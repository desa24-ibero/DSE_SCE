$PBExportHeader$u_cst_querybuilder.sru
forward
global type u_cst_querybuilder from userobject
end type
type st_horz from u_splitbar within u_cst_querybuilder
end type
type uo_client from u_client within u_cst_querybuilder
end type
type tab_1 from tab within u_cst_querybuilder
end type
type tp_select from userobject within tab_1
end type
type dw_6 from datawindow within tp_select
end type
type tp_select from userobject within tab_1
dw_6 dw_6
end type
type tabpage_5 from userobject within tab_1
end type
type dw_5 from u_dw_grid within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_5 dw_5
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from u_dw_grid within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_8 from datawindow within tabpage_3
end type
type dw_3 from datawindow within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_8 dw_8
dw_3 dw_3
end type
type tabpage_4 from userobject within tab_1
end type
type dw_4 from u_dw_grid within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_4 dw_4
end type
type tabpage_1 from userobject within tab_1
end type
type dw_7 from datawindow within tabpage_1
end type
type dw_1 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_7 dw_7
dw_1 dw_1
end type
type tabpage_6 from userobject within tab_1
end type
type uo_1 from u_scintilla within tabpage_6
end type
type tabpage_6 from userobject within tab_1
uo_1 uo_1
end type
type tab_1 from tab within u_cst_querybuilder
tp_select tp_select
tabpage_5 tabpage_5
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_1 tabpage_1
tabpage_6 tabpage_6
end type
end forward

global type u_cst_querybuilder from userobject
integer width = 2601
integer height = 1380
long backcolor = 67108864
string text = "Graphic Query"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event resize pbm_size
st_horz st_horz
uo_client uo_client
tab_1 tab_1
end type
global u_cst_querybuilder u_cst_querybuilder

type prototypes
PUBLIC FUNCTION Long SetParent(Long hChild, Long hParent) Library 'user32.dll'
end prototypes

type variables
Transaction itr
n_cst_schema_sql inv_schema

u_dw_table idw_table[]

String is_file
end variables

forward prototypes
public function integer of_settransactionobject (transaction atr)
public function window of_getparentwindow ()
public function integer of_loadcolumnlist ()
public function integer of_additem (string as_item)
public function integer of_removeitem (string as_item)
public function string of_getsyntax ()
public function integer of_addtable ()
public function string of_gettablename (string as_table)
public function integer of_gettableiteration (string as_table)
public function integer of_closetable (u_dw_table adw_table)
public function long of_getrightmost ()
public function string of_getjoinsyntax ()
public function integer of_rearrange ()
public function integer of_loadtable (string as_table)
public function integer of_openquery ()
public function integer of_closealltables ()
public function u_dw_table of_gettable (string as_table)
public function integer of_savequeryas (string as_file)
public function integer of_savequeryas ()
public function integer of_savequery ()
public function integer of_openquery (string as_file)
public function integer of_savereport ()
public function integer of_newquery ()
public function integer of_parsetoarray (string as_source, string as_delimiter, ref string as_array[])
public function integer of_copy ()
public function integer of_cut ()
public function integer of_paste ()
public function integer of_undo ()
public function integer of_selectall ()
end prototypes

event resize;uo_client.Width = THIS.Width
tab_1.Width = THIS.Width
tab_1.Y = THIS.Height - tab_1.Height

uo_client.Height = tab_1.Y - uo_client.Y - 20
st_horz.Width = THIS.Width - 25
st_horz.Y = uo_client.Y + uo_client.Height
end event

public function integer of_settransactionobject (transaction atr);itr = atr
inv_schema.itr = atr

RETURN 1
end function

public function window of_getparentwindow ();Window lw_parent
GraphicObject lgo

lgo = THIS.GetParent()

DO UNTIL lgo.TypeOf() = Window!
	lgo = lgo.GetParent()
LOOP

lw_parent = lgo

RETURN lw_parent
end function

public function integer of_loadcolumnlist ();Long ll_count, ll_index, ll_row, ll_sortrow, ll_grouprow, ll_havingrow
Long ll_computerow
Long ll_innerindex, ll_rowcount
ll_count = UpperBound(idw_table)
DataWindowChild ldwc
DataWindowChild ldwchaving
DataWindowChild ldwccompute


tab_1.tabpage_1.dw_1.Reset()
tab_1.tabpage_3.dw_3.Reset()

tab_1.tabpage_2.dw_2.GetChild('column_name', ldwc)
ldwc.Reset()

tab_1.tabpage_4.dw_4.GetChild('column_name', ldwchaving)
ldwchaving.Reset()

tab_1.tabpage_5.dw_5.GetChild('column_name', ldwccompute)
ldwccompute.Reset()

FOR ll_index = 1 TO ll_count
	
	IF NOT IsValid(idw_table[ll_index]) THEN
		CONTINUE
	END IF
	
	ll_rowcount = idw_table[ll_index].RowCount()
	
	FOR ll_innerindex = 1 TO ll_rowcount
		ll_row = ldwc.InsertRow(0)
		ll_havingrow = ldwchaving.InsertRow(0)
		ll_sortrow = tab_1.tabpage_1.dw_1.InsertRow(0)
		ll_grouprow = tab_1.tabpage_3.dw_3.InsertRow(0)
		ll_computerow = ldwccompute.InsertRow(0)
		
		
		ldwc.SetItem(ll_row, 1, idw_table[ll_index].Title + '.' + idw_table[ll_index].GetItemString(ll_innerindex, 'syscolumns_name'))
		ldwchaving.SetItem(ll_havingrow, 1, idw_table[ll_index].Title + '.' + idw_table[ll_index].GetItemString(ll_innerindex, 'syscolumns_name'))
		ldwccompute.SetItem(ll_computerow, 1, idw_table[ll_index].Title + '.' + idw_table[ll_index].GetItemString(ll_innerindex, 'syscolumns_name'))
		tab_1.tabpage_1.dw_1.SetItem(ll_sortrow, 1, idw_table[ll_index].Title + '.' + idw_table[ll_index].GetItemString(ll_innerindex, 'syscolumns_name'))
		tab_1.tabpage_3.dw_3.SetItem(ll_grouprow, 1, idw_table[ll_index].Title + '.' + idw_table[ll_index].GetItemString(ll_innerindex, 'syscolumns_name'))
		
	NEXT
	
NEXT

RETURN 1


end function

public function integer of_additem (string as_item);Long ll_row

ll_row = tab_1.tp_select.dw_6.InsertRow(0)

tab_1.tp_select.dw_6.SetItem(ll_row, 1, as_item)

RETURN 1
end function

