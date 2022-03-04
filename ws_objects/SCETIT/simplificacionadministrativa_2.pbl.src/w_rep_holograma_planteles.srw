$PBExportHeader$w_rep_holograma_planteles.srw
forward
global type w_rep_holograma_planteles from Window
end type
type rb_anterior from radiobutton within w_rep_holograma_planteles
end type
type rb_nuevo from radiobutton within w_rep_holograma_planteles
end type
type st_plantel from statictext within w_rep_holograma_planteles
end type
type st_3 from statictext within w_rep_holograma_planteles
end type
type st_2 from statictext within w_rep_holograma_planteles
end type
type st_fecha from statictext within w_rep_holograma_planteles
end type
type em_fecha from editmask within w_rep_holograma_planteles
end type
type st_folio_acta from statictext within w_rep_holograma_planteles
end type
type st_1 from statictext within w_rep_holograma_planteles
end type
type uo_1 from uo_orden_cobro within w_rep_holograma_planteles
end type
type dw_1 from uo_dw_captura_holograma within w_rep_holograma_planteles
end type
type gb_formato from groupbox within w_rep_holograma_planteles
end type
end forward

global type w_rep_holograma_planteles from Window
int X=1057
int Y=483
int Width=3584
int Height=1965
boolean TitleBar=true
string Title="Reporte de Hologramas / Titulación (PLANTELES)"
string MenuName="m_menu_rep_hologramas"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
rb_anterior rb_anterior
rb_nuevo rb_nuevo
st_plantel st_plantel
st_3 st_3
st_2 st_2
st_fecha st_fecha
em_fecha em_fecha
st_folio_acta st_folio_acta
st_1 st_1
uo_1 uo_1
dw_1 dw_1
gb_formato gb_formato
end type
global w_rep_holograma_planteles w_rep_holograma_planteles

type variables
long il_folio_acta
integer ii_cve_doc_control_sep
boolean ib_nuevo= false
end variables

on w_rep_holograma_planteles.create
if this.MenuName = "m_menu_rep_hologramas" then this.MenuID = create m_menu_rep_hologramas
this.rb_anterior=create rb_anterior
this.rb_nuevo=create rb_nuevo
this.st_plantel=create st_plantel
this.st_3=create st_3
this.st_2=create st_2
this.st_fecha=create st_fecha
this.em_fecha=create em_fecha
this.st_folio_acta=create st_folio_acta
this.st_1=create st_1
this.uo_1=create uo_1
this.dw_1=create dw_1
this.gb_formato=create gb_formato
this.Control[]={this.rb_anterior,&
this.rb_nuevo,&
this.st_plantel,&
this.st_3,&
this.st_2,&
this.st_fecha,&
this.em_fecha,&
this.st_folio_acta,&
this.st_1,&
this.uo_1,&
this.dw_1,&
this.gb_formato}
end on

on w_rep_holograma_planteles.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_anterior)
destroy(this.rb_nuevo)
destroy(this.st_plantel)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_fecha)
destroy(this.em_fecha)
destroy(this.st_folio_acta)
destroy(this.st_1)
destroy(this.uo_1)
destroy(this.dw_1)
destroy(this.gb_formato)
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

type rb_anterior from radiobutton within w_rep_holograma_planteles
int X=2948
int Y=115
int Width=300
int Height=77
string Text="Anterior"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataobject = 'd_rep_holograma_planteles'
dw_1.SetTransObject(gtr_sce)
ib_nuevo = false
end event

type rb_nuevo from radiobutton within w_rep_holograma_planteles
int X=3251
int Y=115
int Width=252
int Height=77
string Text="Nuevo"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataobject = 'd_rep_holograma_plant_jul'
dw_1.SetTransObject(gtr_sce)
ib_nuevo= true
end event

type st_plantel from statictext within w_rep_holograma_planteles
int X=1488
int Y=106
int Width=607
int Height=99
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_rep_holograma_planteles
int X=1273
int Y=115
int Width=223
int Height=77
boolean Enabled=false
string Text="Plantel:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_rep_holograma_planteles
int X=2417
int Y=32
int Width=344
int Height=61
boolean Enabled=false
string Text="dd/mm/aaaa"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_fecha from statictext within w_rep_holograma_planteles
int X=2194
int Y=115
int Width=201
int Height=77
boolean Enabled=false
string Text="Fecha:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_fecha from editmask within w_rep_holograma_planteles
int X=2421
int Y=106
int Width=336
int Height=99
int TabOrder=20
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="dd/mm/yyyy"
MaskDataType MaskDataType=DateMask!
long TextColor=33554432
long BackColor=15793151
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_folio_acta from statictext within w_rep_holograma_planteles
int X=633
int Y=138
int Width=453
int Height=99
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_rep_holograma_planteles
int X=69
int Y=147
int Width=567
int Height=77
boolean Enabled=false
string Text="Acta Autenticación:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_1 from uo_orden_cobro within w_rep_holograma_planteles
int X=51
int Y=13
int Height=106
int TabOrder=10
boolean Border=false
BorderStyle BorderStyle=StyleBox!
long BackColor=79741120
end type

on uo_1.destroy
call uo_orden_cobro::destroy
end on

type dw_1 from uo_dw_captura_holograma within w_rep_holograma_planteles
int X=37
int Y=269
int Width=3471
int Height=1363
int TabOrder=30
string DataObject="d_rep_holograma_planteles"
boolean HScrollBar=true
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
string ls_plantel

if rowcount > 0 then

	SetNull(ll_folio_acta)

	FOR ll_row_actual= 1 TO rowcount
		ll_folio_acta = this.GetItemNumber(ll_row_actual,"control_sep_folio_acta")
		ls_plantel = this.GetItemString(ll_row_actual,"planteles_plantel")
		li_cve_doc_control_sep[ll_row_actual]= this.GetItemNumber(ll_row_actual,"control_sep_planteles_cve_doc_control_se")
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
	st_plantel.text = Mid(ls_plantel, POS(ls_plantel,"EL") + 3 )
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

type gb_formato from groupbox within w_rep_holograma_planteles
int X=2918
int Y=61
int Width=600
int Height=150
int TabOrder=20
string Text="Formato"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

