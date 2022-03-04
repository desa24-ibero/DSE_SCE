$PBExportHeader$w_ancestro_child.srw
$PBExportComments$Objeto ancestral carente de codigo para ventanas CHILD
forward
global type w_ancestro_child from Window
end type
end forward

global type w_ancestro_child from Window
int X=5
int Y=4
int Width=3730
int Height=2460
boolean TitleBar=true
string Title="Titulo"
long BackColor=29534863
WindowType WindowType=child!
event ue_inicia_seguridad ( )
event ue_destruye_seguridad ( )
event ue_proceso_inicial ( )
event ue_proceso_final ( )
event ue_ajuste_workspace ( integer ai_width,  integer ai_height )
end type
global w_ancestro_child w_ancestro_child

type variables
treeviewitem tvi_padre
uo_tv_menu itv_menu
end variables

on w_ancestro_child.create
end on

on w_ancestro_child.destroy
end on

