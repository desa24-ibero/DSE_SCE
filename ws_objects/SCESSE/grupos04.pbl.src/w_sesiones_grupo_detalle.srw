$PBExportHeader$w_sesiones_grupo_detalle.srw
forward
global type w_sesiones_grupo_detalle from window
end type
type dw_detalle_sesiones from datawindow within w_sesiones_grupo_detalle
end type
type mc_profesor from monthcalendar within w_sesiones_grupo_detalle
end type
type pb_borra_profesor from picturebutton within w_sesiones_grupo_detalle
end type
type pb_inserta_profesor from picturebutton within w_sesiones_grupo_detalle
end type
type cb_2 from commandbutton within w_sesiones_grupo_detalle
end type
type cb_1 from commandbutton within w_sesiones_grupo_detalle
end type
end forward

global type w_sesiones_grupo_detalle from window
integer width = 2981
integer height = 1556
boolean titlebar = true
string title = "Detalle de Sesiones"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_detalle_sesiones dw_detalle_sesiones
mc_profesor mc_profesor
pb_borra_profesor pb_borra_profesor
pb_inserta_profesor pb_inserta_profesor
cb_2 cb_2
cb_1 cb_1
end type
global w_sesiones_grupo_detalle w_sesiones_grupo_detalle

type variables
uo_grupo_paso iuo_grupo_paso
STRING is_fecha_selec  
DATE idt_fecha_profesor 

n_tr itr_sce 


LONG il_cve_prof
STRING is_prof 


DATETIME idt_inicio_titular
DATETIME idt_fin_titular


DATASTORE ids_grupo_horario 
DATASTORE ids_sesiones 

STRING is_dia[7] = {"domingo", "lunes", "martes", "miercoles", "jueves", "viernes", "sabado"} 

INTEGER ie_anio 

INTEGER  ie_modo_opera 
INTEGER ie_modo 

DATETIME idt_inicio_semestre 
DATETIME idt_fin_semestre 



end variables

forward prototypes
public function integer wf_despliega_horarios ()
public function integer wf_valida_hora (integer ai_dia, integer ai_hora)
public function integer wf_valida_fecha ()
public function integer wf_valida_sesiones ()
public function integer wf_valida_duplicados ()
end prototypes

public function integer wf_despliega_horarios ();RETURN 0 

//INTEGER le_pos
//INTEGER le_ttl_reg
//
//INTEGER le_cve_dia
//INTEGER le_hora_inicio
//INTEGER le_hora_final
//
//INTEGER le_pos_hora
//INTEGER le_row 
//
//DATAWINDOWCHILD ldwc_profesor
//DATAWINDOWCHILD ldwc_horas
//
//dw_horario_profesor.GETCHILD("cve_profesor", ldwc_profesor)   
//dw_horario_profesor.GETCHILD("cve_dia", ldwc_horas)   
//
//LONG ll_cve_profesor
//STRING ls_profesor_apaterno
//STRING ls_profesor_amaterno
//STRING ls_profesor_nombre
//
//INTEGER le_titular 
//LONG ll_cve_titular
//DATETIME ldt_inicio_titular
//DATETIME ldt_fin_titular
//STRING ls_dias, ls_coma
//
//
//
//// Se llena el DWC de profesores. 
//le_ttl_reg = iuo_grupo_paso.ids_profesor.ROWCOUNT()  
//
//FOR le_pos = 1 TO le_ttl_reg  
//
//	ll_cve_profesor = iuo_grupo_paso.ids_profesor.GETITEMNUMBER(le_pos, "cve_profesor")  
//	ls_profesor_apaterno = iuo_grupo_paso.ids_profesor.GETITEMSTRING(le_pos, "profesor_apaterno")  
//	IF ISNULL(ls_profesor_apaterno) THEN ls_profesor_apaterno = "" 
//	ls_profesor_amaterno = iuo_grupo_paso.ids_profesor.GETITEMSTRING(le_pos, "profesor_amaterno")  
//	IF ISNULL(ls_profesor_amaterno ) THEN ls_profesor_amaterno  = "" 
//	ls_profesor_nombre = iuo_grupo_paso.ids_profesor. GETITEMSTRING(le_pos, "profesor_nombre")  
//	IF ISNULL(ls_profesor_nombre) THEN ls_profesor_nombre = "" 
//	
////	le_titular = iuo_grupo_paso.ids_profesor. GETITEMNUMBER(le_pos, "titularidad")   
////	IF le_titular = 1 THEN 
//
//	IF ll_cve_profesor = iuo_grupo_paso.il_cve_profesor THEN 
//		ll_cve_titular = ll_cve_profesor  
//		ldt_inicio_titular = iuo_grupo_paso.ids_profesor.GETITEMDATETIME(le_pos, "fecha_inicio") 
//		ldt_fin_titular = iuo_grupo_paso.ids_profesor.GETITEMDATETIME(le_pos, "fecha_fin") 
//		
//		idt_inicio_titular = ldt_inicio_titular
//		idt_fin_titular = ldt_fin_titular
//		
//	END IF
//	
//
//	le_row = ldwc_profesor.INSERTROW(0)  
//	ldwc_profesor.SETITEM(le_row, "cve_profesor", ll_cve_profesor)
//	ldwc_profesor.SETITEM(le_row, "nombre", STRING(ll_cve_profesor) + "-" + ls_profesor_apaterno + " " + ls_profesor_amaterno + " " + ls_profesor_nombre) 
//
//	il_cve_prof = ll_cve_profesor 
//	is_prof = STRING(ll_cve_profesor) + "-" + ls_profesor_apaterno + " " + ls_profesor_amaterno + " " + ls_profesor_nombre	
//
//NEXT 
//
//// Se verifica si se recibe una captura previa.
//// Se despliega la captura previa 
//IF iuo_grupo_paso.ids_horario_profesor.ROWCOUNT() > 0 THEN 
//	
//	iuo_grupo_paso.ids_horario_profesor.ROWSCOPY(1, iuo_grupo_paso.ids_horario_profesor.ROWCOUNT(), PRIMARY!, dw_horario_profesor, 1, PRIMARY!) 
//
//// Se llena información default para edición.
//ELSE
//
//
//	le_ttl_reg = iuo_grupo_paso.ids_horario.ROWCOUNT() 
//	
//	FOR le_pos = 1 TO le_ttl_reg 
//		
//		le_cve_dia = iuo_grupo_paso.ids_horario.GETITEMNUMBER(le_pos, "cve_dia")   
//		IF ISNULL(le_cve_dia) THEN CONTINUE
//		le_hora_inicio = iuo_grupo_paso.ids_horario.GETITEMNUMBER(le_pos, "hora_inicio")   
//		le_hora_final = iuo_grupo_paso.ids_horario.GETITEMNUMBER(le_pos, "hora_final")  
//		
//		le_row = dw_horario_profesor.INSERTROW(0) 
//		dw_horario_profesor.SETITEM(le_row, "cve_profesor", iuo_grupo_paso.il_cve_profesor) 
//		dw_horario_profesor.SETITEM(le_row, "cve_dia", le_cve_dia)  
//		dw_horario_profesor.SETITEM(le_row, "hora_inicio", le_hora_inicio)    
//		dw_horario_profesor.SETITEM(le_row, "hora_final", le_hora_final)   
//		dw_horario_profesor.SETITEM(le_row, "fecha_inicio", ldt_inicio_titular)
//		dw_horario_profesor.SETITEM(le_row, "fecha_fin", ldt_fin_titular) 
//		
//		ls_dias = ls_dias + ls_coma + STRING(le_cve_dia) 
//		
//		ls_coma = "," 
//		
//	NEXT 
//
//
//END IF
//
//
//DATAWINDOWCHILD ldwc_dias
//dw_horario_profesor.GETCHILD("cve_dia", ldwc_dias)  
//ldwc_dias.SETTRANSOBJECT(itr_sce) 
//ldwc_dias.RETRIEVE() 
//ldwc_dias.SETFILTER("cve_dia IN(" + ls_dias + ")") 
//ldwc_dias.FILTER() 
//
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
//
//
//
////	FOR le_pos_hora = le_hora_inicio TO le_hora_final STEP 1
////		
////		le_row = dw_horario_profesor.INSERTROW(0) 
////		dw_horario_profesor.SETITEM(le_row, "cve_dia", le_cve_dia)  
////		dw_horario_profesor.SETITEM(le_row, "hora", le_pos_hora) 
////		dw_horario_profesor.SETITEM(le_row, "horario", STRING(le_pos_hora) + "-" + STRING(le_pos_hora + 1)) 
////		dw_horario_profesor.SETITEM(le_row, "cve_profesor", iuo_grupo_paso.il_cve_profesor)
////		
////		dw_horario_profesor.SETITEM(le_row, "fecha_inicio", ldt_inicio_titular)
////		dw_horario_profesor.SETITEM(le_row, "fecha_fin", ldt_fin_titular)
////		
////		hora_inicio
////		hora_final
////		
////	NEXT 
//
//
//
//
//
//
end function

