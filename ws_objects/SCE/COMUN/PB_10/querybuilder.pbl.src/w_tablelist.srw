$PBExportHeader$w_tablelist.srw
forward
global type w_tablelist from window
end type
type cb_2 from commandbutton within w_tablelist
end type
type cb_1 from commandbutton within w_tablelist
end type
type dw_1 from datawindow within w_tablelist
end type
end forward

global type w_tablelist from window
integer width = 1390
integer height = 1068
boolean titlebar = true
string title = "Table List"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_tablelist w_tablelist

on w_tablelist.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_tablelist.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;DataStore ldw

ldw = Message.PowerObjectParm

CHOOSE CASE ldw.DataObject
	CASE 'd_table_list_display'
		THIS.Title = 'Select Table'
		cb_1.Text = 'Open'
	CASE 'd_columnlist'
		THIS.Title = 'Select Column'
		cb_1.Text = 'Paste'
	CASE 'd_functionlist'
		THIS.Title = 'Select Function'
		cb_1.Text = 'Paste'
END CHOOSE
		
dw_1.DataObject = ldw.DataObject

dw_1.Reset()

ldw.RowsCopy(1, ldw.RowCount(), Primary!, dw_1, 1, Primary!)
end event

type cb_2 from commandbutton within w_tablelist
integer x = 1024
integer y = 132
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

type cb_1 from commandbutton within w_tablelist
integer x = 1024
integer y = 20
integer width = 302
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Open"
end type

event clicked;String ls_tablelist
Long ll_row

ll_row = dw_1.GetSelectedRow(0)

DO UNTIL ll_row = 0
	ls_tablelist = ls_tablelist + dw_1.GetItemString(ll_row, 1) + ';'
	ll_row = dw_1.GetSelectedRow(ll_row)
LOOP

CloseWithReturn(PARENT, ls_tablelist)
end event

type dw_1 from datawindow within w_tablelist
integer x = 27
integer y = 20
integer width = 955
integer height = 936
integer taborder = 10
string title = "none"
string dataobject = "d_table_list_display"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;IF row > 0 THEN
	IF dw_1.DataObject = 'd_table_list_display' THEN
		IF IsSelected(row) THEN
			SelectRow(row, FALSE)
		ELSE
			SelectRow(row, TRUE)
		END IF
	ELSE
		SelectRow(0, FALSE)
		SelectRow(row, TRUE)
	END IF
END IF
end event

