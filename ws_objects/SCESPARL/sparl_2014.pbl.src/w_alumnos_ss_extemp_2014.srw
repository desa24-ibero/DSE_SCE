$PBExportHeader$w_alumnos_ss_extemp_2014.srw
forward
global type w_alumnos_ss_extemp_2014 from window
end type
type st_sistema from statictext within w_alumnos_ss_extemp_2014
end type
type p_ibero from picture within w_alumnos_ss_extemp_2014
end type
type uo_nombre from uo_carreras_alumno_lista within w_alumnos_ss_extemp_2014
end type
type uo_periodo from uo_per_ani within w_alumnos_ss_extemp_2014
end type
type st_estatus_registro from statictext within w_alumnos_ss_extemp_2014
end type
type cb_actualizar from commandbutton within w_alumnos_ss_extemp_2014
end type
type dw_alumno_ss from datawindow within w_alumnos_ss_extemp_2014
end type
end forward

global type w_alumnos_ss_extemp_2014 from window
integer x = 846
integer y = 372
integer width = 3346
integer height = 1900
boolean titlebar = true
string title = "Captura de Servicio Social Extemporaneo"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 16777215
st_sistema st_sistema
p_ibero p_ibero
uo_nombre uo_nombre
uo_periodo uo_periodo
st_estatus_registro st_estatus_registro
cb_actualizar cb_actualizar
dw_alumno_ss dw_alumno_ss
end type
global w_alumnos_ss_extemp_2014 w_alumnos_ss_extemp_2014

type variables
boolean ib_usuario_especial = false
long il_cuenta
end variables

on w_alumnos_ss_extemp_2014.create
this.st_sistema=create st_sistema
this.p_ibero=create p_ibero
this.uo_nombre=create uo_nombre
this.uo_periodo=create uo_periodo
this.st_estatus_registro=create st_estatus_registro
this.cb_actualizar=create cb_actualizar
this.dw_alumno_ss=create dw_alumno_ss
this.Control[]={this.st_sistema,&
this.p_ibero,&
this.uo_nombre,&
this.uo_periodo,&
this.st_estatus_registro,&
this.cb_actualizar,&
this.dw_alumno_ss}
end on

on w_alumnos_ss_extemp_2014.destroy
destroy(this.st_sistema)
destroy(this.p_ibero)
destroy(this.uo_nombre)
destroy(this.uo_periodo)
destroy(this.st_estatus_registro)
destroy(this.cb_actualizar)
destroy(this.dw_alumno_ss)
end on

event open;this.x = 1
this.y = 1

uo_nombre.em_cuenta.text = " "

end event

event doubleclicked;string ls_cuenta
long ll_rows, ll_newrow
int li_activo, li_vigente
long  ll_carrera
string ls_nivel
long ll_row, ll_cuenta, ll_sss_proyecto_id

il_cuenta = long(uo_nombre.of_obten_cuenta())
ll_carrera = uo_nombre.istr_carrera.str_cve_carrera
ls_nivel = uo_nombre.istr_carrera.str_nivel
li_vigente = uo_nombre.istr_carrera.str_vigente

li_activo = 1

if li_vigente = 0 then
	messagebox('Aviso','La carrera del alumno tiene que ser la vigente')
	return
end if

if ls_nivel = 'L' or  ls_nivel = 'T' then
	ll_rows = dw_alumno_ss.Retrieve(il_cuenta, gi_periodo, gi_anio )
	if ll_rows = 0 then
		ll_sss_proyecto_id = 9999
		ll_newrow = dw_alumno_ss.InsertRow(0)
		dw_alumno_ss.ScrollToRow(ll_newrow)
		dw_alumno_ss.SetItem(ll_newrow, "cuenta", il_cuenta)		
		dw_alumno_ss.SetItem(ll_newrow, "cve_carrera", ll_carrera)		
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

end event

type st_sistema from statictext within w_alumnos_ss_extemp_2014
integer x = 800
integer y = 128
integer width = 229
integer height = 100
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 16777215
string text = "DSE"
boolean focusrectangle = false
end type

type p_ibero from picture within w_alumnos_ss_extemp_2014
integer x = 55
integer y = 44
integer width = 681
integer height = 264
boolean bringtotop = true
string picturename = "logoibero-web.png"
boolean focusrectangle = false
end type

type uo_nombre from uo_carreras_alumno_lista within w_alumnos_ss_extemp_2014
integer x = 55
integer y = 420
integer taborder = 30
end type

on uo_nombre.destroy
call uo_carreras_alumno_lista::destroy
end on

type uo_periodo from uo_per_ani within w_alumnos_ss_extemp_2014
integer x = 1998
integer y = 1468
integer taborder = 30
boolean enabled = true
end type

on uo_periodo.destroy
call uo_per_ani::destroy
end on

type st_estatus_registro from statictext within w_alumnos_ss_extemp_2014
integer x = 1147
integer y = 1356
integer width = 987
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_actualizar from commandbutton within w_alumnos_ss_extemp_2014
integer x = 1481
integer y = 1496
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

type dw_alumno_ss from datawindow within w_alumnos_ss_extemp_2014
event ue_actualiza ( )
integer x = 507
integer y = 1044
integer width = 2322
integer height = 228
integer taborder = 20
string dataobject = "d_alumno_ss_extemp_2014"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_actualiza();integer li_resp, li_update, li_sss_alumno_plaza_act, li_periodo, li_anio
long ll_row
string ls_digito, ls_tipo_restriccion, ls_periodo

dwItemStatus l_status

ll_row = this.GetRow()

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

CHOOSE CASE li_periodo
	CASE 0
		ls_periodo = "Primavera"
	CASE 1
		ls_periodo = "Verano"
	CASE 2
		ls_periodo = "Otoño"
END CHOOSE

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

