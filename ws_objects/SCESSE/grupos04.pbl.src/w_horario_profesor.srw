$PBExportHeader$w_horario_profesor.srw
forward
global type w_horario_profesor from window
end type
type mc_profesor from monthcalendar within w_horario_profesor
end type
type pb_borra_profesor from picturebutton within w_horario_profesor
end type
type pb_inserta_profesor from picturebutton within w_horario_profesor
end type
type cb_2 from commandbutton within w_horario_profesor
end type
type cb_1 from commandbutton within w_horario_profesor
end type
type dw_horario_profesor from datawindow within w_horario_profesor
end type
end forward

global type w_horario_profesor from window
integer width = 4215
integer height = 1580
boolean titlebar = true
string title = "Horario de Profesores"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
mc_profesor mc_profesor
pb_borra_profesor pb_borra_profesor
pb_inserta_profesor pb_inserta_profesor
cb_2 cb_2
cb_1 cb_1
dw_horario_profesor dw_horario_profesor
end type
global w_horario_profesor w_horario_profesor

type variables
uo_grupo_paso iuo_grupo_paso
STRING is_fecha_selec  
DATE idt_fecha_profesor 

n_tr itr_sce 


LONG il_cve_prof
STRING is_prof 


DATETIME idt_inicio_titular
DATETIME idt_fin_titular


DATASTORE ids_grupo_sesion 

STRING is_dia[7] = {"domingo", "lunes", "martes", "miercoles", "jueves", "viernes", "sabado"} 

INTEGER ie_titular

INTEGER ie_anio
end variables

forward prototypes
public function integer wf_despliega_horarios ()
public function integer wf_valida_hora (integer ai_dia, integer ai_hora)
public function integer wf_valida_fecha ()
public function integer wf_valida_sesiones ()
public function integer wf_valida_horario_duplicado ()
end prototypes

public function integer wf_despliega_horarios ();INTEGER le_pos
INTEGER le_ttl_reg

INTEGER le_cve_dia
INTEGER le_hora_inicio
INTEGER le_hora_final

INTEGER le_pos_hora
INTEGER le_row 

DATAWINDOWCHILD ldwc_profesor
DATAWINDOWCHILD ldwc_horas

dw_horario_profesor.GETCHILD("cve_profesor", ldwc_profesor)   
dw_horario_profesor.GETCHILD("cve_dia", ldwc_horas)   

LONG ll_cve_profesor
STRING ls_profesor_apaterno
STRING ls_profesor_amaterno
STRING ls_profesor_nombre

INTEGER le_titular 
LONG ll_cve_titular
DATETIME ldt_inicio_titular
DATETIME ldt_fin_titular
STRING ls_dias, ls_coma



// Se llena el DWC de profesores. 
le_ttl_reg = iuo_grupo_paso.ids_profesor.ROWCOUNT()  

FOR le_pos = 1 TO le_ttl_reg  

	ll_cve_profesor = iuo_grupo_paso.ids_profesor.GETITEMNUMBER(le_pos, "cve_profesor")  
	ls_profesor_apaterno = iuo_grupo_paso.ids_profesor.GETITEMSTRING(le_pos, "profesor_apaterno")  
	IF ISNULL(ls_profesor_apaterno) THEN ls_profesor_apaterno = "" 
	ls_profesor_amaterno = iuo_grupo_paso.ids_profesor.GETITEMSTRING(le_pos, "profesor_amaterno")  
	IF ISNULL(ls_profesor_amaterno ) THEN ls_profesor_amaterno  = "" 
	ls_profesor_nombre = iuo_grupo_paso.ids_profesor. GETITEMSTRING(le_pos, "profesor_nombre")  
	IF ISNULL(ls_profesor_nombre) THEN ls_profesor_nombre = "" 
	
