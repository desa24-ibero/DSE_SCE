$PBExportHeader$w_acta_oficial_impresion_masiva.srw
forward
global type w_acta_oficial_impresion_masiva from window
end type
type uo_periodo from uo_periodo_variable within w_acta_oficial_impresion_masiva
end type
type uo_nivel from uo_nivel_2013 within w_acta_oficial_impresion_masiva
end type
type gb_coordinacion from groupbox within w_acta_oficial_impresion_masiva
end type
type gb_tipo_examen from groupbox within w_acta_oficial_impresion_masiva
end type
type rb_ordinario from radiobutton within w_acta_oficial_impresion_masiva
end type
type rb_extrao_tit from radiobutton within w_acta_oficial_impresion_masiva
end type
type st_1 from statictext within w_acta_oficial_impresion_masiva
end type
type em_num_actas from editmask within w_acta_oficial_impresion_masiva
end type
type st_servidor from statictext within w_acta_oficial_impresion_masiva
end type
type cb_imprimir from commandbutton within w_acta_oficial_impresion_masiva
end type
type st_4 from statictext within w_acta_oficial_impresion_masiva
end type
type uoi_coordinaciones from uo_coordinaciones within w_acta_oficial_impresion_masiva
end type
type rb_posgrado from radiobutton within w_acta_oficial_impresion_masiva
end type
type rb_licenciatura from radiobutton within w_acta_oficial_impresion_masiva
end type
type em_no_acta from editmask within w_acta_oficial_impresion_masiva
end type
type st_2 from statictext within w_acta_oficial_impresion_masiva
end type
type uo_profesor from uo_nombre_profesor within w_acta_oficial_impresion_masiva
end type
type uo_grupo from uo_grupos_filtro within w_acta_oficial_impresion_masiva
end type
type rb_5 from radiobutton within w_acta_oficial_impresion_masiva
end type
type rb_4 from radiobutton within w_acta_oficial_impresion_masiva
end type
type rb_3 from radiobutton within w_acta_oficial_impresion_masiva
end type
type st_3 from statictext within w_acta_oficial_impresion_masiva
end type
type dw_estadisticas from datawindow within w_acta_oficial_impresion_masiva
end type
type cb_cargar from commandbutton within w_acta_oficial_impresion_masiva
end type
type em_anio from editmask within w_acta_oficial_impresion_masiva
end type
type dw_1x from datawindow within w_acta_oficial_impresion_masiva
end type
type gb_8 from groupbox within w_acta_oficial_impresion_masiva
end type
type gb_11 from groupbox within w_acta_oficial_impresion_masiva
end type
type gb_20 from groupbox within w_acta_oficial_impresion_masiva
end type
type gb_1 from groupbox within w_acta_oficial_impresion_masiva
end type
type gb_2 from groupbox within w_acta_oficial_impresion_masiva
end type
type rb_todas_nivel from radiobutton within w_acta_oficial_impresion_masiva
end type
end forward

global type w_acta_oficial_impresion_masiva from window
integer width = 6894
integer height = 3504
boolean titlebar = true
string title = "Impresión de Actas Masiva"
string menuname = "m_acta_oficial_impresion_masiva"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
uo_periodo uo_periodo
uo_nivel uo_nivel
gb_coordinacion gb_coordinacion
gb_tipo_examen gb_tipo_examen
rb_ordinario rb_ordinario
rb_extrao_tit rb_extrao_tit
st_1 st_1
em_num_actas em_num_actas
st_servidor st_servidor
cb_imprimir cb_imprimir
st_4 st_4
uoi_coordinaciones uoi_coordinaciones
rb_posgrado rb_posgrado
rb_licenciatura rb_licenciatura
em_no_acta em_no_acta
st_2 st_2
uo_profesor uo_profesor
uo_grupo uo_grupo
rb_5 rb_5
rb_4 rb_4
rb_3 rb_3
st_3 st_3
dw_estadisticas dw_estadisticas
cb_cargar cb_cargar
em_anio em_anio
dw_1x dw_1x
gb_8 gb_8
gb_11 gb_11
gb_20 gb_20
gb_1 gb_1
gb_2 gb_2
rb_todas_nivel rb_todas_nivel
end type
global w_acta_oficial_impresion_masiva w_acta_oficial_impresion_masiva

type variables
int periodo_x

integer ii_periodo, ii_anio
end variables

