$PBExportHeader$uo_profesor_servicios.sru
forward
global type uo_profesor_servicios from nonvisualobject
end type
end forward

global type uo_profesor_servicios from nonvisualobject
end type
global uo_profesor_servicios uo_profesor_servicios

type variables
STRING is_error 

INTEGER ie_periodo 
INTEGER ie_anio

// Grupo que se valida 
LONG il_cve_mat
STRING is_gpo

LONG il_cve_profesor
STRING is_nombre
STRING is_apaterno
STRING is_amaterno
LONG il_cve_depto
DATETIME idt_fecha_ingreso
STRING is_cve_grado_acad
INTEGER ii_nivel
INTEGER ii_cve_categoria
INTEGER ii_cve_tiempo
STRING is_nombre_completo
STRING is_status
STRING is_sexo
STRING is_rfc
STRING is_vpassword
STRING is_vcorreo_portal
INTEGER ie_horas_semanales
INTEGER ie_horas_semanales_profesor 

INTEGER ie_horas_per_calculadas

INTEGER ie_forma_imparte 

INTEGER ie_horas_reales_periodo 

// Horas del horario del grupo que se captura 
INTEGER ie_horas_horario_captura

n_tr itr_sce 
uo_grupo_servicios iuo_grupo_servicios 

// Variables de parámetros

INTEGER ie_horas_gpo_normal  
DECIMAL id_factor_ajuste_horas  
INTEGER ie_horas_adic_x_una_mat 
INTEGER ie_horas_capturadas
INTEGER ie_semanas_semestre

// Grupos donde el profesor da clases en el horario actual. "dw_horario_prof_validar"
DATASTORE ids_horario_profesor
// Datastore dónde se recibe el horario que se edita para su validación.  "dw_horario_prof_validar" 
DATASTORE ids_verifica_horario_paso

// Matriz para validación de cruces de Horarios. "dw_valida_horario_prof"  
DATASTORE ids_matriz_horario

DATASTORE ids_dias_no_laborables

DATETIME idt_inicio_periodo
DATETIME idt_fin_periodo 

//Horas reales totales semanales 
// Se inicializa el valor. (La función de cálculo está en el objeto de servicio de GRUPOS -uo_grupo_servicios-.) 
INTEGER ie_horas_reales_tot_sem

INTEGER ie_num_ptrofesores
BOOLEAN ib_modifica_salon 

LONG il_coordinacion


INTEGER ie_horas_totales_semestre


end variables

forward prototypes
public function integer of_recupera_profesor (long al_cve_profesor)
public function integer of_busca_profesor (string as_nombre, string as_apaterno, string as_amaterno)
public function integer of_inicializa_parametros ()
public function integer of_profesor_bloqueado (integer ai_periodo, integer ai_anio, long al_coordinacion)
public function integer of_inicia_matriz_validacion ()
public function integer of_valida_horario_profesor (long al_cve_profesor, integer ai_periodo, integer ai_anio, long al_cve_materia, string as_gpo)
public function integer of_valida_horas_profesor (long al_cve_materia, string as_gpo, integer ae_tipo)
public function integer of_carga_dias_no_laborables ()
public function long wf_recupera_coordinacion (string as_materia_gpo)
public function integer of_cuenta_horas_reales_profesor (long al_cve_profesor, integer as_horas_reales_materia)
end prototypes

public function integer of_recupera_profesor (long al_cve_profesor);
is_error = ""

// Se recupera la información del profesor solicitado y se deja en las variables de instancia 
SELECT cve_profesor, nombre, apaterno, amaterno, cve_depto, 
			fecha_ingreso, cve_grado_acad, nivel, cve_categoria, cve_tiempo, 
			nombre_completo, status, sexo, rfc, vpassword, 
			vcorreo_portal
INTO 	:il_cve_profesor, :is_nombre, :is_apaterno, :is_amaterno, :il_cve_depto, 
		:idt_fecha_ingreso, :is_cve_grado_acad, :ii_nivel, :ii_cve_categoria, :ii_cve_tiempo, 
		:is_nombre_completo, :is_status, :is_sexo, :is_rfc, :is_vpassword, 
		:is_vcorreo_portal
FROM profesor 
WHERE cve_profesor = :al_cve_profesor 
AND	status = "A"
USING itr_sce; 
IF itr_sce.SQLCODE < 0 THEN 
	is_error = "Se produjo un error al recuperar la información del profesor: "  + itr_sce.SQLERRTEXT 
	RETURN -1
ELSEIF itr_sce.SQLCODE = 100 THEN 
	//is_error = "El profesor " + STRING(il_cve_profesor) + " no existe o se encuentra inactivo. " 
	is_error = "El profesor " + STRING(al_cve_profesor) + " no existe o se encuentra inactivo. "  
	RETURN 100 
END IF 


RETURN 0 



end function

public function integer of_busca_profesor (string as_nombre, string as_apaterno, string as_amaterno);	
LONG 	ll_ttl_prof 
	

as_nombre = "%" + as_nombre + "%" 
as_apaterno = "%" + as_apaterno + "%" 
as_amaterno = "%" + as_amaterno + "%" 	 
	
// Se verifica si existe más de un profesor con el mismo nombre
SELECT COUNT(*) 
INTO :ll_ttl_prof 
FROM profesor 
WHERE nombre LIKE :as_nombre 
	OR  apaterno LIKE :as_apaterno 
	OR amaterno LIKE :as_amaterno 	
USING itr_sce;	
IF itr_sce.SQLCODE < 0 THEN 
	is_error = "Se produjo un error al verificar la existencia del profesor: " +  itr_sce.SQLERRTEXT 
	RETURN -1 
END IF 

IF ll_ttl_prof = 1 THEN 
	
	
ELSEIF ll_ttl_prof > 1 THEN 
	
	
ELSEIF ll_ttl_prof = 0 THEN 
	
	
END IF 
	   
	
	
//
//	
//END IF
//
//	
//	
//	
//	
//	CHOOSE CASE ls_columna
//		CASE "nombre"
//		     ls_nombre ="%"+dw_nombre_alumno.gettext()+"%"
//			  ls_apat="%--%"
//			  ls_amat="%--%"
//			  SELECT profesor.cve_profesor  
//	    		 INTO :ll_cve_profesor  
//	    	    FROM profesor  
//	   		WHERE profesor.nombre like :ls_nombre
//				AND	profesor.status = "A"
//				USING itr_sce;
//		CASE "apaterno"
//			  ls_nombre="%--%"
//			  ls_amat="%--%"			
//			  ls_apat ="%"+dw_nombre_alumno.gettext()+"%"
//			  SELECT profesor.cve_profesor  
//	    		 INTO :ll_cve_profesor  
//	    	    FROM profesor  
//	   		WHERE profesor.apaterno like :ls_apat
//				AND	profesor.status = "A"
//				USING itr_sce;
//		CASE "amaterno"
//			  ls_nombre="%--%"
//			  ls_apat="%--%"
//			  ls_amat ="%"+dw_nombre_alumno.gettext()+"%"			  
//			  SELECT profesor.cve_profesor  
//	    		 INTO :ll_cve_profesor  
//	    	    FROM profesor  
//	   		WHERE profesor.amaterno like :ls_amat
//				AND	profesor.status = "A"
//				USING itr_sce;
//	END CHOOSE	
//	
//	if itr_sce.sqlerrtext = "Select returned more than one row" then
//		origen = entrega_ventana()
//		openwithparm(w_profesoresnombre,origen)
////		opensheetwithparm(w_profesoresnombre,origen, w_principal)
//		IF isvalid(w_profesoresnombre)  then
//			if w_profesoresnombre.dw_nombre.retrieve(ls_nombre,ls_apat,ls_amat)  = 0 then
//				messagebox("Aviso","No existe ningun "+mid(ls_nombre,2,len(ls_nombre)-2)+" "+mid(ls_apat,2,len(ls_apat)-2)+" "+mid(ls_amat,2,len(ls_amat)-2)+" dado de alta.")
//				close(w_profesoresnombre)
//			end if	
//		ELSE
//			MessageBox('w_profesoresnombre', 'El objeto no ha sido creado',Stopsign!)
//		END IF
//	else
//		if dw_nombre_alumno.retrieve(ll_cve_profesor) = 0 then
//			dw_nombre_alumno.insertrow(0)
//		else 
//			em_cve_profesor.text=string(ll_cve_profesor)
//			lch_digito = obten_digito(ll_cve_profesor)
//			em_digito.text=lch_digito
//			iw_ventana.triggerevent("inicia_proceso",0,ll_cve_profesor)
//			iw_ventana.triggerevent(doubleclicked!)
//		end if	
//	end if	
end function

