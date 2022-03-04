$PBExportHeader$w_actas_publica_confirmadas.srw
forward
global type w_actas_publica_confirmadas from w_bit_servicios_uia
end type
type rb_1 from radiobutton within w_actas_publica_confirmadas
end type
type rb_2 from radiobutton within w_actas_publica_confirmadas
end type
type cb_transfiere_registros from commandbutton within w_actas_publica_confirmadas
end type
type hpb_transferencia from u_progressbar within w_actas_publica_confirmadas
end type
type st_3 from statictext within w_actas_publica_confirmadas
end type
type st_minutos from statictext within w_actas_publica_confirmadas
end type
type uo_periodo_anio from uo_per_ani within w_actas_publica_confirmadas
end type
type st_4 from statictext within w_actas_publica_confirmadas
end type
type st_registros from statictext within w_actas_publica_confirmadas
end type
type cb_1 from commandbutton within w_actas_publica_confirmadas
end type
type st_periodo_anio from statictext within w_actas_publica_confirmadas
end type
type st_server_origen from statictext within w_actas_publica_confirmadas
end type
type st_server_destino from statictext within w_actas_publica_confirmadas
end type
type st_num_rows_mi from statictext within w_actas_publica_confirmadas
end type
type st_5 from statictext within w_actas_publica_confirmadas
end type
type st_proceso from statictext within w_actas_publica_confirmadas
end type
type st_6 from statictext within w_actas_publica_confirmadas
end type
type cb_actualiza_calif_sql from commandbutton within w_actas_publica_confirmadas
end type
type rb_extrao_tit from radiobutton within w_actas_publica_confirmadas
end type
type rb_ordinario from radiobutton within w_actas_publica_confirmadas
end type
type gb_3 from groupbox within w_actas_publica_confirmadas
end type
type gb_tipo_examen from groupbox within w_actas_publica_confirmadas
end type
end forward

global type w_actas_publica_confirmadas from w_bit_servicios_uia
integer height = 2036
string title = "Transfiere Calificaciones Confirmadas"
rb_1 rb_1
rb_2 rb_2
cb_transfiere_registros cb_transfiere_registros
hpb_transferencia hpb_transferencia
st_3 st_3
st_minutos st_minutos
uo_periodo_anio uo_periodo_anio
st_4 st_4
st_registros st_registros
cb_1 cb_1
st_periodo_anio st_periodo_anio
st_server_origen st_server_origen
st_server_destino st_server_destino
st_num_rows_mi st_num_rows_mi
st_5 st_5
st_proceso st_proceso
st_6 st_6
cb_actualiza_calif_sql cb_actualiza_calif_sql
rb_extrao_tit rb_extrao_tit
rb_ordinario rb_ordinario
gb_3 gb_3
gb_tipo_examen gb_tipo_examen
end type
global w_actas_publica_confirmadas w_actas_publica_confirmadas

type variables
string is_nivel = "P"
n_transfiere_sybase_sql in_transfiere_sybase_sql
long il_array_cuentas[]
integer ii_sql_sybase = 0
integer ii_sybase_sql = 0

uo_periodo_servicios iuo_periodo_servicios
end variables

on w_actas_publica_confirmadas.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.cb_transfiere_registros=create cb_transfiere_registros
this.hpb_transferencia=create hpb_transferencia
this.st_3=create st_3
this.st_minutos=create st_minutos
this.uo_periodo_anio=create uo_periodo_anio
this.st_4=create st_4
this.st_registros=create st_registros
this.cb_1=create cb_1
this.st_periodo_anio=create st_periodo_anio
this.st_server_origen=create st_server_origen
this.st_server_destino=create st_server_destino
this.st_num_rows_mi=create st_num_rows_mi
this.st_5=create st_5
this.st_proceso=create st_proceso
this.st_6=create st_6
this.cb_actualiza_calif_sql=create cb_actualiza_calif_sql
this.rb_extrao_tit=create rb_extrao_tit
this.rb_ordinario=create rb_ordinario
this.gb_3=create gb_3
this.gb_tipo_examen=create gb_tipo_examen
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.cb_transfiere_registros
this.Control[iCurrent+4]=this.hpb_transferencia
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.st_minutos
this.Control[iCurrent+7]=this.uo_periodo_anio
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.st_registros
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.st_periodo_anio
this.Control[iCurrent+12]=this.st_server_origen
this.Control[iCurrent+13]=this.st_server_destino
this.Control[iCurrent+14]=this.st_num_rows_mi
this.Control[iCurrent+15]=this.st_5
this.Control[iCurrent+16]=this.st_proceso
this.Control[iCurrent+17]=this.st_6
this.Control[iCurrent+18]=this.cb_actualiza_calif_sql
this.Control[iCurrent+19]=this.rb_extrao_tit
this.Control[iCurrent+20]=this.rb_ordinario
this.Control[iCurrent+21]=this.gb_3
this.Control[iCurrent+22]=this.gb_tipo_examen
end on

