$PBExportHeader$w_alumnosnombre.srw
$PBExportComments$Ventana utilizada para presentar diversas posibilidades de alumnos con el mismo nombre o apellidos. Usada para seleccionar uno.
forward
global type w_alumnosnombre from window
end type
type cb_ncta from commandbutton within w_alumnosnombre
end type
type cb_nom from commandbutton within w_alumnosnombre
end type
type cb_am from commandbutton within w_alumnosnombre
end type
type cb_ap from commandbutton within w_alumnosnombre
end type
type dw_nombre from datawindow within w_alumnosnombre
end type
end forward

global type w_alumnosnombre from window
integer x = 466
integer y = 612
integer width = 2770
integer height = 1036
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
cb_ncta cb_ncta
cb_nom cb_nom
cb_am cb_am
cb_ap cb_ap
dw_nombre dw_nombre
end type
global w_alumnosnombre w_alumnosnombre

type variables
datawindow dw_inicio
editmask em_cuenta
editmask em_digito
end variables

on w_alumnosnombre.create
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

on w_alumnosnombre.destroy
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
dw_nombre.settransobject(sqlca)
end event

type cb_ncta from commandbutton within w_alumnosnombre
integer x = 2002
integer y = 60
integer width = 425
integer height = 84
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "No. de Cuenta"
end type

event clicked;dw_nombre.setsort("cuenta")
dw_nombre.sort()
end event

type cb_nom from commandbutton within w_alumnosnombre
integer x = 1349
integer y = 60
integer width = 640
integer height = 84
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Nombre"
end type

event clicked;dw_nombre.setsort("nombre")
dw_nombre.sort()
end event

type cb_am from commandbutton within w_alumnosnombre
integer x = 699
integer y = 60
integer width = 635
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Apellido Materno"
end type

event clicked;dw_nombre.setsort("amaterno")
dw_nombre.sort()
end event

type cb_ap from commandbutton within w_alumnosnombre
integer x = 55
integer y = 60
integer width = 635
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Apellido Paterno"
end type

event clicked;dw_nombre.setsort("apaterno")
dw_nombre.sort()
end event

type dw_nombre from datawindow within w_alumnosnombre
integer x = 23
integer y = 32
integer width = 2656
integer height = 848
integer taborder = 50
string dataobject = "dw_consulta_alumno"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
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
close(w_alumnosnombre)
end event

event retrieveend;dw_nombre.setsort("apaterno,amaterno,nombre")
dw_nombre.sort()
end event

