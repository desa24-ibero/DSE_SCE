$PBExportHeader$w_cambios_de_carrera_nvo.srw
forward
global type w_cambios_de_carrera_nvo from window
end type
type cb_2 from commandbutton within w_cambios_de_carrera_nvo
end type
type uo_estatus_posibles from uo_code_value within w_cambios_de_carrera_nvo
end type
type dw_revision_est from datawindow within w_cambios_de_carrera_nvo
end type
type dw_certificado from datawindow within w_cambios_de_carrera_nvo
end type
type uo_1 from uo_per_ani within w_cambios_de_carrera_nvo
end type
type st_espere from statictext within w_cambios_de_carrera_nvo
end type
type dw_historico_cambio_carr from datawindow within w_cambios_de_carrera_nvo
end type
type dw_prerrequisitos from datawindow within w_cambios_de_carrera_nvo
end type
type uo_nombre from uo_nombre_alumno within w_cambios_de_carrera_nvo
end type
type ddlb_cambio_carrera from dropdownlistbox within w_cambios_de_carrera_nvo
end type
type cb_1 from commandbutton within w_cambios_de_carrera_nvo
end type
type dw_cam_carr from datawindow within w_cambios_de_carrera_nvo
end type
end forward

global type w_cambios_de_carrera_nvo from window
integer x = 832
integer y = 352
integer width = 3424
integer height = 1988
boolean enabled = false
boolean titlebar = true
string title = "CAMBIO DE CARRERA"
string menuname = "m_cambios_de_carrera_nvo"
boolean controlmenu = true
long backcolor = 27291696
cb_2 cb_2
uo_estatus_posibles uo_estatus_posibles
dw_revision_est dw_revision_est
dw_certificado dw_certificado
uo_1 uo_1
st_espere st_espere
dw_historico_cambio_carr dw_historico_cambio_carr
dw_prerrequisitos dw_prerrequisitos
uo_nombre uo_nombre
ddlb_cambio_carrera ddlb_cambio_carrera
cb_1 cb_1
dw_cam_carr dw_cam_carr
end type
global w_cambios_de_carrera_nvo w_cambios_de_carrera_nvo

type variables
long     Cuenta
Integer CarreraActual
integer PlanActual
integer subsistemaActual
Char     NIvelActual
integer ii_cve_formaingreso
n_security_valores_objeto i_n_security_valores_objeto
datawindowchild idddw_child
end variables

forward prototypes
public function boolean wf_es_egresado (long al_cuenta, integer ai_carrera, integer ai_plan, integer ai_subsistema, string as_nivel)
public function boolean revalida_materias (long cuenta_hist, integer carrera_nueva, integer plan_nuevo, string nivel, integer cve_carrera_ant, integer cve_plan_ant)
public function boolean actualiza_academ_banderas (long cuenta_academ, integer carrera_academ, integer plan_academ, character nivel_academ)
public function boolean inserta_hist_carreras (long cuenta_hist_carr, integer ingreso_hist_carr, integer carr_ant_hist_carr, integer plan_ant_hist_carr, integer carr_act_hist_carr, integer plan_act_hist_carr, integer periodo_hist_carr, long anio_hist_carr, integer subsis_ant, integer subsis_act, real ar_promedio_ant, integer ai_sem_cursados_ant, integer ai_creditos_cursados_ant, integer ai_egresado_ant, integer ai_periodo_egre_ant, integer ai_anio_egre_ant, integer ai_periodo_ing_act, integer ai_anio_ing_act, integer ai_cve_formaingreso_ant)
end prototypes

public function boolean wf_es_egresado (long al_cuenta, integer ai_carrera, integer ai_plan, integer ai_subsistema, string as_nivel);integer li_pend_creditos, li_pend_opcion_terminal,li_pend_servicio_social, li_row, li_rows_revision
integer li_cred_minimos, li_cred_cursados
li_pend_creditos =0

dw_certificado.Reset()
dw_revision_est.Reset()

hist_alumno_areas(al_cuenta, ai_carrera, ai_plan, ai_subsistema, dw_certificado, dw_revision_est, as_nivel)
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

