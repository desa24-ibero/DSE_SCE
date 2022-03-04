$PBExportHeader$u_dw_grid.sru
forward
global type u_dw_grid from datawindow
end type
end forward

global type u_dw_grid from datawindow
integer width = 686
integer height = 400
string title = "none"
boolean border = false
boolean livescroll = true
event dwmousemove pbm_dwnmousemove
event timer pbm_timer
event lbuttonup pbm_dwnlbuttonup
end type
global u_dw_grid u_dw_grid

type variables
String is_objectarray[]
String is_style = ''
String is_prev

protected:
n_cst_gridheader_hottrck inv_gridheader_hottrck
end variables

forward prototypes
public function integer of_adjustseparators ()
public function integer of_parsetoarray (string as_source, string as_delimiter, ref string as_array[])
public function integer of_setstylexp ()
public function long of_getgridwidth ()
public function integer of_destroystyle ()
public function integer of_setstyleclassic ()
public function integer of_resizeallcolumns ()
end prototypes

event dwmousemove;IF is_style = 'XP' THEN
	IF IsValid(inv_gridheader_hottrck) THEN
		
		IF Pos(Lower(GetBandAtPointer()),'header') > 0 THEN
			inv_gridheader_hottrck.event dwnmousemove( xpos, ypos, row, dwo)
		ELSE
			inv_gridheader_hottrck.event Process_timer()
			
		END IF
		
		of_AdjustSeparators()
		
	END IF
END IF

end event

event timer;IF IsValid(inv_gridheader_hottrck) THEN
	inv_gridheader_hottrck.event Process_timer()	
END IF
end event

public function integer of_adjustseparators ();String ls_x, ls_width, ls_return
Long ll_index, ll_count, ll_x, ll_width

ll_count = UpperBound(is_objectarray)

FOR ll_index = 1 TO ll_count
	
	ls_width = THIS.Describe(is_objectarray[ll_index] + '.width')
	ls_x = THIS.Describe(is_objectarray[ll_index] + '.x')
	
	ll_x = Long(ls_width) + Long(ls_x)
	
	IF ll_x > ll_width THEN
		ll_width = ll_x
	END IF
	
	ls_return = THIS.Modify(is_objectarray[ll_index] + '_line1.x1=' + String(ll_x))
	ls_return = THIS.Modify(is_objectarray[ll_index] + '_line1.x2=' + String(ll_x))
	ls_return = THIS.Modify(is_objectarray[ll_index] + '_line2.x1=' + String(ll_x + 3))
	ls_return = THIS.Modify(is_objectarray[ll_index] + '_line2.x2=' + String(ll_x + 3))
NEXT

//ll_width = of_GetGridWidth()

THIS.Modify('headerline1.x1="0"')
THIS.Modify('headerline2.x1="0"')
THIS.Modify('headerline3.x1="0"')

THIS.Modify('headerline1.x2="' + String(ll_width + 8) +'"')
THIS.Modify('headerline2.x2="' + String(ll_width + 8) +'"')
THIS.Modify('headerline3.x2="' + String(ll_width + 8) +'"')

RETURN 1
end function

public function integer of_parsetoarray (string as_source, string as_delimiter, ref string as_array[]);long		ll_DelLen, ll_Pos, ll_Count, ll_Start, ll_Length
string 	ls_holder

//Check for NULL
IF Len(Trim(as_source)) = 0 or Len(Trim(as_delimiter)) = 0 Then
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
	IF Right(ls_holder, 2) = '_t' THEN
		ll_Count ++
		as_Array[ll_Count] = ls_holder
	END IF
	
	//Set the new starting position
	ll_Start = ll_Pos + ll_DelLen

	ll_Pos =  Pos(Upper(as_source), Upper(as_Delimiter), ll_Start)
Loop

//Set last entry
ls_holder = Mid (as_source, ll_start, Len (as_source))

