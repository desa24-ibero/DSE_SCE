$PBExportHeader$w_grupos_impartidos_nvo.srw
forward
global type w_grupos_impartidos_nvo from window
end type
type cbx_evaluar from checkbox within w_grupos_impartidos_nvo
end type
type st_1 from statictext within w_grupos_impartidos_nvo
end type
type cb_porcentaje_uso from commandbutton within w_grupos_impartidos_nvo
end type
type dw_profesor_auxiliar from uo_dw_captura within w_grupos_impartidos_nvo
end type
type uo_3 from uo_nombre_profesor within w_grupos_impartidos_nvo
end type
type dw_sdw from datawindow within w_grupos_impartidos_nvo
end type
type dw_horario from uo_dw_captura within w_grupos_impartidos_nvo
end type
type st_periodo from statictext within w_grupos_impartidos_nvo
end type
type cb_1 from commandbutton within w_grupos_impartidos_nvo
end type
type uo_2 from uo_per_ani within w_grupos_impartidos_nvo
end type
type uo_1 from uo_grupos within w_grupos_impartidos_nvo
end type
type dw_1 from uo_dw_captura within w_grupos_impartidos_nvo
end type
end forward

global type w_grupos_impartidos_nvo from window
integer x = 846
integer y = 372
integer width = 3323
integer height = 2236
boolean titlebar = true
string title = "Grupos Impartidos"
string menuname = "m_grupos_impartidos_nvo"
boolean controlmenu = true
boolean maxbox = true
boolean resizable = true
long backcolor = 26439467
cbx_evaluar cbx_evaluar
st_1 st_1
cb_porcentaje_uso cb_porcentaje_uso
dw_profesor_auxiliar dw_profesor_auxiliar
uo_3 uo_3
dw_sdw dw_sdw
dw_horario dw_horario
st_periodo st_periodo
cb_1 cb_1
uo_2 uo_2
uo_1 uo_1
dw_1 dw_1
end type
global w_grupos_impartidos_nvo w_grupos_impartidos_nvo

type variables
boolean ib_borrando= false
long il_cve_asimilada
integer ii_cupo, ii_coord_usuario
string is_gpo_asimilado
Transaction itr_parametros_iniciales
n_tr itr_seguridad, itr_original

//nombre de la conexion en parametros_conexion
CONSTANT	string	is_controlescolar_cnx	=	"controlescolar_inscripcion"
CONSTANT	string	is_tesoreria_cnx			=	"controlescolar_inscripcion_tesoreria"
CONSTANT	string	is_becas_cnx				=	"controlescolar_inscripcion_becas"

long ll_cve_profesor_original



uo_periodo_servicios iuo_periodo_servicios


uo_grupos_multiplantel iuo_grupos_multiplantel 


uo_grupo_servicios luo_grupo_servicios 
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
public function integer wf_valida_horario_salon (string as_salon)
public function boolean wf_valida_salon_en_linea ()
public function integer wf_inserta_horario_profesor ()
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

public function integer wf_valida_horario_salon (string as_salon);INTEGER le_tiene_horario

SELECT tiene_horario 
INTO :le_tiene_horario 
FROM salon_sin_horario
WHERE cve_salon = :as_salon
USING gtr_sce; 
IF gtr_sce.SQLCODE < 0 THEN  
	MESSAGEBOX("Error", "Se produjo un error al verificar si el salón requiere horario: " + gtr_sce.SQLERRTEXT) 
	RETURN -1 
ELSEIF gtr_sce.SQLCODE = 100 THEN 	
	le_tiene_horario = 1
END IF  	
IF ISNULL(le_tiene_horario)  THEN le_tiene_horario = 1 

// le_tiene_horario = 0 NO valida horario, le_tiene_horario = 1 SI valida horario
RETURN le_tiene_horario



end function

public function boolean wf_valida_salon_en_linea ();
// Se verifica si existe algún registro de horario con clase aula diferente a 3 "OTRO" 
// Retorna TRUE si existe una clase aula diferente a OTRO 
IF dw_horario.FIND("clase_aula <> 3", 0, dw_horario.ROWCOUNT() + 1) > 0 THEN RETURN TRUE 
	

end function

public function integer wf_inserta_horario_profesor ();
// EN ESTA FUNCIÓN SE ACTUALIZA TAMBIÉN EL DETALLE DE profesor_cotitular 
// Se inicializa el detalle de horario de profesores. 
LONG ll_cve_mat	
STRING ls_gpo	
INTEGER le_periodo	
INTEGER le_anio	
INTEGER le_cve_dia	
STRING ls_cve_salon	
INTEGER le_hora_inicio	
INTEGER le_hora_final	
INTEGER le_clase_aula
DATETIME ldt_ldt_fecha_inicio
DATETIME ldt_ldt_fecha_fin 

INTEGER le_row_ins, le_pos 
LONG ll_cve_prof 

luo_grupo_servicios = CREATE uo_grupo_servicios  
luo_grupo_servicios.itr_sce = gtr_sce  
luo_grupo_servicios.of_inicializa_parametros( )



ll_cve_mat = uo_1.il_cve_mat  
ls_gpo = uo_1.is_gpo 
le_periodo = uo_1.ii_periodo 
le_anio = uo_1.ii_anio 

luo_grupo_servicios.il_cve_mat = ll_cve_mat 
luo_grupo_servicios.is_gpo = ls_gpo 
luo_grupo_servicios.ie_anio = le_anio 
luo_grupo_servicios.ie_periodo = le_periodo

luo_grupo_servicios.of_fechas_periodo( )

ldt_ldt_fecha_inicio = luo_grupo_servicios.idt_fecha_inicio
ldt_ldt_fecha_fin = luo_grupo_servicios.idt_fecha_fin


ll_cve_prof = LONG(uo_3.em_cve_profesor.text)

FOR le_pos = 1 TO dw_horario.ROWCOUNT() 
	
	le_cve_dia = dw_horario.GETITEMNUMBER(le_pos, "cve_dia") 
	ls_cve_salon = 	dw_horario.GETITEMSTRING(le_pos, "cve_salon") 	
	le_hora_inicio = dw_horario.GETITEMNUMBER(le_pos, "hora_inicio") 	
	le_hora_final = dw_horario.GETITEMNUMBER(le_pos, "hora_final") 	
	le_clase_aula = dw_horario.GETITEMNUMBER(le_pos, "clase_aula")    

	
	le_row_ins = luo_grupo_servicios.ids_horario_profesor.INSERTROW(0) 
	luo_grupo_servicios.ids_horario_profesor.SETITEM(le_row_ins, "cve_mat", ll_cve_mat)	
	luo_grupo_servicios.ids_horario_profesor.SETITEM(le_row_ins, "gpo", ls_gpo)	
	luo_grupo_servicios.ids_horario_profesor.SETITEM(le_row_ins, "periodo", le_periodo)	
	luo_grupo_servicios.ids_horario_profesor.SETITEM(le_row_ins, "anio", le_anio)	
	luo_grupo_servicios.ids_horario_profesor.SETITEM(le_row_ins, "cve_profesor", ll_cve_prof)	 
	luo_grupo_servicios.ids_horario_profesor.SETITEM(le_row_ins, "cve_dia", le_cve_dia)	 
	luo_grupo_servicios.ids_horario_profesor.SETITEM(le_row_ins, "hora_inicio", le_hora_inicio)	
	luo_grupo_servicios.ids_horario_profesor.SETITEM(le_row_ins, "hora_final", le_hora_final)	
	luo_grupo_servicios.ids_horario_profesor.SETITEM(le_row_ins, "fecha_inicio", ldt_ldt_fecha_inicio)	 
	luo_grupo_servicios.ids_horario_profesor.SETITEM(le_row_ins, "fecha_fin", ldt_ldt_fecha_fin) 
	luo_grupo_servicios.ids_horario_profesor.SETITEM(le_row_ins, "horas_asignadas", 0)  

	le_row_ins = luo_grupo_servicios.Ids_horario.INSERTROW(0)
	luo_grupo_servicios.Ids_horario.SETITEM(le_row_ins, "cve_mat", ll_cve_mat) 
	luo_grupo_servicios.Ids_horario.SETITEM(le_row_ins, "gpo", ls_gpo)	 
	luo_grupo_servicios.Ids_horario.SETITEM(le_row_ins, "periodo", le_periodo)	  
	luo_grupo_servicios.Ids_horario.SETITEM(le_row_ins, "anio", le_anio)	 
	luo_grupo_servicios.Ids_horario.SETITEM(le_row_ins, "cve_dia", le_cve_dia)	 
	luo_grupo_servicios.Ids_horario.SETITEM(le_row_ins, "cve_salon", ls_cve_salon)	  
	luo_grupo_servicios.Ids_horario.SETITEM(le_row_ins, "hora_inicio", ldt_ldt_fecha_inicio)	 
	luo_grupo_servicios.Ids_horario.SETITEM(le_row_ins, "hora_final", ldt_ldt_fecha_fin)	 
	luo_grupo_servicios.Ids_horario.SETITEM(le_row_ins, "clase_aula", le_clase_aula)
	luo_grupo_servicios.Ids_horario.SETITEM(le_row_ins, "comentario", "") 

NEXT 


// Se inicializa el detalle de profesor_cotitular. 
STRING ls_evalua 
INTEGER le_horas
le_pos = luo_grupo_servicios.ids_profesor.INSERTROW(0)
luo_grupo_servicios.ids_profesor.SETITEM(le_pos, "cve_profesor", ll_cve_prof) 
luo_grupo_servicios.ids_profesor.SETITEM(le_pos, "titularidad", 1)	
luo_grupo_servicios.ids_profesor.SETITEM(le_pos, "fecha_inicio", ldt_ldt_fecha_inicio)	
luo_grupo_servicios.ids_profesor.SETITEM(le_pos, "fecha_fin", ldt_ldt_fecha_fin)	 

le_horas = luo_grupo_servicios.of_calcula_horas_totales_semestre() 

luo_grupo_servicios.ids_profesor.SETITEM(le_pos, "horas_totales_grupo", le_horas)   
luo_grupo_servicios.ids_profesor.SETITEM(le_pos, "tipo_profesor", 1)   
luo_grupo_servicios.ids_profesor.SETITEM(le_pos, "autorizado", 1)   
IF cbx_evaluar.CHECKED THEN 
	ls_evalua = "S"  
ELSE
	ls_evalua = "N" 
END IF
luo_grupo_servicios.ids_profesor.SETITEM(le_pos, "evalua", ls_evalua)  



IF luo_grupo_servicios.of_inserta_profesor()  < 0 THEN 
	MESSAGEBOX("ERROR", luo_grupo_servicios.is_error) 
	RETURN -1 
END IF 

IF luo_grupo_servicios.of_inserta_profesor_horario()  < 0 THEN 
	MESSAGEBOX("ERROR", luo_grupo_servicios.is_error) 
	RETURN -1 
END IF 

RETURN 0 





//cve_mat	
//gpo	
//periodo	
//anio	
//cve_dia	
//cve_salon	
//hora_inicio	
//hora_final	
//clase_aula
//ldt_fecha_inicio
//ldt_fecha_fin







end function

