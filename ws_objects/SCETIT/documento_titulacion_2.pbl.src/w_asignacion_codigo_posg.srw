$PBExportHeader$w_asignacion_codigo_posg.srw
forward
global type w_asignacion_codigo_posg from w_main
end type
type dw_3 from u_dw_captura within w_asignacion_codigo_posg
end type
type dw_1 from u_dw_captura within w_asignacion_codigo_posg
end type
type dw_2 from u_dw_captura within w_asignacion_codigo_posg
end type
end forward

global type w_asignacion_codigo_posg from w_main
integer width = 4750
integer height = 2180
string title = "Asignación de Código de Titulación Posgrado"
string menuname = "m_menu"
boolean ib_disableclosequery = true
dw_3 dw_3
dw_1 dw_1
dw_2 dw_2
end type
global w_asignacion_codigo_posg w_asignacion_codigo_posg

type variables
string is_orden_cobro, is_ventana, is_dw_fechas, is_dw_cuentas
long il_cve_relacion, il_cve_tipo_relacion, il_row, ii_num_error_codigo_total, ii_num_error_nvo_codigo_total
long il_id_titulo=-1, il_n_titulo= -1, il_asigna_codigo= -1, il_id_titulo_posg=-1, il_n_titulo_posg= -1
datetime idt_fecha_sig_mes_posg
integer ii_cve_documento



end variables

forward prototypes
public function integer wf_asigna_codigo ()
end prototypes

public function integer wf_asigna_codigo ();//wf_asigna_codigo
//Actualiza el código y el numero de titulo para los registros consultados

long ll_row, ll_row_insertado, ll_scroll, ll_rowcount
long ll_cuenta, ll_cve_carrera, ll_cve_plan, ll_maximo_folio, ll_numero
long ll_hologramas[]
datetime ldttm_fecha_hoy
integer li_cve_doc_control_sep, li_siguiente_holograma, li_ciclos_cursados
integer li_num_error_codigo=0, li_num_error_codigo_total=0, li_num_error_nvo_codigo_total=0
string ls_orden_cobro, ls_nvo_codigo
long ll_id_titulo, ll_n_titulo, ll_cve_secuencia= 1
long ll_id_titulo_posg, ll_n_titulo_posg, ll_cve_secuencia_posg= 2
u_codigo_titulo lu_codigo_titulo
double ld_codigo

long	ll_n_acta, ll_n_libro, ll_n_hoja, ll_id_plantel, ll_id_univ
datetime ldttm_f_examen, ldttm_f_exped
date ldt_f_examen, ldt_f_exped
string ls_nombres, ls_a_pat, ls_a_mat, ls_grado


SetNull(ldt_f_examen)
SetNull(ldt_f_exped)

ll_rowcount = dw_2.RowCount()
//dw_2.enabled = false
lu_codigo_titulo = CREATE u_codigo_titulo
ldttm_fecha_hoy =fecha_servidor(gtr_sce)

/*Id y Num Titulo para Licenciatura y RG's(Licenciatura)*/
ll_id_titulo = of_obten_id_titulo(ll_cve_secuencia)
ll_n_titulo = of_obten_n_titulo(ll_cve_secuencia)

IF ll_id_titulo = -1 or ll_n_titulo= -1 THEN
	MessageBox("Simulación Incompleta","No es posible asignar el código a la relación vigente", StopSign!)
	IF isvalid(lu_codigo_titulo) THEN
		DESTROY lu_codigo_titulo
	END IF
	return -1
END IF

/*Id y Num Titulo para Posgrado y RGS(Posgrado)*/
ll_id_titulo_posg = of_obten_id_titulo(ll_cve_secuencia_posg)
ll_n_titulo_posg = of_obten_n_titulo(ll_cve_secuencia_posg)

IF ll_id_titulo_posg = -1 or ll_n_titulo_posg= -1 THEN
	MessageBox("Simulación Incompleta","No es posible asignar el código a la relación vigente", StopSign!)
	IF isvalid(lu_codigo_titulo) THEN
		DESTROY lu_codigo_titulo
	END IF
	return -1
