$PBExportHeader$w_propedeutico_carrera.srw
forward
global type w_propedeutico_carrera from window
end type
type cb_1 from commandbutton within w_propedeutico_carrera
end type
type dw_carrera from datawindow within w_propedeutico_carrera
end type
type cb_2 from commandbutton within w_propedeutico_carrera
end type
type cb_salir from commandbutton within w_propedeutico_carrera
end type
type pb_insert from picturebutton within w_propedeutico_carrera
end type
type pb_delete from picturebutton within w_propedeutico_carrera
end type
type dw_prop_carrera_peso from datawindow within w_propedeutico_carrera
end type
type dw_propedeutico_lista from datawindow within w_propedeutico_carrera
end type
end forward

global type w_propedeutico_carrera from window
boolean visible = false
integer width = 2930
integer height = 2136
boolean titlebar = true
string title = "Carreras Propedéuticos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
dw_carrera dw_carrera
cb_2 cb_2
cb_salir cb_salir
pb_insert pb_insert
pb_delete pb_delete
dw_prop_carrera_peso dw_prop_carrera_peso
dw_propedeutico_lista dw_propedeutico_lista
end type
global w_propedeutico_carrera w_propedeutico_carrera

type variables
//INTEGER ie_row_ant 
//BOOLEAN ib_valida
BOOLEAN ib_modifica_prop, ib_modifica_peso, ib_doubleclicked
end variables

forward prototypes
public function integer wf_carga_detalles ()
public function integer wf_carga_pesos (long al_carrera, string as_prop)
public function integer wf_valida ()
public function integer wf_actualiza_prop (integer ae_row_ant)
public function integer wf_suma_reactivos ()
end prototypes

public function integer wf_carga_detalles ();
INTEGER le_row_prop
LONG ll_cve_carrera
DATAWINDOWCHILD ldw_areas
STRING ls_prop

ll_cve_carrera = dw_carrera.GETITEMNUMBER(1, "cve_carrera") 
//IF ISNULL(ll_cve_carrera) THEN 
//	MESSAGEBOX("Aviso", "No se ha seleccionado ninguna carrera.")
//	RETURN 0
//END IF

// Se recuperan los propedeúticos guardados 
dw_propedeutico_lista.RETRIEVE(ll_cve_carrera) 
//IF dw_propedeutico_lista.ROWCOUNT() = 0 THEN 
//	dw_propedeutico_lista.INSERTROW(0)
//	RETURN 0
//END IF

//le_row_prop = dw_propedeutico_lista.GETROW()
//ls_prop = dw_propedeutico_lista.GETITEMSTRING(le_row_prop, "id_prop") 




RETURN 0
end function

public function integer wf_carga_pesos (long al_carrera, string as_prop);DATAWINDOWCHILD ldw_areas 
INTEGER le_pos



STRING ls_sql
INTEGER le_existe 

SELECT COUNT(*) 
INTO :le_existe  
FROM prop_carrera_peso 
WHERE prop_carrera_peso.id_prop = :as_prop 
AND prop_carrera_peso.cve_carrera = :al_carrera  
USING gtr_sadm;
IF gtr_sadm.SQLCODE < 0 THEN 
	MESSAGEBOX("Aviso", "Se produjo un error al verificar la existencia previa de carrera-propedéutico: " + gtr_sadm.SQLERRTEXT)
	RETURN -1
END IF

