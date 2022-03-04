$PBExportHeader$w_informacion_alumnos_2013.srw
$PBExportComments$Despliegue de datos academicos de un alumno (Carrera, Semestre, Subsistema, Fecha de Ingreso, Fecha de Egreso,.....)
forward
global type w_informacion_alumnos_2013 from w_master_main
end type
type iuo_foto_alumno_blob from uo_foto_alumno_blob within w_informacion_alumnos_2013
end type
type uo_nombre from uo_nombre_alumno_2013 within w_informacion_alumnos_2013
end type
type dw_academico from uo_master_dw within w_informacion_alumnos_2013
end type
end forward

global type w_informacion_alumnos_2013 from w_master_main
integer x = 5
integer y = 4
integer width = 4238
integer height = 1268
string title = "Información del Alumno"
string menuname = "m_menu_general_2013"
boolean center = true
iuo_foto_alumno_blob iuo_foto_alumno_blob
uo_nombre uo_nombre
dw_academico dw_academico
end type
global w_informacion_alumnos_2013 w_informacion_alumnos_2013

type variables
string is_lista_fotos[], is_filename = ""
Datawindowchild dwc_subsis,dwc_carrera,dwc_plan, dwc_periodo 


uo_periodo_servicios iuo_periodo_servicios
end variables

forward prototypes
public function integer wf_borra_fotos_sesion (string as_filename_excepcion)
public function integer wf_validar ()
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

public function integer wf_validar ();if	len(is_filename)= 0 or isnull(is_filename) then
	MessageBox("Foto Inexistente", "No existe la foto del alumno", Information!)
	return -1
end if

return 1
end function

on w_informacion_alumnos_2013.create
int iCurrent
call super::create
if this.MenuName = "m_menu_general_2013" then this.MenuID = create m_menu_general_2013
this.iuo_foto_alumno_blob=create iuo_foto_alumno_blob
this.uo_nombre=create uo_nombre
this.dw_academico=create dw_academico
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.iuo_foto_alumno_blob
this.Control[iCurrent+2]=this.uo_nombre
this.Control[iCurrent+3]=this.dw_academico
end on

on w_informacion_alumnos_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.iuo_foto_alumno_blob)
destroy(this.uo_nombre)
destroy(this.dw_academico)
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

event activate;call super::activate;//control_escolar.toolbarsheettitle="Datos Academicos"

//control_escolar.toolbarsheettitle="Datos Academicos"

integer li_x_units , li_y_units 

li_x_units = PixelsToUnits(150, XPixelsToUnits!)
li_y_units = PixelsToUnits(150, YPixelsToUnits!)

li_x_units = PixelsToUnits(800, XPixelsToUnits!)
li_y_units = PixelsToUnits(800, YPixelsToUnits!)

//
//iuo_foto_alumno_blob.width = li_x_units
//iuo_foto_alumno_blob.height = li_y_units

iuo_foto_alumno_blob.width = 800 
iuo_foto_alumno_blob.height = 800

end event

event close;call super::close;if (desconecta_bd(gtr_scred) = 1) then
	//OK 
else
	MessageBox("Desconexión inválida","No es posible desconectarse de la base de datos de credenciales",StopSign!)
end if

wf_borra_fotos_sesion("")
end event

event doubleclicked;call super::doubleclicked;long cuentalocal
int carrera,plan, li_res_conexion_parametros
string ls_filename
int li_tamanio_lista, li_indice_lista
//char nivel

long  ll_cuenta

ll_cuenta = uo_nombre.of_obten_cuenta()

li_tamanio_lista = upperbound(is_lista_fotos)
li_indice_lista = li_tamanio_lista +1

if f_alumno_restringido (ll_cuenta) then
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


//dw_academico.Modify("Datawindow.object.periodo_ing.dddw.name=d_lista_peroidos "+&
//							 "dddw.displaycolumn=descripcion dddw.datacolumn=periodo")
/*
dddw.percentwidth=0
dddw.lines=0
dddw.limit=0
dddw.allowedit=no
dddw.useasborder=yes
dddw.case=any
*/

dw_academico.getchild('cve_carrera',dwc_carrera)
dwc_carrera.settransobject(gtr_sce)
dw_academico.getchild('cve_plan',dwc_plan)
dwc_plan.settransobject(gtr_sce)
dw_academico.getchild('cve_subsistema',dwc_subsis)
dwc_subsis.settransobject(gtr_sce)


//Modif. Roberto Novoa May/2016 .- Funcionalidad periodos multiples
// Actualización Ago 2016 
//dw_academico.Getchild('periodo_ing',dwc_periodo)
//dwc_periodo.settransobject(gtr_sce)
//dwc_periodo.retrieve(gs_tipo_periodo)
iuo_periodo_servicios.f_modifica_lista_columna( dw_academico, "periodo_ing", "L") 

