$PBExportHeader$w_genera_bloque_cert_sin_status.srw
forward
global type w_genera_bloque_cert_sin_status from w_main
end type
type cbx_actualiza_fechas from checkbox within w_genera_bloque_cert_sin_status
end type
type cb_1 from u_cb within w_genera_bloque_cert_sin_status
end type
type rb_ambos_origen from radiobutton within w_genera_bloque_cert_sin_status
end type
type rb_ventanilla from radiobutton within w_genera_bloque_cert_sin_status
end type
type rb_internet from radiobutton within w_genera_bloque_cert_sin_status
end type
type rb_ambos_papeleria from radiobutton within w_genera_bloque_cert_sin_status
end type
type rb_simple from radiobutton within w_genera_bloque_cert_sin_status
end type
type rb_legalizado from radiobutton within w_genera_bloque_cert_sin_status
end type
type rb_ambos from radiobutton within w_genera_bloque_cert_sin_status
end type
type rb_posgrado from radiobutton within w_genera_bloque_cert_sin_status
end type
type rb_licenciatura from radiobutton within w_genera_bloque_cert_sin_status
end type
type cb_genera from u_cb within w_genera_bloque_cert_sin_status
end type
type cb_cargar from u_cb within w_genera_bloque_cert_sin_status
end type
type dw_1 from uo_dw_reporte within w_genera_bloque_cert_sin_status
end type
type st_2 from statictext within w_genera_bloque_cert_sin_status
end type
type st_1 from statictext within w_genera_bloque_cert_sin_status
end type
type em_fecha_final from u_em within w_genera_bloque_cert_sin_status
end type
type em_fecha_inicial from u_em within w_genera_bloque_cert_sin_status
end type
type gb_1 from groupbox within w_genera_bloque_cert_sin_status
end type
type gb_3 from groupbox within w_genera_bloque_cert_sin_status
end type
type rb_totales from radiobutton within w_genera_bloque_cert_sin_status
end type
type rb_parciales from radiobutton within w_genera_bloque_cert_sin_status
end type
type rb_todos from radiobutton within w_genera_bloque_cert_sin_status
end type
type gb_2 from groupbox within w_genera_bloque_cert_sin_status
end type
type gb_4 from groupbox within w_genera_bloque_cert_sin_status
end type
end forward

global type w_genera_bloque_cert_sin_status from w_main
integer width = 3104
integer height = 1784
string title = "Generación de Bloque de Certificados (Libre)"
string menuname = "m_menu"
cbx_actualiza_fechas cbx_actualiza_fechas
cb_1 cb_1
rb_ambos_origen rb_ambos_origen
rb_ventanilla rb_ventanilla
rb_internet rb_internet
rb_ambos_papeleria rb_ambos_papeleria
rb_simple rb_simple
rb_legalizado rb_legalizado
rb_ambos rb_ambos
rb_posgrado rb_posgrado
rb_licenciatura rb_licenciatura
cb_genera cb_genera
cb_cargar cb_cargar
dw_1 dw_1
st_2 st_2
st_1 st_1
em_fecha_final em_fecha_final
em_fecha_inicial em_fecha_inicial
gb_1 gb_1
gb_3 gb_3
rb_totales rb_totales
rb_parciales rb_parciales
rb_todos rb_todos
gb_2 gb_2
gb_4 gb_4
end type
global w_genera_bloque_cert_sin_status w_genera_bloque_cert_sin_status

type variables
uo_reporte_dw iuo_reporte_dw
string is_nivel= "A"
integer ii_cve_doc_control_sep = 9999
integer ii_legalizado = 9999
integer ii_origen_internet = 9999

n_cortes  in_cortes 


end variables

