$PBExportHeader$w_opciones_imprimir_rediseño.srw
forward
global type w_opciones_imprimir_rediseño from window
end type
type em_num_control_estatal from editmask within w_opciones_imprimir_rediseño
end type
type st_num_control_estatal from statictext within w_opciones_imprimir_rediseño
end type
type st_fecha_generacion from statictext within w_opciones_imprimir_rediseño
end type
type em_fecha_generacion from editmask within w_opciones_imprimir_rediseño
end type
type dw_oficio from datawindow within w_opciones_imprimir_rediseño
end type
type dw_otorgado_por from datawindow within w_opciones_imprimir_rediseño
end type
type st_nombre_plan from statictext within w_opciones_imprimir_rediseño
end type
type st_plan_estudios from statictext within w_opciones_imprimir_rediseño
end type
type st_carrera from statictext within w_opciones_imprimir_rediseño
end type
type st_programa from statictext within w_opciones_imprimir_rediseño
end type
type st_oficio_rvoe from statictext within w_opciones_imprimir_rediseño
end type
type st_otorgado_por from statictext within w_opciones_imprimir_rediseño
end type
type dw_historico_sin_traduccion from datawindow within w_opciones_imprimir_rediseño
end type
type uo_i_idioma from uo_idioma within w_opciones_imprimir_rediseño
end type
type st_idioma from statictext within w_opciones_imprimir_rediseño
end type
type st_num_acuerdo from statictext within w_opciones_imprimir_rediseño
end type
type dw_acuerdos_rg from datawindow within w_opciones_imprimir_rediseño
end type
type cb_pos_simples from commandbutton within w_opciones_imprimir_rediseño
end type
type cb_lic_simples from commandbutton within w_opciones_imprimir_rediseño
end type
type em_pagnum from editmask within w_opciones_imprimir_rediseño
end type
type cb_cancel from commandbutton within w_opciones_imprimir_rediseño
end type
type cb_ok from commandbutton within w_opciones_imprimir_rediseño
end type
type cb_configurar from commandbutton within w_opciones_imprimir_rediseño
end type
type rb_pagina from radiobutton within w_opciones_imprimir_rediseño
end type
type rb_total from radiobutton within w_opciones_imprimir_rediseño
end type
type cb_cambiar_nombre from commandbutton within w_opciones_imprimir_rediseño
end type
type gb_1 from groupbox within w_opciones_imprimir_rediseño
end type
type dw_datos_certificado from datawindow within w_opciones_imprimir_rediseño
end type
end forward

global type w_opciones_imprimir_rediseño from window
integer x = 832
integer y = 364
integer width = 3049
integer height = 2000
boolean titlebar = true
string title = "Impresión de Certificados"
windowtype windowtype = popup!
long backcolor = 12632256
boolean center = true
em_num_control_estatal em_num_control_estatal
st_num_control_estatal st_num_control_estatal
st_fecha_generacion st_fecha_generacion
em_fecha_generacion em_fecha_generacion
dw_oficio dw_oficio
dw_otorgado_por dw_otorgado_por
st_nombre_plan st_nombre_plan
st_plan_estudios st_plan_estudios
st_carrera st_carrera
st_programa st_programa
st_oficio_rvoe st_oficio_rvoe
st_otorgado_por st_otorgado_por
dw_historico_sin_traduccion dw_historico_sin_traduccion
uo_i_idioma uo_i_idioma
st_idioma st_idioma
st_num_acuerdo st_num_acuerdo
dw_acuerdos_rg dw_acuerdos_rg
cb_pos_simples cb_pos_simples
cb_lic_simples cb_lic_simples
em_pagnum em_pagnum
cb_cancel cb_cancel
cb_ok cb_ok
cb_configurar cb_configurar
rb_pagina rb_pagina
rb_total rb_total
cb_cambiar_nombre cb_cambiar_nombre
gb_1 gb_1
dw_datos_certificado dw_datos_certificado
end type
global w_opciones_imprimir_rediseño w_opciones_imprimir_rediseño

type variables
string is_numero_acuerdo = ""

n_cortes  in_cortes
end variables

forward prototypes
public function integer wf_imprime_cert_lic (long al_cuenta, long al_cve_carrera, long al_cve_plan, boolean ab_legalizado)
public function integer wf_imprime_certificado (long al_cuenta, long al_cve_carrera, long al_cve_plan, boolean ab_legalizado, string as_nivel)
end prototypes

public function integer wf_imprime_cert_lic (long al_cuenta, long al_cve_carrera, long al_cve_plan, boolean ab_legalizado);//wf_imprime_cert_lic
//Recibe: al_cuenta				long
//				al_cve_carrera		long
//				al_cve_plan			long
//				ab_legalizado		boolean

uo_reporte_dw luo_reporte_dw
uds_datastore lds_certificado, lds_certificado_n
long ll_rows, ll_creditos_cursados
integer li_res_print, li_cve_tipo_documento
string ls_final_reporte[], ls_carrera, ls_anio_plan, ls_nivel
string ls_carrera_sin_prefijo, ls_grado_carrera, ls_grado_con_articulo
string ls_array_inicio[], LineaR1, LineaR2

luo_reporte_dw = CREATE uo_reporte_dw
lds_certificado = CREATE uds_datastore
lds_certificado_n = CREATE uds_datastore

if ab_legalizado then
	lds_certificado.dataobject = "d_certificados_lic_simples"
	lds_certificado_n.dataobject = "d_certificados_lic_simples_n"
else
	lds_certificado.dataobject = "d_certificados_lic_legal"
	lds_certificado_n.dataobject = "d_certificados_lic_legal_n"	
end if

if w_revision_estudios_rediseño.gb_revalidacion.visible = true then
	LineaR1 = "MATERIAS EQUIVALENTES SEGUN "
	if w_revision_estudios_rediseño.rb_oficio.checked = true then
		LineaR1 += "OFICIO No. "
	elseif w_revision_estudios_rediseño.rb_folio.checked = true then
		LineaR1 += "FOLIO No. "
	else
		LineaR1 += "EXPEDIENTE No. "
	end if
	LineaR1 += w_revision_estudios_rediseño.em_numero.text
	LineaR2 = "DE FECHA "+  mid(w_revision_estudios_rediseño.em_fecha.text,1,2)+" DE "+&
					 DameMes(integer(mid(w_revision_estudios_rediseño.em_fecha.text,4,2)))+" DE " +mid(w_revision_estudios_rediseño.em_fecha.text,7,4) 
	ls_array_inicio[1]= LineaR1
	ls_array_inicio[2]= LineaR2	
end if




ls_carrera_sin_prefijo = f_obten_carrera_sin_prefijo(al_cve_carrera)
ls_grado_carrera = f_obten_grado_carrera(al_cve_carrera)
ls_grado_con_articulo = f_obten_grado_con_articulo(ls_grado_carrera)


SetPointer(HourGlass!)
w_revision_estudios_rediseño.dw_prueba.SetSort("tipo A,periodonum A,sigla A")
w_revision_estudios_rediseño.dw_prueba.Sort()

//Certificado TOTAL
ls_carrera = mid(w_revision_estudios_rediseño.st_carrera.text,17)
ll_creditos_cursados= w_revision_estudios_rediseño.dw_revision_est_fmc.getitemnumber(1,"cursadost")
ls_anio_plan= mid(w_revision_estudios_rediseño.st_nivel.text,1,9)
ls_nivel= mid(w_revision_estudios_rediseño.st_nivel.text,11)
if w_revision_estudios_rediseño.dw_revision_est_fmc.getitemstring(1,"completo") = "si" then
	ls_final_reporte[1]="NOTA: Cubre íntegramente las materias y el mínimo de créditos para optar por el TITULO"
	ls_final_reporte[2]="DE LICENCIADO EN " + f_elimina_acentos(ls_carrera)
	ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
else
//Certificado PARCIAL
	ls_final_reporte[1]="NOTA: El presente certificado parcial ampara "+string(ll_creditos_cursados)+" créditos correspondientes al Plan de"
	ls_final_reporte[2]="Estudios "+ls_anio_plan+" de la "+f_elimina_acentos(ls_nivel)+" en "+f_elimina_acentos(ls_carrera )
	ls_final_reporte[3]="---------------------------------------------------------------------------------------------"

end if

//Si es plan 2003
if al_cve_plan= 3 then
	li_cve_tipo_documento=3
else
	li_cve_tipo_documento=1
end if


if luo_reporte_dw.f_genera_cuerpo(li_cve_tipo_documento,w_revision_estudios_rediseño.dw_prueba, al_cuenta,false,ls_final_reporte,true, ls_array_inicio,al_cve_carrera ) <> -1 then
	lds_certificado.SetTransObject(gtr_sce)
	ll_rows = lds_certificado.Retrieve(al_cuenta, li_cve_tipo_documento, 1, 1)
	if ll_rows >0 then 
		li_res_print= lds_certificado.Print()	
		if li_res_print = 1 then
			lds_certificado_n.SetTransObject(gtr_sce)
			ll_rows = lds_certificado_n.Retrieve(al_cuenta, li_cve_tipo_documento, 1, 9999)
			if ll_rows >0 then 
				li_res_print= lds_certificado_n.Print()	
				if li_res_print = 1 then			
					MessageBox("Impresion Exitosa","Favor de recoger el certificado en la impresora",Information!)
				end if				
			else
				MessageBox("No hay más registros","Solo existe una hoja.~nNo es posible imprimir",StopSign!)		
			end if		
		end if
	else
			MessageBox("No hay registros","No es posible imprimir",StopSign!)		
	end if
end if

if isvalid(luo_reporte_dw) then
	DESTROY luo_reporte_dw 
end if

if isvalid(lds_certificado) then
	DESTROY lds_certificado
end if

if isvalid(lds_certificado_n) then
	DESTROY lds_certificado_n
end if
return 0

end function

public function integer wf_imprime_certificado (long al_cuenta, long al_cve_carrera, long al_cve_plan, boolean ab_legalizado, string as_nivel);//wf_imprime_certificado
//Recibe: al_cuenta				long
//				al_cve_carrera		long
//				al_cve_plan			long
//				ab_legalizado		boolean
//				as_nivel				string

uo_reporte_dw luo_reporte_dw
uds_datastore lds_certificado, lds_certificado_n
long ll_rows, ll_creditos_cursados, ll_ultima_posicion
integer li_res_print, li_cve_tipo_documento
string ls_final_reporte[], ls_carrera, ls_anio_plan, ls_nivel, ls_cadena_buscada = space(1)
string ls_carrera_sin_prefijo, ls_grado_carrera, ls_grado_con_articulo
string ls_array_inicio[], LineaR1, LineaR2, ls_final_carrera01, ls_final_carrera02
boolean lb_imprime_lineas_vacias
string ls_numero_resolucion, ls_fecha_resolucion
long ll_obten_resol_adm_rg, ll_res_acuerdo_rg, ll_es_carrera_tsu
integer	li_res_periodo_egreso, li_periodo_egreso, li_anio_egreso, li_egresado_anterior
integer li_carrera_en_academicos, li_egresa_completos = 1, li_egresa_alumno
integer li_pos_dipes
string ls_numero_acuerdo_sin_dipes, ls_logo_certificado
int  li_logo_certificado_X, li_logo_certificado_Y, li_logo_certificado_Width, li_logo_certificado_Height, li_obten_logo_plantel_vigente
int li_lineas_vacias = 5
int li_i
int li_revisa_corte_cert
int li_obten_clave, li_cve_idioma, li_plan_idioma_valido
string ls_tipo_periodo
int li_SetTransObject, li_retrieve_historico_sin_traduccion, li_print_historico_sin_traduccion
string ls_fecha_generacion
date ldt_fecha_generacion
integer li_cve_plantel_vigente, li_set_filter, li_filter
string ls_condicion_sin_titulos_estatales


li_cve_plantel_vigente = f_obten_cve_plantel_vigente ()
if li_cve_plantel_vigente = -1 then
	MessageBox("Error al consultar plan vigente", "No es posible consultar el plantel vigente", StopSign!)
	return -1
end if

ls_fecha_generacion = em_fecha_generacion.text
if isdate(ls_fecha_generacion) then
	ldt_fecha_generacion = Date( ls_fecha_generacion )
else
	MessageBox("Fecha de Generación Incorrecta", "Es necesario escribir una fecha de generación válida", StopSign!)
	return -1
end if
//2017-junio-22
//Obtiene el idioma seleccionado
li_obten_clave = uo_i_idioma.of_obten_clave()
if li_obten_clave<>0 then
	li_cve_idioma = li_obten_clave
end if