END IF


SetPointer(HourGlass!)
FOR ll_row = 1 TO ll_rowcount
	ll_cuenta =	dw_2.GetItemNumber(ll_row,"cuenta")
	ll_cve_carrera = dw_2.GetItemNumber(ll_row,"cve_carrera")
	ll_cve_plan = dw_2.GetItemNumber(ll_row,"cve_plan")
	
	ll_n_acta = dw_2.getitemnumber(ll_row,"n_acta")
	ll_n_libro = dw_2.getitemnumber(ll_row,"n_libro")
	ll_n_hoja = dw_2.getitemnumber(ll_row,"n_hoja")

	ldttm_f_examen = dw_2.getitemDatetime(ll_row,"f_examen")
//	ldttm_f_exped = dw_2.getitemDatetime(ll_row,"f_exped")
	ldttm_f_exped = idt_fecha_sig_mes_posg
	ldt_f_examen = date(ldttm_f_examen)
	ldt_f_exped = date(ldttm_f_exped)

	ls_nombres = dw_2.getitemstring(ll_row,"nombres")
	ls_a_pat = dw_2.getitemstring(ll_row,"a_pat")
	ls_a_mat = dw_2.getitemstring(ll_row,"a_mat")

	ll_id_plantel = dw_2.getitemnumber(ll_row,"id_plantel")
	ll_id_univ = dw_2.getitemnumber(ll_row,"id_univ")
	
	ls_grado = dw_2.getitemstring(ll_row,"cve_grado")
	
	//Validaciones 
	If IsNull(ll_cuenta) Then
		MessageBox("Error del Sistema","La cuenta no puede ser nula, Registro ["+string(ll_row) +"]", StopSign!)		
		return -1
		EXIT
	End If

	If IsNull(ll_cve_carrera) Then
		MessageBox("Error del Sistema","La clave de la carrera no puede ser nula, Registro ["+string(ll_row) +"]", StopSign!)		
		return -1
		EXIT
	End If

	If IsNull(ll_cve_plan) Then
		MessageBox("Error del Sistema","La clave del plan no puede ser nula, Registro ["+string(ll_row) +"]", StopSign!)		
		return -1
		EXIT
	End If

	If IsNull(ll_n_acta) Then
		MessageBox("Error del Sistema","El número de acta no puede ser nulo, Registro ["+string(ll_row) +"]", StopSign!)		
		return -1
		EXIT
	End If

	If IsNull(ll_n_libro) Then
		MessageBox("Error del Sistema","El número de libro no puede ser nulo, Registro ["+string(ll_row) +"]", StopSign!)		
		return -1
		EXIT
	End If

	If IsNull(ll_n_hoja) Then
		MessageBox("Error del Sistema","El número de hoja no puede ser nulo, Registro ["+string(ll_row) +"]", StopSign!)		
		return -1
		EXIT
	End If

	If IsNull(ldt_f_examen) Then
		MessageBox("Error del Sistema","La fecha de examén no puede ser nula, Registro ["+string(ll_row) +"]", StopSign!)		
		return -1
		EXIT
	End If

	If IsNull(ldt_f_exped) Then
		MessageBox("Error del Sistema","El fecha de expedición no puede ser nula, Registro ["+string(ll_row) +"]", StopSign!)		
		return -1
		EXIT
	End If

	If IsNull(ls_nombres) Or trim(ls_nombres) = "" Then
		MessageBox("Error del Sistema","El nombre del alumno no puede ser nulo, Registro ["+string(ll_row) +"]", StopSign!)		
		return -1
		EXIT
	End If

	If IsNull(ls_a_pat) Then
		ls_a_pat = ""
	End If

	If IsNull(ls_a_mat) Then
		ls_a_mat = ""
	End If
	
	If IsNull(ll_id_plantel) Then
		MessageBox("Error del Sistema","El id del plantel no puede ser nulo, Registro ["+string(ll_row) +"]", StopSign!)		
		return -1
		EXIT
	End If
	
	If IsNull(ll_id_univ) Then
		MessageBox("Error del Sistema","El id de la universidad no puede ser nulo, Registro ["+string(ll_row) +"]", StopSign!)		
		return -1
		EXIT
	End If
	
		If IsNull(ls_grado) Then
		MessageBox("Error del Sistema","El grado de estudios no puede ser nulo, Registro ["+string(ll_row) +"]", StopSign!)		
		return -1
		EXIT
	End If


 //	ld_codigo = lu_codigo_titulo.of_obten_codigo(ll_cuenta, ll_cve_carrera, ll_cve_plan, ll_id_titulo, ll_n_titulo)		//Comentado Jun 2013		
	
