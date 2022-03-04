$PBExportHeader$uo_reporte_dw_anterior.sru
forward
global type uo_reporte_dw_anterior from nonvisualobject
end type
end forward

global type uo_reporte_dw_anterior from nonvisualobject
end type
global uo_reporte_dw_anterior uo_reporte_dw_anterior

type variables
long il_detalles_insertados= 0, il_rows_saltados=0, il_tamanio_array=0, il_rows_detalle_reporte=0
long il_rows_datawindow=0, il_row_datawindow=0, il_rows_primer_pagina=0, il_rows_n_paginas=0
long il_pagina_actual= 0, il_tamanio_array_inicio= 0
u_datastore ids_documento_reporte, ids_cuerpo_reporte, ids_detalle_reporte, ids_solicitud_certificado,ids_solicitud_cert_sin_status

n_cortes in_cortes

end variables

forward prototypes
public function integer f_obten_revision_estudios (long al_cuenta, long al_cve_carrera, long al_cve_plan, ref blob ablob_materias_historico, ref blob ablob_revision_estudios)
public function integer f_genera_bloque_cert_sin_status (datetime adttm_fecha_inicial, datetime adttm_fecha_final, integer ai_cve_doc_control_sep, string as_nivel, integer ai_legalizado, integer ai_origen_internet)
public function integer f_revisa_corte (integer ai_cve_tipo_doc_reporte, long al_renglon_datos, u_datastore adw_datawindow, long al_cuenta, boolean ab_fin_cuerpo_con_registro, long al_cve_carrera)
public function integer f_revisa_corte (integer ai_cve_tipo_doc_reporte, long al_renglon_datos, datawindow adw_datawindow, long al_cuenta, boolean ab_fin_cuerpo_con_registro, long al_cve_carrera)
public function integer f_borra_cuerpo (integer ai_cve_tipo_doc_rep, long al_cuenta, long al_cve_carrera)
public function integer f_inserta_certificado (long al_cuenta, long al_cve_carrera, long al_cve_plan, long al_cve_doc_control_sep, long al_legalizado, datetime adttm_fecha_solicitud)
public function integer f_genera_cuerpo (integer ai_cve_tipo_documento, u_datastore adw_datatawindow, long al_cuenta, boolean ab_permite_lineas_vacias, string as_array_fin_cuerpo[], boolean ab_fin_cuerpo_con_registro, string as_array_inicio_cuerpo[], long al_cve_carrera)
public function integer f_genera_bloque_certificados (datetime adttm_fecha_inicial, datetime adttm_fecha_final, integer ai_cve_doc_control_sep, string as_nivel, integer ai_legalizado, integer ai_origen_internet)
public function integer f_genera_cuerpo (integer ai_cve_tipo_documento, datawindow adw_datatawindow, long al_cuenta, boolean ab_permite_lineas_vacias, ref string as_array_fin_cuerpo[], boolean ab_fin_cuerpo_con_registro, string as_array_inicio_cuerpo[], long al_cve_carrera)
public function integer f_obten_cve_tipo_documento (long al_cve_plan, string as_nivel, boolean ab_legalizado)
public function integer f_aplica_certificados_impresos (datetime adttm_fecha_inicial, datetime adttm_fecha_final, integer ai_cve_doc_control_sep, string as_nivel, integer ai_legalizado, integer ai_origen_internet)
public function integer f_imprime_bloque_cert_sin_status (datetime adttm_fecha_inicial, datetime adttm_fecha_final, integer ai_cve_doc_control_sep, string as_nivel, integer ai_legalizado, integer ai_origen_internet, integer ai_aplica_pago, integer ai_egresa_completos)
public function integer f_imprime_bloque_certificados (datetime adttm_fecha_inicial, datetime adttm_fecha_final, integer ai_cve_doc_control_sep, string as_nivel, integer ai_legalizado, integer ai_origen_internet, integer ai_aplica_pago, integer ai_egresa_completos)
public function integer f_inserta_renglon (integer ai_cve_tipo_documento, long al_cuenta, string as_valor_renglon, long al_pagina_actual, long al_cve_carrera)
public function integer f_obten_separador (integer ai_cve_detalle_rep, ref integer ai_numero_bloque, ref string as_texto_bloque)
public function integer f_obten_separador (integer ai_cve_detalle_rep, integer ai_area_mat, ref integer ai_numero_bloque, ref string as_texto_bloque)
public function integer f_revisa_corte_cert (integer ai_cve_tipo_doc_reporte, long al_renglon_datos, datawindow adw_datawindow, long al_cuenta, boolean ab_fin_cuerpo_con_registro, long al_cve_carrera, ref string as_array_fin_cuerpo[])
public function integer f_obten_renglon_datos (long al_row_datos, datawindow adw_datatawindow, ref string as_valor_renglon)
public function integer f_obten_renglon_datos (long al_row_datos, u_datastore adw_datatawindow, ref string as_valor_renglon)
public function integer f_revisa_corte_cert (integer ai_cve_tipo_doc_reporte, long al_renglon_datos, u_datastore adw_datawindow, long al_cuenta, boolean ab_fin_cuerpo_con_registro, long al_cve_carrera, ref string as_array_fin_cuerpo[])
end prototypes

public function integer f_obten_revision_estudios (long al_cuenta, long al_cve_carrera, long al_cve_plan, ref blob ablob_materias_historico, ref blob ablob_revision_estudios);//f_obten_revision_estudios
//Recibe:  al_cuenta			long
//			al_cve_carrera		long
//			al_cve_plan			long

u_datastore lds_materias_historico, lds_revision_estudios
long ll_materias_historico, ll_revision_estudios, ll_cve_subsistema
blob lblob_revision_estudios, lblob_materias_historico
boolean lb_rev
string ls_nivel
integer lsf_revision_estudios, lsf_materias_historico

lds_materias_historico = CREATE u_datastore
lds_revision_estudios = CREATE u_datastore

lds_materias_historico.dataobject = "dw_certificado_ext2"
lds_revision_estudios.dataobject = "dw_rev_est_fmc"

lds_materias_historico.SetTransObject(gtr_sce)
lds_revision_estudios.SetTransObject(gtr_sce)

ll_materias_historico = lds_materias_historico.Rowcount() 
ll_revision_estudios = lds_revision_estudios.Rowcount() 

ll_cve_subsistema = f_obten_subsistema(al_cuenta, al_cve_carrera, al_cve_plan)

ls_nivel = f_obten_nivel_carrera(al_cve_carrera)


lds_materias_historico.Reset() 
lds_revision_estudios.Reset() 

lb_rev = hist_alumno_areas_fs(al_cuenta, al_cve_carrera, al_cve_plan, ll_cve_subsistema, lds_materias_historico, lds_revision_estudios, ls_nivel, lblob_materias_historico, lblob_revision_estudios)
	
lsf_materias_historico = lds_materias_historico.SetFullState(lblob_materias_historico)
lsf_revision_estudios = lds_revision_estudios.SetFullState(lblob_revision_estudios)

ablob_materias_historico = lblob_materias_historico
ablob_revision_estudios = lblob_revision_estudios

return 0






end function

public function integer f_genera_bloque_cert_sin_status (datetime adttm_fecha_inicial, datetime adttm_fecha_final, integer ai_cve_doc_control_sep, string as_nivel, integer ai_legalizado, integer ai_origen_internet);//f_genera_bloque_cert_sin_status
//Recibe:	adttm_fecha_inicial		datetime
//				adttm_fecha_final			datetime
//				ai_cve_doc_control_sep	integer
//				as_nivel						string
//				ai_legalizado				integer
//				ai_origen_internet		integer
//
//Genera un bloque de certificados en base a los parametros recibidos
//
//Regresa:	integer
long ll_rows

ids_solicitud_certificado.dataobject = "d_bloque_cert_sin_status"
ids_solicitud_certificado.SetTransObject(gtr_sce)

ll_rows = f_genera_bloque_certificados(adttm_fecha_inicial, adttm_fecha_final, ai_cve_doc_control_sep, as_nivel, ai_legalizado, ai_origen_internet)

return ll_rows


end function

public function integer f_revisa_corte (integer ai_cve_tipo_doc_reporte, long al_renglon_datos, u_datastore adw_datawindow, long al_cuenta, boolean ab_fin_cuerpo_con_registro, long al_cve_carrera);//// f_revisa_corte
//ai_cve_tipo_doc_reporte		integer
//al_renglon_datos				long
//adw_datawindow					u_datastore
//al_cuenta						long
//ab_fin_cuerpo_con_registro	boolean
//al_cve_carrera					long

// Revisa si es momento de poner un corte del reporte
long ll_rows_detalle_reporte, ll_row_linea_separadora, ll_renglon_de_separacion_pg1, ll_valor_columna_dw
long ll_valor_long, ll_valor_long_ant, ll_columna_dw, ll_row_insertado, ll_renglon_real_datos
long ll_rows_cuerpo, ll_row_sig_cuerpo, ll_row_sig_cuerpo_mas_array, ll_rows_complementarios
long ll_row_complementario, x, ll_mod_renglon_relativo
string ls_renglon_de_separacion, ls_tipo_pb, ls_texto_bloque_separador, ls_valor_columna_dw
string ls_valor_string, ls_valor_string_ant, ls_texto_complementario
long ll_mod_sumados, ll_mod_sin_sumar, ll_actual_dw, ll_renglon_de_separacion_pgn
ll_rows_detalle_reporte = il_rows_detalle_reporte
ls_texto_complementario = ""


//Si existe una linea separadora definida en la primer pagina

ll_row_linea_separadora =ids_detalle_reporte.Find( "cve_tipo_detalle_rep= 1", 1, ll_rows_detalle_reporte)

if ll_row_linea_separadora>0 then
	ll_rows_cuerpo = ids_cuerpo_reporte.RowCount()
	ls_renglon_de_separacion = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "valor_columna_dw")
	ls_tipo_pb = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "tipo_pb")
	if ls_tipo_pb = "long" or  ls_tipo_pb = "int" or ls_tipo_pb = "integer" then
		ll_renglon_de_separacion_pg1 = long(ls_renglon_de_separacion)
		il_rows_primer_pagina = ll_renglon_de_separacion_pg1
//Siguiente renglon a procesar
		ll_row_sig_cuerpo = ll_rows_cuerpo+1
//Siguiente renglon a procesar mas las lineas añadidas al final en el array
		ll_row_sig_cuerpo_mas_array= ll_rows_cuerpo + 1 + il_tamanio_array 
		if ll_renglon_de_separacion_pg1>= ll_rows_cuerpo then
//Determinar si es el ultimo renglon y el final del cuerpo (array de strings) quedaria en la pagina
			if il_row_datawindow=il_rows_datawindow and &
				mod(ll_row_sig_cuerpo,ll_renglon_de_separacion_pg1) > 0 then
				x= 1
				ll_mod_sumados = mod(ll_row_sig_cuerpo_mas_array + il_detalles_insertados, ll_renglon_de_separacion_pg1) 
				ll_mod_sin_sumar = mod(ll_row_sig_cuerpo + il_detalles_insertados, ll_renglon_de_separacion_pg1)
//Si no se quieren registros sin leyenda final y
//Si el siguiente renglon mas el array, se va a la siguiente pagina
				if ab_fin_cuerpo_con_registro and &
				   mod(ll_row_sig_cuerpo_mas_array , ll_renglon_de_separacion_pg1) < mod(ll_row_sig_cuerpo, ll_renglon_de_separacion_pg1) then
					ll_mod_renglon_relativo = mod(ll_row_sig_cuerpo, ll_renglon_de_separacion_pg1)
					ll_rows_complementarios = 	ll_renglon_de_separacion_pg1 - ll_mod_renglon_relativo 
					ls_texto_bloque_separador = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "texto_bloque")
//Inserta una linea separadora
					ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_doc_reporte)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", ls_texto_bloque_separador)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
					il_pagina_actual = il_pagina_actual +1
//Inserta lineas complementarias por cada renglon que faltaba
					for ll_row_complementario= 1 to ll_rows_complementarios
						ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_doc_reporte)
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", ls_texto_complementario)			
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
					next
				end if	
//Si el siguiente renglon es el ultimo de la pagina				
			elseif mod(ll_row_sig_cuerpo,ll_renglon_de_separacion_pg1) = 0 then
				ls_texto_bloque_separador = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "texto_bloque")
//Inserta un renglon separador
				ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_doc_reporte)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", ls_texto_bloque_separador)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
				il_pagina_actual = il_pagina_actual +1
				il_detalles_insertados= il_detalles_insertados +1						
			end if
		end if	
	else
		MessageBox("Tipo de dato incorrecto","El tipo de dato ["+ls_tipo_pb+"] es incorrecto", StopSign!)
		return -1
	end if
end if

//Si existe una linea separadora definida en las demas paginas

ll_row_linea_separadora =ids_detalle_reporte.Find( "cve_tipo_detalle_rep= 2", 1, ll_rows_detalle_reporte)

if ll_row_linea_separadora>0 then
	ll_rows_cuerpo = ids_cuerpo_reporte.RowCount()
	ls_renglon_de_separacion = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "valor_columna_dw")
	ls_tipo_pb = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "tipo_pb")
	if ls_tipo_pb = "long" or  ls_tipo_pb = "int" or ls_tipo_pb = "integer" then
		ll_renglon_de_separacion_pgn = long(ls_renglon_de_separacion)
		il_rows_n_paginas = ll_renglon_de_separacion_pgn
//Siguiente renglon a procesar
		ll_row_sig_cuerpo = ll_rows_cuerpo+1
//Siguiente renglon a procesar mas las lineas añadidas al final en el array
		ll_row_sig_cuerpo_mas_array= ll_rows_cuerpo + 1 + il_tamanio_array 
		if il_rows_primer_pagina< ll_rows_cuerpo then
//Determinar si es el ultimo renglon y el final del cuerpo (array de strings) quedaria en la pagina
			if il_row_datawindow=il_rows_datawindow and &
				mod(ll_row_sig_cuerpo - il_rows_primer_pagina,ll_renglon_de_separacion_pgn) > 0 then
				x= 1
				ll_mod_sumados = mod(ll_row_sig_cuerpo_mas_array + il_detalles_insertados, ll_renglon_de_separacion_pgn) 
				ll_mod_sin_sumar = mod(ll_row_sig_cuerpo + il_detalles_insertados, ll_renglon_de_separacion_pgn)
//Si no se quieren registros sin leyenda final y
//Si el siguiente renglon mas el array, se va a la siguiente pagina
				if ab_fin_cuerpo_con_registro and &
				   mod(ll_row_sig_cuerpo_mas_array - il_rows_primer_pagina, ll_renglon_de_separacion_pgn) < mod(ll_row_sig_cuerpo - il_rows_primer_pagina, ll_renglon_de_separacion_pgn) then
					ll_mod_renglon_relativo = mod(ll_row_sig_cuerpo - il_rows_primer_pagina, ll_renglon_de_separacion_pgn)
					ll_rows_complementarios = 	ll_renglon_de_separacion_pgn - ll_mod_renglon_relativo 
					ls_texto_bloque_separador = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "texto_bloque")
//Inserta una linea separadora
					ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_doc_reporte)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", ls_texto_bloque_separador)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
					il_pagina_actual = il_pagina_actual +1
//Inserta lineas complementarias por cada renglon que faltaba
					for ll_row_complementario= 1 to ll_rows_complementarios
						ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_doc_reporte)
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", ls_texto_complementario)			
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
					next
				end if	
