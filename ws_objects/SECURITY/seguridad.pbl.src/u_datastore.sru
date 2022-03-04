$PBExportHeader$u_datastore.sru
forward
global type u_datastore from datastore
end type
end forward

global type u_datastore from datastore
end type
global u_datastore u_datastore

on u_datastore.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_datastore.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event dberror;
MessageBox("Titulo",sqlerrtext+"~n*"+sqlsyntax)
return 0
end event