//	le_titular = iuo_grupo_paso.ids_profesor. GETITEMNUMBER(le_pos, "titularidad")   
//	IF le_titular = 1 THEN 

	IF ll_cve_profesor = iuo_grupo_paso.il_cve_profesor THEN 
		ll_cve_titular = ll_cve_profesor  
		ldt_inicio_titular = iuo_grupo_paso.ids_profesor.GETITEMDATETIME(le_pos, "fecha_inicio") 
		ldt_fin_titular = iuo_grupo_paso.ids_profesor.GETITEMDATETIME(le_pos, "fecha_fin") 
		
		idt_inicio_titular = ldt_inicio_titular
		idt_fin_titular = ldt_fin_titular
		
	END IF
	

	le_row = ldwc_profesor.INSERTROW(0)  
	ldwc_profesor.SETITEM(le_row, "cve_profesor", ll_cve_profesor)
	ldwc_profesor.SETITEM(le_row, "nombre", STRING(ll_cve_profesor) + "-" + ls_profesor_apaterno + " " + ls_profesor_amaterno + " " + ls_profesor_nombre) 

	il_cve_prof = ll_cve_profesor 
	is_prof = STRING(ll_cve_profesor) + "-" + ls_profesor_apaterno + " " + ls_profesor_amaterno + " " + ls_profesor_nombre	

NEXT 

// Se verifica si se recibe una captura previa.
// Se despliega la captura previa 
IF iuo_grupo_paso.ids_horario_profesor.ROWCOUNT() > 0 THEN 
	
	iuo_grupo_paso.ids_horario_profesor.ROWSCOPY(1, iuo_grupo_paso.ids_horario_profesor.ROWCOUNT(), PRIMARY!, dw_horario_profesor, 1, PRIMARY!) 

// Se llena información default para edición.
ELSE


	le_ttl_reg = iuo_grupo_paso.ids_horario.ROWCOUNT() 
	
	FOR le_pos = 1 TO le_ttl_reg 
		
		le_cve_dia = iuo_grupo_paso.ids_horario.GETITEMNUMBER(le_pos, "cve_dia")   
		IF ISNULL(le_cve_dia) THEN CONTINUE
		le_hora_inicio = iuo_grupo_paso.ids_horario.GETITEMNUMBER(le_pos, "hora_inicio")   
		le_hora_final = iuo_grupo_paso.ids_horario.GETITEMNUMBER(le_pos, "hora_final")  
		
		le_row = dw_horario_profesor.INSERTROW(0) 
		dw_horario_profesor.SETITEM(le_row, "cve_profesor", iuo_grupo_paso.il_cve_profesor) 
		dw_horario_profesor.SETITEM(le_row, "cve_dia", le_cve_dia)  
		dw_horario_profesor.SETITEM(le_row, "hora_inicio", le_hora_inicio)    
		dw_horario_profesor.SETITEM(le_row, "hora_final", le_hora_final)   
		dw_horario_profesor.SETITEM(le_row, "fecha_inicio", ldt_inicio_titular)
		dw_horario_profesor.SETITEM(le_row, "fecha_fin", ldt_fin_titular) 
		
		ls_dias = ls_dias + ls_coma + STRING(le_cve_dia) 
		
		ls_coma = "," 
		
	NEXT 


END IF


DATAWINDOWCHILD ldwc_dias
dw_horario_profesor.GETCHILD("cve_dia", ldwc_dias)  
ldwc_dias.SETTRANSOBJECT(itr_sce) 
ldwc_dias.RETRIEVE() 
ldwc_dias.SETFILTER("cve_dia IN(" + ls_dias + ")") 
ldwc_dias.FILTER() 





RETURN 0










//	FOR le_pos_hora = le_hora_inicio TO le_hora_final STEP 1
//		
//		le_row = dw_horario_profesor.INSERTROW(0) 
//		dw_horario_profesor.SETITEM(le_row, "cve_dia", le_cve_dia)  
//		dw_horario_profesor.SETITEM(le_row, "hora", le_pos_hora) 
//		dw_horario_profesor.SETITEM(le_row, "horario", STRING(le_pos_hora) + "-" + STRING(le_pos_hora + 1)) 
//		dw_horario_profesor.SETITEM(le_row, "cve_profesor", iuo_grupo_paso.il_cve_profesor)
//		
//		dw_horario_profesor.SETITEM(le_row, "fecha_inicio", ldt_inicio_titular)
//		dw_horario_profesor.SETITEM(le_row, "fecha_fin", ldt_fin_titular)
//		
//		hora_inicio
//		hora_final
//		
//	NEXT 






end function

