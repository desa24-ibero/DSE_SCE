$PBExportHeader$w_pagos_tramite_internet.srw
forward
global type w_pagos_tramite_internet from w_main
end type
type cb_cargar from u_cb within w_pagos_tramite_internet
end type
type st_2 from statictext within w_pagos_tramite_internet
end type
type st_1 from statictext within w_pagos_tramite_internet
end type
type em_fecha_final from u_em within w_pagos_tramite_internet
end type
type em_fecha_inicial from u_em within w_pagos_tramite_internet
end type
type gb_1 from groupbox within w_pagos_tramite_internet
end type
type dw_1 from u_dw_captura within w_pagos_tramite_internet
end type
end forward

global type w_pagos_tramite_internet from w_main
integer width = 2994
integer height = 1772
string title = "Revisión de Pagos en Trámites por Internet"
string menuname = "m_menu"
cb_cargar cb_cargar
st_2 st_2
st_1 st_1
em_fecha_final em_fecha_final
em_fecha_inicial em_fecha_inicial
gb_1 gb_1
dw_1 dw_1
end type
global w_pagos_tramite_internet w_pagos_tramite_internet

type variables
long il_num_tramites_inicial, il_num_tramites_final
u_pipeline_control iu_pipeline_control, iu_pipeline_control02
n_tr i_tr_origen, i_tr_destino
datetime idttm_fecha_servidor

st_confirma_usuario ist_confirma_usuario
end variables

on w_pagos_tramite_internet.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_cargar=create cb_cargar
this.st_2=create st_2
this.st_1=create st_1
this.em_fecha_final=create em_fecha_final
this.em_fecha_inicial=create em_fecha_inicial
this.gb_1=create gb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cargar
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.em_fecha_final
this.Control[iCurrent+5]=this.em_fecha_inicial
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.dw_1
end on

on w_pagos_tramite_internet.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_cargar)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_fecha_final)
destroy(this.em_fecha_inicial)
destroy(this.gb_1)
destroy(this.dw_1)
end on

event open;call super::open;datetime ldttm_fecha_servidor, ldttm_fecha_inicial

ldttm_fecha_servidor = fecha_servidor(gtr_sce)
ldttm_fecha_inicial = datetime(date("1-jan-2004"))
x=1
y=1

il_num_tramites_inicial = f_obten_numero_tramites(9999)


em_fecha_inicial.text = string(ldttm_fecha_inicial,"dd/mm/yyyy")
em_fecha_final.text =  string(ldttm_fecha_servidor,"dd/mm/yyyy")

if conecta_bd(gtr_scob,gs_scob,gs_usuario,gs_password)=0 then
	MessageBox("Error","No es posible consultar los pagos de los trámites",StopSign!)
	close(this)
end if
end event

event close;call super::close;if isvalid(gtr_scob) then
	if desconecta_bd(gtr_scob)=0 then
		MessageBox("Error","No es posible consultar los pagos de los trámites")
		close(this)
	end if
end if
end event

type cb_cargar from u_cb within w_pagos_tramite_internet
integer x = 2039
integer y = 144
integer width = 471
integer taborder = 30
string text = "Consultar"
end type

event clicked;call super::clicked;dw_1.Triggerevent("carga")

end event

type st_2 from statictext within w_pagos_tramite_internet
integer x = 1097
integer y = 228
integer width = 302
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha Final:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_pagos_tramite_internet
integer x = 1097
integer y = 112
integer width = 302
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha Inicial:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fecha_final from u_em within w_pagos_tramite_internet
integer x = 1417
integer y = 212
integer width = 288
integer height = 84
integer taborder = 20
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type em_fecha_inicial from u_em within w_pagos_tramite_internet
integer x = 1417
integer y = 96
integer width = 288
integer height = 84
integer taborder = 10
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type gb_1 from groupbox within w_pagos_tramite_internet
integer x = 1079
integer y = 28
integer width = 672
integer height = 320
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Periodo Atención"
end type

type dw_1 from u_dw_captura within w_pagos_tramite_internet
integer x = 46
integer y = 380
integer width = 2843
integer height = 1148
integer taborder = 30
string dataobject = "d_pagos_tramites_internet"
boolean hscrollbar = true
boolean resizable = true
end type

event retrieverow;call super::retrieverow;long ll_cuenta, ll_existe_pago, ll_existe_pago_anterior
integer li_cve_tramite, li_cve_estado = 1, li_cve_sub_estado= 3
datetime ldttm_fecha_servidor

ll_cuenta = this.GetItemNumber(row, "alumnos_cuenta")
li_cve_tramite = this.GetItemNumber(row, "solicitud_tramite_cve_tramite")
ll_existe_pago_anterior = this.GetItemNumber(row, "existe_pago")
IF isnull(ll_existe_pago_anterior) THEN ll_existe_pago_anterior=0
ll_existe_pago =f_existe_pago_tramite(ll_cuenta, li_cve_tramite)

this.SetItem(row, "existe_pago", ll_existe_pago)

IF ll_existe_pago_anterior=0 AND ll_existe_pago= 1 THEN
	ldttm_fecha_servidor = idttm_fecha_servidor
	this.SetItem(row, "fecha_pago", ldttm_fecha_servidor)
	this.SetItem(row, "cve_estado", li_cve_estado)
	this.SetItem(row, "cve_sub_estado", li_cve_sub_estado)
END IF


end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio=gtr_sce
this.SetTransObject(tr_dw_propio)
end event

event carga;string ls_fecha_inicial, ls_fecha_final, ls_fecha_servidor
date ldt_fecha_inicial, ldt_fecha_final
datetime ldttm_fecha_inicial, ldttm_fecha_final
integer li_num_registros 

idttm_fecha_servidor = fecha_servidor(gtr_sce)
ls_fecha_servidor = string(idttm_fecha_servidor,"dd/mm/yyyy hh:mm")

dw_1.object.fecha_hoy.text =ls_fecha_servidor

if isnull(dw_1.DataObject) then
	return 0
end if

ls_fecha_inicial= em_fecha_inicial.text
ls_fecha_final= em_fecha_final.text

ldt_fecha_inicial =date(ls_fecha_inicial)
ldt_fecha_final =date(ls_fecha_final)

if ldt_fecha_final < ldt_fecha_inicial then
	MessageBox("Error de fechas","La fecha inicial de atención no debe ser mayor a la fecha final")
end if 



ldt_fecha_final= RelativeDate(ldt_fecha_final, +1)

ldttm_fecha_inicial =datetime(ldt_fecha_inicial)
ldttm_fecha_final =datetime(ldt_fecha_final)

li_num_registros= dw_1.retrieve(ldttm_fecha_inicial, ldttm_fecha_final)

return li_num_registros



end event

