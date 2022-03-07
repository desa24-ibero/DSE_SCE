﻿$PBExportHeader$w_alumnosnombre_restring.srw
forward
global type w_alumnosnombre_restring from Window
end type
type cb_ncta from commandbutton within w_alumnosnombre_restring
end type
type cb_nom from commandbutton within w_alumnosnombre_restring
end type
type cb_am from commandbutton within w_alumnosnombre_restring
end type
type cb_ap from commandbutton within w_alumnosnombre_restring
end type
type dw_nombre from datawindow within w_alumnosnombre_restring
end type
end forward

global type w_alumnosnombre_restring from Window
int X=468
int Y=614
int Width=2772
int Height=1037
boolean TitleBar=true
boolean ControlMenu=true
boolean MinBox=true
WindowType WindowType=popup!
cb_ncta cb_ncta
cb_nom cb_nom
cb_am cb_am
cb_ap cb_ap
dw_nombre dw_nombre
end type
global w_alumnosnombre_restring w_alumnosnombre_restring

type variables
datawindow dw_inicio
editmask em_cuenta
editmask em_digito
boolean usuario_especial
end variables

on w_alumnosnombre_restring.create
this.cb_ncta=create cb_ncta
this.cb_nom=create cb_nom
this.cb_am=create cb_am
this.cb_ap=create cb_ap
this.dw_nombre=create dw_nombre
this.Control[]={this.cb_ncta,&
this.cb_nom,&
this.cb_am,&
this.cb_ap,&
this.dw_nombre}
end on

on w_alumnosnombre_restring.destroy
destroy(this.cb_ncta)
destroy(this.cb_nom)
destroy(this.cb_am)
destroy(this.cb_ap)
destroy(this.dw_nombre)
end on

event open;str_param_obj_nombre_r estruct
estruct = message.powerobjectparm
dw_inicio = estruct.nombre
em_cuenta = estruct.cuenta
em_digito = estruct.digito
usuario_especial = estruct.usuario_especial

//if usuario_especial then
//	dw_nombre.dataobject = 	"dw_consulta_alumno"
//else
//	dw_nombre.dataobject = 	"dw_consulta_alumno_restring"
//end if

dw_nombre.settransobject(gtr_sce)
end event

type cb_ncta from commandbutton within w_alumnosnombre_restring
int X=2004
int Y=61
int Width=424
int Height=86
int TabOrder=40
string Text="No. de Cuenta"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_nombre.setsort("cuenta")
dw_nombre.sort()
end event

type cb_nom from commandbutton within w_alumnosnombre_restring
int X=1349
int Y=61
int Width=640
int Height=86
int TabOrder=30
string Text="Nombre"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_nombre.setsort("nombre")
dw_nombre.sort()
end event

type cb_am from commandbutton within w_alumnosnombre_restring
int X=699
int Y=61
int Width=636
int Height=86
int TabOrder=20
string Text="Apellido Materno"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_nombre.setsort("amaterno")
dw_nombre.sort()
end event

type cb_ap from commandbutton within w_alumnosnombre_restring
int X=55
int Y=61
int Width=636
int Height=86
int TabOrder=10
string Text="Apellido Paterno"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_nombre.setsort("apaterno")
dw_nombre.sort()
end event

type dw_nombre from datawindow within w_alumnosnombre_restring
int X=22
int Y=32
int Width=2659
int Height=848
int TabOrder=50
string DataObject="dw_consulta_alumno"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
end type

event doubleclicked;/*Este evento funciona para realizar el Retrieve de los datos
tras la selección del alumno
*/
long ll_cuenta
char lch_digito

ll_cuenta = dw_nombre.getitemnumber(dw_nombre.getrow(),"cuenta")
lch_digito = obten_digito(ll_cuenta)

dw_inicio.retrieve(ll_cuenta)
em_cuenta.text=string(ll_cuenta)+string(lch_digito)
em_cuenta.triggerevent("activarbusq")
close(w_alumnosnombre_restring)
end event

event retrieveend;dw_nombre.setsort("apaterno,amaterno,nombre")
dw_nombre.sort()
end event
