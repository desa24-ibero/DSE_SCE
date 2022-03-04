$PBExportHeader$w_cambio_nip_password_2013.srw
$PBExportComments$Despliegue de datos academicos de un alumno (Carrera, Semestre, Subsistema, Fecha de Ingreso, Fecha de Egreso,.....)
forward
global type w_cambio_nip_password_2013 from w_master_main
end type
type uo_nombre from uo_nombre_alumno_2013 within w_cambio_nip_password_2013
end type
type dw_alumno_cambio_password from datawindow within w_cambio_nip_password_2013
end type
type cb_1 from commandbutton within w_cambio_nip_password_2013
end type
type iuo_foto_alumno_blob from uo_foto_alumno_blob within w_cambio_nip_password_2013
end type
type st_1 from statictext within w_cambio_nip_password_2013
end type
type rr_1 from roundrectangle within w_cambio_nip_password_2013
end type
type sle_nip_2 from singlelineedit within w_cambio_nip_password_2013
end type
type sle_nip_1 from singlelineedit within w_cambio_nip_password_2013
end type
type st_2 from statictext within w_cambio_nip_password_2013
end type
type st_3 from statictext within w_cambio_nip_password_2013
end type
type sle_nip_a from singlelineedit within w_cambio_nip_password_2013
end type
type sle_nip_b from singlelineedit within w_cambio_nip_password_2013
end type
type dw_nuevo_pwd from datawindow within w_cambio_nip_password_2013
end type
type dw_ws_actualiza_password from datawindow within w_cambio_nip_password_2013
end type
type dw_ws_valida_bloqueo from datawindow within w_cambio_nip_password_2013
end type
type st_4 from statictext within w_cambio_nip_password_2013
end type
type rr_2 from roundrectangle within w_cambio_nip_password_2013
end type
type rr_3 from roundrectangle within w_cambio_nip_password_2013
end type
end forward

global type w_cambio_nip_password_2013 from w_master_main
integer x = 5
integer y = 4
integer width = 4238
integer height = 2780
string title = "Cambio de NIP a PASSWORD"
string menuname = "m_menu_constancias_2013"
boolean center = true
uo_nombre uo_nombre
dw_alumno_cambio_password dw_alumno_cambio_password
cb_1 cb_1
iuo_foto_alumno_blob iuo_foto_alumno_blob
st_1 st_1
rr_1 rr_1
sle_nip_2 sle_nip_2
sle_nip_1 sle_nip_1
st_2 st_2
st_3 st_3
sle_nip_a sle_nip_a
sle_nip_b sle_nip_b
dw_nuevo_pwd dw_nuevo_pwd
dw_ws_actualiza_password dw_ws_actualiza_password
dw_ws_valida_bloqueo dw_ws_valida_bloqueo
st_4 st_4
rr_2 rr_2
rr_3 rr_3
end type
global w_cambio_nip_password_2013 w_cambio_nip_password_2013

type variables
long il_cuenta, il_rows_alumno_cambio_password = 0
transaction itr_web, itr_scred
string  is_filename = ""

end variables

forward prototypes
public subroutine f_alumno_cambio_password ()
public function integer f_valida_bloqueo (long al_cuenta)
public function long f_obtiene_nvo_status_usuario (long ar_cuenta, string ar_digito)
public function integer f_actualiza_password (long ar_cuenta, string ar_digito, integer ar_req_email, string ar_password_actual)
end prototypes

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

/***********************      Roberto Novoa 31/Mar/2016      **********************
ll_cve_pregunta_secreta = dw_alumno_cambio_password.GetItemNumber(ll_row, "cve_pregunta_secreta")
ls_respuesta_secreta  = dw_alumno_cambio_password.GetItemString(ll_row, "respuesta_secreta")
ls_email  = dw_alumno_cambio_password.GetItemString(ll_row, "email")
ls_telefono_celular  = dw_alumno_cambio_password.GetItemString(ll_row, "telefono_celular")
ls_telefono_domicilio  = dw_alumno_cambio_password.GetItemString(ll_row, "telefono_domicilio")
ls_curp  = dw_alumno_cambio_password.GetItemString(ll_row, "curp")
ls_rfc  = dw_alumno_cambio_password.GetItemString(ll_row, "rfc")
*/


/********  LLENAMOS LAS VARIABLES QUE INSERTA A LA VISTA  "web_bd.dbo.v_www_alumno_cambio_password"  ************/
ll_cve_pregunta_secreta = 1
ls_respuesta_secreta  = ''
ls_email  = ''
ls_telefono_celular  = ''
ls_telefono_domicilio  = ''
ls_curp  = ''
ls_rfc  = ''


IF il_rows_alumno_cambio_password>0 THEN
//ACTUALIZA EL REGISTRO EXISTENTE

/******** SE COMENTA LA ACTUALIZACIÓN PARA EVITAR QUE SE BLANQUEEN LOS CAMPOS EXISTENTES 
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
*/	
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

public function integer f_valida_bloqueo (long al_cuenta);String ls_error_text_sql2, ls_password, ls_nip2, ls_digito, ls_nombre='ws_cambio_password_upd.cfc?WSDL'
Integer li_error_code_sql2, li_count, li_result
long ll_cuenta

ls_password=sle_nip_2.text

//Voy a validar si no es un usuario con estatus bloqueado
SELECT count(*)
INTO :li_count
FROM obj_config_sys_bit
WHERE cuenta = :al_cuenta
AND estatus = 1
AND bloqueo = 2 Using itr_web;

