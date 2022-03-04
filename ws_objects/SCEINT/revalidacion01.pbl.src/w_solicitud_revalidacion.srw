$PBExportHeader$w_solicitud_revalidacion.srw
forward
global type w_solicitud_revalidacion from window
end type
type st_status from statictext within w_solicitud_revalidacion
end type
type st_3 from statictext within w_solicitud_revalidacion
end type
type st_anio from statictext within w_solicitud_revalidacion
end type
type st_periodo from statictext within w_solicitud_revalidacion
end type
type st_2 from statictext within w_solicitud_revalidacion
end type
type st_1 from statictext within w_solicitud_revalidacion
end type
type tab_datos from tab within w_solicitud_revalidacion
end type
type tabpage_sol_revalidacion from userobject within tab_datos
end type
type uo_1 from uo_aspirante_revalidacion within tabpage_sol_revalidacion
end type
type dw_datos_solicitud from uo_dw_captura_base within tabpage_sol_revalidacion
end type
type uo_z from uo_aspirante_revalidacion within tabpage_sol_revalidacion
end type
type tabpage_sol_revalidacion from userobject within tab_datos
uo_1 uo_1
dw_datos_solicitud dw_datos_solicitud
uo_z uo_z
end type
type tabpage_materias from userobject within tab_datos
end type
type st_4 from statictext within tabpage_materias
end type
type uo_coordinacion from uo_lista_coords within tabpage_materias
end type
type cb_imprime_pliego from commandbutton within tabpage_materias
end type
type dw_sol_mat_revalidacion from uo_dw_captura_base within tabpage_materias
end type
type tabpage_materias from userobject within tab_datos
st_4 st_4
uo_coordinacion uo_coordinacion
cb_imprime_pliego cb_imprime_pliego
dw_sol_mat_revalidacion dw_sol_mat_revalidacion
end type
type tabpage_domicilio from userobject within tab_datos
end type
type dw_sol_rev_domicilio from uo_dw_captura_base within tabpage_domicilio
end type
type tabpage_domicilio from userobject within tab_datos
dw_sol_rev_domicilio dw_sol_rev_domicilio
end type
type tabpage_padre from userobject within tab_datos
end type
type dw_padre_revalidacion from uo_dw_captura_base within tabpage_padre
end type
type tabpage_padre from userobject within tab_datos
dw_padre_revalidacion dw_padre_revalidacion
end type
type tab_datos from tab within w_solicitud_revalidacion
tabpage_sol_revalidacion tabpage_sol_revalidacion
tabpage_materias tabpage_materias
tabpage_domicilio tabpage_domicilio
tabpage_padre tabpage_padre
end type
type uo_2 from uo_per_ani within w_solicitud_revalidacion
end type
end forward

global type w_solicitud_revalidacion from window
integer width = 3410
integer height = 2008
boolean titlebar = true
string title = "Solicitud de Revalidación"
string menuname = "m_solicitud_revalidacion"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
st_status st_status
st_3 st_3
st_anio st_anio
st_periodo st_periodo
st_2 st_2
st_1 st_1
tab_datos tab_datos
uo_2 uo_2
end type
global w_solicitud_revalidacion w_solicitud_revalidacion

type variables
long il_folio, il_cuenta, ii_periodo_ing, ii_anio_ing
integer ii_cancelado_original
end variables

forward prototypes
public function long wf_obten_folio_resultante (string as_apaterno, string as_amaterno, string as_nombre)
end prototypes

public function long wf_obten_folio_resultante (string as_apaterno, string as_amaterno, string as_nombre);return 0

end function

on w_solicitud_revalidacion.create
if this.MenuName = "m_solicitud_revalidacion" then this.MenuID = create m_solicitud_revalidacion
this.st_status=create st_status
this.st_3=create st_3
this.st_anio=create st_anio
this.st_periodo=create st_periodo
this.st_2=create st_2
this.st_1=create st_1
this.tab_datos=create tab_datos
this.uo_2=create uo_2
this.Control[]={this.st_status,&
this.st_3,&
this.st_anio,&
this.st_periodo,&
this.st_2,&
this.st_1,&
this.tab_datos,&
this.uo_2}
end on

on w_solicitud_revalidacion.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_status)
destroy(this.st_3)
destroy(this.st_anio)
destroy(this.st_periodo)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.tab_datos)
destroy(this.uo_2)
end on

event open;x=1
y=1
il_folio= 0
m_solicitud_revalidacion.m_registro.m_cargaregistro.enabled = false



end event

event close;gtr_sce.Autocommit= false
end event

type st_status from statictext within w_solicitud_revalidacion
integer x = 1339
integer y = 68
integer width = 526
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "BUSQUEDA"
boolean focusrectangle = false
end type

type st_3 from statictext within w_solicitud_revalidacion
integer x = 1070
integer y = 68
integer width = 251
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Modo:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_anio from statictext within w_solicitud_revalidacion
integer x = 389
integer y = 100
integer width = 526
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = " "
boolean focusrectangle = false
end type

type st_periodo from statictext within w_solicitud_revalidacion
integer x = 389
integer y = 28
integer width = 526
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = " "
boolean focusrectangle = false
end type

type st_2 from statictext within w_solicitud_revalidacion
integer x = 78
integer y = 100
integer width = 251
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Año:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_solicitud_revalidacion
integer x = 87
integer y = 28
integer width = 251
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Periodo:"
alignment alignment = right!
boolean focusrectangle = false
end type

type tab_datos from tab within w_solicitud_revalidacion
integer x = 41
integer y = 220
integer width = 3282
integer height = 1584
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
integer selectedtab = 1
tabpage_sol_revalidacion tabpage_sol_revalidacion
tabpage_materias tabpage_materias
tabpage_domicilio tabpage_domicilio
tabpage_padre tabpage_padre
end type

