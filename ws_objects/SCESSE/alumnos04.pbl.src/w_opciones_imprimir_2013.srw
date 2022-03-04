$PBExportHeader$w_opciones_imprimir_2013.srw
forward
global type w_opciones_imprimir_2013 from window
end type
type em_pagnum from editmask within w_opciones_imprimir_2013
end type
type cb_cancel from commandbutton within w_opciones_imprimir_2013
end type
type cb_ok from commandbutton within w_opciones_imprimir_2013
end type
type cb_configurar from commandbutton within w_opciones_imprimir_2013
end type
type rb_pagina from radiobutton within w_opciones_imprimir_2013
end type
type rb_total from radiobutton within w_opciones_imprimir_2013
end type
type cb_cambiar_nombre from commandbutton within w_opciones_imprimir_2013
end type
type dw_datos_certificado from datawindow within w_opciones_imprimir_2013
end type
type gb_1 from groupbox within w_opciones_imprimir_2013
end type
end forward

global type w_opciones_imprimir_2013 from window
integer x = 832
integer y = 364
integer width = 1477
integer height = 860
boolean titlebar = true
string title = "Opciones de Impresión"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 16777215
em_pagnum em_pagnum
cb_cancel cb_cancel
cb_ok cb_ok
cb_configurar cb_configurar
rb_pagina rb_pagina
rb_total rb_total
cb_cambiar_nombre cb_cambiar_nombre
dw_datos_certificado dw_datos_certificado
gb_1 gb_1
end type
global w_opciones_imprimir_2013 w_opciones_imprimir_2013

type variables
str_revision_estudios istr_rev_est
end variables

forward prototypes
public function integer wf_imprime_cert_lic (long al_cuenta, long al_cve_carrera, long al_cve_plan, boolean ab_legalizado)
public function string alinea (ref string linea, integer tamanio)
protected function integer wf_imprime_certificado (long al_cuenta, long al_cve_carrera, long al_cve_plan, boolean ab_legalizado, string as_nivel)
end prototypes

public function integer wf_imprime_cert_lic (long al_cuenta, long al_cve_carrera, long al_cve_plan, boolean ab_legalizado);//wf_imprime_cert_lic
//Recibe: al_cuenta				long
//				al_cve_carrera		long
//				al_cve_plan			long
//				ab_legalizado		boolean

uo_reporte_dw luo_reporte_dw
uds_datastore lds_certificado, lds_certificado_n
long ll_rows
Decimal ldc_creditos_cursados
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

if w_revision_estudios.gb_revalidacion.visible = true then
	LineaR1 = "MATERIAS EQUIVALENTES SEGUN "
	if w_revision_estudios.rb_oficio.checked = true then
		LineaR1 += "OFICIO No. "
	elseif w_revision_estudios.rb_folio.checked = true then
		LineaR1 += "FOLIO No. "
	else
		LineaR1 += "EXPEDIENTE No. "
	end if
	LineaR1 += w_revision_estudios.em_numero.text
	LineaR2 = "DE FECHA "+  mid(w_revision_estudios.em_fecha.text,1,2)+" DE "+&
					 DameMes(integer(mid(w_revision_estudios.em_fecha.text,4,2)))+" DE " +mid(w_revision_estudios.em_fecha.text,7,4) 
	ls_array_inicio[1]= LineaR1
	ls_array_inicio[2]= LineaR2	
end if




ls_carrera_sin_prefijo = f_obten_carrera_sin_prefijo(al_cve_carrera)
ls_grado_carrera = f_obten_grado_carrera(al_cve_carrera)
ls_grado_con_articulo = f_obten_grado_con_articulo(ls_grado_carrera)


SetPointer(HourGlass!)
w_revision_estudios.dw_prueba.SetSort("tipo A,periodonum A,sigla A")
w_revision_estudios.dw_prueba.Sort()

