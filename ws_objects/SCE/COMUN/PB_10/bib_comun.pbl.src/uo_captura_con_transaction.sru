$PBExportHeader$uo_captura_con_transaction.sru
$PBExportComments$antes del constructor del objeto hay que asignarle el valor correspondiente a itr_transaction
forward
global type uo_captura_con_transaction from UserObject
end type
type dw_1 from datawindow within uo_captura_con_transaction
end type
end forward

global type uo_captura_con_transaction from UserObject
int Width=2811
int Height=1020
boolean Border=true
long BackColor=67108864
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
dw_1 dw_1
end type
global uo_captura_con_transaction uo_captura_con_transaction

type variables
transaction itr_transaction
end variables

on uo_captura_con_transaction.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on uo_captura_con_transaction.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within uo_captura_con_transaction
event actualiza ( )
event borra ( )
event carga ( )
event nuevo ( )
int Width=4384
int Height=2092
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event borra;DeleteRow(GetRow())
event actualiza()

end event

event carga;DeleteRow(GetRow())
event actualiza()

end event

event nuevo;ScrolltoRow(InsertRow(0))
end event

event itemchanged;if Update( )  = 1  then
	commit using itr_transaction;
	MessageBox("Atencion", "Se han guardado los cambios")
else
	rollback using itr_transaction;
	MessageBox("Atencion", "Los cambios no se han guardado")
end if

end event

event constructor;window ventana_propietaria
m_menu	menu_propietario

ventana_propietaria = getparent()
menu_propietario = ventana_propietaria.menuid
menu_propietario.dw	= this
SetTransObject(itr_transaction)
end event

