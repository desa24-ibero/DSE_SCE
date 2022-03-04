$PBExportHeader$w_valida_fecha_bloqueo.srw
forward
global type w_valida_fecha_bloqueo from window
end type
type mle_mensaje from multilineedit within w_valida_fecha_bloqueo
end type
type cb_salir from commandbutton within w_valida_fecha_bloqueo
end type
end forward

global type w_valida_fecha_bloqueo from window
integer width = 2807
integer height = 1100
boolean titlebar = true
string title = "Notificación de Fecha de Cambio en Uso de la Aplicación"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
mle_mensaje mle_mensaje
cb_salir cb_salir
end type
global w_valida_fecha_bloqueo w_valida_fecha_bloqueo

type variables
DATETIME idt_fecha, idt_fecha_actual
STRING is_texto
end variables

event open;
SELECT fecha_bloqueo, texto_bloqueo, getdate()
INTO :idt_fecha, :is_texto, :idt_fecha_actual 
FROM bloqueo_aplicacion 
WHERE id_bloqueo = 1 
; 
//IF gtr_sce.SQLCODE < 0 THEN 
//	MESSAGEBOX("ERROR", "Se produjo un error al consultar la fecha de bloqueo: " + gtr_sce.SQLERRTEXT) 
//	RETURN 	
//END IF


mle_mensaje.TEXT = is_texto

IF DATE(idt_fecha_actual) <= DATE(idt_fecha) THEN 
	cb_salir.TEXT = "Continuar"
ELSE
	cb_salir.TEXT = "Salir"
END IF





end event

on w_valida_fecha_bloqueo.create
this.mle_mensaje=create mle_mensaje
this.cb_salir=create cb_salir
this.Control[]={this.mle_mensaje,&
this.cb_salir}
end on

on w_valida_fecha_bloqueo.destroy
destroy(this.mle_mensaje)
destroy(this.cb_salir)
end on

type mle_mensaje from multilineedit within w_valida_fecha_bloqueo
integer x = 64
integer y = 56
integer width = 2629
integer height = 716
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_salir from commandbutton within w_valida_fecha_bloqueo
integer x = 2267
integer y = 836
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;
IF DATE(idt_fecha_actual) <= DATE(idt_fecha) THEN 
	CLOSE(PARENT)
ELSE
	HALT
END IF
end event

