$PBExportHeader$w_cambio_nota_2_3.srw
$PBExportComments$Ventana auxiliar que muestra el resultado del proceso de cambio de nota definitiva. Vea w_cambio_nota_2.
forward
global type w_cambio_nota_2_3 from window
end type
type cb_imprimir from commandbutton within w_cambio_nota_2_3
end type
type cb_cerrar from commandbutton within w_cambio_nota_2_3
end type
type dw_materias_ligadas from datawindow within w_cambio_nota_2_3
end type
end forward

global type w_cambio_nota_2_3 from window
integer width = 2533
integer height = 1244
boolean titlebar = true
string title = "Resultado"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 67108864
cb_imprimir cb_imprimir
cb_cerrar cb_cerrar
dw_materias_ligadas dw_materias_ligadas
end type
global w_cambio_nota_2_3 w_cambio_nota_2_3

type variables
window iw_pariente
datastore ids_materias_resultado

end variables

on w_cambio_nota_2_3.create
this.cb_imprimir=create cb_imprimir
this.cb_cerrar=create cb_cerrar
this.dw_materias_ligadas=create dw_materias_ligadas
this.Control[]={this.cb_imprimir,&
this.cb_cerrar,&
this.dw_materias_ligadas}
end on

on w_cambio_nota_2_3.destroy
destroy(this.cb_imprimir)
destroy(this.cb_cerrar)
destroy(this.dw_materias_ligadas)
end on

event open;//////////////////////////////////////////////////////////////////////////////
//
//	Object Name:  w_cambio_nota_2_3
//
//	Description:
//	Ventana auxiliar para realizar los cambios de nota de manera definitiva.
// Esta ventana se muestra al final del proceso de cambio de nota como un
// reporte de las modificaciones realizadas en la base de datos e incluye
// aquellas materias que fueron borradas como consecuencia de haberse
//	reprobado un prerrequisito.
//	Interfase.
//	1.- Consta de una datawindow donde se muestran los datos de las materias
// encadenadas por su seriación. Una como antecedente (prerrequisito) y la
//	otra como consecuente.
//	2.- Consta de botones para imprimir el contenido de la datawindow y para
//	salir de la ventana.
//	Operación.
//	Realiza la carga de la datawindow a través del procedimiento almacenado
//	sp_cambio_nota_relaciones2.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	open
//
//	Arguments:
//	None
//
//	Returns:
//	Long
//
//	Description:	
//	Centra la ventana sobre el escritorio y recibe los parámetros de trabajo
//	desde la ventana w_cambio_nota_2.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
/*----------------------------------------------------------------------*/
/* Ventana pariente.																		*/
/*----------------------------------------------------------------------*/
iw_pariente = this.parentwindow().getactivesheet()

/*----------------------------------------------------------------------*/
/* Centramos la ventana.																*/
/*----------------------------------------------------------------------*/

this.x = (this.parentwindow().x + this.parentwindow().width - this.width) / 2
this.y = (this.parentwindow().y + this.parentwindow().height - this.height) / 2

/*----------------------------------------------------------------------*/
/* Lectura de parametros.																*/
/*----------------------------------------------------------------------*/
this.ids_materias_resultado = Message.PowerObjectParm
this.ids_materias_resultado.sharedata(this.dw_materias_ligadas)

end event

type cb_imprimir from commandbutton within w_cambio_nota_2_3
event ue_keydown pbm_keydown
integer x = 1783
integer y = 1036
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Imprimir"
end type

event ue_keydown;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	ue_keydown
//
//	Arguments:
//	key			Consulte la documentación de PB.
//	keyflags		Consulte la documentación de PB.
//
//	Returns:
//	Long
//
//	Description:
//	Manejo de teclado. Utiliza la API keybd_event (vea la sección Global
//	External Functions)
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
CHOOSE CASE key
	CASE KeyEnter!
		this.triggerevent(clicked!)
	CASE KeyUpArrow!,KeyLeftArrow!
		keybd_event(16,0,0,0)
		keybd_event(9,0,0,0)
		keybd_event(16,0,2,0)
		keybd_event(9,0,2,0)		
	CASE KeyDownArrow!,KeyRightArrow!
		keybd_event(9,0,0,0)
		keybd_event(9,0,2,0)		
END CHOOSE

end event

event clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	clicked
//
//	Arguments:
//	None
//
//	Returns:
//	Long
//
//	Description:
//	Imprime la datawindow.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
parent.dw_materias_ligadas.print()

end event

type cb_cerrar from commandbutton within w_cambio_nota_2_3
event ue_keydown pbm_keydown
integer x = 2149
integer y = 1036
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Cerrar"
end type

event ue_keydown;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	ue_keydown
//
//	Arguments:
//	key			Consulte la documentación de PB.
//	keyflags		Consulte la documentación de PB.
//
//	Returns:
//	Long
//
//	Description:
//	Manejo de teclado. Utiliza la API keybd_event (vea la sección Global
//	External Functions)
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
CHOOSE CASE key
	CASE KeyEnter!
		this.triggerevent(clicked!)
	CASE KeyUpArrow!,KeyLeftArrow!
		keybd_event(16,0,0,0)
		keybd_event(9,0,0,0)
		keybd_event(16,0,2,0)
		keybd_event(9,0,2,0)		
	CASE KeyDownArrow!,KeyRightArrow!
		keybd_event(9,0,0,0)
		keybd_event(9,0,2,0)		
END CHOOSE

end event

event clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	clicked
//
//	Arguments:
//	None
//
//	Returns:
//	Long
//
//	Description:
//	Cierra la ventana.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
close(parent)
end event

type dw_materias_ligadas from datawindow within w_cambio_nota_2_3
integer x = 46
integer y = 40
integer width = 2441
integer height = 956
integer taborder = 10
string title = "none"
string dataobject = "ddw_materias_resultado"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

