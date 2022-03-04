$PBExportHeader$w_datos_padre.srw
$PBExportComments$Datos del Padre (llamada desde w_datos_generales)
forward
global type w_datos_padre from window
end type
type cb_2 from commandbutton within w_datos_padre
end type
type cb_1 from commandbutton within w_datos_padre
end type
type dw_datos from datawindow within w_datos_padre
end type
type dw_cp from datawindow within w_datos_padre
end type
end forward

global type w_datos_padre from window
integer x = 146
integer y = 680
integer width = 3392
integer height = 1052
boolean titlebar = true
string title = "Datos del Padre o Tutor"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 8421376
cb_2 cb_2
cb_1 cb_1
dw_datos dw_datos
dw_cp dw_cp
end type
global w_datos_padre w_datos_padre

event open;//g_nv_security.fnv_secure_window (this)

dw_datos.settransobject(gtr_sce)

if w_datos_padre.dw_datos.retrieve(long(w_datosgenerales_2013.uo_nombre.em_cuenta.text)) = 0 then
	w_datos_padre.dw_datos.insertrow(0)
	dw_datos.setitem(1,"cuenta",long(w_datosgenerales_2013.uo_nombre.em_cuenta.text))
end if	
end event

on w_datos_padre.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_datos=create dw_datos
this.dw_cp=create dw_cp
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_datos,&
this.dw_cp}
end on

on w_datos_padre.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_datos)
destroy(this.dw_cp)
end on

event close;//close(this)
end event

type cb_2 from commandbutton within w_datos_padre
integer x = 2615
integer y = 792
integer width = 320
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar"
end type

event clicked;if w_datos_padre.dw_datos.update() > 0 then
	commit using gtr_sce;
	messagebox("Información","Se han realizado las modificaciones")
else
	rollback using gtr_sce;
	messagebox("Información","No se han realizado las modificaciones")
end if
end event

type cb_1 from commandbutton within w_datos_padre
integer x = 2999
integer y = 792
integer width = 247
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar"
end type

event clicked;close(w_datos_padre)
end event

type dw_datos from datawindow within w_datos_padre
integer x = 73
integer y = 76
integer width = 3246
integer height = 700
integer taborder = 20
string dataobject = "dw_padre_alumnos"
boolean border = false
end type

event rbuttondown;string calle,colonia,codigo_postal,telefono
int estado 
if isvalid(w_datosgenerales_2013) = true then
	calle = w_datosgenerales_2013.dw_domicilio.getitemstring(w_datosgenerales_2013.dw_domicilio.getrow(),"domicilio_calle",Primary!,False)
	colonia = w_datosgenerales_2013.dw_domicilio.getitemstring(w_datosgenerales_2013.dw_domicilio.getrow(),"domicilio_colonia",Primary!,False)
	codigo_postal = w_datosgenerales_2013.dw_domicilio.getitemstring(w_datosgenerales_2013.dw_domicilio.getrow(),"cod_postal",Primary!,False)
	telefono = w_datosgenerales_2013.dw_domicilio.getitemstring(w_datosgenerales_2013.dw_domicilio.getrow(),"domicilio_telefono",Primary!,False)
	estado = w_datosgenerales_2013.dw_domicilio.getitemnumber(w_datosgenerales_2013.dw_domicilio.getrow(),"domicilio_cve_estado",Primary!,False)
	
	w_datos_padre.dw_datos.setitem(w_datos_padre.dw_datos.getrow(),"calle",calle)
	w_datos_padre.dw_datos.setitem(w_datos_padre.dw_datos.getrow(),"colonia",colonia)
	w_datos_padre.dw_datos.setitem(w_datos_padre.dw_datos.getrow(),"cve_estado",estado)
	w_datos_padre.dw_datos.setitem(w_datos_padre.dw_datos.getrow(),"cod_postal",codigo_postal)
	w_datos_padre.dw_datos.setitem(w_datos_padre.dw_datos.getrow(),"telefono",telefono)
end if
end event

event itemchanged;long columna

columna = getcolumn()

if columna=9 then

	dw_cp.retrieve(data)
	if dw_cp.rowcount()>0 then
		if dw_cp.rowcount()=1 then
			object.colonia[1]=dw_cp.object.colonia[1]+", "+dw_cp.object.ciudad[1]
			object.cve_estado[1]=dw_cp.object.cve_estado[1]
		else
			dw_cp.setfocus()
		end if
	end if	
end if
end event

type dw_cp from datawindow within w_datos_padre
event constructor pbm_constructor
event doubleclicked pbm_dwnlbuttondblclk
event getfocus pbm_dwnsetfocus
event losefocus pbm_dwnkillfocus
integer x = 393
integer y = 180
integer width = 2606
integer height = 488
integer taborder = 11
string dataobject = "dw_codigos_postales"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;hide()
settransobject(gtr_sce)
end event

event doubleclicked;if row>0 then
	dw_datos.object.colonia[1]=object.colonia[row]+", "+object.ciudad[row]
	dw_datos.object.cve_estado[1]=object.cve_estado[row]
	dw_datos.setfocus()
end if

end event

event getfocus;show()
end event

event losefocus;hide()
end event

