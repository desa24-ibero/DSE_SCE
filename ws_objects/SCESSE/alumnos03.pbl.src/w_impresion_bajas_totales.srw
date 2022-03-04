$PBExportHeader$w_impresion_bajas_totales.srw
forward
global type w_impresion_bajas_totales from window
end type
type sle_nombre from singlelineedit within w_impresion_bajas_totales
end type
type cb_salir from commandbutton within w_impresion_bajas_totales
end type
type cb_imprimir from commandbutton within w_impresion_bajas_totales
end type
type cb_generar from commandbutton within w_impresion_bajas_totales
end type
type em_cuenta from editmask within w_impresion_bajas_totales
end type
type st_1 from statictext within w_impresion_bajas_totales
end type
type dw_reporte from datawindow within w_impresion_bajas_totales
end type
end forward

global type w_impresion_bajas_totales from window
integer width = 4754
integer height = 3196
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
sle_nombre sle_nombre
cb_salir cb_salir
cb_imprimir cb_imprimir
cb_generar cb_generar
em_cuenta em_cuenta
st_1 st_1
dw_reporte dw_reporte
end type
global w_impresion_bajas_totales w_impresion_bajas_totales

type variables
n_tr itr_sce
end variables

on w_impresion_bajas_totales.create
this.sle_nombre=create sle_nombre
this.cb_salir=create cb_salir
this.cb_imprimir=create cb_imprimir
this.cb_generar=create cb_generar
this.em_cuenta=create em_cuenta
this.st_1=create st_1
this.dw_reporte=create dw_reporte
this.Control[]={this.sle_nombre,&
this.cb_salir,&
this.cb_imprimir,&
this.cb_generar,&
this.em_cuenta,&
this.st_1,&
this.dw_reporte}
end on

on w_impresion_bajas_totales.destroy
destroy(this.sle_nombre)
destroy(this.cb_salir)
destroy(this.cb_imprimir)
destroy(this.cb_generar)
destroy(this.em_cuenta)
destroy(this.st_1)
destroy(this.dw_reporte)
end on

event open;// Se hace la conexión a SQLSERVER 

//f_conecta_con_parametros_bd(gtr_sce, itr_sce, 11)


f_conecta_pas_parametros_bd(gtr_sce, itr_sce, 11, gs_usuario,gs_password) 





end event

event close;DISCONNECT USING itr_sce; 


end event

type sle_nombre from singlelineedit within w_impresion_bajas_totales
integer x = 1033
integer y = 72
integer width = 1760
integer height = 104
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_salir from commandbutton within w_impresion_bajas_totales
integer x = 3840
integer y = 60
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;CLOSE(PARENT) 
end event

type cb_imprimir from commandbutton within w_impresion_bajas_totales
integer x = 3374
integer y = 60
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprimir"
end type

event clicked;PrintSetup ( )
dw_reporte.Print ( )
end event

type cb_generar from commandbutton within w_impresion_bajas_totales
integer x = 2880
integer y = 60
integer width = 471
integer height = 112
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Genera Reporte"
end type

event clicked;
LONG ll_cuenta 

ll_cuenta = LONG(em_cuenta.TEXT) 

dw_reporte.SETTRANSOBJECT(itr_sce)
dw_reporte.RETRIEVE(ll_cuenta) 







end event

type em_cuenta from editmask within w_impresion_bajas_totales
integer x = 485
integer y = 72
integer width = 530
integer height = 104
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "############"
end type

event modified;
LONG ll_cuenta 
STRING ls_nombre

ll_cuenta = LONG(THIS.TEXT) 

SELECT nombre_completo 
INTO :ls_nombre 
FROM alumnos WHERE cuenta = :ll_cuenta  
USING itr_sce; 
IF itr_sce.SQLCODE < 0 THEN  
	MESSAGEBOX("Error", "Se produjo un error al buscar el nombre del alumno: " + itr_sce.SQLERRTEXT) 
	RETURN -1 
END IF 	

sle_nombre.TEXT = ls_nombre 



end event

type st_1 from statictext within w_impresion_bajas_totales
integer x = 96
integer y = 84
integer width = 338
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "No. Cuenta: "
boolean focusrectangle = false
end type

type dw_reporte from datawindow within w_impresion_bajas_totales
integer x = 55
integer y = 224
integer width = 4219
integer height = 2796
integer taborder = 10
string title = "Impresion de Solicitud de Baja"
string dataobject = "dw_imprime_reporte_bajas_totales"
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

