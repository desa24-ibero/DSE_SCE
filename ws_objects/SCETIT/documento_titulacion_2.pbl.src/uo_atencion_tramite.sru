$PBExportHeader$uo_atencion_tramite.sru
forward
global type uo_atencion_tramite from nonvisualobject
end type
end forward

global type uo_atencion_tramite from nonvisualobject
end type
global uo_atencion_tramite uo_atencion_tramite

type variables
uo_atencion_opc_cero iuo_atencion_opc_cero
end variables

forward prototypes
public function boolean of_areas_completas (long al_cuenta, long al_cve_carrera, long al_cve_plan)
public function integer of_establece_estado (long al_cuenta, long al_cve_carrera, long al_cve_plan, long al_cve_tramite, long al_cve_estado, real ar_cve_sub_estado, integer al_exito)
public function integer of_establece_estados (long al_cuenta, long al_cve_carrera, long al_cve_plan, long al_cve_tramite, long al_cve_estado[], real ar_cve_sub_estado[], long al_exito[])
public function integer of_alumno_estado_diagnostico (long al_cuenta, long al_cve_carrera, long al_cve_plan, long al_cve_tramite)
public function boolean of_pago_tramite (long al_cuenta, long al_cve_carrera, long al_cve_plan)
public function integer of_set_pago_tramite (long al_cuenta, long al_cve_carrera, long al_cve_plan, integer al_folio_mov_alumnos, integer al_cve_estatus_pago)
public function boolean of_alumno_susceptible_ct (long al_cuenta, long al_cve_carrera, long al_cve_plan)
public function boolean of_alumno_susceptible_tramite (long al_cuenta, long al_cve_carrera, long al_cve_plan, long al_cve_tramite)
end prototypes

public function boolean of_areas_completas (long al_cuenta, long al_cve_carrera, long al_cve_plan);// of_areas_completas
//Recibe 	al_cuenta	long
//			al_cve_carrera long
//			al_cve_plan		long

integer li_sql_code
integer li_basica, li_mayor_obli, li_mayor_opt, li_menor_obli, li_menor_opt
integer li_integ, li_ss, li_opc_term, li_cve_subsistema
string ls_mensaje
long ll_cuenta
boolean lb_titulado_anterior


SELECT
basica      = basica_min - basica_cur,
mayor_obli  = mayor_obli_min - mayor_obli_cur,
mayor_opt   = mayor_opt_min - mayor_opt_cur,
menor_obli  = menor_obli_min - menor_obli_cur,
menor_opt   = menor_opt_min - menor_opt_cur,
integ       = integ_min - integ_cur,
ss          = ss_min - ss_cur,
opc_ter     = opc_ter_min - opc_ter_cur,
isnull(cve_subsistema,0)
INTO
:li_basica, 
:li_mayor_obli, 
:li_mayor_opt, 
:li_menor_obli, 
:li_menor_opt,
:li_integ, 
:li_ss, 
:li_opc_term, 
:li_cve_subsistema
FROM tramite_titulacion
WHERE cuenta = :al_cuenta
AND   cve_carrera = :al_cve_carrera
AND   cve_plan = :al_cve_plan
USING gtr_sce;

li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText

IF li_sql_code =-1 THEN	
	ROLLBACK USING gtr_sce;
	MessageBox("Error al Consultar", ls_mensaje,StopSign!)
	return false
ELSE

//Si al alumno no cuenta con el subsistema cargado se considerará 
//incompleto
IF li_cve_subsistema = 0 THEN
	return false	
END IF

//Si algún valor de las areas es nulo, se considera un error
IF isnull(li_basica) OR isnull(li_mayor_obli)  OR &
	isnull(li_mayor_opt) OR isnull(li_menor_obli) OR &
	isnull(li_menor_opt) OR isnull(li_integ) OR &
	isnull(li_ss) OR isnull(li_opc_term) THEN
	MessageBox("Areas con Nulos", "Existen areas con valores invalidos",StopSign!)
	return false
END IF	
//	
//Es necesario que en cada area tenga valores menores o iguales a cero
IF li_basica <= 0 AND li_mayor_obli <= 0 AND &
	li_mayor_opt <= 0 AND li_menor_obli <= 0 AND &
	li_menor_opt <= 0 AND li_integ <= 0 AND &
	li_ss <= 0 AND li_opc_term <= 0 THEN
	return true
