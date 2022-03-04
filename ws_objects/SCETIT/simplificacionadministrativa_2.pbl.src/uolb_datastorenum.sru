$PBExportHeader$uolb_datastorenum.sru
$PBExportComments$ListBox que se llena con un datastore
forward
global type uolb_datastorenum from listbox
end type
end forward

global type uolb_datastorenum from listbox
int Width=541
int Height=598
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global uolb_datastorenum uolb_datastorenum

type variables
datastore ids_data_source
end variables

forward prototypes
public function integer llena (string as_dataname, transaction atr_transaction, integer ai_column, integer ai_number, string as_argument)
end prototypes

public function integer llena (string as_dataname, transaction atr_transaction, integer ai_column, integer ai_number, string as_argument);//as_dataname		string  		: Nombre del datastore
//atr_transaction transaction : Transaccion para la conexion
//ai_column			integer		: columna con el valor numerico
//ai_number			integer		: identificador del tipo de lectura
//as_argument		string		: parametro para la llamada al datastore
int li_ret, li_i
ids_data_source.DataObject = as_dataname
ids_data_source.SetTransObject(atr_transaction)
Reset()
if isnull(as_argument) then
	li_ret = ids_data_source.Retrieve()
else
	li_ret = ids_data_source.Retrieve(as_argument)
end if
if li_ret > 0 then
	for li_i = 1 to li_ret
		if ai_number = 0 then
			AddItem(string(ids_data_source.GetItemNumber(li_i,ai_column),"0-00-000000")+"-"+&
						mid(ids_data_source.GetItemString(li_i,ai_column+1),1,2))
		elseif ai_number = 1 then
			AddItem(ids_data_source.GetItemString(li_i,ai_column))
		end if
	next
end if
return li_ret

end function

event constructor;ids_data_source = Create DataStore
end event

event destructor;Destroy(ids_data_source)
end event

