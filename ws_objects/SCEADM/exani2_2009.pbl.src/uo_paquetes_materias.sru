$PBExportHeader$uo_paquetes_materias.sru
forward
global type uo_paquetes_materias from nonvisualobject
end type
end forward

global type uo_paquetes_materias from nonvisualobject
end type
global uo_paquetes_materias uo_paquetes_materias

type variables
DATASTORE ids_aspirantes 
DATASTORE ids_resultadoxcoba
DATASTORE ids_prop_carrera_peso
DATASTORE ids_prop_carrera_minimos
DATASTORE ids_prop_rel_alumno_tipo
DATASTORE ids_prop_aspirante_tipo
DATASTORE ids_prop_alumno_asignacion
DATASTORE ids_prop_alumno_asig_paso 

DATASTORE ids_prerrequisitos_esp



INTEGER le_tot0
INTEGER le_tot1
INTEGER Totales
INTEGER Procesados
end variables

forward prototypes
public function integer f_asigna_propedeuticos (integer al_cve_carrera)
public function integer f_evalua_excoba (long al_folio, long al_carrera, long al_plan, long al_cuenta, ref datastore ads_prop_alumno_asig_paso)
public function integer f_cuenta_paquetes (long al_coordinacion, integer ae_periodo, integer ae_anio, transaction atr_trans, datastore ads_retorno)
public function integer f_carga_aspirantes (integer ai_periodo, integer ai_anio, long al_carrera, string as_modificado)
end prototypes

public function integer f_asigna_propedeuticos (integer al_cve_carrera);
//// Se recuperan los aspirantes aceptados
//ids_aspirantes
//// Se recupera el resultado de la evaluación XCOBA
//ids_resultadoxcoba
//// Se recupera el peso del área y el número de reactivos  d_prop_carrera_peso
//ids_prop_carrera_peso
//// Se recupera el porcentaje mínimo para no cursar propedeútico 
//ids_prop_carrera_minimos
//// Propedeúticos asociados al tipo de alumno
//ids_prop_rel_alumno_tipo
//// Se recuperan los alumnos y se separan por tipo para determinar los posibles propedeúticos que cursarán 
//ids_prop_aspirante_tipo


INTEGER le_pos_aspiran 
INTEGER le_ttl_aspiran
LONG ll_folio 
LONG ll_cve_carrera, ll_plan
LONG ll_cuenta
INTEGER le_anio_ing 
INTEGER le_mes_ing
INTEGER le_pos

// Se recupera el total de aspirantes. 
le_ttl_aspiran = ids_aspirantes.ROWCOUNT() 


// Se hace ciclo para evaluar a cada aspirante.
FOR le_pos_aspiran = 1 TO le_ttl_aspiran 

	ll_folio = ids_aspirantes.GETITEMNUMBER(le_pos_aspiran, "folio")  
	ll_cve_carrera = ids_aspirantes.GETITEMNUMBER(le_pos_aspiran, "clv_carr")   
	ll_cuenta = ids_aspirantes.GETITEMNUMBER(le_pos_aspiran, "general_cuenta")   
	ll_plan = ids_aspirantes.GETITEMNUMBER(le_pos_aspiran, "v_academicos_cve_plan")    
	
	le_anio_ing = ids_aspirantes.GETITEMNUMBER(le_pos_aspiran, "ing_per")   
	le_mes_ing = ids_aspirantes.GETITEMNUMBER(le_pos_aspiran, "ing_anio")   
	
IF 	ll_folio = 186009 OR & 
				ll_folio = 180005 OR  & 
				ll_folio = 180043 OR  & 
				ll_folio = 180055 OR  & 
				ll_folio = 180137 OR  & 
				ll_folio = 180159 OR  & 
				ll_folio = 180160 OR  & 
				ll_folio = 180201 THEN 
	ll_folio = ll_folio
