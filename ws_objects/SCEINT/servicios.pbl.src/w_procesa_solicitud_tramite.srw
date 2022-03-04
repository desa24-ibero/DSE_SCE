$PBExportHeader$w_procesa_solicitud_tramite.srw
forward
global type w_procesa_solicitud_tramite from w_main
end type
type cb_consultar_tramites from u_cb within w_procesa_solicitud_tramite
end type
type cb_consultar_motor from u_cb within w_procesa_solicitud_tramite
end type
type dw_bit_timer from u_dw within w_procesa_solicitud_tramite
end type
type mle_procesamiento from u_mle within w_procesa_solicitud_tramite
end type
type cb_limpiar_respuesta from u_cb within w_procesa_solicitud_tramite
end type
type cb_copiar_respuesta from u_cb within w_procesa_solicitud_tramite
end type
type st_2 from u_st within w_procesa_solicitud_tramite
end type
type mle_respuesta from u_mle within w_procesa_solicitud_tramite
end type
type cb_1 from u_cb within w_procesa_solicitud_tramite
end type
type st_1 from u_st within w_procesa_solicitud_tramite
end type
type st_estatus_timer from u_st within w_procesa_solicitud_tramite
end type
type cb_iniciar_timer from u_cb within w_procesa_solicitud_tramite
end type
type cb_detener_timer from u_cb within w_procesa_solicitud_tramite
end type
type ui_tramite_control_escolar from uo_tramite_control_escolar within w_procesa_solicitud_tramite
end type
type cb_procesar_pendientes from u_cb within w_procesa_solicitud_tramite
end type
type p_estatus_motor_transferencia from u_p within w_procesa_solicitud_tramite
end type
type st_estatus_motor_transferencia from u_st within w_procesa_solicitud_tramite
end type
type gb_estatus_motor_transferencia from u_gb within w_procesa_solicitud_tramite
end type
type gb_timer from u_gb within w_procesa_solicitud_tramite
end type
type gb_tramites_pendientes from u_gb within w_procesa_solicitud_tramite
end type
type gb_1 from u_gb within w_procesa_solicitud_tramite
end type
type gb_2 from u_gb within w_procesa_solicitud_tramite
end type
type dw_procesa_solicitud_tramite from u_dw within w_procesa_solicitud_tramite
end type
end forward

global type w_procesa_solicitud_tramite from w_main
boolean visible = false
integer width = 4306
integer height = 3344
string title = "Solicitudes por Internet"
string menuname = "m_menu_salir"
windowstate windowstate = maximized!
cb_consultar_tramites cb_consultar_tramites
cb_consultar_motor cb_consultar_motor
dw_bit_timer dw_bit_timer
mle_procesamiento mle_procesamiento
cb_limpiar_respuesta cb_limpiar_respuesta
cb_copiar_respuesta cb_copiar_respuesta
st_2 st_2
mle_respuesta mle_respuesta
cb_1 cb_1
st_1 st_1
st_estatus_timer st_estatus_timer
cb_iniciar_timer cb_iniciar_timer
cb_detener_timer cb_detener_timer
ui_tramite_control_escolar ui_tramite_control_escolar
cb_procesar_pendientes cb_procesar_pendientes
p_estatus_motor_transferencia p_estatus_motor_transferencia
st_estatus_motor_transferencia st_estatus_motor_transferencia
gb_estatus_motor_transferencia gb_estatus_motor_transferencia
gb_timer gb_timer
gb_tramites_pendientes gb_tramites_pendientes
gb_1 gb_1
gb_2 gb_2
dw_procesa_solicitud_tramite dw_procesa_solicitud_tramite
end type
global w_procesa_solicitud_tramite w_procesa_solicitud_tramite

type variables
n_tr itr_parametros_iniciales
n_tr 	itr_sit, itr_esta, itr_bus,itr_web
n_tr itr_seguridad, itr_original, itr_mssqlserver
boolean ib_procesando = false
long il_num_intentos = 3, il_segundos = 0
//nombre de la conexion en parametros_conexion
CONSTANT	string	is_controlescolar_cnx	=	"controlescolar_baja_total"
CONSTANT	string	is_tesoreria_cnx			=	"controlescolar_inscripcion_tesoreria"
CONSTANT	string	is_becas_cnx				=	"controlescolar_inscripcion_becas"
end variables

