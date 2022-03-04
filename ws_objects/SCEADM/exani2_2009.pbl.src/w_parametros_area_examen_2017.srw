$PBExportHeader$w_parametros_area_examen_2017.srw
$PBExportComments$Ventana para cambiar fechas
forward
global type w_parametros_area_examen_2017 from w_main
end type
type dw_1 from datawindow within w_parametros_area_examen_2017
end type
type dw_peso_area from u_dw_captura within w_parametros_area_examen_2017
end type
end forward

global type w_parametros_area_examen_2017 from w_main
integer x = 832
integer y = 360
integer width = 2871
integer height = 2628
string title = "Parámetros por Area de Examen"
string menuname = "m_menu"
long backcolor = 67108864
dw_1 dw_1
dw_peso_area dw_peso_area
end type
global w_parametros_area_examen_2017 w_parametros_area_examen_2017

type variables
int ord

// Modo de trabajo de la ventana : 1 = Nuevo, 2= Modifica
INTEGER ie_modo 

STRING is_extender_update



end variables

forward prototypes
public function integer f_carga_carreras (integer pi_tipo_carga)
public function integer f_carga_carreras_capturadas ()
end prototypes

public function integer f_carga_carreras (integer pi_tipo_carga);STRING ls_query

// Si se cargan las carreras guardadas 
IF pi_tipo_carga = 0  THEN 

	ls_query = " SELECT cve_carrera, carrera FROM v_carreras " + & 
					" WHERE cve_carrera = 9999 " + & 
					" AND cve_carrera IN( SELECT cve_carrera FROM parametros_area_examen2017) " + & 
					" UNION " + & 
					" SELECT  cve_carrera, carrera FROM v_carreras  " + & 
					" WHERE activa_1er_ing = 1  " + & 
					" AND cve_carrera IN( SELECT cve_carrera FROM parametros_area_examen2017) "  
					
// Si se cargan las carreras no guardadas 
ELSE
					
	ls_query = " SELECT cve_carrera, carrera FROM v_carreras " + & 
					" WHERE cve_carrera = 9999 " + & 
					" AND cve_carrera NOT IN( SELECT cve_carrera FROM parametros_area_examen2017) " + & 
					" UNION " + & 
					" SELECT  cve_carrera, carrera FROM v_carreras  " + & 
					" WHERE activa_1er_ing = 1  " + & 
					" AND cve_carrera NOT IN( SELECT cve_carrera FROM parametros_area_examen2017) "  
				
END IF


DataWindowChild carr
dw_1.getchild("cve_carrera",carr)
carr.settransobject(gtr_sadm)
carr.MODIFY("Datawindow.Table.Select  ='" + ls_query + "'") 
carr.retrieve()

// Se coloca la ventana en modo nuevo 
ie_modo = 1 


RETURN 0
end function

public function integer f_carga_carreras_capturadas (); // Se carga la configuración de "CUALQUIER CARRERA" por omisión.
dw_1.Retrieve(9999)
// Se cargan las carreras guardadas
f_carga_carreras(0) 
// Se coloca la ventana en modo modificación
ie_modo = 2 

RETURN 0 



end function

on w_parametros_area_examen_2017.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
this.dw_peso_area=create dw_peso_area
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_peso_area
end on

on w_parametros_area_examen_2017.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.dw_peso_area)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)

this.of_SetResize(TRUE)

//this.inv_resize.of_Register &
// (dw_1, this.inv_resize.SCALERIGHTBOTTOM)
 
f_carga_carreras_capturadas() 








end event

type dw_1 from datawindow within w_parametros_area_examen_2017
integer x = 41
integer y = 40
integer width = 2720
integer height = 816
integer taborder = 10
string title = "none"
string dataobject = "d_parametros_area_examen_2017"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event retrieveend;
IF THIS.ROWCOUNT() <= 0 THEN 
	MESSAGEBOX("Aviso", "No se encontró información de parámetros de de evaluación.")
	RETURN
END IF

INTEGER le_id_parametros

le_id_parametros = THIS.GETITEMNUMBER(1, "id_parametros")  
dw_peso_area.RESET()
dw_peso_area.SETTRANSOBJECT(gtr_sadm)
dw_peso_area.RETRIEVE(le_id_parametros) 


end event

event itemchanged;IF dwo.name =  "cve_carrera"  THEN 
	
	IF ie_modo = 1 THEN 
	
		INTEGER le_num_registros
		LONG ll_carrera
		
		ll_carrera = LONG(data)
		
		SELECT COUNT(*) 
		INTO :le_num_registros 	
		FROM  parametros_area_examen2017
		WHERE cve_carrera = :ll_carrera
		USING gtr_sadm; 
		
		// Si ya existe un registro con esta carrera se rechaza el dato 
		IF le_num_registros > 0 THEN 
			MESSAGEBOX("Aviso", "Ya existen parámetros de evaluación asociados a ésta carrera.")
			THIS.SETCOLUMN("cve_parametros_evaluacion")
			RETURN 2
		END IF
		
		RETURN 0
	
	ELSE
		dw_1.Retrieve(LONG(data))
	END IF
	
