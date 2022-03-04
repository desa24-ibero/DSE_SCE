$PBExportHeader$w_cambio_nota_seriacion_perm.srw
$PBExportComments$Ventana auxiliar para mostrar la relación por seriación que existe entre las materias que ha cursado o esta cursando un alumno. Vea w_cambio_nota_2.
forward
global type w_cambio_nota_seriacion_perm from window
end type
type dw_aviso_archivo_intercambio from datawindow within w_cambio_nota_seriacion_perm
end type
type dw_aviso_tesoreria_intercambio from datawindow within w_cambio_nota_seriacion_perm
end type
type cb_sancion_cursadas from commandbutton within w_cambio_nota_seriacion_perm
end type
type cb_sancion_inscritas from commandbutton within w_cambio_nota_seriacion_perm
end type
type dw_materias_ligadas_historico from datawindow within w_cambio_nota_seriacion_perm
end type
type cb_cerrar from commandbutton within w_cambio_nota_seriacion_perm
end type
type dw_materias_ligadas_inscritas from datawindow within w_cambio_nota_seriacion_perm
end type
end forward

global type w_cambio_nota_seriacion_perm from window
integer width = 3689
integer height = 2080
boolean titlebar = true
string title = "Materias ligadas  en cambio de nota permanente..."
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 67108864
dw_aviso_archivo_intercambio dw_aviso_archivo_intercambio
dw_aviso_tesoreria_intercambio dw_aviso_tesoreria_intercambio
cb_sancion_cursadas cb_sancion_cursadas
cb_sancion_inscritas cb_sancion_inscritas
dw_materias_ligadas_historico dw_materias_ligadas_historico
cb_cerrar cb_cerrar
dw_materias_ligadas_inscritas dw_materias_ligadas_inscritas
end type
global w_cambio_nota_seriacion_perm w_cambio_nota_seriacion_perm

type variables
str_msgparm istr_msgparm

n_cst_cambio_nota inv_cambio_nota

long il_cuenta
end variables

on w_cambio_nota_seriacion_perm.create
this.dw_aviso_archivo_intercambio=create dw_aviso_archivo_intercambio
this.dw_aviso_tesoreria_intercambio=create dw_aviso_tesoreria_intercambio
this.cb_sancion_cursadas=create cb_sancion_cursadas
this.cb_sancion_inscritas=create cb_sancion_inscritas
this.dw_materias_ligadas_historico=create dw_materias_ligadas_historico
this.cb_cerrar=create cb_cerrar
this.dw_materias_ligadas_inscritas=create dw_materias_ligadas_inscritas
this.Control[]={this.dw_aviso_archivo_intercambio,&
this.dw_aviso_tesoreria_intercambio,&
this.cb_sancion_cursadas,&
this.cb_sancion_inscritas,&
this.dw_materias_ligadas_historico,&
this.cb_cerrar,&
this.dw_materias_ligadas_inscritas}
end on

on w_cambio_nota_seriacion_perm.destroy
destroy(this.dw_aviso_archivo_intercambio)
destroy(this.dw_aviso_tesoreria_intercambio)
destroy(this.cb_sancion_cursadas)
destroy(this.cb_sancion_inscritas)
destroy(this.dw_materias_ligadas_historico)
destroy(this.cb_cerrar)
destroy(this.dw_materias_ligadas_inscritas)
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
long ll_trans_object, ll_trans_object_2 , ll_trans_object_3,ll_trans_object_4, ll_rows_inscritas, ll_rows_historico, ll_rows_aviso, ll_rows_aviso_archivo
string ls_movimiento = 'Baja'
/*----------------------------------------------------------------------*/
/* Centramos la ventana.																*/
/*----------------------------------------------------------------------*/

this.x = (this.parentwindow().x + this.parentwindow().width - this.width) / 2
this.y = (this.parentwindow().y + this.parentwindow().height - this.height) / 2

/*----------------------------------------------------------------------*/
/* Lectura de parametros.																*/
/*----------------------------------------------------------------------*/
istr_msgparm = Message.PowerObjectParm

inv_cambio_nota = Create using "n_cst_cambio_nota"

il_cuenta = istr_msgparm.data[1] 

ll_trans_object   = this.dw_materias_ligadas_inscritas.settransobject(gtr_sce)
ll_trans_object_2 = this.dw_materias_ligadas_historico.settransobject(gtr_sce)

ll_trans_object_3 = this.dw_aviso_tesoreria_intercambio.settransobject(gtr_sce)
ll_trans_object_4 = this.dw_aviso_archivo_intercambio.settransobject(gtr_sce)

//ll_rows_inscritas = this.dw_materias_ligadas_inscritas.retrieve(istr_msgparm.data[1],istr_msgparm.data[2])
//ll_rows_historico = this.dw_materias_ligadas_historico.retrieve(istr_msgparm.data[1],istr_msgparm.data[2])

ll_rows_inscritas = this.dw_materias_ligadas_inscritas.retrieve(il_cuenta)
ll_rows_historico = this.dw_materias_ligadas_historico.retrieve(il_cuenta)

