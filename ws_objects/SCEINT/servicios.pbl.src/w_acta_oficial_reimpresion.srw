﻿$PBExportHeader$w_acta_oficial_reimpresion.srw
forward
global type w_acta_oficial_reimpresion from window
end type
type uo_nivel from uo_nivel_rbutton within w_acta_oficial_reimpresion
end type
type rb_a_titulo from radiobutton within w_acta_oficial_reimpresion
end type
type rb_ordinario from radiobutton within w_acta_oficial_reimpresion
end type
type rb_extrao from radiobutton within w_acta_oficial_reimpresion
end type
type st_servername from statictext within w_acta_oficial_reimpresion
end type
type rb_acta_nivel from radiobutton within w_acta_oficial_reimpresion
end type
type st_4 from statictext within w_acta_oficial_reimpresion
end type
type uoi_coordinaciones from uo_coordinaciones within w_acta_oficial_reimpresion
end type
type em_no_acta from editmask within w_acta_oficial_reimpresion
end type
type st_2 from statictext within w_acta_oficial_reimpresion
end type
type uo_profesor from uo_nombre_profesor within w_acta_oficial_reimpresion
end type
type uo_grupo from uo_grupos_filtro within w_acta_oficial_reimpresion
end type
type rb_departamento from radiobutton within w_acta_oficial_reimpresion
end type
type rb_5 from radiobutton within w_acta_oficial_reimpresion
end type
type rb_4 from radiobutton within w_acta_oficial_reimpresion
end type
type rb_3 from radiobutton within w_acta_oficial_reimpresion
end type
type rb_grupo from radiobutton within w_acta_oficial_reimpresion
end type
type rb_profesor from radiobutton within w_acta_oficial_reimpresion
end type
type gb_coordinacion from groupbox within w_acta_oficial_reimpresion
end type
type st_3 from statictext within w_acta_oficial_reimpresion
end type
type dw_estadisticas from datawindow within w_acta_oficial_reimpresion
end type
type cb_1 from commandbutton within w_acta_oficial_reimpresion
end type
type em_anio from editmask within w_acta_oficial_reimpresion
end type
type dw_1x from datawindow within w_acta_oficial_reimpresion
end type
type gb_8 from groupbox within w_acta_oficial_reimpresion
end type
type gb_11 from groupbox within w_acta_oficial_reimpresion
end type
type gb_20 from groupbox within w_acta_oficial_reimpresion
end type
type gb_1 from groupbox within w_acta_oficial_reimpresion
end type
type gb_tipo_examen from groupbox within w_acta_oficial_reimpresion
end type
type uo_periodos from uo_periodo_variable_tipos within w_acta_oficial_reimpresion
end type
end forward

global type w_acta_oficial_reimpresion from window
integer width = 6894
integer height = 3504
boolean titlebar = true
string title = "Reimpresión de Actas"
string menuname = "m_estad_alum_mat"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
uo_nivel uo_nivel
rb_a_titulo rb_a_titulo
rb_ordinario rb_ordinario
rb_extrao rb_extrao
st_servername st_servername
rb_acta_nivel rb_acta_nivel
st_4 st_4
uoi_coordinaciones uoi_coordinaciones
em_no_acta em_no_acta
st_2 st_2
uo_profesor uo_profesor
uo_grupo uo_grupo
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
dw_1x dw_1x
gb_8 gb_8
gb_11 gb_11
gb_20 gb_20
gb_1 gb_1
gb_tipo_examen gb_tipo_examen
uo_periodos uo_periodos
end type
global w_acta_oficial_reimpresion w_acta_oficial_reimpresion

type variables
int periodo_x

integer ii_periodo, ii_anio



transaction itr_web

end variables

