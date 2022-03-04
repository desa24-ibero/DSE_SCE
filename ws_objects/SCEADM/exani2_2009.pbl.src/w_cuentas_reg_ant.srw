$PBExportHeader$w_cuentas_reg_ant.srw
forward
global type w_cuentas_reg_ant from window
end type
type dw_datos from datawindow within w_cuentas_reg_ant
end type
end forward

global type w_cuentas_reg_ant from window
integer width = 1851
integer height = 768
boolean titlebar = true
string title = "Cuentas Registradas Previamente"
boolean controlmenu = true
windowtype windowtype = popup!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_datos dw_datos
end type
global w_cuentas_reg_ant w_cuentas_reg_ant

on w_cuentas_reg_ant.create
this.dw_datos=create dw_datos
this.Control[]={this.dw_datos}
end on

on w_cuentas_reg_ant.destroy
destroy(this.dw_datos)
end on

event open;Long ll_cuenta

ll_cuenta = Message.doubleparm

dw_datos.setTransobject(gtr_sadm)
dw_datos.retrieve(ll_cuenta)
end event

type dw_datos from datawindow within w_cuentas_reg_ant
integer x = 50
integer y = 36
integer width = 1723
integer height = 596
integer taborder = 10
string title = "none"
string dataobject = "d_cuentas_reg_ant"
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;String ls_sort_ant, ls_columna, ls_tipo_sort

IF Right(dwo.Name,2) = "_t"  THEN
	ls_columna = LEFT(dwo.Name, LEN(String(dwo.Name)) - 2)
	ls_sort_ant = This.Describe("Datawindow.Table.sort") 
	
	IF ls_columna = LEFT(ls_sort_ant, LEN(ls_sort_ant) - 2) THEN
		ls_tipo_sort = RIGHT(ls_sort_ant, 1)
		
		IF ls_tipo_sort = 'A' THEN 
			ls_tipo_sort = 'D' 
		ELSE 
			ls_tipo_sort = 'A' 
		END IF 
		
		This.SetSort(ls_columna + " " + ls_tipo_sort) 
	ELSE
		This.SetSort(ls_columna + " A") 
	END IF
	
	This.Sort() 
ELSE
	IF row > 0 THEN
		This.SelectRow (0,False)
		This.SelectRow (row,True)
	ELSE
		This.SelectRow (0,False)
	END IF
END IF


end event

