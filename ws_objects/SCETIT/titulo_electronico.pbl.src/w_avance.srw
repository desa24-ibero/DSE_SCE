$PBExportHeader$w_avance.srw
forward
global type w_avance from window
end type
type st_avance from statictext within w_avance
end type
type hpb_docs from hprogressbar within w_avance
end type
end forward

global type w_avance from window
integer width = 1696
integer height = 324
windowtype windowtype = child!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_avance st_avance
hpb_docs hpb_docs
end type
global w_avance w_avance

on w_avance.create
this.st_avance=create st_avance
this.hpb_docs=create hpb_docs
this.Control[]={this.st_avance,&
this.hpb_docs}
end on

on w_avance.destroy
destroy(this.st_avance)
destroy(this.hpb_docs)
end on

type st_avance from statictext within w_avance
integer x = 78
integer y = 64
integer width = 1495
integer height = 80
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 67108864
string text = "Generando: "
boolean focusrectangle = false
end type

type hpb_docs from hprogressbar within w_avance
integer x = 78
integer y = 188
integer width = 1495
integer height = 68
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 1
boolean smoothscroll = true
end type

