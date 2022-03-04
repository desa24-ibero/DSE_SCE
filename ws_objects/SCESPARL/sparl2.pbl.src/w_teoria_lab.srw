$PBExportHeader$w_teoria_lab.srw
forward
global type w_teoria_lab from Window
end type
type st_1 from statictext within w_teoria_lab
end type
type cb_ver_planes_por_mat from commandbutton within w_teoria_lab
end type
type dw_teoria_lab from datawindow within w_teoria_lab
end type
end forward

global type w_teoria_lab from Window
int X=834
int Y=362
int Width=3434
int Height=1562
boolean TitleBar=true
string Title="Teoria Laboratorio"
string MenuName="m_menugeneral"
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_1 st_1
cb_ver_planes_por_mat cb_ver_planes_por_mat
dw_teoria_lab dw_teoria_lab
end type
global w_teoria_lab w_teoria_lab

on w_teoria_lab.create
if this.MenuName = "m_menugeneral" then this.MenuID = create m_menugeneral
this.st_1=create st_1
this.cb_ver_planes_por_mat=create cb_ver_planes_por_mat
this.dw_teoria_lab=create dw_teoria_lab
this.Control[]={this.st_1,&
this.cb_ver_planes_por_mat,&
this.dw_teoria_lab}
end on

on w_teoria_lab.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.cb_ver_planes_por_mat)
destroy(this.dw_teoria_lab)
end on

event open;x = 1
y = 1
dw_teoria_lab.event carga()

end event

type st_1 from statictext within w_teoria_lab
int X=29
int Y=192
int Width=1715
int Height=77
boolean Enabled=false
string Text="El asterisco en Grupo (*) significa que esta abierta a cualquiera"
Alignment Alignment=Right!
boolean FocusRectangle=false
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_ver_planes_por_mat from commandbutton within w_teoria_lab
int X=2615
int Y=157
int Width=717
int Height=109
int TabOrder=1
string Text="Ver Planes por Materia"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long cve_carrera_plan
int cve_carrera, cve_plan

if dw_teoria_lab.GetRow() > 0 then
	openwithparm(w_planes_por_mat,&
	long(dw_teoria_lab.GetItemNumber(dw_teoria_lab.GetRow(),1)))
	cve_carrera_plan = Message.DoubleParm
	if cve_carrera_plan <> 0 then
		cve_carrera = integer(cve_carrera_plan / 10)
		cve_plan = integer(mod(cve_carrera_plan , 10))
		dw_teoria_lab.SetItem(dw_teoria_lab.GetRow(),"cve_carrera",cve_carrera)
		dw_teoria_lab.SetItem(dw_teoria_lab.GetRow(),"cve_plan",cve_plan)
	end if
else
	MessageBox("Atención","Primero Seleccione un renglon")
end if
	
end event

type dw_teoria_lab from datawindow within w_teoria_lab
event carga ( )
event nuevo ( )
event borra ( )
event actualiza ( )
int X=29
int Y=285
int Width=3302
int Height=1002
int TabOrder=1
string DataObject="d_teoria_lab"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event carga;retrieve()
end event

event nuevo;ScrolltoRow(InsertRow(0))
end event

event borra;DeleteRow(GetRow())
event actualiza()
end event

event actualiza;if Update( )  = 1  then
	commit using gtr_sce;
	MessageBox("Atencion", "Se han guardado los cambios")
else
	rollback using gtr_sce;
	MessageBox("Atencion", "Los cambios no se han guardado")
end if
end event

event constructor;m_menugeneral.dw = this
SetTransObject(gtr_sce)
end event

event doubleclicked;cb_ver_planes_por_mat.event clicked()
end event

