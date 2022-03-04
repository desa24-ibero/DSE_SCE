$PBExportHeader$w_asigna_automatica_salon.srw
forward
global type w_asigna_automatica_salon from window
end type
type cbx_asignacion_especial from checkbox within w_asigna_automatica_salon
end type
type st_2 from statictext within w_asigna_automatica_salon
end type
type st_1 from statictext within w_asigna_automatica_salon
end type
type cbx_actualiza_clase_aula from checkbox within w_asigna_automatica_salon
end type
type st_asignacion from statictext within w_asigna_automatica_salon
end type
type st_precarga from statictext within w_asigna_automatica_salon
end type
type cb_preproceso from commandbutton within w_asigna_automatica_salon
end type
type cb_imprime from commandbutton within w_asigna_automatica_salon
end type
type dw_external_reporte from datawindow within w_asigna_automatica_salon
end type
type cb_empieza from commandbutton within w_asigna_automatica_salon
end type
type st_pasos from statictext within w_asigna_automatica_salon
end type
type st_informacion from statictext within w_asigna_automatica_salon
end type
type oval_1 from oval within w_asigna_automatica_salon
end type
type st_inf_criterio from statictext within w_asigna_automatica_salon
end type
type st_inf_categorias from statictext within w_asigna_automatica_salon
end type
type st_porcentaje from statictext within w_asigna_automatica_salon
end type
type rb_inscritos from radiobutton within w_asigna_automatica_salon
end type
type rb_cupo from radiobutton within w_asigna_automatica_salon
end type
type uo_1 from uo_per_ani within w_asigna_automatica_salon
end type
type gb_criterio from groupbox within w_asigna_automatica_salon
end type
type ln_1 from line within w_asigna_automatica_salon
end type
type oval_2 from oval within w_asigna_automatica_salon
end type
end forward

global type w_asigna_automatica_salon from window
integer x = 846
integer y = 372
integer width = 4686
integer height = 2152
boolean titlebar = true
string title = "Asignación Automática de Salones"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
long backcolor = 79741120
cbx_asignacion_especial cbx_asignacion_especial
st_2 st_2
st_1 st_1
cbx_actualiza_clase_aula cbx_actualiza_clase_aula
st_asignacion st_asignacion
st_precarga st_precarga
cb_preproceso cb_preproceso
cb_imprime cb_imprime
dw_external_reporte dw_external_reporte
cb_empieza cb_empieza
st_pasos st_pasos
st_informacion st_informacion
oval_1 oval_1
st_inf_criterio st_inf_criterio
st_inf_categorias st_inf_categorias
st_porcentaje st_porcentaje
rb_inscritos rb_inscritos
rb_cupo rb_cupo
uo_1 uo_1
gb_criterio gb_criterio
ln_1 ln_1
oval_2 oval_2
end type
global w_asigna_automatica_salon w_asigna_automatica_salon

type variables

// Objeto de servicio de niveles.
uo_nivel_servicios iuo_nivel_servicios

uo_salones_servicios iuo_salones_servicios 

INTEGER ii_periodo, ii_anio 





end variables

forward prototypes
public function integer wf_asignacion_especial ()
public function integer wf_asignacion_especial2 ()
end prototypes

public function integer wf_asignacion_especial ();
// ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL 
// ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL 

// Comienza proceso de asignación.
datastore lds_asigna_automatica_salon,lds_salones_existentes
LONG li_crit, li_cat, li_niv, li_tot, li_totparc, li_critcupoinsc, li_tothor, li_asigparc
LONG li_ret, li_res, li_i, li_j, li_totasig, li_total_niveles, li_ttl_bloques
INTEGER li_limiteinf[5], li_limitesup[5], li_cupoinsc[5]
string ls_enbasea, ls_nivel, ls_nivel2 

STRING ls_orden, ls_filtro 
STRING ls_filtro_nivel, ls_filtro_nivel_completo 

STRING ls_sql 

INTEGER le_bloque, le_bloque_max, le_vuelta   


// Se inicializan los DS de asignación especial.
//iuo_salones_servicios.of_carga_asignacion_especial() 


st_asignacion.TEXT = "Inicio: " + STRING(NOW()) 

ls_sql = " SELECT	horario.cve_mat, horario.gpo, horario.anio,horario.periodo,  horario.cve_dia,   horario.cve_salon,   horario.hora_inicio,  " + & 
				" horario.hora_final, grupos.cupo, grupos.inscritos, materias.nivel, materias.materia, dias.dia, grupos.forma_imparte,   " + & 
				" grupos.fecha_inicio, grupos.fecha_fin   " + & 
				" FROM grupos, horario, materias, dias  " + & 
				" WHERE ( grupos.cve_mat = horario.cve_mat )  " + & 
				" and    	  ( grupos.gpo = horario.gpo )  " + & 
				" and    	  ( grupos.periodo = horario.periodo ) " + &  
				" and    	  ( grupos.anio = horario.anio )  " + & 
				" and   	  ( grupos.cve_mat = materias.cve_mat )  " + & 
				" and   	  ( horario.cve_dia = dias.cve_dia )  " + & 
				" and  	  ( ( grupos.cond_gpo = 1 )  " + & 
				" AND    	  ( horario.cve_salon is NULL OR UPPER(horario.cve_salon) LIKE ~~'%HIBRIDASAL%~~' )  " + & 
				" AND    	  ( grupos.tipo = 0 )  " + & 
				" AND    	  ( horario.clase_aula = 0 )  " + & 
				" AND    	  ( grupos.anio = " + STRING(ii_anio) + " )  " + & 
				" AND       ( grupos.periodo = " + STRING(ii_periodo) + " ))  " + & 
				" AND grupos.forma_imparte = 1   " + &  
				" UNION  " + & 
				" SELECT horario_modular.cve_mat, horario_modular.gpo, horario_modular.anio, horario_modular.periodo, horario_modular.cve_dia, horario_modular.cve_salon, horario.hora_inicio,    " + & 
				" horario.hora_final, grupos.cupo, grupos.inscritos, materias.nivel, materias.materia, dias.dia, grupos.forma_imparte,    " + & 
				" grupos.fecha_inicio, grupos.fecha_fin  FROM grupos,  horario_modular , materias, dias, horario     " + & 
				" WHERE ( grupos.cve_mat = horario_modular.cve_mat )  " + & 
				" and    	( grupos.gpo = horario_modular.gpo )  " + & 
				" and    	( grupos.periodo = horario_modular.periodo ) " + &  
				" and    	( grupos.anio = horario_modular.anio )  " + & 
				" and   	( grupos.cve_mat = materias.cve_mat )  " + & 
				" and   	( horario_modular.cve_dia = dias.cve_dia )  " + & 
				" and  	( ( grupos.cond_gpo = 1 )  " + & 
				" AND    	( horario.cve_salon is NULL OR UPPER(horario.cve_salon) LIKE ~~'%HIBRIDASAL%~~' )  " + & 
				" AND    	( grupos.tipo = 0 )  " + & 
				" AND    	( grupos.anio = " + STRING(ii_anio) + " )  " + & 
				" AND    	( grupos.periodo = " + STRING(ii_periodo) + " ))  " + & 
				" AND grupos.forma_imparte = 2  " + &   	
				" AND EXISTS (SELECT * FROM horario  " + &    				
				" 		WHERE grupos.cve_mat = horario.cve_mat " + & 
				" 		AND grupos.gpo = horario.gpo " + & 
				" 		AND grupos.periodo = horario.periodo " + &    				
				" 		AND grupos.anio = horario.anio " + & 
				" 		AND horario.clase_aula = 0) " + & 
				" AND horario_modular.cve_mat = horario.cve_mat  " + & 
				" AND horario_modular.gpo = horario.gpo " + & 
				" AND horario_modular.periodo = horario.periodo " + & 
				" AND horario_modular.anio = horario.anio " + & 
				" AND horario_modular.cve_dia = horario.cve_dia " + &    	
				" AND horario_modular.hora_inicio = horario.hora_inicio " 


f_llena_configuracion_asignacion_salones(li_limiteinf,li_limitesup,li_cupoinsc) 

li_totasig = 0
if rb_inscritos.checked = true then
	ls_enbasea = "grupos_inscritos"
	li_limiteinf[5] = 1
else
	ls_enbasea = "grupos_cupo"
end if
dw_external_reporte.reset()
//Preguntar si son correctas las opciones de anio, periodo y en base a que, . . .

// Se recupera el total de niveles
li_total_niveles = iuo_nivel_servicios.ids_niveles.ROWCOUNT() 

// Se incrementa el total para considerar el nivel 'Cualquiera'
li_total_niveles ++

// Se recupera el Universo de grupos a los que se asigna salón. 
lds_asigna_automatica_salon = CREATE datastore
lds_asigna_automatica_salon.dataobject = "d_asigna_automatica_salon"
lds_asigna_automatica_salon.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'")
lds_asigna_automatica_salon.SetTransObject(gtr_sce)
li_res = lds_asigna_automatica_salon.retrieve(ii_anio, ii_periodo)

// Se recuperan los salones existentes 
//lds_salones_existentes = CREATE datastore
//lds_salones_existentes.dataobject = "d_salones_existentes_especial"
//lds_salones_existentes.SetTransObject(gtr_sce)


if li_res > 0 then
	li_tot = li_res
	st_porcentaje.text = "Asignados 0 de "+string(li_tot)
	
		
	// Ciclo de nivel ("L", "P", "C")  
	for li_niv = 1 to li_total_niveles 
			
