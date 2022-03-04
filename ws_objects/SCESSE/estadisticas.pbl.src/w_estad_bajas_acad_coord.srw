$PBExportHeader$w_estad_bajas_acad_coord.srw
forward
global type w_estad_bajas_acad_coord from window
end type
type uo_periodo from uo_periodo_variable_tipos within w_estad_bajas_acad_coord
end type
type uo_coordinacion from uo_coordinaciones within w_estad_bajas_acad_coord
end type
type gb_coordinacion from groupbox within w_estad_bajas_acad_coord
end type
type st_3 from statictext within w_estad_bajas_acad_coord
end type
type dw_estadisticas from datawindow within w_estad_bajas_acad_coord
end type
type cb_1 from commandbutton within w_estad_bajas_acad_coord
end type
type em_anio from editmask within w_estad_bajas_acad_coord
end type
type dw_1x from datawindow within w_estad_bajas_acad_coord
end type
type gb_8 from groupbox within w_estad_bajas_acad_coord
end type
type gb_11 from groupbox within w_estad_bajas_acad_coord
end type
type gb_20 from groupbox within w_estad_bajas_acad_coord
end type
type gb_1 from groupbox within w_estad_bajas_acad_coord
end type
end forward

global type w_estad_bajas_acad_coord from window
integer width = 3666
integer height = 1980
boolean titlebar = true
string title = "Estadística de Bajas Académicas por Coordinación"
string menuname = "m_estad_alum_mat"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
uo_periodo uo_periodo
uo_coordinacion uo_coordinacion
gb_coordinacion gb_coordinacion
st_3 st_3
dw_estadisticas dw_estadisticas
cb_1 cb_1
em_anio em_anio
dw_1x dw_1x
gb_8 gb_8
gb_11 gb_11
gb_20 gb_20
gb_1 gb_1
end type
global w_estad_bajas_acad_coord w_estad_bajas_acad_coord

type variables
int periodo_x
end variables

on w_estad_bajas_acad_coord.create
if this.MenuName = "m_estad_alum_mat" then this.MenuID = create m_estad_alum_mat
this.uo_periodo=create uo_periodo
this.uo_coordinacion=create uo_coordinacion
this.gb_coordinacion=create gb_coordinacion
this.st_3=create st_3
this.dw_estadisticas=create dw_estadisticas
this.cb_1=create cb_1
this.em_anio=create em_anio
this.dw_1x=create dw_1x
this.gb_8=create gb_8
this.gb_11=create gb_11
this.gb_20=create gb_20
this.gb_1=create gb_1
this.Control[]={this.uo_periodo,&
this.uo_coordinacion,&
this.gb_coordinacion,&
this.st_3,&
this.dw_estadisticas,&
this.cb_1,&
this.em_anio,&
this.dw_1x,&
this.gb_8,&
this.gb_11,&
this.gb_20,&
this.gb_1}
end on

on w_estad_bajas_acad_coord.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_periodo)
destroy(this.uo_coordinacion)
destroy(this.gb_coordinacion)
destroy(this.st_3)
destroy(this.dw_estadisticas)
destroy(this.cb_1)
destroy(this.em_anio)
destroy(this.dw_1x)
destroy(this.gb_8)
destroy(this.gb_11)
destroy(this.gb_20)
destroy(this.gb_1)
end on

event open;this.x=1
this.y=1


THIS.uo_periodo.of_inicializa_servicio("V", "L", "L", "N", gtr_sce)





end event

type uo_periodo from uo_periodo_variable_tipos within w_estad_bajas_acad_coord
integer x = 434
integer y = 124
integer width = 974
integer height = 344
integer taborder = 30
end type

on uo_periodo.destroy
call uo_periodo_variable_tipos::destroy
end on

type uo_coordinacion from uo_coordinaciones within w_estad_bajas_acad_coord
event destroy ( )
integer x = 1536
integer y = 160
integer taborder = 30
boolean border = false
long backcolor = 79741120
end type

on uo_coordinacion.destroy
call uo_coordinaciones::destroy
end on

