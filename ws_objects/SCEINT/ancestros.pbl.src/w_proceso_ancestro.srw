$PBExportHeader$w_proceso_ancestro.srw
$PBExportComments$Ventana Base para los Procesos Especiales
forward
global type w_proceso_ancestro from w_ancestral
end type
end forward

global type w_proceso_ancestro from w_ancestral
int Width=2130
int Height=1348
end type
global w_proceso_ancestro w_proceso_ancestro

on w_proceso_ancestro.create
call super::create
end on

on w_proceso_ancestro.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

