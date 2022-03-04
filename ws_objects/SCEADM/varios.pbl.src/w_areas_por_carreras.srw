$PBExportHeader$w_areas_por_carreras.srw
forward
global type w_areas_por_carreras from window
end type
type tab_1 from tab within w_areas_por_carreras
end type
type tab_carreras from userobject within tab_1
end type
type cb_2 from commandbutton within tab_carreras
end type
type cb_imprimir from commandbutton within tab_carreras
end type
type cb_1 from commandbutton within tab_carreras
end type
type pb_6 from picturebutton within tab_carreras
end type
type pb_5 from picturebutton within tab_carreras
end type
type dw_carrera_bloque from datawindow within tab_carreras
end type
type tab_carreras from userobject within tab_1
cb_2 cb_2
cb_imprimir cb_imprimir
cb_1 cb_1
pb_6 pb_6
pb_5 pb_5
dw_carrera_bloque dw_carrera_bloque
end type
type tab_config from userobject within tab_1
end type
type st_1 from statictext within tab_config
end type
type cb_guarda_bloque from commandbutton within tab_config
end type
type dw_lista_areas from datawindow within tab_config
end type
type pb_4 from picturebutton within tab_config
end type
type pb_agrega from picturebutton within tab_config
end type
type dw_areas_bloque from datawindow within tab_config
end type
type dw_bloques from datawindow within tab_config
end type
type tab_config from userobject within tab_1
st_1 st_1
cb_guarda_bloque cb_guarda_bloque
dw_lista_areas dw_lista_areas
pb_4 pb_4
pb_agrega pb_agrega
dw_areas_bloque dw_areas_bloque
dw_bloques dw_bloques
end type
type tab_areas from userobject within tab_1
end type
type cb_guarda_areas from commandbutton within tab_areas
end type
type pb_inserta_area from picturebutton within tab_areas
end type
type dw_areas from datawindow within tab_areas
end type
type tab_areas from userobject within tab_1
cb_guarda_areas cb_guarda_areas
pb_inserta_area pb_inserta_area
dw_areas dw_areas
end type
type tab_1 from tab within w_areas_por_carreras
tab_carreras tab_carreras
tab_config tab_config
tab_areas tab_areas
end type
end forward

global type w_areas_por_carreras from window
integer width = 4315
integer height = 1912
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
tab_1 tab_1
end type
global w_areas_por_carreras w_areas_por_carreras

type variables

// 1 = Nuevo, 2 = modificación 
INTEGER ie_modo_trabajo  



end variables

forward prototypes
public function integer wf_carga_bloque (integer id_bloque)
public function integer wf_filtra ()
end prototypes

public function integer wf_carga_bloque (integer id_bloque);STRING ls_desc_bloque 

SELECT descripcion 
INTO :ls_desc_bloque
FROM area_evaluacion_bloques 
WHERE id_bloque = :id_bloque
USING gtr_sadm; 
IF gtr_sadm.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar el bloque: " + gtr_sadm.SQLERRTEXT)
	RETURN -1
ELSEIF gtr_sadm.SQLCODE = 100 THEN 	 
	// Nuevo registro 
	ie_modo_trabajo = 1
ELSE
	// Registro modificado
	tab_1.tab_config.dw_bloques.SETITEM(1, "descripcion", ls_desc_bloque) 
	ie_modo_trabajo = 2
END IF 


tab_1.tab_config.dw_areas_bloque.SETTRANSOBJECT(gtr_sadm)
tab_1.tab_config.dw_areas_bloque.RETRIEVE(id_bloque) 

wf_filtra() 

RETURN 0




end function

public function integer wf_filtra ();INTEGER le_row
INTEGER le_ttl_row
STRING ls_areas, ls_coma
INTEGER le_area 

le_ttl_row = tab_1.tab_config.dw_areas_bloque.ROWCOUNT() 

IF le_ttl_row <= 0 THEN 
	tab_1.tab_config.dw_lista_areas.SETFILTER("") 
	tab_1.tab_config.dw_lista_areas.FILTER() 
	tab_1.tab_config.dw_lista_areas.SORT() 	
	RETURN 0
