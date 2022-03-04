$PBExportHeader$uo_ver_per_ani.sru
$PBExportComments$Objeto con el que se puede seleccionar: Version, Periodo y Año en cuestión. Modifica variables globales.
forward
global type uo_ver_per_ani from userobject
end type
type dw_ver from datawindow within uo_ver_per_ani
end type
type vsb_dw_ver from vscrollbar within uo_ver_per_ani
end type
type vsb_dw_per from vscrollbar within uo_ver_per_ani
end type
type dw_per from datawindow within uo_ver_per_ani
end type
type em_ani from editmask within uo_ver_per_ani
end type
type r_3 from rectangle within uo_ver_per_ani
end type
type cbx_nuevo from checkbox within uo_ver_per_ani
end type
type rr_1 from roundrectangle within uo_ver_per_ani
end type
type rr_4 from roundrectangle within uo_ver_per_ani
end type
type rr_5 from roundrectangle within uo_ver_per_ani
end type
end forward

global type uo_ver_per_ani from userobject
integer width = 2286
integer height = 164
boolean enabled = false
long tabtextcolor = 41943040
long tabbackcolor = 80793808
long picturemaskcolor = 553648127
event cambia_seleccion ( )
dw_ver dw_ver
vsb_dw_ver vsb_dw_ver
vsb_dw_per vsb_dw_per
dw_per dw_per
em_ani em_ani
r_3 r_3
cbx_nuevo cbx_nuevo
rr_1 rr_1
rr_4 rr_4
rr_5 rr_5
end type
global uo_ver_per_ani uo_ver_per_ani

type variables


end variables

on uo_ver_per_ani.create
this.dw_ver=create dw_ver
this.vsb_dw_ver=create vsb_dw_ver
this.vsb_dw_per=create vsb_dw_per
this.dw_per=create dw_per
this.em_ani=create em_ani
this.r_3=create r_3
this.cbx_nuevo=create cbx_nuevo
this.rr_1=create rr_1
this.rr_4=create rr_4
this.rr_5=create rr_5
this.Control[]={this.dw_ver,&
this.vsb_dw_ver,&
this.vsb_dw_per,&
this.dw_per,&
this.em_ani,&
this.r_3,&
this.cbx_nuevo,&
this.rr_1,&
this.rr_4,&
this.rr_5}
end on

on uo_ver_per_ani.destroy
destroy(this.dw_ver)
destroy(this.vsb_dw_ver)
destroy(this.vsb_dw_per)
destroy(this.dw_per)
destroy(this.em_ani)
destroy(this.r_3)
destroy(this.cbx_nuevo)
destroy(this.rr_1)
destroy(this.rr_4)
destroy(this.rr_5)
end on

type dw_ver from datawindow within uo_ver_per_ani
integer x = 1262
integer y = 24
integer width = 859
integer height = 104
integer taborder = 40
string dataobject = "dw_version"
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(gtr_sadm)


end event

event rowfocuschanged;/* En cuanto el usuario cambie "manualmente" el focus del DataWindow... */

if RowCount()<>0 then
	accepttext()

	/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
	vsb_dw_ver.maxposition=RowCount()

	/* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
	vsb_dw_ver.position=currentrow

end if
end event

event retrieveend;long ll_renglon_ver ,ll_renglon_per, ll_ver_mas1
string ls_ver, ls_per
string ls_anio
long ll_nada

scrolltorow(gi_version+1)
em_ani.text=string(gi_anio)

ll_ver_mas1=gi_version+1
ll_renglon_ver = dw_ver.getrow()
ll_renglon_per = dw_per.getrow()
ls_anio = em_ani.text
ls_ver = dw_ver.object.version[dw_ver.getrow()]
ls_per = dw_per.object.periodo[dw_per.getrow()]

tit1=dw_ver.object.version[dw_ver.getrow()]+' '+&
	dw_per.object.periodo[dw_per.getrow()]+' '+em_ani.text
	
ll_nada = 0

end event

type vsb_dw_ver from vscrollbar within uo_ver_per_ani
integer x = 2139
integer y = 24
integer width = 105
integer height = 104
boolean bringtotop = true
boolean stdwidth = false
integer minposition = 1
integer position = 1
end type

event linedown;/* En cuanto el usuario oprima la flecha-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_ver.RowCount() then
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
maxposition=dw_ver.RowCount()

/* Haz que el la ventana del DataWindow se mueva al cambiar la posición del ScrollBar */
dw_ver.ScrollToRow(scrollpos)
gi_version=dw_ver.object.clv_ver[scrollpos]
tit1=dw_ver.object.version[dw_ver.getrow()]+' '+&
	dw_per.object.periodo[dw_per.getrow()]+' '+em_ani.text
	
