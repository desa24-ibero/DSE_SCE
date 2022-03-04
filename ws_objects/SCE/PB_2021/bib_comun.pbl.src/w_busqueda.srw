$PBExportHeader$w_busqueda.srw
forward
global type w_busqueda from Window
end type
type dw_desc from datawindow within w_busqueda
end type
type cbx_bus from checkbox within w_busqueda
end type
type st_1 from statictext within w_busqueda
end type
type dw_busqueda from datawindow within w_busqueda
end type
end forward

global type w_busqueda from Window
int X=517
int Y=601
int Width=2625
int Height=1205
boolean TitleBar=true
long BackColor=30976088
boolean ControlMenu=true
WindowType WindowType=response!
dw_desc dw_desc
cbx_bus cbx_bus
st_1 st_1
dw_busqueda dw_busqueda
end type
global w_busqueda w_busqueda

on w_busqueda.create
this.dw_desc=create dw_desc
this.cbx_bus=create cbx_bus
this.st_1=create st_1
this.dw_busqueda=create dw_busqueda
this.Control[]={ this.dw_desc,&
this.cbx_bus,&
this.st_1,&
this.dw_busqueda}
end on

on w_busqueda.destroy
destroy(this.dw_desc)
destroy(this.cbx_bus)
destroy(this.st_1)
destroy(this.dw_busqueda)
end on

event open;string objeto

objeto = message.stringparm

if objeto = "carrera" then
	w_busqueda.dw_busqueda.dataobject = "dw_carr_bus"
	ok=0
elseif objeto ="escuela" then
	w_busqueda.dw_busqueda.dataobject = "dw_esc_bus"
	ok=222
end if

dw_busqueda.settransobject(gtr_sce)
dw_desc.insertrow(0)
end event

type dw_desc from datawindow within w_busqueda
int X=467
int Y=105
int Width=1692
int Height=121
int TabOrder=10
string DataObject="dw_editor"
boolean Border=false
boolean LiveScroll=true
end type

event editchanged;string desc
accepttext()

if cbx_bus.checked = true then
	desc = "%"+getitemstring(getrow(),1)+"%"
	
else
	desc = getitemstring(getrow(),1)+"%"
	
end if

dw_busqueda.retrieve(desc)
end event

type cbx_bus from checkbox within w_busqueda
int X=1153
int Y=17
int Width=961
int Height=77
string Text="Busqueda de Palabra Intermedia "
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_busqueda
int X=165
int Y=109
int Width=293
int Height=93
boolean Enabled=false
boolean Border=true
string Text="Nombre:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=10789024
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_busqueda from datawindow within w_busqueda
int Y=241
int Width=2602
int Height=837
string DataObject="dw_esc_bus"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event doubleclicked;ok=object.clave[row]
close(w_busqueda)
end event

