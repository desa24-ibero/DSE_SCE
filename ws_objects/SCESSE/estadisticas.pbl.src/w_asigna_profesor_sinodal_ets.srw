$PBExportHeader$w_asigna_profesor_sinodal_ets.srw
forward
global type w_asigna_profesor_sinodal_ets from w_master
end type
type uo_1 from uo_per_ani within w_asigna_profesor_sinodal_ets
end type
type cb_actualizar from commandbutton within w_asigna_profesor_sinodal_ets
end type
type mc_calendario from monthcalendar within w_asigna_profesor_sinodal_ets
end type
type st_5 from statictext within w_asigna_profesor_sinodal_ets
end type
type st_1 from statictext within w_asigna_profesor_sinodal_ets
end type
type st_4 from statictext within w_asigna_profesor_sinodal_ets
end type
type uoi_coordinaciones from uo_coordinaciones within w_asigna_profesor_sinodal_ets
end type
type rb_posgrado from radiobutton within w_asigna_profesor_sinodal_ets
end type
type rb_licenciatura from radiobutton within w_asigna_profesor_sinodal_ets
end type
type em_no_acta from editmask within w_asigna_profesor_sinodal_ets
end type
type st_2 from statictext within w_asigna_profesor_sinodal_ets
end type
type uo_profesor from uo_nombre_profesor within w_asigna_profesor_sinodal_ets
end type
type uo_grupo from uo_grupos_filtro within w_asigna_profesor_sinodal_ets
end type
type rb_5 from radiobutton within w_asigna_profesor_sinodal_ets
end type
type rb_4 from radiobutton within w_asigna_profesor_sinodal_ets
end type
type rb_3 from radiobutton within w_asigna_profesor_sinodal_ets
end type
type st_3 from statictext within w_asigna_profesor_sinodal_ets
end type
type dw_estadisticas from u_dw within w_asigna_profesor_sinodal_ets
end type
type cb_1 from commandbutton within w_asigna_profesor_sinodal_ets
end type
type em_anio from editmask within w_asigna_profesor_sinodal_ets
end type
type rb_otonio from radiobutton within w_asigna_profesor_sinodal_ets
end type
type rb_verano from radiobutton within w_asigna_profesor_sinodal_ets
end type
type rb_primavera from radiobutton within w_asigna_profesor_sinodal_ets
end type
type dw_1x from datawindow within w_asigna_profesor_sinodal_ets
end type
type gb_8 from groupbox within w_asigna_profesor_sinodal_ets
end type
type gb_11 from groupbox within w_asigna_profesor_sinodal_ets
end type
type gb_20 from groupbox within w_asigna_profesor_sinodal_ets
end type
type gb_1 from groupbox within w_asigna_profesor_sinodal_ets
end type
end forward

global type w_asigna_profesor_sinodal_ets from w_master
boolean visible = false
integer width = 6894
integer height = 3504
string title = "Asignación de Sinodales de Extraordinario y a Título de Suficiencia"
string menuname = "m_estad_alum_mat"
long backcolor = 67108864
boolean ib_disableclosequery = true
uo_1 uo_1
cb_actualizar cb_actualizar
mc_calendario mc_calendario
st_5 st_5
st_1 st_1
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
global w_asigna_profesor_sinodal_ets w_asigna_profesor_sinodal_ets

type variables
int periodo_x

integer ii_periodo, ii_anio

integer ii_cupo, ii_coord_usuario, ii_cve_coordinacion

string is_gpo_asimilado
Transaction itr_parametros_iniciales
n_tr itr_seguridad, itr_original

//nombre de la conexion en parametros_conexion
CONSTANT	string	is_controlescolar_cnx	=	"controlescolar_inscripcion"
CONSTANT	string	is_tesoreria_cnx			=	"controlescolar_inscripcion_tesoreria"
CONSTANT	string	is_becas_cnx				=	"controlescolar_inscripcion_becas"

datetime idttm_fecha_inicial, idttm_fecha_final   

//LONG il_cve_coordinacion


end variables

