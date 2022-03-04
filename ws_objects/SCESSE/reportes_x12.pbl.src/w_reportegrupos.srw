$PBExportHeader$w_reportegrupos.srw
forward
global type w_reportegrupos from w_ancestral
end type
type dw_reportegrupos from uo_dw_reporte within w_reportegrupos
end type
type cb_1 from commandbutton within w_reportegrupos
end type
type st_periodo from statictext within w_reportegrupos
end type
type uo_nivel from uo_nivel_2013 within w_reportegrupos
end type
type st_1 from statictext within w_reportegrupos
end type
type em_anio from editmask within w_reportegrupos
end type
type uo_periodo from uo_periodo_variable_tipos within w_reportegrupos
end type
type st_2 from statictext within w_reportegrupos
end type
type ddlb_tipo_imp from dropdownlistbox within w_reportegrupos
end type
type gb_11 from groupbox within w_reportegrupos
end type
type gb_1 from groupbox within w_reportegrupos
end type
end forward

global type w_reportegrupos from w_ancestral
integer width = 4037
integer height = 2940
string title = "Reporte de Inscripción"
string menuname = "m_menu"
long backcolor = 16777215
dw_reportegrupos dw_reportegrupos
cb_1 cb_1
st_periodo st_periodo
uo_nivel uo_nivel
st_1 st_1
em_anio em_anio
uo_periodo uo_periodo
st_2 st_2
ddlb_tipo_imp ddlb_tipo_imp
gb_11 gb_11
gb_1 gb_1
end type
global w_reportegrupos w_reportegrupos

type variables

Transaction itr_parametros_iniciales
n_tr itr_seguridad, itr_original

//nombre de la conexion en parametros_conexion
CONSTANT	string	is_controlescolar_cnx	=	"controlescolar_inscripcion"
CONSTANT	string	is_tesoreria_cnx			=	"controlescolar_inscripcion_tesoreria"
CONSTANT	string	is_becas_cnx				=	"controlescolar_inscripcion_becas"
int ii_cve_coordinacion, ii_periodo, ii_anio, ii_num_resize = 0
integer ii_tipo_imp

STRING is_descripcion_periodo
end variables

on w_reportegrupos.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_reportegrupos=create dw_reportegrupos
this.cb_1=create cb_1
this.st_periodo=create st_periodo
this.uo_nivel=create uo_nivel
this.st_1=create st_1
this.em_anio=create em_anio
this.uo_periodo=create uo_periodo
this.st_2=create st_2
this.ddlb_tipo_imp=create ddlb_tipo_imp
this.gb_11=create gb_11
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_reportegrupos
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_periodo
this.Control[iCurrent+4]=this.uo_nivel
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.em_anio
this.Control[iCurrent+7]=this.uo_periodo
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.ddlb_tipo_imp
this.Control[iCurrent+10]=this.gb_11
this.Control[iCurrent+11]=this.gb_1
end on

on w_reportegrupos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_reportegrupos)
destroy(this.cb_1)
destroy(this.st_periodo)
destroy(this.uo_nivel)
destroy(this.st_1)
destroy(this.em_anio)
destroy(this.uo_periodo)
destroy(this.st_2)
destroy(this.ddlb_tipo_imp)
destroy(this.gb_11)
destroy(this.gb_1)
end on

event open;call super::open;int li_retorno, li_periodo, li_anio, li_coord_usuario, li_chk, li_num_items, li_item_actual, li_cve_coordinacion

//Cambio por Ajustes en Línea
//1)->
//Se conecta a la seguridad para mantener separada una transacción para la seguridad
if not (conecta_bd_n_tr(itr_seguridad,gs_sce,gs_usuario,gs_password) = 1) then
	messageBox('Error en seguridad', 'No es posible validar la seguridad del usuario',Stopsign!)
end if

itr_parametros_iniciales = gtr_sce

li_chk	=	f_conecta_pas_parametros_act_bd(itr_parametros_iniciales,gtr_sce,is_controlescolar_cnx,gs_usuario,gs_password,1)
if li_chk <> 1 then return


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


//Cambio por Ajustes en Línea
//2)->
//Se vuelve a poner porque en el constructor de los datawindows ya previamente se había ejecutado apuntando a sybase
//dw_reportegrupos.settransobject(gtr_sce)
dw_reportegrupos.settransobject(gtr_sce)

f_obten_titulo(w_principal)

w_principal.ChangeMenu(m_grupos_impartidos_salir)

