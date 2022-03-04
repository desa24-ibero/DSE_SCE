$PBExportHeader$uo_carrera_admision.sru
$PBExportComments$Objeto para seleccionar una carrera
forward
global type uo_carrera_admision from userobject
end type
type dw_carrera from datawindow within uo_carrera_admision
end type
type vsb_dw_carrera from vscrollbar within uo_carrera_admision
end type
type r_3 from rectangle within uo_carrera_admision
end type
type cbx_nuevo from checkbox within uo_carrera_admision
end type
end forward

global type uo_carrera_admision from userobject
integer width = 1810
integer height = 204
boolean enabled = false
long tabtextcolor = 41943040
long tabbackcolor = 80793808
long picturemaskcolor = 553648127
dw_carrera dw_carrera
vsb_dw_carrera vsb_dw_carrera
r_3 r_3
cbx_nuevo cbx_nuevo
end type
global uo_carrera_admision uo_carrera_admision

type variables


end variables

on uo_carrera_admision.create
this.dw_carrera=create dw_carrera
this.vsb_dw_carrera=create vsb_dw_carrera
this.r_3=create r_3
this.cbx_nuevo=create cbx_nuevo
this.Control[]={this.dw_carrera,&
this.vsb_dw_carrera,&
this.r_3,&
this.cbx_nuevo}
end on

on uo_carrera_admision.destroy
destroy(this.dw_carrera)
destroy(this.vsb_dw_carrera)
destroy(this.r_3)
destroy(this.cbx_nuevo)
end on

type dw_carrera from datawindow within uo_carrera_admision
event muevete ( )
integer y = 8
integer width = 1701
integer height = 192
string dataobject = "d_carrera_admision"
borderstyle borderstyle = stylelowered!
end type

event muevete;integer numarg

numarg = Message.WordParm

scrolltorow(numarg)
end event

event constructor;settransobject(gtr_sce)
retrieve()
Object.DataWindow.Zoom = 79
scrolltorow(rowcount())
end event

event rowfocuschanged;/* En cuanto el usuario cambie "manualmente" el focus del DataWindow... */

if RowCount()<>0 then
	accepttext()

	/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
	vsb_dw_carrera.maxposition=RowCount()

	/* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
	vsb_dw_carrera.position=currentrow

end if
end event

event itemchanged;int li_cont
if GetColumn( )=1 then
	FOR li_cont=1 TO rowcount()
		if object.cve_carrera[li_cont]=integer(data) then
			PostEvent ("muevete",li_cont,0)
			return 2
		end if
	NEXT
	return 2
end if
end event

type vsb_dw_carrera from vscrollbar within uo_carrera_admision
integer x = 1701
integer width = 105
integer height = 196
boolean bringtotop = true
boolean stdwidth = false
integer minposition = 1
integer position = 1
end type

event linedown;/* En cuanto el usuario oprima la flecha-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_carrera.RowCount() then
	/* Si no lo estoy mueve el scroll bar una posición más */
	position=position+1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if

end event

event lineup;/* En cuanto el usuario oprima la flecha-arriba del ScrollBar... */

/* Verifica que no esté al inicio de los renglones del DataWindow */
if position>1 then
	/* Si no lo estoy mueve el scroll bar una posición menos */
	position=position -1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if
end event

event moved;/* En cuanto se de el evento Moved (usuario moviendo la barra o llamado desde aca adentro)... */

/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
maxposition=dw_carrera.RowCount()

/* Haz que el la ventana del DataWindow se mueva al cambiar la posición del ScrollBar */
dw_carrera.ScrollToRow(scrollpos)
end event

event pagedown;/* En cuanto el usuario oprima la página-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_carrera.RowCount() then
	/* Si no lo estoy mueve el scroll bar una posición más */
	position=position+1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if
end event

event pageup;/* En cuanto el usuario oprima la página-arriba del ScrollBar... */

/* Verifica que no esté al inicio de los renglones del DataWindow */
if position>1 then
	/* Si no lo estoy mueve el scroll bar una posición menos */
	position=position -1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if
end event

type r_3 from rectangle within uo_carrera_admision
boolean visible = false
integer linethickness = 5
long fillcolor = 30588249
integer x = 2807
integer y = 32
integer width = 407
integer height = 72
end type

type cbx_nuevo from checkbox within uo_carrera_admision
boolean visible = false
integer x = 2811
integer y = 36
integer width = 393
integer height = 64
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Modificar"
end type

