$PBExportHeader$w_seleccion_jurado.srw
forward
global type w_seleccion_jurado from w_response
end type
type cb_suplente_2 from u_cb within w_seleccion_jurado
end type
type cb_suplente_1 from u_cb within w_seleccion_jurado
end type
type cb_secretario from u_cb within w_seleccion_jurado
end type
type cb_vocal from u_cb within w_seleccion_jurado
end type
type cb_presidente from u_cb within w_seleccion_jurado
end type
type dw_jurado from u_dw within w_seleccion_jurado
end type
type uo_nombre_profesor_i from uo_nombre_profesor within w_seleccion_jurado
end type
type cb_cerrar from u_cb within w_seleccion_jurado
end type
end forward

global type w_seleccion_jurado from w_response
integer width = 3003
integer height = 1040
string title = "Diagnóstico del Alumno"
boolean controlmenu = false
boolean ib_disableclosequery = true
cb_suplente_2 cb_suplente_2
cb_suplente_1 cb_suplente_1
cb_secretario cb_secretario
cb_vocal cb_vocal
cb_presidente cb_presidente
dw_jurado dw_jurado
uo_nombre_profesor_i uo_nombre_profesor_i
cb_cerrar cb_cerrar
end type
global w_seleccion_jurado w_seleccion_jurado

type variables

str_jurado_posgrado ist_parametros
end variables

on w_seleccion_jurado.create
int iCurrent
call super::create
this.cb_suplente_2=create cb_suplente_2
this.cb_suplente_1=create cb_suplente_1
this.cb_secretario=create cb_secretario
this.cb_vocal=create cb_vocal
this.cb_presidente=create cb_presidente
this.dw_jurado=create dw_jurado
this.uo_nombre_profesor_i=create uo_nombre_profesor_i
this.cb_cerrar=create cb_cerrar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_suplente_2
this.Control[iCurrent+2]=this.cb_suplente_1
this.Control[iCurrent+3]=this.cb_secretario
this.Control[iCurrent+4]=this.cb_vocal
this.Control[iCurrent+5]=this.cb_presidente
this.Control[iCurrent+6]=this.dw_jurado
this.Control[iCurrent+7]=this.uo_nombre_profesor_i
this.Control[iCurrent+8]=this.cb_cerrar
end on

on w_seleccion_jurado.destroy
call super::destroy
destroy(this.cb_suplente_2)
destroy(this.cb_suplente_1)
destroy(this.cb_secretario)
destroy(this.cb_vocal)
destroy(this.cb_presidente)
destroy(this.dw_jurado)
destroy(this.uo_nombre_profesor_i)
destroy(this.cb_cerrar)
end on

event open;long ll_row

x=1	
y=1

dw_jurado.SetTransObject(gtr_sce)
dw_jurado.InsertRow(0)

//Lee los valores recibidos por la ventana anterior

if dw_jurado.RowCount()>0 then
	ll_row = dw_jurado.GetRow()
	ist_parametros = Message.PowerObjectParm	
	dw_jurado.SetItem(ll_row, "cve_presidente", ist_parametros.cve_presidente )
	dw_jurado.SetItem(ll_row, "cve_vocal", ist_parametros.cve_vocal )
	dw_jurado.SetItem(ll_row, "cve_secretario", ist_parametros.cve_secretario )
	dw_jurado.SetItem(ll_row, "cve_suplente_1", ist_parametros.cve_suplente_1 )
	dw_jurado.SetItem(ll_row, "cve_suplente_2", ist_parametros.cve_suplente_2 )
	dw_jurado.SetItem(ll_row, "nombre_presidente", ist_parametros.nombre_presidente )
	dw_jurado.SetItem(ll_row, "nombre_vocal", ist_parametros.nombre_vocal )
	dw_jurado.SetItem(ll_row, "nombre_secretario", ist_parametros.nombre_secretario )
	dw_jurado.SetItem(ll_row, "nombre_suplente_1", ist_parametros.nombre_suplente_1 )
	dw_jurado.SetItem(ll_row, "nombre_suplente_2", ist_parametros.nombre_suplente_2 )

end if
end event

type cb_suplente_2 from u_cb within w_seleccion_jurado
integer x = 64
integer y = 652
integer width = 334
integer height = 88
integer taborder = 50
string text = "Suplente 2=>"
end type

event clicked;call super::clicked;long ll_row, ll_cve_profesor
string ls_nombre_completo

if dw_jurado.RowCount()>0 then
	ll_row = dw_jurado.GetRow()
	ll_cve_profesor = uo_nombre_profesor_i.of_obten_cve_profesor()
	ls_nombre_completo = uo_nombre_profesor_i.of_obten_nombre_completo()
	if ll_cve_profesor = 0 then
		MessageBox("Profesor Inválido", "Por favor seleccione otro profesor", StopSign!)
		return
	end if
	
	ist_parametros.cve_suplente_2 = ll_cve_profesor
	ist_parametros.nombre_suplente_2 = ls_nombre_completo
	dw_jurado.SetItem(ll_row,"cve_suplente_2",ll_cve_profesor)
	dw_jurado.SetItem(ll_row,"nombre_suplente_2",ls_nombre_completo)		
	
