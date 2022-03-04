$PBExportHeader$w_cambio_nota_reactivacion_2013.srw
$PBExportComments$Despliegue de datos academicos de un alumno (Carrera, Semestre, Subsistema, Fecha de Ingreso, Fecha de Egreso,.....)
forward
global type w_cambio_nota_reactivacion_2013 from w_master_main
end type
type iuo_foto_alumno_blob from uo_foto_alumno_blob within w_cambio_nota_reactivacion_2013
end type
type uo_nombre from uo_carreras_alumno_lista within w_cambio_nota_reactivacion_2013
end type
type dw_materias_intercambio from uo_master_dw within w_cambio_nota_reactivacion_2013
end type
type cb_refrescar from commandbutton within w_cambio_nota_reactivacion_2013
end type
type cb_reactivar from commandbutton within w_cambio_nota_reactivacion_2013
end type
type dw_aviso_tesoreria_intercambio from datawindow within w_cambio_nota_reactivacion_2013
end type
end forward

global type w_cambio_nota_reactivacion_2013 from w_master_main
integer x = 5
integer y = 4
integer width = 4238
integer height = 2704
string title = "Reactivacion por cambio de nota en Intercambio"
string menuname = "m_menu_general_base_2013"
boolean center = true
iuo_foto_alumno_blob iuo_foto_alumno_blob
uo_nombre uo_nombre
dw_materias_intercambio dw_materias_intercambio
cb_refrescar cb_refrescar
cb_reactivar cb_reactivar
dw_aviso_tesoreria_intercambio dw_aviso_tesoreria_intercambio
end type
global w_cambio_nota_reactivacion_2013 w_cambio_nota_reactivacion_2013

type variables
string is_lista_fotos[], is_filename = ""
str_msgparm istr_msgparm
long il_cuenta,il_carrera
end variables

forward prototypes
public function integer wf_borra_fotos_sesion (string as_filename_excepcion)
end prototypes

public function integer wf_borra_fotos_sesion (string as_filename_excepcion);integer li_indice_lista, li_tamanio_lista
string ls_filename
boolean lb_deletefile

li_tamanio_lista = upperbound(is_lista_fotos)

for li_indice_lista =1 to li_tamanio_lista
	ls_filename = is_lista_fotos[li_indice_lista]
	if as_filename_excepcion <> ls_filename then
		if FileExists(ls_filename) then
			lb_deletefile = FileDelete(ls_filename)
			if not lb_deletefile then
				MessageBox("Error de eliminación","No es posible eliminar el archivo ["+ls_filename+"]",StopSign!)
				return -1
			end if
		end if
	end if
next
return 0
end function

on w_cambio_nota_reactivacion_2013.create
int iCurrent
call super::create
if this.MenuName = "m_menu_general_base_2013" then this.MenuID = create m_menu_general_base_2013
this.iuo_foto_alumno_blob=create iuo_foto_alumno_blob
this.uo_nombre=create uo_nombre
this.dw_materias_intercambio=create dw_materias_intercambio
this.cb_refrescar=create cb_refrescar
this.cb_reactivar=create cb_reactivar
this.dw_aviso_tesoreria_intercambio=create dw_aviso_tesoreria_intercambio
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.iuo_foto_alumno_blob
this.Control[iCurrent+2]=this.uo_nombre
this.Control[iCurrent+3]=this.dw_materias_intercambio
this.Control[iCurrent+4]=this.cb_refrescar
this.Control[iCurrent+5]=this.cb_reactivar
this.Control[iCurrent+6]=this.dw_aviso_tesoreria_intercambio
end on

on w_cambio_nota_reactivacion_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.iuo_foto_alumno_blob)
destroy(this.uo_nombre)
destroy(this.dw_materias_intercambio)
destroy(this.cb_refrescar)
destroy(this.cb_reactivar)
destroy(this.dw_aviso_tesoreria_intercambio)
end on

event ue_actualiza;call super::ue_actualiza;integer li_confirmacion, li_almacenamiento
integer li_FileNum, li_GetFolder, li_FileNum_new, li_close_new, li_close_original,li_res
blob lb_photo
long ll_bytes_read, ll_bytes_written
string ls_ruta = "", ls_nombre_ruta

li_res = wf_validar ()
if li_res = -1 then
	rollback using gtr_sce;
	messagebox("Información","No se han guardado los cambios")	
	return
end if

li_confirmacion = MessageBox("Confirmación", "¿Desea almacenar la foto del alumno como archivo?", Question!, YesNO!)

if li_confirmacion = 1 then
	li_FileNum = FileOpen(is_filename, StreamMode!, Read!, LockWrite!)
	ll_bytes_read = FileReadEx(li_FileNum, lb_photo)
	li_GetFolder = GetFolder ( "Selecciona Directorio para grabar el archivo["+is_filename+"]", ls_ruta )
	if li_GetFolder = 1 then
		ls_nombre_ruta = ls_ruta +"\"+is_filename
		li_FileNum_new =FileOpen(ls_nombre_ruta, StreamMode!, Write!, LockWrite!, Replace!)
		ll_bytes_written = FileWriteEx ( li_FileNum_new, lb_photo )
		li_close_original = FileClose(li_FileNum)
		li_close_new = FileClose(li_FileNum_new)		
		triggerevent(doubleclicked!)
	end if

