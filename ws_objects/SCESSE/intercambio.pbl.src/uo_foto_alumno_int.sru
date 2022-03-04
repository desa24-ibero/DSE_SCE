$PBExportHeader$uo_foto_alumno_int.sru
$PBExportComments$Objeto descendiente de uo_gvbox. Encapsula las operaciones necesarias para mostrar la foto de un alumno. La imagen es un campo blob contenido en una base de datos.
forward
global type uo_foto_alumno_int from uo_gvbox
end type
end forward

global type uo_foto_alumno_int from uo_gvbox
end type
global uo_foto_alumno_int uo_foto_alumno_int

type variables
protected string is_inifile
protected string is_section
string is_connectfrom = "1"

CONSTANT string IS_USE_INIFILE 	= "1"
CONSTANT string IS_USE_REGISTRY	= "2"
CONSTANT string IS_USE_SCRIPT 	= "3"

protected transaction itr_local
end variables

forward prototypes
public function integer of_disconnectdb ()
public function blob of_filetoblob (string as_filename)
public function blob of_getphoto (long al_cuenta, integer ai_tipo)
public function integer of_connectdb ()
public subroutine of_blobtofile (string as_filename, ref blob ablb_blob)
public subroutine of_transaction (transaction atr_transaction)
public function transaction of_transaction ()
public function integer of_getconnectioninfo (ref string as_dbms, ref string as_database, ref string as_userid, ref string as_dbpass, ref string as_logid, ref string as_logpass, ref string as_server, ref string as_dbparm, ref string as_lock, ref string as_autocommit)
public function integer of_init (string as_inifile, string as_inisection)
public function integer of_set_blob (ref blob ablob_foto)
public subroutine of_loadphoto (long al_cuenta, integer ai_tipo)
end prototypes

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
//	Desconecta la base de datos usando la transacción local y devuelve el
//	valor de la propiedad sqlcode.
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
Disconnect using itr_local;

If itr_local.SQLCode <> 0 Then
	MessageBox ("Cannot Disconnect to Database", itr_local.SQLErrText )
End If

Return itr_local.SQLCode
end function

public function blob of_filetoblob (string as_filename);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_filetoblob
//
//	Access:  public
//
//	Arguments:
//	as_filename		La ruta y el nombre del archivo a leer.
//
//	Returns:
//	Blob
//
//	Description:
//	Lee un archivo de formato binario cuyo nombre ha indicado el usuario y
//	lo convierte en un objeto tipo BLOB.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
Integer li_FileNum, li_Index, li_Loops
Long    ll_FileLength, ll_Bytes_Read
Blob    lblb_Input, lblb_Temp

// RETURN NULL IF FILE DOES NOT EXIST
IF NOT FileExists(as_filename) THEN 
  SetNull(lblb_Input)
  RETURN lblb_Input
END IF

ll_FileLength = FileLength(as_filename)

IF ll_FileLength > 32765 THEN
  IF Mod(ll_FileLength, 32765) = 0 THEN
    li_Loops = ll_FileLength / 32765
  ELSE
    li_Loops = (ll_FileLength / 32765) + 1
  END IF
ELSE
  li_Loops = 1
END IF
li_FileNum = FileOpen(as_filename, StreamMode!, Read!, LockReadWrite!)

FOR li_Index = 1 TO li_Loops
  FileRead(li_FileNum, lblb_Temp)
  lblb_Input = lblb_Input + lblb_Temp
NEXT
  
FileClose(li_FileNum)

RETURN lblb_Input

end function

public function blob of_getphoto (long al_cuenta, integer ai_tipo);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_getphoto
//
//	Access:  public
//
//	Arguments:
//	al_cuenta		Número de cuenta de un alumno.
//	ai_tipo			Identificador de la fuente de donde tomará la fotografía:
//						1 = fotos_alumnos
//						2 = fotos_alumnos_dica
//
//	Returns:
//	Blob
//
//	Description:
//	Recupera de la base de datos la fotografía de un alumno que tiene la
//	cuenta indicada y que corresponde al tipo solicitado.
//	La imagen es devuelta como una variable de tipo blob.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
integer li_tipoAl
Blob lblob_foto

li_tipoAl =ai_tipo

// Seleccion del blob de foto del alumno segun el argumento 'al_cuenta'
if li_tipoAl =1 then

	SELECTBLOB foto
	INTO :lblob_foto 
	FROM fotos_alumnos
	WHERE cuenta = :al_cuenta
	Using itr_local;
end if

