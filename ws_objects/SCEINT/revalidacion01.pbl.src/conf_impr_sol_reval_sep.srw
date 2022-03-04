$PBExportHeader$conf_impr_sol_reval_sep.srw
forward
global type conf_impr_sol_reval_sep from Window
end type
type sle_nom_arch from singlelineedit within conf_impr_sol_reval_sep
end type
type cbx_archivo from checkbox within conf_impr_sol_reval_sep
end type
type st_text from statictext within conf_impr_sol_reval_sep
end type
type ddlb_pg from dropdownlistbox within conf_impr_sol_reval_sep
end type
type cb_printer from commandbutton within conf_impr_sol_reval_sep
end type
type cb_cancel from commandbutton within conf_impr_sol_reval_sep
end type
type cb_ok from commandbutton within conf_impr_sol_reval_sep
end type
type st_5 from statictext within conf_impr_sol_reval_sep
end type
type st_4 from statictext within conf_impr_sol_reval_sep
end type
type rb_3 from radiobutton within conf_impr_sol_reval_sep
end type
type rb_2 from radiobutton within conf_impr_sol_reval_sep
end type
type rb_1 from radiobutton within conf_impr_sol_reval_sep
end type
type st_3 from statictext within conf_impr_sol_reval_sep
end type
type st_2 from statictext within conf_impr_sol_reval_sep
end type
type sle_paginas from singlelineedit within conf_impr_sol_reval_sep
end type
type em_copia from editmask within conf_impr_sol_reval_sep
end type
type gb_1 from groupbox within conf_impr_sol_reval_sep
end type
end forward

global type conf_impr_sol_reval_sep from Window
int X=834
int Y=355
int Width=1971
int Height=1277
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
global conf_impr_sol_reval_sep conf_impr_sol_reval_sep

type variables
datawindow dwp
str_imp_sol_reval_sep  istr_sol_reval_sep
end variables

on close;//principal.no_vent_imp=false
end on

event open;istr_sol_reval_sep= message.powerobjectparm
dwp = istr_sol_reval_sep.sdw_datawindow

//dwp = message.powerobjectparm
st_text.text= profilestring("win.ini","windows","device","*****")
em_copia.text=String(1)
end event

on conf_impr_sol_reval_sep.create
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

on conf_impr_sol_reval_sep.destroy
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

type sle_nom_arch from singlelineedit within conf_impr_sol_reval_sep
int X=691
int Y=877
int Width=494
int Height=74
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

type cbx_archivo from checkbox within conf_impr_sol_reval_sep
int X=124
int Y=877
int Width=563
int Height=77
string Text="Imprimir al archivo:"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_text from statictext within conf_impr_sol_reval_sep
int X=560
int Y=42
int Width=1317
int Height=74
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

type ddlb_pg from dropdownlistbox within conf_impr_sol_reval_sep
int X=666
int Y=970
int Width=567
int Height=259
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

type cb_printer from commandbutton within conf_impr_sol_reval_sep
int X=1404
int Y=720
int Width=479
int Height=109
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

type cb_cancel from commandbutton within conf_impr_sol_reval_sep
int X=1404
int Y=285
int Width=479
int Height=109
int TabOrder=100
string Text="Cancelar"
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(conf_impr_sol_reval_sep)

end event

type cb_ok from commandbutton within conf_impr_sol_reval_sep
int X=1404
int Y=138
int Width=479
int Height=109
int TabOrder=10
string Text="Aceptar"
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_res_imp, li_num_constancia
long	ll_folio, ll_folio_reval_sep
string ls_cuenta, ls_folio_reval_sep

dwp.modify("DataWindow.print.copies="+em_copia.text)
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




ls_cuenta = istr_sol_reval_sep.suo_user_object.em_cuenta.text
ll_folio = long(ls_cuenta)
ll_folio_reval_sep= f_inserta_folio_reval_sep(ll_folio)
//istr_constancias.sw_window.event "busqueda_simple" ll_folio_reval_sep)
ls_folio_reval_sep= string(ll_folio_reval_sep)
dwp.object.st_folio.text = ls_folio_reval_sep

li_res_imp = dwp.print()


close(conf_impr_sol_reval_sep)


end event

type st_5 from statictext within conf_impr_sol_reval_sep
int X=176
int Y=973
int Width=443
int Height=74
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

type st_4 from statictext within conf_impr_sol_reval_sep
int X=249
int Y=682
int Width=944
int Height=115
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

type rb_3 from radiobutton within conf_impr_sol_reval_sep
int X=249
int Y=592
int Width=329
int Height=74
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

type rb_2 from radiobutton within conf_impr_sol_reval_sep
int X=249
int Y=493
int Width=486
int Height=74
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

type rb_1 from radiobutton within conf_impr_sol_reval_sep
int X=249
int Y=381
int Width=249
int Height=74
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

type st_3 from statictext within conf_impr_sol_reval_sep
int X=124
int Y=157
int Width=307
int Height=74
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

type st_2 from statictext within conf_impr_sol_reval_sep
int X=124
int Y=51
int Width=307
int Height=74
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

type sle_paginas from singlelineedit within conf_impr_sol_reval_sep
int X=691
int Y=586
int Width=494
int Height=74
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

type em_copia from editmask within conf_impr_sol_reval_sep
int X=560
int Y=154
int Width=391
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

type gb_1 from groupbox within conf_impr_sol_reval_sep
int X=113
int Y=288
int Width=1137
int Height=557
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

