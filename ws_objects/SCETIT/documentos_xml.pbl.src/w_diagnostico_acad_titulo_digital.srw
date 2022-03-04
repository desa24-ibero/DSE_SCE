$PBExportHeader$w_diagnostico_acad_titulo_digital.srw
forward
global type w_diagnostico_acad_titulo_digital from w_response
end type
type p_preventiva_servicio_soc from picture within w_diagnostico_acad_titulo_digital
end type
type p_preventiva_estudio_ant from picture within w_diagnostico_acad_titulo_digital
end type
type p_preventiva_diseño from picture within w_diagnostico_acad_titulo_digital
end type
type p_preventiva_titulacion from picture within w_diagnostico_acad_titulo_digital
end type
type p_preventiva_tit_sep from picture within w_diagnostico_acad_titulo_digital
end type
type p_preventiva_hist_carreras from picture within w_diagnostico_acad_titulo_digital
end type
type p_preventiva_academicos from picture within w_diagnostico_acad_titulo_digital
end type
type p_preventiva_alumnos from picture within w_diagnostico_acad_titulo_digital
end type
type p_paloma_servicio_soc from picture within w_diagnostico_acad_titulo_digital
end type
type p_tache_servicio_soc from picture within w_diagnostico_acad_titulo_digital
end type
type p_tache_estudio_ant from picture within w_diagnostico_acad_titulo_digital
end type
type p_paloma_estudio_ant from picture within w_diagnostico_acad_titulo_digital
end type
type p_tache_diseño from picture within w_diagnostico_acad_titulo_digital
end type
type p_paloma_diseño from picture within w_diagnostico_acad_titulo_digital
end type
type p_paloma_tit_sep from picture within w_diagnostico_acad_titulo_digital
end type
type p_tache_tit_sep from picture within w_diagnostico_acad_titulo_digital
end type
type p_paloma_titulacion from picture within w_diagnostico_acad_titulo_digital
end type
type p_tache_titulacion from picture within w_diagnostico_acad_titulo_digital
end type
type p_tache_hist_carreras from picture within w_diagnostico_acad_titulo_digital
end type
type p_paloma_hist_carreras from picture within w_diagnostico_acad_titulo_digital
end type
type p_paloma_academicos from picture within w_diagnostico_acad_titulo_digital
end type
type p_tache_academicos from picture within w_diagnostico_acad_titulo_digital
end type
type p_tache_alumnos from picture within w_diagnostico_acad_titulo_digital
end type
type p_paloma_alumnos from picture within w_diagnostico_acad_titulo_digital
end type
type st_9 from statictext within w_diagnostico_acad_titulo_digital
end type
type st_8 from statictext within w_diagnostico_acad_titulo_digital
end type
type st_7 from statictext within w_diagnostico_acad_titulo_digital
end type
type st_6 from statictext within w_diagnostico_acad_titulo_digital
end type
type st_5 from statictext within w_diagnostico_acad_titulo_digital
end type
type st_3 from statictext within w_diagnostico_acad_titulo_digital
end type
type st_2 from statictext within w_diagnostico_acad_titulo_digital
end type
type st_1 from statictext within w_diagnostico_acad_titulo_digital
end type
type dw_servicio_social from datawindow within w_diagnostico_acad_titulo_digital
end type
type dw_titulacion_sep from datawindow within w_diagnostico_acad_titulo_digital
end type
type dw_diseño from datawindow within w_diagnostico_acad_titulo_digital
end type
type dw_titulacion from datawindow within w_diagnostico_acad_titulo_digital
end type
type dw_estudio_ant from datawindow within w_diagnostico_acad_titulo_digital
end type
type dw_hist_carreras from datawindow within w_diagnostico_acad_titulo_digital
end type
type dw_academicos from datawindow within w_diagnostico_acad_titulo_digital
end type
type dw_alumnos from datawindow within w_diagnostico_acad_titulo_digital
end type
type cb_cerrar from u_cb within w_diagnostico_acad_titulo_digital
end type
type cb_imprimir from u_cb within w_diagnostico_acad_titulo_digital
end type
type dw_diagnostico from u_dw within w_diagnostico_acad_titulo_digital
end type
end forward

