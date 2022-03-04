$PBExportHeader$insc_coord.sra
$PBExportComments$Sistema de Reinscripción para coordinaciones
forward
global type insc_coord from application
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

int G_per
long G_anio

STRING gs_logo

int gi_nivel_usuario, gi_cve_coordinacion = 0
string gs_nivel_coordinacion = ""

boolean gb_liberacion_vigente = false
boolean gb_es_coordinacion_integ_ru = false

//nombre de la conexion en parametros_conexion
CONSTANT	string	gs_controlescolar_cnx	=	"controlescolar_inscripcion"
CONSTANT	string	gs_tesoreria_cnx			=	"controlescolar_inscripcion_tesoreria"
CONSTANT	string	gs_becas_cnx				=	"controlescolar_inscripcion_becas"


STRING gs_tipo_periodo

STRING gs_multiples_periodos
STRING gs_periodo_default
STRING gs_descripcion_periodo

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

global type insc_coord from application
string appname = "insc_coord"
string appruntimeversion = "21.0.0.1311"
end type
global insc_coord insc_coord

on insc_coord.create
appname="insc_coord"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on insc_coord.destroy
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
long ll_cve_coordinacion

/* Get the environment information */
IF ( GetEnvironment(env) <> 1 ) THEN
	MessageBox( "Application: Open", "Unable to get environment information.~nHalting ..." )
	HALT
END IF


toolbarframetitle="Sistema de Control Escolar"

/*Inicializar variable globales*/
gtr_parametros_iniciales = create transaction

// Create the global variable for security support.
//	g_nv_security = CREATE nv_security
//	g_nv_components = CREATE nv_components


	/* Open MDI frame window */
	

	open(w_login_insc_coord)


	s_userid = message.stringParm
	usuario	=	s_userid


	IF s_userid <> "" THEN
		li_ret = f_usuario_valido_aplicacion(GetApplication().appname,s_userid,SQLCA)		
		if (li_ret = 1) then //usuario_valido
			ll_cve_coordinacion = f_obten_coord_de_usuario (usuario)
			if f_existe_coordinacion (ll_cve_coordinacion) and ll_cve_coordinacion <> 9999 then
				gb_es_coordinacion_integ_ru = f_es_coordinacion_integ_ru (ll_cve_coordinacion)
				gi_cve_coordinacion = ll_cve_coordinacion
				gs_nivel_coordinacion = f_obten_nivel_coordinacion(gi_cve_coordinacion)
				if gs_nivel_coordinacion = '' OR ISNULL(gs_nivel_coordinacion) OR LEN(gs_nivel_coordinacion) = 0 then
					MessageBox("Coordinación sin nivel relacionado", "Error al determinar el nivel de la coordinación [Licenciatura/Posgrado] ",Exclamation!)									
					HALT CLOSE
				end if
				open(w_insc_coord)
			else
				MessageBox("Coordinador inválido", "El usuario que está utilizando no está registrado como coordinador",Exclamation!)				
			end if
		elseif li_ret = 0	then// usuario invalido
			MessageBox("Usuario desconocido", "El usuario no tiene permisos para entrar a esta aplicación",Exclamation!)
			HALT CLOSE
		else	//Error BD
			MessageBox("Error de Comunicación","Error con la consulta de seguridad BD. Favor de intentar nuevamente", None!)
			HALT CLOSE
		end if
	end if




end event

