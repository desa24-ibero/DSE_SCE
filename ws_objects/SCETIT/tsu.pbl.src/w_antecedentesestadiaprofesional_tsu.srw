$PBExportHeader$w_antecedentesestadiaprofesional_tsu.srw
forward
global type w_antecedentesestadiaprofesional_tsu from window
end type
type dw_estadia_profesional_tsu from datawindow within w_antecedentesestadiaprofesional_tsu
end type
type uo_nombrealumno from uo_nombre_carrera_ant_estprof_tsu within w_antecedentesestadiaprofesional_tsu
end type
type dw_servicio_social_captura from datawindow within w_antecedentesestadiaprofesional_tsu
end type
end forward

global type w_antecedentesestadiaprofesional_tsu from window
integer x = 832
integer y = 364
integer width = 3598
integer height = 1904
boolean titlebar = true
string title = "Antecedentes de Estadía Profesional"
string menuname = "m_menu_certificado"
boolean controlmenu = true
boolean minbox = true
boolean resizable = true
long backcolor = 16777215
event inicia_proceso ( )
dw_estadia_profesional_tsu dw_estadia_profesional_tsu
uo_nombrealumno uo_nombrealumno
dw_servicio_social_captura dw_servicio_social_captura
end type
global w_antecedentesestadiaprofesional_tsu w_antecedentesestadiaprofesional_tsu

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

dw_servicio_social_captura.AcceptText()
ll_row_actual=  dw_servicio_social_captura.GetRow()
if ll_row_actual > 0 then
	li_exento =	dw_servicio_social_captura.GetItemNumber(ll_row_actual,"exento")
	ldttm_fecha_inicial = dw_servicio_social_captura.GetItemDatetime(ll_row_actual,"fecha_inicial")
	ldttm_fecha_final = dw_servicio_social_captura.GetItemDatetime(ll_row_actual,"fecha_final")
	ldt_fecha_inicial = date(ldttm_fecha_inicial)
	ldt_fecha_final = date(ldttm_fecha_final)
	ll_dias= DaysAfter(ldt_fecha_inicial, ldt_fecha_final)
	if li_exento = 1 then
		if isnull(ldt_fecha_inicial) then
			MessageBox("Fecha Inválidas", "Es necesaria la fecha Inicial",StopSign!)
			return -1			
		end if			
	ls_periodo = string(ldttm_fecha_inicial,"dd/mm/yyyy")+"  "

	elseif li_exento = 0 then
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
		//2015-03-03 Se quita la validación de los 181 días, ya que para TSU es distinto a licenciatura
//		if ll_dias < 181 then
//			MessageBox("Fechas Inválidas", "El rango debería ser mayor a 6 meses",StopSign!)
//			return -1						
//		end if
		ls_periodo = string(ldttm_fecha_inicial,"dd/mm/yyyy")+" A "+string(ldttm_fecha_final,"dd/mm/yyyy")
	elseif isnull(li_exento) then
		MessageBox("Especifique si es exento", "Debe especificar si el alumno esta exento",StopSign!)
		return -1
	end if

end if

dw_servicio_social_captura.SetItem(ll_row_actual,"periodo", ls_periodo)

return 0

end function

on w_antecedentesestadiaprofesional_tsu.create
if this.MenuName = "m_menu_certificado" then this.MenuID = create m_menu_certificado
this.dw_estadia_profesional_tsu=create dw_estadia_profesional_tsu
this.uo_nombrealumno=create uo_nombrealumno
this.dw_servicio_social_captura=create dw_servicio_social_captura
this.Control[]={this.dw_estadia_profesional_tsu,&
this.uo_nombrealumno,&
this.dw_servicio_social_captura}
end on

on w_antecedentesestadiaprofesional_tsu.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_estadia_profesional_tsu)
destroy(this.uo_nombrealumno)
destroy(this.dw_servicio_social_captura)
end on

event open;//Comentado para migrar sin padlock
//g_nv_security.fnv_secure_window (this)
x = 1
y = 1

dw_estadia_profesional_tsu.SetTransObject(gtr_sce)
end event

type dw_estadia_profesional_tsu from datawindow within w_antecedentesestadiaprofesional_tsu
integer x = 69
integer y = 752
integer width = 3195
integer height = 344
integer taborder = 30
string title = "none"
string dataobject = "d_estadia_profesional_tsu"
boolean border = false
boolean livescroll = true
end type

type uo_nombrealumno from uo_nombre_carrera_ant_estprof_tsu within w_antecedentesestadiaprofesional_tsu
integer x = 23
integer y = 28
integer taborder = 10
boolean enabled = true
end type

on uo_nombrealumno.destroy
call uo_nombre_carrera_ant_estprof_tsu::destroy
end on

type dw_servicio_social_captura from datawindow within w_antecedentesestadiaprofesional_tsu
event type integer carga ( long al_cuenta,  integer ai_cve_carrera,  integer ai_cve_plan )
event actualiza ( )
event nuevo ( )
event primero ( )
event ultimo ( )
event anterior ( )
event siguiente ( )
event borra_renglon ( )
integer x = 41
integer y = 1140
integer width = 3360
integer height = 464
integer taborder = 20
string dataobject = "d_servicio_social_captura"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event type integer carga(long al_cuenta, integer ai_cve_carrera, integer ai_cve_plan);long ll_rows_estadia
ll_rows_estadia = dw_estadia_profesional_tsu.retrieve(al_cuenta,ai_cve_carrera,ai_cve_plan)

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

