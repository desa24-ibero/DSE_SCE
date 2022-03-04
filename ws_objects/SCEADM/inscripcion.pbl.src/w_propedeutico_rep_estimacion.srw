$PBExportHeader$w_propedeutico_rep_estimacion.srw
forward
global type w_propedeutico_rep_estimacion from window
end type
type cb_genera from commandbutton within w_propedeutico_rep_estimacion
end type
type cb_imprimir from commandbutton within w_propedeutico_rep_estimacion
end type
type cb_salir from commandbutton within w_propedeutico_rep_estimacion
end type
type cb_guardar from commandbutton within w_propedeutico_rep_estimacion
end type
type uo_per_ani from uo_per_ani_admision within w_propedeutico_rep_estimacion
end type
type dw_propedeutico from datawindow within w_propedeutico_rep_estimacion
end type
type dw_carrera from datawindow within w_propedeutico_rep_estimacion
end type
type st_1 from statictext within w_propedeutico_rep_estimacion
end type
type rb_detalle from radiobutton within w_propedeutico_rep_estimacion
end type
type rb_totales from radiobutton within w_propedeutico_rep_estimacion
end type
type st_2 from statictext within w_propedeutico_rep_estimacion
end type
type st_3 from statictext within w_propedeutico_rep_estimacion
end type
type em_folio_fin from editmask within w_propedeutico_rep_estimacion
end type
type em_folio_inc from editmask within w_propedeutico_rep_estimacion
end type
type dw_reporte from datawindow within w_propedeutico_rep_estimacion
end type
type gb_1 from groupbox within w_propedeutico_rep_estimacion
end type
type gb_2 from groupbox within w_propedeutico_rep_estimacion
end type
end forward

global type w_propedeutico_rep_estimacion from window
integer width = 6021
integer height = 2388
boolean titlebar = true
string title = "Estimación de Propedéuticos Requeridos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_genera cb_genera
cb_imprimir cb_imprimir
cb_salir cb_salir
cb_guardar cb_guardar
uo_per_ani uo_per_ani
dw_propedeutico dw_propedeutico
dw_carrera dw_carrera
st_1 st_1
rb_detalle rb_detalle
rb_totales rb_totales
st_2 st_2
st_3 st_3
em_folio_fin em_folio_fin
em_folio_inc em_folio_inc
dw_reporte dw_reporte
gb_1 gb_1
gb_2 gb_2
end type
global w_propedeutico_rep_estimacion w_propedeutico_rep_estimacion

type variables

INTEGER ie_periodo 
INTEGER ie_anio 

uo_propedeuticos_reportes iuo_propedeuticos_reportes 
end variables

on w_propedeutico_rep_estimacion.create
this.cb_genera=create cb_genera
this.cb_imprimir=create cb_imprimir
this.cb_salir=create cb_salir
this.cb_guardar=create cb_guardar
this.uo_per_ani=create uo_per_ani
this.dw_propedeutico=create dw_propedeutico
this.dw_carrera=create dw_carrera
this.st_1=create st_1
this.rb_detalle=create rb_detalle
this.rb_totales=create rb_totales
this.st_2=create st_2
this.st_3=create st_3
this.em_folio_fin=create em_folio_fin
this.em_folio_inc=create em_folio_inc
this.dw_reporte=create dw_reporte
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.cb_genera,&
this.cb_imprimir,&
this.cb_salir,&
this.cb_guardar,&
this.uo_per_ani,&
this.dw_propedeutico,&
this.dw_carrera,&
this.st_1,&
this.rb_detalle,&
this.rb_totales,&
this.st_2,&
this.st_3,&
this.em_folio_fin,&
this.em_folio_inc,&
this.dw_reporte,&
this.gb_1,&
this.gb_2}
end on

on w_propedeutico_rep_estimacion.destroy
destroy(this.cb_genera)
destroy(this.cb_imprimir)
destroy(this.cb_salir)
destroy(this.cb_guardar)
destroy(this.uo_per_ani)
destroy(this.dw_propedeutico)
destroy(this.dw_carrera)
destroy(this.st_1)
destroy(this.rb_detalle)
destroy(this.rb_totales)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.em_folio_fin)
destroy(this.em_folio_inc)
destroy(this.dw_reporte)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;iuo_propedeuticos_reportes = CREATE uo_propedeuticos_reportes 
 
dw_propedeutico.SETTRANSOBJECT(gtr_sadm) 
dw_propedeutico.INSERTROW(0) 
dw_carrera.SETTRANSOBJECT(gtr_sadm) 
dw_carrera.INSERTROW(0) 
dw_carrera.SETITEM(1, "cve_carrera", 9999)

