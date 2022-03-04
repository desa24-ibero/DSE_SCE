$PBExportHeader$w_recibo_documentos_certificacion_2013.srw
forward
global type w_recibo_documentos_certificacion_2013 from window
end type
type cbx_licenciatura_pliego from checkbox within w_recibo_documentos_certificacion_2013
end type
type dw_recibo_documentos from datawindow within w_recibo_documentos_certificacion_2013
end type
type cb_cancel from commandbutton within w_recibo_documentos_certificacion_2013
end type
type cb_ok from commandbutton within w_recibo_documentos_certificacion_2013
end type
type cbx_pliego_reval_tot_licenciatura from checkbox within w_recibo_documentos_certificacion_2013
end type
type cbx_tit_mae_copia_certificada from checkbox within w_recibo_documentos_certificacion_2013
end type
type cbx_tit_mae_copia_notariada from checkbox within w_recibo_documentos_certificacion_2013
end type
type cbx_tit_mae_copia_cotejada from checkbox within w_recibo_documentos_certificacion_2013
end type
type cbx_ced_lic_copia_certificada from checkbox within w_recibo_documentos_certificacion_2013
end type
type cbx_ced_lic_copia_notariada from checkbox within w_recibo_documentos_certificacion_2013
end type
type cbx_ced_lic_copia_cotejada from checkbox within w_recibo_documentos_certificacion_2013
end type
type cbx_tit_lic_copia_certificada from checkbox within w_recibo_documentos_certificacion_2013
end type
type cbx_tit_lic_copia_notariada from checkbox within w_recibo_documentos_certificacion_2013
end type
type cbx_tit_lic_copia_cotejada from checkbox within w_recibo_documentos_certificacion_2013
end type
type cbx_bachillerato_pliego from checkbox within w_recibo_documentos_certificacion_2013
end type
type cbx_bachillerato_certificado from checkbox within w_recibo_documentos_certificacion_2013
end type
type cbx_acta_nac_extranjera from checkbox within w_recibo_documentos_certificacion_2013
end type
type gb_7 from groupbox within w_recibo_documentos_certificacion_2013
end type
type gb_6 from groupbox within w_recibo_documentos_certificacion_2013
end type
type gb_5 from groupbox within w_recibo_documentos_certificacion_2013
end type
type gb_4 from groupbox within w_recibo_documentos_certificacion_2013
end type
type gb_2 from groupbox within w_recibo_documentos_certificacion_2013
end type
type cbx_acta_nac_mexicana from checkbox within w_recibo_documentos_certificacion_2013
end type
end forward

global type w_recibo_documentos_certificacion_2013 from window
integer x = 846
integer y = 372
integer width = 2505
integer height = 1024
boolean titlebar = true
string title = "Recibo de documentos"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 16777215
cbx_licenciatura_pliego cbx_licenciatura_pliego
dw_recibo_documentos dw_recibo_documentos
cb_cancel cb_cancel
cb_ok cb_ok
cbx_pliego_reval_tot_licenciatura cbx_pliego_reval_tot_licenciatura
cbx_tit_mae_copia_certificada cbx_tit_mae_copia_certificada
cbx_tit_mae_copia_notariada cbx_tit_mae_copia_notariada
cbx_tit_mae_copia_cotejada cbx_tit_mae_copia_cotejada
cbx_ced_lic_copia_certificada cbx_ced_lic_copia_certificada
cbx_ced_lic_copia_notariada cbx_ced_lic_copia_notariada
cbx_ced_lic_copia_cotejada cbx_ced_lic_copia_cotejada
cbx_tit_lic_copia_certificada cbx_tit_lic_copia_certificada
cbx_tit_lic_copia_notariada cbx_tit_lic_copia_notariada
cbx_tit_lic_copia_cotejada cbx_tit_lic_copia_cotejada
cbx_bachillerato_pliego cbx_bachillerato_pliego
cbx_bachillerato_certificado cbx_bachillerato_certificado
cbx_acta_nac_extranjera cbx_acta_nac_extranjera
gb_7 gb_7
gb_6 gb_6
gb_5 gb_5
gb_4 gb_4
gb_2 gb_2
cbx_acta_nac_mexicana cbx_acta_nac_mexicana
end type
global w_recibo_documentos_certificacion_2013 w_recibo_documentos_certificacion_2013

