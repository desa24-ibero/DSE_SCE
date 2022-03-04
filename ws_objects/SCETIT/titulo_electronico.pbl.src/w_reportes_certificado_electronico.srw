$PBExportHeader$w_reportes_certificado_electronico.srw
forward
global type w_reportes_certificado_electronico from window
end type
type cb_imprimir from commandbutton within w_reportes_certificado_electronico
end type
type rb_fechas from radiobutton within w_reportes_certificado_electronico
end type
type rb_relacion from radiobutton within w_reportes_certificado_electronico
end type
type rb_legalizado from radiobutton within w_reportes_certificado_electronico
end type
type rb_simple from radiobutton within w_reportes_certificado_electronico
end type
type cbx_individual from checkbox within w_reportes_certificado_electronico
end type
type cb_buscar from commandbutton within w_reportes_certificado_electronico
end type
type cb_salir from commandbutton within w_reportes_certificado_electronico
end type
type st_fecha_inicial from statictext within w_reportes_certificado_electronico
end type
type st_fecha_final from statictext within w_reportes_certificado_electronico
end type
type em_fecha_final from editmask within w_reportes_certificado_electronico
end type
type em_fecha_inicial from editmask within w_reportes_certificado_electronico
end type
type rb_parciales from radiobutton within w_reportes_certificado_electronico
end type
type rb_totales from radiobutton within w_reportes_certificado_electronico
end type
type cb_cargar from commandbutton within w_reportes_certificado_electronico
end type
type dw_reporte from datawindow within w_reportes_certificado_electronico
end type
type rb_tsu from radiobutton within w_reportes_certificado_electronico
end type
type rb_posgrado from radiobutton within w_reportes_certificado_electronico
end type
type rb_licenciatura from radiobutton within w_reportes_certificado_electronico
end type
type cb_generar from commandbutton within w_reportes_certificado_electronico
end type
type gb_1 from groupbox within w_reportes_certificado_electronico
end type
type gb_2 from groupbox within w_reportes_certificado_electronico
end type
type gb_tipo from groupbox within w_reportes_certificado_electronico
end type
type gb_papeleria from groupbox within w_reportes_certificado_electronico
end type
type gb_relacion from groupbox within w_reportes_certificado_electronico
end type
type em_anio from editmask within w_reportes_certificado_electronico
end type
type st_anio from statictext within w_reportes_certificado_electronico
end type
type uo_relacion from uo_relacion_tit_2013 within w_reportes_certificado_electronico
end type
type gb_fechas from groupbox within w_reportes_certificado_electronico
end type
end forward

global type w_reportes_certificado_electronico from window
integer width = 4754
integer height = 2612
boolean titlebar = true
string title = "Generación de archivos para "
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
string icon = "AppIcon!"
boolean center = true
cb_imprimir cb_imprimir
rb_fechas rb_fechas
rb_relacion rb_relacion
rb_legalizado rb_legalizado
rb_simple rb_simple
cbx_individual cbx_individual
cb_buscar cb_buscar
cb_salir cb_salir
st_fecha_inicial st_fecha_inicial
st_fecha_final st_fecha_final
em_fecha_final em_fecha_final
em_fecha_inicial em_fecha_inicial
rb_parciales rb_parciales
rb_totales rb_totales
cb_cargar cb_cargar
dw_reporte dw_reporte
rb_tsu rb_tsu
rb_posgrado rb_posgrado
rb_licenciatura rb_licenciatura
cb_generar cb_generar
gb_1 gb_1
gb_2 gb_2
gb_tipo gb_tipo
gb_papeleria gb_papeleria
gb_relacion gb_relacion
em_anio em_anio
st_anio st_anio
uo_relacion uo_relacion
gb_fechas gb_fechas
end type
global w_reportes_certificado_electronico w_reportes_certificado_electronico

type variables
INTEGER ii_anio_proc_titulacion  

uo_servicios_titulo_e iuo_servicios_titulo_e

STRING is_documento  

// Datos de GENERACIÓN INDIVIDUAL 
LONG il_cuenta  
LONG il_cve_carrera  
LONG il_cve_plan   





end variables