public function integer wf_valida_hora (integer ai_dia, integer ai_hora);
INTEGER le_row 
INTEGER le_hora_inicio
INTEGER le_hora_final
INTEGER le_errores

le_row = iuo_grupo_paso.ids_horario.FIND("cve_dia = " + STRING(ai_dia), 1, iuo_grupo_paso.ids_horario.ROWCOUNT()) 

DO WHILE le_row > 0 

	le_hora_inicio = iuo_grupo_paso.ids_horario.GETITEMNUMBER(le_row, "hora_inicio")  
	le_hora_final = iuo_grupo_paso.ids_horario.GETITEMNUMBER(le_row, "hora_final") 
	
	IF (ai_hora < le_hora_inicio OR ai_hora > le_hora_final)  THEN 
		
		le_errores++ 
		le_row = iuo_grupo_paso.ids_horario.FIND("cve_dia = " + STRING(ai_dia), le_row + 1, iuo_grupo_paso.ids_horario.ROWCOUNT() + 1)   
		
//		IF le_row = iuo_grupo_paso.ids_horario.ROWCOUNT() THEN 
//			MESSAGEBOX("Aviso", "La hora seleccionada no es válida, debe estar entre " + STRING(le_hora_inicio)  + " y " + STRING(le_hora_final)) 
//			RETURN -1 
//		ELSE
//			le_row = iuo_grupo_paso.ids_horario.FIND("cve_dia = " + STRING(ai_dia), le_row + 1, iuo_grupo_paso.ids_horario.ROWCOUNT())  
//		END IF

	ELSE
		RETURN 0 
	END IF 

LOOP 


IF le_errores >  0 THEN 
	MESSAGEBOX("Aviso", "La hora seleccionada no es válida, debe estar entre " + STRING(le_hora_inicio)  + " y " + STRING(le_hora_final)) 
	RETURN -1
ELSE 	
	RETURN 0  
END IF 	

// ------------------------------------------------------------------------------------------------------
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


//RETURN 0 




end function

public function integer wf_valida_fecha ();
INTEGER le_pos 
INTEGER le_ttl_profs
		
DATETIME ldt_inicio 
DATETIME ldt_fin 
DATETIME ldt_limpia

le_ttl_profs = dw_horario_profesor.ROWCOUNT() 

FOR le_pos = 1 TO le_ttl_profs 

	ldt_inicio = dw_horario_profesor.GETITEMDATETIME(le_pos, "fecha_inicio") 
	IF ISNULL(ldt_inicio) OR ldt_inicio = ldt_limpia OR (MONTH(DATE(ldt_inicio)) = 1 AND (DAY(DATE(ldt_inicio))) = 1) THEN CONTINUE 
	ldt_fin = dw_horario_profesor.GETITEMDATETIME(le_pos, "fecha_fin") 
	IF ISNULL(ldt_fin) OR ldt_fin = ldt_limpia OR (MONTH(DATE(ldt_fin)) = 1 AND (DAY(DATE(ldt_fin))) = 1)   THEN CONTINUE  
	
	IF DATE(ldt_inicio) < DATE(idt_inicio_titular) OR DATE(ldt_inicio) > DATE(idt_fin_titular) OR DATE(ldt_inicio) > DATE(ldt_fin)  THEN 
		MESSAGEBOX("Error", "La fecha INICIAL esta fuera del periodo asignado al Profesor.")			
		dw_horario_profesor.SETROW(le_pos)
		dw_horario_profesor.SETCOLUMN("fecha_inicio")
		SETFOCUS(dw_horario_profesor)
		RETURN -1 
	ELSEIF DATE(ldt_fin) < DATE(idt_inicio_titular) OR DATE(ldt_fin) > DATE(idt_fin_titular) THEN 
		MESSAGEBOX("Error", "La fecha FINAL esta fuera del periodo asignado al Profesor.")			
		dw_horario_profesor.SETROW(le_pos)
		dw_horario_profesor.SETCOLUMN("fecha_fin")			
		SETFOCUS(dw_horario_profesor)
		RETURN -1 
	END IF
	

		
		
		
NEXT 

RETURN 0 





end function

public function integer wf_valida_sesiones ();
INTEGER le_pos , ll_pos_sesion, ll_ttl_sesion 
INTEGER le_ttl_profs
		