global type w_diagnostico_acad_titulo_digital from w_response
integer width = 5650
integer height = 2772
string title = "Diagnóstico del Alumno para Título Digital"
boolean controlmenu = false
event type integer wf_valida_titulo_digital ( long al_cuenta )
p_preventiva_servicio_soc p_preventiva_servicio_soc
p_preventiva_estudio_ant p_preventiva_estudio_ant
p_preventiva_diseño p_preventiva_diseño
p_preventiva_titulacion p_preventiva_titulacion
p_preventiva_tit_sep p_preventiva_tit_sep
p_preventiva_hist_carreras p_preventiva_hist_carreras
p_preventiva_academicos p_preventiva_academicos
p_preventiva_alumnos p_preventiva_alumnos
p_paloma_servicio_soc p_paloma_servicio_soc
p_tache_servicio_soc p_tache_servicio_soc
p_tache_estudio_ant p_tache_estudio_ant
p_paloma_estudio_ant p_paloma_estudio_ant
p_tache_diseño p_tache_diseño
p_paloma_diseño p_paloma_diseño
p_paloma_tit_sep p_paloma_tit_sep
p_tache_tit_sep p_tache_tit_sep
p_paloma_titulacion p_paloma_titulacion
p_tache_titulacion p_tache_titulacion
p_tache_hist_carreras p_tache_hist_carreras
p_paloma_hist_carreras p_paloma_hist_carreras
p_paloma_academicos p_paloma_academicos
p_tache_academicos p_tache_academicos
p_tache_alumnos p_tache_alumnos
p_paloma_alumnos p_paloma_alumnos
st_9 st_9
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_3 st_3
st_2 st_2
st_1 st_1
dw_servicio_social dw_servicio_social
dw_titulacion_sep dw_titulacion_sep
dw_diseño dw_diseño
dw_titulacion dw_titulacion
dw_estudio_ant dw_estudio_ant
dw_hist_carreras dw_hist_carreras
dw_academicos dw_academicos
dw_alumnos dw_alumnos
cb_cerrar cb_cerrar
cb_imprimir cb_imprimir
dw_diagnostico dw_diagnostico
end type
global w_diagnostico_acad_titulo_digital w_diagnostico_acad_titulo_digital

type variables
str_alumno_opc_cero ist_parametros
uo_genera_xml_cuenta iuo_genera_xml_cuenta


end variables

event type integer wf_valida_titulo_digital(long al_cuenta);//wf_valida_titulo_digital
//Recibe:		al_cuenta long
//Devuelve: 	-1   Error
//					 0   Cumple con lo necesario




return 0

end event

