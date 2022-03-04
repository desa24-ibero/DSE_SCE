$PBExportHeader$w_relationship.srw
forward
global type w_relationship from window
end type
type cb_3 from commandbutton within w_relationship
end type
type cb_2 from commandbutton within w_relationship
end type
type cb_1 from commandbutton within w_relationship
end type
type dw_1 from datawindow within w_relationship
end type
end forward

global type w_relationship from window
integer width = 2153
integer height = 580
boolean titlebar = true
string title = "Relationship"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_relationship w_relationship

on w_relationship.create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_relationship.destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;String ls_where
DataStore lds

lds = Message.PowerObjectParm

dw_1.Reset()
lds.RowsCopy(1, lds.RowCount(), Primary!, dw_1, 1, Primary!)
end event

type cb_3 from commandbutton within w_relationship
integer x = 1806
integer y = 248
integer width = 302
integer height = 96
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Delete"
end type

event clicked;CloseWithReturn(PARENT, '@@DELETE@@')
end event

type cb_2 from commandbutton within w_relationship
integer x = 1806
integer y = 120
integer width = 302
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;CloseWithReturn(PARENT, '@@CANCEL@@')

end event

type cb_1 from commandbutton within w_relationship
integer x = 1806
integer y = 12
integer width = 302
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;String ls_where
Long ll_row

ll_row = dw_1.GetSelectedRow(0)

IF ll_row = 0 THEN
	CloseWithReturn(PARENT, '@@CANCEL@@')
ELSE
	ls_where = dw_1.GetItemString(ll_row, 1)
	CloseWithReturn(PARENT, ls_where)
END IF
end event

type dw_1 from datawindow within w_relationship
integer x = 18
integer y = 12
integer width = 1742
integer height = 456
integer taborder = 10
string title = "none"
string dataobject = "d_relationship"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;IF Row > 0 THEN
	SelectRow(0, FALSE)
	SelectRow(Row, TRUE)
END IF
end event

