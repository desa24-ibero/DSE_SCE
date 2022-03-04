$PBExportHeader$w_autoriza_profesor_cotitular.srw
forward
global type w_autoriza_profesor_cotitular from window
end type
type dw_estatus from datawindow within w_autoriza_profesor_cotitular
end type
type cb_5 from commandbutton within w_autoriza_profesor_cotitular
end type
type uo_1 from uo_per_ani within w_autoriza_profesor_cotitular
end type
type cb_4 from commandbutton within w_autoriza_profesor_cotitular
end type
type cb_3 from commandbutton within w_autoriza_profesor_cotitular
end type
type cb_2 from commandbutton within w_autoriza_profesor_cotitular
end type
type cb_1 from commandbutton within w_autoriza_profesor_cotitular
end type
type dw_grupos from datawindow within w_autoriza_profesor_cotitular
end type
end forward

global type w_autoriza_profesor_cotitular from window
integer width = 4754
integer height = 1916
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_estatus dw_estatus
cb_5 cb_5
uo_1 uo_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_grupos dw_grupos
end type
global w_autoriza_profesor_cotitular w_autoriza_profesor_cotitular

on w_autoriza_profesor_cotitular.create
this.dw_estatus=create dw_estatus
this.cb_5=create cb_5
this.uo_1=create uo_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_grupos=create dw_grupos
this.Control[]={this.dw_estatus,&
this.cb_5,&
this.uo_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_grupos}
end on

on w_autoriza_profesor_cotitular.destroy
destroy(this.dw_estatus)
destroy(this.cb_5)
destroy(this.uo_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_grupos)
end on

type dw_estatus from datawindow within w_autoriza_profesor_cotitular
integer x = 3483
integer y = 280
integer width = 686
integer height = 116
integer taborder = 40
string title = "none"
boolean border = false
boolean livescroll = true
end type

type cb_5 from commandbutton within w_autoriza_profesor_cotitular
integer x = 4274
integer y = 272
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar"
end type

type uo_1 from uo_per_ani within w_autoriza_profesor_cotitular
integer x = 3429
integer y = 68
integer taborder = 20
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type cb_4 from commandbutton within w_autoriza_profesor_cotitular
integer x = 3680
integer y = 1608
integer width = 87
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

event clicked;INTEGER le_row

le_row = dw_grupos.INSERTROW(0)
dw_grupos.SETITEM(le_row, "tipo_row", 2)




end event

type cb_3 from commandbutton within w_autoriza_profesor_cotitular
integer x = 3557
integer y = 1608
integer width = 87
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

event clicked;INTEGER le_row

le_row = dw_grupos.INSERTROW(0)
dw_grupos.SETITEM(le_row, "tipo_row", 1)




end event

type cb_2 from commandbutton within w_autoriza_profesor_cotitular
integer x = 4274
integer y = 776
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

type cb_1 from commandbutton within w_autoriza_profesor_cotitular
integer x = 4274
integer y = 640
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar"
end type

type dw_grupos from datawindow within w_autoriza_profesor_cotitular
integer x = 50
integer y = 64
integer width = 3319
integer height = 1664
integer taborder = 10
string title = "none"
string dataobject = "dw_autoriza_profesor_cotitular"
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

