$PBExportHeader$w_login_srl.srw
forward
global type w_login_srl from window
end type
type st_plantel from statictext within w_login_srl
end type
type p_3 from picture within w_login_srl
end type
type st_4 from statictext within w_login_srl
end type
type st_6 from statictext within w_login_srl
end type
type st_8 from statictext within w_login_srl
end type
type st_ver from statictext within w_login_srl
end type
type st_1 from statictext within w_login_srl
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
boolean center = true
event ue_login pbm_custom60
event ue_close pbm_custom61
st_plantel st_plantel
p_3 p_3
st_4 st_4
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
global w_login_srl w_login_srl

forward prototypes
public subroutine of_inicializa_variables_config (string as_servidor)
end prototypes

event ue_login;/*******************************************************************/
/*Cambio en forma de conexión debido a requerimeinto. El sistema debe funcionar tanto en
SQL Server como en Sybase.
	La validación del usuario y lectura del parámetro de conexión se realiza a través de una conexión
auxiliar (gtr_parametros_iniciales) la cual obtendrá sus parámetros de conexión del la sección [SCE] del archivo ini de la 
aplicación.
    Con la conexión auxiliar se recuperará a que servidor se debe de conectar el objeto SQLCA, leyendose
la información de una base de datos.
*/
/*******************************************************************/
string			s_password
string			s_userid
integer		li_chk

s_userid = Trim (Lower (sle_userid.text))

/*Conexión para lectura del servidor de conexión:*/
gtr_parametros_iniciales.DBMS			= ProfileString (gs_startupfile, gs_sce, "dbms",       "")
gtr_parametros_iniciales.database		= ProfileString (gs_startupfile, gs_sce, "database",   "")
gtr_parametros_iniciales.logid      		= s_userid
gtr_parametros_iniciales.logpass    	= sle_pass.text
gtr_parametros_iniciales.servername	= ProfileString (gs_startupfile, gs_sce, "servername", "")
gtr_parametros_iniciales.dbparm     	= ProfileString (gs_startupfile, gs_sce, "dbparm",     "")

DISCONNECT USING gtr_parametros_iniciales;
CONNECT USING gtr_parametros_iniciales;
If gtr_parametros_iniciales.sqlcode <> 0 Then
	MessageBox("Error","Los parámetros de conexión no son correctos o el servidor " + gtr_parametros_iniciales.servername + &
								" no está disponible.",stopsign!)
	return
End if

//// DESCOMENTAR DESCOMENTAR DESCOMENTAR DESCOMENTAR DESCOMENTAR DESCOMENTAR DESCOMENTAR DESCOMENTAR 
//// DESCOMENTAR DESCOMENTAR DESCOMENTAR DESCOMENTAR DESCOMENTAR DESCOMENTAR DESCOMENTAR DESCOMENTAR 
////////feb 2020_Validación de login

//if Not f_valida_login(gtr_parametros_iniciales.logid, gtr_parametros_iniciales.logpass, gtr_parametros_iniciales) then
//	if isvalid(gtr_parametros_iniciales) then 
//		disconnect using gtr_parametros_iniciales;
//		//Destroy gtr_parametros_iniciales
//	end if
//	
//	sle_pass.setfocus()
//	sle_pass.SelectText(1, Len(sle_pass.Text))
//	return
//end if

//// DESCOMENTAR DESCOMENTAR DESCOMENTAR DESCOMENTAR DESCOMENTAR DESCOMENTAR DESCOMENTAR DESCOMENTAR 
//// DESCOMENTAR DESCOMENTAR DESCOMENTAR DESCOMENTAR DESCOMENTAR DESCOMENTAR DESCOMENTAR DESCOMENTAR 



li_chk	=	f_conecta_pas_parametros_bd(gtr_parametros_iniciales,SQLCA,gs_controlescolar_cnx,s_userid,sle_pass.text)
if li_chk <> 1 then return
DISCONNECT USING gtr_parametros_iniciales;
CloseWithReturn (this, s_userid)
end event

on ue_close;
CloseWithReturn (this, "")

end on

public subroutine of_inicializa_variables_config (string as_servidor);String ls_complemento

IF as_servidor = "" THEN as_servidor = "Mexico"
IF gs_separador = "" THEN gs_separador = "."

ls_complemento = gs_separador + as_servidor

gs_sfeb = "sfeb" + ls_complemento
gs_cobranzas = "cobranzas" + ls_complemento
gs_sce = "sce" + ls_complemento
gs_datos = "datos" + ls_complemento

RETURN
end subroutine

on w_login_srl.create
this.st_plantel=create st_plantel
this.p_3=create p_3
this.st_4=create st_4
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
this.Control[]={this.st_plantel,&
this.p_3,&
this.st_4,&
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

on w_login_srl.destroy
destroy(this.st_plantel)
destroy(this.p_3)
destroy(this.st_4)
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

event open;String ls_plantel, ls_info_periodo, ls_logo, ls_valor

// Se inicializa las variables con el nombre del servidor
gs_servidor = LOWER(TRIM(ProfileString (gs_startupfile, "config", "Servidor","Mexico")))
of_inicializa_variables_config(gs_servidor)

ls_plantel = UPPER(ProfileString (gs_startupfile, gs_datos, "plantel",""))
ls_info_periodo = ProfileString (gs_startupfile, gs_datos, "info_periodo","")
ls_logo = ProfileString (gs_startupfile, gs_datos, "logo","")
gs_logo = ls_logo

CHOOSE CASE LOWER(gs_servidor) 
	CASE LOWER("Tijuana")
		st_plantel.VISIBLE = TRUE
		st_plantel.TEXT = ls_plantel
		st_plantel.TEXTCOLOR = RGB(200,50,50)
		p_3.PictureName = ls_logo
		st_1.TEXTCOLOR = RGB(200,50,50)
		st_2.TEXTCOLOR = RGB(200,50,50)
		st_3.TEXTCOLOR = RGB(200,50,50)
		st_4.TEXTCOLOR = RGB(200,50,50)
		st_6.TEXTCOLOR = RGB(200,50,50)
		st_8.TEXTCOLOR = RGB(200,50,50)
		st_8.TEXT = ls_info_periodo
		st_ver.TEXTCOLOR = RGB(200,50,50)

	CASE LOWER("Chalco")
		st_plantel.VISIBLE = TRUE
		st_plantel.TEXT = ls_plantel
		st_8.TEXT = ls_info_periodo
		p_3.PictureName = ls_logo
	
	CASE ELSE 
		st_plantel.TEXT = ls_plantel
		st_8.TEXT = ls_info_periodo
		p_3.PictureName = ls_logo
END CHOOSE
end event

type st_plantel from statictext within w_login_srl
integer x = 366
integer y = 228
integer width = 2473
integer height = 128
integer textsize = -22
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 12632256
alignment alignment = center!
boolean focusrectangle = false
end type

type p_3 from picture within w_login_srl
integer x = 82
integer y = 548
integer width = 960
integer height = 460
string picturename = "anEscudo-Logo.png"
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_4 from statictext within w_login_srl
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
string text = "Otoño 2017"
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
integer x = 1317
integer y = 580
integer width = 1586
integer height = 308
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Sistema de Reinscripción en Línea PB 12"
alignment alignment = center!
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
long linecolor = 16777215
integer linethickness = 3
long fillcolor = 15780518
integer x = 2994
integer y = 1708
integer width = 87
integer height = 76
end type