if li_cve_idioma<>1 then
	li_plan_idioma_valido = f_obten_plan_idioma_valido(al_cve_plan, li_cve_idioma ,as_nivel  )
	
	if li_plan_idioma_valido = 100 then
		MessageBox("Combinación de Plan-Idioma no válida,","No es posible generar el certificado en ese idioma con el plan de estudios correspondiente",StopSign!)
		return -1
	end if
	li_SetTransObject = dw_historico_sin_traduccion.SetTransObject(gtr_sce)
	if li_SetTransObject = -1 then 
		MessageBox("Error en consulta de traducciones","No es posible consultar las materias traducidas",StopSign!)		
	end if	
	li_retrieve_historico_sin_traduccion = dw_historico_sin_traduccion.Retrieve(al_cuenta, al_cve_carrera, al_cve_plan, li_cve_idioma)
	if li_retrieve_historico_sin_traduccion= -1 then 
		MessageBox("Error en consulta de traducciones","No es posible consultar las materias traducidas",StopSign!)		
		return -1
	elseif li_retrieve_historico_sin_traduccion>0 then 
		MessageBox("Materias sin  traducción","Existen materias sin traducción",StopSign!)			
		li_print_historico_sin_traduccion = dw_historico_sin_traduccion.Print()	
		if li_print_historico_sin_traduccion = -1 then
			MessageBox("Materias sin  traducción","No fue posible imprimir las materias sin traducción",StopSign!)						
		else
			MessageBox("Materias sin  traducción","Se mandó a imprimir la lista de materias sin traducción",StopSign!)						
		end if
		return -1
	end if
end if

integer li_obten_es_plan_estatal
long ll_incorporado_sep, ll_plan_estatal
string ls_otorgado_por , ls_no_rvoe
string ls_num_control_estatal


li_obten_es_plan_estatal= f_obten_es_plan_estatal( al_cve_carrera, al_cve_plan, ll_incorporado_sep, ll_plan_estatal, ls_otorgado_por, ls_no_rvoe )
if li_obten_es_plan_estatal = 100 then
	MessageBox("Plan de estudios no válido,","No es posible generar el certificado con el plan de estudios correspondiente",StopSign!)
	return -1
elseif li_obten_es_plan_estatal = -1 then 
	MessageBox("Error en consulta de Plan de estudios no válido","No es posible consultar el plan de estudios",StopSign!)		
	return -1
end if

long ll_row_otorgado, ll_row_oficio
string  ls_otorgado_por_elegido, ls_oficio_elegido

if ll_plan_estatal = 1 then 
	ls_num_control_estatal = em_num_control_estatal.text
	if len(ls_num_control_estatal) = 0  OR isnull(ls_num_control_estatal)  then
		MessageBox("Número de control obligatorio","El número de control estatal no puede ser nulo", StopSign!)
		return -1
	end if
	
	 ll_row_otorgado = dw_otorgado_por.GetRow()
	 ls_otorgado_por_elegido = dw_otorgado_por.GetItemString(ll_row_otorgado, "otorgado_por")
	 
	 ll_row_oficio = dw_oficio.GetRow()
	 ls_oficio_elegido = dw_oficio.GetItemString(ll_row_oficio, "no_rvoe_oficio")
 
end if


luo_reporte_dw = CREATE uo_reporte_dw
lds_certificado = CREATE uds_datastore
lds_certificado_n = CREATE uds_datastore

ll_es_carrera_tsu =f_es_carrera_tsu(al_cve_carrera)

//LOS CERTIFICADOS DE TSU SALEN EN LA MISMA PAPELERÍA DE POSGRADO
//if as_nivel = "L"  and not (ll_es_carrera_tsu= 1)  then
if as_nivel <> "P"  and not (ll_es_carrera_tsu= 1)  then	
	if ab_legalizado then
		choose case li_cve_idioma
			case 1
				if ll_plan_estatal = 1 then
					lds_certificado.dataobject = "d_certificados_estat_rediseño_1"
					lds_certificado_n.dataobject = "d_certificados_estat_rediseño_n_1"						
				else					
					lds_certificado.dataobject = "d_certificados_lic_legal_rn"
					lds_certificado_n.dataobject = "d_certificados_lic_legal_rn_n"	
				end if
				/*statementblock*/
			case 2
				lds_certificado.dataobject = "d_certificados_lic_legal_rediseño_rn_ingles_ln"
				lds_certificado_n.dataobject = "d_certificados_lic_legal_rediseño_rn_ln_ingles_n"	
				/*statementblock*/
		end choose	
	else
		choose case li_cve_idioma
			case 1
				if ll_plan_estatal = 1 then
					lds_certificado.dataobject = "d_certificados_estat_rediseño_1"
					lds_certificado_n.dataobject = "d_certificados_estat_rediseño_n_1"						
				else		
					lds_certificado.dataobject    = "d_certificados_lic_simples_rn"
					lds_certificado_n.dataobject = "d_certificados_lic_simples_rn_n"	
				end if
				/*statementblock*/
			case 2
				lds_certificado.dataobject     = "d_certificados_lic_simples_red_ing"
				lds_certificado_n.dataobject = "d_certificados_lic_simples_red_ing_n"	
				/*statementblock*/
		end choose	

	end if
elseif as_nivel = "P" or  ll_es_carrera_tsu= 1 then
	if ab_legalizado then
		choose case li_cve_idioma
			case 1
				if ll_plan_estatal = 1 then
					lds_certificado.dataobject = "d_certificados_estat_rediseño_1"
					lds_certificado_n.dataobject = "d_certificados_estat_rediseño_n_1"						
				else							
					lds_certificado.dataobject    = "d_certificados_lic_legal_rn"
					lds_certificado_n.dataobject = "d_certificados_lic_legal_rn_n"	
				end if
				/*statementblock*/
			case 2
				lds_certificado.dataobject = "d_certificados_lic_legal_rediseño_rn_ingles_ln"
				lds_certificado_n.dataobject = "d_certificados_lic_legal_rediseño_rn_ln_ingles_n"	
				/*statementblock*/
		end choose	
	else
		choose case li_cve_idioma
			case 1
				if ll_plan_estatal = 1 then
					lds_certificado.dataobject = "d_certificados_estat_rediseño_1"
					lds_certificado_n.dataobject = "d_certificados_estat_rediseño_n_1"						
				else				
					lds_certificado.dataobject    = "d_certificados_lic_simples_rn"
					lds_certificado_n.dataobject = "d_certificados_lic_simples_rn_n"	
				end if
				/*statementblock*/
			case 2
				lds_certificado.dataobject     = "d_certificados_lic_simples_red_ing"
				lds_certificado_n.dataobject = "d_certificados_lic_simples_red_ing_n"	
				/*statementblock*/
		end choose	


	end if
end if

if ll_plan_estatal <> 1 then 

	if w_revision_estudios_rediseño.gb_revalidacion.visible = true then
		LineaR1 = "MATERIAS EQUIVALENTES SEGÚN "
		if w_revision_estudios_rediseño.rb_oficio.checked = true then
			LineaR1 += "OFICIO No. "
		elseif w_revision_estudios_rediseño.rb_folio.checked = true then
			LineaR1 += "FOLIO No. "
		else
			LineaR1 += "EXPEDIENTE No. "
		end if
		LineaR1 += w_revision_estudios_rediseño.em_numero.text
		LineaR2 = "DE FECHA "+  mid(w_revision_estudios_rediseño.em_fecha.text,1,2)+" DE "+&
						 DameMes(integer(mid(w_revision_estudios_rediseño.em_fecha.text,4,2)))+" DE " +mid(w_revision_estudios_rediseño.em_fecha.text,7,4) 
		ls_array_inicio[1]= LineaR1
		ls_array_inicio[2]= LineaR2	
	end if
	
end if
//if ll_plan_estatal <> 1 then 

ls_carrera_sin_prefijo = f_obten_carrera_sin_prefijo_idioma(al_cve_carrera,  li_cve_idioma)
ls_carrera = f_obten_carrera(al_cve_carrera)
ls_carrera = f_obten_carrera_idioma(  al_cve_carrera,  li_cve_idioma )

ls_grado_carrera = f_obten_grado_carrera(al_cve_carrera)
ls_grado_con_articulo = f_obten_grado_con_articulo_idioma(ls_grado_carrera,  li_cve_idioma)


SetPointer(HourGlass!)
w_revision_estudios_rediseño.dw_prueba.SetSort("tipo A,periodonum A,sigla A")
w_revision_estudios_rediseño.dw_prueba.Sort()

//ls_carrera = mid(w_revision_estudios_rediseño.st_carrera.text,17)
ll_creditos_cursados= w_revision_estudios_rediseño.dw_revision_est_fmc.getitemnumber(1,"cursadost")
if al_cve_plan<>6 then
//	CORREGIDO 2013-04-05
	ls_anio_plan= mid(w_revision_estudios_rediseño.st_nivel.text,1,9)
	//SI NO ES UN INTERVALO solo obtener el primer año
	if 	POS(ls_anio_plan, '-') =0 and POS(ls_anio_plan, '/') =0 then
		ls_anio_plan= mid(ls_anio_plan,1,4)
	end if
else 
	ls_anio_plan = "2004"
end if

ls_nivel= mid(w_revision_estudios_rediseño.st_nivel.text,11)