on w_actas_publica_confirmadas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.cb_transfiere_registros)
destroy(this.hpb_transferencia)
destroy(this.st_3)
destroy(this.st_minutos)
destroy(this.uo_periodo_anio)
destroy(this.st_4)
destroy(this.st_registros)
destroy(this.cb_1)
destroy(this.st_periodo_anio)
destroy(this.st_server_origen)
destroy(this.st_server_destino)
destroy(this.st_num_rows_mi)
destroy(this.st_5)
destroy(this.st_proceso)
destroy(this.st_6)
destroy(this.cb_actualiza_calif_sql)
destroy(this.rb_extrao_tit)
destroy(this.rb_ordinario)
destroy(this.gb_3)
destroy(this.gb_tipo_examen)
end on

event open;datetime ldttm_fecha_servidor, ldttm_fecha_inicial
integer li_periodo , li_anio
x=1
y=1

f_obten_periodo(li_periodo, li_anio, 11)

gi_periodo = li_periodo
gi_anio = li_anio

iu_pipeline_control =  create u_pipeline_control

iu_pipeline_control02 =  create u_pipeline_control

in_transfiere_sybase_sql =  create n_transfiere_sybase_sql


ldttm_fecha_servidor = fecha_servidor(gtr_sce)
ldttm_fecha_inicial = datetime(ldttm_fecha_servidor)

em_fecha_inicial.text = string(ldttm_fecha_inicial,"dd/mm/yyyy")
em_fecha_final.text =  string(ldttm_fecha_servidor,"dd/mm/yyyy")


if conecta_bd(itr_web,gs_web_param, gs_usuario, gs_password)<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	close(this)
else 
//	dw_bitacora.SetTransObject(itr_web)
//Asigna el transaction object de SQLSERVER
	dw_bitacora.SetTransObject(itr_web)
end if

ib_usuario_especial = f_usuario_especial(gs_usuario) 

if ib_usuario_especial then
	MessageBox("Bienvenido", "Su usuario es de acceso especial", Information!)
end if

st_server_origen.text =  "SERVER ORIGEN: " +itr_web.dbparm
st_server_destino.text = "SERVER DESTINO: " +gtr_sce.servername

// Se crea objeto de servicios de periodo
iuo_periodo_servicios = CREATE uo_periodo_servicios 
iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, 'L', gtr_sce) 





end event

event close;call super::close;if isvalid(in_transfiere_sybase_sql) then
	destroy in_transfiere_sybase_sql
end if

end event

event activate;call super::activate;integer li_periodo , li_anio
string ls_periodo

f_obten_periodo(li_periodo, li_anio, 11)

gi_periodo = li_periodo
gi_anio = li_anio


ls_periodo = THIS.iuo_periodo_servicios.f_recupera_descripcion( li_periodo, 'L')

//choose case li_periodo
//	case 0
//		ls_periodo = 'PRIMAVERA'
//	case 1
//		ls_periodo = 'VERANO'
//	case 2
//		ls_periodo = 'OTOÑO'
//end choose

st_periodo_anio.text = ls_periodo+" - "+string(li_anio)
end event

type rb_todos_alumnos from w_bit_servicios_uia`rb_todos_alumnos within w_actas_publica_confirmadas
boolean visible = false
integer x = 1019
end type

type rb_solo_alumno from w_bit_servicios_uia`rb_solo_alumno within w_actas_publica_confirmadas
boolean visible = false
integer x = 1019
end type

type uo_nombre from w_bit_servicios_uia`uo_nombre within w_actas_publica_confirmadas
boolean visible = false
end type

type st_2 from w_bit_servicios_uia`st_2 within w_actas_publica_confirmadas
boolean visible = false
end type

type st_1 from w_bit_servicios_uia`st_1 within w_actas_publica_confirmadas
boolean visible = false
end type

type em_fecha_final from w_bit_servicios_uia`em_fecha_final within w_actas_publica_confirmadas
boolean visible = false
end type

