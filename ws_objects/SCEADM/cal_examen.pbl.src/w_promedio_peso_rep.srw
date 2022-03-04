$PBExportHeader$w_promedio_peso_rep.srw
$PBExportComments$Reporte de pesos (secciones y áreas)
forward
global type w_promedio_peso_rep from window
end type
type dw_1 from uo_dw_reporte within w_promedio_peso_rep
end type
end forward

global type w_promedio_peso_rep from window
integer x = 23
integer y = 12
integer width = 3593
integer height = 1960
boolean titlebar = true
string title = "Reporte de Pesos de Exámenes"
string menuname = "m_menu"
dw_1 dw_1
end type
global w_promedio_peso_rep w_promedio_peso_rep

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
dw_1.retrieve()
end event

on w_promedio_peso_rep.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_promedio_peso_rep.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
end on

type dw_1 from uo_dw_reporte within w_promedio_peso_rep
integer x = 0
integer y = 4
integer width = 3515
integer height = 1740
integer taborder = 3
string dataobject = "dw_promedio_peso_rep"
end type

event constructor;call super::constructor;DataWindowChild car
getchild("sec_peso_clv_carr",car)
car.settransobject(gtr_sce)
car.retrieve()

end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