//if as_nivel = "L" OR ls_nivel = "T" then
if as_nivel <> "P" then	
		//Si la carrera ES TSU
	if ll_es_carrera_tsu= 1 then
		//Certificado TOTAL
		if w_revision_estudios_rediseño.dw_revision_est_fmc.getitemstring(1,"completo") = "si" then
			choose case li_cve_idioma
				case 1
					ls_final_reporte[1]="NOTA: Cubre íntegramente las materias y el mínimo de créditos para optar por el TÍTULO"
					ls_final_reporte[2]="DE " + ls_carrera
					ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
				case 2
					ls_final_reporte[1]="NOTE: IT Completely covers the subjects and minimum credits required to apply for the DEGREE"
					ls_final_reporte[2]="IN " + ls_carrera
					ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
			end choose	
		else
		//Certificado PARCIAL
			ls_final_reporte[1]="NOTA: El presente certificado parcial ampara "+string(ll_creditos_cursados)+" créditos correspondientes al Plan de"
			ls_final_reporte[2]="Estudios "+ls_anio_plan+" de "+ls_carrera
			ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
		end if
	//Si la carrera NO ES Ciencias Teológicas			
	elseif al_cve_carrera <>4601 then
		//Certificado TOTAL
		if w_revision_estudios_rediseño.dw_revision_est_fmc.getitemstring(1,"completo") = "si" then
			//PARA CDMX (QUE NO TIENEN POSTÉCNICOS)
			if li_cve_plantel_vigente = 17 then
				choose case li_cve_idioma
					case 1
						ls_final_reporte[1]="NOTA: Cubre íntegramente las materias y el mínimo de créditos para optar por el TÍTULO"
						ls_final_reporte[2]="DE LICENCIADO EN " + ls_carrera
						ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
					case 2
						ls_final_reporte[1]="NOTE: IT Completely covers the subjects and minimum credits required to apply for the DEGREE"
						ls_final_reporte[2]="IN " + ls_carrera
						ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
				end choose	
			//PARA LOS DEMÁS PLANTELES (QUE TIENEN POSTÉCNICOS)
			else
				//SOLO PARA LOS POSTÉCNICOS
				if ls_grado_carrera = 'P' then
					choose case li_cve_idioma
						case 1
							ls_final_reporte[1]="NOTA: Cubre íntegramente las materias y el mínimo de créditos del CURSO POSTÉCNICO "
							ls_final_reporte[2]="EN " + ls_carrera_sin_prefijo
							ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
						case 2
							ls_final_reporte[1]="NOTE: IT Completely covers the subjects and minimum credits required to apply for the DEGREE"
							ls_final_reporte[2]="IN " + ls_carrera_sin_prefijo
							ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
					end choose	
				//CUALQUIER OTRO GRADO DISTINTO A LOS POSTÉCNICOS
				else
					if ll_plan_estatal = 1 then
						choose case li_cve_idioma
							case 1
								ls_final_reporte[1]="NOTA: Cubre íntegramente las materias y el mínimo de créditos para optar por el TÍTULO"
								ls_final_reporte[2]="EN " + ls_carrera
								ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
							case 2
								ls_final_reporte[1]="NOTE: IT Completely covers the subjects and minimum credits required to apply for the DEGREE"
								ls_final_reporte[2]="IN " + ls_carrera
								ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
						end choose											
					else
						choose case li_cve_idioma
							case 1
								ls_final_reporte[1]="NOTA: Cubre íntegramente las materias y el mínimo de créditos para optar por el TÍTULO"
								ls_final_reporte[2]="DE LICENCIADO EN " + ls_carrera
								ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
							case 2
								ls_final_reporte[1]="NOTE: IT Completely covers the subjects and minimum credits required to apply for the DEGREE"
								ls_final_reporte[2]="IN " + ls_carrera
								ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
						end choose						
					end if	
				end if
			end if
			
	else
		//Certificado PARCIAL
			//PARA CDMX (QUE NO TIENEN POSTÉCNICOS)
			if li_cve_plantel_vigente = 17 then
				//Certificado PARCIAL
					ls_final_reporte[1]="NOTA: El presente certificado parcial ampara "+string(ll_creditos_cursados)+" créditos correspondientes al Plan de"
					ls_final_reporte[2]="Estudios "+ls_anio_plan+" de "+ls_grado_con_articulo+" en "+ls_carrera 
					ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
			else
				//PARA LOS DEMÁS PLANTELES (QUE TIENEN POSTÉCNICOS)
				//SOLO PARA LOS POSTÉCNICOS
				if ls_grado_carrera = 'P' then
					ls_final_reporte[1]="NOTA: El presente certificado parcial ampara "+string(ll_creditos_cursados)+" créditos correspondientes al Plan de"
					ls_final_reporte[2]="Estudios "+ls_anio_plan+" del CURSO POSTÉCNICO EN "+ls_carrera_sin_prefijo 
					ls_final_reporte[3]="---------------------------------------------------------------------------------------------"										
				//CUALQUIER OTRO GRADO DISTINTO A LOS POSTÉCNICOS
				else					
					if ll_plan_estatal = 1 then
						ls_final_reporte[1]="NOTA: El presente certificado parcial ampara "+string(ll_creditos_cursados)+" créditos correspondientes al Plan de"
						ls_final_reporte[2]="Estudios "+ls_anio_plan+" de "+ls_carrera 
						ls_final_reporte[3]="---------------------------------------------------------------------------------------------"				
					
					else
						ls_final_reporte[1]="NOTA: El presente certificado parcial ampara "+string(ll_creditos_cursados)+" créditos correspondientes al Plan de"
						ls_final_reporte[2]="Estudios "+ls_anio_plan+" del "+ls_grado_con_articulo+" en "+ls_carrera 
						ls_final_reporte[3]="---------------------------------------------------------------------------------------------"					
					end if
				end if
			end if				
		end if
	else
	//Si la carrera ES Ciencias Teológicas
		//->[
		//Certificado TOTAL
		ls_final_carrera01 = ""
		if w_revision_estudios_rediseño.dw_revision_est_fmc.getitemstring(1,"completo") = "si" then
			choose case li_cve_idioma
				case 1
					ls_final_reporte[1]="NOTA: Cubre íntegramente las materias y el mínimo de créditos para optar por el TÍTULO"
					ls_final_reporte[2]="DE LICENCIADO EN " + ls_carrera
				case 2
					ls_final_reporte[1]="NOTE: IT Completely covers the subjects and minimum credits required to apply for the DEGREE"
					ls_final_reporte[2]="IN " + ls_carrera
			end choose	

			if len (ls_final_reporte[2]) < 107 then
 			   ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
			else
 				ll_ultima_posicion = f_obten_ultima_aparicion(ls_final_reporte[2], ls_cadena_buscada, 107)
				ls_final_carrera01 = mid( ls_final_reporte[2], 1, ll_ultima_posicion)
				ls_final_carrera02 = mid( ls_final_reporte[2], ll_ultima_posicion + 1)
	 			ls_final_reporte[2]=	ls_final_carrera01		
 				ls_final_reporte[3]=	ls_final_carrera02		
 				ls_final_reporte[4]="---------------------------------------------------------------------------------------------"
			end if
		else
		//Certificado PARCIAL
			ls_final_reporte[1]="NOTA: El presente certificado parcial ampara "+string(ll_creditos_cursados)+" créditos correspondientes al Plan de"
			if ls_grado_carrera = 'D' then
				ls_final_reporte[2]="Estudios "+ls_anio_plan+" d"+ls_grado_con_articulo+" en "+ls_carrera 
			else
				ls_final_reporte[2]="Estudios "+ls_anio_plan+" de "+ls_grado_con_articulo+" en "+ls_carrera 
			end if
			if len (ls_final_reporte[2]) < 107 then
 			   ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
			else
 				ll_ultima_posicion = f_obten_ultima_aparicion(ls_final_reporte[2], ls_cadena_buscada, 107)
				ls_final_carrera01 = mid( ls_final_reporte[2], 1, ll_ultima_posicion)
				ls_final_carrera02 = mid( ls_final_reporte[2], ll_ultima_posicion + 1)
 				ls_final_reporte[2]=	ls_final_carrera01		
 				ls_final_reporte[3]=	ls_final_carrera02		
	 			ls_final_reporte[4]="---------------------------------------------------------------------------------------------"
			end if				
		end if
		li_lineas_vacias = 5
		lb_imprime_lineas_vacias = false
		if w_revision_estudios_rediseño.st_regularizacion.visible = true then
			lb_imprime_lineas_vacias = true
			if ls_final_carrera01 = "" then li_lineas_vacias =4
			for li_i = 0 to 4 
				ls_final_reporte[li_lineas_vacias + li_i] = "~t"
			next
		
			ll_res_acuerdo_rg = f_obten_acuerdo_rg(is_numero_acuerdo, ls_fecha_resolucion)
		
			li_pos_dipes = pos(is_numero_acuerdo,"DIPES")
			if li_pos_dipes>1 then
				ls_numero_acuerdo_sin_dipes = ": "+mid(is_numero_acuerdo, li_pos_dipes+5)
			else
				ls_numero_acuerdo_sin_dipes = is_numero_acuerdo
			end if
//		ll_obten_resol_adm_rg = f_obten_resol_adm_rg(al_cve_carrera,al_cve_plan,ls_numero_resolucion, ls_fecha_resolucion)

			if ll_res_acuerdo_rg<> -1 then
				ls_final_reporte[li_lineas_vacias + 2] = "        *    EL  PRESENTE  CERTIFICADO  SE EXPIDE  EN  CUMPLIMIENTO A LA RESOLUCIÓN"
				ls_final_reporte[li_lineas_vacias + 3] = "             ADMINISTRATIVA  NÚMERO"+ls_numero_acuerdo_sin_dipes+" DE FECHA "+ls_fecha_resolucion+"."
				ls_final_reporte[li_lineas_vacias + 4] = "~t"
				ls_final_reporte[li_lineas_vacias + 5] = "        R.G. REGULARIZACIÓN  GLOBAL  DERIVADA  DE  LA  SOLICITUD PRESENTADA ANTE LA"
				ls_final_reporte[li_lineas_vacias + 6] = "             UNIDAD ADMINISTRATIVA, MISMA QUE FUE RESUELTA CON OFICIO"+is_numero_acuerdo+""
				ls_final_reporte[li_lineas_vacias + 7] = "             DE FECHA "+ls_fecha_resolucion+"."		
			else
				MessageBox("Error en generación","No es obtener el numero y fecha de la resolucion administrativa de RG",StopSign!)	
				return -1
			end if
		end if		
		//]<-
	end if
elseif as_nivel = "P" or as_nivel = "T" then
	//Certificado TOTAL
	ls_final_carrera01 = ""
	if w_revision_estudios_rediseño.dw_revision_est_fmc.getitemstring(1,"completo") = "si" then
//		ls_final_reporte[1]="NOTA: Cubre íntegramente las materias y el mínimo de créditos para optar por"		
		choose case li_cve_idioma
			case 1
				ls_final_reporte[1]="NOTA: Cubre íntegramente las materias y el mínimo de créditos para optar por"
			case 2
				ls_final_reporte[1]="NOTE: IT Completely covers the subjects and minimum credits required to apply for"
		end choose	
		
		if al_cve_carrera<> 7006 then
			choose case li_cve_idioma
				case 1
					ls_final_reporte[2]=upper(ls_grado_con_articulo)+" EN " + ls_carrera_sin_prefijo
				case 2
					ls_final_reporte[2]=upper(ls_grado_con_articulo)+" IN " + ls_carrera_sin_prefijo
			end choose	
		else			
			choose case li_cve_idioma
				case 1			
					ls_final_reporte[2]=upper(ls_grado_con_articulo)+" " + ls_carrera_sin_prefijo
				case 2
					ls_final_reporte[2]=upper(ls_grado_con_articulo)+" " + ls_carrera_sin_prefijo
			end choose	
		end if
		if len (ls_final_reporte[2]) < 107 then
 		   ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
		else
 			ll_ultima_posicion = f_obten_ultima_aparicion(ls_final_reporte[2], ls_cadena_buscada, 107)
			ls_final_carrera01 = mid( ls_final_reporte[2], 1, ll_ultima_posicion)
			ls_final_carrera02 = mid( ls_final_reporte[2], ll_ultima_posicion + 1)
 			ls_final_reporte[2]=	ls_final_carrera01		
 			ls_final_reporte[3]=	ls_final_carrera02		
 			ls_final_reporte[4]="---------------------------------------------------------------------------------------------"
		end if
	else
	//Certificado PARCIAL
		ls_final_reporte[1]="NOTA: El presente certificado parcial ampara "+string(ll_creditos_cursados)+" créditos correspondientes al Plan de"
		if al_cve_carrera<> 7006 then		
			if ls_grado_carrera = 'D' then
				ls_final_reporte[2]="Estudios "+ls_anio_plan+" d"+ls_grado_con_articulo+" EN "+ls_carrera_sin_prefijo 
			else
				ls_final_reporte[2]="Estudios "+ls_anio_plan+" de "+ls_grado_con_articulo+" EN "+ls_carrera_sin_prefijo 				
			end if
		else 
			ls_final_reporte[2]="Estudios "+ls_anio_plan+" d"+ls_grado_con_articulo+" "+ls_carrera_sin_prefijo
		end if
		if len (ls_final_reporte[2]) < 107 then
 		   ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
		else
 			ll_ultima_posicion = f_obten_ultima_aparicion(ls_final_reporte[2], ls_cadena_buscada, 107)
			ls_final_carrera01 = mid( ls_final_reporte[2], 1, ll_ultima_posicion)
			ls_final_carrera02 = mid( ls_final_reporte[2], ll_ultima_posicion + 1)
 			ls_final_reporte[2]=	ls_final_carrera01		
 			ls_final_reporte[3]=	ls_final_carrera02		
 			ls_final_reporte[4]="---------------------------------------------------------------------------------------------"
		end if		
		
	end if
	li_lineas_vacias = 5
	lb_imprime_lineas_vacias = false
	if w_revision_estudios_rediseño.st_regularizacion.visible = true then
		lb_imprime_lineas_vacias = true
		if ls_final_carrera01 = "" then li_lineas_vacias = 4
		for li_i = 0 to 4 
			ls_final_reporte[li_lineas_vacias + li_i] = "~t"
		next
		
		ll_res_acuerdo_rg = f_obten_acuerdo_rg(is_numero_acuerdo, ls_fecha_resolucion)
		
		li_pos_dipes = pos(is_numero_acuerdo,"DIPES")
		if li_pos_dipes>1 then
			ls_numero_acuerdo_sin_dipes = ": "+mid(is_numero_acuerdo, li_pos_dipes+5)
		else
			ls_numero_acuerdo_sin_dipes = is_numero_acuerdo
		end if
//		ll_obten_resol_adm_rg = f_obten_resol_adm_rg(al_cve_carrera,al_cve_plan,ls_numero_resolucion, ls_fecha_resolucion)

		if ll_res_acuerdo_rg<> -1 then
			ls_final_reporte[li_lineas_vacias + 2] = "          *  EL  PRESENTE  CERTIFICADO  SE EXPIDE  EN  CUMPLIMIENTO A LA RESOLUCIÓN"
			ls_final_reporte[li_lineas_vacias + 3] = "             ADMINISTRATIVA  NÚMERO"+ls_numero_acuerdo_sin_dipes+" DE FECHA "+ls_fecha_resolucion+"."
			ls_final_reporte[li_lineas_vacias + 4] = "~t"
			ls_final_reporte[li_lineas_vacias + 5] = "        R.G. REGULARIZACIÓN  GLOBAL  DERIVADA  DE  LA  SOLICITUD PRESENTADA ANTE LA"
			ls_final_reporte[li_lineas_vacias + 6] = "             UNIDAD ADMINISTRATIVA, MISMA QUE FUE RESUELTA CON OFICIO"+is_numero_acuerdo+""
			ls_final_reporte[li_lineas_vacias + 7] = "             DE FECHA "+ls_fecha_resolucion+"."		
		else
			MessageBox("Error en generación","No es obtener el numero y fecha de la resolucion administrativa de RG",StopSign!)	
			return -1
		end if

