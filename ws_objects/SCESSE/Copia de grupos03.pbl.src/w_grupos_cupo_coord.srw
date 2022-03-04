$PBExportHeader$w_grupos_cupo_coord.srw
forward
global type w_grupos_cupo_coord from window
end type
type dw_profesor_auxiliar from uo_dw_captura within w_grupos_cupo_coord
end type
type dw_horario from uo_dw_captura within w_grupos_cupo_coord
end type
type st_periodo from statictext within w_grupos_cupo_coord
end type
type cb_1 from commandbutton within w_grupos_cupo_coord
end type
type uo_2 from uo_per_ani within w_grupos_cupo_coord
end type
type uo_3 from uo_nombre_profesor_cupo_coord within w_grupos_cupo_coord
end type
type dw_1 from uo_dw_captura within w_grupos_cupo_coord
end type
type uo_1 from uo_grupos_cupo_coord within w_grupos_cupo_coord
end type
type dw_sdw from datawindow within w_grupos_cupo_coord
end type
end forward

global type w_grupos_cupo_coord from window
integer x = 846
integer y = 372
integer width = 3250
integer height = 1936
boolean titlebar = true
string title = "Cambio de Cupo para Grupos"
string menuname = "m_grupos_impartidos_nvo_cupo_coor2"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 26439467
dw_profesor_auxiliar dw_profesor_auxiliar
dw_horario dw_horario
st_periodo st_periodo
cb_1 cb_1
uo_2 uo_2
uo_3 uo_3
dw_1 dw_1
uo_1 uo_1
dw_sdw dw_sdw
end type
global w_grupos_cupo_coord w_grupos_cupo_coord

type variables
boolean ib_borrando= false
long il_cve_asimilada
integer ii_cupo, ii_coord_usuario
string is_gpo_asimilado

end variables

forward prototypes
public function boolean wf_existe_hor_duplicado (integer ai_cve_dia, integer ai_hora_inicio, integer al_num_row)
public function integer wf_cuenta_horas_totales ()
public function boolean wf_obten_ocupados_sdu (long al_cve_coordinacion, integer ai_cve_dia, integer ai_hora_inicio, integer ai_cupo, integer ai_derecho, integer ai_ocupados)
public function boolean wf_dec_ocupado_sdu (long al_cve_coordinacion, integer ai_cve_dia, integer ai_hora_inicio, integer ai_cupo, integer ai_derecho, ref integer ai_ocupados, integer ai_es_nuevo, integer ai_es_previo)
public function boolean wf_inc_ocupado_sdu (long al_cve_coordinacion, integer ai_cve_dia, integer ai_hora_inicio, integer ai_cupo, integer ai_derecho, ref integer ai_ocupados, integer ai_es_nuevo, integer ai_es_previo)
public function integer wf_borra_previos ()
public function boolean wf_existe_hor_encimado (integer ai_cve_dia, integer ai_hora_inicio, integer ai_hora_final, integer al_num_row)
public function boolean wf_existe_prof_duplicado (long al_cve_profesor_adj, long al_num_row)
public function boolean wf_puede_dec_derecho_uso (long al_cve_mat, integer ai_dia, integer ai_hor_ini, integer ai_hor_fin, integer ai_cupo, boolean ab_desc_sdu_se, integer ai_es_nuevo, integer ai_es_previo)
public function boolean wf_puede_inc_derecho_uso (long al_cve_mat, integer ai_dia, integer ai_hor_ini, integer ai_hor_fin, integer ai_cupo, boolean ab_desc_sdu_se, integer ai_es_nuevo, integer ai_es_previo)
public function integer wf_actualiza_sdu ()
end prototypes

public function boolean wf_existe_hor_duplicado (integer ai_cve_dia, integer ai_hora_inicio, integer al_num_row);//wf_existe_hor_duplicado
//Revisa que el horario escrito no se encuentre duplicado
//
//ai_cve_dia		integer
//ai_hora_inicio	integer
//al_num_row		long
//

integer li_cve_dia, li_hora_inicio
long ll_row_horario


For ll_row_horario = 1 To dw_horario.RowCount()
	li_cve_dia 		= dw_horario.GetItemNumber(ll_row_horario,"cve_dia")
	li_hora_inicio	= dw_horario.GetItemNumber(ll_row_horario,"hora_inicio")
	if ll_row_horario <> al_num_row then		
		if li_cve_dia = ai_cve_dia and li_hora_inicio= ai_hora_inicio then
			return true
		end if
	end if	
Next
return false
end function

public function integer wf_cuenta_horas_totales ();integer  li_hora_inicio, li_hora_final, li_horas_dadas, li_horas_totales
long ll_row_horario


For ll_row_horario = 1 To dw_horario.RowCount()
	li_hora_inicio = dw_horario.GetItemNumber(ll_row_horario,"hora_inicio")
	li_hora_final	= dw_horario.GetItemNumber(ll_row_horario,"hora_final")
	li_horas_dadas = li_hora_final - li_hora_inicio 
	li_horas_totales = li_horas_totales + li_horas_dadas
Next

return li_horas_totales


end function

public function boolean wf_obten_ocupados_sdu (long al_cve_coordinacion, integer ai_cve_dia, integer ai_hora_inicio, integer ai_cupo, integer ai_derecho, integer ai_ocupados);//wf_obten_ocupados_sdu
//Recibe:
//al_cve_coordinacion	long
//ai_cve_dia				integer
//ai_hora_inicio			integer
//ai_cupo					integer
//ai_derecho				integer
//ai_ocupados				integer
long ll_row_find, ll_row_insert, ll_num_rows
string ls_condicion 
integer li_ocupados
boolean lb_ocupados
ls_condicion = "cve_coordinacion = "+string(al_cve_coordinacion) + " and cve_dia = "+string(ai_cve_dia) + &
 	" and hora_inicio = "+string(ai_hora_inicio)
ll_num_rows=  dw_sdw.RowCount()

ll_row_find = dw_sdw.Find(ls_condicion,1, ll_num_rows)

li_ocupados=0

if ll_row_find = 0 then
	li_ocupados= 0
	lb_ocupados = true
elseif ll_row_find > 0 then	
	li_ocupados = dw_sdw.GetItemNumber(ll_row_find,"ocupados")	
	lb_ocupados = true
else 
	Messagebox ("Error de consulta", "No es posible consultar SDU", StopSign!)
	lb_ocupados = false
	li_ocupados= 0
end if

ai_ocupados= li_ocupados

return lb_ocupados


end function

public function boolean wf_dec_ocupado_sdu (long al_cve_coordinacion, integer ai_cve_dia, integer ai_hora_inicio, integer ai_cupo, integer ai_derecho, ref integer ai_ocupados, integer ai_es_nuevo, integer ai_es_previo);//wf_dec_ocupado_sdu
//Recibe:
//al_cve_coordinacion	long
//ai_cve_dia				integer
//ai_hora_inicio			integer
//ai_cupo					integer
//ai_derecho				integer
//ai_ocupados				integer
//ai_es_nuevo				integer
//ai_es_previo				integer

long ll_row_find, ll_row_insert, ll_num_rows
string ls_condicion 
integer li_ocupados
boolean lb_incremento
ls_condicion = "cve_coordinacion = "+string(al_cve_coordinacion) + " and cve_dia = "+string(ai_cve_dia) + &
 	" and hora_inicio = "+string(ai_hora_inicio)
ll_num_rows=  dw_sdw.RowCount()

ll_row_find = dw_sdw.Find(ls_condicion,1, ll_num_rows)

li_ocupados=0

if ll_row_find = 0 then
	li_ocupados= -1
	ll_row_insert=dw_sdw.InsertRow(0)
	dw_sdw.SetItem(ll_row_insert, "cve_coordinacion", al_cve_coordinacion)
	dw_sdw.SetItem(ll_row_insert, "cve_dia", ai_cve_dia)
	dw_sdw.SetItem(ll_row_insert, "hora_inicio", ai_hora_inicio)
	dw_sdw.SetItem(ll_row_insert, "cupo", ai_cupo)
	dw_sdw.SetItem(ll_row_insert, "derecho", ai_derecho)
	dw_sdw.SetItem(ll_row_insert, "ocupados", li_ocupados)
	dw_sdw.SetItem(ll_row_insert, "es_nuevo", ai_es_nuevo)
	dw_sdw.SetItem(ll_row_insert, "es_previo", ai_es_previo)
	lb_incremento = true
elseif ll_row_find > 0 then	
	li_ocupados = dw_sdw.GetItemNumber(ll_row_find,"ocupados")
	li_ocupados = li_ocupados - 1 
	dw_sdw.SetItem(ll_row_find, "ocupados", li_ocupados)
	dw_sdw.SetItem(ll_row_find, "es_previo", ai_es_previo)
	lb_incremento = true
else 
	Messagebox ("Error de consulta", "No es posible consultar SDU", StopSign!)
	lb_incremento = false
end if
ai_ocupados= li_ocupados

return lb_incremento


end function

public function boolean wf_inc_ocupado_sdu (long al_cve_coordinacion, integer ai_cve_dia, integer ai_hora_inicio, integer ai_cupo, integer ai_derecho, ref integer ai_ocupados, integer ai_es_nuevo, integer ai_es_previo);//wf_inc_ocupado_sdu
//Recibe:
//al_cve_coordinacion	long
//ai_cve_dia				integer
//ai_hora_inicio			integer
//ai_cupo					integer
//ai_derecho				integer
//ai_ocupados				integer
//ai_es_previo				integer
long ll_row_find, ll_row_insert, ll_num_rows
string ls_condicion 
integer li_ocupados
boolean lb_incremento
ls_condicion = "cve_coordinacion = "+string(al_cve_coordinacion) + " and cve_dia = "+string(ai_cve_dia) + &
 	" and hora_inicio = "+string(ai_hora_inicio)
ll_num_rows=  dw_sdw.RowCount()

ll_row_find = dw_sdw.Find(ls_condicion,1, ll_num_rows)