ls_error_text_sql2 = itr_web.sqlerrtext
li_error_code_sql2 = itr_web.SqlCode
if isnull(ls_error_text_sql2) then ls_error_text_sql2=""
If IsNull(li_count) Then  li_count = 0

If li_error_code_sql2 <> 0 Then
	MessageBox('Alerta del Sistema', 'No se pudo validar si es un usuario bloqueado' + ls_error_text_sql2, StopSign!)
	return -1
End If

//Actualizamos el estatus para desbloquear al alumno
If li_count >= 1 Then
	
	/*Consumimos el webservice que manda informacion de la ip, necesaria para desbloquear al usuario */
	li_result = dw_ws_valida_bloqueo.retrieve(al_cuenta, '1', '1')
	
	UPDATE obj_config_sys_bit 
		 SET bloqueo = NULL 
	 WHERE cuenta =:al_cuenta
		 AND estatus = 1
		 AND bloqueo = 2 Using itr_web;
	 
	ls_error_text_sql2 = itr_web.sqlerrtext
	li_error_code_sql2 = itr_web.SqlCode
	if isnull(ls_error_text_sql2) then ls_error_text_sql2=""
	if li_error_code_sql2=-1 then
		messagebox('Aviso:', 'Existió un error en la actualización del bloqueo')
		rollback using itr_web;
		return li_error_code_sql2
	end if
End If

//Validamos si existen registros en la tabla de intentos
SELECT count(*)
   INTO :li_count
  FROM obj_config_sys_intentos
 WHERE estatus IN (1, 2)
     AND cuenta =:al_cuenta
  USING itr_web;

ls_error_text_sql2 = itr_web.sqlerrtext
li_error_code_sql2 = itr_web.SqlCode
if isnull(ls_error_text_sql2) then ls_error_text_sql2=""
if isnull(li_count) then li_count=0
if li_error_code_sql2=-1 then
	messagebox('Aviso:', 'Error en la consultar la tabla de intentos obj_config_sys_intentos')
	return li_error_code_sql2
end if

//Actualizamos el estatus en la tabla de intentos
If li_count>= 1 Then
	UPDATE obj_config_sys_intentos
			SET estatus = 0
	 WHERE estatus IN (1, 2)
		  AND cuenta =:al_cuenta
	  USING itr_web;
	
	ls_error_text_sql2 = itr_web.sqlerrtext
	li_error_code_sql2 = itr_web.SqlCode
	if isnull(ls_error_text_sql2) then ls_error_text_sql2=""
	if li_error_code_sql2=-1 then
		messagebox('Aviso:', 'Existió un error en la actualización de intentos')
		return li_error_code_sql2
	end if
End if

//Validamos si existen registros en la tabla de intentos
SELECT count(*) 
   INTO :li_count
  FROM obj_bit_recuperacion
 WHERE estatus = 1
     AND cuenta =:al_cuenta
  USING itr_web;

ls_error_text_sql2 = itr_web.sqlerrtext
li_error_code_sql2 = itr_web.SqlCode
if isnull(li_count) then li_count=0
if isnull(ls_error_text_sql2) then ls_error_text_sql2=""
if li_error_code_sql2=-1 then
	messagebox('Aviso:', 'Existió un error al consultar la tabla de recuperación (obj_config_sys_bit_recuperacion)')
	return li_error_code_sql2
end if

//Actualizamos el estatus en la tabla de recuperación
If li_count>= 1 Then
	UPDATE obj_bit_recuperacion
			SET estatus = 0
	 WHERE estatus = 1
		  AND cuenta =:al_cuenta
	  USING itr_web;
	
	ls_error_text_sql2 = itr_web.sqlerrtext
	li_error_code_sql2 = itr_web.SqlCode
	if isnull(ls_error_text_sql2) then ls_error_text_sql2=""
	if li_error_code_sql2=-1 then
		messagebox('Aviso:', 'Existió un error en la actualización de recuperación')
		return li_error_code_sql2
	end if
End If

Return 0
end function

public function long f_obtiene_nvo_status_usuario (long ar_cuenta, string ar_digito);/*Esta funcion actualiza la informacion del alumno para poder accesar al portal de servcios en linea, considerando el nuevo esquema de seguridad para Tijuana y CDMX 2016*/
/*Abr2016 SFF*/

String ls_nip2, ls_password, ls_error_text_sql2, ls_result, ls_correo1
Integer li_error_code_sql2, li_count, li_result, li_requiere_email

li_requiere_email = 0

// Vamos a determinar si el alumnno es regular, es decir ya existe en tabla de nips pero NO en nuevo esquema de contraseñas
SELECT nip2, password 
INTO :ls_nip2, :ls_password
FROM controlescolar_bd.dbo.nips 
WHERE cuenta=:ar_cuenta Using itr_web;

ls_error_text_sql2 = itr_web.sqlerrtext
li_error_code_sql2 = itr_web.SqlCode
if isnull(ls_error_text_sql2) then ls_error_text_sql2=""
If IsNull(ls_nip2) Then ls_nip2 = '' 
If IsNull(ls_password) Then ls_password = '' 

If li_error_code_sql2 <> 0 Then
	MessageBox('Alerta del Sistema', 'No se pudo obtener consulta de contraseña en nips '+ ls_error_text_sql2, StopSign!)
	return -1
End If

