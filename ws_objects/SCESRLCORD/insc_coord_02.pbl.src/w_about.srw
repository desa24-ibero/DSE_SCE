$PBExportHeader$w_about.srw
forward
global type w_about from window
end type
type st_n3 from statictext within w_about
end type
type p_uia from picture within w_about
end type
type st_dir_info from statictext within w_about
end type
type st_3 from statictext within w_about
end type
type cb_1 from commandbutton within w_about
end type
type st_1 from statictext within w_about
end type
type r_1 from rectangle within w_about
end type
type gb_1 from groupbox within w_about
end type
end forward

global type w_about from window
integer x = 1120
integer y = 688
integer width = 1248
integer height = 976
boolean titlebar = true
string title = "Acerca de Sistema de Reinscripción en Línea para Coordinaciones"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 31641519
st_n3 st_n3
p_uia p_uia
st_dir_info st_dir_info
st_3 st_3
cb_1 cb_1
st_1 st_1
r_1 r_1
gb_1 gb_1
end type
global w_about w_about

on w_about.create
this.st_n3=create st_n3
this.p_uia=create p_uia
this.st_dir_info=create st_dir_info
this.st_3=create st_3
this.cb_1=create cb_1
this.st_1=create st_1
this.r_1=create r_1
this.gb_1=create gb_1
this.Control[]={this.st_n3,&
this.p_uia,&
this.st_dir_info,&
this.st_3,&
this.cb_1,&
this.st_1,&
this.r_1,&
this.gb_1}
end on

on w_about.destroy
destroy(this.st_n3)
destroy(this.p_uia)
destroy(this.st_dir_info)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.r_1)
destroy(this.gb_1)
end on

event open;X = 1121
Y = 501
end event

type st_n3 from statictext within w_about
integer x = 197
integer y = 404
integer width = 855
integer height = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 31641519
boolean enabled = false
string text = "Antonio Pica Ruiz"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_uia from picture within w_about
integer x = 567
integer y = 64
integer width = 110
integer height = 92
boolean originalsize = true
string picturename = "uia2.bmp"
boolean focusrectangle = false
end type

type st_dir_info from statictext within w_about
integer x = 297
integer y = 596
integer width = 686
integer height = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 31641519
boolean enabled = false
string text = "Dirección de Informática"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_about
integer x = 361
integer y = 500
integer width = 526
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 31641519
boolean enabled = false
string text = "Verano 2009"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_about
integer x = 498
integer y = 732
integer width = 247
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;close(w_about)
end event

type st_1 from statictext within w_about
integer x = 82
integer y = 176
integer width = 1047
integer height = 204
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 31641519
boolean enabled = false
string text = "Sistema de Reinscripción en Línea para Coordinaciones Versión 01/06/09 Desarrollado por "
alignment alignment = center!
boolean focusrectangle = false
end type

type r_1 from rectangle within w_about
long linecolor = 16711680
integer linethickness = 3
long fillcolor = 255
integer x = 1125
integer y = 800
integer width = 87
integer height = 76
end type

type gb_1 from groupbox within w_about
integer x = 27
integer y = 4
integer width = 1175
integer height = 692
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 31641519
end type

