$PBExportHeader$w_mtto_tipo_grupo_clase.srw
forward
global type w_mtto_tipo_grupo_clase from window
end type
type dw_imprimir from datawindow within w_mtto_tipo_grupo_clase
end type
type cb_imprimir from commandbutton within w_mtto_tipo_grupo_clase
end type
type rb_imprimir_seleccionado from radiobutton within w_mtto_tipo_grupo_clase
end type
type rb_imprimir_s_descripciones from radiobutton within w_mtto_tipo_grupo_clase
end type
type rb_imprimir_c_descripciones from radiobutton within w_mtto_tipo_grupo_clase
end type
type dw_descripcion from datawindow within w_mtto_tipo_grupo_clase
end type
type dw_tipos_grupo_clase from datawindow within w_mtto_tipo_grupo_clase
end type
type gb_1 from groupbox within w_mtto_tipo_grupo_clase
end type
type gb_2 from groupbox within w_mtto_tipo_grupo_clase
end type
end forward

global type w_mtto_tipo_grupo_clase from window
integer width = 3337
integer height = 2048
boolean titlebar = true
string title = "Mantenimiento a Tipos Grupo Clase ..."
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_imprimir dw_imprimir
cb_imprimir cb_imprimir
rb_imprimir_seleccionado rb_imprimir_seleccionado
rb_imprimir_s_descripciones rb_imprimir_s_descripciones
rb_imprimir_c_descripciones rb_imprimir_c_descripciones
dw_descripcion dw_descripcion
dw_tipos_grupo_clase dw_tipos_grupo_clase
gb_1 gb_1
gb_2 gb_2
end type
global w_mtto_tipo_grupo_clase w_mtto_tipo_grupo_clase

on w_mtto_tipo_grupo_clase.create
this.dw_imprimir=create dw_imprimir
this.cb_imprimir=create cb_imprimir
this.rb_imprimir_seleccionado=create rb_imprimir_seleccionado
this.rb_imprimir_s_descripciones=create rb_imprimir_s_descripciones
this.rb_imprimir_c_descripciones=create rb_imprimir_c_descripciones
this.dw_descripcion=create dw_descripcion
this.dw_tipos_grupo_clase=create dw_tipos_grupo_clase
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.dw_imprimir,&
this.cb_imprimir,&
this.rb_imprimir_seleccionado,&
this.rb_imprimir_s_descripciones,&
this.rb_imprimir_c_descripciones,&
this.dw_descripcion,&
this.dw_tipos_grupo_clase,&
this.gb_1,&
this.gb_2}
end on

on w_mtto_tipo_grupo_clase.destroy
destroy(this.dw_imprimir)
destroy(this.cb_imprimir)
destroy(this.rb_imprimir_seleccionado)
destroy(this.rb_imprimir_s_descripciones)
destroy(this.rb_imprimir_c_descripciones)
destroy(this.dw_descripcion)
destroy(this.dw_tipos_grupo_clase)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;dw_tipos_grupo_clase.SetTransObject ( gtr_sce )
dw_tipos_grupo_clase.Retrieve ( )

dw_descripcion.SetTransObject ( gtr_sce ) 
end event

type dw_imprimir from datawindow within w_mtto_tipo_grupo_clase
boolean visible = false
integer x = 421
integer y = 700
integer width = 2048
integer height = 988
integer taborder = 30
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_imprimir from commandbutton within w_mtto_tipo_grupo_clase
integer x = 2642
integer y = 112
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Imprimir"
end type

event clicked;Int		li_cve_tipo_grupo_clase

IF dw_tipos_grupo_clase.RowCount ( ) = 0 THEN
	Return;
END IF

PrintSetup ( )

IF rb_imprimir_c_descripciones.Checked THEN
	dw_imprimir.DataObject = 'dw_reporte_tipos_gpo_clase_c_descripcion'
	dw_imprimir.SettransObject ( gtr_sce )
	
	dw_imprimir.Retrieve ( )
	dw_imprimir.Print ( )
END IF

IF rb_imprimir_s_descripciones.Checked THEN
	dw_imprimir.DataObject = 'dw_reporte_tipos_gpo_clase_s_descripcion'
	dw_imprimir.SettransObject ( gtr_sce )
	
	dw_imprimir.Retrieve ( )
	dw_imprimir.Print ( )
END IF

