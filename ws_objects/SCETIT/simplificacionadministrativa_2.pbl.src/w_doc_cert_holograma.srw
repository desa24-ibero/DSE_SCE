$PBExportHeader$w_doc_cert_holograma.srw
forward
global type w_doc_cert_holograma from Window
end type
type st_folio_acta from statictext within w_doc_cert_holograma
end type
type st_1 from statictext within w_doc_cert_holograma
end type
type uo_1 from uo_orden_cobro within w_doc_cert_holograma
end type
type dw_1 from uo_dw_captura_holograma within w_doc_cert_holograma
end type
end forward

global type w_doc_cert_holograma from Window
int X=1057
int Y=483
int Width=3544
int Height=1818
boolean TitleBar=true
string Title="Captura de Hologramas / Certificación"
string MenuName="m_menu_cap_hologramas"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_folio_acta st_folio_acta
st_1 st_1
uo_1 uo_1
dw_1 dw_1
end type
global w_doc_cert_holograma w_doc_cert_holograma

type variables
long il_folio_acta, il_ultimo_folio, il_numeros[]
integer ii_cve_doc_control_sep
end variables

forward prototypes
public function boolean wf_holograma_repetido (long al_num_row, long al_numero, long al_num_holograma)
end prototypes

public function boolean wf_holograma_repetido (long al_num_row, long al_numero, long al_num_holograma);//wf_holograma_repetido
//
//al_num_row					long
//al_numero						long 
//al_num_holograma			long


string ls_orden_cobro
integer li_codigo_sql
string ls_mensaje_sql
long ll_num_holograma, ll_cant_hologramas, ll_num_rows, ll_row_actual, ll_numero

ll_num_rows = dw_1.RowCount()



FOR ll_row_actual = 1 to ll_num_rows
	ll_numero= dw_1.GetItemNumber(al_num_row, "control_sep_numero")
	If (ll_row_actual <>  al_num_row)  then		
		ll_num_holograma= dw_1.GetItemNumber(ll_row_actual, "control_sep_num_holograma")
		If ll_num_holograma= al_num_holograma then
			return true
		End if		
	End if
NEXT


return False


end function

on w_doc_cert_holograma.create
if this.MenuName = "m_menu_cap_hologramas" then this.MenuID = create m_menu_cap_hologramas
this.st_folio_acta=create st_folio_acta
this.st_1=create st_1
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.st_folio_acta,&
this.st_1,&
this.uo_1,&
this.dw_1}
end on

on w_doc_cert_holograma.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_folio_acta)
destroy(this.st_1)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1
end event

type st_folio_acta from statictext within w_doc_cert_holograma
int X=1946
int Y=74
int Width=402
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

type st_1 from statictext within w_doc_cert_holograma
int X=1313
int Y=83
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

type uo_1 from uo_orden_cobro within w_doc_cert_holograma
int X=161
int Y=77
int TabOrder=10
boolean Border=false
BorderStyle BorderStyle=StyleBox!
long BackColor=79741120
end type

on uo_1.destroy
call uo_orden_cobro::destroy
end on

type dw_1 from uo_dw_captura_holograma within w_doc_cert_holograma
int X=26
int Y=269
int Width=3445
int Height=1325
int TabOrder=10
string DataObject="d_doc_cert_holograma"
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

m_menu_cap_hologramas.dw	= this
end event

event ue_carga;string ls_orden_cobro

if isnull(uo_1.em_orden_cobro.text) or uo_1.em_orden_cobro.text= "" or len(uo_1.em_orden_cobro.text)=0 then
	MessageBox("Orden Faltante", "Es necesario escribir la orden de cobro", StopSign!)
	return 0
else
	ls_orden_cobro = uo_1.em_orden_cobro.text
	return retrieve(ls_orden_cobro)
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

if f_existe_holograma_repetido(il_numeros[], ll_num_holograma, false) & 
   or wf_holograma_repetido (ai_num_registro, ll_numero, ll_num_holograma) then
	MessageBox("Holograma Repetido", "El número de holograma escrito se encuentra asignado a alguien mas", StopSign!)
	this.ScrollToRow(ai_num_registro)
	return -1
end if


return 0

end event

event retrieveend;call super::retrieveend;long ll_num_rows, ll_indice, ll_row_actual, ll_folio_acta, ll_numero
integer li_cve_doc_control_sep[], li_respuesta, li_tamanio_lista, li_indice
boolean lb_acta_nula= true
long ll_null

if rowcount > 0 then

	SetNull(ll_folio_acta)
	SetNull(ll_null)
	
	li_tamanio_lista= upperbound(il_numeros[])

	FOR li_indice= 1 TO li_tamanio_lista
		il_numeros[li_indice]= ll_null
	NEXT
	
	FOR ll_row_actual= 1 TO rowcount
		ll_numero= this.GetItemNumber(ll_row_actual,"control_sep_numero")
		il_numeros[ll_row_actual]= ll_numero
	NEXT


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
	
//	if lb_acta_nula then		
//		
		il_ultimo_folio= f_obten_folio_acta(ii_cve_doc_control_sep,17)		
//	end if
//	
//	il_folio_acta=ll_folio_acta
	st_folio_acta.text = string(il_folio_acta)
else
	il_folio_acta= 0
	st_folio_acta.text = string(il_folio_acta)
	MessageBox("Orden Inexistente", "No existen registros para la orden de cobro seleccionada", StopSign!)	
	
end if


end event

event ue_nuevo;return
end event

event ue_actualiza;/*
DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
				Este evento no presenta interacción con el usuario
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/
integer li_resultado_update
long ll_row
AcceptText()
if ModifiedCount()+DeletedCount() > 0 Then
/*Función que solo actualiza*/
	if IsNull(il_folio_acta) or il_folio_acta= 0 then
		il_folio_acta= f_incrementa_folio_acta(ii_cve_doc_control_sep, 17,  il_ultimo_folio)
	end if
	st_folio_acta.text= string(il_folio_acta)
	for ll_row = 1 to this.rowcount()
		this.SetItem(ll_row, "folio_acta", il_folio_acta)
	next
	li_resultado_update = update(true)
	if li_resultado_update = 1 then		
		/*Si es asi, guardalo en la tabla y avisa.*/
		actualizo = 1
		commit using tr_dw_propio;	
		return 1
	else
		actualizo = 0
		/*De lo contrario, desecha los cambios (todos) y avisa*/
		rollback using tr_dw_propio;		
		return -1
	end if
else
	actualizo = 2
	return 1
end if

end event

