$PBExportHeader$w_hoja_res_salon.srw
forward
global type w_hoja_res_salon from Window
end type
type em_folios from editmask within w_hoja_res_salon
end type
type em_salon from editmask within w_hoja_res_salon
end type
type uo_1 from uo_ver_per_ani within w_hoja_res_salon
end type
type dw_1 from uo_dw_reporte within w_hoja_res_salon
end type
end forward

global type w_hoja_res_salon from Window
int X=833
int Y=361
int Width=3745
int Height=1953
boolean TitleBar=true
string Title="Hojas de Respuestas por Salones"
string MenuName="m_menu"
long BackColor=30976088
em_folios em_folios
em_salon em_salon
uo_1 uo_1
dw_1 dw_1
end type
global w_hoja_res_salon w_hoja_res_salon

on w_hoja_res_salon.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.em_folios=create em_folios
this.em_salon=create em_salon
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={ this.em_folios,&
this.em_salon,&
this.uo_1,&
this.dw_1}
end on

on w_hoja_res_salon.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_folios)
destroy(this.em_salon)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type em_folios from editmask within w_hoja_res_salon
int X=2689
int Y=61
int Width=247
int Height=101
int TabOrder=10
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="###"
string DisplayData=""
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_salon from editmask within w_hoja_res_salon
int X=2378
int Y=61
int Width=247
int Height=101
int TabOrder=20
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="!###"
MaskDataType MaskDataType=StringMask!
string DisplayData=""
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_1 from uo_ver_per_ani within w_hoja_res_salon
int X=28
int Y=25
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_hoja_res_salon
int X=19
int Y=193
int Width=3690
int Height=1569
int TabOrder=0
string DataObject="dw_hoja_res_salon"
end type

event constructor;call super::constructor;DataWindowChild carr
getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()
end event

event carga;event primero()
return retrieve(gi_version,gi_periodo,gi_anio,em_salon.text)
end event

event retrieveend;call super::retrieveend;em_folios.text=string(rowcount)
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

