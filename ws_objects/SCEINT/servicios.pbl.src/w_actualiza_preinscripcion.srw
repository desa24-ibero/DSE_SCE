$PBExportHeader$w_actualiza_preinscripcion.srw
forward
global type w_actualiza_preinscripcion from w_bit_servicios_uia
end type
type rb_1 from radiobutton within w_actualiza_preinscripcion
end type
type rb_2 from radiobutton within w_actualiza_preinscripcion
end type
type cb_transfiere_registros from commandbutton within w_actualiza_preinscripcion
end type
type hpb_transferencia from u_progressbar within w_actualiza_preinscripcion
end type
type st_3 from statictext within w_actualiza_preinscripcion
end type
type st_minutos from statictext within w_actualiza_preinscripcion
end type
type uo_1 from uo_per_ani within w_actualiza_preinscripcion
end type
type gb_3 from groupbox within w_actualiza_preinscripcion
end type
type dw_cuentas from u_dw within w_actualiza_preinscripcion
end type
type rb_ambos from radiobutton within w_actualiza_preinscripcion
end type
end forward

global type w_actualiza_preinscripcion from w_bit_servicios_uia
integer height = 2036
string title = "Actualización de Alumnos a Internet"
rb_1 rb_1
rb_2 rb_2
cb_transfiere_registros cb_transfiere_registros
hpb_transferencia hpb_transferencia
st_3 st_3
st_minutos st_minutos
uo_1 uo_1
gb_3 gb_3
dw_cuentas dw_cuentas
rb_ambos rb_ambos
end type
global w_actualiza_preinscripcion w_actualiza_preinscripcion

type variables
string is_nivel = "A"
n_transfiere_sybase_sql in_transfiere_sybase_sql
long il_array_cuentas[]
end variables

on w_actualiza_preinscripcion.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.cb_transfiere_registros=create cb_transfiere_registros
this.hpb_transferencia=create hpb_transferencia
this.st_3=create st_3
this.st_minutos=create st_minutos
this.uo_1=create uo_1
this.gb_3=create gb_3
this.dw_cuentas=create dw_cuentas
this.rb_ambos=create rb_ambos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.cb_transfiere_registros
this.Control[iCurrent+4]=this.hpb_transferencia
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.st_minutos
this.Control[iCurrent+7]=this.uo_1
this.Control[iCurrent+8]=this.gb_3
this.Control[iCurrent+9]=this.dw_cuentas
this.Control[iCurrent+10]=this.rb_ambos
end on

on w_actualiza_preinscripcion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.cb_transfiere_registros)
destroy(this.hpb_transferencia)
destroy(this.st_3)
destroy(this.st_minutos)
destroy(this.uo_1)
destroy(this.gb_3)
destroy(this.dw_cuentas)
destroy(this.rb_ambos)
end on

event open;datetime ldttm_fecha_servidor, ldttm_fecha_inicial

x=1
y=1

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


//if conecta_bd(itr_web,gs_web_desb, "scedesbloqueo","ventdesb06")<>1 then
//if conecta_bd(itr_web,gs_sweb, "sceactualiza", "actualumno01")<>1 then
//if conecta_bd(itr_web,gs_sweb, "sceinserta", "insalumno01")<>1 then
//if conecta_bd(itr_web,gs_sweb, "sa", "u1a2kdes")<>1 then

//if conecta_bd(itr_web,gs_sweb, "preinsce","futuro")<>1 then
if conecta_bd(itr_web,gs_sweb, gs_usuario,gs_password)<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	close(this)
else 
//	dw_bitacora.SetTransObject(itr_web)
	dw_bitacora.SetTransObject(itr_web)
	dw_cuentas.SetTransObject(itr_web)
end if

ib_usuario_especial = f_usuario_especial(gs_usuario) 

if ib_usuario_especial then
	MessageBox("Bienvenido", "Su usuario es de acceso especial", Information!)
end if

end event