forward prototypes
public function integer wf_habilita_por_busqueda ()
public function integer wf_carga_relacion (string as_modo)
end prototypes

public function integer wf_habilita_por_busqueda ();
IF rb_relacion.CHECKED THEN 

	em_anio.VISIBLE = TRUE 
	st_anio.VISIBLE = TRUE 
	uo_relacion.VISIBLE = TRUE 
	gb_fechas.VISIBLE = FALSE  
	st_fecha_inicial.VISIBLE = FALSE  
	st_fecha_final.VISIBLE = FALSE  
	em_fecha_inicial.VISIBLE = FALSE  
	em_fecha_final.VISIBLE = FALSE  	

ELSEIF rb_fechas.CHECKED THEN  

	em_anio.VISIBLE = FALSE  
	st_anio.VISIBLE = FALSE  
	uo_relacion.VISIBLE = FALSE  
	gb_fechas.VISIBLE = TRUE 
	st_fecha_inicial.VISIBLE = TRUE 
	st_fecha_final.VISIBLE = TRUE 
	em_fecha_inicial.VISIBLE = TRUE 
	em_fecha_final.VISIBLE = TRUE 	

END IF 

RETURN 0 


//gb_relacion
//rb_relacion
//rb_fechas









end function

public function integer wf_carga_relacion (string as_modo);
// 'LIC_IMP' 
IF rb_licenciatura.CHECKED THEN 
	 uo_relacion.il_filtro_tipo_relacion = 1
//'POS_TIT'	 
ELSEIF rb_posgrado.CHECKED THEN 
	uo_relacion.il_filtro_tipo_relacion = 9
//'TSU' 	
ELSEIF rb_tsu.CHECKED THEN 
	uo_relacion.il_filtro_tipo_relacion = 5
END IF 
	
//case 'LIC_IMP' 
//case 'TSU' 
//case 'POS_TIT'



//IF rb_relacion.CHECKED THEN 
IF as_modo = "N" THEN 
	ii_anio_proc_titulacion = f_obtiene_anio_proc_tit()
ELSE 
	ii_anio_proc_titulacion = INTEGER(em_anio.TEXT) 
END IF 

uo_relacion.of_carga_control( gtr_sce, ii_anio_proc_titulacion)

RETURN  0





end function

on w_reportes_certificado_electronico.create
this.cb_imprimir=create cb_imprimir
this.rb_fechas=create rb_fechas
this.rb_relacion=create rb_relacion
this.rb_legalizado=create rb_legalizado
this.rb_simple=create rb_simple
this.cbx_individual=create cbx_individual
this.cb_buscar=create cb_buscar
this.cb_salir=create cb_salir
this.st_fecha_inicial=create st_fecha_inicial
this.st_fecha_final=create st_fecha_final
this.em_fecha_final=create em_fecha_final
this.em_fecha_inicial=create em_fecha_inicial
this.rb_parciales=create rb_parciales
this.rb_totales=create rb_totales
this.cb_cargar=create cb_cargar
this.dw_reporte=create dw_reporte
this.rb_tsu=create rb_tsu
this.rb_posgrado=create rb_posgrado
this.rb_licenciatura=create rb_licenciatura
this.cb_generar=create cb_generar
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_tipo=create gb_tipo
this.gb_papeleria=create gb_papeleria
this.gb_relacion=create gb_relacion
this.em_anio=create em_anio
this.st_anio=create st_anio
this.uo_relacion=create uo_relacion
this.gb_fechas=create gb_fechas
this.Control[]={this.cb_imprimir,&
this.rb_fechas,&
this.rb_relacion,&
this.rb_legalizado,&
this.rb_simple,&
this.cbx_individual,&
this.cb_buscar,&
this.cb_salir,&
this.st_fecha_inicial,&
this.st_fecha_final,&
this.em_fecha_final,&
this.em_fecha_inicial,&
this.rb_parciales,&
this.rb_totales,&
this.cb_cargar,&
this.dw_reporte,&
this.rb_tsu,&
this.rb_posgrado,&
this.rb_licenciatura,&
this.cb_generar,&
this.gb_1,&
this.gb_2,&
this.gb_tipo,&
this.gb_papeleria,&
this.gb_relacion,&
this.em_anio,&
this.st_anio,&
this.uo_relacion,&
this.gb_fechas}
end on

