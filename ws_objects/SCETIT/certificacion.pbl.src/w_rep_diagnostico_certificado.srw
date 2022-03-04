$PBExportHeader$w_rep_diagnostico_certificado.srw
forward
global type w_rep_diagnostico_certificado from window
end type
type cb_1 from commandbutton within w_rep_diagnostico_certificado
end type
type cb_excel from commandbutton within w_rep_diagnostico_certificado
end type
type dw_1 from datawindow within w_rep_diagnostico_certificado
end type
type rb_licenciatura from radiobutton within w_rep_diagnostico_certificado
end type
type rb_posgrado from radiobutton within w_rep_diagnostico_certificado
end type
type rb_tsu from radiobutton within w_rep_diagnostico_certificado
end type
type rb_totales from radiobutton within w_rep_diagnostico_certificado
end type
type rb_parciales from radiobutton within w_rep_diagnostico_certificado
end type
type em_fecha_inicial from editmask within w_rep_diagnostico_certificado
end type
type em_fecha_final from editmask within w_rep_diagnostico_certificado
end type
type st_fecha_final from statictext within w_rep_diagnostico_certificado
end type
type st_fecha_inicial from statictext within w_rep_diagnostico_certificado
end type
type rb_simple from radiobutton within w_rep_diagnostico_certificado
end type
type rb_legalizado from radiobutton within w_rep_diagnostico_certificado
end type
type gb_1 from groupbox within w_rep_diagnostico_certificado
end type
type gb_tipo from groupbox within w_rep_diagnostico_certificado
end type
type gb_fechas from groupbox within w_rep_diagnostico_certificado
end type
type gb_papeleria from groupbox within w_rep_diagnostico_certificado
end type
end forward

global type w_rep_diagnostico_certificado from window
integer width = 7022
integer height = 2948
boolean titlebar = true
string title = "Reporte de diagnóstico de Certificados"
string menuname = "m_genera_documento_alumno"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
cb_excel cb_excel
dw_1 dw_1
rb_licenciatura rb_licenciatura
rb_posgrado rb_posgrado
rb_tsu rb_tsu
rb_totales rb_totales
rb_parciales rb_parciales
em_fecha_inicial em_fecha_inicial
em_fecha_final em_fecha_final
st_fecha_final st_fecha_final
st_fecha_inicial st_fecha_inicial
rb_simple rb_simple
rb_legalizado rb_legalizado
gb_1 gb_1
gb_tipo gb_tipo
gb_fechas gb_fechas
gb_papeleria gb_papeleria
end type
global w_rep_diagnostico_certificado w_rep_diagnostico_certificado

on w_rep_diagnostico_certificado.create
if this.MenuName = "m_genera_documento_alumno" then this.MenuID = create m_genera_documento_alumno
this.cb_1=create cb_1
this.cb_excel=create cb_excel
this.dw_1=create dw_1
this.rb_licenciatura=create rb_licenciatura
this.rb_posgrado=create rb_posgrado
this.rb_tsu=create rb_tsu
this.rb_totales=create rb_totales
this.rb_parciales=create rb_parciales
this.em_fecha_inicial=create em_fecha_inicial
this.em_fecha_final=create em_fecha_final
this.st_fecha_final=create st_fecha_final
this.st_fecha_inicial=create st_fecha_inicial
this.rb_simple=create rb_simple
this.rb_legalizado=create rb_legalizado
this.gb_1=create gb_1
this.gb_tipo=create gb_tipo
this.gb_fechas=create gb_fechas
this.gb_papeleria=create gb_papeleria
this.Control[]={this.cb_1,&
this.cb_excel,&
this.dw_1,&
this.rb_licenciatura,&
this.rb_posgrado,&
this.rb_tsu,&
this.rb_totales,&
this.rb_parciales,&
this.em_fecha_inicial,&
this.em_fecha_final,&
this.st_fecha_final,&
this.st_fecha_inicial,&
this.rb_simple,&
this.rb_legalizado,&
this.gb_1,&
this.gb_tipo,&
this.gb_fechas,&
this.gb_papeleria}
end on

on w_rep_diagnostico_certificado.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.cb_excel)
destroy(this.dw_1)
destroy(this.rb_licenciatura)
destroy(this.rb_posgrado)
destroy(this.rb_tsu)
destroy(this.rb_totales)
destroy(this.rb_parciales)
destroy(this.em_fecha_inicial)
destroy(this.em_fecha_final)
destroy(this.st_fecha_final)
destroy(this.st_fecha_inicial)
destroy(this.rb_simple)
destroy(this.rb_legalizado)
destroy(this.gb_1)
destroy(this.gb_tipo)
destroy(this.gb_fechas)
destroy(this.gb_papeleria)
end on

event open;x=1
y=1
end event

type cb_1 from commandbutton within w_rep_diagnostico_certificado
integer x = 3561
integer y = 68
integer width = 498
integer height = 112
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;Date	ld_fecha_inicial
Date	ld_fecha_final
String	ls_nivel []
Int		li_cve_doc_control_sep
Int		li_legalizado

// Verificar las fechas ...
IF em_fecha_inicial.Text = 'none' or IsNull ( em_fecha_final.Text ) or em_fecha_final.Text = "" THEN
	MessageBox ( "Aviso:" , "Por favor, escribe la fecha inicial" )
	em_fecha_inicial.SetFocus ( )
	
	Return
