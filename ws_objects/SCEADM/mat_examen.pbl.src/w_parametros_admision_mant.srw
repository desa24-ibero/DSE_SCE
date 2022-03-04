$PBExportHeader$w_parametros_admision_mant.srw
forward
global type w_parametros_admision_mant from window
end type
type cb_salir from commandbutton within w_parametros_admision_mant
end type
type cb_actualiza from commandbutton within w_parametros_admision_mant
end type
type dw_parametros_adm from datawindow within w_parametros_admision_mant
end type
end forward

global type w_parametros_admision_mant from window
integer width = 2565
integer height = 1400
boolean titlebar = true
string title = "Parámetros de Admisión"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_salir cb_salir
cb_actualiza cb_actualiza
dw_parametros_adm dw_parametros_adm
end type
global w_parametros_admision_mant w_parametros_admision_mant

type variables
transaction itr_web
STRING is_error
end variables

on w_parametros_admision_mant.create
this.cb_salir=create cb_salir
this.cb_actualiza=create cb_actualiza
this.dw_parametros_adm=create dw_parametros_adm
this.Control[]={this.cb_salir,&
this.cb_actualiza,&
this.dw_parametros_adm}
end on

on w_parametros_admision_mant.destroy
destroy(this.cb_salir)
destroy(this.cb_actualiza)
destroy(this.dw_parametros_adm)
end on

event open;
STRING ls_mensaje

IF f_conecta_pas_parametros_bd ( gtr_sce , itr_web , 24 , gs_usuario , gs_password ) = 0 THEN
	ls_mensaje = "Atención: "+ "Problemas al conectarse a la base de datos de WEB.controlescolar_bd"
	MessageBox("Error", ls_mensaje, StopSign!)
	return -1
END IF

dw_parametros_adm.SETTRANSOBJECT(itr_web)  
dw_parametros_adm.RETRIEVE()
IF dw_parametros_adm.ROWCOUNT() = 0 THEN 
	dw_parametros_adm.INSERTROW(0) 
END IF 



end event

type cb_salir from commandbutton within w_parametros_admision_mant
integer x = 2021
integer y = 284
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

type cb_actualiza from commandbutton within w_parametros_admision_mant
integer x = 2021
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
string text = "Actualizar"
end type

event clicked;
INTEGER le_resultado

dw_parametros_adm.SETTRANSOBJECT(itr_web) 
le_resultado = dw_parametros_adm.UPDATE()  

IF le_resultado < 0 THEN 
	ROLLBACK USING itr_web; 
	MESSAGEBOX("Error", "Se produjo un error al actualizar los parámetros de admisión. " + is_error)
	RETURN -1 
END IF 	

COMMIT USING itr_web; 


MESSAGEBOX("Aviso", "Los parámetros fueron actualizados con éxito. " + is_error)

end event

type dw_parametros_adm from datawindow within w_parametros_admision_mant
integer x = 101
integer y = 64
integer width = 1819
integer height = 1152
integer taborder = 10
string title = "none"
string dataobject = "dw_mant_parametros_adm"
boolean border = false
boolean livescroll = true
end type

event error;is_error = errortext 

IF ISNULL(is_error) THEN is_error = "" 
end event

