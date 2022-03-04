$PBExportHeader$w_notas_consulta_resultados.srw
forward
global type w_notas_consulta_resultados from window
end type
type em_num_nota from editmask within w_notas_consulta_resultados
end type
type st_1 from statictext within w_notas_consulta_resultados
end type
type cb_borrar from commandbutton within w_notas_consulta_resultados
end type
type cb_salir from commandbutton within w_notas_consulta_resultados
end type
type cb_guardar from commandbutton within w_notas_consulta_resultados
end type
type cb_nueva from commandbutton within w_notas_consulta_resultados
end type
type dw_notas from datawindow within w_notas_consulta_resultados
end type
end forward

global type w_notas_consulta_resultados from window
integer width = 4805
integer height = 1812
boolean titlebar = true
string title = "Notas para Consulta de Resultados de Admisión"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
em_num_nota em_num_nota
st_1 st_1
cb_borrar cb_borrar
cb_salir cb_salir
cb_guardar cb_guardar
cb_nueva cb_nueva
dw_notas dw_notas
end type
global w_notas_consulta_resultados w_notas_consulta_resultados

forward prototypes
public function integer wf_guarda_nota ()
public function integer wf_carga_nota ()
public function integer wf_inserta_nota (integer ai_modo)
end prototypes

public function integer wf_guarda_nota ();LONG ll_num_nota
LONG ll_notas_existen

dw_notas.ACCEPTTEXT() 

ll_num_nota = LONG(em_num_nota.TEXT) 

IF ISNULL(ll_num_nota)  THEN 
	MESSAGEBOX("Error", "Debe especificar el número de la nota que inserta") 
	RETURN 0 
END IF 

// Se verifica que no haya una nota con ese número
SELECT COUNT(*) 
INTO :ll_notas_existen 
FROM resultado_examen_notas_2017
WHERE id_nota = :ll_num_nota 
USING gtr_sadm; 

IF ll_notas_existen > 0  THEN 
	IF MESSAGEBOX("Error", "Ya existe una nota con ese número. La nota será actualizada. ¿Desea Continuar?", Question!, YesNo!) > 1 THEN RETURN 0 
END IF 


LONG ll_pos
STRING ls_texto

// Se asigna el ID de la nota.
FOR ll_pos = 1 TO dw_notas.ROWCOUNT() 
	
	dw_notas.SETITEM(ll_pos, "id_nota", ll_num_nota) 
	
	ls_texto = dw_notas.GETITEMSTRING(ll_pos, "texto") 
	IF ISNULL(ls_texto) THEN 
		dw_notas.SETITEM(ll_pos, "texto", "") 
	END IF
	
NEXT 

dw_notas.SETTRANSOBJECT(gtr_sadm) 
IF dw_notas.UPDATE() < 0 THEN 
	ROLLBACK USING gtr_sadm; 
	MESSAGEBOX("Error", "Se produjo un error al guardar las notas.") 
	RETURN 0
END IF

COMMIT USING gtr_sadm; 

MESSAGEBOX("Aviso", "La nota fue guardada con éxito")  

RETURN 1









end function

public function integer wf_carga_nota ();LONG ll_num_nota
LONG ll_notas_existen

ll_num_nota = LONG(em_num_nota.TEXT) 

dw_notas.SETTRANSOBJECT(gtr_sadm) 
dw_notas.RETRIEVE(ll_num_nota) 

em_num_nota.ENABLED = FALSE


RETURN 0 


end function

public function integer wf_inserta_nota (integer ai_modo);INTEGER le_pos
LONG ll_num_nota

IF ai_modo = 1  THEN 
	
	ll_num_nota = LONG(em_num_nota.TEXT) 
	
	dw_notas.INSERTROW(0)
	
	FOR le_pos = 1 TO dw_notas.ROWCOUNT() 
	    dw_notas.SETITEM(le_pos, "orden", le_pos)
	    dw_notas.SETITEM(le_pos, "id_nota", ll_num_nota)
	NEXT
	
END IF

IF ai_modo = 2  THEN 
	
	IF MESSAGEBOX("Confirmación", "El renglón actual será eliminado. ¿Desea Continuar?", Question!, YesNoCancel! ) <> 1 THEN RETURN 0
	dw_notas.DELETEROW(dw_notas.GETROW())
	
	FOR le_pos = 1 TO dw_notas.ROWCOUNT() 
		dw_notas.SETITEM(le_pos, "orden", le_pos)
	NEXT
	