//Certificado TOTAL
ls_carrera = mid(w_revision_estudios.st_carrera.text,17)
ldc_creditos_cursados = w_revision_estudios.dw_revision_est_fmc.getitemdecimal(1,"cursadost")
ls_anio_plan= mid(w_revision_estudios.st_nivel.text,1,9)
ls_nivel= mid(w_revision_estudios.st_nivel.text,11)
if w_revision_estudios.dw_revision_est_fmc.getitemstring(1,"completo") = "si" then
	ls_final_reporte[1]="NOTA: Cubre íntegramente las materias y el mínimo de créditos para optar por el TITULO"
	ls_final_reporte[2]="DE LICENCIADO EN " + f_elimina_acentos(ls_carrera)
	ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
else
//Certificado PARCIAL
	ls_final_reporte[1]="NOTA: El presente certificado parcial ampara "+string(ldc_creditos_cursados)+" créditos correspondientes al Plan de"
	ls_final_reporte[2]="Estudios "+ls_anio_plan+" de la "+f_elimina_acentos(ls_nivel)+" en "+f_elimina_acentos(ls_carrera )
	ls_final_reporte[3]="---------------------------------------------------------------------------------------------"

end if

//Si es plan 2003
if al_cve_plan= 3 then
	li_cve_tipo_documento=3
else
	li_cve_tipo_documento=1
end if


if luo_reporte_dw.f_genera_cuerpo(li_cve_tipo_documento,w_revision_estudios.dw_prueba, al_cuenta,false,ls_final_reporte,true, ls_array_inicio ) <> -1 then
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

public function string alinea (ref string linea, integer tamanio);int li_Tam, li_i, li_j
li_i = 1
li_j = 1
string ls_LineaReg = "     "

li_Tam = len (Linea)
if li_Tam <= Tamanio then
	return ""
else
	if trim(Mid(Linea,Tamanio+1)) = "" then
	//if Mid(Linea,Tamanio+1,1) = " " then
		Linea = Left(linea, Tamanio)
		return ls_LineaReg + Mid(Linea, Tamanio+2)
	else
		do while li_j < tamanio
			li_i = li_j
			li_j = Pos(Linea," ",li_i + 1)
			if li_j = 0 then li_j = tamanio + 1
		loop
		ls_LineaReg += Mid(Linea, li_i + 1)
		Linea = Left(linea,li_i - 1)
		return ls_LineaReg
	end if
end if
end function

protected function integer wf_imprime_certificado (long al_cuenta, long al_cve_carrera, long al_cve_plan, boolean ab_legalizado, string as_nivel);//wf_imprime_certificado
//Recibe: al_cuenta				long
//				al_cve_carrera		long
//				al_cve_plan			long
//				ab_legalizado		boolean
//				as_nivel				string

uo_reporte_dw luo_reporte_dw
uds_datastore lds_certificado, lds_certificado_n
long ll_rows, ll_ultima_posicion
Decimal ldc_creditos_cursados
integer li_res_print, li_cve_tipo_documento
string ls_final_reporte[], ls_carrera, ls_anio_plan, ls_nivel, ls_cadena_buscada = space(1)
string ls_carrera_sin_prefijo, ls_grado_carrera, ls_grado_con_articulo
string ls_array_inicio[], LineaR1, LineaR2, ls_final_carrera01, ls_final_carrera02,ls_vigencia,ls_desc_nivel
boolean lb_imprime_lineas_vacias

luo_reporte_dw = CREATE uo_reporte_dw
lds_certificado = CREATE uds_datastore
lds_certificado_n = CREATE uds_datastore


//if as_nivel = "L" then
if as_nivel <> "P" then 
	if ab_legalizado then
		lds_certificado.dataobject = "d_certificados_lic_legal"
		lds_certificado_n.dataobject = "d_certificados_lic_legal_n"	
	else
		lds_certificado.dataobject = "d_certificados_lic_simples"
		lds_certificado_n.dataobject = "d_certificados_lic_simples_n"
	end if
elseif as_nivel = "P" then
	if ab_legalizado then
		lds_certificado.dataobject = "d_certificados_pos_legal"
		lds_certificado_n.dataobject = "d_certificados_pos_legal_n"	
	else
		lds_certificado.dataobject = "d_certificados_pos_simples"
		lds_certificado_n.dataobject = "d_certificados_pos_simples_n"
	end if
