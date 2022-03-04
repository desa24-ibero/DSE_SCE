$PBExportHeader$uo_dw_captura.sru
$PBExportComments$DataWindow con los eventos necesarios para hacer una captura con confirmación o sin confirmación.El objeto usa SQLCA como objeto de transacción, es necesario agregar la linea tr_dw_propio = %OBJTRAN% en el evento inicia_objeto_transaccion.
forward
global type uo_dw_captura from datawindow
end type
end forward

global type uo_dw_captura from datawindow
integer x = 15
integer y = 179
integer width = 2586
integer height = 899
integer taborder = 2
string dataobject = "dw_carrera"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event type integer ue_carga ( )
event type integer ue_actualizacion ( )
event ue_primero ( )
event ue_anterior ( )
event ue_siguiente ( )
event ue_ultimo ( )
event ue_nuevo ( )
event ue_borra ( )
event type integer ue_actualiza_con_mensaje ( )
event ue_asigna_dw_menu ( )
event type integer ue_actualiza ( )
event ue_inicia_transaction_object ( transaction a_tr_dw )
event keyboard pbm_dwnkey
event type integer ue_valida_data_window ( integer ai_num_registro )
event type integer ue_valida_logica ( )
end type
global uo_dw_captura uo_dw_captura

type variables
m_ancestro_menu menu_propietario
transaction tr_dw_propio
int actualizo = 0
String is_estatus='Normal'  //Indica el estatus de la captura: Nuevo (alta) Normal (modificacion)
end variables

event ue_carga;
/*
DESCRIPCIÓN: Antes de cargar algo, ve si hay modificaciones no guardadas.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
if event ue_actualizacion()=1 then
	event ue_primero()
	return retrieve()
end if
return 0
end event

event ue_actualizacion;/*
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
	li_respuesta = messagebox("Atención","Desea actualizar los cambios:",Question!,YesNo!,2)

	if li_respuesta = 1 then
			/*Checa que los renglones cumplan con las reglas de validación*/
			if event ue_actualiza_con_mensaje() = 1 then//Manda llamar la función que realiza el update
				message.longparm = 1
				return message.longparm
			else 
				message.longparm = -1
				return message.longparm
			end if
	else
		/*De lo contrario, solo avisa que no se guardó nada.*/
		messagebox("Información","No se han guardado los cambios")
		message.longparm = -1
		return message.longparm
	end if
else
	return 1
end if
end event

event ue_primero;/*Ve al primer renglón*/
if this.AcceptText()<> -1 then

	setcolumn(1)
	setfocus()
	scrolltorow(1)
	is_estatus = 'Normal'
	
end if

end event

event ue_anterior;/*Ve al renglón anterior*/
if this.AcceptText()<> -1 then

	setcolumn(1)
	setfocus()
	if getrow()>1 then
		scrolltorow(getrow()-1)
	end if
	is_estatus = 'Normal'

end if


end event

event ue_siguiente;/*Ve al siguiente renglón*/
if this.AcceptText()<> -1 then

	setcolumn(1)
	setfocus()
	if getrow()<rowcount() then
		scrolltorow(getrow()+1)
	end if
	is_estatus = 'Normal'
end if

end event

event ue_ultimo;/*Ve al último renglón*/
if this.AcceptText()<> -1 then

	setcolumn(1)
	setfocus()
	scrolltorow(rowcount())
	is_estatus = 'Normal'
end if

end event

event ue_nuevo;/*Inserta un Nuevo Registro*/

if this.AcceptText()<> -1 then
	setfocus()
	scrolltorow(insertrow(0))
	setcolumn(1)

	is_estatus = 'Nuevo'
End if

end event

event ue_borra;/*
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
		triggerevent("ue_actualiza_con_mensaje")
	
	else
		messagebox("Información","No se han guardado los cambios")	
	end if
elseif li_respuesta = 2 then
	rollback using tr_dw_propio;	
end if
end event

event ue_actualiza_con_mensaje;/*
DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
				La unica interacción con el usuario es mediante avisos de que los campos se guardaron o no
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: CAMP(DkWf)
FECHA: 17 Junio 1998

MODIFICACIÓN: 30 de Marzo de 1999
	Se anadio la llamada al user event: ue_valida_data_window
Antonio Pica Ruiz
*/

if event ue_valida_logica() = 1 then

	if event ue_actualiza() = 1 then
		/*Si es asi, guardalo en la tabla y avisa.*/	
		messagebox("Información","Se han guardado los cambios")
		return 1
	else
		/*De lo contrario, desecha los cambios (todos) y avisa*/
		messagebox("Información","Algunos datos están incorrectos, favor de corregirlos")	
		return -1
	end if
else
	return -1
end if


end event