on w_diagnostico_acad_titulo_digital.create
int iCurrent
call super::create
this.p_preventiva_servicio_soc=create p_preventiva_servicio_soc
this.p_preventiva_estudio_ant=create p_preventiva_estudio_ant
this.p_preventiva_diseño=create p_preventiva_diseño
this.p_preventiva_titulacion=create p_preventiva_titulacion
this.p_preventiva_tit_sep=create p_preventiva_tit_sep
this.p_preventiva_hist_carreras=create p_preventiva_hist_carreras
this.p_preventiva_academicos=create p_preventiva_academicos
this.p_preventiva_alumnos=create p_preventiva_alumnos
this.p_paloma_servicio_soc=create p_paloma_servicio_soc
this.p_tache_servicio_soc=create p_tache_servicio_soc
this.p_tache_estudio_ant=create p_tache_estudio_ant
this.p_paloma_estudio_ant=create p_paloma_estudio_ant
this.p_tache_diseño=create p_tache_diseño
this.p_paloma_diseño=create p_paloma_diseño
this.p_paloma_tit_sep=create p_paloma_tit_sep
this.p_tache_tit_sep=create p_tache_tit_sep
this.p_paloma_titulacion=create p_paloma_titulacion
this.p_tache_titulacion=create p_tache_titulacion
this.p_tache_hist_carreras=create p_tache_hist_carreras
this.p_paloma_hist_carreras=create p_paloma_hist_carreras
this.p_paloma_academicos=create p_paloma_academicos
this.p_tache_academicos=create p_tache_academicos
this.p_tache_alumnos=create p_tache_alumnos
this.p_paloma_alumnos=create p_paloma_alumnos
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.dw_servicio_social=create dw_servicio_social
this.dw_titulacion_sep=create dw_titulacion_sep
this.dw_diseño=create dw_diseño
this.dw_titulacion=create dw_titulacion
this.dw_estudio_ant=create dw_estudio_ant
this.dw_hist_carreras=create dw_hist_carreras
this.dw_academicos=create dw_academicos
this.dw_alumnos=create dw_alumnos
this.cb_cerrar=create cb_cerrar
this.cb_imprimir=create cb_imprimir
this.dw_diagnostico=create dw_diagnostico
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_preventiva_servicio_soc
this.Control[iCurrent+2]=this.p_preventiva_estudio_ant
this.Control[iCurrent+3]=this.p_preventiva_diseño
this.Control[iCurrent+4]=this.p_preventiva_titulacion
this.Control[iCurrent+5]=this.p_preventiva_tit_sep
this.Control[iCurrent+6]=this.p_preventiva_hist_carreras
this.Control[iCurrent+7]=this.p_preventiva_academicos
this.Control[iCurrent+8]=this.p_preventiva_alumnos
this.Control[iCurrent+9]=this.p_paloma_servicio_soc
this.Control[iCurrent+10]=this.p_tache_servicio_soc
this.Control[iCurrent+11]=this.p_tache_estudio_ant
this.Control[iCurrent+12]=this.p_paloma_estudio_ant
this.Control[iCurrent+13]=this.p_tache_diseño
this.Control[iCurrent+14]=this.p_paloma_diseño
this.Control[iCurrent+15]=this.p_paloma_tit_sep
this.Control[iCurrent+16]=this.p_tache_tit_sep
this.Control[iCurrent+17]=this.p_paloma_titulacion
this.Control[iCurrent+18]=this.p_tache_titulacion
this.Control[iCurrent+19]=this.p_tache_hist_carreras
this.Control[iCurrent+20]=this.p_paloma_hist_carreras
this.Control[iCurrent+21]=this.p_paloma_academicos
this.Control[iCurrent+22]=this.p_tache_academicos
this.Control[iCurrent+23]=this.p_tache_alumnos
this.Control[iCurrent+24]=this.p_paloma_alumnos
this.Control[iCurrent+25]=this.st_9
this.Control[iCurrent+26]=this.st_8
this.Control[iCurrent+27]=this.st_7
this.Control[iCurrent+28]=this.st_6
this.Control[iCurrent+29]=this.st_5
this.Control[iCurrent+30]=this.st_3
this.Control[iCurrent+31]=this.st_2
this.Control[iCurrent+32]=this.st_1
this.Control[iCurrent+33]=this.dw_servicio_social
this.Control[iCurrent+34]=this.dw_titulacion_sep
this.Control[iCurrent+35]=this.dw_diseño
this.Control[iCurrent+36]=this.dw_titulacion
this.Control[iCurrent+37]=this.dw_estudio_ant
this.Control[iCurrent+38]=this.dw_hist_carreras
this.Control[iCurrent+39]=this.dw_academicos
this.Control[iCurrent+40]=this.dw_alumnos
this.Control[iCurrent+41]=this.cb_cerrar
this.Control[iCurrent+42]=this.cb_imprimir
this.Control[iCurrent+43]=this.dw_diagnostico
end on

on w_diagnostico_acad_titulo_digital.destroy
call super::destroy
destroy(this.p_preventiva_servicio_soc)
destroy(this.p_preventiva_estudio_ant)
destroy(this.p_preventiva_diseño)
destroy(this.p_preventiva_titulacion)
destroy(this.p_preventiva_tit_sep)
destroy(this.p_preventiva_hist_carreras)
destroy(this.p_preventiva_academicos)
destroy(this.p_preventiva_alumnos)
destroy(this.p_paloma_servicio_soc)
destroy(this.p_tache_servicio_soc)
destroy(this.p_tache_estudio_ant)
destroy(this.p_paloma_estudio_ant)
destroy(this.p_tache_diseño)
destroy(this.p_paloma_diseño)
destroy(this.p_paloma_tit_sep)
destroy(this.p_tache_tit_sep)
destroy(this.p_paloma_titulacion)
destroy(this.p_tache_titulacion)
destroy(this.p_tache_hist_carreras)
destroy(this.p_paloma_hist_carreras)
destroy(this.p_paloma_academicos)
destroy(this.p_tache_academicos)
destroy(this.p_tache_alumnos)
destroy(this.p_paloma_alumnos)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_servicio_social)
destroy(this.dw_titulacion_sep)
destroy(this.dw_diseño)
destroy(this.dw_titulacion)
destroy(this.dw_estudio_ant)
destroy(this.dw_hist_carreras)
destroy(this.dw_academicos)
destroy(this.dw_alumnos)
destroy(this.cb_cerrar)
destroy(this.cb_imprimir)
destroy(this.dw_diagnostico)
end on

