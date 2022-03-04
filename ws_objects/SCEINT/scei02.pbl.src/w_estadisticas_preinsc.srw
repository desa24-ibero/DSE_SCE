$PBExportHeader$w_estadisticas_preinsc.srw
forward
global type w_estadisticas_preinsc from w_ancestral
end type
type cb_1 from commandbutton within w_estadisticas_preinsc
end type
type dw_estadisticas_preinsc from uo_dw_reporte within w_estadisticas_preinsc
end type
type dw_proveedor from uo_dw_reporte within w_estadisticas_preinsc
end type
end forward

global type w_estadisticas_preinsc from w_ancestral
int Height=2220
boolean TitleBar=true
string Title="Estadísticas del Correo"
string MenuName="m_menu"
cb_1 cb_1
dw_estadisticas_preinsc dw_estadisticas_preinsc
dw_proveedor dw_proveedor
end type
global w_estadisticas_preinsc w_estadisticas_preinsc

on w_estadisticas_preinsc.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_1=create cb_1
this.dw_estadisticas_preinsc=create dw_estadisticas_preinsc
this.dw_proveedor=create dw_proveedor
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_estadisticas_preinsc
this.Control[iCurrent+3]=this.dw_proveedor
end on

on w_estadisticas_preinsc.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.dw_estadisticas_preinsc)
destroy(this.dw_proveedor)
end on

event open;call super::open;dw_estadisticas_preinsc.settransobject(gtr_sce)
dw_proveedor.settransobject(gtr_sce)
end event

type cb_1 from commandbutton within w_estadisticas_preinsc
int X=1445
int Y=152
int Width=658
int Height=108
int TabOrder=1
boolean BringToTop=true
string Text="Estadísticas de Correo"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;window ventana_propietaria

text='Estadísticas de Correo'
ventana_propietaria = getparent()
dw_estadisticas_preinsc.menu_propietario = ventana_propietaria.menuid
dw_estadisticas_preinsc.menu_propietario.dw	= dw_estadisticas_preinsc

dw_estadisticas_preinsc.visible=true
dw_proveedor.visible=false
end event

event clicked;window ventana_propietaria

if text='Estadísticas de Correo' then
	text='Proveedores de Correo'
	ventana_propietaria = getparent()
	dw_proveedor.menu_propietario = ventana_propietaria.menuid
	dw_proveedor.menu_propietario.dw	= dw_proveedor
	
	dw_estadisticas_preinsc.visible=false
	dw_proveedor.visible=true
else
	text='Estadísticas de Correo'
	ventana_propietaria = getparent()
	dw_estadisticas_preinsc.menu_propietario = ventana_propietaria.menuid
	dw_estadisticas_preinsc.menu_propietario.dw	= dw_estadisticas_preinsc

	dw_estadisticas_preinsc.visible=true
	dw_proveedor.visible=false
end if
end event

type dw_estadisticas_preinsc from uo_dw_reporte within w_estadisticas_preinsc
event inicia_transaction_object ( )
int X=0
int Y=424
int Width=3552
int Height=1596
int TabOrder=10
string DataObject="dw_estadisticas_preinsc"
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

event asigna_dw_menu;///*
//DESCRIPCIÓN: Evento en el cual se asigna a la variable dw del menu este objeto.
//				En este evento se busca la ventana dueña del objeto y cual es su menu
//PARÁMETROS: Ninguno
//REGRESA: Nada
//AUTOR: CAMP(DkWf)
//FECHA: 17 Junio 1998
//MODIFICACIÓN:
//*/
//window ventana_propietaria
//
//ventana_propietaria = getparent()
//
//menu_propietario = ventana_propietaria.menuid
//
//menu_propietario.dw	= this
end event

type dw_proveedor from uo_dw_reporte within w_estadisticas_preinsc
event inicia_transaction_object ( )
int X=0
int Y=424
int Width=3552
int Height=1596
int TabOrder=20
string DataObject="dw_proveedor"
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

event asigna_dw_menu;///*
//DESCRIPCIÓN: Evento en el cual se asigna a la variable dw del menu este objeto.
//				En este evento se busca la ventana dueña del objeto y cual es su menu
//PARÁMETROS: Ninguno
//REGRESA: Nada
//AUTOR: CAMP(DkWf)
//FECHA: 17 Junio 1998
//MODIFICACIÓN:
//*/
//window ventana_propietaria
//
//ventana_propietaria = getparent()
//
//menu_propietario = ventana_propietaria.menuid
//
//menu_propietario.dw	= this
end event

