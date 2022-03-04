$PBExportHeader$w_acred_sersoc_opcterm_2013.srw
$PBExportComments$Se realizan los procesos de acreditación:  servicio social y opción terminal.  Juan Campos .  Marzo-1997.
forward
global type w_acred_sersoc_opcterm_2013 from w_master_main
end type
type uo_nombre from uo_carreras_alumno_lista within w_acred_sersoc_opcterm_2013
end type
type dw_acred_sersoc_opcterm from uo_master_dw within w_acred_sersoc_opcterm_2013
end type
end forward

global type w_acred_sersoc_opcterm_2013 from w_master_main
integer width = 3854
integer height = 2668
string menuname = "m_acreditacion_altasbajascambios_2013"
boolean maxbox = false
uo_nombre uo_nombre
dw_acred_sersoc_opcterm dw_acred_sersoc_opcterm
end type
global w_acred_sersoc_opcterm_2013 w_acred_sersoc_opcterm_2013

type variables
long il_carrera,il_cuenta,il_cve_plan,il_opcion,il_materia
string is_nom_ventana,is_nivel
Datawindowchild dwc_periodo

end variables

forward prototypes
public function integer wf_validar ()
public function string wf_genera_sql (integer ai_tipo, long al_cuenta, long al_materia)
end prototypes

public function integer wf_validar ();string ls_periodo
int li_periodo, li_anio

uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios

if dw_acred_sersoc_opcterm.ModifiedCount( ) > 0 then
	li_anio = idw_trabajo.GetItemNumber(dw_acred_sersoc_opcterm.Getrow(),"anio")
	if li_anio < uo_nombre.istr_carrera.str_anio_ing then
		messagebox('Aviso','El año capturado no puede ser menor a: ' + string(uo_nombre.istr_carrera.str_anio_ing))
		return -1
	end if
	li_periodo = idw_trabajo.GetItemNumber(dw_acred_sersoc_opcterm.Getrow(),"periodo")
	if li_periodo < uo_nombre.istr_carrera.str_periodo_ing and  li_anio <= uo_nombre.istr_carrera.str_anio_ing then

		ls_periodo = UPPER(luo_periodo_servicios.f_recupera_desc_periodo(gtr_sce, uo_nombre.istr_carrera.str_periodo_ing))
		
		IF luo_periodo_servicios.ierror = -1 THEN 
			MessageBox(luo_periodo_servicios.ititulo, luo_periodo_servicios.imensaje, StopSign!)
			RETURN luo_periodo_servicios.ierror
		END IF	

//		choose case uo_nombre.istr_carrera.str_periodo_ing
//		case 0
//			ls_periodo = 'PRIMAVERA'
//		case 1
//			ls_periodo = 'VERANO'
//		case 2
//			ls_periodo = 'OTOÑO'
//		end choose

		messagebox('Aviso','El periodo capturado no puede ser menor a: ' + ls_periodo)
		return -1
	end if
	
	return 1
elseif dw_acred_sersoc_opcterm.DeletedCount( ) > 0 THEN 
	return 1
else
	return -1
end if
end function

public function string wf_genera_sql (integer ai_tipo, long al_cuenta, long al_materia);
// Función que genera el código de SQL 

STRING ls_sql 
STRING ls_materia

// Si se trata de inglés 
IF ai_tipo = 3 THEN 
	ls_materia = " historico.cve_mat IN( " + & 
						" SELECT cve_mat " + &  
						" FROM materias_requisito " + &  
						" WHERE id_prerrequisito = ~~'ING~~') "
ELSE
	ls_materia = " historico.cve_mat = " + STRING(al_materia) + " " 
END IF

ls_sql = " SELECT historico.cuenta, " + &
			" historico.cve_mat, " + &
			" historico.gpo, " + &
			" historico.periodo, " + &
			" historico.anio, " + &
			" historico.cve_carrera, " + &
			" historico.cve_plan, " + &
			" historico.calificacion, " + &
			" historico.observacion, " + &
			" materias.materia, " + &
			" periodo.descripcion " + &  
	 " FROM historico, " + &
			" materias, " + &
			" periodo " + &
	" WHERE ( historico.cve_mat = materias.cve_mat ) and " + &
			" ( historico.periodo = periodo.periodo ) and " + &
			" (historico.cuenta = " + STRING(al_cuenta) + ") AND " + &
			" (" + ls_materia + ")  " 