public function integer of_inicializa_parametros ();

// Parámetros de ajuste de horas permitidas para el profesor.
SELECT horas_normales, factor_ajuste_horas, horas_adic_x_una_mat, semanas_semestre  
INTO :ie_horas_gpo_normal, :id_factor_ajuste_horas, :ie_horas_adic_x_una_mat, :ie_semanas_semestre 
FROM dbo.periodo_parametros
WHERE periodo = :ie_periodo
USING  itr_sce;
IF itr_sce.SQLCODE < 0 THEN 
	is_error = "Se produjo un error al recuparar las horas permitidas para el periodo actual: " + itr_sce.SQLERRTEXT  
	RETURN -1
END IF

ids_horario_profesor = CREATE DATASTORE 
ids_horario_profesor.DATAOBJECT = "dw_horario_prof_validar" 

ids_verifica_horario_paso = CREATE DATASTORE  
ids_verifica_horario_paso.DATAOBJECT = "dw_horario_prof_validar"

ids_dias_no_laborables = CREATE DATASTORE 
ids_dias_no_laborables.DATAOBJECT = "dw_calendario_grupos_mod"

//of_carga_dias_no_laborables() 

//SELECT fecha 
//INTO :idt_inicio_periodo 
//FROM calendario 
//WHERE periodo = :ie_periodo
//AND anio = :ie_anio 
//AND cve_evento = 1
//USING itr_sce;
//IF itr_sce.SQLCODE < 0 THEN 
//	MESSAGEBOX("ERROR", "Se produjo un error al recuperar la fecha de inicio de semestre: " + itr_sce.SQLERRTEXT)
//	RETURN -1 
//END IF
//
//SELECT fecha 
//INTO :idt_fin_periodo
//FROM calendario 
//WHERE periodo = :ie_periodo
//AND anio = :ie_anio  
//AND cve_evento = 2 
//USING itr_sce;
//IF itr_sce.SQLCODE < 0 THEN 
//	MESSAGEBOX("ERROR", "Se produjo un error al recuperar la fecha de fin de semestre: " + itr_sce.SQLERRTEXT)
//	RETURN -1 
//END IF



RETURN 0 



end function

public function integer of_profesor_bloqueado (integer ai_periodo, integer ai_anio, long al_coordinacion);//f_profesor_bloqueado
//Recibe:
//	al_cve_profesor		long
//	al_periodo		integer
//	al_anio			integer
// al_cve_coordinacion 	integer
//Devuelve:
//	Boolean que indica si el profesor en cuestion está bloqueado para el periodo vigente

long  ll_cve_profesor
integer li_codigo_sql
string ls_mensaje_sql 
LONG ll_coordinacion

SELECT nomina
INTO	:ll_cve_profesor
FROM	dbo.v_sg_profesores_bloq
WHERE nomina = :il_cve_profesor
AND (( periodo_inicio <= :ai_periodo And anio_inicio = :ai_anio) Or (anio_inicio < :ai_anio))
AND (( periodo_fin     >= :ai_periodo And anio_fin     = :ai_anio) Or (anio_fin    > :ai_anio))
and (cve_coordinacion = :al_coordinacion)
USING gtr_sce;

li_codigo_sql = gtr_sce.SqlCode
ls_mensaje_sql = gtr_sce.SqlErrText

if li_codigo_sql = 100 or isnull(ll_cve_profesor) then
	return 0
elseif li_codigo_sql = -1 then
	MessageBox("Error al consultar v_sg_profesores_bloq", ls_mensaje_sql)
	return 0
elseif li_codigo_sql = 0 then	
	if ll_cve_profesor> 0 then
		MessageBox("Profesor Bloqueado", &
					  "El profesor "+string(il_cve_profesor)+ " está bloqueado para el periodo actual.~n "+&
					  "Para mayores detalles favor de comunicarse a la Dirección de Análisis e Información Académica.",StopSign!)
		RETURN -1 			  
	else
		return 0
	end if	
end if

return 0


//// Se llama función para validar si el profesor se encuentra bloqueado. Se hace de esta manera para concentrar los llamados a funciones de profesor desde un solo objeto de servicios.
//if f_profesor_bloqueado(il_cve_profesor, ai_periodo, ai_anio, al_coordinacion) then
//	MessageBox("Profesor Bloqueado", &
//	           "El profesor "+string(il_cve_profesor)+ " está bloqueado para el periodo actual.~n "+&
//				  "Para mayores detalles favor de comunicarse a la Dirección de Análisis e Información Académica.",StopSign!)
//	return -1
//end if 
//
//RETURN 0 
//



end function

public function integer of_inicia_matriz_validacion ();
DATE ldt_dia
DATE ldt_inicio
DATE ldt_fin 
INTEGER le_hora 
INTEGER le_row 

IF NOT ISVALID(ids_matriz_horario) THEN 
	ids_matriz_horario = CREATE DATASTORE 
	ids_matriz_horario.DATAOBJECT = "dw_valida_horario_prof" 
ELSE
	ids_matriz_horario.RESET() 
END IF

ldt_inicio = DATE(idt_inicio_periodo) 
ldt_fin = DATE(idt_fin_periodo) 

ldt_dia = ldt_inicio 

DO 
	
	FOR le_hora = 7 TO 21 STEP 1 

		le_row = ids_matriz_horario.INSERTROW(0) 
		
		ids_matriz_horario.SETITEM(le_row, "fecha", ldt_dia) 
		ids_matriz_horario.SETITEM(le_row, "hora_inicio", le_hora) 
		ids_matriz_horario.SETITEM(le_row, "hora_fin", le_hora + 1) 
		
	NEXT 
	
	ldt_dia = RELATIVEDATE(ldt_dia, 1) 
	
LOOP WHILE ldt_dia <= ldt_fin 


RETURN 0  





end function

public function integer of_valida_horario_profesor (long al_cve_profesor, integer ai_periodo, integer ai_anio, long al_cve_materia, string as_gpo);INTEGER le_ttl_horario
INTEGER le_pos 

INTEGER le_hora_inicio	
INTEGER le_hora_fin	
STRING ls_domingo	
STRING ls_lunes	
STRING ls_martes	
STRING ls_miercoles	
STRING ls_jueves	
STRING ls_viernes	
STRING ls_sabado	
DATE ldt_fecha

LONG ll_cve_mat	
STRING ls_gpo	
DATE ldt_fecha_inicio	
DATE ldt_fecha_fin	
INTEGER le_cve_dia	
INTEGER le_hora_inicial	
INTEGER le_hora_final
LONG ll_coordinacion

INTEGER le_pos_valida 
LONG ll_cve_prof

INTEGER ie_row 
INTEGER le_dia_matriz

// Se recuperan Todos los Grupos y Horarios donde el Prof da clases en el horario actual.  
ids_horario_profesor = CREATE DATASTORE 
ids_horario_profesor.DATAOBJECT = "dw_horario_prof_validar"  
ids_horario_profesor.SETTRANSOBJECT(itr_sce)   

of_inicia_matriz_validacion() 

STRING ls_SQL  