type em_fecha_inicial from w_bit_servicios_uia`em_fecha_inicial within w_actas_publica_confirmadas
boolean visible = false
end type

type gb_1 from w_bit_servicios_uia`gb_1 within w_actas_publica_confirmadas
boolean visible = false
end type

type dw_bitacora from w_bit_servicios_uia`dw_bitacora within w_actas_publica_confirmadas
integer x = 91
integer y = 616
integer height = 1152
string dataobject = "d_acta_evaluacion_preeliminar_per_nivel"
end type

event dw_bitacora::retrieverow;call super::retrieverow;string ls_null

if this.rowcount()>0 then
	if not (ib_usuario_especial) then
		setnull(ls_null)
//		this.SetItem(row,"nip2",ls_null)
//		this.SetItem(row,"v_www_bit_nips_password",ls_null)
	end if
end if


end event

event dw_bitacora::carga;string ls_fecha_inicial, ls_fecha_final
date ldt_fecha_inicial, ldt_fecha_final
datetime ldttm_fecha_inicial, ldttm_fecha_final
long ll_num_registros 
long ll_array_cuentas[], ll_row_actual, ll_cuenta_actual
integer li_periodo, li_anio
integer li_periodo_actas, li_anio_actas, li_cve_tipo_examenes[]
long ll_num_actas_nivel_sybase, ll_num_actas_nivel_sql
long ll_num_actas_nivel_L_sybase, ll_num_actas_nivel_L_sql
long ll_num_actas_nivel_P_sybase, ll_num_actas_nivel_P_sql

string ls_desc_nivel, ls_tipo_examen

if isnull(this.DataObject) then
	return 0
end if

if rb_ordinario.checked then
	li_cve_tipo_examenes = {3}
	f_obten_periodo(li_periodo_actas, li_anio_actas, 11)
	ls_tipo_examen ='ORDINARIO'
elseif rb_extrao_tit.checked then
	 li_cve_tipo_examenes= {2,6}
	f_obten_periodo(li_periodo_actas, li_anio_actas, 12)
	ls_tipo_examen ='EXTRAORDINARIO Y A TÍTULO DE SUFICIENCIA'
end if



li_periodo = li_periodo_actas
li_anio = li_anio_actas

if li_periodo_actas<>li_periodo then
	MessageBox ("Periodo Incorrecto", "El periodo elegido no es del periodo de actas",StopSign!)	
	this.Reset()
	return -1
end if

if li_anio_actas<>li_anio then
	MessageBox ("Año Incorrecto", "El año elegido no es del periodo de actas",StopSign!)	
	this.Reset()
	return -1
end if


//Consulta las Actas de Todos los niveles (L y P y TSU)=A
ll_num_registros = retrieve(li_periodo,li_anio, 'A',li_cve_tipo_examenes )

if ll_num_registros = 0 then
	MessageBox ("Sin Registros", "No existe información bajo esos criterios",StopSign!)	
end if

st_registros.text = string(ll_num_registros)


//il_array_cuentas = ll_array_cuentas
hpb_transferencia.of_SetPosition (0)
st_minutos.text = ""
return ll_num_registros


end event

event dw_bitacora::retrieveend;return 0
end event

type gb_2 from w_bit_servicios_uia`gb_2 within w_actas_publica_confirmadas
boolean visible = false
integer x = 974
end type

type rb_1 from radiobutton within w_actas_publica_confirmadas
boolean visible = false
integer x = 133
integer y = 360
integer width = 407
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Posgrado"
boolean checked = true
end type

event clicked;//IF THIS.CHECKED THEN
//	is_nivel = "P"
//END IF
end event

type rb_2 from radiobutton within w_actas_publica_confirmadas
boolean visible = false
integer x = 133
integer y = 460
integer width = 407
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Licenciatura"
end type

event clicked;//IF THIS.CHECKED THEN
//	is_nivel = "L"
//END IF
end event

type cb_transfiere_registros from commandbutton within w_actas_publica_confirmadas
integer x = 101
integer y = 160
integer width = 786
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Transfiere Calificaciones a Sybase"
end type

