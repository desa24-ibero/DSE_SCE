$PBExportHeader$uo_paquetes.sru
forward
global type uo_paquetes from nonvisualobject
end type
end forward

global type uo_paquetes from nonvisualobject
end type
global uo_paquetes uo_paquetes

type variables
LONG il_num_paq
LONG il_clv_carr
LONG il_clv_plan
LONG il_cupo
LONG il_inscritos
INTEGER il_periodo
INTEGER il_anio

LONG il_coordinacion 
STRING is_error 
STRING is_prop_aplican[] 


LONG il_cve_mat
STRING is_gpo

LONG il_materias[] 
LONG il_cuenta

DATASTORE ids_prop_conflicto_horario  



end variables

forward prototypes
public function integer paquetes_inserta ()
public function integer of_crea_matriz_horarios (ref datastore ads_horarios)
public function integer of_valida_horarios (long al_id_paquete, long al_cve_mat, string as_gpo)
public function integer of_valida_horarios (datawindow adw_paquetes, string as_tipo_evaluacion)
public function integer of_valida_horarios (datastore adw_paquetes, string as_tipo_evaluacion)
end prototypes

public function integer paquetes_inserta ();
// Se recupera el último número de paquete
INTEGER le_existe

SELECT COUNT(*) 
INTO :le_existe 
FROM paquetes 
WHERE num_paq = :il_num_paq
USING gtr_sce; 
IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar el número de paquete nuevo: " + gtr_sce.SQLERRTEXT)	 
	RETURN -1 
END IF

// Si no existe el paquete se inserta
IF le_existe = 0 THEN 

	SELECT MAX(num_paq)
	INTO :il_num_paq  
	FROM paquetes 
	USING gtr_sce; 
	IF gtr_sce.SQLCODE < 0 THEN 
		MESSAGEBOX("Error", "Se produjo un error al recuperar el número de paquete nuevo: " + gtr_sce.SQLERRTEXT)	 
		RETURN -1 
	END IF
	IF ISNULL(il_num_paq) THEN il_num_paq = 0 
	
	// Se asigna el siguiente número
	il_num_paq = il_num_paq + 1 
	
	INSERT INTO paquetes (num_paq, clv_carr, clv_plan, cupo, inscritos, periodo, anio) 
	VALUES(:il_num_paq, :il_clv_carr, :il_clv_plan, :il_cupo, :il_inscritos, :il_periodo, :il_anio) 
	USING gtr_sce;
	IF gtr_sce.SQLCODE < 0 THEN 
		is_error = gtr_sce.SQLERRTEXT
		ROLLBACK USING gtr_sce; 
		MESSAGEBOX("Error", "Se produjo un error al recuperar el número de paquete nuevo: " + is_error)	 
		RETURN -1 
	END IF
	
// Si ya existe, se actualiza 
ELSE 
	
	UPDATE paquetes 
	SET 	clv_carr = :il_clv_carr, 
			clv_plan = :il_clv_plan, 
			cupo = :il_cupo, 
			inscritos = :il_inscritos, 
			periodo = :il_periodo, 
			anio = :il_anio 
	WHERE num_paq = :il_num_paq			
	USING gtr_sce;
	IF gtr_sce.SQLCODE < 0 THEN 
		is_error = gtr_sce.SQLERRTEXT
		ROLLBACK USING gtr_sce; 
		MESSAGEBOX("Error", "Se produjo un error al actualizar el paquete: " + is_error)	  
		RETURN -1 
	END IF	

END IF 

RETURN 0 







end function

public function integer of_crea_matriz_horarios (ref datastore ads_horarios);
INTEGER le_hora 
INTEGER le_row 
INTEGER le_dia

ads_horarios.RESET()


FOR le_hora = 1 to 16 
	le_row = ads_horarios.INSERTROW(0)
	ads_horarios.SETITEM(le_row, "hora", (le_hora + 6))
NEXT

RETURN 0 




end function

public function integer of_valida_horarios (long al_id_paquete, long al_cve_mat, string as_gpo);INTEGER le_retorno 


DATASTORE lds_paquetes
lds_paquetes = CREATE DATASTORE 
lds_paquetes.DATAOBJECT = "d_paquetes_2ing" 
lds_paquetes.SETTRANSOBJECT(gtr_sadm) 
le_retorno = lds_paquetes.RETRIEVE(il_clv_carr, il_periodo, il_anio) 

