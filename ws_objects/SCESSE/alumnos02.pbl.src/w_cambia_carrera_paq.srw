$PBExportHeader$w_cambia_carrera_paq.srw
forward
global type w_cambia_carrera_paq from w_master_main
end type
type uo_nombre from uo_nombre_alumno_2013 within w_cambia_carrera_paq
end type
type dw_carrera from datawindow within w_cambia_carrera_paq
end type
type dw_carrera_act from datawindow within w_cambia_carrera_paq
end type
type dw_paq_x_materia from datawindow within w_cambia_carrera_paq
end type
type st_1 from statictext within w_cambia_carrera_paq
end type
type dw_horarios_remedial_mat from datawindow within w_cambia_carrera_paq
end type
type dw_horarios_remedial_esp from datawindow within w_cambia_carrera_paq
end type
type dw_aspiran_con_paq from datawindow within w_cambia_carrera_paq
end type
type dw_5 from datawindow within w_cambia_carrera_paq
end type
type dw_aspiran_reingreso from datawindow within w_cambia_carrera_paq
end type
type dw_paquetes_materias from datawindow within w_cambia_carrera_paq
end type
type dw_mat_inscritas from datawindow within w_cambia_carrera_paq
end type
type st_2 from statictext within w_cambia_carrera_paq
end type
type dw_horario_paquete_visual from datawindow within w_cambia_carrera_paq
end type
end forward

global type w_cambia_carrera_paq from w_master_main
integer width = 5838
integer height = 3020
string title = "Asignación de Paquetes Primer Ingreso con cambio de Carrera"
string menuname = "m_datos_generales_2013"
boolean resizable = true
event ins_mat_inscritas_x_carr ( long al_mat,  string al_grupo,  long al_periodo,  long al_anio )
uo_nombre uo_nombre
dw_carrera dw_carrera
dw_carrera_act dw_carrera_act
dw_paq_x_materia dw_paq_x_materia
st_1 st_1
dw_horarios_remedial_mat dw_horarios_remedial_mat
dw_horarios_remedial_esp dw_horarios_remedial_esp
dw_aspiran_con_paq dw_aspiran_con_paq
dw_5 dw_5
dw_aspiran_reingreso dw_aspiran_reingreso
dw_paquetes_materias dw_paquetes_materias
dw_mat_inscritas dw_mat_inscritas
st_2 st_2
dw_horario_paquete_visual dw_horario_paquete_visual
end type
global w_cambia_carrera_paq w_cambia_carrera_paq

type variables
Datawindowchild dwc_carrera,dwc_plan
long il_cuenta,il_carrera, il_cve_plan, il_periodo_ing, il_anio_ing
String is_tipo_alum
transaction itr_web
Integer ii_CuentaRemedialEsp, ii_CuentaRemedialMat

end variables

forward prototypes
public function integer wf_actualiza_datos (long ar_cuenta, long ar_anio, integer ar_periodo)
public function integer wf_inserta_remediales ()
public function integer wf_inicia_conexiones ()
public function integer wf_act_carrera_paq ()
end prototypes

event ins_mat_inscritas_x_carr(long al_mat, string al_grupo, long al_periodo, long al_anio);/*
	Oscar Sánchez.
	Agosto de 2011.
	Descripción:	Se modifica para replicar la información a SQLServer.
					El objeto de transacción gtr_sce apunta a controlescolar_db en Sybase
					El objeto de transacción itr_web apunta a controlescolar_db en SQLServer
*/

long temp,cupo,inscritos
int tipo, clave_asimilada
string grupo_asimilado,ls_error
Boolean	lb_hacer_commit_SQLServer	= False		/* OSS, 31-Ago-2011 */
Boolean	lb_hacer_commit_Sybase		= False		/* OSS, 31-Ago-2011 */
Boolean	lb_trabajar_en_SQLServer		= True		/* OSS, 31-Ago-2011 */
Boolean	lb_trabajar_en_Sybase			= True		/* OSS, 31-Ago-2011 */

SELECT dbo.mat_inscritas.cuenta
INTO :temp
FROM dbo.mat_inscritas
WHERE ( dbo.mat_inscritas.cuenta = :il_cuenta ) AND
	( dbo.mat_inscritas.cve_mat = :al_mat ) AND
	( dbo.mat_inscritas.gpo = :al_grupo ) AND
	( dbo.mat_inscritas.periodo = :al_periodo ) AND
	( dbo.mat_inscritas.anio = :al_anio )
USING gtr_sce;

///*Si existe la cuenta quiere decir que la materia ya se inscribio*/
if temp = il_cuenta then
	lb_trabajar_en_Sybase = False
end if

/* OSS, 31-Ago-2011 */
SELECT dbo.mat_inscritas.cuenta
INTO :temp
FROM dbo.mat_inscritas
WHERE ( dbo.mat_inscritas.cuenta = :il_cuenta ) AND
	( dbo.mat_inscritas.cve_mat = :al_mat ) AND
	( dbo.mat_inscritas.gpo = :al_grupo ) AND
	( dbo.mat_inscritas.periodo = :al_periodo ) AND
	( dbo.mat_inscritas.anio = :al_anio )
USING itr_web;

/*Si existe la cuenta quiere decir que la materia ya se inscribio*/
if temp = il_cuenta then
	lb_trabajar_en_SQLServer = False
end if

IF lb_trabajar_en_SQLServer = False AND lb_trabajar_en_Sybase = False THEN
	Return
END IF

 
//IF lb_trabajar_en_Sybase = True THEN	/* OSS, 31-Ago-2011 */
	INSERT INTO mat_inscritas  
		( cuenta, cve_mat, gpo, periodo, anio, cve_condicion, acreditacion, inscripcion )
	VALUES ( :il_cuenta, :al_mat, :al_grupo, :al_periodo, :al_anio, 0, 0, 'I' )  
	USING gtr_sce;
	if gtr_sce.SQLErrText<>"" then
		ls_error=gtr_sce.SQLErrText
		rollback using gtr_sce;
		MessageBox("Sybase Database Error",ls_error, Exclamation!)
		return
	else
		lb_hacer_commit_Sybase = True
	end if
//END IF	/* OSS, 31-Ago-2011 */

/* OSS, 31-Ago-2011 */
//IF lb_trabajar_en_SQLServer = True THEN
	INSERT INTO mat_inscritas  
		( cuenta, cve_mat, gpo, periodo, anio, cve_condicion, acreditacion, inscripcion )
	VALUES ( :il_cuenta, :al_mat, :al_grupo, :al_periodo, :al_anio, 0, 0, 'I' )  
	USING itr_web;
	if itr_web.SQLErrText<>"" then
		ls_error = itr_web.SQLErrText
		rollback using itr_web;

		IF lb_hacer_commit_Sybase = True THEN
			rollback using gtr_sce;
		END IF
		
		MessageBox ( "Error en la base de datos web:" ,ls_error, Exclamation! )
		return
	else
		lb_hacer_commit_SQLServer = True
	end if
//END IF

IF lb_hacer_commit_SQLServer = True THEN
	Commit Using itr_web;
END IF

IF lb_hacer_commit_Sybase = True THEN
	Commit Using gtr_sce;
END IF
/* OSS, 31-Ago-2011 */
end event

public function integer wf_actualiza_datos (long ar_cuenta, long ar_anio, integer ar_periodo);Long ll_cuantos, ll_cuantos_web, ll_cve_mat, ll_rows
Integer li_respuesta, li_cont, li_actualiza_insc_sem_ant
String ls_grupo

// Verificar si estan definidas las materias remediales para el año y periodo seleccionados ...
ii_CuentaRemedialEsp = 0
ii_CuentaRemedialMat = 0

// Verificar si esta definida remedial español ...
Select		Count ( * )
Into		:ii_CuentaRemedialEsp
From		horario
Where	cve_mat = 90203 AND
			anio = :ar_anio and
			periodo = :ar_periodo
USING	gtr_sce;

IF gtr_sce.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De base de datos al consultar el horario de la materia Remedial Español.~n~r~n~r" + gtr_sce.SQLErrText  )
	Return -1
END IF

IF ISNull ( ii_CuentaRemedialEsp ) THEN ii_CuentaRemedialEsp = 0

// Verificar si esta definida remedial Matemáticas ...
Select		Count ( * )
Into		:ii_CuentaRemedialMat
From		horario
Where	cve_mat = 90204 AND
			anio = :ar_anio and
			periodo = :ar_periodo
USING	gtr_sce;

IF gtr_sce.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De base de datos al consultar el horario de la materia Remedial Matemáticas.~n~r~n~r" + gtr_sce.SQLErrText  )
	Return -1
END IF

IF ISNull ( ii_CuentaRemedialMat ) THEN ii_CuentaRemedialMat = 0

IF ii_CuentaRemedialEsp = 0 THEN
	li_Respuesta = MessageBox ( "Aviso:" , "No está definida la materia Remedial Español para el año y periodo a enlazar. ~n~n~n~r Si continúa no se inscribirán las materias remediales de Español ~n~r~n~r ¿Desa Continuar?" , Question! , YesNo! )
	
	IF li_Respuesta = 2 THEN
		Return -1
	END IF
END IF

