$PBExportHeader$uo_grupo_servicios.sru
forward
global type uo_grupo_servicios from nonvisualobject
end type
end forward

global type uo_grupo_servicios from nonvisualobject
end type
global uo_grupo_servicios uo_grupo_servicios

type variables
STRING is_cve_mat_gpo
LONG il_cve_mat
STRING is_gpo
INTEGER ie_periodo
INTEGER ie_anio
INTEGER ie_cond_gpo
INTEGER ie_cupo
INTEGER ie_tipo
INTEGER ie_inscritos
INTEGER ie_insc_desp_bajas
LONG il_cve_asimilada
STRING is_gpo_asimilado
LONG il_cve_profesor
DECIMAL id_prom_gpo
DECIMAL id_porc_asis
DECIMAL id_ema4
INTEGER ie_primer_sem
STRING is_comentarios
LONG il_demanda_inscritos
INTEGER ie_forma_imparte
DATETIME idt_fecha_inicio
DATETIME idt_fecha_fin
LONG il_idioma 
INTEGER ie_factor_horas 
STRING is_sesionado 
INTEGER ie_modalidad
//INTEGEr ie_horas_reales_gpo

BOOLEAN ib_modifica_salon

INTEGER ie_horas_totales_semestre
INTEGER ie_horas_horario 

//Profesor obligatorio Bloques 0 - No obligatorio; 1 - Obligatorio 	
INTEGER ie_prof_obligatorio
//Cubrir Horario Completo Bloques 0 - No obligatorio; 1 - Obligatorio
INTEGER ie_horario_completo
//Multiples profesores para Grupo Tradicional 0 - No permitido; 1 - Permitido 
INTEGER ie_multiples_prof_trad
//Detalle de Horario de Profesores 0 - No aplica; 1 - Aplica No Obligatorio; 2 - Aplica Obligatorio
INTEGER ie_horario_prof 
// Fechas de inicio y fin del periodo 
DATETIME idt_inicio_periodo
DATETIME idt_fin_periodo

//Horas reales totales 
//INTEGER ie_horas_reales_tot
//Horas reales semanales
//INTEGER ie_horas_reales

//Horas capturadas semanales 
//HORAS SEMANA CAPTURADAS
INTEGER ie_horas_totales

//Horas reales totales semanales 
INTEGER ie_horas_reales_tot_sem

// Horas totales reales por periodo
//HORAS TOTALES POR SEMESTRE 
INTEGER ie_horas_reales_tot_per 

// Horas totales CAPTURADAS 
//HORAS TOTALES POR SEMESTRE CAPTURADAS
INTEGER ie_horas_totales_capt

STRING is_error

DATASTORE ids_profesor 
DATASTORE ids_horario 
DATASTORE ids_horario_org 
DATASTORE ids_paquete_valida_hora
DATASTORE ids_paquete_horario
DATASTORE ids_horario_profesor
DATASTORE ids_grupos_valida_exepcion 
// Inserta-Recupera las sesiones del grupo 
DATASTORE ids_grupo_sesion  
DATASTORE ids_grupos_bloques

DATASTORE ids_dias_no_laborables 

n_tr itr_sce 

DATASTORE ids_derecho_uso_bloque

STRING is_dia[7] = {"domingo", "lunes", "martes", "miercoles", "jueves", "viernes", "sabado"} 

// grupos_paquetes 
LONG il_id_paquete
STRING is_descripcion_paq
LONG il_cve_coordinacion_paq
INTEGER ie_periodo_paq
INTEGER ie_anio_paq


INTEGER ie_requiere_horario

BOOLEAN ib_afecta_sdu_serv_esc

LONG il_coordinacion

uo_grupos_multiplantel iuo_grupos_multiplantel 


INTEGER ie_doble_presencia = 1
INTEGER ie_horas_minimas = 1 

BOOLEAN ib_mat_exep_fecha_fin

INTEGER ie_modo_opera 


end variables

forward prototypes
public function integer of_fechas_periodo ()
public function integer of_inserta_grupo ()
public function integer of_valida_grupo (long al_cve_materia, string as_grupo)
public function integer of_valida_datos ()
public function integer of_valida_fechas_bloque (boolean pb_mensajes)
public function integer of_valida ()
public function integer of_carga_grupo ()
public function integer of_valida_horario (datastore ads_horario)
public function integer of_inicializa_parametros ()
public function integer of_valida_profesor ()
public function integer of_inserta_horario ()
public function integer of_inserta_profesor ()
public function integer of_actualiza ()
public function integer of_inserta_grupo_paquete ()
public function integer of_carga_grupo_paquete ()
public function integer of_valida_horas ()
public function integer of_nuevo ()
public function integer of_calcula_horas_reales ()
public function integer of_calcula_horas_semana ()
public function integer of_inserta_profesor_horario ()
public function integer of_genera_derecho_uso_bloques (long al_coordinacion)
public function integer of_calcula_derecho_uso_modular (integer ae_genera)
public function integer of_actualiza_derecho_uso_bloques ()
public function integer of_valida_covertura_horario_profesor ()
public function integer of_afecta_sdu_tradicional ()
public function integer of_borra_grupo ()
public function boolean of_existe_grupo (long al_cve_mat, string as_gpo, integer ai_periodo, integer ai_anio)
public function boolean of_grupo_cancelado (long al_cve_mat, string as_gpo, integer ai_periodo, integer ai_anio)
public function boolean of_grupo_asimilado (long al_cve_mat, string as_gpo, integer ai_periodo, integer ai_anio)
public function boolean of_mat_a_menoshoras_mat_b (long al_cve_mat_a, long al_cve_mat_b)
public function boolean of_salon_hora_usado_bloque (long al_cve_mat, string as_gpo, integer ai_periodo, integer ai_anio, integer ai_cve_dia, string as_cve_salon, integer ai_hora_inicio, datetime fecha_inicio, datetime fecha_fin)
public function integer of_obten_nombre_aula_clase_aula (integer ai_clase, ref string as_nombre_aula)
public function boolean of_dec_derecho_uso_sc (long al_cve_mat, integer ai_dia, integer ai_hor_ini, integer ai_hor_fin, integer ai_cupo, boolean ab_desc_sdu_se)
public function boolean of_inc_derecho_uso_sc (long al_cve_mat, integer ai_dia, integer ai_hor_ini, integer ai_hor_fin, integer ai_cupo, boolean ab_desc_sdu_se)
public function integer of_calcula_fecha_final ()
public function boolean of_existe_salon (string as_cve_salon, ref string as_clase_aula, ref integer ai_bloqueado)
public function boolean of_es_salon_otro (string as_cve_salon, ref string as_clase_aula)
public function integer of_carga_valida_exepciones (long al_cve_mat)
public function integer of_inserta_horario_modular ()
public function integer of_valida_sesiones ()
public function integer of_valida_sesiones_profesor ()
public function integer of_valida_horario_prof_sesion ()
public function integer of_cuenta_horas_sesiones ()
public function integer of_carga_dias_no_laborables ()
public function integer of_calcula_horas_reales_sesiones_tot ()
public function integer of_carga_horario_org ()
public function integer of_salon_horario (string as_salon)
public function boolean of_valida_dia_laborable (datetime adt_fecha)
public function long of_calcula_horas_totales_semestre ()
public function integer of_horas_semestre ()
end prototypes

public function integer of_fechas_periodo ();
SELECT fecha 
INTO :idt_inicio_periodo 
FROM calendario 
WHERE periodo = :ie_periodo
AND anio = :ie_anio 
AND cve_evento = 1
USING itr_sce;
IF itr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("ERROR", "Se produjo un error al recuperar la fecha de inicio de semestre: " + itr_sce.SQLERRTEXT)
	RETURN -1 
ELSEIF itr_sce.SQLCODE = 100 THEN 
	MESSAGEBOX("ERROR", "No existe la fecha de inicio de semestre en calendario para el periodo: " + STRING(ie_periodo) + "-" + STRING(ie_anio) )
	RETURN -1 	
END IF

SELECT fecha 
INTO :idt_fin_periodo
FROM calendario 
WHERE periodo = :ie_periodo
AND anio = :ie_anio  
AND cve_evento = 2 
USING itr_sce;
IF itr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("ERROR", "Se produjo un error al recuperar la fecha de fin de semestre: " + itr_sce.SQLERRTEXT)
	RETURN -1 
ELSEIF itr_sce.SQLCODE = 100 THEN 
	MESSAGEBOX("ERROR", "No existe la fecha de fin de semestre en calendario para el periodo: " + STRING(ie_periodo) + "-" + STRING(ie_anio) )
	RETURN -1 		
END IF


idt_fecha_inicio = idt_inicio_periodo
idt_fecha_fin = idt_fin_periodo

RETURN 0 




end function

public function integer of_inserta_grupo ();
INTEGER le_existe

// Se verifica si existe el grupo.
le_existe = of_valida_grupo(il_cve_mat, is_gpo) 

IF le_existe <= 0 THEN 
	
	INSERT INTO grupos (cve_mat_gpo, cve_mat, gpo, periodo, anio, cond_gpo, cupo, tipo, 
								inscritos, insc_desp_bajas, cve_asimilada, gpo_asimilado, cve_profesor, prom_gpo, porc_asis, ema4, 
								primer_sem, comentarios, demanda_inscritos, forma_imparte, fecha_inicio, fecha_fin, idioma, factor_horas, sesionado, modalidad) 
	VALUES(:is_cve_mat_gpo, :il_cve_mat, :is_gpo, :ie_periodo, :ie_anio, :ie_cond_gpo, :ie_cupo, :ie_tipo, 
				:ie_inscritos, :ie_insc_desp_bajas, :il_cve_asimilada, :is_gpo_asimilado, :il_cve_profesor, :id_prom_gpo, :id_porc_asis, :id_ema4, 
				:ie_primer_sem, :is_comentarios, :il_demanda_inscritos, :ie_forma_imparte, :idt_fecha_inicio, :idt_fecha_fin, :il_idioma, :ie_factor_horas, :is_sesionado, :ie_modalidad ) 
	USING itr_sce; 
	IF itr_sce.SQLCODE < 0 THEN 
		is_error = " Se produjo un error al actualizar el grupo: " + itr_sce.SQLERRTEXT  
		ROLLBACK USING itr_sce; 
		RETURN -1 
	END IF
	
ELSE
	
	UPDATE grupos 
	SET  cond_gpo = :ie_cond_gpo,  
			cupo = :ie_cupo,  
			tipo = :ie_tipo,   
			insc_desp_bajas = :ie_insc_desp_bajas,  
			cve_asimilada  = :il_cve_asimilada, 
			gpo_asimilado = :is_gpo_asimilado,  
			cve_profesor = :il_cve_profesor,  
			prom_gpo = :id_prom_gpo,  
			porc_asis = :id_porc_asis,  
			ema4 = :id_ema4,  
			primer_sem = :ie_primer_sem,  
			comentarios = :is_comentarios,  
			forma_imparte  = :ie_forma_imparte, 
			fecha_inicio = :idt_fecha_inicio,  
			fecha_fin = :idt_fecha_fin,  
			idioma = :il_idioma, 
			sesionado = :is_sesionado, 
			modalidad = :ie_modalidad
	WHERE cve_mat = :il_cve_mat  
	 AND gpo = :is_gpo   
	 AND periodo = :ie_periodo   
	 AND anio = :ie_anio   		
	USING itr_sce; 
	IF itr_sce.SQLCODE < 0 THEN 
		is_error = " Se produjo un error al actualizar el grupo: " + itr_sce.SQLERRTEXT 
		ROLLBACK USING itr_sce; 
		RETURN -1 
	END IF	
	//inscritos  = :ie_inscritos, 
	//demanda_inscritos = :il_demanda_inscritos,  
END IF

RETURN 0 





end function

public function integer of_valida_grupo (long al_cve_materia, string as_grupo);INTEGER le_ttl_grupos

SELECT COUNT(*) 
INTO :le_ttl_grupos 
FROM grupos
WHERE cve_mat = :al_cve_materia 
AND gpo = :as_grupo
AND periodo = :ie_periodo
AND anio = :ie_anio 
USING itr_sce; 
IF itr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al validar la existencia del grupo: " + itr_sce.SQLERRTEXT)	 
	RETURN -1 
END IF 

RETURN le_ttl_grupos 







end function

public function integer of_valida_datos ();//INTEGER le_pos
//




//Materia
IF ISNULL(il_cve_mat) THEN il_cve_mat = 0 
IF il_cve_mat = 0 THEN 
	MESSAGEBOX("Error", "No se ha capturado la clave de la materia.") 
	RETURN -1
END IF 

//Grupo
IF ISNULL(is_gpo) THEN is_gpo = "" 
IF TRIM(is_gpo) = "" THEN 
	MESSAGEBOX("Error", "No se ha capturado el grupo.")  
	RETURN -1	
END IF 

// Modalidad 
IF ISNULL(ie_modalidad) OR  ie_modalidad = 0 THEN 
	MESSAGEBOX("Error", "No se ha seleccionado la modalidad.")   
	RETURN -1	
END IF 

// Materia grupo 
is_cve_mat_gpo = STRING(il_cve_mat) + is_gpo

// Periodo
IF ISNULL(ie_periodo)  THEN ie_periodo = -1 
IF ie_periodo < 0 THEN 
	MESSAGEBOX("Error", "No se ha especificado el periodo del grupo.") 
	RETURN -1	
END IF 

// Año
IF ISNULL(ie_anio)  THEN ie_anio = 0 
IF ie_anio = 0 THEN 
	MESSAGEBOX("Error", "No se ha especificado el año del grupo.")   
	RETURN -1	
END IF 

// Condición de grupo 
IF ISNULL(ie_cond_gpo)  THEN ie_cond_gpo = 0 
IF ie_cond_gpo = 0 THEN 
	MESSAGEBOX("Error", "No se ha especificado la condición del grupo.")  
	RETURN -1	
END IF 
 
 // Cupo 
IF ISNULL(ie_cupo)  THEN ie_cupo = 0 
IF ie_cupo < 0 THEN 
	MESSAGEBOX("Error", "No se ha especificado el cupo del grupo.")   
	RETURN -1	
END IF 

 // Tipo de grupo 
IF ISNULL(ie_tipo)  THEN 
	//IF ie_tipo = 0 THEN 
	MESSAGEBOX("Error", "No se ha especificado el tipo del grupo.")   
	RETURN -1	
END IF 

// Validaciones según el TIPO DE GRUPO 
if ids_profesor.ROWCOUNT() > 1 and (ie_tipo = 1)  then 
	MESSAGEBOX("Aviso", "Los grupos por asesoria no pueden tener profesor cotitular.",StopSign!) 
	return -1			
end if

//El grupo asimilado no puede ser el mismo que se esta registrando
IF ie_tipo =2 THEN 
	
// il_cve_asimilada
//is_gpo_asimilado	
//INTEGER ie_periodo
//INTEGER ie_anio
	
	//Revisa que el grupo no se haya dado de alta previamente
	
	if isnull(il_cve_asimilada) then
		MessageBox("Materia Asimilate Faltante", "No se ha asignado la materia que asimila.",StopSign!)
		return -1
	end if

	if isnull(is_gpo_asimilado) then
		MessageBox("Grupo Asimilate Faltante", "No se ha asignado el grupo que asimila.",StopSign!)
		return -1
	end if
	
	if not of_existe_grupo(il_cve_asimilada, is_gpo_asimilado, ie_periodo, ie_anio) then
		MessageBox("Grupo Asimilante Inexistente", "El grupo "+string(il_cve_asimilada)+":"+is_gpo_asimilado+" no ha sido registrado.",StopSign!)
		return -1
	end if

	if of_grupo_cancelado(il_cve_asimilada, is_gpo_asimilado, ie_periodo, ie_anio) then
		MessageBox("Grupo Asimilante Cancelado", "El grupo "+string(il_cve_asimilada)+":"+is_gpo_asimilado+" se encuentra cancelado.",StopSign!)
		return -1
	end if

	if il_cve_asimilada= il_cve_mat and is_gpo_asimilado = is_gpo then
		MessageBox("Grupo Asimilado Invalido", "El grupo "+string(il_cve_asimilada)+":"+&
	              is_gpo_asimilado+" no puede asimilarse a si mismo.",StopSign!)
		return -1
	end if
	if of_grupo_asimilado(il_cve_asimilada, is_gpo_asimilado, ie_periodo, ie_anio) then
		MessageBox("Grupo Asimilado Encadenado", "El grupo "+string(il_cve_asimilada)+":"+&
		is_gpo_asimilado+" esta registrado como asimilado también.",StopSign!)
		return -1
	end if

	if of_mat_a_menoshoras_mat_b(il_cve_asimilada, il_cve_mat) then
		MessageBox("Materia Asimilada con Menos Horas", "La materia "+string(il_cve_asimilada)+&
		" tiene menos horas que la materia "+string(il_cve_mat)+".",StopSign!)
		return -1
	end if

END IF


// Se recuperan los parámetros asociados al tipo de grupo. 
STRING ls_desc_tipo
INTEGER le_requiere_horario

SELECT requiere_horario,  nombre_tipo
INTO :le_requiere_horario, :ls_desc_tipo
FROM tipo_grupo 
WHERE tipo = :ie_tipo
USING itr_sce; 
IF itr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar la información del tipo de grupo: " + itr_sce.SQLERRTEXT) 
	RETURN -1	
END IF 

ie_requiere_horario = le_requiere_horario 

IF ids_horario.ROWCOUNT() = 0 AND le_requiere_horario = 1 THEN  
	MessageBox("Grupo sin Horario", "Es necesario capturar horarios para el grupo.",StopSign!)
	return -1	
ELSEIF ids_horario.ROWCOUNT() > 0 AND le_requiere_horario = 0 then		
	MESSAGEBOX("Grupo sin horario", "Los grupos " + ls_desc_tipo + " no pueden tener horario.",StopSign!) 
	RETURN -1	
END IF 


//********AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI 
//********AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI 
// Si requiere horario y es un grupo sesionado, se validan las sesiones. 
IF le_requiere_horario = 1 AND is_sesionado = 'S' THEN 
	IF of_valida_sesiones( ) < 0 THEN 
		MESSAGEBOX("Error en sesiones", "Las sesiones de grupo capturadas no son válidas.",StopSign!) 
		RETURN -1			
	END IF 
	
	IF of_valida_sesiones_profesor() < 0 THEN 
		MESSAGEBOX("Error en Horario de Profesores", "El Horario asignado a los Profesores no es válido.",StopSign!)  
		RETURN -1			
	END IF 
	
	
END IF 
//********AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI 
//********AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI   

  
  
//ie_inscritos 
//ie_insc_desp_bajas 



// Profesor 
IF ISNULL(il_cve_profesor)  THEN il_cve_profesor  = 0 
IF il_cve_profesor  = 0 THEN 
	MESSAGEBOX("Error", "No se ha especificado un Profesor Titular para el grupo.")    
	RETURN -1	
END IF 





//
////iuo_grupo_servicios.id_prom_gpo
////iuo_grupo_servicios.id_porc_asis
////iuo_grupo_servicios.id_ema4
//ie_primer_sem 

IF ISNULL(is_comentarios) THEN is_comentarios = "" 

////iuo_grupo_servicios.il_demanda_inscritos

// Forma de impartir (1=Tadicional, 2=Bloques) 
IF ISNULL(ie_forma_imparte)  THEN ie_forma_imparte = 0 
IF ie_forma_imparte = 0 THEN 
	MESSAGEBOX("Error", "No se ha especificado la forma de impartir el curso.")    
	RETURN -1	
END IF 

// Se valida la fecha de inicio 
IF ISNULL(idt_fecha_inicio) THEN 
	MESSAGEBOX("Error", "No se ha especificado la fecha de inicio del curso.")    
	RETURN -1		
END IF
IF (DATE(idt_fecha_inicio) <  DATE(idt_inicio_periodo)) OR (DATE(idt_fecha_inicio) > DATE(idt_fin_periodo))  THEN 
	MESSAGEBOX("Error", "No se ha especificado una fecha de inicio de curso válida.")    
	RETURN -1		
END IF

// Se valida la fecha de fin 
IF ISNULL(idt_fecha_fin) THEN 
	MESSAGEBOX("Error", "No se ha especificado la fecha de fin del curso.")    
	RETURN -1		
END IF
IF (DATE(idt_fecha_fin) <  DATE(idt_inicio_periodo)) OR (DATE(idt_fecha_fin) > DATE(idt_fin_periodo))  THEN 
	MESSAGEBOX("Error", "No se ha especificado una fecha de fin de curso válida.")    
	RETURN -1		
END IF

// Se valida que sea un periodo de fecha válido 
IF DATE(idt_fecha_inicio) >= DATE(idt_fecha_fin) THEN 
	MESSAGEBOX("Error", "Las fechas de inicio y fin de periodo específicadas no son válidas.")     
	RETURN -1			
END IF

// Idioma
IF ISNULL(il_idioma)  THEN il_idioma = 0 
IF il_idioma = 0 THEN 
	MESSAGEBOX("Error", "No se ha especificado el idioma del curso.")    
	RETURN -1	
END IF 


RETURN 0 






// // Grupo asimilado 
//IF ISNULL(is_gpo_asimilado) THEN is_gpo_asimilado = "" 
//IF TRIM(is_gpo_asimilado) = "" THEN 
//	MESSAGEBOX("Error", "No se ha capturado el grupo asimilado.")   
//	RETURN -1	
//END IF 
//

//// Materia asimilada 
//IF ISNULL(il_cve_asimilada)  THEN il_cve_asimilada = 0 
//IF il_cve_asimilada = 0 THEN 
//	MESSAGEBOX("Error", "No se ha especificado la clave asimilada.")    
//	RETURN -1	
//END IF 




end function

public function integer of_valida_fechas_bloque (boolean pb_mensajes);// Se verifica que sea un periodo de fechas válido 
IF DATE(idt_fecha_inicio) >=  DATE(idt_fecha_fin) THEN 
	IF pb_mensajes THEN 
		MESSAGEBOX("Aviso", "La fecha Final debe ser POSTERIOR a la Inicial. ")
	ELSE
		is_error = "La fecha Final debe ser POSTERIOR a la Inicial. "
	END IF
	RETURN -1 
END IF 

RETURN 0 


end function

public function integer of_valida ();// Función de validación de grupo antes de guardar.
IF of_valida_fechas_bloque(FALSE) < 0 THEN 
	MESSAGEBOX("Aviso", is_error) 
	RETURN -1
END IF





end function

public function integer of_carga_grupo ();
SELECT cve_mat_gpo,  cond_gpo, cupo, tipo, 
							inscritos, insc_desp_bajas, cve_asimilada, gpo_asimilado, cve_profesor, prom_gpo, porc_asis, ema4, 
							primer_sem, comentarios, demanda_inscritos, forma_imparte, fecha_inicio, fecha_fin, idioma, factor_horas, 
							sesionado, modalidad  
INTO :is_cve_mat_gpo,  :ie_cond_gpo, :ie_cupo, :ie_tipo, 
			:ie_inscritos, :ie_insc_desp_bajas, :il_cve_asimilada, :is_gpo_asimilado, :il_cve_profesor, :id_prom_gpo, :id_porc_asis, :id_ema4, 
			:ie_primer_sem, :is_comentarios, :il_demanda_inscritos, :ie_forma_imparte, :idt_fecha_inicio, :idt_fecha_fin, :il_idioma, :ie_factor_horas, 
			:is_sesionado, :ie_modalidad 
FROM grupos 
WHERE cve_mat = :il_cve_mat  
AND gpo = :is_gpo 
AND periodo = :ie_periodo 
AND anio = :ie_anio 
USING itr_sce;  
IF itr_sce.SQLCODE < 0 THEN  
	is_error = "Se produjo un error al cargar la información del grupo: " + itr_sce.SQLERRTEXT 
	RETURN -1
