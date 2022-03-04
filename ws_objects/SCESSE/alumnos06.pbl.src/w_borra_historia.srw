$PBExportHeader$w_borra_historia.srw
forward
global type w_borra_historia from Window
end type
type cb_borra_historia from commandbutton within w_borra_historia
end type
type uo_nombre from uo_nombre_alumno within w_borra_historia
end type
type dw_borra_historia from datawindow within w_borra_historia
end type
end forward

global type w_borra_historia from Window
int X=832
int Y=360
int Width=3607
int Height=1816
boolean TitleBar=true
string Title="Borra Historia Académica"
string MenuName="m_movimientos_historico"
long BackColor=27291696
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_borra_historia cb_borra_historia
uo_nombre uo_nombre
dw_borra_historia dw_borra_historia
end type
global w_borra_historia w_borra_historia

type variables
Window EstaVentana
Int carrera,plan
end variables

event open;// Juan Campos Sánchez.
// Versión 2.0.   Feb-1998.

This.x=1
This.y=1

EstaVentana = This

uo_nombre.em_cuenta.setfocus()


end event

on w_borra_historia.create
if this.MenuName = "m_movimientos_historico" then this.MenuID = create m_movimientos_historico
this.cb_borra_historia=create cb_borra_historia
this.uo_nombre=create uo_nombre
this.dw_borra_historia=create dw_borra_historia
this.Control[]={this.cb_borra_historia,&
this.uo_nombre,&
this.dw_borra_historia}
end on

on w_borra_historia.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_borra_historia)
destroy(this.uo_nombre)
destroy(this.dw_borra_historia)
end on

event doubleclicked;// Juan Campos Sánchez.
// Vesion 2.0.	Feb-1998.

long Cuenta
Cuenta = Long(uo_nombre.em_cuenta.text)

If cuenta > 0 Then
	Select cve_carrera,cve_plan Into :Carrera,:Plan
	From academicos Where cuenta = :Cuenta Using gtr_sce;
	If gtr_sce.sqlcode = 0 Then
		If dw_borra_historia.Retrieve(Cuenta,Carrera,Plan) = 0 Then
			MessageBox("Aviso","El alumno no tiene materias en el catálogo_Histórico")
			uo_nombre.em_cuenta.Setfocus()
		Else
			cb_borra_historia.setfocus()
		End If  		
	Else
		MessageBox("Error","Al consultar la carrera y plan del alumno "+gtr_sce.sqlerrtext)
		uo_nombre.em_cuenta.Setfocus()		
	End IF
End If
 

end event

type cb_borra_historia from commandbutton within w_borra_historia
event key pbm_keydown
int X=3122
int Y=968
int Width=416
int Height=108
int TabOrder=20
string Text="Borra Historia"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event key;if keydown(keyenter!) Then This.EVENT Clicked()
end event

event clicked;// Borra de la tabla de histórico todas las materias con todos sus datos
// Excepto la materia de prerrequisito de ingles 4078
// Juan Campos. Febrero. - 1997.
// Versión 2.0.  Juan Campos Sánchez.     Feb-1998.

long    	Cuenta
int contador,contmat
Boolean  DeleteOK = True

If dw_borra_historia.RowCount() > 0 Then
	If MessageBox("Aviso","Está seguro que desea BORRAR LA HISTORIA académica de esté alumno",Question!,YesNo!,2) = 1 Then
		Cuenta = Long(uo_nombre.em_cuenta.text)
      ContMat		= dw_borra_historia.RowCount()
		For Contador = 1 To ContMat
			If dw_borra_historia.DeleteRow(1) <> 1 Then
				DeleteOK = False
				Messagebox("Ocurrio un error al borrar la historia","Intente de nuevo")
				Contador = ContMat
			End If
		Next
		If DeleteOk  Then 
			dw_borra_historia.Update()
    		Commit Using gtr_sce; 
	 		MessageBox("Aviso","La historia académica fue borrada")
    		If Not act_banderas_borrahistoria(Cuenta) then 
				rollback using gtr_sce;
      		Messagebox("ATENCIÓN","Los catálogos, Académicos, Banderas de bloqueos de servicios escolares, NO se actualizaron")
      		MessageBox("IMPORTANTE","Revisar promedio, créditos y Banderas bloqueos de servicios escolares del alumno, en sus respectivos catálogos")		  	  
			else
				commit using gtr_sce;				
    		End if
		Else	
			Rollback Using gtr_sce;
			Messagebox("Error al borrar Historia","Los cambios No fueron guardados "+gtr_sce.sqlerrtext)		
		End IF
	Else
		Rollback Using gtr_sce;
		Messagebox("Aviso","La historia académica No fue borrada")		
	End If
Else
	Rollback Using gtr_sce;
	Messagebox("No hay datos para borrar","")
End If

uo_nombre.em_cuenta.setfocus()
end event

type uo_nombre from uo_nombre_alumno within w_borra_historia
int X=27
int Y=12
int TabOrder=10
boolean Enabled=true
end type

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

type dw_borra_historia from datawindow within w_borra_historia
int X=27
int Y=444
int Width=3067
int Height=1156
string DataObject="dw_bajasborrahistoria_materias"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;dw_borra_historia.settransobject(gtr_sce)
end event

