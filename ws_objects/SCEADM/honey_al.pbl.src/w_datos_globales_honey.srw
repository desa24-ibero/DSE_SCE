$PBExportHeader$w_datos_globales_honey.srw
forward
global type w_datos_globales_honey from Window
end type
type uo_1 from uo_ver_per_ani within w_datos_globales_honey
end type
type dw_1 from uo_dw_reporte within w_datos_globales_honey
end type
end forward

global type w_datos_globales_honey from Window
int X=833
int Y=361
int Width=3694
int Height=1965
boolean TitleBar=true
string Title="Datos Globales de Aspirantes"
string MenuName="m_menu"
long BackColor=30976088
uo_1 uo_1
dw_1 dw_1
end type
global w_datos_globales_honey w_datos_globales_honey

type variables

end variables

on w_datos_globales_honey.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={ this.uo_1,&
this.dw_1}
end on

on w_datos_globales_honey.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type uo_1 from uo_ver_per_ani within w_datos_globales_honey
int X=5
int Y=5
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_datos_globales_honey
int X=1
int Y=181
int Width=3639
int Height=1553
int TabOrder=0
string DataObject="dw_honey_resultados"
boolean HScrollBar=true
end type

event carga;event primero()
return retrieve(gi_version,gi_periodo,gi_anio)
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

