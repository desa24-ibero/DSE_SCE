$PBExportHeader$uo_academicos_servicios.sru
$PBExportComments$Objeto con servicios de datos académicos.
forward
global type uo_academicos_servicios from nonvisualobject
end type
end forward

global type uo_academicos_servicios from nonvisualobject
end type
global uo_academicos_servicios uo_academicos_servicios

type variables
// ACADEMICOS 
LONG il_cuenta
LONG il_cve_carrera
INTEGER ie_cve_plan
INTEGER ie_cve_subsistema
STRING is_nivel
DECIMAL id_promedio
INTEGER ie_sem_cursados
INTEGER ie_creditos_cursados
INTEGER ib_egresado
INTEGER ie_periodo_ing
INTEGER ie_anio_ing
INTEGER ie_periodo_egre
INTEGER ie_anio_egre
INTEGER ie_cve_formaingreso
INTEGER ie_ceremonia_mes
INTEGER ie_ceremonia_anio 

// ACADEMICOS_HIST
LONG il_cuenta_h
LONG il_cve_carrera_h
INTEGER ie_cve_plan_h
INTEGER ie_cve_subsistema_h
STRING is_nivel_h
DECIMAL id_promedio_h
INTEGER ie_sem_cursados_h
INTEGER ie_creditos_cursados_h
INTEGER ib_egresado_h
INTEGER ie_periodo_ing_h
INTEGER ie_anio_ing_h
INTEGER ie_periodo_egre_h
INTEGER ie_anio_egre_h
INTEGER ie_cve_formaingreso_h
INTEGER ie_ceremonia_mes_h
INTEGER ie_ceremonia_anio_h
DATETIME idt_fec_modif
STRING is_usuario_modif
INTEGER ie_vigente 

//HIST_CARRERAS 
LONG il_cuenta_hc
INTEGER ie_cve_formaingreso_hc
LONG il_cve_carrera_ant_hc
INTEGER ie_cve_plan_ant_hc
INTEGER ie_cve_subsistema_ant_hc
INTEGER ie_cve_carrera_act_hc
INTEGER ie_cve_plan_act_hc
INTEGER ie_cve_subsistema_act_hc
INTEGER ie_periodo_ing_hc
INTEGER ie_anio_ing_hc
STRING is_nivel_ant_hc
STRING is_nivel_act_hc
DECIMAL id_promedio_ant_hc
INTEGER ie_sem_cursados_ant_hc
INTEGER ie_creditos_cursados_ant_hc
INTEGER ib_egresado_ant_hc
INTEGER ie_periodo_egre_ant_hc
INTEGER ie_anio_egre_ant_hc
INTEGER ie_periodo_ing_act_hc
INTEGER ie_anio_ing_act_hc
INTEGER ie_cve_formaingreso_ant_hc
STRING is_usuario_hc
DATETIME idt_fecha_hc
INTEGER ie_ceremonia_mes_hc
INTEGER ie_ceremonia_anio_hc
DECIMAL id_promedio_act_hc
INTEGER ie_sem_cursados_act_hc
INTEGER ie_creditos_cursados_act_hc
INTEGER ib_egresado_act_hc
INTEGER ie_periodo_egre_act_hc
INTEGER ie_anio_egre_act_hc
	
	
	
end variables

forward prototypes
public function integer of_actualiza_academicos_hist ()
public function integer of_carga_academicos_hist ()
public function integer of_actualiza_academicos (integer ae_operacion)
public function integer of_actualiza_hist_carreras ()
public function integer of_carga_academicos ()
public function integer of_inicializa_hist_carreras ()
end prototypes

public function integer of_actualiza_academicos_hist ();INTEGER le_ttl_rgs

