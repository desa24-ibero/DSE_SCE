$PBExportHeader$w_autoriza_tramite.srw
forward
global type w_autoriza_tramite from w_doc_ole_tramite
end type
type dw_estado_tramite_alumno from u_dw within w_autoriza_tramite
end type
end forward

global type w_autoriza_tramite from w_doc_ole_tramite
boolean visible = false
integer width = 3474
integer height = 1466
string title = "Diagnóstico de Trámites"
event metodo01 ( )
dw_estado_tramite_alumno dw_estado_tramite_alumno
end type
global w_autoriza_tramite w_autoriza_tramite

event metodo01();boolean lb_procede_tramite, lb_alumno_susceptible
long ll_cuenta, ll_cve_carrera, ll_cve_plan, ll_cve_tramite, ll_num_estados

ll_cuenta = uoi_datos_tramite.of_obten_cuenta()
ll_cve_carrera = uoi_datos_tramite.of_obten_cve_carrera()
ll_cve_plan= uoi_datos_tramite.of_obten_cve_plan(ll_cuenta)
ll_cve_tramite= uoi_datos_tramite.of_obten_cve_tramite()


lb_procede_tramite = uoi_datos_tramite.of_procede_tramite()

lb_alumno_susceptible =iuo_atencion_tramite.of_alumno_susceptible_tramite(ll_cuenta, ll_cve_carrera, ll_cve_plan, ll_cve_tramite)

ll_num_estados= dw_estado_tramite_alumno.Retrieve(ll_cuenta, ll_cve_carrera, ll_cve_plan)

if ll_num_estados= -1 then
	MessageBox("Error","No es posible consultar el estado del tramite",StopSign!)	
end if

if not lb_procede_tramite or not lb_alumno_susceptible then
	MessageBox("Error","El alumno no es susceptible del trámite",StopSign!)
	return
end if


end event

on w_autoriza_tramite.create
int iCurrent
call super::create
this.dw_estado_tramite_alumno=create dw_estado_tramite_alumno
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_estado_tramite_alumno
end on

on w_autoriza_tramite.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_estado_tramite_alumno)
end on

event open;call super::open;dw_estado_tramite_alumno.SetTransObject(gtr_sce)
end event

type uoi_datos_tramite from w_doc_ole_tramite`uoi_datos_tramite within w_autoriza_tramite
integer taborder = 10
end type

type cb_seleccion from w_doc_ole_tramite`cb_seleccion within w_autoriza_tramite
boolean visible = false
integer x = 1913
integer y = 1472
boolean enabled = false
end type

type st_3 from w_doc_ole_tramite`st_3 within w_autoriza_tramite
integer x = 106
integer y = 1501
boolean enabled = false
end type

type uo_tipo_documento from w_doc_ole_tramite`uo_tipo_documento within w_autoriza_tramite
boolean visible = false
integer x = 636
integer y = 1472
integer taborder = 30
boolean enabled = false
end type

type ole_documento from w_doc_ole_tramite`ole_documento within w_autoriza_tramite
boolean visible = false
integer x = 66
integer y = 1386
integer height = 45
integer taborder = 60
end type

type dw_documento_titulacion from w_doc_ole_tramite`dw_documento_titulacion within w_autoriza_tramite
boolean visible = false
integer x = 66
integer y = 1312
integer height = 51
boolean enabled = false
end type

type dw_estado_tramite_alumno from u_dw within w_autoriza_tramite
integer x = 18
integer y = 573
integer width = 3204
integer height = 634
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_estado_tramite_alumno"
boolean hscrollbar = true
end type

