$PBExportHeader$w_lugares.srw
$PBExportComments$Asigna Lugares de acuerdo a los puntajes
forward
global type w_lugares from Window
end type
type dw_1 from uo_dw_captura within w_lugares
end type
type dw_2 from uo_dw_captura within w_lugares
end type
type dw_3 from uo_dw_captura within w_lugares
end type
type ddlb_opcion from dropdownlistbox within w_lugares
end type
type cb_3 from commandbutton within w_lugares
end type
type st_1 from statictext within w_lugares
end type
type cb_1 from commandbutton within w_lugares
end type
type uo_1 from uo_ver_per_ani within w_lugares
end type
end forward

global type w_lugares from Window
int X=833
int Y=361
int Width=3091
int Height=1957
boolean TitleBar=true
string Title="Cálculo de Lugares"
string MenuName="m_menu"
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
ddlb_opcion ddlb_opcion
cb_3 cb_3
st_1 st_1
cb_1 cb_1
uo_1 uo_1
end type
global w_lugares w_lugares

type variables
int carr
end variables

on w_lugares.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.ddlb_opcion=create ddlb_opcion
this.cb_3=create cb_3
this.st_1=create st_1
this.cb_1=create cb_1
this.uo_1=create uo_1
this.Control[]={ this.dw_1,&
this.dw_2,&
this.dw_3,&
this.ddlb_opcion,&
this.cb_3,&
this.st_1,&
this.cb_1,&
this.uo_1}
end on

on w_lugares.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.ddlb_opcion)
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.uo_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
dw_2.settransobject(gtr_sadm)
dw_3.settransobject(gtr_sadm)
end event

type dw_1 from uo_dw_captura within w_lugares
int X=14
int Y=397
int Width=1276
int Height=1357
int TabOrder=40
string DataObject="dw_lugar_gen"
end type

event constructor;call super::constructor;m_menu.dw = this
end event

event carga;st_1.text="Cargando General"

int opcion

IF ddlb_opcion.text='DIFERIDOS' THEN
	opcion=1
else
	opcion=0
END IF

return retrieve(gi_version,gi_periodo,gi_anio,opcion)

st_1.text="Cargando Por Carrera"
carr=9999
dw_2.event carga()
st_1.text="Ya acabe"
end event

type dw_2 from uo_dw_captura within w_lugares
int X=1317
int Y=397
int Width=1729
int Height=1357
int TabOrder=50
string DataObject="dw_lugar_carr"
end type

event carga;int opcion

IF ddlb_opcion.text='DIFERIDOS' THEN
	opcion=1
else
	opcion=0
END IF

return retrieve(gi_version,gi_periodo,gi_anio,carr,opcion)
end event

type dw_3 from uo_dw_captura within w_lugares
int X=3091
int Y=401
int Width=494
int Height=793
int TabOrder=30
string DataObject="dw_carr_exis"
end type

event carga;return retrieve(gi_version,gi_periodo,gi_anio)
end event

type ddlb_opcion from dropdownlistbox within w_lugares
int X=2538
int Y=129
int Width=398
int Height=229
int TabOrder=10
boolean VScrollBar=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"NORMAL",&
"DIFERIDOS"}
end type

type cb_3 from commandbutton within w_lugares
event clicked pbm_bnclicked
int X=2364
int Y=237
int Width=467
int Height=109
int TabOrder=60
string Text="Asigna Lugares"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long cont1, cont2

SetPointer(HourGlass!)

st_1.text="Cargando Carreras"
dw_3.event carga()

FOR cont2=1 TO dw_3.rowcount()
	st_1.text="Cargando siguiente Carrera"
	carr=dw_3.object.clv_carr[cont2]
	dw_2.event carga()
	FOR cont1=1 TO dw_2.rowcount()
		st_1.text="Asignando Lugar "+string(cont1)+" Carrera "+&
			string(dw_3.object.clv_carr[cont2])
		dw_2.object.lugar_car[cont1]=cont1
	NEXT
	st_1.text="Guardando Cambios"
	dw_2.event actualiza()
NEXT

carr=9999
dw_2.event carga()
st_1.text="Ya acabé"
end event

type st_1 from statictext within w_lugares
int X=517
int Y=249
int Width=1797
int Height=77
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_lugares
int X=33
int Y=237
int Width=467
int Height=109
int TabOrder=20
string Text="Asigna Lugares"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long cont

dw_1.event carga()
SetPointer(HourGlass!)

FOR cont=1 TO dw_1.rowcount()
	st_1.text="Asignando Lugar "+string(cont)
	dw_1.object.lugar_gen[cont]=cont
NEXT

st_1.text="Guardando Cambios"
dw_1.event actualiza()
st_1.text="Ya acabé"
end event

type uo_1 from uo_ver_per_ani within w_lugares
int X=33
int Y=45
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