If li_error_code_sql2 = 0 Then

	//Si si tiene password
	If ls_password <> '' Then 
		//Verificamos si ya existe en nuevo esquema de contraseñas
		SELECT count(*)
		INTO :li_count
		FROM obj_config_sys_bit 
		WHERE cuenta = :ar_cuenta
		Using itr_web;
		
		ls_error_text_sql2 = itr_web.sqlerrtext
		li_error_code_sql2 = itr_web.SqlCode
		if isnull(ls_error_text_sql2) then ls_error_text_sql2=""
		If IsNull(li_count) Then  li_count = 0
	
		If li_error_code_sql2 <> 0 Then
			MessageBox('Alerta del Sistema', 'No se pudo obtener consulta de obj_config_sys_bit ' + ls_error_text_sql2, StopSign!)
			return -1
		End If
		
		//Si ya existen registros en nuevo esquema de contraseñas
		If li_count > 0 Then 
			
			//Voy a validar si no es un usuario con estatus bloqueado
			SELECT count(*)
			INTO :li_count
			FROM obj_config_sys_bit
			WHERE cuenta = :ar_cuenta
			AND estatus = 1
			AND bloqueo = 2 Using itr_web;
			
			ls_error_text_sql2 = itr_web.sqlerrtext
			li_error_code_sql2 = itr_web.SqlCode
			if isnull(ls_error_text_sql2) then ls_error_text_sql2=""
			If IsNull(li_count) Then  li_count = 0
		
			If li_error_code_sql2 <> 0 Then
				MessageBox('Alerta del Sistema', 'No se pudo validar si es un usuario bloqueado' + ls_error_text_sql2, StopSign!)
				return -1
			End If

			//Si esta bloqueado el alumno
			If li_count >= 1 Then
				//Procedemos a desbloquear al alumno
				li_result = f_valida_bloqueo (ar_cuenta)
				If li_result = -1  Then
					rollback using gtr_sce;
					rollback using itr_web;
					return -1
				End If
			End If

			//Voy a validar si ya cuenta con correo electrónico
			SELECT count(*)
			INTO :li_count
			FROM cuentas_email 
			WHERE cuenta = :ar_cuenta
			Using itr_web;
		
			ls_error_text_sql2 = itr_web.sqlerrtext
			li_error_code_sql2 = itr_web.SqlCode
			if isnull(ls_error_text_sql2) then ls_error_text_sql2=""
			If IsNull(li_count) Then  li_count = 0
		
			If li_error_code_sql2 <> 0 Then
				MessageBox('Alerta del Sistema', 'No se pudo obtener consulta de cuentas_email ' + ls_error_text_sql2, StopSign!)
				return -1
			End If
			
			If li_count >= 1 Then 
				li_requiere_email = 0
			Else
				li_requiere_email = 1
				/*Validamos que en verdad se haya introducido en el formulario el email requerido*/
				ls_correo1=dw_nuevo_pwd.getitemstring(dw_nuevo_pwd.getrow(),'mail_1')
				If IsNull(ls_correo1) Then ls_correo1 = ""
				If (ls_correo1 = "")  Then
					rollback using gtr_sce;
					rollback using itr_web;
					Messagebox('Mensaje del Sistema','Es necesario introducir el correo electrónico...', Stopsign!)
					return -1
				End If
			End If
			
			//Se ejecuta actualizacion de password atraves de webservice
			li_result = f_actualiza_password (ar_cuenta, ar_digito, li_requiere_email, ls_password)
			If li_result <> 0 Then 
				return -1
			End If

			//Se valida resultado
			//Se actualiza información en SYBASE
		Else //No existe info en nuevo esquema de contraseñas

			  li_requiere_email = 1
			  
			/*Validamos que en verdad se haya introducido en el formulario el email requerido*/
			ls_correo1=dw_nuevo_pwd.getitemstring(dw_nuevo_pwd.getrow(),'mail_1')
			If IsNull(ls_correo1) Then ls_correo1 = ""
			If (ls_correo1 = "")  Then
				rollback using gtr_sce;
				rollback using itr_web;
				Messagebox('Mensaje del Sistema','Es necesario introducir el correo electrónico...', Stopsign!)
				return -1
			End If
			  
			//Se ejecuta actualizacion de password atraves de webservice
			li_result = f_actualiza_password (ar_cuenta, ar_digito, li_requiere_email, ls_password)
			If li_result <> 0 Then 
				return -1
			End If
			
			//Se actualiza información en SYBASE
		End If
		
	Else	//En caso de no contar con contraseña
			//Solo se actualizara Nip2 del Usuario
		return 2
	End If
	
End If

return li_result
end function

public function integer f_actualiza_password (long ar_cuenta, string ar_digito, integer ar_req_email, string ar_password_actual);//En esta función se va a realizar la actualizacion tanto en WEB como en Sybase
String ls_result, ls_web_service, ls_ws_mensaje
Integer li_resultado, li_row, li_result, li_ws_codigo

Long ll_usuario 
String ls_contrasenia_nva, ls_conf_contrasenia_nva, ls_contrasenia_anterior, ls_email_alterno, ls_email, ls_digito_verificador
Integer li_tipo_forma
String ls_conf_email, ls_peticion, ls_referencia

long li_numtot
integer li_pos_ini , li_pos_fin, iIndex, iPosini, iPosfin, iMaxLen
string sAsterisco, sCadena, sResultado,  ls_Array_Nivel[]