//		IF li_niv = li_total_niveles THEN 
//			ls_nivel = 'C' 
//		ELSE
//			ls_nivel = iuo_nivel_servicios.ids_niveles.GETITEMSTRING(li_niv, "cve_nivel")
//		END IF 

		ls_nivel = 'C' 

		// Filtra los grupos por asignar por Inscritos o por cupo de los grupos y por la capacidad de los salones. 
		//*-******************************************************************************************
		//*-******************************************************************************************		
		
		// 1.- Se establecen los criterios de bloque 
		// 2.- Se establecen los criterios de horas - inicio por bloque
		// 3.- Se establecen los criterios por comodín 
			
		// BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE 
		// BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE 
		
		SELECT MAX(bloque)
		INTO :li_ttl_bloques 
		FROM salones_edificio_conf
		USING gtr_sce; 
		
		IF ISNULL(li_ttl_bloques) THEN li_ttl_bloques = 1 
		//li_ttl_bloques ++ 
		
		FOR le_vuelta = 1 TO li_ttl_bloques // BLOQUE 				
	
			STRING ls_or
			ls_filtro_nivel_completo = "" 
			
			// Se genera cadena de filtro para seleccionar los grupos que entran en el primer  y segundo bloque 
			IF le_vuelta = 1 THEN 
				
				ls_or = "" 
				le_bloque_max = iuo_salones_servicios.ids_cadenas_filtrado.ROWCOUNT() 
				FOR  le_bloque = 1 TO le_bloque_max 
					ls_filtro_nivel = iuo_salones_servicios.ids_cadenas_filtrado.GETITEMSTRING(le_bloque, "cadena_filtro")
					ls_filtro_nivel_completo = ls_filtro_nivel_completo + ls_or + "(" + ls_filtro_nivel + ")" 
					ls_or = " OR " 
				NEXT
				
				ls_filtro_nivel_completo = "(" + ls_filtro_nivel_completo + ")"
				
			ELSE 
				ls_filtro_nivel_completo = "" 
			END IF 
			
			// Se filtran los salones por el "PRIMER NIVEL DE HORARIO" 
			lds_asigna_automatica_salon.SETFILTER(ls_filtro_nivel_completo) 
			lds_asigna_automatica_salon.FILTER() 
			
			// Ciclo de Categoria (Categoria de Cupo en salones) Comienza por los más llenos y salones más grandes
			for li_cat = 1 to 5
				
				// Ciclo de cliterios ( De 1 a 4 Según se describen en el layout) 
				for li_crit = 1 to 4 	
					
					if (li_crit >= 3 and li_niv = 3) or li_crit < 3 then 		
					
						st_pasos.text = "Usando criterio " + string(li_crit) + " para categoría " + string(li_cat) + " del nivel " + ls_nivel 
						
						li_totparc = 0
							
							ls_orden = "" 
							
							// Licenciatura incluye TSU 
							IF ls_nivel = "L" THEN 
								ls_nivel2 = "T" 
							ELSE
								ls_nivel2 = ls_nivel 
							END IF 	
						
							ls_filtro = ls_enbasea + " BETWEEN "+string(li_limiteinf[li_cat])+" AND " + string(li_limitesup[li_cat]) + " AND (materias_nivel = '"+ ls_nivel + "' OR materias_nivel = '"+ ls_nivel2 +"' OR 'C' = '"+ ls_nivel +"' ) " + & 
										" AND " + ls_filtro_nivel_completo 
							
							lds_asigna_automatica_salon.SetFilter(ls_filtro) 
							li_res = lds_asigna_automatica_salon.Filter() 
							// Si no hay grupos con esta cantidad de inscritos, se procede al siguiente nivel. 
							IF li_res <= 0 THEN CONTINUE 
		
							lds_asigna_automatica_salon.SetSort(ls_enbasea + ' D, totalhorario D, horario_cve_mat A, horario_gpo A')	
							lds_asigna_automatica_salon.Sort()																								
							lds_asigna_automatica_salon.GroupCalc()																						
							
							li_totparc = lds_asigna_automatica_salon.RowCount()
							li_asigparc = 0
							
							if li_totparc > 0 then
								
								// Se verifica el criterio actual del ciclo 
								if li_crit = 1 then
									li_critcupoinsc = li_cupoinsc[li_cat]  
									
									iuo_salones_servicios.il_cupo_minimo = li_limiteinf[li_cat] 
									iuo_salones_servicios.il_cupo_maximo = li_limitesup[li_cat]									
									
								elseif li_crit = 2 then 
									
									// Se verifica si la categoria es 1 para que no se desborde el array 
									if li_cat = 1 then
										
										li_critcupoinsc = li_cupoinsc[li_cat]
										
										iuo_salones_servicios.il_cupo_minimo = li_limiteinf[li_cat] 
										iuo_salones_servicios.il_cupo_maximo = li_limitesup[li_cat]																			
									
									// Se se trata de una categoria posterior, se busca la categoria inmediata superior 
									else
										
										li_critcupoinsc = li_cupoinsc[li_cat - 1] 
										
										iuo_salones_servicios.il_cupo_minimo = li_limiteinf[li_cat - 1] 
										iuo_salones_servicios.il_cupo_maximo = li_limitesup[li_cat - 1]	
										
									end if
								else
									li_critcupoinsc = 0
								end if
								
								// Se recuperan los salones disponibles según el cupo recuperado en el criterio criterio y el nivel del ciclo.   
								//li_res = iuo_salones_servicios.of_existe_salon_esp(li_critcupoinsc, ls_nivel) 
								li_res = iuo_salones_servicios.of_existe_salon_esp(iuo_salones_servicios.il_cupo_minimo, iuo_salones_servicios.il_cupo_maximo, ls_nivel) 

								li_i = 1
								if li_res > 0 then
		
									li_res = iuo_salones_servicios.of_asigna_salon_esp(lds_asigna_automatica_salon, li_critcupoinsc,ls_nivel,li_i,li_crit, le_vuelta)
		
									li_i += li_tothor
									if li_res >= 0 then 
										li_asigparc += li_res
										li_totasig += li_res
										st_porcentaje.text = "Asignados "+string(li_totasig)+" de "+string(li_tot)
									end if
										
								end if
							end if
							li_res = dw_external_reporte.InsertRow(0)
							dw_external_reporte.SetItem(li_res,1,li_crit)
							dw_external_reporte.SetItem(li_res,2,li_cat)
							//dw_external_reporte.SetItem(li_res,3,li_niv)
							dw_external_reporte.SetItem(li_res,3,ls_nivel) 
							dw_external_reporte.SetItem(li_res,4,li_totparc)
							dw_external_reporte.SetItem(li_res,5,li_asigparc)
							dw_external_reporte.SetItem(li_res,6,li_tot)
							dw_external_reporte.Scroll(1)
							//li_res = lds_asigna_automatica_salon.retrieve(ii_anio, ii_periodo)
							lds_asigna_automatica_salon.dataobject = "d_asigna_automatica_salon"
							lds_asigna_automatica_salon.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'")
							lds_asigna_automatica_salon.SetTransObject(gtr_sce)
							li_res = lds_asigna_automatica_salon.retrieve(ii_anio, ii_periodo)
						
							
					end if 
						
					
				next // Ciclo de cliterios ( De 1 a 4 Según se describen en el layout) 
				
			next // Ciclo de Categoria
		
		NEXT //BLOQUE 	
		// BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE 						
		// BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE 		
		
		//*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*/
		//*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*/		
		
	next // Ciclo de nivel 
elseif li_res = 0 then
	MessageBox("Atencion","No hay grupos normales sin salón asignado")
else
	MessageBox("Atencion","Error en la consulta de grupos normales sin salon asignado")
end if
DESTROY lds_asigna_automatica_salon
DESTROY lds_salones_existentes


st_asignacion.TEXT = st_asignacion.TEXT + "    FIN: " + STRING(NOW())

MESSAGEBOX("Aviso", "Asignación terminada.") 

RETURN 0 









// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 
// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 
// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 
// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 


//// ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL 
//// ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL 
//
//// Comienza proceso de asignación.
//datastore lds_asigna_automatica_salon,lds_salones_existentes
//LONG li_crit, li_cat, li_niv, li_tot, li_totparc, li_critcupoinsc, li_tothor, li_asigparc
//LONG li_ret, li_res, li_i, li_j, li_totasig, li_total_niveles, li_ttl_bloques
//INTEGER li_limiteinf[5], li_limitesup[5], li_cupoinsc[5]
//string ls_enbasea, ls_nivel 
//
//STRING ls_orden, ls_filtro 
//STRING ls_filtro_nivel, ls_filtro_nivel_completo 
//
//STRING ls_sql 
//
//INTEGER le_bloque, le_bloque_max, le_vuelta   
//
//
//// Se inicializan los DS de asignación especial.
////iuo_salones_servicios.of_carga_asignacion_especial() 
//
//
//st_asignacion.TEXT = "Inicio: " + STRING(NOW()) 
//
//ls_sql = " SELECT	horario.cve_mat, horario.gpo, horario.anio,horario.periodo,  horario.cve_dia,   horario.cve_salon,   horario.hora_inicio,  " + & 
//				" horario.hora_final, grupos.cupo, grupos.inscritos, materias.nivel, materias.materia, dias.dia, grupos.forma_imparte,   " + & 
//				" grupos.fecha_inicio, grupos.fecha_fin   " + & 
//				" FROM grupos, horario, materias, dias  " + & 
//				" WHERE ( grupos.cve_mat = horario.cve_mat )  " + & 
//				" and    	  ( grupos.gpo = horario.gpo )  " + & 
//				" and    	  ( grupos.periodo = horario.periodo ) " + &  
//				" and    	  ( grupos.anio = horario.anio )  " + & 
//				" and   	  ( grupos.cve_mat = materias.cve_mat )  " + & 
//				" and   	  ( horario.cve_dia = dias.cve_dia )  " + & 
//				" and  	  ( ( grupos.cond_gpo = 1 )  " + & 
//				" AND    	  ( horario.cve_salon is NULL OR UPPER(horario.cve_salon) LIKE ~~'%HIBRIDASAL%~~' )  " + & 
//				" AND    	  ( grupos.tipo = 0 )  " + & 
//				" AND    	  ( horario.clase_aula = 0 )  " + & 
//				" AND    	  ( grupos.anio = " + STRING(ii_anio) + " )  " + & 
//				" AND       ( grupos.periodo = " + STRING(ii_periodo) + " ))  " + & 
//				" AND grupos.forma_imparte = 1   " + &  
//				" UNION  " + & 
//				" SELECT horario_modular.cve_mat, horario_modular.gpo, horario_modular.anio, horario_modular.periodo, horario_modular.cve_dia, horario_modular.cve_salon, horario.hora_inicio,    " + & 
//				" horario.hora_final, grupos.cupo, grupos.inscritos, materias.nivel, materias.materia, dias.dia, grupos.forma_imparte,    " + & 
//				" grupos.fecha_inicio, grupos.fecha_fin  FROM grupos,  horario_modular , materias, dias, horario     " + & 
//				" WHERE ( grupos.cve_mat = horario_modular.cve_mat )  " + & 
//				" and    	( grupos.gpo = horario_modular.gpo )  " + & 
//				" and    	( grupos.periodo = horario_modular.periodo ) " + &  
//				" and    	( grupos.anio = horario_modular.anio )  " + & 
//				" and   	( grupos.cve_mat = materias.cve_mat )  " + & 
//				" and   	( horario_modular.cve_dia = dias.cve_dia )  " + & 
//				" and  	( ( grupos.cond_gpo = 1 )  " + & 
//				" AND    	( horario.cve_salon is NULL OR UPPER(horario.cve_salon) LIKE ~~'%HIBRIDASAL%~~' )  " + & 
//				" AND    	( grupos.tipo = 0 )  " + & 
//				" AND    	( grupos.anio = " + STRING(ii_anio) + " )  " + & 
//				" AND    	( grupos.periodo = " + STRING(ii_periodo) + " ))  " + & 
//				" AND grupos.forma_imparte = 2  " + &   	
//				" AND EXISTS (SELECT * FROM horario  " + &    				
//				" 		WHERE grupos.cve_mat = horario.cve_mat " + & 
//				" 		AND grupos.gpo = horario.gpo " + & 
//				" 		AND grupos.periodo = horario.periodo " + &    				
//				" 		AND grupos.anio = horario.anio " + & 
//				" 		AND horario.clase_aula = 0) " + & 
//				" AND horario_modular.cve_mat = horario.cve_mat  " + & 
//				" AND horario_modular.gpo = horario.gpo " + & 
//				" AND horario_modular.periodo = horario.periodo " + & 
//				" AND horario_modular.anio = horario.anio " + & 
//				" AND horario_modular.cve_dia = horario.cve_dia " + &    	
//				" AND horario_modular.hora_inicio = horario.hora_inicio " 
//
//
//f_llena_configuracion_asignacion_salones(li_limiteinf,li_limitesup,li_cupoinsc) 
//
//li_totasig = 0
//if rb_inscritos.checked = true then
//	ls_enbasea = "grupos_inscritos"
//	li_limiteinf[5] = 1
//else
//	ls_enbasea = "grupos_cupo"
//end if
//dw_external_reporte.reset()
////Preguntar si son correctas las opciones de anio, periodo y en base a que, . . .
//
//// Se recupera el total de niveles
//li_total_niveles = iuo_nivel_servicios.ids_niveles.ROWCOUNT() 
//
//// Se incrementa el total para considerar el nivel 'Cualquiera'
//li_total_niveles ++
//
//// Se recupera el Universo de grupos a los que se asigna salón. 
//lds_asigna_automatica_salon = CREATE datastore
//lds_asigna_automatica_salon.dataobject = "d_asigna_automatica_salon"
//lds_asigna_automatica_salon.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'")
//lds_asigna_automatica_salon.SetTransObject(gtr_sce)
//li_res = lds_asigna_automatica_salon.retrieve(ii_anio, ii_periodo)
//
//// Se recuperan los salones existentes 
////lds_salones_existentes = CREATE datastore
////lds_salones_existentes.dataobject = "d_salones_existentes_especial"
////lds_salones_existentes.SetTransObject(gtr_sce)
//
//
//if li_res > 0 then
//	li_tot = li_res
//	st_porcentaje.text = "Asignados 0 de "+string(li_tot)
//	
//		
//	// Ciclo de nivel ("L", "P", "C")  
//	for li_niv = 1 to li_total_niveles 
//			
//		IF li_niv <= li_total_niveles THEN 
//			ls_nivel = 'C' 
//		ELSE
//			ls_nivel = iuo_nivel_servicios.ids_niveles.GETITEMSTRING(li_niv, "cve_nivel")
//		END IF
//
//		// Filtra los grupos por asignar por Inscritos o por cupo de los grupos y por la capacidad de los salones. 
//		//*-******************************************************************************************
//		//*-******************************************************************************************		
//		
//		// 1.- Se establecen los criterios de bloque 
//		// 2.- Se establecen los criterios de horas - inicio por bloque
//		// 3.- Se establecen los criterios por comodín 
//			
//		// BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE 
//		// BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE 
//		
//		SELECT MAX(bloque)
//		INTO :li_ttl_bloques 
//		FROM salones_edificio_conf
//		USING gtr_sce; 
//		
//		IF ISNULL(li_ttl_bloques) THEN li_ttl_bloques = 1 
//		li_ttl_bloques ++ 
//		
//		FOR le_vuelta = 1 TO li_ttl_bloques // BLOQUE 				
//	
//			STRING ls_or
//			ls_filtro_nivel_completo = "" 
//			
//			// Se genera cadena de filtro para seleccionar los grupos que entran en el primer  y segundo bloque 
//			IF le_vuelta = 1 THEN 
//				
//				ls_or = "" 
//				le_bloque_max = iuo_salones_servicios.ids_cadenas_filtrado.ROWCOUNT() 
//				FOR  le_bloque = 1 TO le_bloque_max 
//					ls_filtro_nivel = iuo_salones_servicios.ids_cadenas_filtrado.GETITEMSTRING(le_bloque, "cadena_filtro")
//					ls_filtro_nivel_completo = ls_filtro_nivel_completo + ls_or + "(" + ls_filtro_nivel + ")" 
//					ls_or = " OR " 
//				NEXT
//				
//				ls_filtro_nivel_completo = "(" + ls_filtro_nivel_completo + ")"
//				
//			ELSE 
//				ls_filtro_nivel_completo = "" 
//			END IF 
//			
//			// Se filtran los salones por el "PRIMER NIVEL DE HORARIO" 
//			lds_asigna_automatica_salon.SETFILTER(ls_filtro_nivel_completo) 
//			lds_asigna_automatica_salon.FILTER() 
//			
//			// Ciclo de Categoria (Categoria de Cupo en salones) Comienza por los más llenos y salones más grandes
//			for li_cat = 1 to 5
//				
//				// Ciclo de cliterios ( De 1 a 4 Según se describen en el layout) 
//				for li_crit = 1 to 4 	
//					
//					if (li_crit >= 3 and li_niv = 3) or li_crit < 3 then 		
//					
//						st_pasos.text = "Usando criterio " + string(li_crit) + " para categoría " + string(li_cat) + " del nivel " + ls_nivel 
//						
//						li_totparc = 0
//							
//							ls_orden = ""
//							ls_filtro = ls_enbasea + " BETWEEN "+string(li_limiteinf[li_cat])+" AND " + string(li_limitesup[li_cat]) + " AND (materias_nivel = '"+ ls_nivel +"' OR 'C' = '"+ ls_nivel +"' ) " + & 
//										" AND " + ls_filtro_nivel_completo 
//							
//							
//							iuo_salones_servicios.il_cupo_minimo = li_limiteinf[li_cat] 
//							iuo_salones_servicios.il_cupo_maximo = li_limitesup[li_cat]
//							
//							lds_asigna_automatica_salon.SetFilter(ls_filtro) 
//							li_res = lds_asigna_automatica_salon.Filter() 
//							// Si no hay grupos con esta cantidad de inscritos, se procede al siguiente nivel. 
//							IF li_res <= 0 THEN CONTINUE 
//		
//							lds_asigna_automatica_salon.SetSort(ls_enbasea + ' D, totalhorario D, horario_cve_mat A, horario_gpo A')	
//							lds_asigna_automatica_salon.Sort()																								
//							lds_asigna_automatica_salon.GroupCalc()																						
//							
//							li_totparc = lds_asigna_automatica_salon.RowCount()
//							li_asigparc = 0
//							
//							if li_totparc > 0 then
//								
//								// Se verifica el criterio actual del ciclo 
//								if li_crit = 1 then
//									li_critcupoinsc = li_cupoinsc[li_cat]
//								elseif li_crit = 2 then
//									if li_cat = 1 then
//										li_critcupoinsc = li_cupoinsc[li_cat]
//									else
//										li_critcupoinsc = li_cupoinsc[li_cat - 1]
//									end if
//								else
//									li_critcupoinsc = 0
//								end if
//								
//								// Se recuperan los salones disponibles según el cupo recuperado en el criterio criterio y el nivel del ciclo.   
//								//li_res = iuo_salones_servicios.of_existe_salon_esp(li_critcupoinsc, ls_nivel) 
//								li_res = iuo_salones_servicios.of_existe_salon_esp(iuo_salones_servicios.il_cupo_minimo, iuo_salones_servicios.il_cupo_maximo, ls_nivel) 
//
//								li_i = 1
//								if li_res > 0 then
//		
//									li_res = iuo_salones_servicios.of_asigna_salon_esp(lds_asigna_automatica_salon, li_critcupoinsc,ls_nivel,li_i,li_crit, le_vuelta)
//		
//									li_i += li_tothor
//									if li_res >= 0 then 
//										li_asigparc += li_res
//										li_totasig += li_res
//										st_porcentaje.text = "Asignados "+string(li_totasig)+" de "+string(li_tot)
//									end if
//										
//								end if
//							end if
//							li_res = dw_external_reporte.InsertRow(0)
//							dw_external_reporte.SetItem(li_res,1,li_crit)
//							dw_external_reporte.SetItem(li_res,2,li_cat)
//							//dw_external_reporte.SetItem(li_res,3,li_niv)
//							dw_external_reporte.SetItem(li_res,3,ls_nivel) 
//							dw_external_reporte.SetItem(li_res,4,li_totparc)
//							dw_external_reporte.SetItem(li_res,5,li_asigparc)
//							dw_external_reporte.SetItem(li_res,6,li_tot)
//							dw_external_reporte.Scroll(1)
//							//li_res = lds_asigna_automatica_salon.retrieve(ii_anio, ii_periodo)
//							lds_asigna_automatica_salon.dataobject = "d_asigna_automatica_salon"
//							lds_asigna_automatica_salon.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'")
//							lds_asigna_automatica_salon.SetTransObject(gtr_sce)
//							li_res = lds_asigna_automatica_salon.retrieve(ii_anio, ii_periodo)
//						
//							
//					end if 
//						
//					
//				next // Ciclo de cliterios ( De 1 a 4 Según se describen en el layout) 
//				
//			next // Ciclo de Categoria
//		
//		NEXT //BLOQUE 	
//		// BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE 						
//		// BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE 		
//		
//		//*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*/
//		//*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*/		
//		
//	next // Ciclo de nivel 
//elseif li_res = 0 then
//	MessageBox("Atencion","No hay grupos normales sin salón asignado")
//else
//	MessageBox("Atencion","Error en la consulta de grupos normales sin salon asignado")
//end if
//DESTROY lds_asigna_automatica_salon
//DESTROY lds_salones_existentes
//
//
//st_asignacion.TEXT = st_asignacion.TEXT + "    FIN: " + STRING(NOW())
//
//MESSAGEBOX("Aviso", "Asignación terminada.") 
//
//RETURN 0 
//

// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 
// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 
// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 
// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 










end function

public function integer wf_asignacion_especial2 ();
// ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL 
// ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL 

// Comienza proceso de asignación.
datastore lds_asigna_automatica_salon,lds_salones_existentes
LONG li_crit, li_cat, li_niv, li_tot, li_totparc, li_critcupoinsc, li_tothor, li_asigparc
LONG li_ret, li_res, li_i, li_j, li_totasig, li_total_niveles, li_ttl_bloques
INTEGER li_limiteinf[5], li_limitesup[5], li_cupoinsc[5]
string ls_enbasea, ls_nivel, ls_nivel2 

STRING ls_orden, ls_filtro 
STRING ls_filtro_nivel, ls_filtro_nivel_completo 

STRING ls_sql 

INTEGER le_bloque, le_bloque_max, le_vuelta   


// Se inicializan los DS de asignación especial.
//iuo_salones_servicios.of_carga_asignacion_especial() 


st_asignacion.TEXT = "Inicio: " + STRING(NOW()) 

