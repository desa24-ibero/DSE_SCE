$PBExportHeader$w_bitacora_profesor_auxiliar.srw
forward
global type w_bitacora_profesor_auxiliar from window
end type
type cbx_todos from checkbox within w_bitacora_profesor_auxiliar
end type
type st_gpo from statictext within w_bitacora_profesor_auxiliar
end type
type st_materia from statictext within w_bitacora_profesor_auxiliar
end type
type em_gpo from editmask within w_bitacora_profesor_auxiliar
end type
type em_cve_mat from editmask within w_bitacora_profesor_auxiliar
end type
type cb_1 from commandbutton within w_bitacora_profesor_auxiliar
end type
type st_2 from statictext within w_bitacora_profesor_auxiliar
end type
type st_fecha_final from statictext within w_bitacora_profesor_auxiliar
end type
type st_1 from statictext within w_bitacora_profesor_auxiliar
end type
type em_fecha_final from editmask within w_bitacora_profesor_auxiliar
end type
type em_fecha_inicial from editmask within w_bitacora_profesor_auxiliar
end type
type dw_1 from datawindow within w_bitacora_profesor_auxiliar
end type
end forward

global type w_bitacora_profesor_auxiliar from window
integer x = 37
integer y = 212
integer width = 3959
integer height = 2652
boolean titlebar = true
string title = "Consulta Bitácora de Profesores Auxiliares"
string menuname = "m_menu_reporte"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
cbx_todos cbx_todos
st_gpo st_gpo
st_materia st_materia
em_gpo em_gpo
em_cve_mat em_cve_mat
cb_1 cb_1
st_2 st_2
st_fecha_final st_fecha_final
st_1 st_1
em_fecha_final em_fecha_final
em_fecha_inicial em_fecha_inicial
dw_1 dw_1
end type
global w_bitacora_profesor_auxiliar w_bitacora_profesor_auxiliar

type variables
Datawindowchild dwc_periodo
end variables

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

on w_bitacora_profesor_auxiliar.create
if this.MenuName = "m_menu_reporte" then this.MenuID = create m_menu_reporte
this.cbx_todos=create cbx_todos
this.st_gpo=create st_gpo
this.st_materia=create st_materia
this.em_gpo=create em_gpo
this.em_cve_mat=create em_cve_mat
this.cb_1=create cb_1
this.st_2=create st_2
this.st_fecha_final=create st_fecha_final
this.st_1=create st_1
this.em_fecha_final=create em_fecha_final
this.em_fecha_inicial=create em_fecha_inicial
this.dw_1=create dw_1
this.Control[]={this.cbx_todos,&
this.st_gpo,&
this.st_materia,&
this.em_gpo,&
this.em_cve_mat,&
this.cb_1,&
this.st_2,&
this.st_fecha_final,&
this.st_1,&
this.em_fecha_final,&
this.em_fecha_inicial,&
this.dw_1}
end on

on w_bitacora_profesor_auxiliar.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_todos)
destroy(this.st_gpo)
destroy(this.st_materia)
destroy(this.em_gpo)
destroy(this.em_cve_mat)
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


//Modif. Roberto Novoa May/2016 .- Funcionalidad periodos multiples
f_dddw_converter(dw_1, dwc_periodo, "periodo")

end event

type cbx_todos from checkbox within w_bitacora_profesor_auxiliar
integer x = 133
integer y = 156
integer width = 553
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Todos los grupos"
boolean checked = true
end type

event clicked;//Habilita la seleccion de grupos o no

if this.checked then
	em_cve_mat.enabled = false
	em_gpo.enabled = false
else
	em_cve_mat.enabled = true
	em_gpo.enabled = true
end if
end event

type st_gpo from statictext within w_bitacora_profesor_auxiliar
integer x = 608
integer y = 284
integer width = 183
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
string text = "Grupo"
boolean focusrectangle = false
end type

type st_materia from statictext within w_bitacora_profesor_auxiliar
integer x = 119
integer y = 284
integer width = 215
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
string text = "Materia"
boolean focusrectangle = false
end type

type em_gpo from editmask within w_bitacora_profesor_auxiliar
integer x = 786
integer y = 276
integer width = 137
integer height = 84
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15793151
boolean enabled = false
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!"
end type

type em_cve_mat from editmask within w_bitacora_profesor_auxiliar
integer x = 352
integer y = 276
integer width = 229
integer height = 84
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15793151
boolean enabled = false
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type cb_1 from commandbutton within w_bitacora_profesor_auxiliar
integer x = 3013
integer y = 172
integer width = 361
integer height = 108
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

type st_2 from statictext within w_bitacora_profesor_auxiliar
integer x = 1650
integer y = 60
integer width = 370
integer height = 76
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

type st_fecha_final from statictext within w_bitacora_profesor_auxiliar
integer x = 1417
integer y = 284
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

type st_1 from statictext within w_bitacora_profesor_auxiliar
integer x = 1417
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

type em_fecha_final from editmask within w_bitacora_profesor_auxiliar
integer x = 1641
integer y = 276
integer width = 370
integer height = 84
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

type em_fecha_inicial from editmask within w_bitacora_profesor_auxiliar
integer x = 1641
integer y = 152
integer width = 370
integer height = 84
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

type dw_1 from datawindow within w_bitacora_profesor_auxiliar
event carga ( )
integer x = 55
integer y = 492
integer width = 3813
integer height = 1912
integer taborder = 60
string dataobject = "d_bitacora_profesor_auxiliar"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
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

if cbx_todos.checked then
	ll_cve_mat = 9999
	ls_gpo = "99"
else
	if not isnumber(em_cve_mat.text) then
		MessageBox("Error de materia","La materia escrita no es valida")	
		return
	end if
	if isnull(em_gpo.text) or (em_gpo.text = "") then
		MessageBox("Error de grupo","El grupo escrito no es valido")	
		return
	end if
	ll_cve_mat = long(em_cve_mat.text)
	ls_gpo = em_gpo.text
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

li_num_registros= dw_1.retrieve(ldttm_fecha_inicial, ldttm_fecha_final, ll_cve_mat, ls_gpo, gs_tipo_periodo)








end event

event constructor;SetTransObject(gtr_sce)
m_menu_reporte.dw = dw_1
end event

