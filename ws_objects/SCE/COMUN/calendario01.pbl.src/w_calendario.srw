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
string menuname = "m_menu"
dw_calendario dw_calendario
uo_1 uo_1
end type
global w_calendario w_calendario

type variables

uo_periodo_servicios iuo_periodo_servicios 


end variables

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

iuo_periodo_servicios = CREATE uo_periodo_servicios
iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, 'L', gtr_sce)
iuo_periodo_servicios.f_carga_periodos_tipo(gtr_sce)

iuo_periodo_servicios.f_modifica_lista_columna( dw_calendario, 'periodo', 'L')





end event

type p_uia from w_ancestral`p_uia within w_calendario
end type

type dw_calendario from uo_dw_captura within w_calendario
integer x = 384
integer y = 716
integer width = 2633
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_calendario"
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
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
integer x = 1696
integer y = 64
integer taborder = 10
boolean bringtotop = true
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