//Si el siguiente renglon es el ultimo de la pagina				
			elseif mod(ll_row_sig_cuerpo - il_rows_primer_pagina,ll_renglon_de_separacion_pgn) = 0 then
				ls_texto_bloque_separador = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "texto_bloque")
//Inserta un renglon separador
				ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_doc_reporte)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", ls_texto_bloque_separador)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
				il_pagina_actual = il_pagina_actual +1
				il_detalles_insertados= il_detalles_insertados +1						
			end if
		end if	
	else
		MessageBox("Tipo de dato incorrecto","El tipo de dato ["+ls_tipo_pb+"] es incorrecto", StopSign!)
		return -1
	end if
end if



//Si existe un cambio de valor en alguna columna que indique un encabezado
ll_row_linea_separadora =ids_detalle_reporte.Find( "cve_tipo_detalle_rep= 3", 1, ll_rows_detalle_reporte)
if ll_row_linea_separadora>0 then
	
	do while ll_row_linea_separadora >0
		ll_renglon_real_datos= al_renglon_datos - il_detalles_insertados - il_tamanio_array_inicio
		ll_renglon_real_datos= il_row_datawindow
		ll_columna_dw = ids_detalle_reporte.GetItemNumber(ll_row_linea_separadora, "columna_dw")
		ls_valor_columna_dw = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "valor_columna_dw")
		ls_tipo_pb = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "tipo_pb")
		ls_texto_bloque_separador = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "texto_bloque")
		if ls_tipo_pb = "long" or  ls_tipo_pb = "int" or ls_tipo_pb = "integer" then
			ll_valor_long = adw_datawindow.GetItemNumber(ll_renglon_real_datos, ll_columna_dw)
			ll_valor_columna_dw = long(ls_valor_columna_dw)
			if ll_renglon_real_datos > 1 then
				ll_valor_long_ant = adw_datawindow.GetItemNumber(ll_renglon_real_datos - 1, ll_columna_dw)		
			end if
			if ll_renglon_real_datos= 1 then
				//El valor del datawindow es igual al valor consultado
				if ll_valor_long = ll_valor_columna_dw then
					ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_doc_reporte)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", ls_texto_bloque_separador)					
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
					il_detalles_insertados= il_detalles_insertados +1
				end if
				//El valor del datawindow actual es diferente al anterior, pero igual al del corte
			elseif ll_valor_long <> ll_valor_long_ant and ll_valor_long= ll_valor_columna_dw then
				ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_doc_reporte)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", ls_texto_bloque_separador)				
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
				il_detalles_insertados= il_detalles_insertados +1				
			end if
		elseif ls_tipo_pb = "str" or  ls_tipo_pb = "string" then
			ls_valor_string = adw_datawindow.GetItemString(ll_renglon_real_datos, ll_columna_dw)		
			if ll_renglon_real_datos > 1 then
				ls_valor_string_ant = adw_datawindow.GetItemString(ll_renglon_real_datos - 1, ll_columna_dw)		
			end if
			if ll_renglon_real_datos= 1 then
				//El valor del datawindow es igual al valor consultado
				if ls_valor_string = ls_valor_columna_dw then
					ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_doc_reporte)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", ls_texto_bloque_separador)					
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
					il_detalles_insertados= il_detalles_insertados +1
				end if
				//El valor del datawindow actual es diferente al anterior, pero igual al del corte
			elseif ls_valor_string <> ls_valor_string_ant and ls_valor_string= ls_valor_columna_dw then
				ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_doc_reporte)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", ls_texto_bloque_separador)			
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
				il_detalles_insertados= il_detalles_insertados +1
			end if

		else
			MessageBox("Tipo de dato incorrecto","El tipo de dato ["+ls_tipo_pb+"] es incorrecto", StopSign!)
			return -1
		end if
		if ll_row_linea_separadora = ll_rows_detalle_reporte then
			ll_row_linea_separadora = 0
		else
			ll_row_linea_separadora =ids_detalle_reporte.Find( "cve_tipo_detalle_rep= 3", ll_row_linea_separadora + 1, ll_rows_detalle_reporte)
		end if
	loop
end if

return 0
end function

public function integer f_revisa_corte (integer ai_cve_tipo_doc_reporte, long al_renglon_datos, datawindow adw_datawindow, long al_cuenta, boolean ab_fin_cuerpo_con_registro, long al_cve_carrera);//// f_revisa_corte
//ai_cve_tipo_doc_reporte		integer
//al_renglon_datos				long
//adw_datawindow					datawindow
//al_cuenta						long
//ab_fin_cuerpo_con_registro	boolean
//al_cve_carrera					long

// Revisa si es momento de poner un corte del reporte
long ll_rows_detalle_reporte, ll_row_linea_separadora, ll_renglon_de_separacion_pg1, ll_valor_columna_dw
long ll_valor_long, ll_valor_long_ant, ll_columna_dw, ll_row_insertado, ll_renglon_real_datos
long ll_rows_cuerpo, ll_row_sig_cuerpo, ll_row_sig_cuerpo_mas_array, ll_rows_complementarios
long ll_row_complementario, x, ll_mod_renglon_relativo
string ls_renglon_de_separacion, ls_tipo_pb, ls_texto_bloque_separador, ls_valor_columna_dw
string ls_valor_string, ls_valor_string_ant, ls_texto_complementario
long ll_mod_sumados, ll_mod_sin_sumar, ll_actual_dw, ll_renglon_de_separacion_pgn
ll_rows_detalle_reporte = il_rows_detalle_reporte
ls_texto_complementario = ""


//Si existe una linea separadora definida en la primer pagina

ll_row_linea_separadora =ids_detalle_reporte.Find( "cve_tipo_detalle_rep= 1", 1, ll_rows_detalle_reporte)

if ll_row_linea_separadora>0 then
//Cuenta los registros ya insertados
	ll_rows_cuerpo = ids_cuerpo_reporte.RowCount()
//	Obtiene el número de renglón donde irá un separador para el certificado
	ls_renglon_de_separacion = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "valor_columna_dw")
	ls_tipo_pb = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "tipo_pb")
	if ls_tipo_pb = "long" or  ls_tipo_pb = "int" or ls_tipo_pb = "integer" then
//		Convierte el número de renglón donde irá un separador para el certificado
		ll_renglon_de_separacion_pg1 = long(ls_renglon_de_separacion)
		il_rows_primer_pagina = ll_renglon_de_separacion_pg1
//Siguiente renglon a procesar en base a los renglones insertados en cuerpo_reporte
		ll_row_sig_cuerpo = ll_rows_cuerpo+1
//Siguiente renglon a procesar en base a los renglones insertados en cuerpo_reporte mas las lineas añadidas al final en el array
		ll_row_sig_cuerpo_mas_array= ll_rows_cuerpo + 1 + il_tamanio_array 
//Si el número de renglon donde irá un separador aún es mayor o igual al número de  renglones insertados en cuerpo_reporte
		if ll_renglon_de_separacion_pg1>= ll_rows_cuerpo then
//Determinar si es el ultimo renglon y el final del cuerpo (array de strings) quedaria en la pagina
//Si el renglón actual  de cuerpo_reporte es igual al total de registros y el renglón a insertar no es el ultimo de la pagina
			if il_row_datawindow=il_rows_datawindow and &
				mod(ll_row_sig_cuerpo,ll_renglon_de_separacion_pg1) > 0 then
				x= 1				
//El siguiente renglon a procesar en base a los renglones insertados en cuerpo_reporte mas las lineas añadidas al final en el array
//mas los detalles ya insertados entre el número de renglones por página
				ll_mod_sumados = mod(ll_row_sig_cuerpo_mas_array + il_detalles_insertados, ll_renglon_de_separacion_pg1) 
//El siguiente renglon a procesar en base a los renglones insertados en cuerpo_reporte mas los detalles ya insertados 
//entre el número de renglones por página
				ll_mod_sin_sumar = mod(ll_row_sig_cuerpo + il_detalles_insertados, ll_renglon_de_separacion_pg1)
//Si no se quieren registros sin leyenda final y
//Si el siguiente renglon mas el array, se va a la siguiente pagina
				if ab_fin_cuerpo_con_registro and &
				   mod(ll_row_sig_cuerpo_mas_array , ll_renglon_de_separacion_pg1) < mod(ll_row_sig_cuerpo, ll_renglon_de_separacion_pg1) then
					ll_mod_renglon_relativo = mod(ll_row_sig_cuerpo, ll_renglon_de_separacion_pg1)
					ll_rows_complementarios = 	ll_renglon_de_separacion_pg1 - ll_mod_renglon_relativo 
					ls_texto_bloque_separador = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "texto_bloque")
//Inserta una linea separadora
					ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_doc_reporte)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", ls_texto_bloque_separador)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
//Incrementa el Numero de página después del separador					
					il_pagina_actual = il_pagina_actual +1
//Inserta lineas complementarias por cada renglon que faltaba
					for ll_row_complementario= 1 to ll_rows_complementarios
						ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_doc_reporte)
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", ls_texto_complementario)			
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
					next
				end if	
//Si el siguiente renglon es el ultimo de la pagina				
			elseif mod(ll_row_sig_cuerpo,ll_renglon_de_separacion_pg1) = 0 then
				ls_texto_bloque_separador = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "texto_bloque")
//Inserta un renglon separador
				ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_doc_reporte)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", ls_texto_bloque_separador)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
//Incrementa el Numero de página después del separador y de detalles insertados				
				il_pagina_actual = il_pagina_actual +1
				il_detalles_insertados= il_detalles_insertados +1						
			end if
		end if	
	else
		MessageBox("Tipo de dato incorrecto","El tipo de dato ["+ls_tipo_pb+"] es incorrecto", StopSign!)
		return -1
	end if
end if

//Si existe una linea separadora definida en las demas paginas

ll_row_linea_separadora =ids_detalle_reporte.Find( "cve_tipo_detalle_rep= 2", 1, ll_rows_detalle_reporte)

if ll_row_linea_separadora>0 then
//Cuenta los registros ya insertados
	ll_rows_cuerpo = ids_cuerpo_reporte.RowCount()
//	Obtiene el número de renglón donde irá un separador para el certificado
	ls_renglon_de_separacion = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "valor_columna_dw")
	ls_tipo_pb = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "tipo_pb")
	if ls_tipo_pb = "long" or  ls_tipo_pb = "int" or ls_tipo_pb = "integer" then
//		Convierte el número de renglón donde irá un separador para el certificado
		ll_renglon_de_separacion_pgn = long(ls_renglon_de_separacion)
		il_rows_n_paginas = ll_renglon_de_separacion_pgn
//Siguiente renglon a procesar en base a los renglones insertados en cuerpo_reporte
		ll_row_sig_cuerpo = ll_rows_cuerpo+1
//Siguiente renglon a procesar en base a los renglones insertados en cuerpo_reporte mas las lineas añadidas al final en el array
		ll_row_sig_cuerpo_mas_array= ll_rows_cuerpo + 1 + il_tamanio_array 
//Si el número de renglon donde irá un separador de la primera pagina es menor al número de  renglones insertados en cuerpo_reporte
		if il_rows_primer_pagina< ll_rows_cuerpo then
//Determinar si es el ultimo renglon y el final del cuerpo (array de strings) quedaria en la pagina
			if il_row_datawindow=il_rows_datawindow and &
				mod(ll_row_sig_cuerpo - il_rows_primer_pagina,ll_renglon_de_separacion_pgn) > 0 then
				x= 1
//El siguiente renglon a procesar en base a los renglones insertados en cuerpo_reporte mas las lineas añadidas al final en el array
//mas los detalles ya insertados entre el número de renglones por página
				ll_mod_sumados = mod(ll_row_sig_cuerpo_mas_array + il_detalles_insertados, ll_renglon_de_separacion_pgn) 
//El siguiente renglon a procesar en base a los renglones insertados en cuerpo_reporte mas los detalles ya insertados 
//entre el número de renglones por página
				ll_mod_sin_sumar = mod(ll_row_sig_cuerpo + il_detalles_insertados, ll_renglon_de_separacion_pgn)
//Si no se quieren registros sin leyenda final y
//Si el siguiente renglon mas el array, se va a la siguiente pagina
				if ab_fin_cuerpo_con_registro and &
				   mod(ll_row_sig_cuerpo_mas_array - il_rows_primer_pagina, ll_renglon_de_separacion_pgn) < mod(ll_row_sig_cuerpo - il_rows_primer_pagina, ll_renglon_de_separacion_pgn) then
					ll_mod_renglon_relativo = mod(ll_row_sig_cuerpo - il_rows_primer_pagina, ll_renglon_de_separacion_pgn)
					ll_rows_complementarios = 	ll_renglon_de_separacion_pgn - ll_mod_renglon_relativo 
					ls_texto_bloque_separador = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "texto_bloque")
//Inserta una linea separadora
					ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_doc_reporte)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", ls_texto_bloque_separador)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
//Incrementa el Numero de página después del separador					
					il_pagina_actual = il_pagina_actual +1
//Inserta lineas complementarias por cada renglon que faltaba
					for ll_row_complementario= 1 to ll_rows_complementarios
						ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_doc_reporte)
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", ls_texto_complementario)			
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
					next
				end if	
//Si el siguiente renglon es el ultimo de la pagina				
			elseif mod(ll_row_sig_cuerpo - il_rows_primer_pagina,ll_renglon_de_separacion_pgn) = 0 then
				ls_texto_bloque_separador = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "texto_bloque")
//Inserta un renglon separador
				ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_doc_reporte)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", ls_texto_bloque_separador)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
//Incrementa el Numero de página después del separador y de detalles insertados				
				il_pagina_actual = il_pagina_actual +1
				il_detalles_insertados= il_detalles_insertados +1						
			end if
		end if	
	else
		MessageBox("Tipo de dato incorrecto","El tipo de dato ["+ls_tipo_pb+"] es incorrecto", StopSign!)
		return -1
	end if
end if



//Si existe un cambio de valor en alguna columna que indique un encabezado
ll_row_linea_separadora =ids_detalle_reporte.Find( "cve_tipo_detalle_rep= 3", 1, ll_rows_detalle_reporte)
if ll_row_linea_separadora>0 then
	
	do while ll_row_linea_separadora >0
		ll_renglon_real_datos= al_renglon_datos - il_detalles_insertados - il_tamanio_array_inicio
		ll_renglon_real_datos= il_row_datawindow
		ll_columna_dw = ids_detalle_reporte.GetItemNumber(ll_row_linea_separadora, "columna_dw")
		ls_valor_columna_dw = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "valor_columna_dw")
		ls_tipo_pb = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "tipo_pb")
		ls_texto_bloque_separador = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "texto_bloque")
		if ls_tipo_pb = "long" or  ls_tipo_pb = "int" or ls_tipo_pb = "integer" then
			ll_valor_long = adw_datawindow.GetItemNumber(ll_renglon_real_datos, ll_columna_dw)
			ll_valor_columna_dw = long(ls_valor_columna_dw)
			if ll_renglon_real_datos > 1 then
				ll_valor_long_ant = adw_datawindow.GetItemNumber(ll_renglon_real_datos - 1, ll_columna_dw)		
			end if
			if ll_renglon_real_datos= 1 then
				//El valor del datawindow es igual al valor consultado
				if ll_valor_long = ll_valor_columna_dw then
					ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_doc_reporte)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", ls_texto_bloque_separador)					
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
					il_detalles_insertados= il_detalles_insertados +1
				end if
				//El valor del datawindow actual es diferente al anterior, pero igual al del corte
			elseif ll_valor_long <> ll_valor_long_ant and ll_valor_long= ll_valor_columna_dw then
				ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_doc_reporte)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", ls_texto_bloque_separador)				
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
				il_detalles_insertados= il_detalles_insertados +1				
			end if
		elseif ls_tipo_pb = "str" or  ls_tipo_pb = "string" then
			ls_valor_string = adw_datawindow.GetItemString(ll_renglon_real_datos, ll_columna_dw)		
			if ll_renglon_real_datos > 1 then
				ls_valor_string_ant = adw_datawindow.GetItemString(ll_renglon_real_datos - 1, ll_columna_dw)		
			end if
			if ll_renglon_real_datos= 1 then
				//El valor del datawindow es igual al valor consultado
				if ls_valor_string = ls_valor_columna_dw then
					ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_doc_reporte)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", ls_texto_bloque_separador)					
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
					ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
					il_detalles_insertados= il_detalles_insertados +1
				end if
				//El valor del datawindow actual es diferente al anterior, pero igual al del corte
			elseif ls_valor_string <> ls_valor_string_ant and ls_valor_string= ls_valor_columna_dw then
				ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_doc_reporte)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", ls_texto_bloque_separador)			
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
				il_detalles_insertados= il_detalles_insertados +1
			end if

		else
			MessageBox("Tipo de dato incorrecto","El tipo de dato ["+ls_tipo_pb+"] es incorrecto", StopSign!)
			return -1
		end if
		if ll_row_linea_separadora = ll_rows_detalle_reporte then
			ll_row_linea_separadora = 0
		else
			ll_row_linea_separadora =ids_detalle_reporte.Find( "cve_tipo_detalle_rep= 3", ll_row_linea_separadora + 1, ll_rows_detalle_reporte)
		end if
	loop
