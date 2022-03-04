﻿$PBExportHeader$pfcscanner_n_ds.sru
$PBExportComments$Datastore object used by scanner process.
forward
global type pfcscanner_n_ds from datastore
end type
end forward

global type pfcscanner_n_ds from datastore
end type
global pfcscanner_n_ds pfcscanner_n_ds

type variables
Public :
//n_cst_dssrv	inv_base
transaction		itr_object

Protected :
boolean		ib_append
end variables

forward prototypes
public function integer of_setappend (boolean ab_append)
public function boolean of_getappend ()
end prototypes

public function integer of_setappend (boolean ab_append);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetAppend
//
//	Access:  public
//
//	Arguments:
//	ab_append:  whether data will be appended to existing data when retrieving
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:
//	Sets the behavior for retrieval so that data appends or is replaced
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

// Check arguments
if IsNull (ab_append) then
	return -1
end if

ib_append = ab_append
return 1
end function

public function boolean of_getappend ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetAppend
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  boolean
//
//	Description:
//	Returns whether data is appended to existing data when retrieving
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

return ib_append
end function

event retrievestart;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  retrievestart
//
//	Description:
//	Determine if retrieved data should be appended to the existing data,
//	or if the existing data should be reset prior to retrieval.
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

long	ll_rc

if ib_append then
	ll_rc = 2
end if
	
return ll_rc

end event

on pfcscanner_n_ds.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on pfcscanner_n_ds.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

event dberror;string	ls_message

// Construct the error message.
ls_message = "A database error has occurred.~r~n~r~n~r~n" + &
	"Database error code:  " + String (sqldbcode) + "~r~n~r~n" + &
	"Database error message:~r~n" + sqlerrtext   + "~r~n~r~n" + &
	"Row: " + string(row)


	Messagebox ("Database Error", ls_message, StopSign!, Ok!)
	
end event

