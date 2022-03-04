$PBExportHeader$w_acta_oficial_reporte_tablero.srw
forward
global type w_acta_oficial_reporte_tablero from window
end type
type uo_nivel from uo_nivel_rbutton within w_acta_oficial_reporte_tablero
end type
type gb_coordinacion from groupbox within w_acta_oficial_reporte_tablero
end type
type uo_periodos from uo_per_ani within w_acta_oficial_reporte_tablero
end type
type st_4 from statictext within w_acta_oficial_reporte_tablero
end type
type uoi_coordinaciones from uo_coordinaciones within w_acta_oficial_reporte_tablero
end type
type em_no_acta from editmask within w_acta_oficial_reporte_tablero
end type
type st_2 from statictext within w_acta_oficial_reporte_tablero
end type
type uo_profesor from uo_nombre_profesor within w_acta_oficial_reporte_tablero
end type
type rb_5 from radiobutton within w_acta_oficial_reporte_tablero
end type
type rb_4 from radiobutton within w_acta_oficial_reporte_tablero
end type
type rb_3 from radiobutton within w_acta_oficial_reporte_tablero
end type
type st_3 from statictext within w_acta_oficial_reporte_tablero
end type
type dw_estadisticas from datawindow within w_acta_oficial_reporte_tablero
end type
type cb_1 from commandbutton within w_acta_oficial_reporte_tablero
end type
type em_anio from editmask within w_acta_oficial_reporte_tablero
end type
type dw_1x from datawindow within w_acta_oficial_reporte_tablero
end type
type gb_8 from groupbox within w_acta_oficial_reporte_tablero
end type
type gb_11 from groupbox within w_acta_oficial_reporte_tablero
end type
type gb_20 from groupbox within w_acta_oficial_reporte_tablero
end type
type gb_2 from groupbox within w_acta_oficial_reporte_tablero
end type
type rb_ordinario from radiobutton within w_acta_oficial_reporte_tablero
end type
type rb_extrao_tit from radiobutton within w_acta_oficial_reporte_tablero
end type
type rb_departamento from radiobutton within w_acta_oficial_reporte_tablero
end type
type uo_grupo from uo_grupos_filtro within w_acta_oficial_reporte_tablero
end type
type gb_1 from groupbox within w_acta_oficial_reporte_tablero
end type
end forward

global type w_acta_oficial_reporte_tablero from window
boolean visible = false
integer width = 6894
integer height = 3504
boolean titlebar = true
string title = "Impresión de Reportes de Tablero"
string menuname = "m_estad_alum_mat"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
uo_nivel uo_nivel
gb_coordinacion gb_coordinacion
uo_periodos uo_periodos
st_4 st_4
uoi_coordinaciones uoi_coordinaciones
em_no_acta em_no_acta
st_2 st_2
uo_profesor uo_profesor
rb_5 rb_5
rb_4 rb_4
rb_3 rb_3
st_3 st_3
dw_estadisticas dw_estadisticas
cb_1 cb_1
em_anio em_anio
dw_1x dw_1x
gb_8 gb_8
gb_11 gb_11
gb_20 gb_20
gb_2 gb_2
rb_ordinario rb_ordinario
rb_extrao_tit rb_extrao_tit
rb_departamento rb_departamento
uo_grupo uo_grupo
gb_1 gb_1
end type
global w_acta_oficial_reporte_tablero w_acta_oficial_reporte_tablero

type variables
//int periodo_x

integer ii_periodo, ii_anio

integer ii_cupo, ii_coord_usuario, ii_cve_coordinacion

string is_gpo_asimilado
Transaction itr_parametros_iniciales
n_tr itr_seguridad, itr_original

//nombre de la conexion en parametros_conexion
CONSTANT	string	is_controlescolar_cnx	=	"controlescolar_inscripcion"
CONSTANT	string	is_tesoreria_cnx			=	"controlescolar_inscripcion_tesoreria"
CONSTANT	string	is_becas_cnx				=	"controlescolar_inscripcion_becas"


uo_periodo_servicios iuo_periodo_servicios

end variables