IF le_existe = 0 THEN 

	ls_sql = " SELECT area_evaluacion.id_area AS id_area, " + & 
							" area_evaluacion.descripcion descripcion " + &  
				" FROM area_evaluacion " + &  
				" WHERE NOT EXISTS(SELECT * FROM prop_carrera_peso " + &  
								" WHERE prop_carrera_peso.id_area = area_evaluacion.id_area " + & 
								" AND prop_carrera_peso.cve_carrera = " + STRING(al_carrera) + " AND prop_carrera_peso.id_prop = ~~'" + as_prop + "~~' ) " + & 
				" AND NOT EXISTS(SELECT * FROM area_eval_carrera_relacion " + &  
								" WHERE area_eval_carrera_relacion.id_area = area_evaluacion.id_area " + &  
								" AND area_eval_carrera_relacion.cve_carrera = " + STRING(al_carrera) + ") " + &  
				" UNION " + &  
				" SELECT area_evaluacion.id_area AS id_area, " + &     
							" area_evaluacion_carrera.descripcion AS descripcion " + &    
				" FROM area_evaluacion, area_evaluacion_carrera, area_eval_carrera_relacion " + &  
				" WHERE NOT EXISTS(SELECT * FROM prop_carrera_peso " + &  
								" WHERE prop_carrera_peso.id_area = area_evaluacion_carrera.id_area " + & 
								" AND prop_carrera_peso.cve_carrera = " + STRING(al_carrera) + " AND prop_carrera_peso.id_prop = ~~'" + as_prop + "~~' ) " + & 
				" AND area_eval_carrera_relacion.id_area_carrera = area_evaluacion_carrera.id_area " + &  
				" AND area_eval_carrera_relacion.cve_carrera = " + STRING(al_carrera) + " " + &      
				" AND area_evaluacion.id_area = area_eval_carrera_relacion.id_area " 

ELSE

	ls_sql = " SELECT area_evaluacion.id_area AS id_area, " + & 
							" area_evaluacion.descripcion descripcion " + &  
				" FROM area_evaluacion " + &  
				" WHERE EXISTS(SELECT * FROM prop_carrera_peso " + &  
								" WHERE prop_carrera_peso.id_area = area_evaluacion.id_area " + & 
								" AND prop_carrera_peso.cve_carrera = " + STRING(al_carrera) + " AND prop_carrera_peso.id_prop = ~~'" + as_prop + "~~' ) " + & 
				" AND NOT EXISTS(SELECT * FROM area_eval_carrera_relacion " + &  
								" WHERE area_eval_carrera_relacion.id_area = area_evaluacion.id_area " + &  
								" AND area_eval_carrera_relacion.cve_carrera = " + STRING(al_carrera) + ") " + &  
				" UNION " + &  
				" SELECT area_evaluacion.id_area AS id_area, " + &     
							" area_evaluacion_carrera.descripcion AS descripcion " + &    
				" FROM area_evaluacion, area_evaluacion_carrera, area_eval_carrera_relacion " + &  
				" WHERE NOT EXISTS(SELECT * FROM prop_carrera_peso " + &  
								" WHERE prop_carrera_peso.id_area = area_evaluacion_carrera.id_area " + & 
								" AND prop_carrera_peso.cve_carrera = " + STRING(al_carrera) + " AND prop_carrera_peso.id_prop = ~~'" + as_prop + "~~' ) " + & 
				" AND area_eval_carrera_relacion.id_area_carrera = area_evaluacion_carrera.id_area " + &  
				" AND area_eval_carrera_relacion.cve_carrera = " + STRING(al_carrera) + " " + &      
				" AND area_evaluacion.id_area = area_eval_carrera_relacion.id_area " 


END IF

// Se recuperan las áreas de evaluación relacionadas a la carrera. 
dw_prop_carrera_peso.GETCHILD("id_area", ldw_areas) 
ldw_areas.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'")
ldw_areas.SETTRANSOBJECT(gtr_sadm)
ldw_areas.RETRIEVE(al_carrera)



// Se recuperan los pesos por área para evaluación de asignación de propedéuticos
IF dw_prop_carrera_peso.RETRIEVE(al_carrera, as_prop) <= 0 THEN 
	dw_prop_carrera_peso.RETRIEVE(0, as_prop)
//ELSE
//	FOR le_pos = 1 TO dw_prop_carrera_peso.ROWCOUNT() 
//		dw_prop_carrera_peso.SETITEM(le_pos, "cve_carrera", al_carrera)
//		dw_prop_carrera_peso.SETITEM(le_pos, "id_prop", as_prop) 
//		//dw_prop_carrera_peso.SETITEMSTATUS(le_pos, 0, PRIMARY!, NEWMODIFIED!)
//	NEXT  		
END IF 


RETURN 0 



end function

public function integer wf_valida ();
INTEGER le_pos 
DECIMAL ld_peso 
DECIMAL ld_total 

dw_prop_carrera_peso.ACCEPTTEXT() 
IF dw_prop_carrera_peso.ROWCOUNT() = 0 THEN RETURN 0