public function integer of_removeitem (string as_item);Long ll_row

ll_row = tab_1.tp_select.dw_6.Find('table_column="' + as_item + '"', 1, tab_1.tp_select.dw_6.RowCount())

IF ll_row > 0 THEn
	tab_1.tp_select.dw_6.DeleteRow(ll_row)
END IF

RETURN 1
end function

public function string of_getsyntax ();String ls_syntax, ls_join
Long ll_index, ll_rowcount

ls_syntax ='SELECT '

tab_1.tabpage_2.dw_2.AcceptText()
tab_1.tabpage_1.dw_7.AcceptText()
tab_1.tabpage_4.dw_4.AcceptText()
tab_1.tabpage_5.dw_5.AcceptText()

ll_rowcount = tab_1.tp_select.dw_6.RowCount()

FOR ll_index = 1 TO ll_rowcount
	IF ll_index = ll_rowcount THEN
		IF tab_1.tabpage_5.dw_5.GetItemString(1,1) <> '' THEN
			ls_syntax = ls_syntax + tab_1.tp_select.dw_6.GetItemString(ll_index, 1) + ',~r~n'
		ELSE
			ls_syntax = ls_syntax + tab_1.tp_select.dw_6.GetItemString(ll_index, 1) + '~r~n'
		END IF
	ELSE
		ls_syntax = ls_syntax + tab_1.tp_select.dw_6.GetItemString(ll_index, 1) + ',~r~n'
	END IF
	
NEXT

//Compute
ll_rowcount = tab_1.tabpage_5.dw_5.RowCount()

FOR ll_index = 1 TO ll_rowcount
	IF Len(Trim(tab_1.tabpage_5.dw_5.GetItemString(ll_index, 1))) > 0 AND &
	   NOT IsNull(tab_1.tabpage_5.dw_5.GetItemString(ll_index, 1)) THEN
		IF ll_index = ll_rowcount THEN	
			ls_syntax = ls_syntax + tab_1.tabpage_5.dw_5.GetItemString(ll_index, 1) + '~r~n'
		ELSE
			ls_syntax = ls_syntax + tab_1.tabpage_5.dw_5.GetItemString(ll_index, 1) + ',~r~n'
		END IF
	END IF
NEXT

ll_rowcount = UpperBound(idw_table)

IF ll_rowcount > 0 THEN
	ls_syntax = ls_syntax + 'FROM '
END IF

FOR ll_index = 1 TO ll_rowcount
	IF IsValid(idw_table[ll_index]) THEN
		IF ll_index = ll_rowcount THEN	
			ls_syntax = ls_syntax + idw_table[ll_index].of_GetTableName() + '~r~n'
		ELSE
			ls_syntax = ls_syntax + idw_table[ll_index].of_GetTableName() + ',~r~n'
		END IF
	END IF
NEXT

IF Right(ls_syntax, 3) = ',~r~n' THEN
	ls_syntax = Left(ls_syntax, Len(ls_syntax) - 3) + '~r~n'
END IF

ll_rowcount = tab_1.tabpage_2.dw_2.RowCount()

ls_join = of_GetJoinSyntax()

IF ll_rowcount > 0 THEN
	IF Len(tab_1.tabpage_2.dw_2.GetItemString(1, 1)) > 0 OR &
	Len(ls_join) > 0 THEN
		ls_syntax = ls_syntax + 'WHERE ' + ls_join
	END IF
END IF

FOR ll_index = 1 TO ll_rowcount
	IF Len(tab_1.tabpage_2.dw_2.GetItemString(ll_index, 1)) > 0 THEN
		IF Len(ls_join) > 0 THEN
			ls_syntax = ls_syntax + ' AND '
			ls_join = ''
		END IF
		ls_syntax = ls_syntax + '(' + tab_1.tabpage_2.dw_2.GetItemString(ll_index, 1) + ' ' + &
		                        tab_1.tabpage_2.dw_2.GetItemString(ll_index, 2) + ' ' + &
										tab_1.tabpage_2.dw_2.GetItemString(ll_index, 3) + ' ) ' + &
										Upper(tab_1.tabpage_2.dw_2.GetItemString(ll_index, 4)) + '~r~n'
	END IF
NEXT

ll_rowcount = tab_1.tabpage_3.dw_8.RowCount()

IF ll_rowcount > 0 THEN
	ls_syntax = ls_syntax + 'GROUP BY '
END IF

FOR ll_index = 1 TO ll_rowcount
	IF ll_index = ll_rowcount THEN	
		ls_syntax = ls_syntax + tab_1.tabpage_3.dw_8.GetItemString(ll_index, 1) + '~r~n'
	ELSE
		ls_syntax = ls_syntax + tab_1.tabpage_3.dw_8.GetItemString(ll_index, 1) + ',~r~n'
	END IF
	
NEXT

ll_rowcount = tab_1.tabpage_4.dw_4.RowCount()

IF ll_rowcount > 0 THEN
	IF Len(tab_1.tabpage_4.dw_4.GetItemString(1, 1)) > 0 THEN
		ls_syntax = ls_syntax + 'HAVING '
	END IF
END IF

FOR ll_index = 1 TO ll_rowcount
	IF Len(tab_1.tabpage_4.dw_4.GetItemString(ll_index, 1)) > 0 THEN
		ls_syntax = ls_syntax + '(' + tab_1.tabpage_4.dw_4.GetItemString(ll_index, 1) + ' ' + &
		                        tab_1.tabpage_4.dw_4.GetItemString(ll_index, 2) + ' ' + &
										tab_1.tabpage_4.dw_4.GetItemString(ll_index, 3) + ' ) ' + &
										tab_1.tabpage_4.dw_4.GetItemString(ll_index, 4) + '~r~n'
	END IF
NEXT

ll_rowcount = tab_1.tabpage_1.dw_7.RowCount()

IF ll_rowcount > 0 THEN
	ls_syntax = ls_syntax + 'ORDER BY '
END IF

FOR ll_index = 1 TO ll_rowcount
	IF ll_index = ll_rowcount THEN	
		ls_syntax = ls_syntax + tab_1.tabpage_1.dw_7.GetItemString(ll_index, 1) + ' ' + &
		                        tab_1.tabpage_1.dw_7.GetItemString(ll_index, 2) + '~r~n'
	ELSE
		ls_syntax = ls_syntax + tab_1.tabpage_1.dw_7.GetItemString(ll_index, 1) + ' ' + &
		                        tab_1.tabpage_1.dw_7.GetItemString(ll_index, 2) + ',~r~n'
	END IF
NEXT

RETURN ls_syntax
end function

