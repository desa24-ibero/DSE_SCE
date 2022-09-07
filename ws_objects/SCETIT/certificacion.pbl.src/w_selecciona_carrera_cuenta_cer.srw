﻿$PBExportHeader$w_selecciona_carrera_cuenta_cer.srw
forward
global type w_selecciona_carrera_cuenta_cer from window
end type
type st_1 from statictext within w_selecciona_carrera_cuenta_cer
end type
type dw_lista_carreras from datawindow within w_selecciona_carrera_cuenta_cer
end type
end forward

global type w_selecciona_carrera_cuenta_cer from window
integer width = 3319
integer height = 964
boolean titlebar = true
string title = "Carreras Cursadas"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_1 st_1
dw_lista_carreras dw_lista_carreras
end type
global w_selecciona_carrera_cuenta_cer w_selecciona_carrera_cuenta_cer

on w_selecciona_carrera_cuenta_cer.create
this.st_1=create st_1
this.dw_lista_carreras=create dw_lista_carreras
this.Control[]={this.st_1,&
this.dw_lista_carreras}
end on

on w_selecciona_carrera_cuenta_cer.destroy
destroy(this.st_1)
destroy(this.dw_lista_carreras)
end on

event open;LONG ll_cuenta 

ll_cuenta = MESSAGE.DOUBLEPARM 

dw_lista_carreras.SETTRANSOBJECT(gtr_sce) 
dw_lista_carreras.RETRIEVE(ll_cuenta) 






end event

type st_1 from statictext within w_selecciona_carrera_cuenta_cer
integer x = 78
integer y = 40
integer width = 1865
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "*Haga Doble Click sobre la carrera que desea seleccionar"
boolean focusrectangle = false
end type

type dw_lista_carreras from datawindow within w_selecciona_carrera_cuenta_cer
event selecciona_carrera ( )
integer x = 69
integer y = 128
integer width = 3177
integer height = 712
integer taborder = 10
string title = "Carreras Cursadas "
string dataobject = "dw_lista_carreras_cert_ant"
boolean minbox = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event selecciona_carrera();LONG ll_carrera 
LONG ll_plan 
STRING ls_carrera
INTEGER le_row
INTEGER le_subsistema
STRING ls_nivel 

le_row = THIS.GETROW() 

ll_carrera = THIS.GETITEMNUMBER(le_row, "carreras_cve_carrera")
IF ISNULL(ll_carrera) THEN ll_carrera = 0
ll_plan = THIS.GETITEMNUMBER(le_row, "cve_plan")
IF ISNULL(ll_plan) THEn ll_plan = 0 
ls_carrera = THIS.GETITEMSTRING(le_row, "carrera")  
IF ISNULL(ls_carrera) THEN ls_carrera = "" 

ls_nivel = THIS.GETITEMSTRING(le_row, "nivel")   
IF ISNULL(ls_nivel) THEN ls_nivel = "" 



le_subsistema = THIS.GETITEMNUMBER(le_row, "subsistema")
IF ISNULL(le_subsistema) THEn le_subsistema = 0 

uo_parametros_cer_ant luo_parametros_cer_ant 
luo_parametros_cer_ant = CREATE uo_parametros_cer_ant 

luo_parametros_cer_ant.il_cve_carrera = ll_carrera  
luo_parametros_cer_ant.il_cve_plan = ll_plan  
luo_parametros_cer_ant.is_carrera = ls_carrera 

luo_parametros_cer_ant.is_nivel = ls_nivel 

luo_parametros_cer_ant.ie_subsistema = le_subsistema

CLOSEWITHRETURN(w_selecciona_carrera_cuenta_cer,luo_parametros_cer_ant)
end event

event itemfocuschanged;THIS.SELECTROW(0, FALSE)
THIS.SELECTROW(row, TRUE) 



end event

event doubleclicked;THIS.SETROW(row) 
THIS.TRIGGEREVENT("selecciona_carrera") 



end event

event retrieveend;IF rowcount = 1 THEN THIS.TRIGGEREVENT("selecciona_carrera") 
end event

