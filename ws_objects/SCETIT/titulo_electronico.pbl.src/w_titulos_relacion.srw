$PBExportHeader$w_titulos_relacion.srw
forward
global type w_titulos_relacion from window
end type
type cb_ruta from commandbutton within w_titulos_relacion
end type
type st_ruta from statictext within w_titulos_relacion
end type
type rb_archivo from radiobutton within w_titulos_relacion
end type
type rb_individual from radiobutton within w_titulos_relacion
end type
type rb_seleccion from radiobutton within w_titulos_relacion
end type
type st_texto_ruta from u_st within w_titulos_relacion
end type
type sle_ruta_archivo from u_sle within w_titulos_relacion
end type
type cb_carga_archivo from commandbutton within w_titulos_relacion
end type
type rb_legalizado from radiobutton within w_titulos_relacion
end type
type rb_simple from radiobutton within w_titulos_relacion
end type
type cb_buscar from commandbutton within w_titulos_relacion
end type
type cb_salir from commandbutton within w_titulos_relacion
end type
type st_fecha_inicial from statictext within w_titulos_relacion
end type
type st_fecha_final from statictext within w_titulos_relacion
end type
type em_fecha_final from editmask within w_titulos_relacion
end type
type em_fecha_inicial from editmask within w_titulos_relacion
end type
type rb_parciales from radiobutton within w_titulos_relacion
end type
type rb_totales from radiobutton within w_titulos_relacion
end type
type cb_cargar from commandbutton within w_titulos_relacion
end type
type dw_reporte from datawindow within w_titulos_relacion
end type
type rb_tsu from radiobutton within w_titulos_relacion
end type
type rb_posgrado from radiobutton within w_titulos_relacion
end type
type rb_licenciatura from radiobutton within w_titulos_relacion
end type
type cb_generar from commandbutton within w_titulos_relacion
end type
type gb_1 from groupbox within w_titulos_relacion
end type
type gb_2 from groupbox within w_titulos_relacion
end type
type gb_tipo from groupbox within w_titulos_relacion
end type
type gb_papeleria from groupbox within w_titulos_relacion
end type
type gb_3 from groupbox within w_titulos_relacion
end type
type uo_relacion from uo_relacion_tit_2013_e within w_titulos_relacion
end type
type gb_fechas from groupbox within w_titulos_relacion
end type
end forward

global type w_titulos_relacion from window
integer width = 5385
integer height = 2844
boolean titlebar = true
string title = "Generación de archivos para "
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
string icon = "AppIcon!"
boolean center = true
cb_ruta cb_ruta
st_ruta st_ruta
rb_archivo rb_archivo
rb_individual rb_individual
rb_seleccion rb_seleccion
st_texto_ruta st_texto_ruta
sle_ruta_archivo sle_ruta_archivo
cb_carga_archivo cb_carga_archivo
rb_legalizado rb_legalizado
rb_simple rb_simple
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
gb_3 gb_3
uo_relacion uo_relacion
gb_fechas gb_fechas
end type
global w_titulos_relacion w_titulos_relacion

type variables
INTEGER ii_anio_proc_titulacion  

uo_servicios_titulo_e iuo_servicios_titulo_e

STRING is_documento  

// Datos de GENERACIÓN INDIVIDUAL 
LONG il_cuenta  
LONG il_cve_carrera  
LONG il_cve_plan   

LONG il_num_relacion


DATASTORE ids_cuentas_archivo 

LONG il_cuentas[] 

STRING is_relacion_titulos 


end variables

forward prototypes
public function integer wf_carga_relacion ()
public function integer wf_habilita ()
public function integer wf_despliega_ruta (string as_ruta)
end prototypes

public function integer wf_carga_relacion ();
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

ii_anio_proc_titulacion =f_obtiene_anio_proc_tit()
uo_relacion.of_carga_control( gtr_sce, ii_anio_proc_titulacion)

RETURN  0





end function

public function integer wf_habilita ();
IF rb_seleccion.CHECKED THEN 
	cb_buscar.VISIBLE = FALSE
	cb_carga_archivo.VISIBLE = FALSE
	sle_ruta_archivo.VISIBLE = FALSE
	sle_ruta_archivo.TEXT = ""
	st_texto_ruta.VISIBLE = FALSE
ELSEIF rb_individual.CHECKED THEN 
	cb_buscar.VISIBLE = TRUE
	cb_carga_archivo.VISIBLE = FALSE
	sle_ruta_archivo.VISIBLE = FALSE
	sle_ruta_archivo.TEXT = ""
	st_texto_ruta.VISIBLE = FALSE
ELSEIF rb_archivo.CHECKED THEN 
	cb_buscar.VISIBLE = FALSE
	cb_carga_archivo.VISIBLE = TRUE
	sle_ruta_archivo.VISIBLE = TRUE
	sle_ruta_archivo.TEXT = ""
	st_texto_ruta.VISIBLE = TRUE
END IF 	