on w_genera_bloque_cert_sin_status.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cbx_actualiza_fechas=create cbx_actualiza_fechas
this.cb_1=create cb_1
this.rb_ambos_origen=create rb_ambos_origen
this.rb_ventanilla=create rb_ventanilla
this.rb_internet=create rb_internet
this.rb_ambos_papeleria=create rb_ambos_papeleria
this.rb_simple=create rb_simple
this.rb_legalizado=create rb_legalizado
this.rb_ambos=create rb_ambos
this.rb_posgrado=create rb_posgrado
this.rb_licenciatura=create rb_licenciatura
this.cb_genera=create cb_genera
this.cb_cargar=create cb_cargar
this.dw_1=create dw_1
this.st_2=create st_2
this.st_1=create st_1
this.em_fecha_final=create em_fecha_final
this.em_fecha_inicial=create em_fecha_inicial
this.gb_1=create gb_1
this.gb_3=create gb_3
this.rb_totales=create rb_totales
this.rb_parciales=create rb_parciales
this.rb_todos=create rb_todos
this.gb_2=create gb_2
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_actualiza_fechas
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.rb_ambos_origen
this.Control[iCurrent+4]=this.rb_ventanilla
this.Control[iCurrent+5]=this.rb_internet
this.Control[iCurrent+6]=this.rb_ambos_papeleria
this.Control[iCurrent+7]=this.rb_simple
this.Control[iCurrent+8]=this.rb_legalizado
this.Control[iCurrent+9]=this.rb_ambos
this.Control[iCurrent+10]=this.rb_posgrado
this.Control[iCurrent+11]=this.rb_licenciatura
this.Control[iCurrent+12]=this.cb_genera
this.Control[iCurrent+13]=this.cb_cargar
this.Control[iCurrent+14]=this.dw_1
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.st_1
this.Control[iCurrent+17]=this.em_fecha_final
this.Control[iCurrent+18]=this.em_fecha_inicial
this.Control[iCurrent+19]=this.gb_1
this.Control[iCurrent+20]=this.gb_3
this.Control[iCurrent+21]=this.rb_totales
this.Control[iCurrent+22]=this.rb_parciales
this.Control[iCurrent+23]=this.rb_todos
this.Control[iCurrent+24]=this.gb_2
this.Control[iCurrent+25]=this.gb_4
end on

on w_genera_bloque_cert_sin_status.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_actualiza_fechas)
destroy(this.cb_1)
destroy(this.rb_ambos_origen)
destroy(this.rb_ventanilla)
destroy(this.rb_internet)
destroy(this.rb_ambos_papeleria)
destroy(this.rb_simple)
destroy(this.rb_legalizado)
destroy(this.rb_ambos)
destroy(this.rb_posgrado)
destroy(this.rb_licenciatura)
destroy(this.cb_genera)
destroy(this.cb_cargar)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_fecha_final)
destroy(this.em_fecha_inicial)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.rb_totales)
destroy(this.rb_parciales)
destroy(this.rb_todos)
destroy(this.gb_2)
destroy(this.gb_4)
end on

event open;call super::open;iuo_reporte_dw = create uo_reporte_dw
datetime ldttm_fecha_servidor, ldttm_fecha_inicial


if not isvalid(in_cortes) then
	in_cortes = create n_cortes
end if


x=1
y=1


ldttm_fecha_servidor = fecha_servidor(gtr_sce)
ldttm_fecha_inicial = datetime(date("1-jan-2005"))

em_fecha_inicial.text = string(ldttm_fecha_inicial,"dd/mm/yyyy")
em_fecha_final.text =  string(ldttm_fecha_servidor,"dd/mm/yyyy")

end event

event close;call super::close;if isvalid(in_cortes) then
	destroy in_cortes 
end if

if isvalid(iuo_reporte_dw) then
	destroy	iuo_reporte_dw
end if
end event

type cbx_actualiza_fechas from checkbox within w_genera_bloque_cert_sin_status
integer x = 841
integer y = 304
integer width = 805
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Actualiza fechas en Certificados"
boolean checked = true
end type

type cb_1 from u_cb within w_genera_bloque_cert_sin_status
integer x = 1335
integer y = 1488
integer width = 379
integer taborder = 210
string text = "Generar Nuevo"
end type

event clicked;call super::clicked;string ls_fecha_inicial, ls_fecha_final
date ldt_fecha_inicial, ldt_fecha_final
datetime ldttm_fecha_inicial, ldttm_fecha_final
long ll_certificados_generados, ll_certificados_impresos
integer li_aplica_pago = 0, li_egresa_completos = 1, li_actualiza_fechas

if dw_1.Triggerevent("carga") <= 0 then
	MessageBox("Bloque sin datos","No existen solicitudes a generar")
end if

ls_fecha_inicial= em_fecha_inicial.text
ls_fecha_final= em_fecha_final.text

ldt_fecha_inicial =date(ls_fecha_inicial)
ldt_fecha_final =date(ls_fecha_final)

if ldt_fecha_final < ldt_fecha_inicial then
	MessageBox("Error de fechas","La fecha inicial no debe ser mayor a la fecha final")
end if 

ldt_fecha_final= RelativeDate(ldt_fecha_final, +1)
                         
ldttm_fecha_inicial =datetime(ldt_fecha_inicial)
ldttm_fecha_final =datetime(ldt_fecha_final)

//2014-10-13
//2018-01-23
if cbx_actualiza_fechas.checked then
	li_actualiza_fechas = 1
else 
	li_actualiza_fechas = 0