/*******   OBTIENE LA RUTA DONDE SE ENCUENTRA EL WEB-SERVICE   ********/
//SELECT obj_config_sys.cont_config_sys 
//INTO :ls_web_service 
//FROM obj_config_sys
//WHERE obj_config_sys.id_obj_config_sys=4 USING itr_web;
//
//ls_web_service=ls_web_service+'ws_cambio_password_upd.cfc?WSDL'

ls_result = ''
li_ws_codigo = -1
li_row = dw_nuevo_pwd.getrow( )

ll_usuario = ar_cuenta
ls_contrasenia_nva = dw_nuevo_pwd.getitemstring(li_row, "pwd_1")
ls_conf_contrasenia_nva = dw_nuevo_pwd.getitemstring(li_row, "pwd_2")
ls_contrasenia_anterior = ar_password_actual
ls_email_alterno = dw_nuevo_pwd.getitemstring(li_row, "mail_3")
ls_email = dw_nuevo_pwd.getitemstring(li_row, "mail_1")
ls_conf_email = dw_nuevo_pwd.getitemstring(li_row, "mail_2")
//Validamos si se requiere el email
If ar_req_email = 1 Then
	li_tipo_forma = 0
Else
	li_tipo_forma = 1
	SetNull(ls_email_alterno)
	SetNull(ls_email)
	SetNull(ls_conf_email)	
End If

ls_digito_verificador = ar_digito
ls_peticion = '1'
ls_referencia = '1'

//Ejecutamos el WEBSERVICE
li_result  = dw_ws_actualiza_password.retrieve(ll_usuario, ls_contrasenia_nva, ls_conf_contrasenia_nva, ls_contrasenia_anterior, ls_email_alterno, ls_email, li_tipo_forma, ls_conf_email, ls_digito_verificador, ls_peticion, ls_referencia )

If li_result <> 1 Then 
	MessageBox('Mensaje del Sistema','No fue satisfactoria la ejecución al intentar actualizar la contraseña en web_bd (dw_u_cambio_pwd_web)', StopSign!)
	return -1
End If 


If li_result = 1  And dw_ws_actualiza_password.rowcount() = 1 Then

	ls_result = dw_ws_actualiza_password.getitemstring( dw_ws_actualiza_password.getrow(), 'returnvalue')
	sCadena = ls_result
	sAsterisco = '.-'
	iIndex = 1
	iPosini  = 1
	
	iMaxLen = Len(sCadena)
		 
	Do  While Pos(sCadena, sAsterisco) > 0 
		iPosfin    = Pos(sCadena, sAsterisco)
		sResultado = Mid(sCadena, iPosini, iPosfin - 1)
		sCadena    = Mid(sCadena, iPosfin + 1, len(sCadena))
		ls_Array_Nivel[iIndex] = sResultado
		iIndex  = iIndex  + 1
	Loop                  
	
		sResultado = Mid(sCadena, iPosfin, iMaxLen)
		ls_Array_Nivel[iIndex] = sResultado	
	
	If UpperBound(ls_Array_Nivel[]) > 0 then
		li_ws_codigo = Integer(ls_Array_Nivel[1])
		ls_ws_mensaje = ls_Array_Nivel[2]
		MessageBox('Mensaje del Sistema','Codigo recibido de proceso que actualiza contraseña: ' + string(li_ws_codigo) + '. ' + ls_ws_mensaje, Information!)
	Else
		MessageBox('Mensaje del Sistema','Error al intentar actualizar la contraseña ' + ls_ws_mensaje, StopSign!)
		return -1
	End IF
End If	

return li_ws_codigo
end function

on w_cambio_nip_password_2013.create
int iCurrent
call super::create
if this.MenuName = "m_menu_constancias_2013" then this.MenuID = create m_menu_constancias_2013
this.uo_nombre=create uo_nombre
this.dw_alumno_cambio_password=create dw_alumno_cambio_password
this.cb_1=create cb_1
this.iuo_foto_alumno_blob=create iuo_foto_alumno_blob
this.st_1=create st_1
this.rr_1=create rr_1
this.sle_nip_2=create sle_nip_2
this.sle_nip_1=create sle_nip_1
this.st_2=create st_2
this.st_3=create st_3
this.sle_nip_a=create sle_nip_a
this.sle_nip_b=create sle_nip_b
this.dw_nuevo_pwd=create dw_nuevo_pwd
this.dw_ws_actualiza_password=create dw_ws_actualiza_password
this.dw_ws_valida_bloqueo=create dw_ws_valida_bloqueo
this.st_4=create st_4
this.rr_2=create rr_2
this.rr_3=create rr_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_nombre
this.Control[iCurrent+2]=this.dw_alumno_cambio_password
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.iuo_foto_alumno_blob
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.rr_1
this.Control[iCurrent+7]=this.sle_nip_2
this.Control[iCurrent+8]=this.sle_nip_1
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.sle_nip_a
this.Control[iCurrent+12]=this.sle_nip_b
this.Control[iCurrent+13]=this.dw_nuevo_pwd
this.Control[iCurrent+14]=this.dw_ws_actualiza_password
this.Control[iCurrent+15]=this.dw_ws_valida_bloqueo
this.Control[iCurrent+16]=this.st_4
this.Control[iCurrent+17]=this.rr_2
this.Control[iCurrent+18]=this.rr_3
end on