//dw_academico.Getchild('periodo_egre',dwc_periodo)
//dwc_periodo.settransobject(gtr_sce)
//dwc_periodo.retrieve(gs_tipo_periodo)
iuo_periodo_servicios.f_modifica_lista_columna( dw_academico, "periodo_egre", "L") 



cuentalocal = uo_nombre.of_obten_cuenta()

int cuantos

dwc_carrera.retrieve()

if isvalid(dw_academico) then
	setnull(cuantos)
	SELECT  s.cve_subsistema, a.cve_carrera, a.cve_plan INTO :cuantos, :carrera, :plan
	FROM dbo.academicos a  LEFT JOIN dbo.subsistema s ON a.cve_carrera = s.cve_carrera AND a.cve_plan = s.cve_plan	
	WHERE a.cuenta = :cuentalocal using gtr_sce;
	if isnull(cuantos) then 
		dwc_subsis.retrieve(0,0)
	end if
	if isnull(carrera)  then
		dwc_plan.Retrieve(0)
		dwc_subsis.retrieve(0,0)
	else 
		dwc_plan.Retrieve(carrera)
		dwc_subsis.retrieve(carrera,plan)
	end if
end if

if ll_cuenta > 0 then
	ls_filename = iuo_foto_alumno_blob.of_loadPhoto(ll_cuenta,1, gtr_scred, 0)
	ls_filename = "photo_"+string(ll_cuenta)+".jpg"
	is_filename = ls_filename
	is_lista_fotos[li_indice_lista] = ls_filename
else  
	is_filename = ""
end if

if dw_academico.retrieve(uo_nombre.of_obten_cuenta()) = 0 then
	dw_academico.insertrow(0)
end if

if dwc_plan.rowcount() = 0 then
	dwc_plan.Insertrow(0)
	dwc_plan.Setitem(1,'cve_plan', 0)
	dwc_plan.Setitem(1,'nombre_plan', 'SIN PLAN')
end if
if dwc_subsis.rowcount() = 0 then
	dwc_subsis.Insertrow(0)
	dwc_subsis.Setitem(1,'cve_subsistema', 0)
	dwc_subsis.Setitem(1,'subsistema', 'SIN SUBSISTEMA')
end if

end event

event open;call super::open;m_menu_general_2013.m_registro.m_nuevo.enabled = False
m_menu_general_2013.m_registro.m_borraregistro.enabled = False

//g_nv_security.fnv_secure_window (this)
integer li_x_units, li_y_units

this.of_SetResize(TRUE)
this.inv_resize.of_Register(iuo_foto_alumno_blob, this.inv_resize.SCALERIGHTBOTTOM)
this.inv_resize.of_SetOrigSize(this.width, this.height) 
this.inv_resize.of_SetMinSize(this.width - 50 , this.height - 50 )

dw_academico.settransobject(gtr_sce)

if (f_conecta_con_parametros_bd(gtr_sce, gtr_scred,1) = 1) then
	//OK 
else
	MessageBox("Acceso a fotos inválido","No es posible conectarse a la base de datos de credenciales",StopSign!)
end if

iuo_periodo_servicios = CREATE uo_periodo_servicios 
iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, "L", gtr_sce)  

uo_nombre.em_cuenta.text = " "
triggerevent(doubleclicked!) 
/**/gnv_app.inv_security.of_SetSecurity(this)









end event

type st_sistema from w_master_main`st_sistema within w_informacion_alumnos_2013
end type

type p_ibero from w_master_main`p_ibero within w_informacion_alumnos_2013
end type

type iuo_foto_alumno_blob from uo_foto_alumno_blob within w_informacion_alumnos_2013
event destroy ( )
integer x = 3310
integer y = 188
integer width = 809
integer height = 808
integer taborder = 10
borderstyle borderstyle = stylebox!
end type

on iuo_foto_alumno_blob.destroy
call uo_foto_alumno_blob::destroy
end on

type uo_nombre from uo_nombre_alumno_2013 within w_informacion_alumnos_2013
event destroy ( )
integer x = 59
integer y = 304
integer taborder = 20
end type

on uo_nombre.destroy
call uo_nombre_alumno_2013::destroy
end on

event constructor;call super::constructor;m_menu_general_2013.objeto = this

end event

type dw_academico from uo_master_dw within w_informacion_alumnos_2013
integer x = 46
integer y = 644
integer width = 3250
integer height = 356
integer taborder = 30
boolean enabled = false
string dataobject = "dw_informacion_alumnos_2013"
boolean hscrollbar = false
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;idw_trabajo = this
m_menu_general_2013.dw = this
end event

