$PBExportHeader$uo_gpo_division_servicios_back.sru
forward
global type uo_gpo_division_servicios_back from nonvisualobject
end type
end forward

global type uo_gpo_division_servicios_back from nonvisualobject
end type
global uo_gpo_division_servicios_back uo_gpo_division_servicios_back

type variables

DATASTORE ids_grupos_div_detalle  
DATASTORE ids_grupos_div_cupo 
DATASTORE ids_grupos_cupo_div 
DATASTORE ids_aspiran_inscribe
TRANSACTION itr_sce 
TRANSACTION itr_sce_adm 

INTEGER ie_periodo 
INTEGER ie_anio 
INTEGER il_version

LONG il_cve_mat 


LONG il_folio_inc 
LONG il_folio_fin 

INTEGER ie_num_vuelta 

end variables

forward prototypes
public function integer of_genera_grupos_division ()
public function integer of_incribe_mat_division ()
end prototypes

public function integer of_genera_grupos_division ();
ids_grupos_div_detalle = CREATE DATASTORE 
ids_grupos_div_detalle.DATAOBJECT = "dw_grupos_div_detalle" 
ids_grupos_div_detalle.SETTRANSOBJECT(itr_sce_adm) 
ids_grupos_div_detalle.retrieve(il_cve_mat, ie_periodo, ie_anio ) 


ids_grupos_div_cupo = CREATE DATASTORE 
ids_grupos_div_cupo.DATAOBJECT = "dw_grupos_div_proporcion" 
ids_grupos_div_cupo.SETTRANSOBJECT(itr_sce_adm) 
ids_grupos_div_cupo.retrieve() 


// Se hace ciclo para insertar cada "sub-grupo" asignado a las diferentes divisiones. 

LONG ll_cve_mat
STRING ls_gpo, ls_error, ls_inserta_modifica
INTEGER le_cupo
INTEGER le_pos, le_pos2
INTEGER le_cve_division, le_porcentaje, le_cupo_proporcion


// Se elimina cualquier generación previa de la materia. 
//DELETE FROM grupos_division 
//WHERE cve_mat = :il_cve_mat
//AND periodo = :ie_periodo  
//AND anio = :ie_anio 
//USING itr_sce_adm; 
//
//DELETE FROM grupos_div_cupo 
//WHERE cve_mat = :il_cve_mat
//AND periodo = :ie_periodo  
//AND anio = :ie_anio 
//USING itr_sce_adm; 
//

FOR le_pos = 1 TO ids_grupos_div_detalle.ROWCOUNT() 


	ll_cve_mat = ids_grupos_div_detalle.GETITEMNUMBER(le_pos, "cve_mat")
	ls_gpo = ids_grupos_div_detalle.GETITEMSTRING(le_pos, "gpo")
	ie_periodo = ids_grupos_div_detalle.GETITEMNUMBER(le_pos, "periodo")
	ie_anio = ids_grupos_div_detalle.GETITEMNUMBER(le_pos, "anio") 
	le_cupo = ids_grupos_div_detalle.GETITEMNUMBER(le_pos, "cupo") 
	ls_inserta_modifica = ids_grupos_div_detalle.GETITEMSTRING(le_pos, "inserta_modifica")  
	
	// Se se agrega un nuevo grupo
	IF ls_inserta_modifica = 'I' THEN 
	
		INSERT INTO grupos_division (cve_mat, gpo, periodo, anio, cupo, inscritos)
		VALUES (:il_cve_mat, :ls_gpo, :ie_periodo, :ie_anio, :le_cupo, 0)	
		USING itr_sce_adm; 
		IF itr_sce_adm.SQLCODE < 0 THEN 
			ls_error = itr_sce_adm.SQLERRTEXT 
			ROLLBACK USING itr_sce_adm; 
			MESSAGEBOX("Error", "Se produjo un error al generar los grupos a utilizar: " + ls_error) 
			RETURN -1
		END IF 
		
	// Si se actualiza el cupo de un grupo 	
	ELSE
		
		UPDATE grupos_division 
		SET cupo = :le_cupo 
		WHERE cve_mat = :il_cve_mat 
		AND gpo = :ls_gpo 
		AND periodo = :ie_periodo 
		AND anio = :ie_anio 
		USING itr_sce_adm; 
		IF itr_sce_adm.SQLCODE < 0 THEN 
			ls_error = itr_sce_adm.SQLERRTEXT 
			ROLLBACK USING itr_sce_adm; 
			MESSAGEBOX("Error", "Se produjo un error al actualizar el cupo de los grupos a utilizar: " + ls_error) 
			RETURN -1
		END IF 		
		
	END IF
	
	// Se genera el detalle de p´roporción de cupo por división 
	FOR le_pos2 = 1 TO ids_grupos_div_cupo.ROWCOUNT() 
		
		le_cve_division = ids_grupos_div_cupo.GETITEMNUMBER(le_pos2, "cve_division") 
		le_porcentaje = ids_grupos_div_cupo.GETITEMNUMBER(le_pos2, "porcentaje") 
		
		le_cupo_proporcion = TRUNCATE((le_cupo * (le_porcentaje/100)), 0) 

		// Se inserta un nuevo grupos para inscripción
		IF ls_inserta_modifica = 'I' THEN 
		
			INSERT INTO grupos_div_cupo (cve_mat, gpo, periodo, anio, cve_division, cupo, inscritos)
			VALUES (:ll_cve_mat, :ls_gpo, :ie_periodo, :ie_anio, :le_cve_division, :le_cupo_proporcion, 0)
			USING itr_sce_adm; 
			
		// Se modifica el cupo de algún grupo preexistente	 
		ELSE
			
			UPDATE grupos_div_cupo  
			SET cupo = :le_cupo_proporcion 
			WHERE cve_mat = :ll_cve_mat  
			AND gpo = :ls_gpo  
			AND periodo = :ie_periodo  
			AND anio = :ie_anio  
			AND cve_division = :le_cve_division
			USING itr_sce_adm; 			
			
		END IF 
		
		IF itr_sce_adm.SQLCODE < 0 THEN 
			ls_error = itr_sce_adm.SQLERRTEXT 
			ROLLBACK USING itr_sce_adm; 
			MESSAGEBOX("Error", "Se produjo un error al generar la proporción por división: " + ls_error)  
			RETURN -1
		END IF 		
		
	NEXT 	

