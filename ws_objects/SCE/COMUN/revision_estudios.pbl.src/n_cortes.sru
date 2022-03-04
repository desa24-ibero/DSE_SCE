$PBExportHeader$n_cortes.sru
forward
global type n_cortes from n_base
end type
end forward

global type n_cortes from n_base
end type
global n_cortes n_cortes

forward prototypes
public function integer of_obten_cve_flag_promedio (long al_cuenta)
public function integer of_obten_cve_flag_serv_social (long al_cuenta)
public function decimal of_obten_puntaje_min (long al_cve_carrera, long al_cve_plan)
public function integer of_obten_cred_serv_social (long al_cve_carrera, long al_cve_plan)
public function integer of_curso_tema_integracion (long al_cuenta, long al_cve_carrera, long al_cve_plan, long al_area)
public function integer of_corte_integracion (long al_cuenta, long al_cve_carrera, long al_cve_plan, ref integer ai_ya_puede, ref integer ai_ya_curso)
public function boolean of_revisa_areas_completas (long al_cuenta, long al_cve_carrera, long al_cve_plan, long al_cve_subsistema, string as_nivel)
public function integer of_obten_cred_integracion (long al_cve_carrera, long al_cve_plan)
public function long of_obten_calificacion_ss (long al_cuenta, long al_cve_carrera, long al_cve_plan, ref string as_calificacion)
public function integer of_corte_servicio_social (long al_cuenta, long al_cve_carrera, long al_cve_plan, ref integer ai_ya_puede, ref integer ai_ya_curso)
public function integer of_obten_carrera_plan_sub_niv (long al_cuenta, ref long al_cve_carrera, ref long al_cve_plan, ref long al_cve_subsistema, ref string as_nivel, ref integer ai_egresado_anterior)
public function integer of_obten_carrera_plan (long al_cuenta, ref long al_cve_carrera, ref long al_cve_plan)
public function integer of_obten_nombre_completo (long al_cuenta, ref string as_nombre_completo)
public function integer of_obten_periodo_egreso (ref integer ai_periodo, ref integer ai_anio)
public function integer of_actualiza_egresado (long al_cuenta, integer ai_egresado, integer ai_periodo_egre, integer ai_anio_egre, integer ai_creditos, decimal ad_promedio, integer ai_egresado_anterior)
public function integer of_obten_baja_3_reprob (long al_cuenta)
public function integer of_obten_baja_4_insc (long al_cuenta)
public function integer of_corte_3r_4i (long al_cuenta, long al_cve_carrera, long al_cve_plan, ref integer ai_baja_3_reprob, ref integer ai_baja_4_insc)
public function integer of_obten_indulto (long al_cuenta, integer ai_periodo, integer ai_anio, string as_cve_indulto)
public function long of_obten_nivel_carrera (long al_cve_carrera, ref string as_nivel)
public function integer of_obten_periodo_egreso (ref integer ai_periodo, ref integer ai_anio, string as_tipo_periodo)
public function integer of_calcula_promedio (long al_cuenta, long al_cve_carrera, long al_cve_plan, ref decimal ad_promedio, ref decimal ad_creditos)
public function integer of_corte_promedio_creditos_sb (long al_cuenta, long al_cve_carrera, long al_cve_plan, ref decimal ad_promedio, ref decimal ad_creditos)
public function integer of_corte_promedio_creditos (long al_cuenta, long al_cve_carrera, long al_cve_plan, ref decimal ad_promedio, ref decimal ad_creditos, ref long al_cve_flag_promedio)
public function decimal of_obten_cred_egresado (long al_cve_carrera, long al_cve_plan)
public function decimal of_corte_egresado (long al_cuenta, long al_cve_carrera, long al_cve_plan, integer ai_periodo, integer ai_anio, ref integer ai_egresado)
public function integer of_obten_periodo_cambio_nota (ref integer ai_periodo, ref integer ai_anio, string as_tipo_periodo)
end prototypes

public function integer of_obten_cve_flag_promedio (long al_cuenta);//of_obten_cve_flag_promedio
//
//Obtiene el flag_promedio del alumno en cuestion
//
//Recibe
//al_cuenta			long


Integer  li_codigo_sql
Long ll_cve_flag_promedio
String ls_mensaje_sql

Select cve_flag_promedio
Into :ll_cve_flag_promedio
From banderas 
Where cuenta = :al_cuenta
Using gtr_sce;

ls_mensaje_sql= gtr_sce.SqlErrtext
li_codigo_sql= gtr_sce.SqlCode

IF li_codigo_sql =-1 THEN
	Messagebox("Error al consultar banderas", ls_mensaje_sql, StopSign!)
	return li_codigo_sql
ELSEIF li_codigo_sql =100 THEN
	Messagebox("Alumno "+string(al_cuenta)+"-"+obten_digito(al_cuenta)+"inexistente",ls_mensaje_sql,StopSign!)
	li_codigo_sql = -1
	return li_codigo_sql
END IF

RETURN ll_cve_flag_promedio


end function

public function integer of_obten_cve_flag_serv_social (long al_cuenta);//of_obten_cve_flag_serv_social
//
//Obtiene el flag_serv_social del alumno en cuestion
//
//Recibe
//al_cuenta			long


Integer  li_codigo_sql
Long ll_cve_flag_serv_social
String ls_mensaje_sql

Select cve_flag_serv_social
Into :ll_cve_flag_serv_social
From banderas 
Where cuenta = :al_cuenta
Using gtr_sce;

ls_mensaje_sql= gtr_sce.SqlErrtext
li_codigo_sql= gtr_sce.SqlCode

IF li_codigo_sql =-1 THEN
	Messagebox("Error al consultar banderas", ls_mensaje_sql, StopSign!)
	return li_codigo_sql
ELSEIF li_codigo_sql =100 THEN
	Messagebox("Alumno "+string(al_cuenta)+"-"+obten_digito(al_cuenta)+"inexistente",ls_mensaje_sql,StopSign!)
	li_codigo_sql = -1
	return li_codigo_sql
END IF

RETURN ll_cve_flag_serv_social


end function

public function decimal of_obten_puntaje_min (long al_cve_carrera, long al_cve_plan);//of_obten_puntaje_min
//
//Obtiene el puntaje minimo del plan de estudios correspondiente
//
//Recibe
//al_cve_carrera	long
//al_cve_plan		long


Integer  li_codigo_sql
decimal ld_puntaje_min
String ls_mensaje_sql

Select puntaje_min
Into :ld_puntaje_min
From plan_estudios 
Where cve_carrera = :al_cve_carrera
and   cve_plan    = :al_cve_plan
Using gtr_sce;

ls_mensaje_sql= gtr_sce.SqlErrtext
li_codigo_sql= gtr_sce.SqlCode

IF li_codigo_sql =-1 THEN
	Messagebox("Error al consultar plan_estudios", ls_mensaje_sql, StopSign!)
	return li_codigo_sql
ELSEIF li_codigo_sql =100 THEN
	Messagebox("Plan_estudios inexistente", ls_mensaje_sql, StopSign!)
	li_codigo_sql = -1
	return li_codigo_sql
END IF

RETURN ld_puntaje_min


end function

public function integer of_obten_cred_serv_social (long al_cve_carrera, long al_cve_plan);//of_obten_cred_serv_social
//
//Obtiene los creditos para el servicio social del plan de estudios correspondiente
//
//Recibe
//al_cve_carrera	long
//al_cve_plan		long


Integer  li_codigo_sql
long ll_cred_serv_social
String ls_mensaje_sql

Select cred_serv_social
Into :ll_cred_serv_social
From plan_estudios 
Where cve_carrera = :al_cve_carrera
and   cve_plan    = :al_cve_plan
Using gtr_sce;

ls_mensaje_sql= gtr_sce.SqlErrtext
li_codigo_sql= gtr_sce.SqlCode

IF li_codigo_sql =-1 THEN
	Messagebox("Error al consultar plan_estudios", ls_mensaje_sql, StopSign!)
	return li_codigo_sql
ELSEIF li_codigo_sql =100 THEN
	Messagebox("Plan_estudios inexistente", ls_mensaje_sql, StopSign!)
	li_codigo_sql = -1
	return li_codigo_sql
END IF

RETURN ll_cred_serv_social


end function

public function integer of_curso_tema_integracion (long al_cuenta, long al_cve_carrera, long al_cve_plan, long al_area);// Obtiene si el alumno curso  y aprobo alguna materia del area correspondiente de integración
//
// of_curso_tema_integracion
//
// Recibe:
// al_cuenta		long
//	al_cve_carrera	long
//	al_cve_plan		long
// area				long

Integer  li_codigo_sql, li_rows_historico
String ls_mensaje_sql, ls_calificacion

Select count(h.cuenta)
Into :li_rows_historico
From historico h, area_mat am
Where h.cuenta = :al_cuenta 
And	h.cve_carrera = :al_cve_carrera
And	h.cve_plan = :al_cve_plan
And	h.cve_mat = am.cve_mat
And   h.calificacion in ('6','7','8','9','10','AC','MB','B','S','RE','E') 
And	am.cve_area = :al_area
Using gtr_sce;


ls_mensaje_sql= gtr_sce.SqlErrtext
li_codigo_sql= gtr_sce.SqlCode


IF li_codigo_sql =-1 THEN
	Messagebox("Error al consultar en historico el area de integracion ["&
	           +string(al_area)+"]",ls_mensaje_sql,StopSign!)
	return -1				  
ELSEIF li_codigo_sql =100 THEN
	//No existen registros (con el count no debería entrar aqui)
	return 0
ELSEIF li_codigo_sql =0 THEN
	IF li_rows_historico>=1 THEN
		li_rows_historico= 1
	END IF
	return li_rows_historico
END IF

RETURN li_rows_historico


end function

public function integer of_corte_integracion (long al_cuenta, long al_cve_carrera, long al_cve_plan, ref integer ai_ya_puede, ref integer ai_ya_curso);//of_corte_integracion
//
//Efectua un corte de integracion para el alumno recibido y devuelve si ya puede cursar y si ya cursó
//
//Recibe
//al_cuenta			long
//al_cve_carrera	long
//al_cve_plan		long
//ai_ya_puede		integer
//ai_ya_curso		integer
long ll_cred_integracion
decimal ld_promedio, ldc_creditos
integer li_calcula_promedio, li_puede_integracion
integer li_fundamental, li_tema_1, li_tema_2, li_tema_3, li_tema_4, 	li_area_fundamental_tsu
integer li_area_fundamental, li_area_tema_1, li_area_tema_2, li_area_tema_3, li_area_tema_4, li_area_tema_1_tsu
string ls_mensaje_sql, ls_nivel
integer li_codigo_sql, li_obtiene_nivel


ll_cred_integracion = of_obten_cred_integracion(al_cve_carrera, al_cve_plan)

