$PBExportHeader$w_opciones_imprimir.srw
forward
global type w_opciones_imprimir from window
end type
type cb_pos_simples from commandbutton within w_opciones_imprimir
end type
type cb_lic_simples from commandbutton within w_opciones_imprimir
end type
type em_pagnum from editmask within w_opciones_imprimir
end type
type cb_cancel from commandbutton within w_opciones_imprimir
end type
type cb_ok from commandbutton within w_opciones_imprimir
end type
type cb_configurar from commandbutton within w_opciones_imprimir
end type
type rb_pagina from radiobutton within w_opciones_imprimir
end type
type rb_total from radiobutton within w_opciones_imprimir
end type
type cb_cambiar_nombre from commandbutton within w_opciones_imprimir
end type
type dw_datos_certificado from datawindow within w_opciones_imprimir
end type
type gb_1 from groupbox within w_opciones_imprimir
end type
end forward

global type w_opciones_imprimir from window
integer x = 832
integer y = 364
integer width = 1477
integer height = 860
boolean titlebar = true
string title = "Opciones de Impresion"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 10789024
cb_pos_simples cb_pos_simples
cb_lic_simples cb_lic_simples
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
global w_opciones_imprimir w_opciones_imprimir

type variables

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
long ll_rows
decimal ldc_creditos_cursados
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

public function integer wf_imprime_certificado (long al_cuenta, long al_cve_carrera, long al_cve_plan, boolean ab_legalizado, string as_nivel);//wf_imprime_certificado
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
string ls_array_inicio[], LineaR1, LineaR2, ls_final_carrera01, ls_final_carrera02
boolean lb_imprime_lineas_vacias

luo_reporte_dw = CREATE uo_reporte_dw
lds_certificado = CREATE uds_datastore
lds_certificado_n = CREATE uds_datastore


if as_nivel = "L" then
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

ls_carrera = mid(w_revision_estudios.st_carrera.text,17)
ldc_creditos_cursados = w_revision_estudios.dw_revision_est_fmc.getitemdecimal(1,"cursadost")
if al_cve_plan<>6 then
	ls_anio_plan= mid(w_revision_estudios.st_nivel.text,1,9)
else 
	ls_anio_plan = "2004"
end if

ls_nivel= mid(w_revision_estudios.st_nivel.text,11)

if as_nivel = "L" then
	//Certificado TOTAL
	if w_revision_estudios.dw_revision_est_fmc.getitemstring(1,"completo") = "si" then
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
	if w_revision_estudios.dw_revision_est_fmc.getitemstring(1,"completo") = "si" then
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
	if w_revision_estudios.st_regularizacion.visible = true then
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
if as_nivel = "L" then
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


if luo_reporte_dw.f_genera_cuerpo(li_cve_tipo_documento,w_revision_estudios.dw_prueba, al_cuenta,lb_imprime_lineas_vacias,ls_final_reporte,true, ls_array_inicio ) <> -1 then
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
end event

on w_opciones_imprimir.create
this.cb_pos_simples=create cb_pos_simples
this.cb_lic_simples=create cb_lic_simples
this.em_pagnum=create em_pagnum
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.cb_configurar=create cb_configurar
this.rb_pagina=create rb_pagina
this.rb_total=create rb_total
this.cb_cambiar_nombre=create cb_cambiar_nombre
this.dw_datos_certificado=create dw_datos_certificado
this.gb_1=create gb_1
this.Control[]={this.cb_pos_simples,&
this.cb_lic_simples,&
this.em_pagnum,&
this.cb_cancel,&
this.cb_ok,&
this.cb_configurar,&
this.rb_pagina,&
this.rb_total,&
this.cb_cambiar_nombre,&
this.dw_datos_certificado,&
this.gb_1}
end on

on w_opciones_imprimir.destroy
destroy(this.cb_pos_simples)
destroy(this.cb_lic_simples)
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

type cb_pos_simples from commandbutton within w_opciones_imprimir
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
long ll_cuenta, ll_rows, ll_cve_carrera, ll_cve_plan
Decimal ldc_creditos_cursados
integer li_res_print, li_cve_tipo_documento
string ls_final_reporte[], ls_carrera, ls_anio_plan, ls_nivel
string ls_grado_con_articulo, ls_carrera_sin_prefijo, ls_grado_carrera
string ls_array_inicio[], LineaR1, LineaR2

luo_reporte_dw = CREATE uo_reporte_dw
lds_certificado = CREATE uds_datastore
lds_certificado_n = CREATE uds_datastore
lds_certificado.dataobject = "d_certificados_pos_simples"
lds_certificado_n.dataobject = "d_certificados_pos_simples_n"