RETURN ls_sql




end function

on w_acred_sersoc_opcterm_2013.create
int iCurrent
call super::create
if this.MenuName = "m_acreditacion_altasbajascambios_2013" then this.MenuID = create m_acreditacion_altasbajascambios_2013
this.uo_nombre=create uo_nombre
this.dw_acred_sersoc_opcterm=create dw_acred_sersoc_opcterm
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_nombre
this.Control[iCurrent+2]=this.dw_acred_sersoc_opcterm
end on

on w_acred_sersoc_opcterm_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nombre)
destroy(this.dw_acred_sersoc_opcterm)
end on

event closequery;//
end event

event doubleclicked;call super::doubleclicked;/*	1 = AC SERVICIO SOCIAL
	2 = AC OPCION TERMINAL
	3 = AC PREREQUISITO INGLÉS
*/
Long 	CveOpcterm = 0,CveSemTit = 0,CveProyOpcTerm = 0
int Modifica_Periodo
string ls_materia
long ll_cuenta , ll_cve_area_servicio_social,  ll_cve_mat_ss
int li_obten_area_mat_ss
STRING ls_sql

il_cuenta = long(uo_nombre.of_obten_cuenta())
il_carrera = uo_nombre.istr_carrera.str_cve_carrera
il_cve_plan = uo_nombre.istr_carrera.str_cve_plan
is_nivel = uo_nombre.istr_carrera.str_nivel

if il_carrera = 0 then return

dw_acred_sersoc_opcterm.Reset()

choose case il_opcion
	case 1	
		//If is_nivel = "L" Then // Nivel
		If is_nivel <> "P" Then // Nivel 

