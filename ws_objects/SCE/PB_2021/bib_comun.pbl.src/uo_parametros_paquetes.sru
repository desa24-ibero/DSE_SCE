$PBExportHeader$uo_parametros_paquetes.sru
forward
global type uo_parametros_paquetes from nonvisualobject
end type
end forward

global type uo_parametros_paquetes from nonvisualobject
end type
global uo_parametros_paquetes uo_parametros_paquetes

type variables
INTEGER ie_periodo 
INTEGER ie_anio 
LONG il_coordinacion

INTEGER ie_retorno
DATASTORE ids_paso 

LONG il_cve_mat 
STRING is_gpo 

end variables
on uo_parametros_paquetes.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_parametros_paquetes.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

