$PBExportHeader$n_tr.sru
$PBExportComments$Extension Transaction class
forward
global type n_tr from pfc_n_tr
end type
end forward

global type n_tr from pfc_n_tr
end type
global n_tr n_tr

forward prototypes
public function integer of_init_sce (string as_inifile, string as_inisection)
end prototypes

public function integer of_init_sce (string as_inifile, string as_inisection);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Init
//
//	Access:  public
//
//	Arguments:
//	as_inifile   .INI file to read values from.
//	as_inisection   Section within .INI file where transaction object values are.
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:
//	Initializes transaction object's properties with 	values from 
//	an .INI file.  Values that are not found will be defaulted to an empty string.
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

n_cst_conversion lnv_conversion

// Check arguments
if IsNull (as_inifile) or IsNull (as_inisection) or &
	Len (Trim (as_inifile))=0 or Len (Trim (as_inisection))=0 or &
	(not FileExists (as_inifile)) then
	return -1
end if

this.DBMS= ProfileString (as_inifile, as_inisection, 'DBMS', '')
this.Database = ProfileString (as_inifile, as_inisection, 'Database', '')
this.LogID =  gs_usuario
this.LogPass = gs_password
this.ServerName = ProfileString (as_inifile, as_inisection, 'ServerName', '')
this.UserID =  gs_usuario
this.DBPass = gs_password
this.Lock =ProfileString (as_inifile, as_inisection, 'Lock', '')
this.DBParm =ProfileString (as_inifile, as_inisection, 'DBParm', '')
this.AutoCommit = lnv_conversion.of_Boolean &
 		(ProfileString (as_inifile, as_inisection, 'AutoCommit', 'false'))
if IsNull (this.AutoCommit) then this.AutoCommit = false

return 1
end function

on n_tr.create
call super::create
end on

on n_tr.destroy
call super::destroy
end on

