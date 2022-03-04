$PBExportHeader$w_rep_mov_prof_aux_bajas.srw
forward
global type w_rep_mov_prof_aux_bajas from w_ancestral
end type
type dw_rep_mov_prof from uo_dw_reporte within w_rep_mov_prof_aux_bajas
end type
type em_1 from editmask within w_rep_mov_prof_aux_bajas
end type
type cb_1 from commandbutton within w_rep_mov_prof_aux_bajas
end type
end forward

global type w_rep_mov_prof_aux_bajas from w_ancestral
integer width = 3621
integer height = 1892
string title = "Reporte de Bajas de Movimientos de Profesores"
string menuname = "m_menu"
dw_rep_mov_prof dw_rep_mov_prof
em_1 em_1
cb_1 cb_1
end type
global w_rep_mov_prof_aux_bajas w_rep_mov_prof_aux_bajas

on w_rep_mov_prof_aux_bajas.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_rep_mov_prof=create dw_rep_mov_prof
this.em_1=create em_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_rep_mov_prof
this.Control[iCurrent+2]=this.em_1
this.Control[iCurrent+3]=this.cb_1
end on

on w_rep_mov_prof_aux_bajas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_rep_mov_prof)
destroy(this.em_1)
destroy(this.cb_1)
end on

event open;call super::open;dw_rep_mov_prof.settransobject(gtr_sce)
m_menu.m_registro.m_cargaregistro.enabled = false
end event

type p_uia from w_ancestral`p_uia within w_rep_mov_prof_aux_bajas
end type

type dw_rep_mov_prof from uo_dw_reporte within w_rep_mov_prof_aux_bajas
integer x = 398
integer y = 0
integer width = 3177
integer height = 1680
integer taborder = 0
string dataobject = "d_rep_mov_prof_aux_bajas"
boolean hscrollbar = true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

type em_1 from editmask within w_rep_mov_prof_aux_bajas
integer y = 504
integer width = 379
integer height = 104
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
string displaydata = "~r"
end type

type cb_1 from commandbutton within w_rep_mov_prof_aux_bajas
integer y = 796
integer width = 379
integer height = 108
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carga"
end type

event clicked;dw_rep_mov_prof.retrieve(date(em_1.text))
end event