on w_asigna_profesor_sinodal_ets.create
int iCurrent
call super::create
if this.MenuName = "m_estad_alum_mat" then this.MenuID = create m_estad_alum_mat
this.uo_1=create uo_1
this.cb_actualizar=create cb_actualizar
this.mc_calendario=create mc_calendario
this.st_5=create st_5
this.st_1=create st_1
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
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.cb_actualizar
this.Control[iCurrent+3]=this.mc_calendario
this.Control[iCurrent+4]=this.st_5
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.uoi_coordinaciones
this.Control[iCurrent+8]=this.rb_posgrado
this.Control[iCurrent+9]=this.rb_licenciatura
this.Control[iCurrent+10]=this.em_no_acta
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.uo_profesor
this.Control[iCurrent+13]=this.uo_grupo
this.Control[iCurrent+14]=this.rb_5
this.Control[iCurrent+15]=this.rb_4
this.Control[iCurrent+16]=this.rb_3
this.Control[iCurrent+17]=this.st_3
this.Control[iCurrent+18]=this.dw_estadisticas
this.Control[iCurrent+19]=this.cb_1
this.Control[iCurrent+20]=this.em_anio
this.Control[iCurrent+21]=this.rb_otonio
this.Control[iCurrent+22]=this.rb_verano
this.Control[iCurrent+23]=this.rb_primavera
this.Control[iCurrent+24]=this.dw_1x
this.Control[iCurrent+25]=this.gb_8
this.Control[iCurrent+26]=this.gb_11
this.Control[iCurrent+27]=this.gb_20
this.Control[iCurrent+28]=this.gb_1
end on

on w_asigna_profesor_sinodal_ets.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.cb_actualizar)
destroy(this.mc_calendario)
destroy(this.st_5)
destroy(this.st_1)
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

event open;
this.x=1
this.y=1

long ll_row, ll_row_actual, ll_rows_coordinaciones, ll_row_coordinacion, ll_cve_coordinacion
int li_retorno, li_periodo, li_anio, li_coord_usuario, li_chk, li_num_items, li_item_actual
int li_evento_baja_total = 11, li_proceso_en_captura = 4, li_proceso_transferidas = 7, li_evento_ets= 12
datetime ldttm_fecha_inicial, ldttm_fecha_final
date ldt_fecha_inicial, ldt_fecha_final, ldt_fecha_actual

li_retorno = f_obten_periodo_fechas(li_periodo, li_anio, ldttm_fecha_inicial, ldttm_fecha_final, li_evento_ets)

if li_retorno = -1 then
	MessageBox("Error en calendario", "No es posible leer el periodo de Extraordinario y a Título de Suficiencia",StopSign!)
	if li_coord_usuario <> 9999 then
		close(this	)
	end if
end if

idttm_fecha_inicial = ldttm_fecha_inicial
idttm_fecha_final = ldttm_fecha_final

ldt_fecha_inicial = date(ldttm_fecha_inicial)
ldt_fecha_final = date(ldttm_fecha_final)

integer li_return

ldt_fecha_actual= ldt_fecha_inicial

//Pone en Bold a todas las fechas del rango correspondente
do while ldt_fecha_actual <= ldt_fecha_final
	li_return = mc_calendario.SetBoldDate (ldt_fecha_actual, true )
	ldt_fecha_actual= RelativeDate(ldt_fecha_actual,  1)
loop






//li_proceso_en_captura   = f_obten_estatus_proceso_actas(4, li_periodo,li_anio, gtr_sce)
//li_proceso_transferidas = f_obten_estatus_proceso_actas(7, li_periodo,li_anio, gtr_sce)
//
////Cambio por Actas en Línea
////1)->
////Se conecta a la seguridad para mantener separada una transacción para la seguridad
//if not (conecta_bd_n_tr(itr_seguridad,"SCE",gs_usuario,gs_password) = 1) then
//	messageBox('Error en seguridad', 'No es posible validar la seguridad del usuario',Stopsign!)
//end if
//
//itr_parametros_iniciales = gtr_sce
//if li_proceso_transferidas= 0 then
//	li_chk	=	f_conecta_pas_parametros_act_bd(itr_parametros_iniciales,gtr_sce,is_controlescolar_cnx,gs_usuario,gs_password,0)
//	if li_chk <> 1 then return
//end if
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
////Cambio por Actas en Línea
////1)<-