END IF 	

FOR le_row = 1 TO le_ttl_row 
	
	le_area = tab_1.tab_config.dw_areas_bloque.GETITEMNUMBER(le_row, "id_area") 
	
	ls_areas = ls_areas + ls_coma + STRING(le_area) 
	ls_coma = ","

NEXT 

ls_areas = "id_area NOT IN(" + ls_areas + ")"
tab_1.tab_config.dw_lista_areas.SETFILTER(ls_areas) 
tab_1.tab_config.dw_lista_areas.FILTER() 
tab_1.tab_config.dw_lista_areas.SORT() 


RETURN 0 



end function

on w_areas_por_carreras.create
this.tab_1=create tab_1
this.Control[]={this.tab_1}
end on

on w_areas_por_carreras.destroy
destroy(this.tab_1)
end on

event open;tab_1.tab_carreras.dw_carrera_bloque.SETTRANSOBJECT(gtr_sadm)
tab_1.tab_carreras.dw_carrera_bloque.RETRIEVE() 

end event

type tab_1 from tab within w_areas_por_carreras
integer x = 55
integer y = 76
integer width = 4123
integer height = 1640
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tab_carreras tab_carreras
tab_config tab_config
tab_areas tab_areas
end type

on tab_1.create
this.tab_carreras=create tab_carreras
this.tab_config=create tab_config
this.tab_areas=create tab_areas
this.Control[]={this.tab_carreras,&
this.tab_config,&
this.tab_areas}
end on

on tab_1.destroy
destroy(this.tab_carreras)
destroy(this.tab_config)
destroy(this.tab_areas)
end on

event selectionchanged;IF newindex = 1 THEN 


ELSEIF newindex = 2 THEN 
	tab_config.dw_bloques.RESET()
	tab_config.dw_bloques.INSERTROW(0)
	
	DATAWINDOWCHILD ldw_child
	
	tab_config.dw_bloques.GETCHILD( "id_bloque", ldw_child)
	ldw_child.SETTRANSOBJECT(gtr_sadm) 
	ldw_child.RETRIEVE() 
	
	tab_config.dw_lista_areas.SETTRANSOBJECT(gtr_sadm) 
	tab_config.dw_lista_areas.RETRIEVE()  
	
	tab_config.dw_areas_bloque.RESET() 
	
ELSEIF newindex = 3 THEN 
	tab_areas.dw_areas.SETTRANSOBJECT(gtr_sadm) 
	tab_areas.dw_areas.RETRIEVE() 
END IF


end event

type tab_carreras from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4087
integer height = 1512
long backcolor = 67108864
string text = "Carreras Bloque"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_2 cb_2
cb_imprimir cb_imprimir
cb_1 cb_1
pb_6 pb_6
pb_5 pb_5
dw_carrera_bloque dw_carrera_bloque
end type

on tab_carreras.create
this.cb_2=create cb_2
this.cb_imprimir=create cb_imprimir
this.cb_1=create cb_1
this.pb_6=create pb_6
this.pb_5=create pb_5
this.dw_carrera_bloque=create dw_carrera_bloque
this.Control[]={this.cb_2,&
this.cb_imprimir,&
this.cb_1,&
this.pb_6,&
this.pb_5,&
this.dw_carrera_bloque}
end on

on tab_carreras.destroy
destroy(this.cb_2)
destroy(this.cb_imprimir)
destroy(this.cb_1)
destroy(this.pb_6)
destroy(this.pb_5)
destroy(this.dw_carrera_bloque)
end on

type cb_2 from commandbutton within tab_carreras
integer x = 3465
integer y = 388
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

event clicked;CLOSE(w_areas_por_carreras)
end event

type cb_imprimir from commandbutton within tab_carreras
integer x = 3424
integer y = 1340
integer width = 608
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprimir Resumen"
end type

