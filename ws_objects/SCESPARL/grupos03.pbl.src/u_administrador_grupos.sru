$PBExportHeader$u_administrador_grupos.sru
forward
global type u_administrador_grupos from nonvisualobject
end type
end forward

global type u_administrador_grupos from nonvisualobject
end type
global u_administrador_grupos u_administrador_grupos

type variables
u_datastore ids_horario, ids_profesor_auxiliar, ids_grupos, ids_sdu
u_datastore  ids_horario_coord, ids_profesor_auxiliar_coord, ids_grupos_coord, ids_sdu_coord
long il_cve_mat[]
string is_gpo[]
end variables 

forward prototypes
public function boolean of_dec_derecho_uso_sc (long al_cve_mat, integer ai_dia, integer ai_hor_ini, integer ai_hor_fin, integer ai_cupo, boolean ab_desc_sdu_se)
public function boolean of_inc_derecho_uso_sc (long al_cve_mat, integer ai_dia, integer ai_hor_ini, integer ai_hor_fin, integer ai_cupo, boolean ab_desc_sdu_se)
public function integer of_obten_grupo (long al_cve_mat, string as_gpo, integer ai_periodo, integer ai_anio)
//public function integer of_borra_grupo (long al_cve_mat, string as_gpo, integer ai_periodo, integer ai_anio, boolean ab_desc_sdu_se)
public function long of_obten_grupos_coord (long al_cve_coordinacion, integer ai_periodo, integer ai_anio)
public function integer of_reset_dw ()
public function integer of_borra_grupos_coord (long al_cve_coordinacion, integer ai_periodo, integer ai_anio, boolean ab_desc_sdu_se)
public function integer of_borra_ds_coord (ref datastore ads_datastore)
public function integer of_actualiza_sdu_coord (boolean ab_desc_sdu_se)
public function integer of_asigna_arrays_grupos (long al_cve_mat[], string as_gpo[])
public function long of_cuenta_grupos_que_asimila (long al_cve_mat, string as_gpo, integer ai_periodo, integer ai_anio)
public function integer of_actualiza_sdu (long al_cve_mat, boolean ab_desc_sdu_se)
public function long of_cuenta_horario_de_salon (integer ai_periodo, integer ai_anio, string as_cve_salon, integer ai_clase_aula)
public function integer of_limpia_horario_de_salon (integer ai_periodo, integer ai_anio, string as_cve_salon, integer ai_clase_aula)
end prototypes

public function boolean of_dec_derecho_uso_sc (long al_cve_mat, integer ai_dia, integer ai_hor_ini, integer ai_hor_fin, integer ai_cupo, boolean ab_desc_sdu_se);//of_dec_derecho_uso_sc
//Disminuye el derecho uso en base a los valores recibidos
//al_cve_mat			long
//ai_dia					integer
//ai_hor_ini			integer
//ai_hor_fin			integer
//ai_cupo				integer	
//ab_desc_sdu_se		boolean
//*! NOTA IMPORTANTE
//En este procedimiento no se efectua un COMMIT/ROLLBACK sobre la operación de 
//decremento al derecho y uso de los salones, por lo tanto, es necesrio que la función que la llame
//lleve a cabo la finalización de la transacción ya sea con un COMMIT USING gtr_sce; 
//o con un ROLLBACK USING gtr_sce;
// NOTA IMPORTANTE !*


Integer Depto=0, li_diferencia,hora_inicio_sdu,li_ciclo
Boolean ConsultaDepto = False
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
	//Tabla bloqueada o coordinación inexistente
	If gtr_sce.sqlcode <> 0 Then 
		Messagebox("Error al consultar la coordinacion [f_dec_derecho_uso_sc]",gtr_sce.sqlerrtext,StopSign!)
   	Return False
	End if
