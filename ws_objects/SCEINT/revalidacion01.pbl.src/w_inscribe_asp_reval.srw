$PBExportHeader$w_inscribe_asp_reval.srw
forward
global type w_inscribe_asp_reval from window
end type
type cb_imprime_errores from commandbutton within w_inscribe_asp_reval
end type
type cb_revisa_seriacion from commandbutton within w_inscribe_asp_reval
end type
type cb_1 from commandbutton within w_inscribe_asp_reval
end type
type dw_universidad from datawindow within w_inscribe_asp_reval
end type
type cb_revision from commandbutton within w_inscribe_asp_reval
end type
type dw_equiv_mat_revalidacion from uo_dw_captura_base within w_inscribe_asp_reval
end type
type uo_1 from uo_nombre_aspirante_reval within w_inscribe_asp_reval
end type
type dw_errores_perten_prerreq from datawindow within w_inscribe_asp_reval
end type
end forward

global type w_inscribe_asp_reval from window
integer width = 3547
integer height = 2504
boolean titlebar = true
string title = "Inscripcion de Aspirantes por Revalidacion"
string menuname = "m_pliego_revalidacion"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
event inicia_proceso ( integer ai_numero,  long al_cuenta )
cb_imprime_errores cb_imprime_errores
cb_revisa_seriacion cb_revisa_seriacion
cb_1 cb_1
dw_universidad dw_universidad
cb_revision cb_revision
dw_equiv_mat_revalidacion dw_equiv_mat_revalidacion
uo_1 uo_1
dw_errores_perten_prerreq dw_errores_perten_prerreq
end type
global w_inscribe_asp_reval w_inscribe_asp_reval

type variables
long il_folio =0
boolean ib_seriacion_revisada = false
end variables

forward prototypes
public function integer wf_cuenta_materias (integer ai_renglon)
public function integer wf_revisa_prerrequisitos (long al_folio)
public function integer wf_revisa_pertenencia (long al_folio)
public function long wf_imprime_pliego (long al_folio, datetime adttm_fecha)
public function long wf_inserta_mats_erroneas (long al_folio)
public function long wf_califica_mats_erroneas (long al_folio)
public function integer wf_pertenencia_prerreq (long al_folio)
public function integer wf_revisa_seriacion (boolean ab_imprime_propuesta)
end prototypes

event inicia_proceso(integer ai_numero, long al_cuenta);long ll_rows, ll_cuenta
int li_cancelado, li_res_comite

ll_cuenta= Message.LongParm

ll_rows = dw_equiv_mat_revalidacion.retrieve(ll_cuenta)
li_cancelado= f_obten_cancelado(ll_cuenta)
//li_res_comite= f_obten_res_comite(ll_cuenta)
dw_universidad.retrieve(ll_cuenta)

if li_cancelado <>  0 then
	MessageBox("Aspirante con proceso cancelado", "No se permitirá la edición de la información",StopSign!)
end if

il_folio = ll_cuenta
ib_seriacion_revisada = false

//if li_res_comite <>  1 then
//	MessageBox("Aspirante no aceptado", "El aspirante no ha sido autorizado por el comité.~n" +&
//	           "No se permitirá la edición de la información.",StopSign!)
//end if
//or li_res_comite <>1

if li_cancelado <> 0  then
	dw_equiv_mat_revalidacion.Enabled = false
	m_pliego_revalidacion.m_registro.m_actualizar.enabled = false
else
	dw_equiv_mat_revalidacion.Enabled = true	
	m_pliego_revalidacion.m_registro.m_actualizar.enabled = true
end if


dw_errores_perten_prerreq.Reset()
return

end event

public function integer wf_cuenta_materias (integer ai_renglon);string ls_nombre_materia, ls_nombre_actual
long ll_renglon, ll_num_rows, ll_indice, ll_cuenta

ll_renglon = ai_renglon
ll_num_rows = dw_equiv_mat_revalidacion.RowCount()

ls_nombre_materia = dw_equiv_mat_revalidacion.GetItemString(ll_renglon, "nombre_materia")

ll_cuenta = 0

for ll_indice=1 to ll_num_rows
	ls_nombre_actual = dw_equiv_mat_revalidacion.GetItemString(ll_indice, "nombre_materia")

	if ls_nombre_materia =ls_nombre_actual then
		ll_cuenta= ll_cuenta + 1		
	end if
	
next

return ll_cuenta


end function

public function integer wf_revisa_prerrequisitos (long al_folio);long ll_num_rows, li_row_actual, ll_folio
long ll_cve_mat
integer li_cve_carrera, li_cve_plan, li_codigo_sql, li_curso_prerreq_reval
string ls_folio, ls_mensaje_sql



ll_folio = al_folio

SELECT dbo.aspirantes_revalidacion.cve_carrera,
		 dbo.aspirantes_revalidacion.cve_plan
INTO	:li_cve_carrera,
		:li_cve_plan
FROM  dbo.aspirantes_revalidacion
WHERE dbo.aspirantes_revalidacion.folio = :ll_folio
USING gtr_sce;

li_codigo_sql = gtr_sce.SqlCode
ls_mensaje_sql = gtr_sce.SqlErrtext

if li_codigo_sql= -1 then
	MessageBox("Error en la lectura de aspirantes_revalidacion: "+ls_folio, ls_mensaje_sql, StopSign!)
	return 0
