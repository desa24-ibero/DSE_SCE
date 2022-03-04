$PBExportHeader$w_login_srl_7.srw
forward
global type w_login_srl_7 from window
end type
type p_uia from picture within w_login_srl_7
end type
type st_4 from statictext within w_login_srl_7
end type
type sle_pass from singlelineedit within w_login_srl_7
end type
type cb_close from commandbutton within w_login_srl_7
end type
type cb_login from commandbutton within w_login_srl_7
end type
type sle_password from singlelineedit within w_login_srl_7
end type
type sle_userid from singlelineedit within w_login_srl_7
end type
type st_3 from statictext within w_login_srl_7
end type
type st_2 from statictext within w_login_srl_7
end type
type st_1 from statictext within w_login_srl_7
end type
type ln_1 from line within w_login_srl_7
end type
type r_1 from rectangle within w_login_srl_7
end type
end forward

global type w_login_srl_7 from window
integer x = 832
integer y = 356
integer width = 1573
integer height = 1012
windowtype windowtype = response!
long backcolor = 0
string icon = "reinscripcion.ico"
event ue_login pbm_custom60
event ue_close pbm_custom61
p_uia p_uia
st_4 st_4
sle_pass sle_pass
cb_close cb_close
cb_login cb_login
sle_password sle_password
sle_userid sle_userid
st_3 st_3
st_2 st_2
st_1 st_1
ln_1 ln_1
r_1 r_1
end type
global w_login_srl_7 w_login_srl_7

event ue_login;string	s_password
string	s_userid

s_userid = Trim (Lower (sle_userid.text))

/* Populate sqlca from current PB.INI settings */
sqlca.DBMS       = ProfileString (gs_startupfile, gs_sce, "dbms",       "")
sqlca.database   = ProfileString (gs_startupfile, gs_sce, "database",   "")
sqlca.logid      = s_userid
//sqlcaini(sqlca.logid)
sqlca.logpass    = sle_pass.text
//sqlcaini(sqlca.logpass)
sqlca.servername = ProfileString (gs_startupfile, gs_sce, "servername", "")
sqlca.dbparm     = ProfileString (gs_startupfile, gs_sce, "dbparm",     "")

/* Uncomment the following for actual DB connection */
connect;
//
if sqlca.sqlcode <> 0 then
	MessageBox ("Error de Comunicación", sqlca.sqlerrtext, None!)
	return
end if

//  SELECT	pc_user_def.password
//    INTO	:s_password
//    FROM	pc_user_def
//   WHERE	pc_user_def.user_id = :s_userid
//   USING	SQLCA
//;

//IF SQLCA.SQLCode = 100 THEN
//	MessageBox ("Error de Comunicación", "No se encontró el UserID.", None!)
//	sle_userid.SetFocus ()
//	RETURN
//END IF
//
//IF SQLCA.SQLCode < 0 THEN
//	MessageBox ("Error de Comunicación", "No se verificó UserID y Password.", None!)
//	RETURN
//END IF
//
//// Make sure to release any locks...
//COMMIT USING SQLCA;

//IF Trim (Lower (s_password)) = Trim (Lower (sle_password.text)) THEN
	CloseWithReturn (this, s_userid)
//ELSE
//	MessageBox ("Error de Comunicación", "El password para : '" + s_userid + "' no coincide", None!)
//	sle_password.SetFocus ()
//END IF

end event

on ue_close;
CloseWithReturn (this, "")

end on

on w_login_srl_7.create
this.p_uia=create p_uia
this.st_4=create st_4
this.sle_pass=create sle_pass
this.cb_close=create cb_close
this.cb_login=create cb_login
this.sle_password=create sle_password
this.sle_userid=create sle_userid
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.ln_1=create ln_1
this.r_1=create r_1
this.Control[]={this.p_uia,&
this.st_4,&
this.sle_pass,&
this.cb_close,&
this.cb_login,&
this.sle_password,&
this.sle_userid,&
this.st_3,&
this.st_2,&
this.st_1,&
this.ln_1,&
this.r_1}
end on

on w_login_srl_7.destroy
destroy(this.p_uia)
destroy(this.st_4)
destroy(this.sle_pass)
destroy(this.cb_close)
destroy(this.cb_login)
destroy(this.sle_password)
destroy(this.sle_userid)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ln_1)
destroy(this.r_1)
end on

type p_uia from picture within w_login_srl_7
integer x = 23
integer y = 880
integer width = 110
integer height = 92
boolean originalsize = true
string picturename = "uia2.bmp"
boolean focusrectangle = false
end type

type st_4 from statictext within w_login_srl_7
integer x = 690
integer y = 900
integer width = 718
integer height = 76
integer textsize = -6
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 15780518
long backcolor = 0
boolean enabled = false
string text = "Verano 2009 01/06/09"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_pass from singlelineedit within w_login_srl_7
integer x = 649
integer y = 540
integer width = 837
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

event modified;string pass

pass=sle_pass.text
consulta_sie(pass)
sle_password.text=pass

IF (Len (this.text) > 0) AND (Len (sle_userid.text) > 0) THEN
	cb_login.enabled = TRUE
ELSE
	cb_login.enabled = FALSE
END IF

cb_login.setfocus()
end event

type cb_close from commandbutton within w_login_srl_7
integer x = 832
integer y = 748
integer width = 361
integer height = 100
integer taborder = 40
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

type cb_login from commandbutton within w_login_srl_7
integer x = 261
integer y = 748
integer width = 361
integer height = 100
integer taborder = 30
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
//IF KeyDown (keyControl!) THEN
//	g_show_security = TRUE
//END IF
//
end event

type sle_password from singlelineedit within w_login_srl_7
event ue_check pbm_custom70
event ue_char pbm_char
integer x = 649
integer y = 540
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

type sle_userid from singlelineedit within w_login_srl_7
event ue_check pbm_custom70
event ue_char pbm_char
integer x = 649
integer y = 412
integer width = 837
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

type st_3 from statictext within w_login_srl_7
integer x = 201
integer y = 544
integer width = 393
integer height = 92
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Password:"
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_2 from statictext within w_login_srl_7
integer x = 247
integer y = 416
integer width = 352
integer height = 92
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "User ID:"
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_1 from statictext within w_login_srl_7
integer x = 123
integer y = 60
integer width = 1285
integer height = 268
integer textsize = -20
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean italic = true
long textcolor = 15780518
long backcolor = 0
boolean enabled = false
string text = "Sistema de Reinscripción en Linea"
alignment alignment = center!
boolean border = true
long bordercolor = 16777215
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type ln_1 from line within w_login_srl_7
long linecolor = 15793151
integer linethickness = 3
integer beginx = 64
integer beginy = 692
integer endx = 1399
integer endy = 692
end type

type r_1 from rectangle within w_login_srl_7
long linecolor = 16711680
integer linethickness = 3
long fillcolor = 255
integer x = 1417
integer y = 916
integer width = 87
integer height = 76
end type