public function integer wf_valida_hora (integer ai_dia, integer ai_hora);RETURN 0 
//
//INTEGER le_row 
//INTEGER le_hora_inicio
//INTEGER le_hora_final
//
//
//le_row = iuo_grupo_paso.ids_horario.FIND("cve_dia = " + STRING(ai_dia), 1, iuo_grupo_paso.ids_horario.ROWCOUNT()) 
//
//
//IF le_row > 0 THEN 
//	
//	le_hora_inicio = iuo_grupo_paso.ids_horario.GETITEMNUMBER(le_row, "hora_inicio")  
//	le_hora_final = iuo_grupo_paso.ids_horario.GETITEMNUMBER(le_row, "hora_final") 
//	
//	IF ai_hora < le_hora_inicio OR ai_hora > le_hora_final THEN 
//		MESSAGEBOX("Aviso", "La hora seleccionada no es válida, debe estar entre " + STRING(le_hora_inicio)  + " y " + STRING(le_hora_final)) 
//		RETURN -1 
//	ELSE
//		RETURN 0  
//	END IF 
//	
//ELSE
//
//	RETURN 0
//
//END IF
//
//
//RETURN 0 
//
//
//
//
end function

public function integer wf_valida_fecha ();RETURN 0 

//
//INTEGER le_pos 
//INTEGER le_ttl_profs
//		
//DATETIME ldt_inicio 
//DATETIME ldt_fin 
//DATETIME ldt_limpia
//
//le_ttl_profs = dw_horario_profesor.ROWCOUNT() 
//
//FOR le_pos = 1 TO le_ttl_profs 
//
//	ldt_inicio = dw_horario_profesor.GETITEMDATETIME(le_pos, "fecha_inicio") 
//	IF ISNULL(ldt_inicio) OR ldt_inicio = ldt_limpia THEN CONTINUE 
//	ldt_fin = dw_horario_profesor.GETITEMDATETIME(le_pos, "fecha_fin") 
//	IF ISNULL(ldt_fin) OR ldt_fin = ldt_limpia THEN CONTINUE 
//	
//	IF DATE(ldt_inicio) < DATE(idt_inicio_titular) OR DATE(ldt_inicio) > DATE(ldt_fin) THEN 
//		MESSAGEBOX("Error", "La fecha INICIAL esta fuera del periodo asignado al Profesor.")			
//		dw_horario_profesor.SETROW(le_pos)
//		dw_horario_profesor.SETCOLUMN("fecha_inicio")
//		SETFOCUS(dw_horario_profesor)
//		RETURN -1 
//	ELSEIF DATE(ldt_fin) < DATE(idt_inicio_titular) OR DATE(ldt_fin) > DATE(idt_fin_titular) THEN 
//		MESSAGEBOX("Error", "La fecha FINAL esta fuera del periodo asignado al Profesor.")			
//		dw_horario_profesor.SETROW(le_pos)
//		dw_horario_profesor.SETCOLUMN("fecha_fin")			
//		SETFOCUS(dw_horario_profesor)
//		RETURN -1 
//	END IF
//	
//
//		
//		
//		
//NEXT 
//
//RETURN 0 
//
//
//
//
//
end function

