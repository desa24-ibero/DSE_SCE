$PBExportHeader$w_inserta_materias.srw
forward
global type w_inserta_materias from Window
end type
type cb_1 from commandbutton within w_inserta_materias
end type
type em_1 from editmask within w_inserta_materias
end type
end forward

global type w_inserta_materias from Window
int X=845
int Y=371
int Width=2055
int Height=1229
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_1 cb_1
em_1 em_1
end type
global w_inserta_materias w_inserta_materias

on w_inserta_materias.create
this.cb_1=create cb_1
this.em_1=create em_1
this.Control[]={this.cb_1,&
this.em_1}
end on

on w_inserta_materias.destroy
destroy(this.cb_1)
destroy(this.em_1)
end on

type cb_1 from commandbutton within w_inserta_materias
int X=629
int Y=365
int Width=252
int Height=106
int TabOrder=20
string Text="Inserta"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_cuenta, ll_rows
string ls_cuenta

ls_cuenta = em_1.text

ll_cuenta = long(ls_cuenta)

ll_rows = f_inserta_mats_revalid(ll_cuenta)

MessageBox("Resultado de Inserción", "Registro de "+string(ll_rows)+" registros")


end event

type em_1 from editmask within w_inserta_materias
int X=483
int Y=122
int Width=611
int Height=118
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string Mask="########"
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

