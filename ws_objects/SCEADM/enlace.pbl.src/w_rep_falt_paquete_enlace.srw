$PBExportHeader$w_rep_falt_paquete_enlace.srw
forward
global type w_rep_falt_paquete_enlace from Window
end type
type uo_1 from uo_ver_per_ani within w_rep_falt_paquete_enlace
end type
type dw_1 from uo_dw_captura within w_rep_falt_paquete_enlace
end type
end forward

global type w_rep_falt_paquete_enlace from Window
int X=834
int Y=362
int Width=3672
int Height=1958
boolean TitleBar=true
string Title="Reporte de Faltantes de Paquete previos al Enlace"
string MenuName="m_menu"
long BackColor=30976088
uo_1 uo_1
dw_1 dw_1
end type
global w_rep_falt_paquete_enlace w_rep_falt_paquete_enlace

type variables
int ord
end variables

on w_rep_falt_paquete_enlace.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.uo_1,&
this.dw_1}
end on

on w_rep_falt_paquete_enlace.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type uo_1 from uo_ver_per_ani within w_rep_falt_paquete_enlace
int X=0
int Y=16
int Width=2308
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_captura within w_rep_falt_paquete_enlace
int X=22
int Y=202
int Width=3606
int Height=1558
int TabOrder=0
string DataObject="dw_aspi-alum_sce_ing_sin_paq"
end type

event carga;/*Antes de cargar algo, ve si hay modificaciones no guardadas*/
event primero()
return retrieve(gi_version,gi_periodo, gi_anio)
end event

event actualiza;/**/
return 0
end event

event borra;/**/
end event

event nuevo;/**/
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

