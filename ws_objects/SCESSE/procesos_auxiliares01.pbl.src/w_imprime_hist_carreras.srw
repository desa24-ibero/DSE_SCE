$PBExportHeader$w_imprime_hist_carreras.srw
forward
global type w_imprime_hist_carreras from Window
end type
type st_1 from statictext within w_imprime_hist_carreras
end type
type uo_cap_periodo from uo_periodo within w_imprime_hist_carreras
end type
type dw_imprime_hist_carreras from datawindow within w_imprime_hist_carreras
end type
end forward

global type w_imprime_hist_carreras from Window
int X=5
int Y=4
int Width=3630
int Height=1868
boolean TitleBar=true
string Title="REPORTE CAMBIOS DE CARRERA"
long BackColor=10789024
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_1 st_1
uo_cap_periodo uo_cap_periodo
dw_imprime_hist_carreras dw_imprime_hist_carreras
end type
global w_imprime_hist_carreras w_imprime_hist_carreras

type variables
integer contador = 0
end variables

on w_imprime_hist_carreras.create
this.st_1=create st_1
this.uo_cap_periodo=create uo_cap_periodo
this.dw_imprime_hist_carreras=create dw_imprime_hist_carreras
this.Control[]={this.st_1,&
this.uo_cap_periodo,&
this.dw_imprime_hist_carreras}
end on

on w_imprime_hist_carreras.destroy
destroy(this.st_1)
destroy(this.uo_cap_periodo)
destroy(this.dw_imprime_hist_carreras)
end on

event open;// Juan Campos. Abril-1997.

this.x = 1
this.y = 1

dw_imprime_hist_carreras.SetTransObject(gtr_sce)
w_imprime_hist_carreras.uo_cap_periodo.ddlb_periodo.setfocus()
end event

event doubleclicked;// Juan Campos. Abril-1997.

Long    Job 
Integer EstasSeguro

this.x = 1
this.y = 1
SetPointer(Hourglass!)  	

if dw_imprime_hist_carreras.Retrieve(uo_cap_periodo.periodo,uo_cap_periodo.año) > 0 then
	EstasSeguro = MessageBox("Aviso","Desea imprimir esté reporte de cambios de carrera",Question!,YesNo!,1)
	if EstasSeguro = 1 then
		Job 	= PrintOpen("Reporte Cambios de carrera" ) 
  		PrintDataWindow(Job,dw_imprime_hist_carreras)  
  		PrintClose(job)
	end if
else
	MessageBox("No se encontro información con esté periodo","intente con otro periodo")
	MessageBox("Aviso","Recuerde que los cambios de carrera tienen efecto siempre para el periodo proximo")
end if

close(w_imprime_hist_carreras)
end event

event key;
if key = keyenter! or key = keytab! then
	Contador ++
	if contador >= 2 Then
		contador = 0	
		triggerevent(doubleclicked!)	
	end if
end if
end event

type st_1 from statictext within w_imprime_hist_carreras
int X=1445
int Y=64
int Width=736
int Height=88
boolean Enabled=false
string Text="PERIODO         AÑO"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=78164112
long BorderColor=8388608
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_cap_periodo from uo_periodo within w_imprime_hist_carreras
int X=1403
int Y=180
int Height=172
int TabOrder=1
end type

on uo_cap_periodo.destroy
call uo_periodo::destroy
end on

type dw_imprime_hist_carreras from datawindow within w_imprime_hist_carreras
int X=50
int Y=372
int Width=3520
int Height=1244
int TabOrder=1
string DataObject="dw_imprime_hist_carreras"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;object.fecha_hoy.text = Mid(fecha_espaniol_servidor(gtr_sce),1,11)
end event

event retrieveend;
// Se asigna el digito verificador a una columna auxiliar, "cve_movimiento".
// pero esto es solo hasta que el retrieve del data window termina para que la 
// asignacion no afecte a otras columnas. Ver codigo del query del data window.
// Juan Campos. Abril-1997


Integer l_Contador,Renglon
long    CuentaInt
Char    Digito

FOR l_Contador = 1 To RowCount()
  SetRow(l_Contador)		
  CuentaInt = GetItemNumber(GetRow(),1)  
  Digito = obten_digito(CuentaInt)  
  SetItem(l_Contador,2,Integer(Digito))
NEXT
 
 


end event

