$PBExportHeader$w_actualiza_sybase_sql.srw
forward
global type w_actualiza_sybase_sql from w_bit_servicios_uia
end type
type rb_1 from radiobutton within w_actualiza_sybase_sql
end type
type rb_2 from radiobutton within w_actualiza_sybase_sql
end type
type cb_transfiere_registros from commandbutton within w_actualiza_sybase_sql
end type
type hpb_transferencia from u_progressbar within w_actualiza_sybase_sql
end type
type st_3 from statictext within w_actualiza_sybase_sql
end type
type st_minutos from statictext within w_actualiza_sybase_sql
end type
type uo_periodo_anio from uo_per_ani within w_actualiza_sybase_sql
end type
type st_4 from statictext within w_actualiza_sybase_sql
end type
type st_registros from statictext within w_actualiza_sybase_sql
end type
type cb_establece_titular_intercambio from commandbutton within w_actualiza_sybase_sql
end type
type dw_titular_intercambio from datawindow within w_actualiza_sybase_sql
end type
type rb_ordinario from radiobutton within w_actualiza_sybase_sql
end type
type rb_extrao_tit from radiobutton within w_actualiza_sybase_sql
end type
type cb_transfiere_sinodales from commandbutton within w_actualiza_sybase_sql
end type
type uo_nivel from uo_nivel_2013 within w_actualiza_sybase_sql
end type
type st_periodo from statictext within w_actualiza_sybase_sql
end type
type gb_nivel from groupbox within w_actualiza_sybase_sql
end type
type gb_tipo_examen from groupbox within w_actualiza_sybase_sql
end type
end forward

global type w_actualiza_sybase_sql from w_bit_servicios_uia
integer height = 2036
string title = "Transferencia de Actas a Internet"
rb_1 rb_1
rb_2 rb_2
cb_transfiere_registros cb_transfiere_registros
hpb_transferencia hpb_transferencia
st_3 st_3
st_minutos st_minutos
uo_periodo_anio uo_periodo_anio
st_4 st_4
st_registros st_registros
cb_establece_titular_intercambio cb_establece_titular_intercambio
dw_titular_intercambio dw_titular_intercambio
rb_ordinario rb_ordinario
rb_extrao_tit rb_extrao_tit
cb_transfiere_sinodales cb_transfiere_sinodales
uo_nivel uo_nivel
st_periodo st_periodo
gb_nivel gb_nivel
gb_tipo_examen gb_tipo_examen
end type
global w_actualiza_sybase_sql w_actualiza_sybase_sql

type variables
string is_nivel = "P"
n_transfiere_sybase_sql in_transfiere_sybase_sql
long il_array_cuentas[]
end variables

forward prototypes
public subroutine wf_despliega_periodo (integer ai_periodo_por_proceso)
end prototypes

public subroutine wf_despliega_periodo (integer ai_periodo_por_proceso);
STRING ls_proceso 
STRING ls_desc_periodo

INTEGER li_periodo
INTEGER li_anio
INTEGER li_periodo_por_proceso



li_periodo_por_proceso = ai_periodo_por_proceso

f_obten_periodo(li_periodo, li_anio, li_periodo_por_proceso)

SELECT proceso
INTO:ls_proceso
FROM periodos_por_procesos
WHERE cve_proceso = :ai_periodo_por_proceso 
AND tipo_periodo = :gs_tipo_periodo
USING gtr_sce;


//ai_periodo
uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios 
luo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, "L", gtr_sce)
ls_desc_periodo = luo_periodo_servicios.f_recupera_descripcion( li_periodo, "L") 

st_periodo.TEXT = ls_proceso + ": " + STRING(ls_desc_periodo) + " - " + STRING(li_anio) 

DESTROY luo_periodo_servicios 

RETURN 













end subroutine

