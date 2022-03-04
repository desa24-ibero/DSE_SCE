$PBExportHeader$w_parametros_admision.srw
forward
global type w_parametros_admision from window
end type
type cb_4 from commandbutton within w_parametros_admision
end type
type dw_parametros from datawindow within w_parametros_admision
end type
type cb_3 from commandbutton within w_parametros_admision
end type
type cb_2 from commandbutton within w_parametros_admision
end type
type cb_1 from commandbutton within w_parametros_admision
end type
end forward

global type w_parametros_admision from window
integer width = 3959
integer height = 864
boolean titlebar = true
string title = "Parámetros de Admisión"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
cb_4 cb_4
dw_parametros dw_parametros
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_parametros_admision w_parametros_admision

on w_parametros_admision.create
this.cb_4=create cb_4
this.dw_parametros=create dw_parametros
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.cb_4,&
this.dw_parametros,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_parametros_admision.destroy
destroy(this.cb_4)
destroy(this.dw_parametros)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;x=1
y=1
dw_parametros.settransobject(gtr_sadm)
dw_parametros.retrieve()

end event

type cb_4 from commandbutton within w_parametros_admision
integer x = 2473
integer y = 536
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Salir"
end type

event clicked;close(parent)
end event

type dw_parametros from datawindow within w_parametros_admision
integer x = 32
integer y = 40
integer width = 3831
integer height = 420
integer taborder = 10
string title = "none"
string dataobject = "d_parametros_admision"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_parametros_admision
integer x = 1934
integer y = 536
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Actualizar"
end type

event clicked;if dw_parametros.update()=1 then
	commit using gtr_sadm;
	messagebox("Mensaje del Sistema","Los datos se han actualizado exitosamente",information!)
else
	rollback using gtr_sadm;
	messagebox("Mensaje del Sistema","Ha ocurrido un error al actualizar los datos",stopsign!)
end if
end event

type cb_2 from commandbutton within w_parametros_admision
integer x = 1394
integer y = 536
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Eliminar"
end type

event clicked;dw_parametros.deleterow(dw_parametros.getrow())
end event

type cb_1 from commandbutton within w_parametros_admision
integer x = 855
integer y = 536
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Nuevo"
end type

event clicked;dw_parametros.scrolltorow(dw_parametros.insertrow(0))
end event

