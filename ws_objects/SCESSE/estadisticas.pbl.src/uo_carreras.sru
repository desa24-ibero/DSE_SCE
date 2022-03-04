$PBExportHeader$uo_carreras.sru
forward
global type uo_carreras from userobject
end type
type dw_carreras from datawindow within uo_carreras
end type
end forward

global type uo_carreras from userobject
integer width = 1253
integer height = 152
boolean border = true
long backcolor = 67108864
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_carreras dw_carreras
end type
global uo_carreras uo_carreras

forward prototypes
public function long of_obten_cve_carrera ()
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

on uo_carreras.create
this.dw_carreras=create dw_carreras
this.Control[]={this.dw_carreras}
end on

on uo_carreras.destroy
destroy(this.dw_carreras)
end on

type dw_carreras from datawindow within uo_carreras
integer x = 5
integer y = 28
integer width = 1216
integer height = 92
integer taborder = 10
string dataobject = "d_carreras"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;long ll_n_rows

this.SetTransObject(gtr_sce)
ll_n_rows= this.Retrieve()
this.ScrollToRow(ll_n_rows)

end event