on tab_datos.create
this.tabpage_sol_revalidacion=create tabpage_sol_revalidacion
this.tabpage_materias=create tabpage_materias
this.tabpage_domicilio=create tabpage_domicilio
this.tabpage_padre=create tabpage_padre
this.Control[]={this.tabpage_sol_revalidacion,&
this.tabpage_materias,&
this.tabpage_domicilio,&
this.tabpage_padre}
end on

on tab_datos.destroy
destroy(this.tabpage_sol_revalidacion)
destroy(this.tabpage_materias)
destroy(this.tabpage_domicilio)
destroy(this.tabpage_padre)
end on

event selectionchanged;integer li_indice, li_num_rows_domicilio, li_num_rows_padre
boolean lb_editable

li_indice = newindex

//MessageBox("Indice: "+String(newindex), "Objeto: "+string(this))

SetPointer(HourGlass!)

m_solicitud_revalidacion.m_registro.enabled = true
m_solicitud_revalidacion.m_registro.m_borraregistro.enabled = true
m_solicitud_revalidacion.m_registro.m_nuevo.enabled = true
m_solicitud_revalidacion.m_registro.m_actualizar.enabled = true

lb_editable = tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.Enabled


choose case li_indice
	case 1
 	  tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.Retrieve(il_folio)
 	  tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.triggerevent("ue_asigna_dw_menu")
 	  tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.triggerevent("ue_inicia_transaction_object")
	case 2
 	  tab_datos.tabpage_materias.dw_sol_mat_revalidacion.Retrieve(il_folio)
 	  tab_datos.tabpage_materias.dw_sol_mat_revalidacion.triggerevent("ue_asigna_dw_menu")
 	  tab_datos.tabpage_materias.dw_sol_mat_revalidacion.triggerevent("ue_inicia_transaction_object")
 	  tab_datos.tabpage_materias.dw_sol_mat_revalidacion.enabled = lb_editable
	case 3
	  m_solicitud_revalidacion.m_registro.m_nuevo.enabled = false
 	  tab_datos.tabpage_domicilio.dw_sol_rev_domicilio.dataobject = 'd_domicilio_revalidacion'
 	  tab_datos.tabpage_domicilio.dw_sol_rev_domicilio.triggerevent("ue_asigna_dw_menu")
 	  tab_datos.tabpage_domicilio.dw_sol_rev_domicilio.triggerevent("ue_inicia_transaction_object")
 	  li_num_rows_domicilio= tab_datos.tabpage_domicilio.dw_sol_rev_domicilio.Retrieve(il_folio)
 	  tab_datos.tabpage_domicilio.dw_sol_rev_domicilio.enabled = lb_editable
	  if li_num_rows_domicilio = 0 then
		  m_solicitud_revalidacion.m_registro.enabled = false
		  m_solicitud_revalidacion.m_registro.m_borraregistro.enabled = false
		  m_solicitud_revalidacion.m_registro.m_cargaregistro.enabled = false
		  m_solicitud_revalidacion.m_registro.m_nuevo.enabled = false
		  m_solicitud_revalidacion.m_registro.m_actualizar.enabled = false
	 	  tab_datos.tabpage_domicilio.dw_sol_rev_domicilio.dataobject = 'd_domicilio_cons_rev'
 		  tab_datos.tabpage_domicilio.dw_sol_rev_domicilio.triggerevent("ue_asigna_dw_menu")
	 	  tab_datos.tabpage_domicilio.dw_sol_rev_domicilio.triggerevent("ue_inicia_transaction_object")
		  li_num_rows_domicilio= tab_datos.tabpage_domicilio.dw_sol_rev_domicilio.Retrieve(il_cuenta)
	 	  tab_datos.tabpage_domicilio.dw_sol_rev_domicilio.enabled = lb_editable
	  end if
		
	case 4
	  m_solicitud_revalidacion.m_registro.m_nuevo.enabled = false
     tab_datos.tabpage_padre.dw_padre_revalidacion.dataobject = 'd_padre_revalidacion'
 	  tab_datos.tabpage_padre.dw_padre_revalidacion.triggerevent("ue_asigna_dw_menu")
 	  tab_datos.tabpage_padre.dw_padre_revalidacion.triggerevent("ue_inicia_transaction_object")
 	  li_num_rows_padre= tab_datos.tabpage_padre.dw_padre_revalidacion.Retrieve(il_folio)
 	  tab_datos.tabpage_padre.dw_padre_revalidacion.enabled= lb_editable
	  if li_num_rows_padre = 0 then
		  m_solicitud_revalidacion.m_registro.enabled = false
		  m_solicitud_revalidacion.m_registro.m_borraregistro.enabled = false
		  m_solicitud_revalidacion.m_registro.m_cargaregistro.enabled = false
		  m_solicitud_revalidacion.m_registro.m_nuevo.enabled = false
		  m_solicitud_revalidacion.m_registro.m_actualizar.enabled = false
	     tab_datos.tabpage_padre.dw_padre_revalidacion.dataobject = 'd_padre_cons_rev'
 		  tab_datos.tabpage_padre.dw_padre_revalidacion.triggerevent("ue_asigna_dw_menu")
	 	  tab_datos.tabpage_padre.dw_padre_revalidacion.triggerevent("ue_inicia_transaction_object")
 		  li_num_rows_padre= tab_datos.tabpage_padre.dw_padre_revalidacion.Retrieve(il_cuenta)		
	 	  tab_datos.tabpage_padre.dw_padre_revalidacion.enabled = lb_editable
     end if 
end choose


end event

event selectionchanging;integer li_indice, li_num_rows_domicilio, li_num_rows_padre, li_resp
long ll_modificados, ll_borrados

//Evita el Cambio de página   1
//Permite el Cambio de página   0
if oldindex = 1 and tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.is_estatus = 'Nuevo' then
	MessageBox("Información incompleta", "Es necesario terminar la captura de la solicitud antes de cambiar de pagina",StopSign!)
	return 1
end if

//Validar cambio de pagina

li_indice = oldindex

