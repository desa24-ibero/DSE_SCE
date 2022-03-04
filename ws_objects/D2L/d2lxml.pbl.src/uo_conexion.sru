$PBExportHeader$uo_conexion.sru
forward
global type uo_conexion from nonvisualobject
end type
end forward

global type uo_conexion from nonvisualobject
end type
global uo_conexion uo_conexion

type variables
STRING is_error
end variables

forward prototypes
public function integer conecta_bd ()
public function integer desconecta_bd ()
end prototypes

public function integer conecta_bd ();
SQLCA.database = ProfileString ("d2l_xml.ini", "SCE", "database", "") 
SQLCA.dbms = ProfileString ("d2l_xml.ini", "SCE", "dbms", "") 
//SQLCA.dbparm = ProfileString ("d2l_xml.ini", "SCE", "dbparm", "") 
SQLCA.logid = gs_usuario
SQLCA.logpass = gs_password 
SQLCA.servername = ProfileString ("d2l_xml.ini", "SCE", "servername", "")   
SQLCA.AUTOCOMMIT = TRUE 


//SQLCA.database = ProfileString ("d2l_xml.ini", "PARAM", "database", "")
//SQLCA.dbms = ProfileString ("d2l_xml.ini", "PARAM", "dbms", "")
//SQLCA.dbparm = ProfileString ("d2l_xml.ini", "PARAM", "dbparm", "") 
//SQLCA.logid = gs_usuario
//SQLCA.logpass = gs_password 
//SQLCA.servername = ProfileString ("d2l_xml.ini", "PARAM", "servername", "")   
//SQLCA.AUTOCOMMIT = TRUE 


CONNECT USING(SQLCA); 
IF SQLCA.SQLCODE < 0 THEN 
	is_error = SQLCA.SQLERRTEXT  
	MESSAGEBOX("Error", "Se produjo un error al conectarse a la Base de Datos: " + is_error)  
	RETURN -1
END IF 

//STRING ls_sintaxis_sql 
//ls_sintaxis_sql = 'SET IMPLICIT_TRANSACTIONS OFF'
//EXECUTE IMMEDIATE :ls_sintaxis_sql USING SQLCA; 




end function

public function integer desconecta_bd ();
DISCONNECT USING SQLCA; 

IF SQLCA.SQLCODE < 0 THEN  
	MESSAGEBOX("Error", SQLCA.SQLERRTEXT) 
	RETURN -1 
END IF 

RETURN 0 



end function

on uo_conexion.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_conexion.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

