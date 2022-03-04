$PBExportHeader$w_bitacora_constancias.srw
forward
global type w_bitacora_constancias from Window
end type
type st_3 from statictext within w_bitacora_constancias
end type
type uo_constancia from uo_constancias within w_bitacora_constancias
end type
type cb_1 from commandbutton within w_bitacora_constancias
end type
type st_2 from statictext within w_bitacora_constancias
end type
type st_fecha_final from statictext within w_bitacora_constancias
end type
type st_1 from statictext within w_bitacora_constancias
end type
type em_fecha_final from editmask within w_bitacora_constancias
end type
type em_fecha_inicial from editmask within w_bitacora_constancias
end type
type dw_1 from datawindow within w_bitacora_constancias
end type
end forward

global type w_bitacora_constancias from Window
int X=37
int Y=212
int Width=3648
int Height=1668
boolean TitleBar=true
string Title="Consulta Bitácora de Constancias"
string MenuName="m_menu_reporte"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_3 st_3
uo_constancia uo_constancia
cb_1 cb_1
st_2 st_2
st_fecha_final st_fecha_final
st_1 st_1
em_fecha_final em_fecha_final
em_fecha_inicial em_fecha_inicial
dw_1 dw_1
end type
global w_bitacora_constancias w_bitacora_constancias

forward prototypes
public function integer wf_cambia_dw (string as_nom_datawindow, integer ai_zoom, integer ai_orientation)
end prototypes

public function integer wf_cambia_dw (string as_nom_datawindow, integer ai_zoom, integer ai_orientation);/*
Función wf_cambia_dw

Parámetros:
as_nom_datawindow string
	Cadena con el nombre del datawindow

ai_zoom				integer
	Donde ai_zoom > 0 y es el porcentaje de la impresion
	
ai_orientation 	integer
	0 - La orientation de default de la impresora
	1 - Landscape
	2 - Portrait
*/


if isnull(dw_1.DataObject) then
	MessageBox("Nombre de DataWindow Inválido","El DataWindow :"+as_nom_datawindow+" no existe")	
	return 0
end if

if isnull(ai_zoom) or ai_zoom <= 0 then
	MessageBox("Tamaño del Zoom Inválido","El Zoom :"+string(ai_zoom)+" no está permitido")	
	return 0
end if

if isnull(ai_orientation) or (ai_orientation < 0 and ai_orientation> 2) then
	MessageBox("Orientación inválida","La Orientación :"+string(ai_orientation)+" no está permitida")	
	return 0
end if

dw_1.DataObject =  as_nom_datawindow

dw_1.SetTransObject(gtr_sce)

dw_1.Object.DataWindow.Print.Preview.Zoom = ai_zoom

dw_1.Object.DataWindow.Print.Orientation = ai_orientation

m_menu_reporte.dw = dw_1

return 0
end function

on w_bitacora_constancias.create
if this.MenuName = "m_menu_reporte" then this.MenuID = create m_menu_reporte
this.st_3=create st_3
this.uo_constancia=create uo_constancia
this.cb_1=create cb_1
this.st_2=create st_2
this.st_fecha_final=create st_fecha_final
this.st_1=create st_1
this.em_fecha_final=create em_fecha_final
this.em_fecha_inicial=create em_fecha_inicial
this.dw_1=create dw_1
this.Control[]={this.st_3,&
this.uo_constancia,&
this.cb_1,&
this.st_2,&
this.st_fecha_final,&
this.st_1,&
this.em_fecha_final,&
this.em_fecha_inicial,&
this.dw_1}
end on

on w_bitacora_constancias.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_3)
destroy(this.uo_constancia)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.st_fecha_final)
destroy(this.st_1)
destroy(this.em_fecha_final)
destroy(this.em_fecha_inicial)
destroy(this.dw_1)
end on

event open;datetime lddtm_fecha
string ls_fecha_inicial, ls_fecha_final

lddtm_fecha = fecha_servidor(gtr_sce)


ls_fecha_inicial = string(lddtm_fecha, "dd/mm/yyyy" )
ls_fecha_final = string(lddtm_fecha, "dd/mm/yyyy" )


em_fecha_inicial.text = ls_fecha_inicial
em_fecha_final.text = ls_fecha_final



end event

