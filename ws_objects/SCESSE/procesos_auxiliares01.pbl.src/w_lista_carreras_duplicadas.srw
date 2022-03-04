$PBExportHeader$w_lista_carreras_duplicadas.srw
forward
global type w_lista_carreras_duplicadas from window
end type
type dw_1 from datawindow within w_lista_carreras_duplicadas
end type
end forward

global type w_lista_carreras_duplicadas from window
integer width = 4754
integer height = 1980
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
end type
global w_lista_carreras_duplicadas w_lista_carreras_duplicadas

on w_lista_carreras_duplicadas.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_lista_carreras_duplicadas.destroy
destroy(this.dw_1)
end on

event open;//SELECT hist_carreras.cuenta, cve_carrera_ant, cve_plan_ant, can.carrera, cve_carrera_act, cve_plan_act, cac.carrera, alumnos.nombre_completo   
//FROM hist_carreras, carreras can, carreras cac, alumnos  
//WHERE hist_carreras.cuenta in(
//SELECT cuenta
//FROM hist_carreras 
//GROUP BY cuenta, cve_carrera_act, cve_plan_act 
//HAVING COUNT(*) > 1
//) 
//AND hist_carreras.cve_carrera_ant = can.cve_carrera 
//AND hist_carreras.cve_carrera_act = cac.cve_carrera 
//AND alumnos.cuenta = hist_carreras.cuenta 
// 
end event

type dw_1 from datawindow within w_lista_carreras_duplicadas
integer x = 101
integer y = 148
integer width = 4256
integer height = 1612
integer taborder = 10
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

