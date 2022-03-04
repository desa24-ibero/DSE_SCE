$PBExportHeader$w_reporte_documentos.srw
forward
global type w_reporte_documentos from window
end type
type cbx_error from checkbox within w_reporte_documentos
end type
type cbx_correcto from checkbox within w_reporte_documentos
end type
type cb_salir from commandbutton within w_reporte_documentos
end type
type cb_imprimir from commandbutton within w_reporte_documentos
end type
type dw_reporte from datawindow within w_reporte_documentos
end type
type gb_1 from groupbox within w_reporte_documentos
end type
end forward

global type w_reporte_documentos from window
integer width = 5015
integer height = 2440
boolean titlebar = true
string title = "Resultado de la generación de Archivos"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cbx_error cbx_error
cbx_correcto cbx_correcto
cb_salir cb_salir
cb_imprimir cb_imprimir
dw_reporte dw_reporte
gb_1 gb_1
end type
global w_reporte_documentos w_reporte_documentos

type variables
LONG il_relacion[] 
end variables

forward prototypes
public function integer wf_carga_datos ()
public function integer wf_filtra ()
end prototypes

public function integer wf_carga_datos ();
dw_reporte.SETTRANSOBJECT(gtr_sce) 
dw_reporte.RETRIEVE(il_relacion) 

dw_reporte.SETSORT("estatus_generado asc, cuenta asc") 
dw_reporte.SORT() 
dw_reporte.GROUPCALC() 


RETURN 0 
end function

public function integer wf_filtra ();
IF cbx_correcto.CHECKED AND cbx_error.CHECKED THEN 
	dw_reporte.SETFILTER("") 
	dw_reporte.FILTER()
ELSEIF cbx_correcto.CHECKED THEN 
	dw_reporte.SETFILTER("estatus_generado = 0") 
	dw_reporte.FILTER()	
ELSEIF cbx_error.CHECKED THEN 
	dw_reporte.SETFILTER("estatus_generado <> 0") 
	dw_reporte.FILTER()	
ELSE 	
	dw_reporte.SETFILTER("") 
	dw_reporte.FILTER()	
END IF

dw_reporte.SETSORT("estatus_generado asc, cuenta asc") 
dw_reporte.SORT() 
dw_reporte.GROUPCALC() 


RETURN 0 
end function

on w_reporte_documentos.create
this.cbx_error=create cbx_error
this.cbx_correcto=create cbx_correcto
this.cb_salir=create cb_salir
this.cb_imprimir=create cb_imprimir
this.dw_reporte=create dw_reporte
this.gb_1=create gb_1
this.Control[]={this.cbx_error,&
this.cbx_correcto,&
this.cb_salir,&
this.cb_imprimir,&
this.dw_reporte,&
this.gb_1}
end on

on w_reporte_documentos.destroy
destroy(this.cbx_error)
destroy(this.cbx_correcto)
destroy(this.cb_salir)
destroy(this.cb_imprimir)
destroy(this.dw_reporte)
destroy(this.gb_1)
end on

event open;IF NOT ISVALID(MESSAGE.powerobjectparm) THEN 
	MESSAGEBOX("Aviso", "No se pudieron recuperar los registros generados")	  
	RETURN 
END IF 

uo_parametros  luo_parametros
luo_parametros = CREATE uo_parametros
luo_parametros = MESSAGE.powerobjectparm 

il_relacion = luo_parametros.il_relacion 


wf_carga_datos() 
COMMIT USING gtr_sce; 
end event

type cbx_error from checkbox within w_reporte_documentos
integer x = 3035
integer y = 96
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Con Error"
boolean checked = true
end type

event clicked;wf_filtra()
end event

type cbx_correcto from checkbox within w_reporte_documentos
integer x = 2519
integer y = 96
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Correctos "
boolean checked = true
end type

event clicked;wf_filtra()
end event

type cb_salir from commandbutton within w_reporte_documentos
integer x = 4475
integer y = 68
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;
CLOSE(PARENT)  




end event

type cb_imprimir from commandbutton within w_reporte_documentos
integer x = 4046
integer y = 68
integer width = 402
integer height = 112
integer taborder = 20
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

type dw_reporte from datawindow within w_reporte_documentos
integer x = 91
integer y = 244
integer width = 4827
integer height = 2024
integer taborder = 10
string title = "none"
string dataobject = "dw_e_documento_gen_reporte"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_reporte_documentos
integer x = 2418
integer y = 20
integer width = 1106
integer height = 188
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Estatus de Documentos: "
end type

