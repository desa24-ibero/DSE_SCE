$PBExportHeader$w_actualiza_preinscripcion_2013.srw
forward
global type w_actualiza_preinscripcion_2013 from w_bit_servicios_uia_2013
end type
type cb_transfiere_registros from commandbutton within w_actualiza_preinscripcion_2013
end type
type hpb_transferencia from u_progressbar within w_actualiza_preinscripcion_2013
end type
type st_3 from statictext within w_actualiza_preinscripcion_2013
end type
type st_minutos from statictext within w_actualiza_preinscripcion_2013
end type
type dw_cuentas from u_dw within w_actualiza_preinscripcion_2013
end type
type uo_nivel from uo_nivel_2013 within w_actualiza_preinscripcion_2013
end type
type uo_periodo from uo_per_ani within w_actualiza_preinscripcion_2013
end type
end forward

global type w_actualiza_preinscripcion_2013 from w_bit_servicios_uia_2013
integer width = 4709
string title = "Actualización de Alumnos a Internet"
cb_transfiere_registros cb_transfiere_registros
hpb_transferencia hpb_transferencia
st_3 st_3
st_minutos st_minutos
dw_cuentas dw_cuentas
uo_nivel uo_nivel
uo_periodo uo_periodo
end type
global w_actualiza_preinscripcion_2013 w_actualiza_preinscripcion_2013

type variables
string is_nivel = "P"
n_transfiere_sybase_sql in_transfiere_sybase_sql
long il_array_cuentas[]
end variables

on w_actualiza_preinscripcion_2013.create
int iCurrent
call super::create
this.cb_transfiere_registros=create cb_transfiere_registros
this.hpb_transferencia=create hpb_transferencia
this.st_3=create st_3
this.st_minutos=create st_minutos
this.dw_cuentas=create dw_cuentas
this.uo_nivel=create uo_nivel
this.uo_periodo=create uo_periodo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_transfiere_registros
this.Control[iCurrent+2]=this.hpb_transferencia
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_minutos
this.Control[iCurrent+5]=this.dw_cuentas
this.Control[iCurrent+6]=this.uo_nivel
this.Control[iCurrent+7]=this.uo_periodo
end on

on w_actualiza_preinscripcion_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_transfiere_registros)
destroy(this.hpb_transferencia)
destroy(this.st_3)
destroy(this.st_minutos)
destroy(this.dw_cuentas)
destroy(this.uo_nivel)
destroy(this.uo_periodo)
end on

event open;datetime ldttm_fecha_servidor, ldttm_fecha_inicial

m_menu_general_2013.m_registro.m_cargaregistro.visible = true
m_menu_general_2013.m_registro.m_cargaregistro.enabled = true
m_menu_general_2013.m_registro.m_cargaregistro.toolbaritemvisible = true

iu_pipeline_control =  create u_pipeline_control

iu_pipeline_control02 =  create u_pipeline_control

in_transfiere_sybase_sql =  create n_transfiere_sybase_sql

ldttm_fecha_servidor = fecha_servidor(gtr_sce)
ldttm_fecha_inicial = datetime(ldttm_fecha_servidor)

em_fecha_inicial.text = string(ldttm_fecha_inicial,"dd/mm/yyyy")
em_fecha_final.text =  string(ldttm_fecha_servidor,"dd/mm/yyyy")

if conecta_bd(itr_web,gs_sweb,gs_usuario,gs_password)<>1 then
//if conecta_bd(itr_web,gs_sweb, "preinsce","pruebas1")<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	close(this)
else 
	dw_bitacora.SetTransObject(itr_web)
	dw_cuentas.SetTransObject(itr_web)
end if

IF IsValid(This) THEN 
	ib_usuario_especial = f_usuario_especial(gs_usuario) 

	if ib_usuario_especial then
		MessageBox("Bienvenido", "Su usuario es de acceso especial", Information!)
	end if

	uo_nivel.of_carga_control(gtr_sce) 
	
	integer li_result
	
	li_result = uo_nivel.of_carga_arreglo_nivel( )