//Ejecuta el stored procedure que calcula tanto el promedio como el número de créditos acumulados
li_calcula_promedio = of_calcula_promedio(al_cuenta,al_cve_carrera, al_cve_plan, ld_promedio, ldc_creditos)
	
IF li_calcula_promedio = -1 THEN
	MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_integracion",StopSign!)
	return li_calcula_promedio
END IF

// Se obtiene el nivel de acuerdo a la carrera
li_obtiene_nivel = of_obten_nivel_carrera (al_cve_carrera,ls_nivel)
IF li_obtiene_nivel = -1 THEN
	MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_integracion, of_obten_nivel_carrera()",StopSign!)
	return li_obtiene_nivel
END IF

//El alumno ya curso los creditos necesarios para integracion
IF ll_cred_integracion <= ldc_creditos THEN
	li_puede_integracion = 1
ELSE	
	li_puede_integracion = 0
END IF

ai_ya_puede = li_puede_integracion



// Se recuperan las areas de las materias de integración para verificar cada una.
LONG ll_area_fundamental 
LONG ll_area_tema1
LONG ll_area_tema2
LONG ll_area_tema3
LONG ll_area_tema4

SELECT cve_area_integ_fundamental, cve_area_integ_tema1, cve_area_integ_tema2, cve_area_integ_tema3, cve_area_integ_tema4 
INTO :ll_area_fundamental, :ll_area_tema1, :ll_area_tema2, :ll_area_tema3, :ll_area_tema4 
FROM plan_estudios 
WHERE cve_carrera = :al_cve_carrera 
AND cve_plan = :al_cve_plan
USING gtr_sce;  
IF gtr_sce.SQLCODE < 0 THEN 
	
END IF


// Se verifica Tema fundamental 1
IF ll_area_fundamental > 0 THEN 
	li_fundamental = of_curso_tema_integracion(al_cuenta, al_cve_carrera, al_cve_plan, ll_area_fundamental)
	IF li_fundamental = -1 THEN
		MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_integracion",StopSign!)
		return li_fundamental
	END IF
END IF

// Se verifica Tema 1
IF ll_area_tema1 > 0 THEN 
	li_tema_1 = of_curso_tema_integracion(al_cuenta, al_cve_carrera, al_cve_plan, ll_area_tema1)
	IF li_fundamental = -1 THEN
		MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_integracion",StopSign!)
		return li_fundamental
	END IF
END IF 

// Se verifica Tema 2
IF ll_area_tema2 > 0 THEN 
	li_tema_2 = of_curso_tema_integracion(al_cuenta, al_cve_carrera, al_cve_plan, ll_area_tema2)
	IF li_fundamental = -1 THEN
		MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_integracion",StopSign!)
		return li_fundamental
	END IF
END IF

// Se verifica Tema 3 
IF ll_area_tema3 > 0 THEN 
	li_tema_3 = of_curso_tema_integracion(al_cuenta, al_cve_carrera, al_cve_plan, ll_area_tema3)
	IF li_fundamental = -1 THEN
		MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_integracion",StopSign!)
		return li_fundamental
	END IF
END IF

// Se verifica Tema 4 
IF ll_area_tema4 > 0 THEN 
	li_tema_4 = of_curso_tema_integracion(al_cuenta, al_cve_carrera, al_cve_plan, ll_area_tema4)
	IF li_fundamental = -1 THEN
		MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_integracion",StopSign!)
		return li_fundamental
	END IF
END IF 
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
// Se inicializa bandera como ya cursó 
ai_ya_curso = 1 
IF ll_area_fundamental > 0 AND li_fundamental = 0 THEN ai_ya_curso = 0 
IF ll_area_tema1 > 0 AND li_tema_1 = 0 THEN ai_ya_curso = 0  
IF ll_area_tema2 > 0 AND li_tema_2 = 0 THEN ai_ya_curso = 0  
IF ll_area_tema3 > 0 AND li_tema_3 = 0 THEN ai_ya_curso = 0  
IF ll_area_tema4 > 0 AND li_tema_4 = 0 THEN ai_ya_curso = 0  
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		

UPDATE banderas
SET tema_fundamental_1 = :li_fundamental,
	tema_1 = :li_tema_1,
	tema_2 = :li_tema_2,
	tema_3 = :li_tema_3,
	tema_4 = :li_tema_4,
	puede_integracion = :li_puede_integracion
FROM banderas
WHERE cuenta = :al_cuenta
USING gtr_sce;

ls_mensaje_sql= gtr_sce.SqlErrtext
li_codigo_sql= gtr_sce.SqlCode

IF li_codigo_sql =-1 THEN
	ROLLBACK USING gtr_sce;
	Messagebox("Error al actualizar las banderas",ls_mensaje_sql,StopSign!)
	RETURN -1
ELSEIF li_codigo_sql =100 THEN
	ROLLBACK USING gtr_sce;
	Messagebox("Alumno "+string(al_cuenta)+"-"+obten_digito(al_cuenta)+"inexistente",ls_mensaje_sql,StopSign!)
	RETURN -1
ELSEIF li_codigo_sql =0 THEN
	COMMIT USING gtr_sce;
END IF


RETURN 0







// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 
// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 
////of_corte_integracion
////
////Efectua un corte de integracion para el alumno recibido y devuelve si ya puede cursar y si ya cursó
////
////Recibe
////al_cuenta			long
////al_cve_carrera	long
////al_cve_plan		long
////ai_ya_puede		integer
////ai_ya_curso		integer
//long ll_cred_integracion, ll_creditos
//decimal ld_promedio
//integer li_calcula_promedio, li_puede_integracion
//integer li_fundamental, li_tema_1, li_tema_2, li_tema_3, li_tema_4, 	li_area_fundamental_tsu
//integer li_area_fundamental, li_area_tema_1, li_area_tema_2, li_area_tema_3, li_area_tema_4, li_area_tema_1_tsu
//string ls_mensaje_sql, ls_nivel
//integer li_codigo_sql, li_obtiene_nivel
//
//
//ll_cred_integracion = of_obten_cred_integracion(al_cve_carrera, al_cve_plan)
//
////Ejecuta el stored procedure que calcula tanto el promedio como el número de créditos acumulados
//li_calcula_promedio = of_calcula_promedio(al_cuenta,al_cve_carrera, al_cve_plan, ld_promedio, ll_creditos)
//	
//IF li_calcula_promedio = -1 THEN
//	MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_integracion",StopSign!)
//	return li_calcula_promedio
//END IF
//
//// Se obtiene el nivel de acuerdo a la carrera
//li_obtiene_nivel = of_obten_nivel_carrera (al_cve_carrera,ls_nivel)
//IF li_obtiene_nivel = -1 THEN
//	MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_integracion, of_obten_nivel_carrera()",StopSign!)
//	return li_obtiene_nivel
//END IF
//
////El alumno ya curso los creditos necesarios para integracion
//IF ll_cred_integracion <= ll_creditos THEN
//	li_puede_integracion = 1
//ELSE	
//	li_puede_integracion = 0
//END IF
//
//ai_ya_puede = li_puede_integracion
//
//IF al_cve_plan<>6 THEN
//
////Revisa los temas de Integracion
//
//	li_area_fundamental = 2201 
//	
//	li_area_tema_1 = 2202
//	
//	li_area_tema_2 = 2203
//	
//	li_area_tema_3 = 2204
//	
//	li_area_tema_4 = 2205
//	
//	/*Temas de Integración TSU*/
//	li_area_fundamental_tsu = 335
//	
//	li_area_tema_1_tsu = 336
//
//	/*Para TSU*/
//	IF ls_nivel = 'T' THEN
//		li_fundamental = of_curso_tema_integracion(al_cuenta, al_cve_carrera, al_cve_plan, li_area_fundamental_tsu)
//		IF li_fundamental = -1 THEN
//			MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_integracion",StopSign!)
//			return li_fundamental
//		END IF
//
//		li_tema_1 = of_curso_tema_integracion(al_cuenta, al_cve_carrera, al_cve_plan, li_area_tema_1_tsu)
//		IF li_tema_1 = -1 THEN
//			MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_integracion",StopSign!)
//			return li_tema_1
//		END IF
//	ELSE
//		li_fundamental = of_curso_tema_integracion(al_cuenta, al_cve_carrera, al_cve_plan, li_area_fundamental)
//		IF li_fundamental = -1 THEN
//			MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_integracion",StopSign!)
//			return li_fundamental
//		END IF
//
//		li_tema_1 = of_curso_tema_integracion(al_cuenta, al_cve_carrera, al_cve_plan, li_area_tema_1)
//		IF li_tema_1 = -1 THEN
//			MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_integracion",StopSign!)
//			return li_tema_1
//		END IF
//	END IF	
//	
//	li_tema_2 = of_curso_tema_integracion(al_cuenta, al_cve_carrera, al_cve_plan, li_area_tema_2)
//	IF li_tema_2 = -1 THEN
//		MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_integracion",StopSign!)
//		return li_tema_2
//	END IF
//
//	li_tema_3 = of_curso_tema_integracion(al_cuenta, al_cve_carrera, al_cve_plan, li_area_tema_3)
//	IF li_tema_3 = -1 THEN
//		MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_integracion",StopSign!)
//		return li_tema_3
//	END IF
//
//	li_tema_4 = of_curso_tema_integracion(al_cuenta, al_cve_carrera, al_cve_plan, li_area_tema_4)
//	IF li_tema_4 = -1 THEN
//		MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_integracion",StopSign!)
//		return li_tema_4
//	END IF
//
//	/*Para TSU*/
//	IF ls_nivel = 'T' THEN	
//		IF li_fundamental>= 1 AND li_tema_1 >= 1  THEN
//			ai_ya_curso= 1
//		ELSE
//			ai_ya_curso= 0
//		END IF
//	ELSE
//		IF li_fundamental>= 1 AND li_tema_1 >= 1 AND li_tema_2>=1 AND li_tema_3>=1 AND li_tema_4>=1 THEN
//			ai_ya_curso= 1
//		ELSE
//			ai_ya_curso= 0
//		END IF
//	END iF
//
//ELSE
//	
////Revisa los temas de Reflexion Universitaria
//
//	li_area_tema_1 = 8061
//	
//	li_area_tema_2 = 8062
//	
//	li_area_tema_3 = 8063
//	
//	li_area_tema_4 = 8064
//	
//	li_fundamental = 0
//
//	li_tema_1 = of_curso_tema_integracion(al_cuenta, al_cve_carrera, al_cve_plan, li_area_tema_1)
//	IF li_tema_1 = -1 THEN
//		MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_integracion",StopSign!)
//		return li_tema_1
//	END IF
//
//	li_tema_2 = of_curso_tema_integracion(al_cuenta, al_cve_carrera, al_cve_plan, li_area_tema_2)
//	IF li_tema_2 = -1 THEN
//		MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_integracion",StopSign!)
//		return li_tema_2
//	END IF
//
//	li_tema_3 = of_curso_tema_integracion(al_cuenta, al_cve_carrera, al_cve_plan, li_area_tema_3)
//	IF li_tema_3 = -1 THEN
//		MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_integracion",StopSign!)
//		return li_tema_3
//	END IF
//
//	li_tema_4 = of_curso_tema_integracion(al_cuenta, al_cve_carrera, al_cve_plan, li_area_tema_4)
//	IF li_tema_4 = -1 THEN
//		MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_integracion",StopSign!)
//		return li_tema_4
//	END IF
//	
//	IF li_tema_1 >= 1 AND li_tema_2>=1 AND li_tema_3>=1 AND li_tema_4>=1 THEN
//		ai_ya_curso= 1
//	ELSE
//		ai_ya_curso= 0
//	END IF
//END IF
//
//	UPDATE banderas
//	SET tema_fundamental_1 = :li_fundamental,
//		tema_1 = :li_tema_1,
//		tema_2 = :li_tema_2,
//		tema_3 = :li_tema_3,
//		tema_4 = :li_tema_4,
//		puede_integracion = :li_puede_integracion
//	FROM banderas
//	WHERE cuenta = :al_cuenta
//	USING gtr_sce;
//
//	ls_mensaje_sql= gtr_sce.SqlErrtext
//	li_codigo_sql= gtr_sce.SqlCode
//
//	IF li_codigo_sql =-1 THEN
//		ROLLBACK USING gtr_sce;
//		Messagebox("Error al actualizar las banderas",ls_mensaje_sql,StopSign!)
//		RETURN -1
//	ELSEIF li_codigo_sql =100 THEN
//		ROLLBACK USING gtr_sce;
//		Messagebox("Alumno "+string(al_cuenta)+"-"+obten_digito(al_cuenta)+"inexistente",ls_mensaje_sql,StopSign!)
//		RETURN -1
//	ELSEIF li_codigo_sql =0 THEN
//		COMMIT USING gtr_sce;
//	END IF
//
//
//RETURN 0
//