//	IF ld_codigo = -1 THEN
//		MessageBox("Simulación Incompleta","No es posible asignar el código a la relación vigente", StopSign!)
//		IF isvalid(lu_codigo_titulo) THEN
//			DESTROY lu_codigo_titulo
//		END IF
//		return -1
//	END IF

//20130711 SALVADOR FRAYLE FLORES	
//	ls_nvo_codigo = lu_codigo_titulo.of_obten_nvo_codigo(ll_cuenta, ll_cve_carrera, ll_cve_plan, ll_id_titulo, ll_n_titulo)

	If ls_grado = 'M' Or ls_grado = 'D' OR ls_grado = 'E' Then
		ls_nvo_codigo = lu_codigo_titulo.of_obten_nvo_seguro (ll_n_titulo_posg, ll_n_acta, ll_n_libro, ll_n_hoja,&
								ldt_f_examen, ldt_f_exped, ls_nombres, ls_a_pat, ls_a_mat,&
								ll_cve_carrera, ll_id_plantel, ll_id_univ, ll_id_titulo_posg)
	Else
		ls_nvo_codigo = lu_codigo_titulo.of_obten_nvo_seguro (ll_n_titulo, ll_n_acta, ll_n_libro, ll_n_hoja,&
								ldt_f_examen, ldt_f_exped, ls_nombres, ls_a_pat, ls_a_mat,&
								ll_cve_carrera, ll_id_plantel, ll_id_univ, ll_id_titulo)
	End If		

	
	If LEN(ls_nvo_codigo) > 100 Then
		ls_nvo_codigo = LEFT(ls_nvo_codigo, 100)
	End If

	If ls_grado = 'M' Or ls_grado = 'D' Or ls_grado = 'E'  Then
		dw_2.SetItem(ll_row,"id_titulo",ll_id_titulo_posg)
		dw_2.SetItem(ll_row,"numero_titulo",string(ll_n_titulo_posg))
	Else
		dw_2.SetItem(ll_row,"id_titulo",ll_id_titulo)
		dw_2.SetItem(ll_row,"numero_titulo",string(ll_n_titulo))
	End If
		
	dw_2.SetItem(ll_row,"codigo_completo",MID(ls_nvo_codigo,1,100))
	dw_2.Setitem(ll_row, 'fecha_expedicion', ldt_f_exped)

	
	IF ls_nvo_codigo = "-1" THEN
		dw_2.SelectRow(ll_row, TRUE)
		li_num_error_nvo_codigo_total = li_num_error_nvo_codigo_total + 1
	END IF
	
	If ls_grado = 'M' Or ls_grado = 'D' Or ls_grado = 'E' Then
		ll_id_titulo_posg = ll_id_titulo_posg + 1
		ll_n_titulo_posg = ll_n_titulo_posg + 1
	Else
		ll_id_titulo = ll_id_titulo + 1 
		ll_n_titulo  = ll_n_titulo + 1
	End If
		il_id_titulo_posg = ll_id_titulo_posg  
		il_n_titulo_posg  = ll_n_titulo_posg
		il_id_titulo = ll_id_titulo  
		il_n_titulo  = ll_n_titulo 
NEXT

 //Comentado Jun 2013	
