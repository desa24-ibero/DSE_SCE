$PBExportHeader$w_aula_audiovisual_ocupada.srw
forward
global type w_aula_audiovisual_ocupada from window
end type
type cb_aceptar from commandbutton within w_aula_audiovisual_ocupada
end type
type dw_aulas from datawindow within w_aula_audiovisual_ocupada
end type
end forward

global type w_aula_audiovisual_ocupada from window
integer width = 4667
integer height = 1216
boolean titlebar = true
string title = "Aulas ocupadas"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_aceptar cb_aceptar
dw_aulas dw_aulas
end type
global w_aula_audiovisual_ocupada w_aula_audiovisual_ocupada

on w_aula_audiovisual_ocupada.create
this.cb_aceptar=create cb_aceptar
this.dw_aulas=create dw_aulas
this.Control[]={this.cb_aceptar,&
this.dw_aulas}
end on

on w_aula_audiovisual_ocupada.destroy
destroy(this.cb_aceptar)
destroy(this.dw_aulas)
end on

event open;STRING ls_query 
DATASTORE lds_paso

lds_paso = MESSAGE.POWEROBJECTPARM  
dw_aulas.DATAOBJECT = lds_paso.DATAOBJECT 
lds_paso.ROWSCOPY(1, lds_paso.ROWCOUNT(), PRIMARY!, dw_aulas, 1, PRIMARY!)
	




//STRING ls_mensaje
//TRANSACTION itr_sumuia 
//// Se hace la conexión a sumuia_bd 
//if f_conecta_pas_parametros_bd(gtr_sce, itr_sumuia, 26, gs_usuario, gs_password)=0 then  
//	ls_mensaje = "Atención: "+ "Problemas al conectarse a la base de datos de WEB.controlescolar_bd"
//	MessageBox("Error", ls_mensaje, StopSign!)
//	return -1
//end if
//itr_sumuia.AUTOCOMMIT = TRUE
//
//
//
//dw_aulas.SETTRANSOBJECT(itr_sumuia)
//dw_aulas.RETRIEVE(1001, 'A')
end event

type cb_aceptar from commandbutton within w_aula_audiovisual_ocupada
integer x = 4178
integer y = 940
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
end type

event clicked;CLOSE(PARENT)
end event

type dw_aulas from datawindow within w_aula_audiovisual_ocupada
integer x = 91
integer y = 56
integer width = 4480
integer height = 824
integer taborder = 10
string title = "none"
string dataobject = "dw_multiplantel_sala_ocupada"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

