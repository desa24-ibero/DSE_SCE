$PBExportHeader$uo_estado_titulo.sru
forward
global type uo_estado_titulo from uo_clave_texto
end type
end forward

global type uo_estado_titulo from uo_clave_texto
integer width = 1269
integer height = 128
end type
global uo_estado_titulo uo_estado_titulo

on uo_estado_titulo.create
call super::create
end on

on uo_estado_titulo.destroy
call super::destroy
end on

type dw_1 from uo_clave_texto`dw_1 within uo_estado_titulo
integer y = 10
integer width = 1218
string dataobject = "duo_estado_titulo"
end type

