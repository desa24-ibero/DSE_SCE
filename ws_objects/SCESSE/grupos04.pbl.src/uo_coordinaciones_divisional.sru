$PBExportHeader$uo_coordinaciones_divisional.sru
forward
global type uo_coordinaciones_divisional from userobject
end type
type dw_coordinaciones from datawindow within uo_coordinaciones_divisional
end type
end forward

global type uo_coordinaciones_divisional from userobject
integer width = 1312
integer height = 152
boolean border = true
long backcolor = 67108864
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event carga ( )
dw_coordinaciones dw_coordinaciones
end type
global uo_coordinaciones_divisional uo_coordinaciones_divisional

type variables
LONG il_division 



end variables

forward prototypes
public function long of_obten_cve_coordinacion ()
public subroutine of_coordinaciones_completas ()
end prototypes

event carga();
dw_coordinaciones.TRIGGEREVENT("carga") 

end event

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

public subroutine of_coordinaciones_completas ();
dw_coordinaciones.DATAOBJECT = "d_coordinaciones_uo_2" 
TRIGGEREVENT("carga")


end subroutine

on uo_coordinaciones_divisional.create
this.dw_coordinaciones=create dw_coordinaciones
this.Control[]={this.dw_coordinaciones}
end on

on uo_coordinaciones_divisional.destroy
destroy(this.dw_coordinaciones)
end on

event constructor;
//POSTEVENT("carga") 
end event

type dw_coordinaciones from datawindow within uo_coordinaciones_divisional
event carga ( )
integer x = 5
integer y = 28
integer width = 1280
integer height = 92
integer taborder = 10
string dataobject = "d_coordinaciones_uo_divisional"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event carga();
long ll_n_rows
DATAWINDOWCHILD ldwc
STRING ls_query 

ls_query = " SELECT coordinaciones.cve_coordinacion,  coordinaciones.coordinacion  " + & 
				" FROM coordinaciones, departamentos, divisiones  " + &   
				" WHERE coordinaciones.cve_depto = departamentos.cve_depto  " + & 
				" AND departamentos.cve_division = divisiones.cve_division  " + & 
				" AND (divisiones.cve_division = " + STRING(il_division) + " OR " + STRING(il_division) + " = 9999)  " + & 
				" UNION " + & 
				" SELECT 9999, ~~'Todos~~' " + &
				" ORDER BY 1 ASC   "   
				
dw_coordinaciones.RESET()
dw_coordinaciones.INSERTROW(0)
dw_coordinaciones.GETCHILD("cve_coordinacion", ldwc)
ldwc.MODIFY("Datawindow.Table.Select = '" + ls_query + "'") 
ldwc.SetTransObject(gtr_sce)
ll_n_rows = ldwc.Retrieve(gs_tipo_periodo)
ldwc.ScrollToRow(ll_n_rows)



//dw_coordinaciones.SetTransObject(gtr_sce)
//ll_n_rows = dw_coordinaciones.Retrieve(gs_tipo_periodo)
//dw_coordinaciones.ScrollToRow(ll_n_rows)


end event

event constructor;//long ll_n_rows
//
//THIS.SetTransObject(gtr_sce)
//ll_n_rows = THIS.Retrieve(gs_tipo_periodo)
//THIS.ScrollToRow(ll_n_rows)
//
end event