END IF

	// Se filtra el datastore de resultados. 
	ids_resultadoxcoba.SETFILTER("aspiran_folio = " + STRING(ll_folio)) 
	ids_resultadoxcoba.FILTER() 
	IF ids_resultadoxcoba.ROWCOUNT() = 0 THEN 
		CONTINUE 
	END IF
	Procesados++
	
	// Se limpia el de ds de paso para cada iteración 
	ids_prop_alumno_asig_paso.RESET() 
	
	// Se llama función que calcula el porcentaje de aciertos 
	f_evalua_excoba(ll_folio, ll_cve_carrera, ll_plan, ll_cuenta, ids_prop_alumno_asig_paso)  

	FOR le_pos = 1 TO ids_prop_alumno_asig_paso.ROWCOUNT()
		
		ids_prop_alumno_asig_paso.SETITEM(le_pos, "cuenta", ll_cuenta) 
		ids_prop_alumno_asig_paso.SETITEM(le_pos, "periodo", le_anio_ing) 
		ids_prop_alumno_asig_paso.SETITEM(le_pos, "anio", le_mes_ing) 
		ids_prop_alumno_asig_paso.SETITEM(le_pos, "modificado", "P")  
		
	NEXT

	IF ids_prop_alumno_asig_paso.ROWCOUNT() > 0 THEN  
		ids_prop_alumno_asig_paso.ROWSCOPY(1, ids_prop_alumno_asig_paso.ROWCOUNT(), PRIMARY!, ids_prop_alumno_asignacion, ids_prop_alumno_asignacion.ROWCOUNT() + 1, PRIMARY!)
	END IF 		
	
NEXT 

STRING ls_error

DELETE FROM prop_alumno_asignacion 
WHERE periodo = :le_anio_ing
AND anio = :le_mes_ing 
AND modificado = 'P' 
USING gtr_sadm;
//MESSAGEBOX("BORRO", "Borro: " + STRING(gtr_sadm.SQLNRows) )  
IF gtr_sadm.SQLCODE < 0 THEN 
	ls_error = gtr_sadm.SQLERRTEXT 
	ROLLBACK USING gtr_sadm;
	MESSAGEBOX("Error", "Se produjo un error al eliminar la asignación de propedéuticos anterior: " + ls_error )  
	RETURN -1
END IF 





ids_prop_alumno_asignacion.UPDATE() 
COMMIT USING gtr_sadm; 


Totales = le_ttl_aspiran

MESSAGEBOX("Procesados", "Totales = " + STRING(Totales) + " Procesados = " + STRING(Procesados) + "  Normales = " + STRING(le_tot0) + " Si Quieres Puedes = " + STRING(le_tot1) ) 



RETURN 0 












end function

public function integer f_evalua_excoba (long al_folio, long al_carrera, long al_plan, long al_cuenta, ref datastore ads_prop_alumno_asig_paso);LONG ll_folio
LONG ll_cuenta
LONG ll_periodo
LONG ll_anio
LONG ll_cve_carrera
DECIMAL ld_porcentaje_aciertos
LONG ll_id_prop
STRING ls_carrera_filtro

INTEGER le_row 
INTEGER le_pos_enc
STRING ls_id_prop
DECIMAL ld_porcentaje_min
INTEGER le_pos_puntaje

INTEGER le_tipo_alumno
INTEGER le_tipo 
INTEGER le_row_ins
INTEGER le_pos_tipo

DECIMAL ld_procentaje_minimo
INTEGER li_por_peso
INTEGER li_prop_carr_peso_id_area
DECIMAL ld_prop_carrera_peso_peso
LONG ll_area_eval_num_reactivos
DECIMAL ld_puntaje_examen
DECIMAL ld_porcentaje_proporcional //, ld_porcentaje_acumulado
LONG ll_carrera_original

STRING ls_evaluacion 
DECIMAL ld_total_reactivos
DECIMAL ld_total_puntaje 
DECIMAL ld_aciertos_minimos

ll_carrera_original = al_carrera

IF al_carrera = 103 OR al_carrera = 2701 THEN 
	al_carrera = al_carrera 
END IF


// Se filtra el ds con los resultados del examen.
ids_resultadoxcoba.SETFILTER("aspiran_folio = " + STRING(al_folio))
ids_resultadoxcoba.FILTER()

// Se filtran los porcentajes mínimos de las carreras 
ids_prop_carrera_minimos.SETFILTER("")
ids_prop_carrera_minimos.FILTER() 
le_pos_enc = ids_prop_carrera_minimos.FIND("cve_carrera = " + STRING(al_carrera), 0, ids_prop_carrera_minimos.ROWCOUNT() + 1) 
IF le_pos_enc > 0 THEN 
	ids_prop_carrera_minimos.SETFILTER("cve_carrera = " + STRING(al_carrera))	 
	ids_prop_carrera_minimos.FILTER() 
ELSE
	ids_prop_carrera_minimos.SETFILTER("cve_carrera = 9999")	 
	ids_prop_carrera_minimos.FILTER() 	
	// Al no encontrar la carrera se usa "Todas las carreras"
	al_carrera = 9999
