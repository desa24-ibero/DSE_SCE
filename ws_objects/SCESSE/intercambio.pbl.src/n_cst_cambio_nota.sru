$PBExportHeader$n_cst_cambio_nota.sru
$PBExportComments$Objeto de transacción que almacena los procedimientos almacenados utilizados en el cambio de nota.Vea w_cambio_nota_1 y w_cambio_nota_2.
forward
global type n_cst_cambio_nota from transaction
end type
end forward

global type n_cst_cambio_nota from transaction
end type
global n_cst_cambio_nota n_cst_cambio_nota

type prototypes
function long sp_cambio_nota_provisional(long arg_iCuenta,long arg_iMateria,string arg_sCalificacion, long periodo, long anio) RPCFUNC ALIAS FOR "dbo.sp_cambio_nota_provisional"
function long sp_cambio_nota_definitiva (long arg_iCuenta,long arg_iMateria,string arg_sCalificacion, long periodo, long anio) RPCFUNC ALIAS FOR "dbo.sp_cambio_nota_definitiva"

end prototypes

type variables
string is_connectfrom = "1"

CONSTANT string IS_USE_INIFILE 	= "1"
CONSTANT string IS_USE_REGISTRY	= "2"
CONSTANT string IS_USE_SCRIPT 	= "3"

end variables

forward prototypes
public function integer of_connectdb ()
public function integer of_disconnectdb ()
public function integer of_getconnectioninfo (ref string as_dbms, ref string as_database, ref string as_userid, ref string as_dbpass, ref string as_logid, ref string as_logpass, ref string as_server, ref string as_dbparm, ref string as_lock, ref string as_autocommit)
public function integer of_valida_seriacion_intercambio (long al_cuenta, long al_cve_mat, ref boolean ab_seriada_inscrita, ref boolean ab_seriada_cursada)
public function integer of_es_cambio_nota_definitivo (long al_cuenta, long al_cve_mat, ref boolean ab_cambio_nota_definitivo)
public function integer of_cambio_nota_provisional (long al_cuenta, long al_cve_mat, string as_calificacion, integer ai_periodo, integer ai_anio)
public function integer of_sanciona_ser_int_mat_insc (long al_cuenta)
public function integer of_sanciona_ser_int_historico (long al_cuenta)
public function integer of_reactiva_mat_intercambio (long al_cuenta, long al_cve_mat, long al_cve_motivo)
public function integer of_cambio_nota_definitivo (long al_cuenta, long al_cve_mat, string as_calificacion, integer ai_periodo, integer ai_anio)
end prototypes

public function integer of_connectdb ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_connectdb
//
//	Access:  public
//
//	Arguments:
//	None
//
//	Returns:
//	Integer
//
//	Description:
//	Realiza la conexión con la base de datos y devuelve el valor de la
//	propiedad sqlcode.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//*--------------------------------------------------------*/
//*  Make a connection to the database
//*--------------------------------------------------------*/
/*  Actual DB connection */
Connect using this;

If this.SQLCode <> 0 Then
	MessageBox ("Cannot Connect to Database", this.SQLErrText )
End If

Return this.SQLCode
end function

public function integer of_disconnectdb ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_disconnectdb
//
//	Access:  public
//
//	Arguments:
//	None
//
//	Returns:
//	Integer
//
//	Description:
//	Desconecta la base de datos y devuelve el valor de la propiedad sqlcode.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//*--------------------------------------------------------*/
//*  Disconnect from database
//*--------------------------------------------------------*/
/*  Actual DB disconnection */
Disconnect using this;

If this.SQLCode <> 0 Then
	MessageBox ("Cannot Disconnect to Database", this.SQLErrText )
End If

Return this.SQLCode
end function

