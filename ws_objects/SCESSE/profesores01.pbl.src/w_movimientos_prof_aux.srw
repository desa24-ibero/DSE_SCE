$PBExportHeader$w_movimientos_prof_aux.srw
forward
global type w_movimientos_prof_aux from window
end type
type cb_cerrar from commandbutton within w_movimientos_prof_aux
end type
type cb_actualizar from commandbutton within w_movimientos_prof_aux
end type
type dw_movimiento_prof_aux from datawindow within w_movimientos_prof_aux
end type
end forward

global type w_movimientos_prof_aux from window
integer x = 846
integer y = 372
integer width = 2226
integer height = 752
boolean titlebar = true
string title = "Movimientos a profesores auxiliares"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 26439467
boolean toolbarvisible = false
cb_cerrar cb_cerrar
cb_actualizar cb_actualizar
dw_movimiento_prof_aux dw_movimiento_prof_aux
end type
global w_movimientos_prof_aux w_movimientos_prof_aux

type variables
long il_contador_actualizaciones=0, il_cve_profesor,il_cve_profesor_ant
long il_cve_mat
integer ii_periodo, ii_anio, ii_cve_dia, ii_hora_inicio, ii_hora_final
string is_gpo, is_usuario, is_cve_mat_gpo

end variables

on w_movimientos_prof_aux.create
this.cb_cerrar=create cb_cerrar
this.cb_actualizar=create cb_actualizar
this.dw_movimiento_prof_aux=create dw_movimiento_prof_aux
this.Control[]={this.cb_cerrar,&
this.cb_actualizar,&
this.dw_movimiento_prof_aux}
end on

on w_movimientos_prof_aux.destroy
destroy(this.cb_cerrar)
destroy(this.cb_actualizar)
destroy(this.dw_movimiento_prof_aux)
end on

event open;long ll_row, ll_cve_profesor, ll_cve_profesor_ant, ll_insert
long ll_cve_mat
integer li_periodo, li_anio
string ls_gpo, ls_usuario

str_movimiento_prof_aux lstr_movimiento_prof_aux

lstr_movimiento_prof_aux = Message.PowerObjectParm

ll_cve_profesor  = lstr_movimiento_prof_aux.cve_profesor
ll_cve_profesor_ant  = lstr_movimiento_prof_aux.cve_prof_ant
ll_cve_mat = lstr_movimiento_prof_aux.cve_mat
ls_gpo = lstr_movimiento_prof_aux.gpo
li_periodo = lstr_movimiento_prof_aux.periodo
li_anio = lstr_movimiento_prof_aux.anio
ii_cve_dia = lstr_movimiento_prof_aux.cve_dia
ii_hora_inicio = lstr_movimiento_prof_aux.hora_inicio
ii_hora_final = lstr_movimiento_prof_aux.hora_final
ls_usuario = lstr_movimiento_prof_aux.usuario

il_cve_profesor = ll_cve_profesor 
il_cve_profesor_ant = ll_cve_profesor_ant
il_cve_mat = ll_cve_mat
is_gpo = ls_gpo
ii_periodo = li_periodo
ii_anio = li_anio
is_usuario = ls_usuario
is_cve_mat_gpo = string(ll_cve_mat)+ls_gpo

dw_movimiento_prof_aux.Event ue_nuevo()

end event

event closequery;integer li_confirmacion
long ll_rows_modificados, ll_rows_borrados

ll_rows_modificados = dw_movimiento_prof_aux.ModifiedCount()
ll_rows_borrados = dw_movimiento_prof_aux.DeletedCount()

//li_confirmacion = MessageBox("Confirmar Salida",&
//         "¿Desea salir de la captura de movimientos?"+"M:"+string(ll_rows_modificados)+" D:"+string(ll_rows_borrados), Question!, YesNo!)

li_confirmacion = MessageBox("Confirmar Salida",&
         "¿Desea salir de la captura de movimientos con ["+string(il_contador_actualizaciones)+"] operacion(es) registrada(s)?", Question!, YesNo!)

if li_confirmacion = 2 then
//No cierra la ventana
	return 1
else
//Cierra la ventana
	return 0	
end if
end event

event close;CloseWithReturn(this, il_contador_actualizaciones)

end event

type cb_cerrar from commandbutton within w_movimientos_prof_aux
integer x = 1088
integer y = 484
integer width = 320
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar"
end type

event clicked;//	CloseWithReturn(parent, il_contador_actualizaciones)
close(parent)
end event

