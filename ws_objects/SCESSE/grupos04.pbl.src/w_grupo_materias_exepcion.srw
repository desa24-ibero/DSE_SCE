$PBExportHeader$w_grupo_materias_exepcion.srw
forward
global type w_grupo_materias_exepcion from window
end type
type st_1 from statictext within w_grupo_materias_exepcion
end type
type dw_coord from datawindow within w_grupo_materias_exepcion
end type
type cb_carga_archivo from commandbutton within w_grupo_materias_exepcion
end type
type sle_ruta_archivo from u_sle within w_grupo_materias_exepcion
end type
type st_texto_ruta from u_st within w_grupo_materias_exepcion
end type
type cb_1 from commandbutton within w_grupo_materias_exepcion
end type
type cb_guardar from commandbutton within w_grupo_materias_exepcion
end type
type cb_salir from commandbutton within w_grupo_materias_exepcion
end type
type pb_borra_horario from picturebutton within w_grupo_materias_exepcion
end type
type pb_inserta_horario from picturebutton within w_grupo_materias_exepcion
end type
type dw_materias from datawindow within w_grupo_materias_exepcion
end type
end forward

global type w_grupo_materias_exepcion from window
integer width = 4859
integer height = 2456
boolean titlebar = true
string title = "Materias con excepciones de validación."
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_1 st_1
dw_coord dw_coord
cb_carga_archivo cb_carga_archivo
sle_ruta_archivo sle_ruta_archivo
st_texto_ruta st_texto_ruta
cb_1 cb_1
cb_guardar cb_guardar
cb_salir cb_salir
pb_borra_horario pb_borra_horario
pb_inserta_horario pb_inserta_horario
dw_materias dw_materias
end type
global w_grupo_materias_exepcion w_grupo_materias_exepcion

type variables
INTEGER ii_periodo 
INTEGER ii_anio 

end variables

forward prototypes
public function integer wf_recupera_horas (integer al_materia, ref long al_horas, ref long al_horas_totales)
end prototypes

public function integer wf_recupera_horas (integer al_materia, ref long al_horas, ref long al_horas_totales);
INTEGER le_semanas 
INTEGER le_horas

SELECT semanas_semestre 
INTO :le_semanas  
FROM periodo_parametros 
WHERE periodo = :ii_periodo  
USING gtr_sce; 
IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar las semanas del semestre: " + gtr_sce.SQLERRTEXT) 
	RETURN -1 
END IF 	
IF ISNULL(le_semanas) THEN le_semanas = 0 

SELECT horas_reales
iNTO :le_horas
FROM materias
WHERE cve_mat = :al_materia
USING gtr_sce; 
IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar las horas reales de la materia: " + gtr_sce.SQLERRTEXT)  
	RETURN -1 
END IF 	
IF ISNULL(le_semanas) THEN le_semanas = 0 

// Se insertan las Horas Totales. 
al_horas_totales = le_horas * le_semanas 

// Se insertan las Horas Semanales
al_horas = le_horas 




//
//SELECT ISNULL(periodo_parametros.semanas_semestre, 0) * ISNULL(materias.horas_reales, 0) as horas_totales_default, 
//  			ISNULL(materias.horas_reales, 0) AS horas_reales 
//    FROM materias
//   WHERE cve_mat = :al_materia ; 
//
//

RETURN 0 
end function

on w_grupo_materias_exepcion.create
this.st_1=create st_1
this.dw_coord=create dw_coord
this.cb_carga_archivo=create cb_carga_archivo
this.sle_ruta_archivo=create sle_ruta_archivo
this.st_texto_ruta=create st_texto_ruta
this.cb_1=create cb_1
this.cb_guardar=create cb_guardar
this.cb_salir=create cb_salir
this.pb_borra_horario=create pb_borra_horario
this.pb_inserta_horario=create pb_inserta_horario
this.dw_materias=create dw_materias
this.Control[]={this.st_1,&
this.dw_coord,&
this.cb_carga_archivo,&
this.sle_ruta_archivo,&
this.st_texto_ruta,&
this.cb_1,&
this.cb_guardar,&
this.cb_salir,&
this.pb_borra_horario,&
this.pb_inserta_horario,&
this.dw_materias}
end on

on w_grupo_materias_exepcion.destroy
destroy(this.st_1)
destroy(this.dw_coord)
destroy(this.cb_carga_archivo)
destroy(this.sle_ruta_archivo)
destroy(this.st_texto_ruta)
destroy(this.cb_1)
destroy(this.cb_guardar)
destroy(this.cb_salir)
destroy(this.pb_borra_horario)
destroy(this.pb_inserta_horario)
destroy(this.dw_materias)
end on

event open;//// Se recupera el periodo de alta de grupos
// f_obten_periodo(ii_periodo, ii_anio, 4) 
// 
//THIS.uo_periodo.ie_anio = ii_anio 
//THIS.uo_periodo.ie_periodo = ii_periodo   
//THIS.uo_periodo.TRIGGEREVENT("ue_modifica") 
//

INTEGER le_periodo 

SELECT MIN(periodo)  
INTO :le_periodo 
FROM periodo 
WHERE tipo = :gs_tipo_periodo 
USING gtr_sce; 
IF ISNULL(le_periodo) THEN le_periodo = 0


dw_materias.SETTRANSOBJECT(gtr_sce) 
dw_materias.RETRIEVE(le_periodo) 
dw_materias.SetRowFocusIndicator(Hand!)

dw_coord.SETTRANSOBJECT(gtr_sce) 
dw_coord.INSERTROW(0) 

end event

type st_1 from statictext within w_grupo_materias_exepcion
integer x = 219
integer y = 56
integer width = 453
integer height = 64
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Coordinación:"
boolean focusrectangle = false
end type