ELSEIF itr_sce.SQLCODE = 100 THEN  
	RETURN 100
END IF 

INTEGER le_num_rgs, le_pos
INTEGER le_inicio, le_fin


ids_profesor.SETTRANSOBJECT(itr_sce) 
le_num_rgs = ids_profesor.RETRIEVE(il_cve_mat, is_gpo, ie_periodo, ie_anio) 

ids_horario.SETTRANSOBJECT(itr_sce) 
le_num_rgs = ids_horario.RETRIEVE(il_cve_mat, is_gpo, ie_periodo, ie_anio ) 

//// Se calculan las horas registradas en el horario 
//FOR le_pos = 1 TO le_num_rgs  
//	le_inicio = ids_horario.GETITEMNUMBER(le_pos, "hora_inicio") 
//	IF ISNULL(le_inicio) THEN le_inicio = 0 
//	le_fin	= ids_horario.GETITEMNUMBER(le_pos, "hora_final") 
//	IF ISNULL(le_fin) THEN le_fin = 0 
//	ie_horas_horario = ie_horas_horario + (le_fin - le_inicio)
//NEXT 


ids_horario_org.SETTRANSOBJECT(itr_sce)  
le_num_rgs = ids_horario_org.RETRIEVE(il_cve_mat, is_gpo, ie_periodo, ie_anio )   

ids_horario_profesor.SETTRANSOBJECT(itr_sce) 
le_num_rgs = ids_horario_profesor.RETRIEVE(il_cve_mat, is_gpo, ie_periodo, ie_anio)  

ids_grupo_sesion.SETTRANSOBJECT(itr_sce) 
le_num_rgs = ids_grupo_sesion.RETRIEVE(il_cve_mat, is_gpo, ie_periodo, ie_anio)  

ids_grupos_bloques.SETTRANSOBJECT(itr_sce) 
le_num_rgs = ids_grupos_bloques.RETRIEVE(il_cve_mat, is_gpo, ie_periodo, ie_anio)  


RETURN 0








end function

public function integer of_valida_horario (datastore ads_horario);
INTEGER ll_ttl_reg 
INTEGER ll_pos , ll_row_horario

LONG ll_cve_mat
STRING ls_gpo
INTEGER le_periodo
INTEGER le_anio
INTEGER le_cve_dia
STRING ls_cve_salon
INTEGER le_hora_inicio
INTEGER le_hora_final 
LONG ll_clase_aula

STRING ls_clase_aula_otro 

STRING ls_null
SETNULL(ls_null) 

BOOLEAN lb_es_salon_otro, lb_existe_salon  
STRING ls_clase_aula, ls_nombre_aula   
INTEGER li_bloqueado, li_obten_nombre_aula_clase_aula, valida_salon_horario 
BOOLEAN lb_salon_ocupado 
INTEGER li_cve_dia_val
INTEGER li_hora_inicio_val 
INTEGER le_clase_aula_comentario 
STRING ls_comentario 

IF ie_requiere_horario = 0 THEN RETURN 0 

// Se valida en primera instancia que se hayan capturado las horas completas.
//IF ie_horas_reales_tot_sem > ie_horas_totales THEN 
//	MESSAGEBOX("Error", "No se han capturado las horas mínimas necesarias para la materia.") 
//	RETURN -1
//ELSEIF ie_horas_reales_tot_sem < ie_horas_totales THEN 	
//	IF MESSAGEBOX("Error", "Las horas capturadas son superiores a las requeridas. ¿Desea continuar?", Question!, YesNo!)  = 2 THEN RETURN -1	
//END IF


of_carga_valida_exepciones(il_cve_mat)  

// Se verifica la forma en la que se imparte la materia. 
// TRADICIONAL
IF ie_forma_imparte = 1 THEN 

	IF ie_horas_reales_tot_sem <> ie_horas_totales THEN  
		IF il_coordinacion = 9999 THEN 
			IF MESSAGEBOX("Aviso", "Las horas capturadas no corresponden con las horas requeridas. ~r ¿Desea Continuar?", QUESTION!, YesNo!)  = 2 THEN RETURN -1
		ELSE	
			MESSAGEBOX("Error", "Las horas capturadas no corresponden con las horas requeridas.")  
			RETURN -1
		END IF 	
	END IF

// MODULAR 
ELSE
	//IF ie_horas_reales_tot_per <> ie_horas_totales_capt AND ie_horas_minimas  = 1 THEN 
	IF ie_horas_reales_tot_per <> ie_horas_totales_capt  THEN 
		IF il_coordinacion = 9999 THEN 
			IF MESSAGEBOX("Aviso", "Las horas capturadas no corresponden con las horas requeridas. ~r ¿Desea Continuar?", QUESTION!, YesNo!)  = 2 THEN RETURN -1
		ELSE	
			MESSAGEBOX("Error", "Las horas capturadas no corresponden con las horas requeridas.")  
			RETURN -1
		END IF
	END IF	
END IF



ll_ttl_reg = Ids_horario.ROWCOUNT() 

// Se hace ciclo para validar el Horario capturado. 
FOR ll_pos = 1 TO ll_ttl_reg 

	ll_cve_mat	= ids_horario.GETITEMNUMBER(ll_pos, "cve_mat") 
	ls_gpo	= ids_horario.GETITEMSTRING(ll_pos, "gpo")	 
	le_periodo	= ids_horario.GETITEMNUMBER(ll_pos, "periodo")	  
	le_anio	= ids_horario.GETITEMNUMBER(ll_pos, "anio")	 
	le_cve_dia	= ids_horario.GETITEMNUMBER(ll_pos, "cve_dia")	 
	ls_cve_salon	= ids_horario.GETITEMSTRING(ll_pos, "cve_salon")	  
	le_hora_inicio	= ids_horario.GETITEMNUMBER(ll_pos, "hora_inicio")	 
	le_hora_final	= ids_horario.GETITEMNUMBER(ll_pos, "hora_final")	 
	ll_clase_aula	= ids_horario.GETITEMNUMBER(ll_pos, "clase_aula")
	//le_clase_aula_comentario = ids_horario.GETITEMNUMBER(ll_pos, "clase_aula_comentario")
	ls_comentario = ids_horario.GetItemString(ll_pos,"comentario")  
	
	valida_salon_horario  = of_salon_horario(ls_cve_salon)
	IF valida_salon_horario < 0 THEN valida_salon_horario = 1 
	
	
	//Si tiene una cadena vacía, le asigna el valor de nulo
	IF ls_cve_salon= "" THEN 
		ids_horario.SetItem(ll_pos, "cve_salon", ls_null)
	END IF 
	
	//El dia de la semana es obligatorio
	IF isnull(le_cve_dia) THEN 
		MessageBox("Horario sin día de la semana", "Existe un horario sin día de la semana capturado.",StopSign!)		 
		return -1	
	END IF 

	//La clase de aula es obligatoria
	IF isnull(ll_clase_aula) THEN
		MessageBox("Horario sin clase de aula", "Existe un horario sin clase de aula capturado.",StopSign!)		
		return -1	
	END IF 
	
	// Si es clase aula "otro", valida el comentario 
	IF ll_clase_aula = 3 THEN 
	//IF le_clase_aula_comentario = 1 THEN 
		
		IF ISNULL(ls_comentario) THEN ls_comentario = "N" 
		IF LEN(TRIM(ls_comentario)) < 4 THEN 
			MessageBox("Descripción de Aula", &		
   		         "La descripción de aula para tipo 'Otro' debe tener al menos 4 caracteres.",StopSign!)					
			return -1						
		END IF
	END IF	
	
	
	
	//La hora inicial es obligatoria
	IF isnull(le_hora_inicio) THEN 
		MessageBox("Horario sin hora inicial", "Existe algun horario sin la hora inicial capturada, tal vez necesite dar [Enter] o [Tab] en dicho campo.",StopSign!)		
		return -1	
	ELSEIF le_hora_inicio >21 or le_hora_inicio < 7 THEN
		MessageBox("Hora inicial fuera de rango", "La hora inicial solo puede estar entre 7 y 21.",StopSign!)		
		return -1			
	END IF 

	//La hora final es obligatoria	
	IF isnull(le_hora_final) THEN 
		MessageBox("Horario sin hora final", "Existe algun horario sin la hora final capturada, tal vez necesite dar [Enter] o [Tab] en dicho campo.",StopSign!)		 
		return -1	
	ELSEIF le_hora_final >22 or le_hora_final < 8 THEN  
		MessageBox("Hora final fuera de rango", "La hora final solo puede estar entre 8 y 22.",StopSign!)		 
		return -1			
	END IF 
	
	IF le_hora_inicio >= le_hora_final THEN 
		MessageBox("Horario Inválido", "La hora Inicial no puede ser posterior o igual a la hora final",StopSign!)		  
		return -1	
	END IF

	//Verifica si el aula es de "OTROS" tipos, como cubículo,almace, bodega, consultorio, etc.	
	ls_clase_aula_otro = "" 
	lb_es_salon_otro= of_es_salon_otro(ls_cve_salon, ls_clase_aula_otro)
	
	//Busca el salon escrito, obtiene su clase de aula y si esta bloqueado o no	
	ls_clase_aula = "" 
	lb_existe_salon = of_existe_salon(ls_cve_salon, ls_clase_aula, li_bloqueado)
	//	El salon no existe, solo manda el error cuando se escribió algo en la columna de salón
	IF NOT lb_existe_salon AND NOT isnull(ls_cve_salon) AND (ls_cve_salon <> "") THEN
		MessageBox("Horario con salon inexistente", "Existe algun horario con un salon inexistente, "+ls_cve_salon+ " tal vez necesite dar [Enter] o [Tab] en dicho campo.",StopSign!)		
		return -1		
	// Se agrega validación de modo de operación para que en grupos-cambios no valide que se haya capturado un salón por parte del coordinador.	
	ELSEIF lb_existe_salon AND il_coordinacion <> 9999 and ls_clase_aula = "SALON" AND ie_modo_opera = 1 AND ib_modifica_salon THEN
			MessageBox("Horario con salon invalido", "Solo puede elegir laboratorios, talleres y especiales, tal vez necesite dar [Enter] o [Tab] en dicho campo.",StopSign!)		
			return -1				
	END IF 

	//Asigna la cadena vacía a la clase del aula	
	if isnull(ls_clase_aula) then
		ls_clase_aula = ""
	end if
	
//Busca si el salon ya se asignó en otro horario o para otro grupo
	if	ls_clase_aula <> "TALLER" then	
		// Se verifica si el salón requiere validación de Horario
		IF  valida_salon_horario = 1 THEN 
			lb_salon_ocupado= of_salon_hora_usado_bloque(ll_cve_mat, ls_gpo, le_periodo, le_anio, le_cve_dia, ls_cve_salon, le_hora_inicio, DATETIME(idt_fecha_inicio), DATETIME(idt_fecha_fin)) 
			if lb_salon_ocupado and (not isnull(ls_cve_salon) and (ls_cve_salon<>"")) then 
				MessageBox("Salon ocupado en algún horario", &		
						"Existe algun horario con el salon "+ls_cve_salon +" previamente ocupado en las horas escritas, tal vez necesite dar [Enter] o [Tab] en dicho campo.",StopSign!)		
				return -1		
			end if
		END IF 
	end if
	
	//Si se capturó un salon	
	IF NOT (isnull(ls_cve_salon)) AND (ls_cve_salon<>"") THEN 
		//Obtiene el nombre del salon para la clase de aula en cuestión
		li_obten_nombre_aula_clase_aula = of_obten_nombre_aula_clase_aula(ll_clase_aula, ls_nombre_aula)
		IF li_obten_nombre_aula_clase_aula <> 0 THEN
			MessageBox("Clase de aula invalida", "Favor de revisar la clase de aula ["+string(ll_clase_aula) +"].",StopSign!)		
			return -1				
		END IF 
		
		//Si la clase de aula no corresponde con el nombre del aula
		IF (pos(ls_clase_aula, ls_nombre_aula)= 0 AND pos(ls_nombre_aula, ls_clase_aula)= 0) AND NOT(lb_es_salon_otro AND ll_clase_aula = 3) THEN
			MessageBox("Clase de aula incongruente", "El salon "+ls_cve_salon +" no corresponde con la clase de aula seleccionada.",StopSign!)		
			return -1						
		END IF
	END IF 

	//Si el salón está bloqueado
	if li_bloqueado = 1 then
		MessageBox("Salon bloqueado", "Existe algun horario con el salon " + ls_cve_salon + " marcado como bloqueado, tal vez necesite dar [Enter] o [Tab] en dicho campo.", StopSign!) 
		return -1				
	end if 

	//Si el horario se duplicó	
	For ll_row_horario = 1 To ids_horario.RowCount()
		li_cve_dia_val 		= ids_horario.GetItemNumber(ll_row_horario,"cve_dia")
		li_hora_inicio_val	= ids_horario.GetItemNumber(ll_row_horario,"hora_inicio")
		if ll_row_horario <> ll_pos then		
			if li_cve_dia_val = le_cve_dia and li_hora_inicio_val= le_hora_inicio then
				MessageBox("Existe un horario con el mismo dia y hora de inicio",  "El dia: "+STRING(le_cve_dia)+" se encuentra repetido con la hora: "+string(li_hora_inicio_val),StopSign!)						
				return -1
			end if
		end if	
	Next
//	If wf_existe_hor_duplicado(li_cve_dia, li_hora_inicio, ll_row_horario) then
//		ls_dia =f_obten_dia(li_cve_dia)
//		MessageBox("Existe un horario con el mismo dia y hora de inicio", &		
//            "El dia: "+ls_dia+" se encuentra repetido con la hora: "+string(li_hora_inicio),StopSign!)		
//		dw_horario.ScrollToRow(ll_row_horario)
//		return -1
//	End If 

////Si el horario se encima 
//	If wf_existe_hor_encimado(li_cve_dia, li_hora_inicio, li_hora_final, ll_row_horario) then
//		ls_dia =f_obten_dia(li_cve_dia)
//		MessageBox("Existe un horario que se encima", &		
//            "El dia: "+ls_dia+" se encuentra encimado en la hora: "+string(li_hora_inicio),StopSign!)		
//		dw_horario.ScrollToRow(ll_row_horario)
//		return -1
//	End If
//	
////	If	f_doble_presencia_profesor(ll_cve_mat, ls_gpo, li_periodo, li_anio, &
////		ll_cve_profesor,li_cve_dia, li_hora_inicio,li_hora_final,ls_grupos_doble_presencia) then
////		ls_dia =f_obten_dia(li_cve_dia)
////		MessageBox("Existe un horario que se encima al profesor "+string(ll_cve_profesor), &		
////            "El dia: "+ls_dia+" se encuentra encimado en la hora: "+string(li_hora_inicio)+"~nEn el(los) siguiente(s) grupo(s):~n"+ls_grupos_doble_presencia,StopSign!)		
////		dw_horario.ScrollToRow(ll_row_horario)
////		
////		return -1
////Obtiene la categoría del profesor
//	li_cve_categoria = f_obten_categoria_profesor(ll_cve_profesor)
//	if li_cve_categoria= -1 then
//		MessageBox("Error en consulta de categoria", &		
//	            "No es posible consultar la categoria del profesor capturado",StopSign!)			
//	end if//	End If
//
//
////Valida que el profesor no esté impartiendo clases a la misma hora
//	If	f_doble_presencia_profesor03(ll_cve_mat, ls_gpo, li_periodo, li_anio, &
//		ll_cve_profesor,li_cve_dia, li_hora_inicio,li_hora_final,ls_grupos_doble_presencia) then
//		ls_dia =f_obten_dia(li_cve_dia)
//		MessageBox("Existe un horario que se encima al profesor "+string(ll_cve_profesor), &		
//            "El dia: "+ls_dia+" se encuentra encimado en la hora: "+string(li_hora_inicio)+"~nEn el(los) siguiente(s) grupo(s):~n"+ls_grupos_doble_presencia,StopSign!)		
//		dw_horario.ScrollToRow(ll_row_horario)
//		return -1
//		
////		if li_cve_categoria <> 3 then
////			return -1
////		end if	
//		
//	End If

	//No permitir que se asigne un salon a un grupo que en clase aula sea diferente a salon
	if	ll_clase_aula <> 0 and ls_clase_aula = "SALON" then		
			MessageBox("Salon invalido asignado",  "La clase de aula elegida, no permite asignar un SALON, tal vez necesite dar [Enter] o [Tab] en dicho campo.",StopSign!)		
			return -1			
	end if

	//Si es un Taller
	if	ll_clase_aula = 1 then		
		//Es necesario especificar en que Taller se llevará a cabo la clase (cve_salon)
		if isnull(ls_cve_salon) OR (ls_cve_salon = "") then
			MessageBox("Taller invalido asignado", "Para la clase de aula elegida, es necesario asignar el Taller correspondiente en la columna Salón, ~ntal vez necesite dar [Enter] o [Tab] en dicho campo.",StopSign!)		
			return -1	
		end if
	end if

	//Si es un Laboratorio
	if	ll_clase_aula = 2 then		
	//Es necesario especificar en que Laboratorio se llevará a cabo la clase (cve_salon)
		if isnull(ls_cve_salon) OR (ls_cve_salon = "") then
			MessageBox("Laboratorio invalido asignado", "Para la clase de aula elegida, es necesario asignar el Laboratorio correspondiente en la columna Salón, ~ntal vez necesite dar [Enter] o [Tab] en dicho campo.", StopSign!)		
			return -1	
		end if
	end if
	
////2014-05-23 Si el aula es 4-POR ASIGNAR	debe haber derecho en la matriz para ese dia-horas
////2014-06-25 Si el aula es 3-OTRO	debe haber derecho en la matriz para ese dia-horas
//	if li_clase_aula = 4 OR li_clase_aula = 3 then
//		lb_horario_por_asignar_valido =f_horario_por_asignar_valido (li_cve_dia, li_hora_inicio , li_hora_final)
//		if lb_horario_por_asignar_valido then
////			Messagebox("OK", "HORARIO VALIDO", iNFORMATION!)
//		else
//			Messagebox("Horario por asignar Inválido", "No es posible registrar horarios POR ASIGNAR/OTRO en este día-hora,  ~ntal vez necesite dar [Enter] o [Tab] en dicho campo.", StopSign!)
//			return -1
//		end if	
//	end if	
	
	
	
	
	
	
	
	
NEXT 


RETURN 0 






end function

public function integer of_inicializa_parametros ();
// Se cargan los parámetros de validación de grupos. 

// Profesor obligatorio Bloques
SELECT valor 
INTO :ie_prof_obligatorio 
FROM grupos_parametros 
WHERE cve_parametro = 1
USING itr_sce;  
IF itr_sce.SQLCODE < 0 THEN  
	MESSAGEBOX("Error", "Se produjo un error al recuperar el parámetro de Profesor obligatorio Bloques:" + itr_sce.SQLERRTEXT )
	RETURN -1
END IF  

// Cubrir Horario Completo Bloques
SELECT valor 
INTO :ie_horario_completo 
FROM grupos_parametros 
WHERE cve_parametro = 2
USING itr_sce;  
IF itr_sce.SQLCODE < 0 THEN  
	MESSAGEBOX("Error", "Se produjo un error al recuperar el parámetro de Cubrir Horario Completo Bloques:" + itr_sce.SQLERRTEXT )
	RETURN -1	
END IF 

// Multiples profesores para Grupo Tradicional
SELECT valor 
INTO :ie_multiples_prof_trad 
FROM grupos_parametros 
WHERE cve_parametro = 3
USING itr_sce;  
IF itr_sce.SQLCODE < 0 THEN  
	MESSAGEBOX("Error", "Se produjo un error al recuperar el parámetro de Multiples profesores para Grupo Tradicional:" + itr_sce.SQLERRTEXT )
	RETURN -1
END IF 

// Detalle de Horario de Profesores
SELECT valor 
INTO :ie_horario_prof  
FROM grupos_parametros WHERE cve_parametro = 4 
USING itr_sce;  
IF itr_sce.SQLCODE < 0 THEN  
	MESSAGEBOX("Error", "Se produjo un error al recuperar el parámetro de Detalle de Horario de Profesores: " + itr_sce.SQLERRTEXT )
	RETURN -1
END IF 




ids_profesor = CREATE DATASTORE 
ids_profesor.DATAOBJECT = "dw_profesor_cotitular_servicio"

ids_horario = CREATE DATASTORE  
ids_horario.DATAOBJECT = "dw_horario_bloque_serv" 

ids_horario_org = CREATE DATASTORE  
ids_horario_org.DATAOBJECT = "dw_horario_bloque_serv" 

ids_paquete_horario = CREATE DATASTORE 
ids_paquete_horario.DATAOBJECT = "dw_grupos_paquetes_horario"

ids_horario_profesor = CREATE DATASTORE 
ids_horario_profesor.DATAOBJECT = "dw_horario_prof_grupo"

ids_grupos_valida_exepcion = CREATE DATASTORE 
ids_grupos_valida_exepcion.DATAOBJECT = "dw_grupos_valida_exepcion" 

ids_grupo_sesion = CREATE DATASTORE 
ids_grupo_sesion.DATAOBJECT = "dw_horario_modular" 

ids_grupos_bloques = CREATE DATASTORE 
ids_grupos_bloques.DATAOBJECT = "dw_fechas_modular" 


RETURN 0 







end function

public function integer of_valida_profesor ();
INTEGER le_total, le_pos 
LONG ll_cve_profesor
INTEGER le_titularidad
DATETIME ldt_fecha_inicio
DATETIME ldt_fecha_fin

INTEGER le_total_titular
INTEGER le_error
INTEGER le_horas_profesor

le_total = ids_profesor.ROWCOUNT() 

// Se verifica que se hayan capturado profesores.  
IF le_total = 0 THEN 
	is_error = "No se han capturado profesores."
	le_error = 1			
	RETURN -1
END IF

// Si es un grupo tradicional y no se permite múltiples profesores. 
//IF ie_forma_imparte = 1 AND ie_multiples_prof_trad = 0 AND le_total > 0 THEN  
//	is_error = "En grupos tradicionales no se permiten múltiples profesores."
//	le_error = 1		
//END IF 	


FOR le_pos = 1 TO le_total   
	
	ll_cve_profesor = ids_profesor.GETITEMNUMBER(le_pos, "cve_profesor") 
	IF ISNULL(ll_cve_profesor) THEN 
		is_error = "No se han caturado todos los profesores."
		le_error = 1
		EXIT
	END IF
	
	le_titularidad = ids_profesor.GETITEMNUMBER(le_pos, "titularidad") 
	IF ISNULL(le_titularidad) THEN le_titularidad =  0
	le_total_titular = le_total_titular + le_titularidad
	
	ldt_fecha_inicio = ids_profesor.GETITEMDATETIME(le_pos, "fecha_inicio") 
	ldt_fecha_fin = ids_profesor.GETITEMDATETIME(le_pos, "fecha_fin")	 
	
	IF 	DATE(ldt_fecha_inicio) < DATE(idt_inicio_periodo) OR DATE(ldt_fecha_inicio) > DATE(idt_fin_periodo) THEN 
		is_error = "La fecha de inicio del profesor " + STRING(ll_cve_profesor) + " no es válida. "
		le_error = 1
		EXIT		
	ELSEIF DATE(ldt_fecha_fin) < DATE(idt_inicio_periodo) OR DATE(ldt_fecha_fin) > DATE(idt_fin_periodo) THEN 
		is_error = "La fecha de fin del profesor " + STRING(ll_cve_profesor) + " no es válida. "
		le_error = 1
		EXIT			
	ELSEIF DATE(ldt_fecha_inicio) >= DATE(idt_fin_periodo) THEN 
		is_error = "El rango de fechas del profesor " + STRING(ll_cve_profesor) + " no es válida. " 
		le_error = 1
		EXIT				
	ELSEIF ISNULL(ldt_fecha_inicio) OR ISNULL(ldt_fecha_fin) THEN 	
		is_error = "Hay fechas inválidas en el detalle de profesores."
		le_error = 1
		EXIT					
	END IF 