event clicked;long ll_num_rows, ll_num_segundos
real lr_num_minutos
integer li_res_actualizacion, li_confirmacion, li_periodo, li_anio
string ls_nivel, ls_desc_nivel
time ltm_hora_inicial, ltm_hora_final
integer li_periodo_actas, li_anio_actas
long ll_num_actas_nivel_sybase, ll_num_actas_nivel_sql
long ll_borra_actas_transf_sybase, ll_borra_actas_transf_sql
long ll_borra_alum_transf_sybase, ll_borra_alum_transf_sql
long ll_inserta_actas_transf_sybase, ll_inserta_actas_transf_sql
long ll_inserta_alum_transf_sybase, ll_inserta_alum_transf_sql
integer li_actualiza_actas_transf, li_actualiza_alumnos_transf
integer li_actualiza_mi_calif_transf
integer li_cve_estatus_acta, li_cve_estatus_acta_al, li_cve_estatus_acta_mi
long ll_num_rows_mi
integer li_proceso_transferidas, li_set_estatus_proceso_actas, li_cve_tipo_examen, li_cve_tipo_examenes[]
string ls_tipo_examen
hpb_transferencia.of_SetPosition (0)
hpb_transferencia.of_SetDisplayStyle(1)
hpb_transferencia.of_SetStep ( 20.0 )
hpb_transferencia.of_SetAutoReset(FALSE)

st_proceso.text = 'Transferencia'


//Obtiene el periodo de bajas totales o de Extraordinario y a título de Suficiencia

if rb_ordinario.checked then
	li_cve_tipo_examen = 3
	li_cve_tipo_examenes = {3}
	f_obten_periodo(li_periodo_actas, li_anio_actas, 11)
	ls_tipo_examen ='ORDINARIO'
elseif rb_extrao_tit.checked then
	li_cve_tipo_examen = 26
	li_cve_tipo_examenes = {2,6}
	f_obten_periodo(li_periodo_actas, li_anio_actas, 12)
	ls_tipo_examen ='EXTRAORDINARIO Y A TÍTULO DE SUFICIENCIA'
end if


li_periodo = li_periodo_actas
li_anio = li_anio_actas

if li_periodo_actas<>li_periodo then
	MessageBox ("Periodo Incorrecto", "El periodo elegido no es del periodo de actas",StopSign!)	
	return 
end if

if li_anio_actas<>li_anio then
	MessageBox ("Año Incorrecto", "El año elegido no es del periodo de actas",StopSign!)	
	return 
end if


ltm_hora_inicial = now()

//Cuenta las actas de la tabla de transferencia existentes en SYBASE
ll_num_actas_nivel_sybase = f_num_actas_transf(li_periodo, li_anio, li_cve_tipo_examen, gtr_sce)

if ll_num_actas_nivel_sybase= -1 then
	dw_bitacora.Reset()
	Messagebox("Error de Consulta SYBASE","No es posible consultar las actas, probablemente por permisos",StopSign!)
	return -1	
end if

//Si hay actas en SYBASE, borra los registros de las tablas de transferencia
IF ll_num_actas_nivel_sybase> 0 THEN
	ll_borra_actas_transf_sybase = f_borra_actas_transf(li_periodo, li_anio, li_cve_tipo_examen, gtr_sce)
	ll_borra_alum_transf_sybase = f_borra_alumnos_transf(li_periodo, li_anio, li_cve_tipo_examen, gtr_sce)
	if ll_borra_actas_transf_sybase= -1 or ll_borra_alum_transf_sybase= -1 then
		Messagebox("Error de eliminacion en SYBASE","No es posible transferir las actas, probablemente por permisos",StopSign!)
		return -1			
	end if
END IF

//Cuenta las actas de la tabla de transferencia existentes en SQLSERVER
ll_num_actas_nivel_sql = f_num_actas_transf(li_periodo, li_anio, li_cve_tipo_examen, itr_web)

if ll_num_actas_nivel_sql= -1 then
	dw_bitacora.Reset()
	Messagebox("Error de Consulta SQL","No es posible consultar las actas, probablemente por permisos",StopSign!)
	return -1	
end if

//Si hay actas en SQLSERVER, borra los registros de las tablas de transferencia
IF ll_num_actas_nivel_sql> 0 THEN
	ll_borra_actas_transf_sql = f_borra_actas_transf(li_periodo, li_anio, li_cve_tipo_examen, itr_web)
	ll_borra_alum_transf_sql = f_borra_alumnos_transf(li_periodo, li_anio, li_cve_tipo_examen, itr_web)
	if ll_borra_actas_transf_sql= -1 or ll_borra_alum_transf_sql= -1 then
		Messagebox("Error de eliminacion en SQL","No es posible transferir las actas, probablemente por permisos",StopSign!)
		return -1			
	end if
END IF

//Copia de las tablas originales a las tablas de transferencia en SQLSERVER
ll_inserta_actas_transf_sql = f_inserta_actas_transf(li_periodo, li_anio, li_cve_tipo_examen, itr_web)
ll_inserta_alum_transf_sql  = f_inserta_alumnos_transf(li_periodo, li_anio, li_cve_tipo_examen, itr_web)

