$PBExportHeader$w_propedeutico_catalogos.srw
forward
global type w_propedeutico_catalogos from window
end type
type cb_1 from commandbutton within w_propedeutico_catalogos
end type
type pb_9 from picturebutton within w_propedeutico_catalogos
end type
type pb_8 from picturebutton within w_propedeutico_catalogos
end type
type pb_7 from picturebutton within w_propedeutico_catalogos
end type
type pb_6 from picturebutton within w_propedeutico_catalogos
end type
type pb_5 from picturebutton within w_propedeutico_catalogos
end type
type pb_4 from picturebutton within w_propedeutico_catalogos
end type
type pb_3 from picturebutton within w_propedeutico_catalogos
end type
type pb_2 from picturebutton within w_propedeutico_catalogos
end type
type pb_1 from picturebutton within w_propedeutico_catalogos
end type
type pb_guarda_prop from picturebutton within w_propedeutico_catalogos
end type
type pb_delete from picturebutton within w_propedeutico_catalogos
end type
type pb_insert from picturebutton within w_propedeutico_catalogos
end type
type dw_prop_tipo_alumno_rel from datawindow within w_propedeutico_catalogos
end type
type dw_prop_materia from datawindow within w_propedeutico_catalogos
end type
type dw_tipo_alumno from datawindow within w_propedeutico_catalogos
end type
type dw_prop from datawindow within w_propedeutico_catalogos
end type
type gb_1 from groupbox within w_propedeutico_catalogos
end type
type gb_2 from groupbox within w_propedeutico_catalogos
end type
type gb_3 from groupbox within w_propedeutico_catalogos
end type
type gb_4 from groupbox within w_propedeutico_catalogos
end type
end forward

global type w_propedeutico_catalogos from window
integer width = 3813
integer height = 2140
boolean titlebar = true
string title = "Propedéuticos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
pb_9 pb_9
pb_8 pb_8
pb_7 pb_7
pb_6 pb_6
pb_5 pb_5
pb_4 pb_4
pb_3 pb_3
pb_2 pb_2
pb_1 pb_1
pb_guarda_prop pb_guarda_prop
pb_delete pb_delete
pb_insert pb_insert
dw_prop_tipo_alumno_rel dw_prop_tipo_alumno_rel
dw_prop_materia dw_prop_materia
dw_tipo_alumno dw_tipo_alumno
dw_prop dw_prop
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
end type
global w_propedeutico_catalogos w_propedeutico_catalogos

type variables
STRING is_error
end variables

on w_propedeutico_catalogos.create
this.cb_1=create cb_1
this.pb_9=create pb_9
this.pb_8=create pb_8
this.pb_7=create pb_7
this.pb_6=create pb_6
this.pb_5=create pb_5
this.pb_4=create pb_4
this.pb_3=create pb_3
this.pb_2=create pb_2
this.pb_1=create pb_1
this.pb_guarda_prop=create pb_guarda_prop
this.pb_delete=create pb_delete
this.pb_insert=create pb_insert
this.dw_prop_tipo_alumno_rel=create dw_prop_tipo_alumno_rel
this.dw_prop_materia=create dw_prop_materia
this.dw_tipo_alumno=create dw_tipo_alumno
this.dw_prop=create dw_prop
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.Control[]={this.cb_1,&
this.pb_9,&
this.pb_8,&
this.pb_7,&
this.pb_6,&
this.pb_5,&
this.pb_4,&
this.pb_3,&
this.pb_2,&
this.pb_1,&
this.pb_guarda_prop,&
this.pb_delete,&
this.pb_insert,&
this.dw_prop_tipo_alumno_rel,&
this.dw_prop_materia,&
this.dw_tipo_alumno,&
this.dw_prop,&
this.gb_1,&
this.gb_2,&
this.gb_3,&
this.gb_4}
end on

on w_propedeutico_catalogos.destroy
destroy(this.cb_1)
destroy(this.pb_9)
destroy(this.pb_8)
destroy(this.pb_7)
destroy(this.pb_6)
destroy(this.pb_5)
destroy(this.pb_4)
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.pb_guarda_prop)
destroy(this.pb_delete)
destroy(this.pb_insert)
destroy(this.dw_prop_tipo_alumno_rel)
destroy(this.dw_prop_materia)
destroy(this.dw_tipo_alumno)
destroy(this.dw_prop)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
end on

