$PBExportHeader$uo_tipo_periodo.sru
forward
global type uo_tipo_periodo from UserObject
end type
type rb_ingreso from radiobutton within uo_tipo_periodo
end type
type rb_registro from radiobutton within uo_tipo_periodo
end type
end forward

global type uo_tipo_periodo from UserObject
int Width=325
int Height=134
long BackColor=79741120
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
rb_ingreso rb_ingreso
rb_registro rb_registro
end type
global uo_tipo_periodo uo_tipo_periodo

on uo_tipo_periodo.create
this.rb_ingreso=create rb_ingreso
this.rb_registro=create rb_registro
this.Control[]={this.rb_ingreso,&
this.rb_registro}
end on

on uo_tipo_periodo.destroy
destroy(this.rb_ingreso)
destroy(this.rb_registro)
end on

type rb_ingreso from radiobutton within uo_tipo_periodo
int X=7
int Y=64
int Width=307
int Height=58
string Text="Ingreso"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_registro from radiobutton within uo_tipo_periodo
int X=7
int Width=307
int Height=58
string Text="Registro"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

