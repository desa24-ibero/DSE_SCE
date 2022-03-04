$PBExportHeader$w_definicion_lineas_corte.srw
$PBExportComments$Ventana que sirve para definir el número de aspirantes que serán aceptados
forward
global type w_definicion_lineas_corte from w_main
end type
type dw_1 from uo_dw_captura within w_definicion_lineas_corte
end type
end forward

global type w_definicion_lineas_corte from w_main
integer x = 160
integer y = 600
integer width = 2976
integer height = 2036
string title = "Definición de Líneas de Corte"
string menuname = "m_menu"
long backcolor = 67108864
dw_1 dw_1
end type
global w_definicion_lineas_corte w_definicion_lineas_corte

on w_definicion_lineas_corte.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_definicion_lineas_corte.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
end on

event open;/*Al abrir la ventana colócala en la esq. superior izquierda*/
x=1
y=1

dw_1.settransobject(gtr_sadm)
dw_1.retrieve()
end event

event close;/*Antes de cerrar la ventana verifica que no se pierdan cambios*/
dw_1.event actualiza()
end event

type dw_1 from uo_dw_captura within w_definicion_lineas_corte
integer x = 18
integer y = 48
integer width = 2843
integer height = 1700
integer taborder = 1
string dataobject = "dw_lineas_corte_definicion"
boolean resizable = true
borderstyle borderstyle = styleraised!
end type

event carga;int i=0
return 0
end event

event constructor;call super::constructor;//DataWindowChild carr
//getchild("clv_carr",carr)
//carr.settransobject(gtr_sce)
//carr.retrieve()
end event

event nuevo;setfocus()
scrolltorow(insertrow(0))
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

