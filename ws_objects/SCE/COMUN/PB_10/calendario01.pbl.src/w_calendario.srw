$PBExportHeader$w_calendario.srw
forward
global type w_calendario from w_ancestral
end type
type dw_calendario from uo_dw_captura within w_calendario
end type
type uo_1 from uo_per_ani within w_calendario
end type
end forward

global type w_calendario from w_ancestral
string MenuName="m_menu"
dw_calendario dw_calendario
uo_1 uo_1
end type
global w_calendario w_calendario

on w_calendario.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_calendario=create dw_calendario
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_calendario
this.Control[iCurrent+2]=this.uo_1
end on

on w_calendario.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_calendario)
destroy(this.uo_1)
end on

event open;call super::open;dw_calendario.event carga()
end event

type dw_calendario from uo_dw_captura within w_calendario
int X=435
int Y=717
int TabOrder=10
boolean BringToTop=true
string DataObject="d_calendario"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event constructor;call super::constructor;SetTransObject(gtr_sce)
tr_dw_propio = gtr_sce
end event

event carga;if event actualiza()=1 then
	event primero()
	return retrieve(gi_periodo,gi_anio)
end if
end event

type uo_1 from uo_per_ani within w_calendario
int X=1697
int Y=64
int TabOrder=10
boolean Enabled=true
boolean BringToTop=true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

