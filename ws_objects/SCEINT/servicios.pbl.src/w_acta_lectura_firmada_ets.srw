$PBExportHeader$w_acta_lectura_firmada_ets.srw
forward
global type w_acta_lectura_firmada_ets from window
end type
type uo_nivel from uo_nivel_rbutton within w_acta_lectura_firmada_ets
end type
type rb_a_titulo from radiobutton within w_acta_lectura_firmada_ets
end type
type rb_extraordinario from radiobutton within w_acta_lectura_firmada_ets
end type
type gb_5 from groupbox within w_acta_lectura_firmada_ets
end type
type st_servername from statictext within w_acta_lectura_firmada_ets
end type
type cb_prepara_lector from commandbutton within w_acta_lectura_firmada_ets
end type
type st_periodo_actas from statictext within w_acta_lectura_firmada_ets
end type
type dw_acta_listado_profesor from datawindow within w_acta_lectura_firmada_ets
end type
type cb_consulta_actas_profesor from commandbutton within w_acta_lectura_firmada_ets
end type
type cb_impresion from commandbutton within w_acta_lectura_firmada_ets
end type
type rb_sin_firma from radiobutton within w_acta_lectura_firmada_ets
end type
type rb_con_firma from radiobutton within w_acta_lectura_firmada_ets
end type
type cb_valida_codigo from commandbutton within w_acta_lectura_firmada_ets
end type
type em_codigo_barras from editmask within w_acta_lectura_firmada_ets
end type
type st_1 from statictext within w_acta_lectura_firmada_ets
end type
type rb_todas_nivel from radiobutton within w_acta_lectura_firmada_ets
end type
type rb_acta_nivel from radiobutton within w_acta_lectura_firmada_ets
end type
type st_4 from statictext within w_acta_lectura_firmada_ets
end type
type uoi_coordinaciones from uo_coordinaciones within w_acta_lectura_firmada_ets
end type
type em_no_acta from editmask within w_acta_lectura_firmada_ets
end type
type st_2 from statictext within w_acta_lectura_firmada_ets
end type
type uo_profesor from uo_nombre_profesor within w_acta_lectura_firmada_ets
end type
type uo_grupo from uo_grupos_filtro within w_acta_lectura_firmada_ets
end type
type rb_departamento from radiobutton within w_acta_lectura_firmada_ets
end type
type rb_5 from radiobutton within w_acta_lectura_firmada_ets
end type
type rb_4 from radiobutton within w_acta_lectura_firmada_ets
end type
type rb_3 from radiobutton within w_acta_lectura_firmada_ets
end type
type rb_grupo from radiobutton within w_acta_lectura_firmada_ets
end type
type rb_profesor from radiobutton within w_acta_lectura_firmada_ets
end type
type gb_coordinacion from groupbox within w_acta_lectura_firmada_ets
end type
type st_3 from statictext within w_acta_lectura_firmada_ets
end type
type dw_estadisticas from datawindow within w_acta_lectura_firmada_ets
end type
type cb_lectura from commandbutton within w_acta_lectura_firmada_ets
end type
type dw_1x from datawindow within w_acta_lectura_firmada_ets
end type
type gb_8 from groupbox within w_acta_lectura_firmada_ets
end type
type gb_1 from groupbox within w_acta_lectura_firmada_ets
end type
type gb_2 from groupbox within w_acta_lectura_firmada_ets
end type
type gb_3 from groupbox within w_acta_lectura_firmada_ets
end type
type gb_4 from groupbox within w_acta_lectura_firmada_ets
end type
end forward

global type w_acta_lectura_firmada_ets from window
integer width = 5989
integer height = 3528
boolean titlebar = true
string title = "Recepción de Actas a Extraordinario y a Título de Suficiencia (Impresión)"
string menuname = "m_estad_alum_mat"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
uo_nivel uo_nivel
rb_a_titulo rb_a_titulo
rb_extraordinario rb_extraordinario
gb_5 gb_5
st_servername st_servername
cb_prepara_lector cb_prepara_lector
st_periodo_actas st_periodo_actas
dw_acta_listado_profesor dw_acta_listado_profesor
cb_consulta_actas_profesor cb_consulta_actas_profesor
cb_impresion cb_impresion
rb_sin_firma rb_sin_firma
rb_con_firma rb_con_firma
cb_valida_codigo cb_valida_codigo
em_codigo_barras em_codigo_barras
st_1 st_1
rb_todas_nivel rb_todas_nivel
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
cb_lectura cb_lectura
dw_1x dw_1x
gb_8 gb_8
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
end type
global w_acta_lectura_firmada_ets w_acta_lectura_firmada_ets

type variables
int periodo_x

integer ii_periodo, ii_anio

uo_periodo_servicios iuo_periodo_servicios
transaction itr_web


STRING is_tipo_periodo, is_descripcion_tipo
end variables

forward prototypes
public subroutine wf_selecciona_acta (integer row)
end prototypes