public function integer of_getconnectioninfo (ref string as_dbms, ref string as_database, ref string as_userid, ref string as_dbpass, ref string as_logid, ref string as_logpass, ref string as_server, ref string as_dbparm, ref string as_lock, ref string as_autocommit);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_getconnectioninfo
//
//	Access:  public
//
//	Arguments:
//	as_dbms			Identificador del proveedor de la base de datos.
//	as_database		El nombre de la base de datos.
//	as_userid		El nombre o ID del usuario que se unirá a la base de datos.
//	as_dbpass		La contraseña que será usada para unirse a la base de datos.
//	as_logid			El nombre o ID del usuario quien se conectará al servidor.
//	as_logpass		La contraseña que será usada para conectarse al servidor.
//	as_server		El nombre del servidor en el cual reside la base de datos.
//	as_dbparm		Parámetros específicos del DBMS.
//	as_lock			Nivel de aislamiento.
//	as_autocommit	Indicador de commit.
//						TRUE = Aplica de manera automática el commit después
//						de cada operación de la base de datos.
//						FALSE= No aplica de manera automática el commit después
//						de cada operación de la base de datos. 
//
//	Returns: Integer
//	 1 = éxito
//	-1 = fracaso
//
//	Description:
//	Obtiene los parámetros de conexión de la base de datos y devuelve un
//	valor que indica el éxito o fracaso de la operación.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//*--------------------------------------------------------*/
//*  The source of connection information can be changed by
//*  altering the value of the 'is_connectfrom' variable.
//*--------------------------------------------------------*/
Choose Case is_connectfrom
		
	Case IS_USE_INIFILE						/*  Populate Database Connection from INI file  */
		string ls_inifile

		ls_inifile = gnv_app.of_GetAppIniFile()
		
		as_dbms			= ProfileString ( ls_inifile, "Database", "DBMS",			"ODBC")
		as_database		= ProfileString ( ls_inifile, "Database", "Database",		"EAS Demo DB V3")
		as_userid		= ProfileString ( ls_inifile, "Database", "UserID",		"")
		as_dbpass		= ProfileString ( ls_inifile, "Database", "DBPass",		"")
		as_logid			= ProfileString ( ls_inifile, "Database", "LogID",			"")
		as_logpass		= ProfileString ( ls_inifile, "Database", "LogPassword",	"")
		as_server		= ProfileString ( ls_inifile, "Database", "Servername",	"")
		as_dbparm		= ProfileString ( ls_inifile, "Database", "DBParm",		"ConnectString='DSN=EAS Demo DB V3;UID=dba;PWD=sql'")
		as_lock			= ProfileString ( ls_inifile, "Database", "Lock",			"")
		as_autocommit	= ProfileString ( ls_inifile, "Database", "AutoCommit",	"false")

	Case IS_USE_REGISTRY						/*  Populate Database Connection from Registry  */
		string ls_registrykey = "" + "\DataBase"
		
		If RegistryGet ( ls_registrykey, "DBMS", 			RegString!, as_dbms ) <> 1 Then
			RegistrySet ( ls_registrykey, "DBMS", 			RegString!, "ODBC" )
			RegistryGet ( ls_registrykey, "DBMS", 			RegString!, as_dbms )
		End If
		If RegistryGet ( ls_registrykey, "Database", 	RegString!, as_database ) <> 1 Then
			RegistrySet ( ls_registrykey, "Database", 	RegString!, "EAS Demo DB V3" )
			RegistryGet ( ls_registrykey, "Database", 	RegString!, as_database )
		End If
		If RegistryGet ( ls_registrykey, "UserID", 		RegString!, as_userid ) <> 1 Then
			RegistrySet ( ls_registrykey, "UserID", 		RegString!, "" )
			RegistryGet ( ls_registrykey, "UserID", 		RegString!, as_userid )
		End If
		If RegistryGet ( ls_registrykey, "DBPass", 		RegString!, as_dbpass ) <> 1 Then
			RegistrySet ( ls_registrykey, "DBPass", 		RegString!, "" )
			RegistryGet ( ls_registrykey, "DBPass", 		RegString!, as_dbpass )
		End If
		If RegistryGet ( ls_registrykey, "LogID", 		RegString!, as_logid ) <> 1 Then
			RegistrySet ( ls_registrykey, "LogID", 		RegString!, "" )
			RegistryGet ( ls_registrykey, "LogID", 		RegString!, as_logid )
		End If
		If RegistryGet ( ls_registrykey, "LogPassword", RegString!, as_logpass ) <> 1 Then
			RegistrySet ( ls_registrykey, "LogPassword", RegString!, "" )
			RegistryGet ( ls_registrykey, "LogPassword", RegString!, as_logpass )
		End If
		If RegistryGet ( ls_registrykey, "Servername", 	RegString!, as_server ) <> 1 Then
			RegistrySet ( ls_registrykey, "Servername", 	RegString!, "" )
			RegistryGet ( ls_registrykey, "Servername", 	RegString!, as_server )
		End If
		If RegistryGet ( ls_registrykey, "DBParm", 		RegString!, as_dbparm ) <> 1 Then
			RegistrySet ( ls_registrykey, "DBParm", 		RegString!, "ConnectString='DSN=EAS Demo DB V3;UID=dba;PWD=sql'" )
			RegistryGet ( ls_registrykey, "DBParm", 		RegString!, as_dbparm )
		End If
		If RegistryGet ( ls_registrykey, "Lock", 			RegString!, as_lock ) <> 1 Then
			RegistrySet ( ls_registrykey, "Lock", 			RegString!, "" )
			RegistryGet ( ls_registrykey, "Lock", 			RegString!, as_lock )
		End If
		If RegistryGet ( ls_registrykey, "AutoCommit", 	RegString!, as_autocommit ) <> 1 Then
			RegistrySet ( ls_registrykey, "AutoCommit", 	RegString!, "false" )
			RegistryGet ( ls_registrykey, "AutoCommit", 	RegString!, as_autocommit )
		End If

	Case IS_USE_SCRIPT							/*  Populate Database Connection from Script  */
		as_dbms			= "ODBC"
		as_database		= "EAS Demo DB V3"
		as_userid		= ""
		as_dbpass		= ""
		as_logid			= ""
		as_logpass		= ""
		as_server		= ""
		as_dbparm		= "ConnectString='DSN=EAS Demo DB V3;UID=dba;PWD=sql'"
		as_lock			= ""
		as_autocommit	= "false"

		
	Case Else
		
		Return -1
		
