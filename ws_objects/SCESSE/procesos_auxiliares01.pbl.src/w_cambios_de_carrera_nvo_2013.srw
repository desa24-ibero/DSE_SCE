$PBExportHeader$w_cambios_de_carrera_nvo_2013.srw
forward
global type w_cambios_de_carrera_nvo_2013 from w_master_main
end type
type dw_prerrequisitos from uo_master_dw within w_cambios_de_carrera_nvo_2013
end type
type dw_historico_cambio_carr from uo_master_dw within w_cambios_de_carrera_nvo_2013
end type
type dw_revision_est from uo_master_dw within w_cambios_de_carrera_nvo_2013
end type
type uo_1 from uo_per_ani within w_cambios_de_carrera_nvo_2013
end type
type dw_carreras_cursadas from uo_carreras_alumno within w_cambios_de_carrera_nvo_2013
end type
type r_3 from rectangle within w_cambios_de_carrera_nvo_2013
end type
type r_1 from rectangle within w_cambios_de_carrera_nvo_2013
end type
type dw_cam_carr from uo_master_dw within w_cambios_de_carrera_nvo_2013
end type
type st_espere from statictext within w_cambios_de_carrera_nvo_2013
end type
type st_anio from statictext within w_cambios_de_carrera_nvo_2013
end type
type st_per from statictext within w_cambios_de_carrera_nvo_2013
end type
type rr_1 from roundrectangle within w_cambios_de_carrera_nvo_2013
end type
type rr_2 from roundrectangle within w_cambios_de_carrera_nvo_2013
end type
type rr_3 from roundrectangle within w_cambios_de_carrera_nvo_2013
end type
type uo_nombre from uo_nombre_alumno_2013 within w_cambios_de_carrera_nvo_2013
end type
type st_carrera_actual from statictext within w_cambios_de_carrera_nvo_2013
end type
type st_2 from statictext within w_cambios_de_carrera_nvo_2013
end type
type rb_cambio from radiobutton within w_cambios_de_carrera_nvo_2013
end type
type rb_nueva from radiobutton within w_cambios_de_carrera_nvo_2013
end type
type pb_hist_carreras from picturebutton within w_cambios_de_carrera_nvo_2013
end type
type st_1 from statictext within w_cambios_de_carrera_nvo_2013
end type
type gb_1 from groupbox within w_cambios_de_carrera_nvo_2013
end type
end forward

global type w_cambios_de_carrera_nvo_2013 from w_master_main
integer width = 4910
integer height = 3232
string title = "CAMBIO DE CARRERA"
string menuname = "m_cambios_de_carrera_nvo_2013"
boolean controlmenu = false
boolean maxbox = false
dw_prerrequisitos dw_prerrequisitos
dw_historico_cambio_carr dw_historico_cambio_carr
dw_revision_est dw_revision_est
uo_1 uo_1
dw_carreras_cursadas dw_carreras_cursadas
r_3 r_3
r_1 r_1
dw_cam_carr dw_cam_carr
st_espere st_espere
st_anio st_anio
st_per st_per
rr_1 rr_1
rr_2 rr_2
rr_3 rr_3
uo_nombre uo_nombre
st_carrera_actual st_carrera_actual
st_2 st_2
rb_cambio rb_cambio
rb_nueva rb_nueva
pb_hist_carreras pb_hist_carreras
st_1 st_1
gb_1 gb_1
end type
global w_cambios_de_carrera_nvo_2013 w_cambios_de_carrera_nvo_2013

type variables
long     Cuenta
Integer CarreraActual
integer PlanActual
integer subsistemaActual
integer ii_periodo, ii_anio //se colocan estas variables para actualizar el valor de Inscripción de Posgrado al UO_1
Char     NIvelActual
integer ii_cve_formaingreso  

STRING is_carrera

n_security_valores_objeto i_n_security_valores_objeto
datawindowchild idddw_child
Datawindowchild dwc_subsis, dwc_carrera, dwc_plan, dwc_formaing
Datawindowchild dwc_periodo
uo_periodo_servicios iuo_periodo_servicios

uo_academicos_servicios iuo_academicos_servicios



end variables

forward prototypes
public function boolean actualiza_academ_banderas (long cuenta_academ, integer carrera_academ, integer plan_academ, character nivel_academ)
public function boolean inserta_hist_carreras (long cuenta_hist_carr, integer ingreso_hist_carr, integer carr_ant_hist_carr, integer plan_ant_hist_carr, integer carr_act_hist_carr, integer plan_act_hist_carr, integer periodo_hist_carr, long anio_hist_carr, integer subsis_ant, integer subsis_act, real ar_promedio_ant, integer ai_sem_cursados_ant, integer ai_creditos_cursados_ant, integer ai_egresado_ant, integer ai_periodo_egre_ant, integer ai_anio_egre_ant, integer ai_periodo_ing_act, integer ai_anio_ing_act, integer ai_cve_formaingreso_ant)
public function boolean insertar_academicos_hist (long an_cuenta, integer an_carrera, integer an_plan)
public function boolean revalida_materias (long cuenta_hist, integer carrera_nueva, integer plan_nuevo, string nivel, integer cve_carrera_ant, integer cve_plan_ant)
public function boolean wf_es_egresado (long al_cuenta, integer ai_carrera, integer ai_plan, integer ai_subsistema, string as_nivel)
public function integer wf_validar ()
public subroutine wf_limpiar ()
public function integer wf_filtra_carreras ()
public function boolean wf_despliega_carrera (long al_cve_carrera, long al_id_carrera)
end prototypes

public function boolean actualiza_academ_banderas (long cuenta_academ, integer carrera_academ, integer plan_academ, character nivel_academ);// Actualiza la tabla de academicos en sus campos de , promedio y creditos.
// y de acuerdo al nuevo promedio y los nuevos creditos,  se actualiza:
// flag_promedio, Flag_75%, Flag_sevicio_social,Inscrito_sem_ant,Prerrequisito_ingles,Area_integracion
// Si la actualización es existosa la función regresa "True"
// Juan Campos. Abril-1997.

Int     Carrera, Plan, CveFlagPromedio,CveFlagServSocial,InscritoAnterior
Decimal creditos 
Int     CreditosServicioSocial,CreditosPuntaje, li_sem_cursados, li_cve_flag_promedio
Real    promedio,PuntajeMinimo
Char    NivelAcademico
Boolean lb_PromCredOk, lb_ActualizaBanderas, lb_Banderas, lb_academicos, lb_actualice_3r_y_4i
Int li_cve_flag_serv_social, li_puede_integracion, li_egresado
Boolean lb_Sem_anterior, lb_flagpromediook, lb_cred_ss_integrac_ok
Integer li_materias_en_historico
lb_PromCredOk = False
lb_Banderas   = False
lb_ActualizaBanderas = False
lb_academicos  = False
li_cve_flag_promedio = 0
li_egresado = 0
lb_Sem_anterior = False
lb_flagpromediook = False
lb_cred_ss_integrac_ok = False
DECLARE Emp_proc procedure for calcula_promedio
	@cuenta   = :cuenta_academ,
	@cve_carr = :carrera_academ, 
 	@plan     = :plan_academ,
 	@promedio = :promedio out, 
 	@creditos = :creditos out using gtr_sce;
   	
EXECUTE Emp_proc ;
If gtr_sce.Sqlcode <> 0 Then
	Goto Error
End IF
FETCH Emp_proc INTO :promedio,:creditos;
If gtr_sce.Sqlcode <> 0 Then
	Goto Error
End IF
CLOSE Emp_proc;
If gtr_sce.Sqlcode <> 0 Then
	Goto Error
End IF

if isnull(promedio) then promedio = 0
if isnull(creditos) then creditos = 0

//Actualizacion del promedio y los creditos
UPDATE academicos
   SET promedio = :promedio , creditos_cursados = CONVERT(INT,:creditos)
 WHERE cuenta = :cuenta_academ
 USING gtr_sce;

IF gtr_sce.sqlcode = 0 Then   
	commit using gtr_sce;			//aaa
	lb_PromCredOk = True
	lb_actualice_3r_y_4i= actualiza_bandera(cuenta_academ,1)		//aaa
	If not lb_actualice_3r_y_4i Then
		MessageBox("Error","Al modificar 3 reprobadas y 4 inscritas de este alumno")			
		lb_PromCredOk  = False
	End If
ElseIf gtr_sce.sqlcode = 100 Then
 	lb_PromCredOk  = False
	MessageBox("Error","Al modificar el promedio y los creditos de este alumno")	
ElseIf gtr_sce.sqlcode = -1 Then 
	lb_PromCredOk  = False
	MessageBox("Error al actualizar el promedio",gtr_sce.sqlerrtext)
Else
	lb_PromCredOk  = False
End If

If lb_PromCredOk Then
	li_sem_cursados=f_obten_periodos_cursados(cuenta_academ, carrera_academ, plan_academ)
	if li_sem_cursados = -1 then
		lb_academicos  = False
		MessageBox("Error al calcular los periodos cursados",gtr_sce.sqlerrtext)
	else
		lb_academicos  = True
	end if	
End if

If lb_academicos then	
// Actualizacion de academicos
	If ii_cve_formaingreso = 1 then
		//PARA CAMBIO DE CARRERA NO DEBE MOVERSE EL PERIODO DE INGRESO
		UPDATE academicos
	  	 SET cve_subsistema = 0 , 
			 sem_cursados = :li_sem_cursados,
	  	 	 periodo_egre = 0 , 
	   	 cve_formaingreso = :ii_cve_formaingreso,
			 egresado = :li_egresado
	 	WHERE cuenta = :cuenta_academ
		 USING gtr_sce;	 
	ElseIF ii_cve_formaingreso = 2 OR ii_cve_formaingreso = 8 then
		//PARA NUEVA CARRERA Y ADMISION POSGRADO  DEBE MOVERSE EL PERIODO DE INGRESO
		UPDATE academicos
	  	 SET cve_subsistema = 0 , 
			 sem_cursados = :li_sem_cursados,
	  	 	 periodo_egre = 0 , 
	   	 cve_formaingreso = :ii_cve_formaingreso,
			 egresado = :li_egresado,
			 anio_ing = :gi_anio,
			 periodo_ing = :gi_periodo
	 	WHERE cuenta = :cuenta_academ
		 USING gtr_sce;		
	End if

	IF gtr_sce.sqlcode = 0 Then   
		commit using gtr_sce;			
		lb_academicos = True
	ElseIf gtr_sce.sqlcode = 100 Then
	 	lb_academicos  = False
		MessageBox("Error","Al modificar academicos de este alumno")	
	ElseIf gtr_sce.sqlcode = -1 Then 
		lb_academicos  = False
		MessageBox("Error al actualizar academicos",gtr_sce.sqlerrtext)
	Else
		lb_academicos  = False
	End If
End If

