$PBExportHeader$w_textos_cartas.srw
forward
global type w_textos_cartas from window
end type
type cb_4 from commandbutton within w_textos_cartas
end type
type dw_cartas from datawindow within w_textos_cartas
end type
type cb_3 from commandbutton within w_textos_cartas
end type
type cb_2 from commandbutton within w_textos_cartas
end type
type cb_1 from commandbutton within w_textos_cartas
end type
end forward

global type w_textos_cartas from window
integer width = 2912
integer height = 2088
boolean titlebar = true
string title = "Texto de Estatus en Internet"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
cb_4 cb_4
dw_cartas dw_cartas
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_textos_cartas w_textos_cartas

on w_textos_cartas.create
this.cb_4=create cb_4
this.dw_cartas=create dw_cartas
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.cb_4,&
this.dw_cartas,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_textos_cartas.destroy
destroy(this.cb_4)
destroy(this.dw_cartas)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;x=1
y=1
dw_cartas.settransobject(gtr_sadm)
dw_cartas.retrieve()

end event

type cb_4 from commandbutton within w_textos_cartas
integer x = 1920
integer y = 1824
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

type dw_cartas from datawindow within w_textos_cartas
integer x = 32
integer y = 40
integer width = 2729
integer height = 1716
integer taborder = 10
string title = "none"
string dataobject = "d_textos_cartas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_textos_cartas
integer x = 1381
integer y = 1824
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

event clicked;if dw_cartas.update()=1 then
	commit using gtr_sadm;
	messagebox("Mensaje del Sistema","Los datos se han actualizado exitosamente",information!)
else
	rollback using gtr_sadm;
	messagebox("Mensaje del Sistema","Ha ocurrido un error al actualizar los datos",stopsign!)
end if
end event

type cb_2 from commandbutton within w_textos_cartas
integer x = 841
integer y = 1824
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

event clicked;dw_cartas.deleterow(dw_cartas.getrow())
end event

type cb_1 from commandbutton within w_textos_cartas
integer x = 302
integer y = 1824
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

event clicked;dw_cartas.scrolltorow(dw_cartas.insertrow(0))
end event