ls_sql = " SELECT	horario.cve_mat, horario.gpo, horario.anio,horario.periodo,  horario.cve_dia,   horario.cve_salon,   horario.hora_inicio,  " + & 
				" horario.hora_final, grupos.cupo, grupos.inscritos, materias.nivel, materias.materia, dias.dia, grupos.forma_imparte,   " + & 
				" grupos.fecha_inicio, grupos.fecha_fin   " + & 
				" FROM grupos, horario, materias, dias  " + & 
				" WHERE ( grupos.cve_mat = horario.cve_mat )  " + & 
				" and    	  ( grupos.gpo = horario.gpo )  " + & 
				" and    	  ( grupos.periodo = horario.periodo ) " + &  
				" and    	  ( grupos.anio = horario.anio )  " + & 
				" and   	  ( grupos.cve_mat = materias.cve_mat )  " + & 
				" and   	  ( horario.cve_dia = dias.cve_dia )  " + & 
				" and  	  ( ( grupos.cond_gpo = 1 )  " + & 
				" AND    	  ( horario.cve_salon is NULL OR UPPER(horario.cve_salon) LIKE ~~'%HIBRIDASAL%~~' )  " + & 
				" AND    	  ( grupos.tipo = 0 )  " + & 
				" AND    	  ( horario.clase_aula = 0 )  " + & 
				" AND    	  ( grupos.anio = " + STRING(ii_anio) + " )  " + & 
				" AND       ( grupos.periodo = " + STRING(ii_periodo) + " ))  " + & 
				" AND grupos.forma_imparte = 1   " + &  
				" UNION  " + & 
				" SELECT horario_modular.cve_mat, horario_modular.gpo, horario_modular.anio, horario_modular.periodo, horario_modular.cve_dia, horario_modular.cve_salon, horario.hora_inicio,    " + & 
				" horario.hora_final, grupos.cupo, grupos.inscritos, materias.nivel, materias.materia, dias.dia, grupos.forma_imparte,    " + & 
				" grupos.fecha_inicio, grupos.fecha_fin  FROM grupos,  horario_modular , materias, dias, horario     " + & 
				" WHERE ( grupos.cve_mat = horario_modular.cve_mat )  " + & 
				" and    	( grupos.gpo = horario_modular.gpo )  " + & 
				" and    	( grupos.periodo = horario_modular.periodo ) " + &  
				" and    	( grupos.anio = horario_modular.anio )  " + & 
				" and   	( grupos.cve_mat = materias.cve_mat )  " + & 
				" and   	( horario_modular.cve_dia = dias.cve_dia )  " + & 
				" and  	( ( grupos.cond_gpo = 1 )  " + & 
				" AND    	( horario.cve_salon is NULL OR UPPER(horario.cve_salon) LIKE ~~'%HIBRIDASAL%~~' )  " + & 
				" AND    	( grupos.tipo = 0 )  " + & 
				" AND    	( grupos.anio = " + STRING(ii_anio) + " )  " + & 
				" AND    	( grupos.periodo = " + STRING(ii_periodo) + " ))  " + & 
				" AND grupos.forma_imparte = 2  " + &   	
				" AND EXISTS (SELECT * FROM horario  " + &    				
				" 		WHERE grupos.cve_mat = horario.cve_mat " + & 
				" 		AND grupos.gpo = horario.gpo " + & 
				" 		AND grupos.periodo = horario.periodo " + &    				
				" 		AND grupos.anio = horario.anio " + & 
				" 		AND horario.clase_aula = 0) " + & 
				" AND horario_modular.cve_mat = horario.cve_mat  " + & 
				" AND horario_modular.gpo = horario.gpo " + & 
				" AND horario_modular.periodo = horario.periodo " + & 
				" AND horario_modular.anio = horario.anio " + & 
				" AND horario_modular.cve_dia = horario.cve_dia " + &    	
				" AND horario_modular.hora_inicio = horario.hora_inicio " 


f_llena_configuracion_asignacion_salones(li_limiteinf,li_limitesup,li_cupoinsc) 

li_totasig = 0
if rb_inscritos.checked = true then
	ls_enbasea = "grupos_inscritos"
	li_limiteinf[5] = 1
else
	ls_enbasea = "grupos_cupo"
end if
dw_external_reporte.reset()
//Preguntar si son correctas las opciones de anio, periodo y en base a que, . . .

// Se recupera el total de niveles
li_total_niveles = iuo_nivel_servicios.ids_niveles.ROWCOUNT() 

// Se incrementa el total para considerar el nivel 'Cualquiera'
li_total_niveles ++

// Se recupera el Universo de grupos a los que se asigna salón. 
lds_asigna_automatica_salon = CREATE datastore
lds_asigna_automatica_salon.dataobject = "d_asigna_automatica_salon"
lds_asigna_automatica_salon.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'")
lds_asigna_automatica_salon.SetTransObject(gtr_sce)
li_res = lds_asigna_automatica_salon.retrieve(ii_anio, ii_periodo)

// Se recuperan los salones existentes 
//lds_salones_existentes = CREATE datastore
//lds_salones_existentes.dataobject = "d_salones_existentes_especial"
//lds_salones_existentes.SetTransObject(gtr_sce)


if li_res > 0 then
	li_tot = li_res
	st_porcentaje.text = "Asignados 0 de "+string(li_tot)
	
		
	// Ciclo de nivel ("L", "P", "C")  
	for li_niv = 1 to li_total_niveles 
			
//		IF li_niv = li_total_niveles THEN 
//			ls_nivel = 'C' 
//		ELSE
//			ls_nivel = iuo_nivel_servicios.ids_niveles.GETITEMSTRING(li_niv, "cve_nivel")
//		END IF 

		ls_nivel = 'C' 

		// Filtra los grupos por asignar por Inscritos o por cupo de los grupos y por la capacidad de los salones. 
		//*-******************************************************************************************
		//*-******************************************************************************************		
		
		// 1.- Se establecen los criterios de bloque 
		// 2.- Se establecen los criterios de horas - inicio por bloque
		// 3.- Se establecen los criterios por comodín 
			
		// BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE 
		// BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE 
		
		SELECT MAX(bloque)
		INTO :li_ttl_bloques 
		FROM salones_edificio_conf
		USING gtr_sce; 
		
		IF ISNULL(li_ttl_bloques) THEN li_ttl_bloques = 1 
		//li_ttl_bloques ++ 
		
		FOR le_vuelta = 1 TO li_ttl_bloques // BLOQUE 				
	
			STRING ls_or
			ls_filtro_nivel_completo = "" 
			
			// Se genera cadena de filtro para seleccionar los grupos que entran en el primer  y segundo bloque 
			IF le_vuelta = 1 THEN 
				
				ls_or = "" 
				le_bloque_max = iuo_salones_servicios.ids_cadenas_filtrado.ROWCOUNT() 
				FOR  le_bloque = 1 TO le_bloque_max 
					ls_filtro_nivel = iuo_salones_servicios.ids_cadenas_filtrado.GETITEMSTRING(le_bloque, "cadena_filtro")
					ls_filtro_nivel_completo = ls_filtro_nivel_completo + ls_or + "(" + ls_filtro_nivel + ")" 
					ls_or = " OR " 
				NEXT
				
				ls_filtro_nivel_completo = "(" + ls_filtro_nivel_completo + ")"
				
			ELSE 
				ls_filtro_nivel_completo = "" 
			END IF 
			
			// Se filtran los salones por el "PRIMER NIVEL DE HORARIO" 
			lds_asigna_automatica_salon.SETFILTER(ls_filtro_nivel_completo) 
			lds_asigna_automatica_salon.FILTER() 
			
			// Ciclo de Categoria (Categoria de Cupo en salones) Comienza por los más llenos y salones más grandes
			for li_cat = 1 to 5
				
				// Ciclo de cliterios ( De 1 a 4 Según se describen en el layout) 
				for li_crit = 1 to 4 	
					
					if (li_crit >= 3 and li_niv = 3) or li_crit < 3 then 		
					
						st_pasos.text = "Usando criterio " + string(li_crit) + " para categoría " + string(li_cat) + " del nivel " + ls_nivel 
						
						li_totparc = 0
							
							ls_orden = "" 
							
							// Licenciatura incluye TSU 
							IF ls_nivel = "L" THEN 
								ls_nivel2 = "T" 
							ELSE
								ls_nivel2 = ls_nivel 
							END IF 	
						
						//**//
//							ls_filtro = ls_enbasea + " BETWEEN "+string(li_limiteinf[li_cat])+" AND " + string(li_limitesup[li_cat]) + " AND (materias_nivel = '"+ ls_nivel + "' OR materias_nivel = '"+ ls_nivel2 +"' OR 'C' = '"+ ls_nivel +"' ) " + & 
//										" AND " + ls_filtro_nivel_completo 
//							
//							lds_asigna_automatica_salon.SetFilter(ls_filtro) 
//							li_res = lds_asigna_automatica_salon.Filter() 
						//**//

							// Si no hay grupos con esta cantidad de inscritos, se procede al siguiente nivel. 
							IF li_res <= 0 THEN CONTINUE 
		
							lds_asigna_automatica_salon.SetSort(ls_enbasea + ' D, totalhorario D, horario_cve_mat A, horario_gpo A')	
							lds_asigna_automatica_salon.Sort()																								
							lds_asigna_automatica_salon.GroupCalc()																						
							
							li_totparc = lds_asigna_automatica_salon.RowCount()
							li_asigparc = 0
							
							if li_totparc > 0 then
								
								// Se verifica el criterio actual del ciclo 
								if li_crit = 1 then
									li_critcupoinsc = li_cupoinsc[li_cat]  
									
									iuo_salones_servicios.il_cupo_minimo = li_limiteinf[li_cat] 
									iuo_salones_servicios.il_cupo_maximo = li_limitesup[li_cat]									
									
								elseif li_crit = 2 then 
									
									// Se verifica si la categoria es 1 para que no se desborde el array 
									if li_cat = 1 then
										
										li_critcupoinsc = li_cupoinsc[li_cat]
										
										iuo_salones_servicios.il_cupo_minimo = li_limiteinf[li_cat] 
										iuo_salones_servicios.il_cupo_maximo = li_limitesup[li_cat]																			
									
									// Se se trata de una categoria posterior, se busca la categoria inmediata superior 
									else
										
										li_critcupoinsc = li_cupoinsc[li_cat - 1] 
										
										iuo_salones_servicios.il_cupo_minimo = li_limiteinf[li_cat - 1] 
										iuo_salones_servicios.il_cupo_maximo = li_limitesup[li_cat - 1]	
										
									end if
								else
									li_critcupoinsc = 0
								end if
								
								// Se recuperan los salones disponibles según el cupo recuperado en el criterio criterio y el nivel del ciclo.   
								//li_res = iuo_salones_servicios.of_existe_salon_esp(li_critcupoinsc, ls_nivel) 
								li_res = iuo_salones_servicios.of_existe_salon_esp(iuo_salones_servicios.il_cupo_minimo, iuo_salones_servicios.il_cupo_maximo, ls_nivel) 

								li_i = 1
								if li_res > 0 then
		
									li_res = iuo_salones_servicios.of_asigna_salon_esp(lds_asigna_automatica_salon, li_critcupoinsc,ls_nivel,li_i,li_crit, le_vuelta)
		
									li_i += li_tothor
									if li_res >= 0 then 
										li_asigparc += li_res
										li_totasig += li_res
										st_porcentaje.text = "Asignados "+string(li_totasig)+" de "+string(li_tot)
									end if
										
								end if
							end if
							li_res = dw_external_reporte.InsertRow(0)
							dw_external_reporte.SetItem(li_res,1,li_crit)
							dw_external_reporte.SetItem(li_res,2,li_cat)
							//dw_external_reporte.SetItem(li_res,3,li_niv)
							dw_external_reporte.SetItem(li_res,3,ls_nivel) 
							dw_external_reporte.SetItem(li_res,4,li_totparc)
							dw_external_reporte.SetItem(li_res,5,li_asigparc)
							dw_external_reporte.SetItem(li_res,6,li_tot)
							dw_external_reporte.Scroll(1)
							//li_res = lds_asigna_automatica_salon.retrieve(gi_anio, gi_periodo)
							lds_asigna_automatica_salon.dataobject = "d_asigna_automatica_salon"
							lds_asigna_automatica_salon.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'")
							lds_asigna_automatica_salon.SetTransObject(gtr_sce)
							li_res = lds_asigna_automatica_salon.retrieve(ii_anio, ii_periodo)
						
							
					end if 
						
					
				next // Ciclo de cliterios ( De 1 a 4 Según se describen en el layout) 
				
			next // Ciclo de Categoria
		
		NEXT //BLOQUE 	
		// BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE 						
		// BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE 		
		
		//*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*/
		//*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*/		
		
	next // Ciclo de nivel 