public function integer wf_valida_sesiones ();INTEGER le_pos

INTEGER le_cve_dia
INTEGER le_hora_inicio
INTEGER le_hora_final
DATETIME ldt_fecha_inicio
DATETIME ldt_fecha_fin
DATETIME ldt_fecha_compara 

STRING ls_cadena  
INTEGER le_pos_enc 
BOOLEAN lb_error

INTEGER le_hora_inicio_enc
INTEGER le_hora_final_enc
DATE ldt_fecha_inicio_enc
DATE ldt_fecha_fin_enc 

INTEGER le_pos_sesiones
INTEGER le_cuenta_dias
STRING ls_columna 
INTEGER le_errores_fechas, le_NO_encontro_horas, le_encontro_horas

// Se hace ciclo para validar cada una de las sesiones capturadas. 
FOR le_pos = 1 TO  dw_detalle_sesiones.ROWCOUNT() 

	le_cve_dia = dw_detalle_sesiones.GETITEMNUMBER(le_pos, "cve_dia")  
	IF ISNULL(le_cve_dia) THEN 
		MESSAGEBOX("Aviso", "No se ha especificado el día. ")  
		lb_error = TRUE 
		ls_columna =  "cve_dia"
		EXIT 
	END IF
	
	le_hora_inicio = dw_detalle_sesiones.GETITEMNUMBER(le_pos, "hora_inicio")  
	IF ISNULL(le_hora_inicio) THEN  
		MESSAGEBOX("Aviso", "No se ha especificado la hora de inicio. ")   
		lb_error = TRUE 
		ls_columna =  "hora_inicio"
		EXIT 		
	END IF
	
	le_hora_final = dw_detalle_sesiones.GETITEMNUMBER(le_pos, "hora_final")  
	IF ISNULL(le_hora_final) THEN  
		MESSAGEBOX("Aviso", "No se ha especificado la hora final. ")   
		lb_error = TRUE 
		ls_columna =  "hora_final"
		EXIT 				
	END IF
	
	ldt_fecha_inicio = dw_detalle_sesiones.GETITEMDATETIME(le_pos, "fecha_inicio")  
	IF ISNULL(ldt_fecha_inicio) OR ldt_fecha_inicio = ldt_fecha_compara THEN  
		MESSAGEBOX("Aviso", "No se ha especificado la fecha de inicio. ")   
		lb_error = TRUE 
		ls_columna =  "fecha_inicio"
		EXIT 		
	END IF
	
	ldt_fecha_fin = dw_detalle_sesiones.GETITEMDATETIME(le_pos, "fecha_fin")  
	IF ISNULL(ldt_fecha_fin) OR ldt_fecha_fin = ldt_fecha_compara THEN  
		MESSAGEBOX("Aviso", "No se ha especificado la fecha de fin. ")    
		lb_error = TRUE 
		ls_columna =  "fecha_fin"
		EXIT 				
	END IF

	// Se verifica el dia.
	ls_cadena = "cve_dia = " + STRING(le_cve_dia)  
	le_pos_enc = 0
	le_cuenta_dias = 0
	le_NO_encontro_horas = 0
	le_encontro_horas = 0
	DO	
	
		le_pos_enc = ids_grupo_horario.FIND(ls_cadena, le_pos_enc + 1, ids_grupo_horario.ROWCOUNT() + 1)  
		
		IF le_pos_enc <= 0 AND le_cuenta_dias = 0 THEN 
			MESSAGEBOX("Aviso", "El dia " + UPPER(is_dia[le_cve_dia + 1]) + " no se encuentra especificado en el horario. ") 
			lb_error = TRUE 
			ls_columna =  "cve_dia"
			RETURN -1  
		END IF 	
		IF le_pos_enc <= 0 THEN EXIT 
		
		le_cuenta_dias++
		
		
		// Si encuentra el día, toma los límites del horario definido.
		le_hora_inicio_enc = ids_grupo_horario.GETITEMNUMBER(le_pos_enc, "hora_inicio") 
		le_hora_final_enc = ids_grupo_horario.GETITEMNUMBER(le_pos_enc, "hora_final") 
	
		// Se verifica la hora de inicio	
		IF le_hora_inicio < le_hora_inicio_enc OR le_hora_inicio >= le_hora_final_enc THEN 
			//MESSAGEBOX("Aviso", "La hora de inicio especificada no es válida.")  
			//lb_error = TRUE 
			le_NO_encontro_horas++
			ls_columna =  "hora_inicio"
			CONTINUE 
			//EXIT 		
		END IF	
	
		// Se verifica la hora final 	
		IF le_hora_final <= le_hora_inicio_enc OR le_hora_final > le_hora_final_enc THEN 
			//MESSAGEBOX("Aviso", "La hora final especificada no es válida.")  
			//lb_error = TRUE 
			le_NO_encontro_horas++
			ls_columna =  "hora_final"
			CONTINUE
			//EXIT 				
		END IF		
		
		// Si pasa las validacioones se incremente el indicador de hora encontrada 
		le_encontro_horas++ 
		le_errores_fechas = 0
		
		// SOLAMENTE SE HACE VALIDACIÓN SOBRE EL INICIO Y FIN DE PERIODO 
		// Se verifica la fecha de inicio de la sesión contra la fecha de inicio del periodo
		IF DATE(ldt_fecha_inicio) < DATE(idt_inicio_semestre) OR DATE(ldt_fecha_inicio) > DATE(idt_fin_semestre) THEN 
			le_errores_fechas++
			CONTINUE
		END IF 	
		
		// Se verifica la fecha final de la sesión contra la fecha final del periodo
		IF DATE(ldt_fecha_fin) < DATE(idt_inicio_semestre) OR DATE(ldt_fecha_fin) > DATE(idt_fin_semestre) THEN  
			le_errores_fechas++			
			CONTINUE
		END IF 			


		
