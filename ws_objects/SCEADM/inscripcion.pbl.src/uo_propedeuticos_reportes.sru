$PBExportHeader$uo_propedeuticos_reportes.sru
forward
global type uo_propedeuticos_reportes from nonvisualobject
end type
end forward

global type uo_propedeuticos_reportes from nonvisualobject
end type
global uo_propedeuticos_reportes uo_propedeuticos_reportes

type variables

DATASTORE ids_prop_carrera_minimos 
DATASTORE ids_prop_carrera_peso 

DATASTORE ids_puntajes_para_prop 
DATASTORE ids_puntajes_para_prop_tot 


end variables

forward prototypes
public function string of_genera_sql (integer ae_periodo, integer ae_anio, string as_propedeutico)
public function integer of_carga_configuracion ()
public function string of_generaquery_sqp (integer ae_periodo, integer ae_anio, string as_id_prop)
end prototypes

public function string of_genera_sql (integer ae_periodo, integer ae_anio, string as_propedeutico);STRING ls_query 
STRING ls_filtro, ls_filtro2

INTEGER le_pos, le_pos2, le_pos3 
INTEGER le_ttl_curso, le_ttl_curso2
LONG ll_cve_carrera, ll_carreras[], ll_lmp[]
LONG ll_cve_carrera_ant


STRING ls_id_prop, ls_busqueda
DECIMAL ld_numero_aciertos
DECIMAL ld_aciertos_totales

STRING ls_carreras, ls_nombre_col_area, ls_cadena_areas
INTEGER le_id_area, le_cont_carreras, le_id_area_ant 
INTEGER le_rowins 
STRING ls_carrera_ant 
INTEGER le_pos_cadenas , le_cadenas_ins
STRING ls_carreras_act, ls_areas_act 


DATASTORE lds_areas_por_carrera
lds_areas_por_carrera = CREATE DATASTORE 
lds_areas_por_carrera.DATAOBJECT = "dw_prop_carrera_peso_rep" 

DATASTORE lds_cadenas_carrera_areas
lds_cadenas_carrera_areas = CREATE DATASTORE 
lds_cadenas_carrera_areas.DATAOBJECT = "dw_cadenas_carrera_areas" 


// Se filtran las diferentes combinaciones de puntos. 
ls_filtro = "id_prop = '" + as_propedeutico + "'" 
		
ids_puntajes_para_prop.SETFILTER(ls_filtro)  
ids_puntajes_para_prop.FILTER() 
le_ttl_curso =  ids_puntajes_para_prop.ROWCOUNT() 

