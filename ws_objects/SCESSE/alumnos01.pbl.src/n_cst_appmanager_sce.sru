$PBExportHeader$n_cst_appmanager_sce.sru
forward
global type n_cst_appmanager_sce from n_cst_appmanager
end type
end forward

global type n_cst_appmanager_sce from n_cst_appmanager
end type
global n_cst_appmanager_sce n_cst_appmanager_sce

type variables
n_tr itr_security
end variables

on n_cst_appmanager_sce.create
TriggerEvent( this, "constructor" )
end on

on n_cst_appmanager_sce.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;if not isnull(gs_startupfile) and len(gs_startupfile)>1 then
	is_appinifile = gs_startupfile
else
	is_appinifile = "controle.ini"
end if



end event