//ii_num_error_codigo_total= li_num_error_codigo_total
//dw_2.enabled = true
//IF ii_num_error_codigo_total >0 THEN
//	MessageBox("Documentos Repetidos","Existen ["+string(ii_num_error_codigo_total) +"] documentos repetidos", StopSign!)		
//	return -1
//END IF

ii_num_error_nvo_codigo_total = li_num_error_nvo_codigo_total
IF ii_num_error_nvo_codigo_total >0 THEN
	MessageBox("Error del Sistema","No fue posible obtener el código. Existen ["+string(ii_num_error_nvo_codigo_total) +"] Documentos con error", StopSign!)		
	return -1
END IF

return 0
end function

on w_asignacion_codigo_posg.create
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

on w_asignacion_codigo_posg.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_3)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event open;call super::open;is_ventana = Message.stringparm

X=1
Y=1

SELECT fecha_posgrado
	INTO :idt_fecha_sig_mes_posg
FROM parametros_titulacion
where  cve_parametro = 1
USING gtr_sce;

choose case is_ventana
	case "POSG", "POS_DUP"
		dw_1.dataobject ="d_relacion_consulta_posg"
		is_dw_cuentas = "d_asigna_codigo_dis_ctas"
		If is_ventana = "POS_DUP" Then 
			is_dw_fechas  = "d_asigna_codigo_disenio"	
			ii_cve_documento = 81
			This.title = "Asignación de Código de Titulación Posgrado (DUPLICADOS)"
		Else
			is_dw_fechas  = "d_asigna_codigo_disenio_posg"
		End If
	case "RGS", "RGS_DUP"
		dw_1.dataobject ="d_relacion_consulta_rgs"
		is_dw_cuentas = "d_asigna_codigo_dis_ctas"
		This.title = "	Asignación de Código de Titulación RG's "
		If is_ventana = "RGS_DUP" Then 
			ii_cve_documento = 82
			This.title = "Asignación de Código de Titulación RG's (DUPLICADOS)"
			is_dw_fechas  = "d_asigna_codigo_duplicados_rgs"	
		Else
			is_dw_fechas  = "d_asigna_codigo_disenio_rgs"
		End If
end choose

dw_1.SetTransObject(gtr_sce)
dw_2.SetTransObject(gtr_sce)
dw_3.SetTransObject(gtr_sce)
dw_1.Retrieve()

end event

type dw_3 from u_dw_captura within w_asignacion_codigo_posg
integer x = 27
integer y = 776
integer width = 3259
integer height = 724
integer taborder = 20
string dataobject = "d_control_sep_asigna_holograma"
boolean hscrollbar = true
boolean ib_rmbmenu = false
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

event updateend;call super::updateend;integer li_procesado=1
dw_1.SetItem(il_row,"relacion_documentos_codigo_asignado",li_procesado)

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

IF ii_num_error_codigo_total>0 THEN
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

type dw_1 from u_dw_captura within w_asignacion_codigo_posg
event type integer ue_valida_row ( long al_row )
event type long ue_valida_rep_tras ( long al_row,  long al_cve_doc_control_sep,  long al_numero_inicial,  long al_numero_final )
integer x = 27
integer y = 24
integer width = 3259
integer height = 700
integer taborder = 10
string dataobject = "d_relacion_consulta_posg"
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
long ll_cve_relacion
string ls_orden_cobro

//string ls_dw_fechas  = "d_asigna_codigo_disenio_posg"
//string ls_dw_cuentas = "d_asigna_codigo_dis_ctas"

string ls_fecha_ini, ls_fecha_fin

If IsNull(idt_fecha_sig_mes_posg) Then
	MessageBox('Mensaje del Sistema', 'La fecha de posgrado no ha sido definida en la tabla de parametros, favor de verificar', StopSign!)
	return -1
End If

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

	li_confirmación = MessageBox("Confirmación", "Los registros se actualizaran con fecha expedición: " + string(date(idt_fecha_sig_mes_posg)) + "~r¿Desea simular la relación ["+string(ll_cve_relacion)+"] ?",Question!,YesNo!)

