$PBExportHeader$w_file_functions.srw
$PBExportComments$Shows examples of how to Run other programs and check to see if other programs are running.
forward
global type w_file_functions from w_center
end type
type st_5 from statictext within w_file_functions
end type
type st_4 from statictext within w_file_functions
end type
type sle_windowname from singlelineedit within w_file_functions
end type
type st_3 from statictext within w_file_functions
end type
type st_2 from statictext within w_file_functions
end type
type st_1 from statictext within w_file_functions
end type
type sle_result from singlelineedit within w_file_functions
end type
type sle_file from singlelineedit within w_file_functions
end type
type rb_normal from radiobutton within w_file_functions
end type
type rb_min from radiobutton within w_file_functions
end type
type rb_max from radiobutton within w_file_functions
end type
type cb_close from commandbutton within w_file_functions
end type
type cb_2 from commandbutton within w_file_functions
end type
type cb_run from commandbutton within w_file_functions
end type
type sle_filename from singlelineedit within w_file_functions
end type
type rb_user from radiobutton within w_file_functions
end type
type rb_pre from radiobutton within w_file_functions
end type
type lb_desktop from listbox within w_file_functions
end type
type gb_2 from groupbox within w_file_functions
end type
type gb_run from groupbox within w_file_functions
end type
type gb_1 from groupbox within w_file_functions
end type
end forward

shared variables
boolean flag_window1
boolean flag_fish
boolean flag_train
boolean flag_colors
boolean flag_multwin
end variables

global type w_file_functions from w_center
int X=544
int Y=340
int Width=1847
int Height=1512
boolean TitleBar=true
string Title="Working with Executables"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
st_5 st_5
st_4 st_4
sle_windowname sle_windowname
st_3 st_3
st_2 st_2
st_1 st_1
sle_result sle_result
sle_file sle_file
rb_normal rb_normal
rb_min rb_min
rb_max rb_max
cb_close cb_close
cb_2 cb_2
cb_run cb_run
sle_filename sle_filename
rb_user rb_user
rb_pre rb_pre
lb_desktop lb_desktop
gb_2 gb_2
gb_run gb_run
gb_1 gb_1
end type
global w_file_functions w_file_functions

type prototypes

end prototypes

forward prototypes
public function string of_getrunnable ()
public function string of_getwindowname ()
public function windowstate of_getwindowstate ()
end prototypes

public function string of_getrunnable ();string	ls_selected

if rb_pre.checked then
	ls_selected = lb_desktop.selecteditem()
	choose case ls_selected
	case "Calculator"
		return "calc"
	case "Notepad"
		return "notepad"
	case "Solitaire"
		return "Sol"
	case "Word Pad"
		return "write"
	case "Paint Brush"
		return "pbrush"
	case "Character Map"
		return "charmap"
	case else
		return ""
end choose
else
	return (sle_filename.text)
end if
end function

public function string of_getwindowname ();string	ls_selected 
if rb_pre.checked then
	ls_selected = lb_desktop.selecteditem()
	choose case ls_selected
		case "Calculator"
			return "Calculator"
		case "Notepad"
			return "untitled - notepad"
		case "Solitaire"
			return "Solitaire"
		case "Word Pad"
			return "Document - WordPad"
		case "Paint Brush"
			return "untitled - paint"
		case "Character Map"
			return "Character Map"
		case else
			return ""
	end choose
else
	return (sle_windowname.text)
end if

end function

public function windowstate of_getwindowstate ();//Check state of three radio button on screen and
//return the appropriate enumerated windowstate type

if rb_max.checked then
	return maximized!
elseif rb_min.checked then
	return minimized!
else
	return normal!
end if
end function

on open;//open event
//select first item
lb_desktop.selectitem(1)
end on

on close;//Close script for w_run_others

w_main.Show( )

end on

on w_file_functions.create
this.st_5=create st_5
this.st_4=create st_4
this.sle_windowname=create sle_windowname
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_result=create sle_result
this.sle_file=create sle_file
this.rb_normal=create rb_normal
this.rb_min=create rb_min
this.rb_max=create rb_max
this.cb_close=create cb_close
this.cb_2=create cb_2
this.cb_run=create cb_run
this.sle_filename=create sle_filename
this.rb_user=create rb_user
this.rb_pre=create rb_pre
this.lb_desktop=create lb_desktop
this.gb_2=create gb_2
this.gb_run=create gb_run
this.gb_1=create gb_1
this.Control[]={this.st_5,&
this.st_4,&
this.sle_windowname,&
this.st_3,&
this.st_2,&
this.st_1,&
this.sle_result,&
this.sle_file,&
this.rb_normal,&
this.rb_min,&
this.rb_max,&
this.cb_close,&
this.cb_2,&
this.cb_run,&
this.sle_filename,&
this.rb_user,&
this.rb_pre,&
this.lb_desktop,&
this.gb_2,&
this.gb_run,&
this.gb_1}
end on