end if

if istr_rev_est.ab_bolean = true then
	LineaR1 = "MATERIAS EQUIVALENTES SEGUN "
	if istr_rev_est.an_oficio = 1 then
		LineaR1 += "OFICIO No. "
	elseif istr_rev_est.an_folio = 1 then
		LineaR1 += "FOLIO No. "
	elseif istr_rev_est.an_expediente = 1 then
		LineaR1 += "EXPEDIENTE No. "
	end if
	LineaR1 += istr_rev_est.as_numero
	
	LineaR2 = "     DE FECHA "+  mid(istr_rev_est.as_fecha,1,2)+" DE "+&
				 DameMes(integer(mid(istr_rev_est.as_fecha,4,2)))+" DE " +mid(istr_rev_est.as_fecha,7,4) 	

	ls_array_inicio[1]= LineaR1
	ls_array_inicio[2]= LineaR2	
end if



ls_carrera_sin_prefijo = f_obten_carrera_sin_prefijo(al_cve_carrera)
ls_grado_carrera = f_obten_grado_carrera(al_cve_carrera)
ls_grado_con_articulo = f_obten_grado_con_articulo(ls_grado_carrera)

SELECT upper(nivel.desc_corta  )
    INTO :ls_desc_nivel 
FROM nivel  
WHERE nivel.cve_nivel = :as_nivel  using gtr_sce ;

SELECT vigencia
into :ls_vigencia
FROM plan_estudios
	WHERE cve_plan = :al_cve_plan AND cve_carrera = :al_cve_carrera  using gtr_sce ;

SetPointer(HourGlass!)
istr_rev_est.adw_prueba.SetSort("tipo A,periodonum A,sigla A")
istr_rev_est.adw_prueba.Sort()

ls_carrera = istr_rev_est.as_carrera
ldc_creditos_cursados = istr_rev_est.adw_revision.getitemdecimal(1,"cursadost")
if al_cve_plan<>6 then
	ls_anio_plan= ls_vigencia
else 
	ls_anio_plan = "2004"
end if

ls_nivel= ls_desc_nivel

//if as_nivel = "L" then
if as_nivel <> "P" then 
	//Certificado TOTAL
	if istr_rev_est.adw_revision.getitemstring(1,"completo") = "si" then
		ls_final_reporte[1]="NOTA: Cubre íntegramente las materias y el mínimo de créditos para optar por el TITULO"
		ls_final_reporte[2]="DE LICENCIADO EN " + f_elimina_acentos(ls_carrera)
		ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
	else
	//Certificado PARCIAL
		ls_final_reporte[1]="NOTA: El presente certificado parcial ampara "+string(ldc_creditos_cursados)+" créditos correspondientes al Plan de"
		ls_final_reporte[2]="Estudios "+ls_anio_plan+" de "+f_elimina_acentos(ls_grado_con_articulo)+" en "+f_elimina_acentos(ls_carrera )
		ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
	end if
elseif as_nivel = "P" then
	//Certificado TOTAL
	ls_final_carrera01 = ""
	if istr_rev_est.adw_revision.getitemstring(1,"completo") = "si" then
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
		ls_final_reporte[1]="NOTA: El presente certificado parcial ampara "+string(ldc_creditos_cursados)+" créditos correspondientes al Plan de"
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
	lb_imprime_lineas_vacias = false
	int li_lineas_vacias = 5
	int li_i
	if istr_rev_est.an_regular = 1 then
		lb_imprime_lineas_vacias = true
		if ls_final_carrera01 = "" then li_lineas_vacias = 4
		for li_i = 0 to 4 
			ls_final_reporte[li_lineas_vacias + li_i] = "."
		next
		ls_final_reporte[li_lineas_vacias + 5] = "          *  EL  PRESENTE  CERTIFICADO  SE EXPIDE  EN  CUMPLIMIENTO A LA RESOLUCION"
		ls_final_reporte[li_lineas_vacias + 6] = "             ADMINISTRATIVA  NÚMERO 219/2004/2223 DE FECHA 1 DE SEPTIEMBRE DE 2004."
		ls_final_reporte[li_lineas_vacias + 7] = "."
		ls_final_reporte[li_lineas_vacias + 8] = "        R.G. REGULARIZACIÓN  GLOBAL  DERIVADA  DE  LA  SOLICITUD PRESENTADA ANTE LA"
		ls_final_reporte[li_lineas_vacias + 9] = "             UNIDAD ADMINISTRATIVA, MISMA QUE FUE RESUELTA CON OFICIO 219/2004/2223"
		ls_final_reporte[li_lineas_vacias + 10] = "             DE FECHA 1 DE SEPTIEMBRE DE 2004."
	end if