IF is_documento = "TIT"  AND (rb_individual.CHECKED OR  rb_archivo.CHECKED) THEN 

	gb_fechas.VISIBLE = TRUE 	
	st_fecha_inicial.VISIBLE = TRUE 
	st_fecha_final.VISIBLE = TRUE 	
	em_fecha_inicial.VISIBLE = TRUE 
	em_fecha_final.VISIBLE = TRUE
	em_fecha_inicial.TEXT = "" 
	em_fecha_final.TEXT = "" 
	uo_relacion.VISIBLE = FALSE 
	
ELSEIF is_documento = "TIT" AND rb_seleccion.CHECKED THEN 

	st_fecha_inicial.VISIBLE = FALSE 
	st_fecha_final.VISIBLE = FALSE  	
	em_fecha_inicial.TEXT = "" 
	em_fecha_final.TEXT = "" 	
	em_fecha_inicial.VISIBLE = FALSE 
	em_fecha_final.VISIBLE = FALSE
	gb_fechas.VISIBLE = FALSE 
	uo_relacion.VISIBLE = TRUE 	
	
END IF



RETURN 0 




end function

public function integer wf_despliega_ruta (string as_ruta);STRING ls_ruta 
STRING id_doc

id_doc = LOWER(is_documento) 

SELECT ruta 
INTO :ls_ruta  
FROM e_titulo 
WHERE id_doc = :id_doc   
USING gtr_sce; 
IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar la ruta de archivos de salida: " + gtr_sce.SQLERRTEXT) 
	RETURN -1 
END IF 

IF ISNULL(ls_ruta) THEN  ls_ruta = "" 

IF ls_ruta = "VARIABLE" OR ls_ruta = "" THEN ls_ruta = as_ruta  

//st_ruta.TEXT = "Ruta Archivos de Salida: " + ls_ruta 
st_ruta.TEXT = ls_ruta 

RETURN 0




end function

on w_titulos_relacion.create
this.cb_ruta=create cb_ruta
this.st_ruta=create st_ruta
this.rb_archivo=create rb_archivo
this.rb_individual=create rb_individual
this.rb_seleccion=create rb_seleccion
this.st_texto_ruta=create st_texto_ruta
this.sle_ruta_archivo=create sle_ruta_archivo
this.cb_carga_archivo=create cb_carga_archivo
this.rb_legalizado=create rb_legalizado
this.rb_simple=create rb_simple
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
this.gb_3=create gb_3
this.uo_relacion=create uo_relacion
this.gb_fechas=create gb_fechas
this.Control[]={this.cb_ruta,&
this.st_ruta,&
this.rb_archivo,&
this.rb_individual,&
this.rb_seleccion,&
this.st_texto_ruta,&
this.sle_ruta_archivo,&
this.cb_carga_archivo,&
this.rb_legalizado,&
this.rb_simple,&
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
this.gb_3,&
this.uo_relacion,&
this.gb_fechas}
end on

on w_titulos_relacion.destroy
destroy(this.cb_ruta)
destroy(this.st_ruta)
destroy(this.rb_archivo)
destroy(this.rb_individual)
destroy(this.rb_seleccion)
destroy(this.st_texto_ruta)
destroy(this.sle_ruta_archivo)
destroy(this.cb_carga_archivo)
destroy(this.rb_legalizado)
destroy(this.rb_simple)
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
destroy(this.gb_3)
destroy(this.uo_relacion)
destroy(this.gb_fechas)
end on

event open;
is_documento = MESSAGE.stringparm 

SELECT relacion_titulos 
INTO :is_relacion_titulos 
FROM parametros_titulo_elec 
USING gtr_sce;
IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar los parámetros de Titulación Electrónica:" + gtr_sce.SQLERRTEXT) 
	MESSAGEBOX("Aviso", "No estará disponible la generación por relación de Títulos Electrónicos")  
	is_relacion_titulos = 'N' 
END IF 
IF ISNULL(is_relacion_titulos) THEN 
	MESSAGEBOX("Error", "No se han configurado los parámetros de Titulación Electrónica." + gtr_sce.SQLERRTEXT) 
	MESSAGEBOX("Aviso", "No estará disponible la generación por relación de Títulos Electrónicos")  
	is_relacion_titulos = 'N' 	
END IF 	

IF  is_documento = "CER" OR is_documento = "CERES" THEN  
	THIS.TITLE = "Generación de archivos para solicitud de Certificado Electrónico. "
	IF gs_plantel = "PLANTEL CIUDAD DE MÉXICO" THEN
		dw_reporte.DATAOBJECT = "d_reporte_bloque_cert_sin_status_e"
	ELSEIF gs_plantel = "PLANTEL TIJUANA"  THEN 
		dw_reporte.DATAOBJECT = "d_reporte_bloq_cert_sin_sta_e_tij" 
	END IF 	
		uo_relacion.VISIBLE = FALSE 
