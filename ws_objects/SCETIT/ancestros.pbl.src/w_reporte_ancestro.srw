$PBExportHeader$w_reporte_ancestro.srw
$PBExportComments$Ventana Base para la generación de Reportes
forward
global type w_reporte_ancestro from w_ancestral
end type
type cb_configurar from commandbutton within w_reporte_ancestro
end type
type cb_imprimir from commandbutton within w_reporte_ancestro
end type
type cb_buscar from commandbutton within w_reporte_ancestro
end type
type dw_reporte from uo_dw_reporte within w_reporte_ancestro
end type
end forward

global type w_reporte_ancestro from w_ancestral
int Width=3081
int Height=1740
string MenuName="m_ancestro_menu_reportes"
cb_configurar cb_configurar
cb_imprimir cb_imprimir
cb_buscar cb_buscar
dw_reporte dw_reporte
end type
global w_reporte_ancestro w_reporte_ancestro

on w_reporte_ancestro.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_ancestro_menu_reportes" then this.MenuID = create m_ancestro_menu_reportes
this.cb_configurar=create cb_configurar
this.cb_imprimir=create cb_imprimir
this.cb_buscar=create cb_buscar
this.dw_reporte=create dw_reporte
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_configurar
this.Control[iCurrent+2]=this.cb_imprimir
this.Control[iCurrent+3]=this.cb_buscar
this.Control[iCurrent+4]=this.dw_reporte
end on

on w_reporte_ancestro.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_configurar)
destroy(this.cb_imprimir)
destroy(this.cb_buscar)
destroy(this.dw_reporte)
end on

type cb_configurar from commandbutton within w_reporte_ancestro
int X=1787
int Y=1400
int Width=544
int Height=108
int TabOrder=30
boolean Visible=false
boolean BringToTop=true
string Text="Configurar Impresora"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/*
Evento que configura la impresora antes de imprimir el reporte
AUTOR: Antonio Pica Ruiz
FECHA: 30 de Marzo de 1999

*/


PrintSetup()
end event

type cb_imprimir from commandbutton within w_reporte_ancestro
int X=2382
int Y=1400
int Width=544
int Height=108
int TabOrder=40
boolean Visible=false
boolean BringToTop=true
string Text="Imprimir"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/*
Evento que envía a la impresora la información relacionada con el data window control
AUTOR: Antonio Pica Ruiz
FECHA: 30 de Marzo de 1999

*/

dw_reporte.Print()
end event

type cb_buscar from commandbutton within w_reporte_ancestro
int X=2578
int Y=52
int Width=343
int Height=108
int TabOrder=20
boolean BringToTop=true
string Text="Buscar"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/*
Evento que recupera la información relacionada con el data window control
AUTOR: Antonio Pica Ruiz
FECHA: 30 de Marzo de 1999

Esta función debera sobreescribirse en caso de requerir parámetros en su llamada

*/

dw_reporte.Retrieve()


end event

type dw_reporte from uo_dw_reporte within w_reporte_ancestro
int X=142
int Y=208
int Width=2775
int Height=1140
int TabOrder=10
end type