elseif li_codigo_sql= 100 then
	MessageBox("Error grave de eliminacion de folio en aspirantes_revalidacion: "+ls_folio, ls_mensaje_sql, StopSign!)
	return	0
end if	

ll_num_rows = dw_equiv_mat_revalidacion.RowCount()

for li_row_actual= 1 to ll_num_rows
	ll_cve_mat = dw_equiv_mat_revalidacion.GetItemNumber(li_row_actual,"cve_mat")
	li_curso_prerreq_reval= f_curso_prerreq_reval(ll_folio, ll_cve_mat, li_cve_carrera, li_cve_plan)
	if li_curso_prerreq_reval = 0 then
		MessageBox("Materia sin prerrequisitos: ", string(ll_cve_mat), StopSign!)		
	elseif li_curso_prerreq_reval = -1 then
		MessageBox("Error en la lectura de los prerrequisitos: ", string(ll_cve_mat), StopSign!)				
	end if
next


return 0

end function

public function integer wf_revisa_pertenencia (long al_folio);long ll_num_rows, li_row_actual, ll_folio
long ll_cve_mat
integer li_cve_carrera, li_cve_plan, li_codigo_sql, li_curso_prerreq_reval
string ls_folio, ls_mensaje_sql



ll_folio = al_folio

SELECT dbo.aspirantes_revalidacion.cve_carrera,
		 dbo.aspirantes_revalidacion.cve_plan
INTO	:li_cve_carrera,
		:li_cve_plan
FROM  dbo.aspirantes_revalidacion
WHERE dbo.aspirantes_revalidacion.folio = :ll_folio
USING gtr_sce;

li_codigo_sql = gtr_sce.SqlCode
ls_mensaje_sql = gtr_sce.SqlErrtext

if li_codigo_sql= -1 then
	MessageBox("Error en la lectura de aspirantes_revalidacion: "+ls_folio, ls_mensaje_sql, StopSign!)
	return 0
elseif li_codigo_sql= 100 then
	MessageBox("Error grave de eliminacion de folio en aspirantes_revalidacion: "+ls_folio, ls_mensaje_sql, StopSign!)
	return	0
end if	

ll_num_rows = dw_equiv_mat_revalidacion.RowCount()

for li_row_actual= 1 to ll_num_rows
	ll_cve_mat = dw_equiv_mat_revalidacion.GetItemNumber(li_row_actual,"cve_mat")
	li_curso_prerreq_reval= f_escursativa(ll_cve_mat, li_cve_carrera, li_cve_plan)
	if li_curso_prerreq_reval = 0 then
		MessageBox("Materia sin pertenencia: "+string(ll_cve_mat),&
		 "La materia no pertenece al plan de estudios", StopSign!)		
//	elseif li_curso_prerreq_reval = -1 then
//		MessageBox("Error en la lectura de los prerrequisitos: ", string(ll_cve_mat), StopSign!)				
	end if
next


return 0

end function

public function long wf_imprime_pliego (long al_folio, datetime adttm_fecha);//Argumentos:
//long 		al_folio
//datetime 	adttm_fecha
//
//Regresa:
//long		num_de_registros leidos


long ll_rows
DataStore lds_sol_equivalencias
lds_sol_equivalencias = Create DataStore
lds_sol_equivalencias.DataObject = "d_solicitud_equivalencias"
lds_sol_equivalencias.SetTransObject(gtr_sce)

ll_rows = lds_sol_equivalencias.Retrieve(al_folio, adttm_fecha)

if ll_rows = -1 then
	MessageBox("Error de Datawindow","No se puede leer: d_solicitud_equivalencias",StopSign!)
elseif ll_rows >0 then
	lds_sol_equivalencias.Print()
else
	MessageBox("No existen registros","Datawindow: d_solicitud_equivalencias~n"+&
	           "no tiene registros para imprimir",StopSign!)
end if

return ll_rows		



end function

public function long wf_inserta_mats_erroneas (long al_folio);//wf_inserta_mats_erroneas
long ll_num_rows, ll_row_actual, ll_num_inserts
integer li_codigo
string ls_mensaje_error
integer li_mat_sin_equiv
long ll_cve_materia

ll_num_rows = dw_errores_perten_prerreq.RowCount()
ll_num_inserts= 0
DELETE dbo.mats_inconsist_reval
WHERE dbo.mats_inconsist_reval.folio = :al_folio
USING gtr_sce;

li_codigo= gtr_sce.SqlCode
ls_mensaje_error= gtr_sce.SqlErrText

if li_codigo = -1  then
	ROLLBACK USING gtr_sce;
	MessageBox("Error al borrar mats_inconsist_reval en el folio actual :"+string(al_folio),ls_mensaje_error, StopSign!)
	return -1
else 
	COMMIT USING gtr_sce;
end if