ELSEIF is_documento = "TIT" THEN  
	THIS.TITLE = "Generación de archivos para solicitud de Titulo Electrónico. "
	gb_tipo.VISIBLE = FALSE 
	rb_totales.VISIBLE = FALSE 
	rb_parciales.VISIBLE = FALSE 
	//rb_todos.VISIBLE = FALSE 
	uo_relacion.X = 133 
	uo_relacion.Y = 76 
	st_fecha_inicial.VISIBLE = FALSE 
	st_fecha_final.VISIBLE = FALSE 
	em_fecha_inicial.VISIBLE = FALSE 
	em_fecha_final.VISIBLE = FALSE 
	gb_fechas.VISIBLE = FALSE 
	rb_legalizado.VISIBLE = FALSE 
	rb_simple.VISIBLE = FALSE 
	gb_papeleria.VISIBLE = FALSE 
END IF 

// Si no se generan títulos por ralación se ocultan estas opciones
IF is_relacion_titulos = "S" THEN 
	wf_carga_relacion() 
ELSE
	rb_seleccion.VISIBLE = FALSE 
	uo_relacion.VISIBLE = FALSE 
	rb_seleccion.CHECKED = FALSE 
	rb_individual.CHECKED = TRUE 
END IF 

wf_habilita() 

wf_despliega_ruta("")




end event

type cb_ruta from commandbutton within w_titulos_relacion
integer x = 3762
integer y = 636
integer width = 311
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cambiar"
end type

event clicked;STRING ls_ruta 

OPENWITHPARM(w_ruta_archivos_salida, lower(is_documento)) 

ls_ruta = MESSAGE.STRINGPARM 

wf_despliega_ruta(ls_ruta)  



end event

type st_ruta from statictext within w_titulos_relacion
integer x = 73
integer y = 656
integer width = 3648
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ruta Archivos de Salida: "
alignment alignment = right!
boolean focusrectangle = false
end type

type rb_archivo from radiobutton within w_titulos_relacion
integer x = 3264
integer y = 320
integer width = 389
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
string text = "Archivo"
end type

event clicked;wf_habilita() 
end event

type rb_individual from radiobutton within w_titulos_relacion
integer x = 3264
integer y = 220
integer width = 389
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
string text = "Individual"
end type

event clicked;wf_habilita() 
end event

type rb_seleccion from radiobutton within w_titulos_relacion
integer x = 3264
integer y = 120
integer width = 389
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
string text = "Selección"
boolean checked = true
end type

event clicked;wf_habilita() 
end event

type st_texto_ruta from u_st within w_titulos_relacion
integer x = 1815
integer y = 520
integer width = 146
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1073741824
string text = "Ruta:"
end type

type sle_ruta_archivo from u_sle within w_titulos_relacion
integer x = 1998
integer y = 512
integer width = 1719
integer height = 76
integer taborder = 70
integer textsize = -10
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1073741824
boolean displayonly = true
end type

type cb_carga_archivo from commandbutton within w_titulos_relacion
integer x = 3753
integer y = 484
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Sel. Archivo"
end type

event clicked;string pathname, filename, ls_nombre_archivo

integer value

value = GetFileOpenName("Seleccione el Archivo", &
		+ pathname, filename, "TXT", &
		+ "Text Files (*.TXT),*.TXT")

IF value = 1 THEN 
	ls_nombre_archivo = pathname
	sle_ruta_archivo.text = ls_nombre_archivo
ELSE
	MessageBox("Sin Archivo","No se ha abierto ningún archivo",Information!)
END IF


//INTEGER le_pos, le_ttl_rgs
//LONG ll_cuenta
//
//ids_cuentas_archivo = CREATE DATASTORE  
//
//ids_cuentas_archivo.DATAOBJECT = "dw_cuentas_archivo" 
////ids_cuentas_archivo.SETTRANSOBJECT(itr_sce) 
////ids_cuentas_archivo.RETRIEVE() 
//ids_cuentas_archivo.ImportFile(ls_nombre_archivo)  
//
//le_ttl_rgs = ids_cuentas_archivo.ROWCOUNT() 
//
//FOR le_pos = 1 TO le_ttl_rgs 
//	ll_cuenta = ids_cuentas_archivo.GETITEMNUMBER(le_pos, "cuenta") 
//	il_cuentas[le_pos] = ll_cuenta
//NEXT 
//

//String ls_window
//
//il_cuenta = 0 
//il_cve_carrera = 0 
//il_cve_plan = 0 
//
//uo_parametros luo_parametros 
//luo_parametros = CREATE uo_parametros
//
//ls_window = Message.StringParm
//Open(w_titulo_electronico) 
//IF NOT ISVALID(MESSAGE.powerobjectparm) THEN 
//	MESSAGEBOX("Aviso", "No se ha seleccionado un número de cuenta válido")	 
//	RETURN 
//END IF 
//
//luo_parametros = MESSAGE.powerobjectparm 
//
//il_cuenta = luo_parametros.il_cuenta 
//il_cve_carrera = luo_parametros.il_cve_carrera  
//il_cve_plan = luo_parametros.il_plan 
//
//cb_cargar.TRIGGEREVENT(CLICKED!) 
//
//
//







end event

type rb_legalizado from radiobutton within w_titulos_relacion
integer x = 2715
integer y = 136
integer width = 416
integer height = 76
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

type rb_simple from radiobutton within w_titulos_relacion
integer x = 2715
integer y = 232
integer width = 325
integer height = 64
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

