﻿$PBExportHeader$w_creditos_integracion.srw
forward
global type w_creditos_integracion from window
end type
type uo_nivel from uo_nivel_rbutton within w_creditos_integracion
end type
type uoi_nombre_plan from uo_clave_texto_nombre_plan within w_creditos_integracion
end type
type st_3 from statictext within w_creditos_integracion
end type
type cb_1 from commandbutton within w_creditos_integracion
end type
type st_2 from statictext within w_creditos_integracion
end type
type em_creditos_integracion from editmask within w_creditos_integracion
end type
type cb_extension_creditos from commandbutton within w_creditos_integracion
end type
type st_1 from statictext within w_creditos_integracion
end type
type em_extension_creditos from editmask within w_creditos_integracion
end type
type rb_desbloquear from radiobutton within w_creditos_integracion
end type
type rb_bloquear from radiobutton within w_creditos_integracion
end type
type cb_adeuda_finanzas from commandbutton within w_creditos_integracion
end type
type em_cantidad_nivel from editmask within w_creditos_integracion
end type
type cb_contar_nivel from commandbutton within w_creditos_integracion
end type
type gb_2 from groupbox within w_creditos_integracion
end type
type gb_1 from groupbox within w_creditos_integracion
end type
end forward

global type w_creditos_integracion from window
integer x = 846
integer y = 372
integer width = 2661
integer height = 1336
boolean titlebar = true
string title = "Reset de Banderas"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
uo_nivel uo_nivel
uoi_nombre_plan uoi_nombre_plan
st_3 st_3
cb_1 cb_1
st_2 st_2
em_creditos_integracion em_creditos_integracion
cb_extension_creditos cb_extension_creditos
st_1 st_1
em_extension_creditos em_extension_creditos
rb_desbloquear rb_desbloquear
rb_bloquear rb_bloquear
cb_adeuda_finanzas cb_adeuda_finanzas
em_cantidad_nivel em_cantidad_nivel
cb_contar_nivel cb_contar_nivel
gb_2 gb_2
gb_1 gb_1
end type
global w_creditos_integracion w_creditos_integracion

type variables
string is_nivel = "L"
string is_nombre_nivel = "Licenciatura"
string is_bloqueo_finanzas = "Bloquear"
integer ii_adeuda_finanzas = 1
st_confirma_usuario ist_confirma_usuario
long il_creditos
end variables

on w_creditos_integracion.create
this.uo_nivel=create uo_nivel
this.uoi_nombre_plan=create uoi_nombre_plan
this.st_3=create st_3
this.cb_1=create cb_1
this.st_2=create st_2
this.em_creditos_integracion=create em_creditos_integracion
this.cb_extension_creditos=create cb_extension_creditos
this.st_1=create st_1
this.em_extension_creditos=create em_extension_creditos
this.rb_desbloquear=create rb_desbloquear
this.rb_bloquear=create rb_bloquear
this.cb_adeuda_finanzas=create cb_adeuda_finanzas
this.em_cantidad_nivel=create em_cantidad_nivel
this.cb_contar_nivel=create cb_contar_nivel
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.uo_nivel,&
this.uoi_nombre_plan,&
this.st_3,&
this.cb_1,&
this.st_2,&
this.em_creditos_integracion,&
this.cb_extension_creditos,&
this.st_1,&
this.em_extension_creditos,&
this.rb_desbloquear,&
this.rb_bloquear,&
this.cb_adeuda_finanzas,&
this.em_cantidad_nivel,&
this.cb_contar_nivel,&
this.gb_2,&
this.gb_1}
end on

on w_creditos_integracion.destroy
destroy(this.uo_nivel)
destroy(this.uoi_nombre_plan)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.em_creditos_integracion)
destroy(this.cb_extension_creditos)
destroy(this.st_1)
destroy(this.em_extension_creditos)
destroy(this.rb_desbloquear)
destroy(this.rb_bloquear)
destroy(this.cb_adeuda_finanzas)
destroy(this.em_cantidad_nivel)
destroy(this.cb_contar_nivel)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event open;
uo_nivel.f_genera_nivel( "V", "L", "L", gtr_sce, "N", "N")
end event

