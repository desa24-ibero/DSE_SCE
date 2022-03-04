$PBExportHeader$w_doc_ole_posgrado_arch.srw
forward
global type w_doc_ole_posgrado_arch from w_doc_ole_posgrado
end type
end forward

global type w_doc_ole_posgrado_arch from w_doc_ole_posgrado
integer height = 1520
string title = "Documentos de Posgrado (Archivo)"
end type
global w_doc_ole_posgrado_arch w_doc_ole_posgrado_arch

on w_doc_ole_posgrado_arch.create
int iCurrent
call super::create
end on

on w_doc_ole_posgrado_arch.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;long ll_rows

dw_documento_titulacion.SetTransObject(gtr_sce)
ll_rows= dw_documento_titulacion.Retrieve(18)

x=1
y=1

iuo_atencion_posgrado = CREATE uo_atencion_posgrado
end event

type cb_seleccion from w_doc_ole_posgrado`cb_seleccion within w_doc_ole_posgrado_arch
boolean visible = false
integer x = 2011
integer y = 1456
end type

type st_3 from w_doc_ole_posgrado`st_3 within w_doc_ole_posgrado_arch
boolean visible = true
integer x = 206
integer y = 1484
end type

type uo_tipo_documento from w_doc_ole_posgrado`uo_tipo_documento within w_doc_ole_posgrado_arch
boolean visible = false
integer x = 736
integer y = 1456
end type

type ole_documento from w_doc_ole_posgrado`ole_documento within w_doc_ole_posgrado_arch
integer y = 884
end type

type dw_documento_titulacion from w_doc_ole_posgrado`dw_documento_titulacion within w_doc_ole_posgrado_arch
integer y = 404
end type

event dw_documento_titulacion::doubleclicked;long ll_cuenta, ll_cve_documento, ll_cve_carrera, ll_cve_plan
integer li_res, li_res_obten_fecha_opcion, li_res_usa_folio_existente
string ls_query_datos, ls_query_definicion, ls_columnas_marcas[], ls_valores[]
boolean lb_procede_tramite, lb_alumno_susceptible
datetime ldttm_fecha_examen, ldttm_fecha_nula
long ll_opcion_titulacion, ll_long_nulo, ll_inserta_folio_monedas, ll_folio_monedas

SetNull(ldttm_fecha_nula)
SetNull(ll_long_nulo)
ll_cuenta = uo_datos_opc_cero_i.of_obten_cuenta()
ll_cve_carrera = uo_datos_opc_cero_i.of_obten_cve_carrera()
ll_cve_plan= uo_datos_opc_cero_i.of_obten_cve_plan(ll_cuenta)

lb_procede_tramite = uo_datos_opc_cero_i.of_procede_tramite()
lb_alumno_susceptible =iuo_atencion_posgrado.of_alumno_susceptible_tit(ll_cuenta, ll_cve_carrera, ll_cve_plan)

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
		if ll_cve_documento= 21 then
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
						ll_inserta_folio_monedas = of_inserta_folio_monedas(ll_cuenta, ll_cve_carrera, ll_cve_plan, ldttm_fecha_examen , ll_opcion_titulacion, 0, 0)
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
		else			
			if ole_documento.of_imprime_documento(ll_cve_documento, ls_valores, false,false) =0 then
				MessageBox("Impresion Exitosa", "El documento se ha impreso exitosamente",Information!)
			end if
		end if
	end if
end if

end event

type uo_datos_opc_cero_i from w_doc_ole_posgrado`uo_datos_opc_cero_i within w_doc_ole_posgrado_arch
end type

