$PBExportHeader$uo_carreras_alumno.sru
$PBExportComments$Objeto que busca al alumno por No. de Cta., por nombre o por apellidos, o efectuando una revisión en la tabla de alumnos
forward
global type uo_carreras_alumno from uo_master_dw
end type
end forward

global type uo_carreras_alumno from uo_master_dw
integer width = 3077
integer height = 260
string dataobject = "dw_carreras_cursadas"
end type
global uo_carreras_alumno uo_carreras_alumno

type variables
//window iw_ventana
end variables

on uo_carreras_alumno.create
call super::create
end on

on uo_carreras_alumno.destroy
call super::destroy
end on

event clicked;call super::clicked;if row = 0 then return

this.selectrow(0,false)
this.selectrow(row,true)
end event

event constructor;call super::constructor;this.settransobject(gtr_sce)
this.insertrow(0)

end event

event doubleclicked;call super::doubleclicked;if row = 0 then return
end event

