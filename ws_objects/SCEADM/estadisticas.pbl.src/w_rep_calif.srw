$PBExportHeader$w_rep_calif.srw
forward
global type w_rep_calif from Window
end type
type uo_tipo_periodo_ing from uo_tipo_periodo within w_rep_calif
end type
type uo_1 from uo_ver_per_ani within w_rep_calif
end type
type dw_1 from uo_dw_reporte within w_rep_calif
end type
end forward

global type w_rep_calif from Window
int X=834
int Y=362
int Width=3558
int Height=1965
boolean TitleBar=true
string Title="Reporte de Calificaciones"
string MenuName="m_menu"
long BackColor=30976088
uo_tipo_periodo_ing uo_tipo_periodo_ing
uo_1 uo_1
dw_1 dw_1
end type
global w_rep_calif w_rep_calif

on w_rep_calif.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_tipo_periodo_ing=create uo_tipo_periodo_ing
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.uo_tipo_periodo_ing,&
this.uo_1,&
this.dw_1}
end on

on w_rep_calif.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_tipo_periodo_ing)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type uo_tipo_periodo_ing from uo_tipo_periodo within w_rep_calif
int X=2297
int Y=32
int TabOrder=10
end type

on uo_tipo_periodo_ing.destroy
call uo_tipo_periodo::destroy
end on

type uo_1 from uo_ver_per_ani within w_rep_calif
int X=11
int Y=16
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_rep_calif
int X=4
int Y=198
int Width=3522
int Height=1581
int TabOrder=0
string DataObject="dw_rep_calif"
boolean HScrollBar=true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;long ll_rows
IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	this.dataobject = "dw_rep_calif"
	this.SetTransObject(gtr_sadm)
ELSE
	this.dataobject = "dw_rep_calif_ing"
	this.SetTransObject(gtr_sadm)	
END IF

ll_rows = this.retrieve(gi_version, gi_periodo, gi_anio)

return ll_rows
end event

