$PBExportHeader$w_estadistica_status_carrera.srw
forward
global type w_estadistica_status_carrera from window
end type
type st_1 from statictext within w_estadistica_status_carrera
end type
type uo_lb_estatus_examen from uo_list_box_multiple within w_estadistica_status_carrera
end type
type uo_tipo_periodo_ing from uo_tipo_periodo within w_estadistica_status_carrera
end type
type uo_sel_carrera from uo_carrera within w_estadistica_status_carrera
end type
type dw_status_seleccion from datawindow within w_estadistica_status_carrera
end type
type cb_buscar from commandbutton within w_estadistica_status_carrera
end type
type uo_1 from uo_ver_per_ani within w_estadistica_status_carrera
end type
type dw_1 from uo_dw_reporte within w_estadistica_status_carrera
end type
end forward

global type w_estadistica_status_carrera from window
integer x = 834
integer y = 362
integer width = 3694
integer height = 1965
boolean titlebar = true
string title = "Estadística de Status de Aspirantes"
string menuname = "m_menu"
long backcolor = 30976088
st_1 st_1
uo_lb_estatus_examen uo_lb_estatus_examen
uo_tipo_periodo_ing uo_tipo_periodo_ing
uo_sel_carrera uo_sel_carrera
dw_status_seleccion dw_status_seleccion
cb_buscar cb_buscar
uo_1 uo_1
dw_1 dw_1
end type
global w_estadistica_status_carrera w_estadistica_status_carrera

on w_estadistica_status_carrera.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.st_1=create st_1
this.uo_lb_estatus_examen=create uo_lb_estatus_examen
this.uo_tipo_periodo_ing=create uo_tipo_periodo_ing
this.uo_sel_carrera=create uo_sel_carrera
this.dw_status_seleccion=create dw_status_seleccion
this.cb_buscar=create cb_buscar
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.uo_lb_estatus_examen,&
this.uo_tipo_periodo_ing,&
this.uo_sel_carrera,&
this.dw_status_seleccion,&
this.cb_buscar,&
this.uo_1,&
this.dw_1}
end on

on w_estadistica_status_carrera.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.uo_lb_estatus_examen)
destroy(this.uo_tipo_periodo_ing)
destroy(this.uo_sel_carrera)
destroy(this.dw_status_seleccion)
destroy(this.cb_buscar)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;long ll_default[]
x=1
y=1




ll_default[1]=2
uo_lb_estatus_examen.event ue_genera_lista("ddlb_status_examen",ll_default,gtr_sadm)

dw_1.settransobject(gtr_sadm)
end event

type st_1 from statictext within w_estadistica_status_carrera
integer x = 80
integer y = 256
integer width = 282
integer height = 61
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29534863
string text = "Status"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_lb_estatus_examen from uo_list_box_multiple within w_estadistica_status_carrera
integer x = 479
integer y = 237
integer width = 691
integer height = 307
integer taborder = 20
boolean border = false
end type

on uo_lb_estatus_examen.destroy
call uo_list_box_multiple::destroy
end on

type uo_tipo_periodo_ing from uo_tipo_periodo within w_estadistica_status_carrera
integer x = 2308
integer y = 38
integer taborder = 10
end type

on uo_tipo_periodo_ing.destroy
call uo_tipo_periodo::destroy
end on

type uo_sel_carrera from uo_carrera within w_estadistica_status_carrera
integer x = 2326
integer y = 189
integer width = 1346
integer taborder = 30
boolean enabled = true
long backcolor = 1090519039
end type

on uo_sel_carrera.destroy
call uo_carrera::destroy
end on

type dw_status_seleccion from datawindow within w_estadistica_status_carrera
boolean visible = false
integer x = 2878
integer width = 494
integer height = 381
integer taborder = 20
string dataobject = "dw_status_seleccion"
boolean livescroll = true
end type

type cb_buscar from commandbutton within w_estadistica_status_carrera
integer x = 1898
integer y = 240
integer width = 307
integer height = 106
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Buscar"
end type

event clicked;dw_1.event carga()
end event

type uo_1 from uo_ver_per_ani within w_estadistica_status_carrera
integer x = 18
integer y = 22
integer height = 166
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_estadistica_status_carrera
integer x = 22
integer y = 586
integer width = 3566
integer height = 1133
integer taborder = 0
string dataobject = "dw_estadistica_status_carrera"
boolean hscrollbar = true
boolean border = true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event type integer carga();/**/
integer array_li_status[ ], li_carrera, li_version
long ll_tamanio,  ll_siguiente
long   ll_cve_estatus_examen[], ll_num_registros
datetime ldttm_fecha_servidor
string ls_fecha_servidor


ldttm_fecha_servidor= fecha_servidor(gtr_sce)

IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	this.dataobject = "dw_estadistica_status_carrera"
	this.SetTransObject(gtr_sadm)
	li_version = gi_version
ELSE
	this.dataobject = "dw_estadistica_status_car_ing"
	this.SetTransObject(gtr_sadm)	
	li_version = 99
END IF


li_carrera= uo_sel_carrera.dw_carrera.object.cve_carrera[uo_sel_carrera.dw_carrera.getrow()]

uo_lb_estatus_examen.of_obten_lista_seleccionados(ll_cve_estatus_examen)
ll_num_registros=0

if upperbound(ll_cve_estatus_examen)> 0 then
	ll_num_registros= retrieve(li_version, gi_periodo, gi_anio, li_carrera, ll_cve_estatus_examen)
end if

IF ll_num_registros >0 THEN
	ls_fecha_servidor = string(ldttm_fecha_servidor,"dd/mm/yyyy hh:mm")
	this.object.fecha_servidor.text = ls_fecha_servidor
END IF

return ll_num_registros


end event

