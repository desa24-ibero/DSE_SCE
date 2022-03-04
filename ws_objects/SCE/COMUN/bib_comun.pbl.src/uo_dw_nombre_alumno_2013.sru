$PBExportHeader$uo_dw_nombre_alumno_2013.sru
forward
global type uo_dw_nombre_alumno_2013 from uo_master_dw
end type
end forward

global type uo_dw_nombre_alumno_2013 from uo_master_dw
integer width = 3191
integer height = 200
string dataobject = "dw_nombre_alumno_2013"
boolean hscrollbar = false
boolean vscrollbar = false
boolean livescroll = false
end type
global uo_dw_nombre_alumno_2013 uo_dw_nombre_alumno_2013

on uo_dw_nombre_alumno_2013.create
call super::create
end on

on uo_dw_nombre_alumno_2013.destroy
call super::destroy
end on

