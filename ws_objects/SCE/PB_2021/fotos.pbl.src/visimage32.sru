$PBExportHeader$visimage32.sru
forward
global type visimage32 from UserObject
end type
end forward

global type visimage32 from UserObject
int Width=2551
int Height=1533
boolean Border=true
long BackColor=79741120
long PictureMaskColor=553648127
long TabTextColor=33554432
long TabBackColor=16777215
end type
global visimage32 visimage32

type prototypes
private SUBROUTINE pB100(ulong a) LIBRARY "vispb32.dll"
private SUBROUTINE pB99(ulong a) LIBRARY "vispb32.dll"
private SUBROUTINE pB1(uint a, REF string b) LIBRARY "vispb32.dll" alias for "pB1;Ansi"
private FUNCTION long pB2(uint a, int b, int c, int d, int e, int f, int g, int h) LIBRARY "vispb32.dll"
private FUNCTION int pB3(blob a,  REF str_blob_info b, int c, long d) LIBRARY "vispb32.dll" alias for "pB3;Ansi"
private SUBROUTINE pB4(uint a, REF str_set_scan b, int c) LIBRARY "vispb32.dll" alias for "pB4;Ansi"
private FUNCTION long pB5(uint a, int b, int c, int d, int e, int f, int g, int h) LIBRARY "vispb32.dll"
private FUNCTION long pB6(REF string a) LIBRARY "vispb32.dll" alias for "pB6;Ansi"
private FUNCTION long pB7() LIBRARY "vispb32.dll"
private FUNCTION long pB8() LIBRARY "vispb32.dll"
private FUNCTION long pB9() LIBRARY "vispb32.dll"
private SUBROUTINE pB10(uint a, REF str_rect_roi b) LIBRARY "vispb32.dll" alias for "pB10;Ansi"
private FUNCTION long pB11(uint a, int b, int c, int d, int e, int f, int g, int h) LIBRARY "vispb32.dll"
private FUNCTION long pB12(uint a, int b, int c, int d, int e, int f, int g, int h) LIBRARY "vispb32.dll"
private FUNCTION long pB13(uint a, blob b, int c, ulong d) LIBRARY "vispb32.dll"
private FUNCTION long pB14(uint a, blob b, ulong c) LIBRARY "vispb32.dll"
private FUNCTION long pB15(ulong a, REF str_rgb_quad b[]) LIBRARY "vispb32.dll" alias for "pB15;Ansi"
private FUNCTION long pB16(ulong a, REF str_rgb_quad b[]) LIBRARY "vispb32.dll" alias for "pB16;Ansi"
private FUNCTION long pB17(string a, int b) LIBRARY "vispb32.dll" alias for "pB17;Ansi"
private FUNCTION long pB18(blob a, int b, long c) LIBRARY "vispb32.dll"
private FUNCTION long pB19() LIBRARY "vispb32.dll"
private FUNCTION long pB20(int a) LIBRARY "vispb32.dll"
private FUNCTION long pB21() LIBRARY "vispb32.dll"
private FUNCTION long pB22(int a) LIBRARY "vispb32.dll"
private FUNCTION int pB23(ulong a, ulong b, uint c, uint d, uint e, ulong f) LIBRARY "vispb32.dll"
private FUNCTION int pB24(ulong a, uint b, REF uint c, REF uint d) LIBRARY "vispb32.dll"
private FUNCTION long pB25(uint a, int b, int c, int d, int e, int f, int g) LIBRARY "vispb32.dll"
private FUNCTION long pB26(uint a, blob b, ulong c) LIBRARY "vispb32.dll"
private FUNCTION long pB27(uint a, blob b, int c, ulong d) LIBRARY "vispb32.dll"
private FUNCTION int pB28(string a,  REF str_blob_info b, int c) LIBRARY "vispb32.dll" alias for "pB28;Ansi"
private FUNCTION int pB29(ulong a, uint b, REF uint c, REF uint d) LIBRARY "vispb32.dll"
private FUNCTION int pB30(string a , int b, int c, int d, UINT e) LIBRARY "vispb32.dll" alias for "pB30;Ansi"
private FUNCTION long LoadLibraryA(string libName) LIBRARY "kernel32" alias for "LoadLibraryA;Ansi"

end prototypes

