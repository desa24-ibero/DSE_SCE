$PBExportHeader$udo_tipo_nomina.sru
forward
global type udo_tipo_nomina from uo_clave_texto
end type
end forward

global type udo_tipo_nomina from uo_clave_texto
integer width = 578
integer height = 96
long backcolor = 12632256
end type
global udo_tipo_nomina udo_tipo_nomina

on udo_tipo_nomina.create
call super::create
end on

on udo_tipo_nomina.destroy
call super::destroy
end on

type dw_1 from uo_clave_texto`dw_1 within udo_tipo_nomina
integer width = 571
string dataobject = "udw_tipo_nomina"
end type

