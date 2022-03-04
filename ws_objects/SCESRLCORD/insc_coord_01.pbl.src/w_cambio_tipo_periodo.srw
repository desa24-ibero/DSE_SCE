$PBExportHeader$w_cambio_tipo_periodo.srw
forward
global type w_cambio_tipo_periodo from window
end type
type cb_2 from commandbutton within w_cambio_tipo_periodo
end type
type cb_1 from commandbutton within w_cambio_tipo_periodo
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
cb_2 cb_2
cb_1 cb_1
dw_tipo_periodo dw_tipo_periodo
end type
global w_cambio_tipo_periodo w_cambio_tipo_periodo

on w_cambio_tipo_periodo.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_tipo_periodo=create dw_tipo_periodo
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_tipo_periodo}
end on

on w_cambio_tipo_periodo.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_tipo_periodo)
end on

event open;

// Se carga el listado de tipos de periodo.

STRING ls_query
Datawindowchild ldwc_tipo_periodo

dw_tipo_periodo.INSERTROW(0)


ls_query = " SELECT id_tipo, descripcion " + &
				" FROM periodo_tipo " 

dw_tipo_periodo.GETCHILD("id_tipo", ldwc_tipo_periodo) 
ldwc_tipo_periodo.SETTRANSOBJECT(sqlca) 
ldwc_tipo_periodo.MODIFY("Datawindow.Table.Select = '" + ls_query + "'") 
ldwc_tipo_periodo.RETRIEVE() 
				
// Se selecciona por default el tipo de periodo actual.
dw_tipo_periodo.SETITEM(1, "id_tipo", gs_tipo_periodo) 



				
				
				
				

				
				
				
				
				







end event

type cb_2 from commandbutton within w_cambio_tipo_periodo
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

event clicked;
CLOSE(PARENT)




end event

type cb_1 from commandbutton within w_cambio_tipo_periodo
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

event clicked;
STRING ls_tipo_periodo 
STRING ls_tipo_periodo_desc


dw_tipo_periodo.ACCEPTTEXT()

ls_tipo_periodo = dw_tipo_periodo.GETITEMSTRING(1, "id_tipo") 

// Se recupera el tipo de periodo
SELECT descripcion
INTO :ls_tipo_periodo_desc
FROM periodo_tipo 
WHERE id_tipo = :ls_tipo_periodo 
 USING SQLCA;
IF ISNULL(ls_tipo_periodo)  THEN ls_tipo_periodo = "" 

INTEGER le_respuesta

le_respuesta = MESSAGEBOX("Confirmación.", "El periodo de operación por default será " + UPPER(ls_tipo_periodo_desc) + "   ¿Desea continuar?", Question!, YesNoCancel!)

IF le_respuesta = 1 THEN 

	// Se asigna el tipo de periodo seleccionado.
	gs_tipo_periodo = ls_tipo_periodo 
	CLOSE(PARENT)
	
	w_insc_coord.TRIGGEREVENT("ue_inicializa") 
	
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