IF itr_sce.Servername = "SQLWEBPRO"  THEN  
	
	ls_SQL = " SELECT g.cve_mat as cve_mat, " + & 
						  " g.gpo as gpo, " + &  
						  " h.fecha_inicio as fecha_inicio, " + &  
						  " h.fecha_fin as fecha_fin, " + &  
						  " h.cve_dia as cve_dia, " + &  
						  " h.hora_inicio as hora_inicio , " + &  
						  " h.hora_final as hora_final, " + &  
						  "  grupos_cve_profesor = h.cve_profesor, " + &  
						  " m.cve_coordinacion as cve_coordinacion " + &  
				" FROM grupos g, horario_profesor_grupo h, materias m " + &     
				" WHERE h.cve_profesor = " + STRING(al_cve_profesor) + &  
				" AND g.periodo = " + STRING(ai_periodo) + &  
				" AND g.anio = " + STRING(ai_anio) + &  
				" AND g.cve_mat = h.cve_mat " + &  
				" AND g.gpo = h.gpo COLLATE SQL_Latin1_General_CP1_CI_AS " + &  
				" AND g.periodo = h.periodo " + &  
				" AND g.anio = h.anio " + &  
				" AND m.cve_mat = g.cve_mat " + & 
				" AND NOT (g.cve_mat = " + STRING(al_cve_materia) + " AND g.gpo = ~~'" + as_gpo + "~~' ) " + & 
				" ORDER BY g.cve_profesor, g.cve_mat_gpo "   
				
				//" AND g.cve_profesor = h.cve_profesor " + & 
				
	ids_horario_profesor.MODIFY("Datawindow.Table.Select = '" + ls_SQL + "'") 

END IF 

le_ttl_horario = ids_horario_profesor.RETRIEVE(al_cve_profesor, ai_periodo, ai_anio, al_cve_materia, as_gpo)  

// Se agrega el horario que se edita para su validación. 
ids_verifica_horario_paso.SETFILTER("grupos_cve_profesor = " + STRING(al_cve_profesor)) 
ids_verifica_horario_paso.FILTER() 
ids_verifica_horario_paso.ROWSCOPY(1, ids_verifica_horario_paso.ROWCOUNT(), PRIMARY!, ids_horario_profesor, ids_horario_profesor.ROWCOUNT() + 1, PRIMARY!)   

le_ttl_horario = ids_horario_profesor.ROWCOUNT() 

FOR le_pos = 1 TO le_ttl_horario 

	

	ll_cve_mat = ids_horario_profesor.GETITEMNUMBER(le_pos, "grupos_cve_mat") 
	ls_gpo = TRIM(ids_horario_profesor.GETITEMSTRING(le_pos, "grupos_gpo"))	  
//	ldt_fecha_inicio = DATE(ids_horario_profesor.GETITEMDATETIME(le_pos, "grupos_fecha_inicio"))
//	ldt_fecha_fin = DATE(ids_horario_profesor.GETITEMDATETIME(le_pos, "grupos_fecha_fin")) 
	ldt_fecha_inicio = DATE(ids_horario_profesor.GETITEMDATETIME(le_pos, "horario_profesor_grupo_fecha_inicio"))
	ldt_fecha_fin = DATE(ids_horario_profesor.GETITEMDATETIME(le_pos, "horario_profesor_grupo_fecha_fin")) 
	
	le_cve_dia = ids_horario_profesor.GETITEMNUMBER(le_pos, "horario_profesor_grupo_cve_dia")  
	le_hora_inicio = ids_horario_profesor.GETITEMNUMBER(le_pos, "horario_profesor_grupo_hora_inicio")  
	le_hora_fin = ids_horario_profesor.GETITEMNUMBER(le_pos, "horario_profesor_grupo_hora_final")   
	ll_coordinacion = ids_horario_profesor.GETITEMNUMBER(le_pos, "materias_cve_coordinacion")   
	
	ll_cve_prof = ids_horario_profesor.GETITEMNUMBER(le_pos, "grupos_cve_profesor")   
	// Si el profesor es "POR DESIGNAR" no se valida 
	IF ll_cve_prof = 1 THEN CONTINUE 
//	IF ll_cve_prof = al_cve_profesor THEN CONTINUE 

	FOR le_pos_valida = 1 TO ids_matriz_horario.ROWCOUNT() STEP 1 
		
		le_hora_inicial = ids_matriz_horario.GETITEMNUMBER(le_pos_valida, "hora_inicio") 
		le_hora_final = ids_matriz_horario.GETITEMNUMBER(le_pos_valida, "hora_fin")  
		ldt_fecha = ids_matriz_horario.GETITEMDATE(le_pos_valida, "fecha") 		 
		
		le_dia_matriz = DAYNUMBER(DATE(ldt_fecha)) - 1 
		
		// Si no se imparte clase en esa fecha en particular continua la validación.
		IF le_cve_dia <> le_dia_matriz THEN CONTINUE 
		
		// Si la fecha ya es posterior a la fecha de fin, termina el ciclo 
		IF ldt_fecha > ldt_fecha_fin THEN EXIT 

		// FECHAS
		IF ldt_fecha >= ldt_fecha_inicio AND ldt_fecha <= ldt_fecha_fin THEN 
			
			// HORAS
			IF le_hora_inicial >= le_hora_inicio AND le_hora_final <= le_hora_fin AND le_hora_inicial <= le_hora_fin AND le_hora_final > le_hora_inicio  THEN  

				CHOOSE CASE le_cve_dia 
					// DOMINGO	
					CASE 0
						ls_domingo = ids_matriz_horario.GETITEMSTRING(le_pos_valida, "domingo") 
						ll_coordinacion = wf_recupera_coordinacion(ls_domingo) 
						IF (TRIM(ls_domingo) <> "" AND ll_coordinacion = il_coordinacion) OR (TRIM(ls_domingo) <> "" AND 9999 = il_coordinacion)  THEN 
							is_error = "Doble presencia del profesor: " + STRING(al_cve_profesor) + " El grupo " + STRING(ll_cve_mat) + "-" + ls_gpo + " tiene conflicto de horario con el grupo: " + ls_domingo 
							RETURN -1 
						END IF
						ls_domingo = STRING(ll_cve_mat) + "-" + ls_gpo + " "  
						ids_matriz_horario.SETITEM(le_pos_valida, "domingo", ls_domingo) 
					//LUNES	
					CASE 	1		
						ls_lunes = ids_matriz_horario.GETITEMSTRING(le_pos_valida, "lunes") 
						ll_coordinacion = wf_recupera_coordinacion(ls_lunes) 
						IF (TRIM(ls_lunes) <> "" AND ll_coordinacion = il_coordinacion) OR (TRIM(ls_lunes) <> "" AND 9999 = il_coordinacion) THEN 
							is_error = "Doble presencia del profesor: " + STRING(al_cve_profesor) + " El grupo " + STRING(ll_cve_mat) + "-" + ls_gpo + " tiene conflicto de horario con el grupo: " + ls_lunes 
							RETURN -1 
						END IF					
						ls_lunes = STRING(ll_cve_mat) + "-" + ls_gpo + " "  
						ids_matriz_horario.SETITEM(le_pos_valida, "lunes", ls_lunes)  					
					//MARTES
					CASE 	2		
						ls_martes = ids_matriz_horario.GETITEMSTRING(le_pos_valida, "martes") 
						ll_coordinacion = wf_recupera_coordinacion(ls_martes) 
						IF (TRIM(ls_martes) <> "" AND ll_coordinacion = il_coordinacion) OR (TRIM(ls_martes) <> "" AND 9999 = il_coordinacion) THEN 
							is_error = "Doble presencia del profesor: " + STRING(al_cve_profesor) + " El grupo " + STRING(ll_cve_mat) + "-" + ls_gpo + " tiene conflicto de horario con el grupo: " + ls_martes 
							RETURN -1 
						END IF					
						ls_martes = STRING(ll_cve_mat) + "-" + ls_gpo + " "  
						ids_matriz_horario.SETITEM(le_pos_valida, "martes", ls_martes) 	 					
					//MIERCOLES 	
					CASE 	3
						ls_miercoles = ids_matriz_horario.GETITEMSTRING(le_pos_valida, "miercoles") 
						ll_coordinacion = wf_recupera_coordinacion(ls_miercoles) 
						IF (TRIM(ls_miercoles) <> "" AND ll_coordinacion = il_coordinacion) OR  (TRIM(ls_miercoles) <> "" AND 9999 = il_coordinacion) THEN 
							is_error = "Doble presencia del profesor: " + STRING(al_cve_profesor) + " El grupo " + STRING(ll_cve_mat) + "-" + ls_gpo + " tiene conflicto de horario con el grupo: " + ls_miercoles 
							RETURN -1 
						END IF					
						ls_miercoles = STRING(ll_cve_mat) + "-" + ls_gpo + " "  
						ids_matriz_horario.SETITEM(le_pos_valida, "miercoles", ls_miercoles)   
					//JUEVES 	
					CASE 	4		
						ls_jueves	 = ids_matriz_horario.GETITEMSTRING(le_pos_valida, "jueves") 
						ll_coordinacion = wf_recupera_coordinacion(ls_jueves) 
						IF (TRIM(ls_jueves) <> "" AND ll_coordinacion = il_coordinacion) OR (TRIM(ls_jueves) <> "" AND 9999 = il_coordinacion) THEN 
							is_error = "Doble presencia del profesor: " + STRING(al_cve_profesor) +  " El grupo " + STRING(ll_cve_mat) + "-" + ls_gpo + " tiene conflicto de horario con el grupo: " + ls_jueves 
							RETURN -1 
						END IF					
						ls_jueves = STRING(ll_cve_mat) + "-" + ls_gpo + " "   
						ids_matriz_horario.SETITEM(le_pos_valida, "jueves", ls_jueves)   
					//VIERNES	
					CASE 	5		
						ls_viernes = ids_matriz_horario.GETITEMSTRING(le_pos_valida, "viernes") 
						ll_coordinacion = wf_recupera_coordinacion(ls_viernes) 
						IF (TRIM(ls_viernes) <> "" AND ll_coordinacion = il_coordinacion) OR  (TRIM(ls_viernes) <> "" AND 9999 = il_coordinacion) THEN 
							is_error = "Doble presencia del profesor: " + STRING(al_cve_profesor) + " El grupo " + STRING(ll_cve_mat) + "-" + ls_gpo + " tiene conflicto de horario con el grupo: " + ls_viernes 
							RETURN -1 
						END IF					
						ls_viernes = STRING(ll_cve_mat) + "-" + ls_gpo + " "  
						ids_matriz_horario.SETITEM(le_pos_valida, "viernes", ls_viernes) 	
					//SABADO	
					CASE 	6
						ls_sabado = ids_matriz_horario.GETITEMSTRING(le_pos_valida, "sabado")   
						ll_coordinacion = wf_recupera_coordinacion(ls_sabado) 
						IF (TRIM(ls_sabado) <> "" AND ll_coordinacion = il_coordinacion) OR (TRIM(ls_sabado) <> "" AND 9999 = il_coordinacion) THEN 
							is_error = "Doble presencia del profesor: " + STRING(al_cve_profesor) +  " El grupo " + STRING(ll_cve_mat) + "-" + ls_gpo + " tiene conflicto de horario con el grupo: " + ls_sabado 
							RETURN -1 
						END IF					
						ls_sabado = STRING(ll_cve_mat) + "-" + ls_gpo + " "   					
						ids_matriz_horario.SETITEM(le_pos_valida, "sabado", ls_sabado) 	
				END CHOOSE  
				
			// HORAS
			END IF

		// FECHAS
		END IF

	NEXT 
	
