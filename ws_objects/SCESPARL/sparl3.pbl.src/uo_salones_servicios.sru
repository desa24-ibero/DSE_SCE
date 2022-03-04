$PBExportHeader$uo_salones_servicios.sru
forward
global type uo_salones_servicios from nonvisualobject
end type
end forward

global type uo_salones_servicios from nonvisualobject
end type
global uo_salones_servicios uo_salones_servicios

type variables
DATASTORE ids_horarios 

INTEGER ie_periodo 
INTEGER ie_anio 

// Se hace "dispersión" de los edificios-niveles.  
DATASTORE ids_salones_edificio_conf 
// Datastore con los salones y el cupo ajustado al porcentaje definido por el usuario. 
DATASTORE ids_salones_disp_especial
// Datastore con las cadenas de filtrado 
DATASTORE ids_cadenas_filtrado

INTEGER ie_bloque_max 


LONG il_cupo_minimo, il_cupo_maximo

//cve_mat
//gpo
//periodo
//anio 
//cve_dia
//hora_inicio
//hora_final
//fecha_inicio
//fecha_fin
//cve_salon
end variables

forward prototypes
public function integer of_genera_id_horarios ()
public function integer of_asigna_salon (datastore ads_asigna_automatica_salon, integer ai_critcupoinsc, string as_descnivel, integer ai_i, integer ai_crit)
public function integer of_carga_horarios ()
public function integer of_genera_salon_horario ()
public function integer of_carga_asig_especial ()
public function integer of_genera_cadenas_filtrado ()
public function integer of_asigna_salon_esp (datastore ads_asigna_automatica_salon, integer ai_critcupoinsc, string as_descnivel, integer ai_i, integer ai_crit, integer ai_vuelta)
public function integer of_salones_preasignados ()
public function long of_existe_salon_esp (long ai_cupo, long ai_cupo_max, string as_grado)
end prototypes

public function integer of_genera_id_horarios ();
LONG ll_pos 
LONG ll_ttl_reg
LONG ll_id 

LONG ll_cve_mat
STRING ls_gpo
INTEGER le_periodo
INTEGER le_anio
INTEGER le_cve_dia
INTEGER le_hora_inicio
INTEGER le_hora_final
DATETIME ldt_fecha_inicio
DATETIME ldt_fecha_fin 
STRING ls_cve_salon 
STRING ls_dato  
DATE ldt_valida, ld_fecha_fin 
INTEGER le_hora, le_cve_dia_val, le_hora_fin 
INTEGER li_inscritos 
LONG ll_row, le_dia_mes

ll_ttl_reg = ids_horarios.ROWCOUNT() 

DATASTORE lds_fecha_hora
lds_fecha_hora = CREATE DATASTORE 
lds_fecha_hora.DATAOBJECT = "dw_asigna_salon_update"
lds_fecha_hora.SETTRANSOBJECT(gtr_sce)  


DELETE FROM salones_asignacion USING gtr_sce; 
COMMIT USING gtr_sce; 

FOR ll_pos = 1 TO ll_ttl_reg 


	ll_cve_mat = ids_horarios.GETITEMNUMBER(ll_pos, "cve_mat") 
	ls_gpo = ids_horarios.GETITEMSTRING(ll_pos, "gpo")
	le_periodo = ids_horarios.GETITEMNUMBER(ll_pos, "periodo")
	le_anio = ids_horarios.GETITEMNUMBER(ll_pos, "anio") 
	le_cve_dia = ids_horarios.GETITEMNUMBER(ll_pos, "cve_dia")
	le_hora_inicio = ids_horarios.GETITEMNUMBER(ll_pos, "hora_inicio")
	le_hora_final = ids_horarios.GETITEMNUMBER(ll_pos, "hora_final")
	ldt_fecha_inicio = ids_horarios.GETITEMDATETIME(ll_pos, "fecha_inicio")
	ldt_fecha_fin = ids_horarios.GETITEMDATETIME(ll_pos, "fecha_fin")
	SETNULL(ls_cve_salon) // = ids_horarios.GETITEMSTRING(ll_pos, "cve_salon") 
	li_inscritos = ids_horarios.GETITEMNUMBEr(ll_pos, "inscritos")

	/********************************/
//	IF ll_cve_mat = 21834 AND ls_gpo = 'B' THEN 
//		ll_cve_mat = ll_cve_mat 
//	END IF 	

	/********************************/

	ldt_valida = DATE(ldt_fecha_inicio) 
	ld_fecha_fin = DATE(ldt_fecha_fin) 
	le_hora_fin = le_hora_final - 1

	// le_horas_dia = le_hora_final - le_hora_inicio 

	// Se hace ciclo sobre el rango de fechas 
	DO WHILE ldt_valida <= ld_fecha_fin 
		
		// Si el dia de la semana del horario  coincide con el dia de la fecha que se evalua
		IF (DAYNUMBER(ldt_valida) - 1) = le_cve_dia THEN  
		
			// Se generan los ID de las horas comprendidas en este dia 
			FOR le_hora = le_hora_inicio TO le_hora_fin 
				
				// Si encuentra el dia dentro del rango de fechas, se genera la clave y se inserta. 
//				ls_dato = STRING(le_hora) + STRING(DAY(DATE(ldt_valida))) + RIGHT(STRING(MONTH(DATE(ldt_valida)) + 100 ), 2) 
//				ll_id = LONG(ls_dato)   
				
				ls_dato = STRING(le_hora) + RIGHT(STRING(DAY(DATE(ldt_valida)) + 100 ), 2) + RIGHT(STRING(MONTH(DATE(ldt_valida)) + 100 ), 2) 
				ll_id = LONG(ls_dato)   
				
				le_dia_mes = LONG(RIGHT(STRING(DAY(DATE(ldt_valida)) + 100 ), 2) + RIGHT(STRING(MONTH(DATE(ldt_valida)) + 100 ), 2))
				
				ll_row = lds_fecha_hora.INSERTROW(0)  
				lds_fecha_hora.SETITEM(ll_row, "cve_mat", ll_cve_mat)
				lds_fecha_hora.SETITEM(ll_row, "gpo", ls_gpo)
				lds_fecha_hora.SETITEM(ll_row, "cve_dia", le_cve_dia)
				lds_fecha_hora.SETITEM(ll_row, "fechahora", ll_id)
				lds_fecha_hora.SETITEM(ll_row, "cve_salon", ls_cve_salon) 
				lds_fecha_hora.SETITEM(ll_row, "inscritos", li_inscritos)
				lds_fecha_hora.SETITEM(ll_row, "dia_mes", le_dia_mes)
				
				IF MOD(ll_row, 10000) = 0  THEN 
					lds_fecha_hora.UPDATE() 
					commit USING gtr_sce; 
					
					lds_fecha_hora.RESET() 
					lds_fecha_hora.SETTRANSOBJECT(gtr_sce) 
					
					GARBAGECOLLECT() 
					
				END IF 
	
//				INSERT INTO salones_asignacion(cve_mat, gpo, fechahora, cve_salon, inscritos)   
//				VALUES (:ll_cve_mat, :ls_gpo, :ll_id, :ls_cve_salon, :li_inscritos)
//				USING gtr_sce; 
//				IF gtr_sce.SQLCODE < 0 THEN 
//					MESSAGEBOX("Aviso", "Se produjo un error al insertar el ID de Fecha-Hora : ID " + STRING(ls_dato)) 
//				END IF 
				
				COMMIT USING gtr_sce; 
				
			NEXT 	
	
	
	
			// Acumula las horas y evalúa la siguiente fecha 	
			//le_horas_totales = le_horas_totales + le_horas_dia  
			
		END IF
		
		ldt_valida = RELATIVEDATE(ldt_valida, 1)
		
	LOOP  
	
NEXT 
		
lds_fecha_hora.UPDATE() 
commit USING gtr_sce; 		
	
		
//		// Al enciontrar el primer dia de la semana igual, se determina si es fecha está cubierta. 		
//		ls_busqueda = "cve_dia = " + STRING((le_cve_dia)) + " AND hora_inicio <= " + STRING(le_hora) + " AND hora_final >= " + STRING(le_hora) + & 
//							" AND fecha_inicio <= DATE('" + STRING(ldt_valida, "yyyy-mm-dd") + "') AND DATE('" + STRING(ldt_valida, "yyyy-mm-dd") + "') <= fecha_fin "  
//		
//		//'absag_datedebut = Date ( "' + string(dtt_debut, "yyyy-mm-dd") + '")'
//		
//		
//		le_row_enc = ids_horario_profesor.FIND(ls_busqueda, 0, ids_horario_profesor.ROWCOUNT() + 1) 
//		IF le_row_enc = 0 THEN  
//			is_error = "El horario comprendido entre " + STRING(le_hora_inicio) + " y " + STRING(le_hora_final) + " el día " + is_dia[le_cve_dia + 1] + " en la fecha " + STRING(ldt_valida, "dd/mm/yyyy") + " no se encuentra cubierto por ningún profesor. " 
//			RETURN -1 
//		END IF
//	
//		le_hora ++
	


RETURN 0 

	





//
//	DO 
//		
//		// Se verifica el dia de la semana
//		DO 
//			le_cve_dia_val = (DAYNUMBER(ldt_valida) -1)
//			IF le_cve_dia_val <> le_cve_dia THEN 
//				ldt_valida = RELATIVEDATE(ldt_valida, 1) 
//				IF ldt_valida > DATE(ldt_fecha_fin) THEN 
//					EXIT 
//				END IF	
//			END IF
//		LOOP WHILE le_cve_dia_val <> le_cve_dia AND ldt_valida <= DATE(ldt_fecha_fin)  
//		
//		IF ldt_valida > DATE(ldt_fecha_fin) THEN 
//			le_hora ++
//			CONTINUE 
//		END IF 
//
//
//
//
//RETURN  0 
//
//
//