on w_grupos_impartidos_nvo.create
if this.MenuName = "m_grupos_impartidos_nvo" then this.MenuID = create m_grupos_impartidos_nvo
this.cbx_evaluar=create cbx_evaluar
this.st_1=create st_1
this.cb_porcentaje_uso=create cb_porcentaje_uso
this.dw_profesor_auxiliar=create dw_profesor_auxiliar
this.uo_3=create uo_3
this.dw_sdw=create dw_sdw
this.dw_horario=create dw_horario
this.st_periodo=create st_periodo
this.cb_1=create cb_1
this.uo_2=create uo_2
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.cbx_evaluar,&
this.st_1,&
this.cb_porcentaje_uso,&
this.dw_profesor_auxiliar,&
this.uo_3,&
this.dw_sdw,&
this.dw_horario,&
this.st_periodo,&
this.cb_1,&
this.uo_2,&
this.uo_1,&
this.dw_1}
end on

on w_grupos_impartidos_nvo.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_evaluar)
destroy(this.st_1)
destroy(this.cb_porcentaje_uso)
destroy(this.dw_profesor_auxiliar)
destroy(this.uo_3)
destroy(this.dw_sdw)
destroy(this.dw_horario)
destroy(this.st_periodo)
destroy(this.cb_1)
destroy(this.uo_2)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;long ll_row
int li_retorno, li_periodo, li_anio, li_coord_usuario, li_chk, li_num_items, li_item_actual

//Cambio por Ajustes en Línea
//1)->
//Se conecta a la seguridad para mantener separada una transacción para la seguridad
if not (conecta_bd_n_tr(itr_seguridad,gs_sce,gs_usuario,gs_password) = 1) then
	messageBox('Error en seguridad', 'No es posible validar la seguridad del usuario',Stopsign!)
end if

iuo_periodo_servicios = CREATE uo_periodo_servicios 
iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, "L", gtr_sce) 

itr_parametros_iniciales = gtr_sce

li_chk	=	f_conecta_pas_parametros_act_bd(itr_parametros_iniciales,gtr_sce,is_controlescolar_cnx,gs_usuario,gs_password,1)
if li_chk <> 1 then return

//Es necesario reasignar el transaction object para la seguridad
gnv_app.of_SetSecurity(TRUE)
gnv_app.itr_security = itr_seguridad
gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), gs_sce)
gnv_app.itr_security.of_Connect()
if (gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, gs_usuario,"Default") <> 1) then
		MessageBox("Atención","No se pudo inicializar correctamente la seguridad")
		Close(this)
end if

//Cambio por Ajustes en Línea
//1)<-

//Habilita la seguridad para la ventana actual

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

//Cambio por Ajustes en Línea
//2)->
//Se vuelve a poner porque en el constructor de los datawindows ya previamente se había ejecutado apuntando a sybase
dw_1.triggerevent("asigna_dw_menu")
dw_1.triggerevent("inicia_transaction_object")

dw_horario.triggerevent("asigna_dw_menu")
dw_horario.triggerevent("inicia_transaction_object")

dw_profesor_auxiliar.triggerevent("asigna_dw_menu")
dw_profesor_auxiliar.triggerevent("inicia_transaction_object")

dw_sdw.SetTransObject(gtr_sce)

uo_3.dw_nombre_alumno.settransobject(gtr_sce)
uo_3.dw_nombre_alumno.insertrow(0)
f_obten_titulo(w_principal)

w_principal.ChangeMenu(m_grupos_impartidos_salir)
 
//Cambio por Ajustes en Línea
//2)<-












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

event activate;//MessageBox('Activate', 'w_grupo_impartidos_nvo',Information!)
//integer		li_chk




end event

event deactivate;//MessageBox('Deactivate', 'w_grupo_impartidos_nvo',Information!)
end event

event close;//Cambio por Ajustes en Línea
//3)->
//Se conecta a la base de datos original para reasignar a la transacción principal
if not (conecta_bd_n_tr(itr_original,gs_sce,gs_usuario,gs_password) = 1) then
	messageBox('Error en conectividad', 'No es posible reconectarse al origen. Favor de reiniciar la aplicación',Stopsign!)
	HALT CLOSE		
end if

//Se asigna la transacción original
gtr_sce = itr_original 

//Es necesario reasignar el transaction object para la seguridad
gnv_app.of_SetSecurity(TRUE)
gnv_app.itr_security = gtr_sce
gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), gs_sce)
gnv_app.itr_security.of_Connect()
if (gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, gs_usuario,"Default") <> 1) then
		MessageBox("Atención","No se pudo inicializar correctamente la seguridad")
		Close(this)
end if

f_obten_titulo(w_principal)
w_principal.ChangeMenu(m_principal)
gnv_app.inv_security.of_SetSecurity(w_principal)
//Cambio por Ajustes en Línea
//3)<-

end event

type cbx_evaluar from checkbox within w_grupos_impartidos_nvo
integer x = 2857
integer y = 1532
integer width = 297
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Evaluar"
boolean checked = true
end type

type st_1 from statictext within w_grupos_impartidos_nvo
integer x = 3067
integer y = 1812
integer width = 137
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 32768
string text = "VBC"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type cb_porcentaje_uso from commandbutton within w_grupos_impartidos_nvo
integer x = 178
integer y = 1736
integer width = 594
integer height = 108
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Porcentaje de Uso"
end type

event clicked;str_periodo_coord lst_parametros
 
 lst_parametros.cve_coordinacion = ii_coord_usuario
 lst_parametros.periodo = gi_periodo
 lst_parametros.anio =gi_anio
 			 
OpenWithParm(w_porcentaje_espacios_coord, lst_parametros, parent)			 
end event

type dw_profesor_auxiliar from uo_dw_captura within w_grupos_impartidos_nvo
event type integer borra_actual ( )
event type integer borra_todo ( )
boolean visible = false
integer x = 82
integer y = 1280
integer width = 2743
integer height = 220
integer taborder = 50
boolean enabled = false
string dataobject = "d_profesor_auxiliar"
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

type uo_3 from uo_nombre_profesor within w_grupos_impartidos_nvo
integer x = 82
integer y = 1468
integer taborder = 40
boolean enabled = true
end type

on uo_3.destroy
call uo_nombre_profesor::destroy
end on

type dw_sdw from datawindow within w_grupos_impartidos_nvo
boolean visible = false
integer x = 23
integer y = 1540
integer width = 1970
integer height = 300
integer taborder = 70
string dataobject = "d_ext_sdu_grupos_nvo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.SetTransObject(gtr_sce)

end event

type dw_horario from uo_dw_captura within w_grupos_impartidos_nvo
event type integer borra_todo ( )
event type integer borra_actual ( )
integer x = 96
integer y = 904
integer width = 2725
integer height = 384
integer taborder = 30
string dataobject = "d_gpo_imp_horario"
boolean livescroll = false
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

event itemchanged;call super::itemchanged;
IF dwo.name = "clase_aula" THEN 
	
	// Se verifica si el aula seleccionda es diferente a "OTRO" y si la modalidad es a "DISTANCIA" 
	IF data <> "3"  THEN 
		INTEGER le_modadlidad 
		le_modadlidad = dw_1.GETITEMNUMBER(1, "modalidad") 
		IF le_modadlidad = 2 THEN 
			MESSAGEBOX("Aviso", "Un de modalidad 'DISTANCIA' solo puede ser clase aula 'OTRO'. ")  
			THIS.settext('') 
			RETURN 2 			
		END IF 
	END IF 	

END IF 



end event

type st_periodo from statictext within w_grupos_impartidos_nvo
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

type cb_1 from commandbutton within w_grupos_impartidos_nvo
integer x = 1125
integer y = 1736
integer width = 526
integer height = 108
integer taborder = 80
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

//choose case gi_periodo
//	case 0
//		st_periodo.text = "PRIMAVERA " + String(gi_anio)
//	case 1
//		st_periodo.text = "VERANO " + String(gi_anio)
//	case 2
//		st_periodo.text = "OTOÑO " + String(gi_anio)
//end choose


st_periodo.text = iuo_periodo_servicios.f_recupera_descripcion( gi_periodo, "L")  + " " + STRING(gi_anio)




if uo_1.is_estatus = "Insertar" then
	ll_row = dw_1.GetRow()
	dw_1.object.periodo[ll_row]= uo_1.ii_periodo
	dw_1.object.anio[ll_row]= uo_1.ii_anio
end if

end event

type uo_2 from uo_per_ani within w_grupos_impartidos_nvo
integer x = 1682
integer y = 1704
integer width = 1253
integer height = 168
integer taborder = 60
boolean enabled = true
boolean border = true
long backcolor = 1090519039
end type

on uo_2.destroy
call uo_per_ani::destroy
end on

type uo_1 from uo_grupos within w_grupos_impartidos_nvo
integer x = 64
integer y = 84
integer width = 3118
integer height = 316
integer taborder = 10
boolean border = false
long backcolor = 79741120
borderstyle borderstyle = styleraised!
long tabtextcolor = 0
long tabbackcolor = 0
long picturemaskcolor = 0
string is_estatus = ""
end type

on uo_1.destroy
call uo_grupos::destroy
end on

type dw_1 from uo_dw_captura within w_grupos_impartidos_nvo
event type integer valida ( )
event nuevo_horario ( )
event borra_horario ( )
event type integer valida_borra ( )
event borra_horario_actual ( )
event borra_profesor_actual ( )
event nuevo_profesor ( )
integer x = 64
integer y = 412
integer width = 3118
integer height = 1252
integer taborder = 20
string dataobject = "d_grupos_imp_nvo"
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
boolean lb_desc_sdu_se, lb_existe_salon, lb_salon_ocupado, lb_nuevo_adjunto, lb_es_salon_otro
integer  li_clase_aula, li_null, li_acepta, li_clase_aula_orig, le_modalidad
integer li_cve_dia_prim, li_cve_dia_del, li_cve_dia_filt, li_bloqueado
string ls_cve_salon, ls_clase_aula, ls_nombre_completo, ls_apaterno, ls_amaterno, ls_nombre
string ls_uo_cve_profesor
long ll_por_designar, ll_uo_cve_profesor, ll_cve_profesor_adj, ll_row_profesor, ll_num_profesores
integer li_horas, li_cve_categoria_auxiliar
datastore lds_data, lds_data2
long ll_num_cords, ll_suma_horas, ll_row_horas_coord, ll_horas_reales, ll_horas_gpo_normal
long ll_suma_horas_mas_actual, ll_num_cords2, ll_num_cords_adj, ll_num_cords2_adj //, ll_horas_verano
string ls_coordinacion, ls_mensaje, ls_mensaje_adj, ls_salon_nulo
integer li_cve_categoria, li_cve_categoria_profesor, li_obten_clase_aula_salon, li_obten_nombre_aula_clase_aula
long ll_num_cambios_horario, ll_adjuntos_borrados, ll_adjuntos_modificados, ll_adjuntos_cambios
string ls_grupos_doble_presencia, ls_clase_aula_salon, ls_nombre_aula, ls_clase_aula_otro
long ll_cve_coordinacion_mat
//2014-05-23
boolean lb_horario_por_asignar_valido 

Integer HorasReales , le_retorno, le_horas_adic_x_una_mat, le_requiere_horario_sal 
decimal ld_factor_ajuste_horas 
STRING ls_desc_tipo 
INTEGER le_requiere_horario, le_valida_audiovisual
STRING ls_comentario

//ll_horas_gpo_normal = 12
//ll_horas_verano = 12
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

//****************************************************