if li_tipoAl =2 then

	SELECTBLOB foto
	INTO :lblob_foto 
	FROM fotos_alumnos_dica
	WHERE cuenta = :al_cuenta
	Using itr_local;
end if


if itr_local.sqlcode <> 0 then
     MessageBox ('No se encontro la fotografía', itr_local.sqlerrtext,StopSign!)
     SetNull(lblob_foto)
end if

Return lblob_foto
end function

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
//	Realiza la conexión a la base de datos con la transacción local y
//	devuelve el valor de la propiedad sqlcode.
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
Connect using itr_local;

If itr_local.SQLCode <> 0 Then
	MessageBox ("Cannot Connect to Database", itr_local.SQLErrText )
End If

Return itr_local.SQLCode
end function

public subroutine of_blobtofile (string as_filename, ref blob ablb_blob);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_blobtofile
//
//	Access:  public
//
//	Arguments:
//	as_filename		La ruta y el nombre del archivo a grabar.
//	ablb_object		Objeto tipo BLOB que se va a guardar como
//						archivo.
//
//	Returns:
//	None
//
//	Description:
//	Recibe un objeto tipo BLOB y lo guarda en un archivo en formato binario
//	con el nombre dado por el usuario.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
Long    ll_FileLength
Integer li_Loops, li_Index, li_FileNum
Blob    lblb_Temp

ll_FileLength = Len(ablb_blob)

IF ll_FileLength > 32765 THEN
  IF Mod(ll_FileLength, 32765) = 0 THEN
    li_Loops = ll_FileLength / 32765
  ELSE
    li_Loops = (ll_FileLength / 32765) + 1
  END IF
ELSE
  li_Loops = 1
END IF
  
li_FileNum = FileOpen(as_filename, StreamMode!, Write!, LockReadWrite!, Replace!)
FOR li_Index = 1 TO li_Loops
  lblb_Temp = BlobMid(ablb_blob, ((32765 * li_Index) - 32765 + 1), 32765)
  FileWrite(li_FileNum, lblb_Temp)
NEXT

FileClose(li_FileNum)
end subroutine

public subroutine of_transaction (transaction atr_transaction);
//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_transaction
//
//	Access:  public
//
//	Arguments:
//	transaction	atr_transaction
//
//	Returns:
//	none
//
//	Description:
//	Establece los valores de la transacción local usando otra transacción.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////


itr_local = atr_transaction
end subroutine

public function transaction of_transaction ();
//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_transaction
//
//	Access:  public
//
//	Arguments:
//	none
//
//	Returns:
//	transaction
//
//	Description:
//	Devuelve la transacción usada para la conexión a la base de datos.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

return itr_local
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
		
		as_dbms			= ProfileString ( is_inifile, is_section, "DBMS",			"ODBC")
		as_database		= ProfileString ( is_inifile, is_section, "Database",		"EAS Demo DB V3")
		as_userid		= ProfileString ( is_inifile, is_section, "UserID",		"")
		as_dbpass		= ProfileString ( is_inifile, is_section, "DBPass",		"")
		as_logid			= ProfileString ( is_inifile, is_section, "LogID",			"")
		as_logpass		= ProfileString ( is_inifile, is_section, "LogPassword",	"")
		as_server		= ProfileString ( is_inifile, is_section, "Servername",	"")
		as_dbparm		= ProfileString ( is_inifile, is_section, "DBParm",		"ConnectString='DSN=EAS Demo DB V3;UID=dba;PWD=sql'")
		as_lock			= ProfileString ( is_inifile, is_section, "Lock",			"")
		as_autocommit	= ProfileString ( is_inifile, is_section, "AutoCommit",	"false")

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

public function integer of_init (string as_inifile, string as_inisection);//////////////////////////////////////////////////////////////////////////////
//	Public Function:  of_Init
//	Arguments:		as_inifile   		Archivo .INI para leer valores.
//						as_inisection   	La sección dentro del archivo .INI donde
//												están los valores del objeto de transacción.
//	Returns:			integer
//	 					1 = Éxito
//						-1 = Error
//	Description:	Inicializa las propiedades del objeto de transacción con valores
//						desde un archivo .INI. Los valores que no son encontrados serán
//						por default una cadena vacía. Tomado del objeto pfc_n_tr.
//
//////////////////////////////////////////////////////////////////////////////
//	Rev. History	Version
//						5.0   Initial version
//////////////////////////////////////////////////////////////////////////////
//	Copyright © 1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////

