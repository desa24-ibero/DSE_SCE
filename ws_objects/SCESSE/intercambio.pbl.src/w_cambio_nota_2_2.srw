$PBExportHeader$w_cambio_nota_2_2.srw
$PBExportComments$Ventana auxiliar para mostrar la relación por seriación que existe entre las materias que ha cursado o esta cursando un alumno. Vea w_cambio_nota_2.
forward
global type w_cambio_nota_2_2 from window
end type
type cb_cerrar from commandbutton within w_cambio_nota_2_2
end type
type dw_materias_ligadas from datawindow within w_cambio_nota_2_2
end type
end forward

global type w_cambio_nota_2_2 from window
integer width = 3182
integer height = 1316
boolean titlebar = true
string title = "Materias ligadas..."
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 67108864
cb_cerrar cb_cerrar
dw_materias_ligadas dw_materias_ligadas
end type
global w_cambio_nota_2_2 w_cambio_nota_2_2

type variables
str_msgparm istr_msgparm
end variables

on w_cambio_nota_2_2.create
this.cb_cerrar=create cb_cerrar
this.dw_materias_ligadas=create dw_materias_ligadas
this.Control[]={this.cb_cerrar,&
this.dw_materias_ligadas}
end on

on w_cambio_nota_2_2.destroy
destroy(this.cb_cerrar)
destroy(this.dw_materias_ligadas)
end on

event open;//////////////////////////////////////////////////////////////////////////////
//
//	Object Name:  w_cambio_nota_2_2
//
//	Description:
//	Ventana auxiliar para realizar los cambios de nota de manera definitiva.
//	Interfase.
//	1.- Consta de una datawindow donde se muestran los datos de las materias
// encadenadas por su seriación. Una como antecedente (prerrequisito) y la
//	otra como consecuente.
//	2.- Consta de un botón para salir de la ventana.
//	Operación.
//	Realiza la carga de la datawindow a través del procedimiento almacenado
//	sp_cambio_nota_relaciones1.
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
long ll_resultado

/*----------------------------------------------------------------------*/
/* Centramos la ventana.																*/
/*----------------------------------------------------------------------*/

this.x = (this.parentwindow().x + this.parentwindow().width - this.width) / 2
this.y = (this.parentwindow().y + this.parentwindow().height - this.height) / 2

/*----------------------------------------------------------------------*/
/* Lectura de parametros.																*/
/*----------------------------------------------------------------------*/
istr_msgparm = Message.PowerObjectParm

ll_resultado = this.dw_materias_ligadas.settransobject(gtr_sce)
gtr_sce.Autocommit = true
ll_resultado = this.dw_materias_ligadas.retrieve(istr_msgparm.data[1],"%","%")
gtr_sce.Autocommit = false

end event

type cb_cerrar from commandbutton within w_cambio_nota_2_2
event ue_keydown pbm_keydown
integer x = 2775
integer y = 1104
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

type dw_materias_ligadas from datawindow within w_cambio_nota_2_2
integer x = 37
integer y = 36
integer width = 3081
integer height = 1036
integer taborder = 10
string title = "none"
string dataobject = "d_parent_child1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	dberror
//
//	Arguments:
//	sqldbcode		Consulte la documentación de PB.
//	sqlerrtext		Consulte la documentación de PB.
//	sqlsyntax		Consulte la documentación de PB.
//	buffer			Consulte la documentación de PB.
//	row				Consulte la documentación de PB.
//
//	Returns:
//	Long
//
//	Description:
//	Manejo de errores. Atrapa el error 277 generado al recuperar los datos
//	desde el procedimiento almacenado sp_cambio_nota_relaciones1.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
CHOOSE CASE sqldbcode
	CASE 277
		RETURN 1		
	CASE ELSE
		RETURN 0		
END CHOOSE

end event

