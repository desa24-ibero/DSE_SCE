$PBExportHeader$w_antecedentesserviciosocial.srw
forward
global type w_antecedentesserviciosocial from window
end type
type uo_nombrealumno from uo_nombre_carrera_ant_sersoc within w_antecedentesserviciosocial
end type
type dw_servicio_social_captura from datawindow within w_antecedentesserviciosocial
end type
end forward

global type w_antecedentesserviciosocial from window
integer x = 832
integer y = 364
integer width = 3598
integer height = 1716
boolean titlebar = true
string title = "Antecedentes de Servicio Social"
string menuname = "m_menu_certificado"
boolean controlmenu = true
boolean minbox = true
boolean resizable = true
long backcolor = 16777215
event inicia_proceso ( )
uo_nombrealumno uo_nombrealumno
dw_servicio_social_captura dw_servicio_social_captura
end type
global w_antecedentesserviciosocial w_antecedentesserviciosocial

type variables
String		vis_nivel	// Oscar Sánchez, 08-Marzo-2019.
end variables

forward prototypes
public function integer wf_valida_datos ()
end prototypes

event inicia_proceso;//long ll_cuenta
//ll_cuenta = Message.LongParm
//dw_servicio_social_captura.Event carga(ll_cuenta)

end event

public function integer wf_valida_datos ();long ll_row_actual, ll_dias
integer li_exento
datetime ldttm_fecha_inicial, ldttm_fecha_final
date ldt_fecha_inicial, ldt_fecha_final
string ls_periodo
String	ls_nombre_institucion, ls_entidad_federativa
Long	ll_idfundamentolegalserviciosoc

dw_servicio_social_captura.AcceptText()
ll_row_actual=  dw_servicio_social_captura.GetRow()
if ll_row_actual > 0 then
	li_exento =	dw_servicio_social_captura.GetItemNumber(ll_row_actual,"exento")
	ldttm_fecha_inicial = dw_servicio_social_captura.GetItemDatetime(ll_row_actual,"fecha_inicial")
	ldttm_fecha_final = dw_servicio_social_captura.GetItemDatetime(ll_row_actual,"fecha_final")
	ldt_fecha_inicial = date(ldttm_fecha_inicial)
	ldt_fecha_final = date(ldttm_fecha_final)
	ll_dias= DaysAfter(ldt_fecha_inicial, ldt_fecha_final)
	
	ls_nombre_institucion = Trim ( dw_servicio_social_captura.GetItemString ( ll_row_actual , "nombre_institucion" ) )
	ls_entidad_federativa = Trim ( dw_servicio_social_captura.GetItemString ( ll_row_actual , "entidad_federativa" ) )
	ll_idfundamentolegalserviciosoc = dw_servicio_social_captura.GetItemNumber ( ll_row_actual , "idfundamentolegalserviciosoc" )
	
	// Oscar Sánchez, 08-Mar-2019. Solo el nivel posgrado tiene opción de elegir la opcion excento ...
	IF vis_nivel = 'P' and li_exento = 1 THEN
		return 0

