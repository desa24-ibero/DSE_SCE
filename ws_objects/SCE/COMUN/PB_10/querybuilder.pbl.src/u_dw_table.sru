$PBExportHeader$u_dw_table.sru
forward
global type u_dw_table from datawindow
end type
end forward

global type u_dw_table from datawindow
boolean visible = false
integer width = 987
integer height = 1052
string dragicon = "StopSign!"
boolean titlebar = true
string dataobject = "d_table_extract_display"
boolean controlmenu = true
boolean vscrollbar = true
boolean resizable = true
string icon = "DataWindow5!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event syscommand pbm_syscommand
event positionchanging pbm_windowposchanging
event lbuttonup pbm_dwnlbuttonup
event positionchanged pbm_windowposchanged
event ue_postconstructor ( )
event mousemove pbm_dwnmousemove
event move pbm_move
event moved ( )
event movestart ( )
end type
global u_dw_table u_dw_table

type prototypes
Function integer GetSystemMetrics ( int nIndex ) Library "user32.dll"
end prototypes

type variables
u_cst_querybuilder iuo_parent
u_client iuo_client

CONSTANT Integer SM_CYCAPTION = 4
CONSTANT Integer SM_CYBORDER = 6

String is_table
Integer ii_iteration

u_join iuo_join[]
String is_position[]
end variables

forward prototypes
public function integer of_setparent (u_cst_querybuilder auo_parent)
public function integer of_adjustheight ()
public function integer of_settable (string as_table)
public function integer of_setiteration (integer ai_iteration, string as_table)
public function string of_gettablename ()
public function integer of_closejoin (u_join ajoin)
end prototypes

event syscommand;Long ll_index, ll_rowcount

CHOOSE CASE commandtype
	CASE 61536 //Close
		ll_rowcount = UpperBound(iuo_join)

		FOR ll_index = 1 TO ll_rowcount
			IF IsValid(iuo_join[ll_index]) THEN
				iuo_join[ll_index].of_CloseJoin()
			END IF
		NEXT
		
		iuo_parent.of_CloseTable(THIS)
END CHOOSE
end event

event positionchanging;Long ll_index, ll_rowcount
Long ll_firstrow
Long ll_title, ll_total

ll_firstrow = Long(Describe('DataWindow.FirstRowOnPage'))

ll_rowcount = UpperBound(iuo_join)

ll_title = PixelsToUnits(GetSystemMetrics(SM_CYCAPTION), XPixelsToUnits!)
ll_total = ll_title+ 104

FOR ll_index = 1 TO ll_rowcount
	IF IsValid(iuo_join[ll_index]) THEN
		CHOOSE CASE is_position[ll_index]
			CASE 'B'
				
				IF iuo_join[ll_index].EndX < (X + (Width / 2)) THEN
					iuo_join[ll_index].BeginX = X
				ELSE
					iuo_join[ll_index].BeginX = X + Width
				END IF
				
				IF (Y + ll_total + ((iuo_join[ll_index].ii_rowA - ll_firstrow) * 64)) > Y + Height THEN
					iuo_join[ll_index].BeginY = Y + Height
				ELSEIF (Y + ll_total + ((iuo_join[ll_index].ii_rowA - ll_firstrow) * 64)) < Y + ll_title THEN
					iuo_join[ll_index].BeginY = Y + ll_title
				ELSE
					iuo_join[ll_index].BeginY = Y + ll_total + ((iuo_join[ll_index].ii_rowA - ll_firstrow) * 64)
				END IF
			CASE 'E'
				
				IF iuo_join[ll_index].BeginX < X THEN
					iuo_join[ll_index].EndX = X
				ELSE
					iuo_join[ll_index].EndX = Width + X
				END IF
				
				IF (Y + ll_total + ((iuo_join[ll_index].ii_rowB - ll_firstrow) * 64)) > Y + Height THEN
					iuo_join[ll_index].EndY = Y + Height
				ELSEIF (Y + ll_total + ((iuo_join[ll_index].ii_rowB - ll_firstrow) * 64)) < Y + ll_title THEN
					iuo_join[ll_index].EndY = Y + ll_title
				ELSE
					iuo_join[ll_index].EndY = Y + ll_total + ((iuo_join[ll_index].ii_rowB - ll_firstrow) * 64)
				END IF
		END CHOOSE
		
		iuo_join[ll_index].of_PositionRelationship()
		
	END IF
