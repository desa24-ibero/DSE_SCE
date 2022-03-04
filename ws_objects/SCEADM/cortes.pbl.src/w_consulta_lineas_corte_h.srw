$PBExportHeader$w_consulta_lineas_corte_h.srw
forward
global type w_consulta_lineas_corte_h from Window
end type
type uo_1 from uo_ver_per_ani within w_consulta_lineas_corte_h
end type
type dw_1 from uo_dw_reporte within w_consulta_lineas_corte_h
end type
end forward

global type w_consulta_lineas_corte_h from Window
int X=833
int Y=361
int Width=3324
int Height=1877
boolean TitleBar=true
string Title="Consulta Histórica de Líneas de Corte"
string MenuName="m_menu"
long BackColor=30976088
uo_1 uo_1
dw_1 dw_1
end type
global w_consulta_lineas_corte_h w_consulta_lineas_corte_h

on w_consulta_lineas_corte_h.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={ this.uo_1,&
this.dw_1}
end on

on w_consulta_lineas_corte_h.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type uo_1 from uo_ver_per_ani within w_consulta_lineas_corte_h
int X=28
int Y=29
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_consulta_lineas_corte_h
int X=23
int Y=217
int Width=3219
int Height=1425
int TabOrder=0
string DataObject="dw_consulta_lineas_corte_h"
boolean HScrollBar=true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;event primero()
return retrieve(gi_version, gi_periodo, gi_anio)

end event