//	IF vis_nivel = 'P' THEN
//		
//		if li_exento = 1 then
//			if isnull(ldt_fecha_inicial) then
//				return -1			
//			end if			
//		ls_periodo = string(ldttm_fecha_inicial,"dd/mm/yyyy")+"  "
//		END IF
//		
//		if li_exento = 0 then
//			IF IsNull ( ls_nombre_institucion ) OR ls_nombre_institucion = ""THEN
//				MessageBox("Nombre de institución requerido", "Es necesario capturar el nombre de la Institución" , StopSign! )
//				dw_servicio_social_captura.SetFocus ( )
//				dw_servicio_social_captura.SetColumn  ( "nombre_institucion" )
//				return -1
//			END IF
//			
//			IF IsNull ( ls_entidad_federativa ) OR ls_entidad_federativa = ""THEN
//				MessageBox("Entidad Federatica requerido", "Es necesario capturar el nombre de la Entidad Federativa" , StopSign! )
//				dw_servicio_social_captura.SetFocus ( )
//				dw_servicio_social_captura.SetColumn  ( "entidad_federativa" )
//				return -1
//			END IF
//			
//			if isnull(ldt_fecha_inicial) then
//				MessageBox("Fecha Inválida", "Es necesaria la fecha Inicial",StopSign!)
//				return -1			
//			end if	
//			if isnull(ldt_fecha_final) then
//				MessageBox("Fecha Inválida", "Es necesaria la fecha Final",StopSign!)
//				return -1			
//			end if	
//			if ldt_fecha_inicial >= ldt_fecha_final then
//				MessageBox("Fechas Inválidas", "La fecha Final no puede ser menor o igual a la Inicial",StopSign!)
//				return -1			
//			end if	
//			if ll_dias < 181 then
//				MessageBox("Fechas Inválidas", "El rango debería ser mayor a 6 meses",StopSign!)
//				return -1						
//			end if
//			ls_periodo = string(ldttm_fecha_inicial,"dd/mm/yyyy")+" A "+string(ldttm_fecha_final,"dd/mm/yyyy")
//		
//		elseif isnull(li_exento) then
//			MessageBox("Especifique si es exento", "Debe especificar si el alumno esta exento",StopSign!)
//			return -1
//		end if		
	END IF

	ls_periodo = string(ldttm_fecha_inicial,"dd/mm/yyyy")+"  "
	
	if li_exento = 0 then
		IF IsNull ( ls_nombre_institucion ) OR ls_nombre_institucion = ""THEN
			MessageBox("Nombre de institución requerido", "Es necesario capturar el nombre de la Institución" , StopSign! )
			dw_servicio_social_captura.SetFocus ( )
			dw_servicio_social_captura.SetColumn  ( "nombre_institucion" )
			return -1
		END IF
		
		IF IsNull ( ls_entidad_federativa ) OR ls_entidad_federativa = ""THEN
			MessageBox("Entidad Federatica requerido", "Es necesario capturar el nombre de la Entidad Federativa" , StopSign! )
			dw_servicio_social_captura.SetFocus ( )
			dw_servicio_social_captura.SetColumn  ( "entidad_federativa" )
			return -1
		END IF
		
		if isnull(ldt_fecha_inicial) then
			MessageBox("Fecha Inválida", "Es necesaria la fecha Inicial",StopSign!)
			return -1			
		end if	
		if isnull(ldt_fecha_final) then
			MessageBox("Fecha Inválida", "Es necesaria la fecha Final",StopSign!)
			return -1			
		end if	
		if ldt_fecha_inicial >= ldt_fecha_final then
			MessageBox("Fechas Inválidas", "La fecha Final no puede ser menor o igual a la Inicial",StopSign!)
			return -1			
		end if	
		if ll_dias < 181 then
			MessageBox("Fechas Inválidas", "El rango debería ser mayor a 6 meses",StopSign!)
			return -1						
		end if
		
		IF IsNull ( ll_idfundamentolegalserviciosoc ) OR ll_idfundamentolegalserviciosoc = 0 THEN
			MessageBox("Fundamento Legal requerido", "Es necesario Seleccionar el Fundamento Legal" , StopSign! )
			dw_servicio_social_captura.SetFocus ( )
			dw_servicio_social_captura.SetColumn  ( "idfundamentolegalserviciosoc" )
			return -1
		END IF
		
		ls_periodo = string(ldttm_fecha_inicial,"dd/mm/yyyy")+" A "+string(ldttm_fecha_final,"dd/mm/yyyy")
	
	elseif isnull(li_exento) then
		MessageBox("Especifique si es exento", "Debe especificar si el alumno esta exento",StopSign!)
		return -1
	end if		


end if

dw_servicio_social_captura.SetItem(ll_row_actual,"periodo", ls_periodo)

return 0

end function

on w_antecedentesserviciosocial.create
if this.MenuName = "m_menu_certificado" then this.MenuID = create m_menu_certificado
this.uo_nombrealumno=create uo_nombrealumno
this.dw_servicio_social_captura=create dw_servicio_social_captura
this.Control[]={this.uo_nombrealumno,&
this.dw_servicio_social_captura}
end on

on w_antecedentesserviciosocial.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nombrealumno)
destroy(this.dw_servicio_social_captura)
end on