choose case li_indice
	case 1
 	  ll_Modificados = tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.ModifiedCount()
 	  ll_Borrados = tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.DeletedCount()
	  if ll_Modificados+ll_Borrados> 0 and parent.st_status.text<>"BUSQUEDA" then
			li_resp = MessageBox("Información modificada", "¿Desea almacenar los cambios?", Question!, YesNo!)
			if li_resp = 1 then
				SetPointer(HourGlass!)
				tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.TriggerEvent("ue_actualizacion")
			end if
	  end if
	case 2
 	  ll_Modificados = tab_datos.tabpage_materias.dw_sol_mat_revalidacion.ModifiedCount()
 	  ll_Borrados = tab_datos.tabpage_materias.dw_sol_mat_revalidacion.DeletedCount()
	  if ll_Modificados+ll_Borrados> 0 and parent.st_status.text<>"BUSQUEDA" then
			li_resp = MessageBox("Información modificada", "¿Desea almacenar los cambios?", Question!, YesNo!)
			if li_resp = 1 then
				SetPointer(HourGlass!)	
				tab_datos.tabpage_materias.dw_sol_mat_revalidacion.TriggerEvent("ue_actualizacion")
			end if
	  end if
	case 3
 	  ll_Modificados = tab_datos.tabpage_domicilio.dw_sol_rev_domicilio.ModifiedCount()
 	  ll_Borrados = tab_datos.tabpage_domicilio.dw_sol_rev_domicilio.DeletedCount()
	  if ll_Modificados+ll_Borrados> 0 and parent.st_status.text<>"BUSQUEDA" then
			li_resp = MessageBox("Información modificada", "¿Desea almacenar los cambios?", Question!, YesNo!)
			if li_resp = 1 then
				SetPointer(HourGlass!)
				tab_datos.tabpage_domicilio.dw_sol_rev_domicilio.TriggerEvent("ue_actualizacion")
			end if
	  end if
	case 4
 	  ll_Modificados = tab_datos.tabpage_padre.dw_padre_revalidacion.ModifiedCount()
 	  ll_Borrados = tab_datos.tabpage_padre.dw_padre_revalidacion.DeletedCount()
	  if ll_Modificados+ll_Borrados> 0 and parent.st_status.text<>"BUSQUEDA" then
			li_resp = MessageBox("Información modificada", "¿Desea almacenar los cambios?", Question!, YesNo!)
			if li_resp = 1 then
				SetPointer(HourGlass!)
				tab_datos.tabpage_padre.dw_padre_revalidacion.TriggerEvent("ue_actualizacion")
			end if
	  end if
end choose





end event

type tabpage_sol_revalidacion from userobject within tab_datos
integer x = 18
integer y = 112
integer width = 3246
integer height = 1456
long backcolor = 79741120
string text = "Datos Solicitud"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
uo_1 uo_1
dw_datos_solicitud dw_datos_solicitud
uo_z uo_z
end type

on tabpage_sol_revalidacion.create
this.uo_1=create uo_1
this.dw_datos_solicitud=create dw_datos_solicitud
this.uo_z=create uo_z
this.Control[]={this.uo_1,&
this.dw_datos_solicitud,&
this.uo_z}
end on

on tabpage_sol_revalidacion.destroy
destroy(this.uo_1)
destroy(this.dw_datos_solicitud)
destroy(this.uo_z)
end on

type uo_1 from uo_aspirante_revalidacion within tabpage_sol_revalidacion
integer x = 229
integer y = 16
integer taborder = 40
end type

on uo_1.destroy
call uo_aspirante_revalidacion::destroy
end on

type dw_datos_solicitud from uo_dw_captura_base within tabpage_sol_revalidacion
event ue_filtra_carrera ( )
integer x = 119
integer y = 480
integer width = 2583
integer height = 904
integer taborder = 30
string dataobject = "d_solicitud_revalidacion"
end type

event ue_filtra_carrera;DataWindowChild cve_plan
string ls_filtro, ls_filtro_1, ls_filtro_2, ls_carrera, ls_columna, ls_plan
integer rtncode
long ll_carrera, ll_plan, ll_row, ll_num_rows

ll_row = this.GetRow()
ll_num_rows = this.RowCount()

if ll_num_rows <= 0 then
	return
end if


ll_carrera = object.cve_carrera[ll_row]
ls_carrera = string(ll_carrera)

if isnull(ls_carrera) then
	ls_carrera = "0"
end if



ls_filtro_1 = "plan_estudios_cve_carrera = "+ ls_carrera


rtncode = dw_datos_solicitud.GetChild('cve_plan', cve_plan)

IF rtncode = -1 THEN MessageBox("Error", "No es un DataWindowChild")

// Set the transaction object for the child
	
cve_plan.SetTransObject(gtr_sce)
	
cve_plan.SetFilter(ls_filtro_1)
cve_plan.Filter()
cve_plan.Retrieve()


end event

event ue_inicia_transaction_object;/*
DESCRIPCIÓN: Evento en el que se asigna al tr_dw_propio el objeto de transacción que se va a utilizar en el dw.
					 El codigo de este evento se agrega desde el control en la ventana
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: CAMP(DkWf)
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/
//tr_dw_propio = create transaction

tr_dw_propio = gtr_sce
this.SetTransObject(tr_dw_propio)


end event

event ue_nuevo;
/*Inserta un Nuevo Registro*/
IF uo_1.is_confirmacion_nuevo <> "S" THEN  
	if is_estatus = 'Nuevo' then
		MessageBox("Insertando Registro Nuevo", "Favor de terminar la captura actual", StopSign!)
		return
	end if
END IF

if this.AcceptText()<> -1 then
	setfocus()
	scrolltorow(insertrow(0))
	setcolumn(1)

	is_estatus = 'Nuevo'
End if
st_status.text = "EDICION"


string ls_apaterno, ls_amaterno, ls_nombre, ls_calif_examen, ls_cuenta
long ll_folio, ll_row, ll_cuenta
integer li_ing_por_revalidacion, li_res_comite, li_cancelado, li_calif_entrevista
ll_row = GetRow()