li_ocupados= 0
if ll_row_find = 0 then
	li_ocupados= 1
	ll_row_insert=dw_sdw.InsertRow(0)
	dw_sdw.SetItem(ll_row_insert, "cve_coordinacion", al_cve_coordinacion)
	dw_sdw.SetItem(ll_row_insert, "cve_dia", ai_cve_dia)
	dw_sdw.SetItem(ll_row_insert, "hora_inicio", ai_hora_inicio)
	dw_sdw.SetItem(ll_row_insert, "cupo", ai_cupo)
	dw_sdw.SetItem(ll_row_insert, "derecho", ai_derecho)
	dw_sdw.SetItem(ll_row_insert, "ocupados", li_ocupados)
	dw_sdw.SetItem(ll_row_insert, "es_nuevo", ai_es_nuevo)
	dw_sdw.SetItem(ll_row_insert, "es_previo", ai_es_previo)
	lb_incremento= true
elseif ll_row_find > 0 then	
	li_ocupados = dw_sdw.GetItemNumber(ll_row_find,"ocupados")
	li_ocupados = li_ocupados + 1 
	dw_sdw.SetItem(ll_row_find, "ocupados", li_ocupados)
	dw_sdw.SetItem(ll_row_find, "es_previo", ai_es_previo)
	lb_incremento= true
else 
	Messagebox ("Error de consulta", "No es posible consultar SDU", StopSign!)
	lb_incremento= false
end if

ai_ocupados= li_ocupados

return lb_incremento


end function

public function integer wf_borra_previos ();long ll_num_rows, ll_row_indice, ll_row_actual
integer li_es_nuevo, li_es_previo, li_ocupados, li_cve_dia, li_hora_inicio, li_res_del

ll_num_rows = dw_sdw.RowCount()

for ll_row_indice=1 to dw_sdw.RowCount()	
	dw_sdw.ScrollToRow(ll_row_indice)
	li_cve_dia=  dw_sdw.GetItemNumber(dw_sdw.GetRow(), "cve_dia")
	li_hora_inicio=  dw_sdw.GetItemNumber(dw_sdw.GetRow(), "hora_inicio")
	li_es_previo=  dw_sdw.GetItemNumber(dw_sdw.GetRow(), "es_previo")
	li_es_nuevo=  dw_sdw.GetItemNumber(dw_sdw.GetRow(), "es_nuevo")
	li_ocupados=  dw_sdw.GetItemNumber(dw_sdw.GetRow(), "ocupados")
	if li_es_nuevo = 1 then
		li_res_del= dw_sdw.DeleteRow(0)
	else
		if li_es_previo = 1 then
			li_ocupados = li_ocupados - 1
			dw_sdw.SetItem(dw_sdw.GetRow(), "ocupados", li_ocupados)
		end if
	end if
next

return 0

end function

public function boolean wf_existe_hor_encimado (integer ai_cve_dia, integer ai_hora_inicio, integer ai_hora_final, integer al_num_row);//wf_existe_hor_encimado
//Revisa que el horario escrito no se encuentre encimado
//
//ai_cve_dia		integer
//ai_hora_inicio	integer
//ai_hora_final	integer
//al_num_row		long
//

integer li_cve_dia, li_hora_inicio, li_hora_final, li_hora_final_menos_uno
long ll_row_horario

ai_hora_final = ai_hora_final - 1

For ll_row_horario = 1 To dw_horario.RowCount()
	li_cve_dia 		= dw_horario.GetItemNumber(ll_row_horario,"cve_dia")
	li_hora_inicio	= dw_horario.GetItemNumber(ll_row_horario,"hora_inicio")
	li_hora_final	= dw_horario.GetItemNumber(ll_row_horario,"hora_final")
	li_hora_final_menos_uno = li_hora_final - 1
	if ll_row_horario <> al_num_row then		
		if li_cve_dia = ai_cve_dia and &
		   ((li_hora_inicio <= ai_hora_inicio and ai_hora_inicio <= li_hora_final_menos_uno) or &
		    (li_hora_inicio <= ai_hora_final and ai_hora_final <= li_hora_final_menos_uno))  then
			return true
		end if
	end if	
Next
return false
end function

public function boolean wf_existe_prof_duplicado (long al_cve_profesor_adj, long al_num_row);//wf_existe_prof_duplicado
//Revisa que el profesor escrito no se encuentre duplicado
//
//al_cve_profesor_adj	long
//al_num_row				long


integer li_cve_dia, li_hora_inicio
long ll_row_prof, ll_cve_profesor_adj


For ll_row_prof = 1 To dw_profesor_auxiliar.RowCount()
	ll_cve_profesor_adj 		= dw_profesor_auxiliar.GetItemNumber(ll_row_prof,"cve_profesor")
	if ll_row_prof <> al_num_row then		
		if ll_cve_profesor_adj = al_cve_profesor_adj then
			return true
		end if
	end if	
Next
return false
end function

public function boolean wf_puede_dec_derecho_uso (long al_cve_mat, integer ai_dia, integer ai_hor_ini, integer ai_hor_fin, integer ai_cupo, boolean ab_desc_sdu_se, integer ai_es_nuevo, integer ai_es_previo);//wf_puede_dec_derecho_uso
//Revisa si es posible decrementar el derecho uso
//       en base a los valores recibidos
//al_cve_mat			integer
//ai_dia					integer
//ai_hor_ini			integer
//ai_hor_fin			integer
//ai_cupo				integer	
//ab_desc_sdu_se		boolean
//ai_es_nuevo			integer
//ai_es_previo			integer

Integer Depto=0, li_diferencia,hora_inicio_sdu,li_ciclo, li_dec_ocupado_sdu, li_ocupados, li_derecho
Boolean ConsultaDepto = False, lb_dec_ocupado_sdu
String ls_mensaje

If ab_desc_sdu_se Then
// Servicios Escolares
	Depto = 7300 
	ConsultaDepto = False
Else
	ConsultaDepto = True
End If	


If ConsultaDepto Then
	Select cve_coordinacion
	Into 	:depto
	From 	materias
	Where	cve_mat = :al_cve_mat using gtr_sce;
	If gtr_sce.sqlcode <> 0 Then 
		Messagebox("Error al consultar la coordinacion",gtr_sce.sqlerrtext)
   	Return False
	End if
End If
If gtr_sce.sqlcode = 0 or Depto = 7300 Then	
	If ai_hor_fin > ai_hor_ini Then
		li_diferencia = ai_hor_fin - ai_hor_ini
		hora_inicio_sdu = ai_hor_ini
		FOR li_ciclo=1 TO li_diferencia
			
			SELECT ocupados, 
					derecho
			INTO  :li_ocupados, 
					:li_derecho // Obtiene los ocupados
			FROM  salones_derecho_uso
			Where (cve_coordinacion	= :depto) and (cve_dia	= :ai_dia) and
					(hora_inicio = :Hora_inicio_sdu) using gtr_sce;
//					and (ocupados <> 0) 
//					and (cupo	= :ai_cupo) 

			lb_dec_ocupado_sdu = wf_dec_ocupado_sdu(depto, ai_dia,  Hora_inicio_sdu, 0, li_derecho, li_dec_ocupado_sdu, ai_es_nuevo, ai_es_previo)

			hora_inicio_sdu ++
//			If gtr_sce.sqlcode = -1 Then
//				ls_mensaje = gtr_sce.sqlerrtext
//				ROLLBACK USING gtr_sce;
//				MessageBox("Error al decrementar el derecho y uso",ls_mensaje)
//				Return False
//			Else
//				COMMIT USING gtr_sce;
//			End If	
		Next
		Return True
	Else
		Messagebox("Aviso","el horario no es valido, favor de verificar")
		Return False
	End If
	Messagebox("Error","al obtener la clave del departamento")
	Return False
End If 

end function

public function boolean wf_puede_inc_derecho_uso (long al_cve_mat, integer ai_dia, integer ai_hor_ini, integer ai_hor_fin, integer ai_cupo, boolean ab_desc_sdu_se, integer ai_es_nuevo, integer ai_es_previo);//wf_puede_inc_derecho_uso
//Incrementa el derecho uso en base a los valores recibidos
//al_cve_mat			integer
//ai_dia					integer
//ai_hor_ini			integer
//ai_hor_fin			integer
//ai_cupo				integer
//ab_desc_sdu_se		boolean	
//ai_es_nuevo			integer
//ai_es_previo			integer


Integer Depto=0,li_diferencia, hora_inicio_sdu,li_ciclo, Derecho=0,Ocupados=0, li_ocupados_sdu
Integer li_inc_ocupado_sdu, li_num_incrementos, li_inc_actual, li_des_ocupados_sdu
Boolean TieneDerechoTodosOk = True, ConsultaDepto = False, lb_ocupados_sdu, lb_inc_ocupado_sdu
Boolean lb_dec_ocupado_sdu
String ls_mensaje
Integer li_hora_inicio_array[], li_hora_inicio

ConsultaDepto = True
li_num_incrementos = 0
If ab_desc_sdu_se Then
// Servicios Escolares
	Depto = 7300 
	ConsultaDepto = False
Else
	ConsultaDepto = True
End If	


If ConsultaDepto Then
	Select cve_coordinacion
	Into 	:depto
	From 	materias
	Where	cve_mat = :al_cve_mat using gtr_sce;	
	If gtr_sce.sqlcode <> 0 Then 
		Messagebox("Error al consultar la coordinacion",gtr_sce.sqlerrtext)
		Return False
	End if
End If

IF gtr_sce.sqlcode = 0 or Depto = 7300 Then	
	IF ai_hor_fin > ai_hor_ini Then
		li_diferencia = ai_hor_fin - ai_hor_ini
		hora_inicio_sdu = ai_hor_ini
		FOR li_ciclo=1 TO li_diferencia
			Select derecho,ocupados
			Into :Derecho,:Ocupados
			From salones_derecho_uso
			Where	(cve_coordinacion	= :depto) and (cve_dia = :ai_dia) and
					(hora_inicio = :Hora_inicio_sdu) 
					using gtr_sce;
//					and (cupo = :ai_cupo) 
			IF gtr_sce.sqlcode = 0 Then			
				lb_ocupados_sdu = wf_obten_ocupados_sdu(depto, ai_dia,  Hora_inicio_sdu, 0, Derecho, li_ocupados_sdu)
				Ocupados = Ocupados + li_ocupados_sdu
				IF Ocupados >= Derecho Then
					TieneDerechoTodosOk = False
					Messagebox("No tiene derecho","Hora Inicio = "+string(Hora_inicio_sdu)+" Ocupados = "+string(Ocupados)+" Derecho = "+string(Derecho))  								 
				Else	
					li_num_incrementos = li_num_incrementos + 1
					lb_inc_ocupado_sdu = wf_inc_ocupado_sdu(depto, ai_dia,  Hora_inicio_sdu, 0, Derecho, li_inc_ocupado_sdu, ai_es_nuevo, ai_es_previo)
					li_hora_inicio_array[li_num_incrementos]= Hora_inicio_sdu
					
