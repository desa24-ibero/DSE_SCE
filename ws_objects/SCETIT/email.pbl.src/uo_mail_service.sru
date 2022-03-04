$PBExportHeader$uo_mail_service.sru
forward
global type uo_mail_service from nonvisualobject
end type
end forward

global type uo_mail_service from nonvisualobject
end type
global uo_mail_service uo_mail_service

type variables
string is_archivo_html, is_rutacompleta= ""
integer ii_numero_archivo_html, ii_longitud_archivo_html
end variables

forward prototypes
public function integer of_reemplaza_marca (ref string as_texto_origen, string as_nombre_marca, string as_texto_marca)
public function integer of_lee_archivo_html ()
public subroutine of_logoff_mail (mailsession ams_mses, string as_attach_name)
public function integer of_establece_directorio (ref string as_ruta_completa)
public function integer of_genera_html_opcion_cero (long al_cuentas[], long al_cve_carreras[], string as_nombres_completos[], string as_fechas_entrega[])
public function integer of_escribe_archivo (string as_nombre_archivo, string as_extension, string as_contenido)
public function integer of_genera_emails_opcion_cero (long al_cuentas[], long al_cve_carreras[], string as_email[])
end prototypes

public function integer of_reemplaza_marca (ref string as_texto_origen, string as_nombre_marca, string as_texto_marca);//of_reemplaza_marca
//Recibe un texto en el que busca un nombre de marca en formato <<nombre_marca>>
//y coloca una cadena en sustitucion de dicha marca
//Recibe	as_texto_origen	string
//			as_nombre_marca	string
//			as_texto_marca		string

string ls_inicio_marca="«", ls_fin_marca = "»"
string ls_marca_delimitada, ls_inicio_texto, ls_fin_texto 
long ll_posicion_inicial_marca, ll_tamanio_marca_delimitada

if len(as_nombre_marca)=0 or isnull(as_nombre_marca) then
	return 0
end if

if len(as_texto_marca)=0 or isnull(as_texto_marca) then
	as_texto_marca= ""
end if

ls_marca_delimitada = ls_inicio_marca +as_nombre_marca + ls_fin_marca
ll_tamanio_marca_delimitada = LEN(ls_marca_delimitada)
ll_posicion_inicial_marca = POS(as_texto_origen,ls_marca_delimitada)

if ll_posicion_inicial_marca > 0 then

	ls_inicio_texto = MID(as_texto_origen, 1, ll_posicion_inicial_marca -1)

	ls_fin_texto =MID(as_texto_origen, ll_posicion_inicial_marca + ll_tamanio_marca_delimitada)

	as_texto_origen = ls_inicio_texto + as_texto_marca +ls_fin_texto
else	
	return 0
end if

return 0
end function

public function integer of_lee_archivo_html ();//of_lee_archivo_html

string ls_docname, ls_named, ls_texto_archivo, ls_Emp_Input
integer li_value
integer li_FileNum, li_read, li_close
long ll_FLength, ll_tamanio_bloque = 32767


li_value = GetFileOpenName("Seleccione Archivo", &
		+ ls_docname, ls_named, "HTML", &
		+ "Archivos HTM (*.HTM),*.HTM," &
		+ "Archivos HTMl (*.HTML),*.HTML")

IF li_value = 1 THEN 
	ll_FLength = FileLength(ls_docname)
	ii_longitud_archivo_html= ll_FLength
	li_FileNum= FileOpen(ls_docname, StreamMode!, Read!, LockReadWrite! )
	ii_numero_archivo_html = li_FileNum
	IF ll_FLength < ll_tamanio_bloque THEN
		li_read = FileRead(li_FileNum, ls_Emp_Input)
		if li_read <>-1 and not isnull(li_read) then
			is_archivo_html= ls_Emp_Input
			li_close = FileClose(li_FileNum)
			if li_close =-1 or isnull(li_close) then
				MessageBox("Error al cerrar", "No es posible cerrar el archivo",StopSign!)
				return -1				
			end if			
		else
			MessageBox("Error de lectura", "No es posible leer el archivo",StopSign!)
			return -1
		end if
	END IF
ELSE 
	return li_value
END IF

return 0

end function

public subroutine of_logoff_mail (mailsession ams_mses, string as_attach_name);//of_logoff_mail
//Recibe: ams_mses			mailsession
//			as_attach_name		string

string 	ls_ret	
mailreturncode mRet

///*****************************************************************
//	Se sale del sistema de correo
// *****************************************************************/
mRet = ams_mSes.mailLogoff ( )
ls_ret = f_mail_error_to_string ( mRet, 'Logoff:', FALSE )
//st_status_bar.text = ' Logoff: ' + ls_ret

If mRet <> mailReturnSuccess! Then
	MessageBox ("Mail Logoff", 'Return Code <> mailReturnSuccess!' )
	return
End If

