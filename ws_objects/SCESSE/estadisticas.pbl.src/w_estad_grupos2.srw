$PBExportHeader$w_estad_grupos2.srw
forward
global type w_estad_grupos2 from window
end type
type tab_1 from tab within w_estad_grupos2
end type
type estad_hist_grupos from userobject within tab_1
end type
type st_1 from statictext within estad_hist_grupos
end type
type uo_periodo from uo_periodo_variable_tipos within estad_hist_grupos
end type
type ddlb_tipo_grupo from dropdownlistbox within estad_hist_grupos
end type
type st_status from statictext within estad_hist_grupos
end type
type dw_estad_hist_grupos from datawindow within estad_hist_grupos
end type
type cb_3 from commandbutton within estad_hist_grupos
end type
type cb_2 from commandbutton within estad_hist_grupos
end type
type cb_1 from commandbutton within estad_hist_grupos
end type
type ddlb_periodo from dropdownlistbox within estad_hist_grupos
end type
type em_año from editmask within estad_hist_grupos
end type
type gb_1 from groupbox within estad_hist_grupos
end type
type estad_hist_grupos from userobject within tab_1
st_1 st_1
uo_periodo uo_periodo
ddlb_tipo_grupo ddlb_tipo_grupo
st_status st_status
dw_estad_hist_grupos dw_estad_hist_grupos
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
ddlb_periodo ddlb_periodo
em_año em_año
gb_1 gb_1
end type
type tab_1 from tab within w_estad_grupos2
estad_hist_grupos estad_hist_grupos
end type
end forward

global type w_estad_grupos2 from window
integer x = 832
integer y = 360
integer width = 3511
integer height = 1872
boolean titlebar = true
string title = "Histórico de Grupos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
tab_1 tab_1
end type
global w_estad_grupos2 w_estad_grupos2

type variables
Integer Periodo
Long Año
int tipo
end variables

on w_estad_grupos2.create
this.tab_1=create tab_1
this.Control[]={this.tab_1}
end on

on w_estad_grupos2.destroy
destroy(this.tab_1)
end on

event open;// ESTADISTICA DE HISTÓRICO GRUPOS (VARIOS.)
// JUAN CAMPOS SÁNCHEZ- MAR-1998.


THIS.tab_1.estad_hist_grupos.uo_periodo.of_inicializa_servicio("V", "L", "L", "N", gtr_sce) 











end event

type tab_1 from tab within w_estad_grupos2
integer x = 14
integer y = 24
integer width = 3424
integer height = 1720
integer taborder = 1
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean raggedright = true
integer selectedtab = 1
estad_hist_grupos estad_hist_grupos
end type

on tab_1.create
this.estad_hist_grupos=create estad_hist_grupos
this.Control[]={this.estad_hist_grupos}
end on

on tab_1.destroy
destroy(this.estad_hist_grupos)
end on

type estad_hist_grupos from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3387
integer height = 1592
long backcolor = 79741120
string text = "Estadística Histórico Grupos"
long tabtextcolor = 8388608
long tabbackcolor = 8388608
string picturename = "Graph!"
long picturemaskcolor = 553648127
st_1 st_1
uo_periodo uo_periodo
ddlb_tipo_grupo ddlb_tipo_grupo
st_status st_status
dw_estad_hist_grupos dw_estad_hist_grupos
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
ddlb_periodo ddlb_periodo
em_año em_año
gb_1 gb_1
end type

on estad_hist_grupos.create
this.st_1=create st_1
this.uo_periodo=create uo_periodo
this.ddlb_tipo_grupo=create ddlb_tipo_grupo
this.st_status=create st_status
this.dw_estad_hist_grupos=create dw_estad_hist_grupos
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.ddlb_periodo=create ddlb_periodo
this.em_año=create em_año
this.gb_1=create gb_1
this.Control[]={this.st_1,&
this.uo_periodo,&
this.ddlb_tipo_grupo,&
this.st_status,&
this.dw_estad_hist_grupos,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.ddlb_periodo,&
this.em_año,&
this.gb_1}
end on

