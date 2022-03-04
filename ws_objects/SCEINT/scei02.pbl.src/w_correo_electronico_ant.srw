$PBExportHeader$w_correo_electronico_ant.srw
forward
global type w_correo_electronico_ant from w_ancestral
end type
type mle_note from multilineedit within w_correo_electronico_ant
end type
type dw_inbox from datawindow within w_correo_electronico_ant
end type
type dw_cons_bolsa from datawindow within w_correo_electronico_ant
end type
type dw_horarios from datawindow within w_correo_electronico_ant
end type
type dw_mat_preinsc from uo_dw_captura within w_correo_electronico_ant
end type
type st_atendidos from statictext within w_correo_electronico_ant
end type
type dw_materias_inscritas from datawindow within w_correo_electronico_ant
end type
type dw_lugar_preinsc from datawindow within w_correo_electronico_ant
end type
end forward

global type w_correo_electronico_ant from w_ancestral
integer width = 3625
integer height = 2076
string title = "Servidor Trámites vía Correo Electrónico"
string menuname = "m_menu"
event type integer canaliza ( string linea )
mle_note mle_note
dw_inbox dw_inbox
dw_cons_bolsa dw_cons_bolsa
dw_horarios dw_horarios
dw_mat_preinsc dw_mat_preinsc
st_atendidos st_atendidos
dw_materias_inscritas dw_materias_inscritas
dw_lugar_preinsc dw_lugar_preinsc
end type
global w_correo_electronico_ant w_correo_electronico_ant

type variables
string is_digito, is_correo,is_respuesta
string is_mail_sce, is_mail_bolsa
long il_cuenta,il_nip,il_periodo_preinsc
datetime enviado
mailSession ms_sesion
mailMessage mm_mensaje

DataStore dw_historico,dw_plan_estud,dw_materiasxcursar
DataStore dw_materias_abiertas
end variables

forward prototypes
public function string inc (string as_cadena)
public function string val_grupo (string as_grupo)
public subroutine despliega_materias (integer area)
public function string identificacion (long cuenta)
public function string cuenta_preinsc (integer clave, string grupo)
end prototypes

event canaliza;/*
DESCRIPCIÓN: Verifica que la cuenta sea válida, el nip sea el adecuado.
				 Canaliza el trámite al dw respectivo.
PARÁMETROS: linea leída del correo.
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 22 Septiembre 1998
MODIFICACIÓN:
*/
string ls_tramite,ls_cuenta,ls_nip_1,ls_nip_2,ls_periodo,ls_anio
int li_tramite,regreso,li_File_respuesta, li_nip_detectado
mailReturnCode mrc_estado
mailMessage mm_respuesta
datetime inicio,fin, ldttm_fecha_servidor
long ll_van,ll_enviados,ll_recibidos
string password='"fraze hultrasecreta de la UIA5"'
string ls_nip_plano, ls_error_file, ls_cuenta_file, ls_fecha_servidor
string ls_nombre_archivo ="err_nips.txt"
integer li_file_number, li_res_close
string ls_respuesta

inicio=datetime(today(),now())

if linea="" then
	li_tramite=-1
else
	
	ls_tramite=lee_cadenas(linea,"tramite=")
	ls_cuenta=lee_cadenas(linea,"cuenta=")
	is_digito=lee_cadenas(linea,"digito=")
	ls_nip_1=lee_cadenas(linea,"contrasena=")
   is_correo=lee_cadenas(linea,"correo=")
	ls_periodo=lee_cadenas(linea,"semestre=")
	if is_digito = "a" then is_digito = "A"
	
	CHOOSE CASE ls_periodo
		CASE 'Primavera'
			gi_periodo=0
		CASE 'Verano'
			gi_periodo=1
		CASE 'Otono'
			gi_periodo=2
	END CHOOSE

	ls_anio=lee_cadenas(linea,"anio=")
	gi_anio=long(ls_anio)

	if obten_digito(long(ls_cuenta)) <> is_digito then
		li_tramite=0
		is_respuesta="Cuenta Inexistente:	"+ls_cuenta+'-'+is_digito
		mm_respuesta.Subject = 'Cuenta Inexistente'
	else
		il_cuenta=long(ls_cuenta)
		setnull(ls_nip_2)
		SELECT nips.nip  
		INTO :ls_nip_2
		FROM nips
		WHERE nips.cuenta = :il_cuenta
		USING gtr_sce;
		commit USING gtr_sce;
		if isnull(ls_nip_1) then
			ls_nip_1="0"
		end if
		if isnull(ls_nip_2) then
			ls_nip_2="0"
		end if
      ls_nip_plano = ls_nip_1
		consulta_sie(ls_nip_1)
		
		if ls_nip_1<>ls_nip_2 then
			li_tramite=0
			is_respuesta="Nip Incorrecto:	"+ls_cuenta+'-'+is_digito
			mm_respuesta.Subject = 'Nip Incorrecto'
		else
			is_respuesta=identificacion(il_cuenta)
			li_nip_detectado = 1
			UPDATE nips
			SET ND = :li_nip_detectado,
				 nip2 = :ls_nip_plano
			WHERE nips.cuenta = :il_cuenta
			USING gtr_sce;
			if gtr_sce.SqlCode=-1 then
//Grabar en un archivo
				ls_error_file = gtr_sce.SqlErrtext
				ls_cuenta_file = string(il_cuenta)
				rollback using gtr_sce;
				ldttm_fecha_servidor = fecha_servidor(gtr_sce)
				ls_fecha_servidor = string(ldttm_fecha_servidor)
				li_file_number = FileOpen(ls_nombre_archivo, LineMode!, Write!, LockReadWrite!, Append!)
				if li_file_number<>-1 then
					FileWrite(li_file_number, ls_cuenta_file +" "+ls_error_file +" "+ls_fecha_servidor)
					li_res_close = FileClose(li_file_number)
				end if
			else
				commit using gtr_sce;
			end if		
			ls_respuesta = ""
			CHOOSE CASE ls_tramite
			CASE 'kardex'
				li_tramite=1
				if (revisaadeudosinscripcion(il_cuenta,ls_respuesta,1)<>0) then
					is_respuesta = ls_respuesta
				else
					agrega_historico_internet(dw_historico,il_cuenta,dw_materias_inscritas,is_respuesta)
				end if
				mm_respuesta.Subject = 'Resultado de tu Solicitud de Kardex'
			CASE 'preinscripcion'
				li_tramite=2
				if il_periodo_preinsc<>1 then
					is_respuesta=is_respuesta+"~n~rLo siento, no estamos en tiempo de preinscripciones."
				elseif (revisaadeudosinscripcion(il_cuenta,ls_respuesta,1)<>0) then
					is_respuesta = ls_respuesta
				else
					dw_mat_preinsc.event agrega(linea)
				end if
				mm_respuesta.Subject = 'Resultado de tu Solicitud de Kardex'
			CASE 'solmat'
				li_tramite=3
				if (revisaadeudosinscripcion(il_cuenta,ls_respuesta,1)<>0) then
					is_respuesta = ls_respuesta
				else
					dw_materias_abiertas.retrieve(gi_periodo,gi_anio)
					agrega_materiasxcursar_internet(il_cuenta,is_respuesta,dw_materiasxcursar,dw_historico,dw_plan_estud,dw_materias_inscritas,dw_materias_abiertas)
				end if
				mm_respuesta.Subject = 'Resultado de tu Solicitud de Materias'
			CASE 'horarios'
				li_tramite=4
				if (revisaadeudosinscripcion(il_cuenta,ls_respuesta,1)<>0) then
					is_respuesta = ls_respuesta
				else
					dw_horarios.event agrega(linea)
				end if
				mm_respuesta.Subject = 'Resultado de tu Solicitud de Horarios'
			CASE 'cons_bolsa'
				li_tramite=5
				dw_cons_bolsa.event busca()
				mm_respuesta.Subject = 'Resultado de la consulta en Bolsa de Trabajo'
			CASE 'registra_alumno','consulta_alumno'
				li_tramite=6
				is_respuesta=is_respuesta+'~n~r'+dw_cons_bolsa.event registro(linea)
				mm_respuesta.Subject = 'Resultado de tu registro de Bolsa de Trabajo'
			CASE ELSE
				li_tramite=-1
				is_respuesta="Trámite desconocido"
				mm_respuesta.Subject = 'Trámite desconocido'
			END CHOOSE
		end if
	End if
