$PBExportHeader$w_solicitud_autorizacion_especial.srw
forward
global type w_solicitud_autorizacion_especial from window
end type
type cb_rechaza from commandbutton within w_solicitud_autorizacion_especial
end type
type dw_horario from datawindow within w_solicitud_autorizacion_especial
end type
type dw_grupos_existentes_sae from datawindow within w_solicitud_autorizacion_especial
end type
type cb_inscribe from commandbutton within w_solicitud_autorizacion_especial
end type
type cb_5 from commandbutton within w_solicitud_autorizacion_especial
end type
type cb_4 from commandbutton within w_solicitud_autorizacion_especial
end type
type st_5 from statictext within w_solicitud_autorizacion_especial
end type
type st_4 from statictext within w_solicitud_autorizacion_especial
end type
type em_gpo_2 from editmask within w_solicitud_autorizacion_especial
end type
type em_cve_mat_2 from editmask within w_solicitud_autorizacion_especial
end type
type st_3 from statictext within w_solicitud_autorizacion_especial
end type
type st_2 from statictext within w_solicitud_autorizacion_especial
end type
type st_1 from statictext within w_solicitud_autorizacion_especial
end type
type em_gpo from editmask within w_solicitud_autorizacion_especial
end type
type em_cve_mat from editmask within w_solicitud_autorizacion_especial
end type
type cb_3 from commandbutton within w_solicitud_autorizacion_especial
end type
type em_cuenta from editmask within w_solicitud_autorizacion_especial
end type
type cb_2 from commandbutton within w_solicitud_autorizacion_especial
end type
type cb_1 from commandbutton within w_solicitud_autorizacion_especial
end type
type p_ibero from picture within w_solicitud_autorizacion_especial
end type
type st_sistema from statictext within w_solicitud_autorizacion_especial
end type
type dw_detalle from datawindow within w_solicitud_autorizacion_especial
end type
type dw_maestro from datawindow within w_solicitud_autorizacion_especial
end type
type r_1 from rectangle within w_solicitud_autorizacion_especial
end type
type r_2 from rectangle within w_solicitud_autorizacion_especial
end type
end forward

global type w_solicitud_autorizacion_especial from window
integer width = 5595
integer height = 2744
boolean titlebar = true
string title = "Solicitud de Autorización Especial"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
cb_rechaza cb_rechaza
dw_horario dw_horario
dw_grupos_existentes_sae dw_grupos_existentes_sae
cb_inscribe cb_inscribe
cb_5 cb_5
cb_4 cb_4
st_5 st_5
st_4 st_4
em_gpo_2 em_gpo_2
em_cve_mat_2 em_cve_mat_2
st_3 st_3
st_2 st_2
st_1 st_1
em_gpo em_gpo
em_cve_mat em_cve_mat
cb_3 cb_3
em_cuenta em_cuenta
cb_2 cb_2
cb_1 cb_1
p_ibero p_ibero
st_sistema st_sistema
dw_detalle dw_detalle
dw_maestro dw_maestro
r_1 r_1
r_2 r_2
end type
global w_solicitud_autorizacion_especial w_solicitud_autorizacion_especial

type variables
long il_cuenta, il_cve_mat, il_row_selected = 0, il_row_maestro= 0
string is_gpo
end variables

on w_solicitud_autorizacion_especial.create
this.cb_rechaza=create cb_rechaza
this.dw_horario=create dw_horario
this.dw_grupos_existentes_sae=create dw_grupos_existentes_sae
this.cb_inscribe=create cb_inscribe
this.cb_5=create cb_5
this.cb_4=create cb_4
this.st_5=create st_5
this.st_4=create st_4
this.em_gpo_2=create em_gpo_2
this.em_cve_mat_2=create em_cve_mat_2
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.em_gpo=create em_gpo
this.em_cve_mat=create em_cve_mat
this.cb_3=create cb_3
this.em_cuenta=create em_cuenta
this.cb_2=create cb_2
this.cb_1=create cb_1
this.p_ibero=create p_ibero
this.st_sistema=create st_sistema
this.dw_detalle=create dw_detalle
this.dw_maestro=create dw_maestro
this.r_1=create r_1
this.r_2=create r_2
this.Control[]={this.cb_rechaza,&
this.dw_horario,&
this.dw_grupos_existentes_sae,&
this.cb_inscribe,&
this.cb_5,&
this.cb_4,&
this.st_5,&
this.st_4,&
this.em_gpo_2,&
this.em_cve_mat_2,&
this.st_3,&
this.st_2,&
this.st_1,&
this.em_gpo,&
this.em_cve_mat,&
this.cb_3,&
this.em_cuenta,&
this.cb_2,&
this.cb_1,&
this.p_ibero,&
this.st_sistema,&
this.dw_detalle,&
this.dw_maestro,&
this.r_1,&
this.r_2}
end on

