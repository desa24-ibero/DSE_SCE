$PBExportHeader$w_elige_profesor.srw
forward
global type w_elige_profesor from window
end type
type uo_1 from uo_nombre_profesor within w_elige_profesor
end type
type cb_1 from commandbutton within w_elige_profesor
end type
type cb_2 from commandbutton within w_elige_profesor
end type
end forward

global type w_elige_profesor from window
integer width = 2867
integer height = 486
boolean titlebar = true
string title = "Elija el Profesor"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
uo_1 uo_1
cb_1 cb_1
cb_2 cb_2
end type
global w_elige_profesor w_elige_profesor

type variables
long il_cve_profesor=0
end variables

on w_elige_profesor.create
this.uo_1=create uo_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.Control[]={this.uo_1,&
this.cb_1,&
this.cb_2}
end on

on w_elige_profesor.destroy
destroy(this.uo_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;il_cve_profesor = Message.DoubleParm
end event

type uo_1 from uo_nombre_profesor within w_elige_profesor
integer x = 26
integer y = 42
integer width = 2768
integer height = 182
integer taborder = 20
boolean enabled = true
end type

on uo_1.destroy
call uo_nombre_profesor::destroy
end on

type cb_1 from commandbutton within w_elige_profesor
integer x = 1507
integer y = 282
integer width = 336
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;CloseWithReturn(Parent, 0)

end event

type cb_2 from commandbutton within w_elige_profesor
integer x = 995
integer y = 282
integer width = 336
integer height = 96
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
end type

event clicked;il_cve_profesor = uo_1.il_cve_profesor
CloseWithReturn(Parent, il_cve_profesor)
end event