FOR le_pos = 1 TO dw_prop_carrera_peso.ROWCOUNT() 

	ld_peso = dw_prop_carrera_peso.GETITEMDECIMAL(le_pos, "peso") 
	IF ISNULL(ld_peso) THEN ld_peso = 0 
	ld_total = ld_total + ld_peso 
	
NEXT 

IF ld_total < 100 THEN 
	MESSAGEBOX("Aviso", "No se ha asignado el 100% de paso a las áreas de evaluación. ")
	RETURN -1
END IF
end function

public function integer wf_actualiza_prop (integer ae_row_ant);LONG ll_cve_carrera
STRING ls_id_prop
DECIMAL ld_procentaje_minimo
INTEGER le_existe
STRING ls_error
INTEGER le_pos, le_total

LONG ll_id_area
DECIMAL ld_peso

DECIMAL ld_numero_aciertos 
DECIMAL ld_aciertos_totales 

STRING ls_aplica


ll_cve_carrera = dw_propedeutico_lista.GETITEMNUMBER(ae_row_ant, "cve_carrera")
ls_id_prop = dw_propedeutico_lista.GETITEMSTRING(ae_row_ant, "id_prop")
ld_procentaje_minimo = dw_propedeutico_lista.GETITEMDECIMAL(ae_row_ant, "procentaje_minimo")

ld_numero_aciertos = dw_propedeutico_lista.GETITEMDECIMAL(ae_row_ant, "numero_aciertos") 
ld_aciertos_totales = dw_propedeutico_lista.GETITEMDECIMAL(ae_row_ant, "aciertos_totales") 

IF ISNULL(ll_cve_carrera) OR ISNULL(ls_id_prop) OR ISNULL(ld_procentaje_minimo) THEN RETURN 0 

SELECT COUNT(*) 
INTO :le_existe 
FROM prop_carrera_minimos 
WHERE cve_carrera = :ll_cve_carrera
AND id_prop = :ls_id_prop
USING gtr_sadm;
IF gtr_sadm.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al verificar la existencia de la relación Carrera-Propedéutico: " + gtr_sadm.SQLERRTEXT)	
	RETURN -1 	
END IF
IF le_existe > 0 THEN 
	UPDATE prop_carrera_minimos 
	SET procentaje_minimo = :ld_procentaje_minimo, 
		numero_aciertos = :ld_numero_aciertos, 
		aciertos_totales = :ld_aciertos_totales 
	WHERE cve_carrera = :ll_cve_carrera 
	AND id_prop = :ls_id_prop	
	USING gtr_sadm;
	IF gtr_sadm.SQLCODE < 0 THEN 
		ls_error = gtr_sadm.SQLERRTEXT
		ROLLBACK USING gtr_sadm;
		MESSAGEBOX("Error", "Se produjo un error al insertar la relación Carrera-Propedéutico: " + ls_error)	
		RETURN -1 		
	END IF
ELSE
	INSERT INTO prop_carrera_minimos (cve_carrera, id_prop, procentaje_minimo, numero_aciertos, aciertos_totales ) 
	VALUES (:ll_cve_carrera, :ls_id_prop, :ld_procentaje_minimo, :ld_numero_aciertos, :ld_aciertos_totales) 
	USING gtr_sadm;
	IF gtr_sadm.SQLCODE < 0 THEN 
		ls_error = gtr_sadm.SQLERRTEXT
		ROLLBACK USING gtr_sadm;		
		MESSAGEBOX("Error", "Se produjo un error al insertar la relación Carrera-Propedéutico: " + ls_error)	
		RETURN -1 		
	END IF
END IF

// Se elimina el detalle de porcentaje de evaluación por área.
DELETE FROM prop_carrera_peso
WHERE cve_carrera = :ll_cve_carrera
AND id_prop = :ls_id_prop 
USING gtr_sadm; 
IF gtr_sadm.SQLCODE < 0 THEN 
		ls_error = gtr_sadm.SQLERRTEXT
		ROLLBACK USING gtr_sadm;
		MESSAGEBOX("Error", "Se produjo un error al eliminar el detalle de pesos de evaluación por área: " + ls_error)
		RETURN -1
END IF