NEXT 

IF le_total_titular = 0 THEN 
	is_error = "No se ha especificado un profesor Titular." 
	le_error = 1	
END IF

IF le_error = 1 THEN 	RETURN -1

RETURN 0 












end function

public function integer of_inserta_horario ();
LONG ll_cve_mat	
STRING ls_gpo	
INTEGER le_periodo	
INTEGER le_anio	
INTEGER le_cve_dia	
STRING ls_cve_salon	
INTEGER le_hora_inicio	
INTEGER le_hora_final	
LONG ll_clase_aula

LONG ll_ttl_reg, ll_pos
STRING ls_comentario


DELETE FROM horario 
WHERE cve_mat = :il_cve_mat 
AND gpo = :is_gpo 
AND periodo = :ie_periodo 
AND anio = :ie_anio 
USING itr_sce; 
IF itr_sce.SQLCODE < 0 THEN 
	is_error = " Se produjo un error al borrar los datos de horario anteriores: " + itr_sce.sqlerrtext  
	ROLLBACK USING itr_sce; 
	RETURN -1
END IF 


ll_ttl_reg = Ids_horario.ROWCOUNT() 

FOR ll_pos = 1 TO ll_ttl_reg 

	ll_cve_mat	= Ids_horario.GETITEMNUMBER(ll_pos, "cve_mat") 
	ls_gpo	= Ids_horario.GETITEMSTRING(ll_pos, "gpo")	 
	le_periodo	= Ids_horario.GETITEMNUMBER(ll_pos, "periodo")	  
	le_anio	= Ids_horario.GETITEMNUMBER(ll_pos, "anio")	 
	le_cve_dia	= Ids_horario.GETITEMNUMBER(ll_pos, "cve_dia")	 
	ls_cve_salon	= Ids_horario.GETITEMSTRING(ll_pos, "cve_salon")	  
	le_hora_inicio	= Ids_horario.GETITEMNUMBER(ll_pos, "hora_inicio")	 
	le_hora_final	= Ids_horario.GETITEMNUMBER(ll_pos, "hora_final")	 
	ll_clase_aula	= Ids_horario.GETITEMNUMBER(ll_pos, "clase_aula")
	ls_comentario = Ids_horario.GETITEMSTRING(ll_pos, "comentario") 
	
	
	INSERT INTO horario (cve_mat, gpo, periodo, anio, cve_dia, cve_salon, hora_inicio, hora_final, clase_aula, comentario)
	VALUES (:ll_cve_mat, :ls_gpo, :le_periodo, :le_anio, :le_cve_dia, :ls_cve_salon, :le_hora_inicio, :le_hora_final, :ll_clase_aula, :ls_comentario)  
	USING  itr_sce; 	
	
	IF itr_sce.SQLCODE < 0 THEN 
		is_error = " Se produjo un error al insertar los datos de horario: " + itr_sce.sqlerrtext   
		ROLLBACK USING itr_sce; 
		RETURN -1
	END IF 	
	
NEXT 


RETURN 0 










end function

public function integer of_inserta_profesor ();INTEGER le_pos 

LONG ll_cve_profesor
INTEGER le_titularidad
DATETIME ldt_fecha_inicio
DATETIME ldt_fecha_fin
INTEGER le_horas_totales 
INTEGER le_tipo_profesor 
INTEGER le_estatus_profesor 
STRING ls_evalua 

DELETE FROM profesor_cotitular 
WHERE cve_mat = :il_cve_mat 
AND gpo = :is_gpo 
AND periodo = :ie_periodo 
AND anio = :ie_anio 
USING itr_sce; 

// Se pasa el detalle de profesores.
FOR le_pos = 1 TO ids_profesor.ROWCOUNT() 

	ll_cve_profesor = ids_profesor.GETITEMNUMBER(le_pos, "cve_profesor") 
	le_titularidad = ids_profesor.GETITEMNUMBER(le_pos, "titularidad")	
	IF ISNULL(le_titularidad) THEN le_titularidad = 0 
	ldt_fecha_inicio = ids_profesor.GETITEMDATETIME(le_pos, "fecha_inicio")	
	ldt_fecha_fin = ids_profesor.GETITEMDATETIME(le_pos, "fecha_fin")	 
	le_horas_totales = ids_profesor.GETITEMNUMBER(le_pos, "horas_totales_grupo")   
	le_tipo_profesor = ids_profesor.GETITEMNUMBER(le_pos, "tipo_profesor")   
	IF ISNULL(le_tipo_profesor) THEN le_tipo_profesor = 1 
	le_estatus_profesor = ids_profesor.GETITEMNUMBER(le_pos, "autorizado")   
	IF ISNULL(le_estatus_profesor) THEN le_estatus_profesor = 0 
	ls_evalua = ids_profesor.GETITEMSTRING(le_pos, "evalua")  
	IF ISNULL(ls_evalua) THEN ls_evalua = "S" 
	

	INSERT INTO profesor_cotitular(cve_mat, gpo, periodo, anio, cve_profesor, titularidad, fecha_inicio, fecha_fin, horas_totales_grupo, 
											tipo_profesor, autorizado, evalua )   
	VALUES (:il_cve_mat, :is_gpo, :ie_periodo, :ie_anio, 
				:ll_cve_profesor, :le_titularidad, :ldt_fecha_inicio, :ldt_fecha_fin, :le_horas_totales, 
				:le_tipo_profesor, :le_estatus_profesor, :ls_evalua) 

	USING itr_sce; 
	IF itr_sce.SQLCODE < 0 THEN 
		is_error = "Se produjo un error al insertar el profesor asociado al grupo:" + itr_sce.SQLERRTEXT 
		ROLLBACK USING itr_sce;
		RETURN -1 
	END IF
	
NEXT 


RETURN 0 


end function

public function integer of_actualiza ();
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Se verifica si se puede apartar el aula audiovisual. 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////	 
INTEGER le_valida_audiovisual
////il_cve_mat, is_gpo, il_cve_profesor
iuo_grupos_multiplantel = CREATE uo_grupos_multiplantel
le_valida_audiovisual = iuo_grupos_multiplantel.of_cancela_apartado(il_cve_mat, is_gpo)  
//li_tipo = object.tipo[THIS.GETROW()]

IF ie_tipo = 5 THEN 
	//iuo_grupos_multiplantel = CREATE uo_grupos_multiplantel
	iuo_grupos_multiplantel.ie_periodo = ie_periodo
	iuo_grupos_multiplantel.ie_anio = ie_anio
	iuo_grupos_multiplantel.of_inserta_valida_aula_bloque(il_cve_mat, is_gpo, ids_horario, itr_sce)
	le_valida_audiovisual = iuo_grupos_multiplantel.of_valida_nuevo_grupo(il_cve_mat, is_gpo )
	
	IF le_valida_audiovisual = 0 THEN 
		//MESSAGEBOX("Aviso", iuo_grupos_multiplantel.is_ocupado)
		MESSAGEBOX("Aviso", "El aula audiovisual no está disponible.")
		DESTROY iuo_grupos_multiplantel 
		RETURN -1 
	ELSEIF le_valida_audiovisual < 0 THEN 		
		MESSAGEBOX("Aviso", "Se produjo un error al validar apartado de aula multimedia.")
		DESTROY iuo_grupos_multiplantel 
		RETURN -1 	
	END IF	
	DESTROY iuo_grupos_multiplantel 
END IF 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////


// Se actualiza el maestro.
IF of_inserta_grupo() < 0 THEN 
	RETURN -1 
END IF 

// Se inserta el detalle de Horario	
//IF ie_requiere_horario = 1 THEN 
	IF of_inserta_horario() < 0 THEN 
		RETURN -1 
	END IF 
//END IF

// Inserta el detalle de Profesores.
IF of_inserta_profesor() < 0 THEN 
	RETURN -1 
END IF 

IF ie_requiere_horario = 1 THEN 
	// Inserta el horario de profesores
	IF of_inserta_profesor_horario() < 0 THEN 
		RETURN -1 
	END IF 
END IF

IF ie_requiere_horario = 1 THEN 
	// Inserta el horario de profesores
	IF of_inserta_horario_modular() < 0 THEN 
		RETURN -1 
	END IF 
END IF




///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Se verifica si se puede apartar el aula audiovisual. 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////	
IF NOT ISVALID(iuo_grupos_multiplantel) THEN iuo_grupos_multiplantel = CREATE uo_grupos_multiplantel 
//INTEGER le_valida_audiovisual 

//le_valida_audiovisual = iuo_grupos_multiplantel.of_cancela_apartado(ll_cve_mat, ls_gpo)  
//li_tipo = object.tipo[THIS.GETROW()]

IF ie_tipo = 5 THEN 
	
	//ll_cve_prof= LONG(uo_3.em_cve_profesor.text) 
	
	le_valida_audiovisual = iuo_grupos_multiplantel.of_inserta_apartado(il_cve_mat, is_gpo, il_cve_profesor)
	
	IF le_valida_audiovisual < 0 THEN 		
		MESSAGEBOX("Aviso", "Se produjo un error al validar apartado de aula multimedia.")
		ROLLBACK USING itr_sce;
		DESTROY iuo_grupos_multiplantel 
		RETURN -1 	
	END IF	
	
END IF 
DESTROY iuo_grupos_multiplantel 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////				


COMMIT USING itr_sce; 




RETURN 0 







end function

public function integer of_inserta_grupo_paquete (); 
// grupos_paquetes 
LONG id_paquete
STRING descripcion
LONG cve_coordinacion
INTEGER periodo
INTEGER anio

// Si el id paquete = 0 se trata de uno NUEVO 
IF il_id_paquete = 0 THEN 

	SELECT MAX(id_paquete)  
	INTO :il_id_paquete 	
	FROM grupos_paquetes 
	USING itr_sce; 
	IF ISNULL(il_id_paquete) THEN il_id_paquete = 0 

	il_id_paquete ++	

	INSERT INTO grupos_paquetes(id_paquete, descripcion, cve_coordinacion, periodo, anio) 
	VALUES(:il_id_paquete, :is_descripcion_paq, :il_cve_coordinacion_paq, :ie_periodo_paq, :ie_anio_paq) 
	USING itr_sce;
	IF itr_sce.SQLCODE < 0 THEN 
		is_error = "Se produjo un error al insertar el paquete: " + itr_sce.SQLERRTEXT 
		ROLLBACK USING itr_sce; 
		RETURN -1 
	END IF
	
ELSE

	UPDATE 	grupos_paquetes 
	SET descripcion = :is_descripcion_paq, 
		cve_coordinacion = :il_cve_coordinacion_paq, 
		periodo = :ie_periodo_paq, 
		anio = :ie_anio_paq	
	WHERE id_paquete = :il_id_paquete 
	USING itr_sce; 
	IF itr_sce.SQLCODE < 0 THEN 
		is_error = "Se produjo un error al actualizar el paquete: " + itr_sce.SQLERRTEXT 
		ROLLBACK USING itr_sce; 
		RETURN -1 
	END IF	

END IF

INTEGER le_pos, le_ttl
LONG ll_cve_materia_paq 
INTEGER le_hora_inicio_paq
INTEGER le_hora_fin_paq
INTEGER le_cve_dia_paq

DELETE FROM grupos_paquetes_horario 
WHERE id_paquete = :il_id_paquete  
USING itr_sce; 

le_ttl = ids_paquete_horario.ROWCOUNT() 

FOR le_pos = 1 TO le_ttl

	ll_cve_materia_paq = ids_paquete_horario.GETITEMNUMBER(le_pos, "cve_materia")
	le_hora_inicio_paq = ids_paquete_horario.GETITEMNUMBER(le_pos, "hora_inicio") 
	le_hora_fin_paq = ids_paquete_horario.GETITEMNUMBER(le_pos, "hora_fin") 
	le_cve_dia_paq = ids_paquete_horario.GETITEMNUMBER(le_pos, "cve_dia") 

	INSERT INTO grupos_paquetes_horario (id_paquete, cve_materia, hora_inicio, hora_fin, cve_dia)
	VALUES (:il_id_paquete, :ll_cve_materia_paq, :le_hora_inicio_paq, :le_hora_fin_paq, :le_cve_dia_paq) 
	USING itr_sce; 
	IF itr_sce.SQLCODE < 0 THEN 
		is_error = "Se produjo un error al insertar el horario del paquete: " + itr_sce.SQLERRTEXT  
		ROLLBACK USING itr_sce; 
		RETURN -1 
	END IF


NEXT 

COMMIT USING itr_sce;

RETURN 0




end function

public function integer of_carga_grupo_paquete ();

SELECT descripcion, cve_coordinacion, periodo, anio 
INTO :is_descripcion_paq, :il_cve_coordinacion_paq, :ie_periodo_paq, :ie_anio_paq 
FROM grupos_paquetes
WHERE id_paquete = :il_id_paquete 
USING itr_sce;
IF itr_sce.SQLCODE < 0 THEN 
	is_error = "Se produjo un error al recuperar el paquete: "	+ itr_sce.SQLERRTEXT 
	RETURN -1 	
END IF


ids_paquete_horario.SETTRANSOBJECT(itr_sce) 
IF ids_paquete_horario.RETRIEVE() < 0 THEN 
	is_error = "Se produjo un error al recuperar el horario del paquete: "	+ itr_sce.SQLERRTEXT 
	RETURN -1 		
END IF 


RETURN 0 





end function

public function integer of_valida_horas ();
INTEGER le_pos 
INTEGER le_ttl_mat

INTEGER le_hora_inicial 
INTEGER le_hora_final 
INTEGER le_diferencia
INTEGER le_horas_semana


LONG ll_cve_materia_paq 
INTEGER le_cve_dia_paq 
LONG ll_mat_anterior
INTEGER le_horas

//IF ie_requiere_horario = 0 THEN RETURN 0 

ids_paquete_valida_hora.SETSORT("cve_materia asc")  
ids_paquete_valida_hora.SORT() 

le_ttl_mat = ids_paquete_valida_hora.ROWCOUNT() 


FOR le_pos = 1 TO le_ttl_mat 

	ll_cve_materia_paq = ids_paquete_valida_hora.GETITEMNUMBER(le_pos, "cve_materia")
	IF le_pos = 1 THEN ll_mat_anterior = ll_cve_materia_paq 
	
	IF ll_mat_anterior <> ll_cve_materia_paq THEN 
		
		SELECT horas_reales 
		INTO :le_horas 
		FROM materias 
		WHERE cve_mat = :ll_cve_materia_paq 
		USING itr_sce; 
		IF itr_sce.SQLCODE < 0 THEN 
			is_error = "Las horas asignadas a la materia " + STRING(ll_mat_anterior) + " no pueden ser menores a " + STRING(le_horas) 
			RETURN -1
		END IF 			
		
		IF le_horas_semana < le_horas THEN 
			is_error = "Las horas asignadas a la materia " + STRING(ll_mat_anterior) + " no pueden ser menores a " + STRING(le_horas) 
			RETURN -1
		END IF 	
		
		le_horas_semana = 0 
		ll_mat_anterior = ll_cve_materia_paq 
		
	END IF	
	
	le_hora_inicial = ids_paquete_valida_hora.GETITEMNUMBER(le_pos, "hora_inicio") 
	le_hora_final = ids_paquete_valida_hora.GETITEMNUMBER(le_pos, "hora_fin") 
	le_cve_dia_paq = ids_paquete_valida_hora.GETITEMNUMBER(le_pos, "cve_dia")  	
 
	le_diferencia = le_hora_final - le_hora_final
	le_horas_semana = le_horas_semana + le_diferencia

NEXT 

RETURN 0 









end function

public function integer of_nuevo ();
DATETIME ldt_lmp

// GRUPOS 
is_gpo = "" 
ie_periodo = 0
ie_anio = 0
ie_cond_gpo = 0
ie_cupo = 0
ie_tipo = 0
ie_inscritos = 0
ie_insc_desp_bajas = 0
il_cve_asimilada = 0
is_gpo_asimilado = "" 
il_cve_profesor = 0 
id_prom_gpo = 0 
id_porc_asis = 0 
id_ema4 = 0 
ie_primer_sem = 0 
is_comentarios = "" 
il_demanda_inscritos = 0
ie_forma_imparte = 0
idt_fecha_inicio = ldt_lmp
idt_fecha_fin = ldt_lmp
il_idioma = 0

IF ISVALID(ids_profesor) THEN ids_profesor.RESET() 
IF ISVALID(ids_horario) THEN ids_horario.RESET() 
IF ISVALID(ids_paquete_horario) THEN ids_paquete_horario.RESET() 
IF ISVALID(ids_paquete_valida_hora) THEN ids_paquete_valida_hora.RESET()  
IF ISVALID(ids_grupo_sesion) THEN ids_grupo_sesion.RESET()  

IF ISVALID(ids_horario_org) THEN ids_horario_org.RESET() 
IF ISVALID(ids_horario_profesor) THEN ids_horario_profesor.RESET() 
IF ISVALID(ids_grupos_valida_exepcion) THEN ids_grupos_valida_exepcion.RESET() 
IF ISVALID(ids_grupos_bloques) THEN ids_grupos_bloques.RESET()  


// PAQUETES 
il_id_paquete = 0
is_descripcion_paq = "" 
il_cve_coordinacion_paq = 0
ie_periodo_paq = 0
ie_anio_paq = 0


is_error = "" 



RETURN 0 









end function

public function integer of_calcula_horas_reales ();

//SELECT horas_reales 
//INTO :le_horas_reales 
//FROM materias 
//WHERE cve_mat = :il_cve_mat 
//USING itr_sce; 
//IF itr_sce.SQLCODE < 0 THEN 
//	is_error = " Se produjo un error al recuperar las horas reales de la materia: " + itr_sce.SQLERRTEXT 
//	RETURN -1 
//END IF 

INTEGER le_horas_reales, le_semanas_semestre, le_horas_maximas 
DECIMAL ld_factor_ajuste_horas


//if not horas_materia(il_cve_mat, ie_periodo, le_horas_reales) then
//	MessageBox("Error al consultar materia", "No es posible consultar las horas de la materia: "+string(il_cve_mat),StopSign!)		
//	return -1
//end if
//
////le_horas_reales = ie_horas_reales_tot_sem 

//**--**--**--**--**--**--**--**--**--**--**

// Se recuperan las horas 
Select horas_reales
Into	:le_horas_reales
From	materias
Where	cve_mat = :il_cve_mat using gtr_sce;

//**--**--**--**--**--**--**--**--**--**--**

// Se recupera el factor de ajuste por periodo. 
SELECT  factor_horas_semana, factor_ajuste_horas
INTO :le_semanas_semestre, :ld_factor_ajuste_horas
FROM periodo_parametros
WHERE periodo = :ie_periodo
USING  itr_sce;
IF itr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuparar las horas permitidas para el periodo actual: " + itr_sce.SQLERRTEXT)
	RETURN -1
END IF

// El factor de ajuste solo se hace para grupos tradicionales. 
IF ie_forma_imparte = 1 THEN 
	// Se hace el ajuste de horas semanales permitidas.
	le_horas_reales = le_horas_reales * ld_factor_ajuste_horas  
END IF 	

//**//
// Las horas determinadas solo aplican para grupos modulares 
INTEGER le_horas_totales
IF ie_forma_imparte = 2 THEN 
	
	// Se verifica si la materia tiene establecido algún valor de horas por periodo.
	SELECT horas_totales 
	INTO :le_horas_totales
	FROM grupos_valida_exepcion 
	WHERE cve_mat = :il_cve_mat 
	USING  itr_sce;
	IF itr_sce.SQLCODE < 0 THEN 
		MESSAGEBOX("Error", "Se produjo un error al recuparar las horas para validación de la materia: " + itr_sce.SQLERRTEXT)
		RETURN -1
	END IF 
	IF ISNULL(le_horas_totales) THEN le_horas_totales = 0 
	// Si tiene asignado un valor regresa este como el determinado 
	//IF le_horas_totales > 0 THEN RETURN le_horas_totales 
	
END IF 	
//**//

// Se determinan las horas máximas 
ie_horas_reales_tot_sem = le_horas_reales 
le_horas_maximas = le_semanas_semestre * le_horas_reales 

IF le_horas_totales > 0 THEN
	ie_horas_reales_tot_per = le_horas_totales 
ELSE
	ie_horas_reales_tot_per = le_horas_maximas 
END IF	

ie_horas_totales_capt = le_semanas_semestre * ie_horas_totales

RETURN 0 


//
//INTEGER le_dias 
//INTEGER le_semanas_totales, le_semanas_modulo
//INTEGER le_horas_totales_cap
//INTEGER le_numero_grupos_dif 
//
//// TRADICIONAL 
//IF ie_forma_imparte = 1 THEN 
//
//	if not horas_materia(il_cve_mat, ie_periodo, ie_horas_reales_tot_sem) then
//		MessageBox("Error al consultar materia", "No es posible consultar las horas de la materia: "+string(il_cve_mat),StopSign!)		
//		return -1
//	end if
//
//// MODULAR
//ELSE 
//	
//	SELECT horas_reales 
//	INTO :ie_horas_reales 
//	FROM materias 
//	WHERE cve_mat = :il_cve_mat 
//	USING itr_sce; 
//	IF itr_sce.SQLCODE < 0 THEN 
//		is_error = " Se produjo un error al recuperar las horas reales de la materia: " + itr_sce.SQLERRTEXT 
//		RETURN -1 
//	END IF 
//	
//	// Se calculan las semanas en un periodo completo 
//	le_dias = DAYSAFTER(DATE(idt_inicio_periodo), DATE(idt_fin_periodo)) 
//	le_semanas_totales = TRUNCATE((le_dias/7), 0) 
//	
//	// Se calculan las horas reales Totales de la materia.
//	ie_horas_reales_tot = le_semanas_totales * ie_horas_reales 
//	
//	// Se calculan las semanas del curso modular.
//	le_dias = DAYSAFTER(DATE(idt_fecha_inicio), DATE(idt_fecha_fin)) 
//	le_semanas_modulo = TRUNCATE((le_dias/7), 0) 
//	
//	// Se calculan las horas totales capturadas.
//	IF le_semanas_modulo > 0 THEN 
//		ie_horas_reales_tot_sem = ie_horas_reales_tot/le_semanas_modulo     
//	ELSE
//		ie_horas_reales_tot_sem = 0 
//	END IF
//	
//	//le_horas_totales_cap = le_semanas * ie_horas_totales  
//	
//	// Se verifica si se cubren las horas requeridas.
//	IF ie_horas_totales < ie_horas_reales_tot_sem THEN 
//		is_error = "Las horas capturadas no cubren el mínio de horas requeridas. " 
//		RETURN -1 
//	ELSEIF ie_horas_totales > ie_horas_reales_tot_sem THEN  	
//		is_error = "Las horas capturadas sobrepasan las horas requeridas. "  
//		RETURN 1
//	END IF 
//	
//END IF
//
//RETURN 0 
//
//
//
//
//
//
//
//
//
end function

public function integer of_calcula_horas_semana ();LONG ll_cve_mat	
STRING ls_gpo	
INTEGER le_periodo	
INTEGER le_anio	
INTEGER le_cve_dia	
STRING ls_cve_salon	
INTEGER le_hora_inicio	
INTEGER le_hora_final	
LONG ll_clase_aula

LONG ll_ttl_reg, ll_pos 


INTEGER le_horas

ll_ttl_reg = Ids_horario.ROWCOUNT() 