IF ii_CuentaRemedialMat = 0 THEN
	li_Respuesta = MessageBox ( "Aviso:" , "No está definida la materia Remedial Matemáticas para el año y periodo a enlazar. ~n~n~n~r Si continúa no se inscribirán las materias remediales de Español ~n~r~n~r ¿Desa Continuar?" , Question! , YesNo! )
	
	IF li_Respuesta = 2 THEN
		Return -1
	END IF
END IF

IF ii_CuentaRemedialMat > 0 THEN
	dw_horarios_remedial_mat.Reset ( )
	dw_horarios_remedial_mat.SetTransObject ( gtr_sce )
	dw_horarios_remedial_mat.Retrieve ( 90204 , ar_anio , ar_periodo )
END IF

IF ii_CuentaRemedialEsp > 0 THEN
	dw_horarios_remedial_esp.Reset ( )
	dw_horarios_remedial_esp.SetTransObject ( gtr_sce )
	dw_horarios_remedial_esp.Retrieve ( 90203 , ar_anio , ar_periodo )
END IF

// Si las materias remediales ESPAÑOL y MATEMÁTICAS no estan definidas para el año y periodo,
// preguntar si se desea continuar sin realizar el proceso de inscribir las materias remediales ...
IF ii_CuentaRemedialMat = 0 AND ii_CuentaRemedialEsp = 0 THEN
	li_Respuesta = MessageBox ( "Aviso:" , "No están definidas las materias Remediales Matemáticas y Español para el año y periodo a enlazar. ~n~n~n~r Si continúa no se inscribirán las materias remediales de Español y Matemáticas~n~r~n~r ¿Desa Continuar?" , Question! , YesNo! )
	
	IF li_Respuesta = 2 THEN
		Return -1
	END IF
END IF
		
		// OSS 03-Ene-2011
		// Verificar si las materias del paquete ya fueron inscritas para el aspirante ...
		ll_cuantos = 0
		
		SELECT	Count (dbo.mat_inscritas.cuenta)
		INTO		:ll_cuantos
		FROM		dbo.mat_inscritas
		WHERE	( dbo.mat_inscritas.cuenta = :il_cuenta ) AND
					( dbo.mat_inscritas.periodo = :ar_periodo ) AND
					( dbo.mat_inscritas.anio = :ar_anio )
		USING	gtr_sce;
		
//		// SFF. Se debe validar tamb en Web
		ll_cuantos_web = 0
		
		SELECT	Count (dbo.mat_inscritas.cuenta)
		INTO		:ll_cuantos_web
		FROM		dbo.mat_inscritas
		WHERE	( dbo.mat_inscritas.cuenta = :il_cuenta ) AND
					( dbo.mat_inscritas.periodo = :ar_periodo ) AND
					( dbo.mat_inscritas.anio = :ar_anio )
		USING	itr_web;
		
	
		IF ll_cuantos > 0 Or ll_cuantos_web > 0 THEN
			li_respuesta = MessageBox ( "Aviso" , "El alumno con cuenta [" + String ( il_cuenta ) + "]  ya tiene materias inscritas.~n~r¿Desea Borrar y volver a inscribir las materias?" , StopSign! , YesNo! )
					
			
			IF li_respuesta = 1 THEN
				
				Delete
				FROM		dbo.mat_inscritas
				WHERE	( dbo.mat_inscritas.cuenta = :il_cuenta ) AND
							( dbo.mat_inscritas.periodo = :ar_periodo ) AND
							( dbo.mat_inscritas.anio = :ar_anio )
				USING	gtr_sce;
				
				Delete
				FROM		dbo.mat_inscritas
				WHERE	( dbo.mat_inscritas.cuenta = :il_cuenta ) AND
							( dbo.mat_inscritas.periodo = :ar_periodo ) AND
							( dbo.mat_inscritas.anio = :ar_anio )
				USING	itr_web;
				
				Commit Using gtr_sce;
				Commit Using itr_web;
			
				For li_cont=1 to dw_paquetes_materias.rowcount()
					ll_cve_mat = dw_paquetes_materias.object.clv_mat[li_cont]
					ls_grupo = dw_paquetes_materias.object.grupo[li_cont]
					event ins_mat_inscritas_x_carr( ll_cve_mat, ls_grupo, ar_periodo , ar_anio )
				Next
				
			END IF
		END IF
		
		IF ll_cuantos = 0 and ll_cuantos_web = 0 THEN
			For li_cont=1 to dw_paquetes_materias.rowcount()
				ll_cve_mat = dw_paquetes_materias.object.clv_mat[li_cont]
				ls_grupo = dw_paquetes_materias.object.grupo[li_cont]
		
				event ins_mat_inscritas_x_carr( ll_cve_mat, ls_grupo, ar_periodo , ar_anio )
			Next
		END IF
		
		ll_cuantos = 0
		// OSS 03-Ene-2011
		ll_cuantos_web = 0 ///SFF Dic2014
		
		li_actualiza_insc_sem_ant = f_actualiza_insc_sem_ant ( il_cuenta )
		if li_actualiza_insc_sem_ant= -1 then
			MessageBox("Error de Inserción","Error al actualizar la bandera de inscrito el semestre anterior",StopSign!)
		end if
	
//		IF ll_rows > 0 THEN
			IF ii_CuentaRemedialMat > 0 AND ii_CuentaRemedialEsp > 0 THEN
//				wf_inserta_remediales ( cont_1 );
				wf_inserta_remediales ( );
			END IF
//		END IF
//	END IF
	
		dw_mat_inscritas.retrieve(il_cuenta)
		MessageBox("Mensaje del sistema","El proceso se realizo de manera exitosa, se refrescará la información...")
		w_cambia_carrera_paq.triggerevent("ue_nuevo")
	
	RETURN 0 
end function

public function integer wf_inserta_remediales ();Long			ll_folio
Long			ll_clv_carr
Dec			ld_puntos_matematicas
Dec			ld_puntos_espanol
Int				li_hora_inicio
Int				li_hora_final
Int				li_cont
Int				li_num_paq
Int				li_cve_dia
Boolean		lb_remedial_mat_insertada = False
Boolean		lb_remedial_esp_insertada = False
String			ls_MensajeError
String			ls_gpo
Int				li_cve_mat
String			ls_gpo_rem
Int				li_cve_dia_rem
Int				li_hora_inicio_rem
Int				li_hora_final_rem
Int				li_no_mat_con_horarios_cruzados
DateTime	ldt_fecha_hora_actual
Int				li_clv_ver
Int				li_respuesta
Int				li_cuantos
Int				li_result
Long			ll_cuenta_aux
/*Para los reingresos*/
Integer 		li_clv_ver_reing, li_periodo_reing
Long			ll_anio_reing


Choose case is_tipo_alum
	case 'P'
		li_result = dw_aspiran_con_paq.retrieve(gi_version,il_periodo_ing, il_anio_ing, il_cuenta)
	case 'R'
		li_result = dw_aspiran_reingreso.retrieve(il_cuenta)
	case else
		Messagebox(' Mensaje del Sistema', 'No esta definido si es un alumno de primer ingreso o un reingreso...(wf_inserta_remediales)')
		return -1
end choose

If li_result <= 0 Then 
	Messagebox(' Mensaje del Sistema', 'No existe información necesaria del alumno (aspiran) para poder validar materias remediales')
	return -1
Else
	If is_tipo_alum = 'P' Then	
		ll_folio		= dw_aspiran_con_paq.Object.folio [1]
		ll_clv_carr	= il_carrera
		li_num_paq	= dw_paq_x_materia.Object.num_paq [1]
	
		IF gi_version = 99 THEN
			li_clv_ver = dw_aspiran_con_paq.Object.clv_ver [1]
		ELSE
			li_clv_ver = gi_version
		END IF
	Else  /*Reingreso*/
		ll_folio		= dw_aspiran_reingreso.Object.folio [1]
		ll_clv_carr	= il_carrera
		li_num_paq	= dw_paq_x_materia.Object.num_paq [1]

		li_clv_ver = dw_aspiran_reingreso.Object.clv_ver [1]
		li_clv_ver_reing = dw_aspiran_reingreso.Object.clv_ver [1]
		li_periodo_reing = dw_aspiran_reingreso.Object.clv_per [1]
		ll_anio_reing = dw_aspiran_reingreso.Object.anio [1]
		
	End If
	
End If



/* *************************************************************
	Verificar si se requiere agregar la materia de REMEDIAL MATEMATICAS
	**************************************************************/
	If is_tipo_alum = 'P' Then
		Select		a.folio,
					area_1 + area_2 as Matematicas
		Into		:ll_folio,
					:ld_puntos_matematicas
		From		admision_bd.dbo.aspiran a,
					admision_bd.dbo.resultado_examen_modulo rem
		Where	a.folio							= rem.folio		and
					a.clv_ver						= rem.clv_ver	and
					a.clv_per						= rem.clv_per	and
					a.anio							= rem.anio		and
					a.status						in ( 1,2 )			and	/* Tabla status, 1 = 'ACEPTADO', 2 = 'INSCRITO' */
					a.promedio					<= 73			and
					( area_1 + area_2			<= 110 )			and
					rem.cve_tipo_examen	= 1				and	/* Tabla tipo_examen, 1 = 'Selección' */
					a.anio							= :il_anio_ing	and
					a.clv_ver						= :li_clv_ver		and
					a.clv_per						= :gi_periodo	and
					a.folio							= :ll_folio
		Using	gtr_sadm;
	Else   /*Reingreso*/
		Select		a.folio,
					area_1 + area_2 as Matematicas
		Into		:ll_folio,
					:ld_puntos_matematicas
		From		admision_bd.dbo.aspiran a,
					admision_bd.dbo.resultado_examen_modulo rem
		Where	a.folio							= rem.folio		and
					a.clv_ver						= rem.clv_ver	and
					a.clv_per						= rem.clv_per	and
					a.anio							= rem.anio		and
					a.status						in ( 1,2 )			and	/* Tabla status, 1 = 'ACEPTADO', 2 = 'INSCRITO' */
					a.promedio					<= 73			and
					( area_1 + area_2			<= 110 )			and
					rem.cve_tipo_examen	= 1				and	/* Tabla tipo_examen, 1 = 'Selección' */
					a.anio							= :ll_anio_reing		and
					a.clv_ver						= :li_clv_ver_reing		and
					a.clv_per						= :li_periodo_reing	and
					a.folio							= :ll_folio
		Using	gtr_sadm;
