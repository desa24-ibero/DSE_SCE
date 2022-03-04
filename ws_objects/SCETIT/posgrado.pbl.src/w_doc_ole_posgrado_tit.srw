$PBExportHeader$w_doc_ole_posgrado_tit.srw
forward
global type w_doc_ole_posgrado_tit from w_doc_ole_posgrado
end type
end forward

global type w_doc_ole_posgrado_tit from w_doc_ole_posgrado
integer height = 1520
string title = "Documentos de Posgrado (Titulación)"
end type
global w_doc_ole_posgrado_tit w_doc_ole_posgrado_tit

forward prototypes
public function integer wf_valida_duplicado_pos (long al_cve_cuenta, long al_cve_carrera, long al_cve_plan)
end prototypes

public function integer wf_valida_duplicado_pos (long al_cve_cuenta, long al_cve_carrera, long al_cve_plan);//long ll_posicion_coma, ll_indice_arreglo, ll_ano_expedicion_orig
//string ls_mensaje
//integer li_resultado, li_valida
//
//li_valida = 0
//
//
///* Obtenemos fecha expedición del titulo */
//SELECT year( d.fecha_expedicion )
//   INTO  :ll_ano_expedicion_orig
//  FROM titulacion t, diseño_titulacion d
//WHERE t.cuenta = d.cuenta
//	AND t.cve_carrera = d.cve_carrera
//	AND t.cve_plan = d.cve_plan
//	AND t.cuenta = :al_cve_cuenta
//	AND t.cve_carrera = :al_cve_carrera
//	AND t.cve_plan = :al_cve_plan
// USING gtr_sce;
//	
//If ll_ano_expedicion_orig >= 2005 Then
//
//	/* CARTA DE NO ADEUDO */
//	SELECT IsNull(count(*), 0)
//	INTO :li_valida
//	FROM bit_documento_titulacion b
//	WHERE  b.cuenta  = :al_cve_cuenta
//	AND b.cve_carrera = :al_cve_carrera
//	AND b.cve_plan = :al_cve_plan
//	AND b.cve_documento = 52
//	USING gtr_sce;
//	
//	li_resultado= gtr_sce.SqlCode
//	ls_mensaje= gtr_sce.SqlErrText
//	
//	If li_resultado = -1 Then
//		MessageBox("Error de consulta en wf_valida_duplicado_pos", ls_mensaje, StopSign!)
//		return li_resultado
//	Else 
//		If li_resultado = 100 Or li_valida <= 0 Then
//			MessageBox("Error de consulta en wf_valida_duplicado_pos", "No se encontro el registro previo documento (52)", StopSign!)
//			return -1
//		  End If
//	End If
//	
//	
//	/*  ACTA DE EXAMEN (MAESTRIA) */
//	SELECT IsNull(count(*), 0)
//	INTO :li_valida
//	FROM bit_documento_titulacion b
//	WHERE  b.cuenta  = :al_cve_cuenta
//	AND b.cve_carrera = :al_cve_carrera
//	AND b.cve_plan = :al_cve_plan
//	AND b.cve_documento = 12
//	USING gtr_sce;
//	
//	li_resultado= gtr_sce.SqlCode
//	ls_mensaje= gtr_sce.SqlErrText
//	
//	If li_resultado = -1 Then
//		MessageBox("Error de consulta en wf_valida_duplicado_pos", ls_mensaje, StopSign!)
//		return li_resultado
//	Else 
//		If li_resultado = 100 Or li_valida <= 0 Then
//			MessageBox("Error de consulta en wf_valida_duplicado_pos", "No se encontro el registro previo documento (12)", StopSign!)
//			return -1
//		 End If
//	End If
//	
//	return 0
//Else
	return 0
//End If
end function

on w_doc_ole_posgrado_tit.create
int iCurrent
call super::create
end on

on w_doc_ole_posgrado_tit.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;long ll_rows

dw_documento_titulacion.SetTransObject(gtr_sce)
ll_rows= dw_documento_titulacion.Retrieve(17)

x=1
y=1

iuo_atencion_posgrado = CREATE uo_atencion_posgrado
end event

type cb_seleccion from w_doc_ole_posgrado`cb_seleccion within w_doc_ole_posgrado_tit
boolean visible = false
integer x = 2011
integer y = 1456
end type

type st_3 from w_doc_ole_posgrado`st_3 within w_doc_ole_posgrado_tit
boolean visible = true
integer x = 206
integer y = 1484
end type

type uo_tipo_documento from w_doc_ole_posgrado`uo_tipo_documento within w_doc_ole_posgrado_tit
boolean visible = false
integer x = 736
integer y = 1456
end type

type ole_documento from w_doc_ole_posgrado`ole_documento within w_doc_ole_posgrado_tit
integer y = 884
end type