public function integer of_addtable ();DataStore lds
u_dw_table ldw_table
Long ll_item, ll_pos, ll_prev, ll_x
String ls_name, ls_selected

lds = CREATE DataStore
lds.DataObject = 'd_table_list_display'

inv_schema.of_ChangeSQL(inv_schema.TABLELIST, itr.dbms, lds, '')

lds.SetTransObject(itr)
lds.Retrieve()

OpenWithParm(w_tablelist, lds)

ls_selected = Message.StringParm

IF ls_selected = '@@CANCEL@@' THEN
	DESTROY lds
	RETURN 0
END IF

ll_pos = Pos(ls_selected, ';')
ll_prev = 1

DO UNTIL ll_pos = 0
	
	ls_name = Mid(ls_selected, ll_prev, ll_pos - ll_prev)
	
	ll_x = of_GetRightMost()
	
	ll_item = UpperBound(idw_table) + 1
	idw_table[ll_item] = ldw_table
	
	of_GetParentWindow().OpenUserObject(idw_table[ll_item])
	idw_table[ll_item].of_SetParent(THIS)
	SetParent(Handle(idw_table[ll_item]), Handle(uo_client))
	
	inv_schema.of_ChangeSQL(inv_schema.TABLEEXTRACT, itr.dbms, idw_table[ll_item], ls_name)
	
	idw_table[ll_item].of_SetTable(ls_name)
	idw_table[ll_item].of_SetIteration(of_GetTableIteration(ls_name),of_GetTableName(ls_name))
	idw_table[ll_item].SetTransObject(itr)
	idw_table[ll_item].Retrieve()
	idw_table[ll_item].X = ll_x
	
	ll_prev = ll_pos + 1
	ll_pos = Pos(ls_selected, ';', ll_prev)

LOOP

of_LoadColumnList()

DESTROY lds

RETURN 1
end function

public function string of_gettablename (string as_table);String ls_tablename
Long ll_iteration

ll_iteration = of_GetTableIteration(as_table)

IF ll_iteration > 1 THEN
	ls_tablename = as_table + '_' + String(ll_iteration)
ELSE
	ls_tablename = as_table
END IF

RETURN ls_tablename
end function

public function integer of_gettableiteration (string as_table);Integer li_iteration
Long ll_index, ll_rowcount

ll_rowcount = UpperBound(idw_table)

FOR ll_index = 1 TO ll_rowcount
	
	IF IsValid(idw_table[ll_index]) THEN
		IF idw_table[ll_index].is_table = as_table THEN
			IF idw_table[ll_index].ii_iteration > li_iteration THEN
				li_iteration = idw_table[ll_index].ii_iteration
			END IF
		END IF
	END IF
	
NEXT

li_iteration = li_iteration + 1

RETURN li_iteration
end function

public function integer of_closetable (u_dw_table adw_table);Long ll_index, ll_rowcount, ll_found
u_dw_table ldw
String ls_table

ll_rowcount = UpperBound(idw_table)

FOR ll_index = 1 TO ll_rowcount
	
	IF IsValid(idw_table[ll_index]) THEN
		IF idw_table[ll_index] = adw_table THEN
			ls_table = idw_table[ll_index].Title + '.%'
			idw_table[ll_index] = ldw
		END IF
	END IF
	
NEXT

of_LoadColumnList()

ll_rowcount = tab_1.tp_select.dw_6.RowCount()
ll_found = tab_1.tp_select.dw_6.Find('table_column like "' + ls_table + '"', 1, ll_rowcount)

DO UNTIL ll_found = 0
	tab_1.tp_select.dw_6.DeleteRow(ll_found)
	ll_found = tab_1.tp_select.dw_6.Find('table_column like "' + ls_table + '"', 1, ll_rowcount)

LOOP

RETURN 1
end function

public function long of_getrightmost ();Long ll_index, ll_rowcount
Long ll_x

ll_rowcount = UpperBound(idw_table)

FOR ll_index = 1 TO ll_rowcount
	
	IF IsValid(idw_table[ll_index]) THEN
		IF idw_table[ll_index].X + idw_table[ll_index].Width > ll_x THEN
			ll_x = idw_table[ll_index].X + idw_table[ll_index].Width + 100
		END IF
	END IF
	
NEXT

RETURN ll_x
end function

public function string of_getjoinsyntax ();String ls_join, ls_tableA, ls_tableB, ls_where
Long ll_index, ll_rowcount

ll_rowcount = UpperBound(uo_client.iuo_join)

FOR ll_index = 1 TO ll_rowcount
	
	IF uo_client.iuo_join[ll_index].Visible THEN
		ls_where = uo_client.iuo_join[ll_index].iuo_relationship.Text
		ls_tableA = uo_client.iuo_join[ll_index].idw_tableA.Title + '.' + uo_client.iuo_join[ll_index].idw_tableA.GetItemString(uo_client.iuo_join[ll_index].ii_rowA, 1)
	   ls_tableB = uo_client.iuo_join[ll_index].idw_tableB.Title + '.' + uo_client.iuo_join[ll_index].idw_tableB.GetItemString(uo_client.iuo_join[ll_index].ii_rowB, 1)
		ls_join = ls_join + '(' + ls_tableA + ' ' + ' ' + ls_where + ' ' + ls_tableB + ') AND ~r~n'
	END IF
	
NEXT

ls_join = Left(ls_join, Len(ls_join) - 6)

RETURN ls_join

end function

public function integer of_rearrange ();Long ll_index, ll_rowcount

ll_rowcount = UpperBound(idw_table)

FOR ll_index = 1 TO ll_rowcount
	
	IF IsValid(idw_table[ll_index]) THEN
		idw_table[ll_index].TriggerEvent('positionchanging')
	END IF
	
NEXT

RETURN 1
end function

public function integer of_loadtable (string as_table);DataStore lds
u_dw_table ldw_table
Long ll_item, ll_pos, ll_prev, ll_x
String ls_name, ls_selected

ls_name = as_table
	
ll_x = of_GetRightMost()

ll_item = UpperBound(idw_table) + 1
idw_table[ll_item] = ldw_table

of_GetParentWindow().OpenUserObject(idw_table[ll_item])
idw_table[ll_item].of_SetParent(THIS)
SetParent(Handle(idw_table[ll_item]), Handle(uo_client))

inv_schema.of_ChangeSQL(inv_schema.TABLEEXTRACT, itr.dbms, idw_table[ll_item], ls_name)

idw_table[ll_item].of_SetTable(ls_name)
idw_table[ll_item].of_SetIteration(of_GetTableIteration(ls_name),of_GetTableName(ls_name))
idw_table[ll_item].SetTransObject(itr)
idw_table[ll_item].Retrieve()
idw_table[ll_item].X = ll_x

