$PBExportHeader$w_rep_cert_holograma.srw
forward
global type w_rep_cert_holograma from window
end type
type rb_nuevo from radiobutton within w_rep_cert_holograma
end type
type st_2 from statictext within w_rep_cert_holograma
end type
type st_fecha from statictext within w_rep_cert_holograma
end type
type em_fecha from editmask within w_rep_cert_holograma
end type
type st_folio_acta from statictext within w_rep_cert_holograma
end type
type st_1 from statictext within w_rep_cert_holograma
end type
type uo_1 from uo_orden_cobro within w_rep_cert_holograma
end type
type dw_1 from uo_dw_captura_holograma within w_rep_cert_holograma
end type
type gb_formato from groupbox within w_rep_cert_holograma
end type
type rb_anterior from radiobutton within w_rep_cert_holograma
end type
end forward

global type w_rep_cert_holograma from window
integer x = 1056
integer y = 484
integer width = 3598
integer height = 1964
boolean titlebar = true
string title = "Reporte de Hologramas / Certificación"
string menuname = "m_menu_rep_hologramas"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
rb_nuevo rb_nuevo
st_2 st_2
st_fecha st_fecha
em_fecha em_fecha
st_folio_acta st_folio_acta
st_1 st_1
uo_1 uo_1
dw_1 dw_1
gb_formato gb_formato
rb_anterior rb_anterior
end type
global w_rep_cert_holograma w_rep_cert_holograma

type variables
long il_folio_acta
integer ii_cve_doc_control_sep
boolean ib_nuevo= false
end variables

on w_rep_cert_holograma.create
if this.MenuName = "m_menu_rep_hologramas" then this.MenuID = create m_menu_rep_hologramas
this.rb_nuevo=create rb_nuevo
this.st_2=create st_2
this.st_fecha=create st_fecha
this.em_fecha=create em_fecha
this.st_folio_acta=create st_folio_acta
this.st_1=create st_1
this.uo_1=create uo_1
this.dw_1=create dw_1
this.gb_formato=create gb_formato
this.rb_anterior=create rb_anterior
this.Control[]={this.rb_nuevo,&
this.st_2,&
this.st_fecha,&
this.em_fecha,&
this.st_folio_acta,&
this.st_1,&
this.uo_1,&
this.dw_1,&
this.gb_formato,&
this.rb_anterior}
end on

on w_rep_cert_holograma.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_nuevo)
destroy(this.st_2)
destroy(this.st_fecha)
destroy(this.em_fecha)
destroy(this.st_folio_acta)
destroy(this.st_1)
destroy(this.uo_1)
destroy(this.dw_1)
destroy(this.gb_formato)
destroy(this.rb_anterior)
end on

event open;datetime ldttm_fecha_hoy
date ldt_fecha_hoy
x=1
y=1

ldttm_fecha_hoy = fecha_servidor(gtr_sce)
ldt_fecha_hoy = date(ldttm_fecha_hoy)
em_fecha.text = string(ldt_fecha_hoy)
dw_1.Modify("DataWindow.Print.Preview= Yes")
end event

type rb_nuevo from radiobutton within w_rep_cert_holograma
integer x = 2967
integer y = 116
integer width = 251
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Nuevo"
boolean checked = true
end type

event clicked;dw_1.dataobject = 'd_rep_cert_holograma_2014_05_sin_espacios'
dw_1.SetTransObject(gtr_sce)
ib_nuevo= true
end event

type st_2 from statictext within w_rep_cert_holograma
integer x = 2386
integer y = 32
integer width = 343
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "dd/mm/aaaa"
boolean focusrectangle = false
end type

type st_fecha from statictext within w_rep_cert_holograma
integer x = 2139
integer y = 124
integer width = 233
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Fecha:"
boolean focusrectangle = false
end type

type em_fecha from editmask within w_rep_cert_holograma
integer x = 2405
integer y = 108
integer width = 338
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type st_folio_acta from statictext within w_rep_cert_holograma
integer x = 1687
integer y = 108
integer width = 402
integer height = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_1 from statictext within w_rep_cert_holograma
integer x = 1111
integer y = 116
integer width = 567
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Acta Autenticación:"
boolean focusrectangle = false
end type

type uo_1 from uo_orden_cobro within w_rep_cert_holograma
integer x = 27
integer y = 100
integer height = 108
integer taborder = 10
boolean border = false
long backcolor = 79741120
end type

on uo_1.destroy
call uo_orden_cobro::destroy
end on

type dw_1 from uo_dw_captura_holograma within w_rep_cert_holograma
integer x = 23
integer y = 268
integer width = 3511
integer height = 1364
integer taborder = 30
string dataobject = "d_rep_cert_holograma_jul"
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
tr_dw_propio = create transaction

tr_dw_propio = gtr_sce
dw_1.SetTransObject(gtr_sce)

end event

