$PBExportHeader$w_captura_hologramas.srw
forward
global type w_captura_hologramas from w_main
end type
type st_estatus from statictext within w_captura_hologramas
end type
type em_cve_doc_control_sep from editmask within w_captura_hologramas
end type
type cb_1 from commandbutton within w_captura_hologramas
end type
type st_1 from statictext within w_captura_hologramas
end type
type em_cve_relacion from editmask within w_captura_hologramas
end type
type dw_1 from u_dw_captura within w_captura_hologramas
end type
end forward

global type w_captura_hologramas from w_main
integer width = 3099
integer height = 1816
string title = "Captura de hologramas"
string menuname = "m_menu"
st_estatus st_estatus
em_cve_doc_control_sep em_cve_doc_control_sep
cb_1 cb_1
st_1 st_1
em_cve_relacion em_cve_relacion
dw_1 dw_1
end type
global w_captura_hologramas w_captura_hologramas

on w_captura_hologramas.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.st_estatus=create st_estatus
this.em_cve_doc_control_sep=create em_cve_doc_control_sep
this.cb_1=create cb_1
this.st_1=create st_1
this.em_cve_relacion=create em_cve_relacion
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_estatus
this.Control[iCurrent+2]=this.em_cve_doc_control_sep
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.em_cve_relacion
this.Control[iCurrent+6]=this.dw_1
end on

on w_captura_hologramas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_estatus)
destroy(this.em_cve_doc_control_sep)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.em_cve_relacion)
destroy(this.dw_1)
end on

event open;call super::open;X=1
Y=1
dw_1.SetTransObject(gtr_sce)
dw_1.Retrieve()

end event

type st_estatus from statictext within w_captura_hologramas
integer x = 1746
integer y = 52
integer width = 1051
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type em_cve_doc_control_sep from editmask within w_captura_hologramas
integer x = 608
integer y = 52
integer width = 750
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
boolean spin = true
string displaydata = "CERTIFICADOS~t1/TITULOS~t4/GRADO~t6/"
boolean usecodetable = true
end type

type cb_1 from commandbutton within w_captura_hologramas
integer x = 1394
integer y = 48
integer width = 306
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Buscar"
end type

event clicked;STRING ls_numero, ls_documento, ls_documento_cond, ls_estado_holograma
STRING ls_estado_captura, ls_estado_asignacion
LONG ll_row_buscado, ll_cve_doc_control_sep, ll_folios_asignados, ll_numero
ls_numero = em_cve_relacion.text
ls_documento = em_cve_doc_control_sep.text


IF ISNULL(ls_documento) OR LEN(ls_documento)=0 THEN
	MessageBox("Documento Inválido", "Favor de seleccionar un documento", StopSign!)
	RETURN
ELSE
	CHOOSE CASE ls_documento
	CASE "TITULOS"
		ls_documento_cond= "4"
		ll_cve_doc_control_sep= 4
	CASE "CERTIFICADOS"
		ls_documento_cond= "1"
		ll_cve_doc_control_sep = 1
	CASE ELSE
		ls_documento_cond= "0"
		ll_cve_doc_control_sep = 0
	END CHOOSE
END IF


IF NOT ISNUMBER(ls_numero) THEN
	MessageBox("Numero Inválido", "Favor de escribir un número positivo", StopSign!)
ELSE
	
	ll_numero= long(ls_numero)

	ll_folios_asignados = of_hologramas_asignados(ll_numero, ll_numero, ll_cve_doc_control_sep )
	
	ll_row_buscado = dw_1.Find("numero_inicial <= "+ls_numero+" and "+ls_numero+" <= numero_final and cve_doc_control_sep = "+ls_documento_cond, 1, dw_1.RowCount())

	IF ll_row_buscado= 0 THEN
		ls_estado_captura = "NO CAPTURADO -"
   ELSE
		ls_estado_captura = "CAPTURADO    -"
	END IF
	
	IF ll_folios_asignados= 0 THEN
		ls_estado_asignacion = " NO ASIGNADO"
	ELSEIF ll_folios_asignados= 1 THEN
		ls_estado_asignacion = " ASIGNADO"
	ELSEIF ll_folios_asignados> 1 THEN
		ls_estado_asignacion = " ASIGNADO DOBLE"		
	END IF
	
	ls_estado_holograma = ls_estado_captura + ls_estado_asignacion
	st_estatus.text = ls_estado_holograma
	
	IF ll_row_buscado= 0 THEN
		MessageBox("Numero No Encontrado", "No se encontró el holograma["+ls_numero+"]", StopSign!)		
	ELSE
		dw_1.ScrollToRow(ll_row_buscado)
	END IF	