end function

public function boolean of_revisa_areas_completas (long al_cuenta, long al_cve_carrera, long al_cve_plan, long al_cve_subsistema, string as_nivel);//of_revisa_areas_completas
//
//Valida que el alumno haya concluido todas las areas correspondientes a su plan de estudios
//
//Recibe
//al_cuenta
//al_cve_carrera
//al_cve_plan
//al_cve_subsistema
//as_nivel

datastore ds_historico_sin_area
datastore ds_historico_area
DataStore ds_Revision, ds_mat_acred


IF NOT isvalid(ds_historico_sin_area) THEN
	ds_historico_sin_area = CREATE datastore
END IF
ds_historico_sin_area.DataObject = "d_hist_sin_area"
ds_historico_sin_area.settransobject(gtr_sce)

IF NOT isvalid(ds_historico_area) THEN
	ds_historico_area = CREATE datastore
END IF
ds_historico_area.DataObject = "d_hist_area"
ds_historico_area.settransobject(gtr_sce)

IF NOT isvalid(ds_Revision) THEN
	ds_Revision = CREATE datastore
END IF
ds_Revision.DataObject = "d_revision_est"
ds_Revision.Settransobject(gtr_sce)

IF NOT isvalid(ds_mat_acred) THEN
	ds_mat_acred = CREATE datastore
END IF
ds_mat_acred.DataObject = "d_mat_acred"
ds_mat_acred.Settransobject(gtr_sce)


int in_i, in_j, in_tot_mat, in_tot_mat_a, in_m, in_renglon, in_area2, in_CreditosComunes, in_area3
int in_FalMe, in_FalMa, in_Areas[14], in_CredMin[14], in_TotCred[14] 
Boolean bo_Egresado = True, lb_rev
Integer in_Minimos = 0

Constant int ABa=1;Constant int AMaOb=2;Constant int AOT=3;Constant int ASS=4;Constant int AMeOb=5
Constant int AI0=6;Constant int AI1=7;Constant int AI2=8;Constant int AI3=9;Constant int AI4=10;
Constant int AMaOp = 11;Constant int AMeOp = 12; 
CONSTANT INT ASEO = 14
CONSTANT INT ASEOp = 13 

ds_Revision.Reset()
ds_mat_acred.Reset()
ds_historico_area.Reset()
ds_historico_sin_area.Reset()

SELECT 	cve_area_basica,					cve_area_mayor_oblig,		cve_area_mayor_opt,
			cve_area_opcion_terminal,		cve_area_servicio_social,
			cve_area_integ_fundamental,	cve_area_integ_tema1,		cve_area_integ_tema2,
			cve_area_integ_tema3,			cve_area_integ_tema4, 
			cve_area_sintesis_eval_oblig,  cve_area_sintesis_eval_opt  
		INTO	:in_Areas[ABa], :in_Areas[AMaOb],	:in_Areas[AMaOp], :in_Areas[AOT], :in_Areas[ASS],
				:in_Areas[AI0], :in_Areas[AI1], 		:in_Areas[AI2],  :in_Areas[AI3], :in_Areas[AI4], 
				:in_Areas[ASEO], :in_Areas[ASEOp] 
		FROM plan_estudios
		WHERE cve_carrera = :al_cve_carrera AND cve_plan = :al_cve_plan
		USING gtr_sce;
		
if IsNull(al_cve_subsistema) then al_cve_subsistema = 0

// Si tiene subsistema se recuperan las areas correspondientes 
if (al_cve_subsistema<> 0) then
	
	SELECT cve_area  INTO :in_Areas[AMeOb] FROM subsistema 
		WHERE cve_subsistema = :al_cve_subsistema 
		AND	cve_carrera = :al_cve_carrera
		AND 	cve_plan = :al_cve_plan
		AND 	clase_area LIKE "OBL"
		USING gtr_sce;

	SELECT cve_area  INTO :in_Areas[AMeOp] FROM subsistema 
		WHERE cve_subsistema = :al_cve_subsistema 
		AND	cve_carrera = :al_cve_carrera
		AND 	cve_plan = :al_cve_plan
		AND 	clase_area LIKE "OPT"
		USING gtr_sce;

//Si no tiene subsistema, se toma el subsistema "UNICO" 
else
	//if as_nivel = "L" Or as_nivel = "T" then
	if as_nivel <> "P" then 
		in_CredMin[AMeOp] = 1
		in_CredMin[AMeOb] = 1
	end if
end if

// Se recupera el TOTAL de materias del Historico sin considerar el área 
ds_historico_sin_area.retrieve(al_cuenta,al_cve_carrera,al_cve_plan)
in_tot_mat = ds_historico_sin_area.rowcount()
ds_mat_acred.insertrow(1)
ds_mat_acred.setitem(1,1,0)
ds_mat_acred.setitem(1,2,0)
if IsNull(in_Areas[AMeOp]) then in_Areas[AMeOp] = 0
if IsNull(in_Areas[AMaOp]) then in_Areas[AMaOp] = 0
if IsNull(in_Areas[ASEOp]) then in_Areas[ASEOp] = 0
in_i = 2

// Se hace ciclo sobre cada una de las áreas 
for in_j = 1 to 14
	if IsNull(in_Areas[in_j]) then in_Areas[in_j] = 0
	
	// Si tiene créditos mínimos, se recuperan 
	if in_CredMin[in_j] <> 1 then
		SELECT creditos_min INTO :in_CredMin[in_j] FROM areas WHERE cve_area = :in_Areas[in_j] USING gtr_sce; 
	end if 
	
	// Si existe un Área definida, se busca si ya se procesó 
	if (in_Areas[in_j] <> 0) then
		in_area2 = 0
		in_area3 = 0
		// Se verifica si el área corresponde al subsistema 
		//****************************//
				// Se recuperan las áreas optativas 
		// Si es la Mayor Optativa, se excluyen la Menor Optativa y la de sintésis_optativa  
		if in_j = AMaOp then 
			in_area2 = in_Areas[AMeOp]
			in_area3 = in_Areas[ASEOp]
		END IF 	
		
		// Si es la Menor Optativa, se excluyen la Mayor Optativa y la de   sintésis_optativa
		if in_j = AMeOp then 
			in_area2 = in_Areas[AMaOp]
			in_area3 = in_Areas[ASEOp]
		END IF 	
		// Si es la Menor Optativa, se excluyen la Mayor Optativa y la de   sintésis_optativa
		if in_j = ASEOp then 
			in_area2 = in_Areas[AMaOp]
			in_area3 = in_Areas[AMeOp]
		END IF 			
		//****************************// 		
		
		
		
//		if in_j = AMaOp then in_area2 = in_Areas[AMeOp]
//		if in_j = AMeOp then in_area2 = in_Areas[AMaOp]
		
		// Se recuperan las materias correspondientes al área. 		
		ds_historico_area.retrieve(al_cuenta,in_Areas[in_j],al_cve_carrera,al_cve_plan, in_area2, in_area3)
		in_tot_mat_a = ds_historico_area.rowcount()
		
		// Ciclo para validar cada una de las materias de área 
		if in_tot_mat_a > 0 then
			
			for in_m=1 to in_tot_mat_a
				
				// Se busca la materia en el DS de Materias sin Área 
				in_renglon = ds_historico_sin_area.find("materias_materia = '" +	ds_historico_area.getitemstring(in_m,3)+"'", 1, in_tot_mat)
				
				if (in_renglon<>0) then
					
					// Si encuentra el registro, se elimina del DS Materias sin Área (DS con TODAS las materias) 
					ds_historico_sin_area.deleterow(in_renglon)
					in_tot_mat --
					
					// Se inserta la materia en el DS de materias acréditadas 
					ds_mat_acred.insertrow(in_i)
					ds_mat_acred.setitem(in_i,1,al_cuenta)//cuenta 
					
					// Se inserta el tipo de Área de la materia. (ver función) 
					ds_mat_acred.setitem(in_i,2,TipoArea(in_j,al_cve_plan))//tipo Area
					ds_mat_acred.setitem(in_i,3,ds_historico_area.getitemstring(in_m,2))//sigla
					ds_mat_acred.setitem(in_i,4,ds_historico_area.getitemstring(in_m,3))//materia 
					// Se obtiene y da formato al periodo 
					ds_mat_acred.setitem(in_i,5,SacaPeriodo(&
								ds_historico_area.getitemnumber(in_m,4),ds_historico_area.getitemnumber(in_m,5),ds_historico_area.getitemnumber(in_m,8)))//periodo
					ds_mat_acred.setitem(in_i,6,ds_historico_area.getitemnumber(in_m,6))//creditos
					
					// Se acu ulan lo créditos 
					in_TotCred[in_j] += ds_historico_area.getitemnumber(in_m,6)
					
					ds_mat_acred.setitem(in_i,7,ds_historico_area.getitemstring(in_m,7))//CalNum
					ds_mat_acred.setitem(in_i,8,ConvierteLetra(ds_historico_area.getitemstring(in_m,7)))//CalLetra
					ds_mat_acred.setitem(in_i,9,ConvierteObservacion(ds_historico_area.getitemnumber(in_m,8),lb_rev))//Observaciones
					
					// Se recupera y da formato al periodo númerico 
					ds_mat_acred.setitem(in_i,10,string(&
								ds_historico_area.getitemnumber(in_m,4)-1900)+string(ds_historico_area.getitemnumber(in_m,5)))//periodonumerico
								
					ds_mat_acred.setitem(in_i,11,ds_historico_area.getitemnumber(in_m,9))//sigla
					ds_mat_acred.setitem(in_i,12,in_j)//clave del area
					in_i++
				end if
			next
		end if
	end  if