//2016-04-06:Corregido para que obtenga la clave de materia en función del área						  
//	
//   			If il_cve_plan = 1 or il_cve_plan = 2 Then
//    				il_materia = 3748   
//   			ElseIF il_cve_plan = 3 Or il_cve_plan = 4 Or il_cve_plan = 6 Then
//	      		il_materia = 8763 
//       		Else
//        			MessageBox("Aviso","Revise el plan de estudios de este alumno")		
//				dw_acred_sersoc_opcterm.Reset()					  
//		   		Return
//			End if
			ll_cuenta=il_cuenta
			
			 li_obten_area_mat_ss= f_obten_area_mat_ss(ll_cuenta,	ll_cve_area_servicio_social,  ll_cve_mat_ss) 
			 if li_obten_area_mat_ss <> 0 then
					Messagebox("Error","No es posible insertar la materia de servicio social", StopSign!)
					return
			end if

			il_materia = ll_cve_mat_ss
			
			//**--****--****--****--**
			// Se genera cadena de query
			ls_sql = wf_genera_sql(1, il_cuenta,il_materia)
			dw_acred_sersoc_opcterm.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'")			
			//**--****--****--****--**
			
   			if dw_acred_sersoc_opcterm.Retrieve(il_cuenta,il_materia) = 0 Then
	  			Messagebox("Aviso","El alumno no tiene la materia de servicio social")
				dw_acred_sersoc_opcterm.Reset()					  
		   		Return
			end if
		
			m_acreditacion_altasbajascambios_2013.m_bajas.enabled = False
			m_acreditacion_altasbajascambios_2013.m_cambios.enabled = True
			m_acreditacion_altasbajascambios_2013.m_altas.enabled = False
		else
  			Messagebox("Aviso","Solo alumnos de licenciatura")
			dw_acred_sersoc_opcterm.Reset()
			return
		end if
	case 2
		If obten_cve_opcion_terminal(il_carrera,il_cve_plan,CveOpcterm,CveSemTit,CveProyOpcTerm) Then
			prerrequisito_opcterm(il_cuenta,CveSemTit,CveProyOpcTerm)
			if CveProyOpcTerm > 0 Then					
				
				//**--****--****--****--**
				// Se genera cadena de query
				ls_sql = wf_genera_sql(2, il_cuenta,CveOpcterm)
				dw_acred_sersoc_opcterm.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'")			
				//**--****--****--****--**				
				
	  			If dw_acred_sersoc_opcterm.Retrieve(il_cuenta,CveOpcterm) = 0 Then	
					select materia
						into :ls_materia
					from materias 
					where cve_mat =:CveOpcterm using gtr_sce;
		    			m_acreditacion_altasbajascambios_2013.m_bajas.enabled = False
		    			m_acreditacion_altasbajascambios_2013.m_cambios.enabled = False
		    			m_acreditacion_altasbajascambios_2013.m_altas.enabled = True
					dw_acred_sersoc_opcterm.Insertrow(0)
		  			dw_acred_sersoc_opcterm.SetItem(1,"cuenta",il_cuenta)
	     			dw_acred_sersoc_opcterm.SetItem(1,"cve_mat",CveOpcterm) 
  	     			dw_acred_sersoc_opcterm.SetItem(1,"materias_materia",ls_materia) 
	     			dw_acred_sersoc_opcterm.SetItem(1,"cve_plan",il_cve_plan) 
	     			dw_acred_sersoc_opcterm.SetItem(1,"cve_carrera",il_carrera)     
		     		dw_acred_sersoc_opcterm.SetItem(1,"calificacion","AC")      
	   		  		dw_acred_sersoc_opcterm.SetItem(1,"periodo",gi_periodo)      
	     			dw_acred_sersoc_opcterm.SetItem(1,"anio",gi_anio)      					  
	    			Else	
		    			m_acreditacion_altasbajascambios_2013.m_altas.enabled = False
		 			m_acreditacion_altasbajascambios_2013.m_bajas.enabled = True
		    			m_acreditacion_altasbajascambios_2013.m_cambios.enabled = True
        			End IF // retrieve data window 
			else 
	  			MessageBox("Aviso","El alumno no cumple con los prerrequisitos de: "+String(CveSemTit)+" "+String(CveProyOpcTerm)+" "+ "para acreditar La opción Terminal")
				dw_acred_sersoc_opcterm.Reset()
				return			
			end if
		else
			Messagebox("Aviso","Revisé que el plan de estudios de esté alumno tenga cargada la:  cve_area_opción terminal, ")
			MessageBox("Aviso","El catalógo Aux_Opcion_terminal , contiene las materias que son prerrequsito para acreditar la materia de opción_terminal, verifique que se encuentren cargadas")	
			dw_acred_sersoc_opcterm.Reset()
			return
		end if				
	case 3
		//If is_nivel = "L" Then // Nivel
		If is_nivel <> "P" Then // Nivel
      		//il_materia = 4078         		
			il_materia = 0
				
			//**--****--****--****--**
			// Se genera cadena de query
			ls_sql = wf_genera_sql(3, il_cuenta,il_materia)
			dw_acred_sersoc_opcterm.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'")			
			//**--****--****--****--**								
				
	   		if dw_acred_sersoc_opcterm.Retrieve(il_cuenta,il_materia) = 0 Then
				Messagebox("Aviso","El alumno no tiene la materia del Prerrequisito de Inglés")
				
				SELECT cve_mat 
				INTO :il_materia
				FROM materias_requisito 
				WHERE id_prerrequisito = 'ING' 
				using gtr_sce; 
				
				select materia
						into :ls_materia
					from materias 
					where cve_mat =:il_materia using gtr_sce;
	    			dw_acred_sersoc_opcterm.InsertRow(0)			
				dw_acred_sersoc_opcterm.SetItem(1,"cuenta",il_cuenta)
	     		dw_acred_sersoc_opcterm.SetItem(1,"cve_mat",il_materia) 
				dw_acred_sersoc_opcterm.SetItem(1,"materias_materia",ls_materia) 
	     		dw_acred_sersoc_opcterm.SetItem(1,"cve_plan",il_cve_plan) 
	     		dw_acred_sersoc_opcterm.SetItem(1,"cve_carrera",il_carrera)      
	     		dw_acred_sersoc_opcterm.SetItem(1,"gpo","Z")      
	     		dw_acred_sersoc_opcterm.SetItem(1,"calificacion","AC")      
	     		dw_acred_sersoc_opcterm.SetItem(1,"periodo",gi_periodo)      
	     		dw_acred_sersoc_opcterm.SetItem(1,"anio",gi_anio)      
	     		dw_acred_sersoc_opcterm.SetItem(1,"observacion",3) //Ordinario     
			End if
 			m_acreditacion_altasbajascambios_2013.m_bajas.enabled = True
    			m_acreditacion_altasbajascambios_2013.m_cambios.enabled = True	
			m_acreditacion_altasbajascambios_2013.m_altas.enabled = False				 
		else
  			Messagebox("Aviso","Solo alumnos de licenciatura")
			dw_acred_sersoc_opcterm.Reset()
			return
		end if