type gb_coordinacion from groupbox within w_estad_bajas_acad_coord
integer x = 1504
integer y = 96
integer width = 1294
integer height = 224
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Coordinación"
borderstyle borderstyle = styleraised!
end type

type st_3 from statictext within w_estad_bajas_acad_coord
integer x = 3081
integer y = 76
integer width = 443
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
string text = "Total : 0"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_estadisticas from datawindow within w_estad_bajas_acad_coord
integer y = 532
integer width = 3589
integer height = 1228
integer taborder = 80
string dataobject = "d_bajas_academicas_coord"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
m_estad_alum_mat.dw= this
end event

event retrieveend;/*Cuando dw_1 termine de leer los datos de la tabla...*/


string Cont
Cont = '0'
/*Verifica si se bajo más de un dato*/
if rowcount >= 1 then
	Cont = string(rowcount)
	// Se actualiza el numero de datos traidos
//	Cont =string(dw_1z.object.cuantos[1])
	st_3.text='Total : '+Cont
else
	st_3.text='Total : '+Cont
end if

end event

type cb_1 from commandbutton within w_estad_bajas_acad_coord
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 3186
integer y = 220
integer width = 265
integer height = 108
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar"
end type

event clicked;// Se recuperan los registros de la base de datos
long ll_renglon_uo
integer li_cve_forma_ingreso, li_anio, li_periodo, li_indice_nivel
string ls_anio, ls_nivel[], ls_periodo, ls_periodo_elegido, ls_forma_ingreso, ls_fecha_servidor
long ll_row_carrera, ll_cve_carrera, ll_row_coordinacion, ll_cve_coordinacion
datetime ldttm_fecha_servidor

ll_row_coordinacion = parent.uo_coordinacion.dw_coordinaciones.GetRow()
ll_cve_coordinacion = parent.uo_coordinacion.dw_coordinaciones.object.cve_coordinacion[ll_row_coordinacion]

//if rb_primavera.checked then
//	li_periodo= 0
//	ls_periodo = "Primavera"
//elseif rb_verano.checked then
//	li_periodo= 1
//	ls_periodo = "Verano"
//elseif rb_otonio.checked then
//	li_periodo= 2	
//	ls_periodo = "Otoño"
//else
//	MessageBox("Error", "Es necesario seleccionar un Periodo", StopSign!)
//	return
//end if


//**--****--****--****--****--****--****--****--****--****--****--****--**
INTEGER le_index
INTEGER le_periodo[] 
STRING ls_tipo_periodo[]

PARENT.uo_periodo.of_recupera_periodos()

FOR le_index = 1 TO UPPERBOUND(PARENT.uo_periodo.istr_periodos[])
	IF TRIM(ls_periodo_elegido) <> "" THEN ls_periodo_elegido = ls_periodo_elegido + ", "
	ls_periodo_elegido = ls_periodo_elegido + PARENT.uo_periodo.istr_periodos[le_index].descripcion 
	le_periodo[le_index] = PARENT.uo_periodo.istr_periodos[le_index].periodo
	ls_tipo_periodo[le_index] = PARENT.uo_periodo.istr_periodos[le_index].tipo
NEXT 
//**--****--****--****--****--****--****--****--****--****--****--****--**




ls_anio = em_anio.text

if not isnumber(ls_anio) then
	MessageBox("Error", "Es necesario escribir un Año", StopSign!)
	return
end if

li_anio= integer(ls_anio)

setpointer(Hourglass!)
ldttm_fecha_servidor = fecha_servidor(gtr_sce)
ls_fecha_servidor= string(ldttm_fecha_servidor, "dd/mm/yyyy hh:mm")

//ls_periodo_elegido =ls_periodo +" "+ ls_anio
ls_periodo_elegido = ls_periodo_elegido + " " + ls_anio

//dw_estadisticas.object.periodo_anio.text= ls_periodo_elegido
//dw_estadisticas.object.st_fecha_hoy.text= ls_fecha_servidor
//dw_estadisticas.Retrieve(li_periodo, li_anio, ll_cve_coordinacion)

