$PBExportHeader$uo_datastore.sru
forward
global type uo_datastore from datastore
end type
end forward

global type uo_datastore from datastore
end type
global uo_datastore uo_datastore

type variables
string ds_sqlerrtext
end variables

on uo_datastore.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_datastore.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event dberror;//Muestra el error ocurrido
MessageBox("Error en datastore",sqlerrtext+"~n"+sqlsyntax,StopSign!)
ds_sqlerrtext = sqlerrtext
return 0
end event

