$PBExportHeader$w_cat_edo_civil.srw
forward
global type w_cat_edo_civil from w_catalogo
end type
end forward

global type w_cat_edo_civil from w_catalogo
boolean TitleBar=true
string Title="Catalogo de Estado Civil"
end type
global w_cat_edo_civil w_cat_edo_civil

on w_cat_edo_civil.create
call w_catalogo::create
end on

on w_cat_edo_civil.destroy
call w_catalogo::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;control_escolar.toolbarsheettitle="Estado Civil"
end event

event open;call super::open;//g_nv_security.fnv_secure_window (this)
end event

