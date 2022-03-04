$PBExportHeader$uo_mostrar_grado.sru
forward
global type uo_mostrar_grado from UserObject
end type
type rb_licenciatura from radiobutton within uo_mostrar_grado
end type
type rb_posgrado from radiobutton within uo_mostrar_grado
end type
type rb_todos from radiobutton within uo_mostrar_grado
end type
type gb_mostrar from groupbox within uo_mostrar_grado
end type
end forward

global type uo_mostrar_grado from UserObject
int Width=526
int Height=320
boolean Border=true
long BackColor=12632256
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
rb_licenciatura rb_licenciatura
rb_posgrado rb_posgrado
rb_todos rb_todos
gb_mostrar gb_mostrar
end type
global uo_mostrar_grado uo_mostrar_grado

type variables
window ventana_padre
string is_mostrar = ""
end variables

on uo_mostrar_grado.create
this.rb_licenciatura=create rb_licenciatura
this.rb_posgrado=create rb_posgrado
this.rb_todos=create rb_todos
this.gb_mostrar=create gb_mostrar
this.Control[]={this.rb_licenciatura,&
this.rb_posgrado,&
this.rb_todos,&
this.gb_mostrar}
end on

on uo_mostrar_grado.destroy
destroy(this.rb_licenciatura)
destroy(this.rb_posgrado)
destroy(this.rb_todos)
destroy(this.gb_mostrar)
end on

event constructor;rb_todos.Checked = true

end event

type rb_licenciatura from radiobutton within uo_mostrar_grado
int X=59
int Y=60
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

event clicked;is_mostrar = "L"
end event

type rb_posgrado from radiobutton within uo_mostrar_grado
int X=59
int Y=136
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

event clicked;is_mostrar = "P"
end event

type rb_todos from radiobutton within uo_mostrar_grado
int X=59
int Y=216
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

event clicked;is_mostrar = ""
end event

type gb_mostrar from groupbox within uo_mostrar_grado
int X=14
int Width=494
int Height=304
int TabOrder=10
string Text="Nivel"
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