type dw_documento_titulacion from w_doc_ole_posgrado`dw_documento_titulacion within w_doc_ole_posgrado_tit
integer y = 404
end type

event dw_documento_titulacion::doubleclicked;long ll_cuenta, ll_cve_documento, ll_cve_carrera, ll_cve_plan, ll_valido_duplicar
integer li_res, li_res_obten_fecha_opcion, li_res_usa_folio_existente
string ls_query_datos, ls_query_definicion, ls_columnas_marcas[], ls_valores[]
boolean lb_procede_tramite, lb_alumno_susceptible
datetime ldttm_fecha_examen, ldttm_fecha_nula
long ll_opcion_titulacion, ll_long_nulo, ll_inserta_folio_monedas, ll_folio_monedas, ll_inserta_posgrado
long ll_cve_carrera_rg, ll_cve_plan_rg, ll_carrera_plan_rg, ll_carrera_resol_adm_rg
long ll_inserta_posgrado_egc, ll_existe_alumno_egc

SetNull(ldttm_fecha_nula)
SetNull(ll_long_nulo)
ll_cuenta = uo_datos_opc_cero_i.of_obten_cuenta()
ll_cve_carrera = uo_datos_opc_cero_i.of_obten_cve_carrera()
ll_cve_plan= uo_datos_opc_cero_i.of_obten_cve_plan(ll_cuenta)

ll_cve_documento = this.GetItemNumber(row, "cve_documento")	

lb_procede_tramite = uo_datos_opc_cero_i.of_procede_tramite()

if not lb_procede_tramite then
	MessageBox("Error","El alumno no ha sido diagnosticado para el trámite",StopSign!)
	return
end if

// Si se trata de un duplicado de titulo de posgrado No se realiza la validacion de alumno susceptible SFF Mayo 2014
IF NOT (ll_cve_documento = 81 OR ll_cve_documento = 82)  Then
	lb_alumno_susceptible =iuo_atencion_posgrado.of_alumno_susceptible_tit(ll_cuenta, ll_cve_carrera, ll_cve_plan)
	if not lb_alumno_susceptible then
		MessageBox("Error","El alumno no es susceptible del trámite",StopSign!)
		return
	end if
End IF

if row <= 0 then
	MessageBox("Error", "No existe el documento base para generar",StopSign!)
	return -1	
end if

ls_valores[1] =string(ll_cuenta)
ls_valores[2] =string(ll_cve_carrera)
ls_valores[3] =string(ll_cve_plan)

if ll_cuenta <> -1 then
	li_res= MessageBox("Confirmacion","¿Desea generar el documento con el papel actual de la impresora ?",Question!,YesNo!)
	if li_res = 1 then
		ll_cve_documento = this.GetItemNumber(row, "cve_documento")	
		ls_query_datos = this.GetItemString(row, "query_datos")	
		ls_query_definicion = this.GetItemString(row, "query_definicion")	
		ole_documento.of_obten_arreglo_de_string(ls_query_datos, ls_columnas_marcas)
		if upperbound(ls_columnas_marcas) = 0 then
			MessageBox("Error", "No existen marcas a incrustar",StopSign!)
			return
		end if
		if len(trim (ls_query_definicion))= 0 then
			MessageBox("Error", "No existe query de definición",StopSign!)
			return			
		end if
		
//Constancia de examen profesional
		if ll_cve_documento= 1 then
			ll_existe_alumno_egc = of_existe_alumno_egc(ll_cuenta, ll_cve_carrera, ll_cve_plan)			
			if ll_existe_alumno_egc = -1 then 				
				MessageBox("Error", "No es posible consultar al alumno en examen general de conocimientos",StopSign!)
				return				
			end if
			//Examen general de conocimientos
			li_res_obten_fecha_opcion = of_obten_fecha_opcion(ll_cuenta, ll_cve_carrera, ll_cve_plan, ldttm_fecha_examen , ll_opcion_titulacion)
			if li_res_obten_fecha_opcion = -1 then 				
				MessageBox("Error", "No es posible generar el documento",StopSign!)
				return				
			//Examen general de conocimientos
			elseif isnull(ll_opcion_titulacion) and ll_existe_alumno_egc = 0 then
				MessageBox("La opcion de titulacion es nula", "No es posible generar el documento",StopSign!)
				return					
			elseif ll_opcion_titulacion = 5 or ll_existe_alumno_egc >= 1 then			
				if isnull(ldttm_fecha_examen) then
					MessageBox("La fecha del examen es nula", "No es posible generar el documento",StopSign!)
					return					
				end if
				ll_inserta_posgrado_egc= of_inserta_posgrado_egc(ll_cuenta, ll_cve_carrera, ll_cve_plan)
				if ll_inserta_posgrado_egc= -1 then
					li_res_usa_folio_existente = MessageBox("Error de Inserción","No es posible insertar al alumno de examen general de conocimientos",StopSign!)								
					return				
				else
					if ole_documento.of_imprime_documento(ll_cve_documento, ls_valores, false,false) =0 then
							MessageBox("Impresion Exitosa", "El documento se ha impreso exitosamente",Information!)
					end if					
				end if
			else
				if ole_documento.of_imprime_documento(ll_cve_documento, ls_valores, false,false) =0 then
					MessageBox("Impresion Exitosa", "El documento se ha impreso exitosamente",Information!)
				end if										
			end if		
		
//Recibo de monedas	
		elseif ll_cve_documento= 21 then
			ll_folio_monedas= of_existe_folio_monedas(ll_cuenta, ll_cve_carrera, ll_cve_plan)
			if ll_folio_monedas>0 then
				li_res_usa_folio_existente = MessageBox("Existe un folio anterior para el alumno", "¿Desea reutilizarlo?",Question!, YesNo!)								
			end if 	
			if ll_folio_monedas=0 or li_res_usa_folio_existente=2 then			
					li_res_obten_fecha_opcion = of_obten_fecha_opcion(ll_cuenta, ll_cve_carrera, ll_cve_plan, ldttm_fecha_examen , ll_opcion_titulacion)
					if li_res_obten_fecha_opcion = -1 then 				
						MessageBox("Error", "No es posible generar el documento",StopSign!)
						return
					else
						if isnull(ldttm_fecha_examen) then
							MessageBox("La fecha del examen es nula", "No es posible generar el documento",StopSign!)
							return					
						end if 
						if isnull(ll_opcion_titulacion) then
							MessageBox("La opcion de titulacion es nula", "No es posible generar el documento",StopSign!)
							return					
						end if 
						ll_inserta_folio_monedas = of_inserta_folio_monedas(ll_cuenta, ll_cve_carrera, ll_cve_plan, ldttm_fecha_examen , ll_opcion_titulacion,0,0)
						if ll_inserta_folio_monedas = -1 then 				
							MessageBox("Error en la foliación de monedas", "No es posible generar el documento",StopSign!)
							return
						else
							if ole_documento.of_imprime_documento(ll_cve_documento, ls_valores, false,false) =0 then
								MessageBox("Impresion Exitosa", "El documento se ha impreso exitosamente",Information!)
							end if					
						end if				
					end if
			else
				if ole_documento.of_imprime_documento(ll_cve_documento, ls_valores, false,false) =0 then
					MessageBox("Impresion Exitosa", "El documento se ha impreso exitosamente",Information!)
				end if										
			end if		
		elseif ll_cve_documento= 58 or ll_cve_documento= 59 or ll_cve_documento= 61 or ll_cve_documento= 64 or ll_cve_documento= 69 then
			ll_carrera_plan_rg = of_obten_carrera_plan_rg(ll_cve_carrera, ll_cve_plan, ll_cve_carrera_rg, ll_cve_plan_rg)
			if	ll_carrera_plan_rg= -1 then
				MessageBox("Error", "No es posible consultar la carrera y plan R.G.",StopSign!)
				return							
			elseif ll_carrera_plan_rg= 0 then
				MessageBox("Error", "No existe una carrera equivalente R.G.",StopSign!)
				return											
			end if			

//			ll_carrera_resol_adm_rg = f_es_carrera_resol_adm_rg(ll_cve_carrera_rg, ll_cve_plan_rg)	
//			if	ll_carrera_resol_adm_rg= -1 then
//				MessageBox("Error", "No es posible consultar la resolución administrativa R.G.",StopSign!)
//				return							
//			elseif ll_carrera_resol_adm_rg = 0 then
//				ll_cve_documento = 58
//			elseif ll_carrera_resol_adm_rg > 0 then
//				ll_cve_documento = 59
//			end if			
			
			
			
			ll_inserta_posgrado= of_inserta_posgrado_rg(ll_cuenta, ll_cve_carrera, ll_cve_plan)
			if ll_inserta_posgrado= -1 then
				MessageBox("Error", "No es posible generar insertar al alumno en el plan regularizado",StopSign!)
				return			
			end if 	
			
			ls_valores[1] =string(ll_cuenta)
			ls_valores[2] =string(ll_cve_carrera_rg)
			ls_valores[3] =string(ll_cve_plan_rg)
			
			if ole_documento.of_imprime_documento(ll_cve_documento, ls_valores, false,false) =0 then
				MessageBox("Impresion Exitosa", "El documento se ha impreso exitosamente",Information!)
			end if
			
		else			
			if ole_documento.of_imprime_documento(ll_cve_documento, ls_valores, false,false) =0 then
				MessageBox("Impresion Exitosa", "El documento se ha impreso exitosamente",Information!)
			end if
		end if
		
	end if
end if

end event

type uo_datos_opc_cero_i from w_doc_ole_posgrado`uo_datos_opc_cero_i within w_doc_ole_posgrado_tit
end type

