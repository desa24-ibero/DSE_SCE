$PBExportHeader$w_cat_carreras.srw
forward
global type w_cat_carreras from w_catalogo
end type
type p_1 from picture within w_cat_carreras
end type
type st_1 from statictext within w_cat_carreras
end type
end forward

global type w_cat_carreras from w_catalogo
integer x = 5
integer y = 8
integer width = 4027
integer height = 2752
long backcolor = 16777215
p_1 p_1
st_1 st_1
end type
global w_cat_carreras w_cat_carreras

on w_cat_carreras.create
int iCurrent
call super::create
this.p_1=create p_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.st_1
end on

on w_cat_carreras.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.p_1)
destroy(this.st_1)
end on

event activate;call super::activate;control_escolar.toolbarsheettitle="Carreras"
end event

event open;call super::open;//g_nv_security.fnv_secure_window (this)

p_1.PictureName = gs_logo
end event

event close;call super::close;//close(this)
end event

type dw_catalogo from w_catalogo`dw_catalogo within w_cat_carreras
integer x = 9
integer y = 320
integer width = 3922
integer height = 2208
string dataobject = "dw_cat_carrera_2013"
boolean hscrollbar = true
borderstyle borderstyle = styleraised!
end type

event dw_catalogo::constructor;call super::constructor;this.SetRowFocusIndicator(Hand!)
end event

type p_1 from picture within w_cat_carreras
integer x = 23
integer y = 36
integer width = 681
integer height = 264
boolean bringtotop = true
string picturename = "logoibero-web.png"
boolean focusrectangle = false
end type

type st_1 from statictext within w_cat_carreras
integer x = 722
integer y = 116
integer width = 192
integer height = 88
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 16777215
string text = "DSE"
boolean focusrectangle = false
end type

