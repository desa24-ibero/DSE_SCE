﻿$PBExportHeader$uo_materia_sce.sru
forward
global type uo_materia_sce from UserObject
end type
type dw_carrera from datawindow within uo_materia_sce
end type
type vsb_dw_carrera from vscrollbar within uo_materia_sce
end type
type r_3 from rectangle within uo_materia_sce
end type
type cbx_nuevo from checkbox within uo_materia_sce
end type
end forward

global type uo_materia_sce from UserObject
int Width=1430
int Height=205
boolean Enabled=false
long PictureMaskColor=553648127
long TabTextColor=41943040
long TabBackColor=80793808
dw_carrera dw_carrera
vsb_dw_carrera vsb_dw_carrera
r_3 r_3
cbx_nuevo cbx_nuevo
end type
global uo_materia_sce uo_materia_sce

type variables


end variables

on uo_materia_sce.create
this.dw_carrera=create dw_carrera
this.vsb_dw_carrera=create vsb_dw_carrera
this.r_3=create r_3
this.cbx_nuevo=create cbx_nuevo
this.Control[]={this.dw_carrera,&
this.vsb_dw_carrera,&
this.r_3,&
this.cbx_nuevo}
end on

on uo_materia_sce.destroy
destroy(this.dw_carrera)
destroy(this.vsb_dw_carrera)
destroy(this.r_3)
destroy(this.cbx_nuevo)
end on

type dw_carrera from datawindow within uo_materia_sce
event muevete ( )
int Width=1331
int Height=205
string DataObject="dw_materia_sce"
BorderStyle BorderStyle=StyleLowered!
end type

event muevete;long numarg

numarg = Message.WordParm
SetPointer(HourGlass!)
scrolltorow(numarg)
end event

event constructor;settransobject(gtr_sce)
retrieve()
Object.DataWindow.Zoom = 70
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

event itemchanged;long ll_cont
if GetColumn( )=1 then
	FOR ll_cont=1 TO rowcount()
		if object.cve_mat[ll_cont]=long(data) then
			PostEvent ("muevete",ll_cont,0)
			return 2
		end if
	NEXT
	return 2
end if
end event

type vsb_dw_carrera from vscrollbar within uo_materia_sce
int X=1331
int Width=106
int Height=205
boolean Enabled=false
boolean BringToTop=true
boolean StdWidth=false
int MinPosition=1
int Position=1
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

type r_3 from rectangle within uo_materia_sce
int X=2809
int Y=32
int Width=406
int Height=77
boolean Visible=false
boolean Enabled=false
int LineThickness=13
long FillColor=30588249
end type

type cbx_nuevo from checkbox within uo_materia_sce
int X=2812
int Y=45
int Width=391
int Height=64
int TabOrder=10
boolean Visible=false
boolean Enabled=false
string Text="Modificar"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