/*choose case is_ventana
	case "POSG", "POS_DUP"
		dw_1.dataobject ="d_relacion_consulta_posg"
		is_dw_cuentas = "d_asigna_codigo_dis_ctas"
		If is_ventana = "POSG_DUP" Then 
			is_dw_fechas  = "d_asigna_codigo_disenio"		
		Else
			is_dw_fechas  = "d_asigna_codigo_disenio_posg"
		End If
	case "RGS", "RGS_DUP"
		dw_1.dataobject ="d_relacion_consulta_rgs"
		is_dw_cuentas = "d_asigna_codigo_dis_ctas"
		If is_ventana = "RGS_DUP" Then 
			is_dw_fechas  = "d_asigna_codigo_disenio"		
		Else
			is_dw_fechas  = "d_asigna_codigo_disenio_rgs"
		End If
*/

	IF li_confirmación = 1 THEN
		dw_3.Reset()
		choose case is_ventana
			case 'POSG', 'POS_DUP'
				ls_fecha_ini = mid(string(date(ldttm_fecha_inicial)),7,4) + mid(string(date(ldttm_fecha_inicial)),4,2)  + mid(string(date(ldttm_fecha_inicial)),1,2)	
				ls_fecha_fin = mid(string(date(ldttm_fecha_final)),7,4) + mid(string(date(ldttm_fecha_final)),4,2)  + mid(string(date(ldttm_fecha_final)),1,2)				

				IF li_cve_tipo_relacion = 5 THEN
					dw_2.dataobject =is_dw_fechas
					dw_2.SetTransObject(gtr_sce)
					If is_ventana = 'POS_DUP' Then 
//						ldttm_fecha_inicial = this.GetItemDateTime(row,"relacion_documentos_fecha_inicial")
//						ldttm_fecha_final = this.GetItemDateTime(row,"relacion_documentos_fecha_final")
//						dw_2.Retrieve(ldttm_fecha_inicial, ldttm_fecha_final,ii_cve_documento)	
						dw_2.Retrieve(ls_fecha_ini, ls_fecha_fin,ii_cve_documento)	
					Else
						dw_2.Retrieve(ls_fecha_ini, ls_fecha_fin)
					End If
		//		ELSE
		//			dw_2.dataobject =ls_dw_cuentas
		//			dw_2.SetTransObject(gtr_sce)
		//			dw_2.Retrieve(ll_cve_relacion, li_cve_tipo_relacion)	
				END IF
			case 'RGS', 'RGS_DUP'
				IF li_cve_tipo_relacion = 6 THEN
					dw_2.dataobject =is_dw_fechas
					dw_2.SetTransObject(gtr_sce)
					If is_ventana = 'RGS_DUP' Then
						ls_fecha_ini = mid(string(date(ldttm_fecha_inicial)),7,4) + mid(string(date(ldttm_fecha_inicial)),4,2)  + mid(string(date(ldttm_fecha_inicial)),1,2)	
						ls_fecha_fin = mid(string(date(ldttm_fecha_final)),7,4) + mid(string(date(ldttm_fecha_final)),4,2)  + mid(string(date(ldttm_fecha_final)),1,2)				
						//dw_2.Retrieve(ls_fecha_ini, ls_fecha_fin,ii_cve_documento)
						dw_2.Retrieve(ldttm_fecha_inicial, ldttm_fecha_final_2,idt_fecha_sig_mes_posg)	
					Else
						dw_2.Retrieve(ldttm_fecha_inicial, ldttm_fecha_final_2,idt_fecha_sig_mes_posg)	
					End If
		//		ELSE
		//			dw_2.dataobject =ls_dw_cuentas
		//			dw_2.SetTransObject(gtr_sce)
		//			dw_2.Retrieve(ll_cve_relacion, li_cve_tipo_relacion)	
				END IF
		end choose

END IF
			
			
			
//		End If
END IF

end event

event asigna_dw_menu;return
end event

