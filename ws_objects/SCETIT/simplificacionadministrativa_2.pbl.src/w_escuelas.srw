$PBExportHeader$w_escuelas.srw
forward
global type w_escuelas from Window
end type
type dw_escuelas from datawindow within w_escuelas
end type
end forward

global type w_escuelas from Window
int X=833
int Y=361
int Width=3461
int Height=1541
boolean TitleBar=true
string Title="Catalogo de Escuelas"
string MenuName="m_titulacion"
long BackColor=10789024
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_escuelas dw_escuelas
end type
global w_escuelas w_escuelas

on w_escuelas.create
if this.MenuName = "m_titulacion" then this.MenuID = create m_titulacion
this.dw_escuelas=create dw_escuelas
this.Control[]={ this.dw_escuelas}
end on

on w_escuelas.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_escuelas)
end on

event open;//Comentado para migrar sin padlock
//g_nv_security.fnv_secure_window (this)
dw_escuelas.Event carga()
end event

type dw_escuelas from datawindow within w_escuelas
event type integer carga ( )
event type integer nuevo ( )
event type integer borra_renglon ( )
event actualiza ( )
int X=37
int Y=33
int Width=3351
int Height=1309
int TabOrder=1
string DataObject="d_escuelas"
boolean Border=false
boolean VScrollBar=true
boolean LiveScroll=true
end type

event carga;return retrieve()
end event

event nuevo;return ScrollToRow(InsertRow(0))

end event

event borra_renglon;int li_respuesta
li_respuesta = messagebox("Atención","Esta seguro de querer borrar la escuela "+&
					string(GetItemNumber(GetRow(),"cve_escuela"))&
					,StopSign!,YesNo!,2)

if li_respuesta = 1 then
	deleterow(getrow())
	return TriggerEvent("actualiza")
end if
return -1
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
m_titulacion.dw = this
end event