event open;
long ll_cuenta, ll_cve_carrera, ll_cve_plan, ll_diagnostico, ll_diagnostico0
boolean lb_procede_tramite, lb_revisa_cobranzas
integer li_res, li_tiene_adeudos, li_datos_tramites, li_revision_estudios, li_inserta_carrera, li_actualizacion
uo_atencion_opc_cero luo_atencion_opc_cero 
string ls_nivel
long  	ll_academicos,  	ll_alumnos, 	ll_diseno,  	ll_domicilio, 	ll_estudio_ant, 	ll_hist_carreras
long 	ll_titulacion, 	ll_titulacion_sep, 	ll_servicio_social
string ls_curp, ls_e_mail, ls_nocedula
integer li_curp_validado, li_cve_escuela, li_cve_sep
datetime ldttm_fecha_examen, ldttm_fecha_expedicion , lddtm_fecha_inicio, lddtm_fechaterminacion
datetime lddtm_fecha_inicio_s, lddtm_fechaterminacion_s
string ls_nombre_institucion_ss
integer li_idfundamentolegalserviciosocial
long li_opcion_titulacion
x=1	
y=1



//Lee los valores recibidos por la ventana anterior
ist_parametros = Message.PowerObjectParm	
	
ll_cuenta=	ist_parametros.cuenta 
ll_cve_carrera = 	ist_parametros.cve_carrera 
ll_cve_plan=	ist_parametros.cve_plan 

ls_nivel = f_obten_nivel(ll_cve_carrera)

luo_atencion_opc_cero = CREATE uo_atencion_opc_cero
SetPointer(Arrow!)
SetPointer(HourGlass!)

if not ISVALID(iuo_genera_xml_cuenta) then
	iuo_genera_xml_cuenta = CREATE uo_genera_xml_cuenta
	SQLCA = gtr_sce
else
	SQLCA = gtr_sce
end if
	
	iuo_genera_xml_cuenta.of_calcula_titulo(ll_cuenta, ll_cve_carrera, ll_cve_plan)
	
//	dw_diagnostico.SetTransObject(gtr_sce)
	dw_academicos.SetTransObject(gtr_sce)
	dw_alumnos.SetTransObject(gtr_sce)
	dw_diseño.SetTransObject(gtr_sce)
	dw_estudio_ant.SetTransObject(gtr_sce)
	dw_hist_carreras.SetTransObject(gtr_sce)	
	dw_titulacion.SetTransObject(gtr_sce)
	dw_titulacion_sep.SetTransObject(gtr_sce)
	dw_servicio_social.SetTransObject(gtr_sce)

	
