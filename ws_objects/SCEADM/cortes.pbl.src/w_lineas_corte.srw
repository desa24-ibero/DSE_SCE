$PBExportHeader$w_lineas_corte.srw
$PBExportComments$Ventana que sirve para definir el número de aspirantes que serán aceptados
forward
global type w_lineas_corte from Window
end type
type dw_1 from uo_dw_captura within w_lineas_corte
end type
end forward

global type w_lineas_corte from Window
int X=161
int Y=601
int Width=2684
int Height=1941
boolean TitleBar=true
string Title="Definición de Líneas de Corte"
string MenuName="m_menu"
long BackColor=30976088
dw_1 dw_1
end type
global w_lineas_corte w_lineas_corte

on w_lineas_corte.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
this.Control[]={ this.dw_1}
end on

on w_lineas_corte.destroy
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

type dw_1 from uo_dw_captura within w_lineas_corte
int X=19
int Y=49
int Width=2606
int Height=1701
int TabOrder=1
string DataObject="dw_lineas_corte"
end type

event carga;int i=0
return 0
end event

event constructor;call super::constructor;DataWindowChild carr
getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()
end event

event nuevo;setfocus()
scrolltorow(insertrow(0))
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