on w_cambio_nip_password_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nombre)
destroy(this.dw_alumno_cambio_password)
destroy(this.cb_1)
destroy(this.iuo_foto_alumno_blob)
destroy(this.st_1)
destroy(this.rr_1)
destroy(this.sle_nip_2)
destroy(this.sle_nip_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.sle_nip_a)
destroy(this.sle_nip_b)
destroy(this.dw_nuevo_pwd)
destroy(this.dw_ws_actualiza_password)
destroy(this.dw_ws_valida_bloqueo)
destroy(this.st_4)
destroy(this.rr_2)
destroy(this.rr_3)
end on

event close;if isvalid(itr_web) then
	if desconecta_bd(itr_web) <> 1 then
		return
	end if
end if


if isvalid(itr_scred) then
	if desconecta_bd(itr_scred) <> 1 then
		return
	end if
end if

end event

event closequery;//
end event

event open;call super::open;string ls_servidor_syb

sle_nip_1.enabled=false
sle_nip_2.enabled=false

sle_nip_1.text=''
sle_nip_2.text=''

dw_nuevo_pwd.insertrow(0)

if conecta_bd(itr_scred,gs_scred, gs_usuario,gs_password)<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de credenciales_bd", StopSign!)
	close(this)
end if

IF IsValid(This) THEN
	//if conecta_bd(itr_web,gs_web_desb, 'sa','desarrollo')<>1 then
	if conecta_bd(itr_web,gs_web_desb, gs_usuario,gs_password)<>1 then
		MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
		close(this)
	else 
		dw_alumno_cambio_password.SetTransObject(itr_web)
	end if

	IF IsValid(This) THEN 
		ls_servidor_syb = UPPER(gtr_sce.servername)

		/*Aqui se asigna el DW que consume el wevservice dependiendo del ambiente al que este conectado, tanto servidor como plantel*/
		choose case ls_servidor_syb
			case 'SYBCESPROTIJ'
				dw_ws_actualiza_password.dataobject = 'ws_u_cambio_pwd_tij_pro'
				dw_ws_valida_bloqueo.dataobject = 'ws_valida_bloqueo_tij_pro'		
			case 'SYBCESPRUTIJ'
				dw_ws_actualiza_password.dataobject = 'ws_u_cambio_pwd_tij_pru'
				dw_ws_valida_bloqueo.dataobject = 'ws_valida_bloqueo_tij_pru'
			case 'SYBCESPRO'
				dw_ws_actualiza_password.dataobject = 'ws_u_cambio_pwd_pro'
				dw_ws_valida_bloqueo.dataobject = 'ws_valida_bloqueo_pro'		
			case 'SYBCESPRU'
				dw_ws_actualiza_password.dataobject = 'ws_u_cambio_pwd_pru'
				dw_ws_valida_bloqueo.dataobject = 'ws_valida_bloqueo_pru'
			case else  /*No se encuentra en que plantel esta firmado*/
				cb_1.enabled = False
		end choose
	END IF			
END IF	
end event

event doubleclicked;call super::doubleclicked;/*
DESCRIPCIÓN: Cuando se capture el número de cuenta ponlo en la variable i_lo_cuenta.
				 Habilita sle_1 para que se capture el nuevo nip.
PARÁMETROS: Message.LongParm
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
LONG ll_rows , ll_row_actual
string ls_filename, ls_servidor_syb
il_cuenta = uo_nombre.of_obten_cuenta()


ls_servidor_syb = UPPER(gtr_sce.servername)



if il_cuenta > 0 then
	If (ls_servidor_syb = 'SYBCESPRO') Or  (ls_servidor_syb = 'SYBCESPRU') Or (ls_servidor_syb = 'SYBCESDES')Then 
//		ls_filename = iuo_foto_alumno_blob.of_loadPhoto(il_cuenta,1, gtr_scred, 0)
		ls_filename = iuo_foto_alumno_blob.of_loadPhoto(il_cuenta,1, itr_scred, 0)
	End If
	ls_filename = "photo_"+string(il_cuenta)+".jpg"
	is_filename =ls_filename
	sle_nip_1.enabled=true
	sle_nip_2.enabled=false
 
	sle_nip_1.setfocus()
else  
	is_filename = ""
end if

sle_nip_1.text=''
sle_nip_2.text=''

ll_rows = dw_alumno_cambio_password.retrieve(il_cuenta)
il_rows_alumno_cambio_password = ll_rows
IF ll_rows= 0 THEN
	dw_alumno_cambio_password.InsertRow(0)
	ll_row_actual = dw_alumno_cambio_password.GetRow()
	dw_alumno_cambio_password.SetItem(ll_row_actual, "cuenta", il_cuenta)
END IF
end event

type st_sistema from w_master_main`st_sistema within w_cambio_nip_password_2013
end type

type p_ibero from w_master_main`p_ibero within w_cambio_nip_password_2013
end type

type uo_nombre from uo_nombre_alumno_2013 within w_cambio_nip_password_2013
event destroy ( )
integer x = 599
integer y = 328
boolean bringtotop = true
end type

on uo_nombre.destroy
call uo_nombre_alumno_2013::destroy
end on

event constructor;call super::constructor;m_menu_constancias_2013.objeto = this
end event

type dw_alumno_cambio_password from datawindow within w_cambio_nip_password_2013
boolean visible = false
integer x = 73
integer y = 1756
integer width = 1074
integer height = 612
integer taborder = 50
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "d_alumno_cambio_password_2013"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_cambio_nip_password_2013
integer x = 1650
integer y = 2332
integer width = 718
integer height = 112
integer taborder = 60
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
integer li_nip_detectado, li_password_valido, li_count, li_result
integer li_error_code_syb, li_error_code_sql, li_error_code_sql2
string ls_error_text_syb, ls_error_text_sql, ls_error_text_sql2, ls_ruta, ls_web_service, ls_digito

long ll_cuenta , ll_cve_profesor , ll_folio , ll_cve_pregunta_secreta 
string ls_cve_tipo_usuario ="A", ls_respuesta_secreta , ls_email , ls_telefono_celular 
string ls_telefono_domicilio , ls_curp , ls_rfc, ls_nip2
String ls_pwd1, ls_pwd2, ls_correo1, ls_correo2, ls_correo3
datetime ls_fecha     
long ll_row 

ll_row = dw_alumno_cambio_password.GetRow()
dw_alumno_cambio_password.AcceptText()

ls_cve_tipo_usuario = "A"
ll_cuenta = dw_alumno_cambio_password.GetItemNumber(ll_row, "cuenta")

/********   Valida que la información ingresada no tenga diferencias   ******/
dw_nuevo_pwd.accepttext()