if uo_1.ii_elegi_para_nuevo = 0 then
	uo_1.ii_moviendo_folio = 1 
	uo_1.ii_moviendo_cuenta = 1 
	uo_1.ii_limpiando_nombre= 1 
	uo_1.em_apaterno.text = ""
	uo_1.em_amaterno.text = ""
	uo_1.em_nombre.text = ""
	uo_1.em_folio.text = ""
	uo_1.em_folio.enabled = false
	uo_1.em_cuenta.text = ""
	uo_1.em_cuenta.enabled = false
	uo_1.em_digito.text = ""
	uo_1.em_digito.enabled = false	
	uo_1.rb_edicion.text = "Nuevo"
	uo_1.rb_edicion.checked = true
	this.Enabled = true
end if


ll_folio = 1
li_ing_por_revalidacion = 1
li_res_comite = 0
li_cancelado = 0
ls_calif_examen= "AC"
ls_cuenta = uo_1.em_cuenta.text

if isnumber(ls_cuenta) then
	ll_cuenta = long(ls_cuenta)
end if 

if ll_cuenta > 0 then
	li_ing_por_revalidacion = 0
	li_res_comite = 1
else
	li_ing_por_revalidacion = 1
	li_res_comite = 0
end if
li_calif_entrevista= 6

this.SetItem(ll_row, "folio", ll_folio)
this.SetItem(ll_row, "ing_por_revalidacion", li_ing_por_revalidacion)
this.SetItem(ll_row, "res_comite", li_res_comite)
this.SetItem(ll_row, "cancelado", li_cancelado)
this.SetItem(ll_row, "calif_examen_global", ls_calif_examen)
this.SetItem(ll_row, "periodo_ing", gi_periodo)
this.SetItem(ll_row, "anio_ing", gi_anio)
this.SetItem(ll_row, "calif_entrevista", li_calif_entrevista)
this.SetItem(ll_row, "tipo_periodo", gs_tipo_periodo) 

// Se limpia el objeto de búsqueda 
IF uo_1.is_confirmacion_nuevo <> "S" THEN  
	uo_1.TRIGGEREVENT("ue_reinicia_objeto") 
END IF






end event

event ue_valida_logica;call super::ue_valida_logica;///*
//DESCRIPCIÓN: Evento en el cual se debe llevar a cabo un proceso de validación 
//	de la información contenida en el DataWindow para garantizar su integridad
//	en la base de datos y la lógica que la gobierna
//	
//	Efectua la llamada al user event: ue_valida_data_window para todos los registros
//	a actualizar
//	
//	
//PARÁMETROS: Ninguno
//REGRESA:  1 si toda la información esta bien
//			-1 Si hubo alguna falla
//AUTOR: Antonio Pica Ruiz
//FECHA: 30 de Marzo de 1999
//MODIFICACIÓN:
//*/

integer li_total_registros, li_cve_carrera, li_cve_plan
string ls_apaterno, ls_amaterno, ls_nombre, ls_nombre_completo, ls_cuenta, ls_nivel
long ll_cuenta, ll_registro_actual

ls_cuenta = uo_1.em_cuenta.text

ll_registro_actual = this.GetRow()

ls_apaterno = uo_1.em_apaterno.text
ls_amaterno = uo_1.em_amaterno.text
ls_nombre = uo_1.em_nombre.text
ls_nombre_completo= ls_apaterno +" "+ls_amaterno+" "+ls_nombre

if isnumber(ls_cuenta) then
	ll_cuenta = long(ls_cuenta)
end if 

li_cve_carrera= this.GetItemNumber(ll_registro_actual, "cve_carrera")
li_cve_plan= this.GetItemNumber(ll_registro_actual, "cve_plan")
ls_nivel = f_obten_nivel_carrera(li_cve_carrera)
if gi_periodo = 1 and is_estatus = 'Nuevo'then
	MessageBox("Error en periodo","No se permiten ingresos en Verano", StopSign!)
	return -1
elseif is_estatus = 'Nuevo'then
	this.SetItem(ll_registro_actual, "periodo_ing", gi_periodo)
	this.SetItem(ll_registro_actual, "anio_ing", gi_anio)
end if
if not f_plan_activo(li_cve_carrera, li_cve_plan) then
	MessageBox("Plan Inactivo","La carrera: ["+string(li_cve_carrera)+"] con el plan: ["+string(li_cve_plan)+ "] no estan activos ")	
	return -1
end if

this.SetItem(ll_registro_actual, "apaterno", ls_apaterno)
this.SetItem(ll_registro_actual, "amaterno", ls_amaterno)
this.SetItem(ll_registro_actual, "nombre", ls_nombre)
this.SetItem(ll_registro_actual, "nombre_completo", ls_nombre_completo)
this.SetItem(ll_registro_actual, "cuenta", ll_cuenta)
this.SetItem(ll_registro_actual, "nivel", ls_nivel)
this.SetItem(ll_registro_actual, "tipo_periodo", gs_tipo_periodo) 

return 1


end event

event retrieveend;long ll_total_rows, ll_row, ll_folio, ll_cuenta
string ls_apaterno, ls_amaterno, ls_nombre, ls_folio, ls_cuenta, ls_digito, ls_periodo, ls_anio
integer li_periodo, li_anio
dec ld_promedio, ld_promedio_calculado, ld_promedio_validado, ld_promedio_validado_calc

ll_total_rows = rowcount
ll_row = this.GetRow()

if ll_total_rows >0 then
	
	ll_folio = this.GetItemNumber(ll_row, "folio")
	ll_cuenta = this.GetItemNumber(ll_row, "cuenta")
	ls_apaterno = this.GetItemString(ll_row, "apaterno")
	ls_amaterno = this.GetItemString(ll_row, "amaterno")
	ls_nombre = this.GetItemString(ll_row, "nombre")
	li_periodo = this.GetItemNumber(ll_row, "periodo_ing")
	li_anio = this.GetItemNumber(ll_row, "anio_ing")
	ld_promedio = this.GetItemDecimal(ll_row, "prom_mat_revalidacion")
	ld_promedio_validado = this.GetItemDecimal(ll_row, "prom_mats_validadas")
	ii_cancelado_original = this.GetItemNumber(ll_row, "cancelado")
	
	if isnull(ld_promedio) then
		ld_promedio= 0
	end if
	if isnull(ld_promedio_validado) then
		ld_promedio_validado= 0
	end if
	ls_cuenta = string (ll_cuenta)
	ls_folio = string (ll_folio)