End If

IF gtr_sadm.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De Base de Datos al verificar si se debe agregar la materia Remedial Matemáticas.~n~r~n~r" + gtr_sadm.SQLErrText )
	Return -1
END IF



IF gtr_sadm.SQLCode = 0 THEN
	// Verificar en que horario se puede tomar la materia REMEDIAL MATEMATICAS ...
	
	dw_horarios_remedial_mat.Reset ( )
	dw_horarios_remedial_mat.SetTransObject ( gtr_sce )
	dw_horarios_remedial_mat.Retrieve ( 90204 , il_anio_ing , gi_periodo )
	
	dw_5.Reset ( )
	/*
		El siguiente FOR es para verificar la materia REMEDIAL MATEMÁTICAS con menor número
		de inscritos (asi esta ordenada la dw), se evalúa que renglón de la dw tiene un horario que
		no se cruce con el horario de alguna materia del paquete ...
	*/
	FOR li_cont = 1 TO dw_horarios_remedial_mat.RowCount ( )
		ls_gpo_rem		= dw_horarios_remedial_mat.Object.gpo		[ li_cont ]
		li_cve_dia_rem	= dw_horarios_remedial_mat.Object.cve_dia	[ li_cont ]

		// Obtener la hora de inicio y hora final de la materia REMEDIAL MATEMÁTICAS ...
		li_hora_inicio_rem	= dw_horarios_remedial_mat.Object.horario_hora_inicio	[ li_cont ]
		li_hora_final_rem	= dw_horarios_remedial_mat.Object.horario_hora_final		[ li_cont ]
		
		/*
			El siguiente query verifica que el horario de la materia REMEDIAL MATEMÁTICAS
			no se cruce con alguna materia del paquete, si el resultado del count es '0' significa
			que el horario no se cruza, mayor a '0' significa que se cruza con alguna materia ...
		*/
		
		Select		distinct
					h.cve_mat,
					h.gpo,
					h.cve_dia,
					h.hora_inicio,
					h.hora_final,
					GetDate ( )
		Into		:li_cve_mat,
					:ls_gpo,
					:li_cve_dia,
					:li_hora_inicio,
					:li_hora_final,
					:ldt_fecha_hora_actual
		From		paquetes_materias pm,
					horario h
		Where	h.cve_mat		= pm.clv_mat and
					h.gpo				= pm.grupo and
					h.periodo		= pm.clv_per and
					h.anio				= pm.anio and
					pm.num_paq	= :li_num_paq and
					pm.clv_per		= :il_periodo_ing and
					pm.anio			= :il_anio_ing	and
					h.cve_dia		= :li_cve_dia_rem	/* Para evaluar solo las materias del paquete que coincidan con el día de la materia remedial */
					and  /* La sig. condición es para que devuelva el número de registros que se cruzan con el horario de la materia remedial*/
					(

						(
							( :li_hora_inicio_rem between h.hora_inicio and h.hora_final ) or
							( :li_hora_final_rem between h.hora_inicio and h.hora_final )
						) and
						(
							
							(
								( :li_hora_inicio_rem < h.hora_final ) or
								( :li_hora_final_rem <= h.hora_final )
							) and 
							(
								:li_hora_final_rem > h.hora_inicio
							)
						)

					)
		Using	gtr_sce;
		
		IF gtr_sce.SQLCode = -1 THEN
			MessageBox ( "Error:" , "De Base de Datos al verificar si la materia Remedial Matemáticas no se cruza con algún horario del paquete de materias.~n~r~n~r" + gtr_sce.SQLErrText )
			Return -1
		END IF
		
		IF gtr_sce.SQLCode = 100 THEN
			// Verificar si ya existe la materia remedial Matematicas en mat_inscritas ...
			Select		cuenta
			Into		:ll_cuenta_aux
			From		mat_inscritas
			Where	cuenta	= :il_cuenta		and
						cve_mat	= 90204			and
//						gpo		= :ls_gpo_rem	and
						periodo	= :il_periodo_ing	and
						anio		= :il_anio_ing
			Using		gtr_sce;
			
			IF gtr_sce.SQLCode = 0 AND ll_cuenta_aux > 0 THEN
				li_respuesta = MessageBox ( "Aviso" , "El alumno con cuenta [" + String ( il_cuenta ) + "]  ya tiene inscrita la materia Remedial Matemáticas.~n~r¿Desea Borrar y volver a inscribir la materia?" , StopSign! , YesNo! )
				
				IF li_respuesta = 2 THEN
					Return -1
				END IF
				
				IF li_respuesta = 1 THEN
					// Eliminar el registro de Materias Inscritas en Sybase ...
					Delete
					From		mat_inscritas
					Where	cuenta	= :il_cuenta		and
								cve_mat	= 90204			and
//								gpo		= :ls_gpo_rem	and
								periodo	= :il_periodo_ing	and
								anio		= :il_anio_ing
					Using		gtr_sce;
					
					// Eliminar el registro en Sybase (admision) de la bitácora de materias remediales inscritas ...
					Delete From aspiran_remediales_inscritas
					Where	folio					= :ll_folio				AND
								clv_ver				= :li_clv_ver				AND
								clv_per				= :il_periodo_ing			AND
								anio					= :il_anio_ing				AND
								cve_mat_rem		= 90204					//AND		/*Comentado SFF DIC 2014*/
//								cve_dia_rem		= :li_cve_dia_rem		AND
//								hora_inicio_rem	= :li_hora_inicio_rem	AND
//								hora_fin_rem		= :li_hora_final_rem
					Using		gtr_sadm;

					
					// Eliminar el registro de Materias Inscritas en SQL Server ...
					Delete
					From		mat_inscritas
					Where	cuenta	= :il_cuenta		and
								cve_mat	= 90204			and
//								gpo		= :ls_gpo_rem	and
								periodo	= :il_periodo_ing	and
								anio		= :il_anio_ing
					Using		itr_web;
					
					Commit Using gtr_sce;
					Commit Using itr_web;
					Commit Using gtr_sadm;
				END IF
			END IF
			
			INSERT INTO mat_inscritas  
			( cuenta, cve_mat, gpo, periodo, anio, cve_condicion, acreditacion, inscripcion )
			VALUES ( :il_cuenta, 90204, :ls_gpo_rem, :il_periodo_ing, :il_anio_ing, 0, 0, 'I' )  
			USING gtr_sce;
			
			IF gtr_sce.SQLCode = -1 THEN
				ls_MensajeError = gtr_sce.SQLErrText
				RollBack Using gtr_sce;
				MessageBox ( "Error:" , "De base de Datos.~n~r Al insertar la materia remedial Matemáticas.~n~r~n~r" + ls_MensajeError  )
				return -1
			END IF
				
			IF gtr_sce.SQLCode = 0 THEN
				INSERT INTO mat_inscritas  
				( cuenta, cve_mat, gpo, periodo, anio, cve_condicion, acreditacion, inscripcion )
				VALUES ( :il_cuenta, 90204, :ls_gpo_rem, :il_periodo_ing, :il_anio_ing, 0, 0, 'I' )  
				USING itr_web;
				
				IF itr_web.SQLCode = -1 THEN
					ls_MensajeError = itr_web.SQLErrText
					RollBack Using gtr_sce;
					RollBack Using itr_web;
					
					MessageBox ( "SQLServer Error:" , "De base de Datos.~n~r Al insertar la materia en mat_inscritas .~n~r~n~r" + ls_MensajeError  )
					return -1
				END IF
				
				
				Commit Using gtr_sce;
				Commit Using itr_web;
			END IF
			
			ll_cuenta_aux = 0
			
			/*SFF DIC 2014*/
			// Verificar si ya existe la materia remedial Matematicas en aspiran_remediales_inscritas ...
			Select		folio
			Into		:ll_cuenta_aux
			From		aspiran_remediales_inscritas
			Where	folio					= :ll_folio				AND
						clv_ver				= :li_clv_ver				AND
						clv_per				= :il_periodo_ing			AND
						anio					= :il_anio_ing				AND
						cve_mat_rem		= 90204					//AND
