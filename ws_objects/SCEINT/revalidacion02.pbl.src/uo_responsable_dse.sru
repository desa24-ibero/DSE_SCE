$PBExportHeader$uo_responsable_dse.sru
forward
global type uo_responsable_dse from uo_clave_texto
end type
end forward

global type uo_responsable_dse from uo_clave_texto
long backcolor = 80269524
end type
global uo_responsable_dse uo_responsable_dse

forward prototypes
public function string of_obten_puesto ()
end prototypes

public function string of_obten_puesto ();//of_obten_puesto
//Devuelve el puesto seleccionado

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
		ls_texto = lds_datastore.GetItemString(ll_row_texto,3)		
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

on uo_responsable_dse.create
call super::create
end on

on uo_responsable_dse.destroy
call super::destroy
end on

type dw_1 from uo_clave_texto`dw_1 within uo_responsable_dse
string dataobject = "duo_responsable_dse"
end type

