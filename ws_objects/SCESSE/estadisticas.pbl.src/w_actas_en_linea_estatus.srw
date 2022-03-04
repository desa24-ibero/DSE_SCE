$PBExportHeader$w_actas_en_linea_estatus.srw
forward
global type w_actas_en_linea_estatus from window
end type
type uo_periodos from uo_per_ani within w_actas_en_linea_estatus
end type
type rb_extrao_tit from radiobutton within w_actas_en_linea_estatus
end type
type rb_ordinario from radiobutton within w_actas_en_linea_estatus
end type
type gb_3 from groupbox within w_actas_en_linea_estatus
end type
type cbx_filtra_zz from checkbox within w_actas_en_linea_estatus
end type
type rb_mi_coord from radiobutton within w_actas_en_linea_estatus
end type
type rb_gpos_coord from radiobutton within w_actas_en_linea_estatus
end type
type uo_coordinacion from uo_dgmu_coordinaciones within w_actas_en_linea_estatus
end type
type gb_coordinacion from groupbox within w_actas_en_linea_estatus
end type
type st_3 from statictext within w_actas_en_linea_estatus
end type
type dw_estadisticas from datawindow within w_actas_en_linea_estatus
end type
type cb_1 from commandbutton within w_actas_en_linea_estatus
end type
type em_anio from editmask within w_actas_en_linea_estatus
end type
type rb_otonio from radiobutton within w_actas_en_linea_estatus
end type
type rb_verano from radiobutton within w_actas_en_linea_estatus
end type
type rb_primavera from radiobutton within w_actas_en_linea_estatus
end type
type dw_1x from datawindow within w_actas_en_linea_estatus
end type
type gb_8 from groupbox within w_actas_en_linea_estatus
end type
type gb_11 from groupbox within w_actas_en_linea_estatus
end type
type gb_20 from groupbox within w_actas_en_linea_estatus
end type
type gb_2 from groupbox within w_actas_en_linea_estatus
end type
type gb_4 from groupbox within w_actas_en_linea_estatus
end type
type gb_1 from groupbox within w_actas_en_linea_estatus
end type
type uoi_estatus_acta from uo_estatus_acta within w_actas_en_linea_estatus
end type
end forward

global type w_actas_en_linea_estatus from window
integer width = 5051
integer height = 2532
boolean titlebar = true
string title = "Actas por Coordinación"
string menuname = "m_estad_alum_mat"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
uo_periodos uo_periodos
rb_extrao_tit rb_extrao_tit
rb_ordinario rb_ordinario
gb_3 gb_3
cbx_filtra_zz cbx_filtra_zz
rb_mi_coord rb_mi_coord
rb_gpos_coord rb_gpos_coord
uo_coordinacion uo_coordinacion
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
gb_2 gb_2
gb_4 gb_4
gb_1 gb_1
uoi_estatus_acta uoi_estatus_acta
end type
global w_actas_en_linea_estatus w_actas_en_linea_estatus

type variables
int periodo_x

integer ii_periodo, ii_anio


boolean ib_borrando= false
long il_cve_asimilada
integer ii_cupo, ii_coord_usuario, ii_cve_coordinacion
string is_gpo_asimilado
Transaction itr_parametros_iniciales
n_tr itr_seguridad, itr_original, itr_syb, itr_sql


//nombre de la conexion en parametros_conexion
CONSTANT	string	is_controlescolar_cnx	=	"controlescolar_inscripcion"
CONSTANT	string	is_tesoreria_cnx			=	"controlescolar_inscripcion_tesoreria"
CONSTANT	string	is_becas_cnx				=	"controlescolar_inscripcion_becas"

uo_periodo_servicios iuo_periodo_servicios

n_tr itr_ejecucion

STRING is_dbms

INTEGER ii_proceso_transferidas, ii_proceso_transferidas_ext

end variables

forward prototypes
public function integer wf_conecta_bd ()
end prototypes