//	uo_1.ii_moviendo_cuenta = 1
//	uo_1.ii_moviendo_folio = 1
//	uo_1.ii_limpiando_nombre = 1

	uo_1.em_folio.text = ls_folio
	uo_1.em_cuenta.text = ls_cuenta
	uo_1.em_apaterno.text = ls_apaterno
	uo_1.em_amaterno.text = ls_amaterno
	uo_1.em_nombre.text = ls_nombre
	
	if	ll_cuenta <>0 then
		ls_digito = obten_digito(ll_cuenta)
		uo_1.em_digito.enabled = true
		uo_1.em_digito.text = ls_digito		
		uo_1.em_digito.enabled = false
	else
		uo_1.em_digito.enabled = true
		uo_1.em_digito.text = ""
		uo_1.em_digito.enabled = false		
	end if
	
	uo_periodo_servicios luo_periodo_servicios 
	luo_periodo_servicios = CREATE uo_periodo_servicios 
	luo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, "L", gtr_sce) 
	ls_periodo = luo_periodo_servicios.f_recupera_descripcion( li_periodo, "L") 
	
//	choose case  li_periodo 
//		case 0 
//			ls_periodo = "PRIMAVERA"	
//		case	1
//			ls_periodo = "VERANO"	
//		case 2
//			ls_periodo = "OTOÑO"				
//		case else
//			ls_periodo = ""				
//	end choose
	
	f_calc_prom_revalid(ll_folio, ld_promedio_calculado)
	f_calc_prom_mats_valid(ll_folio, ld_promedio_validado_calc)
	
	if	ld_promedio_calculado <> ld_promedio then
		this.SetItem(ll_row, "prom_mat_revalidacion", ld_promedio_calculado)
	end if

	if	ld_promedio_validado_calc <> ld_promedio_validado then
		this.SetItem(ll_row, "prom_mats_validadas", ld_promedio_validado_calc)
	end if
		
	st_periodo.text = ls_periodo
	ls_anio = string(li_anio)
	st_anio.text = ls_anio
	
//	Asigna el folio a la ventana
	il_folio = ll_folio
	il_cuenta = ll_cuenta
	ii_anio_ing = li_anio
	ii_periodo_ing = li_periodo
	
end if

this.triggerevent("ue_filtra_carrera")


end event

event ue_actualizacion;call super::ue_actualizacion;//Se prepara para el cambio de is_status para continuar con la captura
string ls_apaterno,ls_amaterno, ls_nombre
long ll_folio
long ll_row

ll_row = this.GetRow()

If AncestorReturnValue = 1 THEN
// execute some code
	if is_estatus = 'Nuevo' then
		ls_apaterno= GetItemString(ll_row, "apaterno")
		ls_amaterno= GetItemString(ll_row, "amaterno")
		ls_nombre= GetItemString(ll_row, "nombre")
		ll_folio = f_obten_folio_resultante(ls_apaterno, ls_amaterno, ls_nombre)
		if ll_folio <> 0 then
			this.Retrieve(ll_folio)
		   is_estatus = 'Modificando'	
			uo_1.rb_edicion.text = 'Modificando'	
		end if
	else
   	is_estatus = 'Modificando'	
		uo_1.rb_edicion.text = 'Modificando'
	end if
	COMMIT USING gtr_sce;
	return 1
ELSE
// execute some other code
	ROLLBACK USING gtr_sce;
	return -1
END IF


end event

event itemchanged;DataWindowChild cve_plan
string ls_filtro, ls_filtro_1, ls_filtro_2, ls_carrera, ls_columna, ls_plan, ls_valor
integer rtncode
long ll_carrera, ll_plan, ll_row
string ls_data, ls_text, ls_comite, ls_text_opuesto, ls_cancelado, ls_can_opuesto
integer li_res_comite, li_res_cambio_comite, li_res_comite_opuesto
integer li_cancelado, li_res_cancelado, li_cancelado_opuesto
string ls_nombre_cancelado, ls_cadena_cancelacion

ll_row = this.GetRow()

this.AcceptText()

//ls_columna =dwo.name

ls_columna =this.GetColumnName()


ll_carrera = object.cve_carrera[ll_row]
ls_carrera = string(ll_carrera)

//ll_plan = object.cve_plan[ll_row]
//ls_plan = string(ll_plan)

ls_filtro_1 = "plan_estudios_cve_carrera = "+ ls_carrera

ls_filtro_2 = "cve_plan = "+ ls_plan

choose case ls_columna 
case'cve_carrera' 
	

	rtncode = dw_datos_solicitud.GetChild('cve_plan', cve_plan)

	IF rtncode = -1 THEN MessageBox("Error", "No es un DataWindowChild")

	// Set the transaction object for the child
	
	cve_plan.SetTransObject(gtr_sce)
	
	// Populate the child with all the posible values for planes
	if isnull(ls_carrera) then
		ls_carrera = "0"
	end if
	
	cve_plan.SetFilter(ls_filtro_1)
	cve_plan.Filter()
	cve_plan.Retrieve()
case 'res_comite' 
//	ls_data = string(dwo.data)
	ls_text = this.GetText()
//	li_res_comite = integer(ls_data)
	li_res_comite=	this.object.res_comite[row]
	if li_res_comite = 0 then
		ls_comite= "RECHAZADO"
		ls_text_opuesto ="1"
		li_res_comite_opuesto = 1
	else	
		ls_comite= "ACEPTADO"
		ls_text_opuesto ="0"
		li_res_comite_opuesto = 0
	end if	
	li_res_cambio_comite = MessageBox("Modificación al resultado del comité",&
	 "¿Desea cambiar a "+ls_comite+" el resultado del comité", Question!, YesNo!)
	if li_res_cambio_comite = 1 then
		this.SetItem(row,"res_comite", li_res_comite)
		return 0
	else
		this.SetItem(row,"res_comite", li_res_comite_opuesto)
		return 2
	end if
