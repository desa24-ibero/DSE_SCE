$PBExportHeader$w_cap_password.srw
forward
global type w_cap_password from w_ancestral
end type
type sle_nip_2 from singlelineedit within w_cap_password
end type
type sle_nip_1 from singlelineedit within w_cap_password
end type
type uo_2 from uo_nombre_alu_foto within w_cap_password
end type
type dw_adeudos from datawindow within w_cap_password
end type
end forward

global type w_cap_password from w_ancestral
integer width = 3639
integer height = 1264
string title = "Captura y Cambio de NIP"
event inicia_proceso ( )
sle_nip_2 sle_nip_2
sle_nip_1 sle_nip_1
uo_2 uo_2
dw_adeudos dw_adeudos
end type
global w_cap_password w_cap_password

type variables
long il_cuenta
end variables

event inicia_proceso;call super::inicia_proceso;/*
DESCRIPCIÓN: Cuando se capture el número de cuenta ponlo en la variable i_lo_cuenta.
				 Habilita sle_1 para que se capture el nuevo nip.
PARÁMETROS: Message.LongParm
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
il_cuenta=Message.LongParm

sle_nip_1.enabled=true
sle_nip_2.enabled=false

sle_nip_1.setfocus()

dw_adeudos.retrieve(il_cuenta)
end event

event close;/*
DESCRIPCIÓN: Al cerrar, desconectate de cobranzas.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
if gi_numscob = 1 then
	if desconecta_bd_n_tr(gtr_scob) <> 1 then
		return
	end if
end if
gi_numscob --
end event

event open;/*
DESCRIPCIÓN: Al abrir pon la ventana en el extremo y conectate a la base de cobranzas.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/

x=1
y=1

sle_nip_1.enabled=false
sle_nip_2.enabled=false
if isnull(gi_numscob) OR not (isvalid(gtr_scob)) then gi_numscob = 0
if gi_numscob <= 0 then
	if conecta_bd_n_tr(gtr_scob,gs_scob,gs_usuario,gs_password)<>1 then
		MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de cobranzas", StopSign!)
		close(this)
	end if
end if
gi_numscob++
dw_adeudos.settransobject(gtr_scob)
end event

on w_cap_password.create
int iCurrent
call super::create
this.sle_nip_2=create sle_nip_2
this.sle_nip_1=create sle_nip_1
this.uo_2=create uo_2
this.dw_adeudos=create dw_adeudos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_nip_2
this.Control[iCurrent+2]=this.sle_nip_1
this.Control[iCurrent+3]=this.uo_2
this.Control[iCurrent+4]=this.dw_adeudos
end on

on w_cap_password.destroy
call super::destroy
destroy(this.sle_nip_2)
destroy(this.sle_nip_1)
destroy(this.uo_2)
destroy(this.dw_adeudos)
end on

type p_uia from w_ancestral`p_uia within w_cap_password
end type

type sle_nip_2 from singlelineedit within w_cap_password
event getfocus pbm_ensetfocus
event modified pbm_enmodified
integer x = 1975
integer y = 448
integer width = 626
integer height = 252
integer textsize = -26
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
boolean password = true
integer limit = 4
borderstyle borderstyle = styleraised!
end type

event getfocus;/*
DESCRIPCIÓN: Limpia el texto que se haya escrito antes.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
text=""
end event

event modified;/*
DESCRIPCIÓN: Si concuerdan los nips y son válidos, actualízalos en la base de credenciales.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
long ll_nip
string ls_nip, ls_nip_plano, ls_error_text
integer li_nip_detectado, li_error_code

sle_nip_2.enabled=false
if sle_nip_1.text<>sle_nip_2.text then
	messagebox("Vuelve a intentarlo","No concuerda la contraseña")
	sle_nip_1.enabled=true
else
	ll_nip=long(sle_nip_1.text)
	if ll_nip<=0 then
		messagebox("Vuelve a intentarlo","La contraseña tiene que ser númerica")
		sle_nip_1.enabled=true
	else
		ls_nip=sle_nip_1.text
		ls_nip_plano = ls_nip
		li_nip_detectado = 1
//		consulta_sie(ls_nip)
		UPDATE nips
		SET nip2 = :ls_nip_plano
		WHERE nips.cuenta = :il_cuenta
		USING gtr_sce;
		ls_error_text =gtr_sce.sqlerrtext
		li_error_code =gtr_sce.SqlCode
		
		if li_error_code= -1 then
			rollback using gtr_sce;
			messagebox("Error en Cambio de NIP",ls_error_text)
		else
			commit using gtr_sce;
			messagebox("Ha cambiado su contraseña","")
		end if		
	end if
end if

end event

type sle_nip_1 from singlelineedit within w_cap_password
event getfocus pbm_ensetfocus
event modified pbm_enmodified
integer x = 983
integer y = 448
integer width = 626
integer height = 252
integer textsize = -26
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
boolean password = true
integer limit = 4
borderstyle borderstyle = styleraised!
end type

event getfocus;/*
DESCRIPCIÓN: Limpia el texto que se haya escrito antes.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
text=""
end event

event modified;/*
DESCRIPCIÓN: Al capturar el nip, habilita la segunda ventana para confirmarlo.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
sle_nip_1.enabled=false
sle_nip_2.enabled=true

sle_nip_2.setfocus()
end event

type uo_2 from uo_nombre_alu_foto within w_cap_password
integer x = 9
integer width = 3598
integer taborder = 10
boolean bringtotop = true
boolean enabled = true
end type

on uo_2.destroy
call uo_nombre_alu_foto::destroy
end on

type dw_adeudos from datawindow within w_cap_password
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
integer x = 951
integer y = 732
integer width = 1673
integer height = 412
integer taborder = 11
boolean bringtotop = true
string dataobject = "dw_adeudos_informes_sin_detalle"
borderstyle borderstyle = styleraised!
end type

event constructor;Visible=FALSE

end event

event retrieveend;long cuenta

SELECT banderas_inscrito.cuenta
INTO :cuenta
FROM banderas_inscrito
WHERE banderas_inscrito.cuenta = :il_cuenta
using gtr_sce;

if gtr_sce.sqlcode = 100 then
	Visible=FALSE
	messagebox("Aviso","El Alumno no esta inscrito este semestre")
else
	Visible=TRUE
end if
end event