END IF


end function

on w_notas_consulta_resultados.create
this.em_num_nota=create em_num_nota
this.st_1=create st_1
this.cb_borrar=create cb_borrar
this.cb_salir=create cb_salir
this.cb_guardar=create cb_guardar
this.cb_nueva=create cb_nueva
this.dw_notas=create dw_notas
this.Control[]={this.em_num_nota,&
this.st_1,&
this.cb_borrar,&
this.cb_salir,&
this.cb_guardar,&
this.cb_nueva,&
this.dw_notas}
end on

on w_notas_consulta_resultados.destroy
destroy(this.em_num_nota)
destroy(this.st_1)
destroy(this.cb_borrar)
destroy(this.cb_salir)
destroy(this.cb_guardar)
destroy(this.cb_nueva)
destroy(this.dw_notas)
end on

type em_num_nota from editmask within w_notas_consulta_resultados
integer x = 731
integer y = 120
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

event modified;LONG ll_notas_existen
LONG ll_num_nota

ll_num_nota = LONG(TEXT)

// Se verifica que no haya una nota con ese número
SELECT COUNT(*) 
INTO :ll_notas_existen 
FROM resultado_examen_notas_2017
WHERE id_nota = :ll_num_nota 
USING gtr_sadm; 

IF ll_notas_existen > 0  THEN 
	wf_carga_nota()
ELSE
	dw_notas.RESET()
	wf_inserta_nota(1)
END IF 


end event

type st_1 from statictext within w_notas_consulta_resultados
integer x = 91
integer y = 132
integer width = 599
integer height = 64
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Número de Nota: "
boolean focusrectangle = false
end type

type cb_borrar from commandbutton within w_notas_consulta_resultados
integer x = 4297
integer y = 256
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Borrar Nota"
end type

event clicked;
LONG ll_num_nota 

ll_num_nota = LONG(em_num_nota.TEXT) 

IF MESSAGEBOX("Confirmación", "La nota " + STRING(ll_num_nota) + " será eliminada. ¿Desea Continuar?", Question!, YesNoCancel! ) <> 1 THEN RETURN 0

DELETE FROM resultado_examen_notas_2017 
WHERE id_nota = :ll_num_nota 
USING gtr_sadm;
IF gtr_sadm.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al eliminar la nota: " + gtr_sadm.SQLERRTEXT)	
	RETURN -1
END IF

RETURN 0 



end event

type cb_salir from commandbutton within w_notas_consulta_resultados
integer x = 4297
integer y = 544
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;CLOSE(PARENT) 
end event

type cb_guardar from commandbutton within w_notas_consulta_resultados
string tag = "Salir"
integer x = 4297
integer y = 400
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar"
end type

event clicked;
wf_guarda_nota() 



end event

type cb_nueva from commandbutton within w_notas_consulta_resultados
integer x = 4297
integer y = 112
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Nueva Nota"
end type

event clicked;
em_num_nota.TEXT = ""
dw_notas.RESET()
wf_inserta_nota(1)

em_num_nota.ENABLED = TRUE
end event

type dw_notas from datawindow within w_notas_consulta_resultados
integer x = 82
integer y = 316
integer width = 4123
integer height = 1184
integer taborder = 10
string title = "Notas para consulta de resultados. "
string dataobject = "dw_resultados_examen_notas"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;INTEGER le_pos
LONG ll_num_nota

IF dwo.name = "b_agrega"  THEN 
	
	ll_num_nota = LONG(em_num_nota.TEXT) 
	
	THIS.INSERTROW(0)
	
	FOR le_pos = 1 TO THIS.ROWCOUNT() 
		THIS.SETITEM(le_pos, "orden", le_pos)
	    THIS.SETITEM(le_pos, "id_nota", ll_num_nota)
	NEXT
	
END IF

IF dwo.name = "b_elimina"  THEN 
	
	IF MESSAGEBOX("Confirmación", "El renglón actual será eliminado. ¿Desea Continuar?", Question!, YesNoCancel! ) <> 1 THEN RETURN 0
	THIS.DELETEROW(row)
	
	FOR le_pos = 1 TO THIS.ROWCOUNT() 
		THIS.SETITEM(le_pos, "orden", le_pos)
	NEXT
	
END IF


end event