on w_actualiza_sybase_sql.create
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
this.cb_establece_titular_intercambio=create cb_establece_titular_intercambio
this.dw_titular_intercambio=create dw_titular_intercambio
this.rb_ordinario=create rb_ordinario
this.rb_extrao_tit=create rb_extrao_tit
this.cb_transfiere_sinodales=create cb_transfiere_sinodales
this.uo_nivel=create uo_nivel
this.st_periodo=create st_periodo
this.gb_nivel=create gb_nivel
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
this.Control[iCurrent+10]=this.cb_establece_titular_intercambio
this.Control[iCurrent+11]=this.dw_titular_intercambio
this.Control[iCurrent+12]=this.rb_ordinario
this.Control[iCurrent+13]=this.rb_extrao_tit
this.Control[iCurrent+14]=this.cb_transfiere_sinodales
this.Control[iCurrent+15]=this.uo_nivel
this.Control[iCurrent+16]=this.st_periodo
this.Control[iCurrent+17]=this.gb_nivel
this.Control[iCurrent+18]=this.gb_tipo_examen
end on

on w_actualiza_sybase_sql.destroy
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
destroy(this.cb_establece_titular_intercambio)
destroy(this.dw_titular_intercambio)
destroy(this.rb_ordinario)
destroy(this.rb_extrao_tit)
destroy(this.cb_transfiere_sinodales)
destroy(this.uo_nivel)
destroy(this.st_periodo)
destroy(this.gb_nivel)
destroy(this.gb_tipo_examen)
end on

event open;datetime ldttm_fecha_servidor, ldttm_fecha_inicial
integer li_periodo , li_anio
x=1
y=1

f_obten_periodo(li_periodo, li_anio, 11)
// Se despliega el periodo activo 
wf_despliega_periodo(11)

gi_periodo = li_periodo
gi_anio = li_anio

iu_pipeline_control =  create u_pipeline_control
//iu_pipeline_control.dataobject  = "dp_estado_alumno_tramite"

iu_pipeline_control02 =  create u_pipeline_control
//iu_pipeline_control02.dataobject= "dp_solicitud_tramite"

in_transfiere_sybase_sql =  create n_transfiere_sybase_sql

//dw_resultado.SettransObject(gtr_sce)

ldttm_fecha_servidor = fecha_servidor(gtr_sce)
//ldttm_fecha_inicial = datetime(date("1-feb-2006"))
ldttm_fecha_inicial = datetime(ldttm_fecha_servidor)

em_fecha_inicial.text = string(ldttm_fecha_inicial,"dd/mm/yyyy")
em_fecha_final.text =  string(ldttm_fecha_servidor,"dd/mm/yyyy")


//if conecta_bd(itr_web,"WEB_DESB", "scedesbloqueo","ventdesb06")<>1 then
//if conecta_bd(itr_web,"SWEB", "sceactualiza", "actualumno01")<>1 then
//if conecta_bd(itr_web,"SWEB", "sceinserta", "insalumno01")<>1 then
//if conecta_bd(itr_web,"SWEB", "sa", "u1a2kdes")<>1 then
//if conecta_bd(itr_web,"WEB_PARAM", "sa", gs_password)<>1 then

if conecta_bd(itr_web,gs_web_param, gs_usuario, gs_password)<>1 then 
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)  
	close(this)  
else 
//	dw_bitacora.SetTransObject(itr_web)
	dw_bitacora.SetTransObject(gtr_sce)
end if

ib_usuario_especial = f_usuario_especial(gs_usuario) 

if ib_usuario_especial then
	MessageBox("Bienvenido", "Su usuario es de acceso especial", Information!)
end if
dw_titular_intercambio.SetTransObject(itr_web)
dw_titular_intercambio.Retrieve(1)

uo_nivel.of_carga_control(gtr_sce)
end event

event close;call super::close;if isvalid(in_transfiere_sybase_sql) then
	destroy in_transfiere_sybase_sql
end if

end event

type rb_todos_alumnos from w_bit_servicios_uia`rb_todos_alumnos within w_actualiza_sybase_sql
boolean visible = false
integer x = 1019
end type

type rb_solo_alumno from w_bit_servicios_uia`rb_solo_alumno within w_actualiza_sybase_sql
boolean visible = false
integer x = 1019
end type

