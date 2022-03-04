$PBExportHeader$uo_carreras_paquete_nvo.sru
forward
global type uo_carreras_paquete_nvo from userobject
end type
type dw_carreras from datawindow within uo_carreras_paquete_nvo
end type
end forward

global type uo_carreras_paquete_nvo from userobject
integer width = 1253
integer height = 152
boolean border = true
long backcolor = 67108864
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_carreras dw_carreras
end type
global uo_carreras_paquete_nvo uo_carreras_paquete_nvo

type variables

STRING is_filtra 

end variables

forward prototypes
public function long of_obten_cve_carrera ()
public function integer of_filtra (long al_cve_coord)
end prototypes

public function long of_obten_cve_carrera ();//of_obten_cve_carrera
//Devuelve la carrera seleccionada

long ll_row_carrera, ll_cve_carrera

ll_row_carrera = this.dw_carreras.GetRow()

IF ll_row_carrera <> 0 THEN 
	ll_cve_carrera = this.dw_carreras.object.cve_carrera[ll_row_carrera]
END IF	

return ll_cve_carrera


end function

public function integer of_filtra (long al_cve_coord);DATAWINDOWCHILD dwc_carreras

dw_carreras.GETCHILD("cve_carrera", dwc_carreras) 
dwc_carreras.SETFILTER("cve_coordinacion = " + STRING(al_cve_coord)) 
dwc_carreras.FILTER() 

dw_carreras.SETFILTER("cve_coordinacion = " + STRING(al_cve_coord)) 
dw_carreras.FILTER() 

RETURN 0 





end function

on uo_carreras_paquete_nvo.create
this.dw_carreras=create dw_carreras
this.Control[]={this.dw_carreras}
end on

on uo_carreras_paquete_nvo.destroy
destroy(this.dw_carreras)
end on

type dw_carreras from datawindow within uo_carreras_paquete_nvo
integer x = 5
integer y = 28
integer width = 1216
integer height = 92
integer taborder = 10
string dataobject = "d_carreras_paquetes_nvo"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;long ll_n_rows

this.SetTransObject(gtr_sce)
ll_n_rows= this.Retrieve()
this.ScrollToRow(ll_n_rows)

end event