for ll_row_actual = 1 to ll_num_rows
	li_mat_sin_equiv = dw_errores_perten_prerreq.GetItemNumber(ll_row_actual,"mat_sin_equiv")
	ll_cve_materia = dw_errores_perten_prerreq.GetItemNumber(ll_row_actual,"cve_materia")
	if isnull(ll_cve_materia) then
		ll_cve_materia = 0
	end if
	if li_mat_sin_equiv = 1 then
		INSERT INTO dbo.mats_inconsist_reval
		(folio, cve_mat)
		VALUES
		(:al_folio, :ll_cve_materia)
		USING gtr_sce;
		
		li_codigo= gtr_sce.SqlCode
		ls_mensaje_error= gtr_sce.SqlErrText
		if li_codigo = -1  then
			ROLLBACK USING gtr_sce;
			MessageBox("Error al insertar mats_inconsist_reval en el folio actual :"+string(al_folio),ls_mensaje_error, StopSign!)
			return -1
		else
			COMMIT USING gtr_sce;
			ll_num_inserts= ll_num_inserts+1
		end if
		
	end if
next

return ll_num_inserts

end function

public function long wf_califica_mats_erroneas (long al_folio);long ll_num_rows, ll_row_actual, ll_num_inserts
integer li_codigo
string ls_mensaje_error
integer li_mat_sin_equiv, li_cumple_prerreq, li_pertenece_plan, li_status
long ll_cve_materia

ll_num_rows = dw_errores_perten_prerreq.RowCount()
ll_num_inserts= 0

for ll_row_actual = 1 to ll_num_rows
	ll_cve_materia = dw_errores_perten_prerreq.GetItemNumber(ll_row_actual,"cve_materia")
	li_mat_sin_equiv = dw_errores_perten_prerreq.GetItemNumber(ll_row_actual,"mat_sin_equiv")
	li_cumple_prerreq = dw_errores_perten_prerreq.GetItemNumber(ll_row_actual,"cumple_prerreq")
	li_pertenece_plan = dw_errores_perten_prerreq.GetItemNumber(ll_row_actual,"pertenece_plan")
	if isnull(ll_cve_materia) then
		ll_cve_materia = 0
	end if
	if isnull(li_mat_sin_equiv) then
		li_mat_sin_equiv = 0
	end if
	if isnull(li_cumple_prerreq) then
		li_cumple_prerreq = 0
	end if
	if isnull(li_pertenece_plan) then
		li_pertenece_plan = 0
	end if
	
	if li_mat_sin_equiv =0 or li_cumple_prerreq =0 or li_pertenece_plan =0 then
		li_status =1
	else
		li_status =0		
	end if
	
	UPDATE dbo.materias_revalidacion
	SET dbo.materias_revalidacion.status = :li_status
	WHERE dbo.materias_revalidacion.cve_mat = :ll_cve_materia
	AND   dbo.materias_revalidacion.folio = :al_folio
	USING gtr_sce;
		
	li_codigo= gtr_sce.SqlCode
	ls_mensaje_error= gtr_sce.SqlErrText
	if li_codigo = -1  then
		ROLLBACK USING gtr_sce;
		MessageBox("Error al actualizar materias_revalidacion en el folio actual :"+string(al_folio),ls_mensaje_error, StopSign!)
		return -1
	else
		COMMIT USING gtr_sce;
		ll_num_inserts= ll_num_inserts+1
	end if
		
next

return ll_num_inserts

end function

public function integer wf_pertenencia_prerreq (long al_folio);//wf_revisa_pertenencia
long ll_num_rows, li_row_actual, ll_folio, ll_num_prerreq, ll_actual_prerreq
long ll_cve_mat
integer li_cve_carrera, li_cve_plan, li_codigo_sql, li_curso_prerreq_reval, li_pertenece_plan
string ls_folio, ls_mensaje_sql
long array_cve_prerreq[]
integer array_pertenece[], li_tamanio_array, li_cve_prerreq, li_orden, li_null
string array_enlace[], ls_orden, ls_materia, ls_enlace, ls_null, ls_nombre_materia
long ll_new_error, ll_null
integer li_tamanio_prerreq, li_tamanio_perten, li_tamanio,  li_indice_arrays
long ll_comodin
string array_nom_mat[]
integer li_mat_sin_equiv, li_cumple_prerreq, li_curso_prerreq_rec
string ls_apaterno, ls_amaterno, ls_nombre, ls_nombre_completo

setnull(li_null)
setnull(ls_null)
setnull(ll_null)

li_indice_arrays= 1

ll_folio = al_folio

SELECT dbo.aspirantes_revalidacion.cve_carrera,
		 dbo.aspirantes_revalidacion.cve_plan,
		 dbo.aspirantes_revalidacion.apaterno,
		 dbo.aspirantes_revalidacion.amaterno,
		 dbo.aspirantes_revalidacion.nombre
INTO	:li_cve_carrera,
		:li_cve_plan, 
		:ls_apaterno,
		:ls_amaterno,
		:ls_nombre		
FROM  dbo.aspirantes_revalidacion
WHERE dbo.aspirantes_revalidacion.folio = :ll_folio
USING gtr_sce;

li_codigo_sql = gtr_sce.SqlCode
ls_mensaje_sql = gtr_sce.SqlErrtext

if li_codigo_sql= -1 then
	MessageBox("Error en la lectura de aspirantes_revalidacion: "+ls_folio, ls_mensaje_sql, StopSign!)
	return 0
elseif li_codigo_sql= 100 then
	MessageBox("Error grave de eliminacion de folio en aspirantes_revalidacion: "+ls_folio, ls_mensaje_sql, StopSign!)
	return	0
end if	

ls_nombre_completo = ls_apaterno + " "+ls_amaterno+" "+ls_nombre