type uo_nombre from w_bit_servicios_uia`uo_nombre within w_actualiza_sybase_sql
boolean visible = false
end type

type st_2 from w_bit_servicios_uia`st_2 within w_actualiza_sybase_sql
boolean visible = false
end type

type st_1 from w_bit_servicios_uia`st_1 within w_actualiza_sybase_sql
boolean visible = false
end type

type em_fecha_final from w_bit_servicios_uia`em_fecha_final within w_actualiza_sybase_sql
boolean visible = false
end type

type em_fecha_inicial from w_bit_servicios_uia`em_fecha_inicial within w_actualiza_sybase_sql
boolean visible = false
end type

type gb_1 from w_bit_servicios_uia`gb_1 within w_actualiza_sybase_sql
boolean visible = false
end type

type dw_bitacora from w_bit_servicios_uia`dw_bitacora within w_actualiza_sybase_sql
integer y = 648
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
integer li_periodo_actas, li_anio_actas
long ll_num_actas_nivel_sybase, ll_num_actas_nivel_sql
long ll_num_actas_nivel_ext_sybase, ll_num_actas_ext_nivel_sql
long ll_num_actas_nivel_tit_sybase, ll_num_actas_tit_nivel_sql
string ls_desc_nivel, ls_tipo_examen = ''
integer li_cve_tipo_examen_ordinario = 3, li_cve_tipo_examen_extra = 2, li_cve_tipo_examen_tit = 6
integer li_cve_tipo_examenes[]
string ls_array_nivel[]
integer li_result
if isnull(this.DataObject) then
	return 0
end if

//ls_fecha_inicial= em_fecha_inicial.text
//ls_fecha_final= em_fecha_final.text
//
//ldt_fecha_inicial =date(ls_fecha_inicial)
//ldt_fecha_final =date(ls_fecha_final)
//
//if ldt_fecha_final < ldt_fecha_inicial then
//	MessageBox("Error de fechas","La fecha inicial no debe ser mayor a la fecha final")
//end if 
//
//ldt_fecha_final= RelativeDate(ldt_fecha_final, +1)
//
//ldttm_fecha_inicial =datetime(ldt_fecha_inicial)
//ldttm_fecha_final =datetime(ldt_fecha_final)
//
li_periodo = gi_periodo
li_anio = gi_anio


//Obtiene el periodo correspondiente a las Actas Ordinarias
if rb_ordinario.checked = true then
	f_obten_periodo(li_periodo_actas, li_anio_actas, 11)
	ls_tipo_examen = 'ORDINARIO'
	li_cve_tipo_examenes = {3}
//Obtiene el periodo correspondiente a las Actas Extraordinarias
elseif rb_extrao_tit.checked = true then
	f_obten_periodo(li_periodo_actas, li_anio_actas, 12)	
	ls_tipo_examen = 'ET'
	li_cve_tipo_examenes = {2,6}
end if

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

//if is_nivel = 'L' then
//	ls_desc_nivel = 'Licenciatura'
//else
//	ls_desc_nivel = 'Posgrado'
//end if

li_result = uo_nivel.of_carga_arreglo_nivel( )
uo_nivel.of_obtiene_array( ls_array_nivel[] )

If li_result = - 1 Then
	MessageBox("Mensaje del Sistema", "Error al ejecutar uo_nivel.of_carga_arreglo_nivel", StopSign!)
	return -1
End If

If UpperBound(ls_array_nivel[]) <= 0 Then
	MessageBox("Mensaje del Sistema", "Debe seleccionar un nivel", StopSign!)
	return -1
End If

If UpperBound(ls_array_nivel[]) > 1 Then
	MessageBox("Mensaje del Sistema", "Sólo puede seleccionar un nivel", StopSign!)
	return -1
End If

is_nivel = ls_array_nivel[1]
ls_desc_nivel = f_decodifica_nivel(is_nivel) 
//choose case is_nivel
//	case "L"
//		ls_desc_nivel = "Licenciatura"
//	case "P"
//		ls_desc_nivel =	 "Posgrado"
//	case "T"
//		ls_desc_nivel =	 "TSU"
//end choose

//Valida que existe información para transferir
//Si el examen es Ordinario
if ls_tipo_examen = 'ORDINARIO' then

	ll_num_actas_nivel_sybase = f_num_actas_nivel_tipo_examen(li_periodo, li_anio, is_nivel, li_cve_tipo_examen_ordinario, gtr_sce)

	if ll_num_actas_nivel_sybase= -1 then
		this.Reset()
		Messagebox("Error de Consulta SYBASE","No es posible consultar las actas Ordinarias, probablemente por permisos",StopSign!)
		return -1	
	end if

	if ll_num_actas_nivel_sybase =0 then
		this.Reset()
		Messagebox("Actas origen No Generadas","NO se encontraron actas Ordinarias de ["+ls_desc_nivel+"] a Transferir.",StopSign!)
		return -1	
	end if
	
//Si el examen es Extraordinario o a Título de Suficiencia
else
	ll_num_actas_nivel_ext_sybase = f_num_actas_nivel_tipo_examen(li_periodo, li_anio, is_nivel, li_cve_tipo_examen_extra, gtr_sce)

	if ll_num_actas_nivel_ext_sybase= -1 then
		this.Reset()
		Messagebox("Error de Consulta SYBASE","No es posible consultar las actas Extraordinarias, probablemente por permisos",StopSign!)
		return -1	
	end if

	
	ll_num_actas_nivel_tit_sybase = f_num_actas_nivel_tipo_examen(li_periodo, li_anio, is_nivel, li_cve_tipo_examen_tit, gtr_sce)

	if ll_num_actas_nivel_tit_sybase= -1 then
		this.Reset()
		Messagebox("Error de Consulta SYBASE","No es posible consultar las actas A Título, probablemente por permisos",StopSign!)
		return -1	
	end if

//Bajar
	if ll_num_actas_nivel_tit_sybase =0 and ll_num_actas_nivel_ext_sybase =0 then
		this.Reset()
		Messagebox("Actas origen No Generadas","NO se encontraron actas A Extraordinario y A Título de ["+ls_desc_nivel+"] a Transferir.",StopSign!)
		return -1	
	end if

////Bajar
//	if ll_num_actas_nivel_ext_sybase =0 then
//		this.Reset()
//		Messagebox("Actas origen No Generadas","NO se encontraron actas Extraordinario de ["+ls_desc_nivel+"] a Transferir.",StopSign!)
//		return -1	
//	end if
			
end if


//Valida que no se haya transferido información previamente
//Si el examen es Ordinario
if ls_tipo_examen = 'ORDINARIO' then

	ll_num_actas_nivel_sql = f_num_actas_nivel_tipo_examen(li_periodo, li_anio, is_nivel, li_cve_tipo_examen_ordinario, itr_web)

	if ll_num_actas_nivel_sql= -1 then
		this.Reset()
		Messagebox("Error de Consulta SQL","No es posible consultar las actas, probablemente por permisos",StopSign!)
		return -1	
	end if

	if ll_num_actas_nivel_sql >0 then
		this.Reset()
		Messagebox("Actas Destino Generadas","Se encontraron ["+string(ll_num_actas_nivel_sql)+"] actas Ordinarias de ["+ls_desc_nivel+"] previamente Transferidas.",StopSign!)
		return -1	
	end if
//Si el examen es Extraordinario o a Título de Suficiencia
else
	ll_num_actas_ext_nivel_sql = f_num_actas_nivel_tipo_examen(li_periodo, li_anio, is_nivel, li_cve_tipo_examen_extra, itr_web)

	if ll_num_actas_ext_nivel_sql= -1 then
		this.Reset()
		Messagebox("Error de Consulta SQL","No es posible consultar las actas, probablemente por permisos",StopSign!)
		return -1	
	end if

	
	ll_num_actas_tit_nivel_sql = f_num_actas_nivel_tipo_examen(li_periodo, li_anio, is_nivel, li_cve_tipo_examen_tit, itr_web)

	if ll_num_actas_tit_nivel_sql= -1 then
		this.Reset()
		Messagebox("Error de Consulta SQL","No es posible consultar las actas, probablemente por permisos",StopSign!)
		return -1	
	end if

//Bajar
	if ll_num_actas_tit_nivel_sql >0 or ll_num_actas_ext_nivel_sql >0 then
		this.Reset()
		Messagebox("Actas Destino Generadas","Se encontraron ["+string(ll_num_actas_tit_nivel_sql+ll_num_actas_ext_nivel_sql)+"] actas Extraordinarias de ["+ls_desc_nivel+"] previamente Transferidas.",StopSign!)
		return -1	
	end if

////Bajar
//	if ll_num_actas_ext_nivel_sql >0 then
//		this.Reset()
//		Messagebox("Actas Destino Generadas","Se encontraron ["+string(ll_num_actas_ext_nivel_sql)+"] actas Extraordinarias de ["+ls_desc_nivel+"] previamente Transferidas.",StopSign!)
//		return -1	
//	end if

end if

ll_num_registros = retrieve(li_periodo,li_anio, is_nivel, li_cve_tipo_examenes)
if ll_num_registros = 0 then
	MessageBox ("Sin Registros", "No existe información bajo esos criterios",StopSign!)	
end if

st_registros.text = string(ll_num_registros)

//FOR ll_row_actual=1 TO ll_num_registros
//	ll_cuenta_actual = this.GetItemNumber(ll_row_actual, "cuenta")
//	ll_array_cuentas[ll_row_actual]= ll_cuenta_actual
//NEXT


//il_array_cuentas = ll_array_cuentas
hpb_transferencia.of_SetPosition (0)
st_minutos.text = ""
return ll_num_registros


end event

event dw_bitacora::retrieveend;return 0
end event

type gb_2 from w_bit_servicios_uia`gb_2 within w_actualiza_sybase_sql
boolean visible = false
integer x = 974
end type