on w_acta_oficial_reimpresion.create
if this.MenuName = "m_estad_alum_mat" then this.MenuID = create m_estad_alum_mat
this.uo_nivel=create uo_nivel
this.rb_a_titulo=create rb_a_titulo
this.rb_ordinario=create rb_ordinario
this.rb_extrao=create rb_extrao
this.st_servername=create st_servername
this.rb_acta_nivel=create rb_acta_nivel
this.st_4=create st_4
this.uoi_coordinaciones=create uoi_coordinaciones
this.em_no_acta=create em_no_acta
this.st_2=create st_2
this.uo_profesor=create uo_profesor
this.uo_grupo=create uo_grupo
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
this.dw_1x=create dw_1x
this.gb_8=create gb_8
this.gb_11=create gb_11
this.gb_20=create gb_20
this.gb_1=create gb_1
this.gb_tipo_examen=create gb_tipo_examen
this.uo_periodos=create uo_periodos
this.Control[]={this.uo_nivel,&
this.rb_a_titulo,&
this.rb_ordinario,&
this.rb_extrao,&
this.st_servername,&
this.rb_acta_nivel,&
this.st_4,&
this.uoi_coordinaciones,&
this.em_no_acta,&
this.st_2,&
this.uo_profesor,&
this.uo_grupo,&
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
this.dw_1x,&
this.gb_8,&
this.gb_11,&
this.gb_20,&
this.gb_1,&
this.gb_tipo_examen,&
this.uo_periodos}
end on

on w_acta_oficial_reimpresion.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nivel)
destroy(this.rb_a_titulo)
destroy(this.rb_ordinario)
destroy(this.rb_extrao)
destroy(this.st_servername)
destroy(this.rb_acta_nivel)
destroy(this.st_4)
destroy(this.uoi_coordinaciones)
destroy(this.em_no_acta)
destroy(this.st_2)
destroy(this.uo_profesor)
destroy(this.uo_grupo)
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
destroy(this.dw_1x)
destroy(this.gb_8)
destroy(this.gb_11)
destroy(this.gb_20)
destroy(this.gb_1)
destroy(this.gb_tipo_examen)
destroy(this.uo_periodos)
end on

event open;integer li_evento_baja_total = 11, li_proceso_en_captura = 4, li_proceso_transferidas = 7
int li_periodo,li_anio
string ls_periodo, ls_anio

this.x=1
this.y=1

//iuo_periodo_servicios = CREATE uo_periodo_variable_tipos

uoi_coordinaciones.of_coordinaciones_completas( )
//uo_nivel.f_genera_nivel( "V", gtr_sce) 
uo_nivel.f_genera_nivel( "V", "C", "L", gtr_sce) 

uo_periodos.of_recupera_periodos()
uo_periodos.of_inicializa_servicio( "H", "L", "L",gs_tipo_periodo,gtr_sce)

uoi_coordinaciones.backcolor = this.backcolor
uoi_coordinaciones.enabled = true

uo_grupo.rb_editar.visible = false
uo_grupo.rb_insertar.visible = false

dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")

if conecta_bd(itr_web,gs_sweb, gs_usuario, gs_password)<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	close(this)
end if

f_obten_periodo(li_periodo,li_anio,li_evento_baja_total)

li_proceso_transferidas = f_obten_estatus_proceso_actas(7, li_periodo,li_anio, gtr_sce)

IF IsValid(This) THEN 
	//Si las actas ya se transfirieron de SQL a SYBASE las consultas serán en EN BD CS, de lo contrario seran en BD WEB
	IF li_proceso_transferidas = 1 THEN
		st_servername.text = 'SYBASE:'+gtr_sce.ServerName
		dw_estadisticas.SetTransObject(gtr_sce)
	ELSE
		st_servername.text = 'SQLSERVER:'+itr_web.Dbparm
		dw_estadisticas.SetTransObject(itr_web)
	END IF
END IF
end event

type uo_nivel from uo_nivel_rbutton within w_acta_oficial_reimpresion
integer x = 978
integer y = 676
integer width = 521
integer height = 288
integer taborder = 90
end type

on uo_nivel.destroy
call uo_nivel_rbutton::destroy
end on

type rb_a_titulo from radiobutton within w_acta_oficial_reimpresion
integer x = 1650
integer y = 916
integer width = 946
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "A Título de Suficiencia"
end type

type rb_ordinario from radiobutton within w_acta_oficial_reimpresion
integer x = 1650
integer y = 740
integer width = 407
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ordinario"
boolean checked = true
end type

type rb_extrao from radiobutton within w_acta_oficial_reimpresion
integer x = 1650
integer y = 828
integer width = 946
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Extraordinario"
end type

type st_servername from statictext within w_acta_oficial_reimpresion
integer x = 151
integer y = 1020
integer width = 4466
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "SERVIDOR"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type rb_acta_nivel from radiobutton within w_acta_oficial_reimpresion
integer x = 2875
integer y = 880
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
string text = "Por Acta y Nivel"
boolean checked = true
end type

event clicked;//d_acta_oficial
integer li_evento_baja_total = 11, li_proceso_en_captura = 4, li_proceso_transferidas = 7
int li_periodo,li_anio
string ls_periodo, ls_anio