//		if f_es_carrera_resol_adm_rg(al_cve_carrera, al_cve_plan)>0 then
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
end if

//LOS CERTIFICADOS DE TSU SALEN EN LA MISMA PAPELERÍA DE POSGRADO
//Si es alumno de licenciatura
//if as_nivel = "L" and not (ll_es_carrera_tsu= 1)  then 
if as_nivel <> "P" and not (ll_es_carrera_tsu= 1)  then 	
	//Si es plan 2004
	if al_cve_plan>= 6 then
		//Si es certificado legalizado
		if ab_legalizado then
			if ll_plan_estatal = 1 then
			//Si es plan estatal, como si fuera certificado simple
				li_cve_tipo_documento=2
			else				
				li_cve_tipo_documento=6
			end if
		else
		//Si es certificado simple
			li_cve_tipo_documento=2			
		end if
	else
		//Si es certificado legalizado
		if ab_legalizado then
			if ll_plan_estatal = 1 then
			//Si es plan estatal, como si fuera certificado simple
				li_cve_tipo_documento=1		
			else
				li_cve_tipo_documento=5
			end if
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
		//if ab_legalizado and ll_plan_estatal = 0 then
		if ab_legalizado then
			li_cve_tipo_documento=8
		else
		//Si es certificado simple
			li_cve_tipo_documento=4			
		end if
	else
		//Si es certificado legalizado
		//if ab_legalizado and ll_plan_estatal = 0 then
		if ab_legalizado then 
			li_cve_tipo_documento=7
		else
		//Si es certificado simple
			li_cve_tipo_documento=3			
		end if
	end if	
end if

//Comentado 2010-02-05
//if luo_reporte_dw.f_genera_cuerpo(li_cve_tipo_documento,w_revision_estudios_rediseño.dw_prueba, al_cuenta,lb_imprime_lineas_vacias,ls_final_reporte,true, ls_array_inicio, al_cve_carrera ) <> -1 then

//Cambiado por el 2010-02_08

//Cambiado por modificaciones el 2013-01- 18
//Nuevas modificaciones el 2013-06- 18

w_revision_estudios_rediseño.triggerevent("doubleclicked")

//li_revisa_corte_cert = luo_reporte_dw.f_revisa_corte_cert_m(li_cve_tipo_documento,1,w_revision_estudios_rediseño.dw_prueba,al_cuenta, true, al_cve_carrera,ls_final_reporte, ls_array_inicio)
li_revisa_corte_cert = luo_reporte_dw.f_genera_certificado_bd(li_cve_tipo_documento,1,w_revision_estudios_rediseño.dw_prueba,al_cuenta, true, al_cve_carrera,ls_final_reporte, ls_array_inicio, li_cve_idioma)

//2018-05-14 
string ls_anio_inicial, ls_anio_final, ls_obs, ls_intervalo_anios
integer li_anio_inicial, li_anio_final
boolean lb_actualizar_periodo 

long ll_rows_cert1, ll_row_actual
if w_revision_estudios_rediseño.gb_revalidacion.visible = true then
	if w_revision_estudios_rediseño.cbx_intervalo.Checked then
		ls_anio_inicial = w_revision_estudios_rediseño.em_inicial.text 
		ls_anio_final = w_revision_estudios_rediseño.em_final.text 
		if not isnumber(ls_anio_inicial) then
			MessageBox("Año inicial incorrecto", "Escriba un año inicial válido", StopSign!)	
			return -1
			lb_actualizar_periodo = false
		end if
		if not isnumber(ls_anio_final) then
			MessageBox("Año final incorrecto", "Escriba un año final válido", StopSign!)					
			return -1
			lb_actualizar_periodo = false
		end if
		ls_intervalo_anios = ls_anio_inicial+ '-'+ls_anio_final
		lb_actualizar_periodo = true
	end if
end if

//Cambiado por 2010-02-05
if li_revisa_corte_cert<>-1 then
	lds_certificado.SetTransObject(gtr_sce)
	
	if ll_plan_estatal = 1 then  
		ll_rows = lds_certificado.Retrieve(al_cuenta, li_cve_tipo_documento, 1, 1, al_cve_carrera, ls_otorgado_por_elegido, ls_oficio_elegido, ls_fecha_generacion, ls_num_control_estatal   )	
		ls_condicion_sin_titulos_estatales= " materias_certificado_cve_mat <> 0 "
		li_set_filter = lds_certificado.SetFilter(ls_condicion_sin_titulos_estatales)
		li_filter = lds_certificado.Filter()
	else	
		ll_rows = lds_certificado.Retrieve(al_cuenta, li_cve_tipo_documento, 1, 1, al_cve_carrera, ls_fecha_generacion)
	end if
	if ll_rows >0 then 
		if lb_actualizar_periodo then
			ll_rows_cert1 = lds_certificado.RowCount()
			for ll_row_actual=1 to ll_rows_cert1
				ls_obs = lds_certificado.GetItemString(ll_row_actual, "materias_certificado_obs")
				if ls_obs = 'EQ' then
					 lds_certificado.SetItem(ll_row_actual, 'materias_certificado_periodo_str', ls_intervalo_anios)
				end if
			next
		end if
//		long ll_row_actual, ll_tipo
//		for ll_row_actual=1 to ll_rows
//			ll_tipo = lds_certificado.GetItemNumber(ll_row_actual, "materias_certificado_tipo")
//			if ll_tipo = 4 then
//				lds_certificado.object.FaceName = "Courier New"
//				
//			end if		
//		next

		//if as_nivel = "L"  and not (ll_es_carrera_tsu= 1)  then
		if as_nivel <> "P"  and not (ll_es_carrera_tsu= 1)  then
			li_obten_logo_plantel_vigente = f_obten_coordenadas_logo( li_logo_certificado_X, li_logo_certificado_Y, li_logo_certificado_Width, li_logo_certificado_Height)
			if li_obten_logo_plantel_vigente = -1 then
				MessageBox("Coordenadas Inválidas", "No existen coordenadas para el logo", StopSign!)				
			end if
			ls_logo_certificado = f_obten_logo_plantel_vigente()
			lds_certificado.object.p_logo.filename = ls_logo_certificado
			lds_certificado.object.p_logo.x = li_logo_certificado_X
			lds_certificado.object.p_logo.y = li_logo_certificado_Y
			lds_certificado.object.p_logo.Width = li_logo_certificado_Width
			lds_certificado.object.p_logo.Height = li_logo_certificado_Height
			
//			lds_certificado.object.ln_vertical_izquierda.EndX = 300
//			lds_certificado.object.ln_vertical_izquierda.EndY = 300
//			lds_certificado.object.ln_vertical_derecha.EndX = 300
//			lds_certificado.object.ln_vertical_derecha.EndY = 300
////			
//			lds_certificado.object.ln_vertical_izquierda.x2 = lds_certificado.object.ln_inferior.x1
//			lds_certificado.object.ln_vertical_izquierda.y2 = lds_certificado.object.ln_inferior.y1
//			lds_certificado.object.ln_vertical_derecha.x2 = lds_certificado.object.ln_inferior.x2
//			lds_certificado.object.ln_vertical_derecha.y2 = lds_certificado.object.ln_inferior.y2

		end if

		li_res_print= lds_certificado.Print()	
		if li_res_print = 1 then
			lds_certificado_n.SetTransObject(gtr_sce)
			if ll_plan_estatal = 1 then  
				ll_rows = lds_certificado_n.Retrieve(al_cuenta, li_cve_tipo_documento, 1, 9999, al_cve_carrera,ls_otorgado_por_elegido, ls_oficio_elegido, ls_fecha_generacion, ls_num_control_estatal   )	
				ls_condicion_sin_titulos_estatales= " materias_certificado_es_separador <> 1 "
				li_set_filter = lds_certificado_n.SetFilter(ls_condicion_sin_titulos_estatales)
				li_filter = lds_certificado_n.Filter()
			else	
				ll_rows = lds_certificado_n.Retrieve(al_cuenta, li_cve_tipo_documento, 1, 9999, al_cve_carrera, ls_fecha_generacion)
			end if			
			if lb_actualizar_periodo then
				ll_rows_cert1 = lds_certificado_n.RowCount()
				for ll_row_actual=1 to ll_rows_cert1
					ls_obs = lds_certificado_n.GetItemString(ll_row_actual, "materias_certificado_obs")
					if ls_obs = 'EQ' then
						 lds_certificado_n.SetItem(ll_row_actual, 'materias_certificado_periodo_str', ls_intervalo_anios)
					end if
				next
			end if
			
			li_obten_logo_plantel_vigente = f_obten_coordenadas_logo( li_logo_certificado_X, li_logo_certificado_Y, li_logo_certificado_Width, li_logo_certificado_Height)
			if li_obten_logo_plantel_vigente = -1 then
				MessageBox("Coordenadas Inválidas", "No existen coordenadas para el logo", StopSign!)				
			end if
			ls_logo_certificado = f_obten_logo_plantel_vigente()
			
			lds_certificado_n.object.p_logo.filename = ls_logo_certificado
			lds_certificado_n.object.p_logo.x = li_logo_certificado_X
			lds_certificado_n.object.p_logo.y = li_logo_certificado_Y
			lds_certificado_n.object.p_logo.Width = li_logo_certificado_Width
			lds_certificado_n.object.p_logo.Height = li_logo_certificado_Height
			
			if ll_rows >0 then 
				li_res_print= lds_certificado_n.Print()	
				if li_res_print = 1 then			
					MessageBox("Impresion Exitosa","Favor de recoger el certificado en la impresora",Information!)
				end if				
			else
				MessageBox("No hay más registros","Solo existe una hoja.~nHa concluido la impresión",StopSign!)		
			end if		
		end if
	else
			MessageBox("No hay registros","No es posible imprimir",StopSign!)		
	end if
end if




//Descomentar 2010-02-05
////Recibe:
////ai_cve_tipo_doc_reporte		integer
////al_renglon_datos				long
////adw_datawindow					datawindow
////al_cuenta						long
////ab_fin_cuerpo_con_registro	boolean
////al_cve_carrera					long
////as_array_fin_cuerpo			string[]
////Devuelve:
//	
//	lds_certificado.SetTransObject(gtr_sce)
//	ll_rows = lds_certificado.Retrieve(al_cuenta, li_cve_tipo_documento, 1, 1, al_cve_carrera)
//	if ll_rows >0 then 
//		li_res_print= lds_certificado.Print()	
//		if li_res_print = 1 then
//			lds_certificado_n.SetTransObject(gtr_sce)
//			ll_rows = lds_certificado_n.Retrieve(al_cuenta, li_cve_tipo_documento, 1, 9999, al_cve_carrera)
//			if ll_rows >0 then 
//				li_res_print= lds_certificado_n.Print()	
//				if li_res_print = 1 then			
//					MessageBox("Impresion Exitosa","Favor de recoger el certificado en la impresora",Information!)
//				end if				
//			else
//				MessageBox("No hay más registros","Solo existe una hoja.~nHa concluido la impresión",StopSign!)		
//			end if		
//		end if
//	else
//			MessageBox("No hay registros","No es posible imprimir",StopSign!)		
//	end if
//end if

if isvalid(luo_reporte_dw) then
	DESTROY luo_reporte_dw 
end if

if isvalid(lds_certificado) then
	DESTROY lds_certificado
end if

if isvalid(lds_certificado_n) then
	DESTROY lds_certificado_n
end if

ls_tipo_periodo =f_obten_tipo_periodo_cuenta(al_cuenta)

li_res_periodo_egreso = in_cortes.of_obten_periodo_egreso(li_periodo_egreso, li_anio_egreso, ls_tipo_periodo)

if li_res_periodo_egreso=0 then				
			
	li_carrera_en_academicos = f_carrera_en_academicos(al_cuenta, al_cve_carrera)
	//Si la carrera en cuestión está en academicos
	if li_carrera_en_academicos>=0 then			
			
		//Si se desea egresr al alumno en cuestión		
		if li_egresa_completos = 1 then
			li_egresa_alumno = in_cortes.of_corte_egresado(al_cuenta, al_cve_carrera, al_cve_plan, li_periodo_egreso, li_anio_egreso, li_egresado_anterior)
					
			if li_egresa_alumno= -1 then
				MessageBox("Error en corte de egresado","No es posible continuar la validación del egreso del alumno",StopSign!)
				return -1				
			end if
		end if
		
	elseif li_carrera_en_academicos= -1 then
		MessageBox("Error de consulta de carrera en academicos","No es posible continuar la validación del egreso del alumno",StopSign!)
		return -1				
	end if