if ll_inserta_actas_transf_sql= -1 or ll_inserta_alum_transf_sql= -1 then
		Messagebox("Error de inserción en SQL","No es posible transferir las actas, probablemente por permisos",StopSign!)
		return -1			
end if


//Valida que existan registros a transferir en el datawindow
ll_num_rows = dw_bitacora.RowCount()
IF ll_num_rows <= 0 THEN	
	MessageBox("No existen registros a transferir", "Favor de intentar un periodo distinto", StopSign!)
	return
END IF
li_confirmacion = MessageBox("Confirmación", "¿Desea Insertar las ["+string(ll_num_rows)+"] actas", Question!, YesNo!)

IF li_confirmacion <> 1 THEN	
	return
END IF


//Realiza una inserción de las tablas de transferencia de actas de SQLSERVER ( Origen - itr_web) A SYBASE (Destino - gtr_sce)
li_res_actualizacion = in_transfiere_sybase_sql.of_actualizacion_publicacion_actas( li_periodo, li_anio, li_cve_tipo_examenes, 'd_acta_evaluacion_transf_per_tipo', itr_web, gtr_sce )

IF li_res_actualizacion = -1 THEN	
	MessageBox("Error de transferencia", "No es posible efectuar la actualizacion d_acta_evaluacion_transf_per", StopSign!)
	return
END IF

//Incrementa el progress bar
hpb_transferencia.of_Increment()

//Realiza una inserción de las tablas de transferencia de alumnos de SQLSERVER ( Origen - itr_web) A SYBASE (Destino - gtr_sce)
li_res_actualizacion = in_transfiere_sybase_sql.of_actualizacion_publicacion_actas( li_periodo, li_anio, li_cve_tipo_examenes, 'd_alumno_acta_evaluacion_transf_per_tipo',itr_web, gtr_sce )

IF li_res_actualizacion = -1 THEN	
	MessageBox("Error de transferencia", "No es posible efectuar la actualizacion d_alumno_acta_evaluacion_transf_per", StopSign!)
	return
END IF

//Incrementa el progress bar
hpb_transferencia.of_Increment()

//Actualiza las columnas del acta: cve_estatus_acta, cve_origen_confirmacion, cve_tipo_recepcion en SYBASE (gtr_sce)
//Para las actas de estatus 5 o menor, o sea TODAS
li_cve_estatus_acta = 5
li_actualiza_actas_transf = f_actualiza_actas_transf(li_periodo, li_anio, li_cve_estatus_acta, li_cve_tipo_examen, gtr_sce)
IF li_actualiza_actas_transf = -1 THEN	
	MessageBox("Error de Actualización", "No es posible efectuar la actualizacion de acta_evaluacion_preeliminar", StopSign!)
	return
END IF

//Incrementa el progress bar
hpb_transferencia.of_Increment()

//Actualiza las columnas del acta: calificacion_confirmada,calificacion, ip_calificacion_confirmada ,
//                                 ip_calificacion, fecha_calificacion_confirmada, fecha_calificacion en SYBASE (gtr_sce)
//Para las actas de estatus 5 o menor, o sea TODAS
li_cve_estatus_acta_al = 5
li_actualiza_alumnos_transf = f_actualiza_alumnos_transf(li_periodo, li_anio, li_cve_estatus_acta_al, li_cve_tipo_examen, gtr_sce)

IF li_actualiza_alumnos_transf = -1 THEN	
	MessageBox("Error de Actualización", "No es posible efectuar la actualizacion de alumno_acta_evaluacion_preelim", StopSign!)
	return
END IF

//Incrementa el progress bar
hpb_transferencia.of_Increment()

//Actualiza las columnas del acta: calificacion_confirmada,calificacion, ip_calificacion_confirmada ,
//                                 ip_calificacion, fecha_calificacion_confirmada, fecha_calificacion en SYBASE (gtr_sce)
//Para las actas de estatus 3 o mayor, o sea CONFIRMADAS, IMPRESAS Y RECIBIDAS
li_cve_estatus_acta_mi = 3


if	li_cve_tipo_examen = 3 then
	li_actualiza_mi_calif_transf = f_actualiza_mi_calif_transf(li_periodo, li_anio, li_cve_estatus_acta_mi, ll_num_rows_mi, gtr_sce)
