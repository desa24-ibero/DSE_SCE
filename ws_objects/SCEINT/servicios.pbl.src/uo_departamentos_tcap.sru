$PBExportHeader$uo_departamentos_tcap.sru
forward
global type uo_departamentos_tcap from userobject
end type
type dw_departamentos from datawindow within uo_departamentos_tcap
end type
end forward

global type uo_departamentos_tcap from userobject
integer width = 1454
integer height = 152
boolean border = true
long backcolor = 12632256
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_departamentos dw_departamentos
end type
global uo_departamentos_tcap uo_departamentos_tcap

forward prototypes
public function long of_obten_cve_depto ()
end prototypes

public function long of_obten_cve_depto ();//of_obten_cve_depto
//Devuelve la clave del departamento seleccionado
//			>0  Si es un departamento válido
//			 0  Si no existen departamentos
long ll_rows_departamentos, ll_row_departamento, ll_cve_depto

ll_rows_departamentos = dw_departamentos.RowCount()

IF ll_rows_departamentos> 0 THEN
	ll_row_departamento = dw_departamentos.GetRow()
	ll_cve_depto = dw_departamentos.GetItemNumber(ll_row_departamento, 2)
ELSE
	MessageBox("Tabla sin departamentos", "No existen departamentos registrados",StopSign!)
	ll_cve_depto = 0
	
END IF
return ll_cve_depto
end function

on uo_departamentos_tcap.create
this.dw_departamentos=create dw_departamentos
this.Control[]={this.dw_departamentos}
end on

on uo_departamentos_tcap.destroy
destroy(this.dw_departamentos)
end on

type dw_departamentos from datawindow within uo_departamentos_tcap
integer x = 5
integer y = 28
integer width = 1408
integer height = 92
integer taborder = 10
string dataobject = "d_tcap_departamentos"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;long ll_n_rows

this.SetTransObject(gtr_sce)
ll_n_rows = this.Retrieve()
this.ScrollToRow(ll_n_rows)

end event

