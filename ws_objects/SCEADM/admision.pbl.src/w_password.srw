$PBExportHeader$w_password.srw
$PBExportComments$Ventana de verificación de Password
forward
global type w_password from window
end type
type st_4 from statictext within w_password
end type
type p_3 from picture within w_password
end type
type st_6 from statictext within w_password
end type
type st_8 from statictext within w_password
end type
type st_ver from statictext within w_password
end type
type st_1 from statictext within w_password
end type
type sle_pass from singlelineedit within w_password
end type
type cb_close from commandbutton within w_password
end type
type cb_login from commandbutton within w_password
end type
type sle_password from singlelineedit within w_password
end type
type sle_userid from singlelineedit within w_password
end type
type st_3 from statictext within w_password
end type
type st_2 from statictext within w_password
end type
type r_1 from rectangle within w_password
end type
end forward

global type w_password from window
integer x = 832
integer y = 356
integer width = 3131
integer height = 1900
boolean titlebar = true
string title = "Ventana de acceso (Inscripción de Alumnos)"
windowtype windowtype = response!
long backcolor = 12632256
string icon = "reinscripcion.ico"
boolean center = true
event ue_login pbm_custom60
event ue_close pbm_custom61
st_4 st_4
p_3 p_3
st_6 st_6
st_8 st_8
st_ver st_ver
st_1 st_1
sle_pass sle_pass
cb_close cb_close
cb_login cb_login
sle_password sle_password
sle_userid sle_userid
st_3 st_3
st_2 st_2
r_1 r_1
end type
global w_password w_password

type variables
integer ii_num_intentos = 0
end variables

event ue_login;string	s_password, s_mypassword
gs_usuario = Trim (Lower (sle_userid.text))
gs_password = sle_pass.text	 



if (conecta_bd(gtr_sce,gs_sce,gs_usuario,gs_password) = 1) then
	if conecta_bd(gtr_sadm,gs_sadm,gs_usuario,gs_password)=1 then
		if (f_usuario_valido_aplicacion(GetApplication().appname, gs_usuario, gtr_sce)=1) then
			Open (w_principal)
			Close(this)
		else
			MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la aplicacion", StopSign!)
			desconecta_bd(gtr_sce)	
			desconecta_bd(gtr_sadm)	
			ii_num_intentos = ii_num_intentos +1
		end if
	else
		ii_num_intentos = ii_num_intentos +1		
	end if
else	
	ii_num_intentos = ii_num_intentos +1
end if
if ii_num_intentos >= 3 then
	Close(this)
end if


end event

event ue_close;Close(this)

end event

on w_password.create
this.st_4=create st_4
this.p_3=create p_3
this.st_6=create st_6
this.st_8=create st_8
this.st_ver=create st_ver
this.st_1=create st_1
this.sle_pass=create sle_pass
this.cb_close=create cb_close
this.cb_login=create cb_login
this.sle_password=create sle_password
this.sle_userid=create sle_userid
this.st_3=create st_3
this.st_2=create st_2
this.r_1=create r_1
this.Control[]={this.st_4,&
this.p_3,&
this.st_6,&
this.st_8,&
this.st_ver,&
this.st_1,&
this.sle_pass,&
this.cb_close,&
this.cb_login,&
this.sle_password,&
this.sle_userid,&
this.st_3,&
this.st_2,&
this.r_1}
end on

on w_password.destroy
destroy(this.st_4)
destroy(this.p_3)
destroy(this.st_6)
destroy(this.st_8)
destroy(this.st_ver)
destroy(this.st_1)
destroy(this.sle_pass)
destroy(this.cb_close)
destroy(this.cb_login)
destroy(this.sle_password)
destroy(this.sle_userid)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.r_1)
end on

event open;title=ProfileString (gs_startupfile, gs_datos, "APLICACION","")
end event