END IF	
end event

event ue_carga;string ls_fecha_inicial, ls_fecha_final
date ldt_fecha_inicial, ldt_fecha_final
datetime ldttm_fecha_inicial, ldttm_fecha_final
long ll_num_registros, ll_num_registros_cuentas
long ll_array_cuentas[], ll_row_actual, ll_cuenta_actual
long ll_periodo, ll_anio
string ls_array_nivel[]

ls_fecha_inicial= em_fecha_inicial.text
ls_fecha_final= em_fecha_final.text

ldt_fecha_inicial =date(ls_fecha_inicial)
ldt_fecha_final =date(ls_fecha_final)

if ldt_fecha_final < ldt_fecha_inicial then
	MessageBox("Error de fechas","La fecha inicial no debe ser mayor a la fecha final")
end if 

ldt_fecha_final= RelativeDate(ldt_fecha_final, +1)

ldttm_fecha_inicial =datetime(ldt_fecha_inicial)
ldttm_fecha_final =datetime(ldt_fecha_final)
//DESCOMENTAR DESPUES DE PROBAR
ll_periodo = gi_periodo
ll_anio = gi_anio
//ll_periodo = 1
//ll_anio = 2013

uo_nivel.of_carga_arreglo_nivel()
uo_nivel.of_obtiene_array(ls_array_nivel[])

if Upperbound(ls_array_nivel[]) <> 1 then
	Messagebox('Aviso','Debe de escoger solo un nivel')
	uo_nivel.of_carga_arreglo_nivel()
	return
end if

is_nivel = ls_array_nivel[1]

ll_num_registros = dw_bitacora.retrieve(il_cuenta, ldttm_fecha_inicial, ldttm_fecha_final, is_nivel, ll_periodo, ll_anio)
ll_num_registros_cuentas = dw_cuentas.Retrieve(il_cuenta, ldttm_fecha_inicial, ldttm_fecha_final, is_nivel, ll_periodo, ll_anio)

if ll_num_registros_cuentas = 0 then
	MessageBox ("Sin Registros", "No existe información bajo esos criterios",StopSign!)	
end if

FOR ll_row_actual=1 TO ll_num_registros_cuentas
	ll_cuenta_actual = dw_cuentas.GetItemNumber(ll_row_actual, "cuenta")
	ll_array_cuentas[ll_row_actual]= ll_cuenta_actual
NEXT

il_array_cuentas = ll_array_cuentas
hpb_transferencia.of_SetPosition (0)
st_minutos.text = ""
//return ll_num_registros


end event

type st_sistema from w_bit_servicios_uia_2013`st_sistema within w_actualiza_preinscripcion_2013
end type

type p_ibero from w_bit_servicios_uia_2013`p_ibero within w_actualiza_preinscripcion_2013
end type

type uo_nombre from w_bit_servicios_uia_2013`uo_nombre within w_actualiza_preinscripcion_2013
end type

type dw_bitacora from w_bit_servicios_uia_2013`dw_bitacora within w_actualiza_preinscripcion_2013
integer width = 4485
string dataobject = "d_bitacora_alumnos_preinscritos_2013"
end type

type rb_todos_alumnos from w_bit_servicios_uia_2013`rb_todos_alumnos within w_actualiza_preinscripcion_2013
integer x = 1303
end type

type rb_solo_alumno from w_bit_servicios_uia_2013`rb_solo_alumno within w_actualiza_preinscripcion_2013
integer x = 1303
end type

type st_1 from w_bit_servicios_uia_2013`st_1 within w_actualiza_preinscripcion_2013
end type

type st_2 from w_bit_servicios_uia_2013`st_2 within w_actualiza_preinscripcion_2013
end type

