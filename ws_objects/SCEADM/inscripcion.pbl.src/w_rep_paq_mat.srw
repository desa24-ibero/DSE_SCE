$PBExportHeader$w_rep_paq_mat.srw
forward
global type w_rep_paq_mat from window
end type
type uo_1 from uo_ver_per_ani within w_rep_paq_mat
end type
type dw_1 from uo_dw_reporte within w_rep_paq_mat
end type
end forward

global type w_rep_paq_mat from window
integer x = 832
integer y = 360
integer width = 3694
integer height = 1972
boolean titlebar = true
string title = "Reporte de Paquetes con Materias"
string menuname = "m_menu"
long backcolor = 30976088
uo_1 uo_1
dw_1 dw_1
end type
global w_rep_paq_mat w_rep_paq_mat

type variables
Transaction itr_parametros_iniciales
n_tr itr_seguridad, itr_original

//nombre de la conexion en parametros_conexion
CONSTANT	string	is_controlescolar_cnx	=	"controlescolar_inscripcion"
CONSTANT	string	is_tesoreria_cnx			=	"controlescolar_inscripcion_tesoreria"
CONSTANT	string	is_becas_cnx				=	"controlescolar_inscripcion_becas"

end variables

on w_rep_paq_mat.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.uo_1,&
this.dw_1}
end on

on w_rep_paq_mat.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;int li_chk

x=1
y=1

//Cambio por Ajustes en Línea
//1)->
//Se conecta a la seguridad para mantener separada una transacción para la seguridad
if not (conecta_bd_n_tr(itr_seguridad,gs_sce,gs_usuario,gs_password) = 1) then
	messageBox('Error en seguridad', 'No es posible validar la seguridad del usuario',Stopsign!)
end if

itr_parametros_iniciales = gtr_sce

li_chk	=	f_conecta_pas_parametros_act_bd(itr_parametros_iniciales,gtr_sce,is_controlescolar_cnx,gs_usuario,gs_password,1)
if li_chk <> 1 then return



//Es necesario reasignar el transaction object para la seguridad
gnv_app.of_SetSecurity(TRUE)
gnv_app.itr_security = itr_seguridad
gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), gs_sce)
gnv_app.itr_security.of_Connect()
if (gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, gs_usuario,"Default") <> 1) then
		MessageBox("Atención","No se pudo inicializar correctamente la seguridad")
		Close(this)
end if

//Cambio por Ajustes en Línea
//1)<-


//Cambio por Ajustes en Línea
//2)->
//Se vuelve a poner porque en el constructor de los datawindows ya previamente se había ejecutado apuntando a sybase
dw_1.triggerevent("asigna_dw_menu")
dw_1.triggerevent("inicia_transaction_object")


f_obten_titulo_ajustes(w_principal)

w_principal.ChangeMenu(m_grupos_impartidos_salir)

//Cambio por Ajustes en Línea
//2)<-


//dw_1.settransobject(gtr_sadm)
dw_1.settransobject(gtr_sce)
end event

event close;//Cambio por Ajustes en Línea
//3)->
//Se conecta a la base de datos original para reasignar a la transacción principal
if not (conecta_bd_n_tr(itr_original,gs_sce,gs_usuario,gs_password) = 1) then
	messageBox('Error en conectividad', 'No es posible reconectarse al origen. Favor de reiniciar la aplicación',Stopsign!)
	HALT CLOSE		
end if

//Se asigna la transacción original
gtr_sce = itr_original 

//Es necesario reasignar el transaction object para la seguridad
gnv_app.of_SetSecurity(TRUE)
gnv_app.itr_security = gtr_sce
gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), gs_sce)
gnv_app.itr_security.of_Connect()
if (gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, gs_usuario,"Default") <> 1) then
		MessageBox("Atención","No se pudo inicializar correctamente la seguridad")
		Close(this)
end if

f_obten_titulo_ajustes(w_principal)
w_principal.ChangeMenu(m_principal)
gnv_app.inv_security.of_SetSecurity(w_principal)
//Cambio por Ajustes en Línea
//3)<-

end event

type uo_1 from uo_ver_per_ani within w_rep_paq_mat
integer x = 5
integer y = 4
integer height = 164
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_rep_paq_mat
integer x = 37
integer y = 200
integer width = 3611
integer height = 1568
integer taborder = 0
string dataobject = "dw_rep_paq_mat"
end type

event carga;event primero()
return retrieve(gi_periodo,gi_anio)
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