on w_acta_oficial_reporte_tablero.create
if this.MenuName = "m_estad_alum_mat" then this.MenuID = create m_estad_alum_mat
this.uo_nivel=create uo_nivel
this.gb_coordinacion=create gb_coordinacion
this.uo_periodos=create uo_periodos
this.st_4=create st_4
this.uoi_coordinaciones=create uoi_coordinaciones
this.em_no_acta=create em_no_acta
this.st_2=create st_2
this.uo_profesor=create uo_profesor
this.rb_5=create rb_5
this.rb_4=create rb_4
this.rb_3=create rb_3
this.st_3=create st_3
this.dw_estadisticas=create dw_estadisticas
this.cb_1=create cb_1
this.em_anio=create em_anio
this.dw_1x=create dw_1x
this.gb_8=create gb_8
this.gb_11=create gb_11
this.gb_20=create gb_20
this.gb_2=create gb_2
this.rb_ordinario=create rb_ordinario
this.rb_extrao_tit=create rb_extrao_tit
this.rb_departamento=create rb_departamento
this.uo_grupo=create uo_grupo
this.gb_1=create gb_1
this.Control[]={this.uo_nivel,&
this.gb_coordinacion,&
this.uo_periodos,&
this.st_4,&
this.uoi_coordinaciones,&
this.em_no_acta,&
this.st_2,&
this.uo_profesor,&
this.rb_5,&
this.rb_4,&
this.rb_3,&
this.st_3,&
this.dw_estadisticas,&
this.cb_1,&
this.em_anio,&
this.dw_1x,&
this.gb_8,&
this.gb_11,&
this.gb_20,&
this.gb_2,&
this.rb_ordinario,&
this.rb_extrao_tit,&
this.rb_departamento,&
this.uo_grupo,&
this.gb_1}
end on

on w_acta_oficial_reporte_tablero.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nivel)
destroy(this.gb_coordinacion)
destroy(this.uo_periodos)
destroy(this.st_4)
destroy(this.uoi_coordinaciones)
destroy(this.em_no_acta)
destroy(this.st_2)
destroy(this.uo_profesor)
destroy(this.rb_5)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.st_3)
destroy(this.dw_estadisticas)
destroy(this.cb_1)
destroy(this.em_anio)
destroy(this.dw_1x)
destroy(this.gb_8)
destroy(this.gb_11)
destroy(this.gb_20)
destroy(this.gb_2)
destroy(this.rb_ordinario)
destroy(this.rb_extrao_tit)
destroy(this.rb_departamento)
destroy(this.uo_grupo)
destroy(this.gb_1)
end on

event open;this.x=1
this.y=1

long ll_row, ll_row_actual, ll_rows_coordinaciones, ll_row_coordinacion, ll_cve_coordinacion
int li_retorno, li_periodo, li_anio, li_coord_usuario, li_chk, li_num_items, li_item_actual
int li_evento_baja_total = 11, li_proceso_en_captura = 4, li_proceso_transferidas = 7

// Se incializa objeto de nivel.
THIS.uo_nivel.f_genera_nivel( "V", "C", "L", gtr_sce, "N", "N") 

li_retorno = f_obten_periodo(li_periodo, li_anio, li_evento_baja_total)

if li_retorno = -1 then
	MessageBox("Error en calendario", "No es posible leer el periodo de baja total",StopSign!)
	if li_coord_usuario <> 9999 then
		close(this	)
	end if
end if

li_proceso_en_captura   = f_obten_estatus_proceso_actas(4, li_periodo,li_anio, gtr_sce)
li_proceso_transferidas = f_obten_estatus_proceso_actas(7, li_periodo,li_anio, gtr_sce)

//Cambio por Actas en Línea
//1)->
//Se conecta a la seguridad para mantener separada una transacción para la seguridad
if not (conecta_bd_n_tr(itr_seguridad,gs_sce,gs_usuario,gs_password) = 1) then
	messageBox('Error en seguridad', 'No es posible validar la seguridad del usuario',Stopsign!)
end if

itr_parametros_iniciales = gtr_sce
if li_proceso_transferidas= 0 then
	li_chk	=	f_conecta_pas_parametros_act_bd(itr_parametros_iniciales,gtr_sce,is_controlescolar_cnx,gs_usuario,gs_password,0)
	if li_chk <> 1 then return
end if


//Es necesario reasignar el transaction object para la seguridad
gnv_app.of_SetSecurity(TRUE)
gnv_app.itr_security = itr_seguridad
gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), gs_sce)
gnv_app.itr_security.of_Connect()
if (gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, gs_usuario,"Default") <> 1) then
		MessageBox("Atención","No se pudo inicializar correctamente la seguridad")
		Close(this)
end if

//Cambio por Actas en Línea
//1)<-


//Habilita la seguridad para la ventana actual

/**/
//gnv_app.inv_security.of_SetSecurity(this)


uoi_coordinaciones.backcolor = this.backcolor
uoi_coordinaciones.enabled = true

