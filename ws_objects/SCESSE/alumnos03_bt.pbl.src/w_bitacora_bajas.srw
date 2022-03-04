$PBExportHeader$w_bitacora_bajas.srw
forward
global type w_bitacora_bajas from Window
end type
type st_periodo_año from statictext within w_bitacora_bajas
end type
type st_fecha from statictext within w_bitacora_bajas
end type
type em_fecha_final from editmask within w_bitacora_bajas
end type
type em_fecha_inicio from editmask within w_bitacora_bajas
end type
type st_2 from statictext within w_bitacora_bajas
end type
type st_1 from statictext within w_bitacora_bajas
end type
type uo_cap_periodo from uo_periodo within w_bitacora_bajas
end type
type dw_bitacora_bajas_periodo from datawindow within w_bitacora_bajas
end type
type rr_1 from roundrectangle within w_bitacora_bajas
end type
type rr_2 from roundrectangle within w_bitacora_bajas
end type
type dw_bitacora_bajas from datawindow within w_bitacora_bajas
end type
end forward

global type w_bitacora_bajas from Window
int X=5
int Y=4
int Width=3557
int Height=2084
boolean TitleBar=true
string Title="BITACORA BAJAS"
string MenuName="m_bitacora_bajas"
long BackColor=10789024
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_periodo_año st_periodo_año
st_fecha st_fecha
em_fecha_final em_fecha_final
em_fecha_inicio em_fecha_inicio
st_2 st_2
st_1 st_1
uo_cap_periodo uo_cap_periodo
dw_bitacora_bajas_periodo dw_bitacora_bajas_periodo
rr_1 rr_1
rr_2 rr_2
dw_bitacora_bajas dw_bitacora_bajas
end type
global w_bitacora_bajas w_bitacora_bajas

type variables
boolean primeravez = false
end variables

on w_bitacora_bajas.create
if this.MenuName = "m_bitacora_bajas" then this.MenuID = create m_bitacora_bajas
this.st_periodo_año=create st_periodo_año
this.st_fecha=create st_fecha
this.em_fecha_final=create em_fecha_final
this.em_fecha_inicio=create em_fecha_inicio
this.st_2=create st_2
this.st_1=create st_1
this.uo_cap_periodo=create uo_cap_periodo
this.dw_bitacora_bajas_periodo=create dw_bitacora_bajas_periodo
this.rr_1=create rr_1
this.rr_2=create rr_2
this.dw_bitacora_bajas=create dw_bitacora_bajas
this.Control[]={this.st_periodo_año,&
this.st_fecha,&
this.em_fecha_final,&
this.em_fecha_inicio,&
this.st_2,&
this.st_1,&
this.uo_cap_periodo,&
this.dw_bitacora_bajas_periodo,&
this.rr_1,&
this.rr_2,&
this.dw_bitacora_bajas}
end on

on w_bitacora_bajas.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_periodo_año)
destroy(this.st_fecha)
destroy(this.em_fecha_final)
destroy(this.em_fecha_inicio)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.uo_cap_periodo)
destroy(this.dw_bitacora_bajas_periodo)
destroy(this.rr_1)
destroy(this.rr_2)
destroy(this.dw_bitacora_bajas)
end on

event open;// Juan Campos. Marzo-1997.

This.x = 1
This.y = 1
String  Parametro 
dw_bitacora_bajas.SetTransObject(gtr_sce)
dw_bitacora_bajas_periodo.SetTransObject(gtr_sce)
Parametro = Message.StringParm 
em_fecha_final.visible = false
em_fecha_final.enabled = false

If Parametro = "POR_FECHAS" Then
  w_bitacora_bajas.title = "REPORTE BITÁCORA BAJAS POR FECHAS"	 
  em_fecha_inicio.visible = True
  em_fecha_inicio.enabled = True
  em_fecha_final.visible = True
  em_fecha_final.enabled = True
  st_1.visible = True
  st_2.visible = True
  rr_1.visible = True
  rr_2.visible = True
  w_bitacora_bajas.uo_cap_periodo.visible = False
  w_bitacora_bajas.uo_cap_periodo.enabled = False
  st_fecha.visible = True
  st_periodo_año.visible = False
  dw_bitacora_bajas.visible = True
  dw_bitacora_bajas.enabled = True
   dw_bitacora_bajas.height = 1350
  em_fecha_inicio.setfocus()
