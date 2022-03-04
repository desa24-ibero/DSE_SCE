$PBExportHeader$w_hist_indulto_2.srw
forward
global type w_hist_indulto_2 from window
end type
type cb_1 from commandbutton within w_hist_indulto_2
end type
type uo_2 from uo_per_ani within w_hist_indulto_2
end type
type dw_1 from uo_dw_captura within w_hist_indulto_2
end type
type st_estatus_registro from statictext within w_hist_indulto_2
end type
type uo_1 from uo_nombre_alumno within w_hist_indulto_2
end type
end forward

global type w_hist_indulto_2 from window
integer x = 846
integer y = 372
integer width = 3383
integer height = 2180
boolean titlebar = true
string title = "Indultos"
string menuname = "m_menu"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
cb_1 cb_1
uo_2 uo_2
dw_1 dw_1
st_estatus_registro st_estatus_registro
uo_1 uo_1
end type
global w_hist_indulto_2 w_hist_indulto_2

type variables
boolean ib_modificado
long il_cuenta
integer ii_periodo, ii_anio

end variables

on w_hist_indulto_2.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_1=create cb_1
this.uo_2=create uo_2
this.dw_1=create dw_1
this.st_estatus_registro=create st_estatus_registro
this.uo_1=create uo_1
this.Control[]={this.cb_1,&
this.uo_2,&
this.dw_1,&
this.st_estatus_registro,&
this.uo_1}
end on

on w_hist_indulto_2.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.uo_2)
destroy(this.dw_1)
destroy(this.st_estatus_registro)
destroy(this.uo_1)
end on

event open;//ib_usuario_especial= f_usuario_especial(gs_usuario)
x= 1;y=1
end event

event doubleclicked;string ls_cuenta
long ll_rows, ll_newrow
int li_restringido
ii_periodo = gi_periodo
ii_anio = gi_anio
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

type cb_1 from commandbutton within w_hist_indulto_2
boolean visible = false
integer x = 1426
integer y = 488
integer width = 448
integer height = 112
integer taborder = 41
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Filtrar Periodo"
end type

event clicked;long ll_row
integer li_periodo, li_anio, li_confirmación
if isnull(il_cuenta) or il_cuenta = 0 then
	MessageBox("Cuenta no seleccionada","Favor de elegir a un alumno antes de cargar",StopSign!)
	return 0
end if
li_periodo = gi_periodo
li_anio = gi_anio

li_confirmación = MessageBox("Confirmación","¿Desea filtrar el periodo elegido?",Question!, YesNo!)
if li_confirmación <> 1 then
	return 0
end if

return dw_1.retrieve(il_cuenta, li_periodo, li_anio)
end event

type uo_2 from uo_per_ani within w_hist_indulto_2
integer x = 2025
integer y = 464
integer taborder = 31
boolean enabled = true
end type

on uo_2.destroy
call uo_per_ani::destroy
end on

type dw_1 from uo_dw_captura within w_hist_indulto_2
event type integer ue_valida ( )
integer x = 457
integer y = 692
integer width = 2478
integer height = 1220
integer taborder = 20
string dataobject = "dw_hist_indulto"
boolean hscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event type integer ue_valida();//Revisa que los registros sean lógicos y no estén repetidos
long ll_rows, ll_row_actual, ll_row_buscado
string ls_cve_indulto
string ls_busqueda_duplicado
integer li_periodo, li_anio
ll_rows = this.RowCount()
for ll_row_actual=1  to ll_rows
	ls_cve_indulto= this.GetItemString(ll_row_actual, "cve_indulto")
	li_periodo = this.GetItemNumber(ll_row_actual, "periodo")
	li_anio= this.GetItemNumber(ll_row_actual, "anio")
	if isnull(ls_cve_indulto) then
		ScrollToRow(ll_row_actual)	
		MessageBox("Indulto Incorrecto", "Favor de escribir un Indulto válido", StopSign!)
		return -1
	end if
	ls_busqueda_duplicado = 'cve_indulto = "'+ls_cve_indulto+'" and periodo = '+string(li_periodo)+' and anio = '+string(li_anio) 
	ll_row_buscado = find(ls_busqueda_duplicado,1, ll_rows)
	if ll_row_buscado <> 0 and ll_row_buscado <> ll_row_actual then
		ScrollToRow(ll_row_actual)	
		MessageBox("Indulto Duplicado", "Favor de escribir un Indulto distinto", StopSign!)
		return -1	
	end if
next

return 0
end event

event constructor;call super::constructor;this.SetTransObject(gtr_sce)
end event

event dberror;call super::dberror;MessageBox("Error en la base de datos","Codigo ["+string(sqldbcode)+"]~n"+"Error"+sqlerrtext)

RETURN 0
end event

event nuevo;long ll_row
if isnull(il_cuenta) or il_cuenta = 0 then
	MessageBox("Cuenta no seleccionada","Favor de elegir a un alumno antes de insertar",StopSign!)
	return
end if

//if ii_periodo <> gi_periodo or ii_anio <> gi_anio then
//	this.AcceptText()
//	if (this.ModifiedCount()+this.DeletedCount()) > 0 or this.RowCount()>0 Then
//		MessageBox("Periodos Combinados","Favor de guardar y presionar Cargar Periodo antes de Insertar",StopSign!)
//		return	
//	else
//		 this.event carga()
//	end if
//end if

setfocus()
scrolltorow(insertrow(0))
setcolumn(1)
ll_row= GetRow()
this.SetItem(ll_row, "cuenta", il_cuenta)
this.SetItem(ll_row, 'periodo', gi_periodo)
this.SetItem(ll_row, 'anio', gi_anio)
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
integer li_periodo, li_anio
if isnull(il_cuenta) or il_cuenta = 0 then
	MessageBox("Cuenta no seleccionada","Favor de elegir a un alumno antes de cargar",StopSign!)
	return 0
end if
li_periodo = gi_periodo
li_anio = gi_anio

return this.retrieve(il_cuenta, li_periodo, li_anio)
end event

type st_estatus_registro from statictext within w_hist_indulto_2
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

type uo_1 from uo_nombre_alumno within w_hist_indulto_2
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

