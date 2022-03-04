$PBExportHeader$w_salones.srw
forward
global type w_salones from Window
end type
type dw_salon_horario from datawindow within w_salones
end type
type cbx_nuevo from checkbox within w_salones
end type
type dw_salon from datawindow within w_salones
end type
type rr_1 from roundrectangle within w_salones
end type
end forward

global type w_salones from Window
int X=800
int Y=224
int Width=3168
int Height=1452
boolean TitleBar=true
string Title="Salones"
string MenuName="m_salones"
long BackColor=10789024
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_salon_horario dw_salon_horario
cbx_nuevo cbx_nuevo
dw_salon dw_salon
rr_1 rr_1
end type
global w_salones w_salones

type variables

end variables

forward prototypes
public function boolean inserta_salon_horario (string salon)
end prototypes

public function boolean inserta_salon_horario (string salon);// Inserta en la tabla salon_horario los los renglones correspondientes
// para un salon nuevo. ejemplo salon XXX  dia Lunes hora-inicio 7 ocupado = 0. 
// Para todos los dias de la semana y en todas las horas de inicio (lunes a viernes y de 7 a 21 hrs)
// Regresa true si es exitosa la actualización.
// Juan Campos Sánchez.		Enero-1998.

Integer Dia,HoraInicio,Renglon
if dw_salon_horario.Rowcount() = 0 then
	FOR Dia = 1 TO 6
		FOR HoraInicio = 7 TO 21
			Renglon = dw_salon_horario.InsertRow(0)
			dw_salon_horario.SetItem(Renglon,"cve_salon",Salon)
			dw_salon_horario.SetItem(Renglon,"cve_dia",Dia)
			dw_salon_horario.SetItem(Renglon,"hora_inicio",HoraInicio)
			dw_salon_horario.SetItem(Renglon,"ocupado",0)
		NEXT	
	NEXT
	
	IF dw_salon_horario.Update(True,True) = 1 Then
		Return True
	Else
		Rollback using gtr_sce;
		Messagebox("Algunos Datos Son Incorrectos","Verifique que no haya información para esté salón en la tabla salon_horario")
		return false
	End if
end if
return true

end function

event open;// Original: Carlos Melgoza Piña.
// Modificado y corregido : Juan Campos Sánchez.  Agosto-1997- Enero-1998.

//g_nv_security.fnv_secure_window (this)

dw_salon.settransobject(gtr_sce)
dw_salon.insertrow(0)
//em_cvsalon.setfocus()
//dw_salon.enabled = False
/**/gnv_app.inv_security.of_SetSecurity(this)


end event

on w_salones.create
if this.MenuName = "m_salones" then this.MenuID = create m_salones
this.dw_salon_horario=create dw_salon_horario
this.cbx_nuevo=create cbx_nuevo
this.dw_salon=create dw_salon
this.rr_1=create rr_1
this.Control[]={this.dw_salon_horario,&
this.cbx_nuevo,&
this.dw_salon,&
this.rr_1}
end on

on w_salones.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_salon_horario)
destroy(this.cbx_nuevo)
destroy(this.dw_salon)
destroy(this.rr_1)
end on

event close;Rollback using gtr_sce;
end event

type dw_salon_horario from datawindow within w_salones
int X=777
int Y=880
int Width=1349
int Height=364
boolean Visible=false
boolean Enabled=false
string DataObject="dw_salon_horario"
boolean TitleBar=true
string Title="Salon horario para salones nuevos"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event constructor;dw_salon_horario.SetTransObject(gtr_sce)
end event

type cbx_nuevo from checkbox within w_salones
int X=178
int Y=44
int Width=315
int Height=76
string Text="Nuevo"
BorderStyle BorderStyle=StyleRaised!
boolean LeftText=true
long BackColor=10789024
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_salon.setredraw(False)
//cbx_nuevo.checked=True
dw_salon.reset()
dw_salon.Insertrow(0)
dw_salon.SetFocus()
dw_salon.setredraw(True)


end event

type dw_salon from datawindow within w_salones
event actualiza ( )
event borra ( )
event primero ( )
event anterior ( )
event siguiente ( )
event ultimo ( )
int X=123
int Y=176
int Width=2825
int Height=672
int TabOrder=10
string DataObject="dw_salon"
boolean Border=false
boolean LiveScroll=true
end type

event actualiza;// Juan Campos Sánchez.      Enero-1998.
String Salon

IF dw_salon.rowcount() > 0 Then
	Salon = GetItemString(GetRow(),"cve_salon")
	If Inserta_Salon_Horario(Salon) And dw_salon.Update(True,True) = 1 Then		
		Commit using gtr_sce;
		messagebox("Aviso","Se han guardado los cambios")			
	Else
		Rollback using gtr_sce;
		Messagebox("Aviso","Algunos datos están incorrectos, favor de corregirlos")	
	End if