event close;call super::close;if isvalid(in_transfiere_sybase_sql) then
	destroy in_transfiere_sybase_sql
end if

end event

type rb_todos_alumnos from w_bit_servicios_uia`rb_todos_alumnos within w_actualiza_preinscripcion
integer x = 1019
integer y = 780
end type

type rb_solo_alumno from w_bit_servicios_uia`rb_solo_alumno within w_actualiza_preinscripcion
integer x = 1019
integer y = 680
end type

type uo_nombre from w_bit_servicios_uia`uo_nombre within w_actualiza_preinscripcion
end type

type st_2 from w_bit_servicios_uia`st_2 within w_actualiza_preinscripcion
integer y = 792
end type

type st_1 from w_bit_servicios_uia`st_1 within w_actualiza_preinscripcion
integer y = 696
end type

type em_fecha_final from w_bit_servicios_uia`em_fecha_final within w_actualiza_preinscripcion
integer y = 780
end type

type em_fecha_inicial from w_bit_servicios_uia`em_fecha_inicial within w_actualiza_preinscripcion
integer y = 680
end type

type gb_1 from w_bit_servicios_uia`gb_1 within w_actualiza_preinscripcion
integer y = 616
end type

type dw_bitacora from w_bit_servicios_uia`dw_bitacora within w_actualiza_preinscripcion
integer y = 904
integer height = 868
string dataobject = "d_bitacora_alumnos_preinscritos"
end type

event dw_bitacora::carga;string ls_fecha_inicial, ls_fecha_final
date ldt_fecha_inicial, ldt_fecha_final
datetime ldttm_fecha_inicial, ldttm_fecha_final
long ll_num_registros, ll_num_registros_cuentas
long ll_array_cuentas[], ll_row_actual, ll_cuenta_actual
long ll_periodo, ll_anio

if isnull(this.DataObject) then
	return 0
end if

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
ll_periodo = gi_periodo
ll_anio = gi_anio
ll_num_registros = retrieve(il_cuenta, ldttm_fecha_inicial, ldttm_fecha_final, is_nivel, ll_periodo, ll_anio)
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
return ll_num_registros


end event

type gb_2 from w_bit_servicios_uia`gb_2 within w_actualiza_preinscripcion
integer x = 974
integer y = 616
end type

type rb_1 from radiobutton within w_actualiza_preinscripcion
integer x = 1979
integer y = 752
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
end type

event clicked;IF THIS.CHECKED THEN
	is_nivel = "P"
END IF
end event

type rb_2 from radiobutton within w_actualiza_preinscripcion
integer x = 1979
integer y = 828
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

event clicked;IF THIS.CHECKED THEN
	is_nivel = "L"
END IF
end event

type cb_transfiere_registros from commandbutton within w_actualiza_preinscripcion
integer x = 2839
integer y = 636
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

type hpb_transferencia from u_progressbar within w_actualiza_preinscripcion
integer x = 2839
integer y = 788
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

type st_3 from statictext within w_actualiza_preinscripcion
integer x = 3319
integer y = 656
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

type st_minutos from statictext within w_actualiza_preinscripcion
integer x = 3570
integer y = 636
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

type uo_1 from uo_per_ani within w_actualiza_preinscripcion
integer x = 32
integer y = 436
integer taborder = 40
boolean bringtotop = true
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type gb_3 from groupbox within w_actualiza_preinscripcion
integer x = 1925
integer y = 616
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

type dw_cuentas from u_dw within w_actualiza_preinscripcion
integer y = 1520
integer width = 3854
integer taborder = 11
string dataobject = "d_cuentas_alumnos_preinscritos"
boolean resizable = true
borderstyle borderstyle = styleraised!
end type

type rb_ambos from radiobutton within w_actualiza_preinscripcion
integer x = 1979
integer y = 676
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
string text = "Ambos"
boolean checked = true
end type

event clicked;IF THIS.CHECKED THEN
	is_nivel = "A"
END IF
end event

