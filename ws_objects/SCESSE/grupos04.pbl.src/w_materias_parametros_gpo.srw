$PBExportHeader$w_materias_parametros_gpo.srw
forward
global type w_materias_parametros_gpo from window
end type
type cb_2 from commandbutton within w_materias_parametros_gpo
end type
type cb_1 from commandbutton within w_materias_parametros_gpo
end type
type dw_lista from datawindow within w_materias_parametros_gpo
end type
type dw_alta from datawindow within w_materias_parametros_gpo
end type
end forward

global type w_materias_parametros_gpo from window
integer width = 4046
integer height = 2048
boolean titlebar = true
string title = "Materias Parametros Grupo"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
dw_lista dw_lista
dw_alta dw_alta
end type
global w_materias_parametros_gpo w_materias_parametros_gpo

on w_materias_parametros_gpo.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_lista=create dw_lista
this.dw_alta=create dw_alta
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_lista,&
this.dw_alta}
end on

on w_materias_parametros_gpo.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_lista)
destroy(this.dw_alta)
end on

event open;dw_alta.INSERTROW(0)

dw_lista.INSERTROW(0)
dw_lista.INSERTROW(0)
dw_lista.INSERTROW(0)
dw_lista.INSERTROW(0)
end event

type cb_2 from commandbutton within w_materias_parametros_gpo
integer x = 2894
integer y = 200
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

type cb_1 from commandbutton within w_materias_parametros_gpo
integer x = 2894
integer y = 68
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

type dw_lista from datawindow within w_materias_parametros_gpo
integer x = 128
integer y = 880
integer width = 3378
integer height = 960
integer taborder = 20
string title = "none"
string dataobject = "dw_materias_parametros_gpo_lista"
boolean border = false
boolean livescroll = true
end type

type dw_alta from datawindow within w_materias_parametros_gpo
integer x = 96
integer y = 76
integer width = 2670
integer height = 724
integer taborder = 10
string title = "none"
string dataobject = "dw_materias_parametros_gpo"
boolean border = false
boolean livescroll = true
end type

