$PBExportHeader$w_cambios_de_carrera.srw
$PBExportComments$Se realiza el proceso de cambio de carrera de alumnos.   Juan Campos. Marzo-1997
forward
global type w_cambios_de_carrera from window
end type
type st_espere from statictext within w_cambios_de_carrera
end type
type dw_historico_cambio_carr from datawindow within w_cambios_de_carrera
end type
type dw_prerrequisitos from datawindow within w_cambios_de_carrera
end type
type uo_nombre from uo_nombre_alumno within w_cambios_de_carrera
end type
type ddlb_cambio_carrera from dropdownlistbox within w_cambios_de_carrera
end type
type cb_1 from commandbutton within w_cambios_de_carrera
end type
type dw_cam_carr from datawindow within w_cambios_de_carrera
end type
end forward

global type w_cambios_de_carrera from window
integer x = 832
integer y = 352
integer width = 3424
integer height = 1988
boolean titlebar = true
string title = "CAMBIO DE CARRERA"
string menuname = "m_cambios_de_carrera"
boolean controlmenu = true
long backcolor = 27291696
st_espere st_espere
dw_historico_cambio_carr dw_historico_cambio_carr
dw_prerrequisitos dw_prerrequisitos
uo_nombre uo_nombre
ddlb_cambio_carrera ddlb_cambio_carrera
cb_1 cb_1
dw_cam_carr dw_cam_carr
end type
global w_cambios_de_carrera w_cambios_de_carrera

type variables
long     Cuenta
Integer CarreraActual
integer PlanActual
integer subsistemaActual
Char     NIvelActual
end variables

forward prototypes
public function boolean actualiza_academ_banderas (long cuenta_academ, integer carrera_academ, integer plan_academ, character nivel_academ)
public function boolean inserta_hist_carreras (long cuenta_hist_carr, integer ingreso_hist_carr, integer carr_ant_hist_carr, integer plan_ant_hist_carr, integer carr_act_hist_carr, integer plan_act_hist_carr, integer periodo_hist_carr, long año_hist_carr, integer subsis_ant, integer subsis_act)
public function boolean revalida_materias (long cuenta_hist, integer carrera_nueva, integer plan_nuevo, string nivel)
end prototypes

public function boolean actualiza_academ_banderas (long cuenta_academ, integer carrera_academ, integer plan_academ, character nivel_academ);// Actualiza la tabla de academicos en sus campos de , promedio y creditos.
// y de acuerdo al nuevo promedio y los nuevos creditos,  se actualiza:
// flag_promedio, Flag_75%, Flag_sevicio_social,Inscrito_sem_ant,Prerrequisito_ingles,Area_integracion
// Si la actualización es existosa la función regresa "True"
// Juan Campos. Abril-1997.

Int Carrera, Plan, CveFlagPromedio,CveFlagServSocial,InscritoAnterior
Decimal creditos 
Int     CreditosServicioSocial,CreditosPuntaje
Real    promedio,PuntajeMinimo
Char    NivelAcademico
Boolean PromCredOk, ActualizaBanderas,Banderas

PromCredOk = False
Banderas   = False
ActualizaBanderas = False
		
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

UPDATE academicos
   SET promedio = :promedio , creditos_cursados = CONVERT(INT, :creditos)
 WHERE cuenta = :cuenta_academ
 USING gtr_sce;

IF gtr_sce.sqlcode = 0 Then   
	PromCredOk = True
	commit using gtr_sce;			//aaa
	return actualiza_bandera(cuenta_academ,1)		//aaa
ElseIf gtr_sce.sqlcode = 100 Then
 	PromCredOk  = False
	MessageBox("Error","Al modificar el promedio y los creditos de este alumno")	
ElseIf gtr_sce.sqlcode = -1 Then 
	PromCredOk  = False
	MessageBox("Error ",gtr_sce.sqlerrtext)
Else
	PromCredOk  = False