end if


if li_tramite<>-1 then
	mm_respuesta.Recipient[1].name = is_correo
	if ls_tramite='registra_alumno' then
		mm_respuesta.Recipient[2].name = is_mail_bolsa
	end if
	mm_respuesta.NoteText = is_respuesta
	
	li_File_respuesta = FileOpen("firma.txt",LineMode!, Write!, LockWrite!, Replace!)
	DO UNTIL Pos(is_respuesta, "~n")=0
		FileWrite(li_File_respuesta, Left(is_respuesta, Pos(is_respuesta, "~n") - 1 ))
		is_respuesta=Mid(is_respuesta, Pos(is_respuesta, "~n") + 2)
	LOOP
	FileWrite(li_File_respuesta, is_respuesta)
	FileClose(li_File_respuesta)	
	if FileExists ("Firma.pgp") then
		FileDelete ("Firma.pgp")
	end if
	Run("pgps.pif firma.txt -z "+password)
	DO UNTIL FileExists ("Firma.pgp")
	LOOP
	
	mm_respuesta.AttachmentFile[1].Pathname="firma.pgp"
	mrc_estado = ms_sesion.mailSend ( mm_respuesta )
	IF mrc_estado <> mailReturnSuccess! THEN
		regreso=0
	else
		regreso=-1
	END IF
else
	regreso=0
end if

fin=datetime(today(),now())

SELECT isnull(max(num_ope),0)
INTO :ll_van
FROM estadisticas_preinsc
USING gtr_sce;
commit USING gtr_sce;

ll_enviados=len(is_respuesta)
ll_recibidos=len(mle_note.text)

INSERT INTO estadisticas_preinsc
	( num_ope,operacion,envio,recepcion,respuesta,enviados,recibidos )
VALUES ( :ll_van+1,:li_tramite,:enviado,:inicio,:fin,:ll_enviados,:ll_recibidos )
USING gtr_sce;
commit USING gtr_sce;

if li_tramite<>-1 then
	UPDATE dbo.alumnos
	SET fotografia = :is_correo
	WHERE dbo.alumnos.cuenta = :il_cuenta
	USING gtr_sce;
	commit USING gtr_sce;
end if

st_atendidos.text=string(ll_van+1)

return regreso
end event

public function string inc (string as_cadena);long ll_letra
string ls_resultado

ls_resultado=""

FOR ll_letra=Pos ( as_cadena, "(tramite)" ) TO Pos ( as_cadena, "FIN	." )
	CHOOSE CASE Mid ( as_cadena, ll_letra, 1 )
	CASE '('
		ls_resultado=ls_resultado
	CASE ')'
		ls_resultado=ls_resultado+'='
		ll_letra=ll_letra+2
	CASE char(13)
		ls_resultado=ls_resultado+'	'
	CASE char(10)
		ls_resultado=ls_resultado
	CASE ELSE
		ls_resultado=ls_resultado+Mid ( as_cadena, ll_letra, 1 )
	END CHOOSE

NEXT

return ls_resultado
end function

public function string val_grupo (string as_grupo);if len(as_grupo)=3 then
	if mid(as_grupo,2,1)=' ' then
		return mid(as_grupo,1,1)+mid(as_grupo,3,1)
	else
		return as_grupo
	end if
else
	return trim(as_grupo)
end if
end function

public subroutine despliega_materias (integer area);integer ll_cont_1

if isnull(area) then
	area=0
end if
dw_materiasxcursar.SetFilter("area_mat_cve_area="+string(area))
dw_materiasxcursar.Filter( )
dw_materiasxcursar.Sort( )

if dw_materiasxcursar.rowcount()>0 then
	is_respuesta=is_respuesta+"~n~rMAT	SIGLA	CRED	HRS	S.IDEAL	MATERIA~n~r~n~r"
end if

FOR ll_cont_1=1 TO dw_materiasxcursar.rowcount()
	is_respuesta=is_respuesta+string(dw_materiasxcursar.object.cve_mat[ll_cont_1])+'	'+&
		string(dw_materiasxcursar.object.sigla[ll_cont_1])+'	'+&
		string(dw_materiasxcursar.object.creditos[ll_cont_1],"###0.00")+'	'+&
		string(dw_materiasxcursar.object.horas_reales[ll_cont_1])+'	'
	if isnull(dw_materiasxcursar.object.semestre_ideal[ll_cont_1]) then
		is_respuesta=is_respuesta+'		'
	else
		is_respuesta=is_respuesta+&
			string(dw_materiasxcursar.object.semestre_ideal[ll_cont_1])+'	'
	end if
		is_respuesta=is_respuesta+&
			string(dw_materiasxcursar.object.materia[ll_cont_1])+'~n~r'
NEXT
end subroutine

public function string identificacion (long cuenta);string nombre,carrera,escuela,municipio,localidad,estado

SELECT alumnos.nombre_completo,carreras.carrera
INTO :nombre,:carrera
FROM academicos,alumnos,carreras
WHERE ( alumnos.cuenta = academicos.cuenta ) and
		( academicos.cve_carrera = carreras.cve_carrera ) and
		( ( academicos.cuenta = :cuenta ) )
USING gtr_sce;
commit USING gtr_sce;

setnull(escuela)
setnull(municipio)
setnull(localidad)
setnull(estado)

SELECT dbo.escuelas.escuela,dbo.municipio_localidad.municipio,dbo.municipio_localidad.localidad,
	dbo.estados.estado  
INTO :escuela,:municipio,:localidad,:estado
FROM dbo.escuelas,dbo.estados,dbo.municipio_localidad,dbo.estudio_ant
WHERE ( dbo.escuelas.cve_escuela = dbo.estudio_ant.cve_escuela ) and
	( dbo.escuelas.cve_sep *= dbo.estados.cve_sep) and
	( dbo.escuelas.cve_mun_loc *= dbo.municipio_localidad.cve_mun_loc) and
	( ( dbo.estudio_ant.cuenta = :cuenta ) AND
	( dbo.estudio_ant.cve_grado = 'B' ) )
USING gtr_sce;
commit USING gtr_sce;

if isnull(escuela) then
	escuela=''
end if
if isnull(municipio) then
	municipio=''
end if
if isnull(localidad) then
	localidad=''
end if
if isnull(estado) then
	estado=''
end if

return string(il_cuenta)+'-'+is_digito+'~n~r'+nombre+'~n~r'+carrera+'~n~r'+&
	'Bachillerato en: '+escuela+' '+municipio+' '+localidad+' '+estado+&
	' Si está incorrecto, pasa a servicios escolares.~n~r~n~r'
end function

public function string cuenta_preinsc (integer clave, string grupo);long cont
string lugar

dw_lugar_preinsc.retrieve(clave,grupo,gi_periodo,gi_anio)

lugar=string(dw_lugar_preinsc.rowcount())

if dw_lugar_preinsc.rowcount()=0 then
	return "0"
else
	FOR cont=1 TO dw_lugar_preinsc.rowcount()
	IF dw_lugar_preinsc.object.mat_preinsc_cuenta[cont]=il_cuenta THEN
		lugar=string(cont)+' de '+lugar
		return lugar
	END IF
	NEXT
end if

return lugar
end function