Else
	Messagebox("Aviso","No hay datos para guardar")			
End if
cbx_nuevo.checked = False

end event

event borra;// Juan Campos Sánchez		Enero-1998.
String	Salon

This.setredraw(False)

if Messagebox("Atención","Esta seguro de querer borrar el campo actual.",StopSign!,YesNo!,2) = 1 Then
	Accepttext()
	Salon = GetItemString(getrow(),"cve_salon")
	Delete salon_horario where cve_salon = :Salon Using gtr_sce;
	IF gtr_sce.sqlcode = 0 Then	
		IF This.deleterow(getrow()) = 1 Then
	   	IF This.DeletedCount( ) > 0 Then
 				IF This.Update(True,True) = 1 Then
					Commit using gtr_sce;
					Messagebox("Aviso","Se han guardado los cambios")			
					This.insertrow(0)
 				Else
					Rollback using gtr_sce;
					Messagebox("Aviso","Algunos datos están incorrectos, favor de corregirlos")	
				End if		
	   	Else
				Messagebox("Información","No hay datos para guardar")	
 	   	End if
 		Else
			Rollback using gtr_sce;
			Messagebox("Información","No se han guardado los cambios")	
		End if
	Else
		Rollback using gtr_sce;
		Messagebox("No se guardaron los cambios","El Salón en La Tabla de salon_horario no fue borrado")	
	End if
Else
	Rollback using gtr_sce;
End if

This.setredraw(True)
end event

event primero; // Juan Campos.       Junio-1997.

String Salon

Select  Min(cve_salon) Into :Salon From salon using gtr_sce;
Setitem(Getrow(),"cve_salon",Salon)
This.TriggerEvent(Itemchanged!)

 

end event

event anterior;// Juan Campos.       Junio-1997.

String salon

Accepttext()
Salon = GetItemString(GetRow(),"cve_salon")
Select Max(cve_salon) Into :salon From salon  Where cve_salon < :Salon using gtr_sce;
If Not Isnull(salon)  Then	 
	SetItem(GetRow(),"cve_salon",Salon)
	AcceptText()
	This.Triggerevent(ItemChanged!)
Else
	messagebox("Aviso","Este es el primer salon")
End if
	 

	 

end event

event siguiente;// Juan Campos.       Junio-1997.

String salon

Accepttext()
Salon = GetItemString(GetRow(),"cve_salon")
Select Min(cve_salon) Into :salon From salon  Where cve_salon > :Salon using gtr_sce;
If Not Isnull(salon)  Then	 
	SetItem(GetRow(),"cve_salon",Salon)
	AcceptText()
	This.Triggerevent(ItemChanged!)
Else
	Messagebox("Aviso","Este es el último salon")
End if

end event

event ultimo; // Juan Campos.       Junio-1997.

String Salon

Select  Max(cve_salon) Into :Salon From salon using gtr_sce;
Setitem(Getrow(),"cve_salon",Salon)
This.TriggerEvent(Itemchanged!)

end event

event constructor;m_salones.dw = this
end event

event itemchanged;// Juan Campos Sánchez.      Enero-1998.

String	Columna,Salon

Accepttext()
Columna = GetColumnName()
dw_salon.setredraw(False)
Choose Case Columna	
Case "cve_salon"
	Salon = GetItemString(GetRow(),"cve_salon")	
	If cbx_nuevo.checked Then
		If dw_salon.retrieve(salon) > 0 Then
			Messagebox("Aviso","El salón con clave "+salon+" Ya existe.~rFavor de verificar.",stopsign!)
			SetColumn("cve_salon")
			cbx_nuevo.checked = False		
		Else
			dw_salon.Reset()
			dw_salon.InsertRow(0)				
			SetItem(GetRow(),"cve_salon",Salon)
		   Accepttext()
			SetColumn("bloqueado")
		End IF
	Else
		If dw_salon.retrieve(salon) = 0 Then
			Messagebox("Aviso","El salón con clave "+salon+" No existe.~rFavor de verificar.",stopsign!)
			dw_salon.reset()
			dw_salon.InsertRow(0)
		else
			dw_salon_horario.retrieve(salon)
		End if
 	End If	
Case "cupo_max"
	If getitemnumber(getrow(),"cupo_max") < getitemnumber(getrow(),"cupo") then
		Return 1
	End If
Case "cupo"
	If getitemnumber(getrow(),"cupo_max") < getitemnumber(getrow(),"cupo") then
		Return 1
	End If		
End Choose
dw_salon.setredraw(True)

	
 
end event

type rr_1 from roundrectangle within w_salones
int X=123
int Y=28
int Width=425
int Height=112
boolean Enabled=false
int LineThickness=4
int CornerHeight=44
int CornerWidth=41
long LineColor=16777215
long FillColor=10789024
end type

