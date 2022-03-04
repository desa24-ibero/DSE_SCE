$PBExportHeader$w_cat_trabajos.srw
forward
global type w_cat_trabajos from w_catalogo
end type
end forward

global type w_cat_trabajos from w_catalogo
boolean TitleBar=true
string Title="Catalogo de Trabajos"
end type
global w_cat_trabajos w_cat_trabajos

on w_cat_trabajos.create
call w_catalogo::create
end on

on w_cat_trabajos.destroy
call w_catalogo::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;control_escolar.toolbarsheettitle="Trabajo"
end event

event open;call super::open;//g_nv_security.fnv_secure_window (this)
end event

type dw_catalogo from w_catalogo`dw_catalogo within w_cat_trabajos
int X=394
int Width=1230
string DataObject="dw_trabajo"
end type