//cve_mat
//gpo
//periodo
//anio 
//cve_dia
//hora_inicio
//hora_final
//fecha_inicio
//fecha_fin
//cve_salon




end function

public function integer of_asigna_salon (datastore ads_asigna_automatica_salon, integer ai_critcupoinsc, string as_descnivel, integer ai_i, integer ai_crit);STRING ls_sql, ls_grupo, ls_grupo_ant, ls_grupo_act 
LONG ll_cve_mat, ll_pos, ll_cve_mat_ant, ll_cve_mat_act, ll_pos_act, ll_ttl_gpo, ll_fecha_hora 
int li_tothor, li_i, li_asignados, li_cve_dia, li_hora_inicio, li_hora_final,li_res
int li_busco, li_salones_encontrados 
STRING ls_clave_salon, ls_error
datastore lds_salones_libres, lds_salon_libre
lds_salones_libres = CREATE DataStore
lds_salon_libre = CREATE DataStore
lds_salones_libres.DataObject = "d_salones_libres2"
lds_salon_libre.DataObject = "d_salon_libre"
lds_salones_libres.SetTransObject(gtr_sce)
lds_salon_libre.SetTransObject(gtr_sce)
//li_tothor = ads_asigna_automatica_salon.GetItemNumber(ai_i,"totalhorario")
li_i = 0
li_asignados = 0
//if ai_crit = 3 then	/*Ant Cambio FMC Jun2006*/
if ai_crit = 4 then		/*Nue Cambio FMC Jun2006*/

	ll_ttl_gpo = ads_asigna_automatica_salon.ROWCOUNT()

	FOR ll_pos = 1 TO ll_ttl_gpo 
		
		li_cve_dia = ads_asigna_automatica_salon.GetItemNumber(ll_pos,"horario_cve_dia")  
		ll_cve_mat = ads_asigna_automatica_salon.GetItemNumber(ll_pos,"horario_cve_mat") 
		ls_grupo = ads_asigna_automatica_salon.GetItemSTRING(ll_pos,"horario_gpo") 		
		ll_fecha_hora = 0
		
		ls_sql = " SELECT salon.cve_salon, salon.cupo_max " + & 
					" FROM salon " + & 
					" WHERE ( salon.bloqueado = 0 ) " + &    
					" AND salon.clase_aula LIKE ~~'SALON~~' " + &   
					" AND (salon.cupo_max = " + STRING(ai_critcupoinsc) + " OR " + STRING(ai_critcupoinsc) + " = 0) " + &     
					" AND ( salon.nivel = ~~'" + as_descnivel + "~~' OR ~~'" + as_descnivel + "~~' = ~~'C~~') " + &    
					" AND NOT EXISTS( SELECT *  " + &    
					" FROM salones_asignacion sa, salones_asignacion sb   " + &     
					" WHERE sa.cve_mat =  " + STRING(ll_cve_mat) + &     
					" AND sa.gpo =  ~~'" + ls_grupo + "~~' " + &    
					" AND sa.cve_dia =  " + STRING(li_cve_dia) + &    
					" AND sb.cve_salon = salon.cve_salon  " + &    
					" AND sa.fechahora = sb.fechahora) " 				
		
		li_res = lds_salones_libres.Retrieve(ie_anio,ie_periodo,ai_critcupoinsc,as_descnivel, li_cve_dia,li_hora_inicio,li_hora_final) 
		if li_res > 0 then
			
			ls_clave_salon = lds_salones_libres.GetItemString(1,"cve_salon") 
			
			ads_asigna_automatica_salon.SetItem(ll_pos,"horario_cve_salon", ls_clave_salon) 
			IF ads_asigna_automatica_salon.Update() < 0 THEN 
				ROLLBACK USING gtr_sce;
				MESSAGEBOX("Aviso", "Se produjo un error al actualizar el salon. " )
				RETURN -1 
			END IF 	
				
			
			// Se actualiza la tabla de asignación de salones. 
			UPDATE salones_asignacion 
			SET cve_salon = :ls_clave_salon
			WHERE cve_mat = :ll_cve_mat 
			AND gpo = :ls_grupo 
			AND cve_dia = :li_cve_dia
			USING gtr_sce;  
			IF gtr_sce.SQLCODE < 0 THEN 
				ls_error = gtr_sce.SQLERRTEXT 
				ROLLBACK USING gtr_sce;
				MESSAGEBOX("Aviso", "Se produjo un error al actualizar la tabla de asignación de salones: " + ls_error )
				RETURN -1 			
			END IF 
		
			Commit USING gtr_sce;
			li_asignados++
		end if
		ai_i++
	next
else
	li_busco = 0
	li_salones_encontrados = 0
	ll_ttl_gpo = ads_asigna_automatica_salon.ROWCOUNT()
	
	// Se hace recorrido por todos los grupos que se actualizan. 
	FOR ll_pos = 1 TO ll_ttl_gpo   
		
		ll_cve_mat = ads_asigna_automatica_salon.GetItemNumber(ll_pos,"horario_cve_mat") 
		ls_grupo = ads_asigna_automatica_salon.GetItemSTRING(ll_pos,"horario_gpo") 
		li_cve_dia = ads_asigna_automatica_salon.GetItemNumber(ai_i,"horario_cve_dia")
		li_hora_inicio = ads_asigna_automatica_salon.GetItemNumber(ai_i,"horario_hora_inicio")
		li_hora_final = ads_asigna_automatica_salon.GetItemNumber(ai_i,"horario_hora_final")	
	
		// Para la primera iteración se iguala la materia-grupo 
		IF ll_pos = 1 THEN 
			ll_cve_mat_ant = ll_cve_mat 
			ls_grupo_ant = ls_grupo 
		END IF 
		
		// Al cambiar el grupo que se procesa, se busca salón para el anterior 		
		IF ll_cve_mat = ll_cve_mat_ant AND ls_grupo = ls_grupo_ant AND ll_pos < ll_ttl_gpo THEN CONTINUE 
		
		ls_sql = " SELECT salon.cve_salon, salon.cupo_max " + & 
					" FROM salon " + & 
					" WHERE ( salon.bloqueado = 0 ) " + &    
					" AND salon.clase_aula LIKE ~~'SALON~~' " + &   
					" AND (salon.cupo_max = " + STRING(ai_critcupoinsc) + " OR " + STRING(ai_critcupoinsc) + " = 0) " + &     
					" AND ( salon.nivel = ~~'" + as_descnivel + "~~' OR ~~'" + as_descnivel + "~~' = ~~'C~~') " + &    
					" AND NOT EXISTS( SELECT * " + &    
											" FROM salones_asignacion sa, salones_asignacion sa2 " + &    
											" WHERE sa.cve_mat = " + STRING(ll_cve_mat_ant) +  &   
											" AND sa.gpo = ~~'" + ls_grupo_ant + "~~' " + &    
											" AND sa.fechahora = sa2.fechahora " + &    
											" AND sa2.cve_salon = salon.cve_salon ) "  
		
		lds_salones_libres.DataObject = "d_salones_libres2"
		lds_salones_libres.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'") 
		lds_salones_libres.SETTRANSOBJECT(gtr_sce) 
		li_res = lds_salones_libres.Retrieve(ie_anio,ie_periodo,ai_critcupoinsc,as_descnivel, 	li_cve_dia,li_hora_inicio,li_hora_final) 
		if li_res > 0 then
			
			// Se toma el primer salón que cumpla con las condiciones. 
			ls_clave_salon = lds_salones_libres.GetItemString(1,"cve_salon")
	
			FOR ll_pos_act = 1 TO ll_ttl_gpo 
				
				ll_cve_mat_act = ads_asigna_automatica_salon.GetItemNumber(ll_pos_act,"horario_cve_mat")  
				ls_grupo_act = ads_asigna_automatica_salon.GetItemSTRING(ll_pos_act,"horario_gpo") 
				
				IF ll_cve_mat_act = ll_cve_mat_ant AND ls_grupo_act = ls_grupo_ant THEN 
					ads_asigna_automatica_salon.SetItem(ll_pos_act,"horario_cve_salon", ls_clave_salon ) 
					li_asignados++
				END IF 	
				
			NEXT 
			
			// Se actualiza el horario 
			 IF ads_asigna_automatica_salon.Update() < 0 THEN 
				ROLLBACK USING gtr_sce; 
				MESSAGEBOX("Error", "Se produjo un error al actualizar la clave del salon en horarios. ") 
				RETURN -1 
			END IF 	
//			// SUBTITUIR por UPDATE EMBEBIDO 
//			UPDATE horario 
//			SET cve_salon = :ls_clave_salon 
//			WHERE cve_mat = :ll_cve_mat_ant 
//			AND gpo = :ls_grupo_ant  
//			AND periodo = :gi_periodo 
//			AND anio = :gi_anio 			
//			AND cve_dia = :li_cve_dia 
//			AND hora_inicio = :li_hora_inicio   
//			AND hora_final = :li_hora_final 
			
			// Se actualiza la tabla de asignación de salones. 
			UPDATE salones_asignacion 
			SET cve_salon = :ls_clave_salon
			WHERE cve_mat = :ll_cve_mat_ant 
			AND gpo = :ls_grupo_ant 
			USING gtr_sce;  
			IF gtr_sce.SQLCODE < 0 THEN 
				ls_error = gtr_sce.SQLERRTEXT 
				ROLLBACK USING gtr_sce;
				MESSAGEBOX("Aviso", "Se produjo un error al actualizar la tabla de asignación de salones: " + ls_error )
				RETURN -1 			
			END IF 
			Commit USING gtr_sce;
	
		end if
		
		// Se iguala la nueva materia-grupo
		ll_cve_mat_ant = ll_cve_mat 
		ls_grupo_ant = ls_grupo 		
		
	NEXT
	