SElECT COUNT(*) 
INTO :le_ttl_rgs 
FROM academicos_hist 
WHERE cuenta = :il_cuenta_h   
AND cve_carrera= :il_cve_carrera_h   
AND cve_plan= :ie_cve_plan_h  
USING gtr_sce;  
IF gtr_sce.SQLCODE < 0 THEN  
	MESSAGEBOX("Error", "Se produjo un error al verificar la existencia previa del registro de Academicos Histórico: " + gtr_sce.SQLERRTEXT) 
	RETURN -1 
END IF 

IF le_ttl_rgs <= 0 THEN 
	// Se inserta el registro nuevo 
	INSERT INTO academicos_hist(cuenta, cve_carrera, cve_plan, cve_subsistema, nivel, promedio, sem_cursados, creditos_cursados, 
											egresado, periodo_ing, anio_ing, periodo_egre, anio_egre, cve_formaingreso, ceremonia_mes, ceremonia_anio, 
											fec_modif, usuario_modif, vigente) 
	VALUES (:il_cuenta_h, :il_cve_carrera_h, :ie_cve_plan_h, :ie_cve_subsistema_h, :is_nivel_h, :id_promedio_h, :ie_sem_cursados_h, :ie_creditos_cursados_h, 
				:ib_egresado_h, :ie_periodo_ing_h, :ie_anio_ing_h, :ie_periodo_egre_h, :ie_anio_egre_h, :ie_cve_formaingreso_h, :ie_ceremonia_mes_h, :ie_ceremonia_anio_h, 
				:idt_fec_modif, :is_usuario_modif, :ie_vigente) 
	USING gtr_sce; 
	IF gtr_sce.SQLCODE < 0 THEN  
		MESSAGEBOX("Error", "Se produjo un error al insertar Academicos Histórico: " + gtr_sce.SQLERRTEXT)
		RETURN -1 		
	END IF 
	
ELSE 


	// Se actgualiza el registro 
	UPDATE academicos_hist 
	SET 	cve_subsistema= :ie_cve_subsistema_h,   
			nivel= :is_nivel_h,  
			promedio = :id_promedio_h,   
			sem_cursados = :ie_sem_cursados_h, 
			creditos_cursados  = :ie_creditos_cursados_h,
			egresado  = :ib_egresado_h,  
			periodo_ing = :ie_periodo_ing_h,  
			anio_ing = :ie_anio_ing_h,  
			periodo_egre = :ie_periodo_egre_h,  
			anio_egre = :ie_anio_egre_h,  
			cve_formaingreso = :ie_cve_formaingreso_h,  
			ceremonia_mes = :ie_ceremonia_mes_h,  
			ceremonia_anio = :ie_ceremonia_anio_h,  
			fec_modif = :idt_fec_modif,  
			usuario_modif = :is_usuario_modif,  
			vigente = :ie_vigente 
	WHERE cuenta = :il_cuenta_h   
	AND cve_carrera= :il_cve_carrera_h   
	AND cve_plan= :ie_cve_plan_h  
	USING gtr_sce; 
	IF gtr_sce.SQLCODE < 0 THEN  
		MESSAGEBOX("Error", "Se produjo un error al actualizar Academicos Histórico: " + gtr_sce.SQLERRTEXT) 
		RETURN -1 			
	END IF 

END IF 

RETURN 0









end function

public function integer of_carga_academicos_hist ();// Se recupera 

SELECT  cve_subsistema, nivel, promedio, sem_cursados, creditos_cursados, 
			egresado, periodo_ing, anio_ing, periodo_egre, anio_egre, cve_formaingreso, ceremonia_mes, ceremonia_anio, 
			fec_modif, usuario_modif, vigente 
INTO  :ie_cve_subsistema_h, :is_nivel_h, :id_promedio_h, :ie_sem_cursados_h, :ie_creditos_cursados_h, 
			:ib_egresado_h, :ie_periodo_ing_h, :ie_anio_ing_h, :ie_periodo_egre_h, :ie_anio_egre_h, :ie_cve_formaingreso_h, :ie_ceremonia_mes_h, :ie_ceremonia_anio_h, 
			:idt_fec_modif, :is_usuario_modif, :ie_vigente 
