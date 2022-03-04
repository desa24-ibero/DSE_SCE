$PBExportHeader$w_frame_intercambio.srw
$PBExportComments$Ventana principal de la aplicación.
forward
global type w_frame_intercambio from w_frame
end type
end forward

global type w_frame_intercambio from w_frame
integer x = 107
string menuname = "m_frame_intercambio"
windowstate windowstate = maximized!
end type
global w_frame_intercambio w_frame_intercambio

on w_frame_intercambio.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_frame_intercambio" then this.MenuID = create m_frame_intercambio
end on

on w_frame_intercambio.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_open;call super::pfc_open;//////////////////////////////////////////////////////////////////////////////
//
//	Object Name:  w_frame_intercambio
//
//	Description:
//	Ventana principal de la aplicación.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	pfc_open
//
//	Arguments:
//	None
//
//	Returns:
//	None
//
//	Description:	
//	Abre la ventana child sobre el escritorio.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
String   ls_sheet

w_sheet  lw_sheet

ls_sheet = Message.StringParm
OpenSheet(lw_sheet, ls_sheet, this, 0, Layered!)
end event