// Se hace un ciclo por cada combinación de puntos. 
FOR le_pos = 1 TO  le_ttl_curso 

	ls_id_prop = ids_puntajes_para_prop.GETITEMSTRING(le_pos, "id_prop")  
	ld_numero_aciertos = ids_puntajes_para_prop.GETITEMDECIMAL(le_pos, "numero_aciertos")  
	ld_aciertos_totales = ids_puntajes_para_prop.GETITEMDECIMAL(le_pos, "aciertos_totales")  
	
	// Se filtran las carreras con esta combinación de puntos mínimos 
	ls_filtro2 = "id_prop = '" + ls_id_prop + "' AND numero_aciertos = " +  STRING(ld_numero_aciertos) + " AND aciertos_totales = " + STRING(ld_aciertos_totales)  
	
	ids_puntajes_para_prop_tot.SETFILTER(ls_filtro2)  
	ids_puntajes_para_prop_tot.FILTER() 
	le_ttl_curso2 = ids_puntajes_para_prop_tot.ROWCOUNT()  
	
	ls_carreras = "" 
	le_cont_carreras = 0
	ll_carreras = ll_lmp 
	// Se recuperan las carreras que tienen esta combinación de puntos 
	FOR le_pos2 = 1 TO le_ttl_curso2 
	
		ll_cve_carrera = ids_puntajes_para_prop_tot.GETITEMNUMBER(le_pos2, "cve_carrera")  
		IF ISNULL(ll_cve_carrera) THEN ll_cve_carrera = 0 
		IF ll_cve_carrera = 0 THEN CONTINUE 
		IF ll_cve_carrera = 5201 THEN 
			ll_cve_carrera = ll_cve_carrera
		END IF
		
		le_cont_carreras = le_cont_carreras + 1
		ll_carreras[le_cont_carreras] = ll_cve_carrera
		
		IF TRIM(ls_carreras) = "" THEN 
			ls_carreras = STRING(ll_cve_carrera) 
		ELSE
			ls_carreras = ls_carreras + ", " + STRING(ll_cve_carrera) 
		END IF
	
	NEXT 
	
	lds_areas_por_carrera.SETTRANSOBJECT(gtr_sadm)
	lds_areas_por_carrera.RETRIEVE(as_propedeutico, ll_carreras) 

	// Se hace ciclo para generar cada uno de los fragmentos de cadena
	FOR le_pos3 = 1 TO lds_areas_por_carrera.ROWCOUNT() 
	
		le_id_area = lds_areas_por_carrera.GETITEMNUMBER(le_pos3, "id_area")  
		ll_cve_carrera = lds_areas_por_carrera.GETITEMNUMBER(le_pos3, "cve_carrera")  
		IF le_pos3 = 1 THEN 
			ll_cve_carrera_ant = ll_cve_carrera
			le_id_area_ant = le_id_area
		END IF 
		
		IF ll_cve_carrera = 5201 THEN 
			ll_cve_carrera = ll_cve_carrera
		END IF		
		
		
		CHOOSE CASE le_id_area
			CASE 1
				ls_nombre_col_area = "espaniol_primaria"
			CASE 2
				ls_nombre_col_area = "matematicas_primaria" 
			CASE 3
				ls_nombre_col_area = "espaniol_secundaria" 
			CASE 4
				ls_nombre_col_area = "matematicas_secundaria" 
			CASE 5
				ls_nombre_col_area = "cs_naturales_secundaria" 
			CASE 6
				ls_nombre_col_area = "cs_sociales_secundaria" 
			CASE 7
				ls_nombre_col_area = "asignatura_1" 
			CASE 8
				ls_nombre_col_area = "asignatura_2" 
			CASE 9
				ls_nombre_col_area = "asignatura_3"
		 END CHOOSE
 
		// Se verifica si hay un cambio de carrera 
		IF ll_cve_carrera_ant = ll_cve_carrera THEN   
			
			IF TRIM(ls_cadena_areas) = "" THEN 
				 ls_cadena_areas = ls_nombre_col_area  
			ELSE
				IF le_id_area_ant <> le_id_area THEN 
					ls_cadena_areas = ls_cadena_areas + " + " + ls_nombre_col_area 
				END IF 
			END IF								
			
		END IF
		IF  ll_cve_carrera_ant <> ll_cve_carrera OR  le_pos3 = lds_areas_por_carrera.ROWCOUNT()  THEN 
			
			// Se busca la cadena de áreas al momento para ver si ya se ha agrupado. 
			ls_busqueda = "areas = '" + ls_cadena_areas + "' AND  aciertos = " + STRING(ld_numero_aciertos) + " AND total_aciertos = " + STRING(ld_aciertos_totales) 
			le_pos_cadenas = lds_cadenas_carrera_areas.FIND(ls_busqueda, 0, lds_cadenas_carrera_areas.ROWCOUNT())    
			IF le_pos_cadenas > 0 THEN 
				
				ls_carreras_act = lds_cadenas_carrera_areas.GETITEMSTRING(le_pos_cadenas, "carreras")
				ls_areas_act = lds_cadenas_carrera_areas.GETITEMSTRING(le_pos_cadenas, "areas")
				
				IF ISNULL(ls_carreras_act) THEN ls_carreras_act = "" 
				IF TRIM(ls_carreras_act) <> "" THEN ls_carreras_act = ls_carreras_act + "," + STRING(ll_cve_carrera_ant) 
				IF  le_pos3 = lds_areas_por_carrera.ROWCOUNT()  THEN ls_carreras_act = ls_carreras_act + "," + STRING(ll_cve_carrera)  
				
				// Se inserta la cedena de carreras
				lds_cadenas_carrera_areas.SETITEM(le_pos_cadenas, "carreras", ls_carreras_act) 
				
			ELSE
				
				le_cadenas_ins = lds_cadenas_carrera_areas.INSERTROW(0)
			
				// Se inserta la cedena de carreras
				lds_cadenas_carrera_areas.SETITEM(le_cadenas_ins, "carreras", STRING(ll_cve_carrera_ant))	
				lds_cadenas_carrera_areas.SETITEM(le_cadenas_ins, "areas", ls_cadena_areas)	
				lds_cadenas_carrera_areas.SETITEM(le_cadenas_ins, "aciertos", ld_numero_aciertos)	
				lds_cadenas_carrera_areas.SETITEM(le_cadenas_ins, "total_aciertos", ld_aciertos_totales)	
				
			END IF 
			
			// Se pasa la nueva carrera a la variable de comparación. 
			ll_cve_carrera_ant = ll_cve_carrera 
			
			// Se asigna el área actiual de la nueva carrera. 
			ls_cadena_areas = ls_nombre_col_area 
			
			
		END IF 
	
	NEXT
	ls_carreras_act =  "" 
	ls_cadena_areas = ""
	
 