end if

return 0
end function

public function integer f_borra_cuerpo (integer ai_cve_tipo_doc_rep, long al_cuenta, long al_cve_carrera);//f_borra_cuerpo
//Elimina el cuerpo del reporte
//Recibe	ai_cve_tipo_doc_rep	integer
//al_cuenta							long
//al_cve_carrera					long

string ls_mensaje_sql
integer li_codigo_sql

DELETE FROM cuerpo_reporte
WHERE cve_tipo_doc_rep = :ai_cve_tipo_doc_rep
AND cuenta = :al_cuenta
AND cve_carrera = :al_cve_carrera
USING gtr_sce;

li_codigo_sql= gtr_sce.SqlCode
ls_mensaje_sql= gtr_sce.SqlErrText

if li_codigo_sql <>0 then
	MessageBox("Error al eliminar cuerpo_reporte", ls_mensaje_sql,StopSign!)
	ROLLBACK USING gtr_sce;
else	
	COMMIT USING gtr_sce;
end if

return li_codigo_sql

end function

public function integer f_inserta_certificado (long al_cuenta, long al_cve_carrera, long al_cve_plan, long al_cve_doc_control_sep, long al_legalizado, datetime adttm_fecha_solicitud);//f_inserta_certificado
//Recibe
//			al_cuenta					long
//			al_cve_carrera				long
//			al_cve_plan					long
//			al_cve_doc_control_sep	long
//			al_legalizado				long
//			adttm_fecha_solicitud	datetime

integer li_parcial, li_codigo_sql
datetime ldttm_fecha_hoy
string ls_mensaje_sql

ldttm_fecha_hoy = fecha_servidor(gtr_sce)

//Certificado Total
if al_cve_doc_control_sep = 1 then
	li_parcial = 0
//Certificado Parcial
elseif al_cve_doc_control_sep = 2 then
	li_parcial = 1	
end if

//INSERT INTO certificado
//(cuenta,
//cve_carrera,
//cve_plan,
//fecha_inicio,
//fecha_entrada_sep,
//fecha_salida_tentat_sep,
//fecha_salida_sep,
//fecha_checado_sep,
//fecha_envio_plantel,
//num_veces_sep,
//num_reg,
//parcial,
//legalizado,
//checado_sep,
//entrada_arch,
//observaciones,
//fecha_elaboracion
//)

INSERT INTO certificado
(cuenta,	
cve_carrera,
cve_plan,
fecha_inicio,
fecha_entrada_sep,
parcial,
legalizado,
fecha_elaboracion
)
VALUES
(:al_cuenta,
:al_cve_carrera,
:al_cve_plan,
:ldttm_fecha_hoy,
:adttm_fecha_solicitud,
:li_parcial,
:al_legalizado,
:ldttm_fecha_hoy
) USING gtr_sce;

li_codigo_sql = gtr_sce.SqlCode
ls_mensaje_sql = gtr_sce.SqlErrText

if li_codigo_sql = -1 then
	ROLLBACK USING gtr_sce;
	MessageBox("Error al insertar certificado", ls_mensaje_sql, StopSign!)
	return  -1
elseif li_codigo_sql = 0 then
	COMMIT USING gtr_sce;
	return  0
end if

return 0

end function

public function integer f_genera_cuerpo (integer ai_cve_tipo_documento, u_datastore adw_datatawindow, long al_cuenta, boolean ab_permite_lineas_vacias, string as_array_fin_cuerpo[], boolean ab_fin_cuerpo_con_registro, string as_array_inicio_cuerpo[], long al_cve_carrera);//f_genera_cuerpo
//Recibe
//	ai_cve_tipo_documento	integer
//	adw_datatawindow			u_datastore
//al_cuenta						long
//ab_permite_lineas_vacias	boolean
//as_array_fin_cuerpo[]		string
//ab_fin_cuerpo_con_registro	boolean
//as_array_inicio_cuerpo[]	string
//al_cve_carrera				long

long ll_rows_documento_reporte, ll_rows_cuerpo_reporte, ll_detalle_reporte
long ll_row_documento_reporte, ll_row_datawindow, ll_rows_datawindow, ll_row_insertado
string ls_valor_renglon, ls_formato_columna_dw, ls_tipo_pb, ls_valor_columna_dw, ls_valor_string
integer li_columna_ubicacion, li_longitud_ubicacion, li_columna_dw, li_valor_integer
long ll_rows_insertados, ll_tamanio_array, ll_elemento_array, ll_elemento_array_inicio
integer li_num_espacios

if f_borra_cuerpo(ai_cve_tipo_documento, al_cuenta, al_cve_carrera)= -1 then
	return -1
end if

ll_rows_documento_reporte = ids_documento_reporte.Retrieve(ai_cve_tipo_documento)
ids_cuerpo_reporte.Reset()
ll_rows_cuerpo_reporte =ids_cuerpo_reporte.Retrieve(ai_cve_tipo_documento, al_cuenta, al_cve_carrera)
il_tamanio_array=upperbound(as_array_fin_cuerpo)

il_tamanio_array_inicio=upperbound(as_array_inicio_cuerpo)

il_rows_detalle_reporte = ids_detalle_reporte.Retrieve(ai_cve_tipo_documento, al_cuenta)

if isnull(adw_datatawindow) then
	return -1
end if


ll_rows_datawindow= adw_datatawindow.RowCount()
il_rows_datawindow = ll_rows_datawindow
il_pagina_actual=1

//quitar
adw_datatawindow.Print()

if il_tamanio_array_inicio> 0 then
//Inserta el inicio del cuerpo
	for ll_elemento_array_inicio=1 to il_tamanio_array_inicio
		ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_documento)
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)		
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", as_array_inicio_cuerpo[ll_elemento_array_inicio])				
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
	next	
end if


	for ll_row_datawindow= 1 to ll_rows_datawindow
		il_row_datawindow = ll_row_datawindow
		ls_valor_renglon = space(255)
		for ll_row_documento_reporte = 1 to ll_rows_documento_reporte
			//Lee los valores correspondientes a la definicion del reporte
			li_columna_ubicacion = ids_documento_reporte.GetItemNumber(ll_row_documento_reporte,"columna_ubicacion")
			li_longitud_ubicacion = ids_documento_reporte.GetItemNumber(ll_row_documento_reporte,"longitud_ubicacion")
			li_columna_dw  = ids_documento_reporte.GetItemNumber(ll_row_documento_reporte,"columna_dw")
			ls_formato_columna_dw = ids_documento_reporte.GetItemString(ll_row_documento_reporte,"formato_columna_dw")
			ls_tipo_pb = ids_documento_reporte.GetItemString(ll_row_documento_reporte,"tipo_pb")
			//Revisa el tipo de dato del campo que se esta leyendo
			//Si el tipo de dato es un entero
			if ls_tipo_pb= "int" or ls_tipo_pb = "integer" then
				li_valor_integer = adw_datatawindow.GetItemNumber(ll_row_datawindow,li_columna_dw)
				if isnull(ls_formato_columna_dw) then
					if isnull(li_valor_integer) then
						ls_valor_columna_dw= ""
					else
						ls_valor_columna_dw = string(li_valor_integer)
					end if
				else
					if isnull(li_valor_integer) then
						ls_valor_columna_dw= ""
					else
						ls_valor_columna_dw = string(li_valor_integer,ls_formato_columna_dw)
					end if
				end if				
			//Si el tipo de dato es un string
			elseif ls_tipo_pb= "str" or ls_tipo_pb = "string" then
				ls_valor_string = adw_datatawindow.GetItemString(ll_row_datawindow,li_columna_dw)
				if isnull(ls_valor_string)	then		
					ls_valor_string=""
				end if				
				if isnull(ls_formato_columna_dw) then
					ls_valor_columna_dw = ls_valor_string
				else
					ls_valor_columna_dw = string(ls_valor_string,ls_formato_columna_dw)
				end if
			else
				MessageBox("Tipo de dato NO soportado","El tipo de dato ["+ls_tipo_pb+"] no esta soportado",StopSign!)
				return -1
			end if
			//Ajusta/recorta el valor leido a la longitud definida/permitida en el reporte
			ls_valor_columna_dw = left(ls_valor_columna_dw,li_longitud_ubicacion)
			if len(ls_valor_columna_dw) < li_longitud_ubicacion then
				li_num_espacios = li_longitud_ubicacion  - len(ls_valor_columna_dw)
				ls_valor_columna_dw = ls_valor_columna_dw +space(li_num_espacios)
			end if
			ls_valor_renglon= Replace(ls_valor_renglon, li_columna_ubicacion, li_longitud_ubicacion, ls_valor_columna_dw)
		next	
		//Revisa si el reporte permite lineas vacias para añadirlas al cuerpo
		if len(trim(ls_valor_renglon))> 0 or ab_permite_lineas_vacias then					

				ll_rows_insertados= ids_cuerpo_reporte.RowCount()
				ll_rows_insertados= ll_rows_insertados + 1 + il_rows_saltados
				//Revisa si es necesario realizar un corte por la información o el numero de registros
				if f_revisa_corte(ai_cve_tipo_documento, ll_rows_insertados,  adw_datatawindow, al_cuenta, true, al_cve_carrera) = -1 then
					return -1
				end if
				//Inserta el registro en la tabla con el renglon construido
				ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_documento)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)		
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", ls_valor_renglon)	
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
				
		else
			il_rows_saltados= il_rows_saltados +1			
		end if
	next
	//Inserta el final del cuerpo
	for ll_elemento_array=1 to il_tamanio_array
		ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_documento)
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)		
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", as_array_fin_cuerpo[ll_elemento_array])				
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
	next
	//Actualiza la informacion en la base de datos
	if	ids_cuerpo_reporte.Update()= 1 then
		COMMIT USING gtr_sce;
//		MessageBox("Actualizacion exitosa","Reporte almacenado",Information!)
	else
		ROLLBACK USING gtr_sce;		
		MessageBox("Error al almacenar","No es posible generar el reporte",StopSign!)
		return -1
	end if

return 0
end function

public function integer f_genera_bloque_certificados (datetime adttm_fecha_inicial, datetime adttm_fecha_final, integer ai_cve_doc_control_sep, string as_nivel, integer ai_legalizado, integer ai_origen_internet);//f_genera_bloque_certificados
//Recibe:	adttm_fecha_inicial		datetime
//				adttm_fecha_final			datetime
//				ai_cve_doc_control_sep	integer
//				as_nivel						string
//				ai_legalizado				integer
//				ai_origen_internet		integer
//
//Genera un bloque de certificados en base a los parametros recibidos
//
//Regresa:	integer

uo_reporte_dw luo_reporte_dw
u_datastore lds_certificado, lds_certificado_n
long ll_rows, ll_creditos_cursados
integer li_res_print, li_cve_tipo_documento
string ls_final_reporte[], ls_carrera, ls_anio_plan, ls_nivel
string ls_carrera_sin_prefijo, ls_grado_carrera, ls_grado_con_articulo
string LineaR1, LineaR2, ls_texto_documento, ls_mes
long ll_cuenta, ll_cve_carrera, ll_cve_plan
long ll_rows_sol_cert, ll_row, ll_cve_doc_control_sep, ll_cve_tipo_doc_reval
datetime ldttm_fecha_revalidacion
date ldt_fecha_revalidacion
long ll_dia, ll_mes, ll_anio, ll_legalizado, ll_tiene_mats_revalidadas, ll_cve_subsistema
boolean lb_tiene_mats_revalidadas, lb_legalizado, lb_rev
//u_dw_captura ldw_revision_estudios, ldw_materias_historico
u_datastore ldw_revision_estudios, ldw_materias_historico
long ll_materias_historico, ll_revision_estudios
blob lblob_revision_estudios, lblob_materias_historico
integer lsf_revision_estudios, lsf_materias_historico
boolean lb_es_regularizacion= false, lb_imprime_lineas_vacias
string ls_final_carrera01, ls_final_carrera02, ls_cadena_buscada = space(1), ls_string_null
long ll_ultima_posicion
long ll_indice_nulo, ll_tamanio_arreglo, ll_obten_resol_adm_rg
string ls_num_documento, ls_numero_resolucion, ls_fecha_resolucion
SetNull(ls_string_null)

lds_certificado = CREATE u_datastore
lds_certificado_n = CREATE u_datastore

//ldw_revision_estudios = CREATE u_dw_captura
//ldw_materias_historico = CREATE u_dw_captura

ldw_revision_estudios = CREATE u_datastore
ldw_materias_historico = CREATE u_datastore

ldw_revision_estudios.dataobject = "dw_rev_est_fmc"
ldw_materias_historico.dataobject = "dw_certificado_ext2"

ldw_revision_estudios.SetTransObject(gtr_sce)
ldw_materias_historico.SetTransObject(gtr_sce)

//ldw_revision_estudios.Insertrow(0)
//ldw_materias_historico.Insertrow(0)

ll_materias_historico = ldw_materias_historico.Rowcount() 
ll_revision_estudios = ldw_revision_estudios.Rowcount() 


ll_rows_sol_cert = ids_solicitud_certificado.Retrieve(adttm_fecha_inicial, adttm_fecha_final, ai_cve_doc_control_sep, as_nivel, ai_legalizado, ai_origen_internet)