Long  i, MateriaHist 
Integer Per,Año,Obs,Existe
String Gpo,Calif
IF dw_historico_cambio_carr.retrieve(cuenta_hist) > 0 Then
  For i = 1 to dw_historico_cambio_carr.RowCount()
		MateriaHist = dw_historico_cambio_carr.GetItemNumber(i,"cve_mat")
		IF MateriaHist = 3748 OR MateriaHist = 8763 Then		
			//Ojo No Incluye a el servicio social			
		Else
         IF (MateriaHist = 4078) or & 
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
						else
							commit using gtr_sce;					
						end if
					End If 
				End if
			End If
		End IF	
  Next
Else
	Messagebox("No se encontro la historia del alumno","")
End if	
	
Return True	

end function

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
   SET promedio = :promedio , creditos_cursados = CONVERT(INT, :creditos)
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
	

//   IF NivelAcademico = "P" and CveFlagPromedio <> 0 Then 
//      UPDATE banderas
//         SET cve_flag_promedio = 0   // Normal
//       WHERE cuenta = :cuenta_academ
//       USING gtr_sce;
//	   IF gtr_sce.sqlcode = -1 Then     
// 	   	lb_ActualizaBanderas  = False
//	   	MessageBox("Error","No se actualizo la bandera de: flag_promedio. "+gtr_sce.sqlerrtext)
//    	End If			
//   Else // Nivel academico	
//      IF creditos >= CreditosPuntaje Then 
//		   If CveFlagPromedio <> 3 Then 
//            UPDATE banderas
//               SET cve_flag_promedio = 3   // Creditos 75 %
//         	 WHERE cuenta = :cuenta_academ
//         	 USING gtr_sce;
//		    	IF gtr_sce.sqlcode = -1 Then   
// 	        		lb_ActualizaBanderas  = False
//	        		MessageBox("Error","No se actualizo la bandera de: creditos 75%. "+gtr_sce.sqlerrtext)
//         	End If			
//      	End if
//   	Else  // creditos puntaje
//			
//			if  CveFlagPromedio = 3 then
//			    UPDATE banderas
//                SET cve_flag_promedio = 0   // Normal
//         	  WHERE cuenta = :cuenta_academ
//         	  USING gtr_sce;
//		    	 IF gtr_sce.sqlcode = -1 Then   
// 	        		 lb_ActualizaBanderas  = False
//	        		 MessageBox("Error","No se actualizo la bandera de: creditos 75%. "+gtr_sce.sqlerrtext)
//         	 End If	
//		   end if
//			

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
			  
//      	Else  // puntaje minimo
//		  		IF CveFlagPromedio = 0 or CveFlagPromedio = 3 Then 
//		    		UPDATE banderas
//             		SET cve_flag_promedio = 1   // Amonestado
//           		 WHERE cuenta = :cuenta_academ
//           		 USING gtr_sce;
//		     		IF gtr_sce.sqlcode = -1 Then   
// 	          		lb_ActualizaBanderas  = False
//	          		MessageBox("Error","No se actualizo la bandera de: flag_promedio. "+gtr_sce.sqlerrtext)						
//           		End If		
//		  		End If	
//		  
//		  		IF CveFlagPromedio = 1 Then  
//		    		UPDATE banderas
//             		SET cve_flag_promedio = 2   // Baja
//           		 WHERE cuenta = :cuenta_academ
//           		 USING gtr_sce;
//		     		IF gtr_sce.sqlcode = -1 Then   
// 	          		lb_ActualizaBanderas  = False
//	          		MessageBox("Error","No se actualizo la bandera de: flag_promedio. "+gtr_sce.sqlerrtext)												 
//           		End If	  
//		  		End If// CveFlagPromedio = 1		  
//         End If// puntaje minimo			  
//      End If// Creditos puntaje 
//


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

			 
			 