End If

 			
//If PromCredOk Then 
//   SELECT puntaje_min,cred_serv_social,cred_puntaje 
//     INTO :PuntajeMinimo,:CreditosServicioSocial,:CreditosPuntaje
//     FROM plan_estudios
//    WHERE (cve_carrera = :carrera_academ) and
//	       (cve_plan    = :plan_academ)
//   USING gtr_sce;	
//	
//   IF gtr_sce.sqlcode = 0 Then  
//	   SELECT insc_sem_ant,cve_flag_promedio,cve_flag_serv_social
//        INTO :InscritoAnterior,:CveFlagPromedio,:CveFlagServSocial
//        FROM banderas
//       WHERE cuenta = :cuenta_academ
//       USING gtr_sce;	
//	   IF gtr_sce.sqlcode = 0 Then 
//		   Banderas = True
//	   ElseIf gtr_sce.sqlcode = 100 Then 
//		   Banderas = False
//		   MessageBox("Error ","Al obtener banderas de este alumno")
//	   ElseIf gtr_sce.sqlcode = -1 Then
//		   Banderas = False
//		   MessageBox("Error",gtr_sce.sqlerrtext)
//	   Else  
//		   Banderas = False
//	   End if
//   Else
// 	   Banderas = False
//	   MessageBox("Error al obtener banderas de este alumno ",gtr_sce.sqlerrtext)
//   End If
//End if
//
//If Banderas Then 
//	ActualizaBanderas = True
//	
//	If InscritoAnterior = 0 Then  // 0 = InscritoAnterior No
//	   UPDATE banderas
//         SET insc_sem_ant = 1    // 1 = InscritoAnterior Si
//       WHERE cuenta = :cuenta_academ
//       USING gtr_sce;
//	   IF gtr_sce.sqlcode = -1  Then  
//			ActualizaBanderas  = False
//	   	MessageBox("Error","No se actualizo la bandera de: Inscrito_Semestre_Anterior. "+gtr_sce.sqlerrtext)
//    	End If		
//   end if
//	
//   IF NivelAcademico = "P" and CveFlagPromedio <> 0 Then 
//      UPDATE banderas
//         SET cve_flag_promedio = 0   // Normal
//       WHERE cuenta = :cuenta_academ
//       USING gtr_sce;
//	   IF gtr_sce.sqlcode = -1 Then     
// 	   	ActualizaBanderas  = False
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
// 	        		ActualizaBanderas  = False
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
// 	        		 ActualizaBanderas  = False
//	        		 MessageBox("Error","No se actualizo la bandera de: creditos 75%. "+gtr_sce.sqlerrtext)
//         	 End If	
//		   end if
//			
//         IF promedio >= PuntajeMinimo Then 
//	     		IF CveflagPromedio = 1 or CveFlagPromedio = 2 Then 
//               UPDATE banderas
//             		SET cve_flag_promedio = 0   // Normal
//           		 WHERE cuenta = :cuenta_academ
//           		USING gtr_sce;
//		     		IF gtr_sce.sqlcode = -1 Then   
// 	          		ActualizaBanderas  = False
//	          		MessageBox("Error","No se actualizo la bandera de: flag_promedio. "+gtr_sce.sqlerrtext)
//           		End If			
//		  		End if	
//      	Else  // puntaje minimo
//		  		IF CveFlagPromedio = 0 or CveFlagPromedio = 3 Then 
//		    		UPDATE banderas
//             		SET cve_flag_promedio = 1   // Amonestado
//           		 WHERE cuenta = :cuenta_academ
//           		 USING gtr_sce;
//		     		IF gtr_sce.sqlcode = -1 Then   
// 	          		ActualizaBanderas  = False
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
// 	          		ActualizaBanderas  = False
//	          		MessageBox("Error","No se actualizo la bandera de: flag_promedio. "+gtr_sce.sqlerrtext)												 
//           		End If	  
//		  		End If// CveFlagPromedio = 1		  
//         End If// puntaje minimo			  
//      End If// Creditos puntaje 
//
//	   IF creditos >= CreditosServicioSocial Then 
//	   	UPDATE banderas
//         	SET cve_flag_serv_social = 1  // Ya puede cursar
//       	 WHERE cuenta = :cuenta_academ
//       	 USING gtr_sce;
//		 	IF gtr_sce.sqlcode = -1 Then   
// 	      	ActualizaBanderas  = False
//	      	MessageBox("Error","No se actualizo la bandera de: flag_serv_social. "+gtr_sce.sqlerrtext)
//       	End If
//		else
//			UPDATE banderas
//         	SET cve_flag_serv_social = 0  // No ha cursado
//       	 WHERE cuenta = :cuenta_academ
//       	 USING gtr_sce;
//		 	IF gtr_sce.sqlcode = -1 Then   
// 	      	ActualizaBanderas  = False
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
//					ActualizaBanderas  = False
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
//  ActualizaBanderas  = False
//End IF // banderas
//
//If ActualizaBanderas Then 
//  Return True	
//End if