public function integer wf_conecta_bd ();
INTEGER li_proceso_transferidas
INTEGER  li_periodo,li_anio, li_chk, li_retorno, li_evento_baja_total = 11

IF rb_ordinario.CHECKED THEN 
	li_proceso_transferidas = f_obten_estatus_proceso_actas(7, ii_periodo,ii_anio, itr_syb)
ELSE
	li_proceso_transferidas = f_obten_estatus_proceso_actas(107, ii_periodo,ii_anio, itr_syb)
END IF

IF li_proceso_transferidas = 0 THEN 
	gtr_sce =  itr_sql 
ELSE
	gtr_sce =  itr_syb 
END IF

f_obten_titulo(w_principal)

RETURN 0

//IF li_proceso_transferidas = 0 AND gtr_sce.DBMS = 'OLE DB' THEN 
//	RETURN 0
////ELSEIF li_proceso_transferidas <> 0 AND gtr_sce.DBMS <> 'OLE DB'	THEN 
////	RETURN 0
//END IF 
//	
//DISCONNECT USING gtr_sce; 
//IF ISVALID(itr_ejecucion) THEN 
//	DISCONNECT USING itr_ejecucion;
//END IF		
//
//gtr_sce = itr_syb
//
//
//////IF ISVALID(itr_original) THEN 
//////	DISCONNECT USING itr_original;
//////END IF		
////
////// Se conecta a la BD original
////if not (conecta_bd_n_tr(itr_original,gs_sce,gs_usuario,gs_password) = 1) then
////	messageBox('Error en conectividad', 'No es posible reconectarse al origen. Favor de reiniciar la aplicación',Stopsign!)
////	HALT CLOSE		
////end if
//
////
//////Se asigna la transacción original
////gtr_sce = itr_original 
//
////itr_parametros_iniciales = gtr_sce
//
//itr_ejecucion = CREATE TRANSACTION
//
//if li_proceso_transferidas= 0 then
//	//li_chk	=	f_conecta_pas_parametros_act_bd(itr_parametros_iniciales,gtr_sce,is_controlescolar_cnx,gs_usuario,gs_password,0)
//	IF rb_ordinario.CHECKED THEN 
//		itr_ejecucion = itr_syb
//	ELSE
//		li_chk	=	f_conecta_pas_parametros_bd(itr_syb,itr_ejecucion,11,gs_usuario,gs_password)	
//	END IF
//	if li_chk <> 1 then 
//		MESSAGEBOX("ERROR", "Error al conectarse a la base de datos.") 
//		return 0
//	ELSE
//		DISCONNECT USING gtr_sce;
//		gtr_sce = itr_ejecucion 
//	END IF		
//end if
//
//f_obten_titulo(w_principal)
//RETURN 1
//
//
//
//
end function

on w_actas_en_linea_estatus.create
if this.MenuName = "m_estad_alum_mat" then this.MenuID = create m_estad_alum_mat
this.uo_periodos=create uo_periodos
this.rb_extrao_tit=create rb_extrao_tit
this.rb_ordinario=create rb_ordinario
this.gb_3=create gb_3
this.cbx_filtra_zz=create cbx_filtra_zz
this.rb_mi_coord=create rb_mi_coord
this.rb_gpos_coord=create rb_gpos_coord
this.uo_coordinacion=create uo_coordinacion
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
this.gb_2=create gb_2
this.gb_4=create gb_4
this.gb_1=create gb_1
this.uoi_estatus_acta=create uoi_estatus_acta
this.Control[]={this.uo_periodos,&
this.rb_extrao_tit,&
this.rb_ordinario,&
this.gb_3,&
this.cbx_filtra_zz,&
this.rb_mi_coord,&
this.rb_gpos_coord,&
this.uo_coordinacion,&
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
this.gb_2,&
this.gb_4,&
this.gb_1,&
this.uoi_estatus_acta}
end on

on w_actas_en_linea_estatus.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_periodos)
destroy(this.rb_extrao_tit)
destroy(this.rb_ordinario)
destroy(this.gb_3)
destroy(this.cbx_filtra_zz)
destroy(this.rb_mi_coord)
destroy(this.rb_gpos_coord)
destroy(this.uo_coordinacion)
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
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.uoi_estatus_acta)
end on