//		// Se hace ciclo sobre las sesiones generales definidas para validar el rango de fechas.
//		FOR le_pos_sesiones = 1 TO ids_sesiones.ROWCOUNT() 
//		
//			// Hace un barrido de las fechas para verificar que las fechas estén dentro de algúno de los rangos definidos. 
//			ldt_fecha_inicio_enc = DATE(ids_sesiones .GETITEMDATETIME(le_pos_sesiones, "fecha_inicio")) 
//			ldt_fecha_fin_enc = DATE(ids_sesiones .GETITEMDATETIME(le_pos_sesiones, "fecha_fin")) 
//			
//			// Se verifica la fecha de inicio 
//			IF DATE(ldt_fecha_inicio) < ldt_fecha_inicio_enc OR DATE(ldt_fecha_inicio) > ldt_fecha_fin_enc THEN 
//				le_errores_fechas++
//				CONTINUE
//			END IF 	
//			
//			// Se verifica la fecha final 
//			IF DATE(ldt_fecha_fin) < ldt_fecha_inicio_enc OR DATE(ldt_fecha_fin) > ldt_fecha_fin_enc THEN  
//				le_errores_fechas++			
//				CONTINUE
//			END IF 	
//		
//		NEXT
		
		IF le_errores_fechas = ids_sesiones.ROWCOUNT() THEN 
			MESSAGEBOX("Aviso", "Error en el rango de fechas especificado.")   
			lb_error = TRUE 
			ls_columna =  "fecha_fin"
		END IF 

	LOOP WHILE le_pos_enc > 0 
	
	IF le_NO_encontro_horas > 0 AND le_encontro_horas = 0 THEN 
			MESSAGEBOX("Aviso", "El horario especificado no es válido.")  
			lb_error = TRUE 
			ls_columna =  "hora_final"
	END IF 		
	
	IF lb_error THEN EXIT 
	
NEXT 

// Se verifica un error de datos incompletos 
IF lb_error THEN 
	//dw_detalle_sesiones.SETROW(le_pos) 
	dw_detalle_sesiones.SELECTROW(0, FALSE)
	dw_detalle_sesiones.SELECTROW(le_pos, TRUE)
	dw_detalle_sesiones.SETCOLUMN(ls_columna)
	RETURN -1 
END IF 

RETURN 0 

