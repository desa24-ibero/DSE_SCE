$PBExportHeader$uo_dgmu_coordinaciones.sru
forward
global type uo_dgmu_coordinaciones from userobject
end type
type dw_coordinaciones from datawindow within uo_dgmu_coordinaciones
end type
end forward

global type uo_dgmu_coordinaciones from userobject
integer width = 1253
integer height = 152
boolean border = true
long backcolor = 12632256
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_coordinaciones dw_coordinaciones
end type
global uo_dgmu_coordinaciones uo_dgmu_coordinaciones

on uo_dgmu_coordinaciones.create
this.dw_coordinaciones=create dw_coordinaciones
this.Control[]={this.dw_coordinaciones}
end on

on uo_dgmu_coordinaciones.destroy
destroy(this.dw_coordinaciones)
end on

type dw_coordinaciones from datawindow within uo_dgmu_coordinaciones
integer x = 5
integer y = 28
integer width = 1216
integer height = 92
integer taborder = 10
string dataobject = "d_dgmu_coordinaciones"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;long ll_n_rows

this.SetTransObject(gtr_sce)
ll_n_rows = this.Retrieve()
this.ScrollToRow(ll_n_rows)

end event