of_LoadColumnList()

DESTROY lds

RETURN 1
end function

public function integer of_openquery ();String ls_path, ls_file

IF GetFileOpenName ( "Select File", &
                          ls_path, ls_file, "QRY", &
							     "Query Files (*.qry),*.qry" , "C:\My Documents", 32770) <> 1 THEN
	RETURN 0
ELSE
	RETURN of_OpenQuery(ls_path)
END IF
end function

public function integer of_closealltables ();Long ll_index, ll_rowcount

ll_rowcount = UpperBound(idw_table)

FOR ll_index = 1 TO ll_rowcount
	IF IsValid(idw_table[ll_index]) THEN
		idw_table[ll_index].Visible = FALSE
		idw_table[ll_index].Trigger Event SysCommand(61536,0,0)
	END IF
NEXT

RETURN 1
end function

public function u_dw_table of_gettable (string as_table);Long ll_index, ll_rowcount

ll_rowcount = UpperBound(idw_table)

FOR ll_index = 1 TO ll_rowcount
	
	IF IsValid(idw_table[ll_index]) THEN
		IF idw_table[ll_index].Title = as_table THEN
			RETURN idw_table[ll_index]
		END IF
	END IF
	
NEXT
end function

public function integer of_savequeryas (string as_file);String ls_path, ls_file
Int li_rc, il_file
Long ll_index, ll_rowcount, ll_count
String ls_rows
Long ll_row

is_file = as_file

tab_1.tp_select.dw_6.AcceptText( )
tab_1.tabpage_2.dw_2.AcceptText( )
tab_1.tabpage_3.dw_8.AcceptText( )
tab_1.tabpage_4.dw_4.AcceptText( )
tab_1.tabpage_1.dw_7.AcceptText( )
tab_1.tabpage_5.dw_5.AcceptText( )

il_file = FileOpen(is_file, LineMode!, Write!, LockWrite!, Replace!)

FileWrite(il_file, '[SELECT]')
ll_rowcount = tab_1.tp_select.dw_6.RowCount()

FOR ll_index = 1 TO ll_rowcount
	FileWrite(il_file, String(ll_index) + '="' + tab_1.tp_select.dw_6.GetItemString(ll_index, 1) + '"')
NEXT

FileWrite(il_file, '')

FileWrite(il_file, '[COMPUTE]')
ll_rowcount = tab_1.tabpage_5.dw_5.RowCount()

FOR ll_index = 1 TO ll_rowcount
	FileWrite(il_file, String(ll_index) + '="' + tab_1.tabpage_5.dw_5.GetItemString(ll_index, 1) + '"')
NEXT

FileWrite(il_file, '')

FileWrite(il_file, '[FROM]')

ll_rowcount = UpperBound(idw_table)
ll_count = 0
FOR ll_index = 1 TO ll_rowcount
	IF IsValid(idw_table[ll_index]) THEN
		ll_count++
		FileWrite(il_file, String(ll_count) + '=' + idw_table[ll_index].is_table)
	END IF
NEXT

FileWrite(il_file, '')

FileWrite(il_file, '[WHERE]')
ll_rowcount = tab_1.tabpage_2.dw_2.RowCount()

FOR ll_index = 1 TO ll_rowcount
	FileWrite(il_file, String(ll_index) + '="' + tab_1.tabpage_2.dw_2.GetItemString(ll_index, 1) +'~t'+ &
																tab_1.tabpage_2.dw_2.GetItemString(ll_index, 2) +'~t'+ &
																tab_1.tabpage_2.dw_2.GetItemString(ll_index, 3) +'~t'+ &
																tab_1.tabpage_2.dw_2.GetItemString(ll_index, 4) + '"')
NEXT
FileWrite(il_file, '')

FileWrite(il_file, '[GROUPBY]')
ll_rowcount = tab_1.tabpage_3.dw_8.RowCount()

FOR ll_index = 1 TO ll_rowcount
	FileWrite(il_file, String(ll_index) + '="' + tab_1.tabpage_3.dw_8.GetItemString(ll_index,1) + '"')
NEXT
FileWrite(il_file, '')

FileWrite(il_file, '[HAVING]')
ll_rowcount = tab_1.tabpage_4.dw_4.RowCount()

FOR ll_index = 1 TO ll_rowcount
	FileWrite(il_file, String(ll_index) + '="' + tab_1.tabpage_4.dw_4.GetItemString(ll_index, 1) +'~t'+ &
																tab_1.tabpage_4.dw_4.GetItemString(ll_index, 2) +'~t'+ &
																tab_1.tabpage_4.dw_4.GetItemString(ll_index, 3) +'~t'+ &
																tab_1.tabpage_4.dw_4.GetItemString(ll_index, 4) + '"')
NEXT
FileWrite(il_file, '')

FileWrite(il_file, '[ORDERBY]')
ll_rowcount = tab_1.tabpage_1.dw_7.RowCount()

FOR ll_index = 1 TO ll_rowcount
	FileWrite(il_file, String(ll_index) + '="' + tab_1.tabpage_1.dw_7.GetItemString(ll_index, 1) +'~t'+&
																tab_1.tabpage_1.dw_7.GetItemString(ll_index, 2) + '"')
NEXT
FileWrite(il_file, '')

ll_rowcount = UpperBound(idw_table)
FOR ll_index = 1 TO ll_rowcount
	IF IsValid(idw_table[ll_index]) THEN
		FileWrite(il_file, '[' + idw_table[ll_index].of_GetTableName() + ']')
		FileWrite(il_file, 'X=' + String(idw_table[ll_index].X))
		FileWrite(il_file, 'Y=' + String(idw_table[ll_index].Y))
		FileWrite(il_file, 'Width=' + String(idw_table[ll_index].Width))
		FileWrite(il_file, 'Height=' + String(idw_table[ll_index].Height))
		
		ll_row = idw_table[ll_index].GetSelectedRow(0)
		ls_rows = ''
		
		DO UNTIL ll_row = 0
			ls_rows = ls_rows + String(ll_row) + ','
			ll_row = idw_table[ll_index].GetSelectedRow(ll_row)
		LOOP
		FileWrite(il_file, 'Rows="' + ls_rows + '"')
		
		FileWrite(il_file, '')
	END IF
NEXT

