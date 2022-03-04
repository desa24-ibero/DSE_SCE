$PBExportHeader$w_alumnos_baja_laboratorio.srw
forward
global type w_alumnos_baja_laboratorio from window
end type
type st_replica from statictext within w_alumnos_baja_laboratorio
end type
type dw_1 from uo_dw_captura within w_alumnos_baja_laboratorio
end type
type st_estatus_registro from statictext within w_alumnos_baja_laboratorio
end type
type uo_1 from uo_nombre_alumno within w_alumnos_baja_laboratorio
end type
end forward

global type w_alumnos_baja_laboratorio from window
integer x = 846
integer y = 372
integer width = 3515
integer height = 1516
boolean titlebar = true
string title = "Captura de Alumnos con Baja de Laboratorio"
string menuname = "m_menu"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
st_replica st_replica
dw_1 dw_1
st_estatus_registro st_estatus_registro
uo_1 uo_1
end type
global w_alumnos_baja_laboratorio w_alumnos_baja_laboratorio

type variables
boolean ib_usuario_especial = false
long il_cuenta
end variables

on w_alumnos_baja_laboratorio.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.st_replica=create st_replica
this.dw_1=create dw_1
this.st_estatus_registro=create st_estatus_registro
this.uo_1=create uo_1
this.Control[]={this.st_replica,&
this.dw_1,&
this.st_estatus_registro,&
this.uo_1}
end on

on w_alumnos_baja_laboratorio.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_replica)
destroy(this.dw_1)
destroy(this.st_estatus_registro)
destroy(this.uo_1)
end on

event open;//ib_usuario_especial= f_usuario_especial(gs_usuario)

end event

event doubleclicked;string ls_cuenta
long ll_rows, ll_newrow
int li_restringido
li_restringido = 1
ls_cuenta = uo_1.em_cuenta.text
if isnumber(ls_cuenta) then
	il_cuenta = long (ls_cuenta)
	ll_rows = dw_1.Event carga()
//	if ll_rows = 0 then
//		ll_newrow = dw_alumno_baja_laboratorio.InsertRow(0)
//		dw_alumno_baja_laboratorio.ScrollToRow(ll_newrow)
//		dw_alumno_baja_laboratorio.SetItem(ll_newrow, "cuenta", il_cuenta)		
//		dw_alumno_baja_laboratorio.SetItem(ll_newrow, "restringido", li_restringido)	
//		cb_actualizar.text = "Registrar"
//		st_estatus_registro.Text = "NUEVO"
//		st_estatus_registro.TextColor = RGB(255,0,0)
//	else
//		cb_actualizar.text = "Actualizar"		
//		st_estatus_registro.Text = "ANTERIOR"
//		st_estatus_registro.TextColor = RGB(0,128,0)
//	end if
else
	dw_1.Reset()
	MessageBox ("Alumno invalido", "Favor de seleccionar una alumno existente", StopSign!)
	return
end if
end event

event activate;//integer li_indice
//if not ib_usuario_especial then
//	MessageBox("Usuario NO autorizado", &
//	"Ventana de acceso restringido consulte a la Dirección de Servicios Escolares", StopSign!)
////	for li_indice = 1 to upperbound(controls)
////		control[li_indice].enabled = 0
////	next
//end if

end event

type st_replica from statictext within w_alumnos_baja_laboratorio
integer x = 3323
integer y = 24
integer width = 110
integer height = 88
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
alignment alignment = center!
boolean focusrectangle = false
end type

event constructor;n_transfiere_sybase_sql ln_transfiere_sybase_sql
ln_transfiere_sybase_sql =  create n_transfiere_sybase_sql
integer li_replica_activa, li_obten_parametros_replicacion
li_obten_parametros_replicacion = ln_transfiere_sybase_sql.of_obten_parametros_replica(li_replica_activa)
if li_replica_activa = 1 then
	THIS.text = 'A'
	THIS.BackColor =RGB(0,255,0)
else
	THIS.text = 'I'
	THIS.BackColor =RGB(255,0,0)
end if

end event

type dw_1 from uo_dw_captura within w_alumnos_baja_laboratorio
event type integer ue_valida ( )
integer x = 978
integer y = 516
integer width = 1445
integer height = 560
integer taborder = 20
string dataobject = "d_alumno_baja_laboratorio"
boolean hscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event ue_valida;//Revisa que los registros sean lógicos y no estén repetidos
long ll_rows, ll_row_actual, ll_row_buscado
integer ll_cve_laboratorio
string ls_busqueda_duplicado
ll_rows = this.RowCount()
for ll_row_actual=1  to ll_rows
	ll_cve_laboratorio= this.GetItemNumber(ll_row_actual, "cve_laboratorio")
	if isnull(ll_cve_laboratorio) then
		ScrollToRow(ll_row_actual)	
		MessageBox("Laboratorio Incorrecto", "Favor de escribir un laboratorio válido", StopSign!)
		return -1
	end if
	ls_busqueda_duplicado = 'cve_laboratorio = '+string(ll_cve_laboratorio)
	ll_row_buscado = find(ls_busqueda_duplicado,1, ll_rows)
	if ll_row_buscado <> 0 and ll_row_buscado <> ll_row_actual then
		ScrollToRow(ll_row_actual)	
		MessageBox("Laboratorio Duplicado", "Favor de escribir un laboratorio distinto", StopSign!)
		return -1	
	end if