end if
DESTROY lds_salones_libres
DESTROY lds_salon_libre 
GARBAGECOLLECT() 
return li_asignados




// GODIGO ORIGINAL // GODIGO ORIGINAL // GODIGO ORIGINAL // GODIGO ORIGINAL // GODIGO ORIGINAL // GODIGO ORIGINAL // GODIGO ORIGINAL // GODIGO ORIGINAL 
// GODIGO ORIGINAL // GODIGO ORIGINAL // GODIGO ORIGINAL // GODIGO ORIGINAL // GODIGO ORIGINAL // GODIGO ORIGINAL // GODIGO ORIGINAL // GODIGO ORIGINAL 
//
//
//int li_tothor, li_i, li_asignados, li_cve_dia, li_hora_inicio, li_hora_final,li_res
//int li_busco, li_salones_encontrados
//datastore lds_salones_libres, lds_salon_libre
//lds_salones_libres = CREATE DataStore
//lds_salon_libre = CREATE DataStore
//lds_salones_libres.DataObject = "d_salones_libres"
//lds_salon_libre.DataObject = "d_salon_libre"
//lds_salones_libres.SetTransObject(gtr_sce)
//lds_salon_libre.SetTransObject(gtr_sce)
//li_tothor = ads_asigna_automatica_salon.GetItemNumber(ai_i,"totalhorario")
//li_i = 0
//li_asignados = 0
////if ai_crit = 3 then	/*Ant Cambio FMC Jun2006*/
//if ai_crit = 4 then		/*Nue Cambio FMC Jun2006*/
//	for li_i = 1 to li_tothor
//		li_cve_dia = ads_asigna_automatica_salon.GetItemNumber(ai_i,"horario_cve_dia")
//		li_hora_inicio = ads_asigna_automatica_salon.GetItemNumber(ai_i,"horario_hora_inicio")
//		li_hora_final = ads_asigna_automatica_salon.GetItemNumber(ai_i,"horario_hora_final")
//		li_res = lds_salones_libres.Retrieve(gi_anio,gi_periodo,ai_critcupoinsc,as_descnivel, li_cve_dia,li_hora_inicio,li_hora_final) 
//		if li_res > 0 then
//			ads_asigna_automatica_salon.SetItem(ai_i,"horario_cve_salon", lds_salones_libres.GetItemString(1,"cve_salon")) 
//			ads_asigna_automatica_salon.Update()
//			Commit USING gtr_sce;
//			li_asignados++
//		end if
//		ai_i++
//	next
//else
//	li_busco = 0
//	li_salones_encontrados = 0
//	li_cve_dia = ads_asigna_automatica_salon.GetItemNumber(ai_i,"horario_cve_dia")
//	li_hora_inicio = ads_asigna_automatica_salon.GetItemNumber(ai_i,"horario_hora_inicio")
//	li_hora_final = ads_asigna_automatica_salon.GetItemNumber(ai_i,"horario_hora_final")
//	li_res = lds_salones_libres.Retrieve(gi_anio,gi_periodo,ai_critcupoinsc,as_descnivel, 	li_cve_dia,li_hora_inicio,li_hora_final) 
//	if li_res > 0 then
//		li_salones_encontrados = 1
//		li_busco = 1
//		DO WHILE li_salones_encontrados < li_tothor AND li_busco <= li_res 
//			li_cve_dia = ads_asigna_automatica_salon.GetItemNumber(ai_i + li_salones_encontrados ,"horario_cve_dia")
//			li_hora_inicio = ads_asigna_automatica_salon.GetItemNumber(ai_i + li_salones_encontrados ,"horario_hora_inicio")
//			li_hora_final = ads_asigna_automatica_salon.GetItemNumber(ai_i + li_salones_encontrados ,"horario_hora_final")
//			IF (lds_salon_libre.Retrieve(gi_anio,gi_periodo,li_hora_inicio, li_hora_final,li_cve_dia, lds_salones_libres.GetItemString(li_busco,"cve_salon")) = 0) THEN  
//				li_salones_encontrados ++
//			ELSE
//				li_salones_encontrados = 1
//				li_busco++
//			END IF 
//		LOOP 
//		if li_salones_encontrados = li_tothor then
//			for li_i = 1 to li_tothor
//				ads_asigna_automatica_salon.SetItem(ai_i,"horario_cve_salon",&
//					lds_salones_libres.GetItemString(li_busco,"cve_salon"))
//				ai_i++
//				li_asignados++
//			next
//			ads_asigna_automatica_salon.Update()
//			Commit USING gtr_sce;
//		end if
//	end if
//end if
//DESTROY lds_salones_libres
//DESTROY lds_salon_libre
//return li_asignados





end function

public function integer of_carga_horarios ();
STRING ls_sql 
LONG ll_num_horario

ls_sql = " SELECT h.cve_mat, h.anio, h.periodo, h.cve_dia,h.hora_inicio,h.hora_final, g.fecha_inicio, g.fecha_fin, h.gpo, h.cve_salon, g.inscritos " + & 
			" FROM horario h,  " + & 
			" 	 grupos g  " + & 
			" WHERE g.periodo = " + STRING(ie_periodo) + & 
			" AND g.anio =  " + STRING(ie_anio) + & 
			" AND g.forma_imparte = 1   " + & 
			" AND h.cve_mat = g.cve_mat " + & 
			" AND h.gpo = g.gpo  " + & 
			" AND h.periodo = g.periodo  " + & 
			" AND h.anio = g.anio " + & 
			" AND h.clase_aula = 0 " + &  
			"  AND (UPPER(h.cve_salon) NOT IN(~~'DISTANCIA~~', ~~'HIBRIDACOM~~', ~~'HIBRIDALAB~~', ~~'HIBRIDATALL~~') OR h.cve_salon IS NULL)  " + & 
			" UNION " + & 
			" SELECT h.cve_mat, h.anio, h.periodo, h.cve_dia,h.hora_inicio,h.hora_final, h.fecha_inicio, h.fecha_fin, h.gpo, h.cve_salon, g.inscritos " + & 
			" FROM horario_modular h,  " + & 
			" 	 grupos g " + & 
			" WHERE g.periodo = " + STRING(ie_periodo) + & 
			" AND g.anio =  " + STRING(ie_anio) + & 
			" AND g.forma_imparte = 2   " + & 
			" AND h.cve_mat = g.cve_mat " + & 
			" AND h.gpo = g.gpo  " + & 
			" AND h.periodo = g.periodo  " + & 
			" AND h.anio = g.anio  " + & 
			" AND EXISTS(SELECT * FROM horario h1 " + &  
						" WHERE h1.cve_mat = h.cve_mat " + &  
						" AND h1.gpo = h.gpo " + &  
						" AND h1.periodo = h.periodo " + &   
						" AND h1.anio = h.anio " + &  
						" AND h1.cve_dia = h.cve_dia " + &   
						" AND h1.clase_aula = 0 " + & 
						"  AND (UPPER(h.cve_salon) NOT IN(~~'DISTANCIA~~', ~~'HIBRIDACOM~~', ~~'HIBRIDALAB~~', ~~'HIBRIDATALL~~') OR h1.cve_salon IS NULL) ) " + & 
			" ORDER BY 1, 2, 3 "


//" AND (h.cve_salon is NULL OR UPPER(h.cve_salon) LIKE ~~'%HIBRIDASAL%~~' ) " + &  
//" AND (h1.cve_salon is NULL OR UPPER(h1.cve_salon) LIKE ~~'%HIBRIDASAL%~~') )  " + &  


ids_horarios = CREATE DATASTORE  
ids_horarios.DATAOBJECT = "dw_horario_asigna_salones" 
ids_horarios.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'") 
ids_horarios.SETTRANSOBJECT(gtr_sce)  
ll_num_horario = ids_horarios.RETRIEVE() 
IF ll_num_horario < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al generar los ID de Fecha-Hora para asignación.")
	RETURN -1 	
END IF 

RETURN 0 


end function

public function integer of_genera_salon_horario ();
LONG ll_pos 
LONG ll_ttl_reg
LONG ll_id , le_dia_mes

STRING ls_edificio 
INTEGER le_cve_dia, le_cupo
DATETIME ldt_fecha_inicio
DATETIME ldt_fecha_fin 
STRING ls_cve_salon, ls_nivel 
STRING ls_dato  
DATE ldt_valida, ld_fecha_fin 
INTEGER le_hora, le_cve_dia_val, le_hora_fin 
LONG ll_row
STRING ls_query
DATASTORE lds_fecha_hora_sal_update 

// Se recuperan los salones 
//ls_query = " SELECT edificio = LEFT(cve_salon, 1), cve_salon, cupo_max, dia = 0, hora = 0, fechahora = 0, estatus = ~~'~~', nivel = substring(cve_salon,2,1) " + & 
//				" FROM salon " + &  
//				" WHERE clase_aula = ~~'SALON~~' "  
				