ie_horas_totales = 0 

FOR ll_pos = 1 TO ll_ttl_reg 

//	ll_cve_mat	= Ids_horario.GETITEMNUMBER(ll_pos, "cve_mat") 
//	ls_gpo	= Ids_horario.GETITEMSTRING(ll_pos, "gpo")	 
//	le_periodo	= Ids_horario.GETITEMNUMBER(ll_pos, "periodo")	  
//	le_anio	= Ids_horario.GETITEMNUMBER(ll_pos, "anio")	 
//	le_cve_dia	= Ids_horario.GETITEMNUMBER(ll_pos, "cve_dia")	 
//	ls_cve_salon	= Ids_horario.GETITEMSTRING(ll_pos, "cve_salon")	  
	le_hora_inicio	= Ids_horario.GETITEMNUMBER(ll_pos, "hora_inicio")	 
	IF ISNULL(le_hora_inicio) THEN le_hora_inicio = 0 
	le_hora_final	= Ids_horario.GETITEMNUMBER(ll_pos, "hora_final")	 
	IF ISNULL(le_hora_final) THEN le_hora_final = 0
//	ll_clase_aula	= Ids_horario.GETITEMNUMBER(ll_pos, "clase_aula")

	le_horas = 	le_hora_final - le_hora_inicio 
	
	ie_horas_totales = ie_horas_totales + le_horas

NEXT 

IF ie_horas_totales < 0 THEN ie_horas_totales = 0 

RETURN 0 









//
//LONG ll_cve_mat	
//STRING ls_gpo	
//INTEGER le_periodo	
//INTEGER le_anio	
//INTEGER le_cve_dia	
//STRING ls_cve_salon	
//INTEGER le_hora_inicio	
//INTEGER le_hora_final	
//LONG ll_clase_aula
//
//LONG ll_ttl_reg, ll_pos 
//
//INTEGER le_horas
//
//ll_ttl_reg = Ids_horario.ROWCOUNT() 
//
//ie_horas_totales = 0 
//
//// Si se trata de un grupos modular 
//IF ie_forma_imparte = 2 THEN 
//
//
//	ie_horas_totales = of_calcula_horas_reales_sesiones_tot( )
//
//	/**********************************************************/
//	/**********************************************************/
////	// SE CALCULAN LAS HORAS CAPTURADAS DEL GRUPO SEGÚN LAS SESIONES CAPTURADAS. 
////	
////	INTEGER le_ttl_rgs 
////	INTEGER le_pos 
////	DATE ld_fecha_inicio 
////	DATE ld_fecha_fin  
////	DATE ld_fecha_evalua 
////	INTEGER le_dia_no_laborable 
////	INTEGER le_dia, le_horas_dia 
////	
////	
////	le_ttl_rgs = ids_grupo_sesion.ROWCOUNT() 
////	
////	of_carga_dias_no_laborables() 
////	
////	FOR le_pos = 1 TO le_ttl_rgs 
////		
////	//	ld_fecha_inicio = DATE(ids_verifica_horario_paso.GETITEMDATETIME(le_pos, "grupos_fecha_inicio"))  
////	//	ld_fecha_fin =  DATE(ids_verifica_horario_paso.GETITEMDATETIME(le_pos, "grupos_fecha_fin"))  
////		ld_fecha_inicio = DATE(ids_grupo_sesion.GETITEMDATETIME(le_pos, "fecha_inicio"))  
////		ld_fecha_fin =  DATE(ids_grupo_sesion.GETITEMDATETIME(le_pos, "fecha_fin"))  
////	
////		le_dia = ids_grupo_sesion.GETITEMNUMBER(le_pos, "cve_dia")  
////		le_hora_inicio = ids_grupo_sesion.GETITEMNUMBER(le_pos, "hora_inicio")  
////		le_hora_final =  ids_grupo_sesion.GETITEMNUMBER(le_pos, "hora_final")  
////		
////		ld_fecha_evalua = ld_fecha_inicio 
////		le_horas_dia = le_hora_final - le_hora_inicio 
////		
////		DO WHILE ld_fecha_evalua <= ld_fecha_fin 
////			
////			IF (DAYNUMBER(ld_fecha_evalua) - 1) = le_dia THEN 
////			
////				// Se verifica si el día es laborable 
////				le_dia_no_laborable = ids_dias_no_laborables.FIND("fecha = DATETIME('" + STRING(DATETIME(ld_fecha_evalua)) + "')", 1, ids_dias_no_laborables.ROWCOUNT() + 1)
////				IF le_dia_no_laborable > 0 THEN 
////					ld_fecha_evalua = RELATIVEDATE(ld_fecha_evalua, 1)
////					CONTINUE
////				END IF 
////		
////				// Acumula las horas y evalúa la siguiente fecha 	
////				ie_horas_totales = ie_horas_totales + le_horas_dia  
////				
////			END IF
////			
////			ld_fecha_evalua = RELATIVEDATE(ld_fecha_evalua, 1)
////			
////		LOOP  
////		
////	NEXT 
//
///**********************************************************/
///**********************************************************/
//
//// Si se trata de Grupo "Tradicional "
//ELSE 
//	FOR ll_pos = 1 TO ll_ttl_reg 
//	
//	//	ll_cve_mat	= Ids_horario.GETITEMNUMBER(ll_pos, "cve_mat") 
//	//	ls_gpo	= Ids_horario.GETITEMSTRING(ll_pos, "gpo")	 
//	//	le_periodo	= Ids_horario.GETITEMNUMBER(ll_pos, "periodo")	  
//	//	le_anio	= Ids_horario.GETITEMNUMBER(ll_pos, "anio")	 
//	//	le_cve_dia	= Ids_horario.GETITEMNUMBER(ll_pos, "cve_dia")	 
//	//	ls_cve_salon	= Ids_horario.GETITEMSTRING(ll_pos, "cve_salon")	  
//		le_hora_inicio	= Ids_horario.GETITEMNUMBER(ll_pos, "hora_inicio")	 
//		IF ISNULL(le_hora_inicio) THEN le_hora_inicio = 0 
//		le_hora_final	= Ids_horario.GETITEMNUMBER(ll_pos, "hora_final")	 
//		IF ISNULL(le_hora_final) THEN le_hora_final = 0
//	//	ll_clase_aula	= Ids_horario.GETITEMNUMBER(ll_pos, "clase_aula")
//	
//		le_horas = 	le_hora_final - le_hora_inicio 
//		
//		ie_horas_totales = ie_horas_totales + le_horas
//	
//	NEXT 
//	
//	IF ie_horas_totales < 0 THEN ie_horas_totales = 0 
//
//END IF 
//
//
//
//
//RETURN 0 
//
//
//
//
//
//
// 
end function

public function integer of_inserta_profesor_horario ();
LONG le_cve_mat
STRING ls_gpo
INTEGER le_periodo
INTEGER le_anio
LONG ll_cve_profesor
INTEGER le_cve_dia
INTEGER le_hora_inicio
INTEGER le_hora_final
DATETIME ldt_fecha_inicio
DATETIME ldt_fecha_fin
INTEGER le_horas_asignadas 

INTEGER le_pos, le_ttl_rgs

// Se elimina el detalle previo de horario 
DELETE FROM horario_profesor_grupo 
WHERE cve_mat = :il_cve_mat 
AND gpo =  :is_gpo 
AND periodo =  :ie_periodo 
AND anio = :ie_anio 
USING itr_sce; 
IF itr_sce.SQLCODE < 0 THEN 
	is_error = "Se produjo un error al  elimina el detalle previo de horario deprofesor: " + itr_sce.SQLERRTEXT  
	ROLLBACK USING itr_sce;
	RETURN -1 
END IF 


le_ttl_rgs = ids_horario_profesor.ROWCOUNT() 

// Se hace ciclo para insertar el detalle del horario del profesor. 
FOR le_pos = 1 TO le_ttl_rgs 

	le_cve_mat = ids_horario_profesor.GETITEMNUMBER(le_pos, "cve_mat")	
	ls_gpo = ids_horario_profesor.GETITEMSTRING(le_pos, "gpo")	
	le_periodo = ids_horario_profesor.GETITEMNUMBER(le_pos, "periodo")	
	le_anio = ids_horario_profesor.GETITEMNUMBER(le_pos, "anio")	
	ll_cve_profesor = ids_horario_profesor.GETITEMNUMBER(le_pos, "cve_profesor")	
	le_cve_dia = ids_horario_profesor.GETITEMNUMBER(le_pos, "cve_dia")	
	le_hora_inicio = ids_horario_profesor.GETITEMNUMBER(le_pos, "hora_inicio")	
	le_hora_final = ids_horario_profesor.GETITEMNUMBER(le_pos, "hora_final")	
	ldt_fecha_inicio = ids_horario_profesor.GETITEMDATETIME(le_pos, "fecha_inicio")	 
	ldt_fecha_fin = ids_horario_profesor.GETITEMDATETIME(le_pos, "fecha_fin") 
	le_horas_asignadas = ids_horario_profesor.GETITEMNUMBER(le_pos, "horas_asignadas") 
	
	INSERT INTO dbo.horario_profesor_grupo (cve_mat, gpo, periodo, anio, cve_profesor, cve_dia, hora_inicio, hora_final, fecha_inicio, fecha_fin, horas_asignadas) 
	VALUES (:le_cve_mat, :ls_gpo, :le_periodo, :le_anio, :ll_cve_profesor, :le_cve_dia, :le_hora_inicio, :le_hora_final, :ldt_fecha_inicio, :ldt_fecha_fin, :le_horas_asignadas)  
	USING itr_sce; 
	IF itr_sce.SQLCODE < 0 THEN 
		is_error = "Se produjo un error al insertar el horario de los profesores: " + itr_sce.SQLERRTEXT 
		ROLLBACK USING itr_sce;
		RETURN -1 
	END IF 


NEXT 


RETURN 0 



end function

public function integer of_genera_derecho_uso_bloques (long al_coordinacion);
LONG ll_pos 
LONG ll_ttl_rgs
LONG ll_row 
INTEGER le_semana, le_hora
DATE ldt_inicio 
DATE ldt_fin, ldt_fin_semana  
INTEGER le_derecho_domingo
INTEGER le_derecho_lunes
INTEGER le_derecho_martes
INTEGER le_derecho_miercoles
INTEGER le_derecho_jueves
INTEGER le_derecho_viernes
INTEGER le_derecho_sabado 
INTEGER le_registro_buscado

//DATASTORE lds_derecho_uso_bloque
ids_derecho_uso_bloque = CREATE DATASTORE 
ids_derecho_uso_bloque.DATAOBJECT = "dw_salon_derecho_uso_bloque" 
ids_derecho_uso_bloque.SETTRANSOBJECT(itr_sce) 
//ll_ttl_rgs = ids_derecho_uso_bloque.RETRIEVE(al_coordinacion) 
//IF ll_ttl_rgs > 0 THEN RETURN 1 

// Datastore con el derecho y uso base 
DATASTORE lds_derecho_uso_base 
lds_derecho_uso_base = CREATE DATASTORE  
lds_derecho_uso_base.DATAOBJECT = "dw_derecho_uso_base"  
lds_derecho_uso_base.SETTRANSOBJECT(itr_sce) 
lds_derecho_uso_base.RETRIEVE(al_coordinacion) 

//idt_fecha_inicio = idt_inicio_periodo
//idt_fecha_fin = idt_fin_periodo

ldt_inicio = DATE(idt_inicio_periodo) 
ldt_fin = DATE(idt_fin_periodo) 
le_semana = 1

// Se coloca la fecha para que sea DOMINGO 
DO WHILE DayNumber(ldt_inicio) <> 1 
	ldt_inicio = RELATIVEDATE(ldt_inicio, -1) 
LOOP 

ldt_fin_semana = RELATIVEDATE(ldt_inicio, 6)

// Se inicializa el dw para generar el derecho y uso por bloque de la coordinación. 
DO 

	FOR le_hora = 7 TO 21 STEP 1 

		le_registro_buscado = lds_derecho_uso_base.FIND("cve_dia = 0 AND hora_inicio = " + STRING(le_hora), 1, lds_derecho_uso_base.ROWCOUNT()) 
		IF le_registro_buscado > 0 THEN 
			le_derecho_domingo = lds_derecho_uso_base.GETITEMNUMBER(le_registro_buscado, "derecho") 
		ELSE
			le_derecho_domingo = 0
		END IF
		
		le_registro_buscado = lds_derecho_uso_base.FIND("cve_dia = 1 AND hora_inicio = " + STRING(le_hora), 1, lds_derecho_uso_base.ROWCOUNT()) 
		IF le_registro_buscado > 0 THEN 
			le_derecho_lunes = lds_derecho_uso_base.GETITEMNUMBER(le_registro_buscado, "derecho") 
		ELSE
			le_derecho_lunes = 0
		END IF
		
		le_registro_buscado = lds_derecho_uso_base.FIND("cve_dia = 2 AND hora_inicio = " + STRING(le_hora), 1, lds_derecho_uso_base.ROWCOUNT()) 
		IF le_registro_buscado > 0 THEN 
			le_derecho_martes = lds_derecho_uso_base.GETITEMNUMBER(le_registro_buscado, "derecho") 
		ELSE
			le_derecho_martes = 0
		END IF		
		
		le_registro_buscado = lds_derecho_uso_base.FIND("cve_dia = 3 AND hora_inicio = " + STRING(le_hora), 1, lds_derecho_uso_base.ROWCOUNT()) 
		IF le_registro_buscado > 0 THEN 
			le_derecho_miercoles = lds_derecho_uso_base.GETITEMNUMBER(le_registro_buscado, "derecho") 
		ELSE
			le_derecho_miercoles = 0
		END IF
		
		le_registro_buscado = lds_derecho_uso_base.FIND("cve_dia = 4 AND hora_inicio = " + STRING(le_hora), 1, lds_derecho_uso_base.ROWCOUNT()) 
		IF le_registro_buscado > 0 THEN 
			le_derecho_jueves = lds_derecho_uso_base.GETITEMNUMBER(le_registro_buscado, "derecho") 
		ELSE
			le_derecho_jueves = 0 
		END IF
		
		le_registro_buscado = lds_derecho_uso_base.FIND("cve_dia = 5 AND hora_inicio = " + STRING(le_hora), 1, lds_derecho_uso_base.ROWCOUNT()) 
		IF le_registro_buscado > 0 THEN 
			le_derecho_viernes = lds_derecho_uso_base.GETITEMNUMBER(le_registro_buscado, "derecho") 
		ELSE
			le_derecho_viernes = 0
		END IF
		
		le_registro_buscado = lds_derecho_uso_base.FIND("cve_dia = 6 AND hora_inicio = " + STRING(le_hora), 1, lds_derecho_uso_base.ROWCOUNT()) 
		IF le_registro_buscado > 0 THEN 
			le_derecho_sabado = lds_derecho_uso_base.GETITEMNUMBER(le_registro_buscado, "derecho") 
		ELSE
			le_derecho_sabado = 0 
		END IF

		ll_row = ids_derecho_uso_bloque.INSERTROW(0) 
		ids_derecho_uso_bloque.SETITEM(ll_row, "cve_coordinacion", al_coordinacion)	
		ids_derecho_uso_bloque.SETITEM(ll_row, "semana", le_semana)		
		ids_derecho_uso_bloque.SETITEM(ll_row, "hora_inicio", le_hora)		
		ids_derecho_uso_bloque.SETITEM(ll_row, "hora_fin", (le_hora + 1))		
		ids_derecho_uso_bloque.SETITEM(ll_row, "domingo", le_derecho_domingo)		
		ids_derecho_uso_bloque.SETITEM(ll_row, "lunes", le_derecho_lunes)		
		ids_derecho_uso_bloque.SETITEM(ll_row, "martes", le_derecho_martes)		
		ids_derecho_uso_bloque.SETITEM(ll_row, "miercoles", le_derecho_miercoles)		
		ids_derecho_uso_bloque.SETITEM(ll_row, "jueves", le_derecho_jueves)		
		ids_derecho_uso_bloque.SETITEM(ll_row, "viernes", le_derecho_viernes)		
		ids_derecho_uso_bloque.SETITEM(ll_row, "sabado", le_derecho_sabado)		
		ids_derecho_uso_bloque.SETITEM(ll_row, "fecha_inicial", ldt_inicio)		
		ids_derecho_uso_bloque.SETITEM(ll_row, "fecha_final", ldt_fin_semana)	
 	
	NEXT 
	ldt_inicio = RELATIVEDATE(ldt_inicio, 7) 
	ldt_fin_semana = RELATIVEDATE(ldt_inicio, 6)
	le_semana++

LOOP WHILE ldt_inicio < ldt_fin 

// Se elimina cualquier Derecho y Uso previo por bloques.
DELETE FROM salones_derecho_uso_bloque
WHERE cve_coordinacion = :il_coordinacion
USING itr_sce; 

of_actualiza_derecho_uso_bloques()

//// Si llega a este punto, no se había generado la matriz de derecho y uso de la coordinación.
//IF ids_derecho_uso_bloque.UPDATE() < 0 THEN 
//	is_error = "Se produjo un error al insertar la información de derecho y uso por bloques. " 
//	RETURN -1 
//END IF
//
//COMMIT USING itr_sce;



// Si se hace la carga inicial, se llama función de afectación de Derecho y uso de salones por bloque.
IF of_calcula_derecho_uso_modular(0) < 0 THEN 
	RETURN -1
END IF


RETURN 0





end function

public function integer of_calcula_derecho_uso_modular (integer ae_genera);// Función que valida el derecho y uso de la coordinación. 
// Argumentos: ae_genera = Genera todo o el grupo que se edita. 
// Valores: 0 = Todo (Valida y Actualiza);  1 = Solo el grupo actual (Solo Valida) 


INTEGER le_hora_inicio, le_hora_fin 
INTEGEr le_cve_dia 
DATE ldt_fecha_inicio
DATE ldt_fecha_fin 	
STRING ls_buscar
INTEGER le_derecho 
INTEGER le_num_dia
LONG ll_clase_aula

LONG ll_pos, ll_row_dyu
LONG ll_ttl_rgs 
DATE ldt_valida 

INTEGER le_row 

DATASTORE lds_horario_derecho_uso
lds_horario_derecho_uso = CREATE DATASTORE  
lds_horario_derecho_uso.DATAOBJECT = "dw_horario_calc_der_uso" 
IF ae_genera = 0 THEN 
	
	lds_horario_derecho_uso.SETTRANSOBJECT(itr_sce) 
	
	IF lds_horario_derecho_uso.RETRIEVE(ie_periodo, ie_anio, il_coordinacion, il_cve_mat, is_gpo)  < 0 THEN 
		MESSAGEBOX("Error", "Se produjo un error al recuperar el horario de la coordinación para el cálculo del derecho y uso.") 
		RETURN -1 
	END IF
	
ELSE 
//IF ae_genera <> 0 THEN 
	
	ll_ttl_rgs = ids_horario.ROWCOUNT() 
	
	FOR ll_pos = 1 TO ll_ttl_rgs 
		
		le_hora_inicio = ids_horario.GETITEMNUMBER(ll_pos, "hora_inicio")
		le_hora_fin = ids_horario.GETITEMNUMBER(ll_pos, "hora_final")
		le_cve_dia = ids_horario.GETITEMNUMBER(ll_pos, "cve_dia")
		ll_clase_aula	= Ids_horario.GETITEMNUMBER(ll_pos, "clase_aula")
		ldt_fecha_inicio = DATE(idt_fecha_inicio)
		ldt_fecha_fin = DATE(idt_fecha_fin)  	 
		
		le_row = lds_horario_derecho_uso.INSERTROW(0) 
		lds_horario_derecho_uso.SETITEM(le_row, "horario_hora_inicio", le_hora_inicio)
		lds_horario_derecho_uso.SETITEM(le_row, "horario_hora_final", le_hora_fin)
		lds_horario_derecho_uso.SETITEM(le_row, "horario_cve_dia", le_cve_dia)
		lds_horario_derecho_uso.SETITEM(le_row, "grupos_fecha_inicio", ldt_fecha_inicio) 
		lds_horario_derecho_uso.SETITEM(le_row, "grupos_fecha_fin", ldt_fecha_fin) 
		lds_horario_derecho_uso.SETITEM(le_row, "horario_clase_aula", ll_clase_aula) 
	
	NEXT
	
END IF 

ll_ttl_rgs = lds_horario_derecho_uso.ROWCOUNT()


FOR ll_pos = 1 TO ll_ttl_rgs 
	
	le_hora_inicio = lds_horario_derecho_uso.GETITEMNUMBER(ll_pos, "horario_hora_inicio")
	le_hora_fin = lds_horario_derecho_uso.GETITEMNUMBER(ll_pos, "horario_hora_final")
	le_cve_dia = lds_horario_derecho_uso.GETITEMNUMBER(ll_pos, "horario_cve_dia")
	ldt_fecha_inicio = DATE(lds_horario_derecho_uso.GETITEMDATETIME(ll_pos, "grupos_fecha_inicio"))
	ldt_fecha_fin = DATE(lds_horario_derecho_uso.GETITEMDATETIME(ll_pos, "grupos_fecha_fin"))  
	ll_clase_aula = lds_horario_derecho_uso.GETITEMNUMBER(ll_pos, "horario_clase_aula") 
	// Solo se valida el derecho y uso para clase "SALON" 
	IF ll_clase_aula <> 0 THEN CONTINUE

	ll_row_dyu = 0  
	DO 
	
		DO 
	
			ls_buscar = "hora_inicio = " + STRING(le_hora_inicio) 
			ll_row_dyu = ids_derecho_uso_bloque.FIND(ls_buscar, ll_row_dyu + 1, ids_derecho_uso_bloque.ROWCOUNT() + 1)  
			IF ll_row_dyu = 0 THEN CONTINUE   
			 
			// Se toma la fecha inicial para determinar si esta dentro del rango. 
			ldt_valida = DATE(ids_derecho_uso_bloque.GETITEMDATETIME(ll_row_dyu, "fecha_inicial"))  
	
			// Si la fecha inicial ya es posterior a la fecha de fin del bloque termina el ciclo 
			IF ldt_valida > ldt_fecha_fin THEN EXIT  
			
			// Se incrementa la fecha de validación hasta el dia que se valida.
			ldt_valida = RELATIVEDATE(ldt_valida, le_cve_dia)  
			
			// Si la fecha inicial AL DIA QUE SE VALIDA ya es posterior a la fecha de fin del bloque termina el ciclo 
			IF ldt_valida > ldt_fecha_fin THEN EXIT  		
			
			// Se toma el derecho disponible en ese dia
			le_derecho = ids_derecho_uso_bloque.GETITEMNUMBER(ll_row_dyu, is_dia[le_cve_dia+1]) 
			
			// Si ya no hay derecho disponible termina el ciclo.
			IF le_derecho = 0 AND il_coordinacion <> 9999 THEN 
				is_error = "No existe derecho de salon disponible para la fecha: " + STRING(ldt_valida, "dd/mmm/yyyy") 
				RETURN -1 
			END IF 
			
			le_derecho -- 
			ids_derecho_uso_bloque.SETITEM(ll_row_dyu, is_dia[le_cve_dia+1], le_derecho)  
	
		LOOP WHILE ll_row_dyu > 0 
		
		// Se incrementa la hora de inicio para validar las 
		le_hora_inicio ++
		// Se reinicial el renglón de inicio de búsqueda.
		ll_row_dyu = 0 
		
	LOOP WHILE le_hora_inicio < le_hora_fin 
	
NEXT 

IF ae_genera = 0 THEN 
	IF of_actualiza_derecho_uso_bloques() < 0 THEN 
		MESSAGEBOX("Error", "Se produjo un error al actualizar el derecho y uso por bloques ")
		RETURN -1
	END IF 	
