$PBExportHeader$sparl.sra
forward
global type sparl from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
boolean gb_liberacion_vigente
string gs_bd_finanzas
window g_w_frame
string usuario
transaction gtr_scob, gtr_sadm, gtr_sit,  gtr_sfeb, gtr_scred
int G_per, ok
long G_anio

int ge_plantel


int gi_nivel_usuario
int gi_periodo, gi_anio

n_cst_appmanager_sparl gnv_app
n_tr  gtr_sce

/**/
string gs_usuario, gs_password,gs_startupfile, gs_path_ini 

STRING gs_tipo_periodo
STRING gs_descripcion_tipo_periodo
STRING gs_plantel
STRING gs_multiples_periodos 
STRING gs_periodo_default 

// ** MALH 27/10/2017 SE AGREGAN VARABLES PARA TOMAR LA CONFIGURACIÓN DE ACUERDO AL SERVIDOR ASIGNADO EN EL ARCHIVO "sparl.ini"
String gs_separador = ""

String gs_servidor = "Mexico"
String gs_sfeb = "sfeb"
String gs_scob = "scob"
String gs_sce = "sce"
String gs_datos = "datos"
String gs_web_param = "WEB_PARAM"
String gs_servidores = "servidores"
String gs_sweb = "sweb"
String gs_sadm = "sadm"
String gs_scred = "scred"
String gs_scaj = "scaj"
// **

STRING gs_logo

end variables

global type sparl from application
string appname = "sparl"
string appruntimeversion = "21.0.0.1311"
end type
global sparl sparl

type variables

end variables

forward prototypes
public subroutine of_inicializa_variables_config (string as_servidor)
end prototypes

public subroutine of_inicializa_variables_config (string as_servidor);String ls_complemento

IF as_servidor = "" THEN as_servidor = "Mexico"
IF gs_separador = "" THEN gs_separador = "."

ls_complemento = gs_separador + as_servidor

gs_sfeb = "sfeb" + ls_complemento
gs_scob = "scob" + ls_complemento
gs_sce = "sce" + ls_complemento
gs_datos = "datos" + ls_complemento
gs_web_param = "WEB_PARAM" + ls_complemento
gs_servidores = "servidores" + ls_complemento
gs_sweb = "sweb" + ls_complemento
gs_sweb = "sadm" + ls_complemento
gs_scred = "scred" + ls_complemento
gs_scaj = "scaj" + ls_complemento

RETURN
end subroutine

on sparl.create
appname="sparl"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on sparl.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;string s_userid,file
environment	env				// holds environment information
string		startupfile		// holds name of start-up file
int	li_ret

//Comentada para aprovechar la misma de la seguridad
//gtr_sce = Create Transaction

/* Get the environment information */
IF ( GetEnvironment(env) <> 1 ) THEN
	MessageBox( "Application: Open", "Unable to get environment information.~nHalting ..." )
	HALT
END IF

/* Select start-up file by operating system */
CHOOSE CASE env.OSType
CASE Windows!, WindowsNT!
	gs_startupfile = "sparl.ini"
CASE Sol2!, AIX!, OSF1!, HPUX!
	gs_startupfile = ".sparl.ini"
CASE Macintosh!
	gs_startupfile = "Sparl Preferences"
CASE ELSE
	MessageBox( "Application: Open", "Unrecognized operating system.~nHalting ..." )
	HALT
END CHOOSE

toolbarframetitle="Sistema de Control Escolar"

// Se inicializa las variables con el nombre del servidor
gs_servidor = LOWER(TRIM(ProfileString (gs_startupfile, "config", "Servidor","Mexico")))
of_inicializa_variables_config(gs_servidor)

/* Open MDI frame window */
	
//	open(w_portada)
	
 //Lineas utilizadas en la conversion de la aplicacion a PFC
/**/gnv_app = create n_cst_appmanager_sparl
/**/gnv_app.event pfc_open (commandline)

open(w_login_srl)
	

end event

event close;//Linea utilizado en la conversion de la aplicacion a PFC
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