event close;/*
DESCRIPCIÓN: Cierra y destruye la sesión de correo.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
ms_sesion.mailLogoff( )
DESTROY ms_sesion

DESTROY dw_historico
DESTROY dw_plan_estud
DESTROY dw_materiasxcursar
DESTROY dw_materias_abiertas

if gi_numscob = 1 then
	if desconecta_bd_n_tr(gtr_scob) <> 1 then
		return
	end if
end if
gi_numscob --
desconecta_bd(gtr_bolsa)
desconecta_bd_n_tr(gtr_sfeb)
end event

event open;call super::open;/*
DESCRIPCIÓN: Genera una sesión de correo y conéctate al servidor.
				 Conectate a la base de credenciales.
				 Liga dw_mat_preinsc a sce.
				 Establece el evento Timer para cada 30 segundos.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
ms_sesion = CREATE mailSession
ms_sesion.mailLogon(mailNewSession!)
long ll_van

//if conecta_bd(gtr_scob,gs_scob,"informes","informes")=0 then
//	return
//end if

if isnull(gi_numscob) OR not (isvalid(gtr_scob)) then gi_numscob = 0
if gi_numscob <= 0 then
	if conecta_bd_n_tr(gtr_scob,gs_scob,gs_usuario,gs_password)<>1 then
		MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de cobranzas", StopSign!)
		close(this)
	end if
end if
gi_numscob++


if conecta_bd(gtr_bolsa,"bolsa",gs_usuario,gs_password)=0 then
	return
end if

if conecta_bd_n_tr(gtr_sfeb,gs_sfeb,gs_usuario,gs_password)=0 then
	return
end if

dw_plan_estud = CREATE DataStore
dw_plan_estud.DataObject = "dw_plan_estud"
dw_plan_estud.Settransobject(gtr_sce)

dw_historico = CREATE DataStore
dw_historico.DataObject = "dw_historico"
dw_historico.Settransobject(gtr_sce)

dw_materiasxcursar = CREATE DataStore
dw_materiasxcursar.DataObject = "dw_materiasxcursar"
dw_materiasxcursar.Settransobject(gtr_sce)

dw_materias_abiertas = CREATE DataStore
dw_materias_abiertas.DataObject = "dw_materias_abiertas"
dw_materias_abiertas.Settransobject(gtr_sce)

dw_mat_preinsc.settransobject(gtr_sce)
dw_horarios.settransobject(gtr_sce)
dw_lugar_preinsc.settransobject(gtr_sce)
dw_materias_inscritas.settransobject(gtr_sce)
dw_cons_bolsa.settransobject(gtr_bolsa)

dw_mat_preinsc.visible=false
dw_horarios.visible=false
dw_lugar_preinsc.visible=false
dw_materias_inscritas.visible=false
dw_cons_bolsa.visible=false

SELECT isnull(max(num_ope),0)
INTO :ll_van
FROM estadisticas_preinsc
USING gtr_sce;
commit USING gtr_sce;

st_atendidos.text=string(ll_van)

is_mail_sce=ProfileString ("preinsc.ini", gs_datos, "EMAIL_sce","")
is_mail_bolsa=ProfileString ("preinsc.ini", gs_datos, "EMAIL_bolsa","")

il_periodo_preinsc = MessageBox("¿Estamos en periodo de Preinscripción?",&
	"Consulte a Servicios Escolares",Exclamation!, YesNo!, 2)
IF il_periodo_preinsc = 1 THEN 
	// Process Yes.
ELSE
	// Process No.
END IF

Timer(30)
end event

event timer;call super::timer;/*
DESCRIPCIÓN: Cada 30 segundos verifica el correo, si hay correo con instrucciones de
				 válidas canalízalas. Si las instrucciones se entendieron y ejecutaron,
				 borra el correo.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
long lo_n, lo_c_row
date fecha
time hora
mailReturnCode mrc_estado
mailMessage mm_respuesta

dw_inbox.reset()
dw_mat_preinsc.reset()
dw_historico.reset()
dw_materiasxcursar.reset()
dw_plan_estud.reset()

timer(0)
ms_sesion.mailGetMessages( )

//FOR lo_n = UpperBound(ms_sesion.MessageID[])	to 1 step -1
FOR lo_n = 1 to UpperBound(ms_sesion.MessageID[])

	ms_sesion.mailReadMessage(ms_sesion.MessageID[lo_n],mm_mensaje, mailEntireMessage!, TRUE)

	lo_c_row = dw_inbox.InsertRow( 0 )
	dw_inbox.SetItem(lo_c_row, "msgid", ms_sesion.MessageID[lo_n])
	dw_inbox.SetItem(lo_c_row, "msgdate", mm_mensaje.DateReceived)
	// Truncate subject to fit defined column size
	dw_inbox.SetItem(lo_c_row, "msgsubject",Left(mm_mensaje.Subject, 100))
	
	mle_note.Text = inc(mm_mensaje.NoteText)
		
	fecha=date(left(dw_inbox.object.msgdate[lo_c_row],10))
	hora=time(right(dw_inbox.object.msgdate[lo_c_row],5))
	enviado=datetime(fecha,hora)
	
	if event canaliza(inc(mm_mensaje.NoteText))=-1 then
		ms_sesion.mailDeleteMessage(ms_sesion.MessageID[lo_n])
	else
		mm_respuesta.Subject = mm_mensaje.Subject
		mm_respuesta.NoteText = mm_mensaje.NoteText
		mm_respuesta.Recipient[1].name = is_mail_sce
		mrc_estado = ms_sesion.mailSend ( mm_respuesta )
			IF mrc_estado = mailReturnSuccess! THEN
				ms_sesion.mailDeleteMessage(ms_sesion.MessageID[lo_n])
			END IF
	end if
NEXT
timer(30)
end event

on w_correo_electronico_ant.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.mle_note=create mle_note
this.dw_inbox=create dw_inbox
this.dw_cons_bolsa=create dw_cons_bolsa
this.dw_horarios=create dw_horarios
this.dw_mat_preinsc=create dw_mat_preinsc
this.st_atendidos=create st_atendidos
this.dw_materias_inscritas=create dw_materias_inscritas
this.dw_lugar_preinsc=create dw_lugar_preinsc
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_note
this.Control[iCurrent+2]=this.dw_inbox
this.Control[iCurrent+3]=this.dw_cons_bolsa
this.Control[iCurrent+4]=this.dw_horarios
this.Control[iCurrent+5]=this.dw_mat_preinsc
this.Control[iCurrent+6]=this.st_atendidos
this.Control[iCurrent+7]=this.dw_materias_inscritas
this.Control[iCurrent+8]=this.dw_lugar_preinsc
end on

on w_correo_electronico_ant.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mle_note)
destroy(this.dw_inbox)
destroy(this.dw_cons_bolsa)
destroy(this.dw_horarios)
destroy(this.dw_mat_preinsc)
destroy(this.st_atendidos)
destroy(this.dw_materias_inscritas)
destroy(this.dw_lugar_preinsc)
end on

type p_uia from w_ancestral`p_uia within w_correo_electronico_ant
end type

type mle_note from multilineedit within w_correo_electronico_ant
integer y = 428
integer width = 3561
integer height = 412
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
end type

type dw_inbox from datawindow within w_correo_electronico_ant
event clicked pbm_dwnlbuttonclk
integer x = 375
integer width = 3177
integer height = 412
string dataobject = "d_inbox"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;/*
DESCRIPCIÓN: Despliega el contenido del correo que se recibió.
PARÁMETROS: Renglón que se eligió.
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
integer  li_nRow
string ls_MessageID,ls_Ret,ls_Name

// Find out what Mail Item was selected

li_nRow = row

IF li_nRow > 0 THEN
	// Get the message ID from the row
	ls_MessageID = GetItemString(li_nRow, 'msgid')

	//Re-read the message to obtain entire  contents 
	// because previously we read only the envelope
//	sRet = mSes.mailReadMessage(sMessageID, Msg, mailEntireMessage!, TRUE)
	ms_sesion.mailReadMessage(ls_MessageID, mm_mensaje, mailEntireMessage!, TRUE)
	mle_note.Text = inc(mm_mensaje.NoteText)
END IF
end event

type dw_cons_bolsa from datawindow within w_correo_electronico_ant
event busca ( )
event type string registro ( string linea )
integer x = 5
integer y = 860
integer width = 3543
integer height = 1036
integer taborder = 30
string dataobject = "dw_cons_bolsa"
boolean livescroll = true
end type

event busca;string ls_sexo
int li_carrera[], li_edad, li_cont
datetime ld_fecha_nac
DataStore dw_carreras_anteriores

dw_carreras_anteriores = CREATE DataStore
dw_carreras_anteriores.DataObject = "d_carreras_anteriores"
dw_carreras_anteriores.Settransobject(gtr_sce)

visible = true

SELECT dbo.academicos.cve_carrera
INTO :li_carrera[1]
FROM dbo.academicos
WHERE dbo.academicos.cuenta = :il_cuenta
USING gtr_sce;

dw_carreras_anteriores.retrieve(il_cuenta)

FOR li_cont=1 TO dw_carreras_anteriores.rowcount()
	li_carrera[li_cont+1]=dw_carreras_anteriores.object.cve_carrera_ant[li_cont]
NEXT

DESTROY dw_carreras_anteriores

SELECT dbo.alumnos.sexo,dbo.alumnos.fecha_nac
INTO :ls_sexo,:ld_fecha_nac
FROM dbo.alumnos
WHERE dbo.alumnos.cuenta = :il_cuenta
USING gtr_sce;

IF ls_sexo='F' THEN
	ls_sexo='FEMENINO'
ELSE
	ls_sexo='MASCULINO'
END IF

li_edad=year(today()) - year(date(ld_fecha_nac))
if month(today()) < month(date(ld_fecha_nac)) then
	li_edad=li_edad - 1
else
	if month(today()) = month(date(ld_fecha_nac)) then
		if day(today()) < day(date(ld_fecha_nac)) then
			li_edad=li_edad - 1
		end if
	end if
end if

if retrieve(li_carrera[],ls_sexo,li_edad)>0 then

	FOR li_cont=1 TO rowcount()
		
		if not(isnull(object.datos_oferta_fecha_ingreso[li_cont])) then
			is_respuesta=is_respuesta+'Fecha: '+string(object.datos_oferta_fecha_ingreso[li_cont],"dd-mm-yy")+'~n~r'
		end if
		is_respuesta=is_respuesta+'~n~rEmpresa:~n~r'
		if not(isnull(object.empresa_nombre_empresa[li_cont])) then
			is_respuesta=is_respuesta+'Nombre: '+object.empresa_nombre_empresa[li_cont]+'~n~r'
		end if
		if not(isnull(object.empresa_calle[li_cont])) then
			is_respuesta=is_respuesta+'Calle y Número: '+object.empresa_calle[li_cont]+' '
		end if
		if not(isnull(object.empresa_cod_postal[li_cont])) then
			is_respuesta=is_respuesta+' C.P. '+object.empresa_cod_postal[li_cont]+'~n~r'
		end if
		if not(isnull(object.empresa_colonia[li_cont])) then
			is_respuesta=is_respuesta+'Colonia: '+object.empresa_colonia[li_cont]+' '
		end if
		if not(isnull(object.empresa_pais[li_cont])) then
			is_respuesta=is_respuesta+' País: '+object.empresa_pais[li_cont]+'~n~r'
		end if
		if not(isnull(object.empresa_delegacion[li_cont])) then
			is_respuesta=is_respuesta+'Delegación: '+object.empresa_delegacion[li_cont]+'~n~r'
		end if
		if not(isnull(object.empresa_ciudad[li_cont])) then
			is_respuesta=is_respuesta+'Ciudad: '+object.empresa_ciudad[li_cont]+' '
		end if
		if not(isnull(object.empresa_fax1[li_cont])) then
			is_respuesta=is_respuesta+' Fax 1: '+object.empresa_fax1[li_cont]+' '
		end if
		if not(isnull(object.empresa_fax2[li_cont])) then
			is_respuesta=is_respuesta+' Fax 2: '+object.empresa_fax2[li_cont]+'~n~r'
		else
			is_respuesta=is_respuesta+'~n~r'
		end if
		if not(isnull(object.empresa_telefono1[li_cont])) then
			is_respuesta=is_respuesta+'Teléfono 1: '+object.empresa_telefono1[li_cont]+' '
		end if
		if not(isnull(object.empresa_extencion1[li_cont])) then
			is_respuesta=is_respuesta+'ext. '+object.empresa_extencion1[li_cont]+' '
		end if
		if not(isnull(object.empresa_telefono2[li_cont])) then
			is_respuesta=is_respuesta+' Teléfono 2: '+object.empresa_telefono2[li_cont]+' '
		end if
		if not(isnull(object.empresa_extencion2[li_cont])) then
			is_respuesta=is_respuesta+'ext. '+object.empresa_extencion2[li_cont]+' '
		end if
		if not(isnull(object.empresa_telefono3[li_cont])) then
			is_respuesta=is_respuesta+' Teléfono 3: '+object.empresa_telefono3[li_cont]+' '
		end if
		if not(isnull(object.empresa_extencion3[li_cont])) then
			is_respuesta=is_respuesta+'ext. '+object.empresa_extencion3[li_cont]+'~n~r'
		else
			is_respuesta=is_respuesta+'~n~r'
		end if
		if not(isnull(object.empresa_mail[li_cont])) then
			is_respuesta=is_respuesta+'E-Mail: '+object.empresa_mail[li_cont]+' '
		end if
		if not(isnull(object.empresa_contacto[li_cont])) then
			is_respuesta=is_respuesta+' Contacto: '+object.empresa_contacto[li_cont]+'~n~r'
		end if
		if not(isnull(object.empresa_giro[li_cont])) then
			is_respuesta=is_respuesta+'Giro: '+object.empresa_giro[li_cont]+'~n~r'
		end if
		is_respuesta=is_respuesta+'~n~rOferta:~n~r'
		if not(isnull(object.datos_oferta_puesto[li_cont])) then
			is_respuesta=is_respuesta+'Puesto: '+object.datos_oferta_puesto[li_cont]+'~n~r'
		end if
		if not(isnull(object.escolaridad_nivel[li_cont])) then
			is_respuesta=is_respuesta+'Nivel: '+object.escolaridad_nivel[li_cont]+' '
		end if
		if not(isnull(object.datos_oferta_posgrado[li_cont])) then
			is_respuesta=is_respuesta+' Posgrado: '+object.datos_oferta_posgrado[li_cont]+'~n~r'
		end if
		if not(isnull(object.datos_oferta_idioma1[li_cont])) then
			is_respuesta=is_respuesta+'Inglés: '+string(object.datos_oferta_idioma1[li_cont])+'% '
		end if
		if not(isnull(object.datos_oferta_idioma2[li_cont])) then
			is_respuesta=is_respuesta+' Francés: '+string(object.datos_oferta_idioma2[li_cont])+'% '
		end if
		if not(isnull(object.datos_oferta_idioma3[li_cont])) then
			is_respuesta=is_respuesta+' Alemán: '+string(object.datos_oferta_idioma3[li_cont])+'% '
		end if
		if not(isnull(object.datos_oferta_sueldo_max[li_cont])) then
			is_respuesta=is_respuesta+' Sueldo Máximo: '+string(object.datos_oferta_sueldo_max[li_cont],"$#,##0.00")+' '
		end if
		if not(isnull(object.datos_oferta_sueldo_min[li_cont])) then
			is_respuesta=is_respuesta+' Sueldo Mínimo: '+string(object.datos_oferta_sueldo_min[li_cont],"$#,##0.00")+'~n~r'
		end if
		
		if not(isnull(object.datos_oferta_experiencia[li_cont])) then
			if object.datos_oferta_experiencia[li_cont]=2 then
				is_respuesta=is_respuesta+'Experiencia Necesaria'
				if not(isnull(object.datos_oferta_exper_donde[li_cont])) then
					is_respuesta=is_respuesta+' en: '+object.datos_oferta_exper_donde[li_cont]+'~n~r'
				end if
			end if
		end if
		if not(isnull(object.datos_oferta_computadora[li_cont])) then
			if object.datos_oferta_computadora[li_cont]="2" then
				is_respuesta=is_respuesta+' Conocimientos de Cómputo necesarios.'+'~n~r'
			end if
		end if
		if not(isnull(object.datos_oferta_paqueteria[li_cont])) then
			is_respuesta=is_respuesta+' Paquetería: '+object.datos_oferta_paqueteria[li_cont]+'~n~r'
		end if
		if not(isnull(object.datos_oferta_cambio_res[li_cont])) then
			if object.datos_oferta_cambio_res[li_cont]='si' then
				is_respuesta=is_respuesta+' Cambio de Residencia Necesario~n~r'
			end if
		end if
		if not(isnull(object.datos_oferta_automovil[li_cont])) then
			if object.datos_oferta_automovil[li_cont]="2" then
				is_respuesta=is_respuesta+'Automóvil necesario.'
			end if
		end if
		if not(isnull(object.datos_oferta_viajar[li_cont])) then
			if object.datos_oferta_viajar[li_cont]="2" then
				is_respuesta=is_respuesta+' Necesario viajar'
				if not(isnull(object.datos_oferta_lugar[li_cont])) then
					is_respuesta=is_respuesta+' a: '+object.datos_oferta_lugar[li_cont]+'~n~r'
				else
					is_respuesta=is_respuesta+'~n~r'
				end if
			end if
		end if
		
		if not(isnull(object.datos_oferta_observaciones1[li_cont])) then
			is_respuesta=is_respuesta+object.datos_oferta_observaciones1[li_cont]+'~n~r'
		end if
		if not(isnull(object.datos_oferta_observaciones2[li_cont])) then
			is_respuesta=is_respuesta+object.datos_oferta_observaciones2[li_cont]+'~n~r'
		end if
		is_respuesta=is_respuesta+'~n~r________________________________________________~n~r~n~r'

	NEXT
else

	is_respuesta=is_respuesta+'~n~rLo siento, por lo pronto no hay ofertas con tu perfil.~n~r'
end if

visible = false
end event

event registro;string ls_auto_nombre, ls_auto_telefono, ls_confidencial, ls_telefono1, ls_telefono2
string ls_telefono3, ls_fax1, ls_fax2, ls_areas, ls_sueldo, ls_lic_nombre, ls_lic_ini
string ls_lic_fin, ls_lic_uni, ls_lic_nivel, ls_lic_sem, ls_lic_fecha_tit, ls_lic_prom
string ls_pos_nombre, ls_pos_ini, ls_pos_fin, ls_pos_uni, ls_pos_nivel, ls_pos_sem
string ls_pos_fecha_tit, ls_otro_nombre_1, ls_otro_uni_1, ls_otro_nombre_2, ls_otro_uni_2
string ls_otro_nombre_3, ls_otro_uni_3
string ls_puesto_1, ls_anios_1, ls_meses_1
string ls_puesto_2, ls_anios_2, ls_meses_2
string ls_puesto_3, ls_anios_3, ls_meses_3
string ls_puesto_4, ls_anios_4, ls_meses_4
string ls_puesto_5, ls_anios_5, ls_meses_5
string ls_idioma_1, ls_idioma1, ls_idioma_2, ls_idioma2, ls_idioma_3, ls_idioma3
string ls_idioma_4, ls_idioma4, ls_viajar, ls_cambio_res, ls_observaciones
string ls_nombre_completo, ls_telefono, ls_calle, ls_colonia, ls_cod_postal, ls_estado
string ls_sexo, ls_edo_civil, ls_nacionalidad, ls_nivel, ls_carrera
datetime ld_fecha_nac,ld_fecha_titulo
string respuesta,ls_ya_no
int li_cont,li_sem_cursados,li_egresado,li_edad
real lr_promedio
DataStore dw_titulos_obtenidos

dw_titulos_obtenidos = CREATE DataStore
dw_titulos_obtenidos.DataObject = "d_titulos_obtenidos"
dw_titulos_obtenidos.Settransobject(gtr_sce)

dw_titulos_obtenidos.retrieve(il_cuenta)

SELECT dbo.alumnos.nombre_completo,dbo.domicilio.telefono,dbo.domicilio.calle,
	dbo.domicilio.colonia,dbo.domicilio.cod_postal,dbo.estados.estado,
	dbo.alumnos.fecha_nac,dbo.alumnos.sexo,dbo.edo_civil.edo_civil,
	dbo.nacionalidad.nacionalidad,dbo.academicos.nivel,dbo.carreras.carrera,
	dbo.academicos.sem_cursados,dbo.academicos.egresado,dbo.academicos.promedio
INTO :ls_nombre_completo,:ls_telefono,:ls_calle,:ls_colonia,:ls_cod_postal,:ls_estado,
	:ld_fecha_nac,:ls_sexo,:ls_edo_civil,:ls_nacionalidad,:ls_nivel,:ls_carrera,
	:li_sem_cursados,:li_egresado,:lr_promedio
FROM dbo.academicos,dbo.alumnos,dbo.carreras,dbo.domicilio,dbo.estados,
	dbo.edo_civil,dbo.nacionalidad
WHERE ( dbo.alumnos.cuenta = dbo.academicos.cuenta ) and  
	( dbo.academicos.cve_carrera = dbo.carreras.cve_carrera ) and  
	( dbo.domicilio.cuenta = dbo.alumnos.cuenta ) and  
	( dbo.domicilio.cve_estado = dbo.estados.cve_estado ) and  
	( dbo.alumnos.cve_edocivil = dbo.edo_civil.cve_edocivil ) and  
	( dbo.alumnos.cve_nacion = dbo.nacionalidad.cve_nacion ) and  
	( ( dbo.academicos.cuenta = :il_cuenta ) )
USING gtr_sce;

li_edad=year(today()) - year(date(ld_fecha_nac))
if month(today()) < month(date(ld_fecha_nac)) then
	li_edad=li_edad - 1
else
	if month(today()) = month(date(ld_fecha_nac)) then
		if day(today()) < day(date(ld_fecha_nac)) then
			li_edad=li_edad - 1
		end if
	end if
end if

ls_auto_nombre=lee_cadenas(linea,"auto_nombre=")
ls_auto_telefono=lee_cadenas(linea,"auto_telefono=")
ls_confidencial=lee_cadenas(linea,"confidencial=")
ls_telefono1=lee_cadenas(linea,"telefono1=")
ls_telefono2=lee_cadenas(linea,"telefono2=")
ls_telefono3=lee_cadenas(linea,"telefono3=")
ls_fax1=lee_cadenas(linea,"fax1=")
ls_fax2=lee_cadenas(linea,"fax2=")
ls_areas=lee_cadenas(linea,"areas=")
ls_sueldo=lee_cadenas(linea,"sueldo=")
ls_lic_nombre=lee_cadenas(linea,"lic_nombre=")
ls_lic_ini=lee_cadenas(linea,"lic_ini=")
ls_lic_fin=lee_cadenas(linea,"lic_fin=")
ls_lic_uni=lee_cadenas(linea,"lic_uni=")
ls_lic_nivel=lee_cadenas(linea,"lic_nivel=")
ls_lic_sem=lee_cadenas(linea,"lic_sem=")
ls_lic_fecha_tit=lee_cadenas(linea,"lic_fecha_tit=")
ls_lic_prom=lee_cadenas(linea,"lic_prom=")
ls_pos_nombre=lee_cadenas(linea,"pos_nombre=")
ls_pos_ini=lee_cadenas(linea,"pos_ini=")
ls_pos_fin=lee_cadenas(linea,"pos_fin=")
ls_pos_uni=lee_cadenas(linea,"pos_uni=")
ls_pos_nivel=lee_cadenas(linea,"pos_nivel=")
ls_pos_sem=lee_cadenas(linea,"pos_sem=")
ls_pos_fecha_tit=lee_cadenas(linea,"pos_fecha_tit=")
ls_otro_nombre_1=lee_cadenas(linea,"otro_nombre_1=")
ls_otro_uni_1=lee_cadenas(linea,"otro_uni_1=")
ls_otro_nombre_2=lee_cadenas(linea,"otro_nombre_2=")
ls_otro_uni_2=lee_cadenas(linea,"otro_uni_2=")
ls_otro_nombre_3=lee_cadenas(linea,"otro_nombre_3=")
ls_otro_uni_3=lee_cadenas(linea,"otro_uni_3=")
ls_puesto_1=lee_cadenas(linea,"puesto_1=")
ls_anios_1=lee_cadenas(linea,"anios_1=")
ls_meses_1=lee_cadenas(linea,"meses_1=")
ls_puesto_2=lee_cadenas(linea,"puesto_2=")
ls_anios_2=lee_cadenas(linea,"anios_2=")
ls_meses_2=lee_cadenas(linea,"meses_2=")
ls_puesto_3=lee_cadenas(linea,"puesto_3=")
ls_anios_3=lee_cadenas(linea,"anios_3=")
ls_meses_3=lee_cadenas(linea,"meses_3=")
ls_puesto_4=lee_cadenas(linea,"puesto_4=")
ls_anios_4=lee_cadenas(linea,"anios_4=")
ls_meses_4=lee_cadenas(linea,"meses_4=")
ls_puesto_5=lee_cadenas(linea,"puesto_5=")
ls_anios_5=lee_cadenas(linea,"anios_5=")
ls_meses_5=lee_cadenas(linea,"meses_5=")
ls_idioma_1=lee_cadenas(linea,"idioma_1=")
ls_idioma1=lee_cadenas(linea,"idioma1=")
ls_idioma_2=lee_cadenas(linea,"idioma_2=")
ls_idioma2=lee_cadenas(linea,"idioma2=")
ls_idioma_3=lee_cadenas(linea,"idioma_3=")
ls_idioma3=lee_cadenas(linea,"idioma3=")
ls_idioma_4=lee_cadenas(linea,"idioma_4=")
ls_idioma4=lee_cadenas(linea,"idioma4=")
ls_viajar=lee_cadenas(linea,"viajar=")
ls_cambio_res=lee_cadenas(linea,"cambio_res=")
ls_observaciones=lee_cadenas(linea,"observaciones=")

respuesta=&
"Distribución: NOMBRE, TELEFONO, DIRECCION, EDAD, SEXO, ESTADO CIVIL, NACIONALIDAD, GRADO~n~r"+&
"UNIVERSITARIO, AREA DE INTERES, RANGO DE SUELDO, EXPERIENCIA PROFESIONAL, IDIOMAS Y~n~r"+&
"DISPONIBILIDAD PARA VIAJAR O RADICAR FUERA DEL D.F.~n~r~n~r"

if ls_confidencial="si" then
	respuesta=respuesta+'Quiero aparecer solo con mi clave, mi solicitud es confidencial.~n~r'
else
	if ls_auto_nombre="si" then
		respuesta=respuesta+'Autorizo que se publique mi nombre en el Boletín.~n~r'
	else
		respuesta=respuesta+'NO Autorizo que se publique mi nombre en el Boletín.~n~r'
	end if
	
	if ls_auto_telefono="si" then
		respuesta=respuesta+'Autorizo que se publique mi telefono en el Boletín.~n~r'
	else
		respuesta=respuesta+'NO Autorizo que se publique mi telefono en el Boletín.~n~r'
	end if
end if

respuesta=respuesta+ls_nombre_completo
if ls_telefono<>"" then
	respuesta=respuesta+'/~n~r'+ls_telefono
end if
if ls_telefono1<>"" then
	respuesta=respuesta+'/~n~r'+ls_telefono1
end if
if ls_telefono2<>"" then
	respuesta=respuesta+'/~n~r'+ls_telefono2
end if
if ls_telefono3<>"" then
	respuesta=respuesta+'/~n~r'+ls_telefono3
end if
if ls_fax1<>"" then
	respuesta=respuesta+'/~n~rFAX: '+ls_fax1
end if
if ls_fax2<>"" then
	respuesta=respuesta+'/~n~rFAX: '+ls_fax2
end if
if ls_calle<>"" then
	respuesta=respuesta+'/~n~r'+ls_calle
end if
if ls_colonia<>"" then
	respuesta=respuesta+'/~n~r'+ls_colonia
end if
if ls_cod_postal<>"" then
	respuesta=respuesta+'/~n~r'+ls_cod_postal
end if
if ls_estado<>"" then
	respuesta=respuesta+'/~n~r'+ls_estado
end if
respuesta=respuesta+'/~n~r'+string(li_edad)
respuesta=respuesta+'/~n~r'+ls_sexo
respuesta=respuesta+'/~n~r'+ls_edo_civil
respuesta=respuesta+'/~n~r'+ls_nacionalidad

ls_ya_no="si"
FOR li_cont=1 TO dw_titulos_obtenidos.rowcount()
	if dw_titulos_obtenidos.object.carreras_carrera[li_cont]=ls_carrera then
		if ls_nivel='L' then
			respuesta=respuesta+'/~n~rtit. Lic. '+string(ls_carrera)
		else
			respuesta=respuesta+'/~n~rtit. Pos. '+string(ls_carrera)
		end if
		respuesta=respuesta+' '+string(lr_promedio,"#,##0.00")
		ls_ya_no="no"
	else
		respuesta=respuesta+'/~n~rtit. '+dw_titulos_obtenidos.object.carreras_carrera[li_cont]
	end if
	respuesta=respuesta+' '+string(dw_titulos_obtenidos.object.titulacion_fecha_examen[li_cont],"d-m-yy")
	if dw_titulos_obtenidos.object.titulacion_mencion[li_cont]=1 then
		respuesta=respuesta+' Con mención'
	end if
	if dw_titulos_obtenidos.object.titulacion_reconocimiento[li_cont]=1 then
		respuesta=respuesta+' Con reconocimiento'
	end if
NEXT

if ls_ya_no="si" then
	if li_egresado=0 then
		respuesta=respuesta+'/~n~rest. '+string(li_sem_cursados)+'o. sem.'
	else
		respuesta=respuesta+'/~n~rpas.'
	end if
	if ls_nivel='L' then
		respuesta=respuesta+' Lic. '+string(ls_carrera)
	else
		respuesta=respuesta+' Pos. '+string(ls_carrera)
	end if
	respuesta=respuesta+' '+string(lr_promedio,"#,##0.00")
end if

if ls_lic_nombre<>"" and ls_lic_nombre<>"----------" then
	respuesta=respuesta+'/~n~rLic. '+ls_lic_nombre
	if ls_lic_ini<>"" then
		respuesta=respuesta+' '+ls_lic_ini
	end if
	if ls_lic_fin<>"" then
		respuesta=respuesta+' '+ls_lic_fin
	end if
	if ls_lic_uni<>"" then
		respuesta=respuesta+' '+ls_lic_uni
	end if
	if ls_lic_nivel<>"" then
		respuesta=respuesta+' '+ls_lic_nivel
	end if
	if ls_lic_sem<>"" then
		respuesta=respuesta+' '+ls_lic_sem+'o. sem.'
	end if
	if ls_lic_fecha_tit<>"" then
		respuesta=respuesta+' '+ls_lic_fecha_tit
	end if
	if ls_lic_prom<>"" then
		respuesta=respuesta+' '+ls_lic_prom
	end if
end if

if ls_pos_nombre<>"" then
	respuesta=respuesta+'/~n~rPos. '+ls_pos_nombre
	if ls_pos_ini<>"" then
		respuesta=respuesta+' '+ls_pos_ini
	end if
	if ls_pos_fin<>"" then
		respuesta=respuesta+' '+ls_pos_fin
	end if
	if ls_pos_uni<>"" then
		respuesta=respuesta+' '+ls_pos_uni
	end if
	if ls_pos_nivel<>"" then
		respuesta=respuesta+' '+ls_pos_nivel
	end if
	if ls_pos_sem<>"" then
		respuesta=respuesta+' '+ls_pos_sem+'o. sem.'
	end if
	if ls_pos_fecha_tit<>"" then
		respuesta=respuesta+' '+ls_pos_fecha_tit
	end if
end if

if ls_otro_nombre_1<>"" then
	respuesta=respuesta+'/~n~rOtro Estudio: '+ls_otro_nombre_1
end if
if ls_otro_uni_1<>"" then
	respuesta=respuesta+' en '+ls_otro_uni_1
end if

if ls_otro_nombre_2<>"" then
	respuesta=respuesta+'/~n~rOtro Estudio: '+ls_otro_nombre_2
end if
if ls_otro_uni_2<>"" then
	respuesta=respuesta+' en '+ls_otro_uni_2
end if

if ls_otro_nombre_3<>"" then
	respuesta=respuesta+'/~n~rOtro Estudio: '+ls_otro_nombre_3
end if
if ls_otro_uni_3<>"" then
	respuesta=respuesta+' en '+ls_otro_uni_3
end if

if ls_areas<>"" then
	respuesta=respuesta+'/~n~rAreas de Interes: '+ls_areas
end if

if ls_sueldo<>"" then
	respuesta=respuesta+'/~n~rSueldo: '+ls_sueldo
end if

if ls_puesto_1<>"" then
	respuesta=respuesta+'/~n~rExp. '
	if ls_anios_1<>"" then
		respuesta=respuesta+ls_anios_1+' años '
	end if
	if ls_meses_1<>"" then
		respuesta=respuesta+ls_meses_1+' m. '
	end if
   respuesta=respuesta+ls_puesto_1
end if

if ls_puesto_2<>"" then
	respuesta=respuesta+'/~n~rExp. '
	if ls_anios_2<>"" then
		respuesta=respuesta+ls_anios_2+' años '
	end if
	if ls_meses_2<>"" then
		respuesta=respuesta+ls_meses_2+' m. '
	end if
   respuesta=respuesta+ls_puesto_2
end if

if ls_puesto_3<>"" then
	respuesta=respuesta+'/~n~rExp. '
	if ls_anios_3<>"" then
		respuesta=respuesta+ls_anios_3+' años '
	end if
	if ls_meses_3<>"" then
		respuesta=respuesta+ls_meses_3+' m. '
	end if
   respuesta=respuesta+ls_puesto_3
end if

if ls_puesto_4<>"" then
	respuesta=respuesta+'/~n~rExp. '
	if ls_anios_4<>"" then
		respuesta=respuesta+ls_anios_4+' años '
	end if
	if ls_meses_4<>"" then
		respuesta=respuesta+ls_meses_4+' m. '
	end if
   respuesta=respuesta+ls_puesto_4
end if

if ls_puesto_5<>"" then
	respuesta=respuesta+'/~n~rExp. '
	if ls_anios_5<>"" then
		respuesta=respuesta+ls_anios_5+' años '
	end if
	if ls_meses_5<>"" then
		respuesta=respuesta+ls_meses_5+' m. '
	end if
   respuesta=respuesta+ls_puesto_5
end if

if ls_idioma_1<>"" then
	respuesta=respuesta+'/~n~r'+ls_idioma_1+' '
	if ls_idioma1<>"" then
		respuesta=respuesta+ls_idioma1+'%'
	end if
end if

if ls_idioma_2<>"" then
	respuesta=respuesta+'/~n~r'+ls_idioma_2+' '
	if ls_idioma2<>"" then
		respuesta=respuesta+ls_idioma2+'%'
	end if
end if

if ls_idioma_3<>"" then
	respuesta=respuesta+'/~n~r'+ls_idioma_3+' '
	if ls_idioma3<>"" then
		respuesta=respuesta+ls_idioma3+'%'
	end if
end if

if ls_idioma_4<>"" then
	respuesta=respuesta+'/~n~r'+ls_idioma_4+' '
	if ls_idioma4<>"" then
		respuesta=respuesta+ls_idioma4+'%'
	end if
end if

CHOOSE CASE ls_viajar
	CASE "si"
		respuesta=respuesta+'/~n~rDisp. para viajar'
	CASE "ocasionalmente"
		respuesta=respuesta+'/~n~rDisp. para viajar Ocasionalmente'
	CASE "negociable"
		respuesta=respuesta+'/~n~rDisp. para viajar Negociable'
END CHOOSE

CHOOSE CASE ls_cambio_res
	CASE "si"
		respuesta=respuesta+'/~n~rDisp. para cambiar residencia'
	CASE "ocasionalmente"
		respuesta=respuesta+'/~n~rDisp. para cambiar residencia Ocasionalmente'
	CASE "negociable"
		respuesta=respuesta+'/~n~rDisp. para cambiar residencia Negociable'
END CHOOSE

if ls_observaciones<>"" then
	respuesta=respuesta+'/~n~rNota: '+ls_observaciones+'~n~r'
end if

DESTROY dw_titulos_obtenidos

return respuesta
end event

type dw_horarios from datawindow within w_correo_electronico_ant
event type integer agrega ( string linea )
integer y = 852
integer width = 3543
integer height = 1036
integer taborder = 10
string dataobject = "dw_horarios"
boolean vscrollbar = true
boolean livescroll = true
end type

event agrega;/*
DESCRIPCIÓN: Obtiene el horario de las materias que el alumno solicito.
PARÁMETROS: linea leída del archivo del correo.
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
string ls_clave[10]
int li_a,li_cont
long ll_renglon

visible=true

FOR li_cont=1 TO 10	
	li_a=Pos (linea, "	")
	if li_a=0 then
		ls_clave[li_cont]=linea
		if Pos(ls_clave[li_cont], "materia_")=1 then
			ls_clave[li_cont]=Right(ls_clave[li_cont],len(ls_clave[li_cont])-10)
		else
			ls_clave[li_cont]=""
		end if
	else
		ls_clave[li_cont]=Left (linea, li_a -1)
		if Pos(ls_clave[li_cont], "materia_")=1 then
			ls_clave[li_cont]=Right(ls_clave[li_cont],len(ls_clave[li_cont])-10)
			linea=mid(linea,li_a+1)
		else
			ls_clave[li_cont]=""
		end if
	end if
NEXT

is_respuesta=is_respuesta+"Horario de Materias "+string(gi_periodo)+' '+string(gi_anio)+':~n~r~n~r'
is_respuesta=is_respuesta+"cve_mat Materia~n~r"
is_respuesta=is_respuesta+"	Grupo	Estado		Cupo	Preinsc	Inscritos	Profesor~n~r"
is_respuesta=is_respuesta+"		Salón		Horario~n~r"

FOR li_cont=1 TO 10
	if long(ls_clave[li_cont])<>0 then
		retrieve(long(ls_clave[li_cont]),gi_periodo,gi_anio)
		if rowcount()>0 then
			is_respuesta=is_respuesta+'~n~r'+string(object.grupos_cve_mat[1])+'	'+&
				object.materias_materia[1]+'~n~r'
			FOR ll_renglon=1 TO rowcount()
				if ll_renglon=1 then
					is_respuesta=is_respuesta+'~n~r	'+object.grupos_gpo[ll_renglon]
					is_respuesta=is_respuesta+'	'+string(object.condicion_gpo_condicion[ll_renglon],"@@@@@@@@@")
					is_respuesta=is_respuesta+'	'+string(object.grupos_cupo[ll_renglon],"##,00")
					is_respuesta=is_respuesta+'	'+cuenta_preinsc(object.grupos_cve_mat[1],object.grupos_gpo[ll_renglon])
					is_respuesta=is_respuesta+'	'+string(object.grupos_inscritos[ll_renglon],"##,00")
					is_respuesta=is_respuesta+'	'+object.profesor_nombre_completo[ll_renglon]+'~n~r~n~r'
				elseif object.grupos_gpo[ll_renglon]<>object.grupos_gpo[ll_renglon -1] then
					is_respuesta=is_respuesta+'~n~r	'+object.grupos_gpo[ll_renglon]
					is_respuesta=is_respuesta+'	'+string(object.condicion_gpo_condicion[ll_renglon],"@@@@@@@@@")
					is_respuesta=is_respuesta+'	'+string(object.grupos_cupo[ll_renglon],"##,00")
					is_respuesta=is_respuesta+'	'+cuenta_preinsc(object.grupos_cve_mat[1],object.grupos_gpo[ll_renglon])
					is_respuesta=is_respuesta+'	'+string(object.grupos_inscritos[ll_renglon],"##,00")
					is_respuesta=is_respuesta+'	'+object.profesor_nombre_completo[ll_renglon]+'~n~r~n~r'
				end if
				if not isnull(object.horario_cve_salon[ll_renglon]) then
					is_respuesta=is_respuesta+'		'+object.horario_cve_salon[ll_renglon]
				else
					is_respuesta=is_respuesta+'		'
				end if
				if not isnull(object.grupos_cve_asimilada[ll_renglon]) then
					is_respuesta=is_respuesta+'	Asimilada a:	'+string(object.grupos_cve_asimilada[ll_renglon])
					is_respuesta=is_respuesta+'-'+object.grupos_gpo_asimilado[ll_renglon]+'~n~r'
				elseif not isnull(object.horario_hora_inicio[ll_renglon]) then
					is_respuesta=is_respuesta+'	'+string(object.horario_hora_inicio[ll_renglon],"##,00")+':00'
					is_respuesta=is_respuesta+'	'+string(object.horario_hora_final[ll_renglon],"##,00")+':00'
					is_respuesta=is_respuesta+'	'+object.dias_dia[ll_renglon]+'~n~r'
				else
					is_respuesta=is_respuesta+'	Por Asesoría~n~r'
				end if
			NEXT
		end if
	end if
NEXT

visible=false

RETURN 0
end event

type dw_mat_preinsc from uo_dw_captura within w_correo_electronico_ant
event constructor pbm_constructor
event borra ( )
event type integer busca ( long materia )
event type integer agrega ( string linea )
integer x = 0
integer y = 852
integer width = 3552
integer height = 1024
integer taborder = 0
string dataobject = "d_mat_preinsc"
end type

event borra;/*
DESCRIPCIÓN: En caso de que se desee editar manualmente las materias, con este evento se
				 podrá una de ellas.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
setfocus()
deleterow(getrow())
end event

event busca;call super::busca;/*
DESCRIPCIÓN: Busca la materia que se pasa de parámetro dentro de las de este dw.
PARÁMETROS: materia
REGRESA: Posición de la materia en el dw, 0 si no la encuentra.
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
long ll_cont
FOR ll_cont=1 TO rowcount()
	if materia=object.cve_mat[ll_cont] then
		return ll_cont
	end if
NEXT

return 0
end event

event agrega;/*
DESCRIPCIÓN: Verifica que este preinscrito.
				 Si no esta preinscrito, lo preinscribe. Checa carrera, plan y nivel. Lee las
				 materias que eligió. Carga las materias que ya tenía preinscritas. Complétalas 
				 o corrígelas. Verifica el nuevo status de cada una y guarda los cambios.
PARÁMETROS: linea leída del archivo del correo.
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
string ls_clave[10]
string ls_grupo[10], ls_accion[10], ls_nivel
int li_a,li_cont,li_status,li_carr,li_plan
long ll_renglon,ll_folio

visible=true

setnull(ll_folio)

SELECT preinsc.folio
INTO :ll_folio
FROM preinsc
WHERE preinsc.cuenta = :il_cuenta and periodo=:gi_periodo and anio=:gi_anio
USING gtr_sce;
commit USING gtr_sce;

if isnull(ll_folio) then
	
	if il_periodo_preinsc<>1 then
		visible=false
		is_respuesta=is_respuesta+"~n~rLo siento, no estamos en tiempo de preinscripciones."
		return 0
	end if
	
//	if (revisaadeudosinscripcion(il_cuenta,is_respuesta)<>0) then
//		return 0
//	end if
revisaadeudosinscripcion(il_cuenta,is_respuesta,1)
is_respuesta += "~n"
	
	SELECT max(preinsc.folio)
	INTO :ll_folio
	FROM preinsc
	WHERE periodo=:gi_periodo and anio=:gi_anio
	USING gtr_sce;
	commit USING gtr_sce;
	
	if isnull(ll_folio) or ll_folio<100000 then
		ll_folio=100000
	else
		ll_folio=ll_folio+1
	end if
	
	INSERT INTO preinsc
	( cuenta,folio,status,periodo,anio )
	VALUES ( :il_cuenta,:ll_folio,2,:gi_periodo,:gi_anio )
	USING gtr_sce;
	
	if gtr_sce.sqlerrtext<>"" then
		messagebox("Error en Pre-Inscripción",gtr_sce.sqlerrtext)
		rollback using gtr_sce;
		return 0
	else
		commit using gtr_sce;
	end if
end if
//if (revisaadeudosinscripcion(il_cuenta,is_respuesta)<>0) then
//	if Pos(is_respuesta,"preinscripción")>0 then
//		is_respuesta = replace(is_respuesta,Pos(is_respuesta,"preinscripción"),14,"trámite")
//	end if
//	return 0
//end if

SELECT academicos.nivel,academicos.cve_carrera,academicos.cve_plan
INTO :ls_nivel,:li_carr,:li_plan
FROM academicos
WHERE academicos.cuenta = :il_cuenta
USING gtr_sce;
commit USING gtr_sce;

FOR li_cont=1 TO 10
	li_a=Pos (linea, "	")
	ls_clave[li_cont]=Left (linea, li_a -1)
	if Pos(ls_clave[li_cont], "materia_")=1 then
		ls_clave[li_cont]=Right(ls_clave[li_cont],len(ls_clave[li_cont])-10)
		linea=mid(linea,li_a+1)
	else
		ls_clave[li_cont]=""
	end if

	li_a=Pos (linea, "	")
	ls_grupo[li_cont]=Left (linea, li_a -1)
	if Pos(ls_grupo[li_cont], "grupo_")=1 then
		ls_grupo[li_cont]=Upper(Right(ls_grupo[li_cont],len(ls_grupo[li_cont])-8))
		linea=mid(linea,li_a+1)
	else
		ls_grupo[li_cont]=""
	end if
	
	li_a=Pos (linea, "	")
	if li_a=0 then
		ls_accion[li_cont]=linea
		if Pos(ls_accion[li_cont], "accion_")=1 then
			ls_accion[li_cont]=Right(ls_accion[li_cont],len(ls_accion[li_cont])-9)
		else
			ls_accion[li_cont]=""
		end if
	else
		ls_accion[li_cont]=Left (linea, li_a -1)
		if Pos(ls_accion[li_cont], "accion_")=1 then
			ls_accion[li_cont]=Right(ls_accion[li_cont],len(ls_accion[li_cont])-9)
			linea=mid(linea,li_a+1)
		else
			ls_accion[li_cont]=""
		end if
	end if
NEXT

retrieve(il_cuenta)

if il_periodo_preinsc=1 then
	FOR li_cont=1 TO 10
		if long(ls_clave[li_cont])<>0 then
			ll_renglon=event busca(long(ls_clave[li_cont]))
			if ls_accion[li_cont]="Insertar" then
				if ll_renglon=0 then
					insertrow(0)
					ll_renglon=rowcount()
					object.cuenta[ll_renglon]=il_cuenta
					object.cve_mat[ll_renglon]=long(ls_clave[li_cont])
					object.gpo[ll_renglon]=val_grupo(ls_grupo[li_cont])
					object.periodo[ll_renglon]=gi_periodo
					object.anio[ll_renglon]=gi_anio
				else
					object.gpo[ll_renglon]=val_grupo(ls_grupo[li_cont])
				end if
			else
				if ll_renglon<>0 then
					deleterow(ll_renglon)
				end if
			end if
		end if
	NEXT
end if

FOR ll_renglon=1 TO rowcount()
	if gi_periodo=object.periodo[ll_renglon] and gi_anio=object.anio[ll_renglon] then
		li_status=f_e_mat(object.cve_mat[ll_renglon])
		li_status=f_e_grup(object.cve_mat[ll_renglon],val_grupo(object.gpo[ll_renglon]))+li_status
		li_status=f_e_plan(ls_nivel,li_carr,li_plan,object.cve_mat[ll_renglon])+li_status
		li_status=f_no_curso(il_cuenta,object.cve_mat[ll_renglon])+li_status
		li_status=f_puede_integracion(il_cuenta,object.cve_mat[ll_renglon])+li_status
		li_status=f_puede_cursar(il_cuenta,object.cve_mat[ll_renglon],li_carr,li_plan)+li_status
		object.status[ll_renglon]=li_status
	end if
NEXT

if event actualiza_0_int()=-1 then
	RETURN -1
end if

is_respuesta=is_respuesta+"Comprobante de Preinscripción #"+string(ll_folio)+'~n~r'
is_respuesta=is_respuesta+"Materias Preinscritas "
choose case gi_periodo 
	case 0
		is_respuesta += " Primavera"
	case 1
		is_respuesta += " Verano"
	case 2
		is_respuesta += " Otoño"
end choose
is_respuesta += ' '+string(gi_anio)+':~n~r~n~r'+"Preinsc	Materia	Gpo				Diagnóstico~n~r~n~r"
FOR ll_renglon=1 TO rowcount()
	if gi_periodo=object.periodo[ll_renglon] and gi_anio=object.anio[ll_renglon] then
		is_respuesta=is_respuesta+&
			cuenta_preinsc(object.cve_mat[ll_renglon],val_grupo(object.gpo[ll_renglon]))+'	'+&
			string(object.cve_mat[ll_renglon])+'	'+val_grupo(object.gpo[ll_renglon])+'	'+&
			object.diag[ll_renglon]+'~n~r'
	end if
NEXT

visible=false

RETURN 0
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

event actualiza_0_int;/*
DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
				Este evento no presenta interacción con el usuario
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/
AcceptText()
if ModifiedCount()+DeletedCount() > 0 Then
/*Función que solo actualiza*/
	if update(true) = 1 then		
		/*Si es asi, guardalo en la tabla y avisa.*/
		commit using gtr_sce;	
		return 1
	else
		/*De lo contrario, desecha los cambios (todos) y avisa*/
		rollback using gtr_sce;		
		return -1
	end if
else
	return 1
end if
end event

type st_atendidos from statictext within w_correo_electronico_ant
integer y = 852
integer width = 3543
integer height = 1036
integer textsize = -190
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 16777215
boolean enabled = false
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_materias_inscritas from datawindow within w_correo_electronico_ant
integer y = 860
integer width = 2400
integer height = 556
integer taborder = 20
string dataobject = "dw_materias_inscritas"
boolean livescroll = true
end type

type dw_lugar_preinsc from datawindow within w_correo_electronico_ant
integer x = 5
integer y = 860
integer width = 1605
integer height = 448
integer taborder = 40
string dataobject = "dw_lugar_preinsc"
boolean livescroll = true
end type

