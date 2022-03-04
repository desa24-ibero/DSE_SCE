$PBExportHeader$w_sit.srw
$PBExportComments$La referencia a esta ventana se debe realizar por medio de w_principal
forward
global type w_sit from w_frame
end type
end forward

global type w_sit from w_frame
string menuname = "m_sit_principal"
windowstate windowstate = maximized!
long backcolor = 33554432
string icon = "uia.ico"
end type
global w_sit w_sit

event open;call super::open;//============================================================================
// Lineas para la seguridad de la Aplicacón.
// Juan M. Campos Sánchez. 25-Junio-2001
//============================================================================

date ldt_fecha_servidor
string ls_nombre
integer li_error,li_return
ls_nombre=gs_usuario

SELECT description
INTO :ls_nombre
FROM security_users
WHERE security_users.name = :ls_nombre
USING gtr_sit;

if gtr_sit.sqlcode = 100 then
	Messagebox("Error de seguridad","El usuario no existe en la base de datos de seguridad")
	close(this) 
elseif gtr_sit.sqlcode = -1 then
	Messagebox("Error de seguridad",gtr_sit.sqlerrtext)
	close(this) 
end if

title=ProfileString (gs_startupfile, "datos", "APLICACION","")+' '+gs_usuario+' '+ls_nombre

//Seguridad via PFC
gnv_app.of_SetSecurity(TRUE)

//Comentado para aprovechar el uso de una transaccion
//gnv_app.itr_security = CREATE n_tr
gnv_app.itr_security = gtr_sit
li_error = gnv_app.itr_security.of_Init_sit("SIT.INI","SIT",gs_usuario,gs_password)

if li_error < 1 then
	Messagebox("Error de seguridad","Consulte al administrador de la aplicación")
	close(this) 
end if

//li_error = gnv_app.itr_security.of_Connect()

li_return = gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, &
gs_usuario, gs_password)

gnv_app.inv_security.of_SetSecurity(this)

// Quitame.
m_sit_principal.m_catalogos.m_costos.visible=true
m_sit_principal.m_catalogos.m_costos.enabled=true
////------------------------------------------------

end event
on w_sit.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_sit_principal" then this.MenuID = create m_sit_principal
end on

on w_sit.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