type rb_1 from radiobutton within w_actualiza_sybase_sql
boolean visible = false
integer x = 73
integer y = 304
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

type rb_2 from radiobutton within w_actualiza_sybase_sql
boolean visible = false
integer x = 73
integer y = 368
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

type cb_transfiere_registros from commandbutton within w_actualiza_sybase_sql
integer x = 992
integer y = 32
integer width = 475
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Transfiere Actas"
end type

event clicked;long ll_num_rows, ll_num_segundos
real lr_num_minutos
integer li_res_actualizacion, li_confirmacion, li_periodo, li_anio, li_cve_tipo_examenes[]
string ls_nivel, ls_desc_nivel, ls_tipo_examen
time ltm_hora_inicial, ltm_hora_final
integer li_periodo_actas, li_anio_actas, li_proceso_publicadas, li_set_estatus_proceso_actas

hpb_transferencia.of_SetPosition (0)
hpb_transferencia.of_SetDisplayStyle(1)
hpb_transferencia.of_SetStep ( 50.0 )
hpb_transferencia.of_SetAutoReset(FALSE)


li_periodo = gi_periodo
li_anio = gi_anio




//Obtiene el periodo correspondiente a las Actas Ordinarias
if rb_ordinario.checked = true then
	f_obten_periodo(li_periodo_actas, li_anio_actas, 11)
	ls_tipo_examen = 'ORDINARIO'
	li_cve_tipo_examenes = {3}
