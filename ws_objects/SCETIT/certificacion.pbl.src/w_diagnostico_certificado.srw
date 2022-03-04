$PBExportHeader$w_diagnostico_certificado.srw
forward
global type w_diagnostico_certificado from w_response
end type
type st_16 from statictext within w_diagnostico_certificado
end type
type mle_diagnostico from multilineedit within w_diagnostico_certificado
end type
type st_15 from statictext within w_diagnostico_certificado
end type
type st_18 from statictext within w_diagnostico_certificado
end type
type st_14 from statictext within w_diagnostico_certificado
end type
type st_1 from statictext within w_diagnostico_certificado
end type
type st_13 from statictext within w_diagnostico_certificado
end type
type st_12 from statictext within w_diagnostico_certificado
end type
type st_11 from statictext within w_diagnostico_certificado
end type
type st_10 from statictext within w_diagnostico_certificado
end type
type st_9 from statictext within w_diagnostico_certificado
end type
type st_8 from statictext within w_diagnostico_certificado
end type
type st_7 from statictext within w_diagnostico_certificado
end type
type st_6 from statictext within w_diagnostico_certificado
end type
type st_5 from statictext within w_diagnostico_certificado
end type
type st_4 from statictext within w_diagnostico_certificado
end type
type st_3 from statictext within w_diagnostico_certificado
end type
type st_2 from statictext within w_diagnostico_certificado
end type
type cb_cerrar from u_cb within w_diagnostico_certificado
end type
type cb_imprimir from u_cb within w_diagnostico_certificado
end type
type dw_revision_estudios from u_dw within w_diagnostico_certificado
end type
type dw_diagnostico from u_dw within w_diagnostico_certificado
end type
end forward

global type w_diagnostico_certificado from w_response
integer x = 214
integer y = 221
integer width = 3598
integer height = 2076
string title = "Diagnóstico del Alumno"
boolean controlmenu = false
st_16 st_16
mle_diagnostico mle_diagnostico
st_15 st_15
st_18 st_18
st_14 st_14
st_1 st_1
st_13 st_13
st_12 st_12
st_11 st_11
st_10 st_10
st_9 st_9
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
cb_cerrar cb_cerrar
cb_imprimir cb_imprimir
dw_revision_estudios dw_revision_estudios
dw_diagnostico dw_diagnostico
end type
global w_diagnostico_certificado w_diagnostico_certificado

type variables
str_alumno_opc_cero ist_parametros
boolean ib_alumno_sin_bloqueos = false
uo_bloqueos_alumno iuo_bloqueos_alumno
long il_cuenta
end variables

on w_diagnostico_certificado.create
int iCurrent
call super::create
this.st_16=create st_16
this.mle_diagnostico=create mle_diagnostico
this.st_15=create st_15
this.st_18=create st_18
this.st_14=create st_14
this.st_1=create st_1
this.st_13=create st_13
this.st_12=create st_12
this.st_11=create st_11
this.st_10=create st_10
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.cb_cerrar=create cb_cerrar
this.cb_imprimir=create cb_imprimir
this.dw_revision_estudios=create dw_revision_estudios
this.dw_diagnostico=create dw_diagnostico
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_16
this.Control[iCurrent+2]=this.mle_diagnostico
this.Control[iCurrent+3]=this.st_15
this.Control[iCurrent+4]=this.st_18
this.Control[iCurrent+5]=this.st_14
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.st_13
this.Control[iCurrent+8]=this.st_12
this.Control[iCurrent+9]=this.st_11
this.Control[iCurrent+10]=this.st_10
this.Control[iCurrent+11]=this.st_9
this.Control[iCurrent+12]=this.st_8
this.Control[iCurrent+13]=this.st_7
this.Control[iCurrent+14]=this.st_6
this.Control[iCurrent+15]=this.st_5
this.Control[iCurrent+16]=this.st_4
this.Control[iCurrent+17]=this.st_3
this.Control[iCurrent+18]=this.st_2
this.Control[iCurrent+19]=this.cb_cerrar
this.Control[iCurrent+20]=this.cb_imprimir
this.Control[iCurrent+21]=this.dw_revision_estudios
this.Control[iCurrent+22]=this.dw_diagnostico
end on

on w_diagnostico_certificado.destroy
call super::destroy
destroy(this.st_16)
destroy(this.mle_diagnostico)
destroy(this.st_15)
destroy(this.st_18)
destroy(this.st_14)
destroy(this.st_1)
destroy(this.st_13)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cb_cerrar)
destroy(this.cb_imprimir)
destroy(this.dw_revision_estudios)
destroy(this.dw_diagnostico)
end on

event open;
long ll_cuenta, ll_cve_carrera, ll_cve_plan, ll_diagnostico
boolean lb_procede_tramite, lb_revisa_cobranzas
integer li_res, li_tiene_adeudos, li_datos_tramites

uo_reporte_dw luo_reporte_dw 
blob lblob_materias_historico, lblob_revision_estudios
integer li_revision_estudios, lisfs_revision_estudios
long ll_revision_est
x=1	
y=1
dw_revision_estudios.SetTransObject(gtr_sce)
//Lee los valores recibidos por la ventana anterior
ist_parametros = Message.PowerObjectParm	
	
ll_cuenta=	ist_parametros.cuenta 
ll_cve_carrera = 	ist_parametros.cve_carrera 
ll_cve_plan=	ist_parametros.cve_plan 

il_cuenta= ll_cuenta

