$PBExportHeader$w_dgmu_estad_insc.srw
forward
global type w_dgmu_estad_insc from window
end type
type rb_mi_col from radiobutton within w_dgmu_estad_insc
end type
type rb_mi_coord from radiobutton within w_dgmu_estad_insc
end type
type rb_gpos_coord from radiobutton within w_dgmu_estad_insc
end type
type uo_coordinacion from uo_dgmu_coordinaciones within w_dgmu_estad_insc
end type
type gb_coordinacion from groupbox within w_dgmu_estad_insc
end type
type st_3 from statictext within w_dgmu_estad_insc
end type
type dw_estadisticas from datawindow within w_dgmu_estad_insc
end type
type cb_1 from commandbutton within w_dgmu_estad_insc
end type
type em_anio from editmask within w_dgmu_estad_insc
end type
type rb_otonio from radiobutton within w_dgmu_estad_insc
end type
type rb_verano from radiobutton within w_dgmu_estad_insc
end type
type rb_primavera from radiobutton within w_dgmu_estad_insc
end type
type dw_1x from datawindow within w_dgmu_estad_insc
end type
type gb_8 from groupbox within w_dgmu_estad_insc
end type
type gb_11 from groupbox within w_dgmu_estad_insc
end type
type gb_20 from groupbox within w_dgmu_estad_insc
end type
type gb_2 from groupbox within w_dgmu_estad_insc
end type
type gb_1 from groupbox within w_dgmu_estad_insc
end type
end forward

global type w_dgmu_estad_insc from window
integer width = 5051
integer height = 2532
boolean titlebar = true
string title = "Estadística de Grupos Abiertos por Coordinación"
string menuname = "m_estad_alum_mat"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
rb_mi_col rb_mi_col
rb_mi_coord rb_mi_coord
rb_gpos_coord rb_gpos_coord
uo_coordinacion uo_coordinacion
gb_coordinacion gb_coordinacion
st_3 st_3
dw_estadisticas dw_estadisticas
cb_1 cb_1
em_anio em_anio
rb_otonio rb_otonio
rb_verano rb_verano
rb_primavera rb_primavera
dw_1x dw_1x
gb_8 gb_8
gb_11 gb_11
gb_20 gb_20
gb_2 gb_2
gb_1 gb_1
end type
global w_dgmu_estad_insc w_dgmu_estad_insc

type variables
int periodo_x

integer ii_periodo, ii_anio
end variables

on w_dgmu_estad_insc.create
if this.MenuName = "m_estad_alum_mat" then this.MenuID = create m_estad_alum_mat
this.rb_mi_col=create rb_mi_col
this.rb_mi_coord=create rb_mi_coord
this.rb_gpos_coord=create rb_gpos_coord
this.uo_coordinacion=create uo_coordinacion
this.gb_coordinacion=create gb_coordinacion
this.st_3=create st_3
this.dw_estadisticas=create dw_estadisticas
this.cb_1=create cb_1
this.em_anio=create em_anio
this.rb_otonio=create rb_otonio
this.rb_verano=create rb_verano
this.rb_primavera=create rb_primavera
this.dw_1x=create dw_1x
this.gb_8=create gb_8
this.gb_11=create gb_11
this.gb_20=create gb_20
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.rb_mi_col,&
this.rb_mi_coord,&
this.rb_gpos_coord,&
this.uo_coordinacion,&
this.gb_coordinacion,&
this.st_3,&
this.dw_estadisticas,&
this.cb_1,&
this.em_anio,&
this.rb_otonio,&
this.rb_verano,&
this.rb_primavera,&
this.dw_1x,&
this.gb_8,&
this.gb_11,&
this.gb_20,&
this.gb_2,&
this.gb_1}
end on

on w_dgmu_estad_insc.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_mi_col)
destroy(this.rb_mi_coord)
destroy(this.rb_gpos_coord)
destroy(this.uo_coordinacion)
destroy(this.gb_coordinacion)
destroy(this.st_3)
destroy(this.dw_estadisticas)
destroy(this.cb_1)
destroy(this.em_anio)
destroy(this.rb_otonio)
destroy(this.rb_verano)
destroy(this.rb_primavera)
destroy(this.dw_1x)
destroy(this.gb_8)
destroy(this.gb_11)
destroy(this.gb_20)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event open;this.x=1
this.y=1
rb_gpos_coord.event clicked()
end event

type rb_mi_col from radiobutton within w_dgmu_estad_insc
integer x = 1266
integer y = 476
integer width = 1006
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12632256
string text = "Materias Inscritas por Colegio"
end type

event clicked;dw_estadisticas.dataobject = "d_tcap_mi_col"
dw_estadisticas.SetTransObject(gtr_sce)

end event

type rb_mi_coord from radiobutton within w_dgmu_estad_insc
integer x = 1266
integer y = 396
integer width = 1006
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12632256
string text = "Materias Inscritas por Coordinación"
end type

event clicked;dw_estadisticas.dataobject = "d_dgmu_mi_coord"
dw_estadisticas.SetTransObject(gtr_sce)
end event

type rb_gpos_coord from radiobutton within w_dgmu_estad_insc
integer x = 1266
integer y = 316
integer width = 960
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12632256
string text = "Actas por Coordinación y Estatus"
boolean checked = true
end type

event clicked;dw_estadisticas.dataobject = "d_dgmu_gpos_coord"
dw_estadisticas.SetTransObject(gtr_sce)
end event