type variables
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
public subroutine fu_auto_resize ()
public subroutine fu_zoom_fixed (integer factor)
public subroutine fu_zoom_img (integer flag)
public subroutine fu_set_dither (integer dither_mode)
public function integer fu_get_display_bits ()
public function integer fu_clip_notify (unsignedinteger wparam, unsignedlong lparam)
public function boolean fu_clip_valid ()
public subroutine fu_set_clipboard ()
public subroutine fu_image_info (ref str_img_info img_info_str)
public subroutine fu_image_description ()
public subroutine fu_notify_palette (integer is_active)
public subroutine fu_empty_clipboard ()
public subroutine fu_fit_to_window (integer flag)
public subroutine fu_reset_selection_rect ()
public function integer fu_get_num_pages (string filename)
public function integer fu_open_image (string filename, integer page)
public function integer fu_45d_edge_det (integer degree)
public function integer fu_alter_brightness (integer level)
public function integer fu_alter_contrast (integer level)
public function integer fu_alter_gamma (double level)
public function integer fu_alter_rgb (integer red, integer green, integer blue)
public function integer fu_blur_image ()
public function integer fu_convert_to_grayscale ()
public function integer fu_create_dot_drawing ()
public function integer fu_get_blob_from_file (ref blob blob_data, string filename)
public function integer fu_open_auto (ref string filename)
public function integer fu_dither_to_2 (integer mode)
public function integer fu_emboss_img (integer direction)
public function integer fu_first_page ()
public function integer fu_last_page ()
public function integer fu_next_page ()
public function integer fu_prior_page ()
public function integer fu_flip_image ()
public function integer fu_mirror_image ()
public function integer fu_gently_sharpen ()
public function integer fu_get_clipboard ()
public function integer fu_horz_edge_det (integer degree)
public function integer fu_vert_edge_det (integer degree)
public function integer fu_neg_45d_edge_det (integer degree)
public function integer fu_sobel_filter (integer direction)
public function integer fu_prewitt_filter (integer direction)
public function integer fu_laplacian_process (integer mode)
public function integer fu_median_filter ()
public function integer fu_posterize_image (integer amount)
public function integer fu_mosaic_transform (integer factor)
public function integer fu_promote_to_24bit ()
public function integer fu_promote_to_8bit ()
public function integer fu_save_auto ()
public function integer fu_sharpen ()
public function integer fu_smooth_image (integer level)
public subroutine fu_select_twain_source ()
public function integer fu_get_img_bitspix ()
public subroutine fu_set_multipage_export (integer flag)
public function integer fu_multiply_image (integer value)
public function integer fu_invert_image ()
public function integer fu_solarize_image (integer threshold)
public function integer fu_divide_image (integer value)
public function long fu_get_image_cursor_pos ()
public function integer fu_get_current_scale_factor ()
public function long fu_get_image_scroll_pos ()
public subroutine fu_enable_selection_rect (integer onoff)
public function long fu_get_image_scroll_range (integer scroll_bar)
public function long fu_get_printer_dimensions ()
public function long fu_get_free_mem ()
public function long fu_get_free_resources ()
public subroutine fu_scroll_image (integer scroll_bar, integer scrollcode, integer scroll_amount)
public subroutine fu_clear_image ()
public function integer fu_get_system_res ()
public function integer fu_dither_to_256 (unsignedinteger mode)
public function integer fu_dither_to_16 (unsignedinteger mode)
public function integer fu_copy_pow_uo (long uo_hwnd)
public subroutine fu_zoom_to_rect ()
public function integer fu_oil_paint ()
public function integer fu_print_start_doc ()
public function integer fu_print_end_doc ()
public function integer fu_print_new_page ()
public subroutine fu_set_roi (str_rect_roi roi_rc)
public function integer fu_matrix_convolution (ref string matrix)
public function integer fu_acquire_twain (ref str_set_scan scan_str, integer ui_flag)
public function integer fu_goto_page (integer selpg)
public function integer fu_print_abort_doc ()
public subroutine fu_set_autocolor (integer flag)
public subroutine fu_set_antialias (integer flag)
public function integer fu_histo_equalize ()
public function integer fu_alter_hsv (integer hue, integer saturation, integer value)
public subroutine fu_enter_clip_chain (integer next_window_hndl)
public subroutine fu_leave_clip_chain (integer next_window_hndl)
public function integer fu_print_image_doc (integer bw, decimal xpos, decimal ypos, decimal printwidth, decimal printheight, integer aspect, integer full)
public function integer fu_print_image (integer bw, decimal xpos, decimal ypos, decimal printwidth, decimal printheight, integer aspect, integer full)
public function integer fu_print_window (unsignedinteger window_hndl, integer bw, decimal xpos, decimal ypos, decimal printwidth, decimal printheight, integer aspect, integer full)
public function integer fu_print_window_doc (unsignedinteger window_hndl, integer bw, decimal xpos, decimal ypos, decimal printwidth, decimal printheight, integer aspect, integer full)
public function integer fu_rotate_image (double degree, long color, integer clockwise)
public function integer fu_resize_img (unsignedlong newwidth, unsignedlong newheight)
public function integer fu_save_image (string filename, integer filetype)
public function integer fu_blob_info (ref blob blob_name, ref str_blob_info blb_inf, long blb_len, integer page)
public function integer fu_get_numpages_blob (ref blob blob)
public function integer fu_display_blob (long blob_length, ref blob blob_data, integer page, integer auto_resize)
public function integer fu_load_blob (long blob_length, ref blob blob_data, integer page)
public function unsignedlong fu_get_imghandle ()
public function integer fu_get_palette (unsignedlong imghandle, ref str_rgb_quad rgbpal[])
public function integer fu_set_palette (unsignedlong imghandle, ref str_rgb_quad rgbpal[])
public function integer fu_set_backcolor (long bkclr)
public function integer fu_set_decompsize (unsignedinteger NewWidth, unsignedinteger NewHeight)
public function integer fu_get_transpindx_file (ref string filename, integer page)
public function integer fu_get_transpindx_blob (ref blob blobdata, integer page, long bloblen)
public function integer fu_get_transp_ex (integer degree)
public function integer fu_set_transp_ex (integer transp_indx)
public function integer fu_set_comp_quality (integer quality)
public function integer fu_get_comp_quality (integer quality)
public function long fu_get_backcolor ()
public function integer fu_set_transpcolor (long transpcolor)
public function long fu_get_transpcolor ()
public function integer fu_set_statuscallback (integer message_num, long win_hWnd)
public subroutine fu_resize_control ()
public function integer fu_deskew_image ()
public function integer fu_60s_fun ()
public function integer fu_scan_to_file (string filename, integer filetype, ref str_set_scan scan_str, integer ui_flag)
public subroutine fu_show_scrollbars (integer onoff)
public function integer fann_load_annsdk ()
public function integer fann_unload_annsdk ()
public function integer fann_add_annotation (integer objType)
public function integer fann_free_annotations ()
public function integer fann_set_annotation_mode (integer mode)
public function integer fann_save_annotation (string filename)
public function integer fann_print_annotations_doc (decimal xpos, decimal ypos, decimal printwidth, decimal printheight, integer aspect, integer full)
public function integer fann_load_annotations (string filename, integer page)
public function integer fann_load_annotations_blob (long blob_length, ref blob blob_data, integer page)
public function integer fann_first_page ()
public function integer fann_goto_page (integer selpg)
public function integer fann_next_page ()
public function integer fann_last_page ()
public function integer fann_prior_page ()
public function integer fann_get_numpages (string filename)
public function integer fann_get_numpages_blob (ref blob blob)
public function integer fann_render_image ()
public function boolean fann_is_annotation_changed ()
public function integer fu_inittwain ()
public subroutine fu_exittwain ()
public subroutine fu_set_printer_mode (unsignedinteger mode)
public function integer fu_file_info (ref string file_name, ref str_blob_info file_inf, integer page)
public function integer fu_merge_image (unsignedinteger p_hwnd, unsignedinteger c_hwnd, unsignedinteger xpos, unsignedinteger ypos, unsignedinteger rasterop, unsignedlong transparency)
public function integer fu_mapimagepts2screenpts (unsignedinteger win_hwnd, ref unsignedinteger xpos, ref unsignedinteger ypos)
public function integer fu_mapscreenpts2imagepts (unsignedinteger win_hwnd, ref unsignedinteger xpos, ref unsignedinteger ypos)
public function integer fu_despeckle (integer level, integer mode)
public function integer fu_line_removal (integer minlength, integer mode)
public function integer fu_rotate_image_interp (double degree, long color, integer clockwise)
public subroutine fu_set_autoredraw (integer mode)
public function integer fu_save_window_content (string filename, integer filetype, integer bitdepth, integer dithermode, unsignedinteger pb_hWnd)
end prototypes