NEXT 

COMMIT USING itr_sce_adm; 

RETURN 0 




end function

public function integer of_incribe_mat_division ();INTEGER le_pos 

LONG ll_num_paq	
LONG ll_clv_carr	
INTEGER le_clv_plan
LONG ll_cuenta
INTEGER le_cve_division 
INTEGER le_pos_gpo

LONG ll_cve_mat 
STRING ls_gpo 
INTEGER le_pos_paq 
INTEGER le_inscritos
STRING ls_error
INTEGER le_existe


// Se cargan los grupos a nivel división disponibles 
ids_grupos_cupo_div = CREATE DATASTORE 
ids_grupos_cupo_div.DATAOBJECT = "dw_grupos_div_cupo_insc" 
ids_grupos_cupo_div.SETTRANSOBJECT(gtr_sadm)
ids_grupos_cupo_div.RETRIEVE(9999, ie_periodo, ie_anio)

ids_aspiran_inscribe = CREATE DATASTORE  
ids_aspiran_inscribe.DATAOBJECT = "dw_asp_alum_ing_paq_div" 
ids_aspiran_inscribe.SETTRANSOBJECT(gtr_sadm)
ids_aspiran_inscribe.RETRIEVE(il_version, ie_periodo, ie_anio, il_folio_inc, il_folio_fin)


DATASTORE lds_grupos_paquete 
lds_grupos_paquete = CREATE DATASTORE 
lds_grupos_paquete.DATAOBJECT = "dw_paq_mat_division" 
lds_grupos_paquete.SETTRANSOBJECT(gtr_sadm)
lds_grupos_paquete.RETRIEVE(ie_periodo, ie_anio)

