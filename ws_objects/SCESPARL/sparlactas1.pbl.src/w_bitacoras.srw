$PBExportHeader$w_bitacoras.srw
$PBExportComments$Reporte de bitácora, de  los movimientos al histórico.   Juan Campos. Marzo-1997.
forward
global type w_bitacoras from Window
end type
type cbx_todos from checkbox within w_bitacoras
end type
type st_periodo_año from statictext within w_bitacoras
end type
type uo_cap_periodo from uo_periodo within w_bitacoras
end type
type dw_bitacora_periodo from datawindow within w_bitacoras
end type
type em_fecha_final from editmask within w_bitacoras
end type
type st_fecha from statictext within w_bitacoras
end type
type st_2 from statictext within w_bitacoras
end type
type st_1 from statictext within w_bitacoras
end type
type em_fecha_inicio from editmask within w_bitacoras
end type
type dw_bitacora from datawindow within w_bitacoras
end type
type rr_1 from roundrectangle within w_bitacoras
end type
type rr_2 from roundrectangle within w_bitacoras
end type
end forward

global type w_bitacoras from Window
int X=4
int Y=3
int Width=3558
int Height=2045
boolean TitleBar=true
string Title="REPORTES BITACORAS HISTÓRICO"
string MenuName="m_bitacoras"
long BackColor=10789024
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cbx_todos cbx_todos
st_periodo_año st_periodo_año
uo_cap_periodo uo_cap_periodo
dw_bitacora_periodo dw_bitacora_periodo
em_fecha_final em_fecha_final
st_fecha st_fecha
st_2 st_2
st_1 st_1
em_fecha_inicio em_fecha_inicio
dw_bitacora dw_bitacora
rr_1 rr_1
rr_2 rr_2
end type
global w_bitacoras w_bitacoras

type variables
boolean primeravez = false
end variables

on w_bitacoras.create
if this.MenuName = "m_bitacoras" then this.MenuID = create m_bitacoras
this.cbx_todos=create cbx_todos
this.st_periodo_año=create st_periodo_año
this.uo_cap_periodo=create uo_cap_periodo
this.dw_bitacora_periodo=create dw_bitacora_periodo
this.em_fecha_final=create em_fecha_final
this.st_fecha=create st_fecha
this.st_2=create st_2
this.st_1=create st_1
this.em_fecha_inicio=create em_fecha_inicio
this.dw_bitacora=create dw_bitacora
this.rr_1=create rr_1
this.rr_2=create rr_2
this.Control[]={this.cbx_todos,&
this.st_periodo_año,&
this.uo_cap_periodo,&
this.dw_bitacora_periodo,&
this.em_fecha_final,&
this.st_fecha,&
this.st_2,&
this.st_1,&
this.em_fecha_inicio,&
this.dw_bitacora,&
this.rr_1,&
this.rr_2}
end on

on w_bitacoras.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_todos)
destroy(this.st_periodo_año)
destroy(this.uo_cap_periodo)
destroy(this.dw_bitacora_periodo)
destroy(this.em_fecha_final)
destroy(this.st_fecha)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_fecha_inicio)
destroy(this.dw_bitacora)
destroy(this.rr_1)
destroy(this.rr_2)
end on

event open;// Documentación pendiente
// Juan Campos. Febrero-1997.

//g_nv_security.fnv_secure_window (this)

this.x = 1
This.y = 1

String  Parametro 

dw_bitacora.SetTransObject(gtr_sce)
dw_bitacora_periodo.SetTransObject(gtr_sce)

Parametro	= Message.StringParm 
em_fecha_final.visible	= false

If Parametro = "POR_FECHAS" Then
  	w_bitacoras.title = "REPORTE BITÁCORA HISTÓRICO POR FECHAS"	 
  	em_fecha_inicio.visible		=	True
  	em_fecha_inicio.enabled	=	True
  	em_fecha_final.visible	=	True
  	em_fecha_final.enabled	=	True
  	st_1.visible	= True
  	st_2.visible	= True
  	rr_1.visible	= True
  	rr_2.visible	= True
