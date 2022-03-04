$PBExportHeader$w_ruta_archivos_salida.srw
forward
global type w_ruta_archivos_salida from window
end type
type pb_1 from picturebutton within w_ruta_archivos_salida
end type
type cb_1 from commandbutton within w_ruta_archivos_salida
end type
type sle_ruta from singlelineedit within w_ruta_archivos_salida
end type
type gb_1 from groupbox within w_ruta_archivos_salida
end type
end forward

global type w_ruta_archivos_salida from window
integer width = 3227
integer height = 476
boolean titlebar = true
string title = "Ruta de Archivos de Salida"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
pb_1 pb_1
cb_1 cb_1
sle_ruta sle_ruta
gb_1 gb_1
end type
global w_ruta_archivos_salida w_ruta_archivos_salida

type variables
STRING is_id_doc 
STRING is_ruta

end variables

on w_ruta_archivos_salida.create
this.pb_1=create pb_1
this.cb_1=create cb_1
this.sle_ruta=create sle_ruta
this.gb_1=create gb_1
this.Control[]={this.pb_1,&
this.cb_1,&
this.sle_ruta,&
this.gb_1}
end on

on w_ruta_archivos_salida.destroy
destroy(this.pb_1)
destroy(this.cb_1)
destroy(this.sle_ruta)
destroy(this.gb_1)
end on

event open;STRING ls_ruta 

is_id_doc = MESSAGE.STRINGPARM 

SELECT ruta 
INTO :ls_ruta  
FROM e_titulo 
WHERE id_doc = :is_id_doc  
USING gtr_sce; 

IF ISNULL(ls_ruta) THEN  ls_ruta = "" 

sle_ruta.TEXT = ls_ruta
is_ruta = ls_ruta 




end event

type pb_1 from picturebutton within w_ruta_archivos_salida
integer x = 2990
integer y = 96
integer width = 110
integer height = 96
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean default = true
string picturename = "Open!"
alignment htextalign = left!
end type

event clicked;
STRING ls_path = "C:\"
INTEGER li_result
li_result = GetFolder( "Archivos XML para D2L", ls_path)
IF li_result <= 0 THEN RETURN  
sle_ruta.text = ls_path + "\" 

	
end event

type cb_1 from commandbutton within w_ruta_archivos_salida
integer x = 2706
integer y = 208
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

event clicked;STRING ls_ruta 

IF ISNULL(ls_ruta) THEN  ls_ruta = "" 

ls_ruta = sle_ruta.TEXT 
IF ISNULL(ls_ruta) THEN ls_ruta = "" 

IF TRIM(ls_ruta) = "" THEN 
	MESSAGEBOX("Error", "No se ha especificado la ruta de los archivos de salida. ")
	RETURN 
END IF  


IF TRIM(is_ruta) <> "VARIABLE" THEN 
	UPDATE e_titulo  
	SET ruta = :ls_ruta  
	WHERE id_doc = :is_id_doc
	USING gtr_sce; 
	IF gtr_sce.SQLCODE < 0 THEN 
		MESSAGEBOX("Error", "Se produjo un error al actualizar la ruta de archivos de salida: " + gtr_sce.SQLERRTEXT) 
		RETURN -1 
	END IF 
	COMMIT USING gtr_sce; 
END IF 	

CLOSEWITHRETURN (PARENT, ls_ruta)  




end event

type sle_ruta from singlelineedit within w_ruta_archivos_salida
integer x = 82
integer y = 100
integer width = 2875
integer height = 88
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_ruta_archivos_salida
integer x = 27
integer y = 32
integer width = 3136
integer height = 316
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ruta de Archivos de Salida:"
end type

