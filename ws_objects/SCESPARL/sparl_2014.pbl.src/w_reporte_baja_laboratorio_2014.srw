$PBExportHeader$w_reporte_baja_laboratorio_2014.srw
forward
global type w_reporte_baja_laboratorio_2014 from w_master
end type
type st_sistema from statictext within w_reporte_baja_laboratorio_2014
end type
type p_ibero from picture within w_reporte_baja_laboratorio_2014
end type
type rb_materias from radiobutton within w_reporte_baja_laboratorio_2014
end type
type rb_alumnos from radiobutton within w_reporte_baja_laboratorio_2014
end type
type dw_1 from uo_dw_reporte within w_reporte_baja_laboratorio_2014
end type
type gb_1 from groupbox within w_reporte_baja_laboratorio_2014
end type
end forward

global type w_reporte_baja_laboratorio_2014 from w_master
integer x = 23
integer y = 36
integer width = 5189
integer height = 3348
string menuname = "m_menu"
long backcolor = 16777215
st_sistema st_sistema
p_ibero p_ibero
rb_materias rb_materias
rb_alumnos rb_alumnos
dw_1 dw_1
gb_1 gb_1
end type
global w_reporte_baja_laboratorio_2014 w_reporte_baja_laboratorio_2014

event open;call super::open;dw_1.SetTransObject(gtr_sce)
x=1
y=1

end event

on w_reporte_baja_laboratorio_2014.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.st_sistema=create st_sistema
this.p_ibero=create p_ibero
this.rb_materias=create rb_materias
this.rb_alumnos=create rb_alumnos
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_sistema
this.Control[iCurrent+2]=this.p_ibero
this.Control[iCurrent+3]=this.rb_materias
this.Control[iCurrent+4]=this.rb_alumnos
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.gb_1
end on

on w_reporte_baja_laboratorio_2014.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_sistema)
destroy(this.p_ibero)
destroy(this.rb_materias)
destroy(this.rb_alumnos)
destroy(this.dw_1)
destroy(this.gb_1)
end on

type st_sistema from statictext within w_reporte_baja_laboratorio_2014
integer x = 800
integer y = 112
integer width = 229
integer height = 100
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 16777215
string text = "DSE"
boolean focusrectangle = false
end type

type p_ibero from picture within w_reporte_baja_laboratorio_2014
integer x = 55
integer y = 28
integer width = 681
integer height = 264
boolean bringtotop = true
string picturename = "logoibero-web.png"
boolean focusrectangle = false
end type

type rb_materias from radiobutton within w_reporte_baja_laboratorio_2014
integer x = 2661
integer y = 172
integer width = 997
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "Materias de Alumnos Bloqueados"
end type

event clicked;dw_1.dataobject="d_alumnos_materia_baja_laboratorio"
dw_1.SetTransObject(gtr_sce)
end event

type rb_alumnos from radiobutton within w_reporte_baja_laboratorio_2014
integer x = 2661
integer y = 88
integer width = 663
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "Alumnos Bloqueados"
boolean checked = true
end type

event clicked;dw_1.dataobject="d_alumnos_baja_laboratorio_2014"
dw_1.SetTransObject(gtr_sce)
end event

type dw_1 from uo_dw_reporte within w_reporte_baja_laboratorio_2014
integer x = 59
integer y = 352
integer width = 3643
integer height = 2144
integer taborder = 10
string dataobject = "d_alumnos_baja_laboratorio_2014"
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

type gb_1 from groupbox within w_reporte_baja_laboratorio_2014
integer x = 2619
integer y = 16
integer width = 1083
integer height = 276
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "Reporte"
end type

