$PBExportHeader$n_cst_schema_sql.sru
forward
global type n_cst_schema_sql from nonvisualobject
end type
end forward

global type n_cst_schema_sql from nonvisualobject autoinstantiate
end type

type prototypes
FUNCTION int SQLFetch(long statementhandle) library "odbc32.dll" 
FUNCTION int SQLAllocHandle(int handletype, long inputhandle, ref long ouputhandle) library "odbc32.dll" 
FUNCTION int SQLTables(long statementhandle, string catalogname, int namelength, string schedmaname, int namelength2, string tablename, int namelength3, string tabletype, int namelength4) library "odbc32.dll" alias for "SQLTables;Ansi" 
FUNCTION int SQLProcedures(long statementhandle, string catalogname, int namelength, string schedmaname, int namelength2, string tablename, int namelength3) library "odbc32.dll" alias for "SQLProcedures;Ansi" 
FUNCTION int SQLBindCol(long statementhandle, int columnnumber, int targettype, ref string targetvalueptr, int bufferlength, ref int strlen) library "odbc32.dll" alias for "SQLBindCol;Ansi" 
FUNCTION int SQLBindCol(long statementhandle, int columnnumber, int targettype, ref int targetvalueptr, int bufferlength, ref int strlen) library "odbc32.dll" 


FUNCTION int SQLColumns(long statementhandle, string catlogname, int namelength1, string schemaname, int namelength2, string tablename, int namelength3, string columnname, int namelength4) library "odbc32.dll" alias for "SQLColumns;Ansi" 
FUNCTION int SQLGetInfo(long connectionhandle, int infotype, ref string infovalueptr, int bufferlength, ref int stringlengthptr) library "odbc32.dll" alias for "SQLGetInfo;Ansi" 
FUNCTION int SQLPrimaryKeys(long statementhandle, string catlogname, int namelength1, string schemaname, int namelength2, string tablename, int namelength3) library "odbc32.dll" alias for "SQLPrimaryKeys;Ansi" 

FUNCTION int SQLExecDirect(long statementhandle, String sqlstatement, Long sqlstatementlen) library "odbc32.dll" alias for "SQLExecDirect;Ansi" 
FUNCTION int SQLGetData(long statementhandle, int icol, int fCType, REF String rgbValue, Long cbValueMax , Ref int pcbValue ) library "odbc32.dll" alias for "SQLGetData;Ansi" 

end prototypes

type variables
Transaction itr

Constant Long TABLELIST = 1
Constant Long SPLIST = 2
Constant Long VIEWLIST = 3
Constant Long TRIGGERLIST = 4
Constant Long INDEXLIST = 5
Constant Long TABLEEXTRACT = 6
Constant Long SPEXTRACT = 7
Constant Long VIEWEXTRACT = 8
Constant Long TRIGGEREXTRACT = 9
Constant Long INDEXEXTRACT = 10

Protected: 
Constant Integer SQL_STMT_HANDLE= 3 
Constant Integer SQL_CHAR = 1 
Constant Integer SQL_NUMERIC = 2 
Constant Integer SQL_DECIMAL =  3 
Constant Integer SQL_INTEGER = 4 
Constant Integer SQL_SMALLINT = 5 
Constant Integer SQL_FLOAT= 6 
Constant Integer SQL_REAL = 7 
Constant Integer SQL_DOUBLE = 8 
Constant Integer SQL_DATETIME = 9 
Constant Integer SQL_VARCHAR = 12
Constant Integer SQL_NVARCHAR = 247

Constant Integer SQL_C_WCHAR = -8  
Constant Integer SQL_C_INTEGER = 4 
Constant Integer SQL_TAB_TABLE_NAME= 3 
Constant Integer SQL_TAB_TABLE_TYPE = 4 
Constant Integer SQL_COL_COLUMN_NAME = 4 
Constant Integer SQL_COL_DATA_TYPE = 5 
Constant Integer SQL_COL_COLUMN_SIZE = 7 
Constant Integer SQL_COL_DECIMAL_DIGITS =  9 
Constant Integer SQL_KEY_COLUMN_NAME = 4 
Constant Integer SQL_SUCCESS = 0 
Constant Integer SQL_SUCCESS_WITH_INFO = 1 
Constant Integer SQL_USER_NAME = 47 
Constant Integer SQL_DBMS_NAME = 17 

