$PBExportHeader$uo_carreras.sru
forward
global type uo_carreras from uo_clave_texto
end type
end forward

global type uo_carreras from uo_clave_texto
integer width = 2454
end type
global uo_carreras uo_carreras

on uo_carreras.create
call super::create
end on

on uo_carreras.destroy
call super::destroy
end on

type dw_1 from uo_clave_texto`dw_1 within uo_carreras
integer width = 2406
string dataobject = "duo_carreras"
end type