f_obten_periodo(li_periodo,li_anio,li_evento_baja_total)

li_proceso_transferidas = f_obten_estatus_proceso_actas(7, li_periodo,li_anio, gtr_sce)

if rb_ordinario.checked = true then 
	dw_estadisticas.dataobject = "d_acta_oficial_estatus"
elseif rb_extrao.checked = true or rb_a_titulo.checked  then 
	dw_estadisticas.dataobject = "d_acta_oficial_estatus_ets"
end if

//Si las actas ya se transfirieron de SQL a SYBASE las consultas serán en EN BD CS, de lo contrario seran en BD WEB
if li_proceso_transferidas = 1 then
	dw_estadisticas.SetTransObject(gtr_sce)
else
	dw_estadisticas.SetTransObject(itr_web)
end if

dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")
end event

type st_4 from statictext within w_acta_oficial_reimpresion
integer x = 178
integer y = 492
integer width = 357
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

type uoi_coordinaciones from uo_coordinaciones within w_acta_oficial_reimpresion
integer x = 594
integer y = 460
integer height = 136
integer taborder = 90
boolean border = false
end type

on uoi_coordinaciones.destroy
call uo_coordinaciones::destroy
end on

type em_no_acta from editmask within w_acta_oficial_reimpresion
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
string text = "0"
borderstyle borderstyle = stylelowered!
string mask = "####"
end type

type st_2 from statictext within w_acta_oficial_reimpresion
integer x = 174
integer y = 712
integer width = 357
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

type uo_profesor from uo_nombre_profesor within w_acta_oficial_reimpresion
integer x = 27
integer y = 32
integer taborder = 30
boolean enabled = true
end type

on uo_profesor.destroy
call uo_nombre_profesor::destroy
end on

type uo_grupo from uo_grupos_filtro within w_acta_oficial_reimpresion
integer x = 14
integer y = 228
integer width = 2784
integer height = 228
integer taborder = 70
boolean border = false
long tabtextcolor = 0
long picturemaskcolor = 0
string is_estatus = ""
end type

on uo_grupo.destroy
call uo_grupos_filtro::destroy
end on

type rb_departamento from radiobutton within w_acta_oficial_reimpresion
integer x = 2875
integer y = 792
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

event clicked;integer li_evento_baja_total = 11, li_proceso_en_captura = 4, li_proceso_transferidas = 7
int li_periodo,li_anio
string ls_periodo, ls_anio

f_obten_periodo(li_periodo,li_anio,li_evento_baja_total)

li_proceso_transferidas = f_obten_estatus_proceso_actas(7, li_periodo,li_anio, gtr_sce)

if rb_ordinario.checked = true then 
	dw_estadisticas.dataobject = "d_acta_oficial_coordinacion"
elseif rb_extrao.checked = true or rb_a_titulo.checked  then 
	dw_estadisticas.dataobject = "d_acta_oficial_coordinacion_ets"
end if

//Si las actas ya se transfirieron de SQL a SYBASE las consultas serán en EN BD CS, de lo contrario seran en BD WEB
if li_proceso_transferidas = 1 then
	dw_estadisticas.SetTransObject(gtr_sce)
else
	dw_estadisticas.SetTransObject(itr_web)
end if

dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")
end event

type rb_5 from radiobutton within w_acta_oficial_reimpresion
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

type rb_4 from radiobutton within w_acta_oficial_reimpresion
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

type rb_3 from radiobutton within w_acta_oficial_reimpresion
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

type rb_grupo from radiobutton within w_acta_oficial_reimpresion
integer x = 2875
integer y = 704
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

event clicked;integer li_evento_baja_total = 11, li_proceso_en_captura = 4, li_proceso_transferidas = 7
int li_periodo,li_anio
string ls_periodo, ls_anio

f_obten_periodo(li_periodo,li_anio,li_evento_baja_total)

li_proceso_transferidas = f_obten_estatus_proceso_actas(7, li_periodo,li_anio, gtr_sce)

if rb_ordinario.checked = true then 
	dw_estadisticas.dataobject = "d_acta_oficial_grupo"
elseif rb_extrao.checked = true or rb_a_titulo.checked  then 
	dw_estadisticas.dataobject = "d_acta_oficial_grupo_ets"
end if