ll_rowcount = UpperBound(uo_client.iuo_join)
FOR ll_index = 1 TO ll_rowcount
	IF uo_client.iuo_join[ll_index].Visible THEN
		FileWrite(il_file, '[ln_' + String(ll_index) + ']')
		FileWrite(il_file, 'Visible="Y"')
		FileWrite(il_file, 'BeginX=' + String(uo_client.iuo_join[ll_index].BeginX))
		FileWrite(il_file, 'EndX=' + String(uo_client.iuo_join[ll_index].EndX))
		FileWrite(il_file, 'BeginY=' + String(uo_client.iuo_join[ll_index].BeginY))
		FileWrite(il_file, 'EndY=' + String(uo_client.iuo_join[ll_index].EndY))
		FileWrite(il_file, 'TableA="' + uo_client.iuo_join[ll_index].idw_tableA.Title + '"')
		FileWrite(il_file, 'TableB="' + uo_client.iuo_join[ll_index].idw_tableB.Title + '"')
		FileWrite(il_file, 'RowA="' + String(uo_client.iuo_join[ll_index].ii_rowA) + '"')
		FileWrite(il_file, 'RowB="' + String(uo_client.iuo_join[ll_index].ii_rowB) + '"')
		FileWrite(il_file, 'Relationship="' + String(uo_client.iuo_join[ll_index].iuo_relationship.Text) + '"')
		
		FileWrite(il_file, '')
	END IF
NEXT

FileClose(il_file)


RETURN 1
end function

public function integer of_savequeryas ();String ls_path, ls_file

IF GetFileSaveName ( "Select File", &
                          ls_path, ls_file, "QRY", &
							     "Query Files (*.qry),*.qry" , "C:\My Documents", 32770) <> 1 THEN
	RETURN 0
ELSE
	RETURN of_SaveQueryAs(ls_path)
END IF
end function

public function integer of_savequery ();IF Len(Trim(is_file)) = 0 THEN
	RETURN of_SaveQueryAs()
ELSE
	RETURN of_SaveQueryAs(is_file)
END IF
end function

public function integer of_openquery (string as_file);String ls_data
Long ll_index, ll_rowcount, ll_count
String ls_table
String ls_rows[]
u_dw_table ldw_table

is_file = as_file
	
of_CloseAllTables()

//SELECT
ll_count = 1
ls_data = ProfileString(is_file, 'SELECT', String(ll_count), '')
tab_1.tp_select.dw_6.Reset()

DO UNTIL ls_data = ''
	tab_1.tp_select.dw_6.ImportString(ls_data)
	ll_count ++
	ls_data = ProfileString(is_file, 'SELECT', String(ll_count), '')
LOOP

//Compute	
ll_count = 1
ls_data = ProfileString(is_file, 'COMPUTE', String(ll_count), '')
tab_1.tabpage_5.dw_5.Reset()

DO UNTIL ls_data = ''
	tab_1.tabpage_5.dw_5.ImportString(ls_data)
	ll_count ++
	ls_data = ProfileString(is_file, 'COMPUTE', String(ll_count), '')
LOOP

IF tab_1.tabpage_5.dw_5.RowCount() = 0 THEN
	tab_1.tabpage_5.dw_5.InsertRow(0)
END IF

//FROM
ll_count = 1
ls_data = ProfileString(is_file, 'FROM', String(ll_count), '')

DO UNTIL ls_data = ''
	of_LoadTable(ls_data)
	ll_count ++
	ls_data = ProfileString(is_file, 'FROM', String(ll_count), '')
LOOP

//WHERE
ll_count = 1
ls_data = ProfileString(is_file, 'WHERE', String(ll_count), '')
tab_1.tabpage_2.dw_2.Reset()

DO UNTIL ls_data = ''
	tab_1.tabpage_2.dw_2.ImportString(ls_data)
	ll_count ++
	ls_data = ProfileString(is_file, 'WHERE', String(ll_count), '')
LOOP

//GROUP BY
ll_count = 1
ls_data = ProfileString(is_file, 'GROUPBY', String(ll_count), '')
tab_1.tabpage_3.dw_8.Reset()

DO UNTIL ls_data = ''
	tab_1.tabpage_3.dw_8.ImportString(ls_data)
	ll_count ++
	ls_data = ProfileString(is_file, 'GROUPBY', String(ll_count), '')
LOOP

//HAVING
ll_count = 1
ls_data = ProfileString(is_file, 'HAVING', String(ll_count), '')
tab_1.tabpage_4.dw_4.Reset()

DO UNTIL ls_data = ''
	tab_1.tabpage_4.dw_4.ImportString(ls_data)
	ll_count ++
	ls_data = ProfileString(is_file, 'HAVING', String(ll_count), '')
LOOP

//ORDER BY
ll_count = 1
ls_data = ProfileString(is_file, 'ORDERBY', String(ll_count), '')
tab_1.tabpage_1.dw_7.Reset()

DO UNTIL ls_data = ''
	tab_1.tabpage_1.dw_7.ImportString(ls_data)
	ll_count ++
	ls_data = ProfileString(is_file, 'ORDERBY', String(ll_count), '')
LOOP

IF tab_1.tabpage_2.dw_2.RowCount() = 0 THEN
	tab_1.tabpage_2.dw_2.InsertRow(0)
END IF

IF tab_1.tabpage_4.dw_4.RowCount() = 0 THEN
	tab_1.tabpage_4.dw_4.InsertRow(0)
END IF

ll_rowcount = UpperBound(idw_table)

FOR ll_index = 1 TO ll_rowcount
	IF IsValid(idw_table[ll_index]) THEN
		idw_table[ll_index].X = ProfileInt(is_file, idw_table[ll_index].of_GetTableName(), 'X', idw_table[ll_index].X)
		idw_table[ll_index].Y = ProfileInt(is_file, idw_table[ll_index].of_GetTableName(), 'Y', idw_table[ll_index].Y)
		idw_table[ll_index].Width = ProfileInt(is_file, idw_table[ll_index].of_GetTableName(), 'Width', idw_table[ll_index].Width)
		idw_table[ll_index].Height = ProfileInt(is_file, idw_table[ll_index].of_GetTableName(), 'Height', idw_table[ll_index].Height)
		
		of_ParseToArray(ProfileString(is_file, idw_table[ll_index].of_GetTableName(), 'Rows', ''), ',', ls_rows)
		
		FOR ll_count = 1 TO UpperBound(ls_rows)
			
			IF IsNumber(ls_rows[ll_count]) THEN
				idw_table[ll_index].SelectRow(Long(ls_rows[ll_count]), TRUE)
			END IF
			
		NEXT
	END IF
NEXT

ll_rowcount = UpperBound(uo_client.iuo_join)

