$PBExportHeader$w_invoca_diagnostico_titulo_digital.srw
forward
global type w_invoca_diagnostico_titulo_digital from w_doc_titulo_digital
end type
end forward

global type w_invoca_diagnostico_titulo_digital from w_doc_titulo_digital
boolean visible = false
integer height = 668
string title = "Diagnóstico de Trámite de Título Digital"
event metodo01 ( )
end type
global w_invoca_diagnostico_titulo_digital w_invoca_diagnostico_titulo_digital

event metodo01();boolean lb_procede_tramite, lb_alumno_susceptible
long ll_cuenta, ll_cve_carrera, ll_cve_plan

ll_cuenta = uo_datos_titulo_digital_i.of_obten_cuenta()
ll_cve_carrera = uo_datos_titulo_digital_i.of_obten_cve_carrera()
ll_cve_plan= uo_datos_titulo_digital_i.of_obten_cve_plan(ll_cuenta)


lb_procede_tramite = uo_datos_titulo_digital_i.of_procede_tramite()
lb_alumno_susceptible =iuo_atencion_opc_cero.of_alumno_susceptible(ll_cuenta, ll_cve_carrera, ll_cve_plan)

if not lb_procede_tramite or not lb_alumno_susceptible then
	MessageBox("Error","El alumno no es susceptible del trámite",StopSign!)
	return
end if


end event

on w_invoca_diagnostico_titulo_digital.create
int iCurrent
call super::create
end on

on w_invoca_diagnostico_titulo_digital.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type uo_datos_titulo_digital_i from w_doc_titulo_digital`uo_datos_titulo_digital_i within w_invoca_diagnostico_titulo_digital
end type

type cb_seleccion from w_doc_titulo_digital`cb_seleccion within w_invoca_diagnostico_titulo_digital
boolean visible = false
integer x = 1911
integer y = 1472
boolean enabled = false
end type

type st_3 from w_doc_titulo_digital`st_3 within w_invoca_diagnostico_titulo_digital
integer x = 105
integer y = 1500
boolean enabled = false
end type

type uo_tipo_documento from w_doc_titulo_digital`uo_tipo_documento within w_invoca_diagnostico_titulo_digital
boolean visible = false
integer x = 635
integer y = 1472
boolean enabled = false
end type

type ole_documento from w_doc_titulo_digital`ole_documento within w_invoca_diagnostico_titulo_digital
boolean visible = false
integer y = 1388
integer height = 44
end type

type dw_documento_titulacion from w_doc_titulo_digital`dw_documento_titulacion within w_invoca_diagnostico_titulo_digital
boolean visible = false
integer y = 1312
integer height = 52
boolean enabled = false
end type