// Check arguments
if IsNull (as_inifile) or IsNull (as_inisection) or &
	Len (Trim (as_inifile))=0 or Len (Trim (as_inisection))=0 or &
	(not FileExists (as_inifile)) then return -1

itr_local.DBMS= ProfileString (as_inifile, as_inisection, 'DBMS', '')
itr_local.Database = ProfileString (as_inifile, as_inisection, 'Database', '')
itr_local.LogID = ProfileString (as_inifile, as_inisection, 'LogID', '')
itr_local.LogPass = ProfileString (as_inifile, as_inisection, 'LogPassword', '')
itr_local.ServerName = ProfileString (as_inifile, as_inisection, 'ServerName', '')
itr_local.UserID = ProfileString (as_inifile, as_inisection, 'UserID', '')
itr_local.DBPass =ProfileString (as_inifile, as_inisection, 'DatabasePassword', '')
itr_local.Lock =ProfileString (as_inifile, as_inisection, 'Lock', '')
itr_local.DBParm =ProfileString (as_inifile, as_inisection, 'DBParm', '')
itr_local.AutoCommit = f_Boolean (ProfileString (as_inifile, as_inisection, 'AutoCommit', 'false'))
if IsNull (itr_local.AutoCommit) then itr_local.AutoCommit = false

return 1
end function

public function integer of_set_blob (ref blob ablob_foto);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_set_blob
//
//	Access:  public
//
//	Arguments:
//	ablob_foto 	blob
//
//	Returns:
//	integer		Resultado de asignación
//
//	Description:
//	Establece el blob en el objeto ole
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
integer li_asignacion
if not isnull(ablob_foto) then
	this.ole_1.event pfc_InsertObject()
	li_asignacion = 1
else 
	li_asignacion = -1
end if

return li_asignacion

end function

public subroutine of_loadphoto (long al_cuenta, integer ai_tipo);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_loadphoto
//
//	Access:  public
//
//	Arguments:
//	al_cuenta		Número de cuenta de un alumno.
//						Este parámetro es necesario porque lo requiere la función
//						of_getphoto (vea la documentación de la función)
//	ai_tipo			Identificador de la fuente de donde tomará la fotografía.
//						Este parámetro es necesario porque lo requiere la función
//						of_getphoto (vea la documentación de la función)
//
//	Returns:
//	None
//
//	Description:
//	Primero. Recupera de la base de datos la imagen asociada a la cuenta.
//	Segundo. La guarda como un archivo en formato jpg.
//	Tercero. Carga la fotografía del alumno en el control gvbox.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
string ls_filename
blob lblob_photo

ls_filename = "photo_" + string(al_cuenta) + ".jpg"
lblob_photo = this.of_getphoto(al_cuenta,ai_tipo)
if not isnull(lblob_photo) then
	this.of_blobtofile(ls_filename,lblob_photo)
	// truena al ejecutarse
	//	this.of_filename(ls_filename) 
	//	FileDelete(ls_filename)
else
	//	this.of_filename("")
end if
	



end subroutine

on uo_foto_alumno_int.create
call super::create
end on

on uo_foto_alumno_int.destroy
call super::destroy
end on

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Object Name:  uo_foto_alumno
//
//	Description:
//	Objeto de usuario para mostrar las fotografías de los alumnos de la UIA.
//	Este objeto trabaja como un servicio.
//	Interfase.
//	1.- Consta de un control ole descendiente de uo_gvbox.
//	Operación.
// 1.- Establecer el archivo ini usando of_inifile().
// 2.- Abrir la conexión con la base de datos usando of_connectdb().
//	3.- Realiza la carga de una imagen, por número de cuenta, llamando la
//	función of_loadphoto(cuenta).
//	4.- Cerrar la conexión con of_disconnectdb().
//
//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	constructor
//
//	Arguments:
//	None
//
//	Returns:
//	Long
//
//	Description:
//	Crea el objeto de transacción apropiado para el objeto de usuario.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

itr_local = create transaction

end event

event destructor;call super::destructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	destructor
//
//	Arguments:
//	None
//
//	Returns:
//	Long
//
//	Description:
//	Destruye el objeto de transacción.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

destroy itr_local
end event

type ole_1 from uo_gvbox`ole_1 within uo_foto_alumno_int
end type

event ole_1::constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	constructor
//
//	Arguments:
//	None
//
//	Returns:
//	Long
//
//	Description:
//	Ajuste horizontal de la imagen manteniendo la proporción. 
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//***+this.object.autosize = 2


end event