public subroutine wf_selecciona_acta (integer row);
long ll_row, ll_no_acta
string ls_nivel
integer li_cve_tipo_examen


ll_row = row
if ll_row > 0 then
	ll_no_acta = dw_acta_listado_profesor.GetItemNumber(ll_row, "acta_evaluacion_preeliminar_no_acta")
	ls_nivel   = dw_acta_listado_profesor.GetItemString(ll_row, "acta_evaluacion_preeliminar_nivel")
	li_cve_tipo_examen = dw_acta_listado_profesor.GetItemNumber(ll_row, "tipo_examen_cve_tipo_examen")
	is_tipo_periodo = dw_acta_listado_profesor.GetItemString(ll_row, "periodo_tipo") 
	//ASIGNA EL NUMERO DE ACTA
	em_no_acta.text = string(ll_no_acta)
	//ASIGNA EL NIVEL DEL ACTA
	
//	if ls_nivel = 'L' then
//		rb_licenciatura.checked = true
//	elseif ls_nivel = 'P' then
//		rb_posgrado.checked = true		
//	end if

	uo_nivel.f_selecciona_nivel( ls_nivel, "L") 


	//ASIGNA EL TIPO DE EXAMEN
	if li_cve_tipo_examen= 2 then
		rb_extraordinario.checked = true
	elseif li_cve_tipo_examen= 6 then
		rb_a_titulo.checked = true		
	end if
	
	SELECT descripcion
	INTO :is_descripcion_tipo
	FROM periodo_tipo 
	WHERE id_tipo = :is_tipo_periodo
	USING gtr_sce;	
	
	
end if 


IF ll_row > 0 THEN 
	dw_acta_listado_profesor.SELECTROW(0, FALSE)
	dw_acta_listado_profesor.SELECTROW(ll_row, TRUE)
END IF






end subroutine

on w_acta_lectura_firmada_ets.create
if this.MenuName = "m_estad_alum_mat" then this.MenuID = create m_estad_alum_mat
this.uo_nivel=create uo_nivel
this.rb_a_titulo=create rb_a_titulo
this.rb_extraordinario=create rb_extraordinario
this.gb_5=create gb_5
this.st_servername=create st_servername
this.cb_prepara_lector=create cb_prepara_lector
this.st_periodo_actas=create st_periodo_actas
this.dw_acta_listado_profesor=create dw_acta_listado_profesor
this.cb_consulta_actas_profesor=create cb_consulta_actas_profesor
this.cb_impresion=create cb_impresion
this.rb_sin_firma=create rb_sin_firma
this.rb_con_firma=create rb_con_firma
this.cb_valida_codigo=create cb_valida_codigo
this.em_codigo_barras=create em_codigo_barras
this.st_1=create st_1
this.rb_todas_nivel=create rb_todas_nivel
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
this.cb_lectura=create cb_lectura
this.dw_1x=create dw_1x
this.gb_8=create gb_8
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.Control[]={this.uo_nivel,&
this.rb_a_titulo,&
this.rb_extraordinario,&
this.gb_5,&
this.st_servername,&
this.cb_prepara_lector,&
this.st_periodo_actas,&
this.dw_acta_listado_profesor,&
this.cb_consulta_actas_profesor,&
this.cb_impresion,&
this.rb_sin_firma,&
this.rb_con_firma,&
this.cb_valida_codigo,&
this.em_codigo_barras,&
this.st_1,&
this.rb_todas_nivel,&
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
this.cb_lectura,&
this.dw_1x,&
this.gb_8,&
this.gb_1,&
this.gb_2,&
this.gb_3,&
this.gb_4}
end on

on w_acta_lectura_firmada_ets.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nivel)
destroy(this.rb_a_titulo)
destroy(this.rb_extraordinario)
destroy(this.gb_5)
destroy(this.st_servername)
destroy(this.cb_prepara_lector)
destroy(this.st_periodo_actas)
destroy(this.dw_acta_listado_profesor)
destroy(this.cb_consulta_actas_profesor)
destroy(this.cb_impresion)
destroy(this.rb_sin_firma)
destroy(this.rb_con_firma)
destroy(this.cb_valida_codigo)
destroy(this.em_codigo_barras)
destroy(this.st_1)
destroy(this.rb_todas_nivel)
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
destroy(this.cb_lectura)
destroy(this.dw_1x)
destroy(this.gb_8)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
end on

event open;integer li_evento_extraordinario_titulo = 12, li_proceso_en_captura = 4, li_proceso_transferidas = 7
int li_periodo,li_anio
string ls_periodo, ls_anio

this.x=1
this.y=1

uo_nivel.f_genera_nivel( "V", "C", "L", gtr_sce) 

iuo_periodo_servicios = CREATE uo_periodo_servicios
iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)

f_obten_periodo(li_periodo,li_anio,li_evento_extraordinario_titulo)