end if

end event

type cb_suplente_1 from u_cb within w_seleccion_jurado
integer x = 64
integer y = 552
integer width = 334
integer height = 88
integer taborder = 40
string text = "Suplente 1=>"
end type

event clicked;call super::clicked;long ll_row, ll_cve_profesor
string ls_nombre_completo

if dw_jurado.RowCount()>0 then
	ll_row = dw_jurado.GetRow()
	ll_cve_profesor = uo_nombre_profesor_i.of_obten_cve_profesor()
	ls_nombre_completo = uo_nombre_profesor_i.of_obten_nombre_completo()
	if ll_cve_profesor = 0 then
		MessageBox("Profesor Inválido", "Por favor seleccione otro profesor", StopSign!)
		return
	end if
	
	ist_parametros.cve_suplente_1 = ll_cve_profesor
	ist_parametros.nombre_suplente_1 = ls_nombre_completo
	dw_jurado.SetItem(ll_row,"cve_suplente_1",ll_cve_profesor)
	dw_jurado.SetItem(ll_row,"nombre_suplente_1",ls_nombre_completo)		
	
end if

end event

type cb_secretario from u_cb within w_seleccion_jurado
integer x = 64
integer y = 452
integer width = 334
integer height = 88
integer taborder = 40
string text = "Secretario=>"
end type

event clicked;call super::clicked;long ll_row, ll_cve_profesor
string ls_nombre_completo

if dw_jurado.RowCount()>0 then
	ll_row = dw_jurado.GetRow()
	ll_cve_profesor = uo_nombre_profesor_i.of_obten_cve_profesor()
	ls_nombre_completo = uo_nombre_profesor_i.of_obten_nombre_completo()
	if ll_cve_profesor = 0 then
		MessageBox("Profesor Inválido", "Por favor seleccione otro profesor", StopSign!)
		return
	end if
	
	ist_parametros.cve_secretario = ll_cve_profesor
	ist_parametros.nombre_secretario = ls_nombre_completo
	dw_jurado.SetItem(ll_row,"cve_secretario",ll_cve_profesor)
	dw_jurado.SetItem(ll_row,"nombre_secretario",ls_nombre_completo)		
	
end if

end event

type cb_vocal from u_cb within w_seleccion_jurado
integer x = 64
integer y = 352
integer width = 334
integer height = 88
integer taborder = 30
string text = "Vocal=>"
end type

event clicked;call super::clicked;long ll_row, ll_cve_profesor
string ls_nombre_completo

if dw_jurado.RowCount()>0 then
	ll_row = dw_jurado.GetRow()
	ll_cve_profesor = uo_nombre_profesor_i.of_obten_cve_profesor()
	ls_nombre_completo = uo_nombre_profesor_i.of_obten_nombre_completo()
	if ll_cve_profesor = 0 then
		MessageBox("Profesor Inválido", "Por favor seleccione otro profesor", StopSign!)
		return
	end if
	
	ist_parametros.cve_vocal = ll_cve_profesor
	ist_parametros.nombre_vocal = ls_nombre_completo
	dw_jurado.SetItem(ll_row,"cve_vocal",ll_cve_profesor)
	dw_jurado.SetItem(ll_row,"nombre_vocal",ls_nombre_completo)		
	
end if

end event

type cb_presidente from u_cb within w_seleccion_jurado
integer x = 64
integer y = 252
integer width = 334
integer height = 88
integer taborder = 40
string text = "Presidente=>"
end type

event clicked;call super::clicked;long ll_row, ll_cve_profesor
string ls_nombre_completo

if dw_jurado.RowCount()>0 then
	ll_row = dw_jurado.GetRow()
	ll_cve_profesor = uo_nombre_profesor_i.of_obten_cve_profesor()
	ls_nombre_completo = uo_nombre_profesor_i.of_obten_nombre_completo()
	if ll_cve_profesor = 0 then
		MessageBox("Profesor Inválido", "Por favor seleccione otro profesor", StopSign!)
		return
	end if
	
	ist_parametros.cve_presidente = ll_cve_profesor
	ist_parametros.nombre_presidente = ls_nombre_completo
	dw_jurado.SetItem(ll_row,"cve_presidente",ll_cve_profesor)
	dw_jurado.SetItem(ll_row,"nombre_presidente",ls_nombre_completo)		
	
end if

end event

type dw_jurado from u_dw within w_seleccion_jurado
integer x = 475
integer y = 252
integer width = 2432
integer height = 544
integer taborder = 30
string dataobject = "d_jurado_external"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_nombre_profesor_i from uo_nombre_profesor within w_seleccion_jurado
integer x = 23
integer y = 20
integer width = 2766
integer taborder = 40
boolean enabled = true
end type

on uo_nombre_profesor_i.destroy
call uo_nombre_profesor::destroy
end on

type cb_cerrar from u_cb within w_seleccion_jurado
integer x = 1257
integer y = 840
integer taborder = 20
string text = "Cerrar"
end type

event clicked;call super::clicked;
Message.PowerObjectParm = ist_parametros
CloseWithReturn(parent, ist_parametros)


end event

