$PBExportHeader$w_avance_soli.srw
forward
global type w_avance_soli from Window
end type
type uo_tipo_periodo_ing from uo_tipo_periodo within w_avance_soli
end type
type em_2 from editmask within w_avance_soli
end type
type em_1 from editmask within w_avance_soli
end type
type uo_1 from uo_ver_per_ani within w_avance_soli
end type
type dw_1 from uo_dw_reporte within w_avance_soli
end type
end forward

global type w_avance_soli from Window
int X=834
int Y=362
int Width=3507
int Height=1952
boolean TitleBar=true
string Title="Avance en las Solicitudes"
string MenuName="m_menu"
long BackColor=30976088
uo_tipo_periodo_ing uo_tipo_periodo_ing
em_2 em_2
em_1 em_1
uo_1 uo_1
dw_1 dw_1
end type
global w_avance_soli w_avance_soli

on w_avance_soli.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_tipo_periodo_ing=create uo_tipo_periodo_ing
this.em_2=create em_2
this.em_1=create em_1
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.uo_tipo_periodo_ing,&
this.em_2,&
this.em_1,&
this.uo_1,&
this.dw_1}
end on

on w_avance_soli.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_tipo_periodo_ing)
destroy(this.em_2)
destroy(this.em_1)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type uo_tipo_periodo_ing from uo_tipo_periodo within w_avance_soli
int X=2289
int Y=38
int TabOrder=20
end type

on uo_tipo_periodo_ing.destroy
call uo_tipo_periodo::destroy
end on

type em_2 from editmask within w_avance_soli
event constructor pbm_constructor
int X=3072
int Y=64
int Width=424
int Height=86
int TabOrder=10
Alignment Alignment=Center!
string Mask="dd-mm-yyyy"
MaskDataType MaskDataType=DateMask!
boolean Spin=true
string DisplayData=""
double Increment=1
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;text=String(Today( ), "dd-mm-yyyy")
end event

type em_1 from editmask within w_avance_soli
int X=2626
int Y=64
int Width=424
int Height=86
int TabOrder=20
Alignment Alignment=Center!
string Mask="dd-mm-yyyy"
MaskDataType MaskDataType=DateMask!
boolean Spin=true
string DisplayData="\"
double Increment=1
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;text=String(Today( ), "dd-mm-yyyy")

end event

type uo_1 from uo_ver_per_ani within w_avance_soli
int X=0
int Y=22
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_avance_soli
int X=15
int Y=192
int Width=3456
int Height=1574
int TabOrder=0
string DataObject="dw_avance_soli"
end type

event carga;DateTime fecha_1,fecha_2

date dia_1,dia_2
time hora_1,hora_2


IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	this.dataobject = "dw_avance_soli"
	this.SetTransObject(gtr_sadm)
ELSE
	this.dataobject = "dw_avance_soli_ing"
	this.SetTransObject(gtr_sadm)	
END IF

DataWindowChild carr
getchild("aspiran_clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

dia_1 = Date(em_1.Text)
dia_2 = Date(em_2.Text)
hora_1 = Time('0:0:0.000')
hora_2 = Time('23:59:59.9999')
fecha_1 = DateTime(dia_1,hora_1)
fecha_2 = DateTime(dia_2,hora_2)

event primero()
object.st_1.text='Solicitudes recibidas del '+em_1.text+' al '+em_2.text+' para '+tit1
return retrieve(gi_version,gi_periodo,gi_anio,fecha_1,fecha_2)
end event

event constructor;call super::constructor;DataWindowChild carr
getchild("aspiran_clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

