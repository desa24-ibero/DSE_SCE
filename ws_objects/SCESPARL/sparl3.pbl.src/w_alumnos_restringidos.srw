$PBExportHeader$w_alumnos_restringidos.srw
forward
global type w_alumnos_restringidos from window
end type
type st_estatus_registro from statictext within w_alumnos_restringidos
end type
type cb_actualizar from commandbutton within w_alumnos_restringidos
end type
type dw_alumno_restringido from datawindow within w_alumnos_restringidos
end type
type uo_1 from uo_nombre_alumno within w_alumnos_restringidos
end type
end forward

global type w_alumnos_restringidos from window
integer x = 846
integer y = 372
integer width = 3346
integer height = 1144
boolean titlebar = true
string title = "Captura de Alumnos de acceso Restringido"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
st_estatus_registro st_estatus_registro
cb_actualizar cb_actualizar
dw_alumno_restringido dw_alumno_restringido
uo_1 uo_1
end type
global w_alumnos_restringidos w_alumnos_restringidos

type variables
boolean ib_usuario_especial = false
long il_cuenta
end variables

on w_alumnos_restringidos.create
this.st_estatus_registro=create st_estatus_registro
this.cb_actualizar=create cb_actualizar
this.dw_alumno_restringido=create dw_alumno_restringido
this.uo_1=create uo_1
this.Control[]={this.st_estatus_registro,&
this.cb_actualizar,&
this.dw_alumno_restringido,&
this.uo_1}
end on

on w_alumnos_restringidos.destroy
destroy(this.st_estatus_registro)
destroy(this.cb_actualizar)
destroy(this.dw_alumno_restringido)
destroy(this.uo_1)
end on

event open;ib_usuario_especial= f_usuario_especial(gs_usuario)

end event

event doubleclicked;string ls_cuenta
long ll_rows, ll_newrow
int li_restringido
li_restringido = 1
ls_cuenta = uo_1.em_cuenta.text
if isnumber(ls_cuenta) then
	il_cuenta = long (ls_cuenta) 
	
	//**--**
	STRING ls_tipo_periodo
	// Se verifica el tipo de periodo.
	SELECT plan_estudios.tipo_periodo 
	INTO :ls_tipo_periodo
	FROM academicos, plan_estudios 
	WHERE academicos.cuenta = :il_cuenta 
	AND plan_estudios.cve_carrera = academicos.cve_carrera
	AND plan_estudios.cve_plan = academicos.cve_plan
	USING gtr_sce;
	// Se verifica si el alumno es del tipo 
	IF ls_tipo_periodo <> gs_tipo_periodo  THEN 
		MESSAGEBOX("Aviso", "El alumno con cuenta: " + STRING(il_cuenta) + " no es de plan de estudios " + gs_descripcion_tipo_periodo )  
		RETURN -1
	END IF
	//**--**	
	
	ll_rows = dw_alumno_restringido.Retrieve(il_cuenta)
	if ll_rows = 0 then
		ll_newrow = dw_alumno_restringido.InsertRow(0)
		dw_alumno_restringido.ScrollToRow(ll_newrow)
		dw_alumno_restringido.SetItem(ll_newrow, "cuenta", il_cuenta)		
		dw_alumno_restringido.SetItem(ll_newrow, "restringido", li_restringido)	
		cb_actualizar.text = "Registrar"
		st_estatus_registro.Text = "NUEVO"
		st_estatus_registro.TextColor = RGB(255,0,0)
	else
		cb_actualizar.text = "Actualizar"		
		st_estatus_registro.Text = "ANTERIOR"
		st_estatus_registro.TextColor = RGB(0,128,0)
	end if
else
	dw_alumno_restringido.Reset()
	MessageBox ("Alumno invalido", "Favor de seleccionar una alumno existente", StopSign!)
	return
end if
end event

event activate;integer li_indice
if not ib_usuario_especial then
	MessageBox("Usuario NO autorizado", &
	"Ventana de acceso restringido consulte a la Dirección de Servicios Escolares", StopSign!)
//	for li_indice = 1 to upperbound(controls)
//		control[li_indice].enabled = 0
//	next
end if

end event

type st_estatus_registro from statictext within w_alumnos_restringidos
integer x = 1161
integer y = 728
integer width = 987
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_actualizar from commandbutton within w_alumnos_restringidos
integer x = 1449
integer y = 892
integer width = 320
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar"
end type

event clicked;dw_alumno_restringido.event ue_actualiza()
end event

type dw_alumno_restringido from datawindow within w_alumnos_restringidos
event ue_actualiza ( )
integer x = 1161
integer y = 484
integer width = 987
integer height = 228
integer taborder = 20
string dataobject = "d_alumno_restringido"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_actualiza;integer li_resp, li_update, li_restringido
long ll_row
string ls_digito, ls_tipo_restriccion

dwItemStatus l_status

ll_row = dw_alumno_restringido.GetRow()

dw_alumno_restringido.AcceptText()

l_status = dw_alumno_restringido.GetItemStatus(ll_row, 0, Primary!)
li_restringido =dw_alumno_restringido.GetItemNumber(ll_row, "restringido")
ls_digito = obten_digito(il_cuenta)

if li_restringido <> 0 and li_restringido<>1 or isnull(li_restringido) then
	MessageBox("Error", "Es necesario elegir un valor para restringido", Information!)
	return
end if

if li_restringido = 0 then
	ls_tipo_restriccion= "NO RESTRINGIDO"
elseif li_restringido = 1 then
	ls_tipo_restriccion= "RESTRINGIDO"
end if

if l_status = New! or l_status = NewModified! then
	li_resp= MessageBox("Confirmación", "¿Desea registrar al alumno con cuenta ["+&
	           string(il_cuenta)+"-"+ls_digito+ "] como de acceso "+ls_tipo_restriccion+" ?", Question!, YesNo!)

elseif l_status = NotModified! then
	MessageBox("Información", "No se ha modificado al alumno con cuenta ["+&
	           string(il_cuenta)+"-"+ls_digito+ "]", Information!)
	return
elseif l_status = DataModified! then
	li_resp= MessageBox("Confirmación", "¿Desea modificar el acceso al alumno con cuenta ["+&
	           string(il_cuenta)+"-"+ls_digito+ "] a "+ ls_tipo_restriccion+"?", Question!, YesNo!)
	
end if

if li_resp = 1 then
	li_update = dw_alumno_restringido.Update()
	if li_update<> -1 then
		COMMIT USING gtr_sce;
		st_estatus_registro.Text = "ANTERIOR"
		st_estatus_registro.TextColor = RGB(0,128,0)
		MessageBox("Información", "Se ha actualizado la información", Information!)
	else
		ROLLBACK USING gtr_sce;
		MessageBox("Información", "No es posible actualizar la información", StopSign!)		
	end if	
end if



end event

event constructor;this.SetTransObject(gtr_sce)
end event

event dberror;

MessageBox("Error en la base de datos","Codigo ["+string(sqldbcode)+"]~n"+"Error"+sqlerrtext)


RETURN 0
end event

type uo_1 from uo_nombre_alumno within w_alumnos_restringidos
integer x = 32
integer y = 24
integer width = 3241
integer height = 424
integer taborder = 10
boolean enabled = true
end type

on uo_1.destroy
call uo_nombre_alumno::destroy
end on

