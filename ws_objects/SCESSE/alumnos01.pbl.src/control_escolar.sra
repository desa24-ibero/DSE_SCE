$PBExportHeader$control_escolar.sra
forward
global type control_escolar from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
boolean gb_liberacion_vigente
n_tr gtr_sce, gtr_sfeb
transaction gtr_sit
string gs_bd_finanzas
transaction gtr_scred,gtr_scob, gtr_sadm
int G_Per,G_year,ok, gi_periodo, gi_anio, gi_version
string                       gs_usuario,gs_password,gs_startupfile
//nv_security	g_nv_security	// PADLock Security Object
//nv_components	g_nv_components
//boolean		g_show_security = FALSE
//boolean		g_load_security = TRUE
window                    g_w_frame
n_cst_appmanager_sce gnv_app

// ** MALH 25/08/2017 SE AGREGAN VARABLES PARA TOMAR LA CONFIGURACIÓN DE ACUERDO AL SERVIDOR ASIGNADO EN EL ARCHIVO "controle.ini"
String gs_separador = ""

STRING gs_logo

String gs_servidor = "Mexico"
String gs_datos = "datos"
String gs_servidores = "servidores"
String gs_sce = "sce"
String gs_scob = "scob"
String gs_scred = "scred"
String gs_sadm = "sadm"
String gs_fotos = "fotos"
String gs_sweb = "sweb"
String gs_scaj = "scaj"
// **
STRING gs_tipo_periodo, gs_plantel, gs_descripcion_tipo_periodo 
STRING gs_multiples_periodos 
STRING gs_periodo_default 

integer gi_numscob, gi_numsadm


Constant long VK_NUMLOCK						=  144
Constant long VK_SCROLL							=  145
Constant long VK_CAPITAL						= 20
Constant long KEYEVENTF_EXTENDEDKEY			= 1
Constant long KEYEVENTF_KEYUP					= 2
Constant long VER_PLATFORM_WIN32_NT			= 2
Constant long VER_PLATFORM_WIN32_WINDOWS	= 1



end variables

global type control_escolar from application
string appname = "control_escolar"
string appruntimeversion = "21.0.0.1311"
end type
global control_escolar control_escolar

type prototypes
Function uint GetModuleHandleA(string ModuleName) LIBRARY "KERNEL32.DLL" alias for "GetModuleHandleA;Ansi"
FUNCTION uLong GetVersionExA(Ref str_osversioninfo lpVersionInfo) LIBRARY "KERNEL32.DLL" alias for "GetVersionExA;Ansi"
SUBROUTINE keybd_event(int bVk, int bScan, int dwFlags, int dwExtraInfo) LIBRARY "USER32.DLL" 
FUNCTION boolean GetKeyboardState(ref integer kbarray[256])  LIBRARY "USER32.DLL"
FUNCTION boolean SetKeyboardState(ref integer kbarray[256]) LIBRARY "USER32.DLL"
FUNCTION ulong FindWindowA(ulong Winhandle, string Wintitle) LIBRARY "USER32.DLL" alias for "FindWindowA;Ansi"
FUNCTION ulong FindWindowA(ref string lpClassName, ref string lpWindowName) LIBRARY "USER32.DLL" alias for "FindWindowA;Ansi"
Function long GetClassNameA(ulong hwnd, ref string cname, int buf) LIBRARY "User32.dll" alias for "GetClassNameA;Ansi"




end prototypes

type variables



end variables

forward prototypes
public subroutine of_inicializa_variables_config (string as_servidor)
end prototypes

public subroutine of_inicializa_variables_config (string as_servidor);String ls_complemento

IF as_servidor = "" THEN as_servidor = "Mexico"
IF gs_separador = "" THEN gs_separador = "."

ls_complemento = gs_separador + as_servidor

gs_datos = "datos" + ls_complemento
gs_servidores = "servidores" + ls_complemento
gs_sce = "sce" + ls_complemento
gs_scob = "scob" + ls_complemento
gs_scred = "scred" + ls_complemento
gs_sadm = "sadm" + ls_complemento
gs_fotos = "fotos" + ls_complemento
gs_sweb = "sweb" + ls_complemento
gs_scaj = "scaj" + ls_complemento

RETURN
end subroutine

on control_escolar.create
appname="control_escolar"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on control_escolar.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;/*
DESCRIPCIÓN: Primer evento de la aplicación de Control Escolar
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 24 Junio 1998
MODIFICACIÓN:
*/

/*******************************************************
 *	Application Open Script
 *		Selects start-up file according to Operating System
 *		Opens Password
 */
environment lenv_env		// holds environment information
String ls_servidor

/* Get the environment information */
IF ( GetEnvironment(lenv_env) <> 1 ) THEN
	MessageBox( "Application: Open", "Unable to get environment information.~nHalting ..." )
	HALT
END IF

/* Select start-up file by operating system */
CHOOSE CASE lenv_env.OSType
CASE Windows!, WindowsNT!
	gs_startupfile = "controle.ini"
CASE Sol2!, AIX!, OSF1!, HPUX!
	gs_startupfile = ".controle.ini"
CASE Macintosh!
	gs_startupfile = "Control Escolar Preferences"
CASE ELSE
	MessageBox( "Application: Open", "Unrecognized operating system.~nHalting ..." )
	HALT
END CHOOSE
//Lineas utilizadas en la conversion de la aplicacion a PFC
gnv_app = create n_cst_appmanager_sce
gnv_app.event pfc_open (commandline)
/**/
/**/

// Se inicializa las variables con el nombre del servidor
gs_servidor = LOWER(TRIM(ProfileString (gs_startupfile, "config", "Servidor","Mexico")))
of_inicializa_variables_config(gs_servidor)

gs_usuario=ProfileString (gs_startupfile, gs_datos, "USUARIO","")
toolbarframetitle=ProfileString (gs_startupfile, gs_datos, "APLICACION","")
Open (w_login_sce)
end event

event close;/*Guarda los cambios hechos al gs_usuario*/
SetProfileString (gs_startupfile, gs_datos, "USUARIO",gs_usuario)
//Linea utilizado en la conversion de la aplicacion a PFC
gnv_app.event pfc_close()

Destroy gtr_sce



end event

event connectionbegin;//Linea utilizado en la conversion de la aplicacion a PFC
return gnv_app. event pfc_connectionbegin (userid, password, connectstring)

end event

event connectionend;//Linea utilizado en la conversion de la aplicacion a PFC
gnv_app.event pfc_connectionend()

end event

event idle;//Linea utilizado en la conversion de la aplicacion a PFC
gnv_app.event pfc_idle()

end event

event systemerror;//Linea utilizado en la conversion de la aplicacion a PFC
gnv_app.event pfc_systemerror()
end event