//						cve_dia_rem		= :li_cve_dia_rem		AND
//						hora_inicio_rem	= :li_hora_inicio_rem	AND
//						hora_fin_rem		= :li_hora_final_rem
			Using		gtr_sadm;

			
			If (gtr_sce.SQLCode = 0) And (ll_cuenta_aux > 0) Then 
				// Eliminar el registro en Sybase (admision) de la bitácora de materias remediales inscritas ...
				Delete From aspiran_remediales_inscritas
				Where	folio					= :ll_folio				AND
							clv_ver				= :li_clv_ver				AND
							clv_per				= :il_periodo_ing			AND
							anio					= :il_anio_ing				AND
							cve_mat_rem		= 90204					//AND
//							cve_dia_rem		= :li_cve_dia_rem		AND
//							hora_inicio_rem	= :li_hora_inicio_rem	AND
//							hora_fin_rem		= :li_hora_final_rem
				Using		gtr_sadm;
				
				Commit Using gtr_sadm;
			End If
			
			
			lb_remedial_mat_insertada = True
			
			// Insertar en aspiran_remediales_inscritas ...
			INSERT INTO aspiran_remediales_inscritas
			( folio,		clv_ver,		clv_per,		anio,		fecha,			clv_carr,		num_paq,		cve_mat_rem,	gpo_rem,		cve_dia_rem,		hora_inicio_rem,		hora_fin_rem,			mat_insertada )
			VALUES 
			( :ll_folio,	:li_clv_ver,	:il_periodo_ing,	:il_anio_ing,	GetDate ( ),	:ll_clv_carr,	:li_num_paq,	90204,			:ls_gpo_rem,	:li_cve_dia_rem,	:li_hora_inicio_rem,	:li_hora_final_rem,	1 )
			Using gtr_sadm;
			
			IF gtr_sadm.SQLCode = -1 THEN
				ls_MensajeError = gtr_sadm.SQLErrText
				RollBack Using gtr_sadm;
				MessageBox ( "Error:" , "De base de Datos.~n~r Al insertar la materia remedial Matemáticas en aspiran_remediales_inscritas.~n~r~n~r" + ls_MensajeError  )
				return -1
			END IF
				
			IF gtr_sadm.SQLCode = 0 THEN
				Commit Using gtr_sadm;
			END IF
			
			EXIT
		END IF
		
		IF gtr_sce.SQLCode = 0 THEN
			// Significa que una materia remedial se cruza con algún horario de las materias del paquete ...

			// Verificar si la materia Remedial fue insertada en la bitácora ...
			Select		Count ( folio )
			Into		:li_cuantos
			From		aspiran_remediales_inscritas
			Where	folio					= :ll_folio				AND
						clv_ver				= :li_clv_ver				AND
						clv_per				= :il_periodo_ing		AND
						anio					= :il_anio_ing			AND
						cve_mat_rem		= 90204					AND
						cve_dia_rem		= :li_cve_dia_rem		AND
						hora_inicio_rem	= :li_hora_inicio_rem AND
						hora_fin_rem		= :li_hora_final_rem
			Using		gtr_sadm;
			
			IF gtr_sadm.SQLCode = 0 and li_cuantos > 0 THEN
				li_respuesta = MessageBox ( "Aviso" , "El alumno con cuenta [" + String ( il_cuenta ) + "]  ya tiene una bitácora de Materia remedial Matemáticas no inscrita.~n~r¿Desea Borrar y volver a intentar inscribir la materia?" , StopSign! , YesNo! )
				
				IF li_respuesta = 2 THEN
					Return -1
				END IF
				
				IF li_respuesta = 1 THEN
					
					// Eliminar el registro en Sybase (admision) de la bitácora de materias remediales inscritas ...
					Delete From aspiran_remediales_inscritas
					Where	folio					= :ll_folio				AND
								clv_ver				= :li_clv_ver				AND
								clv_per				= :il_periodo_ing			AND
								anio					= :il_anio_ing				AND
								cve_mat_rem		= 90204					AND
								cve_dia_rem		= :li_cve_dia_rem		AND
								hora_inicio_rem	= :li_hora_inicio_rem	AND
								hora_fin_rem		= :li_hora_final_rem
					Using		gtr_sadm;

					
					Commit Using gtr_sadm;
				END IF
			END IF

			// Insertar los posibles renglones de las materias del paquete que se cruzan con la materia remedial ...
			dw_5.InsertRow ( 0 )

			dw_5.Object.folio					[ dw_5.RowCount ( ) ] = ll_folio
			dw_5.Object.clv_ver				[ dw_5.RowCount ( ) ] = li_clv_ver
			dw_5.Object.clv_per				[ dw_5.RowCount ( ) ] = gi_periodo
			dw_5.Object.anio					[ dw_5.RowCount ( ) ] = il_anio_ing
			dw_5.Object.fecha					[ dw_5.RowCount ( ) ] = ldt_fecha_hora_actual
			dw_5.Object.clv_carr				[ dw_5.RowCount ( ) ] = ll_clv_carr
			dw_5.Object.num_paq			[ dw_5.RowCount ( ) ] = li_num_paq
			dw_5.Object.cve_mat_rem		[ dw_5.RowCount ( ) ] = 90204
			dw_5.Object.gpo_rem			[ dw_5.RowCount ( ) ] = ls_gpo_rem
			dw_5.Object.cve_dia_rem		[ dw_5.RowCount ( ) ] = li_cve_dia_rem
			dw_5.Object.hora_inicio_rem	[ dw_5.RowCount ( ) ] = li_hora_inicio_rem
			dw_5.Object.hora_fin_rem		[ dw_5.RowCount ( ) ] = li_hora_final_rem
			dw_5.Object.cve_mat				[ dw_5.RowCount ( ) ] = li_cve_mat
			dw_5.Object.gpo					[ dw_5.RowCount ( ) ] = ls_gpo
			dw_5.Object.cve_dia				[ dw_5.RowCount ( ) ] = li_cve_dia
			dw_5.Object.hora_inicio			[ dw_5.RowCount ( ) ] = li_hora_inicio
			dw_5.Object.hora_fin				[ dw_5.RowCount ( ) ] = li_hora_final
			dw_5.Object.mat_insertada		[ dw_5.RowCount ( ) ] = 0
			dw_5.Object.comentarios		[ dw_5.RowCount ( ) ] = 'El horario y día de la materia remedial Matemáticas coincide con el horario y dia de una materia Inscrita'
			
			li_no_mat_con_horarios_cruzados ++
		END IF
		
	NEXT

	IF lb_remedial_mat_insertada = False THEN
		
		// Insertar en aspiran_remediales_inscritas ...
		dw_5.Update ( )
		
		IF gtr_sadm.SQLCode = 0 THEN
			Commit Using gtr_sadm;
		END IF
	END IF
END IF


/* *************************************************************
	Verificar si se requiere agregar la materia de REMEDIAL ESPAÑOL
	**************************************************************/
/* Primer Ingreso */
If is_tipo_alum = 'P' Then
	Select		a.folio,
				area_3 + area_4 as espanol
	Into		:ll_folio,
				:ld_puntos_espanol
	From		aspiran a,
				resultado_examen_modulo rem
	Where	a.folio							= rem.folio		and
				a.clv_ver						= rem.clv_ver	and
				a.clv_per						= rem.clv_per	and
				a.anio							= rem.anio		and
				a.status						in ( 1,2 )			and	/* Tabla status, 1 = 'ACEPTADO', 2 = 'INSCRITO' */
				a.promedio					<= 73			and
				( area_3 + area_4			<= 110 )			and
				rem.cve_tipo_examen	= 1				and	/* Tabla tipo_examen, 1 = 'Selección' */
				a.anio							= :il_anio_ing		and
				a.clv_ver						= :li_clv_ver	         and
				a.clv_per						= :il_periodo_ing	and
				a.folio							= :ll_folio
	Using	gtr_sadm;
Else  /* Reingreso */
	Select		a.folio,
				area_3 + area_4 as espanol
	Into		:ll_folio,
				:ld_puntos_espanol
	From		aspiran a,
				resultado_examen_modulo rem
	Where	a.folio							= rem.folio		and
				a.clv_ver						= rem.clv_ver	and
				a.clv_per						= rem.clv_per	and
				a.anio							= rem.anio		and
				a.status						in ( 1,2 )			and	/* Tabla status, 1 = 'ACEPTADO', 2 = 'INSCRITO' */
				a.promedio					<= 73			and
				( area_3 + area_4			<= 110 )			and
				rem.cve_tipo_examen	= 1				and	/* Tabla tipo_examen, 1 = 'Selección' */
				a.anio							= :ll_anio_reing		and
				a.clv_ver						= :li_clv_ver_reing 	and
				a.clv_per						= :li_periodo_reing	and
				a.folio							= :ll_folio
	Using	gtr_sadm;	
End If

IF gtr_sadm.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De Base de Datos al verificar si se debe agregar la materia Remedial Español.~n~r~n~r" + gtr_sadm.SQLErrText )
	Return -1
END IF

