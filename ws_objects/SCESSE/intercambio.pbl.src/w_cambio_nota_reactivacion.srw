$PBExportHeader$w_cambio_nota_reactivacion.srw
$PBExportComments$Cambio de nota provisional. Procesa el cambio de calificación de una materia de intercambio académico de manera temporal.
forward
global type w_cambio_nota_reactivacion from w_sheet
end type
type dw_aviso_tesoreria_intercambio from datawindow within w_cambio_nota_reactivacion
end type
type cb_reactivar from commandbutton within w_cambio_nota_reactivacion
end type
type dw_carrera_plan_intercambio from u_dw within w_cambio_nota_reactivacion
end type
type p_alumno from picture within w_cambio_nota_reactivacion
end type
type uo_cuenta from uo_nombre_alumno within w_cambio_nota_reactivacion
end type
type cb_aplicar from commandbutton within w_cambio_nota_reactivacion
end type
type cb_salir from commandbutton within w_cambio_nota_reactivacion
end type
type cb_refrescar from commandbutton within w_cambio_nota_reactivacion
end type
type dw_materias_intercambio from datawindow within w_cambio_nota_reactivacion
end type
type uo_foto from uo_foto_alumno_int within w_cambio_nota_reactivacion
end type
end forward

global type w_cambio_nota_reactivacion from w_sheet
boolean visible = false
integer width = 3739
integer height = 1848
string title = "Reactivacion por cambio de nota en Intercambio"
event ue_setitem ( )
event inicia_proceso ( )
dw_aviso_tesoreria_intercambio dw_aviso_tesoreria_intercambio
cb_reactivar cb_reactivar
dw_carrera_plan_intercambio dw_carrera_plan_intercambio
p_alumno p_alumno
uo_cuenta uo_cuenta
cb_aplicar cb_aplicar
cb_salir cb_salir
cb_refrescar cb_refrescar
dw_materias_intercambio dw_materias_intercambio
uo_foto uo_foto
end type
global w_cambio_nota_reactivacion w_cambio_nota_reactivacion

type variables
datawindowchild idwc_hijos[]
str_msgparm istr_msgparm
string is_wintitle[] = {""}
long il_cuenta_activa = 0

end variables

forward prototypes
public function boolean of_materia_aprobada (string as_calificacion)
public function boolean of_materia_reprobada (string as_calificacion)
public function integer of_modificable (ref any aa_data[])
end prototypes

event ue_setitem();//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	ue_setitem
//
//	Arguments:
//	None
//
//	Returns:
//	None
//
//	Description:
//	Toma los parámetros enviados por w_cambio_nota_1_1 y dispara el evento
//	de la datawindow ue_setitem.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
istr_msgparm = Message.PowerObjectParm

this.dw_materias_intercambio.event ue_setitem()
end event

event inicia_proceso();//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	inicia_proceso
//
//	Arguments:
//	None
//
//	Returns:
//	None
//
//	Description:
//	Toma los parámetros enviados por el objeto uo_cuenta desde activarbusq.
//	Recupera la foto del alumno desde la base de datos y carga las materias
//	de intercambio.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
integer	li_resultado
long		ll_cuenta
long		ll_row_carrera_plan_intercambio, ll_rows, ll_rows_aviso
string	ls_inifile
string	ls_nombre_photo
string ls_movimiento = 'Alta'

/*-------------------------------------------------------*/
/* Recuperación de los parámetros...							*/
/*-------------------------------------------------------*/
ll_cuenta = Message.LongParm
il_cuenta_activa = Message.LongParm

/*-------------------------------------------------------*/
/* Archivo ini donde se encuentra la información de la	*/
/* de la base de datos.												*/
/*-------------------------------------------------------*/
ls_inifile = gnv_app.of_GetAppIniFile()
li_resultado = uo_foto.of_init(ls_inifile,"Fotos")
/*-------------------------------------------------------*/
/* Conexion de la base de datos donde se almacenan las	*/
/* fotografías.														*/
/*-------------------------------------------------------*/
li_resultado = uo_foto.of_connectdb()
/*-------------------------------------------------------*/
/* Recuperamos la fotografía.										*/
/*-------------------------------------------------------*/
if li_resultado = 0 then
	uo_foto.of_loadphoto(ll_cuenta,1)
end if
/*-------------------------------------------------------*/
/* Desconexion de la base de datos donde se almacenan	las*/
/* fotografías.														*/
/*-------------------------------------------------------*/
li_resultado = uo_foto.of_disconnectdb()