elseif li_res_periodo_egreso= -1 or  li_res_periodo_egreso = 100 then
	MessageBox("Error de consulta en periodo de egreso","No es posible continuar validar el egreso del alumno",StopSign!)
	return -1				
end if			


return 0

end function

event open;//g_nv_security.fnv_secure_window (this)
datetime ldttm_fecha_servidor
ldttm_fecha_servidor = fecha_servidor (gtr_sce)
em_fecha_generacion.text = string(date(ldttm_fecha_servidor))



dw_datos_certificado.retrieve()
/**/gnv_app.inv_security.of_SetSecurity(this)

DataWindowChild dwch_acuerdos
integer rtncode, ll_row_child
long ll_cuenta, ll_cve_carrera, ll_cve_plan
integer li_obten_es_plan_estatal
long ll_incorporado_sep, ll_plan_estatal, ll_otorgado_por, ll_oficio
string ls_otorgado_por , ls_no_rvoe, ls_carrera, ls_nombre_plan


ll_cuenta = long(w_revision_estudios_rediseño.uo_1.em_cuenta.text)
ll_cve_carrera = w_revision_estudios_rediseño.il_cve_carrera
ll_cve_plan = w_revision_estudios_rediseño.il_cve_plan


li_obten_es_plan_estatal= f_obten_es_plan_estatal( ll_cve_carrera, ll_cve_plan, ll_incorporado_sep, ll_plan_estatal, ls_otorgado_por, ls_no_rvoe )

if li_obten_es_plan_estatal = 100 then
	MessageBox("Plan de estudios no válido,","No es posible determinar si es un plan de estudios estatal",StopSign!)
	return -1
elseif li_obten_es_plan_estatal = -1 then 
	MessageBox("Error en consulta de Plan de estudios no válido","No es posible consultar si el plan de estudios es estatal", StopSign!)		
	return -1
end if

if ll_plan_estatal = 1 then
	this.Width =3095
	this.Height = 2004
	
	dw_otorgado_por.SetTransObject(gtr_sce )
	ll_otorgado_por = dw_otorgado_por.Retrieve(ll_cve_carrera, ll_cve_plan)
	dw_otorgado_por.SetRowFocusIndicator(Hand!)
	
	dw_oficio.SetTransObject(gtr_sce )
	ll_oficio = dw_oficio.Retrieve(ll_cve_carrera, ll_cve_plan)
	dw_oficio.SetRowFocusIndicator(Hand!)
else
	this.Width =2766
	this.Height = 1124
end if

ls_carrera = f_obten_carrera (ll_cve_carrera )

this.st_carrera.text =ls_carrera +"(" + string(ll_cve_carrera) +")" 

ls_nombre_plan = f_obten_nombre_plan(ll_cve_plan)

this.st_nombre_plan.text =ls_nombre_plan +"(" +string(ll_cve_plan)+")" 

if w_revision_estudios_rediseño.st_regularizacion.visible = true then
	st_num_acuerdo.Visible = true
//	dw_acuerdos_rg.SetTransObject(gtr_sce)
	
	rtncode = dw_acuerdos_rg.GetChild('num_resolucion', dwch_acuerdos)
	IF rtncode = -1 THEN MessageBox( "Error", "No es un DataWindowChild",StopSign!)
	// Establish the connection
	// Set the transaction object for the child
	dwch_acuerdos.SetTransObject(gtr_sce)
	// Populate with values for acuerdos RG
	ll_row_child = dwch_acuerdos.Retrieve()
	// Set transaction object for main DW and retrieve
	dw_acuerdos_rg.SetTransObject(gtr_sce)
//	ll_row_child = dw_acuerdos_rg.Retrieve()

	dw_acuerdos_rg.Visible = true
	dw_acuerdos_rg.Enabled = true
	
end if

if not isvalid(in_cortes) then
	in_cortes = create n_cortes
end if

end event

on w_opciones_imprimir_rediseño.create
this.em_num_control_estatal=create em_num_control_estatal
this.st_num_control_estatal=create st_num_control_estatal
this.st_fecha_generacion=create st_fecha_generacion
this.em_fecha_generacion=create em_fecha_generacion
this.dw_oficio=create dw_oficio
this.dw_otorgado_por=create dw_otorgado_por
this.st_nombre_plan=create st_nombre_plan
this.st_plan_estudios=create st_plan_estudios
this.st_carrera=create st_carrera
this.st_programa=create st_programa
this.st_oficio_rvoe=create st_oficio_rvoe
this.st_otorgado_por=create st_otorgado_por
this.dw_historico_sin_traduccion=create dw_historico_sin_traduccion
this.uo_i_idioma=create uo_i_idioma
this.st_idioma=create st_idioma
this.st_num_acuerdo=create st_num_acuerdo
this.dw_acuerdos_rg=create dw_acuerdos_rg
this.cb_pos_simples=create cb_pos_simples
this.cb_lic_simples=create cb_lic_simples
this.em_pagnum=create em_pagnum
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.cb_configurar=create cb_configurar
this.rb_pagina=create rb_pagina
this.rb_total=create rb_total
this.cb_cambiar_nombre=create cb_cambiar_nombre
this.gb_1=create gb_1
this.dw_datos_certificado=create dw_datos_certificado
this.Control[]={this.em_num_control_estatal,&
this.st_num_control_estatal,&
this.st_fecha_generacion,&
this.em_fecha_generacion,&
this.dw_oficio,&
this.dw_otorgado_por,&
this.st_nombre_plan,&
this.st_plan_estudios,&
this.st_carrera,&
this.st_programa,&
this.st_oficio_rvoe,&
this.st_otorgado_por,&
this.dw_historico_sin_traduccion,&
this.uo_i_idioma,&
this.st_idioma,&
this.st_num_acuerdo,&
this.dw_acuerdos_rg,&
this.cb_pos_simples,&
this.cb_lic_simples,&
this.em_pagnum,&
this.cb_cancel,&
this.cb_ok,&
this.cb_configurar,&
this.rb_pagina,&
this.rb_total,&
this.cb_cambiar_nombre,&
this.gb_1,&
this.dw_datos_certificado}
end on

on w_opciones_imprimir_rediseño.destroy
destroy(this.em_num_control_estatal)
destroy(this.st_num_control_estatal)
destroy(this.st_fecha_generacion)
destroy(this.em_fecha_generacion)
destroy(this.dw_oficio)
destroy(this.dw_otorgado_por)
destroy(this.st_nombre_plan)
destroy(this.st_plan_estudios)
destroy(this.st_carrera)
destroy(this.st_programa)
destroy(this.st_oficio_rvoe)
destroy(this.st_otorgado_por)
destroy(this.dw_historico_sin_traduccion)
destroy(this.uo_i_idioma)
destroy(this.st_idioma)
destroy(this.st_num_acuerdo)
destroy(this.dw_acuerdos_rg)
destroy(this.cb_pos_simples)
destroy(this.cb_lic_simples)
destroy(this.em_pagnum)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.cb_configurar)
destroy(this.rb_pagina)
destroy(this.rb_total)
destroy(this.cb_cambiar_nombre)
destroy(this.gb_1)
destroy(this.dw_datos_certificado)
end on

event close;
if isvalid(in_cortes) then
	destroy in_cortes 
end if

end event

type em_num_control_estatal from editmask within w_opciones_imprimir_rediseño
integer x = 983
integer y = 1036
integer width = 891
integer height = 112
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "xxxxxxxxxxxxxxxxxxxxxxxxx"
end type

type st_num_control_estatal from statictext within w_opciones_imprimir_rediseño
integer x = 101
integer y = 1068
integer width = 809
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Número de Control Estatal :"
boolean focusrectangle = false
end type

type st_fecha_generacion from statictext within w_opciones_imprimir_rediseño
integer x = 1390
integer y = 552
integer width = 731
integer height = 84
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "FECHA DE GENERACIÓN:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fecha_generacion from editmask within w_opciones_imprimir_rediseño
integer x = 2135
integer y = 540
integer width = 402
integer height = 112
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type dw_oficio from datawindow within w_opciones_imprimir_rediseño
integer x = 119
integer y = 1704
integer width = 2802
integer height = 196
integer taborder = 90
string dataobject = "d_plan_rvoe_oficio_estatal_oficio"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;long ll_row_actual, ll_rows, ll_row_inicial
ll_row_actual = row


if ll_row_actual>0 then
	ll_rows = dw_oficio.Rowcount()
	for ll_row_inicial=1 to ll_rows
		dw_oficio.SelectRow(ll_row_inicial, false)
	next

	dw_oficio.ScrollToRow(ll_row_actual)
	dw_oficio.SelectRow(ll_row_actual, true)
end if
return 0

end event

type dw_otorgado_por from datawindow within w_opciones_imprimir_rediseño
integer x = 105
integer y = 1424
integer width = 2811
integer height = 188
integer taborder = 80
string dataobject = "d_plan_rvoe_oficio_estatal_otorgado"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;long ll_row_actual, ll_rows, ll_row_inicial
ll_row_actual = row

if ll_row_actual>0 then
	ll_rows = dw_otorgado_por.Rowcount()
	for ll_row_inicial=1 to ll_rows
		dw_otorgado_por.SelectRow(ll_row_inicial, false)
	next
	
	dw_otorgado_por.ScrollToRow(ll_row_actual)
	dw_otorgado_por.SelectRow(ll_row_actual, true)
end if
return 0

end event

type st_nombre_plan from statictext within w_opciones_imprimir_rediseño
integer x = 544
integer y = 1248
integer width = 1605
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean focusrectangle = false
end type

type st_plan_estudios from statictext within w_opciones_imprimir_rediseño
integer x = 101
integer y = 1248
integer width = 439
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Plan Estudios :"
boolean focusrectangle = false
end type

type st_carrera from statictext within w_opciones_imprimir_rediseño
integer x = 475
integer y = 1160
integer width = 1673
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean focusrectangle = false
end type

type st_programa from statictext within w_opciones_imprimir_rediseño
integer x = 101
integer y = 1156
integer width = 343
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Programa :"
boolean focusrectangle = false
end type

type st_oficio_rvoe from statictext within w_opciones_imprimir_rediseño
integer x = 101
integer y = 1620
integer width = 635
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Num. Oficio / RVOE:"
boolean focusrectangle = false
end type

type st_otorgado_por from statictext within w_opciones_imprimir_rediseño
integer x = 101
integer y = 1340
integer width = 430
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Otorgado por :"
boolean focusrectangle = false
end type

type dw_historico_sin_traduccion from datawindow within w_opciones_imprimir_rediseño
boolean visible = false
integer x = 133
integer y = 688
integer width = 1975
integer height = 128
integer taborder = 60
string title = "none"
string dataobject = "d_historico_sin_traduccion"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_i_idioma from uo_idioma within w_opciones_imprimir_rediseño
integer x = 430
integer y = 520
integer taborder = 90
boolean border = false
end type

on uo_i_idioma.destroy
call uo_idioma::destroy
end on

type st_idioma from statictext within w_opciones_imprimir_rediseño
integer x = 37
integer y = 552
integer width = 279
integer height = 84
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "IDIOMA:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_num_acuerdo from statictext within w_opciones_imprimir_rediseño
boolean visible = false
integer x = 110
integer y = 464
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Num.Acuerdo"
boolean focusrectangle = false
end type

type dw_acuerdos_rg from datawindow within w_opciones_imprimir_rediseño
boolean visible = false
integer x = 562
integer y = 444
integer width = 832
integer height = 104
integer taborder = 80
string title = "none"
string dataobject = "d_acuerdos_rg"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_pos_simples from commandbutton within w_opciones_imprimir_rediseño
boolean visible = false
integer x = 1143
integer y = 668
integer width = 320
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "POS REP"
end type

event clicked;uo_reporte_dw luo_reporte_dw
uds_datastore lds_certificado, lds_certificado_n
long ll_cuenta, ll_rows, ll_creditos_cursados, ll_cve_carrera, ll_cve_plan
integer li_res_print, li_cve_tipo_documento
string ls_final_reporte[], ls_carrera, ls_anio_plan, ls_nivel
string ls_grado_con_articulo, ls_carrera_sin_prefijo, ls_grado_carrera
string ls_array_inicio[], LineaR1, LineaR2

luo_reporte_dw = CREATE uo_reporte_dw
lds_certificado = CREATE uds_datastore
lds_certificado_n = CREATE uds_datastore
lds_certificado.dataobject = "d_certificados_pos_simples"
lds_certificado_n.dataobject = "d_certificados_pos_simples_n"

