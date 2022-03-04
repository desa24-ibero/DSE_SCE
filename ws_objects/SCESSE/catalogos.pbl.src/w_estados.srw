$PBExportHeader$w_estados.srw
forward
global type w_estados from w_catalogo
end type
end forward

global type w_estados from w_catalogo
boolean TitleBar=true
string Title="Catalogo de Estados"
end type
global w_estados w_estados

on w_estados.create
call w_catalogo::create
end on

on w_estados.destroy
call w_catalogo::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;control_escolar.toolbarsheettitle="Estados"
end event

event open;call super::open;//g_nv_security.fnv_secure_window (this)
end event

type dw_catalogo from w_catalogo`dw_catalogo within w_estados
int X=426
int Width=1281
string DataObject="dw_estado"
end type