ls_query = " SELECT slns.edificio, slns.cve_salon, cupo_max = ROUND((slns.cupo_max * (salones_edificio_conf.porcentaje_ocupa/100.00)), 0), slns.dia, slns.hora, slns.nivel, slns.dia_mes, slns.fechahora, slns.estatus  FROM " + & 
				" ( SELECT edificio = LEFT(cve_salon, 1), cve_salon, cupo_max, dia = 0, hora = 0, dia_mes = 0, fechahora = 0, estatus = ~~'~~', nivel = substring(cve_salon,2,1) " + & 
				"   FROM salon " + & 
				"  WHERE clase_aula = ~~'SALON~~' AND bloqueado = 0 AND cupo_max > 0) slns, salones_edificio_conf  " + &  
				" WHERE slns.edificio = salones_edificio_conf.edificio  " + & 
				" AND slns.nivel = salones_edificio_conf.nivel " 
				
ids_salones_disp_especial = CREATE DATASTORE 
ids_salones_disp_especial.DATAOBJECT = "dw_salones_disponibilidad"
ids_salones_disp_especial.MODIFY("Datawindow.Table.Select = '" + ls_query + "'") 
ids_salones_disp_especial.SETTRANSOBJECT(gtr_sce)  
ll_ttl_reg = ids_salones_disp_especial.RETRIEVE() 

DELETE FROM salones_disponibilidad USING gtr_sce; 
COMMIT USING gtr_sce; 
IF gtr_sce.SQLCODE < 0 THEN  
	MESSAGEBOX("Error", "Se produjo un error al borrar la disponibilidad de salones: " + gtr_sce.SQLERRTEXT)
	RETURN -1 
END IF 	


// Se recuperan las fechas de inicio y fin del periodo 
SELECT fecha 
INTO :ldt_fecha_inicio
FROM calendario 
WHERE periodo = :ie_periodo 
AND anio = :ie_anio 
AND cve_evento = 1 
USING gtr_sce; 
IF gtr_sce.SQLCODE < 0 THEN  
	MESSAGEBOX("Error", "Se produjo un error al recuperar la fecha de inicio del periodo: " + gtr_sce.SQLERRTEXT)
	RETURN -1 
END IF 	

SELECT fecha 
INTO :ldt_fecha_fin 
FROM calendario 
WHERE periodo = :ie_periodo 
AND anio = :ie_anio 
AND cve_evento = 2
USING gtr_sce; 
IF gtr_sce.SQLCODE < 0 THEN  
	MESSAGEBOX("Error", "Se produjo un error al recuperar la fecha de fin del periodo: " + gtr_sce.SQLERRTEXT) 
	RETURN -1 
END IF 	



lds_fecha_hora_sal_update = CREATE DATASTORE 
lds_fecha_hora_sal_update.DATAOBJECT = "dw_salones_disponibilidad" 
lds_fecha_hora_sal_update.SETTRANSOBJECT(gtr_sce) 


// Se hace ciclo por cada salón 
FOR ll_pos = 1 TO ll_ttl_reg 

	ls_edificio = ids_salones_disp_especial.GETITEMSTRING(ll_pos, "edificio")
	ls_cve_salon = ids_salones_disp_especial.GETITEMSTRING(ll_pos, "cve_salon")
	le_cupo =  ids_salones_disp_especial.GETITEMNUMBER(ll_pos, "cupo") 	 
	ls_nivel = ids_salones_disp_especial.GETITEMSTRING(ll_pos, "nivel") 	 
	// Se asigna la fecha inicial 
	ldt_valida = DATE(ldt_fecha_inicio) 

	// Se hace ciclo sobre el rango de fechas 
	DO WHILE ldt_valida <= DATE(ldt_fecha_fin) 
		
		// Si el dia de la semana del horario  coincide con el dia de la fecha que se evalua
		le_cve_dia = (DAYNUMBER(ldt_valida) - 1)
		
		// Se generan los ID de las horas comprendidas en este dia 
		FOR le_hora = 7 TO 21 
			
			// Si encuentra el dia dentro del rango de fechas, se genera la clave y se inserta. 
//			ls_dato = STRING(le_hora) + STRING(DAY(DATE(ldt_valida))) + RIGHT(STRING(MONTH(DATE(ldt_valida)) + 100 ), 2) 
//			ll_id = LONG(ls_dato)   
			
			ls_dato = STRING(le_hora) + RIGHT(STRING(DAY(DATE(ldt_valida)) + 100 ), 2) + RIGHT(STRING(MONTH(DATE(ldt_valida)) + 100 ), 2) 
			ll_id = LONG(ls_dato)
			
			le_dia_mes = LONG(RIGHT(STRING(DAY(DATE(ldt_valida)) + 100 ), 2) + RIGHT(STRING(MONTH(DATE(ldt_valida)) + 100 ), 2))
			
			ll_row = lds_fecha_hora_sal_update.INSERTROW(0)  
			lds_fecha_hora_sal_update.SETITEM(ll_row, "edificio", ls_edificio)
			lds_fecha_hora_sal_update.SETITEM(ll_row, "cve_salon", ls_cve_salon)
			lds_fecha_hora_sal_update.SETITEM(ll_row, "nivel", ls_nivel)
			lds_fecha_hora_sal_update.SETITEM(ll_row, "cupo", le_cupo)
			lds_fecha_hora_sal_update.SETITEM(ll_row, "cve_dia", le_cve_dia)
			lds_fecha_hora_sal_update.SETITEM(ll_row, "hora", le_hora)
			lds_fecha_hora_sal_update.SETITEM(ll_row, "dia_mes", le_dia_mes)
			lds_fecha_hora_sal_update.SETITEM(ll_row, "fechahora", ll_id)
//			lds_fecha_hora_sal_update.SETITEM(ll_row, "estatus", '')
			
			// Se actualiza cada 10,000 registros.
			IF MOD(ll_row, 10000) = 0  THEN 
				
				lds_fecha_hora_sal_update.UPDATE() 
				commit USING gtr_sce; 
				
				lds_fecha_hora_sal_update.RESET() 
				lds_fecha_hora_sal_update.SETTRANSOBJECT(gtr_sce) 
				
				GARBAGECOLLECT() 
				
			END IF 

			//COMMIT USING gtr_sce; 
			
		NEXT 	
		
		ldt_valida = RELATIVEDATE(ldt_valida, 1)
		
	LOOP  
	
NEXT 
		
lds_fecha_hora_sal_update.UPDATE() 

commit USING gtr_sce; 		

MESSAGEBOX("", "termino")
	
RETURN 0






	
//edificio 
//cve_salon 
//cupo 
//cve_dia tipo_dia 
//hora tipo_hora 
//fechahora 
//estatus
//
//le_cupo
//	
//STRING ls_edificio 
//INTEGER le_cve_dia
//DATETIME ldt_fecha_inicio
//DATETIME ldt_fecha_fin 
//STRING ls_cve_salon 	
//le_hora 	

//	ldt_valida = DATE(ldt_fecha_inicio) 
//	ld_fecha_fin = DATE(ldt_fecha_fin) 
//	le_hora_fin = le_hora_final - 1

	// le_horas_dia = le_hora_final - le_hora_inicio 
end function

public function integer of_carga_asig_especial ();
INTEGER le_num_reg,  le_row_ins
LONG ll_pos 
STRING ls_edificio 
STRING ls_nivel 
INTEGER le_porcentaje_ocupa 
INTEGER le_tiempo_sanitizacion 
INTEGER le_tiempo_bloque 
INTEGER le_hora_inicio, le_hora_ins 
STRING ls_comodin 
INTEGER le_bloque, le_hora_final  

DATASTORE lds_salones_edificio_conf 

ids_salones_edificio_conf = CREATE DATASTORE 
ids_salones_edificio_conf.DATAOBJECT = "dw_salones_edificio_conf"  

lds_salones_edificio_conf = CREATE DATASTORE 
lds_salones_edificio_conf.DATAOBJECT = "dw_salones_edificio_conf"  
lds_salones_edificio_conf.SETTRANSOBJECT(gtr_sce) 
le_num_reg = lds_salones_edificio_conf.RETRIEVE()  
IF le_num_reg < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar la configuración para asignación especial.") 
	RETURN -1 
END IF 

ie_bloque_max = 0

// Se hace ciclo para expandir la configuración de asignación. 
FOR ll_pos = 1 TO le_num_reg 

	ls_edificio = lds_salones_edificio_conf.GETITEMSTRING(ll_pos, "edificio") 
	ls_nivel = lds_salones_edificio_conf.GETITEMSTRING(ll_pos, "nivel") 
	le_porcentaje_ocupa = lds_salones_edificio_conf.GETITEMNUMBER(ll_pos, "porcentaje_ocupa") 
	le_tiempo_sanitizacion = lds_salones_edificio_conf.GETITEMNUMBER(ll_pos, "tiempo_sanitizacion")  
	le_tiempo_bloque = lds_salones_edificio_conf.GETITEMNUMBER(ll_pos, "tiempo_bloque") 
	le_hora_inicio = lds_salones_edificio_conf.GETITEMNUMBER(ll_pos, "hora_inicio") 
	ls_comodin = lds_salones_edificio_conf.GETITEMSTRING(ll_pos, "comodin")  
	le_bloque = lds_salones_edificio_conf.GETITEMNUMBER(ll_pos, "bloque") 

	// Se almacena el bloque más alto 
	IF le_bloque > ie_bloque_max THEN ie_bloque_max = le_bloque
	
	le_hora_final = (le_hora_inicio + le_tiempo_bloque) - 1 
	IF le_hora_final = le_hora_inicio THEN le_hora_final = le_hora_inicio + 1 

	FOR le_hora_ins = le_hora_inicio TO le_hora_final 

		le_row_ins = ids_salones_edificio_conf.INSERTROW(0) 
		ids_salones_edificio_conf.SETITEM(le_row_ins, "edificio", ls_edificio) 
		ids_salones_edificio_conf.SETITEM(le_row_ins, "nivel", ls_nivel) 
		ids_salones_edificio_conf.SETITEM(le_row_ins, "porcentaje_ocupa", le_porcentaje_ocupa) 
		ids_salones_edificio_conf.SETITEM(le_row_ins, "tiempo_sanitizacion", le_tiempo_sanitizacion) 
		ids_salones_edificio_conf.SETITEM(le_row_ins, "tiempo_bloque", le_tiempo_bloque)  
		// Se inserta la expansión de horas 
		ids_salones_edificio_conf.SETITEM(le_row_ins, "hora_inicio", le_hora_ins)  
		ids_salones_edificio_conf.SETITEM(le_row_ins, "comodin", ls_comodin)  
		ids_salones_edificio_conf.SETITEM(le_row_ins, "bloque", le_bloque)  

	NEXT 

