$PBExportHeader$w_cat_carreras_dgp.srw
forward
global type w_cat_carreras_dgp from window
end type
type rb_nombre from radiobutton within w_cat_carreras_dgp
end type
type rb_clave from radiobutton within w_cat_carreras_dgp
end type
type cb_salir from commandbutton within w_cat_carreras_dgp
end type
type cb_guardar from commandbutton within w_cat_carreras_dgp
end type
type cb_eliminar from commandbutton within w_cat_carreras_dgp
end type
type cb_agregar from commandbutton within w_cat_carreras_dgp
end type
type dw_carreras_dgp from datawindow within w_cat_carreras_dgp
end type
type gb_1 from groupbox within w_cat_carreras_dgp
end type
type gb_2 from groupbox within w_cat_carreras_dgp
end type
end forward

global type w_cat_carreras_dgp from window
integer width = 4631
integer height = 2904
boolean titlebar = true
string title = "Carreras DGP "
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
rb_nombre rb_nombre
rb_clave rb_clave
cb_salir cb_salir
cb_guardar cb_guardar
cb_eliminar cb_eliminar
cb_agregar cb_agregar
dw_carreras_dgp dw_carreras_dgp
gb_1 gb_1
gb_2 gb_2
end type
global w_cat_carreras_dgp w_cat_carreras_dgp

type variables
BOOLEAN ib_nuevo 
end variables

forward prototypes
public function integer wf_carga ()
public function integer wf_ordena ()
end prototypes

public function integer wf_carga ();dw_carreras_dgp.SETTRANSOBJECT(gtr_sce) 
dw_carreras_dgp.RETRIEVE() 

RETURN 0 
end function

public function integer wf_ordena ();
IF rb_clave.CHECKED THEN 
	dw_carreras_dgp.SETSORT("cvecarreradgp ASC")
ELSEIF rb_nombre.CHECKED THEN 
	dw_carreras_dgp.SETSORT("carrera ASC")
END IF 

dw_carreras_dgp.SORT()
 
RETURN 0 

 


end function

on w_cat_carreras_dgp.create
this.rb_nombre=create rb_nombre
this.rb_clave=create rb_clave
this.cb_salir=create cb_salir
this.cb_guardar=create cb_guardar
this.cb_eliminar=create cb_eliminar
this.cb_agregar=create cb_agregar
this.dw_carreras_dgp=create dw_carreras_dgp
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.rb_nombre,&
this.rb_clave,&
this.cb_salir,&
this.cb_guardar,&
this.cb_eliminar,&
this.cb_agregar,&
this.dw_carreras_dgp,&
this.gb_1,&
this.gb_2}
end on

on w_cat_carreras_dgp.destroy
destroy(this.rb_nombre)
destroy(this.rb_clave)
destroy(this.cb_salir)
destroy(this.cb_guardar)
destroy(this.cb_eliminar)
destroy(this.cb_agregar)
destroy(this.dw_carreras_dgp)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;wf_carga() 
dw_carreras_dgp.SETROWFOCUSINDICATOR(Hand!)  

wf_ordena()




end event

type rb_nombre from radiobutton within w_cat_carreras_dgp
integer x = 4078
integer y = 284
integer width = 402
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nombre DGP"
end type

event clicked;wf_ordena()
end event

type rb_clave from radiobutton within w_cat_carreras_dgp
integer x = 4078
integer y = 196
integer width = 402
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Clave DGP"
boolean checked = true
end type

event clicked;wf_ordena()
end event

type cb_salir from commandbutton within w_cat_carreras_dgp
integer x = 4078
integer y = 948
integer width = 402
integer height = 112
integer taborder = 50
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

type cb_guardar from commandbutton within w_cat_carreras_dgp
integer x = 4078
integer y = 716
integer width = 402
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

event clicked;
dw_carreras_dgp.SETTRANSOBJECT(gtr_sce) 
IF dw_carreras_dgp.UPDATE()  < 0 THEN 
	ROLLBACK USING gtr_sce; 
END IF 	

COMMIT USING gtr_sce; 

ib_nuevo = FALSE 

MESSAGEBOX("Aviso", "Los cambios fueron guardados con éxito.") 






end event

type cb_eliminar from commandbutton within w_cat_carreras_dgp
integer x = 4078
integer y = 584
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Eliminar"
end type

event clicked;LONG ll_row

ll_row = dw_carreras_dgp.GETROW() 

dw_carreras_dgp.SELECTROW(0, FALSE) 
dw_carreras_dgp.SELECTROW(ll_row, TRUE) 

IF MESSAGEBOX("Confirmación", "¿Desea eliminar el registro de carrera DGP seleccionado?", QUESTION!, YesNoCancel!) > 1 THEN 
	dw_carreras_dgp.SELECTROW(0, FALSE) 
	RETURN 0 
END IF  

dw_carreras_dgp.DELETEROW(ll_row) 
IF dw_carreras_dgp.UPDATE() < 0 THEN 
	ROLLBACK USING gtr_sce; 
END IF 

COMMIT USING gtr_sce; 

MESSAGEBOX("Aviso", "El registro fue eliminado con éxito.")  

RETURN 0 






end event

type cb_agregar from commandbutton within w_cat_carreras_dgp
integer x = 4078
integer y = 460
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Agregar"
end type

event clicked;
IF ib_nuevo THEN 
	MESSAGEBOX("Aviso", "Debe guardar el registro recién agregado antes de insertar otro. ")
	RETURN 0
END IF 	

LONG ll_row

ll_row = dw_carreras_dgp.INSERTROW(0) 
dw_carreras_dgp.SCROLLTOROW(ll_row) 
dw_carreras_dgp.SETROW(ll_row) 

ib_nuevo = TRUE 




end event

type dw_carreras_dgp from datawindow within w_cat_carreras_dgp
integer x = 169
integer y = 148
integer width = 3707
integer height = 2488
integer taborder = 10
string title = "none"
string dataobject = "dw_carreras_dgp_mant"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;//SELECTROW(0,FALSE)
//SELECTROW(currentrow,TRUE) 
end event

type gb_1 from groupbox within w_cat_carreras_dgp
integer x = 119
integer y = 68
integer width = 3826
integer height = 2672
integer taborder = 10
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Carreras DGP: "
end type

type gb_2 from groupbox within w_cat_carreras_dgp
integer x = 4018
integer y = 104
integer width = 521
integer height = 288
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ordenar por:"
end type

