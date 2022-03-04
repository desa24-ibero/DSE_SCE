$PBExportHeader$w_constancia_a_opc_cero.srw
forward
global type w_constancia_a_opc_cero from w_doc_ole_opc_cero
end type
end forward

global type w_constancia_a_opc_cero from w_doc_ole_opc_cero
integer height = 1516
string title = "Documentos del Trámite de Titulación por Opción Cero"
end type
global w_constancia_a_opc_cero w_constancia_a_opc_cero

forward prototypes
public function integer wf_valida_duplicado_lic (long ai_cve_cuenta, long ai_cve_carrera, long ai_cve_plan)
end prototypes

public function integer wf_valida_duplicado_lic (long ai_cve_cuenta, long ai_cve_carrera, long ai_cve_plan);long ll_posicion_coma, ll_indice_arreglo, ll_ano_expedicion_orig
string ls_mensaje
integer li_resultado, li_valida

li_valida = 0

/* Obtenemos fecha expedición del titulo */
SELECT year( t.fecha_examen )
   INTO  :ll_ano_expedicion_orig
  FROM titulacion t, diseño_titulacion d
WHERE t.cuenta = d.cuenta
	AND t.cve_carrera = d.cve_carrera
	AND t.cve_plan = d.cve_plan
	AND t.cuenta = :ai_cve_cuenta
	AND t.cve_carrera = :ai_cve_carrera
	AND t.cve_plan = :ai_cve_plan
 USING gtr_sce;
	
If ll_ano_expedicion_orig >= 2004 Then
	 /* SOLICITUD DE EXPEDICIÓN DE TÍTULO*/
	SELECT IsNull(count(*), 0)
	INTO :li_valida
	FROM bit_documento_titulacion b
	WHERE  b.cuenta  = :ai_cve_cuenta
	AND b.cve_carrera = :ai_cve_carrera
	AND b.cve_plan = :ai_cve_plan
	AND b.cve_documento = 29
	USING gtr_sce;
	
	li_resultado= gtr_sce.SqlCode
	ls_mensaje= gtr_sce.SqlErrText
	
	If li_resultado = -1 Then
		MessageBox("Error de consulta en wf_valida_duplicado_lic", ls_mensaje, StopSign!)
		return li_resultado
	Else 
		If li_resultado = 100 Or li_valida <= 0 Then
			MessageBox("Error de consulta en wf_valida_duplicado_lic", "No se encontro el registro previo documento (29)", StopSign!)
			return -1
		  End If
	End If
	
	
	/*-- CONSTANCIA DE TITULACION A  */
	SELECT IsNull(count(*), 0)
	INTO :li_valida
	FROM bit_documento_titulacion b
	WHERE  b.cuenta  = :ai_cve_cuenta
	AND b.cve_carrera = :ai_cve_carrera
	AND b.cve_plan = :ai_cve_plan
	AND b.cve_documento = 30
	USING gtr_sce;
	
	li_resultado= gtr_sce.SqlCode
	ls_mensaje= gtr_sce.SqlErrText
	
	If li_resultado = -1 Then
		MessageBox("Error de consulta en wf_valida_duplicado_lic", ls_mensaje, StopSign!)
		return li_resultado
	Else 
		If li_resultado = 100 Or li_valida <= 0 Then
			MessageBox("Error de consulta en wf_valida_duplicado_lic", "No se encontro el registro previo documento (30)", StopSign!)
			return -1
		 End If
	End If

	return 0
	
Else
	return 0
End If
end function

on w_constancia_a_opc_cero.create
int iCurrent
call super::create
end on

on w_constancia_a_opc_cero.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;long ll_rows

dw_documento_titulacion.SetTransObject(gtr_sce)
ll_rows= dw_documento_titulacion.Retrieve(6)
iuo_atencion_opc_cero = CREATE uo_atencion_opc_cero
x=1
y=1
end event

type uo_datos_opc_cero_i from w_doc_ole_opc_cero`uo_datos_opc_cero_i within w_constancia_a_opc_cero
end type

type cb_seleccion from w_doc_ole_opc_cero`cb_seleccion within w_constancia_a_opc_cero
boolean visible = false
integer x = 1861
integer y = 1308
end type

type st_3 from w_doc_ole_opc_cero`st_3 within w_constancia_a_opc_cero
boolean visible = true
integer x = 55
integer y = 1340
end type

type uo_tipo_documento from w_doc_ole_opc_cero`uo_tipo_documento within w_constancia_a_opc_cero
boolean visible = false
integer x = 585
integer y = 1308
end type

type ole_documento from w_doc_ole_opc_cero`ole_documento within w_constancia_a_opc_cero
integer y = 896
end type

type dw_documento_titulacion from w_doc_ole_opc_cero`dw_documento_titulacion within w_constancia_a_opc_cero
integer y = 416
end type

event dw_documento_titulacion::doubleclicked;long ll_cuenta, ll_cve_documento, ll_cve_carrera, ll_cve_plan, ll_valido_duplicar
integer li_res, li_confirmacion
string ls_query_datos, ls_query_definicion, ls_columnas_marcas[], ls_valores[]
boolean lb_procede_tramite, lb_alumno_susceptible, lb_susceptible_diploma

ll_cuenta = uo_datos_opc_cero_i.of_obten_cuenta()
ll_cve_carrera = uo_datos_opc_cero_i.of_obten_cve_carrera()
ll_cve_plan= uo_datos_opc_cero_i.of_obten_cve_plan(ll_cuenta)

ll_cve_documento = this.GetItemNumber(row, "cve_documento")	

lb_procede_tramite = uo_datos_opc_cero_i.of_procede_tramite()
if not lb_procede_tramite then
	MessageBox("Error","El alumno no ha sido diagnosticado para el trámite",StopSign!)
	return
end if

// Si se trata de un duplicado de titulo de licenciatura cambian las validaciones SFF Mayo 2014
IF ll_cve_documento = 80 Then
	ll_valido_duplicar = wf_valida_duplicado_lic (ll_cuenta, ll_cve_carrera, ll_cve_plan)
	If ll_valido_duplicar = -1 Then
		MessageBox("Error","El alumno no es susceptible del trámite",StopSign!)
		return
	End If
Else
	lb_alumno_susceptible =iuo_atencion_opc_cero.of_alumno_susceptible(ll_cuenta, ll_cve_carrera, ll_cve_plan)
	if not lb_alumno_susceptible then
		MessageBox("Error","El alumno no es susceptible del trámite",StopSign!)
		return
	end if
End IF

lb_susceptible_diploma =iuo_atencion_opc_cero.of_susceptible_diploma(ll_cuenta, ll_cve_carrera, ll_cve_plan)

if lb_susceptible_diploma then
	li_confirmacion =MessageBox("Alumno susceptible de Diploma","Es altamente probable que el alumno requiera tramitar un Diploma ~n"+&
	"y no el trámite seleccionado.~n ¿Desea imprimir de todas formas?.",Question!, YesNo!)
	if li_confirmacion<>1 then
		return	
	end if
end if


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
		if ole_documento.of_imprime_documento(ll_cve_documento, ls_valores, false,false) =0 then
			MessageBox("Impresion Exitosa", "El documento se ha impreso exitosamente",Information!)
		end if
	end if
end if

end event

