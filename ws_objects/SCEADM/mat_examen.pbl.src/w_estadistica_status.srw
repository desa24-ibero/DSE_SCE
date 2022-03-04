$PBExportHeader$w_estadistica_status.srw
forward
global type w_estadistica_status from Window
end type
type uo_tipo_periodo_ing from uo_tipo_periodo within w_estadistica_status
end type
type uo_sel_carrera from uo_carrera within w_estadistica_status
end type
type cbx_rechazados from checkbox within w_estadistica_status
end type
type cbx_diferidos from checkbox within w_estadistica_status
end type
type cbx_inscritos from checkbox within w_estadistica_status
end type
type cbx_aceptados from checkbox within w_estadistica_status
end type
type dw_status_seleccion from datawindow within w_estadistica_status
end type
type cb_buscar from commandbutton within w_estadistica_status
end type
type uo_1 from uo_ver_per_ani within w_estadistica_status
end type
type dw_1 from uo_dw_reporte within w_estadistica_status
end type
end forward

global type w_estadistica_status from Window
int X=834
int Y=362
int Width=3694
int Height=1965
boolean TitleBar=true
string Title="Estadística de Status de Aspirantes"
string MenuName="m_menu"
long BackColor=30976088
uo_tipo_periodo_ing uo_tipo_periodo_ing
uo_sel_carrera uo_sel_carrera
cbx_rechazados cbx_rechazados
cbx_diferidos cbx_diferidos
cbx_inscritos cbx_inscritos
cbx_aceptados cbx_aceptados
dw_status_seleccion dw_status_seleccion
cb_buscar cb_buscar
uo_1 uo_1
dw_1 dw_1
end type
global w_estadistica_status w_estadistica_status

on w_estadistica_status.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_tipo_periodo_ing=create uo_tipo_periodo_ing
this.uo_sel_carrera=create uo_sel_carrera
this.cbx_rechazados=create cbx_rechazados
this.cbx_diferidos=create cbx_diferidos
this.cbx_inscritos=create cbx_inscritos
this.cbx_aceptados=create cbx_aceptados
this.dw_status_seleccion=create dw_status_seleccion
this.cb_buscar=create cb_buscar
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.uo_tipo_periodo_ing,&
this.uo_sel_carrera,&
this.cbx_rechazados,&
this.cbx_diferidos,&
this.cbx_inscritos,&
this.cbx_aceptados,&
this.dw_status_seleccion,&
this.cb_buscar,&
this.uo_1,&
this.dw_1}
end on

on w_estadistica_status.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_tipo_periodo_ing)
destroy(this.uo_sel_carrera)
destroy(this.cbx_rechazados)
destroy(this.cbx_diferidos)
destroy(this.cbx_inscritos)
destroy(this.cbx_aceptados)
destroy(this.dw_status_seleccion)
destroy(this.cb_buscar)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type uo_tipo_periodo_ing from uo_tipo_periodo within w_estadistica_status
int X=2308
int Y=38
int TabOrder=10
end type

on uo_tipo_periodo_ing.destroy
call uo_tipo_periodo::destroy
end on

type uo_sel_carrera from uo_carrera within w_estadistica_status
int X=2326
int Y=189
int TabOrder=30
boolean Enabled=true
long BackColor=1090519039
end type

on uo_sel_carrera.destroy
call uo_carrera::destroy
end on

type cbx_rechazados from checkbox within w_estadistica_status
int X=37
int Y=253
int Width=413
int Height=80
string Text="Rechazados"
boolean LeftText=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_diferidos from checkbox within w_estadistica_status
int X=1423
int Y=253
int Width=311
int Height=80
string Text="Diferidos"
boolean LeftText=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_inscritos from checkbox within w_estadistica_status
int X=1017
int Y=253
int Width=307
int Height=80
string Text="Inscritos"
boolean LeftText=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_aceptados from checkbox within w_estadistica_status
int X=549
int Y=253
int Width=366
int Height=80
string Text="Aceptados"
boolean LeftText=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_status_seleccion from datawindow within w_estadistica_status
int X=2977
int Y=214
int Width=494
int Height=381
int TabOrder=20
boolean Visible=false
string DataObject="dw_status_seleccion"
boolean LiveScroll=true
end type

