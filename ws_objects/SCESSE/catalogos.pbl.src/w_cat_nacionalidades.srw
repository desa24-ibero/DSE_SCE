$PBExportHeader$w_cat_nacionalidades.srw
forward
global type w_cat_nacionalidades from w_catalogo
end type
end forward

global type w_cat_nacionalidades from w_catalogo
boolean TitleBar=true
string Title="Catalogo de Nacionalidades"
end type
global w_cat_nacionalidades w_cat_nacionalidades

on w_cat_nacionalidades.create
call w_catalogo::create
end on

on w_cat_nacionalidades.destroy
call w_catalogo::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;control_escolar.toolbarsheettitle="Nacionalidades"
end event

event open;call super::open;//g_nv_security.fnv_secure_window (this)
end event

type dw_catalogo from w_catalogo`dw_catalogo within w_cat_nacionalidades
int X=261
int Width=1623
string DataObject="dw_nacionalidad"
end type