//Para cada certificado solicititado
FOR ll_row=1 TO ll_rows_sol_cert
	string ls_array_inicio[], ls_array_vacio[]
	ll_cuenta = ids_solicitud_certificado.GetItemNumber(ll_row,"cuenta")
	ll_cve_carrera = ids_solicitud_certificado.GetItemNumber(ll_row,"cve_carrera")
	ll_cve_plan	= ids_solicitud_certificado.GetItemNumber(ll_row,"cve_plan")
	ls_nivel = f_obten_nivel_carrera(ll_cve_carrera)
	ll_cve_doc_control_sep = ids_solicitud_certificado.GetItemNumber(ll_row,"cve_doc_control_sep")
	ll_cve_tipo_doc_reval = ids_solicitud_certificado.GetItemNumber(ll_row,"cve_tipo_doc_reval")
	ll_tiene_mats_revalidadas= of_tiene_mats_revalidadas(ll_cuenta, ll_cve_carrera, ll_cve_plan)	
	if ll_tiene_mats_revalidadas =0 then
		lb_tiene_mats_revalidadas= false
	elseif ll_tiene_mats_revalidadas =-1 then
		lb_tiene_mats_revalidadas= false
		MessageBox("Error en generación","No es posible continuar",StopSign!)	
		return -1
	else
		lb_tiene_mats_revalidadas= true		
	end if
	ls_texto_documento =  ids_solicitud_certificado.GetItemString(ll_row,"texto_documento")
	ls_num_documento = ids_solicitud_certificado.GetItemString(ll_row,"num_documento")
	ldttm_fecha_revalidacion = ids_solicitud_certificado.GetItemDatetime(ll_row,"fecha_revalidacion")
	ll_legalizado = ids_solicitud_certificado.GetItemNumber(ll_row,"legalizado")
	ll_cve_subsistema = f_obten_subsistema(ll_cuenta, ll_cve_carrera, ll_cve_plan)
	if ll_cve_subsistema= -1 then
		MessageBox("Error en generación","No es posible continuar",StopSign!)	
		return -1
	end if
	if ll_legalizado = 1 then lb_legalizado = true else lb_legalizado= false
	if lb_tiene_mats_revalidadas then
		ldt_fecha_revalidacion = date(ldttm_fecha_revalidacion)
		ll_dia = day(ldt_fecha_revalidacion)
		ll_mes = month(ldt_fecha_revalidacion)
		ls_mes = f_obten_mes(ll_mes)
		ll_anio = year(ldt_fecha_revalidacion)
		if isnull(ls_texto_documento) then
			ls_texto_documento= ""
		end if
		LineaR1 = "MATERIAS EQUIVALENTES SEGUN "
		LineaR1 += ls_texto_documento
		if isnull(ls_num_documento) then
			LineaR1 += ""
		else
			LineaR1 += ls_num_documento
		end if
		LineaR2 = "DE FECHA "+  string(ll_dia)+" DE "+ls_mes +" DE " +string(ll_anio)
		ls_array_inicio[1]= LineaR1
		ls_array_inicio[2]= LineaR2
	else
		ls_array_inicio= ls_array_vacio
//		ls_array_inicio[2]= ls_string_null
	end if
	
	ls_carrera_sin_prefijo = f_obten_carrera_sin_prefijo(ll_cve_carrera)
	ls_grado_carrera = f_obten_grado_carrera(ll_cve_carrera)
	ls_grado_con_articulo = f_obten_grado_con_articulo(ls_grado_carrera)

	ldw_materias_historico.Reset() 
	ldw_revision_estudios.Reset() 

	lb_rev = hist_alumno_areas_fs(ll_cuenta, ll_cve_carrera, ll_cve_plan, ll_cve_subsistema, ldw_materias_historico, ldw_revision_estudios, ls_nivel, lblob_materias_historico, lblob_revision_estudios)
	
	lsf_revision_estudios = ldw_revision_estudios.SetFullState(lblob_revision_estudios)
	lsf_materias_historico = ldw_materias_historico.SetFullState(lblob_materias_historico)
	
	ll_materias_historico = ldw_materias_historico.Rowcount() 
	ll_revision_estudios = ldw_revision_estudios.Rowcount() 

	SetPointer(HourGlass!)
	ldw_materias_historico.SetSort("tipo A,periodonum A,sigla A")
	ldw_materias_historico.Sort()
	if of_obten_vigencia_plan(ll_cve_carrera, ll_cve_plan, ls_anio_plan)<> 0 then
		MessageBox("Error en vigencia","No es posible continuar",StopSign!)	
		return -1		
	end if
	
	if ldw_materias_historico.RowCount() >= 2 then
		if ldw_materias_historico.GetItemString(2,"obs") = " *" then	
			lb_es_regularizacion = true
		else
			lb_es_regularizacion = false
		end if
	end if	
	
	ll_tamanio_arreglo = upperbound(ls_final_reporte)	
	FOR ll_indice_nulo=1 TO ll_tamanio_arreglo
		SetNull(ls_final_reporte[ll_indice_nulo])		
	NEXT
	
	ll_creditos_cursados= ldw_revision_estudios.getitemnumber(1,"cursadost")
	//if ls_nivel = "L" then
	if ls_nivel <> "P" then
		//Certificado TOTAL
		if ldw_revision_estudios.getitemstring(1,"completo") = "si" then
			ls_final_reporte[1]="NOTA: Cubre íntegramente las materias y el mínimo de créditos para optar por el TITULO"
			ls_final_reporte[2]="DE LICENCIADO EN " + f_elimina_acentos(ls_carrera_sin_prefijo)
			ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
		else
		//Certificado PARCIAL
			ls_final_reporte[1]="NOTA: El presente certificado parcial ampara "+string(ll_creditos_cursados)+" créditos correspondientes al Plan de"
			ls_final_reporte[2]="Estudios "+ls_anio_plan+" de "+f_elimina_acentos(ls_grado_con_articulo)+" en "+f_elimina_acentos(ls_carrera_sin_prefijo )
			ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
		end if
	elseif ls_nivel = "P" then
		//Certificado TOTAL
		ls_final_carrera01 = ""
		if ldw_revision_estudios.getitemstring(1,"completo") = "si" then
			ls_final_reporte[1]="NOTA: Cubre íntegramente las materias y el mínimo de créditos para optar por"
			ls_final_reporte[2]=upper(f_elimina_acentos(ls_grado_con_articulo))+" EN " + f_elimina_acentos(ls_carrera_sin_prefijo)
			if len (ls_final_reporte[2]) < 87 then
 			   ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
			else
 				ll_ultima_posicion = f_obten_ultima_aparicion(ls_final_reporte[2], ls_cadena_buscada, 87)
				ls_final_carrera01 = mid( ls_final_reporte[2], 1, ll_ultima_posicion)
				ls_final_carrera02 = mid( ls_final_reporte[2], ll_ultima_posicion + 1)
	 			ls_final_reporte[2]=	ls_final_carrera01		
 				ls_final_reporte[3]=	ls_final_carrera02		
	 			ls_final_reporte[4]="---------------------------------------------------------------------------------------------"
			end if
		else
		//Certificado PARCIAL
			ls_final_reporte[1]="NOTA: El presente certificado parcial ampara "+string(ll_creditos_cursados)+" créditos correspondientes al Plan de"
			ls_final_reporte[2]="Estudios "+ls_anio_plan+" de "+f_elimina_acentos(ls_grado_con_articulo)+" EN "+f_elimina_acentos(ls_carrera_sin_prefijo) 
			if len (ls_final_reporte[2]) < 87 then
 			   ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
			else
 				ll_ultima_posicion = f_obten_ultima_aparicion(ls_final_reporte[2], ls_cadena_buscada, 87)
				ls_final_carrera01 = mid( ls_final_reporte[2], 1, ll_ultima_posicion)
				ls_final_carrera02 = mid( ls_final_reporte[2], ll_ultima_posicion + 1)
 				ls_final_reporte[2]=	ls_final_carrera01		
 				ls_final_reporte[3]=	ls_final_carrera02		
	 			ls_final_reporte[4]="---------------------------------------------------------------------------------------------"
			end if		
		end if
	end if
	li_cve_tipo_documento =f_obten_cve_tipo_documento(ll_cve_plan, ls_nivel, lb_legalizado)

	lb_imprime_lineas_vacias = false
	int li_lineas_vacias = 5
	int li_i
	if lb_es_regularizacion = true then
		lb_imprime_lineas_vacias = true
		if ls_final_carrera01 = "" then li_lineas_vacias = 4
		for li_i = 0 to 4 
			ls_final_reporte[li_lineas_vacias + li_i] = "."
		next
		ll_obten_resol_adm_rg = f_obten_resol_adm_rg(ll_cve_carrera,ll_cve_plan,ls_numero_resolucion, ls_fecha_resolucion)
		if ll_obten_resol_adm_rg<> -1 then
			ls_final_reporte[li_lineas_vacias + 5] = "          *  EL  PRESENTE  CERTIFICADO  SE EXPIDE  EN  CUMPLIMIENTO A LA RESOLUCION"
			ls_final_reporte[li_lineas_vacias + 6] = "             ADMINISTRATIVA  NÚMERO "+ls_numero_resolucion+" DE FECHA "+ls_fecha_resolucion+"."
			ls_final_reporte[li_lineas_vacias + 7] = "."
			ls_final_reporte[li_lineas_vacias + 8] = "        R.G. REGULARIZACIÓN  GLOBAL  DERIVADA  DE  LA  SOLICITUD PRESENTADA ANTE LA"
			ls_final_reporte[li_lineas_vacias + 9] = "             UNIDAD ADMINISTRATIVA, MISMA QUE FUE RESUELTA CON OFICIO "+ls_numero_resolucion+""
			ls_final_reporte[li_lineas_vacias + 10] = "             DE FECHA "+ls_fecha_resolucion+"."		
		else
			MessageBox("Error en generación","No es obtener el numero y fecha de la resolucion administrativa de RG",StopSign!)	
			return -1
		end if
		
//		if	f_es_carrera_resol_adm_rg(ll_cve_carrera,ll_cve_plan)>0 then
//			ls_final_reporte[li_lineas_vacias + 5] = "          *  EL  PRESENTE  CERTIFICADO  SE EXPIDE  EN  CUMPLIMIENTO A LA RESOLUCION"
//			ls_final_reporte[li_lineas_vacias + 6] = "             ADMINISTRATIVA  NÚMERO 219/2005/0429 DE FECHA 22 DE FEBRERO DE 2005."
//			ls_final_reporte[li_lineas_vacias + 7] = "."
//			ls_final_reporte[li_lineas_vacias + 8] = "        R.G. REGULARIZACIÓN  GLOBAL  DERIVADA  DE  LA  SOLICITUD PRESENTADA ANTE LA"
//			ls_final_reporte[li_lineas_vacias + 9] = "             UNIDAD ADMINISTRATIVA, MISMA QUE FUE RESUELTA CON OFICIO 219/2005/0429"
//			ls_final_reporte[li_lineas_vacias + 10] = "             DE FECHA 22 DE FEBRERO DE 2005."		
//		else
//			ls_final_reporte[li_lineas_vacias + 5] = "          *  EL  PRESENTE  CERTIFICADO  SE EXPIDE  EN  CUMPLIMIENTO A LA RESOLUCION"
//			ls_final_reporte[li_lineas_vacias + 6] = "             ADMINISTRATIVA  NÚMERO 219/2004/2223 DE FECHA 1 DE SEPTIEMBRE DE 2004."
//			ls_final_reporte[li_lineas_vacias + 7] = "."
//			ls_final_reporte[li_lineas_vacias + 8] = "        R.G. REGULARIZACIÓN  GLOBAL  DERIVADA  DE  LA  SOLICITUD PRESENTADA ANTE LA"
//			ls_final_reporte[li_lineas_vacias + 9] = "             UNIDAD ADMINISTRATIVA, MISMA QUE FUE RESUELTA CON OFICIO 219/2004/2223"
//			ls_final_reporte[li_lineas_vacias + 10] = "             DE FECHA 1 DE SEPTIEMBRE DE 2004."
//		end if
		
		
	end if
	
	if f_genera_cuerpo(li_cve_tipo_documento,ldw_materias_historico, ll_cuenta,false,ls_final_reporte,true, ls_array_inicio, ll_cve_carrera) = -1 then
		MessageBox("Error en generación","No es posible continuar",StopSign!)	
		return -1
	end if
	
NEXT


return ll_rows_sol_cert

end function

public function integer f_genera_cuerpo (integer ai_cve_tipo_documento, datawindow adw_datatawindow, long al_cuenta, boolean ab_permite_lineas_vacias, ref string as_array_fin_cuerpo[], boolean ab_fin_cuerpo_con_registro, string as_array_inicio_cuerpo[], long al_cve_carrera);//f_genera_cuerpo
//Recibe
//	ai_cve_tipo_documento	integer
//	adw_datatawindow			datawindow
//al_cuenta						long
//ab_permite_lineas_vacias	boolean
//as_array_fin_cuerpo[]		string
//ab_fin_cuerpo_con_registro	boolean
//as_array_inicio_cuerpo[]	string
//al_cve_carrera				long


long ll_rows_documento_reporte, ll_rows_cuerpo_reporte, ll_detalle_reporte
long ll_row_documento_reporte, ll_row_datawindow, ll_rows_datawindow, ll_row_insertado
string ls_valor_renglon, ls_formato_columna_dw, ls_tipo_pb, ls_valor_columna_dw, ls_valor_string
integer li_columna_ubicacion, li_longitud_ubicacion, li_columna_dw, li_valor_integer
long ll_rows_insertados, ll_tamanio_array, ll_elemento_array, ll_elemento_array_inicio
integer li_num_espacios, li_inserta_renglon

if f_borra_cuerpo(ai_cve_tipo_documento, al_cuenta, al_cve_carrera)= -1 then
	return -1
end if
//Obtiene los registros con la definicion de las coordenadas de los campos y columnas a leer del datawindow
ll_rows_documento_reporte = ids_documento_reporte.Retrieve(ai_cve_tipo_documento)
ids_cuerpo_reporte.Reset()
//Recupera la información imprimible del reporte según el tipo de documento, cuenta y carrera, en este punto debe estar vacía,
//ya que fue eliminada por la función f_borra_cuerpo()
ll_rows_cuerpo_reporte =ids_cuerpo_reporte.Retrieve(ai_cve_tipo_documento, al_cuenta, al_cve_carrera)
//Calcula el tamaño del arreglo que se concatenará al final del reporte y el valor inicial del mismo
il_tamanio_array=upperbound(as_array_fin_cuerpo)

il_tamanio_array_inicio=upperbound(as_array_inicio_cuerpo)

//Obtiene los registros detalle, que contienen los encabezados de sección y las líneas separadoras del reporte
il_rows_detalle_reporte = ids_detalle_reporte.Retrieve(ai_cve_tipo_documento, al_cuenta)

//Si el datawindow de datos de las materias está vacío, termina la ejecución
if isnull(adw_datatawindow) then
	return -1
end if

//Obtiene el número de registros del datawindow de datos de las materias 
ll_rows_datawindow= adw_datatawindow.RowCount()
//Asigna variables de datos de las materias y página inicial
il_rows_datawindow = ll_rows_datawindow
il_pagina_actual=1

//quitar
adw_datatawindow.Print()

//En el caso que el reporte deba incluir un arreglo de renglones informativos al inicio, los añade
if il_tamanio_array_inicio> 0 then
//Inserta el inicio del cuerpo
	for ll_elemento_array_inicio=1 to il_tamanio_array_inicio
		ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_documento)
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)		
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", as_array_inicio_cuerpo[ll_elemento_array_inicio])				
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
	next	
end if

