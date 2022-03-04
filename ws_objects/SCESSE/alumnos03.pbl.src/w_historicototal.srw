$PBExportHeader$w_historicototal.srw
forward
global type w_historicototal from Window
end type
type dw_historicototal from datawindow within w_historicototal
end type
type uo_nombre from uo_nombre_alumno within w_historicototal
end type
end forward

global type w_historicototal from Window
int X=834
int Y=362
int Width=3460
int Height=1610
boolean TitleBar=true
string Title="Consulta Total Historico"
string MenuName="m_menu"
long BackColor=10789024
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event inicia_proceso ( )
dw_historicototal dw_historicototal
uo_nombre uo_nombre
end type
global w_historicototal w_historicototal

event inicia_proceso;long ll_row, ll_cuenta


ll_row = uo_nombre.dw_nombre_alumno.GetRow()
ll_cuenta = uo_nombre.dw_nombre_alumno.GetItemNumber(ll_row, "cuenta")

if f_alumno_restringido (ll_cuenta) then
	if f_usuario_especial(gs_usuario) then
		MessageBox("Usuario  Autorizado", &
		"Alumno con acceso restringido",Information!)		
	else
		MessageBox("Usuario NO Autorizado", &
	           "Alumno con acceso restringido, por favor consulte a la ~n"+ &
				 +"Dirección de Servicios Escolares",StopSign!)
		uo_nombre.dw_nombre_alumno.Reset()	
		uo_nombre.dw_nombre_alumno.insertrow(0)
		uo_nombre.em_digito.text=" "
		uo_nombre.em_cuenta.text = " "
		uo_nombre.em_cuenta.setfocus()

		return		
	end if
end if

if dw_historicototal.Retrieve(long(uo_nombre.em_cuenta.text)) = 0 then
  MessageBox("Aviso","No se encontró información con esta cuenta")
end if  
end event

on w_historicototal.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_historicototal=create dw_historicototal
this.uo_nombre=create uo_nombre
this.Control[]={this.dw_historicototal,&
this.uo_nombre}
end on

on w_historicototal.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_historicototal)
destroy(this.uo_nombre)
end on

event open;x=1
y=1
end event

type dw_historicototal from datawindow within w_historicototal
int X=33
int Y=509
int Width=3233
int Height=886
int TabOrder=2
string DataObject="d_historicototal"
boolean Border=false
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;SetTransObject(gtr_sce)
m_menu.dw = this

end event

type uo_nombre from uo_nombre_alumno within w_historicototal
int X=33
int Y=29
int TabOrder=1
boolean Enabled=true
end type

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

