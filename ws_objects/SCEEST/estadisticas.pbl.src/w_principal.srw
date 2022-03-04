$PBExportHeader$w_principal.srw
$PBExportComments$Ventana principal de la aplicación
forward
global type w_principal from window
end type
type mdi_1 from mdiclient within w_principal
end type
end forward

global type w_principal from window
integer x = 101
integer y = 364
integer width = 3479
integer height = 1664
boolean titlebar = true
string menuname = "m_principal"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
mdi_1 mdi_1
end type
global w_principal w_principal

on w_principal.create
if this.MenuName = "m_principal" then this.MenuID = create m_principal
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_principal.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

event open;/*
DESCRIPCIÓN: Si el password es el correcto, habilita la seguridad en la aplicación y
				pon el nombre del usuario en la ventana.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
string ls_nombre
ls_nombre=gs_usuario

//Comentado para migrar sin padlock
//SELECT first_name+' '+last_name
//INTO :ls_nombre
//FROM pc_user_def
//WHERE pc_user_def.user_id = :ls_nombre
//USING gtr_sce;

SELECT description
INTO :ls_nombre
FROM security_users
WHERE security_users.name = :ls_nombre
USING gtr_sce;


title=ProfileString (gs_startupfile, gs_datos, "APLICACION","")+' '+gs_usuario+' '+ls_nombre

//Comentado para migrar sin padlock
//g_nv_security.fnv_secure_window(this)

//Seguridad via PFC
gnv_app.of_SetSecurity(TRUE)
//Comentado para aprovechar el uso de una transaccion
//gnv_app.itr_security = CREATE n_tr
gnv_app.itr_security = gtr_sce
gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), "SCE")
//gnv_app.itr_security.of_Connect()

Integer li_return

li_return = gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, &
gs_usuario, "Default")

gnv_app.inv_security.of_SetSecurity(this)



end event

event close;/*
DESCRIPCIÓN: Al salir de la aplicación, cierra la seguridad.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/

//Comentado para migrar sin padlock
//g_nv_security.fnv_close_security()
end event

type mdi_1 from mdiclient within w_principal
long BackColor=276856960
end type