End Choose

Return 1
end function

public function integer of_valida_seriacion_intercambio (long al_cuenta, long al_cve_mat, ref boolean ab_seriada_inscrita, ref boolean ab_seriada_cursada); //of_valida_seriacion_intercambio
//long arg_iCuenta,long arg_iMateria,string arg_sCalificacion, long periodo, long anio
//
//Efectua la validación de los posrrequisitos de una materia
//
//Recibe:
//	al_cuenta				long
// al_cve_mat		 		long
// ab_seriada_inscrita	boolean
// ab_seriada_cursada	boolean
//
//Devuelve integer

decimal ld_promedio
string ls_mensaje
integer li_codigo_error, li_cve_carrera, li_cve_plan, li_cve_altura, li_mat_inscritas, li_mat_cursadas

SELECT cve_carrera,     cve_plan
INTO   :li_cve_carrera, :li_cve_plan
FROM academicos
WHERE cuenta = :al_cuenta
USING gtr_sce;

li_codigo_error= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
	
if li_codigo_error = -1 then
	MessageBox("Error al consultar academicos", ls_mensaje)
	return -1
elseif li_codigo_error = 100 then
	MessageBox("Alumno inexistente", "No se encontro al alumno con numero de cuenta ["+string(al_cuenta)+"]"+ls_mensaje)
	return -1
//		OK		
//		COMMIT USING gtr_sce;
end if

li_cve_altura = 0

//Declara el stored procedure que realiza la validación de los posrrequisitos de una materia
	DECLARE sp_posrrequisitos PROCEDURE FOR sp_posrrequisitos_int  
			@cuenta      	= :al_cuenta,
			@cve_mat_base  = :al_cve_mat,
			@cve_mat       = :al_cve_mat,
			@cve_carrera   = :li_cve_carrera, 	
			@cve_plan      = :li_cve_plan,
			@cve_altura    = :li_cve_altura
	USING gtr_sce;

//Efectua el cambio de nota
	execute sp_posrrequisitos;
	
	li_codigo_error= gtr_sce.SQLCode
	ls_mensaje= gtr_sce.SQLErrText
	
	if li_codigo_error = -1 then
		ROLLBACK USING gtr_sce;
		MessageBox("Error al ejecutar stored procedure sp_posrrequisitos_int", ls_mensaje)
		return -1
	elseif li_codigo_error = 0 then
		