type cb_buscar from commandbutton within w_titulos_relacion
integer x = 3753
integer y = 76
integer width = 402
integer height = 112
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Buscar"
end type

event clicked;String ls_window

il_cuenta = 0 
il_cve_carrera = 0 
il_cve_plan = 0 

uo_parametros luo_parametros 
luo_parametros = CREATE uo_parametros

uo_parametros luo_parametros2 
luo_parametros2 = CREATE uo_parametros

luo_parametros2.is_documento = is_documento

ls_window = Message.StringParm
OpenWithParm(w_titulo_electronico, luo_parametros2) 
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

type cb_salir from commandbutton within w_titulos_relacion
integer x = 4206
integer y = 348
integer width = 402
integer height = 112
integer taborder = 60
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

type st_fecha_inicial from statictext within w_titulos_relacion
integer x = 279
integer y = 152
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

type st_fecha_final from statictext within w_titulos_relacion
integer x = 279
integer y = 268
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

type em_fecha_final from editmask within w_titulos_relacion
integer x = 704
integer y = 256
integer width = 503
integer height = 88
integer taborder = 30
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

type em_fecha_inicial from editmask within w_titulos_relacion
integer x = 709
integer y = 140
integer width = 503
integer height = 88
integer taborder = 20
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

type rb_parciales from radiobutton within w_titulos_relacion
integer x = 2213
integer y = 232
integer width = 338
integer height = 64
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

type rb_totales from radiobutton within w_titulos_relacion
integer x = 2213
integer y = 140
integer width = 338
integer height = 64
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

type cb_cargar from commandbutton within w_titulos_relacion
integer x = 4206
integer y = 76
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
LONG ll_limpia[] 
LONG ll_cuenta
INTEGER le_legalizado

INTEGER li_cve_doc_control_sep 
STRING ls_nivel[]
STRING ls_fecha_inicial, ls_fecha_final
INTEGER le_rows

INTEGER le_pos, le_ttl_rgs
STRING ls_nombre_archivo
DATETIME ldt_comp

il_cuentas = ll_limpia 

//ldt_fecha_inicial = datetime(uo_relacion.of_obtiene_fecha_ini( ))
//ldt_fecha_final = datetime(uo_relacion.of_obtiene_fecha_fin( ))
//li_cve_relacion = uo_relacion.of_obtiene_cve_relacion()
//il_num_relacion = li_cve_relacion 

//IF cbx_individual.CHECKED THEN 
IF rb_individual.CHECKED THEN 
	il_cuentas[1] = il_cuenta
ELSE
	ll_cuenta = 9999
END IF 

