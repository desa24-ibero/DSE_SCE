$PBExportHeader$w_cambio_nip_password.srw
forward
global type w_cambio_nip_password from w_ancestral
end type
type sle_nip_2 from singlelineedit within w_cambio_nip_password
end type
type sle_nip_1 from singlelineedit within w_cambio_nip_password
end type
type uo_2 from uo_nombre_alu_foto within w_cambio_nip_password
end type
type dw_alumno_cambio_password from datawindow within w_cambio_nip_password
end type
type cb_1 from commandbutton within w_cambio_nip_password
end type
end forward

global type w_cambio_nip_password from w_ancestral
integer width = 3639
integer height = 1852
string title = "Cambio de NIP a PASSWORD"
event inicia_proceso ( )
sle_nip_2 sle_nip_2
sle_nip_1 sle_nip_1
uo_2 uo_2
dw_alumno_cambio_password dw_alumno_cambio_password
cb_1 cb_1
end type
global w_cambio_nip_password w_cambio_nip_password

type variables
long il_cuenta, il_rows_alumno_cambio_password = 0
transaction itr_web
end variables

forward prototypes
public subroutine f_alumno_cambio_password ()
end prototypes

event inicia_proceso;call super::inicia_proceso;/*
DESCRIPCIÓN: Cuando se capture el número de cuenta ponlo en la variable i_lo_cuenta.
				 Habilita sle_1 para que se capture el nuevo nip.
PARÁMETROS: Message.LongParm
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
LONG ll_rows , ll_row_actual
il_cuenta=Message.LongParm

sle_nip_1.enabled=true
sle_nip_2.enabled=false

sle_nip_1.setfocus()

ll_rows = dw_alumno_cambio_password.retrieve(il_cuenta)
il_rows_alumno_cambio_password = ll_rows
IF ll_rows= 0 THEN
	dw_alumno_cambio_password.InsertRow(0)
	ll_row_actual = dw_alumno_cambio_password.GetRow()
	dw_alumno_cambio_password.SetItem(ll_row_actual, "cuenta", il_cuenta)
END IF
end event

public subroutine f_alumno_cambio_password ();long ll_cuenta , ll_cve_profesor , ll_folio , ll_cve_pregunta_secreta 
string ls_cve_tipo_usuario ="A", ls_respuesta_secreta , ls_email , ls_telefono_celular 
string ls_telefono_domicilio , ls_curp , ls_rfc 
datetime ls_fecha     
long ll_row 

ll_row = dw_alumno_cambio_password.GetRow()
 
ls_cve_tipo_usuario = "A"
ll_cuenta = dw_alumno_cambio_password.GetItemNumber(ll_row, "cuenta")
ll_cve_profesor = 0
ll_folio = 0
ll_cve_pregunta_secreta = dw_alumno_cambio_password.GetItemNumber(ll_row, "cve_pregunta_secreta")
ls_respuesta_secreta  = dw_alumno_cambio_password.GetItemString(ll_row, "respuesta_secreta")
ls_email  = dw_alumno_cambio_password.GetItemString(ll_row, "email")
ls_telefono_celular  = dw_alumno_cambio_password.GetItemString(ll_row, "telefono_celular")
ls_telefono_domicilio  = dw_alumno_cambio_password.GetItemString(ll_row, "telefono_domicilio")
ls_curp  = dw_alumno_cambio_password.GetItemString(ll_row, "curp")
ls_rfc  = dw_alumno_cambio_password.GetItemString(ll_row, "rfc")

IF il_rows_alumno_cambio_password>0 THEN
//ACTUALIZA EL REGISTRO EXISTENTE
		UPDATE web_bd.dbo.v_www_alumno_cambio_password 
		SET	cve_pregunta_secreta = :ll_cve_pregunta_secreta,
			respuesta_secreta = :ls_respuesta_secreta,
			email = :ls_email,
			telefono_celular = :ls_telefono_celular,
			telefono_domicilio = :ls_telefono_domicilio,
			curp = :ls_curp,
			rfc =:ls_rfc,
			fecha = getdate()
		FROM web_bd.dbo.v_www_alumno_cambio_password
		WHERE cuenta= :ll_cuenta
		AND 	cve_tipo_usuario = 'A'
		USING itr_web;
		
ELSE
//INSERTA UN REGISTRO NUEVO

		INSERT INTO web_bd.dbo.v_www_alumno_cambio_password (
			cve_tipo_usuario,
			cuenta,
			cve_profesor,
			folio,
			cve_pregunta_secreta,
			respuesta_secreta,
			email,
			telefono_celular,
			telefono_domicilio,
			curp,
			rfc,
			fecha
			) 
		VALUES ('A',
			:ll_cuenta,
			0,
			0,
			:ll_cve_pregunta_secreta,
			:ls_respuesta_secreta,
			:ls_email,
			:ls_telefono_celular,
			:ls_telefono_domicilio,
			:ls_curp,
			:ls_rfc,
			getdate()
			)
		USING itr_web;
END IF

return 
end subroutine

event close;
/*
DESCRIPCIÓN: Al cerrar, desconectate de cobranzas.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
//if gi_numscob = 1 then
//	if desconecta_bd_n_tr(gtr_scob) <> 1 then
//		return
//	end if
//end if
//gi_numscob --


if isvalid(itr_web) then
	if desconecta_bd(itr_web) <> 1 then
		return
	end if
end if


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
//if isnull(gi_numscob) OR not (isvalid(gtr_scob)) then gi_numscob = 0
//if gi_numscob <= 0 then
//	if conecta_bd_n_tr(gtr_scob,gs_scob,gs_usuario,gs_password)<>1 then
//		MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de cobranzas", StopSign!)
//		close(this)
//	end if
//end if

//if conecta_bd(itr_web,gs_web_desb, "scedesbloqueo","ventdesb06")<>1 then
if conecta_bd(itr_web,gs_web_desb, gs_usuario,gs_password)<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	close(this)
else 
	dw_alumno_cambio_password.SetTransObject(itr_web)
end if


//gi_numscob++
//dw_adeudos.settransobject(gtr_scob)
end event

on w_cambio_nip_password.create
int iCurrent
call super::create
this.sle_nip_2=create sle_nip_2
this.sle_nip_1=create sle_nip_1
this.uo_2=create uo_2
this.dw_alumno_cambio_password=create dw_alumno_cambio_password
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_nip_2
this.Control[iCurrent+2]=this.sle_nip_1
this.Control[iCurrent+3]=this.uo_2
this.Control[iCurrent+4]=this.dw_alumno_cambio_password
this.Control[iCurrent+5]=this.cb_1
end on

on w_cambio_nip_password.destroy
call super::destroy
destroy(this.sle_nip_2)
destroy(this.sle_nip_1)
destroy(this.uo_2)
destroy(this.dw_alumno_cambio_password)
destroy(this.cb_1)
end on

type p_uia from w_ancestral`p_uia within w_cambio_nip_password
end type

type sle_nip_2 from singlelineedit within w_cambio_nip_password
event getfocus pbm_ensetfocus
event modified pbm_enmodified
integer x = 1975
integer y = 448
integer width = 626
integer height = 252
integer taborder = 30
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
boolean password = true
integer limit = 8
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

event modified;///*
//DESCRIPCIÓN: Si concuerdan los nips y son válidos, actualízalos en la base de credenciales.
//PARÁMETROS: Ninguno
//REGRESA: Nada
////AUTOR: Víctor Manuel Iniestra Álvarez
//FECHA: 15 Junio 1998
//MODIFICACIÓN:
//*/
//long ll_nip
//string ls_nip, ls_nip_plano, ls_error_text, ls_error, ls_contrasenia_capturada
//integer li_nip_detectado, li_password_valido
//integer li_error_code_syb, li_error_code_sql
//string ls_error_text_syb, ls_error_text_sql
//
//sle_nip_2.enabled=false
//if sle_nip_1.text<>sle_nip_2.text then
//	messagebox("Vuelve a intentarlo","No concuerda la contraseña")
//	sle_nip_1.enabled=true
//else
//	ls_contrasenia_capturada = sle_nip_2.text
//	li_password_valido = f_password_valido(ls_contrasenia_capturada, ls_error)
//	IF li_password_valido <>1 THEN
//		messagebox("Vuelve a Intentarlo","La contraseña debe iniciar en letra y contener al menus un número~n"+ls_error,StopSign!)
//		sle_nip_1.enabled=true
//		return
//	END IF
//	ll_nip=long(sle_nip_1.text)
////	if ll_nip<=0 then
////		messagebox("Vuelve a intentarlo","La contraseña tiene que ser númerica")
////		sle_nip_1.enabled=true
////	else
//		ls_nip=sle_nip_1.text
//		ls_nip_plano = ls_nip
//		li_nip_detectado = 1
////		consulta_sie(ls_nip)
//		UPDATE nips
//		SET password  = :ls_nip_plano,
//			fecha = getdate()
//		WHERE nips.cuenta = :il_cuenta
//		USING gtr_sce;
//		ls_error_text_syb = gtr_sce.sqlerrtext
//		li_error_code_syb = gtr_sce.SqlCode
//		if isnull(ls_error_text_syb) then ls_error_text_syb=""
//
////		UPDATE controlescolar_bd.dbo.nips
////		SET password  = :ls_nip_plano,
////			fecha = getdate()
////		WHERE controlescolar_bd.dbo.nips.cuenta = :il_cuenta
////		USING itr_web;
////		ls_error_text_sql = itr_web.sqlerrtext
////		li_error_code_sql = itr_web.SqlCode
////		if isnull(ls_error_text_sql) then ls_error_text_sql=""
//		
//		
//		if (li_error_code_syb = -1) or (li_error_code_sql = -1) then
//			rollback using gtr_sce;
//			rollback using itr_web;
//			messagebox("Error en Cambio de NIP",ls_error_text_syb+"~n"+ls_error_text_sql,StopSign!)
//		else
//			commit using gtr_sce;
//			commit using itr_web;
//			messagebox("Confirmación","Ha cambiado su contraseña exitosamente",Information!)
//		end if		
////	end if
//end if
//
end event