//		OK		
//		COMMIT USING gtr_sce;

	end if

//Cierra el stored procedure	
	close sp_posrrequisitos;
	
	
SELECT COUNT(mi.cuenta)
INTO :li_mat_inscritas
FROM posrrequisitos_intercambio posint,
mat_inscritas mi
WHERE posint.cuenta = mi.cuenta
AND posint.cve_posrreq = mi.cve_mat
AND mi.cuenta = :al_cuenta
AND posint.cve_mat_base = :al_cve_mat
AND posint.cuenta not in (select historico.cuenta 
									from historico 
									where historico.cve_mat = :al_cve_mat
									and  historico.calificacion in ('6','7','8','9','10','AC','MB','B','S','RE','E') 
									and  historico.gpo <>'ZZ')
USING gtr_sce;

li_codigo_error= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
	
if li_codigo_error = -1 then
	MessageBox("Error al consultar posrrequisitos_intercambio, mat_inscritas", ls_mensaje)
	return -1

//elseif li_codigo_error = 0 then

end if


SELECT COUNT(h.cuenta)
INTO :li_mat_cursadas
FROM posrrequisitos_intercambio posint,
historico h
WHERE posint.cuenta = h.cuenta
AND posint.cve_posrreq = h.cve_mat
AND h.cuenta = :al_cuenta
AND posint.cve_mat_base = :al_cve_mat
AND h.cuenta not in (select historico.cuenta 
									from historico 
									where historico.cve_mat = :al_cve_mat
									and  historico.calificacion in ('6','7','8','9','10','AC','MB','B','S','RE','E') 
									and  historico.gpo <>'ZZ')
USING gtr_sce;

li_codigo_error= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
	
if li_codigo_error = -1 then
	MessageBox("Error al consultar posrrequisitos_intercambio, historico", ls_mensaje)
	return -1
//elseif li_codigo_error = 0 then

end if
 
if li_mat_inscritas >0 then
	ab_seriada_inscrita = true
else
	ab_seriada_inscrita = false
end if
	
if li_mat_cursadas >0 then
	ab_seriada_cursada = true
else
	ab_seriada_cursada = false
end if

return 0


end function

public function integer of_es_cambio_nota_definitivo (long al_cuenta, long al_cve_mat, ref boolean ab_cambio_nota_definitivo); //of_es_cambio_nota_definitivo
//long arg_iCuenta,long arg_iMateria,string arg_sCalificacion, long periodo, long anio
//
//Efectua la validación de los posrrequisitos de una materia
//
//Recibe:
//	al_cuenta				long
// al_cve_mat		 		long
//
//Devuelve integer

decimal ld_promedio
string ls_mensaje
integer li_codigo_error, li_num_cambios_nota
ab_cambio_nota_definitivo = false

SELECT COUNT(cuenta)
INTO :li_num_cambios_nota
FROM v_dca_cambio_nota_definitivo
WHERE cuenta = :al_cuenta
AND   cve_mat = :al_cve_mat
USING gtr_sce;

li_codigo_error= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
	
if li_codigo_error = -1 then
	MessageBox("Error al consultar v_dca_cambio_nota_definitivo", ls_mensaje)
	return -1
end if

if li_num_cambios_nota >0 then
	ab_cambio_nota_definitivo = true
else
	ab_cambio_nota_definitivo = false
end if
	
return 0


end function

public function integer of_cambio_nota_provisional (long al_cuenta, long al_cve_mat, string as_calificacion, integer ai_periodo, integer ai_anio);//of_cambio_nota_provisional
//long arg_iCuenta,long arg_iMateria,string arg_sCalificacion, long periodo, long anio
//
//Efectua el cambio de nota provisional efectuando una llamada a un stored procedure
//
//Recibe:
//	al_cuenta			long
// al_cve_mat		 	long
// as_calificacion	string
// ai_periodo			int
//	ai_anio				int
//
//Devuelve integer

decimal ld_promedio
string ls_mensaje
integer li_codigo_error

