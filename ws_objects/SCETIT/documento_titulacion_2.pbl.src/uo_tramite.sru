$PBExportHeader$uo_tramite.sru
forward
global type uo_tramite from uo_clave_texto
end type
end forward

global type uo_tramite from uo_clave_texto
integer width = 1269
integer height = 128
end type
global uo_tramite uo_tramite

on uo_tramite.create
call super::create
end on

on uo_tramite.destroy
call super::destroy
end on

type dw_1 from uo_clave_texto`dw_1 within uo_tramite
integer y = 10
integer width = 1218
string dataobject = "duo_tramite"
end type