IF gtr_sadm.SQLCode = 0 THEN
	// Verificar en que horario se puede tomar la materia REMEDIAL ESPAÑOL ...
	
	dw_horarios_remedial_esp.Reset ( )
	dw_horarios_remedial_esp.SetTransObject ( gtr_sce )
	dw_horarios_remedial_esp.Retrieve ( 90203 , il_anio_ing , il_periodo_ing )
	
	/*
		El siguiente FOR es para verificar la materia REMEDIAL ESPAÑOL con menor número
		de inscritos (asi esta ordenada la dw), se evalúa que renglón de la dw tiene un horario que
		no se cruce con el horario de alguna materia del paquete ...
	*/
	FOR li_cont = 1 TO dw_horarios_remedial_esp.RowCount ( )
		ls_gpo_rem		= dw_horarios_remedial_esp.Object.gpo		[ li_cont ]
		li_cve_dia_rem	= dw_horarios_remedial_esp.Object.cve_dia	[ li_cont ]
		
		// Obtener la hora de inicio y hora final de la materia REMEDIAL ESPAÑOL ...
		li_hora_inicio_rem	= dw_horarios_remedial_esp.Object.horario_hora_inicio	[ li_cont ]
		li_hora_final_rem	= dw_horarios_remedial_esp.Object.horario_hora_final	[ li_cont ]
		
		/*
			El siguiente query verifica que el horario de la materia REMEDIAL ESPAÑOL
			no se cruce con alguna materia del paquete, si el resultado del count es '0' significa
			que el horario no se cruza, mayor a '0' significa que se cruza con alguna materia ...
		*/

		Select		distinct
					h.cve_mat,
					h.gpo,
					h.cve_dia,
					h.hora_inicio,
					h.hora_final,
					GetDate ( )
		Into		:li_cve_mat,
					:ls_gpo,
					:li_cve_dia,
					:li_hora_inicio,
					:li_hora_final,
					:ldt_fecha_hora_actual
		From		paquetes_materias pm,
					horario h
		Where	h.cve_mat		= pm.clv_mat and
					h.gpo				= pm.grupo and
					h.periodo		= pm.clv_per and
					h.anio				= pm.anio and
					pm.num_paq	= :li_num_paq and
					pm.clv_per		= :gi_periodo and
					pm.anio			= :il_anio_ing and
					h.cve_dia		= :li_cve_dia_rem	/* Para evaluar solo las materias del paquete que coincidan con el día de la materia remedial */
					and  /* La sig. condición es para que devuelva el número de registros que se cruzan con el horario de la materia remedial*/
					(

						(
							( :li_hora_inicio_rem between h.hora_inicio and h.hora_final ) or
							( :li_hora_final_rem between h.hora_inicio and h.hora_final )
						) and
						(

							(
								( :li_hora_inicio_rem < h.hora_final ) or
								( :li_hora_final_rem <= h.hora_final )
							) and 
							(
								:li_hora_final_rem > h.hora_inicio
							)

						)

					)
		Using	gtr_sce;
		
		IF gtr_sce.SQLCode = -1 THEN
			MessageBox ( "Error:" , "De Base de Datos al verificar si la materia Remedial Español no se cruza con algún horario del paquete de materias.~n~r~n~r" + gtr_sce.SQLErrText )
			Return -1
		END IF
		
		IF gtr_sce.SQLCode = 100 THEN
			// Verificar si ya existe la materia remedial Español mat_inscritas ...
			Select		cuenta
			Into		:ll_cuenta_aux
			From		mat_inscritas
			Where	cuenta	= :il_cuenta		and
						cve_mat	= 90203			and
//						gpo		= :ls_gpo_rem	and
						periodo	= :il_periodo_ing	and
						anio		= :il_anio_ing
			Using		gtr_sce;
			
			IF gtr_sce.SQLCode = 0 AND ll_cuenta_aux > 0 THEN
				li_respuesta = MessageBox ( "Aviso" , "El alumno con cuenta [" + String ( il_cuenta ) + "]  ya tiene inscrita la materia Remedial Español.~n~r¿Desea Borrar y volvera inscribir la materia?" , StopSign! , YesNo! )
				
				IF li_respuesta = 2 THEN
					Return -1
				END IF
				
				IF li_respuesta = 1 THEN
					// Eliminar el registro de Materias Inscritas en Sybase ...
					Delete
					From		mat_inscritas
					Where	cuenta	= :il_cuenta		and
								cve_mat	= 90203			and
//								gpo		= :ls_gpo_rem	and
								periodo	= :il_periodo_ing	and
								anio		= :il_anio_ing
					Using		gtr_sce;
					
					// Eliminar el registro en Sybase (admision) de la bitácora de materias remediales inscritas ...
					Delete From aspiran_remediales_inscritas
					Where	folio					= :ll_folio				AND
								clv_ver				= :li_clv_ver				AND
								clv_per				= :il_periodo_ing			AND
								anio					= :il_anio_ing				AND
								cve_mat_rem		= 90203					//AND
//								cve_dia_rem		= :li_cve_dia_rem		AND  /*Comentado SFF DIc2014*/
//								hora_inicio_rem	= :li_hora_inicio_rem	AND
//								hora_fin_rem		= :li_hora_final_rem
					Using		gtr_sadm;

					
					// Eliminar el registro de Materias Inscritas en SQL Server ...
					Delete
					From		mat_inscritas
					Where	cuenta	= :il_cuenta		and
								cve_mat	= 90203			and
//								gpo		= :ls_gpo_rem	and
								periodo	= :il_periodo_ing	and
								anio		= :il_anio_ing
					Using		itr_web;
					
					Commit Using gtr_sce;
					Commit Using itr_web;
					Commit Using gtr_sadm;
				END IF
			END IF
			
			INSERT INTO mat_inscritas  
			( cuenta, cve_mat, gpo, periodo, anio, cve_condicion, acreditacion, inscripcion )
			VALUES ( :il_cuenta, 90203, :ls_gpo_rem, :il_periodo_ing, :il_anio_ing, 0, 0, 'I' )  
			USING gtr_sce;
			
			IF gtr_sce.SQLCode = -1 THEN
				ls_MensajeError = gtr_sce.SQLErrText
				RollBack Using gtr_sce;
				MessageBox ( "Error:" , "De base de Datos.~n~r Al insertar la materia remedial Español.~n~r~n~r" + ls_MensajeError  )
				return -1
			END IF
				
			IF gtr_sce.SQLCode = 0 THEN
				INSERT INTO mat_inscritas  
				( cuenta, cve_mat, gpo, periodo, anio, cve_condicion, acreditacion, inscripcion )
				VALUES ( :il_cuenta, 90203, :ls_gpo_rem, :il_periodo_ing, :il_anio_ing, 0, 0, 'I' )  
				USING itr_web;
				
				IF itr_web.SQLCode = -1 THEN
					ls_MensajeError = itr_web.SQLErrText
					RollBack Using gtr_sce;
					RollBack Using itr_web;
					
					MessageBox ( "SQLServer Error:" , "De base de Datos.~n~r Al insertar la materia en mat_inscritas.~n~r~n~r" + ls_MensajeError  )
					return -1
				END IF
				
				
				Commit Using gtr_sce;
				Commit Using itr_web;
			END IF
			
			/*SFF DIC 2014*/
			// Verificar si ya existe la materia remedial Matematicas en aspiran_remediales_inscritas ...
			Select		folio
			Into		:ll_cuenta_aux
			From		aspiran_remediales_inscritas
			Where	folio					= :ll_folio				AND
						clv_ver				= :li_clv_ver				AND
						clv_per				= :il_periodo_ing			AND
						anio					= :il_anio_ing				AND
						cve_mat_rem		= 90203					//AND
//						cve_dia_rem		= :li_cve_dia_rem		AND
//						hora_inicio_rem	= :li_hora_inicio_rem	AND
//						hora_fin_rem		= :li_hora_final_rem
			Using		gtr_sadm;

			
			If (gtr_sce.SQLCode = 0) And (ll_cuenta_aux > 0) Then 
				// Eliminar el registro en Sybase (admision) de la bitácora de materias remediales inscritas ...
				Delete From aspiran_remediales_inscritas
				Where	folio					= :ll_folio				AND
							clv_ver				= :li_clv_ver				AND
							clv_per				= :il_periodo_ing			AND
							anio					= :il_anio_ing				AND
							cve_mat_rem		= 90203					//AND