INTEGER le_dia , le_dia_ses
INTEGER le_hora_inicio, le_hora_inicio_ses
INTEGER le_hora_fin, le_hora_fin_ses
		
DATETIME ldt_inicio 
DATETIME ldt_fin 
DATETIME ldt_limpia 

DATETIME ldt_inicio_sesion 
DATETIME ldt_fin_sesion  

STRING ls_busqueda

INTEGER le_pos_enc
BOOLEAN lb_error_rango 
BOOLEAN lb_error
INTEGER le_row_error 
INTEGER le_rows_correcto

ll_ttl_sesion = ids_grupo_sesion.ROWCOUNT()  
le_ttl_profs = dw_horario_profesor.ROWCOUNT() 

FOR le_pos = 1 TO le_ttl_profs 

	le_dia = dw_horario_profesor.GETITEMNUMBER(le_pos, "cve_dia")  
	IF ISNULL(le_dia) THEN CONTINUE 
	le_hora_inicio = dw_horario_profesor.GETITEMNUMBER(le_pos, "hora_inicio") 
	IF ISNULL(le_hora_inicio) THEN CONTINUE 
	le_hora_fin = dw_horario_profesor.GETITEMNUMBER(le_pos, "hora_final")  
	IF ISNULL(le_hora_fin) THEN CONTINUE 

	ldt_inicio = dw_horario_profesor.GETITEMDATETIME(le_pos, "fecha_inicio") 
	IF ISNULL(ldt_inicio) OR ldt_inicio = ldt_limpia THEN CONTINUE 
	ldt_fin = dw_horario_profesor.GETITEMDATETIME(le_pos, "fecha_fin") 
	IF ISNULL(ldt_fin) OR ldt_fin = ldt_limpia THEN CONTINUE 
	
	IF ldt_inicio > ldt_fin THEN 
		
		MESSAGEBOX("Error", "La fecha INICIAL debe se MENOR a la fecha FINAL.") 
		dw_horario_profesor. SELECTROW(le_pos, TRUE) 
		
	END IF
	
	// Se busca el dia y hora dentro de las sesiones propuestas para el grupo. 
	ls_busqueda =  "cve_dia = " + STRING(le_dia) + " AND hora_inicio = " + STRING(le_hora_inicio) + " AND hora_final = " + STRING(le_hora_fin)   

	le_rows_correcto = 0 
	le_pos_enc = 0
	lb_error_rango = FALSE 
	
	FOR ll_pos_sesion = 1 TO ll_ttl_sesion 
		
		le_dia_ses = ids_grupo_sesion.GETITEMNUMBER(ll_pos_sesion, "cve_dia")  
		le_hora_inicio_ses = ids_grupo_sesion.GETITEMNUMBER(ll_pos_sesion, "hora_inicio")  
		le_hora_fin_ses = ids_grupo_sesion.GETITEMNUMBER(ll_pos_sesion, "hora_final")  
		ldt_inicio_sesion = ids_grupo_sesion.GETITEMDATETIME(ll_pos_sesion, "fecha_inicio") 
		ldt_fin_sesion = ids_grupo_sesion.GETITEMDATETIME(ll_pos_sesion, "fecha_fin")  		
	
		// Si se trata del mismo dia y hora.
		IF le_dia = le_dia_ses AND le_hora_inicio = le_hora_inicio_ses AND le_hora_fin = le_hora_fin_ses THEN 
			
			// Si no entra en el rango de fechas marca error 
			IF (ldt_inicio < ldt_inicio_sesion OR ldt_inicio > ldt_fin_sesion OR ldt_fin < ldt_inicio_sesion OR ldt_fin > ldt_fin_sesion)  THEN   
				le_row_error = le_pos 
				lb_error_rango = TRUE 
			// Si encuentra el rango, apaga el error 
			ELSE 	
				le_rows_correcto ++
			END IF	
		END IF 
	
	NEXT 
	
	// Si no hubo sesiones que contengan el horario y hubo registros fuera de rango, se despliega error 
	IF le_rows_correcto = 0 AND lb_error_rango THEN 

		MESSAGEBOX("Error", "El rango de fechas especificado se encuentra fuera de las sesiones especificadas ")  
		dw_horario_profesor.SELECTROW(le_pos, TRUE)  
		RETURN -1 	
	
	END IF
	
