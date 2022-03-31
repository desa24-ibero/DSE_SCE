$PBExportHeader$w_cuadros_evaluacion.srw
forward
global type w_cuadros_evaluacion from window
end type
type ddlb_periodo_ibero from dropdownlistbox within w_cuadros_evaluacion
end type
type st_4 from statictext within w_cuadros_evaluacion
end type
type dw_siglas from datawindow within w_cuadros_evaluacion
end type
type ddlb_periodo from dropdownlistbox within w_cuadros_evaluacion
end type
type ddlb_anio from dropdownlistbox within w_cuadros_evaluacion
end type
type st_3 from statictext within w_cuadros_evaluacion
end type
type st_2 from statictext within w_cuadros_evaluacion
end type
type st_1 from statictext within w_cuadros_evaluacion
end type
type dw_carrera from datawindow within w_cuadros_evaluacion
end type
type p_logo_ibero from picture within w_cuadros_evaluacion
end type
type cb_imprimir from commandbutton within w_cuadros_evaluacion
end type
type cb_1 from commandbutton within w_cuadros_evaluacion
end type
type dw_1 from datawindow within w_cuadros_evaluacion
end type
type gb_1 from groupbox within w_cuadros_evaluacion
end type
end forward

global type w_cuadros_evaluacion from window
integer width = 4590
integer height = 2644
boolean titlebar = true
string title = "Generación de Cuadros de Evaluación"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
ddlb_periodo_ibero ddlb_periodo_ibero
st_4 st_4
dw_siglas dw_siglas
ddlb_periodo ddlb_periodo
ddlb_anio ddlb_anio
st_3 st_3
st_2 st_2
st_1 st_1
dw_carrera dw_carrera
p_logo_ibero p_logo_ibero
cb_imprimir cb_imprimir
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_cuadros_evaluacion w_cuadros_evaluacion

on w_cuadros_evaluacion.create
this.ddlb_periodo_ibero=create ddlb_periodo_ibero
this.st_4=create st_4
this.dw_siglas=create dw_siglas
this.ddlb_periodo=create ddlb_periodo
this.ddlb_anio=create ddlb_anio
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.dw_carrera=create dw_carrera
this.p_logo_ibero=create p_logo_ibero
this.cb_imprimir=create cb_imprimir
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.ddlb_periodo_ibero,&
this.st_4,&
this.dw_siglas,&
this.ddlb_periodo,&
this.ddlb_anio,&
this.st_3,&
this.st_2,&
this.st_1,&
this.dw_carrera,&
this.p_logo_ibero,&
this.cb_imprimir,&
this.cb_1,&
this.dw_1,&
this.gb_1}
end on

on w_cuadros_evaluacion.destroy
destroy(this.ddlb_periodo_ibero)
destroy(this.st_4)
destroy(this.dw_siglas)
destroy(this.ddlb_periodo)
destroy(this.ddlb_anio)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_carrera)
destroy(this.p_logo_ibero)
destroy(this.cb_imprimir)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;Int		li_anio_actual

dw_siglas.SetTransObject ( gtr_sce )

dw_carrera.SetTransObject ( gtr_sce )
dw_carrera.Retrieve ( )


SELECT	DatePart ( year , getdate () ) 
INTO		:li_anio_actual
FROM		dummy
USING	gtr_sce;

ddlb_anio.SelectItem ( String ( li_anio_actual ) , 0 )
end event

type ddlb_periodo_ibero from dropdownlistbox within w_cuadros_evaluacion
integer x = 3762
integer y = 648
integer width = 480
integer height = 400
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string item[] = {"Trimestre I","Trimestre II","Trimestre III","Trimestre IV"}
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_cuadros_evaluacion
integer x = 3296
integer y = 664
integer width = 430
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Periodo Ibero:"
boolean focusrectangle = false
end type

type dw_siglas from datawindow within w_cuadros_evaluacion
boolean visible = false
integer x = 3607
integer y = 1020
integer width = 645
integer height = 380
integer taborder = 20
string title = "none"
string dataobject = "dw_siglas_mat_cuadros_eval"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type ddlb_periodo from dropdownlistbox within w_cuadros_evaluacion
integer x = 3762
integer y = 524
integer width = 480
integer height = 400
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"1","2","3","4","5","6","7","8"}
borderstyle borderstyle = stylelowered!
end type

type ddlb_anio from dropdownlistbox within w_cuadros_evaluacion
integer x = 3762
integer y = 400
integer width = 480
integer height = 400
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017","2018","2019","2020","2021","2022","2023","2024","2025","2026","2027","2028","2029","2030","2031","2032","2033","2034","2035","2036","2037","2038","2039","2040","2041"}
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_cuadros_evaluacion
integer x = 3296
integer y = 540
integer width = 398
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Periodo SEP:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_cuadros_evaluacion
integer x = 3296
integer y = 412
integer width = 187
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Año:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_cuadros_evaluacion
integer x = 279
integer y = 392
integer width = 905
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleccione la carrera:"
boolean focusrectangle = false
end type

type dw_carrera from datawindow within w_cuadros_evaluacion
integer x = 270
integer y = 500
integer width = 2811
integer height = 396
integer taborder = 20
string title = "none"
string dataobject = "dddw_carreras_plan_estatal"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;This.SelectRow(0, false)
This.SelectRow(CurrentRow, true)
end event

