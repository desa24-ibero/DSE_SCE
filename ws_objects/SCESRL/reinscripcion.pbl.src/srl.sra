$PBExportHeader$srl.sra
$PBExportComments$Sistema de Reinscripción en Línea
forward
global type srl from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
//nv_security g_nv_security
//nv_components g_nv_components
//boolean g_show_security = False
//boolean g_load_security = True
window g_w_frame
string usuario
Transaction cobra
Transaction gtr_parametros_iniciales
STRING gs_logo

int G_per
long G_anio

int gi_nivel_usuario

boolean gb_liberacion_vigente = false

//nombre del archivo de configuracion de la aplicacion
string	gs_inifile
//nombre de la conexion en parametros_conexion
CONSTANT	string	gs_controlescolar_cnx	=	"controlescolar_inscripcion"
CONSTANT	string	gs_tesoreria_cnx			=	"controlescolar_inscripcion_tesoreria"
CONSTANT	string	gs_becas_cnx				=	"controlescolar_inscripcion_becas"

// Tipo de Periodo default que tiene asignado el usuario que se firma
STRING gs_periodo_default  
// Tipo de periodo seleccionado para trabajar
STRING gs_tipo_periodo
STRING gs_descripcion_periodo
// Bandera indicadora de múltiples periodos
STRING gs_multiples_periodos

// ** MALH 13/09/2017 SE AGREGAN VARABLES PARA TOMAR LA CONFIGURACIÓN DE ACUERDO AL SERVIDOR ASIGNADO EN EL ARCHIVO "SRLv6.ini"
String gs_separador = ""

String gs_startupfile = "SRLv6.ini"
String gs_servidor = "Mexico"
String gs_sfeb = "sfeb"
String gs_cobranzas = "cobranzas" 
String gs_sce = "sce"
String gs_datos = "datos"
// **


end variables

global type srl from application
string appname = "srl"
string appruntimeversion = "21.0.0.1311"
end type
global srl srl

on srl.create
appname="srl"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on srl.destroy
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

/* Get the environment information */
IF ( GetEnvironment(env) <> 1 ) THEN
	MessageBox( "Application: Open", "Unable to get environment information.~nHalting ..." )
	HALT
END IF


toolbarframetitle="Sistema de Control Escolar"

/*Inicializar variable globales*/
gtr_parametros_iniciales = create transaction


	open(w_login_srl)

	s_userid = message.stringParm
	usuario	=	s_userid


	IF s_userid <> "" THEN
		li_ret = f_usuario_valido_aplicacion(GetApplication().appname,s_userid,SQLCA)
		if (li_ret = 1) then //usuario_valido
//			// Se verifica si el plantel soporta múltiples periodos.
//			IF gs_multiples_periodos ="S" THEN 
//				// Se carga el usuario 
//				// Se verifica si el usuario tiene seleccionado un periodo default.
//				IF TRIM(gs_periodo_default) = "" THEN 
//					MessageBox("Usuario sin periodo definido", "El usuario no tiene asignado un tipo de periodo por omisión",Exclamation!)
//					HALT CLOSE				
//				END IF
//			ELSE
//				// Se asigna por omisión Semestral
//				gs_periodo_default = "S"				
//			END IF
			open(w_srl)
		elseif li_ret = 0	then// usuario invalido
			MessageBox("Usuario desconocido", "El usuario no tiene permisos para entrar a esta aplicación",Exclamation!)
			HALT CLOSE
		else	//Error BD
			MessageBox("Error de Comunicación","Error con la consulta de seguridad BD. Favor de intentar nuevamente", None!)
			HALT CLOSE
		end if
	end if



end event