event clicked;//
n_ds lds_datos
//DATASTORE lds_reporte
INTEGER le_ttl_rgs
//INTEGER le_pos
//
//INTEGER le_id_bloque
//STRING ls_desc_bloque
//LONG ll_cve_carrera
//STRING ls_v_carreras_carrera
//INTEGER le_id_area
//STRING ls_carrera_descripcion
//
//INTEGER le_row_ins
//
//
//
lds_datos = CREATE n_ds 
lds_datos.DATAOBJECT = "dw_reporte_areas_bloques" 
lds_datos.SETTRANSOBJECT(gtr_sadm) 
le_ttl_rgs = lds_datos.RETRIEVE()  

//lds_reporte = CREATE DATASTORE 
//lds_reporte.DATAOBJECT = "dw_reporte_areas_bloques" 
//
//INTEGER le_id_bloque_ant
//INTEGER le_cuenta
//LONG ll_cve_carrera_ant
//INTEGER le_cuenta_carrera
//
//FOR le_pos = 1 TO le_ttl_rgs 
//	
//	le_id_bloque = lds_datos.GETITEMNUMBER(le_pos, "area_eval_carrera_relacion_id_bloque")
//	ls_desc_bloque = lds_datos.GETITEMSTRING(le_pos, "area_evaluacion_bloques_descripcion") 
//	ll_cve_carrera = lds_datos.GETITEMNUMBER(le_pos, "cve_carrera")
//	ls_v_carreras_carrera = lds_datos.GETITEMSTRING(le_pos, "v_carreras_carrera") 
//	le_id_area = lds_datos.GETITEMNUMBER(le_pos, "area_eval_carrera_relacion_id_area")
//	ls_carrera_descripcion = lds_datos.GETITEMSTRING(le_pos, "area_evaluacion_carrera_descripcion") 
//	
//	
//	// Si hay un cambio de bloque se reinicia el contador 
//	IF le_id_bloque <> le_id_bloque_ant  THEN 
//		le_id_bloque_ant = le_id_bloque 
//		le_cuenta = 1 
//	END IF 	
//	
//	// Asigna la carrera anterior 
//	IF ll_cve_carrera_ant <> ll_cve_carrera THEN 
//		ll_cve_carrera_ant = ll_cve_carrera 
//		le_cuenta_carrera = 0
//	END IF 	
//	
//	// Se reinicia el renglón que se inserta 	
//	le_row_ins = 0 
//	// Si hay un cambio de carrera, inserta el bloque y la carrera 	
//	IF le_cuenta_carrera = 0 THEN  
//		le_row_ins = lds_reporte.INSERTROW(0)  
//		lds_reporte.SETITEM(le_row_ins, "area_eval_carrera_relacion_id_bloque", le_id_bloque) 
//		lds_reporte.SETITEM(le_pos, "area_evaluacion_bloques_descripcion", ls_desc_bloque)   
//		lds_reporte.SETITEM(le_row_ins, "cve_carrera", ll_cve_carrera) 
//		lds_reporte.SETITEM(le_row_ins, "v_carreras_carrera", ls_v_carreras_carrera) 
//		le_cuenta_carrera ++ 
//	END IF 	
//	
////	le_row_ins = lds_reporte.INSERTROW(0) 
////	lds_reporte.SETITEM(le_row_ins, "area_eval_carrera_relacion_id_bloque", le_id_bloque) 
////	lds_reporte.SETITEM(le_pos, "area_evaluacion_bloques_descripcion", ls_desc_bloque)   
//
//	IF le_cuenta <= 3 THEN 
//		IF le_row_ins = 0 THEN 
//			le_row_ins = lds_reporte.INSERTROW(0) 
//			lds_reporte.SETITEM(le_row_ins, "area_eval_carrera_relacion_id_bloque", le_id_bloque) 
//			lds_reporte.SETITEM(le_pos, "area_evaluacion_bloques_descripcion", ls_desc_bloque)   			
//		END IF 	
//		lds_reporte.SETITEM(le_row_ins, "area_eval_carrera_relacion_id_area", le_id_area) 
//		lds_reporte.SETITEM(le_row_ins, "area_evaluacion_carrera_descripcion", ls_carrera_descripcion) 
//	END IF 	
//	le_cuenta++ 
//
//NEXT  

