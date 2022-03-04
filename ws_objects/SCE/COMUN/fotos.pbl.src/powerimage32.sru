$PBExportHeader$powerimage32.sru
forward
global type powerimage32 from UserObject
end type
end forward

global type powerimage32 from UserObject
int Width=2455
int Height=1753
UserObjects ObjectType=ExternalVisual!
long BackColor=0
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
string Pointer="Cross!"
string ClassName="powerimage32"
string LibraryName="pwrimg32.dll"
long Style=1174405121
event type integer busca ( long cuenta,  transaction tr_scred,  integer factor )
end type
global powerimage32 powerimage32

type prototypes
private SUBROUTINE pB1(uint a, REF string b) LIBRARY "pwrimg32.dll" alias for "pB1;Ansi"
private FUNCTION long pB2(uint a, int b, int c, int d, int e, int f, int g, int h) LIBRARY "pwrimg32.dll"
private FUNCTION int pB3(blob a,  REF str_blob_info b, int c, long d) LIBRARY "pwrimg32.dll" alias for "pB3;Ansi"
private SUBROUTINE pB4(uint a, REF str_set_scan b, int c) LIBRARY "pwrimg32.dll" alias for "pB4;Ansi"
private FUNCTION long pB5(uint a, int b, int c, int d, int e, int f, int g, int h) LIBRARY "pwrimg32.dll"
private FUNCTION long pB6(REF string a) LIBRARY "pwrimg32.dll" alias for "pB6;Ansi"
private FUNCTION long pB7() LIBRARY "pwrimg32.dll"
private FUNCTION long pB8() LIBRARY "pwrimg32.dll"
private FUNCTION long pB9() LIBRARY "pwrimg32.dll"
private SUBROUTINE pB10(uint a, REF str_rect_roi b) LIBRARY "pwrimg32.dll" alias for "pB10;Ansi"
private FUNCTION long pB11(uint a, int b, int c, int d, int e, int f, int g, int h) LIBRARY "pwrimg32.dll"
private FUNCTION long pB12(uint a, int b, int c, int d, int e, int f, int g, int h) LIBRARY "pwrimg32.dll"
private FUNCTION long pB13(uint a, blob b, int c, ulong d) LIBRARY "pwrimg32.dll"
private FUNCTION long pB14(uint a, blob b, ulong c) LIBRARY "pwrimg32.dll"
private FUNCTION long pB15(ulong a, REF str_rgb_quad b[]) LIBRARY "pwrimg32.dll" alias for "pB15;Ansi"
private FUNCTION long pB16(ulong a, REF str_rgb_quad b[]) LIBRARY "pwrimg32.dll" alias for "pB16;Ansi"
private FUNCTION long pB17(string a, int b) LIBRARY "pwrimg32.dll" alias for "pB17;Ansi"
private FUNCTION long pB18(blob a, int b, long c) LIBRARY "pwrimg32.dll"
private FUNCTION long pB19() LIBRARY "pwrimg32.dll"
private FUNCTION long pB20(int a) LIBRARY "pwrimg32.dll"
private FUNCTION long pB21() LIBRARY "pwrimg32.dll"
private FUNCTION long pB22(int a) LIBRARY "pwrimg32.dll"
private FUNCTION int pB23(ulong a, ulong b, uint c, uint d, uint e, ulong f) LIBRARY "pwrimg32.dll"
private FUNCTION int pB24(ulong a, uint b, REF uint c, REF uint d) LIBRARY "pwrimg32.dll"
private FUNCTION long pB25(uint a, int b, int c, int d, int e, int f, int g) LIBRARY "pwrimg32.dll"
private FUNCTION long pB26(uint a, blob b, ulong c) LIBRARY "pwrimg32.dll"
private FUNCTION long pB27(uint a, blob b, int c, ulong d) LIBRARY "pwrimg32.dll"
private FUNCTION int pB28(string a,  REF str_blob_info b, int c) LIBRARY "pwrimg32.dll" alias for "pB28;Ansi"
private FUNCTION int pB29(ulong a, uint b, REF uint c, REF uint d) LIBRARY "pwrimg32.dll"
private FUNCTION int pB30(string a , int b, int c, int d, UINT e) LIBRARY "pwrimg32.dll" alias for "pB30;Ansi"
end prototypes