NEXT 

RETURN 0 



		


end function

public function integer of_valida_horas_profesor (long al_cve_materia, string as_gpo, integer ae_tipo);// Función de validación de horas permitidas a un profesor.
LONG ll_horas_gpo_normal
DECIMAL ld_factor_ajuste_horas
INTEGER le_horas_adic_x_una_mat
INTEGER le_semanas_semestre
STRING ls_mensaje 
LONG ll_horas_permitidas
LONG ll_horas_totales_profesor
LONG ll_horas_semanales_profesor 

INTEGER li_cve_categoria 
datastore lds_data //, lds_data2
LONG ll_num_reg
LONG ll_suma_horas, ll_row_horas_coord, ll_horas_reales
STRING ls_coordinacion 
LONG ll_suma_horas_mas_actual

LONG ll_cve_materia 
STRING ls_gpo 
INTEGER le_periodo 
INTEGER  le_anio  
DATETIME ldt_fecha_inicio_gpo
DATETIME ldt_fecha_fin_gpo
INTEGER le_forma_imparte
STRING ls_multititular

STRING ls_query 
LONG ll_ttl 
LONG ll_horas_multititular 
LONG ll_horas_tradicional , le_horas_grupo_valida

uo_grupo_servicios luo_grupo_servicios 
luo_grupo_servicios = CREATE uo_grupo_servicios 
luo_grupo_servicios.itr_sce = itr_sce 
//iuo_grupo_servicios.il_cve_coordinacion_paq = il_coordinacion 
luo_grupo_servicios.of_inicializa_parametros() 


li_cve_categoria = f_obten_categoria_profesor(il_cve_profesor)
if li_cve_categoria= -1 then
	MessageBox("Error en consulta de categoria", "No es posible consultar la categoria del profesor capturado",StopSign!)			
end if

// Revision para grupos no asimilados 	ae_tipo <> 2
//claves de profesor validas 				ll_cve_profesor > 8
//en profesores de asignatura 			li_cve_categoria = 4 
if ae_tipo <> 2 and il_cve_profesor > 8 and  li_cve_categoria = 4 then 

		
	// Se recupera el factor de ajuste por periodo. 
	SELECT horas_normales, factor_ajuste_horas, horas_adic_x_una_mat, semanas_semestre
	INTO :ll_horas_gpo_normal, :ld_factor_ajuste_horas, :le_horas_adic_x_una_mat, :le_semanas_semestre
	FROM periodo_parametros
	WHERE periodo = :ie_periodo
	USING  itr_sce;
	IF itr_sce.SQLCODE < 0 THEN 
		MESSAGEBOX("Error", "Se produjo un error al recuparar las horas permitidas para el periodo actual: " + itr_sce.SQLERRTEXT)
		RETURN -1
	END IF
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Se verifica si el profesor solo tiene un grupo.
	INTEGER le_numero_grupos_dif
	
	SELECT COUNT(*) 
	INTO :le_numero_grupos_dif 
	FROM grupos g, profesor_cotitular pc   
	WHERE pc.cve_profesor = :il_cve_profesor  
	AND	g.tipo not in (1, 2)
	AND   g.periodo = :ie_periodo
	AND   g.anio = :ie_anio 
	AND NOT (g.cve_mat = :al_cve_materia AND g.gpo = :as_gpo) 
	AND g.cve_mat = pc.cve_mat
	AND g.gpo = pc.gpo 
	AND g.periodo = pc.periodo
	AND g.anio = pc.anio 	
	AND	g.cond_gpo = 1 
	USING itr_sce; 
	IF itr_sce.SQLCODE < 0 THEN 
		MESSAGEBOX("Error", "Se produjo un error al recuperar otros grupos del profesor:" + itr_sce.SQLERRTEXT)
		RETURN -1 
	END IF
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Se calcula el número de horas máximo del profesor. 
	IF le_numero_grupos_dif = 0 THEN 
		//ll_horas_permitidas = (ll_horas_gpo_normal + le_horas_adic_x_una_mat) * le_semanas_semestre 
		ll_horas_permitidas = (ll_horas_gpo_normal + le_horas_adic_x_una_mat) 
	ELSEIF le_numero_grupos_dif > 0 THEN  
		//ll_horas_permitidas = ll_horas_gpo_normal * le_semanas_semestre 
		ll_horas_permitidas = ll_horas_gpo_normal 
	END IF	
	
	/*Se recuperan los diferentes grupos donde el profesor imparte clases*/ 
	INTEGER le_pos_grupo 
	INTEGER le_horas_acumuladas
	INTEGER le_horas_grupo_actual
	DATASTORE lds_grupos_diferentes 	
	