//Si las actas ya se transfirieron de SQL a SYBASE las consultas serán en EN BD CS, de lo contrario seran en BD WEB
if li_proceso_transferidas = 1 then
	dw_estadisticas.SetTransObject(gtr_sce)
else
	dw_estadisticas.SetTransObject(itr_web)
end if

dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")
end event

type rb_profesor from radiobutton within w_acta_oficial_reimpresion
integer x = 2875
integer y = 616
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
string text = "Por Profesor"
end type

event clicked;integer li_evento_baja_total = 11, li_proceso_en_captura = 4, li_proceso_transferidas = 7
int li_periodo,li_anio
string ls_periodo, ls_anio

f_obten_periodo(li_periodo,li_anio,li_evento_baja_total)

li_proceso_transferidas = f_obten_estatus_proceso_actas(7, li_periodo,li_anio, gtr_sce)

if rb_ordinario.checked = true then 
	dw_estadisticas.dataobject = "d_acta_oficial_profesor"
elseif rb_extrao.checked = true or rb_a_titulo.checked  then 
	dw_estadisticas.dataobject = "d_acta_oficial_profesor_ets"
end if

//Si las actas ya se transfirieron de SQL a SYBASE las consultas serán en EN BD CS, de lo contrario seran en BD WEB
if li_proceso_transferidas = 1 then
	dw_estadisticas.SetTransObject(gtr_sce)
else
	dw_estadisticas.SetTransObject(itr_web)
end if



dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")
end event

type gb_coordinacion from groupbox within w_acta_oficial_reimpresion
integer x = 2834
integer y = 552
integer width = 882
integer height = 440
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

type st_3 from statictext within w_acta_oficial_reimpresion
boolean visible = false
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

type dw_estadisticas from datawindow within w_acta_oficial_reimpresion
integer y = 1152
integer width = 4466
integer height = 2120
integer taborder = 80
string dataobject = "d_acta_oficial_estatus"
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

event constructor;m_estad_alum_mat.dw= this
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

type cb_1 from commandbutton within w_acta_oficial_reimpresion
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
string ls_anio,  ls_periodo, ls_periodo_elegido, ls_forma_ingreso, ls_fecha_servidor
long ll_row_carrera, ll_cve_carrera, ll_row_coordinacion, ll_cve_coordinacion, ll_rows_coordinaciones
datetime ldttm_fecha_servidor
long ll_rows
long ll_cuenta
long ll_cve_firma = 1
long ll_cve_mat = 0
string ls_gpo = ""
string ls_no_acta = ""
long ll_cve_profesor
long ll_no_acta
string ls_nivel, ls_desc_nivel
integer li_cve_estatus_impresion_recibida = 4
integer li_cve_estatus_confirmada = 3, li_cve_tipo_examen = 0
integer li_proceso_transferidas

ll_cve_mat = uo_grupo.il_cve_mat
ls_gpo = uo_grupo.is_gpo

li_periodo=ii_periodo

ll_cve_profesor = uo_profesor.of_obten_cve_profesor()
ll_cve_coordinacion = uoi_coordinaciones.of_obten_cve_coordinacion()

Select descripcion into :ls_periodo from periodo where periodo=:ii_periodo using gtr_sce;

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

//if rb_licenciatura.checked then
//	ls_nivel = "L"
//	ls_desc_nivel = "Licenciatura"
//elseif rb_posgrado.checked then
//	ls_nivel = "P"
//	ls_desc_nivel = "Posgrado"
//else
//	MessageBox("Error", "Es necesario seleccionar un Nivel", StopSign!)
//	return
//end if

ls_nivel = uo_nivel.cve_nivel 
ls_desc_nivel = uo_nivel.descripcion_corta 

if rb_extrao.checked = true then
	li_cve_tipo_examen = 2
elseif rb_a_titulo.checked = true then 
	li_cve_tipo_examen = 6
end if



ls_anio = em_anio.text

if not isnumber(ls_anio) then
	MessageBox("Error", "Es necesario escribir un Año", StopSign!)
	return
end if

li_anio= integer(ls_anio)


ls_no_acta = em_no_acta.text

if not isnumber(ls_no_acta) then
	MessageBox("Error", "Es necesario escribir un acta válida", StopSign!)
	return
end if

ll_no_acta = integer(ls_no_acta)

setpointer(Hourglass!)
ldttm_fecha_servidor = fecha_servidor(gtr_sce)
ls_fecha_servidor= string(ldttm_fecha_servidor, "dd/mm/yyyy hh:mm")