THIS.uo_per_ani.TRIGGEREVENT("ue_modifica")
end event

type cb_genera from commandbutton within w_propedeutico_rep_estimacion
integer x = 3177
integer y = 96
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar"
end type

event clicked;STRING ls_prop 
STRING ls_query 
STRING ls_desc_curso 

iuo_propedeuticos_reportes.of_carga_configuracion( )


ls_prop = dw_propedeutico.GETITEMSTRING(1, "id_prop")

IF ls_prop = "Q" THEN 
	ls_query = iuo_propedeuticos_reportes.of_generaquery_sqp(ie_periodo, ie_anio, ls_prop) 
	dw_reporte.DATAOBJECT = "dw_propedeuticos_estimacion_rep_sqp"	
ELSE	
	ls_query = iuo_propedeuticos_reportes.of_genera_sql(ie_periodo, ie_anio, ls_prop) 
	dw_reporte.DATAOBJECT = "dw_propedeuticos_estimacion_rep"
END IF 

dw_reporte.SETTRANSOBJECT(gtr_sadm) 
dw_reporte.MODIFY("Datawindow.Table.Select = '" + ls_query + "'")   
dw_reporte.RETRIEVE() 

SELECT descripcion 
INTO :ls_desc_curso 
FROM propedeuticos 
WHERE id_prop = :ls_prop 
USING gtr_sadm; 
IF gtr_sadm.SQLCODE < 0 THEN 
	Messagebox("Error", "Se produjo un error al recuperar a descripción del curso propedéutico: " + gtr_sadm.SQLERRTEXT) 
END IF

dw_reporte.MODIFY("t_titulo.TEXT = '" + UPPER(ls_desc_curso) + "'")  








end event

type cb_imprimir from commandbutton within w_propedeutico_rep_estimacion
integer x = 3593
integer y = 96
integer width = 402
integer height = 112
integer taborder = 20
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

type cb_salir from commandbutton within w_propedeutico_rep_estimacion
integer x = 4425
integer y = 96
integer width = 402
integer height = 112
integer taborder = 30
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

type cb_guardar from commandbutton within w_propedeutico_rep_estimacion
integer x = 4009
integer y = 96
integer width = 402
integer height = 112
integer taborder = 20
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

type uo_per_ani from uo_per_ani_admision within w_propedeutico_rep_estimacion
event destroy ( )
integer x = 59
integer y = 64
integer taborder = 40
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

type dw_propedeutico from datawindow within w_propedeutico_rep_estimacion
integer x = 1765
integer y = 88
integer width = 1088
integer height = 84
integer taborder = 10
string title = "none"
string dataobject = "dw_propedeutico_lista_reporte"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_carrera from datawindow within w_propedeutico_rep_estimacion
boolean visible = false
integer x = 1376
integer y = 168
integer width = 2130
integer height = 100
integer taborder = 20
string title = "none"
string dataobject = "dw_prop_selecciona_carrera"
boolean border = false
boolean livescroll = true
end type

type st_1 from statictext within w_propedeutico_rep_estimacion
integer x = 1330
integer y = 88
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

type rb_detalle from radiobutton within w_propedeutico_rep_estimacion
boolean visible = false
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

type rb_totales from radiobutton within w_propedeutico_rep_estimacion
boolean visible = false
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

type st_2 from statictext within w_propedeutico_rep_estimacion
boolean visible = false
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

type st_3 from statictext within w_propedeutico_rep_estimacion
boolean visible = false
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

type em_folio_fin from editmask within w_propedeutico_rep_estimacion
boolean visible = false
integer x = 4110
integer y = 172
integer width = 402
integer height = 80
integer taborder = 20
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

type em_folio_inc from editmask within w_propedeutico_rep_estimacion
boolean visible = false
integer x = 4110
integer y = 80
integer width = 402
integer height = 80
integer taborder = 10
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

type dw_reporte from datawindow within w_propedeutico_rep_estimacion
integer x = 73
integer y = 272
integer width = 5847
integer height = 1948
integer taborder = 10
string title = "none"
string dataobject = "dw_propedeuticos_estimacion_rep"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_propedeutico_rep_estimacion
boolean visible = false
integer x = 3511
integer width = 398
integer height = 276
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within w_propedeutico_rep_estimacion
boolean visible = false
integer x = 3941
integer y = 4
integer width = 608
integer height = 272
integer taborder = 50
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