ll_cuenta = long(w_revision_estudios.uo_1.em_cuenta.text)
ll_cve_carrera = w_revision_estudios.il_cve_carrera
ll_cve_plan = w_revision_estudios.il_cve_plan

ls_carrera_sin_prefijo = f_obten_carrera_sin_prefijo(ll_cve_carrera)
ls_grado_carrera = f_obten_grado_carrera(ll_cve_carrera)
ls_grado_con_articulo = f_obten_grado_con_articulo(ls_grado_carrera)


SetPointer(HourGlass!)
w_revision_estudios.dw_prueba.SetSort("tipo A,periodonum A,sigla A")
w_revision_estudios.dw_prueba.Sort()

//Certificado TOTAL
ls_carrera = mid(w_revision_estudios.st_carrera.text,17)
ldc_creditos_cursados =  w_revision_estudios.dw_revision_est_fmc.getitemdecimal(1,"cursadost")
ls_anio_plan= mid(w_revision_estudios.st_nivel.text,1,9)
ls_nivel= mid(w_revision_estudios.st_nivel.text,11)
if w_revision_estudios.dw_revision_est_fmc.getitemstring(1,"completo") = "si" then
	ls_final_reporte[1]="NOTA: Cubre íntegramente las materias y el mínimo de créditos para optar por"
	ls_final_reporte[2]=upper(f_elimina_acentos(ls_grado_con_articulo))+" EN " + f_elimina_acentos(ls_carrera_sin_prefijo)
	ls_final_reporte[3]="---------------------------------------------------------------------------------------------"
else
//Certificado PARCIAL
	ls_final_reporte[1]="NOTA: El presente certificado parcial ampara "+string(ldc_creditos_cursados)+" créditos correspondientes al Plan de"
	ls_final_reporte[2]="Estudios "+ls_anio_plan+" de "+f_elimina_acentos(ls_grado_con_articulo)+" EN "+f_elimina_acentos(ls_carrera_sin_prefijo)
	ls_final_reporte[3]="---------------------------------------------------------------------------------------------"

end if

if ll_cve_plan= 3 then
	li_cve_tipo_documento=4
else
	li_cve_tipo_documento=2
end if

if luo_reporte_dw.f_genera_cuerpo(li_cve_tipo_documento,w_revision_estudios.dw_prueba, ll_cuenta,false,ls_final_reporte,true, ls_array_inicio ) <> -1 then
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

type cb_lic_simples from commandbutton within w_opciones_imprimir
boolean visible = false
integer x = 1143
integer y = 556
integer width = 315
integer height = 108
integer taborder = 50
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
long ll_cuenta, ll_rows, ll_cve_carrera, ll_cve_plan
Decimal ldc_creditos_cursados
integer li_res_print, li_cve_tipo_documento
string ls_final_reporte[], ls_carrera, ls_anio_plan, ls_nivel
string ls_carrera_sin_prefijo, ls_grado_carrera, ls_grado_con_articulo
string ls_array_inicio[], LineaR1, LineaR2

luo_reporte_dw = CREATE uo_reporte_dw
lds_certificado = CREATE uds_datastore
lds_certificado_n = CREATE uds_datastore
lds_certificado.dataobject = "d_certificados_lic_simples"
lds_certificado_n.dataobject = "d_certificados_lic_simples_n"


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


ll_cuenta = long(w_revision_estudios.uo_1.em_cuenta.text)
ll_cve_carrera = w_revision_estudios.il_cve_carrera
ll_cve_plan = w_revision_estudios.il_cve_plan

ls_carrera_sin_prefijo = f_obten_carrera_sin_prefijo(ll_cve_carrera)
ls_grado_carrera = f_obten_grado_carrera(ll_cve_carrera)
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

if ll_cve_plan= 3 then
	li_cve_tipo_documento=3
else
	li_cve_tipo_documento=1
end if


if luo_reporte_dw.f_genera_cuerpo(li_cve_tipo_documento,w_revision_estudios.dw_prueba, ll_cuenta,false,ls_final_reporte,true , ls_array_inicio) <> -1 then
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

type em_pagnum from editmask within w_opciones_imprimir
integer x = 544
integer y = 256
integer width = 96
integer height = 84
integer taborder = 70
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

type cb_cancel from commandbutton within w_opciones_imprimir
integer x = 718
integer y = 620
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

type cb_ok from commandbutton within w_opciones_imprimir
integer x = 210
integer y = 620
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
long ll_cuenta, ll_cve_carrera, ll_cve_plan

//Si el certificado lleva holograma

