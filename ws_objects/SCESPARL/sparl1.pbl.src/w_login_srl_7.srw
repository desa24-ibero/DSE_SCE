$PBExportHeader$w_login_srl_7.srw
forward
global type w_login_srl_7 from window
end type
type p_uia from picture within w_login_srl_7
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
end forward

global type w_login_srl_7 from window
integer x = 832
integer y = 356
integer width = 1687
integer height = 1012
windowtype windowtype = response!
long backcolor = 0
event ue_login pbm_custom60
event ue_close pbm_custom61
event ue_login_ant pbm_custom62
p_uia p_uia
sle_pass sle_pass
cb_close cb_close
cb_login cb_login
sle_password sle_password
sle_userid sle_userid
st_3 st_3
st_2 st_2
st_1 st_1
ln_1 ln_1
end type
global w_login_srl_7 w_login_srl_7

event ue_login;string	s_password
string	s_userid

string ls_pass_2,ls_pass_3
integer li_usuario_aplicacion

gs_usuario  = Trim (Lower (sle_userid.text))
gs_password = Trim (Lower (sle_pass.text))

if conecta_bd_n_tr(gtr_sce,gs_sce,gs_usuario,gs_password)=1 then

   li_usuario_aplicacion = f_usuario_valido_aplicacion(GetApplication().appname, gs_usuario, gtr_sce)
									
	choose case li_usuario_aplicacion 
		case 0
			MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la aplicacion", StopSign!)
			disconnect using gtr_sce;
			return
		case -1
			MessageBox("Acceso Negado",&
			"Favor de intentarlo nuevamente",StopSign!)
			disconnect using gtr_sce;
			return
	end choose
	periodo_actual(gi_periodo,gi_anio,gtr_sce)
	gi_periodo++
	if gi_periodo=3 then
		gi_periodo=0
		gi_anio++
	end if
						
	open(w_principal)
//	open(w_sparl)

	close(w_login_srl)

else /*conecta_bd_n_tr(sce,"sce",g_st_usuario,g_st_password)=0*/
	return
end if/*conecta_bd_n_tr(sce,"sce",g_st_usuario,g_st_password)=0*/

end event

event ue_close;
CloseWithReturn (this, "")

end event

event ue_login_ant;string	s_password
string	s_userid

s_userid = Trim (Lower (sle_userid.text))

/* Populate gtr_sce from current PB.INI settings */
gtr_sce.DBMS       = ProfileString ("sparl.ini", gs_sce, "dbms",       "")
gtr_sce.database   = ProfileString ("sparl.ini", gs_sce, "database",   "")
gtr_sce.logid      = s_userid
//gtr_sceini(gtr_sce.logid)
gtr_sce.logpass    = sle_pass.text
//gtr_sceini(gtr_sce.logpass)
gtr_sce.servername = ProfileString ("sparl.ini", gs_sce, "servername", "")
gtr_sce.dbparm     = ProfileString ("sparl.ini", gs_sce, "dbparm",     "")

/* Uncomment the following for actual DB connection */
connect USING gtr_sce;
//
if gtr_sce.sqlcode <> 0 then
	MessageBox ("Error de Comunicación", gtr_sce.sqlerrtext, None!)
	return
end if

  SELECT	pc_user_def.password
    INTO	:s_password
    FROM	pc_user_def
   WHERE	pc_user_def.user_id = :s_userid
   USING	gtr_sce;

IF gtr_sce.SQLCode = 100 THEN
	MessageBox ("Error de Comunicación", "No se encontró el UserID.", None!)
	sle_userid.SetFocus ()
	RETURN
END IF

IF gtr_sce.SQLCode < 0 THEN
	MessageBox ("Error de Comunicación", "No se verificó UserID y Password.", None!)
	RETURN
END IF

// Make sure to release any locks...
COMMIT USING gtr_sce;

IF Trim (Lower (s_password)) = Trim (Lower (sle_password.text)) THEN
	CloseWithReturn (this, s_userid)
ELSE
	MessageBox ("Error de Comunicación", "El password para : '" + s_userid + "' no coincide", None!)
	sle_password.SetFocus ()
END IF

end event

on w_login_srl_7.create
this.p_uia=create p_uia
this.sle_pass=create sle_pass
this.cb_close=create cb_close
this.cb_login=create cb_login
this.sle_password=create sle_password
this.sle_userid=create sle_userid
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.ln_1=create ln_1
this.Control[]={this.p_uia,&
this.sle_pass,&
this.cb_close,&
this.cb_login,&
this.sle_password,&
this.sle_userid,&
this.st_3,&
this.st_2,&
this.st_1,&
this.ln_1}
end on

on w_login_srl_7.destroy
destroy(this.p_uia)
destroy(this.sle_pass)
destroy(this.cb_close)
destroy(this.cb_login)
destroy(this.sle_password)
destroy(this.sle_userid)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ln_1)
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

//pass=sle_pass.text
//consulta_sie(pass)
//sle_password.text=pass

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
integer x = 50
integer y = 60
integer width = 1586
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
string text = "Sistema de Procesos Auxiliares a la Reinscripción"
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

