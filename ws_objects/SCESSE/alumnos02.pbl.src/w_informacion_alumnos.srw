$PBExportHeader$w_informacion_alumnos.srw
$PBExportComments$Despliegue de datos academicos de un alumno (Carrera, Semestre, Subsistema, Fecha de Ingreso, Fecha de Egreso,.....)
forward
global type w_informacion_alumnos from w_main
end type
type cb_1 from u_cb within w_informacion_alumnos
end type
type iuo_foto_alumno_blob from uo_foto_alumno_blob within w_informacion_alumnos
end type
type uo_nombre from uo_nombre_alumno within w_informacion_alumnos
end type
type dw_academico from datawindow within w_informacion_alumnos
end type
type r_1 from rectangle within w_informacion_alumnos
end type
end forward

global type w_informacion_alumnos from w_main
integer x = 5
integer y = 4
integer width = 4311
integer height = 1292
string title = "Información del Alumno"
string menuname = "m_datos_academicos"
boolean hscrollbar = true
boolean vscrollbar = true
long backcolor = 10789024
boolean center = true
cb_1 cb_1
iuo_foto_alumno_blob iuo_foto_alumno_blob
uo_nombre uo_nombre
dw_academico dw_academico
r_1 r_1
end type
global w_informacion_alumnos w_informacion_alumnos

type variables
boolean ib_modificando=false
string is_lista_fotos[], is_filename = ""
end variables

forward prototypes
public function integer wf_borra_fotos_sesion (string as_filename_excepcion)
end prototypes

public function integer wf_borra_fotos_sesion (string as_filename_excepcion);//wf_borra_fotos_sesion

integer li_indice_lista, li_tamanio_lista
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

on w_informacion_alumnos.create
int iCurrent
call super::create
if this.MenuName = "m_datos_academicos" then this.MenuID = create m_datos_academicos
this.cb_1=create cb_1
this.iuo_foto_alumno_blob=create iuo_foto_alumno_blob
this.uo_nombre=create uo_nombre
this.dw_academico=create dw_academico
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.iuo_foto_alumno_blob
this.Control[iCurrent+3]=this.uo_nombre
this.Control[iCurrent+4]=this.dw_academico
this.Control[iCurrent+5]=this.r_1
end on

on w_informacion_alumnos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.iuo_foto_alumno_blob)
destroy(this.uo_nombre)
destroy(this.dw_academico)
destroy(this.r_1)
end on

event open;
//g_nv_security.fnv_secure_window (this)
integer li_x_units, li_y_units

this.of_SetResize(TRUE)
this.inv_resize.of_Register(iuo_foto_alumno_blob, this.inv_resize.SCALERIGHTBOTTOM)
this.inv_resize.of_SetOrigSize(this.width, this.height) 
this.inv_resize.of_SetMinSize(this.width - 50 , this.height - 50 )
this.x = 1
this.y = 1


dw_academico.settransobject(gtr_sce)


if (f_conecta_con_parametros_bd(gtr_sce, gtr_scred,1) = 1) then
	//OK 
else
	MessageBox("Acceso a fotos inválido","No es posible conectarse a la base de datos de credenciales",StopSign!)
end if



//dw_academico.object.cve_subsistema.dddw.settransobject(gtr_sce)
uo_nombre.em_cuenta.text = " "
triggerevent(doubleclicked!) 
/**/gnv_app.inv_security.of_SetSecurity(this)
//if dw_academico.rowcount() = 0 then
//	dw_academico.insertrow(0)
//end if
//if dw_ingreso.rowcount() = 0 then
//	dw_ingreso.insertrow(0)
//end if
//dw_reingreso.insertrow(0)
//dw_indulto.insertrow(0)


end event

event doubleclicked;long cuentalocal
int carrera,plan, li_res_conexion_parametros
string ls_filename
int li_tamanio_lista, li_indice_lista
//char nivel

long ll_row, ll_cuenta