// Obten el puntaje minimo para determinar si estaria amonestado por promedio 			
If lb_academicos Then 
   SELECT puntaje_min,cred_serv_social,cred_puntaje 
     INTO :PuntajeMinimo,:CreditosServicioSocial,:CreditosPuntaje
     FROM plan_estudios
    WHERE (cve_carrera = :carrera_academ) and
	       (cve_plan    = :plan_academ)
   USING gtr_sce;	
	
   IF gtr_sce.sqlcode = 0 Then  
	   SELECT insc_sem_ant,cve_flag_promedio,cve_flag_serv_social
        INTO :InscritoAnterior,:CveFlagPromedio,:CveFlagServSocial
        FROM banderas
       WHERE cuenta = :cuenta_academ
       USING gtr_sce;	
	   IF gtr_sce.sqlcode = 0 Then 
		   lb_Banderas = True
	   ElseIf gtr_sce.sqlcode = 100 Then 
		   lb_Banderas = False
		   MessageBox("Error ","Al obtener banderas de este alumno")
	   ElseIf gtr_sce.sqlcode = -1 Then
		   lb_Banderas = False
		   MessageBox("Error",gtr_sce.sqlerrtext)
	   Else  
		   lb_Banderas = False
	   End if
   Else
 	   lb_Banderas = False
	   MessageBox("Error al obtener banderas de este alumno ",gtr_sce.sqlerrtext)
   End If
End if




If lb_Banderas Then 
	lb_ActualizaBanderas = True
	
	If InscritoAnterior = 0 Then  // 0 = InscritoAnterior No
	   UPDATE banderas
         SET insc_sem_ant = 1    // 1 = InscritoAnterior Si
       WHERE cuenta = :cuenta_academ
       USING gtr_sce;
	   IF gtr_sce.sqlcode = -1  Then  
			lb_ActualizaBanderas  = False
	   	MessageBox("Error","No se actualizo la bandera de: Inscrito_Semestre_Anterior. "+gtr_sce.sqlerrtext)
			lb_Sem_anterior = False
		Else 
			lb_Sem_anterior = True
		End If	
	Else
		lb_Sem_anterior = True
	end if
End if

//En base al promedio calculado  de la nueva carrera, hay que amonestar o desamonestar
If	lb_Sem_anterior Then
	
		li_materias_en_historico = f_materias_en_historico(cuenta_academ, carrera_academ, plan_academ)
		IF li_materias_en_historico = -1 THEN
 	      	lb_ActualizaBanderas  = False
	      	MessageBox("Error","No se actualizo la bandera de: flag_promedio.", StopSign!)
				lb_flagpromediook = false
		END IF
         IF li_materias_en_historico = 0 Then 				
				li_cve_flag_promedio = 0				
         ElseIF promedio >= PuntajeMinimo Then 				
				li_cve_flag_promedio = 0				
			Else
				li_cve_flag_promedio = 1
			End if
	     	UPDATE banderas
         	SET cve_flag_promedio = :li_cve_flag_promedio   // Normal
         WHERE cuenta = :cuenta_academ
         USING gtr_sce;
		   IF gtr_sce.sqlcode = -1 Then   
 	      	lb_ActualizaBanderas  = False
	      	MessageBox("Error","No se actualizo la bandera de: flag_promedio. "+gtr_sce.sqlerrtext)
				lb_flagpromediook = false
			Else
				lb_flagpromediook = true
  		  	End if	
End if

If lb_flagpromediook Then

//En base a los creditos calculados  de la nueva carrera, hay determinar 
//si ya puede cursar el servicio social

	   IF creditos >= CreditosServicioSocial Then 
			li_cve_flag_serv_social = 1
		Else
			li_cve_flag_serv_social = 0
		End if

//En base a los creditos calculados  de la nueva carrera, hay determinar si ya puede cursar 
//materias de integracion

	   IF creditos >= 72 Then 
			li_puede_integracion = 1
		Else
			li_puede_integracion = 0
		End if
		
	   UPDATE banderas
        	SET cve_flag_serv_social = :li_cve_flag_serv_social,  
        	    puede_integracion = :li_puede_integracion  
      WHERE cuenta = :cuenta_academ
      USING gtr_sce;
		IF gtr_sce.sqlcode = -1 Then   
 	     	lb_ActualizaBanderas  = False
	     	MessageBox("Error","No se actualizaron las bandera de: flag_serv_social, puede_integracion. "+gtr_sce.sqlerrtext)
		  lb_cred_ss_integrac_ok = false
		Else
		  lb_cred_ss_integrac_ok = true		
      End If
		
End If
			 
if lb_cred_ss_integrac_ok then
	return true
end if

Error:
  Messagebox("Ocurrio un Error",gtr_sce.sqlerrtext)
  Rollback Using gtr_sce;
  Return False
	  	  
end function

public function boolean inserta_hist_carreras (long cuenta_hist_carr, integer ingreso_hist_carr, integer carr_ant_hist_carr, integer plan_ant_hist_carr, integer carr_act_hist_carr, integer plan_act_hist_carr, integer periodo_hist_carr, long anio_hist_carr, integer subsis_ant, integer subsis_act, real ar_promedio_ant, integer ai_sem_cursados_ant, integer ai_creditos_cursados_ant, integer ai_egresado_ant, integer ai_periodo_egre_ant, integer ai_anio_egre_ant, integer ai_periodo_ing_act, integer ai_anio_ing_act, integer ai_cve_formaingreso_ant);// hace un insert a la tabla de hist_carreras, consulta que no este repetido 
// para el mismo periodo y año. Regresa "True" si el insert es exitoso.
// Juan Campos. Abril-1997.

integer li_existe, li_res_sql, li_periodo_ant, li_anio_ant, li_periodo_act, li_anio_act, li_confirmacion
boolean lb_movimientoOk, lb_es_egresado
string ls_nivel_ant, ls_nivel_act,ls_mensaje_sql, ls_confirmacion
decimal ld_promedio, ldc_creditos

li_periodo_act= gi_periodo
li_anio_act= gi_anio

select count(*)
into	:li_existe
from	hist_carreras
where (cuenta          = :cuenta_hist_carr) and
		(periodo_ing_act = :li_periodo_act) and
		(anio_ing_act    = :li_anio_act) and
		(cve_carrera_act = :carr_act_hist_carr) and
		(cve_plan_act    = :plan_act_hist_carr) and
		(cve_carrera_ant = :carr_ant_hist_carr) and
		(cve_plan_ant    = :plan_ant_hist_carr)
		using gtr_sce;

li_res_sql = gtr_sce.sqlcode


if li_existe>0 then
	ls_confirmacion = "El alumno ya tiene un cambio de la misma carrera anterior ~n a la misma carrera actual con el mismo periodo actual~n"&
							+ "¿Aún así desea realizar el cambio?"	
	li_confirmacion = MessageBox("Confirmación", ls_confirmacion, Question!, YesNo!)
	if li_confirmacion <> 1 then
		MessageBox("Cancelación", "No se ha realizado el cambio de carrera",Information!)
		return false
	else
		li_existe=0
	end if
end if
	
		
ls_nivel_ant = f_obten_nivel(carr_ant_hist_carr)
ls_nivel_act = f_obten_nivel(carr_act_hist_carr)


if li_res_sql =-1 Then
	lb_movimientoOk = False
	Messagebox("Error al consultar historico carreras",gtr_sce.sqlerrtext)
elseif li_res_sql = 0 or li_res_sql = 100 then
	lb_movimientoOk = True
End if 

if isnull(subsis_ant) then subsis_ant = 0
if isnull(subsis_act) then subsis_act = 0

lb_es_egresado= wf_es_egresado(cuenta_hist_carr, carr_ant_hist_carr, plan_ant_hist_carr, subsis_ant, ls_nivel_ant)

if lb_es_egresado then
	ai_egresado_ant=1
	f_obten_promedio_creditos(cuenta_hist_carr, carr_ant_hist_carr, plan_ant_hist_carr, ld_promedio, ldc_creditos)
	ar_promedio_ant=ld_promedio
	ai_creditos_cursados_ant=Integer(ldc_creditos)
	li_periodo_ant= gi_periodo
	li_anio_ant= gi_anio
	f_obten_periodo_ant_sv(li_periodo_ant, li_anio_ant)	
	ai_periodo_egre_ant=li_periodo_ant
	ai_anio_egre_ant=li_anio_ant

else
	ai_egresado_ant=0	
end if


if lb_movimientoOk Then
	if li_existe = 0 or li_res_sql = 100 then		
 		Insert Into dbo.hist_carreras (cuenta, 
		                           cve_formaingreso,
											cve_carrera_ant, 
											cve_plan_ant,
											cve_subsistema_ant,
											cve_carrera_act,
											cve_plan_act,
											cve_subsistema_act,
											periodo_ing,
											anio_ing,
											promedio_ant,
											sem_cursados_ant,
											creditos_cursados_ant,
											egresado_ant,
											periodo_egre_ant,
											anio_egre_ant,
											nivel_ant,
											nivel_act,
											periodo_ing_act,
											anio_ing_act,
											cve_formaingreso_ant)
											values (:Cuenta_hist_carr,
		                                  :ingreso_hist_carr,
													 :carr_ant_hist_carr,
													 :plan_ant_hist_carr,
													 :subsis_ant, 
													 :carr_act_hist_carr,
													 :plan_act_hist_carr,
													 :subsis_act,
													 :Periodo_hist_carr,
													 :anio_hist_carr,
													 :ar_promedio_ant,
													 :ai_sem_cursados_ant,
													 :ai_creditos_cursados_ant,
													 :ai_egresado_ant,
													 :ai_periodo_egre_ant,
													 :ai_anio_egre_ant,
													 :ls_nivel_ant,
													 :ls_nivel_act,
													 :li_periodo_act,
													 :li_anio_act,
													 :ai_cve_formaingreso_ant)
		Using gtr_sce;	
		li_res_sql = gtr_sce.sqlcode
		ls_mensaje_sql = gtr_sce.sqlerrtext
		
		if li_res_sql = 0 Then		
			commit using gtr_sce;
		   lb_movimientoOk = True
	   Elseif li_res_sql= -1 then
			rollback using gtr_sce;
         lb_movimientoOk = False
			MessageBox("Error al actualizar la tabla de hist_carreras",ls_mensaje_sql)
		end if
	else
		lb_movimientoOk = False
		Messagebox("Error","El alumno ya tiene registrado un movimiento de carrera para el periodo proximo, Revise el historico de carreras de este alumno")
	end if
end if
												
if lb_movimientoOk Then
	Return True
else
	Return False
end if
end function

public function boolean insertar_academicos_hist (long an_cuenta, integer an_carrera, integer an_plan);int li_reg		
string ls_mensaje_sql
datetime ldt_fec_servidor
		
select count(*)
		into :li_reg
	from academicos_hist
	where cuenta = :an_cuenta and
			cve_carrera = :an_carrera and
			cve_plan = :an_plan
			using gtr_sce;
