$PBExportHeader$uo_dw_reporte.sru
$PBExportComments$DataWindow con los eventos para mostrar y manipular un reporte
forward
global type uo_dw_reporte from datawindow
end type
end forward

global type uo_dw_reporte from datawindow
int X=14
int Y=204
int Width=3355
int Height=1652
int TabOrder=2
string DataObject="dw_carrera"
boolean Border=false
boolean VScrollBar=true
boolean LiveScroll=true
event type integer carga ( )
event actualiza ( )
event ue_primero ( )
event ue_anterior ( )
event ue_siguiente ( )
event ue_ultimo ( )
event nuevo ( )
event borra ( )
event asigna_dw_menu ( )
event inicia_transaction_object ( )
end type
global uo_dw_reporte uo_dw_reporte

type variables
m_menu menu_propietario
transaction tr_dw_propio
end variables

event carga;event ue_primero()
return retrieve()
end event

event ue_primero;/*Ve al primer renglón*/
scrolltorow(1)
end event

event ue_anterior;/*Ve al renglón anterior*/
scrollpriorpage ( )


end event

event ue_siguiente;/*Ve al siguiente renglón*/
scrollnextpage ( )
end event

event ue_ultimo;/*Ve al último renglón*/
scrolltorow(rowcount())
end event

event asigna_dw_menu;/*
DESCRIPCIÓN: Evento en el cual se asigna a la variable dw del menu este objeto.
				En este evento se busca la ventana dueña del objeto y cual es su menu
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: CAMP(DkWf)
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/
window ventana_propietaria

ventana_propietaria = getparent()

menu_propietario = ventana_propietaria.menuid

menu_propietario.dw	= this
end event

event inicia_transaction_object;/*
DESCRIPCIÓN: Evento en el que se asigna al tr_dw_propio el objeto de transacción que se va a utilizar en el dw.
					 El codigo de este evento se agrega desde el control en la ventana
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: CAMP(DkWf)
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/
tr_dw_propio = create transaction

//Ejemplo:					

//	tr_dw_propio = SFEB
end event

event clicked;zoomin(this)
end event

event rbuttondown;zoomout(this)
end event

event constructor;/*
DESCRIPCIÓN: Evento en el que se localiza la variable dw en el menu y se asigna el valor de este objeto	.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: CAMP(DkWf)
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/
triggerevent("asigna_dw_menu")
modify("Datawindow.print.preview = Yes")
triggerevent("inicia_transaction_object")
end event

