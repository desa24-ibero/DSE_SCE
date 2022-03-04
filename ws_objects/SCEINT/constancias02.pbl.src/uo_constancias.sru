$PBExportHeader$uo_constancias.sru
forward
global type uo_constancias from UserObject
end type
type dw_constancia from datawindow within uo_constancias
end type
end forward

global type uo_constancias from UserObject
int Width=1545
int Height=136
long BackColor=79741120
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
dw_constancia dw_constancia
end type
global uo_constancias uo_constancias

type variables
integer ii_cve_constancia
end variables

on uo_constancias.create
this.dw_constancia=create dw_constancia
this.Control[]={this.dw_constancia}
end on

on uo_constancias.destroy
destroy(this.dw_constancia)
end on

type dw_constancia from datawindow within uo_constancias
int X=5
int Y=4
int Width=1490
int Height=100
int TabOrder=10
string DataObject="d_constancias"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event constructor;SetTransObject(gtr_sce)
this.Retrieve()
end event

event itemchanged;integer li_cve_constancia
long li_num_renglon

this.AcceptText()

li_num_renglon= this.GetRow()

li_cve_constancia= this.object.cve_constancia[li_num_renglon]

ii_cve_constancia = li_cve_constancia


end event