// Se hace ciclo para insertar el detalle de peso.
le_total = dw_prop_carrera_peso.ROWCOUNT() 
FOR le_pos = 1 TO le_total 

	ll_id_area = dw_prop_carrera_peso.GETITEMNUMBER(le_pos, "id_area")
	IF ISNULL(ll_id_area) THEN RETURN -1
	ld_peso = dw_prop_carrera_peso.GETITEMDECIMAL(le_pos, "peso") 
	IF ISNULL(ld_peso) THEN RETURN -1  
	ls_aplica = dw_prop_carrera_peso.GETITEMSTRING(le_pos, "incluye") 
	IF ISNULL(ls_aplica) THEN ls_aplica = 'N' 

	INSERT INTO prop_carrera_peso (cve_carrera, id_area, id_prop, peso, evaluacion)
	VALUES(:ll_cve_carrera, :ll_id_area, :ls_id_prop, :ld_peso, :ls_aplica) 
	USING gtr_sadm;
	IF gtr_sadm.SQLCODE < 0 THEN 
		ls_error = gtr_sadm.SQLERRTEXT
		ROLLBACK USING gtr_sadm;
		MESSAGEBOX("Error", "Se produjo un error al insertar el detalle de pesos de evaluación por área: " + ls_error)
		RETURN -1 
	END IF


NEXT 

COMMIT USING gtr_sadm; 


 RETURN 0  
end function

public function integer wf_suma_reactivos ();INTEGER le_ttl_areas 
INTEGER le_pos 
DECIMAL ld_reactivos 
DECIMAL ld_total_reactivos 
STRING ls_incluye  

dw_prop_carrera_peso.ACCEPTTEXT() 

le_ttl_areas = dw_prop_carrera_peso.ROWCOUNT()

FOR le_pos = 1 TO le_ttl_areas 
	
	ls_incluye = dw_prop_carrera_peso.GETITEMSTRING(le_pos, "incluye")  
	IF ls_incluye = 'N' THEN CONTINUE 
	
	ld_reactivos = dw_prop_carrera_peso.GETITEMDECIMAL(le_pos, "area_evaluacion_numero_reactivos")  
	
	ld_total_reactivos = ld_total_reactivos + ld_reactivos 

NEXT 

dw_propedeutico_lista.SETITEM(dw_propedeutico_lista.GETROW(), "aciertos_totales", ld_total_reactivos)    


RETURN 0 








end function

on w_propedeutico_carrera.create
this.cb_1=create cb_1
this.dw_carrera=create dw_carrera
this.cb_2=create cb_2
this.cb_salir=create cb_salir
this.pb_insert=create pb_insert
this.pb_delete=create pb_delete
this.dw_prop_carrera_peso=create dw_prop_carrera_peso
this.dw_propedeutico_lista=create dw_propedeutico_lista
this.Control[]={this.cb_1,&
this.dw_carrera,&
this.cb_2,&
this.cb_salir,&
this.pb_insert,&
this.pb_delete,&
this.dw_prop_carrera_peso,&
this.dw_propedeutico_lista}
end on

on w_propedeutico_carrera.destroy
destroy(this.cb_1)
destroy(this.dw_carrera)
destroy(this.cb_2)
destroy(this.cb_salir)
destroy(this.pb_insert)
destroy(this.pb_delete)
destroy(this.dw_prop_carrera_peso)
destroy(this.dw_propedeutico_lista)
end on

event open;dw_propedeutico_lista.SETTRANSOBJECT(gtr_sadm) 
dw_prop_carrera_peso.SETTRANSOBJECT(gtr_sadm) 
dw_propedeutico_lista.SetRowFocusIndicator(Hand!)
dw_carrera.SETTRANSOBJECT(gtr_sadm) 
dw_carrera.INSERTROW(0)
//dw_carrera.SETITEM(1, 1, 9999)
//wf_carga_detalles()
//ib_valida = TRUE


end event

type cb_1 from commandbutton within w_propedeutico_carrera
integer x = 2441
integer y = 240
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Reporte Global"
end type

event clicked;OPEN(w_resumen_conf_prop) 
end event

type dw_carrera from datawindow within w_propedeutico_carrera
event carga ( )
integer x = 137
integer y = 56
integer width = 2341
integer height = 148
integer taborder = 10
string title = "none"
string dataobject = "dw_prop_selecciona_carrera"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event carga();INTEGER le_pos
INTEGER le_ttl

