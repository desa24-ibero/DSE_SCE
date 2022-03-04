﻿$PBExportHeader$w_rep_extrao_tit.srw
forward
global type w_rep_extrao_tit from window
end type
type uo_periodos from uo_per_ani within w_rep_extrao_tit
end type
type dw_extrao_tit from datawindow within w_rep_extrao_tit
end type
type cb_procesar_autorizaciones from commandbutton within w_rep_extrao_tit
end type
type cbx_cursativas from checkbox within w_rep_extrao_tit
end type
type uo_coordinacion from uo_dgmu_coordinaciones within w_rep_extrao_tit
end type
type st_3 from statictext within w_rep_extrao_tit
end type
type dw_estadisticas from datawindow within w_rep_extrao_tit
end type
type cb_1 from commandbutton within w_rep_extrao_tit
end type
type em_anio from editmask within w_rep_extrao_tit
end type
type dw_1x from datawindow within w_rep_extrao_tit
end type
type gb_8 from groupbox within w_rep_extrao_tit
end type
type gb_11 from groupbox within w_rep_extrao_tit
end type
type gb_20 from groupbox within w_rep_extrao_tit
end type
type gb_2 from groupbox within w_rep_extrao_tit
end type
type gb_nivel from groupbox within w_rep_extrao_tit
end type
type gb_1 from groupbox within w_rep_extrao_tit
end type
type uo_nivel from uo_nivel_rbutton within w_rep_extrao_tit
end type
end forward

global type w_rep_extrao_tit from window
integer width = 4974
integer height = 3228
boolean titlebar = true
string title = "Reporte de Extraordinario y a Título de Suficiencia"
string menuname = "m_estad_alum_mat"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 79741120
uo_periodos uo_periodos
dw_extrao_tit dw_extrao_tit
cb_procesar_autorizaciones cb_procesar_autorizaciones
cbx_cursativas cbx_cursativas
uo_coordinacion uo_coordinacion
st_3 st_3
dw_estadisticas dw_estadisticas
cb_1 cb_1
em_anio em_anio
dw_1x dw_1x
gb_8 gb_8
gb_11 gb_11
gb_20 gb_20
gb_2 gb_2
gb_nivel gb_nivel
gb_1 gb_1
uo_nivel uo_nivel
end type
global w_rep_extrao_tit w_rep_extrao_tit

type variables
//int periodo_x

integer ii_periodo, ii_anio


boolean ib_borrando= false
long il_cve_asimilada
integer ii_cupo, ii_coord_usuario, ii_cve_coordinacion
string is_gpo_asimilado
Transaction itr_parametros_iniciales
n_tr itr_seguridad, itr_original

//nombre de la conexion en parametros_conexion
CONSTANT	string	is_controlescolar_cnx	=	"controlescolar_ets"
CONSTANT	string	is_tesoreria_cnx			=	"controlescolar_inscripcion_tesoreria"
CONSTANT	string	is_becas_cnx				=	"controlescolar_inscripcion_becas"


uo_periodo_servicios iuo_periodo_servicios



end variables

on w_rep_extrao_tit.create
if this.MenuName = "m_estad_alum_mat" then this.MenuID = create m_estad_alum_mat
this.uo_periodos=create uo_periodos
this.dw_extrao_tit=create dw_extrao_tit
this.cb_procesar_autorizaciones=create cb_procesar_autorizaciones
this.cbx_cursativas=create cbx_cursativas
this.uo_coordinacion=create uo_coordinacion
this.st_3=create st_3
this.dw_estadisticas=create dw_estadisticas
this.cb_1=create cb_1
this.em_anio=create em_anio
this.dw_1x=create dw_1x
this.gb_8=create gb_8
this.gb_11=create gb_11
this.gb_20=create gb_20
this.gb_2=create gb_2
this.gb_nivel=create gb_nivel
this.gb_1=create gb_1
this.uo_nivel=create uo_nivel
this.Control[]={this.uo_periodos,&
this.dw_extrao_tit,&
this.cb_procesar_autorizaciones,&
this.cbx_cursativas,&
this.uo_coordinacion,&
this.st_3,&
this.dw_estadisticas,&
this.cb_1,&
this.em_anio,&
this.dw_1x,&
this.gb_8,&
this.gb_11,&
this.gb_20,&
this.gb_2,&
this.gb_nivel,&
this.gb_1,&
this.uo_nivel}
end on

