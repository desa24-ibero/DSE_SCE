$PBExportHeader$uo_reporte_dw.sru
forward
global type uo_reporte_dw from nonvisualobject
end type
end forward

global type uo_reporte_dw from nonvisualobject
end type
global uo_reporte_dw uo_reporte_dw

type variables
long il_detalles_insertados= 0, il_rows_saltados=0, il_tamanio_array=0, il_rows_detalle_reporte=0
long il_rows_datawindow=0, il_row_datawindow=0, il_rows_primer_pagina=0, il_rows_n_paginas=0
long il_pagina_actual= 0, il_tamanio_array_inicio= 0
uds_datastore ids_documento_reporte, ids_cuerpo_reporte, ids_detalle_reporte


end variables

forward prototypes
public function integer f_revisa_corte (integer ai_cve_tipo_doc_reporte, long al_renglon_datos, datawindow adw_datawindow, long al_cuenta, boolean ab_fin_cuerpo_con_registro)
public function integer f_borra_cuerpo (integer ai_cve_tipo_doc_rep, long al_cuenta)
public function integer f_genera_cuerpo (integer ai_cve_tipo_documento, datawindow adw_datatawindow, long al_cuenta, boolean ab_permite_lineas_vacias, ref string as_array_fin_cuerpo[], boolean ab_fin_cuerpo_con_registro, string as_array_inicio_cuerpo[])
end prototypes

public function integer f_revisa_corte (integer ai_cve_tipo_doc_reporte, long al_renglon_datos, datawindow adw_datawindow, long al_cuenta, boolean ab_fin_cuerpo_con_registro);// f_revisa_corte
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
					il_pagina_actual = il_pagina_actual +1
//Inserta lineas complementarias por cada renglon que faltaba
					for ll_row_complementario= 1 to ll_rows_complementarios
						ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_doc_reporte)
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", ls_texto_complementario)			
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
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
					il_pagina_actual = il_pagina_actual +1
//Inserta lineas complementarias por cada renglon que faltaba
					for ll_row_complementario= 1 to ll_rows_complementarios
						ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_doc_reporte)
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", ls_texto_complementario)			
						ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
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

public function integer f_borra_cuerpo (integer ai_cve_tipo_doc_rep, long al_cuenta);//f_borra_cuerpo
//Elimina el cuerpo del reporte
//Recibe	ai_cve_tipo_doc_rep	integer

string ls_mensaje_sql
integer li_codigo_sql

DELETE FROM cuerpo_reporte
WHERE cve_tipo_doc_rep = :ai_cve_tipo_doc_rep
AND cuenta = :al_cuenta
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

public function integer f_genera_cuerpo (integer ai_cve_tipo_documento, datawindow adw_datatawindow, long al_cuenta, boolean ab_permite_lineas_vacias, ref string as_array_fin_cuerpo[], boolean ab_fin_cuerpo_con_registro, string as_array_inicio_cuerpo[]);//f_genera_cuerpo
//Recibe
//	ai_cve_tipo_documento	integer
//	adw_datatawindow			datawindow

long ll_rows_documento_reporte, ll_rows_cuerpo_reporte, ll_detalle_reporte
long ll_row_documento_reporte, ll_row_datawindow, ll_rows_datawindow, ll_row_insertado
string ls_valor_renglon, ls_formato_columna_dw, ls_tipo_pb, ls_valor_columna_dw, ls_valor_string
integer li_columna_ubicacion, li_longitud_ubicacion, li_columna_dw, li_valor_integer
long ll_rows_insertados, ll_tamanio_array, ll_elemento_array, ll_elemento_array_inicio
integer li_num_espacios

if f_borra_cuerpo(ai_cve_tipo_documento, al_cuenta)= -1 then
	return -1
end if

ll_rows_documento_reporte = ids_documento_reporte.Retrieve(ai_cve_tipo_documento)
ids_cuerpo_reporte.Reset()
ll_rows_cuerpo_reporte =ids_cuerpo_reporte.Retrieve(ai_cve_tipo_documento, al_cuenta)
il_tamanio_array=upperbound(as_array_fin_cuerpo)

il_tamanio_array_inicio=upperbound(as_array_inicio_cuerpo)

il_rows_detalle_reporte = ids_detalle_reporte.Retrieve(ai_cve_tipo_documento)

if isnull(adw_datatawindow) then
	return -1
end if


ll_rows_datawindow= adw_datatawindow.RowCount()
il_rows_datawindow = ll_rows_datawindow
il_pagina_actual=1

//adw_datatawindow.Print()

if il_tamanio_array_inicio> 0 then
//Inserta el inicio del cuerpo
	for ll_elemento_array_inicio=1 to il_tamanio_array_inicio
		ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_documento)
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)		
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", as_array_inicio_cuerpo[ll_elemento_array_inicio])				
		ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
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
				if f_revisa_corte(ai_cve_tipo_documento, ll_rows_insertados,  adw_datatawindow, al_cuenta, true) = -1 then
					return -1
				end if
				//Inserta el registro en la tabla con el renglon construido
				ll_row_insertado = ids_cuerpo_reporte.InsertRow(0)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cve_tipo_doc_rep", ai_cve_tipo_documento)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "cuenta", al_cuenta)		
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "num_renglon", ll_row_insertado)
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "texto_renglon", ls_valor_renglon)	
				ids_cuerpo_reporte.SetItem(ll_row_insertado, "pagina", il_pagina_actual)	
				
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

on uo_reporte_dw.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_reporte_dw.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_documento_reporte = CREATE uds_datastore
ids_cuerpo_reporte = CREATE uds_datastore
ids_detalle_reporte = CREATE uds_datastore

ids_documento_reporte.dataobject = "d_documento_reporte"
ids_cuerpo_reporte.dataobject = "d_cuerpo_reporte"
ids_detalle_reporte.dataobject = "d_detalle_reporte"
ids_documento_reporte.SetTransObject(gtr_sce)
ids_cuerpo_reporte.SetTransObject(gtr_sce)
ids_detalle_reporte.SetTransObject(gtr_sce)


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



end event

