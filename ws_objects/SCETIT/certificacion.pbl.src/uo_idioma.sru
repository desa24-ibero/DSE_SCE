$PBExportHeader$uo_idioma.sru
forward
global type uo_idioma from uo_clave_texto
end type
end forward

global type uo_idioma from uo_clave_texto
integer width = 960
integer height = 176
long backcolor = 12632256
end type
global uo_idioma uo_idioma

forward prototypes
public function long of_obten_clave ()
end prototypes

public function long of_obten_clave ();//of_obten_clave
//Devuelve la clave seleccionada

long ll_row_actual, ll_clave

dw_1.AcceptText()

ll_row_actual= dw_1.GetRow()

if ll_row_actual >0 then
	ll_clave = dw_1.GetItemNumber(ll_row_actual,1)
else
	ll_clave =0
end if

return ll_clave

end function

on uo_idioma.create
call super::create
end on

on uo_idioma.destroy
call super::destroy
end on

type dw_1 from uo_clave_texto`dw_1 within uo_idioma
integer width = 827
integer height = 104
string dataobject = "d_uo_idioma"
end type

