$PBExportHeader$w_paso.srw
forward
global type w_paso from Window
end type
type rb_todos from radiobutton within w_paso
end type
type rb_posgrado from radiobutton within w_paso
end type
type rb_licenciatura from radiobutton within w_paso
end type
type gb_mostrar from groupbox within w_paso
end type
end forward

global type w_paso from Window
int X=823
int Y=356
int Width=2016
int Height=1212
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
rb_todos rb_todos
rb_posgrado rb_posgrado
rb_licenciatura rb_licenciatura
gb_mostrar gb_mostrar
end type
global w_paso w_paso

on w_paso.create
this.rb_todos=create rb_todos
this.rb_posgrado=create rb_posgrado
this.rb_licenciatura=create rb_licenciatura
this.gb_mostrar=create gb_mostrar
this.Control[]={this.rb_todos,&
this.rb_posgrado,&
this.rb_licenciatura,&
this.gb_mostrar}
end on

on w_paso.destroy
destroy(this.rb_todos)
destroy(this.rb_posgrado)
destroy(this.rb_licenciatura)
destroy(this.gb_mostrar)
end on

type rb_todos from radiobutton within w_paso
int X=997
int Y=296
int Width=398
int Height=80
string Text="Todos"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
boolean LeftText=true
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_posgrado from radiobutton within w_paso
int X=997
int Y=216
int Width=398
int Height=80
string Text="Posgrado"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_licenciatura from radiobutton within w_paso
int X=997
int Y=136
int Width=398
int Height=80
string Text="Licenciatura"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_mostrar from groupbox within w_paso
int X=951
int Y=76
int Width=494
int Height=320
int TabOrder=10
string Text="Mostrar"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