ll_num_rows = dw_equiv_mat_revalidacion.RowCount()
ll_comodin= 9999
for li_row_actual= 1 to ll_num_rows
	ll_cve_mat = dw_equiv_mat_revalidacion.GetItemNumber(li_row_actual,"cve_mat")
	ls_nombre_materia = dw_equiv_mat_revalidacion.GetItemString(li_row_actual,"nombre_materia")
	
	if isnull(ll_cve_mat) then
		ll_cve_mat= ll_comodin
	end if
	
	li_pertenece_plan= f_escursativa(ll_cve_mat, li_cve_carrera, li_cve_plan)
	li_curso_prerreq_reval= f_curso_prerreq_reval_sep(ll_folio, ll_cve_mat, li_cve_carrera, li_cve_plan)

	if (li_curso_prerreq_reval=1 and upperbound(gl_mats_prerreq[])<> 0)  then
		li_curso_prerreq_rec= f_curso_prerreq_recursiv_sep(ll_folio, ll_cve_mat, li_cve_carrera, li_cve_plan,gl_mats_prerreq[])
		li_curso_prerreq_reval = li_curso_prerreq_rec
		ls_nombre_materia= "SUBNIVEL DE: "+ls_nombre_materia
	end if


	if li_curso_prerreq_reval = 0 or li_pertenece_plan = 0 then
		array_cve_prerreq[li_indice_arrays]= ll_cve_mat
		array_nom_mat[li_indice_arrays]= ls_nombre_materia
		array_pertenece[li_indice_arrays]= li_pertenece_plan	
		li_indice_arrays= li_indice_arrays+1
		dw_equiv_mat_revalidacion.SetItem(li_row_actual,"procede", 0)		
	elseif li_curso_prerreq_reval = -1 then
		if not isnull(ll_cve_mat) then
			MessageBox("Error en la lectura de los prerrequisitos: ", string(ll_cve_mat), StopSign!)				
		else
			MessageBox("Error en la lectura de los prerrequisitos: ", "materia nula", StopSign!)							
		end if
	elseif  li_pertenece_plan = -1 then
		if not isnull(ll_cve_mat) then
			MessageBox("Error en la pertenecia al plan: ", string(ll_cve_mat), StopSign!)				
		else
			MessageBox("Error en la pertenecia al plan ", "materia nula", StopSign!)							
		end if
	end if
	
next

DataStore lds_prerrequisito
lds_prerrequisito = Create DataStore
lds_prerrequisito.DataObject = "dw_prerrequisitos"
lds_prerrequisito.SetTransObject(gtr_sce)

li_tamanio_prerreq= upperbound(array_cve_prerreq)
li_tamanio_perten= upperbound(array_pertenece)
//if li_tamanio_prerreq > li_tamanio_perten
li_tamanio= li_tamanio_perten
for li_row_actual = 1 to li_tamanio
	ll_cve_mat = array_cve_prerreq[li_row_actual]
	ls_nombre_materia = array_nom_mat[li_row_actual]
	ll_num_prerreq = lds_prerrequisito.Retrieve(ll_cve_mat, li_cve_carrera, li_cve_plan)
	li_pertenece_plan = array_pertenece[li_row_actual]
	li_cumple_prerreq= 1
	li_mat_sin_equiv= 1
   for ll_actual_prerreq= 1 to ll_num_prerreq
		li_cumple_prerreq= 0
//Obtiene los datos de los prerrequisitos faltantes
		li_cve_prerreq = 	lds_prerrequisito.GetItemNumber(	ll_actual_prerreq, "cve_prerreq")
		li_orden = 	lds_prerrequisito.GetItemNumber(ll_actual_prerreq, "orden")
		ls_enlace = lds_prerrequisito.GetItemString(ll_actual_prerreq, "enlace")
		ls_materia = lds_prerrequisito.GetItemString(ll_actual_prerreq, "materias_materia")
		ll_new_error = dw_errores_perten_prerreq.InsertRow(0)
//Inserta en la tabla de errores los datos de los prerrequisitos faltantes
		dw_errores_perten_prerreq.ScrollToRow(ll_new_error)	
		dw_errores_perten_prerreq.SetItem(ll_new_error, "cve_materia", ll_cve_mat)	
		dw_errores_perten_prerreq.SetItem(ll_new_error, "cve_prerrequisito", li_cve_prerreq)	