End If
If gtr_sce.sqlcode = 0 or Depto = 7300 Then	
	If ai_hor_fin > ai_hor_ini Then
		li_diferencia = ai_hor_fin - ai_hor_ini
		hora_inicio_sdu = ai_hor_ini
		FOR li_ciclo=1 TO li_diferencia
			Update salones_derecho_uso
			Set ocupados = ocupados - 1 // decrementa uno en el campo de ocupados 
			Where (cve_coordinacion	= :depto) and (cve_dia	= :ai_dia) and
					(hora_inicio = :Hora_inicio_sdu) using gtr_sce;
			hora_inicio_sdu ++
			If gtr_sce.sqlcode = -1 Then
				ls_mensaje = gtr_sce.sqlerrtext
				MessageBox("Error al decrementar el derecho y uso [f_dec_derecho_uso_sc]",ls_mensaje,StopSign!)
				Return False
			End If	
		Next
		Return True
	Else
		Messagebox("Aviso","el horario no es valido, favor de verificar",StopSign!)
		Return False
	End If
	Messagebox("Error","al obtener la clave del departamento",StopSign!)
	Return False
End If 

end function

public function boolean of_inc_derecho_uso_sc (long al_cve_mat, integer ai_dia, integer ai_hor_ini, integer ai_hor_fin, integer ai_cupo, boolean ab_desc_sdu_se);//of_inc_derecho_uso_sc
//Incrementa el derecho uso en base a los valores recibidos
//al_cve_mat
//ai_dia
//ai_hor_ini
//ai_hor_fin
//ai_cupo
//ab_desc_sdu_se
//*! NOTA IMPORTANTE
//En este procedimiento no se efectua un COMMIT/ROLLBACK sobre la operación de 
//decremento al derecho y uso de los salones, por lo tanto, es necesrio que la función que la llame
//lleve a cabo la finalización de la transacción ya sea con un COMMIT USING gtr_sce; 
//o con un ROLLBACK USING gtr_sce;
// NOTA IMPORTANTE !*


Integer Depto=0,li_diferencia, hora_inicio_sdu,li_ciclo, Derecho=0,Ocupados=0
Boolean TieneDerechoTodosOk = True, ConsultaDepto = False
String ls_mensaje

ConsultaDepto = True

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
// Tabla bloqueada o coordinacion inexistente
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
			IF gtr_sce.sqlcode = 0 Then			
				IF Ocupados >= Derecho Then
					TieneDerechoTodosOk = False
					Messagebox("No tiene derecho","Hora Inicio = "+string(Hora_inicio_sdu)+" Ocupados = "+string(Ocupados)+" Derecho = "+string(Derecho),StopSign!)  								 
				Else	
					Update salones_derecho_uso
					Set ocupados = ocupados + 1 // Incrementa uno en el campo de ocupados 
					Where (cve_coordinacion	= :depto) and (cve_dia	= :ai_dia) and
							(hora_inicio = :Hora_inicio_sdu) 							
							using gtr_sce;
					IF gtr_sce.sqlcode <> 0 Then
						TieneDerechoTodosOk= False
						ls_mensaje = gtr_sce.sqlerrtext
						Messagebox("Error al actualizar la tabla derecho_y_uso f_inc_derecho_uso_sc",ls_mensaje,StopSign!)
 					End IF	
				End IF
			Else
				TieneDerechoTodosOk = False
				Messagebox("No tiene asignado un derecho y uso para:","Dia "+Dia_String(ai_dia)+"~nHora Inicio "+string(Hora_inicio_sdu)+"~nCupo "+string(ai_cupo)+" "+gtr_sce.sqlerrtext,StopSign!)
			End IF // Sqlcode del select 
			hora_inicio_sdu ++
		Next
	Else
		TieneDerechoTodosOk = False
		Messagebox("Aviso","El horario no es valido, favor de Verificar",StopSign!)
	End IF
Else	
	TieneDerechoTodosOk = False
	Messagebox("Error","Al obtener el numero de coordinacion",StopSign!)
End IF 

IF TieneDerechoTodosOk Then
	Return True
Else
	Return False
End IF	

end function

public function integer of_obten_grupo (long al_cve_mat, string as_gpo, integer ai_periodo, integer ai_anio);//of_obten_grupo
//Objetivo:
//Recuperar la información de un grupo así como sus registros dependientes
//Recibe
//al_cve_mat	long
//as_gpo			str
//ai_periodo	integer
//ai_anio		integer
long ll_grupos, ll_horario, ll_profesor_auxiliar

