$PBExportHeader$w_aspirantesnombre_p_insc.srw
$PBExportComments$Ventana utilizada para presentar diversas posibilidades de aspirantes con el mismo nombre o apellidos. Usada para seleccionar uno.
forward
global type w_aspirantesnombre_p_insc from window
end type
type cb_ncta from commandbutton within w_aspirantesnombre_p_insc
end type
type cb_nom from commandbutton within w_aspirantesnombre_p_insc
end type
type cb_am from commandbutton within w_aspirantesnombre_p_insc
end type
type cb_ap from commandbutton within w_aspirantesnombre_p_insc
end type
type dw_nombre from datawindow within w_aspirantesnombre_p_insc
end type
end forward

global type w_aspirantesnombre_p_insc from window
integer x = 197
integer y = 742
integer width = 3288
integer height = 890
windowtype windowtype = child!
long backcolor = 79741120
cb_ncta cb_ncta
cb_nom cb_nom
cb_am cb_am
cb_ap cb_ap
dw_nombre dw_nombre
end type
global w_aspirantesnombre_p_insc w_aspirantesnombre_p_insc

type variables
datawindow dw_inicio
long folio
editmask em_cuenta
end variables

on w_aspirantesnombre_p_insc.create
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

on w_aspirantesnombre_p_insc.destroy
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

type cb_ncta from commandbutton within w_aspirantesnombre_p_insc
boolean visible = false
integer x = 2816
integer y = 58
integer width = 369
integer height = 86
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Folio"
end type

event clicked;/*Ordena el dw*/
dw_nombre.setsort("folio")
dw_nombre.sort()
end event

type cb_nom from commandbutton within w_aspirantesnombre_p_insc
boolean visible = false
integer x = 1898
integer y = 58
integer width = 896
integer height = 86
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Nombre"
end type

event clicked;/*Ordena el dw*/
dw_nombre.setsort("nombre")
dw_nombre.sort()
end event

type cb_am from commandbutton within w_aspirantesnombre_p_insc
boolean visible = false
integer x = 980
integer y = 61
integer width = 896
integer height = 86
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Apellido Materno"
end type

event clicked;/*Ordena el dw*/
dw_nombre.setsort("amaterno")
dw_nombre.sort()
end event

type cb_ap from commandbutton within w_aspirantesnombre_p_insc
boolean visible = false
integer x = 59
integer y = 61
integer width = 896
integer height = 86
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Apellido Paterno"
end type

event clicked;/*Ordena el dw*/
dw_nombre.setsort("apaterno")
dw_nombre.sort()
end event

type dw_nombre from datawindow within w_aspirantesnombre_p_insc
event type integer carga ( string nombre,  string apat,  string amat )
integer x = 22
integer y = 26
integer width = 3237
integer height = 848
string dataobject = "dw_consulta_aspirante_p_insc"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
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