end choose

dw_acred_sersoc_opcterm.SetTabOrder(3,0)
dw_acred_sersoc_opcterm.SetTabOrder(4,0)
dw_acred_sersoc_opcterm.SetTabOrder(5,0)
dw_acred_sersoc_opcterm.SetTabOrder(8,0)
dw_acred_sersoc_opcterm.SetTabOrder(9,0)
	
if il_opcion = 1 or il_opcion = 3 then
	
	Modifica_Periodo = MessageBox("Aviso","Desea Modificar el periodo",Question!,YesNo!,2)
	IF  ModIFica_Periodo = 1 Then 
		if il_opcion = 1 then
			dw_acred_sersoc_opcterm.SetTabOrder(4,1)
			dw_acred_sersoc_opcterm.SetTabOrder(5,2)
			dw_acred_sersoc_opcterm.SetTabOrder(8,3)   
		else
			dw_acred_sersoc_opcterm.SetTabOrder(3,1)
			dw_acred_sersoc_opcterm.SetTabOrder(4,2)
			dw_acred_sersoc_opcterm.SetTabOrder(5,3)
			dw_acred_sersoc_opcterm.SetTabOrder(8,4)
//			dw_acred_sersoc_opcterm.SetTabOrder(9,5)
		end if
	Else
		if il_opcion = 1 then
			dw_acred_sersoc_opcterm.SetTabOrder(4,0)
			dw_acred_sersoc_opcterm.SetTabOrder(5,0)
			dw_acred_sersoc_opcterm.SetTabOrder(8,1)
		else
			dw_acred_sersoc_opcterm.SetTabOrder(3,1)
			dw_acred_sersoc_opcterm.SetTabOrder(4,0)
			dw_acred_sersoc_opcterm.SetTabOrder(5,0)
			dw_acred_sersoc_opcterm.SetTabOrder(8,2)
//			dw_acred_sersoc_opcterm.SetTabOrder(9,3)
		end if
	End IF 	
else
	dw_acred_sersoc_opcterm.SetTabOrder(3,1)
	dw_acred_sersoc_opcterm.SetTabOrder(4,2)
	dw_acred_sersoc_opcterm.SetTabOrder(5,3)
	dw_acred_sersoc_opcterm.SetTabOrder(8,4)
//	dw_acred_sersoc_opcterm.SetTabOrder(9,5)
end if
end event

event open;call super::open;dw_acred_sersoc_opcterm.settransobject(gtr_sce)

uo_nombre.em_cuenta.text = " "

il_opcion = Message.DoubleParm 

choose case il_opcion
	case 1
		is_nom_ventana = "ACREDITACIÓN SERVICIO SOCIAL"	 
	case 2
		is_nom_ventana = "ACREDITACIÓN OPCIÓN TERMINAL"
	case 3
		is_nom_ventana = "ACREDITACIÓN PRERREQUISITO DE INGLÉS"
end choose

title = is_nom_ventana

triggerevent(doubleclicked!)
/**/gnv_app.inv_security.of_SetSecurity(this)

//Modif. Roberto Novoa May/2016 .- Funcionalidad periodos multiples
f_dddw_converter(dw_acred_sersoc_opcterm, dwc_periodo, "periodo")

end event

event activate;call super::activate;control_escolar.toolbarsheettitle=is_nom_ventana
end event

event ue_actualiza;call super::ue_actualiza;/*	1 = AC SERVICIO SOCIAL
	2 = AC OPCION TERMINAL
	3 = AC PREREQUISITO INGLÉS
*/
int li_res,li_var
string ls_calificacion

li_res = wf_validar ()
if li_res = -1 then
	rollback using gtr_sce;
	messagebox("Información","No se han guardado los cambios")	
	triggerevent(doubleclicked!)
	return
end if

SetPointer(Hourglass!) 
if il_opcion = 1 then 
	li_var = 1
else 
	li_var = 0
