$PBExportHeader$uo_planteles.sru
forward
global type uo_planteles from UserObject
end type
type dw_1 from datawindow within uo_planteles
end type
end forward

global type uo_planteles from UserObject
int Width=662
int Height=131
boolean Border=true
long BackColor=67108864
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
dw_1 dw_1
end type
global uo_planteles uo_planteles

on uo_planteles.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on uo_planteles.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within uo_planteles
int X=11
int Y=10
int Width=629
int Height=99
int TabOrder=10
string DataObject="d_uo_planteles"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event constructor;this.SetTransObject(gtr_sce)
this.Retrieve()
end event