type variables
long il_cuenta
end variables

on w_recibo_documentos_certificacion_2013.create
this.cbx_licenciatura_pliego=create cbx_licenciatura_pliego
this.dw_recibo_documentos=create dw_recibo_documentos
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.cbx_pliego_reval_tot_licenciatura=create cbx_pliego_reval_tot_licenciatura
this.cbx_tit_mae_copia_certificada=create cbx_tit_mae_copia_certificada
this.cbx_tit_mae_copia_notariada=create cbx_tit_mae_copia_notariada
this.cbx_tit_mae_copia_cotejada=create cbx_tit_mae_copia_cotejada
this.cbx_ced_lic_copia_certificada=create cbx_ced_lic_copia_certificada
this.cbx_ced_lic_copia_notariada=create cbx_ced_lic_copia_notariada
this.cbx_ced_lic_copia_cotejada=create cbx_ced_lic_copia_cotejada
this.cbx_tit_lic_copia_certificada=create cbx_tit_lic_copia_certificada
this.cbx_tit_lic_copia_notariada=create cbx_tit_lic_copia_notariada
this.cbx_tit_lic_copia_cotejada=create cbx_tit_lic_copia_cotejada
this.cbx_bachillerato_pliego=create cbx_bachillerato_pliego
this.cbx_bachillerato_certificado=create cbx_bachillerato_certificado
this.cbx_acta_nac_extranjera=create cbx_acta_nac_extranjera
this.gb_7=create gb_7
this.gb_6=create gb_6
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_2=create gb_2
this.cbx_acta_nac_mexicana=create cbx_acta_nac_mexicana
this.Control[]={this.cbx_licenciatura_pliego,&
this.dw_recibo_documentos,&
this.cb_cancel,&
this.cb_ok,&
this.cbx_pliego_reval_tot_licenciatura,&
this.cbx_tit_mae_copia_certificada,&
this.cbx_tit_mae_copia_notariada,&
this.cbx_tit_mae_copia_cotejada,&
this.cbx_ced_lic_copia_certificada,&
this.cbx_ced_lic_copia_notariada,&
this.cbx_ced_lic_copia_cotejada,&
this.cbx_tit_lic_copia_certificada,&
this.cbx_tit_lic_copia_notariada,&
this.cbx_tit_lic_copia_cotejada,&
this.cbx_bachillerato_pliego,&
this.cbx_bachillerato_certificado,&
this.cbx_acta_nac_extranjera,&
this.gb_7,&
this.gb_6,&
this.gb_5,&
this.gb_4,&
this.gb_2,&
this.cbx_acta_nac_mexicana}
end on

on w_recibo_documentos_certificacion_2013.destroy
destroy(this.cbx_licenciatura_pliego)
destroy(this.dw_recibo_documentos)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.cbx_pliego_reval_tot_licenciatura)
destroy(this.cbx_tit_mae_copia_certificada)
destroy(this.cbx_tit_mae_copia_notariada)
destroy(this.cbx_tit_mae_copia_cotejada)
destroy(this.cbx_ced_lic_copia_certificada)
destroy(this.cbx_ced_lic_copia_notariada)
destroy(this.cbx_ced_lic_copia_cotejada)
destroy(this.cbx_tit_lic_copia_certificada)
destroy(this.cbx_tit_lic_copia_notariada)
destroy(this.cbx_tit_lic_copia_cotejada)
destroy(this.cbx_bachillerato_pliego)
destroy(this.cbx_bachillerato_certificado)
destroy(this.cbx_acta_nac_extranjera)
destroy(this.gb_7)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.cbx_acta_nac_mexicana)
end on

