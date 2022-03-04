$PBExportHeader$pfcscanner_n_cst_filesrvwin32.sru
$PBExportComments$PFC Win32 File handler service
forward
global type pfcscanner_n_cst_filesrvwin32 from pfcscanner_n_cst_filesrv
end type
end forward

global type pfcscanner_n_cst_filesrvwin32 from pfcscanner_n_cst_filesrv
end type
global pfcscanner_n_cst_filesrvwin32 pfcscanner_n_cst_filesrvwin32

type prototypes
end prototypes

type variables
end variables

forward prototypes
end prototypes

on pfcscanner_n_cst_filesrvwin32.create
TriggerEvent( this, "constructor" )
end on

on pfcscanner_n_cst_filesrvwin32.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//	Event:  Constructor
//	Description:	Set the instance variables for the directory separator
//						and wildcard for all files for this OS.
//////////////////////////////////////////////////////////////////////////////
//	Rev. History:	Version
//						5.0   Initial version
// 					5.0.03	Replace Uint with Ulong in Local External Functions for full NT 4.0
//									32 bit compatibility (handle type variables).
//						5.0.03	Changed object structure os_securityattributes datatype from char to string
//									to fix NT 4.0 directory creation inconsistency
//////////////////////////////////////////////////////////////////////////////
//	Copyright © 1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
is_Separator = "\"
is_AllFiles = "*.*"
is_FileType = "pbl"
end event

