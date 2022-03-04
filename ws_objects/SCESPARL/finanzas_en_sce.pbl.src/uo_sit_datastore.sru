$PBExportHeader$uo_sit_datastore.sru
$PBExportComments$Usar este objeto para declarar un data stored ejemplo
forward
global type uo_sit_datastore from datastore
end type
end forward

global type uo_sit_datastore from datastore
end type
global uo_sit_datastore uo_sit_datastore

type variables
public string ds_sqlerrtext
public integer ds_sqlcode
end variables

event dberror;ds_sqlerrtext = sqlerrtext
ds_sqlcode = sqldbcode
end event

on uo_sit_datastore.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_sit_datastore.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

