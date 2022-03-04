$PBExportHeader$w_actualiza_documentos_opc_cero.srw
forward
global type w_actualiza_documentos_opc_cero from window
end type
type cb_1 from commandbutton within w_actualiza_documentos_opc_cero
end type
end forward

global type w_actualiza_documentos_opc_cero from window
integer width = 1229
integer height = 634
boolean titlebar = true
string title = "Actualización de Documentos Masiva para Opción Cero"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
cb_1 cb_1
end type
global w_actualiza_documentos_opc_cero w_actualiza_documentos_opc_cero

on w_actualiza_documentos_opc_cero.create
this.cb_1=create cb_1
this.Control[]={this.cb_1}
end on

on w_actualiza_documentos_opc_cero.destroy
destroy(this.cb_1)
end on

type cb_1 from commandbutton within w_actualiza_documentos_opc_cero
integer x = 95
integer y = 352
integer width = 1009
integer height = 106
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualización de Documentos"
end type

event clicked;uo_atencion_opc_cero luo_atencion_opc_cero
int li_confirma, li_res
li_confirma = MessageBox("Confirmación","¿Desea Actualizar los documentos de Todos los Alumnos de Licenciatura?",Question!,YesNo!)
if li_confirma=1 then
	luo_atencion_opc_cero = CREATE uo_atencion_opc_cero 
	SetPointer(HourGlass!)
	li_res = luo_atencion_opc_cero.of_actualiza_datos_tramites()
	SetPointer(Arrow!)
	if li_res = -1 then
		MessageBox("Error al Actualizar","No se han guardado los cambios",StopSign!)
	else
		MessageBox("Actualizacion","Se han guardado los cambios",Information!)
	end if
	if isvalid(	luo_atencion_opc_cero) then
		DESTROY luo_atencion_opc_cero
	end if
end if
end event

