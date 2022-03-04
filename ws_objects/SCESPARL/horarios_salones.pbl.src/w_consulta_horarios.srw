$PBExportHeader$w_consulta_horarios.srw
forward
global type w_consulta_horarios from window
end type
type st_2 from statictext within w_consulta_horarios
end type
type st_1 from statictext within w_consulta_horarios
end type
end forward

global type w_consulta_horarios from window
integer width = 3593
integer height = 1816
windowtype windowtype = child!
st_2 st_2
st_1 st_1
end type
global w_consulta_horarios w_consulta_horarios

on w_consulta_horarios.create
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={this.st_2,&
this.st_1}
end on

on w_consulta_horarios.destroy
destroy(this.st_2)
destroy(this.st_1)
end on

type st_2 from statictext within w_consulta_horarios
integer x = 855
integer y = 68
integer width = 1394
integer height = 172
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Horarios"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_consulta_horarios
end type

on st_1.create
end on

on st_1.destroy
end on