on w_acta_oficial_impresion_masiva.create
if this.MenuName = "m_acta_oficial_impresion_masiva" then this.MenuID = create m_acta_oficial_impresion_masiva
this.uo_periodo=create uo_periodo
this.uo_nivel=create uo_nivel
this.gb_coordinacion=create gb_coordinacion
this.gb_tipo_examen=create gb_tipo_examen
this.rb_ordinario=create rb_ordinario
this.rb_extrao_tit=create rb_extrao_tit
this.st_1=create st_1
this.em_num_actas=create em_num_actas
this.st_servidor=create st_servidor
this.cb_imprimir=create cb_imprimir
this.st_4=create st_4
this.uoi_coordinaciones=create uoi_coordinaciones
this.rb_posgrado=create rb_posgrado
this.rb_licenciatura=create rb_licenciatura
this.em_no_acta=create em_no_acta
this.st_2=create st_2
this.uo_profesor=create uo_profesor
this.uo_grupo=create uo_grupo
this.rb_5=create rb_5
this.rb_4=create rb_4
this.rb_3=create rb_3
this.st_3=create st_3
this.dw_estadisticas=create dw_estadisticas
this.cb_cargar=create cb_cargar
this.em_anio=create em_anio
this.dw_1x=create dw_1x
this.gb_8=create gb_8
this.gb_11=create gb_11
this.gb_20=create gb_20
this.gb_1=create gb_1
this.gb_2=create gb_2
this.rb_todas_nivel=create rb_todas_nivel
this.Control[]={this.uo_periodo,&
this.uo_nivel,&
this.gb_coordinacion,&
this.gb_tipo_examen,&
this.rb_ordinario,&
this.rb_extrao_tit,&
this.st_1,&
this.em_num_actas,&
this.st_servidor,&
this.cb_imprimir,&
this.st_4,&
this.uoi_coordinaciones,&
this.rb_posgrado,&
this.rb_licenciatura,&
this.em_no_acta,&
this.st_2,&
this.uo_profesor,&
this.uo_grupo,&
this.rb_5,&
this.rb_4,&
this.rb_3,&
this.st_3,&
this.dw_estadisticas,&
this.cb_cargar,&
this.em_anio,&
this.dw_1x,&
this.gb_8,&
this.gb_11,&
this.gb_20,&
this.gb_1,&
this.gb_2,&
this.rb_todas_nivel}
end on

on w_acta_oficial_impresion_masiva.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_periodo)
destroy(this.uo_nivel)
destroy(this.gb_coordinacion)
destroy(this.gb_tipo_examen)
destroy(this.rb_ordinario)
destroy(this.rb_extrao_tit)
destroy(this.st_1)
destroy(this.em_num_actas)
destroy(this.st_servidor)
destroy(this.cb_imprimir)
destroy(this.st_4)
destroy(this.uoi_coordinaciones)
destroy(this.rb_posgrado)
destroy(this.rb_licenciatura)
destroy(this.em_no_acta)
destroy(this.st_2)
destroy(this.uo_profesor)
destroy(this.uo_grupo)
destroy(this.rb_5)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.st_3)
destroy(this.dw_estadisticas)
destroy(this.cb_cargar)
destroy(this.em_anio)
destroy(this.dw_1x)
destroy(this.gb_8)
destroy(this.gb_11)
destroy(this.gb_20)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.rb_todas_nivel)
end on

event open;this.x=1
this.y=1
uoi_coordinaciones.backcolor = this.backcolor
uoi_coordinaciones.enabled = true

uo_grupo.rb_editar.visible = false
uo_grupo.rb_insertar.visible = false

dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")

st_servidor.text = gtr_sce.servername

uo_nivel.of_carga_control(gtr_sce)

// Se inicializa objeto de servicios de selección de Periodo.
THIS.uo_periodo.f_genera_periodo(gs_tipo_periodo, 'V', 'L', 'L', 'N', gtr_sce) 

THIS.uo_periodo.f_selecciona_periodo( periodo_x, 'L')



end event

type uo_periodo from uo_periodo_variable within w_acta_oficial_impresion_masiva
integer x = 3589
integer y = 76
integer width = 489
integer height = 316
integer taborder = 30
end type

on uo_periodo.destroy
call uo_periodo_variable::destroy
end on

