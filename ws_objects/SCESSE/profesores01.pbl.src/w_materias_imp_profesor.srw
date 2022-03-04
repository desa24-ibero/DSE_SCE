$PBExportHeader$w_materias_imp_profesor.srw
forward
global type w_materias_imp_profesor from window
end type
type uo_1 from uo_per_ani within w_materias_imp_profesor
end type
type uo_profesor from uo_nombre_profesor_tot within w_materias_imp_profesor
end type
type st_3 from statictext within w_materias_imp_profesor
end type
type dw_estadisticas from datawindow within w_materias_imp_profesor
end type
type cb_1 from commandbutton within w_materias_imp_profesor
end type
type em_anio from editmask within w_materias_imp_profesor
end type
type rb_otonio from radiobutton within w_materias_imp_profesor
end type
type rb_verano from radiobutton within w_materias_imp_profesor
end type
type rb_primavera from radiobutton within w_materias_imp_profesor
end type
type dw_1x from datawindow within w_materias_imp_profesor
end type
type gb_8 from groupbox within w_materias_imp_profesor
end type
type gb_11 from groupbox within w_materias_imp_profesor
end type
type gb_20 from groupbox within w_materias_imp_profesor
end type
type gb_1 from groupbox within w_materias_imp_profesor
end type
end forward

global type w_materias_imp_profesor from window
integer width = 4434
integer height = 2452
boolean titlebar = true
string title = "Materias Impartidas por Profesor"
string menuname = "m_materias_imp_profesor"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
uo_1 uo_1
uo_profesor uo_profesor
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
gb_1 gb_1
end type
global w_materias_imp_profesor w_materias_imp_profesor

type variables
int periodo_x
uo_periodo_servicios iuo_periodo_servicios
end variables

on w_materias_imp_profesor.create
if this.MenuName = "m_materias_imp_profesor" then this.MenuID = create m_materias_imp_profesor
this.uo_1=create uo_1
this.uo_profesor=create uo_profesor
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
this.gb_1=create gb_1
this.Control[]={this.uo_1,&
this.uo_profesor,&
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
this.gb_1}
end on

on w_materias_imp_profesor.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.uo_profesor)
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
destroy(this.gb_1)
end on

event open;this.x=1
this.y=1

	//Modif. Roberto Novoa R.  Jun/2016 - Funcionalidad de periodos múltiples
	iuo_periodo_servicios = CREATE uo_periodo_servicios
	iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)
//	st_periodo.text = iuo_periodo_servicios.f_recupera_descripcion(ii_periodo , "L")

end event

type uo_1 from uo_per_ani within w_materias_imp_profesor
integer x = 448
integer y = 144
integer taborder = 100
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type uo_profesor from uo_nombre_profesor_tot within w_materias_imp_profesor
integer x = 27
integer y = 380
integer width = 2802
integer height = 256
integer taborder = 80
boolean enabled = true
end type

on uo_profesor.destroy
call uo_nombre_profesor_tot::destroy
end on

type st_3 from statictext within w_materias_imp_profesor
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

type dw_estadisticas from datawindow within w_materias_imp_profesor
integer y = 660
integer width = 4361
integer height = 1544
integer taborder = 60
string dataobject = "d_materias_imp_profesor"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
m_materias_imp_profesor.dw= this
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

type cb_1 from commandbutton within w_materias_imp_profesor
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 3186
integer y = 220
integer width = 265
integer height = 108
integer taborder = 70
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
long ll_row_carrera, ll_cve_carrera, ll_cve_profesor
datetime ldttm_fecha_servidor
string ls_cve_profesor

ls_cve_profesor = parent.uo_profesor.em_cve_profesor.Text
if not isnumber(ls_cve_profesor) then
	MessageBox("Error", "Es necesario seleccionar un Profesor Valido", StopSign!)
	return
else	
	ll_cve_profesor  = long(ls_cve_profesor)
end if

	//Modif. Roberto Novoa R.  Jun/2016 - Funcionalidad de periodos múltiples
	ls_periodo=uo_1.em_per.text
	li_periodo=uo_1.iuo_periodo_servicios.f_recupera_id( ls_periodo, "L")


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

dw_estadisticas.object.periodo_anio.text= ls_periodo_elegido
dw_estadisticas.object.st_fecha_hoy.text= ls_fecha_servidor

dw_estadisticas.Retrieve(li_periodo, li_anio, ll_cve_profesor)






end event

event constructor;TabOrder = 4
end event

type em_anio from editmask within w_materias_imp_profesor
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
this.enabled = FALSE
rb_primavera.enabled = FALSE
rb_verano.enabled = FALSE
rb_otonio.enabled = FALSE
		

		
end event

event modified;long fecha

fecha = long(this.text)
if fecha < 1900 then
   messagebox ("Información", "El año DEBE ser mayor a 1900")
	this.SelectText(1, Len(this.Text))
	this.setfocus()
end if
end event

type rb_otonio from radiobutton within w_materias_imp_profesor
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 2917
integer y = 824
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

type rb_verano from radiobutton within w_materias_imp_profesor
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 2560
integer y = 824
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

type rb_primavera from radiobutton within w_materias_imp_profesor
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 2176
integer y = 824
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

type dw_1x from datawindow within w_materias_imp_profesor
boolean visible = false
integer x = 3767
integer y = 624
integer width = 1038
integer height = 564
integer taborder = 50
string dataobject = "dw_repo_mad_18_gx"
boolean livescroll = true
end type

type gb_8 from groupbox within w_materias_imp_profesor
integer x = 3150
integer y = 172
integer width = 329
integer height = 176
integer taborder = 90
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_11 from groupbox within w_materias_imp_profesor
integer x = 37
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

type gb_20 from groupbox within w_materias_imp_profesor
integer x = 411
integer y = 72
integer width = 1312
integer height = 256
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Periodo"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_materias_imp_profesor
boolean visible = false
integer x = 91
integer y = 752
integer width = 3589
integer height = 452
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