type uo_nivel from uo_nivel_rbutton within w_creditos_integracion
integer x = 128
integer y = 104
integer width = 526
integer height = 356
integer taborder = 40
end type

on uo_nivel.destroy
call uo_nivel_rbutton::destroy
end on

event ue_cambia_seleccion;call super::ue_cambia_seleccion;is_nivel = cve_nivel
is_nombre_nivel = descripcion_corta 






end event

type uoi_nombre_plan from uo_clave_texto_nombre_plan within w_creditos_integracion
integer x = 1970
integer y = 84
integer width = 485
integer taborder = 30
boolean border = false
end type

on uoi_nombre_plan.destroy
call uo_clave_texto_nombre_plan::destroy
end on

type st_3 from statictext within w_creditos_integracion
integer x = 1609
integer y = 80
integer width = 311
integer height = 136
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Plan de Estudios:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_creditos_integracion
integer x = 1915
integer y = 924
integer width = 599
integer height = 108
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = " Créditos Integración"
end type

event clicked;integer li_confirma, li_resultado_elimina
long ll_cant_alumnos
string ls_creditos_integracion, ls_texto, ls_nombre_plan
long ll_creditos_integracion, ll_clave, ll_cve_plan

ll_clave = uoi_nombre_plan.of_obten_clave()
ls_texto = uoi_nombre_plan.of_obten_texto()

IF (IsNull(ll_clave)) or ll_clave <= 0 THEN
	MessageBox("Plan de Estudios Incorrecto", "Favor de elegir un plan de estudios válido", StopSign!)
	RETURN
ELSE
	ll_cve_plan= long(ll_clave)
	ls_nombre_plan = ls_texto
END IF


ls_creditos_integracion = em_creditos_integracion.text

IF NOT IsNumber(ls_creditos_integracion) THEN
	MessageBox("Créditos de Integración inválidos", "Favor de escribir un valor permitido", StopSign!)
	RETURN
ELSE
	ll_creditos_integracion= long(ls_creditos_integracion)
END IF

IF ll_creditos_integracion<0 THEN
	MessageBox("Créditos inválidos", "Favor de escribir un valor mayor a 0", StopSign!)
	RETURN
END IF

ll_cant_alumnos = f_cuenta_alumnos_nivel_plan(is_nivel, ll_cve_plan)

IF ll_cant_alumnos= -1 THEN
	RETURN	
END IF

em_cantidad_nivel.text = string(ll_cant_alumnos)

li_confirma=MessageBox("Confirme Actualización", "¿Desea establecer en ["+string(ll_creditos_integracion)+"] los creditos de los ["+string(ll_cant_alumnos)+"] alumnos de "+is_nombre_nivel+" del plan["+string(ll_cve_plan)+"-"+ls_nombre_plan+"]?",Question!, YesNo!)
							 
IF li_confirma <> 1 THEN
	RETURN
ELSE
	Open(w_confirma_usuario)
	ist_confirma_usuario = Message.PowerObjectParm
	IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
		MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
		RETURN
	END IF
END IF

SetPointer(HourGlass!)
li_resultado_elimina= f_actualiza_creditos_integracion(is_nivel, ll_creditos_integracion, ll_cve_plan)

IF li_resultado_elimina <> -1 THEN	
	MessageBox("Actualización Exitosa", "El proceso modifico a los créditos de los alumnos exitosamente", Information!)
	RETURN
END IF

end event

type st_2 from statictext within w_creditos_integracion
integer x = 1646
integer y = 592
integer width = 334
integer height = 136
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Créditos de Integración:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_creditos_integracion from editmask within w_creditos_integracion
integer x = 2016
integer y = 608
integer width = 393
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###"
end type

type cb_extension_creditos from commandbutton within w_creditos_integracion
integer x = 974
integer y = 924
integer width = 635
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Extensión Créditos"
end type

event clicked;integer li_confirma, li_resultado_elimina
long ll_cant_alumnos
string ls_creditos
long ll_creditos

ls_creditos = em_extension_creditos.text

IF NOT IsNumber(ls_creditos) THEN
	MessageBox("Créditos inválidos", "Favor de escribir un valor permitido", StopSign!)
	RETURN
ELSE
	ll_creditos= long(ls_creditos)
END IF

