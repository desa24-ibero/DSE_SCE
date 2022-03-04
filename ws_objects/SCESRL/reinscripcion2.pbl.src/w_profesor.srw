$PBExportHeader$w_profesor.srw
forward
global type w_profesor from Window
end type
type st_matgpo from statictext within w_profesor
end type
type st_prof from statictext within w_profesor
end type
type r_1 from rectangle within w_profesor
end type
end forward

global type w_profesor from Window
int X=517
int Y=2061
int Width=1802
int Height=249
long BackColor=15793151
boolean ToolBarVisible=false
WindowType WindowType=popup!
st_matgpo st_matgpo
st_prof st_prof
r_1 r_1
end type
global w_profesor w_profesor

on w_profesor.create
this.st_matgpo=create st_matgpo
this.st_prof=create st_prof
this.r_1=create r_1
this.Control[]={ this.st_matgpo,&
this.st_prof,&
this.r_1}
end on

on w_profesor.destroy
destroy(this.st_matgpo)
destroy(this.st_prof)
destroy(this.r_1)
end on

event deactivate;close(this)
end event

type st_matgpo from statictext within w_profesor
int X=10
int Y=9
int Width=1770
int Height=105
boolean Enabled=false
string Text="Profesor de la Materia "
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=15793151
long BackColor=0
int TextSize=-14
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_prof from statictext within w_profesor
int X=5
int Y=117
int Width=1779
int Height=113
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="     "
boolean FocusRectangle=false
long TextColor=128
long BackColor=15793151
long BorderColor=16777215
int TextSize=-14
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type r_1 from rectangle within w_profesor
int Y=5
int Width=1793
int Height=233
boolean Enabled=false
int LineThickness=5
long LineColor=15793151
end type

