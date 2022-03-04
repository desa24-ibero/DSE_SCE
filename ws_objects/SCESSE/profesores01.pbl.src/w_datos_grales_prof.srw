$PBExportHeader$w_datos_grales_prof.srw
forward
global type w_datos_grales_prof from Window
end type
type dw_dgf from datawindow within w_datos_grales_prof
end type
end forward

global type w_datos_grales_prof from Window
int X=834
int Y=362
int Width=3664
int Height=842
boolean TitleBar=true
string Title="Datos Generales  Profesor"
string MenuName="m_datos_grales_prof"
long BackColor=10789024
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_dgf dw_dgf
end type
global w_datos_grales_prof w_datos_grales_prof

type variables
window EstaVentana
boolean  ib_nuevo = false
end variables

on w_datos_grales_prof.create
if this.MenuName = "m_datos_grales_prof" then this.MenuID = create m_datos_grales_prof
this.dw_dgf=create dw_dgf
this.Control[]={this.dw_dgf}
end on

on w_datos_grales_prof.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_dgf)
end on

event open;// Juan Campos Sánchez.		Noviembre-1997.

//g_nv_security.fnv_secure_window (this)

This.x = 1
This.y = 1
m_datos_grales_prof.ventana = This 

EstaVentana = This
dw_dgf.SetTransObject(gtr_sce)
dw_dgf.InsertRow(0)
/**/gnv_app.inv_security.of_SetSecurity(this)
end event

type dw_dgf from datawindow within w_datos_grales_prof
event primero ( )
event anterior ( )
event siguiente ( )
event ultimo ( )
event nuevo ( )
event actualiza ( )
event borra ( )
int Y=6
int Width=3577
int Height=973
int TabOrder=1
string DataObject="dw_datos_grales_prof"
boolean Border=false
boolean LiveScroll=true
end type

event primero;long	CveProf

Select Min(cve_profesor) Into :CveProf
From profesor using gtr_sce;

SetItem(GetRow(),"cve_profesor",CveProf)
TriggerEvent(ItemChanged!)
 

end event

event anterior;long	CveProf

Cveprof = GetItemNumber(GetRow(),"cve_profesor")

Select Max(cve_profesor) Into :CveProf
From profesor
Where cve_profesor < :Cveprof using gtr_sce;

If IsNull(CveProf) Then
	Messagebox("Aviso","Es el primer registro")
Else
	SetItem(GetRow(),"cve_profesor",CveProf)
	TriggerEvent(ItemChanged!)
End if
end event

event siguiente;long	CveProf

Cveprof = GetItemNumber(GetRow(),"cve_profesor")

Select Min(cve_profesor) Into :CveProf
From profesor
Where cve_profesor > :Cveprof using gtr_sce;

If IsNull(CveProf) Then
	Messagebox("Aviso","Es el último registro")
Else
	SetItem(GetRow(),"cve_profesor",CveProf)
	TriggerEvent(ItemChanged!)
End if


end event

event ultimo;long	CveProf

Select Max(cve_profesor) Into :CveProf
From profesor using gtr_sce;

SetItem(GetRow(),"cve_profesor",CveProf)
TriggerEvent(ItemChanged!)
end event

event nuevo;//dw.scrolltorow(dw.insertrow(0))
ib_nuevo = true
scrolltorow(InsertRow(0))
end event

event actualiza;ib_nuevo = false
SetItem(getrow(),"nombre_completo",GetItemString(getrow(), "apaterno") + " " +&
					GetItemString(getrow(), "amaterno") + " " +GetItemString(getrow(), "nombre"))
if Update() = 1 then
	commit using gtr_sce;
	messagebox("Información","Se han guardado los cambios")
else
	rollback using gtr_sce;
	SetItem(getrow(),"cve_profesor",0)
	messagebox("Información","No se han guardado los cambios",stopsign!)
end if
end event

event borra;DeleteRow(0)
if Update() = 1 then
	commit using gtr_sce;
	messagebox("Información","Se han guardado los cambios")
else
	rollback using gtr_sce;
	messagebox("Información","No se han guardado los cambios",stopsign!)
end if
end event

event itemchanged;// Juan Campos Sánchez.		Noviembre-1997.

Integer Depto
if dwo.name = "cve_profesor" then
if ib_nuevo = false then
	Accepttext()
	EstaVentana.SetRedraw(False) 
	If This.Retrieve(GetItemNumber(GetRow(),"cve_profesor")) = 0 Then
		Messagebox("Aviso","La clave de profesor no existe")
		InsertRow(0)	
	End if
	EstaVentana.SetRedraw(True)
end if
end if
 
end event

event constructor;m_datos_grales_prof.dw = this

 

end event