on w_reportes_certificado_electronico.destroy
destroy(this.cb_imprimir)
destroy(this.rb_fechas)
destroy(this.rb_relacion)
destroy(this.rb_legalizado)
destroy(this.rb_simple)
destroy(this.cbx_individual)
destroy(this.cb_buscar)
destroy(this.cb_salir)
destroy(this.st_fecha_inicial)
destroy(this.st_fecha_final)
destroy(this.em_fecha_final)
destroy(this.em_fecha_inicial)
destroy(this.rb_parciales)
destroy(this.rb_totales)
destroy(this.cb_cargar)
destroy(this.dw_reporte)
destroy(this.rb_tsu)
destroy(this.rb_posgrado)
destroy(this.rb_licenciatura)
destroy(this.cb_generar)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_tipo)
destroy(this.gb_papeleria)
destroy(this.gb_relacion)
destroy(this.em_anio)
destroy(this.st_anio)
destroy(this.uo_relacion)
destroy(this.gb_fechas)
end on

event open;
is_documento = MESSAGE.stringparm 

IF  is_documento = "CER" THEN  
	THIS.TITLE = "Generación de archivos para solicitud de Certificado Electrónico. "
	dw_reporte.DATAOBJECT = "d_bloque_cert_sin_status_reporte_e"
	uo_relacion.VISIBLE = FALSE 
	st_anio.VISIBLE = FALSE 
	em_anio.VISIBLE = FALSE 
	gb_relacion.VISIBLE = FALSE 
	rb_relacion.VISIBLE = FALSE 
	rb_fechas.VISIBLE = FALSE 
ELSEIF is_documento = "TIT" THEN  
	THIS.TITLE = "Generación de archivos para solicitud de Titulo Electrónico. "
	gb_tipo.VISIBLE = FALSE 
	rb_totales.VISIBLE = FALSE 
	rb_parciales.VISIBLE = FALSE 
	//rb_todos.VISIBLE = FALSE 
//	uo_relacion.X = 133 
//	uo_relacion.Y = 76 
	st_fecha_inicial.VISIBLE = FALSE 
	st_fecha_final.VISIBLE = FALSE 
	em_fecha_inicial.VISIBLE = FALSE 
	em_fecha_final.VISIBLE = FALSE 
	gb_fechas.VISIBLE = FALSE 
	rb_legalizado.VISIBLE = FALSE 
	rb_simple.VISIBLE = FALSE 
	gb_papeleria.VISIBLE = FALSE 
	wf_carga_relacion("N") 
	wf_habilita_por_busqueda() 
END IF 


iuo_servicios_titulo_e = CREATE uo_servicios_titulo_e 



end event

type cb_imprimir from commandbutton within w_reportes_certificado_electronico
integer x = 4201
integer y = 200
integer width = 402
integer height = 112
integer taborder = 140
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprimir"
end type

event clicked;SetPointer(HourGlass!)
openwithparm(conf_impr,dw_reporte)
end event

type rb_fechas from radiobutton within w_reportes_certificado_electronico
integer x = 1961
integer y = 236
integer width = 457
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Fechas"
end type

event clicked;POST wf_habilita_por_busqueda() 
end event

type rb_relacion from radiobutton within w_reportes_certificado_electronico
integer x = 1961
integer y = 144
integer width = 457
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Relación"
boolean checked = true
end type

event clicked;POST wf_habilita_por_busqueda() 
end event

type rb_legalizado from radiobutton within w_reportes_certificado_electronico
integer x = 1381
integer y = 144
integer width = 416
integer height = 76
integer taborder = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Legalizado"
boolean checked = true
end type

event clicked;//ii_legalizado = 1
end event

type rb_simple from radiobutton within w_reportes_certificado_electronico
integer x = 1381
integer y = 240
integer width = 325
integer height = 64
integer taborder = 130
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Simple"
end type

event clicked;//ii_legalizado = 0
end event

type cbx_individual from checkbox within w_reportes_certificado_electronico
boolean visible = false
integer x = 3264
integer y = 64
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Individual"
end type

