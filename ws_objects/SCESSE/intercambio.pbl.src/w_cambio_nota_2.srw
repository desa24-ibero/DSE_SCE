$PBExportHeader$w_cambio_nota_2.srw
$PBExportComments$Cambio de nota definitiva. Procesa el cambio de calificación de una materia de intercambio académico de manera definitiva.
forward
global type w_cambio_nota_2 from w_sheet
end type
type dw_carrera_plan_intercambio from u_dw within w_cambio_nota_2
end type
type p_alumno from picture within w_cambio_nota_2
end type
type cb_ver_materias_ligadas from commandbutton within w_cambio_nota_2
end type
type uo_cuenta from uo_nombre_alumno within w_cambio_nota_2
end type
type cb_aplicar from commandbutton within w_cambio_nota_2
end type
type cb_salir from commandbutton within w_cambio_nota_2
end type
type cb_refrescar from commandbutton within w_cambio_nota_2
end type
type dw_materias_intercambio from datawindow within w_cambio_nota_2
end type
type uo_foto from uo_foto_alumno_int within w_cambio_nota_2
end type
end forward

global type w_cambio_nota_2 from w_sheet
integer width = 4000
integer height = 2356
string title = "Cambio de nota definitiva"
event ue_setitem ( )
event inicia_proceso ( )
dw_carrera_plan_intercambio dw_carrera_plan_intercambio
p_alumno p_alumno
cb_ver_materias_ligadas cb_ver_materias_ligadas
uo_cuenta uo_cuenta
cb_aplicar cb_aplicar
cb_salir cb_salir
cb_refrescar cb_refrescar
dw_materias_intercambio dw_materias_intercambio
uo_foto uo_foto
end type
global w_cambio_nota_2 w_cambio_nota_2

type variables
datawindowchild idwc_hijos[]
str_msgparm istr_msgparm
string is_wintitle[] = {"","Materias ligadas...","Resultado"}
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
//	Toma los parámetros enviados por w_cambio_nota_2_1 y dispara el evento
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
long		ll_row_carrera_plan_intercambio
string	ls_inifile
string	ls_nombre_photo

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
li_resultado = uo_foto.of_init(ls_inifile,gs_fotos)
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
this.dw_materias_intercambio.retrieve(ll_cuenta,"%","%")
ll_row_carrera_plan_intercambio = dw_carrera_plan_intercambio.Retrieve(ll_cuenta)
ls_nombre_photo = "photo_"+string(ll_cuenta)+".jpg"
p_alumno.picturename = ls_nombre_photo
p_alumno.width = 494
p_alumno.height = 496
//*******DESCOMENTAR LA LINEA PARA BORRAR LA FOTO
FileDelete(ls_nombre_photo)

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
//	Function:  of_materia_aprobada
//
//	Access:  public
//
//	Arguments:
//	aa_data		Un arreglo.
//
//	Returns:
//	Boolean
//
//	Description:
//	Recibe un arreglo (vea dw_materias_intercambio en el evento retrieveend)
//	y realiza una evaluación para determinar si una materia es candidata para
//	modificar su calificación.
// El índices que se evalua es el 11 (tabla).
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
if aa_data[11] = "historico_intercambio" then
	return 1
else
	return 0
end if

end function

on w_cambio_nota_2.create
int iCurrent
call super::create
this.dw_carrera_plan_intercambio=create dw_carrera_plan_intercambio
this.p_alumno=create p_alumno
this.cb_ver_materias_ligadas=create cb_ver_materias_ligadas
this.uo_cuenta=create uo_cuenta
this.cb_aplicar=create cb_aplicar
this.cb_salir=create cb_salir
this.cb_refrescar=create cb_refrescar
this.dw_materias_intercambio=create dw_materias_intercambio
this.uo_foto=create uo_foto
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_carrera_plan_intercambio
this.Control[iCurrent+2]=this.p_alumno
this.Control[iCurrent+3]=this.cb_ver_materias_ligadas
this.Control[iCurrent+4]=this.uo_cuenta
this.Control[iCurrent+5]=this.cb_aplicar
this.Control[iCurrent+6]=this.cb_salir
this.Control[iCurrent+7]=this.cb_refrescar
this.Control[iCurrent+8]=this.dw_materias_intercambio
this.Control[iCurrent+9]=this.uo_foto
end on

