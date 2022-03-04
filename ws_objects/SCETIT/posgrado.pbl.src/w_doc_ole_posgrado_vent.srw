$PBExportHeader$w_doc_ole_posgrado_vent.srw
forward
global type w_doc_ole_posgrado_vent from w_doc_ole_posgrado
end type
type dw_solicitud_titulacion_pos from u_dw within w_doc_ole_posgrado_vent
end type
type cb_elige_jurado from u_cb within w_doc_ole_posgrado_vent
end type
type cb_almacena_solicitud from u_cb within w_doc_ole_posgrado_vent
end type
type cb_insertar from u_cb within w_doc_ole_posgrado_vent
end type
end forward

global type w_doc_ole_posgrado_vent from w_doc_ole_posgrado
integer width = 3470
integer height = 1976
string title = "Documentos de Posgrado (Ventanilla)"
event metodo01 ( )
event metodo02 ( )
dw_solicitud_titulacion_pos dw_solicitud_titulacion_pos
cb_elige_jurado cb_elige_jurado
cb_almacena_solicitud cb_almacena_solicitud
cb_insertar cb_insertar
end type
global w_doc_ole_posgrado_vent w_doc_ole_posgrado_vent

forward prototypes
public function integer wf_valida_solicitud ()
end prototypes

event metodo01();//Metodo01
//Efectua una operación cuando se escribe la información en el user object
long  ll_cuenta, ll_cve_carrera, ll_cve_plan
long ll_rows_solicitud_titulacion, ll_row_insertado

ll_cuenta = uo_datos_opc_cero_i.of_obten_cuenta()
ll_cve_carrera = uo_datos_opc_cero_i.of_obten_cve_carrera()
ll_cve_plan= uo_datos_opc_cero_i.of_obten_cve_plan(ll_cuenta)

ll_rows_solicitud_titulacion= dw_solicitud_titulacion_pos.Retrieve(ll_cuenta,ll_cve_carrera,ll_cve_plan)
if ll_rows_solicitud_titulacion= -1 then
	MessageBox("Error en solicitud de alumno","No es posible consultar la solicitud del alumno",StopSign!)
	return
elseif ll_rows_solicitud_titulacion= 0 then
	if uo_datos_opc_cero_i.of_obten_num_carreras()>0 then
		ll_row_insertado = dw_solicitud_titulacion_pos.InsertRow(0)
		dw_solicitud_titulacion_pos.SetItem(ll_row_insertado,"cuenta",ll_cuenta)
		dw_solicitud_titulacion_pos.SetItem(ll_row_insertado,"cve_carrera",ll_cve_carrera)
		dw_solicitud_titulacion_pos.SetItem(ll_row_insertado,"cve_plan",ll_cve_plan)
	end if
end if

return

end event

event metodo02();//Metodo02
//Efectua una operación cuando se escribe la información en el user object
//En este caso limpia el datawindow
long ll_reset

ll_reset= dw_solicitud_titulacion_pos.Reset()

return

end event

public function integer wf_valida_solicitud ();//wf_valida_solicitud
//Devuelve: 1 si la información es válida
//				-1 si la información no es correcta
integer li_opcion_titulacion 
string ls_nombre_tesis
datetime ldttm_fecha_examen
long ll_row

if dw_solicitud_titulacion_pos.RowCount()>0 then
	dw_solicitud_titulacion_pos.AcceptText()
	ll_row = dw_solicitud_titulacion_pos.GetRow()
	li_opcion_titulacion = dw_solicitud_titulacion_pos.GetItemNumber(ll_row,"opcion_titulacion")
	ls_nombre_tesis  = dw_solicitud_titulacion_pos.GetItemString(ll_row,"nombre_tesis")
	ldttm_fecha_examen = dw_solicitud_titulacion_pos.GetItemDateTime(ll_row,"fecha_examen")
	if isnull(li_opcion_titulacion) then
		MessageBox("Opcion Incorrecta", "Favor de elegir una opción de titulación", StopSign!)
		return -1
	end if
	if isnull(ls_nombre_tesis) then
		MessageBox("Trabajo Incorrecto", "Favor de escribir un título del trabajo", StopSign!)
		return -1
	end if
	if isnull(ldttm_fecha_examen) then
		MessageBox("Fecha-Hora Incorrecto", "Favor de escribir la Fecha-Hora de Examen ", StopSign!)
		return -1
	end if

end if

return 1
end function