ls_pwd1=dw_nuevo_pwd.getitemstring(1,'pwd_1')
ls_pwd2=dw_nuevo_pwd.getitemstring(1,'pwd_2')
ls_correo1=dw_nuevo_pwd.getitemstring(1,'mail_1')
ls_correo2=dw_nuevo_pwd.getitemstring(1,'mail_2')
ls_correo3=dw_nuevo_pwd.getitemstring(1,'mail_3')

if ls_pwd1<>ls_pwd2 then
	Messagebox('Aviso:','No concuerda el Password, vuelve a intentarlo!', Stopsign!)
	dw_nuevo_pwd.setitem(1,'pwd_2','')
	dw_nuevo_pwd.setcolumn(2)
	dw_nuevo_pwd.setfocus()
	return
end if

if ls_correo1<>ls_correo2 then
	Messagebox('Aviso:','No concuerda el correo, vuelve a intentarlo!', Stopsign!)
	dw_nuevo_pwd.setitem(1,'mail_2','')
	dw_nuevo_pwd.setcolumn(4)
	dw_nuevo_pwd.setfocus()
	return
end if

//Validamos que exista la información de seguridad del alumno en sybase, tabla nips
SELECT count(*)
INTO :li_count
FROM controlescolar_bd.dbo.nips 
WHERE cuenta=:ll_cuenta USING gtr_sce;
ls_error_text_syb = gtr_sce.sqlerrtext
li_error_code_syb = gtr_sce.SqlCode
if isnull(ls_error_text_syb) then ls_error_text_syb=""
if isnull(li_count) then li_count=0

if (li_error_code_syb = -1)  then
	messagebox("Error al consultar Contraseña en Sybase",ls_error_text_syb+"~n"+ls_error_text_sql+"~n"+ls_error_text_sql2,StopSign!)
	return
End If

if (li_count = 0)  then
	messagebox("Error al consultar Contraseña en Sybase",ls_error_text_syb+"~n"+ls_error_text_sql+"~n"+ls_error_text_sql2,StopSign!)
	return
End If


/**********   Obtiene el dígito verificador   *********/
SELECT digito into :ls_digito FROM v_sce_alumno_digito
WHERE cuenta = :ll_cuenta Using gtr_sce;

/**********   Se ejecuta la funcion para validar si se actualizara contaseña basanndose en nuevo esquema de contraseñas 2016   *********/
li_result = f_obtiene_nvo_status_usuario (ll_cuenta, ls_digito)

If li_result  = -1  Then
	rollback using gtr_sce;
	rollback using itr_web;
	return
End If


/**********   Si fue exitosa la actualización de la contraseña en web, actualizo el mismo campo en Sybase   *********/
If li_result = 0 Then
	SELECT count(*)
	INTO :li_count
	FROM controlescolar_bd.dbo.nips 
	WHERE cuenta=:ll_cuenta USING gtr_sce;
	ls_error_text_syb = gtr_sce.sqlerrtext
	li_error_code_syb = gtr_sce.SqlCode
	if isnull(ls_error_text_syb) then ls_error_text_syb=""
	if isnull(li_count) then li_count=0
	
	if (li_error_code_syb = -1)  then
		rollback using gtr_sce;
		rollback using itr_web;
		messagebox("Error en Cambio de Contraseña en Sybase",ls_error_text_syb+"~n"+ls_error_text_sql+"~n"+ls_error_text_sql2,StopSign!)
		return
	End If

	If 	li_count >= 1 Then 
		UPDATE controlescolar_bd.dbo.nips 
		SET password=:ls_pwd1,
		fecha = getdate(),
		transferencia_pendiente = 0,
		transferencia_pendiente_web = 0
		WHERE cuenta=:ll_cuenta USING gtr_sce;
		ls_error_text_syb = gtr_sce.sqlerrtext
		li_error_code_syb = gtr_sce.SqlCode
		if isnull(ls_error_text_syb) then ls_error_text_syb=""
		
		if (li_error_code_syb = -1)  then
			rollback using gtr_sce;
			rollback using itr_web;
			messagebox("Error en Cambio de Contraseña en Sybase ",ls_error_text_syb+"~n"+ls_error_text_sql+"~n"+ls_error_text_sql2,StopSign!)
			return
		End If
	Else
		rollback using gtr_sce;
		rollback using itr_web;
		messagebox("Error en Cambio de Contraseña en Sybase, no se encontro información de contraseña para esta cuenta ",ls_error_text_syb+"~n"+ls_error_text_sql+"~n"+ls_error_text_sql2,StopSign!)
		return
	End If
