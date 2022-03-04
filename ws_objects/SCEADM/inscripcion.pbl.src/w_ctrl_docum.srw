$PBExportHeader$w_ctrl_docum.srw
$PBExportComments$Reporte de Control de Documentos para Archivo.
forward
global type w_ctrl_docum from Window
end type
type uo_tipo_periodo_ing from uo_tipo_periodo within w_ctrl_docum
end type
type uo_1 from uo_ver_per_ani within w_ctrl_docum
end type
type dw_1 from uo_dw_reporte within w_ctrl_docum
end type
end forward

global type w_ctrl_docum from Window
int X=834
int Y=362
int Width=3683
int Height=1965
boolean TitleBar=true
string Title="Reporte para Archivo"
string MenuName="m_menu"
long BackColor=30976088
uo_tipo_periodo_ing uo_tipo_periodo_ing
uo_1 uo_1
dw_1 dw_1
end type
global w_ctrl_docum w_ctrl_docum

on w_ctrl_docum.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_tipo_periodo_ing=create uo_tipo_periodo_ing
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.uo_tipo_periodo_ing,&
this.uo_1,&
this.dw_1}
end on

on w_ctrl_docum.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_tipo_periodo_ing)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type uo_tipo_periodo_ing from uo_tipo_periodo within w_ctrl_docum
int X=1247
int Y=29
int TabOrder=10
end type

on uo_tipo_periodo_ing.destroy
call uo_tipo_periodo::destroy
end on

type uo_1 from uo_ver_per_ani within w_ctrl_docum
int X=4
int Y=13
int Width=1243
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_ctrl_docum
int X=37
int Y=189
int Width=3606
int Height=1584
int TabOrder=0
string DataObject="dw_ctrl_docum"
boolean HScrollBar=true
end type

event carga;IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	this.dataobject = "dw_ctrl_docum"
	this.SetTransObject(gtr_sadm)
ELSE
	this.dataobject = "dw_ctrl_docum_ing"
	this.SetTransObject(gtr_sadm)	
END IF
event primero()
return retrieve(gi_periodo,gi_anio)
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

