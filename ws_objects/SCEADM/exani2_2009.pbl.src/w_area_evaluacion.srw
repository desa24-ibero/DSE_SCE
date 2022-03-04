$PBExportHeader$w_area_evaluacion.srw
$PBExportComments$Ventana para cambiar fechas
forward
global type w_area_evaluacion from w_main
end type
type dw_1 from u_dw_captura within w_area_evaluacion
end type
end forward

global type w_area_evaluacion from w_main
integer x = 832
integer y = 360
integer width = 3013
integer height = 2856
string title = "Catálogo de Areas de Evaluación"
string menuname = "m_menu"
long backcolor = 67108864
dw_1 dw_1
end type
global w_area_evaluacion w_area_evaluacion

type variables
int ord
long il_row
end variables

on w_area_evaluacion.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_area_evaluacion.destroy
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

m_menu.m_registro.m_borraregistro.enabled = false
 
dw_1.Retrieve()


end event

type dw_1 from u_dw_captura within w_area_evaluacion
integer x = 41
integer y = 32
integer width = 2880
integer height = 2596
integer taborder = 20
string dataobject = "d_area_evaluacion"
borderstyle borderstyle = styleraised!
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;if event actualiza()=1 then
	event primero()
	return retrieve()
end if
end event

event nuevo;call super::nuevo;long ll_id_area

IF il_row = 0 THEN il_row = dw_1.GetRow()

IF il_row <> dw_1.GetRow() THEN
	dw_1.deleterow(dw_1.GetRow())
	RETURN
END IF

SELECT ISNULL(MAX(id_area),0) + 1
INTO :ll_id_area
FROM area_evaluacion
USING gtr_sadm;

dw_1.setitem(il_row, "id_area", ll_id_area)


end event

event actualiza;call super::actualiza;dwItemStatus rowstatus

IF dw_1.GetRow() > 0 THEN
   rowstatus = dw_1.GetItemStatus(dw_1.GetRow(), 0, Primary! )
   IF rowstatus = NotModified! THEN
		il_row = 0
   END IF
END IF

RETURN 1
end event

