$PBExportHeader$w_bajas_totales.srw
$PBExportComments$En esta ventana se realiza el proceso  modificacón de todas las materias inscritas en las tablas de : mat_inscritas.cve_condicion como baja_Total y se modifica  grupos.insc_desp_bajas.       Juan Campos Nov-1996.
forward
global type w_bajas_totales from window
end type
type st_estatus_motor_transferencia from u_st within w_bajas_totales
end type
type cb_consultar_motor from u_cb within w_bajas_totales
end type
type p_estatus_motor_transferencia from u_p within w_bajas_totales
end type
type dw_imprime_bajas_totales from datawindow within w_bajas_totales
end type
type uo_nombre from uo_nombre_alu_foto within w_bajas_totales
end type
type dw_materias_inscritas from datawindow within w_bajas_totales
end type
type gb_estatus_motor_transferencia from u_gb within w_bajas_totales
end type
end forward

global type w_bajas_totales from window
integer x = 5
integer y = 4
integer width = 4247
integer height = 2104
boolean titlebar = true
string title = "BAJAS TOTALES"
string menuname = "m_bajas_totales"
boolean controlmenu = true
long backcolor = 27291696
st_estatus_motor_transferencia st_estatus_motor_transferencia
cb_consultar_motor cb_consultar_motor
p_estatus_motor_transferencia p_estatus_motor_transferencia
dw_imprime_bajas_totales dw_imprime_bajas_totales
uo_nombre uo_nombre
dw_materias_inscritas dw_materias_inscritas
gb_estatus_motor_transferencia gb_estatus_motor_transferencia
end type
global w_bajas_totales w_bajas_totales

type variables
Transaction itr_parametros_iniciales
n_tr itr_seguridad, itr_original, itr_mssqlserver
n_tr itr_web


//nombre de la conexion en parametros_conexion
CONSTANT	string	is_controlescolar_cnx	=	"controlescolar_baja_total"
CONSTANT	string	is_tesoreria_cnx			=	"controlescolar_inscripcion_tesoreria"
CONSTANT	string	is_becas_cnx				=	"controlescolar_inscripcion_becas"


uo_periodo_servicios iuo_periodo_servicios
end variables

forward prototypes
public function integer wf_renglon_cursor ()
public function integer of_obten_estatus_transferencia (boolean ab_envia_mensaje)
public function integer wf_revisa_adeudo ()
end prototypes

public function integer wf_renglon_cursor ();Long NumRen
NumRen = dw_materias_inscritas.getRow()

if NumRen > 0 then
	dw_materias_inscritas.SetRow(NumRen)
	dw_materias_inscritas.ScrollToRow(NumRen)
	dw_materias_inscritas.SetRowFocusIndicator(Hand!)
	Return NumRen
else
   Return 0
end if

	
end function

public function integer of_obten_estatus_transferencia (boolean ab_envia_mensaje);//of_obten_estatus_transferencia
//Devuelve int  si está detenida
//			  0, Si el proceso no esta detenido.
//			  1, Si el proceso si esta detenido.
//        -1, Si hay un error
//Actualiza textos e imágenes en la pantalla

int li_detenido
string ls_error, ls_estatus_motor_transferencia, ls_archivo_semaforo
string ls_usuario, ls_nomb_usu_detiene, ls_proceso_detiene
integer  li_estatus
//
ls_usuario = gs_usuario

//Modificado el 2012-09-11
//li_detenido = f_trans_sql_syb_detenido(ls_error)
li_detenido = f_trans_sql_syb_detenido(ls_error,ls_usuario,ls_nomb_usu_detiene, ls_proceso_detiene)
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
			Messagebox("Aviso","El proceso de tranferencia de movimientos de estacionamiento esta detenido actualmente por ["+ ls_nomb_usu_detiene+"] Proceso: ["+ ls_proceso_detiene+"]")
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

on w_bajas_totales.create
if this.MenuName = "m_bajas_totales" then this.MenuID = create m_bajas_totales
this.st_estatus_motor_transferencia=create st_estatus_motor_transferencia
this.cb_consultar_motor=create cb_consultar_motor
this.p_estatus_motor_transferencia=create p_estatus_motor_transferencia
this.dw_imprime_bajas_totales=create dw_imprime_bajas_totales
this.uo_nombre=create uo_nombre
this.dw_materias_inscritas=create dw_materias_inscritas
this.gb_estatus_motor_transferencia=create gb_estatus_motor_transferencia
this.Control[]={this.st_estatus_motor_transferencia,&
this.cb_consultar_motor,&
this.p_estatus_motor_transferencia,&
this.dw_imprime_bajas_totales,&
this.uo_nombre,&
this.dw_materias_inscritas,&
this.gb_estatus_motor_transferencia}
end on

on w_bajas_totales.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_estatus_motor_transferencia)
destroy(this.cb_consultar_motor)
destroy(this.p_estatus_motor_transferencia)
destroy(this.dw_imprime_bajas_totales)
destroy(this.uo_nombre)
destroy(this.dw_materias_inscritas)
destroy(this.gb_estatus_motor_transferencia)
end on

event open;// Juan Campos Sánchez		Nov-1996.
transaction ltr_sit
integer li_detenido

