$PBExportHeader$w_actividad.srw
forward
global type w_actividad from Window
end type
type dw_1 from uo_dw_captura within w_actividad
end type
end forward

global type w_actividad from Window
int X=833
int Y=361
int Width=2821
int Height=1805
boolean TitleBar=true
string Title="Actividades"
string MenuName="m_menu"
long BackColor=30976088
dw_1 dw_1
end type
global w_actividad w_actividad

type variables
int ord
end variables

on w_actividad.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
this.Control[]={ this.dw_1}
end on

on w_actividad.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
dw_1.event carga()
end event

type dw_1 from uo_dw_captura within w_actividad
int X=19
int Y=21
int Width=2739
int Height=1561
int TabOrder=20
string DataObject="dw_actividad"
end type

event carga;/*Antes de cargar algo, ve si hay modificaciones no guardadas*/
event actualiza()
event primero()
return retrieve()
end event

event nuevo;if gi_version<>99 then
	/*Ve que no estemos en "Todos los periodos"*/
	setfocus()
	scrolltorow(insertrow(0))
end if
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