ll_grupos = ids_grupos.Retrieve(al_cve_mat, as_gpo, ai_periodo, ai_anio)
ll_horario = ids_horario.Retrieve(al_cve_mat, as_gpo, ai_periodo, ai_anio)
ll_profesor_auxiliar = ids_profesor_auxiliar.Retrieve(al_cve_mat, as_gpo,ai_periodo, ai_anio)

IF ll_grupos >0 AND  ll_horario>=0 AND ll_profesor_auxiliar>=0 THEN
	RETURN 1
ELSEIF ll_grupos= 0 THEN
	MessageBox("Grupo Inexistente","El grupo ["+string(al_cve_mat)+"-"+as_gpo+"] no existe", StopSign!)
	RETURN -1	
ELSEIF ll_grupos= -1 THEN
	MessageBox("Error en Grupo","No es posible leer el grupo ["+string(al_cve_mat)+"-"+as_gpo+"]", StopSign!)
	RETURN -1		
ELSEIF ll_horario= -1 THEN
	MessageBox("Error en Horario de Grupo","No es posible leer el horario del grupo ["+string(al_cve_mat)+"-"+as_gpo+"]", StopSign!)
	RETURN -1		
ELSEIF ll_profesor_auxiliar= -1 THEN
	MessageBox("Error en Profesor Auxiliar de Grupo","No es posible leer el profesor auxiliar del grupo ["+string(al_cve_mat)+"-"+as_gpo+"]", StopSign!)
	RETURN -1		
END IF

RETURN 1
end function

public function long of_obten_grupos_coord (long al_cve_coordinacion, integer ai_periodo, integer ai_anio);//of_obten_grupos_coord
//Objetivo:
//Recuperar la información de un grupo así como sus registros dependientes
//Recibe
//al_cve_coordinacion	long
//ai_periodo				integer
//ai_anio					integer
long ll_grupos, ll_horario, ll_profesor_auxiliar
long ll_row_actual, ll_cve_mat,ll_num_asimilados
string ls_gpo
integer li_periodo, li_anio, li_res_setitem

ll_grupos = ids_grupos_coord.Retrieve(al_cve_coordinacion, ai_periodo, ai_anio)
ll_horario = ids_horario_coord.Retrieve(al_cve_coordinacion, ai_periodo, ai_anio)
ll_profesor_auxiliar = ids_profesor_auxiliar_coord.Retrieve(al_cve_coordinacion, ai_periodo, ai_anio)

FOR ll_row_actual= 1 TO ll_grupos
	ll_cve_mat = ids_grupos_coord.GetItemNumber(ll_row_actual,"cve_mat")
	ls_gpo = ids_grupos_coord.GetItemString(ll_row_actual,"gpo")
	li_periodo = ids_grupos_coord.GetItemNumber(ll_row_actual,"periodo")
	li_anio = ids_grupos_coord.GetItemNumber(ll_row_actual,"anio")
	ll_num_asimilados = of_cuenta_grupos_que_asimila(ll_cve_mat, ls_gpo, li_periodo, li_anio)
	li_res_setitem = ids_grupos_coord.SetItem(ll_row_actual,"grupos_que_asimila",ll_num_asimilados)
	IF li_res_setitem = -1 OR ll_num_asimilados= -1 THEN 
		MessageBox("Error en Grupo","No es posible leer los grupos asimilantes de la coordinacion ["+string(al_cve_coordinacion)+"]", StopSign!)
		RETURN -1
	END IF
NEXT

IF ll_grupos >0 AND  ll_horario>=0 AND ll_profesor_auxiliar>=0 THEN
	RETURN 1
ELSEIF ll_grupos= 0 THEN
	MessageBox("Grupos Inexistentes","La coordinación ["+string(al_cve_coordinacion)+"] no tiene grupos disponibles", StopSign!)
	RETURN -1	
ELSEIF ll_grupos= -1 THEN
	MessageBox("Error en Grupo","No es posible leer los grupos de la coordinación ["+string(al_cve_coordinacion)+"]", StopSign!)
	RETURN -1		