this.x = 1
this.y = 1
dw_materias_inscritas.SetTransObject(gtr_sce)
dw_materias_inscritas.enabled = False


int li_chk

//1)->

itr_parametros_iniciales = gtr_sce

li_chk	=	f_conecta_pas_parametros_act_bd(itr_parametros_iniciales,itr_mssqlserver,is_controlescolar_cnx,gs_usuario,gs_password,1)
if li_chk <> 1 then return

//1)<-

if f_conecta_pas_parametros_bd(gtr_sce, ltr_sit, 2, gs_usuario, gs_password )=0 then
	messagebox("Atención...", "Problemas al conectarse a la bd de tesoreria")
	close( this)
	return 
else
	gtr_sit = ltr_sit
end if 

li_detenido =of_obten_estatus_transferencia(false)

iuo_periodo_servicios = CREATE uo_periodo_servicios 
iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, 'L', gtr_sce) 
iuo_periodo_servicios.f_modifica_lista_columna( dw_materias_inscritas, 'mat_inscritas_periodo', 'C') 

end event

event doubleclicked;// Juan Campos. Nov-1996
integer li_detenido,li_tiene_adeudos
long ll_cuenta

m_bajas_totales.m_reactivabaja.enabled = true
m_bajas_totales.m_baja.enabled = true

ll_cuenta = long(w_bajas_totales.uo_nombre.em_cuenta.text)

if wf_revisa_adeudo() = 1 then

	li_tiene_adeudos = tiene_adeudos(ll_cuenta, gtr_sit)
		 
	IF li_tiene_adeudos = -1 THEN
		MessageBox("Aviso","Error en la revisión de  tiene_adeudos~n Por favor reporte el error mostrado", StopSign!)
		m_bajas_totales.m_reactivabaja.enabled = false
		m_bajas_totales.m_baja.enabled = false
		dw_materias_inscritas.Reset()
		RETURN
	ELSEIF li_tiene_adeudos = 1 THEN 
		MessageBox("Alumno con Adeudos","Se han encontrado adeudos.~n No procede la baja total.", StopSign!)
		m_bajas_totales.m_reactivabaja.enabled = false
		m_bajas_totales.m_baja.enabled = false
		dw_materias_inscritas.Reset()
		RETURN
	END IF
end if

dw_materias_inscritas.SetSort("mat_inscritas_cve_mat")	 

li_detenido =of_obten_estatus_transferencia(false)

if w_bajas_totales.dw_materias_inscritas. &
   Retrieve(long(w_bajas_totales.uo_nombre.em_cuenta.text)) = 0 then
  MessageBox("Aviso","No tiene materias inscritas este semestre")
Else
  dw_materias_inscritas.setfocus()
end if  

 
end event

type st_estatus_motor_transferencia from u_st within w_bajas_totales
integer x = 3607
integer y = 512
integer width = 590
integer weight = 700
fontcharset fontcharset = ansi!
long backcolor = 67108864
string text = "estatus"
alignment alignment = center!
end type

type cb_consultar_motor from u_cb within w_bajas_totales
integer x = 3657
integer y = 616
integer width = 494
integer height = 88
integer taborder = 30
string text = "Consultar Motor"
end type

event clicked;call super::clicked;integer li_detenido
	
li_detenido =of_obten_estatus_transferencia(false)
end event

type p_estatus_motor_transferencia from u_p within w_bajas_totales
integer x = 3776
integer y = 76
integer width = 256
integer height = 400
string picturename = "semaforo_manual.bmp"
end type

type dw_imprime_bajas_totales from datawindow within w_bajas_totales
event constructor pbm_constructor
boolean visible = false
integer x = 2286
integer y = 912
integer width = 923
integer height = 624
integer taborder = 21
string dataobject = "dw_imprime_bajas_totales"
boolean livescroll = true
end type

event constructor;dw_imprime_bajas_totales.object.fecha.text = Mid(fecha_espaniol_servidor(gtr_sce),1,11)
setTransobject(gtr_sce)
end event

type uo_nombre from uo_nombre_alu_foto within w_bajas_totales
integer taborder = 10
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alu_foto::destroy
end on

type dw_materias_inscritas from datawindow within w_bajas_totales
integer x = 27
integer y = 468
integer width = 3351
integer height = 1224
integer taborder = 20
string dataobject = "dw_materias_inscritas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;// quitar comentarios Si en un futuro se utilaza este codigo
// Juan Campos Feb-1997.
//
//if wf_renglon_cursor() > 0 then
//  m_bajas_totales.m_baja.enabled = true
//  m_bajas_totales.m_reactivabaja.enabled = true
//else
//  MessageBox("Aviso","El renglon no fue seleccionado correctamente")	
//end if
end event

event clicked;// quitar comentarios Si en un futuro se utilaza este codigo
// Juan campos Nov-1996.

//if wf_renglon_cursor() > 0 then
//  m_bajas_totales.m_baja.enabled = true
//  m_bajas_totales.m_reactivabaja.enabled = true
//else
//  MessageBox("Aviso","El renglon no fue seleccionado correctamente")	
//end if
end event

type gb_estatus_motor_transferencia from u_gb within w_bajas_totales
integer x = 3607
integer y = 4
integer width = 590
integer height = 748
integer taborder = 20
string text = "Motor de Transferencia"
end type