on w_rep_extrao_tit.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_periodos)
destroy(this.dw_extrao_tit)
destroy(this.cb_procesar_autorizaciones)
destroy(this.cbx_cursativas)
destroy(this.uo_coordinacion)
destroy(this.st_3)
destroy(this.dw_estadisticas)
destroy(this.cb_1)
destroy(this.em_anio)
destroy(this.dw_1x)
destroy(this.gb_8)
destroy(this.gb_11)
destroy(this.gb_20)
destroy(this.gb_2)
destroy(this.gb_nivel)
destroy(this.gb_1)
destroy(this.uo_nivel)
end on

event open;this.x=1
this.y=1
//rb_gpos_coord.event clicked()


long ll_row, ll_row_actual, ll_rows_coordinaciones, ll_row_coordinacion, ll_cve_coordinacion
int li_retorno, li_periodo, li_anio, li_coord_usuario, li_chk, li_num_items, li_item_actual
int li_evento_baja_total = 11, li_proceso_en_captura = 4, li_proceso_transferidas = 7
string ls_nivel
int li_nivel_coordinacion




//li_retorno = f_obten_periodo(li_periodo, li_anio, li_evento_baja_total)
//
//if li_retorno = -1 then
//	MessageBox("Error en calendario", "No es posible leer el periodo de baja total",StopSign!)
//	if li_coord_usuario <> 9999 then
//		close(this	)
//	end if
//end if
//
//li_proceso_en_captura   = f_obten_estatus_proceso_actas(4, li_periodo,li_anio, gtr_sce)
//li_proceso_transferidas = f_obten_estatus_proceso_actas(7, li_periodo,li_anio, gtr_sce)



////Cambio por Ajustes en Línea
////1)->
////Se conecta a la seguridad para mantener separada una transacción para la seguridad
//if not (conecta_bd_n_tr(itr_seguridad,"SCE",gs_usuario,gs_password) = 1) then
//	messageBox('Error en seguridad', 'No es posible validar la seguridad del usuario',Stopsign!)
//end if
//
//itr_parametros_iniciales = gtr_sce
////Se redirige la ventana a Web, para que las consultas coincidan con la base de web
//li_chk	=	f_conecta_pas_parametros_act_bd(itr_parametros_iniciales,gtr_sce,is_controlescolar_cnx,gs_usuario,gs_password,1)
//if li_chk <> 1 then return
//
//
////Es necesario reasignar el transaction object para la seguridad
//gnv_app.of_SetSecurity(TRUE)
//gnv_app.itr_security = itr_seguridad
//gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), gs_sce)
//gnv_app.itr_security.of_Connect()
//if (gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, gs_usuario,"Default") <> 1) then
//		MessageBox("Atención","No se pudo inicializar correctamente la seguridad")
//		Close(this)
//end if
//
////Cambio por Ajustes en Línea
////1)<-

//Habilita la seguridad para la ventana actual

/**/
//gnv_app.inv_security.of_SetSecurity(this)

gi_anio=li_anio
gi_periodo=li_periodo


ii_cve_coordinacion = f_obten_coord_de_usuario(gs_usuario)

if ii_cve_coordinacion = 9999 then
	gb_nivel.visible = true
//	rb_licenciatura.visible = true
//	rb_posgrado.visible = true
	uo_nivel.visible = true
//	cbx_descuenta_sdu_se.enabled = true

elseif ii_cve_coordinacion = -1 then
	MessageBox("Error en lectura de coordinacion", "No es posible determinar la coordinacion del usuario",StopSign!)
	close(this)
