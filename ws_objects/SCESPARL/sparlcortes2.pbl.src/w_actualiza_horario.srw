$PBExportHeader$w_actualiza_horario.srw
forward
global type w_actualiza_horario from w_ancestral
end type
type cb_1 from commandbutton within w_actualiza_horario
end type
type cb_2 from commandbutton within w_actualiza_horario
end type
type dw_deptos from datawindow within w_actualiza_horario
end type
type dw_act_hor from datawindow within w_actualiza_horario
end type
type uo_1 from uo_per_ani within w_actualiza_horario
end type
type rb_abiertos from radiobutton within w_actualiza_horario
end type
type st_1 from statictext within w_actualiza_horario
end type
end forward

global type w_actualiza_horario from w_ancestral
int Width=3233
int Height=1645
cb_1 cb_1
cb_2 cb_2
dw_deptos dw_deptos
dw_act_hor dw_act_hor
uo_1 uo_1
rb_abiertos rb_abiertos
st_1 st_1
end type
global w_actualiza_horario w_actualiza_horario

forward prototypes
public function integer actualiza_horario_departamento (integer cve_depto, string departamento)
public function integer agrega_encabezado (string depato)
public function string quitaespacios (string conespacios)
end prototypes

public function integer actualiza_horario_departamento (integer cve_depto, string departamento);int li_cond
if rb_abiertos.checked then
	li_cond=1
else
	li_cond=0
end if
dw_act_hor.retrieve(cve_depto,gi_periodo,gi_anio,li_cond)
int li_i,li_j,li_IntNull
String ls_MyNull
SetNull(ls_MyNull)
SetNull(li_IntNull)
string ls_cve_mat_gpo1,ls_cve_mat_gpo2
li_i = 1
if dw_act_hor.RowCount() > 0 then
	ls_cve_mat_gpo1 = dw_act_hor.GetItemString(li_i,1)
	for li_i = 2 to dw_act_hor.RowCount()
		ls_cve_mat_gpo2 = dw_act_hor.GetItemString(li_i,1)
		if ls_cve_mat_gpo1 = ls_cve_mat_gpo2 then
			dw_act_hor.SetItem(li_i,2,li_IntNull)
			for li_j = 3 to 6
				dw_act_hor.SetItem(li_i,li_j,ls_MyNull)
			next
		else
			ls_cve_mat_gpo1 = ls_cve_mat_gpo2
		end if
	next
dw_act_hor.SaveAs("C:\Horarios2\tmp.htm"/*+departamento+".htm"*/, HTMLTable!, FALSE)
agrega_encabezado(departamento);
end if
return 0
end function

public function integer agrega_encabezado (string depato);int li_cabeza_1, li_cabeza_2, li_pies, li_total, li_tmp
blob lblb_MyBlob
string ls_underpato
ls_underpato = QuitaEspacios(depato)
st_1.text = "Agregando encabezado: "+depato
li_total = FileOpen("C:\Horarios\"+ls_underpato+".htm", StreamMode!, Write!, LockWrite!, Replace!)
li_cabeza_1 = FileOpen("C:\Horarios2\cab1.htm",StreamMode!, Read!)
FileRead(li_cabeza_1,lblb_MyBlob)
FileWrite(li_total,lblb_MyBlob)
FileClose(li_cabeza_1)
FileWrite(li_total,depato)
li_cabeza_2 = FileOpen("C:\Horarios2\cab2.htm",StreamMode!, Read!)
FileRead(li_cabeza_2,lblb_MyBlob)
FileWrite(li_total,lblb_MyBlob)
FileClose(li_cabeza_2)
li_tmp = FileOpen("C:\Horarios2\tmp.htm",StreamMode!, Read!)
do while FileRead(li_tmp,lblb_MyBlob) > 0
	FileWrite(li_total,lblb_MyBlob)
loop
FileClose(li_tmp)
li_pies = FileOpen("C:\Horarios2\pies.htm",StreamMode!, Read!)
FileRead(li_pies,lblb_MyBlob)
FileWrite(li_total,lblb_MyBlob)
FileClose(li_pies)
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

on w_actualiza_horario.create
int iCurrent
call w_ancestral::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_deptos=create dw_deptos
this.dw_act_hor=create dw_act_hor
this.uo_1=create uo_1
this.rb_abiertos=create rb_abiertos
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_1
this.Control[iCurrent+2]=cb_2
this.Control[iCurrent+3]=dw_deptos
this.Control[iCurrent+4]=dw_act_hor
this.Control[iCurrent+5]=uo_1
this.Control[iCurrent+6]=rb_abiertos
this.Control[iCurrent+7]=st_1
end on

on w_actualiza_horario.destroy
call w_ancestral::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_deptos)
destroy(this.dw_act_hor)
destroy(this.uo_1)
destroy(this.rb_abiertos)
destroy(this.st_1)
end on