event open;this.x=1
this.y=1
rb_gpos_coord.event clicked()


long ll_row, ll_row_actual, ll_rows_coordinaciones, ll_row_coordinacion, ll_cve_coordinacion
int li_retorno, li_periodo, li_anio, li_coord_usuario, li_chk, li_num_items, li_item_actual
int li_evento_baja_total = 11, li_proceso_en_captura = 4, li_proceso_transferidas = 7


li_retorno = f_obten_periodo(li_periodo, li_anio, li_evento_baja_total)
 ii_periodo = li_periodo
 ii_anio = li_anio


if li_retorno = -1 then
	MessageBox("Error en calendario", "No es posible leer el periodo de baja total",StopSign!)
	if li_coord_usuario <> 9999 then
		close(this	)
	end if
end if

li_proceso_en_captura   = f_obten_estatus_proceso_actas(4, li_periodo,li_anio, gtr_sce)
li_proceso_transferidas = f_obten_estatus_proceso_actas(7, li_periodo,li_anio, gtr_sce)

ii_proceso_transferidas = li_proceso_transferidas 
ii_proceso_transferidas_ext = f_obten_estatus_proceso_actas(107, li_periodo,li_anio, gtr_sce)

conecta_bd_n_tr(itr_syb,gs_sce,gs_usuario,gs_password)
f_conecta_pas_parametros_bd(gtr_sce,itr_sql,11,gs_usuario,gs_password)	
is_dbms = 'SYB'

//Cambio por Ajustes en Línea
//1)->
//Se conecta a la seguridad para mantener separada una transacción para la seguridad
if not (conecta_bd_n_tr(itr_seguridad,gs_sce,gs_usuario,gs_password) = 1) then
	messageBox('Error en seguridad', 'No es posible validar la seguridad del usuario',Stopsign!)
end if

itr_parametros_iniciales = gtr_sce

itr_ejecucion = CREATE TRANSACTION

if li_proceso_transferidas= 0 then
	//li_chk	=	f_conecta_pas_parametros_act_bd(itr_parametros_iniciales,gtr_sce,is_controlescolar_cnx,gs_usuario,gs_password,0)
	li_chk	=	f_conecta_pas_parametros_bd(itr_parametros_iniciales,itr_ejecucion,11,gs_usuario,gs_password)	
	if li_chk <> 1 then 
		return
	ELSE
		DISCONNECT USING gtr_sce;
		gtr_sce = itr_ejecucion 
		is_dbms = 'SQL'
	END IF		
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

//Cambio por Ajustes en Línea
//1)<-

//Habilita la seguridad para la ventana actual

/**/
//gnv_app.inv_security.of_SetSecurity(this)

gi_anio=li_anio
gi_periodo=li_periodo

	//Modif. Roberto Novoa R.  May/2016 - Funcionalidad de periodos múltiples
	iuo_periodo_servicios = CREATE uo_periodo_servicios
	iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)


ii_cve_coordinacion = f_obten_coord_de_usuario(gs_usuario)

if ii_cve_coordinacion = 9999 then
//	cbx_descuenta_sdu_se.enabled = true

elseif ii_cve_coordinacion = -1 then
	MessageBox("Error en lectura de coordinacion", "No es posible determinar la coordinacion del usuario",StopSign!)
	close(this)
else	
//	cbx_descuenta_sdu_se.enabled = false
end if





//Cambio por Ajustes en Línea
//2)->
//Se vuelve a poner porque en el constructor de los datawindows ya previamente se había ejecutado apuntando a sybase


dw_estadisticas.SetTransObject(gtr_sce)

f_obten_titulo(w_principal)

w_principal.ChangeMenu(m_grupos_impartidos_salir)


ll_row_actual = this.uo_coordinacion.dw_coordinaciones.GetRow()