long il_stmt_handle
end variables

forward prototypes
public function string of_gettablelistsql (string as_dbms)
public function string of_getsplistsql (string as_dbms)
public function string of_getviewlistsql (string as_dbms)
public function string of_gettriggerlistsql (string as_dbms)
public function string of_getindexlistsql (string as_dbms)
public function integer of_changesql (long as_action, string as_dbms, datastore a_dw, string as_name)
public function integer of_changesql (long as_action, string as_dbms, datawindow a_dw, string as_name)
public function string of_getindexextractsql (string as_dbms, string as_name)
public function string of_getspextractsql (string as_dbms, string as_name)
public function string of_gettableextractsql (string as_dbms, string as_name)
public function string of_gettriggerextractsql (string as_dbms, string as_name)
public function string of_getviewextractsql (string as_dbms, string as_name)
public function long of_odbctablelist (transaction atr, ref string as_table_list[])
public function long of_odbctableextract (transaction atr, string as_table_name, ref str_tabledef as_column_list[])
public function long of_getdbhandle (transaction atr)
public function long of_odbcsplist (transaction atr, ref string as_sp_list[])
public function long of_odbcspextract (transaction atr, string as_sp, ref string as_sp_list[])
end prototypes

public function string of_gettablelistsql (string as_dbms);String ls_sql
String ls_table[]
Long ll_index, ll_count

CHOOSE CASE Lower(as_dbms)
	CASE 'syc'
		ls_sql = 'select name, id from sysobjects o where type in ("U", "S") order by name'
	CASE 'odb'
		//itr = gnv_app.of_GetTransaction(gnv_toolbar.of_GetToolBar('w_toolbar1').Dynamic of_GetTransaction())

		of_ODBCTableList(itr, ls_table)
		
		ll_count = UpperBound(ls_table)
		
		FOR ll_index = 1 TO ll_count
			IF ll_index = 1 THEN
				ls_sql = "SELECT ~~'" + ls_table[ll_index] + "~~', 1"
			ELSE
				ls_sql = ls_sql + " UNION SELECT ~~'" + ls_table[ll_index] + "~~', 1"
			END IF
			
		NEXT
	
END CHOOSE

RETURN ls_sql
end function

public function string of_getsplistsql (string as_dbms);String ls_sql
String ls_sp[]
Long ll_index, ll_count

CHOOSE CASE Lower(as_dbms)
	CASE 'syc'
		ls_sql = 'select name, id from sysobjects	where type = "P" order by name'

	CASE 'odb'
		//itr = gnv_app.of_GetTransaction(gnv_toolbar.of_GetToolBar('w_toolbar1').Dynamic of_GetTransaction())

		of_ODBCSPList(itr, ls_sp)
		
		ll_count = UpperBound(ls_sp)
		
		FOR ll_index = 1 TO ll_count
			IF ll_index = 1 THEN
				ls_sql = "SELECT ~~'" + ls_sp[ll_index] + "~~', 1"
			ELSE
				ls_sql = ls_sql + " UNION SELECT ~~'" + ls_sp[ll_index] + "~~', 1"
			END IF
			
		NEXT
END CHOOSE

RETURN ls_sql
end function

public function string of_getviewlistsql (string as_dbms);String ls_sql

CHOOSE CASE Lower(as_dbms)
	CASE 'syc'
		ls_sql = 'select name, id from sysobjects	where type = "V" order by name'
END CHOOSE

RETURN ls_sql
end function

public function string of_gettriggerlistsql (string as_dbms);String ls_sql

CHOOSE CASE Lower(as_dbms)
	CASE 'syc'
		ls_sql = 'select name, id from sysobjects	where type = "TR" order by name'
END CHOOSE

RETURN ls_sql
end function

public function string of_getindexlistsql (string as_dbms);String ls_sql

CHOOSE CASE Lower(as_dbms)
	CASE 'syc'
		ls_sql = "SELECT O.name, " + &
					"		 O.id " + &
					"FROM sysindexes I, " + &
					"	  syssegments S, " + &
					"	  sysobjects O  " + &
					"WHERE I.indid>0  " + &
					"  AND I.indid<255  " + &
					"  AND I.status2 & 2!=2  " + &
					"  AND I.segment=S.segment  " + &
					"  AND O.id=I.id " + &
					"ORDER BY O.name "