next

return 0
end event

event constructor;call super::constructor;this.SetTransObject(gtr_sce)
end event

event retrieveend;call super::retrieveend;integer li_baja_laboratorio 

li_baja_laboratorio = f_obten_baja_laboratorio(il_cuenta)

if li_baja_laboratorio= 1 then
		st_estatus_registro.Text = "BLOQUEADO"
		st_estatus_registro.TextColor = RGB(255,0,0)
elseif li_baja_laboratorio= 0 then
		st_estatus_registro.Text = "DESBLOQUEADO"
		st_estatus_registro.TextColor = RGB(0,128,0)
elseif li_baja_laboratorio= -1 then
		st_estatus_registro.Text = ""
		st_estatus_registro.TextColor = RGB(0,0,0)	
end if

end event

event dberror;call super::dberror;MessageBox("Error en la base de datos","Codigo ["+string(sqldbcode)+"]~n"+"Error"+sqlerrtext)

RETURN 0
end event

event nuevo;long ll_row
if isnull(il_cuenta) or il_cuenta = 0 then
	MessageBox("Cuenta no seleccionada","Favor de elegir a un alumno antes de insertar",StopSign!)
	return
end if
setfocus()
scrolltorow(insertrow(0))
setcolumn(1)
ll_row= GetRow()
this.SetItem(ll_row, "cuenta", il_cuenta)
end event

event borra;long ll_row
if isnull(il_cuenta) or il_cuenta = 0 then
	MessageBox("Cuenta no seleccionada","Favor de elegir a un alumno antes de borrar",StopSign!)
	return
end if


int li_respuesta
li_respuesta = messagebox("Atención","Esta seguro de querer borrar el campo actual.",Question!,YesNo!,2)

if li_respuesta = 1 then
	if deleterow(getrow())	= 1 then
		if this.event ue_valida()<> -1 then

			if this.Update()=1 then
				commit using gtr_sce;
				messagebox("Información","Se ha eliminado el registro exitosamente",Information!)	
				event carga()
			else
				rollback using gtr_sce;
				messagebox("Error al Actualizar","NO se ha eliminado el registro",StopSign!)	
				event carga()
			end if
		else
			return 
		end if
	else
		messagebox("Información","No se han guardado los cambios", Information!)	
	end if
elseif li_respuesta = 2 then
		messagebox("Información","No se han guardado los cambios", Information!)	
end if

return
end event

event actualiza;long ll_row
if isnull(il_cuenta) or il_cuenta = 0 then
	MessageBox("Cuenta no seleccionada","Favor de elegir a un alumno antes de actualizar",StopSign!)
	return 0
end if

int li_respuesta
//Acepta el texto de la última columna editada
AcceptText()

//Pregunta si se desean guardar los cambios hechos
	li_respuesta = messagebox("Atención","Desea actualizar los cambios:",Question!,YesNo!,2)

	if li_respuesta = 1 then
		if this.event ue_valida()<> -1 then
//			Checa que los renglones cumplan con las reglas de validación
			if this.Update() = 1 then		//Manda llamar la función que realiza el update
				commit using gtr_sce;

				//INICIO:Replica a Internet
				transaction ltr_web
				n_transfiere_sybase_sql ln_transfiere_sybase_sql
				ln_transfiere_sybase_sql =  create n_transfiere_sybase_sql
				string ls_classname
				long ll_cuentas[]
				integer li_replica_activa, li_obten_parametros_replicacion, li_res_actualizacion
					li_obten_parametros_replicacion = ln_transfiere_sybase_sql.of_obten_parametros_replica(li_replica_activa)
					if li_replica_activa = 1 then
						parent.st_replica.text = 'A'
						parent.st_replica.BackColor =RGB(0,255,0)
						ls_classname =	parent.ClassName()
						ll_cuentas[1] = il_cuenta
						li_res_actualizacion = ln_transfiere_sybase_sql.of_actualizacion_objeto_replica(ll_cuentas, ls_classname, gtr_sce, ltr_web)
					else
						parent.st_replica.text = 'I'
						parent.st_replica.BackColor =RGB(255,0,0)
					end if
				//FIN:Replica a Internet				
				
				event carga()
				return 1
			else 
				rollback using gtr_sce;
				event carga()
				return -1
			end if
		else
			return -1
		end if
	else
//		De lo contrario, solo avisa que no se guardó nada.
		messagebox("Información","No se han guardado los cambios", Information!)
		return -1
	end if

end event

event carga;long ll_row
if isnull(il_cuenta) or il_cuenta = 0 then
	MessageBox("Cuenta no seleccionada","Favor de elegir a un alumno antes de cargar",StopSign!)
	return 0
end if

return this.retrieve(il_cuenta)
end event

type st_estatus_registro from statictext within w_alumnos_baja_laboratorio
integer x = 1285
integer y = 1136
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

type uo_1 from uo_nombre_alumno within w_alumnos_baja_laboratorio
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