luo_reporte_dw = CREATE uo_reporte_dw
if isvalid(luo_reporte_dw) then
		
	SetPointer(HourGlass!)
	
	li_revision_estudios= luo_reporte_dw.f_obten_revision_estudios(ll_cuenta, ll_cve_carrera, ll_cve_plan, lblob_materias_historico, lblob_revision_estudios)
	if li_revision_estudios= 0 then
		lisfs_revision_estudios = dw_revision_estudios.SetFullState(lblob_revision_estudios)
	end if
	dw_diagnostico.SetTransObject(gtr_sce)
	
	ll_revision_est = dw_diagnostico.retrieve(ll_cuenta, ll_cve_carrera, ll_cve_plan)
	
	SetPointer(Arrow!)

end if 

if isvalid(luo_reporte_dw) then
	DESTROY luo_reporte_dw
end if

if li_datos_tramites=-1 or li_revision_estudios= -1 then
	MessageBox("Información no disponible","No es posible consultar el estatus del alumno",StopSign!)
	ist_parametros.procede_tramite=false
	cb_cerrar.event clicked()
	return
end if

	
end event

event closequery;RETURN 0
end event

event activate;call super::activate;String ls_mensaje_bloqueos = ""

IF NOT isvalid(gtr_scob) THEN
	IF conecta_bd(gtr_scob,gs_scob,gs_usuario,gs_password)<>1 THEN
		MessageBox("Error de Conexion","No es posible conectarse a tesorería", StopSign!)
		CLOSE(THIS)
	END IF
END IF

IF IsValid(THIS) THEN 
	iuo_bloqueos_alumno = CREATE uo_bloqueos_alumno
	
	IF iuo_bloqueos_alumno.f_mensaje_bloqueos(il_cuenta, ls_mensaje_bloqueos) <> -1 THEN 
		IF LEN(ls_mensaje_bloqueos)= 0 THEN
			mle_diagnostico.text = "OK"
			ib_alumno_sin_bloqueos= TRUE
		ELSE
			mle_diagnostico.text = ls_mensaje_bloqueos
			ib_alumno_sin_bloqueos= FALSE
		END IF
	ELSE
		CLOSE(THIS)
	END IF
END IF

end event

event close;call super::close;if isvalid(gtr_scob) then
	if desconecta_bd(gtr_scob)<>1 then
			MessageBox("Error en Desconexion","No es posible desconectarse de tesorería", StopSign!)			
	end if	
end if

end event

type st_16 from statictext within w_diagnostico_certificado
integer x = 2199
integer y = 640
integer width = 411
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 80269524
string text = "Diagnóstico"
boolean focusrectangle = false
end type

type mle_diagnostico from multilineedit within w_diagnostico_certificado
integer x = 1902
integer y = 736
integer width = 1006
integer height = 424
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15793151
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_15 from statictext within w_diagnostico_certificado
integer x = 1362
integer y = 532
integer width = 247
integer height = 92
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Completa"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_18 from statictext within w_diagnostico_certificado
integer x = 1115
integer y = 532
integer width = 247
integer height = 92
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Faltantes"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_14 from statictext within w_diagnostico_certificado
integer x = 869
integer y = 532
integer width = 247
integer height = 92
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Cursados"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_1 from statictext within w_diagnostico_certificado
integer x = 622
integer y = 532
integer width = 247
integer height = 92
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Mínimos"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_13 from statictext within w_diagnostico_certificado
integer x = 105
integer y = 1580
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Menor Optativa"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_12 from statictext within w_diagnostico_certificado
integer x = 105
integer y = 1492
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Mayor Optativa"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_11 from statictext within w_diagnostico_certificado
integer x = 105
integer y = 1404
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Integ Tema IV"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_10 from statictext within w_diagnostico_certificado
integer x = 105
integer y = 1316
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Integ Tema III"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_9 from statictext within w_diagnostico_certificado
integer x = 105
integer y = 1228
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Integ Tema II"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_8 from statictext within w_diagnostico_certificado
integer x = 105
integer y = 1140
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Integ Tema I"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_7 from statictext within w_diagnostico_certificado
integer x = 105
integer y = 1052
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Integ Fundamental"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_6 from statictext within w_diagnostico_certificado
integer x = 105
integer y = 964
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Menor Obligatoria"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_5 from statictext within w_diagnostico_certificado
integer x = 105
integer y = 876
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Servicio Social"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_4 from statictext within w_diagnostico_certificado
integer x = 105
integer y = 788
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Opción Terminal"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_3 from statictext within w_diagnostico_certificado
integer x = 105
integer y = 700
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Mayor Obligatoria"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_2 from statictext within w_diagnostico_certificado
integer x = 105
integer y = 612
integer width = 507
integer height = 96
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Básica"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_cerrar from u_cb within w_diagnostico_certificado
integer x = 1888
integer y = 1832
integer taborder = 20
string text = "Cerrar"
end type

event clicked;call super::clicked;string ls_completo

Message.PowerObjectParm = ist_parametros
ls_completo = dw_revision_estudios.GetItemString(1, "completo")
IF NOT(ib_alumno_sin_bloqueos) THEN
	ls_completo="BLOQUEO"
END IF

CloseWithReturn(parent, ls_completo)


end event

type cb_imprimir from u_cb within w_diagnostico_certificado
integer x = 1381
integer y = 1832
integer taborder = 20
string text = "Imprimir"
end type

event clicked;call super::clicked;ist_parametros.procede_tramite=true
//dw_revision_estudios.print()
dw_revision_estudios.event pfc_print()
end event

type dw_revision_estudios from u_dw within w_diagnostico_certificado
integer x = 613
integer y = 612
integer width = 1019
integer height = 1196
integer taborder = 30
string dataobject = "dw_rev_est_fmc"
boolean vscrollbar = false
end type

type dw_diagnostico from u_dw within w_diagnostico_certificado
integer x = 114
integer y = 12
integer width = 3191
integer height = 448
integer taborder = 10
string dataobject = "d_datos_diagnostico_cert"
end type

