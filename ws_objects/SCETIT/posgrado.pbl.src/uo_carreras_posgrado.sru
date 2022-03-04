$PBExportHeader$uo_carreras_posgrado.sru
forward
global type uo_carreras_posgrado from uo_clave_texto
end type
end forward

global type uo_carreras_posgrado from uo_clave_texto
integer width = 2455
integer height = 134
end type
global uo_carreras_posgrado uo_carreras_posgrado

on uo_carreras_posgrado.create
call super::create
end on

on uo_carreras_posgrado.destroy
call super::destroy
end on

type dw_1 from uo_clave_texto`dw_1 within uo_carreras_posgrado
integer width = 2405
string dataobject = "duo_carreras_posgrado"
end type