elseif li_res = 0 then
	MessageBox("Atencion","No hay grupos normales sin salón asignado")
else
	MessageBox("Atencion","Error en la consulta de grupos normales sin salon asignado")
end if
DESTROY lds_asigna_automatica_salon
DESTROY lds_salones_existentes


st_asignacion.TEXT = st_asignacion.TEXT + "    FIN: " + STRING(NOW())

MESSAGEBOX("Aviso", "Asignación terminada.") 

RETURN 0 









// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 
// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 
// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 
// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 


//// ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL 
//// ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL  ASIGNACIÓN ESPECIAL 
//
//// Comienza proceso de asignación.
//datastore lds_asigna_automatica_salon,lds_salones_existentes
//LONG li_crit, li_cat, li_niv, li_tot, li_totparc, li_critcupoinsc, li_tothor, li_asigparc
//LONG li_ret, li_res, li_i, li_j, li_totasig, li_total_niveles, li_ttl_bloques
//INTEGER li_limiteinf[5], li_limitesup[5], li_cupoinsc[5]
//string ls_enbasea, ls_nivel 
//
//STRING ls_orden, ls_filtro 
//STRING ls_filtro_nivel, ls_filtro_nivel_completo 
//
//STRING ls_sql 
//
//INTEGER le_bloque, le_bloque_max, le_vuelta   
//
//
//// Se inicializan los DS de asignación especial.
////iuo_salones_servicios.of_carga_asignacion_especial() 
//
//
//st_asignacion.TEXT = "Inicio: " + STRING(NOW()) 
//
//ls_sql = " SELECT	horario.cve_mat, horario.gpo, horario.anio,horario.periodo,  horario.cve_dia,   horario.cve_salon,   horario.hora_inicio,  " + & 
//				" horario.hora_final, grupos.cupo, grupos.inscritos, materias.nivel, materias.materia, dias.dia, grupos.forma_imparte,   " + & 
//				" grupos.fecha_inicio, grupos.fecha_fin   " + & 
//				" FROM grupos, horario, materias, dias  " + & 
//				" WHERE ( grupos.cve_mat = horario.cve_mat )  " + & 
//				" and    	  ( grupos.gpo = horario.gpo )  " + & 
//				" and    	  ( grupos.periodo = horario.periodo ) " + &  
//				" and    	  ( grupos.anio = horario.anio )  " + & 
//				" and   	  ( grupos.cve_mat = materias.cve_mat )  " + & 
//				" and   	  ( horario.cve_dia = dias.cve_dia )  " + & 
//				" and  	  ( ( grupos.cond_gpo = 1 )  " + & 
//				" AND    	  ( horario.cve_salon is NULL OR UPPER(horario.cve_salon) LIKE ~~'%HIBRIDASAL%~~' )  " + & 
//				" AND    	  ( grupos.tipo = 0 )  " + & 
//				" AND    	  ( horario.clase_aula = 0 )  " + & 
//				" AND    	  ( grupos.anio = " + STRING(gi_anio) + " )  " + & 
//				" AND       ( grupos.periodo = " + STRING(gi_periodo) + " ))  " + & 
//				" AND grupos.forma_imparte = 1   " + &  
//				" UNION  " + & 
//				" SELECT horario_modular.cve_mat, horario_modular.gpo, horario_modular.anio, horario_modular.periodo, horario_modular.cve_dia, horario_modular.cve_salon, horario.hora_inicio,    " + & 
//				" horario.hora_final, grupos.cupo, grupos.inscritos, materias.nivel, materias.materia, dias.dia, grupos.forma_imparte,    " + & 
//				" grupos.fecha_inicio, grupos.fecha_fin  FROM grupos,  horario_modular , materias, dias, horario     " + & 
//				" WHERE ( grupos.cve_mat = horario_modular.cve_mat )  " + & 
//				" and    	( grupos.gpo = horario_modular.gpo )  " + & 
//				" and    	( grupos.periodo = horario_modular.periodo ) " + &  
//				" and    	( grupos.anio = horario_modular.anio )  " + & 
//				" and   	( grupos.cve_mat = materias.cve_mat )  " + & 
//				" and   	( horario_modular.cve_dia = dias.cve_dia )  " + & 
//				" and  	( ( grupos.cond_gpo = 1 )  " + & 
//				" AND    	( horario.cve_salon is NULL OR UPPER(horario.cve_salon) LIKE ~~'%HIBRIDASAL%~~' )  " + & 
//				" AND    	( grupos.tipo = 0 )  " + & 
//				" AND    	( grupos.anio = " + STRING(gi_anio) + " )  " + & 
//				" AND    	( grupos.periodo = " + STRING(gi_periodo) + " ))  " + & 
//				" AND grupos.forma_imparte = 2  " + &   	
//				" AND EXISTS (SELECT * FROM horario  " + &    				
//				" 		WHERE grupos.cve_mat = horario.cve_mat " + & 
//				" 		AND grupos.gpo = horario.gpo " + & 
//				" 		AND grupos.periodo = horario.periodo " + &    				
//				" 		AND grupos.anio = horario.anio " + & 
//				" 		AND horario.clase_aula = 0) " + & 
//				" AND horario_modular.cve_mat = horario.cve_mat  " + & 
//				" AND horario_modular.gpo = horario.gpo " + & 
//				" AND horario_modular.periodo = horario.periodo " + & 
//				" AND horario_modular.anio = horario.anio " + & 
//				" AND horario_modular.cve_dia = horario.cve_dia " + &    	
//				" AND horario_modular.hora_inicio = horario.hora_inicio " 
//
//
//f_llena_configuracion_asignacion_salones(li_limiteinf,li_limitesup,li_cupoinsc) 
//
//li_totasig = 0
//if rb_inscritos.checked = true then
//	ls_enbasea = "grupos_inscritos"
//	li_limiteinf[5] = 1
//else
//	ls_enbasea = "grupos_cupo"
//end if
//dw_external_reporte.reset()
////Preguntar si son correctas las opciones de anio, periodo y en base a que, . . .
//
//// Se recupera el total de niveles
//li_total_niveles = iuo_nivel_servicios.ids_niveles.ROWCOUNT() 
//
//// Se incrementa el total para considerar el nivel 'Cualquiera'
//li_total_niveles ++
//
//// Se recupera el Universo de grupos a los que se asigna salón. 
//lds_asigna_automatica_salon = CREATE datastore
//lds_asigna_automatica_salon.dataobject = "d_asigna_automatica_salon"
//lds_asigna_automatica_salon.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'")
//lds_asigna_automatica_salon.SetTransObject(gtr_sce)
//li_res = lds_asigna_automatica_salon.retrieve(gi_anio, gi_periodo)
//
//// Se recuperan los salones existentes 
////lds_salones_existentes = CREATE datastore
////lds_salones_existentes.dataobject = "d_salones_existentes_especial"
////lds_salones_existentes.SetTransObject(gtr_sce)
//
//
//if li_res > 0 then
//	li_tot = li_res
//	st_porcentaje.text = "Asignados 0 de "+string(li_tot)
//	
//		
//	// Ciclo de nivel ("L", "P", "C")  
//	for li_niv = 1 to li_total_niveles 
//			
//		IF li_niv <= li_total_niveles THEN 
//			ls_nivel = 'C' 
//		ELSE
//			ls_nivel = iuo_nivel_servicios.ids_niveles.GETITEMSTRING(li_niv, "cve_nivel")
//		END IF
//
//		// Filtra los grupos por asignar por Inscritos o por cupo de los grupos y por la capacidad de los salones. 
//		//*-******************************************************************************************
//		//*-******************************************************************************************		
//		
//		// 1.- Se establecen los criterios de bloque 
//		// 2.- Se establecen los criterios de horas - inicio por bloque
//		// 3.- Se establecen los criterios por comodín 
//			
//		// BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE 
//		// BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE 
//		
//		SELECT MAX(bloque)
//		INTO :li_ttl_bloques 
//		FROM salones_edificio_conf
//		USING gtr_sce; 
//		
//		IF ISNULL(li_ttl_bloques) THEN li_ttl_bloques = 1 
//		li_ttl_bloques ++ 
//		
//		FOR le_vuelta = 1 TO li_ttl_bloques // BLOQUE 				
//	
//			STRING ls_or
//			ls_filtro_nivel_completo = "" 
//			
//			// Se genera cadena de filtro para seleccionar los grupos que entran en el primer  y segundo bloque 
//			IF le_vuelta = 1 THEN 
//				
//				ls_or = "" 
//				le_bloque_max = iuo_salones_servicios.ids_cadenas_filtrado.ROWCOUNT() 
//				FOR  le_bloque = 1 TO le_bloque_max 
//					ls_filtro_nivel = iuo_salones_servicios.ids_cadenas_filtrado.GETITEMSTRING(le_bloque, "cadena_filtro")
//					ls_filtro_nivel_completo = ls_filtro_nivel_completo + ls_or + "(" + ls_filtro_nivel + ")" 
//					ls_or = " OR " 
//				NEXT
//				
//				ls_filtro_nivel_completo = "(" + ls_filtro_nivel_completo + ")"
//				
//			ELSE 
//				ls_filtro_nivel_completo = "" 
//			END IF 
//			
//			// Se filtran los salones por el "PRIMER NIVEL DE HORARIO" 
//			lds_asigna_automatica_salon.SETFILTER(ls_filtro_nivel_completo) 
//			lds_asigna_automatica_salon.FILTER() 
//			
//			// Ciclo de Categoria (Categoria de Cupo en salones) Comienza por los más llenos y salones más grandes
//			for li_cat = 1 to 5
//				
//				// Ciclo de cliterios ( De 1 a 4 Según se describen en el layout) 
//				for li_crit = 1 to 4 	
//					
//					if (li_crit >= 3 and li_niv = 3) or li_crit < 3 then 		
//					
//						st_pasos.text = "Usando criterio " + string(li_crit) + " para categoría " + string(li_cat) + " del nivel " + ls_nivel 
//						
//						li_totparc = 0
//							
//							ls_orden = ""
//							ls_filtro = ls_enbasea + " BETWEEN "+string(li_limiteinf[li_cat])+" AND " + string(li_limitesup[li_cat]) + " AND (materias_nivel = '"+ ls_nivel +"' OR 'C' = '"+ ls_nivel +"' ) " + & 
//										" AND " + ls_filtro_nivel_completo 
//							
//							
//							iuo_salones_servicios.il_cupo_minimo = li_limiteinf[li_cat] 
//							iuo_salones_servicios.il_cupo_maximo = li_limitesup[li_cat]
//							
//							lds_asigna_automatica_salon.SetFilter(ls_filtro) 
//							li_res = lds_asigna_automatica_salon.Filter() 
//							// Si no hay grupos con esta cantidad de inscritos, se procede al siguiente nivel. 
//							IF li_res <= 0 THEN CONTINUE 
//		
//							lds_asigna_automatica_salon.SetSort(ls_enbasea + ' D, totalhorario D, horario_cve_mat A, horario_gpo A')	
//							lds_asigna_automatica_salon.Sort()																								
//							lds_asigna_automatica_salon.GroupCalc()																						
//							
//							li_totparc = lds_asigna_automatica_salon.RowCount()
//							li_asigparc = 0
//							
//							if li_totparc > 0 then
//								
//								// Se verifica el criterio actual del ciclo 
//								if li_crit = 1 then
//									li_critcupoinsc = li_cupoinsc[li_cat]
//								elseif li_crit = 2 then
//									if li_cat = 1 then
//										li_critcupoinsc = li_cupoinsc[li_cat]
//									else
//										li_critcupoinsc = li_cupoinsc[li_cat - 1]
//									end if
//								else
//									li_critcupoinsc = 0
//								end if
//								
//								// Se recuperan los salones disponibles según el cupo recuperado en el criterio criterio y el nivel del ciclo.   
//								//li_res = iuo_salones_servicios.of_existe_salon_esp(li_critcupoinsc, ls_nivel) 
//								li_res = iuo_salones_servicios.of_existe_salon_esp(iuo_salones_servicios.il_cupo_minimo, iuo_salones_servicios.il_cupo_maximo, ls_nivel) 
//
//								li_i = 1
//								if li_res > 0 then
//		
//									li_res = iuo_salones_servicios.of_asigna_salon_esp(lds_asigna_automatica_salon, li_critcupoinsc,ls_nivel,li_i,li_crit, le_vuelta)
//		
//									li_i += li_tothor
//									if li_res >= 0 then 
//										li_asigparc += li_res
//										li_totasig += li_res
//										st_porcentaje.text = "Asignados "+string(li_totasig)+" de "+string(li_tot)
//									end if
//										
//								end if
//							end if
//							li_res = dw_external_reporte.InsertRow(0)
//							dw_external_reporte.SetItem(li_res,1,li_crit)
//							dw_external_reporte.SetItem(li_res,2,li_cat)
//							//dw_external_reporte.SetItem(li_res,3,li_niv)
//							dw_external_reporte.SetItem(li_res,3,ls_nivel) 
//							dw_external_reporte.SetItem(li_res,4,li_totparc)
//							dw_external_reporte.SetItem(li_res,5,li_asigparc)
//							dw_external_reporte.SetItem(li_res,6,li_tot)
//							dw_external_reporte.Scroll(1)
//							//li_res = lds_asigna_automatica_salon.retrieve(gi_anio, gi_periodo)
//							lds_asigna_automatica_salon.dataobject = "d_asigna_automatica_salon"
//							lds_asigna_automatica_salon.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'")
//							lds_asigna_automatica_salon.SetTransObject(gtr_sce)
//							li_res = lds_asigna_automatica_salon.retrieve(gi_anio, gi_periodo)
//						
//							
//					end if 
//						
//					
//				next // Ciclo de cliterios ( De 1 a 4 Según se describen en el layout) 
//				
//			next // Ciclo de Categoria
//		
//		NEXT //BLOQUE 	
//		// BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE 						
//		// BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE BLOQUE 		
//		
//		//*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*/
//		//*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*///*/*/*/*/*/		
//		
//	next // Ciclo de nivel 
//elseif li_res = 0 then
//	MessageBox("Atencion","No hay grupos normales sin salón asignado")
//else
//	MessageBox("Atencion","Error en la consulta de grupos normales sin salon asignado")
//end if
//DESTROY lds_asigna_automatica_salon
//DESTROY lds_salones_existentes
//
//
//st_asignacion.TEXT = st_asignacion.TEXT + "    FIN: " + STRING(NOW())
//
//MESSAGEBOX("Aviso", "Asignación terminada.") 
//
//RETURN 0 
//

// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 
// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 
// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 
// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 










end function

on w_asigna_automatica_salon.create
this.cbx_asignacion_especial=create cbx_asignacion_especial
this.st_2=create st_2
this.st_1=create st_1
this.cbx_actualiza_clase_aula=create cbx_actualiza_clase_aula
this.st_asignacion=create st_asignacion
this.st_precarga=create st_precarga
this.cb_preproceso=create cb_preproceso
this.cb_imprime=create cb_imprime
this.dw_external_reporte=create dw_external_reporte
this.cb_empieza=create cb_empieza
this.st_pasos=create st_pasos
this.st_informacion=create st_informacion
this.oval_1=create oval_1
this.st_inf_criterio=create st_inf_criterio
this.st_inf_categorias=create st_inf_categorias
this.st_porcentaje=create st_porcentaje
this.rb_inscritos=create rb_inscritos
this.rb_cupo=create rb_cupo
this.uo_1=create uo_1
this.gb_criterio=create gb_criterio
this.ln_1=create ln_1
this.oval_2=create oval_2
this.Control[]={this.cbx_asignacion_especial,&
this.st_2,&
this.st_1,&
this.cbx_actualiza_clase_aula,&
this.st_asignacion,&
this.st_precarga,&
this.cb_preproceso,&
this.cb_imprime,&
this.dw_external_reporte,&
this.cb_empieza,&
this.st_pasos,&
this.st_informacion,&
this.oval_1,&
this.st_inf_criterio,&
this.st_inf_categorias,&
this.st_porcentaje,&
this.rb_inscritos,&
this.rb_cupo,&
this.uo_1,&
this.gb_criterio,&
this.ln_1,&
this.oval_2}
end on

on w_asigna_automatica_salon.destroy
destroy(this.cbx_asignacion_especial)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cbx_actualiza_clase_aula)
destroy(this.st_asignacion)
destroy(this.st_precarga)
destroy(this.cb_preproceso)
destroy(this.cb_imprime)
destroy(this.dw_external_reporte)
destroy(this.cb_empieza)
destroy(this.st_pasos)
destroy(this.st_informacion)
destroy(this.oval_1)
destroy(this.st_inf_criterio)
destroy(this.st_inf_categorias)
destroy(this.st_porcentaje)
destroy(this.rb_inscritos)
destroy(this.rb_cupo)
destroy(this.uo_1)
destroy(this.gb_criterio)
destroy(this.ln_1)
destroy(this.oval_2)
end on

event open;
// Se crea e inicializa objeto de servicio de niveles.
iuo_nivel_servicios = CREATE uo_nivel_servicios 

iuo_nivel_servicios.f_carga_niveles( gtr_sce)

iuo_salones_servicios = CREATE uo_salones_servicios 

// Se recupera el periodo de alta de grupos
 f_obten_periodo(ii_periodo, ii_anio, 4)
 
//ii_anio = 2019 
//ii_periodo = 0 
 
 
THIS.uo_1.em_ani.text = string(ii_anio)
THIS.uo_1.em_per.text = string(ii_periodo)

THIS.uo_1.ie_anio = ii_anio 
THIS.uo_1.ie_periodo = ii_periodo   
//THIS.uo_1.TRIGGEREVENT("ue_modifica") 
end event

type cbx_asignacion_especial from checkbox within w_asigna_automatica_salon
integer x = 50
integer y = 392
integer width = 1819
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Asignación Especial "
boolean checked = true
end type

type st_2 from statictext within w_asigna_automatica_salon
integer x = 64
integer y = 1572
integer width = 741
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tiempo Asignación: "
boolean focusrectangle = false
end type

type st_1 from statictext within w_asigna_automatica_salon
integer x = 64
integer y = 1476
integer width = 741
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tiempo Preprocesamiento: "
boolean focusrectangle = false
end type

type cbx_actualiza_clase_aula from checkbox within w_asigna_automatica_salon
integer x = 50
integer y = 312
integer width = 1819
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Actualizar clase aula ~"Por Asignar~" a ~"Salón~""
end type

type st_asignacion from statictext within w_asigna_automatica_salon
integer x = 795
integer y = 1572
integer width = 1074
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_precarga from statictext within w_asigna_automatica_salon
integer x = 800
integer y = 1476
integer width = 1074
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_preproceso from commandbutton within w_asigna_automatica_salon
integer x = 745
integer y = 1668
integer width = 503
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Preproceso"
end type

event clicked;

// Se verifica si se actualiza el Tipo de Aula. 
IF cbx_actualiza_clase_aula.CHECKED THEN 
	
	STRING ls_error 
	
	UPDATE horario 
	SET clase_aula = 0 
	WHERE clase_aula = 4 
	USING gtr_sce; 
	IF gtr_sce.SQLCODE < 0 THEN  
		ls_error = "Se produjo un error al actualizar la clase de aula en la tabla horario: " + gtr_sce.SQLERRTEXT 
		ROLLBACK USING gtr_sce;  
		MESSAGEBOX("Error", ls_error) 
		RETURN -1 
	END IF 
	COMMIT USING gtr_sce; 
	
END IF



iuo_salones_servicios.ie_anio = ii_anio
iuo_salones_servicios.ie_periodo = ii_periodo
iuo_salones_servicios.of_carga_horarios() 

st_precarga.TEXT = " INICIO: " + STRING(NOW() ) 
IF iuo_salones_servicios.of_genera_id_horarios() < 0 THEN RETURN -1
st_precarga.TEXT = st_precarga.TEXT + "  FIN: " + STRING(NOW() ) 

//iuo_salones_servicios.ie_anio = gi_anio
//iuo_salones_servicios.ie_periodo = gi_periodo
IF iuo_salones_servicios.of_genera_salon_horario() < 0 THEN RETURN -1 

//// Se apartan los salones previamente asignado.
//iuo_salones_servicios.of_salones_preasignados()


