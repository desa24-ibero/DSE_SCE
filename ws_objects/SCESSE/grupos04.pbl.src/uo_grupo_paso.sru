$PBExportHeader$uo_grupo_paso.sru
forward
global type uo_grupo_paso from nonvisualobject
end type
end forward

global type uo_grupo_paso from nonvisualobject autoinstantiate
end type

type variables
DATASTORE ids_horario 
DATASTORE ids_profesor 
// Datastore de validación de integridad 
DATASTORE ids_sesiones

DATASTORE ids_horario_profesor

DATASTORE ids_grupo_sesion 

LONG il_cve_profesor  

INTEGER ie_retorno 

STRING is_dias_cve_dia 

DATETIME idt_inicio_semestre
DATETIME idt_fin_semestre

STRING is_sesion

INTEGER ie_anio

INTEGER ie_titular  


INTEGER ie_modo_opera
INTEGER ie_modo 

end variables
event constructor;ids_horario = CREATE DATASTORE 
ids_profesor = CREATE DATASTORE 
ids_sesiones = CREATE DATASTORE 

ids_horario_profesor = CREATE DATASTORE 
ids_grupo_sesion = CREATE DATASTORE 




end event

on uo_grupo_paso.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_grupo_paso.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