type variables
powerimage32 uo_pwimg
int i_new_width
int i_new_height
int i_fitwin
blob i_vis_blob
string i_sheet_title
boolean clpimg = FALSE
unsignedinteger i_raster_op = 7
boolean i_is_annotated = FALSE
int i_scan_ui

int i_scale_factor = 100
blob i_blob
long i_blblength
uint i_numpages
uint i_curpage
string i_fname
blob i_ann_blob
long i_ann_blblength
uint i_ann_numpages
uint i_ann_curpage
string i_ann_fname
boolean i_annLoaded = TRUE
end variables

forward prototypes
public function integer fu_get_blob_from_file (ref blob blob_data, string filename)
public function integer fu_blob_info (ref blob blob_name, ref str_blob_info blb_inf, long blb_len, integer page)
public function integer fu_get_numpages_blob (ref blob blob)
public function integer fu_display_blob (long blob_length, ref blob blob_data, integer page, integer auto_resize)
public function integer fu_load_blob (long blob_length, ref blob blob_data, integer page)
public function integer fu_get_transpindx_blob (ref blob blobdata, integer page, long bloblen)
public function integer fann_load_annotations_blob (long blob_length, ref blob blob_data, integer page)
public subroutine fu_zoom_fixed (integer factor)
end prototypes

event busca;long li_length
blob blob_buff

setnull(blob_buff)

height=PixelsToUnits(343*factor/100.0, YPixelsToUnits!)
width=PixelsToUnits(272*factor/100.0, XPixelsToUnits!)

SELECTBLOB foto
INTO 	:blob_buff				//local variable
FROM  fotos_alumnos						//table name
WHERE fotos_alumnos.cuenta = :cuenta	 //where criteria
USING tr_scred ;			//Transaction Object
		
if tr_scred.sqlcode < 0 then
	MessageBox ("Sorry! No insert Blobs yet", tr_scred.SQLErrText)
	return -1
end if

if tr_scred.sqlcode <> 0 then
	MessageBox ("Sorry! No insert Blobs yet", "NO blob")
	return -1
end if
	
if tr_scred.sqlcode = 100 then
	MessageBox ("Sorry! No insert Blobs yet", "Lo encontre")
end if

if isnull(blob_buff) then
	SELECTBLOB foto
	INTO 	:blob_buff				//local variable
	FROM  fotos_alumnos						//table name
	WHERE fotos_alumnos.cuenta = 0	 //where criteria
	USING tr_scred ;			//Transaction Object
end if

SetPointer(HourGlass!)

i_vis_blob = blob_buff
li_length = Len(i_vis_blob)
fu_display_blob(li_length,i_vis_blob, 0, 0)

Send(handle(this),1128,UnitsToPixels(width - width*0.005, XUnitsToPixels!),&
	UnitsToPixels(height - height*0.005, YUnitsToPixels!))

SetPointer(Arrow!)

return 0
end event

