$PBExportHeader$w_tcap_reconocimientos.srw
forward
global type w_tcap_reconocimientos from window
end type
type st_4 from statictext within w_tcap_reconocimientos
end type
type uoi_coordinaciones from uo_coordinaciones within w_tcap_reconocimientos
end type
type rb_posgrado from radiobutton within w_tcap_reconocimientos
end type
type rb_licenciatura from radiobutton within w_tcap_reconocimientos
end type
type em_no_acta from editmask within w_tcap_reconocimientos
end type
type st_2 from statictext within w_tcap_reconocimientos
end type
type uo_profesor from uo_nombre_profesor within w_tcap_reconocimientos
end type
type uo_grupo from uo_grupos_filtro within w_tcap_reconocimientos
end type
type st_1 from statictext within w_tcap_reconocimientos
end type
type uo_departamento from uo_departamentos_tcap within w_tcap_reconocimientos
end type
type rb_departamento from radiobutton within w_tcap_reconocimientos
end type
type rb_5 from radiobutton within w_tcap_reconocimientos
end type
type rb_4 from radiobutton within w_tcap_reconocimientos
end type
type rb_3 from radiobutton within w_tcap_reconocimientos
end type
type rb_grupo from radiobutton within w_tcap_reconocimientos
end type
type rb_profesor from radiobutton within w_tcap_reconocimientos
end type
type gb_coordinacion from groupbox within w_tcap_reconocimientos
end type
type st_3 from statictext within w_tcap_reconocimientos
end type
type dw_estadisticas from datawindow within w_tcap_reconocimientos
end type
type cb_1 from commandbutton within w_tcap_reconocimientos
end type
type em_anio from editmask within w_tcap_reconocimientos
end type
type rb_otonio from radiobutton within w_tcap_reconocimientos
end type
type rb_verano from radiobutton within w_tcap_reconocimientos
end type
type rb_primavera from radiobutton within w_tcap_reconocimientos
end type
type dw_1x from datawindow within w_tcap_reconocimientos
end type
type gb_8 from groupbox within w_tcap_reconocimientos
end type
type gb_11 from groupbox within w_tcap_reconocimientos
end type
type gb_20 from groupbox within w_tcap_reconocimientos
end type
type gb_1 from groupbox within w_tcap_reconocimientos
end type
end forward

global type w_tcap_reconocimientos from window
integer width = 6894
integer height = 3504
boolean titlebar = true
string title = "Generación de Reconocimientos"
string menuname = "m_estad_alum_mat"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
st_4 st_4
uoi_coordinaciones uoi_coordinaciones
rb_posgrado rb_posgrado
rb_licenciatura rb_licenciatura
em_no_acta em_no_acta
st_2 st_2
uo_profesor uo_profesor
uo_grupo uo_grupo
st_1 st_1
uo_departamento uo_departamento
rb_departamento rb_departamento
rb_5 rb_5
rb_4 rb_4
rb_3 rb_3
rb_grupo rb_grupo
rb_profesor rb_profesor
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
gb_1 gb_1
end type
global w_tcap_reconocimientos w_tcap_reconocimientos

type variables
int periodo_x

integer ii_periodo, ii_anio
end variables

on w_tcap_reconocimientos.create
if this.MenuName = "m_estad_alum_mat" then this.MenuID = create m_estad_alum_mat
this.st_4=create st_4
this.uoi_coordinaciones=create uoi_coordinaciones
this.rb_posgrado=create rb_posgrado
this.rb_licenciatura=create rb_licenciatura
this.em_no_acta=create em_no_acta
this.st_2=create st_2
this.uo_profesor=create uo_profesor
this.uo_grupo=create uo_grupo
this.st_1=create st_1
this.uo_departamento=create uo_departamento
this.rb_departamento=create rb_departamento
this.rb_5=create rb_5
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_grupo=create rb_grupo
this.rb_profesor=create rb_profesor
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
this.gb_1=create gb_1
this.Control[]={this.st_4,&
this.uoi_coordinaciones,&
this.rb_posgrado,&
this.rb_licenciatura,&
this.em_no_acta,&
this.st_2,&
this.uo_profesor,&
this.uo_grupo,&
this.st_1,&
this.uo_departamento,&
this.rb_departamento,&
this.rb_5,&
this.rb_4,&
this.rb_3,&
this.rb_grupo,&
this.rb_profesor,&
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
this.gb_1}
end on

