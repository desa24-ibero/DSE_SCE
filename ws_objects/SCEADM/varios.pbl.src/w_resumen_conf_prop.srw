$PBExportHeader$w_resumen_conf_prop.srw
forward
global type w_resumen_conf_prop from window
end type
type cb_1 from commandbutton within w_resumen_conf_prop
end type
type cb_guardar from commandbutton within w_resumen_conf_prop
end type
type cb_imprimir from commandbutton within w_resumen_conf_prop
end type
type dw_peso_resumen from datawindow within w_resumen_conf_prop
end type
end forward

global type w_resumen_conf_prop from window
integer width = 3026
integer height = 1956
boolean titlebar = true
string title = "Reporte Global Configuración de Cursos Propedéuticos"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
cb_guardar cb_guardar
cb_imprimir cb_imprimir
dw_peso_resumen dw_peso_resumen
end type
global w_resumen_conf_prop w_resumen_conf_prop

on w_resumen_conf_prop.create
this.cb_1=create cb_1
this.cb_guardar=create cb_guardar
this.cb_imprimir=create cb_imprimir
this.dw_peso_resumen=create dw_peso_resumen
this.Control[]={this.cb_1,&
this.cb_guardar,&
this.cb_imprimir,&
this.dw_peso_resumen}
end on

on w_resumen_conf_prop.destroy
destroy(this.cb_1)
destroy(this.cb_guardar)
destroy(this.cb_imprimir)
destroy(this.dw_peso_resumen)
end on

event open;

dw_peso_resumen.SETTRANSOBJECT(gtr_sadm) 
dw_peso_resumen.RETRIEVE() 






//STRING ls_sql 

//
//ls_sql = " SELECT area_evaluacion.id_area AS id_area, " + & 
//						" area_evaluacion.descripcion descripcion " + &  
//			" FROM area_evaluacion " + &  
//			" WHERE EXISTS(SELECT * FROM prop_carrera_peso " + &  
//							" WHERE prop_carrera_peso.id_area = area_evaluacion.id_area " + & 
//							" AND prop_carrera_peso.cve_carrera = " + STRING(al_carrera) + " AND prop_carrera_peso.id_prop = ~~'" + as_prop + "~~' ) " + & 
//			" AND NOT EXISTS(SELECT * FROM area_eval_carrera_relacion " + &  
//							" WHERE area_eval_carrera_relacion.id_area = area_evaluacion.id_area " + &  
//							" AND area_eval_carrera_relacion.cve_carrera = " + STRING(al_carrera) + ") " + &  
//			" UNION " + &  
//			" SELECT area_evaluacion.id_area AS id_area, " + &     
//						" area_evaluacion_carrera.descripcion AS descripcion " + &    
//			" FROM area_evaluacion, area_evaluacion_carrera, area_eval_carrera_relacion " + &  
//			" WHERE NOT EXISTS(SELECT * FROM prop_carrera_peso " + &  
//							" WHERE prop_carrera_peso.id_area = area_evaluacion_carrera.id_area " + & 
//							" AND prop_carrera_peso.cve_carrera = " + STRING(al_carrera) + " AND prop_carrera_peso.id_prop = ~~'" + as_prop + "~~' ) " + & 
//			" AND area_eval_carrera_relacion.id_area_carrera = area_evaluacion_carrera.id_area " + &  
//			" AND area_eval_carrera_relacion.cve_carrera = " + STRING(al_carrera) + " " + &      
//			" AND area_evaluacion.id_area = area_eval_carrera_relacion.id_area " 
//
//
//END IF
//
//// Se recuperan las áreas de evaluación relacionadas a la carrera. 
//dw_prop_carrera_peso.GETCHILD("id_area", ldw_areas) 
//ldw_areas.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'")
//ldw_areas.SETTRANSOBJECT(gtr_sadm)
//ldw_areas.RETRIEVE(al_carrera)
//
//




end event

type cb_1 from commandbutton within w_resumen_conf_prop
integer x = 2501
integer y = 484
integer width = 402
integer height = 112
integer taborder = 40
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

type cb_guardar from commandbutton within w_resumen_conf_prop
integer x = 2501
integer y = 208
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salvar"
end type

event clicked;if dw_peso_resumen.SaveAs("",Excel!, TRUE)<>1 then
	dw_peso_resumen.SaveAs("",Clipboard!, TRUE)
	messagebox("No se pudo guardar el archivo","La información se encuentra en el Clipboard")	
end if

end event

type cb_imprimir from commandbutton within w_resumen_conf_prop
integer x = 2501
integer y = 76
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

event clicked;dw_peso_resumen.modify("Datawindow.print.preview = Yes")
dw_peso_resumen.modify("Datawindow.print.Orientation = 1")
SetPointer(HourGlass!)
openwithparm(conf_impr,dw_peso_resumen)
end event

type dw_peso_resumen from datawindow within w_resumen_conf_prop
integer x = 82
integer y = 68
integer width = 2318
integer height = 1724
integer taborder = 10
string title = "none"
string dataobject = "dw_peso_prop_resumen"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

