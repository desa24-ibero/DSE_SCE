$PBExportHeader$w_actualiza_grupos_cerrados.srw
forward
global type w_actualiza_grupos_cerrados from w_ancestral
end type
type st_3 from statictext within w_actualiza_grupos_cerrados
end type
type st_2 from statictext within w_actualiza_grupos_cerrados
end type
type cb_2 from commandbutton within w_actualiza_grupos_cerrados
end type
type dw_deptos from datawindow within w_actualiza_grupos_cerrados
end type
type dw_act_gru_can from datawindow within w_actualiza_grupos_cerrados
end type
type st_1 from statictext within w_actualiza_grupos_cerrados
end type
end forward

global type w_actualiza_grupos_cerrados from w_ancestral
int Width=2992
int Height=525
boolean TitleBar=true
string Title="CORTE DE GRUPOS CERRADOS"
st_3 st_3
st_2 st_2
cb_2 cb_2
dw_deptos dw_deptos
dw_act_gru_can dw_act_gru_can
st_1 st_1
end type
global w_actualiza_grupos_cerrados w_actualiza_grupos_cerrados

type variables
int ii_Archivototal
end variables

forward prototypes
public subroutine actualiza_cabeza1 ()
public function integer actualiza_horario_departamento (integer cve_depto, string departamento)
public function integer agrega_encabezado (string depato, integer clave)
public function string quitaespacios (string conespacios)
end prototypes

public subroutine actualiza_cabeza1 ();// Juan Campos Sánchez.  Mayo-1998.

Integer li_Numfile
String ls_Fecha,ls_Ruta

ls_Ruta = "c:\windows\escritorio\"
ls_Fecha = Fecha_pc()
li_NumFile = FileOpen(ls_Ruta+"cabeza1.txt",LineMode!, Write!, LockWrite!, Replace!)
FileWrite(li_NumFile,Fill(' ',14)+"U N I V E R S I D A D   I B E R O A M E R I C A N A"+Fill(' ',4)+ls_Fecha)
FileWrite(li_NumFile,Fill(' ',75)+String(Now( ), "hh:mm"))
FileWrite(li_NumFile,Fill(' ',22)+"DIRECCION DE SERVICIOS ESCOLARES..."+Fill(' ',17)+"Hoja 1")
FileClose(li_NumFile)
st_3.text = String(today(),"dd-mmm-yyyy h:mm")

end subroutine

public function integer actualiza_horario_departamento (integer cve_depto, string departamento);String ls_Ruta = "c:\windows\escritorio\"
dw_act_gru_can.retrieve(cve_depto)
int i,j,IntNull
String MyNull
SetNull(MyNull)
SetNull(IntNull)
long cve_mat_gpo1,cve_mat_gpo2
i = 1
if dw_act_gru_can.RowCount() > 0 then
/*	cve_mat_gpo1 = dw_act_gru_can.GetItemNumber(i,1)
	for i = 2 to dw_act_gru_can.RowCount()
		cve_mat_gpo2 = dw_act_gru_can.GetItemNumber(i,1)
		if cve_mat_gpo1 = cve_mat_gpo2 then
			dw_act_gru_can.SetItem(i,2,IntNull)
			for j = 3 to 6
				dw_act_gru_can.SetItem(i,j,MyNull)
			next
		else
			cve_mat_gpo1 = cve_mat_gpo2
		end if
	next*/
dw_act_gru_can.SaveAs(ls_Ruta+"tmp.txt"/*+departamento+".htm"*/, Text!, FALSE)
departamento = mid(departamento,1,20)
agrega_encabezado(departamento,cve_depto);
end if
return 0
end function

public function integer agrega_encabezado (string depato, integer clave);int li_cabeza_1, li_cabeza_2, li_pies, li_total, li_tmp
blob lblb_MyBlob
string ls_LineaLee, ls_LineaEscribe
string ls_underpato //
String ls_Ruta = "c:\windows\escritorio\"

ls_underpato = QuitaEspacios(depato) //
st_1.text = "Agregando encabezado: "+depato
li_total = FileOpen(ls_Ruta+"Rep_inscripcion.lis"+depato+".txt", StreamMode!, Write!, LockWrite!, Replace!)
li_cabeza_1 = FileOpen(ls_Ruta+"cabeza1.txt",StreamMode!, Read!)
FileRead(li_cabeza_1,lblb_MyBlob)
FileWrite(li_total,lblb_MyBlob)
FileWrite(ii_archivototal,lblb_MyBlob)
FileClose(li_cabeza_1)
FileWrite(li_total,"                               ")
FileWrite(ii_archivototal,"                               ")
FileWrite(li_total,string(clave,"0000"))
FileWrite(ii_archivototal,string(clave,"0000"))
FileWrite(li_total," ")
FileWrite(ii_archivototal," ")
FileWrite(li_total,depato)
FileWrite(ii_archivototal,depato)
li_cabeza_2 = FileOpen(ls_Ruta+"cabeza2.txt",StreamMode!, Read!)
FileRead(li_cabeza_2,lblb_MyBlob)
FileWrite(li_total,lblb_MyBlob)
FileWrite(ii_archivototal,lblb_MyBlob)
FileClose(li_cabeza_2)
li_tmp = FileOpen(ls_Ruta+"tmp.txt",LineMode!, Read!)
do while FileRead(li_tmp,ls_LineaLee) > 0
	ls_LineaEscribe = Replace(ls_LineaLee,5,1," ")
	ls_LineaEscribe = Replace(ls_LineaEscribe,11,2,"  ")
	ls_LineaEscribe = Replace(ls_LineaEscribe,60,2,"  ")
	ls_LineaEscribe = Replace(ls_LineaEscribe,72,2,"  ")
	ls_LineaEscribe = Replace(ls_LineaEscribe,79,1,char(13))
	ls_LineaEscribe = Replace(ls_LineaEscribe,80,1,char(10))