ll_cuenta = long(w_revision_estudios.uo_1.em_cuenta.text)
ll_cve_carrera = w_revision_estudios.il_cve_carrera
ll_cve_plan = w_revision_estudios.il_cve_plan
lb_legalizado = w_revision_estudios.ib_legalizado
ls_nivel = w_revision_estudios.is_nivel 

if wf_imprime_certificado(ll_cuenta, ll_cve_carrera, ll_cve_plan, lb_legalizado, ls_nivel)= 0 then
	Goto Certificados
else
	messagebox("Error","Error al imprimir el certificado")	
end if
			 
//if mid(w_revision_estudios.st_nivel.text,11) = "LICENCIATURA" and &
//		(w_revision_estudios.cbx_legal.checked= false) then 
//	cb_lic_simples.event clicked()
//	Goto Simples
//end if
//
//if (w_revision_estudios.is_nivel) = "P" and &
//		(w_revision_estudios.cbx_legal.checked= false) then 
//	cb_pos_simples.event clicked()
//	Goto Simples
//end if


if dw_datos_certificado.rowcount() = 1 then
	ls_director=dw_datos_certificado.getitemstring(1,"nombre")
else
	messagebox("Error","Error al obtener el nombre del director")
end if

//-* Solo para ver el resultado intermedio 
//w_revision_estudios.dw_prueba.print()

select getdate() into :fecha from carreras using gtr_sce;

cue = long(w_revision_estudios.uo_1.em_cuenta.text)
carrera = f_elimina_acentos(mid(w_revision_estudios.st_carrera.text,17))

LineaR1 = "     MATERIAS EQUIVALENTES SEGUN "
if w_revision_estudios.rb_oficio.checked = true then
	LineaR1 += "OFICIO No. "
elseif w_revision_estudios.rb_folio.checked = true then
	LineaR1 += "FOLIO No. "
else
	LineaR1 += "EXPEDIENTE No. "
end if
LineaR1 += w_revision_estudios.em_numero.text
LineaR2 = "     DE FECHA "+  mid(w_revision_estudios.em_fecha.text,1,2)+" DE "+&
				 DameMes(integer(mid(w_revision_estudios.em_fecha.text,4,2)))+" DE " +mid(w_revision_estudios.em_fecha.text,7,4) 
				 
if mid(w_revision_estudios.st_nivel.text,11) = "LICENCIATURA" then ls_nivel = "L"	


if w_revision_estudios.dw_revision_est_fmc.getitemstring(1,"completo") = "si" then
//-	LineaC1 = "     NOTA: Cubre íntegramente las materias y el mínimo de créditos para optar por el TITULO"
	//LineaC2 = "     por el TITULO DE " //variable
//-	  LineaC2 = "     DE "


	if ls_nivel = "L" then
		LineaC1 = "     NOTA: Cubre íntegramente las materias y el mínimo de créditos para optar por el TITULO"
		//LineaC2 = "     por el TITULO DE " //variable
		LineaC2 = "     DE "
		LineaC2 += "LICENCIADO EN " + carrera
	else		
		
		
		LineaC1 = "     NOTA: Cubre íntegramente las materias y el mínimo de créditos para optar por "
//-		LineaC2 = "     DE "
//-		LineaC2 += mid(w_revision_estudios.st_nivel.text,11) + " EN " +carrera
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
						string(w_revision_estudios.dw_revision_est_fmc.getitemnumber(1,"cursadost"))+" créditos correspondientes al Plan de"
	LineaC2 = "     Estudios "/*"al Plan de Estudios " */+mid(w_revision_estudios.st_nivel.text,1,9)
	if ls_nivel = "L" then
		LineaC2 += " de la "+mid(w_revision_estudios.st_nivel.text,11)+ " en "+carrera  //variable
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

//-		LineaC2 += " del "+mid(w_revision_estudios.st_nivel.text,11)+ " en "+carrera  //variable
		LineaC2 += ls_carrera_posgrado

	end if
end if
	LineaC2 += " "
	LineaC3 = w_revision_estudios.Alinea(LineaC2,93)
	LineaC3 = RightTrim(LineaC3)
if not es_especialidad then					
	LineaCarrera1 = "                     "+carrera
else
	LineaCarrera1 = "                     "+"ESPECIALIDAD EN "+	ls_subnombre_especialidad
end if
LineaCarrera2 = "            "+w_revision_estudios.Alinea(LineaCarrera1,73)


numero=PrintOpen()
PrintSetSpacing(numero,1.09)
PrintDefineFont(numero, 2, "Courier New",  &
	-10, 400, Default!, Roman!, FALSE, FALSE)
PrintDefineFont(numero, 3, "Arial",  &
	-6, 400, Default!, Modern!, FALSE, FALSE)