next

//	ds_mat_acred.SetFilter("tipoarea="+string(AMeOp))
//	ds_mat_acred.Filter()
//	ds_mat_acred.GroupCalc()
//	if (ds_mat_acred.rowcount() > 0 ) then
//		CreditosComunes = ds_mat_acred.getitemnumber(1,"creditos_cursados")
//	end if
//	ds_mat_acred.SetFilter("")
//	ds_mat_acred.Filter()
in_CreditosComunes = 0

// Si todavía hay materias en Histórico sin Área, se verifica si son optativas. 
if (ds_historico_sin_area.RowCount() > 0) then 
	
	// En este ciclo se hace sobre las Optativas (INDICE 11 al 13 DEL ARREGLO) 
	//for in_j = AMaOp to AmeOp
	// Se modifica el ciclo para considerar el área nueva.
	for in_j = AMaOp to ASEOp
		
		// Se recuperan las materias de estas áreas opcionales
		ds_historico_area.retrieve(al_cuenta,in_Areas[in_j],al_cve_carrera,al_cve_plan, 0)
		
		 // Se verifica si existen áreas opcionales definidas
		if (in_Areas[in_j] <> 0) then
			
			// Se verifica si existen máterias de 
			in_tot_mat_a = ds_historico_area.rowcount()
			if in_tot_mat_a > 0 then
				
				// Se hace ciclo sobre las materias del área opcional 
				for in_m=1 to in_tot_mat_a 
					
					// (Número de créditos acumulados + Números de créditos opcionales) <= Créditos Mínimos OR Índice Actual = Índice Área Menor Optativa 
					if (in_TotCred[in_j] + ds_historico_area.getitemnumber(in_m,6) <= in_CredMin[in_j]) OR (in_j = AMeOp) then
						
						// Se verifica si ya se proceso la materia en el DS de Materias sin Área. 
						in_renglon = ds_historico_sin_area.find("materias_materia = '" + ds_historico_area.getitemstring(in_m,3) + "' ", 1, in_tot_mat)
						
						// Si no se ha procesado, se agrega al ds de salida
						if (in_renglon<>0) then
							ds_historico_sin_area.deleterow(in_renglon)
							in_tot_mat --
							ds_mat_acred.insertrow(in_i)
							ds_mat_acred.setitem(in_i,1,al_cuenta)//cuenta
							ds_mat_acred.setitem(in_i,2,TipoArea(in_j,al_cve_plan))//tipo Area
							ds_mat_acred.setitem(in_i,3,ds_historico_area.getitemstring(in_m,2))//sigla
							ds_mat_acred.setitem(in_i,4,ds_historico_area.getitemstring(in_m,3))//materia
							
							//Se recupera y da formato al periodo 
							ds_mat_acred.setitem(in_i,5,SacaPeriodo(ds_historico_area.getitemnumber(in_m,4),ds_historico_area.getitemnumber(in_m,5),ds_historico_area.getitemnumber(in_m,8)))//periodo
														
							ds_mat_acred.setitem(in_i,6,ds_historico_area.getitemnumber(in_m,6))//creditos
							
							// Se recuperan y acumulan los créditos 
							in_TotCred[in_j] += ds_historico_area.getitemnumber(in_m,6)
							in_CreditosComunes += ds_historico_area.getitemnumber(in_m,6)
							
							ds_mat_acred.setitem(in_i,7,ds_historico_area.getitemstring(in_m,7))//CalNum
							ds_mat_acred.setitem(in_i,8,ConvierteLetra(ds_historico_area.getitemstring(in_m,7)))//CalLetra
							ds_mat_acred.setitem(in_i,9,ConvierteObservacion(ds_historico_area.getitemnumber(in_m,8),lb_rev))//Observaciones
							
							// Se recupera y da formato al periodo numérico. 
							ds_mat_acred.setitem(in_i,10,string(ds_historico_area.getitemnumber(in_m,4)-1900)+string(ds_historico_area.getitemnumber(in_m,5)))//periodonumerico
										
							ds_mat_acred.setitem(in_i,11,ds_historico_area.getitemnumber(in_m,9))//sigla
							ds_mat_acred.setitem(in_i,12,in_j)//clave del area
							in_i++
						end if
					end if
				next
			end if
		end if
	next
end if

ds_Revision.reset()

for in_i = 1 to 14
	ds_mat_acred.SetFilter("tipoarea="+string(in_i))
	ds_mat_acred.Filter()
	ds_mat_acred.GroupCalc()
	ds_Revision.InsertRow(in_i)
	ds_Revision.SetItem(in_i,1,in_CredMin[in_i])
	if (ds_mat_acred.RowCount()>0) then
		ds_Revision.SetItem(in_i,2,ds_mat_acred.getitemnumber(1,"creditos_cursados"))
//		if (i = AMeOp) then CreditosComunes = ds_mat_acred.getitemnumber(1,&
//												"creditos_cursados") - CreditosComunes
	else
		ds_Revision.SetItem(in_i,2,0)
	end if
next

ds_mat_acred.SetFilter("")
ds_mat_acred.Filter()
ds_mat_acred.SetSort("tipoarea A")
ds_mat_acred.Sort()
ds_mat_acred.GroupCalc()

in_FalMa = ds_Revision.getitemnumber(AMaOp,"faltantes")
in_FalMe = ds_Revision.getitemnumber(AMeOp,"faltantes")
if (in_FalMe < 0) then
	if (in_FalMa > 0) and (in_FalMe+in_FalMa <= 0) and (in_CreditosComunes >= in_FalMa) then
		ds_Revision.setitem(AMaOp,"cursados", &
		ds_Revision.getitemnumber(AMaOp,"cursados") + in_FalMa)
		ds_Revision.setitem(AMeOp,"cursados", &
		ds_Revision.getitemnumber(AMeOp,"cursados") - in_FalMa)
	end if
end if

if (in_FalMa < 0) then
	if (in_FalMe > 0) and (in_FalMe+in_FalMa <= 0) and (in_CreditosComunes >= in_FalMe) then
		ds_Revision.setitem(AMeOp,"cursados", &
		ds_Revision.getitemnumber(AMeOp,"cursados") + in_FalMe)
		ds_Revision.setitem(AMaOp,"cursados", &
		ds_Revision.getitemnumber(AMaOp,"cursados") - in_FalMe)
	end if
end if

//if ((al_cve_plan = 1) OR (al_cve_plan = 2)) AND (as_nivel = "L") then
if ((al_cve_plan = 1) OR (al_cve_plan = 2)) AND (as_nivel <> "P") then	
	if (ds_Revision.getitemnumber(AI1,"cursados")+ds_Revision.getitemnumber(AI2,"cursados")+&
		ds_Revision.getitemnumber(AI3,"cursados")+ds_Revision.getitemnumber(AI4,"cursados")+&
		ds_Revision.getitemnumber(AI0,"cursados")>=40)then
				ds_Revision.setitem(AI0,"minimos",ds_Revision.getitemnumber(AI0,"cursados"))
				ds_Revision.setitem(AI1,"minimos",ds_Revision.getitemnumber(AI1,"cursados"))
				ds_Revision.setitem(AI2,"minimos",ds_Revision.getitemnumber(AI2,"cursados"))
				ds_Revision.setitem(AI3,"minimos",ds_Revision.getitemnumber(AI3,"cursados"))
				ds_Revision.setitem(AI4,"minimos",ds_Revision.getitemnumber(AI4,"cursados"))
	end if
end if

//if  (((al_cve_plan = 3) OR (al_cve_plan = 4)) AND as_nivel = "L") then
if  (((al_cve_plan = 3) OR (al_cve_plan = 4)) AND as_nivel <> "P") then	
	if (ds_Revision.getitemnumber(AI1,"cursados")+ds_Revision.getitemnumber(AI2,"cursados")+&
		ds_Revision.getitemnumber(AI3,"cursados")+ds_Revision.getitemnumber(AI4,"cursados")>=32)then
				ds_Revision.setitem(AI1,"minimos",ds_Revision.getitemnumber(AI1,"cursados"))
				ds_Revision.setitem(AI2,"minimos",ds_Revision.getitemnumber(AI2,"cursados"))
				ds_Revision.setitem(AI3,"minimos",ds_Revision.getitemnumber(AI3,"cursados"))
				ds_Revision.setitem(AI4,"minimos",ds_Revision.getitemnumber(AI4,"cursados"))
	end if
end if

For in_i = 1 To 14
	in_Minimos = in_Minimos + ds_Revision.GetItemNumber(in_i,"minimos")
	If ds_Revision.getitemnumber(in_i,"faltantes") > 0 Then 
		bo_Egresado = False
		Exit
	End if
Next	

If	bo_Egresado And in_Minimos > 0 Then
	Return True		// Egresado ok 
Else
	Return False	// Faltan Créditos
End if 
end function

public function integer of_obten_cred_integracion (long al_cve_carrera, long al_cve_plan);//of_obten_cred_integracion
//
//Obtiene los creditos para cursar materias de integracion/reflexion universitaria
//del plan de estudios correspondiente
//
//Recibe
//al_cve_carrera	long
//al_cve_plan		long


Integer  li_codigo_sql
long ll_cred_integracion
String ls_mensaje_sql

//Actualmente es un valor fijo, cambiese la funcion si se añade al plan de estudios
//para que sea distinto por carrera

ll_cred_integracion = 72

RETURN ll_cred_integracion


end function

public function long of_obten_calificacion_ss (long al_cuenta, long al_cve_carrera, long al_cve_plan, ref string as_calificacion);// Obtiene si el alumno está cursando o curso el servicio social para una carrera y el plan de un alumno
//
// of_obten_calificacion_ss
//
// Recibe:
// al_cuenta		long
//	al_cve_carrera	long
//	al_cve_plan		long
// as_calificacion string

Integer  li_codigo_sql, li_rows_historico
String ls_mensaje_sql, ls_calificacion

//Select calificacion
//Into :ls_calificacion
//From historico 
//Where cuenta = :al_cuenta 
//And	cve_carrera = :al_cve_carrera
//And	cve_plan = :al_cve_plan
//And	cve_mat in (8763, 3748)
//And   calificacion in ('AC', 'IN' ) 
//Using gtr_sce;