public subroutine fu_auto_resize ();
Send(handle(this), 1105, 0, 0)
end subroutine

public subroutine fu_zoom_fixed (integer factor);
if factor < 10 then
	return	
end if
i_scale_factor = Send(handle(this), 1109, factor, 0)
end subroutine

public subroutine fu_zoom_img (integer flag);
long result, lparam
lparam = long(flag, 0)
i_scale_factor = Send(handle(this), 1108, 0, lparam)
end subroutine

public subroutine fu_set_dither (integer dither_mode);
Send(handle(this), 1110, dither_mode, 0)
end subroutine

public function integer fu_get_display_bits ();
long result
result = Send(handle(this), 1111, 0, 0)
return IntLow(result)
end function

public function integer fu_clip_notify (unsignedinteger wparam, unsignedlong lparam);
return(Send(handle(this), 1123, wParam, lParam))
end function

public function boolean fu_clip_valid ();
long result
result = Send(Handle(this), 1120, 0, 0)
if result > 0 then
	return TRUE
else
	return FALSE
end if
end function

public subroutine fu_set_clipboard ();
Send(handle(this), 1121, 0, 0)
end subroutine

public subroutine fu_image_info (ref str_img_info img_info_str);
int NewWidth, NewHeight, bitsperpix
long result
result = 0
result = Send(handle(this), 1136, 0, 0)
NewWidth = IntLow(result)
NewHeight = IntHigh(result)
result = Send(handle(this), 1138, 0, 0)
bitsperpix = IntLow(result)
img_info_str.width = NewWidth
img_info_str.height = NewHeight
img_info_str.bitspix = bitsperpix
return
end subroutine

public subroutine fu_image_description ();
Send(handle(this), 1140, 0, 0)
end subroutine

public subroutine fu_notify_palette (integer is_active);
Send(handle(this), 6, is_active, 0)	
end subroutine

public subroutine fu_empty_clipboard ();
Send(handle(this), 1145, 0, 0)
end subroutine

public subroutine fu_fit_to_window (integer flag);
Send(Handle(this), 1176, flag, 0)
end subroutine

public subroutine fu_reset_selection_rect ();
Send(Handle(this), 1284, 0, 0)
end subroutine

public function integer fu_get_num_pages (string filename);
return(Send(Handle(this), 1285, 0, filename))
end function

public function integer fu_open_image (string filename, integer page);
int rcode
rcode = Send(handle(this), 1106, page, filename)
if (rcode < 0) then
	return rcode
end if
SetNull(i_blob)
i_blblength = 0
i_fname = filename
i_curpage = page
i_numpages = Send(Handle(this), 1285, 0, filename)
return rcode
end function

