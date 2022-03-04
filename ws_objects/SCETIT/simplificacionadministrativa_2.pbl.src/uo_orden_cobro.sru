$PBExportHeader$uo_orden_cobro.sru
forward
global type uo_orden_cobro from UserObject
end type
type em_orden_cobro from editmask within uo_orden_cobro
end type
type st_1 from statictext within uo_orden_cobro
end type
end forward

global type uo_orden_cobro from UserObject
int Width=1088
int Height=120
boolean Border=true
long BackColor=67108864
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
em_orden_cobro em_orden_cobro
st_1 st_1
end type
global uo_orden_cobro uo_orden_cobro

on uo_orden_cobro.create
this.em_orden_cobro=create em_orden_cobro
this.st_1=create st_1
this.Control[]={this.em_orden_cobro,&
this.st_1}
end on

on uo_orden_cobro.destroy
destroy(this.em_orden_cobro)
destroy(this.st_1)
end on

type em_orden_cobro from editmask within uo_orden_cobro
int X=581
int Width=457
int Height=100
int TabOrder=10
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
MaskDataType MaskDataType=StringMask!
long TextColor=33554432
long BackColor=15793151
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within uo_orden_cobro
int X=14
int Y=16
int Width=507
int Height=68
boolean Enabled=false
string Text="Orden de Cobro:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

