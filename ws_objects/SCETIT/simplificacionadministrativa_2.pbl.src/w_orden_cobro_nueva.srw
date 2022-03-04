$PBExportHeader$w_orden_cobro_nueva.srw
forward
global type w_orden_cobro_nueva from Window
end type
type cb_cancelar from commandbutton within w_orden_cobro_nueva
end type
type cb_aceptar from commandbutton within w_orden_cobro_nueva
end type
type sle_orden_cobro from singlelineedit within w_orden_cobro_nueva
end type
type st_1 from statictext within w_orden_cobro_nueva
end type
end forward

global type w_orden_cobro_nueva from Window
int X=845
int Y=371
int Width=1020
int Height=554
boolean TitleBar=true
string Title="Untitled"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_cancelar cb_cancelar
cb_aceptar cb_aceptar
sle_orden_cobro sle_orden_cobro
st_1 st_1
end type
global w_orden_cobro_nueva w_orden_cobro_nueva

on w_orden_cobro_nueva.create
this.cb_cancelar=create cb_cancelar
this.cb_aceptar=create cb_aceptar
this.sle_orden_cobro=create sle_orden_cobro
this.st_1=create st_1
this.Control[]={this.cb_cancelar,&
this.cb_aceptar,&
this.sle_orden_cobro,&
this.st_1}
end on

on w_orden_cobro_nueva.destroy
destroy(this.cb_cancelar)
destroy(this.cb_aceptar)
destroy(this.sle_orden_cobro)
destroy(this.st_1)
end on

type cb_cancelar from commandbutton within w_orden_cobro_nueva
int X=501
int Y=304
int Width=333
int Height=106
int TabOrder=30
string Text="Cancelar"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(parent,"")
end event

type cb_aceptar from commandbutton within w_orden_cobro_nueva
int X=110
int Y=304
int Width=333
int Height=106
int TabOrder=20
string Text="Aceptar"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;int li_i
boolean lb_sirve = true
int li_char
if sle_orden_cobro.text <> "" then 
	li_i = 1
	sle_orden_cobro.text = trim(sle_orden_cobro.text)
	do while li_i <= len(sle_orden_cobro.text) and lb_sirve = true
		li_char = asc(mid(sle_orden_cobro.text,li_i,1))
		if li_char <> 45 AND (li_char < 48 OR li_char > 57 ) then lb_sirve = false
		li_i ++
	loop
	if lb_sirve = true then
		CloseWithReturn(parent,sle_orden_cobro.text)
	else
		MessageBox("Atención","Sólo se admiten números o guiones")
	end if
else
	MessageBox("Atención", "Escriba algo en la orden de cobro")
end if
end event

type sle_orden_cobro from singlelineedit within w_orden_cobro_nueva
int X=249
int Y=154
int Width=457
int Height=109
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
int Limit=12
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;cb_aceptar.event clicked()
end event

type st_1 from statictext within w_orden_cobro_nueva
int X=55
int Y=51
int Width=856
int Height=77
boolean Enabled=false
string Text="Teclea la nueva orden de cobro"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

