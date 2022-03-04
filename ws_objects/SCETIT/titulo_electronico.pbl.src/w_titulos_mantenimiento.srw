$PBExportHeader$w_titulos_mantenimiento.srw
forward
global type w_titulos_mantenimiento from window
end type
type pb_delete from picturebutton within w_titulos_mantenimiento
end type
type pb_insert from picturebutton within w_titulos_mantenimiento
end type
type cb_2 from commandbutton within w_titulos_mantenimiento
end type
type cb_1 from commandbutton within w_titulos_mantenimiento
end type
type dw_documentos from datawindow within w_titulos_mantenimiento
end type
end forward

global type w_titulos_mantenimiento from window
integer width = 4498
integer height = 1416
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
cb_2 cb_2
cb_1 cb_1
dw_documentos dw_documentos
end type
global w_titulos_mantenimiento w_titulos_mantenimiento

on w_titulos_mantenimiento.create
this.pb_delete=create pb_delete
this.pb_insert=create pb_insert
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_documentos=create dw_documentos
this.Control[]={this.pb_delete,&
this.pb_insert,&
this.cb_2,&
this.cb_1,&
this.dw_documentos}
end on

on w_titulos_mantenimiento.destroy
destroy(this.pb_delete)
destroy(this.pb_insert)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_documentos)
end on

event open;dw_documentos.SETTRANSOBJECT(gtr_sce) 
dw_documentos.RETRIEVE() 



end event

type pb_delete from picturebutton within w_titulos_mantenimiento
boolean visible = false
integer x = 4599
integer y = 48
integer width = 110
integer height = 96
integer taborder = 20
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

type pb_insert from picturebutton within w_titulos_mantenimiento
boolean visible = false
integer x = 4402
integer y = 92
integer width = 110
integer height = 96
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Insert5!"
alignment htextalign = left!
end type

event clicked;
INTEGER le_row
le_row = dw_documentos.INSERTROW(0)
//dw_documentos.SETITEM(le_row, "cve_carrera", ll_cve_carrera) 







end event

type cb_2 from commandbutton within w_titulos_mantenimiento
integer x = 3963
integer y = 1148
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Salir"
end type

event clicked;CLOSE(PARENT)
end event

type cb_1 from commandbutton within w_titulos_mantenimiento
integer x = 3520
integer y = 1148
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Guardar"
end type

event clicked;
IF dw_documentos.UPDATE()  < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al actualizar la información.")	
ELSE
	MESSAGEBOX("Aviso", "La información fué actualizada con éxito.")	  
END IF 

RETURN 0 






end event

type dw_documentos from datawindow within w_titulos_mantenimiento
integer x = 82
integer y = 80
integer width = 4283
integer height = 996
integer taborder = 10
string title = "none"
string dataobject = "dw_titulo_mantenimiento_e"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

