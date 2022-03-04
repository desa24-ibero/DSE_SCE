$PBExportHeader$w_bit_acceso_uia.srw
forward
global type w_bit_acceso_uia from w_bit_servicios_uia
end type
type cbx_agrupar_aplicacion from checkbox within w_bit_acceso_uia
end type
end forward

global type w_bit_acceso_uia from w_bit_servicios_uia
cbx_agrupar_aplicacion cbx_agrupar_aplicacion
end type
global w_bit_acceso_uia w_bit_acceso_uia

on w_bit_acceso_uia.create
int iCurrent
call super::create
this.cbx_agrupar_aplicacion=create cbx_agrupar_aplicacion
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_agrupar_aplicacion
end on

on w_bit_acceso_uia.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_agrupar_aplicacion)
end on

type rb_todos_alumnos from w_bit_servicios_uia`rb_todos_alumnos within w_bit_acceso_uia
end type

type rb_solo_alumno from w_bit_servicios_uia`rb_solo_alumno within w_bit_acceso_uia
end type

type uo_nombre from w_bit_servicios_uia`uo_nombre within w_bit_acceso_uia
end type

type st_2 from w_bit_servicios_uia`st_2 within w_bit_acceso_uia
end type

type st_1 from w_bit_servicios_uia`st_1 within w_bit_acceso_uia
end type

type em_fecha_final from w_bit_servicios_uia`em_fecha_final within w_bit_acceso_uia
end type

type em_fecha_inicial from w_bit_servicios_uia`em_fecha_inicial within w_bit_acceso_uia
end type

type gb_1 from w_bit_servicios_uia`gb_1 within w_bit_acceso_uia
end type

type dw_bitacora from w_bit_servicios_uia`dw_bitacora within w_bit_acceso_uia
end type

type gb_2 from w_bit_servicios_uia`gb_2 within w_bit_acceso_uia
end type

type cbx_agrupar_aplicacion from checkbox within w_bit_acceso_uia
integer x = 2144
integer y = 572
integer width = 608
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
string text = "Agrupar por Aplicación"
borderstyle borderstyle = stylelowered!
end type

event clicked;
IF THIS.CHECKED THEN
	dw_bitacora.dataobject = "d_bit_acceso_uia_aplicacion"
	dw_bitacora.SetTransObject(itr_web)
ELSE
	dw_bitacora.dataobject = "d_bit_acceso_uia"	
	dw_bitacora.SetTransObject(itr_web)
END IF


end event

