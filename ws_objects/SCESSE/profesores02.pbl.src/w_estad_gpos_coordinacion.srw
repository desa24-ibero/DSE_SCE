$PBExportHeader$w_estad_gpos_coordinacion.srw
forward
global type w_estad_gpos_coordinacion from window
end type
type uo_nivel from uo_nivel_rbutton within w_estad_gpos_coordinacion
end type
type uo_periodos from uo_per_ani within w_estad_gpos_coordinacion
end type
type dw_detalle from datawindow within w_estad_gpos_coordinacion
end type
type cbx_todas_categorias from checkbox within w_estad_gpos_coordinacion
end type
type cbx_todos_grupos from checkbox within w_estad_gpos_coordinacion
end type
type uo_tipo_nomina from udo_tipo_nomina within w_estad_gpos_coordinacion
end type
type uo_tipo_grupo from udo_tipo_grupo within w_estad_gpos_coordinacion
end type
type gb_coordinacion from groupbox within w_estad_gpos_coordinacion
end type
type st_3 from statictext within w_estad_gpos_coordinacion
end type
type cb_1 from commandbutton within w_estad_gpos_coordinacion
end type
type em_anio from editmask within w_estad_gpos_coordinacion
end type
type rb_otonio from radiobutton within w_estad_gpos_coordinacion
end type
type rb_verano from radiobutton within w_estad_gpos_coordinacion
end type
type rb_primavera from radiobutton within w_estad_gpos_coordinacion
end type
type dw_1x from datawindow within w_estad_gpos_coordinacion
end type
type gb_8 from groupbox within w_estad_gpos_coordinacion
end type
type gb_11 from groupbox within w_estad_gpos_coordinacion
end type
type gb_20 from groupbox within w_estad_gpos_coordinacion
end type
type gb_2 from groupbox within w_estad_gpos_coordinacion
end type
type gb_3 from groupbox within w_estad_gpos_coordinacion
end type
type gb_1 from groupbox within w_estad_gpos_coordinacion
end type
type uo_coordinacion from uo_coordinaciones within w_estad_gpos_coordinacion
end type
type dw_estadisticas from uo_dw_reporte within w_estad_gpos_coordinacion
end type
end forward

global type w_estad_gpos_coordinacion from window
integer width = 4462
integer height = 2872
boolean titlebar = true
string title = "Estadística de Alumnos/Materias"
string menuname = "m_estad_gpos_coordinacion"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
uo_nivel uo_nivel
uo_periodos uo_periodos
dw_detalle dw_detalle
cbx_todas_categorias cbx_todas_categorias
cbx_todos_grupos cbx_todos_grupos
uo_tipo_nomina uo_tipo_nomina
uo_tipo_grupo uo_tipo_grupo
gb_coordinacion gb_coordinacion
st_3 st_3
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
gb_3 gb_3
gb_1 gb_1
uo_coordinacion uo_coordinacion
dw_estadisticas dw_estadisticas
end type
global w_estad_gpos_coordinacion w_estad_gpos_coordinacion

type variables
int periodo_x
integer ii_periodo, ii_anio

uo_periodo_servicios iuo_periodo_servicios
end variables

on w_estad_gpos_coordinacion.create
if this.MenuName = "m_estad_gpos_coordinacion" then this.MenuID = create m_estad_gpos_coordinacion
this.uo_nivel=create uo_nivel
this.uo_periodos=create uo_periodos
this.dw_detalle=create dw_detalle
this.cbx_todas_categorias=create cbx_todas_categorias
this.cbx_todos_grupos=create cbx_todos_grupos
this.uo_tipo_nomina=create uo_tipo_nomina
this.uo_tipo_grupo=create uo_tipo_grupo
this.gb_coordinacion=create gb_coordinacion
this.st_3=create st_3
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
this.gb_3=create gb_3
this.gb_1=create gb_1
this.uo_coordinacion=create uo_coordinacion
this.dw_estadisticas=create dw_estadisticas
this.Control[]={this.uo_nivel,&
this.uo_periodos,&
this.dw_detalle,&
this.cbx_todas_categorias,&
this.cbx_todos_grupos,&
this.uo_tipo_nomina,&
this.uo_tipo_grupo,&
this.gb_coordinacion,&
this.st_3,&
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
this.gb_3,&
this.gb_1,&
this.uo_coordinacion,&
this.dw_estadisticas}
end on