li_proceso_en_captura   = f_obten_estatus_proceso_actas(104, li_periodo,li_anio, gtr_sce)
li_proceso_transferidas = f_obten_estatus_proceso_actas(107, li_periodo,li_anio, gtr_sce)

if li_proceso_en_captura = 0 then
	MessageBox("Recepción de Actas No habilitadas", "Por favor solicite a la Jefatura de Control Escolar que habilite la recepción de actas.", StopSign!)
	close(this)	
	return
end if

//uoi_coordinaciones.backcolor = this.backcolor
//uoi_coordinaciones.enabled = true

uo_grupo.rb_editar.visible = false
uo_grupo.rb_insertar.visible = false

if conecta_bd(itr_web,gs_sweb, gs_usuario, gs_password)<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	close(this)
end if

IF IsValid(This) THEN 
	//Si las actas ya se transfirieron de SQL a SYBASE las consultas serán en EN BD CS, de lo contrario seran en BD WEB
	if li_proceso_transferidas = 1 then
		st_servername.text = 'SYBASE'
		dw_estadisticas.SetTransObject(gtr_sce)
		dw_estadisticas.SetTransObject(gtr_sce)
		dw_acta_listado_profesor.SetTransObject(gtr_sce)
	//Como ya se realizó la transferencia se deshabilita la impresión	
		cb_impresion.enabled = false
		rb_con_firma.checked = true
		rb_sin_firma.visible = true
		rb_sin_firma.enabled = true
	else
		st_servername.text = 'SQLSERVER'
		dw_estadisticas.SetTransObject(itr_web)
		dw_estadisticas.SetTransObject(itr_web)
		dw_acta_listado_profesor.SetTransObject(itr_web)
		rb_con_firma.checked = true
		rb_sin_firma.visible = false
		rb_sin_firma.enabled = false
	end if
	
	dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
	dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '75'")
	
	ls_periodo=iuo_periodo_servicios.f_recupera_descripcion( li_periodo, "L")
	
	/*
	// 0 = Primavera
	// 1 = Verano
	// 2 = Otoño
	
	CHOOSE CASE li_periodo
		CASE 0
			ls_periodo = 'PRIMAVERA'
		CASE 1
			ls_periodo = 'VERANO'
		CASE 2
			ls_periodo = 'OTOÑO'
	END CHOOSE
	*/
	
	ii_periodo = li_periodo
	ii_anio = li_anio
	ls_anio = string(li_anio)
	
	st_periodo_actas.TEXT = ls_periodo+" - "+ ls_anio
END IF
end event

type uo_nivel from uo_nivel_rbutton within w_acta_lectura_firmada_ets
integer x = 2971
integer y = 128
integer width = 475
integer taborder = 130
end type

on uo_nivel.destroy
call uo_nivel_rbutton::destroy
end on

type rb_a_titulo from radiobutton within w_acta_lectura_firmada_ets
integer x = 3648
integer y = 260
integer width = 622
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "A Título de Suficiencia"
end type

type rb_extraordinario from radiobutton within w_acta_lectura_firmada_ets
integer x = 3648
integer y = 172
integer width = 407
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Extraordinario"
end type

type gb_5 from groupbox within w_acta_lectura_firmada_ets
integer x = 3611
integer y = 80
integer width = 763
integer height = 296
integer taborder = 140
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo de Examen"
end type

type st_servername from statictext within w_acta_lectura_firmada_ets
integer x = 2025
integer y = 60
integer width = 613
integer height = 84
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "SERVERNAME"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_prepara_lector from commandbutton within w_acta_lectura_firmada_ets
integer x = 2944
integer y = 752
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Prepara"
end type

event clicked;string ls_codigo_barras
ls_codigo_barras = em_codigo_barras.text

em_codigo_barras.SelectText(1,len(ls_codigo_barras))	
em_codigo_barras.SetFocus()	

end event

type st_periodo_actas from statictext within w_acta_lectura_firmada_ets
boolean visible = false
integer x = 965
integer y = 52
integer width = 869
integer height = 100
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "PERIODO - AÑO"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_acta_listado_profesor from datawindow within w_acta_lectura_firmada_ets
integer x = 32
integer y = 624
integer width = 2789
integer height = 1188
integer taborder = 110
string dataobject = "d_acta_listado_profesor_ets"
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;
wf_selecciona_acta(row) 


//long ll_row, ll_no_acta
//string ls_nivel
//integer li_cve_tipo_examen
//
//
//ll_row = row
//if ll_row > 0 then
//	ll_no_acta = this.GetItemNumber(ll_row, "acta_evaluacion_preeliminar_no_acta")
//	ls_nivel   = this.GetItemString(ll_row, "acta_evaluacion_preeliminar_nivel")
//	li_cve_tipo_examen = this.GetItemNumber(ll_row, "tipo_examen_cve_tipo_examen")
//	//ASIGNA EL NUMERO DE ACTA
//	em_no_acta.text = string(ll_no_acta)
//	//ASIGNA EL NIVEL DEL ACTA
//	if ls_nivel = 'L' then
//		rb_licenciatura.checked = true
//	elseif ls_nivel = 'P' then
//		rb_posgrado.checked = true		
//	end if
//
//	//ASIGNA EL TIPO DE EXAMEN
//	if li_cve_tipo_examen= 2 then
//		rb_extraordinario.checked = true
//	elseif li_cve_tipo_examen= 6 then
//		rb_a_titulo.checked = true		
//	end if
//end if
end event