FOR ll_index = 1 TO ll_rowcount
	IF ProfileString(is_file, 'ln_' + String(ll_index), 'Visible', 'N') = 'Y' THEN
		uo_client.iuo_join[ll_index].Visible = TRUE
		uo_client.iuo_join[ll_index].iuo_relationship.Visible = TRUE
		uo_client.iuo_join[ll_index].BeginX = ProfileInt(is_file, 'ln_' + String(ll_index), 'BeginX', uo_client.iuo_join[ll_index].BeginX)
		uo_client.iuo_join[ll_index].EndX = ProfileInt(is_file, 'ln_' + String(ll_index), 'EndX', uo_client.iuo_join[ll_index].EndX)
		uo_client.iuo_join[ll_index].BeginY = ProfileInt(is_file, 'ln_' + String(ll_index), 'BeginY', uo_client.iuo_join[ll_index].BeginY)
		uo_client.iuo_join[ll_index].EndY = ProfileInt(is_file, 'ln_' + String(ll_index), 'BeginX', uo_client.iuo_join[ll_index].EndY)
		uo_client.iuo_join[ll_index].ii_rowA = ProfileInt(is_file, 'ln_' + String(ll_index), 'RowA', 0)
		uo_client.iuo_join[ll_index].ii_rowB = ProfileInt(is_file, 'ln_' + String(ll_index), 'RowB', 0)
		uo_client.iuo_join[ll_index].iuo_relationship.Text = ProfileString(is_file, 'ln_' + String(ll_index), 'Relationship', '=')
		
		ls_table = ProfileString(is_file, 'ln_' + String(ll_index), 'TableA', '')
		
		IF Len(Trim(ls_table)) = 0 THEN
			Continue
		END IF
		
		ldw_table = of_GetTable(ls_table)
		
		ldw_table.iuo_join[UpperBound(ldw_table.iuo_join) + 1] = uo_client.iuo_join[ll_index]
		ldw_table.is_position[UpperBound(ldw_table.iuo_join)] = 'B'
		uo_client.iuo_join[ll_index].idw_tableA = ldw_table
		
		ls_table = ProfileString(is_file, 'ln_' + String(ll_index), 'TableB', '')
		
		IF Len(Trim(ls_table)) = 0 THEN
			Continue
		END IF
		
		ldw_table = of_GetTable(ls_table)
		
		ldw_table.iuo_join[UpperBound(ldw_table.iuo_join) + 1] = uo_client.iuo_join[ll_index]
		ldw_table.is_position[UpperBound(ldw_table.iuo_join)] = 'E'
		uo_client.iuo_join[ll_index].idw_tableB = ldw_table
		
		uo_client.iuo_join[ll_index].of_PositionRelationship()
	END IF
NEXT

RETURN 1
end function

public function integer of_savereport ();
//tab_1.tabpage_7.dw_9.SaveAs()

RETURN 1
end function

public function integer of_newquery ();
of_CloseAllTables()

tab_1.tabpage_2.dw_2.Reset()
tab_1.tabpage_2.dw_2.InsertRow(0)
tab_1.tabpage_1.dw_7.Reset()
tab_1.tabpage_3.dw_8.Reset()
tab_1.tabpage_4.dw_4.Reset()
tab_1.tabpage_4.dw_4.InsertRow(0)
tab_1.tp_select.dw_6.Reset()
tab_1.tabpage_6.uo_1.of_SetText('')
//tab_1.tabpage_7.dw_9.DataObject = ''
tab_1.tabpage_5.dw_5.Reset()
tab_1.tabpage_5.dw_5.InsertRow(0)

RETURN 1
end function

public function integer of_parsetoarray (string as_source, string as_delimiter, ref string as_array[]);long		ll_DelLen, ll_Pos, ll_Count, ll_Start, ll_Length
string 	ls_holder

//Check for NULL
IF IsNull(as_source) or IsNull(as_delimiter) Then
	long ll_null
	SetNull(ll_null)
	Return ll_null
End If

//Check for at leat one entry
If Trim (as_source) = '' Then
	Return 0
End If

//Get the length of the delimeter
ll_DelLen = Len(as_Delimiter)

ll_Pos =  Pos(Upper(as_source), Upper(as_Delimiter))

//Only one entry was found
if ll_Pos = 0 then
	as_Array[1] = as_source
	return 1
end if

//More than one entry was found - loop to get all of them
ll_Count = 0
ll_Start = 1
Do While ll_Pos > 0
	
	//Set current entry
	ll_Length = ll_Pos - ll_Start
	ls_holder = Mid (as_source, ll_start, ll_length)

	// Update array and counter
	ll_Count ++
	as_Array[ll_Count] = ls_holder
	
	//Set the new starting position
	ll_Start = ll_Pos + ll_DelLen

	ll_Pos =  Pos(Upper(as_source), Upper(as_Delimiter), ll_Start)
Loop

//Set last entry
ls_holder = Mid (as_source, ll_start, Len (as_source))

// Update array and counter if necessary
if Len (ls_holder) > 0  then
	ll_count++
	as_Array[ll_Count] = ls_holder
end if

//Return the number of entries found
Return ll_Count
end function

public function integer of_copy ();CHOOSE CASE tab_1.SelectedTab
	CASE 1
	CASE 2
		tab_1.tabpage_2.dw_2.Copy()
	CASE 3
	CASE 4
		tab_1.tabpage_4.dw_4.Copy()
	CASE 5
	CASE 6
	CASE 7
		tab_1.tabpage_6.uo_1.of_Copy()
END CHOOSE

RETURN 1
end function

public function integer of_cut ();CHOOSE CASE tab_1.SelectedTab
	CASE 1
	CASE 2
		tab_1.tabpage_2.dw_2.Cut()
	CASE 3
	CASE 4
		tab_1.tabpage_4.dw_4.Cut()
	CASE 5
	CASE 6
	CASE 7
		tab_1.tabpage_6.uo_1.of_Cut()
END CHOOSE

RETURN 1
end function

public function integer of_paste ();CHOOSE CASE tab_1.SelectedTab
	CASE 1
	CASE 2
		tab_1.tabpage_2.dw_2.Paste()
	CASE 3
	CASE 4
		tab_1.tabpage_4.dw_4.Paste()
	CASE 5
	CASE 6
	CASE 7
		tab_1.tabpage_6.uo_1.of_Paste()
END CHOOSE

RETURN 1
end function

public function integer of_undo ();CHOOSE CASE tab_1.SelectedTab
	CASE 1
	CASE 2
		tab_1.tabpage_2.dw_2.Undo()
	CASE 3
	CASE 4
		tab_1.tabpage_4.dw_4.Undo()
	CASE 5
	CASE 6
	CASE 7
		tab_1.tabpage_6.uo_1.of_Undo()
END CHOOSE

RETURN 1
end function