END IF 


IF dwo.name =  "clv_ver_t" OR dwo.name =  "clv_per" OR dwo.name =  "anio"  THEN 
	is_extender_update = "S" 
END IF







end event

type dw_peso_area from u_dw_captura within w_parametros_area_examen_2017
integer x = 41
integer y = 884
integer width = 2715
integer height = 1480
integer taborder = 20
string dataobject = "dw_parametros_area_exam_peso"
borderstyle borderstyle = styleraised!
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;if event actualiza()=1 then
	event primero()
	return retrieve()
end if
end event

event nuevo;long ll_renglon, ll_pos, ll_id_parametros
LONG  ll_cve_parametros_evaluacion, ll_clv_ver_t, ll_clv_per
LONG ll_anio, ll_criterios_absolutos 
DECIMAL ld_porcentaje_examen, ld_porcentaje_promedio 


SETNULL(ll_id_parametros) 

// Se carga por default la información de "Todas las carreras"
SELECT cve_parametros_evaluacion, clv_ver, clv_per,
	anio, criterios_absolutos, porcentaje_examen, porcentaje_promedio 
INTO :ll_cve_parametros_evaluacion, :ll_clv_ver_t, :ll_clv_per, 
	:ll_anio, :ll_criterios_absolutos, :ld_porcentaje_examen, :ld_porcentaje_promedio 
FROM parametros_area_examen2017 
WHERE cve_carrera = 9999 
USING gtr_sadm; 
IF gtr_sadm.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar los parámetros por Omisión.") 
	RETURN 	
END IF

dw_1.RESET() 
dw_1.INSERTROW(0)
dw_1.SETITEM(1, "cve_parametros_evaluacion", ll_cve_parametros_evaluacion)
dw_1.SETITEM(1, "clv_ver_t", ll_clv_ver_t)
dw_1.SETITEM(1, "clv_per", ll_clv_per)
dw_1.SETITEM(1, "anio", ll_anio)
dw_1.SETITEM(1, "criterios_absolutos", ll_criterios_absolutos)
dw_1.SETITEM(1, "porcentaje_examen", ld_porcentaje_examen)
dw_1.SETITEM(1, "porcentaje_promedio", ld_porcentaje_promedio)
dw_1.SETITEM(1, "id_parametros", ll_id_parametros)
dw_1.SETITEM(1, "cve_carrera", ll_id_parametros)

DATASTORE lds_detalle
lds_detalle = CREATE DATASTORE 
lds_detalle.DATAOBJECT = "dw_parametros_area_exam_peso" 
lds_detalle.SETTRANSOBJECT(gtr_sadm)  
lds_detalle.RETRIEVE(1) 

INTEGER le_cve_area_examen, ll_row_new
DECIMAL ld_peso_area

THIS.RESET()
// Se inserta el ID en los dw. 
FOR ll_pos = 1 TO lds_detalle.ROWCOUNT() 
		
	le_cve_area_examen = lds_detalle.GETITEMNUMBER(ll_pos, "cve_area_examen") 
	ld_peso_area = lds_detalle.GETITEMDECIMAL(ll_pos, "peso_area") 
	
	ll_row_new = THIS.INSERTROW(0)
	THIS.SETITEM(ll_row_new, "id_parametros", ll_id_parametros)
	THIS.SETITEM(ll_row_new, "cve_area_examen", le_cve_area_examen)
	THIS.SETITEM(ll_row_new, "peso_area", ld_peso_area)
	
NEXT

// Se cargan todas carreras no guardadas
f_carga_carreras(1) 


//dw_peso_area.MODIFY("b_agregar.VISIBLE = 1") 
//dw_peso_area.MODIFY("b_eliminar.VISIBLE = 1") 


//INTEGER le_num_areas, le_pos
//SELECT COUNT(*) 
//INTO :le_num_areas 
//FROM parametros_area_exam_peso
//USING gtr_sadm; 
//
//// Se insertan tantos renglones como parámetros haya definidos
//FOR le_pos = 1 TO le_num_areas 
//	dw_peso_area.INSERTROW(0) 
//NEXT 

ll_renglon=rowcount() 





end event

event actualiza;DECIMAL ld_total_peso , ld_peso, ld_porcentaje_examen, ld_porcentaje_promedio
LONG ll_id_parametros, ll_pos 

dw_1.ACCEPTTEXT()
THIS.ACCEPTTEXT()