NEXT
end event

event positionchanged;iuo_client.SetRedraw(TRUE)


end event

event ue_postconstructor();THIS.Visible = TRUE

SetRedraw(TRUE)
end event

event mousemove;IF iuo_client.ib_join THEN
	iuo_client.TriggerEvent('mousemove')
END IF
end event

event moved();iuo_parent.of_Rearrange()
iuo_client.SetRedraw(TRUE)
end event

event movestart();THIS.BringToTop = true

SetRedraw(TRUE)
end event

public function integer of_setparent (u_cst_querybuilder auo_parent);iuo_parent = auo_parent
iuo_client = iuo_parent.uo_client

RETURN 1
end function

public function integer of_adjustheight ();Long ll_height
Long ll_rowcount
Long ll_title

ll_rowcount = THIS.RowCount()

IF ll_rowcount > 10 THEN
	ll_rowcount = 10
END IF

ll_title = PixelsToUnits(GetSystemMetrics(SM_CYCAPTION) + GetSystemMetrics(SM_CYBORDER), YPixelsToUnits!)

ll_height = ll_title + 104 + (ll_rowcount * 64)

THIS.Height = ll_height

RETURN 1
end function

public function integer of_settable (string as_table);is_table = as_table

RETURN 1
end function

public function integer of_setiteration (integer ai_iteration, string as_table);ii_iteration = ai_iteration
THIS.Title = as_table

RETURN 1
end function

public function string of_gettablename ();String ls_table

IF ii_iteration > 1 THEN
	ls_table = is_table + ' ' + THIS.Title
ELSE
	ls_table = is_table
END IF

RETURN ls_table
end function

public function integer of_closejoin (u_join ajoin);Long ll_index, ll_rowcount
u_join luo_join

ll_rowcount = UpperBound(iuo_join)

FOR ll_index = 1 TO ll_rowcount
	IF IsValid(iuo_join[ll_index]) THEN
		IF iuo_join[ll_index] = ajoin THEN
			iuo_join[ll_index] = luo_join
			EXIT
		END IF
	END IF
NEXT

RETURN 1
end function

on u_dw_table.create
end on

on u_dw_table.destroy
end on

event clicked;IF row > 0 THEN
	IF KeyDown(KeyShift!) THEN
		IF NOT iuo_client.ib_join THEN
			iuo_join[UpperBound(iuo_join) + 1] = iuo_client.of_GetNextLine()
			is_position[UpperBound(is_position) + 1] = 'B'
			iuo_client.of_StartJoin(THIS,Row)
		ELSE
			iuo_join[UpperBound(iuo_join) + 1] = iuo_client.iuo_current
			is_position[UpperBound(is_position) + 1] = 'E'
			iuo_client.of_EndJoin(THIS,Row)
		END IF
	ELSE
		IF IsSelected(row) THEN
			SelectRow(row, FALSE)
			iuo_parent.of_RemoveItem(THIS.Title + '.' + THIS.GetItemString(row, 1))
		ELSE
			SelectRow(row, TRUE)
			iuo_parent.of_AddItem(THIS.Title + '.' + THIS.GetItemString(row, 1))
		END IF
	END IF
END IF
end event

event resize;THIS.Modify('t_header.Width=' + String(Width))
end event

event retrieveend;of_AdjustHeight()
end event

event constructor;PostEvent('ue_postconstructor')
end event

event scrollvertical;TriggerEvent('positionchanging')
end event

event other;CHOOSE CASE Message.Number
	CASE 562
		TriggerEvent('moved')
	CASE 561
		TriggerEvent('movestart')
END CHOOSE
end event

