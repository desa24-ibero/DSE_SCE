$PBExportHeader$w_estad_gi_mats_imp.srw
forward
global type w_estad_gi_mats_imp from window
end type
type ddlb_tipo_imp from dropdownlistbox within w_estad_gi_mats_imp
end type
type st_2 from statictext within w_estad_gi_mats_imp
end type
type uo_periodo from uo_periodo_variable_tipos within w_estad_gi_mats_imp
end type
type uo_coordinacion from uo_coordinaciones within w_estad_gi_mats_imp
end type
type gb_coordinacion from groupbox within w_estad_gi_mats_imp
end type
type st_3 from statictext within w_estad_gi_mats_imp
end type
type dw_estadisticas from datawindow within w_estad_gi_mats_imp
end type
type cb_1 from commandbutton within w_estad_gi_mats_imp
end type
type em_anio from editmask within w_estad_gi_mats_imp
end type
type dw_1x from datawindow within w_estad_gi_mats_imp
end type
type gb_8 from groupbox within w_estad_gi_mats_imp
end type
type gb_11 from groupbox within w_estad_gi_mats_imp
end type
type gb_20 from groupbox within w_estad_gi_mats_imp
end type
type gb_1 from groupbox within w_estad_gi_mats_imp
end type
end forward

global type w_estad_gi_mats_imp from window
integer width = 3639
integer height = 2056
boolean titlebar = true
string title = "Estadística de Grupos Abiertos por Coordinación"
string menuname = "m_estad_alum_mat"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
ddlb_tipo_imp ddlb_tipo_imp
st_2 st_2
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
global w_estad_gi_mats_imp w_estad_gi_mats_imp

type variables
integer ii_tipo_imp, ii_num_resize = 0
int periodo_x[]
STRING is_descripcion_periodo 
end variables

on w_estad_gi_mats_imp.create
if this.MenuName = "m_estad_alum_mat" then this.MenuID = create m_estad_alum_mat
this.ddlb_tipo_imp=create ddlb_tipo_imp
this.st_2=create st_2
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
this.Control[]={this.ddlb_tipo_imp,&
this.st_2,&
this.uo_periodo,&
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

on w_estad_gi_mats_imp.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddlb_tipo_imp)
destroy(this.st_2)
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

event open;
// Se inicializa el objeto de periodos
THIS.uo_periodo.of_inicializa_servicio( "V", "L", "L", "N", gtr_sce)
ddlb_tipo_imp.selectitem(2)
this.x=1
this.y=1

end event

event resize;long ll_height_win, ll_height_dw, ll_dif_height_tab, ll_height_tab, ll_width_tab, ll_height_tab_final

if ii_num_resize > 0 then
	ll_height_dw = dw_estadisticas.height
	ll_height_win = this.height

	ll_height_tab = dw_estadisticas.height
	ll_width_tab = dw_estadisticas.width

	dw_estadisticas.width = newwidth - 50
	dw_estadisticas.height = newheight - 600
	
	ll_height_tab_final = dw_estadisticas.height
	
	ll_dif_height_tab = ll_height_tab_final - ll_height_tab  

	dw_estadisticas.width = newwidth - 200
	dw_estadisticas.height = ll_height_dw + ll_dif_height_tab
else
	ii_num_resize = ii_num_resize + 1
end if
end event

type ddlb_tipo_imp from dropdownlistbox within w_estad_gi_mats_imp
integer x = 2190
integer y = 296
integer width = 549
integer height = 384
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
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

type st_2 from statictext within w_estad_gi_mats_imp
integer x = 1682
integer y = 304
integer width = 498
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12632256
string text = "Tipo impartición:"
boolean focusrectangle = false
end type

type uo_periodo from uo_periodo_variable_tipos within w_estad_gi_mats_imp
integer x = 443
integer y = 116
integer width = 1115
integer height = 392
integer taborder = 20
end type

on uo_periodo.destroy
call uo_periodo_variable_tipos::destroy
end on

type uo_coordinacion from uo_coordinaciones within w_estad_gi_mats_imp
event destroy ( )
integer x = 1719
integer y = 124
integer height = 128
integer taborder = 30
boolean border = false
long backcolor = 12632256
end type

on uo_coordinacion.destroy
call uo_coordinaciones::destroy
end on

type gb_coordinacion from groupbox within w_estad_gi_mats_imp
integer x = 1687
integer y = 56
integer width = 1358
integer height = 212
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

type st_3 from statictext within w_estad_gi_mats_imp
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