NEXT 

//recupera los salones con el cupo ajustado  
//ids_salones_disp_especial 

of_genera_cadenas_filtrado()

RETURN 0 





end function

public function integer of_genera_cadenas_filtrado ();
LONG ll_pos, ll_ttl_rgs, le_row 
INTEGER le_hora_inicio, le_hora_fin, le_hora, le_uid_bloque 
STRING ls_edificio, ls_filtro 
INTEGER le_bloque, le_id_bloque_ant, le_id_bloque
INTEGER le_horas_bloque, le_hora_max, le_horas_bloque_ant, le_hora_inicio_ant, le_bloque_max

ids_cadenas_filtrado = CREATE DATASTORE  
ids_cadenas_filtrado.DATAOBJECT = "dw_cadenas_filtrado_esp"  

ll_ttl_rgs = ids_salones_edificio_conf.ROWCOUNT()  

// Se hace ciclo por cada bloque de salones
FOR le_bloque = 1 TO ll_ttl_rgs 

	le_hora_inicio = ids_salones_edificio_conf.getitemnumber(le_bloque, "hora_inicio")  
	le_horas_bloque = ids_salones_edificio_conf.getitemnumber(le_bloque, "tiempo_bloque")  
	le_id_bloque = ids_salones_edificio_conf.GETITEMNUMBER(le_bloque, "bloque")  
	
	// Si se trata de la primera iteración, se asignan valores 
	IF le_bloque = 1 THEN 
		le_id_bloque_ant = le_id_bloque 
		le_horas_bloque_ant = le_horas_bloque 
		le_hora_inicio_ant = le_hora_inicio
	END IF 	
	
	// Si hay un cambio de bloque, se genera la cadena de filtrado 	
	IF le_id_bloque_ant <> le_id_bloque OR le_bloque = ll_ttl_rgs THEN 
		
		le_hora_fin = le_hora_inicio_ant 
		
		le_hora_fin = le_hora_inicio_ant 
		DO WHILE le_horas_bloque_ant > 0 
			le_hora_fin ++ 
			le_horas_bloque_ant -- 
		LOOP  
			
		ls_filtro = " horario_hora_inicio >= " + STRING(le_hora_inicio_ant) + " AND horario_hora_inicio <= " + STRING(le_hora_fin) 
		le_row = ids_cadenas_filtrado.INSERTROW(0) 
		ids_cadenas_filtrado.SETITEM(le_row, "bloque", le_id_bloque_ant)
		ids_cadenas_filtrado.SETITEM(le_row, "cadena_filtro", ls_filtro)
		
		// Se asignan valores a variables con valore anteriores 
		le_id_bloque_ant = le_id_bloque 
		le_horas_bloque_ant = le_horas_bloque 
		le_hora_inicio_ant = le_hora_inicio		
		
		
	END IF 
		

NEXT 


RETURN 1 




//		le_row_ins = ids_salones_edificio_conf.INSERTROW(0) 
//		ids_salones_edificio_conf.SETITEM(le_row_ins, "edificio", ls_edificio) 
//		ids_salones_edificio_conf.SETITEM(le_row_ins, "nivel", ls_nivel) 
//		ids_salones_edificio_conf.SETITEM(le_row_ins, "porcentaje_ocupa", le_porcentaje_ocupa) 
//		ids_salones_edificio_conf.SETITEM(le_row_ins, "tiempo_sanitizacion", le_tiempo_sanitizacion) 
//		ids_salones_edificio_conf.SETITEM(le_row_ins, "tiempo_bloque", le_tiempo_bloque)  
//		// Se inserta la expansión de horas 
//		ids_salones_edificio_conf.SETITEM(le_row_ins, "hora_inicio", le_hora_ins)  
//		ids_salones_edificio_conf.SETITEM(le_row_ins, "comodin", ls_comodin)  
//		ids_salones_edificio_conf.SETITEM(le_row_ins, "bloque", le_bloque)  


//edificio	
//nivel	
//porcentaje_ocupa	
//tiempo_sanitizacion	
//tiempo_bloque	
//hora_inicio	
//comodin	
//bloque

end function

public function integer of_asigna_salon_esp (datastore ads_asigna_automatica_salon, integer ai_critcupoinsc, string as_descnivel, integer ai_i, integer ai_crit, integer ai_vuelta);STRING ls_sql, ls_grupo, ls_grupo_ant, ls_grupo_act 
LONG ll_cve_mat, ll_pos, ll_cve_mat_ant, ll_cve_mat_act, ll_pos_act, ll_ttl_gpo, ll_fecha_hora 
int li_tothor, li_i, li_asignados, li_cve_dia, li_hora_inicio, li_hora_final,li_res
int li_busco, li_salones_encontrados, le_ultima_hora, le_pos_salon, le_horas_sanitizacion, le_cupo_max, le_inscritos  
LONG ll_salones_no_libres
STRING ls_clave_salon, ls_error, ls_materia_grupo, ls_query_san, ls_filtro_nivel 
LONG ll_ttl_san, ll_pos_san
INTEGER le_ttl_dias, le_pos_dia 
INTEGER le_hora_max, le_dia_san, le_inscritos_ant
DATASTORE lds_horas_sanitizacion 
lds_horas_sanitizacion = CREATE DATASTORE 

//ads_asigna_automatica_salon.SETSORT("grupos_inscritos D") 
//ads_asigna_automatica_salon.SORT()
			
			
datastore lds_salones_libres, lds_salon_libre
lds_salones_libres = CREATE DataStore
lds_salon_libre = CREATE DataStore
lds_salones_libres.DataObject = "d_salones_libres2"
lds_salon_libre.DataObject = "d_salon_libre"
lds_salones_libres.SetTransObject(gtr_sce)
lds_salon_libre.SetTransObject(gtr_sce)

//li_tothor = ads_asigna_automatica_salon.GetItemNumber(ai_i,"totalhorario")
li_i = 0
li_asignados = 0
//if ai_crit = 3 then	/*Ant Cambio FMC Jun2006*/
if ai_crit = 4 then		/*Nue Cambio FMC Jun2006*/
	
	/*BORRAR BORRAR BORRAR BORRAR BORRAR BORRAR BORRAR BORRAR BORRAR BORRAR BORRAR */
	//RETURN 0
	/*BORRAR BORRAR BORRAR BORRAR BORRAR BORRAR BORRAR BORRAR BORRAR BORRAR BORRAR */

	ll_ttl_gpo = ads_asigna_automatica_salon.ROWCOUNT()

	FOR ll_pos = 1 TO ll_ttl_gpo 
		
		li_cve_dia = ads_asigna_automatica_salon.GetItemNumber(ll_pos,"horario_cve_dia")  
		ll_cve_mat = ads_asigna_automatica_salon.GetItemNumber(ll_pos,"horario_cve_mat") 
		ls_grupo = ads_asigna_automatica_salon.GetItemSTRING(ll_pos,"horario_gpo") 		
		le_inscritos = ads_asigna_automatica_salon.GetItemNumber(ll_pos,"grupos_inscritos")	
		ll_fecha_hora = 0
		