end if
end event

event close;if (desconecta_bd(gtr_scred) = 1) then
	//OK 
else
	MessageBox("Desconexión inválida","No es posible desconectarse de la base de datos de credenciales",StopSign!)
end if

wf_borra_fotos_sesion("")
end event

event doubleclicked;call super::doubleclicked;long cuentalocal
string ls_filename
int li_tamanio_lista, li_indice_lista
string ls_movimiento = 'Alta'

il_cuenta = uo_nombre.of_obten_cuenta()
il_carrera = uo_nombre.istr_carrera.str_cve_carrera


li_tamanio_lista = upperbound(is_lista_fotos)
li_indice_lista = li_tamanio_lista +1

if f_alumno_restringido (il_cuenta) then
	if f_usuario_especial(gs_usuario) then
		MessageBox("Usuario  Autorizado", &
		"Alumno con acceso restringido",Information!)	
	else
		MessageBox("Usuario NO Autorizado", &
	           "Alumno con acceso restringido, por favor consulte a la ~n"+ &
				 +"Dirección de Servicios Escolares",StopSign!)
		uo_nombre.dw_nombre_alumno.Reset()	
		uo_nombre.dw_nombre_alumno.insertrow(0)
		uo_nombre.em_digito.text=" "
		uo_nombre.em_cuenta.text = " "
		uo_nombre.em_cuenta.setfocus()
		return		
	end if
end if

dw_materias_intercambio.Retrieve(il_cuenta,il_carrera)

if il_cuenta > 0 then
	ls_filename = iuo_foto_alumno_blob.of_loadPhoto(il_cuenta,1, gtr_scred, 0)
	ls_filename = "photo_"+string(il_cuenta)+".jpg"
	is_filename = ls_filename
	is_lista_fotos[li_indice_lista] = ls_filename
else  
	is_filename = ""
end if

dw_aviso_tesoreria_intercambio.retrieve(il_cuenta,ls_movimiento,il_carrera)

end event

event open;call super::open;//g_nv_security.fnv_secure_window (this)
integer li_x_units, li_y_units

//dw_academico.settransobject(gtr_sce)

if (f_conecta_con_parametros_bd(gtr_sce, gtr_scred,1) = 1) then
	//OK 
else
	MessageBox("Acceso a fotos inválido","No es posible conectarse a la base de datos de credenciales",StopSign!)
end if

uo_nombre.em_cuenta.text = " "
dw_materias_intercambio.Settransobject(gtr_sce)
dw_aviso_tesoreria_intercambio.Settransobject(gtr_sce)

triggerevent(doubleclicked!) 
/**/gnv_app.inv_security.of_SetSecurity(this)



end event

event closequery;//
end event

type st_sistema from w_master_main`st_sistema within w_cambio_nota_reactivacion_2013
end type

type p_ibero from w_master_main`p_ibero within w_cambio_nota_reactivacion_2013
end type

type iuo_foto_alumno_blob from uo_foto_alumno_blob within w_cambio_nota_reactivacion_2013
event destroy ( )
integer x = 41
integer y = 328
integer width = 498
integer height = 492
integer taborder = 10
borderstyle borderstyle = stylebox!
end type

on iuo_foto_alumno_blob.destroy
call uo_foto_alumno_blob::destroy
end on

type uo_nombre from uo_carreras_alumno_lista within w_cambio_nota_reactivacion_2013
event destroy ( )
integer x = 571
integer y = 328
integer width = 3223
integer taborder = 30
boolean bringtotop = true
end type

on uo_nombre.destroy
call uo_carreras_alumno_lista::destroy
end on

event constructor;call super::constructor;m_menu_general_base_2013.objeto = this
end event

type dw_materias_intercambio from uo_master_dw within w_cambio_nota_reactivacion_2013
integer x = 37
integer y = 880
integer width = 4082
integer height = 1428
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_reactivacion_cambio_nota_int_2013"
end type

type cb_refrescar from commandbutton within w_cambio_nota_reactivacion_2013
integer x = 3067
integer y = 2348
integer width = 402
integer height = 88
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Refrescar..."
end type

event clicked;dw_materias_intercambio.retrieve(il_cuenta,il_carrera)
end event

type cb_reactivar from commandbutton within w_cambio_nota_reactivacion_2013
integer x = 3534
integer y = 2348
integer width = 576
integer height = 88
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Reactivar Seleccionadas"
end type

event clicked;integer li_resultado, li_confirmacion
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

ll_rows_aviso = dw_aviso_tesoreria_intercambio.retrieve(ll_cuenta,ls_movimiento,il_carrera)

if lb_inscrita_reactivada then
	dw_aviso_tesoreria_intercambio.Print()
end if


ls_titulo = "Información"
ls_mensaje = "Se reactivaron: " + string(li_procesados) + " registros"
MessageBox(ls_titulo, ls_mensaje,Information!)

SetPointer(oldpointer)


end event

type dw_aviso_tesoreria_intercambio from datawindow within w_cambio_nota_reactivacion_2013
boolean visible = false
integer x = 151
integer y = 2324
integer width = 1591
integer height = 84
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_aviso_tesoreria_interc_perm_01_2013"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

