$PBExportHeader$uo_status_aspiran.sru
forward
global type uo_status_aspiran from UserObject
end type
type dw_status from datawindow within uo_status_aspiran
end type
end forward

global type uo_status_aspiran from UserObject
int Width=746
int Height=160
boolean Border=true
long BackColor=67108864
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
dw_status dw_status
end type
global uo_status_aspiran uo_status_aspiran

on uo_status_aspiran.create
this.dw_status=create dw_status
this.Control[]={this.dw_status}
end on

on uo_status_aspiran.destroy
destroy(this.dw_status)
end on

type dw_status from datawindow within uo_status_aspiran
int X=18
int Y=26
int Width=691
int Height=90
int TabOrder=10
string DataObject="d_status"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event constructor;long ll_n_rows

this.SetTransObject(gtr_sce)
ll_n_rows = this.Retrieve()
this.ScrollToRow(1)

end event