elseif li_cve_tipo_examen = 26 then
	li_actualiza_mi_calif_transf = f_actualiza_ets_calif_transf(li_periodo, li_anio, li_cve_estatus_acta_mi, ll_num_rows_mi, gtr_sce)
end if



IF li_actualiza_mi_calif_transf = -1 THEN	
	MessageBox("Error de Actualización", "No es posible efectuar la actualizacion de mat_inscritas", StopSign!)
	return
END IF

st_num_rows_mi.text = string(ll_num_rows_mi)

//Incrementa el progress bar
hpb_transferencia.of_Increment()

ltm_hora_final = now()

ll_num_segundos = SecondsAfter ( ltm_hora_inicial, ltm_hora_final )

lr_num_minutos = ll_num_segundos / 60

st_minutos.text = string(lr_num_minutos,"#,###.####")
ii_sql_sybase = 1


//2010-07-07 13:10
//Se decidió que no se actualce el estatus al ejecutarse el proceso
//Actualiza el esatus general del proceso de actas para el periodo vigente
//li_proceso_transferidas=7
//li_set_estatus_proceso_actas =f_set_estatus_proceso_actas(li_proceso_transferidas,li_periodo, li_anio,1,gtr_sce)
//if li_set_estatus_proceso_actas = -1 then
//	MessageBox("Error en la actualizacion del proceso de actas ["+string(li_proceso_transferidas)+"]",&
//					"Si la transferencia fue exitosa actualice el registro ["+string(li_proceso_transferidas)+"] de la tabla proceso_actas",StopSign!)
//end if

MessageBox("Aviso","No se ha actualizado el estatus [7] de proceso de actas~n"+&
						"Si esta es la transferencia definitiva será necesario moverlo manualmente en la ventana~n"+&
						"Proceso de Actas en Línea", Information!)

end event

type hpb_transferencia from u_progressbar within w_actas_publica_confirmadas
integer x = 110
integer y = 320
integer width = 1001
integer height = 96
integer taborder = 40
boolean bringtotop = true
boolean border = true
string pointer = "AppStarting!"
borderstyle borderstyle = stylelowered!
end type

on hpb_transferencia.destroy
call u_progressbar::destroy
end on

type st_3 from statictext within w_actas_publica_confirmadas
integer x = 2130
integer y = 260
integer width = 210
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Minutos:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_minutos from statictext within w_actas_publica_confirmadas
integer x = 2382
integer y = 240
integer width = 443
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type uo_periodo_anio from uo_per_ani within w_actas_publica_confirmadas
boolean visible = false
integer x = 2171
integer y = 304
integer width = 1253
integer height = 168
integer taborder = 50
boolean bringtotop = true
boolean enabled = true
end type

on uo_periodo_anio.destroy
call uo_per_ani::destroy
end on

type st_4 from statictext within w_actas_publica_confirmadas
integer x = 2117
integer y = 152
integer width = 224
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Registros:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_registros from statictext within w_actas_publica_confirmadas
integer x = 2382
integer y = 128
integer width = 443
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_actas_publica_confirmadas
boolean visible = false
integer x = 101
integer y = 168
integer width = 786
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Publica Calificaciones a SQL"
end type

event clicked;
integer li_res_actualizacion, li_confirmacion, li_periodo, li_anio
string ls_nivel, ls_desc_nivel
time ltm_hora_inicial, ltm_hora_final
integer li_periodo_actas, li_anio_actas
long ll_num_rows, ll_num_segundos
real lr_num_minutos

hpb_transferencia.of_SetPosition (0)
hpb_transferencia.of_SetDisplayStyle(1)
hpb_transferencia.of_SetStep ( 50.0 )
hpb_transferencia.of_SetAutoReset(FALSE)


if ii_sql_sybase = 0 then
	li_confirmacion =MessageBox("Las Calificaciones no han sido actualizadas en esta sesión","¿Desea replicar las materias así?",Question!,YesNo!)
	if li_confirmacion<>1 then
		return
	end if
end if


li_periodo = gi_periodo
li_anio = gi_anio

f_obten_periodo(li_periodo_actas, li_anio_actas, 11)

if li_periodo_actas<>li_periodo then
	MessageBox ("Periodo Incorrecto", "El periodo elegido no es del periodo de actas",StopSign!)	
	return 
end if

if li_anio_actas<>li_anio then
	MessageBox ("Año Incorrecto", "El año elegido no es del periodo de actas",StopSign!)	
	return 
end if


ltm_hora_inicial = now()

hpb_transferencia.of_Increment()