type cb_consulta_actas_profesor from commandbutton within w_acta_lectura_firmada_ets
integer x = 1029
integer y = 472
integer width = 782
integer height = 112
integer taborder = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta Actas de Profesor"
end type

event clicked;long ll_rows_profesor, ll_cve_profesor

ll_cve_profesor = uo_profesor.of_obten_cve_profesor()

//dw_acta_listado_profesor.SetTransObject(gtr_sce)

ll_rows_profesor = dw_acta_listado_profesor.Retrieve(ll_cve_profesor)  //Tipo de Examen 2 y 6   2=Extraordinario y 6=A Título


end event

type cb_impresion from commandbutton within w_acta_lectura_firmada_ets
integer x = 3680
integer y = 488
integer width = 370
integer height = 108
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Impresión"
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
string ls_nivel
integer li_periodo_evento,li_anio_evento,li_evento_extraordinario_titulo, li_codigo_retorno
integer li_periodo_acta,li_anio_acta, li_tipo_recepcion, li_cve_estatus_acta, li_actualiza_estatus_acta
long ll_retrieve_acta
integer li_cve_estatus_acta_original
integer li_proceso_en_captura, li_proceso_transferidas, li_cve_tipo_examen
li_evento_extraordinario_titulo = 12

f_obten_periodo_tipo(li_periodo_evento,li_anio_evento,li_evento_extraordinario_titulo, is_tipo_periodo)


li_proceso_en_captura   = f_obten_estatus_proceso_actas(104, li_periodo_evento,li_anio_evento, gtr_sce)
li_proceso_transferidas = f_obten_estatus_proceso_actas(107, li_periodo_evento,li_anio_evento, gtr_sce)


if li_proceso_en_captura = 0 then
	MessageBox("Recepción de Actas No habilitadas", "Por favor solicite a la Jefatura de Control Escolar que habilite la recepción de actas.", StopSign!)
	return
end if

if li_proceso_transferidas = 1 then
	MessageBox("Actas ya transferidas", "Una vez transferidas las actas no se permite la impresión.", StopSign!)
	return
end if


//LEE EL VALOR DEL ACTA ESCRITA
ls_no_acta = em_no_acta.text

if not isnumber(ls_no_acta) then
	MessageBox("Error", "Es necesario escribir un acta válida", StopSign!)
	return
end if

ll_no_acta = integer(ls_no_acta)

//LEE EL NIVEL DEL ACTA

//if rb_licenciatura.checked then
//	ls_nivel = "L"
//elseif rb_posgrado.checked then
//	ls_nivel = "P"
//else
//	MessageBox("Error", "Es necesario seleccionar un Nivel", StopSign!)
//	return
//end if

ls_nivel = uo_nivel.cve_nivel 

//LEE EL TIPO DE EXAMEN DEL ACTA

if rb_extraordinario.checked then
	li_cve_tipo_examen = 2
elseif rb_a_titulo.checked then
	li_cve_tipo_examen = 6
else
	MessageBox("Error", "Es necesario seleccionar un Tipo de Examen", StopSign!)
	return
end if


setpointer(Hourglass!)

li_periodo = li_periodo_evento
li_anio = li_anio_evento

if rb_con_firma.checked then
//CON FIRMA
	li_tipo_recepcion = 1
elseif rb_sin_firma.checked then
//SIN FIRMA
	li_tipo_recepcion = 0
else
	MessageBox("Error","Favor de elegir un tipo de recepción válido",StopSign!)
	return
end if

SetNull(li_tipo_recepcion)

//Se asigna el estatus de IMPRESA
li_cve_estatus_acta = 4
						
MESSAGEBOX("Aviso", "Se imprimirá un Acta de un periodo " + is_descripcion_tipo) 
						
if li_codigo_retorno=-1 then
	MessageBox("Error","Codigo de barras erróneo",StopSign!)
	return
