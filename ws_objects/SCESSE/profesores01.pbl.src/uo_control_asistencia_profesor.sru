$PBExportHeader$uo_control_asistencia_profesor.sru
forward
global type uo_control_asistencia_profesor from nonvisualobject
end type
end forward

global type uo_control_asistencia_profesor from nonvisualobject
end type
global uo_control_asistencia_profesor uo_control_asistencia_profesor

type variables
uds_datastore ids_datastore, ids_datastore_multiple,  ids_datastore_grupos_periodo
end variables

forward prototypes
public function integer of_cuenta_asistencias (integer ai_periodo, integer ai_anio, long al_cve_mat, string as_gpo, integer ai_cve_asistencia[])
public function integer of_asistencia_grupo (integer ai_periodo, integer ai_anio, long al_cve_mat, string as_gpo, ref integer aio_clases_totales, ref integer aio_asistencias, ref integer aio_faltas, ref decimal ado_porcentaje_asistencia)
public function integer of_actual_asistencia_periodo (integer ai_periodo, integer ai_anio)
public function integer of_asistencia_grupo_multiple (integer ai_periodo, integer ai_anio, long al_cve_mat, string as_gpo, ref integer aio_clases_totales, ref integer aio_asistencias, ref integer aio_faltas, ref decimal ado_porcentaje_asistencia)
public function integer of_elimina_asistencia_periodo (integer ai_periodo, integer ai_anio)
end prototypes

public function integer of_cuenta_asistencias (integer ai_periodo, integer ai_anio, long al_cve_mat, string as_gpo, integer ai_cve_asistencia[]);//of_cuenta_asistencias
//cuenta la cantidad de registros en base a las claves de asistencia recibidas
//para un grupo
//Recibe:
//	ai_periodo				integer
//	ai_anio					integer
//	al_cve_mat				long
//	as_gpo					string
//	ai_cve_asistencia[]	array de enteros

long ll_num_rows, ll_cantidad

ll_num_rows = ids_datastore.Retrieve(ai_periodo, ai_anio, al_cve_mat, as_gpo, ai_cve_asistencia)

IF ll_num_rows> 0 THEN
	ll_cantidad= ids_datastore.GetItemNumber(1,"cantidad")
	RETURN ll_cantidad
END IF


RETURN 0
end function

public function integer of_asistencia_grupo (integer ai_periodo, integer ai_anio, long al_cve_mat, string as_gpo, ref integer aio_clases_totales, ref integer aio_asistencias, ref integer aio_faltas, ref decimal ado_porcentaje_asistencia);//of_asistencia_grupo
//Devuelve las  asistencia de los grupos recibidos
//Recibe:
//	ai_periodo				integer
//	ai_anio					integer
//	al_cve_mat				long
//	as_gpo					string
//Devuelve en parametros de salida
//	aio_clases_totales			integer
//	aio_asistencias				integer
//	aio_faltas						integer
//	ado_porcentaje_asistencia	decimal

integer li_clases_totales , li_asistencias, li_faltas
integer li_cve_clases_totales[]={0,1,2,3,4}, li_cve_asistencias[]={0,1,4}, li_cve_faltas[]={2,3}
decimal ld_porcentaje_asistencia

li_clases_totales = of_cuenta_asistencias(ai_periodo, ai_anio, al_cve_mat, as_gpo, li_cve_clases_totales)

IF li_clases_totales >= 0 THEN
	aio_clases_totales= li_clases_totales
ELSE
	aio_clases_totales=0
END IF

li_asistencias = of_cuenta_asistencias(ai_periodo, ai_anio, al_cve_mat, as_gpo, li_cve_asistencias)
IF li_asistencias >= 0 THEN
	aio_asistencias= li_asistencias
ELSE
	aio_asistencias=0
END IF

li_faltas = of_cuenta_asistencias(ai_periodo, ai_anio, al_cve_mat, as_gpo, li_cve_faltas)
IF li_faltas >= 0 THEN
	aio_faltas= li_faltas
ELSE
	aio_faltas= 0
END IF

