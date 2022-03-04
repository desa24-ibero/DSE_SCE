$PBExportHeader$w_splash.srw
$PBExportComments$Splash screen displayed on startup
forward
global type w_splash from w_center
end type
type p_splash from picture within w_splash
end type
type st_dir from statictext within w_splash
end type
type lb_dir from listbox within w_splash
end type
end forward

global type w_splash from w_center
int X=457
int Y=580
int Width=2203
int Height=1212
long BackColor=75530304
boolean titlebar=false
boolean Border=false
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=popup!
p_splash p_splash
st_dir st_dir
lb_dir lb_dir
end type
global w_splash w_splash

type prototypes
end prototypes

event open;call super::open;Integer			li_ScreenH, li_ScreenW
Environment	le_Env

If Message.StringParm = "hide" Then
	This.Hide()
	Return
End If

p_splash.Hide()

p_splash.SetRedraw(True)
p_splash.OriginalSize = True

This.Height = p_splash.Height
This.Width = p_splash.Width

p_splash.Show()

// Center window
GetEnvironment(le_Env)

li_ScreenH = PixelsToUnits(le_Env.ScreenHeight, YPixelsToUnits!)
li_ScreenW = PixelsToUnits(le_Env.ScreenWidth, XPixelsToUnits!)

This.Y = (li_ScreenH - This.Height) / 2
This.X = (li_ScreenW - This.Width) / 2
This.SetPosition(Topmost!)
end event

on w_splash.destroy
destroy(this.p_splash)
destroy(this.st_dir)
destroy(this.lb_dir)
end on

on w_splash.create
this.p_splash=create p_splash
this.st_dir=create st_dir
this.lb_dir=create lb_dir
this.Control[]={ this.p_splash,&
this.st_dir,&
this.lb_dir}
end on

type p_splash from picture within w_splash
int Width=2203
int Height=1212
string PictureName="example.bmp"
boolean FocusRectangle=false
end type

type st_dir from statictext within w_splash
int X=690
int Y=732
int Width=192
int Height=64
boolean Enabled=false
string Text="none"
boolean FocusRectangle=false
long BackColor=12632256
long BorderColor=8388608
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type lb_dir from listbox within w_splash
int X=101
int Y=660
int Width=384
int Height=304
int TabOrder=1
boolean VScrollBar=true
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