FROM academicos_hist 
WHERE cuenta = :il_cuenta_h  
AND cve_carrera = :il_cve_carrera_h  
AND cve_plan = :ie_cve_plan_h 
USING gtr_sce; 

RETURN 0 




end function

public function integer of_actualiza_academicos (integer ae_operacion);// ae_operacion  1 = Nuevo registro en académicos, 2 = Se hace actualización de la información en académicos. 

// Se verifica el  tipo de operación que se va a realizar.  

// Si se inserta un nuevo registro 
IF ae_operacion = 1 THEN 

	INSERT INTO academicos(cuenta, cve_carrera, cve_plan, cve_subsistema, nivel, promedio, sem_cursados, creditos_cursados, 
									egresado, periodo_ing, anio_ing, periodo_egre, anio_egre, cve_formaingreso, ceremonia_mes, ceremonia_anio ) 
	VALUES(:il_cuenta, :il_cve_carrera, :ie_cve_plan, :ie_cve_subsistema, :is_nivel, :id_promedio, :ie_sem_cursados, :ie_creditos_cursados, 
				:ib_egresado, :ie_periodo_ing, :ie_anio_ing, :ie_periodo_egre, :ie_anio_egre, :ie_cve_formaingreso, :ie_ceremonia_mes, :ie_ceremonia_anio)  
	USING gtr_sce; 
	IF gtr_sce.SQLCODE < 0 THEN 
		MESSAGEBOX("Error", "Se produjo un error al insertar en Académicos: " + gtr_sce.SQLERRTEXT) 
		RETURN -1 
	END IF 	
	
// Si se "Activa" o se Cambia de carrera.
ELSE 

	UPDATE academicos 
	SET 	cve_carrera = :il_cve_carrera,   
			cve_plan = :ie_cve_plan,    
			cve_subsistema = :ie_cve_subsistema,   
			nivel = :is_nivel,    
			promedio = :id_promedio,   
			sem_cursados  = :ie_sem_cursados,    
			creditos_cursados = :ie_creditos_cursados,   
			egresado  = :ib_egresado,    
			periodo_ing = :ie_periodo_ing, 
			anio_ing = :ie_anio_ing,   
			periodo_egre  = :ie_periodo_egre,    
			anio_egre = :ie_anio_egre,   
			cve_formaingreso = :ie_cve_formaingreso,    
			ceremonia_mes = :ie_ceremonia_mes ,    
			ceremonia_anio = :ie_ceremonia_anio 
	WHERE cuenta  = :il_cuenta 			
	USING gtr_sce; 
	IF gtr_sce.SQLCODE < 0 THEN 
		MESSAGEBOX("Error", "Se produjo un error al actualizar Académicos: " + gtr_sce.SQLERRTEXT) 
		RETURN -1 		
	END IF 		
	
	
END IF 

RETURN 0 


end function

public function integer of_actualiza_hist_carreras ();INTEGER le_ttl_rgs 

// Se verifica si existe el cambio entre estas mismas carreras. 
SELECT COUNT(*) 
INTO :le_ttl_rgs 
FROM hist_carreras 
WHERE cuenta = :il_cuenta_hc  
AND cve_carrera_act = :ie_cve_carrera_act_hc  
AND cve_plan_act = :ie_cve_plan_act_hc  
USING gtr_sce; 
//AND cve_carrera_ant = :il_cve_carrera_ant_hc  
//AND cve_plan_ant = :ie_cve_plan_ant_hc  

IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al verificar la existencia de el cambio de carrera: " + gtr_sce.SQLERRTEXT)
	RETURN -1 	
END IF 	 


