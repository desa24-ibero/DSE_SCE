$PBExportHeader$w_carga_historia_acad_2013.srw
forward
global type w_carga_historia_acad_2013 from w_master_main
end type
type dw_historicototal from uo_master_dw within w_carga_historia_acad_2013
end type
type pb_archivo from picturebutton within w_carga_historia_acad_2013
end type
type sle_ruta_archivo from u_sle within w_carga_historia_acad_2013
end type
type st_texto_ruta from u_st within w_carga_historia_acad_2013
end type
type pb_materias from picturebutton within w_carga_historia_acad_2013
end type
type uo_nombre from uo_carreras_alumno_lista within w_carga_historia_acad_2013
end type
type cb_1 from commandbutton within w_carga_historia_acad_2013
end type
type gb_1 from groupbox within w_carga_historia_acad_2013
end type
type gb_4 from groupbox within w_carga_historia_acad_2013
end type
end forward

global type w_carga_historia_acad_2013 from w_master_main
integer width = 3547
integer height = 2972
string title = "Carga de Historia Académica"
string menuname = "m_carga_historia_acad_2013"
dw_historicototal dw_historicototal
pb_archivo pb_archivo
sle_ruta_archivo sle_ruta_archivo
st_texto_ruta st_texto_ruta
pb_materias pb_materias
uo_nombre uo_nombre
cb_1 cb_1
gb_1 gb_1
gb_4 gb_4
end type
global w_carga_historia_acad_2013 w_carga_historia_acad_2013

type variables
int ii_sw = 0

string is_nombre_archivo
long il_carrera

end variables

forward prototypes
public function boolean wf_existen_repetidos ()
end prototypes

public function boolean wf_existen_repetidos ();long ll_num_rows, ll_row_actual, ll_row_buscado, ll_cuenta_actual
string ls_gpo_actual, ls_calificacion_actual
long ll_cve_mat_actual 
integer li_periodo_actual, li_anio_actual
integer li_cve_carrera_actual, li_cve_plan_actual, li_observacion_actual
long  ll_cuenta_buscada
string ls_gpo_buscado, ls_calificacion_buscada
long ll_cve_mat_buscada
integer li_periodo_buscado, li_anio_buscado
integer li_cve_carrera_buscada, li_cve_plan_buscado, li_observacion_buscada

ll_num_rows= dw_historicototal.RowCount()
for ll_row_actual = 1 to ll_num_rows
	ll_cuenta_actual = dw_historicototal.GetItemNumber(ll_row_actual,"historico_cuenta")	
	if long(uo_nombre.of_obten_cuenta()) <> ll_cuenta_actual then
		messagebox('Aviso','La cuenta capturada no corresponde a la que trae el archivo, verifique')
		return true
	end if
	ll_cve_mat_actual = dw_historicototal.GetItemNumber(ll_row_actual,"historico_cve_mat")	
	ls_gpo_actual = dw_historicototal.GetItemString(ll_row_actual,"historico_gpo")	
	li_periodo_actual = dw_historicototal.GetItemNumber(ll_row_actual,"historico_periodo")	
	li_anio_actual = dw_historicototal.GetItemNumber(ll_row_actual,"historico_anio")	
	li_cve_carrera_actual = dw_historicototal.GetItemNumber(ll_row_actual,"historico_cve_carrera")	
	if il_carrera <> li_cve_carrera_actual then
		messagebox('Aviso','La carrera selecionada no corresponde a la que trae el archivo, verifique')
		return true
	end if
	li_cve_plan_actual = dw_historicototal.GetItemNumber(ll_row_actual,"historico_cve_plan")	
	ls_calificacion_actual = dw_historicototal.GetItemString(ll_row_actual,"historico_calificacion")	
	li_observacion_actual = dw_historicototal.GetItemNumber(ll_row_actual,"historico_observacion")	

	for ll_row_buscado = 1 to ll_num_rows
		ll_cuenta_buscada = dw_historicototal.GetItemNumber(ll_row_buscado,"historico_cuenta")	
		ll_cve_mat_buscada = dw_historicototal.GetItemNumber(ll_row_buscado,"historico_cve_mat")	
		ls_gpo_buscado = dw_historicototal.GetItemString(ll_row_buscado,"historico_gpo")	
		li_periodo_buscado = dw_historicototal.GetItemNumber(ll_row_buscado,"historico_periodo")	
		li_anio_buscado = dw_historicototal.GetItemNumber(ll_row_buscado,"historico_anio")	
		li_cve_carrera_buscada = dw_historicototal.GetItemNumber(ll_row_buscado,"historico_cve_carrera")	
		li_cve_plan_buscado = dw_historicototal.GetItemNumber(ll_row_buscado,"historico_cve_plan")	
		ls_calificacion_buscada = dw_historicototal.GetItemString(ll_row_buscado,"historico_calificacion")	
		li_observacion_buscada = dw_historicototal.GetItemNumber(ll_row_buscado,"historico_observacion")	
		if ll_row_buscado <> ll_row_actual and ll_cuenta_buscada =ll_cuenta_actual and &
			ll_cve_mat_buscada = ll_cve_mat_actual and ls_gpo_buscado = ls_gpo_actual and &
			li_periodo_buscado = li_periodo_actual and li_anio_buscado = li_anio_actual and &
			li_cve_carrera_buscada = li_cve_carrera_actual and li_cve_plan_buscado = li_cve_plan_actual then
			MessageBox("Registro Repetido en renglones "+string(ll_row_actual)+" y "+string(ll_row_buscado), &
			           "Cuenta  : "+string(ll_cuenta_buscada)+"~n"+ &
			           "Cve Mat : "+string(ll_cve_mat_buscada)+"~n"+ &
			           "Grupo   : "+ls_gpo_buscado+"~n"+ &
			           "Periodo : "+string(li_periodo_buscado)+"~n"+ &
			           "Anio    : "+string(li_anio_buscado)+"~n"+ &
			           "Carrera : "+string(li_cve_carrera_buscada)+"~n"+ &
			           "Plan    : "+string(li_cve_plan_buscado)+"~n")
			dw_historicototal.SelectRow(0,false)								  
			dw_historicototal.SelectRow(ll_row_buscado,true)						  
			return true
		end if
	next
