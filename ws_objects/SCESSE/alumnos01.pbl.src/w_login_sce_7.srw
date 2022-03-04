$PBExportHeader$w_login_sce_7.srw
forward
global type w_login_sce_7 from window
end type
type cb_close from commandbutton within w_login_sce_7
end type
type cb_login from commandbutton within w_login_sce_7
end type
type sle_password from singlelineedit within w_login_sce_7
end type
type sle_userid from singlelineedit within w_login_sce_7
end type
type st_3 from statictext within w_login_sce_7
end type
type st_2 from statictext within w_login_sce_7
end type
type ln_1 from line within w_login_sce_7
end type
end forward

global type w_login_sce_7 from window
integer x = 718
integer y = 736
integer width = 1664
integer height = 668
boolean titlebar = true
windowtype windowtype = response!
long backcolor = 8421376
event ue_login pbm_custom60
event ue_close pbm_custom61
cb_close cb_close
cb_login cb_login
sle_password sle_password
sle_userid sle_userid
st_3 st_3
st_2 st_2
ln_1 ln_1
end type
global w_login_sce_7 w_login_sce_7

event ue_login;string	s_password, s_mypassword
gs_usuario = Trim (Lower (sle_userid.text))
gs_password = sle_password.text	 
if (conecta_bd_n_tr(gtr_sce,gs_sce,gs_usuario,gs_password) = 1) then
	periodo_actual(g_per,g_year,gtr_sce)
	 if (f_usuario_valido_aplicacion(GetApplication().appname, gs_usuario, gtr_sce)=1) then
		Open (w_principal)
	else
		MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la aplicacion", StopSign!)
	end if
end if
Close(this)


end event

event ue_close;Close(this)

end event

on w_login_sce_7.create
this.cb_close=create cb_close
this.cb_login=create cb_login
this.sle_password=create sle_password
this.sle_userid=create sle_userid
this.st_3=create st_3
this.st_2=create st_2
this.ln_1=create ln_1
this.Control[]={this.cb_close,&
this.cb_login,&
this.sle_password,&
this.sle_userid,&
this.st_3,&
this.st_2,&
this.ln_1}
end on

on w_login_sce_7.destroy
destroy(this.cb_close)
destroy(this.cb_login)
destroy(this.sle_password)
destroy(this.sle_userid)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.ln_1)
end on

event open;
//gtr_sce.DBMS       = ProfileString (gs_startupfile, gs_sce, "dbms",       "")
//gtr_sce.database   = ProfileString (gs_startupfile, gs_sce, "database",   "")
//gtr_sce.userid     = ProfileString (gs_startupfile, gs_sce, "userid",     "")
//gtr_sce.dbpass     = ProfileString (gs_startupfile, gs_sce, "dbpass",     "")
//gtr_sce.servername = ProfileString (gs_startupfile, gs_sce, "servername", "")
//gtr_sce.dbparm     = ProfileString (gs_startupfile, gs_sce, "dbparm",     "")
//
title=ProfileString (gs_startupfile, gs_datos, "APLICACION","")+" "+&
		ProfileString (gs_startupfile, gs_servidores, "actual","")
end event

type cb_close from commandbutton within w_login_sce_7
integer x = 896
integer y = 412
integer width = 361
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Close"
boolean cancel = true
end type

on clicked;parent.PostEvent ("ue_close")

end on

type cb_login from commandbutton within w_login_sce_7
integer x = 398
integer y = 412
integer width = 361
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Login"
boolean default = true
end type

event clicked;parent.PostEvent ("ue_login")
IF KeyDown (keyControl!) THEN
//	g_show_security = TRUE
END IF



end event

type sle_password from singlelineedit within w_login_sce_7
event ue_check pbm_custom70
event ue_char pbm_char
integer x = 731
integer y = 204
integer width = 837
integer height = 96
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 15793151
boolean password = true
integer limit = 20
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

type sle_userid from singlelineedit within w_login_sce_7
event ue_check pbm_custom70
event ue_char pbm_char
integer x = 731
integer y = 64
integer width = 837
integer height = 96
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 15793151
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event ue_check;IF (Len (this.text) > 0) AND (Len (sle_password.text) > 0) THEN
	cb_login.enabled = TRUE
ELSE
	cb_login.enabled = FALSE
END IF

end event

on ue_char;this.TriggerEvent ("ue_check")

end on

on getfocus;SelectText (this, 1, Len (this.text))

end on

event constructor;text=gs_usuario
end event

type st_3 from statictext within w_login_sce_7
integer x = 279
integer y = 208
integer width = 393
integer height = 92
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 8421376
boolean enabled = false
string text = "Password:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_login_sce_7
integer x = 325
integer y = 80
integer width = 352
integer height = 92
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 8421376
boolean enabled = false
string text = "User ID:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ln_1 from line within w_login_sce_7
integer linethickness = 4
integer beginx = 137
integer beginy = 356
integer endx = 1527
integer endy = 356
end type

