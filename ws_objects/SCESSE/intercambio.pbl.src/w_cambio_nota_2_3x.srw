$PBExportHeader$w_cambio_nota_2_3x.srw
$PBExportComments$Ventana auxiliar que muestra el resultado del proceso de cambio de nota definitiva. Vea w_cambio_nota_2.
forward
global type w_cambio_nota_2_3x from window
end type
type cb_1 from commandbutton within w_cambio_nota_2_3x
end type
type cb_2 from commandbutton within w_cambio_nota_2_3x
end type
type dw_1 from datawindow within w_cambio_nota_2_3x
end type
end forward

global type w_cambio_nota_2_3x from window
integer width = 2533
integer height = 1244
boolean titlebar = true
string title = "Resultado"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 67108864
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
end type
global w_cambio_nota_2_3x w_cambio_nota_2_3x

type variables
window iw_pariente
datastore ids_materias_resultado

end variables

on w_cambio_nota_2_3x.create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.cb_2,&
this.dw_1}
end on

on w_cambio_nota_2_3x.destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
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
this.ids_materias_resultado.sharedata(this.dw_1)

end event

type cb_1 from commandbutton within w_cambio_nota_2_3x
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

event ue_keydown;CHOOSE CASE key
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

event clicked;parent.dw_1.print()


//string ls_titulo, ls_mensaje
//string ls_calificacion
//datastore lds_materias_ligadas
//any la_data[]
//long ll_resultado
//long ll_renglon
//long ll_renglones
//
//ls_calificacion = trim(upper(sle_2.text))
//
//if iw_pariente.dynamic of_materia_aprobada(ls_calificacion) then
//	istr_msgparm.data[8] = ls_calificacion
//	Message.PowerObjectParm = istr_msgparm
//	iw_pariente.dynamic event ue_setitem()
//elseif iw_pariente.dynamic of_materia_reprobada(ls_calificacion) then
///*----------------------------------------------------------------------*/
///* Usamos un datastore para verificar que no existan materias dependien-*/
///* tes.																						*/
///*----------------------------------------------------------------------*/
//	lds_materias_ligadas = create datastore
//	lds_materias_ligadas.dataobject = "d_parent_child2"
//	lds_materias_ligadas.settransobject(gtr_sce)
//	ll_resultado = lds_materias_ligadas.retrieve(istr_msgparm.data[1],istr_msgparm.data[2],"%","%")
///*----------------------------------------------------------------------*/
///* Ojo. El datastore esta previamente filtrado con: not isNull(cuenta2)	*/
///* Vea el datawindow d_parent_child2												*/
///*----------------------------------------------------------------------*/
//	ll_renglones = lds_materias_ligadas.rowcount()
//	if ll_renglones = 0 then
///*----------------------------------------------------------------------*/
///* No hay materias dependientes.														*/
///*----------------------------------------------------------------------*/
//		istr_msgparm.data[8] = ls_calificacion
//		Message.PowerObjectParm = istr_msgparm
//		iw_pariente.dynamic event ue_setitem()	
//	else
///*----------------------------------------------------------------------*/
///* Hay materias dependientes.															*/
///*----------------------------------------------------------------------*/
//		ls_titulo = string(istr_msgparm.data[2]) + "-" + istr_msgparm.data[3]
//		ls_mensaje = "Las siguientes materias seran afectadas por este cambio:~r~n"
//		for ll_renglon = 1 to ll_renglones
//			la_data = lds_materias_ligadas.object.data[ll_renglon]
//			ls_mensaje += string(la_data[13]) + "-" + la_data[14] + "~r~n"
//		next
//		ls_mensaje += "¿Desea continuar...?~r~n"	
//		ll_resultado = MessageBox(ls_titulo, ls_mensaje,Question!,YesNo!)
//		if ll_resultado = 1 then
//			istr_msgparm.data[8] = ls_calificacion
//			Message.PowerObjectParm = istr_msgparm
//			iw_pariente.dynamic event ue_setitem()
//		end if
//	end if
//	destroy lds_materias_ligadas
//else
//	ls_titulo = "Error al evaluar la calificación"
//	ls_mensaje = "La calificación " + ls_calificacion + " no es válida para este proceso"
//	MessageBox(ls_titulo, ls_mensaje,stopsign!)
//end if
end event

type cb_2 from commandbutton within w_cambio_nota_2_3x
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

event ue_keydown;CHOOSE CASE key
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

event clicked;close(parent)
end event

type dw_1 from datawindow within w_cambio_nota_2_3x
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

