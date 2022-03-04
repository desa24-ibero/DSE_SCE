$PBExportHeader$n_cst_gridheader_hottrck.sru
$PBExportComments$Extension DataWindow Sort service
forward
global type n_cst_gridheader_hottrck from nonvisualobject
end type
end forward

global type n_cst_gridheader_hottrck from nonvisualobject
event doubleclicked pbm_dwnlbuttondblclk
event dwnmousemove pbm_dwnmousemove
event dwnlbuttonup pbm_dwnlbuttonup
event process_timer ( )
end type
global n_cst_gridheader_hottrck n_cst_gridheader_hottrck

type prototypes
Function Long SetTimer  (long  hWnd,long nIDEvent,Long uElapse, Long lpTimerFunc) Library  "user32.dll" 
Function Long KillTimer  (long hwnd,Long nIDEvent)  Library "user32.dll"
Function long SetCapture (LONG hwnd ) LibRARY "user32" 
Function long ReleaseCapture () Library "user32"

end prototypes

type variables
CONSTANT integer SUCCESS = 1
CONSTANT integer FAILURE = -1
CONSTANT integer TRANSPARENT_MODE = 1
CONSTANT integer OPAQUE_MODE = 2
CONSTANT string OBJECT_TYPE = "text"

PROTECTED:
datawindow idw_requestor
string	is_defaultheadersuffix = "_t"
dwobject idwo_columnheader_text 
int ii_default_border = 0
int ii_hottrack_border = 6
string IS_HTTRCK_UNDERLINE_COLOR = String(RGB(249, 177, 25))
boolean ib_useborder
end variables

forward prototypes
protected function integer of_getobjects (ref string as_objlist[], string as_objtype, string as_band, boolean ab_visibleonly)
public function integer of_set_requestor (datawindow adw)
public subroutine of_set_useborder (boolean ab_switch)
public subroutine of_set_header_suffix (string as_suffix)
public function integer of_create_hottrack_effects ()
end prototypes

event dwnmousemove;/*------------------------------------------------------------------------------

 Event   :			 n_cst_gridheader_hottrck.Dwnmousemove

 Returns:         Long

 Parameters:      value Integer xpos
                  value Integer ypos
                  value Long row
                  value DWObject dwo

 Copyright © 2004 DTI - Philip Salgannik

 Date Created: 11/9/2004

 Description:	pbm_dwnmousemove
 
--------------------------------------------------------------------------------
 Modifications:
 Date            Author              Comments
------------------------------------------------------------------------------*/

string ls_width, ls_height
string ls_x
string ls_y
if row = 0 then
	choose case dwo.type
			
		case OBJECT_TYPE
			if dwo.band = 'header' then
				if isvalid(idwo_columnheader_text) then
					if(dwo.name = idwo_columnheader_text.name) then return
					IF ib_useborder THEN idwo_columnheader_text.border = ii_default_border
					idwo_columnheader_text.background.mode= TRANSPARENT_MODE 
					idwo_columnheader_text.background.color=RGB(250,248,243) 
					idw_requestor.Modify(String(idwo_columnheader_text.name) + "_rect.visible='0'")
				end if
				idwo_columnheader_text = dwo
				idwo_columnheader_text.background.mode=OPAQUE_MODE 
				idwo_columnheader_text.background.color=RGB(250,248,243)
				
				IF ib_useborder THEN dwo.border = ii_hottrack_border
				ls_width = idw_requestor.Describe(String(idwo_columnheader_text.name) + ".width")
				ls_x = idw_requestor.Describe(String(idwo_columnheader_text.name) + ".x")
				
				idw_requestor.Modify(String(idwo_columnheader_text.name) + "_rect.width=" + ls_width)
				idw_requestor.Modify(String(idwo_columnheader_text.name) + "_rect.x=" + ls_x)
				idw_requestor.Modify(String(idwo_columnheader_text.name) + "_rect.visible='1'")

				SetTimer(Handle(idw_requestor),0,200,0)
			end if
		case else 
			return
							
	end choose

	
end if



end event