else	
	gb_nivel.visible = false
//	rb_licenciatura.visible = false
//	rb_posgrado.visible = false
	uo_nivel.visible = false 
//	cbx_descuenta_sdu_se.enabled = false
end if

li_nivel_coordinacion= f_obten_nivel_coordinacion(ii_cve_coordinacion, ls_nivel)

if li_nivel_coordinacion= -1 then
	MessageBox("Error en lectura de coordinacion", "No es posible determinar el nivel de la coordinacion del usuario",StopSign!)
	close(this)	
end if

//Cambio por Ajustes en Línea
//2)->
//Se vuelve a poner porque en el constructor de los datawindows ya previamente se había ejecutado apuntando a sybase

//if ls_nivel = 'L' then
if ls_nivel <> 'P' then
	dw_estadisticas.dataobject = 	'd_extrao_tit_lic'
	dw_extrao_tit.dataobject = 	'd_extrao_tit_lic'
elseif ls_nivel = 'P' then
	dw_estadisticas.dataobject = 	'd_extrao_tit_lic'	
	dw_extrao_tit.dataobject = 	'd_extrao_tit_lic'
end if

dw_estadisticas.SetTransObject(gtr_sce)
dw_extrao_tit.SetTransObject(gtr_sce)

dw_estadisticas.SetRowFocusIndicator(Hand!)
dw_extrao_tit.SetRowFocusIndicator(Hand!)

//f_obten_titulo(w_principal)
//
//w_principal.ChangeMenu(m_grupos_impartidos_salir)


ll_row_actual = this.uo_coordinacion.dw_coordinaciones.GetRow()

ll_rows_coordinaciones = this.uo_coordinacion.dw_coordinaciones.RowCount()

this.uo_coordinacion.dw_coordinaciones.SetItem(ll_row_actual,"cve_coordinacion", ii_cve_coordinacion)


	//Modif. Roberto Novoa R.  May/2016 - Funcionalidad de periodos múltiples
	iuo_periodo_servicios = CREATE uo_periodo_servicios
	iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)


IF ll_rows_coordinaciones> 0 THEN
	ll_row_coordinacion = this.uo_coordinacion.dw_coordinaciones.GetRow()
	ll_cve_coordinacion = this.uo_coordinacion.dw_coordinaciones.GetItemNumber(ll_row_coordinacion, 1)
ELSE
	MessageBox("Tabla sin coordinaciones", "No existen coordinaciones registradas",StopSign!)
	return
END IF

IF ii_cve_coordinacion <> 9999 THEN 
	this.uo_coordinacion.enabled = false
//	cbx_filtra_zz.visible = false
ELSE
	this.uo_coordinacion.enabled = true
//	cbx_filtra_zz.visible = true
END IF

THIS.uo_nivel.f_genera_nivel( "V", "L", "L", gtr_sce, "N", "N") 


//Cambio por Ajustes en Línea
//2)<-
//rb_gpos_coord.event clicked()


end event

event close;////Cambio por Ajustes en Línea
////3)->
////Se conecta a la base de datos original para reasignar a la transacción principal
//if not (conecta_bd_n_tr(itr_original,"SCE",gs_usuario,gs_password) = 1) then
//	messageBox('Error en conectividad', 'No es posible reconectarse al origen. Favor de reiniciar la aplicación',Stopsign!)
//	HALT CLOSE		
//end if
//
////Se asigna la transacción original
//gtr_sce = itr_original 
//
////Es necesario reasignar el transaction object para la seguridad
//gnv_app.of_SetSecurity(TRUE)
//gnv_app.itr_security = gtr_sce
//gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), gs_sce)
//gnv_app.itr_security.of_Connect()
//if (gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, gs_usuario,"Default") <> 1) then
//		MessageBox("Atención","No se pudo inicializar correctamente la seguridad")
//		Close(this)
//end if
//
//f_obten_titulo(w_principal)
//w_principal.ChangeMenu(m_principal)
//gnv_app.inv_security.of_SetSecurity(w_principal)
////Cambio por Ajustes en Línea
////3)<-

