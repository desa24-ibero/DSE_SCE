$PBExportHeader$udo_tipo_grupo.sru
forward
global type udo_tipo_grupo from uo_clave_texto
end type
end forward

global type udo_tipo_grupo from uo_clave_texto
integer width = 479
long backcolor = 12632256
end type
global udo_tipo_grupo udo_tipo_grupo

on udo_tipo_grupo.create
call super::create
end on

on udo_tipo_grupo.destroy
call super::destroy
end on

type dw_1 from uo_clave_texto`dw_1 within udo_tipo_grupo
integer width = 464
string dataobject = "udw_tipo_grupo"
end type

