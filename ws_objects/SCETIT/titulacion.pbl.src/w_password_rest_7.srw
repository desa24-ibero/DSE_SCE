$PBExportHeader$w_password_rest_7.srw
$PBExportComments$Ventana de verificación de Password
forward
global type w_password_rest_7 from w_ancestral_aux
end type
type st_2 from statictext within w_password_rest_7
end type
type sle_username from singlelineedit within w_password_rest_7
end type
type sle_password from singlelineedit within w_password_rest_7
end type
type st_1 from statictext within w_password_rest_7
end type
end forward

global type w_password_rest_7 from w_ancestral_aux
integer x = 1358
integer y = 952
integer width = 1271
integer height = 524
st_2 st_2
sle_username sle_username
sle_password sle_password
st_1 st_1
end type
global w_password_rest_7 w_password_rest_7

on w_password_rest_7.create
int iCurrent
call super::create
this.st_2=create st_2
this.sle_username=create sle_username
this.sle_password=create sle_password
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.sle_username
this.Control[iCurrent+3]=this.sle_password
this.Control[iCurrent+4]=this.st_1
end on

on w_password_rest_7.destroy
call super::destroy
destroy(this.st_2)
destroy(this.sle_username)
destroy(this.sle_password)
destroy(this.st_1)
end on

event open;call super::open;/*
DESCRIPCIÓN: No pongas seguridad, no lo pongas en la esquina.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 18 Junio 1998
MODIFICACIÓN:
*/
x	=	1358
y	=	952
title=ProfileString (gs_startupfile, gs_datos, "APLICACION","")
end event

type p_uia from w_ancestral_aux`p_uia within w_password_rest_7
end type

type st_2 from statictext within w_password_rest_7
integer x = 366
integer y = 88
integer width = 293
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Usuario:"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type sle_username from singlelineedit within w_password_rest_7
event modified pbm_enmodified
integer x = 686
integer y = 80
integer width = 494
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean autohscroll = false
textcase textcase = lower!
borderstyle borderstyle = stylelowered!
end type

event constructor;/*
DESCRIPCIÓN: Pon el nombre de usuario en la ventana de password
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/

text=gs_usuario
end event

event getfocus;/*
DESCRIPCIÓN: Cuando se selecciona el sle, se "seleccionará" el texto ahí escrito
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/

selecttext(1,len(text))
end event

type sle_password from singlelineedit within w_password_rest_7
integer x = 686
integer y = 228
integer width = 494
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean password = true
integer limit = 20
borderstyle borderstyle = stylelowered!
end type

event getfocus;/*
DESCRIPCIÓN: Cuando se selecciona el sle, se "seleccionará" el texto ahí escrito
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/

selecttext(1,len(text))
end event

event modified;/*
DESCRIPCIÓN: Verifica el password, si es correcto deja entrar; si no, pues no.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/

string ls_pass_2,ls_pass_3
integer li_usuario_aplicacion

gs_usuario  = sle_username.text
gs_password = sle_password.text

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
		

//Comentado para migrar sin padlock
	/*Cortesia de Charlie:*/
//	ls_pass_3=gs_password
//	consulta_sie(ls_pass_3)
//	SELECT password
//	INTO :ls_pass_2
//	FROM pc_user_def
//	WHERE pc_user_def.user_id=:gs_usuario AND
//			pc_user_def.password=:ls_pass_3
//	USING gtr_sce;
//
//	if gtr_sce.SQLCode = 100 then
//		MessageBox("Usuario Desconocido Por PADLOCK","")
//		desconecta_bd(gtr_sce)
//		return
//	else /*sce.SQLCode = 100*/

//Comentado para migrar sin padlock
//		g_nv_security.fnv_init_security(GetApplication().AppName,gs_usuario,gtr_sce,TRUE)
		
		periodo_actual(gi_periodo,gi_anio,gtr_sce)
		gi_periodo++
		if gi_periodo=3 then
			gi_periodo=0
			gi_anio++
		end if
		
		open(w_principal)
		close(w_password_rest)

//Comentado para migrar sin padlock
//	end if/*sce.SQLCode = 100*/

else /*conecta_bd(sce,"sce",g_st_usuario,g_st_password)=0*/
	return
end if/*conecta_bd(sce,"sce",g_st_usuario,g_st_password)=0*/
end event

type st_1 from statictext within w_password_rest_7
integer x = 366
integer y = 236
integer width = 293
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Password:"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