on w_doc_ole_posgrado_vent.create
int iCurrent
call super::create
this.dw_solicitud_titulacion_pos=create dw_solicitud_titulacion_pos
this.cb_elige_jurado=create cb_elige_jurado
this.cb_almacena_solicitud=create cb_almacena_solicitud
this.cb_insertar=create cb_insertar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_solicitud_titulacion_pos
this.Control[iCurrent+2]=this.cb_elige_jurado
this.Control[iCurrent+3]=this.cb_almacena_solicitud
this.Control[iCurrent+4]=this.cb_insertar
end on

on w_doc_ole_posgrado_vent.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_solicitud_titulacion_pos)
destroy(this.cb_elige_jurado)
destroy(this.cb_almacena_solicitud)
destroy(this.cb_insertar)
end on

event open;call super::open;long ll_rows

dw_documento_titulacion.SetTransObject(gtr_sce)
dw_solicitud_titulacion_pos.SetTransObject(gtr_sce)
ll_rows= dw_documento_titulacion.Retrieve(16)

gnv_app.inv_security.of_SetSecurity(this)

x=1
y=1

iuo_atencion_posgrado = CREATE uo_atencion_posgrado
end event

type cb_seleccion from w_doc_ole_posgrado`cb_seleccion within w_doc_ole_posgrado_vent
boolean visible = false
integer y = 1460
end type

type st_3 from w_doc_ole_posgrado`st_3 within w_doc_ole_posgrado_vent
integer y = 1488
end type

type uo_tipo_documento from w_doc_ole_posgrado`uo_tipo_documento within w_doc_ole_posgrado_vent
boolean visible = false
integer y = 1460
end type

type ole_documento from w_doc_ole_posgrado`ole_documento within w_doc_ole_posgrado_vent
integer y = 892
end type

type dw_documento_titulacion from w_doc_ole_posgrado`dw_documento_titulacion within w_doc_ole_posgrado_vent
integer y = 412
integer width = 3058
end type

type uo_datos_opc_cero_i from w_doc_ole_posgrado`uo_datos_opc_cero_i within w_doc_ole_posgrado_vent
end type

type dw_solicitud_titulacion_pos from u_dw within w_doc_ole_posgrado_vent
integer x = 64
integer y = 892
integer width = 3058
integer height = 824
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_solicitud_titulacion_pos"
boolean hscrollbar = true
boolean ib_rmbmenu = false
end type

type cb_elige_jurado from u_cb within w_doc_ole_posgrado_vent
integer x = 3136
integer y = 892
integer width = 219
integer taborder = 11
boolean bringtotop = true
string text = "Jurado"
end type

event clicked;call super::clicked;str_jurado_posgrado lst_parametros, lst_parametros_return
long ll_row

if dw_solicitud_titulacion_pos.RowCount()>0 then
	ll_row = dw_solicitud_titulacion_pos.GetRow()
	lst_parametros.cve_presidente = dw_solicitud_titulacion_pos.GetItemNumber(ll_row, "cve_presidente")
	lst_parametros.cve_vocal =	dw_solicitud_titulacion_pos.GetItemNumber(ll_row, "cve_vocal")
	lst_parametros.cve_secretario = dw_solicitud_titulacion_pos.GetItemNumber(ll_row, "cve_secretario")
	lst_parametros.cve_suplente_1 = dw_solicitud_titulacion_pos.GetItemNumber(ll_row, "cve_suplente_1")
	lst_parametros.cve_suplente_2 = dw_solicitud_titulacion_pos.GetItemNumber(ll_row, "cve_suplente_2")
	lst_parametros.nombre_presidente = dw_solicitud_titulacion_pos.GetItemString(ll_row, "nombre_presidente")
	lst_parametros.nombre_vocal = dw_solicitud_titulacion_pos.GetItemString(ll_row, "nombre_vocal")
	lst_parametros.nombre_secretario = dw_solicitud_titulacion_pos.GetItemString(ll_row, "nombre_secretario")
	lst_parametros.nombre_suplente_1 = dw_solicitud_titulacion_pos.GetItemString(ll_row, "nombre_suplente_1")
	lst_parametros.nombre_suplente_2 = dw_solicitud_titulacion_pos.GetItemString(ll_row, "nombre_suplente_2")

end if

