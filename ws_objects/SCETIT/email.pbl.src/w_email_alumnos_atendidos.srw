$PBExportHeader$w_email_alumnos_atendidos.srw
forward
global type w_email_alumnos_atendidos from w_main
end type
type cb_procesar from u_cb within w_email_alumnos_atendidos
end type
type em_fecha_inicial_asig from u_em within w_email_alumnos_atendidos
end type
type em_fecha_final_asig from u_em within w_email_alumnos_atendidos
end type
type st_4 from statictext within w_email_alumnos_atendidos
end type
type st_3 from statictext within w_email_alumnos_atendidos
end type
type cb_cargar from u_cb within w_email_alumnos_atendidos
end type
type dw_1 from uo_dw_reporte within w_email_alumnos_atendidos
end type
type st_2 from statictext within w_email_alumnos_atendidos
end type
type st_1 from statictext within w_email_alumnos_atendidos
end type
type em_fecha_final from u_em within w_email_alumnos_atendidos
end type
type em_fecha_inicial from u_em within w_email_alumnos_atendidos
end type
type gb_1 from groupbox within w_email_alumnos_atendidos
end type
type gb_2 from groupbox within w_email_alumnos_atendidos
end type
end forward

global type w_email_alumnos_atendidos from w_main
integer width = 3105
integer height = 1782
string title = "Relación de Alumnos Atendidos"
string menuname = "m_menu"
cb_procesar cb_procesar
em_fecha_inicial_asig em_fecha_inicial_asig
em_fecha_final_asig em_fecha_final_asig
st_4 st_4
st_3 st_3
cb_cargar cb_cargar
dw_1 dw_1
st_2 st_2
st_1 st_1
em_fecha_final em_fecha_final
em_fecha_inicial em_fecha_inicial
gb_1 gb_1
gb_2 gb_2
end type
global w_email_alumnos_atendidos w_email_alumnos_atendidos

type variables
uo_mail_service iuo_mail_service
end variables

on w_email_alumnos_atendidos.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_procesar=create cb_procesar
this.em_fecha_inicial_asig=create em_fecha_inicial_asig
this.em_fecha_final_asig=create em_fecha_final_asig
this.st_4=create st_4
this.st_3=create st_3
this.cb_cargar=create cb_cargar
this.dw_1=create dw_1
this.st_2=create st_2
this.st_1=create st_1
this.em_fecha_final=create em_fecha_final
this.em_fecha_inicial=create em_fecha_inicial
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_procesar
this.Control[iCurrent+2]=this.em_fecha_inicial_asig
this.Control[iCurrent+3]=this.em_fecha_final_asig
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.cb_cargar
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.em_fecha_final
this.Control[iCurrent+11]=this.em_fecha_inicial
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.gb_2
end on

on w_email_alumnos_atendidos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_procesar)
destroy(this.em_fecha_inicial_asig)
destroy(this.em_fecha_final_asig)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.cb_cargar)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_fecha_final)
destroy(this.em_fecha_inicial)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;x=1
y=1

iuo_mail_service = create uo_mail_service
end event

event close;call super::close;if isvalid(iuo_mail_service) then
	destroy iuo_mail_service
end if
end event

type cb_procesar from u_cb within w_email_alumnos_atendidos
integer x = 2458
integer y = 118
integer width = 351
integer height = 93
integer taborder = 60
string text = "Procesar"
end type

event clicked;call super::clicked;string ls_fecha_inicial, ls_fecha_final
date ldt_fecha_inicial, ldt_fecha_final, ldt_fecha_asignacion
datetime ldttm_fecha_inicial, ldttm_fecha_final, ldttm_fecha_asignacion
integer li_num_registros , li_num_dias_periodo, li_alumnos_dia, li_row_actual
integer li_day, li_month
string ls_nombre_completo, ls_dia, ls_mes, ls_fecha_recepcion, ls_e_mail
string ls_nombres_completos[], ls_fechas_recepcion[], ls_e_mails[]
long 	ll_cuentas[], ll_cve_carreras[], ll_cuenta, ll_cve_carrera

li_num_registros = dw_1.RowCount()

if li_num_registros= 0 then
	MessageBox("Error de datos","No existen registros a procesar",StopSign!)
	return
end if

ls_fecha_inicial= em_fecha_inicial_asig.text
ls_fecha_final= em_fecha_final_asig.text

ldt_fecha_inicial =date(ls_fecha_inicial)
ldt_fecha_final =date(ls_fecha_final)

if ldt_fecha_final < ldt_fecha_inicial then
	MessageBox("Error de fechas","La fecha inicial de entrega no debe ser mayor a la fecha final")
	return