on w_solicitud_autorizacion_especial.destroy
destroy(this.cb_rechaza)
destroy(this.dw_horario)
destroy(this.dw_grupos_existentes_sae)
destroy(this.cb_inscribe)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.em_gpo_2)
destroy(this.em_cve_mat_2)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_gpo)
destroy(this.em_cve_mat)
destroy(this.cb_3)
destroy(this.em_cuenta)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.p_ibero)
destroy(this.st_sistema)
destroy(this.dw_detalle)
destroy(this.dw_maestro)
destroy(this.r_1)
destroy(this.r_2)
end on

event open;long ll_rows_maestro, ll_rows_detalle
x=1
y=1

dw_detalle.settransobject(sqlca)
dw_maestro.settransobject(sqlca)
dw_grupos_existentes_sae.settransobject(sqlca)
dw_horario.settransobject(sqlca)

ll_rows_maestro= dw_maestro.Retrieve(gi_cve_coordinacion)

end event

type cb_rechaza from commandbutton within w_solicitud_autorizacion_especial
integer x = 3543
integer y = 1860
integer width = 663
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Rechaza Materia Grupo"
end type

event clicked;long ll_row_maestro, ll_estatus_rechazado = 3
integer li_update_maestro, li_confirmacion
if il_cve_mat >0 then
	li_confirmacion = MessageBox("Confirmación Rechazo","¿Desea rechazar la materia ["+string(il_cve_mat)+" - "+ is_gpo+"] ?" ,  Question!, YesNo!)

	ll_row_maestro = il_row_maestro

	dw_maestro.SetItem(ll_row_maestro,"cve_estatus_autorizacion", ll_estatus_rechazado)
	li_update_maestro =  dw_maestro.Update()
	if li_update_maestro = 1 then
		COMMIT USING SQLCA;
	ELSE
		ROLLBACK USING SQLCA;
	end if
else
	MessageBox("Selección Pendiente", "Es necesario elegir una materia antes de rechazar",StopSign!)
end if

end event

type dw_horario from datawindow within w_solicitud_autorizacion_especial
integer x = 27
integer y = 1692
integer width = 2464
integer height = 400
integer taborder = 30
string title = "none"
string dataobject = "d_horarios_sae"
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_grupos_existentes_sae from datawindow within w_solicitud_autorizacion_especial
integer x = 3333
integer y = 324
integer width = 2043
integer height = 828
integer taborder = 20
string title = "none"
string dataobject = "d_grupos_existentes_sae"
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type cb_inscribe from commandbutton within w_solicitud_autorizacion_especial
integer x = 2766
integer y = 1860
integer width = 649
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Inscribe Materia Grupo"
end type

event clicked;long ll_valida_alumno, ll_codigo, ll_cuenta, ll_cve_mat , ll_inscribe_materia_grupo, ll_cve_mat_2, ll_row_detalle, ll_estatus_autorizado = 2, ll_row_maestro
string ls_mensaje, ls_cuenta , ls_cve_mat, ls_gpo, ls_gpo_2
integer li_inscribe = 0, li_es_labo, li_lleva_teoria_lab, li_update_maestro 