else
//Si ya se tranfirieron Apuntar a SYBASE
	if li_proceso_transferidas = 1 then
		dw_estadisticas.SetTransObject(gtr_sce )
	else
	//Apuntar a SQL SERVER
		dw_estadisticas.SetTransObject(itr_web )
	end if

	ll_retrieve_acta =dw_estadisticas.Retrieve(ll_no_acta,ls_nivel,li_periodo, li_anio, li_cve_tipo_examen)
	if ll_retrieve_acta>0 then
		li_cve_estatus_acta_original = dw_estadisticas.GetItemNumber(1,"v_captura_actas_cve_estatus_acta")
		if li_cve_estatus_acta_original<>3 then
			MessageBox("Error","El Acta no se encuentra en estatus 3-CONFIRMADA.~n"+&
							"Por lo tanto no puede Imprimirse.",StopSign!)
			return		
		end if
	else
			MessageBox("Error","No se encuentra el acta ["+string(ll_no_acta)+"-"+ls_nivel+"] o es de Intercambio."+&
							"Por lo tanto no puede Imprimirse.",StopSign!)		
			return
	end if
	//Como solo se puede imprimir antes de la transferencia se hace explicita la transacción al WEB
	if li_proceso_transferidas = 1 then
		li_actualiza_estatus_acta =	f_actualiza_estatus_acta_ets(ll_no_acta,ls_nivel,li_periodo, li_anio, li_cve_estatus_acta,li_tipo_recepcion,li_cve_tipo_examen, gtr_sce )
	else	
		li_actualiza_estatus_acta =	f_actualiza_estatus_acta_ets(ll_no_acta,ls_nivel,li_periodo, li_anio, li_cve_estatus_acta,li_tipo_recepcion, li_cve_tipo_examen, itr_web )
	end if
	if li_actualiza_estatus_acta <> -1 then
		dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
		dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '75'")
//		ll_retrieve_acta =dw_estadisticas.Retrieve(ll_no_acta,ls_nivel,li_periodo, li_anio)
		if ll_retrieve_acta >=1 then
			MessageBox("Prepare la Impresora","Favor de poner papel membretado en la impresora.",Information!)
			dw_estadisticas.Print(true,true)
		else
			MessageBox("Error de Impresión","No es posible imprimir el acta.~n"+&
						"El Acta no se encuentra CONFIRMADA o no existe.",StopSign!)
			return
		end if
	end if
	em_codigo_barras.SelectText(1,len(em_codigo_barras.text))	
	em_codigo_barras.SetFocus()	
	return	
end if








end event

type rb_sin_firma from radiobutton within w_acta_lectura_firmada_ets
integer x = 4805
integer y = 336
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Sin Firma"
end type

event clicked;MessageBox("Cambio de estatus de recepción", "SIN FIRMA",Information!)
end event

type rb_con_firma from radiobutton within w_acta_lectura_firmada_ets
integer x = 4805
integer y = 232
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Con Firma"
boolean checked = true
end type

event clicked;MessageBox("Cambio de estatus de recepción", "CON FIRMA",Information!)
end event

type cb_valida_codigo from commandbutton within w_acta_lectura_firmada_ets
integer x = 4686
integer y = 756
integer width = 421
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Valida Código"
end type

event clicked;string ls_codigo_barras
long		   ll_cve_mat	
string		ls_gpo		
integer		li_periodo	
integer		li_anio		
integer		li_no_acta		
string		ls_nivel		
string ls_cve_mat, ls_periodo, ls_anio, ls_no_acta, ls_asterisco_inicial, ls_asterisco_final
integer li_codigo_retorno
integer li_tipo_recepcion, li_actualiza_estatus_acta, li_cve_estatus_acta
integer li_cve_estatus_acta_original, li_cve_tipo_examen
long ll_retrieve_acta
ls_codigo_barras = em_codigo_barras.text

integer li_periodo_evento,li_anio_evento,li_evento_extraordinario_titulo
integer li_proceso_en_captura, li_proceso_transferidas

li_evento_extraordinario_titulo = 12

f_obten_periodo_tipo(li_periodo_evento,li_anio_evento,li_evento_extraordinario_titulo)


li_proceso_en_captura   = f_obten_estatus_proceso_actas(104, li_periodo_evento,li_anio_evento, gtr_sce)
li_proceso_transferidas = f_obten_estatus_proceso_actas(107, li_periodo_evento,li_anio_evento, gtr_sce)


if li_proceso_en_captura = 0 then
	MessageBox("Recepción de Actas No habilitadas", "Por favor solicite a la Jefatura de Control Escolar que habilite la recepción de actas.", StopSign!)
	return
end if

li_codigo_retorno = f_lee_codigo_acta_ets(ls_codigo_barras,&
						li_periodo,&		
						li_anio,&
						li_no_acta,&
						ls_nivel, &
						li_cve_tipo_examen)
						
if li_periodo_evento<>li_periodo then
	MessageBox("Periodo Incorrecto","El periodo del acta no corresponde al del periodo vigente",StopSign!)
	em_codigo_barras.SelectText(1,len(ls_codigo_barras))	
	em_codigo_barras.SetFocus()	
	return	
end if

if li_anio_evento<>li_anio then
	MessageBox("Periodo Incorrecto","El año del acta no corresponde al del periodo vigente",StopSign!)
	em_codigo_barras.SelectText(1,len(ls_codigo_barras))	
	em_codigo_barras.SetFocus()	
	return	
end if