case 'cancelado' 
//	ls_data = string(dwo.data)
	ls_text = this.GetText()
//	li_res_comite = integer(ls_data)
	li_cancelado=	this.object.cancelado[row]
	ls_nombre_cancelado = f_obten_nombre_cancelado(li_cancelado)
	if li_cancelado = 0 then
		ls_cancelado= "NO CANCELADO"
		ls_text_opuesto ="1"
		li_cancelado_opuesto = 1
	elseif li_cancelado = 1 then	
		ls_cancelado= ls_nombre_cancelado
		ls_text_opuesto ="0"
		li_cancelado_opuesto = 0
	elseif li_cancelado = 2 then	
		ls_cancelado= ls_nombre_cancelado
		ls_text_opuesto ="0"
		li_cancelado_opuesto = 0
	end if	
	ls_cadena_cancelacion= 	 "¿Desea cambiar a "+ls_cancelado+" el trámite del aspirante?"
	li_res_cancelado = MessageBox("Cancelación del proceso",&
	 ls_cadena_cancelacion, Question!, YesNo!)
	if li_res_cancelado = 1 then
		this.SetItem(row,"cancelado", li_cancelado)
		return 0
	else
		this.SetItem(row,"cancelado", ii_cancelado_original)
		return 2
	end if

end choose

return 0

end event

event doubleclicked;//doubleclicked

if getcolumn() = 11 then
	busqueda("univ_proc")
	object.univ_proc[row]=ok
end if

end event

event constructor;call super::constructor;gtr_sce.Autocommit= true 


datawindowchild ldw_carreras
LONG ll_num_carreras

THIS.GETCHILD("cve_carrera", ldw_carreras)
ldw_carreras.SETTRANSOBJECT(gtr_sce) 
ll_num_carreras = ldw_carreras.RETRIEVE(gs_tipo_periodo) 
IF ll_num_carreras = 0 THEN 
	MESSAGEBOX("Aviso", "No se encontraron carreras de tipo " + gs_descripcion_tipo_periodo)
END IF







end event

type uo_z from uo_aspirante_revalidacion within tabpage_sol_revalidacion
integer x = 119
integer y = 16
integer width = 0
integer height = 0
integer taborder = 10
boolean border = false
long backcolor = 0
long tabtextcolor = 0
long tabbackcolor = 0
long picturemaskcolor = 0
end type

on uo_z.destroy
call uo_aspirante_revalidacion::destroy
end on

type tabpage_materias from userobject within tab_datos
integer x = 18
integer y = 112
integer width = 3246
integer height = 1456
long backcolor = 79741120
string text = "Materias a Revalidar"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
st_4 st_4
uo_coordinacion uo_coordinacion
cb_imprime_pliego cb_imprime_pliego
dw_sol_mat_revalidacion dw_sol_mat_revalidacion
end type

on tabpage_materias.create
this.st_4=create st_4
this.uo_coordinacion=create uo_coordinacion
this.cb_imprime_pliego=create cb_imprime_pliego
this.dw_sol_mat_revalidacion=create dw_sol_mat_revalidacion
this.Control[]={this.st_4,&
this.uo_coordinacion,&
this.cb_imprime_pliego,&
this.dw_sol_mat_revalidacion}
end on

on tabpage_materias.destroy
destroy(this.st_4)
destroy(this.uo_coordinacion)
destroy(this.cb_imprime_pliego)
destroy(this.dw_sol_mat_revalidacion)
end on

type st_4 from statictext within tabpage_materias
integer x = 210
integer y = 1164
integer width = 443
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Coordinación :"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_coordinacion from uo_lista_coords within tabpage_materias
integer x = 695
integer y = 1132
integer taborder = 40
long backcolor = 79741120
end type

on uo_coordinacion.destroy
call uo_lista_coords::destroy
end on

type cb_imprime_pliego from commandbutton within tabpage_materias
integer x = 2043
integer y = 1152
integer width = 457
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprime Pliego"
end type

event clicked;long	ll_res_impresion, ll_num_rows, ll_row_coord
datetime lddtm_fecha
integer li_imprime, li_coordinacion
string ls_nombre_coordinacion, ls_mensaje_coordinacion

ll_row_coord= uo_coordinacion.dw_coordinacion.GetRow()
li_coordinacion= uo_coordinacion.dw_coordinacion.GetItemNumber(ll_row_coord, "cve_coordinacion")

lddtm_fecha = fecha_servidor(gtr_sce)
ll_num_rows = dw_sol_mat_revalidacion.RowCount()

if dw_sol_mat_revalidacion.ModifiedCount()+dw_sol_mat_revalidacion.DeletedCount() > 0 Then
	MessageBox("Favor de almacenar los cambios",&
				"Es necesario grabar las materias, ~n"+ &
				 "antes de la impresion del pliego",StopSign!)
	return 
end if
if li_coordinacion = 9999 then
	ls_mensaje_coordinacion= "Todas las coordinaciones"
else	
	ls_nombre_coordinacion =f_obten_nombre_coord(li_coordinacion)
	ls_mensaje_coordinacion= "La coordinacion de " + ls_nombre_coordinacion	
end if

	
//li_imprime=MessageBox("Confirmacion",&
//				"Desea imprimir el pliego correspondiente a ~n"+ &
//				string(ll_num_rows)+ " materias",Question!, YesNo!)
li_imprime=MessageBox("Confirmacion",&
				"Desea imprimir el pliego correspondiente a ~n"+ &
				ls_mensaje_coordinacion,Question!, YesNo!)
if li_imprime = 1 then				
	ll_res_impresion= f_imprime_sol_equiv_coord(il_folio, lddtm_fecha, li_coordinacion)
end if


end event