NEXT 

RETURN 0 

//		MESSAGEBOX("Error", "El rango de fechas especificado se encuentra fuera de las sesiones especificadas: " + & 
//							"~n Dia: " + is_dia[le_dia_ses + 1] + "~n Hora Inicio: " + STRING(le_hora_inicio_ses) + "~n Hora Final: " + STRING(le_hora_fin_ses) + & 
//							"~n Fecha Inicio: " + STRING(ldt_inicio_sesion) + "~n Fecha Fin: " + STRING(ldt_fin_sesion))  













//
//INTEGER le_pos 
//INTEGER le_ttl_profs
//		
//INTEGER le_dia
//INTEGER le_hora_inicio
//INTEGER le_hora_fin
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
//BOOLEAN lb_rango
//
//
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
//	le_pos_enc = 0
//	lb_rango = FALSE 
//	DO 
//		
//		le_pos_enc = ids_grupo_sesion.FIND(ls_busqueda, le_pos_enc + 1, ids_grupo_sesion.ROWCOUNT() + 1)   
//		
//		IF le_pos_enc > 0 THEN 
//			
//			ldt_inicio_sesion = ids_grupo_sesion.GETITEMDATETIME(le_pos_enc, "fecha_inicio") 
//			ldt_fin_sesion = ids_grupo_sesion.GETITEMDATETIME(le_pos_enc, "fecha_fin")  
//			
//			IF (ldt_inicio < ldt_inicio_sesion OR ldt_inicio >= ldt_fin_sesion) OR (ldt_fin <= ldt_inicio_sesion OR ldt_fin >  ldt_fin_sesion) THEN  
//				MESSAGEBOX("Error", "Existen fechas fuera del rango de las seciones definidas.") 
//				dw_horario_profesor. SELECTROW(le_pos, TRUE) 
//				RETURN -1 
//			END IF 
//			
////			IF (DATE(ldt_inicio) < DATE(ldt_inicio_sesion) OR DATE(ldt_inicio) > DATE(ldt_fin)) AND le_pos_enc >= ids_grupo_sesion.ROWCOUNT()  THEN 
////				MESSAGEBOX("Error", "La fecha INICIAL esta fuera de las sesiones definidas.")			
////				dw_horario_profesor.SETROW(le_pos)
////				dw_horario_profesor.SETCOLUMN("fecha_inicio")
////				SETFOCUS(dw_horario_profesor)
////				RETURN -1 
////			ELSEIF (DATE(ldt_fin) < DATE(ldt_inicio_sesion) OR DATE(ldt_fin) > DATE(ldt_fin_sesion)) AND  le_pos_enc >= ids_grupo_sesion.ROWCOUNT()  THEN 
////				MESSAGEBOX("Error", "La fecha FINAL esta fuera de las sesiones definidas.")			 
////				dw_horario_profesor.SETROW(le_pos)
////				dw_horario_profesor.SETCOLUMN("fecha_fin")			
////				SETFOCUS(dw_horario_profesor)
////				RETURN -1 
////			ELSE
////				lb_rango = TRUE 
////			END IF			
//			
//		ELSE 
//			
//			MESSAGEBOX("Error", "El dia y hora especificado no existe en las sesiones definidas.") 
//			SETFOCUS(dw_horario_profesor)
//			RETURN -1
//		 	
//		END IF 
//		
//	LOOP WHILE (le_pos_enc > 0 AND NOT lb_rango)  	
//	
//NEXT 
//
//RETURN 0 
//
//
//
//






//	le_cve_dia = ids_grupo_sesion.GETITEMNUMBER(le_pos_sesion, "cve_dia") 
//	le_hora_inicio = ids_grupo_sesion.GETITEMNUMBER(le_pos_sesion, "hora_inicio")  
//	le_hora_final = ids_grupo_sesion.GETITEMNUMBER(le_pos_sesion, "hora_final") 
//	ldt_fecha_inicio = ids_grupo_sesion.GETITEMDATETIME(le_pos_sesion, "fecha_inicio")  
//	ldt_fecha_fin	 = ids_grupo_sesion.GETITEMDATETIME(le_pos_sesion, "fecha_fin")  	
end function