END IF

end event

type st_1 from statictext within w_captura_hologramas
integer x = 50
integer y = 64
integer width = 137
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ir A:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_cve_relacion from editmask within w_captura_hologramas
integer x = 215
integer y = 52
integer width = 366
integer height = 88
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "#######"
end type

type dw_1 from u_dw_captura within w_captura_hologramas
event type integer ue_valida_row ( long al_row )
event type long ue_valida_rep_tras ( long al_row,  long al_cve_doc_control_sep,  long al_numero_inicial,  long al_numero_final )
integer x = 50
integer y = 196
integer width = 2734
integer height = 1276
integer taborder = 10
string dataobject = "d_hologramas_disponibles"
end type

event type integer ue_valida_row(long al_row);//ue_valida_row
//Recibe 	al_row
//Valida el registro recibido como parametro
//con las revisiones logicas necesarias

long ll_cve_doc_control_sep
long ll_holograma_inicial, ll_holograma_final

ll_cve_doc_control_sep= this.GetItemNumber(al_row,"cve_doc_control_sep")

if isnull(ll_cve_doc_control_sep) then
	MessageBox("Clave de documento nula","Es necesario capturar la clave del documento",StopSign!)
	ScrollToRow(al_row)
	return -1
end if

ll_holograma_inicial= this.GetItemNumber(al_row,"numero_inicial")
if isnull(ll_holograma_inicial) then
	MessageBox("Cuenta inicial nula","Es necesario capturar el numero inicial",StopSign!)
	ScrollToRow(al_row)
	return -1
end if

ll_holograma_final= this.GetItemNumber(al_row,"numero_final")
if isnull(ll_holograma_final) then
	MessageBox("Cuenta final nula","Es necesario capturar el numero final",StopSign!)
	ScrollToRow(al_row)
	return -1
end if

if ll_holograma_inicial > ll_holograma_final then
	MessageBox("Cuenta inicial invalida","Es necesario que el numero sea menor al numero final",StopSign!)
	ScrollToRow(al_row)
	return -1
end if

if event ue_valida_rep_tras(al_row, ll_cve_doc_control_sep, ll_holograma_inicial, ll_holograma_final) = -1 then
	return -1
end if

return 0
end event

event type long ue_valida_rep_tras(long al_row, long al_cve_doc_control_sep, long al_numero_inicial, long al_numero_final);//ue_valida_rep_tras
//Recibe	al_row, 
//			al_cve_doc_control_sep, 
//			al_numero_inicial, 
//			al_numero_final


long ll_cve_doc_control_sep
long ll_numero_inicial, ll_numero_final, ll_num_rows, ll_row


ll_num_rows= this.RowCount()