event clicked;IF THIS.CHECKED THEN 
	cb_buscar.ENABLED = TRUE 
ELSE
	cb_buscar.ENABLED = FALSE 
END IF 
end event

type cb_buscar from commandbutton within w_reportes_certificado_electronico
boolean visible = false
integer x = 3685
integer y = 44
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Buscar"
end type

event clicked;String ls_window

il_cuenta = 0 
il_cve_carrera = 0 
il_cve_plan = 0 

uo_parametros luo_parametros 
luo_parametros = CREATE uo_parametros

ls_window = Message.StringParm
Open(w_titulo_electronico) 
IF NOT ISVALID(MESSAGE.powerobjectparm) THEN 
	MESSAGEBOX("Aviso", "No se ha seleccionado un número de cuenta válido")	 
	RETURN 
END IF 

luo_parametros = MESSAGE.powerobjectparm 

il_cuenta = luo_parametros.il_cuenta 
il_cve_carrera = luo_parametros.il_cve_carrera  
il_cve_plan = luo_parametros.il_plan 

cb_cargar.TRIGGEREVENT(CLICKED!) 


//MESSAGEBOX("", STRING(il_cuenta) + STRING(il_cve_carrera) + STRING(il_cve_plan))







end event

type cb_salir from commandbutton within w_reportes_certificado_electronico
integer x = 4206
integer y = 340
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Salir"
end type

event clicked;CLOSE(PARENT)
end event

type st_fecha_inicial from statictext within w_reportes_certificado_electronico
integer x = 2784
integer y = 136
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Fecha Inicial: "
alignment alignment = right!
boolean focusrectangle = false
end type

type st_fecha_final from statictext within w_reportes_certificado_electronico
integer x = 2784
integer y = 236
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Fecha Final: "
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fecha_final from editmask within w_reportes_certificado_electronico
integer x = 3209
integer y = 224
integer width = 503
integer height = 88
integer taborder = 90
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
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type em_fecha_inicial from editmask within w_reportes_certificado_electronico
integer x = 3214
integer y = 124
integer width = 503
integer height = 88
integer taborder = 90
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
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type rb_parciales from radiobutton within w_reportes_certificado_electronico
integer x = 878
integer y = 240
integer width = 338
integer height = 64
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Parciales"
end type

event clicked;//ii_cve_doc_control_sep = 2
end event

type rb_totales from radiobutton within w_reportes_certificado_electronico
integer x = 878
integer y = 148
integer width = 338
integer height = 64
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Totales"
boolean checked = true
end type

event clicked;//ii_cve_doc_control_sep = 1
end event

type cb_cargar from commandbutton within w_reportes_certificado_electronico
integer x = 4206
integer y = 60
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cargar"
end type

event clicked;
DATETIME ldt_fecha_inicial 
DATETIME ldt_fecha_final 
INTEGER li_cve_relacion 
LONG ll_cuenta 
INTEGER le_legalizado
STRING ls_fecha_inicial, ls_fecha_final	 

INTEGER li_cve_doc_control_sep 
STRING ls_nivel[]

//IF cbx_individual.CHECKED THEN 
//	ll_cuenta = il_cuenta
//ELSE
	ll_cuenta = 9999
//END IF 

// Si se generan TITULOS 
IF is_documento = "TIT" THEN 
	
	IF rb_relacion.CHECKED THEN 
		ldt_fecha_inicial = datetime(uo_relacion.of_obtiene_fecha_ini( ))
		ldt_fecha_final = datetime(uo_relacion.of_obtiene_fecha_fin( ))
		li_cve_relacion = uo_relacion.of_obtiene_cve_relacion()		
	ELSEIF rb_fechas.CHECKED THEN  
		ls_fecha_inicial= em_fecha_inicial.text
		ls_fecha_final= em_fecha_final.text
		
		ldt_fecha_inicial = datetime(ls_fecha_inicial)
		ldt_fecha_final = datetime(ls_fecha_final)		 
		
	END IF
	