END IF

IF em_fecha_final.Text = 'none'  or IsNull (em_fecha_final.Text ) or em_fecha_final.Text = "" THEN
	MessageBox ( "Aviso:" , "Por favor, escribe la fecha final" )
	em_fecha_final.SetFocus ( )
	
	Return
END IF

ld_fecha_inicial = Date ( em_fecha_inicial.Text )
ld_fecha_final = Date ( em_fecha_final.Text )

IF ld_fecha_final < ld_fecha_inicial THEN
	MessageBox ( "Error de fechas" , "La fecha inicial no debe ser mayor a la fecha final" )
	em_fecha_inicial.SetFocus ( )
	
	Return
END IF

// Verificar el nivel ...
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

// Verificar el tipo ...
IF rb_totales.CHECKED THEN 
	li_cve_doc_control_sep = 1 
ELSEIF rb_parciales.CHECKED THEN 
	li_cve_doc_control_sep = 2 
END IF

// Verificar si es legalizado ...
IF rb_legalizado.CHECKED  THEN 
	li_legalizado = 1 
ELSEIF rb_simple.CHECKED THEN 
	li_legalizado = 0
END IF
	
dw_1.Reset ( )
dw_1.SetTransObject ( gtr_sce )
dw_1.Retrieve ( ld_fecha_inicial , ld_fecha_final , ls_nivel [] , li_cve_doc_control_sep , li_legalizado )

// Escribir los textos de los encabezados ...
dw_1.Object.t_rangos_fecha.Text = String ( ld_fecha_inicial ) + ' A ' + String ( ld_fecha_final )

IF rb_licenciatura.CHECKED THEN 
	dw_1.Object.t_nivel.Text = 'Licenciatura'
ELSEIF rb_posgrado.CHECKED THEN 
	dw_1.Object.t_nivel.Text = 'Posgrado'
ELSEIF rb_tsu.CHECKED THEN 
	dw_1.Object.t_nivel.Text = 'TSU'
END IF 

IF rb_totales.CHECKED THEN 
	dw_1.Object.t_tipo.Text = 'Totales'
ELSEIF rb_parciales.CHECKED THEN 
	dw_1.Object.t_tipo.Text = 'Parciales'
END IF

IF rb_legalizado.CHECKED  THEN 
	dw_1.Object.t_papeleria.Text = 'Legalizado'
ELSEIF rb_simple.CHECKED THEN 
	dw_1.Object.t_papeleria.Text = 'Simple'
END IF

IF dw_1.RowCount ( ) >  0 THEN
	cb_excel.Enabled = True
END IF
end event

type cb_excel from commandbutton within w_rep_diagnostico_certificado
integer x = 3561
integer y = 200
integer width = 498
integer height = 112
integer taborder = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Exportar a Excel"
end type

event clicked;dw_1.SaveAs ( "" , Excel! , True )
end event

type dw_1 from datawindow within w_rep_diagnostico_certificado
integer x = 169
integer y = 600
integer width = 6377
integer height = 1820
integer taborder = 90
string title = "none"
string dataobject = "dw_rep_diagnostico_certificado"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_licenciatura from radiobutton within w_rep_diagnostico_certificado
integer x = 1600
integer y = 136
integer width = 402
integer height = 80
integer taborder = 30
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

type rb_posgrado from radiobutton within w_rep_diagnostico_certificado
integer x = 1600
integer y = 228
integer width = 402
integer height = 80
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Posgrado"
end type

type rb_tsu from radiobutton within w_rep_diagnostico_certificado
integer x = 1600
integer y = 320
integer width = 402
integer height = 80
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "TSU"
end type

type rb_totales from radiobutton within w_rep_diagnostico_certificado
integer x = 2235
integer y = 144
integer width = 338
integer height = 64
integer taborder = 60
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

type rb_parciales from radiobutton within w_rep_diagnostico_certificado
integer x = 2235
integer y = 236
integer width = 338
integer height = 64
integer taborder = 70
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

type em_fecha_inicial from editmask within w_rep_diagnostico_certificado
integer x = 709
integer y = 140
integer width = 503
integer height = 88
integer taborder = 10
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

type em_fecha_final from editmask within w_rep_diagnostico_certificado
integer x = 704
integer y = 256
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

type st_fecha_final from statictext within w_rep_diagnostico_certificado
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

type st_fecha_inicial from statictext within w_rep_diagnostico_certificado
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

type rb_simple from radiobutton within w_rep_diagnostico_certificado
integer x = 2738
integer y = 236
integer width = 325
integer height = 64
integer taborder = 100
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

type rb_legalizado from radiobutton within w_rep_diagnostico_certificado
integer x = 2738
integer y = 140
integer width = 416
integer height = 76
integer taborder = 80
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

type gb_1 from groupbox within w_rep_diagnostico_certificado
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

type gb_tipo from groupbox within w_rep_diagnostico_certificado
integer x = 2199
integer y = 48
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

type gb_fechas from groupbox within w_rep_diagnostico_certificado
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

type gb_papeleria from groupbox within w_rep_diagnostico_certificado
integer x = 2697
integer y = 48
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

