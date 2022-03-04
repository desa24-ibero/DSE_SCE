$PBExportHeader$w_modulo_examen.srw
$PBExportComments$Ventana para cambiar fechas
forward
global type w_modulo_examen from w_main
end type
type dw_1 from u_dw_captura within w_modulo_examen
end type
end forward

global type w_modulo_examen from w_main
integer x = 832
integer y = 360
integer width = 3013
integer height = 1956
string title = "Catálogo de Módulos de Examen"
string menuname = "m_menu"
long backcolor = 67108864
dw_1 dw_1
end type
global w_modulo_examen w_modulo_examen

type variables
int ord
end variables

on w_modulo_examen.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_modulo_examen.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)

this.of_SetResize(TRUE)

this.inv_resize.of_Register &
 (dw_1, this.inv_resize.SCALERIGHTBOTTOM)
 
 dw_1.Retrieve()

end event

type dw_1 from u_dw_captura within w_modulo_examen
integer x = 41
integer y = 32
integer width = 2880
integer height = 1664
integer taborder = 20
string dataobject = "d_modulo_examen"
boolean hscrollbar = true
borderstyle borderstyle = styleraised!
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;if event actualiza()=1 then
	event primero()
	return retrieve()
end if
end event

event nuevo;call super::nuevo;long ll_renglon

ll_renglon=rowcount()

end event