//Cambio por Ajustes en Línea
//2)<-


li_cve_coordinacion = f_obten_coord_de_usuario(gs_usuario)

if li_cve_coordinacion = 9999 then
	ii_cve_coordinacion = li_cve_coordinacion
// No es coordinador
elseif li_cve_coordinacion = -1 then
// Error de consulta en la lectura
	MessageBox("Error en lectura de coordinacion", "No es posible determinar la coordinacion del usuario",StopSign!)
	close(this)
else	
//Es coordinador
	ii_cve_coordinacion = li_cve_coordinacion
end if


li_retorno = f_obten_periodo(li_periodo, li_anio, 4)

if li_retorno = -1 then
	MessageBox("Error en calendario", "No es posible leer el periodo de carga de coordinadores",StopSign!)
	if li_coord_usuario <> 9999 then
		close(this)
	end if
end if

//si el usuario es coordinador, no puede modificar el periodo.
if li_cve_coordinacion <> 9999 then
//	uo_1.visible= false
//	cb_actualiza_periodo.visible= false	

	// Se inicializa el objeto de periodos en modo exclusivo para periodo activo
	THIS.uo_periodo.of_inicializa_servicio( "V", "L", "L", "S", gtr_sce)
	em_anio.ENABLED = FALSE
else
//	uo_1.visible= true
//	cb_actualiza_periodo.visible= true

	// Se inicializa el objeto de periodos en modo libre.
	THIS.uo_periodo.of_inicializa_servicio( "V", "L", "L", "N", gtr_sce)
end if


//gi_anio=li_anio
//gi_periodo=li_periodo
//uo_1.em_ani.text = string(gi_anio)
//uo_1.em_per.text = string(gi_periodo)
//cb_actualiza_periodo.event Clicked()

uo_nivel.of_carga_control(gtr_sce)
ddlb_tipo_imp.selectitem(2)

end event

event close;call super::close;//Cambio por Ajustes en Línea
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
//Cambio por Ajustes en Línea
//3)<-

end event

event resize;call super::resize;long ll_height_win, ll_height_dw, ll_dif_height_tab, ll_height_tab, ll_width_tab, ll_height_tab_final

if ii_num_resize > 0 then
	ll_height_dw = dw_reportegrupos.height
	ll_height_win = this.height

	ll_height_tab = dw_reportegrupos.height
	ll_width_tab = dw_reportegrupos.width

	dw_reportegrupos.width = newwidth - 50
	dw_reportegrupos.height = newheight - 850
	
	ll_height_tab_final = dw_reportegrupos.height
	
	ll_dif_height_tab = ll_height_tab_final - ll_height_tab  

	dw_reportegrupos.width = newwidth - 200
	dw_reportegrupos.height = ll_height_dw + ll_dif_height_tab
else
	ii_num_resize = ii_num_resize +1
end if
end event