type sle_nip_1 from singlelineedit within w_cambio_nip_password
event getfocus pbm_ensetfocus
event modified pbm_enmodified
integer x = 983
integer y = 448
integer width = 626
integer height = 252
integer taborder = 20
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
boolean password = true
integer limit = 8
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

type uo_2 from uo_nombre_alu_foto within w_cambio_nip_password
integer x = 9
integer width = 3598
integer height = 420
integer taborder = 10
boolean bringtotop = true
boolean enabled = true
end type

on uo_2.destroy
call uo_nombre_alu_foto::destroy
end on

type dw_alumno_cambio_password from datawindow within w_cambio_nip_password
integer x = 361
integer y = 736
integer width = 2894
integer height = 768
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_alumno_cambio_password"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_cambio_nip_password
integer x = 1449
integer y = 1576
integer width = 718
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cambiar NIP a Password"
end type

event clicked;long ll_nip
string ls_nip, ls_nip_plano, ls_error_text, ls_error, ls_contrasenia_capturada
integer li_nip_detectado, li_password_valido
integer li_error_code_syb, li_error_code_sql, li_error_code_sql2
string ls_error_text_syb, ls_error_text_sql, ls_error_text_sql2


long ll_cuenta , ll_cve_profesor , ll_folio , ll_cve_pregunta_secreta 
string ls_cve_tipo_usuario ="A", ls_respuesta_secreta , ls_email , ls_telefono_celular 
string ls_telefono_domicilio , ls_curp , ls_rfc 
datetime ls_fecha     
long ll_row 