END IF


// Se filtran los pesos de carrera
ids_prop_carrera_peso.SETFILTER("")
ids_prop_carrera_peso.FILTER()
le_pos_enc = ids_prop_carrera_peso.FIND("prop_carrera_peso_cve_carrera = " + STRING(al_carrera), 0, ids_prop_carrera_peso.ROWCOUNT() + 1) 
IF le_pos_enc > 0 THEN  
	// Se filtran los valores correspondientes a la carrera. 
	ids_prop_carrera_peso.SETFILTER("prop_carrera_peso_cve_carrera = " + STRING(al_carrera)) 
	ids_prop_carrera_peso.FILTER() 
ELSE
	// Si no tiene definido ningún propedeútico se utilizan los valores default.
	ids_prop_carrera_peso.SETFILTER("prop_carrera_peso_cve_carrera = 9999")  
	ids_prop_carrera_peso.FILTER() 	
END IF 

// Se busca el tipo de alumno.
le_pos_enc = ids_prop_aspirante_tipo.FIND("cuenta = " + STRING(al_cuenta), 0, ids_prop_aspirante_tipo.ROWCOUNT() + 1) 
IF le_pos_enc > 0 THEN 
	le_tipo_alumno = 1 
	le_tot1++
ELSE
	// Se asigna 0 (Normal), por default 
	le_tipo_alumno = 0 
	le_tot0 ++
END IF

// Se busca la carrera en el ds de prerrequisitos especiales.
le_pos_enc = ids_prerrequisitos_esp.FIND("cve_carrera = " + STRING(ll_carrera_original) + " AND  cve_plan = " + STRING(al_plan), 0, ids_prerrequisitos_esp.ROWCOUNT() + 1) 