type em_fecha_final from w_bit_servicios_uia_2013`em_fecha_final within w_actualiza_preinscripcion_2013
end type

type em_fecha_inicial from w_bit_servicios_uia_2013`em_fecha_inicial within w_actualiza_preinscripcion_2013
end type

type gb_1 from w_bit_servicios_uia_2013`gb_1 within w_actualiza_preinscripcion_2013
end type

type gb_2 from w_bit_servicios_uia_2013`gb_2 within w_actualiza_preinscripcion_2013
integer x = 1257
integer width = 768
end type

type cb_transfiere_registros from commandbutton within w_actualiza_preinscripcion_2013
integer x = 3374
integer y = 716
integer width = 475
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Transfiere Registros"
end type

event clicked;long ll_num_rows, ll_num_segundos
real lr_num_minutos
integer li_res_actualizacion, li_confirmacion
time ltm_hora_inicial, ltm_hora_final

hpb_transferencia.of_SetPosition (0)
hpb_transferencia.of_SetDisplayStyle(1)
hpb_transferencia.of_SetStep ( 50 )
hpb_transferencia.of_SetAutoReset(FALSE)

ll_num_rows = dw_cuentas.RowCount()
IF ll_num_rows <= 0 THEN	
	MessageBox("No existen registros a transferir", "Favor de intentar un periodo distinto", StopSign!)
	return
END IF
li_confirmacion = MessageBox("Confirmación", "¿Desea Insertar los ["+string(ll_num_rows)+"] alumnos?", Question!, YesNo!)

IF li_confirmacion <> 1 THEN	
	return
END IF

ltm_hora_inicial = now()

li_res_actualizacion = in_transfiere_sybase_sql.of_actualizacion_delete_insert( il_array_cuentas, 'd_mat_preinsc_sql_sybase', itr_web, gtr_sce)

IF li_res_actualizacion = -1 THEN	
	MessageBox("Error de transferencia", "No es posible efectuar la actualizacion d_mat_preinsc_sql_sybase", StopSign!)
	return
END IF

hpb_transferencia.of_Increment()

hpb_transferencia.of_Increment()

ltm_hora_final = now()

ll_num_segundos = SecondsAfter ( ltm_hora_inicial, ltm_hora_final )

lr_num_minutos = ll_num_segundos / 60

st_minutos.text = string(lr_num_minutos,"#,###.####")
//MessageBox("Titulo",string(ltm_hora_inicial)+"-"+string(ltm_hora_final))

end event

type hpb_transferencia from u_progressbar within w_actualiza_preinscripcion_2013
event destroy ( )
integer x = 3374
integer y = 868
integer width = 1001
integer height = 96
integer taborder = 50
boolean bringtotop = true
boolean border = true
string pointer = "AppStarting!"
borderstyle borderstyle = stylelowered!
end type

on hpb_transferencia.destroy
call u_progressbar::destroy
end on

type st_3 from statictext within w_actualiza_preinscripcion_2013
integer x = 3854
integer y = 736
integer width = 210
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "Minutos:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_minutos from statictext within w_actualiza_preinscripcion_2013
integer x = 4105
integer y = 716
integer width = 270
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_cuentas from u_dw within w_actualiza_preinscripcion_2013
integer x = 87
integer y = 1520
integer width = 3854
integer taborder = 21
string dataobject = "d_cuentas_alumnos_preinscritos"
boolean resizable = true
borderstyle borderstyle = styleraised!
end type

type uo_nivel from uo_nivel_2013 within w_actualiza_preinscripcion_2013
integer x = 2336
integer y = 696
integer taborder = 40
boolean bringtotop = true
end type

on uo_nivel.destroy
call uo_nivel_2013::destroy
end on

type uo_periodo from uo_per_ani within w_actualiza_preinscripcion_2013
integer x = 3328
integer y = 480
integer taborder = 30
boolean bringtotop = true
boolean enabled = true
end type

on uo_periodo.destroy
call uo_per_ani::destroy
end on