//uo_periodo_parametros luo_periodo_parametros
//luo_periodo_parametros = CREATE uo_periodo_parametros 
//le_retorno = luo_periodo_parametros.f_carga_parametros( li_periodo, gtr_sce)
//IF le_retorno  < 0  OR le_retorno  = 100 THEN 
//	Messagebox("Error",luo_periodo_parametros.is_msg_err) 
//	DESTROY luo_periodo_parametros  
//	Return -1 
//END IF 
//
//// Se toman los valores devueltos
//ll_horas_gpo_normal = luo_periodo_parametros.id_horas_normales 
//ld_factor_ajuste_horas = luo_periodo_parametros.id_factor_ajuste_horas 
//le_horas_adic_x_una_mat  = luo_periodo_parametros.ie_horas_adic_x_una_mat 
//
//// Se destruye el objeto de servicios.
//DESTROY luo_periodo_parametros 

SELECT horas_normales, factor_ajuste_horas, horas_adic_x_una_mat
INTO :ll_horas_gpo_normal, :ld_factor_ajuste_horas, :le_horas_adic_x_una_mat
FROM dbo.periodo_parametros
WHERE periodo = :li_periodo
USING  gtr_sce;
IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuparar las horas permitidas para el periodo actual: " + gtr_sce.SQLERRTEXT)
	RETURN -1
END IF

//****************************************************

ll_cve_asimilada = object.cve_asimilada[ll_row]
ls_gpo_asimilado = object.gpo_asimilado[ll_row]
li_tipo = object.tipo[ll_row]
li_cupo = object.cupo[ll_row]
ii_cupo = li_cupo
ll_adjuntos_cambios = ll_adjuntos_borrados+ll_adjuntos_modificados

le_modalidad = object.modalidad[ll_row]
IF ISNULL(le_modalidad) OR le_modalidad = 0 THEN 
	MESSAGEBOX("Error", "No se ha especificado la modalidad del grupo. ") 
	RETURN -1		
END IF 	
	


SELECT nombre_tipo, requiere_horario 
INTO :ls_desc_tipo, :le_requiere_horario
FROM tipo_grupo 
WHERE tipo = :li_tipo
USING gtr_sce; 
IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar la información del tipo de grupo: " + gtr_sce.SQLERRTEXT) 
	RETURN -1	
END IF 


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

// Los grupos que no son por asesoria deben tener al menos un horario
if ll_num_horarios =0 and le_requiere_horario = 1 then
		MessageBox("Grupo sin Horario", "Es necesario capturar horarios para el grupo.",StopSign!)
	return -1
elseif ll_num_horarios >0 AND le_requiere_horario = 0 then		
		MessageBox("Grupo sin horario", "Los grupos " + ls_desc_tipo + " no pueden tener horario.",StopSign!) 
		RETURN -1
end if

// Los grupos por asesoria no pueden tener profesor adjunto
if ll_num_profesores >0 and (li_tipo=2)  then
	if li_tipo=2 and ll_adjuntos_cambios>0 then
		MessageBox("Grupo Especial con Profesor Adjunto", "Los grupos asimilados no pueden insertar/modificar Profesor Adjunto.",StopSign!)
		return -1			
	end if		
end if
	
	
	
//El grupo asimilado no puede ser el mismo que se esta registrando
if li_tipo =2 then
	//Revisa que el grupo no se haya dado de alta previamente
	
	if isnull(ll_cve_asimilada) then
		MessageBox("Materia Asimilate Faltante", "No se ha asignado la materia que asimila.",StopSign!)
		return -1
	end if

	if isnull(ls_gpo_asimilado) then
		MessageBox("Grupo Asimilate Faltante", "No se ha asignado el grupo que asimila.",StopSign!)
		return -1
	end if
	
	if not f_existe_grupo(ll_cve_asimilada, ls_gpo_asimilado, li_periodo, li_anio) then
		MessageBox("Grupo Asimilante Inexistente", "El grupo "+string(ll_cve_asimilada)+":"+ls_gpo_asimilado+" no ha sido registrado.",StopSign!)
		return -1
	end if

	if f_grupo_cancelado(ll_cve_asimilada, ls_gpo_asimilado, li_periodo, li_anio) then
		MessageBox("Grupo Asimilante Cancelado", "El grupo "+string(ll_cve_asimilada)+":"+ls_gpo_asimilado+" se encuentra cancelado.",StopSign!)
		return -1
	end if

	if ll_cve_asimilada= ll_cve_mat and ls_gpo_asimilado = ls_gpo then
		MessageBox("Grupo Asimilado Invalido", "El grupo "+string(ll_cve_asimilada)+":"+&
	              ls_gpo_asimilado+" no puede asimilarse a si mismo.",StopSign!)
		return -1
	end if
	if f_grupo_asimilado(ll_cve_asimilada, ls_gpo_asimilado, li_periodo, li_anio) then
		MessageBox("Grupo Asimilado Encadenado", "El grupo "+string(ll_cve_asimilada)+":"+&
		ls_gpo_asimilado+" esta registrado como asimilado también.",StopSign!)
		return -1
	end if

	if f_mat_a_menoshoras_mat_b(ll_cve_asimilada, ll_cve_mat) then
		MessageBox("Materia Asimilada con Menos Horas", "La materia "+string(ll_cve_asimilada)+&
		" tiene menos horas que la materia "+string(ll_cve_mat)+".",StopSign!)
		return -1
	end if

end if

// Validaciones para cualquier tipo de registro

if not isnumber(ls_uo_cve_profesor) then
		MessageBox("Profesor Incorrecto", "La clave del profesor no es valida.",StopSign!)
		return -1	
end if

ll_cve_profesor= long(ls_uo_cve_profesor)

object.cve_profesor[ll_row] =ll_cve_profesor

if not(f_profesor_valido(ll_cve_profesor)) then
	MessageBox("Profesor Inexistente", &
	           "El profesor "+string(ll_cve_profesor)+ " no existe registrado~n"+&
				   "o se encuentra inactivo.",StopSign!)
	this.SetItem(ll_row,"cve_profesor", ll_por_designar)
	uo_3.em_cve_profesor.text= string(ll_por_designar)
	uo_3.em_cve_profesor.Event Activarbusq()
	ls_nombre_completo= f_obten_nombre_profesor(ll_por_designar,ls_apaterno, ls_amaterno, ls_nombre)
	this.object.st_prof_apaterno.text = ls_apaterno
	this.object.st_prof_amaterno.text = ls_amaterno
	this.object.st_prof_nombre.text = ls_nombre
	return -1
end if


ll_cve_coordinacion_mat = f_obten_coord_materia(ll_cve_mat)
if  ll_cve_coordinacion_mat = -1 then
		MessageBox("Coordinacion no encontrada", "La coordinacion de la materia no existe.",StopSign!)
		return -1	
end if


if f_profesor_bloqueado(ll_cve_profesor, li_periodo, li_anio, ll_cve_coordinacion_mat)  and ll_cve_profesor_original <> ll_cve_profesor then
	MessageBox("Profesor Bloqueado", &
	           "El profesor "+string(ll_cve_profesor)+ " está bloqueado para el periodo actual.~n "+&
				  "Para mayores detalles favor de comunicarse a la Dirección de Análisis e Información Académica.",StopSign!)
	this.SetItem(ll_row,"cve_profesor", ll_por_designar)
	uo_3.em_cve_profesor.text= string(ll_por_designar)
	uo_3.em_cve_profesor.Event Activarbusq()
	ls_nombre_completo= f_obten_nombre_profesor(ll_por_designar,ls_apaterno, ls_amaterno, ls_nombre)
	this.object.st_prof_apaterno.text = ls_apaterno
	this.object.st_prof_amaterno.text = ls_amaterno
	this.object.st_prof_nombre.text = ls_nombre
	return -1
end if


li_acepta = dw_horario.AcceptText()
if li_acepta = -1 then
		MessageBox("Horario erroneo", &		
            "Existe un horario incorrectamente capturado.",StopSign!)		
		return -1		
end if
ll_num_cambios_horario = dw_horario.DeletedCount() + dw_horario.ModifiedCount()
For ll_row_horario = 1 To dw_horario.RowCount()
//Lee los valores del registro actual	
	lb_existe_salon = false
	ls_clase_aula= ""
	li_cve_dia 		= dw_horario.GetItemNumber(ll_row_horario,"cve_dia")
	li_clase_aula	= dw_horario.GetItemNumber(ll_row_horario,"clase_aula")
	li_hora_inicio	= dw_horario.GetItemNumber(ll_row_horario,"hora_inicio")
	li_hora_final	= dw_horario.GetItemNumber(ll_row_horario,"hora_final")
	ls_cve_salon	= dw_horario.GetItemString(ll_row_horario,"cve_salon")
	ls_comentario = dw_horario.GetItemString(ll_row_horario,"comentario")  
	
	le_requiere_horario_sal = wf_valida_horario_salon(ls_cve_salon)
	IF le_requiere_horario_sal < 0 THEN le_requiere_horario = 1

//Si tiene una cadena vacía, le asigna el valor de nulo
	if ls_cve_salon= "" then
		dw_horario.SetItem(ll_row_horario, "cve_salon", ls_salon_nulo)
	end if
	
//El dia de la semana es obligatorio
	if isnull(li_cve_dia) or li_cve_dia = li_null then
		MessageBox("Horario sin día de la semana", &		
            "Existe un horario sin día de la semana capturado.",StopSign!)		
		dw_horario.ScrollToRow(ll_row_horario)
		return -1	
	end if
//La clase de aula es obligatoria
	if isnull(li_clase_aula) or li_clase_aula = li_null then
		MessageBox("Horario sin clase de aula", &		
            "Existe un horario sin clase de aula capturado.",StopSign!)		
		dw_horario.ScrollToRow(ll_row_horario)
		return -1	
	end if 
	
	// Si es clase aula "otro", valida el comentario 
	IF li_clase_aula = 3 THEN 
		
		IF ISNULL(ls_comentario) THEN ls_comentario = "" 
		IF LEN(TRIM(ls_comentario)) < 4 THEN 
			MessageBox("Descripción de Aula", &		
   		         "La descripción de aula para tipo 'Otro' debe tener al menos 4 caracteres.",StopSign!)					
			dw_horario.ScrollToRow(ll_row_horario)
			return -1						
		END IF
	END IF
	
//La hora inicial es obligatoria
	if isnull(li_hora_inicio) or li_hora_inicio = li_null then
		MessageBox("Horario sin hora inicial", &		
            "Existe algun horario sin la hora inicial capturada, tal vez necesite dar [Enter] o [Tab] en dicho campo.",StopSign!)		
		dw_horario.ScrollToRow(ll_row_horario)
		return -1	
	elseif li_hora_inicio >21 or li_hora_inicio< 7 then
		MessageBox("Hora inicial fuera de rango", &		
            "La hora inicial solo puede estar entre 7 y 21.",StopSign!)		
		dw_horario.ScrollToRow(ll_row_horario)
		return -1			
	end if
//La hora final es obligatoria	
	if isnull(li_hora_final) or li_hora_final = li_null then
		MessageBox("Horario sin hora final", &		
            "Existe algun horario sin la hora final capturada, tal vez necesite dar [Enter] o [Tab] en dicho campo.",StopSign!)		
		dw_horario.ScrollToRow(ll_row_horario)
		return -1	
	elseif li_hora_final >22 or li_hora_final< 8 then
		MessageBox("Hora final fuera de rango", &		
            "La hora final solo puede estar entre 8 y 22.",StopSign!)		
		dw_horario.ScrollToRow(ll_row_horario)
		return -1			
	end if