//Para cada renglon de datos de las materias
	for ll_row_datawindow= 1 to ll_rows_datawindow
		//Asigna el renglón actual
		il_row_datawindow = ll_row_datawindow
		//Asigna la variable que al final contendrá el valor de cada renglón a insertar en cuerpo_reporte
		ls_valor_renglon = space(255)
		for ll_row_documento_reporte = 1 to ll_rows_documento_reporte
			//Lee los valores correspondientes a la definicion del reporte
			li_columna_ubicacion = ids_documento_reporte.GetItemNumber(ll_row_documento_reporte,"columna_ubicacion")
			li_longitud_ubicacion = ids_documento_reporte.GetItemNumber(ll_row_documento_reporte,"longitud_ubicacion")
			li_columna_dw  = ids_documento_reporte.GetItemNumber(ll_row_documento_reporte,"columna_dw")
			ls_formato_columna_dw = ids_documento_reporte.GetItemString(ll_row_documento_reporte,"formato_columna_dw")
			ls_tipo_pb = ids_documento_reporte.GetItemString(ll_row_documento_reporte,"tipo_pb")
			//Revisa el tipo de dato del campo que se esta leyendo
			//Asigna los valores de cada columna de datos de las materias
			//		Si el tipo de dato es un entero
			if ls_tipo_pb= "int" or ls_tipo_pb = "integer" then
				li_valor_integer = adw_datatawindow.GetItemNumber(ll_row_datawindow,li_columna_dw)
				if isnull(ls_formato_columna_dw) then
					if isnull(li_valor_integer) then
						ls_valor_columna_dw= ""
					else
						ls_valor_columna_dw = string(li_valor_integer)
					end if
				else
					if isnull(li_valor_integer) then
						ls_valor_columna_dw= ""
					else
						ls_valor_columna_dw = string(li_valor_integer,ls_formato_columna_dw)
					end if
				end if				
			//		Si el tipo de dato es un string
			elseif ls_tipo_pb= "str" or ls_tipo_pb = "string" then
				ls_valor_string = adw_datatawindow.GetItemString(ll_row_datawindow,li_columna_dw)
				if isnull(ls_valor_string)	then		
					ls_valor_string=""
				end if				
				if isnull(ls_formato_columna_dw) then
					ls_valor_columna_dw = ls_valor_string
				else
					ls_valor_columna_dw = string(ls_valor_string,ls_formato_columna_dw)
				end if
			else
			//		Si el tipo de dato no es correcto
				MessageBox("Tipo de dato NO soportado","El tipo de dato ["+ls_tipo_pb+"] no esta soportado",StopSign!)
				return -1
			end if
			//Ajusta/recorta el valor leido a la longitud definida/permitida en el reporte según documento_reporte
			ls_valor_columna_dw = left(ls_valor_columna_dw,li_longitud_ubicacion)
			if len(ls_valor_columna_dw) < li_longitud_ubicacion then
				li_num_espacios = li_longitud_ubicacion  - len(ls_valor_columna_dw)
				ls_valor_columna_dw = ls_valor_columna_dw +space(li_num_espacios)
			end if
			//Inserta el valor leido en el renglón de datos
			ls_valor_renglon= Replace(ls_valor_renglon, li_columna_ubicacion, li_longitud_ubicacion, ls_valor_columna_dw)
		next	
		//Revisa si el reporte permite lineas vacias para añadirlas al cuerpo
		if len(trim(ls_valor_renglon))> 0 or ab_permite_lineas_vacias then					

				ll_rows_insertados= ids_cuerpo_reporte.RowCount()
				ll_rows_insertados= ll_rows_insertados + 1 + il_rows_saltados
				//Revisa si es necesario realizar un corte por la información o el numero de registros
				if f_revisa_corte(ai_cve_tipo_documento, ll_rows_insertados,  adw_datatawindow, al_cuenta, true, al_cve_carrera) = -1 then
					return -1
				end if
				//Inserta el registro en la tabla con el renglon construido
				
				li_inserta_renglon = f_inserta_renglon(ai_cve_tipo_documento,al_cuenta, ls_valor_renglon, il_pagina_actual, al_cve_carrera)
				
//				ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
//				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_documento)
//				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)		
//				ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
//				ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", ls_valor_renglon)	
//				ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
//				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
				
		else
			il_rows_saltados= il_rows_saltados +1			
		end if
	next
	//Inserta el final de cuerpo_reporte, el arreglo de información que generalmente incluye la leyenda donde se indica si cubre las materias
	//y créditos para optar por el grado correspondiente
	for ll_elemento_array=1 to il_tamanio_array
		ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_documento)
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)		
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", as_array_fin_cuerpo[ll_elemento_array])				
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
	next
	//Actualiza la informacion en la base de datos
	if	ids_cuerpo_reporte.Update()= 1 then
		COMMIT USING gtr_sce;
//		MessageBox("Actualizacion exitosa","Reporte almacenado",Information!)
	else
		ROLLBACK USING gtr_sce;		
		MessageBox("Error al almacenar","No es posible generar el reporte",StopSign!)
		return -1
	end if

return 0
end function

public function integer f_obten_cve_tipo_documento (long al_cve_plan, string as_nivel, boolean ab_legalizado);//f_obten_cve_tipo_documento
//Recibe: 	al_cve_plan		long
//				as_nivel			string
//				ab_legalizado	boolean

long li_cve_tipo_documento=0

//Si es alumno de licenciatura
//if as_nivel = "L" then
if as_nivel <> "P" then
	//Si es plan 2004
	if al_cve_plan>= 6 then
		//Si es certificado legalizado
		if ab_legalizado then
			li_cve_tipo_documento=6
		else
		//Si es certificado simple
			li_cve_tipo_documento=2			
		end if
	else
		//Si es certificado legalizado
		if ab_legalizado then
			li_cve_tipo_documento=5
		else
		//Si es certificado simple
			li_cve_tipo_documento=1		
		end if
	end if
//Si es alumno de posgrado
else
	//Si es plan 2004
	if al_cve_plan>= 6 then
		//Si es certificado legalizado
		if ab_legalizado then
			li_cve_tipo_documento=8
		else
		//Si es certificado simple
			li_cve_tipo_documento=4			
		end if
	else
		//Si es certificado legalizado
		if ab_legalizado then
			li_cve_tipo_documento=7
		else
		//Si es certificado simple
			li_cve_tipo_documento=3			
		end if
	end if	
end if

return  li_cve_tipo_documento



end function

public function integer f_aplica_certificados_impresos (datetime adttm_fecha_inicial, datetime adttm_fecha_final, integer ai_cve_doc_control_sep, string as_nivel, integer ai_legalizado, integer ai_origen_internet);//f_aplica_certificados_impresos
//Aplica el pago de los certificados para que no vuelva a utilizarse
//Devuelve: 0  Todos los pagos fueron aplicados			
//         -1  Hubo error durante la aplicación
//
long ll_cuenta, ll_rows, ll_row, ll_rows_sol_cert, ll_cve_carrera, ll_cve_plan
integer li_cve_tipo_documento, li_res_print, li_cve_doc_control_sep, li_cve_tramite
string ls_nivel
long ll_legalizado
boolean lb_legalizado
integer li_existe_en_academicos = 0
datetime ldttm_fecha_solicitud
integer li_cve_estado = 1, li_cve_sub_estado = 4

	
ll_rows_sol_cert = ids_solicitud_certificado.Retrieve(adttm_fecha_inicial, adttm_fecha_final, ai_cve_doc_control_sep, as_nivel, ai_legalizado, ai_origen_internet)



//Para cada certificado solicititado
FOR ll_row=1 TO ll_rows_sol_cert
	ll_cuenta = ids_solicitud_certificado.GetItemNumber(ll_row,"cuenta")
	ll_cve_carrera = ids_solicitud_certificado.GetItemNumber(ll_row,"cve_carrera")
	ll_cve_plan	= ids_solicitud_certificado.GetItemNumber(ll_row,"cve_plan")
	li_cve_doc_control_sep	= ids_solicitud_certificado.GetItemNumber(ll_row,"cve_doc_control_sep")
	ls_nivel = f_obten_nivel_carrera(ll_cve_carrera)
	ll_legalizado = ids_solicitud_certificado.GetItemNumber(ll_row,"legalizado")
	ldttm_fecha_solicitud= ids_solicitud_certificado.GetItemDatetime(ll_row,"fecha_solicitud")

//Certificado total 
	if li_cve_doc_control_sep= 1 then
		if ll_legalizado= 1 then
			li_cve_tramite=106
			li_cve_tramite=2
		end if		
//Certificado parcial
	elseif li_cve_doc_control_sep= 2 then
		if ll_legalizado= 1 then
			li_cve_tramite=105			
			li_cve_tramite=3
		end if				
	end if		

	if f_aplica_pago_tramite(ll_cuenta,li_cve_tramite)=1 then
	   if f_establece_estatus_tramite(ll_cuenta, ll_cve_carrera, ll_cve_plan, li_cve_tramite, ldttm_fecha_solicitud, li_cve_estado, li_cve_sub_estado)<>0 then 
			MessageBox("No es posible asignar el estatus","Favor de revisar al alumno["&
			           +string(ll_cuenta)+"-"+obten_digito(ll_cuenta)+"]",StopSign!)	
		   return -1
		else
//Ya se insertó el certificado, no es necesario insertar nuevamente			
//			if f_inserta_certificado(ll_cuenta, ll_cve_carrera, ll_cve_plan, li_cve_tramite, ldttm_fecha_solicitud)<>0 then 
//				MessageBox("No es posible insertar el certificado","Favor de revisar al alumno["&
//				           +string(ll_cuenta)+"-"+obten_digito(ll_cuenta)+"]",StopSign!)	
//			   return -1
//			end if
		end if
	else
		MessageBox("No es posible aplicar el pago","Favor de revisar al alumno["&
		           +string(ll_cuenta)+"-"+obten_digito(ll_cuenta)+"]",StopSign!)	
	   return -1		
	end if		

NEXT

//f_aplica_pago_tramite


return 0

end function

public function integer f_imprime_bloque_cert_sin_status (datetime adttm_fecha_inicial, datetime adttm_fecha_final, integer ai_cve_doc_control_sep, string as_nivel, integer ai_legalizado, integer ai_origen_internet, integer ai_aplica_pago, integer ai_egresa_completos);//f_imprime_bloque_cert_sin_status 
//Recibe:	
//			adttm_fecha_inicial		datetime
//			adttm_fecha_final			datetime
//			ai_cve_doc_control_sep	integer
//			as_nivel						string
//			ai_legalizado				integer
//			ai_origen_internet		integer
//			ai_aplica_pago				integer
//			ai_egresa_completos		integer
//Regresa:
//		integer

long ll_rows

ids_solicitud_certificado.dataobject = "d_bloque_cert_sin_status"
ids_solicitud_certificado.SetTransObject(gtr_sce)
ll_rows = f_imprime_bloque_certificados(adttm_fecha_inicial, adttm_fecha_final, ai_cve_doc_control_sep, as_nivel, ai_legalizado, ai_origen_internet, ai_aplica_pago, ai_egresa_completos)

return ll_rows

end function

public function integer f_imprime_bloque_certificados (datetime adttm_fecha_inicial, datetime adttm_fecha_final, integer ai_cve_doc_control_sep, string as_nivel, integer ai_legalizado, integer ai_origen_internet, integer ai_aplica_pago, integer ai_egresa_completos);//f_imprime_bloque_certificados
//Recibe:	
//			adttm_fecha_inicial		datetime
//			adttm_fecha_final			datetime
//			ai_cve_doc_control_sep	integer
//			as_nivel						string
//			ai_legalizado				integer
//			ai_origen_internet		integer
//			ai_aplica_pago				integer
//			ai_egresa_completos		integer
//Regresa:
//		integer

u_datastore lds_certificado, lds_certificado_n
long ll_cuenta, ll_rows, ll_row, ll_rows_sol_cert, ll_cve_carrera, ll_cve_plan
integer li_cve_tipo_documento, li_res_print
string ls_nivel
long ll_legalizado
boolean lb_legalizado
integer li_existe_en_academicos = 0, li_cve_doc_control_sep, li_carrera_en_academicos, li_egresa_alumno
datetime ldttm_fecha_solicitud
integer	li_res_periodo_egreso, li_periodo_egreso, li_anio_egreso, li_egresado_anterior
integer li_folio_solicitud

	
lds_certificado = CREATE u_datastore
lds_certificado_n = CREATE u_datastore
	
ll_rows_sol_cert = ids_solicitud_certificado.Retrieve(adttm_fecha_inicial, adttm_fecha_final, ai_cve_doc_control_sep, as_nivel, ai_legalizado, ai_origen_internet)


MessageBox("Primera Pagina","A punto de imprimir la primer página de los certificados")
//Para cada certificado solicititado
FOR ll_row=1 TO ll_rows_sol_cert
	ll_cuenta = ids_solicitud_certificado.GetItemNumber(ll_row,"cuenta")
	ll_cve_carrera = ids_solicitud_certificado.GetItemNumber(ll_row,"cve_carrera")
	ll_cve_plan	= ids_solicitud_certificado.GetItemNumber(ll_row,"cve_plan")
	ls_nivel = f_obten_nivel_carrera(ll_cve_carrera)
	ll_legalizado = ids_solicitud_certificado.GetItemNumber(ll_row,"legalizado")
	ldttm_fecha_solicitud = ids_solicitud_certificado.GetItemDatetime(ll_row,"fecha_solicitud")
	li_cve_doc_control_sep = ids_solicitud_certificado.GetItemNumber(ll_row,"cve_doc_control_sep")
	li_folio_solicitud = ids_solicitud_certificado.GetItemNumber(ll_row,"folio_solicitud")

//Se suspende la inserción, para que solo se actualice la fecha de elaboración

	//Actuliza el certificado en cuestion
	if f_actualiza_fecha_certificado(ll_cuenta, ll_cve_carrera, ll_cve_plan, ldttm_fecha_solicitud, li_folio_solicitud) = -1 then
		MessageBox("Error de inserción","No es posible insertar el certificado en cuestión",StopSign!)
		return -1	
	end if
	
	//Si es un CERTIFICADO TOTAL LEGALIZADO 
	if li_cve_doc_control_sep= 1 and ll_legalizado=1 then
		li_res_periodo_egreso = in_cortes.of_obten_periodo_egreso(li_periodo_egreso, li_anio_egreso)

		if li_res_periodo_egreso=0 then				
			
			li_carrera_en_academicos = f_carrera_en_academicos(ll_cuenta, ll_cve_carrera)
			//Si la carrera en cuestión está en academicos
			if li_carrera_en_academicos>=0 then			
			
				//Si se desea egresr al alumno en cuestión		
				if ai_egresa_completos = 1 then
					li_egresa_alumno = in_cortes.of_corte_egresado(ll_cuenta, ll_cve_carrera, ll_cve_plan, li_periodo_egreso, li_anio_egreso, li_egresado_anterior)
					
					if li_egresa_alumno= -1 then
						MessageBox("Error en corte de egresado","No es posible continuar la impresión",StopSign!)
						return -1				
					end if
				end if
		
			elseif li_carrera_en_academicos= -1 then
				MessageBox("Error de consulta de carrera en academicos","No es posible continuar la impresión",StopSign!)
				return -1				
			end if
		elseif li_res_periodo_egreso= -1 or  li_res_periodo_egreso = 100 then
			MessageBox("Error de consulta en periodo de egreso","No es posible continuar la impresión",StopSign!)
			return -1				
		end if			
	end if
	
	if ll_legalizado = 1 then lb_legalizado = true else lb_legalizado= false
	li_cve_tipo_documento =f_obten_cve_tipo_documento(ll_cve_plan, ls_nivel, lb_legalizado)
   li_existe_en_academicos = f_carrera_en_academicos(ll_cuenta,ll_cve_carrera)
	
	if li_existe_en_academicos= 1 then

		//if ls_nivel = "L" then
		if ls_nivel <> "P" then
			if lb_legalizado then
				lds_certificado.dataobject = "d_certificados_lic_legal"
				lds_certificado_n.dataobject = "d_certificados_lic_legal_n"	
			else
				lds_certificado.dataobject = "d_certificados_lic_simples"
				lds_certificado_n.dataobject = "d_certificados_lic_simples_n"
			end if
		elseif ls_nivel = "P" then
			if lb_legalizado then
				lds_certificado.dataobject = "d_certificados_pos_legal"
				lds_certificado_n.dataobject = "d_certificados_pos_legal_n"	
			else
				lds_certificado.dataobject = "d_certificados_pos_simples"
				lds_certificado_n.dataobject = "d_certificados_pos_simples_n"
			end if
		end if
		
	else

		//if ls_nivel = "L" then
		if ls_nivel <> "P" then			
			if lb_legalizado then
				lds_certificado.dataobject = "d_certificados_lic_legal_h"
				lds_certificado_n.dataobject = "d_certificados_lic_legal_n_h"	
			else
				lds_certificado.dataobject = "d_certificados_lic_simples_h"
				lds_certificado_n.dataobject = "d_certificados_lic_simples_n_h"
			end if
		elseif ls_nivel = "P" then
			if lb_legalizado then
				lds_certificado.dataobject = "d_certificados_pos_legal_h"
				lds_certificado_n.dataobject = "d_certificados_pos_legal_n_h"	
			else
				lds_certificado.dataobject = "d_certificados_pos_simples_h"
				lds_certificado_n.dataobject = "d_certificados_pos_simples_n_h"
			end if
		end if

   end if

	lds_certificado.SetTransObject(gtr_sce)
	ll_rows = lds_certificado.Retrieve(ll_cuenta, li_cve_tipo_documento, 1, 1, ll_cve_carrera)
	if ll_rows >0 then 
		li_res_print= lds_certificado.Print()	
		if li_res_print = 1 then
			
		end if
	else
		
		//	MessageBox("No hay registros","No es posible imprimir",StopSign!)		
	end if