//		else
//			UPDATE banderas
//         	SET cve_flag_serv_social = 0  // No ha cursado
//       	 WHERE cuenta = :cuenta_academ
//       	 USING gtr_sce;
//		 	IF gtr_sce.sqlcode = -1 Then   
// 	      	lb_ActualizaBanderas  = False
//	      	MessageBox("Error","No se actualizo la bandera de: flag_serv_social. "+gtr_sce.sqlerrtext)
//       	End If
//      End If// Creditos servicio social 
//		
//		Int     semestres, Flag_prerreq_ingles
//		Boolean BanderaOk
//		string  Califhist
// 
//		SELECT sem_cursados
//  		  INTO :semestres
//  		  FROM academicos
// 		 WHERE cuenta = :cuenta_academ
// 		USING gtr_sce;
//  
//		IF gtr_sce.sqlcode = 0  Then
//			SELECT calificacion
//  	  		  INTO :Califhist
//  	  		  FROM historico
// 	 		 WHERE (cuenta = :cuenta_academ) and
//				    (cve_mat = 4078)     // 4078 = Prerrequisito de ingles
// 	 		USING gtr_sce; 
//			if gtr_sce.sqlcode = 0 then
//  				IF semestres >= 2 Then 
//    				IF Califhist = "NA" Then 
//	   				Flag_prerreq_ingles = 1
//    				End IF
//    				IF Califhist = "AC" Then 
//	   				Flag_prerreq_ingles = 0
//    				End IF
//  				Else
//    				IF Califhist = "NA" Then 
//	   				Flag_prerreq_ingles = 2
//    				End IF
//    				IF Califhist = "AC" Then 
//	   				Flag_prerreq_ingles = 0
//    				End IF 
//  				End IF
//			  
//  				UPDATE banderas
//     	   		SET cve_flag_prerreq_ingles = :Flag_prerreq_ingles
//   	 	 	 WHERE cuenta = :cuenta_academ
//   	 		 USING gtr_sce;		
//	   		IF gtr_sce.sqlcode = -1  Then
//					lb_ActualizaBanderas  = False
//		      	MessageBox("Error","No se actualizo la bandera de: flag_prerreeq_ingles. "+gtr_sce.sqlerrtext)				
//      	  	End If		 
//			end if // sqlcode historico
//		end if // sqlcode academicos	
//		
//		// Si se supone que todas las materias de integración son 
//		// revalidadas, no se deberia actualizar este campo. 
//		// de lo contrario falta actualizar area_integracion 
//		// poner codigo aqui
//		
//   End If// Nivel academico		 
//Else  // banderas
//  lb_ActualizaBanderas  = False
//End IF // banderas
//
//If lb_ActualizaBanderas Then 
//  Return True	
//End if

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

on w_cambios_de_carrera_nvo.create
if this.MenuName = "m_cambios_de_carrera_nvo" then this.MenuID = create m_cambios_de_carrera_nvo
this.cb_2=create cb_2
this.uo_estatus_posibles=create uo_estatus_posibles
this.dw_revision_est=create dw_revision_est
this.dw_certificado=create dw_certificado
this.uo_1=create uo_1
this.st_espere=create st_espere
this.dw_historico_cambio_carr=create dw_historico_cambio_carr
this.dw_prerrequisitos=create dw_prerrequisitos
this.uo_nombre=create uo_nombre
this.ddlb_cambio_carrera=create ddlb_cambio_carrera
this.cb_1=create cb_1
this.dw_cam_carr=create dw_cam_carr
this.Control[]={this.cb_2,&
this.uo_estatus_posibles,&
this.dw_revision_est,&
this.dw_certificado,&
this.uo_1,&
this.st_espere,&
this.dw_historico_cambio_carr,&
this.dw_prerrequisitos,&
this.uo_nombre,&
this.ddlb_cambio_carrera,&
this.cb_1,&
this.dw_cam_carr}
end on

on w_cambios_de_carrera_nvo.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_2)
destroy(this.uo_estatus_posibles)
destroy(this.dw_revision_est)
destroy(this.dw_certificado)
destroy(this.uo_1)
destroy(this.st_espere)
destroy(this.dw_historico_cambio_carr)
destroy(this.dw_prerrequisitos)
destroy(this.uo_nombre)
destroy(this.ddlb_cambio_carrera)
destroy(this.cb_1)
destroy(this.dw_cam_carr)
end on

event open;// Juan Campos.  Abril-1997.
//Ultima Modificacion:	10-dic-2001
//Antonio Pica


This.x = 5
This.y = 5

st_espere.visible = False
st_espere.enabled = False
uo_nombre.em_cuenta.text = " "
triggerevent(doubleclicked!) 
  