//Declara el stored procedure que efectua el cambio de nota provisional
	DECLARE cambio_nota PROCEDURE FOR sp_cambio_nota_provisional  
			@arg_iCuenta 		 =	:al_cuenta,
			@arg_iMateria 		 =	:al_cve_mat,
			@arg_sCalificacion =	:as_calificacion,
			@periodo 		  	 = :ai_periodo, 	
			@anio  				 = :ai_anio
	USING gtr_sce;

//Efectua el cambio de nota
	gtr_sce.Autocommit = true
	execute cambio_nota;
	gtr_sce.Autocommit = false	

	li_codigo_error= gtr_sce.SQLCode
	ls_mensaje= gtr_sce.SQLErrText
	
	if li_codigo_error = -1 then
		ROLLBACK USING gtr_sce;
		MessageBox("Error al ejecutar stored procedure sp_cambio_nota_provisional", ls_mensaje)
		return -1
	elseif li_codigo_error = 0 then
//		OK		
//		COMMIT USING gtr_sce;
	end if

//Cierra el stored procedure	
	close cambio_nota;

return 0
end function

public function integer of_sanciona_ser_int_mat_insc (long al_cuenta); //of_sanciona_ser_int_mat_insc
//
//
//Efectua la validación de los posrrequisitos de una materia
//
//Recibe:
//	al_cuenta				long
//
//Devuelve integer

decimal ld_promedio
string ls_mensaje
integer li_codigo_error, li_cve_carrera, li_cve_plan, li_cve_altura, li_mat_inscritas, li_mat_cursadas

SELECT cve_carrera,     cve_plan
INTO   :li_cve_carrera, :li_cve_plan
FROM academicos
WHERE cuenta = :al_cuenta
USING gtr_sce;

li_codigo_error= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
	
if li_codigo_error = -1 then
	MessageBox("Error al consultar academicos", ls_mensaje)
	return -1
elseif li_codigo_error = 100 then
	MessageBox("Alumno inexistente", "No se encontro al alumno con numero de cuenta ["+string(al_cuenta)+"]"+ls_mensaje)
	return -1
//		OK		
//		COMMIT USING gtr_sce;
end if

li_cve_altura = 0

//Declara el stored procedure que realiza la sancion por violar seriacion de los posrrequisitos de una materia inscrita 
	DECLARE sp_ser_mat_insc PROCEDURE FOR sp_seriacion_int_mat_inscritas  
			@cuenta      	= :al_cuenta
	USING gtr_sce;

//Efectua el cambio de nota

	gtr_sce.Autocommit = true
	execute sp_ser_mat_insc;
	gtr_sce.Autocommit = false
	
	li_codigo_error= gtr_sce.SQLCode
	ls_mensaje= gtr_sce.SQLErrText
	
	if li_codigo_error = -1 then
		ROLLBACK USING gtr_sce;
		MessageBox("Error al ejecutar stored procedure sp_seriacion_int_mat_inscritas", ls_mensaje)
		return -1
	elseif li_codigo_error = 0 then
//		OK		
//		COMMIT USING gtr_sce;
	end if

//Cierra el stored procedure	
	close sp_ser_mat_insc;
	
	

return 0


end function

public function integer of_sanciona_ser_int_historico (long al_cuenta); //of_sanciona_ser_int_historico
//
//
//Efectua la validación de los posrrequisitos de una materia
//
//Recibe:
//	al_cuenta				long
//
//Devuelve integer

decimal ld_promedio
string ls_mensaje
integer li_codigo_error, li_cve_carrera, li_cve_plan, li_cve_altura, li_mat_inscritas, li_mat_cursadas

SELECT cve_carrera,     cve_plan
INTO   :li_cve_carrera, :li_cve_plan
FROM academicos
WHERE cuenta = :al_cuenta
USING gtr_sce;

li_codigo_error= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
	
if li_codigo_error = -1 then
	MessageBox("Error al consultar academicos", ls_mensaje)
	return -1
elseif li_codigo_error = 100 then
	MessageBox("Alumno inexistente", "No se encontro al alumno con numero de cuenta ["+string(al_cuenta)+"]"+ls_mensaje)
	return -1
//		OK		
//		COMMIT USING gtr_sce;
end if

li_cve_altura = 0

//Declara el stored procedure que realiza la sancion por violar seriacion de los posrrequisitos de una materia inscrita 
	DECLARE sp_ser_historico PROCEDURE FOR sp_seriacion_int_historico  
			@cuenta      	= :al_cuenta
	USING gtr_sce;

