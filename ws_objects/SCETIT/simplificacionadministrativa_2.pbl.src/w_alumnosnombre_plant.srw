$PBExportHeader$w_alumnosnombre_plant.srw
forward
global type w_alumnosnombre_plant from Window
end type
type cb_ncta from commandbutton within w_alumnosnombre_plant
end type
type cb_ap from commandbutton within w_alumnosnombre_plant
end type
type dw_nombre from datawindow within w_alumnosnombre_plant
end type
end forward

global type w_alumnosnombre_plant from Window
int X=468
int Y=614
int Width=2772
int Height=1037
boolean TitleBar=true
boolean ControlMenu=true
boolean MinBox=true
WindowType WindowType=popup!
cb_ncta cb_ncta
cb_ap cb_ap
dw_nombre dw_nombre
end type
global w_alumnosnombre_plant w_alumnosnombre_plant

type variables
datawindow dw_inicio
editmask em_cuenta
editmask em_digito
end variables

on w_alumnosnombre_plant.create
this.cb_ncta=create cb_ncta
this.cb_ap=create cb_ap
this.dw_nombre=create dw_nombre
this.Control[]={this.cb_ncta,&
this.cb_ap,&
this.dw_nombre}
end on

on w_alumnosnombre_plant.destroy
destroy(this.cb_ncta)
destroy(this.cb_ap)
destroy(this.dw_nombre)
end on

event open;param_obj_nombre estruct
estruct = message.powerobjectparm
dw_inicio = estruct.nombre
em_cuenta = estruct.cuenta
em_digito = estruct.digito
dw_nombre.settransobject(gtr_sce)
end event

type cb_ncta from commandbutton within w_alumnosnombre_plant
int X=2004
int Y=61
int Width=424
int Height=86
int TabOrder=20
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

type cb_ap from commandbutton within w_alumnosnombre_plant
int X=55
int Y=61
int Width=1938
int Height=86
int TabOrder=10
string Text="Nombre Completo"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_nombre.setsort("nombre_completo")
dw_nombre.sort()
end event

type dw_nombre from datawindow within w_alumnosnombre_plant
int X=22
int Y=32
int Width=2659
int Height=848
int TabOrder=30
string DataObject="dw_consulta_alumno_plant"
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
close(w_alumnosnombre_plant)
end event

event retrieveend;dw_nombre.setsort("nombre_completo, cuenta")
dw_nombre.sort()
end event