//**********************************
// Se recupera la calkificación en base a 

Select  TOP 1 historico.calificacion
Into :ls_calificacion
From historico 
Where historico.cuenta = :al_cuenta 
And	historico.cve_carrera = :al_cve_carrera
And	historico.cve_plan = :al_cve_plan
And	historico.cve_mat in (	SELECT am.cve_mat FROM area_mat am 
									WHERE am.cve_area IN(SELECT pe2.cve_area_servicio_social 
																	FROM plan_estudios pe2
																	WHERE historico.cve_carrera = pe2.cve_carrera 
																	AND historico.cve_plan = pe2.cve_plan)

)
And   calificacion in ('AC', 'IN' ) 
Using gtr_sce;
//**********************************

ls_mensaje_sql= gtr_sce.SqlErrtext
li_codigo_sql= gtr_sce.SqlCode
as_calificacion = ls_calificacion

IF li_codigo_sql =-1 THEN
	Messagebox("Error al consultar en historico el servicio social ["&
	           +string(al_cuenta)+"-"+obten_digito(al_cuenta)+"], probable duplicidad",ls_mensaje_sql,StopSign!)
	return -1				  
ELSEIF li_codigo_sql =100 THEN
	//No ha cursado el servicio social
	return 0
ELSEIF li_codigo_sql =0 THEN
	return 1
END IF

RETURN li_codigo_sql


end function

public function integer of_corte_servicio_social (long al_cuenta, long al_cve_carrera, long al_cve_plan, ref integer ai_ya_puede, ref integer ai_ya_curso);//of_corte_servicio_social
//
//Efectua un corte de servicio social para el alumno recibido y devuelve si ya puede cursar y si ya cursó
//
//Recibe
//al_cuenta			long
//al_cve_carrera	long
//al_cve_plan		long
//ai_ya_puede		integer
//ai_ya_curso		integer


integer li_cve_flag_serv_social, li_res_obten_calificacion_ss, li_cred_cred_serv_social
string ls_calificacion
integer li_calcula_promedio
decimal ld_promedio, ldc_creditos
string ls_mensaje_sql
integer li_codigo_sql

//Obtiene el flag del servicio social
li_cve_flag_serv_social = of_obten_cve_flag_serv_social(al_cuenta)

IF li_cve_flag_serv_social = -1 THEN
	MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_servicio_social",StopSign!)
	return li_cve_flag_serv_social
END IF

//Obtiene la calificacion del servicio social
li_res_obten_calificacion_ss = of_obten_calificacion_ss(al_cuenta, al_cve_carrera, al_cve_plan, ls_calificacion)

IF li_res_obten_calificacion_ss = -1 THEN
	MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_servicio_social",StopSign!)
	return li_res_obten_calificacion_ss
END IF

//Obtiene los creditos del servicio social
li_cred_cred_serv_social =of_obten_cred_serv_social(al_cve_carrera, al_cve_plan)

IF li_cred_cred_serv_social = -1 THEN
	MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_servicio_social",StopSign!)
	return li_cred_cred_serv_social
END IF

//Ejecuta el stored procedure que calcula tanto el promedio como el número de créditos acumulados
li_calcula_promedio = of_calcula_promedio(al_cuenta, al_cve_carrera, al_cve_plan, ld_promedio, ldc_creditos)
	
IF li_calcula_promedio = -1 THEN
	MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_promedio_creditos",StopSign!)
	return li_calcula_promedio
END IF


CHOOSE CASE li_res_obten_calificacion_ss
	//NO TIENE EL SERVICIO SOCIAL EN HISTORICO		
	CASE 0
		IF ldc_creditos >= li_cred_cred_serv_social THEN			
			//PONE EL FLAG EN: YA PUEDE CURSAR
			li_cve_flag_serv_social = 1	
			ai_ya_puede = 1
		ELSE
			//PONE EL FLAG EN: NO HA CURSADO
			li_cve_flag_serv_social = 0			
			ai_ya_puede = 0
		END IF
		ai_ya_curso = 0
	//TIENE EL SERVICIO SOCIAL EN HISTORICO 
	CASE 1
		//LO TIENE NO ACREDITADO
		IF ls_calificacion="IN" THEN
			//PONE EL FLAG EN: YA PUEDE CURSAR
			li_cve_flag_serv_social = 1	
			ai_ya_puede = 1
			ai_ya_curso = 0
		ELSEIF ls_calificacion="AC" THEN	
			//PONE EL FLAG EN: ESTA O YA CURSO
			li_cve_flag_serv_social = 2
			ai_ya_puede = 1
			ai_ya_curso = 1			
		END IF
	CASE ELSE 
		MessageBox("Error en flag_serv_social", "El valor["+string(li_cve_flag_serv_social)+"] está fuera de rango",StopSign!)
		ai_ya_puede = 0
		ai_ya_curso = 0
END CHOOSE

	UPDATE banderas
	SET cve_flag_serv_social = :li_cve_flag_serv_social
	FROM banderas
	WHERE cuenta = :al_cuenta
	USING gtr_sce;

	ls_mensaje_sql= gtr_sce.SqlErrtext
	li_codigo_sql= gtr_sce.SqlCode

	IF li_codigo_sql =-1 THEN
		ROLLBACK USING gtr_sce;
		Messagebox("Error al actualizar las banderas",ls_mensaje_sql,StopSign!)
		RETURN -1
	ELSEIF li_codigo_sql =100 THEN
		ROLLBACK USING gtr_sce;
		Messagebox("Alumno "+string(al_cuenta)+"-"+obten_digito(al_cuenta)+"inexistente",ls_mensaje_sql,StopSign!)
		RETURN -1
	ELSEIF li_codigo_sql =0 THEN
		COMMIT USING gtr_sce;
	END IF

return 0
end function

public function integer of_obten_carrera_plan_sub_niv (long al_cuenta, ref long al_cve_carrera, ref long al_cve_plan, ref long al_cve_subsistema, ref string as_nivel, ref integer ai_egresado_anterior);// Obtiene la carrera, el plan, subsistema y nivel de un alumno, 
// correspondiente a su información de académicos
//
// of_obten_carrera_plan_sub_niv
//
// Recibe:
// al_cuenta			long
//	al_cve_carrera		long
//	al_cve_plan			long
//	al_cve_subsistema long
//	as_nivel				string

Integer  li_codigo_sql
String ls_mensaje_sql

Select cve_carrera,   cve_plan,     cve_subsistema,     nivel, 	egresado  
Into :al_cve_carrera, :al_cve_plan, :al_cve_subsistema, :as_nivel, :ai_egresado_anterior 
From academicos 
Where cuenta = :al_cuenta 
Using gtr_sce;

ls_mensaje_sql= gtr_sce.SqlErrtext
li_codigo_sql= gtr_sce.SqlCode

IF li_codigo_sql =-1 THEN
	Messagebox("Error al consultar los académicos",ls_mensaje_sql,StopSign!)
ELSEIF li_codigo_sql =100 THEN
	Messagebox("Alumno inexistente",ls_mensaje_sql,StopSign!)
END IF

RETURN li_codigo_sql


end function

public function integer of_obten_carrera_plan (long al_cuenta, ref long al_cve_carrera, ref long al_cve_plan);// Obtiene la carrera y el plan de un alumno, correspondiente a su información de académicos
//
// of_obten_carrera_plan
//
// Recibe:
// al_cuenta		long
//	al_cve_carrera	long
//	al_cve_plan		long


Integer  li_codigo_sql
String ls_mensaje_sql, ls_nivel
Long	ll_cve_subsistema
Integer li_egresado_anterior

li_codigo_sql = of_obten_carrera_plan_sub_niv(al_cuenta, al_cve_carrera, al_cve_plan, ll_cve_subsistema, ls_nivel, li_egresado_anterior)

RETURN li_codigo_sql


end function

public function integer of_obten_nombre_completo (long al_cuenta, ref string as_nombre_completo);// Obtiene el nombre completo de un alumno
//
// of_obten_nombre_completo
//
// Recibe:
// al_cuenta			long
// Devuelve:
// as_nombre_completo string

Integer  li_codigo_sql
String ls_mensaje_sql

Select nombre_completo
Into :as_nombre_completo
From alumnos 
Where cuenta = :al_cuenta 
Using gtr_sce;

ls_mensaje_sql= gtr_sce.SqlErrtext
li_codigo_sql= gtr_sce.SqlCode

IF li_codigo_sql =-1 THEN
	Messagebox("Error al consultar los alumnos",ls_mensaje_sql,StopSign!)
ELSEIF li_codigo_sql =100 THEN
	Messagebox("Alumno inexistente",ls_mensaje_sql,StopSign!)
END IF

RETURN li_codigo_sql


end function

public function integer of_obten_periodo_egreso (ref integer ai_periodo, ref integer ai_anio);// Obtiene el periodo y año de egreso señalado en los parámetros
//
// of_obten_periodo_egreso
//
// Devuelve:
// ai_periodo			integer
//	ai_anio				integer

Integer  li_codigo_sql, li_cve_proceso_egreso = 9
String ls_mensaje_sql

Select periodo,
		anio
Into :ai_periodo,
		:ai_anio
From periodos_por_procesos 
Where cve_proceso = :li_cve_proceso_egreso
Using gtr_sce;

ls_mensaje_sql= gtr_sce.SqlErrtext
li_codigo_sql= gtr_sce.SqlCode

IF li_codigo_sql =-1 THEN
	Messagebox("Error al consultar los periodos_por_procesos para egreso",ls_mensaje_sql,StopSign!)
ELSEIF li_codigo_sql =100 THEN
	Messagebox("Proceso de egreso inexistente",ls_mensaje_sql,StopSign!)
END IF

RETURN li_codigo_sql


end function

public function integer of_actualiza_egresado (long al_cuenta, integer ai_egresado, integer ai_periodo_egre, integer ai_anio_egre, integer ai_creditos, decimal ad_promedio, integer ai_egresado_anterior);//of_actualiza_egresado
//Actualiza los valores  del alumno recibido correspondiente a su egreso, anio y periodo de egreso 
//y sus creditos y promedio
//
//Recibe
//al_cuenta			long
//ai_egresado		integer
//ai_periodo_egre	integer
//ai_anio_egre		integer
//ai_creditos		integer
//ad_promedio		decimal

string ls_mensaje_sql
integer li_codigo_sql


//Si ya es egresado, no es necesario moverle los periodos de egreso
IF ai_egresado_anterior <> 1 THEN
	UPDATE academicos
	SET egresado         = :ai_egresado,
		periodo_egre      = :ai_periodo_egre,
		anio_egre         = :ai_anio_egre,
		creditos_cursados = :ai_creditos,
		promedio          = :ad_promedio
	FROM academicos
	WHERE cuenta = :al_cuenta
	USING gtr_sce;