ll_row = dw_alumno_cambio_password.GetRow()
dw_alumno_cambio_password.AcceptText()

ls_cve_tipo_usuario = "A"
ll_cuenta = dw_alumno_cambio_password.GetItemNumber(ll_row, "cuenta")
ll_cve_profesor = 0
ll_folio = 0
ll_cve_pregunta_secreta = dw_alumno_cambio_password.GetItemNumber(ll_row, "cve_pregunta_secreta")
ls_respuesta_secreta  = dw_alumno_cambio_password.GetItemString(ll_row, "respuesta_secreta")
ls_email  = dw_alumno_cambio_password.GetItemString(ll_row, "email")
ls_telefono_celular  = dw_alumno_cambio_password.GetItemString(ll_row, "telefono_celular")
ls_telefono_domicilio  = dw_alumno_cambio_password.GetItemString(ll_row, "telefono_domicilio")
ls_curp  = dw_alumno_cambio_password.GetItemString(ll_row, "curp")
ls_rfc  = dw_alumno_cambio_password.GetItemString(ll_row, "rfc")

IF isnull(ll_cve_pregunta_secreta) THEN
	messagebox("Faltan datos","Favor de seleccionar la pregunta secreta",StopSign!)
	return
END IF

IF isnull(ls_respuesta_secreta) or ls_respuesta_secreta = "" THEN
	messagebox("Faltan datos","Favor de escribir la respuesta secreta",StopSign!)
	return