li_res_actualizacion = in_transfiere_sybase_sql.of_actualizacion_periodo_delete_insert( li_periodo, li_anio, 'd_acta_mat_inscritas_periodo',itr_web, gtr_sce )

IF li_res_actualizacion = -1 THEN	
	MessageBox("Error de transferencia", "No es posible efectuar la actualizacion d_alumno_acta_evaluacion_preelim_per_niv", StopSign!)
	return
END IF
//
hpb_transferencia.of_Increment()

ltm_hora_final = now()

ll_num_segundos = SecondsAfter ( ltm_hora_inicial, ltm_hora_final )

lr_num_minutos = ll_num_segundos / 60

st_minutos.text = string(lr_num_minutos,"#,###.####")


end event

type st_periodo_anio from statictext within w_actas_publica_confirmadas
integer x = 2953
integer y = 56
integer width = 983
integer height = 116
boolean bringtotop = true
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "PERIODO - AÑO"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_server_origen from statictext within w_actas_publica_confirmadas
integer x = 91
integer y = 476
integer width = 3854
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "SERVER ORIGEN:"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_server_destino from statictext within w_actas_publica_confirmadas
integer x = 91
integer y = 564
integer width = 3854
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "SERVER DESTINO:"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_num_rows_mi from statictext within w_actas_publica_confirmadas
integer x = 2382
integer y = 352
integer width = 443
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_5 from statictext within w_actas_publica_confirmadas
integer x = 1838
integer y = 372
integer width = 503
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Califs. Actualizadas:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_proceso from statictext within w_actas_publica_confirmadas
integer x = 2382
integer y = 16
integer width = 443
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_6 from statictext within w_actas_publica_confirmadas
integer x = 2117
integer y = 40
integer width = 224
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Proceso:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_actualiza_calif_sql from commandbutton within w_actas_publica_confirmadas
integer x = 101
integer y = 16
integer width = 786
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Actualiza Calificaciones en SQL"
end type

event clicked;long ll_num_rows, ll_num_segundos
real lr_num_minutos
integer li_res_actualizacion, li_confirmacion, li_periodo, li_anio
string ls_nivel, ls_desc_nivel
time ltm_hora_inicial, ltm_hora_final
integer li_periodo_actas, li_anio_actas
long ll_num_actas_nivel_sybase, ll_num_actas_nivel_sql
long ll_borra_actas_transf_sybase, ll_borra_actas_transf_sql
long ll_borra_alum_transf_sybase, ll_borra_alum_transf_sql
long ll_inserta_actas_transf_sybase, ll_inserta_actas_transf_sql
long ll_inserta_alum_transf_sybase, ll_inserta_alum_transf_sql
integer li_actualiza_actas_transf, li_actualiza_alumnos_transf
integer li_actualiza_mi_calif_transf
integer li_cve_estatus_acta, li_cve_estatus_acta_al, li_cve_estatus_acta_mi
long ll_num_rows_mi
integer li_proceso_transferidas, li_set_estatus_proceso_actas
integer li_cve_tipo_examen = 0
string	ls_tipo_examen
hpb_transferencia.of_SetPosition (0)
hpb_transferencia.of_SetDisplayStyle(1)
hpb_transferencia.of_SetStep ( 34.0 )
hpb_transferencia.of_SetAutoReset(FALSE)

//Obtiene el periodo de bajas totales o de Extraordinario y a título de Suficiencia

if rb_ordinario.checked then
	li_cve_tipo_examen = 3
	f_obten_periodo(li_periodo_actas, li_anio_actas, 11)
	ls_tipo_examen ='ORDINARIO'
elseif rb_extrao_tit.checked then
	li_cve_tipo_examen = 26
	f_obten_periodo(li_periodo_actas, li_anio_actas, 12)
	ls_tipo_examen ='EXTRAORDINARIO Y A TÍTULO DE SUFICIENCIA'
end if



li_periodo = li_periodo_actas
li_anio = li_anio_actas

if li_periodo_actas<>li_periodo then
	MessageBox ("Periodo Incorrecto", "El periodo elegido no es del periodo de actas",StopSign!)	
	return 
end if

if li_anio_actas<>li_anio then
	MessageBox ("Año Incorrecto", "El año elegido no es del periodo de actas",StopSign!)	
	return 
end if


//Valida que existan registros a transferir en el datawindow
ll_num_rows = dw_bitacora.RowCount()
IF ll_num_rows <= 0 THEN	
	MessageBox("No existen registros a transferir", "Favor de intentar un periodo distinto", StopSign!)
	return