if il_cve_mat >0 then

	ls_cuenta    = em_cuenta.text
	ls_cve_mat = em_cve_mat.text
	ls_gpo        = em_gpo.text

	ll_cuenta = long(ls_cuenta)
	ll_cve_mat = long(ls_cve_mat)

	n_ajustes ln_ajustes

	ll_cuenta = il_cuenta
	ll_cve_mat = il_cve_mat
	ls_gpo =is_gpo

	if il_cuenta>0 and il_cve_mat>0 then 
		ln_ajustes = CREATE n_ajustes
		li_lleva_teoria_lab = ln_ajustes.of_lleva_teoria_lab (il_cuenta, il_cve_mat, is_gpo, ll_cve_mat_2, ls_gpo_2, li_es_labo)
		if ll_cve_mat_2>0 then
			ll_row_detalle = dw_detalle.GetRow()
			ls_gpo_2 = 	dw_detalle.GetItemString(ll_row_detalle, "gpo_ligado")
			if ls_gpo_2= "--" or len(ls_gpo_2) = 0 or isnull(ls_gpo_2) then
				MessageBox("Resultado de la validación","No se ha elegido el grupo de la materia ligada ["+string(ll_cve_mat_2)+"] favor de dar dobleclick en la clave de la materia", Stopsign!)	
				return
			end if		
			ll_inscribe_materia_grupo = ln_ajustes.of_inscribe_materia_grupo (il_cuenta, il_cve_mat, is_gpo, ll_cve_mat_2, ls_gpo_2, ll_codigo, ls_mensaje)
			if ll_inscribe_materia_grupo = 0 then
				ll_row_maestro = il_row_maestro
				dw_maestro.SetItem(ll_row_maestro,"cve_estatus_autorizacion", ll_estatus_autorizado)
				li_update_maestro =  dw_maestro.Update()
				if li_update_maestro = 1 then
					COMMIT USING SQLCA;
				ELSE
					ROLLBACK USING SQLCA;
				end if
			end if
		else
			ll_inscribe_materia_grupo = ln_ajustes.of_inscribe_materia_grupo (il_cuenta, il_cve_mat, is_gpo, 0, "", ll_codigo, ls_mensaje)		
			if ll_inscribe_materia_grupo = 0 then
				ll_row_maestro = il_row_maestro
				dw_maestro.SetItem(ll_row_maestro,"cve_estatus_autorizacion", ll_estatus_autorizado)
				li_update_maestro =  dw_maestro.Update()
				if li_update_maestro = 1 then
					COMMIT USING SQLCA;
				ELSE
					ROLLBACK USING SQLCA;
				end if
			end if
		end if	

		if ll_inscribe_materia_grupo= 0 then
			MessageBox("Resultado de la validación","Cuenta ["+string(ll_cuenta) +"] cve_mat ["+string(ll_cve_mat) +"-"+ls_gpo+"] Código ["+string(ll_codigo)+"] Mensaje ["+ls_mensaje+"]", Stopsign!)	
		end if

	end if
else
	MessageBox("Selección Pendiente", "Es necesario elegir una materia antes de inscribir",StopSign!)
end if

return



end event

type cb_5 from commandbutton within w_solicitud_autorizacion_especial
integer x = 2085
integer y = 2332
integer width = 603
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "ValidaTeoria-Lab"
end type

event clicked;long ll_valida_alumno, ll_codigo, ll_cuenta, ll_cve_mat , ll_cve_mat_2
string ls_mensaje, ls_cuenta , ls_cve_mat, ls_gpo, ls_gpo_2
integer li_inscribe = 0, li_es_labo

ls_cuenta    = em_cuenta.text
ls_cve_mat = em_cve_mat.text
ls_gpo        = em_gpo.text

ll_cuenta = long(ls_cuenta)
ll_cve_mat = long(ls_cve_mat)

n_ajustes ln_ajustes


if ll_cuenta>0 and ll_cve_mat>0 then 
	ln_ajustes = CREATE n_ajustes
	ll_valida_alumno = ln_ajustes.of_lleva_teoria_lab (ll_cuenta, ll_cve_mat, ls_gpo, ll_cve_mat_2, ls_gpo_2, li_es_labo)

	if ll_valida_alumno= 0 then
		MessageBox("Resultado de la validación","Cuenta ["+string(ll_cuenta) +"] cve_mat ["+string(ll_cve_mat) +"-"+ls_gpo+"] cve_mat_2 ["+string(ll_cve_mat_2) +"-"+ls_gpo_2+"]", Information!)	
	end if

end if

return



end event

type cb_4 from commandbutton within w_solicitud_autorizacion_especial
integer x = 3447
integer y = 2184
integer width = 603
integer height = 112
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Inscribe Teoria-Lab"
boolean cancel = true
end type

event clicked;long ll_valida_alumno, ll_codigo, ll_cuenta, ll_cve_mat , ll_cve_mat_2 
string ls_mensaje, ls_cuenta , ls_cve_mat, ls_gpo, ls_cve_mat_2, ls_gpo_2
integer li_inscribe = 0

ls_cuenta    = em_cuenta.text
ls_cve_mat = em_cve_mat.text
ls_gpo        = em_gpo.text