ELSE
	return false
END IF


END IF
RETURN TRUE


end function

public function integer of_establece_estado (long al_cuenta, long al_cve_carrera, long al_cve_plan, long al_cve_tramite, long al_cve_estado, real ar_cve_sub_estado, integer al_exito);// of_establece_estado
//Recibe al_cuenta	long
//			al_cve_carrera long
//			al_cve_plan		long
//			al_cve_tramite
//			al_cve_estado
//			ar_cve_sub_estado
//			al_exito

integer li_sql_code
integer li_basica, li_mayor_obli, li_mayor_opt, li_menor_obli, li_menor_opt
integer li_integ, li_ss, li_opc_term, li_cve_subsistema, li_num_estados
string ls_mensaje
long ll_cuenta
boolean lb_titulado_anterior

SELECT count(*)
INTO :li_num_estados
FROM estado_alumno_tramite
WHERE cuenta = :al_cuenta
AND   cve_carrera = :al_cve_carrera
AND   cve_plan = :al_cve_plan
AND 	cve_tramite = :al_cve_tramite
AND 	cve_estado = :al_cve_estado
AND 	cve_sub_estado = :ar_cve_sub_estado
USING gtr_sce;

li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText

IF li_sql_code =-1 THEN	
	ROLLBACK USING gtr_sce;
	MessageBox("Error al Consultar estado_alumno_tramite", ls_mensaje,StopSign!)
	return -1
ELSE
	IF li_num_estados = 0 THEN 
		INSERT INTO estado_alumno_tramite (cuenta, cve_carrera, cve_plan, cve_tramite, 	cve_estado, 	cve_sub_estado, 	exito)
		VALUES (:al_cuenta, 	:al_cve_carrera, 	:al_cve_plan, 	:al_cve_tramite, 	:al_cve_estado, 	:ar_cve_sub_estado, 	:al_exito)
		USING gtr_sce;

		li_sql_code= gtr_sce.SQLCode
		ls_mensaje= gtr_sce.SQLErrText
	
		IF li_sql_code =-1 THEN	
			ROLLBACK USING gtr_sce;
			MessageBox("Error al Insertar en estado_alumno_tramite", ls_mensaje,StopSign!)
			return -1
		ELSEIF li_sql_code =0 THEN	
			COMMIT USING gtr_sce;
			return 0
		END IF
	ELSEIF li_num_estados = 1 THEN 

		UPDATE estado_alumno_tramite
		SET exito= :al_exito
		WHERE cuenta = :al_cuenta
		AND   cve_carrera = :al_cve_carrera
		AND   cve_plan = :al_cve_plan
		AND 	cve_tramite = :al_cve_tramite
		AND 	cve_estado = :al_cve_estado
		AND 	cve_sub_estado = :ar_cve_sub_estado
		USING gtr_sce;
		
		li_sql_code= gtr_sce.SQLCode
		ls_mensaje= gtr_sce.SQLErrText
	
		IF li_sql_code =-1 THEN	
			ROLLBACK USING gtr_sce;
			MessageBox("Error al Actualizar estado_alumno_tramite", ls_mensaje,StopSign!)
			return -1
		ELSEIF li_sql_code =0 THEN	
			COMMIT USING gtr_sce;
			return 0
		END IF		
	END IF
END IF

RETURN 0


end function

public function integer of_establece_estados (long al_cuenta, long al_cve_carrera, long al_cve_plan, long al_cve_tramite, long al_cve_estado[], real ar_cve_sub_estado[], long al_exito[]);// of_establece_estado
//Recibe al_cuenta	long
//			al_cve_carrera long
//			al_cve_plan		long
//			al_cve_tramite
//			al_cve_estado
//			ar_cve_sub_estado
//			al_exito

integer li_sql_code
integer li_basica, li_mayor_obli, li_mayor_opt, li_menor_obli, li_menor_opt
integer li_integ, li_ss, li_opc_term, li_cve_subsistema, li_num_estados
string ls_mensaje
long ll_cuenta, ll_tamanio_arreglos, ll_renglon_actual
boolean lb_titulado_anterior