//		IF ll_cve_mat = 9322 AND ls_grupo = 'A' THEN 
//			ll_cve_mat = ll_cve_mat
//		END IF 	
		
		
		// Se verifica el número de vuelta 
		//IF ai_vuelta = 1 THEN ai_vuelta = ai_vuelta
		
		// Se recuperan los salones con el cupo corrrespondiente		
		ls_sql = " SELECT DISTINCT sd.cve_salon, sd.cupo " + &  
					" FROM salones_disponibilidad sd, salon s " + &   
					" WHERE sd.cve_salon = s.cve_salon " + &  
					" AND sd.cupo >= " + STRING(le_inscritos) + & 
					" AND NOT EXISTS(  SELECT *  FROM salones_asignacion sa, salones_disponibilidad sd2  " + & 
											" WHERE sa.cve_mat = " + STRING(ll_cve_mat) + " AND sa.gpo =~~'" + ls_grupo + "~~'  "  + &  
											" AND sa.fechahora = sd2.fechahora "  + &   
											" AND sd2.cve_salon = sd.cve_salon "  + &  
											" AND sd2.estatus IS NOT NULL ) ORDER BY 2 DESC "  
											
											
		//" AND (sd.cupo >= " + STRING(le_inscritos) + " OR " + STRING(ai_critcupoinsc) + " = 0) " + &   		
		//" AND (sd.cupo >= " + STRING(ai_critcupoinsc) + " OR " + STRING(ai_critcupoinsc) + " = 0) " + &   
		
		lds_salones_libres.DataObject = "d_salones_libres2"
		lds_salones_libres.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'") 
		lds_salones_libres.SETTRANSOBJECT(gtr_sce) 		
		li_res = lds_salones_libres.Retrieve(ie_anio,ie_periodo,ai_critcupoinsc,as_descnivel, li_cve_dia,li_hora_inicio,li_hora_final) 
		if li_res > 0 then
			
			ls_clave_salon = lds_salones_libres.GetItemString(1,"cve_salon") 
			
			/***************/
			IF ls_clave_salon = 'N1ASV' THEN 
				ls_clave_salon = ls_clave_salon 
			END IF 	
			/***************/			
			
			ads_asigna_automatica_salon.SetItem(ll_pos,"horario_cve_salon", ls_clave_salon) 
			IF ads_asigna_automatica_salon.Update() < 0 THEN 
				ROLLBACK USING gtr_sce;
				MESSAGEBOX("Aviso", "Se produjo un error al actualizar el salon. " )
				RETURN -1 
			END IF 	
				
			
			// Se actualiza la tabla de asignación de salones. 
			UPDATE salones_asignacion 
			SET cve_salon = :ls_clave_salon
			WHERE cve_mat = :ll_cve_mat 
			AND gpo = :ls_grupo 
			AND cve_dia = :li_cve_dia
			USING gtr_sce;  
			IF gtr_sce.SQLCODE < 0 THEN 
				ls_error = gtr_sce.SQLERRTEXT 
				ROLLBACK USING gtr_sce;
				MESSAGEBOX("Aviso", "Se produjo un error al actualizar la tabla de asignación de salones: " + ls_error )
				RETURN -1 			
			END IF 
			
			ls_materia_grupo = STRING(ll_cve_mat) + ls_grupo  
			
			// Se actualiza la disponibilidad de salones 
			UPDATE salones_disponibilidad 
			SET salones_disponibilidad.estatus = :ls_materia_grupo 
			WHERE EXISTS (SELECT * FROM salones_asignacion sa 
								WHERE sa.cve_mat = :ll_cve_mat AND sa.gpo = :ls_grupo  
								AND salones_disponibilidad.cve_salon = :ls_clave_salon  
								AND sa.fechahora = salones_disponibilidad.fechahora)  			
			USING gtr_sce;  
			IF gtr_sce.SQLCODE < 0 THEN 
				ls_error = gtr_sce.SQLERRTEXT 
				ROLLBACK USING gtr_sce;
				MESSAGEBOX("Aviso", "Se produjo un error al actualizar la tabla de disponibilidad de salones: " + ls_error )
				RETURN -1 			
			END IF 			
		
			Commit USING gtr_sce;
			li_asignados++
		end if
		ai_i++
	next
else
	li_busco = 0
	li_salones_encontrados = 0
	ll_ttl_gpo = ads_asigna_automatica_salon.ROWCOUNT()
	
	// Se hace recorrido por todos los grupos que se actualizan. 
	FOR ll_pos = 1 TO ll_ttl_gpo   
		
		ll_cve_mat = ads_asigna_automatica_salon.GetItemNumber(ll_pos,"horario_cve_mat") 
		ls_grupo = ads_asigna_automatica_salon.GetItemSTRING(ll_pos,"horario_gpo") 
		li_cve_dia = ads_asigna_automatica_salon.GetItemNumber(ll_pos,"horario_cve_dia")
		li_hora_inicio = ads_asigna_automatica_salon.GetItemNumber(ll_pos,"horario_hora_inicio")
		li_hora_final = ads_asigna_automatica_salon.GetItemNumber(ll_pos,"horario_hora_final")	
		le_inscritos = ads_asigna_automatica_salon.GetItemNumber(ll_pos,"grupos_inscritos")	
	
		// Para la primera iteración se iguala la materia-grupo 
		IF ll_pos = 1 THEN 
			ll_cve_mat_ant = ll_cve_mat 
			ls_grupo_ant = ls_grupo 
			le_inscritos_ant = le_inscritos
		END IF 
		
		// Al cambiar el grupo que se procesa, se busca salón para el anterior 		
		IF ll_cve_mat = ll_cve_mat_ant AND ls_grupo = ls_grupo_ant AND ll_pos < ll_ttl_gpo THEN CONTINUE 
		
		IF ll_cve_mat_ant = 9322 AND ls_grupo_ant = 'A' THEN 
			ll_cve_mat_ant = ll_cve_mat_ant
		END IF 			
		
		
		IF as_descnivel = 'L' THEN 
			//ls_filtro_nivel = " AND ( s.nivel = ~~'L~~' OR s.nivel = ~~'T~~' ) "
			ls_filtro_nivel = " AND ( ~~'L~~' = ~~'L~~') "
		ELSE 
			//ls_filtro_nivel = " AND ( s.nivel = ~~'" + as_descnivel + "~~' OR ~~'" + as_descnivel + "~~' = ~~'C~~') "
			ls_filtro_nivel = " AND ( ~~'L~~' = ~~'L~~') "
		END IF 	
		
		
		ls_sql = " SELECT DISTINCT sd.cve_salon, sd.cupo " + &  
					" FROM salones_disponibilidad sd, salon s " + &   
					" WHERE sd.cve_salon = s.cve_salon " + &  
					" AND sd.cupo >= " + STRING(le_inscritos) + & 
					ls_filtro_nivel + &   
					"  AND NOT EXISTS( SELECT *  FROM salones_asignacion sa, salones_disponibilidad sd2  " + & 
											" WHERE sa.cve_mat = " + STRING(ll_cve_mat_ant) + " AND sa.gpo = ~~'" + ls_grupo_ant + "~~'  "  + &  
											" AND sa.fechahora = sd2.fechahora "  + &   
											" AND sd2.cve_salon = sd.cve_salon "  + &  
											" AND sd2.estatus IS NOT NULL ) ORDER BY 2 DESC "

					//*** Se elimina esta condición para filtrat por rango de cupo ***
					//" AND ((sd.cupo >= " + STRING(il_cupo_minimo) + " AND sd.cupo <= " + STRING(il_cupo_maximo)   + ") OR " + STRING(ai_critcupoinsc) + " = 0) " + &   
					//*** Se elimina esta condición para filtrat por rango de cupo *** 
					
					//" AND (sd.cupo = " + STRING(ai_critcupoinsc) + " OR " + STRING(ai_critcupoinsc) + " = 0) " + &   
					//" AND ((sd.cupo >= " + STRING(il_cupo_minimo) + " AND sd.cupo <= " + STRING(il_cupo_maximo)   + ") OR " + STRING(ai_critcupoinsc) + " = 0) " + &   
					
					
					
//					" AND NOT EXISTS( SELECT *  FROM salones_asignacion sa, salones_asignacion sa2 " + &   
//									" WHERE sa.cve_mat = " + STRING(ll_cve_mat_ant)  + " AND sa.gpo =  ~~'" + ls_grupo_ant + "~~'  " + &   
//									" AND sa.fechahora = sa2.fechahora " + &   
//									" AND sa2.cve_salon = s.cve_salon ) "  
		
		lds_salones_libres.DataObject = "d_salones_libres2"
		lds_salones_libres.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'") 
		lds_salones_libres.SETTRANSOBJECT(gtr_sce) 
		li_res = lds_salones_libres.Retrieve(ie_anio,ie_periodo,ai_critcupoinsc,as_descnivel, 	li_cve_dia,li_hora_inicio,li_hora_final) 
		if li_res > 0 then 
			
			FOR le_pos_salon = 1 TO li_res 
			
				// Se toma el primer salón que cumpla con las condiciones. 
				ls_clave_salon = lds_salones_libres.GetItemString(le_pos_salon, "cve_salon")
				le_cupo_max = lds_salones_libres.GETITEMNUMBER(le_pos_salon, "cupo")
				//IF le_cupo_max = 0 THEN le_cupo_max = le_cupo_max

				/***************/
				IF ls_clave_salon = 'N1ASV' THEN 
					ls_clave_salon = ls_clave_salon 
				END IF 	
				/***************/

				// Se verifica que no se "desborde el salón" 
				IF le_cupo_max < le_inscritos_ant THEN 
					ls_clave_salon = ""
					CONTINUE   					
				END IF 					
				
				// Si existen salones se verifica que esten disponibles en las horas y dias requeridos 
				SELECT COUNT(*)  
				INTO :ll_salones_no_libres 
				FROM salones_asignacion sa 
				WHERE sa.cve_mat = :ll_cve_mat_ant AND sa.gpo = :ls_grupo_ant   
				AND NOT EXISTS (SELECT * FROM salones_disponibilidad sd  
								WHERE cve_salon = :ls_clave_salon 
								AND sd.fechahora = sa.fechahora 
								AND sd.estatus IS NULL)			
				USING gtr_sce; 
				// Si no ecuentra todas sus horas cubiertas busca el siguiente salón. 
				IF ll_salones_no_libres > 0 THEN 
					ls_clave_salon = ""
					CONTINUE   
				END IF	
				
			
				