ELSEIF ll_horario= -1 THEN
	MessageBox("Error en Horario de Grupo","No es posible leer los horarios de la coordinación ["+string(al_cve_coordinacion)+"]", StopSign!)
	RETURN -1		
ELSEIF ll_profesor_auxiliar= -1 THEN
	MessageBox("Error en Profesor Auxiliar de Grupo","No es posible leer los profesores auxiliares de la coordinación ["+string(al_cve_coordinacion)+"]", StopSign!)
	RETURN -1		
END IF

RETURN 1
end function

public function integer of_reset_dw ();//of_reset_dw
//Objetivo:
//Reinicializa los dw utilizados en el objeto
//Recibe
//nada

integer li_grupos, li_grupos_coord, li_horario, li_horario_coord, li_profesor_auxiliar
integer li_profesor_auxiliar_coord, li_sdu, li_sdu_coord

li_grupos = ids_grupos.Reset()
li_grupos_coord = ids_grupos_coord.Reset()
li_horario= ids_horario.Reset()
li_horario_coord = ids_horario_coord.Reset()
li_profesor_auxiliar= ids_profesor_auxiliar.Reset()
li_profesor_auxiliar_coord= ids_profesor_auxiliar_coord.Reset()
li_sdu= ids_sdu.Reset()
li_sdu_coord =ids_sdu_coord.Reset()

IF (li_grupos=1 and li_grupos_coord=1) AND ( li_horario=1) AND ( li_horario_coord=1) AND ( li_profesor_auxiliar=1) &
   AND (li_profesor_auxiliar_coord=1) AND (li_sdu=1) AND (li_sdu_coord=1) THEN
	RETURN 1	
ELSE
	MessageBox("Error ", "No es posible limpiar los datawindows de grupos",StopSign!)
	RETURN -1
END IF



RETURN 1

end function

public function integer of_borra_grupos_coord (long al_cve_coordinacion, integer ai_periodo, integer ai_anio, boolean ab_desc_sdu_se);//of_borra_grupos_coord
//Objetivo:
//Eliminar un grupo, reestableciendo el derecho y uso a los salones de la coordinación en cuestion
//Recibe
//al_cve_coordinacion	long
//ai_periodo	integer
//ai_anio		integer
//ab_desc_sdu_se integer


string ls_mensaje_sql

IF ids_grupos_coord.RowCount()> 0 THEN
	
//	IF ids_horario.of_borra_todo()=1 and ids_profesor_auxiliar.of_borra_todo()=1  THEN
//		IF of_actualiza_sdu(al_cve_mat, ab_desc_sdu_se)= 1 and ids_horario.update()=1 and ids_profesor_auxiliar.update()=1 and ids_grupos.deleterow(ids_grupos.getrow())= 1 and ids_grupos.Update()=1 THEN
//			COMMIT USING gtr_sce;
//			messagebox("Información","El grupo se ha eliminado exitosamente",Information!)					
//			RETURN 1
//		ELSE
//			ls_mensaje_sql= gtr_sce.SqlErrText
//			ROLLBACK USING gtr_sce;						  
//			MessageBox("Error al eliminar el horario", ls_mensaje_sql,StopSign!)
//			RETURN -1
//		END IF
//	ELSE
//		MessageBox("Información","No es posible eliminar los horarios y los profesores auxiliares",StopSign!)					
//		RETURN -1
//	END IF	
ELSE	
	MessageBox("Grupos no borrados","No es posible eliminar los grupos de la coordinación ["+string(al_cve_coordinacion)+"]", StopSign!)
	RETURN -1		
END IF

RETURN 1

end function

public function integer of_borra_ds_coord (ref datastore ads_datastore);//of_borra_ds_coord
//Elimina los registros correspondientes al datastore recibido en base a los 
//elementos existentes en el array de los grupos
//Recibe:	ads_datastore   datastore
//Devuelve: nada

long ll_tamanio_array, ll_indice_actual, ll_row_buscado, ll_num_rows_ds, ll_cve_mat
string ls_gpo
integer li_res_delete

ll_tamanio_array= upperbound(il_cve_mat)
ll_num_rows_ds = ads_datastore.RowCount()