End If

If li_result = 0 Or li_result = 2 Then
	/**********   Obtiene el nip2 del alumno   *********/
	SELECT Substring(convert(char(10),fecha_nac,3),1,2)+Substring(convert(char(10),fecha_nac,3),4,2) into :ls_nip2 from alumnos
s	where cuenta=:ll_cuenta Using gtr_sce;


// aqui cph	
	/**********   Actualiza el campo nip2 en Sybase   *********/
	UPDATE controlescolar_bd.dbo.nips 
	SET nip2=:ls_nip2,
	password=:ls_pwd1, // se actualiza el password tambien, se consulto con Antonio Pica. cph abril de 2021
	fecha = getdate(),
	transferencia_pendiente = 0,
	transferencia_pendiente_web = 0
	WHERE cuenta=:ll_cuenta USING gtr_sce;
	ls_error_text_syb = gtr_sce.sqlerrtext
	li_error_code_syb = gtr_sce.SqlCode
	if isnull(ls_error_text_syb) then ls_error_text_syb=""
	
	/**********   Actualiza el campo nip2 en WEB_DB   *********/
	UPDATE controlescolar_bd.dbo.nips 
	SET nip2=:ls_nip2,
	password=:ls_pwd1, // se actualiza el password tambien, se consulto con Antonio Pica. cph abril de 2021
	fecha = getdate(),
	transferencia_pendiente = 0,
	transferencia_pendiente_web = 0
	WHERE cuenta=:ll_cuenta USING itr_web;
	
	ls_error_text_sql2 = itr_web.sqlerrtext
	li_error_code_sql2 = itr_web.SqlCode
	if isnull(ls_error_text_sql2) then ls_error_text_sql2=""
	
	if (li_error_code_syb = -1) or (li_error_code_sql = -1) or (li_error_code_sql2 = -1) then
		rollback using gtr_sce;
		rollback using itr_web;
		messagebox("Error en Cambio de NIP",ls_error_text_syb+"~n"+ls_error_text_sql+"~n"+ls_error_text_sql2,StopSign!)
		return
	end if
	
	if (li_error_code_syb = -1) or (li_error_code_sql = -1) or (li_error_code_sql2 = -1) then
		rollback using gtr_sce;
		rollback using itr_web;
		messagebox("Error en Cambio de NIP",ls_error_text_syb+"~n"+ls_error_text_sql+"~n"+ls_error_text_sql2,StopSign!)
	else
		commit using gtr_sce;
		commit using itr_web;
		messagebox("Confirmación","Ha cambiado su contraseña exitosamente",Information!)
		dw_nuevo_pwd.reset( )
		dw_nuevo_pwd.insertrow(0)
		uo_nombre.em_cuenta.text = ''
		uo_nombre.em_digito.text = ''
		uo_nombre.dw_nombre_alumno.reset()
		uo_nombre.dw_nombre_alumno.insertrow(0)
		iuo_foto_alumno_blob.p_photo.picturename = ''
	end if		
End If


/***********   BORRA Y ACTUALIZA LOS REGISTROS BLOQUEADOS DEL ALUMNO   **********/
//li_error_code_sql2 = f_valida_bloqueo(ll_cuenta)
//
//if li_error_code_sql2=-1 then
//	Messagebox('Aviso:','No se desbloqueó el alumno')
//	return
//end if
//



/************************************************************************************
		SE COMENTAN LAS VALIDACIONES Y LAS ACCIONES ANTERIORES AL WEB-SERVICE
		=======================================================


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
sle_nip_b.enabled=false

if sle_nip_a.text<>sle_nip_b.text then
	messagebox("Vuelve a intentarlo","No concuerda el Nip")
	sle_nip_a.enabled=true
	return
end if


if sle_nip_1.text<>sle_nip_2.text then
	messagebox("Vuelve a intentarlo","No concuerda la contraseña")
	sle_nip_1.enabled=true
else
	ls_contrasenia_capturada = lower(sle_nip_2.text)
	
	ls_contrasenia_capturada = lower(ls_pwd2)
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
	end if
end if
*/
end event

type iuo_foto_alumno_blob from uo_foto_alumno_blob within w_cambio_nip_password_2013
event destroy ( )
integer x = 87
integer y = 324
integer width = 498
integer height = 492
boolean bringtotop = true
borderstyle borderstyle = stylebox!
end type

on iuo_foto_alumno_blob.destroy
call uo_foto_alumno_blob::destroy
end on

type st_1 from statictext within w_cambio_nip_password_2013
integer x = 1545
integer y = 716
integer width = 1321
integer height = 160
boolean bringtotop = true
integer textsize = -21
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Nueva Contraseña"
boolean focusrectangle = false
end type

type rr_1 from roundrectangle within w_cambio_nip_password_2013
boolean visible = false
integer linethickness = 4
long fillcolor = 12639424
integer x = 946
integer y = 720
integer width = 2286
integer height = 488
integer cornerheight = 40
integer cornerwidth = 46
end type

type sle_nip_2 from singlelineedit within w_cambio_nip_password_2013
boolean visible = false
integer x = 2139
integer y = 852
integer width = 942
integer height = 252
integer taborder = 20
boolean bringtotop = true
integer textsize = -26
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
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