w_revision_estudios.dw_prueba.SetFilter("tipo = 1"); w_revision_estudios.dw_prueba.Filter(); oblig = w_revision_estudios.dw_prueba.RowCount()
w_revision_estudios.dw_prueba.SetFilter("tipo = 2"); w_revision_estudios.dw_prueba.Filter(); opta = w_revision_estudios.dw_prueba.RowCount()
w_revision_estudios.dw_prueba.SetFilter("tipo = 3"); w_revision_estudios.dw_prueba.Filter(); forma = w_revision_estudios.dw_prueba.RowCount()
w_revision_estudios.dw_prueba.SetFilter(""); w_revision_estudios.dw_prueba.Filter();total = w_revision_estudios.dw_prueba.RowCount()
total --;

if w_revision_estudios.gb_revalidacion.visible = true then
	tot = total
	total = 10000
end if
	
renglon = 2
w_revision_estudios.dw_prueba.SetSort("tipo A,periodonum A,sigla A")
w_revision_estudios.dw_prueba.Sort()
PrintSetFont(numero,2)
//if ((w_revision_estudios.cbx_legal.checked) AND&
//	((rb_total.checked = true) OR (integer(em_pagnum.text) = 1))) then
//		PrintBitmap(numero, "SepCompleto.bmp",1900,3700, 0,0)
//end if
tipoant = 0	
if (w_revision_estudios.cbx_legal.checked) then 
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
		   Linea = "        " + w_revision_estudios.uo_1.em_cuenta.text+&
														w_revision_estudios.uo_1.em_digito.text
	CASE 2 TO 8
			Linea = ""
	CASE 9
		   PrintSetFont(numero,2)
			if not (w_revision_estudios.cbx_legal.checked) then 
			//SIMPLE	
			 Linea = "                  "    +w_revision_estudios.uo_1.dw_nombre_alumno.object.nombre[1]+&
													 " "+w_revision_estudios.uo_1.dw_nombre_alumno.object.apaterno[1]+&
													 " "+w_revision_estudios.uo_1.dw_nombre_alumno.object.amaterno[1]
			else
				Linea = ""
			end if
	CASE 10 TO 11
			Linea = ""
	CASE 12
		if  (w_revision_estudios.cbx_legal.checked) and pagnum > 1 then 			
			 Linea = "                  "    +w_revision_estudios.uo_1.dw_nombre_alumno.object.nombre[1]+&
													 " "+w_revision_estudios.uo_1.dw_nombre_alumno.object.apaterno[1]+&
													 " "+w_revision_estudios.uo_1.dw_nombre_alumno.object.amaterno[1]
			else
				//SIMPLE
				Linea = ""
			end if
	CASE 13
			Linea = ""
	CASE 14
		if not (w_revision_estudios.cbx_legal.checked) then 
		//SIMPLE	
			Linea = LineaCarrera1
		else
			Linea = ""
		end if
	CASE 15
		if not (w_revision_estudios.cbx_legal.checked) then 
		//SIMPLE
			Linea = LineaCarrera2
		else
			if (w_revision_estudios.cbx_legal.checked) and pagnum > 1 then
				Linea = LineaCarrera1
			else
			//SIMPLE
				Linea = ""
			end if
		end if
	CASE 16
		if (w_revision_estudios.cbx_legal.checked) and pagnum > 1 then
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
				   (w_revision_estudios.cbx_legal.checked)) OR (total = 0)) then
					choose case contador1
						case 29
							Linea = "                  "    +w_revision_estudios.uo_1.dw_nombre_alumno.object.nombre[1]+&
									" "+w_revision_estudios.uo_1.dw_nombre_alumno.object.apaterno[1]+&
									" "+w_revision_estudios.uo_1.dw_nombre_alumno.object.amaterno[1]
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
						tipo = w_revision_estudios.dw_prueba.GetItemNumber(renglon,"tipo")
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
							if (w_revision_estudios.cbx_legal.checked) and ls_nivel = "L" then Linea += " "
							if IsNull(w_revision_estudios.dw_prueba.GetItemString(renglon,3)) then
								Linea += "       "
							else
								Linea += space(7 - len(w_revision_estudios.dw_prueba.GetItemString(renglon,3)))+w_revision_estudios.dw_prueba.GetItemString(renglon,3)
							end if
							if (w_revision_estudios.cbx_legal.checked) then
								Linea += " "+mid( w_revision_estudios.dw_prueba.GetItemString(renglon,4),1,47)+space(49 - len(w_revision_estudios.dw_prueba.GetItemString(renglon,4)))+&
								w_revision_estudios.dw_prueba.GetItemString(renglon,5)+Space(5 - len(w_revision_estudios.dw_prueba.GetItemString(renglon,5)))+&
								space(2 - len(string(w_revision_estudios.dw_prueba.GetItemNumber(renglon,6))))+string(w_revision_estudios.dw_prueba.GetItemNumber(renglon,6))+"   "+&
								space(2 - len(w_revision_estudios.dw_prueba.GetItemString(renglon,7)))+w_revision_estudios.dw_prueba.GetItemString(renglon,7)+"   "+&
								w_revision_estudios.dw_prueba.GetItemString(renglon,8)+space(12 - len(w_revision_estudios.dw_prueba.GetItemString(renglon,8)))+&
								w_revision_estudios.dw_prueba.GetItemString(renglon,9)

							else
							//SIMPLE
								if ls_nivel = "L" then
									Linea += "  "+w_revision_estudios.dw_prueba.GetItemString(renglon,4)+space(50 - len(w_revision_estudios.dw_prueba.GetItemString(renglon,4)))+&
									w_revision_estudios.dw_prueba.GetItemString(renglon,5)+Space(4 - len(w_revision_estudios.dw_prueba.GetItemString(renglon,5)))+&
									space(2 - len(string(w_revision_estudios.dw_prueba.GetItemNumber(renglon,6))))+string(w_revision_estudios.dw_prueba.GetItemNumber(renglon,6))+"   "+&
									space(2 - len(w_revision_estudios.dw_prueba.GetItemString(renglon,7)))+w_revision_estudios.dw_prueba.GetItemString(renglon,7)+"  "+&
									w_revision_estudios.dw_prueba.GetItemString(renglon,8)+space(13 - len(w_revision_estudios.dw_prueba.GetItemString(renglon,8)))+&
									w_revision_estudios.dw_prueba.GetItemString(renglon,9)
								else
									Linea += " "+w_revision_estudios.dw_prueba.GetItemString(renglon,4)+space(50 - len(w_revision_estudios.dw_prueba.GetItemString(renglon,4)))+&
									w_revision_estudios.dw_prueba.GetItemString(renglon,5)+Space(4 - len(w_revision_estudios.dw_prueba.GetItemString(renglon,5)))+&
									space(2 - len(string(w_revision_estudios.dw_prueba.GetItemNumber(renglon,6))))+string(w_revision_estudios.dw_prueba.GetItemNumber(renglon,6))+"   "+&
									space(2 - len(w_revision_estudios.dw_prueba.GetItemString(renglon,7)))+w_revision_estudios.dw_prueba.GetItemString(renglon,7)+"   "+&
									w_revision_estudios.dw_prueba.GetItemString(renglon,8)+space(13 - len(w_revision_estudios.dw_prueba.GetItemString(renglon,8)))+&
									w_revision_estudios.dw_prueba.GetItemString(renglon,9)
						
								end if
							end if
							if (not(w_revision_estudios.cbx_legal.checked) and ls_nivel <> "L") then Linea = "  "+Linea
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
		if w_revision_estudios.cbx_legal.checked then
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
		if not(w_revision_estudios.cbx_legal.checked) then
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
		if w_revision_estudios.cbx_legal.checked then
			Linea = "                                                                "+ls_director
		else
		//SIMPLE
			Linea = ""
		end if
