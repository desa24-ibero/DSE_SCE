$PBExportHeader$uo_coordinador.sru
forward
global type uo_coordinador from uo_clave_texto
end type
end forward

global type uo_coordinador from uo_clave_texto
long backcolor = 80269524
end type
global uo_coordinador uo_coordinador

on uo_coordinador.create
call super::create
end on

on uo_coordinador.destroy
call super::destroy
end on

type dw_1 from uo_clave_texto`dw_1 within uo_coordinador
string dataobject = "duo_coordinador"
end type