// Si se generan TITULOS 
IF is_documento = "TIT" THEN 
	
	IF rb_individual.CHECKED OR  rb_archivo.CHECKED THEN 
		ls_fecha_inicial= em_fecha_inicial.text
		ls_fecha_final= em_fecha_final.text

		
		ldt_fecha_inicial = DATETIME(date(ls_fecha_inicial))
		ldt_fecha_final = DATETIME(date(ls_fecha_final))
		
		IF ldt_comp = ldt_fecha_inicial OR ldt_comp = ldt_fecha_final THEN 
			MessageBox("Error de fechas","El rango de fechas especificado no es válido")  
			RETURN -1 
		END IF 
	
		if ldt_fecha_final < ldt_fecha_inicial then
			MessageBox("Error de fechas","La fecha inicial no debe ser mayor a la fecha final") 
			RETURN -1 
		end if 		
	END IF	
	
	//IF cbx_individual.CHECKED THEN
	IF rb_individual.CHECKED THEN
	
		dw_reporte.DATAOBJECT = "dw_gen_titulos_ind_e"	  
		dw_reporte.SETTRANSOBJECT(gtr_sce) 
		le_rows = dw_reporte.retrieve(il_cuentas, ldt_fecha_inicial, ldt_fecha_final)	
		
	//ELSEIF cbx_archivo.CHECKED THEN 
	ELSEIF rb_archivo.CHECKED THEN
	
	
		ids_cuentas_archivo = CREATE DATASTORE  
		
		ids_cuentas_archivo.DATAOBJECT = "dw_cuentas_archivo" 
		ls_nombre_archivo = sle_ruta_archivo.TEXT 
		IF TRIM(ls_nombre_archivo) = "" THEN 
			MESSAGEBOX("Error", "No se ha seleccionado un archivo válido.")
			RETURN -1
		END IF
		ids_cuentas_archivo.ImportFile(ls_nombre_archivo)  
		
		le_ttl_rgs = ids_cuentas_archivo.ROWCOUNT() 
		
		FOR le_pos = 1 TO le_ttl_rgs 
			ll_cuenta = ids_cuentas_archivo.GETITEMNUMBER(le_pos, "cuenta") 
			il_cuentas[le_pos] = ll_cuenta
		NEXT 
	
	
	
	
		dw_reporte.DATAOBJECT = "dw_gen_titulos_ind_e"	  
		dw_reporte.SETTRANSOBJECT(gtr_sce) 
		le_rows = dw_reporte.retrieve(il_cuentas, ldt_fecha_inicial, ldt_fecha_final)			
	
	ELSE
		
		ldt_fecha_inicial = datetime(uo_relacion.of_obtiene_fecha_ini( ))
		ldt_fecha_final = datetime(uo_relacion.of_obtiene_fecha_fin( ))
		li_cve_relacion = uo_relacion.of_obtiene_cve_relacion()
		il_num_relacion = li_cve_relacion 		
				
		// 'LIC_IMP' 
		IF rb_licenciatura.CHECKED THEN 
			dw_reporte.DATAOBJECT = "dw_rep_titulos_lic_impresor_e"	  
			dw_reporte.SETTRANSOBJECT(gtr_sce) 
			dw_reporte.retrieve(ldt_fecha_inicial,ldt_fecha_final,li_cve_relacion, ll_cuenta)	
		//'POS_TIT'	 
		ELSEIF rb_posgrado.CHECKED THEN 
			ls_nivel[1] = 'M' 
			ls_nivel[2] = 'D' 
			ls_nivel[3] = 'E' 
			//ls_nivel[3] = 'P' 			
			dw_reporte.DATAOBJECT = "dw_rep_titulos_posg_imp_e" 
			dw_reporte.SETTRANSOBJECT(gtr_sce) 
			dw_reporte.retrieve(ldt_fecha_inicial,ldt_fecha_final,ls_nivel,li_cve_relacion, ll_cuenta)	
		//'TSU' 	
		ELSEIF rb_tsu.CHECKED THEN 
			dw_reporte.DATAOBJECT = "dw_rep_titulos_tsu_impresor_e" 
			dw_reporte.SETTRANSOBJECT(gtr_sce) 
			dw_reporte.retrieve(ldt_fecha_inicial,ldt_fecha_final,li_cve_relacion, ll_cuenta)	 
		END IF 
		
	END IF
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
		//ls_nivel[3] = 'P' 
	ELSEIF rb_tsu.CHECKED THEN 
		//ls_nivel = 'T'  
		ls_nivel[1] = 'T' 
	END IF 

	IF gs_plantel = "PLANTEL CIUDAD DE MÉXICO" THEN
		IF rb_totales.CHECKED THEN 
			li_cve_doc_control_sep = 1 
		ELSEIF rb_parciales.CHECKED THEN 
			li_cve_doc_control_sep = 2 
		END IF
	ELSEIF gs_plantel = "PLANTEL TIJUANA"  THEN
		IF rb_totales.CHECKED THEN 
			li_cve_doc_control_sep = 0 
		ELSEIF rb_parciales.CHECKED THEN 
			li_cve_doc_control_sep = 1 
		END IF	
	END IF 	

	IF rb_legalizado.CHECKED  THEN 
		le_legalizado = 1 
	ELSEIF rb_simple.CHECKED THEN 
		le_legalizado = 0
	END IF

//	IF rb_archivo.CHECKED OR rb_seleccion.CHECKED THEN 
		ls_fecha_inicial= em_fecha_inicial.text
		ls_fecha_final= em_fecha_final.text
		
		
		ldt_fecha_inicial = DATETIME(date(ls_fecha_inicial))
		ldt_fecha_final = DATETIME(date(ls_fecha_final))
		
		IF ldt_comp = ldt_fecha_inicial OR ldt_comp = ldt_fecha_final THEN 
			MessageBox("Error de fechas","El rango de fechas especificado no es válido")  
			RETURN -1 
		END IF 
	
		if ldt_fecha_final < ldt_fecha_inicial then
			MessageBox("Error de fechas","La fecha inicial no debe ser mayor a la fecha final") 
			RETURN -1 
		end if 		