type dw_estadisticas from datawindow within w_estad_gi_mats_imp
integer y = 576
integer width = 3589
integer height = 1268
integer taborder = 60
string dataobject = "d_gi_materias_impartidas"
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

type cb_1 from commandbutton within w_estad_gi_mats_imp
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 3186
integer y = 220
integer width = 265
integer height = 108
integer taborder = 40
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

ls_anio = em_anio.text

if not isnumber(ls_anio) then
	MessageBox("Error", "Es necesario escribir un Año", StopSign!)
	return
end if

li_anio= integer(ls_anio)

setpointer(Hourglass!)
ldttm_fecha_servidor = fecha_servidor(gtr_sce)
ls_fecha_servidor= string(ldttm_fecha_servidor, "dd/mm/yyyy hh:mm")

ls_periodo_elegido =ls_periodo +" "+ ls_anio

//dw_estadisticas.object.periodo_anio.text= ls_periodo_elegido
dw_estadisticas.object.st_fecha_hoy.text= ls_fecha_servidor


//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**		
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	
INTEGER le_index
INTEGER le_periodo[] 
STRING ls_tipo_periodo[]
//STRING is_descripcion_periodo
DATASTORE lds_paso

lds_paso = CREATE DATASTORE 
lds_paso.DATAOBJECT = dw_estadisticas.DATAOBJECT 

PARENT.uo_periodo.of_recupera_periodos() 

IF ii_tipo_imp = 0 THEN ii_tipo_imp = 1 // 1 = Tradicional	

periodo_x[] = le_periodo[]
is_descripcion_periodo = ""
FOR le_index = 1 TO UPPERBOUND(PARENT.uo_periodo.istr_periodos[])
	IF TRIM(is_descripcion_periodo) <> "" THEN is_descripcion_periodo = is_descripcion_periodo + ", "
	is_descripcion_periodo = is_descripcion_periodo + PARENT.uo_periodo.istr_periodos[le_index].descripcion 
	periodo_x[le_index] = PARENT.uo_periodo.istr_periodos[le_index].periodo
	ls_tipo_periodo[le_index] = PARENT.uo_periodo.istr_periodos[le_index].tipo
	
	dw_estadisticas.RESET()
	//IF dw_estadisticas.Retrieve(periodo_x[le_index], li_anio, ll_cve_coordinacion, ls_tipo_periodo[le_index]) < 0 THEN RETURN 0
	IF dw_estadisticas.Retrieve(periodo_x[le_index], li_anio, ll_cve_coordinacion, ii_tipo_imp) < 0 THEN RETURN 0
	dw_estadisticas.ROWSCOPY(1, dw_estadisticas.ROWCOUNT(), PRIMARY!, lds_paso, lds_paso.ROWCOUNT() + 1, PRIMARY!)
NEXT 	
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**		
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	

dw_estadisticas.object.periodo_anio.text= is_descripcion_periodo+" "+ ls_anio

dw_estadisticas.RESET()
lds_paso.ROWSCOPY(1, lds_paso.ROWCOUNT(), PRIMARY!, dw_estadisticas, dw_estadisticas.ROWCOUNT() + 1 , PRIMARY!)
dw_estadisticas.SORT()
dw_estadisticas.GROUPCALC()



//dw_estadisticas.Retrieve(li_periodo, li_anio, ll_cve_coordinacion)






end event

event constructor;TabOrder = 4
end event

type em_anio from editmask within w_estad_gi_mats_imp
event constructor pbm_constructor
event modified pbm_enmodified
integer x = 82
integer y = 112
integer width = 219
integer height = 80
integer taborder = 10
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

type dw_1x from datawindow within w_estad_gi_mats_imp
boolean visible = false
integer x = 3767
integer y = 624
integer width = 1038
integer height = 564
integer taborder = 50
string dataobject = "dw_repo_mad_18_gx"
boolean livescroll = true
end type

type gb_8 from groupbox within w_estad_gi_mats_imp
integer x = 3150
integer y = 172
integer width = 329
integer height = 176
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_11 from groupbox within w_estad_gi_mats_imp
integer x = 37
integer y = 52
integer width = 315
integer height = 160
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Año"
borderstyle borderstyle = styleraised!
end type

type gb_20 from groupbox within w_estad_gi_mats_imp
integer x = 407
integer y = 52
integer width = 1198
integer height = 484
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Periodo"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_estad_gi_mats_imp
integer width = 3589
integer height = 576
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Criterios de Busqueda"
borderstyle borderstyle = styleraised!
end type