em_no_acta.text = string(li_no_acta)

//if ls_nivel = 'L' then
//	rb_licenciatura.checked = true
//elseif ls_nivel = 'P' then
//	rb_posgrado.checked = true		
//end if

uo_nivel.f_selecciona_nivel( ls_nivel, "L") 

if rb_con_firma.checked then
//CON FIRMA
	li_tipo_recepcion = 1
elseif rb_sin_firma.checked then
//SIN FIRMA
	li_tipo_recepcion = 0
else
	MessageBox("Error","Favor de elegir un tipo de recepción válido",StopSign!)
	return
end if

//Se asigna el estatus de RECIBIDA
li_cve_estatus_acta = 5
						
if li_codigo_retorno=-1 then
	MessageBox("Error","Codigo de barras erróneo",StopSign!)
	em_codigo_barras.SelectText(1,len(ls_codigo_barras))	
	em_codigo_barras.SetFocus()	
	return
else

	//Si ya se tranfirieron Apuntar a SYBASE
	if li_proceso_transferidas = 1 then
		dw_estadisticas.SetTransObject(gtr_sce )
	else
	//Apuntar a SQL SERVER
		dw_estadisticas.SetTransObject(itr_web )
	end if
	ll_retrieve_acta =dw_estadisticas.Retrieve(li_no_acta,ls_nivel,li_periodo, li_anio, li_cve_tipo_examen)
	if ll_retrieve_acta>0 then
		li_cve_estatus_acta_original = dw_estadisticas.GetItemNumber(1,"v_captura_actas_cve_estatus_acta")
		if li_cve_estatus_acta_original<>4 then
			MessageBox("Error","El Acta ["+string(li_no_acta)+" - "+ls_nivel+"] Tipo de Examen ["+string(li_cve_tipo_examen)+"] no se encuentra en estatus 4-IMPRESA.~n"+&
							"Por lo tanto no puede Recibirse.",StopSign!)
			em_codigo_barras.SelectText(1,len(ls_codigo_barras))	
			em_codigo_barras.SetFocus()								
			return		
		end if
	else
			MessageBox("Error","No se encuentra el acta ["+string(li_no_acta)+"-"+ls_nivel+"] Tipo de Examen ["+string(li_cve_tipo_examen)+"] o es de Intercambio."+&
							"Por lo tanto no puede Recibirse.",StopSign!)		
			return		
	end if
	//Si ya se tranfirieron Apuntar a SYBASE
	if li_proceso_transferidas = 1 then
		li_actualiza_estatus_acta =	f_actualiza_estatus_acta_ets(li_no_acta,ls_nivel,li_periodo, li_anio, li_cve_estatus_acta,li_tipo_recepcion, li_cve_tipo_examen,  gtr_sce )
	else
	//Apuntar a SQL SERVER
		li_actualiza_estatus_acta =	f_actualiza_estatus_acta_ets(li_no_acta,ls_nivel,li_periodo, li_anio, li_cve_estatus_acta,li_tipo_recepcion, li_cve_tipo_examen, itr_web )
	end if


	if li_actualiza_estatus_acta <> -1 then
		dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
		dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")
		dw_estadisticas.Retrieve(li_no_acta,ls_nivel,li_periodo, li_anio, li_cve_tipo_examen)
	end if
	em_codigo_barras.SelectText(1,len(ls_codigo_barras))	
	em_codigo_barras.SetFocus()	
	return	
end if
end event

type em_codigo_barras from editmask within w_acta_lectura_firmada_ets
integer x = 3950
integer y = 752
integer width = 590
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "xxxxxxxxxxxxxxxxxxx"
end type

event modified;cb_valida_codigo.event clicked()
end event

type st_1 from statictext within w_acta_lectura_firmada_ets
integer x = 3392
integer y = 776
integer width = 489
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Código de Barras:"
boolean focusrectangle = false
end type

type rb_todas_nivel from radiobutton within w_acta_lectura_firmada_ets
boolean visible = false
integer x = 2898
integer y = 824
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
string text = "Todas por Nivel"
end type

event clicked;dw_estadisticas.dataobject = "d_reconocimientos_departamento_tcap"
dw_estadisticas.SetTransObject(gtr_sce)

dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")
end event

type rb_acta_nivel from radiobutton within w_acta_lectura_firmada_ets
boolean visible = false
integer x = 2898
integer y = 736
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

dw_estadisticas.dataobject = "d_acta_oficial"
dw_estadisticas.SetTransObject(gtr_sce)

dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")
end event

type st_4 from statictext within w_acta_lectura_firmada_ets
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

type uoi_coordinaciones from uo_coordinaciones within w_acta_lectura_firmada_ets
boolean visible = false
integer x = 594
integer y = 464
integer taborder = 110
boolean border = false
end type

on uoi_coordinaciones.destroy
call uo_coordinaciones::destroy
end on

