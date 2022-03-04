$PBExportHeader$w_estad_grupos.srw
$PBExportComments$Estadistica de histórico grupos. (Varios).  Juan Campos Sánchez. Mar-1998.
forward
global type w_estad_grupos from Window
end type
type tab_1 from tab within w_estad_grupos
end type
type estad_hist_grupos from userobject within tab_1
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
st_status st_status
dw_estad_hist_grupos dw_estad_hist_grupos
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
ddlb_periodo ddlb_periodo
em_año em_año
gb_1 gb_1
end type
type tab_1 from tab within w_estad_grupos
estad_hist_grupos estad_hist_grupos
end type
end forward

global type w_estad_grupos from Window
int X=832
int Y=360
int Width=3433
int Height=1680
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
tab_1 tab_1
end type
global w_estad_grupos w_estad_grupos

type variables
Integer Periodo
Long Año
end variables

on w_estad_grupos.create
this.tab_1=create tab_1
this.Control[]={this.tab_1}
end on

on w_estad_grupos.destroy
destroy(this.tab_1)
end on

event open;// ESTADISTICA DE HISTÓRICO GRUPOS (VARIOS.)
// JUAN CAMPOS SÁNCHEZ- MAR-1998.
end event

type tab_1 from tab within w_estad_grupos
int X=14
int Y=24
int Width=3301
int Height=1540
int TabOrder=1
boolean RaggedRight=true
int SelectedTab=1
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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
int X=18
int Y=112
int Width=3264
int Height=1412
long BackColor=79741120
string Text="Estadística Histórico Grupos"
long TabBackColor=8388608
long TabTextColor=65535
long PictureMaskColor=553648127
string PictureName="Graph!"
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
this.st_status=create st_status
this.dw_estad_hist_grupos=create dw_estad_hist_grupos
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.ddlb_periodo=create ddlb_periodo
this.em_año=create em_año
this.gb_1=create gb_1
this.Control[]={this.st_status,&
this.dw_estad_hist_grupos,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.ddlb_periodo,&
this.em_año,&
this.gb_1}
end on

on estad_hist_grupos.destroy
destroy(this.st_status)
destroy(this.dw_estad_hist_grupos)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.ddlb_periodo)
destroy(this.em_año)
destroy(this.gb_1)
end on

type st_status from statictext within estad_hist_grupos
int X=55
int Y=1332
int Width=3173
int Height=76
boolean Enabled=false
string Text="Status"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16776960
long BackColor=8388608
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_estad_hist_grupos from datawindow within estad_hist_grupos
int X=5
int Y=268
int Width=3287
int Height=1012
int TabOrder=4
string DataObject="dw_estad_hist_grupos"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;dw_estad_hist_grupos.settransobject(gtr_sce)
end event

type cb_3 from commandbutton within estad_hist_grupos
int X=2418
int Y=68
int Width=818
int Height=108
int TabOrder=4
string Text="Salvar como archivo de Exel."
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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
		FileWrite(NumArchivo,"Cve Mat~t"+ &
	                     	"Materia~t"+ &
									"Inscritos~t"+ &
									"Grupos Abiertos"+ &
									"Grupos Cerrados~t"+ &
									"Bajas~t"+ &
 									"Reprobadas")
		For i = 1 to dw_estad_hist_grupos.RowCount() 
   		FileWrite(NumArchivo,String(dw_estad_hist_grupos.GetItemNumber(i,"hist_grupos_cve_mat"))	+'~t'+ &
	                               	 dw_estad_hist_grupos.GetItemString(i,"materias_materia")		+'~t'+ &
										 	 	 dw_estad_hist_grupos.GetItemString(i,"inscritos")					+'~t'+ &
										String(dw_estad_hist_grupos.GetItemNumber(i,"compute_0005"))			+'~t'+ &
										  	 	 dw_estad_hist_grupos.GetItemString(i,"gpo_cerrados")				+'~t'+ &
										    	 dw_estad_hist_grupos.GetItemString(i,"bajas")						+'~t'+ &
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
int X=1865
int Y=68
int Width=489
int Height=108
int TabOrder=3
string Text="Imprime Reporte"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// Juan Campos Sánchez.    Mar-1998.

IF dw_estad_hist_grupos.RowCount() > 0 Then
	dw_estad_hist_grupos.Print()
Else
	Messagebox("No hay datos para imprimir","")
End IF
end event

type cb_1 from commandbutton within estad_hist_grupos
int X=1330
int Y=68
int Width=471
int Height=108
int TabOrder=2
string Text="Genera Reporte"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// Juan Campos Sánchez.     Mar-1998.

If ddlb_periodo.text ="PRIMAVERA" Then
	Periodo = 0
ElseIf ddlb_periodo.text ="VERANO" Then
	Periodo = 1
ElseIf ddlb_periodo.text ="OTOÑO" Then
	Periodo = 2
Else
	Periodo = 9 // Error
End If

Año = Long(em_año.Text)
If dw_estad_hist_grupos.Retrieve(Año,Periodo) = 0 Then
	Messagebox("No hay información","Verifique el periodo y año")
End if
end event

type ddlb_periodo from dropdownlistbox within estad_hist_grupos
int X=73
int Y=92
int Width=553
int Height=348
int TabOrder=3
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
long BackColor=15793151
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"PRIMAVERA",&
"VERANO",&
"OTOÑO"}
end type

type em_año from editmask within estad_hist_grupos
int X=645
int Y=92
int Width=247
int Height=104
int TabOrder=4
BorderStyle BorderStyle=StyleLowered!
string Mask="####"
string DisplayData=""
long TextColor=33554432
long BackColor=15793151
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within estad_hist_grupos
int X=41
int Y=12
int Width=891
int Height=220
int TabOrder=2
string Text="Periodo. Año"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