//					Update salones_derecho_uso
//					Set ocupados = ocupados + 1 // Incrementa uno en el campo de ocupados 
//					Where (cve_coordinacion	= :depto) and (cve_dia	= :ai_dia) and
//							(hora_inicio = :Hora_inicio_sdu) 							
//							using gtr_sce;
//							and(cupo	= :ai_cupo) 
//					IF gtr_sce.sqlcode <> 0 Then
//						TieneDerechoTodosOk= False
//						ls_mensaje = gtr_sce.sqlerrtext
//						ROLLBACK USING gtr_sce;
//						Messagebox("Error al actualizar la tabla derecho_y_uso",ls_mensaje)
//					Else
//						COMMIT USING gtr_sce;
// 				End IF	
				End IF
			Else
				TieneDerechoTodosOk = False
				Messagebox("No tiene asignado un derecho y uso para:","Dia "+Dia_String(ai_dia)+"~nHora Inicio "+string(Hora_inicio_sdu)+"~nCupo "+string(ai_cupo)+" "+gtr_sce.sqlerrtext)
			End IF // Sqlcode del select 
			hora_inicio_sdu ++
		Next
	Else
		TieneDerechoTodosOk = False
		Messagebox("Aviso","El horario no es valido, favor de Verificar")
	End IF
Else	
	TieneDerechoTodosOk = False
	Messagebox("Error","Al obtener el numero de coordinacion")
End IF 

IF TieneDerechoTodosOk Then
	Return True
Else
	for li_inc_actual = 1 to li_num_incrementos 
		li_hora_inicio= li_hora_inicio_array[li_inc_actual]
		lb_dec_ocupado_sdu = wf_dec_ocupado_sdu(depto, ai_dia,  li_hora_inicio, 0, Derecho, li_des_ocupados_sdu, ai_es_nuevo, ai_es_previo)	
	next

	Return False
End IF	

end function

public function integer wf_actualiza_sdu ();dwItemStatus l_status, l_status_deleted
boolean lb_desc_sdu_se, lb_dec_derecho_uso
long ll_cve_mat
integer li_cupo
integer li_clase_aula_orig, li_clase_aula, li_cve_dia, li_hora_inicio, li_hora_final
integer li_cve_dia_orig, li_hora_inicio_orig, li_hora_final_orig
long ll_row_horario, ll_row_sdu, ll_num_rows_sdu, ll_cve_coordinacion_sdu
integer li_cve_dia_sdu, li_hora_inicio_sdu, li_cupo_sdu, li_derecho_sdu, li_ocupados_sdu
integer li_abs_ocupados_sdu, li_indice_dec, li_hora_final_sdu, li_es_nuevo
long ll_num_rows_deleted, ll_row_deleted
integer  li_clase_aula_orig_del, li_cve_dia_orig_del
integer li_hora_inicio_orig_del, li_hora_final_orig_del

ll_cve_mat = uo_1.il_cve_mat  
lb_desc_sdu_se= uo_1.ib_desc_sdu_se
li_cupo = ii_cupo
wf_borra_previos()

ll_num_rows_deleted = dw_horario.DeletedCount()

For ll_row_deleted = 1 to ll_num_rows_deleted
	l_status_deleted = dw_horario.GetItemStatus(ll_row_deleted, 0, Delete!)
	li_clase_aula_orig_del = dw_horario.GetItemNumber(ll_row_deleted,"clase_aula", Delete!, true)
	If l_status_deleted =DataModified! or l_status_deleted = NotModified! THEN
//Si el registro se modifico, al ser eliminado hay que decrementar los ocupados del horario original
//e incrementar los actualmente capturados
		li_cve_dia_orig_del = dw_horario.GetItemNumber(ll_row_deleted,"cve_dia", Delete!, true)
		li_hora_inicio_orig_del = dw_horario.GetItemNumber(ll_row_deleted,"hora_inicio", Delete!, true)
		li_hora_final_orig_del = dw_horario.GetItemNumber(ll_row_deleted,"hora_final", Delete!, true)
		//El registro anterior era salon
		If li_clase_aula_orig_del= 0 Then
			//Decrementa el derecho y uso del registro anterior
			If not f_dec_derecho_uso_sc(ll_cve_mat, li_cve_dia_orig_del, li_hora_inicio_orig_del, li_hora_final_orig_del, li_cupo, lb_desc_sdu_se) Then			
				Return -1 // Evento CambiaCupo
		   End if
		End if // Si registro anterior no era salon no es necesario decrementar los ocupados
	End if
Next


For ll_row_horario = 1 To dw_horario.RowCount()
	li_clase_aula_orig = dw_horario.GetItemNumber(ll_row_horario,"clase_aula", Primary!, true)
	li_clase_aula = dw_horario.GetItemNumber(ll_row_horario,"clase_aula")
	li_cve_dia 		= dw_horario.GetItemNumber(ll_row_horario,"cve_dia")
	li_hora_inicio	= dw_horario.GetItemNumber(ll_row_horario,"hora_inicio")
	li_hora_final	= dw_horario.GetItemNumber(ll_row_horario,"hora_final")
	l_status = dw_horario.GetItemStatus(ll_row_horario, 0, Primary!)
//Si el registro es nuevo y es salon, hay que incrementar los ocupados en salones_derecho_uso
		If (l_status = New! or l_status = NewModified!) and (li_clase_aula= 0) then
			if not f_inc_derecho_uso_sc(ll_cve_mat, li_cve_dia, li_hora_inicio, li_hora_final, li_cupo, lb_desc_sdu_se) Then
				Return -1 // Evento CambiaCupo
		   End if
		Elseif l_status =DataModified! tHEN
//Si el regisro se modifico, hay que decrementar los ocupados del horario original
//e incrementar los actualmente capturados
			li_cve_dia_orig = dw_horario.GetItemNumber(ll_row_horario,"cve_dia", Primary!, true)
			li_hora_inicio_orig = dw_horario.GetItemNumber(ll_row_horario,"hora_inicio", Primary!, true)
			li_hora_final_orig = dw_horario.GetItemNumber(ll_row_horario,"hora_final", Primary!, true)
			//El registro anterior era salon
			If li_clase_aula_orig= 0 Then
				//Decrementa el derecho y uso del registro anterior
				If f_dec_derecho_uso_sc(ll_cve_mat, li_cve_dia_orig, li_hora_inicio_orig, li_hora_final_orig, li_cupo, lb_desc_sdu_se) Then			
					// El horario actual es salon
					If li_clase_aula= 0 Then
						//Incrementa el derecho y uso correspondiente a los horarios capturados
						if not f_inc_derecho_uso_sc(ll_cve_mat, li_cve_dia, li_hora_inicio, li_hora_final, li_cupo, lb_desc_sdu_se) Then
							Return -1 // Evento CambiaCupo
					   End if
					End if
				Else
					Return -1 // Evento CambiaCupo
			   End if
			Else  // Si registro anterior no era salon no es necesario decrementar los ocupados
				// El horario actual es salon
				If li_clase_aula= 0 Then
					//Incrementa el derecho y uso correspondiente a los horarios capturados
					if not f_inc_derecho_uso_sc(ll_cve_mat, li_cve_dia, li_hora_inicio, li_hora_final, li_cupo, lb_desc_sdu_se) Then
						Return -1 // Evento CambiaCupo
				   End if
				End if				
			End if
		End if
Next	

Return 1

end function

on w_grupos_cupo_coord.create
if this.MenuName = "m_grupos_impartidos_nvo_cupo_coor2" then this.MenuID = create m_grupos_impartidos_nvo_cupo_coor2
this.dw_profesor_auxiliar=create dw_profesor_auxiliar
this.dw_horario=create dw_horario
this.st_periodo=create st_periodo
this.cb_1=create cb_1
this.uo_2=create uo_2
this.uo_3=create uo_3
this.dw_1=create dw_1
this.uo_1=create uo_1
this.dw_sdw=create dw_sdw
this.Control[]={this.dw_profesor_auxiliar,&
this.dw_horario,&
this.st_periodo,&
this.cb_1,&
this.uo_2,&
this.uo_3,&
this.dw_1,&
this.uo_1,&
this.dw_sdw}
end on

on w_grupos_cupo_coord.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_profesor_auxiliar)
destroy(this.dw_horario)
destroy(this.st_periodo)
destroy(this.cb_1)
destroy(this.uo_2)
destroy(this.uo_3)
destroy(this.dw_1)
destroy(this.uo_1)
destroy(this.dw_sdw)
end on

event open;long ll_row
int li_retorno, li_periodo, li_anio, li_coord_usuario

/**/gnv_app.inv_security.of_SetSecurity(this)

li_retorno = f_obten_periodo(li_periodo, li_anio, 4)
li_coord_usuario = uo_1.ii_cve_coordinacion
ii_coord_usuario = li_coord_usuario
if li_retorno = -1 then
	MessageBox("Error en calendario", "No es posible leer el periodo de carga de coordinadores",StopSign!)
	if li_coord_usuario <> 9999 then
		close(this	)
	end if
end if
//si el usuario es coordinador, no puede modificar el periodo
if li_coord_usuario <> 9999 then
	uo_2.visible= false
	cb_1.visible= false
else
	uo_2.visible= true
	cb_1.visible= true
end if


gi_anio=li_anio
gi_periodo=li_periodo
uo_2.em_ani.text = string(gi_anio)
uo_2.em_per.text = string(gi_periodo)

//ll_row= dw_1.InsertRow(0)
//dw_1.ScrollToRow(ll_row) 
cb_1.TriggerEvent(Clicked!)

end event

event closequery;long ll_row
long ll_cve_mat
integer li_desea_salir
string ls_gpo
long ll_profesores_modificados, ll_profesores_borrados
long ll_grupos_modificados, ll_grupos_borrados
long ll_horarios_modificados, ll_horarios_borrados, ll_suma_cambios