event open;call super::open;dw_act_hor.settransobject(gtr_sce)
dw_deptos.settransobject(gtr_sce)
end event

type cb_1 from commandbutton within w_actualiza_horario
event clicked pbm_bnclicked
int X=1057
int Y=45
int Width=778
int Height=101
int TabOrder=30
string Text="Genera Archivo de Horarios"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;text = "trabajando. . ."
dw_deptos.retrieve()
int li_i
int li_cond

if rb_abiertos.checked then
	li_cond=1
else
	li_cond=0
end if

for li_i=1 to dw_deptos.RowCount()
	st_1.text = String(li_i)+"  Escribiendo Archivo del depto:"+&
					String(dw_deptos.GetItemNumber(li_i,1))+"  "+dw_deptos.GetItemString(li_i,2)
	dw_act_hor.retrieve(dw_deptos.GetItemNumber(li_i,1),gi_periodo,gi_anio,li_cond)

	if dw_act_hor.RowCount() > 0 then
		dw_act_hor.SaveAs("C:\HorariosTexto\"+dw_deptos.GetItemString(li_i,2)+".txt", Text! , TRUE)
	end if
next
text = "Genera Archivo de Horarios"
end event

type cb_2 from commandbutton within w_actualiza_horario
event clicked pbm_bnclicked
int X=398
int Y=45
int Width=599
int Height=101
int TabOrder=40
string Text="Actualiza Horarios"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;text = "trabajando. . ."
dw_deptos.retrieve()
int li_i
for li_i=1 to dw_deptos.RowCount()
	st_1.text = String(li_i)+"  Actualizando depto:"+&
					String(dw_deptos.GetItemNumber(li_i,1))+"  "+dw_deptos.GetItemString(li_i,2)
	actualiza_horario_departamento(dw_deptos.GetItemNumber(li_i,1),dw_deptos.GetItemString(li_i,2))
next
text = "Actualiza Horario"
end event

type dw_deptos from datawindow within w_actualiza_horario
event constructor pbm_constructor
int X=1537
int Y=193
int Width=718
int Height=105
int TabOrder=10
boolean Visible=false
string DataObject="d_coordinacion"
boolean LiveScroll=true
end type

type dw_act_hor from datawindow within w_actualiza_horario
event constructor pbm_constructor
int X=161
int Y=629
int Width=2844
int Height=893
int TabOrder=20
string DataObject="d_actualiza_horario"
boolean LiveScroll=true
end type

type uo_1 from uo_per_ani within w_actualiza_horario
int X=279
int Y=425
int TabOrder=11
boolean Enabled=true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type rb_abiertos from radiobutton within w_actualiza_horario
int X=1811
int Y=469
int Width=302
int Height=77
boolean BringToTop=true
string Text="Abiertos"
boolean LeftText=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_actualiza_horario
int X=394
int Y=201
int Width=2437
int Height=97
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