//		if (trim(ls_enlace) <> "Y" and trim(ls_enlace) <> "O") or &
//		   (trim(ls_enlace) = ls_null or trim(ls_enlace) = "" or isnull(ls_enlace)) then
//			ls_enlace = "Z"
//
//		end if
		dw_errores_perten_prerreq.SetItem(ll_new_error, "enlace", ls_enlace)	
		dw_errores_perten_prerreq.SetItem(ll_new_error, "orden", li_orden)			
		dw_errores_perten_prerreq.SetItem(ll_new_error, "pertenece_plan", li_pertenece_plan)			
		dw_errores_perten_prerreq.SetItem(ll_new_error, "cumple_prerreq", li_cumple_prerreq)			
		dw_errores_perten_prerreq.SetItem(ll_new_error, "mat_sin_equiv", li_mat_sin_equiv)	
		dw_errores_perten_prerreq.SetItem(ll_new_error, "nombre_aspirante", ls_nombre_completo)	
		dw_errores_perten_prerreq.SetItem(ll_new_error, "folio", ll_folio)	
	next
	if	ll_num_prerreq = 0 and li_pertenece_plan = 0 then
		ll_new_error = dw_errores_perten_prerreq.InsertRow(0)
		dw_errores_perten_prerreq.ScrollToRow(ll_new_error)	
		dw_errores_perten_prerreq.SetItem(ll_new_error, "cve_materia", ll_cve_mat)	
		dw_errores_perten_prerreq.SetItem(ll_new_error, "cve_prerrequisito", li_null)	
		dw_errores_perten_prerreq.SetItem(ll_new_error, "enlace", ls_null)	
		dw_errores_perten_prerreq.SetItem(ll_new_error, "orden", li_null)					
		dw_errores_perten_prerreq.SetItem(ll_new_error, "pertenece_plan", li_pertenece_plan)			
		dw_errores_perten_prerreq.SetItem(ll_new_error, "nombre_materia", ls_null)			
		dw_errores_perten_prerreq.SetItem(ll_new_error, "nombre_aspirante", ls_nombre_completo)	
		dw_errores_perten_prerreq.SetItem(ll_new_error, "folio", ll_folio)	

		if ll_cve_mat = 9999 then
			li_mat_sin_equiv = 0
			li_cumple_prerreq = 0
			dw_errores_perten_prerreq.SetItem(ll_new_error, "nombre_materia", ls_nombre_materia)			
			dw_errores_perten_prerreq.SetItem(ll_new_error, "cve_materia", li_null)	
			dw_errores_perten_prerreq.SetItem(ll_new_error, "cumple_prerreq", li_cumple_prerreq )	
			dw_errores_perten_prerreq.SetItem(ll_new_error, "mat_sin_equiv", li_mat_sin_equiv)			
		else
			dw_errores_perten_prerreq.SetItem(ll_new_error, "cve_materia", ll_cve_mat)	
			dw_errores_perten_prerreq.SetItem(ll_new_error, "nombre_materia", ls_null )	
			dw_errores_perten_prerreq.SetItem(ll_new_error, "cumple_prerreq", li_cumple_prerreq )	
			dw_errores_perten_prerreq.SetItem(ll_new_error, "mat_sin_equiv", li_mat_sin_equiv)			
			
			if ll_cve_mat = 0 then
				dw_errores_perten_prerreq.SetItem(ll_new_error, "nombre_materia", "HERE" )			
			end if
		end if
	end if

next

return 0

end function

public function integer wf_revisa_seriacion (boolean ab_imprime_propuesta);//wf_revisa_seriacion
//Recibe boolean 	ab_imprime_propuesta

string ls_folio
integer li_curso_prerreq_reval, li_prerrequisitos, li_pertenecia, li_pertenecia_prerreq
long ll_folio, ll_num_errores, ll_res_impresion, ll_mats_erroneas
datetime lddtm_fecha
integer li_res_comite, li_cancelado, li_limpia_status_materias, li_coordinacion
long ll_suma_creditos, ll_creditos_plan, ll_creditos_plan_perm
decimal ld_porcent_creditos, ld_creditos_plan_perm
long ll_cve_carrera, ll_cve_plan, ll_row_universidad, ll_row_coord

lddtm_fecha = fecha_servidor(gtr_sce)

if dw_equiv_mat_revalidacion.ModifiedCount()+dw_equiv_mat_revalidacion.DeletedCount() > 0 Then
	MessageBox("Favor de almacenar los cambios",&
				"Es necesario grabar las materias, ~n"+ &
				 "antes de realizar la validaciones ~n de prerrequisitos y pertenecia",StopSign!)
	return -1
end if

ll_folio = il_folio

if ll_folio = 0 then 
	MessageBox("Sin aspirante",&
				"Favor de escribir un aspirante valido.",StopSign!)
	return 	-1
end if

//PARA LA PROPUESTA NO ES NECESARIO REVISAR SI EL ASPIRANTE HA SIDO AUTORIZADO POR EL COMITÉ


li_cancelado = f_obten_cancelado(ll_folio)

if li_cancelado <>0 then
	MessageBox("Aspirante con proceso cancelado",&
				"Se ha cancelado el proceso del aspirante, ~n"+ &
				 "no es posible efectuar validaciones adicionales.",StopSign!)
	return -1
end if


dw_errores_perten_prerreq.Reset()

li_limpia_status_materias= f_limpia_status_materias(ll_folio)


li_pertenecia_prerreq= wf_pertenencia_prerreq(ll_folio)

dw_errores_perten_prerreq.Sort()

ll_num_errores = dw_errores_perten_prerreq.RowCount()

if ll_num_errores >0 then
	MessageBox("Errores de pertenencia/prerrequisitos",&
				"Existen errores en la seriación o pertenencia a los planes ~n"+&
				 "en las materias registradas.",StopSign!)
//	dw_errores_perten_prerreq.Object.DataWindow.Zoom = 100
//	dw_errores_perten_prerreq.Print()
//	dw_errores_perten_prerreq.Object.DataWindow.Zoom = 75
end if
ll_mats_erroneas= wf_califica_mats_erroneas(ll_folio)