type dw_sol_mat_revalidacion from uo_dw_captura_base within tabpage_materias
integer x = 59
integer y = 184
integer width = 3058
integer height = 892
integer taborder = 12
string dataobject = "d_sol_materias_revalidacion"
boolean hscrollbar = true
end type

event ue_inicia_transaction_object;/*
DESCRIPCIÓN: Evento en el que se asigna al tr_dw_propio el objeto de transacción que se va a utilizar en el dw.
					 El codigo de este evento se agrega desde el control en la ventana
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: CAMP(DkWf)
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/
//tr_dw_propio = create transaction

tr_dw_propio = gtr_sce
this.SetTransObject(tr_dw_propio)


end event

event ue_nuevo;call super::ue_nuevo;string ls_apaterno, ls_amaterno, ls_nombre, ls_cuenta
long ll_folio, ll_row, ll_cuenta
integer li_periodo_ing, li_anio_ing, li_procede

ll_row = GetRow()

ll_folio = il_folio
li_periodo_ing= ii_periodo_ing
li_anio_ing= ii_anio_ing
li_procede = 0

//MessageBox("Folio: "+string(ll_folio),"Periodo: "+string(li_periodo_ing)+"Anio:"+string(li_anio_ing))

this.SetItem(ll_row, "folio", ll_folio)
this.SetItem(ll_row, "periodo", li_periodo_ing)
this.SetItem(ll_row, "anio", li_anio_ing)
this.SetItem(ll_row, "procede", li_procede)


SetColumn(1)





end event

event ue_valida_logica;//
//DESCRIPCIÓN: Evento en el cual se debe llevar a cabo un proceso de validación 
//	de la información contenida en el DataWindow para garantizar su integridad
//	en la base de datos y la lógica que la gobierna
//	
//	Efectua la llamada al user event: ue_valida_data_window para todos los registros
//	a actualizar
//	
//	
//PARÁMETROS: Ninguno
//REGRESA:  1 si toda la información esta bien
//			-1 Si hubo alguna falla
//AUTOR: Antonio Pica Ruiz
//FECHA: 30 de Marzo de 1999
//MODIFICACIÓN:
//
//

integer li_total_registros, li_registro_actual

li_registro_actual = 1
li_total_registros = RowCount()

DO WHILE li_registro_actual <= li_total_registros
	
	If Event ue_valida_data_window(li_registro_actual) <> 0 then
		ScrollToRow(li_registro_actual)
		return -1
	End If

	li_registro_actual = li_registro_actual +1 
	
LOOP


return 1



end event

event ue_valida_data_window;//DESCRIPCIÓN: Evento en el cual se debe llevar a cabo un proceso de validación 
//	de la información contenida en el DataWindow para garantizar su integridad
//	en la base de datos y la lógica que la gobierna
//	
//	Es necesario sobreescribirse en cada catálogo donde se desee dicha validación
//	ya que por omisión regresará 1 (información correcta)
//	
//PARÁMETROS: Ninguno
//REGRESA:  0 si toda la información esta bien
//			-1 Si hubo alguna falla
//AUTOR: Antonio Pica Ruiz
//FECHA: 30 de Marzo de 1999
//MODIFICACIÓN:


string ls_nombre_materia, ls_calificacion, ls_nombre_materia_act, ls_calificacion_act
long ll_registro_actual, ll_num_rows
integer li_cals_distintas

ll_num_rows = this.RowCount()

ls_nombre_materia= this.GetItemString(ai_num_registro,"nombre_materia")
ls_calificacion= this.GetItemString(ai_num_registro,"calificacion")

for ll_registro_actual=1 to ll_num_rows
	if ll_registro_actual <> ai_num_registro then
		ls_nombre_materia_act= this.GetItemString(ll_registro_actual,"nombre_materia")
		ls_calificacion_act= this.GetItemString(ll_registro_actual,"calificacion")
		if (ls_nombre_materia =ls_nombre_materia_act) and &
			(ls_calificacion <>ls_calificacion_act) then
			MessageBox("Misma materia externa con distinta calificacion",&
			 "La materia "+ls_nombre_materia+" tiene calificaciones distintas.",StopSign!)
			 return -1
		end if
	end if	
next

return 0

end event

event ue_actualizacion;/*
DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
				
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/
int li_respuesta
/*Acepta el texto de la última columna editada*/
AcceptText()
/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
if ModifiedCount()+DeletedCount() > 0 Then

	/*Pregunta si se desean guardar los cambios hechos*/
	li_respuesta = messagebox("Atención","Desea actualizar los cambios:",Question!,YesNo!,2)

	if li_respuesta = 1 then
			/*Checa que los renglones cumplan con las reglas de validación*/
			if event ue_actualiza_con_mensaje() = 1 then//Manda llamar la función que realiza el update
				message.longparm = 1
				COMMIT USING gtr_sce;
				return message.longparm
			else 
				message.longparm = -1
				ROLLBACK USING gtr_sce;
				return message.longparm
			end if
	else
		/*De lo contrario, solo avisa que no se guardó nada.*/
		messagebox("Información","No se han guardado los cambios")
		message.longparm = -1
		ROLLBACK USING gtr_sce;
		return message.longparm
	end if
else
	COMMIT USING gtr_sce;
	return 1
end if


end event

event constructor;call super::constructor;gtr_sce.Autocommit= true

datawindowchild ldw_coordinaciones
LONG ll_num_coord

THIS.GETCHILD("cve_coordinacion", ldw_coordinaciones)
ldw_coordinaciones.SETTRANSOBJECT(gtr_sce) 
ll_num_coord = ldw_coordinaciones.RETRIEVE(gs_tipo_periodo) 
IF ll_num_coord = 0 THEN 
	MESSAGEBOX("Aviso", "No se encontraron coordinaciones de tipo " + gs_descripcion_tipo_periodo)
END IF





end event

type tabpage_domicilio from userobject within tab_datos
integer x = 18
integer y = 112
integer width = 3246
integer height = 1456
long backcolor = 79741120
string text = "Domicilio"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_sol_rev_domicilio dw_sol_rev_domicilio
end type