ls_query = " SELECT g.cve_mat, g.gpo, g.periodo, g.anio, g.fecha_inicio, g.fecha_fin, g.forma_imparte, multititular = ~~'N~~' " + &       
				"  FROM horario h, grupos g " + &   
					" WHERE NOT(h.cve_mat = " + STRING(al_cve_materia) + " AND h.gpo = ~~'" + as_gpo + "~~') " + &
					" AND h.periodo = " + STRING(ie_periodo) + &     
					" AND h.anio = " + STRING(ie_anio) + &    
					" AND g.cve_profesor = " + STRING(il_cve_profesor) + &
					" AND g.cve_mat = h.cve_mat " + &      
					" AND g.gpo = h.gpo " + &     
					" AND g.periodo = h.periodo " + &     
					" AND g.anio = h.anio " + &    
					" AND g.tipo <> 1 " + &    
					" AND NOT EXISTS(  SELECT * FROM horario_profesor_grupo pg " + &      
										" WHERE pg.cve_profesor = " + STRING(il_cve_profesor)  + &    
										" AND pg.cve_mat = h.cve_mat " + &      
										" AND pg.gpo = h.gpo " + &     
										" AND pg.periodo = h.periodo " + &     
										" AND pg.anio = h.anio) " + &      
				" UNION " + &      
				" SELECT g.cve_mat, g.gpo, g.periodo, g.anio, g.fecha_inicio, g.fecha_fin, g.forma_imparte, multititular = ~~'S~~' " + &         
				" FROM horario_profesor_grupo pg, grupos g " + &      
				" WHERE pg.cve_profesor = " + STRING(il_cve_profesor) + &
					" AND NOT(pg.cve_mat = " + STRING(al_cve_materia) + " AND pg.gpo = ~~'" + as_gpo + "~~') " + &      
					" AND pg.periodo = " + STRING(ie_periodo) + &     
					" AND pg.anio = " + STRING(ie_anio) + &    
					" AND g.cve_mat = pg.cve_mat " + &     
					" AND g.gpo = pg.gpo " + &     
					" AND g.periodo = pg.periodo " + &     
					" AND g.anio = pg.anio "   
	
	
	lds_grupos_diferentes = CREATE DATASTORE 
	lds_grupos_diferentes.DATAOBJECT = "dw_grupos_prof_diferentes" 
	lds_grupos_diferentes.MODIFY("Datawindow.table.Select = '" + ls_query + "'")
	lds_grupos_diferentes.SETTRANSOBJECT(itr_sce) 
	le_numero_grupos_dif = lds_grupos_diferentes.RETRIEVE() 
	
	iuo_grupo_servicios = CREATE uo_grupo_servicios 
	iuo_grupo_servicios.itr_sce = itr_sce 
	

	
	DATASTORE lds_horas_grupos
	lds_horas_grupos = CREATE DATASTORE 
	
	
	/*Se hace ciclo para contar las horas semanales de cada grupo*/
	FOR le_pos_grupo = 1 TO le_numero_grupos_dif 
	
		ll_cve_materia = lds_grupos_diferentes.GETITEMNUMBER(le_pos_grupo, "cve_mat")
		ls_gpo = lds_grupos_diferentes.GETITEMSTRING(le_pos_grupo, "gpo") 
		le_periodo = lds_grupos_diferentes.GETITEMNUMBER(le_pos_grupo, "periodo") 
		le_anio = lds_grupos_diferentes.GETITEMNUMBER(le_pos_grupo, "anio")   
		ldt_fecha_inicio_gpo = lds_grupos_diferentes.GETITEMDATETIME(le_pos_grupo, "fecha_inicio") 
		ldt_fecha_fin_gpo = lds_grupos_diferentes.GETITEMDATETIME(le_pos_grupo, "fecha_fin") 
		le_forma_imparte = lds_grupos_diferentes.GETITEMNUMBER(le_pos_grupo, "forma_imparte") 
		ls_multititular = lds_grupos_diferentes.GETITEMSTRING(le_pos_grupo, "multititular") 
		
		// Se carga el grupo para validar as horas totales del mismo. 
		luo_grupo_servicios.of_nuevo( )
		luo_grupo_servicios.il_cve_mat = ll_cve_materia
		luo_grupo_servicios.is_gpo = ls_gpo
		luo_grupo_servicios.ie_periodo = le_periodo 
		luo_grupo_servicios.ie_anio = le_anio 
		luo_grupo_servicios.of_fechas_periodo() 
		IF luo_grupo_servicios.of_carga_grupo() < 0 THEN 
			MESSAGEBOX("Aviso", luo_grupo_servicios.is_error ) 
			RETURN -1
		END IF
		luo_grupo_servicios.of_carga_dias_no_laborables() 
		le_horas_grupo_valida = luo_grupo_servicios.of_horas_semestre() 		
		
		
		
		//**********************************************


		// Se define la forma de calcular las horas semanales. 
		// 1.- Tradicional y No-Multititular 
		IF le_forma_imparte = 1 AND ls_multititular = 'N' THEN 
			
			ls_query = " SELECT SUM(hora_final - hora_inicio)  " + & 
							" FROM(  " + &  
										 " SELECT cve_dia = h.cve_dia, hora_inicio = h.hora_inicio, hora_final = h.hora_final, g.fecha_inicio, g.fecha_fin, g.forma_imparte, multititular = ~~'N~~'   " + &   
										" FROM horario h, grupos g   " + &  
											" WHERE h.cve_mat = " + STRING(ll_cve_materia) + " AND h.gpo = ~~'" + ls_gpo + "~~' " + & 
											" AND h.periodo = " + STRING(le_periodo) + & 
											" AND h.anio = " + STRING(le_anio) + & 
											" AND g.cve_profesor = " + STRING(il_cve_profesor) + & 
											" AND g.cve_mat = h.cve_mat   " + &  
											" AND g.gpo = h.gpo  " + &  
											" AND g.periodo = h.periodo  " + &  
											" AND g.anio = h.anio  " + & 
											" AND g.tipo <> 1  " + & 
											" AND NOT EXISTS(  SELECT * FROM horario_profesor_grupo pg   " + &  
																" WHERE pg.cve_profesor = " + STRING(il_cve_profesor) + & 
																" AND pg.cve_mat = h.cve_mat   " + &  
																" AND pg.gpo = h.gpo  " + &  
																" AND pg.periodo = h.periodo  " + &  
																" AND pg.anio = h.anio)  " + & 
								" ) horas_impartidas  " 	 
	
		// 2.- Tradicional y Multititular OR 3.- Modular
		ELSEIF (le_forma_imparte = 1 AND ls_multititular = 'S') OR le_forma_imparte = 2 THEN 
			
			ls_query = " SELECT SUM(hora_final - hora_inicio)  " + & 
							" FROM(  " + &
									" SELECT cve_dia = 1, hora_inicio = 0, hora_final = pc.horas_totales_grupo, g.fecha_inicio, g.fecha_fin, g.forma_imparte, multititular = ~~'S~~'  " + &
										"  FROM profesor_cotitular pc, grupos g   " + & 
										"  WHERE pc.cve_profesor = " + STRING(il_cve_profesor) + & 
											"  AND pc.cve_mat = " + STRING(ll_cve_materia) + " AND pc.gpo = ~~'" + ls_gpo + "~~' " + &  
											" AND pc.periodo = " + STRING(le_periodo) + & 
											"  AND pc.anio = " + STRING(le_anio) + & 
											"  AND g.cve_mat = pc.cve_mat    " + &
											"  AND g.gpo = pc.gpo   " + & 
											"  AND g.periodo = pc.periodo    " + &
											"  AND g.anio = pc.anio   "+ & 
								" ) horas_impartidas  " 	  
			//" SELECT cve_dia = 1, hora_inicio = 0, hora_final = ROUND((pc.horas_totales_grupo/" + STRING(le_semanas_semestre) + ".0), 0), g.fecha_inicio, g.fecha_fin, g.forma_imparte, multititular = ~~'S~~'  " + &					
			
		END IF 	
		
		lds_horas_grupos.DATAOBJECT = "d_horas_otros_grupos"  											  
		lds_horas_grupos.MODIFY("Datawindow.table.Select = '" + ls_query + "'") 
		lds_horas_grupos.SETTRANSOBJECT(itr_sce) 
		ll_ttl = lds_horas_grupos.RETRIEVE() 
		IF ll_ttl > 0 THEN 
			ll_horas_totales_profesor = lds_horas_grupos.GETITEMNUMBER(1,1)
			IF ISNULL(ll_horas_totales_profesor) THEN ll_horas_totales_profesor = 0  
			
				// 1.- Tradicional y No-Multititular 
				IF le_forma_imparte = 1 AND ls_multititular = 'N' THEN 
					ll_horas_tradicional = ll_horas_tradicional +  ll_horas_totales_profesor
				// 2.- Tradicional y Multititular OR 3.- Modular	
				ELSEIF (le_forma_imparte = 1 AND ls_multititular = 'S') OR le_forma_imparte = 2 THEN 	
					
					/***********************************/
					// Se comparan las horas impartidas con las horas totales del grupo en un semestre convencional.
					IF le_horas_grupo_valida = ll_horas_totales_profesor THEN 
						SELECT SUM(horario.hora_final - horario.hora_inicio) 
						INTO :ll_horas_totales_profesor 
						FROM horario 
						WHERE cve_mat = :ll_cve_materia 
						AND gpo = :ls_gpo 
						AND periodo = :le_periodo
						AND anio = :le_anio
						USING itr_sce; 
						IF itr_sce.SQLCODE < 0 THEN 
							MESSAGEBOX("Error", "Se produjko un error al recuperar los otros grupos impartidos por el profesor:" +  itr_sce.SQLERRTEXT) 
							RETURN -1 
						END IF  	
						ll_horas_tradicional = ll_horas_tradicional +  ll_horas_totales_profesor
					ELSE	
						ll_horas_multititular = ll_horas_multititular  + ll_horas_totales_profesor 
					END IF 
					/***********************************/
					//ll_horas_multititular = ll_horas_multititular  + ll_horas_totales_profesor 
					
				END IF 			
			
			//ll_horas_semanales_profesor = ll_horas_semanales_profesor + ll_horas_totales_profesor

		ELSE
			//ll_horas_totales_profesor = 0 
			//ll_horas_semanales_profesor = 0
		END IF 
	
	NEXT 

	// Se calculan las horas MULTIPROFESOR 
	ll_horas_multititular = ROUND(ll_horas_multititular/(le_semanas_semestre * 1.0), 0) 
	// Se suman con las horas tradicional 
	ll_horas_totales_profesor = ll_horas_multititular + ll_horas_tradicional
	
	// Se acumulan las horas TOTALES 
	ll_horas_semanales_profesor = ll_horas_semanales_profesor + ll_horas_totales_profesor	

	/**/
	// Se valida null en horas. 
	IF ISNULL(ll_horas_totales_profesor) THEN ll_horas_totales_profesor = 0 
	
	//ll_horas_totales_profesor = of_cuenta_horas_reales_profesor(il_cve_profesor) 	
	
	
	// Se valida si las horas del grupo actual corresponden con la horas totales de semestre.
	IF ie_horas_per_calculadas = ie_horas_totales_semestre THEN  
		// Se toman las horas que se pasan de la ventana de captura actual en el detalle de horario. 
		ie_horas_semanales_profesor = ie_horas_horario_captura
		
	ELSE	
	
		// Se calculan las horas semanales que se capturan
		ie_horas_semanales_profesor = ROUND((ie_horas_per_calculadas/le_semanas_semestre), 0)
	
	END IF 
	
	// Se acumulan las horas que se capturan
	ll_horas_totales_profesor = ll_horas_semanales_profesor + ie_horas_semanales_profesor		
	
