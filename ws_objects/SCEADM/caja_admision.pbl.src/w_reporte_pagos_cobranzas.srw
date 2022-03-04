$PBExportHeader$w_reporte_pagos_cobranzas.srw
forward
global type w_reporte_pagos_cobranzas from window
end type
type cbx_concepto_1 from checkbox within w_reporte_pagos_cobranzas
end type
type cbx_pago_cobranzas from checkbox within w_reporte_pagos_cobranzas
end type
type cbx_pago_admision from checkbox within w_reporte_pagos_cobranzas
end type
type cb_filtra_pagados from commandbutton within w_reporte_pagos_cobranzas
end type
type cbx_concepto_20 from checkbox within w_reporte_pagos_cobranzas
end type
type cbx_concepto_19 from checkbox within w_reporte_pagos_cobranzas
end type
type cb_cargar from commandbutton within w_reporte_pagos_cobranzas
end type
type uo_1 from uo_ver_per_ani within w_reporte_pagos_cobranzas
end type
type dw_1 from uo_dw_reporte within w_reporte_pagos_cobranzas
end type
end forward

global type w_reporte_pagos_cobranzas from window
integer x = 832
integer y = 364
integer width = 3611
integer height = 2068
boolean titlebar = true
string title = "Reporte de Pagos Registrados en Cobranzas"
string menuname = "m_menu"
long backcolor = 26439467
cbx_concepto_1 cbx_concepto_1
cbx_pago_cobranzas cbx_pago_cobranzas
cbx_pago_admision cbx_pago_admision
cb_filtra_pagados cb_filtra_pagados
cbx_concepto_20 cbx_concepto_20
cbx_concepto_19 cbx_concepto_19
cb_cargar cb_cargar
uo_1 uo_1
dw_1 dw_1
end type
global w_reporte_pagos_cobranzas w_reporte_pagos_cobranzas

type variables
uo_administrador_liberacion iuo_administrador_liberacion
end variables

on w_reporte_pagos_cobranzas.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cbx_concepto_1=create cbx_concepto_1
this.cbx_pago_cobranzas=create cbx_pago_cobranzas
this.cbx_pago_admision=create cbx_pago_admision
this.cb_filtra_pagados=create cb_filtra_pagados
this.cbx_concepto_20=create cbx_concepto_20
this.cbx_concepto_19=create cbx_concepto_19
this.cb_cargar=create cb_cargar
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.cbx_concepto_1,&
this.cbx_pago_cobranzas,&
this.cbx_pago_admision,&
this.cb_filtra_pagados,&
this.cbx_concepto_20,&
this.cbx_concepto_19,&
this.cb_cargar,&
this.uo_1,&
this.dw_1}
end on

on w_reporte_pagos_cobranzas.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_concepto_1)
destroy(this.cbx_pago_cobranzas)
destroy(this.cbx_pago_admision)
destroy(this.cb_filtra_pagados)
destroy(this.cbx_concepto_20)
destroy(this.cbx_concepto_19)
destroy(this.cb_cargar)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

f_obten_titulo(w_principal)
dw_1.settransobject(gtr_sadm)
end event

event close;desconecta_bd(gtr_scob)

if isvalid(iuo_administrador_liberacion) then
	DESTROY iuo_administrador_liberacion 
end if

end event

type cbx_concepto_1 from checkbox within w_reporte_pagos_cobranzas
integer x = 27
integer y = 228
integer width = 631
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Aportacion Unica (1)"
boolean checked = true
boolean lefttext = true
end type

type cbx_pago_cobranzas from checkbox within w_reporte_pagos_cobranzas
integer x = 2661
integer y = 152
integer width = 535
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Pago Cobranzas"
boolean checked = true
boolean lefttext = true
end type

type cbx_pago_admision from checkbox within w_reporte_pagos_cobranzas
integer x = 2706
integer y = 60
integer width = 489
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Pago Admision"
boolean lefttext = true
end type

type cb_filtra_pagados from commandbutton within w_reporte_pagos_cobranzas
integer x = 3264
integer y = 88
integer width = 251
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Filtrar"
end type