end event

type uo_periodos from uo_per_ani within w_rep_extrao_tit
integer x = 59
integer y = 124
integer taborder = 10
boolean enabled = true
end type

on uo_periodos.destroy
call uo_per_ani::destroy
end on

type dw_extrao_tit from datawindow within w_rep_extrao_tit
boolean visible = false
integer y = 1820
integer width = 4699
integer height = 1052
integer taborder = 140
string dataobject = "d_extrao_tit_lic"
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

type cb_procesar_autorizaciones from commandbutton within w_rep_extrao_tit
boolean visible = false
integer x = 1998
integer y = 1476
integer width = 704
integer height = 112
integer taborder = 150
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Procesar Autorizaciones"
end type

event clicked;integer li_confirmacion
long ll_rows, ll_row
integer li_autorizado, li_pagado, li_update

ll_rows = dw_estadisticas.RowCount()

IF ll_rows<= 0 THEN
	MessageBox("Sin Solicitudes","No existen solicitudes a procesar", StopSign!)
END IF

li_confirmacion = MessageBox("Confirmación","¿Desea procesar los ["+string(ll_rows)+"] registros?", Question!, YesNo!)

if li_confirmacion<>1 then
	MessageBox("Confirmación","No se han procesado las Solicitudes Autorizadas.", StopSign!)
	return	
end if

//for ll_row=1  to ll_rows
//	/*statementblock*/
//	li_pagado = dw_estadisticas.GetItemNumber(ll_row, 'examen_extrao_titulo_sol_pagado')
//	li_autorizado = dw_estadisticas.GetItemNumber(ll_row, 'examen_extrao_titulo_sol_autorizado')
//	
//next


li_update = dw_estadisticas.Update()
if li_update = 1 then
	commit using gtr_sce;
else
	rollback using gtr_sce;
	MessageBox("Error","No es posible almacenar las Solicitudes Autorizadas", StopSign!)
	return
end if

cb_1.event clicked()

end event

type cbx_cursativas from checkbox within w_rep_extrao_tit
integer x = 3342
integer y = 256
integer width = 494
integer height = 80
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Solo Cursativas"
end type

type uo_coordinacion from uo_dgmu_coordinaciones within w_rep_extrao_tit
integer x = 64
integer y = 380
integer width = 1275
integer taborder = 20
boolean border = false
end type

on uo_coordinacion.destroy
call uo_dgmu_coordinaciones::destroy
end on

type st_3 from statictext within w_rep_extrao_tit
integer x = 2789
integer y = 112
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

type dw_estadisticas from datawindow within w_rep_extrao_tit
integer x = 5
integer y = 580
integer width = 4690
integer height = 2212
integer taborder = 160
string dataobject = "d_extrao_tit_lic"
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

event itemfocuschanged;//long ll_row
//int li_autorizado
//string ls_autorizado
//
//ll_row = row
//
//if ll_row >0 then
//	this.SetTabOrder(9, 25)
//end if
//

end event

event rowfocuschanged;//long ll_row
//int li_autorizado
//string ls_autorizado
//
//ll_row = currentrow
//
//if ll_row >0 then
//	this.SetTabOrder(9, 25)
//	ls_autorizado = 'examen_extrao_titulo_sol_autorizado'
//	li_autorizado = this.GetItemNumber(ll_row, 9)
//
//	//Si la solicitud ha sido autorizada académicamente
//	if li_autorizado =1 then
//		this.SetTabOrder(9, 0)
//	else
//		this.SetTabOrder(9, 25)
//	end if
//end if



end event

event scrollvertical;long ll_numrows , ll_firstrow, ll_lastrow
string ls_firstrow, ls_lastrow

