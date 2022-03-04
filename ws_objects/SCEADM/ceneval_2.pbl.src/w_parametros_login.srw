$PBExportHeader$w_parametros_login.srw
forward
global type w_parametros_login from w_master_main
end type
type dw_parametros_login from uo_master_dw within w_parametros_login
end type
end forward

global type w_parametros_login from w_master_main
integer width = 3369
integer height = 2716
string title = "Parámetros de Login del Registro de Admisión por Internet"
string menuname = "m_menu_general_2013"
dw_parametros_login dw_parametros_login
end type
global w_parametros_login w_parametros_login

type variables
int ord
uo_administrador_liberacion iuo_administrador_liberacion

transaction itr_admision_web

n_transfiere_sybase_sql in_transfiere_sybase_sql

end variables

on w_parametros_login.create
int iCurrent
call super::create
if this.MenuName = "m_menu_general_2013" then this.MenuID = create m_menu_general_2013
this.dw_parametros_login=create dw_parametros_login
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_parametros_login
end on

on w_parametros_login.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_parametros_login)
end on

event open;call super::open;//Se conecta a la base de datos SQLWEBPRO.admision_bd
integer li_conexion, li_retrieve

x=1
y=1

li_conexion = f_conecta_pas_parametros_bd(gtr_sce, itr_admision_web, 24, gs_usuario, gs_password)
//transaction		atr_transaccion_parametros
//transaction		atr_transaccion_nueva_bd
//integer 			ai_cve_conexion
//string				as_usuario
//string				as_password

if li_conexion <>1 then
	MessageBox("Error de conexion a la base del web","Favor de reintentar con un usuario que tenga permisos", StopSign!)
	close(this)
	return
end if


//Inicializa el transaction object
dw_parametros_login.settransobject(itr_admision_web)

idw_trabajo = dw_parametros_login

m_menu_general_2013.dw = idw_trabajo

f_obten_titulo(w_principal)


li_retrieve = dw_parametros_login.Retrieve()
if li_retrieve <= 0 then
	MessageBox("Parámetros Inexistentes","No ha sido posible encontrar parámetros del Registro de Admisión por Internet", StopSign!)
	return	
end if

if not isvalid(iuo_administrador_liberacion) then
	iuo_administrador_liberacion = CREATE uo_administrador_liberacion	
end if

end event

event close;call super::close;
if isvalid(itr_admision_web) then
	DISCONNECT USING itr_admision_web;
end if

if isvalid(iuo_administrador_liberacion) then
	DESTROY iuo_administrador_liberacion 
end if

f_obten_titulo(w_principal)

end event

event ue_actualiza;call super::ue_actualiza;dw_parametros_login.event ue_actualiza()

//parentwindow.triggerevent("ue_actualiza")
end event

type st_sistema from w_master_main`st_sistema within w_parametros_login
end type

type p_ibero from w_master_main`p_ibero within w_parametros_login
end type

type dw_parametros_login from uo_master_dw within w_parametros_login
integer x = 37
integer y = 308
integer width = 2953
integer height = 2128
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_parametros_login"
end type

event constructor;call super::constructor;m_menu.dw = idw_trabajo
end event

event ue_actualiza;//ue_actualiza
//Autor: Antonio Pica Ruiz
// Personalizado para los catálogos 
// Regresa: 1 si hace los cambios en la base de datos
// Cambios al objeto de transaccion para que permita modificar en
//	Control Escolar
// Febrero 2014
 
if this.ModifiedCount() + this.DeletedCount() > 0 then 
	if this.Event pfc_Update(true,true) >= 1 then 
		commit using itr_admision_web;
		Messagebox("Aviso","Los cambios fueron guardados")
		return 1
	else
		rollback using itr_admision_web;
		Messagebox("Antención","~nAlgunos datos no son validos~n~nLos cambios NO se guardaron")	
		return 0
	end if
else
	return FAILURE 
end if

end event

event ue_borrarenglon;//ue_borrarenglon
//Autor: Antonio Pica Ruiz
// Borra el renglon selecionado y guarda los cambios en la base de datos 
// Se personalizo para uso de los Catálogos
// Febrero 2014

if messagebox("Atención","Esta seguro que desea borrar el renglon actual",Question!,YesNo!,1) = 1 then

	if this. event pfc_deleterow() = 1 then
	
		if this.DeletedCount() > 0 then 		
			
			if this. event ue_actualiza() = 0 then this. event pfc_retrieve()
			
		end if
		
	end if
	
end if

end event