INTEGER le_resultado
DATASTORE lds_temporal

lds_temporal = CREATE DATASTORE 
lds_temporal.DATAOBJECT = dw_estadisticas.DATAOBJECT 

FOR le_index = 1 TO UPPERBOUND(le_periodo[])

	//Necesario por la creacion de la tabla temporal
	gtr_sce.Autocommit= true
	dw_estadisticas.reset()
	le_resultado = dw_estadisticas.Retrieve(le_periodo[le_index], li_anio, ll_cve_coordinacion, ls_tipo_periodo[le_index])
	//dw_estadisticas.RETRIEVE(le_periodo[le_index], li_anio, ll_cve_coordinacion, ls_tipo_periodo[le_index])
	gtr_sce.Autocommit= false

	IF le_resultado < 0 THEN 
		dw_estadisticas.RESET()
		MESSAGEBOX("Error", "No se pudo generar el reporte.") 
		RETURN -1
	ELSEIF le_resultado = 0 THEN 
		CONTINUE
	ELSE
		dw_estadisticas.ROWSCOPY(1, dw_estadisticas.ROWCOUNT(), PRIMARY!, lds_temporal, lds_temporal.ROWCOUNT() + 1, PRIMARY!) 
	END IF


NEXT 


// Se copia la información al dw principal.
dw_estadisticas.RESET()
lds_temporal.ROWSCOPY(1, lds_temporal.ROWCOUNT(), PRIMARY!, dw_estadisticas, dw_estadisticas.ROWCOUNT() + 1, PRIMARY!)

dw_estadisticas.object.periodo_anio.text= ls_periodo_elegido
dw_estadisticas.object.st_fecha_hoy.text= ls_fecha_servidor


end event

event constructor;TabOrder = 4
end event

type em_anio from editmask within w_estad_bajas_acad_coord
event constructor pbm_constructor
event modified pbm_enmodified
integer x = 82
integer y = 124
integer width = 219
integer height = 80
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy"
string displaydata = "`"
end type

event constructor;TabOrder = 0

int periodo,anio


periodo_actual_mat_insc(periodo,anio,gtr_sce)

// 0 = Primavera
// 1 = Verano
// 2 = Otoño

//CHOOSE CASE periodo
//	CASE 0
//		periodo_x = 0
//		rb_primavera.checked = TRUE
//	CASE 1
//		periodo_x = 1
//      rb_verano.checked = TRUE
//	CASE 2
//		periodo_x = 2
//      rb_otonio.checked = TRUE
//
//END CHOOSE
this.text = string(anio)

//Deshabilitar los objetos que señalan el periodo
//this.enabled = FALSE
//rb_primavera.enabled = FALSE
//rb_verano.enabled = FALSE
//rb_otonio.enabled = FALSE
		

		
end event

event modified;long fecha

fecha = long(this.text)
if fecha < 1900 then
   messagebox ("Información", "El año DEBE ser mayor a 1900")
	this.SelectText(1, Len(this.Text))
	this.setfocus()
end if
end event

type dw_1x from datawindow within w_estad_bajas_acad_coord
integer x = 3767
integer y = 624
integer width = 1038
integer height = 564
integer taborder = 70
string dataobject = "dw_repo_mad_18_gx"
boolean livescroll = true
end type

type gb_8 from groupbox within w_estad_bajas_acad_coord
integer x = 3150
integer y = 172
integer width = 329
integer height = 176
integer taborder = 100
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_11 from groupbox within w_estad_bajas_acad_coord
integer x = 37
integer y = 64
integer width = 315
integer height = 160
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Año"
borderstyle borderstyle = styleraised!
end type

type gb_20 from groupbox within w_estad_bajas_acad_coord
integer x = 389
integer y = 64
integer width = 1056
integer height = 424
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Periodo"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_estad_bajas_acad_coord
integer width = 3589
integer height = 512
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Criterios de Busqueda"
borderstyle borderstyle = styleraised!
end type