//dw_carrera_bloque.DATAOBJECT = "dw_reporte_areas_bloques" 
//lds_reporte.ROWSCOPY(1, lds_reporte.ROWCOUNT(), PRIMARY!, dw_carrera_bloque, 1, PRIMARY! )
//dw_carrera_bloque.SORT() 
//dw_carrera_bloque.GROUPCALC() 
//

PRINTSETUP() 
lds_datos.PRINT() 

end event

type cb_1 from commandbutton within tab_carreras
integer x = 3465
integer y = 224
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar"
end type

event clicked;
INTEGER le_ttl_carreras
INTEGER le_pos

INTEGER le_ttl_areas
INTEGER le_pos_area

LONG ll_carrera
INTEGER le_bloque
INTEGER le_modificado 

DATASTORE lds_areas_bloques

INTEGER le_area, le_area_carrera 

tab_1.tab_carreras.dw_carrera_bloque.ACCEPTTEXT() 
le_ttl_carreras = tab_1.tab_carreras.dw_carrera_bloque.ROWCOUNT() 

lds_areas_bloques = CREATE DATASTORE 
lds_areas_bloques.DATAOBJECT = "dw_area_eval_carrera_guarda"   
lds_areas_bloques.SETTRANSOBJECT(gtr_sadm) 
// Se recuperan todas las Áreas-Bloque 
le_ttl_areas = lds_areas_bloques.RETRIEVE(9999)

// Se barre cada una de las carreras.
FOR le_pos = 1 TO le_ttl_carreras 
	
	// Si no se ha modificado, no se procesa
	le_modificado = tab_1.tab_carreras.dw_carrera_bloque.GETITEMNUMBER(le_pos, "modificado") 
	IF le_modificado = 0 THEN CONTINUE 
	
	// Se toma la carrera y el bloque relacionado.
	ll_carrera = tab_1.tab_carreras.dw_carrera_bloque.GETITEMNUMBER(le_pos, "cve_carrera")
	le_bloque = tab_1.tab_carreras.dw_carrera_bloque.GETITEMNUMBER(le_pos, "id_bloque")
	
	lds_areas_bloques.SETFILTER("id_bloque = " + STRING(le_bloque))
	lds_areas_bloques.FILTER() 
	lds_areas_bloques.SETSORT("area_bloques_relacion_orden asc") 
	lds_areas_bloques.SORT()  
	
	// Se elimina las relaciones previas del bloque 
	DELETE FROM area_eval_carrera_relacion 
	WHERE cve_carrera = :ll_carrera 
	USING gtr_sadm; 

	
	
	le_area_carrera = 7
	le_ttl_areas = lds_areas_bloques.ROWCOUNT() 
	FOR le_pos_area = 1 TO le_ttl_areas 
		
		le_area = lds_areas_bloques.GETITEMNUMBER(le_pos_area, "id_area")  
		IF ISNULL(le_area) THEN CONTINUE 

		// Se inserta el valor de la relación
		INSERT INTO area_eval_carrera_relacion (cve_carrera, id_area, id_area_carrera, id_bloque) 
		VALUES (:ll_carrera, :le_area_carrera, :le_area, :le_bloque) 
		USING gtr_sadm;  
		
		le_area_carrera++ 
		
		
		
	NEXT


NEXT 

COMMIT USING gtr_sadm; 
MESSAGEBOX("Aviso", "Los cambios fueron guardados")


end event

type pb_6 from picturebutton within tab_carreras
integer x = 3598
integer y = 92
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

event clicked;
INTEGER le_row

le_row = tab_1.tab_carreras.dw_carrera_bloque.GETROW() 
IF le_row > 0 THEN tab_1.tab_carreras.dw_carrera_bloque.DELETEROW(le_row)  

end event

type pb_5 from picturebutton within tab_carreras
integer x = 3461
integer y = 92
integer width = 110
integer height = 96
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Insert5!"
alignment htextalign = left!
end type

