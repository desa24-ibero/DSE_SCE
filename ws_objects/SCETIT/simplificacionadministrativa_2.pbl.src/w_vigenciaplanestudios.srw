$PBExportHeader$w_vigenciaplanestudios.srw
forward
global type w_vigenciaplanestudios from Window
end type
type dw_vigenciaplanestudios from datawindow within w_vigenciaplanestudios
end type
end forward

global type w_vigenciaplanestudios from Window
int X=833
int Y=361
int Width=2679
int Height=1057
boolean TitleBar=true
string Title="Vigencias de planes de estudios"
string MenuName="m_vigenciaplanestudios"
long BackColor=10789024
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_vigenciaplanestudios dw_vigenciaplanestudios
end type
global w_vigenciaplanestudios w_vigenciaplanestudios

type variables
DataStore ids_carreraplan
end variables

on w_vigenciaplanestudios.create
if this.MenuName = "m_vigenciaplanestudios" then this.MenuID = create m_vigenciaplanestudios
this.dw_vigenciaplanestudios=create dw_vigenciaplanestudios
this.Control[]={ this.dw_vigenciaplanestudios}
end on

on w_vigenciaplanestudios.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_vigenciaplanestudios)
end on

event open;ids_carreraplan = Create DataStore
ids_carreraplan.DataObject = "d_carreraplan"
ids_carreraplan.SetTrans(gtr_sce)
if ids_carreraplan.retrieve() <= 0 then
	close(this)
end if
dw_vigenciaplanestudios.Event Primero()
//Comentado para migrar sin padlock
//g_nv_security.fnv_secure_window (this)


end event

event close;Destroy ids_carreraplan
end event

type dw_vigenciaplanestudios from datawindow within w_vigenciaplanestudios
event type integer carga ( integer ai_carrera,  integer ai_plan )
event type integer primero ( )
event type integer ultimo ( )
event type integer anterior ( )
event type integer siguiente ( )
event actualiza ( )
int X=74
int Y=65
int Width=2510
int Height=745
int TabOrder=1
string DataObject="d_vigenciaplanestudios"
boolean Border=false
boolean LiveScroll=true
end type

event carga;int li_respuesta
li_respuesta = retrieve(ai_carrera,ai_plan)
if li_respuesta = 0 then
	messagebox("Aviso", "no existe la carrera "+string(ai_carrera)+"-"+string(ai_plan))
	Event primero()
end if
return li_respuesta
end event

event primero;ids_carreraplan.SetRow(1)
return Event carga(ids_carreraplan.GetItemNumber(1,"cve_carrera"),&
						ids_carreraplan.GetItemNumber(1,"cve_plan"))
end event

event ultimo;ids_carreraplan.SetRow(ids_carreraplan.RowCount())
return Event carga(ids_carreraplan.GetItemNumber(ids_carreraplan.GetRow(),"cve_carrera"),&
						ids_carreraplan.GetItemNumber(ids_carreraplan.GetRow(),"cve_plan"))
end event

event anterior;if (ids_carreraplan.GetRow() > 1 ) then 
	ids_carreraplan.SetRow(ids_carreraplan.GetRow() - 1)
else
	ids_carreraplan.SetRow(ids_carreraplan.RowCount())
end if
return Event carga(ids_carreraplan.GetItemNumber(ids_carreraplan.GetRow(),"cve_carrera"),&
						ids_carreraplan.GetItemNumber(ids_carreraplan.GetRow(),"cve_plan"))
end event

event siguiente;if ids_carreraplan.GetRow() < ids_carreraplan.Rowcount() then
	ids_carreraplan.SetRow(ids_carreraplan.GetRow() + 1)
else
	ids_carreraplan.SetRow(1)
end if
return Event carga(ids_carreraplan.GetItemNumber(ids_carreraplan.GetRow(),"cve_carrera"),&
						ids_carreraplan.GetItemNumber(ids_carreraplan.GetRow(),"cve_plan"))
end event

event actualiza;if Update() = 1 then
		commit using gtr_sce;
		MessageBox("Atención","Se han guardado los cambios")
else
		rollback using gtr_sce;
		MessageBox("Atención","No se han guardado los cambios")
end if
end event

event constructor;SetTrans(gtr_sce)
m_vigenciaplanestudios.dw = this
end event

event itemchanged;if dwo.Name = "carreraplan" then
	Event carga(integer(mid(data,1,len(data)-1)),&
			integer(mid(data,len(data),1)))
end if
end event