forward prototypes
public function integer of_obten_estatus_transferencia (boolean ab_envia_mensaje)
public function integer wf_insert_bit_timer (long al_cve_tramite, long al_cuenta, string as_classname, datetime adttm_fecha, integer ai_exito, long al_num_registros, string as_mensaje)
public function integer wf_revisa_adeudo ()
end prototypes

public function integer of_obten_estatus_transferencia (boolean ab_envia_mensaje);//of_obten_estatus_transferencia
//Devuelve int  si está detenida
//			  0, Si el proceso no esta detenido.
//			  1, Si el proceso si esta detenido.
//        -1, Si hay un error
//Actualiza textos e imágenes en la pantalla

int li_detenido
string ls_error, ls_estatus_motor_transferencia, ls_archivo_semaforo

li_detenido = f_trans_sql_syb_detenido(ls_error)
//			  0, Si el proceso no esta detenido.
//			  1, Si el proceso si esta detenido.
//        -1, Si hay un error

choose case li_detenido
	//PROCESO DE TRANSFERENCIA EJECUTANDOSE		
	case 0
		ls_estatus_motor_transferencia = "EJECUTANDOSE"
		ls_archivo_semaforo = 'semaforo_manual_verde.bmp'
	// PROCESO DE TRANSFERENCIA DETENIDO
	case 1
		if ab_envia_mensaje then
			Messagebox("Aviso","El proceso de tranferencia de movimientos de estacionamiento esta detenido actualmente por otro proceso, intente mas tarde...")
		end if
		ls_estatus_motor_transferencia = "DETENIDO"
		ls_archivo_semaforo = 'semaforo_manual_rojo.bmp'


	// ERROR AL CONSULTAR EL ESTATUS DEL PROCESO DE TRANSFERENCIA
	case else
		ls_estatus_motor_transferencia = "ERROR AL CONSULTAR"
		ls_archivo_semaforo = 'semaforo_manual_amarillo.bmp'

		if ab_envia_mensaje then
			Messagebox("Error", "Error al consultar estatus de proceso de transferencia movimientos de estacionamiento~n" + ls_error)
		end if
		return -1
end choose


st_estatus_motor_transferencia.TEXT = ls_estatus_motor_transferencia
p_estatus_motor_transferencia.PictureName = ls_archivo_semaforo

return li_detenido

end function

public function integer wf_insert_bit_timer (long al_cve_tramite, long al_cuenta, string as_classname, datetime adttm_fecha, integer ai_exito, long al_num_registros, string as_mensaje);// wf_insert_bit_timer
//Recibe:
//al_cve_tramite		long
//al_cuenta			long
//as_classname		string
//adttm_fecha			datetime	
//ai_exito				integer
//al_num_registros	long
//as_mensaje			string


long ll_newrow, ll_rows_totales
integer li_update

ll_newrow = dw_bit_timer.InsertRow(0)
dw_bit_timer.ScrollToRow(ll_newrow)

dw_bit_timer.SetItem(ll_newrow, "cve_tramite", al_cve_tramite)
dw_bit_timer.SetItem(ll_newrow, "cuenta", al_cuenta)
dw_bit_timer.SetItem(ll_newrow, "classname", as_classname)
dw_bit_timer.SetItem(ll_newrow, "exito", ai_exito)
dw_bit_timer.SetItem(ll_newrow, "num_registros", al_num_registros)
dw_bit_timer.SetItem(ll_newrow, "mensaje", as_mensaje)

li_update = dw_bit_timer.Update()
if li_update= 1 then
	COMMIT USING gtr_sce;
	ll_rows_totales = dw_bit_timer.Retrieve()
	dw_bit_timer.ScrollToRow(ll_rows_totales)
else
	ROLLBACK USING gtr_sce;
end if


return li_update





end function

public function integer wf_revisa_adeudo ();int li_revisa_ade

if conecta_bd(itr_web,gs_sweb, gs_usuario,gs_password)<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de Control Escolar WEB", StopSign!)
	return -1
End if