//	IF ie_num_ptrofesores > 1 THEN 
//		// CAMBIO DEL 26/AGOSTO/2020 
//		//ll_horas_totales_profesor = ll_horas_semanales_profesor + ROUND(ie_horas_per_calculadas/(le_semanas_semestre * 1.0), 0) 
//		ll_horas_totales_profesor = ROUND((ll_horas_semanales_profesor + ie_horas_per_calculadas)/(le_semanas_semestre * 1.0), 0) 
//	ELSE
//		ie_horas_semanales_profesor = ROUND((ie_horas_per_calculadas/le_semanas_semestre), 0)
//		ll_horas_totales_profesor = ll_horas_semanales_profesor + ie_horas_semanales_profesor		
//	END IF 	
		
	is_error = "~nEl Profesor Titular rebasa la cantidad de Horas Permitidas"
	is_error =is_error+    "~n Como Titular:"
	
	// Se verifica que las horas no sean mayores a las horas permitidas.
	if ll_horas_totales_profesor > ll_horas_permitidas then
		ls_mensaje =ls_mensaje+     "~nProfesor   :"+ string(il_cve_profesor)
		//ls_mensaje =ls_mensaje+     "~nHoras Grupo Actual   :"+ string(ie_horas_capturadas)	
		ls_mensaje =ls_mensaje+     "~nHoras Grupo Actual   :"+ string(ie_horas_semanales_profesor)	
		ls_mensaje =ls_mensaje+     "~n"
		ls_mensaje =ls_mensaje+     "~nHoras Permitidas     :"+string(ll_horas_permitidas)
		ls_mensaje =ls_mensaje+     "~nHoras Totales           :"+string(ll_horas_totales_profesor)
		MessageBox("Profesor con Horas de mas", ls_mensaje,StopSign!)	
		return -1
		//ls_mensaje =ls_mensaje+     "~nHoras Permitidas     :"+string(ll_horas_gpo_normal)
	end if
		
end if
	

RETURN 0 






////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////

