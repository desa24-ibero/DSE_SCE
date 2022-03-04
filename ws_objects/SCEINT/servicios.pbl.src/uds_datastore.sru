$PBExportHeader$uds_datastore.sru
forward
global type uds_datastore from datastore
end type
end forward

global type uds_datastore from datastore
end type
global uds_datastore uds_datastore

on uds_datastore.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uds_datastore.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event dberror;MessageBox(sqlerrtext,sqlsyntax,StopSign!)
return 1
end event