//	ll_diagnostico = dw_diagnostico.Retrieve(ll_cuenta)
	ll_academicos = dw_academicos.Retrieve(ll_cuenta)
	if ll_academicos <= 0 then
		p_paloma_academicos.visible = false
		p_tache_academicos.visible = true	
		p_preventiva_academicos.visible = true
	else
		p_paloma_academicos.visible = true
		p_tache_academicos.visible = false		
		p_preventiva_academicos.visible = false
	end if	
	
	ll_alumnos = dw_alumnos.Retrieve(ll_cuenta)
	if ll_alumnos <= 0 then
		p_paloma_alumnos.visible = false
		p_tache_alumnos.visible = true	
	else
		ls_curp = dw_alumnos.GetItemString(ll_alumnos, "curp")
		ls_e_mail = dw_alumnos.GetItemString(ll_alumnos, "domicilio_e_mail")
		li_curp_validado = dw_alumnos.GetItemNumber(ll_alumnos, "curp_validado")
		if len(ls_curp)<>18 or len(ls_e_mail)=0 or li_curp_validado = 0 then
			p_preventiva_alumnos.visible = true
		else 
			p_preventiva_alumnos.visible = false
		end if
		p_paloma_alumnos.visible = true
		p_tache_alumnos.visible = false		
	end if	
	
	ll_diseno = dw_diseño.Retrieve(ll_cuenta, ll_cve_carrera, ll_cve_plan)
	if ll_diseno <= 0 then
		p_paloma_diseño.visible = false
		p_tache_diseño.visible = true	
		p_preventiva_diseño.visible = true
	else
		ldttm_fecha_expedicion= dw_diseño.GetItemDateTime(ll_diseno, "diseño_titulacion_fecha_expedicion" )
		if isnull(ldttm_fecha_expedicion)	 then 
			p_preventiva_diseño.visible = true
		else
			p_preventiva_diseño.visible = false
		end if
		p_paloma_diseño.visible = true
		p_tache_diseño.visible = false		
	end if	
	
	
	ll_estudio_ant = dw_estudio_ant.Retrieve(ll_cuenta)
	if ll_estudio_ant <= 0 then
		p_paloma_estudio_ant.visible = false
		p_tache_estudio_ant.visible = true	
		p_preventiva_estudio_ant.visible = true
	else
		 li_cve_escuela = dw_estudio_ant.GetItemNumber(ll_estudio_ant, "estudio_ant_cve_escuela" )
		 li_cve_sep = dw_estudio_ant.GetItemNumber(ll_estudio_ant, "escuelas_cve_sep" )
		 lddtm_fecha_inicio = dw_estudio_ant.GetItemDateTime(ll_estudio_ant, "estudio_ant_fechainicio" )
		 lddtm_fechaterminacion= dw_estudio_ant.GetItemDateTime(ll_estudio_ant, "estudio_ant_fechaterminacion" )
		 ls_nocedula = dw_estudio_ant.GetItemString(ll_estudio_ant, "estudio_ant_nocedula" )
		if isnull(lddtm_fecha_inicio) or isnull(lddtm_fechaterminacion) or isnull(li_cve_escuela) or isnull(li_cve_sep) then
			p_preventiva_estudio_ant.visible = true
		else
			p_preventiva_estudio_ant.visible = true
		end if
		p_paloma_estudio_ant.visible = true
		p_tache_estudio_ant.visible = false		
	end if	
	
	
	ll_hist_carreras = dw_hist_carreras.Retrieve(ll_cuenta)
	if ll_hist_carreras <= 0 then
		p_paloma_hist_carreras.visible = true
		p_tache_hist_carreras.visible = false	
		p_preventiva_hist_carreras.visible = true
	else
		p_paloma_hist_carreras.visible = true
		p_tache_hist_carreras.visible = false		
		p_preventiva_hist_carreras.visible = false
	end if	
	
	ll_titulacion = dw_titulacion.Retrieve(ll_cuenta, ll_cve_carrera, ll_cve_plan)
	if ll_titulacion <= 0 then
		p_paloma_titulacion.visible = false
		p_tache_titulacion.visible = true	
		p_preventiva_titulacion.visible = true
	else
		ldttm_fecha_examen = dw_titulacion.GetItemDateTime(ll_titulacion, "titulacion_fecha_examen" )
		li_opcion_titulacion = dw_titulacion.GetItemNumber(ll_titulacion, "titulacion_opcion_titulacion" )
		if isnull(li_opcion_titulacion) or isnull(ldttm_fecha_examen) then
			p_preventiva_titulacion.visible = true
		else
			p_preventiva_titulacion.visible = false
		end if
		
		p_paloma_titulacion.visible = true
		p_tache_titulacion.visible = false		
	end if	
	
	ll_titulacion_sep = dw_titulacion_sep.Retrieve(ll_cuenta, ll_cve_carrera, ll_cve_plan)
	if ll_titulacion_sep <= 0 then
		p_paloma_tit_sep.visible = false
		p_tache_tit_sep.visible = true	
		p_preventiva_tit_sep.visible = true
	else
		 lddtm_fecha_inicio_s = dw_titulacion_sep.GetItemDateTime(ll_titulacion_sep, "titulacion_sep_fechainicio" )
		 lddtm_fechaterminacion_s= dw_titulacion_sep.GetItemDateTime(ll_titulacion_sep, "titulacion_sep_fechaterminacion" )
		if isnull(lddtm_fecha_inicio_s)  or isnull(lddtm_fechaterminacion_s) then
			p_preventiva_tit_sep.visible = true			
		else
			p_preventiva_tit_sep.visible = false						
		end if
		p_paloma_tit_sep.visible = true
		p_tache_tit_sep.visible = false		
	end if	
	
	ll_servicio_social = dw_servicio_social.Retrieve(ll_cuenta, ll_cve_carrera, ll_cve_plan)
	if ls_nivel= 'P' then
		p_preventiva_servicio_soc.visible = false
		if ll_servicio_social <= 0 then
			p_paloma_servicio_soc.visible = true
			p_tache_servicio_soc.visible = false	
		else
			p_paloma_servicio_soc.visible = true
			p_tache_servicio_soc.visible = false		
		end if	
	else
		if ll_servicio_social <= 0 then
			p_paloma_servicio_soc.visible = false
			p_tache_servicio_soc.visible = true	
		else
			ls_nombre_institucion_ss = dw_servicio_social.GetItemString(ll_servicio_social, "servicio_social_nombre_institucion")
			li_idfundamentolegalserviciosocial= dw_servicio_social.GetItemNumber(ll_servicio_social, "servicio_social_idfundamentolegalserviciosoc")
			if isnull(ls_nombre_institucion_ss)	or isnull(li_idfundamentolegalserviciosocial) then
				p_preventiva_servicio_soc.visible = true
			else 
				p_preventiva_servicio_soc.visible = false
			end if
			p_paloma_servicio_soc.visible = true
			p_tache_servicio_soc.visible = false		
		end if	
	end if