//	IF cbx_individual.CHECKED THEN
//		
//		dw_reporte.DATAOBJECT = "dw_gen_titulos_ind_e"	  
//		dw_reporte.SETTRANSOBJECT(gtr_sce) 
//		dw_reporte.retrieve(ll_cuenta)	
//	
//	ELSE
		
		// 'LIC_IMP' 
		IF rb_licenciatura.CHECKED THEN 
			//dw_reporte.DATAOBJECT = "dw_rep_titulos_lic_impresor_e"	  
			dw_reporte.DATAOBJECT = "dw_reporte_titulos_lic_impresor_e" 
			dw_reporte.SETTRANSOBJECT(gtr_sce) 
			dw_reporte.retrieve(ldt_fecha_inicial,ldt_fecha_final,li_cve_relacion, ll_cuenta)	
		//'POS_TIT'	 
		ELSEIF rb_posgrado.CHECKED THEN 
			//dw_reporte.DATAOBJECT = "dw_rep_titulos_posg_imp_e" 
			ls_nivel[1] = 'M' 
			ls_nivel[2] = 'D' 
			ls_nivel[3] = 'E' 			
			dw_reporte.DATAOBJECT = "dw_reporte_titulos_posg_imp_e" 
			dw_reporte.SETTRANSOBJECT(gtr_sce) 
			dw_reporte.retrieve(ldt_fecha_inicial,ldt_fecha_final,ls_nivel,li_cve_relacion, ll_cuenta)	
		//'TSU' 	
		ELSEIF rb_tsu.CHECKED THEN 
			dw_reporte.DATAOBJECT = "dw_reporte_titulos_tsu_impresor_e" 
			dw_reporte.SETTRANSOBJECT(gtr_sce) 
			dw_reporte.retrieve(ldt_fecha_inicial,ldt_fecha_final,li_cve_relacion, ll_cuenta)	 
		END IF 
		
//	END IF

// Si se generan CERTIFICADOS  
ELSE	
	

	

	IF rb_licenciatura.CHECKED THEN 
		//ls_nivel = 'L' 
		ls_nivel[1] = 'L'
	ELSEIF rb_posgrado.CHECKED THEN 
		//ls_nivel = 'P' 
		ls_nivel[1] = 'M' 
		ls_nivel[2] = 'D' 
		ls_nivel[3] = 'E' 
		ls_nivel[3] = 'P' 
	ELSEIF rb_tsu.CHECKED THEN 
		//ls_nivel = 'T'  
		ls_nivel[1] = 'T' 
	END IF 

	IF rb_totales.CHECKED THEN 
		li_cve_doc_control_sep = 1 
	ELSEIF rb_parciales.CHECKED THEN 
		li_cve_doc_control_sep = 2 
//	ELSEIF rb_todos.CHECKED THEN 
//		li_cve_doc_control_sep = 9999 
	END IF

	IF rb_legalizado.CHECKED  THEN 
		le_legalizado = 1 
	ELSEIF rb_simple.CHECKED THEN 
		le_legalizado = 0
	END IF


	ls_fecha_inicial= em_fecha_inicial.text
	ls_fecha_final= em_fecha_final.text

	ldt_fecha_inicial = DATETIME(date(ls_fecha_inicial))
	ldt_fecha_final = DATETIME(date(ls_fecha_final))

	if ldt_fecha_final < ldt_fecha_inicial then
		MessageBox("Error de fechas","La fecha inicial no debe ser mayor a la fecha final") 
		RETURN -1 
	end if 

//	IF cbx_individual.CHECKED THEN 
//		dw_reporte.DATAOBJECT = "dw_gen_certificados_ind_e" 
//		dw_reporte.SETTRANSOBJECT(gtr_sce) 
//		dw_reporte.retrieve(li_cve_doc_control_sep, ll_cuenta, le_legalizado, il_cve_carrera, il_cve_plan)	 
//	ELSE
		dw_reporte.SETTRANSOBJECT(gtr_sce) 
		dw_reporte.retrieve(ldt_fecha_inicial, ldt_fecha_final, li_cve_doc_control_sep, 	ls_nivel, ll_cuenta, le_legalizado)	  		
//	END IF 
	
END IF 


RETURN  0







end event