IF le_retorno <= 0 THEN 
    RETURN -1
END IF 

lds_paquetes.SETFILTER("num_paq = " + STRING(al_id_paquete))
lds_paquetes.FILTER() 

il_cve_mat = al_cve_mat
is_gpo = as_gpo

of_valida_horarios(lds_paquetes, 'U') 


RETURN ids_prop_conflicto_horario.ROWCOUNT()  



end function

public function integer of_valida_horarios (datawindow adw_paquetes, string as_tipo_evaluacion);// as_tipo_evaluacion: 'T' = Todos los tipos de propedéuticos, 'U' = Solo un Propedéutico 


INTEGER le_ttl_paq  
INTEGER le_ttl_mat
INTEGER le_ttl_hist
INTEGER le_pos 
INTEGER le_pos_paq
INTEGER le_pos_horario 

LONG ll_id_paquete 
DATASTORE lds_paquete_materias 
DATASTORE lds_horarios
DATASTORE lds_horarios_grupos 
DATASTORE lds_grupos_prop_horario
//DATASTORE ids_prop_conflicto_horario 

LONG ll_num_paquete 
INTEGER le_periodo 
INTEGER le_anio 
LONG ll_cve_mat
STRING ls_grupo 
INTEGER le_hora_inicio, le_hora_fin, le_dia 
INTEGER le_hora, le_hora_pos 
INTEGER le_por_horario, le_ttl_horario_prop 
STRING ls_ocupado, ls_propedeutico
INTEGER le_row_conflicto, le_insertado 
STRING ls_info_materia_paquete


le_ttl_paq = adw_paquetes.ROWCOUNT() 

lds_paquete_materias = CREATE DATASTORE 
lds_paquete_materias.DATAOBJECT = "dw_paquetes_materias_horarios" 
lds_paquete_materias.settransobject(gtr_sce) 

lds_horarios = CREATE DATASTORE 
lds_horarios.DATAOBJECT =  "dw_paquetes_horarios_prop" 

lds_horarios_grupos = CREATE DATASTORE 
lds_horarios_grupos.DATAOBJECT = "dw_paquetes_horario_valida" 

lds_grupos_prop_horario = CREATE DATASTORE 
lds_grupos_prop_horario.DATAOBJECT = "dw_paquetes_grupos_prop" 

ids_prop_conflicto_horario = CREATE DATASTORE  
ids_prop_conflicto_horario.DATAOBJECT = "dw_paquetes_conflicto_horario_prop"

