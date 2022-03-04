$PBExportHeader$uo_division.sru
$PBExportComments$Objeto para seleccionar una división
forward
global type uo_division from UserObject
end type
type dw_division from datawindow within uo_division
end type
type vsb_dw_division from vscrollbar within uo_division
end type
type r_3 from rectangle within uo_division
end type
type cbx_nuevo from checkbox within uo_division
end type
end forward

global type uo_division from UserObject
int Width=1377
int Height=157
boolean Enabled=false
long PictureMaskColor=553648127
long TabTextColor=41943040
long TabBackColor=80793808
dw_division dw_division
vsb_dw_division vsb_dw_division
r_3 r_3
cbx_nuevo cbx_nuevo
end type
global uo_division uo_division

type variables


end variables

on uo_division.create
this.dw_division=create dw_division
this.vsb_dw_division=create vsb_dw_division
this.r_3=create r_3
this.cbx_nuevo=create cbx_nuevo
this.Control[]={ this.dw_division,&
this.vsb_dw_division,&
this.r_3,&
this.cbx_nuevo}
end on

on uo_division.destroy
destroy(this.dw_division)
destroy(this.vsb_dw_division)
destroy(this.r_3)
destroy(this.cbx_nuevo)
end on

type dw_division from datawindow within uo_division
int X=14
int Y=21
int Width=1217
int Height=105
int TabOrder=20
string DataObject="dw_division"
BorderStyle BorderStyle=StyleLowered!
end type

event constructor;settransobject(gtr_sce)
retrieve()
end event

event rowfocuschanged;/* En cuanto el usuario cambie "manualmente" el focus del DataWindow... */

if RowCount()<>0 then
	accepttext()

	/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
	vsb_dw_division.maxposition=RowCount()

	/* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
	vsb_dw_division.position=currentrow

end if
end event

type vsb_dw_division from vscrollbar within uo_division
int X=1244
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
if position<dw_division.RowCount() then
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
maxposition=dw_division.RowCount()

/* Haz que el la ventana del DataWindow se mueva al cambiar la posición del ScrollBar */
dw_division.ScrollToRow(scrollpos)
end event

event pagedown;/* En cuanto el usuario oprima la página-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_division.RowCount() then
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

type r_3 from rectangle within uo_division
int X=2807
int Y=33
int Width=407
int Height=73
boolean Visible=false
boolean Enabled=false
int LineThickness=5
long FillColor=30588249
end type

type cbx_nuevo from checkbox within uo_division
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

