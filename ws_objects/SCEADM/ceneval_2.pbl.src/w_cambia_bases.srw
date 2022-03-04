$PBExportHeader$w_cambia_bases.srw
forward
global type w_cambia_bases from Window
end type
type sle_nombre_folio from singlelineedit within w_cambia_bases
end type
type sle_nombre_cuenta from singlelineedit within w_cambia_bases
end type
type em_folio from editmask within w_cambia_bases
end type
type em_cuenta from editmask within w_cambia_bases
end type
type cb_3 from commandbutton within w_cambia_bases
end type
type cb_2 from commandbutton within w_cambia_bases
end type
type cb_1 from commandbutton within w_cambia_bases
end type
type cb_admision from commandbutton within w_cambia_bases
end type
type sle_1 from singlelineedit within w_cambia_bases
end type
type cb_controlescolar from commandbutton within w_cambia_bases
end type
end forward

global type w_cambia_bases from Window
int X=845
int Y=371
int Width=2176
int Height=1395
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
sle_nombre_folio sle_nombre_folio
sle_nombre_cuenta sle_nombre_cuenta
em_folio em_folio
em_cuenta em_cuenta
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
cb_admision cb_admision
sle_1 sle_1
cb_controlescolar cb_controlescolar
end type
global w_cambia_bases w_cambia_bases

on w_cambia_bases.create
this.sle_nombre_folio=create sle_nombre_folio
this.sle_nombre_cuenta=create sle_nombre_cuenta
this.em_folio=create em_folio
this.em_cuenta=create em_cuenta
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_admision=create cb_admision
this.sle_1=create sle_1
this.cb_controlescolar=create cb_controlescolar
this.Control[]={this.sle_nombre_folio,&
this.sle_nombre_cuenta,&
this.em_folio,&
this.em_cuenta,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.cb_admision,&
this.sle_1,&
this.cb_controlescolar}
end on

on w_cambia_bases.destroy
destroy(this.sle_nombre_folio)
destroy(this.sle_nombre_cuenta)
destroy(this.em_folio)
destroy(this.em_cuenta)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_admision)
destroy(this.sle_1)
destroy(this.cb_controlescolar)
end on

type sle_nombre_folio from singlelineedit within w_cambia_bases
int X=947
int Y=1101
int Width=633
int Height=96
int TabOrder=80
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_nombre_cuenta from singlelineedit within w_cambia_bases
int X=205
int Y=1094
int Width=633
int Height=96
int TabOrder=70
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_folio from editmask within w_cambia_bases
int X=1104
int Y=781
int Width=318
int Height=99
int TabOrder=40
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="######"
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_cuenta from editmask within w_cambia_bases
int X=362
int Y=778
int Width=318
int Height=99
int TabOrder=50
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="######"
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_3 from commandbutton within w_cambia_bases
int X=1137
int Y=896
int Width=252
int Height=106
int TabOrder=80
string Text="Folio"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long folio
string ls_nombre

folio = long(em_folio.text)

of_obten_nombre_folio(folio,ls_nombre)


sle_nombre_folio.text= ls_nombre
end event

type cb_2 from commandbutton within w_cambia_bases
int X=395
int Y=896
int Width=252
int Height=106
int TabOrder=60
string Text="Cuenta"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long cuenta
string ls_nombre

cuenta = long(em_cuenta.text)

of_obten_nombre_cuenta(cuenta,ls_nombre)

sle_nombre_cuenta.text= ls_nombre


end event

type cb_1 from commandbutton within w_cambia_bases
int X=695
int Y=125
int Width=450
int Height=106
int TabOrder=10
string Text="Base de Datos"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;sle_1.text = of_obten_nombre_base()

end event

type cb_admision from commandbutton within w_cambia_bases
int X=1042
int Y=419
int Width=304
int Height=106
int TabOrder=30
string Text="Admisión"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;of_cambia_de_base("admision_bd")
sle_1.text = of_obten_nombre_base()

end event

type sle_1 from singlelineedit within w_cambia_bases
int X=658
int Y=259
int Width=541
int Height=96
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_controlescolar from commandbutton within w_cambia_bases
int X=435
int Y=419
int Width=252
int Height=106
int TabOrder=90
string Text="Control"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
of_cambia_de_base("controlescolar_bd")
sle_1.text = of_obten_nombre_base()

end event