ls_cve_mat_2 = em_cve_mat_2.text
ls_gpo_2        = em_gpo_2.text


ll_cuenta = long(ls_cuenta)
ll_cve_mat = long(ls_cve_mat)
ll_cve_mat_2 = long(ls_cve_mat_2)

n_ajustes ln_ajustes


if ll_cuenta>0 and ll_cve_mat>0 then 
	ln_ajustes = CREATE n_ajustes
	ll_valida_alumno = ln_ajustes.of_inscripcion_teoria_lab(ll_cuenta, ll_cve_mat, ls_gpo, ll_cve_mat_2, ls_gpo_2, li_inscribe, ll_codigo, ls_mensaje)
	if ll_valida_alumno= 0 then
		MessageBox("Resultado de la validación","Cuenta ["+string(ll_cuenta) +"] cve_mat ["+string(ll_cve_mat) +"-"+ls_gpo+"] cve_mat_2 ["+string(ll_cve_mat_2) +"-"+ls_gpo_2+"] Código ["+string(ll_codigo)+"] Mensaje ["+ls_mensaje+"]", Information!)	
	end if

end if

return



end event

type st_5 from statictext within w_solicitud_autorizacion_especial
integer x = 2789
integer y = 2388
integer width = 183
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "gpo 2"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_solicitud_autorizacion_especial
integer x = 2706
integer y = 2204
integer width = 283
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "cve_mat 2"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_gpo_2 from editmask within w_solicitud_autorizacion_especial
integer x = 3003
integer y = 2352
integer width = 402
integer height = 112
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!"
end type

type em_cve_mat_2 from editmask within w_solicitud_autorizacion_especial
integer x = 3008
integer y = 2180
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type st_3 from statictext within w_solicitud_autorizacion_especial
integer x = 59
integer y = 2388
integer width = 187
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "cuenta"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_solicitud_autorizacion_especial
integer x = 1303
integer y = 2384
integer width = 283
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "gpo"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_solicitud_autorizacion_especial
integer x = 1303
integer y = 2216
integer width = 283
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "cve_mat"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_gpo from editmask within w_solicitud_autorizacion_especial
integer x = 1623
integer y = 2360
integer width = 402
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!"
end type

type em_cve_mat from editmask within w_solicitud_autorizacion_especial
integer x = 1623
integer y = 2184
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type cb_3 from commandbutton within w_solicitud_autorizacion_especial
integer x = 2085
integer y = 2184
integer width = 603
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Valida Materia Grupo"
end type

event clicked;long ll_valida_alumno, ll_codigo, ll_cuenta, ll_cve_mat 
string ls_mensaje, ls_cuenta , ls_cve_mat, ls_gpo
integer li_inscribe = 0

ls_cuenta    = em_cuenta.text
ls_cve_mat = em_cve_mat.text
ls_gpo        = em_gpo.text

ll_cuenta = long(ls_cuenta)
ll_cve_mat = long(ls_cve_mat)

n_ajustes ln_ajustes


if ll_cuenta>0 and ll_cve_mat>0 then 
	ln_ajustes = CREATE n_ajustes
	ll_valida_alumno = ln_ajustes.of_valida_materia_grupo (ll_cuenta, ll_cve_mat, ls_gpo, li_inscribe, ll_codigo, ls_mensaje)

	if ll_valida_alumno= 0 then
		MessageBox("Resultado de la validación","Cuenta ["+string(ll_cuenta) +"] cve_mat ["+string(ll_cve_mat) +"-"+ls_gpo+"] Código ["+string(ll_codigo)+"] Mensaje ["+ls_mensaje+"]", Information!)	
	end if

end if

return



end event

type em_cuenta from editmask within w_solicitud_autorizacion_especial
integer x = 274
integer y = 2356
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "######"
end type

type cb_2 from commandbutton within w_solicitud_autorizacion_especial
integer x = 809
integer y = 2356
integer width = 430
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Valida Cuenta"
end type

event clicked;long ll_valida_alumno, ll_codigo, ll_cuenta
string ls_mensaje, ls_cuenta 

ls_cuenta = em_cuenta.text

ll_cuenta = long(ls_cuenta)


n_ajustes ln_ajustes


