﻿$PBExportHeader$conf_impr_documentos.srw
$PBExportComments$Ventana que imprime el DataWindow que se le pasa como parámetro.
forward
global type conf_impr_documentos from window
end type
type sle_nom_arch from singlelineedit within conf_impr_documentos
end type
type cbx_archivo from checkbox within conf_impr_documentos
end type
type st_text from statictext within conf_impr_documentos
end type
type ddlb_pg from dropdownlistbox within conf_impr_documentos
end type
type cb_printer from commandbutton within conf_impr_documentos
end type
type cb_cancel from commandbutton within conf_impr_documentos
end type
type cb_ok from commandbutton within conf_impr_documentos
end type
type st_5 from statictext within conf_impr_documentos
end type
type st_4 from statictext within conf_impr_documentos
end type
type rb_3 from radiobutton within conf_impr_documentos
end type
type rb_2 from radiobutton within conf_impr_documentos
end type
type rb_1 from radiobutton within conf_impr_documentos
end type
type st_3 from statictext within conf_impr_documentos
end type
type st_2 from statictext within conf_impr_documentos
end type
type sle_paginas from singlelineedit within conf_impr_documentos
end type
type em_copia from editmask within conf_impr_documentos
end type
type gb_1 from groupbox within conf_impr_documentos
end type
end forward

global type conf_impr_documentos from window
integer x = 832
integer y = 356
integer width = 1970
integer height = 1276
boolean titlebar = true
string title = "Imprimir"
boolean controlmenu = true
windowtype windowtype = response!
sle_nom_arch sle_nom_arch
cbx_archivo cbx_archivo
st_text st_text
ddlb_pg ddlb_pg
cb_printer cb_printer
cb_cancel cb_cancel
cb_ok cb_ok
st_5 st_5
st_4 st_4
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
st_3 st_3
st_2 st_2
sle_paginas sle_paginas
em_copia em_copia
gb_1 gb_1
end type
global conf_impr_documentos conf_impr_documentos

type variables
datawindow dwp
end variables

on close;//principal.no_vent_imp=false
end on

event open;dwp=message.powerobjectparm
st_text.text= profilestring("win.ini","windows","device","*****")
em_copia.text=String(2)
end event

on conf_impr_documentos.create
this.sle_nom_arch=create sle_nom_arch
this.cbx_archivo=create cbx_archivo
this.st_text=create st_text
this.ddlb_pg=create ddlb_pg
this.cb_printer=create cb_printer
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_5=create st_5
this.st_4=create st_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_3=create st_3
this.st_2=create st_2
this.sle_paginas=create sle_paginas
this.em_copia=create em_copia
this.gb_1=create gb_1
this.Control[]={this.sle_nom_arch,&
this.cbx_archivo,&
this.st_text,&
this.ddlb_pg,&
this.cb_printer,&
this.cb_cancel,&
this.cb_ok,&
this.st_5,&
this.st_4,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.st_3,&
this.st_2,&
this.sle_paginas,&
this.em_copia,&
this.gb_1}
end on

on conf_impr_documentos.destroy
destroy(this.sle_nom_arch)
destroy(this.cbx_archivo)
destroy(this.st_text)
destroy(this.ddlb_pg)
destroy(this.cb_printer)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_paginas)
destroy(this.em_copia)
destroy(this.gb_1)
end on

type sle_nom_arch from singlelineedit within conf_impr_documentos
integer x = 690
integer y = 876
integer width = 494
integer height = 72
integer taborder = 90
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type cbx_archivo from checkbox within conf_impr_documentos
integer x = 123
integer y = 876
integer width = 562
integer height = 76
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Imprimir al archivo:"
end type

type st_text from statictext within conf_impr_documentos
integer x = 558
integer y = 40
integer width = 1317
integer height = 72
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
long bordercolor = 1090519039
boolean focusrectangle = false
end type

type ddlb_pg from dropdownlistbox within conf_impr_documentos
integer x = 667
integer y = 968
integer width = 567
integer height = 260
integer taborder = 80
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean allowedit = true
boolean vscrollbar = true
integer limit = 3
string item[] = {"Todo","Páginas impares","Páginas pares"}
borderstyle borderstyle = stylelowered!
end type