type uo_nivel from uo_nivel_2013 within w_acta_oficial_impresion_masiva
integer x = 78
integer y = 56
integer taborder = 20
end type

on uo_nivel.destroy
call uo_nivel_2013::destroy
end on

type gb_coordinacion from groupbox within w_acta_oficial_impresion_masiva
integer x = 2139
integer y = 100
integer width = 631
integer height = 212
integer taborder = 50
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Actas a Generar"
borderstyle borderstyle = styleraised!
end type

type gb_tipo_examen from groupbox within w_acta_oficial_impresion_masiva
integer x = 686
integer y = 56
integer width = 1006
integer height = 272
integer taborder = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Tipo de Examen"
end type

type rb_ordinario from radiobutton within w_acta_oficial_impresion_masiva
integer x = 750
integer y = 132
integer width = 407
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Ordinario"
boolean checked = true
end type

event clicked;
dw_estadisticas.dataobject = 'd_acta_oficial_masiva_nivel'
dw_estadisticas.settransobject(gtr_sce)
m_acta_oficial_impresion_masiva.dw= dw_estadisticas
end event

type rb_extrao_tit from radiobutton within w_acta_oficial_impresion_masiva
integer x = 745
integer y = 220
integer width = 919
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Extraordinario y a Título de Suf."
end type

event clicked;
dw_estadisticas.dataobject = 'd_acta_oficial_masiva_nivel_ets'
dw_estadisticas.settransobject(gtr_sce)
m_acta_oficial_impresion_masiva.dw= dw_estadisticas
end event

type st_1 from statictext within w_acta_oficial_impresion_masiva
integer x = 1888
integer y = 340
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Num. Actas:"
boolean focusrectangle = false
end type

type em_num_actas from editmask within w_acta_oficial_impresion_masiva
integer x = 2354
integer y = 320
integer width = 402
integer height = 112
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
string mask = "##,###"
end type

type st_servidor from statictext within w_acta_oficial_impresion_masiva
integer x = 1879
integer y = 16
integer width = 1152
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

type cb_imprimir from commandbutton within w_acta_oficial_impresion_masiva
integer x = 3177
integer y = 152
integer width = 265
integer height = 108
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprimir"
end type

event clicked;integer li_confirmacion, li_print
string ls_mensaje_confirmacion, ls_nivel, ls_desc_nivel
long ll_rows
integer li_actualiza_estatus_acta_mas, li_anio, li_periodo
string ls_anio, ls_periodo
integer li_estatus_confirmada, li_estatus_impresa, li_proceso_impresas, li_set_estatus_proceso_actas
integer li_result
string ls_array_nivel[]


ls_anio = em_anio.text

if not isnumber(ls_anio) then
	MessageBox("Error", "Es necesario escribir un Año", StopSign!)
	return
end if

li_anio= integer(ls_anio)


// Se recupera el periodo seleccionado.
li_periodo = PARENT.uo_periodo.id_periodo
ls_periodo = PARENT.uo_periodo.descripcion
IF li_periodo < 0 OR TRIM(ls_periodo) = "" THEN
	MessageBox("Error", "Es necesario seleccionar un Periodo", StopSign!)
	return	
END IF 

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

li_result = uo_nivel.of_carga_arreglo_nivel( )
uo_nivel.of_obtiene_array( ls_array_nivel[] )

If li_result = - 1 Then
	MessageBox("Mensaje del Sistema", "Error al ejecutar uo_nivel.of_carga_arreglo_nivel", StopSign!)
	return
End If

If UpperBound(ls_array_nivel[]) <= 0 Then
	MessageBox("Mensaje del Sistema", "Debe seleccionar un nivel", StopSign!)
	return
End If

If UpperBound(ls_array_nivel[]) > 1 Then
	MessageBox("Mensaje del Sistema", "Solo puede seleccionar un nivel", StopSign!)
	return
End If

ls_nivel = ls_array_nivel[1]
ls_desc_nivel = f_decodifica_nivel(ls_nivel) 
//choose case ls_nivel
//	case "L"
//		ls_desc_nivel = "Licenciatura"
//	case "P"
//		ls_desc_nivel =	 "Posgrado"
//	case "T"
//		ls_desc_nivel =	 "TSU"
//end choose

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

ll_rows = dw_estadisticas.RowCount()

if ll_rows= 0 then
	MessageBox("Impresión Cancelada", "No existen actas a imprimir", Information!	)
	return	