IF rb_imprimir_seleccionado.Checked THEN
	li_cve_tipo_grupo_clase = dw_tipos_grupo_clase.Object.cve_tipo_grupo_clase [ dw_tipos_grupo_clase.GetRow ( ) ]
	
	dw_imprimir.DataObject = 'dw_reporte_tipos_gpo_clase_c_filtro'
	dw_imprimir.SettransObject ( gtr_sce )
	
	dw_imprimir.Retrieve ( li_cve_tipo_grupo_clase )
	dw_imprimir.Print ( )
END IF
end event

type rb_imprimir_seleccionado from radiobutton within w_mtto_tipo_grupo_clase
integer x = 1184
integer y = 128
integer width = 1312
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Imprimir el Tipo de Grupo - Clase seleccionado"
end type

type rb_imprimir_s_descripciones from radiobutton within w_mtto_tipo_grupo_clase
integer x = 224
integer y = 220
integer width = 786
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Imprimir sin descripciones"
end type

type rb_imprimir_c_descripciones from radiobutton within w_mtto_tipo_grupo_clase
integer x = 224
integer y = 128
integer width = 786
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Imprimir con descripciones"
boolean checked = true
end type

type dw_descripcion from datawindow within w_mtto_tipo_grupo_clase
boolean visible = false
integer x = 219
integer y = 572
integer width = 2537
integer height = 1132
integer taborder = 30
string title = "none"
string dataobject = "dw_descripcion_tipo_grupo_clase"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;Int		li_cve_tipo_grupo_clase

IF DWO.name = 'b_almacenar' THEN
	
	li_cve_tipo_grupo_clase = Object.cve_tipo_grupo_clase [ Row ]
	
	dw_tipos_grupo_clase.SetFilter ( "" )
	dw_tipos_grupo_clase.Filter ( )
	
	dw_tipos_grupo_clase.SetSort ("#1 A")
	dw_tipos_grupo_clase.Sort (  )
	
	dw_tipos_grupo_clase.SetRow ( li_cve_tipo_grupo_clase )
	
	Visible = False
	
	IF Update ( ) = 1 THEN
		
		Commit Using gtr_sce;
		
		MessageBox ( "Aviso:" , "La descripción se almacenó de forma correcta ... " )
		
	END IF
	
	Reset (  )
	
	dw_tipos_grupo_clase.SetFocus ( )
	
END IF

IF DWO.name = 'b_regresar' THEN
	
	li_cve_tipo_grupo_clase = Object.cve_tipo_grupo_clase [ Row ]
	
	dw_tipos_grupo_clase.SetFilter ( "" )
	dw_tipos_grupo_clase.Filter ( )
	
	dw_tipos_grupo_clase.SetSort ("#1 A")
	dw_tipos_grupo_clase.Sort (  )
	
	dw_tipos_grupo_clase.SetRow ( li_cve_tipo_grupo_clase )
	
	Visible = False
	
	Reset (  )
	
	dw_tipos_grupo_clase.SetFocus ( )
	
END IF
end event

event getfocus;// Esto es para que lo que se escriba sea editable y aparezca dentro del área visual
// es lo mejor que encontre ...
//Object.descripcion.RightToLeft	= 1
end event

event losefocus;//Object.descripcion.RightToLeft	= 0
end event

type dw_tipos_grupo_clase from datawindow within w_mtto_tipo_grupo_clase
integer x = 219
integer y = 428
integer width = 2537
integer height = 1276
integer taborder = 20
string title = "none"
string dataobject = "dw_tipos_grupo_clase"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;SelectRow ( 0 , False )

SelectRow ( CurrentRow , True )
end event

event buttonclicked;Int		li_cve_tipo_grupo_clase

IF DWO.name = 'b_1' THEN
	
	li_cve_tipo_grupo_clase = Object.cve_tipo_grupo_clase [ GetRow ( ) ]

	SetFilter ( "cve_tipo_grupo_clase = " + String ( li_cve_tipo_grupo_clase ) )
	Filter ( )
	
	dw_descripcion.Visible = True
	
	dw_descripcion.Retrieve ( li_cve_tipo_grupo_clase )
	
//	dw_descripcion.SetFocus ( )
END IF
end event

type gb_1 from groupbox within w_mtto_tipo_grupo_clase
integer x = 105
integer y = 328
integer width = 3035
integer height = 1444
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within w_mtto_tipo_grupo_clase
integer x = 105
integer y = 44
integer width = 3035
integer height = 280
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Opciones de Impresión"
end type