//							cve_dia_rem		= :li_cve_dia_rem		AND
//							hora_inicio_rem	= :li_hora_inicio_rem	AND
//							hora_fin_rem		= :li_hora_final_rem
				Using		gtr_sadm;
				
				Commit Using gtr_sadm;
			End If			
			
			lb_remedial_esp_insertada = True
			
			// Insertar en aspiran_remediales_inscritas ...
			INSERT INTO aspiran_remediales_inscritas
			( folio, clv_ver, clv_per, anio, fecha, clv_carr, num_paq, cve_mat_rem, gpo_rem, cve_dia_rem, hora_inicio_rem, hora_fin_rem, mat_insertada )
			VALUES 
			( :ll_folio, :li_clv_ver, :il_periodo_ing, :il_anio_ing, GetDate ( ), :ll_clv_carr, :li_num_paq, 90203, :ls_gpo_rem, :li_cve_dia_rem, :li_hora_inicio_rem, :li_hora_final_rem, 1 )
			Using gtr_sadm;
			
			IF gtr_sadm.SQLCode = -1 THEN
				ls_MensajeError = gtr_sadm.SQLErrText
				RollBack Using gtr_sadm;
				MessageBox ( "Error:" , "De base de Datos.~n~r Al insertar la materia remedial Español en aspiran_remediales_inscritas.~n~r~n~r" + ls_MensajeError  )
				return -1
			END IF
				
			IF gtr_sadm.SQLCode = 0 THEN
				Commit Using gtr_sadm;
			END IF
			EXIT
		END IF
		
		IF gtr_sce.SQLCode = 0 THEN
			// Significa que una materia remedial se cruza con algún horario de las materias del paquete ...
			
			// Verificar si la materia Remedial fue insertada en la bitácora ...
			Select		Count ( folio )
			Into		:li_cuantos
			From		aspiran_remediales_inscritas
			Where	folio					= :ll_folio				AND
						clv_ver				= :li_clv_ver				AND
						clv_per				= :il_periodo_ing			AND
						anio					= :il_anio_ing				AND
						cve_mat_rem		= 90203					AND
						cve_dia_rem		= :li_cve_dia_rem		AND
						hora_inicio_rem	= :li_hora_inicio_rem	AND
						hora_fin_rem		= :li_hora_final_rem
			Using		gtr_sadm;
			
			IF gtr_sadm.SQLCode = 0 and li_cuantos > 0 THEN
				li_respuesta = MessageBox ( "Aviso" , "El alumno con cuenta [" + String ( il_cuenta ) + "]  ya tiene una bitácora de Materia remedial Español no inscrita.~n~r¿Desea Borrar y volver a intentar inscribir la materia?" , StopSign! , YesNo! )
				
				IF li_respuesta = 2 THEN
					Return -1
				END IF
				
				IF li_respuesta = 1 THEN
					
					// Eliminar el registro en Sybase (admision) de la bitácora de materias remediales inscritas ...
					Delete From aspiran_remediales_inscritas
					Where	folio					= :ll_folio				AND
								clv_ver				= :li_clv_ver				AND
								clv_per				= :il_periodo_ing			AND
								anio					= :il_anio_ing				AND
								cve_mat_rem		= 90203					AND
								cve_dia_rem		= :li_cve_dia_rem		AND
								hora_inicio_rem	= :li_hora_inicio_rem	AND
								hora_fin_rem		= :li_hora_final_rem
					Using		gtr_sadm;

					
					Commit Using gtr_sadm;
				END IF
			END IF
			
			// Insertar los posibles renglones de las materias del paquete que se cruzan con la materia remedial ...
			dw_5.InsertRow ( 0 )

			dw_5.Object.folio					[ dw_5.RowCount ( ) ] = ll_folio
			dw_5.Object.clv_ver				[ dw_5.RowCount ( ) ] = li_clv_ver
			dw_5.Object.clv_per				[ dw_5.RowCount ( ) ] = gi_periodo
			dw_5.Object.anio					[ dw_5.RowCount ( ) ] = il_anio_ing
			dw_5.Object.fecha					[ dw_5.RowCount ( ) ] = ldt_fecha_hora_actual
			dw_5.Object.clv_carr				[ dw_5.RowCount ( ) ] = ll_clv_carr
			dw_5.Object.num_paq			[ dw_5.RowCount ( ) ] = li_num_paq
			dw_5.Object.cve_mat_rem		[ dw_5.RowCount ( ) ] = 90203
			dw_5.Object.gpo_rem			[ dw_5.RowCount ( ) ] = ls_gpo_rem
			dw_5.Object.cve_dia_rem		[ dw_5.RowCount ( ) ] = li_cve_dia_rem
			dw_5.Object.hora_inicio_rem	[ dw_5.RowCount ( ) ] = li_hora_inicio_rem
			dw_5.Object.hora_fin_rem		[ dw_5.RowCount ( ) ] = li_hora_final_rem
			dw_5.Object.cve_mat				[ dw_5.RowCount ( ) ] = li_cve_mat
			dw_5.Object.gpo					[ dw_5.RowCount ( ) ] = ls_gpo
			dw_5.Object.cve_dia				[ dw_5.RowCount ( ) ] = li_cve_dia
			dw_5.Object.hora_inicio			[ dw_5.RowCount ( ) ] = li_hora_inicio
			dw_5.Object.hora_fin				[ dw_5.RowCount ( ) ] = li_hora_final
			dw_5.Object.mat_insertada		[ dw_5.RowCount ( ) ] = 0
			dw_5.Object.comentarios		[ dw_5.RowCount ( ) ] = 'El horario y día de la materia remedial Matemáticas coincide con el horario y dia de una materia Inscrita'
			
			li_no_mat_con_horarios_cruzados ++
		END IF
		
	NEXT

	IF lb_remedial_esp_insertada = False THEN
		// Significa que nigún horario de las materias remediales se ajusta a los horarios de las materias del paquete ...

		// Insertar en aspiran_remediales_inscritas ...
		dw_5.Update ( )
		
		IF gtr_sadm.SQLCode = 0 THEN
			Commit Using gtr_sadm;
		END IF
	END IF
END IF




Return 1
end function

public function integer wf_inicia_conexiones ();String ls_mensaje


IF f_conecta_pas_parametros_bd ( gtr_sce , itr_web , 11 , gs_usuario , gs_password ) = 0 THEN
	ls_mensaje = "Atención: "+ "Problemas al conectarse a la base de datos de WEB.controlescolar_bd"
	MessageBox("Error", ls_mensaje, StopSign!)
	close(w_cambia_carrera_paq)
	return -1
END IF

gtr_sadm = CREATE transaction	//Creación de la transacción

//Asigna los valores del objeto de transaccion nuevo en base a los valores leidos de la base de datos
gtr_sadm.AutoCommit		= gtr_sce.AutoCommit
gtr_sadm.Database			= ProfileString(gs_startupfile,gs_sadm,"Database","")
gtr_sadm.DBMS	 			= ProfileString(gs_startupfile,gs_sadm,"DBMS","")
gtr_sadm.DBParm				= ProfileString(gs_startupfile,gs_sadm,"DBPARM","")
gtr_sadm.LogID				= gtr_sce.LogID
gtr_sadm.LogPass				= gtr_sce.LogPass
gtr_sadm.ServerName	 	= 	ProfileString(gs_startupfile,gs_sadm,"ServerName","")

//Conexión a la base de datos
connect using gtr_sadm;

If gtr_sadm.sqlcode <> 0 then
	MessageBox ("No hay conexión con la Base de Datos Admision", gtr_sadm.sqlerrtext, StopSign!)
	return -1
End IF
end function

public function integer wf_act_carrera_paq ();Integer li_result, li_clv_ver, li_num_paq, li_respuesta, li_row
String ls_error, ls_salon
Long ll_folio, ll_clv_carr

If il_cuenta  = 0 Or IsNull(il_cuenta) Then
	MessageBox ( "Mensaje del sistema" , "No existe información de la nueva carrera por asignar al alumno", StopSign!)
	return -1
End If

If il_cve_plan  = 0 Or IsNull(il_cve_plan) Then
	MessageBox ( "Mensaje del sistema" , "No existe información del plan de estudios de la nueva carrera por asignar al alumno", StopSign!)
	return -1
End If

/*Informacion del nuevo paquete-materias elegido*/
dw_paq_x_materia.accepttext( )
li_row = dw_paq_x_materia.getrow( )
li_num_paq = dw_paq_x_materia.Object.num_paq [li_row]

IF li_num_paq = 0 Then
	Messagebox(' Mensaje del Sistema', 'Debe elegir un nuevo paquete-materias para asignar al alumno', StopSign!)
	return -1
Else
	dw_paquetes_materias.retrieve(li_num_paq, il_periodo_ing, il_anio_ing)
End If

li_respuesta = MessageBox ( "Aviso" , "Esta usted seguro de querer actualizar la carrera y paquete para el alumno con cuenta [" + String ( il_cuenta ) + "]" , StopSign! , YesNo! )
If li_respuesta = 2 Then
	Return -1
End If

SELECT count(*)
   INTO  :li_result
  FROM  academicos
 WHERE cuenta = :il_cuenta 
  USING  gtr_sce;
  
If li_result > 0 Then

	/*Se actualiza informacion de la nueva carrera */
	UPDATE academicos
		 SET cve_carrera = :il_carrera,
			   cve_plan = :il_cve_plan,
			   cve_subsistema = 1
	 WHERE cuenta = :il_cuenta
	USING gtr_sce;
	
	ls_error = gtr_sce.sqlerrtext
	
	If gtr_sce.SQLCode = -1 Then
		ROLLBACK Using gtr_sce;
		MessageBox ( "Error:" , "Error al actualizar la informacion de academicos" + ls_error  )
		return -1
	End If
	
	
	/*Se actualiza informacion de la nueva carrera en WEB */
	UPDATE academicos
		 SET cve_carrera = :il_carrera,
			   cve_plan = :il_cve_plan,
			   cve_subsistema = 1
	 WHERE cuenta = :il_cuenta
	USING itr_web;
	
	ls_error = itr_web.sqlerrtext
	
	If itr_web.SQLCode = -1 Then
		ROLLBACK Using itr_web;
		ROLLBACK Using gtr_sce;
		MessageBox ( "Error:" , "Error al actualizar la informacion de academicos" + ls_error  )
		return -1
	End If