END IF

//ids_derecho_uso_bloque.UPDATE() 
//COMMIT USING itr_sce; 


RETURN 0




//
//hora_inicio 
//cve_dia 
//fecha_inicio
//fecha_fin 
//



//ie_periodo
//ie_anio
//il_coordinacion

//		ll_row = ids_derecho_uso_bloque.INSERTROW(0) 
//		ids_derecho_uso_bloque.SETITEM(ll_row, "cve_coordinacion", al_coordinacion)	
//		ids_derecho_uso_bloque.SETITEM(ll_row, "semana", le_semana)		
//		ids_derecho_uso_bloque.SETITEM(ll_row, "hora_inicio", le_hora)		
//		ids_derecho_uso_bloque.SETITEM(ll_row, "hora_fin", (le_hora + 1))		
//		ids_derecho_uso_bloque.SETITEM(ll_row, "domingo", le_derecho_domingo)		
//		ids_derecho_uso_bloque.SETITEM(ll_row, "lunes", le_derecho_lunes)		
//		ids_derecho_uso_bloque.SETITEM(ll_row, "martes", le_derecho_martes)		
//		ids_derecho_uso_bloque.SETITEM(ll_row, "miercoles", le_derecho_miercoles)		
//		ids_derecho_uso_bloque.SETITEM(ll_row, "jueves", le_derecho_jueves)		
//		ids_derecho_uso_bloque.SETITEM(ll_row, "viernes", le_derecho_viernes)		
//		ids_derecho_uso_bloque.SETITEM(ll_row, "sabado", le_derecho_sabado)		
//		ids_derecho_uso_bloque.SETITEM(ll_row, "fecha_inicial", ldt_inicio)		
//		ids_derecho_uso_bloque.SETITEM(ll_row, "fecha_final", ldt_fin_semana)		
//	
////	ids_derecho_uso_bloque
////hora_inicio 
////cve_dia 
////fecha_inicio
////fecha_fin 	






end function

public function integer of_actualiza_derecho_uso_bloques ();
//// Se elimina cualquier Derecho y Uso previo por bloques.
//DELETE FROM salones_derecho_uso_bloque
//WHERE cve_coordinacion = :il_coordinacion
//USING itr_sce; 

// Si llega a este punto, no se había generado la matriz de derecho y uso de la coordinación.
IF ids_derecho_uso_bloque.UPDATE() < 0 THEN 
	ROLLBACK USING itr_sce;  
	is_error = "Se produjo un error al insertar la información de derecho y uso por bloques. " 
	RETURN -1 
END IF

COMMIT USING itr_sce;



end function

public function integer of_valida_covertura_horario_profesor ();
INTEGER le_pos, le_ttl_rgs

INTEGER le_cve_dia, le_cve_dia_val

INTEGER le_hora_inicio
INTEGER le_hora_final

INTEGER le_hora
INTEGER le_row_enc

STRING ls_busqueda

LONG ll_pos 

DATE ldt_valida 

DATE ld_inicial 
DATE ldt_final 

//IF ie_requiere_horario = 0 THEN RETURN 0 

of_carga_valida_exepciones(il_cve_mat) 

IF ie_doble_presencia = 0 THEN RETURN 0  

IF ids_horario_profesor.ROWCOUNT() = 0 THEN
	is_error = "No se ha capturado ningún horario de profesor. " 
	RETURN -1 	
END IF

le_ttl_rgs = ids_horario.ROWCOUNT() 


ldt_valida = DATE(idt_fecha_inicio) 
ld_inicial = DATE(idt_fecha_inicio)
ldt_final = DATE(idt_fecha_fin)

// Se hace ciclo sobre la información de horario para verificar que todos los horarios estén cubiertos. 
FOR ll_pos = 1 TO le_ttl_rgs 

	// Se incrementa en 1 el dia para hacerlo compatible con el daynumber de PB 
	//le_cve_dia	= (ids_horario.GETITEMNUMBER(ll_pos, "cve_dia") + 1) 
	le_cve_dia	= ids_horario.GETITEMNUMBER(ll_pos, "cve_dia")  
	le_hora_inicio	= ids_horario.GETITEMNUMBER(ll_pos, "hora_inicio")	 
	le_hora_final	= ids_horario.GETITEMNUMBER(ll_pos, "hora_final")	 
	le_hora = le_hora_inicio 
	

	
	// CICLO DE HORAS
	DO 
		// CILO DE FECHAS
		DO
			
			// Se verifica el dia de la semana
			DO 
				le_cve_dia_val = DAYNUMBER(ldt_valida) - 1
				IF le_cve_dia_val <> le_cve_dia THEN 
					ldt_valida = RELATIVEDATE(ldt_valida, 1) 
					IF ldt_valida > DATE(ldt_final) THEN 
						EXIT 
					END IF					
				END IF
			LOOP WHILE le_cve_dia_val <> le_cve_dia AND ldt_valida <= ldt_final 
			
			IF ldt_valida > DATE(ldt_final) THEN 
				le_hora ++
				CONTINUE 
			END IF 		
			
			IF le_cve_dia = 4 AND MONTH(ldt_valida) = 9 THEN 
				le_cve_dia = le_cve_dia 
			END IF 	
			
			// Al enciontrar el primer dia de la semana igual, se determina si es fecha está cubierta. 		
//			ls_busqueda = "cve_dia = " + STRING((le_cve_dia - 1)) + " AND hora_inicio <= " + STRING(le_hora) + " AND hora_final >= " + STRING(le_hora) + & 
//								" AND fecha_inicio <= DATE('" + STRING(ldt_valida, "yyyy-mm-dd") + "') AND DATE('" + STRING(ldt_valida, "yyyy-mm-dd") + "') <= fecha_fin "  
								
			ls_busqueda = "cve_dia = " + STRING(le_cve_dia) + " AND hora_inicio <= " + STRING(le_hora) + " AND hora_final >= " + STRING(le_hora) + & 
								" AND fecha_inicio <= DATE('" + STRING(ldt_valida, "yyyy-mm-dd") + "') AND DATE('" + STRING(ldt_valida, "yyyy-mm-dd") + "') <= fecha_fin "  								
			
			le_row_enc = ids_horario_profesor.FIND(ls_busqueda, 0, ids_horario_profesor.ROWCOUNT() + 1) 
			IF le_row_enc = 0 THEN  
				// Se verifica si el dia es laborable. 
				IF of_valida_dia_laborable(DATETIME(ldt_valida)) THEN 
					is_error = "El horario comprendido entre " + STRING(le_hora_inicio) + " y " + STRING(le_hora_final) + " el día " + is_dia[(le_cve_dia + 1)] + " en la fecha " + STRING(ldt_valida, "dd/mm/yyyy") + " no se encuentra cubierto por ningún profesor. " 
					RETURN -1 
				END IF 	
			END IF
		
			ldt_valida = RELATIVEDATE(ldt_valida, 1) 
			
		
		LOOP WHILE ldt_valida <= ldt_final 
	
		le_hora ++
		ldt_valida = ld_inicial 
	
	LOOP WHILE le_hora <= le_hora_final  

	ld_inicial = RELATIVEDATE(ld_inicial, 1) 
	ldt_valida = ld_inicial 
	
NEXT 


RETURN 0 











////
////INTEGER le_cve_mat
////STRING ls_gpo
////INTEGER le_periodo
////INTEGER le_anio
////LONG ll_cve_profesor
////INTEGER le_cve_dia
////INTEGER le_hora_inicio
////INTEGER le_hora_final
////DATETIME ldt_fecha_inicio
////DATETIME ldt_fecha_fin
////
//INTEGER le_pos, le_ttl_rgs
//
////LONG ll_cve_mat
////STRING ls_gpo
////INTEGER le_periodo
////INTEGER le_anio
//INTEGER le_cve_dia, le_cve_dia_val
////STRING ls_cve_salon
//INTEGER le_hora_inicio
//INTEGER le_hora_final
////LONG ll_clase_aula
//INTEGER le_hora
//INTEGER le_row_enc
//
//STRING ls_busqueda
//
//LONG ll_pos 
//
//DATE ldt_valida 
//
////IF ie_requiere_horario = 0 THEN RETURN 0 
//
//of_carga_valida_exepciones(il_cve_mat) 
//
//IF ie_doble_presencia = 0 THEN RETURN 0  
//
//IF ids_horario_profesor.ROWCOUNT() = 0 THEN
//	is_error = "No se ha capturado ningún horario de profesor. " 
//	RETURN -1 	
//END IF
//
//le_ttl_rgs = ids_horario.ROWCOUNT() 
//
//// Se hace ciclo sobre la información de horario para verificar que todos los horarios estén cubiertos. 
//FOR ll_pos = 1 TO le_ttl_rgs 
//
//
//	
//	// Se incrementa en 1 el dia para hacerlo compatible con el daynumber de PB 
//	le_cve_dia	= (ids_horario.GETITEMNUMBER(ll_pos, "cve_dia") + 1) 
//	le_hora_inicio	= ids_horario.GETITEMNUMBER(ll_pos, "hora_inicio")	 
//	le_hora_final	= ids_horario.GETITEMNUMBER(ll_pos, "hora_final")	 
//	le_hora = le_hora_inicio 
//	
//	ldt_valida = DATE(idt_fecha_inicio) 
//	
//	DO 
//		
//		// Se verifica el dia de la semana
//		DO 
//			le_cve_dia_val = DAYNUMBER(ldt_valida) 
//			IF le_cve_dia_val <> le_cve_dia THEN 
//				ldt_valida = RELATIVEDATE(ldt_valida, 1) 
//			END IF
//		LOOP WHILE le_cve_dia_val <> le_cve_dia
//		
//		// Al enciontrar el primer dia de la semana igual, se determina si es fecha está cubierta. 		
//		ls_busqueda = "cve_dia = " + STRING((le_cve_dia - 1)) + " AND hora_inicio <= " + STRING(le_hora) + " AND hora_final >= " + STRING(le_hora) + & 
//							" AND fecha_inicio <= DATE('" + STRING(ldt_valida, "yyyy-mm-dd") + "') AND DATE('" + STRING(ldt_valida, "yyyy-mm-dd") + "') <= fecha_fin "  
//		
//		//'absag_datedebut = Date ( "' + string(dtt_debut, "yyyy-mm-dd") + '")'
//		
//		
//		le_row_enc = ids_horario_profesor.FIND(ls_busqueda, 0, ids_horario_profesor.ROWCOUNT() + 1) 
//		IF le_row_enc = 0 THEN  
//			is_error = "El horario comprendido entre " + STRING(le_hora_inicio) + " y " + STRING(le_hora_final) + " el día " + is_dia[le_cve_dia] + " en la fecha " + STRING(ldt_valida, "dd/mm/yyyy") + " no se encuentra cubierto por ningún profesor. " 
//			RETURN -1 
//		END IF
//	
//		le_hora ++
//	
//	LOOP WHILE le_hora <= le_hora_final  
//	
//	
//NEXT 
//
//
//RETURN 0 
//
//
//
//
//
//
//
//
end function

public function integer of_afecta_sdu_tradicional ();LONG ll_pos 
LONG ll_ttl_rgs

LONG ll_cve_mat
INTEGER le_cve_dia
INTEGER le_hora_inicio
INTEGER le_hora_final 
INTEGER le_clase_aula

BOOLEAN lb_desc_sdu_se 
lb_desc_sdu_se = ib_afecta_sdu_serv_esc 

ll_ttl_rgs = ids_horario_org.ROWCOUNT() 

// Se decrementa el derecho y uso de los registros originales.
FOR ll_pos = 1 TO ll_ttl_rgs  
	
	le_clase_aula = ids_horario_org.GETITEMNUMBER(ll_pos, "clase_aula")	 
	IF ISNULL(le_clase_aula) THEN le_clase_aula = -1 
	IF le_clase_aula <> 0 THEN CONTINUE 	
	
	ll_cve_mat = ids_horario_org.GETITEMNUMBER(ll_pos, "cve_mat")	
	le_cve_dia = ids_horario_org.GETITEMNUMBER(ll_pos, "cve_dia")
	le_hora_inicio = ids_horario_org.GETITEMNUMBER(ll_pos, "hora_inicio")	
	le_hora_final = ids_horario_org.GETITEMNUMBER(ll_pos, "hora_final")	

	If not of_dec_derecho_uso_sc(ll_cve_mat, le_cve_dia, le_hora_inicio, le_hora_final, 0, lb_desc_sdu_se) Then			
		Return -1 // Evento CambiaCupo
	End if

NEXT 


ll_ttl_rgs = ids_horario.ROWCOUNT() 

// Se decrementa el derecho y uso de los registros originales.
FOR ll_pos = 1 TO ll_ttl_rgs  
	
	le_clase_aula = ids_horario.GETITEMNUMBER(ll_pos, "clase_aula")	 
	IF ISNULL(le_clase_aula) THEN le_clase_aula = -1 
	IF le_clase_aula <> 0 THEN CONTINUE 
	
	ll_cve_mat = ids_horario.GETITEMNUMBER(ll_pos, "cve_mat")	
	le_cve_dia = ids_horario.GETITEMNUMBER(ll_pos, "cve_dia")
	le_hora_inicio = ids_horario.GETITEMNUMBER(ll_pos, "hora_inicio")	
	le_hora_final = ids_horario.GETITEMNUMBER(ll_pos, "hora_final")	

	If not of_inc_derecho_uso_sc(ll_cve_mat, le_cve_dia, le_hora_inicio, le_hora_final, 0, lb_desc_sdu_se) Then			
		Return -1 // Evento CambiaCupo
	End if


NEXT 


//// Se inicializa el Horario del Profesor para validación.  
//le_row_ins = iuo_grupo_servicios.ids_horario.INSERTROW(0)
//iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "cve_mat", iuo_grupo_servicios.il_cve_mat)	
//iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "gpo", iuo_grupo_servicios.is_gpo)	
//iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "periodo", iuo_grupo_servicios.ie_periodo)	 
//iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "anio", iuo_grupo_servicios.ie_anio)	
//iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "cve_dia", le_cve_dia)	
//iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "cve_salon", ls_cve_salon)	
//iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "hora_inicio", le_hora_inicio)	
//iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "hora_final", le_hora_final)	
//iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "clase_aula", le_clase_aula)


RETURN 0 





end function

public function integer of_borra_grupo ();
//LONG il_cve_mat
//STRING is_gpo
//INTEGER ie_periodo
//INTEGER ie_anio
STRING ls_mensaje 

INTEGER li_borra
LONG ll_num_asimila

// Se carga el grupos actual.
of_carga_grupo()  

idt_inicio_periodo = idt_fecha_inicio
idt_fin_periodo = idt_fecha_fin 

IF ie_inscritos > 0 THEN 
	li_borra = MessageBox("Grupo con Alumnos Inscritos", "El grupo " + STRING(il_cve_mat) + ":" + is_gpo + " tiene [" + STRING(ie_inscritos)+"] alumnos inscritos. ¿Desea eliminarlo?",Question!, YesNo!)
	if li_borra = 2 then
		return 0		 
	end if
END IF 

SELECT count(grupos.cve_mat)
INTO	:ll_num_asimila
FROM	grupos
WHERE grupos.cve_asimilada = :il_cve_mat
AND	grupos.gpo_asimilado = :is_gpo
AND	grupos.periodo = :ie_periodo
AND	grupos.anio = :ie_anio
AND	grupos.cond_gpo = 1
USING itr_sce;
IF itr_sce.SQLCODE < 0 THEN 
	ls_mensaje = itr_sce.SQLERRTEXT
	MESSAGEBOX("Error", "Se produjo un error al verificar grupos asimilados: " + itr_sce.SQLERRTEXT)
	RETURN -1
END IF 

IF ll_num_asimila > 0  then
	MessageBox("El grupo no puede eliminarse por asimilar ", "El grupo "+string(il_cve_mat)+":" + is_gpo+" esta registrado como que asimila a otro.",StopSign!)
	return -1
END IF

if ie_primer_sem = 1 then
	li_borra =MessageBox("Paquete de primer ingreso", "El grupo "+string(il_cve_mat) + ":" + is_gpo + " es de primer ingreso. ¿Desea eliminarlo?",Question!, YesNo!)
	if li_borra = 2 then
		return 0		 
	end if
end if

//// Se genera la matrriz de derecho y uso
//IF of_genera_derecho_uso_bloques(il_coordinacion) < 0 THEN 
//	MESSAGEBOX("Error", is_error )
//END IF


//// Se recdalcula el derecho y uso
//IF of_calcula_derecho_uso_modular(0) < 0 THEN  RETURN -1 
// Se limpia el ds con el horario para reestaurar el SDU 
ids_horario.RESET() 
// Se reestablece el derecho y uso
IF of_afecta_sdu_tradicional() < 0 THEN RETURN -1 


DELETE FROM grupos 
WHERE cve_mat = :il_cve_mat 
AND gpo = :is_gpo 
AND periodo = :ie_periodo 
AND anio = :ie_anio 
USING itr_sce;
IF itr_sce.SQLCODE < 0 THEN 
	ls_mensaje = itr_sce.SQLERRTEXT
	ROLLBACK USING itr_sce; 
	MESSAGEBOX("Error", "Se produjo un error al borrar el grupo: " + ls_mensaje)
	RETURN -1
END IF 

DELETE FROM horario
WHERE cve_mat = :il_cve_mat 
AND gpo = :is_gpo 
AND periodo = :ie_periodo 
AND anio = :ie_anio 
USING itr_sce;
IF itr_sce.SQLCODE < 0 THEN 
	ls_mensaje = itr_sce.SQLERRTEXT
	ROLLBACK USING itr_sce; 
	MESSAGEBOX("Error", "Se produjo un error al borrar el horario: " + ls_mensaje)
	RETURN -1
END IF 

DELETE FROM horario_profesor_grupo 
WHERE cve_mat = :il_cve_mat 
AND gpo = :is_gpo 
AND periodo = :ie_periodo 
AND anio = :ie_anio 
USING itr_sce;
IF itr_sce.SQLCODE < 0 THEN 
	ls_mensaje = itr_sce.SQLERRTEXT
	ROLLBACK USING itr_sce; 
	MESSAGEBOX("Error", "Se produjo un error al borrar el horario del profesor: " + ls_mensaje)
	RETURN -1
END IF 

DELETE FROM profesor_cotitular 
WHERE cve_mat = :il_cve_mat 
AND gpo = :is_gpo 
AND periodo = :ie_periodo 
AND anio = :ie_anio 
USING itr_sce;
IF itr_sce.SQLCODE < 0 THEN 
	ls_mensaje = itr_sce.SQLERRTEXT
	ROLLBACK USING itr_sce; 
	MESSAGEBOX("Error", "Se produjo un error al borrar profesores: " + ls_mensaje) 
	RETURN -1
END IF 

/**/
// Se elimina el detalle de sesiones anterior.
DELETE FROM horario_modular 
WHERE cve_mat = :il_cve_mat 
AND gpo = :is_gpo 
AND periodo = :ie_periodo 
AND anio = :ie_anio 
USING itr_sce;
IF itr_sce.SQLCODE < 0 THEN 
	is_error = " Se produjo un error al borrar el horario de sesiones de grupo anteriores: " + itr_sce.sqlerrtext  
	ROLLBACK USING itr_sce; 
	RETURN -1
END IF 

DELETE FROM  grupos_bloques
WHERE cve_mat = :il_cve_mat 
AND gpo = :is_gpo 
AND periodo = :ie_periodo 
AND anio = :ie_anio 
USING itr_sce;
IF itr_sce.SQLCODE < 0 THEN 
	ls_mensaje = itr_sce.SQLERRTEXT
	ROLLBACK USING itr_sce; 
	MESSAGEBOX("Error", "Se produjo un error al borrar grupos bloques: " + ls_mensaje) 
	RETURN -1
END IF 

/**/

COMMIT USING itr_sce; 

RETURN 0  





end function

public function boolean of_existe_grupo (long al_cve_mat, string as_gpo, integer ai_periodo, integer ai_anio);//f_existe_grupo
//Recibe:
//	al_cve_mat		long
//	as_gpo			string
//	ai_periodo		integer
//	ai_anio			integer
//Devuelve:
//	Boolean que indica si el grupo en cuestion existe

long ll_cve_mat
integer li_codigo_sql
string ls_mensaje_sql

SELECT grupos.cve_mat
INTO	:ll_cve_mat
FROM	grupos
WHERE grupos.cve_mat = :al_cve_mat
AND	grupos.gpo = :as_gpo
AND	grupos.periodo = :ai_periodo
AND	grupos.anio = :ai_anio
USING itr_sce;

li_codigo_sql = itr_sce.SqlCode
ls_mensaje_sql = itr_sce.SqlErrText

if li_codigo_sql = 100 or isnull(ll_cve_mat) then
	return false
elseif li_codigo_sql = -1 then
	MessageBox("Error al consultar grupos", ls_mensaje_sql)
	return false
end if

return true 



end function

public function boolean of_grupo_cancelado (long al_cve_mat, string as_gpo, integer ai_periodo, integer ai_anio);//f_grupo_cancelado
//Recibe:
//	al_cve_mat		long
//	as_gpo			string
//	ai_periodo		integer
//	ai_anio			integer
//Devuelve:
//	Boolean que indica si el grupo en cuestion se encuentra cancelado


integer li_cond_gpo, li_codigo_sql
string ls_mensaje_sql

SELECT grupos.cond_gpo
INTO	:li_cond_gpo
FROM	grupos
WHERE grupos.cve_mat = :al_cve_mat
AND	grupos.gpo = :as_gpo
AND	grupos.periodo = :ai_periodo
AND	grupos.anio = :ai_anio
USING itr_sce;

li_codigo_sql = itr_sce.SqlCode
ls_mensaje_sql = itr_sce.SqlErrText

if li_codigo_sql = 100 or isnull(li_cond_gpo) then
	return false
elseif li_codigo_sql = -1 then
	MessageBox("Error al consultar grupos", ls_mensaje_sql)
	return false
end if

if li_cond_gpo= 0 then 
	return true
else
	return false
end if




end function

public function boolean of_grupo_asimilado (long al_cve_mat, string as_gpo, integer ai_periodo, integer ai_anio);long ll_cve_mat
integer li_codigo_sql
string ls_mensaje_sql

SELECT grupos.cve_mat
INTO	:ll_cve_mat
FROM	grupos
WHERE grupos.cve_mat = :al_cve_mat
AND	grupos.gpo = :as_gpo
AND	grupos.periodo = :ai_periodo
AND	grupos.anio = :ai_anio
AND	grupos.tipo = 2
USING itr_sce;

li_codigo_sql = itr_sce.SqlCode
ls_mensaje_sql = itr_sce.SqlErrText

if li_codigo_sql = 100 or isnull(ll_cve_mat) then
	return false
elseif li_codigo_sql = -1 then
	MessageBox("Error al consultar grupos asimilados", ls_mensaje_sql)
	return false
end if

return true
end function

public function boolean of_mat_a_menoshoras_mat_b (long al_cve_mat_a, long al_cve_mat_b);integer  li_codigo_sql
string ls_mensaje_sql
int li_horas_reales_a, li_horas_reales_b

Select m.horas_reales
Into :li_horas_reales_a
From  dbo.materias m
Where m.cve_mat = :al_cve_mat_a 
using itr_sce;

li_codigo_sql = itr_sce.SqlCode
ls_mensaje_sql = itr_sce.SqlErrText

if li_codigo_sql = 100 or isnull(li_horas_reales_a) then
	li_horas_reales_a = 0
elseif li_codigo_sql = -1 then
	MessageBox("Error al consultar materia A", ls_mensaje_sql)
end if

Select m.horas_reales
Into :li_horas_reales_b
From  dbo.materias m
Where m.cve_mat = :al_cve_mat_b 
using itr_sce;