// Se hace ciclo sobre los aspirantes. 
FOR le_pos = 1 TO ids_aspiran_inscribe.ROWCOUNT() 
	
	ll_num_paq	= ids_aspiran_inscribe.GETITEMNUMBER(le_pos, "num_paq	")
	ll_clv_carr = ids_aspiran_inscribe.GETITEMNUMBER(le_pos, "aspiran_clv_carr")	
	le_clv_plan	= ids_aspiran_inscribe.GETITEMNUMBER(le_pos, "clv_plan")
	ll_cuenta	= ids_aspiran_inscribe.GETITEMNUMBER(le_pos, "general_cuenta")
	le_cve_division	= ids_aspiran_inscribe.GETITEMNUMBER(le_pos, "cve_division") 

	// Se hace ciclo sobre los grupos asociados al paquete para encontrar alguno con cupo en la divisón correspondiente. 
	lds_grupos_paquete.SETFILTER("paquetes_materias_num_paq = " + STRING(ll_num_paq))  
	lds_grupos_paquete.FILTER() 
	
	FOR le_pos_paq = 1 TO lds_grupos_paquete.ROWCOUNT() 
			
		ll_cve_mat = lds_grupos_paquete.GETITEMNUMBER(le_pos_paq, "cve_mat")  
		ls_gpo = lds_grupos_paquete.GETITEMSTRING(le_pos_paq, "gpo")  

		// Se verifica si la materia ya fue inscrita. 
		SELECT COUNT(*) 
		INTO :le_existe
		FROM controlescolar_bd.dbo.mat_inscritas 
		WHERE cuenta = :ll_cuenta 
		AND cve_mat = :ll_cve_mat 
		AND periodo = :ie_periodo 
		AND anio = :ie_anio  
		USING gtr_sce; 
		IF gtr_sce.SQLCODE < 0 THEN 
			ls_error = gtr_sce.SQLERRTEXT 
			ROLLBACK USING gtr_sadm;
			ROLLBACK USING gtr_sce; 
			MESSAGEBOX("Error", "Se produjo un error al verificar si la materia ya fue inscrita: " + ls_error)  
			RETURN -1
		END IF 
		
		IF le_existe > 0 THEN EXIT  	
	
	
		// Se busca un grupo con cupo disponible para la división. 
		le_pos_gpo = ids_grupos_cupo_div.FIND("cve_mat = " + STRING(ll_cve_mat) + " AND gpo = '" + ls_gpo + "' AND cve_division = " + STRING(le_cve_division)  + &
															" AND cupo > inscritos ", 1, ids_grupos_cupo_div.ROWCOUNT() + 1) 	 
		
		IF le_pos_gpo > 0 THEN 
			
			IF ll_cuenta = 223062 THEN
				ll_cuenta = ll_cuenta 
			END IF 				
			
			
			// Si encuentra cupo, inscribe al alumno 
			le_inscritos = ids_grupos_cupo_div.GETITEMNUMBER(le_pos_gpo, "inscritos") 
			le_inscritos++
			ids_grupos_cupo_div.SETITEM(le_pos_gpo, "inscritos", le_inscritos) 
			
			UPDATE grupos_div_cupo
			SET inscritos = :le_inscritos
			WHERE cve_mat = :ll_cve_mat
			AND gpo = :ls_gpo
			AND periodo = :ie_periodo
			AND anio = :ie_anio
			AND cve_division = :le_cve_division 
			USING gtr_sadm; 
			IF gtr_sadm.SQLCODE < 0 THEN 
				ls_error = gtr_sadm.SQLERRTEXT 
				ROLLBACK USING gtr_sadm;
				ROLLBACK USING gtr_sce; 
				MESSAGEBOX("Error", "Se produjo un error al insertar el cupo por división: " + ls_error) 
				RETURN -1
			END IF 
			
			UPDATE grupos_division
			SET inscritos = (inscritos + 1)
			WHERE cve_mat = :ll_cve_mat
			AND gpo = :ls_gpo
			AND periodo = :ie_periodo
			AND anio = :ie_anio
			AND inscritos < (inscritos + 1)
			USING gtr_sadm; 
			IF gtr_sadm.SQLCODE < 0 THEN 
				ls_error = gtr_sadm.SQLERRTEXT 
				ROLLBACK USING gtr_sadm;
				ROLLBACK USING gtr_sce; 
				MESSAGEBOX("Error", "Se produjo un error al insertar el cupo por división: " + ls_error) 
				RETURN -1
			END IF 			
			
			INSERT INTO controlescolar_bd.dbo.mat_inscritas (cuenta, cve_mat, gpo, periodo, anio, calificacion, cve_condicion, acreditacion, inscripcion)
			VALUES (:ll_cuenta, :ll_cve_mat, :ls_gpo,  :ie_periodo, :ie_anio, null, 0, null, 'I')
			USING gtr_sce; 
			IF gtr_sce.SQLCODE < 0 THEN 
				ls_error = gtr_sce.SQLERRTEXT 
				ROLLBACK USING gtr_sadm;
				ROLLBACK USING gtr_sce; 
				MESSAGEBOX("Error", "Se produjo un error al insertar en mat_inscritas división: " + ls_error + " " + STRING(ll_cuenta) + "-" + STRING(ll_cve_mat) + "-" + ls_gpo ) 
				RETURN -1
			END IF 
			
			EXIT
			
		ELSE
			
			CONTINUE 

		END IF 	
			
			
			
			
			
	////num_paq	
	////clv_carr	
	////clv_plan
	////cuenta
	////cve_division		
	//		
	//
	NEXT


	

	

NEXT 

commit using gtr_sce;
COMMIT USING itr_sce_adm; 

 ids_grupos_cupo_div.SAVEAS("", CLIPBOARD!, TRUE) 
 MESSAGEBOX("Aviso", "Inscripción de materias terminada" )


RETURN 0 

//num_paq	
//clv_carr	
//clv_plan
//cuenta
//cve_division
//
//
//
//
//
//
//
//num_paq	clv_carr	clv_plan
//1439	102	10
//
//
//cuenta
//222678
//
//
//cve_division
//3000
//







end function

on uo_gpo_division_servicios_back.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_gpo_division_servicios_back.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