ll_rows_coordinaciones = this.uo_coordinacion.dw_coordinaciones.RowCount()

this.uo_coordinacion.dw_coordinaciones.SetItem(ll_row_actual,"cve_coordinacion", ii_cve_coordinacion)



IF ll_rows_coordinaciones> 0 THEN
	ll_row_coordinacion = this.uo_coordinacion.dw_coordinaciones.GetRow()
	ll_cve_coordinacion = this.uo_coordinacion.dw_coordinaciones.GetItemNumber(ll_row_coordinacion, 1)
ELSE
	MessageBox("Tabla sin coordinaciones", "No existen coordinaciones registradas",StopSign!)
	return
END IF

IF ii_cve_coordinacion <> 9999 THEN 
	this.uo_coordinacion.enabled = false
	cbx_filtra_zz.visible = false
ELSE
	this.uo_coordinacion.enabled = true
	cbx_filtra_zz.visible = true
END IF


//Cambio por Ajustes en Línea
//2)<-
rb_gpos_coord.event clicked()


end event

event close;//Cambio por Ajustes en Línea
//3)->
//Se conecta a la base de datos original para reasignar a la transacción principal
if not (conecta_bd_n_tr(itr_original,gs_sce,gs_usuario,gs_password) = 1) then
	messageBox('Error en conectividad', 'No es posible reconectarse al origen. Favor de reiniciar la aplicación',Stopsign!)
	HALT CLOSE		
end if

//Se asigna la transacción original
gtr_sce = itr_original 

DISCONNECT USING itr_syb; 
DISCONNECT USING itr_sql; 

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
//Cambio por Ajustes en Línea
//3)<-


end event

type uo_periodos from uo_per_ani within w_actas_en_linea_estatus
integer x = 37
integer y = 224
integer taborder = 100
boolean enabled = true
end type

on uo_periodos.destroy
call uo_per_ani::destroy
end on

type rb_extrao_tit from radiobutton within w_actas_en_linea_estatus
integer x = 2464
integer y = 476
integer width = 914
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12632256
string text = "Extraordinario y a Título de Suf."
end type

event clicked;wf_conecta_bd()
end event

type rb_ordinario from radiobutton within w_actas_en_linea_estatus
integer x = 2464
integer y = 372
integer width = 507
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12632256
string text = "Ordinario"
boolean checked = true
end type

event clicked;wf_conecta_bd()
end event

type gb_3 from groupbox within w_actas_en_linea_estatus
integer x = 2395
integer y = 300
integer width = 1015
integer height = 308
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Tipo de Examen"
borderstyle borderstyle = styleraised!
end type

type cbx_filtra_zz from checkbox within w_actas_en_linea_estatus
integer x = 3776
integer y = 452
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Filtra ZZ"
boolean checked = true
end type

type rb_mi_coord from radiobutton within w_actas_en_linea_estatus
integer x = 1714
integer y = 476
integer width = 507
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12632256
string text = "Actas Detallado"
end type

event clicked;dw_estadisticas.dataobject = "d_estatus_actas_coord_detalle_en_linea"
dw_estadisticas.SetTransObject(gtr_sce)


end event

type rb_gpos_coord from radiobutton within w_actas_en_linea_estatus
integer x = 1714
integer y = 372
integer width = 507
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12632256
string text = "Actas Totales"
boolean checked = true
end type

event clicked;dw_estadisticas.dataobject = "d_estatus_actas_coord_en_linea"
dw_estadisticas.SetTransObject(gtr_sce)

end event

type uo_coordinacion from uo_dgmu_coordinaciones within w_actas_en_linea_estatus
integer x = 1335
integer y = 88
integer taborder = 110
boolean border = false
end type

on uo_coordinacion.destroy
call uo_dgmu_coordinaciones::destroy
end on

type gb_coordinacion from groupbox within w_actas_en_linea_estatus
integer x = 1614
integer y = 300
integer width = 626
integer height = 308
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Reporte a Consultar"
borderstyle borderstyle = styleraised!
end type

