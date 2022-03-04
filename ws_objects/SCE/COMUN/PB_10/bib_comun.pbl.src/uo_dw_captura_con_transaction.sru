$PBExportHeader$uo_dw_captura_con_transaction.sru
$PBExportComments$Antes de usar cualquier funcionalidad del datawindow se debe de llamar a la funcion atr_transaction que recibe como parametro la transaccion
forward
global type uo_dw_captura_con_transaction from datawindow
end type
end forward

global type uo_dw_captura_con_transaction from datawindow
int Width=2427
int Height=1184
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
event actualiza ( )
event borra ( )
event carga ( )
event nuevo ( )
event asignatransaction ( transaction atr_transaction )
end type
global uo_dw_captura_con_transaction uo_dw_captura_con_transaction

type variables
transaction itr_transaction
end variables

event actualiza;if Update( )  = 1  then
	commit using itr_transaction;
	MessageBox("Atencion", "Se han guardado los cambios")
else
	rollback using itr_transaction;
	MessageBox("Atencion", "Los cambios no se han guardado")
end if
end event

event borra;DeleteRow(GetRow())
event actualiza()
end event

event carga;retrieve()

end event

event nuevo;ScrolltoRow(InsertRow(0))
end event

event asignatransaction;itr_transaction = atr_transaction
SetTransObject(itr_transaction)
end event

event constructor;window ventana_propietaria
menu	menu_propietario

ventana_propietaria = getparent()
menu_propietario = ventana_propietaria.menuid
menu_propietario.DYNAMIC asigna_dw(this)


end event