SELECT revisa_adeudo_baja_total  
	into :li_revisa_ade
FROM parametros_servicios  
WHERE cve_parametro = 1   using itr_web; 

if isvalid(itr_web) then
	desconecta_bd_n_tr(itr_web)
end if

if isnull(li_revisa_ade) and li_revisa_ade = 0 then
	return 0
else
	return li_revisa_ade
end if

end function

on w_procesa_solicitud_tramite.create
int iCurrent
call super::create
if this.MenuName = "m_menu_salir" then this.MenuID = create m_menu_salir
this.cb_consultar_tramites=create cb_consultar_tramites
this.cb_consultar_motor=create cb_consultar_motor
this.dw_bit_timer=create dw_bit_timer
this.mle_procesamiento=create mle_procesamiento
this.cb_limpiar_respuesta=create cb_limpiar_respuesta
this.cb_copiar_respuesta=create cb_copiar_respuesta
this.st_2=create st_2
this.mle_respuesta=create mle_respuesta
this.cb_1=create cb_1
this.st_1=create st_1
this.st_estatus_timer=create st_estatus_timer
this.cb_iniciar_timer=create cb_iniciar_timer
this.cb_detener_timer=create cb_detener_timer
this.ui_tramite_control_escolar=create ui_tramite_control_escolar
this.cb_procesar_pendientes=create cb_procesar_pendientes
this.p_estatus_motor_transferencia=create p_estatus_motor_transferencia
this.st_estatus_motor_transferencia=create st_estatus_motor_transferencia
this.gb_estatus_motor_transferencia=create gb_estatus_motor_transferencia
this.gb_timer=create gb_timer
this.gb_tramites_pendientes=create gb_tramites_pendientes
this.gb_1=create gb_1
this.gb_2=create gb_2
this.dw_procesa_solicitud_tramite=create dw_procesa_solicitud_tramite
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_consultar_tramites
this.Control[iCurrent+2]=this.cb_consultar_motor
this.Control[iCurrent+3]=this.dw_bit_timer
this.Control[iCurrent+4]=this.mle_procesamiento
this.Control[iCurrent+5]=this.cb_limpiar_respuesta
this.Control[iCurrent+6]=this.cb_copiar_respuesta
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.mle_respuesta
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.st_estatus_timer
this.Control[iCurrent+12]=this.cb_iniciar_timer
this.Control[iCurrent+13]=this.cb_detener_timer
this.Control[iCurrent+14]=this.ui_tramite_control_escolar
this.Control[iCurrent+15]=this.cb_procesar_pendientes
this.Control[iCurrent+16]=this.p_estatus_motor_transferencia
this.Control[iCurrent+17]=this.st_estatus_motor_transferencia
this.Control[iCurrent+18]=this.gb_estatus_motor_transferencia
this.Control[iCurrent+19]=this.gb_timer
this.Control[iCurrent+20]=this.gb_tramites_pendientes
this.Control[iCurrent+21]=this.gb_1
this.Control[iCurrent+22]=this.gb_2
this.Control[iCurrent+23]=this.dw_procesa_solicitud_tramite
end on

on w_procesa_solicitud_tramite.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_consultar_tramites)
destroy(this.cb_consultar_motor)
destroy(this.dw_bit_timer)
destroy(this.mle_procesamiento)
destroy(this.cb_limpiar_respuesta)
destroy(this.cb_copiar_respuesta)
destroy(this.st_2)
destroy(this.mle_respuesta)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.st_estatus_timer)
destroy(this.cb_iniciar_timer)
destroy(this.cb_detener_timer)
destroy(this.ui_tramite_control_escolar)
destroy(this.cb_procesar_pendientes)
destroy(this.p_estatus_motor_transferencia)
destroy(this.st_estatus_motor_transferencia)
destroy(this.gb_estatus_motor_transferencia)
destroy(this.gb_timer)
destroy(this.gb_tramites_pendientes)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.dw_procesa_solicitud_tramite)
end on

event open;call super::open;int li_chk, li_detenido, li_obten_parametros_timer
string ls_error, ls_estatus_motor_transferencia, ls_archivo_semaforo, ls_name
long ll_row_tramite, ll_todos, ll_minutos, ll_segundos, ll_num_intentos
this.x = 1
this.y = 1