public function integer fu_45d_edge_det (integer degree);
return(Send(Handle(this), 1169, degree, 0))
end function

public function integer fu_alter_brightness (integer level);
return(Send(Handle(this), 1152, level, 0))
end function

public function integer fu_alter_contrast (integer level);
return(Send(Handle(this), 1153, level, 0))
end function

public function integer fu_alter_gamma (double level);
int val
val = level * 1000
return(Send(Handle(this), 1171, val, 0))
end function

public function integer fu_alter_rgb (integer red, integer green, integer blue);
Send(Handle(this), 1321, red, 0)
Send(Handle(this), 1320, green, blue)
return(Send(Handle(this), 1288, 0, 0))
end function

public function integer fu_blur_image ();
return(Send(Handle(this), 1156, 0, 0))
end function

public function integer fu_convert_to_grayscale ();
long method
method = long(256, 3)
return(Send(handle(this), 1172, 0, method))
end function

public function integer fu_create_dot_drawing ();
return(Send(Handle(this), 1283, 0, 0))
end function

public function integer fu_get_blob_from_file (ref blob blob_data, string filename);
integer li_FileNum
long li_length, bytes_read
int loops, i
blob buff_blob
string buff
SetPointer(HourGlass!)
li_length = FileLength(filename)
li_FileNum = FileOpen(filename, StreamMode!, Read!, Shared!)

if li_FileNum < 0 then
	return -1
end if

if li_length > 32765 then
	if Mod(li_length, 32765) = 0 then
		loops = li_length/32765
	else
		loops = (li_length/32765) + 1
	end if
else
	loops = 1
end if

FOR i = 1 to loops
	bytes_read = FileRead(li_FileNum, buff_blob)
	if bytes_read < 0 then
		return -2
	end if
	blob_data = blob_data + buff_blob
NEXT

FileClose(li_FileNum)

SetPointer(Arrow!)
return 0
end function

public function integer fu_open_auto (ref string filename);
long result = 0
filename = Space(144)
i_fname = Space(144)
result = Send (handle(this), 1104, 0, 0) 
if result < 0 then
	SetNull(filename)
	i_fname = "NO_DATA"
	return result
else
	pB1(handle(this), filename)
	i_fname = filename
	i_curpage = result
	i_numpages = Send(Handle(this), 1285, 0, filename)
	i_blblength = 0
	SetNull(i_blob)
	return result
end if
end function

public function integer fu_dither_to_2 (integer mode);
return(Send(handle(this), 1173, mode, 0))
end function

public function integer fu_emboss_img (integer direction);
return(Send(handle(this), 1113, direction, 0))
end function

public function integer fu_first_page ();
int rcode = 0
i_curpage = 0
if (i_fname = "Blob_Data") then
	if (i_blblength > 0) then
		rcode = pB13 ( Handle(this), i_blob, i_curpage, i_blblength )
	end if
else
	rcode = Send(handle(this), 1106, i_curpage, i_fname)
end if 
return rcode
end function

public function integer fu_last_page ();
int rcode = 0
i_curpage = (i_numpages - 1)
if (i_fname = "Blob_Data") then
	if (i_blblength > 0) then
		rcode = pB13 ( Handle(this), i_blob, i_curpage, i_blblength )
	end if
else
	rcode = Send(handle(this), 1106, i_curpage, i_fname)
end if 
return rcode
end function

public function integer fu_next_page ();
int rcode = 0
if (((i_curpage + 1) >= 0) and ((i_curpage + 1) <= (i_numpages - 1))) then
	i_curpage = (i_curpage + 1)
else
	return -1
end if
if (i_fname = "Blob_Data") then
	if (i_blblength > 0) then
		rcode = pB13 ( Handle(this), i_blob, i_curpage, i_blblength )
	end if
else
	rcode = Send(handle(this), 1106, i_curpage, i_fname)
end if 	
return rcode
end function

public function integer fu_prior_page ();
int rcode = 0
if (((i_curpage - 1) >= 0) and ((i_curpage - 1) <= (i_numpages - 1))) then
	i_curpage = (i_curpage - 1)
else
	return -1
end if
if (i_fname = "Blob_Data") then
	if (i_blblength > 0) then
		rcode = pB13 ( Handle(this), i_blob, i_curpage, i_blblength )
	end if
else
	rcode = Send(handle(this), 1106, i_curpage, i_fname)
end if 
return rcode
end function

public function integer fu_flip_image ();
return(Send(Handle(this), 1159, 0, 0))
end function

public function integer fu_mirror_image ();
return(Send(handle(this), 1160, 0, 0))
end function

public function integer fu_gently_sharpen ();
return(Send(Handle(this), 1155, 0, 0))
end function

public function integer fu_get_clipboard ();
return(Send(handle(this), 1125, 0, 0))
end function

public function integer fu_horz_edge_det (integer degree);
return(Send(Handle(this), 1168, degree, 0))
end function

public function integer fu_vert_edge_det (integer degree);
return(Send(Handle(this), 1161, degree, 0))
end function

public function integer fu_neg_45d_edge_det (integer degree);
return(Send(Handle(this), 1170, degree, 0))
end function

public function integer fu_sobel_filter (integer direction);
return(Send(Handle(this), 1280, direction, 0))
end function

public function integer fu_prewitt_filter (integer direction);
return(Send(Handle(this), 1286, direction, 0))

