$PBExportHeader$w_exam_fal.srw
$PBExportComments$Ventana que muestra los exámenes que faltan por cargar
forward
global type w_exam_fal from Window
end type
type uo_1 from uo_ver_per_ani within w_exam_fal
end type
type dw_1 from uo_dw_reporte within w_exam_fal
end type
end forward

global type w_exam_fal from Window
int X=833
int Y=361
int Width=3434
int Height=1953
boolean TitleBar=true
string Title="Exámenes Faltantes por cargar"
string MenuName="m_menu"
long BackColor=12632256
uo_1 uo_1
dw_1 dw_1
end type
global w_exam_fal w_exam_fal

on w_exam_fal.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={ this.uo_1,&
this.dw_1}
end on

on w_exam_fal.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type uo_1 from uo_ver_per_ani within w_exam_fal
int X=5
int Y=25
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_exam_fal
int X=14
int Y=201
int Height=1565
int TabOrder=0
string DataObject="dw_exam_fal"
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;event primero()
return retrieve(gi_version,gi_periodo,gi_anio)
end event