//Efectua el cambio de nota

	gtr_sce.Autocommit = true
	execute sp_ser_historico;
	gtr_sce.Autocommit = false
	
	li_codigo_error= gtr_sce.SQLCode
	ls_mensaje= gtr_sce.SQLErrText
	
	if li_codigo_error = -1 then
		ROLLBACK USING gtr_sce;
		MessageBox("Error al ejecutar stored procedure sp_seriacion_int_mat_inscritas", ls_mensaje)
		return -1
	elseif li_codigo_error = 0 then
//		OK		
//		COMMIT USING gtr_sce;
	end if

//Cierra el stored procedure	
	close sp_ser_historico;
	
	

return 0


end function

public function integer of_reactiva_mat_intercambio (long al_cuenta, long al_cve_mat, long al_cve_motivo);//of_reactiva_mat_intercambio
//long arg_iCuenta,long arg_iMateria,string arg_sCalificacion, long periodo, long anio
//
//Efectua el cambio de nota provisional efectuando una llamada a un stored procedure
//
//Recibe:
//	al_cuenta			long
// al_cve_mat		 	long
//	al_cve_motivo		long
//
//Devuelve integer

decimal ld_promedio	
string ls_mensaje
integer li_codigo_error

//Declara el stored procedure que calcula tanto el promedio como el número de créditos acumulados
	DECLARE sp_reac_mat PROCEDURE FOR sp_reactiva_mat_intercambio  
			@cuenta 		 =	:al_cuenta,
			@cve_mat 	 =	:al_cve_mat,
			@cve_motivo	 = :al_cve_motivo
	USING gtr_sce;

//Efectua el cambio de nota
	gtr_sce.Autocommit = true
	execute sp_reac_mat;
	gtr_sce.Autocommit = false	

	li_codigo_error= gtr_sce.SQLCode
	ls_mensaje= gtr_sce.SQLErrText
	
	if li_codigo_error = -1 then
		ROLLBACK USING gtr_sce;
		MessageBox("Error al ejecutar stored procedure sp_reactiva_mat_intercambio", ls_mensaje)
		return -1
	elseif li_codigo_error = 0 then
//		OK		
//		COMMIT USING gtr_sce;
	end if

//Cierra el stored procedure	
	close sp_reac_mat;

return 0

end function

public function integer of_cambio_nota_definitivo (long al_cuenta, long al_cve_mat, string as_calificacion, integer ai_periodo, integer ai_anio);//of_cambio_nota_definitivo
//long arg_iCuenta,long arg_iMateria,string arg_sCalificacion, long periodo, long anio
//
//Efectua el cambio de nota definitivo efectuando una llamada a un stored procedure
//
//Recibe:
//	al_cuenta			long
// al_cve_mat		 	long
// as_calificacion	string
// ai_periodo			int
//	ai_anio				int
//
//Devuelve integer

decimal ld_promedio
string ls_mensaje
integer li_codigo_error

//Declara el stored procedure que efectua el cambio de nota definitivo
	DECLARE cambio_nota PROCEDURE FOR sp_cambio_nota_definitivo  
			@cuenta 		 =	:al_cuenta,
			@cve_mat 		 =	:al_cve_mat,
			@arg_sCalificacion =	:as_calificacion,
			@periodo 		  	 = :ai_periodo, 	
			@anio  				 = :ai_anio
	USING gtr_sce;

//Efectua el cambio de nota
	gtr_sce.Autocommit = true
	execute cambio_nota;
	gtr_sce.Autocommit = false	

	li_codigo_error= gtr_sce.SQLCode
	ls_mensaje= gtr_sce.SQLErrText
	
	if li_codigo_error = -1 then
		ROLLBACK USING gtr_sce;
		MessageBox("Error al ejecutar stored procedure sp_cambio_nota_definitivo", ls_mensaje)
		return -1
	elseif li_codigo_error = 0 then
//		OK		
//		COMMIT USING gtr_sce;
	end if

//Cierra el stored procedure	
	close cambio_nota;

return 0
end function

on n_cst_cambio_nota.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_cambio_nota.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