/**/

				// Se genera query para ciclo de actualización de tiempo de sanitización. 
				ls_query_san = " SELECT MAX(sd.hora), sd.cve_dia, sc.tiempo_sanitizacion " + &  
									" FROM salones_disponibilidad sd, salones_asignacion sa, salones_edificio_conf sc " + &      
									" WHERE sd.cve_salon = ~~'" + ls_clave_salon + "~~'" + &    
									" AND sa.cve_mat = " + STRING(ll_cve_mat_ant) + " AND sa.gpo = ~~'" + ls_grupo_ant + "~~'" + &      
									" AND sa.fechahora = sd.fechahora " + &   
									" AND sd.edificio = sc.edificio " + &   
									" AND sd.nivel = sc.nivel " + &   
									" GROUP BY sd.cve_dia, sc.tiempo_sanitizacion " 
	
				lds_horas_sanitizacion.DATAOBJECT = "dw_hora_dia_san"  
				lds_horas_sanitizacion.MODIFY("Datawindow.Table.Select = '" + ls_query_san + "'") 
				lds_horas_sanitizacion.SETTRANSOBJECT(gtr_sce) 
				le_ttl_dias = lds_horas_sanitizacion.RETRIEVE() 
				
				// Se "Apartan las horas de sanitización"
				FOR	le_pos_dia = 1 TO le_ttl_dias
				
					le_hora_max = lds_horas_sanitizacion.GETITEMNUMBER(le_pos_dia, "hora")
					le_dia_san = lds_horas_sanitizacion.GETITEMNUMBER(le_pos_dia, "dia")
					ll_ttl_san =	lds_horas_sanitizacion.GETITEMNUMBER(le_pos_dia, "tiempo_san") 
				
					FOR ll_pos_san = 1 TO ll_ttl_san 
				
						SELECT COUNT(*) 
						INTO :le_horas_sanitizacion 
						FROM salones_disponibilidad
						WHERE salones_disponibilidad.cve_salon = :ls_clave_salon  
						AND salones_disponibilidad.hora = (:le_hora_max + :ll_pos_san) 
						AND salones_disponibilidad.cve_dia = :le_dia_san 
						AND salones_disponibilidad.estatus IS NOT NULL
						AND EXISTS (SELECT * FROM salones_asignacion sa    
										WHERE sa.cve_mat = :ll_cve_mat_ant AND sa.gpo = :ls_grupo_ant  
										AND sa.dia_mes = salones_disponibilidad.dia_mes ) 	
						USING gtr_sce; 									
						IF gtr_sce.SQLCODE < 0 THEN 
							ls_error = gtr_sce.SQLERRTEXT 
							ROLLBACK USING gtr_sce;
							MESSAGEBOX("Aviso", "Se produjo un error al actualizar la tabla de disponibilidad de salones: " + ls_error )
							RETURN -1 			
						END IF 				
						
						IF le_horas_sanitizacion > 0 THEN EXIT
					
					NEXT
					
					IF le_horas_sanitizacion > 0 THEN EXIT
					
				NEXT 
/***/

				IF le_horas_sanitizacion > 0 THEN 
					ls_clave_salon = ""
					CONTINUE   
				END IF	
				
				// Si pasa las validaciones anteriores, se asigna el salón. 
				EXIT 
				
			NEXT
	
			// Si el salón pasa todas las validaciones, se asigna al grupos 
			IF ls_clave_salon <>  "" THEN 

				FOR ll_pos_act = 1 TO ll_ttl_gpo 
					
					ll_cve_mat_act = ads_asigna_automatica_salon.GetItemNumber(ll_pos_act,"horario_cve_mat")  
					ls_grupo_act = ads_asigna_automatica_salon.GetItemSTRING(ll_pos_act,"horario_gpo") 
					
					IF ll_cve_mat_act = ll_cve_mat_ant AND ls_grupo_act = ls_grupo_ant THEN 
						ads_asigna_automatica_salon.SetItem(ll_pos_act,"horario_cve_salon", ls_clave_salon ) 
						li_asignados++
					END IF 	
					
				NEXT 
				
			//END IF 	
			
				// Se actualiza el horario 
				 IF ads_asigna_automatica_salon.Update() < 0 THEN 
					ROLLBACK USING gtr_sce; 
					MESSAGEBOX("Error", "Se produjo un error al actualizar la clave del salon en horarios. ") 
					RETURN -1 
				END IF 	
			
				// Se actualiza la tabla de asignación de salones. 
				UPDATE salones_asignacion 
				SET cve_salon = :ls_clave_salon
				WHERE cve_mat = :ll_cve_mat_ant 
				AND gpo = :ls_grupo_ant 
				USING gtr_sce;  
				IF gtr_sce.SQLCODE < 0 THEN 
					ls_error = gtr_sce.SQLERRTEXT 
					ROLLBACK USING gtr_sce;
					MESSAGEBOX("Aviso", "Se produjo un error al actualizar la tabla de asignación de salones: " + ls_error )
					RETURN -1 			
				END IF 
			
			
				ls_materia_grupo = STRING(ll_cve_mat_ant) + ls_grupo_ant  
			
				// Se actualiza la disponibilidad de salones 
				UPDATE salones_disponibilidad 
				SET salones_disponibilidad.estatus = :ls_materia_grupo 
				WHERE EXISTS (SELECT * FROM salones_asignacion sa 
									WHERE sa.cve_mat = :ll_cve_mat_ant AND sa.gpo = :ls_grupo_ant  
									AND salones_disponibilidad.cve_salon = :ls_clave_salon  
									AND sa.fechahora = salones_disponibilidad.fechahora)  			
				USING gtr_sce;  
				IF gtr_sce.SQLCODE < 0 THEN 
					ls_error = gtr_sce.SQLERRTEXT 
					ROLLBACK USING gtr_sce;
					MESSAGEBOX("Aviso", "Se produjo un error al actualizar la tabla de disponibilidad de salones: " + ls_error )
					RETURN -1 			
				END IF 
				
				// Se genera query para ciclo de actualización de tiempo de sanitización. 
				ls_query_san = " SELECT MAX(sd.hora), sd.cve_dia, sc.tiempo_sanitizacion " + &  
									" FROM salones_disponibilidad sd, salones_asignacion sa, salones_edificio_conf sc " + &      
									" WHERE sd.cve_salon = ~~'" + ls_clave_salon + "~~'" + &    
									" AND sa.cve_mat = " + STRING(ll_cve_mat_ant) + " AND sa.gpo = ~~'" + ls_grupo_ant + "~~'" + &      
									" AND sa.fechahora = sd.fechahora " + &   
									" AND sd.edificio = sc.edificio " + &   
									" AND sd.nivel = sc.nivel " + &   
									" GROUP BY sd.cve_dia, sc.tiempo_sanitizacion " 
	
				lds_horas_sanitizacion.DATAOBJECT = "dw_hora_dia_san"  
				lds_horas_sanitizacion.MODIFY("Datawindow.Table.Select = '" + ls_query_san + "'") 
				lds_horas_sanitizacion.SETTRANSOBJECT(gtr_sce) 
				le_ttl_dias = lds_horas_sanitizacion.RETRIEVE() 
				
				
				// Se "Apartan las horas de sanitización"
				FOR	le_pos_dia = 1 TO le_ttl_dias
				
					le_hora_max = lds_horas_sanitizacion.GETITEMNUMBER(le_pos_dia, "hora")
					le_dia_san = lds_horas_sanitizacion.GETITEMNUMBER(le_pos_dia, "dia")
					ll_ttl_san =	lds_horas_sanitizacion.GETITEMNUMBER(le_pos_dia, "tiempo_san") 
				
					FOR ll_pos_san = 1 TO ll_ttl_san 
				
						UPDATE salones_disponibilidad 
						SET salones_disponibilidad.estatus = 'SAN' 
						WHERE salones_disponibilidad.cve_salon = :ls_clave_salon  
						AND salones_disponibilidad.hora = (:le_hora_max + :ll_pos_san) 
						AND salones_disponibilidad.cve_dia = :le_dia_san 
						AND EXISTS (SELECT * FROM salones_asignacion sa    
										WHERE sa.cve_mat = :ll_cve_mat_ant AND sa.gpo = :ls_grupo_ant  
										AND sa.dia_mes = salones_disponibilidad.dia_mes ) 	
						USING gtr_sce; 									
						IF gtr_sce.SQLCODE < 0 THEN 
							ls_error = gtr_sce.SQLERRTEXT 
							ROLLBACK USING gtr_sce;
							MESSAGEBOX("Aviso", "Se produjo un error al actualizar la tabla de disponibilidad de salones: " + ls_error )
							RETURN -1 			
						END IF 						
					
					NEXT
					
				NEXT 
				
				Commit USING gtr_sce;
				
			END IF 	// Si se actualiza salón	
	
		end if    // Si existe salón 
		
		// Se iguala la nueva materia-grupo
		ll_cve_mat_ant = ll_cve_mat 
		ls_grupo_ant = ls_grupo 		
		le_inscritos_ant = le_inscritos
		
	NEXT
	
end if
DESTROY lds_salones_libres
DESTROY lds_salon_libre 
GARBAGECOLLECT() 
return li_asignados



/******************************************************************************************************/
/******************************************************************************************************/

//		ls_sql = " SELECT salon.cve_salon, salon.cupo_max " + & 
//					" FROM salon " + & 
//					" WHERE ( salon.bloqueado = 0 ) " + &    
//					" AND salon.clase_aula LIKE ~~'SALON~~' " + &   
//					" AND (salon.cupo_max = " + STRING(ai_critcupoinsc) + " OR " + STRING(ai_critcupoinsc) + " = 0) " + &     
//					" AND ( salon.nivel = ~~'" + as_descnivel + "~~' OR ~~'" + as_descnivel + "~~' = ~~'C~~') " + &    
//					" AND NOT EXISTS( SELECT *  " + &    
//					" FROM salones_asignacion sa, salones_asignacion sb   " + &     
//					" WHERE sa.cve_mat =  " + STRING(ll_cve_mat) + &     
//					" AND sa.gpo =  ~~'" + ls_grupo + "~~' " + &    
//					" AND sa.cve_dia =  " + STRING(li_cve_dia) + &    
//					" AND sb.cve_salon = salon.cve_salon  " + &    
//					" AND sa.fechahora = sb.fechahora " 		