END CHOOSE					

RETURN ls_sql
end function

public function integer of_changesql (long as_action, string as_dbms, datastore a_dw, string as_name);String ls_sql

as_dbms = Left(Lower(as_dbms), 3)

CHOOSE CASE as_action
	CASE TABLELIST
		ls_sql = of_GetTableListSQL(as_dbms)
	CASE SPLIST
		ls_sql = of_GetSPListSQL(as_dbms)
	CASE VIEWLIST
		ls_sql = of_GetViewListSQL(as_dbms)
	CASE TRIGGERLIST
		ls_sql = of_GetTriggerListSQL(as_dbms)
	CASE INDEXLIST
		ls_sql = of_GetIndexListSQL(as_dbms)
		
	CASE TABLEEXTRACT
		ls_sql = of_GetTableExtractSQL(as_dbms, as_name)
	CASE SPEXTRACT
		ls_sql = of_GetSPExtractSQL(as_dbms, as_name)
	CASE VIEWEXTRACT
		ls_sql = of_GetViewExtractSQL(as_dbms, as_name)
	CASE TRIGGEREXTRACT
		ls_sql = of_GetTriggerExtractSQL(as_dbms, as_name)
	CASE INDEXEXTRACT
		ls_sql = of_GetIndexExtractSQL(as_dbms, as_name)
END CHOOSE

a_dw.Modify("DataWindow.Table.Select='" + ls_sql + "'")

RETURN 1
end function

public function integer of_changesql (long as_action, string as_dbms, datawindow a_dw, string as_name);String ls_sql
String ls_return

as_dbms = Left(Lower(as_dbms), 3)

CHOOSE CASE as_action
	CASE TABLELIST
		ls_sql = of_GetTableListSQL(as_dbms)
	CASE SPLIST
		ls_sql = of_GetSPListSQL(as_dbms)
	CASE VIEWLIST
		ls_sql = of_GetViewListSQL(as_dbms)
	CASE TRIGGERLIST
		ls_sql = of_GetTriggerListSQL(as_dbms)
	CASE INDEXLIST
		ls_sql = of_GetIndexListSQL(as_dbms)
		
	CASE TABLEEXTRACT
		ls_sql = of_GetTableExtractSQL(as_dbms, as_name)
	CASE SPEXTRACT
		ls_sql = of_GetSPExtractSQL(as_dbms, as_name)
	CASE VIEWEXTRACT
		ls_sql = of_GetViewExtractSQL(as_dbms, as_name)
	CASE TRIGGEREXTRACT
		ls_sql = of_GetTriggerExtractSQL(as_dbms, as_name)
	CASE INDEXEXTRACT
		ls_sql = of_GetIndexExtractSQL(as_dbms, as_name)
END CHOOSE

ls_return = a_dw.Modify("DataWindow.Table.Select='" + ls_sql + "'")

RETURN 1
end function

public function string of_getindexextractsql (string as_dbms, string as_name);String ls_sql

CHOOSE CASE Lower(as_dbms)
	CASE 'syc'
		ls_sql = "SELECT A.text " + &
					"FROM sysindexes I, " + &
					"	  syssegments S, " + &
					"	  sysobjects O,  " + &
					"	  syscomments A,  " + &
					"WHERE I.indid>0  " + &
					"  AND I.indid<255  " + &
					"  AND I.status2 & 2!=2  " + &
					"  AND I.segment=S.segment  " + &
					"  AND O.id=I.id " + &
					"  AND O.id=A.id " + &
					"ORDER BY A.colid "
END CHOOSE					

RETURN ls_sql
end function

public function string of_getspextractsql (string as_dbms, string as_name);String ls_sql
String ls_sp[]
Long ll_index, ll_count

CHOOSE CASE Lower(as_dbms)
	CASE 'syc'
		ls_sql = "SELECT A.text from syscomments A, sysobjects B where A.id = B.id and  B.name = ~"" + as_name + "~" order by colid"

	CASE 'odb'
		//itr = gnv_app.of_GetTransaction(gnv_toolbar.of_GetToolBar('w_toolbar1').Dynamic of_GetTransaction())

		of_ODBCSPExtract(itr, as_name, ls_sp)
		
		ll_count = UpperBound(ls_sp)
		
		FOR ll_index = 1 TO ll_count
			IF ll_index = 1 THEN
				ls_sql = "SELECT ~~'" + ls_sp[ll_index] + "~~', 1"
			ELSE
				ls_sql = ls_sql + " UNION SELECT ~~'" + ls_sp[ll_index] + "~~', 1"
			END IF
			
		NEXT		