if li_reg = 0 then //si no lo encuentra lo inserta en academicos_hist
	insert  academicos_hist (cuenta,   
	         						cve_carrera,   
    									cve_plan,   
    									cve_subsistema,   
    									nivel,   
    									promedio,   
    									sem_cursados,   
    									creditos_cursados,   
    									egresado,   
    									periodo_ing,   
    									anio_ing,   
    									periodo_egre,   
    									anio_egre,   
    									cve_formaingreso,   
    									ceremonia_mes,   
    									ceremonia_anio  )
		select * 
			from academicos
			where cuenta = :an_cuenta and
					cve_carrera = :an_carrera and
					cve_plan = :an_plan
			using gtr_sce;
					
		li_reg = gtr_sce.sqlcode
		ls_mensaje_sql = gtr_sce.sqlerrtext
		
		if li_reg = 0 Then		
			commit using gtr_sce;
	   Elseif li_reg= -1 then
			rollback using gtr_sce;
			MessageBox("Error al actualizar la tabla de academicos_hist",ls_mensaje_sql)
		end if
		
		ldt_fec_servidor = datetime(f_obten_fecha_servidor() )
		update academicos_hist
			set vigente = 0
			where cuenta = :an_cuenta
		using gtr_sce;
		update academicos_hist
			set vigente = 1,
				fec_modif = :ldt_fec_servidor,
				usuario_modif = :gs_usuario
			where cuenta = :an_cuenta and
					cve_carrera = :an_carrera and
					cve_plan = :an_plan
		using gtr_sce;
		
end if
		
if li_reg < 0 Then
	Return False
else 
	Return true
end if


end function

public function boolean revalida_materias (long cuenta_hist, integer carrera_nueva, integer plan_nuevo, string nivel, integer cve_carrera_ant, integer cve_plan_ant);// Juan Campos. Abril-1997.
// Revalida las materias que sean de la misma carrera y plan
// Modificado. Marzo-1998.


DataStore dw_mat_prerrequisito
dw_mat_prerrequisito = CREATE DataStore
integer li_codigo_sql
string ls_mensaje_sql

//If Nivel = 'L' Then 
If Nivel <> 'P' Then 
	dw_mat_prerrequisito.DataObject = "dw_mat_prerrequisito"
Else
	dw_mat_prerrequisito.DataObject = "dw_mat_prerrequisito_pos"
End if
dw_mat_prerrequisito.Settransobject(gtr_sce) 
dw_historico_cambio_carr.Settransobject(gtr_sce) 

Long  i, MateriaHist 
Integer Per,Año,Obs,Existe
String Gpo,Calif
INTEGER le_existe_ing, le_existe_ss

IF dw_historico_cambio_carr.retrieve(cuenta_hist) > 0 Then
  For i = 1 to dw_historico_cambio_carr.RowCount()
		MateriaHist = dw_historico_cambio_carr.GetItemNumber(i,"cve_mat")
		
		//**--**
		// Se Verifica si la materia corresponde a servicio social o a inglés 
		// Se verifica si la materia es inglés 
		SELECT COUNT(*) 
		INTO :le_existe_ing 
		FROM materias_requisito 
		WHERE id_prerrequisito = 'ING'	 
		AND cve_mat = :MateriaHist 
		USING gtr_sce; 
		IF ISNULL(le_existe_ing) THEN le_existe_ing = 0		
		
		// Se verifica si la materia es de SS 
		SELECT COUNT(*) 
		INTO :le_existe_ss 
		FROM area_mat am 
		WHERE am.cve_mat = :MateriaHist
		AND am.cve_area IN(SELECT pe.cve_area_servicio_social 
								FROM plan_estudios pe
								WHERE  pe.cve_carrera = :carrera_nueva
								AND pe.cve_plan = :plan_nuevo)		
		USING gtr_sce; 			
		IF ISNULL(le_existe_ss) THEN le_existe_ss = 0
								
		
		//**--**
		
		//IF MateriaHist = 3748 OR MateriaHist = 8763 Then		
		IF le_existe_ss > 0 THEN 
			//Ojo No Incluye a el servicio social			
		Else
         //IF (MateriaHist = 4078) or & 
		  IF (le_existe_ing > 0) or &  
		 	   (dw_mat_prerrequisito.Retrieve(MateriaHist,Carrera_Nueva,Plan_Nuevo) > 0) Then // Si es mayor a cero, la materia si pertenece a la carrera y plan nuevo
				If f_curso_prerrequisitos(Cuenta_hist,MateriaHist,Carrera_nueva,Plan_Nuevo,Nivel,cve_carrera_ant,cve_plan_ant)=1 Then 
					Gpo   = dw_historico_cambio_carr.GetItemString(i,"gpo")
					Per   = dw_historico_cambio_carr.GetItemNumber(i,"periodo")
					Año   = dw_historico_cambio_carr.GetItemNumber(i,"anio")
					calif = dw_historico_cambio_carr.GetItemString(i,"calificacion")
   				Obs	= dw_historico_cambio_carr.GetItemNumber(i,"observacion")
					Existe = 0
					Select count(*)
						Into :Existe
						From historico
						Where cuenta       = :Cuenta_hist And
								cve_mat      = :MateriaHist And
								cve_carrera  = :Carrera_Nueva And
								cve_plan 			 = :plan_nuevo And
								gpo          = :Gpo And
								periodo      = :Per And
								anio         = :Año And
								calificacion = :Calif using gtr_sce;
					If Isnull(Existe) Then Existe = 0
					If Existe = 0 Then
						IF IsNull(Gpo) or Gpo = "" Then
		         		Insert Into historico 
								values (:Cuenta_hist,:MateriaHist,Null,:Per,:Año,:Carrera_Nueva,:Plan_Nuevo,:Calif,:Obs) using gtr_sce;
            		Else
		         		Insert Into historico 
								values (:Cuenta_hist,:MateriaHist,:Gpo,:Per,:Año,:Carrera_Nueva,:Plan_Nuevo,:calif,:Obs) using gtr_sce;							
						End IF	
						li_codigo_sql = gtr_sce.SqlCode						
						ls_mensaje_sql = gtr_sce.SqlErrText
						if li_codigo_sql = -1 then
							rollback using gtr_sce;
							MessageBox("Error al insertar en historico",ls_mensaje_sql)
							return false
						else
							commit using gtr_sce;					
						end if
					End If 
				End if
			End If
		End IF	
  Next
Else
	Messagebox("No se encontro la historia del alumno","El alumno no tiene información en histórico")
	return false
End if	
	
Return True	

end function

public function boolean wf_es_egresado (long al_cuenta, integer ai_carrera, integer ai_plan, integer ai_subsistema, string as_nivel);integer li_pend_creditos, li_pend_opcion_terminal,li_pend_servicio_social, li_row, li_rows_revision
integer li_cred_minimos, li_cred_cursados
li_pend_creditos =0

dw_revision_est.Reset()

li_rows_revision= dw_revision_est.Rowcount()
for li_row = 1 to li_rows_revision
	li_cred_minimos = dw_revision_est.GetItemNumber(li_row,"minimos")
	li_cred_cursados = dw_revision_est.GetItemNumber(li_row,"cursados")
	//Si le faltan créditos y no son de 3 (opcion terminal) ni de 4 (servicio social) 
	if li_cred_cursados < li_cred_minimos  then
		li_pend_creditos = 1
		exit
	end if
next

if li_pend_creditos = 1 then
	return false
else
	return true
end if


end function

public function integer wf_validar ();//long ll_code_seleccionado
integer li_cve_formaingreso,li_creditos_cursados,li_cve_carrera,li_cve_plan
decimal ldc_creditos_totales_plan
string ls_nivel_act,ls_nivel_ant, ls_nivel_carrera

li_cve_formaingreso = dw_cam_carr.GetItemNumber(1,"cve_formaingreso",Primary!,false)
li_creditos_cursados	= dw_cam_carr.GetItemNumber(1,"creditos_cursados",Primary!,True)	

ls_nivel_ant			 = dw_cam_carr.GetItemString(1,"nivel",Primary!,true)
ls_nivel_act			 = dw_cam_carr.GetItemString(1,"nivel",Primary!,false)
li_cve_carrera		 = dw_cam_carr.GetItemNumber(1,"cve_carrera",Primary!,false)
li_cve_plan			 = dw_cam_carr.GetItemNumber(1,"cve_plan",Primary!,false)

if dw_cam_carr.Getitemnumber(1,'periodo_ing') = 1 then
	IF messagebox('Aviso','El periodo seleccionado es "VERANO", ¿desea continuar?',Question!,Yesno!) = 2 then
		return -1
	end if
end if

Select cred_total 
Into	:ldc_creditos_totales_plan
From	plan_estudios 
Where	cve_carrera	= :li_cve_carrera And 
		    cve_plan	= :li_cve_plan using gtr_sce;

//Where	cve_carrera	= :CarreraActual And 
//		cve_plan		= :PlanActual using gtr_sce;
		
If gtr_sce.sqlcode <> 0 Then
	Messagebox("Error al consultar plan de estudios",gtr_sce.sqlerrtext)
	Return -1
End if

If isnull(li_cve_formaingreso) Then
	Messagebox("Seleccionar forma de ingreso","No ha elegido la forma de ingreso o~n"+&
			"el usuario firmado no está autorizado para efectuar un cambio.", StopSign!)
	Return -1
End IF

Select nivel
Into :ls_nivel_carrera
From carreras
Where cve_carrera = :li_cve_carrera using gtr_sce;


IF ls_nivel_carrera <> 'P' AND li_cve_formaingreso = 8 THEN 
	Messagebox("La carrera es de otro nivel académico","Revise el nivel académico de las carreras segun la forma de ingreso")
	dw_cam_carr.setcolumn("cve_carrera")
	Return -1
END IF

//if ls_nivel_ant <> ls_nivel_act then
IF ls_nivel_act <> 	ls_nivel_carrera THEN 
	Messagebox("La carrera es de otro nivel académico","Revise el nivel académico de las carreras")
	dw_cam_carr.setcolumn("cve_carrera")
	Return -1
end if

//if ((li_cve_carrera = CarreraActual) OR (li_cve_plan = PlanActual))Then
if ((li_cve_carrera = CarreraActual) AND (li_cve_plan = PlanActual))Then	
	Messagebox('Aviso',"La carrera es la misma que actualmente tiene inscrita, ~rIntenta de nuevo")
	dw_cam_carr.Setcolumn("cve_Carrera")			
	Return -1
End If

If (li_cve_formaingreso = 1) or &
   (li_cve_formaingreso = 2 And li_creditos_cursados >= ldc_creditos_totales_plan) or &
	(li_cve_formaingreso = 8) then		
		return 1
else 
	Messagebox("Aviso","Forma de Ingreso Invalida para Cambio de carrera", StopSign!)
	Return -1
end if

return 1
end function

public subroutine wf_limpiar ();dw_cam_carr.Reset()
dw_carreras_cursadas.Reset()
end subroutine

public function integer wf_filtra_carreras ();
STRING ls_carreras 
DATAWINDOWCHILD ldwc_carreras 

// Se genera la cadena de selección 
ls_carreras = " SELECT carreras.cve_carrera,   " + & 
         " carreras.carrera, " + &    
         " carreras.nivel, " + &    
         " carreras.cve_coordinacion, " + &    
         " carreras.num_simpl_admva_sep, " + &    
         " carreras.cve_grado, " + &    
         " carreras.carrera_sin_prefijo, " + &    
         " carreras.nombre_minusculas, " + &    
         " carreras.activa_1er_ing " 


