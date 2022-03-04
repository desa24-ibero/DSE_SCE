$PBExportHeader$w_reporte_baja_laboratorio.srw
forward
global type w_reporte_baja_laboratorio from w_master
end type
type rb_materias from radiobutton within w_reporte_baja_laboratorio
end type
type rb_alumnos from radiobutton within w_reporte_baja_laboratorio
end type
type dw_1 from uo_dw_reporte within w_reporte_baja_laboratorio
end type
type gb_1 from groupbox within w_reporte_baja_laboratorio
end type
end forward

global type w_reporte_baja_laboratorio from w_master
integer width = 3250
integer height = 1660
string menuname = "m_menu"
rb_materias rb_materias
rb_alumnos rb_alumnos
dw_1 dw_1
gb_1 gb_1
end type
global w_reporte_baja_laboratorio w_reporte_baja_laboratorio

event open;call super::open;dw_1.SetTransObject(gtr_sce)
x=1
y=1

end event

on w_reporte_baja_laboratorio.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.rb_materias=create rb_materias
this.rb_alumnos=create rb_alumnos
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_materias
this.Control[iCurrent+2]=this.rb_alumnos
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_reporte_baja_laboratorio.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_materias)
destroy(this.rb_alumnos)
destroy(this.dw_1)
destroy(this.gb_1)
end on

type rb_materias from radiobutton within w_reporte_baja_laboratorio
integer x = 2112
integer y = 172
integer width = 997
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Materias de Alumnos Bloqueados"
end type

event clicked;dw_1.dataobject="d_alumnos_materia_baja_laboratorio"
dw_1.SetTransObject(gtr_sce)
end event

type rb_alumnos from radiobutton within w_reporte_baja_laboratorio
integer x = 2112
integer y = 88
integer width = 663
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Alumnos Bloqueados"
boolean checked = true
end type

event clicked;dw_1.dataobject="d_alumnos_baja_laboratorio"
dw_1.SetTransObject(gtr_sce)
end event

type dw_1 from uo_dw_reporte within w_reporte_baja_laboratorio
integer x = 59
integer y = 316
integer width = 3099
integer height = 1120
integer taborder = 10
string dataobject = "d_alumnos_baja_laboratorio"
boolean hscrollbar = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;call super::retrieveend;datetime ldttm_fecha_servidor
string  ls_fecha_servidor

ldttm_fecha_servidor = fecha_servidor(gtr_sce)
ls_fecha_servidor = string(ldttm_fecha_servidor,"dd/mm/yyyy hh:mm")

this.object.t_fecha_servidor.text=ls_fecha_servidor
end event

event carga;event primero()
return retrieve(gs_tipo_periodo) 

end event

type gb_1 from groupbox within w_reporte_baja_laboratorio
integer x = 2071
integer y = 16
integer width = 1083
integer height = 276
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Reporte"
end type