// Antes de hacer la asignación se verifica si en la carrera aplican los propedéuticos.
IF le_pos_enc > 0 THEN 
	
	// Se hace ciclo sobre los propedeuticos que aplican al alumno según su carrera.
	FOR le_tipo = 1 TO ids_prop_carrera_minimos.ROWCOUNT() 
		
		ls_id_prop = ids_prop_carrera_minimos.GETITEMSTRING(le_tipo, "id_prop")  
		ld_procentaje_minimo = ids_prop_carrera_minimos.GETITEMDECIMAL(le_tipo, "procentaje_minimo")  
		ld_aciertos_minimos = ids_prop_carrera_minimos.GETITEMDECIMAL(le_tipo, "numero_aciertos")  
		
		// Se filtran los valores correspondientes a la carrera. 
		ls_carrera_filtro = STRING(al_carrera)
		ids_prop_carrera_peso.SETFILTER("prop_carrera_peso_cve_carrera = " + ls_carrera_filtro + " AND prop_carrera_peso_id_prop = '" + ls_id_prop + "'")  
		ids_prop_carrera_peso.FILTER() 
		
		//ld_porcentaje_acumulado = 0
		ld_total_puntaje = 0
		
		// Se hace ciclo sobre el propedeutico para evaluar el resultado del examen de admisión. 
		FOR li_por_peso = 1 TO ids_prop_carrera_peso.ROWCOUNT() 
			
			li_prop_carr_peso_id_area = ids_prop_carrera_peso.GETITEMNUMBER(li_por_peso, "prop_carrera_peso_id_area") 
			ld_prop_carrera_peso_peso = ids_prop_carrera_peso.GETITEMNUMBER(li_por_peso, "prop_carrera_peso_peso") 
			ll_area_eval_num_reactivos = ids_prop_carrera_peso.GETITEMNUMBER(li_por_peso, "area_evaluacion_numero_reactivos")
			//IF ll_area_eval_num_reactivos = 0 THEN ll_area_eval_num_reactivos = 1 
			
			
			ls_evaluacion = ids_prop_carrera_peso.GETITEMSTRING(li_por_peso, "prop_carrera_peso_evaluacion") 
			IF ISNULL(ls_evaluacion) OR TRIM(ls_evaluacion) = ""  THEN ls_evaluacion = "N"  
			IF ls_evaluacion = "N" THEN CONTINUE 
			
			// Si el Área participa en la evaluación se acumula el número de reactivos 
			ld_total_reactivos = ld_total_reactivos + ll_area_eval_num_reactivos 
			
			// Se busca y recupera el puntaje del área.
			CHOOSE CASE li_prop_carr_peso_id_area 
				CASE 1 
					ld_puntaje_examen = ids_resultadoxcoba.GETITEMDECIMAL(1, "resultado_examen_excoba_2017_espaniol_primaria")	
				CASE 2
					ld_puntaje_examen = ids_resultadoxcoba.GETITEMDECIMAL(1, "resultado_examen_excoba_2017_matematicas_primaria")		
				CASE 3
					ld_puntaje_examen = ids_resultadoxcoba.GETITEMDECIMAL(1, "resultado_examen_excoba_2017_espaniol_secundaria")		
				CASE 4
					ld_puntaje_examen = ids_resultadoxcoba.GETITEMDECIMAL(1, "resultado_examen_excoba_2017_matematicas_secundaria")	
				CASE 5
					ld_puntaje_examen = ids_resultadoxcoba.GETITEMDECIMAL(1, "resultado_examen_excoba_2017_cs_naturales_secundaria")		
				CASE 6
					ld_puntaje_examen = ids_resultadoxcoba.GETITEMDECIMAL(1, "resultado_examen_excoba_2017_cs_sociales_secundaria	")	
				CASE 7
					ld_puntaje_examen = ids_resultadoxcoba.GETITEMDECIMAL(1, "resultado_examen_excoba_2017_asignatura_1")		
				CASE 8
					ld_puntaje_examen = ids_resultadoxcoba.GETITEMDECIMAL(1, "resultado_examen_excoba_2017_asignatura_2")		
				CASE 9
					ld_puntaje_examen = ids_resultadoxcoba.GETITEMDECIMAL(1, "resultado_examen_excoba_2017_asignatura_3")	
			END CHOOSE
			IF ISNULL(ld_puntaje_examen) THEN ld_puntaje_examen = 0 
			
			// Se acumula el puntaje del área  
			ld_total_puntaje = ld_total_puntaje + ld_puntaje_examen 
			
		NEXT 
		
		// Se verifica si el aspirante alcanza el mínimo para no cursar 
		//IF ld_porcentaje_acumulado < ld_procentaje_minimo THEN 
		IF ld_total_puntaje <= ld_aciertos_minimos THEN 	 
			
	//		ll_folio = al_folio
			ll_cuenta = 0
			ll_periodo = ids_resultadoxcoba.GETITEMNUMBER(1, "aspiran_clv_per")	
			ll_anio = ids_resultadoxcoba.GETITEMNUMBER(1, "aspiran_anio")		
			ll_cve_carrera = al_carrera
			//ld_porcentaje_aciertos = ld_porcentaje_acumulado
			//ls_id_prop = ls_id_prop
			
			le_row_ins = ads_prop_alumno_asig_paso.INSERTROW(0)
			ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "cuenta", ll_cuenta)	
			ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "periodo", ll_periodo)	
			ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "anio", ll_anio)	
			ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "cve_carrera", ll_cve_carrera)	
			ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "porcentaje_aciertos", ld_porcentaje_aciertos)	
			ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "id_prop",ls_id_prop)		
			ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "folio",al_folio)		
			
		END IF
		
	NEXT 
		
END IF  // CIERRE DE VERIFICACIÖN DE CARRERA EN PRERREQUISITOS ESPECIALES 		



// Se filtran los propedeúticos asignados por default al tipo de alumno.
ids_prop_rel_alumno_tipo.SETFILTER("id_tipo = " + STRING(le_tipo_alumno))
ids_prop_rel_alumno_tipo.FILTER() 

// Segundo ciclo para los propedeuticos que se asignan por tipo de alumno. estos SIEMPRE SE ASIGNAN (SOLO PARA CIERTAS CARRERAS)	 
FOR le_pos_tipo = 1 TO ids_prop_rel_alumno_tipo.ROWCOUNT() 
	
	// Se toma el tipo de propedéutico 
	ls_id_prop = ids_prop_rel_alumno_tipo.GETITEMSTRING(le_pos_tipo, "id_prop") 

	// Se verifica si ya se asignó un propedéutico de este tipo
	le_pos_enc = ads_prop_alumno_asig_paso.FIND("id_prop = '" + ls_id_prop + "'", 0, ads_prop_alumno_asig_paso.ROWCOUNT() + 1)  
	
	// Si lo encuentra continúa con el siguiente curso
	IF le_pos_enc > 0 THEN CONTINUE 
	
	// Si no lo encuentra evalúa si este tipo de propedéutico aplica para la carrera del alumno.  
	le_pos_enc = ids_prerrequisitos_esp.FIND("cve_carrera = " + STRING(ll_carrera_original) + " AND  cve_plan = " + STRING(al_plan) + " AND prop_rel_materia_id_prop = '" + ls_id_prop + "'" , 0, ids_prerrequisitos_esp.ROWCOUNT() + 1) 
	
	// Si no existe este propedéutico relacionado a esta carrera, no lo agrega 
	IF le_pos_enc <= 0 THEN CONTINUE
		
