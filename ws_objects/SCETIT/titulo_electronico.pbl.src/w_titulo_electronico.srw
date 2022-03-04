$PBExportHeader$w_titulo_electronico.srw
forward
global type w_titulo_electronico from window
end type
type uo_nombre from uo_nombre_alumno_2013 within w_titulo_electronico
end type
type cb_2 from commandbutton within w_titulo_electronico
end type
type cb_aceptar from commandbutton within w_titulo_electronico
end type
type dw_carreras from datawindow within w_titulo_electronico
end type
end forward

global type w_titulo_electronico from window
integer width = 3447
integer height = 1504
boolean titlebar = true
string title = "Alumnos"
windowtype windowtype = response!
string icon = "AppIcon!"
boolean center = true
uo_nombre uo_nombre
cb_2 cb_2
cb_aceptar cb_aceptar
dw_carreras dw_carreras
end type
global w_titulo_electronico w_titulo_electronico

type variables
LONG il_cuenta

STRING is_documento
end variables

on w_titulo_electronico.create
this.uo_nombre=create uo_nombre
this.cb_2=create cb_2
this.cb_aceptar=create cb_aceptar
this.dw_carreras=create dw_carreras
this.Control[]={this.uo_nombre,&
this.cb_2,&
this.cb_aceptar,&
this.dw_carreras}
end on

on w_titulo_electronico.destroy
destroy(this.uo_nombre)
destroy(this.cb_2)
destroy(this.cb_aceptar)
destroy(this.dw_carreras)
end on

event doubleclicked;il_cuenta = long(uo_nombre.of_obten_cuenta())

IF is_documento = "TIT" THEN
	dw_carreras.DATAOBJECT = "dw_carreras_cursadas_e_tit"
ELSEIF is_documento = "CER"  THEN 
	dw_carreras.DATAOBJECT = "dw_carreras_cursadas_e_cer" 
END IF 	


	
dw_carreras.SETTRANSOBJECT(gtr_sce) 
dw_carreras.RETRIEVE(il_cuenta)  

//MESSAGEBOX("", STRING(il_cuenta)) 
end event

event open;
uo_parametros luo_parametros  
luo_parametros = CREATE uo_parametros

luo_parametros = MESSAGE.powerobjectparm 
is_documento = luo_parametros.is_documento



end event

type uo_nombre from uo_nombre_alumno_2013 within w_titulo_electronico
integer x = 119
integer y = 60
integer taborder = 10
long backcolor = 1073741824
end type

on uo_nombre.destroy
call uo_nombre_alumno_2013::destroy
end on

type cb_2 from commandbutton within w_titulo_electronico
integer x = 2949
integer y = 1256
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Salir"
end type

event clicked;CLOSE(PARENT)
end event

type cb_aceptar from commandbutton within w_titulo_electronico
integer x = 2487
integer y = 1260
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Aceptar"
end type

event clicked;
LONG ll_cuenta 
LONG ll_cve_carrera
LONG ll_cve_plan 
INTEGER le_row 


ll_cuenta = il_cuenta

IF ll_cuenta = 0 THEN 
	MESSAGEBOX("Aviso", "No se ha seleccionado un número de cuenta válido. ")
	RETURN -1 
END IF 

le_row = dw_carreras.GETSELECTEDROW(0)  
IF le_row <= 0 THEN 
	MESSAGEBOX("Error", "No se ha seleccionado una carrera para generar documento.")
	RETURN -1 
END IF 

IF is_documento = 'TIT' THEN 
	ll_cve_carrera = dw_carreras.GETITEMNUMBER(le_row, "carreras_cve_carrera")   
	ll_cve_plan  = dw_carreras.GETITEMNUMBER(le_row, "titulacion_cve_plan")
END IF 
IF is_documento = 'CER' THEN 
	ll_cve_carrera = dw_carreras.GETITEMNUMBER(le_row, "carreras_cve_carrera")   
	ll_cve_plan  = dw_carreras.GETITEMNUMBER(le_row, "certificado_cve_plan")  
END IF 	

uo_parametros luo_parametros 
luo_parametros = CREATE uo_parametros

luo_parametros.il_cuenta = ll_cuenta  
luo_parametros.il_cve_carrera = ll_cve_carrera  
luo_parametros.il_plan = ll_cve_plan  

CLOSEWITHRETURN(PARENT, luo_parametros) 


RETURN 0  




end event

type dw_carreras from datawindow within w_titulo_electronico
integer x = 142
integer y = 448
integer width = 3191
integer height = 748
integer taborder = 20
string title = "none"
string dataobject = "dw_carreras_cursadas_e_tit"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;THIS.SELECTROW(0, FALSE) 
THIS.SELECTROW(currentrow, TRUE)  
end event

