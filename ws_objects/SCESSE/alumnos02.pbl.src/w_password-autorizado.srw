$PBExportHeader$w_password-autorizado.srw
$PBExportComments$Ventana que solicita un password autorizado para realizar un proceso Regresa 26 si el password esta correcto y 12 si el password no se conoce o se cancela la operación Marzo 1998 CAMP DkWf
forward
global type w_password-autorizado from window
end type
type st_chance from statictext within w_password-autorizado
end type
type st_user from statictext within w_password-autorizado
end type
type sle_user from singlelineedit within w_password-autorizado
end type
type cb_cancel from commandbutton within w_password-autorizado
end type
type cb_ok from commandbutton within w_password-autorizado
end type
type sle_password from singlelineedit within w_password-autorizado
end type
type st_1 from statictext within w_password-autorizado
end type
end forward

global type w_password-autorizado from window
integer x = 832
integer y = 364
integer width = 1335
integer height = 540
boolean titlebar = true
string title = "Verificación del Password"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 15793151
st_chance st_chance
st_user st_user
sle_user sle_user
cb_cancel cb_cancel
cb_ok cb_ok
sle_password sle_password
st_1 st_1
end type
global w_password-autorizado w_password-autorizado

type variables
string oldpass, user
int cont 
end variables

on w_password-autorizado.create
this.st_chance=create st_chance
this.st_user=create st_user
this.sle_user=create sle_user
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.sle_password=create sle_password
this.st_1=create st_1
this.Control[]={this.st_chance,&
this.st_user,&
this.sle_user,&
this.cb_cancel,&
this.cb_ok,&
this.sle_password,&
this.st_1}
end on

on w_password-autorizado.destroy
destroy(this.st_chance)
destroy(this.st_user)
destroy(this.sle_user)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.sle_password)
destroy(this.st_1)
end on

type st_chance from statictext within w_password-autorizado
integer x = 59
integer y = 320
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Narrow"
long backcolor = 255
boolean enabled = false
string text = "3"
alignment alignment = center!
long bordercolor = 15793151
boolean focusrectangle = false
end type

type st_user from statictext within w_password-autorizado
integer x = 59
integer y = 80
integer width = 562
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Narrow"
long backcolor = 255
boolean enabled = false
string text = "User Id."
alignment alignment = right!
long bordercolor = 15793151
boolean focusrectangle = false
end type

type sle_user from singlelineedit within w_password-autorizado
event modified pbm_enmodified
integer x = 658
integer y = 68
integer width = 617
integer height = 84
integer taborder = 1
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Narrow"
long textcolor = 8388608
boolean autohscroll = false
boolean password = true
textcase textcase = lower!
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

event modified;user=sle_user.text

SELECT permisos_esp.uid  
	 INTO :user  
 FROM permisos_esp  
WHERE permisos_esp.uid = :user   using gtr_sce;

If gtr_sce.sqlcode	=	0	then
	st_1.visible	= true
	sle_password.visible = true
	sle_password.setfocus()
	st_chance.text = string(3)
	cont = 0
else
	messagebox("User Id NO AUTORIZADO",user+" NO esta AUTORIZADO para efectuar estos cambios",stopsign!,ok!)
	sle_user.setfocus()
	sle_user.selecttext(1,Len(sle_user.text))
	st_1.visible	= false
	sle_password.visible = false
	if cont	>=3 then
		cb_cancel.triggerevent(clicked!)
	else
		cont++
		st_chance.text = string(integer(st_chance.text) -1)
	end if
end if

end event

type cb_cancel from commandbutton within w_password-autorizado
integer x = 654
integer y = 320
integer width = 247
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Narrow"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,12)
end event

type cb_ok from commandbutton within w_password-autorizado
boolean visible = false
integer x = 1024
integer y = 320
integer width = 247
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Narrow"
string text = "Ok"
end type

event clicked;closewithreturn(parent,26)
end event

type sle_password from singlelineedit within w_password-autorizado
event modified pbm_enmodified
boolean visible = false
integer x = 654
integer y = 172
integer width = 617
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Narrow"
long textcolor = 8388608
boolean autohscroll = false
boolean password = true
textcase textcase = lower!
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

event modified;string old_pass,userid,conf_old_pass

//userid=mid(usuario,2)
userid=gs_usuario
old_pass=sle_password.text
//oldpass = sle_password.text
//consulta_sie(old_pass)  
//	SELECT pc_user_def.password  
//    INTO :conf_old_pass  
//    FROM pc_user_def  
//   WHERE pc_user_def.user_id = :user    using gtr_sce;

if old_pass=gs_password and userid = gs_usuario then //si el passwod es correcto
	 cb_ok.triggerevent(clicked!)
else
	if userid<>gs_usuario then	
		messagebox("Error","Password Incorrecto",stopsign!,ok!)
	else
		messagebox("Usuario Inconsistente",&
		"Es necesario que el usuario escrito sea el mismo firmado en el sistema",stopsign!,ok!)		
	end if
   sle_password.setfocus()
	sle_password.selecttext(1,Len(sle_password.text))
	cb_ok.visible	=	false
	if cont	>=3 then
		cb_cancel.triggerevent(clicked!)
	else
		cont++		
		st_chance.text = string(integer(st_chance.text) -1)
	end if
end if

end event

type st_1 from statictext within w_password-autorizado
boolean visible = false
integer x = 59
integer y = 188
integer width = 562
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Narrow"
long backcolor = 255
boolean enabled = false
string text = "Password Autorizado"
alignment alignment = right!
long bordercolor = 15793151
boolean focusrectangle = false
end type