//		ll_folio = al_folio
	ll_cuenta = 0
	ll_periodo = ids_resultadoxcoba.GETITEMNUMBER(1, "aspiran_clv_per")	
	ll_anio = ids_resultadoxcoba.GETITEMNUMBER(1, "aspiran_anio")		
	ll_cve_carrera = al_carrera
	ld_porcentaje_aciertos = 0
	//ls_id_prop = ls_id_prop		
	
	le_row_ins = ads_prop_alumno_asig_paso.INSERTROW(0)
	ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "cuenta", ll_cuenta)	
	ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "periodo", ll_periodo)	
	ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "anio", ll_anio)	
	ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "cve_carrera", ll_cve_carrera)	
	ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "porcentaje_aciertos", ld_porcentaje_aciertos)	
	ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "id_prop",ls_id_prop)		
	ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "folio",al_folio)					
	

NEXT 
	

RETURN  0









//LONG ll_folio
//LONG ll_cuenta
//LONG ll_periodo
//LONG ll_anio
//LONG ll_cve_carrera
//DECIMAL ld_porcentaje_aciertos
//LONG ll_id_prop
//STRING ls_carrera_filtro
//
//INTEGER le_row 
//INTEGER le_pos_enc
//STRING ls_id_prop
//DECIMAL ld_porcentaje_min
//INTEGER le_pos_puntaje
//
//INTEGER le_tipo_alumno
//INTEGER le_tipo 
//INTEGER le_row_ins
//INTEGER le_pos_tipo
//
//DECIMAL ld_procentaje_minimo
//INTEGER li_por_peso
//INTEGER li_prop_carr_peso_id_area
//DECIMAL ld_prop_carrera_peso_peso
//LONG ll_area_eval_num_reactivos
//DECIMAL ld_puntaje_examen
//DECIMAL ld_porcentaje_proporcional, ld_porcentaje_acumulado
//LONG ll_carrera_original
//ll_carrera_original = al_carrera
//
//IF al_carrera = 103 OR al_carrera = 2701 THEN 
//	al_carrera = al_carrera 
//END IF
//
//
//// Se filtra el ds con los resultados del examen.
//ids_resultadoxcoba.SETFILTER("aspiran_folio = " + STRING(al_folio))
//ids_resultadoxcoba.FILTER()
//
//// Se filtran los porcentajes mínimos de las carreras 
//ids_prop_carrera_minimos.SETFILTER("")
//ids_prop_carrera_minimos.FILTER() 
//le_pos_enc = ids_prop_carrera_minimos.FIND("cve_carrera = " + STRING(al_carrera), 0, ids_prop_carrera_minimos.ROWCOUNT() + 1) 
//IF le_pos_enc > 0 THEN 
//	ids_prop_carrera_minimos.SETFILTER("cve_carrera = " + STRING(al_carrera))	 
//	ids_prop_carrera_minimos.FILTER() 
//ELSE
//	ids_prop_carrera_minimos.SETFILTER("cve_carrera = 9999")	 
//	ids_prop_carrera_minimos.FILTER() 	
//	// Al no encontrar la carrera se usa "Todas las carreras"
//	al_carrera = 9999
//END IF
//
//
//// Se filtran los pesos de carrera
//ids_prop_carrera_peso.SETFILTER("")
//ids_prop_carrera_peso.FILTER()
//le_pos_enc = ids_prop_carrera_peso.FIND("prop_carrera_peso_cve_carrera = " + STRING(al_carrera), 0, ids_prop_carrera_peso.ROWCOUNT() + 1) 
//IF le_pos_enc > 0 THEN  
//	// Se filtran los valores correspondientes a la carrera. 
//	ids_prop_carrera_peso.SETFILTER("prop_carrera_peso_cve_carrera = " + STRING(al_carrera)) 
//	ids_prop_carrera_peso.FILTER() 
//ELSE
//	// Si no tiene definido ningún propedeútico se utilizan los valores default.
//	ids_prop_carrera_peso.SETFILTER("prop_carrera_peso_cve_carrera = 9999")  
//	ids_prop_carrera_peso.FILTER() 	
//END IF 
//
//// Se busca el tipo de alumno.
//le_pos_enc = ids_prop_aspirante_tipo.FIND("cuenta = " + STRING(al_cuenta), 0, ids_prop_aspirante_tipo.ROWCOUNT() + 1) 
//IF le_pos_enc > 0 THEN 
//	le_tipo_alumno = 1 
//	le_tot1++
//ELSE
//	// Se asigna 0 (Normal), por default 
//	le_tipo_alumno = 0 
//	le_tot0 ++
//END IF
//
//// Se busca la carrera en el ds de prerrequisitos especiales.
//le_pos_enc = ids_prerrequisitos_esp.FIND("cve_carrera = " + STRING(ll_carrera_original) + " AND  cve_plan = " + STRING(al_plan), 0, ids_prerrequisitos_esp.ROWCOUNT() + 1) 
//
//// Antes de hacer la asignación se verifica si en la carrera aplican los propedéuticos.
//IF le_pos_enc > 0 THEN 
//	
//	// Se hace ciclo sobre los propedeuticos que aplican al alumno según su carrera.
//	FOR le_tipo = 1 TO ids_prop_carrera_minimos.ROWCOUNT() 
//		
//		ls_id_prop = ids_prop_carrera_minimos.GETITEMSTRING(le_tipo, "id_prop")
//		ld_procentaje_minimo = ids_prop_carrera_minimos.GETITEMDECIMAL(le_tipo, "procentaje_minimo") 
//		
//		// Se filtran los valores correspondientes a la carrera. 
//		ls_carrera_filtro = STRING(al_carrera)
//		ids_prop_carrera_peso.SETFILTER("prop_carrera_peso_cve_carrera = " + ls_carrera_filtro + " AND prop_carrera_peso_id_prop = '" + ls_id_prop + "'")  
//		ids_prop_carrera_peso.FILTER() 
//		
//		ld_porcentaje_acumulado = 0
//		
//		// Se hace ciclo sobre el propedeutico para evaluar el resultado del examen de admisión. 
//		FOR li_por_peso = 1 TO ids_prop_carrera_peso.ROWCOUNT() 
//			
//			li_prop_carr_peso_id_area = ids_prop_carrera_peso.GETITEMNUMBER(li_por_peso, "prop_carrera_peso_id_area") 
//			ld_prop_carrera_peso_peso = ids_prop_carrera_peso.GETITEMNUMBER(li_por_peso, "prop_carrera_peso_peso") 
//			ll_area_eval_num_reactivos = ids_prop_carrera_peso.GETITEMNUMBER(li_por_peso, "area_evaluacion_numero_reactivos")
//			IF ll_area_eval_num_reactivos = 0 THEN ll_area_eval_num_reactivos = 1 
//			
//			// Se busca y recupera el puntaje del área.
//			CHOOSE CASE li_prop_carr_peso_id_area 
//				CASE 1 
//					ld_puntaje_examen = ids_resultadoxcoba.GETITEMDECIMAL(1, "resultado_examen_excoba_2017_espaniol_primaria")	
//				CASE 2
//					ld_puntaje_examen = ids_resultadoxcoba.GETITEMDECIMAL(1, "resultado_examen_excoba_2017_matematicas_primaria")		
//				CASE 3
//					ld_puntaje_examen = ids_resultadoxcoba.GETITEMDECIMAL(1, "resultado_examen_excoba_2017_espaniol_secundaria")		
//				CASE 4
//					ld_puntaje_examen = ids_resultadoxcoba.GETITEMDECIMAL(1, "resultado_examen_excoba_2017_matematicas_secundaria")	
//				CASE 5
//					ld_puntaje_examen = ids_resultadoxcoba.GETITEMDECIMAL(1, "resultado_examen_excoba_2017_cs_naturales_secundaria")		
//				CASE 6
//					ld_puntaje_examen = ids_resultadoxcoba.GETITEMDECIMAL(1, "resultado_examen_excoba_2017_cs_sociales_secundaria	")	
//				CASE 7
//					ld_puntaje_examen = ids_resultadoxcoba.GETITEMDECIMAL(1, "resultado_examen_excoba_2017_asignatura_1")		
//				CASE 8
//					ld_puntaje_examen = ids_resultadoxcoba.GETITEMDECIMAL(1, "resultado_examen_excoba_2017_asignatura_2")		
//				CASE 9
//					ld_puntaje_examen = ids_resultadoxcoba.GETITEMDECIMAL(1, "resultado_examen_excoba_2017_asignatura_3")	
//			END CHOOSE
//			IF ISNULL(ld_puntaje_examen) THEN ld_puntaje_examen = 0 
//	
//			// Se calcula el porcentaje proporcional
//			ld_porcentaje_proporcional = (ld_puntaje_examen * ld_prop_carrera_peso_peso) / 100 
//			//ld_porcentaje_proporcional = (ld_puntaje_examen * ld_prop_carrera_peso_peso) / ll_area_eval_num_reactivos
//			//ld_porcentaje_proporcional = (ld_puntaje_examen * 100) / ll_area_eval_num_reactivos
//			
//			// Se acumula el porcentaje 
//			ld_porcentaje_acumulado = ld_porcentaje_acumulado + ld_porcentaje_proporcional
//			
//		NEXT 
//		
//		// Se verifica si el aspirante alcanza el mínimo para no cursar 
//		IF ld_porcentaje_acumulado < ld_procentaje_minimo THEN 
//			
//	//		ll_folio = al_folio
//			ll_cuenta = 0
//			ll_periodo = ids_resultadoxcoba.GETITEMNUMBER(1, "aspiran_clv_per")	
//			ll_anio = ids_resultadoxcoba.GETITEMNUMBER(1, "aspiran_anio")		
//			ll_cve_carrera = al_carrera
//			ld_porcentaje_aciertos = ld_porcentaje_acumulado
//			//ls_id_prop = ls_id_prop
//			
//			le_row_ins = ads_prop_alumno_asig_paso.INSERTROW(0)
//			ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "cuenta", ll_cuenta)	
//			ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "periodo", ll_periodo)	
//			ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "anio", ll_anio)	
//			ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "cve_carrera", ll_cve_carrera)	
//			ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "porcentaje_aciertos", ld_porcentaje_aciertos)	
//			ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "id_prop",ls_id_prop)		
//			ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "folio",al_folio)		
//			
//		END IF
//		
//	NEXT 
//		
//END IF  // CIERRE DE VERIFICACIÖN DE CARRERA EN PRERREQUISITOS ESPECIALES 		
//
//
//
//// Se filtran los propedeúticos asignados por default al tipo de alumno.
//ids_prop_rel_alumno_tipo.SETFILTER("id_tipo = " + STRING(le_tipo_alumno))
//ids_prop_rel_alumno_tipo.FILTER() 
//
//// Segundo ciclo para los propedeuticos que se asignan por tipo de alumno. estos SIEMPRE SE ASIGNAN (SOLO PARA CIERTAS CARRERAS)	 
//FOR le_pos_tipo = 1 TO ids_prop_rel_alumno_tipo.ROWCOUNT() 
//	
//	// Se toma el tipo de propedéutico 
//	ls_id_prop = ids_prop_rel_alumno_tipo.GETITEMSTRING(le_pos_tipo, "id_prop") 
//
//	// Se verifica si ya se asignó un propedéutico de este tipo
//	le_pos_enc = ads_prop_alumno_asig_paso.FIND("id_prop = '" + ls_id_prop + "'", 0, ads_prop_alumno_asig_paso.ROWCOUNT() + 1)  
//	
//	// Si lo encuentra continúa con el siguiente curso
//	IF le_pos_enc > 0 THEN CONTINUE 
//	
//	// Si no lo encuentra evalúa si este tipo de propedéutico aplica para la carrera del alumno.  
//	le_pos_enc = ids_prerrequisitos_esp.FIND("cve_carrera = " + STRING(ll_carrera_original) + " AND  cve_plan = " + STRING(al_plan) + " AND prop_rel_materia_id_prop = '" + ls_id_prop + "'" , 0, ids_prerrequisitos_esp.ROWCOUNT() + 1) 
//	
//	// Si no existe este propedéutico relacionado a esta carrera, no lo agrega 
//	IF le_pos_enc <= 0 THEN CONTINUE
//		
////		ll_folio = al_folio
//	ll_cuenta = 0
//	ll_periodo = ids_resultadoxcoba.GETITEMNUMBER(1, "aspiran_clv_per")	
//	ll_anio = ids_resultadoxcoba.GETITEMNUMBER(1, "aspiran_anio")		
//	ll_cve_carrera = al_carrera
//	ld_porcentaje_aciertos = 0
//	//ls_id_prop = ls_id_prop		
//	
//	le_row_ins = ads_prop_alumno_asig_paso.INSERTROW(0)
//	ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "cuenta", ll_cuenta)	
//	ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "periodo", ll_periodo)	
//	ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "anio", ll_anio)	
//	ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "cve_carrera", ll_cve_carrera)	
//	ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "porcentaje_aciertos", ld_porcentaje_aciertos)	
//	ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "id_prop",ls_id_prop)		
//	ads_prop_alumno_asig_paso.SETITEM(le_row_ins, "folio",al_folio)					
//	
//
//NEXT 
//	
//
//RETURN  0
//
//
//
//
end function