//Obtiene el periodo correspondiente a las Actas Extraordinarias
elseif rb_extrao_tit.checked = true then
	f_obten_periodo(li_periodo_actas, li_anio_actas, 12)	
	ls_tipo_examen = 'ET'
	li_cve_tipo_examenes = {2,6}
end if




if li_periodo_actas<>li_periodo then
	MessageBox ("Periodo Incorrecto", "El periodo elegido no es del periodo de actas",StopSign!)	
	return 
end if

if li_anio_actas<>li_anio then
	MessageBox ("Año Incorrecto", "El año elegido no es del periodo de actas",StopSign!)	
	return 
end if

//if is_nivel = 'L' then
//	ls_nivel = is_nivel
//	ls_desc_nivel = 'Licenciatura'
//else
//	ls_nivel = is_nivel
//	ls_desc_nivel = 'Posgrado'
//end if

ls_nivel = is_nivel
ls_desc_nivel = f_decodifica_nivel(ls_nivel) 

//choose case is_nivel
//	case "L"
//		ls_nivel = is_nivel
//		ls_desc_nivel = "Licenciatura"
//	case "P"
//		ls_nivel = is_nivel
//		ls_desc_nivel =	 "Posgrado"
//	case "T"
//		ls_nivel = is_nivel
//		ls_desc_nivel =	 "TSU"
//end choose