Error:
  Messagebox("Ocurrio un Error",gtr_sce.sqlerrtext)
  Rollback Using gtr_sce;
  Return False
	  	  
end function

public function boolean inserta_hist_carreras (long cuenta_hist_carr, integer ingreso_hist_carr, integer carr_ant_hist_carr, integer plan_ant_hist_carr, integer carr_act_hist_carr, integer plan_act_hist_carr, integer periodo_hist_carr, long año_hist_carr, integer subsis_ant, integer subsis_act);// hace un insert a la tabla de hist_carreras, consulta que no este repetido 
// para el mismo periodo y año. Regresa "True" si el insert es exitoso.
// Juan Campos. Abril-1997.

integer Existe
boolean MovimientoOk

select count(*)
into	:Existe
from	hist_carreras
where (cuenta       = :cuenta_hist_carr) and
		(periodo_ing  = :periodo_hist_carr) and
		(anio_ing     = :año_hist_carr) using gtr_sce;
		  
if gtr_sce.sqlcode = -1 Then
	MovimientoOk = False
	Messagebox("Error al consultar historico carreras",gtr_sce.sqlerrtext)
Else
	MovimientoOk = True
End if 

if MovimientoOk Then
	if Existe = 0 then		
 		Insert Into hist_carreras values (:Cuenta_hist_carr,
		                                  :ingreso_hist_carr,
													 :carr_ant_hist_carr,
													 :plan_ant_hist_carr,
													 :subsis_ant, 
													 :carr_act_hist_carr,
													 :plan_act_hist_carr,
													 :subsis_act,
													 :Periodo_hist_carr,
													 :Año_hist_carr)
		Using gtr_sce;	
		if gtr_sce.sqlcode = 0 Then			
		   MovimientoOk = True
	   Else
         MovimientoOk = False
			MessageBox("Error al actualizar la tabla de hist_carreras",gtr_sce.sqlerrtext)
		end if
	else
		MovimientoOk = False
		Messagebox("Error","El alumno ya tiene registrado un movimiento de carrera para el período próximo, Revise el histórico de carreras de esté alumno")
	end if
end if
												
if MovimientoOk Then
	Return True
else
	Return False
end if
end function

public function boolean revalida_materias (long cuenta_hist, integer carrera_nueva, integer plan_nuevo, string nivel);// Juan Campos. Abril-1997.
// Revalida las materias que sean de la misma carrera y plan
// Modificado. Marzo-1998.


DataStore dw_mat_prerrequisito
dw_mat_prerrequisito = CREATE DataStore

If Nivel = 'L' Then 
	dw_mat_prerrequisito.DataObject = "dw_mat_prerrequisito"
Else
	dw_mat_prerrequisito.DataObject = "dw_mat_prerrequisito_pos"
End if
dw_mat_prerrequisito.Settransobject(gtr_sce) 