//Habilita la seguridad para la ventana actual

/**/
//gnv_app.inv_security.of_SetSecurity(this)


uoi_coordinaciones.backcolor = this.backcolor
uoi_coordinaciones.enabled = true

uo_grupo.rb_editar.visible = false
uo_grupo.rb_insertar.visible = false

//dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
//dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")

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

//2011/03/04
//w_principal.ChangeMenu(m_grupos_impartidos_salir)


ll_row_actual = this.uoi_coordinaciones.dw_coordinaciones.GetRow()

ll_rows_coordinaciones = this.uoi_coordinaciones.dw_coordinaciones.RowCount()

this.uoi_coordinaciones.dw_coordinaciones.SetItem(ll_row_actual,"cve_coordinacion", ii_cve_coordinacion)


uoi_coordinaciones.TRIGGEREVENT("carga") 
ll_rows_coordinaciones = this.uoi_coordinaciones.dw_coordinaciones.RowCount()

IF ll_rows_coordinaciones> 0 THEN
	ll_row_coordinacion = this.uoi_coordinaciones.dw_coordinaciones.GetRow()
	ll_cve_coordinacion = this.uoi_coordinaciones.dw_coordinaciones.GetItemNumber(ll_row_coordinacion, 1)
ELSE
	MessageBox("Tabla sin coordinaciones", "No existen coordinaciones registradas",StopSign!)
	return
END IF

IF ii_cve_coordinacion <> 9999 THEN 
	this.uoi_coordinaciones.enabled = false
ELSE
	this.uoi_coordinaciones.enabled = true
END IF

dw_estadisticas.SetTransObject(gtr_sce)
dw_estadisticas.SetRowFocusIndicator(Hand!)

//dw_estadisticas.of_SetDropDownCalendar ( true )
//dw_estadisticas.iuo_calendar.of_Register("grupo_sinodal_ets_fecha_examen", &
//  dw_estadisticas.iuo_calendar.DDLB)



//Cambio por Actas en Línea
//2)<-
end event

event close;////Cambio por Actas en Línea
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
////Cambio por Actas en Línea
////3)<-

end event

type uo_1 from uo_per_ani within w_asigna_profesor_sinodal_ets
integer x = 2843
integer y = 44
integer taborder = 30
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type cb_actualizar from commandbutton within w_asigna_profesor_sinodal_ets
integer x = 4229
integer y = 1868
integer width = 439
integer height = 108
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar"
end type

event clicked;integer li_update, li_confirmacion
long ll_row, ll_rows
datetime ldttm_grupo_sinodal_ets_fecha_examen, ldttm_fecha_nula, ldttm_fecha_final
date ldt_fecha_final
time ltm_hora_final
SetNull(ldttm_fecha_nula)
li_confirmacion = 	MessageBox("Confirmación","¿Desea actualizar la información de Sinodales?.",Question!, yesno!)


dw_estadisticas.AcceptText()

if li_confirmacion = 1 then

	ll_rows = dw_estadisticas.RowCount()

	for ll_row=1 to ll_rows
		ldttm_grupo_sinodal_ets_fecha_examen = dw_estadisticas.GetItemDatetime(ll_row, "grupo_sinodal_ets_fecha_examen")
		if not isnull(ldttm_grupo_sinodal_ets_fecha_examen) then 
		//Valida que el rango de fechas sea correcto
		   ldt_fecha_final = date(idttm_fecha_final)
		//Se comento para que los minutos no den problemas
		// ldt_fecha_final =RelativeDate(ldt_fecha_final,1)
		//Se Suman los minutos de la fecha final
			ltm_hora_final = Time('23:29')
			ldttm_fecha_final =DateTime(ldt_fecha_final,ltm_hora_final)
			if not(idttm_fecha_inicial<= ldttm_grupo_sinodal_ets_fecha_examen  and  ldttm_grupo_sinodal_ets_fecha_examen <= ldttm_fecha_final) then
				MessageBox("Error de Fecha","La fecha no se encuentra en el rango de las permitidas del~n"+&
				 "["+string(idttm_fecha_inicial,"dd/mm/yyyy")+" al "+string(idttm_fecha_final,"dd/mm/yyyy")+"].",StopSign!)
				dw_estadisticas.ScrollToRow(ll_row)				 
				return				
			end if			
		end if
	next

	li_update =  dw_estadisticas.Update()

	if li_update= 1 then
		COMMIT USING gtr_sce;
		MessageBox("Actualización Exitosa","Se ha actualizado la información.",Information!)
	else
		ROLLBACK USING gtr_sce;
		MessageBox("Error de Actualización","No es posible actualizar la información.",StopSign!)
	end if
	