//if isvalid(luo_atencion_opc_cero) then

	
//	ll_diagnostico0= dw_diagnostico.Retrieve(ll_cuenta, ll_cve_carrera, ll_cve_plan)
//	if ll_diagnostico0 = 0 then
//		li_actualizacion=  luo_atencion_opc_cero.of_inserta_carreras(ll_cuenta)
//		if li_actualizacion= 0 then
//			MessageBox("Actualización correcta","Se han actualizado las carreras del alumno", Information!)			
//		elseif li_actualizacion= 100 then
//			MessageBox("Alumno sin datos","El alumno NO tiene información Válida de Licenciatura Cargada~n"+&
//						"NO se han actualizado las carreras del alumno", StopSign!)			
//			return			
//		elseif li_actualizacion= -1 then
//			MessageBox("Error de Actualización","NO se han actualizado las carreras del alumno", StopSign!)			
//			return			
//		end if
//	end if
		
//	li_datos_tramites = luo_atencion_opc_cero.of_actualiza_datos_tramites( ll_cuenta, ll_cve_carrera, ll_cve_plan)
//	if li_datos_tramites= -1 then
//		MessageBox("Error en Actualizar Datos","Error en la actualización de los datos requeridos en el trámite",StopSign!)
//	end if
//	li_tiene_adeudos = luo_atencion_opc_cero.of_adeuda_finanzas( ll_cuenta)
//	if li_tiene_adeudos= -1 then
//		MessageBox("Error en Adeudos","Error en la consulta de adeudos en cobranzas",StopSign!)
//	end if
//	SetPointer(HourGlass!)
//	li_revision_estudios = luo_atencion_opc_cero.of_revision_estudios( ll_cuenta, ll_cve_carrera, ll_cve_plan)
//	SetPointer(Arrow!)
//	if li_revision_estudios= -1 then
//		MessageBox("Error en Revisión de estudios","Error en la ejecución de la revisión de estudios",StopSign!)
//	end if
//
//end if 

//if isvalid(luo_atencion_opc_cero) then
//	DESTROY luo_atencion_opc_cero
//end if
////	li_tiene_adeudos= -1 or
//
//if li_datos_tramites=-1 or li_revision_estudios= -1 then
//	MessageBox("Información no disponible","No es posible consultar el estatus del alumno",StopSign!)
//	ist_parametros.procede_tramite=false
//	cb_cerrar.event clicked()
//	return
//end if

//dw_diagnostico.SetTransObject(gtr_sce)	
//ll_diagnostico= dw_diagnostico.Retrieve(ll_cuenta, ll_cve_carrera, ll_cve_plan)
//	
//if ll_diagnostico= -1  then
//	MessageBox("Información no disponible","No es posible consultar el estatus del alumno [dw_diagnostico]",StopSign!)
//	ist_parametros.procede_tramite=false
//	cb_cerrar.event clicked()
//	return
//elseif ll_diagnostico= 0  then
//	MessageBox("Información inexistente","No es posible consultar el estatus del alumno [dw_diagnostico]",StopSign!)
//	ist_parametros.procede_tramite=false
//	cb_cerrar.event clicked()
//	return
//else
//	ist_parametros.procede_tramite=true	
//	return
//end if
//	



end event

type p_preventiva_servicio_soc from picture within w_diagnostico_acad_titulo_digital
integer x = 5106
integer y = 2076
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "preventiva.bmp"
boolean focusrectangle = false
end type