//Verifica si el aula es de "OTROS" tipos, como cubículo,almace, bodega, consultorio, etc.	
	lb_es_salon_otro= f_es_salon_otro(ls_cve_salon, ls_clase_aula_otro)
	
//Busca el salon escrito, obtiene su clase de aula y si esta bloqueado o no	
	lb_existe_salon = f_existe_salon(ls_cve_salon, ls_clase_aula, li_bloqueado)
//	El salon no existe, solo manda el error cuando se escribió algo en la columna de salón
	if not lb_existe_salon and NOT isnull(ls_cve_salon) AND (ls_cve_salon <> "") then
		MessageBox("Horario con salon inexistente", &		
            "Existe algun horario con un salon inexistente, "+ls_cve_salon+ " tal vez necesite dar [Enter] o [Tab] en dicho campo.",StopSign!)		
		dw_horario.ScrollToRow(ll_row_horario)
		return -1		
	elseif lb_existe_salon and li_coord_usuario<>9999 and ls_clase_aula = "SALON" then
		if ll_num_cambios_horario> 0 then
			MessageBox("Horario con salon invalido", &		
      	      "Solo puede elegir laboratorios, talleres y especiales, tal vez necesite dar [Enter] o [Tab] en dicho campo.",StopSign!)		
			dw_horario.ScrollToRow(ll_row_horario)
			return -1				
		end if
	end if
//Asigna la cadena vacía a la clase del aula	
	if isnull(ls_clase_aula) then
		ls_clase_aula = ""
	end if
//Busca si el salon ya se asignó en otro horario o para otro grupo
	if	ls_clase_aula <> "TALLER" then
		// Se verifica si el salón requiere validación de Horario
		IF le_requiere_horario_sal = 1 THEN 
			lb_salon_ocupado= f_salon_ocupado(ll_cve_mat, ls_gpo, li_periodo, li_anio, li_cve_dia, &
												  ls_cve_salon, li_hora_inicio, li_hora_final)
		
			if lb_salon_ocupado and (not isnull(ls_cve_salon) and (ls_cve_salon<>"")) then
				MessageBox("Salon ocupado en algún horario", &		
						"Existe algun horario con el salon "+ls_cve_salon +" previamente ocupado en las horas escritas, tal vez necesite dar [Enter] o [Tab] en dicho campo.",StopSign!)		
				dw_horario.ScrollToRow(ll_row_horario)
				return -1		
			end if
		END IF	
	end if

//Si se capturó un salon	
	if not (isnull(ls_cve_salon)) and (ls_cve_salon<>"") then
//Obtiene el nombre del salon para la clase de aula en cuestión
	   li_obten_nombre_aula_clase_aula = f_obten_nombre_aula_clase_aula(li_clase_aula,ls_nombre_aula)
		if li_obten_nombre_aula_clase_aula <> 0 then
				MessageBox("Clase de aula invalida", &		
	   	         "Favor de revisar la clase de aula ["+string(li_clase_aula) +"].",StopSign!)		
				dw_horario.ScrollToRow(ll_row_horario)
				return -1				
		end if
//Si la clase de aula no corresponde con el nombre del aula
		if (pos(ls_clase_aula,ls_nombre_aula)= 0 AND pos(ls_nombre_aula, ls_clase_aula)= 0) AND NOT(lb_es_salon_otro AND li_clase_aula = 3) THEN
				MessageBox("Clase de aula incongruente", &		
	   	         "El salon "+ls_cve_salon +" no corresponde con la clase de aula seleccionada.",StopSign!)		
				dw_horario.ScrollToRow(ll_row_horario)
				return -1						
		end if
	end if

//Si el salón está bloqueado
	if li_bloqueado = 1 then
			MessageBox("Salon bloqueado", &		
	            "Existe algun horario con el salon "+ls_cve_salon +" marcado como bloqueado, tal vez necesite dar [Enter] o [Tab] en dicho campo.",StopSign!)		
			dw_horario.ScrollToRow(ll_row_horario)
			return -1				
	end if
//Si el horario se duplicó	
	If wf_existe_hor_duplicado(li_cve_dia, li_hora_inicio, ll_row_horario) then
		ls_dia =f_obten_dia(li_cve_dia)
		MessageBox("Existe un horario con el mismo dia y hora de inicio", &		
            "El dia: "+ls_dia+" se encuentra repetido con la hora: "+string(li_hora_inicio),StopSign!)		
		dw_horario.ScrollToRow(ll_row_horario)
		return -1
	End If
//Si el horario se encima
	If wf_existe_hor_encimado(li_cve_dia, li_hora_inicio, li_hora_final, ll_row_horario) then
		ls_dia =f_obten_dia(li_cve_dia)
		MessageBox("Existe un horario que se encima", &		
            "El dia: "+ls_dia+" se encuentra encimado en la hora: "+string(li_hora_inicio),StopSign!)		
		dw_horario.ScrollToRow(ll_row_horario)
		return -1
	End If
	
//	If	f_doble_presencia_profesor(ll_cve_mat, ls_gpo, li_periodo, li_anio, &
//		ll_cve_profesor,li_cve_dia, li_hora_inicio,li_hora_final,ls_grupos_doble_presencia) then
//		ls_dia =f_obten_dia(li_cve_dia)
//		MessageBox("Existe un horario que se encima al profesor "+string(ll_cve_profesor), &		
//            "El dia: "+ls_dia+" se encuentra encimado en la hora: "+string(li_hora_inicio)+"~nEn el(los) siguiente(s) grupo(s):~n"+ls_grupos_doble_presencia,StopSign!)		
//		dw_horario.ScrollToRow(ll_row_horario)
//		
//		return -1
//Obtiene la categoría del profesor
	li_cve_categoria = f_obten_categoria_profesor(ll_cve_profesor)
	if li_cve_categoria= -1 then
		MessageBox("Error en consulta de categoria", &		
	            "No es posible consultar la categoria del profesor capturado",StopSign!)			
	end if//	End If


//Valida que el profesor no esté impartiendo clases a la misma hora
	If	f_doble_presencia_profesor03(ll_cve_mat, ls_gpo, li_periodo, li_anio, &
		ll_cve_profesor,li_cve_dia, li_hora_inicio,li_hora_final,ls_grupos_doble_presencia) then
		ls_dia =f_obten_dia(li_cve_dia)
		MessageBox("Existe un horario que se encima al profesor "+string(ll_cve_profesor), &		
            "El dia: "+ls_dia+" se encuentra encimado en la hora: "+string(li_hora_inicio)+"~nEn el(los) siguiente(s) grupo(s):~n"+ls_grupos_doble_presencia,StopSign!)		
		dw_horario.ScrollToRow(ll_row_horario)
		return -1
		
//		if li_cve_categoria <> 3 then
//			return -1
//		end if	
		
	End If

//No permitir que se asigne un salon a un grupo que en clase aula sea diferente a salon
	if	li_clase_aula <> 0 and ls_clase_aula = "SALON" then		
			MessageBox("Salon invalido asignado", &		
	            "La clase de aula elegida, no permite asignar un SALON, tal vez necesite dar [Enter] o [Tab] en dicho campo.",StopSign!)		
			dw_horario.ScrollToRow(ll_row_horario)
			return -1			
	end if

//Si es un Taller
	if	li_clase_aula = 1 then		
//Es necesario especificar en que Taller se llevará a cabo la clase (cve_salon)
		if isnull(ls_cve_salon) OR (ls_cve_salon = "") then
			MessageBox("Taller invalido asignado", &		
	            "Para la clase de aula elegida, es necesario asignar el Taller correspondiente en la columna Salón, ~ntal vez necesite dar [Enter] o [Tab] en dicho campo.",StopSign!)		
			dw_horario.ScrollToRow(ll_row_horario)
			return -1	
		end if
	end if

//Si es un Laboratorio
	if	li_clase_aula = 2 then		
//Es necesario especificar en que Laboratorio se llevará a cabo la clase (cve_salon)
		if isnull(ls_cve_salon) OR (ls_cve_salon = "") then
			MessageBox("Laboratorio invalido asignado", &		
	            "Para la clase de aula elegida, es necesario asignar el Laboratorio correspondiente en la columna Salón, ~ntal vez necesite dar [Enter] o [Tab] en dicho campo.",StopSign!)		
			dw_horario.ScrollToRow(ll_row_horario)
			return -1	
		end if
	end if
	
//2014-05-23 Si el aula es 4-POR ASIGNAR	debe haber derecho en la matriz para ese dia-horas
//2014-06-25 Si el aula es 3-OTRO	debe haber derecho en la matriz para ese dia-horas
	if li_clase_aula = 4 OR li_clase_aula = 3 then
		lb_horario_por_asignar_valido =f_horario_por_asignar_valido (li_cve_dia, li_hora_inicio , li_hora_final)
		if lb_horario_por_asignar_valido then
//			Messagebox("OK", "HORARIO VALIDO", iNFORMATION!)
		else
			Messagebox("Horario por asignar Inválido", "No es posible registrar horarios POR ASIGNAR/OTRO en este día-hora,  ~ntal vez necesite dar [Enter] o [Tab] en dicho campo.", StopSign!)
			return -1
		end if	
	end if
Next


li_acepta = dw_profesor_auxiliar.AcceptText()
if li_acepta = -1 then
		MessageBox("Profesor Adjunto erroneo", &		
            "Existe un Profesor Adjunto incorrectamente capturado.",StopSign!)		
		return -1		
end if

if not horas_materia(ll_cve_mat, li_periodo, li_horas_mat_permitidas) then
		MessageBox("Error al consultar materia", &		
            "No es posible consultar las horas de la materia: "+string(ll_cve_mat),StopSign!)		
		return -1
end if


///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Se verifica si el profesor solo tiene un grupo.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////	
INTEGER le_numero_grupos_dif

SELECT COUNT(*) 
INTO :le_numero_grupos_dif 
FROM grupos g 
WHERE g.cve_profesor = :ll_cve_profesor 
AND	g.tipo not in (1, 2)
AND   g.periodo = :li_periodo
AND   g.anio = :li_anio 
AND NOT (g.cve_mat = :ll_cve_mat AND g.gpo = :ls_gpo) 
AND	g.cond_gpo = 1 
USING gtr_sce; 
IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar otros grupos del profesor:" + gtr_sce.SQLERRTEXT)
	RETURN -1 
END IF
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Se verifica si se puede apartar el aula audiovisual. 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////	

iuo_grupos_multiplantel = CREATE uo_grupos_multiplantel
le_valida_audiovisual = iuo_grupos_multiplantel.of_cancela_apartado(ll_cve_mat, ls_gpo)  
//li_tipo = object.tipo[THIS.GETROW()]

IF li_tipo = 5 THEN 
	//iuo_grupos_multiplantel = CREATE uo_grupos_multiplantel
	iuo_grupos_multiplantel.ie_periodo = li_periodo
	iuo_grupos_multiplantel.ie_anio = li_anio
	iuo_grupos_multiplantel.of_inserta_valida_aula(ll_cve_mat, ls_gpo, PARENT.dw_horario)
	le_valida_audiovisual = iuo_grupos_multiplantel.of_valida_nuevo_grupo(ll_cve_mat, ls_gpo )
	
	IF le_valida_audiovisual = 0 THEN 
		//MESSAGEBOX("Aviso", iuo_grupos_multiplantel.is_ocupado)
		MESSAGEBOX("Aviso", "El aula audiovisual no está disponible.")
		DESTROY iuo_grupos_multiplantel 
		RETURN -1 
	ELSEIF le_valida_audiovisual < 0 THEN 		
		MESSAGEBOX("Aviso", "Se produjo un error al validar apartado de aula multimedia.")
		DESTROY iuo_grupos_multiplantel 
		RETURN -1 	
	END IF	
	DESTROY iuo_grupos_multiplantel 