End If

	// Consultamos información del Aspirante
	Choose case is_tipo_alum
		case 'P'
			li_result = dw_aspiran_con_paq.retrieve(gi_version,il_periodo_ing, il_anio_ing, il_cuenta)
		case 'R'
			li_result = dw_aspiran_reingreso.retrieve(il_cuenta)
		case else
			ROLLBACK Using itr_web;
			ROLLBACK Using gtr_sce;
			Messagebox(' Mensaje del Sistema', 'No esta definido si es un alumno de primer ingreso o un reingreso...(wf_inserta_remediales)')
			return -1
	end choose
	
	If li_result <= 0 Then 
		ROLLBACK Using itr_web;
		ROLLBACK Using gtr_sce;
		Messagebox(' Mensaje del Sistema', 'No existe información necesaria del alumno (aspiran) para poder realizar la actualización de la carrera')
		return -1
	Else
		If is_tipo_alum = 'P' Then
			ll_folio		= dw_aspiran_con_paq.Object.folio [1]
			ll_clv_carr	= il_carrera
			ls_salon		= dw_aspiran_con_paq.Object.salon [1]
			
			If gi_version = 99 Then
				li_clv_ver = dw_aspiran_con_paq.Object.clv_ver [1]
			Else
				li_clv_ver = gi_version
			End If
		Else
			ll_folio		= dw_aspiran_reingreso.Object.folio [1]
			ll_clv_carr	= il_carrera
		
			If gi_version = 99 Then
				li_clv_ver = dw_aspiran_reingreso.Object.clv_ver [1]
			Else
				li_clv_ver = gi_version
			End If
		End If
	End If
	
	/*En caso de ser de primer ingreso se actualiza carrera y numero de paquete en aspirante*/
	If is_tipo_alum = 'P' Then
		 SELECT IsNull(COUNT(*), 0)
			INTO :li_result
		   FROM carr_sal
		 WHERE clv_ver 	= :li_clv_ver
			 AND salon 		= :ls_salon
			 AND clv_carr 	= :ll_clv_carr
			 AND clv_per 	= :il_periodo_ing
			 AND anio 		= :il_anio_ing
		   USING gtr_sadm;
			
		If   li_result > 0 Then
			UPDATE carr_sal
				 SET folios = folios + 1
			 WHERE clv_ver 	= :li_clv_ver
				 AND salon 		= :ls_salon
				 AND clv_carr 	= :ll_clv_carr
				 AND clv_per 	= :il_periodo_ing
				 AND anio 		= :il_anio_ing
			  USING gtr_sadm;
		Else
			INSERT INTO carr_sal ( clv_ver, salon, clv_carr, clv_per, anio, folios )
		    		   VALUES ( :li_clv_ver, :ls_salon, :ll_clv_carr, :il_periodo_ing, :il_anio_ing, 1)
			  USING gtr_sadm; 
		End If

		ls_error = gtr_sadm.sqlerrtext
		
		IF gtr_sadm.SQLCode = -1 THEN
			ROLLBACK Using gtr_sadm;
			ROLLBACK Using itr_web;
			ROLLBACK Using gtr_sce;
			MessageBox ( "Error:" , "Error al actualizar la informacion de aspirantes(carr_sal)" + ls_error  )
			return -1
		Else 
			IF gtr_sadm.SQLCode = 0 Then 
				COMMIT Using gtr_sadm;
			End If
		End If

		/*Actualizamos carrera y numero de paquete*/
		 UPDATE aspiran
			  SET clv_carr   = :ll_clv_carr,
					num_paq = :li_num_paq
		  WHERE folio 		 =	:ll_folio
			  AND ing_per 	 = :il_periodo_ing
			  AND ing_anio 	 = :il_anio_ing
		   USING gtr_sadm;
			  
		ls_error = gtr_sadm.sqlerrtext
		
		IF gtr_sadm.SQLCode = -1 THEN
			ROLLBACK Using gtr_sadm;
			ROLLBACK Using itr_web;
			ROLLBACK Using gtr_sce;
			MessageBox ( "Error:" , "Error al actualizar la informacion de aspirantes" + ls_error  )
			return -1
		Else 
			IF gtr_sadm.SQLCode = 0 Then 
				COMMIT Using gtr_sadm;
			End If
		End If
		
		/*Actualizamos en WEB*/
		
		 UPDATE admision_bd.dbo.aspiran
			  SET clv_carr   = :ll_clv_carr,
					num_paq = :li_num_paq
		  WHERE folio = :ll_folio
			  AND ing_per = :il_periodo_ing
			  AND ing_anio = :il_anio_ing
		   USING itr_web;
			  
		ls_error = itr_web.sqlerrtext
		
		IF itr_web.SQLCode = -1 THEN
			ROLLBACK Using itr_web;
			ROLLBACK Using gtr_sce;
			MessageBox ( "Error:" , "Error al actualizar la informacion de aspirantes" + ls_error  )
			return -1
		End If

	End If
  
COMMIT Using gtr_sce;
COMMIT Using itr_web;
return 0
end function

on w_cambia_carrera_paq.create
int iCurrent
call super::create
if this.MenuName = "m_datos_generales_2013" then this.MenuID = create m_datos_generales_2013
this.uo_nombre=create uo_nombre
this.dw_carrera=create dw_carrera
this.dw_carrera_act=create dw_carrera_act
this.dw_paq_x_materia=create dw_paq_x_materia
this.st_1=create st_1
this.dw_horarios_remedial_mat=create dw_horarios_remedial_mat
this.dw_horarios_remedial_esp=create dw_horarios_remedial_esp
this.dw_aspiran_con_paq=create dw_aspiran_con_paq
this.dw_5=create dw_5
this.dw_aspiran_reingreso=create dw_aspiran_reingreso
this.dw_paquetes_materias=create dw_paquetes_materias
this.dw_mat_inscritas=create dw_mat_inscritas
this.st_2=create st_2
this.dw_horario_paquete_visual=create dw_horario_paquete_visual
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_nombre
this.Control[iCurrent+2]=this.dw_carrera
this.Control[iCurrent+3]=this.dw_carrera_act
this.Control[iCurrent+4]=this.dw_paq_x_materia
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.dw_horarios_remedial_mat
this.Control[iCurrent+7]=this.dw_horarios_remedial_esp
this.Control[iCurrent+8]=this.dw_aspiran_con_paq
this.Control[iCurrent+9]=this.dw_5
this.Control[iCurrent+10]=this.dw_aspiran_reingreso
this.Control[iCurrent+11]=this.dw_paquetes_materias
this.Control[iCurrent+12]=this.dw_mat_inscritas
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.dw_horario_paquete_visual
end on

on w_cambia_carrera_paq.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nombre)
destroy(this.dw_carrera)
destroy(this.dw_carrera_act)
destroy(this.dw_paq_x_materia)
destroy(this.st_1)
destroy(this.dw_horarios_remedial_mat)
destroy(this.dw_horarios_remedial_esp)
destroy(this.dw_aspiran_con_paq)
destroy(this.dw_5)
destroy(this.dw_aspiran_reingreso)
destroy(this.dw_paquetes_materias)
destroy(this.dw_mat_inscritas)
destroy(this.st_2)
destroy(this.dw_horario_paquete_visual)
end on

event open;call super::open;String ls_mensaje
Integer li_respuesta

uo_nombre.em_cuenta.text = " "
triggerevent(doubleclicked!)

uo_nombre.cbx_nuevo.visible = true
uo_nombre.cbx_nuevo.enabled = true
//uo_nombre.r_3.visible  = true
/**/
//gnv_app.inv_security.of_SetSecurity(this)

li_respuesta = wf_inicia_conexiones()
If li_respuesta = -1 Then 
	return
End If

dw_aspiran_con_paq.settransobject(gtr_sadm)
dw_aspiran_reingreso.settransobject(gtr_sadm)
dw_5.settransobject(gtr_sadm)

dw_carrera_act.settransobject(gtr_sce)
dw_carrera_act.insertrow( 0)

dw_carrera.getchild('cve_carrera',dwc_carrera)
dwc_carrera.settransobject(gtr_sce)
dw_carrera.getchild('cve_plan',dwc_plan)
dwc_plan.settransobject(gtr_sce)

dw_carrera.settransobject(gtr_sce)
dw_carrera.insertrow(0)

dw_paq_x_materia.settransobject(gtr_sce)
dw_paquetes_materias.settransobject(gtr_sce)

dw_mat_inscritas.settransobject(gtr_sce)
dw_mat_inscritas.insertrow(0)

periodo_actual_mat_insc(gi_periodo,gi_anio,gtr_sce)
il_anio_ing = gi_anio
il_periodo_ing = gi_periodo


gi_version = 99
end event

event close;//dwItemStatus l_status
//
//l_status = idw_trabajo.GetItemStatus(1, 0, Primary!)
//
//if l_status <> NotModified!	then
//	if messagebox('Aviso','¿Desea guardar los cambios?',Question!,Yesno!) = 1 then
//		if wf_validar () <> 1 then 	
//			rollback using gtr_sce;
//			messagebox("Información","No se han guardado los cambios")	
//			return 
//		else
//			 triggerevent("ue_actualiza")
//		end if
//	end if
//end if

IF IsValid(itr_web) THEN 
	Disconnect Using itr_web;
END IF

IF IsValid(gtr_sadm) THEN 
	Disconnect Using gtr_sadm;
END IF
end event

event doubleclicked;call super::doubleclicked;Integer li_result 

il_cuenta = long(uo_nombre.of_obten_cuenta())