ll_cuenta = long(w_revision_estudios_rediseño.uo_1.em_cuenta.text)
ll_cve_carrera = w_revision_estudios_rediseño.il_cve_carrera
ll_cve_plan = w_revision_estudios_rediseño.il_cve_plan

ls_carrera_sin_prefijo = f_obten_carrera_sin_prefijo(ll_cve_carrera)
ls_grado_carrera = f_obten_grado_carrera(ll_cve_carrera)
ls_grado_con_articulo = f_obten_grado_con_articulo(ls_grado_carrera)


SetPointer(HourGlass!)
w_revision_estudios_rediseño.dw_prueba.SetSort("tipo A,periodonum A,sigla A")
w_revision_estudios_rediseño.dw_prueba.Sort()

//Certificado TOTAL
ls_carrera = mid(w_revision_estudios_rediseño.st_carrera.text,17)
ll_creditos_cursados= w_revision_estudios_rediseño.dw_revision_est_fmc.getitemnumber(1,"cursadost")
ls_anio_plan= mid(w_revision_estudios_rediseño.st_nivel.text,1,9)
ls_nivel= mid(w_revision_estudios_rediseño.st_nivel.text,11)
if w_revision_estudios_rediseño.dw_revision_est_fmc.getitemstring(1,"completo") = "si" then
	ls_final_reporte[1]="NOTA: Cubre íntegramente las materias y el mínimo de créditos para optar por"
	ls_final_reporte[2]=upper(f_elimina_acentos(ls_grado_con_articulo))+" EN " + f_elimina_acentos(ls_carrera_sin_prefijo)
	ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
else
//Certificado PARCIAL
	ls_final_reporte[1]="NOTA: El presente certificado parcial ampara "+string(ll_creditos_cursados)+" créditos correspondientes al Plan de"
	ls_final_reporte[2]="Estudios "+ls_anio_plan+" de "+f_elimina_acentos(ls_grado_con_articulo)+" EN "+f_elimina_acentos(ls_carrera_sin_prefijo) 
	ls_final_reporte[3]="---------------------------------------------------------------------------------------------"

end if

if ll_cve_plan= 3 then
	li_cve_tipo_documento=4
else
	li_cve_tipo_documento=2
end if

if luo_reporte_dw.f_genera_cuerpo(li_cve_tipo_documento,w_revision_estudios_rediseño.dw_prueba, ll_cuenta,false,ls_final_reporte,true, ls_array_inicio, ll_cve_carrera ) <> -1 then
	lds_certificado.SetTransObject(gtr_sce)
	ll_rows = lds_certificado.Retrieve(ll_cuenta, li_cve_tipo_documento, 1, 1)
	if ll_rows >0 then 
		li_res_print= lds_certificado.Print()	
		if li_res_print = 1 then
			lds_certificado_n.SetTransObject(gtr_sce)
			ll_rows = lds_certificado_n.Retrieve(ll_cuenta, li_cve_tipo_documento, 1, 9999)
			if ll_rows >0 then 
				li_res_print= lds_certificado_n.Print()	
				if li_res_print = 1 then			
					MessageBox("Impresion Exitosa","Favor de recoger el certificado en la impresora",Information!)
				end if				
			else
				MessageBox("No hay más registros","Solo existe una hoja.~nNo es posible imprimir más (lds_certificado_n).",StopSign!)		
			end if		
		end if
	else
			MessageBox("No hay registros","No es posible imprimir lds_certificado",StopSign!)		
	end if
end if

if isvalid(luo_reporte_dw) then
	DESTROY luo_reporte_dw 
end if

if isvalid(lds_certificado) then
	DESTROY lds_certificado
end if

if isvalid(lds_certificado_n) then
	DESTROY lds_certificado_n
end if

end event

type cb_lic_simples from commandbutton within w_opciones_imprimir_rediseño
boolean visible = false
integer x = 1143
integer y = 556
integer width = 315
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "LIC REP"
end type

event clicked;uo_reporte_dw luo_reporte_dw
uds_datastore lds_certificado, lds_certificado_n
long ll_cuenta, ll_rows, ll_creditos_cursados, ll_cve_carrera, ll_cve_plan
integer li_res_print, li_cve_tipo_documento
string ls_final_reporte[], ls_carrera, ls_anio_plan, ls_nivel
string ls_carrera_sin_prefijo, ls_grado_carrera, ls_grado_con_articulo
string ls_array_inicio[], LineaR1, LineaR2

luo_reporte_dw = CREATE uo_reporte_dw
lds_certificado = CREATE uds_datastore
lds_certificado_n = CREATE uds_datastore
lds_certificado.dataobject = "d_certificados_lic_simples"
lds_certificado_n.dataobject = "d_certificados_lic_simples_n"


if w_revision_estudios_rediseño.gb_revalidacion.visible = true then
	LineaR1 = "MATERIAS EQUIVALENTES SEGUN "
	if w_revision_estudios_rediseño.rb_oficio.checked = true then
		LineaR1 += "OFICIO No. "
	elseif w_revision_estudios_rediseño.rb_folio.checked = true then
		LineaR1 += "FOLIO No. "
	else
		LineaR1 += "EXPEDIENTE No. "
	end if
	LineaR1 += w_revision_estudios_rediseño.em_numero.text
	LineaR2 = "DE FECHA "+  mid(w_revision_estudios_rediseño.em_fecha.text,1,2)+" DE "+&
					 DameMes(integer(mid(w_revision_estudios_rediseño.em_fecha.text,4,2)))+" DE " +mid(w_revision_estudios_rediseño.em_fecha.text,7,4) 
	ls_array_inicio[1]= LineaR1
	ls_array_inicio[2]= LineaR2	
end if


ll_cuenta = long(w_revision_estudios_rediseño.uo_1.em_cuenta.text)
ll_cve_carrera = w_revision_estudios_rediseño.il_cve_carrera
ll_cve_plan = w_revision_estudios_rediseño.il_cve_plan

ls_carrera_sin_prefijo = f_obten_carrera_sin_prefijo(ll_cve_carrera)
ls_grado_carrera = f_obten_grado_carrera(ll_cve_carrera)
ls_grado_con_articulo = f_obten_grado_con_articulo(ls_grado_carrera)


SetPointer(HourGlass!)
w_revision_estudios_rediseño.dw_prueba.SetSort("tipo A,periodonum A,sigla A")
w_revision_estudios_rediseño.dw_prueba.Sort()

//Certificado TOTAL
ls_carrera = mid(w_revision_estudios_rediseño.st_carrera.text,17)
ll_creditos_cursados= w_revision_estudios_rediseño.dw_revision_est_fmc.getitemnumber(1,"cursadost")
ls_anio_plan= mid(w_revision_estudios_rediseño.st_nivel.text,1,9)
ls_nivel= mid(w_revision_estudios_rediseño.st_nivel.text,11)
if w_revision_estudios_rediseño.dw_revision_est_fmc.getitemstring(1,"completo") = "si" then
	ls_final_reporte[1]="NOTA: Cubre íntegramente las materias y el mínimo de créditos para optar por el TITULO"
	ls_final_reporte[2]="DE LICENCIADO EN " + f_elimina_acentos(ls_carrera)
	ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
else
//Certificado PARCIAL
	ls_final_reporte[1]="NOTA: El presente certificado parcial ampara "+string(ll_creditos_cursados)+" créditos correspondientes al Plan de"
	ls_final_reporte[2]="Estudios "+ls_anio_plan+" de la "+f_elimina_acentos(ls_nivel)+" en "+f_elimina_acentos(ls_carrera )
	ls_final_reporte[3]="---------------------------------------------------------------------------------------------"

end if

if ll_cve_plan= 3 then
	li_cve_tipo_documento=3
else
	li_cve_tipo_documento=1
end if


if luo_reporte_dw.f_genera_cuerpo(li_cve_tipo_documento,w_revision_estudios_rediseño.dw_prueba, ll_cuenta,false,ls_final_reporte,true , ls_array_inicio, ll_cve_carrera) <> -1 then
	lds_certificado.SetTransObject(gtr_sce)
	ll_rows = lds_certificado.Retrieve(ll_cuenta, li_cve_tipo_documento, 1, 1)
	if ll_rows >0 then 
		li_res_print= lds_certificado.Print()	
		if li_res_print = 1 then
			lds_certificado_n.SetTransObject(gtr_sce)
			ll_rows = lds_certificado_n.Retrieve(ll_cuenta, li_cve_tipo_documento, 1, 9999)
			if ll_rows >0 then 
				li_res_print= lds_certificado_n.Print()	
				if li_res_print = 1 then			
					MessageBox("Impresion Exitosa","Favor de recoger el certificado en la impresora",Information!)
				end if				
			else
				MessageBox("No hay más registros","Solo existe una hoja.~nNo es posible imprimir",StopSign!)		
			end if		
		end if
	else
			MessageBox("No hay registros","No es posible imprimir",StopSign!)		
	end if
end if

if isvalid(luo_reporte_dw) then
	DESTROY luo_reporte_dw 
end if

if isvalid(lds_certificado) then
	DESTROY lds_certificado
end if

if isvalid(lds_certificado_n) then
	DESTROY lds_certificado_n
end if

end event

type em_pagnum from editmask within w_opciones_imprimir_rediseño
integer x = 631
integer y = 256
integer width = 96
integer height = 84
integer taborder = 100
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "1"
borderstyle borderstyle = stylelowered!
string mask = "#"
string displaydata = ""
end type

type cb_cancel from commandbutton within w_opciones_imprimir_rediseño
integer x = 1486
integer y = 848
integer width = 389
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;close(parent)
end event

type cb_ok from commandbutton within w_opciones_imprimir_rediseño
integer x = 978
integer y = 848
integer width = 389
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
end type

event clicked;int pag, li_espacio, li_empieza
string LineaCarrera1, LineaCarrera2, lasrayas
int  total, tot
long numero
int contador1
int materias = 12
int renglon
int oblig,opta,forma
string Linea, LineaR1, LineaR2, LineaC1, LineaC2, LineaC3
string carrera
long cue
datetime fecha
int tipo, tipoant
int numpag, pagnum = 0
int li_relleno = 0
string ls_director
string ls_nivel, ls_carrera_posgrado, ls_subnombre_especialidad
int li_ind_maestria, li_ind_especialidad, li_ind_doctorado
boolean NoImprime = false
boolean es_especialidad= false, lb_legalizado
parent.enabled = false
long ll_cuenta, ll_cve_carrera, ll_cve_plan, ll_row_actual
string ls_numero_acuerdo = ""
integer li_cve_plantel_vigente
//Si el certificado lleva holograma

ll_cuenta = long(w_revision_estudios_rediseño.uo_1.em_cuenta.text)
ll_cve_carrera = w_revision_estudios_rediseño.il_cve_carrera
ll_cve_plan = w_revision_estudios_rediseño.il_cve_plan
lb_legalizado = w_revision_estudios_rediseño.ib_legalizado
ls_nivel = w_revision_estudios_rediseño.is_nivel 

is_numero_acuerdo = ""

//20-04-2018 LOS CERTIFICADOS R.G SON SOLO PARA CDMX
li_cve_plantel_vigente = f_obten_cve_plantel_vigente ()
if li_cve_plantel_vigente = -1 then
	MessageBox("Error en plantel vigente","No es posible consultar el plantel vigente",StopSign!)
	return
end if

if li_cve_plantel_vigente = 17 then

	if w_revision_estudios_rediseño.st_regularizacion.visible = true then
		if dw_acuerdos_rg.RowCount()=0 then
			MessageBox("Acuerdos no registrados","Favor de registrar acuerdos RG",StopSign!)
		else
			ll_row_actual = dw_acuerdos_rg.Getrow()
			ls_numero_acuerdo = dw_acuerdos_rg.GetItemString(ll_row_actual,"num_resolucion")
		end if
		if ls_numero_acuerdo = "-" then
			MessageBox("Acuerdo no elegido","Favor de elegir un acuerdo RG",StopSign!)
			is_numero_acuerdo = ""
			Goto Fin
		else
			is_numero_acuerdo = ls_numero_acuerdo
		end if	
	end if
end if

if wf_imprime_certificado(ll_cuenta, ll_cve_carrera, ll_cve_plan, lb_legalizado, ls_nivel)= 0 then
	Goto Certificados
else
	messagebox("Error","Error al imprimir el certificado")	
end if
			 
