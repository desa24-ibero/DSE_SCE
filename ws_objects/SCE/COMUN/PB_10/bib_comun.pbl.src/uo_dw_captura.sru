$PBExportHeader$uo_dw_captura.sru
$PBExportComments$DataWindow con los eventos necesarios para hacer una captura con confirmación o sin confirmación.El objeto usa SQLCA como objeto de transacción, es necesario agregar la linea tr_dw_propio = %OBJTRAN% en el evento inicia_objeto_transaccion.
forward
global type uo_dw_captura from datawindow
end type
end forward

global type uo_dw_captura from datawindow
int X=14
int Y=180
int Width=2587
int Height=900
int TabOrder=2
string DataObject="dw_carrera"
BorderStyle BorderStyle=StyleShadowBox!
boolean VScrollBar=true
boolean LiveScroll=true
event type integer carga ( )
event type integer actualiza ( )
event primero ( )
event anterior ( )
event siguiente ( )
event ultimo ( )
event nuevo ( )
event borra ( )
event type integer actualiza_np ( )
event asigna_dw_menu ( )
event type integer actualiza_0_int ( )
event inicia_transaction_object ( )
event keyboard pbm_dwnkey
end type
global uo_dw_captura uo_dw_captura

type variables
m_menu menu_propietario
transaction tr_dw_propio

end variables

event carga;
/*
DESCRIPCIÓN: Antes de cargar algo, ve si hay modificaciones no guardadas.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
if event actualiza()=1 then
	event primero()
	return retrieve()
end if
end event

event actualiza;/*
DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
				
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/
int li_respuesta
/*Acepta el texto de la última columna editada*/
AcceptText()
/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
if ModifiedCount()+DeletedCount() > 0 Then

	/*Pregunta si se desean guardar los cambios hechos*/
	li_respuesta = messagebox("Atención","Desea actualizar los cambios:",StopSign!,YesNo!,2)

	if li_respuesta = 1 then
			/*Checa que los renglones cumplan con las reglas de validación*/
			if event actualiza_np() = 1 then//Manda llamar la función que realiza el update
				return 1
			else 
				return -1
			end if
	else
		/*De lo contrario, solo avisa que no se guardó nada.*/
		messagebox("Información","No se han guardado los cambios")
		return -1
	end if
else
	return 1
end if
end event

event primero;/*Ve al primer renglón*/
setcolumn(1)
setfocus()
scrolltorow(1)
end event

event anterior;/*Ve al renglón anterior*/
setcolumn(1)
setfocus()
if getrow()>1 then
	scrolltorow(getrow()-1)
end if

end event

event siguiente;/*Ve al siguiente renglón*/
setcolumn(1)
setfocus()
if getrow()<rowcount() then
	scrolltorow(getrow()+1)
end if

end event

event ultimo;/*Ve al último renglón*/
setcolumn(1)
setfocus()
scrolltorow(rowcount())
end event

event nuevo;setfocus()
scrolltorow(insertrow(0))
setcolumn(1)
end event

event borra;/*
DESCRIPCIÓN: Borra el renglon actual y actualiza.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
int li_respuesta
li_respuesta = messagebox("Atención","Esta seguro de querer borrar el campo actual.",StopSign!,YesNo!,2)

if li_respuesta = 1 then
	if deleterow(getrow())	= 1 then
		triggerevent("actualiza")
	else
		messagebox("Información","No se han guardado los cambios")	
	end if
elseif li_respuesta = 2 then
	rollback;
end if
end event

event actualiza_np;/*
DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
				La unica interacción con el usuario es mediante avisos de que los campos se guardaron o no
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: CAMP(DkWf)
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/

if event actualiza_0_int() = 1 then
	/*Si es asi, guardalo en la tabla y avisa.*/
	messagebox("Información","Se han guardado los cambios")
	return 1
else
	/*De lo contrario, desecha los cambios (todos) y avisa*/
	messagebox("Información","Algunos datos están incorrectos, favor de corregirlos")	
	return -1
end if
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

event actualiza_0_int;/*
DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
				Este evento no presenta interacción con el usuario
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/

//transaction ltr_trans 
//ltr_trans = Create Transaction
//if GetTrans(ltr_trans) = 1 then

AcceptText()
if ModifiedCount()+DeletedCount() > 0 Then
/*Función que solo actualiza*/
	if update(true) = 1 then		
		/*Si es asi, guardalo en la tabla y avisa.*/
		commit using tr_dw_propio;	
		//destroy ltr_trans
		return 1
	else
		/*De lo contrario, desecha los cambios (todos) y avisa*/
		rollback using tr_dw_propio;	
		//destroy ltr_trans
		return -1
	end if
else
	return 1
end if
//else
//	destroy ltr_trans
//	return -1
//end if
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

event keyboard;/*
DESCRIPCIÓN:Agrega un renglón sobre el catalogo.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR:CAMP(DkWf)
FECHA:  1996
MODIFICACIÓN:
*/

if key = KeyDownArrow! then
	if getrow() = rowcount() then  //Agrega un renglón si se esta en el último y se presiona la tecla key down arrow
			triggerevent("nuevo")
			setcolumn(1)			
	end if
end if
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
triggerevent("inicia_transaction_object")
end event

event getfocus;/*
DESCRIPCIÓN: Evento en el que se localiza la variable dw en el menu y se asigna el valor de este objeto	.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: CAMP(DkWf)
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/
triggerevent("asigna_dw_menu")
end event

event rowfocuschanged;/*Visualiza una mano grafica en la parte izquierda del renglón seleccionado.*/

SetRowFocusIndicator(Hand!) 
end event

