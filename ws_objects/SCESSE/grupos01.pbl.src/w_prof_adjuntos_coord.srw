$PBExportHeader$w_prof_adjuntos_coord.srw
forward
global type w_prof_adjuntos_coord from window
end type
type ddlb_tipo_imp from dropdownlistbox within w_prof_adjuntos_coord
end type
type st_2 from statictext within w_prof_adjuntos_coord
end type
type uo_1 from uo_per_ani within w_prof_adjuntos_coord
end type
type uo_coordinacion from uo_coordinaciones within w_prof_adjuntos_coord
end type
type gb_coordinacion from groupbox within w_prof_adjuntos_coord
end type
type st_3 from statictext within w_prof_adjuntos_coord
end type
type dw_estadisticas from datawindow within w_prof_adjuntos_coord
end type
type cb_1 from commandbutton within w_prof_adjuntos_coord
end type
type em_anio from editmask within w_prof_adjuntos_coord
end type
type rb_otonio from radiobutton within w_prof_adjuntos_coord
end type
type rb_verano from radiobutton within w_prof_adjuntos_coord
end type
type rb_primavera from radiobutton within w_prof_adjuntos_coord
end type
type dw_1x from datawindow within w_prof_adjuntos_coord
end type
type gb_8 from groupbox within w_prof_adjuntos_coord
end type
type gb_20 from groupbox within w_prof_adjuntos_coord
end type
type gb_1 from groupbox within w_prof_adjuntos_coord
end type
end forward

global type w_prof_adjuntos_coord from window
integer width = 4155
integer height = 2660
boolean titlebar = true
string title = "Reporte de Autorización de Otras Actividades"
string menuname = "m_prof_adjunto_coord"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
ddlb_tipo_imp ddlb_tipo_imp
st_2 st_2
uo_1 uo_1
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
gb_20 gb_20
gb_1 gb_1
end type
global w_prof_adjuntos_coord w_prof_adjuntos_coord

type variables
integer ii_tipo_imp, ii_num_resize = 0
int periodo_x
uo_periodo_servicios iuo_periodo_servicios
end variables

on w_prof_adjuntos_coord.create
if this.MenuName = "m_prof_adjunto_coord" then this.MenuID = create m_prof_adjunto_coord
this.ddlb_tipo_imp=create ddlb_tipo_imp
this.st_2=create st_2
this.uo_1=create uo_1
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
this.gb_20=create gb_20
this.gb_1=create gb_1
this.Control[]={this.ddlb_tipo_imp,&
this.st_2,&
this.uo_1,&
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
this.gb_20,&
this.gb_1}
end on

on w_prof_adjuntos_coord.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddlb_tipo_imp)
destroy(this.st_2)
destroy(this.uo_1)
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
destroy(this.gb_20)
destroy(this.gb_1)
end on

event open;this.x=1
this.y=1

	//Modif. Roberto Novoa R.  Jun/2016 - Funcionalidad de periodos múltiples
	iuo_periodo_servicios = CREATE uo_periodo_servicios
	iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)

	uo_1.em_per.text = iuo_periodo_servicios.f_recupera_descripcion(gi_periodo , "L")
	uo_1.em_ani.text = String(gi_anio)
	ddlb_tipo_imp.selectitem(2)

end event

event resize;long ll_height_win, ll_height_dw, ll_dif_height_tab, ll_height_tab, ll_width_tab, ll_height_tab_final

if ii_num_resize > 0 then
	ll_height_dw = dw_estadisticas.height
	ll_height_win = this.height

	ll_height_tab = dw_estadisticas.height
	ll_width_tab = dw_estadisticas.width

	dw_estadisticas.width = newwidth - 50
	dw_estadisticas.height = newheight - 450
	
	ll_height_tab_final = dw_estadisticas.height
	
	ll_dif_height_tab = ll_height_tab_final - ll_height_tab  

	dw_estadisticas.width = newwidth - 200
	dw_estadisticas.height = ll_height_dw + ll_dif_height_tab
else
	ii_num_resize = ii_num_resize + 1
end if
end event