//ll_row_universidad = dw_universidad.GetRow()
//ll_cve_carrera = dw_universidad.GetItemNumber(ll_row_universidad, "aspirantes_revalidacion_cve_carrera")
//ll_cve_plan =dw_universidad.GetItemNumber(ll_row_universidad, "aspirantes_revalidacion_cve_plan")
//
//ll_suma_creditos = f_obten_suma_creditos(ll_folio)
//ll_creditos_plan = f_obten_creditos_plan(ll_cve_carrera, ll_cve_plan)
//
//if ll_creditos_plan >0 then
//	ld_porcent_creditos =ll_suma_creditos / ll_creditos_plan
//else
//	ld_porcent_creditos= 0
//end if
//
//ld_creditos_plan_perm = ll_creditos_plan * 0.40
//
//ll_creditos_plan_perm = ld_creditos_plan_perm
//
//if ld_porcent_creditos > 0.40 then
//	MessageBox("Exceso de créditos",&
//				"Se ha superado el número de créditos posibles a revalidar, ~n"+ &
//				 "no es posible continuar con el proceso. ~n"+ &
//				 "Creditos Revalidados : "+string(ll_suma_creditos)+"~n"+ &
// 				 "Creditos Permitidos : "+string(ll_creditos_plan_perm)+"~n",StopSign!)
//	return -1
//end if
//

if ab_imprime_propuesta then
	ll_res_impresion= f_imprime_propuesta_reval(ll_folio, lddtm_fecha, li_coordinacion)
	MessageBox("Propuesta de revalidación generada",&
				"Correspondiente a ~n"+ &
				string(ll_res_impresion)+ " materias",Information!)
end if

return 0

end function

on w_inscribe_asp_reval.create
if this.MenuName = "m_pliego_revalidacion" then this.MenuID = create m_pliego_revalidacion
this.cb_imprime_errores=create cb_imprime_errores
this.cb_revisa_seriacion=create cb_revisa_seriacion
this.cb_1=create cb_1
this.dw_universidad=create dw_universidad
this.cb_revision=create cb_revision
this.dw_equiv_mat_revalidacion=create dw_equiv_mat_revalidacion
this.uo_1=create uo_1
this.dw_errores_perten_prerreq=create dw_errores_perten_prerreq
this.Control[]={this.cb_imprime_errores,&
this.cb_revisa_seriacion,&
this.cb_1,&
this.dw_universidad,&
this.cb_revision,&
this.dw_equiv_mat_revalidacion,&
this.uo_1,&
this.dw_errores_perten_prerreq}
end on

on w_inscribe_asp_reval.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_imprime_errores)
destroy(this.cb_revisa_seriacion)
destroy(this.cb_1)
destroy(this.dw_universidad)
destroy(this.cb_revision)
destroy(this.dw_equiv_mat_revalidacion)
destroy(this.uo_1)
destroy(this.dw_errores_perten_prerreq)
end on

event open;x=1
y=1
m_pliego_revalidacion.m_registro.m_cargaregistro.enabled = false
m_pliego_revalidacion.m_registro.m_nuevo.enabled =false
m_pliego_revalidacion.m_registro.m_borraregistro.enabled = false

end event

type cb_imprime_errores from commandbutton within w_inscribe_asp_reval
integer x = 2999
integer y = 1380
integer width = 411
integer height = 108
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprime Errores"
end type

event clicked;long ll_num_errores
integer li_respuesta


li_respuesta = MessageBox("Confirmación", "¿Desea imprimir los errores?",Question!,YesNo!)

if li_respuesta <>1 then
	return
else
	ll_num_errores = dw_errores_perten_prerreq.RowCount()
	if ll_num_errores > 0 then
		dw_errores_perten_prerreq.Object.DataWindow.Zoom = 100
		dw_errores_perten_prerreq.Print()
		dw_errores_perten_prerreq.Object.DataWindow.Zoom = 75
	end if
end if
end event

type cb_revisa_seriacion from commandbutton within w_inscribe_asp_reval
integer x = 1362
integer y = 2032
integer width = 567
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Revisa Seriación"
end type

event clicked;int li_res, li_res_comite, li_aceptado_comite= 1

 li_res = MessageBox("Confirmación", "Desea revisar la seriación de las materias",Question!, YesNo!)
if li_res = 1 then 
	wf_revisa_seriacion(false)
   ib_seriacion_revisada= true
end if
end event

type cb_1 from commandbutton within w_inscribe_asp_reval
integer x = 439
integer y = 2032
integer width = 567
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar por Comité"
end type

event clicked;int li_res, li_res_comite, li_aceptado_comite= 1

 li_res = MessageBox("Confirmación", "Desea Aceptar por el comité",Question!, YesNo!)
if li_res = 1 then 
	li_res_comite = f_set_res_comite(il_folio,li_aceptado_comite)
	if li_res_comite= 0 then
		MessageBox("Exito", "Aceptación exitosa",Information!)
	else
		MessageBox("Error", "No se ha podido aceptar por el comité",StopSign!)	
	end if
end if
end event

type dw_universidad from datawindow within w_inscribe_asp_reval
integer x = 398
integer y = 364
integer width = 2501
integer height = 264
integer taborder = 20
string dataobject = "d_datos_universidad"
boolean border = false
boolean livescroll = true
end type

event constructor;this.SetTransObject(gtr_sce)
this.object.datawindow.zoom = 85


datawindowchild ldw_carreras
LONG ll_num_carreras

