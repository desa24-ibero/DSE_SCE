$PBExportHeader$uo_lista_coords.sru
forward
global type uo_lista_coords from userobject
end type
type dw_coordinacion from datawindow within uo_lista_coords
end type
end forward

global type uo_lista_coords from userobject
integer width = 1289
integer height = 148
boolean border = true
long backcolor = 67108864
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_coordinacion dw_coordinacion
end type
global uo_lista_coords uo_lista_coords

on uo_lista_coords.create
this.dw_coordinacion=create dw_coordinacion
this.Control[]={this.dw_coordinacion}
end on

on uo_lista_coords.destroy
destroy(this.dw_coordinacion)
end on

type dw_coordinacion from datawindow within uo_lista_coords
integer x = 23
integer y = 20
integer width = 1221
integer height = 96
integer taborder = 10
string dataobject = "d_coordinaciones"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;
datawindowchild ldw_coordinaciones
LONG ll_num_coord

THIS.GETCHILD("cve_coordinacion", ldw_coordinaciones)
ldw_coordinaciones.SETTRANSOBJECT(gtr_sce) 
ll_num_coord = ldw_coordinaciones.RETRIEVE(gs_tipo_periodo) 
IF ll_num_coord = 0 THEN 
	MESSAGEBOX("Aviso", "No se encontraron coordinaciones de tipo " + gs_descripcion_tipo_periodo)
END IF



integer ll_num_rows
this.SetTransObject(gtr_sce)
ll_num_rows= this.Retrieve()
this.ScrollToRow(ll_num_rows)


end event