event open;il_cuenta = Message.DoubleParm
dw_recibo_documentos.SetTransObject(gtr_sce)

end event

type cbx_licenciatura_pliego from checkbox within w_recibo_documentos_certificacion_2013
integer x = 123
integer y = 616
integer width = 709
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Pliego Licenciatura"
boolean lefttext = true
end type

type dw_recibo_documentos from datawindow within w_recibo_documentos_certificacion_2013
integer x = 101
integer y = 748
integer width = 539
integer height = 40
integer taborder = 60
string dataobject = "d_recibo_documentos_certificacion"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_cancel from commandbutton within w_recibo_documentos_certificacion_2013
integer x = 389
integer y = 812
integer width = 251
integer height = 108
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancelar"
end type

event clicked;close(parent)
end event

type cb_ok from commandbutton within w_recibo_documentos_certificacion_2013
integer x = 101
integer y = 812
integer width = 251
integer height = 108
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Aceptar"
end type

event clicked;long ll_rows
ll_rows = dw_recibo_documentos.Retrieve(il_cuenta)
if ll_rows = 1 then
	if cbx_acta_nac_mexicana.checked = true then dw_recibo_documentos.Modify("r_acta_nac_mexicana.Brush.Color=12632256")
	if cbx_acta_nac_extranjera.checked = true then dw_recibo_documentos.Modify("r_acta_nac_extranjera.Brush.Color=12632256")
	if cbx_bachillerato_certificado.checked = true then dw_recibo_documentos.Modify("r_bachillerato_certificado.Brush.Color=12632256")
	if cbx_bachillerato_pliego.checked = true then dw_recibo_documentos.Modify("r_bachillerato_pliego.Brush.Color=12632256")
	if cbx_licenciatura_pliego.checked = true then dw_recibo_documentos.Modify("r_licenciatura_pliego.Brush.Color=12632256")
//	if cbx_9.checked = true then dw_recibo_documentos.Modify("r_9.Brush.Color=12632256")
	if cbx_tit_lic_copia_cotejada.checked = true then dw_recibo_documentos.Modify("r_tit_lic_copia_cotejada.Brush.Color=12632256")
	if cbx_tit_lic_copia_notariada.checked = true then dw_recibo_documentos.Modify("r_tit_lic_copia_notariada.Brush.Color=12632256")
	if cbx_tit_lic_copia_certificada.checked = true then dw_recibo_documentos.Modify("r_tit_lic_copia_certificada.Brush.Color=12632256")
	if cbx_ced_lic_copia_cotejada.checked = true then dw_recibo_documentos.Modify("r_ced_lic_copia_cotejada.Brush.Color=12632256")
	if cbx_ced_lic_copia_notariada.checked = true then dw_recibo_documentos.Modify("r_ced_lic_copia_notariada.Brush.Color=12632256")
	if cbx_ced_lic_copia_certificada.checked = true then dw_recibo_documentos.Modify("r_ced_lic_copia_certificada.Brush.Color=12632256")
	if cbx_pliego_reval_tot_licenciatura.checked = true then dw_recibo_documentos.Modify("r_pliego_reval_tot_licenciatura.Brush.Color=12632256")
	if cbx_tit_mae_copia_cotejada.checked = true then dw_recibo_documentos.Modify("r_tit_mae_copia_cotejada.Brush.Color=12632256")
	if cbx_tit_mae_copia_notariada.checked = true then dw_recibo_documentos.Modify("r_tit_mae_copia_notariada.Brush.Color=12632256")
	if cbx_tit_mae_copia_certificada.checked = true then dw_recibo_documentos.Modify("r_tit_mae_copia_certificada.Brush.Color=12632256")
		dw_recibo_documentos.modify("Datawindow.print.preview = Yes")
	SetPointer(HourGlass!)
	openwithparm(conf_impr,dw_recibo_documentos)
	close(parent)
else
	MessageBox("Aviso","No se puede generar el recibo de documentos de la cuenta "+&
					string(il_cuenta)+"-"+obten_digito(il_cuenta))
