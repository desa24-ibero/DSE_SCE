﻿$PBExportHeader$w_aspirantesnombre.srw
$PBExportComments$Ventana utilizada para presentar diversas posibilidades de aspirantes con el mismo nombre o apellidos. Usada para seleccionar uno.
forward
global type w_aspirantesnombre from Window
end type
type cb_ncta from commandbutton within w_aspirantesnombre
end type
type cb_nom from commandbutton within w_aspirantesnombre
end type
type cb_am from commandbutton within w_aspirantesnombre
end type
type cb_ap from commandbutton within w_aspirantesnombre
end type
type dw_nombre from datawindow within w_aspirantesnombre
end type
end forward

global type w_aspirantesnombre from Window
int X=197
int Y=741
int Width=3287
int Height=889
long BackColor=79741120
WindowType WindowType=child!
cb_ncta cb_ncta
cb_nom cb_nom
cb_am cb_am
cb_ap cb_ap
dw_nombre dw_nombre
end type
global w_aspirantesnombre w_aspirantesnombre

type variables
datawindow dw_inicio
long folio
editmask em_cuenta
end variables

on w_aspirantesnombre.create
this.cb_ncta=create cb_ncta
this.cb_nom=create cb_nom
this.cb_am=create cb_am
this.cb_ap=create cb_ap
this.dw_nombre=create dw_nombre
this.Control[]={ this.cb_ncta,&
this.cb_nom,&
this.cb_am,&
this.cb_ap,&
this.dw_nombre}
end on

on w_aspirantesnombre.destroy
destroy(this.cb_ncta)
destroy(this.cb_nom)
destroy(this.cb_am)
destroy(this.cb_ap)
destroy(this.dw_nombre)
end on

event open;/*Lee los parámetros que le pasaron al abrirse y los asigna en variables de instancia,
dw_inicio, em_cuenta y em_digito*/
param_obj_aspirante estruct
estruct = message.powerobjectparm

dw_inicio = estruct.nombre
folio = estruct.folio
em_cuenta = estruct.em_cuenta
end event

type cb_ncta from commandbutton within w_aspirantesnombre
int X=2817
int Y=57
int Width=371
int Height=85
int TabOrder=40
boolean Visible=false
string Text="Folio"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/*Ordena el dw*/
dw_nombre.setsort("folio")
dw_nombre.sort()
end event

type cb_nom from commandbutton within w_aspirantesnombre
int X=1898
int Y=57
int Width=897
int Height=85
int TabOrder=30
boolean Visible=false
string Text="Nombre"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/*Ordena el dw*/
dw_nombre.setsort("nombre")
dw_nombre.sort()
end event

type cb_am from commandbutton within w_aspirantesnombre
int X=979
int Y=61
int Width=897
int Height=85
int TabOrder=20
boolean Visible=false
string Text="Apellido Materno"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/*Ordena el dw*/
dw_nombre.setsort("amaterno")
dw_nombre.sort()
end event

type cb_ap from commandbutton within w_aspirantesnombre
int X=60
int Y=61
int Width=897
int Height=85
int TabOrder=10
boolean Visible=false
string Text="Apellido Paterno"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/*Ordena el dw*/
dw_nombre.setsort("apaterno")
dw_nombre.sort()
end event

type dw_nombre from datawindow within w_aspirantesnombre
event type integer carga ( string nombre,  string apat,  string amat )
int X=23
int Y=25
int Width=3237
int Height=849
string DataObject="dw_consulta_aspirante"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
end type

event carga;return retrieve(nombre,apat,amat,gi_version,gi_periodo,gi_anio)
end event

event doubleclicked;/*Este evento funciona para realizar el Carga() de los datos
tras la selección del aspirante*/
long lo_cuenta
char ch_digito

lo_cuenta = dw_nombre.getitemnumber(dw_nombre.getrow(),"folio")
ch_digito = obten_digito(lo_cuenta)

dw_inicio.triggerevent("carga(cuenta)")
em_cuenta.text=string(lo_cuenta)+string(ch_digito)
em_cuenta.triggerevent("activarbusq")
close(parent)
end event

event retrieveend;dw_nombre.setsort("apaterno,amaterno,nombre")
dw_nombre.sort()
end event

event constructor;settransobject(gtr_sadm)
end event