FOR ll_indice_actual = 1 TO ll_tamanio_array
	ll_cve_mat= il_cve_mat[ll_indice_actual]
	ls_gpo= is_gpo[ll_indice_actual]
	IF NOT isnull(ll_cve_mat) THEN
		ll_row_buscado= ads_datastore.Find("cve_mat = "+string(ll_cve_mat)+" and gpo = '"+ls_gpo+"'",1, ll_num_rows_ds)
		DO WHILE ll_row_buscado > 0
			IF ll_row_buscado> 0 THEN
				li_res_delete= ads_datastore.DeleteRow(ll_row_buscado)
				IF li_res_delete<>1 THEN
					RETURN -1
				END IF
			END IF	
			ll_row_buscado++
			// Evita un ciclo infinito
			IF ll_row_buscado > ll_num_rows_ds THEN EXIT	
			ll_row_buscado= ads_datastore.Find("cve_mat = "+string(ll_cve_mat)+" and gpo = '"+ls_gpo+"'",1, ll_num_rows_ds)
		LOOP
	END IF
NEXT

RETURN 1
end function

public function integer of_actualiza_sdu_coord (boolean ab_desc_sdu_se);//of_actualiza_sdu_coord
//OBJETIVO: Actualizar el derecho y uso de los grupos en base a los valores recibidos como parametros
//
//RECIBE:
//
//ab_desc_sdu_se	boolean

dwItemStatus l_status, l_status_deleted
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
long ll_cve_mat_del

lb_desc_sdu_se= ab_desc_sdu_se
li_cupo = 0

ll_num_rows_deleted = ids_horario_coord.DeletedCount()

For ll_row_deleted = 1 to ll_num_rows_deleted
	l_status_deleted = ids_horario_coord.GetItemStatus(ll_row_deleted, 0, Delete!)
	li_clase_aula_orig_del = ids_horario_coord.GetItemNumber(ll_row_deleted,"clase_aula", Delete!, true)
	ll_cve_mat_del = ids_horario_coord.GetItemNumber(ll_row_deleted,"cve_mat", Delete!, true)
	If l_status_deleted =DataModified! or l_status_deleted = NotModified! THEN
//Si el registro se modifico o no, al ser eliminado hay que decrementar los ocupados del horario original
//e incrementar los actualmente capturados
		li_cve_dia_orig_del = ids_horario_coord.GetItemNumber(ll_row_deleted,"cve_dia", Delete!, true)
		li_hora_inicio_orig_del = ids_horario_coord.GetItemNumber(ll_row_deleted,"hora_inicio", Delete!, true)
		li_hora_final_orig_del = ids_horario_coord.GetItemNumber(ll_row_deleted,"hora_final", Delete!, true)
		//El registro anterior era salon
		If li_clase_aula_orig_del= 0 Then
			//Decrementa el derecho y uso del registro anterior
			If not f_dec_derecho_uso_sc(ll_cve_mat_del, li_cve_dia_orig_del, li_hora_inicio_orig_del, li_hora_final_orig_del, li_cupo, lb_desc_sdu_se) Then			
				Return -1 // Evento CambiaCupo
		   End if
		End if // Si registro anterior no era salon no es necesario decrementar los ocupados
	End if
Next

RETURN 1

end function

public function integer of_asigna_arrays_grupos (long al_cve_mat[], string as_gpo[]);//of_asigna_arrays_grupos
//Asigna los grupos a eliminar
//Recibe:  al_cve_mat array long de materias
//			as_gpo 		string de grupos
			
			
string ls_null
long ll_null, ll_indice_array, ll_tamanio_array_local, ll_tamanio_array_recibido

SetNull(ll_null)
SetNull(ls_null)

ll_tamanio_array_local= upperbound(il_cve_mat)
ll_tamanio_array_recibido= upperbound(al_cve_mat)

FOR ll_indice_array = 1 TO ll_tamanio_array_local
	il_cve_mat[ll_indice_array]= ll_null
	is_gpo[ll_indice_array]= ls_null
NEXT