end function

public function integer fu_laplacian_process (integer mode);
return(Send(Handle(this), 1281, mode, 0))
end function

public function integer fu_median_filter ();
return(Send(Handle(this), 1282, 0, 0))
end function

public function integer fu_posterize_image (integer amount);
return(Send(Handle(this), 1287, amount, 0))
end function

public function integer fu_mosaic_transform (integer factor);
return(Send(Handle(this), 1177, factor, 0))
end function

public function integer fu_promote_to_24bit ();
return(Send(handle(this), 1175, 0, 0))
end function

public function integer fu_promote_to_8bit ();
return(Send(handle(this), 1174, 0, 0))
end function

public function integer fu_save_auto ();
return(Send(handle(this), 1107, 0, 0))
end function

public function integer fu_sharpen ();
return(Send(Handle(this), 1154, 0, 0))
end function

public function integer fu_smooth_image (integer level);
return(Send(Handle(this), 1157, level, 0))
end function

public subroutine fu_select_twain_source ();
Send(Handle(this), 1127, 0, 0)
end subroutine

public function integer fu_get_img_bitspix ();
return(IntLow(Send(handle(this), 1138, 0, 0)))
end function

public subroutine fu_set_multipage_export (integer flag);
Send(Handle(this), 1297, flag, 0)
end subroutine

public function integer fu_multiply_image (integer value);
return(Send(Handle(this), 1298, value, 0))
end function

public function integer fu_invert_image ();
return(Send(handle(this), 1126, 0, 0))
end function

public function integer fu_solarize_image (integer threshold);
return(IntLow(Send(Handle(this), 1289, threshold, 0)))
end function

public function integer fu_divide_image (integer value);
return(Send(Handle(this), 1299, value, 0))
end function

public function long fu_get_image_cursor_pos ();
return(Send(Handle(this), 1302, 0, 0))
end function

public function integer fu_get_current_scale_factor ();
return i_scale_factor
end function

public function long fu_get_image_scroll_pos ();
Return(Send(Handle(this), 1305, 0, 0))
end function

public subroutine fu_enable_selection_rect (integer onoff);
Send(Handle(this), 1303, onoff, 0)
end subroutine

public function long fu_get_image_scroll_range (integer scroll_bar);
Return(Send(Handle(this), 1304, scroll_bar, 0))
end function

public function long fu_get_printer_dimensions ();
Return(Send(Handle(this), 1312, 0, 0))
end function

public function long fu_get_free_mem ();
return 0 /* unsupported */
end function

public function long fu_get_free_resources ();
return 0 /* unsupported */
end function

public subroutine fu_scroll_image (integer scroll_bar, integer scrollcode, integer scroll_amount);
int s
if scroll_bar = 1 then
	s = 277
elseif scroll_bar = 0 then
	s = 276
else
	return
end if
Send(handle(this), s, scrollcode, long(scroll_amount, s))
end subroutine

public subroutine fu_clear_image ();
Send(Handle(this), 1316, 0, 0)
SetNull(i_blob)
SetNull(i_ann_blob)
i_ann_blblength = 0
i_blblength = 0
i_fname = " "
i_ann_fname = " "
i_curpage = 0
i_numpages = 0
i_ann_curpage = 0
i_ann_numpages = 0
i_annloaded = FALSE

end subroutine

public function integer fu_get_system_res ();
return 0 /* unsupported */
end function

public function integer fu_dither_to_256 (unsignedinteger mode);
long method
method = long(256, mode)
return(Send(handle(this), 1172, 0, method))
end function

public function integer fu_dither_to_16 (unsignedinteger mode);
long method
method = long(16, mode)
return (Send(handle(this), 1172, 0, method))
end function

public function integer fu_copy_pow_uo (long uo_hwnd);
int rcode
if (IsNull(uo_hwnd)) or (uo_hwnd < 0) then
	return -15
end if
rcode = Send(Handle(this), 1328, 0, uo_hwnd)
if (rcode > 0) then
	i_scale_factor = rcode
	return 0
else
	return rcode
end if
end function

public subroutine fu_zoom_to_rect ();
int ret_val
ret_val = Send(Handle(this), 1329, 0, 0)
if ret_val > 0 then
	i_scale_factor  = ret_val
end if
end subroutine

public function integer fu_oil_paint ();
int rcode
this.SetRedraw(FALSE)
rcode = Send(Handle(this), 1331, 0, 0)
this.SetRedraw(TRUE)
return rcode
end function

public function integer fu_print_start_doc ();
string job_name = "Powerimg32 Print Job"
return(pB6(job_name))
end function

public function integer fu_print_end_doc ();
return(pB7())
end function

public function integer fu_print_new_page ();
return(pB9())
end function

public subroutine fu_set_roi (str_rect_roi roi_rc);
pB10(handle(this), roi_rc)
end subroutine

public function integer fu_matrix_convolution (ref string matrix);
return(Send(Handle(this), 1332, 0, matrix))
end function

public function integer fu_acquire_twain (ref str_set_scan scan_str, integer ui_flag);
int rcode
pB4(handle(this), scan_str, ui_flag)
rcode = Send(handle(this), 1296, ui_flag, 0)
i_fname = Space(144)
if rcode < 0 then
	i_fname = "NO_DATA"
	return rcode
