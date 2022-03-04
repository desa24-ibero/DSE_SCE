$PBExportHeader$w_asignacion_hologramas.srw
forward
global type w_asignacion_hologramas from w_main
end type
type dw_3 from u_dw_captura within w_asignacion_hologramas
end type
type dw_1 from u_dw_captura within w_asignacion_hologramas
end type
type dw_2 from u_dw_captura within w_asignacion_hologramas
end type
end forward

global type w_asignacion_hologramas from w_main
integer width = 3383
integer height = 1814
string title = "Asignación de Hologramas a Opción Cero"
string menuname = "m_menu"
boolean ib_disableclosequery = true
dw_3 dw_3
dw_1 dw_1
dw_2 dw_2
end type
global w_asignacion_hologramas w_asignacion_hologramas

type variables
string is_orden_cobro
long il_cve_relacion, il_cve_tipo_relacion, il_row, ii_num_docs_existentes_total
long il_holograma_inicial
end variables

on w_asignacion_hologramas.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_3=create dw_3
this.dw_1=create dw_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.dw_2
end on

on w_asignacion_hologramas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_3)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event open;call super::open;X=1
Y=1
dw_1.SetTransObject(gtr_sce)
dw_2.SetTransObject(gtr_sce)
dw_3.SetTransObject(gtr_sce)
dw_1.Retrieve()

end event

type dw_3 from u_dw_captura within w_asignacion_hologramas
integer x = 26
integer y = 774
integer width = 3259
integer height = 819
integer taborder = 20
string dataobject = "d_control_sep_asigna_holograma"
boolean hscrollbar = true
boolean ib_rmbmenu = false
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

event updateend;call super::updateend;integer li_procesado=1
dw_1.SetItem(il_row,"relacion_documentos_procesado",li_procesado)

if dw_1.Update()=1 then
	commit using gtr_sce;
	dw_1.Retrieve()
else
	rollback using gtr_sce;
end if

//il_cve_relacion
//il_cve_tipo_relacion

end event

event actualiza;/*
DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
				
*/
int li_respuesta
/*Acepta el texto de la última columna editada*/
AcceptText()

IF ii_num_docs_existentes_total>0 THEN
	messagebox("Documentos Repetidos","No se pueden registrar documentos repetidos",StopSign!)	
	return -1
END IF

/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
if ModifiedCount()+DeletedCount() > 0 Then

	/*Pregunta si se desean guardar los cambios hechos*/
	li_respuesta = messagebox("Atención","Desea actualizar los cambios:",Question!,YesNo!,2)

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

type dw_1 from u_dw_captura within w_asignacion_hologramas
event type integer ue_valida_row ( long al_row )
event type long ue_valida_rep_tras ( long al_row,  long al_cve_doc_control_sep,  long al_numero_inicial,  long al_numero_final )
integer x = 26
integer y = 22
integer width = 3259
integer height = 701
integer taborder = 10
string dataobject = "d_relacion_consulta"
boolean hscrollbar = true
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

event doubleclicked;call super::doubleclicked;datetime ldttm_fecha_inicial, ldttm_fecha_final, ldttm_fecha_final_2
date ldt_fecha_final_aux
integer li_confirmación, li_cve_tipo_relacion
long ll_cve_relacion, ll_holograma_inicial
string ls_orden_cobro

string ls_dw_fechas = "d_atendidos_opc_cero_fechas"
string ls_dw_cuentas = "d_atendidos_titulacion_cuentas"

IF row > 0 THEN
	ll_cve_relacion = this.GetItemNumber(row,"relacion_documentos_cve_relacion")
	li_cve_tipo_relacion = this.GetItemNumber(row,"relacion_documentos_cve_tipo_relacion")
	il_cve_relacion = ll_cve_relacion
	il_cve_tipo_relacion = li_cve_tipo_relacion
	il_row = row
	ldttm_fecha_inicial = this.GetItemDateTime(row,"relacion_documentos_fecha_inicial")
	ls_orden_cobro = this.GetItemString(row,"relacion_documentos_orden_cobro")
	ldttm_fecha_final = this.GetItemDateTime(row,"relacion_documentos_fecha_final")
	
	ldt_fecha_final_aux = RelativeDate(date(ldttm_fecha_final), 1)
	ldttm_fecha_final_2 = datetime(ldt_fecha_final_aux)
	is_orden_cobro = ls_orden_cobro

	li_confirmación = MessageBox("Confirmación", "¿Desea simular la relación ["+string(ll_cve_relacion)+"] ?",Question!,YesNo!)

	IF li_confirmación = 1 THEN
		
		OpenWithParm(w_holograma_inicial, 0)
		ll_holograma_inicial= Message.DoubleParm
		il_holograma_inicial = ll_holograma_inicial
		dw_3.Reset()
		IF li_cve_tipo_relacion = 1 THEN
			dw_2.dataobject =ls_dw_fechas
			dw_2.SetTransObject(gtr_sce)
			dw_2.Retrieve(ldttm_fecha_inicial, ldttm_fecha_final_2)	
		ELSE
			dw_2.dataobject =ls_dw_cuentas
			dw_2.SetTransObject(gtr_sce)
			dw_2.Retrieve(ll_cve_relacion, li_cve_tipo_relacion)	
		END IF
	END IF