end if

  IF dw_acred_sersoc_opcterm.update(True) = 1 THEN
	  COMMIT using gtr_sce;
	  messagebox("Información","Se han guardado los cambios")	
    	  If Not actualiza_bandera(il_Cuenta,li_var) then
    		  Messagebox("ATENCIÓN","Los catálogos, Académicos, Banderas de bloqueos de servicios escolares, NO SE ACTUALIZARON")
    		  MessageBox("IMPORTANTE","Revisar promedio, créditos y Banderas bloqueos del alumno, en sus respectivos catalogos")		  	  	
  	  Else
		IF il_opcion = 1 THEN  
	     	ls_calificacion    = dw_acred_sersoc_opcterm.GetItemString(dw_acred_sersoc_opcterm.GetRow(),"calificacion")
			If ls_calificacion = "AC" Then
				UPDATE banderas
				  SET cve_flag_serv_social = 2  // Esta o  Ya curso
				WHERE cuenta = :il_cuenta
				USING gtr_sce;
				if gtr_sce.sqlcode = -1 or  gtr_sce.sqlcode = 100 Then
					rollback using gtr_sce;
					MessageBox("ATENCIÓN","Revisar la bandera Flag_Servicio_Social, que se encuentre actualizada correctamente "+gtr_sce.sqlerrtext)	 
				else
					commit using gtr_sce;
				End if
			end if
		end if
	  End If
Else
	ROLLBACK using gtr_sce;
	Messagebox("Algunos datos son incorrectos","Los cambios no fueron guardados")
end if  

end event

event ue_borra;call super::ue_borra;if dw_acred_sersoc_opcterm.Getrow() = 0 then return
If Messagebox("Aviso","¿Desea borrar la materia seleccionada?",Question!,YesNo!,1) = 1 Then
	dw_acred_sersoc_opcterm.deleterow(dw_acred_sersoc_opcterm.Getrow())
	triggerevent('ue_actualiza')
end if
end event

type st_sistema from w_master_main`st_sistema within w_acred_sersoc_opcterm_2013
end type

type p_ibero from w_master_main`p_ibero within w_acred_sersoc_opcterm_2013
end type

type uo_nombre from uo_carreras_alumno_lista within w_acred_sersoc_opcterm_2013
integer x = 37
integer y = 308
integer width = 3241
integer height = 516
integer taborder = 40
end type

on uo_nombre.destroy
call uo_carreras_alumno_lista::destroy
end on

event constructor;call super::constructor;m_acreditacion_altasbajascambios_2013.objeto = this
end event

type dw_acred_sersoc_opcterm from uo_master_dw within w_acred_sersoc_opcterm_2013
integer x = 37
integer y = 840
integer width = 3698
integer height = 1592
integer taborder = 0
string dataobject = "dw_acred_sersoc_opcterm_2013"
boolean hscrollbar = false
boolean resizable = true
end type

event constructor;call super::constructor;idw_trabajo = this
end event

event itemchanged;call super::itemchanged;STRING ls_periodo

if dwo.name = 'gpo' then
	if not grupo_valido(data) Then
	  	Messagebox("Aviso","Grupos Validos ~r A a la Z,  AN a la ZN,  Donde N = 1 al 9")
		Return 1 // rechaza el valor y no deja cambiar de focus
	end if
end if

//if dwo.name = 'periodo' then
//	if long(data) < uo_nombre.istr_carrera.str_periodo_ing and Getitemnumber(row,'anio') < gi_anio then
//		choose case  uo_nombre.istr_carrera.str_periodo_ing
//		case 0
//			ls_periodo = 'PRIMAVERA'
//		case 1
//			ls_periodo = 'VERANO'
//		case 2
//			ls_periodo = 'OTOÑO'
//		end choose
//	
//		messagebox('Aviso','El periodo no puede ser menor al periodo de ingreso: ' + ls_periodo)
//		return 1
//	end if
//end if
//
//if dwo.name = 'anio' then
//	if long(data) < uo_nombre.istr_carrera.str_anio_ing then
//		MEssagebox('Aviso','El año no debe ser menor al año de ingreso: ' + data)
//      	Return 1  //rechaza el valor y no deja cambiar de focus
//	end if		
//end if
end event

event clicked;call super::clicked;Selectrow(0,false)
Selectrow(row,true)
end event

