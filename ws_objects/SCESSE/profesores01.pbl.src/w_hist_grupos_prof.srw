$PBExportHeader$w_hist_grupos_prof.srw
forward
global type w_hist_grupos_prof from w_datos_grales_prof
end type
type rr_1 from roundrectangle within w_hist_grupos_prof
end type
type dw_hgp from datawindow within w_hist_grupos_prof
end type
type dw_hist_grupos_prof_1 from datawindow within w_hist_grupos_prof
end type
type cb_imprime from commandbutton within w_hist_grupos_prof
end type
type st_1 from statictext within w_hist_grupos_prof
end type
type cb_genera_pdf from commandbutton within w_hist_grupos_prof
end type
end forward

global type w_hist_grupos_prof from w_datos_grales_prof
integer x = 834
integer y = 362
integer width = 3959
integer height = 3720
rr_1 rr_1
dw_hgp dw_hgp
dw_hist_grupos_prof_1 dw_hist_grupos_prof_1
cb_imprime cb_imprime
st_1 st_1
cb_genera_pdf cb_genera_pdf
end type
global w_hist_grupos_prof w_hist_grupos_prof

type variables
Datawindowchild dwc_periodo
end variables

on w_hist_grupos_prof.create
int iCurrent
call super::create
this.rr_1=create rr_1
this.dw_hgp=create dw_hgp
this.dw_hist_grupos_prof_1=create dw_hist_grupos_prof_1
this.cb_imprime=create cb_imprime
this.st_1=create st_1
this.cb_genera_pdf=create cb_genera_pdf
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rr_1
this.Control[iCurrent+2]=this.dw_hgp
this.Control[iCurrent+3]=this.dw_hist_grupos_prof_1
this.Control[iCurrent+4]=this.cb_imprime
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.cb_genera_pdf
end on

on w_hist_grupos_prof.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rr_1)
destroy(this.dw_hgp)
destroy(this.dw_hist_grupos_prof_1)
destroy(this.cb_imprime)
destroy(this.st_1)
destroy(this.cb_genera_pdf)
end on

event open;call super::open;dw_hgp.SetTransObject(gtr_sce)






//Modif. Roberto Novoa Jun/2016 .- Funcionalidad periodos multiples
f_dddw_converter(dw_hgp, dwc_periodo, "hist_grupos_periodo")
end event