NEXT




STRING ls_carreras_qry
STRING ls_areas_qry 
DECIMAL ld_aciertos_qry	
DECIMAL ld_total_aciertos_qry 
STRING ls_querytmp
STRING ls_cursa, ls_cursos, ls_union  


CHOOSE CASE as_propedeutico 
	CASE 'M' 
		ls_cursa = 'MATEMÁTICAS' 
		ls_cursos = "90210/90211" 
	CASE 'E' 
		ls_cursa = 'ESPAÑOL'
		ls_cursos = "90212" 
END CHOOSE 






FOR le_pos = 1 TO  lds_cadenas_carrera_areas.ROWCOUNT() 

	ls_carreras_qry = lds_cadenas_carrera_areas.GETITEMSTRING(le_pos, "carreras") 
	ls_areas_qry = lds_cadenas_carrera_areas.GETITEMSTRING(le_pos, "areas")  
	ld_aciertos_qry = lds_cadenas_carrera_areas.GETITEMDECIMAL(le_pos, "aciertos") 	
	ld_total_aciertos_qry = lds_cadenas_carrera_areas.GETITEMDECIMAL(le_pos, "total_aciertos")  


	ls_querytmp = 	" SELECT g.folio, g.cuenta, d.digito, (" + ls_areas_qry + ") AS puntos_totales, ~~'" + ls_cursa + "~~' AS cursa, ~~'" +  ls_cursos + "~~' AS clave_propedeutico  "  + & 
						", ~~'" +   ls_areas_qry + " <= " + STRING(ld_aciertos_qry) + "~~' " + &  
						", convert(VARCHAR,cve_carrera) + ~~'-~~' + carrera as carrera " + & 
						", a.clv_ver, a.clv_per, a.anio, a.ing_per, a.ing_anio " + & 
						" FROM resultado_examen_excoba_2017 re, aspiran a, general g, controlescolar_bd.dbo.v_sce_alumno_digito d " + & 
						" WHERE re.folio = a.folio  " + & 
						" AND a.ing_per =  " + STRING(ae_periodo)  +  & 
						" AND a.ing_anio = " + STRING(ae_anio) + & 
						" AND a.pago_insc = 1  " + & 
						" AND a.pago_exam = 1  " + & 
						" AND a.clv_carr IN(" + ls_carreras_qry + " )" + & 
						" AND a.folio = g.folio  " + & 
						" AND a.clv_ver = g.clv_ver  " + & 
						" AND a.clv_per = g.clv_per  " + & 
						" AND a.anio = g.anio  " + & 
						" AND g.cuenta = d.cuenta " + &  
						" AND a.status not in (0,3) " + & 
						" AND (" + ls_areas_qry + ")" + " <=  + " + STRING(ld_aciertos_qry) 

	ls_query = ls_query + ls_union + ls_querytmp 
	
	ls_union = " UNION " 
	
NEXT 
 
 
 
