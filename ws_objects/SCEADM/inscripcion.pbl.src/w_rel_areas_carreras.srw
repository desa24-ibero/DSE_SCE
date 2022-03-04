$PBExportHeader$w_rel_areas_carreras.srw
$PBExportComments$Relación Areas de evaluación con Carreras
forward
global type w_rel_areas_carreras from window
end type
type pb_delete from picturebutton within w_rel_areas_carreras
end type
type pb_insert from picturebutton within w_rel_areas_carreras
end type
type dw_carrera from datawindow within w_rel_areas_carreras
end type
type cb_salir from commandbutton within w_rel_areas_carreras
end type
type cb_guardar from commandbutton within w_rel_areas_carreras
end type
type dw_area_carrera_relacion from datawindow within w_rel_areas_carreras
end type
end forward

global type w_rel_areas_carreras from window
integer width = 3159
integer height = 1488
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
pb_delete pb_delete
pb_insert pb_insert
dw_carrera dw_carrera
cb_salir cb_salir
cb_guardar cb_guardar
dw_area_carrera_relacion dw_area_carrera_relacion
end type
global w_rel_areas_carreras w_rel_areas_carreras

on w_rel_areas_carreras.create
this.pb_delete=create pb_delete
this.pb_insert=create pb_insert
this.dw_carrera=create dw_carrera
this.cb_salir=create cb_salir
this.cb_guardar=create cb_guardar
this.dw_area_carrera_relacion=create dw_area_carrera_relacion
this.Control[]={this.pb_delete,&
this.pb_insert,&
this.dw_carrera,&
this.cb_salir,&
this.cb_guardar,&
this.dw_area_carrera_relacion}
end on

on w_rel_areas_carreras.destroy
destroy(this.pb_delete)
destroy(this.pb_insert)
destroy(this.dw_carrera)
destroy(this.cb_salir)
destroy(this.cb_guardar)
destroy(this.dw_area_carrera_relacion)
end on

event open;dw_carrera.SETTRANSOBJECT(gtr_sadm) 
dw_carrera.INSERTROW(0)
end event

type pb_delete from picturebutton within w_rel_areas_carreras
integer x = 2789
integer y = 232
integer width = 110
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "DeleteRow!"
alignment htextalign = left!
end type

event clicked;//LONG ll_cve_carrera
//STRING ls_prop, ls_error
//
//
//ll_cve_carrera = dw_carrera.GETITEMNUMBER(1, "cve_carrera") 
//IF ISNULL(ll_cve_carrera) THEN 
//	MESSAGEBOX("Aviso", "No se ha seleccionado ninguna carrera.")
//	RETURN 1
//END IF
//
//LONG ll_currentrow 
//
//ll_currentrow = dw_propedeutico_lista.GETROW() 
//ls_prop = dw_propedeutico_lista.GETITEMSTRING(ll_currentrow, "id_prop") 
//IF (ISNULL(ls_prop) OR ls_prop = "") THEN  
//	MESSAGEBOX("Aviso", "No se ha seleccionado ningún propedéutico.")
//	RETURN 1
//END IF 
//
//IF MESSAGEBOX("Confirmación", "Se borrará el Propedéutico y los pesos por área asociados. ¿Desea Continuar?", Question!, YesNo!, 2) = 2 THEN RETURN 0
//
//
//DELETE FROM prop_carrera_minimos 
//WHERE cve_carrera = :ll_cve_carrera 
//AND id_prop = :ls_prop 
//USING gtr_sadm; 
//IF gtr_sadm.SQLCODE < 0 THEN 
//	ls_error = gtr_sadm.SQLERRTEXT
//	ROLLBACK USING gtr_sadm; 
//	MESSAGEBOX("Error", "Se produjo un error al borrar el Propedéutico asociado a la Carrera:" + ls_error )
//	RETURN -1
//END IF
//
//DELETE FROM prop_carrera_peso 
//WHERE cve_carrera = :ll_cve_carrera 
//AND id_prop = :ls_prop 
//USING gtr_sadm; 
//IF gtr_sadm.SQLCODE < 0 THEN 
//	ls_error = gtr_sadm.SQLERRTEXT
//	ROLLBACK USING gtr_sadm; 
//	MESSAGEBOX("Error", "Se produjo un error al borrar el peso por área del Propedéutico:" + ls_error )
//	RETURN -1
//END IF
//
//COMMIT USING gtr_sadm; 
//
//dw_carrera.TRIGGEREVENT("carga") 
//
//
//
//
//
//
//
//
//
end event

type pb_insert from picturebutton within w_rel_areas_carreras
integer x = 2665
integer y = 232
integer width = 110
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Insert5!"
alignment htextalign = left!
end type

event clicked;//LONG ll_cve_carrera 
//
//
//ll_cve_carrera = dw_carrera.GETITEMNUMBER(1, "cve_carrera") 
//IF ISNULL(ll_cve_carrera) THEN 
//	MESSAGEBOX("Aviso", "No se ha seleccionado ninguna carrera.")
//	RETURN 0
//END IF
//
//
//INTEGER le_row
//le_row = dw_propedeutico_lista.INSERTROW(0)
//dw_propedeutico_lista.SETITEM(le_row, "cve_carrera", ll_cve_carrera) 
//
//
////dw_propedeutico_lista.SCROLLTOROW(le_row)
////dw_propedeutico_lista.SETROW(le_row) 
//
//
//
//
//
//
//
//
end event

type dw_carrera from datawindow within w_rel_areas_carreras
event carga ( )
integer x = 137
integer y = 56
integer width = 2341
integer height = 116
integer taborder = 10
string title = "none"
string dataobject = "dw_prop_selecciona_carrera"
boolean border = false
boolean livescroll = true
end type

event carga();INTEGER le_pos
INTEGER le_ttl

le_ttl = dw_area_carrera_relacion.ROWCOUNT()
FOR le_pos = 1 TO le_ttl 
	dw_area_carrera_relacion.DELETEROW(1)
NEXT
dw_area_carrera_relacion.RESET()
//wf_carga_detalles() 



end event

event itemchanged;POSTEVENT("carga")



end event

type cb_salir from commandbutton within w_rel_areas_carreras
integer x = 2665
integer y = 508
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

type cb_guardar from commandbutton within w_rel_areas_carreras
integer x = 2665
integer y = 368
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar"
end type

type dw_area_carrera_relacion from datawindow within w_rel_areas_carreras
integer x = 64
integer y = 232
integer width = 2537
integer height = 956
integer taborder = 10
string title = "none"
string dataobject = "dw_area_carrera_relacion"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

