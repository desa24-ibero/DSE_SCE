$PBExportHeader$uo_parametros_cer_ant.sru
forward
global type uo_parametros_cer_ant from nonvisualobject
end type
end forward

global type uo_parametros_cer_ant from nonvisualobject
end type
global uo_parametros_cer_ant uo_parametros_cer_ant

type variables
LONG il_cve_carrera
LONG il_cve_plan 
STRING is_carrera
INTEGER ie_subsistema
STRING is_nivel 

end variables
on uo_parametros_cer_ant.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_parametros_cer_ant.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