event clicked;string ls_DWfilter, ls_filtro_admision, ls_filtro_cobranzas

if cbx_pago_admision.checked then
	ls_filtro_admision= "pago_insc = 1"
else	
	ls_filtro_admision= "pago_insc = 0"
end if

if cbx_pago_cobranzas.checked then
	ls_filtro_cobranzas= "status_cob = 1"
else	
	ls_filtro_cobranzas= "status_cob = 0"
end if

ls_DWfilter = ls_filtro_admision + " and " +ls_filtro_cobranzas

dw_1.SetFilter(ls_DWfilter)
dw_1.Filter( )


end event

type cbx_concepto_20 from checkbox within w_reporte_pagos_cobranzas
integer x = 1385
integer y = 228
integer width = 626
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Insc. Reingreso (20)"
boolean checked = true
boolean lefttext = true
end type

type cbx_concepto_19 from checkbox within w_reporte_pagos_cobranzas
integer x = 704
integer y = 228
integer width = 645
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Insc.1er Ingreso (19)"
boolean checked = true
boolean lefttext = true
end type

type cb_cargar from commandbutton within w_reporte_pagos_cobranzas
integer x = 2336
integer y = 68
integer width = 306
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar"
end type

event clicked;datetime ldttm_fecha, ldttm_fecha_pago, ldttm_fecha_pago_cob, ldttm_fecha_ven_cob, ldttm_fecha_sup
long ll_res_saldos, ll_renglon, ll_newrow, ll_res_aspiran, ll_cuenta_par, ll_cuenta_cob, ll_cuenta
integer  li_ret, li_anio_cob, li_clv_ver, li_clv_per, li_anio
datastore lds_saldos, lds_aspiran_general_version
string ls_periodo_cob
integer li_status_cob
string ls_fecha_aux, ls_control_correcto, ls_datastore
date  ldt_fecha_aux
long ll_indice_saldos, ll_num_saldos
real lr_saldo_cob
li_clv_ver= gi_version
li_clv_per = gi_periodo
li_anio = gi_anio
ll_cuenta = 0


ll_cuenta_par = 0
//ldttm_fecha = f_obten_fecha_version(gi_version, gi_periodo,gi_anio)
ls_fecha_aux = string(ldttm_fecha, "yyyy/mm/dd")
ldt_fecha_aux =date(ls_fecha_aux)
ldt_fecha_aux =relativedate(ldt_fecha_aux,1)
ldttm_fecha_sup = datetime(ldt_fecha_aux)

ls_periodo_cob= f_obten_periodo_cob(gi_periodo)
li_anio_cob= f_obten_anio_cob(gi_anio)



if isnull(ldttm_fecha) then
	MessageBox("Error","No existe una fecha valida para el periodo elegido",StopSign!)
end if

if not isvalid(gtr_sce) then
	if conecta_bd(gtr_sce,gs_sce,gs_usuario,gs_password)<>1 then
		return
	end if
end if

if not isvalid(gtr_scob) then
	if conecta_bd(gtr_scob,gs_scob,gs_usuario,gs_password)<>1 then
		return
	end if
end if




if not isvalid(iuo_administrador_liberacion) then
	iuo_administrador_liberacion = CREATE uo_administrador_liberacion	
end if
ls_datastore= "d_saldos"
IF iuo_administrador_liberacion.of_liberacion_vigente("SIT") THEN
	IF iuo_administrador_liberacion.of_obten_control_correcto("SIT","admision","d_saldos", "datawindow", ls_control_correcto) THEN
		ls_datastore = ls_control_correcto
	END IF
END IF


lds_saldos = Create datastore
lds_saldos.DataObject = ls_datastore
lds_saldos.SetTransObject(gtr_scob)
//ll_res_saldos = lds_saldos.Retrieve(ls_periodo_cob, li_anio_cob, ldttm_fecha, ll_cuenta_par)