on w_cambio_nota_2.destroy
call super::destroy
destroy(this.dw_carrera_plan_intercambio)
destroy(this.p_alumno)
destroy(this.cb_ver_materias_ligadas)
destroy(this.uo_cuenta)
destroy(this.cb_aplicar)
destroy(this.cb_salir)
destroy(this.cb_refrescar)
destroy(this.dw_materias_intercambio)
destroy(this.uo_foto)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////////////
//
//	Object Name:  w_cambio_nota_2
//
//	Description:
//	Ventana maestra para realizar los cambios de nota de manera definitiva
//	y afecta a las tabla mat_inscritas, historico e historico_intercambio.
//	Interfase.
//	1.- Consta de objeto de usuario (uo_cuenta) para validar la cuenta y
//	el dígito verificador. Este objeto es descendiente de uo_nombre_alumno.
//	2.- Costa de un objeto de usuario (uo_foto) para mostrar la fotografía
//	de un alumno. Este objeto es descendiente de uo_foto_alumno_int.
//	3.- Consta de una datawindow (dw_materias_intercambio) que lista todas
//	las materias de intercambio registradas para una cuenta en las tablas
//	mat_inscritas, historico e historico_intercambio.
//	4.- Consta de botones para refrescar los datos, para ver la materias que
//	están ligadas, para aplicar los cambios y para salir de la aplicación.
//	Operación.
//	Cuando se ha ingresado una cuenta el objeto uo_cuenta lo valida. Si la
//	cuenta y su dígito verificador son correctos, entonces muestra el nom-
//	bre y la fotografía del alumno, enseguida hace la carga de las materias
//	de intercambio que el alumno ha cursado o está cursando. Si la cuenta o
//	su dígito verificador son incorrectos envía un mensaje de error y detiene
//	el proceso en espera de una nueva cuenta.
//	Con una cuenta válida, sobre la datawindow, se hace doble clic y si la
//	casilla modificable esta palomeada, entonces se abre la ventana auxiliar
//	para realizar el cambio de nota (vea w_cambio_nota_2_1).
//	Una vez hecha la modificación se activa la opción "procesar" en la
//	datawindow.
//	Al presionar el botón aplicar se vacían los cambios en la base de datos.
//	Vea (n_cst_cambio_nota) donde se encuentra el proceso almacenado llamado
//	sp_cambio_nota_definitiva que es quien realiza la modificación.
//	Al final del proceso recibirá una pantalla informativa (vea w_cambio_nota_2_3)
//	Es recomendable que antes de antes de procesar eche un vistazo a la pantalla
//	de materias ligadas (vea w_cambio_nota_2_2) para tener una idea de las
//	materias que podrían ser afectadas por los cambios.
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

/*-------------------------------------------------------*/
/* Este teclazo (tab) es necesario para poner el foco		*/
/* sobre la columna "cuenta".										*/
/*-------------------------------------------------------*/
keybd_event(9, 0, 0, 0 )
keybd_event(9, 0, 2, 0 )
/*-------------------------------------------------------*/


end event

type dw_carrera_plan_intercambio from u_dw within w_cambio_nota_2
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

type p_alumno from picture within w_cambio_nota_2
integer x = 41
integer y = 36
integer width = 480
integer height = 484
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_ver_materias_ligadas from commandbutton within w_cambio_nota_2
event ue_keydown pbm_keydown
integer x = 2510
integer y = 2120
integer width = 544
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Ver materias ligadas..."
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
//	Toma el número de cuenta activo y lo envía como parámetro a través de
//	la estructura str_msgparm hacia la ventana w_cambio_nota_2_2 (vea el
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
any la_data[]

la_data[1] = il_cuenta_activa
istr_msgparm.data = la_data
openwithparm (w_cambio_nota_2_2,istr_msgparm)

end event

type uo_cuenta from uo_nombre_alumno within w_cambio_nota_2
integer x = 553
integer y = 16
integer taborder = 20
boolean enabled = true
end type

on uo_cuenta.destroy
call uo_nombre_alumno::destroy
end on

type cb_aplicar from commandbutton within w_cambio_nota_2
event ue_keydown pbm_keydown
integer x = 3077
integer y = 2120
integer width = 343
integer height = 92
integer taborder = 60
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
//	almacenado sp_cambio_nota_definitiva (vea la sección Local External
//	Function en el objeto). También se genera un reporte del proceso que
//	se muestra desde la ventana auxiliar w_cambio_nota_2_3. El objeto
//	d_parent_child2 recupera los datos desde el procedimiento almacenado
// sp_cambio_nota_relaciones2.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
n_cst_cambio_nota lnv_cambio_nota
datastore lds_materias_ligadas
datastore lds_materias_resultado
any la_data_parent[]
any la_data_child[]
any la_data[]
long ll_resultado
long ll_i, ll_i_min, ll_i_max
long ll_j, ll_j_min, ll_j_max
long ll_k, ll_k_min, ll_k_max
long ll_l, ll_l_min, ll_l_max
long ll_m, ll_m_min, ll_m_max
string ls_titulo, ls_mensaje
string ls_filtro
pointer oldpointer