END IF 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

For ll_row_profesor = 1 To dw_profesor_auxiliar.RowCount()
	lb_existe_salon = false

	ll_cve_profesor_adj			= dw_profesor_auxiliar.GetItemNumber(ll_row_profesor,"cve_profesor")
	li_horas							= dw_profesor_auxiliar.GetItemNumber(ll_row_profesor,"horas")
	li_cve_categoria_auxiliar	= dw_profesor_auxiliar.GetItemNumber(ll_row_profesor,"cve_categoria_auxiliar")
	
	if isnull(ll_cve_profesor_adj) or ll_cve_profesor_adj = li_null then
		MessageBox("Profesor Adjunto sin clave", &		
            "Existe un Profesor Adjunto sin clave capturada.",StopSign!)		
		dw_profesor_auxiliar.ScrollToRow(ll_row_profesor)
		return -1	
	end if

	if ll_cve_profesor_adj <= 8 then
		MessageBox("Profesor Adjunto Invalido", &		
            "La clave del Profesor Adjunto no esta permitida.",StopSign!)		
		dw_profesor_auxiliar.ScrollToRow(ll_row_profesor)
		return -1			
	end if
	
	if isnull(li_horas) or li_horas = li_null then
		MessageBox("Horas invalidas", &		
            "Existe un Profesor Adjunto sin horas capturadas.",StopSign!)		
		dw_profesor_auxiliar.ScrollToRow(ll_row_profesor)
		return -1	
	end if

	if li_horas <= 0 then
		MessageBox("Horas invalidas", &		
            "Existe un Profesor Adjunto con horas invalidas capturadas.",StopSign!)		
		dw_profesor_auxiliar.ScrollToRow(ll_row_profesor)
		return -1	
	end if
	
	if isnull(li_cve_categoria_auxiliar) or li_cve_categoria_auxiliar = li_null then
		MessageBox("Tipo invalido", &		
            "Existe un Profesor Adjunto sin categoria capturada.",StopSign!)		
		dw_profesor_auxiliar.ScrollToRow(ll_row_profesor)
		return -1	
	end if

	
	If wf_existe_prof_duplicado(ll_cve_profesor_adj, ll_row_profesor) then
		MessageBox("Existe un Profesor Adjunto duplicado", &		
            "El profesor: "+string(ll_cve_profesor_adj)+" se encuentra duplicado",StopSign!)		
		dw_profesor_auxiliar.ScrollToRow(ll_row_profesor)
		return -1
	End If

	if li_horas > li_horas_mat_permitidas then
		MessageBox("Error en las horas de Profesor Adjunto", &		
           "No es posible registrar más horas: "+string(li_horas)+"~n de las permitidas: " &
		             +string(li_horas_mat_permitidas),StopSign!)		
		dw_profesor_auxiliar.ScrollToRow(ll_row_profesor)
		return -1
	end if
	
	if not(f_profesor_valido(ll_cve_profesor_adj)) then
		MessageBox("Profesor Inexistente", &
	           "El profesor "+string(ll_cve_profesor_adj)+ " no existe registrado~n"+&
				   "o se encuentra inactivo.",StopSign!)
		dw_profesor_auxiliar.SetItem(ll_row_profesor,"cve_profesor", ll_por_designar)
		ls_nombre_completo= f_obten_nombre_profesor(ll_por_designar,ls_apaterno, ls_amaterno, ls_nombre)
		dw_profesor_auxiliar.SetItem(ll_row_profesor,"nombre_completo", ls_nombre_completo)		
		dw_profesor_auxiliar.ScrollToRow(ll_row_profesor)
		return -1
	end if
	
	li_cve_categoria = f_obten_categoria_profesor(ll_cve_profesor_adj)
	if li_cve_categoria= -1 then
		MessageBox("Error en consulta de categoria", &		
		            "No es posible consultar la categoria del profesor capturado",StopSign!)			
		dw_profesor_auxiliar.ScrollToRow(ll_row_profesor)
	end if
	
	//	Revision para grupos no asimilados 	li_tipo <> 2
	//	claves de profesor validas 			ll_cve_profesor_adj > 8
	//	en profesores de asignatura 			li_cve_categoria = 4 
	if li_tipo <> 2 and ll_cve_profesor_adj > 8 and  li_cve_categoria = 4 then
		lds_data = CREATE datastore
	 	lds_data.DataObject = 'd_horas_profesor_coord'
		lds_data.SetTransObject(gtr_sce)
		ll_num_cords_adj = lds_data.Retrieve(ll_cve_profesor_adj,ll_cve_mat, ls_gpo, li_periodo, li_anio) 
		//***********************************************************************
		// Validación de número de horas adicionales si el profeso imparte una sola materia.
//		lds_data.FIND()

		INTEGER le_horas_temp, le_horas_totales 
		
		// Se cuentas las materias adicionales que da el profesor 
		SELECT COUNT( DISTINCT g.cve_mat ) AS sum_materias 
		INTO :le_horas_temp 
		FROM grupos g 
		WHERE g.cve_profesor = :ll_cve_profesor_adj 
		AND	g.tipo not in (1, 2)
		AND   g.periodo = :li_periodo
		AND   g.anio = :li_anio
		AND NOT (g.cve_mat = :ll_cve_mat) 
		AND	g.cond_gpo = 1 
		USING gtr_sce; 
		IF gtr_sce.SQLCODE < 0 THEN 
			MESSAGEBOX("Error", "Se produjo un error al recuperar las horas actuales del profesor: " + gtr_sce.SQLERRTEXT)
			RETURN -1
		END IF
		
		// Se acumulan las horas en el periodo actual.
		IF ISNULL(le_horas_temp) THEN le_horas_temp = 0 
		le_horas_totales = le_horas_temp

		SELECT COUNT(DISTINCT g.cve_mat ) AS sum_materias
		INTO :le_horas_temp  
		FROM grupos g
		WHERE g.cve_profesor = :ll_cve_profesor_adj 
		AND	g.tipo not in (1, 2)
		AND   g.periodo IN(SELECT periodo from periodos_por_procesos where cve_proceso = 4 and tipo_periodo <> (SELECT tipo FROM periodo WHERE periodo = :li_periodo))
		AND   g.anio = :li_anio
		AND NOT (g.cve_mat = :ll_cve_mat)
		AND	g.cond_gpo = 1 
		USING gtr_sce; 
		IF gtr_sce.SQLCODE < 0 THEN 
			MESSAGEBOX("Error", "Se produjo un error al recuperar las horas actuales del profesor en otros periodos activos: " + gtr_sce.SQLERRTEXT) 
			RETURN -1
		END IF

		// Se acumulan las horas en otros periodos
		IF ISNULL(le_horas_temp) THEN le_horas_temp = 0 
		le_horas_totales = le_horas_totales + le_horas_temp 
		
		// Si el profesor NO imparte más de una materia, se acumulan las horas adicionales permitidas
		IF le_horas_totales = 0 THEN 
			ll_horas_gpo_normal = ll_horas_gpo_normal + le_horas_adic_x_una_mat
		END IF
		
		//***********************************************************************
		ll_suma_horas= 0
		if ll_num_cords_adj>0 then
			ls_mensaje_adj = "~nEl Profesor Adjunto rebasa la cantidad de Horas Permitidas"
			ls_mensaje_adj =ls_mensaje_adj+    "~n Como Titular:"
			for ll_row_horas_coord=1 to ll_num_cords_adj
				ls_coordinacion= lds_data.GetItemString(ll_row_horas_coord,"coordinaciones_coordinacion")
				ll_horas_reales= lds_data.GetItemNumber(ll_row_horas_coord,"horas_tot_coord")
	// Si es verano, las horas deben ser por 2.5 y las horas maximas pasan de 16 a 20
//				if li_periodo= 1 then
//					ll_horas_reales = ll_horas_reales * 2.5
//					ll_horas_gpo_normal = ll_horas_verano
//				end if
				ll_horas_reales = ll_horas_reales * ld_factor_ajuste_horas
				ls_mensaje_adj =ls_mensaje_adj+     "~nCoordinación  ["+string(ll_row_horas_coord)+"]        :"+ ls_coordinacion
				ls_mensaje_adj =ls_mensaje_adj+     "~nHoras Coord.  ["+string(ll_row_horas_coord)+"]        :"+ string(ll_horas_reales)
				ll_suma_horas= ll_suma_horas + ll_horas_reales	 
			next
		end if
	
	//Profesor auxiliar	
		lds_data2 = CREATE datastore
		lds_data2.DataObject = 'd_horas_profesor_auxiliar'
		lds_data2.SetTransObject(gtr_sce)
		ll_num_cords2_adj = lds_data2.Retrieve(ll_cve_profesor_adj,ll_cve_mat, ls_gpo, li_periodo, li_anio)
		if ll_num_cords2_adj>0 then
			//Si no existieron registros como titular, pon el titulo
			if ll_num_cords_adj = 0 then
				ls_mensaje_adj =ls_mensaje_adj+ "~nEl Profesor Adjunto rebasa la cantidad de Horas Permitidas"
			end if
			
			ls_mensaje_adj =ls_mensaje_adj+    "~n Como Adjunto:"
			for ll_row_horas_coord=1 to ll_num_cords2_adj
				ls_coordinacion= lds_data2.GetItemString(ll_row_horas_coord,"coordinaciones_coordinacion")
				ll_horas_reales= lds_data2.GetItemNumber(ll_row_horas_coord,"horas_tot_coord")
	// Aqui no es necesario multiplicar las horas, ya que solo se consideran las capturadas
	//sin importar el periodo
				ls_mensaje_adj =ls_mensaje_adj+     "~nCoordinación  ["+string(ll_row_horas_coord)+"]        :"+ ls_coordinacion
				ls_mensaje_adj =ls_mensaje_adj+     "~nHoras Coord.  ["+string(ll_row_horas_coord)+"]        :"+ string(ll_horas_reales)
				ll_suma_horas= ll_suma_horas + ll_horas_reales	 
			next
		end if

		ll_suma_horas_mas_actual =ll_suma_horas + li_horas
	
	
		if ll_suma_horas_mas_actual>ll_horas_gpo_normal then
			ls_mensaje_adj =ls_mensaje_adj+     "~nHoras Grupo Actual   :"+ string(li_horas)	
			ls_mensaje_adj =ls_mensaje_adj+     "~n"
			ls_mensaje_adj =ls_mensaje_adj+     "~nHoras Permitidas     :"+string(ll_horas_gpo_normal)
			ls_mensaje_adj =ls_mensaje_adj+     "~nHoras Totales           :"+string(ll_suma_horas_mas_actual)
			MessageBox("Profesor Adjunto con Horas de mas", &		
		            ls_mensaje_adj,StopSign!)	
			dw_profesor_auxiliar.ScrollToRow(ll_row_profesor)		
			return -1
		end if
		DESTROY lds_data
		DESTROY lds_data2
	end if


Next

If wf_existe_prof_duplicado(ll_cve_profesor, 0) then
	MessageBox("Existe un Profesor Adjunto duplicado", &		
           "El profesor: "+string(ll_cve_profesor_adj)+" se encuentra duplicado"+&
           "~n ya que esta registrado como titular.",StopSign!)		
	return -1