type st_3 from statictext within w_actas_en_linea_estatus
integer x = 3739
integer y = 108
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

type dw_estadisticas from datawindow within w_actas_en_linea_estatus
integer y = 660
integer width = 4699
integer height = 1636
integer taborder = 130
string dataobject = "d_estatus_actas_coord_en_linea"
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

type cb_1 from commandbutton within w_actas_en_linea_estatus
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 3845
integer y = 248
integer width = 265
integer height = 108
integer taborder = 140
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
long ll_rows, ll_row_actual
long ll_row_actual_estatus , ll_row_estatus, ll_rows_estatus, ll_cve_estatus_acta

ll_row_actual_estatus = uoi_estatus_acta.dw_estatus_acta.GetRow()
ll_rows_estatus = uoi_estatus_acta.dw_estatus_acta.RowCount()

IF ll_rows_estatus> 0 THEN
	ll_row_estatus = parent.uoi_estatus_acta.dw_estatus_acta.GetRow()
	ll_cve_estatus_acta = parent.uoi_estatus_acta.dw_estatus_acta.GetItemNumber(ll_row_estatus, 1)
ELSE
	MessageBox("Tabla sin estatus", "No existen coordinaciones registradas",StopSign!)
	return
END IF


ll_row_actual = parent.uo_coordinacion.dw_coordinaciones.GetRow()
ll_rows_coordinaciones = parent.uo_coordinacion.dw_coordinaciones.RowCount()
IF ii_cve_coordinacion<>9999 THEN
	parent.uo_coordinacion.dw_coordinaciones.SetItem(ll_row_actual,"cve_coordinacion", ii_cve_coordinacion)
END IF
IF ll_rows_coordinaciones> 0 THEN
	ll_row_coordinacion = parent.uo_coordinacion.dw_coordinaciones.GetRow()
	ll_cve_coordinacion = parent.uo_coordinacion.dw_coordinaciones.GetItemNumber(ll_row_coordinacion, 1)
ELSE
	MessageBox("Tabla sin coordinaciones", "No existen coordinaciones registradas",StopSign!)
	return
END IF

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


//MessageBox("Datawindow", dw_estadisticas.dataobject,Information!)

if rb_gpos_coord.checked then
	//FILTRA LOS GRUPOS ZZ
	if rb_ordinario.checked  = true then
		IF ii_cve_coordinacion <> 9999 THEN 
			dw_estadisticas.dataobject = "d_estatus_actas_coord_en_linea"
			dw_estadisticas.SetTransObject(gtr_sce)		
		ELSE		
			if	cbx_filtra_zz.checked then
				dw_estadisticas.dataobject = "d_estatus_actas_coord_en_linea"
				dw_estadisticas.SetTransObject(gtr_sce)
			else
				dw_estadisticas.dataobject = "d_estatus_actas_coord_en_linea_zz"
				dw_estadisticas.SetTransObject(gtr_sce)
			end if
		END IF
	elseif rb_extrao_tit.checked  = true then		
		IF ii_cve_coordinacion <> 9999 THEN 
			dw_estadisticas.dataobject = "d_estatus_actas_coord_en_linea_ets"
			dw_estadisticas.SetTransObject(gtr_sce)		
		ELSE		
			if	cbx_filtra_zz.checked then
				dw_estadisticas.dataobject = "d_estatus_actas_coord_en_linea_ets"
				dw_estadisticas.SetTransObject(gtr_sce)
			else
				dw_estadisticas.dataobject = "d_estatus_actas_coord_en_linea_zz_ets"
				dw_estadisticas.SetTransObject(gtr_sce)
			end if
		END IF		
	end if
	ll_rows = dw_estadisticas.Retrieve(ll_cve_coordinacion, li_periodo, li_anio, ll_cve_estatus_acta)
