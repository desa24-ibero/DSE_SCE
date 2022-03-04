$PBExportHeader$w_propedeutico_reporte.srw
forward
global type w_propedeutico_reporte from window
end type
type cb_guardar from commandbutton within w_propedeutico_reporte
end type
type em_folio_inc from editmask within w_propedeutico_reporte
end type
type em_folio_fin from editmask within w_propedeutico_reporte
end type
type st_3 from statictext within w_propedeutico_reporte
end type
type st_2 from statictext within w_propedeutico_reporte
end type
type cb_salir from commandbutton within w_propedeutico_reporte
end type
type cb_imprimir from commandbutton within w_propedeutico_reporte
end type
type cb_genera from commandbutton within w_propedeutico_reporte
end type
type rb_totales from radiobutton within w_propedeutico_reporte
end type
type rb_detalle from radiobutton within w_propedeutico_reporte
end type
type st_1 from statictext within w_propedeutico_reporte
end type
type dw_carrera from datawindow within w_propedeutico_reporte
end type
type dw_propedeutico from datawindow within w_propedeutico_reporte
end type
type dw_reporte from datawindow within w_propedeutico_reporte
end type
type uo_per_ani from uo_per_ani_admision within w_propedeutico_reporte
end type
type gb_1 from groupbox within w_propedeutico_reporte
end type
type gb_2 from groupbox within w_propedeutico_reporte
end type
end forward

global type w_propedeutico_reporte from window
integer width = 5097
integer height = 2256
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_guardar cb_guardar
em_folio_inc em_folio_inc
em_folio_fin em_folio_fin
st_3 st_3
st_2 st_2
cb_salir cb_salir
cb_imprimir cb_imprimir
cb_genera cb_genera
rb_totales rb_totales
rb_detalle rb_detalle
st_1 st_1
dw_carrera dw_carrera
dw_propedeutico dw_propedeutico
dw_reporte dw_reporte
uo_per_ani uo_per_ani
gb_1 gb_1
gb_2 gb_2
end type
global w_propedeutico_reporte w_propedeutico_reporte

type variables



INTEGER ie_periodo 
INTEGER ie_anio  

end variables

on w_propedeutico_reporte.create
this.cb_guardar=create cb_guardar
this.em_folio_inc=create em_folio_inc
this.em_folio_fin=create em_folio_fin
this.st_3=create st_3
this.st_2=create st_2
this.cb_salir=create cb_salir
this.cb_imprimir=create cb_imprimir
this.cb_genera=create cb_genera
this.rb_totales=create rb_totales
this.rb_detalle=create rb_detalle
this.st_1=create st_1
this.dw_carrera=create dw_carrera
this.dw_propedeutico=create dw_propedeutico
this.dw_reporte=create dw_reporte
this.uo_per_ani=create uo_per_ani
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.cb_guardar,&
this.em_folio_inc,&
this.em_folio_fin,&
this.st_3,&
this.st_2,&
this.cb_salir,&
this.cb_imprimir,&
this.cb_genera,&
this.rb_totales,&
this.rb_detalle,&
this.st_1,&
this.dw_carrera,&
this.dw_propedeutico,&
this.dw_reporte,&
this.uo_per_ani,&
this.gb_1,&
this.gb_2}
end on

on w_propedeutico_reporte.destroy
destroy(this.cb_guardar)
destroy(this.em_folio_inc)
destroy(this.em_folio_fin)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cb_salir)
destroy(this.cb_imprimir)
destroy(this.cb_genera)
destroy(this.rb_totales)
destroy(this.rb_detalle)
destroy(this.st_1)
destroy(this.dw_carrera)
destroy(this.dw_propedeutico)
destroy(this.dw_reporte)
destroy(this.uo_per_ani)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;dw_propedeutico.SETTRANSOBJECT(gtr_sadm) 
dw_propedeutico.INSERTROW(0) 
dw_carrera.SETTRANSOBJECT(gtr_sadm) 
dw_carrera.INSERTROW(0)

THIS.uo_per_ani.TRIGGEREVENT("ue_modifica")
end event

type cb_guardar from commandbutton within w_propedeutico_reporte
integer x = 4599
integer y = 600
integer width = 402
integer height = 112
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salvar"
end type

event clicked;if dw_reporte.SaveAs("",Excel!, TRUE)<>1 then
	dw_reporte.SaveAs("",Clipboard!, TRUE)
	messagebox("No se pudo guardar el archivo","La información se encuentra en el Clipboard")	
end if

end event

type em_folio_inc from editmask within w_propedeutico_reporte
integer x = 4110
integer y = 80
integer width = 402
integer height = 80
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "#########"
end type

type em_folio_fin from editmask within w_propedeutico_reporte
integer x = 4110
integer y = 172
integer width = 402
integer height = 80
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "#########"
end type

