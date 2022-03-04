$PBExportHeader$w_carga_historia_acad.srw
forward
global type w_carga_historia_acad from window
end type
type cb_2 from commandbutton within w_carga_historia_acad
end type
type cb_1 from commandbutton within w_carga_historia_acad
end type
type dw_historicototal from datawindow within w_carga_historia_acad
end type
type uo_nombre from uo_nombre_alumno within w_carga_historia_acad
end type
end forward

global type w_carga_historia_acad from window
integer x = 832
integer y = 364
integer width = 3374
integer height = 1748
boolean titlebar = true
string title = "Carga de Historia Académica"
string menuname = "m_menu_hist_acad"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 10789024
event inicia_proceso ( )
cb_2 cb_2
cb_1 cb_1
dw_historicototal dw_historicototal
uo_nombre uo_nombre
end type
global w_carga_historia_acad w_carga_historia_acad

forward prototypes
public function boolean wf_existen_repetidos ()
end prototypes

event inicia_proceso;if dw_historicototal.Retrieve(long(uo_nombre.em_cuenta.text)) = 0 then
  MessageBox("Aviso","No se encontró información con esta cuenta")
end if  
end event

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
	ll_cve_mat_actual = dw_historicototal.GetItemNumber(ll_row_actual,"historico_cve_mat")	
	ls_gpo_actual = dw_historicototal.GetItemString(ll_row_actual,"historico_gpo")	
	li_periodo_actual = dw_historicototal.GetItemNumber(ll_row_actual,"historico_periodo")	
	li_anio_actual = dw_historicototal.GetItemNumber(ll_row_actual,"historico_anio")	
	li_cve_carrera_actual = dw_historicototal.GetItemNumber(ll_row_actual,"historico_cve_carrera")	
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
			return true
		end if
	next
next

return false


end function

on w_carga_historia_acad.create
if this.MenuName = "m_menu_hist_acad" then this.MenuID = create m_menu_hist_acad
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_historicototal=create dw_historicototal
this.uo_nombre=create uo_nombre
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_historicototal,&
this.uo_nombre}
end on

on w_carga_historia_acad.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_historicototal)
destroy(this.uo_nombre)
end on

event open;x=1
y=1
end event

type cb_2 from commandbutton within w_carga_historia_acad
integer x = 1925
integer y = 464
integer width = 562
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Almacenar Historia"
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
end event

type cb_1 from commandbutton within w_carga_historia_acad
integer x = 818
integer y = 464
integer width = 562
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Importar Archivo"
end type

event clicked;string ls_null, ls_mensaje_import, ls_cuenta
long ll_res_import, ll_num_rows, ll_cuenta
SetNull(ls_null)

ll_num_rows = dw_historicototal.RowCount()
ls_cuenta= uo_nombre.em_cuenta.text

if not isnumber(ls_cuenta) then
	MessageBox("Cuenta Invalida","Favor de escribir una cuenta permitida")
	return
else
	ll_cuenta = long(ls_cuenta)
end if

if not f_existe_alumno(ll_cuenta) then
	MessageBox("Cuenta Inexistente","Favor de escribir una cuenta valida")
	return
end if

//dw_historicototal.ImportFile ( filename {, startrow {, endrow {, startcolumn 	{, endcolumn {, dwstartcolumn } } } } } )
ll_res_import= dw_historicototal.ImportFile(ls_null, ll_num_rows)

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
else
	MessageBox("Importación Exitosa","Se importaron ["+string(ll_res_import)+"] registros.",StopSign!)
end if

//dw_historicototal.ImportFile ( filename {, startrow {, endrow {, startcolumn 	{, endcolumn {, dwstartcolumn } } } } } )
end event

type dw_historicototal from datawindow within w_carga_historia_acad
integer x = 32
integer y = 616
integer width = 3232
integer height = 888
integer taborder = 40
string dataobject = "d_carga_historia_acad"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;SetTransObject(gtr_sce)
m_menu_hist_acad.dw = this

end event

event dberror;//Para que muestre el error del manejedor de base de datos

return 0
end event

type uo_nombre from uo_nombre_alumno within w_carga_historia_acad
integer x = 32
integer y = 28
integer width = 3241
integer height = 424
integer taborder = 10
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

