$PBExportHeader$estadisticas.sra
forward
global type estadisticas from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
//transaction gtr_sce
long ok
int gi_periodo,gi_anio
string gs_usuario,gs_password,gs_startupfile, gs_bd_finanzas
//nv_security g_nv_security
//nv_components g_nv_components

// Variable manejador de aplicaciones
n_cst_appmanager_est gnv_app
n_tr gtr_sce, gtr_sit
transaction gtr_sadm, gtr_scob

boolean gb_liberacion_vigente 

STRING gs_tipo_periodo, gs_plantel, gs_descripcion_tipo_periodo
STRING gs_multiples_periodos, gs_logo

// ** MALH 27/10/2017 SE AGREGAN VARABLES PARA TOMAR LA CONFIGURACIÓN DE ACUERDO AL SERVIDOR ASIGNADO EN EL ARCHIVO "sparl.ini"
String gs_separador = ""
String gs_servidor = "Mexico"
String gs_sce = "sce"
String gs_datos = "datos"
String gs_scob = "scob"
String gs_servidores = "servidores"
String gs_sadm = "sadm"
String gs_scred = "scred"
String gs_scaj = "scaj"
// **



end variables

global type estadisticas from application
string appname = "estadisticas"
string appruntimeversion = "21.0.0.1311"
end type
global estadisticas estadisticas

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
gs_sadm = "sadm" + ls_complemento
gs_scred = "scred" + ls_complemento
gs_scaj = "scaj" + ls_complemento

RETURN
end subroutine

on estadisticas.create
appname="estadisticas"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on estadisticas.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;/*
DESCRIPCIÓN: Primer evento de la aplicación de Estadísticas
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 25 Agosto 1998
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
	gs_startupfile = "estadisticas.ini"
CASE Sol2!, AIX!, OSF1!, HPUX!
	gs_startupfile = ".estadisticas.ini"
CASE Macintosh!
	gs_startupfile = "Estadisticas Preferences"
CASE ELSE
	MessageBox( "Application: Open", "Unrecognized operating system.~nHalting ..." )
	HALT
END CHOOSE

gs_usuario=ProfileString (gs_startupfile, gs_datos, "USUARIO","")
toolbarframetitle=ProfileString (gs_startupfile, gs_datos, "APLICACION","")

// Se inicializa las variables con el nombre del servidor
gs_servidor = LOWER(TRIM(ProfileString (gs_startupfile, "config", "Servidor","Mexico")))
of_inicializa_variables_config(gs_servidor)

 //Lineas utilizadas en la conversion de la aplicacion a PFC
gnv_app = create n_cst_appmanager_est
gnv_app.event pfc_open (commandline)

//Comentado para migrar sin padlock
//g_nv_components=create nv_components
//g_nv_security=create nv_security

open(w_password)
end event

event close;/*
DESCRIPCIÓN: Último evento de la aplicación de Estadísticas
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 25 Agosto 1998
MODIFICACIÓN:
*/

/*Guarda los cambios hechos al usuario*/
SetProfileString (gs_startupfile, gs_datos, "USUARIO",gs_usuario)

//Comentado para migrar sin padlock
//g_nv_security.fnv_close_security()


//Linea utilizado en la conversion de la aplicacion a PFC
gnv_app.event pfc_close()

/*Destruye los transaction object's y termina la aplicacón*/
destroy gtr_sce
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

event systemerror; //Lineas utilizadas en la conversion de la aplicacion a PFC
gnv_app.event pfc_systemerror()

end event