//	END IF


	//IF cbx_individual.CHECKED THEN 
	IF rb_individual.CHECKED  THEN 
		
		//dw_reporte.DATAOBJECT = "dw_gen_certificados_ind_e" 
		IF gs_plantel = "PLANTEL CIUDAD DE MÉXICO" THEN
			dw_reporte.DATAOBJECT = "dw_gen_certificados_ind_e" 
			dw_reporte.SETTRANSOBJECT(gtr_sce) 
			dw_reporte.retrieve(li_cve_doc_control_sep, il_cuentas, le_legalizado, il_cve_carrera, il_cve_plan, ldt_fecha_inicial, ldt_fecha_final)	 			
		ELSEIF gs_plantel = "PLANTEL TIJUANA"  THEN 
			dw_reporte.DATAOBJECT = "dw_gen_certificados_ind_e_tij"  
			dw_reporte.SETTRANSOBJECT(gtr_sce) 
			dw_reporte.retrieve(li_cve_doc_control_sep, il_cuentas, le_legalizado, il_cve_carrera, il_cve_plan, ldt_fecha_inicial, ldt_fecha_final,ls_nivel)	 			
		END IF 					
		
		IF dw_reporte.ROWCOUNT() <= 0 THEN 
			MESSAGEBOX("Aviso", "No se encontraron certificados que cumplan las condiciones definidas. Por favor revise si existen certificados definidos con el Nivel, Tipo y papeleria especificados. ")
		END IF 	
		
		
	// POR ARCHIVO 	
	ELSEIF rb_archivo.CHECKED THEN

		il_cuentas = ll_limpia 

		ids_cuentas_archivo = CREATE DATASTORE  
		
		ids_cuentas_archivo.DATAOBJECT = "dw_cuentas_archivo" 
		ls_nombre_archivo = sle_ruta_archivo.TEXT 
		IF TRIM(ls_nombre_archivo) = "" THEN 
			MESSAGEBOX("Error", "No se ha seleccionado un archivo válido.")
			RETURN -1
		END IF
		ids_cuentas_archivo.ImportFile(ls_nombre_archivo)  
		
		le_ttl_rgs = ids_cuentas_archivo.ROWCOUNT() 
		
		FOR le_pos = 1 TO le_ttl_rgs 
			ll_cuenta = ids_cuentas_archivo.GETITEMNUMBER(le_pos, "cuenta") 
			il_cuentas[le_pos] = ll_cuenta
		NEXT 		
		
		//dw_reporte.DATAOBJECT = "dw_gen_certificados_ind_e" 
		IF gs_plantel = "PLANTEL CIUDAD DE MÉXICO" THEN
			dw_reporte.DATAOBJECT = "dw_gen_certificados_ind_e" 
		ELSEIF gs_plantel = "PLANTEL TIJUANA"  THEN 
			dw_reporte.DATAOBJECT = "dw_gen_certificados_ind_e_tij"  
		END IF 							
		
		dw_reporte.SETTRANSOBJECT(gtr_sce) 
		dw_reporte.retrieve(li_cve_doc_control_sep, il_cuentas, le_legalizado, 9999, 9999, ldt_fecha_inicial, ldt_fecha_final)	 			
		
		IF dw_reporte.ROWCOUNT() <= 0 THEN 
			MESSAGEBOX("Aviso", "No se encontraron certificados que cumplan las condiciones definidas. Por favor revise si existen certificados definidos con el Nivel, Tipo y papeleria especificados. ")
		END IF 	
		
	// SELECCIÓN 	
	ELSE
		
		//dw_reporte.DATAOBJECT = "d_reporte_bloque_cert_sin_status_e"
		IF gs_plantel = "PLANTEL CIUDAD DE MÉXICO" THEN
			dw_reporte.DATAOBJECT = "d_reporte_bloque_cert_sin_status_e"
		ELSEIF gs_plantel = "PLANTEL TIJUANA"  THEN 
			dw_reporte.DATAOBJECT = "d_reporte_bloq_cert_sin_sta_e_tij" 
		END IF 			
		
		dw_reporte.SETTRANSOBJECT(gtr_sce) 
		dw_reporte.retrieve(ldt_fecha_inicial, ldt_fecha_final, li_cve_doc_control_sep, 	ls_nivel, ll_cuenta, le_legalizado)	  		
	END IF 
	
END IF 


RETURN  0







end event

type dw_reporte from datawindow within w_titulos_relacion
integer x = 183
integer y = 876
integer width = 4343
integer height = 1744
integer taborder = 70
string title = "none"
string dataobject = "dw_rep_titulos_lic_impresor_e"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_tsu from radiobutton within w_titulos_relacion
integer x = 1600
integer y = 320
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

event clicked;wf_carga_relacion() 
end event

type rb_posgrado from radiobutton within w_titulos_relacion
integer x = 1600
integer y = 228
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

event clicked;wf_carga_relacion() 
end event

type rb_licenciatura from radiobutton within w_titulos_relacion
integer x = 1600
integer y = 136
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

event clicked;wf_carga_relacion() 
end event

type cb_generar from commandbutton within w_titulos_relacion
integer x = 4206
integer y = 208
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Generar"
end type

event clicked;
// Se incializa el ds de alumnos del objeto de servicios.
INTEGER le_row, le_legalizado  
INTEGER le_pos, le_ttl_rows

LONG ll_cuenta 
LONG ll_cve_carrera 
LONG ll_cve_plan 

STRING ls_fecha_inicial, ls_fecha_final 
DATETIME ldt_fecha_inicial, ldt_fecha_final, ldt_comp 

IF st_ruta.TEXT = "" THEN 
	MESSAGEBOX("Error", "No se ha especificado una carpeta de salida de archivos generados.")  
	st_ruta.SETFOCUS() 
	RETURN -1	
END IF 

IF dw_reporte.ROWCOUNT() <= 0 THEN 
	MESSAGEBOX("Error", "No existen cuentas seleccionadas para generación de documento electrónico.") 
	RETURN -1
END IF 

IF ISVALID(iuo_servicios_titulo_e) THEN DESTROY iuo_servicios_titulo_e 
iuo_servicios_titulo_e = CREATE uo_servicios_titulo_e 

iuo_servicios_titulo_e.ids_alumnos.RESET() 

iuo_servicios_titulo_e.il_num_relacion = il_num_relacion

le_ttl_rows = dw_reporte.ROWCOUNT()  

IF rb_licenciatura.CHECKED THEN 
	iuo_servicios_titulo_e.is_nivel = 'L'   
ELSEIF rb_posgrado.CHECKED THEN 
	iuo_servicios_titulo_e.is_nivel = 'P'  
