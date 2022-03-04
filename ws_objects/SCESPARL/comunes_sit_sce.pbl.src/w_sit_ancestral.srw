$PBExportHeader$w_sit_ancestral.srw
$PBExportComments$Ventana Ancestro para todos los procesos del sistema. J.C.S
forward
global type w_sit_ancestral from w_master
end type
type st_1 from statictext within w_sit_ancestral
end type
type p_1 from picture within w_sit_ancestral
end type
end forward

global type w_sit_ancestral from w_master
integer width = 3648
integer height = 2040
boolean hscrollbar = true
boolean vscrollbar = true
windowstate windowstate = maximized!
long backcolor = 29534863
string icon = "Window!"
boolean righttoleft = true
boolean clientedge = true
event ue_periodo ( )
st_1 st_1
p_1 p_1
end type
global w_sit_ancestral w_sit_ancestral

type variables
integer ii_periodo, ii_anio
end variables

event ue_periodo;// Cambio de Periodo
end event

event open;// Juan Campos Sánchez
// Julio-2001.

x	=	1
y	=	1

// Inicia Seguridad
gnv_app.inv_security.of_SetSecurity(this)


//J:\Codigo Fuente Nuevo 7.0\uiafondo.bmp
end event

on w_sit_ancestral.create
int iCurrent
call super::create
this.st_1=create st_1
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.p_1
end on

on w_sit_ancestral.destroy
call super::destroy
destroy(this.st_1)
destroy(this.p_1)
end on

type st_1 from statictext within w_sit_ancestral
integer x = 338
integer y = 48
integer width = 1458
integer height = 112
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 29534863
string text = "Sistema Integral de Tesorería"
long bordercolor = 8388608
boolean focusrectangle = false
end type

type p_1 from picture within w_sit_ancestral
integer width = 288
integer height = 204
string picturename = "uiafondo.bmp"
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

event constructor;this.PictureName = gs_path_ini+ "uiafondo.bmp"
end event