//if mid(w_revision_estudios_rediseño.st_nivel.text,11) = "LICENCIATURA" and &
//		(w_revision_estudios_rediseño.cbx_legal.checked= false) then 
//	cb_lic_simples.event clicked()
//	Goto Simples
//end if
//
//if (w_revision_estudios_rediseño.is_nivel) = "P" and &
//		(w_revision_estudios_rediseño.cbx_legal.checked= false) then 
//	cb_pos_simples.event clicked()
//	Goto Simples
//end if


if dw_datos_certificado.rowcount() = 1 then
	ls_director=dw_datos_certificado.getitemstring(1,"nombre")
else
	messagebox("Error","Error al obtener el nombre del director")
end if

//-* Solo para ver el resultado intermedio 
//w_revision_estudios_rediseño.dw_prueba.print()

select getdate() into :fecha from carreras using gtr_sce;

cue = long(w_revision_estudios_rediseño.uo_1.em_cuenta.text)
carrera = f_elimina_acentos(mid(w_revision_estudios_rediseño.st_carrera.text,17))

LineaR1 = "     MATERIAS EQUIVALENTES SEGUN "
if w_revision_estudios_rediseño.rb_oficio.checked = true then
	LineaR1 += "OFICIO No. "
elseif w_revision_estudios_rediseño.rb_folio.checked = true then
	LineaR1 += "FOLIO No. "
else
	LineaR1 += "EXPEDIENTE No. "
end if
LineaR1 += w_revision_estudios_rediseño.em_numero.text
LineaR2 = "     DE FECHA "+  mid(w_revision_estudios_rediseño.em_fecha.text,1,2)+" DE "+&
				 DameMes(integer(mid(w_revision_estudios_rediseño.em_fecha.text,4,2)))+" DE " +mid(w_revision_estudios_rediseño.em_fecha.text,7,4) 
				 
if mid(w_revision_estudios_rediseño.st_nivel.text,11) = "LICENCIATURA" then ls_nivel = "L"	


if w_revision_estudios_rediseño.dw_revision_est_fmc.getitemstring(1,"completo") = "si" then
//-	LineaC1 = "     NOTA: Cubre íntegramente las materias y el mínimo de créditos para optar por el TITULO"
	//LineaC2 = "     por el TITULO DE " //variable
//-	  LineaC2 = "     DE "


	//if ls_nivel = "L" then
	if ls_nivel <> "P" then
		LineaC1 = "     NOTA: Cubre íntegramente las materias y el mínimo de créditos para optar por el TITULO"
		//LineaC2 = "     por el TITULO DE " //variable
		LineaC2 = "     DE "
		LineaC2 += "LICENCIADO EN " + carrera
	else		
		
		
		LineaC1 = "     NOTA: Cubre íntegramente las materias y el mínimo de créditos para optar por "
//-		LineaC2 = "     DE "
//-		LineaC2 += mid(w_revision_estudios_rediseño.st_nivel.text,11) + " EN " +carrera
//-		ls_carrera_posgrado= carrera
		
		if pos(carrera,"MAESTRIA EN")>0 then
			li_ind_maestria= 13
			ls_carrera_posgrado= "     la MAESTRIA EN "+mid(carrera,li_ind_maestria)
		end if
		
		if pos(carrera,"DOCTORADO EN")>0 then
			li_ind_doctorado= 14
			ls_carrera_posgrado= "     el DOCTORADO EN "+mid(carrera,li_ind_doctorado)
		end if
		if pos(carrera, "ESP.EN")>0 and pos(carrera,"MAESTRIA EN")=0 then
			li_ind_especialidad= 7
			ls_subnombre_especialidad= mid(carrera,li_ind_especialidad)
			ls_carrera_posgrado= "     la ESPECIALIDAD EN "+mid(carrera,li_ind_especialidad)
			es_especialidad=true
		end if		
		if pos(carrera, "ESP. EN")>0 and pos(carrera,"MAESTRIA EN")=0 then
			li_ind_especialidad= 8
			ls_subnombre_especialidad= mid(carrera,li_ind_especialidad)
			ls_carrera_posgrado= "     la ESPECIALIDAD EN "+mid(carrera,li_ind_especialidad)
			es_especialidad=true
		end if		
		if pos(carrera, "ESPEC.EN")>0 and pos(carrera,"MAESTRIA EN")=0 then
			li_ind_especialidad= 9
			ls_subnombre_especialidad= mid(carrera,li_ind_especialidad)
			ls_carrera_posgrado= "     la ESPECIALIDAD EN "+mid(carrera,li_ind_especialidad)
			es_especialidad=true
		end if		
		if pos(carrera, "ESPECIALIZ. EN")>0 and pos(carrera,"MAESTRIA EN")=0 then
			li_ind_especialidad= 15
			ls_subnombre_especialidad= mid(carrera,li_ind_especialidad)
			ls_carrera_posgrado= "     la ESPECIALIDAD EN "+mid(carrera,li_ind_especialidad)
			es_especialidad=true
		end if		
		if pos(carrera, "ESPECIALIZA.EN")>0 and pos(carrera,"MAESTRIA EN")=0 then
			li_ind_especialidad= 15
			ls_subnombre_especialidad= mid(carrera,li_ind_especialidad)
			ls_carrera_posgrado= "     la ESPECIALIDAD EN "+mid(carrera,li_ind_especialidad)
			es_especialidad=true
		end if		
		if pos(carrera, "ESPECIALIDAD EN")>0 and pos(carrera,"MAESTRIA EN")=0 then
			li_ind_especialidad= 16
			ls_subnombre_especialidad= mid(carrera,li_ind_especialidad)
			ls_carrera_posgrado= "     la ESPECIALIDAD EN "+mid(carrera,li_ind_especialidad)
			es_especialidad=true
		end if		
		if pos(carrera, "ESPECIALIZACION")>0 and pos(carrera,"MAESTRIA EN")=0 then
			if pos(carrera, "EN ")>0 then
				li_ind_especialidad= 20
				ls_subnombre_especialidad= mid(carrera,li_ind_especialidad)
				ls_carrera_posgrado= "     la ESPECIALIDAD EN "+mid(carrera,li_ind_especialidad)
 				es_especialidad=true
			else
				li_ind_especialidad= 16				
				ls_subnombre_especialidad= mid(carrera,li_ind_especialidad)
				ls_carrera_posgrado= "la ESPECIALIDAD EN "+mid(carrera,li_ind_especialidad)
				es_especialidad=true
			end if
		end if		

		LineaC2 += ls_carrera_posgrado
				
//		li_ind_especialidad
//		"ESP. EN"  7
//		"ESP.EN" 6
//		"ESPEC.EN" 8
//		"ESPECIALIDAD EN" 15
//		"ESPECIALIZ. EN" 14
//		"ESPECIALIZA.EN" 14
//		"ESPECIALIZACION" 15
//		"ESPECIALIZACION EN" 18  
		
	end if
else
	LineaC1 = "     NOTA: El presente certificado parcial ampara "+&
						string(w_revision_estudios_rediseño.dw_revision_est_fmc.getitemnumber(1,"cursadost"))+" créditos correspondientes al Plan de"
	LineaC2 = "     Estudios "/*"al Plan de Estudios " */+mid(w_revision_estudios_rediseño.st_nivel.text,1,9)
	//if ls_nivel = "L" then
	if ls_nivel <> "P" then
		LineaC2 += " de la "+mid(w_revision_estudios_rediseño.st_nivel.text,11)+ " en "+carrera  //variable
	else
		if pos(carrera,"MAESTRIA EN")>0 then
			li_ind_maestria= 13
			ls_carrera_posgrado= " de la MAESTRIA EN "+mid(carrera,li_ind_maestria)
		end if
		
		if pos(carrera,"DOCTORADO EN")>0 then
			li_ind_doctorado= 14
			ls_carrera_posgrado= " del DOCTORADO EN "+mid(carrera,li_ind_doctorado)
		end if
		
		if pos(carrera, "ESP.EN")>0 and pos(carrera,"MAESTRIA EN")=0 then
			li_ind_especialidad= 7
			ls_subnombre_especialidad= mid(carrera,li_ind_especialidad)
			ls_carrera_posgrado= " de la ESPECIALIDAD EN "+mid(carrera,li_ind_especialidad)
			es_especialidad=true
		end if		
		if pos(carrera, "ESP. EN")>0 and pos(carrera,"MAESTRIA EN")=0 then
			li_ind_especialidad= 8
			ls_subnombre_especialidad= mid(carrera,li_ind_especialidad)
			ls_carrera_posgrado= " de la ESPECIALIDAD EN "+mid(carrera,li_ind_especialidad)
			es_especialidad=true
		end if		
		if pos(carrera, "ESPEC.EN")>0 and pos(carrera,"MAESTRIA EN")=0 then
			li_ind_especialidad= 9
			ls_subnombre_especialidad= mid(carrera,li_ind_especialidad)
			ls_carrera_posgrado= " de la ESPECIALIDAD EN "+mid(carrera,li_ind_especialidad)
			es_especialidad=true
		end if		
		if pos(carrera, "ESPECIALIZ. EN")>0 and pos(carrera,"MAESTRIA EN")=0 then
			li_ind_especialidad= 15
			ls_subnombre_especialidad= mid(carrera,li_ind_especialidad)
			ls_carrera_posgrado= " de la ESPECIALIDAD EN "+mid(carrera,li_ind_especialidad)
			es_especialidad=true
		end if		
		if pos(carrera, "ESPECIALIZA.EN")>0 and pos(carrera,"MAESTRIA EN")=0 then
			li_ind_especialidad= 15
			ls_subnombre_especialidad= mid(carrera,li_ind_especialidad)
			ls_carrera_posgrado= " de la ESPECIALIDAD EN "+mid(carrera,li_ind_especialidad)
			es_especialidad=true
		end if		
		if pos(carrera, "ESPECIALIDAD EN")>0 and pos(carrera,"MAESTRIA EN")=0 then
			li_ind_especialidad= 16
			ls_subnombre_especialidad= mid(carrera,li_ind_especialidad)
			ls_carrera_posgrado= " de la ESPECIALIDAD EN "+mid(carrera,li_ind_especialidad)
			es_especialidad=true
		end if		
		if pos(carrera, "ESPECIALIZACION")>0  and pos(carrera,"MAESTRIA EN")=0 then
			if pos(carrera, "EN ")>0 then
				li_ind_especialidad= 20
				ls_subnombre_especialidad= mid(carrera,li_ind_especialidad)
				ls_carrera_posgrado= " de la ESPECIALIDAD EN "+mid(carrera,li_ind_especialidad)
				es_especialidad=true
			else
				li_ind_especialidad= 16				
				ls_subnombre_especialidad= mid(carrera,li_ind_especialidad)
				ls_carrera_posgrado= " de la ESPECIALIDAD EN "+mid(carrera,li_ind_especialidad)
				es_especialidad=true
			end if
		end if		

//-		LineaC2 += " del "+mid(w_revision_estudios_rediseño.st_nivel.text,11)+ " en "+carrera  //variable
		LineaC2 += ls_carrera_posgrado

	end if
end if
	LineaC2 += " "
	LineaC3 = w_revision_estudios_rediseño.Alinea(LineaC2,93)
	LineaC3 = RightTrim(LineaC3)
if not es_especialidad then					
	LineaCarrera1 = "                     "+carrera
else
	LineaCarrera1 = "                     "+"ESPECIALIDAD EN "+	ls_subnombre_especialidad
end if
LineaCarrera2 = "            "+w_revision_estudios_rediseño.Alinea(LineaCarrera1,73)


numero=PrintOpen()
PrintSetSpacing(numero,1.09)
PrintDefineFont(numero, 2, "Courier New",  &
	-10, 400, Default!, Roman!, FALSE, FALSE)
PrintDefineFont(numero, 3, "Arial",  &
	-6, 400, Default!, Modern!, FALSE, FALSE)

w_revision_estudios_rediseño.dw_prueba.SetFilter("tipo = 1"); w_revision_estudios_rediseño.dw_prueba.Filter(); oblig = w_revision_estudios_rediseño.dw_prueba.RowCount()
w_revision_estudios_rediseño.dw_prueba.SetFilter("tipo = 2"); w_revision_estudios_rediseño.dw_prueba.Filter(); opta = w_revision_estudios_rediseño.dw_prueba.RowCount()
w_revision_estudios_rediseño.dw_prueba.SetFilter("tipo = 3"); w_revision_estudios_rediseño.dw_prueba.Filter(); forma = w_revision_estudios_rediseño.dw_prueba.RowCount()
w_revision_estudios_rediseño.dw_prueba.SetFilter(""); w_revision_estudios_rediseño.dw_prueba.Filter();total = w_revision_estudios_rediseño.dw_prueba.RowCount()
total --;

