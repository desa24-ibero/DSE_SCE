$PBExportHeader$w_cat_forma_ingreso.srw
forward
global type w_cat_forma_ingreso from w_catalogo
end type
end forward

global type w_cat_forma_ingreso from w_catalogo
end type
global w_cat_forma_ingreso w_cat_forma_ingreso

on w_cat_forma_ingreso.create
call w_catalogo::create
end on

on w_cat_forma_ingreso.destroy
call w_catalogo::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;control_escolar.toolbarsheettitle="Forma de Ingreso"
end event

type dw_catalogo from w_catalogo`dw_catalogo within w_cat_forma_ingreso
int X=380
int Y=225
int Width=1377
string DataObject="dw_forma_ingreso"
end type