//
//// Función de validación de horas permitidas a un profesor.
//LONG ll_horas_gpo_normal
//DECIMAL ld_factor_ajuste_horas
//INTEGER le_horas_adic_x_una_mat
//INTEGER le_semanas_semestre
//STRING ls_mensaje 
//LONG ll_horas_permitidas
//LONG ll_horas_totales_profesor
//
//
//INTEGER li_cve_categoria 
//datastore lds_data //, lds_data2
//LONG ll_num_reg
//LONG ll_suma_horas, ll_row_horas_coord, ll_horas_reales
//STRING ls_coordinacion 
//LONG ll_suma_horas_mas_actual
//
//li_cve_categoria = f_obten_categoria_profesor(il_cve_profesor)
//if li_cve_categoria= -1 then
//	MessageBox("Error en consulta de categoria", "No es posible consultar la categoria del profesor capturado",StopSign!)			
//end if
//
//// Revision para grupos no asimilados 	ae_tipo <> 2
////claves de profesor validas 				ll_cve_profesor > 8
////en profesores de asignatura 			li_cve_categoria = 4 
//if ae_tipo <> 2 and il_cve_profesor > 8 and  li_cve_categoria = 4 then 
//	
//	lds_data = CREATE datastore
//	lds_data.DataObject = 'd_horas_profesor_coord_bloque'
//	lds_data.SetTransObject(itr_sce)
//	ll_num_reg = lds_data.Retrieve(il_cve_profesor,al_cve_materia, as_gpo, ie_periodo, ie_anio)
//	ll_suma_horas= 0
//	
//	if ll_num_reg>0 then
//		
//		is_error = "~nEl Profesor Titular rebasa la cantidad de Horas Permitidas"
//		is_error =is_error+    "~n Como Titular:"
//		
//		for ll_row_horas_coord=1 to ll_num_reg
//			//ls_coordinacion= lds_data.GetItemString(ll_row_horas_coord,"coordinaciones_coordinacion")
//			ll_horas_reales= lds_data.GetItemNumber(ll_row_horas_coord,"horas_tot")
//			// Si es verano, las horas deben ser por 2.5
//			//			if li_periodo= 1 then
//			//				ll_horas_reales = ll_horas_reales * 2.5	
//			//			end if
//			//ll_horas_reales = ll_horas_reales * ld_factor_ajuste_horas
////			is_error =is_error+     "~nCoordinación  ["+string(ll_row_horas_coord)+"]        :"+ ls_coordinacion
////			is_error =is_error+     "~nHoras Coord.  ["+string(ll_row_horas_coord)+"]        :"+ string(ll_horas_reales)
//			ll_suma_horas= ll_suma_horas + ll_horas_reales	 
//		next
//		
//	end if
//	
////	// Si solo tiene una materia, suma las posibles horas adicionales
////	IF le_numero_grupos_dif = 0 THEN 
////		ll_horas_gpo_normal = ll_horas_gpo_normal + le_horas_adic_x_una_mat 
////		
////	END IF
//	
//	//ll_horas_gpo_normal = (ll_horas_gpo_normal * le_semanas_semestre)
//	
//	if ll_suma_horas_mas_actual>ll_horas_gpo_normal then
//		ls_mensaje =ls_mensaje+     "~nHoras Grupo Actual   :"+ string(ie_horas_capturadas)	
//		ls_mensaje =ls_mensaje+     "~n"
//		ls_mensaje =ls_mensaje+     "~nHoras Permitidas     :"+string(ll_horas_gpo_normal)
//		ls_mensaje =ls_mensaje+     "~nHoras Totales           :"+string(ll_suma_horas_mas_actual)
//		MessageBox("Profesor con Horas de mas", &		
//	            ls_mensaje,StopSign!)	
//		return -1
//	end if
//
//
//
//	DESTROY lds_data
////	DESTROY lds_data2
//	
//end if
//
//
//
//
//
//// Se recupera el factor de ajuste por periodo. 
//SELECT horas_normales, factor_ajuste_horas, horas_adic_x_una_mat, semanas_semestre
//INTO :ll_horas_gpo_normal, :ld_factor_ajuste_horas, :le_horas_adic_x_una_mat, :le_semanas_semestre
//FROM periodo_parametros
//WHERE periodo = :ie_periodo
//USING  gtr_sce;
//IF gtr_sce.SQLCODE < 0 THEN 
//	MESSAGEBOX("Error", "Se produjo un error al recuparar las horas permitidas para el periodo actual: " + gtr_sce.SQLERRTEXT)
//	RETURN -1
//END IF
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Se verifica si el profesor solo tiene un grupo.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//INTEGER le_numero_grupos_dif
//
//SELECT COUNT(*) 
//INTO :le_numero_grupos_dif 
//FROM grupos g 
//WHERE g.cve_profesor = :il_cve_profesor 
//AND	g.tipo not in (1, 2)
//AND   g.periodo = :ie_periodo
//AND   g.anio = :ie_anio 
//AND NOT (g.cve_mat = :al_cve_materia AND g.gpo = :as_gpo) 
//AND	g.cond_gpo = 1 
//USING gtr_sce; 
//IF gtr_sce.SQLCODE < 0 THEN 
//	MESSAGEBOX("Error", "Se produjo un error al recuperar otros grupos del profesor:" + gtr_sce.SQLERRTEXT)
//	RETURN -1 
//END IF
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//// Se calcula el número de horas máximo del profesor. 
//IF le_numero_grupos_dif = 0 THEN 
//	ll_horas_permitidas = (ll_horas_gpo_normal + le_horas_adic_x_una_mat) * le_semanas_semestre 
//ELSEIF le_numero_grupos_dif > 0 THEN  
//	ll_horas_permitidas = ll_horas_gpo_normal * le_semanas_semestre 
//END IF	
//
//
////ll_horas_gpo_normal = ie_horas_reales_tot_sem
//
//ll_horas_totales_profesor = of_cuenta_horas_reales_profesor(il_cve_profesor) 
//
//
//RETURN 0 
//
//
//


//	// Se valida si el profesor da clases en grupos tradicionales o SOLO en modulares. 
//	INTEGER le_grupos1, le_grupos2
//	
//	SELECT COUNT(*) 
//	INTO :le_grupos1
//	FROM grupos g
//	WHERE cve_profesor = :il_cve_profesor
//	AND g.forma_imparte = 1 
//	AND g.periodo = :ie_periodo
//	AND g.anio = :ie_anio
//	AND NOT(g.cve_mat = :al_cve_materia AND g.gpo = :as_gpo)
//	USING itr_sce;
//	
//	SELECT COUNT(*) 
//	INTO :le_grupos2
//	FROM profesor_cotitular pc 
//	WHERE pc.cve_profesor = :il_cve_profesor
//	AND EXISTS ( SELECT * FROM grupos g 
//	WHERE g.cve_mat = pc.cve_mat 
//	AND g.gpo = pc.gpo 
//	AND g.periodo = pc.periodo 
//	AND g.anio = pc.anio
//	AND g.forma_imparte = 1	
//	AND g.periodo = :ie_periodo
//	AND g.anio = :ie_anio	
//	AND NOT(g.cve_mat = :al_cve_materia AND g.gpo = :as_gpo) )
//	USING itr_sce;	


//		ls_query = " SELECT SUM(hora_final - hora_inicio) " + & 
//						" FROM( " + & 
//						" SELECT cve_dia = h.cve_dia, hora_inicio = h.hora_inicio, hora_final = h.hora_final FROM horario h " + &  
//						" WHERE NOT(h.cve_mat = " + STRING(al_cve_materia) + " AND h.gpo = ~~'" + as_gpo + "~~') " + & 
//						" AND h.periodo = " + STRING(ie_periodo) + & 
//						" AND h.anio = " + STRING(ie_anio) + & 
//						" AND EXISTS( " + & 
//											" SELECT * FROM grupos g " + &  
//											" WHERE g.cve_profesor = " + STRING(il_cve_profesor) + & 
//											" AND g.cve_mat = h.cve_mat  " + & 
//											" AND g.gpo = h.gpo " + & 
//											" AND g.periodo = h.periodo " + & 
//											" AND g.anio = h.anio AND g.tipo <> 1 AND g.forma_imparte = 1)  " + & 
//						" AND NOT EXISTS( " + & 
//											" SELECT * FROM horario_profesor_grupo pg  " + & 
//											" WHERE pg.cve_profesor = " + STRING(il_cve_profesor) + & 
//											" AND pg.cve_mat = h.cve_mat  " + & 
//											" AND pg.gpo = h.gpo " + & 
//											" AND pg.periodo = h.periodo " + & 
//											" AND pg.anio = h.anio)  " + & 
//						" UNION  " + & 
//						" SELECT cve_dia = pg.cve_dia, hora_inicio = pg.hora_inicio, hora_final = pg.hora_final " + & 
//						" FROM horario_profesor_grupo pg, grupos g  " + & 
//						" WHERE pg.cve_profesor = " + STRING(il_cve_profesor) + & 
//						" AND NOT(pg.cve_mat = " + STRING(al_cve_materia) + " AND pg.gpo = ~~'" + as_gpo + "~~')  " + & 
//						" AND pg.periodo = " + STRING(ie_periodo) + & 
//						" AND pg.anio = " + STRING(ie_anio) + &  
//						" AND g.cve_mat = pg.cve_mat " + & 
//						" AND g.gpo = pg.gpo " + & 
//						" AND g.periodo = pg.periodo " + & 
//						" AND g.anio = pg.anio  AND g.forma_imparte = 1 "  + & 
//						" UNION " + & 
//						"  SELECT cve_dia = 1, hora_inicio = 0, hora_final = (pc.horas_totales_grupo/" + STRING(le_semanas_semestre) + ") " + & 
//						" FROM profesor_cotitular pc, grupos g " + &    
//						" WHERE pc.cve_profesor = " + STRING(il_cve_profesor) + & 
//						" AND NOT(pc.cve_mat = " + STRING(al_cve_materia) + " AND pc.gpo = ~~'" + as_gpo + "~~')  " + &   
//						" AND pc.periodo = " + STRING(ie_periodo) + & 
//						" AND pc.anio = " + STRING(ie_anio) + &  
//						" AND g.cve_mat = pc.cve_mat " + &   
//						" AND g.gpo = pc.gpo " + &   
//						" AND g.periodo = pc.periodo " + &  
//						" AND g.anio = pc.anio AND g.forma_imparte = 2 " + & 						
//						" ) horas_impartidas 	 " 	
//