RETURN ls_query 






 
 
 
 
 
 
end function

public function integer of_carga_configuracion ();INTEGER le_total_registros

// DIFERENTES PUNTAJES POR PROPEDEUTICO 
ids_puntajes_para_prop = CREATE DATASTORE 
ids_puntajes_para_prop.DATAOBJECT = "dw_puntajes_para_prop"  
ids_puntajes_para_prop.SETTRANSOBJECT(gtr_sadm)  
le_total_registros = ids_puntajes_para_prop.RETRIEVE() 

// PUNTAJES PARA PROPEDEUTICO POR CARRERA
ids_puntajes_para_prop_tot = CREATE DATASTORE  
ids_puntajes_para_prop_tot.DATAOBJECT = "dw_puntajes_para_prop_comp"   
ids_puntajes_para_prop_tot.SETTRANSOBJECT(gtr_sadm)    
le_total_registros = ids_puntajes_para_prop_tot.RETRIEVE() 



RETURN 0 




end function

public function string of_generaquery_sqp (integer ae_periodo, integer ae_anio, string as_id_prop);
STRING ls_query , ls_cursos
INTEGER le_periodo, le_anio 
LONG le_rows, le_pos, ll_cuenta  
STRING ls_cuentas, ls_coma

if (conecta_bd_n_tr(gtr_sfeb,gs_sfeb,gs_usuario,gs_password) <> 1) then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de becas.", StopSign!)
	return ""
end if

// Se recuperan los alumnos y se separan por tipo para determinar los posibles propedeúticos que cursarán 
DATASTORE lds_prop_aspirante_tipo 
lds_prop_aspirante_tipo = CREATE DATASTORE 
lds_prop_aspirante_tipo.DATAOBJECT = "d_prop_v_sfeb_sqp_cuentas" 
lds_prop_aspirante_tipo.SETTRANSOBJECT(gtr_sfeb) 
le_rows = lds_prop_aspirante_tipo.RETRIEVE() 

FOR le_pos = 1 TO le_rows 
	
	ll_cuenta = lds_prop_aspirante_tipo.GETITEMNUMBER(le_pos, "cuenta")  
	
	ls_cuentas = ls_cuentas + ls_coma + STRING(ll_cuenta) 
	
	ls_coma = ","
	
NEXT 

ls_cursos = "90209" 

ls_query = " SELECT g.folio, g.cuenta, d.digito, ~~'QUIMICA~~'  AS cursa, ~~'" + ls_cursos + "~~' AS clave_propedeutico, "  + & 
						" convert(VARCHAR,cve_carrera) + ~~'-~~' + carrera as carrera " + & 
						", a.clv_ver, a.clv_per, a.anio, a.ing_per, a.ing_anio " + & 
						" FROM aspiran a, general g, controlescolar_bd.dbo.v_sce_alumno_digito d, v_carreras " + & 
						" WHERE a.ing_per =  " + STRING(ae_periodo)  +  & 
						" AND a.ing_anio = " + STRING(ae_anio) + & 
						" AND a.pago_insc = 1  " + & 
						" AND a.pago_exam = 1  " + & 
						" AND a.folio = g.folio  " + & 
						" AND a.clv_ver = g.clv_ver  " + & 
						" AND a.clv_per = g.clv_per  " + & 
						" AND a.anio = g.anio  " + & 
						" AND g.cuenta = d.cuenta " + & 
						" AND cve_carrera IN( " + & 
						" SELECT pe.cve_carrera FROM controlescolar_bd.dbo.prerrequisitos_esp pe  " + & 
						" WHERE pe.cve_prerreq IN(SELECT cve_materia FROM prop_rel_materia WHERE id_prop = ~~'" + as_id_prop + "~~') )  " + & 						
						" AND a.clv_carr = v_carreras.cve_carrera " + & 
						" AND g.cuenta in(" + ls_cuentas + ")" 
					
					
					
					
DISCONNECT USING gtr_sfeb; 
						
RETURN ls_query			
						
						
						
						
						
end function

on uo_propedeuticos_reportes.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_propedeuticos_reportes.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