public function integer wf_valida_horario_duplicado ();

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

le_ttl_profs = dw_horario_profesor.ROWCOUNT() 

FOR le_pos = 1 TO le_ttl_profs 

	ldt_inicio = dw_horario_profesor.GETITEMDATETIME(le_pos, "fecha_inicio") 
	ldt_fin = dw_horario_profesor.GETITEMDATETIME(le_pos, "fecha_fin") 
	le_cve_dia = dw_horario_profesor.GETITEMNUMBER(le_pos, "cve_dia") 
	le_hora_inicio = dw_horario_profesor.GETITEMNUMBER(le_pos, "hora_inicio") 
	le_hora_final = dw_horario_profesor.GETITEMNUMBER(le_pos, "hora_final") 
		
	FOR le_pos_2 = 1 TO le_ttl_profs 
	
		ldt_inicio_2 = dw_horario_profesor.GETITEMDATETIME(le_pos_2, "fecha_inicio") 
		ldt_fin_2 = dw_horario_profesor.GETITEMDATETIME(le_pos_2, "fecha_fin") 
		le_cve_dia_2 = dw_horario_profesor.GETITEMNUMBER(le_pos_2, "cve_dia") 
		le_hora_inicio_2 = dw_horario_profesor.GETITEMNUMBER(le_pos_2, "hora_inicio") 
		le_hora_final_2 = dw_horario_profesor.GETITEMNUMBER(le_pos_2, "hora_final") 	
	
		IF 	ldt_inicio = ldt_inicio_2 AND ldt_fin = ldt_fin_2 AND le_cve_dia = le_cve_dia_2 AND le_hora_inicio = le_hora_inicio_2 AND & 
				le_hora_final = le_hora_final_2 AND le_pos_2 <> le_pos THEN 
			MESSAGEBOX("Error", "El profesor tiene horarios duplicados." )  
			
			dw_horario_profesor.SCROLLTOROW(le_pos_2)
			dw_horario_profesor.SELECTROW(le_pos_2, TRUE)
			dw_horario_profesor.SELECTROW(le_pos, TRUE)
			
			RETURN -1 
		END IF
	
	NEXT	
		
NEXT 

RETURN 0 





end function

on w_horario_profesor.create
this.mc_profesor=create mc_profesor
this.pb_borra_profesor=create pb_borra_profesor
this.pb_inserta_profesor=create pb_inserta_profesor
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_horario_profesor=create dw_horario_profesor
this.Control[]={this.mc_profesor,&
this.pb_borra_profesor,&
this.pb_inserta_profesor,&
this.cb_2,&
this.cb_1,&
this.dw_horario_profesor}
end on

on w_horario_profesor.destroy
destroy(this.mc_profesor)
destroy(this.pb_borra_profesor)
destroy(this.pb_inserta_profesor)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_horario_profesor)
end on

event open;

iuo_grupo_paso = message.powerobjectparm

ids_grupo_sesion = CREATE DATASTORE 
ids_grupo_sesion.DATAOBJECT = iuo_grupo_paso.ids_sesiones.DATAOBJECT 
INTEGER le_resultado
le_resultado = iuo_grupo_paso.ids_sesiones.ROWSCOPY(1, iuo_grupo_paso.ids_sesiones.ROWCOUNT(), PRIMARY!, ids_grupo_sesion, 1, PRIMARY!) 

itr_sce = gtr_sce 
wf_despliega_horarios()
dw_horario_profesor.SetRowFocusIndicator(Hand!) 


datawindowchild ldw_dias

dw_horario_profesor.GETCHILD("cve_dia", ldw_dias)  
ldw_dias.SETFILTER("cve_dia in (" + iuo_grupo_paso.is_dias_cve_dia + ")") 
ldw_dias.FILTER() 


// Se toma como referencia la fecha de inicio y fin DEL PERIODO
// La vigencia del CURSO SE DETERMINA POR LAS SESIONES DEL PROFESOR CAPTURADAS
idt_inicio_titular = iuo_grupo_paso.idt_inicio_semestre 
idt_fin_titular = iuo_grupo_paso.idt_fin_semestre 

ie_anio = YEAR(DATE(idt_inicio_titular)) 