public function integer fu_get_blob_from_file (ref blob blob_data, string filename);//
//integer li_FileNum
//long li_length, bytes_read
//int loops, i
//blob buff_blob
//string buff
//SetPointer(HourGlass!)
//li_length = FileLength(filename)
//li_FileNum = FileOpen(filename, StreamMode!, Read!, Shared!)
//
//if li_FileNum < 0 then
//	return -1
//end if
//
//if li_length > 32765 then
//	if Mod(li_length, 32765) = 0 then
//		loops = li_length/32765
//	else
//		loops = (li_length/32765) + 1
//	end if
//else
//	loops = 1
//end if
//
//FOR i = 1 to loops
//	bytes_read = FileRead(li_FileNum, buff_blob)
//	if bytes_read < 0 then
//		return -2
//	end if
//	blob_data = blob_data + buff_blob
//NEXT
//
//FileClose(li_FileNum)
//
//UPDATEBLOB cosas 
//SET cosa = :buff_blob
//WHERE indice = 2
//USING gtr_scred ;
//		
//IF gtr_scred.SQLCODE < 0 THEN
//	messagebox("",gtr_scred.SQLErrText)
//END IF
//
//IF gtr_scred.SQLNRows > 0 THEN
//	COMMIT USING gtr_scred ;
//END IF
//
//SetPointer(Arrow!)
return 0
end function

public function integer fu_blob_info (ref blob blob_name, ref str_blob_info blb_inf, long blb_len, integer page);
long length
if IsNull(blob_name) then
	return -2
end if
length = Len(blob_name)
if length <= 1 or blb_len <= 1 then
	return -2
end if
return(pB3(blob_name, blb_inf, page, blb_len))

end function

public function integer fu_get_numpages_blob (ref blob blob);
if IsNull(blob) then
	return -2
end if
long length
length = Len(blob)
if length <= 1 then
	return -2
end if
return(pB14(Handle(this), blob, Len(blob)))
end function

public function integer fu_display_blob (long blob_length, ref blob blob_data, integer page, integer auto_resize);
long rcode
long length
if IsNull(blob_data) then
	return -2
end if
length = Len(blob_data)
if length <= 1 or blob_length <= 1 then
	return -2
end if
//i_numpages = pB14 ( Handle(this), blob_data, blob_length )
//if ((page > i_numpages) or (page < 0)) then
//	return -14
//end if
i_curpage = page
i_blob = blob_data
i_blblength = blob_length
i_fname = "Blob_Data"
rcode = pB13 ( Handle(this), i_blob, i_curpage, i_blblength )
if auto_resize = 1 then
//	Send(handle(this), 1105, 0, 0)
end if
return rcode
end function

public function integer fu_load_blob (long blob_length, ref blob blob_data, integer page);
long rcode
long length
if IsNull(blob_data) then
	return -2
end if
length = Len(blob_data)
if length <= 1 or blob_length <= 1 then
	return -2
end if
i_numpages = pB14 ( Handle(this), blob_data, blob_length )
if ((page > i_numpages) or (page < 0)) then
	return -14
end if
i_curpage = page
i_blob = blob_data
i_blblength = blob_length
i_fname = "Blob_Data"
rcode = pB13 ( Handle(this), i_blob, i_curpage, i_blblength )
return rcode
end function

public function integer fu_get_transpindx_blob (ref blob blobdata, integer page, long bloblen);
long length
if IsNull(blobdata) then
	return -3
end if
length = Len(blobdata)
if length <= 1 or bloblen <= 1 then
	return -3
end if
return(pB18(blobdata, page, length))
end function

public function integer fann_load_annotations_blob (long blob_length, ref blob blob_data, integer page);
long rcode
long length
if IsNull(blob_data) then
	i_annloaded = FALSE
	return -2
end if
length = Len(blob_data)
if length <= 1 or blob_length <= 1 then
	i_annloaded = FALSE
	return -2
end if
i_ann_numpages = pB26 ( Handle(this), blob_data, blob_length )
if ((page > i_ann_numpages) or (page < 0)) then
	i_annloaded = FALSE
	return -14
end if
i_ann_curpage = page
i_ann_blob = blob_data
i_ann_blblength = blob_length
i_ann_fname = "Blob_Data"
rcode = pB27 ( Handle(this), i_ann_blob, i_ann_curpage, i_ann_blblength )
i_annloaded = TRUE
return rcode
end function

public subroutine fu_zoom_fixed (integer factor);
//if factor < 10 then
//	return	
//end if
i_scale_factor = Send(handle(this), 1109, factor, 0)
end subroutine

