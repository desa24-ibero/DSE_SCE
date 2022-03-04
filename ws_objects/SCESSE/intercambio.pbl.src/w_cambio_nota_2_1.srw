$PBExportHeader$w_cambio_nota_2_1.srw
$PBExportComments$Ventana auxiliar para cambiar la calificación de una materia de manera definitiva. Vea w_cambio_nota_2.
forward
global type w_cambio_nota_2_1 from window
end type
type cb_cerrar from commandbutton within w_cambio_nota_2_1
end type
type cb_aplicar from commandbutton within w_cambio_nota_2_1
end type
type st_calificacion_new from statictext within w_cambio_nota_2_1
end type
type st_calificacion_old from statictext within w_cambio_nota_2_1
end type
type sle_calificacion_new from singlelineedit within w_cambio_nota_2_1
end type
type sle_calificacion_old from singlelineedit within w_cambio_nota_2_1
end type
type gb_1 from groupbox within w_cambio_nota_2_1
end type
end forward

global type w_cambio_nota_2_1 from window
integer width = 1083
integer height = 652
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 67108864
cb_cerrar cb_cerrar
cb_aplicar cb_aplicar
st_calificacion_new st_calificacion_new
st_calificacion_old st_calificacion_old
sle_calificacion_new sle_calificacion_new
sle_calificacion_old sle_calificacion_old
gb_1 gb_1
end type
global w_cambio_nota_2_1 w_cambio_nota_2_1

type variables
window iw_pariente
str_msgparm istr_msgparm


end variables

on w_cambio_nota_2_1.create
this.cb_cerrar=create cb_cerrar
this.cb_aplicar=create cb_aplicar
this.st_calificacion_new=create st_calificacion_new
this.st_calificacion_old=create st_calificacion_old
this.sle_calificacion_new=create sle_calificacion_new
this.sle_calificacion_old=create sle_calificacion_old
this.gb_1=create gb_1
this.Control[]={this.cb_cerrar,&
this.cb_aplicar,&
this.st_calificacion_new,&
this.st_calificacion_old,&
this.sle_calificacion_new,&
this.sle_calificacion_old,&
this.gb_1}
end on

on w_cambio_nota_2_1.destroy
destroy(this.cb_cerrar)
destroy(this.cb_aplicar)
destroy(this.st_calificacion_new)
destroy(this.st_calificacion_old)
destroy(this.sle_calificacion_new)
destroy(this.sle_calificacion_old)
destroy(this.gb_1)
end on

event open;//////////////////////////////////////////////////////////////////////////////
//
//	Object Name:  w_cambio_nota_2_1
//
//	Description:
//	Ventana auxiliar para realizar los cambios de nota de manera definitiva.
//	Interfase.
//	1.- Consta de 2 cajas de texto, una con el calificación actual (bloqueada)
//	y otra para realizar el cambio de nota.
//	2.- Consta de botones para aplicar los cambios y para salir de la ventana.
//	Operación.
//	Cuando se ha modificado la calificación se procede a evaluar si es válida
//	para este proceso. Si la calificación es aprobatoria, entonces modifica
//	la datawindow de la ventana w_cambio_nota_2 palomeando el campo "procesar";
//	si la calificación es reprobatoria muestra un mensaje informativo cuando la
//	materia cuya calificación se ha alterado este relacionada con otras por
//	seriación, entonces modifica la datawindow de la ventana w_cambio_nota_2
//	palomeando el campo "procesar"; en otro caso envía un mensaje de error.
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
istr_msgparm = Message.PowerObjectParm

this.title = istr_msgparm.data[3]
this.sle_calificacion_old.text = istr_msgparm.data[8]
this.sle_calificacion_new.text = istr_msgparm.data[8]

end event

type cb_cerrar from commandbutton within w_cambio_nota_2_1
event ue_keydown pbm_keydown
integer x = 549
integer y = 424
integer width = 343
integer height = 92
integer taborder = 40
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