le_ttl = dw_propedeutico_lista.ROWCOUNT()
FOR le_pos = 1 TO le_ttl 
	dw_propedeutico_lista.DELETEROW(1)
NEXT
dw_prop_carrera_peso.RESET()
wf_carga_detalles() 



end event

event itemchanged;POSTEVENT("carga")



end event

type cb_2 from commandbutton within w_propedeutico_carrera
integer x = 2341
integer y = 788
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar"
end type

event clicked;LONG ll_currentrow 
STRING ls_error , ls_desc_prop

dw_propedeutico_lista.ACCEPTTEXT() 
dw_prop_carrera_peso.ACCEPTTEXT()

ll_currentrow = dw_propedeutico_lista.GETROW() 
IF ib_modifica_prop OR ib_modifica_peso THEN 
	wf_actualiza_prop(ll_currentrow)
	ib_modifica_prop = FALSE
	ib_modifica_peso = FALSE
END IF

//STRING ls_desc_prop
//SELECT descripcion 
//INTO :ls_desc_prop 
//FROM propedeuticos 
//WHERE id_prop = :ls_id_prop
//USING gtr_sadm;
IF gtr_sadm.SQLCODE < 0 THEN 
	ls_error = gtr_sadm.SQLERRTEXT
	ROLLBACK USING gtr_sadm;
	MESSAGEBOX("Error", "Se produjo un error al recuperar la descripción del Propedéutico: " + ls_error)
	RETURN -1 
END IF

MESSAGEBOX("Aviso", "El Propedéutico " + ls_desc_prop + " ha sido guardado con éxito")

//
//
//// Se guarda el registro que acaba de abandonar
//wf_actualiza_prop(ie_row_ant) 
//
//LONG ll_cve_carrera
//STRING ls_prop
//
//ll_cve_carrera = dw_carrera.GETITEMNUMBER(1, "cve_carrera") 
//IF ISNULL(ll_cve_carrera) THEN 
//	MESSAGEBOX("Aviso", "No se ha seleccionado ninguna carrera.")
//	RETURN 0
//END IF
//
//ls_prop = dw_propedeutico_lista.GETITEMSTRING(row, "id_prop") 
//IF ISNULL(ls_prop) THEN ls_prop = "" 
//IF ls_prop = "" THEN  
//	RETURN 0
//END IF
//
//wf_carga_pesos(ll_cve_carrera, ls_prop)  
//
end event

type cb_salir from commandbutton within w_propedeutico_carrera
integer x = 2336
integer y = 928
integer width = 402
integer height = 112
integer taborder = 30
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

type pb_insert from picturebutton within w_propedeutico_carrera
integer x = 2171
integer y = 248
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

event clicked;LONG ll_cve_carrera 


ll_cve_carrera = dw_carrera.GETITEMNUMBER(1, "cve_carrera") 
IF ISNULL(ll_cve_carrera) THEN 
	MESSAGEBOX("Aviso", "No se ha seleccionado ninguna carrera.")
	RETURN 0
END IF


INTEGER le_row
le_row = dw_propedeutico_lista.INSERTROW(0)
dw_propedeutico_lista.SETITEM(le_row, "cve_carrera", ll_cve_carrera) 


//dw_propedeutico_lista.SCROLLTOROW(le_row)
//dw_propedeutico_lista.SETROW(le_row) 








end event

type pb_delete from picturebutton within w_propedeutico_carrera
integer x = 2295
integer y = 248
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

event clicked;LONG ll_cve_carrera
STRING ls_prop, ls_error


ll_cve_carrera = dw_carrera.GETITEMNUMBER(1, "cve_carrera") 
IF ISNULL(ll_cve_carrera) THEN 
	MESSAGEBOX("Aviso", "No se ha seleccionado ninguna carrera.")
	RETURN 1
END IF

LONG ll_currentrow 

ll_currentrow = dw_propedeutico_lista.GETROW() 
ls_prop = dw_propedeutico_lista.GETITEMSTRING(ll_currentrow, "id_prop") 
IF (ISNULL(ls_prop) OR ls_prop = "") THEN  
	MESSAGEBOX("Aviso", "No se ha seleccionado ningún propedéutico.")
	RETURN 1