ll_num_rows = dw_bitacora.RowCount()
IF ll_num_rows <= 0 THEN	
	MessageBox("No existen registros a transferir", "Favor de intentar un periodo distinto", StopSign!)
	return
END IF
li_confirmacion = MessageBox("Confirmación", "¿Desea Insertar las ["+string(ll_num_rows)+"] actas", Question!, YesNo!)

IF li_confirmacion <> 1 THEN	
	return
END IF

ltm_hora_inicial = now()

li_res_actualizacion = in_transfiere_sybase_sql.of_actualizacion_incremental_actas( li_periodo, li_anio, ls_nivel, 'd_acta_evaluacion_preeliminar_per_nivel', li_cve_tipo_examenes, gtr_sce, itr_web)

IF li_res_actualizacion = -1 THEN	
	MessageBox("Error de transferencia", "No es posible efectuar la actualizacion d_acta_evaluacion_preeliminar_per_nivel", StopSign!)
	return
END IF

hpb_transferencia.of_Increment()

li_res_actualizacion = in_transfiere_sybase_sql.of_actualizacion_incremental_actas( li_periodo, li_anio, ls_nivel, 'd_alumno_acta_evaluacion_preelim_per_niv', li_cve_tipo_examenes, gtr_sce, itr_web)

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
//Actualiza el esatus general del proceso de actas para el periodo vigente
li_proceso_publicadas=2
li_set_estatus_proceso_actas =f_set_estatus_proceso_actas(li_proceso_publicadas,li_periodo_actas, li_anio_actas,1,gtr_sce)
if li_set_estatus_proceso_actas = -1 then
	MessageBox("Error en la actualizacion del proceso de actas ["+string(li_proceso_publicadas)+"]",&
					"Si la transferencia fue exitosa actualice el registro ["+string(li_proceso_publicadas)+"] de la tabla proceso_actas",StopSign!)
end if

//MessageBox("Titulo",string(ltm_hora_inicial)+"-"+string(ltm_hora_final))

end event

type hpb_transferencia from u_progressbar within w_actualiza_sybase_sql
integer x = 1001
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

type st_3 from statictext within w_actualiza_sybase_sql
integer x = 1481
integer y = 188
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

type st_minutos from statictext within w_actualiza_sybase_sql
integer x = 1733
integer y = 168
integer width = 270
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

type uo_periodo_anio from uo_per_ani within w_actualiza_sybase_sql
integer x = 2167
integer y = 44
integer width = 1253
integer height = 168
integer taborder = 50
boolean bringtotop = true
boolean enabled = true
end type

on uo_periodo_anio.destroy
call uo_per_ani::destroy
end on

type st_4 from statictext within w_actualiza_sybase_sql
integer x = 1467
integer y = 80
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

type st_registros from statictext within w_actualiza_sybase_sql
integer x = 1733
integer y = 56
integer width = 270
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

type cb_establece_titular_intercambio from commandbutton within w_actualiza_sybase_sql
integer x = 2441
integer y = 252
integer width = 741
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Establece Titular de Intercambio"
end type

event clicked;
long ll_num_rows, ll_num_segundos
real lr_num_minutos
integer li_res_actualizacion, li_confirmacion, li_periodo, li_anio
//string ls_nivel, ls_desc_nivel
time ltm_hora_inicial, ltm_hora_final
integer li_periodo_actas, li_anio_actas, li_actualiza_titular_intercambio
long ll_rows_intercambio, ll_num_empleado
string ls_nombre_completo

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

