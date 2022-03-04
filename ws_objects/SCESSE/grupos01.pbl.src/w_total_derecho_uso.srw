$PBExportHeader$w_total_derecho_uso.srw
forward
global type w_total_derecho_uso from Window
end type
type rb_total from radiobutton within w_total_derecho_uso
end type
type dw_total_derecho_uso from datawindow within w_total_derecho_uso
end type
type rb_80 from radiobutton within w_total_derecho_uso
end type
type rb_60 from radiobutton within w_total_derecho_uso
end type
type rb_40 from radiobutton within w_total_derecho_uso
end type
type rb_20 from radiobutton within w_total_derecho_uso
end type
type gb_cupo from groupbox within w_total_derecho_uso
end type
end forward

global type w_total_derecho_uso from Window
int X=845
int Y=371
int Width=1982
int Height=1306
boolean TitleBar=true
string Title="Total de Derecho y Uso de Salones"
string MenuName="m_menu"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
rb_total rb_total
dw_total_derecho_uso dw_total_derecho_uso
rb_80 rb_80
rb_60 rb_60
rb_40 rb_40
rb_20 rb_20
gb_cupo gb_cupo
end type
global w_total_derecho_uso w_total_derecho_uso

on w_total_derecho_uso.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.rb_total=create rb_total
this.dw_total_derecho_uso=create dw_total_derecho_uso
this.rb_80=create rb_80
this.rb_60=create rb_60
this.rb_40=create rb_40
this.rb_20=create rb_20
this.gb_cupo=create gb_cupo
this.Control[]={this.rb_total,&
this.dw_total_derecho_uso,&
this.rb_80,&
this.rb_60,&
this.rb_40,&
this.rb_20,&
this.gb_cupo}
end on

on w_total_derecho_uso.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_total)
destroy(this.dw_total_derecho_uso)
destroy(this.rb_80)
destroy(this.rb_60)
destroy(this.rb_40)
destroy(this.rb_20)
destroy(this.gb_cupo)
end on

type rb_total from radiobutton within w_total_derecho_uso
int X=113
int Y=454
int Width=194
int Height=77
string Text="total"
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

event clicked;dw_total_derecho_uso.Retrieve(0)
end event

type dw_total_derecho_uso from datawindow within w_total_derecho_uso
int X=380
int Y=48
int Width=1496
int Height=1027
int TabOrder=20
string DataObject="d_total_derecho_uso"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;m_menu menu_propietario
SetTransObject(gtr_sce)
window ventana_propietaria
ventana_propietaria = getparent()
menu_propietario = ventana_propietaria.menuid
menu_propietario.dw	= this
end event

type rb_80 from radiobutton within w_total_derecho_uso
int X=113
int Y=365
int Width=183
int Height=77
string Text="80"
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

event clicked;dw_total_derecho_uso.Retrieve(80)
end event

type rb_60 from radiobutton within w_total_derecho_uso
int X=113
int Y=275
int Width=183
int Height=77
string Text="60"
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

event clicked;dw_total_derecho_uso.Retrieve(60)
end event

type rb_40 from radiobutton within w_total_derecho_uso
int X=113
int Y=186
int Width=183
int Height=77
string Text="40"
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

event clicked;dw_total_derecho_uso.Retrieve(40)
end event

type rb_20 from radiobutton within w_total_derecho_uso
int X=113
int Y=96
int Width=183
int Height=77
string Text="20"
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

event clicked;dw_total_derecho_uso.Retrieve(20)
end event

type gb_cupo from groupbox within w_total_derecho_uso
int X=44
int Y=16
int Width=296
int Height=547
int TabOrder=10
string Text="cupo"
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

