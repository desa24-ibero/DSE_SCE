$PBExportHeader$w_busqueda_2013.srw
forward
global type w_busqueda_2013 from window
end type
type dw_desc from datawindow within w_busqueda_2013
end type
type cbx_bus from checkbox within w_busqueda_2013
end type
type st_1 from statictext within w_busqueda_2013
end type
type dw_busqueda from datawindow within w_busqueda_2013
end type
end forward

global type w_busqueda_2013 from window
integer x = 517
integer y = 600
integer width = 2624
integer height = 1204
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 16777215
dw_desc dw_desc
cbx_bus cbx_bus
st_1 st_1
dw_busqueda dw_busqueda
end type
global w_busqueda_2013 w_busqueda_2013

on w_busqueda_2013.create
this.dw_desc=create dw_desc
this.cbx_bus=create cbx_bus
this.st_1=create st_1
this.dw_busqueda=create dw_busqueda
this.Control[]={this.dw_desc,&
this.cbx_bus,&
this.st_1,&
this.dw_busqueda}
end on

on w_busqueda_2013.destroy
destroy(this.dw_desc)
destroy(this.cbx_bus)
destroy(this.st_1)
destroy(this.dw_busqueda)
end on

event open;string objeto

objeto = message.stringparm

if objeto = "carrera" then
	dw_busqueda.dataobject = "dw_carr_bus_2013"
	ok=0
elseif objeto ="escuela" then
	dw_busqueda.dataobject = "dw_esc_bus_2013"
	ok=222
end if

dw_busqueda.settransobject(gtr_sce)
dw_desc.insertrow(0)
end event

type dw_desc from datawindow within w_busqueda_2013
integer x = 466
integer y = 104
integer width = 1691
integer height = 120
integer taborder = 10
string dataobject = "dw_editor_2013"
boolean border = false
boolean livescroll = true
end type

event editchanged;string desc
accepttext()

if cbx_bus.checked = true then
	desc = "%"+getitemstring(getrow(),1)+"%"
	
else
	desc = getitemstring(getrow(),1)+"%"
	
end if

dw_busqueda.retrieve(desc)
end event

type cbx_bus from checkbox within w_busqueda_2013
integer x = 1152
integer y = 16
integer width = 960
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "Busqueda de Palabra Intermedia "
boolean checked = true
end type

type st_1 from statictext within w_busqueda_2013
integer x = 165
integer y = 108
integer width = 293
integer height = 92
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Nombre:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_busqueda from datawindow within w_busqueda_2013
integer y = 240
integer width = 2601
integer height = 836
string dataobject = "dw_esc_bus_2013"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;ok=object.clave[row]
close(w_busqueda_2013)
end event