type p_logo_ibero from picture within w_cuadros_evaluacion
integer x = 59
integer y = 8
integer width = 686
integer height = 264
boolean originalsize = true
string picturename = "C:\Sourcesafe\MIGRACION 2009\SCESSE\anEscudo-Logo_Tijuana.png"
boolean focusrectangle = false
end type

type cb_imprimir from commandbutton within w_cuadros_evaluacion
integer x = 3392
integer y = 2364
integer width = 489
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Imprimir"
end type

event clicked;dw_1.Print ( )
end event

type cb_1 from commandbutton within w_cuadros_evaluacion
integer x = 3767
integer y = 784
integer width = 489
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar Reporte"
end type

event clicked;Int			li_anio
int			li_periodo
Int			li_cve_carrera
Int			li_cve_plan
String		ls_sigla
Int			li_contador
Int			ls_renglon_selecionado
String		ls_periodo_ibero
Int			li_periodo_ibero
Int			li_total_materias

ls_renglon_selecionado = dw_carrera.GetRow ( )

IF ddlb_periodo.Text = '' OR IsNull ( ddlb_periodo.Text ) THEN
	MessageBox ( "Aviso:" , "Por favor, selecciones el periodo SEP" )
	ddlb_periodo.SetFocus ( )
	Return
END IF

IF  ddlb_periodo_ibero.Text = '' OR IsNull (  ddlb_periodo_ibero.Text ) THEN
	MessageBox ( "Aviso:" , "Por favor, selecciones el periodo Ibero" )
	ddlb_periodo_ibero.SetFocus ( )
	Return
END IF

li_anio				= Integer ( ddlb_anio.Text )
li_periodo			= Integer ( ddlb_periodo.Text )
li_cve_carrera		= dw_carrera.Object.carreras_cve_carrera [ ls_renglon_selecionado ]
li_cve_plan			= dw_carrera.Object.carreras_cve_plan_ofertado [ ls_renglon_selecionado ]
ls_periodo_ibero	= ddlb_periodo_ibero.Text

dw_1.Reset ( )
dw_siglas.Reset ( )

gtr_sce.AutoCommit = True

dw_siglas.Retrieve ( li_anio , li_periodo , li_cve_carrera , li_cve_plan )
li_total_materias = dw_siglas.RowCount ( )

CHOOSE CASE	 ls_periodo_ibero
	CASE 'Trimestre I'
		li_periodo_ibero = 3
	CASE 'Trimestre II'
		li_periodo_ibero = 4
	CASE 'Trimestre III'
		li_periodo_ibero = 5
	CASE 'Trimestre IV'
		li_periodo_ibero = 6
END CHOOSE

CHOOSE CASE	 li_total_materias
	CASE 1
		dw_1.DataObject = 'dw_cuadros_evaluacion_1'
	CASE 2
		dw_1.DataObject = 'dw_cuadros_evaluacion_2'
	CASE 3
		dw_1.DataObject = 'dw_cuadros_evaluacion_3'
	CASE 4
		dw_1.DataObject = 'dw_cuadros_evaluacion_4'
	CASE 5
		dw_1.DataObject = 'dw_cuadros_evaluacion_5'
	CASE 6
		dw_1.DataObject = 'dw_cuadros_evaluacion_6'
	CASE 7
		dw_1.DataObject = 'dw_cuadros_evaluacion_7'
	CASE 8
		dw_1.DataObject = 'dw_cuadros_evaluacion_8'
	CASE 9
		dw_1.DataObject = 'dw_cuadros_evaluacion_9'
END CHOOSE

dw_1.SetTransObject ( gtr_sce )

IF li_total_materias = 0 THEN
	gtr_sce.AutoCommit = False
	MessageBox ( "Aviso:" , "No se encontró información con los criterios especificados." )
	Return
END IF

FOR li_contador = 1 TO li_total_materias
	
	ls_sigla = dw_siglas.Object.sigla [ li_contador ]
	
	CHOOSE CASE	 li_contador
		CASE 1
			dw_1.Object.t_sigla_1.Text = ls_sigla
		CASE 2
			dw_1.Object.t_sigla_2.Text = ls_sigla
		CASE 3
			dw_1.Object.t_sigla_3.Text = ls_sigla
		CASE 4
			dw_1.Object.t_sigla_4.Text = ls_sigla
		CASE 5
			dw_1.Object.t_sigla_5.Text = ls_sigla
		CASE 6
			dw_1.Object.t_sigla_6.Text = ls_sigla
		CASE 7
			dw_1.Object.t_sigla_7.Text = ls_sigla
		CASE 8
			dw_1.Object.t_sigla_8.Text = ls_sigla
		CASE 9
			dw_1.Object.t_sigla_9.Text = ls_sigla
	END CHOOSE
NEXT

dw_1.Retrieve ( li_anio , li_periodo , li_cve_carrera , li_cve_plan , li_periodo_ibero )

gtr_sce.AutoCommit = False

IF dw_1.RowCount ( ) > 0 THEN
	cb_imprimir.Enabled = True
ELSE
	cb_imprimir.Enabled = False
END IF
end event

type dw_1 from datawindow within w_cuadros_evaluacion
integer x = 215
integer y = 960
integer width = 4105
integer height = 1352
integer taborder = 10
string title = "none"
string dataobject = "dw_cuadros_evaluacion_1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_cuadros_evaluacion
integer x = 215
integer y = 316
integer width = 4105
integer height = 620
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

