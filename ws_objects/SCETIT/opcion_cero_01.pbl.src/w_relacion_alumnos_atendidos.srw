﻿$PBExportHeader$w_relacion_alumnos_atendidos.srw
forward
global type w_relacion_alumnos_atendidos from w_main
end type
type cb_cargar from u_cb within w_relacion_alumnos_atendidos
end type
type dw_1 from uo_dw_reporte within w_relacion_alumnos_atendidos
end type
type st_2 from statictext within w_relacion_alumnos_atendidos
end type
type st_1 from statictext within w_relacion_alumnos_atendidos
end type
type em_fecha_final from u_em within w_relacion_alumnos_atendidos
end type
type em_fecha_inicial from u_em within w_relacion_alumnos_atendidos
end type
end forward

global type w_relacion_alumnos_atendidos from w_main
integer width = 3927
integer height = 1764
string title = "Relación de Alumnos Atendidos"
string menuname = "m_menu"
cb_cargar cb_cargar
dw_1 dw_1
st_2 st_2
st_1 st_1
em_fecha_final em_fecha_final
em_fecha_inicial em_fecha_inicial
end type
global w_relacion_alumnos_atendidos w_relacion_alumnos_atendidos

on w_relacion_alumnos_atendidos.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_cargar=create cb_cargar
this.dw_1=create dw_1
this.st_2=create st_2
this.st_1=create st_1
this.em_fecha_final=create em_fecha_final
this.em_fecha_inicial=create em_fecha_inicial
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cargar
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.em_fecha_final
this.Control[iCurrent+6]=this.em_fecha_inicial
end on

on w_relacion_alumnos_atendidos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_cargar)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_fecha_final)
destroy(this.em_fecha_inicial)
end on

event open;call super::open;x=1
y=1
end event

type cb_cargar from u_cb within w_relacion_alumnos_atendidos
integer x = 3438
integer y = 140
integer taborder = 20
string text = "Cargar"
end type

event clicked;call super::clicked;dw_1.Triggerevent("carga")

end event

type dw_1 from uo_dw_reporte within w_relacion_alumnos_atendidos
integer x = 101
integer y = 312
integer width = 3689
integer height = 1180
integer taborder = 30
string dataobject = "d_relacion_alumnos_atendidos"
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

type st_2 from statictext within w_relacion_alumnos_atendidos
integer x = 110
integer y = 200
integer width = 366
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha Final:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_relacion_alumnos_atendidos
integer x = 110
integer y = 84
integer width = 366
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha Inicial:"
boolean focusrectangle = false
end type

type em_fecha_final from u_em within w_relacion_alumnos_atendidos
integer x = 530
integer y = 184
integer width = 320
integer height = 84
integer taborder = 20
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type em_fecha_inicial from u_em within w_relacion_alumnos_atendidos
integer x = 530
integer y = 68
integer width = 320
integer height = 84
integer taborder = 10
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