ll_row = uo_nombre.dw_nombre_alumno.GetRow()
ll_cuenta = uo_nombre.dw_nombre_alumno.GetItemNumber(ll_row, "cuenta")

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


Datawindowchild subsis

dw_academico.getchild('cve_subsistema',subsis)

subsis.settransobject(gtr_sce)

cuentalocal = long(uo_nombre.em_cuenta.text)
//
//  SELECT academicos.nivel  
//    INTO :nivel  
//    FROM academicos  
//   WHERE academicos.cuenta = :cuentalocal    using gtr_sce;
//
//
//  SELECT academicos.cve_carrera,   
//         academicos.cve_plan  
//    INTO :carrera,   
//         :plan  
//    FROM academicos  
//   WHERE academicos.cuenta = :cuentalocal using gtr_sce;

int cuantos

if isvalid(dw_academico) then
	setnull(cuantos)
	SELECT  s.cve_subsistema, a.cve_carrera, a.cve_plan INTO :cuantos, :carrera, :plan
	FROM dbo.academicos a  LEFT JOIN dbo.subsistema s ON a.cve_carrera = s.cve_carrera AND a.cve_plan = s.cve_plan
	WHERE a.cuenta = :cuentalocal using gtr_sce;
	if isnull(cuantos) then 
		subsis.retrieve(0,0)
	else
		subsis.retrieve(carrera,plan) 
	end if
end if
//if isvalid(dw_academico) then
	//if nivel = 'L' then
	//   	if subsis.retrieve(carrera,plan) = -1 then  subsis.retrieve(0,0)
	//	else
	//		subsis.retrieve(145,3)
	//	end if
//end if


if ll_cuenta > 0 then
	ls_filename = iuo_foto_alumno_blob.of_loadPhoto(ll_cuenta,1, gtr_scred, 0)
	ls_filename = "photo_"+string(ll_cuenta)+".jpg"
	is_filename = ls_filename
	is_lista_fotos[li_indice_lista] = ls_filename
else  
	is_filename = ""
end if

if dw_academico.retrieve(long(uo_nombre.em_cuenta.text)) = 0 then
	dw_academico.insertrow(0)
end if







end event

event closequery;//int resp
//if dw_reingreso.modifiedcount() > 0 or dw_reingreso.deletedcount() > 0 or dw_indulto.modifiedcount() > 0 or dw_indulto.deletedcount() > 0 or dw_academico.modifiedcount() > 0 or dw_academico.deletedcount() > 0 then
//	resp = messagebox("Aviso","Los cambios no han sido guardados.~n¿Desea guardarlos ahora?",question!,yesnocancel!)
//	choose case resp
//		case 1 
//			m_datos_academicos.m_registro.m_actualiza.triggerevent(clicked!)			
//		case 2
//			dw_indulto.resetupdate()
//			dw_reingreso.resetupdate()
//			dw_academico.resetupdate()
//			
//		case 3
//			message.returnvalue = 1 
//	end choose
//end if
end event

event activate;//control_escolar.toolbarsheettitle="Datos Academicos"

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

event close;if (desconecta_bd(gtr_scred) = 1) then
	//OK 
else
	MessageBox("Desconexión inválida","No es posible desconectarse de la base de datos de credenciales",StopSign!)
end if

wf_borra_fotos_sesion("")
end event

event resize;call super::resize;
string ls_filename
long ll_row, ll_cuenta

ll_row = uo_nombre.dw_nombre_alumno.GetRow()

if ll_row> 0 then 
	ll_cuenta = uo_nombre.dw_nombre_alumno.GetItemNumber(ll_row, "cuenta")
end if

if ll_cuenta > 0 then

	ls_filename = iuo_foto_alumno_blob.of_loadPhoto(ll_cuenta,1, gtr_scred, 0)

end if
end event

type cb_1 from u_cb within w_informacion_alumnos
integer x = 2866
integer y = 804
integer width = 393
integer taborder = 30
string text = "Guardar Imagen"
end type

