$PBExportHeader$w_datos_globales_cen.srw
forward
global type w_datos_globales_cen from Window
end type
type uo_tipo_periodo_ing from uo_tipo_periodo within w_datos_globales_cen
end type
type uo_1 from uo_ver_per_ani within w_datos_globales_cen
end type
type dw_1 from uo_dw_reporte within w_datos_globales_cen
end type
end forward

global type w_datos_globales_cen from Window
int X=834
int Y=362
int Width=3694
int Height=1965
boolean TitleBar=true
string Title="Datos Globales de Aspirantes"
string MenuName="m_menu"
long BackColor=30976088
uo_tipo_periodo_ing uo_tipo_periodo_ing
uo_1 uo_1
dw_1 dw_1
end type
global w_datos_globales_cen w_datos_globales_cen

type variables

end variables

on w_datos_globales_cen.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_tipo_periodo_ing=create uo_tipo_periodo_ing
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.uo_tipo_periodo_ing,&
this.uo_1,&
this.dw_1}
end on

on w_datos_globales_cen.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_tipo_periodo_ing)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type uo_tipo_periodo_ing from uo_tipo_periodo within w_datos_globales_cen
int X=2289
int Y=22
int TabOrder=10
end type

on uo_tipo_periodo_ing.destroy
call uo_tipo_periodo::destroy
end on

type uo_1 from uo_ver_per_ani within w_datos_globales_cen
int X=4
int Y=6
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_datos_globales_cen
int X=0
int Y=182
int Width=3639
int Height=1552
int TabOrder=0
string DataObject="dw_datos_globales_cen"
boolean HScrollBar=true
end type

event carga;IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	this.dataobject = "dw_datos_globales_cen"
	this.SetTransObject(gtr_sadm)
ELSE
	this.dataobject = "dw_datos_globales_cen_ing"
	this.SetTransObject(gtr_sadm)	
END IF
event primero()
return retrieve(gi_version,gi_periodo,gi_anio)
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

