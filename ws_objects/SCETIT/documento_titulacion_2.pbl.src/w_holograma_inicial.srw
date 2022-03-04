$PBExportHeader$w_holograma_inicial.srw
forward
global type w_holograma_inicial from w_response
end type
type cb_1 from u_cb within w_holograma_inicial
end type
type st_1 from statictext within w_holograma_inicial
end type
type em_1 from editmask within w_holograma_inicial
end type
end forward

global type w_holograma_inicial from w_response
integer x = 214
integer width = 1042
integer height = 451
string title = "Favor de escribir el Holograma Inicial"
cb_1 cb_1
st_1 st_1
em_1 em_1
end type
global w_holograma_inicial w_holograma_inicial

on w_holograma_inicial.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.st_1=create st_1
this.em_1=create em_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.em_1
end on

on w_holograma_inicial.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.em_1)
end on

type cb_1 from u_cb within w_holograma_inicial
integer x = 315
integer y = 224
integer width = 351
integer height = 93
integer taborder = 20
string text = "Aceptar"
end type

event clicked;call super::clicked;string ls_holograma_inicial
long ll_holograma_inicial
integer li_cve_doc_control_sep = 4
ls_holograma_inicial=  em_1.text

if not isnumber (ls_holograma_inicial) then
	MessageBox("Holograma inválido","Favor de escribir un holograma válido", StopSign!)
	return
else 
	ll_holograma_inicial = long(ls_holograma_inicial)
	if ll_holograma_inicial<= 0 then
		MessageBox("Holograma negativo","Favor de escribir un holograma mayor a cero", StopSign!)
		return
	elseif of_hologramas_asignados(ll_holograma_inicial, ll_holograma_inicial, li_cve_doc_control_sep)> 0 then
		MessageBox("Holograma asignado","Favor de escribir un holograma sin asignar", StopSign!)
		return
	end if	
end if

CloseWithReturn ( parent, ll_holograma_inicial )




end event

type st_1 from statictext within w_holograma_inicial
integer x = 33
integer y = 80
integer width = 475
integer height = 61
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Holograma Inicial"
boolean focusrectangle = false
end type

type em_1 from editmask within w_holograma_inicial
integer x = 556
integer y = 61
integer width = 413
integer height = 96
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "#######"
end type