ELSE
	UPDATE academicos
	SET egresado         = :ai_egresado,
		creditos_cursados = :ai_creditos,
		promedio          = :ad_promedio
	FROM academicos
	WHERE cuenta = :al_cuenta
	USING gtr_sce;	
END IF

	ls_mensaje_sql= gtr_sce.SqlErrtext
	li_codigo_sql= gtr_sce.SqlCode

	IF li_codigo_sql =-1 THEN
		ROLLBACK USING gtr_sce;
		Messagebox("Error al actualizar los academicos",ls_mensaje_sql,StopSign!)
		RETURN -1
	ELSEIF li_codigo_sql =100 THEN
		ROLLBACK USING gtr_sce;
		Messagebox("Alumno "+string(al_cuenta)+"-"+obten_digito(al_cuenta)+"inexistente",ls_mensaje_sql,StopSign!)
		RETURN -1
	ELSEIF li_codigo_sql =0 THEN
		COMMIT USING gtr_sce;
	END IF

return 0
end function

public function integer of_obten_baja_3_reprob (long al_cuenta);//of_obten_baja_3_reprob
//
//Obtiene la bandera de baja_3_reprob del alumno en cuestion
//
//Recibe
//al_cuenta			long


Integer  li_codigo_sql
Long ll_baja_3_reprob
String ls_mensaje_sql

Select baja_3_reprob
Into :ll_baja_3_reprob
From banderas 
Where cuenta = :al_cuenta
Using gtr_sce;

ls_mensaje_sql= gtr_sce.SqlErrtext
li_codigo_sql= gtr_sce.SqlCode

IF li_codigo_sql =-1 THEN
	Messagebox("Error al consultar banderas 3r", ls_mensaje_sql, StopSign!)
	return li_codigo_sql
ELSEIF li_codigo_sql =100 THEN
	Messagebox("Alumno "+string(al_cuenta)+"-"+obten_digito(al_cuenta)+"inexistente",ls_mensaje_sql,StopSign!)
	li_codigo_sql = -1
	return li_codigo_sql
END IF

RETURN ll_baja_3_reprob



end function

public function integer of_obten_baja_4_insc (long al_cuenta);//of_obten_baja_4_insc
//
//Obtiene la bandera de baja_4_insc del alumno en cuestion
//
//Recibe
//al_cuenta			long


Integer  li_codigo_sql
Long ll_baja_3_reprob
String ls_mensaje_sql

Select baja_3_reprob
Into :ll_baja_3_reprob
From banderas 
Where cuenta = :al_cuenta
Using gtr_sce;

ls_mensaje_sql= gtr_sce.SqlErrtext
li_codigo_sql= gtr_sce.SqlCode

IF li_codigo_sql =-1 THEN
	Messagebox("Error al consultar banderas 3r", ls_mensaje_sql, StopSign!)
	return li_codigo_sql
ELSEIF li_codigo_sql =100 THEN
	Messagebox("Alumno "+string(al_cuenta)+"-"+obten_digito(al_cuenta)+"inexistente",ls_mensaje_sql,StopSign!)
	li_codigo_sql = -1
	return li_codigo_sql
END IF

RETURN ll_baja_3_reprob



end function

public function integer of_corte_3r_4i (long al_cuenta, long al_cve_carrera, long al_cve_plan, ref integer ai_baja_3_reprob, ref integer ai_baja_4_insc);//of_corte_3r_4i
//
//Efectua un calculo de materias reprobadas e inscritas dadas de baja
//para bloquear en los casos correspondientes a 3 reprobadas y 4 inscripciones
//
//Recibe
//al_cuenta				long
//al_cve_carrera		long
//al_cve_plan			long
//ai_baja_3_reprob	integer	 reference
//ai_baja_4_insc	integer	 reference

n_ds ln_ds
long lo_cont,lo_cuenta
int in_carrera,in_plan,in_cred,in_semestres, li_res_carrera_plan
decimal ld_promedio
long ll_cve_carrera,	ll_cve_plan, ll_rows
Integer  li_codigo_sql
String ls_mensaje_sql
decimal ld_puntaje_min
integer li_baja_3_reprob, li_baja_4_insc
boolean lb_update_acad = false
Integer li_calcula_promedio, li_obten_periodo_cambio_nota, li_periodo_cambio_nota, li_anio_cambio_nota
long ll_cve_mat_3_reprob[], ll_cve_mat_4_insc[], ll_indice_3_reprob=0, ll_indice_4_insc=0
long ll_tamanio_3_reprob=0, ll_tamanio_4_insc=0, ll_indice_array_3_reprob=0, ll_indice_array_4_insc=0
integer li_num_indultos_3r, li_num_indultos_4i

li_res_carrera_plan = of_obten_carrera_plan(al_cuenta, ll_cve_carrera,	ll_cve_plan)

IF li_res_carrera_plan = -1 THEN
	MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_3r_4i",StopSign!)
	return li_res_carrera_plan
END IF

li_baja_3_reprob = of_obten_baja_3_reprob(al_cuenta)

IF li_baja_3_reprob = -1 THEN
	MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_3r_4i",StopSign!)
	return li_baja_3_reprob
END IF

li_baja_4_insc = of_obten_baja_4_insc(al_cuenta)

IF li_baja_4_insc = -1 THEN
	MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_3r_4i",StopSign!)
	return li_baja_4_insc
END IF


if not isvalid(ln_ds) then
	ln_ds	= CREATE n_ds
end if

//Obtiene las materias cursadas 3 veces por el alumno para su carrera vigente en academicos
ln_ds.Dataobject = 'd_mat_calif_3r_4i'
ln_ds.SetTransObject(gtr_sce)
ll_rows = ln_ds.Retrieve(al_cuenta)

IF ll_rows = -1 THEN
	MessageBox("Error de datawindow d_mat_calif_3r_4i", "No es posible efectuar el corte en of_corte_3r_4i",StopSign!)
	return ll_rows
END IF


long ll_cont_1, ll_cuenta, ll_cve_mat = -1
int li_cursadas,li_reprobadas, li_esc_file

//Presunción de inocencia, hasta que demuestren lo contrario
li_baja_3_reprob = 0
li_baja_4_insc = 0
//Se hace para TODAS las materias con posibilidad de dar de baja al alumno
FOR ll_cont_1=1 TO ll_rows
		
		//Si estoy en la misma materia...
		if ll_cve_mat=ln_ds.object.historico_cve_mat[ll_cont_1] then
		//Aumenta el número de materias
			li_cursadas=li_cursadas+1		
		//Si la materia en cuestión se reprobó...
			if integer(ln_ds.object.historico_calificacion[ll_cont_1])=5 or &
					ln_ds.object.historico_calificacion[ll_cont_1]='NA' then
				li_reprobadas=li_reprobadas+1
		//Si la materia no se reprobó y no se dio de baja
			elseif not( integer(ln_ds.object.historico_calificacion[ll_cont_1])=5 or &
				ln_ds.object.historico_calificacion[ll_cont_1]='NA') and &
				not(ln_ds.object.historico_calificacion[ll_cont_1]='BA' or &
				integer(ln_ds.object.historico_calificacion[ll_cont_1])=5 or &
				ln_ds.object.historico_calificacion[ll_cont_1]='BJ' or &
				ln_ds.object.historico_calificacion[ll_cont_1]='NA') then
				
				ll_tamanio_3_reprob= upperbound(ll_cve_mat_3_reprob)
				ll_tamanio_4_insc= upperbound(ll_cve_mat_4_insc)

				if li_baja_3_reprob = 1 THEN								
					FOR ll_indice_array_3_reprob=1 to ll_tamanio_3_reprob
				//Cambia la bandera de 3 reprobadas, pero solo si la misma materia ya fue aprobada		
						if ll_cve_mat_3_reprob[ll_indice_array_3_reprob] = ll_cve_mat then
							li_baja_3_reprob = 0
							EXIT
						else
							li_baja_3_reprob = 1							
						end if
					NEXT	
				end if

				if li_baja_4_insc = 1  then
					FOR ll_indice_array_4_insc=1 to ll_tamanio_4_insc				
				//Cambia la bandera de 4 inscripciones, pero solo si la misma materia ya fue aprobada	
						if ll_cve_mat_4_insc[ll_indice_array_4_insc] = ll_cve_mat then
							li_baja_4_insc = 0
							EXIT
						else
							li_baja_4_insc = 1							
						end if					
					NEXT	
				end if	
			end if
		else
			//	Ve que materia es, empieza la cuenta desde 1
			ll_cve_mat=ln_ds.object.historico_cve_mat[ll_cont_1]			
			li_cursadas=1
			//Si la materia en cuestión se reprobó...
			if integer(ln_ds.object.historico_calificacion[ll_cont_1])=5 or &
					ln_ds.object.historico_calificacion[ll_cont_1]='NA' then
				li_reprobadas=1
			else
				li_reprobadas=0
			end if
		end if 
		// if ll_cve_mat=ln_ds.object.historico_cve_mat[ll_cont_1]
			
		
		//Si la calificación es de 5 y es la tercera vez...
		if integer(ln_ds.object.historico_calificacion[ll_cont_1])=5 or &
				ln_ds.object.historico_calificacion[ll_cont_1]='NA' then
			if li_reprobadas>=3 then
			//Cambia la bandera de 3 reprobadas				
				li_baja_3_reprob = 1
				ll_indice_3_reprob = ll_indice_3_reprob + 1
				ll_cve_mat_3_reprob[ll_indice_3_reprob]=  ll_cve_mat 
			end if
		end if
		
		//Si la calificación es de 5 o 'BA' y es la cuarta vez...
		if ln_ds.object.historico_calificacion[ll_cont_1]='BA' or &
				integer(ln_ds.object.historico_calificacion[ll_cont_1])=5 or &
				ln_ds.object.historico_calificacion[ll_cont_1]='BJ' or &
				ln_ds.object.historico_calificacion[ll_cont_1]='NA' then
			if li_cursadas>=4 then
			//Cambia la bandera de 4 inscripciones
				li_baja_4_insc	= 1
				ll_indice_4_insc = ll_indice_4_insc + 1
				ll_cve_mat_4_insc[ll_indice_4_insc]  = ll_cve_mat
			end if
		end if	
		
NEXT

li_obten_periodo_cambio_nota = of_obten_periodo_cambio_nota(li_periodo_cambio_nota, li_anio_cambio_nota, gs_tipo_periodo)

//Verifica si tiene indultos para el periodo de cambios de nota
li_num_indultos_3r = of_obten_indulto(al_cuenta, li_periodo_cambio_nota, li_anio_cambio_nota, '3')
li_num_indultos_4i = of_obten_indulto(al_cuenta, li_periodo_cambio_nota, li_anio_cambio_nota, '4')

