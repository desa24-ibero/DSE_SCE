$PBExportHeader$uo_planes.sru
forward
global type uo_planes from userobject
end type
type dw_planes from datawindow within uo_planes
end type
end forward

global type uo_planes from userobject
integer width = 562
integer height = 104
boolean border = true
long backcolor = 67108864
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_planes dw_planes
end type
global uo_planes uo_planes

on uo_planes.create
this.dw_planes=create dw_planes
this.Control[]={this.dw_planes}
end on

on uo_planes.destroy
destroy(this.dw_planes)
end on

type dw_planes from datawindow within uo_planes
integer width = 553
integer height = 92
integer taborder = 10
string dataobject = "d_plan"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;long ll_n_rows

this.SetTransObject(gtr_sce)
ll_n_rows= this.Retrieve()
//this.ScrollToRow(ll_n_rows)
this.ScrollToRow(7)

end event