ELSEIF rb_tsu.CHECKED THEN 
	iuo_servicios_titulo_e.is_nivel = 'T'  
END IF 

IF rb_legalizado.CHECKED  THEN 
	le_legalizado = 1 
ELSEIF rb_simple.CHECKED THEN 
	le_legalizado = 0
END IF

iuo_servicios_titulo_e.ie_legalizado =  le_legalizado

iuo_servicios_titulo_e.is_ruta_variable = st_ruta.TEXT 

FOR le_pos = 1 TO le_ttl_rows

	// Si se generan TITULOS 
	IF is_documento = "TIT" THEN 
	
		// 'LIC_IMP' 
		IF rb_licenciatura.CHECKED THEN 
			//dw_reporte.DATAOBJECT = "dw_rep_titulos_lic_impresor_e"	  
	
			ll_cuenta = dw_reporte.GETITEMNUMBER(le_pos, "cuenta")
			IF ISNULL(ll_cuenta) THEN CONTINUE 
			ll_cve_carrera = dw_reporte.GETITEMNUMBER(le_pos, "cve_carrera")
			ll_cve_plan = dw_reporte.GETITEMNUMBER(le_pos, "titulacion_cve_plan")
			
		ELSEIF rb_posgrado.CHECKED THEN 
		//'POS_TIT'	 
			//dw_reporte.DATAOBJECT = "dw_rep_titulos_posg_imp_e" 
			
			ll_cuenta = dw_reporte.GETITEMNUMBER(le_pos, "cuenta")
			IF ISNULL(ll_cuenta) THEN CONTINUE 
			ll_cve_carrera = dw_reporte.GETITEMNUMBER(le_pos, "cve_carrera")
			ll_cve_plan = dw_reporte.GETITEMNUMBER(le_pos, "titulacion_cve_plan")		
	
		//'TSU' 	
		ELSEIF rb_tsu.CHECKED THEN 
			//dw_reporte.DATAOBJECT = "dw_rep_titulos_tsu_impresor_e" 
			
			ll_cuenta = dw_reporte.GETITEMNUMBER(le_pos, "cuenta")
			IF ISNULL(ll_cuenta) THEN CONTINUE 
			ll_cve_carrera = dw_reporte.GETITEMNUMBER(le_pos, "cve_carrera")
			ll_cve_plan = dw_reporte.GETITEMNUMBER(le_pos, "titulacion_cve_plan")		
	
		END IF 
		
		// Se toman las fechas dewl control correspondiente
		IF rb_seleccion.CHECKED THEN 
			
			ldt_fecha_inicial = datetime(uo_relacion.of_obtiene_fecha_ini( ))
			ldt_fecha_final = datetime(uo_relacion.of_obtiene_fecha_fin( ))
			
		ELSE 
			
			ls_fecha_inicial= em_fecha_inicial.text
			ls_fecha_final= em_fecha_final.text
		
			ldt_fecha_inicial = DATETIME(date(ls_fecha_inicial))
			ldt_fecha_final = DATETIME(date(ls_fecha_final))		
		
			iuo_servicios_titulo_e.idt_fecha_inicio = ldt_fecha_inicial 
			iuo_servicios_titulo_e.idt_fecha_fin = ldt_fecha_final 			
			
		END IF
	
		
	// Si se generan CERTIFICADOS  
	ELSE	
		

		
			ls_fecha_inicial= em_fecha_inicial.text
			ls_fecha_final= em_fecha_final.text
		
			ldt_fecha_inicial = DATETIME(date(ls_fecha_inicial))
			ldt_fecha_final = DATETIME(date(ls_fecha_final))		
		
			iuo_servicios_titulo_e.idt_fecha_inicio = ldt_fecha_inicial 
			iuo_servicios_titulo_e.idt_fecha_fin = ldt_fecha_final 
		
			IF gs_plantel = "PLANTEL CIUDAD DE MÉXICO" THEN
				ll_cuenta = dw_reporte.GETITEMNUMBER(le_pos, "solicitud_certificado_cuenta")
				IF ISNULL(ll_cuenta) THEN CONTINUE 
				ll_cve_carrera = dw_reporte.GETITEMNUMBER(le_pos, "solicitud_certificado_cve_carrera")
				ll_cve_plan = dw_reporte.GETITEMNUMBER(le_pos, "solicitud_certificado_cve_plan")			
			ELSEIF gs_plantel = "PLANTEL TIJUANA" THEN 
				ll_cuenta = dw_reporte.GETITEMNUMBER(le_pos, "certificado_cuenta")
				IF ISNULL(ll_cuenta) THEN CONTINUE 
				ll_cve_carrera = dw_reporte.GETITEMNUMBER(le_pos, "certificado_cve_carrera")
				ll_cve_plan = dw_reporte.GETITEMNUMBER(le_pos, "certificado_cve_plan")			
			END IF 	
				
			

	END IF 

	le_row = iuo_servicios_titulo_e.ids_alumnos.INSERTROW(0) 
	iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cuenta", ll_cuenta) 
	iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cve_carrera", ll_cve_carrera) 
	iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cve_plan", ll_cve_plan) 