ll_numrows = this.RowCount()
if ll_numrows> 0 then

	ls_firstrow = this.Object.Datawindow.FirstRowOnPage
	if isnumber(ls_firstrow) then
		ll_firstrow = long (ls_firstrow)
	end if
	ls_lastrow = this.Object.Datawindow.LastRowOnPage
	if isnumber(ls_lastrow) then
		ll_lastrow = long (ls_lastrow)
	end if

	this.ScrollToRow(ll_firstrow)

end if

RETURN 0
end event

event itemchanged;long ll_row
int li_autorizado_original, li_autorizado_nuevo
string ls_autorizado

ll_row = row

if ll_row >0 then
	ls_autorizado = 'examen_extrao_titulo_sol_autorizado'
	this.AcceptText()
	if	Dwo.name = ls_autorizado THEN		 
		li_autorizado_original = this.GetItemNumber(ll_row, 9, Primary!, TRUE)
		li_autorizado_nuevo= this.GetItemNumber(ll_row, 9, Primary!, FALSE)
		//Si el valor anterior era Autorizado y se cambió a otro valor
		IF li_autorizado_original= 1 and li_autorizado_nuevo<>1 then
			MessageBox("Cambio no permitido", "No se permite quitar una autorización de una materia previamente autorizada",StopSign!)
			//Rechaza el valor y mantiene el focus
			this.SetItem(ll_row, 9, 1)
			return 1
		END IF
	end if
end if
//Acepta el valor
return 0

end event

type cb_1 from commandbutton within w_rep_extrao_tit
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 2875
integer y = 276
integer width = 265
integer height = 108
integer taborder = 60
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
string ls_anio, ls_nivel, ls_periodo, ls_periodo_elegido, ls_forma_ingreso, ls_fecha_servidor
long ll_row_carrera, ll_cve_carrera, ll_row_coordinacion, ll_cve_coordinacion, ll_rows_coordinaciones
datetime ldttm_fecha_servidor
long ll_rows, ll_row_actual, ll_rows_tit
long ll_row_actual_estatus , ll_row_estatus, ll_rows_estatus, ll_cve_estatus_acta
integer li_nivel_coordinacion
string ls_filtro_vacio = ""

//ll_row_actual_estatus = uoi_estatus_acta.dw_estatus_acta.GetRow()
//ll_rows_estatus = uoi_estatus_acta.dw_estatus_acta.RowCount()
//
//IF ll_rows_estatus> 0 THEN
//	ll_row_estatus = parent.uoi_estatus_acta.dw_estatus_acta.GetRow()
//	ll_cve_estatus_acta = parent.uoi_estatus_acta.dw_estatus_acta.GetItemNumber(ll_row_estatus, 1)
//ELSE
//	MessageBox("Tabla sin estatus", "No existen coordinaciones registradas",StopSign!)
//	return
//END IF


ll_row_actual = parent.uo_coordinacion.dw_coordinaciones.GetRow()
ll_rows_coordinaciones = parent.uo_coordinacion.dw_coordinaciones.RowCount()
IF ii_cve_coordinacion<>9999 THEN
	gb_nivel.visible = false
//	rb_licenciatura.visible = false
//	rb_posgrado.visible = false
	uo_nivel.visible = false
	parent.uo_coordinacion.dw_coordinaciones.SetItem(ll_row_actual,"cve_coordinacion", ii_cve_coordinacion)
ELSE
	gb_nivel.visible = true
//	rb_licenciatura.visible = true
//	rb_posgrado.visible = true
	uo_nivel.visible = true
END IF

IF ll_rows_coordinaciones> 0 THEN
	ll_row_coordinacion = parent.uo_coordinacion.dw_coordinaciones.GetRow()
	ll_cve_coordinacion = parent.uo_coordinacion.dw_coordinaciones.GetItemNumber(ll_row_coordinacion, 1)
ELSE
	MessageBox("Tabla sin coordinaciones", "No existen coordinaciones registradas",StopSign!)
	return
END IF

