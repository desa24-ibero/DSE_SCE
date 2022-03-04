$PBExportHeader$w_password.srw
$PBExportComments$Ventana de verificación de Password
forward
global type w_password from window
end type
type st_plantel from statictext within w_password
end type
type p_3 from picture within w_password
end type
type st_4 from statictext within w_password
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
global w_password w_password

type variables
integer ii_num_intentos = 0
end variables

event ue_login;String	s_password, s_mypassword
Long ll_num_periodos

uo_periodo_tipo_servicios luo_periodo_tipo_servicios
luo_periodo_tipo_servicios = CREATE uo_periodo_tipo_servicios

gs_usuario = Trim (Lower (sle_userid.text))
gs_password = sle_pass.text	 

IF (conecta_bd_n_tr(gtr_sce,gs_sce,gs_usuario,gs_password) = 1) THEN
	////////Feb 2020_Validación Login
	if Not f_valida_login(gs_usuario, gs_password, gtr_sce) then
		if isvalid(gtr_sce) then 
			disconnect using gtr_sce;
			Destroy gtr_sce
		end if
		
		sle_pass.setfocus()
		sle_pass.SelectText(1, Len(sle_pass.Text))
		return
	end if
	
	IF (f_usuario_valido_aplicacion(GetApplication().appname, gs_usuario, gtr_sce)=1) THEN
		periodo_actual(gi_periodo,gi_anio,gtr_sce)
/*	if (f_usuario_valido_aplicacion(GetApplication().appname, gs_usuario, gtr_sce)=1) then
		if f_insert_application_access(gs_usuario,GetApplication().appname,gs_password )= 0 then
			li_acceso_registrado = 1			
		else 
			li_acceso_registrado = 0			
		end if		
*/		

		// Se llama función que carga el tipo de periodo por omisión del usuario que se firma 
		gs_periodo_default = f_obten_periodo_omision_usuario(gs_usuario, GetApplication().appname, gtr_sce)

		// 29/08/2017 MALH: Se agrega funcionalidad para mostrar la ventana de seleccion del "tipo periodo"
		ll_num_periodos = luo_periodo_tipo_servicios.f_obten_num_periodos(gtr_sce) 

		IF luo_periodo_tipo_servicios.i_error = -1 THEN
			MessageBox(luo_periodo_tipo_servicios.s_title, luo_periodo_tipo_servicios.s_message, StopSign!)
			RETURN luo_periodo_tipo_servicios.i_error
		END IF

		gs_tipo_periodo = ProfileString (gs_startupfile, gs_datos, "PeriodoDefault","S")
		
		IF NOT luo_periodo_tipo_servicios.f_existe_periodo_default(gtr_sce, gs_tipo_periodo) THEN // Si no existe el periodo por default se toma el primero existente como default
			IF luo_periodo_tipo_servicios.i_error = -1 THEN
				MessageBox(luo_periodo_tipo_servicios.s_title, luo_periodo_tipo_servicios.s_message, StopSign!)
				RETURN luo_periodo_tipo_servicios.i_error
			END IF
			
			gs_tipo_periodo = luo_periodo_tipo_servicios.f_obten_primer_periodo_como_default(gtr_sce)
			
			IF luo_periodo_tipo_servicios.i_error = -1 THEN
				MessageBox(luo_periodo_tipo_servicios.s_title, luo_periodo_tipo_servicios.s_message, StopSign!)
				RETURN luo_periodo_tipo_servicios.i_error
			END IF
		END IF
		
		IF ll_num_periodos > 1 THEN 
			gs_multiples_periodos = "S"
			setpointer(Hourglass!)
			OpenWithParm(w_cambio_tipo_periodo, 1) // 1 = Ventana Login
		ELSE
			gs_multiples_periodos = "N"			
		END IF

		OPEN(w_principal)
		CLOSE(this)
		RETURN
	ELSE
		MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la aplicacion", StopSign!)
		desconecta_bd_n_tr(gtr_sce)	
		ii_num_intentos = ii_num_intentos +1
	END IF
ELSE
	ii_num_intentos = ii_num_intentos +1
END IF

IF ii_num_intentos >= 3 THEN 
	CLOSE(THIS)
END IF


end event

event ue_close;Close(this)

end event

on w_password.create
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

on w_password.destroy
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

title = ProfileString (gs_startupfile, gs_datos, "APLICACION","") + " " + &
		 ProfileString (gs_startupfile, gs_servidores, "actual","")
		
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

type st_plantel from statictext within w_password
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

type st_6 from statictext within w_password
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

type st_8 from statictext within w_password
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
string text = "Otoño 2018"
boolean focusrectangle = false
end type

type st_ver from statictext within w_password
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

type st_1 from statictext within w_password
integer x = 1381
integer y = 392
integer width = 1623
integer height = 300
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Sistema de Control Escolar Interno PB 12"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_pass from singlelineedit within w_password
event ue_char pbm_char
event ue_check pbm_custom70
integer x = 2075
integer y = 908
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
integer taborder = 50
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
integer taborder = 40
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
integer y = 908
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
integer y = 780
integer width = 535
integer height = 96
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 15793151
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
integer y = 912
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

type st_2 from statictext within w_password
integer x = 1623
integer y = 784
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

type r_1 from rectangle within w_password
long linecolor = 16777215
integer linethickness = 3
long fillcolor = 15780518
integer x = 2994
integer y = 1708
integer width = 87
integer height = 76
end type

