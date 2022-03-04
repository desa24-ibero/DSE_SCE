$PBExportHeader$uo_parametros.sru
forward
global type uo_parametros from nonvisualobject
end type
end forward

global type uo_parametros from nonvisualobject
end type
global uo_parametros uo_parametros

type variables
LONG il_cuenta 
LONG il_cve_carrera 
LONG il_plan  
LONG il_num_relacion 

STRING is_documento

LONG il_relacion[] 



end variables

on uo_parametros.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_parametros.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

