﻿$PBExportHeader$w_cons_rest.srw
forward
global type w_cons_rest from Window
end type
type uo_1 from uo_ver_per_ani within w_cons_rest
end type
type dw_1 from uo_dw_reporte within w_cons_rest
end type
end forward

global type w_cons_rest from Window
int X=833
int Y=361
int Width=3635
int Height=1965
boolean TitleBar=true
string Title="Resultados del Rest"
string MenuName="m_menu"
long BackColor=30976088
uo_1 uo_1
dw_1 dw_1
end type
global w_cons_rest w_cons_rest

on w_cons_rest.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={ this.uo_1,&
this.dw_1}
end on

on w_cons_rest.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type uo_1 from uo_ver_per_ani within w_cons_rest
int X=28
int Y=25
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_cons_rest
int X=19
int Y=201
int Width=3521
int Height=1581
int TabOrder=0
string DataObject="dw_cons_rest"
boolean HScrollBar=true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;event primero()
return retrieve(gi_version,gi_periodo,gi_anio)
end event