event open;dw_prop.SETTRANSOBJECT(gtr_sadm) 
dw_prop.RETRIEVE()

dw_tipo_alumno.SETTRANSOBJECT(gtr_sadm)  
dw_tipo_alumno.RETRIEVE() 

dw_prop_tipo_alumno_rel.SETTRANSOBJECT(gtr_sadm)  
dw_prop_tipo_alumno_rel.RETRIEVE() 

dw_prop_materia.SETTRANSOBJECT(gtr_sadm)  
dw_prop_materia.RETRIEVE() 





end event

type cb_1 from commandbutton within w_propedeutico_catalogos
integer x = 3264
integer y = 1852
integer width = 402
integer height = 112
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;CLOSE(PARENT) 


end event

type pb_9 from picturebutton within w_propedeutico_catalogos
integer x = 3502
integer y = 1652
integer width = 110
integer height = 96
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Save!"
alignment htextalign = left!
end type

event clicked;IF dw_prop_tipo_alumno_rel.UPDATE() = 1 THEN 
	COMMIT USING gtr_sadm; 
	MESSAGEBOX("Éxito", "La relación fué guardada con Éxito.")
ELSE
	ROLLBACK USING gtr_sadm;
	MESSAGEBOX("Error", "Se produjo un error al Eliminar la Relación: " + is_error) 
END IF



end event

type pb_8 from picturebutton within w_propedeutico_catalogos
integer x = 3369
integer y = 1652
integer width = 110
integer height = 96
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "DeleteRow!"
alignment htextalign = left!
end type

event clicked;INTEGER le_row
LONG li_id_tipo
STRING ls_error
LONG ll_ttl 

IF MESSAGEBOX("Confirmación", "La relación entre Propedéutico y Tipo de Alumno Seleccionada será Eliminada. ¿Desea continuar?", Question!, OKCancel!) = 2 THEN RETURN 0

le_row = dw_prop_tipo_alumno_rel.GETROW() 
dw_prop_tipo_alumno_rel.DELETEROW(le_row)  







end event

type pb_7 from picturebutton within w_propedeutico_catalogos
integer x = 3237
integer y = 1652
integer width = 110
integer height = 96
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Insert5!"
alignment htextalign = left!
end type

event clicked;INTEGER le_row

le_row = dw_prop_tipo_alumno_rel.INSERTROW(0) 


end event

type pb_6 from picturebutton within w_propedeutico_catalogos
integer x = 3479
integer y = 868
integer width = 110
integer height = 96
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Save!"
alignment htextalign = left!
end type

event clicked;IF dw_prop_materia.UPDATE() = 1 THEN 
	COMMIT USING gtr_sadm; 
	MESSAGEBOX("Éxito", "La relación fué guardada con Éxito.")
ELSE
	ROLLBACK USING gtr_sadm;
	MESSAGEBOX("Error", "Se produjo un error al Eliminar la Relación: " + is_error) 
END IF



end event

type pb_5 from picturebutton within w_propedeutico_catalogos
integer x = 3346
integer y = 868
integer width = 110
integer height = 96
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "DeleteRow!"
alignment htextalign = left!
end type

event clicked;INTEGER le_row
LONG li_id_tipo
STRING ls_error
LONG ll_ttl 

IF MESSAGEBOX("Confirmación", "La relación entre Propedéutico y Materia Seleccionada será Eliminada. ¿Desea continuar?", Question!, OKCancel!) = 2 THEN RETURN 0

le_row = dw_prop_materia.GETROW() 
dw_prop_materia.DELETEROW(le_row)  



end event

type pb_4 from picturebutton within w_propedeutico_catalogos
integer x = 3214
integer y = 868
integer width = 110
integer height = 96
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Insert5!"
alignment htextalign = left!
end type

event clicked;INTEGER le_row

le_row = dw_prop_materia.INSERTROW(0) 


end event