IF ie_modo = 1 THEN 
	
	SELECT MAX(id_parametros ) 
	INTO :ll_id_parametros
	FROM parametros_area_examen2017 
	USING gtr_sadm;
	IF gtr_sadm.SQLCODE < 0 THEN 
		MESSAGEBOX("Error", "Se produjo un error: " + gtr_sadm.SQLERRTEXT)
		RETURN -1 
	END IF 
	IF ISNULL(ll_id_parametros) THEN ll_id_parametros = 0 
	ll_id_parametros = ll_id_parametros + 1 
	
	// Se inserta el ID en los dw. 
	FOR ll_pos = 1 TO THIS.ROWCOUNT() 
		THIS.SETITEM(ll_pos, "id_parametros", ll_id_parametros)
	NEXT
	
	dw_1.SETITEM(1, "id_parametros", ll_id_parametros)	
	
END IF 

LONG ll_cve_parametros_evaluacion
LONG ll_clv_ver_t
LONG ll_clv_per
LONG ll_anio
LONG ll_criterios_absolutos
LONG ll_cve_tipo_examen
LONG ll_cve_modulo_examen
LONG ll_cve_carrera


ll_id_parametros = dw_1.GETITEMNUMBER(1, "id_parametros") 
IF ISNULL(ll_id_parametros) THEN 
	MESSAGEBOX("Error", "No se ha especificado el ID de los parámetros") 
	RETURN -1 
END IF
ll_cve_parametros_evaluacion = dw_1.GETITEMNUMBER(1, "cve_parametros_evaluacion")
IF ISNULL(ll_cve_parametros_evaluacion) THEN 
	MESSAGEBOX("Error", "No se ha especificado la Clave los Parámetros de Evaluación")  
	RETURN -1 	
END IF

ll_clv_ver_t = dw_1.GETITEMNUMBER(1, "clv_ver_t")
IF ISNULL(ll_clv_ver_t) THEN 
	MESSAGEBOX("Error", "No se ha especificado la Versión")  
	RETURN -1 		
END IF
	
ll_clv_per = dw_1.GETITEMNUMBER(1, "clv_per")
IF ISNULL(ll_clv_per) THEN 
	MESSAGEBOX("Error", "No se ha especificado el Periodo")   
	RETURN -1 			
END IF

ll_anio = dw_1.GETITEMNUMBER(1, "anio")
IF ISNULL(ll_anio) THEN 
	MESSAGEBOX("Error", "No se ha especificado el Año")   
	RETURN -1 				
END IF

ll_criterios_absolutos = dw_1.GETITEMNUMBER(1, "criterios_absolutos")
IF ISNULL(ll_criterios_absolutos) THEN 
	MESSAGEBOX("Error", "No se ha especificado si es Criterio Absoluto")   
	RETURN -1 					
END IF

ld_porcentaje_examen = dw_1.GETITEMNUMBER(1, "porcentaje_examen")
IF ISNULL(ld_porcentaje_examen) THEN 
	MESSAGEBOX("Error", "No se ha especificado el Porcentaje del Exámen")    
	RETURN -1 						
END IF

ld_porcentaje_promedio = dw_1.GETITEMNUMBER(1, "porcentaje_promedio")
IF ISNULL(ld_porcentaje_promedio) THEN 
	MESSAGEBOX("Error", "No se ha especificado El Pordentaje del Promedio")    
	RETURN -1 								
END IF

IF (ld_porcentaje_examen + ld_porcentaje_promedio) <> 100 THEN 
	MESSAGEBOX("Error", "El Porcentaje del Exámen más el El Pordentaje del Promedio no debe ser diferente a un 100%")
	RETURN -1 	
END IF 


ll_cve_carrera = dw_1.GETITEMNUMBER(1, "cve_carrera") 
IF ISNULL(ll_cve_carrera) THEN 
	MESSAGEBOX("Error", "No se ha especificado la Clave de la Carrera")  
	RETURN -1 									
END IF

// Se verifica el detalle del peso de cada Área 
FOR ll_pos = 1 TO THIS.ROWCOUNT() 
	
	ll_id_parametros = THIS.GETITEMNUMBER(ll_pos, "id_parametros")
	IF ISNULL(ll_id_parametros) THEN 
		MESSAGEBOX("Error", "No se ha especificado La clave de Los Parámetros en el Peso de Cada Área")  
		RETURN -1 											
	END IF
	
	
	ld_peso = THIS.GETITEMDECIMAL(ll_pos, "peso_area")
	IF ISNULL(ld_peso) THEN 
		MESSAGEBOX("Error", "No se ha especificado el Peso de cada una de las Áreas")   
		RETURN -1 											
	END IF
	
NEXT

// Se verifica que el total de pesos sea el 100% 
ld_total_peso = THIS.GETITEMDECIMAL(1, "total_peso")