//
//INTEGER le_pos , ll_pos_sesion, ll_ttl_sesion 
//INTEGER le_ttl_profs
//		
//INTEGER le_dia , le_dia_ses
//INTEGER le_hora_inicio, le_hora_inicio_ses
//INTEGER le_hora_fin, le_hora_fin_ses
//		
//DATETIME ldt_inicio 
//DATETIME ldt_fin 
//DATETIME ldt_limpia 
//
//DATETIME ldt_inicio_sesion 
//DATETIME ldt_fin_sesion  
//
//STRING ls_busqueda
//
//INTEGER le_pos_enc
//BOOLEAN lb_error_rango 
//BOOLEAN lb_error
//INTEGER le_row_error 
//INTEGER le_rows_correcto
//
//ll_ttl_sesion = ids_grupo_sesion.ROWCOUNT()  
//le_ttl_profs = dw_horario_profesor.ROWCOUNT() 
//
//FOR le_pos = 1 TO le_ttl_profs 
//
//	le_dia = dw_horario_profesor.GETITEMNUMBER(le_pos, "cve_dia")  
//	IF ISNULL(le_dia) THEN CONTINUE 
//	le_hora_inicio = dw_horario_profesor.GETITEMNUMBER(le_pos, "hora_inicio") 
//	IF ISNULL(le_hora_inicio) THEN CONTINUE 
//	le_hora_fin = dw_horario_profesor.GETITEMNUMBER(le_pos, "hora_final")  
//	IF ISNULL(le_hora_fin) THEN CONTINUE 
//
//	ldt_inicio = dw_horario_profesor.GETITEMDATETIME(le_pos, "fecha_inicio") 
//	IF ISNULL(ldt_inicio) OR ldt_inicio = ldt_limpia THEN CONTINUE 
//	ldt_fin = dw_horario_profesor.GETITEMDATETIME(le_pos, "fecha_fin") 
//	IF ISNULL(ldt_fin) OR ldt_fin = ldt_limpia THEN CONTINUE 
//	
//	IF ldt_inicio >= ldt_fin THEN 
//		
//		MESSAGEBOX("Error", "La fecha INICIAL debe se MENOR a la fecha FINAL.") 
//		dw_horario_profesor. SELECTROW(le_pos, TRUE) 
//		
//	END IF
//	
//	// Se busca el dia y hora dentro de las sesiones propuestas para el grupo. 
//	ls_busqueda =  "cve_dia = " + STRING(le_dia) + " AND hora_inicio = " + STRING(le_hora_inicio) + " AND hora_final = " + STRING(le_hora_fin)   
//
//	le_rows_correcto = 0 
//	le_pos_enc = 0
//	lb_error_rango = FALSE 
//	
//	FOR ll_pos_sesion = 1 TO ll_ttl_sesion 
//		
//		le_dia_ses = ids_grupo_sesion.GETITEMNUMBER(ll_pos_sesion, "cve_dia")  
//		le_hora_inicio_ses = ids_grupo_sesion.GETITEMNUMBER(ll_pos_sesion, "hora_inicio")  
//		le_hora_fin_ses = ids_grupo_sesion.GETITEMNUMBER(ll_pos_sesion, "hora_final")  
//		ldt_inicio_sesion = ids_grupo_sesion.GETITEMDATETIME(ll_pos_sesion, "fecha_inicio") 
//		ldt_fin_sesion = ids_grupo_sesion.GETITEMDATETIME(ll_pos_sesion, "fecha_fin")  		
//	
//		// Si se trata del mismo dia y hora.
//		IF le_dia = le_dia_ses AND le_hora_inicio = le_hora_inicio_ses AND le_hora_fin = le_hora_fin_ses THEN 
//			
//			// Si no entra en el rango de fechas marca error 
//			IF (ldt_inicio < ldt_inicio_sesion OR ldt_inicio > ldt_fin_sesion OR ldt_fin < ldt_inicio_sesion OR ldt_fin > ldt_fin_sesion)  THEN   
//				le_row_error = le_pos 
//				lb_error_rango = TRUE 
//			// Si encuentra el rango, apaga el error 
//			ELSE 	
//				le_rows_correcto ++
//			END IF	
//		END IF 
//	
//	NEXT 
//	
//	// Si no hubo sesiones que contengan el horario y hubo registros fuera de rango, se despliega error 
//	IF le_rows_correcto = 0 AND lb_error_rango THEN 
//
//		MESSAGEBOX("Error", "El rango de fechas especificado se encuentra fuera de las sesiones especificadas ")  
//		dw_horario_profesor.SELECTROW(le_pos, TRUE)  
//		RETURN -1 	
//	
//	END IF
//	
//NEXT 
//
//RETURN 0 
//
////		MESSAGEBOX("Error", "El rango de fechas especificado se encuentra fuera de las sesiones especificadas: " + & 
////							"~n Dia: " + is_dia[le_dia_ses + 1] + "~n Hora Inicio: " + STRING(le_hora_inicio_ses) + "~n Hora Final: " + STRING(le_hora_fin_ses) + & 
////							"~n Fecha Inicio: " + STRING(ldt_inicio_sesion) + "~n Fecha Fin: " + STRING(ldt_fin_sesion))  
//
//
//
//
//
//
//
//
//
//
//
//
//
////
////INTEGER le_pos 
////INTEGER le_ttl_profs
////		
////INTEGER le_dia
////INTEGER le_hora_inicio
////INTEGER le_hora_fin
////		
////DATETIME ldt_inicio 
////DATETIME ldt_fin 
////DATETIME ldt_limpia 
////
////DATETIME ldt_inicio_sesion 
////DATETIME ldt_fin_sesion  
////
////STRING ls_busqueda
////
////INTEGER le_pos_enc
////BOOLEAN lb_rango
////
////
////le_ttl_profs = dw_horario_profesor.ROWCOUNT() 
////
////FOR le_pos = 1 TO le_ttl_profs 
////
////	le_dia = dw_horario_profesor.GETITEMNUMBER(le_pos, "cve_dia")  
////	IF ISNULL(le_dia) THEN CONTINUE 
////	le_hora_inicio = dw_horario_profesor.GETITEMNUMBER(le_pos, "hora_inicio") 
////	IF ISNULL(le_hora_inicio) THEN CONTINUE 
////	le_hora_fin = dw_horario_profesor.GETITEMNUMBER(le_pos, "hora_final")  
////	IF ISNULL(le_hora_fin) THEN CONTINUE 
////
////	ldt_inicio = dw_horario_profesor.GETITEMDATETIME(le_pos, "fecha_inicio") 
////	IF ISNULL(ldt_inicio) OR ldt_inicio = ldt_limpia THEN CONTINUE 
////	ldt_fin = dw_horario_profesor.GETITEMDATETIME(le_pos, "fecha_fin") 
////	IF ISNULL(ldt_fin) OR ldt_fin = ldt_limpia THEN CONTINUE 
////	
////	IF ldt_inicio >= ldt_fin THEN 
////		
////		MESSAGEBOX("Error", "La fecha INICIAL debe se MENOR a la fecha FINAL.") 
////		dw_horario_profesor. SELECTROW(le_pos, TRUE) 
////		
////	END IF
////	
////	// Se busca el dia y hora dentro de las sesiones propuestas para el grupo. 
////	ls_busqueda =  "cve_dia = " + STRING(le_dia) + " AND hora_inicio = " + STRING(le_hora_inicio) + " AND hora_final = " + STRING(le_hora_fin)   
////
////	le_pos_enc = 0
////	lb_rango = FALSE 
////	DO 
////		
////		le_pos_enc = ids_grupo_sesion.FIND(ls_busqueda, le_pos_enc + 1, ids_grupo_sesion.ROWCOUNT() + 1)   
////		
////		IF le_pos_enc > 0 THEN 
////			
////			ldt_inicio_sesion = ids_grupo_sesion.GETITEMDATETIME(le_pos_enc, "fecha_inicio") 
////			ldt_fin_sesion = ids_grupo_sesion.GETITEMDATETIME(le_pos_enc, "fecha_fin")  
////			
////			IF (ldt_inicio < ldt_inicio_sesion OR ldt_inicio >= ldt_fin_sesion) OR (ldt_fin <= ldt_inicio_sesion OR ldt_fin >  ldt_fin_sesion) THEN  
////				MESSAGEBOX("Error", "Existen fechas fuera del rango de las seciones definidas.") 
////				dw_horario_profesor. SELECTROW(le_pos, TRUE) 
////				RETURN -1 
////			END IF 
////			
//////			IF (DATE(ldt_inicio) < DATE(ldt_inicio_sesion) OR DATE(ldt_inicio) > DATE(ldt_fin)) AND le_pos_enc >= ids_grupo_sesion.ROWCOUNT()  THEN 
//////				MESSAGEBOX("Error", "La fecha INICIAL esta fuera de las sesiones definidas.")			
//////				dw_horario_profesor.SETROW(le_pos)
//////				dw_horario_profesor.SETCOLUMN("fecha_inicio")
//////				SETFOCUS(dw_horario_profesor)
//////				RETURN -1 
//////			ELSEIF (DATE(ldt_fin) < DATE(ldt_inicio_sesion) OR DATE(ldt_fin) > DATE(ldt_fin_sesion)) AND  le_pos_enc >= ids_grupo_sesion.ROWCOUNT()  THEN 
//////				MESSAGEBOX("Error", "La fecha FINAL esta fuera de las sesiones definidas.")			 
//////				dw_horario_profesor.SETROW(le_pos)
//////				dw_horario_profesor.SETCOLUMN("fecha_fin")			
//////				SETFOCUS(dw_horario_profesor)
//////				RETURN -1 
//////			ELSE
//////				lb_rango = TRUE 
//////			END IF			
////			
////		ELSE 
////			
////			MESSAGEBOX("Error", "El dia y hora especificado no existe en las sesiones definidas.") 
////			SETFOCUS(dw_horario_profesor)
////			RETURN -1
////		 	
////		END IF 
////		
////	LOOP WHILE (le_pos_enc > 0 AND NOT lb_rango)  	
////	
////NEXT 
////
////RETURN 0 
////
////
////
////
//
//
//
//
//
//
////	le_cve_dia = ids_grupo_sesion.GETITEMNUMBER(le_pos_sesion, "cve_dia") 
////	le_hora_inicio = ids_grupo_sesion.GETITEMNUMBER(le_pos_sesion, "hora_inicio")  
////	le_hora_final = ids_grupo_sesion.GETITEMNUMBER(le_pos_sesion, "hora_final") 
////	ldt_fecha_inicio = ids_grupo_sesion.GETITEMDATETIME(le_pos_sesion, "fecha_inicio")  
////	ldt_fecha_fin	 = ids_grupo_sesion.GETITEMDATETIME(le_pos_sesion, "fecha_fin")  	
end function