li_confirmacion = MessageBox("Confirmación", "¿Desea actualizar al titular de Intercambio en las actas?", Question!, YesNo!)

IF li_confirmacion <> 1 THEN	
	return
END IF

ll_rows_intercambio = dw_titular_intercambio.RowCount()

if ll_rows_intercambio>0 then
	ll_num_empleado = dw_titular_intercambio.GetItemNumber(1,"num_empleado")
	ls_nombre_completo = dw_titular_intercambio.GetItemString(1,"nombre_completo")
	li_actualiza_titular_intercambio = f_actualiza_titular_intercambio(li_periodo_actas, li_anio_actas,ll_num_empleado,itr_web)
	if li_actualiza_titular_intercambio=-1 then
		MessageBox ("Error de Asignación", "No se ha establecido al Titular de Intercambio",StopSign!)	
		return 
	elseif li_actualiza_titular_intercambio=0 then
		MessageBox ("Asignación de Titular Exitosa", "Se ha establecido al Titular de Intercambio Correctamente",Information!)	
	elseif li_actualiza_titular_intercambio=100 then
		MessageBox ("Asignación de Titular Previa", "El Titular de Intercambio ya estaba establecido",Information!)	
	end if
	
	integer li_proceso_intercambio, li_set_estatus_proceso_actas

	li_proceso_intercambio=3
	li_set_estatus_proceso_actas =f_set_estatus_proceso_actas(li_proceso_intercambio,li_periodo_actas, li_anio_actas,1,gtr_sce)
	if li_set_estatus_proceso_actas = -1 then
		MessageBox("Error en la actualizacion del proceso de actas ["+string(li_proceso_intercambio)+"]",&
					"Si la transferencia fue exitosa actualice el registro ["+string(li_proceso_intercambio)+"] de la tabla proceso_actas",StopSign!)
	end if
else
	MessageBox ("Titular Inválido", "No se ha establecido al Titular de Intercambio",StopSign!)	
	return 
end if

end event

type dw_titular_intercambio from datawindow within w_actualiza_sybase_sql
integer x = 2098
integer y = 360
integer width = 1431
integer height = 180
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_titular_intercambio_acta"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_ordinario from radiobutton within w_actualiza_sybase_sql
integer x = 46
integer y = 72
integer width = 407
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Ordinario"
boolean checked = true
end type

event clicked;cb_transfiere_sinodales.enabled = false

IF THIS.CHECKED THEN wf_despliega_periodo(11)
end event

type rb_extrao_tit from radiobutton within w_actualiza_sybase_sql
integer x = 46
integer y = 148
integer width = 873
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Extraordinario y a Título de Suf."
end type

event clicked;cb_transfiere_sinodales.enabled = true

IF THIS.CHECKED THEN wf_despliega_periodo(12) 


end event

type cb_transfiere_sinodales from commandbutton within w_actualiza_sybase_sql
integer x = 992
integer y = 168
integer width = 485
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Transfiere Sinodales"
end type

event clicked;long ll_num_rows, ll_num_segundos, ll_num_registros
real lr_num_minutos
integer li_res_actualizacion, li_confirmacion, li_periodo, li_anio
string ls_nivel, ls_desc_nivel
time ltm_hora_inicial, ltm_hora_final
integer li_periodo_actas, li_anio_actas, li_proceso_publicadas, li_set_estatus_proceso_actas

hpb_transferencia.of_SetPosition (0)
hpb_transferencia.of_SetDisplayStyle(1)
hpb_transferencia.of_SetStep ( 50.0 )
hpb_transferencia.of_SetAutoReset(FALSE)


li_periodo = gi_periodo
li_anio = gi_anio

f_obten_periodo(li_periodo_actas, li_anio_actas, 12)

if li_periodo_actas<>li_periodo then
	MessageBox ("Periodo Incorrecto", "El periodo elegido no es del periodo de actas",StopSign!)	
	return 
end if

