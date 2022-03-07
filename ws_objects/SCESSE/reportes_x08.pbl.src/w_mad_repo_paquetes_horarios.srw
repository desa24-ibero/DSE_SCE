﻿$PBExportHeader$w_mad_repo_paquetes_horarios.srw
forward
global type w_mad_repo_paquetes_horarios from window
end type
type ddlb_tipo_imp from dropdownlistbox within w_mad_repo_paquetes_horarios
end type
type st_2 from statictext within w_mad_repo_paquetes_horarios
end type
type uo_periodo from uo_periodo_variable_tipos within w_mad_repo_paquetes_horarios
end type
type uo_carreras from uo_carrera_sce within w_mad_repo_paquetes_horarios
end type
type st_1 from statictext within w_mad_repo_paquetes_horarios
end type
type uo_materias from uo_materia_sce within w_mad_repo_paquetes_horarios
end type
type em_grupo from editmask within w_mad_repo_paquetes_horarios
end type
type em_anio from editmask within w_mad_repo_paquetes_horarios
end type
type st_3 from statictext within w_mad_repo_paquetes_horarios
end type
type dw_1z from datawindow within w_mad_repo_paquetes_horarios
end type
type cb_1 from commandbutton within w_mad_repo_paquetes_horarios
end type
type gb_grupo from groupbox within w_mad_repo_paquetes_horarios
end type
type gb_8 from groupbox within w_mad_repo_paquetes_horarios
end type
type gb_11 from groupbox within w_mad_repo_paquetes_horarios
end type
type gb_20 from groupbox within w_mad_repo_paquetes_horarios
end type
type dw_1x from datawindow within w_mad_repo_paquetes_horarios
end type
type gb_1 from groupbox within w_mad_repo_paquetes_horarios
end type
end forward

global type w_mad_repo_paquetes_horarios from window
integer x = 832
integer y = 364
integer width = 3639
integer height = 2120
boolean titlebar = true
string title = "Reporte de Paquetes de Primer Ingreso"
string menuname = "m_repo_mad7"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
ddlb_tipo_imp ddlb_tipo_imp
st_2 st_2
uo_periodo uo_periodo
uo_carreras uo_carreras
st_1 st_1
uo_materias uo_materias
em_grupo em_grupo
em_anio em_anio
st_3 st_3
dw_1z dw_1z
cb_1 cb_1
gb_grupo gb_grupo
gb_8 gb_8
gb_11 gb_11
gb_20 gb_20
dw_1x dw_1x
gb_1 gb_1
end type
global w_mad_repo_paquetes_horarios w_mad_repo_paquetes_horarios

type variables
integer ii_tipo_imp, ii_num_resize = 0
int periodo_x[]
STRING is_descripcion_periodo 
end variables

on w_mad_repo_paquetes_horarios.create
if this.MenuName = "m_repo_mad7" then this.MenuID = create m_repo_mad7
this.ddlb_tipo_imp=create ddlb_tipo_imp
this.st_2=create st_2
this.uo_periodo=create uo_periodo
this.uo_carreras=create uo_carreras
this.st_1=create st_1
this.uo_materias=create uo_materias
this.em_grupo=create em_grupo
this.em_anio=create em_anio
this.st_3=create st_3
this.dw_1z=create dw_1z
this.cb_1=create cb_1
this.gb_grupo=create gb_grupo
this.gb_8=create gb_8
this.gb_11=create gb_11
this.gb_20=create gb_20
this.dw_1x=create dw_1x
this.gb_1=create gb_1
this.Control[]={this.ddlb_tipo_imp,&
this.st_2,&
this.uo_periodo,&
this.uo_carreras,&
this.st_1,&
this.uo_materias,&
this.em_grupo,&
this.em_anio,&
this.st_3,&
this.dw_1z,&
this.cb_1,&
this.gb_grupo,&
this.gb_8,&
this.gb_11,&
this.gb_20,&
this.dw_1x,&
this.gb_1}
end on