if ll_cuenta>0 then 
	ln_ajustes = CREATE n_ajustes
	ll_valida_alumno = ln_ajustes.of_valida_alumno (ll_cuenta, ll_codigo, ls_mensaje)

	if ll_valida_alumno= 0 then
		MessageBox("Resultado de la validación","Cuenta ["+string(ll_cuenta) +"] Código ["+string(ll_codigo)+"] Mensaje ["+ls_mensaje+"]", Information!)	
	end if

end if

return



end event

type cb_1 from commandbutton within w_solicitud_autorizacion_especial
integer x = 809
integer y = 2184
integer width = 430
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Valida Alumno"
end type

event clicked;long ll_valida_alumno, ll_codigo
string ls_mensaje

n_ajustes ln_ajustes

ln_ajustes = CREATE n_ajustes

ll_valida_alumno = ln_ajustes.of_valida_alumno (il_cuenta, ll_codigo, ls_mensaje)

if ll_valida_alumno= 0 then
	MessageBox("Resultado de la validación","Código ["+string(ll_codigo)+"] Mensaje ["+ls_mensaje+"]")	
end if

return



end event

type p_ibero from picture within w_solicitud_autorizacion_especial
integer x = 32
integer y = 24
integer width = 681
integer height = 264
string picturename = "logoibero-web.png"
boolean focusrectangle = false
end type

type st_sistema from statictext within w_solicitud_autorizacion_especial
integer x = 741
integer y = 92
integer width = 229
integer height = 100
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

type dw_detalle from datawindow within w_solicitud_autorizacion_especial
integer x = 27
integer y = 1208
integer width = 5239
integer height = 492
integer taborder = 20
string title = "none"
string dataobject = "d_solicitud_autorizacion_especial_detalle"
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemfocuschanged;long ll_row, ll_cuenta, ll_cve_mat
string ls_gpo


ll_row = row

if ll_row > 0 then
	ll_cuenta = this.GetItemNumber(ll_row, "alumnos_cuenta")
	ll_cve_mat = this.GetItemNumber(ll_row, "grupos_cve_mat")
	ls_gpo = this.GetItemString(ll_row, "grupos_gpo")
	il_cuenta = ll_cuenta
	il_cve_mat = ll_cve_mat
	is_gpo = ls_gpo
	
	
else
	il_cuenta = 0
	il_cve_mat = 0
	is_gpo = ""
end if


end event

event doubleclicked;integer li_return
long ll_row, ll_cuenta, ll_cve_mat_ligada, ll_periodo, ll_anio
string ls_gpo, ls_grupo_retorno
st_grupo_ligado_sae lst_grupo_ligado_sae
w_grupos_ligados_sae lw_grupos_ligados_sae
ll_row = row

if ll_row > 0 then
	ll_cuenta = this.GetItemNumber(ll_row, "alumnos_cuenta")
	ll_cve_mat_ligada = this.GetItemNumber(ll_row, "cve_mat_ligada")
	ll_periodo = this.GetItemNumber(ll_row, "grupos_periodo")
	ll_anio = this.GetItemNumber(ll_row, "grupos_anio")
	ls_gpo = this.GetItemString(ll_row, "grupos_gpo")
	lst_grupo_ligado_sae.cve_mat = ll_cve_mat_ligada
	lst_grupo_ligado_sae.periodo = ll_periodo
	lst_grupo_ligado_sae.anio = ll_anio
	li_return = OpenWithParm (w_grupos_ligados_sae, lst_grupo_ligado_sae)
	ls_grupo_retorno = Message.StringParm
	this.SetItem(ll_row, "gpo_ligado",ls_grupo_retorno )
	
end if




end event

type dw_maestro from datawindow within w_solicitud_autorizacion_especial
integer x = 32
integer y = 324
integer width = 3273
integer height = 828
integer taborder = 10
string title = "none"
string dataobject = "d_solicitud_autorizacion_especial"
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;long ll_row_actual, ll_cuenta, ll_cve_mat, ll_periodo, ll_anio , ll_rows_detalle, ll_rows_grupos_existentes, ll_row_detalle, ll_of_obten_materia, ll_rows_horario
string ls_gpo, ls_materia_2
n_ajustes  ln_ajustes 
long ll_cve_carrera, ll_cve_plan, ll_obten_carrera_plan
integer li_obten_seriaciones_materia
ll_row_actual = row
il_row_maestro= ll_row_actual

if il_row_selected >0 and isSelected(il_row_selected) then
	this.SelectRow(il_row_selected, false)