type uo_coordinacion from uo_dgmu_coordinaciones within w_dgmu_estad_insc
integer x = 1184
integer y = 88
integer taborder = 70
boolean border = false
end type

on uo_coordinacion.destroy
call uo_dgmu_coordinaciones::destroy
end on

type gb_coordinacion from groupbox within w_dgmu_estad_insc
integer x = 1166
integer y = 260
integer width = 1673
integer height = 308
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Reporte a Consultar"
borderstyle borderstyle = styleraised!
end type

type st_3 from statictext within w_dgmu_estad_insc
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

type dw_estadisticas from datawindow within w_dgmu_estad_insc
integer y = 596
integer width = 4699
integer height = 1700
integer taborder = 80
string dataobject = "d_estatus_actas_coord_en_linea"
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
m_estad_alum_mat.dw= this
end event

event retrieveend;/*Cuando dw_1 termine de leer los datos de la tabla...*/

datetime ldttm_fecha_servidor
string Cont, ls_fecha_servidor

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

event dberror;MessageBox( "Error en consulta "+string(sqldbcode), sqlerrtext +"~n"+sqlsyntax,StopSign!)
return 0
end event

type cb_1 from commandbutton within w_dgmu_estad_insc
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 3186
integer y = 216
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
long ll_row_carrera, ll_cve_carrera, ll_row_coordinacion, ll_cve_coordinacion, ll_rows_coordinaciones
datetime ldttm_fecha_servidor
long ll_rows

ll_rows_coordinaciones = parent.uo_coordinacion.dw_coordinaciones.RowCount()

IF ll_rows_coordinaciones> 0 THEN
	ll_row_coordinacion = parent.uo_coordinacion.dw_coordinaciones.GetRow()
	ll_cve_coordinacion = parent.uo_coordinacion.dw_coordinaciones.GetItemNumber(ll_row_coordinacion, 1)
ELSE
	MessageBox("Tabla sin coordinaciones", "No existen coordinaciones registradas",StopSign!)
	return
END IF

if rb_primavera.checked then
	li_periodo= 0
	ls_periodo = "Primavera"
elseif rb_verano.checked then
	li_periodo= 1
	ls_periodo = "Verano"
elseif rb_otonio.checked then
	li_periodo= 2	
	ls_periodo = "Otoño"
else
	MessageBox("Error", "Es necesario seleccionar un Periodo", StopSign!)
	return
end if

ls_anio = em_anio.text

if not isnumber(ls_anio) then
	MessageBox("Error", "Es necesario escribir un Año", StopSign!)
	return
end if

li_anio= integer(ls_anio)

setpointer(Hourglass!)
//ldttm_fecha_servidor = today() 
//ls_fecha_servidor= string(ldttm_fecha_servidor, "dd/mm/yyyy hh:mm")

ls_fecha_servidor = string(today(), "dd/mm/yyyy hh:mm") 

ls_periodo_elegido =ls_periodo +" "+ ls_anio

dw_estadisticas.object.periodo_anio.text= ls_periodo_elegido
dw_estadisticas.object.st_fecha_hoy.text= ls_fecha_servidor


//MessageBox("Datawindow", dw_estadisticas.dataobject,Information!)

if rb_gpos_coord.checked then
	ll_rows = dw_estadisticas.Retrieve(ll_cve_coordinacion, li_periodo, li_anio)
elseif rb_mi_coord.checked then
	ll_rows = dw_estadisticas.Retrieve(ll_cve_coordinacion, li_periodo, li_anio)
elseif rb_mi_col.checked then
	ll_rows = dw_estadisticas.Retrieve( li_periodo, li_anio)
end if
	








end event

event constructor;TabOrder = 4
end event

type em_anio from editmask within w_dgmu_estad_insc
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


periodo_actual_activacion(periodo,anio,gtr_sce)

// 0 = Primavera
// 1 = Verano
// 2 = Otoño

CHOOSE CASE periodo
	CASE 0
		periodo_x = 0
		rb_primavera.checked = TRUE
	CASE 1
		periodo_x = 1
      rb_verano.checked = TRUE
	CASE 2
		periodo_x = 2
      rb_otonio.checked = TRUE

END CHOOSE
this.text = string(anio)
ii_periodo = periodo
ii_anio = anio



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

type rb_otonio from radiobutton within w_dgmu_estad_insc
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 430
integer y = 288
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Otoño"
end type

event clicked;periodo_x = 2
end event

type rb_verano from radiobutton within w_dgmu_estad_insc
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 425
integer y = 208
integer width = 270
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Verano"
end type

event clicked;periodo_x = 1
end event

type rb_primavera from radiobutton within w_dgmu_estad_insc
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 425
integer y = 132
integer width = 343
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Primavera"
end type

event clicked;periodo_x = 0
end event

type dw_1x from datawindow within w_dgmu_estad_insc
boolean visible = false
integer x = 3767
integer y = 624
integer width = 1038
integer height = 564
integer taborder = 70
string dataobject = "dw_repo_mad_18_gx"
boolean livescroll = true
end type

type gb_8 from groupbox within w_dgmu_estad_insc
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

type gb_11 from groupbox within w_dgmu_estad_insc
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

type gb_20 from groupbox within w_dgmu_estad_insc
integer x = 393
integer y = 68
integer width = 489
integer height = 332
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

type gb_2 from groupbox within w_dgmu_estad_insc
integer x = 1166
integer y = 32
integer width = 1294
integer height = 224
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Coordinación"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_dgmu_estad_insc
integer width = 4699
integer height = 592
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

