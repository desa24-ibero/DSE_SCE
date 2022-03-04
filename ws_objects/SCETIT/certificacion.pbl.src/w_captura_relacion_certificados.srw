$PBExportHeader$w_captura_relacion_certificados.srw
forward
global type w_captura_relacion_certificados from w_main
end type
type uo_1 from uo_datos_opc_cero_sin_rev2 within w_captura_relacion_certificados
end type
type dw_2 from u_dw_captura within w_captura_relacion_certificados
end type
type cb_1 from commandbutton within w_captura_relacion_certificados
end type
type st_1 from statictext within w_captura_relacion_certificados
end type
type em_cve_relacion from editmask within w_captura_relacion_certificados
end type
type dw_1 from u_dw_captura within w_captura_relacion_certificados
end type
end forward

global type w_captura_relacion_certificados from w_main
integer x = 466
integer y = 372
integer width = 3120
integer height = 1418
string title = "Relación de Certificados"
string menuname = "m_menu_relacion_certificados"
event metodo01 ( )
uo_1 uo_1
dw_2 dw_2
cb_1 cb_1
st_1 st_1
em_cve_relacion em_cve_relacion
dw_1 dw_1
end type
global w_captura_relacion_certificados w_captura_relacion_certificados

event metodo01();long ll_cuenta, ll_cve_carrera, ll_cve_plan, ll_row_detalle, ll_row_maestro
long ll_cve_relacion, ll_cve_tipo_relacion

IF dw_1.Rowcount()>0 THEN
	ll_row_maestro= dw_1.GetRow()
	IF ll_row_maestro> 0 THEN
		ll_cve_relacion = dw_1.GetItemNumber(ll_row_maestro,"cve_relacion")
		ll_cve_tipo_relacion= dw_1.GetItemNumber(ll_row_maestro,"cve_tipo_relacion")
		IF not isnull(ll_cve_relacion) and ll_cve_relacion>0 and&
			not isnull(ll_cve_tipo_relacion) and ll_cve_tipo_relacion>0 THEN

			ll_cuenta = uo_1.of_obten_cuenta()
			ll_cve_carrera= uo_1.of_obten_cve_carrera()
			ll_cve_plan= uo_1.of_obten_cve_plan(ll_cuenta)

			ll_row_detalle= dw_2.InsertRow(0)

			dw_2.SetItem(ll_row_detalle,"cve_relacion", ll_cve_relacion)			
			dw_2.SetItem(ll_row_detalle,"cve_tipo_relacion", ll_cve_tipo_relacion)
			dw_2.SetItem(ll_row_detalle,"cuenta", ll_cuenta)			
			dw_2.SetItem(ll_row_detalle,"cve_carrera", ll_cve_carrera)
			dw_2.SetItem(ll_row_detalle,"cve_plan", ll_cve_plan)
		ELSE
			MessageBox("Relacion Incompleta", "Es necesario elegir la relación y tipo de relación",StopSign!)
			return
		END IF
	END IF
END IF
end event

on w_captura_relacion_certificados.create
int iCurrent
call super::create
if this.MenuName = "m_menu_relacion_certificados" then this.MenuID = create m_menu_relacion_certificados
this.uo_1=create uo_1
this.dw_2=create dw_2
this.cb_1=create cb_1
this.st_1=create st_1
this.em_cve_relacion=create em_cve_relacion
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.em_cve_relacion
this.Control[iCurrent+6]=this.dw_1
end on

on w_captura_relacion_certificados.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.em_cve_relacion)
destroy(this.dw_1)
end on

event open;call super::open;X=1
Y=1
dw_1.SetTransObject(gtr_sce)
dw_1.of_SetDropDownCalendar ( true )
dw_1.iuo_calendar.of_Register("fecha_inicial", &
  dw_1.iuo_calendar.DDLB)
dw_1.iuo_calendar.of_Register("fecha_final", &
  dw_1.iuo_calendar.DDLB)

dw_1.of_SetLinkage(True)
dw_2.of_SetLinkage(True)
dw_2.of_SetTransObject(gtr_sce)

dw_2.inv_linkage.of_SetMaster(dw_1)

dw_2.inv_linkage.of_Register("cve_relacion","cve_relacion")

dw_2.inv_linkage.of_SetStyle(1)
dw_2.inv_linkage.of_SetUpdateStyle(1)

dw_1.of_Retrieve()
dw_2.of_Retrieve()

end event

type uo_1 from uo_datos_opc_cero_sin_rev2 within w_captura_relacion_certificados
boolean visible = false
integer x = 37
integer y = 714
integer width = 2765
integer taborder = 40
end type

