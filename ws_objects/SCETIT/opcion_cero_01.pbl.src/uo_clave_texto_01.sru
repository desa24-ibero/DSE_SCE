$PBExportHeader$uo_clave_texto_01.sru
forward
global type uo_clave_texto_01 from uo_clave_texto
end type
end forward

global type uo_clave_texto_01 from uo_clave_texto
end type
global uo_clave_texto_01 uo_clave_texto_01

forward prototypes
public function string of_obten_texto_02 ()
public function long of_obten_clave_02 ()
end prototypes

public function string of_obten_texto_02 ();//of_obten_texto_02
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
		ls_texto = lds_datastore.GetItemString(ll_row_texto,4)		
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

public function long of_obten_clave_02 ();//of_obten_clave_02
//Devuelve la clave seleccionada

long ll_row_actual, ll_clave
ll_row_actual= dw_1.GetRow()
if ll_row_actual >0 then
	ll_clave = dw_1.GetItemNumber(ll_row_actual,3)
else
	ll_clave =0
end if

return ll_clave


end function

on uo_clave_texto_01.create
call super::create
end on

on uo_clave_texto_01.destroy
call super::destroy
end on

type dw_1 from uo_clave_texto`dw_1 within uo_clave_texto_01
end type