uo_grupo.rb_editar.visible = false
uo_grupo.rb_insertar.visible = false

dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")

ii_cve_coordinacion = f_obten_coord_de_usuario(gs_usuario)

if ii_cve_coordinacion = 9999 then
//Ve todo
elseif ii_cve_coordinacion = -1 then
	MessageBox("Error en lectura de coordinacion", "No es posible determinar la coordinacion del usuario",StopSign!)
	close(this)
else	
//Solo su coordinacion
end if

//Cambio por Actas en Línea
//2)->
//Se vuelve a poner porque en el constructor de los datawindows ya previamente se había ejecutado apuntando a sybase

dw_estadisticas.SetTransObject(gtr_sce)

f_obten_titulo(w_principal)

w_principal.ChangeMenu(m_grupos_impartidos_salir)

	//Modif. Roberto Novoa R.  May/2016 - Funcionalidad de periodos múltiples
	iuo_periodo_servicios = CREATE uo_periodo_servicios
	iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)


ll_row_actual = this.uoi_coordinaciones.dw_coordinaciones.GetRow()

ll_rows_coordinaciones = this.uoi_coordinaciones.dw_coordinaciones.RowCount()

//this.uoi_coordinaciones.dw_coordinaciones.SetItem(ll_row_actual,"cve_coordinacion", ii_cve_coordinacion)


// 31/10/2017 //
//IF ll_rows_coordinaciones> 0 THEN
//	ll_row_coordinacion = this.uoi_coordinaciones.dw_coordinaciones.GetRow()
//	ll_cve_coordinacion = this.uoi_coordinaciones.dw_coordinaciones.GetItemNumber(ll_row_coordinacion, 1)
//ELSE
//	MessageBox("Tabla sin coordinaciones", "No existen coordinaciones registradas",StopSign!)
//	return
//END IF
// 31/10/2017 //

IF ii_cve_coordinacion <> 9999 THEN 
	this.uoi_coordinaciones.enabled = false
ELSE
	this.uoi_coordinaciones.enabled = true
END IF





//Cambio por Actas en Línea
//2)<- 






end event

event close;//Cambio por Actas en Línea
//3)->
//Se conecta a la base de datos original para reasignar a la transacción principal
if not (conecta_bd_n_tr(itr_original,gs_sce,gs_usuario,gs_password) = 1) then
	messageBox('Error en conectividad', 'No es posible reconectarse al origen. Favor de reiniciar la aplicación',Stopsign!)
	HALT CLOSE		
end if

//Se asigna la transacción original
gtr_sce = itr_original 

//Es necesario reasignar el transaction object para la seguridad
gnv_app.of_SetSecurity(TRUE)
gnv_app.itr_security = gtr_sce
gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), gs_sce)
gnv_app.itr_security.of_Connect()
if (gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, gs_usuario,"Default") <> 1) then
		MessageBox("Atención","No se pudo inicializar correctamente la seguridad")
		Close(this)
end if

f_obten_titulo(w_principal)
w_principal.ChangeMenu(m_principal)
gnv_app.inv_security.of_SetSecurity(w_principal)
//Cambio por Actas en Línea
//3)<-

end event

type uo_nivel from uo_nivel_rbutton within w_acta_oficial_reporte_tablero
integer x = 503
integer y = 224
integer width = 859
integer height = 312
integer taborder = 70
end type

on uo_nivel.destroy
call uo_nivel_rbutton::destroy
end on

type gb_coordinacion from groupbox within w_acta_oficial_reporte_tablero
boolean visible = false
integer x = 562
integer y = 672
integer width = 882
integer height = 364
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Reportes a Generar"
borderstyle borderstyle = styleraised!
end type

type uo_periodos from uo_per_ani within w_acta_oficial_reporte_tablero
integer x = 2907
integer y = 88
integer taborder = 100
boolean enabled = true
end type

on uo_periodos.destroy
call uo_per_ani::destroy
end on

type st_4 from statictext within w_acta_oficial_reporte_tablero
integer x = 101
integer y = 60
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

type uoi_coordinaciones from uo_coordinaciones within w_acta_oficial_reporte_tablero
integer x = 594
integer y = 36
integer taborder = 90
boolean border = false
end type

on uoi_coordinaciones.destroy
call uo_coordinaciones::destroy
end on

event carga;call super::carga;IF  THIS.dw_coordinaciones.ROWCOUNT() > 0 THEN 
	THIS.dw_coordinaciones.SetItem(1,"cve_coordinacion", ii_cve_coordinacion)
END IF
end event

