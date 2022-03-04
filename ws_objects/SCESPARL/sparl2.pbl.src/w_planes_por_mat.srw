$PBExportHeader$w_planes_por_mat.srw
forward
global type w_planes_por_mat from Window
end type
type dw_planes_por_mat from datawindow within w_planes_por_mat
end type
end forward

global type w_planes_por_mat from Window
int X=832
int Y=360
int Width=1998
int Height=1208
boolean TitleBar=true
string Title="Planes de estudio dada una materia"
boolean ControlMenu=true
WindowType WindowType=response!
dw_planes_por_mat dw_planes_por_mat
end type
global w_planes_por_mat w_planes_por_mat

on w_planes_por_mat.create
this.dw_planes_por_mat=create dw_planes_por_mat
this.Control[]={this.dw_planes_por_mat}
end on

on w_planes_por_mat.destroy
destroy(this.dw_planes_por_mat)
end on

event open;dw_planes_por_mat.retrieve(Message.DoubleParm)
end event

type dw_planes_por_mat from datawindow within w_planes_por_mat
int X=73
int Y=188
int Width=1801
int Height=840
int TabOrder=1
string DataObject="d_planes_por_mat"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;SetTransObject(gtr_sce)
end event

event doubleclicked;if row > 0 then
	CloseWithReturn(parent,(long(GetItemNumber(row,"cve_carrera")*10)+GetItemNumber(row,"cve_plan")))
else
	CloseWithReturn(Parent,0)
end if
end event