end if


//Si es alumno de licenciatura
//if as_nivel = "L" then
if as_nivel <> "P" then 
	//Si es plan 2004
	if al_cve_plan= 6 then
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
	if al_cve_plan= 6 then
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


if luo_reporte_dw.f_genera_cuerpo(li_cve_tipo_documento,istr_rev_est.adw_prueba, al_cuenta,lb_imprime_lineas_vacias,ls_final_reporte,true, ls_array_inicio ) <> -1 then
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

event open;//g_nv_security.fnv_secure_window (this)
dw_datos_certificado.retrieve()
/**/gnv_app.inv_security.of_SetSecurity(this)
istr_rev_est = message.PowerObjectParm	
end event

on w_opciones_imprimir_2013.create
this.em_pagnum=create em_pagnum
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.cb_configurar=create cb_configurar
this.rb_pagina=create rb_pagina
this.rb_total=create rb_total
this.cb_cambiar_nombre=create cb_cambiar_nombre
this.dw_datos_certificado=create dw_datos_certificado
this.gb_1=create gb_1
this.Control[]={this.em_pagnum,&
this.cb_cancel,&
this.cb_ok,&
this.cb_configurar,&
this.rb_pagina,&
this.rb_total,&
this.cb_cambiar_nombre,&
this.dw_datos_certificado,&
this.gb_1}
end on

on w_opciones_imprimir_2013.destroy
destroy(this.em_pagnum)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.cb_configurar)
destroy(this.rb_pagina)
destroy(this.rb_total)
destroy(this.cb_cambiar_nombre)
destroy(this.dw_datos_certificado)
destroy(this.gb_1)
end on

type em_pagnum from editmask within w_opciones_imprimir_2013
integer x = 544
integer y = 256
integer width = 96
integer height = 84
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
boolean enabled = false
string text = "1"
borderstyle borderstyle = stylelowered!
string mask = "#"
string displaydata = ""
end type

type cb_cancel from commandbutton within w_opciones_imprimir_2013
integer x = 718
integer y = 620
integer width = 389
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancelar"
end type

event clicked;close(parent)
end event

type cb_ok from commandbutton within w_opciones_imprimir_2013
integer x = 210
integer y = 620
integer width = 389
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
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
string ls_director,ls_desc_nivel,ls_vigencia
string ls_nivel, ls_carrera_posgrado, ls_subnombre_especialidad, ls_desc_grado 
int li_ind_maestria, li_ind_especialidad, li_ind_doctorado
boolean NoImprime = false
boolean es_especialidad= false, lb_legalizado
parent.enabled = false
long ll_cuenta, ll_cve_carrera, ll_cve_plan

//Si el certificado lleva holograma

ll_cuenta = long(istr_rev_est.an_cuenta)
ll_cve_carrera = istr_rev_est.an_cve_carrera
ll_cve_plan = istr_rev_est.an_cve_plan
lb_legalizado = istr_rev_est.ab_legal
ls_nivel = istr_rev_est.as_nivel

SELECT upper(nivel.desc_corta  )
    INTO :ls_desc_nivel 
FROM nivel  
WHERE nivel.cve_nivel = :ls_nivel  using gtr_sce ;