ls_periodo_elegido =ls_periodo +" "+ ls_anio

//dw_estadisticas.object.periodo_anio.text= ls_periodo_elegido
//dw_estadisticas.object.st_fecha_hoy.text= ls_fecha_servidor
//

dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")

dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")

//Actas por Profesor
if rb_profesor.checked then
	MessageBox("Generando Reporte", "Por Profesor",Information!)
	ll_rows = dw_estadisticas.Retrieve(ll_cve_profesor, li_periodo, li_anio, li_cve_estatus_confirmada)
//Actas por Grupo
elseif rb_grupo.checked then
//	if not f_existe_grupo(ll_cve_mat, ls_gpo, li_periodo, li_anio) then
//		MessageBox("Grupo Inexistente", "El grupo "+string(ll_cve_mat)+":"+ls_gpo+" No existe.",StopSign!)
//		return 
//	end if	
	MessageBox("Generando Reporte", "Por Grupo",Information!)
	ll_rows = dw_estadisticas.Retrieve(ll_cve_mat, ls_gpo, li_periodo, li_anio,li_cve_estatus_confirmada)
//Actas por Coordinacion
elseif rb_departamento.checked then
	MessageBox("Generando Reporte", "Por Coordinación",Information!)
	ll_rows = dw_estadisticas.Retrieve(ll_cve_coordinacion, li_periodo, li_anio,li_cve_estatus_confirmada)
//Actas por Acta y Nivel
elseif rb_acta_nivel.checked then
	if rb_ordinario.checked = true then 
		dw_estadisticas.dataobject = "d_acta_oficial_estatus"
	elseif rb_extrao.checked = true or rb_a_titulo.checked  then 
		dw_estadisticas.dataobject = "d_acta_oficial_estatus_ets"
	end if

	li_proceso_transferidas = f_obten_estatus_proceso_actas(7, li_periodo,li_anio, gtr_sce)

	//Si las actas ya se transfirieron de SQL a SYBASE las consultas serán en EN BD CS, de lo contrario seran en BD WEB
	if li_proceso_transferidas = 1 then
		dw_estadisticas.SetTransObject(gtr_sce)
	else
		dw_estadisticas.SetTransObject(itr_web)
	end if	
	
	MessageBox("Generando Reporte", "Por Acta y Nivel",Information!)
	if rb_extrao.checked = true or rb_a_titulo.checked  then 
		ll_rows = dw_estadisticas.Retrieve(ll_no_acta, ls_nivel, li_periodo, li_anio, li_cve_tipo_examen, li_cve_estatus_confirmada)	
	else
		ll_rows = dw_estadisticas.Retrieve(ll_no_acta, ls_nivel, li_periodo, li_anio, li_cve_estatus_confirmada)	
	end if
end if

dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")

end event

event constructor;TabOrder = 4
end event

type em_anio from editmask within w_acta_oficial_reimpresion
event constructor pbm_constructor
event modified pbm_enmodified
integer x = 2990
integer y = 84
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
int li_evento_bajas = 11

f_obten_periodo(periodo,anio,li_evento_bajas)

// 0 = Primavera
// 1 = Verano
// 2 = Otoño
/*
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
*/

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

type dw_1x from datawindow within w_acta_oficial_reimpresion
boolean visible = false
integer x = 3767
integer y = 624
integer width = 1038
integer height = 564
integer taborder = 70
string dataobject = "dw_repo_mad_18_gx"
boolean livescroll = true
end type

type gb_8 from groupbox within w_acta_oficial_reimpresion
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

type gb_11 from groupbox within w_acta_oficial_reimpresion
integer x = 2971
integer y = 28
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

type gb_20 from groupbox within w_acta_oficial_reimpresion
integer x = 2885
integer y = 200
integer width = 1888
integer height = 284
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

type gb_1 from groupbox within w_acta_oficial_reimpresion
integer x = 946
integer y = 612
integer width = 585
integer height = 380
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

type gb_tipo_examen from groupbox within w_acta_oficial_reimpresion
integer x = 1591
integer y = 664
integer width = 1143
integer height = 328
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo de Examen"
end type

type uo_periodos from uo_periodo_variable_tipos within w_acta_oficial_reimpresion
event destroy ( )
integer x = 2889
integer y = 260
integer width = 1870
integer height = 212
integer taborder = 90
boolean bringtotop = true
end type

on uo_periodos.destroy
call uo_periodo_variable_tipos::destroy
end on
