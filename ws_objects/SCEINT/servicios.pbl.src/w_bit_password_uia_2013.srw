$PBExportHeader$w_bit_password_uia_2013.srw
forward
global type w_bit_password_uia_2013 from w_bit_servicios_uia_2013
end type
type rb_rep_inscritos from radiobutton within w_bit_password_uia_2013
end type
type rb_rep_todos from radiobutton within w_bit_password_uia_2013
end type
type rb_rep_cuentas_inscritos from radiobutton within w_bit_password_uia_2013
end type
type gb_3 from groupbox within w_bit_password_uia_2013
end type
end forward

global type w_bit_password_uia_2013 from w_bit_servicios_uia_2013
string title = "Accesos a Servicios en Línea"
rb_rep_inscritos rb_rep_inscritos
rb_rep_todos rb_rep_todos
rb_rep_cuentas_inscritos rb_rep_cuentas_inscritos
gb_3 gb_3
end type
global w_bit_password_uia_2013 w_bit_password_uia_2013

on w_bit_password_uia_2013.create
int iCurrent
call super::create
this.rb_rep_inscritos=create rb_rep_inscritos
this.rb_rep_todos=create rb_rep_todos
this.rb_rep_cuentas_inscritos=create rb_rep_cuentas_inscritos
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_rep_inscritos
this.Control[iCurrent+2]=this.rb_rep_todos
this.Control[iCurrent+3]=this.rb_rep_cuentas_inscritos
this.Control[iCurrent+4]=this.gb_3
end on

on w_bit_password_uia_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_rep_inscritos)
destroy(this.rb_rep_todos)
destroy(this.rb_rep_cuentas_inscritos)
destroy(this.gb_3)
end on

type st_sistema from w_bit_servicios_uia_2013`st_sistema within w_bit_password_uia_2013
end type

type p_ibero from w_bit_servicios_uia_2013`p_ibero within w_bit_password_uia_2013
end type

type uo_nombre from w_bit_servicios_uia_2013`uo_nombre within w_bit_password_uia_2013
end type

type dw_bitacora from w_bit_servicios_uia_2013`dw_bitacora within w_bit_password_uia_2013
integer width = 3680
string dataobject = "d_bit_password_uia_2013"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

event dw_bitacora::retrieverow;call super::retrieverow;string ls_null

if this.rowcount()>0 then
	if not (ib_usuario_especial) then
		setnull(ls_null)
		this.SetItem(row,"nip2",ls_null)
		this.SetItem(row,"v_www_bit_nips_password",ls_null)
	end if
end if
end event

type rb_todos_alumnos from w_bit_servicios_uia_2013`rb_todos_alumnos within w_bit_password_uia_2013
end type

type rb_solo_alumno from w_bit_servicios_uia_2013`rb_solo_alumno within w_bit_password_uia_2013
end type

type st_1 from w_bit_servicios_uia_2013`st_1 within w_bit_password_uia_2013
end type

type st_2 from w_bit_servicios_uia_2013`st_2 within w_bit_password_uia_2013
end type

type em_fecha_final from w_bit_servicios_uia_2013`em_fecha_final within w_bit_password_uia_2013
end type

type em_fecha_inicial from w_bit_servicios_uia_2013`em_fecha_inicial within w_bit_password_uia_2013
end type

type gb_1 from w_bit_servicios_uia_2013`gb_1 within w_bit_password_uia_2013
end type

type gb_2 from w_bit_servicios_uia_2013`gb_2 within w_bit_password_uia_2013
integer width = 741
end type

type rb_rep_inscritos from radiobutton within w_bit_password_uia_2013
integer x = 2181
integer y = 820
integer width = 695
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Solo Inscritos"
end type

event clicked;IF THIS.CHECKED THEN
	dw_bitacora.dataobject = "d_bit_password_uia_inscritos_2013"
	dw_bitacora.SetTransObject(itr_web)
END IF	
end event

type rb_rep_todos from radiobutton within w_bit_password_uia_2013
integer x = 2181
integer y = 752
integer width = 695
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Todos los alumnos"
boolean checked = true
end type

event clicked;IF THIS.CHECKED THEN
	dw_bitacora.dataobject = "d_bit_password_uia_2013"
	dw_bitacora.SetTransObject(itr_web)
END IF
end event

type rb_rep_cuentas_inscritos from radiobutton within w_bit_password_uia_2013
integer x = 2181
integer y = 888
integer width = 695
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Solo Cuenta de Inscritos"
end type

event clicked;IF THIS.CHECKED THEN
	dw_bitacora.dataobject = "d_bit_password_uia_inscritos_cuentas_2013"
	dw_bitacora.SetTransObject(itr_web)
END IF	
end event

type gb_3 from groupbox within w_bit_password_uia_2013
integer x = 2153
integer y = 696
integer width = 809
integer height = 288
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Reporte"
end type

