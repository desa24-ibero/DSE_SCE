$PBExportHeader$admision.sra
$PBExportComments$Aplicación del Proceso de Admision
forward
global type admision from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
long ok
string tit1
transaction gtr_scaj, gtr_sadm, gtr_admision
int gi_version,gi_periodo,gi_anio, gi_sol_version
string gs_usuario,gs_password,gs_startupfile, gs_bd_finanzas
INTEGER le_periodo, le_anio 
n_ds                     gds_datos

//Comentado para migrar sin padlock
//nv_security g_nv_security
//nv_components g_nv_components

// Variable manejador de aplicaciones
n_cst_appmanager_adm gnv_app
n_tr gtr_sce, gtr_sit, gtr_ceneval, gtr_sfeb, gtr_scob
//n_tr gtr_scob, gtr_scaj, gtr_sadm, gtr_admision

boolean gb_liberacion_vigente= false

int gi_clv_per_ceneval_2014 = -1
int gi_anio_ceneval_2014 = -1


STRING gs_plantel, gs_logo 
STRING gs_descripcion_tipo_periodo = 'Semestral', gs_tipo_periodo = 'S', gs_multiples_periodos = 'N'

// ** MALH 03/11/2017 SE AGREGAN VARABLES PARA TOMAR LA CONFIGURACIÓN DE ACUERDO AL SERVIDOR ASIGNADO EN EL ARCHIVO "sparl.ini"
String gs_separador = ""
String gs_servidor = "Mexico"
String gs_sce = "sce"
String gs_datos = "datos"
String gs_scob = "scob"
String gs_servidores = "servidores"
String gs_sadm = "sadm"
String gs_scred = "scred"
String gs_scaj = "scaj"
String gs_tes = "tes"
String gs_sumuia = "sumuia"
String gs_sinf = "sinf"
String gs_sfeb = "sfeb"

// **



end variables

global type admision from application
string appname = "admision"
string appruntimeversion = "21.0.0.1311"
end type
global admision admision

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
gs_tes = "tes" + ls_complemento
gs_sumuia = "sumuia" + ls_complemento
gs_sinf = "sinf" + ls_complemento
gs_sfeb = "sfeb" + ls_complemento

RETURN

end subroutine

on admision.create
appname="admision"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on admision.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;/*
DESCRIPCIÓN: Primer evento de la aplicación de Admisión
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 16 Junio 1998
MODIFICACIÓN:
*/

/*******************************************************
 *	Application Open Script
 *		Selects start-up file according to Operating System
 *		Opens Password
 */
environment lenv_env		// holds environment information

/* Get the environment information */
IF ( GetEnvironment(lenv_env) <> 1 ) THEN
	MessageBox( "Application: Open", "Unable to get environment information.~nHalting ..." )
	HALT
END IF

/* Select start-up file by operating system */
CHOOSE CASE lenv_env.OSType
CASE Windows!, WindowsNT!
	gs_startupfile = "admision.ini"
CASE Sol2!, AIX!, OSF1!, HPUX!
	gs_startupfile = ".admision.ini"
CASE Macintosh!
	gs_startupfile = "Admision Preferences"
CASE ELSE
	MessageBox( "Application: Open", "Unrecognized operating system.~nHalting ..." )
	HALT
END CHOOSE

// Se inicializa las variables con el nombre del servidor
gs_servidor = LOWER(TRIM(ProfileString (gs_startupfile, "config", "Servidor","Mexico")))
of_inicializa_variables_config(gs_servidor)

gi_anio=ProfileInt (gs_startupfile,gs_datos, "ANIO",year(today()))
gi_periodo=ProfileInt (gs_startupfile,gs_datos, "PERIODO",0)
gi_version=ProfileInt (gs_startupfile,gs_datos, "VERSION",0)
gs_usuario=ProfileString (gs_startupfile,gs_datos, "USUARIO","")
toolbarframetitle=ProfileString (gs_startupfile,gs_datos, "APLICACION","")

 //Lineas utilizadas en la conversion de la aplicacion a PFC
gnv_app = create n_cst_appmanager_adm
gnv_app.event pfc_open (commandline)


////Seguridad via PFC
//gnv_app.of_SetSecurity(TRUE)
//
//gnv_app.itr_security = CREATE n_tr
//gnv_app.itr_security.of_Init(gnv_app.of_GetAppINIFile(), "SCE")
//gnv_app.itr_security.of_Connect()


//Comentado para migrar sin padlock
//g_nv_components=create nv_components
//g_nv_security=create nv_security

open(w_password_rest)
end event

event close;/*
DESCRIPCIÓN: Último evento de la aplicación de Admisión
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
/*Guarda los cambios hechos a la fecha y al usuario*/
SetProfileString (gs_startupfile, gs_datos, "ANIO",string(gi_anio))
SetProfileString (gs_startupfile, gs_datos, "PERIODO",string(gi_periodo))
SetProfileString (gs_startupfile, gs_datos, "VERSION",string(gi_version))
SetProfileString (gs_startupfile, gs_datos, "USUARIO",gs_usuario)

//Comentado para migrar sin padlock
//g_nv_security.fnv_close_security()

//Linea utilizado en la conversion de la aplicacion a PFC
gnv_app.event pfc_close()


/*Destruye los transaction object's y termina la aplicacón*/
destroy gtr_sce
destroy gtr_scaj
destroy gtr_scob
destroy gtr_sadm
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