NEXT

MessageBox("Primera Pagina","A punto de imprimir las n-esimas páginas de los certificados")
//Para cada certificado solicititado
FOR ll_row=1 TO ll_rows_sol_cert
	ll_cuenta = ids_solicitud_certificado.GetItemNumber(ll_row,"cuenta")
	ll_cve_carrera = ids_solicitud_certificado.GetItemNumber(ll_row,"cve_carrera")
	ll_cve_plan	= ids_solicitud_certificado.GetItemNumber(ll_row,"cve_plan")
	ls_nivel = f_obten_nivel_carrera(ll_cve_carrera)
	ll_legalizado = ids_solicitud_certificado.GetItemNumber(ll_row,"legalizado")
	if ll_legalizado = 1 then lb_legalizado = true else lb_legalizado= false
	li_cve_tipo_documento =f_obten_cve_tipo_documento(ll_cve_plan, ls_nivel, lb_legalizado)
   li_existe_en_academicos = f_carrera_en_academicos(ll_cuenta,ll_cve_carrera)
	
	if li_existe_en_academicos= 1 then

		//if ls_nivel = "L" then
		if ls_nivel <> "P" then
			if lb_legalizado then
				lds_certificado.dataobject = "d_certificados_lic_legal"
				lds_certificado_n.dataobject = "d_certificados_lic_legal_n"	
			else
				lds_certificado.dataobject = "d_certificados_lic_simples"
				lds_certificado_n.dataobject = "d_certificados_lic_simples_n"
			end if
		elseif ls_nivel = "P" then
			if lb_legalizado then
				lds_certificado.dataobject = "d_certificados_pos_legal"
				lds_certificado_n.dataobject = "d_certificados_pos_legal_n"	
			else
				lds_certificado.dataobject = "d_certificados_pos_simples"
				lds_certificado_n.dataobject = "d_certificados_pos_simples_n"
			end if
		end if
		
	else

		//if ls_nivel = "L" then
		if ls_nivel <> "P" then			
			if lb_legalizado then
				lds_certificado.dataobject = "d_certificados_lic_legal_h"
				lds_certificado_n.dataobject = "d_certificados_lic_legal_n_h"	
			else
				lds_certificado.dataobject = "d_certificados_lic_simples_h"
				lds_certificado_n.dataobject = "d_certificados_lic_simples_n_h"
			end if
		elseif ls_nivel = "P" then
			if lb_legalizado then
				lds_certificado.dataobject = "d_certificados_pos_legal_h"
				lds_certificado_n.dataobject = "d_certificados_pos_legal_n_h"	
			else
				lds_certificado.dataobject = "d_certificados_pos_simples_h"
				lds_certificado_n.dataobject = "d_certificados_pos_simples_n_h"
			end if
		end if

   end if

	lds_certificado_n.SetTransObject(gtr_sce)
	ll_rows = lds_certificado_n.Retrieve(ll_cuenta, li_cve_tipo_documento, 1, 9999, ll_cve_carrera)
	if ll_rows >0 then 
		li_res_print= lds_certificado_n.Print()	
		if li_res_print = 1 then		
			//02
		end if				
	else
//		MessageBox("No hay más registros","Solo existe una hoja.~nNo es posible imprimir",StopSign!)		
	end if		

NEXT

if ai_aplica_pago = 1 then
	if f_aplica_certificados_impresos(adttm_fecha_inicial, adttm_fecha_final, ai_cve_doc_control_sep, as_nivel, ai_legalizado, ai_origen_internet)=-1 then
		MessageBox("Error de aplicación","No es posible aplicar",StopSign!)
		return -1
	end if
end if


if isvalid(lds_certificado) then
	DESTROY lds_certificado
end if

if isvalid(lds_certificado_n) then
	DESTROY lds_certificado_n
end if

return ll_rows_sol_cert
end function

public function integer f_inserta_renglon (integer ai_cve_tipo_documento, long al_cuenta, string as_valor_renglon, long al_pagina_actual, long al_cve_carrera);//Función:
//f_inserta_renglon
//Inserta un renglón de datos en el datawindow
//Recibe: 
//ai_cve_tipo_documento	integer
//al_cuenta					long
//as_valor_renglon			string
//al_pagina_actual			long
//al_cve_carrera				long


long ll_row_insertado=0
								
//Inserta el registro en la tabla con el renglon construido
ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
if ll_row_insertado <> -1 then 
	ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_documento)
	ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)		
	ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
	ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", as_valor_renglon)	
	ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", al_pagina_actual)	
	ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_carrera", al_cve_carrera)	
else
	MessageBox("Error de inserción","Error en la inserción de un registro del certificado",StopSign!)
	return -1
end if
return 1
end function

public function integer f_obten_separador (integer ai_cve_detalle_rep, ref integer ai_numero_bloque, ref string as_texto_bloque);//	f_obten_separador
//	Recibe:
//	ai_cve_detalle_rep	integer
//	ai_numero_bloque		integer
//	as_texto_bloque		string


long ll_row_linea_separadora, ll_rows_detalle_reporte, ll_renglon_de_separacion_pg1
integer li_numero_bloque
string ls_texto_bloque, ls_numero_bloque, ls_tipo_pb
ll_rows_detalle_reporte =ids_detalle_reporte.RowCount()
ll_row_linea_separadora =ids_detalle_reporte.Find( "cve_tipo_detalle_rep= "+string(ai_cve_detalle_rep), 1, ll_rows_detalle_reporte)


if ll_row_linea_separadora>0 then
//	Obtiene el número de renglón donde irá un separador para el certificado
	ls_numero_bloque = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "valor_columna_dw")
	ls_tipo_pb = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "tipo_pb")
	if ls_tipo_pb = "long" or  ls_tipo_pb = "int" or ls_tipo_pb = "integer" then
	//	Convierte el número de renglón donde irá un separador para el certificado
		li_numero_bloque = integer(ls_numero_bloque)
	else
		MessageBox("Tipo de dato incorrecto","El tipo de dato ["+ls_tipo_pb+"] es incorrecto", StopSign!)
		return -1
	end if				
	ls_texto_bloque = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "texto_bloque")			
end if

ai_numero_bloque = li_numero_bloque
as_texto_bloque = ls_texto_bloque


return 0


end function

public function integer f_obten_separador (integer ai_cve_detalle_rep, integer ai_area_mat, ref integer ai_numero_bloque, ref string as_texto_bloque);//	f_obten_separador
//	Recibe:
//	ai_cve_detalle_rep	integer
//	ai_area_mat				integer
//	ai_numero_bloque		integer
//	as_texto_bloque		string


long ll_row_linea_separadora, ll_rows_detalle_reporte, ll_renglon_de_separacion_pg1
integer li_numero_bloque
string ls_texto_bloque, ls_numero_bloque, ls_tipo_pb, ls_query_find = ""
ll_rows_detalle_reporte =ids_detalle_reporte.RowCount()
ls_query_find = "cve_tipo_detalle_rep= "+string(ai_cve_detalle_rep)+" and valor_columna_dw = '"+string(ai_area_mat)+"'"
ll_row_linea_separadora =ids_detalle_reporte.Find( ls_query_find, 1, ll_rows_detalle_reporte)


if ll_row_linea_separadora>0 then
//	Obtiene el número de renglón donde irá un separador para el certificado
	ls_numero_bloque = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "valor_columna_dw")
	ls_tipo_pb = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "tipo_pb")
	if ls_tipo_pb = "long" or  ls_tipo_pb = "int" or ls_tipo_pb = "integer" then
	//	Convierte el número de renglón donde irá un separador para el certificado
		li_numero_bloque = integer(ls_numero_bloque)
	else
		MessageBox("Tipo de dato incorrecto","El tipo de dato ["+ls_tipo_pb+"] es incorrecto", StopSign!)
		return -1
	end if				
	ls_texto_bloque = ids_detalle_reporte.GetItemString(ll_row_linea_separadora, "texto_bloque")			
end if

ai_numero_bloque = li_numero_bloque
as_texto_bloque = ls_texto_bloque


return 0


end function

public function integer f_revisa_corte_cert (integer ai_cve_tipo_doc_reporte, long al_renglon_datos, datawindow adw_datawindow, long al_cuenta, boolean ab_fin_cuerpo_con_registro, long al_cve_carrera, ref string as_array_fin_cuerpo[]);//// f_revisa_corte_cert
//Recibe:
//ai_cve_tipo_doc_reporte		integer
//al_renglon_datos				long
//adw_datawindow					datawindow
//al_cuenta							long
//ab_fin_cuerpo_con_registro	boolean
//al_cve_carrera					long
//as_array_fin_cuerpo			string[]
//Devuelve:
//0 	Inserción de Renglones exitosa
//-1 	Error en el proceso

// Revisa si es momento de poner un corte del reporte
long ll_rows_detalle_reporte, ll_row_linea_separadora, ll_renglon_de_separacion_pg1, ll_valor_columna_dw
long ll_valor_long, ll_valor_long_ant, ll_columna_dw, ll_row_insertado, ll_renglon_real_datos
long ll_rows_cuerpo, ll_row_sig_cuerpo, ll_row_sig_cuerpo_mas_array, ll_rows_complementarios
long ll_row_complementario, x, ll_mod_renglon_relativo
string ls_renglon_de_separacion, ls_tipo_pb, ls_texto_bloque_separador, ls_valor_columna_dw
string ls_valor_string, ls_valor_string_ant, ls_texto_complementario
long ll_mod_sumados, ll_mod_sin_sumar, ll_actual_dw, ll_renglon_de_separacion_pgn
ll_rows_detalle_reporte = il_rows_detalle_reporte
ls_texto_complementario = ""

int li_num_row_separador_pagina_1, li_num_row_separador_pagina_n
int li_res_separador_1, li_res_separador_n

int li_valor_separador_obligatorias, li_valor_separador_optativas, li_valor_separador_formacion
int li_res_separador_obligatorias, li_res_separador_optativas, li_res_separador_formacion

string ls_separador_pagina_1, ls_separador_pagina_n
string ls_separador_obligatorias, ls_separador_optativas, ls_separador_formacion

long ll_row_actual =1, ll_tamanio_array, ll_num_rows_dw_datos, ll_num_rows_dw_datos_array, ll_num_rows_dw_datos_array_separadores
long ll_rows_relativos_pagina_n
string ls_array_guia[]
integer ls_array_guia_num_pag[]
long ll_elemento_array = 1, ll_num_pagina =1, ll_num_pagina_menos_1= 0
integer li_tipo_registro=0, li_tipo_registro_actual=0
boolean lb_inserta_datos = false
boolean lb_hubo_cambio_seccion = true
integer li_num_row_separador_pagina_1_mas_n, li_num_row_separador_pagina_n_mas_n
long ll_elemento_final = 1, ll_rows_documento_reporte, ll_rows_cuerpo_reporte
integer li_obten_renglon_datos
string ls_renglon_datos
string ls_filter_cuenta_valida

integer li_inserta_renglon, li_tamanio_array_guia, li_pagina_actual
long ll_elemento_array_ciclo
string ls_valor_renglon

if f_borra_cuerpo(ai_cve_tipo_doc_reporte, al_cuenta, al_cve_carrera)= -1 then
	return -1
end if

//Obtiene los registros con la definicion de las coordenadas de los campos y columnas a leer del datawindow
ll_rows_documento_reporte = ids_documento_reporte.Retrieve(ai_cve_tipo_doc_reporte)
ids_cuerpo_reporte.Reset()

//Recupera la información imprimible del reporte según el tipo de documento, cuenta y carrera, en este punto debe estar vacía,
//ya que fue eliminada por la función f_borra_cuerpo()
ll_rows_cuerpo_reporte =ids_cuerpo_reporte.Retrieve(ai_cve_tipo_doc_reporte, al_cuenta, al_cve_carrera)

//Obtiene los registros detalle, que contienen los encabezados de sección y las líneas separadoras del reporte
il_rows_detalle_reporte = ids_detalle_reporte.Retrieve(ai_cve_tipo_doc_reporte, al_cuenta)


//Calcula el tamaño del arreglo que se concatenará al final del reporte y el valor inicial del mismo
ll_tamanio_array = upperbound(as_array_fin_cuerpo)

//Solo registra valores con cuenta válida
ls_filter_cuenta_valida = "cuenta > 0"
adw_datawindow.SetFilter(ls_filter_cuenta_valida)
adw_datawindow.Filter()
ll_num_rows_dw_datos= adw_datawindow.RowCount()
//quitar
adw_datawindow.Print()

ll_num_rows_dw_datos_array = ll_num_rows_dw_datos + ll_tamanio_array
ll_num_rows_dw_datos_array_separadores = ll_num_rows_dw_datos_array
li_res_separador_1 = f_obten_separador(1, li_num_row_separador_pagina_1, ls_separador_pagina_1)
li_res_separador_n = f_obten_separador(2, li_num_row_separador_pagina_n, ls_separador_pagina_n)

li_res_separador_obligatorias = f_obten_separador(3, 1, li_valor_separador_obligatorias, ls_separador_obligatorias)
li_res_separador_optativas 	= f_obten_separador(3, 2, li_valor_separador_optativas, ls_separador_optativas)
li_res_separador_formacion 	= f_obten_separador(3, 3, li_valor_separador_formacion, ls_separador_formacion)