on getfocus;
rb_2.checked=false

end on

type cb_printer from commandbutton within conf_impr_documentos
integer x = 1403
integer y = 720
integer width = 480
integer height = 108
integer taborder = 110
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Impresora"
end type

on clicked;
if printsetup()=1 then
   st_text.text= profilestring("win.ini","windows","device","*****")
end if
end on

type cb_cancel from commandbutton within conf_impr_documentos
integer x = 1403
integer y = 284
integer width = 480
integer height = 108
integer taborder = 100
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancelar"
end type

event clicked;close(PARENT)
end event

type cb_ok from commandbutton within conf_impr_documentos
integer x = 1403
integer y = 136
integer width = 480
integer height = 108
integer taborder = 10
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Aceptar"
end type

event clicked;dwp.modify("DataWindow.print.copies="+em_copia.text)
dwp.modify("DataWindow.print.page.rangeinclude=0")


if rb_1.checked=True then
	dwp.modify("DataWindow.print.page.range=")
elseif rb_2.checked=True then
	dwp.modify("DataWindow.print.page.range='"+string(dwp.getitemnumber(dwp.getrow(),"page"))+"'")  
elseif rb_3.checked=True then
	dwp.modify("DataWindow.print.page.range='"+sle_paginas.text+"'")
end if


if ddlb_pg.text="Todo" then
	dwp.modify("DataWindow.print.page.rangeinclude=0")
elseif ddlb_pg.text="Páginas impares" then
	dwp.modify("DataWindow.print.page.rangeinclude=2")
elseif ddlb_pg.text="Páginas pares" then
	dwp.modify("DataWindow.print.page.rangeinclude=1")
end if

if cbx_archivo.checked = true then
	dwp.modify("DataWindow.print.filename ='"+sle_nom_arch.text+"'")
end if


dwp.print()


close(PARENT)
end event

type st_5 from statictext within conf_impr_documentos
integer x = 174
integer y = 972
integer width = 443
integer height = 72
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "  Imprimir sólo:"
long bordercolor = 33554432
boolean focusrectangle = false
end type

type st_4 from statictext within conf_impr_documentos
integer x = 247
integer y = 680
integer width = 942
integer height = 116
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
string text = "Escriba numeros de página  e/o intervalos  separados por comas. Ejemplo: 1,3,5-12,14"
alignment alignment = right!
long bordercolor = 33554432
boolean focusrectangle = false
end type

type rb_3 from radiobutton within conf_impr_documentos
integer x = 247
integer y = 592
integer width = 329
integer height = 72
integer taborder = 60
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "Páginas :"
end type

on getfocus;sle_paginas.setfocus()
end on

type rb_2 from radiobutton within conf_impr_documentos
integer x = 247
integer y = 492
integer width = 485
integer height = 72
integer taborder = 50
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "Página actual"
end type

on clicked;ddlb_pg.text=""
end on

type rb_1 from radiobutton within conf_impr_documentos
integer x = 247
integer y = 380
integer width = 247
integer height = 72
integer taborder = 40
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "Todo"
end type

type st_3 from statictext within conf_impr_documentos
integer x = 123
integer y = 156
integer width = 306
integer height = 72
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
string text = " Copias"
long bordercolor = 1090519039
boolean focusrectangle = false
end type

type st_2 from statictext within conf_impr_documentos
integer x = 123
integer y = 52
integer width = 306
integer height = 72
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
string text = " Impresora "
long bordercolor = 1090519039
boolean focusrectangle = false
end type

type sle_paginas from singlelineedit within conf_impr_documentos
integer x = 690
integer y = 584
integer width = 494
integer height = 72
integer taborder = 70
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

on getfocus;rb_3.checked=True
end on

type em_copia from editmask within conf_impr_documentos
integer x = 558
integer y = 152
integer width = 393
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "#"
boolean spin = true
string displaydata = ""
double increment = 1
string minmax = "1~~20"
end type

type gb_1 from groupbox within conf_impr_documentos
integer x = 114
integer y = 288
integer width = 1138
integer height = 556
integer taborder = 30
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "Intervalo de página"
end type