// Si se inserta el cambio de carrera 
IF le_ttl_rgs <= 0 THEN 
	
	INSERT INTO hist_carreras( cuenta, cve_formaingreso, cve_carrera_ant, cve_plan_ant, cve_subsistema_ant, cve_carrera_act, 
										cve_plan_act, cve_subsistema_act, periodo_ing, anio_ing, nivel_ant, nivel_act, 
										promedio_ant, sem_cursados_ant, creditos_cursados_ant, egresado_ant, periodo_egre_ant, anio_egre_ant, 
										periodo_ing_act, anio_ing_act, cve_formaingreso_ant, usuario, fecha, ceremonia_mes, 
										ceremonia_anio, promedio_act, sem_cursados_act, creditos_cursados_act, egresado_act, periodo_egre_act, 
										anio_egre_act) 
	VALUES( :il_cuenta_hc, :ie_cve_formaingreso_hc, :il_cve_carrera_ant_hc, :ie_cve_plan_ant_hc, :ie_cve_subsistema_ant_hc, :ie_cve_carrera_act_hc, 
				:ie_cve_plan_act_hc, :ie_cve_subsistema_act_hc, :ie_periodo_ing_hc, :ie_anio_ing_hc, :is_nivel_ant_hc, :is_nivel_act_hc, 
				:id_promedio_ant_hc, :ie_sem_cursados_ant_hc, :ie_creditos_cursados_ant_hc, :ib_egresado_ant_hc, :ie_periodo_egre_ant_hc, :ie_anio_egre_ant_hc, 
				:ie_periodo_ing_act_hc, :ie_anio_ing_act_hc, :ie_cve_formaingreso_ant_hc, :is_usuario_hc, :idt_fecha_hc, :ie_ceremonia_mes_hc, 
				:ie_ceremonia_anio_hc, :id_promedio_act_hc, :ie_sem_cursados_act_hc, :ie_creditos_cursados_act_hc, :ib_egresado_act_hc, :ie_periodo_egre_act_hc, 
				:ie_anio_egre_act_hc) 
	USING gtr_sce; 
	IF gtr_sce.SQLCODE < 0 THEN 
		MESSAGEBOX("Error", "Se produjo un error al insertar el cambio de carrera: " + gtr_sce.SQLERRTEXT)
		RETURN -1 
	END IF 


// Si se actualiza la carrera. 
ELSE 
	
	UPDATE hist_carreras 
	SET  	cve_formaingreso = :ie_cve_formaingreso_hc, 
			cve_subsistema_ant = :ie_cve_subsistema_ant_hc, 
			cve_subsistema_act = :ie_cve_subsistema_act_hc, 
			periodo_ing = :ie_periodo_ing_hc, 
			anio_ing = :ie_anio_ing_hc, 
			nivel_ant = :is_nivel_ant_hc, 
			nivel_act = :is_nivel_act_hc, 
			promedio_ant = :id_promedio_ant_hc, 
			sem_cursados_ant = :ie_sem_cursados_ant_hc, 
			creditos_cursados_ant = :ie_creditos_cursados_ant_hc, 
			egresado_ant = :ib_egresado_ant_hc, 
			periodo_egre_ant = :ie_periodo_egre_ant_hc, 
			anio_egre_ant = :ie_anio_egre_ant_hc, 
			periodo_ing_act = :ie_periodo_ing_act_hc, 
			anio_ing_act = :ie_anio_ing_act_hc, 
			cve_formaingreso_ant = :ie_cve_formaingreso_ant_hc, 
			usuario = :is_usuario_hc, 
			fecha = :idt_fecha_hc, 
			ceremonia_mes = :ie_ceremonia_mes_hc, 
			ceremonia_anio = :ie_ceremonia_anio_hc, 
			promedio_act = :id_promedio_act_hc, 
			sem_cursados_act = :ie_sem_cursados_act_hc, 
			creditos_cursados_act = :ie_creditos_cursados_act_hc, 
			egresado_act = :ib_egresado_act_hc, 
			periodo_egre_act = :ie_periodo_egre_act_hc, 
			anio_egre_act = :ie_anio_egre_act_hc 
	WHERE cuenta = :il_cuenta_hc
	AND cve_carrera_ant = :il_cve_carrera_ant_hc 
	AND cve_plan_ant = :ie_cve_plan_ant_hc 	
	AND cve_carrera_act = :ie_cve_carrera_act_hc
	AND cve_plan_act = :ie_cve_plan_act_hc
	USING gtr_sce; 
	IF gtr_sce.SQLCODE < 0 THEN 
		MESSAGEBOX("Error", "Se produjo un error al insertar el cambio de carrera: " + gtr_sce.SQLERRTEXT)
		RETURN -1 		
	END IF 	