event clicked;tab_1.tab_carreras.dw_carrera_bloque.INSERTROW(0)
end event

type dw_carrera_bloque from datawindow within tab_carreras
integer x = 110
integer y = 80
integer width = 3278
integer height = 1316
integer taborder = 60
string title = "none"
string dataobject = "dw_carreras_bloques_mant"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event rowfocuschanged;THIS.SELECTROW(0, FALSE)
THIS.SELECTROW(currentrow, TRUE)
THIS.SETROW(currentrow)

end event

event itemchanged;THIS.SETITEM(row, "modificado", 1)
end event

type tab_config from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4087
integer height = 1512
long backcolor = 67108864
string text = "Bloques"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_1 st_1
cb_guarda_bloque cb_guarda_bloque
dw_lista_areas dw_lista_areas
pb_4 pb_4
pb_agrega pb_agrega
dw_areas_bloque dw_areas_bloque
dw_bloques dw_bloques
end type

on tab_config.create
this.st_1=create st_1
this.cb_guarda_bloque=create cb_guarda_bloque
this.dw_lista_areas=create dw_lista_areas
this.pb_4=create pb_4
this.pb_agrega=create pb_agrega
this.dw_areas_bloque=create dw_areas_bloque
this.dw_bloques=create dw_bloques
this.Control[]={this.st_1,&
this.cb_guarda_bloque,&
this.dw_lista_areas,&
this.pb_4,&
this.pb_agrega,&
this.dw_areas_bloque,&
this.dw_bloques}
end on

on tab_config.destroy
destroy(this.st_1)
destroy(this.cb_guarda_bloque)
destroy(this.dw_lista_areas)
destroy(this.pb_4)
destroy(this.pb_agrega)
destroy(this.dw_areas_bloque)
destroy(this.dw_bloques)
end on

type st_1 from statictext within tab_config
integer x = 78
integer y = 132
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bloque:"
boolean focusrectangle = false
end type

type cb_guarda_bloque from commandbutton within tab_config
integer x = 1563
integer y = 1084
integer width = 402
integer height = 112
integer taborder = 90
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar"
end type

event clicked;
INTEGER le_existe_bloque
INTEGER le_id_bloque 
STRING ls_descripcion_bloque
INTEGER le_pos, le_ttl_rows 
INTEGER le_area
STRING ls_mensaje

tab_1.tab_config.dw_bloques.ACCEPTTEXT()

le_id_bloque  = tab_1.tab_config.dw_bloques.GETITEMNUMBER(1, "id_bloque")
ls_descripcion_bloque = tab_1.tab_config.dw_bloques.GETITEMSTRING(1, "descripcion") 

SELECT COUNT(*) 
INTO :le_existe_bloque 
FROM area_evaluacion_bloques 
WHERE id_bloque = :le_id_bloque  
USING gtr_sadm; 
IF gtr_sadm.SQLCODE < 0 THEN 
	ls_mensaje = gtr_sadm.SQLERRTEXT 
	ROLLBACK USING gtr_sadm;
	ls_mensaje = " Se produjo un error al verificar la existencia del bloque: " + ls_mensaje  
	MESSAGEBOX("Aviso", ls_mensaje) 
	RETURN -1 
END IF	
	

// Si no existe se inserta 
IF le_existe_bloque > 0 THEN 

	UPDATE area_evaluacion_bloques 
	SET descripcion = :ls_descripcion_bloque 
	WHERE id_bloque = :le_id_bloque  
	USING gtr_sadm; 
	IF gtr_sadm.SQLCODE < 0 THEN 
		ls_mensaje = gtr_sadm.SQLERRTEXT 
		ROLLBACK USING gtr_sadm;
		ls_mensaje = " Se produjo un error al actualizar el bloque: " + ls_mensaje  
		MESSAGEBOX("Aviso", ls_mensaje) 
		RETURN -1 
	END IF		