else
	pB1(handle(this), i_fname)
	i_numpages = Send(Handle(this), 1285, 0, i_fname)
	i_curpage = i_numpages - 1
	i_blblength = 0
	SetNull(i_blob)
	return rcode
end if
end function

public function integer fu_goto_page (integer selpg);
int rcode = 0
if ((selpg >= 0) and (selpg <= (i_numpages - 1))) then
	i_curpage = selpg
else
	return -1
end if
if (i_fname = "Blob_Data") then
	if (i_blblength > 0) then
		rcode = pB13 ( Handle(this), i_blob, i_curpage, i_blblength )
	end if
else
	rcode = Send(handle(this), 1106, i_curpage, i_fname)
end if 
return rcode
end function

public function integer fu_print_abort_doc ();
return(pB8())
end function

public subroutine fu_set_autocolor (integer flag);
Send(Handle(this), 1336, flag, 0)
return
end subroutine

public subroutine fu_set_antialias (integer flag);
Send(Handle(this), 1335, flag, 0)
return
end subroutine

public function integer fu_histo_equalize ();
return(Send(Handle(this), 1337, 0, 0))
end function

public function integer fu_alter_hsv (integer hue, integer saturation, integer value);
Send(Handle(this), 1321, hue, 0)
Send(Handle(this), 1320, saturation, value)
return(Send(Handle(this), 1344, 0, 0))
end function

public subroutine fu_enter_clip_chain (integer next_window_hndl);
Send(handle(this), 1122, next_window_hndl, 0)
end subroutine

public subroutine fu_leave_clip_chain (integer next_window_hndl);
long lp
lp = long(0, next_window_hndl)
Send(handle(this), 1124, 0, lp)
end subroutine

public function integer fu_print_image_doc (integer bw, decimal xpos, decimal ypos, decimal printwidth, decimal printheight, integer aspect, integer full);
int	new_xpos, new_ypos, new_width, new_height
new_xpos = Int(xpos * 1000)
new_ypos = Int(ypos * 1000)
new_width = Int(printwidth * 1000)
new_height = Int(printheight * 1000)
return(pB5(Handle(this), bw, new_xpos, new_ypos, new_height, new_width, aspect, full))
end function

public function integer fu_print_image (integer bw, decimal xpos, decimal ypos, decimal printwidth, decimal printheight, integer aspect, integer full);
int	new_xpos, new_ypos, new_width, new_height
new_xpos = Int(xpos * 1000)
new_ypos = Int(ypos * 1000)
new_width = Int(printwidth * 1000)
new_height = Int(printheight * 1000)
return(pB2(Handle(this), bw, new_xpos, new_ypos, new_height, new_width, aspect, full))
end function

public function integer fu_print_window (unsignedinteger window_hndl, integer bw, decimal xpos, decimal ypos, decimal printwidth, decimal printheight, integer aspect, integer full);
int	new_xpos, new_ypos, new_width, new_height
new_xpos = Int(xpos * 1000)
new_ypos = Int(ypos * 1000)
new_width = Int(printwidth * 1000)
new_height = Int(printheight * 1000)
return(pB11(window_hndl, bw, new_xpos, new_ypos, new_height, new_width, aspect, full))
end function

public function integer fu_print_window_doc (unsignedinteger window_hndl, integer bw, decimal xpos, decimal ypos, decimal printwidth, decimal printheight, integer aspect, integer full);
int	new_xpos, new_ypos, new_width, new_height
new_xpos = Int(xpos * 1000)
new_ypos = Int(ypos * 1000)
new_width = Int(printwidth * 1000)
new_height = Int(printheight * 1000)
return(pB12(window_hndl, bw, new_xpos, new_ypos, new_height, new_width, aspect, full))
end function

public function integer fu_rotate_image (double degree, long color, integer clockwise);
int   nDegree

if (clockwise = 0) then
	nDegree = Int(degree * 10)
else
	nDegree = Int((360.00 - degree) * 10)
end if

return(Send(handle(this), 1158, nDegree, color))
end function

public function integer fu_resize_img (unsignedlong newwidth, unsignedlong newheight);
uint nWidth
uint nHeight
if (NewWidth > 65535) then
	nWidth = 65535
else
	nWidth = NewWidth
end if	
if (NewHeight > 65535) then
	nHeight = 65535
else
	nHeight = NewHeight
end if
return(Send(handle(this), 1128, nWidth, nHeight))
end function

public function integer fu_save_image (string filename, integer filetype);
Send(Handle(this), 1300,  0, filename)
return(Send(Handle(this), 1301,  filetype, 0))
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
i_numpages = pB14 ( Handle(this), blob_data, blob_length )
if ((page > i_numpages) or (page < 0)) then
	return -14
end if
i_curpage = page
i_blob = blob_data
i_blblength = blob_length
i_fname = "Blob_Data"
rcode = pB13 ( Handle(this), i_blob, i_curpage, i_blblength )
if auto_resize = 1 then
	Send(handle(this), 1105, 0, 0)
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

public function unsignedlong fu_get_imghandle ();
return(Send(Handle(this), 1345, 0, 0))
end function

public function integer fu_get_palette (unsignedlong imghandle, ref str_rgb_quad rgbpal[]);
int rcode = 0
rcode = pB15 ( imghandle, rgbpal )
return rcode
end function