Integer i,MateriaHist ,Per,Año,Obs,Existe
String Gpo,Calif
IF dw_historico_cambio_carr.retrieve(cuenta_hist) > 0 Then
  For i = 1 to dw_historico_cambio_carr.RowCount()
		MateriaHist = dw_historico_cambio_carr.GetItemNumber(i,"cve_mat")
		IF MateriaHist = 3748 OR MateriaHist = 8763 Then		
			//Ojo No Incluye a el servicio social			
		Else
         IF (MateriaHist = 4078) or & 
		 	   (dw_mat_prerrequisito.Retrieve(MateriaHist,Carrera_Nueva,Plan_Nuevo) > 0) Then // Si es mayor a cero, la materia si pertenece a la carrera y plan nuevo
				If Revisa_Prerreq_Cambio_Carr(Cuenta_hist,MateriaHist,Carrera_nueva,Plan_Nuevo,Nivel) Then 
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

on w_cambios_de_carrera.create
if this.MenuName = "m_cambios_de_carrera" then this.MenuID = create m_cambios_de_carrera
this.st_espere=create st_espere
this.dw_historico_cambio_carr=create dw_historico_cambio_carr
this.dw_prerrequisitos=create dw_prerrequisitos
this.uo_nombre=create uo_nombre
this.ddlb_cambio_carrera=create ddlb_cambio_carrera
this.cb_1=create cb_1
this.dw_cam_carr=create dw_cam_carr
this.Control[]={this.st_espere,&
this.dw_historico_cambio_carr,&
this.dw_prerrequisitos,&
this.uo_nombre,&
this.ddlb_cambio_carrera,&
this.cb_1,&
this.dw_cam_carr}
end on

on w_cambios_de_carrera.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_espere)
destroy(this.dw_historico_cambio_carr)
destroy(this.dw_prerrequisitos)
destroy(this.uo_nombre)
destroy(this.ddlb_cambio_carrera)
destroy(this.cb_1)
destroy(this.dw_cam_carr)
end on

event open;// Juan Campos.  Abril-1997.

This.x = 5
This.y = 5

st_espere.visible = False
st_espere.enabled = False
uo_nombre.em_cuenta.text = " "
triggerevent(doubleclicked!) 
  


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
	if NivelActual = 'L' then
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

type st_espere from statictext within w_cambios_de_carrera
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

type dw_historico_cambio_carr from datawindow within w_cambios_de_carrera
boolean visible = false
integer x = 37
integer y = 1856
integer width = 256
integer height = 160
integer taborder = 60
boolean enabled = false
string dataobject = "dw_historico_cambio_carr"
boolean livescroll = true
end type

event constructor;dw_historico_cambio_carr.settransObject(gtr_sce)
end event

type dw_prerrequisitos from datawindow within w_cambios_de_carrera
boolean visible = false
integer x = 329
integer y = 1856
integer width = 256
integer height = 160
integer taborder = 50
boolean enabled = false
string dataobject = "dw_prerrequisitos"
boolean livescroll = true
end type

event constructor;dw_prerrequisitos.settransObject(gtr_sce)

end event

type uo_nombre from uo_nombre_alumno within w_cambios_de_carrera
integer x = 78
integer y = 28
integer taborder = 10
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

type ddlb_cambio_carrera from dropdownlistbox within w_cambios_de_carrera
integer x = 1646
integer y = 960
integer width = 731
integer height = 320
integer taborder = 30
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

type cb_1 from commandbutton within w_cambios_de_carrera
event keyboard pbm_keydown
integer x = 2450
integer y = 960
integer width = 567
integer height = 124
integer taborder = 40
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

Integer Periodo, Año, Carrera, Plan, ExistePlan = 0,subsistema, Ingreso
Integer CreditosCursados
Decimal CreditosTotalesPlan
String  NivelAlumno,NivelCarrera
Boolean Continua = False, ObtenClaveAreas = False, ActualizaCatalogosOk
	
dw_cam_carr.SetRow(1)
SetPointer(HourGlass!)

Select cred_total 
Into	:CreditosTotalesPlan
From	plan_estudios
Where	cve_carrera	= :CarreraActual And 
		cve_plan		= :PlanActual using gtr_sce;
		