ie_titular = iuo_grupo_paso.ie_titular

il_cve_prof = iuo_grupo_paso.il_cve_profesor

gnv_app.inv_security.of_SetSecurity(THIS)




end event

type mc_profesor from monthcalendar within w_horario_profesor
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

event doubleclicked;THIS.GetSelectedDate(idt_fecha_profesor) 

IF is_fecha_selec = "F" THEN 
	dw_horario_profesor.SETITEM(dw_horario_profesor.GETROW(), "fecha_fin", idt_fecha_profesor)
ELSE
	dw_horario_profesor.SETITEM(dw_horario_profesor.GETROW(), "fecha_inicio", idt_fecha_profesor)
END IF

THIS.VISIBLE = FALSE 

end event

type pb_borra_profesor from picturebutton within w_horario_profesor
integer x = 4055
integer y = 64
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

le_row = dw_horario_profesor.GETROW()

IF le_row > 0 THEN dw_horario_profesor.DELETEROW(le_row) 




end event

type pb_inserta_profesor from picturebutton within w_horario_profesor
integer x = 3931
integer y = 64
integer width = 110
integer height = 96
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Insert5!"
alignment htextalign = left!
end type

event clicked;INTEGER le_row

le_row = PARENT.dw_horario_profesor.INSERTROW(0) 

PARENT.dw_horario_profesor.SETITEM(le_row, "cve_profesor", il_cve_prof)
//PARENT.dw_horario_profesor.SETITEM(le_row, "nombre", is_prof)  


DATE ldt_fecha 

ldt_fecha =  DATE("01/01/" + STRING(ie_anio))  
dw_horario_profesor.SETITEM(le_row, "fecha_inicio", ldt_fecha)
dw_horario_profesor.SETITEM(le_row, "fecha_fin", ldt_fecha)

end event

type cb_2 from commandbutton within w_horario_profesor
integer x = 3017
integer y = 1308
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
end type

event clicked;dw_horario_profesor.ACCEPTTEXT() 

IF wf_valida_fecha()  < 0 THEN RETURN 0

IF iuo_grupo_paso.is_sesion = 'S' THEN 
	IF wf_valida_sesiones() < 0 THEN RETURN 0 
END IF 

IF wf_valida_horario_duplicado() < 0 THEN RETURN 0 

/////////////////////////////////////////////////////////////////////////////////////

INTEGER le_pos 
INTEGER le_ttl_profs
		
DATETIME ldt_inicio 
DATETIME ldt_fin 
DATETIME ldt_limpia

INTEGER le_cve_dia
INTEGER le_hora_inicio
INTEGER le_hora_final  
BOOLEAN lb_valida

le_ttl_profs = dw_horario_profesor.ROWCOUNT() 

// Se valida si el profesor es titular.
IF le_ttl_profs = 0 THEN 
	
	// Si el profesor es Titular y no tiene horario, se permite 
	IF ie_titular = 1 THEN 
		lb_valida = FALSE  
	ELSE 
		lb_valida = TRUE  
	END IF 	
		
END IF 	

IF lb_valida THEN 
	
	IF le_ttl_profs = 0 THEN 
		MESSAGEBOX("Error", "No se han capturado horario para el profesor.") 
		RETURN 0		
	END IF 
	
	FOR le_pos = 1 TO le_ttl_profs 
	
		ldt_inicio = dw_horario_profesor.GETITEMDATETIME(le_pos, "fecha_inicio") 
		IF ISNULL(ldt_inicio) OR ldt_inicio = ldt_limpia THEN 
			MESSAGEBOX("Error", "No se han capturado todas las fechas de inicio.")
			RETURN 0
		END IF
		ldt_fin = dw_horario_profesor.GETITEMDATETIME(le_pos, "fecha_fin") 
		IF ISNULL(ldt_fin) OR ldt_fin = ldt_limpia THEN 
			MESSAGEBOX("Error", "No se han capturado todas las fechas de fin.")
			RETURN 0
		END IF
			
	
		le_cve_dia = dw_horario_profesor.GETITEMNUMBER(le_pos, "cve_dia") 
		IF ISNULL(le_cve_dia) THEN 
			MESSAGEBOX("Error", "No se han capturado todos los dias de horario.")
			RETURN 0
		END IF		
			
		le_hora_inicio = dw_horario_profesor.GETITEMNUMBER(le_pos, "hora_inicio") 
		IF ISNULL(le_hora_inicio) THEN 
			MESSAGEBOX("Error", "No se han capturado todas las horas de inicio.")
			RETURN 0
		END IF				
		
		le_hora_final = dw_horario_profesor.GETITEMNUMBER(le_pos, "hora_final") 
		IF ISNULL(le_hora_final) THEN 
			MESSAGEBOX("Error", "No se han capturado todas las horas de fin.")
			RETURN 0
		END IF						
			
	NEXT 
	