type p_preventiva_estudio_ant from picture within w_diagnostico_acad_titulo_digital
integer x = 5106
integer y = 1728
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "preventiva.bmp"
boolean focusrectangle = false
end type

type p_preventiva_diseño from picture within w_diagnostico_acad_titulo_digital
integer x = 5106
integer y = 1456
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "preventiva.bmp"
boolean focusrectangle = false
end type

type p_preventiva_titulacion from picture within w_diagnostico_acad_titulo_digital
integer x = 5106
integer y = 1156
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "preventiva.bmp"
boolean focusrectangle = false
end type

type p_preventiva_tit_sep from picture within w_diagnostico_acad_titulo_digital
integer x = 5106
integer y = 836
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "preventiva.bmp"
boolean focusrectangle = false
end type

type p_preventiva_hist_carreras from picture within w_diagnostico_acad_titulo_digital
integer x = 5106
integer y = 580
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "preventiva.bmp"
boolean focusrectangle = false
end type

type p_preventiva_academicos from picture within w_diagnostico_acad_titulo_digital
integer x = 5106
integer y = 348
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "preventiva.bmp"
boolean focusrectangle = false
end type

type p_preventiva_alumnos from picture within w_diagnostico_acad_titulo_digital
integer x = 5106
integer y = 64
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "preventiva.bmp"
boolean focusrectangle = false
end type

type p_paloma_servicio_soc from picture within w_diagnostico_acad_titulo_digital
integer x = 4910
integer y = 2084
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "paloma.bmp"
boolean focusrectangle = false
end type

type p_tache_servicio_soc from picture within w_diagnostico_acad_titulo_digital
integer x = 5289
integer y = 2084
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "tache.bmp"
boolean focusrectangle = false
end type

type p_tache_estudio_ant from picture within w_diagnostico_acad_titulo_digital
integer x = 5289
integer y = 1728
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "tache.bmp"
boolean focusrectangle = false
end type

type p_paloma_estudio_ant from picture within w_diagnostico_acad_titulo_digital
integer x = 4910
integer y = 1728
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "paloma.bmp"
boolean focusrectangle = false
end type

type p_tache_diseño from picture within w_diagnostico_acad_titulo_digital
integer x = 5289
integer y = 1456
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "tache.bmp"
boolean focusrectangle = false
end type

type p_paloma_diseño from picture within w_diagnostico_acad_titulo_digital
integer x = 4910
integer y = 1456
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "paloma.bmp"
boolean focusrectangle = false
end type

type p_paloma_tit_sep from picture within w_diagnostico_acad_titulo_digital
integer x = 4910
integer y = 836
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "paloma.bmp"
boolean focusrectangle = false
end type

type p_tache_tit_sep from picture within w_diagnostico_acad_titulo_digital
integer x = 5289
integer y = 836
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "tache.bmp"
boolean focusrectangle = false
end type

type p_paloma_titulacion from picture within w_diagnostico_acad_titulo_digital
integer x = 4910
integer y = 1156
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "paloma.bmp"
boolean focusrectangle = false
end type

type p_tache_titulacion from picture within w_diagnostico_acad_titulo_digital
integer x = 5289
integer y = 1156
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "tache.bmp"
boolean focusrectangle = false
end type

type p_tache_hist_carreras from picture within w_diagnostico_acad_titulo_digital
integer x = 5289
integer y = 580
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "tache.bmp"
boolean focusrectangle = false
end type

type p_paloma_hist_carreras from picture within w_diagnostico_acad_titulo_digital
integer x = 4910
integer y = 580
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "paloma.bmp"
boolean focusrectangle = false
end type

type p_paloma_academicos from picture within w_diagnostico_acad_titulo_digital
integer x = 4910
integer y = 348
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "paloma.bmp"
boolean focusrectangle = false
end type

type p_tache_academicos from picture within w_diagnostico_acad_titulo_digital
integer x = 5289
integer y = 348
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "tache.bmp"
boolean focusrectangle = false
end type

type p_tache_alumnos from picture within w_diagnostico_acad_titulo_digital
integer x = 5289
integer y = 64
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "tache.bmp"
boolean focusrectangle = false
end type

type p_paloma_alumnos from picture within w_diagnostico_acad_titulo_digital
integer x = 4910
integer y = 64
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "paloma.bmp"
boolean focusrectangle = false
end type

type st_9 from statictext within w_diagnostico_acad_titulo_digital
integer x = 5
integer y = 2112
integer width = 517
integer height = 132
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "TIT- Antecedentes Servicio Social"
boolean focusrectangle = false
end type

