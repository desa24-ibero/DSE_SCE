$PBExportHeader$w_cuentas_disponibles.srw
forward
global type w_cuentas_disponibles from w_ancestral
end type
type dw_1 from uo_dw_captura within w_cuentas_disponibles
end type
end forward

global type w_cuentas_disponibles from w_ancestral
int Width=1550
int Height=2189
boolean TitleBar=true
string Title="Cuentas disponibles para Posgrado"
string MenuName="m_menu"
dw_1 dw_1
end type
global w_cuentas_disponibles w_cuentas_disponibles

on w_cuentas_disponibles.create
int iCurrent
call w_ancestral::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_1
end on

on w_cuentas_disponibles.destroy
call w_ancestral::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
end on

event open;call super::open;dw_1.settransobject(gtr_sce)
end event

type dw_1 from uo_dw_captura within w_cuentas_disponibles
int X=714
int Y=29
int Width=682
int Height=2025
int TabOrder=1
string DataObject="dw_cuentas_disponibles"
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

