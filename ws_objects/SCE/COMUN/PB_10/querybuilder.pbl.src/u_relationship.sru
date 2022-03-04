$PBExportHeader$u_relationship.sru
forward
global type u_relationship from statictext
end type
end forward

global type u_relationship from statictext
boolean visible = false
integer width = 91
integer height = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "="
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type
global u_relationship u_relationship

type variables
u_join iuo_join
end variables

on u_relationship.create
end on

on u_relationship.destroy
end on

event constructor;SetPosition(Behind!)
SetPosition(NoTopMost!)
end event

event clicked;Long ll_index, ll_rowcount
DataStore lds
String ls_return, ls_where, ls_tableA, ls_tableB

lds = CREATE DataStore
lds.DataObject = 'd_relationship'

ll_rowcount = lds.RowCount()

FOR ll_index = 1 TO ll_rowcount
	ls_where = lds.GetItemString(ll_index, 1)
	
	ls_tableA = iuo_join.idw_tableA.Title + '.' + iuo_join.idw_tableA.GetItemString(iuo_join.ii_rowA, 1)
	ls_tableB = iuo_join.idw_tableB.Title + '.' + iuo_join.idw_tableB.GetItemString(iuo_join.ii_rowB, 1)
	
	lds.SetItem(ll_index, 2, ls_tableA + ' ' + ls_where + ' ' + ls_tableB)
	
NEXT

OpenWithParm(w_relationship, lds)

ls_return = Message.StringParm

CHOOSE CASE ls_return
	CASE '@@CANCEL@@', ''
		RETURN
	CASE '@@DELETE@@'
		iuo_join.of_CloseJoin()
	CASE ELSE
		THIS.Text = ls_return
END CHOOSE
end event