type st_8 from statictext within w_diagnostico_acad_titulo_digital
integer x = 5
integer y = 844
integer width = 672
integer height = 116
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "CE - Histórico - Consulta"
boolean focusrectangle = false
end type

type st_7 from statictext within w_diagnostico_acad_titulo_digital
integer x = 5
integer y = 1504
integer width = 695
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "TIT- Diseño"
boolean focusrectangle = false
end type

type st_6 from statictext within w_diagnostico_acad_titulo_digital
integer x = 5
integer y = 1192
integer width = 695
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "TIT- Examen Profesional"
boolean focusrectangle = false
end type

type st_5 from statictext within w_diagnostico_acad_titulo_digital
integer x = 5
integer y = 1788
integer width = 498
integer height = 128
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "TIT- Antecedentes Académicos"
boolean focusrectangle = false
end type

type st_3 from statictext within w_diagnostico_acad_titulo_digital
integer x = 5
integer y = 620
integer width = 603
integer height = 116
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "CE - Nuevos Cambios de Carrera"
boolean focusrectangle = false
end type

type st_2 from statictext within w_diagnostico_acad_titulo_digital
integer x = 5
integer y = 380
integer width = 654
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "CE - Datos Académicos"
boolean focusrectangle = false
end type

type st_1 from statictext within w_diagnostico_acad_titulo_digital
integer x = 5
integer y = 108
integer width = 594
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "CE - Datos Generales"
boolean focusrectangle = false
end type

type dw_servicio_social from datawindow within w_diagnostico_acad_titulo_digital
integer x = 704
integer y = 2016
integer width = 4155
integer height = 352
integer taborder = 60
string title = "none"
string dataobject = "d_servicio_social_titulo_digital"
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_titulacion_sep from datawindow within w_diagnostico_acad_titulo_digital
integer x = 704
integer y = 776
integer width = 4155
integer height = 304
integer taborder = 50
string title = "none"
string dataobject = "d_titulacion_sep_titulo_digital"
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_diseño from datawindow within w_diagnostico_acad_titulo_digital
integer x = 704
integer y = 1412
integer width = 4155
integer height = 232
integer taborder = 50
string title = "none"
string dataobject = "d_diseño_titulacion_titulo_digital"
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_titulacion from datawindow within w_diagnostico_acad_titulo_digital
integer x = 704
integer y = 1104
integer width = 4155
integer height = 304
integer taborder = 40
string title = "none"
string dataobject = "d_titulacion_titulo_digital"
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_estudio_ant from datawindow within w_diagnostico_acad_titulo_digital
integer x = 704
integer y = 1684
integer width = 4155
integer height = 304
integer taborder = 40
string title = "none"
string dataobject = "d_estudio_ant_titulo_digital"
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_hist_carreras from datawindow within w_diagnostico_acad_titulo_digital
integer x = 704
integer y = 544
integer width = 4155
integer height = 204
integer taborder = 30
string title = "none"
string dataobject = "d_hist_carreras_titulo_digital"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_academicos from datawindow within w_diagnostico_acad_titulo_digital
integer x = 704
integer y = 296
integer width = 4155
integer height = 232
integer taborder = 20
string title = "none"
string dataobject = "d_academicos_titulo_digital"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_alumnos from datawindow within w_diagnostico_acad_titulo_digital
integer x = 704
integer y = 36
integer width = 4155
integer height = 232
integer taborder = 20
string title = "none"
string dataobject = "d_alumnos_titulo_digital"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_cerrar from u_cb within w_diagnostico_acad_titulo_digital
integer x = 2889
integer y = 2496
integer taborder = 20
string text = "Cerrar"
end type

event clicked;call super::clicked;
Message.PowerObjectParm = ist_parametros
CloseWithReturn(parent, ist_parametros)


end event

type cb_imprimir from u_cb within w_diagnostico_acad_titulo_digital
integer x = 2382
integer y = 2496
integer taborder = 20
string text = "Imprimir"
end type

event clicked;call super::clicked;ist_parametros.procede_tramite=true
dw_diagnostico.event pfc_print()
end event

type dw_diagnostico from u_dw within w_diagnostico_acad_titulo_digital
boolean visible = false
integer x = 114
integer y = 12
integer width = 3397
integer height = 1748
integer taborder = 10
string dataobject = "d_diagnostico_acad_opc_cero"
end type

