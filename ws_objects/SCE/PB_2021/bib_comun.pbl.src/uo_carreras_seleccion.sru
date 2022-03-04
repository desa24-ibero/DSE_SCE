$PBExportHeader$uo_carreras_seleccion.sru
forward
global type uo_carreras_seleccion from userobject
end type
type dw_carreras from datawindow within uo_carreras_seleccion
end type
end forward

global type uo_carreras_seleccion from userobject
integer width = 1906
integer height = 152
boolean border = true
long backcolor = 16777215
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_carreras dw_carreras
end type
global uo_carreras_seleccion uo_carreras_seleccion

forward prototypes
public function long of_obten_cve_carrera ()
public function string of_obten_carrera ()
end prototypes

public function long of_obten_cve_carrera ();//of_obten_cve_carrera
//Devuelve la carrera seleccionada

long ll_row_carrera, ll_cve_carrera

ll_row_carrera = this.dw_carreras.GetRow()
ll_cve_carrera = this.dw_carreras.object.cve_carrera[ll_row_carrera]

return ll_cve_carrera


end function

public function string of_obten_carrera ();//of_obten_carrera
//Devuelve la carrera seleccionada

long ll_obten_nombre_carrera, ll_cve_carrera
string ls_carrera

ll_cve_carrera = this.of_obten_cve_carrera()
ll_obten_nombre_carrera = f_obten_nombre_carrera(ll_cve_carrera, ls_carrera)


return ls_carrera



end function

on uo_carreras_seleccion.create
this.dw_carreras=create dw_carreras
this.Control[]={this.dw_carreras}
end on

on uo_carreras_seleccion.destroy
destroy(this.dw_carreras)
end on

type dw_carreras from datawindow within uo_carreras_seleccion
integer x = 5
integer y = 28
integer width = 1883
integer height = 92
integer taborder = 10
string dataobject = "d_carreras_seleccion"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;long ll_n_rows

this.SetTransObject(gtr_sce)
ll_n_rows= this.Retrieve()
this.ScrollToRow(ll_n_rows)

end event