END CHOOSE

RETURN ls_sql
end function

public function string of_gettableextractsql (string as_dbms, string as_name);String ls_sql
String ls_columnlist[]
Long ll_index, ll_count
str_tabledef lstr_tabledef[]

CHOOSE CASE Lower(as_dbms)
	CASE 'syc'
		ls_sql = "select A.name, " + &
		         "C.name as datatype, " + &
			      " A.length, " + &
			      " A.prec, " + &
			      " A.scale " + &
		     "FROM syscolumns A, " + &
			       "sysobjects B, " + &
			       "systypes C " + &
			 "WHERE A.id = B.id " + &
			   "AND A.usertype = C.usertype " + &
	         "AND B.name =  ~"" + as_name + "~""
				
	CASE 'odb'
		//itr = gnv_app.of_GetTransaction(gnv_toolbar.of_GetToolBar('w_toolbar1').Dynamic of_GetTransaction())

		of_ODBCTableExtract(itr, as_name, lstr_tabledef)
		
		ll_count = UpperBound(lstr_tabledef)
		
		FOR ll_index = 1 TO ll_count
			IF ll_index = 1 THEN
				ls_sql = "SELECT ~~'" + lstr_tabledef[ll_index].Table_name + "~~', ~~'" + &
				                        lstr_tabledef[ll_index].Data_type + "~~', " + &
												String(lstr_tabledef[ll_index].Length) + ", " + &
												String(lstr_tabledef[ll_index].Prec) + ", " + &
												String(lstr_tabledef[ll_index].Scale) + " "
			ELSE
				ls_sql = ls_sql + " UNION SELECT ~~'" + lstr_tabledef[ll_index].Table_name + "~~', ~~'" + &
				                        lstr_tabledef[ll_index].Data_type + "~~', " + &
												String(lstr_tabledef[ll_index].Length) + ", " + &
												String(lstr_tabledef[ll_index].Prec) + ", " + &
												String(lstr_tabledef[ll_index].Scale) + " "

			END IF
			
		NEXT
END CHOOSE

RETURN ls_sql
end function

public function string of_gettriggerextractsql (string as_dbms, string as_name);String ls_sql

CHOOSE CASE Lower(as_dbms)
	CASE 'syc'
		ls_sql = "SELECT A.text from syscomments A, sysobjects B where A.id = B.id and  B.name = ~"" + as_name + "~" order by colid"
END CHOOSE

RETURN ls_sql
end function

public function string of_getviewextractsql (string as_dbms, string as_name);String ls_sql

CHOOSE CASE Lower(as_dbms)
	CASE 'syc'
		ls_sql = "SELECT A.text from syscomments A, sysobjects B where A.id = B.id and  B.name = ~"" + as_name + "~" order by colid"
END CHOOSE

RETURN ls_sql
end function

public function long of_odbctablelist (transaction atr, ref string as_table_list[]);integer li_total_tables = 0 
integer li_rc 
integer li_str_len 
string ls_catlog 
string ls_schema 
string ls_tablename 
Long ll_handle

ll_handle = of_GetDBHandle(atr) 

SetNull(ls_catlog) 
SetNull(ls_schema) 
SetNull(ls_tablename) 

li_rc = SQLTables(ll_handle, ls_tablename, 0, ls_tablename, 0, & 
      ls_tablename, 0, 'TABLE', 5)  
		
ls_tablename = space(128) 
ls_catlog = space(128) 
ls_schema = space(128) 

IF li_rc = SQL_SUCCESS OR li_rc = SQL_SUCCESS_WITH_INFO THEN 
	SQLBindCol(ll_handle, SQL_TAB_TABLE_NAME, SQL_C_WCHAR, ls_tablename, 128, li_str_len) 
	SQLBindCol(ll_handle, 1, SQL_C_WCHAR, ls_catlog, 128, li_str_len) 
	SQLBindCol(ll_handle, 2, SQL_C_WCHAR, ls_schema, 128, li_str_len) 
	
	li_rc = SQLFetch(ll_handle) 
	
	DO WHILE li_rc = SQL_SUCCESS 
		li_total_tables += 1 
		as_table_list[li_total_tables] = ls_tablename 
		li_rc = SQLFetch(ll_handle) 
	LOOP 
