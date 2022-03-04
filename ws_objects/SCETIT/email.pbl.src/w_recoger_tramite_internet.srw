$PBExportHeader$w_recoger_tramite_internet.srw
forward
global type w_recoger_tramite_internet from w_contesta_tramite_internet
end type
end forward

global type w_recoger_tramite_internet from w_contesta_tramite_internet
integer x = 466
integer y = 372
string title = "Recoger de Trámites por Internet"
end type
global w_recoger_tramite_internet w_recoger_tramite_internet

on w_recoger_tramite_internet.create
call super::create
end on

on w_recoger_tramite_internet.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type ddlb_estado_general from w_contesta_tramite_internet`ddlb_estado_general within w_recoger_tramite_internet
string item[] = {"EN TRAMITE","PUEDES RECOGERLO","PROCESO CANCELADO"}
end type

type st_5 from w_contesta_tramite_internet`st_5 within w_recoger_tramite_internet
end type

type cb_responder from w_contesta_tramite_internet`cb_responder within w_recoger_tramite_internet
end type

type st_4 from w_contesta_tramite_internet`st_4 within w_recoger_tramite_internet
end type

type em_respuesta_base from w_contesta_tramite_internet`em_respuesta_base within w_recoger_tramite_internet
end type

type st_3 from w_contesta_tramite_internet`st_3 within w_recoger_tramite_internet
end type

type dw_resultado from w_contesta_tramite_internet`dw_resultado within w_recoger_tramite_internet
end type

type cb_1 from w_contesta_tramite_internet`cb_1 within w_recoger_tramite_internet
end type

type cb_establece from w_contesta_tramite_internet`cb_establece within w_recoger_tramite_internet
end type

type st_2 from w_contesta_tramite_internet`st_2 within w_recoger_tramite_internet
end type

type st_1 from w_contesta_tramite_internet`st_1 within w_recoger_tramite_internet
end type

type em_fecha_final from w_contesta_tramite_internet`em_fecha_final within w_recoger_tramite_internet
end type

type em_fecha_inicial from w_contesta_tramite_internet`em_fecha_inicial within w_recoger_tramite_internet
end type

type gb_1 from w_contesta_tramite_internet`gb_1 within w_recoger_tramite_internet
end type

