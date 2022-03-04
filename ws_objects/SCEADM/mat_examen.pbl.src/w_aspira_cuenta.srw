$PBExportHeader$w_aspira_cuenta.srw
$PBExportComments$Ventana con los aspirantes que tienen cuenta
forward
global type w_aspira_cuenta from Window
end type
type uo_tipo_periodo_ing from uo_tipo_periodo within w_aspira_cuenta
end type
type uo_1 from uo_ver_per_ani within w_aspira_cuenta
end type
type dw_1 from uo_dw_reporte within w_aspira_cuenta
end type
end forward

global type w_aspira_cuenta from Window
int X=834
int Y=362
int Width=3507
int Height=1952
boolean TitleBar=true
string Title="Reporte de Aspirantes con Cuenta"
string MenuName="m_menu"
long BackColor=30976088
uo_tipo_periodo_ing uo_tipo_periodo_ing
uo_1 uo_1
dw_1 dw_1
end type
global w_aspira_cuenta w_aspira_cuenta

on w_aspira_cuenta.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_tipo_periodo_ing=create uo_tipo_periodo_ing
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.uo_tipo_periodo_ing,&
this.uo_1,&
this.dw_1}
end on

on w_aspira_cuenta.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_tipo_periodo_ing)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type uo_tipo_periodo_ing from uo_tipo_periodo within w_aspira_cuenta
int X=2359
int Y=38
int TabOrder=10
end type

on uo_tipo_periodo_ing.destroy
call uo_tipo_periodo::destroy
end on

type uo_1 from uo_ver_per_ani within w_aspira_cuenta
int X=73
int Y=22
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_aspira_cuenta
int X=15
int Y=192
int Width=3456
int Height=1574
int TabOrder=0
string DataObject="dw_aspira_cuenta"
end type

event carga;IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	this.dataobject = "dw_aspira_cuenta"
	this.SetTransObject(gtr_sadm)
ELSE
	this.dataobject = "dw_aspira_cuenta_ing"
	this.SetTransObject(gtr_sadm)	
END IF

DataWindowChild carr
getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

event primero()
object.st_1.text=tit1
return retrieve(gi_version,gi_periodo,gi_anio)
end event

event constructor;call super::constructor;DataWindowChild carr
getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

