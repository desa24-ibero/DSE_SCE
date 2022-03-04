$PBExportHeader$w_aspirantes_reval_nombre.srw
forward
global type w_aspirantes_reval_nombre from Window
end type
type cb_nfolio from commandbutton within w_aspirantes_reval_nombre
end type
type cb_ncta from commandbutton within w_aspirantes_reval_nombre
end type
type cb_nom from commandbutton within w_aspirantes_reval_nombre
end type
type cb_am from commandbutton within w_aspirantes_reval_nombre
end type
type cb_ap from commandbutton within w_aspirantes_reval_nombre
end type
type dw_nombre from datawindow within w_aspirantes_reval_nombre
end type
end forward

global type w_aspirantes_reval_nombre from Window
int X=468
int Y=614
int Width=2757
int Height=1037
boolean TitleBar=true
boolean ControlMenu=true
boolean MinBox=true
WindowType WindowType=popup!
cb_nfolio cb_nfolio
cb_ncta cb_ncta
cb_nom cb_nom
cb_am cb_am
cb_ap cb_ap
dw_nombre dw_nombre
end type
global w_aspirantes_reval_nombre w_aspirantes_reval_nombre

type variables
datawindow dw_inicio
editmask em_cuenta
editmask em_digito
end variables

on w_aspirantes_reval_nombre.create
this.cb_nfolio=create cb_nfolio
this.cb_ncta=create cb_ncta
this.cb_nom=create cb_nom
this.cb_am=create cb_am
this.cb_ap=create cb_ap
this.dw_nombre=create dw_nombre
this.Control[]={this.cb_nfolio,&
this.cb_ncta,&
this.cb_nom,&
this.cb_am,&
this.cb_ap,&
this.dw_nombre}
end on

on w_aspirantes_reval_nombre.destroy
destroy(this.cb_nfolio)
destroy(this.cb_ncta)
destroy(this.cb_nom)
destroy(this.cb_am)
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

type cb_nfolio from commandbutton within w_aspirantes_reval_nombre
int X=2183
int Y=61
int Width=362
int Height=86
int TabOrder=40
string Text="Folio"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_nombre.setsort("folio")
dw_nombre.sort()
end event

type cb_ncta from commandbutton within w_aspirantes_reval_nombre
int X=1843
int Y=61
int Width=329
int Height=86
int TabOrder=40
string Text="Cuenta"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_nombre.setsort("cuenta")
dw_nombre.sort()
end event

type cb_nom from commandbutton within w_aspirantes_reval_nombre
int X=1247
int Y=61
int Width=585
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

type cb_am from commandbutton within w_aspirantes_reval_nombre
int X=651
int Y=61
int Width=585
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

type cb_ap from commandbutton within w_aspirantes_reval_nombre
int X=55
int Y=61
int Width=585
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

type dw_nombre from datawindow within w_aspirantes_reval_nombre
int X=22
int Y=32
int Width=2651
int Height=848
int TabOrder=50
string DataObject="d_consulta_aspirante_reval"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
end type

event doubleclicked;/*Este evento funciona para realizar el Retrieve de los datos
tras la selección del alumno
*/
long ll_folio
char lch_digito

ll_folio = dw_nombre.getitemnumber(dw_nombre.getrow(),"folio")
lch_digito = obten_digito(ll_folio)

dw_inicio.retrieve(ll_folio)
em_cuenta.text=string(ll_folio)
em_cuenta.triggerevent("activarbusq")
close(w_aspirantes_reval_nombre)
end event

event retrieveend;dw_nombre.setsort("apaterno,amaterno,nombre")
dw_nombre.sort()
end event

