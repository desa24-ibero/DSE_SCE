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
TRANSACTION itr_trans

LONG il_coordinacion 
LONG il_area 
LONG il_cve_carrera 
INTEGER ie_plan 

INTEGER le_anio 
INTEGER le_periodo



end variables
on uo_paso_parm_manresa.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_paso_parm_manresa.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