type dw_reporte from datawindow within w_reportes_certificado_electronico
integer x = 183
integer y = 612
integer width = 4343
integer height = 1744
integer taborder = 40
string title = "none"
string dataobject = "dw_reporte_titulos_lic_impresor_e"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_tsu from radiobutton within w_reportes_certificado_electronico
integer x = 242
integer y = 324
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "TSU"
end type

event clicked;POST wf_carga_relacion("M")   
end event

type rb_posgrado from radiobutton within w_reportes_certificado_electronico
integer x = 242
integer y = 232
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Posgrado"
end type

event clicked;POST wf_carga_relacion("M")   
end event

type rb_licenciatura from radiobutton within w_reportes_certificado_electronico
integer x = 242
integer y = 140
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Licenciatura"
boolean checked = true
end type

event clicked;POST wf_carga_relacion("M")   
end event

type cb_generar from commandbutton within w_reportes_certificado_electronico
boolean visible = false
integer x = 4206
integer y = 192
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Generar"
end type

event clicked;//
//// Se incializa el ds de alumnos del objeto de servicios.
//INTEGER le_row  
//INTEGER le_pos, le_ttl_rows
//
//LONG ll_cuenta 
//LONG ll_cve_carrera 
//LONG ll_cve_plan 
//
//iuo_servicios_titulo_e.ids_alumnos.RESET() 
//
//le_ttl_rows = dw_reporte.ROWCOUNT()  
//
//FOR le_pos = 1 TO le_ttl_rows
//
//	// Si se generan TITULOS 
//	IF is_documento = "TIT" THEN 
//	
//		// 'LIC_IMP' 
//		IF rb_licenciatura.CHECKED THEN 
//			//dw_reporte.DATAOBJECT = "dw_rep_titulos_lic_impresor_e"	  
//	
//			ll_cuenta = dw_reporte.GETITEMNUMBER(le_pos, "cuenta")
//			IF ISNULL(ll_cuenta) THEN CONTINUE 
//			ll_cve_carrera = dw_reporte.GETITEMNUMBER(le_pos, "cve_carrera")
//			ll_cve_plan = dw_reporte.GETITEMNUMBER(le_pos, "titulacion_cve_plan")
//			
//		//'POS_TIT'	 
//		ELSEIF rb_posgrado.CHECKED THEN 
//			//dw_reporte.DATAOBJECT = "dw_rep_titulos_posg_imp_e" 
//			
//			ll_cuenta = dw_reporte.GETITEMNUMBER(le_pos, "cuenta")
//			IF ISNULL(ll_cuenta) THEN CONTINUE 
//			ll_cve_carrera = dw_reporte.GETITEMNUMBER(le_pos, "cve_carrera")
//			ll_cve_plan = dw_reporte.GETITEMNUMBER(le_pos, "cve_plan")		
//	
//		//'TSU' 	
//		ELSEIF rb_tsu.CHECKED THEN 
//			//dw_reporte.DATAOBJECT = "dw_rep_titulos_tsu_impresor_e" 
//			
//			ll_cuenta = dw_reporte.GETITEMNUMBER(le_pos, "cuenta")
//			IF ISNULL(ll_cuenta) THEN CONTINUE 
//			ll_cve_carrera = dw_reporte.GETITEMNUMBER(le_pos, "cve_carrera")
//			ll_cve_plan = dw_reporte.GETITEMNUMBER(le_pos, "titulacion_cve_plan")		
//	
//		END IF 
//		
//	// Si se generan CERTIFICADOS  
//	ELSE	
//		
//			ll_cuenta = dw_reporte.GETITEMNUMBER(le_pos, "solicitud_certificado_cuenta")
//			IF ISNULL(ll_cuenta) THEN CONTINUE 
//			ll_cve_carrera = dw_reporte.GETITEMNUMBER(le_pos, "solicitud_certificado_cve_carrera")
//			ll_cve_plan = dw_reporte.GETITEMNUMBER(le_pos, "solicitud_certificado_cve_plan")			
//		
//	END IF 
//
//	le_row = iuo_servicios_titulo_e.ids_alumnos.INSERTROW(0) 
//	iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cuenta", ll_cuenta) 
//	iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cve_carrera", ll_cve_carrera) 
//	iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cve_plan", ll_cve_plan) 
//
//NEXT 
//
//
//
//
//// Se verifica el tipo de documento que se genera 
//IF is_documento = "TIT" THEN  
//	iuo_servicios_titulo_e.f_genera_archivos2("tit") 	
//ELSEIF is_documento = "CER" THEN  
//	iuo_servicios_titulo_e.f_genera_archivos2("cer")  
//END IF
//
//
//
//
//
//// PRUEBAS
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////le_row = iuo_servicios_titulo_e.ids_alumnos.INSERTROW(0)
////iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cuenta", 154051)
////le_row = iuo_servicios_titulo_e.ids_alumnos.INSERTROW(0)
////iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cuenta", 156871)
////le_row = iuo_servicios_titulo_e.ids_alumnos.INSERTROW(0)
////iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cuenta", 153537)
////le_row = iuo_servicios_titulo_e.ids_alumnos.INSERTROW(0)
////iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cuenta", 157921)
////
//
////INTEGEr le_row 
////
////le_row = iuo_servicios_titulo_e.ids_alumnos.INSERTROW(0)
////iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cuenta", 152610)
////
////le_row = iuo_servicios_titulo_e.ids_alumnos.INSERTROW(0)
////iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cuenta", 178038)
////
////le_row = iuo_servicios_titulo_e.ids_alumnos.INSERTROW(0)
////iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cuenta", 181024)
////
////le_row = iuo_servicios_titulo_e.ids_alumnos.INSERTROW(0)
////iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cuenta", 182771)
////
////le_row = iuo_servicios_titulo_e.ids_alumnos.INSERTROW(0)
////iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cuenta", 183704)
////
////le_row = iuo_servicios_titulo_e.ids_alumnos.INSERTROW(0)
////iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cuenta", 189837)
////
////le_row = iuo_servicios_titulo_e.ids_alumnos.INSERTROW(0)
////iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cuenta", 191928)
////
////
////
////// Se verifica el tipo de documento que se genera 
////IF is_documento = "TIT" THEN  
////	iuo_servicios_titulo_e.f_genera_archivos2("tit") 	
////ELSEIF is_documento = "CER" THEN  
////	iuo_servicios_titulo_e.f_genera_archivos2("cer")  
////END IF
//
//
//
end event