li_nivel_coordinacion= f_obten_nivel_coordinacion(ll_cve_coordinacion, ls_nivel)

if li_nivel_coordinacion= -1 then
	MessageBox("Error en lectura de coordinacion", "No es posible determinar el nivel de la coordinacion del usuario",StopSign!)
	return	
end if

//IF ii_cve_coordinacion=9999 THEN
//	if rb_licenciatura.checked then
//		ls_nivel = 'L'
//	elseif rb_posgrado.checked then
//		ls_nivel = 'P'
//	end if
//END IF
 
ls_nivel = PARENT.uo_nivel.cve_nivel  

//if ls_nivel = 'L' then
if ls_nivel <> 'P' then	
	dw_estadisticas.dataobject = 	'd_extrao_tit_lic'
	dw_extrao_tit.dataobject = 	'd_extrao_tit_lic'
elseif ls_nivel = 'P' then
	dw_estadisticas.dataobject = 	'd_extrao_tit_pos'	
	dw_extrao_tit.dataobject = 	'd_extrao_tit_pos'
end if


dw_estadisticas.SetTransObject(gtr_sce)
dw_extrao_tit.SetTransObject(gtr_sce)

ls_periodo=uo_periodos.em_per.text
//li_periodo=Integer(uo_periodos.em_per.text)

//    ls_periodo=uo_periodos.iuo_periodo_servicios.f_recupera_descripcion(ii_periodo , "L")
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

ls_anio = uo_periodos.em_ani.text

if not isnumber(ls_anio) then
	MessageBox("Error", "Es necesario escribir un Año", StopSign!)
	return
end if

li_anio= integer(ls_anio)

setpointer(Hourglass!)
//ldttm_fecha_servidor = today() 
//ls_fecha_servidor= string(ldttm_fecha_servidor, "dd/mm/yyyy hh:mm")

ls_fecha_servidor = string(today(), "dd/mm/yyyy hh:mm") 

ls_periodo_elegido =ls_periodo +" "+ ls_anio

dw_estadisticas.object.periodo_anio.text= ls_periodo_elegido
dw_estadisticas.object.st_fecha_hoy.text= ls_fecha_servidor

//dw_extrao_tit.object.periodo_anio.text= ls_periodo_elegido
//dw_extrao_tit.object.periodo_anio.text= ls_periodo_elegido

//MessageBox("Datawindow", dw_estadisticas.dataobject,Information!)

//if rb_gpos_coord.checked then
//	//FILTRA LOS GRUPOS ZZ
//	IF ii_cve_coordinacion <> 9999 THEN 
//		dw_estadisticas.dataobject = "d_estatus_actas_coord_en_linea"
//		dw_estadisticas.SetTransObject(gtr_sce)		
//	ELSE		
//		if	cbx_filtra_zz.checked then
//			dw_estadisticas.dataobject = "d_estatus_actas_coord_en_linea"
//			dw_estadisticas.SetTransObject(gtr_sce)
//		else
//			dw_estadisticas.dataobject = "d_estatus_actas_coord_en_linea_zz"
//			dw_estadisticas.SetTransObject(gtr_sce)
//		end if
//	END IF
//	ll_rows = dw_estadisticas.Retrieve(ll_cve_coordinacion, li_periodo, li_anio, ll_cve_estatus_acta)
//elseif rb_mi_coord.checked then
//	IF ii_cve_coordinacion <> 9999 THEN 
//		dw_estadisticas.dataobject = "d_estatus_actas_coord_detalle_en_linea"
//		dw_estadisticas.SetTransObject(gtr_sce)		
//	ELSE		
//		if	cbx_filtra_zz.checked then
//			dw_estadisticas.dataobject = "d_estatus_actas_coord_detalle_en_linea"
//			dw_estadisticas.SetTransObject(gtr_sce)
//		else
//			dw_estadisticas.dataobject = "d_estatus_actas_coord_detalle_en_lin_zz"
//			dw_estadisticas.SetTransObject(gtr_sce)
//		end if
//	END IF
//	ll_rows = dw_estadisticas.Retrieve(ll_cve_coordinacion, li_periodo, li_anio, ll_cve_estatus_acta)
//end if
	
