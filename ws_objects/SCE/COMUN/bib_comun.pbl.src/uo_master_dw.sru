$PBExportHeader$uo_master_dw.sru
forward
global type uo_master_dw from u_dw
end type
end forward

global type uo_master_dw from u_dw
integer width = 2309
integer height = 352
boolean hscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
event ue_imprimir_dw ( )
end type
global uo_master_dw uo_master_dw

event ue_imprimir_dw();openwithparm(conf_impr,this)
end event

on uo_master_dw.create
call super::create
end on

on uo_master_dw.destroy
call super::destroy
end on

event ue_guarda_archivo;int in_value
string st_docname,st_named

in_value = GetFileSaveName("Selecciona Archivo",  & 
	st_docname, st_named, "CSV",  &
	" Comma-separated in_values,*.CSV," +&
	" dBASE-III format,*.DBF," +&
	" Data Interchange Format,*.DIF," +&
	" Microsoft Excel format,*.XLS," +&
	" Text with HTML formatting that approximates the DataWindow layout,*.HTM," +&
	" Powersoft Report (PSR) format,*.PSR," +&
	" SQL syntax,*.SQL," +&
	" Microsoft Multiplan format,*.SYL," +&
	" Tab-separated columns with a return at the end of each row,*.TXT," +&
	" Lotus 1-2-3 format,*.WKS," +&
	" Lotus 1-2-3 format,*.WK1," +&
	" Windows Metafile format,*.WMF,")

IF in_value = 1 THEN
	CHOOSE CASE Right (st_named, 3) 
		CASE "CSV"
			  this.SaveAs(st_docname,CSV!, TRUE)
		CASE "DBF"
			  this.SaveAs(st_docname,dBASE3!, TRUE)
		CASE "DIF"
			  this.SaveAs(st_docname,DIF!, TRUE)
		CASE "XLS"
			  this.SaveAs(st_docname,Excel!, TRUE)
		CASE "HTM"
			  this.SaveAs(st_docname,HTMLTable!, TRUE)
		CASE "PSR"
			  this.SaveAs(st_docname,PSReport!, TRUE)
		CASE "SQL"
			  this.SaveAs(st_docname,SQLInsert!, TRUE)
		CASE "SYL"
			  this.SaveAs(st_docname,SYLK!, TRUE)
		CASE "TXT"
			  this.SaveAs(st_docname,Text!, TRUE)
		CASE "WKS"
			  this.SaveAs(st_docname,WKS!, TRUE)
		CASE "WK1"
			  this.SaveAs(st_docname,WK1!, TRUE)
		CASE "WMF"
			  this.SaveAs(st_docname,WMF!, TRUE)
	END CHOOSE
else
	this.SaveAs(st_docname,Clipboard!, TRUE)
end if
end event