public function integer wf_valida_duplicados ();
INTEGER le_pos 
INTEGER le_ttl_profs
		
DATETIME ldt_inicio 
DATETIME ldt_fin 
DATETIME ldt_limpia 

INTEGER le_cve_dia
INTEGER le_hora_inicio
INTEGER le_hora_final 
INTEGER le_pos_valida 

/**/
INTEGER le_pos_2 
		
DATETIME ldt_inicio_2 
DATETIME ldt_fin_2 

INTEGER le_cve_dia_2
INTEGER le_hora_inicio_2
INTEGER le_hora_final_2 
INTEGER le_pos_valida_2 
/**/

le_ttl_profs = dw_detalle_sesiones.ROWCOUNT() 

FOR le_pos = 1 TO le_ttl_profs 

	ldt_inicio = dw_detalle_sesiones.GETITEMDATETIME(le_pos, "fecha_inicio") 
	ldt_fin = dw_detalle_sesiones.GETITEMDATETIME(le_pos, "fecha_fin") 
	le_cve_dia = dw_detalle_sesiones.GETITEMNUMBER(le_pos, "cve_dia") 
	le_hora_inicio = dw_detalle_sesiones.GETITEMNUMBER(le_pos, "hora_inicio") 
	le_hora_final = dw_detalle_sesiones.GETITEMNUMBER(le_pos, "hora_final") 
		
	FOR le_pos_2 = 1 TO le_ttl_profs 
	
		ldt_inicio_2 = dw_detalle_sesiones.GETITEMDATETIME(le_pos_2, "fecha_inicio") 
		ldt_fin_2 = dw_detalle_sesiones.GETITEMDATETIME(le_pos_2, "fecha_fin") 
		le_cve_dia_2 = dw_detalle_sesiones.GETITEMNUMBER(le_pos_2, "cve_dia") 
		le_hora_inicio_2 = dw_detalle_sesiones.GETITEMNUMBER(le_pos_2, "hora_inicio") 
		le_hora_final_2 = dw_detalle_sesiones.GETITEMNUMBER(le_pos_2, "hora_final") 	
	
		IF 	ldt_inicio = ldt_inicio_2 AND ldt_fin = ldt_fin_2 AND le_cve_dia = le_cve_dia_2 AND le_hora_inicio = le_hora_inicio_2 AND & 
				le_hora_final = le_hora_final_2 AND le_pos_2 <> le_pos THEN 
			MESSAGEBOX("Error", "El grupo tiene sesiones duplicadas." )  
			
			dw_detalle_sesiones.SCROLLTOROW(le_pos_2)
			dw_detalle_sesiones.SELECTROW(le_pos_2, TRUE)
			dw_detalle_sesiones.SELECTROW(le_pos, TRUE)
			
			RETURN -1 
		END IF
	
	NEXT	
		
NEXT 

RETURN 0 





end function

on w_sesiones_grupo_detalle.create
this.dw_detalle_sesiones=create dw_detalle_sesiones
this.mc_profesor=create mc_profesor
this.pb_borra_profesor=create pb_borra_profesor
this.pb_inserta_profesor=create pb_inserta_profesor
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.dw_detalle_sesiones,&
this.mc_profesor,&
this.pb_borra_profesor,&
this.pb_inserta_profesor,&
this.cb_2,&
this.cb_1}
end on