End If

//Las siguientes validaciones solo aplican a los grupos normales (con horario requerido)
//if li_tipo<>1 and li_tipo<>2 and li_tipo<>4 then
IF le_requiere_horario = 1 THEN 
	if not horas_materia(ll_cve_mat, li_periodo, li_horas_mat_permitidas) then
			MessageBox("Error al consultar materia", &		
	            "No es posible consultar las horas de la materia: "+string(ll_cve_mat),StopSign!)		
			return -1
	end if

	li_horas_capturadas = wf_cuenta_horas_totales()
	
	if li_horas_capturadas > li_horas_mat_permitidas then
		if li_coord_usuario<>9999 then
			MessageBox("Error en el horario capturado", &		
	            "No es posible registrar más horas: "+string(li_horas_capturadas)+" de las permitidas: " &
					             +string(li_horas_mat_permitidas),StopSign!)		
			return -1
		else
			li_cap_mas_horas= MessageBox("El horario capturado excede a las horas permitidas", &		
	            "Se estan capturando: "+string(li_horas_capturadas)+" horas, las permitidas son: " &
					             +string(li_horas_mat_permitidas)+"¿Desea continuar?",Question!,YesNo!)		
			if li_cap_mas_horas <> 1 then
				return -1
			end if
		end if
	elseif li_horas_capturadas < li_horas_mat_permitidas then
			MessageBox("Error en el horario capturado", &		
	            "No es posible registrar menos horas: "+string(li_horas_capturadas)+" de las permitidas: " &
					             +string(li_horas_mat_permitidas),StopSign!)		
			return -1
	end if
end if

li_cve_categoria = f_obten_categoria_profesor(ll_cve_profesor)
if li_cve_categoria= -1 then
	MessageBox("Error en consulta de categoria", &		
	            "No es posible consultar la categoria del profesor capturado",StopSign!)			
end if
// Revision para grupos no asimilados 	li_tipo <> 2
//claves de profesor validas 				ll_cve_profesor > 8
//en profesores de asignatura 			li_cve_categoria = 4 
if li_tipo <> 2 and ll_cve_profesor > 8 and  li_cve_categoria = 4 then
	lds_data = CREATE datastore
	lds_data.DataObject = 'd_horas_profesor_coord'
	lds_data.SetTransObject(gtr_sce)
	ll_num_cords = lds_data.Retrieve(ll_cve_profesor,ll_cve_mat, ls_gpo, li_periodo, li_anio)
	ll_suma_horas= 0
	if ll_num_cords>0 then
		ls_mensaje = "~nEl Profesor Titular rebasa la cantidad de Horas Permitidas"
		ls_mensaje =ls_mensaje+    "~n Como Titular:"
		for ll_row_horas_coord=1 to ll_num_cords
			ls_coordinacion= lds_data.GetItemString(ll_row_horas_coord,"coordinaciones_coordinacion")
			ll_horas_reales= lds_data.GetItemNumber(ll_row_horas_coord,"horas_tot_coord")
// Si es verano, las horas deben ser por 2.5
//			if li_periodo= 1 then
//				ll_horas_reales = ll_horas_reales * 2.5
//			end if
			ll_horas_reales = ll_horas_reales * ld_factor_ajuste_horas
			ls_mensaje =ls_mensaje+     "~nCoordinación  ["+string(ll_row_horas_coord)+"]        :"+ ls_coordinacion
			ls_mensaje =ls_mensaje+     "~nHoras Coord.  ["+string(ll_row_horas_coord)+"]        :"+ string(ll_horas_reales)
			ll_suma_horas= ll_suma_horas + ll_horas_reales	 
		next
	end if
	
// Si solo tiene una materia, suma las posibles horas adicionales
IF le_numero_grupos_dif = 0 THEN 
	ll_horas_gpo_normal = ll_horas_gpo_normal + le_horas_adic_x_una_mat 
END IF
	
//Profesor auxiliar	
	lds_data2 = CREATE datastore
	lds_data2.DataObject = 'd_horas_profesor_auxiliar'
	lds_data2.SetTransObject(gtr_sce)
	ll_num_cords2 = lds_data2.Retrieve(ll_cve_profesor,ll_cve_mat, ls_gpo, li_periodo, li_anio)
	if ll_num_cords2>0 then
		//Si no existieron registros como titular, pon el titulo
		if ll_num_cords = 0 then
			ls_mensaje =ls_mensaje+ "~nEl Profesor Titular rebasa la cantidad de Horas Permitidas"
		end if
		
		ls_mensaje =ls_mensaje+    "~n Como Adjunto:"
		for ll_row_horas_coord=1 to ll_num_cords2
			ls_coordinacion= lds_data2.GetItemString(ll_row_horas_coord,"coordinaciones_coordinacion")
			ll_horas_reales= lds_data2.GetItemNumber(ll_row_horas_coord,"horas_tot_coord")
// Aqui no es necesario multiplicar las horas, ya que solo se consideran las capturadas
//sin importar el periodo
			ls_mensaje =ls_mensaje+     "~nCoordinación  ["+string(ll_row_horas_coord)+"]        :"+ ls_coordinacion
			ls_mensaje =ls_mensaje+     "~nHoras Coord.  ["+string(ll_row_horas_coord)+"]        :"+ string(ll_horas_reales)
			ll_suma_horas= ll_suma_horas + ll_horas_reales	 
		next
	end if
// Si es verano, las horas maximas pasan de 12 a 12
//	if li_periodo= 1 then
//		ll_horas_gpo_normal = ll_horas_verano
//	end if

	ll_suma_horas_mas_actual =ll_suma_horas + li_horas_capturadas
	
	
	if ll_suma_horas_mas_actual>ll_horas_gpo_normal then
		ls_mensaje =ls_mensaje+     "~nHoras Grupo Actual   :"+ string(li_horas_capturadas)	
		ls_mensaje =ls_mensaje+     "~n"
		ls_mensaje =ls_mensaje+     "~nHoras Permitidas     :"+string(ll_horas_gpo_normal)
		ls_mensaje =ls_mensaje+     "~nHoras Totales           :"+string(ll_suma_horas_mas_actual)
		MessageBox("Profesor con Horas de mas", &		
	            ls_mensaje,StopSign!)	
		return -1
	end if
	DESTROY lds_data
	DESTROY lds_data2
end if


//Modifica el derecho y uso del grupo en cuestion
For ll_row_horario = 1 To dw_horario.RowCount()
	li_clase_aula_orig = dw_horario.GetItemNumber(ll_row_horario,"clase_aula", Primary!, true)
	li_clase_aula = dw_horario.GetItemNumber(ll_row_horario,"clase_aula")
	li_cve_dia 		= dw_horario.GetItemNumber(ll_row_horario,"cve_dia")
	li_hora_inicio	= dw_horario.GetItemNumber(ll_row_horario,"hora_inicio")
	li_hora_final	= dw_horario.GetItemNumber(ll_row_horario,"hora_final")
	l_status = dw_horario.GetItemStatus(ll_row_horario, 0, Primary!)
//Si el registro es nuevo y es salon, hay que incrementar los ocupados en salones_derecho_uso
		If (l_status = New! or l_status = NewModified!) and (li_clase_aula= 0) then
			if not wf_puede_inc_derecho_uso(ll_cve_mat, li_cve_dia, li_hora_inicio, li_hora_final, li_cupo, lb_desc_sdu_se,1,1) Then
				Rollback using gtr_sce;
				Return -1 // Evento CambiaCupo
		   End if
		Elseif l_status =DataModified! Then
//Si el registro se modifico, hay que decrementar los ocupados del horario original
//e incrementar los actualmente capturados
			li_cve_dia_orig = dw_horario.GetItemNumber(ll_row_horario,"cve_dia", Primary!, true)
			li_hora_inicio_orig = dw_horario.GetItemNumber(ll_row_horario,"hora_inicio", Primary!, true)
			li_hora_final_orig = dw_horario.GetItemNumber(ll_row_horario,"hora_final", Primary!, true)
			//El registro anterior era salon
			If li_clase_aula_orig= 0 Then
				//Decrementa el derecho y uso del registro anterior
				If wf_puede_dec_derecho_uso(ll_cve_mat, li_cve_dia_orig, li_hora_inicio_orig, li_hora_final_orig, li_cupo, lb_desc_sdu_se,1,1) Then			
					// El horario actual es salon
					If li_clase_aula= 0 Then
						//Incrementa el derecho y uso correspondiente a los horarios capturados
						if not wf_puede_inc_derecho_uso(ll_cve_mat, li_cve_dia, li_hora_inicio, li_hora_final, li_cupo, lb_desc_sdu_se,1,1) Then
							Rollback using gtr_sce;
							Return -1 // Evento CambiaCupo
					   End if
					End if
				Else
					Rollback using gtr_sce;
					Return -1 // Evento CambiaCupo
			   End if
			Else  // Si registro anterior no era salon no es necesario decrementar los ocupados
				// El horario actual es salon
				If li_clase_aula= 0 Then
					//Incrementa el derecho y uso correspondiente a los horarios capturados
					if not wf_puede_inc_derecho_uso(ll_cve_mat, li_cve_dia, li_hora_inicio, li_hora_final, li_cupo, lb_desc_sdu_se,1,1) Then
						Rollback using gtr_sce;
						Return -1 // Evento CambiaCupo
				   End if
				End if				
			End if
		End if
Next	


return 1



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


end event

event nuevo_horario;dw_horario.TriggerEvent("nuevo")

end event

event borra_horario;dw_horario.TriggerEvent("borra_todo")

end event

event type integer valida_borra();//Funcion que revisa la logica de los grupos
string ls_estatus,ls_gpo, ls_gpo_asimilado
long ll_cve_mat
integer li_periodo, li_anio, ll_inscritos
long ll_cve_asimilada
integer li_tipo, li_primer_sem
long ll_row, ll_num_horarios
integer li_borra_primer_sem, li_actual_gpos, li_borra_con_inscritos

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

ll_inscritos = object.inscritos[ll_row]

il_cve_asimilada = ll_cve_asimilada
is_gpo_asimilado = ls_gpo_asimilado

if ll_inscritos > 0 then
	li_borra_con_inscritos = MessageBox("Grupo con Alumnos Inscritos", "El grupo "+string(ll_cve_mat)+":"+&
	ls_gpo+" tiene ["+ string(ll_inscritos)+"] alumnos inscritos. ¿Desea eliminarlo?",Question!, YesNo!)
	if li_borra_con_inscritos = 2 then
		return -1		
	end if
end if

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
long  ll_row_actual

//*************
INTEGER le_forma_imparte 
// Se verifica si el grupo es modular.
SELECT forma_imparte
INTO :le_forma_imparte 
FROM grupos 
WHERE cve_mat = :uo_1.il_cve_mat 
AND gpo = :uo_1.is_gpo 
AND periodo = :uo_1.ii_periodo
AND anio = :uo_1.ii_anio
USING gtr_sce; 
IF ISNULL(le_forma_imparte) THEN le_forma_imparte = 1 
IF le_forma_imparte = 2 THEN 
	MESSAGEBOX("Aviso", "El grupo especificado se imparte de manera modular, por lo que solo puede ser modificado desde la opción 'Grupos Modulares'")
	RETURN 0
END IF 