ll_grupos_modificados= this.dw_1.modifiedcount()
ll_grupos_borrados= this.dw_1.deletedcount()

ll_horarios_modificados= this.dw_horario.modifiedcount()
ll_horarios_borrados= this.dw_horario.deletedcount()

ll_profesores_modificados= this.dw_profesor_auxiliar.modifiedcount()
ll_profesores_borrados= this.dw_profesor_auxiliar.deletedcount()

ll_suma_cambios =ll_grupos_modificados+ll_grupos_borrados+ll_horarios_modificados+& 
                 ll_horarios_borrados +ll_profesores_modificados+ll_profesores_borrados


ll_row = dw_1.GetRow()

ll_cve_mat = uo_1.il_cve_mat
ls_gpo = uo_1.is_gpo

//No permite cerrar la ventana si existen errores de informacion
if ll_row >0 and not(ll_cve_mat=0 and ls_gpo="") then
	if ll_suma_cambios>0 then

		if this.dw_1.event valida() <> 1 then
			li_desea_salir= messagebox("Error de captura",&
		           "¿Desea salir SIN ALMACENAR los cambios realizados al grupo actual ["+string(ll_cve_mat)+"-"+ls_gpo+"] ?:",Question!, YesNo!)
			ib_borrando= false	
			if li_desea_salir= 2 then
				return 1
			else		
				return 0
			end if
		else
			return 0				
		end if	
	else	
		return 0		
	end if
	return 0
end if
return 0




end event

type dw_profesor_auxiliar from uo_dw_captura within w_grupos_cupo_coord
event type integer borra_actual ( )
event type integer borra_todo ( )
boolean visible = false
integer x = 82
integer y = 1280
integer width = 2743
integer height = 220
integer taborder = 0
boolean enabled = false
string dataobject = "d_profesor_auxiliar_cupo_coord"
boolean hscrollbar = true
end type

event borra_actual;//DESCRIPCIÓN: Borra el profesor actual

integer li_res_del
long ll_row, ll_num_rows, ll_row_actual, ll_rows_nuevos[], ll_indice_array, ll_tam_array

ll_row_actual = GetRow()
ll_num_rows = RowCount()	


li_res_del= DeleteRow(ll_row_actual)


return 1

end event

event borra_todo;//DESCRIPCIÓN: Borra todos los profesores y actualiza.

long ll_cve_mat
integer li_cve_coordinacion, li_periodo, li_anio, li_respuesta, li_res_del, li_res_upd
string ls_gpo, ls_mensaje_sql
long ll_row, ll_num_rows, ll_row_horario
integer li_cve_dia_orig, li_hora_inicio_orig, li_hora_final_orig, li_cupo
dwItemStatus l_status
boolean lb_desc_sdu_se

ll_cve_mat= uo_1.il_cve_mat
ls_gpo = uo_1.is_gpo
li_periodo = uo_1.ii_periodo
li_anio = uo_1.ii_anio
lb_desc_sdu_se= uo_1.ib_desc_sdu_se

	
	
ll_num_rows = RowCount()

for ll_row=1 to ll_num_rows
	li_res_del= DeleteRow(0)
	if li_res_del= -1 then
		return -1
	end if
next

return 1
//if ib_borrando then
//	li_res_upd= Update()
//	ls_mensaje_sql= gtr_sce.SqlErrText
//	IF li_res_upd = 1  THEN
//		COMMIT USING gtr_sce;
//	ELSE
//		ROLLBACK USING gtr_sce;
//		MessageBox("Error al eliminar el profesor adjunto", ls_mensaje_sql)
//		return -1
//	END IF
//
//	return 1
//else
//	return 1
//end if


end event

event asigna_dw_menu;///*
//DESCRIPCIÓN: Evento en el cual se asigna a la variable dw del menu este objeto.
//				En este evento se busca la ventana dueña del objeto y cual es su menu
//PARÁMETROS: Ninguno
//REGRESA: Nada
//AUTOR: CAMP(DkWf)
//FECHA: 17 Junio 1998
//MODIFICACIÓN:
//*/
//window ventana_propietaria
//
//ventana_propietaria = getparent()
//
//menu_propietario = ventana_propietaria.menuid
//
//menu_propietario.dw	= this
end event

event actualiza_np;//DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
//				La unica interacción con el usuario es mediante avisos de que los campos se guardaron o no
//PARÁMETROS: Ninguno
//REGRESA: Nada
//AUTOR: Antonio Pica
//FECHA: 17 Octubre 2000
//MODIFICACIÓN:


if event actualiza_0_int() = 1 then
	/*Si es asi, guardalo en la tabla y avisa.*/
//	messagebox("Información","Se han guardado los cambios")
	return 1
else
	/*De lo contrario, desecha los cambios (todos) y avisa*/
	messagebox("Información","Algunos datos están incorrectos, favor de corregirlos")	
	return -1
end if
end event

event actualiza;
//DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
//				
//PARÁMETROS: Ninguno
//REGRESA: Nada
//AUTOR: Antonio Pica Ruiz
//FECHA: 17 Octubre 2000
//MODIFICACIÓN:

int li_respuesta
//Acepta el texto de la última columna editada
AcceptText()
//Ve si existen cambios en el DataWindow que no se hayan guardado
if ModifiedCount()+DeletedCount() > 0 Then

//Pregunta si se desean guardar los cambios hechos
//li_respuesta = messagebox("Atención","Desea actualizar los cambios:",StopSign!,YesNo!,2)
	
	li_respuesta= 1
	
	if li_respuesta = 1 then
//			Checa que los renglones cumplan con las reglas de validación
			if event actualiza_np() = 1 then//Manda llamar la función que realiza el update
				return 1
			else 
				return -1
			end if
	else
//		De lo contrario, solo avisa que no se guardó nada.
		messagebox("Información","No se han guardado los cambios")
		return -1
	end if
else
	return 1
end if

end event

event borra;//DESCRIPCIÓN: Borra el renglon actual y actualiza.

long ll_cve_mat
integer li_cve_coordinacion, li_periodo, li_anio, li_respuesta
string ls_gpo
long ll_row

ll_cve_mat= uo_1.il_cve_mat
ls_gpo = uo_1.is_gpo
li_periodo = uo_1.ii_periodo
li_anio = uo_1.ii_anio
	
if not f_materia_valida(ll_cve_mat, li_cve_coordinacion) and &
	not f_grupo_valido(ls_gpo)  then
	MessageBox("Grupo Invalido", "Favor de Seleccionar materias y grupos validos ~nantes de "+&
	            "intentar una eliminacion de profesores.")
	uo_1.rb_editar.checked = true
	uo_1.is_estatus = "Modificar"
	return	
end if


li_respuesta = messagebox("Atención","Esta seguro de querer borrar el profesor actual.",StopSign!,YesNo!,2)

if li_respuesta = 1 then
	if deleterow(getrow())	= 1 then
		triggerevent("actualiza")
	else
		messagebox("Información","No se han guardado los cambios")	
	end if
elseif li_respuesta = 2 then
	rollback using gtr_sce;
end if

end event

event carga;//DESCRIPCIÓN: Antes de cargar algo, ve si hay modificaciones no guardadas.

if event actualiza()=1 then
	event primero()
	return dw_profesor_auxiliar.retrieve(uo_1.il_cve_mat, uo_1.is_gpo, uo_1.ii_periodo, uo_1.ii_anio)
end if

end event

event dberror;call super::dberror;return 0
end event

event inicia_transaction_object;tr_dw_propio = gtr_sce
this.SetTransObject(gtr_sce)
end event

event nuevo;long ll_cve_mat
integer li_cve_coordinacion, li_periodo, li_anio
string ls_gpo
long ll_row, ll_row_padre


ll_cve_mat= uo_1.il_cve_mat
ls_gpo = uo_1.is_gpo
li_periodo = uo_1.ii_periodo
li_anio = uo_1.ii_anio
ll_row_padre= dw_1.GetRow()

if not f_materia_valida(ll_cve_mat, li_cve_coordinacion) and &
	not f_grupo_valido(ls_gpo) then
	MessageBox("Grupo Invalido", "Favor de Seleccionar materias y grupos validos "+&	
	"antes de comenzar una Insercion de profesores.")
	uo_1.rb_editar.checked = true
	uo_1.is_estatus = "Modificar"
	return	
elseif ll_row_padre <= 0 then
	MessageBox("Profesor Invalido", "Favor de iniciar la insercion del grupo "+&
	            "antes de los profesores.")
	uo_1.rb_editar.checked = true
	uo_1.is_estatus = "Modificar"
	return	
end if

setfocus()
scrolltorow(insertrow(0))
ll_row = this.GetRow()
this.object.cve_mat[ll_row]= ll_cve_mat
this.object.gpo[ll_row]= ls_gpo
this.object.periodo[ll_row]= li_periodo
this.object.anio[ll_row]= li_anio
setcolumn("cve_categoria_auxiliar")



end event

event itemchanged;call super::itemchanged;string ls_columna, ls_apaterno, ls_amaterno, ls_nombre, ls_nombre_completo, ls_cve_profesor_ec
string ls_cve_profesor_dw, ls_nombre_completo_dw
boolean lb_modificando
long ll_cve_profesor_dw, ll_por_designar, ll_cve_profesor_ec

if lb_modificando then
	return
end if

lb_modificando = true

ll_por_designar= 1
ll_cve_profesor_dw = object.cve_profesor[row]
ls_nombre_completo_dw= object.nombre_completo[row] 
if isnull(ll_cve_profesor_dw) then
	ls_cve_profesor_dw = ""
else
	ls_cve_profesor_dw = string(ll_cve_profesor_dw)	
end if

if isnull(ls_nombre_completo_dw) then
	ls_nombre_completo_dw = ""
else
	ls_nombre_completo_dw = ls_nombre_completo_dw
end if

ls_columna =this.GetColumnName()

choose case ls_columna 
case "cve_profesor"
		ls_cve_profesor_ec = this.GetText()
		if isnumber(ls_cve_profesor_ec) then
			ll_cve_profesor_ec = long(ls_cve_profesor_ec)
		end if
		if not(f_profesor_valido(ll_cve_profesor_ec)) then
			MessageBox("Profesor Inexistente", &
			           "El profesor "+string(ll_cve_profesor_ec)+ " no existe registrado"+&
						   "~n o esta registrado como inactivo",StopSign!)
			this.SetText(string(ls_cve_profesor_dw))
			this.object.nombre_completo[row] = ls_nombre_completo_dw