/*-------------------------------------------------------*/
/* Carga de datos...													*/
/*-------------------------------------------------------*/
ll_rows = dw_materias_intercambio.retrieve(ll_cuenta)

ll_row_carrera_plan_intercambio = dw_carrera_plan_intercambio.Retrieve(ll_cuenta)
ls_nombre_photo = "photo_"+string(ll_cuenta)+".jpg"
p_alumno.picturename = ls_nombre_photo
p_alumno.width = 494
p_alumno.height = 496
FileDelete(ls_nombre_photo)

ll_rows_aviso = this.dw_aviso_tesoreria_intercambio.retrieve(ll_cuenta,ls_movimiento)


end event

public function boolean of_materia_aprobada (string as_calificacion);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_materia_aprobada
//
//	Access:  public
//
//	Arguments:
//	as_calificacion		La calificación de una materia.
//
//	Returns:
//	Boolean
//
//	Description:
//	Guarda en un arreglo las calificaciones que son aprobatorias y hace
//	una comparación con el argumento para determinar si éste esta en el
//	arreglo.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
/*-------------------------------------------------------*/
/* Lista de calificaciones que se consideran aprobatorias*/
/*-------------------------------------------------------*/
string ls_materia_aprobada[] = {"6","7","8","9","10","AC"}
boolean lb_aprobada
integer li_min, li_max, li_i

/*-------------------------------------------------------*/
/* Checamos que la calificación se encuentre en la lista	*/
/* de calificaciones aprobatorias.								*/
/*-------------------------------------------------------*/
lb_aprobada = false

li_min = lowerbound(ls_materia_aprobada)
li_max = upperbound(ls_materia_aprobada)

for li_i = li_min to li_max
	if ls_materia_aprobada[li_i] = as_calificacion then
		lb_aprobada = true
		exit
	end if
next

/*-------------------------------------------------------*/
return lb_aprobada

end function

public function boolean of_materia_reprobada (string as_calificacion);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_materia_reprobada
//
//	Access:  public
//
//	Arguments:
//	as_calificacion		La calificación de una materia.
//
//	Returns:
//	Boolean
//
//	Description:
//	Guarda en un arreglo las calificaciones que son reprobatorias y hace
//	una comparación con el argumento para determinar si éste esta en el
//	arreglo.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
/*-------------------------------------------------------*/
/*Lista de calificaciones que se consideran reprobatorias*/
/*-------------------------------------------------------*/
string ls_materia_reprobada[] = {"5","NA"}
boolean lb_reprobada
integer li_min, li_max, li_i

/*-------------------------------------------------------*/
/* Checamos que la calificación se encuentre en la lista	*/
/* de calificaciones reprobatorias.								*/
/*-------------------------------------------------------*/
lb_reprobada = false

li_min = lowerbound(ls_materia_reprobada)
li_max = upperbound(ls_materia_reprobada)

for li_i = li_min to li_max
	if ls_materia_reprobada[li_i] = as_calificacion then
		lb_reprobada = true
		exit
	end if
next

/*-------------------------------------------------------*/
return lb_reprobada


end function