//	// Si el profesor imparte en grupos tradicionales, se toman las horas previamente impartidas como tradicionales 
//	IF le_grupos1 > 0 OR le_grupos2 > 0 THEN 

						
//		DATASTORE lds_horas_grupos
//		lds_horas_grupos = CREATE DATASTORE 
//		lds_horas_grupos.DATAOBJECT = "d_horas_otros_grupos"  
//		lds_horas_grupos.MODIFY("Datawindow.Table.Select = '" + ls_query + "'" ) 
//		lds_horas_grupos.SETTRANSOBJECT(itr_sce) 
//		ll_ttl = lds_horas_grupos.RETRIEVE() 
//		IF ll_ttl > 0 THEN 
//			ll_horas_totales_profesor = lds_horas_grupos.GETITEMNUMBER(1,1)
//			IF ISNULL(ll_horas_totales_profesor) THEN ll_horas_totales_profesor = 0  
//			ll_horas_semanales_profesor = ll_horas_totales_profesor
//			ll_horas_totales_profesor = ll_horas_totales_profesor * le_semanas_semestre
//		ELSE
//			ll_horas_totales_profesor = 0 
//			ll_horas_semanales_profesor = 0
//		END IF 
//	
//		ie_horas_capturadas = ie_horas_semanales * le_semanas_semestre
//		ie_horas_semanales_profesor = ie_horas_semanales 
	
//	// Si solo imparte horas modulares, se toman las horas del detalle de profesor cotitular
//	ELSE	
//		
//		// Se calculan las oras asignadas a otros grupos
//		SELECT SUM(pc.horas_totales_grupo) 
//		INTO :ll_horas_totales_profesor 
//		FROM grupos g, profesor_cotitular pc  
//		WHERE pc.cve_profesor = :il_cve_profesor 
//		AND	g.tipo not in (1, 2)
//		AND   g.periodo = :ie_periodo 
//		AND   g.anio = :ie_anio 
//		AND NOT (g.cve_mat = :al_cve_materia AND g.gpo = :as_gpo)  
//		AND g.cve_mat = pc.cve_mat
//		AND g.gpo = pc.gpo 
//		AND g.periodo = pc.periodo
//		AND g.anio = pc.anio 
//		AND	g.cond_gpo = 1 
//		USING itr_sce; 	
//		IF itr_sce.SQLCODE < 0 THEN 
//			MESSAGEBOX("Error", "Se produjo un error al recuperar otros grupos del profesor:" + itr_sce.SQLERRTEXT)
//			RETURN -1 
//		END IF			
//		
//	END IF




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

public function long wf_recupera_coordinacion (string as_materia_gpo);

as_materia_gpo = TRIM(as_materia_gpo) 
IF ISNULL(as_materia_gpo) OR TRIM(as_materia_gpo) = "" THEN RETURN 0 

STRING ls_cve_mat
STRING ls_gpo 
LONG ll_pos 
LONG ll_coordinacion

ls_cve_mat = LEFT(as_materia_gpo, (POS(as_materia_gpo, "-") - 1) )
ls_gpo = RIGHT(as_materia_gpo, LEN(as_materia_gpo) - POS(as_materia_gpo, "-")) 

ll_pos = ids_horario_profesor.FIND("grupos_cve_mat = " + ls_cve_mat + " AND grupos_gpo = '" + ls_gpo + "'", 1,  ids_horario_profesor.ROWCOUNT()) 
IF ll_pos < 0 THEN ll_pos = 0 

IF ll_pos > 0 THEN 
	ll_coordinacion = ids_horario_profesor.GETITEMNUMBER(ll_pos, "materias_cve_coordinacion") 
ELSE	
	ll_coordinacion = 0 
END IF 

RETURN ll_coordinacion


//ll_cve_mat = ids_horario_profesor.GETITEMNUMBER(le_pos, "grupos_cve_mat") 
//ls_gpo = ids_horario_profesor.GETITEMSTRING(le_pos, "grupos_gpo")	  
//ldt_fecha_inicio = DATE(ids_horario_profesor.GETITEMDATETIME(le_pos, "grupos_fecha_inicio"))
//ldt_fecha_fin = DATE(ids_horario_profesor.GETITEMDATETIME(le_pos, "grupos_fecha_fin"))
//le_cve_dia = ids_horario_profesor.GETITEMNUMBER(le_pos, "horario_profesor_grupo_cve_dia")  
//le_hora_inicio = ids_horario_profesor.GETITEMNUMBER(le_pos, "horario_profesor_grupo_hora_inicio")  
//le_hora_fin = ids_horario_profesor.GETITEMNUMBER(le_pos, "horario_profesor_grupo_hora_final")   
//ll_coordinacion = ids_horario_profesor.GETITEMNUMBER(le_pos, "materias_cve_coordinacion")   
end function

public function integer of_cuenta_horas_reales_profesor (long al_cve_profesor, integer as_horas_reales_materia);// Función que cuenta las horas reales de un profesor en un grupo. 
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

ids_verifica_horario_paso.SETFILTER("grupos_cve_profesor = " + STRING(al_cve_profesor)) 
ids_verifica_horario_paso.FILTER()  

le_ttl_rgs = ids_verifica_horario_paso.ROWCOUNT() 

of_carga_dias_no_laborables() 

FOR le_pos = 1 TO le_ttl_rgs 
 	
//	ld_fecha_inicio = DATE(ids_verifica_horario_paso.GETITEMDATETIME(le_pos, "grupos_fecha_inicio"))  
//	ld_fecha_fin =  DATE(ids_verifica_horario_paso.GETITEMDATETIME(le_pos, "grupos_fecha_fin"))  
	ld_fecha_inicio = DATE(ids_verifica_horario_paso.GETITEMDATETIME(le_pos, "horario_profesor_grupo_fecha_inicio"))  
	ld_fecha_fin =  DATE(ids_verifica_horario_paso.GETITEMDATETIME(le_pos, "horario_profesor_grupo_fecha_fin"))  

	le_dia = ids_verifica_horario_paso.GETITEMNUMBER(le_pos, "horario_profesor_grupo_cve_dia")  
	le_hora_inicio = ids_verifica_horario_paso.GETITEMNUMBER(le_pos, "horario_profesor_grupo_hora_inicio")  
	le_hora_fin =  ids_verifica_horario_paso.GETITEMNUMBER(le_pos, "horario_profesor_grupo_hora_final")  
	
	ld_fecha_evalua = ld_fecha_inicio 
	le_horas_dia = le_hora_fin - le_hora_inicio 
	
	DO WHILE ld_fecha_evalua <= ld_fecha_fin 
		
		IF (DAYNUMBER(ld_fecha_evalua) - 1) = le_dia THEN 
		
			// Se verifica si el día es laborable 
			//le_dia_no_laborable = ids_dias_no_laborables.FIND("fecha = " + STRING(DATETIME(ld_fecha_evalua)), 1, ids_dias_no_laborables.ROWCOUNT() + 1)  
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

//le_horas_maximas = ie_semanas_semestre * as_horas_reales_materia 
//
//IF le_horas_maximas  < le_horas_totales THEN le_horas_totales = le_horas_maximas 

RETURN  le_horas_totales







end function

on uo_profesor_servicios.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_profesor_servicios.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

