$PBExportHeader$w_bit_servicios_uia_2013.srw
forward
global type w_bit_servicios_uia_2013 from w_master_main
end type
type uo_nombre from uo_nombre_alumno_2013 within w_bit_servicios_uia_2013
end type
type dw_bitacora from datawindow within w_bit_servicios_uia_2013
end type
type rb_todos_alumnos from radiobutton within w_bit_servicios_uia_2013
end type
type rb_solo_alumno from radiobutton within w_bit_servicios_uia_2013
end type
type st_1 from statictext within w_bit_servicios_uia_2013
end type
type st_2 from statictext within w_bit_servicios_uia_2013
end type
type em_fecha_final from u_em within w_bit_servicios_uia_2013
end type
type em_fecha_inicial from u_em within w_bit_servicios_uia_2013
end type
type gb_1 from groupbox within w_bit_servicios_uia_2013
end type
type gb_2 from groupbox within w_bit_servicios_uia_2013
end type
end forward

global type w_bit_servicios_uia_2013 from w_master_main
integer x = 5
integer y = 4
integer width = 4238
integer height = 2704
string title = "Cambio de NIP a PASSWORD"
string menuname = "m_menu_general_2013"
boolean center = true
uo_nombre uo_nombre
dw_bitacora dw_bitacora
rb_todos_alumnos rb_todos_alumnos
rb_solo_alumno rb_solo_alumno
st_1 st_1
st_2 st_2
em_fecha_final em_fecha_final
em_fecha_inicial em_fecha_inicial
gb_1 gb_1
gb_2 gb_2
end type
global w_bit_servicios_uia_2013 w_bit_servicios_uia_2013

type variables
long il_num_tramites_inicial, il_num_tramites_final, il_cuenta
u_pipeline_control iu_pipeline_control, iu_pipeline_control02
n_tr i_tr_origen, i_tr_destino
boolean ib_usuario_especial=false

st_confirma_usuario ist_confirma_usuario
transaction itr_web

end variables

on w_bit_servicios_uia_2013.create
int iCurrent
call super::create
if this.MenuName = "m_menu_general_2013" then this.MenuID = create m_menu_general_2013
this.uo_nombre=create uo_nombre
this.dw_bitacora=create dw_bitacora
this.rb_todos_alumnos=create rb_todos_alumnos
this.rb_solo_alumno=create rb_solo_alumno
this.st_1=create st_1
this.st_2=create st_2
this.em_fecha_final=create em_fecha_final
this.em_fecha_inicial=create em_fecha_inicial
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_nombre
this.Control[iCurrent+2]=this.dw_bitacora
this.Control[iCurrent+3]=this.rb_todos_alumnos
this.Control[iCurrent+4]=this.rb_solo_alumno
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.em_fecha_final
this.Control[iCurrent+8]=this.em_fecha_inicial
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.gb_2
end on

on w_bit_servicios_uia_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nombre)
destroy(this.dw_bitacora)
destroy(this.rb_todos_alumnos)
destroy(this.rb_solo_alumno)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.em_fecha_final)
destroy(this.em_fecha_inicial)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event close;if isvalid(iu_pipeline_control) then
	destroy iu_pipeline_control
end if

if isvalid(iu_pipeline_control02) then
	destroy iu_pipeline_control02
end if

if isvalid(itr_web) then
	if desconecta_bd(itr_web) <> 1 then
		return
	end if
end if

end event

event closequery;//
end event

event open;call super::open;date ldttm_fecha_servidor, ldttm_fecha_inicial

m_menu_general_2013.m_registro.m_cargaregistro.visible = true
m_menu_general_2013.m_registro.m_cargaregistro.enabled = true
m_menu_general_2013.m_registro.m_cargaregistro.toolbaritemvisible = true

iu_pipeline_control =  create u_pipeline_control
iu_pipeline_control.dataobject  = "dp_estado_alumno_tramite"

iu_pipeline_control02 =  create u_pipeline_control
iu_pipeline_control02.dataobject= "dp_solicitud_tramite"

//dw_resultado.SettransObject(gtr_sce)

ldttm_fecha_servidor = date(fecha_servidor(gtr_sce))
f_dia_inicio_semana(ldttm_fecha_servidor,ldttm_fecha_inicial)

em_fecha_inicial.text = string(ldttm_fecha_inicial,"dd/mm/yyyy")
em_fecha_final.text =  string(ldttm_fecha_servidor,"dd/mm/yyyy")


if conecta_bd(itr_web,gs_web_desb, gs_usuario,gs_password)<>1 then
//if conecta_bd(itr_web,gs_web_desb, "scedesbloqueo","pruebas1")<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	close(this)
else 
	dw_bitacora.SetTransObject(itr_web)
end if

IF IsValid(This) THEN 
	ib_usuario_especial = f_usuario_especial(gs_usuario) 
	
	IF ib_usuario_especial THEN 
		MessageBox("Bienvenido", "Su usuario es de acceso especial", Information!)
	END IF 	