//*************
//*************
// Se agrega validación para verificar si el grupo es modular 
INTEGER le_num_prof
// Se verifica si el grupo es modular.
SELECT COUNT(*)
INTO :le_num_prof
FROM profesor_cotitular 
WHERE cve_mat = :uo_1.il_cve_mat 
AND gpo = :uo_1.is_gpo 
AND periodo = :uo_1.ii_periodo
AND anio = :uo_1.ii_anio
USING gtr_sce; 
IF ISNULL(le_num_prof) THEN le_num_prof = 0
IF le_num_prof > 1 THEN 
	MESSAGEBOX("Aviso", "El grupo especificado es Multititular, por lo que solo puede ser modificado desde la opción 'Grupos Modulares'")
	RETURN 0
END IF
//*************

event primero()
ll_row_actual =retrieve(uo_1.il_cve_mat, uo_1.is_gpo, uo_1.ii_periodo, uo_1.ii_anio)

if ll_row_actual>0 then
	ll_cve_profesor_original = this.GetItemNumber(ll_row_actual, "cve_profesor")
end if

STRING ls_evaluaprof
// Se recupera la bandera de Evaluar profesor 
SELECT evalua 
INTO :ls_evaluaprof 
FROM profesor_cotitular 
WHERE cve_mat = :uo_1.il_cve_mat 
AND gpo = :uo_1.is_gpo 
AND periodo = :uo_1.ii_periodo
AND anio = :uo_1.ii_anio 
AND titularidad = 1 
USING gtr_sce; 
IF ISNULL(ls_evaluaprof) OR TRIM(ls_evaluaprof) = "" THEN ls_evaluaprof = "S" 
IF le_num_prof > 1 THEN 
	MESSAGEBOX("Aviso", "Se produjo un error al recuperar la bandera de evaluación de profesor: " + gtr_sce.SQLERRTEXT) 
	RETURN 0
END IF

IF ls_evaluaprof = "S" THEN 
	cbx_evaluar.CHECKED = TRUE
ELSE
	cbx_evaluar.CHECKED = FALSE
END IF 


return ll_row_actual


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

//cambia el color de inscritos cuando ya hay alumnos
if ll_num_mats>0 then
	this.object.inscritos.color= RGB (255, 0, 0 )
else
	this.object.inscritos.color= RGB (0, 0, 0 )
end if

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

m_grupos_impartidos_nvo.m_registro.m_nuevo.enabled = true
m_grupos_impartidos_nvo.m_registro.m_actualiza.enabled = true
m_grupos_impartidos_nvo.m_registro.m_borraregistro.enabled = true
m_grupos_impartidos_nvo.m_registro.m_cargaregistro.enabled = true
m_grupos_impartidos_nvo.m_registro.m_nuevohorario.enabled = true
m_grupos_impartidos_nvo.m_registro.m_borrahorario.enabled = true
m_grupos_impartidos_nvo.m_registro.m_borrahorarioactual.enabled = true
m_grupos_impartidos_nvo.m_registro.m_nuevoprofesor.enabled = true
m_grupos_impartidos_nvo.m_registro.m_borraprofesoradjunto.enabled = true
m_grupos_impartidos_nvo.m_registro.enabled = true
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
		
case 'modalidad' 
	
	INTEGER le_tipo_grupo_val
	le_tipo_grupo_val = THIS.GETITEMNUMBER(row, "tipo") 	
	
	// Se valida la modalidad si el grupo es en líinea
	IF data = '4' THEN 
		// Se valida que la midalidad no sea "Asesoria"  
		IF THIS.GETITEMNUMBER(row, "tipo") = 1 THEN 
			MESSAGEBOX("Aviso", "Un grupo de asesorias no puede impartirse en Línea. ") 
			THIS.settext('') 
			RETURN 1 
		ELSEIF le_tipo_grupo_val <> 4  THEN 	
			MESSAGEBOX("Aviso", "La modalidad 'En línea' solo puede asignarse a grupos de tipo 'En Línea'. ") 
			THIS.settext('') 
			RETURN 2 							
		END IF 	
	
		// Se valida el horario con modalidad a DISTANCIA 	
	ELSEIF data = '2' THEN  
		// Si tiene algún registro con clase aula diferente de "OTRO" envía mensaje y rechaza el valor
		IF wf_valida_salon_en_linea() THEN 
			MESSAGEBOX("Aviso", "La modalidad a 'DISTANCIA' solo permite la clase aula 'OTRO' ") 
			THIS.settext('') 
			RETURN 1 								
		END IF 
	END IF 	
		
		
case	'tipo' 
	if li_tipo=2 then
		this.SetTabOrder ("cve_asimilada" , 33 )
		this.SetTabOrder ("gpo_asimilado" , 36 )		
		this.SetTabOrder ("cve_profesor" , 0 )
		this.SetTabOrder ("cupo" , 0 )		
		uo_3.enabled = false
		dw_horario.enabled = false
		dw_profesor_auxiliar.enabled = false
		m_grupos_impartidos_nvo.m_registro.m_nuevohorario.enabled = false
		m_grupos_impartidos_nvo.m_registro.m_borrahorario.enabled = false
		m_grupos_impartidos_nvo.m_registro.m_borrahorarioactual.enabled = false
		m_grupos_impartidos_nvo.m_registro.m_nuevoprofesor.enabled = false
		m_grupos_impartidos_nvo.m_registro.m_borraprofesoradjunto.enabled = false
//		this.SetTabOrder ("inscritos" , 0 )		
	else
		
		/****************/		
		// Se valida la modalidad si el grupo es de asesoria.
		IF data = '1' THEN 
			// Se valida que la midalidad no sea "En línea" 
			IF THIS.GETITEMNUMBER(row, "modalidad") = 4 THEN 
				MESSAGEBOX("Aviso", "Un grupo de asesorias no puede impartirse en Línea. ") 
				THIS.settext('') 
				RETURN 1 
			END IF 	
		//Si el grupo no es en línea 
		ELSEIF data <> '4' THEN 
			// Se valida que la midalidad no sea "En línea" 
			IF THIS.GETITEMNUMBER(row, "modalidad") = 4 THEN 
				MESSAGEBOX("Aviso", "Un grupo de Modalidad 'En Línea' solo puede ser de tipo 'En Línea'. ") 
				THIS.settext('') 
				RETURN 2 
			END IF 		
		END IF 
		/****************/
		
		this.SetTabOrder ("cve_asimilada" , 0 )
		this.SetTabOrder ("gpo_asimilado" , 0 )		
		object.cve_asimilada[row]= ll_long_null
		object.gpo_asimilado[row]= ls_str_null
	   this.SetTabOrder ("cve_profesor" , 61 )
	   this.SetTabOrder ("cupo" , 41 )	
			this.SetTabOrder ("modalidad" , 81)						
			this.SetTabOrder ("idioma" , 71 )						
			
		uo_3.enabled = true
		dw_horario.enabled = true
		dw_profesor_auxiliar.enabled = true
		m_grupos_impartidos_nvo.m_registro.m_nuevohorario.enabled = true
		m_grupos_impartidos_nvo.m_registro.m_borrahorario.enabled = true
		m_grupos_impartidos_nvo.m_registro.m_borrahorarioactual.enabled = true
		m_grupos_impartidos_nvo.m_registro.m_nuevoprofesor.enabled = true
		m_grupos_impartidos_nvo.m_registro.m_borraprofesoradjunto.enabled = true
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
		if ll_cve_asimilada <> 0	and ls_gpo_asimilado <> ""	then
			ll_prof_asimilado =f_obten_profesor_grupo(ll_cve_asimilada, ls_gpo_asimilado, li_periodo, li_anio)
			li_cupo =f_obten_cupo_grupo(ll_cve_asimilada, ls_gpo_asimilado, li_periodo, li_anio)
			li_inscritos =f_obten_inscritos_grupo(ll_cve_asimilada, ls_gpo_asimilado, li_periodo, li_anio)
		   this.SetTabOrder ("cve_profesor" , 61 )
		   this.SetTabOrder ("cupo" , 41 )		
			this.SetTabOrder ("modalidad" , 81 )						
			this.SetTabOrder ("idioma" , 71 )									
			
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
			
		   // Se recupera la modalidad del grupo asimilado 
		   INTEGER le_modalidad, le_idioma  	
		   SELECT modalidad, idioma  
			INTO :le_modalidad, :le_idioma 
			FROM grupos 
			WHERE cve_mat = :ll_cve_asimilada  
			AND gpo = :ls_gpo_asimilado 
			AND periodo = :li_periodo  
			AND anio = :li_anio 
			USING gtr_sce; 
			
			THIS.SETITEM(row, "modalidad", le_modalidad)
			THIS.SETITEM(row, "idioma", le_idioma)
			

			
			
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
long ll_num_mats, ll_cve_prof
int li_actualiza_sdu, li_hor_modified, li_hor_deleted, li_actualiza_prof, li_idioma, li_tipo, le_valida_audiovisual 
STRING ls_idioma

ll_cve_mat = uo_1.il_cve_mat
ls_gpo = uo_1.is_gpo
li_periodo = uo_1.ii_periodo
li_anio = uo_1.ii_anio

/*Acepta el texto de la última columna editada*/
AcceptText()


/****************************/
INTEGER le_tipo 
INTEGER le_modalidad

le_tipo = THIS.GETITEMNUMBER(1, "tipo")
le_modalidad = THIS.GETITEMNUMBER(1, "modalidad") 

// Modalidad en línea solo puede ser tipo en línea
IF (le_tipo = 4  AND le_modalidad <> 4) OR (le_tipo <> 4  AND le_modalidad = 4) THEN  	
	MESSAGEBOX("Aviso", "Un grupo de modalidad 'En Línea', solo puede ser de tipo 'En Línea' ")	 
	RETURN -1  
// Si el grupo es de modalidad a distancia, se verifica que el horario tenga solo clase aula "otro"   
ELSEIF le_modalidad = 2 AND wf_valida_salon_en_linea() THEN 
	MESSAGEBOX("Aviso", "Un grupo de tipo 'A Distancia', solo puede tener clase aula 'OTRO' ")	  
	RETURN -1  	
END IF 


INTEGER le_existe_otro 
INTEGER le_existe_clase 

le_existe_otro = dw_horario.FIND("clase_aula = 3", 0, dw_horario.ROWCOUNT() + 1)
le_existe_clase = dw_horario.FIND("clase_aula <> 3", 0, dw_horario.ROWCOUNT() + 1) 

// Se es modalidad presencial, ningún horario puede se clase aula OTRO 
IF le_modalidad = 1 AND le_existe_otro > 0 THEN 
	MESSAGEBOX("Aviso", "Un grupo de modalidad 'Presencial', no puede tener clase aula 'OTRO' ")	   
	RETURN -1  		
END IF 

// Se es modalidad HIBRIDA, NO todos los horarios son OTRO 
IF le_modalidad = 3 AND (le_existe_otro > 0 AND le_existe_clase = 0) THEN   
	MESSAGEBOX("Aviso", "Un grupo debe tener clase aula 'OTRO' con algúna otra clase para poder ser de modalidad 'Híbrida'")	   
	RETURN -1  			
END IF 	







/****************************/

li_idioma = dw_1.GETITEMNUMBER(1, "idioma") 
IF ISNULL(li_idioma) THEN li_idioma = 1 

DATETIME fecha_inicio
DATETIME fecha_fin


SELECT fecha 
INTO :fecha_inicio
FROM calendario  
WHERE periodo =  :gi_periodo
AND anio = :gi_anio
AND cve_evento = 1 
USING gtr_sce; 