end if



end event

event constructor;TabOrder = 4
end event

type mc_calendario from monthcalendar within w_asigna_profesor_sinodal_ets
integer x = 3945
integer y = 660
integer width = 1111
integer height = 760
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long titletextcolor = 134217742
long trailingtextcolor = 134217745
long monthbackcolor = 1073741824
long titlebackcolor = 134217741
weekday firstdayofweek = sunday!
integer maxselectcount = 31
integer scrollrate = 1
boolean todaysection = true
boolean todaycircle = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_asigna_profesor_sinodal_ets
integer x = 471
integer y = 556
integer width = 2999
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Para asignar al Profesor Seleccionado en algún grupo, de Doble Click en la clave del Grupo en Cuestión"
boolean focusrectangle = false
end type

type st_1 from statictext within w_asigna_profesor_sinodal_ets
integer x = 658
integer y = 220
integer width = 1586
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Búsqueda de Profesor por Número de Empleado y Nombre"
boolean focusrectangle = false
end type

type st_4 from statictext within w_asigna_profesor_sinodal_ets
integer x = 101
integer y = 76
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

type uoi_coordinaciones from uo_coordinaciones within w_asigna_profesor_sinodal_ets
integer x = 594
integer y = 52
integer taborder = 90
boolean border = false
end type

on uoi_coordinaciones.destroy
call uo_coordinaciones::destroy
end on

event carga;call super::carga;uoi_coordinaciones.dw_coordinaciones.SetItem(1,"cve_coordinacion", PARENT.ii_cve_coordinacion)



end event

type rb_posgrado from radiobutton within w_asigna_profesor_sinodal_ets
boolean visible = false
integer x = 238
integer y = 412
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

type rb_licenciatura from radiobutton within w_asigna_profesor_sinodal_ets
boolean visible = false
integer x = 238
integer y = 308
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

type em_no_acta from editmask within w_asigna_profesor_sinodal_ets
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

type st_2 from statictext within w_asigna_profesor_sinodal_ets
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

type uo_profesor from uo_nombre_profesor within w_asigna_profesor_sinodal_ets
integer x = 73
integer y = 304
integer taborder = 30
boolean enabled = true
end type

on uo_profesor.destroy
call uo_nombre_profesor::destroy
end on

type uo_grupo from uo_grupos_filtro within w_asigna_profesor_sinodal_ets
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

type rb_5 from radiobutton within w_asigna_profesor_sinodal_ets
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

type rb_4 from radiobutton within w_asigna_profesor_sinodal_ets
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

type rb_3 from radiobutton within w_asigna_profesor_sinodal_ets
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

type st_3 from statictext within w_asigna_profesor_sinodal_ets
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

type dw_estadisticas from u_dw within w_asigna_profesor_sinodal_ets
integer x = 73
integer y = 652
integer width = 3794
integer height = 2536
integer taborder = 80
string dataobject = "d_grupo_sinodal_ets"
boolean maxbox = true
boolean hscrollbar = true
boolean resizable = true
boolean ib_rmbmenu = false
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

event doubleclicked;long ll_cve_profesor, ll_cve_mat
boolean lb_profesor_valido
integer li_confirmacion
string ls_materia

if this.rowcount()<=0 then
	return
end if 

ll_cve_profesor = uo_profesor.of_obten_cve_profesor()

