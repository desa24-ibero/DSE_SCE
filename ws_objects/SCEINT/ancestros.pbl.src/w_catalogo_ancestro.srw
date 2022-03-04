$PBExportHeader$w_catalogo_ancestro.srw
forward
global type w_catalogo_ancestro from w_ancestral_base
end type
type dw_catalogo from uo_dw_captura_base within w_catalogo_ancestro
end type
end forward

global type w_catalogo_ancestro from w_ancestral_base
boolean TitleBar=true
string Title="Catalogos"
string MenuName="m_ancestro_menu_catalogos"
event ue_imprime_reporte ( datawindow dw_reporte )
event ue_settrans ( transaction atr_transaction_local )
dw_catalogo dw_catalogo
end type
global w_catalogo_ancestro w_catalogo_ancestro

event ue_imprime_reporte;/*
DESCRIPCIÓN: Evento en el cual se envia  a impresión el reporte de un catalogo determinado.
PARÁMETROS: dw_reporte
REGRESA:Nada
AUTOR: Carlos Armando Melgoza Piña
FECHA: Enero 4, 1999
MODIFICACIÓN:

Desde el evento de las ventanas hijas se deberá utilizar la opción Override Ancestor Script
En el codigo de ese evento se deberá asignar a una variable tipo datawindow el datawindow que se quiere imprimir
se debe asignar el objeto de transacción y se efectua el retrieve, posteriormente
se llama al codigo de la  ventana con 
Super::EVENT ue_imprime_reporte(dw_reporte) de esta forma llamamos al codigo del ancestro
*/ 

if isvalid(dw_reporte) then
	dw_reporte.modify("Datawindow.print.preview = Yes")
	SetPointer(HourGlass!)
	openwithparm(conf_impr,dw_reporte)
end if

end event

event ue_settrans;dw_catalogo.settransobject(atr_transaction_local)
dw_catalogo.event ue_inicia_transaction_object(atr_transaction_local)

end event

on w_catalogo_ancestro.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_ancestro_menu_catalogos" then this.MenuID = create m_ancestro_menu_catalogos
this.dw_catalogo=create dw_catalogo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_catalogo
end on

on w_catalogo_ancestro.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_catalogo)
end on

event closequery;if f_revisa_dw(dw_catalogo) = 1 then
	return 1
end if


end event

event open;call super::open;event ue_settrans(gtr_sce)
dw_catalogo.retrieve()
end event

event ue_proceso_inicial;call super::ue_proceso_inicial;m_ancestro_menu im_menu
im_menu = menuid

int li_roothandle

end event

type dw_catalogo from uo_dw_captura_base within w_catalogo_ancestro
int X=133
int Y=188
int Width=3205
int Height=2140
int TabOrder=10
end type