If gtr_sce.sqlcode <> 0 Then
	Messagebox("Error al consultar plan de estudios",gtr_sce.sqlerrtext)
	Return
End if
		
If ddlb_cambio_carrera.text = "CAMBIO CARRERA" Then
	Ingreso	= 1
ElseIf ddlb_cambio_carrera.text = "NUEVA CARRERA" Then
	Ingreso	= 2
Else
	Messagebox("Selecciona","CAMBIO CARRERA O NUEVA CARRERA")
	Return
End IF
dw_cam_carr.SetItem(1,"cve_formaingreso",Ingreso) 
CreditosCursados	= dw_cam_carr.GetItemNumber(1,"creditos_cursados",Primary!,True)	

If (Ingreso = 1 And CreditosCursados >= 90) or &
	(Ingreso = 2 And CreditosCursados >= CreditosTotalesPlan) then		
	NivelAlumno	= dw_cam_carr.GetItemString(1,"nivel")
	Carrera		= dw_cam_carr.GetItemNumber(1,"cve_carrera")
	Plan			= dw_cam_carr.GetItemNumber(1,"cve_plan")
	Subsistema	= dw_cam_carr.GetItemNumber(1,"cve_subsistema")
	
	Select nivel
	Into :NivelCarrera
	From carreras
	Where cve_carrera = :carrera using gtr_sce;
	
	If gtr_sce.sqlcode <> 0 Then
		Messagebox("Error al consultar Nivel de la carrera",gtr_sce.sqlerrtext)
		Return
	End if

	If NivelCarrera = NivelAlumno Then
		Plan = dw_cam_carr.GetItemNumber(1,"cve_plan")
		
		Select count(*)
		Into	:ExistePlan
		From	plan_estudios
		Where	(cve_carrera = :carrera And 
				cve_plan = :plan) using gtr_sce;
				
		If gtr_sce.sqlcode <> 0 then
			Messagebox("No existe plan de estudios para esta carrera",gtr_sce.sqlerrtext)
			ExistePlan = 0
			Return
		End If 
					
		If ExistePlan > 0 Then
			Periodo_Actual(Periodo,Año,gtr_sce)	
			Choose Case Periodo
			Case 0 to 1
					Periodo = Periodo + 1
			Case 2
   				Periodo = Periodo - 2
   				Año = Año + 1 
			Case Else	
			End Choose
			dw_cam_carr.SetItem(1, "cve_subsistema",0)
			If ingreso = 2 Then
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
			Messagebox("No existe la carrera elegida con ese plan de estudios ",gtr_sce.sqlerrtext)
			ExistePlan = 0
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
		
		If Revalida_Materias(cuenta,carrera,plan,NivelAlumno) then
			dw_cam_carr.AcceptText( )
			If dw_cam_carr.update(true) = 1 then		
				If Inserta_hist_carreras(Cuenta,Ingreso,CarreraActual,PlanActual,Carrera,Plan,periodo,año,subsistemaActual,subsistema) Then
					If Actualiza_academ_banderas(cuenta,carrera,plan,NivelAlumno) Then
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
		
		If ActualizaCatalogosOk Then
			Commit using gtr_sce;
			dw_cam_carr.Retrieve(cuenta)
			Messagebox("Aviso","Los cambios fueron guardados.")
		Else
			Rollback  using gtr_sce;
			Messagebox("Aviso","Los cambios No se guardaron")
		End If

	Else	
		uo_nombre.em_cuenta.setfocus()
	End If // Actualiza Catalogos
End If // continua
 
end event

type dw_cam_carr from datawindow within w_cambios_de_carrera
event keyboard pbm_dwnkey
integer x = 73
integer y = 448
integer width = 3255
integer height = 1312
integer taborder = 20
string dataobject = "dw_academicos_cambio_carr"
boolean resizable = true
boolean livescroll = true
end type

event constructor;dw_cam_carr.SetTransObject(gtr_sce)
end event