do while ll_row_actual <= ll_num_rows_dw_datos
	lb_inserta_datos = true
	lb_hubo_cambio_seccion = false
	ls_renglon_datos = ""
	li_tipo_registro_actual = adw_datawindow.GetItemNumber(ll_row_actual, "tipo")
	//Si hubo un cambio de seccion por tipo de materias
	if li_tipo_registro_actual<>li_tipo_registro then
		//Valida el numero de registro, por si es necesario poner un salto de pagina
		ll_rows_relativos_pagina_n = (li_num_row_separador_pagina_n * ll_num_pagina_menos_1) + li_num_row_separador_pagina_1
		if (ll_elemento_array>= li_num_row_separador_pagina_1 - 2 ) and (ll_num_pagina= 1) then
			ls_array_guia[ll_elemento_array]= ls_separador_pagina_1
			ls_array_guia_num_pag[ll_elemento_array] = ll_num_pagina
			ll_elemento_array=ll_elemento_array + 1
			ll_num_pagina = ll_num_pagina +1
			ll_num_rows_dw_datos_array_separadores =ll_num_rows_dw_datos_array_separadores + 1		
			lb_inserta_datos = true		
		elseif (ll_elemento_array >= ll_rows_relativos_pagina_n) then
			ls_array_guia[ll_elemento_array]= ls_separador_pagina_n
			ls_array_guia_num_pag[ll_elemento_array] = ll_num_pagina
			ll_elemento_array=ll_elemento_array + 1
			ll_num_pagina = ll_num_pagina +1
			ll_num_rows_dw_datos_array_separadores =ll_num_rows_dw_datos_array_separadores + 1		
			lb_inserta_datos = true				
		end if
		
		//Inserta un separador
		choose case li_tipo_registro_actual
			case 1
				ls_array_guia[ll_elemento_array]= ls_separador_obligatorias 
			case 2
				ls_array_guia[ll_elemento_array]= ls_separador_optativas 
			case 3 
				ls_array_guia[ll_elemento_array]= ls_separador_formacion 
			case else
				/*statementblock*/
		end choose
		//Inserta el numero de pagina
		ls_array_guia_num_pag[ll_elemento_array] = ll_num_pagina
		ll_elemento_array=ll_elemento_array + 1		
		ll_num_rows_dw_datos_array_separadores =ll_num_rows_dw_datos_array_separadores + 1		
		li_tipo_registro = li_tipo_registro_actual
		lb_inserta_datos = true
		lb_hubo_cambio_seccion = true
	end if
	li_num_row_separador_pagina_1_mas_n = li_num_row_separador_pagina_1
	
	//Si ya se llegó al final de la primer página
	if (not lb_hubo_cambio_seccion ) and (ll_elemento_array>= li_num_row_separador_pagina_1_mas_n ) and (ll_num_pagina= 1) then
		ls_array_guia[ll_elemento_array]= ls_separador_pagina_1
		ls_array_guia_num_pag[ll_elemento_array] = ll_num_pagina
		ll_elemento_array=ll_elemento_array + 1
		ll_num_pagina = ll_num_pagina +1
		ll_num_rows_dw_datos_array_separadores =ll_num_rows_dw_datos_array_separadores + 1		
		lb_inserta_datos = true		
	end if
	
	ll_num_pagina_menos_1 = ll_num_pagina -1
	li_num_row_separador_pagina_n_mas_n = li_num_row_separador_pagina_n
	ll_rows_relativos_pagina_n = (li_num_row_separador_pagina_n * ll_num_pagina_menos_1) + li_num_row_separador_pagina_1
	
	//Si ya se llegó al final de las páginas n
	if (not lb_hubo_cambio_seccion ) and (ll_elemento_array >= ll_rows_relativos_pagina_n) then
		ls_array_guia[ll_elemento_array]= ls_separador_pagina_n
		ls_array_guia_num_pag[ll_elemento_array] = ll_num_pagina
		ll_elemento_array=ll_elemento_array + 1
		ll_num_pagina = ll_num_pagina +1
		ll_num_rows_dw_datos_array_separadores =ll_num_rows_dw_datos_array_separadores + 1		
		lb_inserta_datos = true		
	end if

	//Si se debe insertar datos y no se ha alcanzado el último registro
	if lb_inserta_datos and (ll_row_actual < ll_num_rows_dw_datos) then
		li_obten_renglon_datos = f_obten_renglon_datos(ll_row_actual, adw_datawindow, ls_renglon_datos ) 
		ls_array_guia[ll_elemento_array]= ls_renglon_datos
		ls_array_guia_num_pag[ll_elemento_array] = ll_num_pagina
		ll_elemento_array=ll_elemento_array + 1
	end if
	
	//Si ya se alcanzó el último registro
	if ll_row_actual >= ll_num_rows_dw_datos then
		// Si es la pagina 1
		if ll_num_pagina = 1 then
			//Si el registro mas la información final salen de los límites de la página
			if (ll_elemento_array + ll_tamanio_array) > li_num_row_separador_pagina_1 then
				//Inserta el separador de la página 1
				ls_array_guia[ll_elemento_array]= ls_separador_pagina_1
				ls_array_guia_num_pag[ll_elemento_array] = ll_num_pagina
				ll_elemento_array=ll_elemento_array + 1
				ll_num_pagina = ll_num_pagina +1
				ll_num_rows_dw_datos_array_separadores =ll_num_rows_dw_datos_array_separadores + 1					
				lb_inserta_datos = true					
			end if
		// Si es la pagina n | n>1
		elseif ll_num_pagina > 1 then
			//Si el registro mas la información final salen de los límites de la página
			if (ll_elemento_array + ll_tamanio_array) > li_num_row_separador_pagina_n then
				//Inserta el separador de la página n
				ls_array_guia[ll_elemento_array]= ls_separador_pagina_n
				ls_array_guia_num_pag[ll_elemento_array] = ll_num_pagina
				ll_elemento_array=ll_elemento_array + 1
				ll_num_pagina = ll_num_pagina +1
				ll_num_rows_dw_datos_array_separadores =ll_num_rows_dw_datos_array_separadores + 1		
				lb_inserta_datos = true					
			end if

		end if
		
		if lb_inserta_datos then
			li_obten_renglon_datos = f_obten_renglon_datos(ll_row_actual, adw_datawindow, ls_renglon_datos ) 
			ls_array_guia[ll_elemento_array]= ls_renglon_datos
			ls_array_guia_num_pag[ll_elemento_array] = ll_num_pagina
			ll_elemento_array=ll_elemento_array + 1
		end if
		
		for ll_elemento_final=1 to ll_tamanio_array step 1
			ls_array_guia[ll_elemento_array]= as_array_fin_cuerpo[ll_elemento_final]
			ls_array_guia_num_pag[ll_elemento_array] = ll_num_pagina
			ll_elemento_array=ll_elemento_array + 1
			ll_num_rows_dw_datos_array_separadores =ll_num_rows_dw_datos_array_separadores + 1		
		next

	end if
	ll_row_actual = ll_row_actual +1
loop

//Inserta el arreglo del certificado en la base de datos
li_tamanio_array_guia = upperbound(ls_array_guia)
for ll_elemento_array_ciclo = 1 to li_tamanio_array_guia step 1
	ls_valor_renglon = ls_array_guia[ll_elemento_array_ciclo]
	li_pagina_actual = ls_array_guia_num_pag[ll_elemento_array_ciclo]
	li_inserta_renglon = f_inserta_renglon(ai_cve_tipo_doc_reporte,al_cuenta, ls_valor_renglon, li_pagina_actual, al_cve_carrera)
	if li_inserta_renglon= -1 then
		MessageBox("Error de Inserción", "No ha sido posible insertar registros del certificado",StopSign!)
		return -1
	end if
next


//Actualiza la informacion en la base de datos
if	ids_cuerpo_reporte.Update()= 1 then
	COMMIT USING gtr_sce;
else
	ROLLBACK USING gtr_sce;		
	MessageBox("Error al almacenar","No es posible generar el reporte",StopSign!)
	return -1
end if




return 0
end function

public function integer f_obten_renglon_datos (long al_row_datos, datawindow adw_datatawindow, ref string as_valor_renglon);//f_obten_renglon_datos
//Recibe
//al_row_datos			long
//adw_datatawindow	datawindow
//as_valor_renglon	string
string ls_valor_renglon

long ll_row_documento_reporte, ll_rows_documento_reporte
integer li_columna_ubicacion, li_longitud_ubicacion, li_columna_dw

string ls_formato_columna_dw, ls_tipo_pb
integer li_valor_integer
string ls_valor_string, ls_valor_columna_dw
long ll_row_datawindow , ll_cuenta= 0
integer li_num_espacios
ll_rows_documento_reporte = ids_documento_reporte.RowCount()

ll_cuenta = adw_datatawindow.GetItemNumber(al_row_datos, "cuenta")

//Asigna la variable que al final contendrá el valor de cada renglón a insertar en cuerpo_reporte
ls_valor_renglon = space(255)
if ll_cuenta>0 then
	for ll_row_documento_reporte = 1 to ll_rows_documento_reporte
		//Lee los valores correspondientes a la definicion del reporte
		li_columna_ubicacion = ids_documento_reporte.GetItemNumber(ll_row_documento_reporte,"columna_ubicacion")
		li_longitud_ubicacion = ids_documento_reporte.GetItemNumber(ll_row_documento_reporte,"longitud_ubicacion")
		li_columna_dw  = ids_documento_reporte.GetItemNumber(ll_row_documento_reporte,"columna_dw")
		ls_formato_columna_dw = ids_documento_reporte.GetItemString(ll_row_documento_reporte,"formato_columna_dw")
		ls_tipo_pb = ids_documento_reporte.GetItemString(ll_row_documento_reporte,"tipo_pb")
		//Revisa el tipo de dato del campo que se esta leyendo
		//Asigna los valores de cada columna de datos de las materias
		//		Si el tipo de dato es un entero
		if ls_tipo_pb= "int" or ls_tipo_pb = "integer" then
			ll_row_datawindow = al_row_datos
			li_valor_integer = adw_datatawindow.GetItemNumber(ll_row_datawindow,li_columna_dw)
			if isnull(ls_formato_columna_dw) then
				if isnull(li_valor_integer) then
					ls_valor_columna_dw= ""
				else
					ls_valor_columna_dw = string(li_valor_integer)
				end if
			else
				if isnull(li_valor_integer) then
					ls_valor_columna_dw= ""
				else
					ls_valor_columna_dw = string(li_valor_integer,ls_formato_columna_dw)
				end if
			end if				
		//		Si el tipo de dato es un string
		elseif ls_tipo_pb= "str" or ls_tipo_pb = "string" then
			ll_row_datawindow = al_row_datos
			ls_valor_string = adw_datatawindow.GetItemString(ll_row_datawindow,li_columna_dw)
			if isnull(ls_valor_string)	then		
				ls_valor_string=""
			end if				
			if isnull(ls_formato_columna_dw) then
				ls_valor_columna_dw = ls_valor_string
			else
				ls_valor_columna_dw = string(ls_valor_string,ls_formato_columna_dw)
			end if
		else
		//		Si el tipo de dato no es correcto
			MessageBox("Tipo de dato NO soportado","El tipo de dato ["+ls_tipo_pb+"] no esta soportado",StopSign!)
			return -1
		end if
		//Ajusta/recorta el valor leido a la longitud definida/permitida en el reporte según documento_reporte
		ls_valor_columna_dw = left(ls_valor_columna_dw,li_longitud_ubicacion)
		if len(ls_valor_columna_dw) < li_longitud_ubicacion then
			li_num_espacios = li_longitud_ubicacion  - len(ls_valor_columna_dw)
			ls_valor_columna_dw = ls_valor_columna_dw +space(li_num_espacios)
		end if
		//Inserta el valor leido en el renglón de datos
		ls_valor_renglon= Replace(ls_valor_renglon, li_columna_ubicacion, li_longitud_ubicacion, ls_valor_columna_dw)
	next	
end if
as_valor_renglon = ls_valor_renglon
return 1


end function

public function integer f_obten_renglon_datos (long al_row_datos, u_datastore adw_datatawindow, ref string as_valor_renglon);//f_obten_renglon_datos
//Recibe
//al_row_datos			long
//adw_datatawindow	datawindow
//as_valor_renglon	string
string ls_valor_renglon

long ll_row_documento_reporte, ll_rows_documento_reporte
integer li_columna_ubicacion, li_longitud_ubicacion, li_columna_dw

string ls_formato_columna_dw, ls_tipo_pb
integer li_valor_integer
string ls_valor_string, ls_valor_columna_dw
long ll_row_datawindow , ll_cuenta= 0
integer li_num_espacios
ll_rows_documento_reporte = ids_documento_reporte.RowCount()

ll_cuenta = adw_datatawindow.GetItemNumber(al_row_datos, "cuenta")

//Asigna la variable que al final contendrá el valor de cada renglón a insertar en cuerpo_reporte
ls_valor_renglon = space(255)
if ll_cuenta>0 then
	for ll_row_documento_reporte = 1 to ll_rows_documento_reporte
		//Lee los valores correspondientes a la definicion del reporte
		li_columna_ubicacion = ids_documento_reporte.GetItemNumber(ll_row_documento_reporte,"columna_ubicacion")
		li_longitud_ubicacion = ids_documento_reporte.GetItemNumber(ll_row_documento_reporte,"longitud_ubicacion")
		li_columna_dw  = ids_documento_reporte.GetItemNumber(ll_row_documento_reporte,"columna_dw")
		ls_formato_columna_dw = ids_documento_reporte.GetItemString(ll_row_documento_reporte,"formato_columna_dw")
		ls_tipo_pb = ids_documento_reporte.GetItemString(ll_row_documento_reporte,"tipo_pb")
		//Revisa el tipo de dato del campo que se esta leyendo
		//Asigna los valores de cada columna de datos de las materias
		//		Si el tipo de dato es un entero
		if ls_tipo_pb= "int" or ls_tipo_pb = "integer" then
			ll_row_datawindow = al_row_datos
			li_valor_integer = adw_datatawindow.GetItemNumber(ll_row_datawindow,li_columna_dw)
			if isnull(ls_formato_columna_dw) then
				if isnull(li_valor_integer) then
					ls_valor_columna_dw= ""
				else
					ls_valor_columna_dw = string(li_valor_integer)
				end if
			else
				if isnull(li_valor_integer) then
					ls_valor_columna_dw= ""
				else
					ls_valor_columna_dw = string(li_valor_integer,ls_formato_columna_dw)
				end if
			end if				
		//		Si el tipo de dato es un string
		elseif ls_tipo_pb= "str" or ls_tipo_pb = "string" then
			ll_row_datawindow = al_row_datos
			ls_valor_string = adw_datatawindow.GetItemString(ll_row_datawindow,li_columna_dw)
			if isnull(ls_valor_string)	then		
				ls_valor_string=""
			end if				
			if isnull(ls_formato_columna_dw) then
				ls_valor_columna_dw = ls_valor_string
			else
				ls_valor_columna_dw = string(ls_valor_string,ls_formato_columna_dw)
			end if
		else
		//		Si el tipo de dato no es correcto
			MessageBox("Tipo de dato NO soportado","El tipo de dato ["+ls_tipo_pb+"] no esta soportado",StopSign!)
			return -1
		end if
		//Ajusta/recorta el valor leido a la longitud definida/permitida en el reporte según documento_reporte
		ls_valor_columna_dw = left(ls_valor_columna_dw,li_longitud_ubicacion)
		if len(ls_valor_columna_dw) < li_longitud_ubicacion then
			li_num_espacios = li_longitud_ubicacion  - len(ls_valor_columna_dw)
			ls_valor_columna_dw = ls_valor_columna_dw +space(li_num_espacios)
		end if
		//Inserta el valor leido en el renglón de datos
		ls_valor_renglon= Replace(ls_valor_renglon, li_columna_ubicacion, li_longitud_ubicacion, ls_valor_columna_dw)
	next	
