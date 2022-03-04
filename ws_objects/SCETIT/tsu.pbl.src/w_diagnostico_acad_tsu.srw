$PBExportHeader$w_diagnostico_acad_tsu.srw
forward
global type w_diagnostico_acad_tsu from w_response
end type
type cb_cerrar from u_cb within w_diagnostico_acad_tsu
end type
type cb_imprimir from u_cb within w_diagnostico_acad_tsu
end type
type dw_diagnostico from u_dw within w_diagnostico_acad_tsu
end type
end forward

global type w_diagnostico_acad_tsu from w_response
integer width = 3598
integer height = 2076
string title = "Diagnóstico del Alumno"
boolean controlmenu = false
cb_cerrar cb_cerrar
cb_imprimir cb_imprimir
dw_diagnostico dw_diagnostico
end type
global w_diagnostico_acad_tsu w_diagnostico_acad_tsu

type variables
str_alumno_opc_cero ist_parametros
end variables

on w_diagnostico_acad_tsu.create
int iCurrent
call super::create
this.cb_cerrar=create cb_cerrar
this.cb_imprimir=create cb_imprimir
this.dw_diagnostico=create dw_diagnostico
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cerrar
this.Control[iCurrent+2]=this.cb_imprimir
this.Control[iCurrent+3]=this.dw_diagnostico
end on

on w_diagnostico_acad_tsu.destroy
call super::destroy
destroy(this.cb_cerrar)
destroy(this.cb_imprimir)
destroy(this.dw_diagnostico)
end on

event open;
long ll_cuenta, ll_cve_carrera, ll_cve_plan, ll_diagnostico, ll_diagnostico0
boolean lb_procede_tramite, lb_revisa_cobranzas
integer li_res, li_tiene_adeudos, li_datos_tramites, li_revision_estudios, li_inserta_carrera, li_actualizacion
uo_atencion_tsu luo_atencion_tsu 

x=1	
y=1

//Lee los valores recibidos por la ventana anterior
ist_parametros = Message.PowerObjectParm	
	
ll_cuenta=	ist_parametros.cuenta 
ll_cve_carrera = 	ist_parametros.cve_carrera 
ll_cve_plan=	ist_parametros.cve_plan 

luo_atencion_tsu = CREATE uo_atencion_tsu
if isvalid(luo_atencion_tsu) then
	SetPointer(HourGlass!)
	
	dw_diagnostico.SetTransObject(gtr_sce)
	ll_diagnostico0= dw_diagnostico.Retrieve(ll_cuenta, ll_cve_carrera, ll_cve_plan)
	if ll_diagnostico0 = 0 then
		li_actualizacion=  luo_atencion_tsu.of_inserta_carreras(ll_cuenta)
		if li_actualizacion= 0 then
			MessageBox("Actualización correcta","Se han actualizado las carreras del alumno", Information!)			
		elseif li_actualizacion= 100 then
			MessageBox("Alumno sin datos","El alumno NO tiene información Válida de Licenciatura Cargada~n"+&
						"NO se han actualizado las carreras del alumno", StopSign!)			
			return			
		elseif li_actualizacion= -1 then
			MessageBox("Error de Actualización","NO se han actualizado las carreras del alumno", StopSign!)			
			return			
		end if
	end if
		
	li_datos_tramites = luo_atencion_tsu.of_actualiza_datos_tramites( ll_cuenta, ll_cve_carrera, ll_cve_plan)
	SetPointer(Arrow!)
	if li_datos_tramites= -1 then
		MessageBox("Error en Actualizar Datos","Error en la actualización de los datos requeridos en el trámite",StopSign!)
	end if
//	li_tiene_adeudos = luo_atencion_tsu.of_adeuda_finanzas( ll_cuenta)
//	if li_tiene_adeudos= -1 then
//		MessageBox("Error en Adeudos","Error en la consulta de adeudos en cobranzas",StopSign!)
//	end if
	SetPointer(HourGlass!)
	li_revision_estudios = luo_atencion_tsu.of_revision_estudios( ll_cuenta, ll_cve_carrera, ll_cve_plan)
	SetPointer(Arrow!)
	if li_revision_estudios= -1 then
		MessageBox("Error en Revisión de estudios","Error en la ejecución de la revisión de estudios",StopSign!)
	end if

end if 

if isvalid(luo_atencion_tsu) then
	DESTROY luo_atencion_tsu
end if
//	li_tiene_adeudos= -1 or

if li_datos_tramites=-1 or li_revision_estudios= -1 then
	MessageBox("Información no disponible","No es posible consultar el estatus del alumno",StopSign!)
	ist_parametros.procede_tramite=false
	cb_cerrar.event clicked()
	return
end if

dw_diagnostico.SetTransObject(gtr_sce)	
ll_diagnostico= dw_diagnostico.Retrieve(ll_cuenta, ll_cve_carrera, ll_cve_plan)
	
if ll_diagnostico= -1  then
	MessageBox("Información no disponible","No es posible consultar el estatus del alumno [dw_diagnostico]",StopSign!)
	ist_parametros.procede_tramite=false
	cb_cerrar.event clicked()
	return
elseif ll_diagnostico= 0  then
	MessageBox("Información inexistente","No es posible consultar el estatus del alumno [dw_diagnostico]",StopSign!)
	ist_parametros.procede_tramite=false
	cb_cerrar.event clicked()
	return
else
	ist_parametros.procede_tramite=true	
	return
end if
	



end event

type cb_cerrar from u_cb within w_diagnostico_acad_tsu
integer x = 1888
integer y = 1832
integer taborder = 20
string text = "Cerrar"
end type

event clicked;call super::clicked;
Message.PowerObjectParm = ist_parametros
CloseWithReturn(parent, ist_parametros)


end event

type cb_imprimir from u_cb within w_diagnostico_acad_tsu
integer x = 1381
integer y = 1832
integer taborder = 20
string text = "Imprimir"
end type

event clicked;call super::clicked;ist_parametros.procede_tramite=true
dw_diagnostico.event pfc_print()
end event

type dw_diagnostico from u_dw within w_diagnostico_acad_tsu
integer x = 114
integer y = 12
integer width = 3397
integer height = 1748
integer taborder = 10
string dataobject = "d_diagnostico_acad_TSU"
end type

