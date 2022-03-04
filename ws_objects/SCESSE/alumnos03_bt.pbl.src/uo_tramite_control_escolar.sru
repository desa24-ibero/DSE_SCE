$PBExportHeader$uo_tramite_control_escolar.sru
forward
global type uo_tramite_control_escolar from userobject
end type
type dw_1 from datawindow within uo_tramite_control_escolar
end type
end forward

global type uo_tramite_control_escolar from userobject
integer width = 1202
integer height = 102
boolean border = true
long backcolor = 29534863
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
end type
global uo_tramite_control_escolar uo_tramite_control_escolar

forward prototypes
public function long of_obten_clave ()
public function string of_obten_texto ()
public function integer of_set_clave (long al_clave)
end prototypes

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
	ll_row_texto = lds_datastore.Find("clave = "+string(ll_clave), ll_row_actual, lds_datastore.Rowcount())
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

on uo_tramite_control_escolar.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on uo_tramite_control_escolar.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within uo_tramite_control_escolar
integer width = 1195
integer height = 92
integer taborder = 10
string dataobject = "duo_tramite_control_escolar"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.SetTransObject(gtr_sce)
this.Retrieve()
end event

event itemchanged;if row> 0 then
//	if isvalid(w_solicitudes_pendientes) then
//		w_solicitudes_pendientes.event ue_sincroniza(data)
//	end if
end if
end event