on w_tcap_reconocimientos.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_4)
destroy(this.uoi_coordinaciones)
destroy(this.rb_posgrado)
destroy(this.rb_licenciatura)
destroy(this.em_no_acta)
destroy(this.st_2)
destroy(this.uo_profesor)
destroy(this.uo_grupo)
destroy(this.st_1)
destroy(this.uo_departamento)
destroy(this.rb_departamento)
destroy(this.rb_5)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_grupo)
destroy(this.rb_profesor)
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
destroy(this.gb_1)
end on

event open;this.x=1
this.y=1
uo_departamento.backcolor = this.backcolor
uo_departamento.enabled = true

uo_grupo.rb_editar.visible = false
uo_grupo.rb_insertar.visible = false

dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")
end event

type st_4 from statictext within w_tcap_reconocimientos
integer x = 101
integer y = 1000
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Coordinación"
boolean focusrectangle = false
end type

type uoi_coordinaciones from uo_coordinaciones within w_tcap_reconocimientos
integer x = 594
integer y = 976
integer taborder = 90
boolean border = false
end type

on uoi_coordinaciones.destroy
call uo_coordinaciones::destroy
end on

type rb_posgrado from radiobutton within w_tcap_reconocimientos
integer x = 1033
integer y = 824
integer width = 421
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Posgrado"
end type

type rb_licenciatura from radiobutton within w_tcap_reconocimientos
integer x = 1033
integer y = 720
integer width = 421
integer height = 112
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Licenciatura"
boolean checked = true
end type

type em_no_acta from editmask within w_tcap_reconocimientos
integer x = 544
integer y = 688
integer width = 347
integer height = 112
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "####"
end type

type st_2 from statictext within w_tcap_reconocimientos
integer x = 73
integer y = 712
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "No. de Acta"
boolean focusrectangle = false
end type

type uo_profesor from uo_nombre_profesor within w_tcap_reconocimientos
integer x = 27
integer y = 32
integer taborder = 30
boolean enabled = true
end type

on uo_profesor.destroy
call uo_nombre_profesor::destroy
end on

type uo_grupo from uo_grupos_filtro within w_tcap_reconocimientos
integer x = 14
integer y = 228
integer width = 2789
integer height = 228
integer taborder = 70
boolean border = false
long backcolor = 0
long tabtextcolor = 0
long picturemaskcolor = 0
string is_estatus = ""
end type

on uo_grupo.destroy
call uo_grupos_filtro::destroy
end on

type st_1 from statictext within w_tcap_reconocimientos
integer x = 69
integer y = 516
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Departamento"
boolean focusrectangle = false
end type

type uo_departamento from uo_departamentos_tcap within w_tcap_reconocimientos
integer x = 535
integer y = 472
integer taborder = 60
boolean border = false
end type

on uo_departamento.destroy
call uo_departamentos_tcap::destroy
end on

type rb_departamento from radiobutton within w_tcap_reconocimientos
integer x = 2898
integer y = 680
integer width = 745
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Por Coordinación"
end type

event clicked;dw_estadisticas.dataobject = "d_reconocimientos_departamento_tcap"
dw_estadisticas.SetTransObject(gtr_sce)

dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")
end event

type rb_5 from radiobutton within w_tcap_reconocimientos
boolean visible = false
integer x = 128
integer y = 896
integer width = 1271
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12632256
string text = "Alumnos Inscritas por Carrera y Actividad"
end type

event clicked;dw_estadisticas.dataobject = "d_dgmu_inscritos_act_ext"
dw_estadisticas.SetTransObject(gtr_sce)

end event

type rb_4 from radiobutton within w_tcap_reconocimientos
boolean visible = false
integer x = 1266
integer y = 580
integer width = 1271
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12632256
string text = "Materias Inscritas por Carrera"
end type

event clicked;dw_estadisticas.dataobject = "d_dgmu_mi_carr"
dw_estadisticas.SetTransObject(gtr_sce)

end event

type rb_3 from radiobutton within w_tcap_reconocimientos
boolean visible = false
integer x = 1266
integer y = 492
integer width = 1504
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12632256
string text = "Materias Inscritas por Coordinación, Materia y Carrera"
end type

event clicked;dw_estadisticas.dataobject = "d_dgmu_mi_coord_carr"
dw_estadisticas.SetTransObject(gtr_sce)

end event

type rb_grupo from radiobutton within w_tcap_reconocimientos
integer x = 2898
integer y = 592
integer width = 745
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Por Grupo"
end type

event clicked;dw_estadisticas.dataobject = "d_reconocimientos_grupo_tcap"
dw_estadisticas.SetTransObject(gtr_sce)

dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")
end event