on w_estad_gpos_coordinacion.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nivel)
destroy(this.uo_periodos)
destroy(this.dw_detalle)
destroy(this.cbx_todas_categorias)
destroy(this.cbx_todos_grupos)
destroy(this.uo_tipo_nomina)
destroy(this.uo_tipo_grupo)
destroy(this.gb_coordinacion)
destroy(this.st_3)
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
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.uo_coordinacion)
destroy(this.dw_estadisticas)
end on

event open;this.x=1
this.y=1

long ll_default_grupo[],ll_default_categoria[]

ll_default_grupo[1]=1
ll_default_categoria[1]=1
periodo_actual_mat_insc(ii_periodo, ii_anio, gtr_sce)

	em_anio.text=string(ii_anio)
	
	//Modif. Roberto Novoa R.  May/2016 - Funcionalidad de periodos múltiples
	iuo_periodo_servicios = CREATE uo_periodo_servicios
	iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)

//uo_lb_tipo_grupo.event ue_genera_lista("ddlb_tipo_grupo",ll_default_grupo,gtr_sce)
//uo_lb_cve_categoria.event ue_genera_lista("ddlb_tipo_nomina",ll_default_categoria,gtr_sce)


uo_nivel.f_genera_nivel( "V", "L", "L", gtr_sce, "S", "N") 



end event

type uo_nivel from uo_nivel_rbutton within w_estad_gpos_coordinacion
integer x = 50
integer y = 240
integer taborder = 120
end type

on uo_nivel.destroy
call uo_nivel_rbutton::destroy
end on

type uo_periodos from uo_per_ani within w_estad_gpos_coordinacion
integer x = 32
integer y = 60
integer taborder = 110
boolean enabled = true
end type

on uo_periodos.destroy
call uo_per_ani::destroy
end on

type dw_detalle from datawindow within w_estad_gpos_coordinacion
boolean visible = false
integer x = 9
integer y = 664
integer width = 3557
integer height = 444
integer taborder = 100
string dataobject = "d_detalle_grupos_coordinacion"
boolean livescroll = true
end type

event constructor;this.SetTransObject(gtr_sce)
m_estad_gpos_coordinacion.dw_2= this


end event

type cbx_todas_categorias from checkbox within w_estad_gpos_coordinacion
integer x = 1947
integer y = 472
integer width = 261
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Todas"
borderstyle borderstyle = styleraised!
end type

event clicked;//Habilita y Deshabilita el user object
if this.checked then
	uo_tipo_nomina.enabled = false
else
	uo_tipo_nomina.enabled = true	
end if
end event

type cbx_todos_grupos from checkbox within w_estad_gpos_coordinacion
integer x = 1289
integer y = 472
integer width = 261
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Todos"
borderstyle borderstyle = styleraised!
end type

event clicked;//Habilita y Deshabilita el user object
if this.checked then
	uo_tipo_grupo.enabled = false
else
	uo_tipo_grupo.enabled = true	
end if
end event

type uo_tipo_nomina from udo_tipo_nomina within w_estad_gpos_coordinacion
event destroy ( )
integer x = 1787
integer y = 356
integer width = 576
integer taborder = 120
end type

on uo_tipo_nomina.destroy
call udo_tipo_nomina::destroy
end on

type uo_tipo_grupo from udo_tipo_grupo within w_estad_gpos_coordinacion
event destroy ( )
integer x = 1179
integer y = 356
integer width = 480
integer height = 100
integer taborder = 110
end type