end if
//ll_certificados_generados= iuo_reporte_dw.f_genera_bloque_cert_sin_status(ldttm_fecha_inicial, ldttm_fecha_final,ii_cve_doc_control_sep, is_nivel, ii_legalizado,ii_origen_internet)
ll_certificados_generados= iuo_reporte_dw.f_genera_bloque_cert_sin_status_bd(ldttm_fecha_inicial, ldttm_fecha_final,ii_cve_doc_control_sep, is_nivel, ii_legalizado,ii_origen_internet,1)
if ll_certificados_generados>0 then
	ll_certificados_impresos= iuo_reporte_dw.f_imprime_bloque_cert_sin_status(ldttm_fecha_inicial, ldttm_fecha_final, ii_cve_doc_control_sep, is_nivel, ii_legalizado, ii_origen_internet, li_aplica_pago, li_egresa_completos, li_actualiza_fechas)
	if ll_certificados_impresos>0 then		
		MessageBox("Impresión Finalizada","Se Imprimieron ["+string(ll_certificados_impresos)+"] certificados")
	else
		MessageBox("Impresión Finalizada","No existen certificados a imprimir")		
	end if
else
		MessageBox("No es posible imprimir","No existen certificados a imprimir")		
end if


end event

type rb_ambos_origen from radiobutton within w_genera_bloque_cert_sin_status
integer x = 2203
integer y = 196
integer width = 338
integer height = 64
integer taborder = 180
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ambos"
boolean checked = true
end type

event clicked;ii_origen_internet = 9999
end event

type rb_ventanilla from radiobutton within w_genera_bloque_cert_sin_status
integer x = 2203
integer y = 132
integer width = 338
integer height = 64
integer taborder = 170
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ventanilla"
end type

event clicked;ii_origen_internet = 0
end event

type rb_internet from radiobutton within w_genera_bloque_cert_sin_status
integer x = 2203
integer y = 68
integer width = 338
integer height = 64
integer taborder = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Internet"
end type

event clicked;ii_origen_internet = 1
end event

type rb_ambos_papeleria from radiobutton within w_genera_bloque_cert_sin_status
integer x = 1774
integer y = 196
integer width = 338
integer height = 64
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ambos"
boolean checked = true
end type

event clicked;ii_legalizado = 9999
end event

type rb_simple from radiobutton within w_genera_bloque_cert_sin_status
integer x = 1774
integer y = 132
integer width = 325
integer height = 64
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Simple"
end type

event clicked;ii_legalizado = 0
end event

type rb_legalizado from radiobutton within w_genera_bloque_cert_sin_status
integer x = 1774
integer y = 68
integer width = 338
integer height = 64
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Legalizado"
end type

event clicked;ii_legalizado = 1
end event

type rb_ambos from radiobutton within w_genera_bloque_cert_sin_status
integer x = 841
integer y = 188
integer width = 338
integer height = 64
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ambos"
boolean checked = true
end type

event clicked;is_nivel = "A"
end event

type rb_posgrado from radiobutton within w_genera_bloque_cert_sin_status
integer x = 841
integer y = 124
integer width = 338
integer height = 64
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Posgrado"
end type

event clicked;is_nivel = "P"
end event

type rb_licenciatura from radiobutton within w_genera_bloque_cert_sin_status
integer x = 841
integer y = 60
integer width = 366
integer height = 64
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Licenciatura"
end type

event clicked;is_nivel = "L"
end event

type cb_genera from u_cb within w_genera_bloque_cert_sin_status
boolean visible = false
integer x = 1413
integer y = 1460
integer taborder = 200
string text = "Generar"
end type

event clicked;call super::clicked;string ls_fecha_inicial, ls_fecha_final
date ldt_fecha_inicial, ldt_fecha_final
datetime ldttm_fecha_inicial, ldttm_fecha_final
long ll_certificados_generados, ll_certificados_impresos
integer li_aplica_pago = 0, li_egresa_completos = 1, li_actualiza_fechas

if dw_1.Triggerevent("carga") <= 0 then
	MessageBox("Bloque sin datos","No existen solicitudes a generar")
end if

ls_fecha_inicial= em_fecha_inicial.text
ls_fecha_final= em_fecha_final.text

ldt_fecha_inicial =date(ls_fecha_inicial)
ldt_fecha_final =date(ls_fecha_final)

if ldt_fecha_final < ldt_fecha_inicial then
	MessageBox("Error de fechas","La fecha inicial no debe ser mayor a la fecha final")
end if 

ldt_fecha_final= RelativeDate(ldt_fecha_final, +1)
                         