//Si tiene indultos de 3 reprobadas, quita la baja
if li_num_indultos_3r >=1 then
	li_baja_3_reprob = 0
end if
	
//Si tiene indultos de 4 inscripciones, quita la baja
if li_num_indultos_4i >=1 then
	li_baja_4_insc = 0
end if
	
	ai_baja_3_reprob = li_baja_3_reprob
	ai_baja_4_insc   = li_baja_4_insc
	
	UPDATE banderas
	SET baja_3_reprob = :li_baja_3_reprob,
		baja_4_insc = :li_baja_4_insc
	FROM banderas
	WHERE cuenta = :al_cuenta
	USING gtr_sce;

	ls_mensaje_sql= gtr_sce.SqlErrtext
	li_codigo_sql= gtr_sce.SqlCode

	IF li_codigo_sql =-1 THEN
		ROLLBACK USING gtr_sce;
		Messagebox("Error al actualizar las banderas",ls_mensaje_sql,StopSign!)
		RETURN -1
	ELSEIF li_codigo_sql =100 THEN
		ROLLBACK USING gtr_sce;
		Messagebox("Alumno inexistente",ls_mensaje_sql,StopSign!)
		RETURN -1
	ELSEIF li_codigo_sql =0 THEN
		COMMIT USING gtr_sce;		
	END IF

return li_codigo_sql

end function

public function integer of_obten_indulto (long al_cuenta, integer ai_periodo, integer ai_anio, string as_cve_indulto);// Obtiene el indulto en base al periodo y año de señalados en los parámetros
//
// of_obten_indulto
//
// Recibe:
// al_cuenta			long
// ai_periodo			integer
//	ai_anio				integer
//	as_cve_indulto		string

Integer  li_codigo_sql, li_num_indultos
String ls_mensaje_sql

 
Select num_indultos = count(cuenta)
Into :li_num_indultos
From hist_indulto 
Where cve_indulto = :as_cve_indulto
AND   periodo = :ai_periodo
AND   anio = :ai_anio
AND	cuenta = :al_cuenta
Using gtr_sce;

ls_mensaje_sql= gtr_sce.SqlErrtext
li_codigo_sql= gtr_sce.SqlCode

IF li_codigo_sql =-1 THEN
	Messagebox("Error al consultar los registros de hist_indulto",ls_mensaje_sql,StopSign!)
	li_num_indultos = 0
ELSEIF li_codigo_sql =100 THEN
	li_num_indultos = 0
END IF

RETURN li_num_indultos


end function

public function long of_obten_nivel_carrera (long al_cve_carrera, ref string as_nivel);//of_obten_nivel_carrera
//
//Obtiene el nivel de la carrera y plan proporcionados
//
//Recibe
//al_cve_carrera	long
//al_cve_plan		long


Integer  li_codigo_sql
long ll_cred_serv_social
String ls_mensaje_sql

Select nivel
Into :as_nivel
From carreras
Where cve_carrera = :al_cve_carrera
Using gtr_sce;

ls_mensaje_sql= gtr_sce.SqlErrtext
li_codigo_sql= gtr_sce.SqlCode

IF li_codigo_sql =-1 THEN
	Messagebox("Error al consultar carrera", ls_mensaje_sql, StopSign!)
	return li_codigo_sql
ELSEIF li_codigo_sql =100 THEN
	Messagebox("Carrera inexistente", ls_mensaje_sql, StopSign!)
	li_codigo_sql = -1
	return li_codigo_sql
END IF

RETURN li_codigo_sql


end function

public function integer of_obten_periodo_egreso (ref integer ai_periodo, ref integer ai_anio, string as_tipo_periodo);// Obtiene el periodo y año de egreso señalado en los parámetros
//
// of_obten_periodo_egreso
//
// Devuelve:
// ai_periodo			integer
//	ai_anio				integer
//  as_tipo_periodo	string

Integer  li_codigo_sql, li_cve_proceso_egreso = 9
String ls_mensaje_sql

Select periodo,
		anio
Into :ai_periodo,
		:ai_anio
From periodos_por_procesos 
Where cve_proceso = :li_cve_proceso_egreso
And tipo_periodo = :as_tipo_periodo
Using gtr_sce;

ls_mensaje_sql= gtr_sce.SqlErrtext
li_codigo_sql= gtr_sce.SqlCode

IF li_codigo_sql =-1 THEN
	Messagebox("Error al consultar los periodos_por_procesos para egreso",ls_mensaje_sql,StopSign!)
ELSEIF li_codigo_sql =100 THEN
	Messagebox("Proceso de egreso inexistente",ls_mensaje_sql,StopSign!)
END IF

RETURN li_codigo_sql


end function

public function integer of_calcula_promedio (long al_cuenta, long al_cve_carrera, long al_cve_plan, ref decimal ad_promedio, ref decimal ad_creditos);//of_calcula_promedio
//
//Recibe:
//	al_cuenta		long
// al_cve_carrera long
// al_cve_plan		long
// ad_promedio		decimal
//	al_creditos		long
//
//Devuelve integer
// ad_promedio		decimal
//	al_creditos		long

decimal ld_promedio, ldc_creditos
string ls_mensaje
integer li_codigo_error

//Declara el stored procedure que calcula tanto el promedio como el número de créditos acumulados
	DECLARE cal_prom PROCEDURE FOR calcula_promedio  
         @cuenta   = :al_cuenta,   
         @cve_carr = :al_cve_carrera,   
         @plan     = :al_cve_plan,   
         @promedio = :ld_promedio OUTPUT,
         @creditos = :ldc_creditos OUTPUT
	USING gtr_sce;

//Calcula promedio y créditos cursados
	execute cal_prom;
	
	li_codigo_error= gtr_sce.SQLCode

	ls_mensaje= gtr_sce.SQLErrText
	
	if li_codigo_error = -1 then
		ROLLBACK USING gtr_sce;
		MessageBox("Error al ejecutar stored procedure calcula_promedio", ls_mensaje)
		return -1
	end if

//Captura el promedio y créditos en las variables
	FETCH cal_prom INTO :ld_promedio, :ldc_creditos;

//Cierra el stored procedure	
	close cal_prom;

//Si no hay materias cursadas o regresó cero
	if isnull(ld_promedio) then
		ld_promedio=0
	end if
	
	if isnull(ldc_creditos) then
		ldc_creditos=0
	end if

	ad_promedio = ld_promedio
	ad_creditos = ldc_creditos
	COMMIT USING gtr_sce;

return 0

end function

public function integer of_corte_promedio_creditos_sb (long al_cuenta, long al_cve_carrera, long al_cve_plan, ref decimal ad_promedio, ref decimal ad_creditos);//of_corte_promedio_creditos_sb
//
//Efectua un calculo de promedio y creditos para el alumno recibido y devuelve el promedio 
//y los créditos calculados sin afectar los bloqueos
//
//Recibe
//al_cuenta			long
//al_cve_carrera	long
//al_cve_plan		long
//ad_promedio				decimal 	reference
//al_creditos				long		reference

long lo_cont,lo_cuenta
int in_carrera,in_plan,in_cred,in_semestres, li_res_carrera_plan
decimal ld_promedio, ldc_creditos
long ll_cve_carrera,	ll_cve_plan
Integer  li_codigo_sql
String ls_mensaje_sql
decimal ld_puntaje_min
long ll_cve_flag_promedio
boolean lb_update_acad = false
Integer li_calcula_promedio

li_res_carrera_plan = of_obten_carrera_plan(al_cuenta, ll_cve_carrera,	ll_cve_plan)

IF li_res_carrera_plan = -1 THEN
	MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_promedio_creditos_sb",StopSign!)
	return li_res_carrera_plan
END IF


//Ejecuta el stored procedure que calcula tanto el promedio como el número de créditos acumulados
li_calcula_promedio = of_calcula_promedio(al_cuenta,ll_cve_carrera, ll_cve_plan, ld_promedio, ldc_creditos)
	
IF li_calcula_promedio = -1 THEN
	MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_promedio_creditos",StopSign!)
	return li_calcula_promedio
END IF

	ad_promedio = ld_promedio
	ad_creditos = ldc_creditos

	UPDATE academicos
	SET promedio = :ad_promedio,
 		 creditos_cursados = CONVERT(INT, :ad_creditos)
	FROM academicos
	WHERE cuenta = :al_cuenta
	USING gtr_sce;

	ls_mensaje_sql= gtr_sce.SqlErrtext
	li_codigo_sql= gtr_sce.SqlCode

	IF li_codigo_sql =-1 THEN
		ROLLBACK USING gtr_sce;
		Messagebox("Error al actualizar los académicos",ls_mensaje_sql,StopSign!)
		RETURN -1
	ELSEIF li_codigo_sql =100 THEN
		ROLLBACK USING gtr_sce;
		Messagebox("Alumno inexistente",ls_mensaje_sql,StopSign!)
		RETURN -1
	ELSEIF li_codigo_sql =0 THEN
		lb_update_acad = true
//		La transaccion concluye al actualizar banderas.cve_flag_promedio		
		COMMIT USING gtr_sce;
	END IF
	

return li_codigo_sql

end function

public function integer of_corte_promedio_creditos (long al_cuenta, long al_cve_carrera, long al_cve_plan, ref decimal ad_promedio, ref decimal ad_creditos, ref long al_cve_flag_promedio);//of_corte_promedio_creditos
//
//Efectua un calculo de promedio y creditos para el alumno recibido y devuelve el promedio 
//y los créditos calculados
//
//Recibe
//al_cuenta			long
//al_cve_carrera	long
//al_cve_plan		long
//ad_promedio				decimal 	reference
//al_creditos				long		reference
//al_cve_flag_promedio	long		reference

long lo_cont,lo_cuenta
int in_carrera,in_plan,in_cred,in_semestres, li_res_carrera_plan
decimal ld_promedio, ldc_creditos
long ll_cve_carrera,	ll_cve_plan
Integer  li_codigo_sql
String ls_mensaje_sql
decimal ld_puntaje_min
long ll_cve_flag_promedio
boolean lb_update_acad = false
Integer li_calcula_promedio

li_res_carrera_plan = of_obten_carrera_plan(al_cuenta, ll_cve_carrera,	ll_cve_plan)

IF li_res_carrera_plan = -1 THEN
	MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_promedio_creditos",StopSign!)
	return li_res_carrera_plan
END IF

ll_cve_flag_promedio = of_obten_cve_flag_promedio(al_cuenta)

IF ll_cve_flag_promedio = -1 THEN
	MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_promedio_creditos",StopSign!)
	return ll_cve_flag_promedio
END IF


//Ejecuta el stored procedure que calcula tanto el promedio como el número de créditos acumulados
li_calcula_promedio = of_calcula_promedio(al_cuenta,ll_cve_carrera, ll_cve_plan, ld_promedio, ldc_creditos)
	
IF li_calcula_promedio = -1 THEN
	MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_promedio_creditos",StopSign!)
	return li_calcula_promedio
