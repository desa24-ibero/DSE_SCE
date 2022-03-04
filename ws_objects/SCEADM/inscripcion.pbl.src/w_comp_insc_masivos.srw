$PBExportHeader$w_comp_insc_masivos.srw
forward
global type w_comp_insc_masivos from Window
end type
type em_cuenta_max from editmask within w_comp_insc_masivos
end type
type em_cuenta_min from editmask within w_comp_insc_masivos
end type
type dw_1 from uo_dw_reporte within w_comp_insc_masivos
end type
type uo_1 from uo_ver_per_ani within w_comp_insc_masivos
end type
end forward

global type w_comp_insc_masivos from Window
int X=833
int Y=361
int Width=3557
int Height=2089
boolean TitleBar=true
string Title="Emisión de Comprobantes de Inscripción Masivos"
string MenuName="m_menu"
long BackColor=30976088
em_cuenta_max em_cuenta_max
em_cuenta_min em_cuenta_min
dw_1 dw_1
uo_1 uo_1
end type
global w_comp_insc_masivos w_comp_insc_masivos

type variables
int esc_file
end variables

on w_comp_insc_masivos.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.em_cuenta_max=create em_cuenta_max
this.em_cuenta_min=create em_cuenta_min
this.dw_1=create dw_1
this.uo_1=create uo_1
this.Control[]={ this.em_cuenta_max,&
this.em_cuenta_min,&
this.dw_1,&
this.uo_1}
end on

on w_comp_insc_masivos.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_cuenta_max)
destroy(this.em_cuenta_min)
destroy(this.dw_1)
destroy(this.uo_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sce)
end event

type em_cuenta_max from editmask within w_comp_insc_masivos
event constructor pbm_constructor
event rbuttondown pbm_rbuttondown
int X=2798
int Y=61
int Width=330
int Height=101
int TabOrder=1
Alignment Alignment=Center!
string Mask="######"
string DisplayData="˜<pbedit050"
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;text="0"
end event

event rbuttondown;text="0"
end event

type em_cuenta_min from editmask within w_comp_insc_masivos
int X=2428
int Y=61
int Width=330
int Height=101
int TabOrder=11
Alignment Alignment=Center!
string Mask="######"
string DisplayData="˜<pbedit050"
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;text="0"
end event

event rbuttondown;text="0"
end event

type dw_1 from uo_dw_reporte within w_comp_insc_masivos
int X=14
int Y=209
int Width=3507
int Height=1681
int TabOrder=0
string DataObject="dw_comp_insc_masivos"
end type

event carga;return retrieve(gi_periodo,gi_anio,long(em_cuenta_min.text),long(em_cuenta_max.text))
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event retrieveend;call super::retrieveend;messagebox("",string(rowcount))
end event

type uo_1 from uo_ver_per_ani within w_comp_insc_masivos
int X=33
int Y=29
int Width=1244
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