public function integer fu_set_palette (unsignedlong imghandle, ref str_rgb_quad rgbpal[]);
int rcode = 0
rcode = pB16 ( imghandle, rgbpal )
return rcode
end function

public function integer fu_set_backcolor (long bkclr);
return(Send(Handle(this), 1347, 0, bkclr))
end function

public function integer fu_set_decompsize (unsignedinteger NewWidth, unsignedinteger NewHeight);
return(Send(Handle(this), 1333, NewWidth, NewHeight))
end function

public function integer fu_get_transpindx_file (ref string filename, integer page);
return(pB17(filename, page))
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

public function integer fu_get_transp_ex (integer degree);
return(pB19())
end function

public function integer fu_set_transp_ex (integer transp_indx);
return(pB20(transp_indx))
end function

public function integer fu_set_comp_quality (integer quality);
return(pB22(quality))
end function

public function integer fu_get_comp_quality (integer quality);
return(pB21())
end function

public function long fu_get_backcolor ();
return(Send(Handle(this), 1346, 0, 0))
end function

public function integer fu_set_transpcolor (long transpcolor);
return(Send(Handle(this), 1349, 0, transpcolor))
end function

public function long fu_get_transpcolor ();
return(Send(Handle(this), 1348, 0, 0))
end function

public function integer fu_set_statuscallback (integer message_num, long win_hWnd);
return(Send(Handle(this), 1350, message_num, win_hWnd))
end function

public subroutine fu_resize_control ();
Send(handle(this), 1351, 0, 0)
end subroutine

public function integer fu_deskew_image ();
return(Send(Handle(this), 1352, 0, 0))
end function

public function integer fu_60s_fun ();
return(Send(Handle(this), 1353, 0, 0))
end function

public function integer fu_scan_to_file (string filename, integer filetype, ref str_set_scan scan_str, integer ui_flag);
pB4(handle(this), scan_str, ui_flag)
Send(Handle(this), 1300,  0, filename)
return(Send(handle(this), 1315, filetype, 0))
end function

public subroutine fu_show_scrollbars (integer onoff);
Send(Handle(this), 1360, onoff, 0)
end subroutine

public function integer fann_load_annsdk ();
return(Send(Handle(this), 1361, 0, 0))

end function

public function integer fann_unload_annsdk ();
//return(Send(Handle(this), 1367, 0, 0))
return(Send(Handle(this), 0, 0, 0))
end function

public function integer fann_add_annotation (integer objType);
return(Send(Handle(this), 1362, objType, 0))
end function

public function integer fann_free_annotations ();
int rcode
rcode = Send(Handle(this), 1363, 0, 0)
i_annloaded = FALSE
return rcode
end function

public function integer fann_set_annotation_mode (integer mode);
return(Send(Handle(this), 1364, mode, 0))
end function

public function integer fann_save_annotation (string filename);
return(Send(Handle(this), 1366, 0, filename))
end function

public function integer fann_print_annotations_doc (decimal xpos, decimal ypos, decimal printwidth, decimal printheight, integer aspect, integer full);
int	new_xpos, new_ypos, new_width, new_height
new_xpos = Int(xpos * 1000)
new_ypos = Int(ypos * 1000)
new_width = Int(printwidth * 1000)
new_height = Int(printheight * 1000)
return(pB25(Handle(this), new_xpos, new_ypos, new_height, new_width, aspect, full))
end function

public function integer fann_load_annotations (string filename, integer page);
int rcode
rcode = Send(handle(this), 1365, page, filename)
if (rcode < 0) then
	i_annloaded = FALSE
	return rcode
end if
SetNull(i_ann_blob)
i_ann_blblength = 0
i_ann_fname = filename
i_ann_curpage = page
i_ann_numpages = Send(Handle(this), 1368, 0, filename)
i_annloaded = TRUE
return rcode
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

public function integer fann_first_page ();
int rcode = 0
if (i_annloaded = TRUE) then
	i_ann_curpage = 0
	if (i_ann_fname = "Blob_Data") then
		if (i_ann_blblength > 0) then
			rcode = pB27 ( Handle(this), i_ann_blob, i_ann_curpage, i_ann_blblength )
		end if
	else
		rcode = Send(handle(this), 1365, i_ann_curpage, i_ann_fname)
	end if 
end if
return rcode
end function

public function integer fann_goto_page (integer selpg);
int rcode = 0
if (i_annloaded = TRUE) then
	if ((selpg >= 0) and (selpg <= (i_ann_numpages - 1))) then
		i_ann_curpage = selpg
	else
		return -1
	end if
	if (i_ann_fname = "Blob_Data") then
		if (i_ann_blblength > 0) then
			rcode = pB27 ( Handle(this), i_ann_blob, i_ann_curpage, i_ann_blblength )
		end if
	else
		rcode = Send(handle(this), 1365, i_ann_curpage, i_ann_fname)
	end if 
end if
return rcode
end function

public function integer fann_next_page ();
int rcode = 0
if (i_annloaded = TRUE) then
	if (((i_ann_curpage + 1) >= 0) and ((i_ann_curpage + 1) <= (i_ann_numpages - 1))) then
		i_ann_curpage = (i_ann_curpage + 1)
	else
		return -1
	end if
	if (i_ann_fname = "Blob_Data") then
		if (i_ann_blblength > 0) then
			rcode = pB27 ( Handle(this), i_ann_blob, i_ann_curpage, i_ann_blblength )
		end if
	else
		rcode = Send(handle(this), 1365, i_ann_curpage, i_ann_fname)
	end if 