//				ls_nombre_completo= f_obten_nombre_profesor(ll_por_designar,ls_apaterno, ls_amaterno, ls_nombre)
//			this.object.nombre_completo[row] = ls_nombre_completo
//			this.object.cve_profesor[row] = ll_por_designar
			lb_modificando = false
			return 2
		else
			ls_nombre_completo= f_obten_nombre_profesor(ll_cve_profesor_ec,ls_apaterno, ls_amaterno, ls_nombre)
			this.object.nombre_completo[row] = ls_nombre_completo
			lb_modificando = false
			return 0
		end if

end choose

lb_modificando = false
return 0


end event

event retrieveend;call super::retrieveend;string ls_columna, ls_apaterno, ls_amaterno, ls_nombre, ls_nombre_completo
long ll_row_actual, ll_cve_profesor

//Es Necesario actualizar el nombre completo, para no sobrecargar la red 
//en la utilizacion de un drop down datawindow

For ll_row_actual = 1 to  rowcount
	ll_cve_profesor = object.cve_profesor[ll_row_actual]
	ls_nombre_completo= f_obten_nombre_profesor(ll_cve_profesor,ls_apaterno, ls_amaterno, ls_nombre)
	this.object.nombre_completo[ll_row_actual] = ls_nombre_completo
	this.SetItemStatus(ll_row_actual, 0, Primary!, NotModified!)
Next
end event

type dw_horario from uo_dw_captura within w_grupos_cupo_coord
event type integer borra_todo ( )
event type integer borra_actual ( )
integer x = 425
integer y = 748
integer width = 1925
integer height = 348
integer taborder = 0
string dataobject = "d_gpo_imp_horario_cupo_coord"
borderstyle borderstyle = stylelowered!
end type

event borra_todo;//DESCRIPCIÓN: Borra todos los horario y actualiza.

long ll_cve_mat
integer li_cve_coordinacion, li_periodo, li_anio, li_respuesta, li_res_del, li_res_upd
string ls_gpo, ls_mensaje_sql
long ll_row, ll_num_rows, ll_row_horario
integer li_cve_dia_orig, li_hora_inicio_orig, li_hora_final_orig, li_cupo
dwItemStatus l_status
boolean lb_desc_sdu_se

ll_cve_mat= uo_1.il_cve_mat
ls_gpo = uo_1.is_gpo
li_periodo = uo_1.ii_periodo
li_anio = uo_1.ii_anio
lb_desc_sdu_se= uo_1.ib_desc_sdu_se

ll_num_rows = RowCount()	

//FOR ll_row_horario= 1 to ll_num_rows
//	l_status = dw_horario.GetItemStatus(ll_row_horario, 0, Primary!)
//	If l_status =DataModified! or l_status =NotModified! Then
////Si el regisro se modifico, hay que decrementar los ocupados del horario original
//		li_cve_dia_orig = dw_horario.GetItemNumber(ll_row_horario,"cve_dia", Primary!, true)
//		li_hora_inicio_orig = dw_horario.GetItemNumber(ll_row_horario,"hora_inicio", Primary!, true)
//		li_hora_final_orig = dw_horario.GetItemNumber(ll_row_horario,"hora_final", Primary!, true)
//		If not wf_puede_dec_derecho_uso(ll_cve_mat, li_cve_dia_orig, li_hora_inicio_orig, li_hora_final_orig, li_cupo, lb_desc_sdu_se, 0, 0) Then			
//			MessageBox("Error al eliminar el horario", "No se pudo decrementar salones_derecho_uso")
//			return -1
//		End If
//	End If
//NEXT
//	
	
	
ll_num_rows = RowCount()

for ll_row=1 to ll_num_rows
	li_res_del= DeleteRow(0)
	if li_res_del= -1 then
		return -1
	end if
next


return 1

end event

event borra_actual;//DESCRIPCIÓN: Borra el horario actual y actualiza.

long ll_cve_mat
integer li_cve_coordinacion, li_periodo, li_anio, li_respuesta, li_res_del, li_res_upd
string ls_gpo, ls_mensaje_sql
long ll_row, ll_num_rows, ll_row_horario, ll_row_actual, ll_rows_nuevos[], ll_indice_array, ll_tam_array
integer li_cve_dia_orig, li_hora_inicio_orig, li_hora_final_orig, li_cupo
dwItemStatus l_status
boolean lb_desc_sdu_se

ll_cve_mat= uo_1.il_cve_mat
ls_gpo = uo_1.is_gpo
li_periodo = uo_1.ii_periodo
li_anio = uo_1.ii_anio
lb_desc_sdu_se= uo_1.ib_desc_sdu_se

ll_row_actual = GetRow()
ll_num_rows = RowCount()	

ll_indice_array= 1
For ll_row= 1 to ll_num_rows
	l_status = dw_horario.GetItemStatus(ll_row, 0, Primary!)
	if l_status= New! or l_status = NewModified! then
		ll_rows_nuevos[ll_indice_array]= ll_row
	end if
Next

l_status = dw_horario.GetItemStatus(ll_row_actual, 0, Primary!)
If l_status =DataModified! or l_status =NotModified! Then
//Si el regisro se modifico, hay que decrementar los ocupados del horario original
	li_cve_dia_orig = dw_horario.GetItemNumber(ll_row_actual,"cve_dia", Primary!, true)
	li_hora_inicio_orig = dw_horario.GetItemNumber(ll_row_actual,"hora_inicio", Primary!, true)
	li_hora_final_orig = dw_horario.GetItemNumber(ll_row_actual,"hora_final", Primary!, true)
	If not wf_puede_dec_derecho_uso(ll_cve_mat, li_cve_dia_orig, li_hora_inicio_orig, li_hora_final_orig, li_cupo, lb_desc_sdu_se,0,0) Then			
		MessageBox("Error al eliminar el horario actual", "No se pudo decrementar salones_derecho_uso")
		return -1
	End If
End If
	
li_res_del= DeleteRow(ll_row_actual)

//If l_status =DataModified! or l_status =NotModified! Then
//	li_res_upd= Update()
//	ls_mensaje_sql= gtr_sce.SqlErrText
//	IF li_res_upd = 1  THEN
//		COMMIT USING gtr_sce;
//	ELSE
//		ROLLBACK USING gtr_sce;
//		MessageBox("Error al eliminar el horario", ls_mensaje_sql)
//		return -1
//	END IF
//End if
//
//
//ll_tam_array = UpperBound(ll_rows_nuevos)
//For ll_indice_array= 1 to ll_tam_array
//	ll_row= ll_rows_nuevos[ll_indice_array]
//	dw_horario.GetItemStatus(ll_row, 0, Primary!)
//	if l_status= New! or l_status = NewModified! then
//		ll_rows_nuevos[ll_indice_array]= ll_row
//	end if
//Next


return 1

end event

event nuevo;long ll_cve_mat
integer li_cve_coordinacion, li_periodo, li_anio
string ls_gpo
long ll_row, ll_row_padre


ll_cve_mat= uo_1.il_cve_mat
ls_gpo = uo_1.is_gpo
li_periodo = uo_1.ii_periodo
li_anio = uo_1.ii_anio
ll_row_padre= dw_1.GetRow()

if not f_materia_valida(ll_cve_mat, li_cve_coordinacion) and &
	not f_grupo_valido(ls_gpo) then
	MessageBox("Grupo Invalido", "Favor de Seleccionar materias y grupos validos antes de "+&
	            "comenzar una Insercion.")
	uo_1.rb_editar.checked = true
	uo_1.is_estatus = "Modificar"
	return	
elseif ll_row_padre <= 0 then
	MessageBox("Horario Invalido", "Favor de iniciar la insercion del grupo "+&
	            "antes de los horarios.")
	uo_1.rb_editar.checked = true
	uo_1.is_estatus = "Modificar"
	return	
end if

setfocus()
scrolltorow(insertrow(0))
setcolumn("clase_aula")
ll_row = this.GetRow()
this.object.cve_mat[ll_row]= ll_cve_mat
this.object.gpo[ll_row]= ls_gpo
this.object.periodo[ll_row]= li_periodo
this.object.anio[ll_row]= li_anio
setcolumn(1)


end event

event borra;//DESCRIPCIÓN: Borra el renglon actual y actualiza.

integer ll_cve_mat
integer li_cve_coordinacion, li_periodo, li_anio, li_respuesta
string ls_gpo
long ll_row

ll_cve_mat= uo_1.il_cve_mat
ls_gpo = uo_1.is_gpo
li_periodo = uo_1.ii_periodo
li_anio = uo_1.ii_anio
	
if not f_materia_valida(ll_cve_mat, li_cve_coordinacion) and &
	not f_grupo_valido(ls_gpo)  then
	MessageBox("Grupo Invalido", "Favor de Seleccionar materias y grupos validos antes de "+&
	            "intentar una eliminacion.")
	uo_1.rb_editar.checked = true
	uo_1.is_estatus = "Modificar"
	return	
end if


li_respuesta = messagebox("Atención","Esta seguro de querer borrar el horario actual.",StopSign!,YesNo!,2)

if li_respuesta = 1 then
	if deleterow(getrow())	= 1 then
		triggerevent("actualiza")
	else
		messagebox("Información","No se han guardado los cambios")	
	end if
elseif li_respuesta = 2 then
	rollback using gtr_sce;
end if

end event

event asigna_dw_menu;///*
//DESCRIPCIÓN: Evento en el cual se asigna a la variable dw del menu este objeto.
//				En este evento se busca la ventana dueña del objeto y cual es su menu
//PARÁMETROS: Ninguno
//REGRESA: Nada
//AUTOR: CAMP(DkWf)
//FECHA: 17 Junio 1998
//MODIFICACIÓN:
//*/
//window ventana_propietaria
//
//ventana_propietaria = getparent()
//
//menu_propietario = ventana_propietaria.menuid
//
//menu_propietario.dw	= this
end event

event inicia_transaction_object;tr_dw_propio = gtr_sce
this.SetTransObject(gtr_sce)
end event

event carga;//DESCRIPCIÓN: Antes de cargar algo, ve si hay modificaciones no guardadas.

