﻿$PBExportHeader$w_login_srl.srw
forward
global type w_login_srl from window
end type
type st_6 from statictext within w_login_srl
end type
type st_8 from statictext within w_login_srl
end type
type st_ver from statictext within w_login_srl
end type
type st_1 from statictext within w_login_srl
end type
type p_logo_uia from picture within w_login_srl
end type
type p_1 from picture within w_login_srl
end type
type p_2 from picture within w_login_srl
end type
type sle_pass from singlelineedit within w_login_srl
end type
type cb_close from commandbutton within w_login_srl
end type
type cb_login from commandbutton within w_login_srl
end type
type sle_password from singlelineedit within w_login_srl
end type
type sle_userid from singlelineedit within w_login_srl
end type
type st_3 from statictext within w_login_srl
end type
type st_2 from statictext within w_login_srl
end type
type r_1 from rectangle within w_login_srl
end type
end forward

global type w_login_srl from window
integer x = 832
integer y = 356
integer width = 3131
integer height = 1900
boolean titlebar = true
string title = "Ventana de acceso (Inscripción de Alumnos)"
windowtype windowtype = response!
long backcolor = 12632256
string icon = "reinscripcion.ico"
event ue_login pbm_custom60
event ue_close pbm_custom61
st_6 st_6
st_8 st_8
st_ver st_ver
st_1 st_1
p_logo_uia p_logo_uia
p_1 p_1
p_2 p_2
sle_pass sle_pass
cb_close cb_close
cb_login cb_login
sle_password sle_password
sle_userid sle_userid
st_3 st_3
st_2 st_2
r_1 r_1
end type
global w_login_srl w_login_srl

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

on w_login_srl.create
this.st_6=create st_6
this.st_8=create st_8
this.st_ver=create st_ver
this.st_1=create st_1
this.p_logo_uia=create p_logo_uia
this.p_1=create p_1
this.p_2=create p_2
this.sle_pass=create sle_pass
this.cb_close=create cb_close
this.cb_login=create cb_login
this.sle_password=create sle_password
this.sle_userid=create sle_userid
this.st_3=create st_3
this.st_2=create st_2
this.r_1=create r_1
this.Control[]={this.st_6,&
this.st_8,&
this.st_ver,&
this.st_1,&
this.p_logo_uia,&
this.p_1,&
this.p_2,&
this.sle_pass,&
this.cb_close,&
this.cb_login,&
this.sle_password,&
this.sle_userid,&
this.st_3,&
this.st_2,&
this.r_1}
end on

on w_login_srl.destroy
destroy(this.st_6)
destroy(this.st_8)
destroy(this.st_ver)
destroy(this.st_1)
destroy(this.p_logo_uia)
destroy(this.p_1)
destroy(this.p_2)
destroy(this.sle_pass)
destroy(this.cb_close)
destroy(this.cb_login)
destroy(this.sle_password)
destroy(this.sle_userid)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.r_1)
end on

type st_6 from statictext within w_login_srl
integer x = 151
integer y = 1400
integer width = 1303
integer height = 88
integer textsize = -11
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

type st_8 from statictext within w_login_srl
integer x = 151
integer y = 1488
integer width = 480
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Copyright@. 2009."
boolean focusrectangle = false
end type

type st_ver from statictext within w_login_srl
integer x = 151
integer y = 1576
integer width = 480
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_1 from statictext within w_login_srl
integer x = 1371
integer y = 372
integer width = 1591
integer height = 304
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Sistema de Inscripciones DGMU PB 10.2"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_logo_uia from picture within w_login_srl
integer x = 151
integer y = 372
integer width = 1029
integer height = 828
string picturename = "uiafondo.bmp"
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type p_1 from picture within w_login_srl
integer x = 475
integer y = 52
integer width = 933
integer height = 176
string picturename = "universidad.bmp"
boolean focusrectangle = false
end type

type p_2 from picture within w_login_srl
integer x = 1403
integer y = 52
integer width = 1193
integer height = 176
string picturename = "iberoamericana.bmp"
boolean focusrectangle = false
end type

type sle_pass from singlelineedit within w_login_srl
integer x = 2075
integer y = 1200
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

type cb_close from commandbutton within w_login_srl
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

type cb_login from commandbutton within w_login_srl
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

type sle_password from singlelineedit within w_login_srl
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

type sle_userid from singlelineedit within w_login_srl
event ue_check pbm_custom70
event ue_char pbm_char
integer x = 2075
integer y = 1072
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

type st_3 from statictext within w_login_srl
integer x = 1623
integer y = 1204
integer width = 393
integer height = 92
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 12632256
boolean enabled = false
string text = "Password:"
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_2 from statictext within w_login_srl
integer x = 1623
integer y = 1076
integer width = 352
integer height = 92
integer textsize = -11
integer weight = 700
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

type r_1 from rectangle within w_login_srl
long linecolor = 16711680
integer linethickness = 3
long fillcolor = 32768
integer x = 2994
integer y = 1708
integer width = 87
integer height = 76
end type