IF ll_creditos<0 THEN
	MessageBox("Créditos inválidos", "Favor de escribir un valor mayor a 0", StopSign!)
	RETURN
END IF

ll_cant_alumnos = f_cuenta_alumnos_nivel(is_nivel)

IF ll_cant_alumnos= -1 THEN
	RETURN	
END IF

em_cantidad_nivel.text = string(ll_cant_alumnos)

li_confirma=MessageBox("Confirme Actualización", "¿Desea establecer en ["+string(ll_creditos)+"] los creditos de los ["+string(ll_cant_alumnos)+"] alumnos de "+is_nombre_nivel+"?",Question!, YesNo!)
							 
IF li_confirma <> 1 THEN
	RETURN
ELSE
	Open(w_confirma_usuario)
	ist_confirma_usuario = Message.PowerObjectParm
	IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
		MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
		RETURN
	END IF
END IF

SetPointer(HourGlass!)
li_resultado_elimina= f_actualiza_creditos(is_nivel, ll_creditos)

IF li_resultado_elimina <> -1 THEN	
	MessageBox("Actualización Exitosa", "El proceso modifico a los créditos de los alumnos exitosamente", Information!)
	RETURN
END IF

end event

type st_1 from statictext within w_creditos_integracion
integer x = 667
integer y = 600
integer width = 402
integer height = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Extensión de Créditos:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_extension_creditos from editmask within w_creditos_integracion
integer x = 1161
integer y = 608
integer width = 393
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###"
end type

type rb_desbloquear from radiobutton within w_creditos_integracion
integer x = 119
integer y = 680
integer width = 425
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "Desbloquear"
end type

event clicked;ii_adeuda_finanzas=0
is_bloqueo_finanzas = "Desbloquear"
end event

type rb_bloquear from radiobutton within w_creditos_integracion
integer x = 119
integer y = 596
integer width = 325
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "Bloquear"
boolean checked = true
end type

event clicked;ii_adeuda_finanzas=1
is_bloqueo_finanzas = "Bloquear"
end event

type cb_adeuda_finanzas from commandbutton within w_creditos_integracion
integer x = 91
integer y = 924
integer width = 512
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Adeuda Finanzas"
end type

event clicked;integer li_confirma, li_resultado_elimina
long ll_cant_alumnos

ll_cant_alumnos = f_cuenta_alumnos_nivel(is_nivel)

IF ll_cant_alumnos= -1 THEN
	RETURN	
END IF

em_cantidad_nivel.text = string(ll_cant_alumnos)

li_confirma=MessageBox("Confirme Actualización", "¿Desea " + is_bloqueo_finanzas+ " los ["+string(ll_cant_alumnos)+"] alumnos?",Question!, YesNo!)
							 
IF li_confirma <> 1 THEN
	RETURN
ELSE
	Open(w_confirma_usuario)
	ist_confirma_usuario = Message.PowerObjectParm
	IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
		MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
		RETURN
	END IF
END IF

SetPointer(HourGlass!)
li_resultado_elimina= f_actualiza_adeuda_finanzas(is_nivel, ii_adeuda_finanzas)

IF li_resultado_elimina <> -1 THEN	
	MessageBox("Actualización Exitosa", "El proceso de "+is_bloqueo_finanzas+" modifico a los alumnos exitosamente", Information!)
	RETURN
END IF

end event

type em_cantidad_nivel from editmask within w_creditos_integracion
integer x = 1161
integer y = 96
integer width = 393
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
string text = "0"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###"
end type

type cb_contar_nivel from commandbutton within w_creditos_integracion
integer x = 731
integer y = 96
integer width = 379
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Contar Nivel"
end type

event clicked;long ll_cuenta_alumnos


ll_cuenta_alumnos = f_cuenta_alumnos_nivel(is_nivel)

IF ll_cuenta_alumnos = -1 THEN
	RETURN	
END IF


em_cantidad_nivel.text= string(ll_cuenta_alumnos)
end event

type gb_2 from groupbox within w_creditos_integracion
integer x = 87
integer y = 520
integer width = 512
integer height = 284
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "Finanzas"
end type

type gb_1 from groupbox within w_creditos_integracion
integer x = 87
integer y = 28
integer width = 599
integer height = 464
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "Nivel"
end type