MESSAGEBOX("Aviso", "Preproceso de asignación terminado.")	

cb_empieza.ENABLED = TRUE 




end event

type cb_imprime from commandbutton within w_asigna_automatica_salon
integer x = 3886
integer y = 1828
integer width = 613
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprime Reporte"
end type

event clicked;if isvalid(dw_external_reporte) then
	dw_external_reporte.modify("Datawindow.print.preview = Yes")
	SetPointer(HourGlass!)
	openwithparm(conf_impr,dw_external_reporte)
end if
end event

type dw_external_reporte from datawindow within w_asigna_automatica_salon
integer x = 1911
integer y = 28
integer width = 2597
integer height = 1772
integer taborder = 30
string dataobject = "d_external_reporte"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_empieza from commandbutton within w_asigna_automatica_salon
integer x = 1321
integer y = 1672
integer width = 503
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Asignación"
end type

event clicked;
// Se pide confirmación de periodos vigentes.
IF cbx_asignacion_especial.CHECKED THEN 
	OPENWITHPARM(w_confirmacion_asig_salones, 'S') 
	IF message.doubleparm = 1 THEN RETURN 0	
	
	// Se apartan los salones previamente asignado.
	iuo_salones_servicios.of_salones_preasignados()
	
	iuo_salones_servicios.of_carga_asig_especial() 
	wf_asignacion_especial() 
	RETURN 0 
ELSE 
	OPENWITHPARM(w_confirmacion_asig_salones, 'N') 
	IF message.doubleparm = 1 THEN RETURN 0		
END IF 	


// Comienza proceso de asignación.
datastore lds_asigna_automatica_salon,lds_salones_existentes
int li_crit, li_cat, li_niv, li_tot, li_totparc, li_critcupoinsc, li_tothor, li_asigparc
int li_ret, li_res, li_i, li_j, li_totasig, li_total_niveles
int li_limiteinf[5], li_limitesup[5], li_cupoinsc[5]
string ls_enbasea, ls_nivel 

STRING ls_sql 

st_asignacion.TEXT = "Inicio: " + STRING(NOW())

ls_sql = " SELECT	horario.cve_mat, horario.gpo, horario.anio,horario.periodo,  horario.cve_dia,   horario.cve_salon,   horario.hora_inicio, " + &    
			" horario.hora_final, grupos.cupo, grupos.inscritos, materias.nivel, materias.materia, dias.dia, grupos.forma_imparte, " + &    
			" grupos.fecha_inicio, grupos.fecha_fin " + &    
			" FROM grupos, horario, materias, dias   " + &    
			" WHERE ( grupos.cve_mat = horario.cve_mat ) and   " + &    
			" 	  ( grupos.gpo = horario.gpo ) and   " + &    
			" 	  ( grupos.periodo = horario.periodo ) and   " + &    
			" 	  ( grupos.anio = horario.anio ) and  " + &    
			" 	  ( grupos.cve_mat = materias.cve_mat ) and  " + &    
			" 	  ( horario.cve_dia = dias.cve_dia ) and " + &    
			" 	  ( ( grupos.cond_gpo = 1 ) AND   " + &    
			" 	  ( horario.cve_salon is NULL ) AND   " + &    
			" 	  ( grupos.tipo = 0 ) AND   " + &    
			" 	  ( horario.clase_aula = 0 ) AND   " + &    
			" 	  ( grupos.anio = " + STRING(ii_anio) + " ) AND     " + &    
			" 	  ( grupos.periodo = " + STRING(ii_periodo) + " ))  " + &    
			" 	  AND grupos.forma_imparte = 1  " + &    
			" UNION 			 " + &    
			" SELECT horario_modular.cve_mat, horario_modular.gpo, horario_modular.anio, horario_modular.periodo, horario_modular.cve_dia, horario_modular.cve_salon, horario.hora_inicio,  " + &    
			" horario.hora_final, grupos.cupo, grupos.inscritos, materias.nivel, materias.materia, dias.dia, grupos.forma_imparte,  " + &    
			" grupos.fecha_inicio, grupos.fecha_fin " + &    
			" FROM grupos,  horario_modular , materias, dias, horario   " + &    
			" WHERE ( grupos.cve_mat = horario_modular.cve_mat ) and   " + &    
			" 	( grupos.gpo = horario_modular.gpo ) and   " + &    
			" 	( grupos.periodo = horario_modular.periodo ) and   " + &    
			" 	( grupos.anio = horario_modular.anio ) and  " + &    
			" 	( grupos.cve_mat = materias.cve_mat ) and  " + &    
			" 	( horario_modular.cve_dia = dias.cve_dia ) and " + &    
			" 	( ( grupos.cond_gpo = 1 ) AND   " + &    
			" 	( horario_modular.cve_salon is NULL ) AND   " + &    
			" 	( grupos.tipo = 0 ) AND   " + &    
			" 	( grupos.anio = " + STRING(ii_anio) + " ) AND   " + &    
			" 	( grupos.periodo = " + STRING(ii_periodo) + " ))  " + &    
			" 	AND grupos.forma_imparte = 2  " + &    
			" 	AND EXISTS (SELECT * FROM horario  " + &    
			" 				WHERE grupos.cve_mat = horario.cve_mat  " + &    
			" 				AND grupos.gpo = horario.gpo  " + &    
			" 				AND grupos.periodo = horario.periodo  " + &    
			" 				AND grupos.anio = horario.anio  " + &    
			" 				AND horario.clase_aula = 0)  " + & 
			" 	AND horario_modular.cve_mat = horario.cve_mat  " + &    
			" 	AND horario_modular.gpo = horario.gpo  " + &    
			" 	AND horario_modular.periodo = horario.periodo  " + &    
			" 	AND horario_modular.anio = horario.anio  " + &    
			" 	AND horario_modular.cve_dia = horario.cve_dia  " + &    
			" 	AND horario_modular.hora_inicio = horario.hora_inicio "			

//string ls_descnivel[3],ls_descnivel2[3]
//li_limiteinf = {45,34,25,11,0}
//li_limitesup = {99,44,33,24,10}
//li_cupoinsc = {60,40,30,20,10}
f_llena_configuracion_asignacion_salones(li_limiteinf,li_limitesup,li_cupoinsc)
//ls_descnivel = {"'L'","'P'","'C'"}	
//ls_descnivel2 = {"L","P","C"}	
li_totasig = 0
if rb_inscritos.checked = true then
	ls_enbasea = "grupos_inscritos"
	li_limiteinf[5] = 1
else
	ls_enbasea = "grupos_cupo"
end if
dw_external_reporte.reset()
//Preguntar si son correctas las opciones de anio, periodo y en base a que, . . .

// Se recupera el total de niveles
li_total_niveles = iuo_nivel_servicios.ids_niveles.ROWCOUNT() 
// Se incrementa el total para considerar el nivel 'Cualquiera'
li_total_niveles ++

lds_asigna_automatica_salon = CREATE datastore
lds_asigna_automatica_salon.dataobject = "d_asigna_automatica_salon"
lds_asigna_automatica_salon.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'")
lds_asigna_automatica_salon.SetTransObject(gtr_sce)
lds_salones_existentes = CREATE datastore
lds_salones_existentes.dataobject = "d_salones_existentes"
lds_salones_existentes.SetTransObject(gtr_sce)
li_res = lds_asigna_automatica_salon.retrieve(ii_anio, ii_periodo)
if li_res > 0 then
	li_tot = li_res
	st_porcentaje.text = "Asignados 0 de "+string(li_tot)
	
	// Ciclo de nivel ("L", "P", "C")  
	//for li_niv = 1 to 3 
	for li_niv = 1 to li_total_niveles 
		
		IF li_niv = li_total_niveles THEN 
			ls_nivel = 'C' 
		ELSE
			ls_nivel = iuo_nivel_servicios.ids_niveles.GETITEMSTRING(li_niv, "cve_nivel")
		END IF
		
		// Ciclo de Categoria (Categoria de Cupo en salones) 
		for li_cat = 1 to 5
			
			// Ciclo de cliterios ( De 1 a 4 Según se describen en el layout) 
			for li_crit = 1 to 4 	/*Nue Cambio FMC Jun2006*/
				
				if (li_crit >= 3 and li_niv = 3) or li_crit < 3 then 		/*Nue Cambio FMC Jun2006*/
				
					//st_pasos.text = "Usando criterio " + string(li_crit) + " para categoría " + string(li_cat) + " del nivel " + ls_descnivel2[li_niv] 
					st_pasos.text = "Usando criterio " + string(li_crit) + " para categoría " + string(li_cat) + " del nivel " + ls_nivel 
					
					li_totparc = 0
					
					// Filtra los grupos por asignar por Inscritos o por cupo de los grupos y por la capacidad de los salones. 
//					lds_asigna_automatica_salon.SetFilter(ls_enbasea&
//					+ ' BETWEEN '+string(li_limiteinf[li_cat])+' AND ' + string(li_limitesup[li_cat])&
//					+ ' AND (materias_nivel = '+ ls_descnivel[li_niv]+"OR 'C' = "+ls_descnivel[li_niv]+")")
					lds_asigna_automatica_salon.SetFilter(ls_enbasea + " BETWEEN "+string(li_limiteinf[li_cat])+" AND " + string(li_limitesup[li_cat]) + " AND (materias_nivel = '"+ ls_nivel +"' OR 'C' = '"+ ls_nivel +"' ) ") 
  					li_res = lds_asigna_automatica_salon.Filter()

//					lds_asigna_automatica_salon.SetSort(ls_enbasea + ' D, horario_cve_mat A, horario_gpo A')	
//					lds_asigna_automatica_salon.Sort()
//					lds_asigna_automatica_salon.GroupCalc()
					lds_asigna_automatica_salon.SetSort(ls_enbasea + ' D, totalhorario D, horario_cve_mat A, horario_gpo A')	/*Nue Cambio FMC Jun2006*/
					lds_asigna_automatica_salon.Sort()																								/*Nue Cambio FMC Jun2006*/
					lds_asigna_automatica_salon.GroupCalc()																						/*Nue Cambio FMC Jun2006*/
					
					li_totparc = lds_asigna_automatica_salon.RowCount()
					li_asigparc = 0
					
					if li_totparc > 0 then
						
						// Se verifica el criterio actual del ciclo 
						if li_crit = 1 then
							li_critcupoinsc = li_cupoinsc[li_cat]
						elseif li_crit = 2 then
							if li_cat = 1 then
								li_critcupoinsc = li_cupoinsc[li_cat]
							else
								li_critcupoinsc = li_cupoinsc[li_cat - 1]
							end if
						else
							li_critcupoinsc = 0
						end if
						
						// Se recuperan los salones disponibles según el cupo recuperado en el criterio criterio y el nivel del ciclo.   
						//li_res = lds_salones_existentes.Retrieve(li_critcupoinsc,ls_descnivel2[li_niv])
						li_res = lds_salones_existentes.Retrieve(li_critcupoinsc,ls_nivel) 
						li_i = 1
						if li_res > 0 then
							//do while li_i <= li_totparc
								
								// Se toma el total de registros en 
								//li_tothor = lds_asigna_automatica_salon.GetItemNumber(li_i,"totalhorario")