end if
end event

type cbx_pliego_reval_tot_licenciatura from checkbox within w_recibo_documentos_certificacion_2013
integer x = 1161
integer y = 24
integer width = 1248
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "Pliego de Revalidación Total de Licenciatura"
boolean lefttext = true
end type

type cbx_tit_mae_copia_certificada from checkbox within w_recibo_documentos_certificacion_2013
integer x = 1874
integer y = 320
integer width = 526
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Certificada"
boolean lefttext = true
end type

type cbx_tit_mae_copia_notariada from checkbox within w_recibo_documentos_certificacion_2013
integer x = 1874
integer y = 256
integer width = 526
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Notariada"
boolean lefttext = true
end type

type cbx_tit_mae_copia_cotejada from checkbox within w_recibo_documentos_certificacion_2013
integer x = 1874
integer y = 192
integer width = 526
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Copia Cotejada"
boolean lefttext = true
end type

type cbx_ced_lic_copia_certificada from checkbox within w_recibo_documentos_certificacion_2013
integer x = 1047
integer y = 616
integer width = 526
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Certificada"
boolean lefttext = true
end type

type cbx_ced_lic_copia_notariada from checkbox within w_recibo_documentos_certificacion_2013
integer x = 1047
integer y = 552
integer width = 526
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Notariada"
boolean lefttext = true
end type

type cbx_ced_lic_copia_cotejada from checkbox within w_recibo_documentos_certificacion_2013
integer x = 1047
integer y = 488
integer width = 526
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Copia Cotejada"
boolean lefttext = true
end type

type cbx_tit_lic_copia_certificada from checkbox within w_recibo_documentos_certificacion_2013
integer x = 1047
integer y = 316
integer width = 526
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Certificada"
boolean lefttext = true
end type

type cbx_tit_lic_copia_notariada from checkbox within w_recibo_documentos_certificacion_2013
integer x = 1047
integer y = 252
integer width = 526
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Notariada"
boolean lefttext = true
end type

type cbx_tit_lic_copia_cotejada from checkbox within w_recibo_documentos_certificacion_2013
integer x = 1047
integer y = 188
integer width = 526
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Copia cotejada"
boolean lefttext = true
end type

type cbx_bachillerato_pliego from checkbox within w_recibo_documentos_certificacion_2013
integer x = 123
integer y = 552
integer width = 709
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Pliego Bachillerato"
boolean lefttext = true
end type

type cbx_bachillerato_certificado from checkbox within w_recibo_documentos_certificacion_2013
integer x = 123
integer y = 488
integer width = 709
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Certificado Bachillerato"
boolean lefttext = true
end type

type cbx_acta_nac_extranjera from checkbox within w_recibo_documentos_certificacion_2013
integer x = 123
integer y = 268
integer width = 709
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Extranjera"
boolean lefttext = true
end type

type gb_7 from groupbox within w_recibo_documentos_certificacion_2013
integer x = 1819
integer y = 128
integer width = 631
integer height = 280
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Titulo Maestria"
end type

type gb_6 from groupbox within w_recibo_documentos_certificacion_2013
integer x = 992
integer y = 432
integer width = 631
integer height = 280
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Cédula Licenciatura"
end type

type gb_5 from groupbox within w_recibo_documentos_certificacion_2013
integer x = 992
integer y = 128
integer width = 631
integer height = 280
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Titulo Licenciatura"
end type

type gb_4 from groupbox within w_recibo_documentos_certificacion_2013
integer x = 78
integer y = 432
integer width = 805
integer height = 280
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Antecedentes"
end type

type gb_2 from groupbox within w_recibo_documentos_certificacion_2013
integer x = 78
integer y = 128
integer width = 805
integer height = 232
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Acta Nacimiento"
end type

type cbx_acta_nac_mexicana from checkbox within w_recibo_documentos_certificacion_2013
integer x = 123
integer y = 192
integer width = 709
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Mexicana"
boolean lefttext = true
end type