PARENT.TRIGGEREVENT("cambia_seleccion")
end event

event pagedown;/* En cuanto el usuario oprima la página-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_ver.RowCount() then
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

type vsb_dw_per from vscrollbar within uo_ver_per_ani
integer x = 1093
integer y = 24
integer width = 105
integer height = 104
boolean bringtotop = true
boolean stdwidth = false
integer minposition = 1
integer position = 1
end type

event linedown;/* En cuanto el usuario oprima la flecha-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_per.RowCount() then
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
maxposition=dw_per.RowCount()

/* Haz que el la ventana del DataWindow se mueva al cambiar la posición del ScrollBar */
dw_per.ScrollToRow(scrollpos)
gi_periodo=dw_per.object.clv_per[scrollpos]
tit1=dw_ver.object.version[dw_ver.getrow()]+' '+&
	dw_per.object.periodo[dw_per.getrow()]+' '+em_ani.text

	
PARENT.TRIGGEREVENT("cambia_seleccion")
end event

event pagedown;/* En cuanto el usuario oprima la página-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_per.RowCount() then
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

type dw_per from datawindow within uo_ver_per_ani
integer x = 457
integer y = 24
integer width = 626
integer height = 104
integer taborder = 30
string dataobject = "dw_periodo"
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(gtr_sadm)
retrieve()
scrolltorow(gi_periodo+1)
end event

event rowfocuschanged;/* En cuanto el usuario cambie "manualmente" el focus del DataWindow... */

if RowCount()<>0 then
	accepttext()

	/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
	vsb_dw_per.maxposition=RowCount()

	/* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
	vsb_dw_per.position=currentrow

end if
end event

event retrieveend;dw_ver.retrieve()
end event

type em_ani from editmask within uo_ver_per_ani
integer x = 32
integer y = 28
integer width = 347
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####"
boolean autoskip = true
boolean spin = true
string displaydata = ""
double increment = 1
end type

event modified;if long(text) < 100 Then
	gi_anio = long(text) + 1900
	text = String(gi_anio)
	tit1=dw_ver.object.version[dw_ver.getrow()]+' '+&
		dw_per.object.periodo[dw_per.getrow()]+' '+text
else
	gi_anio = long(text)
	tit1=dw_ver.object.version[dw_ver.getrow()]+' '+&
		dw_per.object.periodo[dw_per.getrow()]+' '+text
End if

PARENT.TRIGGEREVENT("cambia_seleccion")
end event

type r_3 from rectangle within uo_ver_per_ani
boolean visible = false
integer linethickness = 5
long fillcolor = 30588249
integer x = 2807
integer y = 32
integer width = 407
integer height = 72
end type

type cbx_nuevo from checkbox within uo_ver_per_ani
boolean visible = false
integer x = 2811
integer y = 36
integer width = 393
integer height = 64
integer taborder = 20
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

type rr_1 from roundrectangle within uo_ver_per_ani
long linecolor = 33554432
integer linethickness = 5
long fillcolor = 79741120
integer x = 1243
integer y = 8
integer width = 1019
integer height = 144
integer cornerheight = 41
integer cornerwidth = 42
end type

type rr_4 from roundrectangle within uo_ver_per_ani
long linecolor = 33554432
integer linethickness = 5
long fillcolor = 79741120
integer x = 430
integer y = 8
integer width = 795
integer height = 144
integer cornerheight = 41
integer cornerwidth = 42
end type

type rr_5 from roundrectangle within uo_ver_per_ani
long linecolor = 33554432
integer linethickness = 5
long fillcolor = 79741120
integer x = 14
integer y = 8
integer width = 398
integer height = 144
integer cornerheight = 41
integer cornerwidth = 42
end type

