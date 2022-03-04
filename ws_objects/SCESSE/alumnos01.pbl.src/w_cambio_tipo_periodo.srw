$PBExportHeader$w_cambio_tipo_periodo.srw
forward
global type w_cambio_tipo_periodo from window
end type
type cb_cancelar from commandbutton within w_cambio_tipo_periodo
end type
type cb_aceptar from commandbutton within w_cambio_tipo_periodo
end type
type dw_tipo_periodo from datawindow within w_cambio_tipo_periodo
end type
end forward

global type w_cambio_tipo_periodo from window
integer width = 1298
integer height = 600
boolean titlebar = true
string title = "Selección de Tipo de Periodo"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_cancelar cb_cancelar
cb_aceptar cb_aceptar
dw_tipo_periodo dw_tipo_periodo
end type
global w_cambio_tipo_periodo w_cambio_tipo_periodo

type variables
Long il_origen = 0
end variables

on w_cambio_tipo_periodo.create
this.cb_cancelar=create cb_cancelar
this.cb_aceptar=create cb_aceptar
this.dw_tipo_periodo=create dw_tipo_periodo
this.Control[]={this.cb_cancelar,&
this.cb_aceptar,&
this.dw_tipo_periodo}
end on

on w_cambio_tipo_periodo.destroy
destroy(this.cb_cancelar)
destroy(this.cb_aceptar)
destroy(this.dw_tipo_periodo)
end on

event open;// Se carga el listado de tipos de periodo.
String ls_query
Datawindowchild ldwc_tipo_periodo

IF NOT ISNULL(Message.doubleParm) THEN il_origen = Message.doubleParm

dw_tipo_periodo.INSERTROW(0)

ls_query = " SELECT id_tipo, descripcion " + &
				" FROM periodo_tipo " 

dw_tipo_periodo.GETCHILD("id_tipo", ldwc_tipo_periodo) 
ldwc_tipo_periodo.SETTRANSOBJECT(gtr_sce) 
ldwc_tipo_periodo.MODIFY("Datawindow.Table.Select = '" + ls_query + "'") 
ldwc_tipo_periodo.RETRIEVE() 
				
// Se selecciona por default el tipo de periodo actual.
dw_tipo_periodo.SETITEM(1, "id_tipo", gs_tipo_periodo)

// Se deshabilita boton de cancelar
IF il_origen = 1 THEN // 1 = Ventana Login
	cb_cancelar.enabled = FALSE
	THIS.controlMenu = FALSE
END IF

end event

type cb_cancelar from commandbutton within w_cambio_tipo_periodo
integer x = 814
integer y = 348
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;CLOSE(PARENT)




end event

type cb_aceptar from commandbutton within w_cambio_tipo_periodo
integer x = 389
integer y = 348
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
end type

event clicked;STRING 	ls_tipo_periodo 
STRING 	ls_desc_periodo
INTEGER le_respuesta = 1
dw_tipo_periodo.ACCEPTTEXT()

uo_periodo_tipo_servicios luo_periodo_tipo_servicios
luo_periodo_tipo_servicios = CREATE uo_periodo_tipo_servicios

ls_tipo_periodo = dw_tipo_periodo.GETITEMSTRING(1, "id_tipo") 

IF ISNULL(ls_tipo_periodo)  THEN ls_tipo_periodo = ""

IF ls_tipo_periodo = "" THEN 
	MessageBox("Alerta", "Seleccione un tipo de periodo.", Exclamation!)
	RETURN
END IF	

ls_desc_periodo = luo_periodo_tipo_servicios.f_obten_desc_periodo(gtr_sce, ls_tipo_periodo)

IF luo_periodo_tipo_servicios.i_error = -1 THEN 
	MessageBox(luo_periodo_tipo_servicios.s_title, luo_periodo_tipo_servicios.s_message, StopSign!)
	RETURN luo_periodo_tipo_servicios.i_error
END IF	

IF il_origen = 0 THEN 
	le_respuesta = MESSAGEBOX("Confirmación.", "El periodo de operación por default será " + UPPER(ls_desc_periodo) + "   ¿Desea continuar?", Question!, YesNoCancel!)
END IF	

IF le_respuesta = 1 THEN 
	// Se asigna el tipo de periodo seleccionado.
	gs_tipo_periodo = ls_tipo_periodo 
	
	IF il_origen = 0 THEN 
		CLOSE(PARENT)
		w_principal.TRIGGEREVENT("ue_inicializa_ventana")
	ELSE
		CLOSE(PARENT)
	END IF
	
ELSEIF le_respuesta = 2 THEN 
	RETURN 0

ELSEIF le_respuesta = 3 THEN 
	CLOSE(PARENT)
END IF

RETURN 0
end event

type dw_tipo_periodo from datawindow within w_cambio_tipo_periodo
integer x = 64
integer y = 52
integer width = 1152
integer height = 268
integer taborder = 10
string title = "none"
string dataobject = "d_tipo_periodo_lista_seleccion"
boolean border = false
boolean livescroll = true
end type