ll_rows = dw_estadisticas.Retrieve(ll_cve_coordinacion, li_periodo, li_anio)
ll_rows_tit = dw_extrao_tit.Retrieve(ll_cve_coordinacion, li_periodo, li_anio)


if cbx_cursativas.checked then
	//if ls_nivel = 'L' then
	if ls_nivel <> 'P' then
		dw_estadisticas.SetFilter(' mat_prerrequisito_cursativa = 1 ')
	elseif ls_nivel = 'P' then
		dw_estadisticas.SetFilter(' mat_prerreq_pos_cursativa = 1 ')
	end if
else
	dw_estadisticas.SetFilter(ls_filtro_vacio)
end if

dw_estadisticas.Filter()

if ll_rows > 0 then
	dw_estadisticas.ScrollToRow(1)
end if

dw_estadisticas.object.periodo_anio.text= ls_periodo_elegido
dw_estadisticas.object.st_fecha_hoy.text= ls_fecha_servidor


//dw_extrao_tit.object.periodo_anio.text= ls_periodo_elegido
//dw_extrao_tit.object.st_fecha_hoy.text= ls_fecha_servidor




end event

event constructor;TabOrder = 4
end event

type em_anio from editmask within w_rep_extrao_tit
event constructor pbm_constructor
event modified pbm_enmodified
boolean visible = false
integer x = 96
integer y = 656
integer width = 219
integer height = 80
integer taborder = 80
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

int li_periodo, li_anio, li_retorno, li_coord_usuario


//periodo_actual_activacion(periodo,anio,gtr_sce)


li_retorno = f_obten_periodo(li_periodo, li_anio, 12)

if li_retorno = -1 then
	MessageBox("Error en calendario", "No es posible leer el periodo de baja",StopSign!)
	if li_coord_usuario <> 9999 then
		close(parent)
	end if
end if
gi_anio=li_anio
gi_periodo=li_periodo


// 0 = Primavera
// 1 = Verano
// 2 = Otoño

//CHOOSE CASE li_periodo
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
this.text = string(li_anio)
ii_periodo = li_periodo
ii_anio = li_anio



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

type dw_1x from datawindow within w_rep_extrao_tit
boolean visible = false
integer x = 3767
integer y = 624
integer width = 1038
integer height = 564
integer taborder = 130
string dataobject = "dw_repo_mad_18_gx"
boolean livescroll = true
end type

type gb_8 from groupbox within w_rep_extrao_tit
integer x = 2843
integer y = 232
integer width = 329
integer height = 176
integer taborder = 170
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_11 from groupbox within w_rep_extrao_tit
boolean visible = false
integer x = 50
integer y = 596
integer width = 315
integer height = 160
integer taborder = 90
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Año"
borderstyle borderstyle = styleraised!
end type

type gb_20 from groupbox within w_rep_extrao_tit
integer x = 37
integer y = 60
integer width = 1303
integer height = 264
integer taborder = 110
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Periodo"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_rep_extrao_tit
integer x = 46
integer y = 328
integer width = 1294
integer height = 224
integer taborder = 120
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

type gb_nivel from groupbox within w_rep_extrao_tit
integer x = 1870
integer y = 72
integer width = 622
integer height = 412
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Nivel"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_rep_extrao_tit
integer width = 4229
integer height = 592
integer taborder = 70
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Criterios de Busqueda"
borderstyle borderstyle = styleraised!
end type

type uo_nivel from uo_nivel_rbutton within w_rep_extrao_tit
integer x = 1906
integer y = 140
integer width = 549
integer height = 320
integer taborder = 20
boolean bringtotop = true
end type

on uo_nivel.destroy
call uo_nivel_rbutton::destroy
end on