type dw_dgf from w_datos_grales_prof`dw_dgf within w_hist_grupos_prof
integer height = 964
integer taborder = 10
end type

event dw_dgf::itemchanged;// Juan Campos Sánchez.		Noviembre-1997.
Integer	Depto
long		CveProf
String ls_departamento

ls_departamento= ""
Accepttext()
CveProf = GetItemNumber(GetRow(),"cve_profesor")
EstaVentana.SetRedraw(False) 
If Retrieve(CveProf) = 0 Then
	Messagebox("Aviso","La clave de profesor no existe")
	InsertRow(0)	
Else
	Depto = GetItemNumber(GetRow(),"cve_depto")
	Select departamento Into :ls_departamento
	From departamentos
	Where cve_depto = :Depto using gtr_sce;
	If dw_hgp.Retrieve(CveProf) = 0 Then
		Messagebox("Aviso","No hay datos en histórico grupos de esté profesor")
		dw_hgp.InsertRow(0)	
	End if
End if
EstaVentana.SetRedraw(True)

 
end event

type rr_1 from roundrectangle within w_hist_grupos_prof
long linecolor = 16777215
integer linethickness = 3
long fillcolor = 12632256
integer x = 55
integer y = 964
integer width = 3447
integer height = 708
integer cornerheight = 42
integer cornerwidth = 40
end type

type dw_hgp from datawindow within w_hist_grupos_prof
integer x = 50
integer y = 656
integer width = 3415
integer height = 672
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_hist_grupos_prof"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type dw_hist_grupos_prof_1 from datawindow within w_hist_grupos_prof
integer x = 37
integer y = 1352
integer width = 3451
integer height = 1760
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_hist_grupos_prof_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;dw_hist_grupos_prof_1.SetTransObject(gtr_sce)
end event

type cb_imprime from commandbutton within w_hist_grupos_prof
integer x = 3529
integer y = 1600
integer width = 384
integer height = 108
integer taborder = 11
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprime"
end type

event clicked;// Juan Campos Sánchez.   Marzo-1998.

Long Cveprof // se cambia por Long antes era Integer pero truena con valores grandes . cph mayo 2021


IF dw_dgf.RowCount() > 0 Then
	CveProf = dw_dgf.GetItemNumber(dw_dgf.GetRow(),"cve_profesor")
	If dw_hist_grupos_prof_1.Retrieve(CveProf) > 0 Then
			dw_hist_grupos_prof_1.Print()

	Else
		Messagebox("No hay datos para imprimir","")
	End If
Else
	Messagebox("No hay datos para imprimir","")
End If	
	
end event

type st_1 from statictext within w_hist_grupos_prof
integer x = 3625
integer y = 52
integer width = 169
integer height = 80
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "."
boolean focusrectangle = false
end type

event doubleclicked;Messagebox("Version","20, 27 de mayo de 2021~r~n Cesar Ponce: Se agrega boton para generar archivos PDF.")
end event

type cb_genera_pdf from commandbutton within w_hist_grupos_prof
integer x = 3529
integer y = 1816
integer width = 384
integer height = 108
integer taborder = 21
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Genera PDF"
end type

event clicked;// Cesar Ponce Hdz. Se genera codigo para generar correctamente un archivo PDF. 20-myo-2021

Long Cveprof // se cambia por Long antes era Integer pero truena con valores grandes . cph mayo 2021

IF dw_dgf.RowCount() > 0 Then
	CveProf = dw_dgf.GetItemNumber(dw_dgf.GetRow(),"cve_profesor")
	If dw_hist_grupos_prof_1.Retrieve(CveProf) > 0 Then
			//cph	dw_hist_grupos_prof_1.Print()

//	dw_impresion_pagares.Modify("DataWindow.Print.Filename='" + ls_archivo + "'")


	dw_hist_grupos_prof_1.Modify("Datawindow.Printer='Sybase DataWindow PS'") // debe ser esta impresora para que puda generar correctamente los PDF cph 24/Cot/2020
	dw_hist_grupos_prof_1.Modify("Datawindow.Export.PDF.Method = 0") // el 1 pregunta el archivo prn

	dw_hist_grupos_prof_1.object.datawindow.export.pdf.xslfop.print='Yes'
	dw_hist_grupos_prof_1.Object.DataWindow.Export.PDF.Distill.CustomPostScript="1" 
	//dw_hist_grupos_prof_1.Object.DataWindow.Print.Scale=98
	//dw_hist_grupos_prof_1.Modify("Datawindow.Print.Scale='60'")
	//dw_hist_grupos_prof_1.Modify("Datawindow.Printer='Microsoft XPS Document Writer'")

	// DataWindow Units set to 1/1000 inch
	//dw_hist_grupos_prof_1.Modify("DataWindow.Print.Paper.Size=255")
	//9.875 inches long
	//dw_hist_grupos_prof_1.Modify("DataWindow.Print.CustomPage.Length=9000")
	//7.375 inches wide
	//dw_hist_grupos_prof_1.Modify("DataWindow.Print.CustomPage.Width=6500") 


	Integer li_error_al_grabar

String ls_archivo
	li_error_al_grabar=dw_hist_grupos_prof_1.saveas("", PDF!, TRUE)

//li_error_al_grabar=dw_hist_grupos_prof_1.saveas("c:\tempo\temporalito2.pdf", PDF!, TRUE)

if (	li_error_al_grabar<>1) then 
	Messagebox("Aviso","Error al general el archivo PDF.")
end if


	Else
		Messagebox("No hay datos para imprimir","")
	End If
Else
	Messagebox("No hay datos para imprimir","")
End If	
	
end event