END IF 	
end event

event doubleclicked;call super::doubleclicked;il_cuenta = uo_nombre.of_obten_cuenta()

if f_alumno_restringido (il_cuenta) then
	if ib_usuario_especial then
		MessageBox("Usuario  Autorizado", &
		"Alumno con acceso restringido",Information!)		
	else
		MessageBox("Usuario NO Autorizado", &
	           "Alumno con acceso restringido, por favor consulte a la ~n"+ &
				 +"Dirección de Servicios Escolares",StopSign!)
		uo_nombre.dw_nombre_alumno.Reset()	
		uo_nombre.dw_nombre_alumno.insertrow(0)
		uo_nombre.em_digito.text=" "
		uo_nombre.em_cuenta.text = " "
		uo_nombre.em_cuenta.setfocus()
		il_cuenta = 0
		return		
	end if
end if
end event

event ue_carga;call super::ue_carga;string ls_fecha_inicial, ls_fecha_final
date ldt_fecha_inicial, ldt_fecha_final
datetime ldttm_fecha_inicial, ldttm_fecha_final
integer li_num_registros 

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

Setpointer(Hourglass!)

li_num_registros = dw_bitacora.retrieve(il_cuenta, ldttm_fecha_inicial, ldttm_fecha_final)

Setpointer(Arrow!)

if li_num_registros = 0 then
	MessageBox ("Sin Registros", "No existe información bajo esos criterios",StopSign!)	
end if
end event

type st_sistema from w_master_main`st_sistema within w_bit_servicios_uia_2013
end type

type p_ibero from w_master_main`p_ibero within w_bit_servicios_uia_2013
end type

type uo_nombre from uo_nombre_alumno_2013 within w_bit_servicios_uia_2013
event destroy ( )
integer x = 87
integer y = 336
integer taborder = 30
boolean bringtotop = true
end type

on uo_nombre.destroy
call uo_nombre_alumno_2013::destroy
end on

event constructor;call super::constructor;m_menu_general_2013.objeto = this
end event

type dw_bitacora from datawindow within w_bit_servicios_uia_2013
integer x = 87
integer y = 1052
integer width = 3218
integer height = 1388
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_bit_acceso_uia_2013"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;datetime ldttm_fecha_servidor
string ls_fecha_servidor

if this.rowcount()>0 then
	ldttm_fecha_servidor = fecha_servidor(gtr_sce)
	ls_fecha_servidor = string(ldttm_fecha_servidor)
	this.object.t_fecha_servidor.text = ls_fecha_servidor
end if
end event

type rb_todos_alumnos from radiobutton within w_bit_servicios_uia_2013
integer x = 1211
integer y = 860
integer width = 608
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Todos los Alumnos"
end type

event clicked;//dw_bitacora.dataobject = "d_bit_acceso_uia"
//dw_bitacora.SetTransObject(itr_web)

il_cuenta = 9999999
end event

type rb_solo_alumno from radiobutton within w_bit_servicios_uia_2013
integer x = 1211
integer y = 760
integer width = 608
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Solo Alumno Actual"
boolean checked = true
end type

event clicked;il_cuenta = uo_nombre.of_obten_cuenta()

if f_alumno_restringido (il_cuenta) then
	if f_usuario_especial(gs_usuario) then
		MessageBox("Usuario  Autorizado", &
		"Alumno con acceso restringido",Information!)		
	else
		MessageBox("Usuario NO Autorizado", &
	           "Alumno con acceso restringido, por favor consulte a la ~n"+ &
				 +"Dirección de Servicios Escolares",StopSign!)
		uo_nombre.dw_nombre_alumno.Reset()	
		uo_nombre.dw_nombre_alumno.insertrow(0)
		uo_nombre.em_digito.text=" "
		uo_nombre.em_cuenta.text = " "
		uo_nombre.em_cuenta.setfocus()
		il_cuenta = 0
		return		
	end if
end if
end event

type st_1 from statictext within w_bit_servicios_uia_2013
integer x = 133
integer y = 872
integer width = 411
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Fecha Final:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_bit_servicios_uia_2013
integer x = 133
integer y = 776
integer width = 411
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Fecha Inicial:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fecha_final from u_em within w_bit_servicios_uia_2013
integer x = 581
integer y = 860
integer width = 352
integer height = 84
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Tahoma"
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy "
end type

type em_fecha_inicial from u_em within w_bit_servicios_uia_2013
integer x = 581
integer y = 760
integer width = 352
integer height = 84
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Tahoma"
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy "
end type

type gb_1 from groupbox within w_bit_servicios_uia_2013
integer x = 105
integer y = 696
integer width = 896
integer height = 288
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Periodo Consulta"
end type

type gb_2 from groupbox within w_bit_servicios_uia_2013
integer x = 1166
integer y = 696
integer width = 896
integer height = 288
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Tipo de Consulta"
end type

