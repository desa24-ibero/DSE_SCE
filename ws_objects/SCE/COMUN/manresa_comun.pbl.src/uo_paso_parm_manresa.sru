$PBExportHeader$uo_paso_parm_manresa.sru
$PBExportComments$Servicios de materias MANRESA
forward
global type uo_paso_parm_manresa from nonvisualobject
end type
end forward

global type uo_paso_parm_manresa from nonvisualobject
end type
global uo_paso_parm_manresa uo_paso_parm_manresa

type variables

LONG il_coordinacion 
LONG il_area 
LONG il_cve_carrera 
INTEGER ie_plan 



end variables
on uo_paso_parm_manresa.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_paso_parm_manresa.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