type dw_1 from w_contesta_tramite_internet`dw_1 within w_recoger_tramite_internet
string dataobject = "d_recoger_tramites_internet"
end type

event dw_1::carga;string ls_fecha_inicial, ls_fecha_final
date ldt_fecha_inicial, ldt_fecha_final
datetime ldttm_fecha_inicial, ldttm_fecha_final
integer li_num_registros 
integer li_cve_tramites[] = {2,3}
integer li_cve_sub_estados[] = {3,4}

if isnull(dw_1.DataObject) then
	return 0
end if

ls_fecha_inicial= em_fecha_inicial.text
ls_fecha_final= em_fecha_final.text

ldt_fecha_inicial =date(ls_fecha_inicial)
ldt_fecha_final =date(ls_fecha_final)

if ldt_fecha_final < ldt_fecha_inicial then
	MessageBox("Error de fechas","La fecha inicial de atención no debe ser mayor a la fecha final")
end if 



ldt_fecha_final= RelativeDate(ldt_fecha_final, +1)

ldttm_fecha_inicial =datetime(ldt_fecha_inicial)
ldttm_fecha_final =datetime(ldt_fecha_final)

li_num_registros= dw_1.retrieve(ldttm_fecha_inicial, ldttm_fecha_final, li_cve_tramites, li_cve_sub_estados)

return li_num_registros



end event

event dw_1::ue_responde;long ll_row, ll_rows, ll_estado_general
string ls_respuesta_general, ls_estado_general

ll_rows = dw_1.RowCount()
ls_respuesta_general = em_respuesta_base.text
ls_estado_general = ddlb_estado_general.text

CHOOSE CASE ls_estado_general
	CASE "EN TRAMITE"
		ll_estado_general = 1
	CASE "PUEDES RECOGERLO"
		ll_estado_general = 2
	CASE "PROCESO CANCELADO"
		ll_estado_general = 6
END CHOOSE

FOR ll_row = 1 TO ll_rows
   this.SetItem(ll_row, "estado_alumno_tramite_respuesta", ls_respuesta_general)		
   this.SetItem(ll_row, "estado_puente", ll_estado_general)		
NEXT


end event

event dw_1::actualiza;long ll_row_actual, ll_rowcount
long ll_cuenta, ll_cve_carrera, ll_cve_plan
integer li_cve_tramite, li_cve_estado, li_cve_sub_estado, li_confirma, li_estado_puente
datetime ldttm_fecha

li_confirma = MessageBox("Confirmación", "¿Desea actualizar el estatus?", Question!,YesNo!)

if li_confirma<> 1 then
	return -1
	
end if


ll_rowcount = this.Rowcount()

FOR ll_row_actual=1 TO ll_rowcount

	ll_cuenta = this.GetItemNumber(ll_row_actual, "estado_alumno_tramite_cuenta")
	ll_cve_carrera = this.GetItemNumber(ll_row_actual, "estado_alumno_tramite_cve_carrera")
	ll_cve_plan = this.GetItemNumber(ll_row_actual, "estado_alumno_tramite_cve_plan")
	li_cve_tramite = this.GetItemNumber(ll_row_actual, "estado_alumno_tramite_cve_tramite")
	li_cve_estado = 0
	li_cve_sub_estado= 0
	ldttm_fecha = this.GetItemDatetime(ll_row_actual, "estado_alumno_tramite_fecha")

	li_estado_puente = this.GetItemNumber(ll_row_actual, "estado_puente")

	IF li_cve_tramite= 2 OR li_cve_tramite = 3 THEN
		IF li_estado_puente = 1 THEN
			li_cve_estado = 1 
			li_cve_sub_estado = 3
		ELSEIF li_estado_puente = 2 THEN
			li_cve_estado = 1 
			li_cve_sub_estado = 4
		ELSEIF li_estado_puente = 6 THEN
			li_cve_estado = 2 
			li_cve_sub_estado = 1
		END IF
		
	END IF
	
//	f_obten_estatus_tramite(ll_cuenta,	    ll_cve_carrera,	ll_cve_plan, &
//                         	li_cve_tramite, ldttm_fecha,     li_cve_estado, li_cve_sub_estado)
//
//
//   if f_establece_estatus_tramite(ll_cuenta,	    ll_cve_carrera,	ll_cve_plan, &
//                         	li_cve_tramite, ldttm_fecha,     li_cve_estado, li_cve_sub_estado)= -1 then
//		MessageBox("Error de actualización", "No es posible almacenar los cambios", StopSign!)
//		return -1
//	end if

	this.SetItem(ll_row_actual, "estado_alumno_tramite_cve_estado", li_cve_estado)
	this.SetItem(ll_row_actual, "estado_alumno_tramite_cve_sub_estado", li_cve_sub_estado)

NEXT


IF this.Update()=1 THEN
	COMMIT USING gtr_sce;
	return 0
ELSE
	ROLLBACK USING gtr_sce;
	MessageBox("Error de actualización", "No es posible almacenar los cambios", StopSign!)
	return -1
END IF


return this.event carga()
end event

event dw_1::retrieverow;integer li_cve_estado, li_cve_tramite, li_estado_puente
decimal ld_cve_sub_estado

li_cve_tramite = this.GetItemNumber(row,"estado_alumno_tramite_cve_tramite")
li_cve_estado = this.GetItemNumber(row,"estado_alumno_tramite_cve_estado")
ld_cve_sub_estado = this.GetItemNumber(row,"estado_alumno_tramite_cve_sub_estado")


IF li_cve_tramite = 2 OR li_cve_tramite = 3 THEN
	IF li_cve_estado=1 THEN		
		IF ld_cve_sub_estado= 3 THEN
			li_estado_puente = 1
		ELSEIF ld_cve_sub_estado= 4 THEN
			li_estado_puente = 2
		END IF				
	ELSEIF li_cve_estado=2 THEN
		IF ld_cve_sub_estado= 1 THEN
			li_estado_puente = 6
		END IF		
	END IF
END IF


this.SetItem(row,"estado_puente",li_estado_puente )

end event

