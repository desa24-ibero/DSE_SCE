$PBExportHeader$w_ancestral.srw
$PBExportComments$Ventana ancestro de todo el sistema de FEB. Junio 16, 1998 DkWf
forward
global type w_ancestral from Window
end type
type p_uia from picture within w_ancestral
end type
end forward

global type w_ancestral from Window
int X=23
int Y=36
int Width=3607
int Height=2196
boolean TitleBar=true
long BackColor=29534863
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event inicia_proceso ( )
p_uia p_uia
end type
global w_ancestral w_ancestral

on w_ancestral.create
this.p_uia=create p_uia
this.Control[]={this.p_uia}
end on

on w_ancestral.destroy
destroy(this.p_uia)
end on

event open;x	=	1
y	=	1
//g_nv_security.fnv_secure_window(this)
end event

type p_uia from picture within w_ancestral
int Width=375
int Height=412
string PictureName="lobos_sml2.bmp"
boolean FocusRectangle=false
end type