n_cst_infoattrib  lnv_info

ls_name = this.classname()


//Muestra el nombre de la ventana
//MessageBox("Info", "Description: "+ls_name)

li_obten_parametros_timer = f_obten_parametros_timer(ls_name, ll_minutos, ll_segundos, ll_num_intentos )

if li_obten_parametros_timer= -1 then
	messagebox("Error en parámetros del timer","No es posible configurar el timer de la ventana...", StopSign!)
	return -1	
end if

il_num_intentos = ll_num_intentos
il_segundos = ll_segundos

//Conección a Estacionamiento
if f_conecta_con_parametros_n_tr_bd(gtr_sce, itr_esta, 3 )=0 then
	messagebox("Atención...", "Problemas al conectarse a la bd de estacionamiento")
	return -1
end if 


//Conección a IberoBus
if f_conecta_con_parametros_bd(gtr_sce, itr_bus, 4 )=0 then
	messagebox("Atención...", "Problemas al conectarse a la bd de Iberobus")
	return -1
end if 


//Conección a Tesorería
if f_conecta_pas_parametros_n_tr_bd(gtr_sce, itr_sit, 2, gs_usuario, gs_password )=0 then
	messagebox("Atención...", "Problemas al conectarse a la bd de tesoreria")
	return -1
else
	gtr_sit = itr_sit
end if 

li_detenido =of_obten_estatus_transferencia(false)
//			  0, Si el proceso no esta detenido.
//			  1, Si el proceso si esta detenido.
//        -1, Si hay un error

//1)->

itr_parametros_iniciales = gtr_sce

li_chk	=	f_conecta_pas_parametros_act_n_tr_bd(itr_parametros_iniciales,itr_mssqlserver,is_controlescolar_cnx,gs_usuario,gs_password,1)
if li_chk <> 1 then return

//1)<-

dw_procesa_solicitud_tramite.SetTransObject(itr_mssqlserver)

ll_todos = 9999
ll_row_tramite =ui_tramite_control_escolar.dw_1.GetRow()
ui_tramite_control_escolar.dw_1.SetItem(ll_row_tramite,'clave', ll_todos)
ui_tramite_control_escolar.dw_1.AcceptText()


Timer(ll_segundos)
st_estatus_timer.text = "Ejecutándose cada ["+string(ll_minutos)+"] minutos"

dw_bit_timer.SetTransObject(gtr_sce)
dw_procesa_solicitud_tramite.SetRowFocusIndicator(Hand!)

end event

event timer;call super::timer;cb_procesar_pendientes.event clicked()
end event

event close;call super::close;if isvalid(itr_esta) then
	desconecta_bd_n_tr(itr_esta)
end if
if isvalid(itr_bus) then
	desconecta_bd_n_tr(itr_bus)
end if
if isvalid(itr_sit) then
	desconecta_bd_n_tr(itr_sit)
end if

end event

type cb_consultar_tramites from u_cb within w_procesa_solicitud_tramite
integer x = 1408
integer y = 388
integer width = 494
integer height = 88
integer taborder = 50
string text = "Consultar Trámites"
end type

event clicked;call super::clicked;long ll_clave, ll_num_rows

ll_clave = ui_tramite_control_escolar.of_obten_clave()


DATAWINDOWCHILD ldwc
dw_procesa_solicitud_tramite.GETCHILD("cve_carrera", ldwc) 
ldwc.SETTRANSOBJECT(gtr_sce) 
ldwc.RETRIEVE(gs_tipo_periodo)

ll_num_rows = dw_procesa_solicitud_tramite.Retrieve(ll_clave)

if ll_num_rows= -1 then
	MessageBox("ERROR", "No es posible consultar las solicitudes", StopSign!)	
	ib_procesando = false
	return
end if


end event

type cb_consultar_motor from u_cb within w_procesa_solicitud_tramite
integer x = 146
integer y = 740
integer width = 494
integer height = 88
integer taborder = 50
string text = "Consultar Motor"
end type

event clicked;call super::clicked;integer li_detenido
	
li_detenido =of_obten_estatus_transferencia(false)
end event