type rb_profesor from radiobutton within w_tcap_reconocimientos
integer x = 2898
integer y = 504
integer width = 745
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Por Profesor "
boolean checked = true
end type

event clicked;dw_estadisticas.dataobject = "d_reconocimientos_profesor_tcap"
dw_estadisticas.SetTransObject(gtr_sce)

dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")
end event

type gb_coordinacion from groupbox within w_tcap_reconocimientos
integer x = 2857
integer y = 440
integer width = 882
integer height = 356
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Actas a Generar"
borderstyle borderstyle = styleraised!
end type

type st_3 from statictext within w_tcap_reconocimientos
integer x = 2194
integer y = 644
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

type dw_estadisticas from datawindow within w_tcap_reconocimientos
integer x = 151
integer y = 1184
integer width = 4466
integer height = 2032
integer taborder = 80
string dataobject = "d_reconocimientos_profesor_tcap"
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

type cb_1 from commandbutton within w_tcap_reconocimientos
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 2281
integer y = 480
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
long ll_cve_depto
long ll_cuenta
long ll_cve_firma = 1
long ll_cve_mat = 0
string ls_gpo = ""
long ll_cve_profesor


ll_cve_mat = uo_grupo.il_cve_mat
ls_gpo = uo_grupo.is_gpo



ll_cve_profesor = uo_profesor.of_obten_cve_profesor()
ll_cve_depto = uo_departamento.of_obten_cve_depto()

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
ldttm_fecha_servidor = fecha_servidor(gtr_sce)
ls_fecha_servidor= string(ldttm_fecha_servidor, "dd/mm/yyyy hh:mm")

ls_periodo_elegido =ls_periodo +" "+ ls_anio

//dw_estadisticas.object.periodo_anio.text= ls_periodo_elegido
//dw_estadisticas.object.st_fecha_hoy.text= ls_fecha_servidor
//

dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")

dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")

//Diplomas por Alumno
if rb_profesor.checked then
	MessageBox("Generando Reporte", "Por Profesor",Information!)
	ll_rows = dw_estadisticas.Retrieve(ll_cve_profesor, li_periodo, li_anio, ll_cve_firma)
//Diplomas por Grupo
elseif rb_grupo.checked then
	if not f_existe_grupo(ll_cve_mat, ls_gpo, li_periodo, li_anio) then
		MessageBox("Grupo Inexistente", "El grupo "+string(ll_cve_mat)+":"+ls_gpo+" No existe.",StopSign!)
		return 
	end if	
	MessageBox("Generando Reporte", "Por Grupo",Information!)
	ll_rows = dw_estadisticas.Retrieve(ll_cve_mat, ls_gpo, li_periodo, li_anio, ll_cve_firma)
//Diplomas por Departamento
elseif rb_departamento.checked then
	MessageBox("Generando Reporte", "Por Departamento",Information!)
	ll_rows = dw_estadisticas.Retrieve(ll_cve_depto, li_periodo, li_anio, ll_cve_firma)
end if

dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")



	







end event

event constructor;TabOrder = 4
end event

type em_anio from editmask within w_tcap_reconocimientos
event constructor pbm_constructor
event modified pbm_enmodified
integer x = 3447
integer y = 96
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

type rb_otonio from radiobutton within w_tcap_reconocimientos
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 2889
integer y = 260
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Otoño"
end type

event clicked;periodo_x = 2
end event

type rb_verano from radiobutton within w_tcap_reconocimientos
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 2889
integer y = 180
integer width = 270
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Verano"
end type

event clicked;periodo_x = 1
end event

type rb_primavera from radiobutton within w_tcap_reconocimientos
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 2889
integer y = 104
integer width = 343
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Primavera"
end type

event clicked;periodo_x = 0
end event

type dw_1x from datawindow within w_tcap_reconocimientos
boolean visible = false
integer x = 3767
integer y = 624
integer width = 1038
integer height = 564
integer taborder = 70
string dataobject = "dw_repo_mad_18_gx"
boolean livescroll = true
end type

type gb_8 from groupbox within w_tcap_reconocimientos
integer x = 2249
integer y = 436
integer width = 329
integer height = 176
integer taborder = 100
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type gb_11 from groupbox within w_tcap_reconocimientos
integer x = 3401
integer y = 36
integer width = 315
integer height = 160
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Año"
borderstyle borderstyle = styleraised!
end type

type gb_20 from groupbox within w_tcap_reconocimientos
integer x = 2857
integer y = 40
integer width = 489
integer height = 332
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Periodo"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_tcap_reconocimientos
integer x = 978
integer y = 660
integer width = 553
integer height = 300
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nivel"
end type

