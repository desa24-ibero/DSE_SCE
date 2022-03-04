$PBExportHeader$uo_nivel_2013.sru
$PBExportComments$User Object Nivel Control Escolar
forward
global type uo_nivel_2013 from userobject
end type
type dw_1 from datawindow within uo_nivel_2013
end type
type gb_1 from groupbox within uo_nivel_2013
end type
end forward

global type uo_nivel_2013 from userobject
integer width = 585
integer height = 352
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
gb_1 gb_1
end type
global uo_nivel_2013 uo_nivel_2013

type variables
Transaction itran_obj_nivel
String is_Array_Nivel[]
end variables

forward prototypes
public function integer of_carga_control (transaction tran_obj_nivel)
public function string of_obtiene_seleccion ()
public function integer of_carga_arreglo_nivel ()
public function integer of_obtiene_array (ref string as_array[])
end prototypes

public function integer of_carga_control (transaction tran_obj_nivel);itran_obj_nivel = tran_obj_nivel
dw_1.settransobject( tran_obj_nivel)
dw_1.retrieve( )

return 0
end function

public function string of_obtiene_seleccion ();integer li_row, li_tot
string ls_cvenivel, ls_selecc, ls_niv_acum, ls_array_nulo[]

is_Array_Nivel[] = ls_array_nulo[]


ls_cvenivel = ""
ls_selecc = ""
ls_niv_acum = ""

dw_1.accepttext( )
li_tot = dw_1.rowcount( )
li_row = 1

If li_tot > 0 Then
	Do While li_row <=  li_tot
		ls_selecc = dw_1.getitemstring( li_row, "uso")
		
		If ls_selecc = 'S' Then
			ls_cvenivel = dw_1.getitemstring( li_row, "cve_nivel")
			ls_niv_acum = ls_niv_acum + ls_cvenivel + "|"
		End If
		li_row = li_row + 1
	Loop
End If

return ls_niv_acum
end function

public function integer of_carga_arreglo_nivel ();long li_numtot
integer li_pos_ini , li_pos_fin, iIndex, iPosini, iPosfin
string sAsterisco, sCadena, sResultado, ls_result[]
        
sCadena = This.of_obtiene_seleccion( )
sAsterisco = '|'
iIndex = 1
iPosini  = 1
	 
Do  While Pos(sCadena, sAsterisco) > 0 
	iPosfin    = Pos(sCadena, sAsterisco)
	sResultado = Mid(sCadena, iPosini, iPosfin - 1)
	sCadena    = Mid(sCadena, iPosfin + 1, len(sCadena))
	is_Array_Nivel[iIndex] = sResultado
	iIndex  = iIndex  + 1
Loop                                                                                                                                                                                                                                                                                                                                                                                                                                          

If UpperBound(is_Array_Nivel[]) > 0 then
	return 1
Else
	return 0
End IF
end function

public function integer of_obtiene_array (ref string as_array[]);as_array = is_array_nivel[]

return 1
end function

on uo_nivel_2013.create
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.dw_1,&
this.gb_1}
end on

on uo_nivel_2013.destroy
destroy(this.dw_1)
destroy(this.gb_1)
end on

type dw_1 from datawindow within uo_nivel_2013
integer x = 27
integer y = 64
integer width = 526
integer height = 264
integer taborder = 20
string title = "none"
string dataobject = "dw_nivel"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within uo_nivel_2013
integer x = 9
integer width = 567
integer height = 344
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 16777215
string text = "Nivel"
end type