on estad_hist_grupos.destroy
destroy(this.st_1)
destroy(this.uo_periodo)
destroy(this.ddlb_tipo_grupo)
destroy(this.st_status)
destroy(this.dw_estad_hist_grupos)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.ddlb_periodo)
destroy(this.em_año)
destroy(this.gb_1)
end on

type st_1 from statictext within estad_hist_grupos
integer x = 1102
integer y = 60
integer width = 224
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Año: "
boolean focusrectangle = false
end type

type uo_periodo from uo_periodo_variable_tipos within estad_hist_grupos
integer x = 55
integer y = 64
integer height = 348
integer taborder = 10
end type

on uo_periodo.destroy
call uo_periodo_variable_tipos::destroy
end on

type ddlb_tipo_grupo from dropdownlistbox within estad_hist_grupos
integer x = 1088
integer y = 276
integer width = 489
integer height = 348
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean vscrollbar = true
end type

event constructor;int li_renglon
DataStore lds_tipo_grupo
lds_tipo_grupo = Create DataStore
lds_tipo_grupo.DataObject = "d_tipo_grupo"
lds_tipo_grupo.SetTrans(gtr_sce)
li_renglon = lds_tipo_grupo.Retrieve()
li_renglon = 1
do while li_renglon <= lds_tipo_grupo.RowCount()
	AddItem(string(lds_tipo_grupo.GetItemNumber(li_renglon, "tipo"))+"-"+&
				lds_tipo_grupo.GetItemString(li_renglon, "nombre_tipo"))
	li_renglon++
loop
if lds_tipo_grupo.RowCount() > 0 then SelectItem(1)
Destroy lds_tipo_grupo
end event

type st_status from statictext within estad_hist_grupos
integer x = 55
integer y = 1496
integer width = 3173
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16776960
long backcolor = 8388608
boolean enabled = false
string text = "Status"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_estad_hist_grupos from datawindow within estad_hist_grupos
integer x = 5
integer y = 464
integer width = 3287
integer height = 1012
string dataobject = "dw_estad_hist_grupos2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;dw_estad_hist_grupos.settransobject(gtr_sce)
end event

type cb_3 from commandbutton within estad_hist_grupos
integer x = 2555
integer y = 68
integer width = 818
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salvar como archivo de Exel."
end type

event clicked;// Juan Campos Sánchez.    Mar-1998.

Integer i,NumArchivo,Valor
String  Ruta_NombreArchivo,NombreArchivo

IF dw_estad_hist_grupos.RowCount() > 0 Then	
	Valor = 	GetFileSaveName("Selecciona Archivo", &
        		Ruta_NombreArchivo, NombreArchivo, "TXT","Archivo de texto,*.TXT,")
	If Valor = 1 then
		NumArchivo = FileOpen(Ruta_NombreArchivo,  &
			LineMode!, Write!, LockWrite!, Replace!)
 		st_status.text ="Guardando reporte en "+Ruta_NombreArchivo+", Espere...  Tiempo de proceso 10 minutos. Aprox."
		SetPointer(HourGlass!) 
		FileWrite(NumArchivo,"Año~t"+ &
									"Periodo~t"+ &				
									"Cve Mat~t"+ &
	                     	"Materia~t"+ &
									"Departamento~t"+ &
									"Inscritos~t"+ &
									"Grupos Abiertos~t"+ &
									"Grupos Cerrados~t"+ &
									"Bajas~t"+ &
 									"Reprobadas")
		For i = 1 to dw_estad_hist_grupos.RowCount() 
   		FileWrite(NumArchivo,String(dw_estad_hist_grupos.GetItemNumber(i,"hist_grupos_anio"))	 		+'~t'+ &
	                           String(dw_estad_hist_grupos.GetItemNumber(i,"hist_grupos_periodo"))		+'~t'+ &
										String(dw_estad_hist_grupos.GetItemNumber(i,"hist_grupos_cve_mat"))		+'~t'+ &
										String(dw_estad_hist_grupos.GetItemNumber(i,"coordinaciones_cve_coordinacion"))	+'~t'+ &
	                               	 dw_estad_hist_grupos.GetItemString(i,"materias_materia")			+'~t'+ &
										 	 	 dw_estad_hist_grupos.GetItemString(i,"inscritos")						+'~t'+ &
										       dw_estad_hist_grupos.GetItemString(i,"gpo_abiertos") 				+'~t'+ &
										  	 	 dw_estad_hist_grupos.GetItemString(i,"gpo_cerrados")					+'~t'+ &
										    	 dw_estad_hist_grupos.GetItemString(i,"bajas")							+'~t'+ &
 											 	 dw_estad_hist_grupos.GetItemString(i,"reprobadas"))
		Next
		FileClose(NumArchivo)
		st_status.text="Fin de proceso."
		SetPointer(Arrow!) 
	Else
		Messagebox("No hay datos para guardar","")
	End IF