// Update array and counter if necessary
if Len (ls_holder) > 0  then
	IF Right(ls_holder, 2) = '_t' THEN
		ll_count++
		as_Array[ll_Count] = ls_holder
	END IF
end if

//Return the number of entries found
Return ll_Count
end function

public function integer of_setstylexp ();String ls_x, ls_width, ls_return, ls_text, ls_linecolor
Long ll_index, ll_count, ll_x, ll_width, ll_headerheight
Long ll_colheight
String ls_objects

ls_objects = THIS.Describe("Datawindow.Objects")

of_ParseToArray(ls_objects, '~t', is_objectarray)

is_style = 'XP'

of_DestroyStyle()

ll_headerheight = Long(THIS.Describe("DataWindow.Header.Height"))

IF ll_headerheight > 68 THEN
	ll_colheight = 110
	ll_headerheight = 124
ELSE
	ll_colheight = 64
	ll_headerheight = 80
END IF

ll_count = UpperBound(is_objectarray)

FOR ll_index = 1 TO ll_count
	
	ls_width = THIS.Describe(is_objectarray[ll_index] + '.width')
	ls_x = THIS.Describe(is_objectarray[ll_index] + '.x')
	
	ls_x = String(Long(ls_width) + Long(ls_x))
	
	ls_linecolor = String(RGB(199,197,178))
	
	THIS.Modify('Create line(' + &
	'band=foreground ' + &
	'x1="' + ls_x + '" y1="12" x2="' + ls_x + '" y2="' + String(ll_colheight) + '" ' + &
	'name=' + is_objectarray[ll_index] + '_line1 ' + &
	'visible="1" pen.style="0" pen.width="5" pen.color="' + ls_linecolor + '"  background.mode="2" background.color="' + ls_linecolor + '" )' )
	
	THIS.Modify('Create line(' + &
	'band=foreground ' + &
	'x1="' + String(Long(ls_x) + 3) + '" y1="12" x2="' + String(Long(ls_x) + 3) + '" y2="' + String(ll_colheight) + '" ' + &
	'name=' + is_objectarray[ll_index] + '_line2 ' + &
	'visible="1" pen.style="0" pen.width="5" pen.color="16777215"  background.mode="2" background.color="16777215" )' )
	
	ls_return = THIS.Modify(is_objectarray[ll_index] + '.y="8"')
	ls_return = THIS.Modify(is_objectarray[ll_index] + '.height="' + String(ll_colheight) + '"')
	ls_return = THIS.Modify(is_objectarray[ll_index] + '.border="0"')
	ls_return = THIS.Modify(is_objectarray[ll_index] + '.color="33554432"')
	ls_return = THIS.Modify(is_objectarray[ll_index] + '.background.color="67108864"')
	ls_return = THIS.Modify(is_objectarray[ll_index] + '.font.face="Tahoma"')
	ls_return = THIS.Modify(is_objectarray[ll_index] + '.font.height="-8"')
	
	//ls_text = THIS.Describe(is_objectarray[ll_index] + '.Text')
	//ls_return = THIS.Modify(is_objectarray[ll_index] + '.Text=  ' + Trim(ls_text))
NEXT

THIS.Modify("DataWindow.Header.Height='" + String(ll_headerheight) + "'")
THIS.Modify("DataWindow.Header.Color= '67108864'")

ll_width = of_GetGridWidth() + 8
//band=foreground
THIS.Modify('Create line(band=foreground x1="0" y1="' + String(ll_colheight + 4) + '" x2="' + String(ll_width) +'" y2="' + String(ll_colheight + 4) + '"  name=headerline1 visible="1" pen.style="0" pen.width="5" pen.color="10789024~tRGB(226,222,205)"  background.mode="2" background.color="16777215" )')
THIS.Modify('Create line(band=foreground x1="0" y1="' + String(ll_colheight + 8) + '" x2="' + String(ll_width) +'" y2="' + String(ll_colheight + 8) + '"  name=headerline2 visible="1" pen.style="0" pen.width="5" pen.color="10789024~tRGB(214,210,194)"  background.mode="2" background.color="16777215" )')
THIS.Modify('Create line(band=foreground x1="0" y1="' + String(ll_colheight + 12) + '" x2="' + String(ll_width) +'" y2="' + String(ll_colheight + 12) + '"  name=headerline3 visible="1" pen.style="0" pen.width="5" pen.color="10789024~tRGB(199,197,178)"  background.mode="2" background.color="16777215" )')