IF li_clases_totales> 0 AND li_asistencias > 0 THEN
	ld_porcentaje_asistencia= li_asistencias / li_clases_totales
	ado_porcentaje_asistencia= ld_porcentaje_asistencia *100
ELSE
	ado_porcentaje_asistencia = 0
END IF

IF li_clases_totales= -1 OR li_asistencias= -1 OR li_faltas= -1 THEN
	RETURN -1
ELSEIF li_clases_totales> 0 OR li_asistencias>0 OR li_faltas>0 THEN
	RETURN 1
ELSE
	RETURN 0
END IF

end function

public function integer of_actual_asistencia_periodo (integer ai_periodo, integer ai_anio);//of_actual_asistencia_periodo
//actualiza la asistencia de los registros en hist_grupos del periodo recibido,
//en base a la información de profesor_lista_asistencia
//Recibe:
//	ai_periodo				integer
//	ai_anio					integer

long ll_num_rows, ll_cantidad, ll_row_actual
string ls_gpo
long ll_cve_mat
int li_asistencia, io_clases_totales, io_asistencias, io_faltas, li_res_setitem, li_update_asistencia
decimal do_porcentaje_asistencia

SetPointer(HourGlass!)
ll_num_rows = ids_datastore_grupos_periodo.Retrieve(ai_periodo, ai_anio)

IF ll_num_rows= 0 THEN
	MessageBox("Periodo sin Histórico", "No existen grupos en el histórico con el periodo indicado", StopSign!)
	RETURN ll_num_rows
ELSEIF ll_num_rows= -1 THEN
	MessageBox("Error","Error al consultar Histórico de grupos", StopSign!)
	RETURN ll_num_rows
END IF


FOR ll_row_actual = 1 TO ll_num_rows
	
	ll_cve_mat = ids_datastore_grupos_periodo.GetItemNumber(ll_row_actual,"cve_mat")
	ls_gpo = ids_datastore_grupos_periodo.GetItemString(ll_row_actual,"gpo")
	li_asistencia = of_asistencia_grupo_multiple(ai_periodo, ai_anio, ll_cve_mat, ls_gpo, &
												io_clases_totales, io_asistencias, io_faltas, do_porcentaje_asistencia)
	IF li_asistencia = -1 THEN
		Goto Error
	ELSEIF li_asistencia>0 THEN
		li_res_setitem =ids_datastore_grupos_periodo.SetItem(ll_row_actual,"porc_asis", do_porcentaje_asistencia)
		IF li_res_setitem = -1 THEN
			Goto Error
		END IF
	END IF	
	
NEXT
li_update_asistencia= ids_datastore_grupos_periodo.Update()
IF li_update_asistencia= 1 THEN
	COMMIT USING gtr_sce;
	MessageBox("Actualización Exitosa", "Se ha actualizado exitosamente la asistencia de los profesores", Information!)
	RETURN 0
ELSE
	ROLLBACK USING gtr_sce;
	MessageBox("Error de Actualización", "No es posible actualizar la asistencia de los profesores", StopSign!)
	RETURN -1	
END IF

Error:
	MessageBox("Error","Error al consultar la asistencia de los profesores ["+&
					string(ll_cve_mat)+"-"+ls_gpo+"]", StopSign!)
	RETURN -1




end function

public function integer of_asistencia_grupo_multiple (integer ai_periodo, integer ai_anio, long al_cve_mat, string as_gpo, ref integer aio_clases_totales, ref integer aio_asistencias, ref integer aio_faltas, ref decimal ado_porcentaje_asistencia);//of_asistencia_grupo_simple
//Devuelve las  asistencia de los grupos recibidos
//Recibe:
//	ai_periodo				integer
//	ai_anio					integer
//	al_cve_mat				long
//	as_gpo					string
//Devuelve en parametros de salida
//	aio_clases_totales			integer
//	aio_asistencias				integer
//	aio_faltas						integer
//	ado_porcentaje_asistencia	decimal