//	CASE pag - 1 
//			Linea = ""
	CASE pag
			PrintSetFont(numero,2)
			if not(w_revision_estudios.cbx_legal.checked) then
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

type cb_configurar from commandbutton within w_opciones_imprimir
integer x = 768
integer y = 60
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

type rb_pagina from radiobutton within w_opciones_imprimir
integer x = 87
integer y = 256
integer width = 389
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Una Página"
end type

event clicked;em_pagnum.enabled = true
end event

type rb_total from radiobutton within w_opciones_imprimir
integer x = 87
integer y = 156
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Total"
boolean checked = true
end type

event clicked;em_pagnum.enabled = false
end event

type cb_cambiar_nombre from commandbutton within w_opciones_imprimir
integer x = 768
integer y = 188
integer width = 599
integer height = 108
integer taborder = 60
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

type dw_datos_certificado from datawindow within w_opciones_imprimir
integer x = 37
integer y = 476
integer width = 1358
integer height = 100
integer taborder = 50
boolean enabled = false
string dataobject = "d_datos_certificado"
boolean border = false
boolean livescroll = true
end type

event constructor;SetTrans(gtr_sce)
end event

type gb_1 from groupbox within w_opciones_imprimir
integer x = 37
integer y = 28
integer width = 667
integer height = 380
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Impresion"
end type