///*****************************************************************
//	Finalmente, destruye la session del objeto de correo creada 
//	con anterioridad.
//	Puede si asi se desea, borrar el archivo anexo temporal.
// *****************************************************************
destroy ams_mses


//FileDelete ( as_attach_name )


end subroutine

public function integer of_establece_directorio (ref string as_ruta_completa);//of_establece_directorio

string ls_docname, ls_named, ls_texto_archivo, ls_Emp_Input, ls_rutacompleta
integer li_value
integer li_FileNum
long ll_FLength, ll_tamanio_bloque = 32767, ll_pos_archivo


li_value = GetFileOpenName("Seleccione el Directorio de Trabajo con un Archivo", &
		+ ls_docname, ls_named)

IF li_value = 1 THEN 
	ll_FLength = FileLength(ls_docname)
ELSE 
	as_ruta_completa= ""
	return li_value
END IF
ll_pos_archivo= pos(ls_docname,ls_named)

ls_rutacompleta = mid(ls_docname,1,ll_pos_archivo -1 )
as_ruta_completa= ls_rutacompleta
return 0
end function

public function integer of_genera_html_opcion_cero (long al_cuentas[], long al_cve_carreras[], string as_nombres_completos[], string as_fechas_entrega[]);//of_genera_html_opcion_cero
//Recibe:	al_cuentas[]
//			al_cve_carreras[]
//			as_nombres_completos[]
//			as_fechas_entrega[]


long ll_tamanio_cuentas, ll_tamanio_carreras, ll_tamanio_nombres, ll_tamanio_fechas
long ll_indice, ll_indice_marcas
string ls_cuerpo_archivo, ls_nombre_archivo, ls_extension = "HTML"
string ls_nombre_completo, ls_fecha_entrega, ls_texto_archivo_html
string ls_marcas[2]={"nombre_completo","dia"}, ls_marca, ls_texto_reemplazo
string ls_rutacompleta

ll_tamanio_cuentas = upperbound(al_cuentas)
ll_tamanio_carreras = upperbound(al_cve_carreras)
ll_tamanio_nombres = upperbound(as_nombres_completos)
ll_tamanio_fechas = upperbound(as_fechas_entrega)

if ll_tamanio_cuentas<> ll_tamanio_carreras or &
   ll_tamanio_cuentas<> ll_tamanio_nombres or &
	ll_tamanio_cuentas<> ll_tamanio_fechas then
	MessageBox("Arreglos de distintos tamaños (html)","El tamaño de los arreglos de datos no coincide",Stopsign!)
	return -1
end if

if of_lee_archivo_html()= -1 then return -1
if of_establece_directorio(ls_rutacompleta)= -1 then return -1
is_rutacompleta = ls_rutacompleta
FOR ll_indice = 1 to ll_tamanio_cuentas
	ls_nombre_archivo = string(al_cuentas[ll_indice])+ "_"+string(al_cve_carreras[ll_indice])
	ls_nombre_completo = as_nombres_completos[ll_indice]
	ls_fecha_entrega= as_fechas_entrega[ll_indice]
	ls_texto_archivo_html = is_archivo_html
	of_reemplaza_marca(ls_texto_archivo_html, ls_marcas[1], ls_nombre_completo)
	of_reemplaza_marca(ls_texto_archivo_html, ls_marcas[2], ls_fecha_entrega)
	if of_escribe_archivo(ls_nombre_archivo, ls_extension, ls_texto_archivo_html)= -1 then
		MessageBox("No es posible continuar","No se ha podido generar a todos los archivos",Stopsign!)
		return -1
	end if
NEXT	
return 0

end function

public function integer of_escribe_archivo (string as_nombre_archivo, string as_extension, string as_contenido);//of_escribe_archivo
//Recibe:	as_nombre_archivo
//			as_extension
//			as_contenido

string ls_docname, ls_named, ls_texto_archivo, ls_Emp_Input, ls_nombre_completo
integer li_value
integer li_FileNum, li_write, li_close
long ll_FLength, ll_tamanio_bloque = 32767

ls_nombre_completo = as_nombre_archivo + "."+ as_extension

li_FileNum= FileOpen(ls_nombre_completo, StreamMode!, Write!, LockReadWrite!, Replace! )
	
li_write= FileWrite(li_FileNum, as_contenido)

if li_write = -1 then
	MessageBox("Error -1", "No es posible escribir el archivo ["+ls_nombre_completo+"]",StopSign!)
	return -1
elseif isnull(li_write) then
	MessageBox("Error Nulo", "No es posible escribir el archivo ["+ls_nombre_completo+"]",StopSign!)
	return -1
else
	li_close = FileClose(li_FileNum)
	if li_close = -1 then
		MessageBox("Error -1", "No es posible cerrar el archivo ["+ls_nombre_completo+"]",StopSign!)
		return -1
	elseif isnull(li_close) then
		MessageBox("Error Nulo", "No es posible cerrar el archivo ["+ls_nombre_completo+"]",StopSign!)
		return -1
	else
		return 0	
	end if
