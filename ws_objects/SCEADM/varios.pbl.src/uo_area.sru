$PBExportHeader$uo_area.sru
$PBExportComments$Objeto para seleccionar un área
forward
global type uo_area from UserObject
end type
type dw_area from datawindow within uo_area
end type
type vsb_dw_area from vscrollbar within uo_area
end type
type r_3 from rectangle within uo_area
end type
type cbx_nuevo from checkbox within uo_area
end type
end forward

global type uo_area from UserObject
int Width=1047
int Height=157
boolean Enabled=false
long PictureMaskColor=553648127
long TabTextColor=33554432
long TabBackColor=79741120
dw_area dw_area
vsb_dw_area vsb_dw_area
r_3 r_3
cbx_nuevo cbx_nuevo
end type
global uo_area uo_area

type variables


end variables

on uo_area.create
this.dw_area=create dw_area
this.vsb_dw_area=create vsb_dw_area
this.r_3=create r_3
this.cbx_nuevo=create cbx_nuevo
this.Control[]={ this.dw_area,&
this.vsb_dw_area,&
this.r_3,&
this.cbx_nuevo}
end on

on uo_area.destroy
destroy(this.dw_area)
destroy(this.vsb_dw_area)
destroy(this.r_3)
destroy(this.cbx_nuevo)
end on

type dw_area from datawindow within uo_area
int X=14
int Y=21
int Width=883
int Height=105
int TabOrder=20
string DataObject="dw_areas"
BorderStyle BorderStyle=StyleLowered!
end type

event constructor;settransobject(gtr_sadm)
retrieve()


end event

event rowfocuschanged;/* En cuanto el usuario cambie "manualmente" el focus del DataWindow... */

if RowCount()<>0 then
	accepttext()

	/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
	vsb_dw_area.maxposition=RowCount()

	/* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
	vsb_dw_area.position=currentrow

end if
end event

type vsb_dw_area from vscrollbar within uo_area
int X=910
int Y=21
int Width=106
int Height=105
boolean Enabled=false
boolean BringToTop=true
boolean StdWidth=false
int MinPosition=1
int Position=1
end type

event linedown;/* En cuanto el usuario oprima la flecha-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_area.RowCount() then
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
maxposition=dw_area.RowCount()

/* Haz que el la ventana del DataWindow se mueva al cambiar la posición del ScrollBar */
dw_area.ScrollToRow(scrollpos)
end event

event pagedown;/* En cuanto el usuario oprima la página-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_area.RowCount() then
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

type r_3 from rectangle within uo_area
int X=2807
int Y=33
int Width=407
int Height=73
boolean Visible=false
boolean Enabled=false
int LineThickness=5
long FillColor=30588249
end type

type cbx_nuevo from checkbox within uo_area
int X=2812
int Y=37
int Width=394
int Height=65
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