END IF 


RETURN li_total_tables 
end function

public function long of_odbctableextract (transaction atr, string as_table_name, ref str_tabledef as_column_list[]);Integer li_total_columns = 0 
Integer li_rc 
Integer li_str_len 
Integer li_colsize 
Integer li_coltype 
Integer li_coldecimal 
String ls_type_token 
String ls_catlog 
String ls_schema 
String ls_colname 
String ls_colsize 
String ls_coltype 
String ls_coldecimal 
Long ll_handle


ll_handle = of_GetDBHandle(atr) 

SetNull(ls_catlog) 
SetNull(ls_schema) 
SetNull(ls_colname) 

li_rc = SQLColumns(ll_handle, ls_catlog, 0, ls_colname, 0, & 
                   as_table_name, Len(as_table_name), ls_colname, 0) 
						 
IF li_rc = SQL_SUCCESS OR li_rc = SQL_SUCCESS_WITH_INFO THEN 
	ls_colname = space(128) 
	
	SQLBindCol(ll_handle, SQL_COL_COLUMN_NAME, SQL_C_WCHAR, ls_colname, 128, li_str_len) 
	SQLBINDCol(ll_handle, SQL_COL_COLUMN_SIZE, SQL_C_INTEGER, li_colsize, 0, li_str_len) 
	SQLBINDCol(ll_handle, SQL_COL_DATA_TYPE, SQL_C_INTEGER, li_coltype, 0, li_str_len) 
	SQLBINDCol(ll_handle, SQL_COL_DECIMAL_DIGITS, SQL_C_INTEGER, li_coldecimal, 0, li_str_len) 
	
	li_rc = SQLFetch(ll_handle) 
	
	DO WHILE li_rc = SQL_SUCCESS 
		li_total_columns += 1 

		CHOOSE CASE li_coltype
			CASE SQL_NUMERIC 
				as_column_list[li_total_columns].data_type = 'Numeric'
			CASE SQL_DECIMAL 
				as_column_list[li_total_columns].data_type = 'Decimal'
				as_column_list[li_total_columns].Prec = li_colsize - li_coldecimal
				as_column_list[li_total_columns].Scale = li_coldecimal
			CASE SQL_INTEGER 
				as_column_list[li_total_columns].data_type = 'Integer'
			CASE SQL_SMALLINT 
				as_column_list[li_total_columns].data_type = 'Smallint'
			CASE SQL_FLOAT 
				as_column_list[li_total_columns].data_type = 'Float'
				as_column_list[li_total_columns].Prec = li_colsize - li_coldecimal
				as_column_list[li_total_columns].Scale = li_coldecimal
			CASE SQL_REAL 
				as_column_list[li_total_columns].data_type = 'Real'
			CASE SQL_DOUBLE
				as_column_list[li_total_columns].data_type = 'Double'
				as_column_list[li_total_columns].Prec = li_colsize - li_coldecimal
				as_column_list[li_total_columns].Scale = li_coldecimal
			CASE SQL_VARCHAR, SQL_NVARCHAR
				as_column_list[li_total_columns].data_type = 'Varchar'
			CASE SQL_CHAR
				as_column_list[li_total_columns].data_type = 'Char'
			CASE SQL_DATETIME, 11
				as_column_list[li_total_columns].data_type = 'Datetime'
		END CHOOSE
		
		as_column_list[li_total_columns].Length = li_colsize
		
		as_column_list[li_total_columns].Table_Name = ls_colname
		li_rc = SQLFetch(ll_handle) 
	LOOP 
END IF 


RETURN li_total_columns 

end function

public function long of_getdbhandle (transaction atr);long ll_db_handle 

ll_db_handle = atr.DbHandle() 

SQLAllocHandle(SQL_STMT_HANDLE, ll_db_handle, il_stmt_handle) 

RETURN il_stmt_handle
end function