//	AgregaLinefeed(77)
	FileWrite(li_total,ls_LineaEscribe)
	FileWrite(ii_archivototal,ls_LineaEscribe)
loop
FileClose(li_tmp)
//li_pies = FileOpen("C:\Horarios2\li_pies.htm",StreamMode!, Read!)
//FileRead(li_pies,lblb_MyBlob)
//FileWrite(li_total,char(12))
FileWrite(ii_archivototal,char(12))
FileWrite(ii_archivototal,char(13))
FileWrite(ii_archivototal,char(10))
//FileClose(li_pies)
FileClose(li_total)
return 0 
end function

public function string quitaespacios (string conespacios);long ll_start_pos=1
string ls_old_str, ls_new_str, ls_mystring

ls_mystring = Conespacios
ls_old_str = " "
ls_new_str = "_"
ll_start_pos = Pos(ls_mystring, ls_old_str, ll_start_pos)
DO WHILE ll_start_pos > 0
	ls_mystring = Replace(ls_mystring, ll_start_pos,Len(ls_old_str), ls_new_str)
	ll_start_pos = Pos(ls_mystring, ls_old_str,ll_start_pos+Len(ls_new_str))
LOOP
ll_start_pos=1
ls_old_str = "."
ll_start_pos = Pos(ls_mystring, ls_old_str, ll_start_pos)
DO WHILE ll_start_pos > 0
	ls_mystring = Replace(ls_mystring, ll_start_pos,Len(ls_old_str), ls_new_str)
	ll_start_pos = Pos(ls_mystring, ls_old_str,ll_start_pos+Len(ls_new_str))
LOOP
ll_start_pos=1
ls_old_str = ","
ll_start_pos = Pos(ls_mystring, ls_old_str, ll_start_pos)
DO WHILE ll_start_pos > 0
	ls_mystring = Replace(ls_mystring, ll_start_pos,Len(ls_old_str), ls_new_str)
	ll_start_pos = Pos(ls_mystring, ls_old_str,ll_start_pos+Len(ls_new_str))
LOOP

if len(ls_mystring) > 32 then ls_mystring = mid(ls_mystring, 1, 32)
return ls_mystring
end function

event open;call super::open;int li_i

For li_i = 1 To 3
	If Timer(1800,w_actualiza_grupos_cerrados) = -1 Then
		messagebox("Error","")
		Close(This)
	End if
Next

dw_act_gru_can.settransobject(gtr_sce)
dw_deptos.settransobject(gtr_sce)
end event

event timer;call super::timer;cb_2.event clicked()
end event

on w_actualiza_grupos_cerrados.create
int iCurrent
call super::create
this.st_3=create st_3
this.st_2=create st_2
this.cb_2=create cb_2
this.dw_deptos=create dw_deptos
this.dw_act_gru_can=create dw_act_gru_can
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.dw_deptos
this.Control[iCurrent+5]=this.dw_act_gru_can
this.Control[iCurrent+6]=this.st_1
end on

on w_actualiza_grupos_cerrados.destroy
call super::destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cb_2)
destroy(this.dw_deptos)
destroy(this.dw_act_gru_can)
destroy(this.st_1)
end on

type st_3 from statictext within w_actualiza_grupos_cerrados
int X=2267
int Y=38
int Width=658
int Height=96
boolean Enabled=false
string Text="none"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_actualiza_grupos_cerrados
int X=1755
int Y=38
int Width=512
int Height=96
boolean Enabled=false
string Text="Último corte:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_actualiza_grupos_cerrados
event clicked pbm_bnclicked
int X=402
int Y=32
int Width=841
int Height=106
int TabOrder=20
string Text="Actualiza Grupos Cancelados"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String ls_Ruta ="c:\windows\escritorio\"
 
text = "trabajando. . ."
dw_deptos.retrieve()
int in_i

Actualiza_Cabeza1()
ii_archivototal = FileOpen(ls_Ruta+"Rep_inscripcion.lis", &
                           StreamMode!, Write!, LockWrite!, Replace!)
for in_i=1 to dw_deptos.RowCount()
	st_1.text = String(in_i)+"  Actualizando depto:"+&
					String(dw_deptos.GetItemNumber(in_i,1))+"  "+dw_deptos.GetItemString(in_i,2)
	actualiza_horario_departamento(dw_deptos.GetItemNumber(in_i,1),dw_deptos.GetItemString(in_i,2))
next
FileClose(ii_archivototal)
text = "Actualiza Grupos Cerrados"


 
end event

type dw_deptos from datawindow within w_actualiza_grupos_cerrados
event constructor pbm_constructor
int X=497
int Y=522
int Width=717
int Height=106
int TabOrder=30
boolean Visible=false
string DataObject="d_coordinacion"
boolean LiveScroll=true
end type

type dw_act_gru_can from datawindow within w_actualiza_grupos_cerrados
event constructor pbm_constructor
int X=1273
int Y=490
int Width=1170
int Height=144
int TabOrder=10
boolean Visible=false
string DataObject="d_grupos_cerrados"
boolean LiveScroll=true
end type

type st_1 from statictext within w_actualiza_grupos_cerrados
int X=421
int Y=154
int Width=2436
int Height=96
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="none"
boolean FocusRectangle=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