// Si existe se modifica 
ELSE 

	INSERT INTO area_evaluacion_bloques (id_bloque, descripcion)
	VALUES (:le_id_bloque , :ls_descripcion_bloque)
	USING gtr_sadm; 
	IF gtr_sadm.SQLCODE < 0 THEN 
		ls_mensaje = gtr_sadm.SQLERRTEXT 
		ROLLBACK USING gtr_sadm;
		ls_mensaje = " Se produjo un error al insertar el bloque: " + ls_mensaje  
		MESSAGEBOX("Aviso", ls_mensaje) 
		RETURN -1 
	END IF		
	
END IF 

DELETE FROM area_bloques_relacion 
WHERE id_bloque = :le_id_bloque
USING gtr_sadm;  
IF gtr_sadm.SQLCODE < 0 THEN 
	ls_mensaje = gtr_sadm.SQLERRTEXT 
	ROLLBACK USING gtr_sadm;
	ls_mensaje = " Se produjo un error al borrar las áreas relacionadas: " + ls_mensaje  
	MESSAGEBOX("Aviso", ls_mensaje) 
	RETURN -1 
END IF		


le_ttl_rows = tab_1.tab_config.dw_areas_bloque.ROWCOUNT()

FOR le_pos = 1 TO le_ttl_rows 

	le_area = tab_1.tab_config.dw_areas_bloque.GETITEMNUMBER(le_pos, "id_area")   

	
	INSERT INTO dbo.area_bloques_relacion (id_bloque, id_area, orden) 
	VALUES (:le_id_bloque, :le_area, :le_pos) 
	USING gtr_sadm;  
	IF gtr_sadm.SQLCODE < 0 THEN 
		ls_mensaje = gtr_sadm.SQLERRTEXT 
		ROLLBACK USING gtr_sadm;
		ls_mensaje = " Se produjo un error al insertar las áreas relacionadas: " + ls_mensaje   
		MESSAGEBOX("Aviso", ls_mensaje) 
		RETURN -1 
	END IF		

NEXT 

COMMIT USING gtr_sadm; 
MESSAGEBOX("Aviso", "Los cambios fueron guardados")

//INSERT INTO dbo.area_bloques_relacion (id_bloque, id_area)
//VALUES (@id_bloque, @id_area) 





//
//
//
//dw_bloques.SETTRANSOBJECT(gtr_sadm)
//IF dw_bloques.UPDATE() < 0 THEN 
//	ROLLBACK USING gtr_sadm;
//	MESSAGEBOX("Error", "Se produjo un error al actualizar el bloque.")
//	RETURN 
//END IF




end event

type dw_lista_areas from datawindow within tab_config
integer x = 2117
integer y = 212
integer width = 1902
integer height = 1240
integer taborder = 30
string title = "none"
string dataobject = "dw_area_eval_carrera_mant"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;THIS.SELECTROW(0, FALSE)
THIS.SELECTROW(row, TRUE)
THIS.SETROW(row)

end event

event doubleclicked;tab_1.tab_config.pb_agrega.TRIGGEREVENT(CLICKED!)
end event

type pb_4 from picturebutton within tab_config
integer x = 1993
integer y = 472
integer width = 110
integer height = 96
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "VCRNext!"
alignment htextalign = left!
end type

event clicked;
INTEGER le_row

le_row = tab_1.tab_config.dw_areas_bloque.GETROW() 
IF le_row > 0 THEN tab_1.tab_config.dw_areas_bloque.DELETEROW(le_row)  

wf_filtra() 







end event

type pb_agrega from picturebutton within tab_config
integer x = 1989
integer y = 360
integer width = 110
integer height = 96
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "VCRPrior!"
alignment htextalign = left!
end type

event clicked;
INTEGER le_row, le_row_ins
INTEGER le_ttl_row
STRING ls_areas, ls_coma
INTEGER le_area 


INTEGER le_bloque
STRING ls_desc_area 

IF tab_1.tab_config.dw_areas_bloque.ROWCOUNT() = 3 THEN 
	MESSAGEBOX("Aviso", "Solo es posible relacionar 3 áreas por bloque.")
	RETURN -1
END IF 

