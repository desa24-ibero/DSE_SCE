$PBExportHeader$w_recibo_documentos_certificacion.srw
forward
global type w_recibo_documentos_certificacion from Window
end type
type cbx_licenciatura_pliego from checkbox within w_recibo_documentos_certificacion
end type
type dw_recibo_documentos from datawindow within w_recibo_documentos_certificacion
end type
type cb_cancel from commandbutton within w_recibo_documentos_certificacion
end type
type cb_ok from commandbutton within w_recibo_documentos_certificacion
end type
type cbx_pliego_reval_tot_licenciatura from checkbox within w_recibo_documentos_certificacion
end type
type cbx_tit_mae_copia_certificada from checkbox within w_recibo_documentos_certificacion
end type
type cbx_tit_mae_copia_notariada from checkbox within w_recibo_documentos_certificacion
end type
type cbx_tit_mae_copia_cotejada from checkbox within w_recibo_documentos_certificacion
end type
type cbx_ced_lic_copia_certificada from checkbox within w_recibo_documentos_certificacion
end type
type cbx_ced_lic_copia_notariada from checkbox within w_recibo_documentos_certificacion
end type
type cbx_ced_lic_copia_cotejada from checkbox within w_recibo_documentos_certificacion
end type
type cbx_tit_lic_copia_certificada from checkbox within w_recibo_documentos_certificacion
end type
type cbx_tit_lic_copia_notariada from checkbox within w_recibo_documentos_certificacion
end type
type cbx_tit_lic_copia_cotejada from checkbox within w_recibo_documentos_certificacion
end type
type cbx_bachillerato_pliego from checkbox within w_recibo_documentos_certificacion
end type
type cbx_bachillerato_certificado from checkbox within w_recibo_documentos_certificacion
end type
type cbx_acta_nac_extranjera from checkbox within w_recibo_documentos_certificacion
end type
type gb_7 from groupbox within w_recibo_documentos_certificacion
end type
type gb_6 from groupbox within w_recibo_documentos_certificacion
end type
type gb_5 from groupbox within w_recibo_documentos_certificacion
end type
type gb_4 from groupbox within w_recibo_documentos_certificacion
end type
type gb_2 from groupbox within w_recibo_documentos_certificacion
end type
type cbx_acta_nac_mexicana from checkbox within w_recibo_documentos_certificacion
end type
end forward

global type w_recibo_documentos_certificacion from Window
int X=845
int Y=371
int Width=2505
int Height=1024
boolean TitleBar=true
string Title="Recibo de documentos"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
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
global w_recibo_documentos_certificacion w_recibo_documentos_certificacion

type variables
long il_cuenta
end variables

on w_recibo_documentos_certificacion.create
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

on w_recibo_documentos_certificacion.destroy
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
//MessageBox("",string(il_cuenta))
dw_recibo_documentos.SetTransObject(gtr_sce)
//if w_documentos.cbx_alumno.checked = true then
//	dw_recibo_documentos.DataObject = 'd_recibo_documentos_certificacion'
//	dw_recibo_documentos.SetTransObject(gtr_sce)
//else
//	dw_recibo_documentos.DataObject = 'd_recibo_documentos_certificacion'
//	dw_recibo_documentos.SetTransObject(gtr_sadm)
//end if
//
end event

type cbx_licenciatura_pliego from checkbox within w_recibo_documentos_certificacion
int X=117
int Y=595
int Width=552
int Height=77
string Text="Pliego Licenciatura"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_recibo_documentos from datawindow within w_recibo_documentos_certificacion
int X=102
int Y=749
int Width=538
int Height=38
int TabOrder=60
string DataObject="d_recibo_documentos_certificacion"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type cb_cancel from commandbutton within w_recibo_documentos_certificacion
int X=388
int Y=810
int Width=252
int Height=106
int TabOrder=80
string Text="Cancelar"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_ok from commandbutton within w_recibo_documentos_certificacion
int X=102
int Y=810
int Width=252
int Height=106
int TabOrder=70
string Text="Aceptar"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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

type cbx_pliego_reval_tot_licenciatura from checkbox within w_recibo_documentos_certificacion
int X=1313
int Y=22
int Width=1039
int Height=58
string Text="Pliego de Revalidación Total de Licenciatura"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_tit_mae_copia_certificada from checkbox within w_recibo_documentos_certificacion
int X=1872
int Y=278
int Width=450
int Height=77
string Text="Certificada"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_tit_mae_copia_notariada from checkbox within w_recibo_documentos_certificacion
int X=1872
int Y=214
int Width=450
int Height=77
string Text="Notariada"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_tit_mae_copia_cotejada from checkbox within w_recibo_documentos_certificacion
int X=1872
int Y=154
int Width=450
int Height=77
string Text="Copia Cotejada"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_ced_lic_copia_certificada from checkbox within w_recibo_documentos_certificacion
int X=1042
int Y=595
int Width=450
int Height=77
string Text="Certificada"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_ced_lic_copia_notariada from checkbox within w_recibo_documentos_certificacion
int X=1042
int Y=531
int Width=450
int Height=77
string Text="Notariada"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_ced_lic_copia_cotejada from checkbox within w_recibo_documentos_certificacion
int X=1042
int Y=467
int Width=450
int Height=77
string Text="Copia Cotejada"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_tit_lic_copia_certificada from checkbox within w_recibo_documentos_certificacion
int X=1046
int Y=278
int Width=450
int Height=77
string Text="Certificada"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_tit_lic_copia_notariada from checkbox within w_recibo_documentos_certificacion
int X=1046
int Y=214
int Width=450
int Height=77
string Text="Notariada"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_tit_lic_copia_cotejada from checkbox within w_recibo_documentos_certificacion
int X=1046
int Y=154
int Width=450
int Height=77
string Text="Copia cotejada"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_bachillerato_pliego from checkbox within w_recibo_documentos_certificacion
int X=117
int Y=531
int Width=552
int Height=77
string Text="Pliego Bachillerato"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_bachillerato_certificado from checkbox within w_recibo_documentos_certificacion
int X=117
int Y=467
int Width=552
int Height=77
string Text="Certificado Bachillerato"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_acta_nac_extranjera from checkbox within w_recibo_documentos_certificacion
int X=110
int Y=234
int Width=552
int Height=42
string Text="Extranjera"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_7 from groupbox within w_recibo_documentos_certificacion
int X=1821
int Y=99
int Width=538
int Height=278
int TabOrder=50
string Text="Titulo Maestria"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_6 from groupbox within w_recibo_documentos_certificacion
int X=991
int Y=413
int Width=538
int Height=278
int TabOrder=40
string Text="Cédula Licenciatura"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_5 from groupbox within w_recibo_documentos_certificacion
int X=991
int Y=93
int Width=538
int Height=278
int TabOrder=30
string Text="Titulo Licenciatura"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_4 from groupbox within w_recibo_documentos_certificacion
int X=77
int Y=413
int Width=633
int Height=278
int TabOrder=20
string Text="Antecedentes"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_recibo_documentos_certificacion
int X=77
int Y=93
int Width=633
int Height=221
int TabOrder=10
string Text="Acta Nacimiento"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_acta_nac_mexicana from checkbox within w_recibo_documentos_certificacion
int X=110
int Y=154
int Width=552
int Height=77
boolean BringToTop=true
string Text="Mexicana"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

