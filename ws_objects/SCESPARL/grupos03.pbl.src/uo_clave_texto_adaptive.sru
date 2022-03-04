$PBExportHeader$uo_clave_texto_adaptive.sru
forward
global type uo_clave_texto_adaptive from userobject
end type
type dw_1 from datawindow within uo_clave_texto_adaptive
end type
end forward

global type uo_clave_texto_adaptive from userobject
integer width = 1056
integer height = 136
boolean border = true
long backcolor = 67108864
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
end type
global uo_clave_texto_adaptive uo_clave_texto_adaptive

forward prototypes
public function integer of_set_clave (long al_clave)
public function long of_obten_clave ()
public function string of_obten_texto ()
public function integer of_set_dataobject (string as_dataobject)
end prototypes

public function integer of_set_clave (long al_clave);//of_set_clave
//Devuelve la clave seleccionada

long ll_row_actual, ll_clave
ll_row_actual= dw_1.GetRow()
if ll_row_actual >0 then
	ll_clave = dw_1.SetItem(ll_row_actual,1,al_clave)
else
	ll_clave =-1
end if

return ll_clave


end function

public function long of_obten_clave ();//of_obten_clave
//Devuelve la clave seleccionada

long ll_row_actual, ll_clave
ll_row_actual= dw_1.GetRow()
if ll_row_actual >0 then
	ll_clave = dw_1.GetItemNumber(ll_row_actual,1)
else
	ll_clave =0
end if

return ll_clave


end function

public function string of_obten_texto ();//of_obten_texto
//Devuelve la clave seleccionada

long ll_row_actual, ll_clave, ll_row_texto, ll_ds_retrieve
datastore lds_datastore
STRING ls_texto

lds_datastore = CREATE datastore
lds_datastore.dataobject = dw_1.dataobject
lds_datastore.SetTransObject(gtr_sce)

ll_ds_retrieve= lds_datastore.Retrieve()

ll_row_actual= dw_1.GetRow()

if ll_row_actual >0 and ll_ds_retrieve>0 then
	ll_clave = dw_1.GetItemNumber(ll_row_actual,1)	
	ll_row_texto = lds_datastore.Find("clave = "+string(ll_clave), 1, lds_datastore.Rowcount())
	if ll_row_texto>0 then
		ls_texto = lds_datastore.GetItemString(ll_row_texto,2)		
	else
		ls_texto =""
	end if
else
	ls_texto =""
end if
if isvalid(lds_datastore) then
	DESTROY lds_datastore
end if
return ls_texto



end function

public function integer of_set_dataobject (string as_dataobject);//of_set_dataobject
//Recibe:
//string		as_dataobject

Datawindowchild ldddw_child
int 	li_return
string ls_clase_objeto

ls_clase_objeto = this.ClassName()
li_return = dw_1.GetChild('clave', ldddw_child)

if li_return = -1 then
	MessageBox("Error", "Not se ha encontrado a un DataWindowChild en "+string(ls_clase_objeto),StopSign!)
else
//	ldddw_child.Dataobject = as_dataobject
		
end if
return 0
end function

on uo_clave_texto_adaptive.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on uo_clave_texto_adaptive.destroy
destroy(this.dw_1)
end on

event constructor;//graphicobject lg_graphicobject
//lg_graphicobject = parent.backcolor
long ll_backcolor

Window	LPO_PowerObject	

LPO_PowerObject = THIS.GetParent()

this.BackColor =LPO_PowerObject.BackColor
end event

type dw_1 from datawindow within uo_clave_texto_adaptive
integer x = 18
integer y = 16
integer width = 1010
integer height = 92
integer taborder = 10
string dataobject = "duo_clave_texto_adaptive"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.SetTransObject(gtr_sce)
this.Retrieve()
end event