event process_timer();/*------------------------------------------------------------------------------

 Event   :			 n_cst_gridheader_hottrck.Process_timer

 Returns:         (none)

 Parameters:      

 Copyright © 2004 DTI - Philip Salgannik

 Date Created: 11/9/2004

 Description:	
 
--------------------------------------------------------------------------------
 Modifications:
 Date            Author              Comments
------------------------------------------------------------------------------*/
string object_t
int tab_pos
IF NOT IsValid(idw_requestor) THEN RETURN


object_t = idw_requestor.GetobjectAtPointer()

if isvalid(idwo_columnheader_text) then
	tab_pos = pos(object_t,'~t')
	if tab_pos > 0 then object_t = left(object_t,tab_pos - 1)
	if(object_t <> idwo_columnheader_text.name) then
		idwo_columnheader_text.background.mode=TRANSPARENT_MODE 
		idwo_columnheader_text.background.color=536870912 		
		IF ib_useborder THEN idwo_columnheader_text.border = ii_default_border
		idw_requestor.Modify(String(idwo_columnheader_text.name) + "_rect.visible='0'")
		destroy idwo_columnheader_text
		KillTimer(Handle(idw_requestor),0)		
	end if
end if



end event

protected function integer of_getobjects (ref string as_objlist[], string as_objtype, string as_band, boolean ab_visibleonly);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetObjects (FORMAT 2)
//
//	Access:    		Public
//
//	Arguments:
//   as_objlist[]:	A string array to hold objects (passed by reference)
//   as_objtype:  	The type of objects to get (* for all, others defined
//							by the object .TYPE attribute)
//   as_band:  		The dw band to get objects from (* for all) 
//							Valid bands: header, detail, footer, summary
//							header.#, trailer.#
//   ab_visibleonly: TRUE  - get only the visible objects,
//							 FALSE - get visible and non-visible objects
//
//	Returns:  		Integer
//   					The number of objects in the array
//
//	Description:	The following function will parse the list of objects 
//						contained in the datastore control associated with this service,
//						returning their names into a string array passed by reference, 
//						and returning the number of names in the array as the return value 
//						of the function.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string	ls_ObjString, ls_ObjHolder
integer	li_Start=1, li_Tab, li_Count=0
IF NOT IsValid(idw_requestor) THEN RETURN 0

/* Get the Object String */
ls_ObjString = idw_requestor.Describe("Datawindow.Objects")

/* Get the first tab position. */
li_Tab =  Pos(ls_ObjString, "~t", li_Start)
Do While li_Tab > 0
	ls_ObjHolder = Mid(ls_ObjString, li_Start, (li_Tab - li_Start))

	// Determine if object is the right type and in the right band
	If (idw_requestor.Describe(ls_ObjHolder + ".type") = as_ObjType Or as_ObjType = "*") And &
		(idw_requestor.Describe(ls_ObjHolder + ".band") = as_Band Or as_Band = "*") And &
		(idw_requestor.Describe(ls_ObjHolder + ".visible") = "1" Or Not ab_VisibleOnly) Then
			li_Count ++
			as_ObjList[li_Count] = ls_ObjHolder
	End if

	/* Get the next tab position. */
	li_Start = li_Tab + 1
	li_Tab =  Pos(ls_ObjString, "~t", li_Start)
Loop 

// Check the last object
ls_ObjHolder = Mid(ls_ObjString, li_Start, Len(ls_ObjString))

// Determine if object is the right type and in the right band
If (idw_requestor.Describe(ls_ObjHolder + ".type") = as_ObjType or as_ObjType = "*") And &
	(idw_requestor.Describe(ls_ObjHolder + ".band") = as_Band or as_Band = "*") And &
	(idw_requestor.Describe(ls_ObjHolder + ".visible") = "1" Or Not ab_VisibleOnly) Then
		li_Count ++
		as_ObjList[li_Count] = ls_ObjHolder
End if

Return li_Count
end function

public function integer of_set_requestor (datawindow adw);/*------------------------------------------------------------------------------

 Function:			public n_cst_gridheader_hottrck.of_Set_requestor

 Returns:         Integer

 Parameters:      value DataWindow adw

 Copyright © 2004 DTI - Philip Salgannik

 Date Created: 11/9/2004

 Description:	
 
--------------------------------------------------------------------------------
 Modifications:
 Date            Author              Comments
------------------------------------------------------------------------------*/