END IF

	ad_promedio = ld_promedio
	ad_creditos = ldc_creditos

	UPDATE academicos
	SET promedio = :ad_promedio,
 		 creditos_cursados = CONVERT(INT,:ad_creditos)
	FROM academicos
	WHERE cuenta = :al_cuenta
	USING gtr_sce;

	ls_mensaje_sql= gtr_sce.SqlErrtext
	li_codigo_sql= gtr_sce.SqlCode

	IF li_codigo_sql =-1 THEN
		ROLLBACK USING gtr_sce;
		Messagebox("Error al actualizar los académicos",ls_mensaje_sql,StopSign!)
		RETURN -1
	ELSEIF li_codigo_sql =100 THEN
		ROLLBACK USING gtr_sce;
		Messagebox("Alumno inexistente",ls_mensaje_sql,StopSign!)
		RETURN -1
	ELSEIF li_codigo_sql =0 THEN
		lb_update_acad = true
//		La transaccion concluye al actualizar banderas.cve_flag_promedio		
		COMMIT USING gtr_sce;
	END IF
	
	ld_puntaje_min = of_obten_puntaje_min(ll_cve_carrera,	ll_cve_plan)
	
	IF ld_puntaje_min = -1 THEN
		MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_promedio_creditos",StopSign!)
		return ld_puntaje_min
	END IF
	
	
	IF ld_promedio > ld_puntaje_min THEN	
		//EL ALUMNO TIENE MAYOR PROMEDIO AL PUNTAJE MINIMO DE CALIDAD
		CHOOSE CASE ll_cve_flag_promedio
			//NORMAL
			CASE 0
				ll_cve_flag_promedio = 0
			//AMONESTADO
			CASE 1
				ll_cve_flag_promedio = 0			
			//BAJA
			CASE 2
				ll_cve_flag_promedio = 0			
			//EXENTO
			CASE 3
				ll_cve_flag_promedio = 0			
			CASE ELSE 
				MessageBox("Error en flag_promedio", "El valor ["+ string(ll_cve_flag_promedio) +"] está fuera de rango",StopSign!)
				RETURN -1
		END CHOOSE
	ELSE
		//EL ALUMNO TIENE MENOR PROMEDIO AL PUNTAJE MINIMO DE CALIDAD
		CHOOSE CASE ll_cve_flag_promedio
			//NORMAL
			CASE 0
				ll_cve_flag_promedio = 1						
			//AMONESTADO
			CASE 1
				ll_cve_flag_promedio = 2			
			//BAJA
			CASE 2
				ll_cve_flag_promedio = 2						
			//EXENTO
			CASE 3
				ll_cve_flag_promedio = 3					
			CASE ELSE 
				MessageBox("Error en flag_promedio", "El valor["+string(ll_cve_flag_promedio)+"] está fuera de rango",StopSign!)
		END CHOOSE
	END IF	
	
	al_cve_flag_promedio = ll_cve_flag_promedio
	
	UPDATE banderas
	SET cve_flag_promedio = :ll_cve_flag_promedio
	FROM banderas
	WHERE cuenta = :al_cuenta
	USING gtr_sce;

	ls_mensaje_sql= gtr_sce.SqlErrtext
	li_codigo_sql= gtr_sce.SqlCode

	IF li_codigo_sql =-1 THEN
		ROLLBACK USING gtr_sce;
		Messagebox("Error al actualizar las banderas",ls_mensaje_sql,StopSign!)
		RETURN -1
	ELSEIF li_codigo_sql =100 THEN
		ROLLBACK USING gtr_sce;
		Messagebox("Alumno inexistente",ls_mensaje_sql,StopSign!)
		RETURN -1
	ELSEIF li_codigo_sql =0 THEN
//		IF lb_update_acad THEN
//			Como se actualizaron academicos.promedio y academicos.creditos_cursados
//			la transaccion concluye aqui con banderas.cve_flag_promedio		
			COMMIT USING gtr_sce;		
//		ELSE
//			Messagebox("Error transaccional","Transaccion fallida por actualizar academicos",StopSign!)
//			RETURN -1			
//		END IF
		lb_update_acad = true
	END IF

return li_codigo_sql

end function

public function decimal of_obten_cred_egresado (long al_cve_carrera, long al_cve_plan);//of_obten_cred_egresado
//
//Obtiene los creditos para considerar como egresado a un alumno 
//del plan de estudios correspondiente
//
//Recibe
//al_cve_carrera	long
//al_cve_plan		long


Integer  li_codigo_sql
Decimal ldc_cred_egresado
String ls_mensaje_sql

Select cred_egresado
Into :ldc_cred_egresado
From plan_estudios 
Where cve_carrera = :al_cve_carrera
and   cve_plan    = :al_cve_plan
Using gtr_sce;

ls_mensaje_sql= gtr_sce.SqlErrtext
li_codigo_sql= gtr_sce.SqlCode

IF li_codigo_sql =-1 THEN
	Messagebox("Error al consultar plan_estudios", ls_mensaje_sql, StopSign!)
	return li_codigo_sql
ELSEIF li_codigo_sql =100 THEN
	Messagebox("Plan_estudios inexistente", ls_mensaje_sql, StopSign!)
	li_codigo_sql = -1
	return li_codigo_sql
END IF

RETURN ldc_cred_egresado
end function

public function decimal of_corte_egresado (long al_cuenta, long al_cve_carrera, long al_cve_plan, integer ai_periodo, integer ai_anio, ref integer ai_egresado);//of_corte_egresado
//
//Efectua una revision de estudios para ver si se establece como egresado al alumno recibido,
//actualizandole el año y periodo de egreso, promedio y creditos
//
//Recibe
//al_cuenta			long
//al_cve_carrera	long
//al_cve_plan		long
//ai_periodo		integer
//ai_anio			integer
//ai_agresado		integer


Long	ll_cve_Carrera, ll_cve_Plan, ll_Cve_Subsistema
Integer li_CredCur,li_Cont = 0,li_NumArchivo,li_PEgre =9
Long		ll_Cuenta,ll_i,ll_AEgre=0
String	ls_Ruta,ls_NombreArch,ls_Nivel
real lr_promedio
Integer li_carrera_plan_sub_niv
Integer li_actualiza_egresado, li_calcula_promedio, li_egresado_anterior
Decimal ld_promedio, ldc_creditos

datastore ds_historico_sin_area
datastore ds_historico_area
DataStore ds_Revision, ds_mat_acred
DataStore ds_cuentas

ds_cuentas = CREATE DataStore
ds_cuentas.DataObject = "d_cuentas_academ"
ds_cuentas.Settransobject(gtr_sce)
 
ds_revision = CREATE DataStore
ds_revision.DataObject = "d_revision_est"
ds_revision.Settransobject(gtr_sce)

ds_mat_acred = CREATE DataStore
ds_mat_acred.DataObject = "d_mat_acred"
ds_mat_acred.Settransobject(gtr_sce)

ds_historico_sin_area = CREATE DataStore
ds_historico_sin_area.DataObject = "d_hist_sin_area"
ds_historico_sin_area.settransobject(gtr_sce)

ds_historico_area = CREATE DataStore
ds_historico_area.DataObject = "d_hist_area"
ds_historico_area.settransobject(gtr_sce)
 
ds_cuentas.Retrieve(gs_tipo_periodo) 


	ll_Cuenta = al_cuenta
	li_carrera_plan_sub_niv = of_obten_carrera_plan_sub_niv(ll_Cuenta, ll_cve_Carrera, ll_cve_Plan, ll_Cve_Subsistema, ls_Nivel, li_egresado_anterior)	
	IF li_carrera_plan_sub_niv = -1 THEN
		MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_egresado",StopSign!)
		return li_carrera_plan_sub_niv
	END IF

	If gtr_sce.Sqlcode = 0 Then
		decimal ldc_credegre
		If IsNull(li_CredCur) Then li_CredCur=0
		
		ldc_credegre = of_obten_cred_egresado(ll_cve_Carrera, ll_cve_Plan)
		
		IF ldc_credegre = -1 THEN
			MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_egresado",StopSign!)
			return ldc_credegre
		END IF

      If ldc_credegre >= 0 Then 
			//If li_CredCur + 60 >= li_CredEgre Then 
			//  If li_CredCur >= 0 Then
				If of_Revisa_Areas_Completas(ll_Cuenta,ll_cve_Carrera,ll_cve_Plan,ll_Cve_Subsistema,ls_Nivel) Then 					
					li_PEgre = ai_periodo
					ll_AEgre = ai_anio
	
					li_calcula_promedio = of_calcula_promedio(al_cuenta,ll_cve_carrera, ll_cve_plan, ld_promedio, ldc_creditos)
	
					IF li_calcula_promedio = -1 THEN
						MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_egresado",StopSign!)
						return li_calcula_promedio
					END IF

						li_actualiza_egresado = of_actualiza_egresado(al_cuenta, 1, li_PEgre, ll_AEgre, ldc_creditos, ld_promedio, li_egresado_anterior)


					IF li_actualiza_egresado = -1 THEN
						MessageBox("Error de corte", "No es posible efectuar el corte en of_corte_egresado",StopSign!)
						return li_actualiza_egresado
					END IF
					ai_egresado= 1
				Else
					ai_egresado= 0
 				End if
			//End if	
		End IF	
	End if	
	Commit using gtr_sce;


ds_cuentas.Reset() 
DESTROY ds_cuentas
DESTROY ds_revision  
DESTROY ds_mat_acred  
DESTROY ds_historico_sin_area 
DESTROY ds_historico_area  

return 0
end function

public function integer of_obten_periodo_cambio_nota (ref integer ai_periodo, ref integer ai_anio, string as_tipo_periodo);// Obtiene el periodo y año de señalado para los cortes en los parámetros
//
// of_obten_periodo_cambio_nota
//
// Devuelve:
// ai_periodo			integer
//	ai_anio				integer

Integer  li_codigo_sql, li_cve_proceso_cortes = 10
String ls_mensaje_sql

Select periodo,
		anio
Into :ai_periodo,
		:ai_anio
From periodos_por_procesos 
Where cve_proceso = :li_cve_proceso_cortes
And tipo_periodo = :as_tipo_periodo
Using gtr_sce;

ls_mensaje_sql= gtr_sce.SqlErrtext
li_codigo_sql= gtr_sce.SqlCode

IF li_codigo_sql =-1 THEN
	Messagebox("Error al consultar los periodos_por_procesos para Cambios de Nota",ls_mensaje_sql,StopSign!)
ELSEIF li_codigo_sql =100 THEN
	Messagebox("Periodo de Cambios de Nota inexistente [10]",ls_mensaje_sql,StopSign!)
END IF

RETURN li_codigo_sql



end function

on n_cortes.create
call super::create
end on

on n_cortes.destroy
call super::destroy
end on