END IF 

IF MESSAGEBOX("Confirmación", "Se borrará el Propedéutico y los pesos por área asociados. ¿Desea Continuar?", Question!, YesNo!, 2) = 2 THEN RETURN 0


DELETE FROM prop_carrera_minimos 
WHERE cve_carrera = :ll_cve_carrera 
AND id_prop = :ls_prop 
USING gtr_sadm; 
IF gtr_sadm.SQLCODE < 0 THEN 
	ls_error = gtr_sadm.SQLERRTEXT
	ROLLBACK USING gtr_sadm; 
	MESSAGEBOX("Error", "Se produjo un error al borrar el Propedéutico asociado a la Carrera:" + ls_error )
	RETURN -1
END IF

DELETE FROM prop_carrera_peso 
WHERE cve_carrera = :ll_cve_carrera 
AND id_prop = :ls_prop 
USING gtr_sadm; 
IF gtr_sadm.SQLCODE < 0 THEN 
	ls_error = gtr_sadm.SQLERRTEXT
	ROLLBACK USING gtr_sadm; 
	MESSAGEBOX("Error", "Se produjo un error al borrar el peso por área del Propedéutico:" + ls_error )
	RETURN -1
END IF

COMMIT USING gtr_sadm; 

dw_carrera.TRIGGEREVENT("carga") 









end event

type dw_prop_carrera_peso from datawindow within w_propedeutico_carrera
integer x = 123
integer y = 764
integer width = 2007
integer height = 1172
integer taborder = 20
string title = "none"
string dataobject = "dw_prop_carrera_peso"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;ib_modifica_peso = TRUE 
end event

event clicked;
IF dwo.name = "incluye" THEN  
	POST wf_suma_reactivos()
END IF 	
	







end event

type dw_propedeutico_lista from datawindow within w_propedeutico_carrera
event cargadetalle ( )
integer x = 123
integer y = 224
integer width = 2016
integer height = 512
integer taborder = 10
string title = "Carreras Propedéuticos"
string dataobject = "dw_prop_carrera_minimos"
boolean minbox = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event cargadetalle();
LONG ll_cve_carrera, ll_row
STRING ls_prop

ll_row = THIS.GETROW()

ll_cve_carrera = dw_carrera.GETITEMNUMBER(1, "cve_carrera") 
IF ISNULL(ll_cve_carrera) THEN 
	MESSAGEBOX("Aviso", "No se ha seleccionado ninguna carrera.")
	RETURN 
END IF

ls_prop = dw_propedeutico_lista.GETITEMSTRING(ll_row, "id_prop") 
IF ISNULL(ls_prop) THEN ls_prop = "" 
IF ls_prop = "" THEN  
	dw_prop_carrera_peso.RESET() 
	RETURN 
END IF

wf_carga_pesos(ll_cve_carrera, ls_prop)  

THIS.SELECTROW(0, false)
THIS.SELECTROW(ll_row, true)
//THIS.SETROW(ll_row)
end event

event rowfocuschanging;//IF NOT ib_valida THEN RETURN 0

LONG ll_cve_carrera
STRING ls_prop
DECIMAL ld_porcentaje 

IF NOT ib_doubleclicked THEN RETURN 1 
IF currentrow <= 0 OR dw_propedeutico_lista.ROWCOUNT() = 0 THEN RETURN 0

ll_cve_carrera = dw_carrera.GETITEMNUMBER(1, "cve_carrera") 
IF ISNULL(ll_cve_carrera) THEN 
	MESSAGEBOX("Aviso", "No se ha seleccionado ninguna carrera.")
	RETURN 1
END IF

ls_prop = dw_propedeutico_lista.GETITEMSTRING(currentrow, "id_prop") 
IF (ISNULL(ls_prop) OR ls_prop = "") AND (currentrow <> 0) AND dw_propedeutico_lista.ROWCOUNT() > 0  THEN  
	MESSAGEBOX("Aviso", "No se ha seleccionado ningún propedéutico.")
	RETURN 1
END IF

