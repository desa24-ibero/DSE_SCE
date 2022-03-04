$PBExportHeader$w_paises.srw
forward
global type w_paises from w_catalogo
end type
end forward

global type w_paises from w_catalogo
boolean TitleBar=true
string Title="Catalogo de Paises"
end type
global w_paises w_paises

on w_paises.create
call w_catalogo::create
end on

on w_paises.destroy
call w_catalogo::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;control_escolar.toolbarsheettitle="Paises"
end event

event open;call super::open;//g_nv_security.fnv_secure_window (this)
end event

type dw_catalogo from w_catalogo`dw_catalogo within w_paises
int X=270
int Width=1409
string DataObject="dw_paises"
end type

