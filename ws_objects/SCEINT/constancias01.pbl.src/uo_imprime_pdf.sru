$PBExportHeader$uo_imprime_pdf.sru
$PBExportComments$Objeto creado para generar un archivo PDF de un DataWindow. Cesar Ponce Hdz. cph. 29 sept 2021
forward
global type uo_imprime_pdf from userobject
end type
type cb_1 from commandbutton within uo_imprime_pdf
end type
type em_escala_pdf from editmask within uo_imprime_pdf
end type
type st_4 from statictext within uo_imprime_pdf
end type
end forward

global type uo_imprime_pdf from userobject
integer width = 1280
integer height = 148
long backcolor = 553648127
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_1 cb_1
em_escala_pdf em_escala_pdf
st_4 st_4
end type
global uo_imprime_pdf uo_imprime_pdf

type variables
datawindow idw_datawindow_a_imprimir
String is_archivo
String is_ruta_archivos
String is_escala
end variables

forward prototypes
public subroutine imprime_pdf (ref datawindow dw_param, string archivo_param, string ruta_param, string escala_param)
public subroutine inicializa_dw (ref datawindow dw_param, string archivo_param, string ruta_param, string escala_default_param)
end prototypes

public subroutine imprime_pdf (ref datawindow dw_param, string archivo_param, string ruta_param, string escala_param);//dw_constancia

/**** Inicia generacion del PDF ****/

string ls_resp_impresora // para respaldar impresora del DW. cph sept 2021
string li_resp_escala


ls_resp_impresora=dw_param.Object.DataWindow.printer // respalda la impresora. cph sept 2021
li_resp_escala=dw_param.Object.DataWindow.Print.Scale // respalda la escala


String ls_archivo
String ls_ruta_archivos

ls_archivo=archivo_param
ls_ruta_archivos=ruta_param


	


	
dw_param.Object.DataWindow.Print.DocumentName	 = ls_archivo

//dw_param.Object.DataWindow.Print.DocumentName	 = "Hello.pdf" // luego quitar

//dw_param.Object.DataWindow.Print.DocumentName	 ="temporalito.pdf"
dw_param.Modify("DataWindow.Print.Filename='" +ls_ruta_archivos+ ls_archivo + "'")

//dw_param.Modify("DataWindow.Print.Filename='hello.pdf'")

//dw_param.Object.DataWindow.Print.Filename='hello.pdf'

dw_param.Modify("Datawindow.Printer='Sybase DataWindow PS'") // debe ser esta impresora para que puda generar correctamente los PDF cph 24/Cot/2020
dw_param.Modify("Datawindow.Export.PDF.Method = 0") // Defalut Distill! (0), el 1 pregunta el archivo prn

dw_param.object.datawindow.export.pdf.xslfop.print='Yes'
dw_param.Object.DataWindow.Export.PDF.Distill.CustomPostScript="1" 
//dw_param.Object.DataWindow.Print.Scale=98
dw_param.Object.DataWindow.Print.Scale=escala_param//integer(em_escala_pdf.text)

Integer li_error_al_grabar

//li_error_al_grabar=dw_param.saveas(ls_archivo, PDF!, TRUE)

li_error_al_grabar=dw_param.saveas(ls_ruta_archivos+ ls_archivo, PDF!, TRUE)

// LAS SIGUIENTES 3 LINEAS IMPORTANTISIMAS. HAY QUE RESTAURAR. cph sept 2021
dw_param.Object.DataWindow.printer=ls_resp_impresora			// restaura la impresora. cph sep 2021
dw_param.Object.DataWindow.Print.DocumentName	 = "" // 	restaura el nombre del documento. cph sep 2021
dw_param.Modify("DataWindow.Print.Filename=''")  // 	restaura el nombre del archivo. cph sep 2021

dw_param.Object.DataWindow.Print.Scale=li_resp_escala // restaura la escala

if (li_error_al_grabar<>1) then
	messagebox("Aviso","Error al guardar el archivo pdf en la ruta:"+ls_ruta_archivos+ls_archivo)
	return
end if



/**** Fin generacion del PDF ****/
end subroutine

public subroutine inicializa_dw (ref datawindow dw_param, string archivo_param, string ruta_param, string escala_default_param);idw_datawindow_a_imprimir=dw_param

is_archivo=archivo_param
is_ruta_archivos=ruta_param
is_escala=escala_default_param

em_escala_pdf.text=string(is_escala)



end subroutine

on uo_imprime_pdf.create
this.cb_1=create cb_1
this.em_escala_pdf=create em_escala_pdf
this.st_4=create st_4
this.Control[]={this.cb_1,&
this.em_escala_pdf,&
this.st_4}
end on

on uo_imprime_pdf.destroy
destroy(this.cb_1)
destroy(this.em_escala_pdf)
destroy(this.st_4)
end on

type cb_1 from commandbutton within uo_imprime_pdf
integer x = 786
integer y = 16
integer width = 466
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Exportar a PDF"
end type

event clicked;//dw_param

// Imprime el dw del reporte. Parametros: DW, nombre archivo, ruta archivo, escala. cph 29 sept 2021.

imprime_pdf(idw_datawindow_a_imprimir,is_archivo,is_ruta_archivos,em_escala_pdf.text)
return

end event

type em_escala_pdf from editmask within uo_imprime_pdf
integer x = 489
integer y = 24
integer width = 265
integer height = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "100"
borderstyle borderstyle = stylelowered!
string mask = "###"
boolean spin = true
double increment = 2
string minmax = "50~~100"
end type

type st_4 from statictext within uo_imprime_pdf
integer x = 18
integer y = 40
integer width = 448
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Escala archivo PDF"
alignment alignment = right!
boolean focusrectangle = false
end type

