$PBExportHeader$w_profesoresnombre.srw
forward
global type w_profesoresnombre from window
end type
type cb_ncta from commandbutton within w_profesoresnombre
end type
type cb_nom from commandbutton within w_profesoresnombre
end type
type cb_am from commandbutton within w_profesoresnombre
end type
type cb_ap from commandbutton within w_profesoresnombre
end type
type dw_nombre from datawindow within w_profesoresnombre
end type
end forward

global type w_profesoresnombre from window
integer x = 466
integer y = 616
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
global w_profesoresnombre w_profesoresnombre

type variables
datawindow dw_inicio
editmask em_cuenta
editmask em_digito
end variables

on w_profesoresnombre.create
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

on w_profesoresnombre.destroy
destroy(this.cb_ncta)
destroy(this.cb_nom)
destroy(this.cb_am)
destroy(this.cb_ap)
destroy(this.dw_nombre)
end on

event open;integer li_settransobject
param_obj_nombre estruct
estruct = message.powerobjectparm
dw_inicio = estruct.nombre
em_cuenta = estruct.cuenta
em_digito = estruct.digito

//if isvalid(this.dw_nombre) then
//	MessageBox("OK Dataobject",this.dw_nombre.dataobject,Information!)
//else
//	MessageBox("ERROR Dataobject",this.dw_nombre.dataobject,Information!)
//end if
//
//if isvalid(gtr_sce) then
//	MessageBox("OK gtr_sce","gtr_sce",Information!)
//else
//	MessageBox("ERROR gtr_sce","gtr_sce",Information!)
//end if

li_settransobject = this.dw_nombre.settransobject(gtr_sce)

if li_settransobject<>1 then
	MessageBox("Error de asignación de Transacción","dw_nombre.settransobject",Information!)
end if


return 1

end event

type cb_ncta from commandbutton within w_profesoresnombre
integer x = 2002
integer y = 60
integer width = 430
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cve. Profesor"
end type

event clicked;dw_nombre.setsort("cve_profesor")
dw_nombre.sort()
end event

type cb_nom from commandbutton within w_profesoresnombre
integer x = 1349
integer y = 60
integer width = 640
integer height = 88
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

type cb_am from commandbutton within w_profesoresnombre
integer x = 699
integer y = 60
integer width = 635
integer height = 88
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

type cb_ap from commandbutton within w_profesoresnombre
integer x = 55
integer y = 60
integer width = 635
integer height = 88
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

type dw_nombre from datawindow within w_profesoresnombre
integer x = 23
integer y = 32
integer width = 2661
integer height = 848
integer taborder = 50
string dataobject = "d_consulta_profesor"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;/*Este evento funciona para realizar el Retrieve de los datos
tras la selección del alumno
*/
long ll_cve_profesor
char lch_digito

ll_cve_profesor = dw_nombre.getitemnumber(dw_nombre.getrow(),"cve_profesor")
lch_digito = obten_digito(ll_cve_profesor)

dw_inicio.retrieve(ll_cve_profesor)
//em_cve_profesor.text=string(ll_cve_profesor)+string(lch_digito)
em_cuenta.text=string(ll_cve_profesor)
em_cuenta.triggerevent("activarbusq")
close(w_profesoresnombre)
end event

event retrieveend;dw_nombre.setsort("apaterno,amaterno,nombre")
dw_nombre.sort()
end event