end if 

li_num_dias_periodo= DaysAfter(ldt_fecha_inicial, ldt_fecha_final)


if mod(li_num_registros,li_num_dias_periodo) =0 then
	li_alumnos_dia = round(li_num_registros / li_num_dias_periodo, 0)
else
	li_alumnos_dia = round(li_num_registros / li_num_dias_periodo, 0) + 1
end if	

ldt_fecha_asignacion= ldt_fecha_inicial

FOR li_row_actual= 1 to li_num_registros
	if mod(li_row_actual,li_alumnos_dia)= 0 then
		ldt_fecha_asignacion = RelativeDate(ldt_fecha_asignacion, +1)
	end if
	li_day = day(ldt_fecha_asignacion)
	li_month	= month(ldt_fecha_asignacion)
	ls_nombre_completo = dw_1.GetItemString(li_row_actual,"nombre_completo")
	ls_e_mail = dw_1.GetItemString(li_row_actual,"e_mail")
	ls_mes = f_obten_mes(li_month)
	ls_fecha_recepcion= string(li_day) + " de "+ls_mes
	ls_nombres_completos[li_row_actual] = ls_nombre_completo
	ls_fechas_recepcion[li_row_actual]= ls_fecha_recepcion
	ls_e_mails[li_row_actual]= ls_e_mail
	ll_cuenta = dw_1.GetItemNumber(li_row_actual,"cuenta")
	ll_cve_carrera = dw_1.GetItemNumber(li_row_actual,"cve_carrera")
	ll_cuentas[li_row_actual] = ll_cuenta
	ll_cve_carreras[li_row_actual] = ll_cve_carrera
NEXT
SetPointer(HourGlass!)
if iuo_mail_service.of_genera_html_opcion_cero(ll_cuentas, ll_cve_carreras, ls_nombres_completos, ls_fechas_recepcion) = -1 then
	MessageBox("Error de generación","No se han podido generar los archivos")
	return	
end if
if iuo_mail_service.of_genera_emails_opcion_cero( ll_cuentas, ll_cve_carreras, ls_e_mails) = -1 then
	MessageBox("Error de envío","No se han podido enviar los archivos")
	return	
end if


SetPointer(Arrow!)




end event

type em_fecha_inicial_asig from u_em within w_email_alumnos_atendidos
integer x = 2063
integer y = 80
integer width = 289
integer taborder = 40
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type em_fecha_final_asig from u_em within w_email_alumnos_atendidos
integer x = 2063
integer y = 195
integer width = 289
integer taborder = 50
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type st_4 from statictext within w_email_alumnos_atendidos
integer x = 1723
integer y = 211
integer width = 300
integer height = 51
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

type st_3 from statictext within w_email_alumnos_atendidos
integer x = 1723
integer y = 96
integer width = 300
integer height = 51
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

type cb_cargar from u_cb within w_email_alumnos_atendidos
integer x = 995
integer y = 118
integer width = 351
integer height = 93
integer taborder = 30
string text = "Consultar"
end type

event clicked;call super::clicked;dw_1.Triggerevent("carga")

end event

type dw_1 from uo_dw_reporte within w_email_alumnos_atendidos
integer x = 44
integer y = 381
integer width = 2842
integer height = 1050
integer taborder = 70
string dataobject = "d_relacion_email_atendidos"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio=gtr_sce
this.SetTransObject(tr_dw_propio)
end event

event carga;string ls_fecha_inicial, ls_fecha_final
date ldt_fecha_inicial, ldt_fecha_final
datetime ldttm_fecha_inicial, ldttm_fecha_final
integer li_num_registros 

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

type st_2 from statictext within w_email_alumnos_atendidos
integer x = 278
integer y = 211
integer width = 300
integer height = 51
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

type st_1 from statictext within w_email_alumnos_atendidos
integer x = 278
integer y = 96
integer width = 300
integer height = 51
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

type em_fecha_final from u_em within w_email_alumnos_atendidos
integer x = 600
integer y = 195
integer width = 289
integer taborder = 20
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type em_fecha_inicial from u_em within w_email_alumnos_atendidos
integer x = 600
integer y = 80
integer width = 289
integer taborder = 10
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type gb_1 from groupbox within w_email_alumnos_atendidos
integer x = 260
integer y = 13
integer width = 673
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
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_email_alumnos_atendidos
integer x = 1715
integer y = 13
integer width = 673
integer height = 320
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Periodo Entrega"
borderstyle borderstyle = stylelowered!
end type

