$PBExportHeader$w_biblias.srw
$PBExportComments$Ventana para seleccionar los folios de los aspirantes para que se emitan las biblias respectivas
forward
global type w_biblias from Window
end type
type uo_tipo_periodo_ing from uo_tipo_periodo within w_biblias
end type
type dw_1 from uo_dw_reporte within w_biblias
end type
type uo_1 from uo_ver_per_ani within w_biblias
end type
type em_max from editmask within w_biblias
end type
type em_min from editmask within w_biblias
end type
end forward

global type w_biblias from Window
int X=834
int Y=362
int Width=3723
int Height=1725
boolean TitleBar=true
string Title="Emisión de Biblias"
string MenuName="m_menu"
long BackColor=30976088
event type long num_folios ( integer min_max )
uo_tipo_periodo_ing uo_tipo_periodo_ing
dw_1 dw_1
uo_1 uo_1
em_max em_max
em_min em_min
end type
global w_biblias w_biblias

event num_folios;long folios

if min_max=0 then
	SELECT min(aspiran.folio)
	INTO :folios
	FROM aspiran  
	WHERE ( aspiran.clv_ver = :gi_version ) AND  
		( aspiran.clv_per = :gi_periodo ) AND  
		( aspiran.anio = :gi_anio )
	USING gtr_sadm;
else
	SELECT max(aspiran.folio)
	INTO :folios
	FROM aspiran  
	WHERE ( aspiran.clv_ver = :gi_version ) AND  
		( aspiran.clv_per = :gi_periodo ) AND  
		( aspiran.anio = :gi_anio )
	USING gtr_sadm;
end if

return folios
end event

on w_biblias.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_tipo_periodo_ing=create uo_tipo_periodo_ing
this.dw_1=create dw_1
this.uo_1=create uo_1
this.em_max=create em_max
this.em_min=create em_min
this.Control[]={this.uo_tipo_periodo_ing,&
this.dw_1,&
this.uo_1,&
this.em_max,&
this.em_min}
end on

on w_biblias.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_tipo_periodo_ing)
destroy(this.dw_1)
destroy(this.uo_1)
destroy(this.em_max)
destroy(this.em_min)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type uo_tipo_periodo_ing from uo_tipo_periodo within w_biblias
int X=2315
int Y=42
int TabOrder=10
end type

on uo_tipo_periodo_ing.destroy
call uo_tipo_periodo::destroy
end on

type dw_1 from uo_dw_reporte within w_biblias
int X=33
int Y=198
int Width=3613
int Height=1306
int TabOrder=0
string DataObject="dw_biblias"
end type

event constructor;call super::constructor;DataWindowChild carr
getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

DataWindowChild est
getchild("general_estado",est)
est.settransobject(gtr_sce)
est.retrieve()

DataWindowChild lug
getchild("general_lugar_nac",lug)
lug.settransobject(gtr_sce)
lug.retrieve()

DataWindowChild edo
getchild("general_edo_civil",edo)
edo.settransobject(gtr_sce)
edo.retrieve()

DataWindowChild bac
getchild("general_bachillera",bac)
bac.settransobject(gtr_sce)
bac.retrieve()

end event

event carga;IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	this.dataobject = "dw_biblias"
	this.SetTransObject(gtr_sadm)
ELSE
	this.dataobject = "dw_biblias_ing"
	this.SetTransObject(gtr_sadm)	
END IF

DataWindowChild carr
getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

DataWindowChild est
getchild("general_estado",est)
est.settransobject(gtr_sce)
est.retrieve()

DataWindowChild lug
getchild("general_lugar_nac",lug)
lug.settransobject(gtr_sce)
lug.retrieve()

DataWindowChild edo
getchild("general_edo_civil",edo)
edo.settransobject(gtr_sce)
edo.retrieve()

DataWindowChild bac
getchild("general_bachillera",bac)
bac.settransobject(gtr_sce)
bac.retrieve()

event primero()
object.st_1.text='Biblias del '+tit1
return retrieve(gi_version,gi_periodo,gi_anio,long(em_min.text),long(em_max.text))
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

type uo_1 from uo_ver_per_ani within w_biblias
int X=29
int Y=26
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type em_max from editmask within w_biblias
int X=3072
int Y=54
int Width=340
int Height=102
Alignment Alignment=Center!
string Mask="######"
boolean Spin=true
string DisplayData=""
double Increment=1
string MinMax="2~~999999"
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;text=string(event num_folios(1))
end event

event getfocus;text=string(event num_folios(1))
end event

type em_min from editmask within w_biblias
int X=2714
int Y=54
int Width=340
int Height=102
Alignment Alignment=Center!
string Mask="######"
boolean Spin=true
string DisplayData=""
double Increment=1
string MinMax="2~~999999"
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;text=string(event num_folios(0))
end event

event getfocus;text=string(event num_folios(0))
end event