IF rb_cambio.CHECKED THEN 
	// Si se trata de un cambio de carrera se filtran las carreras que ha cursado el alumno 
	ls_carreras = ls_carreras + & 						 
					", hist_carreras.id_carrera " + & 
					 " FROM carreras " + & 
					" , hist_carreras " + & 
					" WHERE hist_carreras.cve_carrera_act = carreras.cve_carrera " + &  
					" AND hist_carreras.cuenta = " + STRING(Cuenta) 
					 
	if dw_cam_carr.retrieve(long(uo_nombre.of_obten_cuenta())) = 0 then
		dw_cam_carr.insertrow(0)
		uo_nombre.em_cuenta.setfocus()	
	end if						 
					 
ELSEIF rb_nueva.CHECKED THEN 
	
	ls_carreras = ls_carreras + ", 0 as id_carrera FROM carreras WHERE carreras.cve_carrera > 0 "	 
	
END IF 

dw_cam_carr.GETCHILD("cve_carrera", ldwc_carreras)  
ldwc_carreras.MODIFY("Datawindow.Table.Select = '" + ls_carreras + "'" ) 
ldwc_carreras.SETTRANSOBJECT(gtr_sce)
ldwc_carreras.RETRIEVE() 

RETURN 0 



//	ls_carreras = ls_carreras + & 	
//					 " , academicos_hist " + & 
//					 " WHERE academicos_hist.cve_carrera = carreras.cve_carrera " + &  
//					 " AND academicos_hist.cuenta = " + STRING(Cuenta) 



end function

public function boolean wf_despliega_carrera (long al_cve_carrera, long al_id_carrera);
INTEGER le_ttl_rows
INTEGER le_row  
STRING ls_query, ls_busqueda  
BOOLEAN lb_carrera_nueva 

// Se verifica si la carrera ya esta cursada. 
ls_busqueda = "hist_carreras_cve_carrera_act = " + STRING(al_cve_carrera) + " AND hist_carreras_id_carrera = " + STRING(al_id_carrera)  
le_row = dw_carreras_cursadas.FIND(ls_busqueda, 0, dw_carreras_cursadas.ROWCOUNT())
IF le_row > 0 THEN 

	// Si ya esta cursada se toma la información de academicos_hist 
	ls_query = " SELECT hist_carreras.cuenta,  " + & 
				"   hist_carreras.periodo_ing_act,  " + &  
				"   hist_carreras.anio_ing_act,  " + &  
				"   hist_carreras.cve_formaingreso,  " + &  
				"   hist_carreras.cve_carrera_act,  " + &  
				"   hist_carreras.cve_plan_act,  " + &  
				"   hist_carreras.cve_subsistema_act,  " + &  
				"   hist_carreras.nivel_act,  " + &  
				"   hist_carreras.promedio_act,  " + &  
				"   hist_carreras.sem_cursados_act,  " + &  
				"   hist_carreras.creditos_cursados_act,  " + &  
				"   hist_carreras.egresado_act,  " + &  
				"   hist_carreras.periodo_egre_act,  " + &  
				"   hist_carreras.anio_egre_act,  " + &  
				"   hist_carreras.ceremonia_mes,  " + &  
				"   hist_carreras.ceremonia_anio  " + &   
				" FROM hist_carreras  " + & 
				" WHERE hist_carreras.cuenta =  " + STRING(Cuenta)  + &  
				" AND hist_carreras.cve_carrera_act = " + STRING(al_cve_carrera) + & 
				" AND hist_carreras.id_carrera = " + STRING(al_id_carrera) 

	dw_cam_carr.MODIFY("Datawindow.Table.Select = '" + ls_query + "'" ) 
	le_ttl_rows = dw_cam_carr.Retrieve(al_cve_carrera)  

	// Si no se ha cursado la carrera. 
	IF le_ttl_rows <= 0 THEN 
		lb_carrera_nueva = TRUE 
	ELSE 
		RETURN TRUE 
	END IF 

ELSE
	lb_carrera_nueva = TRUE 
END IF 


// Si se ingresa a una nueva carrera 
IF lb_carrera_nueva THEN 
	
	INTEGER le_plan_ofertado 
	STRING ls_nivel 

	SELECT cve_plan_ofertado, nivel 
	INTO :le_plan_ofertado, :ls_nivel 
	FROM carreras 
	WHERE cve_carrera = :al_cve_carrera
	USING gtr_sce; 

	dw_cam_carr.SETITEM(1, "cuenta", Cuenta) 
	dw_cam_carr.SETITEM(1, "periodo_ing", gi_periodo) 
	dw_cam_carr.SETITEM(1, "anio_ing", gi_anio)  
//	dw_cam_carr.SETITEM(1, "cve_formaingreso", ) 
	dw_cam_carr.SETITEM(1, "cve_carrera", al_cve_carrera) 
	dw_cam_carr.SETITEM(1, "cve_plan", le_plan_ofertado) 
//	dw_cam_carr.SETITEM(1, "cve_subsistema", ) 
	dw_cam_carr.SETITEM(1, "nivel", ls_nivel) 
	dw_cam_carr.SETITEM(1, "promedio", 0) 
	dw_cam_carr.SETITEM(1, "sem_cursados", 0) 
	dw_cam_carr.SETITEM(1, "creditos_cursados", 0) 
	dw_cam_carr.SETITEM(1, "egresado", 0) 
	dw_cam_carr.SETITEM(1, "periodo_egre", 0) 
	dw_cam_carr.SETITEM(1, "anio_egre", 0) 
	dw_cam_carr.SETITEM(1, "ceremonia_mes", 0) 
	dw_cam_carr.SETITEM(1, "ceremonia_anio", 0) 

END IF 

RETURN TRUE 


//cuenta
//periodo_ing
//anio_ing
//cve_formaingreso
//cve_carrera
//cve_plan
//cve_subsistema
//nivel
//promedio
//sem_cursados
//creditos_cursados
//egresado
//periodo_egre
//anio_egre
//ceremonia_mes
//ceremonia_anio 


end function

event activate;call super::activate;control_escolar.toolbarsheettitle="Cambios de Carrera"
end event

on w_cambios_de_carrera_nvo_2013.create
int iCurrent
call super::create
if this.MenuName = "m_cambios_de_carrera_nvo_2013" then this.MenuID = create m_cambios_de_carrera_nvo_2013
this.dw_prerrequisitos=create dw_prerrequisitos
this.dw_historico_cambio_carr=create dw_historico_cambio_carr
this.dw_revision_est=create dw_revision_est
this.uo_1=create uo_1
this.dw_carreras_cursadas=create dw_carreras_cursadas
this.r_3=create r_3
this.r_1=create r_1
this.dw_cam_carr=create dw_cam_carr
this.st_espere=create st_espere
this.st_anio=create st_anio
this.st_per=create st_per
this.rr_1=create rr_1
this.rr_2=create rr_2
this.rr_3=create rr_3
this.uo_nombre=create uo_nombre
this.st_carrera_actual=create st_carrera_actual
this.st_2=create st_2
this.rb_cambio=create rb_cambio
this.rb_nueva=create rb_nueva
this.pb_hist_carreras=create pb_hist_carreras
this.st_1=create st_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_prerrequisitos
this.Control[iCurrent+2]=this.dw_historico_cambio_carr
this.Control[iCurrent+3]=this.dw_revision_est
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.dw_carreras_cursadas
this.Control[iCurrent+6]=this.r_3
this.Control[iCurrent+7]=this.r_1
this.Control[iCurrent+8]=this.dw_cam_carr
this.Control[iCurrent+9]=this.st_espere
this.Control[iCurrent+10]=this.st_anio
this.Control[iCurrent+11]=this.st_per
this.Control[iCurrent+12]=this.rr_1
this.Control[iCurrent+13]=this.rr_2
this.Control[iCurrent+14]=this.rr_3
this.Control[iCurrent+15]=this.uo_nombre
this.Control[iCurrent+16]=this.st_carrera_actual
this.Control[iCurrent+17]=this.st_2
this.Control[iCurrent+18]=this.rb_cambio
this.Control[iCurrent+19]=this.rb_nueva
this.Control[iCurrent+20]=this.pb_hist_carreras
this.Control[iCurrent+21]=this.st_1
this.Control[iCurrent+22]=this.gb_1
end on

on w_cambios_de_carrera_nvo_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_prerrequisitos)
destroy(this.dw_historico_cambio_carr)
destroy(this.dw_revision_est)
destroy(this.uo_1)
destroy(this.dw_carreras_cursadas)
destroy(this.r_3)
destroy(this.r_1)
destroy(this.dw_cam_carr)
destroy(this.st_espere)
destroy(this.st_anio)
destroy(this.st_per)
destroy(this.rr_1)
destroy(this.rr_2)
destroy(this.rr_3)
destroy(this.uo_nombre)
destroy(this.st_carrera_actual)
destroy(this.st_2)
destroy(this.rb_cambio)
destroy(this.rb_nueva)
destroy(this.pb_hist_carreras)
destroy(this.st_1)
destroy(this.gb_1)
end on

event doubleclicked;call super::doubleclicked;int sub_sist,li_baja_disciplina,li_baja_documentos,li_cve_flag_promedio, le_cambios_carrera 
// Juan Campos.  Abril-1997.
//BEVM 19/06/2013
 
dw_cam_carr.getchild('cve_carrera',dwc_carrera)
dwc_carrera.settransobject(gtr_sce)
dw_cam_carr.getchild('cve_plan',dwc_plan)
dwc_plan.settransobject(gtr_sce)
dwc_subsis.settransobject(gtr_sce)
cuenta = long(uo_nombre.of_obten_cuenta())