type st_4 from statictext within w_password
integer x = 366
integer y = 40
integer width = 2473
integer height = 180
integer textsize = -22
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "UNIVERSIDAD IBEROAMERICANA"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_3 from picture within w_password
integer x = 82
integer y = 548
integer width = 960
integer height = 460
string picturename = "anEscudo-Logo.png"
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_6 from statictext within w_password
integer x = 82
integer y = 1312
integer width = 1486
integer height = 88
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Dirección de Informática y Telecomunicaciones"
boolean focusrectangle = false
end type

type st_8 from statictext within w_password
integer x = 82
integer y = 1424
integer width = 480
integer height = 88
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Primavera 2013"
boolean focusrectangle = false
end type

type st_ver from statictext within w_password
integer x = 110
integer y = 1512
integer width = 480
integer height = 88
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_1 from statictext within w_password
integer x = 1371
integer y = 548
integer width = 1605
integer height = 152
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Sistema de Admisión PB 12.0"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_pass from singlelineedit within w_password
event ue_char pbm_char
event ue_check pbm_custom70
integer x = 2075
integer y = 1200
integer width = 535
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean password = true
integer limit = 20
borderstyle borderstyle = stylelowered!
end type

event ue_char;this.PostEvent ("ue_check")
end event

event ue_check;IF (Len (this.text) > 0) AND (Len (sle_userid.text) > 0) THEN
	cb_login.enabled = TRUE
ELSE
	cb_login.enabled = FALSE
END IF

end event

event getfocus;SelectText (this, 1, Len (this.text))

end event

event modified;IF (Len (this.text) > 0) AND (Len (sle_userid.text) > 0) THEN
	cb_login.enabled = TRUE
ELSE
	cb_login.enabled = FALSE
END IF
end event

type cb_close from commandbutton within w_password
integer x = 2304
integer y = 1488
integer width = 361
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancelar"
boolean cancel = true
end type

on clicked;parent.PostEvent ("ue_close")

end on

type cb_login from commandbutton within w_password
integer x = 1582
integer y = 1488
integer width = 361
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Listo"
boolean default = true
end type

event clicked;parent.PostEvent ("ue_login")
//IF KeyDown (keyControl!) THEN
//	g_show_security = TRUE
//END IF
//
end event

type sle_password from singlelineedit within w_password
event ue_check pbm_custom70
event ue_char pbm_char
integer x = 2080
integer y = 1200
integer width = 535
integer height = 96
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16777215
long backcolor = 8388608
boolean autohscroll = false
boolean password = true
textcase textcase = lower!
borderstyle borderstyle = stylelowered!
end type

on ue_check;IF (Len (this.text) > 0) AND (Len (sle_userid.text) > 0) THEN
	cb_login.enabled = TRUE
ELSE
	cb_login.enabled = FALSE
END IF

end on

on ue_char;this.PostEvent ("ue_check")
end on

on getfocus;SelectText (this, 1, Len (this.text))

end on

type sle_userid from singlelineedit within w_password
event ue_check pbm_custom70
event ue_char pbm_char
integer x = 2075
integer y = 1072
integer width = 535
integer height = 96
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 15793151
boolean autohscroll = false
textcase textcase = lower!
borderstyle borderstyle = stylelowered!
end type

on ue_check;IF (Len (this.text) > 0) AND (Len (sle_password.text) > 0) THEN
	cb_login.enabled = TRUE
ELSE
	cb_login.enabled = FALSE
END IF

end on

on ue_char;this.TriggerEvent ("ue_check")

end on

on modified;if keydown(keyenter!) and (Len (this.text) > 0) then
  sle_pass.setfocus()
end if
end on

on getfocus;SelectText (this, 1, Len (this.text))

end on

event constructor;text=gs_usuario
end event

type st_3 from statictext within w_password
integer x = 1623
integer y = 1204
integer width = 393
integer height = 92
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 12632256
boolean enabled = false
string text = "Contraseña:"
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_2 from statictext within w_password
integer x = 1623
integer y = 1076
integer width = 352
integer height = 92
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 12632256
boolean enabled = false
string text = "Usuario:"
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type r_1 from rectangle within w_password
long linecolor = 16777215
integer linethickness = 3
long fillcolor = 255
integer x = 2994
integer y = 1708
integer width = 87
integer height = 76
end type

