$PBExportHeader$w_status_mat_preinsc_total.srw
forward
global type w_status_mat_preinsc_total from w_ancestral
end type
type dw_1 from uo_dw_reporte within w_status_mat_preinsc_total
end type
end forward

global type w_status_mat_preinsc_total from w_ancestral
integer width = 3584
integer height = 1748
string title = "Reporte de Total de las Materias Preinscritas"
string menuname = "m_menu"
dw_1 dw_1
end type
global w_status_mat_preinsc_total w_status_mat_preinsc_total

on w_status_mat_preinsc_total.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_status_mat_preinsc_total.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
end on

event open;call super::open;

uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios 
luo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, "L", gtr_sce) 

luo_periodo_servicios.f_modifica_decodificacion( dw_1, "compute_1", "L", "mat_preinsc_periodo") 





end event

type p_uia from w_ancestral`p_uia within w_status_mat_preinsc_total
end type

type dw_1 from uo_dw_reporte within w_status_mat_preinsc_total
integer x = 151
integer y = 468
integer width = 3278
integer height = 1036
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_status_mat_preinsc_total"
boolean hscrollbar = true
boolean resizable = true
boolean border = true
end type

event constructor;call super::constructor;this.SetTransObject(gtr_sce)
end event

event retrieveend;call super::retrieveend;datetime ldttm_fecha
string ls_fecha

if rowcount>0 then
	ldttm_fecha = fecha_servidor(gtr_sce)
	ls_fecha = string(ldttm_fecha, "dd/mm/yyyy hh:mm")

	this.object.t_fecha.text =ls_fecha 
end if
end event

event carga;
event primero()
return retrieve(gs_tipo_periodo) 




end event

