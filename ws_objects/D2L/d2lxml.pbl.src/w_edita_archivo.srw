$PBExportHeader$w_edita_archivo.srw
forward
global type w_edita_archivo from window
end type
type st_1 from statictext within w_edita_archivo
end type
type em_hora from editmask within w_edita_archivo
end type
type cb_guardar from commandbutton within w_edita_archivo
end type
type cb_salir from commandbutton within w_edita_archivo
end type
type dw_archivo from datawindow within w_edita_archivo
end type
end forward

global type w_edita_archivo from window
integer width = 4133
integer height = 1308
boolean titlebar = true
string title = "Configuración de Archivos"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_1 st_1
em_hora em_hora
cb_guardar cb_guardar
cb_salir cb_salir
dw_archivo dw_archivo
end type
global w_edita_archivo w_edita_archivo

type variables

STRING is_hora
end variables

on w_edita_archivo.create
this.st_1=create st_1
this.em_hora=create em_hora
this.cb_guardar=create cb_guardar
this.cb_salir=create cb_salir
this.dw_archivo=create dw_archivo
this.Control[]={this.st_1,&
this.em_hora,&
this.cb_guardar,&
this.cb_salir,&
this.dw_archivo}
end on

on w_edita_archivo.destroy
destroy(this.st_1)
destroy(this.em_hora)
destroy(this.cb_guardar)
destroy(this.cb_salir)
destroy(this.dw_archivo)
end on

event open;
guo_conexion.conecta_bd( )
dw_archivo.SETTRANSOBJECT(SQLCA) 
dw_archivo.RETRIEVE() 

em_hora.TRIGGEREVENT("carga_hora") 






end event

event closequery;guo_conexion.desconecta_bd( )
end event

type st_1 from statictext within w_edita_archivo
integer x = 960
integer y = 1084
integer width = 1047
integer height = 64
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 67108864
string text = "Hora de ejecución: "
alignment alignment = right!
boolean focusrectangle = false
end type

type em_hora from editmask within w_edita_archivo
event carga_hora ( )
integer x = 2021
integer y = 1076
integer width = 402
integer height = 100
integer taborder = 20
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = timemask!
string mask = "hh:mm"
boolean spin = true
end type

event carga_hora();STRING ls_hora 

SELECT hora 
INTO :ls_hora  
FROM archivo_hora  
USING SQLCA;
IF SQLCA.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error. No se han guardado los cambios") 
	ROLLBACK USING SQLCA;
END IF  

em_hora.text = ls_hora 


end event

type cb_guardar from commandbutton within w_edita_archivo
integer x = 2683
integer y = 1072
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Guardar"
end type

event clicked;STRING ls_hora 

dw_archivo.ACCEPTTEXT() 

ls_hora = em_hora.TEXT 

DELETE FROM archivo_hora 
USING SQLCA;
IF SQLCA.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error. No se ha guardado la hora.") 
	ROLLBACK USING SQLCA;
END IF 

INSERT INTO archivo_hora(hora) 
VALUES (:ls_hora)
USING SQLCA;
IF SQLCA.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error. No se ha guardado la hora.") 
	ROLLBACK USING SQLCA;
END IF 

is_hora = ls_hora

IF dw_archivo.UPDATE() < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error. No se han guardado los cambios") 
	ROLLBACK USING SQLCA;
ELSE
	MESSAGEBOX("Aviso", "Los cambios fueron guardados con éxito.")  
	COMMIT USING SQLCA;
END IF 

dw_archivo.RETRIEVE() 

em_hora.TRIGGEREVENT("carga_hora") 


 
end event

type cb_salir from commandbutton within w_edita_archivo
integer x = 3131
integer y = 1068
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Salir"
end type

event clicked;
CLOSEWITHRETURN(PARENT, is_hora) 

end event

type dw_archivo from datawindow within w_edita_archivo
integer x = 91
integer y = 60
integer width = 3945
integer height = 980
integer taborder = 10
string title = "none"
string dataobject = "dw_archivo_edit"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;
IF dwo.name = "b_ruta" THEN 
	
	STRING ls_path = "C:\"
	INTEGER li_result
	li_result = GetFolder( "Archivos XML para D2L", ls_path)
	IF li_result <= 0 THEN RETURN  
	THIS.SETITEM(row, "ruta", ls_path + "\") 
	THIS.ACCEPTTEXT()	
	
END IF


end event

