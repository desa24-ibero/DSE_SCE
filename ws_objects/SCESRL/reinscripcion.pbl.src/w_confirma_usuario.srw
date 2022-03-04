$PBExportHeader$w_confirma_usuario.srw
forward
global type w_confirma_usuario from window
end type
type em_usuario from editmask within w_confirma_usuario
end type
type st_1 from statictext within w_confirma_usuario
end type
type st_2 from statictext within w_confirma_usuario
end type
type cb_confirmar from commandbutton within w_confirma_usuario
end type
type sle_password from singlelineedit within w_confirma_usuario
end type
end forward

global type w_confirma_usuario from window
integer x = 1019
integer y = 616
integer width = 1179
integer height = 512
boolean titlebar = true
string title = "Confirme Usuario"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
em_usuario em_usuario
st_1 st_1
st_2 st_2
cb_confirmar cb_confirmar
sle_password sle_password
end type
global w_confirma_usuario w_confirma_usuario

type variables
st_confirma_usuario ist_confirma_usuario
boolean ib_cierra_por_boton= false
end variables

on w_confirma_usuario.create
this.em_usuario=create em_usuario
this.st_1=create st_1
this.st_2=create st_2
this.cb_confirmar=create cb_confirmar
this.sle_password=create sle_password
this.Control[]={this.em_usuario,&
this.st_1,&
this.st_2,&
this.cb_confirmar,&
this.sle_password}
end on

on w_confirma_usuario.destroy
destroy(this.em_usuario)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_confirmar)
destroy(this.sle_password)
end on

event closequery;IF ib_cierra_por_boton THEN
	RETURN 0
ELSE
	RETURN 1
END IF


end event

type em_usuario from editmask within w_confirma_usuario
integer x = 434
integer y = 76
integer width = 635
integer height = 88
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

type st_1 from statictext within w_confirma_usuario
integer x = 137
integer y = 76
integer width = 256
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean enabled = false
string text = "Usuario :"
boolean focusrectangle = false
end type

type st_2 from statictext within w_confirma_usuario
integer x = 82
integer y = 184
integer width = 311
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean enabled = false
string text = "Password :"
boolean focusrectangle = false
end type

type cb_confirmar from commandbutton within w_confirma_usuario
integer x = 389
integer y = 320
integer width = 443
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
fontcharset fontcharset = ansi!
string text = "Confirmar"
end type

event clicked;string ls_usuario, ls_password


ls_usuario = em_usuario.text
ls_password = sle_password.text

ist_confirma_usuario.usuario = ls_usuario
ist_confirma_usuario.password = ls_password

ib_cierra_por_boton=true
CloseWithReturn(Parent, ist_confirma_usuario)


end event

type sle_password from singlelineedit within w_confirma_usuario
integer x = 434
integer y = 184
integer width = 635
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean autohscroll = false
boolean password = true
borderstyle borderstyle = stylelowered!
end type

