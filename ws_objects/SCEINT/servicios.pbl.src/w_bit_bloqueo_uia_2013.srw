$PBExportHeader$w_bit_bloqueo_uia_2013.srw
forward
global type w_bit_bloqueo_uia_2013 from w_bit_servicios_uia_2013
end type
end forward

global type w_bit_bloqueo_uia_2013 from w_bit_servicios_uia_2013
string title = "Accesos a Servicios en Línea"
end type
global w_bit_bloqueo_uia_2013 w_bit_bloqueo_uia_2013

on w_bit_bloqueo_uia_2013.create
int iCurrent
call super::create
end on

on w_bit_bloqueo_uia_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_sistema from w_bit_servicios_uia_2013`st_sistema within w_bit_bloqueo_uia_2013
end type

type p_ibero from w_bit_servicios_uia_2013`p_ibero within w_bit_bloqueo_uia_2013
end type

type uo_nombre from w_bit_servicios_uia_2013`uo_nombre within w_bit_bloqueo_uia_2013
end type

type dw_bitacora from w_bit_servicios_uia_2013`dw_bitacora within w_bit_bloqueo_uia_2013
integer width = 3758
string dataobject = "d_bit_bloqueo_uia_2013"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

type rb_todos_alumnos from w_bit_servicios_uia_2013`rb_todos_alumnos within w_bit_bloqueo_uia_2013
end type

type rb_solo_alumno from w_bit_servicios_uia_2013`rb_solo_alumno within w_bit_bloqueo_uia_2013
end type

type st_1 from w_bit_servicios_uia_2013`st_1 within w_bit_bloqueo_uia_2013
end type

type st_2 from w_bit_servicios_uia_2013`st_2 within w_bit_bloqueo_uia_2013
end type

type em_fecha_final from w_bit_servicios_uia_2013`em_fecha_final within w_bit_bloqueo_uia_2013
end type

type em_fecha_inicial from w_bit_servicios_uia_2013`em_fecha_inicial within w_bit_bloqueo_uia_2013
end type

type gb_1 from w_bit_servicios_uia_2013`gb_1 within w_bit_bloqueo_uia_2013
end type

type gb_2 from w_bit_servicios_uia_2013`gb_2 within w_bit_bloqueo_uia_2013
end type