on uo_tipo_grupo.destroy
call udo_tipo_grupo::destroy
end on

type gb_coordinacion from groupbox within w_estad_gpos_coordinacion
integer x = 1390
integer y = 52
integer width = 1371
integer height = 180
integer taborder = 70
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

type st_3 from statictext within w_estad_gpos_coordinacion
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

type cb_1 from commandbutton within w_estad_gpos_coordinacion
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 3186
integer y = 220
integer width = 265
integer height = 108
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar"
end type

event clicked;long ll_rows
ll_rows = dw_estadisticas.event carga()
end event

event constructor;TabOrder = 4
end event

type em_anio from editmask within w_estad_gpos_coordinacion
event constructor pbm_constructor
event modified pbm_enmodified
boolean visible = false
integer x = 82
integer y = 124
integer width = 219
integer height = 80
integer taborder = 40
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

type rb_otonio from radiobutton within w_estad_gpos_coordinacion
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 3611
integer y = 400
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Otoño"
end type

event clicked;periodo_x = 2
end event

type rb_verano from radiobutton within w_estad_gpos_coordinacion
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 3255
integer y = 400
integer width = 270
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Verano"
end type

event clicked;periodo_x = 1
end event

type rb_primavera from radiobutton within w_estad_gpos_coordinacion
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 2871
integer y = 400
integer width = 343
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Primavera"
end type

event clicked;periodo_x = 0
end event

type dw_1x from datawindow within w_estad_gpos_coordinacion
integer x = 3159
integer y = 628
integer width = 1038
integer height = 564
integer taborder = 90
string dataobject = "dw_repo_mad_18_gx"
boolean livescroll = true
end type

type gb_8 from groupbox within w_estad_gpos_coordinacion
integer x = 3150
integer y = 172
integer width = 329
integer height = 176
integer taborder = 120
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_11 from groupbox within w_estad_gpos_coordinacion
boolean visible = false
integer x = 37
integer y = 64
integer width = 315
integer height = 160
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Año"
borderstyle borderstyle = styleraised!
end type

type gb_20 from groupbox within w_estad_gpos_coordinacion
boolean visible = false
integer x = 32
integer y = 224
integer width = 1056
integer height = 160
integer taborder = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Periodo"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_estad_gpos_coordinacion
integer x = 1765
integer y = 280
integer width = 649
integer height = 288
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Categoría Profesor"
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_estad_gpos_coordinacion
integer x = 1143
integer y = 280
integer width = 576
integer height = 288
integer taborder = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Tipo de Grupo"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_estad_gpos_coordinacion
integer width = 4338
integer height = 620
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

type uo_coordinacion from uo_coordinaciones within w_estad_gpos_coordinacion
event destroy ( )
integer x = 1426
integer y = 104
integer height = 124
integer taborder = 50
boolean bringtotop = true
boolean border = false
long backcolor = 79741120
end type

on uo_coordinacion.destroy
call uo_coordinaciones::destroy
end on

type dw_estadisticas from uo_dw_reporte within w_estad_gpos_coordinacion
integer x = 9
integer y = 612
integer width = 4320
integer height = 2000
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_grupos_coordinacion"
boolean hscrollbar = true
boolean resizable = true
boolean border = true
end type

event retrieveend;call super::retrieveend;/*Cuando dw_1 termine de leer los datos de la tabla...*/


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

event constructor;call super::constructor;settransobject(gtr_sce)
//m_estad_alum_mat.dw= this
end event

event carga;// Se recuperan los registros de la base de datos
long   ll_tipo_grupo, ll_cve_categoria, ll_rows_detalle
long ll_row_estatus_solicitud, ll_num_registros
long ll_renglon_uo
integer li_cve_forma_ingreso, li_anio, li_periodo, li_indice_nivel
string ls_anio,  ls_periodo, ls_periodo_elegido, ls_forma_ingreso, ls_fecha_servidor
long ll_row_carrera, ll_cve_carrera, ll_row_coordinacion, ll_cve_coordinacion
datetime ldttm_fecha_servidor
string ls_nivel

