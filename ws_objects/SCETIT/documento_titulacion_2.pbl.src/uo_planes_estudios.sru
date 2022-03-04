$PBExportHeader$uo_planes_estudios.sru
forward
global type uo_planes_estudios from uo_clave_texto
end type
end forward

global type uo_planes_estudios from uo_clave_texto
integer width = 2454
end type
global uo_planes_estudios uo_planes_estudios

on uo_planes_estudios.create
call super::create
end on

on uo_planes_estudios.destroy
call super::destroy
end on

type dw_1 from uo_clave_texto`dw_1 within uo_planes_estudios
integer width = 2406
string dataobject = "duo_planes"
end type