IF upperbound(al_cve_estado) <> upperbound(ar_cve_sub_estado) or &
	upperbound(al_cve_estado) <> upperbound(al_exito) THEN
	MessageBox("Tamaños de arreglos incorrectos", &
					"El tamaño de los arreglos de cve_estado, cve_sub_estado, exito son incompatibles",StopSign!)
	return -1
END IF


ll_tamanio_arreglos = upperbound(al_cve_estado)


FOR ll_renglon_actual= 1 TO ll_tamanio_arreglos
	
	
	SELECT count(*)
	INTO :li_num_estados
	FROM estado_alumno_tramite
	WHERE cuenta = :al_cuenta
	AND   cve_carrera = :al_cve_carrera
	AND   cve_plan = :al_cve_plan
	AND 	cve_tramite = :al_cve_tramite
	AND 	cve_estado = :al_cve_estado[ll_renglon_actual]
	AND 	cve_sub_estado = :ar_cve_sub_estado[ll_renglon_actual]
	USING gtr_sce;

	li_sql_code= gtr_sce.SQLCode
	ls_mensaje= gtr_sce.SQLErrText

	IF li_sql_code =-1 THEN	
		ROLLBACK USING gtr_sce;
		MessageBox("Error al Consultar estado_alumno_tramite", ls_mensaje,StopSign!)
		Goto Error
	ELSE
		IF li_num_estados = 0 THEN 
			INSERT INTO estado_alumno_tramite (cuenta, cve_carrera, cve_plan, cve_tramite, 	cve_estado, 	cve_sub_estado, 	exito)
			VALUES (:al_cuenta, 	:al_cve_carrera, 	:al_cve_plan, 	:al_cve_tramite, 	:al_cve_estado[ll_renglon_actual], 	:ar_cve_sub_estado[ll_renglon_actual], 	:al_exito[ll_renglon_actual])
			USING gtr_sce;

			li_sql_code= gtr_sce.SQLCode
			ls_mensaje= gtr_sce.SQLErrText
	
			IF li_sql_code =-1 THEN	
				ROLLBACK USING gtr_sce;
				MessageBox("Error al Insertar en estado_alumno_tramite", ls_mensaje,StopSign!)
				Goto Error
			END IF
		ELSEIF li_num_estados = 1 THEN 

			UPDATE estado_alumno_tramite
			SET exito= :al_exito[ll_renglon_actual]
			WHERE cuenta = :al_cuenta
			AND   cve_carrera = :al_cve_carrera
			AND   cve_plan = :al_cve_plan
			AND 	cve_tramite = :al_cve_tramite
			AND 	cve_estado = :al_cve_estado[ll_renglon_actual]
			AND 	cve_sub_estado = :ar_cve_sub_estado[ll_renglon_actual]
			USING gtr_sce;
		
			li_sql_code= gtr_sce.SQLCode
			ls_mensaje= gtr_sce.SQLErrText
	
			IF li_sql_code =-1 THEN	
				ROLLBACK USING gtr_sce;
				MessageBox("Error al Actualizar estado_alumno_tramite", ls_mensaje,StopSign!)
				Goto Error
			END IF		
		END IF
	END IF


NEXT



IF ll_renglon_actual >= ll_tamanio_arreglos THEN	
	COMMIT USING gtr_sce;
	return 0
ELSE
	return -1
END IF						


Error:
	RETURN -1


end function

public function integer of_alumno_estado_diagnostico (long al_cuenta, long al_cve_carrera, long al_cve_plan, long al_cve_tramite);//of_alumno_estado_diagnostico
//Recibe 	al_cuenta	long
//			al_cve_carrera long
//			al_cve_plan		long
//			al_cve_tramite	long

integer li_adeuda_finanzas, li_baja_biblioteca, li_baja_laboratorio, li_baja_disciplina
integer li_tiene_mats_reval, li_docs_pliego_reval
integer li_docs_nacim, li_docs_estudios, li_docs_rev_est, li_docs_ss
integer li_sql_code=0
string ls_mensaje
long ll_cuenta
boolean lb_titulado_anterior
integer li_bloqueos,  li_tramites, li_revalidacion, li_documentos, li_indice=1, li_estado
long ll_cve_estado[], ll_cve_sub_estado[], ll_exito[]