public function integer f_cuenta_paquetes (long al_coordinacion, integer ae_periodo, integer ae_anio, transaction atr_trans, datastore ads_retorno);




RETURN 0 
end function

public function integer f_carga_aspirantes (integer ai_periodo, integer ai_anio, long al_carrera, string as_modificado);INTEGER le_row


// Se recuperan los aspirantes aceptados
ids_aspirantes = CREATE DATASTORE 
ids_aspirantes.DATAOBJECT = "d_prop_aspirantes_asignacion" 
ids_aspirantes.SETTRANSOBJECT(gtr_sadm) 
le_row = ids_aspirantes.RETRIEVE(ai_periodo, ai_anio, al_carrera, as_modificado)

// Se recupera el resultado de la evaluación XCOBA
ids_resultadoxcoba = CREATE DATASTORE 
ids_resultadoxcoba.DATAOBJECT = "d_prop_resultado_examen_excoba_2017"	
ids_resultadoxcoba.SETTRANSOBJECT(gtr_sadm) 
le_row = ids_resultadoxcoba.RETRIEVE(ai_periodo, ai_anio, al_carrera) 

// Se recupera el peso del área y el número de reactivos  d_prop_carrera_peso
ids_prop_carrera_peso = CREATE DATASTORE 
ids_prop_carrera_peso.DATAOBJECT = "d_prop_carrera_peso" 
ids_prop_carrera_peso.SETTRANSOBJECT(gtr_sadm) 
le_row = ids_prop_carrera_peso.RETRIEVE() 

