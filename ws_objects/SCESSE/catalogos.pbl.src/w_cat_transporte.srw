$PBExportHeader$w_cat_transporte.srw
forward
global type w_cat_transporte from w_catalogo
end type
end forward

global type w_cat_transporte from w_catalogo
boolean TitleBar=true
string Title="Catalogo de Transportes"
end type
global w_cat_transporte w_cat_transporte

on w_cat_transporte.create
call w_catalogo::create
end on

on w_cat_transporte.destroy
call w_catalogo::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;control_escolar.toolbarsheettitle="Transporte"
end event

event open;call super::open;//g_nv_security.fnv_secure_window (this)
end event

type dw_catalogo from w_catalogo`dw_catalogo within w_cat_transporte
string DataObject="dw_transporte"
end type