SELECT
isnull(adeuda_finanzas,-1),
isnull(baja_laboratorio,-1),
isnull(baja_biblioteca,-1),
isnull(baja_disciplina,-1),

isnull(tiene_mats_reval,-1),
isnull(docs_pliego_reval,-1),

isnull(docs_nacim,-1),
isnull(docs_estudios,-1),
isnull(docs_rev_est,-1),
isnull(docs_ss,-1)
INTO
:li_adeuda_finanzas,
:li_baja_laboratorio,
:li_baja_biblioteca,
:li_baja_disciplina,

:li_tiene_mats_reval,
:li_docs_pliego_reval,

:li_docs_nacim,
:li_docs_estudios,
:li_docs_rev_est,
:li_docs_ss
FROM tramite_titulacion
WHERE cuenta = :al_cuenta
AND   cve_carrera = :al_cve_carrera
AND   cve_plan = :al_cve_plan
USING gtr_sce;

li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText

IF li_sql_code =-1 THEN	
	ROLLBACK USING gtr_sce;
	MessageBox("Error al Consultar", ls_mensaje,StopSign!)
	return -1
ELSE

	lb_titulado_anterior = iuo_atencion_opc_cero.of_titulado_anterior(al_cuenta, al_cve_carrera, al_cve_plan)

//Revisión de finanzas 
//Revision de baja de laboratorio
//Revisa adeudos de biblioteca
//Revisa baja por disciplina
	if li_adeuda_finanzas=0 and li_baja_laboratorio=0 and &
	 	li_baja_biblioteca=0 and li_baja_disciplina=0 then	
		 li_bloqueos= 1
	else
		 li_bloqueos= 0		
	end if

	li_indice= 1
	ll_cve_estado[li_indice]= 1
	ll_cve_sub_estado[li_indice] = 1
	ll_exito[li_indice] = li_bloqueos
						
//Si tiene materias revalidadas y pliego de revalidación o no tiene materias revalidadas
	if (li_tiene_mats_reval =1 and li_docs_pliego_reval=1) or &
		(li_tiene_mats_reval = 0) then		
		li_revalidacion= 1
	else		
		li_revalidacion= 0	
	end if
	li_indice= 	li_indice + 1
	ll_cve_estado[li_indice]= 1
	ll_cve_sub_estado[li_indice] = 3
	ll_exito[li_indice] = li_revalidacion


//Si tiene los documentos de nacimiento , 
//revisión de estudios y carta de servicio social			
	if li_docs_nacim=1 and &
		li_docs_rev_est=1 and li_docs_ss=1 then
//Si tiene certificado de estudios de bachillerato o se titulo antes en la ibero, 
		if lb_titulado_anterior or li_docs_estudios=1 then
			li_documentos = 1
		else
			li_documentos = 0				
		end if								
	end if
	li_indice= 	li_indice + 1
	ll_cve_estado[li_indice]= 1
	ll_cve_sub_estado[li_indice] = 4
	ll_exito[li_indice] = li_documentos
	
	li_estado= of_establece_estados(al_cuenta, al_cve_carrera, al_cve_plan, al_cve_tramite, ll_cve_estado, ll_cve_sub_estado, ll_exito)
	
	return li_estado
	
END IF


end function

public function boolean of_pago_tramite (long al_cuenta, long al_cve_carrera, long al_cve_plan);//of_pago_tramite
//Recibe 	al_cuenta	long
//			al_cve_carrera long
//			al_cve_plan		long

integer li_sql_code=0
string ls_mensaje
long ll_cuenta
long ll_num_pagos

SELECT 
COUNT(*)
INTO
:ll_num_pagos
FROM pago_tramite_titulacion
WHERE cuenta = :al_cuenta
AND   cve_carrera = :al_cve_carrera
AND   cve_plan = :al_cve_plan
AND 	cve_estatus_pago = 1
USING gtr_sce;

li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText

IF li_sql_code =-1 THEN	
	MessageBox("Error al Consultar", ls_mensaje,StopSign!)
	return false
ELSE
	IF ll_num_pagos= 0 THEN
		return false
	ELSEIF ll_num_pagos> 0 THEN
		return true
	END IF	
END IF

return false
end function