on w_sesiones_grupo_detalle.destroy
destroy(this.dw_detalle_sesiones)
destroy(this.mc_profesor)
destroy(this.pb_borra_profesor)
destroy(this.pb_inserta_profesor)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;

iuo_grupo_paso = message.powerobjectparm


//ids_grupo_sesion.DATAOBJECT = iuo_grupo_paso.ids_grupo_sesion.DATAOBJECT 
INTEGER le_resultado
//le_resultado = iuo_grupo_paso.ids_grupo_sesion.ROWSCOPY(1, iuo_grupo_paso.ids_grupo_sesion.ROWCOUNT(), PRIMARY!, ids_grupo_sesion, 1, PRIMARY!) 

datawindowchild ldw_dias
dw_detalle_sesiones.GETCHILD("cve_dia", ldw_dias)  
ldw_dias.SETTRANSOBJECT(gtr_sce) 
ldw_dias.RETRIEVE() 

iuo_grupo_paso.ids_grupo_sesion.ROWSCOPY(1, iuo_grupo_paso.ids_grupo_sesion.ROWCOUNT(), PRIMARY!, dw_detalle_sesiones, 1, PRIMARY!) 

ids_grupo_horario = CREATE DATASTORE  
ids_grupo_horario.DATAOBJECT = iuo_grupo_paso.ids_horario.DATAOBJECT 
iuo_grupo_paso.ids_horario.ROWSCOPY(1, iuo_grupo_paso.ids_horario.ROWCOUNT(), PRIMARY!, ids_grupo_horario, 1, PRIMARY!) 

ids_sesiones = CREATE DATASTORE 
//ids_sesiones.DATAOBJECT = iuo_grupo_paso.ids_sesiones.DATAOBJECT 
ids_sesiones = iuo_grupo_paso.ids_sesiones 

ie_modo_opera = iuo_grupo_paso.ie_modo_opera
ie_modo = iuo_grupo_paso.ie_modo 


idt_inicio_semestre = iuo_grupo_paso.idt_inicio_semestre
idt_fin_semestre = iuo_grupo_paso.idt_fin_semestre



//itr_sce = gtr_sce  
//wf_despliega_horarios()
dw_detalle_sesiones.SetRowFocusIndicator(Hand!) 

dw_detalle_sesiones.SETSORT("fecha_inicio asc, cve_dia asc")
dw_detalle_sesiones.SORT() 

INTEGER le_row  
FOR le_row = 1 TO dw_detalle_sesiones.ROWCOUNT() 
	dw_detalle_sesiones.SETITEM(le_row, "horario_modular_orden", le_row)
NEXT

ie_anio = iuo_grupo_paso.ie_anio



// Si esta en modo consulta, inhabilita ls caontroles. 
IF ie_modo_opera = 2 AND ie_modo = 2 THEN 
	
	dw_detalle_sesiones.MODIFY("cve_dia.PROTECT = 1")
	dw_detalle_sesiones.Modify("cve_dia.Background.Color = '67108864'")
	dw_detalle_sesiones.MODIFY("hora_inicio.PROTECT = 1")
	dw_detalle_sesiones.Modify("hora_inicio.Background.Color = '67108864'")
	dw_detalle_sesiones.MODIFY("hora_final.PROTECT = 1")
	dw_detalle_sesiones.Modify("hora_final.Background.Color = '67108864'")
	dw_detalle_sesiones.MODIFY("fecha_inicio.PROTECT = 1")
	dw_detalle_sesiones.Modify("fecha_inicio.Background.Color = '67108864'")
	dw_detalle_sesiones.MODIFY("fecha_fin.PROTECT = 1")
	dw_detalle_sesiones.Modify("fecha_fin.Background.Color = '67108864'")
	pb_inserta_profesor.ENABLED = FALSE 
	pb_borra_profesor.ENABLED = FALSE 
	cb_2.ENABLED = FALSE 	
	
END IF 	

gnv_app.inv_security.of_SetSecurity(THIS)







//dw_detalle_sesiones.accepttext( )

//ldw_dias.SETFILTER("cve_dia in (" + iuo_grupo_paso.is_dias_cve_dia + ")") 
//ldw_dias.FILTER() 


// Se toma como referencia la fecha de inicio y fin DEL PERIODO
// La vigencia del CURSO SE DETERMINA POR LAS SESIONES DEL PROFESOR CAPTURADAS
//idt_inicio_titular = iuo_grupo_paso.idt_inicio_semestre 
//idt_fin_titular = iuo_grupo_paso.idt_fin_semestre 









end event

type dw_detalle_sesiones from datawindow within w_sesiones_grupo_detalle
integer x = 73
integer y = 40
integer width = 2551
integer height = 1220
integer taborder = 60
string title = "none"
string dataobject = "dw_horario_modular"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type mc_profesor from monthcalendar within w_sesiones_grupo_detalle
boolean visible = false
integer x = 3671
integer y = 280
integer width = 1253
integer height = 760
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long titletextcolor = 134217742
long trailingtextcolor = 134217745
long monthbackcolor = 1073741824
long titlebackcolor = 134217741
weekday firstdayofweek = sunday!
integer maxselectcount = 31
integer scrollrate = 1
boolean todaysection = true
boolean todaycircle = true
boolean border = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;
//THIS.GetSelectedDate(idt_fecha_profesor) 
//
//IF is_fecha_selec = "F" THEN 
//	dw_horario_profesor.SETITEM(dw_horario_profesor.GETROW(), "fecha_fin", idt_fecha_profesor)
//ELSE
//	dw_horario_profesor.SETITEM(dw_horario_profesor.GETROW(), "fecha_inicio", idt_fecha_profesor)
//END IF
//
//THIS.VISIBLE = FALSE 
//
end event