FOR ll_indice_array = 1 TO ll_tamanio_array_recibido
	il_cve_mat[ll_indice_array]= al_cve_mat[ll_indice_array]
	is_gpo[ll_indice_array]= as_gpo[ll_indice_array]
NEXT

RETURN ll_tamanio_array_recibido

end function

public function long of_cuenta_grupos_que_asimila (long al_cve_mat, string as_gpo, integer ai_periodo, integer ai_anio);//of_cuenta_grupos_que_asimila
//Recibe			al_cve_mat		long
//					as_gpo			string
//					ai_periodo 		integer
//					ai_anio 			integer

//Devuelve		-1		No pudo contar los grupos
//				>=0		La cantidad de grupo 

integer li_codigo_sql
string ls_mensaje, ls_titulo_mensaje, ls_null
long ll_num_grupos
boolean lb_transaccion=false
SetNull(ls_null)

SELECT count(*)
INTO :ll_num_grupos
FROM grupos
WHERE cve_asimilada = :al_cve_mat
AND	gpo_asimilado	= :as_gpo
AND	periodo = :ai_periodo
AND	anio =	:ai_anio
USING gtr_sce;

li_codigo_sql = gtr_sce.SqlCode 
ls_mensaje = gtr_sce.SqlErrtext

IF li_codigo_sql<> -1 THEN
	RETURN ll_num_grupos
ELSE
	lb_transaccion= false
	ls_titulo_mensaje= "No es posible consultar los grupos"
	GOTO ERROR
END IF

ERROR:
IF lb_transaccion THEN
	ROLLBACK USING gtr_sce;
END IF
MessageBox(ls_titulo_mensaje,ls_mensaje,StopSign!)
RETURN -1


end function

public function integer of_actualiza_sdu (long al_cve_mat, boolean ab_desc_sdu_se);//of_actualiza_sdu
//OBJETIVO: Actualizar el derecho y uso de un grupo en base a los valores recibidos como parametros
//
//RECIBE:
//
//al_cve_mat		long
//ab_desc_sdu_se	boolean


dwItemStatus l_status, l_status_deleted
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

ll_cve_mat = al_cve_mat
lb_desc_sdu_se= ab_desc_sdu_se
li_cupo = 0

ll_num_rows_deleted = ids_horario.DeletedCount()

For ll_row_deleted = 1 to ll_num_rows_deleted
	l_status_deleted = ids_horario.GetItemStatus(ll_row_deleted, 0, Delete!)
	li_clase_aula_orig_del = ids_horario.GetItemNumber(ll_row_deleted,"clase_aula", Delete!, true)
	If l_status_deleted =DataModified! or l_status_deleted = NotModified! THEN
//Si el registro se modifico, al ser eliminado hay que decrementar los ocupados del horario original
//e incrementar los actualmente capturados
		li_cve_dia_orig_del = ids_horario.GetItemNumber(ll_row_deleted,"cve_dia", Delete!, true)
		li_hora_inicio_orig_del = ids_horario.GetItemNumber(ll_row_deleted,"hora_inicio", Delete!, true)
		li_hora_final_orig_del = ids_horario.GetItemNumber(ll_row_deleted,"hora_final", Delete!, true)
		//El registro anterior era salon
		If li_clase_aula_orig_del= 0 Then
			//Decrementa el derecho y uso del registro anterior
			If not f_dec_derecho_uso_sc(ll_cve_mat, li_cve_dia_orig_del, li_hora_inicio_orig_del, li_hora_final_orig_del, li_cupo, lb_desc_sdu_se) Then			
				Return -1 // Evento CambiaCupo
		   End if
		End if // Si registro anterior no era salon no es necesario decrementar los ocupados
	End if
Next


For ll_row_horario = 1 To ids_horario.RowCount()
	li_clase_aula_orig = ids_horario.GetItemNumber(ll_row_horario,"clase_aula", Primary!, true)
	li_clase_aula = ids_horario.GetItemNumber(ll_row_horario,"clase_aula")
	li_cve_dia 		= ids_horario.GetItemNumber(ll_row_horario,"cve_dia")
	li_hora_inicio	= ids_horario.GetItemNumber(ll_row_horario,"hora_inicio")
	li_hora_final	= ids_horario.GetItemNumber(ll_row_horario,"hora_final")
	l_status = ids_horario.GetItemStatus(ll_row_horario, 0, Primary!)