if li_anio_actas<>li_anio then
	MessageBox ("Año Incorrecto", "El año elegido no es del periodo de actas",StopSign!)	
	return 
end if

//if is_nivel = 'L' then
//	ls_nivel = is_nivel
//	ls_desc_nivel = 'Licenciatura'
//else
//	ls_nivel = is_nivel
//	ls_desc_nivel = 'Posgrado'
//end if

ls_nivel = is_nivel
ls_desc_nivel = f_decodifica_nivel(ls_nivel) 


//choose case is_nivel
//	case "L"
//		ls_nivel = is_nivel
//		ls_desc_nivel = "Licenciatura"
//	case "P"
//		ls_nivel = is_nivel
//		ls_desc_nivel =	 "Posgrado"
//	case "T"
//		ls_nivel = is_nivel
//		ls_desc_nivel =	 "TSU"
//end choose

dw_bitacora.dataobject = 'd_grupo_sinodal_ets_periodo'
dw_bitacora.SetTransObject(gtr_sce)


ll_num_registros = dw_bitacora.retrieve(li_periodo,li_anio)

if ll_num_registros = 0 then
	MessageBox ("Sin Registros", "No existe información bajo esos criterios",StopSign!)	
end if

st_registros.text = string(ll_num_registros)


ll_num_rows = dw_bitacora.RowCount()
IF ll_num_rows <= 0 THEN	
	MessageBox("No existen registros a transferir", "Favor de intentar un periodo distinto", StopSign!)
	dw_bitacora.dataobject = 'd_acta_evaluacion_preeliminar_per_nivel'
	dw_bitacora.SetTransObject(gtr_sce)
	return
END IF
li_confirmacion = MessageBox("Confirmación", "¿Desea Insertar los ["+string(ll_num_rows)+"] registros de sinodales", Question!, YesNo!)

IF li_confirmacion <> 1 THEN	
	dw_bitacora.dataobject = 'd_acta_evaluacion_preeliminar_per_nivel'
	dw_bitacora.SetTransObject(gtr_sce)
	return
END IF

ltm_hora_inicial = now()

hpb_transferencia.of_Increment()

li_res_actualizacion = in_transfiere_sybase_sql.of_actualizacion_incremental_ets( li_periodo, li_anio, 'd_grupo_sinodal_ets_periodo', gtr_sce, itr_web)

IF li_res_actualizacion = -1 THEN	
	MessageBox("Error de transferencia", "No es posible efectuar la actualizacion en d_grupo_sinodal_ets_periodo", StopSign!)
	dw_bitacora.dataobject = 'd_acta_evaluacion_preeliminar_per_nivel'
	dw_bitacora.SetTransObject(gtr_sce)
	return
END IF

hpb_transferencia.of_Increment()

ltm_hora_final = now()

ll_num_segundos = SecondsAfter ( ltm_hora_inicial, ltm_hora_final )

lr_num_minutos = ll_num_segundos / 60

st_minutos.text = string(lr_num_minutos,"#,###.####")

dw_bitacora.dataobject = 'd_acta_evaluacion_preeliminar_per_nivel'
dw_bitacora.SetTransObject(gtr_sce)

MessageBox ("Transferencia Exitosa", "Se transfirieron los sinodales de Extraordinario y a Título de Suficiencia Exitosamente.",Information!)	

end event

type uo_nivel from uo_nivel_2013 within w_actualiza_sybase_sql
integer x = 73
integer y = 292
integer taborder = 60
boolean bringtotop = true
end type

on uo_nivel.destroy
call uo_nivel_2013::destroy
end on

type st_periodo from statictext within w_actualiza_sybase_sql
integer x = 713
integer y = 480
integer width = 1330
integer height = 148
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 67108864
string text = "Periodo:"
boolean focusrectangle = false
end type

type gb_nivel from groupbox within w_actualiza_sybase_sql
integer x = 18
integer y = 232
integer width = 896
integer height = 220
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

type gb_tipo_examen from groupbox within w_actualiza_sybase_sql
integer x = 14
integer y = 12
integer width = 923
integer height = 220
integer taborder = 60
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