li_codigo_sql = itr_sce.SqlCode
ls_mensaje_sql = itr_sce.SqlErrText

if li_codigo_sql = 100 or isnull(li_horas_reales_b) then
	li_horas_reales_b = 0
elseif li_codigo_sql = -1 then
	MessageBox("Error al consultar materia B", ls_mensaje_sql)
end if

IF li_horas_reales_a < li_horas_reales_b Then
	Return True
Else
	Return False	
End If	



end function

public function boolean of_salon_hora_usado_bloque (long al_cve_mat, string as_gpo, integer ai_periodo, integer ai_anio, integer ai_cve_dia, string as_cve_salon, integer ai_hora_inicio, datetime fecha_inicio, datetime fecha_fin);//f_salon_hora_usado
//Función que revisa que el salón en cuestión no se esté utilizando para otro grupo
//
//RECIBE
//al_cve_mat		integer
//as_gpo				string
//ai_periodo		integer
//ai_anio			integer
//ai_cve_dia		integer
//as_cve_salon		string
//ai_hora_inicio	integer
//
//REGRESA boolean


integer ll_num_rows, li_codigo_sql, ll_num_rows2, li_codigo_sql2
string ls_mensaje_sql

// Se verifica si el salón está ocupado para el mismo periodo y año para el tipo de periodo que se procesa 
SELECT count(*)
INTO	:ll_num_rows
FROM	horario, grupos 
WHERE not(horario.cve_mat = :al_cve_mat AND	horario.gpo = :as_gpo) 
AND	horario.periodo = :ai_periodo
AND	horario.anio = :ai_anio
AND	horario.cve_dia = :ai_cve_dia
AND ( ( horario.hora_inicio <= :ai_hora_inicio  AND	:ai_hora_inicio < horario.hora_final ) )
AND	horario.cve_salon = :as_cve_salon 
AND grupos.cve_mat = horario.cve_mat 
AND grupos.gpo = horario.gpo
AND grupos.periodo = horario.periodo 
AND grupos.anio = horario.anio  
AND (  
	(grupos.fecha_inicio <= :fecha_inicio AND :fecha_inicio <= grupos.fecha_fin)
	OR 
	(grupos.fecha_fin <= :fecha_fin AND :fecha_fin <= grupos.fecha_fin) 
	)
USING itr_sce;
IF ISNULL(ll_num_rows) THEN ll_num_rows = 0 

li_codigo_sql = itr_sce.SqlCode
ls_mensaje_sql = itr_sce.SqlErrText


// Se verifica si el salón está disponible para cualquier otro periodo de cualquier otro tipo, sin importar la lmateria y/o el grupo. 
SELECT count(*)
INTO	:ll_num_rows2 
FROM	horario, grupos 
WHERE horario.periodo IN(SELECT periodo from periodos_por_procesos where cve_proceso = 0 and tipo_periodo <> (SELECT tipo FROM periodo WHERE periodo = :ai_periodo) ) 
AND	horario.anio IN(SELECT      anio from periodos_por_procesos where cve_proceso = 0 and tipo_periodo <> (SELECT tipo FROM periodo WHERE periodo = :ai_periodo) )  
AND	horario.cve_dia = :ai_cve_dia
AND ( ( horario.hora_inicio <= :ai_hora_inicio  AND	 :ai_hora_inicio < horario.hora_final ) )
AND	horario.cve_salon = :as_cve_salon
AND grupos.cve_mat = horario.cve_mat 
AND grupos.gpo = horario.gpo
AND grupos.periodo = horario.periodo 
AND grupos.anio = horario.anio  
AND (  
	(grupos.fecha_inicio <= :fecha_inicio AND :fecha_inicio <= grupos.fecha_fin)
	OR 
	(grupos.fecha_fin <= :fecha_fin AND :fecha_fin <= grupos.fecha_fin) 
	)
USING itr_sce;
IF ISNULL(ll_num_rows2) THEN ll_num_rows2 = 0 

li_codigo_sql2 = itr_sce.SqlCode
ls_mensaje_sql = TRIM(ls_mensaje_sql + " " + itr_sce.SqlErrText) 

if isnull(ll_num_rows) then
	return false
elseif li_codigo_sql = -1 OR li_codigo_sql2 = -1  then
	MessageBox("Error al consultar el horario de los grupos", ls_mensaje_sql)
	return true
end if

// Se acumulan las dos totales de salones 
ll_num_rows = ll_num_rows  + ll_num_rows2


if ll_num_rows > 0 then
	return true
else
	return false
end if




end function

public function integer of_obten_nombre_aula_clase_aula (integer ai_clase, ref string as_nombre_aula);//f_obten_nombre_aula_clase_aula
// Recibe la clave de la clase de aula salon
//    ai_clase
// Regresa la clase de aula del salon en base a la clave de la clase de aula
//    as_nombre_aula
//
// Antonio Pica

string ls_nombre_completo, ls_apaterno, ls_amaterno, ls_nombre, ls_mensaje
integer li_codigo
string ls_clase, ls_nombre_aula

Select clase,
		 nombre_aula
Into	:ls_clase,
		:ls_nombre_aula
From	clase_aula
Where	clase = :ai_clase
using itr_sce;

li_codigo= itr_sce.sqlcode 
ls_mensaje= itr_sce.sqlerrtext

IF li_codigo = -1 then
	Messagebox("Error",ls_mensaje)
	as_nombre_aula= ""
Elseif li_codigo = 100 then
	as_nombre_aula= ""
End IF
as_nombre_aula = ls_nombre_aula

return li_codigo



end function

public function boolean of_dec_derecho_uso_sc (long al_cve_mat, integer ai_dia, integer ai_hor_ini, integer ai_hor_fin, integer ai_cupo, boolean ab_desc_sdu_se);//f_dec_derecho_uso_sc
//Disminuye el derecho uso en base a los valores recibidos
//al_cve_mat			long
//ai_dia					integer
//ai_hor_ini			integer
//ai_hor_fin			integer
//ai_cupo				integer	
//ab_desc_sdu_se		boolean
//*! NOTA IMPORTANTE
//En este procedimiento no se efectua un COMMIT/ROLLBACK sobre la operación de 
//decremento al derecho y uso de los salones, por lo tanto, es necesrio que la función que la llame
//lleve a cabo la finalización de la transacción ya sea con un COMMIT USING gtr_sce; 
//o con un ROLLBACK USING gtr_sce;
// NOTA IMPORTANTE !*


Integer Depto=0, li_diferencia,hora_inicio_sdu,li_ciclo
Boolean ConsultaDepto = False
String ls_mensaje

If ab_desc_sdu_se Then
// Servicios Escolares
	Depto = 7300 
	ConsultaDepto = False
Else
	ConsultaDepto = True
End If	


If ConsultaDepto Then
	Select cve_coordinacion
	Into 	:depto
	From 	materias
	Where	cve_mat = :al_cve_mat using itr_sce;
	//Tabla bloqueada o coordinación inexistente
	If itr_sce.sqlcode <> 0 Then 
		Messagebox("Error al consultar la coordinacion [f_dec_derecho_uso_sc]",itr_sce.sqlerrtext,StopSign!)
   	Return False
	End if
End If
If gtr_sce.sqlcode = 0 or Depto = 7300 Then	
	If ai_hor_fin > ai_hor_ini Then
		li_diferencia = ai_hor_fin - ai_hor_ini
		hora_inicio_sdu = ai_hor_ini
		FOR li_ciclo=1 TO li_diferencia
			Update salones_derecho_uso
			Set ocupados = ocupados - 1 // decrementa uno en el campo de ocupados 
			Where (cve_coordinacion	= :depto) and (cve_dia	= :ai_dia) and
					(hora_inicio = :Hora_inicio_sdu) using itr_sce;
			hora_inicio_sdu ++
			If itr_sce.sqlcode = -1 Then
				ls_mensaje = itr_sce.sqlerrtext
				MessageBox("Error al decrementar el derecho y uso [f_dec_derecho_uso_sc]",ls_mensaje,StopSign!)
				Return False
			End If	
		Next
		Return True
	Else
		Messagebox("Aviso","el horario no es valido, favor de verificar",StopSign!)
		Return False
	End If
	Messagebox("Error","al obtener la clave del departamento",StopSign!)
	Return False
End If 





end function

public function boolean of_inc_derecho_uso_sc (long al_cve_mat, integer ai_dia, integer ai_hor_ini, integer ai_hor_fin, integer ai_cupo, boolean ab_desc_sdu_se);//f_inc_derecho_uso_sc
//Incrementa el derecho uso en base a los valores recibidos
//al_cve_mat
//ai_dia
//ai_hor_ini
//ai_hor_fin
//ai_cupo
//ab_desc_sdu_se
//*! NOTA IMPORTANTE
//En este procedimiento no se efectua un COMMIT/ROLLBACK sobre la operación de 
//decremento al derecho y uso de los salones, por lo tanto, es necesrio que la función que la llame
//lleve a cabo la finalización de la transacción ya sea con un COMMIT USING gtr_sce; 
//o con un ROLLBACK USING gtr_sce;
// NOTA IMPORTANTE !*


Integer Depto=0,li_diferencia, hora_inicio_sdu,li_ciclo, Derecho=0,Ocupados=0
Boolean TieneDerechoTodosOk = True, ConsultaDepto = False
String ls_mensaje

ConsultaDepto = True

If ab_desc_sdu_se Then
// Servicios Escolares
	Depto = 7300 
	ConsultaDepto = False
Else
	ConsultaDepto = True
End If	


If ConsultaDepto Then
	Select cve_coordinacion
	Into 	:depto
	From 	materias
	Where	cve_mat = :al_cve_mat using itr_sce;	
// Tabla bloqueada o coordinacion inexistente
	If itr_sce.sqlcode <> 0 Then 
		Messagebox("Error al consultar la coordinacion",itr_sce.sqlerrtext)
		Return False
	End if
End If

IF itr_sce.sqlcode = 0 or Depto = 7300 Then	
	IF ai_hor_fin > ai_hor_ini Then
		li_diferencia = ai_hor_fin - ai_hor_ini
		hora_inicio_sdu = ai_hor_ini
		FOR li_ciclo=1 TO li_diferencia
			Select derecho,ocupados
			Into :Derecho,:Ocupados
			From salones_derecho_uso
			Where	(cve_coordinacion	= :depto) and (cve_dia = :ai_dia) and
					(hora_inicio = :Hora_inicio_sdu) 
					using itr_sce;
			IF itr_sce.sqlcode = 0 Then			
				IF Ocupados >= Derecho Then
					TieneDerechoTodosOk = False
					Messagebox("No tiene derecho","Hora Inicio = "+string(Hora_inicio_sdu)+" Ocupados = "+string(Ocupados)+" Derecho = "+string(Derecho),StopSign!)  								 
				Else	
					Update salones_derecho_uso
					Set ocupados = ocupados + 1 // Incrementa uno en el campo de ocupados 
					Where (cve_coordinacion	= :depto) and (cve_dia	= :ai_dia) and
							(hora_inicio = :Hora_inicio_sdu) 							
							using itr_sce;
					IF itr_sce.sqlcode <> 0 Then
						TieneDerechoTodosOk= False
						ls_mensaje = itr_sce.sqlerrtext
						Messagebox("Error al actualizar la tabla derecho_y_uso f_inc_derecho_uso_sc",ls_mensaje,StopSign!)
 					End IF	
				End IF
			Else
				TieneDerechoTodosOk = False
				Messagebox("No tiene asignado un derecho y uso para:","Dia "+Dia_String(ai_dia)+"~nHora Inicio "+string(Hora_inicio_sdu)+"~nCupo "+string(ai_cupo)+" "+gtr_sce.sqlerrtext,StopSign!)
			End IF // Sqlcode del select 
			hora_inicio_sdu ++
		Next
	Else
		TieneDerechoTodosOk = False
		Messagebox("Aviso","El horario no es valido, favor de Verificar",StopSign!)
	End IF
Else	
	TieneDerechoTodosOk = False
	Messagebox("Error","Al obtener el numero de coordinacion",StopSign!)
End IF 

IF TieneDerechoTodosOk Then
	Return True
Else
	Return False
End IF	





end function

public function integer of_calcula_fecha_final ();INTEGER le_pos 
INTEGER le_cve_dia 
INTEGER le_hora_inicio 
INTEGER le_hora_final	 
INTEGER le_horas_dia 
INTEGER le_row 
DATE ldt_fecha_valida 
INTEGER le_horas_acumuladas 
INTEGER le_horas_maximas  
INTEGER le_horas_reales, le_semanas_semestre   
STRING ls_busca

////////////
le_horas_maximas = ie_horas_reales_tot_per

DATASTORE lds_horas_dia
lds_horas_dia = CREATE DATASTORE  
lds_horas_dia.DATAOBJECT = "" 

// Se hace ciclo para contar las horas y calcular la fecha de fin de curso 
ldt_fecha_valida = DATE(idt_fecha_inicio )

DO 

	le_cve_dia = DAYNUMBER(DATE(ldt_fecha_valida)) 
	IF le_cve_dia > 0 THEN le_cve_dia = le_cve_dia - 1
	
	ls_busca = "cve_dia = " + STRING(le_cve_dia) 
	le_row = Ids_horario.FIND(ls_busca, 1, Ids_horario.ROWCOUNT())  
	IF le_row > 0 THEN 
		
		le_hora_inicio	= Ids_horario.GETITEMNUMBER(le_row, "hora_inicio")	 
		IF ISNULL(le_hora_inicio) THEN CONTINUE 
		le_hora_final	= Ids_horario.GETITEMNUMBER(le_row, "hora_final")	 
		IF ISNULL(le_hora_final) THEN CONTINUE 
		le_horas_dia = le_hora_final - le_hora_inicio 	
		le_horas_acumuladas = le_horas_acumuladas + le_horas_dia 
		
	END IF 
	
	ldt_fecha_valida = RELATIVEDATE(ldt_fecha_valida, 1) 
	
LOOP WHILE le_horas_acumuladas < le_horas_maximas  

idt_fecha_fin = DATETIME(ldt_fecha_valida) 

RETURN 0




//FOR le_pos = 1 TO Ids_horario.ROWCOUNT() 
//
//	le_cve_dia	= Ids_horario.GETITEMNUMBER(le_pos, "cve_dia")	 
//	le_hora_inicio	= Ids_horario.GETITEMNUMBER(le_pos, "hora_inicio")	 
//	le_hora_final	= Ids_horario.GETITEMNUMBER(le_pos, "hora_final")	 
//
//	le_horas_dia = le_hora_final - le_hora_inicio 
//		
//	le_row = lds_horas_dia.INSERTROW(0) 	
////	lds_horas_dia.SETITEM(le_row, "le_cve_dia") 
////	lds_horas_dia.SETITEM(le_row, "le_horas_dia") 
//
//NEXT 


//ids_horario

//	ll_cve_mat	= Ids_horario.GETITEMNUMBER(ll_pos, "cve_mat") 
//	ls_gpo	= Ids_horario.GETITEMSTRING(ll_pos, "gpo")	 
//	le_periodo	= Ids_horario.GETITEMNUMBER(ll_pos, "periodo")	  
//	le_anio	= Ids_horario.GETITEMNUMBER(ll_pos, "anio")	 
//	le_cve_dia	= Ids_horario.GETITEMNUMBER(ll_pos, "cve_dia")	 
//	ls_cve_salon	= Ids_horario.GETITEMSTRING(ll_pos, "cve_salon")	  
//	le_hora_inicio	= Ids_horario.GETITEMNUMBER(ll_pos, "hora_inicio")	 
//	le_hora_final	= Ids_horario.GETITEMNUMBER(ll_pos, "hora_final")	 
//	ll_clase_aula	= Ids_horario.GETITEMNUMBER(ll_pos, "clase_aula")
//	ls_comentario = Ids_horario.GETITEMSTRING(ll_pos, "comentario") 
	

//INTEGER ie_factor_horas
//INTEGEr ie_horas_reales_gpo
//
//
//
//DATETIME idt_fecha_inicio
//DATETIME idt_fecha_fin 
//
//
//// Fechas de inicio y fin del periodo 
//DATETIME idt_inicio_periodo
//DATETIME idt_fin_periodo 




RETURN 0 



end function

public function boolean of_existe_salon (string as_cve_salon, ref string as_clase_aula, ref integer ai_bloqueado);//f_existe_salon
// Parametros:	string as_cve_salon  value
// 				string as_clase_aula reference
// Regresa	 : booleano que indica si existe el salon

integer li_codigo_sql, li_bloqueado
string ls_mensaje_sql, ls_clase_aula, ls_cve_salon

ls_clase_aula= ""

if as_cve_salon = "" or isnull(as_cve_salon) then
	as_cve_salon = ls_clase_aula
	return false	
end if

SELECT salon.cve_salon, 
		salon.clase_aula,
		salon.bloqueado
INTO	:ls_cve_salon, 
		:ls_clase_aula,
		:li_bloqueado
FROM	 salon
WHERE salon.cve_salon = :as_cve_salon
USING itr_sce;

li_codigo_sql = itr_sce.SqlCode
ls_mensaje_sql = itr_sce.SqlErrText

if isnull(ls_cve_salon) then
	SetNull(ls_clase_aula)
end if
as_clase_aula= ls_clase_aula

if isnull(li_bloqueado) then
	li_bloqueado = 0
end if
ai_bloqueado= li_bloqueado

if li_codigo_sql = 100 or isnull(ls_cve_salon) then
	return false
elseif li_codigo_sql = -1 then
	MessageBox("Error al consultar salon", ls_mensaje_sql)
	return false
end if

return true

end function

public function boolean of_es_salon_otro (string as_cve_salon, ref string as_clase_aula);//f_es_salon_otro
// Parametros:	string as_cve_salon  value
// 				string as_clase_aula reference
// Regresa	 : booleano que indica si existe el salon

integer li_codigo_sql, li_bloqueado
string ls_mensaje_sql, ls_clase_aula, ls_cve_salon

ls_clase_aula= ""

if as_cve_salon = "" or isnull(as_cve_salon) then
	as_cve_salon = ls_clase_aula
	return false	
end if

select salon.cve_salon, 
		 salon.clase_aula
INTO	:ls_cve_salon, 
		:ls_clase_aula
from  salon
where  clase_aula not LIKE '%TALLER%'
and 	clase_aula not LIKE  '%SALON%'
and 	clase_aula not LIKE  '%LAB%'
and 	clase_aula not LIKE  '%COMPU%'
and 	cve_salon = :as_cve_salon
USING itr_sce;


li_codigo_sql = itr_sce.SqlCode
ls_mensaje_sql = itr_sce.SqlErrText

if isnull(ls_cve_salon) then
	SetNull(ls_clase_aula)
end if

as_clase_aula= ls_clase_aula
//Si no se encontraron registros, o el valor del registro es nulo
if li_codigo_sql = 100 or isnull(ls_cve_salon) then
	return false
elseif li_codigo_sql = -1 then
	MessageBox("Error al consultar salones de tipo OTROS", ls_mensaje_sql)
	return false
end if

return true

end function

public function integer of_carga_valida_exepciones (long al_cve_mat);LONG ll_ttl


ids_grupos_valida_exepcion.SETTRANSOBJECT(itr_sce) 
ll_ttl = ids_grupos_valida_exepcion.RETRIEVE() 

ids_grupos_valida_exepcion.SETFILTER("cve_mat = " + STRING(al_cve_mat)) 
ids_grupos_valida_exepcion.FILTER() 

IF ids_grupos_valida_exepcion.ROWCOUNT() = 1 AND ie_forma_imparte = 2 THEN 

	ie_doble_presencia = ids_grupos_valida_exepcion.GETITEMNUMBER(1, "doble_presencia") 
	ie_horas_minimas	= ids_grupos_valida_exepcion.GETITEMNUMBER(1, "horas_minimas") 
	ib_mat_exep_fecha_fin = TRUE
	
ELSE
	
	// Valida Materia 
	ie_doble_presencia = 1 
	ie_horas_minimas	= 1 
	ib_mat_exep_fecha_fin = FALSE
	
END IF 





RETURN 0 
end function

public function integer of_inserta_horario_modular ();
LONG le_cve_mat
STRING ls_gpo
INTEGER le_periodo
INTEGER le_anio
INTEGER le_cve_dia
STRING ls_cve_salon
INTEGER le_hora_inicio
INTEGER le_hora_final
DATETIME ldt_fecha_inicio
DATETIME ldt_fecha_fin
INTEGER le_orden

INTEGER le_pos 
INTEGER le_ttl_rows

// Se insertan el detalle de HORARIO DE SESIONES. 

// Se elimina el detalle de sesiones anterior.
DELETE FROM horario_modular 
WHERE cve_mat = :il_cve_mat 
AND gpo = :is_gpo 
AND periodo = :ie_periodo 
AND anio = :ie_anio 
USING itr_sce; 
IF itr_sce.SQLCODE < 0 THEN 
	is_error = " Se produjo un error al borrar el horario de sesiones de grupo anteriores: " + itr_sce.sqlerrtext  
	ROLLBACK USING itr_sce; 
	RETURN -1
END IF 


le_ttl_rows = ids_grupo_sesion.ROWCOUNT() 

FOR le_pos = 1 TO le_ttl_rows 

	le_cve_mat = ids_grupo_sesion.GETITEMNUMBER(le_pos, "cve_mat")
	ls_gpo = ids_grupo_sesion.GETITEMSTRING(le_pos, "gpo")
	le_periodo = ids_grupo_sesion.GETITEMNUMBER(le_pos, "periodo")
	le_anio = ids_grupo_sesion.GETITEMNUMBER(le_pos, "anio")
	le_cve_dia = ids_grupo_sesion.GETITEMNUMBER(le_pos, "cve_dia")
	ls_cve_salon = ids_grupo_sesion.GETITEMSTRING(le_pos, "cve_salon")
	le_hora_inicio = ids_grupo_sesion.GETITEMNUMBER(le_pos, "hora_inicio")
	le_hora_final = ids_grupo_sesion.GETITEMNUMBER(le_pos, "hora_final")
	ldt_fecha_inicio = ids_grupo_sesion.GETITEMDATETIME(le_pos, "fecha_inicio")
	ldt_fecha_fin = ids_grupo_sesion.GETITEMDATETIME(le_pos, "fecha_fin")
	le_orden = ids_grupo_sesion.GETITEMNUMBER(le_pos, "horario_modular_orden") 
	
	INSERT INTO horario_modular (cve_mat, gpo, periodo, anio, cve_dia, cve_salon, hora_inicio, hora_final, fecha_inicio, fecha_fin, orden)
	VALUES (:le_cve_mat, :ls_gpo, :le_periodo, :le_anio, :le_cve_dia, :ls_cve_salon, :le_hora_inicio, :le_hora_final, :ldt_fecha_inicio, :ldt_fecha_fin, :le_orden) 
	USING itr_sce;	
	IF itr_sce.SQLCODE < 0 THEN 
		is_error = "Se produjo un error al guardar el horario de sesiones del grupo: " + itr_sce.SQLERRTEXT  
		ROLLBACK USING itr_sce; 
		MESSAGEBOX("Error", is_error) 
		RETURN -1 
	END IF 

NEXT 
	
// Se insertan las sesiones por FECHAS
DELETE FROM grupos_bloques 
WHERE cve_mat = :il_cve_mat  
AND gpo = :is_gpo 
AND periodo = :ie_periodo  
AND anio = :ie_anio  	
USING itr_sce; 
IF itr_sce.SQLCODE < 0 THEN 
	is_error = " Se produjo un error al borrar las sesiones de grupo anteriores: " + itr_sce.sqlerrtext  
	ROLLBACK USING itr_sce; 
	RETURN -1
END IF 