//Si el registro es nuevo y es salon, hay que incrementar los ocupados en salones_derecho_uso
		If (l_status = New! or l_status = NewModified!) and (li_clase_aula= 0) then
			if not f_inc_derecho_uso_sc(ll_cve_mat, li_cve_dia, li_hora_inicio, li_hora_final, li_cupo, lb_desc_sdu_se) Then
				Return -1 // Evento CambiaCupo
		   End if
		Elseif l_status =DataModified! tHEN
//Si el regisro se modifico, hay que decrementar los ocupados del horario original
//e incrementar los actualmente capturados
			li_cve_dia_orig = ids_horario.GetItemNumber(ll_row_horario,"cve_dia", Primary!, true)
			li_hora_inicio_orig = ids_horario.GetItemNumber(ll_row_horario,"hora_inicio", Primary!, true)
			li_hora_final_orig = ids_horario.GetItemNumber(ll_row_horario,"hora_final", Primary!, true)
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

public function long of_cuenta_horario_de_salon (integer ai_periodo, integer ai_anio, string as_cve_salon, integer ai_clase_aula);//of_cuenta_horario_de_salon
//Recibe			ai_periodo 		integer
//					ai_anio 			integer
//					as_cve_salon	string
//Devuelve		-1		No pudo contar los horarios
//				>=0		La cantidad de horario 

integer li_codigo_sql
string ls_mensaje, ls_titulo_mensaje, ls_null
long ll_num_horarios
boolean lb_transaccion=false
SetNull(ls_null)

SELECT count(*)
INTO :ll_num_horarios
FROM horario
WHERE periodo = :ai_periodo
AND	anio =	:ai_anio
AND (cve_salon = :as_cve_salon OR :as_cve_salon= "9999")
AND (clase_aula = :ai_clase_aula OR :ai_clase_aula= 9999)
USING gtr_sce;

li_codigo_sql = gtr_sce.SqlCode 
ls_mensaje = gtr_sce.SqlErrtext

IF li_codigo_sql<> -1 THEN
	RETURN ll_num_horarios
ELSE
	lb_transaccion= false
	ls_titulo_mensaje= "No es posible consultar los horarios"
	GOTO ERROR
END IF

ERROR:
IF lb_transaccion THEN
	ROLLBACK USING gtr_sce;
END IF
MessageBox(ls_titulo_mensaje,ls_mensaje,StopSign!)
RETURN -1


end function

public function integer of_limpia_horario_de_salon (integer ai_periodo, integer ai_anio, string as_cve_salon, integer ai_clase_aula);//of_limpia_horario_de_salon
//Recibe			ai_periodo 		integer
//					ai_anio 			integer
//					as_cve_salon	string
//Devuelve		-1		No pudo actualizar los horarios
//				0		La actualizacion fue exitosa
//				100	No se encontraron horarios con dicho salon

integer li_codigo_sql
string ls_mensaje, ls_titulo_mensaje, ls_null
long ll_num_horarios
boolean lb_transaccion=false
SetNull(ls_null)

UPDATE horario
SET cve_salon = :ls_null
FROM horario
WHERE periodo = :ai_periodo
AND	anio =	:ai_anio
AND (cve_salon = :as_cve_salon OR :as_cve_salon= "9999")
AND (clase_aula = :ai_clase_aula OR :ai_clase_aula= 9999)
USING gtr_sce;

li_codigo_sql = gtr_sce.SqlCode 
ls_mensaje = gtr_sce.SqlErrtext
	
IF li_codigo_sql<> -1 THEN
	COMMIT USING gtr_sce;
	RETURN 0
ELSE
	ls_titulo_mensaje= "No es posible actualizar los horarios"
	GOTO ERROR
END IF


ERROR:
IF lb_transaccion THEN
	ROLLBACK USING gtr_sce;
END IF
MessageBox(ls_titulo_mensaje,ls_mensaje,StopSign!)
return -1

end function