end if
as_valor_renglon = ls_valor_renglon
return 1


end function

public function integer f_revisa_corte_cert (integer ai_cve_tipo_doc_reporte, long al_renglon_datos, u_datastore adw_datawindow, long al_cuenta, boolean ab_fin_cuerpo_con_registro, long al_cve_carrera, ref string as_array_fin_cuerpo[]);//// f_revisa_corte_cert
//Recibe:
//ai_cve_tipo_doc_reporte		integer
//al_renglon_datos				long
//adw_datawindow					datawindow
//al_cuenta							long
//ab_fin_cuerpo_con_registro	boolean
//al_cve_carrera					long
////as_array_fin_cuerpo			string[]
//Devuelve:
//0 	Inserción de Renglones exitosa
//-1 	Error en el proceso

// Revisa si es momento de poner un corte del reporte
long ll_rows_detalle_reporte, ll_row_linea_separadora, ll_renglon_de_separacion_pg1, ll_valor_columna_dw
long ll_valor_long, ll_valor_long_ant, ll_columna_dw, ll_row_insertado, ll_renglon_real_datos
long ll_rows_cuerpo, ll_row_sig_cuerpo, ll_row_sig_cuerpo_mas_array, ll_rows_complementarios
long ll_row_complementario, x, ll_mod_renglon_relativo
string ls_renglon_de_separacion, ls_tipo_pb, ls_texto_bloque_separador, ls_valor_columna_dw
string ls_valor_string, ls_valor_string_ant, ls_texto_complementario
long ll_mod_sumados, ll_mod_sin_sumar, ll_actual_dw, ll_renglon_de_separacion_pgn
ll_rows_detalle_reporte = il_rows_detalle_reporte
ls_texto_complementario = ""

int li_num_row_separador_pagina_1, li_num_row_separador_pagina_n
int li_res_separador_1, li_res_separador_n

int li_valor_separador_obligatorias, li_valor_separador_optativas, li_valor_separador_formacion
int li_res_separador_obligatorias, li_res_separador_optativas, li_res_separador_formacion

string ls_separador_pagina_1, ls_separador_pagina_n
string ls_separador_obligatorias, ls_separador_optativas, ls_separador_formacion

long ll_row_actual =1, ll_tamanio_array, ll_num_rows_dw_datos, ll_num_rows_dw_datos_array, ll_num_rows_dw_datos_array_separadores
long ll_rows_relativos_pagina_n
string ls_array_guia[]
integer ls_array_guia_num_pag[]
long ll_elemento_array = 1, ll_num_pagina =1, ll_num_pagina_menos_1= 0
integer li_tipo_registro=0, li_tipo_registro_actual=0
boolean lb_inserta_datos = false
boolean lb_hubo_cambio_seccion = true
integer li_num_row_separador_pagina_1_mas_n, li_num_row_separador_pagina_n_mas_n
long ll_elemento_final = 1, ll_rows_documento_reporte, ll_rows_cuerpo_reporte
integer li_obten_renglon_datos
string ls_renglon_datos
string ls_filter_cuenta_valida

integer li_inserta_renglon, li_tamanio_array_guia, li_pagina_actual
long ll_elemento_array_ciclo
string ls_valor_renglon

if f_borra_cuerpo(ai_cve_tipo_doc_reporte, al_cuenta, al_cve_carrera)= -1 then
	return -1
end if

//Obtiene los registros con la definicion de las coordenadas de los campos y columnas a leer del datawindow
ll_rows_documento_reporte = ids_documento_reporte.Retrieve(ai_cve_tipo_doc_reporte)
ids_cuerpo_reporte.Reset()

//Recupera la información imprimible del reporte según el tipo de documento, cuenta y carrera, en este punto debe estar vacía,
//ya que fue eliminada por la función f_borra_cuerpo()
ll_rows_cuerpo_reporte =ids_cuerpo_reporte.Retrieve(ai_cve_tipo_doc_reporte, al_cuenta, al_cve_carrera)

//Obtiene los registros detalle, que contienen los encabezados de sección y las líneas separadoras del reporte
il_rows_detalle_reporte = ids_detalle_reporte.Retrieve(ai_cve_tipo_doc_reporte, al_cuenta)


//Calcula el tamaño del arreglo que se concatenará al final del reporte y el valor inicial del mismo
ll_tamanio_array = upperbound(as_array_fin_cuerpo)

//Solo registra valores con cuenta válida
ls_filter_cuenta_valida = "cuenta > 0"
adw_datawindow.SetFilter(ls_filter_cuenta_valida)
adw_datawindow.Filter()
ll_num_rows_dw_datos= adw_datawindow.RowCount()
//quitar
adw_datawindow.Print()

ll_num_rows_dw_datos_array = ll_num_rows_dw_datos + ll_tamanio_array
ll_num_rows_dw_datos_array_separadores = ll_num_rows_dw_datos_array
li_res_separador_1 = f_obten_separador(1, li_num_row_separador_pagina_1, ls_separador_pagina_1)
li_res_separador_n = f_obten_separador(2, li_num_row_separador_pagina_n, ls_separador_pagina_n)

li_res_separador_obligatorias = f_obten_separador(3, 1, li_valor_separador_obligatorias, ls_separador_obligatorias)
li_res_separador_optativas 	= f_obten_separador(3, 2, li_valor_separador_optativas, ls_separador_optativas)
li_res_separador_formacion 	= f_obten_separador(3, 3, li_valor_separador_formacion, ls_separador_formacion)

do while ll_row_actual <= ll_num_rows_dw_datos
	lb_inserta_datos = true
	lb_hubo_cambio_seccion = false
	ls_renglon_datos = ""
	li_tipo_registro_actual = adw_datawindow.GetItemNumber(ll_row_actual, "tipo")
	//Si hubo un cambio de seccion por tipo de materias
	if li_tipo_registro_actual<>li_tipo_registro then
		//Valida el numero de registro, por si es necesario poner un salto de pagina
		ll_rows_relativos_pagina_n = (li_num_row_separador_pagina_n * ll_num_pagina_menos_1) + li_num_row_separador_pagina_1
		if (ll_elemento_array>= li_num_row_separador_pagina_1 - 2 ) and (ll_num_pagina= 1) then
			ls_array_guia[ll_elemento_array]= ls_separador_pagina_1
			ls_array_guia_num_pag[ll_elemento_array] = ll_num_pagina
			ll_elemento_array=ll_elemento_array + 1
			ll_num_pagina = ll_num_pagina +1
			ll_num_rows_dw_datos_array_separadores =ll_num_rows_dw_datos_array_separadores + 1		
			lb_inserta_datos = true		
		elseif (ll_elemento_array >= ll_rows_relativos_pagina_n) then
			ls_array_guia[ll_elemento_array]= ls_separador_pagina_n
			ls_array_guia_num_pag[ll_elemento_array] = ll_num_pagina
			ll_elemento_array=ll_elemento_array + 1
			ll_num_pagina = ll_num_pagina +1
			ll_num_rows_dw_datos_array_separadores =ll_num_rows_dw_datos_array_separadores + 1		
			lb_inserta_datos = true				
		end if
		
		//Inserta un separador
		choose case li_tipo_registro_actual
			case 1
				ls_array_guia[ll_elemento_array]= ls_separador_obligatorias 
			case 2
				ls_array_guia[ll_elemento_array]= ls_separador_optativas 
			case 3 
				ls_array_guia[ll_elemento_array]= ls_separador_formacion 
			case else
				/*statementblock*/
		end choose
		//Inserta el numero de pagina
		ls_array_guia_num_pag[ll_elemento_array] = ll_num_pagina
		ll_elemento_array=ll_elemento_array + 1		
		ll_num_rows_dw_datos_array_separadores =ll_num_rows_dw_datos_array_separadores + 1		
		li_tipo_registro = li_tipo_registro_actual
		lb_inserta_datos = true
		lb_hubo_cambio_seccion = true
	end if
	li_num_row_separador_pagina_1_mas_n = li_num_row_separador_pagina_1
	
	//Si ya se llegó al final de la primer página
	if (not lb_hubo_cambio_seccion ) and (ll_elemento_array>= li_num_row_separador_pagina_1_mas_n ) and (ll_num_pagina= 1) then
		ls_array_guia[ll_elemento_array]= ls_separador_pagina_1
		ls_array_guia_num_pag[ll_elemento_array] = ll_num_pagina
		ll_elemento_array=ll_elemento_array + 1
		ll_num_pagina = ll_num_pagina +1
		ll_num_rows_dw_datos_array_separadores =ll_num_rows_dw_datos_array_separadores + 1		
		lb_inserta_datos = true		
	end if
	
	ll_num_pagina_menos_1 = ll_num_pagina -1
	li_num_row_separador_pagina_n_mas_n = li_num_row_separador_pagina_n
	ll_rows_relativos_pagina_n = (li_num_row_separador_pagina_n * ll_num_pagina_menos_1) + li_num_row_separador_pagina_1
	
	//Si ya se llegó al final de las páginas n
	if (not lb_hubo_cambio_seccion ) and (ll_elemento_array >= ll_rows_relativos_pagina_n) then
		ls_array_guia[ll_elemento_array]= ls_separador_pagina_n
		ls_array_guia_num_pag[ll_elemento_array] = ll_num_pagina
		ll_elemento_array=ll_elemento_array + 1
		ll_num_pagina = ll_num_pagina +1
		ll_num_rows_dw_datos_array_separadores =ll_num_rows_dw_datos_array_separadores + 1		
		lb_inserta_datos = true		
	end if

	//Si se debe insertar datos y no se ha alcanzado el último registro
	if lb_inserta_datos and (ll_row_actual < ll_num_rows_dw_datos) then
		li_obten_renglon_datos = f_obten_renglon_datos(ll_row_actual, adw_datawindow, ls_renglon_datos ) 
		ls_array_guia[ll_elemento_array]= ls_renglon_datos
		ls_array_guia_num_pag[ll_elemento_array] = ll_num_pagina
		ll_elemento_array=ll_elemento_array + 1
	end if
	
	//Si ya se alcanzó el último registro
	if ll_row_actual >= ll_num_rows_dw_datos then
		// Si es la pagina 1
		if ll_num_pagina = 1 then
			//Si el registro mas la información final salen de los límites de la página
			if (ll_elemento_array + ll_tamanio_array) > li_num_row_separador_pagina_1 then
				//Inserta el separador de la página 1
				ls_array_guia[ll_elemento_array]= ls_separador_pagina_1
				ls_array_guia_num_pag[ll_elemento_array] = ll_num_pagina
				ll_elemento_array=ll_elemento_array + 1
				ll_num_pagina = ll_num_pagina +1
				ll_num_rows_dw_datos_array_separadores =ll_num_rows_dw_datos_array_separadores + 1					
				lb_inserta_datos = true					
			end if
		// Si es la pagina n | n>1
		elseif ll_num_pagina > 1 then
			//Si el registro mas la información final salen de los límites de la página
			if (ll_elemento_array + ll_tamanio_array) > li_num_row_separador_pagina_n then
				//Inserta el separador de la página n
				ls_array_guia[ll_elemento_array]= ls_separador_pagina_n
				ls_array_guia_num_pag[ll_elemento_array] = ll_num_pagina
				ll_elemento_array=ll_elemento_array + 1
				ll_num_pagina = ll_num_pagina +1
				ll_num_rows_dw_datos_array_separadores =ll_num_rows_dw_datos_array_separadores + 1		
				lb_inserta_datos = true					
			end if

		end if
		
		if lb_inserta_datos then
			li_obten_renglon_datos = f_obten_renglon_datos(ll_row_actual, adw_datawindow, ls_renglon_datos ) 
			ls_array_guia[ll_elemento_array]= ls_renglon_datos
			ls_array_guia_num_pag[ll_elemento_array] = ll_num_pagina
			ll_elemento_array=ll_elemento_array + 1
		end if
		
		for ll_elemento_final=1 to ll_tamanio_array step 1
			ls_array_guia[ll_elemento_array]= as_array_fin_cuerpo[ll_elemento_final]
			ls_array_guia_num_pag[ll_elemento_array] = ll_num_pagina
			ll_elemento_array=ll_elemento_array + 1
			ll_num_rows_dw_datos_array_separadores =ll_num_rows_dw_datos_array_separadores + 1		
		next

	end if
	ll_row_actual = ll_row_actual +1
loop

//Inserta el arreglo del certificado en la base de datos
li_tamanio_array_guia = upperbound(ls_array_guia)
for ll_elemento_array_ciclo = 1 to li_tamanio_array_guia step 1
	ls_valor_renglon = ls_array_guia[ll_elemento_array_ciclo]
	li_pagina_actual = ls_array_guia_num_pag[ll_elemento_array_ciclo]
	li_inserta_renglon = f_inserta_renglon(ai_cve_tipo_doc_reporte,al_cuenta, ls_valor_renglon, li_pagina_actual, al_cve_carrera)
	if li_inserta_renglon= -1 then
		MessageBox("Error de Inserción", "No ha sido posible insertar registros del certificado",StopSign!)
		return -1
	end if
next


//Actualiza la informacion en la base de datos
if	ids_cuerpo_reporte.Update()= 1 then
	COMMIT USING gtr_sce;
else
	ROLLBACK USING gtr_sce;		
	MessageBox("Error al almacenar","No es posible generar el reporte",StopSign!)
	return -1
end if



return 0
end function

on uo_reporte_dw_anterior.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_reporte_dw_anterior.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_documento_reporte = CREATE u_datastore
ids_cuerpo_reporte = CREATE u_datastore
ids_detalle_reporte = CREATE u_datastore
ids_solicitud_certificado = CREATE u_datastore
ids_solicitud_cert_sin_status = CREATE u_datastore

ids_documento_reporte.dataobject = "d_documento_reporte"
ids_cuerpo_reporte.dataobject = "d_cuerpo_reporte"
ids_detalle_reporte.dataobject = "d_detalle_reporte"
ids_solicitud_certificado.dataobject = "d_bloque_certificados"


ids_documento_reporte.SetTransObject(gtr_sce)
ids_cuerpo_reporte.SetTransObject(gtr_sce)
ids_detalle_reporte.SetTransObject(gtr_sce)
ids_solicitud_certificado.SetTransObject(gtr_sce)

if conecta_bd(gtr_scob, gs_scob,gs_usuario,gs_password)=0 then
	MessageBox("Error","No es posible conectarse a revisar los pagos de trámites",StopSign!)
	this.event destructor()
end if

if not isvalid(in_cortes) then
	in_cortes = create n_cortes
end if

end event

event destructor;if isvalid(ids_documento_reporte) then
	 DESTROY ids_documento_reporte
end if

if isvalid(ids_cuerpo_reporte) then
	 DESTROY ids_cuerpo_reporte
end if

if isvalid(ids_detalle_reporte) then
	 DESTROY ids_detalle_reporte
end if

if isvalid(ids_solicitud_certificado) then
	 DESTROY ids_solicitud_certificado
end if

if isvalid(ids_solicitud_cert_sin_status) then
	 DESTROY ids_solicitud_cert_sin_status
end if


if isvalid(gtr_scob) then
	if desconecta_bd(gtr_scob)=0 then
	   MessageBox("Error","No es posible desconectarse a revisar los pagos de trámites",StopSign!)
	end if
end if

if isvalid(in_cortes) then
	destroy in_cortes 
end if

end event

