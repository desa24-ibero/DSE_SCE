$PBExportHeader$w_relacion_alumnos_posgrado.srw
forward
global type w_relacion_alumnos_posgrado from w_main
end type
type rb_2 from radiobutton within w_relacion_alumnos_posgrado
end type
type rb_1 from radiobutton within w_relacion_alumnos_posgrado
end type
type cb_cargar from u_cb within w_relacion_alumnos_posgrado
end type
type dw_1 from uo_dw_reporte within w_relacion_alumnos_posgrado
end type
type st_2 from statictext within w_relacion_alumnos_posgrado
end type
type st_1 from statictext within w_relacion_alumnos_posgrado
end type
type em_fecha_final from u_em within w_relacion_alumnos_posgrado
end type
type em_fecha_inicial from u_em within w_relacion_alumnos_posgrado
end type
type gb_relacion from groupbox within w_relacion_alumnos_posgrado
end type
end forward

global type w_relacion_alumnos_posgrado from w_main
integer width = 3104
integer height = 1784
string title = "Relación de Alumnos de Posgrado"
string menuname = "m_menu"
rb_2 rb_2
rb_1 rb_1
cb_cargar cb_cargar
dw_1 dw_1
st_2 st_2
st_1 st_1
em_fecha_final em_fecha_final
em_fecha_inicial em_fecha_inicial
gb_relacion gb_relacion
end type
global w_relacion_alumnos_posgrado w_relacion_alumnos_posgrado

on w_relacion_alumnos_posgrado.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_cargar=create cb_cargar
this.dw_1=create dw_1
this.st_2=create st_2
this.st_1=create st_1
this.em_fecha_final=create em_fecha_final
this.em_fecha_inicial=create em_fecha_inicial
this.gb_relacion=create gb_relacion
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_2
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.cb_cargar
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.em_fecha_final
this.Control[iCurrent+8]=this.em_fecha_inicial
this.Control[iCurrent+9]=this.gb_relacion
end on

on w_relacion_alumnos_posgrado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_cargar)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_fecha_final)
destroy(this.em_fecha_inicial)
destroy(this.gb_relacion)
end on

event open;call super::open;x=1
y=1
end event

type rb_2 from radiobutton within w_relacion_alumnos_posgrado
integer x = 1431
integer y = 96
integer width = 635
integer height = 64
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Exámenes Aprobados"
boolean checked = true
boolean lefttext = true
borderstyle borderstyle = stylelowered!
end type

event clicked;dw_1.dataobject = "d_relacion_alumnos_aprob_pos"
dw_1.SetTransObject(gtr_sce)
dw_1.modify("Datawindow.print.preview = Yes")
end event

type rb_1 from radiobutton within w_relacion_alumnos_posgrado
integer x = 1431
integer y = 192
integer width = 635
integer height = 64
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Exámenes Programados"
boolean lefttext = true
borderstyle borderstyle = stylelowered!
end type

event clicked;dw_1.dataobject = "d_relacion_alumnos_prog_pos"
dw_1.SetTransObject(gtr_sce)
dw_1.modify("Datawindow.print.preview = Yes")
end event

type cb_cargar from u_cb within w_relacion_alumnos_posgrado
integer x = 2546
integer y = 116
integer taborder = 50
string text = "Cargar"
end type

event clicked;call super::clicked;dw_1.Triggerevent("carga")

end event

type dw_1 from uo_dw_reporte within w_relacion_alumnos_posgrado
integer x = 101
integer y = 364
integer width = 2862
integer height = 1136
integer taborder = 60
string dataobject = "d_relacion_alumnos_aprob_pos"
boolean hscrollbar = true
boolean resizable = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio=gtr_sce
this.SetTransObject(tr_dw_propio)
end event

event carga;string ls_fecha_inicial, ls_fecha_final
date ldt_fecha_inicial, ldt_fecha_final
datetime ldttm_fecha_inicial, ldttm_fecha_final
integer li_num_registros, li_cve_constancia, li_cve_estatus_solicitud
long ll_row_estatus_solicitud
long ll_area_coordinacion, ll_responsable
string ls_area_coordinacion, ls_estatus_solicitud

if isnull(dw_1.DataObject) then
	return 0
end if

ls_fecha_inicial= em_fecha_inicial.text
ls_fecha_final= em_fecha_final.text

ldt_fecha_inicial =date(ls_fecha_inicial)
ldt_fecha_final =date(ls_fecha_final)

if ldt_fecha_final < ldt_fecha_inicial then
	MessageBox("Error de fechas","La fecha inicial no debe ser mayor a la fecha final")
end if 



ldt_fecha_final= RelativeDate(ldt_fecha_final, +1)

ldttm_fecha_inicial =datetime(ldt_fecha_inicial)
ldttm_fecha_final =datetime(ldt_fecha_final)

li_num_registros= dw_1.retrieve(ldttm_fecha_inicial, ldttm_fecha_final)

return li_num_registros



end event

type st_2 from statictext within w_relacion_alumnos_posgrado
integer x = 174
integer y = 200
integer width = 311
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha Final:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_relacion_alumnos_posgrado
integer x = 174
integer y = 84
integer width = 311
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha Inicial:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fecha_final from u_em within w_relacion_alumnos_posgrado
integer x = 613
integer y = 184
integer width = 343
integer height = 84
integer taborder = 20
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type em_fecha_inicial from u_em within w_relacion_alumnos_posgrado
integer x = 613
integer y = 68
integer width = 343
integer height = 84
integer taborder = 10
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type gb_relacion from groupbox within w_relacion_alumnos_posgrado
integer x = 1385
integer y = 32
integer width = 731
integer height = 260
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo de Relación"
borderstyle borderstyle = stylelowered!
end type