//Solo si es una clave de profesor válida
if not isnull(ll_cve_profesor) and ll_cve_profesor>0 then
	lb_profesor_valido = f_profesor_valido(ll_cve_profesor)

	if not lb_profesor_valido then
		MessageBox("Profesor Inválido","El profesor elegido no se encuentra activo en el sistema.",StopSign!)
		return
	end if


	ll_cve_mat = this.GetitemNumber(row,"grupo_sinodal_ets_cve_mat")
	ls_materia= this.GetitemString(row,"materias_materia")

	li_confirmacion = MessageBox("Confirmación", &
	 "¿Desea asignar al profesor["+string(ll_cve_profesor)+"] a la materia ["+string(ll_cve_mat)+"-"+ls_materia+"]",Question!, YesNO!)
 
	if li_confirmacion<>1 then
		MessageBox("Asignación Cancelada","No se ha asignado a ningún profesor.",StopSign!)
		return	
	end if
 
	this.SetItem(row,"grupo_sinodal_ets_cve_profesor", ll_cve_profesor)
	
end if

end event

event dragenter;call super::dragenter;//MessageBox("objeto", String(source))
end event

type cb_1 from commandbutton within w_asigna_profesor_sinodal_ets
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 2231
integer y = 68
integer width = 439
integer height = 108
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
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

ls_periodo=uo_1.em_per.text
li_periodo=uo_1.iuo_periodo_servicios.f_recupera_id(ls_periodo, "L")

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

if rb_licenciatura.checked then
	ls_nivel = "L"
	ls_desc_nivel = "Licenciatura"
elseif rb_posgrado.checked then
	ls_nivel = "P"
	ls_desc_nivel = "Posgrado"
else
	MessageBox("Error", "Es necesario seleccionar un Nivel", StopSign!)
	return
end if


ls_anio = uo_1.em_ani.text //em_anio.text

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

//dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
//
//dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")

//Actas por Coordinacion
//if rb_departamento.checked then
	MessageBox("Generando Reporte", "Por Coordinación",Information!)
	ll_rows = dw_estadisticas.Retrieve(ll_cve_coordinacion, li_periodo, li_anio)
//end if

//dw_estadisticas.Modify("DataWindow.Print.Preview = 'Yes'")
//dw_estadisticas.Modify("DataWindow.Print.Preview.Zoom = '90'")
//


	







end event

event constructor;TabOrder = 4
end event

type em_anio from editmask within w_asigna_profesor_sinodal_ets
event constructor pbm_constructor
event modified pbm_enmodified
boolean visible = false
integer x = 3945
integer y = 128
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

type rb_otonio from radiobutton within w_asigna_profesor_sinodal_ets
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 3387
integer y = 292
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean enabled = false
string text = "Otoño"
end type

event clicked;periodo_x = 2
end event

type rb_verano from radiobutton within w_asigna_profesor_sinodal_ets
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 3387
integer y = 212
integer width = 270
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean enabled = false
string text = "Verano"
end type

event clicked;periodo_x = 1
end event

type rb_primavera from radiobutton within w_asigna_profesor_sinodal_ets
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 3387
integer y = 136
integer width = 343
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean enabled = false
string text = "Primavera"
end type

event clicked;periodo_x = 0
end event

type dw_1x from datawindow within w_asigna_profesor_sinodal_ets
boolean visible = false
integer x = 3767
integer y = 624
integer width = 1038
integer height = 564
integer taborder = 70
string dataobject = "dw_repo_mad_18_gx"
boolean livescroll = true
end type

type gb_8 from groupbox within w_asigna_profesor_sinodal_ets
integer x = 2190
integer y = 24
integer width = 526
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

type gb_11 from groupbox within w_asigna_profesor_sinodal_ets
boolean visible = false
integer x = 3899
integer y = 68
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

type gb_20 from groupbox within w_asigna_profesor_sinodal_ets
boolean visible = false
integer x = 3355
integer y = 72
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

type gb_1 from groupbox within w_asigna_profesor_sinodal_ets
boolean visible = false
integer x = 183
integer y = 248
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