if cuenta <> 0 then 
	
	SELECT COUNT(*) 
	INTO :le_cambios_carrera 
	FROM hist_carreras 
	WHERE cuenta = :cuenta 
	GROUP BY cuenta, cve_carrera_ant, cve_plan_ant, cve_carrera_act, cve_plan_act 
	HAVING COUNT(*) > 1
	using gtr_sce;	
	
	IF le_cambios_carrera <= 0 THEN 
		SELECT COUNT(*) 
		INTO :le_cambios_carrera 
		FROM hist_carreras 
		WHERE cuenta = :cuenta 
		GROUP BY cuenta, cve_carrera_act, cve_plan_act 
		HAVING COUNT(*) > 1
		using gtr_sce;		
	END IF 	
	
	
	IF 	le_cambios_carrera > 1 THEN 
		pb_hist_carreras.VISIBLE = TRUE 
	ELSE	
		pb_hist_carreras.VISIBLE = FALSE 
	END IF 	
	
	SELECT academicos.cve_carrera, academicos.cve_plan, academicos.cve_subsistema, academicos.nivel, carreras.carrera 
	INTO	:CarreraActual, :PlanActual, :subsistemaActual,:NivelActual, :is_carrera   
	FROM academicos, carreras   
	WHERE academicos.cuenta = :cuenta   
	AND academicos.cve_carrera = carreras.cve_carrera 
	using gtr_sce;	
	
	st_carrera_actual.TEXT = "Carrera Actual: " + STRING(CarreraActual) + "-" + is_carrera  
	rb_cambio.CHECKED = TRUE 
	rb_nueva.CHECKED = FALSE 
	wf_filtra_carreras() 
	
	//BEVM 25/06/2013 Se insertan validaciones (estas estaban en el boton cb_1) para no dejar continuar el proceso si existe un error
	li_baja_disciplina = f_obten_baja_disciplina(cuenta)
	
	if li_baja_disciplina = -1 then
		Messagebox("Error al consultar las banderas de la cuenta :"+string(cuenta),&
						"Reporte el caso con el area de Informatica")
		wf_limpiar()						
		Return	
	elseif li_baja_disciplina = 1 then
		Messagebox("PROCESO NO AUTORIZADO" ,"El alumno con cuenta :"+string(cuenta)+&
						" se encuentra DADO DE BAJA POR DISCIPLINA")
		wf_limpiar()							
		Return	
	end if
	
	li_baja_documentos = f_obten_baja_documentos(cuenta)
	
	if li_baja_documentos = -1 then
		Messagebox("Error al consultar las banderas de la cuenta :"+string(cuenta),&
						"Reporte el caso con el area de Informatica")
		wf_limpiar()	
		Return	
	elseif li_baja_documentos = 1 then
		Messagebox("PROCESO NO AUTORIZADO" ,"El alumno con cuenta :"+string(cuenta)+&
						" se encuentra DADO DE BAJA POR DOCUMENTOS")
		wf_limpiar()	
		Return	
	end if
	
	li_cve_flag_promedio = f_obten_baja_promedio(cuenta)
	
	if li_cve_flag_promedio = -1 then
		Messagebox("Error al consultar las banderas de la cuenta :"+string(cuenta),&
						"Reporte el caso con el area de Informatica")
		wf_limpiar()	
		Return	
	elseif li_cve_flag_promedio = 2 then
		Messagebox("PROCESO NO AUTORIZADO" ,"El alumno con cuenta :"+string(cuenta)+&
						" se encuentra DADO DE BAJA POR PROMEDIO")
		wf_limpiar()	
		Return	
	end if
end if

//SELECT cve_carrera, cve_plan, cve_subsistema,nivel 
//INTO	:CarreraActual, :PlanActual, :subsistemaActual,:NivelActual  
//FROM academicos  
//WHERE academicos.cuenta = :cuenta   using gtr_sce;

//if isvalid(dw_cam_carr) then
//	//if NivelActual = 'L' then
//	if NivelActual <> 'P' then 
//		dwc_plan.retrieve(CarreraActual)
//		dwc_subsis.retrieve(CarreraActual,PlanActual) 
//	else
//		dwc_plan.retrieve(0)
//		dwc_subsis.retrieve(0,0)
//	end if
//end if
//

dwc_plan.retrieve(CarreraActual)
dwc_subsis.retrieve(CarreraActual,PlanActual) 


if dw_cam_carr.retrieve(long(uo_nombre.of_obten_cuenta())) = 0 then
	dw_cam_carr.insertrow(0)
	uo_nombre.em_cuenta.setfocus()	
end if		 

if dwc_plan.rowcount()  = 0 then
	dwc_plan.Insertrow(0)
	dwc_plan.Setitem(1,'cve_plan', 0)
	dwc_plan.Setitem(1,'nombre_plan', 'SIN PLAN')
end if
if dwc_subsis.rowcount()= 0 then
	dwc_subsis.Insertrow(0)
	dwc_subsis.Setitem(1,'cve_subsistema', 0)
	dwc_subsis.Setitem(1,'nombre_plan', 'SIN SUBSISTEMA')
end if


//BEVM 24/06/2013 Se agrego el user object para la consulta de las carreras del alumno
dw_carreras_cursadas.Retrieve(long(uo_nombre.of_obten_cuenta())) 
INTEGER le_row
le_row = dw_carreras_cursadas.FIND("hist_carreras_cve_carrera_act = " +  STRING(CarreraActual) + " AND hist_carreras_cve_plan_act = " + STRING(PlanActual)  , 0, dw_carreras_cursadas.ROWCOUNT()) 
IF le_row > 0 THEN  dw_carreras_cursadas.SETITEM(le_row, "activa", 1)






end event

event key;call super::key;if keydown(KeyEnter!) Then
	dw_cam_carr.SetFocus()	
End if
end event

event open;call super::open;This.x = 5
This.y = 5

//st_espere.visible = False
//st_espere.enabled = False
uo_nombre.em_cuenta.text = " "

//triggerevent(doubleclicked!) 
dw_cam_carr.INSERTROW(0)
  
i_n_security_valores_objeto = CREATE n_security_valores_objeto

	//Modif. Roberto Novoa R.  Jun/2016 - Funcionalidad de periodos múltiples
	iuo_periodo_servicios = CREATE uo_periodo_servicios
	iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)

INTEGER li_periodo,li_anio

//Actualiza el valor de Inscripción de Posgrado al UO_1
select periodo,anio
	into :li_periodo,:li_anio
from periodos_por_procesos
where cve_proceso = 2 and tipo_periodo=:gs_tipo_periodo using gtr_sce;

if gtr_sce.sqlcode = 0 then
	st_anio.text=String(ii_anio)
	st_per.text=iuo_periodo_servicios.f_recupera_descripcion(ii_periodo , "L")
	uo_1.em_ani.text = string(li_anio)
	uo_1.em_per.text = string(li_periodo)
	ii_anio = gi_anio
	ii_periodo = gi_periodo
	gi_anio = li_anio
	gi_periodo = li_periodo
end if

dw_cam_carr.getchild('cve_formaingreso',dwc_formaing)
dwc_formaing.settransobject(gtr_sce)
dwc_formaing.Setfilter('cve_formaingreso <> 99')
dwc_formaing.Filter()

//Modif. Roberto Novoa Jun/2016 .- Funcionalidad periodos multiples
f_dddw_converter(dw_cam_carr, dwc_periodo, "periodo_ing")
f_dddw_converter(dw_cam_carr, dwc_periodo, "periodo_egre")

// Se crea objeto de servicios de académicos. 
iuo_academicos_servicios = CREATE uo_academicos_servicios 




end event

event close;call super::close;IF ISVALID(i_n_security_valores_objeto) THEN
	DESTROY i_n_security_valores_objeto
END IF

gi_anio = ii_anio 
gi_periodo = ii_periodo
end event

event ue_actualiza;call super::ue_actualiza;Integer li_periodo, li_anio, li_cve_carrera, li_cve_plan, li_existe_plan = 0,li_cve_subsistema, li_cve_formaingreso, li_cve_formaingreso_ant
Integer li_creditos_cursados
String  ls_nivel_alumno, ls_mensaje_sql
Boolean Continua = False, ObtenClaveAreas = False, ActualizaCatalogosOk
decimal ld_promedio_ant
integer li_sem_cursados_ant, li_creditos_cursados_ant, li_egresado_ant, li_periodo_egre_ant, li_anio_egre_ant
integer li_periodo_ing_ant, li_anio_ing_ant, li_codigo_sql, li_baja_disciplina, li_baja_documentos
integer li_cve_flag_promedio,li_res
dw_cam_carr.SetRow(1)
SetPointer(HourGlass!)
LONG ll_code_seleccionado


dw_cam_carr.Accepttext()

li_res = wf_validar ()
if li_res = -1 then
	rollback using gtr_sce;
	messagebox("Información","No se han guardado los cambios")	
	triggerevent(doubleclicked!)
	return
end if

// Se toma la información de la NUEVA CARRERA (La carrera en el dw es la CARRERA ACTUAL) 
iuo_academicos_servicios.il_cuenta = dw_cam_carr.GetItemNumber(1,"cuenta") 
iuo_academicos_servicios.il_cve_carrera = dw_cam_carr.GetItemNumber(1,"cve_carrera") 
iuo_academicos_servicios.ie_cve_plan = dw_cam_carr.GetItemNumber(1,"cve_plan")  
iuo_academicos_servicios.ie_cve_subsistema = dw_cam_carr.GetItemNumber(1,"cve_subsistema")  
iuo_academicos_servicios.is_nivel = dw_cam_carr.GetItemString(1,"nivel") 
iuo_academicos_servicios.id_promedio = dw_cam_carr.GetItemDecimal(1,"promedio") 
iuo_academicos_servicios.ie_sem_cursados = dw_cam_carr.GetItemNumber(1,"sem_cursados") 
iuo_academicos_servicios.ie_creditos_cursados = dw_cam_carr.GetItemNumber(1,"creditos_cursados") 
iuo_academicos_servicios.ib_egresado = dw_cam_carr.GetItemNumber(1,"egresado") 
iuo_academicos_servicios.ie_periodo_ing = dw_cam_carr.GetItemNumber(1,"periodo_ing") 
iuo_academicos_servicios.ie_anio_ing = dw_cam_carr.GetItemNumber(1,"anio_ing")  
iuo_academicos_servicios.ie_periodo_egre = dw_cam_carr.GetItemNumber(1,"periodo_egre") 
iuo_academicos_servicios.ie_anio_egre = dw_cam_carr.GetItemNumber(1,"anio_egre") 
iuo_academicos_servicios.ie_cve_formaingreso = dw_cam_carr.GetItemNumber(1,"cve_formaingreso")  
iuo_academicos_servicios.ie_ceremonia_mes = dw_cam_carr.GetItemNumber(1,"ceremonia_mes") 
iuo_academicos_servicios.ie_ceremonia_anio  = dw_cam_carr.GetItemNumber(1,"ceremonia_anio") 

// Si se trata de la misma carrera, no realiza ninguna operación.
IF 	Cuenta = iuo_academicos_servicios.il_cuenta AND CarreraActual = iuo_academicos_servicios.il_cve_carrera AND PlanActual = iuo_academicos_servicios.ie_cve_plan THEN 
	MESSAGEBOX("Aviso", "No se puede realizar un cambio a la misma carrera.") 
	RETURN 
END IF 	

// Se inicializa el h8istórico de carreras antes de actualizar los datos de academicos. 
IF iuo_academicos_servicios.of_inicializa_hist_carreras() < 0 THEN RETURN 

// Se hace la actualización en académicos. El trigger tu_academicos actualiza en el academicos_hist	 
IF iuo_academicos_servicios.of_actualiza_academicos(2) < 0 THEN 
	ROLLBACK USING gtr_sce; 
END IF 	

// Se inserta registrpo en hist_carreras
IF iuo_academicos_servicios.of_actualiza_hist_carreras() < 0 THEN 
	ROLLBACK USING gtr_sce; 
END IF 

COMMIT USING gtr_sce; 


// Se recuperan los procesos que aplican según la forma de ingreso. 
INTEGER le_forma_ingreso 
STRING ls_revalida 

le_forma_ingreso = dw_cam_carr.GetItemNumber(1,"cve_formaingreso")  