//				// Se recupera la última hora del horario 
//				SELECT MAX(sd.hora) 
//				INTO :le_ultima_hora
//				FROM salones_disponibilidad sd, salones_asignacion sa    
//				WHERE sd.cve_salon = :ls_clave_salon 
//				AND sa.cve_mat = :ll_cve_mat AND sa.gpo = :ls_grupo   
//				AND sa.fechahora = sd.fechahora 
//				USING gtr_sce;  
//
//				
//				// Se verifica que exista espacio para sanitizar 
//				SELECT COUNT(*)  
//				INTO:le_horas_sanitizacion
//				FROM salones_disponibilidad sd, salones_asignacion sa 
//				WHERE sd.cve_salon = :ls_clave_salon  
//				AND sa.cve_mat = :ll_cve_mat AND sa.gpo = :ls_grupo  
//				AND sd.fechahora = sa.fechahora 
//				AND EXISTS (SELECT * FROM salones_disponibilidad sd2   
//								WHERE sd2.cve_salon = sd.cve_salon 
//								AND (sd2.hora = (:le_ultima_hora + 1) OR sd2.hora = (:le_ultima_hora + 2))
//								AND sd.hora = :le_ultima_hora 
//								AND sd2.dia_mes = sd.dia_mes 
//								AND sd.cve_salon = sd2.cve_salon 
//								AND sd.dia_mes = sd2.dia_mes 
//								AND sd2.estatus IS NOT NULL)
//     			USING gtr_sce;  


/******************************************************************************************************/
/******************************************************************************************************/




end function

public function integer of_salones_preasignados ();STRING ls_sql 

STRING ls_clave_salon
LONG ll_cve_mat 
STRING ls_grupo 
INTEGER li_cve_dia

LONG ll_pos, ll_ttl_rgs 
STRING ls_error, ls_materia_grupo 

// Se hace una actualización previa de horario modular dónde se haya preasignado el salón. 
UPDATE horario_modular 
SET horario_modular.cve_salon = horario.cve_salon 
FROM horario_modular, horario 
WHERE horario_modular.cve_mat = horario.cve_mat 
AND horario_modular.gpo = horario.gpo 
AND horario_modular.periodo = horario.periodo 
AND horario_modular.anio = horario.anio 
AND horario_modular.cve_dia = horario.cve_dia 
AND horario_modular.hora_inicio = horario.hora_inicio 
AND horario_modular.hora_final = horario.hora_final 
AND horario.cve_salon IS NOT NULL 
AND horario_modular.cve_salon IS NULL 
AND horario_modular.periodo = :ie_periodo  
AND horario_modular.anio = :ie_anio 
USING gtr_sce;  
IF gtr_sce.SQLCODE < 0 THEN 
	ls_error = gtr_sce.SQLERRTEXT 
	ROLLBACK USING gtr_sce;
	MESSAGEBOX("Aviso", "Se produjo un error al actualizar la tabla de horario_modular: " + ls_error ) 
	RETURN -1 			
END IF  


ls_sql = " SELECT h.cve_mat, h.anio, h.periodo, h.cve_dia,h.hora_inicio,h.hora_final, g.fecha_inicio, g.fecha_fin, h.gpo, h.cve_salon, g.inscritos " + &  
			"  FROM horario h, " + &    
				"  grupos g " + &    
			"  WHERE g.periodo = " + STRING(ie_periodo)  + &  
			"  AND g.anio =  " + STRING(ie_anio)  + &  
			"  AND g.forma_imparte = 1  " + &  
			"  AND h.cve_mat = g.cve_mat  " + &  
			"  AND h.gpo = g.gpo   " + &  
			"  AND h.periodo = g.periodo  " + &  
			"  AND h.anio = g.anio  " + &  
			"  AND h.clase_aula = 0  " + &  
			"  AND UPPER(h.cve_salon) NOT IN(~~'HIBRIDASAL~~',~~'DISTANCIA~~', ~~'HIBRIDACOM~~', ~~'HIBRIDALAB~~', ~~'HIBRIDATALL~~')  " + &  
			"  UNION  " + &  
			"  SELECT h.cve_mat, h.anio, h.periodo, h.cve_dia,h.hora_inicio,h.hora_final, h.fecha_inicio, h.fecha_fin, h.gpo, h.cve_salon, g.inscritos  " + &  
			"  FROM horario_modular h,  " + &  
			"  	 grupos g  " + &  
			"  WHERE g.periodo = " + STRING(ie_periodo)  + &  
			"  AND g.anio =  " + STRING(ie_anio)   + &  
			"  AND g.forma_imparte = 2  " + &  
			"  AND h.cve_mat = g.cve_mat  " + &  
			"  AND h.gpo = g.gpo  " + &  
			"  AND h.periodo = g.periodo  " + &  
			"  AND h.anio = g.anio  " + &  
			"  AND EXISTS(SELECT * FROM horario h1  " + &  
			" 			 WHERE h1.cve_mat = h.cve_mat  " + &  
			" 			 AND h1.gpo = h.gpo  " + &  
			" 			 AND h1.periodo = h.periodo  " + &  
			" 			 AND h1.anio = h.anio  " + &  
			" 			 AND h1.cve_dia = h.cve_dia  " + &  
			" 			 AND h1.clase_aula = 0  " + &  
			" 			 AND UPPER(h1.cve_salon) NOT IN (~~'HIBRIDASAL~~',~~'DISTANCIA~~', ~~'HIBRIDACOM~~', ~~'HIBRIDALAB~~', ~~'HIBRIDATALL~~'))    " + &  
			"  ORDER BY 1, 2, 3  " 

DATASTORE lds_asigna_automatica_salon 
lds_asigna_automatica_salon = CREATE datastore
lds_asigna_automatica_salon.dataobject = "dw_horario_asigna_salones" 
lds_asigna_automatica_salon.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'")
lds_asigna_automatica_salon.SetTransObject(gtr_sce)
ll_ttl_rgs = lds_asigna_automatica_salon.retrieve(ie_anio, ie_periodo)




FOR ll_pos = 1 TO ll_ttl_rgs  

	ls_clave_salon = lds_asigna_automatica_salon.GETITEMSTRING(ll_pos, "cve_salon")  
	ll_cve_mat =  lds_asigna_automatica_salon.GETITEMNUMBER(ll_pos, "cve_mat") 
	ls_grupo =  lds_asigna_automatica_salon.GETITEMSTRING(ll_pos, "gpo")  
	li_cve_dia = lds_asigna_automatica_salon.GETITEMNUMBER(ll_pos, "cve_dia")  

	// Se actualiza la tabla de asignación de salones. 
	UPDATE salones_asignacion 
	SET cve_salon = :ls_clave_salon
	WHERE cve_mat = :ll_cve_mat 
	AND gpo = :ls_grupo 
	AND cve_dia = :li_cve_dia
	USING gtr_sce;  
	IF gtr_sce.SQLCODE < 0 THEN 
		ls_error = gtr_sce.SQLERRTEXT 
		ROLLBACK USING gtr_sce;
		MESSAGEBOX("Aviso", "Se produjo un error al actualizar la tabla de asignación de salones: " + ls_error )
		RETURN -1 			
	END IF 

	ls_materia_grupo = STRING(ll_cve_mat) + ls_grupo  
	
	// Se actualiza la disponibilidad de salones 
	UPDATE salones_disponibilidad 
	SET salones_disponibilidad.estatus = :ls_materia_grupo 
	WHERE EXISTS (SELECT * FROM salones_asignacion sa 
						WHERE sa.cve_mat = :ll_cve_mat AND sa.gpo = :ls_grupo   
						AND salones_disponibilidad.cve_salon = :ls_clave_salon  
						AND sa.fechahora = salones_disponibilidad.fechahora)  			
	USING gtr_sce;  
	IF gtr_sce.SQLCODE < 0 THEN 
		ls_error = gtr_sce.SQLERRTEXT 
		ROLLBACK USING gtr_sce;
		MESSAGEBOX("Aviso", "Se produjo un error al actualizar la tabla de disponibilidad de salones: " + ls_error )
		RETURN -1 			
	END IF 			
	
	Commit USING gtr_sce;





NEXT 








//DATASTORE lds_fecha_hora_sal_update 
//lds_fecha_hora_sal_update = CREATE DATASTORE 
//lds_fecha_hora_sal_update.DATAOBJECT = "dw_salones_disponibilidad" 
//lds_fecha_hora_sal_update.SETTRANSOBJECT(gtr_sce) 


RETURN 0 
end function

public function long of_existe_salon_esp (long ai_cupo, long ai_cupo_max, string as_grado);
LONG ll_ttl_salones

SELECT COUNT(*)
INTO:ll_ttl_salones 
FROM salones_disponibilidad sd, salon s 
WHERE sd.cve_salon = s.cve_salon 
AND ((sd.cupo >= :ai_cupo AND sd.cupo <= :ai_cupo_max) OR :ai_cupo = 0) 
AND ( s.nivel = :as_grado OR :as_grado = 'C') 
AND sd.estatus IS NULL 
USING gtr_sce; 
IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al verificar si existe grupo con este cupo: " + gtr_sce.SQLERRTEXT)
	RETURN -1 
END IF

RETURN ll_ttl_salones 




end function

on uo_salones_servicios.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_salones_servicios.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