End If     

If Parametro = "POR_PERIODO" Then
  w_bitacora_bajas.title = "REPORTE BITÁCORA BAJAS POR PERIODO"	 
  em_fecha_inicio.visible = False
  em_fecha_inicio.enabled = False
  em_fecha_final.visible = false
//  em_fecha_auxilar.enabled = false
//  em_fecha_auxiliar.visible = False
//  em_fecha_auxiliar.enabled = False
  st_1.visible = False
  st_2.visible = False
  rr_1.visible = False
  rr_2.visible = False
  w_bitacora_bajas.uo_cap_periodo.visible = True
  w_bitacora_bajas.uo_cap_periodo.enabled = True 
  st_fecha.visible = False
  st_periodo_año.visible = True
  dw_bitacora_bajas.visible = False
  dw_bitacora_bajas.enabled = False
  dw_bitacora_bajas_periodo.visible = True
  dw_bitacora_bajas_periodo.enabled = True
  dw_bitacora_bajas_periodo.x = 28
  dw_bitacora_bajas_periodo.y = 297
  dw_bitacora_bajas_periodo.height = 1350
  st_periodo_año.x = 1180 
  st_periodo_año.y = 21
  w_bitacora_bajas.uo_cap_periodo.x = 46
  w_bitacora_bajas.uo_cap_periodo.y = 137
  w_bitacora_bajas.uo_cap_periodo.ddlb_periodo.setfocus()
End If     
end event

type st_periodo_año from statictext within w_bitacora_bajas
int X=2615
int Y=16
int Width=594
int Height=92
boolean Enabled=false
string Text="PERIODO   AÑO"
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=8388608
long BorderColor=8388608
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_fecha from statictext within w_bitacora_bajas
int X=1179
int Y=20
int Width=1129
int Height=80
boolean Enabled=false
string Text="FECHA VALIDA: DIA-MES-AÑO"
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=41943040
long BorderColor=10789024
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_fecha_final from editmask within w_bitacora_bajas
int X=1504
int Y=148
int Width=407
int Height=92
int TabOrder=10
Alignment Alignment=Center!
string Mask="dd/mm/yyyy"
MaskDataType MaskDataType=DateTimeMask!
string DisplayData="Ä"
long BackColor=15793151
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;// Se incrementa en uno el dia. Esto es un truco para que el between tome el rango
// de la fecha correctamente.
// Ejemplo:  
//  Rango  '18-02-97' Between '20-02-97'    Error. Si existen datos con estas fechas nos 
//                                                 trae del '18-02-97' al '19-02-97'. 
//
//  Rango  ´18-02-97  Between '20-02-97' + Un Dia  Ok Rango Correcto nos trae del '18-02-97' al '20-02-97'. 
// Juan Campos. Febrero 1997.

String  Dia, Mes, Año
Integer DiaEntero
 
//Dia       		= Mid(em_fecha_auxiliar.text, 1, 2)
//Mes       		= Mid(em_fecha_auxiliar.text, 4, 2)
//Año       		= Mid(em_fecha_auxiliar.text, 7, 2)
//DiaEntero 	= Integer(Dia) + 1
//Dia       		= String(DiaEntero)
//em_fecha_final.text = Dia + "/" + Mes +"/"+ año

 
end event

type em_fecha_inicio from editmask within w_bitacora_bajas
int X=471
int Y=152
int Width=407
int Height=92
int TabOrder=20
Alignment Alignment=Center!
string Mask="dd/mm/yyyy "
MaskDataType MaskDataType=DateTimeMask!
string DisplayData=""
long BackColor=15793151
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;if em_fecha_inicio.text = "" Then 
  em_fecha_inicio.setfocus()