END IF 	
/////////////////////////////////////////////////////////////////////////////////////

iuo_grupo_paso.ie_retorno = 1 
iuo_grupo_paso.ids_horario_profesor.RESET() 
dw_horario_profesor.ROWSCOPY(1, dw_horario_profesor.ROWCOUNT(), PRIMARY!, iuo_grupo_paso.ids_horario_profesor, 1, PRIMARY! ) 
CLOSEWITHRETURN(PARENT, iuo_grupo_paso)  



end event

type cb_1 from commandbutton within w_horario_profesor
integer x = 3461
integer y = 1308
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

event clicked;iuo_grupo_paso.ie_retorno = 0
CLOSEWITHRETURN(PARENT, iuo_grupo_paso)  
end event

type dw_horario_profesor from datawindow within w_horario_profesor
integer x = 69
integer y = 52
integer width = 3794
integer height = 1200
integer taborder = 10
string title = "none"
string dataobject = "dw_horario_prof_grupo"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;
//IF iuo_grupo_paso.is_sesion = "S" THEN 
//	
//	POST wf_valida_sesiones() 
//	
////	IF wf_valida_sesiones( ) < 0 THEN RETURN 2 
////	
//	RETURN 0 
//	
//END IF 


THIS.SELECTROW(0, FALSE) 

CHOOSE CASE dwo.name 
		
	CASE "cve_dia" 
		
	CASE "hora_inicio", "hora_final"
		
		INTEGER le_dia
		
		le_dia = THIS.GETITEMNUMBER(row, "cve_dia") 
		IF ISNULL(le_dia) THEN 
			MESSAGEBOX("Aviso", "No ha seleccionado el día") 
			RETURN 2
		END IF
			
		IF wf_valida_hora(le_dia, INTEGER(data)) < 0 THEN 
			RETURN 2 
		END IF
		
	CASE "fecha_inicio"
		
		POST wf_valida_fecha()  
		
		
		
	CASE "fecha_fin"
		
		POST wf_valida_fecha()  

END CHOOSE 



end event

event clicked;
IF dwo.name = "b_fecha_fin" OR dwo.name = "b_fecha_inicio" THEN    
	
	DATETIME ldt_seleccionada
	DATETIME ldt_lmp
	
	mc_profesor.x = dw_horario_profesor.x + PixelsToUnits(xpos , XPixelsToUnits!)
	mc_profesor.y = dw_horario_profesor.y + PixelsToUnits(ypos , YPixelsToUnits!)
	IF dwo.name = "b_fecha_fin"  THEN 
		ldt_seleccionada = THIS.GETITEMDATETime( row, "fecha_inicio") 
		//IF ISNULL(ldt_seleccionada) OR ldt_seleccionada = ldt_lmp THEN ldt_seleccionada = iuo_grupo_servicios.idt_fin_periodo
		mc_profesor.SetSelectedDate (DATE(ldt_seleccionada)) 
		is_fecha_selec = "F" 
	ELSE
		ldt_seleccionada = THIS.GETITEMDATETime( row, "fecha_inicio") 
		//IF ISNULL(ldt_seleccionada) OR ldt_seleccionada = ldt_lmp THEN ldt_seleccionada = iuo_grupo_servicios.idt_inicio_periodo 
		mc_profesor.SetSelectedDate (DATE(ldt_seleccionada))
		is_fecha_selec = "I" 
	END IF
	mc_profesor.VISIBLE = TRUE  
	THIS.SETROW(row)

	POST wf_valida_fecha()  

END IF 

dw_horario_profesor.SELECTROW(0, FALSE)



end event

