$PBExportHeader$w_tramitacion_escolar_opc_cero.srw
forward
global type w_tramitacion_escolar_opc_cero from w_doc_ole_opc_cero
end type
end forward

global type w_tramitacion_escolar_opc_cero from w_doc_ole_opc_cero
integer height = 1517
string title = "Documentos del Tramitación Escolar por Opción Cero"
end type
global w_tramitacion_escolar_opc_cero w_tramitacion_escolar_opc_cero

on w_tramitacion_escolar_opc_cero.create
int iCurrent
call super::create
end on

on w_tramitacion_escolar_opc_cero.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;long ll_rows

dw_documento_titulacion.SetTransObject(gtr_sce)
ll_rows= dw_documento_titulacion.Retrieve(4)

iuo_atencion_opc_cero = CREATE uo_atencion_opc_cero
x=1
y=1
end event

type uo_datos_opc_cero_i from w_doc_ole_opc_cero`uo_datos_opc_cero_i within w_tramitacion_escolar_opc_cero
end type

type cb_seleccion from w_doc_ole_opc_cero`cb_seleccion within w_tramitacion_escolar_opc_cero
boolean visible = false
integer y = 1370
end type

type st_3 from w_doc_ole_opc_cero`st_3 within w_tramitacion_escolar_opc_cero
integer y = 1398
end type

type uo_tipo_documento from w_doc_ole_opc_cero`uo_tipo_documento within w_tramitacion_escolar_opc_cero
boolean visible = false
integer y = 1370
end type

type ole_documento from w_doc_ole_opc_cero`ole_documento within w_tramitacion_escolar_opc_cero
integer y = 896
end type

type dw_documento_titulacion from w_doc_ole_opc_cero`dw_documento_titulacion within w_tramitacion_escolar_opc_cero
integer y = 416
end type

