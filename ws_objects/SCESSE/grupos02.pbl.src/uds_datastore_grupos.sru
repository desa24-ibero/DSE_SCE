$PBExportHeader$uds_datastore_grupos.sru
forward
global type uds_datastore_grupos from uds_datastore
end type
end forward

global type uds_datastore_grupos from uds_datastore
end type
global uds_datastore_grupos uds_datastore_grupos

on uds_datastore_grupos.create
call super::create
end on

on uds_datastore_grupos.destroy
call super::destroy
end on