//								li_res = F_Asigna_Salon(lds_asigna_automatica_salon, li_critcupoinsc,ls_nivel,li_i,li_crit) 
								li_res = iuo_salones_servicios.of_asigna_salon(lds_asigna_automatica_salon, li_critcupoinsc,ls_nivel,li_i,li_crit)

								li_i += li_tothor
								if li_res >= 0 then 
									li_asigparc += li_res
									li_totasig += li_res
									st_porcentaje.text = "Asignados "+string(li_totasig)+" de "+string(li_tot)
								end if
								
							//loop
						end if
					end if
					li_res = dw_external_reporte.InsertRow(0)
					dw_external_reporte.SetItem(li_res,1,li_crit)
					dw_external_reporte.SetItem(li_res,2,li_cat)
					//dw_external_reporte.SetItem(li_res,3,li_niv)
					dw_external_reporte.SetItem(li_res,3,ls_nivel) 
					dw_external_reporte.SetItem(li_res,4,li_totparc)
					dw_external_reporte.SetItem(li_res,5,li_asigparc)
					dw_external_reporte.SetItem(li_res,6,li_tot)
					dw_external_reporte.Scroll(1)
					li_res = lds_asigna_automatica_salon.retrieve(ii_anio, ii_periodo)
				end if
				//MessageBox("",string(li_totparc)+" "+string(li_asigparc))
			next
		next
	next 
elseif li_res = 0 then
	MessageBox("Atencion","No hay grupos normales sin salón asignado")
else
	MessageBox("Atencion","Error en la consulta de grupos normales sin salon asignado")
end if
DESTROY lds_asigna_automatica_salon
DESTROY lds_salones_existentes


st_asignacion.TEXT = st_asignacion.TEXT + "    FIN: " + STRING(NOW())

MESSAGEBOX("Aviso", "Asignación terminada.") 

RETURN 0

// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 
// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 


// Se pide confirmación de periodos vigentes.
OPEN(w_confirmacion_asig_salones)
IF message.doubleparm = 1 THEN RETURN 0


// Comienza proceso de asignación.
//datastore lds_asigna_automatica_salon,lds_salones_existentes
//int li_crit, li_cat, li_niv, li_tot, li_totparc, li_critcupoinsc, li_tothor, li_asigparc
//int li_ret, li_res, li_i, li_j, li_totasig
//int li_limiteinf[5], li_limitesup[5], li_cupoinsc[5]
//string ls_enbasea
string ls_descnivel[3],ls_descnivel2[3]
//li_limiteinf = {45,34,25,11,0}
//li_limitesup = {99,44,33,24,10}
//li_cupoinsc = {60,40,30,20,10}
f_llena_configuracion_asignacion_salones(li_limiteinf,li_limitesup,li_cupoinsc)
ls_descnivel = {"'L'","'P'","'C'"}	
ls_descnivel2 = {"L","P","C"}	
li_totasig = 0
if rb_inscritos.checked = true then
	ls_enbasea = "grupos_inscritos"
	li_limiteinf[5] = 1
else
	ls_enbasea = "grupos_cupo"
end if
dw_external_reporte.reset()
//Preguntar si son correctas las opciones de anio, periodo y en base a que, . . .


lds_asigna_automatica_salon = CREATE datastore
lds_asigna_automatica_salon.dataobject = "d_asigna_automatica_salon"
lds_asigna_automatica_salon.SetTransObject(gtr_sce)
lds_salones_existentes = CREATE datastore
lds_salones_existentes.dataobject = "d_salones_existentes"
lds_salones_existentes.SetTransObject(gtr_sce)
li_res = lds_asigna_automatica_salon.retrieve(ii_anio, ii_periodo)
if li_res > 0 then
	li_tot = li_res
	st_porcentaje.text = "Asignados 0 de "+string(li_tot)
	
	// Ciclo de nivel ("L", "P", "C")  
	for li_niv = 1 to 3 
		
		// Ciclo de Categoria (Categoria de Cupo en salones) 
		for li_cat = 1 to 5
			//for li_crit = 1 to 3 	/*Ant Cambio FMC Jun2006*/
			
			// Ciclo de cliterios ( De 1 a 4 Según se describen en el layout) 
			for li_crit = 1 to 4 	/*Nue Cambio FMC Jun2006*/
				//if (li_crit = 3 and li_niv = 3) or li_crit < 3 then 	/*Ant Cambio FMC Jun2006*/
				
				if (li_crit >= 3 and li_niv = 3) or li_crit < 3 then 		/*Nue Cambio FMC Jun2006*/
					st_pasos.text = "Usando criterio " + string(li_crit) + &
						" para categoría " + string(li_cat) + " del nivel " + ls_descnivel2[li_niv]
					li_totparc = 0
					lds_asigna_automatica_salon.SetFilter(ls_enbasea&
					+ ' BETWEEN '+string(li_limiteinf[li_cat])+' AND ' + string(li_limitesup[li_cat])&
					+ ' AND (materias_nivel = '+ ls_descnivel[li_niv]+"OR 'C' = "+ls_descnivel[li_niv]+")")
					li_res = lds_asigna_automatica_salon.Filter()
	//				MessageBox("",ls_enbasea&
	//				+ ' BETWEEN '+string(li_limiteinf[li_cat])+' AND ' + string(li_limitesup[li_cat])&
	//				+ ' AND materias_nivel <> '+ ls_descnivel[li_niv] +" "+string(li_res))
					lds_asigna_automatica_salon.SetSort(ls_enbasea + ' D, horario_cve_mat A, horario_gpo A')	
					lds_asigna_automatica_salon.Sort()
					lds_asigna_automatica_salon.GroupCalc()
					lds_asigna_automatica_salon.SetSort(ls_enbasea + ' D, totalhorario D, horario_cve_mat A, horario_gpo A')	/*Nue Cambio FMC Jun2006*/
					lds_asigna_automatica_salon.Sort()																								/*Nue Cambio FMC Jun2006*/
					lds_asigna_automatica_salon.GroupCalc()																						/*Nue Cambio FMC Jun2006*/
					
					li_totparc = lds_asigna_automatica_salon.RowCount()
					li_asigparc = 0
					if li_totparc > 0 then
						if li_crit = 1 then
							li_critcupoinsc = li_cupoinsc[li_cat]
						elseif li_crit = 2 then
							if li_cat = 1 then
								li_critcupoinsc = li_cupoinsc[li_cat]
							else
								li_critcupoinsc = li_cupoinsc[li_cat - 1]
							end if
						else
							li_critcupoinsc = 0
						end if
						li_res = lds_salones_existentes.Retrieve(li_critcupoinsc,ls_descnivel2[li_niv])
						li_i = 1
						if li_res > 0 then
							do while li_i <= li_totparc
								li_tothor = lds_asigna_automatica_salon.GetItemNumber(li_i,"totalhorario")
								li_res = F_Asigna_Salon(lds_asigna_automatica_salon,&
								li_critcupoinsc,ls_descnivel2[li_niv],li_i,li_crit)
								li_i += li_tothor
								if li_res >= 0 then 
									li_asigparc += li_res
									li_totasig += li_res
									st_porcentaje.text = "Asignados "+string(li_totasig)+" de "+string(li_tot)
								end if
							loop
						end if
					end if
					li_res = dw_external_reporte.InsertRow(0)
					dw_external_reporte.SetItem(li_res,1,li_crit)
					dw_external_reporte.SetItem(li_res,2,li_cat)
					dw_external_reporte.SetItem(li_res,3,li_niv)
					dw_external_reporte.SetItem(li_res,4,li_totparc)
					dw_external_reporte.SetItem(li_res,5,li_asigparc)
					dw_external_reporte.SetItem(li_res,6,li_tot)
					dw_external_reporte.Scroll(1)
					li_res = lds_asigna_automatica_salon.retrieve(ii_anio, ii_periodo)
				end if
				//MessageBox("",string(li_totparc)+" "+string(li_asigparc))
			next
		next
	next 
elseif li_res = 0 then
	MessageBox("Atencion","No hay grupos normales sin salón asignado")
else
	MessageBox("Atencion","Error en la consulta de grupos normales sin salon asignado")
end if
DESTROY lds_asigna_automatica_salon
DESTROY lds_salones_existentes

end event

type st_pasos from statictext within w_asigna_automatica_salon
integer x = 50
integer y = 656
integer width = 1490
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Usando criterio 0 para categoría 0 del nivel sin nivel."
boolean focusrectangle = false
end type

type st_informacion from statictext within w_asigna_automatica_salon
integer x = 603
integer y = 756
integer width = 608
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Información"
alignment alignment = center!
boolean focusrectangle = false
end type

type oval_1 from oval within w_asigna_automatica_salon
long linecolor = 79741120
integer linethickness = 3
long fillcolor = 65535
integer x = 78
integer y = 772
integer width = 370
integer height = 320
end type

type st_inf_criterio from statictext within w_asigna_automatica_salon
integer x = 302
integer y = 1164
integer width = 1371
integer height = 260
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Criterio 1  : Busca igual categoría, todos días Criterio 2  : Busca categoria superior, todos días  Criterio 3  : Cualquier categoría                     Criterio 4  : Cualquier categoría, cualquier día"
boolean focusrectangle = false
end type

type st_inf_categorias from statictext within w_asigna_automatica_salon
integer x = 471
integer y = 900
integer width = 1399
integer height = 220
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Criterio: igual cupo, cupo superior o cualquier cupo. Categoria: el rango de cupo o inscritos a buscar. Nivel: Licenciatura o Posgrado"
boolean focusrectangle = false
end type

type st_porcentaje from statictext within w_asigna_automatica_salon
integer x = 55
integer y = 560
integer width = 759
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Asignados 0 de 0."
boolean focusrectangle = false
end type

type rb_inscritos from radiobutton within w_asigna_automatica_salon
integer x = 1362
integer y = 176
integer width = 315
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Inscritos"
boolean checked = true
end type

type rb_cupo from radiobutton within w_asigna_automatica_salon
integer x = 1362
integer y = 84
integer width = 251
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cupo"
end type

type uo_1 from uo_per_ani within w_asigna_automatica_salon
integer x = 27
integer y = 72
integer taborder = 10
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type gb_criterio from groupbox within w_asigna_automatica_salon
integer x = 1321
integer y = 8
integer width = 494
integer height = 276
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "En base a:"
end type

type ln_1 from line within w_asigna_automatica_salon
integer linethickness = 32
integer beginx = 261
integer beginy = 808
integer endx = 261
integer endy = 968
end type

type oval_2 from oval within w_asigna_automatica_salon
long linecolor = 79741120
integer linethickness = 3
integer x = 233
integer y = 996
integer width = 59
integer height = 56
end type

