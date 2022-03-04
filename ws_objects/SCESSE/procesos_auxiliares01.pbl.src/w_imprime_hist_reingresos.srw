$PBExportHeader$w_imprime_hist_reingresos.srw
forward
global type w_imprime_hist_reingresos from Window
end type
type cb_2 from commandbutton within w_imprime_hist_reingresos
end type
type cb_1 from commandbutton within w_imprime_hist_reingresos
end type
type st_1 from statictext within w_imprime_hist_reingresos
end type
type uo_cap_periodo from uo_periodo within w_imprime_hist_reingresos
end type
type dw_imprime_reingresos from datawindow within w_imprime_hist_reingresos
end type
end forward

global type w_imprime_hist_reingresos from Window
int X=5
int Y=84
int Width=3630
int Height=1868
boolean TitleBar=true
string Title="REPORTE CAMBIOS DE REINGRESOS"
long BackColor=10789024
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_2 cb_2
cb_1 cb_1
st_1 st_1
uo_cap_periodo uo_cap_periodo
dw_imprime_reingresos dw_imprime_reingresos
end type
global w_imprime_hist_reingresos w_imprime_hist_reingresos

type variables
Integer contador
end variables

on w_imprime_hist_reingresos.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.uo_cap_periodo=create uo_cap_periodo
this.dw_imprime_reingresos=create dw_imprime_reingresos
this.Control[]={this.cb_2,&
this.cb_1,&
this.st_1,&
this.uo_cap_periodo,&
this.dw_imprime_reingresos}
end on

on w_imprime_hist_reingresos.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.uo_cap_periodo)
destroy(this.dw_imprime_reingresos)
end on

event open;// Juan Campos. Abril-1997.

this.x = 1
this.y = 1


uo_cap_periodo.ddlb_periodo.setfocus()

end event

type cb_2 from commandbutton within w_imprime_hist_reingresos
int X=1755
int Y=188
int Width=489
int Height=120
int TabOrder=2
string Text="Imprime Reporte"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// Juan Campos Sánchez.   Mayo-1998.

If dw_imprime_reingresos.RowCount() > 0 Then
	dw_imprime_reingresos.Print()
Else
	Messagebox("No hay datos para imprimir","")
End If
end event

type cb_1 from commandbutton within w_imprime_hist_reingresos
int X=1097
int Y=188
int Width=471
int Height=120
int TabOrder=10
string Text="Genera Reporte"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// Juan Campos Sánchez. Mayo-1998.

If dw_imprime_reingresos.Retrieve(uo_cap_periodo.año,uo_cap_periodo.periodo) <= 0 then
	MessageBox("No se encontro información con esté periodo","intenta con otro periodo")
End if

end event

type st_1 from statictext within w_imprime_hist_reingresos
int X=119
int Y=56
int Width=681
int Height=84
boolean Enabled=false
string Text="PERIODO        AÑO"
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=10789024
long BorderColor=8388608
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_cap_periodo from uo_periodo within w_imprime_hist_reingresos
int X=50
int Y=164
int Height=172
int TabOrder=20
end type

on uo_cap_periodo.destroy
call uo_periodo::destroy
end on

type dw_imprime_reingresos from datawindow within w_imprime_hist_reingresos
int X=14
int Y=372
int Width=3520
int Height=1244
int TabOrder=30
string DataObject="dw_imprime_reingresos"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;this.SetTransObject(gtr_sce)
object.fecha_hoy.text = Mid(fecha_espaniol_servidor(gtr_sce),1,11)

end event

event retrieveend;// OBSOLETO.  Juan campos mayo-1998.

// Se asigna el digito verificador a una columna auxiliar,  
// pero esto es solo hasta que el retrieve del data window termina para que la 
// asignacion no afecte a otras columnas. Ver codigo del query del data window.
// Juan Campos. Abril-1997
//
//
//Integer l_Contador,Renglon
//long    CuentaInt
//Char    Digito
//
//FOR l_Contador = 1 To RowCount()
//  SetRow(l_Contador)		
//  CuentaInt = GetItemNumber(GetRow(),1)  
//  Digito = obten_digito(CuentaInt)  
//  SetItem(l_Contador,2,Integer(Digito))
//NEXT
//
end event