Else
  em_fecha_final.setfocus()	
End If




 
end event

type st_2 from statictext within w_bitacora_bajas
int X=1088
int Y=152
int Width=407
int Height=92
boolean Enabled=false
string Text="Fecha_Final:"
boolean FocusRectangle=false
long BackColor=10789024
long BorderColor=8388608
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_bitacora_bajas
int X=59
int Y=152
int Width=407
int Height=92
boolean Enabled=false
string Text="Fecha_Inicio:"
boolean FocusRectangle=false
long BackColor=10789024
long BorderColor=8388608
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_cap_periodo from uo_periodo within w_bitacora_bajas
int X=2533
int Y=120
int TabOrder=30
end type

on uo_cap_periodo.destroy
call uo_periodo::destroy
end on

type dw_bitacora_bajas_periodo from datawindow within w_bitacora_bajas
int X=32
int Y=1060
int Width=3447
int Height=748
int TabOrder=50
boolean Enabled=false
string DataObject="dw_bitacora_bajas_periodo"
end type

event constructor;dw_bitacora_bajas.object.fecha_hoy.text = Mid(fecha_espaniol_servidor(gtr_sce),1,11)
end event

event retrieveend;
Integer	Contador,Renglon
long     	CuentaInt
Char     	DigitoAux

primeravez = True

FOR Contador = 1 To RowCount()
    SetRow(Contador)
    CuentaInt = GetItemNumber(GetRow(),1)
    DigitoAux = obten_digito(CuentaInt)
    SetItem(Contador,"digito",DigitoAux)
NEXT
 
if rowcount() > 0 Then
	SetRow(1)
	ScrollToRow(GetRow())
	SetRowFocusIndicator(Hand!)
	if messagebox("Impresión","Desea imprimir el reporte",Question!,YesNo!) = 1 Then
		print()
	else
		setfocus()
	end if
end if 
  
end event

event rowfocuschanged;if not primeravez then
  SetRow(GetRow())
  ScrollToRow(GetRow())
  SetRowFocusIndicator(Hand!)
end if
end event

type rr_1 from roundrectangle within w_bitacora_bajas
int X=46
int Y=136
int Width=887
int Height=124
boolean Enabled=false
int LineThickness=4
int CornerHeight=40
int CornerWidth=41
long FillColor=12632256
end type

type rr_2 from roundrectangle within w_bitacora_bajas
int X=1065
int Y=136
int Width=887
int Height=124
boolean Enabled=false
int LineThickness=4
int CornerHeight=40
int CornerWidth=41
long LineColor=10789024
long FillColor=12632256
end type

type dw_bitacora_bajas from datawindow within w_bitacora_bajas
int X=41
int Y=284
int Width=3447
int Height=748
int TabOrder=40
boolean Enabled=false
boolean BringToTop=true
string DataObject="dw_bitacora_bajas"
end type

event constructor;dw_bitacora_bajas.object.fecha_hoy.text =Mid(fecha_espaniol_servidor(gtr_sce),1,11)

 
end event

event retrieveend;
Integer	Contador,Renglon
long     	CuentaInt
Char     	DigitoAux

primeravez = True

FOR Contador = 1 To RowCount()
    SetRow(Contador)
    CuentaInt = GetItemNumber(GetRow(),1)
    DigitoAux = obten_digito(CuentaInt)
    SetItem(Contador,"digito",DigitoAux)
NEXT

if rowcount() > 0 Then
	SetRow(1)
	ScrollToRow(GetRow())
	SetRowFocusIndicator(Hand!)
	if messagebox("Impresión","Desea imprimir el reporte",Question!,YesNo!) = 1 Then
		print()
	else
		setfocus()
	end if
end if 
end event

event rowfocuschanged;if not primeravez then
  SetRow(GetRow())
  ScrollToRow(GetRow())
  SetRowFocusIndicator(Hand!)
end if
end event