If il_cuenta <> 0 Then 
	li_result = f_obtiene_tipo_ingreso( il_cuenta,  is_tipo_alum)
	If li_result = 0 Then
		dw_carrera_act.retrieve(il_cuenta)
		If dw_carrera_act.rowcount( ) > 0 Then
//			il_periodo_ing = dw_carrera_act.getitemnumber( dw_carrera_act.getrow(), "periodo_ing")	
//			il_anio_ing = dw_carrera_act.getitemnumber( dw_carrera_act.getrow(), "anio_ing")	

//			il_carrera= dw_carrera_act.getitemnumber( dw_carrera_act.getrow(), "cve_carrera")
//			dw_carrera.setitem(1, "cve_carrera", il_carrera)

			dw_carrera.insertrow(0)
//			dwc_plan.Retrieve(il_carrera)
//			dw_carrera.setitem(1, "cve_plan", 7)
			dw_mat_inscritas.retrieve(il_cuenta)
		End If
	Else
		Triggerevent("ue_nuevo")
	End If
End If

return 0

end event

event ue_actualiza;call super::ue_actualiza;Integer li_result
String ls_tipo, ls_carrera

li_result = f_obtiene_tipo_ingreso( il_cuenta,  ls_tipo)
If li_result = 0 Then
	li_result = wf_act_carrera_paq()
	If li_result = 0 Then
		wf_actualiza_datos (il_cuenta, il_anio_ing, il_periodo_ing)
	End If
End If


end event

event ue_nuevo;call super::ue_nuevo;dw_aspiran_con_paq.reset( )
dw_aspiran_reingreso.reset( )
dw_5.reset( )
dw_carrera_act.reset( )
dw_carrera.reset( )
dwc_carrera.reset( )
dwc_plan.reset( )
dw_paq_x_materia.reset( )
dw_paquetes_materias.reset( )
dw_carrera_act.insertrow( 0)
dw_carrera.insertrow( 0)

uo_nombre.em_cuenta.text = " "
triggerevent(doubleclicked!)
uo_nombre.cbx_nuevo.visible = true
uo_nombre.cbx_nuevo.enabled = true
uo_nombre.em_digito.text = " "
uo_nombre.dw_nombre_alumno.reset()
uo_nombre.dw_nombre_alumno.insertrow( 0)
dw_mat_inscritas.reset( )
dw_mat_inscritas.insertrow(0)
dw_horario_paquete_visual.reset()
end event

type st_sistema from w_master_main`st_sistema within w_cambia_carrera_paq
integer y = 112
end type

type p_ibero from w_master_main`p_ibero within w_cambia_carrera_paq
integer y = 32
end type

type uo_nombre from uo_nombre_alumno_2013 within w_cambia_carrera_paq
integer x = 960
integer y = 28
integer taborder = 30
boolean bringtotop = true
end type

on uo_nombre.destroy
call uo_nombre_alumno_2013::destroy
end on

type dw_carrera from datawindow within w_cambia_carrera_paq
integer x = 27
integer y = 1412
integer width = 2555
integer height = 224
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_cambio_carrera"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;Integer li_null
Long ll_found

SetNull(li_null)

If This.getcolumnname( ) = "cve_carrera" Then
	This.accepttext( )
	If data <> "" Then
		This.setitem( row, "cve_plan", li_null)
		dwc_plan.Insertrow(0)
		dwc_plan.Retrieve(Long(data))

		If dwc_plan.rowcount( ) > 0 Then
			ll_found = dwc_plan.find( "cve_plan = 7", 1, dwc_plan.rowcount())
			If ll_found > 0 Then
				This.setitem(row, 'cve_plan', 7)
				il_cve_plan = 7
			End If

		End If
		


		
		IF dw_carrera_act.rowcount( ) >0 Then
			il_carrera  = Long(data)
			dw_paq_x_materia.retrieve(il_periodo_ing, il_anio_ing, Long(data))
			If dw_paq_x_materia.rowcount() <= 0 Then
				MessageBox('Mensaje del Sistema', 'No se encontro información de los paquetes para esa carrera elegida...', StopSign!)
			End If
		End If
	End If
End If

If This.getcolumnname( ) = "cve_plan" Then
	dwc_plan.accepttext( )
	il_cve_plan = dwc_plan.getitemnumber( dwc_plan.getrow( ), "cve_plan")
End If

//if dwc_plan.rowcount() = 0 then
//	dwc_plan.Insertrow(0)
//	dwc_plan.Setitem(1,'cve_plan', 0)
//	dwc_plan.Setitem(1,'nombre_plan', 'SIN PLAN')
//end if

end event

type dw_carrera_act from datawindow within w_cambia_carrera_paq
integer x = 27
integer y = 400
integer width = 2834
integer height = 224
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "dw_carrera_actual"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;Integer li_null

SetNull(li_null)

If This.getcolumnname( ) = "cve_carrera" Then
	This.accepttext( )
	If data <> "" Then
		This.setitem( row, "cve_plan", li_null)
		dwc_plan.Insertrow(0)
		dwc_plan.Retrieve(Long(data))
	End If
End If

if dwc_plan.rowcount() = 0 then
	dwc_plan.Insertrow(0)
	dwc_plan.Setitem(1,'cve_plan', 0)
	dwc_plan.Setitem(1,'nombre_plan', 'SIN PLAN')
end if

end event

event retrieveend;long ll_found
long ll_row_actual_carrera
long ll_find = 1, ll_end
long li_carrera
long li_cve_plan

This.accepttext( )

If This.rowcount() > 0 Then
	
	li_carrera = This.getitemnumber( This.getrow(), 'cve_carrera')
	li_cve_plan = This.getitemnumber( This.getrow(), 'cve_plan')
	ll_end = dwc_carrera.RowCount()
	ll_found = dwc_carrera.Find("cve_carrera = " + String(li_carrera), ll_find, ll_end)
	IF ll_found > 0 Then 
		ll_row_actual_carrera = dw_carrera.GetRow()
		dw_carrera.ScrollToRow(ll_row_actual_carrera)
		dw_carrera.SetItem(ll_row_actual_carrera, "cve_carrera", li_carrera)
		dw_carrera.SetItem(ll_row_actual_carrera, "cve_plan", li_cve_plan)
		dwc_carrera.scrolltorow( ll_found )
		dw_carrera.scrolltorow( ll_found )	
		dw_carrera.event itemchanged( ll_found, dw_carrera.object.cve_carrera, string(li_carrera))
	End If	
End If
end event

type dw_paq_x_materia from datawindow within w_cambia_carrera_paq
integer x = 27
integer y = 1652
integer width = 3566
integer height = 1036
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "dw_rep_paq_mat_x_carrera"
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;if getrow()>0 then
	selectrow(0,false)
	selectrow(getrow(),true)
	dw_horario_paquete_visual.reset( )
else
	selectrow(0,false)
end if
end event

event doubleclicked;Integer li_num_paq, li_actualiza_horario

If This.rowcount( ) > 0 and row > 0 Then
	li_num_paq = dw_paq_x_materia.getitemnumber(row, "num_paq")
	dw_paquetes_materias.retrieve(li_num_paq, il_periodo_ing, il_anio_ing)
	li_actualiza_horario = f_actualiza_horario(il_periodo_ing, il_anio_ing, li_num_paq, dw_horario_paquete_visual,false)	
End If
end event

type st_1 from statictext within w_cambia_carrera_paq
integer x = 27
integer y = 1304
integer width = 434
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Nueva Carrera"
boolean focusrectangle = false
end type

type dw_horarios_remedial_mat from datawindow within w_cambia_carrera_paq
boolean visible = false
integer x = 4457
integer y = 364
integer width = 247
integer height = 184
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_horarios_mat_remediales"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_horarios_remedial_esp from datawindow within w_cambia_carrera_paq
boolean visible = false
integer x = 4818
integer y = 364
integer width = 247
integer height = 184
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dw_horarios_mat_remediales"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_aspiran_con_paq from datawindow within w_cambia_carrera_paq
boolean visible = false
integer x = 4475
integer y = 140
integer width = 247
integer height = 184
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dw_asp_con_paq"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_5 from datawindow within w_cambia_carrera_paq
boolean visible = false
integer x = 4535
integer y = 608
integer width = 535
integer height = 280
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dw_aspiran_remediales_inscritas"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_aspiran_reingreso from datawindow within w_cambia_carrera_paq
boolean visible = false
integer x = 4823
integer y = 140
integer width = 247
integer height = 184
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dw_asp_reingreso"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_paquetes_materias from datawindow within w_cambia_carrera_paq
boolean visible = false
integer x = 4425
integer y = 1056
integer width = 160
integer height = 228
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_paquetes_materias"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_mat_inscritas from datawindow within w_cambia_carrera_paq
integer x = 27
integer y = 736
integer width = 2418
integer height = 540
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "dw_mat_inscritas_x_cta"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_cambia_carrera_paq
integer x = 27
integer y = 644
integer width = 517
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Materias Inscritas"
boolean focusrectangle = false
end type

type dw_horario_paquete_visual from datawindow within w_cambia_carrera_paq
integer x = 3689
integer y = 1652
integer width = 1856
integer height = 844
integer taborder = 70
boolean bringtotop = true
boolean titlebar = true
string title = "Horario"
string dataobject = "d_horario_visual_paquete_ext"
boolean vscrollbar = true
boolean resizable = true
borderstyle borderstyle = stylelowered!
end type