ldttm_fecha_inicial =datetime(ldt_fecha_inicial)
ldttm_fecha_final =datetime(ldt_fecha_final)
//2018-01-23
if cbx_actualiza_fechas.checked then
	li_actualiza_fechas = 1
else 
	li_actualiza_fechas = 0
end if

ll_certificados_generados= iuo_reporte_dw.f_genera_bloque_cert_sin_status(ldttm_fecha_inicial, ldttm_fecha_final,ii_cve_doc_control_sep, is_nivel, ii_legalizado,ii_origen_internet)
if ll_certificados_generados>0 then
	ll_certificados_impresos= iuo_reporte_dw.f_imprime_bloque_cert_sin_status(ldttm_fecha_inicial, ldttm_fecha_final, ii_cve_doc_control_sep, is_nivel, ii_legalizado, ii_origen_internet, li_aplica_pago, li_egresa_completos, li_actualiza_fechas)
	if ll_certificados_impresos>0 then		
		MessageBox("Impresión Finalizada","Se Imprimieron ["+string(ll_certificados_impresos)+"] certificados")
	else
		MessageBox("Impresión Finalizada","No existen certificados a imprimir")		
	end if
else
		MessageBox("No es posible imprimir","No existen certificados a imprimir")		
end if


end event

type cb_cargar from u_cb within w_genera_bloque_cert_sin_status
integer x = 2624
integer y = 96
integer taborder = 190
string text = "Cargar"
end type

event clicked;call super::clicked;dw_1.Triggerevent("carga")

end event

type dw_1 from uo_dw_reporte within w_genera_bloque_cert_sin_status
integer x = 101
integer y = 420
integer width = 2843
integer height = 1052
integer taborder = 210
string dataobject = "d_reporte_bloque_cert_sin_status"
boolean hscrollbar = true
boolean resizable = true
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
	MessageBox("Error de fechas","La fecha inicial no debe ser mayor a la fecha final")
end if 



ldt_fecha_final= RelativeDate(ldt_fecha_final, +1)

ldttm_fecha_inicial =datetime(ldt_fecha_inicial)
ldttm_fecha_final =datetime(ldt_fecha_final)

li_num_registros= dw_1.retrieve(ldttm_fecha_inicial, ldttm_fecha_final,ii_cve_doc_control_sep,is_nivel, ii_legalizado, ii_origen_internet)

return li_num_registros



end event

type st_2 from statictext within w_genera_bloque_cert_sin_status
integer x = 110
integer y = 200
integer width = 306
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

type st_1 from statictext within w_genera_bloque_cert_sin_status
integer x = 110
integer y = 84
integer width = 306
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

type em_fecha_final from u_em within w_genera_bloque_cert_sin_status
integer x = 434
integer y = 184
integer width = 320
integer height = 84
integer taborder = 20
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type em_fecha_inicial from u_em within w_genera_bloque_cert_sin_status
integer x = 434
integer y = 68
integer width = 320
integer height = 84
integer taborder = 10
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type gb_1 from groupbox within w_genera_bloque_cert_sin_status
integer x = 809
integer y = 12
integer width = 439
integer height = 272
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "Icon!"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nivel"
end type

type gb_3 from groupbox within w_genera_bloque_cert_sin_status
integer x = 1733
integer y = 12
integer width = 393
integer height = 272
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "Arrow!"
long textcolor = 33554432
long backcolor = 67108864
string text = "Papelería"
end type

type rb_totales from radiobutton within w_genera_bloque_cert_sin_status
integer x = 1326
integer y = 68
integer width = 338
integer height = 64
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Totales"
end type

event clicked;ii_cve_doc_control_sep = 1
end event

type rb_parciales from radiobutton within w_genera_bloque_cert_sin_status
integer x = 1326
integer y = 132
integer width = 338
integer height = 64
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Parciales"
end type

event clicked;ii_cve_doc_control_sep = 2
end event

type rb_todos from radiobutton within w_genera_bloque_cert_sin_status
integer x = 1326
integer y = 196
integer width = 338
integer height = 64
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Todos"
boolean checked = true
end type

event clicked;ii_cve_doc_control_sep = 9999
end event

type gb_2 from groupbox within w_genera_bloque_cert_sin_status
integer x = 1289
integer y = 12
integer width = 384
integer height = 272
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "Arrow!"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo."
end type

type gb_4 from groupbox within w_genera_bloque_cert_sin_status
integer x = 2185
integer y = 8
integer width = 393
integer height = 272
integer taborder = 150
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "Arrow!"
long textcolor = 33554432
long backcolor = 67108864
string text = "Origen"
end type

