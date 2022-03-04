$PBExportHeader$w_cat_departamentos.srw
forward
global type w_cat_departamentos from w_catalogo
end type
end forward

global type w_cat_departamentos from w_catalogo
int X=5
int Y=5
int Width=3699
int Height=2413
end type
global w_cat_departamentos w_cat_departamentos

on w_cat_departamentos.create
call w_catalogo::create
end on

on w_cat_departamentos.destroy
call w_catalogo::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;control_escolar.toolbarsheettitle="Departamentos"
end event

event open;call super::open;//g_nv_security.fnv_secure_window (this)
end event

event close;call super::close;//close(this)
end event

type dw_catalogo from w_catalogo`dw_catalogo within w_cat_departamentos
int X=106
int Width=3228
string DataObject="dw_departamento"
end type