NEXT 

// Se ordenan los titulos por cuenta de manera descendente para que el archivo que se cierre de grupo sea el de la cuenta MÁXIMO
iuo_servicios_titulo_e.ids_alumnos.SETSORT("cuenta desc") 
iuo_servicios_titulo_e.ids_alumnos.SORT() 


IF rb_archivo.CHECKED OR rb_individual.CHECKED THEN 
	IF ldt_comp = ldt_fecha_inicial OR ldt_comp = ldt_fecha_final THEN 
		MessageBox("Error de fechas","El rango de fechas especificado no es válido")  
		RETURN -1 
	END IF 

	if ldt_fecha_final < ldt_fecha_inicial then
		MessageBox("Error de fechas","La fecha inicial no debe ser mayor a la fecha final") 
		RETURN -1 
	end if 		
END IF



// Se verifica el tipo de documento que se genera 
IF is_documento = "TIT" THEN  
	
	iuo_servicios_titulo_e.f_genera_archivos2("tit") 	
	
ELSEIF is_documento = "CER" THEN  
	
	IF rb_totales.CHECKED THEN 
		iuo_servicios_titulo_e.ie_tipo_certificacion = 79 
	ELSEIF rb_parciales.CHECKED THEN 
		iuo_servicios_titulo_e.ie_tipo_certificacion = 80 
	END IF	
	iuo_servicios_titulo_e.f_genera_archivos2("cer")  
	
ELSEIF is_documento = "CERES" THEN  
	
	IF rb_totales.CHECKED THEN 
		iuo_servicios_titulo_e.ie_tipo_certificacion = 79 
	ELSEIF rb_parciales.CHECKED THEN 
		iuo_servicios_titulo_e.ie_tipo_certificacion = 80 
	END IF	
	iuo_servicios_titulo_e.f_genera_archivos2("ceres")  	
	
END IF

COMMIT USING gtr_sce; 

IF ISVALID(iuo_servicios_titulo_e) THEN DESTROY iuo_servicios_titulo_e 



// PRUEBAS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//le_row = iuo_servicios_titulo_e.ids_alumnos.INSERTROW(0)
//iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cuenta", 154051)
//le_row = iuo_servicios_titulo_e.ids_alumnos.INSERTROW(0)
//iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cuenta", 156871)
//le_row = iuo_servicios_titulo_e.ids_alumnos.INSERTROW(0)
//iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cuenta", 153537)
//le_row = iuo_servicios_titulo_e.ids_alumnos.INSERTROW(0)
//iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cuenta", 157921)
//

//INTEGEr le_row 
//
//le_row = iuo_servicios_titulo_e.ids_alumnos.INSERTROW(0)
//iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cuenta", 152610)
//
//le_row = iuo_servicios_titulo_e.ids_alumnos.INSERTROW(0)
//iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cuenta", 178038)
//
//le_row = iuo_servicios_titulo_e.ids_alumnos.INSERTROW(0)
//iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cuenta", 181024)
//
//le_row = iuo_servicios_titulo_e.ids_alumnos.INSERTROW(0)
//iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cuenta", 182771)
//
//le_row = iuo_servicios_titulo_e.ids_alumnos.INSERTROW(0)
//iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cuenta", 183704)
//
//le_row = iuo_servicios_titulo_e.ids_alumnos.INSERTROW(0)
//iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cuenta", 189837)
//
//le_row = iuo_servicios_titulo_e.ids_alumnos.INSERTROW(0)
//iuo_servicios_titulo_e.ids_alumnos.SETITEM(le_row, "cuenta", 191928)
//
//
//
//// Se verifica el tipo de documento que se genera 
//IF is_documento = "TIT" THEN  
//	iuo_servicios_titulo_e.f_genera_archivos2("tit") 	
//ELSEIF is_documento = "CER" THEN  
//	iuo_servicios_titulo_e.f_genera_archivos2("cer")  
//END IF



end event

type gb_1 from groupbox within w_titulos_relacion
integer x = 1536
integer y = 44
integer width = 603
integer height = 376
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Nivel Documento: "
end type

type gb_2 from groupbox within w_titulos_relacion
integer x = 101
integer y = 764
integer width = 4507
integer height = 1932
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
string text = "Documentos que se generan: "
end type

type gb_tipo from groupbox within w_titulos_relacion
integer x = 2176
integer y = 44
integer width = 443
integer height = 292
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

type gb_papeleria from groupbox within w_titulos_relacion
integer x = 2674
integer y = 44
integer width = 489
integer height = 292
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

type gb_3 from groupbox within w_titulos_relacion
integer x = 3200
integer y = 44
integer width = 530
integer height = 408
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
string text = "Generar por:"
end type

type uo_relacion from uo_relacion_tit_2013_e within w_titulos_relacion
integer x = 2821
integer y = 188
integer taborder = 10
end type

on uo_relacion.destroy
call uo_relacion_tit_2013_e::destroy
end on

type gb_fechas from groupbox within w_titulos_relacion
integer x = 187
integer y = 44
integer width = 1106
integer height = 376
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Fechas"
end type