type st_3 from statictext within w_bitacora_constancias
int X=841
int Y=188
int Width=567
int Height=76
boolean Enabled=false
string Text="Tipo de Constancia:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_constancia from uo_constancias within w_bitacora_constancias
int X=1422
int Y=156
int TabOrder=10
end type

on uo_constancia.destroy
call uo_constancias::destroy
end on

type cb_1 from commandbutton within w_bitacora_constancias
int X=3013
int Y=168
int Width=361
int Height=108
int TabOrder=20
string Text="Cargar"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_fecha_inicial, ls_fecha_final
date ldt_fecha_inicial, ldt_fecha_final
datetime ldttm_fecha_inicial, ldttm_fecha_final
integer li_num_registros, li_cve_constancia

if isnull(dw_1.DataObject) then
	return
end if

ls_fecha_inicial= em_fecha_inicial.text
ls_fecha_final= em_fecha_final.text

ldt_fecha_inicial =date(ls_fecha_inicial)
ldt_fecha_final =date(ls_fecha_final)

if ldt_fecha_final < ldt_fecha_inicial then
	MessageBox("Error de fechas","La fecha inicial no debe ser mayor a la fecha final")
end if 

//ldt_fecha_inicial= RelativeDate(ldt_fecha_inicial, -1)

ldt_fecha_final= RelativeDate(ldt_fecha_final, +1)

ldttm_fecha_inicial =datetime(ldt_fecha_inicial)
ldttm_fecha_final =datetime(ldt_fecha_final)

li_cve_constancia= uo_constancia.ii_cve_constancia
//MessageBox("Constancias","Clave "+string(li_cve_constancia))

li_num_registros= dw_1.retrieve(ldttm_fecha_inicial, ldttm_fecha_final, li_cve_constancia)








end event

type st_2 from statictext within w_bitacora_constancias
int X=443
int Y=40
int Width=370
int Height=72
boolean Enabled=false
string Text="dd/mm/yyyy"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_fecha_final from statictext within w_bitacora_constancias
int X=110
int Y=264
int Width=283
int Height=64
boolean Enabled=false
string Text="Fecha Final"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_bitacora_constancias
int X=110
int Y=140
int Width=283
int Height=64
boolean Enabled=false
string Text="Fecha Inicial"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_fecha_final from editmask within w_bitacora_constancias
int X=434
int Y=256
int Width=370
int Height=84
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
string Mask="dd/mm/yyyy"
MaskDataType MaskDataType=DateTimeMask!
long TextColor=33554432
long BackColor=15793151
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_fecha_inicial from editmask within w_bitacora_constancias
int X=434
int Y=132
int Width=370
int Height=84
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string Mask="dd/mm/yyyy"
MaskDataType MaskDataType=DateTimeMask!
long TextColor=33554432
long BackColor=15793151
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from datawindow within w_bitacora_constancias
event carga ( )
int X=78
int Y=492
int Width=3296
int Height=896
int TabOrder=40
string DataObject="d_bitacora_constancias"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event carga;string ls_fecha_inicial, ls_fecha_final
date ldt_fecha_inicial, ldt_fecha_final
datetime ldttm_fecha_inicial, ldttm_fecha_final
integer li_num_registros, li_cve_constancia

if isnull(dw_1.DataObject) then
	return
end if

ls_fecha_inicial= em_fecha_inicial.text
ls_fecha_final= em_fecha_final.text

ldt_fecha_inicial =date(ls_fecha_inicial)
ldt_fecha_final =date(ls_fecha_final)

if ldt_fecha_final < ldt_fecha_inicial then
	MessageBox("Error de fechas","La fecha inicial no debe ser mayor a la fecha final")
end if 

//ldt_fecha_inicial= RelativeDate(ldt_fecha_inicial, -1)

ldt_fecha_final= RelativeDate(ldt_fecha_final, +1)

ldttm_fecha_inicial =datetime(ldt_fecha_inicial)
ldttm_fecha_final =datetime(ldt_fecha_final)

li_cve_constancia= uo_constancia.ii_cve_constancia
//MessageBox("Constancias","Clave "+string(li_cve_constancia))

li_num_registros= dw_1.retrieve(ldttm_fecha_inicial, ldttm_fecha_final, li_cve_constancia)








end event

event constructor;SetTransObject(gtr_sce)
m_menu_reporte.dw = dw_1
end event

