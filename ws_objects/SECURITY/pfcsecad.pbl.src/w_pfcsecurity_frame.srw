$PBExportHeader$w_pfcsecurity_frame.srw
$PBExportComments$PFC Security Admin frame
forward
global type w_pfcsecurity_frame from w_frame
end type
end forward

global type w_pfcsecurity_frame from w_frame
integer x = 5
integer y = 4
integer width = 2999
integer height = 2040
string title = "PFC Security Administration"
string menuname = "m_pfcsecurity_frame"
windowstate windowstate = maximized!
long backcolor = 80921269
boolean toolbarvisible = false
end type
global w_pfcsecurity_frame w_pfcsecurity_frame

on w_pfcsecurity_frame.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_pfcsecurity_frame" then this.MenuID = create m_pfcsecurity_frame
end on

on w_pfcsecurity_frame.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////////////
//
//	Object Name:  w_pfcsecurity_frame
//
//	Description:  MDI frame for PFC Security administration utility
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

end event

event pfc_postopen;call super::pfc_postopen;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  postopen
//
//	Arguments:None
//
//	Returns:  None
//
//	Description:  Get login information, halt application if unable to connect to database
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

integer	li_rc


open(w_pfcsecurity_login_sce,this)  // get the login information
if dbhandle(gnv_app.inv_trans) = 0 then
	halt close
	return
end if


///////////////////////////////////////////////////////////////////////////////////////////////////
// Se recupera la el ambiente actual para colocarlo en el Title del MDI
STRING ls_plantel
ls_plantel = ProfileString(gnv_app.of_getappinifile ( ),"Plantel","Plantel", "Ciudad_de_Mexico") 
IF ls_plantel = "Ciudad_de_Mexico" THEN 
	title = title + " " + "Plantel Ciudad de Mexico"
ELSE
	title = title + " " + "Plantel Tijuana"
END IF
///////////////////////////////////////////////////////////////////////////////////////////////////


end event