type em_no_acta from editmask within w_acta_lectura_firmada_ets
integer x = 3035
integer y = 484
integer width = 347
integer height = 112
integer taborder = 90
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

event modified;

INTEGER le_pos 
STRING ls_busca 


ls_busca = "acta_evaluacion_preeliminar_no_acta = " + STRING(THIS.TEXT) 


le_pos = dw_acta_listado_profesor.FIND(ls_busca, 0, dw_acta_listado_profesor.ROWCOUNT() + 1)

IF le_pos > 0 THEN 
	wf_selecciona_acta(le_pos)
END IF






end event

type st_2 from statictext within w_acta_lectura_firmada_ets
integer x = 3785
integer y = 320
integer width = 343
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
string text = "No. de Acta"
boolean focusrectangle = false
end type

type uo_profesor from uo_nombre_profesor within w_acta_lectura_firmada_ets
integer x = 41
integer y = 224
integer taborder = 30
boolean enabled = true
end type

on uo_profesor.destroy
call uo_nombre_profesor::destroy
end on

type uo_grupo from uo_grupos_filtro within w_acta_lectura_firmada_ets
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

type rb_departamento from radiobutton within w_acta_lectura_firmada_ets
boolean visible = false
integer x = 2880
integer y = 632
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

type rb_5 from radiobutton within w_acta_lectura_firmada_ets
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

type rb_4 from radiobutton within w_acta_lectura_firmada_ets
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

type rb_3 from radiobutton within w_acta_lectura_firmada_ets
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

type rb_grupo from radiobutton within w_acta_lectura_firmada_ets
boolean visible = false
integer x = 2880
integer y = 572
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

type rb_profesor from radiobutton within w_acta_lectura_firmada_ets
boolean visible = false
integer x = 2880
integer y = 484
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
end type

event clicked;dw_estadisticas.dataobject = "d_reconocimientos_profesor_tcap"
dw_estadisticas.SetTransObject(gtr_sce)

dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")
end event

type gb_coordinacion from groupbox within w_acta_lectura_firmada_ets
boolean visible = false
integer x = 2857
integer y = 440
integer width = 882
integer height = 516
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

type st_3 from statictext within w_acta_lectura_firmada_ets
boolean visible = false
integer x = 2181
integer y = 264
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

type dw_estadisticas from datawindow within w_acta_lectura_firmada_ets
integer x = 2880
integer y = 960
integer width = 2880
integer height = 2216
integer taborder = 100
string dataobject = "d_acta_oficial_ets"
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

type cb_lectura from commandbutton within w_acta_lectura_firmada_ets
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 4114
integer y = 488
integer width = 370
integer height = 108
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Recepción"
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
string ls_nivel
integer li_periodo_evento,li_anio_evento,li_evento_extraordinario_titulo, li_codigo_retorno
integer li_periodo_acta,li_anio_acta, li_tipo_recepcion, li_cve_estatus_acta, li_actualiza_estatus_acta
long ll_retrieve_acta
integer li_cve_estatus_acta_original
integer li_proceso_en_captura, li_proceso_transferidas, li_cve_tipo_examen
ll_cve_mat = uo_grupo.il_cve_mat
ls_gpo = uo_grupo.is_gpo


ll_cve_profesor = uo_profesor.of_obten_cve_profesor()
//ll_cve_coordinacion = uoi_coordinaciones.of_obten_cve_coordinacion()

li_evento_extraordinario_titulo = 12

f_obten_periodo_tipo(li_periodo_evento,li_anio_evento,li_evento_extraordinario_titulo, is_tipo_periodo) 

li_proceso_en_captura   = f_obten_estatus_proceso_actas(104, li_periodo_evento,li_anio_evento, gtr_sce)
li_proceso_transferidas = f_obten_estatus_proceso_actas(107, li_periodo_evento,li_anio_evento, gtr_sce)


if li_proceso_en_captura = 0 then
	MessageBox("Recepción de Actas No habilitadas", "Por favor solicite a la Jefatura de Control Escolar que habilite la recepción de actas.", StopSign!)
	return
end if

/*
if li_periodo_evento<0 or li_periodo_evento>2 then
	MessageBox("Error", "Es necesario seleccionar un Periodo Válido", StopSign!)
	return
end if
*/

//if rb_licenciatura.checked then
//	ls_nivel = "L"
//elseif rb_posgrado.checked then
//	ls_nivel = "P"
//else
//	MessageBox("Error", "Es necesario seleccionar un Nivel", StopSign!)
//	return
//end if

ls_nivel = uo_nivel.cve_nivel 

//LEE EL TIPO DE EXAMEN DEL ACTA
if rb_extraordinario.checked then
	li_cve_tipo_examen = 2
elseif rb_a_titulo.checked then
	li_cve_tipo_examen = 6
else
	MessageBox("Error", "Es necesario seleccionar un Tipo de Examen", StopSign!)
	return
end if


//ls_anio = em_anio.text

if isnull(li_anio_evento) then
	MessageBox("Error", "Es necesario escribir un Año", StopSign!)
	return