END IF 

RETURN 0 





end function

public function integer of_carga_academicos ();
SELECT 	cve_carrera, cve_plan, cve_subsistema, nivel, promedio, sem_cursados, creditos_cursados, 
			egresado, periodo_ing, anio_ing, periodo_egre, anio_egre, cve_formaingreso, ceremonia_mes, ceremonia_anio  
INTO :il_cve_carrera, :ie_cve_plan, :ie_cve_subsistema, :is_nivel, :id_promedio, :ie_sem_cursados, :ie_creditos_cursados, 
        :ib_egresado, :ie_periodo_ing, :ie_anio_ing, :ie_periodo_egre, :ie_anio_egre, :ie_cve_formaingreso, :ie_ceremonia_mes, :ie_ceremonia_anio 
FROM academicos 
WHERE cuenta = :il_cuenta 
USING gtr_sce; 
IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al insertar en Académicos: " + gtr_sce.SQLERRTEXT) 
	RETURN -1 
END IF 



end function

public function integer of_inicializa_hist_carreras ();
// Las variables de carrera actual se inicializan con los datos de académicos que serán actualizados. 
il_cuenta_hc = il_cuenta
ie_cve_formaingreso_hc = ie_cve_formaingreso 
ie_cve_carrera_act_hc = il_cve_carrera 
ie_cve_plan_act_hc = ie_cve_plan 
ie_cve_subsistema_act_hc = ie_cve_subsistema
is_nivel_act_hc = is_nivel
ie_periodo_ing_act_hc = ie_periodo_ing 
ie_anio_ing_act_hc = ie_anio_ing 
is_usuario_hc = gs_usuario
idt_fecha_hc = DATETIME(f_obten_fecha_servidor())
ie_ceremonia_mes_hc = ie_ceremonia_mes 
ie_ceremonia_anio_hc = ie_ceremonia_anio 
id_promedio_act_hc = id_promedio 
ie_sem_cursados_act_hc = ie_sem_cursados 
ie_creditos_cursados_act_hc = ie_creditos_cursados 
ib_egresado_act_hc = ib_egresado 
ie_periodo_egre_act_hc = ie_periodo_egre
ie_anio_egre_act_hc = ie_anio_egre 


// Se recupera la información de académicos para inicializar las variables de carrera_ant 
SELECT cve_carrera, cve_plan, cve_subsistema, nivel, 
			promedio, sem_cursados, creditos_cursados, egresado, 
			periodo_egre, anio_egre, cve_formaingreso, periodo_ing, anio_ing
INTO :il_cve_carrera_ant_hc, :ie_cve_plan_ant_hc, :ie_cve_subsistema_ant_hc, :is_nivel_ant_hc, 
		:id_promedio_ant_hc, :ie_sem_cursados_ant_hc, :ie_creditos_cursados_ant_hc, :ib_egresado_ant_hc, 
		:ie_periodo_egre_ant_hc, :ie_anio_egre_ant_hc, :ie_cve_formaingreso_ant_hc, :ie_periodo_ing_hc, :ie_anio_ing_hc 
FROM academicos 
WHERE cuenta = :il_cuenta_hc 
USING gtr_sce; 
IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar la información de academicos para Histórico Carreras: " + gtr_sce.SQLERRTEXT) 
	RETURN -1 
END IF 



RETURN 0 
end function

on uo_academicos_servicios.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_academicos_servicios.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