End If
	 
end event

type cb_2 from commandbutton within estad_hist_grupos
integer x = 2057
integer y = 68
integer width = 489
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprime Reporte"
end type

event clicked;// Juan Campos Sánchez.    Mar-1998.

IF dw_estad_hist_grupos.RowCount() > 0 Then
	dw_estad_hist_grupos.Print()
Else
	Messagebox("No hay datos para imprimir","")
End IF
end event

type cb_1 from commandbutton within estad_hist_grupos
integer x = 1577
integer y = 68
integer width = 471
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Genera Reporte"
end type

event clicked;// Juan Campos Sánchez.     Mar-1998.

//If ddlb_periodo.text ="PRIMAVERA" Then
//	Periodo = 0
//ElseIf ddlb_periodo.text ="VERANO" Then
//	Periodo = 1
//ElseIf ddlb_periodo.text ="OTOÑO" Then
//	Periodo = 2
//Else
//	Periodo = 9 // Error
//End If


//**--****--****--****--****--****--****--****--****--****--****--****--**
INTEGER le_index
INTEGER le_periodo[] 
STRING ls_tipo_periodo[], ls_periodo_elegido

PARENT.uo_periodo.of_recupera_periodos()

FOR le_index = 1 TO UPPERBOUND(PARENT.uo_periodo.istr_periodos[])
	IF TRIM(ls_periodo_elegido) <> "" THEN ls_periodo_elegido = ls_periodo_elegido + ", "
	ls_periodo_elegido = ls_periodo_elegido + PARENT.uo_periodo.istr_periodos[le_index].descripcion 
	le_periodo[le_index] = PARENT.uo_periodo.istr_periodos[le_index].periodo
	ls_tipo_periodo[le_index] = PARENT.uo_periodo.istr_periodos[le_index].tipo
NEXT 
//**--****--****--****--****--****--****--****--****--****--****--****--**


Año = Long(em_año.Text)
tipo = integer(mid(ddlb_tipo_grupo.Text,1,1))
//messagebox(ddlb_tipo_grupo.Text,string(tipo))
//If dw_estad_hist_grupos.Retrieve(Periodo,Año,Tipo) = 0 Then
If dw_estad_hist_grupos.Retrieve(le_periodo[],Año,Tipo) = 0 Then
	Messagebox("No hay información","Verifique el periodo y año")
End if


dw_estad_hist_grupos.MODIFY("t_tipo_periodo.text = '" + ls_periodo_elegido + "'")
end event

type ddlb_periodo from dropdownlistbox within estad_hist_grupos
boolean visible = false
integer x = 73
integer y = 92
integer width = 553
integer height = 348
integer taborder = 70
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
boolean vscrollbar = true
string item[] = {"PRIMAVERA","VERANO","OTOÑO"}
borderstyle borderstyle = stylelowered!
end type

type em_año from editmask within estad_hist_grupos
integer x = 1088
integer y = 132
integer width = 247
integer height = 104
integer taborder = 20
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
borderstyle borderstyle = stylelowered!
string mask = "####"
string displaydata = "~t/"
end type

type gb_1 from groupbox within estad_hist_grupos
integer x = 18
integer y = 12
integer width = 1006
integer height = 416
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Periodo"
end type

