$PBExportHeader$w_parametros_area_examen.srw
$PBExportComments$Ventana para cambiar fechas
forward
global type w_parametros_area_examen from w_main
end type
type dw_1 from u_dw_captura within w_parametros_area_examen
end type
end forward

global type w_parametros_area_examen from w_main
integer x = 832
integer y = 360
integer width = 3552
integer height = 2192
string title = "Parámetros por Area de Examen"
string menuname = "m_menu"
long backcolor = 67108864
dw_1 dw_1
end type
global w_parametros_area_examen w_parametros_area_examen

type variables
int ord
end variables

on w_parametros_area_examen.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_parametros_area_examen.destroy
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

type dw_1 from u_dw_captura within w_parametros_area_examen
integer x = 41
integer y = 32
integer width = 3410
integer height = 1920
integer taborder = 20
string dataobject = "d_parametros_area_examen"
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