//  	w_bitacoras.uo_cap_periodo.visible = False
//  	w_bitacoras.uo_cap_periodo.enabled = False
  	st_fecha.visible = True
  	st_periodo_año.visible = False
  	dw_bitacora.visible = True
  	dw_bitacora.enabled = True
  	dw_bitacora_periodo.visible = False
  	dw_bitacora_periodo.enabled = False
  	dw_bitacora.height = 1350
  em_fecha_inicio.setfocus()
End If     

If Parametro = "POR_PERIODO" Then
  	w_bitacoras.title = "REPORTE BITÁCORA HISTÓRICO POR PERIODO"	 
  	em_fecha_inicio.visible = False
  	em_fecha_inicio.enabled = False
  	em_fecha_final.visible = False
  	em_fecha_final.enabled = False
  	st_1.visible = False
  	st_2.visible = False
  	rr_1.visible = False
  	rr_2.visible = False
  	w_bitacoras.uo_cap_periodo.visible = True
  	w_bitacoras.uo_cap_periodo.enabled = True 
  	st_fecha.visible = False
  	st_periodo_año.visible = True
  	dw_bitacora.visible = False
  	dw_bitacora.enabled = False
  	dw_bitacora_periodo.visible = True
  	dw_bitacora_periodo.enabled = True
  	dw_bitacora_periodo.x = 28
  	dw_bitacora_periodo.y = 297
  	dw_bitacora_periodo.height = 1350
  	st_periodo_año.x = 1180 
  	st_periodo_año.y = 21
  	w_bitacoras.uo_cap_periodo.x = 46
  	w_bitacoras.uo_cap_periodo.y = 137
End If     
end event

event close;//close(this)
end event

type cbx_todos from checkbox within w_bitacoras
int X=2161
int Y=160
int Width=336
int Height=77
string Text="TODOS"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=10789024
int TextSize=-12
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.checked  then
//   w_bitacoras.uo_cap_periodo.visible = False
  	w_bitacoras.uo_cap_periodo.enabled = False
else	  
  	w_bitacoras.uo_cap_periodo.enabled = true
end if
end event

type st_periodo_año from statictext within w_bitacoras
int X=2582
int Y=16
int Width=571
int Height=80
boolean Enabled=false
string Text="PERIODO   AÑO"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=41943040
long BorderColor=8388608
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_cap_periodo from uo_periodo within w_bitacoras
int X=2512
int Y=115
int Height=170
int TabOrder=10
BorderStyle BorderStyle=StyleRaised!
end type

on uo_cap_periodo.destroy
call uo_periodo::destroy
end on

type dw_bitacora_periodo from datawindow within w_bitacoras
int X=33
int Y=1069
int Width=3449
int Height=749
int TabOrder=40
string DataObject="dw_bitacora_periodo"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;dw_bitacora_periodo.object.fecha_hoy.text = Mid(fecha_espaniol_servidor(gtr_sce),1,11)
end event

event retrieveend;// Se asigna el digito verificador a una columna auxiliar, "cve_movimiento".
// pero esto es solo hasta que el retrieve del data window termina para que la 
// asignacion no afecte a otras columnas. Ver codigo del query del data window.
// Juan Campos. febrero-1997


Integer Contador,Renglon
long    CuentaInt
Char    Digito

primeravez = True 

FOR Contador = 1 To RowCount()
  SetRow(Contador)		
  CuentaInt = GetItemNumber(GetRow(),1)  
  Digito = obten_digito(CuentaInt)  
  SetItem(Contador,2,Integer(Digito))
NEXT
 
dw_bitacora_periodo.SetRow(1)
dw_bitacora_periodo.ScrollToRow(dw_bitacora.GetRow())  
dw_bitacora_periodo.SetRowFocusIndicator(Hand!)  


 
end event

event rowfocuschanged;// Juan Campos. Marzo-1997.

if not primeravez then

dw_bitacora_periodo.SetRow(dw_bitacora.GetRow())
dw_bitacora_periodo.ScrollToRow(dw_bitacora.GetRow())  
dw_bitacora_periodo.SetRowFocusIndicator(Hand!)     

end if


end event

type em_fecha_final from editmask within w_bitacoras
int X=1488
int Y=154
int Width=439
int Height=93
int TabOrder=20
Alignment Alignment=Center!
string Mask="dd/mm/yyyy"
MaskDataType MaskDataType=DateTimeMask!
string DisplayData=""
long BackColor=15793151
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;
If em_fecha_final.text = "" Then 
  em_fecha_final.setfocus() 
