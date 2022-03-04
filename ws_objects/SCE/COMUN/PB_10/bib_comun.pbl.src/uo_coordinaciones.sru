$PBExportHeader$uo_coordinaciones.sru
forward
global type uo_coordinaciones from userobject
end type
type dw_coordinaciones from datawindow within uo_coordinaciones
end type
end forward

global type uo_coordinaciones from userobject
integer width = 1253
integer height = 152
boolean border = true
long backcolor = 67108864
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_coordinaciones dw_coordinaciones
end type
global uo_coordinaciones uo_coordinaciones

forward prototypes
public function long of_obten_cve_coordinacion ()
end prototypes

public function long of_obten_cve_coordinacion ();//of_obten_cve_coordinacion
//Devuelve la clave de la coordinacion seleccionada
//			>0  Si es un coordinacion válido
//			 0  Si no existen coordinacion
long ll_rows_departamentos, ll_row_departamento, ll_cve_coordinacion

ll_rows_departamentos = dw_coordinaciones.RowCount()

IF ll_rows_departamentos> 0 THEN
	ll_row_departamento = dw_coordinaciones.GetRow()
	ll_cve_coordinacion = dw_coordinaciones.GetItemNumber(ll_row_departamento, 1)
ELSE
	MessageBox("Tabla sin coordinaciones", "No existen coordinaciones registradas",StopSign!)
	ll_cve_coordinacion = 0
	
END IF
return ll_cve_coordinacion
end function

on uo_coordinaciones.create
this.dw_coordinaciones=create dw_coordinaciones
this.Control[]={this.dw_coordinaciones}
end on

on uo_coordinaciones.destroy
destroy(this.dw_coordinaciones)
end on

type dw_coordinaciones from datawindow within uo_coordinaciones
integer x = 5
integer y = 28
integer width = 1216
integer height = 92
integer taborder = 10
string dataobject = "d_coordinaciones_uo"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;long ll_n_rows

this.SetTransObject(gtr_sce)
ll_n_rows = this.Retrieve()
this.ScrollToRow(ll_n_rows)

end event