public function integer of_selectall ();CHOOSE CASE tab_1.SelectedTab
	CASE 1
	CASE 2
//		tab_1.tabpage_2.dw_2.SelectAll()
	CASE 3
	CASE 4
//		tab_1.tabpage_4.dw_4.SelectAll()
	CASE 5
	CASE 6
	CASE 7
		tab_1.tabpage_6.uo_1.of_SelectAll()
END CHOOSE

RETURN 1
end function

on u_cst_querybuilder.create
this.st_horz=create st_horz
this.uo_client=create uo_client
this.tab_1=create tab_1
this.Control[]={this.st_horz,&
this.uo_client,&
this.tab_1}
end on

on u_cst_querybuilder.destroy
destroy(this.st_horz)
destroy(this.uo_client)
destroy(this.tab_1)
end on

event constructor;TriggerEvent('resize')
end event

type st_horz from u_splitbar within u_cst_querybuilder
integer y = 732
integer width = 2574
integer height = 12
string pointer = "SizeNS!"
end type

event constructor;call super::constructor;of_SetPosition('H')
of_SetBackColor(PARENT.BackColor)
iuo_Parent = PARENT
end event

event mousemove;call super::mousemove;tab_1.SetRedraw(TRUE)
uo_client.SetRedraw(TRUE)
end event

event lbuttonup;call super::lbuttonup;uo_client.Height = THIS.Y - uo_client.Y - 5
tab_1.Y = THIS.Y + THIS.Height
tab_1.Height = PARENT.Height - tab_1.Y
end event

type uo_client from u_client within u_cst_querybuilder
integer y = 4
integer width = 2574
integer height = 724
integer taborder = 30
end type

on uo_client.destroy
call u_client::destroy
end on

event rbuttondown;call super::rbuttondown;of_AddTable()
end event

type tab_1 from tab within u_cst_querybuilder
integer y = 748
integer width = 2574
integer height = 612
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
tabposition tabposition = tabsonbottom!
integer selectedtab = 3
tp_select tp_select
tabpage_5 tabpage_5
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_1 tabpage_1
tabpage_6 tabpage_6
end type

on tab_1.create
this.tp_select=create tp_select
this.tabpage_5=create tabpage_5
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_1=create tabpage_1
this.tabpage_6=create tabpage_6
this.Control[]={this.tp_select,&
this.tabpage_5,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_1,&
this.tabpage_6}
end on

on tab_1.destroy
destroy(this.tp_select)
destroy(this.tabpage_5)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_1)
destroy(this.tabpage_6)
end on

event selectionchanged;String ls_presentation, ls_sql, ls_syntax, ls_error

CHOOSE CASE newindex
	CASE 7
		tabpage_6.uo_1.of_SetText(of_GetSyntax())
		tabpage_6.uo_1.of_Format()

END CHOOSE
end event

type tp_select from userobject within tab_1
event create ( )
event destroy ( )
event resize pbm_size
integer x = 18
integer y = 16
integer width = 2537
integer height = 484
long backcolor = 67108864
string text = "Select"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_6 dw_6
end type

on tp_select.create
this.dw_6=create dw_6
this.Control[]={this.dw_6}
end on

on tp_select.destroy
destroy(this.dw_6)
end on

event resize;dw_6.Resize(NewWidth, NewHeight - 10)
end event

type dw_6 from datawindow within tp_select
integer width = 914
integer height = 276
integer taborder = 50
string dragicon = "drag.ico"
string title = "none"
string dataobject = "d_columnlist"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;IF row > 0 THEN
	SetRow(row)
	Drag(Begin!)
END IF
end event

event dragdrop;IF Source.ClassName() = THIS.ClassName() THEN
	THIS.RowsMove(THIS.GetRow(), THIS.GetRow(), Primary!, THIS, row, Primary!)
END IF
end event

type tabpage_5 from userobject within tab_1
event resize pbm_size
integer x = 18
integer y = 16
integer width = 2537
integer height = 484
long backcolor = 67108864
string text = "Compute"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_5 dw_5
end type

event resize;dw_5.Resize(NewWidth, NewHeight - 10)
end event

on tabpage_5.create
this.dw_5=create dw_5
this.Control[]={this.dw_5}
end on

on tabpage_5.destroy
destroy(this.dw_5)
end on

type dw_5 from u_dw_grid within tabpage_5
integer taborder = 40
string dataobject = "d_compute"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;InsertRow(0)
of_SetStyleXP()
end event

event rbuttondown;call super::rbuttondown;Long ll_y, ll_x
m_clause lm_clause

IF Row > 0 THEN

	ll_y = of_GetParentWindow().PointerY()
	ll_X = of_GetParentWindow().PointerX()
	
	IF GetRow() <> Row THEN
		SetRow(row)
	END IF
	
	lm_clause = CREATE m_clause
	lm_clause.of_SetDW(THIS)
	lm_clause.m_deleteclause.Text = 'Delete Expression'
	lm_clause.m_insertclause.Text = 'Insert Expression'
	lm_clause.PopMenu ( ll_x, ll_y )

END IF
end event

type tabpage_2 from userobject within tab_1
event resize pbm_size
integer x = 18
integer y = 16
integer width = 2537
integer height = 484
long backcolor = 67108864
string text = "Where"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_2 dw_2
end type

event resize;dw_2.Resize(NewWidth, NewHeight - 10)
end event

on tabpage_2.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_2)
end on

type dw_2 from u_dw_grid within tabpage_2
integer taborder = 50
string dataobject = "d_where"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event rbuttondown;call super::rbuttondown;Long ll_y, ll_x
m_clause lm_clause

IF Row > 0 THEN

	ll_y = of_GetParentWindow().PointerY()
	ll_X = of_GetParentWindow().PointerX()
	
	IF GetRow() <> Row THEN
		SetRow(row)
	END IF
	
	IF dwo.Type = 'column' THEN
		IF String(dwo.Name) <> GetColumnName() THEN
			SetColumn(String(dwo.Name))
		END IF
	END IF
	
	lm_clause = CREATE m_clause
	lm_clause.of_SetDW(THIS)
	lm_clause.PopMenu ( ll_x, ll_y )

END IF
end event

event constructor;call super::constructor;THIS.InsertRow(0)
of_SetStyleXP()
end event

event itemchanged;call super::itemchanged;IF dwo.name = 'logical' AND row = THIS.RowCount() THEN
	THIS.InsertRow(0)
END IF

IF row > 1 THEN
	IF Len(Trim(THIS.GetItemString(row - 1, 'logical'))) = 0 THEN
		THIS.SetItem(row - 1, 'logical', 'And')
	END IF
END IF
end event