IF IsNull(adw) OR Not IsValid(adw) THEN RETURN FAILURE
//IF adw.Describe("DataWindow.Processing") <> "1" THEN RETURN FAILURE

idw_requestor = adw
RETURN 1//of_create_hottrack_effects( )

end function

public subroutine of_set_useborder (boolean ab_switch);/*------------------------------------------------------------------------------

 Function:			public n_cst_gridheader_hottrck.of_Set_useborder

 Returns:         (none)

 Parameters:      value Boolean ab_switch

 Copyright © 2004 DTI - Philip Salgannik

 Date Created: 11/10/2004

 Description:	
 
--------------------------------------------------------------------------------
 Modifications:
 Date            Author              Comments
------------------------------------------------------------------------------*/
IF IsNull(ab_switch) THEN RETURN
ib_useborder = ab_switch
end subroutine

public subroutine of_set_header_suffix (string as_suffix);/*------------------------------------------------------------------------------

 Function:			public n_cst_gridheader_hottrck.of_Set_header_suffix

 Returns:         (none)

 Parameters:      value String as_suffix

 Copyright © 2004 DTI - Philip Salgannik

 Date Created: 11/10/2004

 Description:	
 
--------------------------------------------------------------------------------
 Modifications:
 Date            Author              Comments
------------------------------------------------------------------------------*/

IF Len(Trim(as_suffix)) = 0 THEN RETURN
string ls_s
ls_s = Trim(as_suffix)
IF Len(ls_s) = 0 THEN RETURN
is_defaultheadersuffix = ls_s

end subroutine

public function integer of_create_hottrack_effects ();/*------------------------------------------------------------------------------

 Function:			protected n_cst_gridheader_hottrck.of_Create_hottrack_effects

 Returns:         Integer

 Parameters:      

 Copyright © 2004 DTI - Philip Salgannik

 Date Created: 11/9/2004

 Description:	
 
--------------------------------------------------------------------------------
 Modifications:
 Date            Author              Comments
------------------------------------------------------------------------------*/
string ls_cols[], ls_modify, ls_rectangle, ls_err
long kount, total

ls_rectangle = 'create rectangle(band=header ' 

total = of_getobjects( ls_cols, "column", "detail", TRUE)
FOR kount =1 to total
	ls_modify = ls_rectangle + &
	' band=foreground' + &
	' x="' + idw_requestor.Describe(ls_cols[kount]+".x") + '"'+ &
	' y="' + string(Integer(idw_requestor.Describe(ls_cols[kount]+ is_defaultheadersuffix + ".y")) + Integer(idw_requestor.Describe(ls_cols[kount] + is_defaultheadersuffix + ".height")) - 10) + '"' + &
	' height="10"' + &
	' width="' + String(integer(idw_requestor.Describe(ls_cols[kount] + is_defaultheadersuffix + ".width"))) + '"' + &
	' name=' + ls_cols[kount] + is_defaultheadersuffix + '_rect'  + & 
	' visible="0" ' + &
	' brush.color="' + String(RGB(252, 194, 71)) + '" ' + &
	' pen.style="0" pen.width="5" ' + &
	' pen.color="'+ String(RGB(249, 169, 0)) + '"  ' + &
	' background.mode="2" ' + &
	' background.color="'+ String(RGB(252, 194, 71)) + '" )'
	//IS_HTTRCK_UNDERLINE_COLOR
	ls_err += idw_requestor.Modify(ls_modify)	
NEXT
IF Len(ls_err) > 0 THEN RETURN FAILURE
RETURN SUCCESS
end function

on n_cst_gridheader_hottrck.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_gridheader_hottrck.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;/*------------------------------------------------------------------------------

 Event   :			 n_cst_gridheader_hottrck.Constructor

 Returns:         Long

 Parameters:      

 Copyright © 2004 DTI - Philip Salgannik

 Date Created: 11/9/2004

 Description:	This object assumes "_t" suffix convention for grid text objects and 
 					works for grids ONLY. The suffix is configurable.
					Obviously to emulate the way the Header control from the common
					controls DLL works under XP you need to find out the colors, etc.
 
--------------------------------------------------------------------------------
 Modifications:
 Date            Author              Comments
------------------------------------------------------------------------------*/

end event

