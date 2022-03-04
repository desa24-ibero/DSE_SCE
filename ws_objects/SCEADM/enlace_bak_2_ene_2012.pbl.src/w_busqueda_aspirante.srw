$PBExportHeader$w_busqueda_aspirante.srw
forward
global type w_busqueda_aspirante from window
end type
type dw_1 from datawindow within w_busqueda_aspirante
end type
type cb_buscar from commandbutton within w_busqueda_aspirante
end type
type sle_ape_materno from singlelineedit within w_busqueda_aspirante
end type
type sle_ape_paterno from singlelineedit within w_busqueda_aspirante
end type
type sle_nombre from singlelineedit within w_busqueda_aspirante
end type
type st_3 from statictext within w_busqueda_aspirante
end type
type st_2 from statictext within w_busqueda_aspirante
end type
type st_1 from statictext within w_busqueda_aspirante
end type
type cb_2 from commandbutton within w_busqueda_aspirante
end type
type cb_1 from commandbutton within w_busqueda_aspirante
end type
type gb_1 from groupbox within w_busqueda_aspirante
end type
type gb_2 from groupbox within w_busqueda_aspirante
end type
end forward

global type w_busqueda_aspirante from window
integer width = 2624
integer height = 1552
boolean titlebar = true
string title = "Busqueda de Aspirante por nombre ..."
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_buscar cb_buscar
sle_ape_materno sle_ape_materno
sle_ape_paterno sle_ape_paterno
sle_nombre sle_nombre
st_3 st_3
st_2 st_2
st_1 st_1
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
gb_2 gb_2
end type
global w_busqueda_aspirante w_busqueda_aspirante

type variables
String		is_nombre
String		is_apepaterno
String		is_apematerno

str_aspirante	istr_aspirante
end variables

on w_busqueda_aspirante.create
this.dw_1=create dw_1
this.cb_buscar=create cb_buscar
this.sle_ape_materno=create sle_ape_materno
this.sle_ape_paterno=create sle_ape_paterno
this.sle_nombre=create sle_nombre
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.dw_1,&
this.cb_buscar,&
this.sle_ape_materno,&
this.sle_ape_paterno,&
this.sle_nombre,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_2,&
this.cb_1,&
this.gb_1,&
this.gb_2}
end on

on w_busqueda_aspirante.destroy
destroy(this.dw_1)
destroy(this.cb_buscar)
destroy(this.sle_ape_materno)
destroy(this.sle_ape_paterno)
destroy(this.sle_nombre)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;istr_aspirante = Message.powerObjectparm

dw_1.SetTransObject ( gtr_sadm )

end event

type dw_1 from datawindow within w_busqueda_aspirante
integer x = 64
integer y = 624
integer width = 2459
integer height = 576
integer taborder = 50
string title = "none"
string dataobject = "dw_buscar_aspirante_x_nombre"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;SelectRow ( 0 , False )

SelectRow ( CurrentRow , True )
end event

type cb_buscar from commandbutton within w_busqueda_aspirante
integer x = 2011
integer y = 256
integer width = 343
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Buscar"
end type

event clicked;is_nombre = Trim ( sle_nombre.Text )
is_apepaterno = Trim ( sle_ape_paterno.Text )
is_apematerno = Trim ( sle_ape_materno.Text )

IF IsNull ( is_nombre ) OR is_nombre = "" THEN is_nombre = "*"

IF IsNull ( is_apepaterno ) OR is_apepaterno = "" THEN is_apepaterno = "*"

IF IsNull ( is_apematerno ) OR is_apematerno = "" THEN is_apematerno = "*"

dw_1.Retrieve ( gi_version , gi_periodo , gi_anio , is_nombre , is_apepaterno , is_apematerno )

IF dw_1.RowCount ( ) > 0 THEN
	dw_1.SetFocus ( )
END IF
end event

type sle_ape_materno from singlelineedit within w_busqueda_aspirante
integer x = 594
integer y = 360
integer width = 1294
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type sle_ape_paterno from singlelineedit within w_busqueda_aspirante
integer x = 594
integer y = 264
integer width = 1294
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type sle_nombre from singlelineedit within w_busqueda_aspirante
integer x = 594
integer y = 168
integer width = 1294
integer height = 88
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_busqueda_aspirante
integer x = 110
integer y = 376
integer width = 421
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Apellido &Materno:"
boolean focusrectangle = false
end type

event getfocus;sle_ape_materno.SetFocus ( )
end event

type st_2 from statictext within w_busqueda_aspirante
integer x = 110
integer y = 284
integer width = 411
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Apellido &Paterno:"
boolean focusrectangle = false
end type

event getfocus;sle_ape_materno.SetFocus ( )
end event

type st_1 from statictext within w_busqueda_aspirante
integer x = 110
integer y = 192
integer width = 265
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Nombre:"
boolean focusrectangle = false
end type

event getfocus;sle_nombre.SetFocus ( )
end event

type cb_2 from commandbutton within w_busqueda_aspirante
integer x = 1408
integer y = 1304
integer width = 402
integer height = 112
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;istr_aspirante.folio = 0

CloseWithReturn ( Parent , istr_aspirante )
end event

type cb_1 from commandbutton within w_busqueda_aspirante
integer x = 827
integer y = 1304
integer width = 402
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Aceptar"
end type

event clicked;IF dw_1.RowCount ( ) > 0 THEN
	istr_aspirante.folio		= dw_1.Object.folio [ dw_1.GetRow ( ) ]
	istr_aspirante.clv_ver	= dw_1.Object.aspiran_clv_ver [ dw_1.GetRow ( ) ]
	CloseWithReturn ( Parent , istr_aspirante )
END IF
end event

type gb_1 from groupbox within w_busqueda_aspirante
integer x = 46
integer y = 92
integer width = 2510
integer height = 408
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Aspirante:"
end type

type gb_2 from groupbox within w_busqueda_aspirante
integer x = 46
integer y = 524
integer width = 2510
integer height = 708
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Aspirante (s) encontrado(s) :"
end type