type dw_2 from u_dw_captura within w_asignacion_codigo_posg
integer x = 27
integer y = 776
integer width = 4603
integer height = 1124
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_asigna_codigo_disenio_posg"
boolean hscrollbar = true
end type

event retrieveend;call super::retrieveend;//Asigna el codigo correspondiente
il_asigna_codigo = wf_asigna_codigo()

if il_asigna_codigo<> -1 then
	dw_2.enabled= true
end if
end event

event actualiza;/*
DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
				
*/
int li_respuesta
/*Acepta el texto de la última columna editada*/

if il_asigna_codigo= -1 or il_id_titulo = -1 or il_n_titulo= -1  or il_id_titulo_posg = -1 or il_n_titulo_posg= -1 then
	Messagebox("Error en Asignación","No ha sido posible asignar los códigos",StopSign!)
	return -1
end If
AcceptText()
/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
if ModifiedCount()+DeletedCount() > 0 Then

	/*Pregunta si se desean guardar los cambios hechos*/
	li_respuesta = messagebox("Atención","Desea actualizar los cambios:",Question!,YesNo!,2)

	if li_respuesta = 1 then
			/*Checa que los renglones cumplan con las reglas de validación*/
			if event actualiza_np() = 1 then//Manda llamar la función que realiza el update
				messagebox("Información","Se ha almacenado la información exitosamente")
				return 1
			else 
				messagebox("Error","No se ha almacenado la información correctamente")
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

event actualiza_0_int;/*
DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
				Este evento no presenta interacción con el usuario
*/

//transaction ltr_trans 
//ltr_trans = Create Transaction
//if GetTrans(ltr_trans) = 1 then
integer li_codigo_sql, li_codigo_sql_posg
long ll_cve_secuencia=1, ll_cve_secuencia_posg = 2
string ls_mensaje_sql, ls_mensaje_sql_posg
AcceptText()
if ModifiedCount()+DeletedCount() > 0 Then
/*Función que solo actualiza*/
	UPDATE folio_titulacion
	SET n_titulo = :il_n_titulo,
		  id_titulo = :il_id_titulo
	WHERE cve_secuencia = :ll_cve_secuencia
	USING tr_dw_propio;
	
	li_codigo_sql= tr_dw_propio.SqlCode
	ls_mensaje_sql= tr_dw_propio.SqlErrtext
	
	/*Función que solo actualiza folios de posgrado*/
	UPDATE folio_titulacion
	SET n_titulo = :il_n_titulo_posg,
		id_titulo = :il_id_titulo_posg
	WHERE cve_secuencia = :ll_cve_secuencia_posg
	USING tr_dw_propio;
	
	li_codigo_sql_posg= tr_dw_propio.SqlCode
	ls_mensaje_sql_posg= tr_dw_propio.SqlErrtext
	
	If IsNull(ls_mensaje_sql) Then ls_mensaje_sql = ''
	If IsNull(ls_mensaje_sql_posg) Then ls_mensaje_sql_posg = ''

	if li_codigo_sql=0 And li_codigo_sql_posg=0 then
		if update(true) = 1 then		
			/*Si es asi, guardalo en la tabla y avisa.*/
			commit using tr_dw_propio;	
			//destroy ltr_trans
			return 1
		else
			/*De lo contrario, desecha los cambios (todos) y avisa*/
			rollback using tr_dw_propio;	
			//destroy ltr_trans
			return -1
		end if
	else
		rollback using tr_dw_propio;	
			//destroy ltr_trans
		MessageBox("Error al actualizar los folios de titulación",ls_mensaje_sql+''+ ls_mensaje_sql_posg,StopSign!)
		return -1		
	end if
	
else
	return 1
end if

end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce

end event

event updateend;call super::updateend;integer li_codigo_asignado=1
dw_1.SetItem(il_row,"relacion_documentos_codigo_asignado",li_codigo_asignado)

if dw_1.Update()=1 then
	commit using gtr_sce;
	dw_1.Retrieve()
	dw_2.reset( )
else
	rollback using gtr_sce;
end if

end event

event carga;this.reset()
return this.rowcount()
end event

