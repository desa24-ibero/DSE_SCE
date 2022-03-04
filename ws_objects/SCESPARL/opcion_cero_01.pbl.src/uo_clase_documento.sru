$PBExportHeader$uo_clase_documento.sru
forward
global type uo_clase_documento from uo_clave_texto
end type
end forward

global type uo_clase_documento from uo_clave_texto
integer width = 1269
integer height = 128
long backcolor = 80269524
end type
global uo_clase_documento uo_clase_documento

on uo_clase_documento.create
call super::create
end on

on uo_clase_documento.destroy
call super::destroy
end on

type dw_1 from uo_clave_texto`dw_1 within uo_clase_documento
integer y = 10
integer width = 1218
string dataobject = "duo_clase_documento"
end type