on w_mad_repo_paquetes_horarios.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddlb_tipo_imp)
destroy(this.st_2)
destroy(this.uo_periodo)
destroy(this.uo_carreras)
destroy(this.st_1)
destroy(this.uo_materias)
destroy(this.em_grupo)
destroy(this.em_anio)
destroy(this.st_3)
destroy(this.dw_1z)
destroy(this.cb_1)
destroy(this.gb_grupo)
destroy(this.gb_8)
destroy(this.gb_11)
destroy(this.gb_20)
destroy(this.dw_1x)
destroy(this.gb_1)
end on

event open;
// Se inicializa el objeto de periodos
THIS.uo_periodo.of_inicializa_servicio( "H", "L", "L", "N", gtr_sce)
ddlb_tipo_imp.selectitem(2)
this.x=1
this.y=1
end event

event resize;long ll_height_win, ll_height_dw, ll_dif_height_tab, ll_height_tab, ll_width_tab, ll_height_tab_final

if ii_num_resize > 0 then
	ll_height_dw = dw_1z.height
	ll_height_win = this.height

	ll_height_tab = dw_1z.height
	ll_width_tab = dw_1z.width

	dw_1z.width = newwidth - 50
	dw_1z.height = newheight - 600
	
	ll_height_tab_final = dw_1z.height
	
	ll_dif_height_tab = ll_height_tab_final - ll_height_tab  

	dw_1z.width = newwidth - 200
	dw_1z.height = ll_height_dw + ll_dif_height_tab
else
	ii_num_resize = ii_num_resize +1
end if
end event

type ddlb_tipo_imp from dropdownlistbox within w_mad_repo_paquetes_horarios
integer x = 2985
integer y = 236
integer width = 549
integer height = 384
integer taborder = 80
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

type st_2 from statictext within w_mad_repo_paquetes_horarios
integer x = 2478
integer y = 252
integer width = 498
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12632256
string text = "Tipo impartición:"
boolean focusrectangle = false
end type

type uo_periodo from uo_periodo_variable_tipos within w_mad_repo_paquetes_horarios
integer x = 425
integer y = 124
integer width = 1742
integer height = 180
integer taborder = 50
end type

on uo_periodo.destroy
call uo_periodo_variable_tipos::destroy
end on

type uo_carreras from uo_carrera_sce within w_mad_repo_paquetes_horarios
integer x = 1559
integer y = 344
integer taborder = 110
boolean enabled = true
long backcolor = 1090519039
end type

on uo_carreras.destroy
call uo_carrera_sce::destroy
end on

type st_1 from statictext within w_mad_repo_paquetes_horarios
integer x = 2601
integer y = 128
integer width = 375
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "% Para todos"
boolean focusrectangle = false
end type

type uo_materias from uo_materia_sce within w_mad_repo_paquetes_horarios
integer x = 50
integer y = 344
integer width = 1431
integer height = 204
integer taborder = 100
boolean enabled = true
long backcolor = 1090519039
end type

on uo_materias.destroy
call uo_materia_sce::destroy
end on

type em_grupo from editmask within w_mad_repo_paquetes_horarios
integer x = 2327
integer y = 128
integer width = 201
integer height = 80
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!"
end type

type em_anio from editmask within w_mad_repo_paquetes_horarios
integer x = 96
integer y = 124
integer width = 219
integer height = 80
integer taborder = 50
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


periodo_actual(periodo,anio,gtr_sce)

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
end event

event modified;long fecha

fecha = long(this.text)
if fecha < 1900 then
   messagebox ("Información", "El año DEBE ser mayor a 1900")
	this.SelectText(1, Len(this.Text))
	this.setfocus()
end if
end event

type st_3 from statictext within w_mad_repo_paquetes_horarios
integer x = 3081
integer y = 124
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

type dw_1z from datawindow within w_mad_repo_paquetes_horarios
integer y = 572
integer width = 3589
integer height = 1324
integer taborder = 80
string dataobject = "dw_repo_paquetes_horarios"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
m_repo_mad7.dw = this


//Orientación Landscape
this.Object.DataWindow.Print.Orientation	= 1

//Zoom Reducido
this.Object.DataWindow.Zoom = 92	
this.Object.DataWindow.Print.Preview.Zoom = 92	

end event

event retrieveend;/*Cuando dw_1 termine de leer los datos de la tabla...*/