on uo_1.destroy
call uo_datos_opc_cero_sin_rev2::destroy
end on

type dw_2 from u_dw_captura within w_captura_relacion_certificados
boolean visible = false
integer x = 37
integer y = 1005
integer width = 2765
integer height = 506
integer taborder = 40
string dataobject = "d_relacion_documento_alum"
boolean ib_rmbmenu = false
end type

event pfc_retrieve;call super::pfc_retrieve;return this.Retrieve()
end event

event carga;call super::carga;RETURN this.rowcount()
end event

event actualiza;call super::actualiza;/*
DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
				
*/
int li_respuesta
/*Acepta el texto de la última columna editada*/
AcceptText()
/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
if ModifiedCount()+DeletedCount() > 0 Then

	/*Pregunta si se desean guardar los cambios hechos*/
//	li_respuesta = messagebox("Atención","Desea actualizar los cambios:",Question!,YesNo!,2)
	li_respuesta=1
	if li_respuesta = 1 then
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

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio=gtr_sce
end event

event asigna_dw_menu;RETURN
end event

type cb_1 from commandbutton within w_captura_relacion_certificados
integer x = 534
integer y = 6
integer width = 307
integer height = 90
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Buscar"
end type

event clicked;STRING ls_cve_relacion
LONG ll_row_buscado
ls_cve_relacion = em_cve_relacion.text

IF NOT ISNUMBER(ls_cve_relacion) THEN
	MessageBox("Numeo Inválido", "Favor de escribir un número positivo", StopSign!)
ELSE
	ll_row_buscado = dw_1.Find("cve_relacion = "+ls_cve_relacion, 1, dw_1.RowCount())
	IF ll_row_buscado= 0 THEN
		MessageBox("Numeo No Encontrado", "No se encontró la relacion ["+ls_cve_relacion+"]", StopSign!)
	ELSE
		dw_1.ScrollToRow(ll_row_buscado)
	END IF	
END IF
end event

type st_1 from statictext within w_captura_relacion_certificados
integer x = 51
integer y = 22
integer width = 135
integer height = 61
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

type em_cve_relacion from editmask within w_captura_relacion_certificados
integer x = 245
integer y = 10
integer width = 263
integer height = 86
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
string mask = "####"
end type

type dw_1 from u_dw_captura within w_captura_relacion_certificados
event borra_detalle ( )
integer x = 37
integer y = 106
integer width = 2765
integer height = 605
integer taborder = 10
string dataobject = "d_relacion_documentos_certificados"
end type

event borra_detalle();dw_2.event borra()
end event

event carga;call super::carga;RETURN this.rowcount()
end event

event pfc_retrieve;call super::pfc_retrieve;return this.Retrieve()
end event

event rowfocuschanged;call super::rowfocuschanged;//integer li_cve_tipo_relacion, li_cve_relacion
//string ls_filtro
//
//
//IF currentrow > 0 THEN
//	
//	ScrollToRow(currentrow)
//	li_cve_relacion = this.GetItemNumber(currentrow, "cve_relacion")
//	li_cve_tipo_relacion = this.GetItemNumber(currentrow, "cve_tipo_relacion")
//
//	IF li_cve_tipo_relacion>0 AND NOT ISNULL(li_cve_tipo_relacion) THEN
//		IF li_cve_tipo_relacion>0 AND NOT ISNULL(li_cve_tipo_relacion) THEN
//			ls_filtro = "cve_relacion = "+string(li_cve_relacion)+" and cve_tipo_relacion = "+string(li_cve_tipo_relacion)
//			dw_2.SetFilter(ls_filtro)
//			dw_2.Filter( )
//		END IF
//	END IF
//
//END IF
end event

event actualiza;/*
DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
				
*/
int li_respuesta
string ls_filtro= ""
/*Acepta el texto de la última columna editada*/
AcceptText()
//dw_2.SetFilter(ls_filtro)
//dw_2.Filter()
//
/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
if ModifiedCount()+DeletedCount() > 0 or dw_2.ModifiedCount()+dw_2.DeletedCount() > 0  Then

	/*Pregunta si se desean guardar los cambios hechos*/
	li_respuesta = messagebox("Atención","Desea actualizar los cambios:",Question!,YesNo!,2)

	if li_respuesta = 1 then
			/*Checa que los renglones cumplan con las reglas de validación*/
			if event actualiza_np() = 1 and dw_2.event actualiza_np() = 1 then//Manda llamar la función que realiza el update
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

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio=gtr_sce
end event

