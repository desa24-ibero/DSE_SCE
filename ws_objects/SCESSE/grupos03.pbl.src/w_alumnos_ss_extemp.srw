$PBExportHeader$w_alumnos_ss_extemp.srw
forward
global type w_alumnos_ss_extemp from window
end type
type st_replica from statictext within w_alumnos_ss_extemp
end type
type uo_nombre from uo_nombre_alumno_opc_cero within w_alumnos_ss_extemp
end type
type uo_periodo from uo_per_ani within w_alumnos_ss_extemp
end type
type st_estatus_registro from statictext within w_alumnos_ss_extemp
end type
type cb_actualizar from commandbutton within w_alumnos_ss_extemp
end type
type dw_alumno_ss from datawindow within w_alumnos_ss_extemp
end type
end forward

global type w_alumnos_ss_extemp from window
integer x = 846
integer y = 372
integer width = 3442
integer height = 1308
boolean titlebar = true
string title = "Captura de Servicio Social Extemporaneo"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
st_replica st_replica
uo_nombre uo_nombre
uo_periodo uo_periodo
st_estatus_registro st_estatus_registro
cb_actualizar cb_actualizar
dw_alumno_ss dw_alumno_ss
end type
global w_alumnos_ss_extemp w_alumnos_ss_extemp

type variables
boolean ib_usuario_especial = false
long il_cuenta
end variables

on w_alumnos_ss_extemp.create
this.st_replica=create st_replica
this.uo_nombre=create uo_nombre
this.uo_periodo=create uo_periodo
this.st_estatus_registro=create st_estatus_registro
this.cb_actualizar=create cb_actualizar
this.dw_alumno_ss=create dw_alumno_ss
this.Control[]={this.st_replica,&
this.uo_nombre,&
this.uo_periodo,&
this.st_estatus_registro,&
this.cb_actualizar,&
this.dw_alumno_ss}
end on

on w_alumnos_ss_extemp.destroy
destroy(this.st_replica)
destroy(this.uo_nombre)
destroy(this.uo_periodo)
destroy(this.st_estatus_registro)
destroy(this.cb_actualizar)
destroy(this.dw_alumno_ss)
end on

event open;this.x = 1
this.y = 1

uo_nombre.em_cuenta.text = " "

uo_nombre.dw_nombre_alumno.enabled = true
uo_nombre.dw_nombre_alumno.TabOrder = 45	
end event

event doubleclicked;string ls_cuenta
long ll_rows, ll_newrow
int li_activo, li_res_academicos
long  ll_cve_carrera, ll_cve_plan, ll_cve_subsistema
string ls_nivel
long ll_row, ll_cuenta, ll_sss_proyecto_id

ll_row = uo_nombre.dw_nombre_alumno.GetRow()
ll_cuenta = uo_nombre.dw_nombre_alumno.GetItemNumber(ll_row, "cuenta")

li_activo = 1
ls_cuenta = uo_nombre.em_cuenta.text

if isnumber(ls_cuenta) then
	il_cuenta = long (ls_cuenta)
	li_res_academicos = f_obten_carrera_plan_sub_niv( il_cuenta, ll_cve_carrera, ll_cve_plan, ll_cve_subsistema, ls_nivel)
	if li_res_academicos<> -1 then
		//if ls_nivel = 'L' then
		if ls_nivel <> 'P' then 
			ll_rows = dw_alumno_ss.Retrieve(il_cuenta, gi_periodo, gi_anio )
			if ll_rows = 0 then
				ll_sss_proyecto_id = 9999
				ll_newrow = dw_alumno_ss.InsertRow(0)
				dw_alumno_ss.ScrollToRow(ll_newrow)
				dw_alumno_ss.SetItem(ll_newrow, "cuenta", il_cuenta)		
				dw_alumno_ss.SetItem(ll_newrow, "cve_carrera", ll_cve_carrera)		
				dw_alumno_ss.SetItem(ll_newrow, "sss_alumno_plaza_act", li_activo)	
				dw_alumno_ss.SetItem(ll_newrow, "sss_proyecto_id", ll_sss_proyecto_id)					
				cb_actualizar.text = "Registrar"
				st_estatus_registro.Text = "NUEVO"
				st_estatus_registro.TextColor = RGB(255,0,0)
			else
				cb_actualizar.text = "Actualizar"		
				st_estatus_registro.Text = "ANTERIOR"
				st_estatus_registro.TextColor = RGB(0,128,0)
			end if
		else
			uo_nombre.dw_nombre_alumno.Reset()	
			uo_nombre.dw_nombre_alumno.insertrow(0)
			uo_nombre.em_digito.text=" "
			uo_nombre.em_cuenta.text = " "
			uo_nombre.em_cuenta.setfocus()

			dw_alumno_ss.Reset()
			MessageBox ("Alumno invalido", "No se permiten alumnos de posgrado", StopSign!)
			return		
		end if
	end if
