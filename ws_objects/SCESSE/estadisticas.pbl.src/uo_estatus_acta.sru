$PBExportHeader$uo_estatus_acta.sru
forward
global type uo_estatus_acta from userobject
end type
type dw_estatus_acta from datawindow within uo_estatus_acta
end type
end forward

global type uo_estatus_acta from userobject
integer width = 1079
integer height = 152
boolean border = true
long backcolor = 12632256
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_estatus_acta dw_estatus_acta
end type
global uo_estatus_acta uo_estatus_acta

on uo_estatus_acta.create
this.dw_estatus_acta=create dw_estatus_acta
this.Control[]={this.dw_estatus_acta}
end on

on uo_estatus_acta.destroy
destroy(this.dw_estatus_acta)
end on

type dw_estatus_acta from datawindow within uo_estatus_acta
integer x = 5
integer y = 28
integer width = 1015
integer height = 92
integer taborder = 10
string dataobject = "d_estatus_acta"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;long ll_n_rows

this.SetTransObject(gtr_sce)
ll_n_rows = this.Retrieve()
this.ScrollToRow(ll_n_rows)

end event