if event actualiza()=1 then
	event primero()
	return dw_horario.retrieve(uo_1.il_cve_mat, uo_1.is_gpo, uo_1.ii_periodo, uo_1.ii_anio)
end if

end event

event dberror;call super::dberror;return 0
end event

event actualiza;
//DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
//				
//PARÁMETROS: Ninguno
//REGRESA: Nada
//AUTOR: Antonio Pica Ruiz
//FECHA: 17 Octubre 2000
//MODIFICACIÓN:

int li_respuesta
//Acepta el texto de la última columna editada
AcceptText()
//Ve si existen cambios en el DataWindow que no se hayan guardado
if ModifiedCount()+DeletedCount() > 0 Then

//Pregunta si se desean guardar los cambios hechos
//li_respuesta = messagebox("Atención","Desea actualizar los cambios:",StopSign!,YesNo!,2)
	
	li_respuesta= 1
	
	if li_respuesta = 1 then
//			Checa que los renglones cumplan con las reglas de validación
			if event actualiza_np() = 1 then//Manda llamar la función que realiza el update
				return 1
			else 
				return -1
			end if
	else
//		De lo contrario, solo avisa que no se guardó nada.
		messagebox("Información","No se han guardado los cambios")
		return -1
	end if
else
	return 1
end if

end event

event actualiza_np;//DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
//				La unica interacción con el usuario es mediante avisos de que los campos se guardaron o no
//PARÁMETROS: Ninguno
//REGRESA: Nada
//AUTOR: Antonio Pica
//FECHA: 17 Octubre 2000
//MODIFICACIÓN:


if event actualiza_0_int() = 1 then
	/*Si es asi, guardalo en la tabla y avisa.*/
//	messagebox("Información","Se han guardado los cambios")
	return 1
else
	/*De lo contrario, desecha los cambios (todos) y avisa*/
	messagebox("Información","Algunos datos están incorrectos, favor de corregirlos")	
	return -1
end if
end event

type st_periodo from statictext within w_grupos_cupo_coord
integer x = 1161
integer y = 12
integer width = 681
integer height = 76
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_grupos_cupo_coord
integer x = 1125
integer y = 1564
integer width = 526
integer height = 108
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualiza Periodo"
end type

event clicked;long ll_row
int li_retorno, li_periodo, li_anio

uo_1.ii_periodo =gi_periodo
uo_1.ii_anio =gi_anio

choose case gi_periodo
	case 0
		st_periodo.text = "PRIMAVERA " + String(gi_anio)
	case 1
		st_periodo.text = "VERANO " + String(gi_anio)
	case 2
		st_periodo.text = "OTOÑO " + String(gi_anio)
end choose


if uo_1.is_estatus = "Insertar" then
	ll_row = dw_1.GetRow()
	dw_1.object.periodo[ll_row]= uo_1.ii_periodo
	dw_1.object.anio[ll_row]= uo_1.ii_anio
end if

end event

type uo_2 from uo_per_ani within w_grupos_cupo_coord
integer x = 1682
integer y = 1532
integer width = 1253
integer height = 168
integer taborder = 30
boolean enabled = true
boolean border = true
long backcolor = 1090519039
end type

on uo_2.destroy
call uo_per_ani::destroy
end on

type uo_3 from uo_nombre_profesor_cupo_coord within w_grupos_cupo_coord
integer x = 82
integer y = 1100
end type

on uo_3.destroy
call uo_nombre_profesor_cupo_coord::destroy
end on

type dw_1 from uo_dw_captura within w_grupos_cupo_coord
event type integer valida ( )
event nuevo_horario ( )
event borra_horario ( )
event type integer valida_borra ( )
event borra_horario_actual ( )
event borra_profesor_actual ( )
event nuevo_profesor ( )
integer x = 64
integer y = 400
integer width = 2866
integer height = 1120
integer taborder = 20
string dataobject = "d_grupos_imp_nvo_cupo_coord"
boolean vscrollbar = false
borderstyle borderstyle = styleraised!
end type

event type integer valida();//Funcion que revisa la logica de los grupos
string ls_estatus,ls_gpo, ls_gpo_asimilado, ls_dia
long ll_cve_mat, ll_cve_asimilada
integer li_periodo, li_anio, li_tipo, li_cve_dia, li_cupo
long ll_row, ll_num_horarios, ll_row_horario, ll_cve_profesor
integer li_hora_inicio, li_hora_final, li_cve_dia_orig, li_hora_inicio_orig, li_hora_final_orig
dwItemStatus l_status
integer li_horas_mat_permitidas, li_horas_capturadas, li_coord_usuario, li_cap_mas_horas
boolean lb_desc_sdu_se, lb_existe_salon, lb_salon_ocupado, lb_nuevo_adjunto
integer  li_clase_aula, li_null, li_acepta, li_clase_aula_orig
integer li_cve_dia_prim, li_cve_dia_del, li_cve_dia_filt, li_bloqueado
string ls_cve_salon, ls_clase_aula, ls_nombre_completo, ls_apaterno, ls_amaterno, ls_nombre
string ls_uo_cve_profesor
long ll_por_designar, ll_uo_cve_profesor, ll_cve_profesor_adj, ll_row_profesor, ll_num_profesores
integer li_horas, li_cve_categoria_auxiliar
datastore lds_data, lds_data2
long ll_num_cords, ll_suma_horas, ll_row_horas_coord, ll_horas_reales, ll_horas_gpo_normal
long ll_suma_horas_mas_actual, ll_num_cords2, ll_num_cords_adj, ll_num_cords2_adj, ll_horas_verano
string ls_coordinacion, ls_mensaje, ls_mensaje_adj, ls_salon_nulo
integer li_cve_categoria, li_inscritos, li_inscritos_antes, li_inscritos_despues, li_inscritos_intermedios
long ll_num_cambios_horario, ll_adjuntos_borrados, ll_adjuntos_modificados, ll_adjuntos_cambios
string ls_grupos_doble_presencia, ls_explicacion_intermedios

ll_horas_gpo_normal = 12
ll_horas_verano = 12
ll_por_designar = 1
SetNull(li_null)
SetNull(ls_salon_nulo)
ll_row = this.GetRow()
ls_estatus = uo_1.is_estatus
ll_cve_mat = uo_1.il_cve_mat
li_periodo = uo_1.ii_periodo
li_anio = uo_1.ii_anio
ls_gpo = uo_1.is_gpo
lb_desc_sdu_se= uo_1.ib_desc_sdu_se
li_coord_usuario = uo_1.ii_cve_coordinacion
ll_num_horarios=dw_horario.RowCount()
ll_num_profesores=dw_profesor_auxiliar.RowCount()
ll_adjuntos_borrados=dw_profesor_auxiliar.DeletedCount()
ll_adjuntos_modificados=dw_profesor_auxiliar.ModifiedCount()
dwItemStatus l_status_aux
ls_uo_cve_profesor= uo_3.em_cve_profesor.text

ll_cve_asimilada = object.cve_asimilada[ll_row]
ls_gpo_asimilado = object.gpo_asimilado[ll_row]
li_tipo = object.tipo[ll_row]
li_cupo = object.cupo[ll_row]
ii_cupo = li_cupo
li_inscritos_antes = object.inscritos[ll_row]
ll_adjuntos_cambios = ll_adjuntos_borrados+ll_adjuntos_modificados


event carga()
this.setitem(this.GetRow(),"cupo",li_cupo)
// Validaciones para registros nuevos
if ls_estatus = "Insertar" then
	
//Revisa que el grupo no se haya dado de alta previamente	
	if f_existe_grupo(ll_cve_mat, ls_gpo, li_periodo, li_anio) then
		MessageBox("Grupo Existente", "El grupo "+string(ll_cve_mat)+":"+ls_gpo+" ya existe.",StopSign!)
		return -1
	end if
// Validaciones para registros previamente existentes
elseif ls_estatus = "Modificar" then

end if

if isnull(li_tipo) then
	MessageBox("Grupo sin Tipo", "Es necesario elegir el tipo de grupo.",StopSign!)
	return -1
end if


//El grupo asimilado no puede ser el mismo que se esta registrando
if li_tipo =2 then
	//Revisa que el grupo no se haya dado de alta previamente

	MessageBox("Grupo Asimilado", "No se permite editar grupos asimilados.",StopSign!)
	return -1

end if

li_inscritos_despues = object.inscritos[ll_row]
li_inscritos= li_inscritos_despues
//if li_cupo < li_inscritos then
//	//Revisa que el grupo no se haya dado de alta previamente
//	li_inscritos_intermedios = li_inscritos_despues - li_inscritos_antes
//	if li_inscritos_intermedios> 0 then
//		ls_explicacion_intermedios = "~nSe inscribieron ["+string(li_inscritos_intermedios)+"] alumnos desde que seleccionó el grupo actual."
//		MessageBox("Cupo menor a Inscritos", "Favor de incrementar el cupo a un valor mayor o igual a los inscritos."+ls_explicacion_intermedios,StopSign!)
//	else
//		MessageBox("Cupo menor a Inscritos", "Favor de incrementar el cupo a un valor mayor o igual a los inscritos.",StopSign!)		
//	end if
//
//	return -1	
//end if

if li_cupo < 0 then
	MessageBox("Cupo Inválido", "Favor de incrementar el cupo a un valor positivo.",StopSign!)		
	return -1	
end if

return 1


end event

event nuevo_horario;dw_horario.TriggerEvent("nuevo")

end event

event borra_horario;dw_horario.TriggerEvent("borra_todo")

end event

event valida_borra;//Funcion que revisa la logica de los grupos
string ls_estatus,ls_gpo, ls_gpo_asimilado
long ll_cve_mat
integer li_periodo, li_anio
long ll_cve_asimilada
integer li_tipo, li_primer_sem
long ll_row, ll_num_horarios
integer li_borra_primer_sem, li_actual_gpos

ll_row = this.GetRow()
ls_estatus = uo_1.is_estatus
ll_cve_mat = uo_1.il_cve_mat
li_periodo = uo_1.ii_periodo
li_anio = uo_1.ii_anio
ls_gpo = uo_1.is_gpo
ll_num_horarios=dw_horario.RowCount()

