$PBExportHeader$w_reporte_salones.srw
$PBExportComments$Ventana base para la impresión de un reporte de salones
forward
global type w_reporte_salones from Window
end type
type cb_buscar from commandbutton within w_reporte_salones
end type
type uo_1 from uo_ver_per_ani within w_reporte_salones
end type
type dw_1 from uo_dw_reporte within w_reporte_salones
end type
end forward

global type w_reporte_salones from Window
int X=833
int Y=361
int Width=3507
int Height=1965
boolean TitleBar=true
string Title="Reporte de Salones"
string MenuName="m_menu"
long BackColor=30976088
cb_buscar cb_buscar
uo_1 uo_1
dw_1 dw_1
end type
global w_reporte_salones w_reporte_salones

on w_reporte_salones.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_buscar=create cb_buscar
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={ this.cb_buscar,&
this.uo_1,&
this.dw_1}
end on

on w_reporte_salones.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_buscar)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type cb_buscar from commandbutton within w_reporte_salones
int X=2771
int Y=45
int Width=307
int Height=105
int TabOrder=31
string Text="Buscar"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.retrieve(gi_version,gi_periodo,gi_anio)
end event

type uo_1 from uo_ver_per_ani within w_reporte_salones
int X=1
int Y=21
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_reporte_salones
int X=14
int Y=193
int Width=3457
int Height=1589
int TabOrder=0
string DataObject="dw_reporte_salones"
boolean HScrollBar=true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;/**/

return 0
end event