// Se recupera el porcentaje mínimo para no cursar propedeútico 
ids_prop_carrera_minimos = CREATE DATASTORE 
ids_prop_carrera_minimos.DATAOBJECT = "d_prop_carrera_minimos"  
ids_prop_carrera_minimos.SETTRANSOBJECT(gtr_sadm) 
le_row = ids_prop_carrera_minimos.RETRIEVE() 

// Propedeúticos asociados al tipo de alumno
ids_prop_rel_alumno_tipo = CREATE DATASTORE 
ids_prop_rel_alumno_tipo.DATAOBJECT = "d_prop_rel_alumno_tipo"  
ids_prop_rel_alumno_tipo.SETTRANSOBJECT(gtr_sadm) 
le_row = ids_prop_rel_alumno_tipo.RETRIEVE() 

// Se recuperan los alumnos y se separan por tipo para determinar los posibles propedeúticos que cursarán 
ids_prop_aspirante_tipo = CREATE DATASTORE 
//ids_prop_aspirante_tipo.DATAOBJECT = "d_prop_aspirante_tipo" 
ids_prop_aspirante_tipo.DATAOBJECT = "d_prop_v_sfeb_sqp_cuentas" 
ids_prop_aspirante_tipo.SETTRANSOBJECT(gtr_sfeb) 
le_row = ids_prop_aspirante_tipo.RETRIEVE()  

// Se crean datastores para actualización y paso de datos
ids_prop_alumno_asignacion = CREATE DATASTORE 
ids_prop_alumno_asignacion.DATAOBJECT = "d_prop_alumno_asignacion" 
le_row = ids_prop_alumno_asignacion.SETTRANSOBJECT(gtr_sadm)  

ids_prerrequisitos_esp = CREATE DATASTORE 
ids_prerrequisitos_esp.DATAOBJECT = "d_prop_prerrequisitos_esp"  
ids_prerrequisitos_esp.SETTRANSOBJECT(gtr_sadm)
le_row = ids_prerrequisitos_esp.RETRIEVE() 

ids_prop_alumno_asig_paso = CREATE DATASTORE  
ids_prop_alumno_asig_paso.DATAOBJECT = "d_prop_alumno_asignacion" 


RETURN 0 






end function

on uo_paquetes_materias.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_paquetes_materias.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