type tabpage_3 from userobject within tab_1
event resize pbm_size
integer x = 18
integer y = 16
integer width = 2537
integer height = 484
long backcolor = 67108864
string text = "Group By"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_8 dw_8
dw_3 dw_3
end type

event resize;dw_3.Resize((NewWidth / 2) - 7, NewHeight - 10)
dw_8.Resize((NewWidth / 2) - 7, NewHeight - 10)
dw_8.X = dw_3.Width + 14

end event

on tabpage_3.create
this.dw_8=create dw_8
this.dw_3=create dw_3
this.Control[]={this.dw_8,&
this.dw_3}
end on

on tabpage_3.destroy
destroy(this.dw_8)
destroy(this.dw_3)
end on

type dw_8 from datawindow within tabpage_3
integer x = 695
integer width = 686
integer height = 400
integer taborder = 30
string dragicon = "drag.ico"
string title = "none"
string dataobject = "d_columnlist"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dragdrop;DataWindow ldw
Long ll_row

IF Source.ClassName() = 'dw_3' THEN
	ldw = Source
	
	ll_row = THIS.InsertRow(row)
	
	THIS.SetItem(ll_row, 1, ldw.getitemstring(ldw.GetRow(),1))
	
END IF

IF Source.ClassName() = THIS.ClassName() THEN
	THIS.RowsMove(THIS.GetRow(), THIS.GetRow(), Primary!, THIS, row, Primary!)
END IF
end event

event clicked;IF row > 0 THEN
	SetRow(row)
	Drag(Begin!)
END IF
end event

type dw_3 from datawindow within tabpage_3
integer width = 686
integer height = 400
integer taborder = 30
string dragicon = "drag.ico"
string title = "none"
string dataobject = "d_columnlist"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;IF row > 0 THEN
	SetRow(row)
	Drag(Begin!)
END IF
end event

event dragdrop;DataWindow ldw
Long ll_row

IF Source.ClassName() = 'dw_8' THEN
	ldw = Source
	
	ldw.DeleteRow(ldw.GetRow())
	
END IF
end event

type tabpage_4 from userobject within tab_1
event resize pbm_size
integer x = 18
integer y = 16
integer width = 2537
integer height = 484
long backcolor = 67108864
string text = "Having"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_4 dw_4
end type

event resize;dw_4.Resize(NewWidth, NewHeight - 10)
end event

on tabpage_4.create
this.dw_4=create dw_4
this.Control[]={this.dw_4}
end on

on tabpage_4.destroy
destroy(this.dw_4)
end on

type dw_4 from u_dw_grid within tabpage_4
integer taborder = 60
string dataobject = "d_where"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;THIS.InsertRow(0)
of_SetStyleXP()
end event

event itemchanged;call super::itemchanged;IF dwo.name = 'logical' AND row = THIS.RowCount() THEN
	THIS.InsertRow(0)
END IF

IF row > 1 THEN
	IF Len(Trim(THIS.GetItemString(row - 1, 'logical'))) = 0 THEN
		THIS.SetItem(row - 1, 'logical', 'And')
	END IF
END IF
end event

event rbuttondown;call super::rbuttondown;Long ll_y, ll_x
m_clause lm_clause

IF Row > 0 THEN

	ll_y = of_GetParentWindow().PointerY()
	ll_X = of_GetParentWindow().PointerX()
	
	IF GetRow() <> Row THEN
		SetRow(row)
	END IF
	
	IF dwo.Type = 'column' THEN
		IF String(dwo.Name) <> GetColumnName() THEN
			SetColumn(String(dwo.Name))
		END IF
	END IF
	
	lm_clause = CREATE m_clause
	lm_clause.of_SetDW(THIS)
	lm_clause.PopMenu ( ll_x, ll_y )

END IF
end event

type tabpage_1 from userobject within tab_1
event resize pbm_size
integer x = 18
integer y = 16
integer width = 2537
integer height = 484
long backcolor = 67108864
string text = "Order By"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_7 dw_7
dw_1 dw_1
end type

event resize;dw_1.Resize((NewWidth / 2) - 7, NewHeight - 10)
dw_7.Resize((NewWidth / 2) - 7, NewHeight - 10)
dw_7.X = dw_1.Width + 14

end event

on tabpage_1.create
this.dw_7=create dw_7
this.dw_1=create dw_1
this.Control[]={this.dw_7,&
this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_7)
destroy(this.dw_1)
end on

type dw_7 from datawindow within tabpage_1
integer x = 695
integer width = 686
integer height = 400
integer taborder = 30
string dragicon = "drag.ico"
string title = "none"
string dataobject = "d_columnlistsort"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dragdrop;DataWindow ldw
Long ll_row

IF Source.ClassName() = 'dw_1' THEN
	ldw = Source
	
	ll_row = THIS.InsertRow(row)
	
	THIS.SetItem(ll_row, 1, ldw.getitemstring(ldw.GetRow(),1))
	THIS.SetItem(ll_row, 2, 'Asc')
	
END IF

IF Source.ClassName() = THIS.ClassName() THEN
	THIS.RowsMove(THIS.GetRow(), THIS.GetRow(), Primary!, THIS, row, Primary!)
END IF
end event

event clicked;IF row > 0 AND dwo.Name <> 'sort_order' THEN
	SetRow(row)
	Drag(Begin!)
END IF
end event

type dw_1 from datawindow within tabpage_1
integer width = 686
integer height = 400
integer taborder = 10
string dragicon = "drag.ico"
string title = "none"
string dataobject = "d_columnlist"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;IF row > 0 THEN
	SetRow(row)
	Drag(Begin!)
END IF
end event

event dragdrop;DataWindow ldw
Long ll_row

IF Source.ClassName() = 'dw_7' THEN
	ldw = Source
	
	ldw.DeleteRow(ldw.GetRow())
	
END IF
end event

type tabpage_6 from userobject within tab_1
event resize pbm_size
integer x = 18
integer y = 16
integer width = 2537
integer height = 484
long backcolor = 67108864
string text = "Syntax"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
uo_1 uo_1
end type

event resize;uo_1.Resize(NewWidth, NewHeight - 10)
end event

on tabpage_6.create
this.uo_1=create uo_1
this.Control[]={this.uo_1}
end on

on tabpage_6.destroy
destroy(this.uo_1)
end on

type uo_1 from u_scintilla within tabpage_6
integer width = 1490
integer height = 164
integer taborder = 50
end type

on uo_1.destroy
call u_scintilla::destroy
end on

event constructor;call super::constructor;uo_1.of_LineNumbers(FALSE)

uo_1.Resize(THIS.Width, THIS.Height - 5)


end event