i_n_security_valores_objeto = CREATE n_security_valores_objeto
idddw_child = uo_estatus_posibles.of_obten_datawindowchild()
i_n_security_valores_objeto.of_codes_dddw(idddw_child,"w_cambios_de_carrera_nvo","dddw_cambio_carrera")
end event

event doubleclicked;// Juan Campos.  Abril-1997.
 
Datawindowchild subsis 
dw_cam_carr.getchild('cve_subsistema',subsis)
subsis.settransobject(gtr_sce)
cuenta = long(uo_nombre.em_cuenta.text)

SELECT cve_carrera, cve_plan, cve_subsistema,nivel 
INTO	:CarreraActual, :PlanActual, :subsistemaActual,:NivelActual  
FROM academicos  
WHERE academicos.cuenta = :cuenta   using gtr_sce;
if isvalid(dw_cam_carr) then
	//if NivelActual = 'L' then
	if NivelActual <> 'P' then 
		subsis.retrieve(CarreraActual,PlanActual) 
	else
		subsis.retrieve(0,0)
	end if
end if
if dw_cam_carr.retrieve(long(uo_nombre.em_cuenta.text)) = 0 then
	dw_cam_carr.insertrow(0)
	uo_nombre.em_cuenta.setfocus()	
Else
	ddlb_cambio_carrera.text ="CAMBIO CARRERA"
end if		 


end event

event activate;control_escolar.toolbarsheettitle="Cambios de Carrera"
end event

event key;if keydown(KeyEnter!) Then
	dw_cam_carr.SetFocus()	
End if
end event

event close;IF ISVALID(i_n_security_valores_objeto) THEN
	DESTROY i_n_security_valores_objeto
END IF
end event

type cb_2 from commandbutton within w_cambios_de_carrera_nvo
boolean visible = false
integer x = 238
integer y = 484
integer width = 251
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;LONG ll_code_seleccionado

ll_code_seleccionado = uo_estatus_posibles.of_obten_seleccionado_long()
MessageBox("Valor",STRING(ll_code_seleccionado))
end event

type uo_estatus_posibles from uo_code_value within w_cambios_de_carrera_nvo
integer x = 1559
integer y = 1084
integer width = 873
integer height = 92
integer taborder = 50
end type

on uo_estatus_posibles.destroy
call uo_code_value::destroy
end on

type dw_revision_est from datawindow within w_cambios_de_carrera_nvo
boolean visible = false
integer x = 841
integer y = 444
integer width = 704
integer height = 228
integer taborder = 40
string dataobject = "dw_rev_est_fmc"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_certificado from datawindow within w_cambios_de_carrera_nvo
boolean visible = false
integer x = 82
integer y = 444
integer width = 704
integer height = 228
integer taborder = 30
string dataobject = "dw_certificado_ext2"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_1 from uo_per_ani within w_cambios_de_carrera_nvo
integer x = 2066
integer y = 444
integer width = 1253
integer height = 168
integer taborder = 20
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type st_espere from statictext within w_cambios_de_carrera_nvo
boolean visible = false
integer x = 1024
integer y = 1888
integer width = 2304
integer height = 352
integer textsize = -16
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HourGlass!"
long textcolor = 16711680
long backcolor = 10789024
boolean enabled = false
string text = "Actualizando Catálogos.       Espere..."
alignment alignment = center!
boolean border = true
long bordercolor = 16711680
end type

event getfocus;
setpointer(hourglass!)
SetPosition(ToTop!)
end event

type dw_historico_cambio_carr from datawindow within w_cambios_de_carrera_nvo
boolean visible = false
integer x = 37
integer y = 1856
integer width = 256
integer height = 160
integer taborder = 100
boolean enabled = false
string dataobject = "dw_historico_cambio_carr"
boolean livescroll = true
end type

event constructor;dw_historico_cambio_carr.settransObject(gtr_sce)
end event

type dw_prerrequisitos from datawindow within w_cambios_de_carrera_nvo
boolean visible = false
integer x = 329
integer y = 1856
integer width = 256
integer height = 160
integer taborder = 90
boolean enabled = false
string dataobject = "dw_prerrequisitos"
boolean livescroll = true
end type