public function integer of_set_pago_tramite (long al_cuenta, long al_cve_carrera, long al_cve_plan, integer al_folio_mov_alumnos, integer al_cve_estatus_pago);//of_set_pago_tramite
//Recibe 	al_cuenta	long
//			al_cve_carrera long
//			al_cve_plan		long
//			al_cve_estatus_pago	integer

integer li_sql_code=0
string ls_mensaje
long ll_cuenta
long ll_num_pagos


SELECT 
COUNT(*)
INTO
:ll_num_pagos
FROM pago_tramite_titulacion
WHERE cuenta = :al_cuenta
AND   cve_carrera = :al_cve_carrera
AND   cve_plan = :al_cve_plan
USING gtr_sce;

li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText

IF li_sql_code =-1 THEN	
	MessageBox("Error al Consultar", ls_mensaje,StopSign!)
	return -1
ELSE
	IF ll_num_pagos= 0 THEN
	      insert into pago_tramite_titulacion (cuenta, cve_carrera, cve_plan, folio_mov_alumnos, cve_estatus_pago)
  		   values(:al_cuenta, :al_cve_carrera, :al_cve_plan, :al_folio_mov_alumnos, :al_cve_estatus_pago)
			USING gtr_sce;

			li_sql_code= gtr_sce.SQLCode
			ls_mensaje= gtr_sce.SQLErrText

			IF li_sql_code =-1 THEN	
				ROLLBACK USING gtr_sce;
				MessageBox("Error al Consultar", ls_mensaje,StopSign!)
				return -1
			ELSE
				COMMIT USING gtr_sce;
				return 0
			END IF
	ELSEIF ll_num_pagos> 0 THEN
		UPDATE  pago_tramite_titulacion
		SET 	cve_estatus_pago = :al_cve_estatus_pago,
			 	folio_mov_alumnos = :al_folio_mov_alumnos
		WHERE cuenta = :al_cuenta
		AND   cve_carrera = :al_cve_carrera
		AND   cve_plan = :al_cve_plan
		USING gtr_sce;

		li_sql_code= gtr_sce.SQLCode
		ls_mensaje= gtr_sce.SQLErrText

		IF li_sql_code =-1 THEN	
			ROLLBACK USING gtr_sce;
			MessageBox("Error al Consultar", ls_mensaje,StopSign!)
			return -1
		ELSE
			COMMIT USING gtr_sce;
			return 0
		END IF		
	END IF	
END IF

return 0

end function

public function boolean of_alumno_susceptible_ct (long al_cuenta, long al_cve_carrera, long al_cve_plan);// of_alumno_susceptible_ct
//Recibe 	al_cuenta	long
//			al_cve_carrera long
//			al_cve_plan		long

integer li_adeuda_finanzas, li_baja_biblioteca, li_baja_laboratorio, li_baja_disciplina
integer li_tiene_mats_reval, li_docs_pliego_reval
integer li_docs_nacim, li_docs_estudios, li_docs_rev_est, li_docs_ss
integer li_sql_code=0
string ls_mensaje
long ll_cuenta
boolean lb_titulado_anterior


SELECT
isnull(adeuda_finanzas,-1),
isnull(baja_laboratorio,-1),
isnull(baja_biblioteca,-1),
isnull(baja_disciplina,-1),

isnull(tiene_mats_reval,-1),
isnull(docs_pliego_reval,-1),

isnull(docs_nacim,-1),
isnull(docs_estudios,-1),
isnull(docs_rev_est,-1),
isnull(docs_ss,-1)
INTO
:li_adeuda_finanzas,
:li_baja_laboratorio,
:li_baja_biblioteca,
:li_baja_disciplina,

:li_tiene_mats_reval,
:li_docs_pliego_reval,

:li_docs_nacim,
:li_docs_estudios,
:li_docs_rev_est,
:li_docs_ss
FROM tramite_titulacion
WHERE cuenta = :al_cuenta
AND   cve_carrera = :al_cve_carrera
AND   cve_plan = :al_cve_plan
USING gtr_sce;

li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText

IF li_sql_code =-1 THEN	
	ROLLBACK USING gtr_sce;
	MessageBox("Error al Consultar", ls_mensaje,StopSign!)
	return false
ELSE

if not isvalid(iuo_atencion_opc_cero) then
	iuo_atencion_opc_cero = CREATE uo_atencion_opc_cero			
