$PBExportHeader$w_bita_carr.srw
$PBExportComments$Bitácora de cambios de carrera (bita_carr)
forward
global type w_bita_carr from Window
end type
type dw_1 from uo_dw_captura within w_bita_carr
end type
type uo_1 from uo_ver_per_ani within w_bita_carr
end type
end forward

global type w_bita_carr from Window
int X=161
int Y=601
int Width=3754
int Height=1977
boolean TitleBar=true
string Title="Bitácora de Cambios de Carrera"
string MenuName="m_menu"
long BackColor=30976088
dw_1 dw_1
uo_1 uo_1
end type
global w_bita_carr w_bita_carr

type variables

end variables

on w_bita_carr.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
this.uo_1=create uo_1
this.Control[]={ this.dw_1,&
this.uo_1}
end on

on w_bita_carr.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.uo_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type dw_1 from uo_dw_captura within w_bita_carr
int X=19
int Y=197
int Width=3612
int Height=1581
int TabOrder=0
string DataObject="dw_bita_carr"
end type

event carga;event actualiza()
event primero()
object.st_1.text=tit1
return retrieve(1,gi_version,gi_periodo,gi_anio)
end event

event constructor;call super::constructor;DataWindowChild carr1
getchild("carr_ant",carr1)
carr1.settransobject(gtr_sce)
carr1.retrieve()

DataWindowChild carr2
getchild("carr_act",carr2)
carr2.settransobject(gtr_sce)
carr2.retrieve()

end event

event nuevo;int i=0
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

type uo_1 from uo_ver_per_ani within w_bita_carr
int X=69
int Y=25
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

