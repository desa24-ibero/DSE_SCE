$PBExportHeader$w_dir_padre.srw
$PBExportComments$Ventana con el directorio de padres de inscritos
forward
global type w_dir_padre from Window
end type
type uo_tipo_periodo_ing from uo_tipo_periodo within w_dir_padre
end type
type cbx_pago_insc from checkbox within w_dir_padre
end type
type uo_2 from uo_carrera within w_dir_padre
end type
type uo_1 from uo_ver_per_ani within w_dir_padre
end type
type dw_1 from uo_dw_reporte within w_dir_padre
end type
end forward

global type w_dir_padre from Window
int X=834
int Y=362
int Width=3672
int Height=1949
boolean TitleBar=true
string Title="Directorio de Padres"
string MenuName="m_menu"
long BackColor=30976088
uo_tipo_periodo_ing uo_tipo_periodo_ing
cbx_pago_insc cbx_pago_insc
uo_2 uo_2
uo_1 uo_1
dw_1 dw_1
end type
global w_dir_padre w_dir_padre

on w_dir_padre.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_tipo_periodo_ing=create uo_tipo_periodo_ing
this.cbx_pago_insc=create cbx_pago_insc
this.uo_2=create uo_2
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.uo_tipo_periodo_ing,&
this.cbx_pago_insc,&
this.uo_2,&
this.uo_1,&
this.dw_1}
end on

on w_dir_padre.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_tipo_periodo_ing)
destroy(this.cbx_pago_insc)
destroy(this.uo_2)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type uo_tipo_periodo_ing from uo_tipo_periodo within w_dir_padre
int X=2286
int Y=29
int TabOrder=10
end type

on uo_tipo_periodo_ing.destroy
call uo_tipo_periodo::destroy
end on

type cbx_pago_insc from checkbox within w_dir_padre
int X=1723
int Y=189
int Width=541
int Height=77
string Text="Pago Inscripción"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_2 from uo_carrera within w_dir_padre
int X=2286
int Y=182
boolean Enabled=true
end type

on uo_2.destroy
call uo_carrera::destroy
end on

type uo_1 from uo_ver_per_ani within w_dir_padre
int X=0
int Y=13
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_dir_padre
int X=22
int Y=397
int Width=3584
int Height=1366
int TabOrder=0
string DataObject="dw_dir_padre"
end type

event constructor;call super::constructor;DataWindowChild est
getchild("padres_estado",est)
est.settransobject(gtr_sce)
est.retrieve()
end event

event carga;integer li_pago_insc

if cbx_pago_insc.Checked then
	li_pago_insc= 1
else
	li_pago_insc= 99
end if

IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	this.dataobject = "dw_dir_padre"
	this.SetTransObject(gtr_sadm)
ELSE
	this.dataobject = "dw_dir_padre_ing"
	this.SetTransObject(gtr_sadm)	
END IF

DataWindowChild est
getchild("padres_estado",est)
est.settransobject(gtr_sce)
est.retrieve()

event primero()
object.st_1.text=string(uo_2.dw_carrera.object.cve_carrera[uo_2.dw_carrera.getrow()])+' '+tit1
return retrieve(gi_version,gi_periodo,gi_anio,uo_2.dw_carrera.object.cve_carrera[uo_2.dw_carrera.getrow()],li_pago_insc)

//object.st_1.text=uo_2.dw_carrera.object.carr_clv[uo_2.dw_carrera.getrow()]+' '+tit1
//return retrieve(gi_version,gi_periodo,gi_anio,uo_2.dw_carrera.object.cve_carrera[uo_2.dw_carrera.getrow()])
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