END IF

end event

event asigna_dw_menu;return
end event

type dw_2 from u_dw_captura within w_asignacion_hologramas
boolean visible = false
integer x = 26
integer y = 595
integer width = 3259
integer height = 310
integer taborder = 20
string dataobject = "d_atendidos_opc_cero_fechas"
boolean hscrollbar = true
end type

event retrieveend;call super::retrieveend;long ll_row, ll_row_insertado, ll_scroll
long ll_cuenta, ll_cve_carrera, ll_cve_plan, ll_maximo_folio, ll_numero
long ll_hologramas[]
datetime ldttm_fecha_hoy
integer li_cve_doc_control_sep, li_siguiente_holograma, li_ciclos_cursados
integer li_num_docs_existentes=0, li_num_docs_existentes_total=0
string ls_orden_cobro

li_cve_doc_control_sep=4
li_ciclos_cursados=0

ldttm_fecha_hoy =fecha_servidor(gtr_sce)
ll_maximo_folio = of_obten_maximo_folio(li_cve_doc_control_sep)
ll_numero = ll_maximo_folio
//li_siguiente_holograma= of_obten_siguiente_holograma(li_cve_doc_control_sep, rowcount, ll_hologramas)
li_siguiente_holograma= of_obten_siguiente_holog_num(li_cve_doc_control_sep, rowcount, ll_hologramas,il_holograma_inicial )

IF li_siguiente_holograma = -1 THEN
	MessageBox("Simulación Incompleta","No es posible asignar hologramas a la relación vigente", StopSign!)
	return -1
END IF
SetPointer(HourGlass!)
FOR ll_row = 1 TO rowcount
	ll_cuenta =	dw_2.GetItemNumber(ll_row,"cuenta")
	ll_cve_carrera = dw_2.GetItemNumber(ll_row,"cve_carrera")
	ll_cve_plan = dw_2.GetItemNumber(ll_row,"cve_plan")
	li_num_docs_existentes = of_control_sep_existente(ll_cuenta, ll_cve_carrera,  ll_cve_plan, li_cve_doc_control_sep)
	
	ll_row_insertado = dw_3.InsertRow(0)
	ll_scroll =ScrollToRow(ll_row_insertado)
	
	dw_3.SetItem(ll_row_insertado,"cuenta",ll_cuenta)
	dw_3.SetItem(ll_row_insertado,"cve_carrera",ll_cve_carrera)
	dw_3.SetItem(ll_row_insertado,"cve_plan",ll_cve_plan)
	dw_3.SetItem(ll_row_insertado,"fecha_emision",ldttm_fecha_hoy)
	dw_3.SetItem(ll_row_insertado,"numero",ll_numero)
	dw_3.SetItem(ll_row_insertado,"cve_doc_control_sep",li_cve_doc_control_sep)
	dw_3.SetItem(ll_row_insertado,"orden_cobro",is_orden_cobro)
	dw_3.SetItem(ll_row_insertado,"num_holograma",ll_hologramas[ll_row])
	dw_3.SetItem(ll_row_insertado,"ciclos_cursados",li_ciclos_cursados)
	IF li_num_docs_existentes>0 THEN
		dw_3.SelectRow(ll_row_insertado, TRUE)
		li_num_docs_existentes_total = li_num_docs_existentes_total + 1
	END IF
	ll_numero= ll_numero + 1 
NEXT
ii_num_docs_existentes_total= li_num_docs_existentes_total

IF ii_num_docs_existentes_total >0 THEN
	MessageBox("Documentos Repetidos","Existen ["+string(ii_num_docs_existentes_total) +"] documentos repetidos", StopSign!)		
END IF

end event