SELECT revalidacion 
INTO :ls_revalida  
FROM ingreso 
WHERE cve_formaingreso = :le_forma_ingreso  
USING gtr_sce;

// Juan Campos.  	Abril-1997.
// Modificado.		Mayo-1998.	 





Periodo_Actual_mat_insc(li_periodo_ing_ant,li_anio_ing_ant,gtr_sce)	

// Se mueve el periodo solamente si se trata de una nueva carrera. 
IF rb_nueva.CHECKED THEN 
	
	if isnull(li_periodo) then
		li_periodo = gi_periodo
	end if
	if isnull(li_anio) then
		li_anio = gi_anio
	end if
	Choose Case li_periodo
		Case 0 to 1
			li_periodo = li_periodo + 1
		Case 2
			li_periodo = li_periodo - 2
			li_anio = li_anio + 1 
		Case Else	
	End Choose
	dw_cam_carr.SetItem(1, "cve_subsistema",0)
	If li_cve_formaingreso = 2 Then
		dw_cam_carr.SetItem(1,"sem_cursados",0)
	End If
	dw_cam_carr.AcceptText( )
	
END IF 	
	
// Se verifica si se hacen revalidaciones sobre la carrera ACTUAL 
IF ls_revalida = "S" THEN 
	
	Revalida_Materias(iuo_academicos_servicios.il_cuenta, 	& 
										iuo_academicos_servicios.il_cve_carrera, & 
										iuo_academicos_servicios.ie_cve_plan, & 
										iuo_academicos_servicios.is_nivel,  CarreraActual,PlanActual) 	
										
END IF 	
	
Actualiza_academ_banderas(iuo_academicos_servicios.il_cuenta, 	& 
										iuo_academicos_servicios.il_cve_carrera, & 
										iuo_academicos_servicios.ie_cve_plan, & 
										iuo_academicos_servicios.is_nivel)
	
MESSAGEBOX("Aviso", "El cambio de carrera fue realizado con éxito. ")

Triggerevent(DOUBLECLICKED!)

RETURN  








//// Juan Campos.  	Abril-1997.
//// Modificado.		Mayo-1998.	 
//
//Integer li_periodo, li_anio, li_cve_carrera, li_cve_plan, li_existe_plan = 0,li_cve_subsistema, li_cve_formaingreso, li_cve_formaingreso_ant
//Integer li_creditos_cursados
//String  ls_nivel_alumno, ls_mensaje_sql
//Boolean Continua = False, ObtenClaveAreas = False, ActualizaCatalogosOk
//decimal ld_promedio_ant
//integer li_sem_cursados_ant, li_creditos_cursados_ant, li_egresado_ant, li_periodo_egre_ant, li_anio_egre_ant
//integer li_periodo_ing_ant, li_anio_ing_ant, li_codigo_sql, li_baja_disciplina, li_baja_documentos
//integer li_cve_flag_promedio,li_res
//dw_cam_carr.SetRow(1)
//SetPointer(HourGlass!)
//LONG ll_code_seleccionado
//
//li_res = wf_validar ()
//if li_res = -1 then
//	rollback using gtr_sce;
//	messagebox("Información","No se han guardado los cambios")	
//	triggerevent(doubleclicked!)
//	return
//end if
//
////gi_anio = integer(uo_1.em_ani.text)
////gi_periodo = integer(uo_1.em_per.text) 
//
////dw_cam_carr.Setitem(1,'periodo_ing',gi_periodo)
////dw_cam_carr.Setitem(1,'anio_ing',gi_anio)
//dw_cam_carr.Accepttext()
//
//if dw_cam_carr.RowCount()>0 then
//	li_cve_formaingreso = dw_cam_carr.GetItemNumber(1,"cve_formaingreso",Primary!,false)
//	li_cve_formaingreso_ant  = dw_cam_carr.GetItemNumber(1,"cve_formaingreso",Primary!,true)
//	li_creditos_cursados	= dw_cam_carr.GetItemNumber(1,"creditos_cursados",Primary!,True)	
//	ls_nivel_alumno			 = dw_cam_carr.GetItemString(1,"nivel")
//	li_cve_carrera				 = dw_cam_carr.GetItemNumber(1,"cve_carrera")
//	li_cve_plan					 = dw_cam_carr.GetItemNumber(1,"cve_plan")
//	li_cve_subsistema			 = dw_cam_carr.GetItemNumber(1,"cve_subsistema")
//	ld_promedio_ant		    = dw_cam_carr.GetItemNumber(1,"promedio")
//	li_sem_cursados_ant 		 = dw_cam_carr.GetItemNumber(1,"sem_cursados")
//	li_creditos_cursados_ant = dw_cam_carr.GetItemNumber(1,"creditos_cursados")
//	li_egresado_ant			 = dw_cam_carr.GetItemNumber(1,"egresado")
//	li_periodo_egre_ant		 = dw_cam_carr.GetItemNumber(1,"periodo_egre")
//	li_anio_egre_ant			 = dw_cam_carr.GetItemNumber(1,"anio_egre")
//	li_periodo_ing_ant		 = dw_cam_carr.GetItemNumber(1,"periodo_ing",Primary!,true)
//	li_anio_ing_ant			 = dw_cam_carr.GetItemNumber(1,"anio_ing",Primary!,true)
//end if
//	
//Periodo_Actual_mat_insc(li_periodo_ing_ant,li_anio_ing_ant,gtr_sce)	
//if isnull(li_periodo) then
//	li_periodo = gi_periodo
//end if
//if isnull(li_anio) then
//	li_anio = gi_anio
//end if
//Choose Case li_periodo
//	Case 0 to 1
//		li_periodo = li_periodo + 1
//	Case 2
//		li_periodo = li_periodo - 2
//		li_anio = li_anio + 1 
//	Case Else	
//End Choose
//dw_cam_carr.SetItem(1, "cve_subsistema",0)
//If li_cve_formaingreso = 2 Then
//	dw_cam_carr.SetItem(1,"sem_cursados",0)
//End If
//dw_cam_carr.AcceptText( )
//Continua = True 
//   
//if Continua Then
//	if Messagebox("Actualización de catálogos","Está seguro que desea continuar",Question!,YesNo!,1) = 1 then
//   	st_espere.visible = True 
//		st_espere.enabled = True      
////		st_espere.x = 764
////		st_espere.y = 861
//		st_espere.setfocus()
//		
//		If Revalida_Materias(cuenta,li_cve_carrera,li_cve_plan,ls_nivel_alumno, CarreraActual,PlanActual) then
//			//BEVM 25/06/2013 funcion que inserta info en academicos_hist para respaldo los datos anteriores
//			If insertar_academicos_hist (Cuenta,CarreraActual,PlanActual)  then
//				dw_cam_carr.AcceptText( )
//				If dw_cam_carr.update(true) = 1 then		
//	//				If Inserta_hist_carreras(Cuenta,li_cve_formaingreso,CarreraActual,PlanActual,li_cve_carrera,li_cve_plan,li_periodo,li_anio,subsistemaActual,li_cve_subsistema) Then
//					If Inserta_hist_carreras(Cuenta,li_cve_formaingreso,CarreraActual,PlanActual,& 
//						li_cve_carrera,li_cve_plan,li_periodo_ing_ant,li_anio_ing_ant,subsistemaActual,li_cve_subsistema, &
//						ld_promedio_ant, li_sem_cursados_ant, li_creditos_cursados_ant, li_egresado_ant, &
//						li_periodo_egre_ant, li_anio_egre_ant, li_periodo_ing_ant, li_anio_ing_ant, li_cve_formaingreso_ant) Then
//						//BEVM 25/06/2013 funcion que inserta info en academicos_hist para respaldo los datos actuales
//						If insertar_academicos_hist (Cuenta,li_cve_carrera,li_cve_plan)  then
//							If Actualiza_academ_banderas(cuenta,li_cve_carrera,li_cve_plan,ls_nivel_alumno) Then
//								ActualizaCatalogosOk= True
//							Else
//								ActualizaCatalogosOk= false
//							End If // actualiza_academ_banderas
//						else
//							ActualizaCatalogosOk= false
//						End If // insertar_academicos_hist
//					Else
//						ActualizaCatalogosOk= false
//					End If // inserta_hist_carreras
//				Else
//					ActualizaCatalogosOk= false
//				End If // dw_academicos_cambio_carr  update
//			else
//				ActualizaCatalogosOk= false
//			end if //insertar_academicos_hist
//		Else
//			// 02/12/2018 SE COMENTA PARA PERMITIR EL CAMBIO DE CARRERA A ALUMNOS QUE NO TENGAN INFORMACIÓN EN  HISTÓRICO
//			// ActualizaCatalogosOk= false
//			
//			/******************************************************************************/
//			
//			//BEVM 25/06/2013 funcion que inserta info en academicos_hist para respaldo los datos anteriores
//			If insertar_academicos_hist (Cuenta,CarreraActual,PlanActual)  then
//				dw_cam_carr.AcceptText( )
//				If dw_cam_carr.update(true) = 1 then		
//	//				If Inserta_hist_carreras(Cuenta,li_cve_formaingreso,CarreraActual,PlanActual,li_cve_carrera,li_cve_plan,li_periodo,li_anio,subsistemaActual,li_cve_subsistema) Then
//					If Inserta_hist_carreras(Cuenta,li_cve_formaingreso,CarreraActual,PlanActual,& 
//						li_cve_carrera,li_cve_plan,li_periodo_ing_ant,li_anio_ing_ant,subsistemaActual,li_cve_subsistema, &
//						ld_promedio_ant, li_sem_cursados_ant, li_creditos_cursados_ant, li_egresado_ant, &
//						li_periodo_egre_ant, li_anio_egre_ant, li_periodo_ing_ant, li_anio_ing_ant, li_cve_formaingreso_ant) Then
//						//BEVM 25/06/2013 funcion que inserta info en academicos_hist para respaldo los datos actuales
//						If insertar_academicos_hist (Cuenta,li_cve_carrera,li_cve_plan)  then
//							If Actualiza_academ_banderas(cuenta,li_cve_carrera,li_cve_plan,ls_nivel_alumno) Then
//								ActualizaCatalogosOk= True
//							Else
//								ActualizaCatalogosOk= false
//							End If // actualiza_academ_banderas
//						else
//							ActualizaCatalogosOk= false
//						End If // insertar_academicos_hist
//					Else
//						ActualizaCatalogosOk= false
//					End If // inserta_hist_carreras
//				Else
//					ActualizaCatalogosOk= false
//				End If // dw_academicos_cambio_carr  update
//			else
//				ActualizaCatalogosOk= false
//			end if //insertar_academicos_hist			
//			
//			
//			
//			/******************************************************************************/
//			
//		End If // Revalida_materias 
//
////		st_espere.x = 1025
////		st_espere.y = 1889
//		st_espere.visible = False
//		st_espere.enabled = False  	
//		li_codigo_sql= gtr_sce.sqlcode
//		ls_mensaje_sql= gtr_sce.sqlerrtext
//		If ActualizaCatalogosOk Then
//			Commit using gtr_sce;
//			dw_cam_carr.Retrieve(cuenta)
//			Messagebox("Aviso","Los cambios fueron guardados.")
//			this.triggerevent("doubleclicked")
//		Else
//			Rollback  using gtr_sce;
//			Messagebox("Aviso","Los cambios No se guardaron : "+ls_mensaje_sql)
//			this.triggerevent("doubleclicked")
//		End If
//
//	Else	
//		uo_nombre.em_cuenta.setfocus()
//	End If // Actualiza Catalogos
//End If // continua
// 
end event