//ld_porcentaje = dw_propedeutico_lista.GETITEMDECIMAL(currentrow, "procentaje_minimo") 
//IF ld_porcentaje = 0 OR ISNULL(ld_porcentaje)  THEN   
//	MESSAGEBOX("Aviso", "No se ha asignado un porcentaje de aciertos al propedéutico.")
//	RETURN 1
//END IF



//IF currentrow = 0 THEN 
//	ie_row_ant = 1	
//ELSE
//	ie_row_ant = currentrow
//END IF

/*Se elimina la validación por peso 07/12/2020*/
//IF wf_valida() < 0 THEN 
//	RETURN 1 
//ELSE
//	IF ib_modifica_prop OR ib_modifica_peso THEN 
//		wf_actualiza_prop(currentrow)
//		ib_modifica_prop = FALSE
//		ib_modifica_peso = FALSE
//	END IF
//END IF
/*Se elimina la validación por peso 07/12/2020*/

IF ib_modifica_prop OR ib_modifica_peso THEN 
	wf_actualiza_prop(currentrow)
	ib_modifica_prop = FALSE
	ib_modifica_peso = FALSE
END IF


//// Se guarda el detalle de pesos asociados al propedeútico actrual
//dw_prop_carrera_peso.UPDATE()


//wf_carga_pesos(ll_cve_carrera, ls_prop)  






end event

event itemchanged;
LONG ll_cve_carrera
STRING ls_prop

IF dwo.name = "id_prop" THEN 

	ll_cve_carrera = dw_carrera.GETITEMNUMBER(1, "cve_carrera") 
	IF ISNULL(ll_cve_carrera) THEN 
		MESSAGEBOX("Aviso", "No se ha seleccionado ninguna carrera.")
		RETURN 0
	END IF
	
	IF THIS.FIND("id_prop = '" + data + "'", 0, ROWCOUNT() + 1) > 0 THEN 
		MESSAGEBOX("Aviso", "Este Propedéutico ya fue capturado.") 
		RETURN 1
	END IF 
	
	ls_prop = data 
	IF ISNULL(ls_prop) OR ls_prop = "" THEN  
		MESSAGEBOX("Aviso", "No se ha seleccionado ningún propedéutico.")
		RETURN 0
	END IF
	
	wf_carga_pesos(ll_cve_carrera, ls_prop)  

END IF

ib_modifica_prop = TRUE 






end event

event doubleclicked;ib_doubleclicked = TRUE
THIS.ACCEPTTEXT()
THIS.SELECTROW(0, false)
THIS.SELECTROW(row, true)
THIS.SETROW(row)

THIS.POSTEVENT("cargadetalle")

ib_doubleclicked = FALSE 


//
//// Se guarda el registro que acaba de abandonar
//wf_actualiza_prop(ie_row_ant) 
//
//LONG ll_cve_carrera
//STRING ls_prop
//
//ll_cve_carrera = dw_carrera.GETITEMNUMBER(1, "cve_carrera") 
//IF ISNULL(ll_cve_carrera) THEN 
//	MESSAGEBOX("Aviso", "No se ha seleccionado ninguna carrera.")
//	RETURN 0
//END IF
//
//ls_prop = dw_propedeutico_lista.GETITEMSTRING(row, "id_prop") 
//IF ISNULL(ls_prop) THEN ls_prop = "" 
//IF ls_prop = "" THEN  
//	RETURN 0
//END IF
//
//wf_carga_pesos(ll_cve_carrera, ls_prop)  




end event

event rowfocuschanged;//
//// Se guarda el registro que acaba de abandonar
//wf_actualiza_prop(ie_row_ant) 
//
//LONG ll_cve_carrera
//STRING ls_prop
//
//ll_cve_carrera = dw_carrera.GETITEMNUMBER(1, "cve_carrera") 
//IF ISNULL(ll_cve_carrera) THEN 
//	MESSAGEBOX("Aviso", "No se ha seleccionado ninguna carrera.")
//	RETURN 0
//END IF
//
//ls_prop = dw_propedeutico_lista.GETITEMSTRING(currentrow, "id_prop") 
//IF ISNULL(ls_prop) THEN ls_prop = "" 
//IF ls_prop = "" THEN  
//	RETURN 0
//END IF
//
//wf_carga_pesos(ll_cve_carrera, ls_prop)  
//
end event