type dw_bit_timer from u_dw within w_procesa_solicitud_tramite
integer x = 64
integer y = 1140
integer width = 4146
integer height = 464
integer taborder = 20
string dataobject = "d_bit_timer"
boolean hscrollbar = true
boolean resizable = true
end type

type mle_procesamiento from u_mle within w_procesa_solicitud_tramite
boolean visible = false
integer x = 919
integer y = 1008
integer width = 2555
integer height = 76
integer taborder = 50
end type

type cb_limpiar_respuesta from u_cb within w_procesa_solicitud_tramite
integer x = 2395
integer y = 912
integer width = 494
integer height = 88
integer taborder = 50
string text = "Limpiar Respuesta"
end type

event clicked;call super::clicked;long ll_row
string ls_respuesta

ll_row = dw_procesa_solicitud_tramite.GetRow()
SetNull(ls_respuesta)

dw_procesa_solicitud_tramite.SetItem(ll_row, "respuesta", ls_respuesta)


end event

type cb_copiar_respuesta from u_cb within w_procesa_solicitud_tramite
integer x = 1627
integer y = 912
integer width = 494
integer height = 88
integer taborder = 40
string text = "Copiar Respuesta"
end type

event clicked;call super::clicked;long ll_row
string ls_respuesta

ll_row = dw_procesa_solicitud_tramite.GetRow()
ls_respuesta = mle_respuesta.text

dw_procesa_solicitud_tramite.SetItem(ll_row, "respuesta", ls_respuesta)


end event

type st_2 from u_st within w_procesa_solicitud_tramite
integer x = 919
integer y = 664
integer width = 187
string text = "Texto:"
end type

type mle_respuesta from u_mle within w_procesa_solicitud_tramite
integer x = 1106
integer y = 664
integer width = 2373
integer height = 200
integer taborder = 40
end type

type cb_1 from u_cb within w_procesa_solicitud_tramite
integer x = 146
integer y = 108
integer width = 494
integer height = 88
integer taborder = 40
string text = "Iniciar Motor"
end type

event clicked;call super::clicked;integer li_detener, li_detenido
string ls_error
//1)-->
//Comentar antes de liberar
li_detener = MessageBox("Confirmación", "¿Desea arrancar el motor de transferencia? ", Question!, YesNo!)	

if li_detener <> 1 then
	MessageBox("Sin Registros", "No se arrancó el motor de transferencia", StopSign!)	
else
	//Detiene el motor de trasferencia
	if f_trans_sql_syb_detenido_update(0,ls_error) <> 1 then
		li_detenido =of_obten_estatus_transferencia(false)
		Messagebox("Error","No ha sido posible arrancar el motor de trasferencia:"+ls_error)
		return 
	end if
	li_detenido =of_obten_estatus_transferencia(false)
end if
//1)<--

end event

type st_1 from u_st within w_procesa_solicitud_tramite
integer x = 891
integer y = 292
integer width = 155
string text = "Filtrar:"
end type

type st_estatus_timer from u_st within w_procesa_solicitud_tramite
integer x = 2574
integer y = 204
integer width = 946
integer height = 156
integer weight = 700
fontcharset fontcharset = ansi!
string text = "estatus"
alignment alignment = center!
end type

type cb_iniciar_timer from u_cb within w_procesa_solicitud_tramite
integer x = 2798
integer y = 92
integer width = 494
integer height = 88
integer taborder = 40
fontcharset fontcharset = ansi!
string text = "Iniciar Timer"
end type

event clicked;call super::clicked;integer li_detener, li_obten_parametros_timer

long ll_segundos, ll_minutos, ll_num_intentos
string ls_name

ls_name = parent.classname()

li_obten_parametros_timer = f_obten_parametros_timer(ls_name, ll_minutos, ll_segundos, ll_num_intentos )

if li_obten_parametros_timer= -1 then
	messagebox("Error en parámetros del timer","No es posible configurar el timer de la ventana...", StopSign!)
	return -1	
end if

il_num_intentos = ll_num_intentos
il_segundos = ll_segundos
//Comentar antes de liberar
li_detener = MessageBox("Confirmación", "¿Desea inicial el Timer? ", Question!, YesNo!)	

