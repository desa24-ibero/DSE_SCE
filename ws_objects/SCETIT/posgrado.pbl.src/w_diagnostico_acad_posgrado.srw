$PBExportHeader$w_diagnostico_acad_posgrado.srw
forward
global type w_diagnostico_acad_posgrado from w_response
end type
type mle_diagnostico from multilineedit within w_diagnostico_acad_posgrado
end type
type cb_cerrar from u_cb within w_diagnostico_acad_posgrado
end type
type cb_imprimir from u_cb within w_diagnostico_acad_posgrado
end type
type dw_diagnostico from u_dw within w_diagnostico_acad_posgrado
end type
end forward

global type w_diagnostico_acad_posgrado from w_response
integer width = 1586
integer height = 732
string title = "Diagnóstico del Alumno"
boolean controlmenu = false
mle_diagnostico mle_diagnostico
cb_cerrar cb_cerrar
cb_imprimir cb_imprimir
dw_diagnostico dw_diagnostico
end type
global w_diagnostico_acad_posgrado w_diagnostico_acad_posgrado

type variables
str_alumno_opc_cero ist_parametros
end variables

on w_diagnostico_acad_posgrado.create
int iCurrent
call super::create
this.mle_diagnostico=create mle_diagnostico
this.cb_cerrar=create cb_cerrar
this.cb_imprimir=create cb_imprimir
this.dw_diagnostico=create dw_diagnostico
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_diagnostico
this.Control[iCurrent+2]=this.cb_cerrar
this.Control[iCurrent+3]=this.cb_imprimir
this.Control[iCurrent+4]=this.dw_diagnostico
end on

on w_diagnostico_acad_posgrado.destroy
call super::destroy
destroy(this.mle_diagnostico)
destroy(this.cb_cerrar)
destroy(this.cb_imprimir)
destroy(this.dw_diagnostico)
end on

event open;long ll_cuenta, ll_cve_carrera, ll_cve_plan, ll_diagnostico
boolean lb_procede_tramite, lb_revisa_cobranzas
integer li_res, li_tiene_adeudos, li_datos_tramites, li_revision_estudios
string ls_diagnostico_posgrado= "", ls_nueva_linea = "~r~n"
uo_atencion_posgrado luo_atencion_posgrado 
integer li_adeuda_finanzas, li_baja_biblioteca, li_baja_disciplina, li_baja_laboratorio

ll_diagnostico= 0 

x=1	
y=1

//Lee los valores recibidos por la ventana anterior
ist_parametros = Message.PowerObjectParm	
	
ll_cuenta=	ist_parametros.cuenta 
ll_cve_carrera = 	ist_parametros.cve_carrera 
ll_cve_plan=	ist_parametros.cve_plan 

luo_atencion_posgrado = CREATE uo_atencion_posgrado
if isvalid(luo_atencion_posgrado) then
	SetPointer(HourGlass!)
	
	li_adeuda_finanzas  = luo_atencion_posgrado.of_adeuda_finanzas(ll_cuenta)
	if li_adeuda_finanzas= -1 then
		MessageBox("Error en Adeudos","Error en la Consulta de Adeudos",StopSign!)
		ll_diagnostico= -1 
	elseif li_adeuda_finanzas= 1 then
		ls_diagnostico_posgrado =	ls_diagnostico_posgrado+"ADEUDO DE FINANZAS" +ls_nueva_linea		
	end if
	
	li_baja_biblioteca  = luo_atencion_posgrado.of_baja_biblioteca(ll_cuenta)
	if li_baja_biblioteca= -1 then
		MessageBox("Error en Biblioteca","Error en la Consulta de Biblioteca",StopSign!)
		ll_diagnostico= -1 
	elseif li_baja_biblioteca= 1 then
		ls_diagnostico_posgrado =	ls_diagnostico_posgrado+"BAJA DE BIBLIOTECA" +ls_nueva_linea		
	end if
	
	li_baja_disciplina  = luo_atencion_posgrado.of_baja_disciplina(ll_cuenta)
	if li_baja_disciplina= -1 then
		MessageBox("Error en Disciplina","Error en la Consulta de Disciplina",StopSign!)
		ll_diagnostico= -1 
	elseif li_baja_disciplina= 1 then
		ls_diagnostico_posgrado =	ls_diagnostico_posgrado+"BAJA DE DISCIPLINA" +ls_nueva_linea		
	end if

	li_baja_laboratorio = luo_atencion_posgrado.of_baja_laboratorio(ll_cuenta)
	if li_baja_laboratorio= -1 then
		MessageBox("Error en Laboratorio","Error en la Consulta de Laboratorio",StopSign!)
		ll_diagnostico= -1 
	elseif li_baja_laboratorio= 1 then
		ls_diagnostico_posgrado =	ls_diagnostico_posgrado+"BAJA DE LABORATORIO" +ls_nueva_linea		
	end if

	SetPointer(Arrow!)
end if 

if isvalid(luo_atencion_posgrado) then
	DESTROY luo_atencion_posgrado
end if
	
	
	
if ll_diagnostico= -1  then
	MessageBox("Información no disponible","No es posible consultar los bloqueos del alumno",StopSign!)
	ist_parametros.procede_tramite=false
	cb_cerrar.event clicked()
	return
else
	ist_parametros.procede_tramite=true	
	if len(trim(ls_diagnostico_posgrado))= 0 then
		ls_diagnostico_posgrado= "ALUMNO SIN BLOQUEOS"
	end if
	
	mle_diagnostico.text= ls_diagnostico_posgrado
	return
end if
	


end event

type mle_diagnostico from multilineedit within w_diagnostico_acad_posgrado
integer x = 114
integer y = 12
integer width = 1339
integer height = 476
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_cerrar from u_cb within w_diagnostico_acad_posgrado
integer x = 608
integer y = 520
integer taborder = 20
string text = "Cerrar"
end type

event clicked;call super::clicked;
Message.PowerObjectParm = ist_parametros
CloseWithReturn(parent, ist_parametros)


end event

type cb_imprimir from u_cb within w_diagnostico_acad_posgrado
boolean visible = false
integer x = 608
integer y = 520
integer taborder = 20
boolean enabled = false
string text = "Imprimir"
end type

event clicked;call super::clicked;ist_parametros.procede_tramite=true
dw_diagnostico.event pfc_print()
end event

type dw_diagnostico from u_dw within w_diagnostico_acad_posgrado
integer x = 114
integer y = 12
integer width = 1339
integer height = 476
integer taborder = 10
string dataobject = "d_diagnostico_acad_opc_cero"
end type