else
	uo_nombre.dw_nombre_alumno.Reset()	
	uo_nombre.dw_nombre_alumno.insertrow(0)
	uo_nombre.em_digito.text=" "
	uo_nombre.em_cuenta.text = " "
	uo_nombre.em_cuenta.setfocus()
	
	dw_alumno_ss.Reset()
	MessageBox ("Alumno invalido", "Favor de seleccionar una alumno existente", StopSign!)
	return
end if
end event

type st_replica from statictext within w_alumnos_ss_extemp
integer x = 3269
integer y = 28
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

type uo_nombre from uo_nombre_alumno_opc_cero within w_alumnos_ss_extemp
integer x = 41
integer y = 28
integer taborder = 50
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alumno_opc_cero::destroy
end on

type uo_periodo from uo_per_ani within w_alumnos_ss_extemp
integer x = 1998
integer y = 920
integer taborder = 30
boolean enabled = true
end type

on uo_periodo.destroy
call uo_per_ani::destroy
end on

type st_estatus_registro from statictext within w_alumnos_ss_extemp
integer x = 1147
integer y = 808
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

type cb_actualizar from commandbutton within w_alumnos_ss_extemp
integer x = 1481
integer y = 948
integer width = 320
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar"
end type

event clicked;dw_alumno_ss.event ue_actualiza()
end event

type dw_alumno_ss from datawindow within w_alumnos_ss_extemp
event ue_actualiza ( )
integer x = 480
integer y = 496
integer width = 2322
integer height = 228
integer taborder = 20
string dataobject = "d_alumno_ss_extemp"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_actualiza();integer li_resp, li_update, li_sss_alumno_plaza_act, li_periodo, li_anio
long ll_row
string ls_digito, ls_tipo_restriccion, ls_periodo

dwItemStatus l_status

uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios

ll_row = this.GetRow()

IF ll_row = 0 THEN RETURN

this.AcceptText()


l_status = this.GetItemStatus(ll_row, 0, Primary!)
li_sss_alumno_plaza_act =this.GetItemNumber(ll_row, "sss_alumno_plaza_act")
ls_digito = obten_digito(il_cuenta)

if li_sss_alumno_plaza_act <> 0 and li_sss_alumno_plaza_act<>1 or isnull(li_sss_alumno_plaza_act) then
	MessageBox("Error", "Es necesario elegir un valor para Activo", Information!)
	return
end if

if li_sss_alumno_plaza_act = 0 then
	ls_tipo_restriccion= "NO ACTIVO"
elseif li_sss_alumno_plaza_act = 1 then
	ls_tipo_restriccion= "ACTIVO"
end if

li_periodo = gi_periodo
li_anio = gi_anio

ls_periodo = luo_periodo_servicios.f_recupera_desc_periodo(gtr_sce, li_periodo)

IF luo_periodo_servicios.ierror = -1 THEN 
	MessageBox(luo_periodo_servicios.ititulo, luo_periodo_servicios.imensaje, StopSign!)
	RETURN 
END IF	

//CHOOSE CASE li_periodo
//	CASE 0
//		ls_periodo = "Primavera"
//	CASE 1
//		ls_periodo = "Verano"
//	CASE 2
//		ls_periodo = "Otoño"
//END CHOOSE

if l_status = New! or l_status = NewModified! then
	li_resp= MessageBox("Confirmación", "¿Desea registrar al alumno con cuenta ["+&
	           string(il_cuenta)+"-"+ls_digito+ "] con servicio social "+ls_tipo_restriccion+ &
				" para el periodo ["+ls_periodo+"-"+string(li_anio)+"] ?", Question!, YesNo!)

elseif l_status = NotModified! then
	MessageBox("Información", "No se ha modificado al alumno con cuenta ["+&
	           string(il_cuenta)+"-"+ls_digito+ "]", Information!)
	return
elseif l_status = DataModified! then
	li_resp= MessageBox("Confirmación", "¿Desea modificar el servicio social del alumno con cuenta ["+&
	           string(il_cuenta)+"-"+ls_digito+ "] con servicio social "+ ls_tipo_restriccion+ &
				" para el periodo ["+ls_periodo+"-"+string(li_anio)+"] ?", Question!, YesNo!)
	
end if

this.SetItem(this.Getrow(),"periodo", li_periodo)
this.SetItem(this.Getrow(),"anio", li_anio)


if li_resp = 1 then
	li_update = this.Update()
	if li_update<> -1 then
		COMMIT USING gtr_sce;
		
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