event modified;
sle_nip_2.enabled=false
//sle_nip_2.enabled=true

sle_nip_a.setfocus()

///*
//DESCRIPCIÓN: Si concuerdan los nips y son válidos, actualízalos en la base de credenciales.
//PARÁMETROS: Ninguno
//REGRESA: Nada
//AUTOR: Víctor Manuel Iniestra Álvarez
//FECHA: 15 Junio 1998
//MODIFICACIÓN:
//*/
//long ll_nip
//string ls_nip, ls_nip_plano, ls_error_text
//integer li_nip_detectado, li_error_code
//
//sle_nip_2.enabled=false
//if sle_nip_1.text<>sle_nip_2.text then
//	messagebox("Aviso","No concuerda la contraseña")
//	sle_nip_1.enabled=true
//else
//	ll_nip=long(sle_nip_1.text)
//	if ll_nip<=0 then
//		messagebox("Aviso","La contraseña tiene que ser númerica")
//		sle_nip_1.enabled=true
//	else
//		ls_nip=sle_nip_1.text
//		ls_nip_plano = ls_nip
//		li_nip_detectado = 1
////		consulta_sie(ls_nip)
//		UPDATE nips
//		SET nip2 = :ls_nip_plano
//		WHERE nips.cuenta = :il_cuenta
//		USING gtr_sce;
//		ls_error_text =gtr_sce.sqlerrtext
//		li_error_code =gtr_sce.SqlCode
//		
//		if li_error_code= -1 then
//			rollback using gtr_sce;
//			messagebox("Error en Cambio de NIP",ls_error_text)
//		else
//			commit using gtr_sce;
//			messagebox("Aviso","Ha cambiado su contraseña")
//		end if		
//	end if
//end if
//
end event

type sle_nip_1 from singlelineedit within w_cambio_nip_password_2013
boolean visible = false
integer x = 1033
integer y = 852
integer width = 942
integer height = 252
integer taborder = 10
boolean bringtotop = true
integer textsize = -26
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
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

type st_2 from statictext within w_cambio_nip_password_2013
integer x = 1669
integer y = 1276
integer width = 224
integer height = 160
boolean bringtotop = true
integer textsize = -21
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Nip"
boolean focusrectangle = false
end type

type st_3 from statictext within w_cambio_nip_password_2013
integer x = 1961
integer y = 1296
integer width = 603
integer height = 100
boolean bringtotop = true
integer textsize = -15
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "(4 Dígitos 0-9)"
boolean focusrectangle = false
end type

type sle_nip_a from singlelineedit within w_cambio_nip_password_2013
integer x = 1678
integer y = 1444
integer width = 352
integer height = 172
integer taborder = 30
boolean bringtotop = true
integer textsize = -21
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean password = true
borderstyle borderstyle = styleraised!
end type

event modified;if len(text)<4 then
	Messagebox('Aviso:','El Nip debe de ser de 4 dígitos', StopSign!)
	return -1
end if


sle_nip_a.enabled=false
sle_nip_b.enabled=true


sle_nip_b.setfocus()
end event

event getfocus;text=""
end event

type sle_nip_b from singlelineedit within w_cambio_nip_password_2013
integer x = 2149
integer y = 1444
integer width = 352
integer height = 172
integer taborder = 40
boolean bringtotop = true
integer textsize = -21
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean password = true
borderstyle borderstyle = styleraised!
end type

event modified;if len(text)<4 then
	Messagebox('Aviso:','El Nip debe de ser de 4 dígitos',StopSign!)
	text=''
	return -1
end if

if sle_nip_a.text<>text then
	Messagebox('Aviso:','El Nip es diferente, vuelva a intentar...',StopSign!)
	sle_nip_a.text=''
	sle_nip_a.enabled=true
	text=''
	enabled=true
	sle_nip_a.setfocus()
//	return 
end if

sle_nip_b.enabled=false
cb_1.setfocus()


end event

type dw_nuevo_pwd from datawindow within w_cambio_nip_password_2013
integer x = 1056
integer y = 704
integer width = 1970
integer height = 1528
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "de_password"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_ws_actualiza_password from datawindow within w_cambio_nip_password_2013
boolean visible = false
integer x = 192
integer y = 996
integer width = 686
integer height = 400
integer taborder = 30
boolean bringtotop = true
string dataobject = "ws_u_cambio_pwd_tij_pru"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_ws_valida_bloqueo from datawindow within w_cambio_nip_password_2013
boolean visible = false
integer x = 3328
integer y = 920
integer width = 553
integer height = 312
integer taborder = 30
boolean bringtotop = true
string dataobject = "ws_valida_bloqueo_tij_pru"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_cambio_nip_password_2013
integer x = 2981
integer y = 2360
integer width = 480
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 33554432
long backcolor = 553648127
string text = "Ver. 13/abril/2021."
boolean focusrectangle = false
end type

type rr_2 from roundrectangle within w_cambio_nip_password_2013
integer linethickness = 4
long fillcolor = 12639424
integer x = 1449
integer y = 1260
integer width = 1294
integer height = 412
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_3 from roundrectangle within w_cambio_nip_password_2013
integer linethickness = 4
long fillcolor = 12639424
integer x = 1582
integer y = 2300
integer width = 864
integer height = 176
integer cornerheight = 40
integer cornerwidth = 46
end type