// Paquetes 
FOR le_pos = 1 TO le_ttl_paq
	
	ll_num_paquete = adw_paquetes.GETITEMNUMBER(le_pos, "num_paq")  
	IF ISNULL(ll_num_paquete) THEN ll_num_paquete = 0 
	IF ll_num_paquete = 0 THEN CONTINUE 
	le_periodo = adw_paquetes.GETITEMNUMBER(le_pos, "periodo")  
	le_anio = adw_paquetes.GETITEMNUMBER(le_pos, "anio")  
	
	le_ttl_mat = lds_paquete_materias.RETRIEVE(ll_num_paquete, le_periodo, le_anio)  
	
	// Se inicializa el DS de horarios. 
	of_crea_matriz_horarios(lds_horarios) 
	
	// Se hace ciclo para marcar los horarios ocupados en este paquete. 
	// Materia grupo 
	FOR le_pos_paq = 1 TO le_ttl_mat 

		ll_cve_mat = lds_paquete_materias.GETITEMNUMBER(le_pos_paq, "clv_mat") 
		ls_grupo = lds_paquete_materias.GETITEMSTRING(le_pos_paq, "grupo") 
		
		lds_horarios_grupos.SETTRANSOBJECT(gtr_sce) 
		le_ttl_hist = lds_horarios_grupos.RETRIEVE(ll_cve_mat, ls_grupo, le_periodo, le_anio) 
		
		// Se hace ciclo para "ocupar" cada hora del paquete.
		// Grupos 
		FOR le_pos_horario = 1 TO le_ttl_hist 
			
			le_hora_inicio = lds_horarios_grupos.GETITEMNUMBER(le_pos_horario, "hora_inicio") 
			le_hora_fin = lds_horarios_grupos.GETITEMNUMBER(le_pos_horario, "hora_final")  
			le_dia = lds_horarios_grupos.GETITEMNUMBER(le_pos_horario, "cve_dia") 
			
			ls_info_materia_paquete = STRING(ll_cve_mat) + "," + ls_grupo + "," + STRING(le_hora_inicio) + "," + STRING(le_hora_fin) + "," + STRING(le_dia) 
			
			// Horarios 
			FOR le_hora_pos = 1 TO lds_horarios.ROWCOUNT()
				
				le_hora = lds_horarios.GETITEMNUMBER(le_hora_pos, "hora")  
				
				IF le_hora >= le_hora_inicio AND le_hora < le_hora_fin THEN 
					lds_horarios.SETITEM(le_hora - 6, le_dia + 2, ls_info_materia_paquete)   
				END IF	
				
			NEXT
			// Horarios 
			
		NEXT 
		// Grupos 
		
	NEXT
	// Materia grupo 
	
	
	
	// Se procede a verificar si el horario de las materias se cruzan con algún propedeutico.  
	lds_grupos_prop_horario.SETTRANSOBJECT(gtr_sce) 
	le_ttl_horario_prop = lds_grupos_prop_horario.RETRIEVE(il_periodo, il_anio,  il_coordinacion, is_prop_aplican)  
	
	IF as_tipo_evaluacion = 'U' THEN 
		lds_grupos_prop_horario.SETFILTER("cve_prerreq = " + STRING(il_cve_mat) + " AND gpo = '" + is_gpo + "'")
		lds_grupos_prop_horario.FILTER() 
		le_ttl_horario_prop = lds_grupos_prop_horario.ROWCOUNT()
	END IF
	
	// Se verifica si hay algún conflicto de horario.
	FOR le_por_horario = 1 TO le_ttl_horario_prop
		
		le_dia = lds_grupos_prop_horario.GETITEMNUMBER(le_por_horario, "cve_dia") 
		le_hora_inicio = lds_grupos_prop_horario.GETITEMNUMBER(le_por_horario, "hora_inicio") 
		le_hora_fin = lds_grupos_prop_horario.GETITEMNUMBER(le_por_horario, "hora_final") 
		ls_propedeutico = lds_grupos_prop_horario.GETITEMSTRING(le_por_horario, "descripcion") 
	
		// Horarios 
		FOR le_hora_pos = 1 TO lds_horarios.ROWCOUNT()
			
			le_hora = lds_horarios.GETITEMNUMBER(le_hora_pos, "hora")  
			
			IF le_hora >= le_hora_inicio AND le_hora < le_hora_fin THEN 
				ls_ocupado = lds_horarios.GETITEMSTRING(le_hora - 6, le_dia + 2)    
				IF TRIM(ls_ocupado) <> "" THEN  
				
					//le_insertado = ids_prop_conflicto_horario.FIND("s_propedeutico = '" + ls_propedeutico + "'", 0, ids_prop_conflicto_horario.ROWCOUNT() + 1) 
					le_insertado = ids_prop_conflicto_horario.FIND("materia_conflicto = '" + ls_ocupado + "'", 0, ids_prop_conflicto_horario.ROWCOUNT() + 1) 
					
					
					IF le_insertado <= 0 THEN 
						le_row_conflicto = ids_prop_conflicto_horario.INSERTROW(0) 
						ids_prop_conflicto_horario.SETITEM(le_row_conflicto, "s_propedeutico", ls_propedeutico) 
						ids_prop_conflicto_horario.SETITEM(le_row_conflicto, "hora_inicial", le_hora_inicio) 
						ids_prop_conflicto_horario.SETITEM(le_row_conflicto, "hora_final", le_hora_fin) 
						ids_prop_conflicto_horario.SETITEM(le_row_conflicto, "id_dia", le_dia) 
						ids_prop_conflicto_horario.SETITEM(le_row_conflicto, "materia_conflicto", ls_ocupado) 
					END IF
					
				END IF
			END IF	
			
		NEXT		
	
	NEXT
	
NEXT 
// Paquetes 

IF ids_prop_conflicto_horario.ROWCOUNT() > 0 AND as_tipo_evaluacion = 'T' THEN  
	
	uo_parametros_paquetes luo_parametros_paquetes 
	luo_parametros_paquetes = CREATE uo_parametros_paquetes 
	luo_parametros_paquetes.ids_paso = ids_prop_conflicto_horario
	OPENWITHPARM(w_conflicto_prop_horario, luo_parametros_paquetes) 
	
ELSE
	
	RETURN ids_prop_conflicto_horario.ROWCOUNT() 
	