ll_cve_asimilada = object.cve_asimilada[ll_row]
ls_gpo_asimilado = object.gpo_asimilado[ll_row]
li_tipo = object.tipo[ll_row]
li_primer_sem= object.primer_sem[ll_row]

il_cve_asimilada = ll_cve_asimilada
is_gpo_asimilado = ls_gpo_asimilado

// Validaciones para borrar registros de grupos
if ls_estatus = "Insertar" then
	
//Revisa que el grupo no se haya dado de alta previamente	
	if not f_existe_grupo(ll_cve_mat, ls_gpo, li_periodo, li_anio) then
		return 1
	end if
// Validaciones para registros previamente existentes
elseif ls_estatus = "Editar" then
	if f_grupo_que_asimila(ll_cve_mat, ls_gpo, li_periodo, li_anio) then
		MessageBox("El grupo no puede eliminarse por asimilar ", "El grupo "+string(ll_cve_mat)+":"+&
		ls_gpo+" esta registrado como que asimila a otro.",StopSign!)
		return -1
	end if
end if

if li_primer_sem = 1 then
	li_borra_primer_sem =MessageBox("Paquete de primer ingreso", "El grupo "+string(ll_cve_mat)+":"+&
		ls_gpo+" es de primer ingreso. ¿Desea eliminarlo?",Question!, YesNo!)
	if li_borra_primer_sem = 2 then
		return -1		
	end if
end if
// Validaciones para cualquier tipo de registro


return 1


end event

event borra_horario_actual;dw_horario.TriggerEvent("borra_actual")

end event

event borra_profesor_actual;dw_profesor_auxiliar.TriggerEvent("borra_actual")

end event

event nuevo_profesor;dw_profesor_auxiliar.TriggerEvent("nuevo")

end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
this.SetTransObject(gtr_sce)
end event

event carga;///*
//DESCRIPCIÓN: Antes de cargar algo, ve si hay modificaciones no guardadas.
//PARÁMETROS: Ninguno
//REGRESA: Nada
//AUTOR: Víctor Manuel Iniestra Álvarez
//FECHA: 15 Junio 1998
//MODIFICACIÓN:
//*/

//if event actualiza()=1 then

event primero()
return retrieve(uo_1.il_cve_mat, uo_1.is_gpo, uo_1.ii_periodo, uo_1.ii_anio)
//end if
//uo_1.SetFocus()
//uo_1.dw_1.SetRow(uo_1.dw_1.GetRow())
//uo_1.dw_1.SetColumn("gpo")

return 0
end event

event nuevo;long ll_cve_mat
integer li_cve_coordinacion, li_periodo, li_anio, li_tipo
string ls_gpo, ls_nombre_completo, ls_apaterno, ls_amaterno, ls_nombre, ls_prim_let_gpo
long ll_row, ll_num_mats, ll_cve_profesor

IF uo_1.is_estatus = "Insertar" THEN
	MessageBox("Capturando Grupo", "Favor de Terminar la captura actual")
	return
END IF	

ll_cve_mat= uo_1.il_cve_mat
ls_gpo = uo_1.is_gpo
li_cve_coordinacion = uo_1.ii_cve_coordinacion
li_periodo = uo_1.ii_periodo
li_anio = uo_1.ii_anio
// Profesor por designar
ll_cve_profesor = 1
// Tipo normal
li_tipo = 0

if not f_materia_valida(ll_cve_mat, li_cve_coordinacion) or &
	not f_grupo_valido(ls_gpo) then
	MessageBox("Grupo Invalido", "Favor de Seleccionar materias y grupos validos antes de "+&
	            "comenzar una Insercion.")
	uo_1.rb_editar.checked = true
	uo_1.is_estatus = "Modificar"
	return	
end if

//Revisa que el grupo no se haya dado de alta previamente	
if f_existe_grupo(ll_cve_mat, ls_gpo, li_periodo, li_anio) then
	MessageBox("Grupo Existente", "El grupo "+string(ll_cve_mat)+":"+ls_gpo+" ya se ha dado de alta.",StopSign!)
	uo_1.rb_editar.checked = true
	uo_1.is_estatus = "Modificar"
	return 
end if
ls_prim_let_gpo= mid(ls_gpo,1,1)
if li_cve_coordinacion<>9999 and ls_prim_let_gpo= "Z" and ls_gpo<>"Z" then
	MessageBox("Grupo Restringido", "El usuario no se encuentra autorizado para registrar grupos Z.",StopSign!)
	uo_1.rb_editar.checked = true
	uo_1.is_estatus = "Modificar"
	return 	
end if

ll_num_mats = f_cuenta_mat_insc(ll_cve_mat, ls_gpo, li_periodo, li_anio)

//Solo si es un registro nuevo los datawindows de grupos y horario permitirán actualización
this.dataobject = 'd_grupos_imp_nvo_cupo_coord2'
this.SetTransObject(gtr_sce)
dw_horario.dataobject = 'd_gpo_imp_horario_cupo_coord2'
dw_horario.SetTransObject(gtr_sce)


setfocus()
scrolltorow(insertrow(0))
dw_sdw.Reset()
setcolumn("tipo")
uo_1.rb_insertar.checked = true
uo_1.is_estatus = "Insertar"
uo_1.dw_1.enabled = false
ll_row = GetRow()
object.cve_mat[ll_row]= ll_cve_mat
object.gpo[ll_row]= ls_gpo
object.cve_mat_gpo[ll_row]= string(ll_cve_mat)+ls_gpo
object.periodo[ll_row]= li_periodo
object.anio[ll_row]= li_anio
object.cupo[ll_row]= ll_num_mats
object.inscritos[ll_row]= ll_num_mats
object.tipo[ll_row]= li_tipo
ls_nombre_completo= f_obten_nombre_profesor(ll_cve_profesor,ls_apaterno, ls_amaterno, ls_nombre)
//this.SetTabOrder ("cve_profesor" , 61 )
object.cve_profesor[ll_row]= ll_cve_profesor
object.st_prof_apaterno.text = ls_apaterno
object.st_prof_amaterno.text = ls_amaterno
object.st_prof_nombre.text = ls_nombre
// Por default se asume que el grupo a capturar NO sera asimilado
this.SetTabOrder ("cve_asimilada" , 0 )
this.SetTabOrder ("gpo_asimilado" , 0 )		
this.SetTabOrder ("cve_profesor" , 61 )
this.SetTabOrder ("cupo" , 41 )		
//this.SetTabOrder ("inscritos" , 51 )		

m_grupos_impartidos_nvo_cupo_coor2.m_registro.m_nuevo.enabled = true
m_grupos_impartidos_nvo_cupo_coor2.m_registro.m_actualiza.enabled = true

m_grupos_impartidos_nvo_cupo_coor2.m_registro.m_cargaregistro.enabled = true
m_grupos_impartidos_nvo_cupo_coor2.m_registro.m_nuevohorario.enabled = true
m_grupos_impartidos_nvo_cupo_coor2.m_registro.m_borrahorario.enabled = true
m_grupos_impartidos_nvo_cupo_coor2.m_registro.m_borrahorarioactual.enabled = true

m_grupos_impartidos_nvo_cupo_coor2.m_registro.enabled = true
this.enabled = true
dw_horario.enabled = true
dw_profesor_auxiliar.enabled = true
uo_3.enabled = true
uo_3.em_cve_profesor.text= string(ll_cve_profesor)
uo_3.em_cve_profesor.Event Activarbusq()











end event

event itemchanged;string ls_columna, ls_gpo_asimilado, ls_str_null, ls_gpo
integer li_tipo
long ll_cve_asimilada, ll_long_null
integer li_inscritos, li_cupo
integer li_periodo, li_anio,  li_actual_inscritos_gpo
long ll_cve_profesor, ll_cve_profesor_asimilado
boolean lb_modificando
string ls_nombre_completo, ls_apaterno, ls_amaterno, ls_nombre
long ll_prof_asimilado, ll_cve_mat
if lb_modificando then
	return
end if

AcceptText()

lb_modificando = true

ls_columna =this.GetColumnName()
SetNull(ll_long_null)
SetNull(ls_str_null)
li_tipo = object.tipo[row]
ll_cve_profesor = object.cve_profesor[row]
ll_cve_asimilada = object.cve_asimilada[row]
ls_gpo_asimilado = object.gpo_asimilado[row]
if isnull(ll_cve_asimilada) then
	ll_cve_asimilada= 0
end if
if isnull(ls_gpo_asimilado) then
	ls_gpo_asimilado= ""
end if
ll_cve_mat = uo_1.il_cve_mat
ls_gpo = uo_1.is_gpo
li_periodo = uo_1.ii_periodo
li_anio = uo_1.ii_anio


choose case ls_columna 
case	'tipo' 
	if li_tipo=2 then
		this.SetTabOrder ("cve_asimilada" , 33 )
		this.SetTabOrder ("gpo_asimilado" , 36 )		
		this.SetTabOrder ("cve_profesor" , 0 )
		this.SetTabOrder ("cupo" , 0 )		
		uo_3.enabled = false
		dw_horario.enabled = false
		dw_profesor_auxiliar.enabled = false
		m_grupos_impartidos_nvo_cupo_coor2.m_registro.m_nuevohorario.enabled = false
		m_grupos_impartidos_nvo_cupo_coor2.m_registro.m_borrahorario.enabled = false
		m_grupos_impartidos_nvo_cupo_coor2.m_registro.m_borrahorarioactual.enabled = false
//		this.SetTabOrder ("inscritos" , 0 )		
	else
		this.SetTabOrder ("cve_asimilada" , 0 )
		this.SetTabOrder ("gpo_asimilado" , 0 )		
		object.cve_asimilada[row]= ll_long_null
		object.gpo_asimilado[row]= ls_str_null
	   this.SetTabOrder ("cve_profesor" , 61 )
	   this.SetTabOrder ("cupo" , 41 )	
		uo_3.enabled = true
		dw_horario.enabled = true
		dw_profesor_auxiliar.enabled = true
		m_grupos_impartidos_nvo_cupo_coor2.m_registro.m_nuevohorario.enabled = true
		m_grupos_impartidos_nvo_cupo_coor2.m_registro.m_borrahorario.enabled = true
		m_grupos_impartidos_nvo_cupo_coor2.m_registro.m_borrahorarioactual.enabled = true

//	   this.SetTabOrder ("inscritos" , 51 )		
	end if
