$PBExportHeader$w_baja_materias.srw
forward
global type w_baja_materias from Window
end type
type st_nombre_materia from statictext within w_baja_materias
end type
type uo_nombre from uo_nombre_alumno within w_baja_materias
end type
type cb_baja_materia from commandbutton within w_baja_materias
end type
type dw_baja_materia from datawindow within w_baja_materias
end type
end forward

global type w_baja_materias from Window
int X=832
int Y=360
int Width=3410
int Height=1768
boolean TitleBar=true
string Title="BAJA DE MATERIAS"
string MenuName="m_movimientos_historico"
long BackColor=27291696
boolean ControlMenu=true
event reset ( )
st_nombre_materia st_nombre_materia
uo_nombre uo_nombre
cb_baja_materia cb_baja_materia
dw_baja_materia dw_baja_materia
end type
global w_baja_materias w_baja_materias

type variables
window EstaVentana
boolean Enter
end variables

event reset;// Juan Campos Sánchez.   Feb-1998.
EstaVentana.SetRedraw(False)
st_nombre_materia.text =""
dw_baja_materia.Reset()		
dw_baja_materia.InsertRow(0)
cb_baja_materia.Enabled = False
EstaVentana.SetRedraw(True)

end event

on w_baja_materias.create
if this.MenuName = "m_movimientos_historico" then this.MenuID = create m_movimientos_historico
this.st_nombre_materia=create st_nombre_materia
this.uo_nombre=create uo_nombre
this.cb_baja_materia=create cb_baja_materia
this.dw_baja_materia=create dw_baja_materia
this.Control[]={this.st_nombre_materia,&
this.uo_nombre,&
this.cb_baja_materia,&
this.dw_baja_materia}
end on

on w_baja_materias.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_nombre_materia)
destroy(this.uo_nombre)
destroy(this.cb_baja_materia)
destroy(this.dw_baja_materia)
end on

event open;// Baja de materias.
// Juan Campos Sánchez.		Febrero-1998.
// Versión 2.0

This.x=1
This.y=1

EstaVentana = This
cb_baja_materia.Enabled = False
uo_nombre.em_cuenta.SetFocus()
end event

event doubleclicked;// Juan Campos Sánchez.	Feb-1998.

Long  Cuenta

This.TriggerEvent("Reset")
Cuenta = long(uo_nombre.em_cuenta.text)
IF cuenta = 0  Then
	dw_baja_materia.Enabled = False
Else
	dw_baja_materia.Enabled = True
	dw_baja_materia.Setfocus()
End If

 
end event

type st_nombre_materia from statictext within w_baja_materias
int X=87
int Y=480
int Width=2533
int Height=92
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="none"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=15793151
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_nombre from uo_nombre_alumno within w_baja_materias
int X=87
int Y=36
int TabOrder=10
boolean Enabled=true
end type

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

type cb_baja_materia from commandbutton within w_baja_materias
event key pbm_keydown
int X=2706
int Y=1020
int Width=389
int Height=108
int TabOrder=30
string Text="Baja Materia"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event key;if keydown(keyenter!) Then This.EVENT Clicked()
end event

event clicked;// Juan Campos Sánchez. 
// Versión 2.0. 	Feb-1998.

long		Cuenta
long materia
IF dw_baja_materia.RowCount() > 0 Then
	Cuenta	= Long(uo_nombre.em_cuenta.text)
	Materia	= dw_baja_materia.GetItemNumber(dw_baja_materia.GetRow(),"historico_cve_mat")	
	If Messagebox("Esta seleccionada la materia correcta","Confirma si deseas borrarla",Question!,YesNo!,1) = 1 Then
		IF dw_baja_materia.DeleteRow(dw_baja_materia.GetRow()) = 1 And &
			dw_baja_materia.Update(True,True) = 1 Then
				Commit Using gtr_sce;     
				dw_baja_materia.Retrieve(Cuenta,Materia)
  	 			MessageBox("Aviso","La baja de materia fue realizada")		 
	 			IF Materia = 4078 Then 
					IF not act_bandera_prerreq_ingles(Cuenta,"NA") Then
        				Messagebox("Atención","La bandera de prerrequisito de ingles NO se actualizo")		  
	   			End IF
				End If
         	IF Not actualiza_bandera(Cuenta,0) Then
           		Messagebox("ATENCIÓN","Los catálogos Banderas de bloqueos de servicios escolares, NO se actualizaron")
           		MessageBox("IMPORTANTE","Revisar Banderas de bloqueos del alumno, en sus respectivos catálogos")		  	  
         	End IF		    
		Else
			Rollback Using gtr_sce;
			Messagebox("Algunos datos son incorrectos","La baja no fue realizada")
			dw_baja_materia.Retrieve(Cuenta,Materia)
		End IF
	End IF
Else
	Rollback Using gtr_sce;
	Messagebox("No hay una materia para borrar","")
End If
w_baja_materias.TriggerEvent("Reset")				
uo_nombre.em_cuenta.Setfocus()
 

		


end event

type dw_baja_materia from datawindow within w_baja_materias
event key pbm_dwnkey
int X=87
int Y=588
int Width=2519
int Height=972
int TabOrder=20
string DataObject="dw_baja_materia"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event key;if key = keyEnter! Then
	Enter = True
	if parent.cb_baja_materia.enabled = true then parent.cb_baja_materia.event clicked()
Else
	Enter = False
End if


end event

event constructor;dw_baja_materia.settransobject(gtr_sce)
end event

event rowfocuschanged;// Juan Campos Sánchez.	 Febrero-1998.

If Enter Then
	SetRow(1)
	SetRowFocusIndicator(Hand!)  
	ScrollToRow(1)  	
Else
	SetRow(GetRow())
	SetRowFocusIndicator(Hand!)  
	ScrollToRow(GetRow())  
End If

end event

event itemchanged;// Juan Campos Sánchez. Feb-1998.
Long Materia

Accepttext()
Materia = GetItemNumber(GetRow(),"historico_cve_mat")
If Retrieve(Long(uo_nombre.em_cuenta.text),Materia) = 0 Then
	MessageBox("Aviso","El Alumno no tiene registrada esta materia")
   w_baja_materias.triggerEvent("Reset")
	cb_baja_materia.Enabled = False
Else
	Select materia Into :st_nombre_materia.text From materias
	Where cve_mat =:Materia using gtr_sce;
	cb_baja_materia.Enabled = True
End If
 
end event

