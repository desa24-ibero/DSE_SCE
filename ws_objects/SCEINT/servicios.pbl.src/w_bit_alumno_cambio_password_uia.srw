$PBExportHeader$w_bit_alumno_cambio_password_uia.srw
forward
global type w_bit_alumno_cambio_password_uia from w_bit_servicios_uia
end type
end forward

global type w_bit_alumno_cambio_password_uia from w_bit_servicios_uia
end type
global w_bit_alumno_cambio_password_uia w_bit_alumno_cambio_password_uia

on w_bit_alumno_cambio_password_uia.create
int iCurrent
call super::create
end on

on w_bit_alumno_cambio_password_uia.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type rb_todos_alumnos from w_bit_servicios_uia`rb_todos_alumnos within w_bit_alumno_cambio_password_uia
end type

type rb_solo_alumno from w_bit_servicios_uia`rb_solo_alumno within w_bit_alumno_cambio_password_uia
end type

type uo_nombre from w_bit_servicios_uia`uo_nombre within w_bit_alumno_cambio_password_uia
end type

type st_2 from w_bit_servicios_uia`st_2 within w_bit_alumno_cambio_password_uia
end type

type st_1 from w_bit_servicios_uia`st_1 within w_bit_alumno_cambio_password_uia
end type

type em_fecha_final from w_bit_servicios_uia`em_fecha_final within w_bit_alumno_cambio_password_uia
end type

type em_fecha_inicial from w_bit_servicios_uia`em_fecha_inicial within w_bit_alumno_cambio_password_uia
end type

type gb_1 from w_bit_servicios_uia`gb_1 within w_bit_alumno_cambio_password_uia
end type

type dw_bitacora from w_bit_servicios_uia`dw_bitacora within w_bit_alumno_cambio_password_uia
string dataobject = "d_bit_alumno_cambio_password_uia"
end type

event dw_bitacora::retrieverow;call super::retrieverow;string ls_null
integer li_null

if this.rowcount()>0 then
	if not (ib_usuario_especial) then
		setnull(ls_null)
		setnull(li_null)
		this.SetItem(row, 3, li_null)
		this.SetItem(row, 12, ls_null)
	end if
end if

end event

type gb_2 from w_bit_servicios_uia`gb_2 within w_bit_alumno_cambio_password_uia
end type