oldpointer = SetPointer(HourGlass!)

/*----------------------------------------------------------------------*/
/* Conexion con la base de datos donde se almacenan los						*/
/* stored procedures.																	*/
/*----------------------------------------------------------------------*/
lnv_cambio_nota = Create using "n_cst_cambio_nota"
ll_resultado = lnv_cambio_nota.of_connectdb()
/*----------------------------------------------------------------------*/
/* Usamos un datastore para alamcenar el resultado.							*/
/*----------------------------------------------------------------------*/
lds_materias_resultado = create datastore
lds_materias_resultado.dataobject = "ddw_materias_resultado"
lds_materias_resultado.settransobject(gtr_sce)
/*----------------------------------------------------------------------*/
/* Procesamos las materias...															*/
/*----------------------------------------------------------------------*/
ll_i_min = 1
ll_i_max = parent.dw_materias_intercambio.rowcount()

for ll_i = ll_i_min to ll_i_max
	la_data_parent = parent.dw_materias_intercambio.object.data[ll_i]
	if la_data_parent[9] = 1 and la_data_parent[10] = 1 then
/*----------------------------------------------------------------------*/
/* Usamos un datastore para buscar las materias dependientes.				*/
/*----------------------------------------------------------------------*/
		lds_materias_ligadas = create datastore
		lds_materias_ligadas.dataobject = "d_parent_child2"
		lds_materias_ligadas.settransobject(gtr_sce)
		ll_resultado = lds_materias_ligadas.retrieve(la_data_parent[1],la_data_parent[2],"%","%")
/*----------------------------------------------------------------------*/
/* Ojo. El datastore esta previamente filtrado con: not isNull(cuenta2)	*/
/* Vea el datawindow d_parent_child2.												*/
/*----------------------------------------------------------------------*/
		ll_j_min = 1
		ll_j_max = lds_materias_ligadas.rowcount()
			
		if ll_j_max = 0 then
/*----------------------------------------------------------------------*/
/* No hay materias dependientes.														*/
/*----------------------------------------------------------------------*/
			la_data[1] = la_data_parent[1]
			la_data[2] = la_data_parent[2]
			la_data[3] = la_data_parent[2]
			la_data[4] = la_data_parent[3]
			la_data[5] = la_data_parent[4]
			la_data[6] = la_data_parent[5]
			la_data[7] = la_data_parent[6]
			la_data[8] = la_data_parent[7]
			la_data[9] = la_data_parent[8]
			la_data[10] = "Ninguno"
			la_data[11] = 1
			ll_k = lds_materias_resultado.insertrow(0)
			lds_materias_resultado.object.data[ll_k] = la_data
		else
/*----------------------------------------------------------------------*/
/* Hay materias dependientes.															*/
/*----------------------------------------------------------------------*/
			la_data[1] = la_data_parent[1]
			la_data[2] = la_data_parent[2]
			la_data[3] = la_data_parent[2]
			la_data[4] = la_data_parent[3]
			la_data[5] = la_data_parent[4]
			la_data[6] = la_data_parent[5]
			la_data[7] = la_data_parent[6]
			la_data[8] = la_data_parent[7]
			la_data[9] = la_data_parent[8]
			la_data[10] = "Ninguno"
			la_data[11] = 1
			ll_k = lds_materias_resultado.insertrow(0)
			lds_materias_resultado.object.data[ll_k] = la_data

			if parent.of_materia_reprobada(la_data_parent[8]) then
				for ll_j = ll_j_min to ll_j_max
					la_data_child = lds_materias_ligadas.object.data[ll_j]
					la_data[1] = la_data_parent[1]
					la_data[2] = la_data_parent[2]
					la_data[3] = la_data_child[13]
					la_data[4] = la_data_child[14]
					la_data[5] = la_data_child[15]
					la_data[6] = la_data_child[16]
					la_data[7] = la_data_child[17]
					la_data[8] = la_data_child[18]
					la_data[9] = la_data_child[19]
					la_data[10] = "No se aprobó el prerrequisito"
					la_data[11] = 1
					ll_k = lds_materias_resultado.insertrow(0)
					lds_materias_resultado.object.data[ll_k] = la_data
				next
			end if
		end if
/*----------------------------------------------------------------------*/
/* Se elimina el datastore.															*/
/*----------------------------------------------------------------------*/
		destroy lds_materias_ligadas