string Cont
Cont = '0'
/*Verifica si se bajo más de un dato*/
if rowcount >= 1 then
	// Se actualiza el numero de datos traidos
	Cont =string(rowcount)	
	st_3.text='Total : '+Cont
else
	st_3.text='Total : '+Cont
end if

end event

type cb_1 from commandbutton within w_mad_repo_paquetes_horarios
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 3186
integer y = 420
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

event clicked;/* Se le pasa el arreglo al datawindow*/

int Total, Plan_GO
int contador, li_periodo, li_anio
long ll_materia
int li_carrera

int Salones[]
long Anio_X
string Nivel_X[], ls_grupo, ls_anio

long ll_row, ll_row2


ll_row = parent.uo_materias.dw_carrera.GetRow()
ll_materia = parent.uo_materias.dw_carrera.object.cve_mat[ll_row]

ll_row = parent.uo_carreras.dw_carrera.GetRow()
li_carrera = parent.uo_carreras.dw_carrera.object.cve_carrera[ll_row]


setpointer(Hourglass!)
ls_grupo = em_grupo.text
ls_anio = em_anio.text
li_anio = integer(ls_anio)

//if rb_primavera.checked = false and rb_verano.checked = false and rb_otonio.checked = false then
//	MessageBox("Periodo Requerido", "Favor de seleccionar un periodo")
//	return
//end if

if isnull(ls_grupo) or (len(ls_grupo) <1) or ls_grupo = "" then
	MessageBox("Grupo Requerido", "Favor de seleccionar un grupo")
	return
end if

//if rb_primavera.checked then
//	li_periodo = 0
//elseif rb_verano.checked then
//	li_periodo = 1
//elseif rb_otonio.checked then
//	li_periodo = 2	
//end if

//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**		
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	
INTEGER le_index
INTEGER le_periodo[] 
STRING ls_tipo_periodo[]
//STRING is_descripcion_periodo

PARENT.uo_periodo.of_recupera_periodos() 

periodo_x[] = le_periodo[]
is_descripcion_periodo = ""
FOR le_index = 1 TO UPPERBOUND(PARENT.uo_periodo.istr_periodos[])
	IF TRIM(is_descripcion_periodo) <> "" THEN is_descripcion_periodo = is_descripcion_periodo + ", "
	is_descripcion_periodo = is_descripcion_periodo + PARENT.uo_periodo.istr_periodos[le_index].descripcion 
	periodo_x[le_index] = PARENT.uo_periodo.istr_periodos[le_index].periodo
	ls_tipo_periodo[le_index] = PARENT.uo_periodo.istr_periodos[le_index].tipo
NEXT 	
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**		
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	

IF ii_tipo_imp = 0 THEN ii_tipo_imp = 1 // 1 = Tradicional	

//dw_1z.Retrieve(li_periodo,li_anio,ll_materia,ls_grupo,li_carrera)
dw_1z.Retrieve(periodo_x[],li_anio,ll_materia,ls_grupo,li_carrera,ii_tipo_imp)




end event

event constructor;TabOrder = 4
end event

type gb_grupo from groupbox within w_mad_repo_paquetes_horarios
integer x = 2267
integer y = 72
integer width = 315
integer height = 160
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Grupo"
borderstyle borderstyle = styleraised!
end type

type gb_8 from groupbox within w_mad_repo_paquetes_horarios
integer x = 3150
integer y = 372
integer width = 329
integer height = 176
integer taborder = 110
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_11 from groupbox within w_mad_repo_paquetes_horarios
integer x = 50
integer y = 64
integer width = 315
integer height = 160
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Año"
borderstyle borderstyle = styleraised!
end type

type gb_20 from groupbox within w_mad_repo_paquetes_horarios
integer x = 398
integer y = 64
integer width = 1806
integer height = 264
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

type dw_1x from datawindow within w_mad_repo_paquetes_horarios
boolean visible = false
integer x = 3767
integer y = 624
integer width = 1038
integer height = 564
integer taborder = 70
boolean bringtotop = true
string dataobject = "dw_repo_mad_18_gx"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
//m_repo_mad7.dw = this
end event

type gb_1 from groupbox within w_mad_repo_paquetes_horarios
integer x = 9
integer width = 3589
integer height = 568
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