END IF

IF isnull(ls_email) or ls_email = "" THEN
	messagebox("Faltan datos","Favor de escribir la cuenta de correo",StopSign!)
	return
END IF


sle_nip_2.enabled=false
if sle_nip_1.text<>sle_nip_2.text then
	messagebox("Vuelve a intentarlo","No concuerda la contraseña")
	sle_nip_1.enabled=true
else
	ls_contrasenia_capturada = lower(sle_nip_2.text)
	li_password_valido = f_password_valido(ls_contrasenia_capturada, ls_error)
	IF li_password_valido <>1 THEN
		messagebox("Vuelve a Intentarlo","La contraseña debe iniciar en letra y contener al menus un número~n"+ls_error,StopSign!)
		sle_nip_1.enabled=true
		return
	END IF
	ll_nip=long(sle_nip_1.text)
//	if ll_nip<=0 then
//		messagebox("Vuelve a intentarlo","La contraseña tiene que ser númerica")
//		sle_nip_1.enabled=true
//	else
		ls_nip=sle_nip_1.text
		ls_nip_plano = lower(ls_nip)
		li_nip_detectado = 1
//		consulta_sie(ls_nip)
		UPDATE nips
		SET password  = :ls_nip_plano,
			fecha = getdate(),
			transferencia_pendiente = 0,
			transferencia_pendiente_web = 0
		WHERE nips.cuenta = :il_cuenta
		USING gtr_sce;
		ls_error_text_syb = gtr_sce.sqlerrtext
		li_error_code_syb = gtr_sce.SqlCode
		if isnull(ls_error_text_syb) then ls_error_text_syb=""

		UPDATE controlescolar_bd.dbo.nips
		SET password  = :ls_nip_plano,
			fecha = getdate(),
			transferencia_pendiente = 0,
			transferencia_pendiente_web = 0
		WHERE controlescolar_bd.dbo.nips.cuenta = :il_cuenta
		USING itr_web;
		ls_error_text_sql = itr_web.sqlerrtext
		li_error_code_sql = itr_web.SqlCode
		if isnull(ls_error_text_sql) then ls_error_text_sql=""
		
		//Efectua funcion de cambio de password ( y controla aqui el manejo transaccional
		f_alumno_cambio_password()		
		ls_error_text_sql2 = itr_web.sqlerrtext
		li_error_code_sql2 = itr_web.SqlCode
		if isnull(ls_error_text_sql2) then ls_error_text_sql2=""
		
		
		if (li_error_code_syb = -1) or (li_error_code_sql = -1) or (li_error_code_sql2 = -1) then
			rollback using gtr_sce;
			rollback using itr_web;
			messagebox("Error en Cambio de NIP",ls_error_text_syb+"~n"+ls_error_text_sql+"~n"+ls_error_text_sql2,StopSign!)
		else
			commit using gtr_sce;
			commit using itr_web;
			messagebox("Confirmación","Ha cambiado su contraseña exitosamente",Information!)
		end if		
//	end if
end if

end event