integer li_clases_totales , li_asistencias, li_faltas
integer li_cve_clases_totales[]={0,1,2,3,4}, li_cve_asistencias[]={0,1,4}, li_cve_faltas[]={2,3}
decimal ld_porcentaje_asistencia
long 	ll_ind0, ll_ind1, ll_ind2, ll_ind3, ll_ind4
long 	ll_asistencia_0, ll_asistencia_1, ll_asistencia_2, ll_asistencia_3, ll_asistencia_4

li_clases_totales = ids_datastore_multiple.Retrieve(ai_periodo, ai_anio, al_cve_mat, as_gpo, li_cve_clases_totales)

IF li_clases_totales > 0 THEN
	ll_ind0= ids_datastore_multiple.Find("cve_asistencia =0", 1, li_clases_totales)
	ll_ind1= ids_datastore_multiple.Find("cve_asistencia =1", 1, li_clases_totales)
	ll_ind2= ids_datastore_multiple.Find("cve_asistencia =2", 1, li_clases_totales)
	ll_ind3= ids_datastore_multiple.Find("cve_asistencia =3", 1, li_clases_totales)
	ll_ind4= ids_datastore_multiple.Find("cve_asistencia =4", 1, li_clases_totales)

	IF ll_ind0= 0 THEN
		ll_asistencia_0= 0
	ELSE
		ll_asistencia_0= ids_datastore_multiple.GetItemNumber(ll_ind0,"cantidad")
	END IF
	IF ll_ind1= 0 THEN
		ll_asistencia_1= 0
	ELSE
		ll_asistencia_1= ids_datastore_multiple.GetItemNumber(ll_ind1,"cantidad")
	END IF
	IF ll_ind2= 0 THEN
		ll_asistencia_2= 0
	ELSE
		ll_asistencia_2= ids_datastore_multiple.GetItemNumber(ll_ind2,"cantidad")
	END IF
	IF ll_ind3= 0 THEN
		ll_asistencia_3= 0
	ELSE
		ll_asistencia_3= ids_datastore_multiple.GetItemNumber(ll_ind3,"cantidad")
	END IF
	IF ll_ind4= 0 THEN
		ll_asistencia_4= 0
	ELSE
		ll_asistencia_4= ids_datastore_multiple.GetItemNumber(ll_ind4,"cantidad")
	END IF	
	
	aio_clases_totales= ll_asistencia_0 + ll_asistencia_1 + ll_asistencia_2 + ll_asistencia_3 + ll_asistencia_4
	aio_asistencias= ll_asistencia_0 + ll_asistencia_1 + ll_asistencia_4
	aio_faltas= ll_asistencia_2 + ll_asistencia_3
	
	IF aio_clases_totales> 0 AND aio_asistencias > 0 THEN
		ld_porcentaje_asistencia= aio_asistencias / aio_clases_totales
		ado_porcentaje_asistencia= ld_porcentaje_asistencia *100
	ELSE
		ado_porcentaje_asistencia = 0
	END IF

ELSE
	aio_clases_totales=0
	aio_asistencias = 0
	aio_faltas = 0
	ado_porcentaje_asistencia = 0
END IF

RETURN li_clases_totales

end function

public function integer of_elimina_asistencia_periodo (integer ai_periodo, integer ai_anio);//of_elimina_asistencia_periodo
//Elimina la asistencia de los profesores para un periodo
//Recibe:
//ai_periodo 	integer
//ai_anio		integer
//Devuelve 		-1 ERROR EN LA ELIMINACION
//					 0 SALIO SIN ACTUALIZAR
//					 1 ELIMINACION EXITOSA
uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios

long ll_grupos_existentes, ll_regs_asistencia, ll_regs_asistencia_cargada, ll_regs_asistencia_no_cargada
integer li_confirmacion, li_codigo_sql
string ls_periodo_anio, ls_mensaje_sql

ls_periodo_anio = luo_periodo_servicios.f_recupera_desc_periodo(gtr_sce, ai_periodo) + " - " + string(ai_anio)

IF luo_periodo_servicios.ierror = -1 THEN 
	MessageBox(luo_periodo_servicios.ititulo, luo_periodo_servicios.imensaje, StopSign!)
	RETURN luo_periodo_servicios.ierror
