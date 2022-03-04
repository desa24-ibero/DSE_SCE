$PBExportHeader$w_consulta_bitacoras.srw
forward
global type w_consulta_bitacoras from Window
end type
type cb_1 from commandbutton within w_consulta_bitacoras
end type
type st_2 from statictext within w_consulta_bitacoras
end type
type st_fecha_final from statictext within w_consulta_bitacoras
end type
type st_1 from statictext within w_consulta_bitacoras
end type
type em_fecha_final from editmask within w_consulta_bitacoras
end type
type em_fecha_inicial from editmask within w_consulta_bitacoras
end type
type rb_4 from radiobutton within w_consulta_bitacoras
end type
type rb_3 from radiobutton within w_consulta_bitacoras
end type
type rb_2 from radiobutton within w_consulta_bitacoras
end type
type rb_1 from radiobutton within w_consulta_bitacoras
end type
type dw_1 from datawindow within w_consulta_bitacoras
end type
type dw_pfc from u_dw within w_consulta_bitacoras
end type
end forward

global type w_consulta_bitacoras from Window
int X=37
int Y=212
int Width=2962
int Height=1632
boolean TitleBar=true
string Title="Consulta de Bitácoras"
string MenuName="m_menu_reporte"
long BackColor=78682240
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_1 cb_1
st_2 st_2
st_fecha_final st_fecha_final
st_1 st_1
em_fecha_final em_fecha_final
em_fecha_inicial em_fecha_inicial
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
dw_1 dw_1
dw_pfc dw_pfc
end type
global w_consulta_bitacoras w_consulta_bitacoras

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

dw_1.SetTransObject(gnv_app.inv_trans)

dw_1.Object.DataWindow.Print.Preview.Zoom = ai_zoom

dw_1.Object.DataWindow.Print.Orientation = ai_orientation

m_menu_reporte.dw = dw_1

return 0
end function

on w_consulta_bitacoras.create
if this.MenuName = "m_menu_reporte" then this.MenuID = create m_menu_reporte
this.cb_1=create cb_1
this.st_2=create st_2
this.st_fecha_final=create st_fecha_final
this.st_1=create st_1
this.em_fecha_final=create em_fecha_final
this.em_fecha_inicial=create em_fecha_inicial
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.dw_1=create dw_1
this.dw_pfc=create dw_pfc
this.Control[]={this.cb_1,&
this.st_2,&
this.st_fecha_final,&
this.st_1,&
this.em_fecha_final,&
this.em_fecha_inicial,&
this.rb_4,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.dw_1,&
this.dw_pfc}
end on

on w_consulta_bitacoras.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.st_fecha_final)
destroy(this.st_1)
destroy(this.em_fecha_final)
destroy(this.em_fecha_inicial)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.dw_1)
destroy(this.dw_pfc)
end on

event open;datetime lddtm_fecha
string ls_fecha_inicial, ls_fecha_final

lddtm_fecha = fecha_servidor(gnv_app.inv_trans)


ls_fecha_inicial = string(lddtm_fecha, "dd/mm/yyyy" )
ls_fecha_final = string(lddtm_fecha, "dd/mm/yyyy" )


em_fecha_inicial.text = ls_fecha_inicial
em_fecha_final.text = ls_fecha_final



end event

type cb_1 from commandbutton within w_consulta_bitacoras
int X=2167
int Y=172
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
integer li_num_registros

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

ldt_fecha_inicial= RelativeDate(ldt_fecha_inicial, -1)

ldt_fecha_final= RelativeDate(ldt_fecha_final, +1)

ldttm_fecha_inicial =datetime(ldt_fecha_inicial)
ldttm_fecha_final =datetime(ldt_fecha_final)

li_num_registros= dw_1.retrieve(ldttm_fecha_inicial, ldttm_fecha_final)








end event

type st_2 from statictext within w_consulta_bitacoras
int X=1541
int Y=64
int Width=274
int Height=56
boolean Enabled=false
string Text="dd/mm/yyyy"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_fecha_final from statictext within w_consulta_bitacoras
int X=1198
int Y=264
int Width=283
int Height=64
boolean Enabled=false
string Text="Fecha Final"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_consulta_bitacoras
int X=1198
int Y=140
int Width=283
int Height=64
boolean Enabled=false
string Text="Fecha Inicial"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_fecha_final from editmask within w_consulta_bitacoras
int X=1522
int Y=256
int Width=338
int Height=84
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
string Mask="dd/mm/yyyy"
MaskDataType MaskDataType=DateTimeMask!
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_fecha_inicial from editmask within w_consulta_bitacoras
int X=1522
int Y=132
int Width=338
int Height=84
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string Mask="dd/mm/yyyy"
MaskDataType MaskDataType=DateTimeMask!
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_4 from radiobutton within w_consulta_bitacoras
int X=242
int Y=344
int Width=507
int Height=80
string Text="Users"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_cambia_dw("d_bit_security_users", 100, 2)
end event

type rb_3 from radiobutton within w_consulta_bitacoras
int X=242
int Y=240
int Width=507
int Height=80
string Text="Objects"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_cambia_dw("d_bit_security_info", 100, 1)
end event

type rb_2 from radiobutton within w_consulta_bitacoras
int X=242
int Y=140
int Width=507
int Height=80
string Text="Groups"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_cambia_dw("d_bit_security_groupings", 100, 2)
end event

type rb_1 from radiobutton within w_consulta_bitacoras
int X=242
int Y=40
int Width=507
int Height=80
string Text="Users/Applications"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_cambia_dw("d_bit_security_user_app", 100, 2)
end event

type dw_1 from datawindow within w_consulta_bitacoras
event carga ( )
int X=69
int Y=492
int Width=2784
int Height=896
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event carga;string ls_fecha_inicial, ls_fecha_final
date ldt_fecha_inicial, ldt_fecha_final
datetime ldttm_fecha_inicial, ldttm_fecha_final


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

ldt_fecha_inicial= RelativeDate(ldt_fecha_inicial, -1)

ldt_fecha_final= RelativeDate(ldt_fecha_final, +1)

ldttm_fecha_inicial =datetime(ldt_fecha_inicial)
ldttm_fecha_final =datetime(ldt_fecha_final)

this.retrieve(ldttm_fecha_inicial, ldttm_fecha_final)






end event

event constructor;SetTransObject(gnv_app.inv_trans)
m_menu_reporte.dw = dw_1
end event

type dw_pfc from u_dw within w_consulta_bitacoras
event carga ( )
int X=14
int Y=332
int Width=3227
int Height=908
int TabOrder=30
boolean Visible=false
end type

event carga;string ls_fecha_inicial, ls_fecha_final
datetime ldttm_fecha_inicial, ldttm_fecha_final


if isnull(dw_1.DataObject) then
	return
end if

ls_fecha_inicial= em_fecha_inicial.text
ls_fecha_final= em_fecha_final.text

ldttm_fecha_inicial =datetime(ls_fecha_inicial)
ldttm_fecha_final =datetime(ls_fecha_final)

this.retrieve(ldttm_fecha_inicial, ldttm_fecha_final)






end event

event constructor;SetTransObject(gnv_app.inv_trans)
m_menu_reporte.dw = this
end event