end if

lb_titulado_anterior = iuo_atencion_opc_cero.of_titulado_anterior(al_cuenta, al_cve_carrera, al_cve_plan)

//A petición de cobranzas, la revisión de finanzas no será obstáculo en el 
//trámite de opción cero
//	if li_adeuda_finanzas=0 and li_baja_laboratorio=0 then

//Revisa adeudos de biblioteca
	if li_baja_biblioteca=0 then
//Revisa baja por disciplina
		if li_baja_disciplina=0 then		
//Si tiene materias revalidadas y pliego de revalidación o no tiene materias revalidadas
			if (li_tiene_mats_reval =1 and li_docs_pliego_reval=1) or &
				(li_tiene_mats_reval = 0) then
//Si tiene los documentos de nacimiento , 
//revisión de estudios 
//no se pide carta de servicio social (and li_docs_ss=1 )
//no se pide la revision de estudios (li_docs_rev_est=1)
				if li_docs_nacim=1 then
//Si tiene certificado de estudios de bachillerato o se titulo antes en la ibero, 
					if lb_titulado_anterior or li_docs_estudios=1 then
						return true
					else
						return false				
					end if								
				else
					return false				
				end if			
			else
				return false	
			end if	
		else
			return false		
		end if
	else
		return false		
	end if
END IF

return true
end function

public function boolean of_alumno_susceptible_tramite (long al_cuenta, long al_cve_carrera, long al_cve_plan, long al_cve_tramite);//of_alumno_susceptible_tramite
//Recibe	al_cuenta			long
//			al_cve_carrera		long
//			al_cve_plan			long
//			al_cve_tramite		long
//Devuelve
//			boolean

boolean lb_alumno_susceptible= false, lb_areas_completas
integer li_alumno_susceptible, li_areas_completas, li_estado_diagnostico

CHOOSE CASE al_cve_tramite
//Titulación por opcion cero	
	CASE 1
		lb_areas_completas= true
	//Solo se revisaran las areas para los planes SANTA FE(3) y SANTA FE II(4)
		if al_cve_plan = 3 or al_cve_plan =4 then
			lb_areas_completas = of_areas_completas(al_cuenta, al_cve_carrera, al_cve_plan)
		end if
		if not isvalid(iuo_atencion_opc_cero) then
			iuo_atencion_opc_cero = CREATE uo_atencion_opc_cero			
		end if
	//Se revisa si el alumno es susceptible del tramite		
		li_estado_diagnostico= of_alumno_estado_diagnostico(al_cuenta, al_cve_carrera, al_cve_plan, al_cve_tramite)
		if li_estado_diagnostico= 0 and lb_areas_completas then
			lb_alumno_susceptible= true
		else			
			lb_alumno_susceptible= false
		end if
//Certificado total licenciatura, legalizado
	CASE 2
		lb_areas_completas= true
	//Solo se revisaran las areas para los planes SANTA FE(3) y SANTA FE II(4)
		if al_cve_plan = 3 or al_cve_plan =4 then
			lb_areas_completas = of_areas_completas(al_cuenta, al_cve_carrera, al_cve_plan)
		end if
	//Se revisa si el alumno es susceptible del tramite	
		if lb_areas_completas then
			lb_alumno_susceptible = of_alumno_susceptible_ct(al_cuenta, al_cve_carrera, al_cve_plan)
		else 
			lb_alumno_susceptible= false
		end if
	//Cualquier otro trámite se considerara no susceptible
	CASE ELSE
			lb_alumno_susceptible= false
END CHOOSE

if lb_alumno_susceptible then
	li_alumno_susceptible=1
else
	li_alumno_susceptible=0
end if

if lb_areas_completas then
	li_areas_completas=1
else
	li_areas_completas=0	
end if

//Insercion de Estados de Revision de areas y resumen
this.of_establece_estado(al_cuenta, al_cve_carrera, al_cve_plan, al_cve_tramite,1, 5, li_areas_completas)
this.of_establece_estado(al_cuenta, al_cve_carrera, al_cve_plan, al_cve_tramite,1, 0, li_alumno_susceptible)

RETURN lb_alumno_susceptible


end function

on uo_atencion_tramite.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_atencion_tramite.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