if li_detener <> 1 then
	MessageBox("Sin Cambios", "No se iniciará el Timer", StopSign!)	
else
	//Inicia el timer
	Timer(ll_segundos)
	st_estatus_timer.text = "Ejecutándose cada ["+string(ll_minutos)+"] minutos"
end if

end event

type cb_detener_timer from u_cb within w_procesa_solicitud_tramite
integer x = 2798
integer y = 372
integer width = 494
integer height = 88
integer taborder = 30
string text = "Detener Timer"
end type

event clicked;call super::clicked;integer li_detener


//Comentar antes de liberar
li_detener = MessageBox("Confirmación", "¿Desea detener el Timer? ", Question!, YesNo!)	

if li_detener <> 1 then
	MessageBox("Sin Cambios", "No se detendrá el Timer", StopSign!)	
else
	//Detiene el timer
	Timer(0)
	st_estatus_timer.text = "Detenido..."
end if

end event

type ui_tramite_control_escolar from uo_tramite_control_escolar within w_procesa_solicitud_tramite
integer x = 1056
integer y = 268
integer height = 100
integer taborder = 30
end type

on ui_tramite_control_escolar.destroy
call uo_tramite_control_escolar::destroy
end on

type cb_procesar_pendientes from u_cb within w_procesa_solicitud_tramite
integer x = 1408
integer y = 108
integer width = 494
integer height = 88
integer taborder = 20
string text = "Procesar Trámites"
end type

event clicked;call super::clicked;long ll_num_rows, ll_clave, ll_row_actual, ll_cuenta, li_confirmacion, li_detener, li_cve_estatus_solicitud_tramite
int li_detenido, li_cve_tramite, li_baja_total_alumno, li_update,li_tiene_adeudos
long ll_num_intentos, ll_bajas_procesadas
n_tr 	ltr_sit, ltr_esta, ltr_bus
string ls_error, ls_text, ls_name
datetime ldttm_fecha_servidor
integer li_insert_bit_timer, ai_exito
long al_cve_tramite, al_cuenta, al_num_registros
string as_classname,as_mensaje, ls_mensaje_bt 
datetime adttm_fecha




ll_clave = ui_tramite_control_escolar.of_obten_clave()

li_detenido =of_obten_estatus_transferencia(false)

ls_name = parent.classname()
as_classname = ls_name
al_cuenta = 0
SetNull(adttm_fecha)
al_num_registros = 0
as_mensaje = ''

if ib_procesando then
	return
else
	Timer(0)
	st_estatus_timer.text = "Detenido..."
	ib_procesando = true
	SetPointer ( Hourglass!)
end if

if li_detenido = 1 then
	MessageBox("ERROR", "No es posible procesar las solicitudes cuando el motor está detenido, favor de reintentar nuevamente", StopSign!)	
	ib_procesando = false
	return
end if 

ll_num_rows = dw_procesa_solicitud_tramite.Retrieve(ll_clave)

if ll_num_rows= -1 then
	MessageBox("ERROR", "No es posible consultar las solicitudes", StopSign!)	
	ib_procesando = false
	return
elseif ll_num_rows= 0 then	
//	MessageBox("Sin Registros", "No existen solicitudes a procesar", StopSign!)	
	as_mensaje = "No existen solicitudes a procesar"
	li_insert_bit_timer = wf_insert_bit_timer(ll_clave, 0, as_classname, & 
		                                          adttm_fecha, 0, 0, as_mensaje)

	ib_procesando = false
//Inicia el timer
	Timer(il_segundos)
	st_estatus_timer.text = "Ejecutándose cada ["+string(il_segundos/60)+"] minutos"
	ib_procesando = false	
	return
end if

//
//li_confirmacion = MessageBox("Confirmación", "¿Desea procesar las solicitudes pendientes? ", Question!, YesNo!)	
//
//if li_confirmacion <> 1 then
//	MessageBox("Sin Registros", "No se realizó el procesamiento", StopSign!)	
//	ib_procesando = false
//	return	
//end if
//

//SI NO esta conectado a tesorería, se conecta
if not isvalid(itr_sit) then
	if f_conecta_pas_parametros_n_tr_bd(gtr_sce, ltr_sit, 2, gs_usuario, gs_password )=0 then
		messagebox("Atención...", "Problemas al conectarse a la bd de tesoreria")
		ib_procesando = false
		return 
	end if 