END IF	

//CHOOSE CASE ai_periodo
//	CASE 0
//		ls_periodo_anio= "Primavera - "+string(ai_anio)
//	CASE 1
//		ls_periodo_anio= "Verano - "+string(ai_anio)
//	CASE 2
//		ls_periodo_anio= "Otoño - "+string(ai_anio)
//END CHOOSE

SELECT count(*)
INTO :ll_regs_asistencia
FROM profesor_lista_asistencia 
WHERE periodo = :ai_periodo
AND	anio = :ai_anio
USING gtr_sce;

IF ll_regs_asistencia = 0 THEN
	MessageBox("Registros de asistencia inexistentes", "NO existen registros de asistencia los profesores para ["+ls_periodo_anio+"]", Information!)	
	RETURN 0
END IF

SELECT count(*)
INTO :ll_grupos_existentes
FROM hist_grupos 
WHERE periodo = :ai_periodo
AND	anio = :ai_anio
USING gtr_sce;


SELECT count(*)
INTO :ll_regs_asistencia_cargada
FROM hist_grupos 
WHERE periodo = :ai_periodo
AND	anio = :ai_anio
AND	porc_asis <> 0
USING gtr_sce;

SELECT count(*)
INTO :ll_regs_asistencia_no_cargada
FROM hist_grupos 
WHERE periodo = :ai_periodo
AND	anio = :ai_anio
AND	porc_asis = 0
USING gtr_sce;

li_confirmacion = MessageBox("Confirmación",	"Registros de asistencia del periodo ["+ls_periodo_anio+"] = "+string(ll_regs_asistencia) +"~n"+ &
										"Grupos del periodo ["+ls_periodo_anio+"] = "+string(ll_grupos_existentes) +"~n"+ &
										"Grupos CON asistencia cargada mayor a 0 : ["+string(ll_regs_asistencia_cargada)+"]~n"+&
										"Grupos SIN asistencia cargada o con 0   : ["+string(ll_regs_asistencia_no_cargada)+"]~n"+&
										"¿Desea eliminar la asistencia de los profesores del periodo?",Question!,YesNo!)

IF li_confirmacion <> 1 THEN
	MessageBox("Eliminación Cancelada", "NO se ha eliminado la asistencia de los profesores", Information!)	
	RETURN 0
END IF

DELETE FROM profesor_lista_asistencia
WHERE periodo = :ai_periodo
AND	anio = :ai_anio
USING gtr_sce;

li_codigo_sql = gtr_sce.SqlCode
ls_mensaje_sql = gtr_sce.SqlErrText

IF li_codigo_sql= -1 THEN 
	ROLLBACK USING gtr_sce;
	MessageBox("Error de eliminación", "No ha sido posible eliminar la asistencia de los profesores", StopSign!)
ELSE
	COMMIT USING gtr_sce;
	MessageBox("Eliminación exitosa", "Se ha eliminado la asistencia de los profesores", Information!)	
END IF

RETURN li_codigo_sql
end function

event constructor;ids_datastore= create uds_datastore
ids_datastore_multiple = create uds_datastore
ids_datastore_grupos_periodo = create uds_datastore

ids_datastore.dataobject = 'd_asistencia_especifica'
ids_datastore.SetTransObject(gtr_sce)

ids_datastore_multiple.dataobject = 'd_asistencia_multiple'
ids_datastore_multiple.SetTransObject(gtr_sce)

ids_datastore_grupos_periodo.dataobject = 'd_grupos_asistencia_profesor'
ids_datastore_grupos_periodo.SetTransObject(gtr_sce)

end event

event destructor;IF isvalid(ids_datastore) THEN
	DESTROY ids_datastore
END IF

IF isvalid(ids_datastore_multiple) THEN
	DESTROY ids_datastore_multiple
END IF

IF isvalid(ids_datastore_grupos_periodo) THEN
	DESTROY ids_datastore_grupos_periodo
END IF

end event

on uo_control_asistencia_profesor.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_control_asistencia_profesor.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