on w_file_functions.destroy
destroy(this.st_5)
destroy(this.st_4)
destroy(this.sle_windowname)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_result)
destroy(this.sle_file)
destroy(this.rb_normal)
destroy(this.rb_min)
destroy(this.rb_max)
destroy(this.cb_close)
destroy(this.cb_2)
destroy(this.cb_run)
destroy(this.sle_filename)
destroy(this.rb_user)
destroy(this.rb_pre)
destroy(this.lb_desktop)
destroy(this.gb_2)
destroy(this.gb_run)
destroy(this.gb_1)
end on

type st_5 from statictext within w_file_functions
int X=750
int Y=484
int Width=645
int Height=72
boolean Enabled=false
string Text="Window Name (from title bar):"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_file_functions
int X=754
int Y=280
int Width=645
int Height=68
boolean Enabled=false
string Text="Executable File Name:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_windowname from singlelineedit within w_file_functions
int X=750
int Y=568
int Width=645
int Height=84
int TabOrder=50
boolean Enabled=false
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_file_functions
int X=18
int Y=16
int Width=1408
int Height=68
boolean Enabled=false
string Text="Choose a program and hit the Run or Running buttons."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_file_functions
int X=50
int Y=940
int Width=256
int Height=68
boolean Enabled=false
string Text="Program:"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_file_functions
int X=50
int Y=1124
int Width=242
int Height=68
boolean Enabled=false
string Text="Status:"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_result from singlelineedit within w_file_functions
int X=50
int Y=1216
int Width=727
int Height=84
int TabOrder=90
boolean AutoHScroll=false
boolean DisplayOnly=true
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_file from singlelineedit within w_file_functions
int X=50
int Y=1024
int Width=727
int Height=84
int TabOrder=80
boolean DisplayOnly=true
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_normal from radiobutton within w_file_functions
int X=951
int Y=772
int Width=384
int Height=68
string Text="Norma&l"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_min from radiobutton within w_file_functions
int X=503
int Y=772
int Width=384
int Height=68
string Text="Minimi&zed"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_max from radiobutton within w_file_functions
int X=37
int Y=772
int Width=398
int Height=68
string Text="&Maximized"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_close from commandbutton within w_file_functions
int X=1472
int Y=404
int Width=306
int Height=100
int TabOrder=50
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close(parent)
end on

type cb_2 from commandbutton within w_file_functions
int X=1472
int Y=268
int Width=306
int Height=100
int TabOrder=40
string Text="Ru&nning ?"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;ulong 	lul_applhandle 
string 	ls_filename
string	ls_selected

ls_filename = of_GetWindowName()
lul_applhandle = gu_ext_func.uf_FindWindow(0, ls_filename)

sle_file.text = ls_filename

if lul_applhandle > 0 then
	sle_result.text = "Is Running"
else
	sle_result.text = "Is Not Running"
end if


end event

type cb_run from commandbutton within w_file_functions
int X=1472
int Y=132
int Width=306
int Height=100
int TabOrder=100
string Text="&Run"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// use the powerscript function RUN to execute the selected filename.
string	ls_filename

ls_filename = of_GetRunnable()

if ls_filename = "" then
	Messagebox ("Filename Required","Please Choose a File to Run")
	return
end if

sle_file.text = ls_filename

if Run(ls_filename, of_getwindowstate()) <> 1 then
	Messagebox("File not found","Could not find filename " + upper(ls_filename) +&
		".  Try specifying the fully qualified path.", Exclamation!)
	sle_result.text = "Did Not Run"
else
	sle_result.text = "Successfully Ran"
end if


end event

type sle_filename from singlelineedit within w_file_functions
int X=754
int Y=360
int Width=645
int Height=84
int TabOrder=30
boolean Enabled=false
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on losefocus;//when sle loses focus, move user entered filename to display at bottom
//and blank out the results line.

sle_file.text = sle_filename.text
sle_result.text = ""

end on

type rb_user from radiobutton within w_file_functions
int X=750
int Y=180
int Width=549
int Height=68
string Text="&User Supplied"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//Allow typeing in the sle and erase out results boxes 

sle_filename.enabled = true
sle_windowname.enabled = true
sle_file.text = ""
sle_result.text = ""
end event

type rb_pre from radiobutton within w_file_functions
int X=64
int Y=180
int Width=421
int Height=68
string Text="&Pre-defined"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//disallow changing the user filename box anymore

sle_filename.enabled = false
end on

type lb_desktop from listbox within w_file_functions
int X=64
int Y=260
int Width=617
int Height=396
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Calculator",&
"Notepad",&
"Solitaire",&
"Word Pad",&
"Paint Brush",&
"Character Map"}
end type

on selectionchanged;//whenever the user changes selected items, move that filename to the text box
//and blank out the results area.

sle_file.text = lb_desktop.SelectedItem( )
sle_result.text = ""
rb_pre.checked = true
end on

type gb_2 from groupbox within w_file_functions
int X=14
int Y=900
int Width=1367
int Height=480
int TabOrder=70
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_run from groupbox within w_file_functions
int X=14
int Y=716
int Width=1367
int Height=148
int TabOrder=60
string Text="Run State"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_file_functions
int X=14
int Y=116
int Width=1422
int Height=580
int TabOrder=10
string Text="Programs to work with:"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

