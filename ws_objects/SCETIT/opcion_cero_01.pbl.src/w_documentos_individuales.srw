$PBExportHeader$w_documentos_individuales.srw
forward
global type w_documentos_individuales from w_doc_ole_opc_cero
end type
end forward

global type w_documentos_individuales from w_doc_ole_opc_cero
integer x = 466
integer y = 372
integer height = 1517
string title = "Documentos del Trámite de Titulación por Opción Cero"
end type
global w_documentos_individuales w_documentos_individuales

on w_documentos_individuales.create
int iCurrent
call super::create
end on

on w_documentos_individuales.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;long ll_rows

dw_documento_titulacion.SetTransObject(gtr_sce)
ll_rows= dw_documento_titulacion.Retrieve(11)
iuo_atencion_opc_cero = CREATE uo_atencion_opc_cero
x=1
y=1
end event

type uo_datos_opc_cero_i from w_doc_ole_opc_cero`uo_datos_opc_cero_i within w_documentos_individuales
end type

type cb_seleccion from w_doc_ole_opc_cero`cb_seleccion within w_documentos_individuales
boolean visible = false
integer x = 1861
integer y = 1309
end type

type st_3 from w_doc_ole_opc_cero`st_3 within w_documentos_individuales
boolean visible = true
integer x = 55
integer y = 1338
end type

type uo_tipo_documento from w_doc_ole_opc_cero`uo_tipo_documento within w_documentos_individuales
boolean visible = false
integer x = 585
integer y = 1309
end type

type ole_documento from w_doc_ole_opc_cero`ole_documento within w_documentos_individuales
integer y = 896
end type

type dw_documento_titulacion from w_doc_ole_opc_cero`dw_documento_titulacion within w_documentos_individuales
integer y = 416
end type

event dw_documento_titulacion::doubleclicked;long ll_cuenta, ll_cve_documento, ll_cve_carrera, ll_cve_plan
integer li_res
string ls_query_datos, ls_query_definicion, ls_columnas_marcas[], ls_valores[]
boolean lb_procede_tramite, lb_alumno_susceptible

ll_cuenta = uo_datos_opc_cero_i.of_obten_cuenta()
ll_cve_carrera = uo_datos_opc_cero_i.of_obten_cve_carrera()
ll_cve_plan= uo_datos_opc_cero_i.of_obten_cve_plan(ll_cuenta)

lb_procede_tramite = uo_datos_opc_cero_i.of_procede_tramite()

//Por petición expresa, no es necesario revisar si el alumno es susceptible
//lb_alumno_susceptible= true

lb_alumno_susceptible =iuo_atencion_opc_cero.of_alumno_susceptible(ll_cuenta, ll_cve_carrera, ll_cve_plan)

if not lb_procede_tramite then
	MessageBox("Error","El alumno no ha sido diagnosticado para el trámite",StopSign!)
	return
end if

if not lb_procede_tramite or not lb_alumno_susceptible then
	MessageBox("Error","El alumno no es susceptible del trámite",StopSign!)
	return
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