THIS.GETCHILD("aspirantes_revalidacion_cve_carrera", ldw_carreras)
ldw_carreras.SETTRANSOBJECT(gtr_sce) 
ll_num_carreras = ldw_carreras.RETRIEVE(gs_tipo_periodo) 
IF ll_num_carreras = 0 THEN 
	MESSAGEBOX("Aviso", "No se encontraron carreras de tipo " + gs_descripcion_tipo_periodo)
END IF






end event

type cb_revision from commandbutton within w_inscribe_asp_reval
integer x = 2286
integer y = 2032
integer width = 567
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inscribe Aspirante"
end type

event clicked;string ls_folio, ls_filtro_procede
integer li_curso_prerreq_reval, li_prerrequisitos, li_pertenecia, li_pertenecia_prerreq
long ll_folio, ll_num_errores, ll_res_impresion, ll_mats_erroneas, ll_cuenta
datetime lddtm_fecha
integer li_res_comite, li_cancelado, li_confirmacion, li_periodo_ing, li_anio_ing
string null_str
long ll_inserciones_hist, ll_cuenta_asignada, ll_existe_cuenta
integer li_res_ins_alumno, li_res_asigna_cuenta, li_res_asigna_status, li_status, li_res_solo_mats
integer li_limpia_status_materias
SetNull(null_str)
null_str=""
dw_equiv_mat_revalidacion.SetFilter(null_str)
dw_equiv_mat_revalidacion.Filter()

if not ib_seriacion_revisada then
	MessageBox("Revisión Pendiente","No se ha revisado la seriación, favor de revisarla antes de inscribir",StopSign!)
	return
end if


li_confirmacion =	MessageBox("Confirmación de Inscripcion del Aspirante",&
				"El siguiente proceso insertará al Aspirante por Revalidacion, ~n"+ &
				"como alumno, e inscribirá sus materias en histórico.~n"+&
				"¿Está seguro que desea continuar?",Question!, YesNo!)

if li_confirmacion <> 1 then
	return	
end if

lddtm_fecha = fecha_servidor(gtr_sce)

if dw_equiv_mat_revalidacion.ModifiedCount()+dw_equiv_mat_revalidacion.DeletedCount() > 0 Then
	MessageBox("Favor de almacenar los cambios",&
				"Es necesario grabar los cambios a las materias, ~n"+ &
				 "antes de realizar inscripcion del Aspirante",StopSign!)
	return 
end if

ls_folio= uo_1.em_cuenta.text
if not isnumber(ls_folio) then
	return
end if

ll_folio = long(ls_folio)

li_res_comite = f_obten_res_comite(ll_folio)

if li_res_comite <>1 then
	MessageBox("Aspirante no autorizado",&
				"El aspirante no ha sido autorizado aún, ~n"+ &
				 "o el comité rechazó su solicitud.",StopSign!)
	return 	
end if

li_cancelado = f_obten_cancelado(ll_folio)

if li_cancelado <>0 then
	MessageBox("Aspirante con proceso cancelado",&
				"Se ha cancelado el proceso del aspirante, ~n"+ &
				 "no es posible efectuar validaciones adicionales.",StopSign!)
	return 	
end if

ll_cuenta = f_obten_cuenta(ll_folio)

ll_existe_cuenta = f_existe_cuenta(ll_cuenta)

li_status = f_obten_status(ll_folio)

li_res_solo_mats= 0

if (ll_existe_cuenta = ll_cuenta) and ll_cuenta<>0 then
	li_res_solo_mats =	MessageBox("Aspirante previamente transferido",&
				"El aspirante ya existe como alumno, ~n"+ &
				 "¿Desea limitarse a la inscipción de materias?",Question!, YesNo!)
	if li_res_solo_mats <>1 then
		return 	
	end if
end if


dw_errores_perten_prerreq.Reset()

li_limpia_status_materias= f_limpia_status_materias(ll_folio)

ls_filtro_procede = "procede = 1"

dw_equiv_mat_revalidacion.SetFilter(ls_filtro_procede)
dw_equiv_mat_revalidacion.Filter()

li_pertenecia_prerreq= wf_pertenencia_prerreq(ll_folio)
	
dw_errores_perten_prerreq.Sort()

ll_num_errores = dw_errores_perten_prerreq.RowCount()

if ll_num_errores >0 then
	MessageBox("Errores de pertenencia/prerrequisitos",&
				"Existe(n)"+string(ll_num_errores)+ "error(es) en la seriación o pertenencia a los planes ~n"+&
				 "en las materias registradas.~n"+&
				 "Presione Aceptar para imprimir el reporte de errores",StopSign!)
	dw_errores_perten_prerreq.Print()
end if

ll_mats_erroneas= wf_califica_mats_erroneas(ll_folio)

SetNull(null_str)
null_str=""
dw_equiv_mat_revalidacion.SetFilter(null_str)
dw_equiv_mat_revalidacion.Filter()