event closequery;//
end event

type st_sistema from w_master_main`st_sistema within w_cambios_de_carrera_nvo_2013
integer textsize = -16
end type

type p_ibero from w_master_main`p_ibero within w_cambios_de_carrera_nvo_2013
end type

type dw_prerrequisitos from uo_master_dw within w_cambios_de_carrera_nvo_2013
boolean visible = false
integer x = 933
integer y = 924
integer width = 302
integer height = 164
integer taborder = 90
boolean enabled = false
string dataobject = "dw_prerrequisitos"
boolean hscrollbar = false
boolean vscrollbar = false
boolean livescroll = false
end type

type dw_historico_cambio_carr from uo_master_dw within w_cambios_de_carrera_nvo_2013
boolean visible = false
integer x = 576
integer y = 924
integer width = 302
integer height = 164
integer taborder = 80
boolean enabled = false
string dataobject = "dw_historico_cambio_carr"
boolean hscrollbar = false
boolean vscrollbar = false
boolean livescroll = false
end type

type dw_revision_est from uo_master_dw within w_cambios_de_carrera_nvo_2013
boolean visible = false
integer x = 210
integer y = 920
integer width = 302
integer height = 164
integer taborder = 70
boolean enabled = false
string dataobject = "dw_rev_est_fmc"
boolean hscrollbar = false
boolean vscrollbar = false
boolean livescroll = false
end type

type uo_1 from uo_per_ani within w_cambios_de_carrera_nvo_2013
integer x = 1989
integer y = 68
integer width = 1253
integer height = 168
integer taborder = 10
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

event constructor;call super::constructor;INTEGER le_periodo
INTEGER le_anio
STRING is_periodo_desc, ls_error 

// Se recupera el periodo y año de indulto de Inglés.
SELECT periodos_por_procesos.periodo, periodos_por_procesos.anio, periodo.descripcion
INTO :le_periodo, :le_anio, :is_periodo_desc
FROM periodos_por_procesos, periodo  
WHERE periodos_por_procesos.cve_proceso = 2 
AND periodos_por_procesos.periodo = periodo.periodo 
AND periodos_por_procesos.tipo_periodo = :gs_tipo_periodo
USING gtr_sce;
IF gtr_sce.sqlcode < 0 THEN 
	ls_error = gtr_sce.SQLERRTEXT 
	MESSAGEBOX("Error", "Se produjo un error al recuperar el periodo de Indultos de Inglés: " + ls_error) 
	RETURN 0
END IF

this.em_ani.text = string(le_anio) 
this.em_per.text = string(le_periodo)  

//this.em_ani.text = string(gi_anio) 
//this.em_per.text = string(gi_periodo)  

em_per.TRIGGEREVENT(MODIFIED!) 


end event

type dw_carreras_cursadas from uo_carreras_alumno within w_cambios_de_carrera_nvo_2013
integer x = 101
integer y = 764
integer width = 3854
integer height = 448
integer taborder = 30
string dataobject = "dw_lista_carreras_cambio"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;dw_carreras_cursadas.modify("r1_t.Text='Carreras Cursadas: '")
end event

type r_3 from rectangle within w_cambios_de_carrera_nvo_2013
long linecolor = 128
integer linethickness = 5
long fillcolor = 16777215
integer x = 46
integer y = 664
integer width = 3954
integer height = 596
end type

type r_1 from rectangle within w_cambios_de_carrera_nvo_2013
long linecolor = 128
integer linethickness = 5
long fillcolor = 16777215
integer x = 46
integer y = 1324
integer width = 3954
integer height = 1208
end type

type dw_cam_carr from uo_master_dw within w_cambios_de_carrera_nvo_2013
integer x = 87
integer y = 1576
integer width = 3867
integer height = 940
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_academicos_cambio_carr_nvo_2013"
boolean hscrollbar = false
boolean vscrollbar = false
end type

event constructor;call super::constructor;dw_cam_carr.SetTransObject(gtr_sce)
idw_trabajo = this
end event

event itemchanged;call super::itemchanged;
string ls_carrera, ls_columna, ls_plan, ls_nivel,ls_cve_carrera, ls_tper
integer li_carrera, li_cve_plan,li_cve_subsis, li_permax
long ll_row, ll_row_carr, ll_id_carrera
DATAWINDOWCHILD ldw_planestudio
DATAWINDOWCHILD ldw_carreras

ll_row = this.GetRow()

this.AcceptText()

ls_columna =this.GetColumnName()	

li_carrera = object.cve_carrera[ll_row]
//ls_nivel = f_obten_nivel(li_carrera)
ls_nivel = f_obten_nivel(LONG(data))
li_cve_plan = object.cve_plan[ll_row]

choose case ls_columna 
case 'cve_carrera' 
	
	INTEGER le_num_planes
	
	// Si se selecciona una carrera nueva, se limpian los campos mientras no se seleccione la forma de ingreso.  
	THIS.GETCHILD("cve_plan", ldw_planestudio) 
	ldw_planestudio.SETTRANSOBJECT(gtr_sce)  
	le_num_planes = ldw_planestudio.RETRIEVE(LONG(data)) 

	IF le_num_planes <= 0 THEN 
		li_cve_plan = 0 
		dwc_plan.Insertrow(0)	
		dwc_plan.Setitem(1,'cve_plan', 0)
		dwc_plan.Setitem(1,'nombre_plan', 'SIN PLAN')
	end if	
	
	THIS.GETCHILD("cve_carrera", ldw_carreras)
	 ll_row_carr = ldw_carreras.GETROW() 
	 ll_id_carrera = ldw_carreras.GETITEMNUMBER(ll_row_carr, "id_carrera") 
	
	
	// Si se despliega una carrera ya cursada termina
	IF wf_despliega_carrera(LONG(data), ll_id_carrera) THEN RETURN 0 
	
 	//Setitem(row,'cve_plan',li_cve_plan)
	//if dwc_subsis.Retrieve(li_carrera,li_cve_plan) = 0 then
	if dwc_subsis.Retrieve(LONG(data),li_cve_plan) = 0 then
		dwc_subsis.Insertrow(0)
		dwc_subsis.Setitem(1,'cve_subsistema', 0)
		dwc_subsis.Setitem(1,'subsistema', 'SIN SUBSISTEMA')
		Setitem(row,'cve_subsistema',0)
	else
		li_cve_subsis = dwc_subsis.Getitemnumber(1,'cve_subsistema')
		if isnull(li_cve_subsis) then li_cve_subsis = 0
		Setitem(row,'cve_subsistema',li_cve_subsis)
	end if
	
case 'cve_plan'
	
	li_cve_plan = LONG(data)
	
	if not f_plan_activo(li_carrera, li_cve_plan) then
		MessageBox("Plan Inactivo","La carrera: ["+ls_cve_carrera+"] con el plan: ["+string(li_cve_plan)+ "] no estan activos ")	
		if dwc_subsis.Retrieve(li_carrera,li_cve_plan) = 0 then
			dwc_subsis.Insertrow(0)
			dwc_subsis.Setitem(1,'cve_subsistema', 0)
			dwc_subsis.Setitem(1,'subsistema', 'SIN SUBSISTEMA')
			Setitem(row,'cve_subsistema',0)
		else
			li_cve_subsis = dwc_subsis.Getitemnumber(1,'cve_subsistema')
			if isnull(li_cve_subsis) then li_cve_subsis = 0
			Setitem(row,'cve_subsistema',li_cve_subsis)
		end if
	else
		IF dwc_plan.retrieve(li_carrera) = 0 then
			dwc_plan.Insertrow(0)
			dwc_plan.Setitem(1,'cve_plan', 0)
			dwc_plan.Setitem(1,'nombre_plan', 'SIN PLAN')
			Setitem(row,'cve_plan',0)
		else
			/***************Modificado Por: Roberto Novoa Jun/2016***************************/
			ls_tper=data
			Select tipo_periodo into :ls_tper from plan_estudios where cve_carrera=:li_carrera and cve_plan=:li_cve_plan  using gtr_sce;
			
			select periodo,anio
				into :ii_periodo,:ii_anio
			from periodos_por_procesos
			where cve_proceso = 0 and tipo_periodo=:ls_tper using gtr_sce;
			
			if gtr_sce.sqlcode = 0 then
				select max(periodo) into :li_permax from periodo where tipo=:ls_tper using gtr_sce;
				
				if ii_periodo=li_permax then
					select min(periodo) into :ii_periodo from periodo where tipo=:ls_tper using gtr_sce;
					ii_anio++
				else
					ii_periodo++
				end if
			end if
			
			ls_plan=gs_tipo_periodo
			gs_tipo_periodo=ls_tper
			
			iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)

			st_anio.text = string(ii_anio)
			st_per.text =  iuo_periodo_servicios.f_recupera_descripcion(ii_periodo , "L")
//			ii_anio = gi_anio
//			ii_periodo = gi_periodo
//			gi_anio = integer(uo_1.em_ani.text)
//			gi_periodo = integer(uo_1.em_per.text)
			gi_anio = ii_anio
			gi_periodo = ii_periodo
			
			dw_cam_carr.Setitem(1,'periodo_ing',ii_periodo)
			dw_cam_carr.Setitem(1,'anio_ing',ii_anio)
	//Modif. Roberto Novoa Jun/2016 .- Funcionalidad periodos multiples
	f_dddw_converter(dw_cam_carr, dwc_periodo, "periodo_ing")
	f_dddw_converter(dw_cam_carr, dwc_periodo, "periodo_egre")
			dw_cam_carr.accepttext()
			gs_tipo_periodo=ls_plan
			
		end if
		if dwc_subsis.Retrieve(li_carrera,li_cve_plan) = 0 then
			dwc_subsis.Insertrow(0)
			dwc_subsis.Setitem(1,'cve_subsistema', 0)
			dwc_subsis.Setitem(1,'subsistema', 'SIN SUBSISTEMA')
			Setitem(row,'cve_subsistema',0)
		else
			li_cve_subsis = dwc_subsis.Getitemnumber(1,'cve_subsistema')
			if isnull(li_cve_subsis) then li_cve_subsis = 0
			Setitem(row,'cve_subsistema',li_cve_subsis)
		end if
	end if