ll_row_coordinacion = parent.uo_coordinacion.dw_coordinaciones.GetRow()
ll_cve_coordinacion = parent.uo_coordinacion.dw_coordinaciones.object.cve_coordinacion[ll_row_coordinacion]

ls_periodo=uo_periodos.em_per.text
li_periodo=uo_periodos.iuo_periodo_servicios.f_recupera_id( uo_periodos.em_per.text, "L")

/*
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
	return -1
end if
*/

//if rb_licenciatura.checked then
//	ls_nivel= "L"
//elseif rb_posgrado.checked then
//	ls_nivel= "P"
//elseif rb_todos.checked then
//	ls_nivel= "A"
//else
//	MessageBox("Error", "Es necesario seleccionar un Nivel", StopSign!)
//	return -1
//end if

ls_nivel = PARENT.uo_nivel.cve_nivel 
IF TRIM(ls_nivel) = "" THEN 
	MessageBox("Error", "Es necesario seleccionar un Nivel", StopSign!)
	return -1
END IF


ls_anio = uo_periodos.em_ani.text

if not isnumber(ls_anio) then
	MessageBox("Error", "Es necesario escribir un Año", StopSign!)
	return -1
end if

li_anio= integer(ls_anio)

setpointer(Hourglass!)
ldttm_fecha_servidor = fecha_servidor(gtr_sce)
ls_fecha_servidor= string(ldttm_fecha_servidor, "dd/mm/yyyy hh:mm")

ls_periodo_elegido =ls_periodo +" "+ ls_anio

ll_tipo_grupo = uo_tipo_grupo.of_obten_clave()
ll_cve_categoria = uo_tipo_nomina.of_obten_clave()

if cbx_todos_grupos.checked then
	ll_tipo_grupo= 99
end if

if cbx_todas_categorias.checked then
	ll_cve_categoria= 99
end if

if ll_tipo_grupo<0  or isnull(ll_tipo_grupo) then
	MessageBox("Error", "Es necesario seleccionar un tipo de grupo", StopSign!)
	return -1
end if

if ll_cve_categoria<0  or isnull(ll_cve_categoria) then
	MessageBox("Error", "Es necesario seleccionar un tipo de profesor", StopSign!)
	return -1
end if

gtr_sce.autocommit= true
ll_num_registros= dw_estadisticas.Retrieve(li_periodo, li_anio, ll_cve_coordinacion, ll_cve_categoria, ll_tipo_grupo, ls_nivel)
gtr_sce.autocommit= false

if ll_num_registros= -1 then
	MessageBox("Error en consulta de grupos", "No es posible generar el reporte", StopSign!)
	return -1	
end if

if li_periodo= ii_periodo and li_anio = ii_anio then
	dw_detalle.dataobject = "d_detalle_grupos_coordinacion"
	dw_detalle.SetTransObject(gtr_sce)
else
	dw_detalle.dataobject = "d_detalle_hist_grupos_coord"
	dw_detalle.SetTransObject(gtr_sce)	
end if

ll_rows_detalle=dw_detalle.Retrieve(li_periodo, li_anio, ll_cve_coordinacion, ll_cve_categoria, ll_tipo_grupo, ls_nivel)
if ll_rows_detalle= -1 then
	MessageBox("Error en consulta del detalle", "No se generara archivo detalle", StopSign!)
	return -1	
end if
if ll_num_registros >0 then
	dw_estadisticas.object.periodo_anio.text= ls_periodo_elegido
	dw_estadisticas.object.st_fecha_hoy.text= ls_fecha_servidor
end if

return ll_num_registros

end event

