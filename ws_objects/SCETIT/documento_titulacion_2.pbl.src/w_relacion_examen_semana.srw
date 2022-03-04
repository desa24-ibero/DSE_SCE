$PBExportHeader$w_relacion_examen_semana.srw
forward
global type w_relacion_examen_semana from window
end type
type cb_1 from commandbutton within w_relacion_examen_semana
end type
type st_2 from statictext within w_relacion_examen_semana
end type
type st_fecha_final from statictext within w_relacion_examen_semana
end type
type st_1 from statictext within w_relacion_examen_semana
end type
type em_fecha_final from editmask within w_relacion_examen_semana
end type
type em_fecha_inicial from editmask within w_relacion_examen_semana
end type
type dw_1 from datawindow within w_relacion_examen_semana
end type
end forward

global type w_relacion_examen_semana from window
integer x = 37
integer y = 211
integer width = 3650
integer height = 1667
boolean titlebar = true
string title = "Relación de Examenes por Semana"
string menuname = "m_menu_reporte"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
cb_1 cb_1
st_2 st_2
st_fecha_final st_fecha_final
st_1 st_1
em_fecha_final em_fecha_final
em_fecha_inicial em_fecha_inicial
dw_1 dw_1
end type
global w_relacion_examen_semana w_relacion_examen_semana

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

on w_relacion_examen_semana.create
if this.MenuName = "m_menu_reporte" then this.MenuID = create m_menu_reporte
this.cb_1=create cb_1
this.st_2=create st_2
this.st_fecha_final=create st_fecha_final
this.st_1=create st_1
this.em_fecha_final=create em_fecha_final
this.em_fecha_inicial=create em_fecha_inicial
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.st_2,&
this.st_fecha_final,&
this.st_1,&
this.em_fecha_final,&
this.em_fecha_inicial,&
this.dw_1}
end on

on w_relacion_examen_semana.destroy
if IsValid(MenuID) then destroy(MenuID)
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

x=1
y=1

end event

type cb_1 from commandbutton within w_relacion_examen_semana
integer x = 3013
integer y = 170
integer width = 362
integer height = 109
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cargar"
end type

event clicked;
dw_1.event Carga()






end event

type st_2 from statictext within w_relacion_examen_semana
integer x = 1649
integer y = 61
integer width = 369
integer height = 74
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "dd/mm/yyyy"
boolean focusrectangle = false
end type

type st_fecha_final from statictext within w_relacion_examen_semana
integer x = 1415
integer y = 285
integer width = 201
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Fecha Final"
boolean focusrectangle = false
end type

type st_1 from statictext within w_relacion_examen_semana
integer x = 1415
integer y = 160
integer width = 201
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Fecha Inicial"
boolean focusrectangle = false
end type

type em_fecha_final from editmask within w_relacion_examen_semana
integer x = 1642
integer y = 275
integer width = 369
integer height = 83
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15793151
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type em_fecha_inicial from editmask within w_relacion_examen_semana
integer x = 1642
integer y = 150
integer width = 369
integer height = 83
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15793151
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type dw_1 from datawindow within w_relacion_examen_semana
event carga ( )
integer x = 77
integer y = 493
integer width = 3295
integer height = 896
integer taborder = 60
string dataobject = "d_relacion_examen_semana"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event carga();string ls_fecha_inicial, ls_fecha_final, ls_gpo
date ldt_fecha_inicial, ldt_fecha_final
datetime ldttm_fecha_inicial, ldttm_fecha_final
integer li_num_registros, li_cve_constancia
long ll_cve_mat

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

li_num_registros= dw_1.retrieve(ldttm_fecha_inicial, ldttm_fecha_final, ll_cve_mat, ls_gpo)








end event

event constructor;SetTransObject(gtr_sce)
m_menu_reporte.dw = dw_1
end event