type dw_coord from datawindow within w_grupo_materias_exepcion
integer x = 722
integer y = 40
integer width = 1998
integer height = 120
integer taborder = 60
string title = "none"
string dataobject = "dw_coord_materias_excep"
boolean border = false
boolean livescroll = true
end type

event itemchanged;
IF data = '9999' THEN 
	dw_materias.SETFILTER("") 
ELSE 
	dw_materias.SETFILTER("materias_cve_coordinacion = " + data) 
END IF 

dw_materias.FILTER() 






end event

type cb_carga_archivo from commandbutton within w_grupo_materias_exepcion
boolean visible = false
integer x = 2030
integer y = 36
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Sel. Archivo"
end type

event clicked;string pathname, filename, ls_nombre_archivo

integer value

value = GetFileOpenName("Seleccione el Archivo", &
		+ pathname, filename, "TXT", &
		+ "Text Files (*.TXT),*.TXT")

IF value = 1 THEN 
	ls_nombre_archivo = pathname
	sle_ruta_archivo.text = ls_nombre_archivo
ELSE
	MessageBox("Sin Archivo","No se ha abierto ningún archivo",Information!)
END IF

//ids_cuentas_archivo.ImportFile(ls_nombre_archivo)  





end event

type sle_ruta_archivo from u_sle within w_grupo_materias_exepcion
boolean visible = false
integer x = 274
integer y = 64
integer width = 1719
integer height = 76
integer taborder = 50
integer textsize = -10
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1073741824
boolean displayonly = true
end type

type st_texto_ruta from u_st within w_grupo_materias_exepcion
boolean visible = false
integer x = 91
integer y = 72
integer width = 146
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1073741824
string text = "Ruta:"
end type

type cb_1 from commandbutton within w_grupo_materias_exepcion
boolean visible = false
integer x = 2533
integer y = 32
integer width = 480
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Importar Archivo"
end type

type cb_guardar from commandbutton within w_grupo_materias_exepcion
integer x = 4206
integer y = 196
integer width = 480
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar"
end type

event clicked;// Se eliminan las materias qu estén en blanco 
LONG ll_pos
dw_materias.ACCEPTTEXT()
DO 
	ll_pos = dw_materias.FIND("ISNULL(grupos_valida_exepcion_cve_mat)", 1, dw_materias.ROWCOUNT())
	IF ll_pos > 0 THEN dw_materias.DELETEROW(ll_pos) 
LOOP WHILE ll_pos > 0 	


IF dw_materias.UPDATE() < 0 THEN 
	MESSAGEBOX("Aviso", "Se produjo un error al guardar las materias.")
	ROLLBACK USING gtr_sce;
ELSE
	MESSAGEBOX("Aviso", "Las materias fueron actualizadas con éxito.")
	COMMIT USING gtr_sce;
END IF 



end event

type cb_salir from commandbutton within w_grupo_materias_exepcion
integer x = 4206
integer y = 388
integer width = 480
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

type pb_borra_horario from picturebutton within w_grupo_materias_exepcion
integer x = 4325
integer y = 48
integer width = 110
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "DeleteRow!"
alignment htextalign = left!
end type

event clicked;INTEGER le_row 

le_row = dw_materias.GETROW()

IF le_row > 0 THEN dw_materias.DELETEROW(le_row) 


end event

type pb_inserta_horario from picturebutton within w_grupo_materias_exepcion
integer x = 4206
integer y = 48
integer width = 110
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Insert5!"
alignment htextalign = left!
end type

event clicked;INTEGER le_row
le_row = dw_materias.INSERTROW(0)
dw_materias.SCROLLTOROW(le_row)

dw_materias.SETITEM(le_row, "grupos_valida_exepcion_doble_presencia", 1) 
dw_materias.SETITEM(le_row, "grupos_valida_exepcion_horas_minimas", 1) 







end event

type dw_materias from datawindow within w_grupo_materias_exepcion
integer x = 78
integer y = 188
integer width = 4078
integer height = 2104
integer taborder = 10
string title = "none"
string dataobject = "dw_grupos_valida_excepcion"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event itemchanged;
STRING ls_materia

IF dwo.name = "grupos_valida_exepcion_cve_mat" THEN  

	LONG ll_materia 

	ll_materia = LONG(data) 

	SELECT materia 
	into :ls_materia
	FROM materias 
	WHERE cve_mat = :ll_materia  
	USING gtr_sce;
	IF gtr_sce.SQLCODE < 0 THEN 
		MESSAGEBOX("Error", "Se produjo un error al recuperar la descripción de la materia.") 
		RETURN 2 
	END IF 	
	
	IF ISNULL(ls_materia) THEN 
		MESSAGEBOX("Error", "La materia ingresada no existe.")  
		RETURN 2 		
	END IF 	
	
	THIS.SETITEM(row, "materias_materia", ls_materia)
	
	LONG le_horas
	LONG le_horas_tot
	
	wf_recupera_horas(LONG(data), le_horas, le_horas_tot) 
	
	THIS.SETITEM(row, "horas_reales", le_horas)
	THIS.SETITEM(row, "horas_totales_default", le_horas_tot)	

ELSEIF dwo.name = "grupos_valida_exepcion_horas_minimas"	 THEN  
	
	INTEGER le_nulo 
	SETNULL(le_nulo) 
		
	IF data = '1' THEN THIS.SETITEM(row, "grupos_valida_exepcion_horas_totales", le_nulo) 
	

	
END IF 






end event

event rowfocuschanged;THIS.SELECTROW(0, FALSE) 
THIS.SELECTROW(currentrow, TRUE) 
end event