inv_gridheader_hottrck.of_Create_Hottrack_Effects()

RETURN 1
end function

public function long of_getgridwidth ();String ls_x, ls_width, ls_return
Long ll_index, ll_count, ll_x
Long ll_width = 0

ll_count = UpperBound(is_objectarray)

FOR ll_index = 1 TO ll_count
	
	ls_width = THIS.Describe(is_objectarray[ll_index] + '.width')
	ls_x = THIS.Describe(is_objectarray[ll_index] + '.x')
	
	ll_x = Long(ls_width) + Long(ls_x)
	
	IF ll_x > ll_width THEN
		ll_width = ll_x
	END IF
	
NEXT

RETURN ll_width
end function

public function integer of_destroystyle ();String ls_return
Long ll_index, ll_count

ll_count = UpperBound(is_objectarray)

FOR ll_index = 1 TO ll_count
	
	ls_return = THIS.Modify('Destroy ' + is_objectarray[ll_index] + '_line1')
	ls_return = THIS.Modify('Destroy ' + is_objectarray[ll_index] + '_line2')
NEXT

THIS.Modify('Destroy headerline1')
THIS.Modify('Destroy headerline2')
THIS.Modify('Destroy headerline3')

RETURN 1
end function

public function integer of_setstyleclassic ();String ls_x, ls_width, ls_return
Long ll_index, ll_count, ll_x, ll_width

is_style = 'CLASSIC'

of_DestroyStyle()

ll_count = UpperBound(is_objectarray)

FOR ll_index = 1 TO ll_count
	
	ls_width = THIS.Describe(is_objectarray[ll_index] + '.width')
	ls_x = THIS.Describe(is_objectarray[ll_index] + '.x')
	
	ll_x = Long(ls_width) + Long(ls_x)
	
	THIS.Modify(is_objectarray[ll_index] + '.y=8')
	THIS.Modify(is_objectarray[ll_index] + '.height=68')
	THIS.Modify(is_objectarray[ll_index] + '.border="6"')
	THIS.Modify(is_objectarray[ll_index] + '.color="33554432"')
	THIS.Modify(is_objectarray[ll_index] + '.background.color="67108864"')
	
NEXT

THIS.Modify("DataWindow.Header.Height='84'")
THIS.Modify("DataWindow.Header.Color= '67108864'")

RETURN 1
end function

public function integer of_resizeallcolumns ();Long ll_row
String ls_value
Long ll_colcount, ll_width
String ls_colname, ls_modify

ll_colcount = Long(THIS.Describe("DataWindow.Column.Count"))

FOR ll_row = 1 TO ll_colcount
	ls_colname = THIS.Describe('#' + String(ll_row) + '.Name')
	ll_width = Long(THIS.Describe('#' + String(ll_row) + '.Width'))
	
	ls_modify = ls_colname + '.Width=' + String(ll_width + 40)
	
	ls_value = THIS.Modify(ls_modify)
	
NEXT

Return 1
end function

on u_dw_grid.create
end on

on u_dw_grid.destroy
end on

event constructor;inv_gridheader_hottrck = CREATE n_cst_gridheader_hottrck 
IF inv_gridheader_hottrck.of_set_requestor( this) <> 1 THEN
	DESTROY inv_gridheader_hottrck
ELSE
	//inv_gridheader_hottrck.of_set_useborder( TRUE)
END IF


end event

event destructor;IF IsValid(inv_gridheader_hottrck) THEN DESTROY inv_gridheader_hottrck
end event

