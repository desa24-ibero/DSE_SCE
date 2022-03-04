$PBExportHeader$w_reporte_cambios_salon.srw
forward
global type w_reporte_cambios_salon from window
end type
type dw_1 from datawindow within w_reporte_cambios_salon
end type
type uo_1 from uo_per_ani within w_reporte_cambios_salon
end type
end forward

global type w_reporte_cambios_salon from window
integer width = 2533
integer height = 1408
boolean titlebar = true
string title = "Reporte de Cambios de Salón"
string menuname = "m_menugeneral"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
dw_1 dw_1
uo_1 uo_1
end type
global w_reporte_cambios_salon w_reporte_cambios_salon

on w_reporte_cambios_salon.create
if this.MenuName = "m_menugeneral" then this.MenuID = create m_menugeneral
this.dw_1=create dw_1
this.uo_1=create uo_1
this.Control[]={this.dw_1,&
this.uo_1}
end on

on w_reporte_cambios_salon.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.uo_1)
end on

type dw_1 from datawindow within w_reporte_cambios_salon
event carga ( )
integer x = 69
integer y = 248
integer width = 2382
integer height = 932
integer taborder = 40
string title = "none"
string dataobject = "d_reporte_cambios_salon"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event carga();if (retrieve(gi_anio, gi_periodo)=0) then
	MessageBox("Atencion", "NO hay cambios de salones en el periodo seleccionado.", StopSign!)
end if
end event

event constructor;m_menugeneral.dw = this
modify("Datawindow.print.preview = Yes")
SetTransObject(gtr_sce)
end event

type uo_1 from uo_per_ani within w_reporte_cambios_salon
integer x = 69
integer y = 32
integer width = 1248
integer height = 164
integer taborder = 20
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

