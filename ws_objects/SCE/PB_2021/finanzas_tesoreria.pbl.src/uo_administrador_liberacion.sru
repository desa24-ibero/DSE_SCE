$PBExportHeader$uo_administrador_liberacion.sru
forward
global type uo_administrador_liberacion from nonvisualobject
end type
end forward

global type uo_administrador_liberacion from nonvisualobject
end type
global uo_administrador_liberacion uo_administrador_liberacion

forward prototypes
public function boolean of_liberacion_vigente (string as_sistema)
public function boolean of_obten_control_correcto (string as_sistema, string as_application, string as_control, string as_object_type, ref string as_control_correcto)
end prototypes

public function boolean of_liberacion_vigente (string as_sistema);//of_liberacion_vigente
//Recibe 	as_sistema
//Devuelve	booleano que indica si existe una liberacion en curso

string ls_nombre_servidor, ls_nombre_base_datos, ls_mensaje_sql
integer li_codigo_sql, li_liberacion_vigente

as_sistema= upper(as_sistema)

SELECT COUNT(*)
INTO  :li_liberacion_vigente
FROM parametros_liberacion
WHERE sistema = :as_sistema
AND   liberacion_vigente = 1
USING gtr_sce;

ls_mensaje_sql= gtr_sce.SqlErrtext
li_codigo_sql= gtr_sce.SqlCode

IF li_codigo_sql= -1 THEN
	MessageBox("No es posible consultar los parametros de liberacion", ls_mensaje_sql, StopSign!)
	gb_liberacion_vigente = false
	RETURN  False
ELSEIF  li_codigo_sql = 100 THEN
	gb_liberacion_vigente = false
	Return False
ELSE
	IF li_liberacion_vigente>0 THEN
		gb_liberacion_vigente = true
		RETURN True
	ELSE
		gb_liberacion_vigente = false
		RETURN False
	END IF
END IF

end function

public function boolean of_obten_control_correcto (string as_sistema, string as_application, string as_control, string as_object_type, ref string as_control_correcto);//of_obten_control_correcto
//Recibe	as_sistema		
//			as_application
//			as_control
//			as_object_type
//Devuelve
//			Un booleano que indica si el objeto tiene consideraciones durante la liberacion
//			as_control_correcto	Nombre del control a utilizar en la liberacion o nulo de
//										no existir definicion para dicho objeto

string ls_control_correcto
string ls_mensaje_sql, ls_control_original, ls_control_liberacion_vigente,	ls_control_liberacion_inactiva
integer li_codigo_sql

as_sistema= upper(as_sistema)


SELECT control_original,
		control_liberacion_vigente,
		control_liberacion_inactiva
INTO  :ls_control_original,
		:ls_control_liberacion_vigente,
		:ls_control_liberacion_inactiva
FROM objeto_alterno_liberacion
WHERE sistema = :as_sistema
AND	application	= :as_application				
AND	control_original = :as_control		
AND	object_type	= :as_object_type
USING gtr_sce;

ls_mensaje_sql= gtr_sce.SqlErrtext
li_codigo_sql= gtr_sce.SqlCode

IF li_codigo_sql= -1 THEN
	MessageBox("No es posible consultar los objetos de liberacion", ls_mensaje_sql, StopSign!)
	RETURN  False
ELSEIF  li_codigo_sql = 100 THEN
	ls_control_correcto = ""
	as_control_correcto = ls_control_correcto
	Return False
ELSE
	IF of_liberacion_vigente(as_sistema) THEN
		ls_control_correcto = ls_control_liberacion_vigente
	ELSE
		ls_control_correcto = ls_control_liberacion_inactiva		
	END IF
	as_control_correcto = ls_control_correcto
	Return True
END IF


RETURN false
end function

on uo_administrador_liberacion.create
TriggerEvent( this, "constructor" )
end on

on uo_administrador_liberacion.destroy
TriggerEvent( this, "destructor" )
end on

