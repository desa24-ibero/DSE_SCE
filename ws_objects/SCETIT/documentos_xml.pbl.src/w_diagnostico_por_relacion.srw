$PBExportHeader$w_diagnostico_por_relacion.srw
forward
global type w_diagnostico_por_relacion from window
end type
type rb_licenciatura from radiobutton within w_diagnostico_por_relacion
end type
type rb_posgrado from radiobutton within w_diagnostico_por_relacion
end type
type rb_tsu from radiobutton within w_diagnostico_por_relacion
end type
type st_5 from statictext within w_diagnostico_por_relacion
end type
type st_4 from statictext within w_diagnostico_por_relacion
end type
type sle_fecha_final from singlelineedit within w_diagnostico_por_relacion
end type
type sle_fecha_inicial from singlelineedit within w_diagnostico_por_relacion
end type
type st_3 from statictext within w_diagnostico_por_relacion
end type
type cb_excel from commandbutton within w_diagnostico_por_relacion
end type
type dw_1 from datawindow within w_diagnostico_por_relacion
end type
type cb_1 from commandbutton within w_diagnostico_por_relacion
end type
type st_1 from statictext within w_diagnostico_por_relacion
end type
type ddlb_anios from dropdownlistbox within w_diagnostico_por_relacion
end type
type gb_1 from groupbox within w_diagnostico_por_relacion
end type
type dw_relacion from datawindow within w_diagnostico_por_relacion
end type
type gb_2 from groupbox within w_diagnostico_por_relacion
end type
type gb_3 from groupbox within w_diagnostico_por_relacion
end type
end forward

global type w_diagnostico_por_relacion from window
integer width = 5545
integer height = 2804
boolean titlebar = true
string title = "Diagnóstico por Relación"
string menuname = "m_genera_documento_alumno"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
rb_licenciatura rb_licenciatura
rb_posgrado rb_posgrado
rb_tsu rb_tsu
st_5 st_5
st_4 st_4
sle_fecha_final sle_fecha_final
sle_fecha_inicial sle_fecha_inicial
st_3 st_3
cb_excel cb_excel
dw_1 dw_1
cb_1 cb_1
st_1 st_1
ddlb_anios ddlb_anios
gb_1 gb_1
dw_relacion dw_relacion
gb_2 gb_2
gb_3 gb_3
end type
global w_diagnostico_por_relacion w_diagnostico_por_relacion

type variables
Int				ii_anio_proceso_relacion_de_titulacion
String			is_nivel
DateTime	id_fecha_ini
DateTime	id_fecha_fin

DataWindowChild idddw_relacion
end variables

forward prototypes
public function integer wf_obtener_relaciones ()
end prototypes

public function integer wf_obtener_relaciones ();IF ( Not IsNull ( is_nivel ) and is_nivel <> "" ) and ii_anio_proceso_relacion_de_titulacion <> 0 THEN
	gtr_sce.AutoCommit = True
	
	idddw_relacion.Retrieve ( ii_anio_proceso_relacion_de_titulacion , is_nivel )
	
	IF idddw_relacion.RowCount ( ) = 0 THEN
		MessageBox ( "Aviso:" , "No existen relaciones para los criterios seleccionados." )
	END IF
	
	dw_relacion.Reset ( )

	IF idddw_relacion.RowCount ( ) > 0 THEN
		dw_relacion.InsertRow ( 0 )
	END IF
	
	gtr_sce.AutoCommit = False
	
	sle_fecha_inicial.Text = ''
	sle_fecha_final.Text = ''
	
END IF

Return 1
end function

on w_diagnostico_por_relacion.create
if this.MenuName = "m_genera_documento_alumno" then this.MenuID = create m_genera_documento_alumno
this.rb_licenciatura=create rb_licenciatura
this.rb_posgrado=create rb_posgrado
this.rb_tsu=create rb_tsu
this.st_5=create st_5
this.st_4=create st_4
this.sle_fecha_final=create sle_fecha_final
this.sle_fecha_inicial=create sle_fecha_inicial
this.st_3=create st_3
this.cb_excel=create cb_excel
this.dw_1=create dw_1
this.cb_1=create cb_1
this.st_1=create st_1
this.ddlb_anios=create ddlb_anios
this.gb_1=create gb_1
this.dw_relacion=create dw_relacion
this.gb_2=create gb_2
this.gb_3=create gb_3
this.Control[]={this.rb_licenciatura,&
this.rb_posgrado,&
this.rb_tsu,&
this.st_5,&
this.st_4,&
this.sle_fecha_final,&
this.sle_fecha_inicial,&
this.st_3,&
this.cb_excel,&
this.dw_1,&
this.cb_1,&
this.st_1,&
this.ddlb_anios,&
this.gb_1,&
this.dw_relacion,&
this.gb_2,&
this.gb_3}
end on

on w_diagnostico_por_relacion.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_licenciatura)
destroy(this.rb_posgrado)
destroy(this.rb_tsu)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.sle_fecha_final)
destroy(this.sle_fecha_inicial)
destroy(this.st_3)
destroy(this.cb_excel)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.ddlb_anios)
destroy(this.gb_1)
destroy(this.dw_relacion)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;Int		li_anio_actual, li_anio_anterior
Int		li_contador
Int		li_codigo_retorno

SELECT	TOP 1 DatePart ( year , GetDate ( ) )
Into		:li_anio_actual
FROM		periodos_por_procesos
USING	gtr_sce;

IF gtr_sce.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De base de datos al obtener el año actual.~n~r~n~r Mensaje de base de datos: " +  gtr_sce.SQLErrText , StopSign!)
	Return
END IF

IF li_anio_actual = 0 THEN
	MessageBox ( "Error:" , "No fue posible obtener el año actual" , StopSign!)
	Return