type p_uia from w_ancestral`p_uia within w_reportegrupos
integer width = 677
integer height = 272
string picturename = "logoibero-web.png"
end type

type dw_reportegrupos from uo_dw_reporte within w_reportegrupos
integer x = 32
integer y = 828
integer width = 3881
integer height = 1880
integer taborder = 0
string dataobject = "dw_reportegrupos"
boolean hscrollbar = true
boolean resizable = true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

event retrieveend;call super::retrieveend;long ll_cve_mat, ll_cve_asimilada, ll_inscritos, ll_inscritos_reales, ll_tipo_grupo, ll_null, ll_row
string ls_gpo, ls_gpo_asimilado
SetPointer(HourGlass!)

//Se quitó la contabilización de los inscritos para grupos asimilados
//FOR ll_row = 1 TO rowcount
//
//	SetNull(ll_null)
//	ll_inscritos_reales = ll_null
//	ll_cve_mat = this.GetItemNumber(ll_row, "grupos_cve_mat")
//	ll_cve_asimilada = this.GetItemNumber(ll_row, "grupos_cve_asimilada")
//	ll_inscritos = this.GetItemNumber(ll_row, "grupos_inscritos")
//	ll_tipo_grupo = this.GetItemNumber(ll_row, "grupos_tipo")
//	ls_gpo  = this.GetItemString(ll_row, "grupos_gpo")
//	ls_gpo_asimilado  = this.GetItemString(ll_row, "grupos_gpo_asimilado")
//
//	if ll_tipo_grupo=2 or f_grupo_que_asimila(ll_cve_mat, ls_gpo, gi_periodo,gi_anio) then
//		ll_inscritos_reales = f_cuenta_mat_insc(ll_cve_mat, ls_gpo, gi_periodo,gi_anio) 
//	end if
//
//	this.SetItem(ll_row,"inscritos_reales",ll_inscritos_reales)
//
//NEXT

SetPointer(Arrow!)
end event

event carga;cb_1.event clicked()
return rowcount()
end event

type cb_1 from commandbutton within w_reportegrupos
integer x = 2487
integer y = 584
integer width = 379
integer height = 108
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cargar"
end type

event clicked;string ls_array_nivel[]

Parent.uo_nivel.of_carga_arreglo_nivel( )
Parent.uo_nivel.of_obtiene_array( ls_array_nivel[])

If UpperBound(ls_array_nivel[]) <= 0 Then
	MessageBox(" Error ","Debe seleccionar un nivel. ",StopSign!)
	return
End If
	
INTEGER le_anio 
le_anio = INTEGER(em_anio.text) 	
IF le_anio < 1900 THEN 
	MessageBox(" Error ","Debe seleccionar un año válido. ",StopSign!)
	return	
END IF
	
	
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**		
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	
INTEGER le_index
INTEGER le_periodo[] 
STRING ls_tipo_periodo[]
//STRING is_descripcion_periodo

PARENT.uo_periodo.of_recupera_periodos() 

//periodo_x[] = le_periodo[]
is_descripcion_periodo = ""
FOR le_index = 1 TO UPPERBOUND(PARENT.uo_periodo.istr_periodos[])
	IF TRIM(is_descripcion_periodo) <> "" THEN is_descripcion_periodo = is_descripcion_periodo + ", "
	is_descripcion_periodo = is_descripcion_periodo + PARENT.uo_periodo.istr_periodos[le_index].descripcion 
	le_periodo[le_index] = PARENT.uo_periodo.istr_periodos[le_index].periodo
	ls_tipo_periodo[le_index] = PARENT.uo_periodo.istr_periodos[le_index].tipo
NEXT 	
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**		
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**		

dw_reportegrupos.MODIFY("t_titulo.text = '" + is_descripcion_periodo + " de " + STRING(le_anio) + "'")	
st_periodo.text = is_descripcion_periodo + " de " + STRING(le_anio) 
	
IF ii_tipo_imp = 0 THEN ii_tipo_imp = 1 // 1 = Tradicional	

If dw_reportegrupos.retrieve(ls_array_nivel[],le_periodo[],le_anio,ii_cve_coordinacion,ii_tipo_imp) <= 0 Then
  Messagebox("Mensaje de Sistema","No existe información para la consulta realizada")	
  return
End If
end event

type st_periodo from statictext within w_reportegrupos
integer x = 1111
integer y = 744
integer width = 1618
integer height = 84
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_nivel from uo_nivel_2013 within w_reportegrupos
event destroy ( )
integer x = 1874
integer y = 344
integer taborder = 30
boolean bringtotop = true
end type

on uo_nivel.destroy
call uo_nivel_2013::destroy
end on

type st_1 from statictext within w_reportegrupos
integer x = 677
integer y = 96
integer width = 224
integer height = 100
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 16777215
string text = "DSE"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_anio from editmask within w_reportegrupos
integer x = 101
integer y = 484
integer width = 215
integer height = 80
integer taborder = 20
boolean bringtotop = true
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

type uo_periodo from uo_periodo_variable_tipos within w_reportegrupos
integer x = 434
integer y = 372
integer width = 1202
integer height = 344
integer taborder = 40
boolean bringtotop = true
long backcolor = 12639424
end type

on uo_periodo.destroy
call uo_periodo_variable_tipos::destroy
end on

type st_2 from statictext within w_reportegrupos
integer x = 2487
integer y = 416
integer width = 498
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Tipo impartición:"
boolean focusrectangle = false
end type

type ddlb_tipo_imp from dropdownlistbox within w_reportegrupos
integer x = 3008
integer y = 404
integer width = 549
integer height = 384
integer taborder = 132
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

type gb_11 from groupbox within w_reportegrupos
integer x = 64
integer y = 424
integer width = 283
integer height = 156
integer taborder = 100
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 12639424
string text = "Año"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_reportegrupos
integer x = 23
integer y = 304
integer width = 3886
integer height = 436
integer taborder = 11
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Criterios de Busqueda"
borderstyle borderstyle = styleraised!
end type