ll_rows_aviso         = this.dw_aviso_tesoreria_intercambio.retrieve(il_cuenta,ls_movimiento)
ll_rows_aviso_archivo = this.dw_aviso_archivo_intercambio.retrieve(il_cuenta)



end event

type dw_aviso_archivo_intercambio from datawindow within w_cambio_nota_seriacion_perm
integer x = 2665
integer y = 1712
integer width = 955
integer height = 84
integer taborder = 30
string title = "none"
string dataobject = "d_aviso_archivo_interc_perm"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_aviso_tesoreria_intercambio from datawindow within w_cambio_nota_seriacion_perm
integer x = 2665
integer y = 816
integer width = 955
integer height = 84
integer taborder = 20
string title = "none"
string dataobject = "d_aviso_tesoreria_interc_perm_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_sancion_cursadas from commandbutton within w_cambio_nota_seriacion_perm
integer x = 1701
integer y = 1708
integer width = 933
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Sanciona Violación de Materias Cursadas"
end type

event clicked;//

integer li_sanciona_ser_int_mat_insc, li_confirmacion, li_confirmacion2, li_print
long ll_rows_archivo, ll_rows_historico

li_confirmacion2= MessageBox("Aviso","¿Desea imprimir las materias que violan la seriación?",Question!,YesNo!)

if li_confirmacion2 = 1 then
	li_print= dw_aviso_archivo_intercambio.Print()
	if li_print = 1 then
		MessageBox("Información","Se imprimió el reporte exitosamente",Information!)		
	else		
		MessageBox("Error","NO imprimió el reporte",StopSign!)		
	end if
end if

li_confirmacion = MessageBox("¡Advertencia!","¿Desea sancionar la violación en la seriación?~nEste proceso eliminará las materias cursadas en historico que estén seriadas con su antecesor reprobado",Question!,YesNo!)

if li_confirmacion = 1 then
	li_sanciona_ser_int_mat_insc= inv_cambio_nota.of_sanciona_ser_int_historico(il_cuenta)
	if li_sanciona_ser_int_mat_insc= -1 then
		MessageBox("Error","No se sancionaron las materias correctamente",StopSign!)
	else 
		MessageBox("Información","Se sancionaron las materias correctamente",Information!)
	end if
else
	MessageBox("Información","NO se sancionaron las materias",Information!)
end if

ll_rows_historico = dw_materias_ligadas_historico.retrieve(il_cuenta)
ll_rows_archivo = dw_aviso_archivo_intercambio.retrieve(il_cuenta)
end event

type cb_sancion_inscritas from commandbutton within w_cambio_nota_seriacion_perm
integer x = 1701
integer y = 812
integer width = 914
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Sanciona Violación de Materias Inscritas"
end type

event clicked;integer li_sanciona_ser_int_mat_insc, li_confirmacion, li_confirmacion2, li_print
long ll_rows_tesoreria, ll_rows_inscritas
string ls_movimiento  = 'Baja'
li_confirmacion2= MessageBox("Aviso","¿Desea imprimir las materias que violan la seriación?",Question!,YesNo!)

if li_confirmacion2 = 1 then
	li_print= dw_aviso_tesoreria_intercambio.Print()
	if li_print = 1 then
		MessageBox("Información","Se imprimió el reporte exitosamente",Information!)		
	else		
		MessageBox("Error","NO imprimió el reporte",StopSign!)		
	end if
end if


li_confirmacion = MessageBox("¡Advertencia!","¿Desea sancionar la violación en la seriación?~nEste proceso eliminará las materias inscritas que estén seriadas con su antecesor reprobado",Question!,YesNo!)

if li_confirmacion = 1 then
	li_sanciona_ser_int_mat_insc= inv_cambio_nota.of_sanciona_ser_int_mat_insc(il_cuenta)
	if li_sanciona_ser_int_mat_insc= -1 then
		MessageBox("Error","No se sancionaron las materias correctamente",StopSign!)
	else 
		MessageBox("Información","Se sancionaron las materias correctamente",Information!)
	end if
else
	MessageBox("Información","NO se sancionaron las materias",Information!)
end if


ll_rows_inscritas = dw_materias_ligadas_inscritas.retrieve(il_cuenta)
ll_rows_tesoreria = dw_aviso_tesoreria_intercambio.retrieve(il_cuenta, ls_movimiento)
end event

type dw_materias_ligadas_historico from datawindow within w_cambio_nota_seriacion_perm
integer x = 37
integer y = 932
integer width = 3598
integer height = 750
integer taborder = 20
boolean titlebar = true
string title = "MATERIAS YA CURSADAS EN HISTORICO"
string dataobject = "d_seriacion_int_historico"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_cerrar from commandbutton within w_cambio_nota_seriacion_perm
event ue_keydown pbm_keydown
integer x = 1989
integer y = 1892
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

type dw_materias_ligadas_inscritas from datawindow within w_cambio_nota_seriacion_perm
integer x = 37
integer y = 36
integer width = 3598
integer height = 750
integer taborder = 10
boolean titlebar = true
string title = "MATERIAS INSCRITAS ACTUALES"
string dataobject = "d_seriacion_int_inscritas"
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