type ddlb_tipo_imp from dropdownlistbox within w_prof_adjuntos_coord
integer x = 3415
integer y = 80
integer width = 549
integer height = 384
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
boolean vscrollbar = true
string item[] = {"Tradicional","Modular"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String ls_descripcion

IF Lower(This.text) = 'modular' THEN
	ii_tipo_imp = 2 
ELSE
	ii_tipo_imp = 1 // 1 = Tradicional
END IF
end event

type st_2 from statictext within w_prof_adjuntos_coord
integer x = 2907
integer y = 88
integer width = 498
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 553648127
string text = "Tipo impartición:"
boolean focusrectangle = false
end type

type uo_1 from uo_per_ani within w_prof_adjuntos_coord
integer x = 59
integer y = 152
integer taborder = 40
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type uo_coordinacion from uo_coordinaciones within w_prof_adjuntos_coord
event destroy ( )
integer x = 1445
integer y = 172
integer taborder = 30
boolean border = false
long backcolor = 553648127
end type

on uo_coordinacion.destroy
call uo_coordinaciones::destroy
end on

type gb_coordinacion from groupbox within w_prof_adjuntos_coord
integer x = 1413
integer y = 100
integer width = 1362
integer height = 224
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Coordinación"
borderstyle borderstyle = styleraised!
end type

type st_3 from statictext within w_prof_adjuntos_coord
integer x = 3470
integer y = 236
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

type dw_estadisticas from datawindow within w_prof_adjuntos_coord
integer y = 396
integer width = 4091
integer height = 2008
integer taborder = 80
string dataobject = "d_prof_adjuntos_coord"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
m_prof_adjunto_coord.dw= this
dw_estadisticas.Object.DataWindow.Zoom = 92
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

type cb_1 from commandbutton within w_prof_adjuntos_coord
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 3022
integer y = 232
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
	return
end if
*/

ls_periodo=uo_1.em_per.text
li_periodo=uo_1.iuo_periodo_servicios.f_recupera_id( ls_periodo, "L")
ls_anio = uo_1.em_ani.text

if not isnumber(ls_anio) then
	MessageBox("Error", "Es necesario escribir un Año", StopSign!)
	return
end if

li_anio= integer(ls_anio)

setpointer(Hourglass!)
ldttm_fecha_servidor = fecha_servidor(gtr_sce)
ls_fecha_servidor= string(ldttm_fecha_servidor, "dd/mm/yyyy hh:mm")

ls_periodo_elegido =ls_periodo +" "+ ls_anio

dw_estadisticas.object.periodo_anio.text= ls_periodo_elegido
dw_estadisticas.object.st_fecha_hoy.text= ls_fecha_servidor

IF ii_tipo_imp = 0 THEN ii_tipo_imp = 1 // 1 = Tradicional	

gtr_sce.AutoCommit = true
dw_estadisticas.Retrieve(li_periodo, li_anio, ll_cve_coordinacion, ii_tipo_imp)
gtr_sce.AutoCommit = false






end event

event constructor;TabOrder = 4
end event

type em_anio from editmask within w_prof_adjuntos_coord
event constructor pbm_constructor
event modified pbm_enmodified
boolean visible = false
integer x = 3680
integer y = 88
integer width = 219
integer height = 80
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
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

type rb_otonio from radiobutton within w_prof_adjuntos_coord
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 3771
integer y = 336
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

type rb_verano from radiobutton within w_prof_adjuntos_coord
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 3415
integer y = 336
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

type rb_primavera from radiobutton within w_prof_adjuntos_coord
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 3031
integer y = 336
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

type dw_1x from datawindow within w_prof_adjuntos_coord
boolean visible = false
integer x = 4037
integer y = 628
integer width = 1038
integer height = 564
integer taborder = 70
string dataobject = "dw_repo_mad_18_gx"
boolean livescroll = true
end type

type gb_8 from groupbox within w_prof_adjuntos_coord
integer x = 2985
integer y = 184
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

type gb_20 from groupbox within w_prof_adjuntos_coord
integer x = 32
integer y = 80
integer width = 1303
integer height = 252
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

type gb_1 from groupbox within w_prof_adjuntos_coord
integer width = 4087
integer height = 548
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

