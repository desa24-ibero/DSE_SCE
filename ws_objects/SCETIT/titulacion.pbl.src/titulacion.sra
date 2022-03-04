$PBExportHeader$titulacion.sra
$PBExportComments$Aplicación de Titulación
forward
global type titulacion from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
// Variable manejador de aplicaciones
n_cst_appmanager_tit gnv_app
n_tr gtr_sce, gtr_sit
transaction gtr_sadm, gtr_scob
int gi_periodo,gi_anio,ok
string gs_usuario,gs_password,gs_startupfile, gs_bd_finanzas, gtr_scred
STRING gs_scaj

STRING gs_logo

window                    g_w_frame
//Comentado para migrar sin padlock
//nv_security g_nv_security
//nv_components g_nv_components

boolean gb_liberacion_vigente

//cross platform information
//ge_environment maintains the operating environment
environment ge_environment

//gu_ext_func is a user object capable of handling
//generic operating system level calls and mapping
//them to the appropriate external functions.
u_external_function gu_ext_func

//The base registry entry key used
string sREGKEY
string sPBKEY

// the Major Version 
string sVERSION, sVersionSimple

// the Examples Version 
string sVERSIONEX

// the Fix Version
string sVERSIONNAME

// the name of the PB Executable
string sPBEXE

// the directory the Code Examples are installed in
string gs_ExampleDir

string gs_tipo_periodo = "S"
string gs_multiples_periodos = "S"
string gs_plantel = ""
string gs_descripcion_tipo_periodo = ""

// ** MALH 03/11/2017 SE AGREGAN VARABLES PARA TOMAR LA CONFIGURACIÓN DE ACUERDO AL SERVIDOR ASIGNADO EN EL ARCHIVO "titulacion.ini"
String gs_separador = ""
String gs_servidor = "Mexico"
String gs_sce = "sce"
String gs_datos = "datos"
String gs_scob = "scob"
String gs_servidores = "servidores"
String gs_sqlca = "sqlca"
String gs_sadm = "sadm"
String gs_scred = "scred"
String gs_sweb = "sweb"
// **




uo_conexion guo_conexion 
STRING gs_plantel2
INTEGER ge_periodo 
DATE gf_fecha_ejecucion 
STRING multiples_periodos
STRING gs_periodo_default  
INTEGER ge_anio

end variables

global type titulacion from application
string appname = "titulacion"
string appruntimeversion = "21.0.0.1311"
end type
global titulacion titulacion

forward prototypes
public subroutine of_inicializa_variables_config (string as_servidor)
end prototypes

public subroutine of_inicializa_variables_config (string as_servidor);String ls_complemento

IF as_servidor = "" THEN as_servidor = "Mexico"
IF gs_separador = "" THEN gs_separador = "."

ls_complemento = gs_separador + as_servidor

gs_sce = "sce" + ls_complemento
gs_datos = "datos" + ls_complemento
gs_scob = "scob" + ls_complemento
gs_servidores = "servidores" + ls_complemento
gs_sqlca = "sqlca" + ls_complemento
gs_sadm = "sadm" + ls_complemento
gs_scred = "scred" + ls_complemento
gs_sweb = "sweb" + ls_complemento

RETURN
end subroutine

on titulacion.create
appname="titulacion"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on titulacion.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event close;/*
DESCRIPCIÓN: Último evento de la aplicación de Preinscripción
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/

/*Guarda los cambios hechos al usuario*/
SetProfileString (gs_startupfile, gs_datos, "USUARIO",gs_usuario)

//Comentado para migrar sin padlock
//g_nv_security.fnv_close_security()


//Destroy the Cross Platform NVO if exists.
if not IsNull(gu_ext_func) then destroy(gu_ext_func)

//Linea utilizado en la conversion de la aplicacion a PFC
gnv_app.event pfc_close()

/*Destruye los transaction object's y termina la aplicacón*/
destroy gtr_sce
end event

event open;/*
DESCRIPCIÓN: Primer evento de la aplicación de Titulación
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 25 Junio 1998
MODIFICACIÓN:
*/

/*******************************************************
 *	Application Open Script
 *		Selects start-up file according to Operating System
 *		Opens Password
 */
 
 
environment	lenv_env		// holds environment information

/* Get the environment information */
IF ( GetEnvironment(lenv_env) <> 1 ) THEN
	MessageBox( "Application: Open", "Unable to get environment information.~nHalting ..." )
	HALT
END IF

/* Select start-up file by operating system */
CHOOSE CASE lenv_env.OSType
CASE Windows!, WindowsNT!
	gs_startupfile = "titulacion.ini"
CASE Sol2!, AIX!, OSF1!, HPUX!
	gs_startupfile = ".titulacion.ini"
CASE Macintosh!
	gs_startupfile = "Titulacion Preferences"
CASE ELSE
	MessageBox( "Application: Open", "Unrecognized operating system.~nHalting ..." )
	HALT
END CHOOSE

// Se inicializa las variables con el nombre del servidor
gs_servidor = LOWER(TRIM(ProfileString (gs_startupfile, "config", "Servidor","Mexico")))
of_inicializa_variables_config(gs_servidor)

gs_usuario=ProfileString (gs_startupfile, gs_datos, "USUARIO","")
toolbarframetitle=ProfileString (gs_startupfile, gs_datos, "APLICACION","")

 //Lineas utilizadas en la conversion de la aplicacion a PFC
gnv_app = create n_cst_appmanager_tit
gnv_app.event pfc_open (commandline)

// Create the global user object gu_ext_func. 
// The user object will handle cross platform operating system external calls
if not f_create_external_func_uo(gu_ext_func) then
	Messagebox ("External Functions User Object","An error occurred while initializing the "+&
					"external function user object.  External calls will not be available "+&
					"for this session.")
end if

// Get the directory for the examples
//gu_ext_func.uf_set_directories()
//gu_ext_func.uf_get_pb_ini ( ) 

////Seguridad via PFC
//gnv_app.of_SetSecurity(TRUE)
//
//gnv_app.itr_security = CREATE n_tr
//gnv_app.itr_security.of_Init(gnv_app.of_GetAppINIFile(), "SCE")
//gnv_app.itr_security.of_Connect()


//
//Comentado para migrar sin padlock
//g_nv_components=create nv_components
//g_nv_security=create nv_security

open(w_password_rest)
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

event systemerror;gnv_app.event pfc_systemerror()

end event