type gb_1 from groupbox within w_reportes_certificado_electronico
integer x = 178
integer y = 48
integer width = 603
integer height = 376
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Nivel Documento: "
end type

type gb_2 from groupbox within w_reportes_certificado_electronico
integer x = 101
integer y = 500
integer width = 4507
integer height = 1932
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
string text = "Documentos que se generan: "
end type

type gb_tipo from groupbox within w_reportes_certificado_electronico
integer x = 841
integer y = 52
integer width = 443
integer height = 292
integer taborder = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "Arrow!"
long textcolor = 33554432
string text = "Tipo:"
end type

type gb_papeleria from groupbox within w_reportes_certificado_electronico
integer x = 1339
integer y = 52
integer width = 489
integer height = 292
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "Arrow!"
long textcolor = 33554432
string text = "Papelería"
end type

type gb_relacion from groupbox within w_reportes_certificado_electronico
integer x = 1897
integer y = 60
integer width = 635
integer height = 292
integer taborder = 100
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Tipo de búsqueda"
end type

type em_anio from editmask within w_reportes_certificado_electronico
integer x = 2981
integer y = 64
integer width = 402
integer height = 88
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####"
end type

event modified;POST wf_carga_relacion("M")   
end event

type st_anio from statictext within w_reportes_certificado_electronico
integer x = 2715
integer y = 68
integer width = 197
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Año: "
boolean focusrectangle = false
end type

type uo_relacion from uo_relacion_tit_2013 within w_reportes_certificado_electronico
integer x = 2665
integer y = 160
integer taborder = 20
end type

on uo_relacion.destroy
call uo_relacion_tit_2013::destroy
end on

type gb_fechas from groupbox within w_reportes_certificado_electronico
integer x = 2693
integer y = 40
integer width = 1106
integer height = 304
integer taborder = 90
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Fechas"
end type