end if
return rcode
end function

public function integer fann_last_page ();
int rcode = 0

if (i_annloaded = TRUE) then
	i_ann_curpage = (i_ann_numpages - 1)	
	if (i_ann_fname = "Blob_Data") then
		if (i_ann_blblength > 0) then
			rcode = pB27 ( Handle(this), i_ann_blob, i_ann_curpage, i_ann_blblength )
		end if
	else
		rcode = Send(handle(this), 1365, i_ann_curpage, i_ann_fname)
	end if 
end if
return rcode
end function

public function integer fann_prior_page ();
int rcode = 0
if (i_annloaded = TRUE) then
	if (((i_ann_curpage - 1) >= 0) and ((i_ann_curpage - 1) <= (i_ann_numpages - 1))) then
		i_ann_curpage = (i_ann_curpage - 1)
	else
		return -1
	end if
	if (i_ann_fname = "Blob_Data") then
		if (i_ann_blblength > 0) then
			rcode = pB27 ( Handle(this), i_ann_blob, i_ann_curpage, i_ann_blblength )
		end if
	else
		rcode = Send(handle(this), 1365, i_ann_curpage, i_ann_fname)
	end if 
end if
return rcode
end function

public function integer fann_get_numpages (string filename);
return(Send(Handle(this), 1368, 0, filename))
end function

public function integer fann_get_numpages_blob (ref blob blob);
if IsNull(blob) then
	return -2
end if
long length
length = Len(blob)
if length <= 1 then
	return -2
end if
return(pB26(Handle(this), blob, Len(blob)))
end function

public function integer fann_render_image ();
return(Send(handle(this), 1369, 0, 0))
end function

public function boolean fann_is_annotation_changed ();
int rcode
boolean changed
rcode = Send(handle(this), 1376, 0, 0)
if (rcode = 1) then
	changed = TRUE
else
	changed = FALSE
end if
return changed
end function

public function integer fu_inittwain ();
return(Send(Handle(this), 1377, 0, 0))
end function

public subroutine fu_exittwain ();
Send(Handle(this), 1378, 0, 0)
end subroutine

public subroutine fu_set_printer_mode (unsignedinteger mode);
Send(Handle(this), 1379, mode, 0)
return
end subroutine

public function integer fu_file_info (ref string file_name, ref str_blob_info file_inf, integer page);
return(pB28(file_name, file_inf, page))
end function

public function integer fu_merge_image (unsignedinteger p_hwnd, unsignedinteger c_hwnd, unsignedinteger xpos, unsignedinteger ypos, unsignedinteger rasterop, unsignedlong transparency);
unsignedlong desimghandle = 0
unsignedlong srcimghandle = 0
desimghandle = Send(p_hWnd, 1345, 0, 0)
srcimghandle = Send(c_hWnd, 1345, 0, 0)
if ((desimghandle <= 0) or (srcimghandle <= 0)) then
	return -15
end if
return(pB23(desimghandle, srcimghandle, xpos, ypos, rasterop, transparency))
end function

public function integer fu_mapimagepts2screenpts (unsignedinteger win_hwnd, ref unsignedinteger xpos, ref unsignedinteger ypos);
unsignedlong srcimghandle = 0
srcimghandle = Send(Handle(this), 1345, 0, 0)
if (srcimghandle <= 0) then
	return -15
end if
return(pB29(srcimghandle, win_hWnd, ref xpos, ref ypos))

end function

public function integer fu_mapscreenpts2imagepts (unsignedinteger win_hwnd, ref unsignedinteger xpos, ref unsignedinteger ypos);
unsignedlong srcimghandle = 0
srcimghandle = Send(Handle(this), 1345, 0, 0)
if (srcimghandle <= 0) then
	return -15
end if
return(pB24(srcimghandle, win_hWnd, ref xpos, ref ypos))

end function

public function integer fu_despeckle (integer level, integer mode);
return(Send(Handle(this), 1330, level, mode))
end function

public function integer fu_line_removal (integer minlength, integer mode);
return(Send(Handle(this), 1380, minlength, mode))
end function

public function integer fu_rotate_image_interp (double degree, long color, integer clockwise);
int   nDegree

if (clockwise = 0) then
	nDegree = Int(degree * 10)
else
	nDegree = Int((360.00 - degree) * 10)
end if

return(Send(handle(this), 1381, nDegree, color))
end function

public subroutine fu_set_autoredraw (integer mode);
Send(Handle(this), 1382, mode, 0)
end subroutine

public function integer fu_save_window_content (string filename, integer filetype, integer bitdepth, integer dithermode, unsignedinteger pb_hWnd);
return(pb30(filename,filetype,bitdepth,dithermode,pb_hWnd))
end function

event constructor;long rcode = 0

rcode = LoadLibraryA("vispb32.dll")

if (rcode > 0) then
	pb99(Handle(this))
end if	
end event

on visimage32.create
end on

on visimage32.destroy
end on

event destructor;pb100(Handle(this))
end event