le_ttl_rows = ids_grupos_bloques.ROWCOUNT() 

FOR le_pos = 1 TO le_ttl_rows 	
	
	ldt_fecha_inicio = ids_grupos_bloques.GETITEMDATETIME(le_pos, "fecha_inicio")
	ldt_fecha_fin = ids_grupos_bloques.GETITEMDATETIME(le_pos, "fecha_fin")	

	INSERT INTO dbo.grupos_bloques (cve_mat, gpo, periodo, anio, fecha_inicio, fecha_fin)
	VALUES (:il_cve_mat, :is_gpo, :ie_periodo, :ie_anio, :ldt_fecha_inicio, :ldt_fecha_fin)
	USING itr_sce;	
	IF itr_sce.SQLCODE < 0 THEN 
		is_error = "Se produjo un error al guardar las sesiones del grupo: " + itr_sce.SQLERRTEXT  
		ROLLBACK USING itr_sce; 
		MESSAGEBOX("Error", is_error) 
		RETURN -1 
	END IF 	
	
NEXT 
	
	
RETURN  0 





end function

public function integer of_valida_sesiones ();
INTEGER le_pos_sesion, le_ttl_sesion

INTEGER le_cve_dia
INTEGER le_hora_inicio
INTEGER le_hora_final
DATETIME ldt_fecha_inicio
DATETIME ldt_fecha_fin
STRING ls_buscar

DATETIME ldt_fecha_inicio_ses
DATETIME ldt_fecha_fin_ses 
DATETIME ldt_comp

INTEGER le_pos_enc, le_pos_enc2

le_ttl_sesion = ids_grupo_sesion.ROWCOUNT() 

IF le_ttl_sesion <= 0 THEN 
	MESSAGEBOX("Error", "No se han capturado sesiones del grupo") 
	RETURN -1 
END IF 

FOR le_pos_sesion = 1 TO le_ttl_sesion 

	le_cve_dia = ids_grupo_sesion.GETITEMNUMBER(le_pos_sesion, "cve_dia") 
	le_hora_inicio = ids_grupo_sesion.GETITEMNUMBER(le_pos_sesion, "hora_inicio")  
	le_hora_final = ids_grupo_sesion.GETITEMNUMBER(le_pos_sesion, "hora_final") 
	ldt_fecha_inicio = ids_grupo_sesion.GETITEMDATETIME(le_pos_sesion, "fecha_inicio")  
	ldt_fecha_fin	 = ids_grupo_sesion.GETITEMDATETIME(le_pos_sesion, "fecha_fin")  
	
	IF ISNULL(ldt_fecha_inicio) OR ISNULL(ldt_fecha_fin) OR ldt_fecha_inicio = ldt_comp OR ldt_fecha_fin = ldt_comp  THEN 
		MESSAGEBOX("Error", "Debe especificar todas las fechas de las sesiones.")   
		RETURN -1		
	END IF 
	
	
	
	// Se busca el dia y el horario 
	//ls_buscar = "cve_dia = " + STRING(le_cve_dia) + " AND hora_inicio = " + STRING(le_hora_inicio) + " AND hora_final = " + STRING(le_hora_final) 	 
	ls_buscar = "cve_dia = " + STRING(le_cve_dia) + " AND hora_inicio <= " + STRING(le_hora_inicio) + " AND hora_final >= " + STRING(le_hora_final) 	 
	
	// Si no encuentra este dia-hora no es válida la sesión
	le_pos_enc = ids_horario.FIND(ls_buscar, 1, ids_horario.ROWCOUNT()) 
	IF le_pos_enc <= 0 THEN 
		MESSAGEBOX("Error", "Existen sesiones en dias y horarios no válidos :  ~n" + "Día = " + is_dia[le_cve_dia + 1] + "  ~n hora inicio = " + STRING(le_hora_inicio) + "  ~n hora final = " + STRING(le_hora_final))   
		RETURN -1
	END IF 
	
	//Se verifica que las fechas estén dentro del semestre
	IF ldt_fecha_inicio < idt_inicio_periodo OR ldt_fecha_inicio > idt_fin_periodo OR ldt_fecha_fin < idt_inicio_periodo OR ldt_fecha_fin > idt_fin_periodo THEN 
		MESSAGEBOX("Error", "Las fechas de sesión no pueden estar fuera de la duración del periodo escolar :  ~n "  + "Día = " + is_dia[le_cve_dia + 1] + "  ~n hora inicio = " + STRING(le_hora_inicio) + "  ~n hora final = " + STRING(le_hora_final))  
		RETURN -1
	END IF 		
		
	//Se verifica que el rango de fechas de la sesión 
	IF 	ldt_fecha_inicio > ldt_fecha_fin THEN 
		MESSAGEBOX("Error", "Las fechas de inicio y fin de sesión no son válidas:  ~n"  + "Día = " + is_dia[le_cve_dia + 1] + "  ~n hora inicio = " + STRING(le_hora_inicio) + "  ~n hora final = " + STRING(le_hora_final))  
		RETURN -1
	END IF 		


	//Se verifica que no haya traslape en las fechas de sesión del mismo día
	ldt_fecha_inicio = ids_grupo_sesion.GETITEMDATETIME(le_pos_sesion, "fecha_inicio")  
	ldt_fecha_fin	 = ids_grupo_sesion.GETITEMDATETIME(le_pos_sesion, "fecha_fin")  
	
	ls_buscar = "cve_dia = " + STRING(le_cve_dia) + " AND hora_inicio = " + STRING(le_hora_inicio) + " AND hora_final = " + STRING(le_hora_final) 	 
	le_pos_enc2 = ids_grupo_sesion.FIND(ls_buscar, 1, ids_grupo_sesion.ROWCOUNT())  
	// Se busca el dia y el horario en el mismo dw de sesiones
	IF le_pos_enc2 = le_pos_sesion THEN 
		le_pos_enc2 = ids_grupo_sesion.FIND(ls_buscar, le_pos_enc2 + 1, ids_grupo_sesion.ROWCOUNT() + 1)  
	END IF 
	
	IF le_pos_enc2 > 0 THEN 
		
		ldt_fecha_inicio_ses = ids_grupo_sesion.GETITEMDATETIME(le_pos_enc2, "fecha_inicio")   
		ldt_fecha_fin_ses = ids_grupo_sesion.GETITEMDATETIME(le_pos_enc2, "fecha_fin")  
		
		// Se verifica que no haya traslape de fechas.
		IF (ldt_fecha_inicio_ses >= ldt_fecha_inicio AND ldt_fecha_inicio_ses <= ldt_fecha_fin) OR (ldt_fecha_fin_ses >= ldt_fecha_inicio AND ldt_fecha_fin_ses <= ldt_fecha_fin) THEN 
			MESSAGEBOX("Error", "Existen traslapes de fechas en el mismo dia y hora de las sesiones:  ~n" +  + "Día = " + is_dia[le_cve_dia + 1] + "  ~n hora inicio = " + STRING(le_hora_inicio) + "  ~n hora final = " + STRING(le_hora_final) + "  ~n Fecha Inicio = " + STRING(DATE(ldt_fecha_inicio_ses), "dd/mm/yyyy")  + "  ~n Fecha Fin = " +  STRING(DATE(ldt_fecha_inicio_ses), "dd/mm/yyyy")  )  
			RETURN -1		
		END IF
		
		
	END IF 
	
NEXT 







//adw_sesiones
//
//cve_dia
//hora_inicio
//hora_final
//fecha_inicio
//fecha_fin




RETURN 0 











//
//INTEGER le_pos_sesion, le_ttl_sesion
//
//INTEGER le_cve_dia
//INTEGER le_hora_inicio
//INTEGER le_hora_final
//DATETIME ldt_fecha_inicio
//DATETIME ldt_fecha_fin
//STRING ls_buscar
//
//DATETIME ldt_fecha_inicio_ses
//DATETIME ldt_fecha_fin_ses
//
//INTEGER le_pos_enc, le_pos_enc2
//
//le_ttl_sesion = ids_grupo_sesion.ROWCOUNT() 
//
//IF le_ttl_sesion <= 0 THEN 
//	MESSAGEBOX("Error", "No se han capturado sesiones del grupo") 
//	RETURN -1 
//END IF 
//
//FOR le_pos_sesion = 1 TO le_ttl_sesion 
//
//	le_cve_dia = ids_grupo_sesion.GETITEMNUMBER(le_pos_sesion, "cve_dia") 
//	le_hora_inicio = ids_grupo_sesion.GETITEMNUMBER(le_pos_sesion, "hora_inicio")  
//	le_hora_final = ids_grupo_sesion.GETITEMNUMBER(le_pos_sesion, "hora_final") 
//	ldt_fecha_inicio = ids_grupo_sesion.GETITEMDATETIME(le_pos_sesion, "fecha_inicio")  
//	ldt_fecha_fin	 = ids_grupo_sesion.GETITEMDATETIME(le_pos_sesion, "fecha_fin")  
//	
//	// Se busca el dia y el horario 
//	ls_buscar = "cve_dia = " + STRING(le_cve_dia) + " AND hora_inicio = " + STRING(le_hora_inicio) + " AND hora_final = " + STRING(le_hora_final) 	 
//	
//	// Si no encuentra este dia-hora no es válida la sesión
//	le_pos_enc = ids_horario.FIND(ls_buscar, 1, ids_horario.ROWCOUNT()) 
//	IF le_pos_enc <= 0 THEN 
//		MESSAGEBOX("Error", "Existen sesiones en dias y horarios no válidos :  ~n" + "Día = " + is_dia[le_cve_dia + 1] + "  ~n hora inicio = " + STRING(le_hora_inicio) + "  ~n hora final = " + STRING(le_hora_final))   
//		RETURN -1
//	END IF 
//	
//	//Se verifica que las fechas estén dentro del semestre
//	IF ldt_fecha_inicio < idt_inicio_periodo OR ldt_fecha_inicio > idt_fin_periodo OR ldt_fecha_fin < idt_inicio_periodo OR ldt_fecha_fin > idt_fin_periodo THEN 
//		MESSAGEBOX("Error", "Las fechas de sesión no pueden estar fuera de la duración del periodo escolar :  ~n "  + "Día = " + is_dia[le_cve_dia + 1] + "  ~n hora inicio = " + STRING(le_hora_inicio) + "  ~n hora final = " + STRING(le_hora_final))  
//		RETURN -1
//	END IF 		
//		
//	//Se verifica que el rango de fechas de la sesión 
//	IF 	ldt_fecha_inicio >= ldt_fecha_fin THEN 
//		MESSAGEBOX("Error", "Las fechas de inicio y fin de sesión no son válidas:  ~n"  + "Día = " + is_dia[le_cve_dia + 1] + "  ~n hora inicio = " + STRING(le_hora_inicio) + "  ~n hora final = " + STRING(le_hora_final))  
//		RETURN -1
//	END IF 		
//
//
//	//Se verifica que no haya traslape en las fechas de sesión del mismo día
//	ldt_fecha_inicio = ids_grupo_sesion.GETITEMDATETIME(le_pos_sesion, "fecha_inicio")  
//	ldt_fecha_fin	 = ids_grupo_sesion.GETITEMDATETIME(le_pos_sesion, "fecha_fin")  
//	
//	ls_buscar = "cve_dia = " + STRING(le_cve_dia) + " AND hora_inicio = " + STRING(le_hora_inicio) + " AND hora_final = " + STRING(le_hora_final) 	 
//	le_pos_enc2 = ids_grupo_sesion.FIND(ls_buscar, 1, ids_grupo_sesion.ROWCOUNT())  
//	// Se busca el dia y el horario en el mismo dw de sesiones
//	IF le_pos_enc2 = le_pos_sesion THEN 
//		le_pos_enc2 = ids_grupo_sesion.FIND(ls_buscar, le_pos_enc2 + 1, ids_grupo_sesion.ROWCOUNT() + 1)  
//	END IF 
//	
//	IF le_pos_enc2 > 0 THEN 
//		
//		ldt_fecha_inicio_ses = ids_grupo_sesion.GETITEMDATETIME(le_pos_enc2, "fecha_inicio")   
//		ldt_fecha_fin_ses = ids_grupo_sesion.GETITEMDATETIME(le_pos_enc2, "fecha_fin")  
//		
//		// Se verifica que no haya traslape de fechas.
//		IF (ldt_fecha_inicio_ses >= ldt_fecha_inicio AND ldt_fecha_inicio_ses <= ldt_fecha_fin) OR (ldt_fecha_fin_ses >= ldt_fecha_inicio AND ldt_fecha_fin_ses <= ldt_fecha_fin) THEN 
//			MESSAGEBOX("Error", "Existen traslapes de fechas en el mismo dia y hora de las sesiones:  ~n" +  + "Día = " + is_dia[le_cve_dia + 1] + "  ~n hora inicio = " + STRING(le_hora_inicio) + "  ~n hora final = " + STRING(le_hora_final) + "  ~n Fecha Inicio = " + STRING(DATE(ldt_fecha_inicio_ses), "dd/mm/yyyy")  + "  ~n Fecha Fin = " +  STRING(DATE(ldt_fecha_inicio_ses), "dd/mm/yyyy")  )  
//			RETURN -1		
//		END IF
//		
//		
//	END IF 
//	
//NEXT 
//
//
//
//
//
//
//
////adw_sesiones
////
////cve_dia
////hora_inicio
////hora_final
////fecha_inicio
////fecha_fin
//
//
//
//
//RETURN 0 
//
//
//
end function

public function integer of_valida_sesiones_profesor ();

INTEGER le_pos , ll_pos_sesion, ll_ttl_sesion 
INTEGER le_ttl_profs
		
INTEGER le_dia , le_dia_ses
INTEGER le_hora_inicio, le_hora_inicio_ses
INTEGER le_hora_fin, le_hora_fin_ses
		
DATETIME ldt_inicio 
DATETIME ldt_fin 
DATETIME ldt_limpia 

DATETIME ldt_inicio_sesion 
DATETIME ldt_fin_sesion  

STRING ls_busqueda

INTEGER le_pos_enc
BOOLEAN lb_error_rango 
BOOLEAN lb_error
INTEGER le_row_error 
INTEGER le_rows_correcto

ll_ttl_sesion = ids_grupo_sesion.ROWCOUNT()  
le_ttl_profs = ids_horario_profesor.ROWCOUNT() 

FOR le_pos = 1 TO le_ttl_profs 

	le_dia = ids_horario_profesor.GETITEMNUMBER(le_pos, "cve_dia")  
	IF ISNULL(le_dia) THEN CONTINUE 
	le_hora_inicio = ids_horario_profesor.GETITEMNUMBER(le_pos, "hora_inicio") 
	IF ISNULL(le_hora_inicio) THEN CONTINUE 
	le_hora_fin = ids_horario_profesor.GETITEMNUMBER(le_pos, "hora_final")  
	IF ISNULL(le_hora_fin) THEN CONTINUE 

	ldt_inicio = ids_horario_profesor.GETITEMDATETIME(le_pos, "fecha_inicio") 
	IF ISNULL(ldt_inicio) OR ldt_inicio = ldt_limpia THEN CONTINUE 
	ldt_fin = ids_horario_profesor.GETITEMDATETIME(le_pos, "fecha_fin") 
	IF ISNULL(ldt_fin) OR ldt_fin = ldt_limpia THEN CONTINUE 
	
	IF ldt_inicio >= ldt_fin THEN 
		
		MESSAGEBOX("Error", "La fecha INICIAL debe se MENOR a la fecha FINAL.") 
		ids_horario_profesor. SELECTROW(le_pos, TRUE) 
		
	END IF
	
	// Se busca el dia y hora dentro de las sesiones propuestas para el grupo. 
	ls_busqueda =  "cve_dia = " + STRING(le_dia) + " AND hora_inicio = " + STRING(le_hora_inicio) + " AND hora_final = " + STRING(le_hora_fin)   

	le_rows_correcto = 0 
	le_pos_enc = 0
	lb_error_rango = FALSE 
	
	FOR ll_pos_sesion = 1 TO ll_ttl_sesion 
		
		le_dia_ses = ids_grupo_sesion.GETITEMNUMBER(ll_pos_sesion, "cve_dia")  
		le_hora_inicio_ses = ids_grupo_sesion.GETITEMNUMBER(ll_pos_sesion, "hora_inicio")  
		le_hora_fin_ses = ids_grupo_sesion.GETITEMNUMBER(ll_pos_sesion, "hora_final")  
		ldt_inicio_sesion = ids_grupo_sesion.GETITEMDATETIME(ll_pos_sesion, "fecha_inicio") 
		ldt_fin_sesion = ids_grupo_sesion.GETITEMDATETIME(ll_pos_sesion, "fecha_fin")  		
	
		// Si se trata del mismo dia y hora.
		IF le_dia = le_dia_ses AND le_hora_inicio = le_hora_inicio_ses AND le_hora_fin = le_hora_fin_ses THEN 
			
			// Si no entra en el rango de fechas marca error 
			IF (ldt_inicio < ldt_inicio_sesion OR ldt_inicio > ldt_fin_sesion OR ldt_fin < ldt_inicio_sesion OR ldt_fin > ldt_fin_sesion)  THEN   
				le_row_error = le_pos 
				lb_error_rango = TRUE 
			// Si encuentra el rango, apaga el error 
			ELSE 	
				le_rows_correcto ++
			END IF	
		END IF 
	
	NEXT 
	
	// Si no hubo sesiones que contengan el horario y hubo registros fuera de rango, se despliega error 
	IF le_rows_correcto = 0 AND lb_error_rango THEN 

		MESSAGEBOX("Error", "El rango de fechas especificado en el horario de profesores se encuentra fuera de las sesiones especificadas para el grupo.")   
	//	ids_horario_profesor.SELECTROW(le_pos, TRUE)  
		RETURN -1 	
	
	END IF
	
NEXT 

RETURN 0 




end function

public function integer of_valida_horario_prof_sesion ();//
//INTEGER le_cve_mat
//STRING ls_gpo
//INTEGER le_periodo
//INTEGER le_anio
//LONG ll_cve_profesor
//INTEGER le_cve_dia
//INTEGER le_hora_inicio
//INTEGER le_hora_final
//DATETIME ldt_fecha_inicio
//DATETIME ldt_fecha_fin
//
INTEGER le_pos, le_ttl_rgs

//LONG ll_cve_mat
//STRING ls_gpo
//INTEGER le_periodo
//INTEGER le_anio
INTEGER le_cve_dia, le_cve_dia_val
//STRING ls_cve_salon
INTEGER le_hora_inicio
INTEGER le_hora_final
//LONG ll_clase_aula
INTEGER le_hora
INTEGER le_row_enc
DATETIME ldt_fec_inicio 
DATETIME ldt_fec_fin 

STRING ls_busqueda

LONG ll_pos 

DATE ldt_valida 

//	le_cve_mat = ids_grupo_sesion.GETITEMNUMBER(le_pos, "cve_mat")
//	ls_gpo = ids_grupo_sesion.GETITEMSTRING(le_pos, "gpo")
//	le_periodo = ids_grupo_sesion.GETITEMNUMBER(le_pos, "periodo")
//	le_anio = ids_grupo_sesion.GETITEMNUMBER(le_pos, "anio")
//	le_cve_dia = ids_grupo_sesion.GETITEMNUMBER(le_pos, "cve_dia")
//	ls_cve_salon = ids_grupo_sesion.GETITEMSTRING(le_pos, "cve_salon")
//	le_hora_inicio = ids_grupo_sesion.GETITEMNUMBER(le_pos, "hora_inicio")
//	le_hora_final = ids_grupo_sesion.GETITEMNUMBER(le_pos, "hora_final")
//	ldt_fecha_inicio = ids_grupo_sesion.GETITEMDATETIME(le_pos, "fecha_inicio")
//	ldt_fecha_fin = ids_grupo_sesion.GETITEMDATETIME(le_pos, "fecha_fin")
//	le_orden = ids_grupo_sesion.GETITEMNUMBER(le_pos, "horario_modular_orden") 
//


//IF ie_requiere_horario = 0 THEN RETURN 0 

of_carga_valida_exepciones(il_cve_mat) 

IF ie_doble_presencia = 0 THEN RETURN 0  

IF ids_horario_profesor.ROWCOUNT() = 0 THEN
	is_error = "No se ha capturado ningún horario de profesor. " 
	RETURN -1 	
END IF

///////////////////////////////////////////////////////////////////////
INTEGER le_pos_prof 
INTEGER le_ttl_prof 
INTEGER le_ttl_detalle 
LONG ll_cve_prof
INTEGER le_titular

le_ttl_prof = ids_profesor.ROWCOUNT() 

FOR le_pos_prof = 1 TO  le_ttl_prof
	
	ll_cve_prof = ids_profesor.GETITEMNUMBER(le_pos_prof, "cve_profesor")  
	IF ISNULL(ll_cve_prof) THEN CONTINUE 
	le_titular = ids_profesor.GETITEMNUMBER(le_pos_prof, "titularidad") 
	IF ISNULL(le_titular) THEN le_titular = 0 
	IF le_titular = 1 THEN CONTINUE 
	
	IF ids_horario_profesor.FIND("cve_profesor = " + STRING(ll_cve_prof), 1, ids_horario_profesor.ROWCOUNT())  <= 0 THEN 
		is_error = "El profesor: " + STRING(ll_cve_prof) + " no tiene asignado ningún horario."
		RETURN -1 			
	END IF 
	
NEXT 

//////////////////////////////////////////////////////////////////////

// Se recupera el total de sesiones de grupo registradas.
le_ttl_rgs = ids_grupo_sesion.ROWCOUNT()  

// Se hace ciclo sobre la información de horario para verificar que todos los horarios estén cubiertos. 
FOR ll_pos = 1 TO le_ttl_rgs 
	
	// Se incrementa en 1 el dia para hacerlo compatible con el daynumber de PB 
	le_cve_dia	= ids_grupo_sesion.GETITEMNUMBER(ll_pos, "cve_dia") 
	le_hora_inicio	= ids_grupo_sesion.GETITEMNUMBER(ll_pos, "hora_inicio")	 
	le_hora_final	= ids_grupo_sesion.GETITEMNUMBER(ll_pos, "hora_final")	 
	le_hora = le_hora_inicio 
	// Se recuperan las fechas de inicio y fin de la sesión 
	ldt_fec_inicio = ids_grupo_sesion.GETITEMDATETIME(ll_pos, "fecha_inicio")
	ldt_fec_fin = ids_grupo_sesion.GETITEMDATETIME(ll_pos, "fecha_fin")

	ldt_valida = DATE(ldt_fec_inicio) 
	
	DO 
		
		// Se verifica el dia de la semana
		DO 
			le_cve_dia_val = (DAYNUMBER(ldt_valida) -1)
			IF le_cve_dia_val <> le_cve_dia THEN 
				ldt_valida = RELATIVEDATE(ldt_valida, 1) 
				IF ldt_valida > DATE(ldt_fec_fin) THEN 
					EXIT 
				END IF	
			END IF
		LOOP WHILE le_cve_dia_val <> le_cve_dia AND ldt_valida <= DATE(ldt_fec_fin)  
		
		IF ldt_valida > DATE(ldt_fec_fin) THEN 
			le_hora ++
			CONTINUE 
		END IF 
		
		// Al enciontrar el primer dia de la semana igual, se determina si es fecha está cubierta. 		
		ls_busqueda = "cve_dia = " + STRING((le_cve_dia)) + " AND hora_inicio <= " + STRING(le_hora) + " AND hora_final >= " + STRING(le_hora) + & 
							" AND fecha_inicio <= DATE('" + STRING(ldt_valida, "yyyy-mm-dd") + "') AND DATE('" + STRING(ldt_valida, "yyyy-mm-dd") + "') <= fecha_fin "  
		
		//'absag_datedebut = Date ( "' + string(dtt_debut, "yyyy-mm-dd") + '")'
		
		
		le_row_enc = ids_horario_profesor.FIND(ls_busqueda, 0, ids_horario_profesor.ROWCOUNT() + 1) 
		IF le_row_enc = 0 THEN  
			is_error = "El horario comprendido entre " + STRING(le_hora_inicio) + " y " + STRING(le_hora_final) + " el día " + is_dia[le_cve_dia + 1] + " en la fecha " + STRING(ldt_valida, "dd/mm/yyyy") + " no se encuentra cubierto por ningún profesor. " 
			RETURN -1 
		END IF
	
		le_hora ++
	
	LOOP WHILE le_hora <= le_hora_final  
	
	