public function integer of_borra_grupo (long al_cve_mat, string as_gpo, integer ai_periodo, integer ai_anio, boolean ab_desc_sdu_se);//of_borra_grupo
//Objetivo:
//Eliminar un grupo, reestableciendo el derecho y uso a los salones de la coordinación en cuestion
//Recibe
//al_cve_mat	long
//as_gpo		str
//ai_periodo	integer
//ai_anio		integer
//ab_desc_sdu_se integer


string ls_mensaje_sql

IF of_obten_grupo(al_cve_mat, as_gpo, ai_periodo, ai_anio) = 1 THEN
	IF ids_horario.of_borra_todo()=1 and ids_profesor_auxiliar.of_borra_todo()=1 and ids_grupos.deleterow(ids_grupos.getrow())= 1  THEN
		IF of_actualiza_sdu(al_cve_mat, ab_desc_sdu_se)= 1 THEN
			IF ids_horario.update()=1 THEN
				IF ids_profesor_auxiliar.update()=1 THEN
					IF ids_grupos.Update()=1 THEN
						COMMIT USING gtr_sce;
						messagebox("Información","El grupo se ha eliminado exitosamente",Information!)					
						RETURN 1
					ELSE
						GOTO ERROR
					END IF
				ELSE
					GOTO ERROR
				END IF
			ELSE
				GOTO ERROR
			END IF					
		ELSE
			GOTO ERROR
		END IF
	ELSE
		MessageBox("Información","No es posible eliminar los horarios y los profesores auxiliares",StopSign!)					
		RETURN -1
	END IF	
ELSE	
	MessageBox("Grupo no borrado","No es posible eliminar el grupo ["+string(al_cve_mat)+"-"+as_gpo+"]", StopSign!)
	RETURN -1		
END IF

RETURN 1

ERROR:
	ls_mensaje_sql= gtr_sce.SqlErrText
	ROLLBACK USING gtr_sce;						  
	MessageBox("Error al eliminar el horario", ls_mensaje_sql,StopSign!)
	RETURN -1


end function

on u_administrador_grupos.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_administrador_grupos.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//CREA LOS DATASTORE A UTILIZAR

ids_grupos = CREATE u_datastore
ids_horario = CREATE u_datastore
ids_profesor_auxiliar = CREATE u_datastore
ids_sdu = CREATE u_datastore

ids_grupos.dataobject = "d_uo_grupos"
ids_horario.dataobject = "d_uo_horario"
ids_profesor_auxiliar.dataobject = "d_uo_profesor_auxiliar"
ids_sdu.dataobject = "d_uo_salones_derecho_uso"

ids_grupos.SetTransObject(gtr_sce)
ids_horario.SetTransObject(gtr_sce)
ids_profesor_auxiliar.SetTransObject(gtr_sce)
ids_sdu.SetTransObject(gtr_sce)

ids_grupos_coord = CREATE u_datastore
ids_horario_coord = CREATE u_datastore
ids_profesor_auxiliar_coord = CREATE u_datastore
ids_sdu_coord = CREATE u_datastore

ids_grupos_coord.dataobject = "d_uo_grupos_coord_count_asim"
ids_horario_coord.dataobject = "d_uo_horario_coord"
ids_profesor_auxiliar_coord.dataobject = "d_uo_profesor_auxiliar_coord"
ids_sdu_coord.dataobject = "d_uo_salones_derecho_uso_coord"

ids_grupos_coord.SetTransObject(gtr_sce)
ids_horario_coord.SetTransObject(gtr_sce)
ids_profesor_auxiliar_coord.SetTransObject(gtr_sce)
ids_sdu_coord.SetTransObject(gtr_sce)


end event

event destructor;//ELIMINA LAS INSTANCIAS DE LOS DATASTORE UTILIZADOS

IF isvalid(ids_grupos) THEN
	DESTROY 	ids_grupos	
END IF
IF isvalid(ids_horario) THEN
	DESTROY 	ids_horario	
END IF
IF isvalid(ids_profesor_auxiliar) THEN
	DESTROY 	ids_profesor_auxiliar	
END IF
IF isvalid(ids_sdu) THEN
	DESTROY 	ids_sdu	
END IF

end event