next

return false


end function

on w_carga_historia_acad_2013.create
int iCurrent
call super::create
if this.MenuName = "m_carga_historia_acad_2013" then this.MenuID = create m_carga_historia_acad_2013
this.dw_historicototal=create dw_historicototal
this.pb_archivo=create pb_archivo
this.sle_ruta_archivo=create sle_ruta_archivo
this.st_texto_ruta=create st_texto_ruta
this.pb_materias=create pb_materias
this.uo_nombre=create uo_nombre
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_historicototal
this.Control[iCurrent+2]=this.pb_archivo
this.Control[iCurrent+3]=this.sle_ruta_archivo
this.Control[iCurrent+4]=this.st_texto_ruta
this.Control[iCurrent+5]=this.pb_materias
this.Control[iCurrent+6]=this.uo_nombre
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_4
end on

on w_carga_historia_acad_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_historicototal)
destroy(this.pb_archivo)
destroy(this.sle_ruta_archivo)
destroy(this.st_texto_ruta)
destroy(this.pb_materias)
destroy(this.uo_nombre)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_4)
end on

event closequery;//
end event

event open;call super::open;dw_historicototal.settransobject(gtr_sce)
uo_nombre.em_cuenta.text = " "

/**/gnv_app.inv_security.of_SetSecurity(this)

end event

event activate;call super::activate;control_escolar.toolbarsheettitle="Carga de Historia Académica"
end event

event doubleclicked;call super::doubleclicked;il_carrera = uo_nombre.istr_carrera.str_cve_carrera
if dw_historicototal.Retrieve(long(uo_nombre.em_cuenta.text),il_carrera) = 0 then
  MessageBox("Aviso","No se encontró información con esta cuenta")
  pb_archivo.enabled = true
  st_texto_ruta.text = ''
else
	if messagebox('Aviso','Se ha encontrado historia académica del alumno~r¿Desea continuar?',question!,yesno!,2) = 1 then
		pb_archivo.enabled = true
	else
		pb_archivo.enabled = false
	end if
end if  
end event

event close;dwItemStatus l_status

l_status = idw_trabajo.GetItemStatus(1, 0, Primary!)

if l_status <> NotModified!	then
	if messagebox('Aviso','¿Desea guardar los cambios?',Question!,Yesno!) = 1 then
		if wf_validar () <> 1 then 	
			rollback using gtr_sce;
			messagebox("Información","No se han guardado los cambios")	
			return 
		else
			 pb_materias.triggerevent(Clicked!)
		end if
	end if
end if
end event

event ue_imprime;call super::ue_imprime;//*/*//dw_historicototal.print()  //°|°//


end event

type st_sistema from w_master_main`st_sistema within w_carga_historia_acad_2013
end type

type p_ibero from w_master_main`p_ibero within w_carga_historia_acad_2013
end type