NEXT 


RETURN 0 



	//ls_cve_salon	= ids_horario.GETITEMSTRING(ll_pos, "cve_salon")	  
	//ll_clase_aula	= ids_horario.GETITEMNUMBER(ll_pos, "clase_aula")	

	//ll_cve_mat	= ids_horario.GETITEMNUMBER(ll_pos, "cve_mat") 
	//ls_gpo	= ids_horario.GETITEMSTRING(ll_pos, "gpo")	 
	//le_periodo	= ids_horario.GETITEMNUMBER(ll_pos, "periodo")	  
	//le_anio	= ids_horario.GETITEMNUMBER(ll_pos, "anio")	 

//// Se hace ciclo para insertar el detalle del horario del profesor. 
//FOR le_pos = 1 TO le_ttl_rgs 
//
//	le_cve_mat = ids_horario_profesor.GETITEMNUMBER(le_pos, "cve_mat")	
//	ls_gpo = ids_horario_profesor.GETITEMSTRING(le_pos, "gpo")	
//	le_periodo = ids_horario_profesor.GETITEMNUMBER(le_pos, "periodo")	
//	le_anio = ids_horario_profesor.GETITEMNUMBER(le_pos, "anio")	
//	ll_cve_profesor = ids_horario_profesor.GETITEMNUMBER(le_pos, "cve_profesor")	
//	le_cve_dia = ids_horario_profesor.GETITEMNUMBER(le_pos, "cve_dia")	
//	le_hora_inicio = ids_horario_profesor.GETITEMNUMBER(le_pos, "hora_inicio")	
//	le_hora_final = ids_horario_profesor.GETITEMNUMBER(le_pos, "hora_final")	
//	ldt_fecha_inicio = ids_horario_profesor.GETITEMDATETIME(le_pos, "fecha_inicio")	 
//	ldt_fecha_fin = ids_horario_profesor.GETITEMDATETIME(le_pos, "fecha_fin") 
//	
//
//NEXT 









//
//
////
////INTEGER le_cve_mat
////STRING ls_gpo
////INTEGER le_periodo
////INTEGER le_anio
////LONG ll_cve_profesor
////INTEGER le_cve_dia
////INTEGER le_hora_inicio
////INTEGER le_hora_final
////DATETIME ldt_fecha_inicio
////DATETIME ldt_fecha_fin
////
//INTEGER le_pos, le_ttl_rgs
//
////LONG ll_cve_mat
////STRING ls_gpo
////INTEGER le_periodo
////INTEGER le_anio
//INTEGER le_cve_dia, le_cve_dia_val
////STRING ls_cve_salon
//INTEGER le_hora_inicio
//INTEGER le_hora_final
////LONG ll_clase_aula
//INTEGER le_hora
//INTEGER le_row_enc
//
//STRING ls_busqueda
//
//LONG ll_pos 
//
//DATE ldt_valida 
//
////IF ie_requiere_horario = 0 THEN RETURN 0 
//
//IF ie_doble_presencia = 0 THEN RETURN 0  
//
//IF ids_horario_profesor.ROWCOUNT() = 0 THEN
//	is_error = "No se ha capturado ningún horario de profesor. " 
//	RETURN -1 	
//END IF
//
//le_ttl_rgs = ids_horario.ROWCOUNT() 
//
//// Se hace ciclo sobre la información de horario para verificar que todos los horarios estén cubiertos. 
//FOR ll_pos = 1 TO le_ttl_rgs 
//
//
//	
//	// Se incrementa en 1 el dia para hacerlo compatible con el daynumber de PB 
//	le_cve_dia	= (ids_horario.GETITEMNUMBER(ll_pos, "cve_dia") + 1) 
//	le_hora_inicio	= ids_horario.GETITEMNUMBER(ll_pos, "hora_inicio")	 
//	le_hora_final	= ids_horario.GETITEMNUMBER(ll_pos, "hora_final")	 
//	le_hora = le_hora_inicio 
//	
//	ldt_valida = DATE(idt_fecha_inicio) 
//	
//	DO 
//		
//		// Se verifica el dia de la semana
//		DO 
//			le_cve_dia_val = DAYNUMBER(ldt_valida) 
//			IF le_cve_dia_val <> le_cve_dia THEN 
//				ldt_valida = RELATIVEDATE(ldt_valida, 1) 
//			END IF
//		LOOP WHILE le_cve_dia_val <> le_cve_dia
//		
//		// Al enciontrar el primer dia de la semana igual, se determina si es fecha está cubierta. 		
//		ls_busqueda = "cve_dia = " + STRING((le_cve_dia - 1)) + " AND hora_inicio <= " + STRING(le_hora) + " AND hora_final >= " + STRING(le_hora) + & 
//							" AND fecha_inicio <= DATE('" + STRING(ldt_valida, "yyyy-mm-dd") + "') AND DATE('" + STRING(ldt_valida, "yyyy-mm-dd") + "') <= fecha_fin "  
//		
//		//'absag_datedebut = Date ( "' + string(dtt_debut, "yyyy-mm-dd") + '")'
//		
//		
//		le_row_enc = ids_horario_profesor.FIND(ls_busqueda, 0, ids_horario_profesor.ROWCOUNT() + 1) 
//		IF le_row_enc = 0 THEN  
//			is_error = "El horario comprendido entre " + STRING(le_hora_inicio) + " y " + STRING(le_hora_final) + " el día " + is_dia[le_cve_dia] + " en la fecha " + STRING(ldt_valida, "dd/mm/yyyy") + " no se encuentra cubierto por ningún profesor. " 
//			RETURN -1 
//		END IF
//	
//		le_hora ++
//	
//	LOOP WHILE le_hora <= le_hora_final  
//	
//	
//NEXT 
//
//
//RETURN 0 
//
//
//
//	//ls_cve_salon	= ids_horario.GETITEMSTRING(ll_pos, "cve_salon")	  
//	//ll_clase_aula	= ids_horario.GETITEMNUMBER(ll_pos, "clase_aula")	
//
//	//ll_cve_mat	= ids_horario.GETITEMNUMBER(ll_pos, "cve_mat") 
//	//ls_gpo	= ids_horario.GETITEMSTRING(ll_pos, "gpo")	 
//	//le_periodo	= ids_horario.GETITEMNUMBER(ll_pos, "periodo")	  
//	//le_anio	= ids_horario.GETITEMNUMBER(ll_pos, "anio")	 
//
////// Se hace ciclo para insertar el detalle del horario del profesor. 
////FOR le_pos = 1 TO le_ttl_rgs 
////
////	le_cve_mat = ids_horario_profesor.GETITEMNUMBER(le_pos, "cve_mat")	
////	ls_gpo = ids_horario_profesor.GETITEMSTRING(le_pos, "gpo")	
////	le_periodo = ids_horario_profesor.GETITEMNUMBER(le_pos, "periodo")	
////	le_anio = ids_horario_profesor.GETITEMNUMBER(le_pos, "anio")	
////	ll_cve_profesor = ids_horario_profesor.GETITEMNUMBER(le_pos, "cve_profesor")	
////	le_cve_dia = ids_horario_profesor.GETITEMNUMBER(le_pos, "cve_dia")	
////	le_hora_inicio = ids_horario_profesor.GETITEMNUMBER(le_pos, "hora_inicio")	
////	le_hora_final = ids_horario_profesor.GETITEMNUMBER(le_pos, "hora_final")	
////	ldt_fecha_inicio = ids_horario_profesor.GETITEMDATETIME(le_pos, "fecha_inicio")	 
////	ldt_fecha_fin = ids_horario_profesor.GETITEMDATETIME(le_pos, "fecha_fin") 
////	
////
////NEXT 
//
//
//
//
//
//
//
//RETURN  0
end function

public function integer of_cuenta_horas_sesiones ();// Función que cuenta las horas reales de un profesor en un grupo. 
DATE ld_fecha_evalua
DATE ld_fecha_inicio 
DATE ld_fecha_fin  
INTEGER le_dia 
INTEGER le_hora_inicio
INTEGER le_hora_fin 

INTEGER le_pos 
INTEGER le_ttl_rgs 
INTEGER le_horas_dia
INTEGER le_horas_totales 
INTEGER le_dia_no_laborable 
INTEGER le_horas_maximas



le_ttl_rgs = ids_grupo_sesion.ROWCOUNT() 

of_carga_dias_no_laborables() 

FOR le_pos = 1 TO le_ttl_rgs 
 	
//	ld_fecha_inicio = DATE(ids_verifica_horario_paso.GETITEMDATETIME(le_pos, "grupos_fecha_inicio"))  
//	ld_fecha_fin =  DATE(ids_verifica_horario_paso.GETITEMDATETIME(le_pos, "grupos_fecha_fin"))  
	ld_fecha_inicio = DATE(ids_grupo_sesion.GETITEMDATETIME(le_pos, "fecha_inicio"))  
	ld_fecha_fin =  DATE(ids_grupo_sesion.GETITEMDATETIME(le_pos, "fecha_fin"))  

	le_dia = ids_grupo_sesion.GETITEMNUMBER(le_pos, "cve_dia")  
	le_hora_inicio = ids_grupo_sesion.GETITEMNUMBER(le_pos, "hora_inicio")  
	le_hora_fin =  ids_grupo_sesion.GETITEMNUMBER(le_pos, "hora_final")  
	
	//**
//	// Se incrementa en 1 el dia para hacerlo compatible con el daynumber de PB 
//	le_cve_dia	= ids_grupo_sesion.GETITEMNUMBER(ll_pos, "cve_dia") 
//	le_hora_inicio	= ids_grupo_sesion.GETITEMNUMBER(ll_pos, "hora_inicio")	 
//	le_hora_final	= ids_grupo_sesion.GETITEMNUMBER(ll_pos, "hora_final")	 
//	le_hora = le_hora_inicio 
//	// Se recuperan las fechas de inicio y fin de la sesión 
//	ldt_fec_inicio = ids_grupo_sesion.GETITEMDATETIME(ll_pos, "fecha_inicio")
//	ldt_fec_fin = ids_grupo_sesion.GETITEMDATETIME(ll_pos, "fecha_fin")	
	//**
	
	ld_fecha_evalua = ld_fecha_inicio 
	le_horas_dia = le_hora_fin - le_hora_inicio 
	
	DO WHILE ld_fecha_evalua <= ld_fecha_fin 
		
		IF (DAYNUMBER(ld_fecha_evalua) - 1) = le_dia THEN 
		
			// Se verifica si el día es laborable 
			le_dia_no_laborable = ids_dias_no_laborables.FIND("fecha = DATETIME('" + STRING(DATETIME(ld_fecha_evalua)) + "')", 1, ids_dias_no_laborables.ROWCOUNT() + 1)
			IF le_dia_no_laborable > 0 THEN 
				ld_fecha_evalua = RELATIVEDATE(ld_fecha_evalua, 1)
				CONTINUE
			END IF 
	
			// Acumula las horas y evalúa la siguiente fecha 	
			le_horas_totales = le_horas_totales + le_horas_dia  
			
		END IF
		
		ld_fecha_evalua = RELATIVEDATE(ld_fecha_evalua, 1)
		
	LOOP  
	
NEXT 

RETURN  le_horas_totales







end function

public function integer of_carga_dias_no_laborables ();
IF NOT ISVALID(ids_dias_no_laborables) THEN  
	ids_dias_no_laborables = CREATE DATASTORE 
	ids_dias_no_laborables.DATAOBJECT = "dw_calendario_grupos_mod" 
END IF 	
ids_dias_no_laborables.SETTRANSOBJECT(itr_sce)  
// Recupera los dias No-Laborables (evento 3)
ids_dias_no_laborables.RETRIEVE(3, ie_periodo, ie_anio)  


RETURN 0 
end function

public function integer of_calcula_horas_reales_sesiones_tot ();LONG ll_cve_mat	
STRING ls_gpo	
INTEGER le_periodo	
INTEGER le_anio	
INTEGER le_cve_dia	
STRING ls_cve_salon	
INTEGER le_hora_inicio	
INTEGER le_hora_final	
LONG ll_clase_aula

LONG ll_ttl_reg, ll_pos 

INTEGER le_horas

ll_ttl_reg = Ids_horario.ROWCOUNT() 

//ie_horas_totales = 0 
INTEGER le_horas_totales

// Si se trata de un grupos modular 
IF ie_forma_imparte = 2 THEN 

	/**********************************************************/
	/**********************************************************/
	// SE CALCULAN LAS HORAS CAPTURADAS DEL GRUPO SEGÚN LAS SESIONES CAPTURADAS. 
	
	INTEGER le_ttl_rgs 
	INTEGER le_pos 
	DATE ld_fecha_inicio 
	DATE ld_fecha_fin  
	DATE ld_fecha_evalua 
	INTEGER le_dia_no_laborable 
	INTEGER le_dia, le_horas_dia 
	
	
	le_ttl_rgs = ids_grupo_sesion.ROWCOUNT() 
	
	of_carga_dias_no_laborables() 
	
	FOR le_pos = 1 TO le_ttl_rgs 
		
	//	ld_fecha_inicio = DATE(ids_verifica_horario_paso.GETITEMDATETIME(le_pos, "grupos_fecha_inicio"))  
	//	ld_fecha_fin =  DATE(ids_verifica_horario_paso.GETITEMDATETIME(le_pos, "grupos_fecha_fin"))  
		ld_fecha_inicio = DATE(ids_grupo_sesion.GETITEMDATETIME(le_pos, "fecha_inicio"))  
		ld_fecha_fin =  DATE(ids_grupo_sesion.GETITEMDATETIME(le_pos, "fecha_fin"))  
	
		le_dia = ids_grupo_sesion.GETITEMNUMBER(le_pos, "cve_dia")  
		le_hora_inicio = ids_grupo_sesion.GETITEMNUMBER(le_pos, "hora_inicio")  
		le_hora_final =  ids_grupo_sesion.GETITEMNUMBER(le_pos, "hora_final")  
		
		ld_fecha_evalua = ld_fecha_inicio 
		le_horas_dia = le_hora_final - le_hora_inicio 
		
		DO WHILE ld_fecha_evalua <= ld_fecha_fin 
			
			IF (DAYNUMBER(ld_fecha_evalua) - 1) = le_dia THEN 
			
				// Se verifica si el día es laborable 
				le_dia_no_laborable = ids_dias_no_laborables.FIND("fecha = DATETIME('" + STRING(DATETIME(ld_fecha_evalua)) + "')", 1, ids_dias_no_laborables.ROWCOUNT() + 1)
				IF le_dia_no_laborable > 0 THEN 
					ld_fecha_evalua = RELATIVEDATE(ld_fecha_evalua, 1)
					CONTINUE
				END IF 
		
				// Acumula las horas y evalúa la siguiente fecha 	
				le_horas_totales = le_horas_totales + le_horas_dia  
				
			END IF
			
			ld_fecha_evalua = RELATIVEDATE(ld_fecha_evalua, 1)
			
		LOOP  
		
	NEXT 

/**********************************************************/
/**********************************************************/
END IF  

RETURN le_horas_totales 



end function

public function integer of_carga_horario_org ();INTEGER le_num_rgs 

ids_horario_org.SETTRANSOBJECT(itr_sce)  
le_num_rgs = ids_horario_org.RETRIEVE(il_cve_mat, is_gpo, ie_periodo, ie_anio )   
IF le_num_rgs < 0 THEN 
	MESSAGEBOX("Aviso", "Se produjo un error al recuperar el horaruio original ")
	RETURN -1 
END IF 

RETURN 0 
end function

public function integer of_salon_horario (string as_salon);INTEGER le_tiene_horario
STRING ls_salon 

ls_salon = UPPER(as_salon)

SELECT tiene_horario 
INTO :le_tiene_horario 
FROM salon_sin_horario
WHERE UPPER(cve_salon) = :ls_salon
USING itr_sce; 
IF itr_sce.SQLCODE < 0 THEN  
	MESSAGEBOX("Error", "Se produjo un error al verificar si el salón requiere horario: " + itr_sce.SQLERRTEXT) 
	RETURN -1 
ELSEIF itr_sce.SQLCODE = 100 THEN 	
	le_tiene_horario = 1
END IF  	
IF ISNULL(le_tiene_horario)  THEN le_tiene_horario = 1 

// le_tiene_horario = 0 NO valida horario, le_tiene_horario = 1 SI valida horario
RETURN le_tiene_horario



end function

public function boolean of_valida_dia_laborable (datetime adt_fecha);INTEGER le_dia_no_laborable 

of_carga_dias_no_laborables() 

le_dia_no_laborable = ids_dias_no_laborables.FIND("fecha = DATETIME('" + STRING(DATETIME(adt_fecha)) + "')", 1, ids_dias_no_laborables.ROWCOUNT() + 1)
IF le_dia_no_laborable > 0 THEN 
	// Dia no laborable 
	RETURN FALSE
END IF 

// Dia laborable
RETURN TRUE 



end function

public function long of_calcula_horas_totales_semestre ();// Función que calcula las horas reales totales del semestre para grupos tradicionalres. 

LONG ll_cve_mat	
STRING ls_gpo	
INTEGER le_periodo	
INTEGER le_anio	
INTEGER le_cve_dia	
STRING ls_cve_salon	
INTEGER le_hora_inicio	
INTEGER le_hora_final	
LONG ll_clase_aula

LONG ll_ttl_reg, ll_pos 

INTEGER le_horas

ll_ttl_reg = Ids_horario.ROWCOUNT() 

//ie_horas_totales = 0 
INTEGER le_horas_totales

// Si se trata de un grupos modular 
IF ie_forma_imparte = 2 THEN 

	/**********************************************************/
	/**********************************************************/
	// SE CALCULAN LAS HORAS CAPTURADAS DEL GRUPO SEGÚN LAS SESIONES CAPTURADAS. 
	
	INTEGER le_ttl_rgs 
	INTEGER le_pos 
	DATE ld_fecha_inicio 
	DATE ld_fecha_fin  
	DATE ld_fecha_evalua 
	INTEGER le_dia_no_laborable 
	INTEGER le_dia, le_horas_dia 
	
	
	le_ttl_rgs = Ids_horario.ROWCOUNT() 
	
	of_carga_dias_no_laborables() 
	
	FOR le_pos = 1 TO le_ttl_rgs 
		
		ld_fecha_inicio = DATE(idt_inicio_periodo) 
		ld_fecha_fin =  DATE(idt_fin_periodo) 
	
		le_dia = Ids_horario.GETITEMNUMBER(ll_pos, "cve_dia")    
		le_hora_inicio = Ids_horario.GETITEMNUMBER(ll_pos, "hora_inicio")	 
		le_hora_final =  Ids_horario.GETITEMNUMBER(ll_pos, "hora_final")	  
		
		ld_fecha_evalua = ld_fecha_inicio 
		le_horas_dia = le_hora_final - le_hora_inicio 
		
		DO WHILE ld_fecha_evalua <= ld_fecha_fin 
			
			IF (DAYNUMBER(ld_fecha_evalua) - 1) = le_dia THEN 
			
				// Se verifica si el día es laborable 
				le_dia_no_laborable = ids_dias_no_laborables.FIND("fecha = DATETIME('" + STRING(DATETIME(ld_fecha_evalua)) + "')", 1, ids_dias_no_laborables.ROWCOUNT() + 1)
				IF le_dia_no_laborable > 0 THEN 
					ld_fecha_evalua = RELATIVEDATE(ld_fecha_evalua, 1)
					CONTINUE
				END IF 
		
				// Acumula las horas y evalúa la siguiente fecha 	
				le_horas_totales = le_horas_totales + le_horas_dia  
				
			END IF
			
			ld_fecha_evalua = RELATIVEDATE(ld_fecha_evalua, 1)
			
		LOOP  
		
	NEXT 

/**********************************************************/
/**********************************************************/
END IF  

RETURN le_horas_totales 





RETURN 0




end function

public function integer of_horas_semestre ();// Función que calcula las horas reales totales del semestre para grupos tradicionalres. 

LONG ll_cve_mat	
STRING ls_gpo	
INTEGER le_periodo	
INTEGER le_anio	
INTEGER le_cve_dia	
STRING ls_cve_salon	
INTEGER le_hora_inicio	
INTEGER le_hora_final	
LONG ll_clase_aula

LONG ll_ttl_reg, ll_pos 

INTEGER le_horas

ll_ttl_reg = Ids_horario.ROWCOUNT() 

//ie_horas_totales = 0 
INTEGER le_horas_totales

//// Si se trata de un grupos modular 
//IF ie_forma_imparte = 2 THEN 

/**********************************************************/
/**********************************************************/
// SE CALCULAN LAS HORAS CAPTURADAS DEL GRUPO SEGÚN LAS SESIONES CAPTURADAS. 

INTEGER le_ttl_rgs 
INTEGER le_pos 
DATE ld_fecha_inicio 
DATE ld_fecha_fin  
DATE ld_fecha_evalua 
INTEGER le_dia_no_laborable 
INTEGER le_dia, le_horas_dia 


le_ttl_rgs = Ids_horario.ROWCOUNT() 

of_carga_dias_no_laborables() 

FOR le_pos = 1 TO le_ttl_rgs 

	IF ie_forma_imparte = 2 THEN 
		ld_fecha_inicio = DATE(idt_fecha_inicio) 
		ld_fecha_fin = DATE(idt_fecha_fin)  
	END IF 	
	
	ld_fecha_inicio = DATE(idt_inicio_periodo) 
	ld_fecha_fin =  DATE(idt_fin_periodo) 

	le_dia = Ids_horario.GETITEMNUMBER(le_pos, "cve_dia")    
	le_hora_inicio = Ids_horario.GETITEMNUMBER(le_pos, "hora_inicio")	 
	le_hora_final =  Ids_horario.GETITEMNUMBER(le_pos, "hora_final")	  
	
	ld_fecha_evalua = ld_fecha_inicio 
	le_horas_dia = le_hora_final - le_hora_inicio 
	
	DO WHILE ld_fecha_evalua <= ld_fecha_fin 
		
		IF (DAYNUMBER(ld_fecha_evalua) - 1) = le_dia THEN 
		
			// Se verifica si el día es laborable 
			le_dia_no_laborable = ids_dias_no_laborables.FIND("fecha = DATETIME('" + STRING(DATETIME(ld_fecha_evalua)) + "')", 1, ids_dias_no_laborables.ROWCOUNT() + 1)
			IF le_dia_no_laborable > 0 THEN 
				ld_fecha_evalua = RELATIVEDATE(ld_fecha_evalua, 1)
				CONTINUE
			END IF 
	
			// Acumula las horas y evalúa la siguiente fecha 	
			le_horas_totales = le_horas_totales + le_horas_dia  
			
		END IF
		
		ld_fecha_evalua = RELATIVEDATE(ld_fecha_evalua, 1)
		
	LOOP  
	
NEXT 

/**********************************************************/
/**********************************************************/
//END IF  

//  Se pasan las horas a variable de instancia para su uso posterior
ie_horas_totales_semestre = le_horas_totales 

RETURN le_horas_totales 





RETURN 0




end function

on uo_grupo_servicios.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_grupo_servicios.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