END IF

RETURN 0 




end function

public function integer of_valida_horarios (datastore adw_paquetes, string as_tipo_evaluacion);// as_tipo_evaluacion: 'T' = Todos los tipos de propedéuticos, 'U' = Solo un Propedéutico 


INTEGER le_ttl_paq  
INTEGER le_ttl_mat
INTEGER le_ttl_hist
INTEGER le_pos 
INTEGER le_pos_paq
INTEGER le_pos_horario 

LONG ll_id_paquete 
DATASTORE lds_paquete_materias 
DATASTORE lds_horarios
DATASTORE lds_horarios_grupos 
DATASTORE lds_grupos_prop_horario
//DATASTORE ids_prop_conflicto_horario 

LONG ll_num_paquete 
INTEGER le_periodo 
INTEGER le_anio 
LONG ll_cve_mat
STRING ls_grupo 
INTEGER le_hora_inicio, le_hora_fin, le_dia 
INTEGER le_hora, le_hora_pos 
INTEGER le_por_horario, le_ttl_horario_prop 
STRING ls_ocupado, ls_propedeutico
INTEGER le_row_conflicto, le_insertado 
STRING ls_info_materia_paquete


le_ttl_paq = adw_paquetes.ROWCOUNT() 

lds_paquete_materias = CREATE DATASTORE 
//lds_paquete_materias.DATAOBJECT = "dw_paquetes_materias_horarios" 
lds_paquete_materias.DATAOBJECT = "dw_paquetes_materias_horarios_enlace"  
lds_paquete_materias.settransobject(gtr_sce) 

lds_horarios = CREATE DATASTORE 
lds_horarios.DATAOBJECT =  "dw_paquetes_horarios_prop" 

lds_horarios_grupos = CREATE DATASTORE 
lds_horarios_grupos.DATAOBJECT = "dw_paquetes_horario_valida" 

lds_grupos_prop_horario = CREATE DATASTORE 
lds_grupos_prop_horario.DATAOBJECT = "dw_paquetes_grupos_prop2" 

ids_prop_conflicto_horario = CREATE DATASTORE  
ids_prop_conflicto_horario.DATAOBJECT = "dw_paquetes_conflicto_horario_prop"

