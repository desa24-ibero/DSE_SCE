$PBExportHeader$w_reporte_carreras.srw
forward
global type w_reporte_carreras from Window
end type
type uo_tipo_periodo_ing from uo_tipo_periodo within w_reporte_carreras
end type
type cbx_1 from checkbox within w_reporte_carreras
end type
type cb_3 from commandbutton within w_reporte_carreras
end type
type cb_2 from commandbutton within w_reporte_carreras
end type
type uo_1 from uo_ver_per_ani within w_reporte_carreras
end type
type dw_1 from uo_dw_reporte within w_reporte_carreras
end type
end forward

global type w_reporte_carreras from Window
int X=834
int Y=362
int Width=3507
int Height=1965
boolean TitleBar=true
string Title="Reporte de Pagos por Carrera"
string MenuName="m_menu"
long BackColor=30976088
uo_tipo_periodo_ing uo_tipo_periodo_ing
cbx_1 cbx_1
cb_3 cb_3
cb_2 cb_2
uo_1 uo_1
dw_1 dw_1
end type
global w_reporte_carreras w_reporte_carreras

on w_reporte_carreras.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_tipo_periodo_ing=create uo_tipo_periodo_ing
this.cbx_1=create cbx_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.uo_tipo_periodo_ing,&
this.cbx_1,&
this.cb_3,&
this.cb_2,&
this.uo_1,&
this.dw_1}
end on

on w_reporte_carreras.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_tipo_periodo_ing)
destroy(this.cbx_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type uo_tipo_periodo_ing from uo_tipo_periodo within w_reporte_carreras
int X=2286
int Y=38
int TabOrder=20
end type

on uo_tipo_periodo_ing.destroy
call uo_tipo_periodo::destroy
end on

type cbx_1 from checkbox within w_reporte_carreras
int X=2684
int Y=64
int Width=271
int Height=77
int TabOrder=30
string Text="Pagado"
boolean LeftText=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_3 from commandbutton within w_reporte_carreras
int X=3032
int Y=112
int Width=293
int Height=70
int TabOrder=20
string Text="Inscripción"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	dw_1.dataobject = "dw_reporte_carreras"
	dw_1.SetTransObject(gtr_sadm)
ELSE
	dw_1.dataobject = "dw_reporte_carreras_ing"
	dw_1.SetTransObject(gtr_sadm)	
END IF

DataWindowChild carr
dw_1.getchild("aspiran_clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

dw_1.event primero()

if cbx_1.checked then
	dw_1.retrieve(gi_version,gi_periodo,gi_anio,1,1)
	dw_1.object.st_1.text=tit1+' Inscripción Pagada'
else
	dw_1.retrieve(gi_version,gi_periodo,gi_anio,0,1)
	dw_1.object.st_1.text=tit1+' Inscripción No Pagada'
end if
end event

type cb_2 from commandbutton within w_reporte_carreras
int X=3032
int Y=26
int Width=293
int Height=70
int TabOrder=10
string Text="Examen"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	dw_1.dataobject = "dw_reporte_carreras"
	dw_1.SetTransObject(gtr_sadm)
ELSE
	dw_1.dataobject = "dw_reporte_carreras_ing"
	dw_1.SetTransObject(gtr_sadm)	
END IF

DataWindowChild carr
dw_1.getchild("aspiran_clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

dw_1.event primero()
if cbx_1.checked then
	dw_1.retrieve(gi_version,gi_periodo,gi_anio,1,0)
	dw_1.object.st_1.text=tit1+' Examen Pagado'
else
	dw_1.retrieve(gi_version,gi_periodo,gi_anio,0,0)
	dw_1.object.st_1.text=tit1+' Examen No Pagado'
end if
end event

type uo_1 from uo_ver_per_ani within w_reporte_carreras
int X=0
int Y=22
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_reporte_carreras
int X=15
int Y=192
int Width=3456
int Height=1590
int TabOrder=0
string DataObject="dw_reporte_carreras"
end type

event constructor;call super::constructor;DataWindowChild carr
getchild("aspiran_clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;/**/

return 0
end event