event constructor;dw_prerrequisitos.settransObject(gtr_sce)

end event

type uo_nombre from uo_nombre_alumno within w_cambios_de_carrera_nvo
integer x = 78
integer y = 12
integer height = 428
integer taborder = 10
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

type ddlb_cambio_carrera from dropdownlistbox within w_cambios_de_carrera_nvo
integer x = 1646
integer y = 1084
integer width = 731
integer height = 320
integer taborder = 70
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean sorted = false
boolean vscrollbar = true
string item[] = {"CAMBIO CARRERA","NUEVA CARRERA"}
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_cambios_de_carrera_nvo
event keyboard pbm_keydown
integer x = 2450
integer y = 1084
integer width = 567
integer height = 124
integer taborder = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualiza"
end type

event keyboard;if keydown(keyenter!) Then
	TriggerEvent(Clicked!)
End if

end event

event clicked;// Juan Campos.  	Abril-1997.
// Modificado.		Mayo-1998.	 

Integer li_periodo, li_anio, li_cve_carrera, li_cve_plan, li_existe_plan = 0,li_cve_subsistema, li_cve_formaingreso, li_cve_formaingreso_ant
Integer li_creditos_cursados
String  ls_nivel_alumno,ls_nivel_carrera, ls_mensaje_sql
Boolean Continua = False, ObtenClaveAreas = False, ActualizaCatalogosOk
decimal ld_promedio_ant, ldc_creditos_totales_plan
integer li_sem_cursados_ant, li_creditos_cursados_ant, li_egresado_ant, li_periodo_egre_ant, li_anio_egre_ant
integer li_periodo_ing_ant, li_anio_ing_ant, li_codigo_sql, li_baja_disciplina, li_baja_documentos
integer li_cve_flag_promedio
dw_cam_carr.SetRow(1)
SetPointer(HourGlass!)
LONG ll_code_seleccionado

ll_code_seleccionado = uo_estatus_posibles.of_obten_seleccionado_long()



Select cred_total 
Into	:ldc_creditos_totales_plan
From	plan_estudios
Where	cve_carrera	= :CarreraActual And 
		cve_plan		= :PlanActual using gtr_sce;
		
If gtr_sce.sqlcode <> 0 Then
	Messagebox("Error al consultar plan de estudios",gtr_sce.sqlerrtext)
	Return
End if
li_baja_disciplina = f_obten_baja_disciplina(cuenta)

if li_baja_disciplina = -1 then
	Messagebox("Error al consultar las banderas de la cuenta :"+string(cuenta),&
	            "Reporte el caso con el area de Informatica")
	Return	
elseif li_baja_disciplina = 1 then
	Messagebox("PROCESO NO AUTORIZADO" ,"El alumno con cuenta :"+string(cuenta)+&
	            " se encuentra DADO DE BAJA POR DISCIPLINA")
	Return	
end if

li_baja_documentos = f_obten_baja_documentos(cuenta)

if li_baja_documentos = -1 then
	Messagebox("Error al consultar las banderas de la cuenta :"+string(cuenta),&
	            "Reporte el caso con el area de Informatica")
	Return	
elseif li_baja_documentos = 1 then
	Messagebox("PROCESO NO AUTORIZADO" ,"El alumno con cuenta :"+string(cuenta)+&
	            " se encuentra DADO DE BAJA POR DOCUMENTOS")
	Return	
end if

li_cve_flag_promedio = f_obten_baja_promedio(cuenta)

if li_cve_flag_promedio = -1 then
	Messagebox("Error al consultar las banderas de la cuenta :"+string(cuenta),&
	            "Reporte el caso con el area de Informatica")
	Return	
elseif li_cve_flag_promedio = 2 then
	Messagebox("PROCESO NO AUTORIZADO" ,"El alumno con cuenta :"+string(cuenta)+&
	            " se encuentra DADO DE BAJA POR PROMEDIO")
	Return	
end if


//If ddlb_cambio_carrera.text = "CAMBIO CARRERA" Then
//	li_cve_formaingreso	= 1
//ElseIf ddlb_cambio_carrera.text = "NUEVA CARRERA" Then
//	li_cve_formaingreso	= 2
//Else
//	Messagebox("Selecciona","CAMBIO CARRERA O NUEVA CARRERA")
//	Return
//End IF