lds_aspiran_general_version = Create datastore
lds_aspiran_general_version.DataObject = "d_aspiran_general_version"
lds_aspiran_general_version.SetTransObject(gtr_sadm)
ll_res_aspiran = lds_aspiran_general_version.Retrieve(li_clv_ver, li_clv_per, li_anio, ll_cuenta)


ll_renglon = 1

long ll_folio_asp, ll_cuenta_asp
integer li_clv_ver_asp, li_clv_per_asp, li_anio_asp, li_status_asp, li_pago_exam_asp, li_pago_insc_asp
integer li_clv_carr_asp, li_ing_periodo_asp, li_ing_anio_asp
string ls_nombre_asp, ls_apaterno_asp, ls_amaterno_asp, ls_nombre_completo
integer larrayi_cve_con [ ]
integer li_tamanio_array, li_cve_con_cob, li_cve_ban_cob



if cbx_concepto_1.checked then
	li_tamanio_array= upperbound(larrayi_cve_con)
	if gb_liberacion_vigente then 
		larrayi_cve_con[li_tamanio_array + 1]= 1
	else
		larrayi_cve_con[li_tamanio_array + 1]= 1
	end if
end if

if cbx_concepto_19.checked then
	li_tamanio_array= upperbound(larrayi_cve_con)
	if gb_liberacion_vigente then 
		larrayi_cve_con[li_tamanio_array +1]= 3
	else
		larrayi_cve_con[li_tamanio_array +1]= 19
	end if
end if

if cbx_concepto_20.checked then
	li_tamanio_array= upperbound(larrayi_cve_con)
	if gb_liberacion_vigente then 
		larrayi_cve_con[li_tamanio_array +1]= 4
	else
		larrayi_cve_con[li_tamanio_array + 1]= 20
	end if
end if

dw_1.Reset()

do while ll_renglon <= ll_res_aspiran
	ll_folio_asp=  lds_aspiran_general_version.GetItemNumber(ll_renglon, "aspiran_folio")
	li_clv_ver_asp= lds_aspiran_general_version.GetItemNumber(ll_renglon, "aspiran_clv_ver")
	li_clv_per_asp= lds_aspiran_general_version.GetItemNumber(ll_renglon, "aspiran_clv_per")
	li_anio_asp= lds_aspiran_general_version.GetItemNumber(ll_renglon, "aspiran_anio")
	li_status_asp= lds_aspiran_general_version.GetItemNumber(ll_renglon, "aspiran_status")
	li_clv_carr_asp= lds_aspiran_general_version.GetItemNumber(ll_renglon, "aspiran_clv_carr")
	li_pago_exam_asp= lds_aspiran_general_version.GetItemNumber(ll_renglon, "aspiran_pago_exam")
	li_pago_insc_asp= lds_aspiran_general_version.GetItemNumber(ll_renglon, "aspiran_pago_insc")
	li_ing_periodo_asp= lds_aspiran_general_version.GetItemNumber(ll_renglon, "aspiran_ing_per")
	li_ing_anio_asp= lds_aspiran_general_version.GetItemNumber(ll_renglon, "aspiran_ing_anio")
	ll_cuenta_asp= lds_aspiran_general_version.GetItemNumber(ll_renglon, "general_cuenta")
	ls_nombre_asp= lds_aspiran_general_version.GetItemString(ll_renglon, "general_nombre")
	ls_apaterno_asp= lds_aspiran_general_version.GetItemString(ll_renglon, "general_apaterno")
	ls_amaterno_asp= lds_aspiran_general_version.GetItemString(ll_renglon, "general_amaterno")
	
	ls_nombre_completo= ls_apaterno_asp +" "+ ls_amaterno_asp +" "+ ls_nombre_asp
	