type st_3 from statictext within w_propedeutico_reporte
integer x = 3982
integer y = 180
integer width = 128
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fin: "
boolean focusrectangle = false
end type

type st_2 from statictext within w_propedeutico_reporte
integer x = 3982
integer y = 88
integer width = 128
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Inc.: "
boolean focusrectangle = false
end type

type cb_salir from commandbutton within w_propedeutico_reporte
integer x = 4599
integer y = 740
integer width = 402
integer height = 112
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;CLOSE(PARENT)
end event

type cb_imprimir from commandbutton within w_propedeutico_reporte
integer x = 4599
integer y = 460
integer width = 402
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprimir"
end type

event clicked;dw_reporte.modify("Datawindow.print.preview = Yes")
dw_reporte.modify("Datawindow.print.Orientation = 1")
SetPointer(HourGlass!)
openwithparm(conf_impr,dw_reporte)
end event

type cb_genera from commandbutton within w_propedeutico_reporte
integer x = 4599
integer y = 320
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar"
end type

event clicked;IF rb_detalle.CHECKED THEN 
	dw_reporte.DATAOBJECT = "dw_prop_resultado_reporte_detalle"
ELSE
	dw_reporte.DATAOBJECT = "dw_prop_resultado_reporte_prop"
END IF

STRING ls_prop 
LONG ll_cve_carrera 
STRING ls_filtro 
STRING ls_fol_inc, ls_fol_fin

ls_prop = dw_propedeutico.GETITEMSTRING(1, "id_prop")
ll_cve_carrera = dw_carrera.GETITEMNUMBER(1, "cve_carrera")  

dw_reporte.SETTRANSOBJECT(gtr_sadm) 
dw_reporte.RETRIEVE(ie_periodo, ie_anio, ls_prop, ll_cve_carrera) 

ls_fol_inc = em_folio_inc.TEXT 
IF ISNULL(ls_fol_inc) THEN ls_fol_inc= "" 
ls_fol_fin = em_folio_fin.TEXT 
IF ISNULL(ls_fol_fin) THEN ls_fol_fin = "" 

IF rb_detalle.CHECKED THEN 
	IF TRIM(ls_fol_inc) <> "" OR TRIM(ls_fol_fin) <> "" THEN 
	
		IF TRIM(ls_fol_inc) <> "" AND TRIM(ls_fol_fin) <> "" THEN 
			ls_filtro = "aspiran_folio >= " + ls_fol_inc + " AND aspiran_folio <= " + ls_fol_fin 
		ELSEIF TRIM(ls_fol_inc) <> "" THEN 
			ls_filtro = "aspiran_folio = " + ls_fol_inc  
		ELSEIF TRIM(ls_fol_fin) <> "" THEN 
			ls_filtro = "aspiran_folio = " + ls_fol_fin  
		END IF
		//aspiran_folio
		dw_reporte.SETFILTER(ls_filtro) 
		dw_reporte.FILTER() 
		dw_reporte.GROUPCALC()
		
	END IF
END IF 



 
end event

type rb_totales from radiobutton within w_propedeutico_reporte
integer x = 3543
integer y = 156
integer width = 334
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Totales"
end type

type rb_detalle from radiobutton within w_propedeutico_reporte
integer x = 3543
integer y = 60
integer width = 334
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detalle"
boolean checked = true
end type

type st_1 from statictext within w_propedeutico_reporte
integer x = 1330
integer y = 60
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Propedéutico: "
boolean focusrectangle = false
end type

type dw_carrera from datawindow within w_propedeutico_reporte
integer x = 1376
integer y = 168
integer width = 2130
integer height = 100
integer taborder = 50
string title = "none"
string dataobject = "dw_prop_selecciona_carrera"
boolean border = false
boolean livescroll = true
end type

type dw_propedeutico from datawindow within w_propedeutico_reporte
integer x = 1765
integer y = 60
integer width = 1088
integer height = 84
integer taborder = 40
string title = "none"
string dataobject = "dw_propedeutico_lista_reporte"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_reporte from datawindow within w_propedeutico_reporte
integer x = 59
integer y = 304
integer width = 4480
integer height = 1752
integer taborder = 40
string title = "none"
string dataobject = "dw_prop_resultado_reporte_detalle"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_per_ani from uo_per_ani_admision within w_propedeutico_reporte
event destroy ( )
integer x = 59
integer y = 64
integer taborder = 30
boolean enabled = true
long backcolor = 67108864
end type

on uo_per_ani.destroy
call uo_per_ani_admision::destroy
end on

event ue_modifica;call super::ue_modifica;
PARENT.ie_periodo = THIS.ie_periodo
PARENT.ie_anio = THIS.ie_anio
end event

type gb_1 from groupbox within w_propedeutico_reporte
integer x = 3511
integer width = 398
integer height = 276
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within w_propedeutico_reporte
integer x = 3941
integer y = 4
integer width = 608
integer height = 272
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Folios:"
end type

