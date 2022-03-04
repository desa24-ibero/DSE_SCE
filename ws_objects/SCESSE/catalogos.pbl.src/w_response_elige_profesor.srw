$PBExportHeader$w_response_elige_profesor.srw
forward
global type w_response_elige_profesor from w_response
end type
type cb_2 from commandbutton within w_response_elige_profesor
end type
type cb_1 from commandbutton within w_response_elige_profesor
end type
type uo_1 from uo_nombre_profesor within w_response_elige_profesor
end type
end forward

global type w_response_elige_profesor from w_response
integer width = 2849
integer height = 496
string title = "Seleccione el Profesor"
cb_2 cb_2
cb_1 cb_1
uo_1 uo_1
end type
global w_response_elige_profesor w_response_elige_profesor

type variables
long il_cve_profesor = 0
end variables

on w_response_elige_profesor.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.uo_1
end on

on w_response_elige_profesor.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.uo_1)
end on

event open;call super::open;il_cve_profesor = Message.DoubleParm
end event

type cb_2 from commandbutton within w_response_elige_profesor
integer x = 995
integer y = 282
integer width = 336
integer height = 96
integer taborder = 40
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

type cb_1 from commandbutton within w_response_elige_profesor
integer x = 1507
integer y = 282
integer width = 336
integer height = 96
integer taborder = 30
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

type uo_1 from uo_nombre_profesor within w_response_elige_profesor
integer x = 26
integer y = 42
integer width = 2768
integer height = 182
integer taborder = 30
boolean enabled = true
end type

on uo_1.destroy
call uo_nombre_profesor::destroy
end on