IF ld_total_peso <> 100 THEN 
	MESSAGEBOX("Error", "El total de pesos asignados a los parametros debe totalizar 100%")
	RETURN -1 
END IF


// Se solicita confirmación para actualizar el dato de Periodo y clave examen a todas las carreras. 
is_extender_update = "N" 
IF MESSAGEBOX("Confirmación", "¿Desea actualizar el valor de Versión y Periodo Año a Todas las carreras registradas ?", Question!, YesNo!) = 1 THEN 
	is_extender_update = 'S'
END IF

IF dw_1.UPDATE() < 0 THEN 
	ROLLBACK ;
	MESSAGEBOX("Error", "Se produjo un error al actualizar la información", STOPSIGN!)
	RETURN -1 
END IF

IF THIS.UPDATE() < 0 THEN 
	ROLLBACK;
	MESSAGEBOX("Error", "Se produjo un error al actualizar la información", STOPSIGN!)
	RETURN -1 	
END IF

IF is_extender_update = "S" THEN 
	UPDATE parametros_area_examen2017 
	SET clv_ver = :ll_clv_ver_t,
		clv_per = :ll_clv_per,
		anio = :ll_anio 
	USING gtr_sadm;		
	IF gtr_sadm.SQLCODE < 0 THEN 
		STRING ls_mns_error
		ls_mns_error = "Se produjo un error al actualizar la Versión y/o el Periodo:" + gtr_sadm.SQLERRTEXT 
		MESSAGEBOX("Error", ls_mns_error, STOPSIGN!)  
		ROLLBACK;	
	END IF
END IF


COMMIT USING gtr_sadm;
 
MESSAGEBOX("Aviso", "La información fué guardada con éxito")
is_extender_update = "N" 

f_carga_carreras_capturadas() 
dw_1.Retrieve(ll_cve_carrera) 

RETURN 0 




   
end event

event clicked;call super::clicked;IF dwo.name = "b_agregar" THEN 
	THIS.INSERTROW(0)
END IF

IF dwo.name = "b_eliminar" THEN 
	THIS.DELETEROW(row)
END IF
end event

event itemchanged;call super::itemchanged;

IF dwo.name = "cve_area_examen" THEN   
	
	LONG ll_cve_area_examen
	INTEGER le_pos, le_ttl_rows, le_encuentra 
	STRING ls_busca
	
	le_ttl_rows = THIS.ROWCOUNT() 
	
	FOR le_pos = 1 TO le_ttl_rows 
	
		IF le_pos  = row THEN CONTINUE 
	
		ll_cve_area_examen = THIS.GETITEMNUMBER(le_pos, "cve_area_examen")  
		IF ISNULL(ll_cve_area_examen) THEN ll_cve_area_examen = 0 
		
		IF ll_cve_area_examen = LONG(data) THEN 
			MESSAGEBOX("Aviso", "Ya ha sido capturada esta Area de Exámen.")
			RETURN 2 
		END IF
	
	NEXT 
	
END IF 











end event

event borra;

LONG ll_id_parametros , ll_carrera 
STRING ls_mensaje 

ll_carrera = dw_1.GETITEMNUMBER(1, "cve_carrera") 
IF ll_carrera = 9999 THEN 
	MESSAGEBOX("Aviso", "La configuración genral de carreras no puede ser eliminada")
	RETURN
END IF

ll_id_parametros = dw_1.GETITEMNUMBER(1, "id_parametros") 
IF ISNULL(ll_id_parametros) THEN RETURN  

IF MESSAGEBOX("Confirmación", "La información de la carrera desplegada será eliminada. Este proceso no es reversible. ¿Desea continuar?", Question!, OKCancel!) = 2 THEN RETURN 


DELETE FROM parametros_area_exam_peso 
WHERE id_parametros = :ll_id_parametros
USING gtr_sadm; 
IF gtr_sadm.SQLCODE < 0 THEN 
	ls_mensaje = "Se produjo un error al borrar los Pesos de los Parámetros de Area de Exámen: " + gtr_sadm.SQLERRTEXT 
	ROLLBACK USING gtr_sadm; 
	MESSAGEBOX("Error", ls_mensaje)  
	RETURN
END IF

DELETE FROM parametros_area_examen2017
WHERE id_parametros = :ll_id_parametros
USING gtr_sadm; 
IF gtr_sadm.SQLCODE < 0 THEN 
	ls_mensaje = "Se produjo un error al borrar los Parámetros de Area de Exámen: " + gtr_sadm.SQLERRTEXT 
	ROLLBACK USING gtr_sadm; 
	MESSAGEBOX("Error", ls_mensaje)  
	RETURN
END IF

COMMIT USING gtr_sadm; 


f_carga_carreras_capturadas() 

RETURN  
















end event