end if

ls_mensaje_confirmacion = "¿Desea Imprimir las actas aún No Impresas de ["+ls_desc_nivel+"]?~n Al concluir la impresión se actualizará el estatus de las actas a IMPRESA"
li_confirmacion = MessageBox("Confirmación", ls_mensaje_confirmacion, Question!, YesNo!)

if li_confirmacion<>1 then
	MessageBox("Impresión Cancelada", "No se imprimieron las actas", Information!	)
	return	
end if

li_print = dw_estadisticas.Print(true, true)

if li_print = 1 then	
	li_estatus_confirmada = 3 
	li_estatus_impresa = 4
	li_actualiza_estatus_acta_mas = f_actualiza_estatus_acta_mas(ls_nivel, li_periodo, li_anio,&
                                   li_estatus_confirmada, li_estatus_impresa, gtr_sce)
	MessageBox("Impresión Exitosa", "Se imprimieron las actas exitosamente", Information!	)
	if li_actualiza_estatus_acta_mas = -1 then	
		MessageBox("Error de Actualización ", "NO se actualizó el estatus de las actas", Information!	)		
		return
	else
		MessageBox("Actualización Exitosa", "Se actualizó el estatus de las actas exitosamente", Information!	)				
	end if	
else
	MessageBox("Error de Impresión ", "NO se imprimieron las actas", Information!	)		
	return	
end if


//Actualiza el esatus general del proceso de actas para el periodo vigente
li_proceso_impresas=8
li_set_estatus_proceso_actas =f_set_estatus_proceso_actas(li_proceso_impresas,li_periodo, li_anio,1,gtr_sce)
if li_set_estatus_proceso_actas = -1 then
	MessageBox("Error en la actualizacion del proceso de actas ["+string(li_proceso_impresas)+"]",&
					"Si la impresión fue exitosa actualice el registro ["+string(li_proceso_impresas)+"] de la tabla proceso_actas",StopSign!)
end if



end event

type st_4 from statictext within w_acta_oficial_impresion_masiva
boolean visible = false
integer x = 101
integer y = 488
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

type uoi_coordinaciones from uo_coordinaciones within w_acta_oficial_impresion_masiva
boolean visible = false
integer x = 594
integer y = 464
integer taborder = 90
boolean border = false
end type

on uoi_coordinaciones.destroy
call uo_coordinaciones::destroy
end on

type rb_posgrado from radiobutton within w_acta_oficial_impresion_masiva
integer x = 165
integer y = 196
integer width = 421
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Posgrado"
end type

type rb_licenciatura from radiobutton within w_acta_oficial_impresion_masiva
integer x = 165
integer y = 104
integer width = 421
integer height = 112
integer textsize = -8
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

type em_no_acta from editmask within w_acta_oficial_impresion_masiva
boolean visible = false
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

type st_2 from statictext within w_acta_oficial_impresion_masiva
boolean visible = false
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

type uo_profesor from uo_nombre_profesor within w_acta_oficial_impresion_masiva
boolean visible = false
integer x = 27
integer y = 32
integer taborder = 30
boolean enabled = true
end type

on uo_profesor.destroy
call uo_nombre_profesor::destroy
end on

type uo_grupo from uo_grupos_filtro within w_acta_oficial_impresion_masiva
boolean visible = false
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

type rb_5 from radiobutton within w_acta_oficial_impresion_masiva
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

type rb_4 from radiobutton within w_acta_oficial_impresion_masiva
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

type rb_3 from radiobutton within w_acta_oficial_impresion_masiva
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

type st_3 from statictext within w_acta_oficial_impresion_masiva
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

type dw_estadisticas from datawindow within w_acta_oficial_impresion_masiva
integer x = 151
integer y = 440
integer width = 4466
integer height = 2776
integer taborder = 80
string dataobject = "d_acta_oficial_masiva_nivel"
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
m_acta_oficial_impresion_masiva.dw= this
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

type cb_cargar from commandbutton within w_acta_oficial_impresion_masiva
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 1760
integer y = 152
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
integer li_cve_forma_ingreso, li_anio, li_periodo, li_indice_nivel, li_result
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
string ls_array_nivel[]
integer li_cve_estatus_acta_confirmada = 3
long ll_obten_num_actas_estatus

ll_cve_mat = uo_grupo.il_cve_mat
ls_gpo = uo_grupo.is_gpo


