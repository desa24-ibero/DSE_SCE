$PBExportHeader$uo_ingreso.sru
forward
global type uo_ingreso from UserObject
end type
type vsb_ingreso from vscrollbar within uo_ingreso
end type
type dw_ingreso from datawindow within uo_ingreso
end type
end forward

global type uo_ingreso from UserObject
int Width=1251
int Height=150
boolean Border=true
long BackColor=67108864
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
vsb_ingreso vsb_ingreso
dw_ingreso dw_ingreso
end type
global uo_ingreso uo_ingreso

on uo_ingreso.create
this.vsb_ingreso=create vsb_ingreso
this.dw_ingreso=create dw_ingreso
this.Control[]={this.vsb_ingreso,&
this.dw_ingreso}
end on

on uo_ingreso.destroy
destroy(this.vsb_ingreso)
destroy(this.dw_ingreso)
end on

type vsb_ingreso from vscrollbar within uo_ingreso
int X=1115
int Y=3
int Width=73
int Height=122
boolean Enabled=false
end type

event lineup;long ll_renglon_actual, ll_num_rows, ll_renglon_ant

ll_num_rows= dw_ingreso.RowCount()
ll_renglon_actual= dw_ingreso.GetRow()
ll_renglon_ant= ll_renglon_actual - 1

if ll_renglon_actual = 1 then
   dw_ingreso.ScrollToRow(ll_num_rows)
else
   dw_ingreso.ScrollToRow(ll_renglon_ant)
end if

end event

event linedown;long ll_renglon_actual, ll_num_rows, ll_renglon_sig

ll_num_rows= dw_ingreso.RowCount()
ll_renglon_actual= dw_ingreso.GetRow()
ll_renglon_sig= ll_renglon_actual +1

if ll_renglon_actual = ll_num_rows then
   dw_ingreso.ScrollToRow(1)
else
   dw_ingreso.ScrollToRow(ll_renglon_sig)
end if

end event

type dw_ingreso from datawindow within uo_ingreso
int X=22
int Y=26
int Width=1112
int Height=80
int TabOrder=10
boolean Enabled=false
string DataObject="dddw_ingreso"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event constructor;this.SetTransObject(gtr_sce)
this.Retrieve()
this.ScrollToRow(1)

end event