SELECT vigencia
into :ls_vigencia
FROM plan_estudios
	WHERE cve_plan = :ll_cve_plan AND cve_carrera = :ll_cve_carrera  using gtr_sce ;

// Se recupera la descripción del grado para el alumno.
SELECT grado.descripcion 
INTO :ls_desc_grado  
FROM grado, carreras 
WHERE carreras.cve_carrera = :ll_cve_carrera 
AND carreras.cve_grado = grado.cve_grado
using gtr_sce ;



if wf_imprime_certificado(ll_cuenta, ll_cve_carrera, ll_cve_plan, lb_legalizado, ls_nivel)= 0 then
	Goto Certificados
else
	messagebox("Error","Error al imprimir el certificado")	
end if

if dw_datos_certificado.rowcount() = 1 then
	ls_director=dw_datos_certificado.getitemstring(1,"nombre")
else
	messagebox("Error","Error al obtener el nombre del director")
end if

select getdate() into :fecha from carreras using gtr_sce;

cue = ll_cuenta
carrera = f_elimina_acentos(istr_rev_est.as_carrera)

LineaR1 = "     MATERIAS EQUIVALENTES SEGUN "
if istr_rev_est.an_oficio = 1 then
	LineaR1 += "OFICIO No. "
elseif istr_rev_est.an_folio = 1 then
	LineaR1 += "FOLIO No. "
elseif istr_rev_est.an_expediente = 1 then
	LineaR1 += "EXPEDIENTE No. "
end if
LineaR1 += istr_rev_est.as_numero
LineaR2 = "     DE FECHA "+  mid(istr_rev_est.as_fecha,1,2)+" DE "+&
				 DameMes(integer(mid(istr_rev_est.as_fecha,4,2)))+" DE " +mid(istr_rev_est.as_fecha,7,4) 
				 
if istr_rev_est.adw_revision.getitemstring(1,"completo") = "si" then
	//if ls_nivel = "L" then
	if ls_nivel <> "P" then
		LineaC1 = "     NOTA: Cubre íntegramente las materias y el mínimo de créditos para optar por el TITULO"
		LineaC2 = "     DE " 
		LineaC2 += ls_desc_grado + " EN " + carrera 
		//LineaC2 += "LICENCIADO EN " + carrera 
	else		
		LineaC1 = "     NOTA: Cubre íntegramente las materias y el mínimo de créditos para optar por "
	
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
	end if
else
	LineaC1 = "     NOTA: El presente certificado parcial ampara "+&
						string(istr_rev_est.adw_revision.getitemnumber(1,"cursadost"))+" créditos correspondientes al Plan de"
	LineaC2 = "     Estudios "/*"al Plan de Estudios " */+ls_vigencia
//	if ls_nivel = "L" then
	if ls_nivel <> "P" then
		LineaC2 += " de la "+ls_desc_nivel+ " en "+carrera  //variable
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

		LineaC2 += ls_carrera_posgrado

	end if
end if
	LineaC2 += " "
	LineaC3 = Alinea(LineaC2,93)
	LineaC3 = RightTrim(LineaC3)
if not es_especialidad then					
	LineaCarrera1 = "                     "+carrera
else
	LineaCarrera1 = "                     "+"ESPECIALIDAD EN "+	ls_subnombre_especialidad
end if
LineaCarrera2 = "            "+Alinea(LineaCarrera1,73)


numero=PrintOpen()
PrintSetSpacing(numero,1.09)
PrintDefineFont(numero, 2, "Courier New",  &
	-10, 400, Default!, Roman!, FALSE, FALSE)
PrintDefineFont(numero, 3, "Arial",  &
	-6, 400, Default!, Modern!, FALSE, FALSE)

istr_rev_est.adw_prueba.SetFilter("tipo = 1"); istr_rev_est.adw_prueba.Filter(); oblig = istr_rev_est.adw_prueba.RowCount()
istr_rev_est.adw_prueba.SetFilter("tipo = 2"); istr_rev_est.adw_prueba.Filter(); opta = istr_rev_est.adw_prueba.RowCount()
istr_rev_est.adw_prueba.SetFilter("tipo = 3"); istr_rev_est.adw_prueba.Filter(); forma = istr_rev_est.adw_prueba.RowCount()
istr_rev_est.adw_prueba.SetFilter(""); istr_rev_est.adw_prueba.Filter();total = istr_rev_est.adw_prueba.RowCount()
total --;

