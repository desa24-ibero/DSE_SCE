$PBExportHeader$uo_clase_aula.sru
forward
global type uo_clase_aula from uo_clave_texto
end type
end forward

global type uo_clase_aula from uo_clave_texto
long backcolor = 80269524
end type
global uo_clase_aula uo_clase_aula

on uo_clase_aula.create
call super::create
end on

on uo_clase_aula.destroy
call super::destroy
end on

type dw_1 from uo_clave_texto`dw_1 within uo_clase_aula
integer width = 965
integer height = 86
string dataobject = "d_uo_clase_aula"
end type

