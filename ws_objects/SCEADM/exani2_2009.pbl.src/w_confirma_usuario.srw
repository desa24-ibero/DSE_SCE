$PBExportHeader$w_confirma_usuario.srw
forward
global type w_confirma_usuario from w_response
end type
type em_usuario from editmask within w_confirma_usuario
end type
type st_1 from statictext within w_confirma_usuario
end type
type st_2 from statictext within w_confirma_usuario
end type
type cb_confirmar from u_cb within w_confirma_usuario
end type
type sle_password from singlelineedit within w_confirma_usuario
end type
end forward

global type w_confirma_usuario from w_response
int X=1020
int Y=614
int Width=1200
int Height=566
boolean TitleBar=true
string Title="Confirme Usuario"
em_usuario em_usuario
st_1 st_1
st_2 st_2
cb_confirmar cb_confirmar
sle_password sle_password
end type
global w_confirma_usuario w_confirma_usuario

type variables
st_confirma_usuario ist_confirma_usuario
boolean ib_cierra_por_boton= false
end variables

on w_confirma_usuario.create
int iCurrent
call super::create
this.em_usuario=create em_usuario
this.st_1=create st_1
this.st_2=create st_2
this.cb_confirmar=create cb_confirmar
this.sle_password=create sle_password
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_usuario
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.cb_confirmar
this.Control[iCurrent+5]=this.sle_password
end on

on w_confirma_usuario.destroy
call super::destroy
destroy(this.em_usuario)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_confirmar)
destroy(this.sle_password)
end on

event closequery;IF ib_cierra_por_boton THEN
	RETURN 0
ELSE
	RETURN 1
END IF


end event

type em_usuario from editmask within w_confirma_usuario
int X=432
int Y=74
int Width=636
int Height=86
int TabOrder=10
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
MaskDataType MaskDataType=StringMask!
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_confirma_usuario
int X=135
int Y=74
int Width=256
int Height=86
boolean Enabled=false
boolean BringToTop=true
string Text="Usuario :"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_confirma_usuario
int X=80
int Y=182
int Width=311
int Height=86
boolean Enabled=false
boolean BringToTop=true
string Text="Password :"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_confirmar from u_cb within w_confirma_usuario
int X=388
int Y=320
int Width=421
int TabOrder=30
boolean BringToTop=true
string Text="Confirmar"
int TextSize=-10
FontCharSet FontCharSet=Ansi!
end type

event clicked;call super::clicked;string ls_usuario, ls_password


ls_usuario = em_usuario.text
ls_password = sle_password.text

ist_confirma_usuario.usuario = ls_usuario
ist_confirma_usuario.password = ls_password

ib_cierra_por_boton=true
CloseWithReturn(Parent, ist_confirma_usuario)


end event

type sle_password from singlelineedit within w_confirma_usuario
int X=432
int Y=182
int Width=636
int Height=86
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