END IF

li_confirmacion = MessageBox("Confirmación", "¿Desea Insertar las  calificaciones Confirmadas de ["+ls_tipo_examen+"] correspondientes a las ["+string(ll_num_rows)+"] actas", Question!, YesNo!)

IF li_confirmacion <> 1 THEN	
	return
END IF

st_proceso.text = 'Actualización'

ltm_hora_inicial = now()

//Cuenta las actas de la tabla de transferencia existentes en SQLSERVER
ll_num_actas_nivel_sql = f_num_actas_transf(li_periodo, li_anio, li_cve_tipo_examen, itr_web)

if ll_num_actas_nivel_sql= -1 then
	dw_bitacora.Reset()
	Messagebox("Error de Consulta SQL","No es posible consultar las actas, probablemente por permisos",StopSign!)
	return -1	
end if

//Si hay actas en SQLSERVER, borra los registros de las tablas de transferencia
IF ll_num_actas_nivel_sql> 0 THEN
	ll_borra_actas_transf_sql = f_borra_actas_transf(li_periodo, li_anio, li_cve_tipo_examen, itr_web)
	ll_borra_alum_transf_sql = f_borra_alumnos_transf(li_periodo, li_anio, li_cve_tipo_examen, itr_web)
	if ll_borra_actas_transf_sql= -1 or ll_borra_alum_transf_sql= -1 then
		Messagebox("Error de eliminacion en SQL","No es posible transferir las actas, probablemente por permisos",StopSign!)
		return -1			
	end if
END IF

//Incrementa el progress bar
hpb_transferencia.of_Increment()

//Copia de las tablas originales a las tablas de transferencia en SQLSERVER
ll_inserta_actas_transf_sql = f_inserta_actas_transf(li_periodo, li_anio, li_cve_tipo_examen, itr_web)
ll_inserta_alum_transf_sql  = f_inserta_alumnos_transf(li_periodo, li_anio, li_cve_tipo_examen, itr_web)

if ll_inserta_actas_transf_sql= -1 or ll_inserta_alum_transf_sql= -1 then
		Messagebox("Error de inserción en SQL","No es posible transferir las actas, probablemente por permisos",StopSign!)
		return -1			
end if



//Incrementa el progress bar
hpb_transferencia.of_Increment()

//Actualiza las columnas del acta: calificacion_confirmada,calificacion, ip_calificacion_confirmada ,
//                                 ip_calificacion, fecha_calificacion_confirmada, fecha_calificacion en SQLSERVER (itr_web)
//Para las actas de estatus 3 o mayor, o sea CONFIRMADAS, IMPRESAS Y RECIBIDAS
li_cve_estatus_acta_mi = 3

if	li_cve_tipo_examen = 3 then
	li_actualiza_mi_calif_transf = f_actualiza_mi_calif_transf(li_periodo, li_anio, li_cve_estatus_acta_mi, ll_num_rows_mi, itr_web)
elseif li_cve_tipo_examen = 26 then
	li_actualiza_mi_calif_transf = f_actualiza_ets_calif_transf_sql(li_periodo, li_anio, li_cve_estatus_acta_mi, ll_num_rows_mi, itr_web)
end if

IF li_actualiza_mi_calif_transf = -1 THEN	
	MessageBox("Error de Actualización", "No es posible efectuar la actualizacion de mat_inscritas", StopSign!)
	return
END IF

st_num_rows_mi.text = string(ll_num_rows_mi)

//Incrementa el progress bar
hpb_transferencia.of_Increment()

ltm_hora_final = now()

ll_num_segundos = SecondsAfter ( ltm_hora_inicial, ltm_hora_final )

lr_num_minutos = ll_num_segundos / 60

st_minutos.text = string(lr_num_minutos,"#,###.####")
ii_sql_sybase = 1



end event

type rb_extrao_tit from radiobutton within w_actas_publica_confirmadas
integer x = 1147
integer y = 176
integer width = 795
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Extraordinario y a Título de Suf."
end type

type rb_ordinario from radiobutton within w_actas_publica_confirmadas
integer x = 1147
integer y = 88
integer width = 407
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ordinario"
boolean checked = true
end type

type gb_3 from groupbox within w_actas_publica_confirmadas
boolean visible = false
integer x = 78
integer y = 288
integer width = 896
integer height = 288
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nivel"
end type

type gb_tipo_examen from groupbox within w_actas_publica_confirmadas
integer x = 1088
integer y = 28
integer width = 896
integer height = 220
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo de Examen"
end type

