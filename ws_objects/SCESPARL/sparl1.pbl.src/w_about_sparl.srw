$PBExportHeader$w_about_sparl.srw
forward
global type w_about_sparl from Window
end type
type p_uia from picture within w_about_sparl
end type
type st_n2 from statictext within w_about_sparl
end type
type st_dir_info from statictext within w_about_sparl
end type
type cb_1 from commandbutton within w_about_sparl
end type
type st_1 from statictext within w_about_sparl
end type
type r_1 from rectangle within w_about_sparl
end type
type gb_1 from groupbox within w_about_sparl
end type
end forward

global type w_about_sparl from Window
int X=1120
int Y=688
int Width=1253
int Height=976
boolean TitleBar=true
string Title="Acerca de SRL 1.804.98"
long BackColor=0
boolean ControlMenu=true
WindowType WindowType=response!
p_uia p_uia
st_n2 st_n2
st_dir_info st_dir_info
cb_1 cb_1
st_1 st_1
r_1 r_1
gb_1 gb_1
end type
global w_about_sparl w_about_sparl

on w_about_sparl.create
this.p_uia=create p_uia
this.st_n2=create st_n2
this.st_dir_info=create st_dir_info
this.cb_1=create cb_1
this.st_1=create st_1
this.r_1=create r_1
this.gb_1=create gb_1
this.Control[]={this.p_uia,&
this.st_n2,&
this.st_dir_info,&
this.cb_1,&
this.st_1,&
this.r_1,&
this.gb_1}
end on

on w_about_sparl.destroy
destroy(this.p_uia)
destroy(this.st_n2)
destroy(this.st_dir_info)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.r_1)
destroy(this.gb_1)
end on

event open;X = 1121
Y = 501
end event

type p_uia from picture within w_about_sparl
int X=567
int Y=64
int Width=110
int Height=88
string PictureName="uia2.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type st_n2 from statictext within w_about_sparl
int X=197
int Y=388
int Width=855
int Height=92
boolean Enabled=false
string Text="Fantine Medina Carrillo"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=15793151
long BackColor=0
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_dir_info from statictext within w_about_sparl
int X=297
int Y=596
int Width=649
int Height=56
boolean Enabled=false
string Text="Dirección de Informática"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=15793151
long BackColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_about_sparl
int X=498
int Y=732
int Width=247
int Height=108
int TabOrder=10
string Text="OK"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(w_about)
end event

type st_1 from statictext within w_about_sparl
int X=50
int Y=184
int Width=1134
int Height=208
boolean Enabled=false
string Text="Sistema de Procesos Auxiliares a la Reinscripción en Linea SPARL  Desarrollado por "
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=15793151
long BackColor=0
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type r_1 from rectangle within w_about_sparl
int X=1125
int Y=800
int Width=87
int Height=76
boolean Enabled=false
int LineThickness=4
long LineColor=15793151
long FillColor=15793151
end type

type gb_1 from groupbox within w_about_sparl
int X=27
int Y=4
int Width=1175
int Height=692
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
long TextColor=15793151
long BackColor=0
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

