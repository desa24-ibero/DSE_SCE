$PBExportHeader$conf_impr.srw
$PBExportComments$Ventana que imprime el DataWindow que se le pasa como parámetro.
forward
global type conf_impr from Window
end type
type sle_nom_arch from singlelineedit within conf_impr
end type
type cbx_archivo from checkbox within conf_impr
end type
type st_text from statictext within conf_impr
end type
type ddlb_pg from dropdownlistbox within conf_impr
end type
type cb_printer from commandbutton within conf_impr
end type
type cb_cancel from commandbutton within conf_impr
end type
type cb_ok from commandbutton within conf_impr
end type
type st_5 from statictext within conf_impr
end type
type st_4 from statictext within conf_impr
end type
type rb_3 from radiobutton within conf_impr
end type
type rb_2 from radiobutton within conf_impr
end type
type rb_1 from radiobutton within conf_impr
end type
type st_3 from statictext within conf_impr
end type
type st_2 from statictext within conf_impr
end type
type sle_paginas from singlelineedit within conf_impr
end type
type em_copia from editmask within conf_impr
end type
type gb_1 from groupbox within conf_impr
end type
end forward

global type conf_impr from Window
int X=832
int Y=356
int Width=1970
int Height=1276
boolean TitleBar=true
string Title="Imprimir"
boolean ControlMenu=true
WindowType WindowType=response!
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
global conf_impr conf_impr

type variables
datawindow dwp
end variables

on close;//principal.no_vent_imp=false
end on

event open;dwp=message.powerobjectparm
st_text.text= profilestring("win.ini","windows","device","*****")
em_copia.text=String(1)
end event

on conf_impr.create
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

on conf_impr.destroy
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

type sle_nom_arch from singlelineedit within conf_impr
int X=690
int Y=876
int Width=494
int Height=72
int TabOrder=90
BorderStyle BorderStyle=StyleLowered!
TextCase TextCase=Upper!
long TextColor=33554432
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_archivo from checkbox within conf_impr
int X=123
int Y=876
int Width=562
int Height=76
string Text="Imprimir al archivo:"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_text from statictext within conf_impr
int X=558
int Y=40
int Width=1317
int Height=72
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=33554432
long BorderColor=1090519039
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_pg from dropdownlistbox within conf_impr
int X=667
int Y=968
int Width=567
int Height=260
int TabOrder=80
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean AllowEdit=true
int Limit=3
long TextColor=33554432
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Todo",&
"Páginas impares",&
"Páginas pares"}
end type

on getfocus;
rb_2.checked=false

end on

type cb_printer from commandbutton within conf_impr
int X=1403
int Y=720
int Width=480
int Height=108
int TabOrder=110
string Text="Impresora"
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;
if printsetup()=1 then
   st_text.text= profilestring("win.ini","windows","device","*****")
end if
end on

type cb_cancel from commandbutton within conf_impr
int X=1403
int Y=284
int Width=480
int Height=108
int TabOrder=100
string Text="Cancelar"
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close(conf_impr)
end on

type cb_ok from commandbutton within conf_impr
int X=1403
int Y=136
int Width=480
int Height=108
int TabOrder=10
string Text="Aceptar"
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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

dwp.modify("DataWindow.print.Preview =No")


close(conf_impr)
end event

type st_5 from statictext within conf_impr
int X=174
int Y=972
int Width=443
int Height=72
boolean Enabled=false
string Text="  Imprimir sólo:"
boolean FocusRectangle=false
long TextColor=33554432
long BorderColor=33554432
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within conf_impr
int X=247
int Y=680
int Width=942
int Height=116
boolean Enabled=false
string Text="Escriba numeros de página  e/o intervalos  separados por comas. Ejemplo: 1,3,5-12,14"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BorderColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_3 from radiobutton within conf_impr
int X=247
int Y=592
int Width=329
int Height=72
int TabOrder=60
string Text="Páginas :"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on getfocus;sle_paginas.setfocus()
end on

type rb_2 from radiobutton within conf_impr
int X=247
int Y=492
int Width=485
int Height=72
int TabOrder=50
string Text="Página actual"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;ddlb_pg.text=""
end on

type rb_1 from radiobutton within conf_impr
int X=247
int Y=380
int Width=247
int Height=72
int TabOrder=40
string Text="Todo"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within conf_impr
int X=123
int Y=156
int Width=306
int Height=72
boolean Enabled=false
string Text=" Copias"
boolean FocusRectangle=false
long TextColor=33554432
long BorderColor=1090519039
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within conf_impr
int X=123
int Y=52
int Width=306
int Height=72
boolean Enabled=false
string Text=" Impresora "
boolean FocusRectangle=false
long TextColor=33554432
long BorderColor=1090519039
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_paginas from singlelineedit within conf_impr
int X=690
int Y=584
int Width=494
int Height=72
int TabOrder=70
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on getfocus;rb_3.checked=True
end on

type em_copia from editmask within conf_impr
int X=558
int Y=152
int Width=393
int Height=96
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
string Mask="#"
boolean Spin=true
string DisplayData=""
double Increment=1
string MinMax="1~~20"
long TextColor=33554432
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within conf_impr
int X=114
int Y=288
int Width=1138
int Height=556
int TabOrder=30
string Text="Intervalo de página"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

