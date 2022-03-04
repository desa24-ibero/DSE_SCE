$PBExportHeader$w_carga_archivos_xcoba_2017.srw
forward
global type w_carga_archivos_xcoba_2017 from window
end type
type cb_guardar from commandbutton within w_carga_archivos_xcoba_2017
end type
type cb_salir from commandbutton within w_carga_archivos_xcoba_2017
end type
type sle_archivo from singlelineedit within w_carga_archivos_xcoba_2017
end type
type cb_selecciona_archivo from commandbutton within w_carga_archivos_xcoba_2017
end type
type dw_resultados from datawindow within w_carga_archivos_xcoba_2017
end type
end forward

global type w_carga_archivos_xcoba_2017 from window
integer width = 4777
integer height = 2236
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
cb_guardar cb_guardar
cb_salir cb_salir
sle_archivo sle_archivo
cb_selecciona_archivo cb_selecciona_archivo
dw_resultados dw_resultados
end type
global w_carga_archivos_xcoba_2017 w_carga_archivos_xcoba_2017

on w_carga_archivos_xcoba_2017.create
this.cb_guardar=create cb_guardar
this.cb_salir=create cb_salir
this.sle_archivo=create sle_archivo
this.cb_selecciona_archivo=create cb_selecciona_archivo
this.dw_resultados=create dw_resultados
this.Control[]={this.cb_guardar,&
this.cb_salir,&
this.sle_archivo,&
this.cb_selecciona_archivo,&
this.dw_resultados}
end on

on w_carga_archivos_xcoba_2017.destroy
destroy(this.cb_guardar)
destroy(this.cb_salir)
destroy(this.sle_archivo)
destroy(this.cb_selecciona_archivo)
destroy(this.dw_resultados)
end on

type cb_guardar from commandbutton within w_carga_archivos_xcoba_2017
integer x = 3845
integer y = 72
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar"
end type

event clicked;INTEGER le_resultado

dw_resultados.SETTRANSOBJECT(gtr_sadm) 
le_resultado = dw_resultados.UPDATE()
IF le_resultado < 0 THEN 
	ROLLBACK USING gtr_sadm; 
	MESSAGEBOX("ERROR", "Se produjo un error al gusrdar el archivo.") 
	RETURN 0
END IF

COMMIT USING gtr_sadm; 
MESSAGEBOX("Aviso", "Se ha cargado la información del archivo.")  




end event

type cb_salir from commandbutton within w_carga_archivos_xcoba_2017
integer x = 4283
integer y = 72
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

event clicked;
CLOSE(PARENT) 
end event

type sle_archivo from singlelineedit within w_carga_archivos_xcoba_2017
integer x = 530
integer y = 76
integer width = 2254
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_selecciona_archivo from commandbutton within w_carga_archivos_xcoba_2017
integer x = 105
integer y = 72
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Archivo..."
end type

event clicked;
STRING pathname 
INTEGER value
STRING filename 


//value = GetFileOpenName("Seleccione el Archivo", &
//		+ pathname, filename, "TXT", &
//		+ "Text Files (*.TXT),*.TXT")

value = GetFileOpenName("Seleccione el Archivo", &
		+ pathname, filename, "CSV", &
		+ "CSV Files (*.CSV),*.CSV")

	
dw_resultados.ImportFile(pathname)
sle_archivo.TEXT = pathname 




end event

type dw_resultados from datawindow within w_carga_archivos_xcoba_2017
integer x = 91
integer y = 288
integer width = 4567
integer height = 1700
integer taborder = 10
string title = "none"
string dataobject = "dw_carga_resultados_excoba_2017"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