case 'cve_formaingreso'
	//if integer(data) = 0 and dwc_carrera.Getitemstring(dwc_carrera.Getrow(),'nivel') <> 'L' then
	if integer(data) = 0 and dwc_carrera.Getitemstring(dwc_carrera.Getrow(),'nivel') = 'P' then
		Messagebox("Aviso","Forma de ingreso: 'EXAMEN DE ADMISION', no aplica para posgrado.") 
		//Messagebox("Aviso","Forma de ingreso: 'EXAMEN DE ADMISION', solo para nivel licenciatura.")
		return 1
	end if
	if integer(data) = 8 and dwc_carrera.Getitemstring(dwc_carrera.Getrow(),'nivel') <> 'P' then
		Messagebox("Aviso","Forma de ingreso: 'ADMISION POSGRADO', solo para nivel posgrado.")
		return 1
	end if
	ii_cve_formaingreso = integer(data) 
end choose





//****************************************************************************************
//****************************************************************************************
//****************************************************************************************
//****************************************************************************************

//string ls_carrera, ls_columna, ls_plan, ls_nivel,ls_cve_carrera, ls_tper
//integer li_carrera, li_cve_plan,li_cve_subsis, li_permax
//long ll_row
//
//ll_row = this.GetRow()
//
//this.AcceptText()
//
//ls_columna =this.GetColumnName()	
//
//li_carrera = object.cve_carrera[ll_row]
////ls_nivel = f_obten_nivel(li_carrera)
//ls_nivel = f_obten_nivel(LONG(data))
//li_cve_plan = object.cve_plan[ll_row]
//
//choose case ls_columna 
//case 'cve_carrera' 
//	object.nivel[ll_row]= ls_nivel
//	dwc_plan.settransobject(gtr_sce)
//	//if dwc_plan.Retrieve(li_carrera) > 0 then
//	if dwc_plan.Retrieve(LONG(data)) > 0 then
//		li_cve_plan = dwc_plan.Getitemnumber(1,'cve_plan')
//	else
//		li_cve_plan = 0 
//		dwc_plan.Insertrow(0)	
//		dwc_plan.Setitem(1,'cve_plan', 0)
//		dwc_plan.Setitem(1,'nombre_plan', 'SIN PLAN')
//	end if
//	Setitem(row,'cve_plan',li_cve_plan)
//	//if dwc_subsis.Retrieve(li_carrera,li_cve_plan) = 0 then
//	if dwc_subsis.Retrieve(LONG(data),li_cve_plan) = 0 then
//		dwc_subsis.Insertrow(0)
//		dwc_subsis.Setitem(1,'cve_subsistema', 0)
//		dwc_subsis.Setitem(1,'subsistema', 'SIN SUBSISTEMA')
//		Setitem(row,'cve_subsistema',0)
//	else
//		li_cve_subsis = dwc_subsis.Getitemnumber(1,'cve_subsistema')
//		if isnull(li_cve_subsis) then li_cve_subsis = 0
//		Setitem(row,'cve_subsistema',li_cve_subsis)
//	end if
//case 'cve_plan'
//	
//	li_cve_plan = LONG(data)
//	
//	if not f_plan_activo(li_carrera, li_cve_plan) then
//		MessageBox("Plan Inactivo","La carrera: ["+ls_cve_carrera+"] con el plan: ["+string(li_cve_plan)+ "] no estan activos ")	
//		if dwc_subsis.Retrieve(li_carrera,li_cve_plan) = 0 then
//			dwc_subsis.Insertrow(0)
//			dwc_subsis.Setitem(1,'cve_subsistema', 0)
//			dwc_subsis.Setitem(1,'subsistema', 'SIN SUBSISTEMA')
//			Setitem(row,'cve_subsistema',0)
//		else
//			li_cve_subsis = dwc_subsis.Getitemnumber(1,'cve_subsistema')
//			if isnull(li_cve_subsis) then li_cve_subsis = 0
//			Setitem(row,'cve_subsistema',li_cve_subsis)
//		end if
//	else
//		IF dwc_plan.retrieve(li_carrera) = 0 then
//			dwc_plan.Insertrow(0)
//			dwc_plan.Setitem(1,'cve_plan', 0)
//			dwc_plan.Setitem(1,'nombre_plan', 'SIN PLAN')
//			Setitem(row,'cve_plan',0)
//		else
//			/***************Modificado Por: Roberto Novoa Jun/2016***************************/
//			ls_tper=data
//			Select tipo_periodo into :ls_tper from plan_estudios where cve_carrera=:li_carrera and cve_plan=:li_cve_plan  using gtr_sce;
//			
//			select periodo,anio
//				into :ii_periodo,:ii_anio
//			from periodos_por_procesos
//			where cve_proceso = 0 and tipo_periodo=:ls_tper using gtr_sce;
//			
//			if gtr_sce.sqlcode = 0 then
//				select max(periodo) into :li_permax from periodo where tipo=:ls_tper using gtr_sce;
//				
//				if ii_periodo=li_permax then
//					select min(periodo) into :ii_periodo from periodo where tipo=:ls_tper using gtr_sce;
//					ii_anio++
//				else
//					ii_periodo++
//				end if
//			end if
//			
//			ls_plan=gs_tipo_periodo
//			gs_tipo_periodo=ls_tper
//			
//			iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)
//
//			st_anio.text = string(ii_anio)
//			st_per.text =  iuo_periodo_servicios.f_recupera_descripcion(ii_periodo , "L")
////			ii_anio = gi_anio
////			ii_periodo = gi_periodo
////			gi_anio = integer(uo_1.em_ani.text)
////			gi_periodo = integer(uo_1.em_per.text)
//			gi_anio = ii_anio
//			gi_periodo = ii_periodo
//			
//			dw_cam_carr.Setitem(1,'periodo_ing',ii_periodo)
//			dw_cam_carr.Setitem(1,'anio_ing',ii_anio)
//	//Modif. Roberto Novoa Jun/2016 .- Funcionalidad periodos multiples
//	f_dddw_converter(dw_cam_carr, dwc_periodo, "periodo_ing")
//	f_dddw_converter(dw_cam_carr, dwc_periodo, "periodo_egre")
//			dw_cam_carr.accepttext()
//			gs_tipo_periodo=ls_plan
//			
//		end if
//		if dwc_subsis.Retrieve(li_carrera,li_cve_plan) = 0 then
//			dwc_subsis.Insertrow(0)
//			dwc_subsis.Setitem(1,'cve_subsistema', 0)
//			dwc_subsis.Setitem(1,'subsistema', 'SIN SUBSISTEMA')
//			Setitem(row,'cve_subsistema',0)
//		else
//			li_cve_subsis = dwc_subsis.Getitemnumber(1,'cve_subsistema')
//			if isnull(li_cve_subsis) then li_cve_subsis = 0
//			Setitem(row,'cve_subsistema',li_cve_subsis)
//		end if
//	end if
//case 'cve_formaingreso'
//	//if integer(data) = 0 and dwc_carrera.Getitemstring(dwc_carrera.Getrow(),'nivel') <> 'L' then
//	if integer(data) = 0 and dwc_carrera.Getitemstring(dwc_carrera.Getrow(),'nivel') = 'P' then
//		Messagebox("Aviso","Forma de ingreso: 'EXAMEN DE ADMISION', no aplica para posgrado.") 
//		//Messagebox("Aviso","Forma de ingreso: 'EXAMEN DE ADMISION', solo para nivel licenciatura.")
//		return 1
//	end if
//	if integer(data) = 8 and dwc_carrera.Getitemstring(dwc_carrera.Getrow(),'nivel') <> 'P' then
//		Messagebox("Aviso","Forma de ingreso: 'ADMISION POSGRADO', solo para nivel posgrado.")
//		return 1
//	end if
//	ii_cve_formaingreso = integer(data) 
//end choose
//
//
end event

type st_espere from statictext within w_cambios_de_carrera_nvo_2013
boolean visible = false
integer x = 549
integer y = 912
integer width = 2304
integer height = 352
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "HourGlass!"
long backcolor = 12639424
boolean enabled = false
string text = "Actualizando Catálogos.       Espere..."
alignment alignment = center!
boolean border = true
long bordercolor = 32172778
boolean focusrectangle = false
end type

event getfocus;
setpointer(hourglass!)
SetPosition(ToTop!)
end event

type st_anio from statictext within w_cambios_de_carrera_nvo_2013
boolean visible = false
integer x = 1029
integer y = 112
integer width = 215
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Año"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_per from statictext within w_cambios_de_carrera_nvo_2013
boolean visible = false
integer x = 1330
integer y = 112
integer width = 539
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Periodo"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type rr_1 from roundrectangle within w_cambios_de_carrera_nvo_2013
boolean visible = false
integer linethickness = 4
long fillcolor = 67108864
integer x = 960
integer y = 64
integer width = 997
integer height = 176
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_2 from roundrectangle within w_cambios_de_carrera_nvo_2013
boolean visible = false
integer linethickness = 4
long fillcolor = 33554431
integer x = 1006
integer y = 88
integer width = 261
integer height = 124
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_3 from roundrectangle within w_cambios_de_carrera_nvo_2013
boolean visible = false
integer linethickness = 4
long fillcolor = 33554431
integer x = 1289
integer y = 88
integer width = 617
integer height = 124
integer cornerheight = 40
integer cornerwidth = 46
end type

type uo_nombre from uo_nombre_alumno_2013 within w_cambios_de_carrera_nvo_2013
integer x = 46
integer y = 312
integer taborder = 20
end type

on uo_nombre.destroy
call uo_nombre_alumno_2013::destroy
end on

event constructor;call super::constructor;iw_ventana = parent
end event

type st_carrera_actual from statictext within w_cambios_de_carrera_nvo_2013
integer x = 1088
integer y = 348
integer width = 2121
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
string text = "Carrera Actual: "
boolean focusrectangle = false
end type

type st_2 from statictext within w_cambios_de_carrera_nvo_2013
integer x = 96
integer y = 684
integer width = 3854
integer height = 64
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
string text = "Carreras Cursadas: "
alignment alignment = center!
boolean focusrectangle = false
end type

type rb_cambio from radiobutton within w_cambios_de_carrera_nvo_2013
integer x = 809
integer y = 1444
integer width = 805
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
string text = "Cambiar Carrera Actual "
boolean checked = true
end type

event clicked;POST wf_filtra_carreras() 
end event

type rb_nueva from radiobutton within w_cambios_de_carrera_nvo_2013
integer x = 1669
integer y = 1444
integer width = 850
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
string text = "Registro de Nueva Carrera"
end type

event clicked;POST wf_filtra_carreras() 
end event

type pb_hist_carreras from picturebutton within w_cambios_de_carrera_nvo_2013
boolean visible = false
integer x = 3342
integer y = 480
integer width = 663
integer height = 148
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Verificar Hist. Carreras"
boolean originalsize = true
alignment htextalign = left!
long textcolor = 15793151
long backcolor = 128
end type

event clicked;OPENWITHPARM(w_depura_hist_carreras, Cuenta) 
Triggerevent(DOUBLECLICKED!)



end event

type st_1 from statictext within w_cambios_de_carrera_nvo_2013
integer x = 3557
integer y = 132
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
string text = "Abril 2021"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_cambios_de_carrera_nvo_2013
integer x = 731
integer y = 1368
integer width = 1879
integer height = 184
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
string text = "Tipo de Operación: "
end type