event clicked;call super::clicked;integer li_confirmacion, li_almacenamiento
integer li_FileNum, li_GetFolder, li_FileNum_new, li_close_new, li_close_original
blob lb_photo
long ll_bytes_read, ll_bytes_written
string ls_ruta = "", ls_nombre_ruta

if	len(is_filename)= 0 or isnull(is_filename) then
	MessageBox("Foto Inexistente", "No existe la foto del alumno", Information!)
	return
end if

li_confirmacion = MessageBox("Confirmación", "¿Desea almacenar la foto del alumno como archivo?", Question!, YesNO!)

if li_confirmacion = 1 then
//	if	wf_borra_fotos_sesion(is_filename) = -1 then
//		MessageBox("Error", "No es posible guardar la foto", StopSign!)
//		return
//	end if
	li_FileNum = FileOpen(is_filename, StreamMode!, Read!, LockWrite!)
	ll_bytes_read = FileReadEx(li_FileNum, lb_photo)
	li_GetFolder = GetFolder ( "Selecciona Directorio para grabar el archivo["+is_filename+"]", ls_ruta )
	if li_GetFolder = 1 then
		ls_nombre_ruta = ls_ruta +"\"+is_filename
		li_FileNum_new =FileOpen(ls_nombre_ruta, StreamMode!, Write!, LockWrite!, Replace!)
		ll_bytes_written = FileWriteEx ( li_FileNum_new, lb_photo )
		li_close_original = FileClose(li_FileNum)
		li_close_new = FileClose(li_FileNum_new)		
	end if

end if


end event

type iuo_foto_alumno_blob from uo_foto_alumno_blob within w_informacion_alumnos
integer x = 3310
integer y = 32
integer width = 809
integer height = 808
integer taborder = 20
borderstyle borderstyle = stylebox!
end type

on iuo_foto_alumno_blob.destroy
call uo_foto_alumno_blob::destroy
end on

type uo_nombre from uo_nombre_alumno within w_informacion_alumnos
integer x = 37
integer y = 32
integer width = 3241
integer height = 396
integer taborder = 10
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

event constructor;call super::constructor;m_datos_academicos.objeto = this
end event

type dw_academico from datawindow within w_informacion_alumnos
integer x = 41
integer y = 436
integer width = 3250
integer height = 372
integer taborder = 20
boolean enabled = false
string dataobject = "d_informacion_alumnos"
boolean border = false
end type

event getfocus;m_datos_academicos.dw = this
end event

event itemchanged;
string ls_nivel, ls_columna, ls_cve_carrera
long ll_cve_carrera, ll_row
integer li_cve_plan

ll_row = this.GetRow()

if ib_modificando then
	return
end if

ib_modificando = true

this.AcceptText()

//ls_columna =dwo.name

ls_columna =this.GetColumnName()

ll_cve_carrera = object.cve_carrera[ll_row]
ls_cve_carrera = string(ll_cve_carrera)
li_cve_plan = object.cve_plan[ll_row]

choose case ls_columna 
case 'cve_carrera' 	
	ls_nivel = f_obten_nivel(ll_cve_carrera)	
	object.nivel[ll_row]=ls_nivel
case 'cve_plan' 
	if isnull(ll_cve_carrera) or (ll_cve_carrera= 0) then
		ll_cve_carrera= 0
		MessageBox("Captura previa requerida","Favor de Capturar la carrera")
		this.SetColumn("cve_carrera")
		ib_modificando = false
		return 2
	elseif not f_plan_activo(ll_cve_carrera, li_cve_plan) then
		MessageBox("Plan Inactivo","La carrera: ["+ls_cve_carrera+"] con el plan: ["+string(li_cve_plan)+ "] no estan activos ")	
		ib_modificando = false
		return 2		
	end if
end choose

ib_modificando = false

end event

type r_1 from rectangle within w_informacion_alumnos
boolean visible = false
integer linethickness = 4
long fillcolor = 16777215
integer x = 3296
integer y = 24
integer width = 837
integer height = 828
end type