SELECT fecha 
INTO :fecha_fin
FROM calendario  
WHERE periodo =  :gi_periodo
AND anio = :gi_anio
AND cve_evento = 2 
USING gtr_sce; 


/*Se complementa la información default*/ 
dw_1.SETITEM(1, "forma_imparte", 1)
dw_1.SETITEM(1, "fecha_inicio", fecha_inicio)
dw_1.SETITEM(1, "fecha_fin", fecha_fin)
dw_1.SETITEM(1, "factor_horas", 0)
dw_1.SETITEM(1, "sesionado", 'N')

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
		IF li_respuesta = 1 THEN 		
			IF li_idioma <> 1 THEN 
				SELECT idioma
				INTO :ls_idioma
				FROM idioma 
				WHERE cve_idioma = :li_idioma 
				USING gtr_sce;
				IF gtr_sce.SQLCODE < 0 THEN 
					MESSAGEBOX("Error", "Se produjo un error al recuperar la descripción del Idioma: " + gtr_sce.SQLERRTEXT)
					RETURN -1
				END IF
				li_respuesta = messagebox("Atención","El grupo será guardado para impartirse en " + ls_idioma + " ¿Desea Continuar?",Question!,YesNo!,2) 
			END IF
		END IF
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
			
			if wf_actualiza_sdu()=1 and dw_1.Update()=1 and dw_horario.Update()=1 and dw_profesor_auxiliar.Update()=1 then
				
				///////////////////////////////////////////////////////////////////////////////////////////////////////////////
				// Se verifica si se puede apartar el aula audiovisual. 
				///////////////////////////////////////////////////////////////////////////////////////////////////////////////	
				iuo_grupos_multiplantel = CREATE uo_grupos_multiplantel
				//le_valida_audiovisual = iuo_grupos_multiplantel.of_cancela_apartado(ll_cve_mat, ls_gpo)  
				li_tipo = object.tipo[THIS.GETROW()]

				IF li_tipo = 5 THEN 
					
					ll_cve_prof= LONG(uo_3.em_cve_profesor.text) 
					
					le_valida_audiovisual = iuo_grupos_multiplantel.of_inserta_apartado(ll_cve_mat, ls_gpo, ll_cve_prof)
					
					IF le_valida_audiovisual < 0 THEN 		
						MESSAGEBOX("Aviso", "Se produjo un error al validar apartado de aula multimedia.")
						ROLLBACK USING gtr_sce;
						DESTROY iuo_grupos_multiplantel 
						RETURN -1 	
					END IF	
					
				END IF 
				DESTROY iuo_grupos_multiplantel 
				///////////////////////////////////////////////////////////////////////////////////////////////////////////////
				///////////////////////////////////////////////////////////////////////////////////////////////////////////////				
				
				IF wf_inserta_horario_profesor() < 0 THEN 
					// NOTA: EL ROLLBACK SE HACE EN EL OBJETO DE SERVICIOS
					messagebox("Información","No se han guardado los cambios.", Information!)
				ELSE	
					COMMIT USING gtr_sce; 
					messagebox("Información","Se han guardado los cambios exitosamente.", Information!)
				END IF 
				
				
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
	li_hor_modified = dw_horario.ModifiedCount()
	li_hor_deleted= dw_horario.DeletedCount()
	if li_hor_modified +li_hor_deleted > 0 then
		li_actualiza_sdu = wf_actualiza_sdu()
		if li_actualiza_sdu = -1 then
			messagebox("Información","No es posible actualizar los salones derecho y uso")					
			return -1
		end if			
		dw_horario.TriggerEvent("actualiza")		
	end if
	ib_borrando= false		  
	uo_1.is_estatus = "Editar"
	uo_1.rb_editar.Checked = true
	uo_1.rb_editar.TriggerEvent(Clicked!)
	return 1
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

	//cambia el color de inscritos a negro
	this.object.inscritos.color= RGB (0, 0, 0 )
	

	// Si el grupo esta cancelado no se permite modificarle nada
	if li_cond_gpo = 0 then
		m_grupos_impartidos_nvo.m_registro.m_nuevo.enabled = false
		m_grupos_impartidos_nvo.m_registro.m_actualiza.enabled = false
		m_grupos_impartidos_nvo.m_registro.m_borraregistro.enabled = false
		m_grupos_impartidos_nvo.m_registro.m_cargaregistro.enabled = false
		m_grupos_impartidos_nvo.m_registro.m_nuevohorario.enabled = false
		m_grupos_impartidos_nvo.m_registro.m_borrahorario.enabled = false
		m_grupos_impartidos_nvo.m_registro.m_borrahorarioactual.enabled = false
		m_grupos_impartidos_nvo.m_registro.m_nuevoprofesor.enabled = false
		m_grupos_impartidos_nvo.m_registro.m_borraprofesoradjunto.enabled = false
		m_grupos_impartidos_nvo.m_registro.enabled = false
		this.enabled = false
		dw_horario.enabled = false
		dw_profesor_auxiliar.enabled = false
	else
		if not( m_grupos_impartidos_nvo.m_registro.enabled = false or &
			m_grupos_impartidos_nvo.m_registro.visible = false) then

			m_grupos_impartidos_nvo.m_registro.m_nuevo.enabled = true
			m_grupos_impartidos_nvo.m_registro.m_actualiza.enabled = true
			m_grupos_impartidos_nvo.m_registro.m_borraregistro.enabled = true
			m_grupos_impartidos_nvo.m_registro.m_cargaregistro.enabled = true
			m_grupos_impartidos_nvo.m_registro.m_nuevohorario.enabled = true
			m_grupos_impartidos_nvo.m_registro.m_borrahorario.enabled = true
			m_grupos_impartidos_nvo.m_registro.m_borrahorarioactual.enabled = true
			m_grupos_impartidos_nvo.m_registro.m_nuevoprofesor.enabled = true
			m_grupos_impartidos_nvo.m_registro.m_borraprofesoradjunto.enabled = true
			m_grupos_impartidos_nvo.m_registro.enabled = true
			this.enabled = true
			dw_horario.enabled = true
			dw_profesor_auxiliar.enabled = true
		end if
	end if	
	ls_nombre_completo= f_obten_nombre_profesor(ll_cve_profesor,ls_apaterno, ls_amaterno, ls_nombre)
	this.object.st_prof_apaterno.text = ls_apaterno
	this.object.st_prof_amaterno.text = ls_amaterno
	this.object.st_prof_nombre.text = ls_nombre
	uo_3.em_cve_profesor.text= string(ll_cve_profesor)
	uo_3.em_cve_profesor.Event Activarbusq()
	if li_cond_gpo = 1 then
		uo_3.enabled = true
	else
		uo_3.enabled = false		
	end if
		
		
//Grupo Asimilado
	if li_tipo=2 then
		this.SetTabOrder ("cve_asimilada" , 33 )
		this.SetTabOrder ("gpo_asimilado" , 36 )		
		this.SetTabOrder ("cve_profesor" , 0 )
		this.SetTabOrder ("cupo" , 0 )		
		this.SetTabOrder ("modalidad" , 0 )		
		m_grupos_impartidos_nvo.m_registro.m_nuevohorario.enabled = false
		m_grupos_impartidos_nvo.m_registro.m_borrahorario.enabled = false
		m_grupos_impartidos_nvo.m_registro.m_borrahorarioactual.enabled = false
		m_grupos_impartidos_nvo.m_registro.m_nuevoprofesor.enabled = false
		m_grupos_impartidos_nvo.m_registro.m_borraprofesoradjunto.enabled = false
		uo_3.enabled= false
		dw_horario.enabled = false
		ll_cve_asimilada = object.cve_asimilada[ll_row]
		ls_gpo_asimilado = object.gpo_asimilado[ll_row]
		if isnull(ll_cve_asimilada) then
			ll_cve_asimilada= 0
		end if
		if isnull(ls_gpo_asimilado) then
			ls_gpo_asimilado= ""
		end if

		dw_profesor_auxiliar.Retrieve(ll_cve_asimilada, ls_gpo_asimilado, li_periodo, li_anio)

		dw_profesor_auxiliar.enabled = false
//		this.SetTabOrder ("inscritos" , 0 )		
	elseif li_cond_gpo <> 0 then
		this.SetTabOrder ("cve_asimilada" , 0 )
		this.SetTabOrder ("gpo_asimilado" , 0 )		
	   this.SetTabOrder ("cve_profesor" , 61 )
	   this.SetTabOrder ("cupo" , 41 )		
		this.SetTabOrder ("modalidad" , 29 )		
		if not( m_grupos_impartidos_nvo.m_registro.enabled = false or &
			m_grupos_impartidos_nvo.m_registro.visible = false) then
			m_grupos_impartidos_nvo.m_registro.m_nuevohorario.enabled = true
			m_grupos_impartidos_nvo.m_registro.m_borrahorario.enabled = true
			m_grupos_impartidos_nvo.m_registro.m_borrahorarioactual.enabled = true
			m_grupos_impartidos_nvo.m_registro.m_nuevoprofesor.enabled = true
			m_grupos_impartidos_nvo.m_registro.m_borraprofesoradjunto.enabled = true
			uo_3.enabled= true
			dw_horario.enabled = true
			dw_profesor_auxiliar.enabled = true
		end if
//	   	this.SetTabOrder ("inscritos" , 51 )		
	end if
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
int li_wf_actualiza_sdu
int li_dw_horario
int li_dw_profesor_auxiliar
int li_deleterow
int li_dw_1
dwItemStatus l_status_inicial, l_status_final

l_status_inicial = dw_1.GetItemStatus( GetRow(), 0, Primary!)
		  

li_periodo = uo_1.ii_periodo
li_anio = uo_1.ii_anio
li_respuesta = messagebox("Atención","Esta seguro de querer borrar el grupo actual.",Question!,YesNo!,2)

if li_respuesta = 1 then
	ib_borrando = true
	if event valida_borra() = 1 then		
l_status_final = dw_1.GetItemStatus( GetRow(), 0, Primary!)
//		Debido a que existen foreign keys	que obligan integridad referencial de profesor_auxiliar a grupos 
//    y horario a grupos, por lo cual en el caso de una eliminación es necesario eliminar primero los 
//    registros dependientes (horario, profesor_auxiliar) y después el padre (grupos)		
		if dw_horario.Event borra_todo()=1 and dw_profesor_auxiliar.Event borra_todo()=1  then
l_status_final = dw_1.GetItemStatus( GetRow(), 0, Primary!)

li_wf_actualiza_sdu = wf_actualiza_sdu()
li_dw_horario = dw_horario.update()
l_status_final = dw_1.GetItemStatus( GetRow(), 0, Primary!)

li_dw_profesor_auxiliar = dw_profesor_auxiliar.update()
l_status_final = dw_1.GetItemStatus( GetRow(), 0, Primary!)
li_deleterow = deleterow(getrow())
l_status_final = dw_1.GetItemStatus( GetRow(), 0, Delete!)
li_dw_1 = dw_1.Update()
			
			
			if li_wf_actualiza_sdu= 1 and li_dw_horario=1 and li_dw_profesor_auxiliar=1 and li_deleterow	= 1 and li_dw_1=1 then
//			if wf_actualiza_sdu()= 1 and dw_horario.update()=1 and dw_profesor_auxiliar.update()=1 and deleterow(getrow())	= 1 and dw_1.Update()=1 then
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

event dberror;call super::dberror;MessageBox(sqlerrtext,sqlsyntax,StopSign!)

return 0
end event