on tabpage_domicilio.create
this.dw_sol_rev_domicilio=create dw_sol_rev_domicilio
this.Control[]={this.dw_sol_rev_domicilio}
end on

on tabpage_domicilio.destroy
destroy(this.dw_sol_rev_domicilio)
end on

type dw_sol_rev_domicilio from uo_dw_captura_base within tabpage_domicilio
integer x = 174
integer y = 124
integer width = 2935
integer height = 688
integer taborder = 12
string dataobject = "d_domicilio_revalidacion"
boolean hscrollbar = true
end type

event ue_inicia_transaction_object;/*
DESCRIPCIÓN: Evento en el que se asigna al tr_dw_propio el objeto de transacción que se va a utilizar en el dw.
					 El codigo de este evento se agrega desde el control en la ventana
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: CAMP(DkWf)
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/
//tr_dw_propio = create transaction

tr_dw_propio = gtr_sce
this.SetTransObject(tr_dw_propio)


end event

event ue_actualizacion;/*
DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
				
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/
int li_respuesta
/*Acepta el texto de la última columna editada*/
AcceptText()
/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
if ModifiedCount()+DeletedCount() > 0 Then

	/*Pregunta si se desean guardar los cambios hechos*/
	li_respuesta = messagebox("Atención","Desea actualizar los cambios:",Question!,YesNo!,2)

	if li_respuesta = 1 then
			/*Checa que los renglones cumplan con las reglas de validación*/
			if event ue_actualiza_con_mensaje() = 1 then//Manda llamar la función que realiza el update
				message.longparm = 1
				COMMIT USING gtr_sce;
				return message.longparm
			else 
				message.longparm = -1
				ROLLBACK USING gtr_sce;
				return message.longparm
			end if
	else
		/*De lo contrario, solo avisa que no se guardó nada.*/
		messagebox("Información","No se han guardado los cambios")
		message.longparm = -1
		ROLLBACK USING gtr_sce;
		return message.longparm
	end if
else
	COMMIT USING gtr_sce;
	return 1
end if


end event

event constructor;call super::constructor;gtr_sce.Autocommit= true
end event

type tabpage_padre from userobject within tab_datos
integer x = 18
integer y = 112
integer width = 3246
integer height = 1456
long backcolor = 79741120
string text = "Padre"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_padre_revalidacion dw_padre_revalidacion
end type

on tabpage_padre.create
this.dw_padre_revalidacion=create dw_padre_revalidacion
this.Control[]={this.dw_padre_revalidacion}
end on

on tabpage_padre.destroy
destroy(this.dw_padre_revalidacion)
end on

type dw_padre_revalidacion from uo_dw_captura_base within tabpage_padre
integer x = 142
integer y = 108
integer width = 2953
integer height = 1084
integer taborder = 12
string dataobject = "d_padre_revalidacion"
boolean hscrollbar = true
end type

event ue_inicia_transaction_object;/*
DESCRIPCIÓN: Evento en el que se asigna al tr_dw_propio el objeto de transacción que se va a utilizar en el dw.
					 El codigo de este evento se agrega desde el control en la ventana
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: CAMP(DkWf)
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/
//tr_dw_propio = create transaction

tr_dw_propio = gtr_sce
this.SetTransObject(tr_dw_propio)


end event

event ue_valida_logica;///*
//DESCRIPCIÓN: Evento en el cual se debe llevar a cabo un proceso de validación 
//	de la información contenida en el DataWindow para garantizar su integridad
//	en la base de datos y la lógica que la gobierna
//	
//	Efectua la llamada al user event: ue_valida_data_window para todos los registros
//	a actualizar
//	
//	
//PARÁMETROS: Ninguno
//REGRESA:  1 si toda la información esta bien
//			-1 Si hubo alguna falla
//AUTOR: Antonio Pica Ruiz
//FECHA: 30 de Marzo de 1999
//MODIFICACIÓN:
//*/

integer li_total_registros, li_registro_actual
string ls_apaterno, ls_amaterno, ls_nombre, ls_nombre_completo, ls_cuenta

li_registro_actual = this.GetRow()

ls_apaterno= this.GetItemString(li_registro_actual, "apaterno")
ls_amaterno= this.GetItemString(li_registro_actual, "amaterno")
ls_nombre= this.GetItemString(li_registro_actual, "nombre")

ls_nombre_completo= ls_apaterno +" "+ls_amaterno+" "+ls_nombre


this.SetItem(li_registro_actual, "nombre_completo", ls_nombre_completo)


return 1


end event

event ue_actualizacion;call super::ue_actualizacion;/*
DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
				
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/
int li_respuesta
/*Acepta el texto de la última columna editada*/
AcceptText()
/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
if ModifiedCount()+DeletedCount() > 0 Then

	/*Pregunta si se desean guardar los cambios hechos*/
	li_respuesta = messagebox("Atención","Desea actualizar los cambios:",Question!,YesNo!,2)

	if li_respuesta = 1 then
			/*Checa que los renglones cumplan con las reglas de validación*/
			if event ue_actualiza_con_mensaje() = 1 then//Manda llamar la función que realiza el update
				message.longparm = 1
				COMMIT USING gtr_sce;
				return message.longparm
			else 
				message.longparm = -1
				ROLLBACK USING gtr_sce;
				return message.longparm
			end if
	else
		/*De lo contrario, solo avisa que no se guardó nada.*/
		messagebox("Información","No se han guardado los cambios")
		message.longparm = -1
		ROLLBACK USING gtr_sce;
		return message.longparm
	end if
else
	COMMIT USING gtr_sce;
	return 1
end if

end event

event constructor;call super::constructor;gtr_sce.Autocommit= true
end event

type uo_2 from uo_per_ani within w_solicitud_revalidacion
integer x = 2071
integer y = 24
integer width = 1253
integer height = 168
integer taborder = 20
boolean bringtotop = true
boolean enabled = true
end type

on uo_2.destroy
call uo_per_ani::destroy
end on