type cb_actualizar from commandbutton within w_movimientos_prof_aux
integer x = 645
integer y = 484
integer width = 320
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar"
end type

event clicked;integer li_update, li_valida

li_valida = dw_movimiento_prof_aux.Event ue_valida_dw()

if li_valida <> -1 then
	
	li_update = dw_movimiento_prof_aux.Update(true, true)
	
	if dw_movimiento_prof_aux.GetItemNumber(1,"cve_movimiento")= 0 then w_grupos_prof.dw_profesor_auxiliar.TriggerEvent("borra_actual")

	if li_update <> -1 then
		COMMIT USING gtr_sce;
		MessageBox ("Actualizacion exitosa", "Se ha almacenado el movimiento", Information!)
		il_contador_actualizaciones = il_contador_actualizaciones +1
		dw_movimiento_prof_aux.Reset()
		dw_movimiento_prof_aux.Event ue_nuevo()
	else
		ROLLBACK USING gtr_sce;
		MessageBox ("No es posible registrar", "NO se ha almacenado el movimiento", StopSign!)
	end if
end if


end event

type dw_movimiento_prof_aux from datawindow within w_movimientos_prof_aux
event type integer ue_valida_dw ( )
event ue_nuevo ( )
integer x = 96
integer y = 60
integer width = 2007
integer height = 368
integer taborder = 10
string dataobject = "d_movimiento_prof_aux"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_valida_dw;long ll_row
datetime ldttm_fecha_movimiento, ldttm_fecha_null
integer li_movimiento, li_null, li_confirmacion
date ldt_fecha_movimiento, ldt_fecha_null
SetNull(ldttm_fecha_null)
SetNull(ldt_fecha_null)
SetNull(li_null)

for ll_row = 1 to  this.RowCount()
	ldttm_fecha_movimiento = this.GetItemDatetime(ll_row,"fecha_movimiento")
	ldt_fecha_movimiento = Date(ldttm_fecha_movimiento)
//	ldt_fecha_movimiento = this.GetItemDate(ll_row,"fecha_movimiento")
	li_movimiento = this.GetItemNumber(ll_row,"cve_movimiento")
	if isnull(ldt_fecha_movimiento) or ldt_fecha_movimiento= ldt_fecha_null or &
		not isdate(string(ldt_fecha_movimiento))  then
		MessageBox ("Error", "La fecha del movimiento capturado no es valida", StopSign!)		
		return -1		
	end if	
	if isnull(li_movimiento) or li_movimiento= li_null or &
		li_movimiento > 1 or li_movimiento < 0 then
		MessageBox ("Error", "El tipo de movimiento capturado no es valido", StopSign!)		
		return -1		
	end if
next

if il_contador_actualizaciones> 0 then 
	li_confirmacion = MessageBox ("Movimiento Recapturado", "Se ha(n) capturado ["+string(il_contador_actualizaciones)+"] movimiento(s) en esta sesion.~n"+&
	                             "¿Desea registrar otro movimiento?", Question!, YesNo!)		
	if li_confirmacion <>1 then
		return -1	
	else
		return 1
	end if
end if

return 1
end event

event ue_nuevo();long ll_insert, ll_row

ll_insert = dw_movimiento_prof_aux.InsertRow(0)
if ll_insert>= 0 then
	ll_row = dw_movimiento_prof_aux.GetRow()
	dw_movimiento_prof_aux.SetItem(ll_row, "cve_profesor", il_cve_profesor)
	dw_movimiento_prof_aux.SetItem(ll_row, "cve_prof_ant", il_cve_profesor_ant)
	dw_movimiento_prof_aux.SetItem(ll_row, "cve_mat", il_cve_mat)
	dw_movimiento_prof_aux.SetItem(ll_row, "gpo", is_gpo)
	dw_movimiento_prof_aux.SetItem(ll_row, "periodo", ii_periodo)
	dw_movimiento_prof_aux.SetItem(ll_row, "anio", ii_anio)
	dw_movimiento_prof_aux.SetItem(ll_row, "cve_dia", ii_cve_dia)
	dw_movimiento_prof_aux.SetItem(ll_row, "hora_inicio", ii_hora_inicio)
	dw_movimiento_prof_aux.SetItem(ll_row, "hora_final", ii_hora_final)
	dw_movimiento_prof_aux.SetItem(ll_row, "usuario", is_usuario)
	dw_movimiento_prof_aux.SetItem(ll_row, "cve_mat_gpo", is_cve_mat_gpo)
end if

end event

event constructor;this.SetTransObject(gtr_sce)

end event