end if


return 0
end function

public function integer of_genera_emails_opcion_cero (long al_cuentas[], long al_cve_carreras[], string as_email[]);//of_genera_emails_opcion_cero
//Recibe:		al_cuentas[]		long
//				 	al_cve_carreras[]	long
//					as_email[] string
//Devuelve -1 si hubo algun error
//				0 si todo estuvo bien


mailSession				mSes
mailReturnCode			mRet, mRet2
mailMessage			mMsg[]
mailMessage			mMsg1
mailFileDescription		mAttach[]
mailRecipient			mRcpt[]
string					ls_ret, ls_syntax, ls_name, ls_open_pathname, ls_filename
string					ls_attach_name='DataWndw.psr'
int						li_index, li_nret, li_nrecipients, li_nfile
boolean 				lb_noerrors
long ll_tamanio_cuentas, ll_tamanio_carreras, ll_tamanio_email
long ll_indice, ll_indice_marcas
string ls_encabezado= "Requisitos para recoger Título"
boolean lb_solicita_recibo = true
string ls_nombre_archivo, ls_extension = "HTML", ls_email
long ll_cont_invalidos=0

ll_tamanio_cuentas = upperbound(al_cuentas)
ll_tamanio_carreras = upperbound(al_cve_carreras)
ll_tamanio_email = upperbound(as_email)

if ll_tamanio_cuentas<> ll_tamanio_carreras or &
	ll_tamanio_cuentas<> ll_tamanio_email then
	MessageBox("Arreglos de distintos tamaños (email)","El tamaño de los arreglos de datos no coincide",Stopsign!)
	return -1
end if

//*****************************************************************
//	Crea una instancia del Mail Session object, y se registra
// *****************************************************************
mSes = create mailSession

//*****************************************************************
//	Nota: Si el usuario del sistema de correo y su password se
//			conocen, pueden ponerse en el código, y mostrarse en 
//			las siguientes líneas comentadas. Si el usuario y el 
//			password no se ofrecen, se asume que se almacenan
//			en el archivo MSMAIL.INI
// *****************************************************************
mRet = mSes.mailLogon ( mailNewSession! )
ls_ret = f_mail_error_to_string ( mRet, 'Logon:', FALSE )
//--st_status_bar.text = ' Logon: ' + ls_ret
If mRet <> mailReturnSuccess! Then
	MessageBox ("Registro en el Correo", 'Return Code <> mailReturnSuccess!' )
	of_logoff_mail(mSes, ls_attach_name)
	return -1
End If

SetPointer(HourGlass!)




FOR ll_indice = 1 to ll_tamanio_cuentas
	ls_email = as_email[ll_indice]
	ls_email = "antonio.pica@uia.mx"
	if f_correo_valido(ls_email) then

		//*****************************************************************
		//	Copy user's subject to the mail message.
		//	Set return receipt flag If needed.
		//	Build an Attachment structure, and assign it to the mail message.
		// *****************************************************************
		mMsg[ll_indice].Subject	= ls_encabezado
		mMsg[ll_indice].ReceiptRequested = lb_solicita_recibo
	
		ls_nombre_archivo = string(al_cuentas[ll_indice])+ "_"+string(al_cve_carreras[ll_indice])+"."+ls_extension
		ls_attach_name = ls_nombre_archivo

		mAttach[ll_indice].FileType = mailAttach!
		mAttach[ll_indice].PathName = is_rutacompleta + ls_attach_name
		mAttach[ll_indice].FileName = is_rutacompleta + ls_attach_name
		// NotA: EN MS Mail version 3.0b, Position=-1 pone el anexo al
		//  principio del mensaje.
		// Esto colocara el anexo al final del texto del mensaje
//		mAttach[ll_indice].Position = len(mMsg[ll_indice].notetext) - 1		
		mAttach[ll_indice].Position = - 1		
		mMsg[ll_indice].AttachmentFile[1] = mAttach[ll_indice]
//		mRcpt[ll_indice].Address =ls_email
		mRcpt[ll_indice].Name =ls_email
		mMsg[ll_indice].Recipient[1] = mRcpt[ll_indice]
		mMsg1= mMsg[ll_indice]
		mRet2 = mSes.mailsend ( mMsg1)
		ls_ret = f_mail_error_to_string ( mRet2, 'send Mail:', FALSE )
		if mRet2 <> mailReturnSuccess! then
			MessageBox("Código devuelto por el correo",ls_ret,StopSign!)
			of_logoff_mail(mSes, ls_attach_name)
			return -1			
		end if
	else 
		ll_cont_invalidos = ll_cont_invalidos +1
	end if
NEXT	




if ll_cont_invalidos>0 then
	MessageBox("Algunos correos Inválidos","Existen ["+string(ll_cont_invalidos)+"] correos incorrectos",StopSign!)
	return 0
end if
return 0

end function

on uo_mail_service.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_mail_service.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