If isnull(ll_code_seleccionado) Then
	Messagebox("Seleccionar forma de ingreso","No ha elegido la forma de ingreso o~n"+&
			"el usuario firmado no está autorizado para efectuar un cambio.", StopSign!)
	Return
else
	li_cve_formaingreso	= ll_code_seleccionado
End IF

if dw_cam_carr.RowCount()>0 then
	li_cve_formaingreso_ant  = dw_cam_carr.GetItemNumber(1,"cve_formaingreso")
end if

ii_cve_formaingreso= li_cve_formaingreso 
dw_cam_carr.SetItem(1,"cve_formaingreso",li_cve_formaingreso) 
li_creditos_cursados	= dw_cam_carr.GetItemNumber(1,"creditos_cursados",Primary!,True)	
//Ya no es necesario revisar los 90 creditos para el cambio de carrera
If (li_cve_formaingreso = 1) or &
   (li_cve_formaingreso = 2 And li_creditos_cursados >= ldc_creditos_totales_plan) or &
	(li_cve_formaingreso = 8) then		
	ls_nivel_alumno			 = dw_cam_carr.GetItemString(1,"nivel")
	li_cve_carrera				 = dw_cam_carr.GetItemNumber(1,"cve_carrera")
	li_cve_plan					 = dw_cam_carr.GetItemNumber(1,"cve_plan")
	li_cve_subsistema			 = dw_cam_carr.GetItemNumber(1,"cve_subsistema")
	ld_promedio_ant		    = dw_cam_carr.GetItemNumber(1,"promedio")
	li_sem_cursados_ant 		 = dw_cam_carr.GetItemNumber(1,"sem_cursados")
	li_creditos_cursados_ant = dw_cam_carr.GetItemNumber(1,"creditos_cursados")
	li_egresado_ant			 = dw_cam_carr.GetItemNumber(1,"egresado")
	li_periodo_egre_ant		 = dw_cam_carr.GetItemNumber(1,"periodo_egre")
	li_anio_egre_ant			 = dw_cam_carr.GetItemNumber(1,"anio_egre")
	li_periodo_ing_ant		 = dw_cam_carr.GetItemNumber(1,"periodo_ing")
	li_anio_ing_ant			 = dw_cam_carr.GetItemNumber(1,"anio_ing")

	
	Select nivel
	Into :ls_nivel_carrera
	From carreras
	Where cve_carrera = :li_cve_carrera using gtr_sce;
	
	If gtr_sce.sqlcode <> 0 Then
		Messagebox("Error al consultar Nivel de la carrera",gtr_sce.sqlerrtext)
		Return
	End if
	
	If ls_nivel_carrera<>"P" and (li_cve_formaingreso = 8) then		
		Messagebox("La carrera es de otro nivel académico","Revise el nivel académico de las carreras segun la forma de ingreso")
		dw_cam_carr.setcolumn("cve_carrera")
		Return
	End If // Nivel Carrera

	If ls_nivel_carrera = ls_nivel_alumno Then
		li_cve_plan = dw_cam_carr.GetItemNumber(1,"cve_plan")
		
		Select count(*)
		Into	:li_existe_plan
		From	plan_estudios
		Where	(cve_carrera = :li_cve_carrera And 
				cve_plan = :li_cve_plan) using gtr_sce;
				
		If gtr_sce.sqlcode <> 0 then
			Messagebox("No existe plan de estudios para esta carrera",gtr_sce.sqlerrtext)
			li_existe_plan = 0
			Return
		End If 
					
		If li_existe_plan > 0 Then
//			Periodo_Actual(li_periodo,li_anio,gtr_sce)	
			Periodo_Actual_mat_insc(li_periodo,li_anio,gtr_sce)	
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
			If ((dw_cam_carr.getitemnumber(1,"cve_carrera") <> CarreraActual) OR &
				(dw_cam_carr.getitemnumber(1,"cve_plan") <> PlanActual))Then
 				Continua = True      						
			Else
				Messagebox("La carrera es la misma que actualmente tiene inscrita","Intenta de nuevo")
				dw_cam_carr.Setcolumn("cve_Carrera")			
				Return
			End If
		Else
			Messagebox("Carrera/Plan inexistente", "No existe la carrera elegida con ese plan de estudios ")
			Return			
 		End If // Existe Plan
		
	Else
		Messagebox("La carrera es de otro nivel académico","Revise el nivel académico de las carreras")
		dw_cam_carr.setcolumn("cve_carrera")
		Return
	End If // Nivel Carrera