event ue_asigna_dw_menu;/*
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

event ue_actualiza;
/*
DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
				Este evento no presenta interacción con el usuario
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/
integer li_resultado_update

AcceptText()
if ModifiedCount()+DeletedCount() > 0 Then
/*Función que solo actualiza*/
	li_resultado_update = update(true)
	if li_resultado_update = 1 then		
		/*Si es asi, guardalo en la tabla y avisa.*/
		actualizo = 1
		commit using tr_dw_propio;	
		return 1
	else
		actualizo = 0
		/*De lo contrario, desecha los cambios (todos) y avisa*/
		rollback using tr_dw_propio;		
		return -1
	end if
else
	actualizo = 2
	return 1
end if
end event

event ue_inicia_transaction_object;/*
DESCRIPCIÓN: Evento en el que se asigna al tr_dw_propio el objeto de transacción que se va a utilizar en el dw.
					 El codigo de este evento se agrega desde el control en la ventana
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: CAMP(DkWf)
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/
tr_dw_propio = create transaction

tr_dw_propio = a_tr_dw


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
			triggerevent("ue_nuevo")
			setcolumn(1)			
	end if
end if
end event

event ue_valida_data_window;/*
DESCRIPCIÓN: Evento en el cual se debe llevar a cabo un proceso de validación 
	de la información contenida en el DataWindow para garantizar su integridad
	en la base de datos y la lógica que la gobierna
	
	Es necesario sobreescribirse en cada catálogo donde se desee dicha validación
	ya que por omisión regresará 1 (información correcta)
	
PARÁMETROS: Ninguno
REGRESA:  0 si toda la información esta bien
			-1 Si hubo alguna falla
AUTOR: Antonio Pica Ruiz
FECHA: 30 de Marzo de 1999
MODIFICACIÓN:
*/


return 0

end event

event ue_valida_logica;/*
DESCRIPCIÓN: Evento en el cual se debe llevar a cabo un proceso de validación 
	de la información contenida en el DataWindow para garantizar su integridad
	en la base de datos y la lógica que la gobierna
	
	Efectua la llamada al user event: ue_valida_data_window para todos los registros
	a actualizar
	
	
PARÁMETROS: Ninguno
REGRESA:  1 si toda la información esta bien
			-1 Si hubo alguna falla
AUTOR: Antonio Pica Ruiz
FECHA: 30 de Marzo de 1999
MODIFICACIÓN:
*/

integer li_total_registros, li_registro_actual

li_registro_actual = 1
li_total_registros = RowCount()

DO WHILE li_registro_actual <= li_total_registros
	
	If Event ue_valida_data_window(li_registro_actual) <> 0 then
		ScrollToRow(li_registro_actual)
		return -1
	End If

	li_registro_actual = li_registro_actual +1 
	
LOOP


return 1


end event

event constructor;/*
DESCRIPCIÓN: Evento en el que se localiza la variable dw en el menu y se asigna el valor de este objeto	.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: CAMP(DkWf)
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/
triggerevent("ue_asigna_dw_menu")
triggerevent("ue_inicia_transaction_object")
end event

event getfocus;/*
DESCRIPCIÓN: Evento en el que se localiza la variable dw en el menu y se asigna el valor de este objeto	.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: CAMP(DkWf)
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/
//triggerevent("ue_asigna_dw_menu")
end event

event rowfocuschanged;/*Visualiza una mano grafica en la parte izquierda del renglón seleccionado.*/

SetRowFocusIndicator(Hand!) 
end event

event dberror;
/*
DESCRIPCIÓN: Evento en el cual se controlan los errores de la base de datos
	y se envía a la pantalla el mensaje del manejador.

PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Antonio Pica Ruiz
FECHA: 30 Marzo 1999
MODIFICACIÓN: 7 de abril de 1999
	Se anadio la estructura "CHOOSE CASE" con el SQLDBCode para controlar 
   la lista de errores del manejador.
Sergio A. Magallanes
 
*/

//Es necesario efectuar el rollback para evitar que se deje la información bloqueada
//cuando se envíe el MessageBox

rollback using tr_dw_propio;

//Agregar la lista de errores para el manejador y el mensaje asociado.

CHOOSE CASE SQLDBCode
	CASE 2601
		MessageBox("Error","La clave principal esta duplicada",StopSign!)
	CASE ELSE
		MessageBox("Error",string(SQLDBCode)+" "+SqlErrText,StopSign!)
END CHOOSE

return 1

end event

event scrollvertical;string ls_firstrow
long ll_firstrow
ls_firstrow = this.Object.Datawindow.FirstRowOnPage
ll_firstrow= long(ls_firstrow)

ScrollToRow(ll_firstrow)
end event

on uo_dw_captura.create
end on

on uo_dw_captura.destroy
end on