le_row = tab_1.tab_config.dw_lista_areas.GETROW() 

le_area = tab_1.tab_config.dw_lista_areas.GETITEMNUMBER(le_row, "id_area") 
ls_desc_area = tab_1.tab_config.dw_lista_areas.GETITEMSTRING(le_row, "descripcion") 

le_bloque = tab_1.tab_config.dw_bloques.GETITEMNUMBER(1, "id_bloque")


le_row_ins = tab_1.tab_config.dw_areas_bloque.INSERTROW(0)
tab_1.tab_config.dw_areas_bloque.SETITEM(le_row_ins, "id_bloque", le_bloque)
tab_1.tab_config.dw_areas_bloque.SETITEM(le_row_ins, "id_area", le_area)
tab_1.tab_config.dw_areas_bloque.SETITEM(le_row_ins, "area_evaluacion_carrera_descripcion", ls_desc_area)



wf_filtra() 







end event

type dw_areas_bloque from datawindow within tab_config
integer x = 64
integer y = 364
integer width = 1902
integer height = 676
integer taborder = 20
string title = "none"
string dataobject = "dw_area_eval_carrera_guarda"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;THIS.SELECTROW(0, FALSE)
THIS.SELECTROW(row, TRUE)
THIS.SETROW(row)
end event

type dw_bloques from datawindow within tab_config
integer x = 64
integer y = 212
integer width = 1582
integer height = 100
integer taborder = 20
string title = "none"
string dataobject = "dw_area_evaluacion_bloques_m"
boolean border = false
boolean livescroll = true
end type

event itemchanged;IF dwo.name = "id_bloque" THEN 

	INTEGER le_bloque

	le_bloque = INTEGER(data)
	
	POST wf_carga_bloque(le_bloque) 
	
	
END IF  
end event

type tab_areas from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4087
integer height = 1512
long backcolor = 67108864
string text = "Areas"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_guarda_areas cb_guarda_areas
pb_inserta_area pb_inserta_area
dw_areas dw_areas
end type

on tab_areas.create
this.cb_guarda_areas=create cb_guarda_areas
this.pb_inserta_area=create pb_inserta_area
this.dw_areas=create dw_areas
this.Control[]={this.cb_guarda_areas,&
this.pb_inserta_area,&
this.dw_areas}
end on

on tab_areas.destroy
destroy(this.cb_guarda_areas)
destroy(this.pb_inserta_area)
destroy(this.dw_areas)
end on

type cb_guarda_areas from commandbutton within tab_areas
integer x = 2007
integer y = 192
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar"
end type

event clicked;
STRING ls_mensaje

IF dw_areas.UPDATE() <  0 THEN 
	ROLLBACK USING gtr_sadm;
	ls_mensaje = gtr_sadm.SQLERRTEXT 
	MESSAGEBOX("Error",  "Se produjo un error al actualizar las áreas." + ls_mensaje) 
	RETURN -1
END IF 

MESSAGEBOX("Aviso",  "Las áreas fueron actualizadas con éxito.")  

RETURN 0




end event

type pb_inserta_area from picturebutton within tab_areas
integer x = 2007
integer y = 84
integer width = 110
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Insert5!"
alignment htextalign = left!
end type

event clicked;INTEGER le_row
INTEGER id_area
STRING ls_mensaje

le_row = dw_areas.INSERTROW(0)

SELECT MAX(id_area) 
INTO :id_area 
FROM area_evaluacion_carrera
USING gtr_sadm;
IF gtr_sadm.SQLCODE < 0 THEN 
	ls_mensaje = gtr_sadm.SQLERRTEXT 
	MESSAGEBOX("Error", ls_mensaje) 
	RETURN -1
END IF 
IF ISNULL(id_area) THEN id_area = 0 

id_area++

dw_areas.SETITEM(le_row, "id_area", id_area) 





end event

type dw_areas from datawindow within tab_areas
integer x = 50
integer y = 68
integer width = 1920
integer height = 1388
integer taborder = 30
string title = "none"
string dataobject = "dw_area_eval_carrera_mant"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