FOR ll_row= 1 TO ll_num_rows
	IF ll_row <> al_row THEN
		ll_cve_doc_control_sep= this.GetItemNumber(ll_row,"cve_doc_control_sep")
		ll_numero_inicial= this.GetItemNumber(ll_row,"numero_inicial")
		ll_numero_final= this.GetItemNumber(ll_row,"numero_final")
		
		
		IF	ll_numero_inicial = al_numero_inicial and ll_cve_doc_control_sep=al_cve_doc_control_sep THEN
			MessageBox("Holograma inicial repetido","No se permite repetir el numero inicial",StopSign!)
			ScrollToRow(ll_row)
			return -1
		END IF
		
		IF	ll_numero_final = al_numero_final and ll_cve_doc_control_sep=al_cve_doc_control_sep THEN
			MessageBox("Holograma final repetido","No se permite repetir el numero final",StopSign!)
			ScrollToRow(ll_row)
			return -1
		END IF

		IF	ll_numero_inicial <= al_numero_inicial and al_numero_inicial <= ll_numero_final and &
		   ll_cve_doc_control_sep=al_cve_doc_control_sep THEN
			MessageBox("Holograma inicial sobrepuesto","No se permite sobreponer el holograma inicial",StopSign!)
			ScrollToRow(ll_row)
			return -1
		END IF

		IF	ll_numero_inicial <= al_numero_final and al_numero_final <= ll_numero_final and &	
		   ll_cve_doc_control_sep=al_cve_doc_control_sep THEN
			MessageBox("Holograma final sobrepuesto","No se permite sobreponer el holograma final",StopSign!)
			ScrollToRow(ll_row)
			return -1
		END IF

	END IF
NEXT

RETURN 0
end event

event carga;long ll_rows
ll_rows = this.retrieve()
return ll_rows
end event

event retrieveend;call super::retrieveend;long ll_row_actual
long ll_numero_inicial, ll_numero_final, ll_utilizados, ll_disponibles
integer ll_cve_doc_control_sep


FOR ll_row_actual = 1 TO rowcount

	ll_numero_inicial = this.GetItemNumber(ll_row_actual, "numero_inicial")
	ll_numero_final = this.GetItemNumber(ll_row_actual, "numero_final")
	ll_cve_doc_control_sep = this.GetItemNumber(ll_row_actual, "cve_doc_control_sep")

	ll_utilizados = of_hologramas_asignados(ll_numero_inicial, ll_numero_final, ll_cve_doc_control_sep)

	ll_disponibles = ll_numero_final - ll_numero_inicial - ll_utilizados

	this.SetItem(ll_row_actual, "utilizados", ll_utilizados)

	this.SetItem(ll_row_actual, "disponibles", ll_disponibles)
NEXT


end event

event ue_actualiza;/*
DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
*/
long ll_rows, ll_row_actual
int li_respuesta
/*Acepta el texto de la última columna editada*/
AcceptText()
/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
if ModifiedCount()+DeletedCount() > 0 Then

	/*Pregunta si se desean guardar los cambios hechos*/
	li_respuesta = messagebox("Atención","Desea actualizar los cambios:",Question!,YesNo!,2)

	if li_respuesta = 1 then
		ll_rows= this.RowCount()
		
		FOR ll_row_actual= 1 TO ll_rows
			if event ue_valida_row(ll_row_actual)= -1 then
				return -1
			end if		
		NEXT
		
			/*Checa que los renglones cumplan con las reglas de validación*/
			if event actualiza_np() = 1 then//Manda llamar la función que realiza el update
				return 1
			else 
				return -1
			end if
	else
		/*De lo contrario, solo avisa que no se guardó nada.*/
		messagebox("Información","No se han guardado los cambios")
		return -1
	end if
else
	return 1
end if

end event

event actualiza;/*
DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
				
*/
long ll_rows, ll_row_actual
int li_respuesta
/*Acepta el texto de la última columna editada*/
AcceptText()
/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
if ModifiedCount()+DeletedCount() > 0 Then

	/*Pregunta si se desean guardar los cambios hechos*/
	li_respuesta = messagebox("Atención","Desea actualizar los cambios:",Question!,YesNo!,2)

	if li_respuesta = 1 then
		
		ll_rows= this.RowCount()
		
		FOR ll_row_actual= 1 TO ll_rows
			if event ue_valida_row(ll_row_actual)= -1 then
				return -1
			end if		
		NEXT
		
		
			/*Checa que los renglones cumplan con las reglas de validación*/
			if event actualiza_np() = 1 then//Manda llamar la función que realiza el update
				return 1
			else 
				return -1
			end if
	else
		/*De lo contrario, solo avisa que no se guardó nada.*/
		messagebox("Información","No se han guardado los cambios")
		return -1
	end if
else
	return 1
end if

end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