else
	ltr_sit = itr_sit
end if


//SI NO esta conectado a IberoBus, se conecta
if not isvalid(itr_bus) then
	if f_conecta_con_parametros_bd(gtr_sce, ltr_bus, 4 )=0 then
		messagebox("Atención...", "Problemas al conectarse a la bd de Iberobus")
		return -1
	end if 
else
	ltr_bus = itr_bus
end if



//SI NO esta conectado al estacionamiento, se conecta
if not isvalid(itr_esta) then
	if f_conecta_con_parametros_n_tr_bd(gtr_sce, ltr_esta, 3 )=0 then
		messagebox("Atención...", "Problemas al conectarse a la bd de estacionamiento")
		ib_procesando = false
		return 
	end if
else
	ltr_esta = itr_esta
end if

//Detiene el motor de trasferencia
if f_trans_sql_syb_detenido_update(1,ls_error) <> 1 then
	Messagebox("Error","No ha sido posible detener el motor de trasferencia:"+ls_error)
	li_detenido =of_obten_estatus_transferencia(false)
	ib_procesando = false
	return 
end if

dw_bit_timer.Reset()

li_detenido =of_obten_estatus_transferencia(false)

ll_bajas_procesadas = 0
for ll_row_actual=1 to ll_num_rows
	ll_cuenta = dw_procesa_solicitud_tramite.GetItemNumber(ll_row_actual, 'cuenta') 
	
	IF ll_cuenta = 203153 OR ll_cuenta = 206302 THEN 
		ll_cuenta = ll_cuenta
	END IF	
	
	
	li_cve_tramite = dw_procesa_solicitud_tramite.GetItemNumber(ll_row_actual, 'cve_tramite')
	li_cve_estatus_solicitud_tramite = dw_procesa_solicitud_tramite.GetItemNumber(ll_row_actual, 'cve_estatus_solicitud_tramite')
	ll_num_intentos = dw_procesa_solicitud_tramite.GetItemNumber(ll_row_actual, 'num_intentos')
	if isnull(ll_num_intentos) then ll_num_intentos= 0
//Baja Total y estatus Pendiente
	if li_cve_tramite = 4 and li_cve_estatus_solicitud_tramite= 1 and il_num_intentos >= ll_num_intentos then
		al_cve_tramite = li_cve_tramite
		al_cuenta = ll_cuenta 
		ai_exito = 1
		al_num_registros = 1
		
		dw_procesa_solicitud_tramite.ScrollToRow(ll_row_actual)
		
		 if wf_revisa_adeudo() = 1 then
			li_tiene_adeudos = tiene_adeudos(ll_cuenta, ltr_sit)
		else
			li_tiene_adeudos = 0
		end if

		if li_tiene_adeudos = 0 then
			li_baja_total_alumno = f_baja_total_alumno_c(ll_cuenta, ltr_sit, ltr_esta, ltr_bus, itr_mssqlserver,ls_mensaje_bt )
			ll_bajas_procesadas = ll_bajas_procesadas +1
			if li_baja_total_alumno = -1 then
				ai_exito = 0
				as_mensaje = "Error al ejecutar la baja total:"+ls_mensaje_bt
				li_detenido =of_obten_estatus_transferencia(false)
				ib_procesando = false
			else
		//Asigna el estatus a realizado			
		//			3- REALIZADO
				ai_exito = 1
				as_mensaje = "La baja total se ejecutó exitosamente"
				dw_procesa_solicitud_tramite.SetItem(ll_row_actual, 'cve_estatus_solicitud_tramite',3)
			end if	
		else
			ai_exito = 0
			as_mensaje = "La cuenta tiene adeudos, la baja total no procede"
		end if
		li_insert_bit_timer = wf_insert_bit_timer(al_cve_tramite, al_cuenta, as_classname, & 
		                                          adttm_fecha, ai_exito, al_num_registros, as_mensaje)
		ll_num_intentos = ll_num_intentos + 1
		dw_procesa_solicitud_tramite.SetItem(ll_row_actual, 'num_intentos',ll_num_intentos)
		li_update = dw_procesa_solicitud_tramite.Update()
		if li_update = 1 then
			commit using itr_mssqlserver;
		else				
			rollback using itr_mssqlserver;			
			Messagebox("Error","No ha sido posible  actualizar el estatus de la solicitud del alumno ["+string(ll_cuenta)+"-"+obten_digito(ll_cuenta)+"]",StopSign!)				
		end if