type pb_borra_profesor from picturebutton within w_sesiones_grupo_detalle
integer x = 2793
integer y = 60
integer width = 110
integer height = 96
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "DeleteRow!"
alignment htextalign = left!
end type

event clicked;INTEGER le_row 

le_row = dw_detalle_sesiones.GETROW()

IF le_row > 0 THEN dw_detalle_sesiones.DELETEROW(le_row) 




end event

type pb_inserta_profesor from picturebutton within w_sesiones_grupo_detalle
integer x = 2670
integer y = 60
integer width = 110
integer height = 96
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Insert5!"
alignment htextalign = left!
end type

event clicked;INTEGER le_row


le_row = PARENT.dw_detalle_sesiones.INSERTROW(0) 

DATE ldt_fecha 
ldt_fecha = DATE("01/01/" + STRING(ie_anio)) 
dw_detalle_sesiones.SETITEM(le_row, "fecha_inicio", ldt_fecha)
dw_detalle_sesiones.SETITEM(le_row, "fecha_fin", ldt_fecha)


FOR le_row = 1 TO dw_detalle_sesiones.ROWCOUNT() 
	dw_detalle_sesiones.SETITEM(le_row, "horario_modular_orden", le_row)
NEXT



//PARENT.dw_detalle_sesiones.SETITEM(le_row, "cve_profesor", il_cve_prof)
//PARENT.dw_horario_profesor.SETITEM(le_row, "nombre", is_prof)  


end event

type cb_2 from commandbutton within w_sesiones_grupo_detalle
integer x = 1765
integer y = 1304
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
end type

event clicked;
dw_detalle_sesiones.ACCEPTTEXT() 

// Se validan sesiones duplicadas.
IF wf_valida_duplicados() < 0 THEN RETURN 

// Se valida la información capturada. 
IF wf_valida_sesiones() < 0 THEN RETURN 

uo_grupo_paso luo_grupo_paso 
luo_grupo_paso.ids_grupo_sesion.DATAOBJECT = dw_detalle_sesiones.DATAOBJECT 
dw_detalle_sesiones.ROWSCOPY(1, dw_detalle_sesiones.ROWCOUNT(), PRIMARY!, luo_grupo_paso.ids_grupo_sesion, 1, PRIMARY!) 

CLOSEWITHRETURN(w_sesiones_grupo_detalle, luo_grupo_paso) 

RETURN 0 

//IF wf_valida_fecha()  < 0 THEN RETURN 0
//
//IF iuo_grupo_paso.is_sesion = 'S' THEN 
//	IF wf_valida_sesiones() < 0 THEN RETURN 0 
//END IF 
//
///////////////////////////////////////////////////////////////////////////////////////
//
//INTEGER le_pos 
//INTEGER le_ttl_profs
//		
//DATETIME ldt_inicio 
//DATETIME ldt_fin 
//DATETIME ldt_limpia
//
//INTEGER le_cve_dia
//INTEGER le_hora_inicio
//INTEGER le_hora_final
//
//le_ttl_profs = dw_horario_profesor.ROWCOUNT() 
//
//FOR le_pos = 1 TO le_ttl_profs 
//
//	ldt_inicio = dw_horario_profesor.GETITEMDATETIME(le_pos, "fecha_inicio") 
//	IF ISNULL(ldt_inicio) OR ldt_inicio = ldt_limpia THEN 
//		MESSAGEBOX("Error", "No se han capturado todas las fechas de inicio.")
//		RETURN 0
//	END IF
//	ldt_fin = dw_horario_profesor.GETITEMDATETIME(le_pos, "fecha_fin") 
//	IF ISNULL(ldt_fin) OR ldt_fin = ldt_limpia THEN 
//		MESSAGEBOX("Error", "No se han capturado todas las fechas de fin.")
//		RETURN 0
//	END IF
//		
//
//	le_cve_dia = dw_horario_profesor.GETITEMNUMBER(le_pos, "cve_dia") 
//	IF ISNULL(le_cve_dia) THEN 
//		MESSAGEBOX("Error", "No se han capturado todos los dias de horario.")
//		RETURN 0
//	END IF		
//		
//	le_hora_inicio = dw_horario_profesor.GETITEMNUMBER(le_pos, "hora_inicio") 
//	IF ISNULL(le_hora_inicio) THEN 
//		MESSAGEBOX("Error", "No se han capturado todas las horas de inicio.")
//		RETURN 0
//	END IF				
//	
//	le_hora_final = dw_horario_profesor.GETITEMNUMBER(le_pos, "hora_final") 
//	IF ISNULL(le_hora_final) THEN 
//		MESSAGEBOX("Error", "No se han capturado todas las horas de fin.")
//		RETURN 0
//	END IF						
//		
//NEXT 
///////////////////////////////////////////////////////////////////////////////////////
//
//iuo_grupo_paso.ie_retorno = 1 
//iuo_grupo_paso.ids_horario_profesor.RESET() 
//dw_horario_profesor.ROWSCOPY(1, dw_horario_profesor.ROWCOUNT(), PRIMARY!, iuo_grupo_paso.ids_horario_profesor, 1, PRIMARY! ) 
//CLOSEWITHRETURN(PARENT, iuo_grupo_paso)  
//
//
//
end event

type cb_1 from commandbutton within w_sesiones_grupo_detalle
integer x = 2208
integer y = 1304
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;//iuo_grupo_paso.ie_retorno = 0
//CLOSEWITHRETURN(PARENT, iuo_grupo_paso)  
CLOSE(PARENT) 
end event