event ue_asigna_dw_menu;call super::ue_asigna_dw_menu;/*
DESCRIPCIÓN: Evento en el cual se asigna a la variable dw del menu este objeto.
				En este evento se busca la ventana dueña del objeto y cual es su menu
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: CAMP(DkWf)
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/


window ventana_propietaria

ventana_propietaria = getparent()

menu_propietario = ventana_propietaria.menuid

m_menu_rep_hologramas.dw	= this
end event

event ue_carga;string ls_orden_cobro, ls_fecha_simple_en_texto, ls_fecha
date ldt_fecha

if isnull(uo_1.em_orden_cobro.text) or uo_1.em_orden_cobro.text= "" or len(uo_1.em_orden_cobro.text)=0 then
	MessageBox("Orden Faltante", "Es necesario escribir la orden de cobro", StopSign!)
	return 0
else
	if isnull(em_fecha.text) or em_fecha.text= "" or len(em_fecha.text)=0 or not IsDate(em_fecha.text) then
		MessageBox("Fecha Faltante", "Es necesario escribir una fecha valida", StopSign!)
		return 0
	end if
	ls_fecha = em_fecha.text
	ldt_fecha = Date(ls_fecha)
	ls_fecha_simple_en_texto = f_obten_fecha_simple_en_texto(ldt_fecha)
	ls_orden_cobro = uo_1.em_orden_cobro.text
	return retrieve(ls_orden_cobro, ls_fecha_simple_en_texto)
end if



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
	
	if IsNull(il_folio_acta) or il_folio_acta= 0 then
		il_folio_acta= f_incrementa_folio_acta(ii_cve_doc_control_sep, 17,  il_folio_acta)
	end if
	
	st_folio_acta.text= string(il_folio_acta)
	
	if li_respuesta = 1 then
			/*Checa que los renglones cumplan con las reglas de validación*/
			if event ue_actualiza_con_mensaje() = 1 then//Manda llamar la función que realiza el update
				message.longparm = 1
				return message.longparm
			else 
				message.longparm = -1
				return message.longparm
			end if
	else
		/*De lo contrario, solo avisa que no se guardó nada.*/
		messagebox("Información","No se han guardado los cambios")
		message.longparm = -1
		return message.longparm
	end if
else
	return 1
end if
end event

event ue_valida_data_window;//
//DESCRIPCIÓN: Evento en el cual se debe llevar a cabo un proceso de validación 
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
//

long ll_cuenta, ll_cve_doc_control_sep, ll_num_holograma, ll_numero
string ls_orden_cobro

ll_numero= this.GetItemNumber(ai_num_registro, "control_sep_numero")
ll_num_holograma= this.GetItemNumber(ai_num_registro, "control_sep_num_holograma")

if f_existe_holograma(ll_numero, ll_num_holograma) then
	MessageBox("Holograma Repetido", "El número de holograma escrito se encuentra asignado a alguien mas", StopSign!)
	this.ScrollToRow(ai_num_registro)
	return -1
end if

this.SetItem(ai_num_registro, "folio_acta", il_folio_acta)

return 0

end event

event retrieveend;call super::retrieveend;long ll_num_rows, ll_indice, ll_row_actual, ll_folio_acta
integer li_cve_doc_control_sep[], li_respuesta
boolean lb_acta_nula= true

if rowcount > 0 then

	SetNull(ll_folio_acta)

	FOR ll_row_actual= 1 TO rowcount
		ll_folio_acta = this.GetItemNumber(ll_row_actual,"folio_acta")
		li_cve_doc_control_sep[ll_row_actual]= this.GetItemNumber(ll_row_actual,"control_sep_cve_doc_control_sep")
		if not isnull(ll_folio_acta) then
			lb_acta_nula= false
			EXIT 		
		end if
	NEXT

	
	il_folio_acta=ll_folio_acta
	
	ii_cve_doc_control_sep= li_cve_doc_control_sep[1]
	
	if lb_acta_nula then		
		
		ll_folio_acta= f_obten_folio_acta(ii_cve_doc_control_sep,17)		
	end if
	
	il_folio_acta=ll_folio_acta
	st_folio_acta.text = string(il_folio_acta)
else
	il_folio_acta= 0
	st_folio_acta.text = string(il_folio_acta)
	MessageBox("Orden Inexistente", "No existen registros para la orden de cobro seleccionada", StopSign!)	
	
end if


string ls_digito
long ll_cuenta, ll_rowcount
if ib_nuevo then
	ll_rowcount= this.RowCount()
	FOR ll_row_actual= 1 TO ll_rowcount
		ll_cuenta =this.GetItemNumber(ll_row_actual,"control_sep_cuenta")
		ls_digito = obten_digito(ll_cuenta)
		this.SetItem(ll_row_actual, "digito", ls_digito)
	NEXT
end if

end event

type gb_formato from groupbox within w_rep_cert_holograma
integer x = 2935
integer y = 60
integer width = 599
integer height = 152
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Formato"
end type

type rb_anterior from radiobutton within w_rep_cert_holograma
boolean visible = false
integer x = 2967
integer y = 116
integer width = 302
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Anterior"
end type

event clicked;dw_1.dataobject = 'd_rep_cert_holograma'
dw_1.SetTransObject(gtr_sce)
ib_nuevo= false
end event

