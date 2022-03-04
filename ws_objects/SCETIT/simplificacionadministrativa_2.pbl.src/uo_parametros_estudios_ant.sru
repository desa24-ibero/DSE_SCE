$PBExportHeader$uo_parametros_estudios_ant.sru
forward
global type uo_parametros_estudios_ant from nonvisualobject
end type
end forward

global type uo_parametros_estudios_ant from nonvisualobject
end type
global uo_parametros_estudios_ant uo_parametros_estudios_ant

type variables
LONG il_cve_carrera
LONG il_cve_plan 
STRING is_carrera
end variables

on uo_parametros_estudios_ant.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_parametros_estudios_ant.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