if ll_existe_cuenta =0 and li_res_solo_mats=0 then
		
	ll_cuenta_asignada= f_obten_cuenta_disponible()
	if ll_cuenta_asignada <= 0 then
		MessageBox("No existen Cuentas Disponibles", "Favor de solicitar la creación de cuentas disponibles.", StopSign!)
		return	
	else
		ll_cuenta = ll_cuenta_asignada
	end if

	li_periodo_ing= f_obten_periodo_ing(ll_folio)
	li_anio_ing= f_obten_anio_ing(ll_folio)
	li_res_asigna_cuenta= f_asigna_cuenta_folio_reval(ll_folio, ll_cuenta)
	if li_res_asigna_cuenta < 0 then
		MessageBox("Error de asignacion de cuenta", "No se le pudo asignar la cuenta al aspirante.", StopSign!)
		return	
	end if	
	li_res_asigna_status= f_asigna_status_folio_reval(ll_folio, 1)
	if li_res_asigna_cuenta < 0 then
		MessageBox("Error de asignacion de status", "No se le pudo asignar el status al aspirante.", StopSign!)
		return	
	end if		
	gtr_sce.Autocommit = true
	li_res_ins_alumno= f_inserta_asp_reval(ll_cuenta, li_periodo_ing, li_anio_ing)
	if li_res_ins_alumno <> 0 then
		MessageBox("Error de insercion de alumno", "No se pudo insertar exitosamente al aspirante.", StopSign!)
		return	
	end if	
	gtr_sce.Autocommit = false

end if

//SoloMaterias:

ll_inserciones_hist= f_inserta_mats_revalid(ll_cuenta)
MessageBox("Inserción de Materias terminada", "Inserción en historico de "+string(ll_inserciones_hist)+" materias.")


MessageBox("Aspirante insertado como Alumno", "Se ha insertado exitosamente al aspirante con cuenta["+string(ll_cuenta)+"-"+string(obten_digito(ll_cuenta))+"].", Information!)

return





end event

type dw_equiv_mat_revalidacion from uo_dw_captura_base within w_inscribe_asp_reval
event ue_duplicar_materia ( )
integer x = 315
integer y = 636
integer width = 2661
integer height = 568
integer taborder = 30
string dataobject = "d_mat_reval_sep"
boolean hscrollbar = true
end type

event ue_asigna_dw_menu;/*
DESCRIPCIÓN: Evento en el cual se asigna a la variable dw del menu este objeto.
				En este evento se busca la ventana dueña del objeto y cual es su menu
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: CAMP(DkWf)
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/

window ventana_propietaria

ventana_propietaria = this.GetParent()

menu_propietario = ventana_propietaria.menuid

menu_propietario.dw	= this

end event

event ue_inicia_transaction_object;call super::ue_inicia_transaction_object;//
//DESCRIPCIÓN: Evento en el que se asigna al tr_dw_propio el objeto de transacción que se va a utilizar en el dw.
//					 El codigo de este evento se agrega desde el control en la ventana
//PARÁMETROS: Ninguno
//REGRESA: Nada
//AUTOR: CAMP(DkWf)
//FECHA: 17 Junio 1998
//MODIFICACIÓN:
//

tr_dw_propio = gtr_sce
this.SetTransObject(tr_dw_propio)


end event

event ue_carga;//DESCRIPCIÓN: Antes de cargar algo, ve si hay modificaciones no guardadas.
//PARÁMETROS: Ninguno
//REGRESA: Nada
//AUTOR: Víctor Manuel Iniestra Álvarez
//FECHA: 15 Junio 1998
//MODIFICACIÓN:
//
long ll_folio
string ls_folio

ls_folio = uo_1.em_cuenta.text
if not isnumber(ls_folio) then
	MessageBox("Folio Inválido", "Favor de escribir un aspirante válido",StopSign!)
	return 0
else
	ll_folio =long(ls_folio)
end if

if event ue_actualizacion()=1 then
	event ue_primero()
	return retrieve(ll_folio)
end if
return 0
end event

event rbuttondown;long ll_renglon
m_pliego_rbuttondown NewMenu

NewMenu = CREATE m_pliego_rbuttondown

NewMenu.idw_materias = this

NewMenu.PopMenu(w_inscribe_asp_reval.PointerX(), w_inscribe_asp_reval.PointerY())

//this.SelectRow(ll_renglon, true)

//NewMenu.m_duplicarmateria.PopMenu(w_pliego_revalidacion.PointerX(), w_pliego_revalidacion.PointerY())

end event

event retrieverow;call super::retrieverow;integer li_procede

li_procede = this.GetItemNumber(row, "procede")
if isnull(li_procede) then
	this.SetItem(row,"procede", 1)
end if
end event

event constructor;call super::constructor;
datawindowchild ldw_coordinaciones
LONG ll_num_coordinaciones

THIS.GETCHILD("cve_coordinacion", ldw_coordinaciones)
ldw_coordinaciones.SETTRANSOBJECT(gtr_sce) 
ll_num_coordinaciones = ldw_coordinaciones.RETRIEVE(gs_tipo_periodo) 
IF ll_num_coordinaciones = 0 THEN 
	MESSAGEBOX("Aviso", "No se encontraron carreras de tipo " + gs_descripcion_tipo_periodo)
END IF




end event

type uo_1 from uo_nombre_aspirante_reval within w_inscribe_asp_reval
integer x = 27
integer y = 20
integer taborder = 10
boolean enabled = true
end type

on uo_1.destroy
call uo_nombre_aspirante_reval::destroy
end on

type dw_errores_perten_prerreq from datawindow within w_inscribe_asp_reval
integer x = 315
integer y = 1232
integer width = 2661
integer height = 772
integer taborder = 40
string dataobject = "d_errores_perten_prerreq"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.SetTransObject(gtr_sce)
end event

