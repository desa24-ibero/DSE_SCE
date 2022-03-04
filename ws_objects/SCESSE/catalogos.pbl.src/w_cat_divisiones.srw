$PBExportHeader$w_cat_divisiones.srw
forward
global type w_cat_divisiones from w_catalogo
end type
end forward

global type w_cat_divisiones from w_catalogo
integer x = 5
integer y = 4
integer width = 4242
integer height = 2412
long backcolor = 1073741824
end type
global w_cat_divisiones w_cat_divisiones

on w_cat_divisiones.create
call super::create
end on

on w_cat_divisiones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;control_escolar.toolbarsheettitle="Departamentos"
end event

event open;call super::open;//g_nv_security.fnv_secure_window (this)
end event

event close;call super::close;//close(this)
end event

type dw_catalogo from w_catalogo`dw_catalogo within w_cat_divisiones
integer x = 78
integer y = 148
integer width = 3771
integer height = 880
string dataobject = "dw_division_usuarios"
end type