type cb_buscar from commandbutton within w_estadistica_status
int X=1898
int Y=240
int Width=307
int Height=106
int TabOrder=10
string Text="Buscar"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/**/
integer array_li_status[ ], li_carrera
long ll_tamanio,  ll_siguiente


IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	dw_1.dataobject = "dw_estadistica_status"
	dw_1.SetTransObject(gtr_sadm)
ELSE
	dw_1.dataobject = "dw_estadistica_status_ing"
	dw_1.SetTransObject(gtr_sadm)	
END IF

//SetNull(array_li_status)


li_carrera= uo_sel_carrera.dw_carrera.object.cve_carrera[uo_sel_carrera.dw_carrera.getrow()]

if cbx_rechazados.Checked then
	ll_tamanio=UpperBound(array_li_status)		
	ll_siguiente=ll_tamanio+1
	array_li_status[ll_siguiente]=0
end if

if cbx_aceptados.Checked then
	ll_tamanio=UpperBound(array_li_status)		
	ll_siguiente=ll_tamanio+1
	array_li_status[ll_siguiente]=1
end if

if cbx_inscritos.Checked then
	ll_tamanio=UpperBound(array_li_status)		
	ll_siguiente=ll_tamanio+1
	array_li_status[ll_siguiente]=2
end if

if cbx_diferidos.Checked then
	ll_tamanio=UpperBound(array_li_status)		
	ll_siguiente=ll_tamanio+1
	array_li_status[ll_siguiente]=3
end if

ll_tamanio=UpperBound(array_li_status)		
ll_siguiente=ll_tamanio+1
array_li_status[ll_siguiente]=10


dw_1.retrieve(gi_version, gi_periodo, gi_anio, array_li_status, li_carrera)

end event

type uo_1 from uo_ver_per_ani within w_estadistica_status
int X=18
int Y=22
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_estadistica_status
int X=22
int Y=400
int Width=3566
int Height=1318
int TabOrder=0
string DataObject="dw_estadistica_status"
boolean HScrollBar=true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;/**/
integer array_li_status[ ], li_carrera
long ll_tamanio,  ll_siguiente

IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	this.dataobject = "dw_estadistica_status"
	this.SetTransObject(gtr_sadm)
ELSE
	this.dataobject = "dw_estadistica_status_ing"
	this.SetTransObject(gtr_sadm)	
END IF

//return retrieve(gi_version,ord,gi_periodo,gi_anio,
//uo_2.dw_carrera.object.cve_carrera[uo_2.dw_carrera.getrow()])

li_carrera= uo_sel_carrera.dw_carrera.object.cve_carrera[uo_sel_carrera.dw_carrera.getrow()]

//SetNull(array_li_status)

if cbx_rechazados.Checked then
	ll_tamanio=UpperBound(array_li_status)		
	ll_siguiente=ll_tamanio+1
	array_li_status[ll_siguiente]=0
end if

if cbx_aceptados.Checked then
	ll_tamanio=UpperBound(array_li_status)		
	ll_siguiente=ll_tamanio+1
	array_li_status[ll_siguiente]=1
end if

if cbx_inscritos.Checked then
	ll_tamanio=UpperBound(array_li_status)		
	ll_siguiente=ll_tamanio+1
	array_li_status[ll_siguiente]=2
end if

if cbx_diferidos.Checked then
	ll_tamanio=UpperBound(array_li_status)		
	ll_siguiente=ll_tamanio+1
	array_li_status[ll_siguiente]=3
end if

ll_tamanio=UpperBound(array_li_status)		
ll_siguiente=ll_tamanio+1
array_li_status[ll_siguiente]=10


retrieve(gi_version, gi_periodo, gi_anio, array_li_status, li_carrera)

return 0

end event