if w_revision_estudios.gb_revalidacion.visible = true then
	tot = total
	total = 10000
end if
	
renglon = 2
istr_rev_est.adw_prueba.SetSort("tipo A,periodonum A,sigla A")
istr_rev_est.adw_prueba.Sort()
PrintSetFont(numero,2)
//if ((w_revision_estudios.cbx_legal.checked) AND&
//	((rb_total.checked = true) OR (integer(em_pagnum.text) = 1))) then
//		PrintBitmap(numero, "SepCompleto.bmp",1900,3700, 0,0)
//end if
tipoant = 0	
if lb_legalizado then 
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
		   Linea = "        " + string(ll_cuenta) +&
														istr_rev_est.as_digito
	CASE 2 TO 8
			Linea = ""
	CASE 9
		   PrintSetFont(numero,2)
			if not lb_legalizado then 
			//SIMPLE	
			 Linea = "                  "    +istr_rev_est.as_nombre+&
													 " "+istr_rev_est.as_apaterno+&
													 " "+istr_rev_est.as_amaterno
			else
				Linea = ""
			end if
	CASE 10 TO 11
			Linea = ""
	CASE 12
		if  lb_legalizado and pagnum > 1 then 			
			 Linea = "                  "    +istr_rev_est.as_nombre+&
													 " "+istr_rev_est.as_apaterno+&
													 " "+istr_rev_est.as_amaterno
			else
				//SIMPLE
				Linea = ""
			end if
	CASE 13
			Linea = ""
	CASE 14
		if not lb_legalizado then 
		//SIMPLE	
			Linea = LineaCarrera1
		else
			Linea = ""
		end if
	CASE 15
		if not lb_legalizado then 
		//SIMPLE
			Linea = LineaCarrera2
		else
			if lb_legalizado and pagnum > 1 then
				Linea = LineaCarrera1
			else
			//SIMPLE
				Linea = ""
			end if
		end if
	CASE 16
		if lb_legalizado and pagnum > 1 then
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
				  lb_legalizado ) OR (total = 0)) then
					choose case contador1
						case 29
							Linea = "                  "    +istr_rev_est.as_nombre+&
									" "+istr_rev_est.as_apaterno+&
									" "+istr_rev_est.as_amaterno
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
						tipo = istr_rev_est.adw_prueba.GetItemNumber(renglon,"tipo")
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
							//if lb_legalizado and ls_nivel = "L" then Linea += " "
							if lb_legalizado and ls_nivel <> "P" then Linea += " "
							if IsNull(istr_rev_est.adw_prueba.GetItemString(renglon,3)) then
								Linea += "       "
							else
								Linea += space(7 - len(istr_rev_est.adw_prueba.GetItemString(renglon,3)))+istr_rev_est.adw_prueba.GetItemString(renglon,3)
							end if
							if lb_legalizado then
								Linea += " "+mid( istr_rev_est.adw_prueba.GetItemString(renglon,4),1,47)+space(49 - len(istr_rev_est.adw_prueba.GetItemString(renglon,4)))+&
								istr_rev_est.adw_prueba.GetItemString(renglon,5)+Space(5 - len(istr_rev_est.adw_prueba.GetItemString(renglon,5)))+&
								space(2 - len(string(istr_rev_est.adw_prueba.GetItemNumber(renglon,6))))+string(istr_rev_est.adw_prueba.GetItemNumber(renglon,6))+"   "+&
								space(2 - len(istr_rev_est.adw_prueba.GetItemString(renglon,7)))+istr_rev_est.adw_prueba.GetItemString(renglon,7)+"   "+&
								istr_rev_est.adw_prueba.GetItemString(renglon,8)+space(12 - len(istr_rev_est.adw_prueba.GetItemString(renglon,8)))+&
								istr_rev_est.adw_prueba.GetItemString(renglon,9)

							else
							//SIMPLE
								//if ls_nivel = "L" then
								if ls_nivel <> "P" then 
									Linea += "  "+istr_rev_est.adw_prueba.GetItemString(renglon,4)+space(50 - len(istr_rev_est.adw_prueba.GetItemString(renglon,4)))+&
									istr_rev_est.adw_prueba.GetItemString(renglon,5)+Space(4 - len(istr_rev_est.adw_prueba.GetItemString(renglon,5)))+&
									space(2 - len(string(istr_rev_est.adw_prueba.GetItemNumber(renglon,6))))+string(istr_rev_est.adw_prueba.GetItemNumber(renglon,6))+"   "+&
									space(2 - len(istr_rev_est.adw_prueba.GetItemString(renglon,7)))+istr_rev_est.adw_prueba.GetItemString(renglon,7)+"  "+&
									istr_rev_est.adw_prueba.GetItemString(renglon,8)+space(13 - len(istr_rev_est.adw_prueba.GetItemString(renglon,8)))+&
									istr_rev_est.adw_prueba.GetItemString(renglon,9)
								else
									Linea += " "+istr_rev_est.adw_prueba.GetItemString(renglon,4)+space(50 - len(istr_rev_est.adw_prueba.GetItemString(renglon,4)))+&
									istr_rev_est.adw_prueba.GetItemString(renglon,5)+Space(4 - len(istr_rev_est.adw_prueba.GetItemString(renglon,5)))+&
									space(2 - len(string(istr_rev_est.adw_prueba.GetItemNumber(renglon,6))))+string(istr_rev_est.adw_prueba.GetItemNumber(renglon,6))+"   "+&
									space(2 - len(istr_rev_est.adw_prueba.GetItemString(renglon,7)))+istr_rev_est.adw_prueba.GetItemString(renglon,7)+"   "+&
									istr_rev_est.adw_prueba.GetItemString(renglon,8)+space(13 - len(istr_rev_est.adw_prueba.GetItemString(renglon,8)))+&
									istr_rev_est.adw_prueba.GetItemString(renglon,9)
						
								end if
							end if
							//if (not lb_legalizado and ls_nivel <> "L") then Linea = "  "+Linea
							if (not lb_legalizado and ls_nivel = "P") then Linea = "  "+Linea 
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
		if lb_legalizado then
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
		if not lb_legalizado then
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
		if lb_legalizado then
			Linea = "                                                                "+ls_director
		else
		//SIMPLE
			Linea = ""
		end if