public function integer of_modificable (ref any aa_data[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_modificable
//
//	Access:  public
//
//	Arguments:
//	aa_data		Un arreglo.
//
//	Returns:
//	Integer
//
//	Description:
//	Recibe un arreglo (vea dw_materias_intercambio en el evento retrieveend)
//	y realiza una evaluación para determinar si una materia es candidata para
//	modificar su calificación.
// Los índices que se evaluan son el 8 (calificación) y el 11 (tabla).
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
any la_tabla[]
any la_valores[]
integer li_opcion
string ls_titulo
string ls_mensaje


la_valores[1] = aa_data[11] = "historico_intercambio"
la_valores[2] = this.of_materia_aprobada(aa_data[8])
la_valores[3] = this.of_materia_reprobada(aa_data[8])

la_tabla = f_tabla_verdad(upperbound(la_valores))
li_opcion = f_tabla_verdad_test(la_tabla,la_valores)

CHOOSE CASE li_opcion
	CASE 2 //materia aprobada
		return 0
	CASE 3 //materia reprobada
		return 1
	CASE 4 //materia con calificación indefinida
		if len(string(aa_data[8])) > 0 then
			ls_titulo = "Aviso"
			ls_mensaje = "La calificación " + aa_data[8] + " no es válida para este proceso"
			MessageBox(ls_titulo, ls_mensaje,Information!)
		end if
		return 0
	CASE ELSE //ignorar los resultados
		return 0
END CHOOSE

end function

on w_cambio_nota_reactivacion.create
int iCurrent
call super::create
this.dw_aviso_tesoreria_intercambio=create dw_aviso_tesoreria_intercambio
this.cb_reactivar=create cb_reactivar
this.dw_carrera_plan_intercambio=create dw_carrera_plan_intercambio
this.p_alumno=create p_alumno
this.uo_cuenta=create uo_cuenta
this.cb_aplicar=create cb_aplicar
this.cb_salir=create cb_salir
this.cb_refrescar=create cb_refrescar
this.dw_materias_intercambio=create dw_materias_intercambio
this.uo_foto=create uo_foto
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_aviso_tesoreria_intercambio
this.Control[iCurrent+2]=this.cb_reactivar
this.Control[iCurrent+3]=this.dw_carrera_plan_intercambio
this.Control[iCurrent+4]=this.p_alumno
this.Control[iCurrent+5]=this.uo_cuenta
this.Control[iCurrent+6]=this.cb_aplicar
this.Control[iCurrent+7]=this.cb_salir
this.Control[iCurrent+8]=this.cb_refrescar
this.Control[iCurrent+9]=this.dw_materias_intercambio
this.Control[iCurrent+10]=this.uo_foto
end on

on w_cambio_nota_reactivacion.destroy
call super::destroy
destroy(this.dw_aviso_tesoreria_intercambio)
destroy(this.cb_reactivar)
destroy(this.dw_carrera_plan_intercambio)
destroy(this.p_alumno)
destroy(this.uo_cuenta)
destroy(this.cb_aplicar)
destroy(this.cb_salir)
destroy(this.cb_refrescar)
destroy(this.dw_materias_intercambio)
destroy(this.uo_foto)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////////////
//
//	Object Name:  w_cambio_nota_1
//
//	Description:
//	Ventana maestra para realizar los cambios de nota de manera temporal y
// solamente afecta a la tabla historico_intercambio.
//	Interfase.
//	1.- Consta de objeto de usuario (uo_cuenta) para validar la cuenta y
//	el dígito verificador. Este objeto es descendiente de uo_nombre_alumno.
//	2.- Costa de un objeto de usuario (uo_foto) para mostrar la fotografía
//	de un alumno. Este objeto es descendiente de uo_foto_alumno_int.
//	3.- Consta de una datawindow (dw_materias_intercambio) que lista todas
//	las materias de intercambio registradas para una cuenta en las tablas
//	mat_inscritas, historico e historico_intercambio.
//	4.- Consta de botones para refrescar los datos, para aplicar los cambios
//	y para salir de la aplicación.
//	Operación.
//	Cuando se ha ingresado una cuenta el objeto uo_cuenta lo valida. Si la
//	cuenta y su dígito verificador son correctos, entonces muestra el nom-
//	bre y la fotografía del alumno, enseguida hace la carga de las materias
//	de intercambio que el alumno ha cursado o está cursando. Si la cuenta o
//	su dígito verificador son incorrectos envía un mensaje de error y detiene
//	el proceso en espera de una nueva cuenta.
//	Con una cuenta válida, sobre la datawindow, se hace doble clic y si la
//	casilla modificable esta palomeada, entonces se abre la ventana auxiliar
//	para realizar el cambio de nota (vea w_cambio_nota_1_1).
//	Una vez hecha la modificación se activa la opción "procesar" en la
//	datawindow.
//	Al presionar el botón aplicar se vacían los cambios en la base de datos.
//	Vea (n_cst_cambio_nota) donde se encuentra el proceso almacenado llamado
//	sp_cambio_nota_provisional que es quien realiza la modificación.
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
//	Pone el foco sobre el objeto de usuario uo_cuenta. 
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
integer li_resultado
long ll_trans_object_3


/*-------------------------------------------------------*/
/* Este teclazo (tab) es necesario para poner el foco		*/
/* sobre la columna "cuenta".										*/
/*-------------------------------------------------------*/
keybd_event(9, 0, 0, 0 )
keybd_event(9, 0, 2, 0 )
/*-------------------------------------------------------*/

x=1
y=1

ll_trans_object_3 = this.dw_aviso_tesoreria_intercambio.settransobject(gtr_sce)



end event

type dw_aviso_tesoreria_intercambio from datawindow within w_cambio_nota_reactivacion
integer x = 1285
integer y = 1744
integer width = 1591
integer height = 84
integer taborder = 70
string title = "none"
string dataobject = "d_aviso_tesoreria_interc_perm_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_reactivar from commandbutton within w_cambio_nota_reactivacion
event ue_keydown pbm_keydown
integer x = 2601
integer y = 1616
integer width = 635
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Reactivar Seleccionadas"
end type

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
//	Realiza el procesamiento para el cambio de nota. Utiliza el objeto de
//	transacción n_cst_cambio_nota donde esta encapsulado el procedimiento
//	almacenado sp_cambio_nota_provisional (vea la sección Local External
//	Function en el objeto)
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
integer li_resultado, li_confirmacion
n_cst_cambio_nota lnv_cambio_nota
any la_data[]
integer li_procesados
long ll_renglon, ll_renglones, ll_rows_aviso
string ls_titulo, ls_mensaje, ls_calificacion, ls_calificacion_intercambio, ls_materia
pointer oldpointer
long ll_periodo, ll_anio, ll_cuenta, ll_cve_mat, ll_cve_motivo
boolean lb_seriada_inscrita, lb_seriada_cursada, lb_hubo_seriada_inscrita, lb_hubo_seriada_cursada
integer li_reactivar, li_reactiva_mat_intercambio
oldpointer = SetPointer(HourGlass!)
boolean lb_inscrita_reactivada
string ls_movimiento = 'Alta'
boolean ab_seriada_inscrita=false, ab_seriada_cursada =false
integer li_valida_seriacion_intercambio
/*-------------------------------------------------------*/
/* Procesamos las materias...										*/
/*-------------------------------------------------------*/

lnv_cambio_nota = Create using "n_cst_cambio_nota"

ll_renglones = parent.dw_materias_intercambio.rowcount()

li_procesados = 0

li_confirmacion = MessageBox("Confirmación", "¿Desea reactivar las materias seleccionadas?", Question!, YesNo!)
if li_confirmacion<> 1 then	
	return
end if

for ll_renglon = 1 to ll_renglones
	ll_cuenta =  dw_materias_intercambio.GetItemNumber(ll_renglon, "cuenta")
	li_reactivar =  dw_materias_intercambio.GetItemNumber(ll_renglon, "reactivar")
	ll_cve_mat =  dw_materias_intercambio.GetItemNumber(ll_renglon, "cve_mat")
	ll_cve_motivo=  dw_materias_intercambio.GetItemNumber(ll_renglon, "cve_motivo")
	if ll_cve_motivo = 1 then
		lb_inscrita_reactivada= true
	end if
	
	
	if li_reactivar = 1 then
		
		li_valida_seriacion_intercambio = lnv_cambio_nota.of_valida_seriacion_intercambio(ll_cuenta, ll_cve_mat, ab_seriada_inscrita, ab_seriada_cursada)
		li_reactiva_mat_intercambio =	lnv_cambio_nota.of_reactiva_mat_intercambio(ll_cuenta, ll_cve_mat, ll_cve_motivo)
		if li_reactiva_mat_intercambio= -1 then
			MessageBox("Error en reactivacion", "No es posible reactivar la materia ["+string(ll_cve_mat)+"]",StopSign!)
			return
		end if
		li_procesados++
	end if	
next

ll_rows_aviso = dw_aviso_tesoreria_intercambio.retrieve(ll_cuenta,ls_movimiento)
if lb_inscrita_reactivada then
	dw_aviso_tesoreria_intercambio.Print()
end if


ls_titulo = "Información"
ls_mensaje = "Se reactivaron: " + string(li_procesados) + " registros"
MessageBox(ls_titulo, ls_mensaje,Information!)

SetPointer(oldpointer)


end event

type dw_carrera_plan_intercambio from u_dw within w_cambio_nota_reactivacion
integer x = 553
integer y = 436
integer width = 3241
integer height = 112
integer taborder = 40
string dataobject = "d_carrera_plan_intercambio"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.SetTransObject(gtr_sce)
end event

type p_alumno from picture within w_cambio_nota_reactivacion
integer x = 41
integer y = 36
integer width = 480
integer height = 484
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type uo_cuenta from uo_nombre_alumno within w_cambio_nota_reactivacion
integer x = 553
integer y = 12
integer width = 3241
integer height = 424
integer taborder = 20
boolean enabled = true
end type

on uo_cuenta.destroy
call uo_nombre_alumno::destroy
end on

type cb_aplicar from commandbutton within w_cambio_nota_reactivacion
event ue_keydown pbm_keydown
boolean visible = false
integer x = 4690
integer y = 2120
integer width = 343
integer height = 92
integer taborder = 50
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
//	Realiza el procesamiento para el cambio de nota. Utiliza el objeto de
//	transacción n_cst_cambio_nota donde esta encapsulado el procedimiento
//	almacenado sp_cambio_nota_provisional (vea la sección Local External
//	Function en el objeto)
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
integer li_resultado
n_cst_cambio_nota lnv_cambio_nota
any la_data[]
integer li_procesados
long ll_renglon, ll_renglones
string ls_titulo, ls_mensaje, ls_calificacion, ls_materia
pointer oldpointer
long ll_periodo, ll_anio, ll_cuenta, ll_cve_mat
boolean lb_seriada_inscrita, lb_seriada_cursada, lb_hubo_seriada_inscrita, lb_hubo_seriada_cursada

oldpointer = SetPointer(HourGlass!)

/*-------------------------------------------------------*/
/* Conexion con la base de datos donde se almacenan los	*/
/* stored procedures.												*/
/*-------------------------------------------------------*/
lnv_cambio_nota = Create using "n_cst_cambio_nota"
//li_resultado = lnv_cambio_nota.of_connectdb()

/*-------------------------------------------------------*/
/* Procesamos las materias...										*/
/*-------------------------------------------------------*/
ll_renglones = parent.dw_materias_intercambio.rowcount()

li_procesados = 0

for ll_renglon = 1 to ll_renglones
	la_data = parent.dw_materias_intercambio.object.data[ll_renglon]
	ll_cuenta =  dw_materias_intercambio.GetItemNumber(ll_renglon, "cuenta")
	ll_cve_mat =  dw_materias_intercambio.GetItemNumber(ll_renglon, "cve_mat")
	ls_calificacion =  dw_materias_intercambio.GetItemString(ll_renglon, "calificacion")
	ls_materia =  dw_materias_intercambio.GetItemString(ll_renglon, "materia")	
	
	ll_periodo =  dw_materias_intercambio.GetItemNumber(ll_renglon, "periodo")
	ll_anio =  dw_materias_intercambio.GetItemNumber(ll_renglon, "anio")
//	if la_data[9] = 1 and la_data[10] = 1 then
	if trim(ls_calificacion) = "5" then
		lb_seriada_inscrita = false
		lb_seriada_cursada = false
		lnv_cambio_nota.of_valida_seriacion_intercambio(ll_cuenta, ll_cve_mat, lb_seriada_inscrita, lb_seriada_cursada)

		if lb_seriada_inscrita then
			lb_hubo_seriada_inscrita = true
		end if
		
		if lb_seriada_cursada then
			lb_hubo_seriada_cursada = true
		end if
	
	end if
	
	li_resultado = lnv_cambio_nota.of_cambio_nota_provisional(ll_cuenta,ll_cve_mat,ls_calificacion,ll_periodo,ll_anio)
	if li_resultado = 0 then
		li_procesados++
		dw_materias_intercambio.SetItem(ll_renglon, "seriacion_revisada", 1)
		if lb_seriada_inscrita or lb_seriada_cursada then
			dw_materias_intercambio.SetItem(ll_renglon, "seriacion_violada", 1)				
		end if
	else
		ls_titulo = "Error: " + ls_materia
		ls_mensaje = "No se pudo asentar la calificación en la base de datos"
		MessageBox(ls_titulo, ls_mensaje,stopsign!)
	end if

next

ls_titulo = "Información"
ls_mensaje = "Se procesaron: " + string(li_procesados) + " registros"
MessageBox(ls_titulo, ls_mensaje,Information!)


if lb_hubo_seriada_inscrita then
	ls_titulo = "Error ["+ string(ll_cve_mat) +"]" + ls_materia
	ls_mensaje = "Tiene materias seriadas hacia adelante inscritas"
	MessageBox(ls_titulo, ls_mensaje,stopsign!)
end if
		
if lb_hubo_seriada_cursada then
	ls_titulo = "Error ["+ string(ll_cve_mat) +"]" + ls_materia
	ls_mensaje = "Tiene materias seriadas hacia adelante cursadas"
	MessageBox(ls_titulo, ls_mensaje,stopsign!)
end if

if lb_hubo_seriada_inscrita or lb_hubo_seriada_cursada then
	la_data[1] = il_cuenta_activa
	istr_msgparm.data = la_data
	openwithparm (w_cambio_nota_seriacion,istr_msgparm)
end if

		

/*-------------------------------------------------------*/
/* Desconexion de la base de datos.								*/
/*-------------------------------------------------------*/
//li_resultado = lnv_cambio_nota.of_disconnectdb()

/*-------------------------------------------------------*/
SetPointer(oldpointer)


end event

type cb_salir from commandbutton within w_cambio_nota_reactivacion
event ue_keydown pbm_keydown
integer x = 3291
integer y = 1616
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Salir"
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
//	Cierra la ventana. Antes verifica que no haya ventanas auxiliares abiertas,
//	si las hay, las cierra. Utiliza la API FindWindowA (vea la sección Global
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
//ulong  lul_winhandle
//
//lul_winhandle = FindWindowA(0,is_wintitle[1])
//
//If lul_winhandle > 0 Then
//	close (w_cambio_nota_1_1)
//end If

close (parent)
end event

type cb_refrescar from commandbutton within w_cambio_nota_reactivacion
event ue_keydown pbm_keydown
integer x = 2222
integer y = 1616
integer width = 347
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Refrescar..."
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
//	Refresca la datawindow con una nueva lectura a la base de datos.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
/*-------------------------------------------------------*/
/* Carga de datos...													*/
/*-------------------------------------------------------*/
parent.dw_materias_intercambio.retrieve(il_cuenta_activa)

end event

type dw_materias_intercambio from datawindow within w_cambio_nota_reactivacion
event ue_setitem ( )
integer x = 41
integer y = 592
integer width = 3598
integer height = 964
integer taborder = 30
string title = "none"
string dataobject = "d_reactivacion_cambio_nota_int"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_setitem();//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	ue_setitem
//
//	Arguments:
//	None
//
//	Returns:
//	None
//
//	Description:
//	Toma los valores pasados por la ventana w_cambio_nota_1_1 a través de
//	la estructura str_msgparm ([8] = calificación) y los asienta en la
//	datawindow. El índice 10 esta relacionado al campo "procesar".
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
long ll_rowid
string ls_item

ll_rowid = istr_msgparm.data[upperbound(istr_msgparm.data)]
ls_item = istr_msgparm.data[8]

this.setitem(ll_rowid, 8, ls_item)
this.setitem(ll_rowid, 10, 1)
end event

event constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	constructor
//
//	Arguments:
//	None
//
//	Returns:
//	Long
//
//	Description:
//	Establece el objeto de transacción para la datawindow y protege el campo
//	"modificable".
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
this.settransobject(gtr_sce)

//this.object.#9.protect ="1"
end event

event retrieveend;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	retrieveend
//
//	Arguments:
//	rowcount		Vea la documentación de PB.
//
//	Returns:
//	Long
//
//	Description:
//	Recorre la datawindow para marcar el campo modificable según el valor de
//	la función of_modificable.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//integer li_modificable
//long ll_rowid
//any la_data[]
//
//for ll_rowid = 1 to this.rowcount()
//	la_data = this.object.data[ll_rowid]
//	li_modificable = parent.of_modificable(la_data)
//	this.setitem(ll_rowid,9,li_modificable)
//next
//
this.scrolltorow(0)
end event

event doubleclicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	doubleclicked
//
//	Arguments:
//	xpos			Vea la documentación de PB.
//	ypos			Vea la documentación de PB.
//	row			Vea la documentación de PB.
//	dwo			Vea la documentación de PB.
//
//	Returns:
//	Long
//
//	Description:
//	Toma los datos del renglón, siempre y cuando el campo "modificable" este
//	palomeado, los convierte en un arreglo y los envía como parámetro a través
//	de la estructura str_msgparm hacia la ventana w_cambio_nota_1_1 (vea el
//	evento open de la misma).
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//any la_data[]
//
//if row > 0 then
//	if this.object.#9[row] = 1 then
//		la_data = this.object.data[row]
//		istr_msgparm.data = la_data
//		istr_msgparm.data[upperbound(istr_msgparm.data) + 1] = row
//		is_wintitle[1] = la_data[3]
//		openwithparm (w_cambio_nota_1_1,istr_msgparm)
//	end if
//end if
//
end event

type uo_foto from uo_foto_alumno_int within w_cambio_nota_reactivacion
integer x = 41
integer y = 36
integer taborder = 10
end type

on uo_foto.destroy
call uo_foto_alumno_int::destroy
end on