if w_revision_estudios_rediseño.gb_revalidacion.visible = true then
	tot = total
	total = 10000
end if
	
renglon = 2
w_revision_estudios_rediseño.dw_prueba.SetSort("tipo A,periodonum A,sigla A")
w_revision_estudios_rediseño.dw_prueba.Sort()
PrintSetFont(numero,2)
//if ((w_revision_estudios_rediseño.cbx_legal.checked) AND&
//	((rb_total.checked = true) OR (integer(em_pagnum.text) = 1))) then
//		PrintBitmap(numero, "SepCompleto.bmp",1900,3700, 0,0)
//end if
tipoant = 0	
if (w_revision_estudios_rediseño.cbx_legal.checked) then 
	pag = 75
	li_espacio = 16
	li_empieza = 22
	if LineaC1 <> "" then LineaC1 = "" + LineaC1
	if LineaC2 <> "" then LineaC2 = "" + LineaC2
	if LineaC3 <> "" then LineaC3 = "" + LineaC3
	if LineaR1 <> "" then LineaR1 = "" + LineaR1
	if LineaR2 <> "" then LineaR2 = "" + LineaR2
	lasrayas = "    -------------------------------------------------------------------------------------"
else
	//SIMPLE
	pag = 75
	li_empieza = 21
	li_espacio = 13
	lasrayas = "    ----------------------------------------------------------------------------------------"
end if
if total > 0 then pagnum = 1 
FOR contador1=0 TO 531 //numpag*66 //568 //71
 if pagnum > 0 then
	CHOOSE CASE mod(contador1,pag)+1
	CASE 1 
		   Linea = "        " + w_revision_estudios_rediseño.uo_1.em_cuenta.text+&
														w_revision_estudios_rediseño.uo_1.em_digito.text
	CASE 2 TO 8
			Linea = ""
	CASE 9
		   PrintSetFont(numero,2)
			if not (w_revision_estudios_rediseño.cbx_legal.checked) then 
			//SIMPLE	
			 Linea = "                  "    +w_revision_estudios_rediseño.uo_1.dw_nombre_alumno.object.nombre[1]+&
													 " "+w_revision_estudios_rediseño.uo_1.dw_nombre_alumno.object.apaterno[1]+&
													 " "+w_revision_estudios_rediseño.uo_1.dw_nombre_alumno.object.amaterno[1]
			else
				Linea = ""
			end if
	CASE 10 TO 11
			Linea = ""
	CASE 12
		if  (w_revision_estudios_rediseño.cbx_legal.checked) and pagnum > 1 then 			
			 Linea = "                  "    +w_revision_estudios_rediseño.uo_1.dw_nombre_alumno.object.nombre[1]+&
													 " "+w_revision_estudios_rediseño.uo_1.dw_nombre_alumno.object.apaterno[1]+&
													 " "+w_revision_estudios_rediseño.uo_1.dw_nombre_alumno.object.amaterno[1]
			else
				//SIMPLE
				Linea = ""
			end if
	CASE 13
			Linea = ""
	CASE 14
		if not (w_revision_estudios_rediseño.cbx_legal.checked) then 
		//SIMPLE	
			Linea = LineaCarrera1
		else
			Linea = ""
		end if
	CASE 15
		if not (w_revision_estudios_rediseño.cbx_legal.checked) then 
		//SIMPLE
			Linea = LineaCarrera2
		else
			if (w_revision_estudios_rediseño.cbx_legal.checked) and pagnum > 1 then
				Linea = LineaCarrera1
			else
			//SIMPLE
				Linea = ""
			end if
		end if
	CASE 16
		if (w_revision_estudios_rediseño.cbx_legal.checked) and pagnum > 1 then
			Linea = LineaCarrera2
		else
		//SIMPLE
			Linea = ""
		end if
	CASE 17
		Linea = ""
	CASE 18 to li_empieza - 2
			Linea = ""
	CASE li_empieza - 1
		   PrintSetFont(numero,3)
			Linea = ""
			Print(numero, Linea)
	CASE li_empieza to pag - li_espacio
			PrintSetFont(numero,2)
			if total < 0 then
				choose case total
					case -4
						Linea = LineaC1
					case -3
						Linea = LineaC2
					case -2
						if LineaC3 <> "" then
							Linea = LineaC3
						else
							Linea = lasrayas
							total++
						end if
					case -1
						Linea = lasrayas
				end choose
				total++
			else
				if (((pagnum = 1) and (contador1 <= (pag - 37)) and&
				   (w_revision_estudios_rediseño.cbx_legal.checked)) OR (total = 0)) then
					choose case contador1
						case 29
							Linea = "                  "    +w_revision_estudios_rediseño.uo_1.dw_nombre_alumno.object.nombre[1]+&
									" "+w_revision_estudios_rediseño.uo_1.dw_nombre_alumno.object.apaterno[1]+&
									" "+w_revision_estudios_rediseño.uo_1.dw_nombre_alumno.object.amaterno[1]
						case 32
							Linea = LineaCarrera1
						case 33
							Linea = LineaCarrera2
						case else
							Linea = ""
					end choose
					if total = 0 then Linea = ""
				else
				//SIMPLE
					if total >= 10000 then
						choose case total
							case 10000
								Linea = LineaR1
								total++
							case 10001
								Linea = LineaR2
								total = tot
						end choose
					else
					if ((total = 1) AND (mod(contador1,pag)+1 > pag - li_espacio - 2 )) then
						li_relleno = mod(contador1,pag)
						contador1 = pag - li_espacio - 1
						li_relleno = contador1 - li_relleno 
					end if
					if (mod(contador1,pag)+1 = pag - li_espacio) then
						Linea = lasrayas
						do while li_relleno > 0 
							if  ((rb_total.checked = true) OR (integer(em_pagnum.text) = pagnum)) then Print(numero,Linea)
							Linea = ""
							li_relleno --
						loop
					else
						tipo = w_revision_estudios_rediseño.dw_prueba.GetItemNumber(renglon,"tipo")
						if tipo <> tipoant then
							choose case tipo
								case 1 
									Linea = "                    MATERIAS OBLIGATORIAS"
								case 2
									Linea = "                    MATERIAS OPTATIVAS"
								case 3
									Linea = "                    MATERIAS DE FORMACION UNIVERSITARIA"
								case else
									Linea = ""
							end choose 
							tipoant = tipo
						else
							Linea = "   "
							//if (w_revision_estudios_rediseño.cbx_legal.checked) and ls_nivel = "L" then Linea += " "
							if (w_revision_estudios_rediseño.cbx_legal.checked) and ls_nivel <> "P" then Linea += " "
							if IsNull(w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,3)) then
								Linea += "       "
							else
								Linea += space(7 - len(w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,3)))+w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,3)
							end if
							if (w_revision_estudios_rediseño.cbx_legal.checked) then
								Linea += " "+mid( w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,4),1,47)+space(49 - len(w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,4)))+&
								w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,5)+Space(5 - len(w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,5)))+&
								space(2 - len(string(w_revision_estudios_rediseño.dw_prueba.GetItemNumber(renglon,6))))+string(w_revision_estudios_rediseño.dw_prueba.GetItemNumber(renglon,6))+"   "+&
								space(2 - len(w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,7)))+w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,7)+"   "+&
								w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,8)+space(12 - len(w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,8)))+&
								w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,9)

							else
							//SIMPLE
								//if ls_nivel = "L" then
								if ls_nivel <> "P" then
									Linea += "  "+w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,4)+space(50 - len(w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,4)))+&
									w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,5)+Space(4 - len(w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,5)))+&
									space(2 - len(string(w_revision_estudios_rediseño.dw_prueba.GetItemNumber(renglon,6))))+string(w_revision_estudios_rediseño.dw_prueba.GetItemNumber(renglon,6))+"   "+&
									space(2 - len(w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,7)))+w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,7)+"  "+&
									w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,8)+space(13 - len(w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,8)))+&
									w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,9)
								else
									Linea += " "+w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,4)+space(50 - len(w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,4)))+&
									w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,5)+Space(4 - len(w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,5)))+&
									space(2 - len(string(w_revision_estudios_rediseño.dw_prueba.GetItemNumber(renglon,6))))+string(w_revision_estudios_rediseño.dw_prueba.GetItemNumber(renglon,6))+"   "+&
									space(2 - len(w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,7)))+w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,7)+"   "+&
									w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,8)+space(13 - len(w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,8)))+&
									w_revision_estudios_rediseño.dw_prueba.GetItemString(renglon,9)
						
								end if
							end if
							if (not(w_revision_estudios_rediseño.cbx_legal.checked) and ls_nivel <> "L") then Linea = "  "+Linea
							//SIMPLE
							renglon++
							total --
							if total = 0 then
								total = -4
							end if
						end if
					end if
				end if
				end if
			end if
	CASE pag - li_espacio + 1 TO pag - 12 
			Linea = ""
	CASE pag - 11
		if w_revision_estudios_rediseño.cbx_legal.checked then
			Linea = "                                "+string(fecha,"dd      ")+DameMes(integer(string(fecha,"m")))+&
			"          "+string(fecha,"yy")+&
			"                   "+string(pagnum)
		else
		//SIMPLE
			Linea = ""
		end if
//	CASE pag - 11 
//		Linea = ""
	CASE pag - 10
		if not(w_revision_estudios_rediseño.cbx_legal.checked) then
		//SIMPLE
			Linea = "                              "+string(fecha,"dd        ")+DameMes(integer(string(fecha,"m")))+&
					"                 "+string(fecha,"yyyy")+&
			  		"                   "+string(pagnum)
		else
			Linea = ""
		end if
	CASE pag - 9 TO pag - 2
			Linea = ""
	CASE pag - 1
		if w_revision_estudios_rediseño.cbx_legal.checked then
			Linea = "                                                                "+ls_director
		else
		//SIMPLE
			Linea = ""
		end if
//	CASE pag - 1 
//			Linea = ""
	CASE pag
			PrintSetFont(numero,2)
			if not(w_revision_estudios_rediseño.cbx_legal.checked) then
			//SIMPLE
				Linea = "                                                            "+ls_director
			else
				Linea = ""
				if total <= 0 then NoImprime = True
			end if 
	END CHOOSE
	if  ((rb_total.checked = true) OR (integer(em_pagnum.text) = pagnum)) and not(NoImprime) then Print(numero, Linea)
	if mod(contador1,pag) = pag - 1 then
		if total > 0 then
			pagnum++
		else
			pagnum = -1
		end if	
	end if
end if
NEXT
PrintClose(numero)
parent.enabled = true
Close(parent)
return

Certificados:
parent.enabled = true
Close(parent)
return
Fin:
parent.enabled = true
return
end event

type cb_configurar from commandbutton within w_opciones_imprimir_rediseño
integer x = 1138
integer y = 160
integer width = 599
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Configurar Impresora"
end type

event clicked;printsetup()
end event

type rb_pagina from radiobutton within w_opciones_imprimir_rediseño
integer x = 174
integer y = 256
integer width = 389
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Una Página"
end type

event clicked;em_pagnum.enabled = true
end event

type rb_total from radiobutton within w_opciones_imprimir_rediseño
integer x = 174
integer y = 156
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Total"
boolean checked = true
end type

event clicked;em_pagnum.enabled = false
end event

type cb_cambiar_nombre from commandbutton within w_opciones_imprimir_rediseño
boolean visible = false
integer x = 1175
integer y = 188
integer width = 599
integer height = 108
integer taborder = 90
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cambiar Nombre"
end type

event clicked;if text = "Cambiar Nombre" then
	dw_datos_certificado.enabled = true
	dw_datos_certificado.object.datawindow.color = RGB(255,255,255)
	this.text = "Actualizar"
else
	if dw_datos_certificado.update() = 1 then
		commit using gtr_sce;
		messagebox("Información","Se han guardado los cambios")
	else
		rollback using gtr_sce;
		messagebox("Información","No se han guardado los cambios",stopsign!)
	end if
	dw_datos_certificado.object.datawindow.color = RGB(160,160,164)
	dw_datos_certificado.enabled = false
	this.text = "Cambiar Nombre"
end if
	
end event

type gb_1 from groupbox within w_opciones_imprimir_rediseño
integer x = 123
integer y = 28
integer width = 667
integer height = 380
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Impresion"
end type

type dw_datos_certificado from datawindow within w_opciones_imprimir_rediseño
boolean visible = false
integer x = 91
integer y = 984
integer width = 1993
integer height = 100
integer taborder = 70
boolean enabled = false
string dataobject = "d_datos_certificado"
boolean border = false
boolean livescroll = true
end type

event constructor;SetTrans(gtr_sce)
end event

