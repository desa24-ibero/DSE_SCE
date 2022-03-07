﻿$PBExportHeader$uo_carreras_alumno_posgrado.sru
forward
global type uo_carreras_alumno_posgrado from uo_clave_texto_01
end type
end forward

global type uo_carreras_alumno_posgrado from uo_clave_texto_01
integer width = 2299
integer height = 108
end type
global uo_carreras_alumno_posgrado uo_carreras_alumno_posgrado

forward prototypes
public function long of_obten_clave_02 ()
public function integer of_obten_clave_02 (long al_cuenta)
public function long of_sincroniza (long al_cuenta)
end prototypes

public function long of_obten_clave_02 ();//of_obten_clave_02
//Devuelve la clave seleccionada

long ll_row_actual, ll_clave, ll_row_clave_02, ll_ds_retrieve, ll_clave_02
u_datastore lds_datastore
STRING ls_texto

lds_datastore = CREATE u_datastore
lds_datastore.dataobject = dw_1.dataobject
lds_datastore.SetTransObject(gtr_sce)

ll_ds_retrieve= lds_datastore.Retrieve()

ll_row_actual= dw_1.GetRow()

if ll_row_actual >0 and ll_ds_retrieve>0 then
	ll_clave = dw_1.GetItemNumber(ll_row_actual,1)	
	ll_row_clave_02 = lds_datastore.Find("clave = "+string(ll_clave), ll_row_actual, lds_datastore.Rowcount())
	if ll_row_clave_02>0 then
		ll_clave_02 = lds_datastore.GetItemNumber(ll_row_clave_02,3)		
	else
		ll_clave_02 =0
	end if
else
	ll_clave_02 =0
end if
if isvalid(lds_datastore) then
	DESTROY lds_datastore
end if
return ll_clave_02



end function

public function integer of_obten_clave_02 (long al_cuenta);//of_obten_clave_02
//Devuelve la clave seleccionada

long ll_row_actual, ll_clave, ll_row_clave_02, ll_ds_retrieve, ll_clave_02
u_datastore lds_datastore
STRING ls_texto

lds_datastore = CREATE u_datastore
lds_datastore.dataobject = dw_1.dataobject
lds_datastore.SetTransObject(gtr_sce)

ll_ds_retrieve= lds_datastore.Retrieve(al_cuenta)

ll_row_actual= dw_1.GetRow()

if ll_row_actual >0 and ll_ds_retrieve>0 then
	ll_clave = dw_1.GetItemNumber(ll_row_actual,1)	
	ll_row_clave_02 = lds_datastore.Find("clave = "+string(ll_clave), ll_row_actual, lds_datastore.Rowcount())
	if ll_row_clave_02>0 then
		ll_clave_02 = lds_datastore.GetItemNumber(ll_row_clave_02,3)		
	else
		ll_clave_02 =0
	end if
else
	ll_clave_02 =0
end if
if isvalid(lds_datastore) then
	DESTROY lds_datastore
end if
return ll_clave_02


end function

public function long of_sincroniza (long al_cuenta);//of_sincroniza
//Recibe
//	al_cuenta	long

//Declara el Datawindow child
DatawindowChild	dw_child
int		iRtn
long 	ll_row_child, ll_rows_dw_1

//Obtiene el Datawindow child en la variable dw_child
iRtn = dw_1.GetChild("clave", dw_child)

//Revisar errores

if iRtn = -1 then
	MessageBox("Error de datawindow anidado", "No es posible obtener la referencia",StopSign!)
	return -1
else
//Obtiene el objeto de transacción para dw_child 
//y obtiene el hijo. Pasa el estado como argumento.
	dw_child.SetTransObject(gtr_sce)
	ll_row_child = dw_child.Retrieve(al_cuenta)
	if ll_row_child > 0 then
		ll_rows_dw_1 = dw_1.Retrieve(al_cuenta)
	elseif ll_row_child= 0 then
		dw_1.Reset()
		MessageBox("Alumno sin carreras", "El alumno no ha cursado el nivel correspondiente",StopSign!)		
		return -1		
	elseif ll_row_child= -1 then
		dw_1.Reset()
		MessageBox("Error al consultar", "No es posible consultar las carreras del alumno",StopSign!)		
		return -1
	end if
end if

return ll_row_child
end function

on uo_carreras_alumno_posgrado.create
call super::create
end on

on uo_carreras_alumno_posgrado.destroy
call super::destroy
end on

type dw_1 from uo_clave_texto_01`dw_1 within uo_carreras_alumno_posgrado
integer x = 0
integer y = 0
integer width = 2286
integer height = 96
string dataobject = "duo_carreras_plan_pos"
end type

event dw_1::constructor;this.SetTransObject(gtr_sce)

end event