type dw_historicototal from uo_master_dw within w_carga_historia_acad_2013
integer x = 59
integer y = 1076
integer width = 3227
integer height = 1400
integer taborder = 0
string dataobject = "d_carga_historia_acad_2013"
boolean resizable = true
end type

event constructor;call super::constructor;idw_trabajo = this
end event

event retrieveend;call super::retrieveend;if rowcount>0 then
	cb_1.enabled=true
end if
end event

type pb_archivo from picturebutton within w_carga_historia_acad_2013
integer x = 87
integer y = 908
integer width = 160
integer height = 124
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "Custom039!"
string disabledname = "Custom080!"
alignment htextalign = left!
end type

event clicked;long ll_res_import,ll_num_rows,value
string ls_null,ls_mensaje_import,pathname,filename

value = GetFileOpenName("Seleccione el Archivo", &
		+ pathname, filename, "TXT", &
		+ "Text Files (*.TXT),*.TXT")

IF value = 1 THEN 
	sle_ruta_archivo.text = pathname
ELSE
	MessageBox("Sin Archivo","No se ha abierto ningún archivo",Information!)
end if

dw_historicototal.Reset()
ll_res_import= dw_historicototal.ImportFile(pathname)

//Long. Returns the number of rows that were imported if it succeeds and
//one of the following negative integers if an error occurs:
choose case ll_res_import
	case 0  
	ls_mensaje_import= "Fin de archivo; demasiados registros"
	case -1  
		ls_mensaje_import= "No hay registros"
	case -2  
		ls_mensaje_import= "Archivo vacio"
	case -3  
		ls_mensaje_import= "Argumento invalido"
	case -4  
		ls_mensaje_import= "Entrada invalid "
	case -5  
		ls_mensaje_import= "No es posible abrir el archivo"
	case -6  
		ls_mensaje_import= "No es posible cerrar el archivo"
	case -7  
		ls_mensaje_import= "Error leyendo el archivo de texto"
	case -8  
		ls_mensaje_import= "No es un archivo TXT "
	case -9  
		ls_mensaje_import= "El usuario cancelo la importacion"
	case -10 
		ls_mensaje_import= "Formato de archivo dBase no permitido (no es version 2 ni 3)"
end choose

if ll_res_import<=0 then
	MessageBox("Error de importación",ls_mensaje_import,StopSign!)
	pb_materias.enabled = false
else
	MessageBox("Importación Exitosa","Se importaron ["+string(ll_res_import)+"] registros.",StopSign!)
	pb_materias.enabled = true
end if
end event

type sle_ruta_archivo from u_sle within w_carga_historia_acad_2013
integer x = 411
integer y = 932
integer width = 2039
integer height = 76
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Tahoma"
long backcolor = 16777215
end type

type st_texto_ruta from u_st within w_carga_historia_acad_2013
integer x = 265
integer y = 936
integer width = 146
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Tahoma"
long backcolor = 16777215
string text = "Ruta:"
end type

type pb_materias from picturebutton within w_carga_historia_acad_2013
integer x = 2816
integer y = 908
integer width = 160
integer height = 124
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string picturename = "DBAdmin!"
string disabledname = "Custom080!"
alignment htextalign = left!
end type

event clicked;integer rtn


if wf_existen_repetidos() then
	MessageBox("Error de Importacion","No se ha almacenado la historia academica", StopSign!)
	return
end if

rtn = dw_historicototal.Update()

IF rtn = 1 THEN
	COMMIT USING gtr_sce;
	MessageBox("Importacion Exitosa","Se ha almacenado la historia academica", Information!)
ELSE
	ROLLBACK USING gtr_sce;
	MessageBox("Error de Importacion","No se ha almacenado la historia academica", StopSign!)
END IF

pb_materias.enabled = false
pb_archivo.enabled = false
end event

type uo_nombre from uo_carreras_alumno_lista within w_carga_historia_acad_2013
event destroy ( )
integer x = 59
integer y = 296
integer taborder = 40
boolean bringtotop = true
end type

on uo_nombre.destroy
call uo_carreras_alumno_lista::destroy
end on

event constructor;call super::constructor;m_carga_historia_acad_2013.objeto = this
end event

type cb_1 from commandbutton within w_carga_historia_acad_2013
integer x = 1499
integer y = 2568
integer width = 402
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Imprimir"
end type

event clicked;dw_historicototal.print()
end event

type gb_1 from groupbox within w_carga_historia_acad_2013
integer x = 59
integer y = 828
integer width = 2446
integer height = 232
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Seleccionar archivo"
end type

type gb_4 from groupbox within w_carga_historia_acad_2013
integer x = 2533
integer y = 828
integer width = 750
integer height = 232
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Almacenar Historia"
end type