event open;//Comentado para migrar sin padlock
//g_nv_security.fnv_secure_window (this)
x = 1
y = 1
end event

type uo_nombrealumno from uo_nombre_carrera_ant_sersoc within w_antecedentesserviciosocial
integer x = 14
integer y = 20
integer width = 3534
integer height = 668
integer taborder = 10
boolean enabled = true
end type

on uo_nombrealumno.destroy
call uo_nombre_carrera_ant_sersoc::destroy
end on

type dw_servicio_social_captura from datawindow within w_antecedentesserviciosocial
event type integer carga ( long al_cuenta,  integer ai_cve_carrera,  integer ai_cve_plan )
event actualiza ( )
event nuevo ( )
event primero ( )
event ultimo ( )
event anterior ( )
event siguiente ( )
event borra_renglon ( )
integer x = 41
integer y = 764
integer width = 3488
integer height = 680
integer taborder = 20
string dataobject = "d_servicio_social_captura"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event type integer carga(long al_cuenta, integer ai_cve_carrera, integer ai_cve_plan);
// Oscar Sánchez, 08-Marzo-2019. Obtener el nivel ...
Select		nivel
Into		:vis_nivel
From		carreras
Where	cve_carrera = :ai_cve_carrera
Using		gtr_sce;

IF gtr_sce.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De base de datos al obtener el nivel. ~n~r~n~r"  + gtr_sce.SQLErrText )
	Return -1
END IF

IF gtr_sce.SQLCode = 100 THEN
	MessageBox ( "Error:" , "No está definido el nivel para la carrera" )
	Return -1
END IF

// Forzar la captura si el nivel es Licenciatura
IF vis_nivel = 'L' THEN
	dw_servicio_social_captura.object.exento.Protect = 0
ELSE
	dw_servicio_social_captura.object.exento.Protect = 1
END IF

return retrieve(al_cuenta,ai_cve_carrera,ai_cve_plan)
end event

event actualiza();long ll_row_actual
if wf_valida_datos()=0 then
	ll_row_actual =this.GetRow()
	if Update() = 1 then
		commit using gtr_sce;
		MessageBox("Atención","Se han guardado los cambios")
	else
		rollback using gtr_sce;
		MessageBox("Atención","No se han guardado los cambios")
	end if
end if
end event

event nuevo;ScrollToRow(InsertRow(0))
SetItem(GetRow(),"cuenta",long(uo_nombrealumno.em_cuenta.text))
int li_row
string ls_carrera, ls_plan


//Verifica el estado del RadioButton rb_actual dentro del objeto uo_nombre 
if uo_nombrealumno.rb_actual.checked then
	li_row = 1
	ls_carrera = "academicos_cve_carrera"
	ls_plan = "academicos_cve_plan"
else
	li_row = uo_nombrealumno.dw_nombre_alumno.GetRow()
		ls_carrera = "hist_carreras_cve_carrera_ant"
	ls_plan = "hist_carreras_cve_plan_ant"

end if
SetItem(GetRow(),"cve_carrera",uo_nombrealumno.dw_nombre_alumno.GetItemNumber(li_row,ls_carrera))
SetItem(GetRow(),"cve_plan",uo_nombrealumno.dw_nombre_alumno.GetItemNumber(li_row,ls_plan))

	



end event

event primero;uo_nombrealumno.Event primero()
end event

event ultimo;uo_nombrealumno.Event ultimo()
end event

event anterior;uo_nombrealumno.Event anterior()
end event

event siguiente;uo_nombrealumno.Event siguiente()
end event

event borra_renglon;long ll_cuenta
int li_respuesta
ll_cuenta = long(uo_nombrealumno.em_cuenta.text)
li_respuesta = messagebox("Atención","Esta seguro de querer borrar los antecedentes de servicio social~r"+&
				"seleccionados del alumno "+string(ll_cuenta)+"-"+string(obten_digito(ll_cuenta))+&
				".",StopSign!,YesNo!,2)

if li_respuesta = 1 then
	deleterow(getrow())
	Event actualiza()
end if

end event

event constructor;SetTrans(gtr_sce)
m_menu_certificado.dw = this
end event

event doubleclicked;//busqueda("escuela")
//object.cve_escuela[row]=ok
end event