type pb_3 from picturebutton within w_propedeutico_catalogos
integer x = 1536
integer y = 1652
integer width = 110
integer height = 96
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Save!"
alignment htextalign = left!
end type

event clicked;IF dw_tipo_alumno.UPDATE() = 1 THEN 
	COMMIT USING gtr_sadm; 
	MESSAGEBOX("Éxito", "El Tipo Alumno fué guardado con Éxito.")
ELSE
	ROLLBACK USING gtr_sadm;
	MESSAGEBOX("Error", "Se produjo un error al insertar el Tipo Alumno: " + is_error)
END IF



end event

type pb_2 from picturebutton within w_propedeutico_catalogos
integer x = 1403
integer y = 1652
integer width = 110
integer height = 96
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "DeleteRow!"
alignment htextalign = left!
end type

event clicked;INTEGER le_row
LONG li_id_tipo
STRING ls_error
LONG ll_ttl 

IF MESSAGEBOX("Confirmación", "El Tipo de Alumno Seleccionado será Eliminado. ¿Desea continuar?", Question!, OKCancel!) = 2 THEN RETURN 0

le_row = dw_tipo_alumno.GETROW() 

li_id_tipo = dw_tipo_alumno.GETITEMNUMBER(le_row, "id_tipo") 
IF ISNULL(li_id_tipo) THEN dw_tipo_alumno.DELETEROW(le_row)  

SELECT COUNT(*) 
INTO :ll_ttl
FROM prop_rel_alumno_tipo
WHERE id_tipo = :li_id_tipo
USING gtr_sadm; 
IF gtr_sadm.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al verificar la relación con Propedéutico: " + gtr_sadm.SQLERRTEXT ) 
	RETURN 0	
END IF 
IF ll_ttl > 0 THEN 
	MESSAGEBOX("Aviso", "No puede eliminarse el Tipo de Alumno porque tiene relación con Propedéutico")  
	RETURN 0
END IF


dw_tipo_alumno.DELETEROW(le_row)  





end event

type pb_1 from picturebutton within w_propedeutico_catalogos
integer x = 1271
integer y = 1652
integer width = 110
integer height = 96
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Insert5!"
alignment htextalign = left!
end type

event clicked;INTEGER le_row

le_row = dw_tipo_alumno.INSERTROW(0) 


end event

type pb_guarda_prop from picturebutton within w_propedeutico_catalogos
integer x = 1536
integer y = 868
integer width = 110
integer height = 96
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Save!"
alignment htextalign = left!
end type

event clicked;IF dw_prop.UPDATE() = 1 THEN 
	COMMIT USING gtr_sadm; 
	MESSAGEBOX("Éxito", "El Propedéutico fué guardado con Éxito.")
ELSE
	ROLLBACK USING gtr_sadm;
	MESSAGEBOX("Error", "Se produjo un errore al insertar el propedéutico: " + is_error)
END IF



end event

type pb_delete from picturebutton within w_propedeutico_catalogos
integer x = 1403
integer y = 868
integer width = 110
integer height = 96
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "DeleteRow!"
alignment htextalign = left!
end type

event clicked;INTEGER le_row
STRING ls_id_prop
STRING ls_error
LONG ll_ttl

IF MESSAGEBOX("Confirmación", "El Propedéutico Seleccionado será Eliminado. ¿Desea continuar?", Question!, OKCancel!) = 2 THEN RETURN 0

le_row = dw_prop.GETROW() 

ls_id_prop = dw_prop.GETITEMSTRING(le_row, "id_prop") 
IF ISNULL(ls_id_prop) OR TRIM(ls_id_prop) = "" THEN dw_prop.DELETEROW(le_row) 


SELECT COUNT(*) 
INTO :ll_ttl
FROM prop_rel_alumno_tipo
WHERE id_prop = :ls_id_prop 
USING gtr_sadm; 
IF gtr_sadm.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al verificar la relación con Tipo de Alumno: " + gtr_sadm.SQLERRTEXT ) 
	RETURN 0	
END IF 

SELECT COUNT(*) 
INTO :ll_ttl
FROM prop_rel_materia
WHERE id_prop = :ls_id_prop 
USING gtr_sadm; 
IF gtr_sadm.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al verificar la relación con Materias: " + gtr_sadm.SQLERRTEXT ) 
	RETURN 0	