public function long of_odbcsplist (transaction atr, ref string as_sp_list[]);integer li_total_tables = 0 
integer li_rc 
integer li_str_len 
string ls_catlog 
string ls_schema 
string ls_spname 
Long ll_handle

ll_handle = of_GetDBHandle(atr) 

SetNull(ls_catlog) 
SetNull(ls_schema) 
SetNull(ls_spname) 

li_rc = SQLProcedures(ll_handle, ls_spname, 0, ls_spname, 0, & 
      ls_spname, 0) 
		
ls_spname = space(128) 
ls_catlog = space(128) 
ls_schema = space(128) 

IF li_rc = SQL_SUCCESS OR li_rc = SQL_SUCCESS_WITH_INFO THEN 
	SQLBindCol(ll_handle, SQL_TAB_TABLE_NAME, SQL_C_WCHAR, ls_spname, 128, li_str_len) 
	SQLBindCol(ll_handle, 1, SQL_C_WCHAR, ls_catlog, 128, li_str_len) 
	SQLBindCol(ll_handle, 2, SQL_C_WCHAR, ls_schema, 128, li_str_len) 
	
	li_rc = SQLFetch(ll_handle) 
	
	DO WHILE li_rc = SQL_SUCCESS 
		li_total_tables += 1 
		as_sp_list[li_total_tables] = ls_spname 
		li_rc = SQLFetch(ll_handle) 
	LOOP 
END IF 


RETURN li_total_tables 
end function

public function long of_odbcspextract (transaction atr, string as_sp, ref string as_sp_list[]);integer li_total_tables = 0 
integer li_rc 
integer li_str_len 
string ls_catlog 
string ls_schema 
string ls_spname 
String ls_DBMS, ls_DBMSSytax, ls_procsql
Long ll_handle, ll_pos

ll_handle = of_GetDBHandle(atr) 

SetNull(ls_catlog) 
SetNull(ls_schema) 
SetNull(ls_spname) 

ls_DBMS = Space(128)

SQLGetInfo(atr.DBHandle(), SQL_DBMS_NAME, ls_DBMS, 128, li_str_len) 

ls_DBMSSytax = ProfileString('pbodb90.ini', ls_DBMS, 'PBSyntax', '')
ls_procsql = ProfileString('pbodb90.ini', ls_DBMSSytax, 'PBSelectProcSyntax', '')

ls_procsql = Replace(ls_procsql, Pos(ls_procsql, "&ObjectName"), Len("&ObjectName"), as_sp)
ls_procsql = Replace(ls_procsql, Pos(ls_procsql, "&ObjectOwner"), Len("&ObjectOwner"), 'dbo')

ll_pos = Pos(ls_procsql, "''")

DO UNTIL ll_pos = 0
	ls_procsql = Replace(ls_procsql, ll_pos, 2, "'")
	ll_pos = Pos(ls_procsql, "''", ll_pos)
LOOP

li_rc = SQLExecDirect(ll_handle, ls_procsql, Len(ls_procsql))

//li_rc = SQLProcedures(ll_handle, ls_spname, 0, ls_spname, 0, & 
//      as_sp, Len(as_sp)) 
		
ls_spname = space(128) 
ls_catlog = space(128) 
ls_schema = space(128) 

IF li_rc = SQL_SUCCESS OR li_rc = SQL_SUCCESS_WITH_INFO THEN 
	//SQLBindCol(ll_handle, SQL_TAB_TABLE_NAME, SQL_C_CHAR, ls_spname, 128, li_str_len) 
	//SQLBindCol(ll_handle, 1, SQL_C_CHAR, ls_catlog, 128, li_str_len) 
	//SQLBindCol(ll_handle, 2, SQL_C_CHAR, ls_schema, 128, li_str_len) 
	
	ls_spname = Space(32766)
	
	li_rc = SQLGetData(ll_handle, 1, 99, ls_spname, len(ls_spname) ,  li_str_len)
	
	//li_rc = SQLFetch(ll_handle) 
	
	DO WHILE li_rc = SQL_SUCCESS 
		li_total_tables += 1 
		as_sp_list[li_total_tables] = ls_spname 
		li_rc = SQLGetData(ll_handle, 1, 99, ls_spname, len(ls_spname) ,  li_str_len)
	LOOP 
END IF 


RETURN li_total_tables 
end function

on n_cst_schema_sql.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_schema_sql.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

