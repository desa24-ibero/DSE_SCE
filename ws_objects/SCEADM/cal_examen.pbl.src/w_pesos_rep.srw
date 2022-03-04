$PBExportHeader$w_pesos_rep.srw
$PBExportComments$Reporte de pesos (secciones y áreas)
forward
global type w_pesos_rep from Window
end type
type dw_1 from uo_dw_reporte within w_pesos_rep
end type
end forward

global type w_pesos_rep from Window
int X=23
int Y=13
int Width=3594
int Height=1961
boolean TitleBar=true
string Title="Reporte de Pesos de Exámenes"
string MenuName="m_menu"
dw_1 dw_1
end type
global w_pesos_rep w_pesos_rep

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
dw_1.retrieve()
end event

on w_pesos_rep.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
this.Control[]={ this.dw_1}
end on

on w_pesos_rep.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
end on

type dw_1 from uo_dw_reporte within w_pesos_rep
int X=1
int Y=5
int Width=3516
int Height=1741
int TabOrder=3
string DataObject="dw_pesos_rep"
end type

event constructor;call super::constructor;DataWindowChild car
getchild("sec_peso_clv_carr",car)
car.settransobject(gtr_sce)
car.retrieve()

end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