// Paquetes 
FOR le_pos = 1 TO le_ttl_paq
	
	ll_num_paquete = adw_paquetes.GETITEMNUMBER(le_pos, "num_paq")  
	IF ISNULL(ll_num_paquete) THEN ll_num_paquete = 0 
	IF ll_num_paquete = 0 THEN CONTINUE 
	le_periodo = adw_paquetes.GETITEMNUMBER(le_pos, "periodo")  
	le_anio = adw_paquetes.GETITEMNUMBER(le_pos, "anio")  
	
	//le_ttl_mat = lds_paquete_materias.RETRIEVE(ll_num_paquete, le_periodo, le_anio)  
	le_ttl_mat = lds_paquete_materias.RETRIEVE(ll_num_paquete, le_periodo, le_anio, il_cuenta, il_materias)  
	
	// Se inicializa el DS de horarios. 
	of_crea_matriz_horarios(lds_horarios) 
	
	// Se hace ciclo para marcar los horarios ocupados en este paquete. 
	// Materia grupo 
	FOR le_pos_paq = 1 TO le_ttl_mat 

		ll_cve_mat = lds_paquete_materias.GETITEMNUMBER(le_pos_paq, "clv_mat") 
		ls_grupo = lds_paquete_materias.GETITEMSTRING(le_pos_paq, "grupo") 
		
		lds_horarios_grupos.SETTRANSOBJECT(gtr_sce) 
		le_ttl_hist = lds_horarios_grupos.RETRIEVE(ll_cve_mat, ls_grupo, le_periodo, le_anio) 
		
		// Se hace ciclo para "ocupar" cada hora del paquete.
		// Grupos 
		FOR le_pos_horario = 1 TO le_ttl_hist 
			
			le_hora_inicio = lds_horarios_grupos.GETITEMNUMBER(le_pos_horario, "hora_inicio") 
			le_hora_fin = lds_horarios_grupos.GETITEMNUMBER(le_pos_horario, "hora_final")  
			le_dia = lds_horarios_grupos.GETITEMNUMBER(le_pos_horario, "cve_dia") 
			
			ls_info_materia_paquete = STRING(ll_cve_mat) + "," + ls_grupo + "," + STRING(le_hora_inicio) + "," + STRING(le_hora_fin) + "," + STRING(le_dia) 
			
			// Horarios 
			FOR le_hora_pos = 1 TO lds_horarios.ROWCOUNT()
				
				le_hora = lds_horarios.GETITEMNUMBER(le_hora_pos, "hora")  
				
				IF le_hora >= le_hora_inicio AND le_hora < le_hora_fin THEN 
					lds_horarios.SETITEM(le_hora - 6, le_dia + 2, ls_info_materia_paquete)   
				END IF	
				
			NEXT
			// Horarios 
			
		NEXT 
		// Grupos 
		
	NEXT
	// Materia grupo 
	
	
	
	// Se procede a verificar si el horario de las materias se cruzan con algún propedeutico.  
	lds_grupos_prop_horario.SETTRANSOBJECT(gtr_sce) 
	le_ttl_horario_prop = lds_grupos_prop_horario.RETRIEVE(il_periodo, il_anio,  9999, il_cve_mat, is_gpo)   
	
	IF as_tipo_evaluacion = 'U' THEN 
		lds_grupos_prop_horario.SETFILTER("cve_prerreq = " + STRING(il_cve_mat) + " AND gpo = '" + is_gpo + "'")
		lds_grupos_prop_horario.FILTER() 
		le_ttl_horario_prop = lds_grupos_prop_horario.ROWCOUNT()
	END IF
	
	// Se verifica si hay algún conflicto de horario.
	FOR le_por_horario = 1 TO le_ttl_horario_prop
		
		le_dia = lds_grupos_prop_horario.GETITEMNUMBER(le_por_horario, "cve_dia") 
		le_hora_inicio = lds_grupos_prop_horario.GETITEMNUMBER(le_por_horario, "hora_inicio") 
		le_hora_fin = lds_grupos_prop_horario.GETITEMNUMBER(le_por_horario, "hora_final") 
		ls_propedeutico = lds_grupos_prop_horario.GETITEMSTRING(le_por_horario, "descripcion") 
	
		// Horarios 
		FOR le_hora_pos = 1 TO lds_horarios.ROWCOUNT()
			
			le_hora = lds_horarios.GETITEMNUMBER(le_hora_pos, "hora")  
			
			IF le_hora >= le_hora_inicio AND le_hora < le_hora_fin THEN 
				ls_ocupado = lds_horarios.GETITEMSTRING(le_hora - 6, le_dia + 2)    
				IF TRIM(ls_ocupado) <> "" THEN  
				
					//le_insertado = ids_prop_conflicto_horario.FIND("s_propedeutico = '" + ls_propedeutico + "'", 0, ids_prop_conflicto_horario.ROWCOUNT() + 1) 
					le_insertado = ids_prop_conflicto_horario.FIND("materia_conflicto = '" + ls_ocupado + "'", 0, ids_prop_conflicto_horario.ROWCOUNT() + 1) 
					
					
					IF le_insertado <= 0 THEN 
						le_row_conflicto = ids_prop_conflicto_horario.INSERTROW(0) 
						ids_prop_conflicto_horario.SETITEM(le_row_conflicto, "s_propedeutico", ls_propedeutico) 
						ids_prop_conflicto_horario.SETITEM(le_row_conflicto, "hora_inicial", le_hora_inicio) 
						ids_prop_conflicto_horario.SETITEM(le_row_conflicto, "hora_final", le_hora_fin) 
						ids_prop_conflicto_horario.SETITEM(le_row_conflicto, "id_dia", le_dia) 
						ids_prop_conflicto_horario.SETITEM(le_row_conflicto, "materia_conflicto", ls_ocupado) 
					END IF
					
				END IF
			END IF	
			
		NEXT		
	
	NEXT
	
NEXT 
// Paquetes 

IF ids_prop_conflicto_horario.ROWCOUNT() > 0 AND as_tipo_evaluacion = 'T' THEN  
	
	uo_parametros_paquetes luo_parametros_paquetes 
	luo_parametros_paquetes = CREATE uo_parametros_paquetes 
	luo_parametros_paquetes.ids_paso = ids_prop_conflicto_horario
	OPENWITHPARM(w_conflicto_prop_horario, luo_parametros_paquetes) 
	
ELSE
	
	RETURN ids_prop_conflicto_horario.ROWCOUNT() 
	
END IF

RETURN 0 




end function

on uo_paquetes.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_paquetes.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