Else
  em_fecha_final.setfocus()
  m_bitacoras.m_reporte.show()
End If
end event

event losefocus;// 	Se incrementa en uno el dia. Esto es un truco para que el between tome el rango
// 	de la fecha correctamente.
// 	Ejemplo:  
//  	Rango  '18-02-97' Between '20-02-97'    Error. Si existen datos con estas fechas nos 
//                                                 trae del '18-02-97' al '19-02-97'. 
//
//  	Rango  ´18-02-97  Between '20-02-97' + Un Dia  Ok Rango Correcto nos trae del '18-02-97' al '20-02-97'. 
// 	Juan Campos. Febrero 1997.

String  	Dia, Mes, Año
Integer 	DiaEntero
 
//Dia       		= Mid(em_fecha_auxiliar.text, 1, 2)
//Mes       		= Mid(em_fecha_auxiliar.text, 4, 2)
//Año       		= Mid(em_fecha_auxiliar.text, 7, 2)
//DiaEntero 	= Integer(Dia) + 1
//Dia       		= String(DiaEntero)
//
//em_fecha_final.text = Dia + "-" + Mes +"-"+ año


end event

type st_fecha from statictext within w_bitacoras
int X=1178
int Y=19
int Width=1130
int Height=80
boolean Enabled=false
string Text="FECHA VALIDA: DIA-MES-AÑO"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=41943040
long BorderColor=15793151
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_bitacoras
int X=1090
int Y=154
int Width=406
int Height=93
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Fecha_Final"
boolean FocusRectangle=false
long BackColor=12632256
long BorderColor=8388608
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_bitacoras
int X=59
int Y=154
int Width=406
int Height=93
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Fecha_Inicio:"
boolean FocusRectangle=false
long BackColor=12632256
long BorderColor=8388608
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_fecha_inicio from editmask within w_bitacoras
int X=453
int Y=154
int Width=439
int Height=93
int TabOrder=30
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="dd/mm/yyyy"
MaskDataType MaskDataType=DateTimeMask!
string DisplayData=""
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

event getfocus;em_fecha_inicio.selecttext(1,len(em_fecha_inicio.text))
end event

type dw_bitacora from datawindow within w_bitacoras
int X=26
int Y=291
int Width=3449
int Height=749
int TabOrder=50
string DataObject="dw_bitacora"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;dw_bitacora.object.fecha_hoy.text = Mid(fecha_espaniol_servidor(gtr_sce),1,11)


end event

event retrieveend;// Se asigna el digito verificador a una columna auxiliar, "cve_movimiento".
// pero esto es solo hasta que el retrieve del data window termina para que la 
// asignacion no afecte a otras columnas. Ver codigo del query del data window.
// Juan Campos. febrero-1997


Integer 	Contador,Renglon
long    	CuentaInt
Char    	Digito

primeravez = True 

FOR Contador = 1 To RowCount()
  	SetRow(Contador)		
  	CuentaInt = GetItemNumber(GetRow(),1)  
  	Digito = obten_digito(CuentaInt)  
  	SetItem(Contador,2,Integer(Digito))
NEXT
 
dw_bitacora.SetRow(1)
dw_bitacora.ScrollToRow(dw_bitacora.GetRow())  
dw_bitacora.SetRowFocusIndicator(Hand!) 


end event

event rowfocuschanged; // Juan Campos. Marzo-1997.

if not primeravez then
	dw_bitacora.SetRow(dw_bitacora.GetRow())
	dw_bitacora.ScrollToRow(dw_bitacora.GetRow())  
	dw_bitacora.SetRowFocusIndicator(Hand!)     
end if


end event

type rr_1 from roundrectangle within w_bitacoras
int X=48
int Y=138
int Width=889
int Height=125
boolean Enabled=false
int LineThickness=3
int CornerHeight=42
int CornerWidth=40
long LineColor=16777215
long FillColor=12632256
end type

type rr_2 from roundrectangle within w_bitacoras
int X=1064
int Y=138
int Width=889
int Height=125
boolean Enabled=false
int LineThickness=3
int CornerHeight=42
int CornerWidth=40
long LineColor=16777215
long FillColor=12632256
end type

