$PBExportHeader$pfcscanner_n_cst_filesrvaix.sru
$PBExportComments$PFC aix File Handler service
forward
global type pfcscanner_n_cst_filesrvaix from pfcscanner_n_cst_filesrv
end type
end forward

global type pfcscanner_n_cst_filesrvaix from pfcscanner_n_cst_filesrv
end type
global pfcscanner_n_cst_filesrvaix pfcscanner_n_cst_filesrvaix

type prototypes
end prototypes

type variables
end variables

forward prototypes
end prototypes

on pfcscanner_n_cst_filesrvaix.create
call super::create
end on

on pfcscanner_n_cst_filesrvaix.destroy
call super::destroy
end on

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//	Event:  Constructor
//	Description:	Set the instance variables for the directory separator
//						and wildcard for all files for this OS.
//////////////////////////////////////////////////////////////////////////////
//	Rev. History:	Version
//						6.0   Initial version
//////////////////////////////////////////////////////////////////////////////
//	Copyright © 1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
is_Separator = "/"
is_AllFiles = "*"
is_FileType = "pbl"
end event