end if

li_anio= li_anio_evento


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

dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")

dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '70'")


li_evento_extraordinario_titulo = 12

f_obten_periodo(li_periodo_evento,li_anio_evento,li_evento_extraordinario_titulo)

li_periodo = li_periodo_evento
li_anio = li_anio_evento
						
if li_periodo_evento<>li_periodo then
	MessageBox("Periodo Incorrecto","El periodo del acta no corresponde al del periodo vigente",StopSign!)
	return	
end if

if li_anio_evento<>li_anio then
	MessageBox("Periodo Incorrecto","El año del acta no corresponde al del periodo vigente",StopSign!)
	return	
end if

if rb_con_firma.checked then
//CON FIRMA
	li_tipo_recepcion = 1
elseif rb_sin_firma.checked then
//SIN FIRMA
	li_tipo_recepcion = 0
else
	MessageBox("Error","Favor de elegir un tipo de recepción válido",StopSign!)
	return
end if

//Se asigna el estatus de RECIBIDA
li_cve_estatus_acta = 5
						
MESSAGEBOX("Aviso", "Se hará recepción de un Acta de un periodo " + is_descripcion_tipo) 												
						
						
if li_codigo_retorno=-1 then
	MessageBox("Error","Codigo de barras erróneo",StopSign!)
	return
else
	//Si ya se tranfirieron Apuntar a SYBASE
	if li_proceso_transferidas = 1 then
		dw_estadisticas.dataobject = 'd_acta_oficial_con_zz_ets'
		dw_estadisticas.SetTransObject(gtr_sce )
	else
	//Apuntar a SQL SERVER
		dw_estadisticas.dataobject = 'd_acta_oficial_ets'
		dw_estadisticas.SetTransObject(itr_web )
	end if

	ll_retrieve_acta =dw_estadisticas.Retrieve(ll_no_acta,ls_nivel,li_periodo, li_anio, li_cve_tipo_examen)
	
	if ll_retrieve_acta>0 then
		li_cve_estatus_acta_original = dw_estadisticas.GetItemNumber(1,"v_captura_actas_cve_estatus_acta")
		if li_cve_estatus_acta_original<>4 then
			MessageBox("Error","El Acta no se encuentra en estatus 4-IMPRESA.~n"+&
							"Por lo tanto no puede Recibirse.",StopSign!)
			return		
		end if
	else
			MessageBox("Error","No se encuentra el acta ["+string(ll_no_acta)+"-"+ls_nivel+"] o es de Intercambio."+&
							"Por lo tanto no puede Recibirse.",StopSign!)		
			return		
	end if
	
	
	//Si ya se tranfirieron Apuntar a SYBASE
	if li_proceso_transferidas = 1 then
		li_actualiza_estatus_acta =	f_actualiza_estatus_acta_ets(ll_no_acta,ls_nivel,li_periodo, li_anio, li_cve_estatus_acta,li_tipo_recepcion, li_cve_tipo_examen, gtr_sce )
	else
	//Apuntar a SQL SERVER
		li_actualiza_estatus_acta =	f_actualiza_estatus_acta_ets(ll_no_acta,ls_nivel,li_periodo, li_anio, li_cve_estatus_acta,li_tipo_recepcion, li_cve_tipo_examen, itr_web )
	end if

	if li_actualiza_estatus_acta <> -1 then
		dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
		dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '75'")
		dw_estadisticas.Retrieve(ll_no_acta,ls_nivel,li_periodo, li_anio, li_cve_tipo_examen)
	end if
	em_codigo_barras.SelectText(1,len(em_codigo_barras.text))	
	em_codigo_barras.SetFocus()	
	return	
end if








end event

event constructor;TabOrder = 4
end event

type dw_1x from datawindow within w_acta_lectura_firmada_ets
boolean visible = false
integer x = 3767
integer y = 624
integer width = 1038
integer height = 564
integer taborder = 80
string dataobject = "dw_repo_mad_18_gx"
boolean livescroll = true
end type

type gb_8 from groupbox within w_acta_lectura_firmada_ets
boolean visible = false
integer x = 2235
integer y = 56
integer width = 329
integer height = 176
integer taborder = 140
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_acta_lectura_firmada_ets
integer x = 2935
integer y = 68
integer width = 553
integer height = 388
integer taborder = 130
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nivel"
end type

type gb_2 from groupbox within w_acta_lectura_firmada_ets
integer x = 4718
integer y = 156
integer width = 768
integer height = 296
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Elija el tipo de Recepción"
end type

type gb_3 from groupbox within w_acta_lectura_firmada_ets
integer x = 2871
integer y = 4
integer width = 1760
integer height = 628
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Manual"
end type

type gb_4 from groupbox within w_acta_lectura_firmada_ets
integer x = 2871
integer y = 672
integer width = 1760
integer height = 248
integer taborder = 120
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Con Lector"
end type