END IF

li_anio_anterior = li_anio_actual
FOR li_contador = 1 TO 30
	ddlb_anios.AddItem ( String ( li_anio_anterior ) )
	li_anio_anterior --
NEXT

dw_relacion.SetTransObject ( gtr_sce )

ii_anio_proceso_relacion_de_titulacion = f_obtiene_anio_proc_tit()

ddlb_anios.SelectItem ( String ( ii_anio_proceso_relacion_de_titulacion ) , 0 )
ddlb_anios.TriggerEvent ( SelectionChanged! )

li_codigo_retorno = dw_relacion.GetChild ( 'cve_relacion' , idddw_relacion )
IF li_codigo_retorno = -1 THEN
	MessageBox ( "Error", "No fue posible obtener las relaciones")
ELSE
	idddw_relacion.SetTransObject ( gtr_sce )
END IF

// Inicializar el nivel con L que es el default cuando se abre ésta ventana ...
rb_licenciatura.Checked = True
is_nivel = 'L'

wf_obtener_relaciones ( )
end event

type rb_licenciatura from radiobutton within w_diagnostico_por_relacion
integer x = 3054
integer y = 252
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

event clicked;is_nivel = 'L'

wf_obtener_relaciones ( )
end event

type rb_posgrado from radiobutton within w_diagnostico_por_relacion
integer x = 3054
integer y = 344
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

event clicked;is_nivel = 'P'

wf_obtener_relaciones ( )
end event

type rb_tsu from radiobutton within w_diagnostico_por_relacion
integer x = 3054
integer y = 436
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

event clicked;is_nivel = 'T'

wf_obtener_relaciones ( )
end event

type st_5 from statictext within w_diagnostico_por_relacion
integer x = 1870
integer y = 412
integer width = 407
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Fecha final:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_diagnostico_por_relacion
integer x = 1870
integer y = 272
integer width = 407
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Fecha inicial:"
boolean focusrectangle = false
end type

type sle_fecha_final from singlelineedit within w_diagnostico_por_relacion
integer x = 2304
integer y = 400
integer width = 402
integer height = 104
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type sle_fecha_inicial from singlelineedit within w_diagnostico_por_relacion
integer x = 2304
integer y = 260
integer width = 402
integer height = 104
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_diagnostico_por_relacion
integer x = 1106
integer y = 272
integer width = 261
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Relación:"
boolean focusrectangle = false
end type

type cb_excel from commandbutton within w_diagnostico_por_relacion
integer x = 3813
integer y = 384
integer width = 498
integer height = 112
integer taborder = 90
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

type dw_1 from datawindow within w_diagnostico_por_relacion
integer x = 41
integer y = 664
integer width = 5353
integer height = 1768
integer taborder = 100
string title = "none"
string dataobject = "dw_diagnostico_por_relacion"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;//SelectRow ( 0 , false )
//
//SelectRow ( CurrentRow , true )
end event

type cb_1 from commandbutton within w_diagnostico_por_relacion
integer x = 3813
integer y = 252
integer width = 498
integer height = 112
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;Long		ll_cve_relacion


ll_cve_relacion = dw_relacion.GetItemNumber ( dw_relacion.GetRow ( ) , "cve_relacion" )

IF IsNull ( ll_cve_relacion ) or ll_cve_relacion = 0 THEN
	MessageBox ( "Aviso:" , "Por favor, selecciona la relación" )
	dw_relacion.SetFocus ( )
	Return
END IF

IF is_nivel = "L" or is_nivel = "T" THEN
	dw_1.DataObject = 'dw_diagnostico_por_relacion'
ELSE
	dw_1.DataObject = 'dw_diagnostico_por_relacion_pos'
END IF

gtr_sce.AutoCommit = True

dw_1.Reset ( )

dw_1.SetTransObject ( gtr_sce )
dw_1.Retrieve ( String ( id_fecha_ini ) , String ( id_fecha_fin ) , is_nivel )

gtr_sce.AutoCommit = False

IF dw_1.RowCount ( ) >  0 THEN
	cb_excel.Enabled = True
END IF
end event

type st_1 from statictext within w_diagnostico_por_relacion
integer x = 110
integer y = 332
integer width = 146
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Año:"
boolean focusrectangle = false
end type

type ddlb_anios from dropdownlistbox within w_diagnostico_por_relacion
integer x = 315
integer y = 320
integer width = 480
integer height = 400
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = true
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//uo_relacion.of_carga_control ( gtr_sce, Integer ( Text ) )

ii_anio_proceso_relacion_de_titulacion = Integer ( Text )


wf_obtener_relaciones ( )

end event

type gb_1 from groupbox within w_diagnostico_por_relacion
integer x = 1038
integer y = 160
integer width = 1787
integer height = 392
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Relación"
end type

type dw_relacion from datawindow within w_diagnostico_por_relacion
integer x = 1431
integer y = 260
integer width = 361
integer height = 104
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dw_relaciones_x_anio_nivel"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;id_fecha_ini = idddw_relacion.GetItemDateTime ( idddw_relacion.GetRow ( ) , 'fecha_inicial' )
id_fecha_fin = idddw_relacion.GetItemDateTime ( idddw_relacion.GetRow ( ) , 'ldt_fecha_final' )

sle_fecha_inicial.Text =  String ( id_fecha_ini , "dd/mm/yyyy" ) 
sle_fecha_final.Text = String ( id_fecha_fin , "dd/mm/yyyy" ) 
end event

type gb_2 from groupbox within w_diagnostico_por_relacion
integer x = 2990
integer y = 160
integer width = 603
integer height = 376
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Nivel Documento: "
end type

type gb_3 from groupbox within w_diagnostico_por_relacion
integer x = 27
integer y = 160
integer width = 937
integer height = 392
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
end type