/*----------------------------------------------------------------------*/
/* Ejecutamos el procedimiento almacenado.										*/
/* Este proceso elimina el registro de la materia padre (parent) y los	*/
/* registros de la materias dependientes (children).							*/
/* El procesamiento de la información en este módulo sólo requiere la	*/
/* ejecución de este stored procedure. El resto del código se escribió	*/
/* para poder generar un reporte del estado del proceso.						*/
/*----------------------------------------------------------------------*/
//*AQUI		ll_resultado = lnv_cambio_nota.sp_cambio_nota_definitiva(la_data_parent[1],la_data_parent[2],la_data_parent[8])
		if ll_resultado = 0 then
/*----------------------------------------------------------------------*/
/* Se actualiza el status.																*/
/*----------------------------------------------------------------------*/				
			ls_filtro = "cuenta = " + string(la_data_parent[1]) + " and " + "parent = " + string(la_data_parent[2])
			lds_materias_resultado.setfilter(ls_filtro)
			lds_materias_resultado.filter()
			
			ll_l_min = 1
			ll_l_max = lds_materias_resultado.rowcount()
			
			for ll_l = ll_l_min to ll_l_max
				lds_materias_resultado.setitem(ll_l, 11, 0)
			next
							
			ls_filtro = ""
			lds_materias_resultado.setfilter(ls_filtro)
			lds_materias_resultado.filter()

			parent.dw_materias_intercambio.setitem(ll_i, 10, 0)
		else
			ls_titulo = "Error: " + la_data_parent[3]
			ls_mensaje = "No se pudo asentar la calificación en la base de datos"
			MessageBox(ls_titulo, ls_mensaje,stopsign!)
		end if
	end if
next
/*----------------------------------------------------------------------*/
/* Se envía un mensaje indicando el estado del proceso.						*/
/*----------------------------------------------------------------------*/
openwithparm(w_cambio_nota_2_3,lds_materias_resultado)

ll_m_max = lds_materias_resultado.rowcount()

ls_titulo = "Información"
ls_mensaje = "Se procesaron: " + string(ll_m_max) + " registros"
MessageBox(ls_titulo, ls_mensaje,Information!)
/*----------------------------------------------------------------------*/
/* Se elimina el datastore.															*/
/*----------------------------------------------------------------------*/
//destroy lds_materias_resultado
/*----------------------------------------------------------------------*/
/* Desconexion de la base de datos.													*/
/*----------------------------------------------------------------------*/
ll_resultado = lnv_cambio_nota.of_disconnectdb()

/*----------------------------------------------------------------------*/
SetPointer(oldpointer)

end event

type cb_salir from commandbutton within w_cambio_nota_2
event ue_keydown pbm_keydown
integer x = 3442
integer y = 2120
integer width = 343
integer height = 92
integer taborder = 70
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
ulong  lul_winhandle

lul_winhandle = FindWindowA(0,is_wintitle[1])

If lul_winhandle > 0 Then
	close (w_cambio_nota_2_1)
end If

lul_winhandle = FindWindowA(0,is_wintitle[2])

If lul_winhandle > 0 Then
	close (w_cambio_nota_2_2)
end If

lul_winhandle = FindWindowA(0,is_wintitle[3])

If lul_winhandle > 0 Then
	close (w_cambio_nota_2_3)
end If

close (parent)
end event

type cb_refrescar from commandbutton within w_cambio_nota_2
event ue_keydown pbm_keydown
integer x = 2139
integer y = 2120
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
parent.dw_materias_intercambio.retrieve(il_cuenta_activa,"%","%")

end event

type dw_materias_intercambio from datawindow within w_cambio_nota_2
event ue_setitem ( )
integer x = 41
integer y = 580
integer width = 3749
integer height = 1504
integer taborder = 30
string title = "none"
string dataobject = "ddw_materias_intercambio"
boolean hscrollbar = true
boolean vscrollbar = true
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
//	Toma los valores pasados por la ventana w_cambio_nota_2_1 a través de
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

this.object.#9.protect ="1"
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
integer li_modificable
long ll_rowid
any la_data[]

for ll_rowid = 1 to rowcount
	la_data = this.object.data[ll_rowid]
	li_modificable = parent.of_modificable(la_data)
	this.setitem(ll_rowid,9,li_modificable)
next

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
//	de la estructura str_msgparm hacia la ventana w_cambio_nota_2_1 (vea el
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
any la_data[]

if row > 0 then
	if this.object.#9[row] = 1 then
		la_data = this.object.data[row]
		istr_msgparm.data = la_data
		istr_msgparm.data[upperbound(istr_msgparm.data) + 1] = row
		is_wintitle[1] = la_data[3]
		openwithparm (w_cambio_nota_2_1,istr_msgparm)
	end if
end if

end event

type uo_foto from uo_foto_alumno_int within w_cambio_nota_2
integer x = 41
integer y = 36
integer taborder = 10
end type

on uo_foto.destroy
call uo_foto_alumno_int::destroy
end on

