$PBExportHeader$w_password_7.srw
$PBExportComments$Ventana de verificación de Password
forward
global type w_password_7 from w_ancestral
end type
type st_2 from statictext within w_password_7
end type
type sle_username from singlelineedit within w_password_7
end type
type sle_password from singlelineedit within w_password_7
end type
type st_1 from statictext within w_password_7
end type
end forward

global type w_password_7 from w_ancestral
integer x = 1134
integer y = 992
integer width = 1294
integer height = 524
st_2 st_2
sle_username sle_username
sle_password sle_password
st_1 st_1
end type
global w_password_7 w_password_7

event open;title=ProfileString (gs_startupfile, gs_datos, "APLICACION","")
end event

on w_password_7.create
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

on w_password_7.destroy
call super::destroy
destroy(this.st_2)
destroy(this.sle_username)
destroy(this.sle_password)
destroy(this.st_1)
end on

type p_uia from w_ancestral`p_uia within w_password_7
end type

type st_2 from statictext within w_password_7
integer x = 411
integer y = 92
integer width = 293
integer height = 76
integer textsize = -10
integer weight = 400
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

type sle_username from singlelineedit within w_password_7
event constructor pbm_constructor
event getfocus pbm_ensetfocus
event modified pbm_enmodified
integer x = 731
integer y = 84
integer width = 494
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
textcase textcase = lower!
borderstyle borderstyle = stylelowered!
end type

event constructor;/*
DESCRIPCIÓN: Pon el nombre de usuario en la ventana de password
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 16 Junio 1998
MODIFICACIÓN:
*/

text=gs_usuario
end event

event getfocus;/*
DESCRIPCIÓN: Cuando se selecciona el sle, se "seleccionará" el texto ahí escrito
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 16 Junio 1998
MODIFICACIÓN:
*/

selecttext(1,len(text))
end event

type sle_password from singlelineedit within w_password_7
event getfocus pbm_ensetfocus
event modified pbm_enmodified
integer x = 731
integer y = 236
integer width = 494
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
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
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 16 Junio 1998
MODIFICACIÓN:
*/

selecttext(1,len(text))
end event

event modified;/*
DESCRIPCIÓN: Verifica el password, si es correcto deja entrar; si no, pues no.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 16 Junio 1998
MODIFICACIÓN:
*/

string ls_pass_2,ls_pass_3

gs_usuario  = sle_username.text
gs_password = sle_password.text

if conecta_bd(gtr_sce,gs_sce,gs_usuario,gs_password)=1 then
	if conecta_bd(gtr_sadm,gs_sadm,gs_usuario,gs_password)=1 then
		

		open(w_principal)
		close(w_password)
		
//		end if/*SCE.SQLCode = 100*/

	else /*conecta_bd(sadm,"sadm",g_ls_usuario,g_ls_password)=1*/
		desconecta_bd(gtr_sce)
		return
	end if/*conecta_bd(sadm,"sadm",g_ls_usuario,g_ls_password)=1*/
else /*conecta_bd(sce,"sce",g_ls_usuario,g_ls_password)=1*/
	return
end if/*conecta_bd(sce,"sce",g_ls_usuario,g_ls_password)=1*/


end event

type st_1 from statictext within w_password_7
integer x = 411
integer y = 240
integer width = 293
integer height = 76
integer textsize = -10
integer weight = 400
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