end if 
ll_cuenta = this.GetItemNumber(ll_row_actual,"cuenta")
ll_cve_mat = this.GetItemNumber(ll_row_actual,"cve_mat")
ls_gpo = this.GetItemString(ll_row_actual,"gpo")
ll_periodo = this.GetItemNumber(ll_row_actual,"periodo")
ll_anio  = this.GetItemNumber(ll_row_actual,"anio")




il_cuenta = ll_cuenta
il_cve_mat = ll_cve_mat
is_gpo = ls_gpo

il_row_selected = ll_row_actual
this.SelectRow(il_row_selected, true)

ll_rows_detalle = dw_detalle.Retrieve(ll_cuenta,ll_cve_mat, ls_gpo, ll_periodo,ll_anio )

ll_rows_grupos_existentes = dw_grupos_existentes_sae.Retrieve(ll_cve_mat, ll_periodo,ll_anio )

ll_rows_horario = dw_horario.Retrieve(ll_cve_mat, ls_gpo, ll_periodo,ll_anio )


integer li_lleva_teoria_lab,  li_inscribe = 0, li_es_labo, li_valida_materia_grupo, li_valida_materia_grupo_2, li_inscripcion_teoria_lab
long ll_valida_alumno, ll_codigo, ll_codigo_2,   ll_cve_mat_2
string ls_mensaje, ls_cuenta , ls_cve_mat,  ls_gpo_2

//Revisa si la materia lleva teoría o laboratorio ligada
if ll_cuenta>0 and ll_cve_mat>0 then 
	ln_ajustes = CREATE n_ajustes
	ll_obten_carrera_plan = ln_ajustes.of_obten_carrera_plan(ll_cuenta, ll_cve_carrera, ll_cve_plan)	
	li_obten_seriaciones_materia = ln_ajustes.of_obten_seriaciones_materia(ll_cve_mat, ll_cve_carrera, ll_cve_plan)	
	dw_detalle.SetItem(ll_rows_detalle, "num_seriaciones", li_obten_seriaciones_materia)
	
	li_lleva_teoria_lab = ln_ajustes.of_lleva_teoria_lab (ll_cuenta, ll_cve_mat, ls_gpo, ll_cve_mat_2, ls_gpo_2, li_es_labo)
	if ll_cve_mat_2>0 then
		dw_detalle.Modify("t_clave.Visible='1'")
		dw_detalle.Modify("t_grupo_ligado.Visible='1'")
		dw_detalle.Modify("t_materia_ligada.Visible='1'")		
		dw_detalle.Modify("gb_ligados.Visible='1'")		
		dw_detalle.Modify("cve_mat_ligada.Visible='1'")
		dw_detalle.Modify("gpo_ligado.Visible='1'")
		dw_detalle.Modify("materia_ligada.Visible='1'")		

		ll_of_obten_materia = ln_ajustes.of_obten_materia(ll_cve_mat_2, ls_materia_2)
		for ll_row_detalle= 1 to ll_rows_detalle
			dw_detalle.SetItem(ll_row_detalle, "cve_mat_ligada", ll_cve_mat_2)
			if ls_gpo_2 <> '*' then
				dw_detalle.SetItem(ll_row_detalle, "gpo_ligado", ls_gpo_2)
			end if
			if ll_of_obten_materia<>-1 then
				dw_detalle.SetItem(ll_row_detalle, "materia_ligada", ls_materia_2)			
			end if
		next
	else
		dw_detalle.Modify("t_clave.Visible='0'")
		dw_detalle.Modify("t_grupo_ligado.Visible='0'")
		dw_detalle.Modify("t_materia_ligada.Visible='0'")		
		dw_detalle.Modify("gb_ligados.Visible='0'")		
		dw_detalle.Modify("cve_mat_ligada.Visible='0'")
		dw_detalle.Modify("gpo_ligado.Visible='0'")
		dw_detalle.Modify("materia_ligada.Visible='0'")		
	end if	
end if



end event

type r_1 from rectangle within w_solicitud_autorizacion_especial
integer linethickness = 4
long fillcolor = 32768
integer x = 2747
integer y = 1844
integer width = 686
integer height = 144
end type

type r_2 from rectangle within w_solicitud_autorizacion_especial
integer linethickness = 4
long fillcolor = 255
integer x = 3525
integer y = 1844
integer width = 699
integer height = 144
end type

