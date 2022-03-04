$PBExportHeader$w_bit_password_uia.srw
forward
global type w_bit_password_uia from w_bit_servicios_uia
end type
type rb_rep_inscritos from radiobutton within w_bit_password_uia
end type
type rb_rep_todos from radiobutton within w_bit_password_uia
end type
type rb_rep_cuentas_inscritos from radiobutton within w_bit_password_uia
end type
type gb_3 from groupbox within w_bit_password_uia
end type
end forward

global type w_bit_password_uia from w_bit_servicios_uia
rb_rep_inscritos rb_rep_inscritos
rb_rep_todos rb_rep_todos
rb_rep_cuentas_inscritos rb_rep_cuentas_inscritos
gb_3 gb_3
end type
global w_bit_password_uia w_bit_password_uia

on w_bit_password_uia.create
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

on w_bit_password_uia.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_rep_inscritos)
destroy(this.rb_rep_todos)
destroy(this.rb_rep_cuentas_inscritos)
destroy(this.gb_3)
end on

type rb_todos_alumnos from w_bit_servicios_uia`rb_todos_alumnos within w_bit_password_uia
integer x = 1019
end type

type rb_solo_alumno from w_bit_servicios_uia`rb_solo_alumno within w_bit_password_uia
integer x = 1019
end type

type uo_nombre from w_bit_servicios_uia`uo_nombre within w_bit_password_uia
end type

type st_2 from w_bit_servicios_uia`st_2 within w_bit_password_uia
end type

type st_1 from w_bit_servicios_uia`st_1 within w_bit_password_uia
end type

type em_fecha_final from w_bit_servicios_uia`em_fecha_final within w_bit_password_uia
end type

type em_fecha_inicial from w_bit_servicios_uia`em_fecha_inicial within w_bit_password_uia
end type

type gb_1 from w_bit_servicios_uia`gb_1 within w_bit_password_uia
end type

type dw_bitacora from w_bit_servicios_uia`dw_bitacora within w_bit_password_uia
string dataobject = "d_bit_password_uia"
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

type gb_2 from w_bit_servicios_uia`gb_2 within w_bit_password_uia
integer x = 974
end type

type rb_rep_inscritos from radiobutton within w_bit_password_uia
integer x = 1952
integer y = 584
integer width = 398
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
string text = "Solo Inscritos"
borderstyle borderstyle = stylelowered!
end type

event clicked;IF THIS.CHECKED THEN
	dw_bitacora.dataobject = "d_bit_password_uia_inscritos"
	dw_bitacora.SetTransObject(itr_web)
END IF	
end event

type rb_rep_todos from radiobutton within w_bit_password_uia
integer x = 1952
integer y = 516
integer width = 512
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
string text = "Todos los alumnos"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

event clicked;IF THIS.CHECKED THEN
	dw_bitacora.dataobject = "d_bit_password_uia"
	dw_bitacora.SetTransObject(itr_web)
END IF
end event

type rb_rep_cuentas_inscritos from radiobutton within w_bit_password_uia
integer x = 1952
integer y = 652
integer width = 695
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
string text = "Solo Cuenta de Inscritos"
borderstyle borderstyle = stylelowered!
end type

event clicked;IF THIS.CHECKED THEN
	dw_bitacora.dataobject = "d_bit_password_uia_inscritos_cuentas"
	dw_bitacora.SetTransObject(itr_web)
END IF	
end event

type gb_3 from groupbox within w_bit_password_uia
integer x = 1925
integer y = 460
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
string text = "Reporte"
borderstyle borderstyle = stylelowered!
end type

