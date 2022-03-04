$PBExportHeader$w_consulta_becas_fin_2013.srw
forward
global type w_consulta_becas_fin_2013 from w_master_main
end type
type st_porcentaje from statictext within w_consulta_becas_fin_2013
end type
type uo_1 from uo_per_ani within w_consulta_becas_fin_2013
end type
type rb_aspirante from radiobutton within w_consulta_becas_fin_2013
end type
type rb_alumno from radiobutton within w_consulta_becas_fin_2013
end type
type r_1 from rectangle within w_consulta_becas_fin_2013
end type
type gb_tipo from groupbox within w_consulta_becas_fin_2013
end type
type uo_nombre from uo_nombre_alumno_2013 within w_consulta_becas_fin_2013
end type
type uo_nombre_adm from uo_nombre_alumno_adm_2013 within w_consulta_becas_fin_2013
end type
end forward

global type w_consulta_becas_fin_2013 from w_master_main
integer width = 3365
integer height = 980
string title = "Consulta de apoyos de becas y financiamiento"
string menuname = "m_menu"
event inicia_proceso ( )
st_porcentaje st_porcentaje
uo_1 uo_1
rb_aspirante rb_aspirante
rb_alumno rb_alumno
r_1 r_1
gb_tipo gb_tipo
uo_nombre uo_nombre
uo_nombre_adm uo_nombre_adm
end type
global w_consulta_becas_fin_2013 w_consulta_becas_fin_2013

type variables
int ii_sw = 0
end variables

on w_consulta_becas_fin_2013.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.st_porcentaje=create st_porcentaje
this.uo_1=create uo_1
this.rb_aspirante=create rb_aspirante
this.rb_alumno=create rb_alumno
this.r_1=create r_1
this.gb_tipo=create gb_tipo
this.uo_nombre=create uo_nombre
this.uo_nombre_adm=create uo_nombre_adm
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_porcentaje
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.rb_aspirante
this.Control[iCurrent+4]=this.rb_alumno
this.Control[iCurrent+5]=this.r_1
this.Control[iCurrent+6]=this.gb_tipo
this.Control[iCurrent+7]=this.uo_nombre
this.Control[iCurrent+8]=this.uo_nombre_adm
end on

on w_consulta_becas_fin_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_porcentaje)
destroy(this.uo_1)
destroy(this.rb_aspirante)
destroy(this.rb_alumno)
destroy(this.r_1)
destroy(this.gb_tipo)
destroy(this.uo_nombre)
destroy(this.uo_nombre_adm)
end on

event close;if gi_numsadm = 1 then
	if desconecta_bd(gtr_sadm) <> 1 then
		return
	end if
end if
gi_numsadm --
end event

event closequery;//
end event

event open;call super::open;/**/gnv_app.inv_security.of_SetSecurity(this)

end event

event activate;call super::activate;control_escolar.toolbarsheettitle="Consulta de apoyos de becas y financiamiento"
end event

event ue_inicia_proceso;call super::ue_inicia_proceso;long ll_cuenta
int li_porc
if rb_alumno.checked = true then
	ll_cuenta = long(uo_nombre.of_obten_cuenta())
else
	ll_cuenta = long(uo_nombre.of_obten_cuenta())
end if
//MessageBox("",string(ll_cuenta)+"-"+obten_digito(ll_cuenta))


//DECLARE proc_porcentaje_apoyo procedure for SYBFINPRO.becas_fin_bd.dbo.sp_porcentaje_apoyo
DECLARE proc_porcentaje_apoyo procedure for SYBFINDES.becas_fin_bd.dbo.sp_porcentaje_apoyo
@cuenta = :ll_cuenta,
@anio = :gi_anio,
@periodo = :gi_periodo
USING gtr_sce;
fu_errorbd(gtr_sce, "DECLARE")

EXECUTE proc_porcentaje_apoyo;
fu_errorbd(gtr_sce, "EXECUTE")

FETCH  proc_porcentaje_apoyo INTO :li_porc;
//fu_errorbd(gtr_sce, "FETCH")

CLOSE proc_porcentaje_apoyo;
fu_errorbd(gtr_sce, "CLOSE")

st_porcentaje.text = "El porcentaje de apoyo para la cuenta "+&
			string(ll_cuenta)+"-"+obten_digito(ll_cuenta)+" es "+string(li_porc)

end event

type st_porcentaje from statictext within w_consulta_becas_fin_2013
boolean visible = false
integer x = 69
integer y = 548
integer width = 3177
integer height = 220
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Narrow"
string pointer = "HourGlass!"
long backcolor = 255
boolean enabled = false
string text = "El porcentaje de apoyo para la cuenta 0 es 0"
alignment alignment = center!
boolean border = true
long bordercolor = 32172778
boolean focusrectangle = false
end type

event getfocus;
setpointer(hourglass!)
SetPosition(ToTop!)
end event

type uo_1 from uo_per_ani within w_consulta_becas_fin_2013
event destroy ( )
integer x = 46
integer y = 356
integer width = 1253
integer height = 168
integer taborder = 40
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type rb_aspirante from radiobutton within w_consulta_becas_fin_2013
integer x = 2885
integer y = 412
integer width = 338
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Narrow"
long textcolor = 33554432
long backcolor = 15793151
string text = "Aspirante"
end type

event clicked;uo_nombre.enabled = false
uo_nombre.visible = false
uo_nombre_adm.enabled = true
uo_nombre_adm.visible = true
ii_sw = 1
end event

type rb_alumno from radiobutton within w_consulta_becas_fin_2013
integer x = 2478
integer y = 412
integer width = 283
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Narrow"
long textcolor = 33554432
long backcolor = 15793151
string text = "Alumno"
boolean checked = true
end type

event clicked;uo_nombre.enabled = true
uo_nombre.visible = true
uo_nombre_adm.enabled = false
uo_nombre_adm.visible = false
ii_sw = 0
end event

type r_1 from rectangle within w_consulta_becas_fin_2013
long linecolor = 32172778
integer linethickness = 3
long fillcolor = 15793151
integer x = 55
integer y = 532
integer width = 3209
integer height = 248
end type

type gb_tipo from groupbox within w_consulta_becas_fin_2013
integer x = 2039
integer y = 368
integer width = 1230
integer height = 144
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Narrow"
long textcolor = 33554432
long backcolor = 15793151
string text = "Tipo"
end type

type uo_nombre from uo_nombre_alumno_2013 within w_consulta_becas_fin_2013
integer x = 46
integer y = 28
integer taborder = 10
end type

on uo_nombre.destroy
call uo_nombre_alumno_2013::destroy
end on

type uo_nombre_adm from uo_nombre_alumno_adm_2013 within w_consulta_becas_fin_2013
boolean visible = false
integer x = 46
integer y = 28
integer taborder = 40
end type

on uo_nombre_adm.destroy
call uo_nombre_alumno_adm_2013::destroy
end on