OpenWithParm(w_seleccion_jurado, lst_parametros, parent)
lst_parametros_return =Message.PowerObjectParm
if dw_solicitud_titulacion_pos.RowCount()>0 then
	ll_row = dw_solicitud_titulacion_pos.GetRow()
	dw_solicitud_titulacion_pos.SetItem(ll_row, "cve_presidente", lst_parametros_return.cve_presidente )
	dw_solicitud_titulacion_pos.SetItem(ll_row, "cve_vocal", lst_parametros_return.cve_vocal )
	dw_solicitud_titulacion_pos.SetItem(ll_row, "cve_secretario", lst_parametros_return.cve_secretario )
	dw_solicitud_titulacion_pos.SetItem(ll_row, "cve_suplente_1", lst_parametros_return.cve_suplente_1 )
	dw_solicitud_titulacion_pos.SetItem(ll_row, "cve_suplente_2", lst_parametros_return.cve_suplente_2 )
	dw_solicitud_titulacion_pos.SetItem(ll_row, "nombre_presidente", lst_parametros_return.nombre_presidente )
	dw_solicitud_titulacion_pos.SetItem(ll_row, "nombre_vocal", lst_parametros_return.nombre_vocal )
	dw_solicitud_titulacion_pos.SetItem(ll_row, "nombre_secretario", lst_parametros_return.nombre_secretario )
	dw_solicitud_titulacion_pos.SetItem(ll_row, "nombre_suplente_1", lst_parametros_return.nombre_suplente_1 )
	dw_solicitud_titulacion_pos.SetItem(ll_row, "nombre_suplente_2", lst_parametros_return.nombre_suplente_2 )

end if


end event

type cb_almacena_solicitud from u_cb within w_doc_ole_posgrado_vent
integer x = 3136
integer y = 1260
integer width = 219
integer taborder = 21
boolean bringtotop = true
string text = "Guardar"
end type

event clicked;call super::clicked;str_jurado_posgrado lst_parametros, lst_parametros_return
long ll_row, ll_res_update

if dw_solicitud_titulacion_pos.RowCount()>0 then
	if dw_solicitud_titulacion_pos.ModifiedCount()>0 then
		if wf_valida_solicitud()<>-1 then
			ll_res_update = dw_solicitud_titulacion_pos.Update()
			if ll_res_update= 1 then
				COMMIT USING gtr_sce;
				MessageBox("Solicitud Almacenada", "Se ha almacenado la solicitud exitosamente",Information!)
			else
				ROLLBACK USING gtr_sce;
				MessageBox("Error en Solicitud", "NO se ha podido almacenar la solicitud",Information!)
			end if
		end if
	end if
end if


end event

type cb_insertar from u_cb within w_doc_ole_posgrado_vent
integer x = 3136
integer y = 1624
integer width = 219
integer taborder = 31
boolean bringtotop = true
string text = "Insertar"
end type

event clicked;call super::clicked;str_jurado_posgrado lst_parametros, lst_parametros_return
long ll_row, ll_res_update, ll_cuenta, ll_cve_carrera, ll_cve_plan
integer li_confirmacion, li_actual_posgrado_titulacion
dwItemStatus ldw_ItemStatus

if dw_solicitud_titulacion_pos.RowCount()>0 then
	ldw_ItemStatus = dw_solicitud_titulacion_pos.GetItemStatus(dw_solicitud_titulacion_pos.GetRow(),0, Primary!	)
	if ldw_ItemStatus=New! or ldw_ItemStatus=NewModified!	then
		MessageBox("Informacion sin Almacenar", "Favor de Guardar la información del alumno antes de Insertarlo",StopSign!)			
		return
	end if
	li_confirmacion = MessageBox("Confirmar Inserción", "¿Desea Insertar la información?",Question!,YesNo!)
	if li_confirmacion =1 then
		ll_cuenta = uo_datos_opc_cero_i.of_obten_cuenta()
		ll_cve_carrera = uo_datos_opc_cero_i.of_obten_cve_carrera()
		ll_cve_plan= uo_datos_opc_cero_i.of_obten_cve_plan(ll_cuenta)
		li_actual_posgrado_titulacion = of_actual_posgrado_titulacion(ll_cuenta, ll_cve_carrera, ll_cve_plan)
		if li_actual_posgrado_titulacion = 0 then
			MessageBox("Información insertada", "Se ha almacenado la información exitosamente ",Information!)	
		elseif li_actual_posgrado_titulacion = -1 then
			MessageBox("Error de inserción", "No es posible almacenar la información de titulación ",StopSign!)	
		end if
	end if
else
	MessageBox("Datos Inexistentes", "Favor de seleccionar a un alumno antes de insertarlo ",StopSign!)	
end if


end event