END IF 
IF ll_ttl > 0 THEN 
	MESSAGEBOX("Aviso", "No puede eliminarse el Propedéutico porque tiene relación con Materias")  
	RETURN 0
END IF

SELECT COUNT(*) 
INTO :ll_ttl
FROM prop_carrera_peso
WHERE id_prop = :ls_id_prop 
USING gtr_sadm; 
IF gtr_sadm.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al verificar la relación con Peso por Área de Evaluación: " + gtr_sadm.SQLERRTEXT )  
	RETURN 0	
END IF 
IF ll_ttl > 0 THEN 
	MESSAGEBOX("Aviso", "No puede eliminarse el Propedéutico porque tiene relación con Peso por Área de Evaluación")  
	RETURN 0
END IF

SELECT COUNT(*) 
INTO :ll_ttl
FROM prop_carrera_minimos
WHERE id_prop = :ls_id_prop 
USING gtr_sadm; 
IF gtr_sadm.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al verificar la relación con Mínimos para Asignar Propedéutico: " + gtr_sadm.SQLERRTEXT )  
	RETURN 0	
END IF
IF ll_ttl > 0 THEN 
	MESSAGEBOX("Aviso", "No puede eliminarse el Propedéutico porque tiene relación con Mínimos para Asignar Propedéutico")  
	RETURN 0
END IF

SELECT COUNT(*) 
INTO :ll_ttl
FROM prop_alumno_asignacion
WHERE id_prop = :ls_id_prop 
USING gtr_sadm; 
IF gtr_sadm.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al verificar la relación con Alumnos: " + gtr_sadm.SQLERRTEXT )   
	RETURN 0	
END IF 
IF ll_ttl > 0 THEN 
	MESSAGEBOX("Aviso", "No puede eliminarse el Propedéutico porque tiene relación con Alumnos")  
	RETURN 0
END IF

dw_prop.DELETEROW(le_row)  



end event

type pb_insert from picturebutton within w_propedeutico_catalogos
integer x = 1271
integer y = 868
integer width = 110
integer height = 96
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Insert5!"
alignment htextalign = left!
end type

event clicked;INTEGER le_row

le_row = dw_prop.INSERTROW(0) 


end event

type dw_prop_tipo_alumno_rel from datawindow within w_propedeutico_catalogos
integer x = 1879
integer y = 1136
integer width = 1728
integer height = 480
integer taborder = 30
string title = "none"
string dataobject = "dw_prop_tipo_alumno_rel"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event error;is_error = errortext
end event

type dw_prop_materia from datawindow within w_propedeutico_catalogos
integer x = 1879
integer y = 124
integer width = 1728
integer height = 724
integer taborder = 30
string title = "none"
string dataobject = "dw_prop_materia_prop"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event error;is_error = errortext
end event

type dw_tipo_alumno from datawindow within w_propedeutico_catalogos
integer x = 160
integer y = 1136
integer width = 1504
integer height = 480
integer taborder = 20
string title = "none"
string dataobject = "dw_prop_tipo_alumno_cat"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event error;is_error = errortext
end event

type dw_prop from datawindow within w_propedeutico_catalogos
integer x = 160
integer y = 124
integer width = 1504
integer height = 724
integer taborder = 10
string title = "none"
string dataobject = "dw_propedeuticos_cat"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event error;is_error = errortext
end event

type gb_1 from groupbox within w_propedeutico_catalogos
integer x = 1838
integer y = 32
integer width = 1829
integer height = 968
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Propedéutico Materia:"
end type

type gb_2 from groupbox within w_propedeutico_catalogos
integer x = 91
integer y = 32
integer width = 1632
integer height = 968
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Propedéuticos: "
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_propedeutico_catalogos
integer x = 91
integer y = 1044
integer width = 1632
integer height = 752
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipos de alumno:"
end type

type gb_4 from groupbox within w_propedeutico_catalogos
integer x = 1838
integer y = 1044
integer width = 1829
integer height = 752
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Propedéutico Tipo Alumno:"
end type

