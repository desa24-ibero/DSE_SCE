$PBExportHeader$w_lista_alumnos_padres.srw
forward
global type w_lista_alumnos_padres from Window
end type
type uo_tipo_periodo_ing from uo_tipo_periodo within w_lista_alumnos_padres
end type
type uo_1 from uo_per_ani within w_lista_alumnos_padres
end type
type dw_1 from uo_dw_reporte within w_lista_alumnos_padres
end type
end forward

global type w_lista_alumnos_padres from Window
int X=0
int Y=0
int Width=3595
int Height=1958
boolean TitleBar=true
string Title="Lista de datos de Alumnos-Padres"
string MenuName="m_menu"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
uo_tipo_periodo_ing uo_tipo_periodo_ing
uo_1 uo_1
dw_1 dw_1
end type
global w_lista_alumnos_padres w_lista_alumnos_padres

on w_lista_alumnos_padres.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_tipo_periodo_ing=create uo_tipo_periodo_ing
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.uo_tipo_periodo_ing,&
this.uo_1,&
this.dw_1}
end on

on w_lista_alumnos_padres.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_tipo_periodo_ing)
destroy(this.uo_1)
destroy(this.dw_1)
end on

type uo_tipo_periodo_ing from uo_tipo_periodo within w_lista_alumnos_padres
int X=1269
int Y=48
int TabOrder=11
end type

on uo_tipo_periodo_ing.destroy
call uo_tipo_periodo::destroy
end on

type uo_1 from uo_per_ani within w_lista_alumnos_padres
int X=18
int Y=32
int TabOrder=10
boolean Enabled=true
long BackColor=1086374080
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_lista_alumnos_padres
int X=18
int Y=224
int Width=3452
int Height=1373
int TabOrder=20
string DataObject="d_lista_alumnos_padres"
boolean TitleBar=true
string Title="Lista de datos Alumnos-Padres"
boolean Border=true
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=true
end type

event constructor;call super::constructor;settransobject(gtr_sadm)
DataWindowChild est,est_padres
getchild("general_estado",est)
getchild("general_estado",est_padres)
est.settransobject(gtr_sce)
est_padres.settransobject(gtr_sce)
est.retrieve()

end event

event carga;
IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	this.dataobject = "d_lista_alumnos_padres"
	this.SetTransObject(gtr_sadm)
ELSE
	this.dataobject = "d_lista_alumnos_padres_ing"
	this.SetTransObject(gtr_sadm)	
END IF

DataWindowChild est,est_padres
getchild("general_estado",est)
getchild("general_estado",est_padres)
est.settransobject(gtr_sce)
est_padres.settransobject(gtr_sce)
est.retrieve()

event primero()
return retrieve(gi_periodo,gi_anio,9999)



end event