//	ll_res_saldos = lds_saldos.Retrieve(ls_periodo_cob, li_anio_cob, ldttm_fecha, ldttm_fecha_sup, ll_cuenta_asp, larrayi_cve_con)


	IF gb_liberacion_vigente THEN				
		ll_res_saldos = lds_saldos.Retrieve(li_clv_per, li_anio, ll_cuenta_asp, larrayi_cve_con)
	ELSE
		ll_res_saldos = lds_saldos.Retrieve(ls_periodo_cob, li_anio_cob, ll_cuenta_asp, larrayi_cve_con)
	END IF
	
	ll_indice_saldos = 1	
	ll_num_saldos = ll_res_saldos
	
	if ll_res_saldos <= 0 then
		setnull(ldttm_fecha_pago_cob)
		setnull(ldttm_fecha_ven_cob)
		setnull(li_status_cob)
		setnull(li_cve_con_cob)
		setnull(li_cve_ban_cob)
		ll_num_saldos = 1
	end if
	
	do while ll_indice_saldos <= ll_num_saldos
		if ll_res_saldos >= 1 then
//			ldttm_fecha_pago_cob = lds_saldos.GetItemDateTime(ll_indice_saldos, "fecha_pago")
			ldttm_fecha_ven_cob = lds_saldos.GetItemDateTime(ll_indice_saldos, "fecha_ven")
			
			IF gb_liberacion_vigente THEN				
				lr_saldo_cob = lds_saldos.GetItemNumber(ll_indice_saldos, "saldo")			
				IF lr_saldo_cob<=0 THEN
					li_status_cob= 1
				ELSE
					li_status_cob= 0
				END IF

			ELSE	
				li_status_cob = lds_saldos.GetItemNumber(ll_indice_saldos, "status")			
			END IF			
			li_cve_con_cob = lds_saldos.GetItemNumber(ll_indice_saldos, "cve_con")
//			li_cve_ban_cob = lds_saldos.GetItemNumber(ll_indice_saldos, "cve_ban")
		end if
		
		ll_newrow = dw_1.InsertRow(0)
		dw_1.ScrollToRow(ll_newrow)
				
		dw_1.SetItem(ll_newrow, "clv_ver", li_clv_ver_asp)
		dw_1.SetItem(ll_newrow, "clv_per", li_clv_per_asp)
		dw_1.SetItem(ll_newrow, "anio", li_anio_asp)
		dw_1.SetItem(ll_newrow, "cuenta", ll_cuenta_asp)
		dw_1.SetItem(ll_newrow, "pago_insc", li_pago_insc_asp)
//		dw_1.SetItem(ll_newrow, "fecha_pago", ldttm_fecha_pago_cob)
		dw_1.SetItem(ll_newrow, "fecha_ven", ldttm_fecha_ven_cob)
		dw_1.SetItem(ll_newrow, "status", li_status_asp)
		dw_1.SetItem(ll_newrow, "status_cob", li_status_cob)
		dw_1.SetItem(ll_newrow, "nombre_completo", ls_nombre_completo)
		dw_1.SetItem(ll_newrow, "cve_con", li_cve_con_cob)
		dw_1.SetItem(ll_newrow, "folio", ll_folio_asp)
		dw_1.SetItem(ll_newrow, "clv_carr", li_clv_carr_asp)
//		dw_1.SetItem(ll_newrow, "cve_ban", li_cve_ban_cob)
		
		ll_indice_saldos= ll_indice_saldos+1
	loop

	ll_renglon= ll_renglon+1
loop

	
	
	
end event

type uo_1 from uo_ver_per_ani within w_reporte_pagos_cobranzas
integer x = 18
integer y = 24
integer height = 164
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_reporte_pagos_cobranzas
integer x = 23
integer y = 344
integer width = 3570
integer height = 1496
integer taborder = 0
string dataobject = "d_reporte_pagos_cob"
boolean hscrollbar = true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;call super::carga;/**/

cb_cargar.TriggerEvent(Clicked!)

return 0
end event

event constructor;/*
DESCRIPCIÓN: Evento en el que se localiza la variable dw en el menu y se asigna el valor de este objeto	.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: CAMP(DkWf)
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/
triggerevent("asigna_dw_menu")

//Orientation = 0 Default
//Orientation = 1 Landscape
//Orientation = 2 Portrait

dw_1.Modify("DataWindow.Print.Orientation = 1")


end event

