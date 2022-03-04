$PBExportHeader$uo_doc_control_sep.sru
forward
global type uo_doc_control_sep from UserObject
end type
type dw_1 from datawindow within uo_doc_control_sep
end type
end forward

global type uo_doc_control_sep from UserObject
int Width=1159
int Height=134
boolean Border=true
long BackColor=67108864
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
dw_1 dw_1
end type
global uo_doc_control_sep uo_doc_control_sep

on uo_doc_control_sep.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on uo_doc_control_sep.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within uo_doc_control_sep
int X=11
int Y=10
int Width=1123
int Height=99
int TabOrder=10
string DataObject="d_uo_doc_control_sep"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event constructor;this.SetTransObject(gtr_sce)
this.Retrieve()
end event

