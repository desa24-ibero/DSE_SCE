$PBExportHeader$uo_parametros_corr_titulacion.sru
forward
global type uo_parametros_corr_titulacion from nonvisualobject
end type
end forward

global type uo_parametros_corr_titulacion from nonvisualobject
end type
global uo_parametros_corr_titulacion uo_parametros_corr_titulacion

type variables

DATASTORE ids_paso 


end variables

on uo_parametros_corr_titulacion.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_parametros_corr_titulacion.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

