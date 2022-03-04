$PBExportHeader$w_entrega_certificado.srw
forward
global type w_entrega_certificado from w_doc_ole_tramite_todos
end type
type dw_solicitud_certificado from u_dw_captura within w_entrega_certificado
end type
end forward

global type w_entrega_certificado from w_doc_ole_tramite_todos
integer x = 466
integer y = 372
string title = "Entrega de Certificados"
event metodo01 ( )
dw_solicitud_certificado dw_solicitud_certificado
end type
global w_entrega_certificado w_entrega_certificado

type variables
long il_cuenta=0, il_cve_documento=0, il_cve_carrera=0, il_cve_plan=0
str_alumno_opc_cero ist_parametros
end variables

event metodo01();long ll_cuenta, ll_cve_documento, ll_cve_carrera, ll_cve_plan, ll_solicitudes_certificados
long ll_row, ll_rows
integer li_res, li_cve_doc_control_sep
str_alumno_opc_cero lst_parametros
string ls_StringParm, ls_tipo_certificado, ls_nivel

ll_cuenta = uo_datos_opc_cero_i.of_obten_cuenta()
ll_cve_carrera = uo_datos_opc_cero_i.of_obten_cve_carrera()
ll_cve_plan= uo_datos_opc_cero_i.of_obten_cve_plan(ll_cuenta)
ls_nivel = f_obten_nivel_carrera(ll_cve_carrera)

if il_cuenta<>ll_cuenta and ll_cve_carrera= il_cve_carrera then
	dw_solicitud_certificado.Reset()
end if	
il_cuenta = ll_cuenta
il_cve_documento = ll_cve_documento
il_cve_carrera = ll_cve_carrera
il_cve_plan = ll_cve_plan


dw_solicitud_certificado.Event carga()


end event

on w_entrega_certificado.create
int iCurrent
call super::create
this.dw_solicitud_certificado=create dw_solicitud_certificado
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_solicitud_certificado
end on

on w_entrega_certificado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_solicitud_certificado)
end on

event open;call super::open;long ll_rows

dw_documento_titulacion.SetTransObject(gtr_sce)
ll_rows= dw_documento_titulacion.Retrieve(14)
iuo_atencion_opc_cero = CREATE uo_atencion_opc_cero
x=1
y=1
dw_solicitud_certificado.SetTransObject(gtr_sce)
end event

type uo_datos_opc_cero_i from w_doc_ole_tramite_todos`uo_datos_opc_cero_i within w_entrega_certificado
integer taborder = 10
end type

type cb_seleccion from w_doc_ole_tramite_todos`cb_seleccion within w_entrega_certificado
boolean visible = false
integer y = 1382
integer taborder = 0
end type

type st_3 from w_doc_ole_tramite_todos`st_3 within w_entrega_certificado
integer y = 1411
end type

type uo_tipo_documento from w_doc_ole_tramite_todos`uo_tipo_documento within w_entrega_certificado
boolean visible = false
integer y = 1382
integer taborder = 0
end type

type ole_documento from w_doc_ole_tramite_todos`ole_documento within w_entrega_certificado
integer y = 592
integer height = 480
integer taborder = 0
end type

type dw_documento_titulacion from w_doc_ole_tramite_todos`dw_documento_titulacion within w_entrega_certificado
integer y = 298
integer height = 272
integer taborder = 20
end type

event dw_documento_titulacion::doubleclicked;long ll_cuenta, ll_cve_documento, ll_cve_carrera, ll_cve_plan, ll_rows_tramite ,ll_rows_tramites
integer li_res
string ls_query_datos, ls_query_definicion, ls_columnas_marcas[], ls_valores[], ls_nivel
boolean lb_procede_tramite, lb_alumno_susceptible
long ll_cve_tramite, ll_cve_sub_estado

ll_cuenta = uo_datos_opc_cero_i.of_obten_cuenta()
ll_cve_carrera = uo_datos_opc_cero_i.of_obten_cve_carrera()
ll_cve_plan= uo_datos_opc_cero_i.of_obten_cve_plan(ll_cuenta)
ls_nivel = f_obten_nivel_carrera(ll_cve_carrera)

//if uo_datos_opc_cero_i.il_cuenta

//lb_procede_tramite = uo_datos_opc_cero_i.of_procede_tramite()
//lb_alumno_susceptible =iuo_atencion_opc_cero.of_alumno_susceptible(ll_cuenta, ll_cve_carrera, ll_cve_plan)

if isnull(ll_cuenta) or isnull(ll_cve_carrera) or isnull(ll_cve_plan) or &
     ll_cuenta=0 or   ll_cve_carrera=0 or  ll_cve_plan  =0  then
	MessageBox("Error","El alumno no ha sido correctamente elegido",StopSign!)
	return
end if

//if not lb_procede_tramite or not lb_alumno_susceptible then
//	MessageBox("Error","El alumno no es susceptible del trámite",StopSign!)
//	return
//end if
//

if row <= 0 then
	MessageBox("Error", "No existe el documento base para generar",StopSign!)
	return -1	
end if

ls_valores[1] =string(ll_cuenta)
ls_valores[2] =string(ll_cve_carrera)
ls_valores[3] =string(ll_cve_plan)

