$PBExportHeader$w_bita_res.srw
$PBExportComments$Bitácora de cambios de resultados (bita_res)
forward
global type w_bita_res from Window
end type
type dw_1 from uo_dw_captura within w_bita_res
end type
type uo_1 from uo_ver_per_ani within w_bita_res
end type
end forward

global type w_bita_res from Window
int X=161
int Y=601
int Width=2830
int Height=1977
boolean TitleBar=true
string Title="Bitácora de Cambios de Status"
string MenuName="m_menu"
long BackColor=30976088
dw_1 dw_1
uo_1 uo_1
end type
global w_bita_res w_bita_res

type variables

end variables

on w_bita_res.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
this.uo_1=create uo_1
this.Control[]={ this.dw_1,&
this.uo_1}
end on

on w_bita_res.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.uo_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type dw_1 from uo_dw_captura within w_bita_res
int X=33
int Y=225
int Width=2721
int Height=1557
int TabOrder=0
string DataObject="dw_bita_res"
end type

event nuevo;int i=0
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;if event actualiza()=1 then
	event primero()
	return retrieve(gi_version,gi_periodo,gi_anio)
end if
end event

type uo_1 from uo_ver_per_ani within w_bita_res
int X=69
int Y=29
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