elseif rb_mi_coord.checked then
	if rb_ordinario.checked  = true then
		IF ii_cve_coordinacion <> 9999 THEN 
			dw_estadisticas.dataobject = "d_estatus_actas_coord_detalle_en_linea"
			dw_estadisticas.SetTransObject(gtr_sce)		
		ELSE		
			if	cbx_filtra_zz.checked then
				dw_estadisticas.dataobject = "d_estatus_actas_coord_detalle_en_linea"
				dw_estadisticas.SetTransObject(gtr_sce)
			else
				dw_estadisticas.dataobject = "d_estatus_actas_coord_detalle_en_lin_zz"
				dw_estadisticas.SetTransObject(gtr_sce)
			end if
		END IF
	elseif rb_extrao_tit.checked  = true then
		IF ii_cve_coordinacion <> 9999 THEN 
			dw_estadisticas.dataobject = "d_estatus_actas_coord_detalle_en_lin_ets"
			dw_estadisticas.SetTransObject(gtr_sce)		
		ELSE		
			if	cbx_filtra_zz.checked then
				dw_estadisticas.dataobject = "d_estatus_actas_coord_detalle_en_lin_ets"
				dw_estadisticas.SetTransObject(gtr_sce)
			else
				dw_estadisticas.dataobject = "d_estatus_actas_coord_detalle_en_l_zz_et"
				dw_estadisticas.SetTransObject(gtr_sce)
			end if
		END IF
		
	end if		
	ll_rows = dw_estadisticas.Retrieve(ll_cve_coordinacion, li_periodo, li_anio, ll_cve_estatus_acta)
end if
	




dw_estadisticas.object.periodo_anio.text= ls_periodo_elegido
dw_estadisticas.object.st_fecha_hoy.text= ls_fecha_servidor






end event

event constructor;TabOrder = 4
end event

type em_anio from editmask within w_actas_en_linea_estatus
event constructor pbm_constructor
event modified pbm_enmodified
boolean visible = false
integer x = 82
integer y = 520
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

int li_periodo, li_anio, li_retorno, li_coord_usuario


//periodo_actual_activacion(periodo,anio,gtr_sce)


li_retorno = f_obten_periodo(li_periodo, li_anio, 11)

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

CHOOSE CASE li_periodo
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

type rb_otonio from radiobutton within w_actas_en_linea_estatus
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 430
integer y = 572
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Otoño"
end type

event clicked;periodo_x = 2
end event

type rb_verano from radiobutton within w_actas_en_linea_estatus
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 73
integer y = 492
integer width = 270
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Verano"
end type

event clicked;periodo_x = 1
end event

type rb_primavera from radiobutton within w_actas_en_linea_estatus
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 73
integer y = 416
integer width = 343
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Primavera"
end type

event clicked;periodo_x = 0
end event

type dw_1x from datawindow within w_actas_en_linea_estatus
boolean visible = false
integer x = 3767
integer y = 624
integer width = 1038
integer height = 564
integer taborder = 120
string dataobject = "dw_repo_mad_18_gx"
boolean livescroll = true
end type

type gb_8 from groupbox within w_actas_en_linea_estatus
integer x = 3808
integer y = 204
integer width = 329
integer height = 176
integer taborder = 150
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_11 from groupbox within w_actas_en_linea_estatus
boolean visible = false
integer x = 37
integer y = 460
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

type gb_20 from groupbox within w_actas_en_linea_estatus
integer x = 23
integer y = 156
integer width = 1285
integer height = 272
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

type gb_2 from groupbox within w_actas_en_linea_estatus
integer x = 1317
integer y = 32
integer width = 1294
integer height = 224
integer taborder = 70
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

type gb_4 from groupbox within w_actas_en_linea_estatus
integer x = 2661
integer y = 40
integer width = 1056
integer height = 208
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Estatus del Acta"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_actas_en_linea_estatus
integer width = 4699
integer height = 644
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

type uoi_estatus_acta from uo_estatus_acta within w_actas_en_linea_estatus
integer x = 2683
integer y = 92
integer width = 997
integer height = 140
integer taborder = 90
boolean bringtotop = true
boolean border = false
end type

on uoi_estatus_acta.destroy
call uo_estatus_acta::destroy
end on

