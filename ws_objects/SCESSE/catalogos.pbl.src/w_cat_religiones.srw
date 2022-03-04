$PBExportHeader$w_cat_religiones.srw
forward
global type w_cat_religiones from w_catalogo
end type
end forward

global type w_cat_religiones from w_catalogo
boolean TitleBar=true
string Title="Catalogo de Religiones"
end type
global w_cat_religiones w_cat_religiones

on w_cat_religiones.create
call w_catalogo::create
end on

on w_cat_religiones.destroy
call w_catalogo::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;control_escolar.toolbarsheettitle="Religiones"
end event

event open;call super::open;//g_nv_security.fnv_secure_window (this)
end event

type dw_catalogo from w_catalogo`dw_catalogo within w_cat_religiones
int Width=1079
string DataObject="dw_religion"
end type