type cb_aplicar from commandbutton within w_cambio_nota_2_1
event ue_keydown pbm_keydown
integer x = 165
integer y = 424
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Aplicar"
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
//	Evalúa que la calificación ingresada sea aprobatoria o reprobatoria, 
//	entonces envía un arreglo como parámetro a w_cambio_nota_2 (vea el
//	evento ue_setitem).
//	Cuando la calificación no es válida envía un mensaje de error.
// También verifica que la materia, para la cual se ha modificado la
//	calificación, en el caso de ser calilficación reprobatoria, no tenga
// dependientes. Cuando la materia es prerrequisito para otras materias
//	se genera un mensaje que indica las materias que podrían ser afectadas
//	por el cambio.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
string ls_titulo, ls_mensaje
string ls_calificacion
datastore lds_materias_ligadas
any la_data[]
long ll_resultado
long ll_renglon
long ll_renglones

ls_calificacion = trim(upper(sle_calificacion_new.text))

if iw_pariente.dynamic of_materia_aprobada(ls_calificacion) then
	istr_msgparm.data[8] = ls_calificacion
	Message.PowerObjectParm = istr_msgparm
	iw_pariente.dynamic event ue_setitem()
elseif iw_pariente.dynamic of_materia_reprobada(ls_calificacion) then
/*----------------------------------------------------------------------*/
/* Usamos un datastore para verificar que no existan materias dependien-*/
/* tes.																						*/
/*----------------------------------------------------------------------*/
	lds_materias_ligadas = create datastore
	lds_materias_ligadas.dataobject = "d_parent_child2"
	lds_materias_ligadas.settransobject(gtr_sce)
	ll_resultado = lds_materias_ligadas.retrieve(istr_msgparm.data[1],istr_msgparm.data[2],"%","%")
/*----------------------------------------------------------------------*/
/* Ojo. El datastore esta previamente filtrado con: not isNull(cuenta2)	*/
/* Vea el datawindow d_parent_child2												*/
/*----------------------------------------------------------------------*/
	ll_renglones = lds_materias_ligadas.rowcount()
	if ll_renglones = 0 then
/*----------------------------------------------------------------------*/
/* No hay materias dependientes.														*/
/*----------------------------------------------------------------------*/
		istr_msgparm.data[8] = ls_calificacion
		Message.PowerObjectParm = istr_msgparm
		iw_pariente.dynamic event ue_setitem()	
	else
/*----------------------------------------------------------------------*/
/* Hay materias dependientes.															*/
/*----------------------------------------------------------------------*/
		ls_titulo = string(istr_msgparm.data[2]) + "-" + istr_msgparm.data[3]
		ls_mensaje = "Las siguientes materias seran afectadas por este cambio:~r~n"
		for ll_renglon = 1 to ll_renglones
			la_data = lds_materias_ligadas.object.data[ll_renglon]
			ls_mensaje += string(la_data[13]) + "-" + la_data[14] + "~r~n"
		next
		ls_mensaje += "¿Desea continuar...?~r~n"	
		ll_resultado = MessageBox(ls_titulo, ls_mensaje,Question!,YesNo!)
		if ll_resultado = 1 then
			istr_msgparm.data[8] = ls_calificacion
			Message.PowerObjectParm = istr_msgparm
			iw_pariente.dynamic event ue_setitem()
		end if
	end if
	destroy lds_materias_ligadas
else
	ls_titulo = "Error al evaluar la calificación"
	ls_mensaje = "La calificación " + ls_calificacion + " no es válida para este proceso"
	MessageBox(ls_titulo, ls_mensaje,stopsign!)
end if
end event

type st_calificacion_new from statictext within w_cambio_nota_2_1
integer x = 105
integer y = 268
integer width = 398
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nueva calificación"
boolean focusrectangle = false
end type

type st_calificacion_old from statictext within w_cambio_nota_2_1
integer x = 105
integer y = 152
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Calificación"
boolean focusrectangle = false
end type

type sle_calificacion_new from singlelineedit within w_cambio_nota_2_1
event ue_keydown pbm_keydown
integer x = 731
integer y = 232
integer width = 233
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
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
		keybd_event(9,0,0,0)
		keybd_event(9,0,2,0)		
END CHOOSE

end event

type sle_calificacion_old from singlelineedit within w_cambio_nota_2_1
event ue_keydown pbm_keydown
integer x = 731
integer y = 116
integer width = 233
integer height = 88
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
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
		keybd_event(9,0,0,0)
		keybd_event(9,0,2,0)		
END CHOOSE

end event

type gb_1 from groupbox within w_cambio_nota_2_1
integer x = 46
integer y = 24
integer width = 965
integer height = 376
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cambio de nota"
borderstyle borderstyle = stylelowered!
end type