end if

next

//Una vez que concluye la ejecución de las bajas totales
//Inicia el motor de trasferencia
if f_trans_sql_syb_detenido_update(0,ls_error) <> 1 then
	Messagebox("Error","No ha sido posible iniciar el motor de trasferencia:"+ls_error)
	li_detenido =of_obten_estatus_transferencia(false)
	ib_procesando = false
	return -1
end if

li_detenido =of_obten_estatus_transferencia(false)
ldttm_fecha_servidor = fecha_servidor(gtr_sce)
//Messagebox("Procesamiento Exitoso","Se procesaron ["+string(ll_bajas_procesadas )+"] registros de solicitud de baja.", Information!)
//ls_text = mle_procesamiento.text
//mle_procesamiento.text =ls_text + string(ldttm_fecha_servidor,"dd/mm/yyyy hh:mm")+"|Procesamiento Exitoso|"+"Se procesaron ["+string(ll_bajas_procesadas )+"] registros de solicitud de baja total.~n"
//Inicia el timer
Timer(il_segundos)
st_estatus_timer.text = "Ejecutándose cada ["+string(il_segundos/60)+"] minutos"

ib_procesando = false
return


end event

type p_estatus_motor_transferencia from u_p within w_procesa_solicitud_tramite
integer x = 265
integer y = 228
integer width = 256
integer height = 400
string picturename = "semaforo_manual.bmp"
end type

type st_estatus_motor_transferencia from u_st within w_procesa_solicitud_tramite
integer x = 64
integer y = 656
integer width = 663
integer weight = 700
fontcharset fontcharset = ansi!
string text = "estatus"
alignment alignment = center!
end type

type gb_estatus_motor_transferencia from u_gb within w_procesa_solicitud_tramite
integer x = 37
integer y = 32
integer width = 718
integer height = 856
integer taborder = 10
string text = "Motor de Transferencia"
end type

type gb_timer from u_gb within w_procesa_solicitud_tramite
integer x = 2533
integer y = 32
integer width = 1024
integer height = 464
integer taborder = 20
string text = "Timer"
end type

type gb_tramites_pendientes from u_gb within w_procesa_solicitud_tramite
integer x = 869
integer y = 32
integer width = 1577
integer height = 464
integer taborder = 20
string text = "Trámites Pendientes"
end type

type gb_1 from u_gb within w_procesa_solicitud_tramite
integer x = 873
integer y = 540
integer width = 2688
integer height = 504
integer taborder = 30
string text = "Respuesta"
end type

type gb_2 from u_gb within w_procesa_solicitud_tramite
integer x = 46
integer y = 1064
integer width = 4201
integer height = 576
integer taborder = 40
string text = "Procesamiento"
end type

type dw_procesa_solicitud_tramite from u_dw within w_procesa_solicitud_tramite
integer x = 64
integer y = 1656
integer width = 4146
integer height = 1316
integer taborder = 10
string dataobject = "d_procesa_solicitud_tramite"
boolean hscrollbar = true
boolean resizable = true
end type

event ue_actualiza;// Personalizado para los catálogos del SIT
// Juan Campos Sánchez.
// Regresa: 1 si hace los cambios en la base de datos
// Cambios al objeto de transaccion para que permita modificar en
//	Control Escolar
// Julio-2001.
 
if this.ModifiedCount() + this.DeletedCount() > 0 then 
	if this.Event pfc_Update(true,true) >= 1 then 
		commit using itr_mssqlserver;
		Messagebox("Aviso","Los cambios fueron guardados")
		return 1
	else
		rollback using itr_mssqlserver;
		Messagebox("Antención","~nAlgunos datos no son validos~n~nLos cambios NO se guardaron")	
		return 0
	end if
else
	return FAILURE 
end if

end event