ll_rows_tramites = dw_solicitud_certificado.RowCount()

if ll_cuenta <> -1 then
	li_res= MessageBox("Confirmacion","¿Desea generar el/los documento(s) con el papel actual de la impresora ?",Question!,YesNo!)
	if li_res = 1 then
		FOR ll_rows_tramite = 1 TO ll_rows_tramites
			ll_cve_tramite = dw_solicitud_certificado.GetItemNumber(ll_rows_tramite, "estado_alumno_tramite_cve_tramite")
			ll_cve_sub_estado = dw_solicitud_certificado.GetItemNumber(ll_rows_tramite, "estado_alumno_tramite_cve_sub_estado")

			ll_cve_documento = this.GetItemNumber(row, "cve_documento")	
			ls_query_datos = this.GetItemString(row, "query_datos")	
			ls_query_definicion = this.GetItemString(row, "query_definicion")	
			ole_documento.of_obten_arreglo_de_string(ls_query_datos, ls_columnas_marcas)
			if upperbound(ls_columnas_marcas) = 0 then
				MessageBox("Error", "No existen marcas a incrustar",StopSign!)
				return
			end if
			if len(trim (ls_query_definicion))= 0 then
				MessageBox("Error", "No existe query de definición",StopSign!)
				return			
			end if
			if ll_cve_sub_estado = 5 then
				//CERTIFICADO TOTAL
				if ll_cve_tramite = 2 then
					if ole_documento.of_imprime_documento(46, ls_valores, false,false) =0 and &
					   ole_documento.of_imprime_documento(47, ls_valores, false,false) =0 then
						MessageBox("Impresion Exitosa", "El documento se ha impreso exitosamente",Information!)
					end if
				//CERTIFICADO PARCIAL
				elseif ll_cve_tramite = 3 then
					if ole_documento.of_imprime_documento(48, ls_valores, false,false) =0 and &
						ole_documento.of_imprime_documento(49, ls_valores, false,false) =0 then
						MessageBox("Impresion Exitosa", "El documento se ha impreso exitosamente",Information!)
					end if
				end if
			end if	
		NEXT

	end if
end if
	
end event

type dw_solicitud_certificado from u_dw_captura within w_entrega_certificado
integer x = 62
integer y = 1104
integer width = 2849
integer height = 371
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_entrega_certificado"
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio= gtr_sce
end event

event ue_actualiza;long ll_row_actual, ll_rowcount, ll_entregado
long ll_cuenta, ll_cve_carrera, ll_cve_plan
integer li_cve_tramite, li_cve_estado, li_cve_sub_estado, li_confirma, li_estado_puente
datetime ldttm_fecha


li_confirma = MessageBox("Confirmación", "¿Desea actualizar el estatus?", Question!,YesNo!)

if li_confirma<> 1 then
	return -1
	
end if

ll_rowcount = this.Rowcount()


FOR ll_row_actual=1 TO ll_rowcount

	ll_entregado = this.GetItemNumber(ll_row_actual, "entregado")
	li_cve_tramite = this.GetItemNumber(ll_row_actual, "estado_alumno_tramite_cve_tramite")
	li_cve_estado = 0
	li_cve_sub_estado= 0

	IF li_cve_tramite= 2 OR li_cve_tramite = 3 THEN
		IF ll_entregado = 1 THEN
			li_cve_estado = 1 
			li_cve_sub_estado = 5
			this.SetItem(ll_row_actual, "estado_alumno_tramite_cve_estado", li_cve_estado)
			this.SetItem(ll_row_actual, "estado_alumno_tramite_cve_sub_estado", li_cve_sub_estado)
		ELSEIF li_estado_puente = 0 THEN
			//NONE
		END IF		
	END IF
NEXT

IF this.Update()=1 THEN
	COMMIT USING gtr_sce;
	return 0
ELSE
	ROLLBACK USING gtr_sce;
	MessageBox("Error de actualización", "No es posible almacenar los cambios", StopSign!)
	return -1
END IF


//return this.event carga()
end event

event asigna_dw_menu;return
end event

event carga;long ll_solicitudes_certificados 
int li_cve_tramites[] = {2,3}
int li_cve_sub_estados[] = {4,5}

ll_solicitudes_certificados = dw_solicitud_certificado.Retrieve(il_cuenta, il_cve_carrera, il_cve_plan, li_cve_tramites, li_cve_sub_estados)
return ll_solicitudes_certificados

end event

event retrieverow;call super::retrieverow;integer li_cve_estado, li_cve_sub_estado, li_cve_tramite, li_entregado

li_cve_tramite = this.GetItemNumber(row, "estado_alumno_tramite_cve_tramite")	
li_cve_estado = this.GetItemNumber(row, "estado_alumno_tramite_cve_estado")
li_cve_sub_estado = this.GetItemNumber(row, "estado_alumno_tramite_cve_sub_estado")
	
IF li_cve_tramite= 2 OR li_cve_tramite = 3 THEN
	IF li_cve_estado = 1 and li_cve_sub_estado = 5 THEN
		li_entregado= 1
	ELSE
		li_entregado= 0
	END IF		
	this.SetItem(row, "entregado", li_entregado)
END IF

end event

