$PBExportHeader$w_bitacora_revalidacion.srw
forward
global type w_bitacora_revalidacion from Window
end type
type rb_print from radiobutton within w_bitacora_revalidacion
end type
type rb_update from radiobutton within w_bitacora_revalidacion
end type
type cb_1 from commandbutton within w_bitacora_revalidacion
end type
type st_2 from statictext within w_bitacora_revalidacion
end type
type st_fecha_final from statictext within w_bitacora_revalidacion
end type
type st_1 from statictext within w_bitacora_revalidacion
end type
type em_fecha_final from editmask within w_bitacora_revalidacion
end type
type em_fecha_inicial from editmask within w_bitacora_revalidacion
end type
type dw_1 from datawindow within w_bitacora_revalidacion
end type
end forward

global type w_bitacora_revalidacion from Window
int X=37
int Y=211
int Width=3650
int Height=1667
boolean TitleBar=true
string Title="Consulta Bitácora de Revalidación"
string MenuName="m_menu_reporte"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
rb_print rb_print
rb_update rb_update
cb_1 cb_1
st_2 st_2
st_fecha_final st_fecha_final
st_1 st_1
em_fecha_final em_fecha_final
em_fecha_inicial em_fecha_inicial
dw_1 dw_1
end type
global w_bitacora_revalidacion w_bitacora_revalidacion

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

on w_bitacora_revalidacion.create
if this.MenuName = "m_menu_reporte" then this.MenuID = create m_menu_reporte
this.rb_print=create rb_print
this.rb_update=create rb_update
this.cb_1=create cb_1
this.st_2=create st_2
this.st_fecha_final=create st_fecha_final
this.st_1=create st_1
this.em_fecha_final=create em_fecha_final
this.em_fecha_inicial=create em_fecha_inicial
this.dw_1=create dw_1
this.Control[]={this.rb_print,&
this.rb_update,&
this.cb_1,&
this.st_2,&
this.st_fecha_final,&
this.st_1,&
this.em_fecha_final,&
this.em_fecha_inicial,&
this.dw_1}
end on

on w_bitacora_revalidacion.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_print)
destroy(this.rb_update)
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

type rb_print from radiobutton within w_bitacora_revalidacion
int X=417
int Y=278
int Width=355
int Height=77
string Text="Impresión"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
dw_1.DataObject = 'd_bitacora_print_reval_sep'
dw_1.SetTransObject(gtr_sce)
end event

type rb_update from radiobutton within w_bitacora_revalidacion
int X=73
int Y=131
int Width=699
int Height=77
string Text="Inserción/Eliminación"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
dw_1.DataObject = 'd_bitacora_revalidacion'
dw_1.SetTransObject(gtr_sce)
end event

type cb_1 from commandbutton within w_bitacora_revalidacion
int X=3013
int Y=170
int Width=362
int Height=109
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

//li_cve_constancia= uo_constancia.ii_cve_constancia
//MessageBox("Constancias","Clave "+string(li_cve_constancia))

li_num_registros= dw_1.retrieve(ldttm_fecha_inicial, ldttm_fecha_final)








end event

type st_2 from statictext within w_bitacora_revalidacion
int X=1649
int Y=61
int Width=369
int Height=74
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

type st_fecha_final from statictext within w_bitacora_revalidacion
int X=1317
int Y=285
int Width=282
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

type st_1 from statictext within w_bitacora_revalidacion
int X=1317
int Y=160
int Width=282
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

type em_fecha_final from editmask within w_bitacora_revalidacion
int X=1642
int Y=275
int Width=369
int Height=83
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

type em_fecha_inicial from editmask within w_bitacora_revalidacion
int X=1642
int Y=150
int Width=369
int Height=83
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

type dw_1 from datawindow within w_bitacora_revalidacion
event carga ( )
int X=77
int Y=493
int Width=3295
int Height=896
int TabOrder=40
string DataObject="d_bitacora_revalidacion"
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

//li_cve_constancia= uo_constancia.ii_cve_constancia
//MessageBox("Constancias","Clave "+string(li_cve_constancia))

li_num_registros= dw_1.retrieve(ldttm_fecha_inicial, ldttm_fecha_final)








end event

event constructor;SetTransObject(gtr_sce)
m_menu_reporte.dw = dw_1
end event