//	CASE pag - 1 
//			Linea = ""
	CASE pag
			PrintSetFont(numero,2)
			if lb_legalizado then
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
end event

type cb_configurar from commandbutton within w_opciones_imprimir_2013
integer x = 768
integer y = 60
integer width = 599
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Configurar Impresora"
end type

event clicked;printsetup()
end event

type rb_pagina from radiobutton within w_opciones_imprimir_2013
integer x = 87
integer y = 256
integer width = 389
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Una Página"
end type

event clicked;em_pagnum.enabled = true
end event

type rb_total from radiobutton within w_opciones_imprimir_2013
integer x = 87
integer y = 156
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Total"
boolean checked = true
end type

event clicked;em_pagnum.enabled = false
end event

type cb_cambiar_nombre from commandbutton within w_opciones_imprimir_2013
integer x = 768
integer y = 188
integer width = 599
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
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

type dw_datos_certificado from datawindow within w_opciones_imprimir_2013
integer x = 37
integer y = 440
integer width = 1358
integer height = 100
integer taborder = 50
boolean enabled = false
string dataobject = "d_datos_certificado_2013"
boolean border = false
boolean livescroll = true
end type

event constructor;SetTrans(gtr_sce)
end event

type gb_1 from groupbox within w_opciones_imprimir_2013
integer x = 37
integer y = 28
integer width = 667
integer height = 380
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Impresión"
end type

