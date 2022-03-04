$PBExportHeader$w_invoca_diagnostico_opc_cero.srw
forward
global type w_invoca_diagnostico_opc_cero from w_doc_ole_opc_cero
end type
end forward

global type w_invoca_diagnostico_opc_cero from w_doc_ole_opc_cero
boolean visible = false
integer height = 666
string title = "Diagnóstico de Trámite de Titulación"
event metodo01 ( )
end type
global w_invoca_diagnostico_opc_cero w_invoca_diagnostico_opc_cero

event metodo01();boolean lb_procede_tramite, lb_alumno_susceptible
long ll_cuenta, ll_cve_carrera, ll_cve_plan

ll_cuenta = uo_datos_opc_cero_i.of_obten_cuenta()
ll_cve_carrera = uo_datos_opc_cero_i.of_obten_cve_carrera()
ll_cve_plan= uo_datos_opc_cero_i.of_obten_cve_plan(ll_cuenta)


lb_procede_tramite = uo_datos_opc_cero_i.of_procede_tramite()
lb_alumno_susceptible =iuo_atencion_opc_cero.of_alumno_susceptible(ll_cuenta, ll_cve_carrera, ll_cve_plan)

if not lb_procede_tramite or not lb_alumno_susceptible then
	MessageBox("Error","El alumno no es susceptible del trámite",StopSign!)
	return
end if


end event

on w_invoca_diagnostico_opc_cero.create
int iCurrent
call super::create
end on

on w_invoca_diagnostico_opc_cero.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type uo_datos_opc_cero_i from w_doc_ole_opc_cero`uo_datos_opc_cero_i within w_invoca_diagnostico_opc_cero
end type

type cb_seleccion from w_doc_ole_opc_cero`cb_seleccion within w_invoca_diagnostico_opc_cero
boolean visible = false
integer x = 1913
integer y = 1472
boolean enabled = false
end type

type st_3 from w_doc_ole_opc_cero`st_3 within w_invoca_diagnostico_opc_cero
integer x = 106
integer y = 1501
boolean enabled = false
end type

type uo_tipo_documento from w_doc_ole_opc_cero`uo_tipo_documento within w_invoca_diagnostico_opc_cero
boolean visible = false
integer x = 636
integer y = 1472
boolean enabled = false
end type

type ole_documento from w_doc_ole_opc_cero`ole_documento within w_invoca_diagnostico_opc_cero
boolean visible = false
integer x = 66
integer y = 1386
integer height = 45
end type

type dw_documento_titulacion from w_doc_ole_opc_cero`dw_documento_titulacion within w_invoca_diagnostico_opc_cero
boolean visible = false
integer x = 66
integer y = 1312
integer height = 51
boolean enabled = false
end type