ll_cve_profesor = uo_profesor.of_obten_cve_profesor()
ll_cve_coordinacion = uoi_coordinaciones.of_obten_cve_coordinacion()

// Se recupera el periodo seleccionado.
li_periodo = PARENT.uo_periodo.id_periodo
ls_periodo = PARENT.uo_periodo.descripcion
IF li_periodo < 0 OR TRIM(ls_periodo) = "" THEN
	MessageBox("Error", "Es necesario seleccionar un Periodo", StopSign!)
	return	
END IF 

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

li_result = uo_nivel.of_carga_arreglo_nivel( )
uo_nivel.of_obtiene_array( ls_array_nivel[])

If li_result = - 1 Then
	MessageBox("Mensaje del Sistema", "Error al ejecutar uo_nivel.of_carga_arreglo_nivel", StopSign!)
	return
End If

If UpperBound(ls_array_nivel[]) <= 0 Then
	MessageBox("Mensaje del Sistema", "Debe seleccionar un nivel", StopSign!)
	return
End If

If UpperBound(ls_array_nivel[]) > 1 Then
	MessageBox("Mensaje del Sistema", "Solo puede seleccionar un nivel", StopSign!)
	return
End If

ls_nivel = ls_array_nivel[1]
ls_desc_nivel = f_decodifica_nivel(ls_nivel) 

//choose case ls_nivel
//	case "L"
//		ls_desc_nivel = "Licenciatura"
//	case "P"
//		ls_desc_nivel =	 "Posgrado"
//	case "T"
//		ls_desc_nivel =	 "TSU"
//end choose
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

//Actas por Todas las Coordinaciones
if rb_todas_nivel.checked then
	ll_cve_coordinacion = 9999
	MessageBox("Generando Reporte", "Todas Por Nivel ["+ls_desc_nivel+"]",Information!)
	ll_rows = dw_estadisticas.Retrieve(ll_cve_coordinacion, ls_nivel, li_periodo, li_anio,li_cve_estatus_acta_confirmada)	
	//Cuenta el número de actas por estatus	
	ll_obten_num_actas_estatus =f_obten_num_actas_estatus(ls_nivel,li_periodo, li_anio,li_cve_estatus_acta_confirmada, gtr_sce)
	em_num_actas.text = string(ll_obten_num_actas_estatus)
end if

dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")



	







end event

event constructor;TabOrder = 4
end event

type em_anio from editmask within w_acta_oficial_impresion_masiva
event constructor pbm_constructor
event modified pbm_enmodified
integer x = 4183
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
int li_evento_bajas = 11

f_obten_periodo(periodo,anio,li_evento_bajas)

// 0 = Primavera
// 1 = Verano
// 2 = Otoño

// Se pasa el periodo recuperado a la variable de instancia.
periodo_x = periodo

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

type dw_1x from datawindow within w_acta_oficial_impresion_masiva
boolean visible = false
integer x = 3767
integer y = 624
integer width = 1038
integer height = 564
integer taborder = 70
string dataobject = "dw_repo_mad_18_gx"
boolean livescroll = true
end type

type gb_8 from groupbox within w_acta_oficial_impresion_masiva
integer x = 1728
integer y = 104
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

type gb_11 from groupbox within w_acta_oficial_impresion_masiva
integer x = 4137
integer y = 36
integer width = 315
integer height = 160
integer taborder = 40
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Año"
borderstyle borderstyle = styleraised!
end type

type gb_20 from groupbox within w_acta_oficial_impresion_masiva
integer x = 3557
integer y = 20
integer width = 549
integer height = 400
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Periodo"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_acta_oficial_impresion_masiva
integer x = 110
integer y = 56
integer width = 553
integer height = 228
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nivel"
end type

type gb_2 from groupbox within w_acta_oficial_impresion_masiva
integer x = 3145
integer y = 104
integer width = 329
integer height = 176
integer taborder = 110
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
borderstyle borderstyle = styleraised!
end type

type rb_todas_nivel from radiobutton within w_acta_oficial_impresion_masiva
integer x = 2181
integer y = 176
integer width = 530
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Todas por Nivel"
boolean checked = true
end type

event clicked;dw_estadisticas.dataobject = "d_acta_oficial_masiva_nivel"
dw_estadisticas.SetTransObject(gtr_sce)

dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")
end event