type em_no_acta from editmask within w_acta_oficial_reporte_tablero
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

type st_2 from statictext within w_acta_oficial_reporte_tablero
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

type uo_profesor from uo_nombre_profesor within w_acta_oficial_reporte_tablero
boolean visible = false
integer x = 27
integer y = 32
integer taborder = 30
boolean enabled = true
end type

on uo_profesor.destroy
call uo_nombre_profesor::destroy
end on

type rb_5 from radiobutton within w_acta_oficial_reporte_tablero
boolean visible = false
integer x = 1266
integer y = 676
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

type rb_4 from radiobutton within w_acta_oficial_reporte_tablero
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

type rb_3 from radiobutton within w_acta_oficial_reporte_tablero
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

type st_3 from statictext within w_acta_oficial_reporte_tablero
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

type dw_estadisticas from datawindow within w_acta_oficial_reporte_tablero
integer x = 151
integer y = 568
integer width = 4274
integer height = 2648
integer taborder = 80
string dataobject = "d_acta_oficial_coordinacion_rt"
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

type cb_1 from commandbutton within w_acta_oficial_reporte_tablero
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 2281
integer y = 52
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
integer li_cve_estatus_confirmadas = 3

ll_cve_mat = uo_grupo.il_cve_mat
ls_gpo = uo_grupo.is_gpo


ll_cve_profesor = uo_profesor.of_obten_cve_profesor()
ll_cve_coordinacion = uoi_coordinaciones.of_obten_cve_coordinacion()

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

ls_nivel = PARENT.uo_nivel.cve_nivel 
ls_anio = PARENT.uo_periodos.em_ani.text

//ls_anio = em_anio.text

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
dw_estadisticas.object.st_fecha_hoy.text= ls_fecha_servidor
//

dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")

dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")

//Actas por Coordinacion
if rb_departamento.checked then
//	MessageBox("Generando Reporte", "Por Coordinación",Information!)
	ll_rows = dw_estadisticas.Retrieve(ll_cve_coordinacion, li_periodo, li_anio,li_cve_estatus_confirmadas, ls_nivel)
end if

dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")



	







end event

event constructor;TabOrder = 4
end event

type em_anio from editmask within w_acta_oficial_reporte_tablero
event constructor pbm_constructor
event modified pbm_enmodified
boolean visible = false
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
boolean enabled = false
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

type dw_1x from datawindow within w_acta_oficial_reporte_tablero
boolean visible = false
integer x = 3767
integer y = 624
integer width = 1038
integer height = 564
integer taborder = 70
string dataobject = "dw_repo_mad_18_gx"
boolean livescroll = true
end type

type gb_8 from groupbox within w_acta_oficial_reporte_tablero
integer x = 2249
integer y = 8
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

type gb_11 from groupbox within w_acta_oficial_reporte_tablero
boolean visible = false
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

type gb_20 from groupbox within w_acta_oficial_reporte_tablero
integer x = 2857
integer y = 24
integer width = 1335
integer height = 236
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

type gb_2 from groupbox within w_acta_oficial_reporte_tablero
integer x = 1545
integer y = 228
integer width = 960
integer height = 300
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Tipo de Examen"
borderstyle borderstyle = styleraised!
end type

type rb_ordinario from radiobutton within w_acta_oficial_reporte_tablero
integer x = 1614
integer y = 304
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ordinario"
boolean checked = true
end type

event clicked;dw_estadisticas.dataobject= 'd_acta_oficial_coordinacion_rt'
dw_estadisticas.SetTransObject(gtr_sce)
dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")
end event

type rb_extrao_tit from radiobutton within w_acta_oficial_reporte_tablero
integer x = 1614
integer y = 400
integer width = 882
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Extrardinario y a Título de Suf."
end type

event clicked;dw_estadisticas.dataobject= 'd_acta_oficial_coordinacion_rt_ets'
dw_estadisticas.SetTransObject(gtr_sce)
dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")

end event

type rb_departamento from radiobutton within w_acta_oficial_reporte_tablero
integer x = 2697
integer y = 324
integer width = 745
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Por Coordinación"
boolean checked = true
end type

event clicked;dw_estadisticas.dataobject = "d_acta_oficial_coordinacion_rt"
dw_estadisticas.SetTransObject(gtr_sce)

dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")
end event

type uo_grupo from uo_grupos_filtro within w_acta_oficial_reporte_tablero
boolean visible = false
integer y = 876
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

type gb_1 from groupbox within w_acta_oficial_reporte_tablero
integer x = 462
integer y = 172
integer width = 942
integer height = 388
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

