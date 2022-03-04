$PBExportHeader$w_confirma_fecha.srw
forward
global type w_confirma_fecha from window
end type
type cb_1 from commandbutton within w_confirma_fecha
end type
type st_1 from statictext within w_confirma_fecha
end type
type em_fecha from editmask within w_confirma_fecha
end type
end forward

global type w_confirma_fecha from window
integer width = 1339
integer height = 464
boolean titlebar = true
string title = "Fecha de ejecución"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
st_1 st_1
em_fecha em_fecha
end type
global w_confirma_fecha w_confirma_fecha

event open;
em_fecha.TEXT = STRING(DATE(TODAY()), "dd/mm/yyyy") 



end event

on w_confirma_fecha.create
this.cb_1=create cb_1
this.st_1=create st_1
this.em_fecha=create em_fecha
this.Control[]={this.cb_1,&
this.st_1,&
this.em_fecha}
end on

on w_confirma_fecha.destroy
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.em_fecha)
end on

type cb_1 from commandbutton within w_confirma_fecha
integer x = 805
integer y = 220
integer width = 457
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Aceptar"
end type

event clicked;
gf_fecha_ejecucion = DATE(em_fecha.TEXT) 

CLOSE(PARENT) 




end event

type st_1 from statictext within w_confirma_fecha
integer x = 110
integer y = 92
integer width = 709
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha que se procesa: "
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fecha from editmask within w_confirma_fecha
integer x = 841
integer y = 68
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

