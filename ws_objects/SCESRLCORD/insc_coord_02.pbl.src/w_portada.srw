$PBExportHeader$w_portada.srw
$PBExportComments$Portada del Sistema de Control Escolar
forward
global type w_portada from window
end type
type st_5 from statictext within w_portada
end type
type p_uia from picture within w_portada
end type
type st_4 from statictext within w_portada
end type
type st_3 from statictext within w_portada
end type
type st_2 from statictext within w_portada
end type
type st_1 from statictext within w_portada
end type
type p_sce from picture within w_portada
end type
type st_uia from statictext within w_portada
end type
type st_6 from statictext within w_portada
end type
type r_1 from rectangle within w_portada
end type
end forward

global type w_portada from window
integer x = 832
integer y = 356
integer width = 1573
integer height = 1824
windowtype windowtype = response!
long backcolor = 0
string icon = "reinscripcion.ico"
st_5 st_5
p_uia p_uia
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
p_sce p_sce
st_uia st_uia
st_6 st_6
r_1 r_1
end type
global w_portada w_portada

on w_portada.create
this.st_5=create st_5
this.p_uia=create p_uia
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.p_sce=create p_sce
this.st_uia=create st_uia
this.st_6=create st_6
this.r_1=create r_1
this.Control[]={this.st_5,&
this.p_uia,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.p_sce,&
this.st_uia,&
this.st_6,&
this.r_1}
end on

on w_portada.destroy
destroy(this.st_5)
destroy(this.p_uia)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.p_sce)
destroy(this.st_uia)
destroy(this.st_6)
destroy(this.r_1)
end on

event timer;setpointer(Hourglass!)
timer(.20,w_portada)
close(w_portada)

end event

event open;
timer(3,w_portada)
end event

type st_5 from statictext within w_portada
integer x = 462
integer y = 1616
integer width = 667
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 0
boolean enabled = false
string text = "Antonio Pica Ruiz"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_uia from picture within w_portada
integer x = 169
integer y = 68
integer width = 110
integer height = 92
boolean originalsize = true
string picturename = "uia2.bmp"
boolean focusrectangle = false
end type

type st_4 from statictext within w_portada
integer x = 242
integer y = 1688
integer width = 1065
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 0
boolean enabled = false
string text = "CAMP"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_portada
integer x = 462
integer y = 1548
integer width = 667
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 0
boolean enabled = false
string text = " Fantine Medina Carrillo "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_portada
integer x = 699
integer y = 1476
integer width = 151
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 0
boolean enabled = false
string text = "por"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_portada
integer x = 123
integer y = 1412
integer width = 1125
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 0
boolean enabled = false
string text = "S.R.L Versión Verano 2009  01/06/09"
alignment alignment = center!
long bordercolor = 15793151
boolean focusrectangle = false
end type

type p_sce from picture within w_portada
integer x = 69
integer y = 364
integer width = 1413
integer height = 1012
string picturename = "scep.bmp"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_uia from statictext within w_portada
integer x = 69
integer y = 44
integer width = 1413
integer height = 284
integer textsize = -22
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15780518
long backcolor = 0
boolean enabled = false
string text = "UNIVERSIDAD IBEROAMERICANA"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_6 from statictext within w_portada
integer x = 69
integer y = 1392
integer width = 1353
integer height = 404
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 0
boolean enabled = false
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type r_1 from rectangle within w_portada
long linecolor = 16711680
integer linethickness = 3
long fillcolor = 255
integer x = 1458
integer y = 1724
integer width = 87
integer height = 76
end type

