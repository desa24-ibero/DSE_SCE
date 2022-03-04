$PBExportHeader$w_carreras_anteriores.srw
forward
global type w_carreras_anteriores from Window
end type
type dw_carreras_anteriores from datawindow within w_carreras_anteriores
end type
end forward

global type w_carreras_anteriores from Window
int X=823
int Y=356
int Width=2405
int Height=1696
boolean TitleBar=true
string Title="Captura de Carreras de Alumnos"
string MenuName="m_carreras_anteriores"
long BackColor=10789024
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_carreras_anteriores dw_carreras_anteriores
end type
global w_carreras_anteriores w_carreras_anteriores

on w_carreras_anteriores.create
if this.MenuName = "m_carreras_anteriores" then this.MenuID = create m_carreras_anteriores
this.dw_carreras_anteriores=create dw_carreras_anteriores
this.Control[]={this.dw_carreras_anteriores}
end on

on w_carreras_anteriores.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_carreras_anteriores)
end on

event open;dw_carreras_anteriores.Event carga()
end event

type dw_carreras_anteriores from datawindow within w_carreras_anteriores
event type integer carga ( )
int X=82
int Y=64
int Width=2213
int Height=1396
int TabOrder=10
string DataObject="d_carreras_anteriores"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event carga;return this.retrieve()
end event

event constructor;SetTrans(gtr_sce)
m_titulacion.dw = this
end event

