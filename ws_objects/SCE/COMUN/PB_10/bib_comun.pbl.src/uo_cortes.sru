$PBExportHeader$uo_cortes.sru
forward
global type uo_cortes from nonvisualobject
end type
end forward

global type uo_cortes from nonvisualobject
end type
global uo_cortes uo_cortes

forward prototypes
public function integer of_corte_promedio_creditos (long al_cuenta, ref decimal ad_promedio, ref integer ai_creditos)
public function integer of_corte_integracion (long al_cuenta, ref long ai_puede, ref long ai_curso)
public function integer of_corte_egresado (long al_cuenta, long al_periodo, long al_anio)
public function integer of_corte_servicio_social (long al_cuenta, integer ai_puede, integer ai_curso)
end prototypes

public function integer of_corte_promedio_creditos (long al_cuenta, ref decimal ad_promedio, ref integer ai_creditos);//of_corte_promedio_creditos
//
//Objetivo:
//		Realiza el calculo del promedio y creditos para el alumno y lo asigna en academicos
//
//Recibe:
//		al_cuenta 	long		cuenta del alumno a evaluar
//		ad_promedio	decimal	promedio calculado
//		ai_creditos	integer	creditos calculados
//Devuelve:
//		ad_promedio	decimal	promedio calculado
//		ai_creditos	integer	creditos calculados


return 0
end function

public function integer of_corte_integracion (long al_cuenta, ref long ai_puede, ref long ai_curso);//of_corte_integracion
//
//Objetivo:
//		Realiza una revisión para determinar si el alumno ya curso integración o ya puede cursar
//
//Recibe:
//		al_cuenta 	long	cuenta del alumno a evaluar
//		ai_puede		long	periodo a asignar en caso de ser egresado
//		ai_curso		long	anio a asignar en caso de ser egresado



return 0
end function

public function integer of_corte_egresado (long al_cuenta, long al_periodo, long al_anio);//of_corte_egresado
//
//Objetivo:
//		Realiza una revisión de estudios para determinar si el alumno ha egresado
//
//Recibe:
//		al_cuenta 	long	cuenta del alumno a evaluar
//		al_periodo	long	periodo a asignar en caso de ser egresado
//		al_anio		long	anio a asignar en caso de ser egresado



return 0
end function

public function integer of_corte_servicio_social (long al_cuenta, integer ai_puede, integer ai_curso);//of_corte_servicio_social
//
//Objetivo:
//		Realiza una revisión para determinar si el alumno ya curso el servicio social o ya lo puede cursar
//
//Recibe:
//		al_cuenta 	long	cuenta del alumno a evaluar
//		ai_puede		long	periodo a asignar en caso de ser egresado
//		ai_curso		long	anio a asignar en caso de ser egresado



return 0
end function

on uo_cortes.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_cortes.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