Else
	Messagebox("Aviso","No cumple con los créditos")
	uo_nombre.em_cuenta.Setfocus()
	Return
End If // Creditos cursados 			
   
if Continua Then
	if Messagebox("Actualización de catálogos","Está seguro que desea continuar",Question!,YesNo!,1) = 1 then
   	st_espere.visible = True 
		st_espere.enabled = True      
		st_espere.x = 764
		st_espere.y = 861
		st_espere.setfocus()
		
		If Revalida_Materias(cuenta,li_cve_carrera,li_cve_plan,ls_nivel_alumno, CarreraActual,PlanActual) then
			dw_cam_carr.AcceptText( )
			If dw_cam_carr.update(true) = 1 then		
//				If Inserta_hist_carreras(Cuenta,li_cve_formaingreso,CarreraActual,PlanActual,li_cve_carrera,li_cve_plan,li_periodo,li_anio,subsistemaActual,li_cve_subsistema) Then
				If Inserta_hist_carreras(Cuenta,li_cve_formaingreso,CarreraActual,PlanActual,& 
				   li_cve_carrera,li_cve_plan,li_periodo_ing_ant,li_anio_ing_ant,subsistemaActual,li_cve_subsistema, &
					ld_promedio_ant, li_sem_cursados_ant, li_creditos_cursados_ant, li_egresado_ant, &
					li_periodo_egre_ant, li_anio_egre_ant, li_periodo_ing_ant, li_anio_ing_ant, li_cve_formaingreso_ant) Then

					If Actualiza_academ_banderas(cuenta,li_cve_carrera,li_cve_plan,ls_nivel_alumno) Then
						ActualizaCatalogosOk= True
					Else
						ActualizaCatalogosOk= false
					End If // actualiza_academ_banderas
				Else
					ActualizaCatalogosOk= false
				End If // inserta_hist_carreras
			Else
				ActualizaCatalogosOk= false
			End If // dw_academicos_cambio_carr  update
		Else
			ActualizaCatalogosOk= false
		End If // Revalida_materias 

		st_espere.x = 1025
		st_espere.y = 1889
		st_espere.visible = False
		st_espere.enabled = False  	
		li_codigo_sql= gtr_sce.sqlcode
		ls_mensaje_sql= gtr_sce.sqlerrtext
		If ActualizaCatalogosOk Then
			Commit using gtr_sce;
			dw_cam_carr.Retrieve(cuenta)
			Messagebox("Aviso","Los cambios fueron guardados.")
			w_cambios_de_carrera_nvo.triggerevent("doubleclicked")
		Else
			Rollback  using gtr_sce;
			Messagebox("Aviso","Los cambios No se guardaron : "+ls_mensaje_sql)
			w_cambios_de_carrera_nvo.triggerevent("doubleclicked")
		End If

	Else	
		uo_nombre.em_cuenta.setfocus()
	End If // Actualiza Catalogos
End If // continua
 
end event

type dw_cam_carr from datawindow within w_cambios_de_carrera_nvo
event keyboard pbm_dwnkey
integer x = 78
integer y = 608
integer width = 3241
integer height = 1212
integer taborder = 60
string dataobject = "dw_academicos_cambio_carr_nvo"
boolean resizable = true
boolean livescroll = true
end type

event constructor;dw_cam_carr.SetTransObject(gtr_sce)
end event

event itemchanged;string ls_carrera, ls_columna, ls_plan, ls_nivel
integer li_carrera, li_plan
long ll_row

ll_row = this.GetRow()

this.AcceptText()

ls_columna =this.GetColumnName()

li_carrera = object.cve_carrera[ll_row]
ls_nivel = f_obten_nivel(li_carrera)

choose case ls_columna 
case 'cve_carrera' 
	object.nivel[ll_row]= ls_nivel

end choose


end event

