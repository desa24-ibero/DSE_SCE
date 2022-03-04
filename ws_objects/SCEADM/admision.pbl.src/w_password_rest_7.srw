$PBExportHeader$w_password_rest_7.srw
$PBExportComments$Ventana de verificación de Password
forward
global type w_password_rest_7 from w_ancestral_aux
end type
type st_1 from statictext within w_password_rest_7
end type
type st_2 from statictext within w_password_rest_7
end type
type sle_username from singlelineedit within w_password_rest_7
end type
type sle_password from singlelineedit within w_password_rest_7
end type
end forward

global type w_password_rest_7 from w_ancestral_aux
integer width = 1271
integer height = 524
st_1 st_1
st_2 st_2
sle_username sle_username
sle_password sle_password
end type
global w_password_rest_7 w_password_rest_7

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

on w_password_rest_7.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
this.sle_username=create sle_username
this.sle_password=create sle_password
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.sle_username
this.Control[iCurrent+4]=this.sle_password
end on

on w_password_rest_7.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_username)
destroy(this.sle_password)
end on

type p_uia from w_ancestral_aux`p_uia within w_password_rest_7
end type

type st_1 from statictext within w_password_rest_7
integer x = 366
integer y = 92
integer width = 293
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "Usuario:"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_2 from statictext within w_password_rest_7
integer x = 366
integer y = 236
integer width = 293
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "Password:"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type sle_username from singlelineedit within w_password_rest_7
integer x = 690
integer y = 80
integer width = 498
integer height = 100
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
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

event constructor;/*
DESCRIPCIÓN: Pon el nombre de usuario en la ventana de password
PARÁMETROS: Ninguno
REGRESA: Nada
MODIFICACIÓN:
*/

text=gs_usuario

end event

type sle_password from singlelineedit within w_password_rest_7
integer x = 690
integer y = 228
integer width = 498
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean password = true
integer limit = 20
borderstyle borderstyle = stylelowered!
end type

event getfocus;/*
DESCRIPCIÓN: Cuando se selecciona el sle, se "seleccionará" el texto ahí escrito
PARÁMETROS: Ninguno
REGRESA: Nada
MODIFICACIÓN:
*/

selecttext(1,len(text))
end event

event modified;/*
DESCRIPCIÓN: Verifica el password, si es correcto deja entrar; si no, pues no.
PARÁMETROS: Ninguno
REGRESA: Nada
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
	if conecta_bd(gtr_sadm,gs_sadm,gs_usuario,gs_password)=1 then

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

	else /*conecta_bd(sadm,"sadm",g_ls_usuario,g_ls_password)=1*/
		desconecta_bd(gtr_sce)
		return
	end if/*conecta_bd(sadm,"sadm",g_ls_usuario,g_ls_password)=1*/
else /*conecta_bd_n_tr(sce,"sce",g_st_usuario,g_st_password)=0*/
	return
end if/*conecta_bd_n_tr(sce,"sce",g_st_usuario,g_st_password)=0*/
end event