case "cve_profesor"
		if not(f_profesor_valido(ll_cve_profesor)) then
			MessageBox("Profesor Inexistente", &
			           "El profesor "+string(ll_cve_profesor)+ " no existe registrado.",StopSign!)
			this.object.st_prof_apaterno.text = ""
			this.object.st_prof_amaterno.text = ""
			this.object.st_prof_nombre.text = ""
			lb_modificando = false
			return 2
		else
			ls_nombre_completo= f_obten_nombre_profesor(ll_cve_profesor,ls_apaterno, ls_amaterno, ls_nombre)
			this.object.st_prof_apaterno.text = ls_apaterno
			this.object.st_prof_amaterno.text = ls_amaterno
			this.object.st_prof_nombre.text = ls_nombre
		end if
case "cve_asimilada", "gpo_asimilado"
		if ll_cve_asimilada <> 0	and &
			ls_gpo_asimilado <> ""	then
			ll_prof_asimilado =f_obten_profesor_grupo(ll_cve_asimilada, ls_gpo_asimilado, li_periodo, li_anio)
			li_cupo =f_obten_cupo_grupo(ll_cve_asimilada, ls_gpo_asimilado, li_periodo, li_anio)
			li_inscritos =f_obten_inscritos_grupo(ll_cve_asimilada, ls_gpo_asimilado, li_periodo, li_anio)
		   this.SetTabOrder ("cve_profesor" , 61 )
		   this.SetTabOrder ("cupo" , 41 )		
//			li_actual_inscritos_gpo =f_actual_inscritos_grupo(ll_cve_mat, ls_gpo, li_periodo, li_anio, li_inscritos)
			dw_profesor_auxiliar.Retrieve(ll_cve_asimilada, ls_gpo_asimilado, li_periodo, li_anio)
//	   	this.SetTabOrder ("inscritos" , 51 )
			object.cve_profesor[row]= ll_prof_asimilado
			ls_nombre_completo= f_obten_nombre_profesor(ll_prof_asimilado,ls_apaterno, ls_amaterno, ls_nombre)
			this.object.st_prof_apaterno.text = ls_apaterno
			this.object.st_prof_amaterno.text = ls_amaterno
			this.object.st_prof_nombre.text = ls_nombre
			uo_3.enabled = true
			uo_3.em_cve_profesor.text= string(ll_prof_asimilado)
			uo_3.em_cve_profesor.Event Activarbusq()
			uo_3.enabled = false
			object.cupo[row]= li_cupo
			object.inscritos[row]= li_inscritos
		   this.SetTabOrder ("cve_profesor" , 0 )
		   this.SetTabOrder ("cupo" , 0 )		
//		   this.SetTabOrder ("inscritos" , 0 )		
			
		end if

end choose

lb_modificando = false


end event

event actualiza;///*
//DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
//				
//PARÁMETROS: Ninguno
//REGRESA: Nada
//AUTOR: Víctor Manuel Iniestra Álvarez
//FECHA: 17 Junio 1998
//MODIFICACIÓN:
//*/

int li_respuesta, li_actual_gpos, li_periodo, li_anio
long ll_cve_mat
integer li_actual_insc_grupo
string ls_gpo
long ll_num_mats
int li_actualiza_sdu, li_hor_modified, li_hor_deleted, li_actualiza_prof

ll_cve_mat = uo_1.il_cve_mat
ls_gpo = uo_1.is_gpo
li_periodo = uo_1.ii_periodo
li_anio = uo_1.ii_anio

/*Acepta el texto de la última columna editada*/
AcceptText()
/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
if ModifiedCount()+DeletedCount() > 0  or ModifiedCount()= 0 Then
	if not ib_borrando then
		if event valida() <> 1 then
			messagebox("Error de captura",&
		           "Existe informacion incorrecta, favor de corregirla:",StopSign!)
			ib_borrando= false		  
			return -1
		end if
	end if
	/*Pregunta si se desean guardar los cambios hechos*/
	
	if not ib_borrando then
		li_respuesta = messagebox("Atención","Desea actualizar los cambios:",Question!,YesNo!,2)
	else
		li_respuesta = 1
	end if
	
	if li_respuesta = 1 then

//		Se realiza la distinción de la eliminación contra la actualización normal, debido a que existen foreign keys
//		que obligan integridad referencial de profesor_auxiliar a grupos y horario a grupos, por lo cual en el 
//		caso de una inserción es necesario insertar primero el grupo y después sus registros dependientes y en el
//		caso de una eliminación es necesario eliminar primero los registros dependientes (horario, profesor_auxiliar)
//		y después el padre (grupos)
		if not ib_borrando then
			if  dw_1.Update()=1 then
				COMMIT USING gtr_sce;
				messagebox("Información","Se han guardado los cambios exitosamente", Information!)
				ib_borrando= false		  
				uo_1.is_estatus = "Editar"
				uo_1.rb_editar.Checked = true
				uo_1.rb_editar.TriggerEvent(Clicked!)
				return 1
			else
				ROLLBACK USING gtr_sce;
				messagebox("Error en la actualización","No se han guardado los cambios", StopSign!)				
				ib_borrando= false		  
				return -1
			end if		
			
			
		end if
		
		
	else
//		De lo contrario, solo avisa que no se guardó nada.
		messagebox("Información","No se han guardado los cambios")
		ib_borrando= false		  
		return -1
	end if
else
		messagebox("Información","No se ha modificado el cupo")
		ib_borrando= false		  
		return -1	
end if


end event

event retrieveend;long ll_row, ll_cve_profesor, ll_profesores_modificados, ll_profesores_borrados, ll_por_designar
int li_cond_gpo, li_tipo
long ll_cve_asimilada
integer li_periodo, li_anio
string ls_nombre_completo, ls_apaterno, ls_amaterno, ls_nombre, ls_gpo_asimilado

li_periodo = uo_1.ii_periodo
li_anio = uo_1.ii_anio

dw_horario.retrieve(uo_1.il_cve_mat, uo_1.is_gpo, uo_1.ii_periodo, uo_1.ii_anio)
dw_profesor_auxiliar.retrieve(uo_1.il_cve_mat, uo_1.is_gpo, uo_1.ii_periodo, uo_1.ii_anio)

this.SetTabOrder ("cve_asimilada" , 0 )
this.SetTabOrder ("gpo_asimilado" , 0 )	
ll_por_designar= 1

ll_row= this.GetRow()
if ll_row>0 then
	dw_sdw.Reset()
	li_cond_gpo= this.GetItemNumber(ll_row, "cond_gpo")
	ll_cve_profesor= this.GetItemNumber(ll_row, "cve_profesor")
	li_tipo = this.GetItemNumber(ll_row, "tipo")
	ls_nombre_completo= f_obten_nombre_profesor(ll_cve_profesor,ls_apaterno, ls_amaterno, ls_nombre)
	this.object.st_prof_apaterno.text = ls_apaterno
	this.object.st_prof_amaterno.text = ls_amaterno
	this.object.st_prof_nombre.text = ls_nombre
	uo_3.em_cve_profesor.text= string(ll_cve_profesor)
	uo_3.em_cve_profesor.Event Activarbusq()
else
	ll_cve_profesor=-1
	uo_3.em_cve_profesor.text= string(ll_cve_profesor)
	uo_3.em_cve_profesor.Event Activarbusq()
	uo_3.enabled = false		
	
end if



end event

event borra;/*
DESCRIPCIÓN: Borra el renglon actual y actualiza.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
int li_respuesta, li_actual_gpos, li_periodo, li_anio
int li_actualiza_sdu, li_res_upd
long ll_por_designar= 1
long ll_cero= 0
string ls_mensaje_sql

li_periodo = uo_1.ii_periodo
li_anio = uo_1.ii_anio
li_respuesta = messagebox("Atención","Esta seguro de querer borrar el campo actual.",Question!,YesNo!,2)

if li_respuesta = 1 then
	ib_borrando = true
	if event valida_borra() = 1 then		
//		Debido a que existen foreign keys	que obligan integridad referencial de profesor_auxiliar a grupos 
//    y horario a grupos, por lo cual en el caso de una eliminación es necesario eliminar primero los 
//    registros dependientes (horario, profesor_auxiliar) y después el padre (grupos)		
		if dw_horario.Event borra_todo()=1 and dw_profesor_auxiliar.Event borra_todo()=1  then
			if wf_actualiza_sdu()= 1 and dw_horario.update()=1 and dw_profesor_auxiliar.update()=1 and deleterow(getrow())	= 1 and dw_1.Update()=1 then
				COMMIT USING gtr_sce;
				messagebox("Información","El grupo se ha eliminado exitosamente",Information!)					
				uo_3.em_cve_profesor.enabled = true
				uo_3.em_cve_profesor.text= string(ll_cero)
				uo_3.em_cve_profesor.Event Activarbusq()
				
				ib_borrando= false		  
				uo_1.is_estatus = "Editar"
				uo_1.rb_editar.Checked = true
				uo_1.rb_editar.TriggerEvent(Clicked!)				
			else
				ls_mensaje_sql= gtr_sce.SqlErrText
				ROLLBACK USING gtr_sce;
				ib_borrando= false		  
				MessageBox("Error al eliminar el horario", ls_mensaje_sql,StopSign!)
				return 
			end if
		else
			messagebox("Información","No es posible eliminar los horarios y los profesores auxiliares",StopSign!)					
			ROLLBACK USING gtr_sce;
			return 			
		end if
	end if
elseif li_respuesta = 2 then
//		De lo contrario, solo avisa que no se guardó nada.
	messagebox("Información","No se han guardado los cambios")
	ib_borrando= false		  
	return 
end if

ib_borrando = false

end event

event dberror;call super::dberror;return 0
end event

type uo_1 from uo_grupos_cupo_coord within w_grupos_cupo_coord
integer x = 64
integer y = 84
integer height = 316
integer taborder = 10
boolean bringtotop = true
boolean border = false
end type

on uo_1.destroy
call uo_grupos_cupo_coord::destroy
end on

type dw_sdw from datawindow within w_grupos_cupo_coord
boolean visible = false
integer x = 23
integer y = 1540
integer width = 1970
integer height = 300
string dataobject = "d_ext_sdu_grupos_nvo_cupo_coord"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.SetTransObject(gtr_sce)

end event

