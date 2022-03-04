$PBExportHeader$u_splitbar.sru
forward
global type u_splitbar from statictext
end type
end forward

global type u_splitbar from statictext
integer width = 768
integer height = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 268435456
boolean focusrectangle = false
event mousemove pbm_mousemove
event lbuttonup pbm_lbuttonup
end type
global u_splitbar u_splitbar

type variables
String is_position
Long il_backcolor
Long il_movecolor

Long il_prevX
Long il_prevY

u_cst_querybuilder iuo_parent
end variables

forward prototypes
public function integer of_setposition (string as_pos)
public function integer of_setbackcolor (long al_backcolor)
end prototypes

event mousemove;
If Not KeyDown(keyLeftButton!) Then
	Return
End If

this.SetPosition(ToTop!)

il_prevx = iuo_parent.PointerX()
il_prevy = iuo_parent.PointerY()	

THIS.BackColor = il_movecolor

IF is_position = 'H' THEN
		
	// Position bar on its new location.
	THIS.Y = il_prevy

ELSEIF is_position = 'V' Then
	
	// Position bar on its new location.		
	this.X = il_prevx

End If
end event

event lbuttonup;THIS.BackColor = il_backcolor
end event

public function integer of_setposition (string as_pos);is_position = as_pos
RETURN 1
end function

public function integer of_setbackcolor (long al_backcolor);il_backcolor = al_backcolor
THIS.BackColor = il_backcolor

RETURN 1
end function

on u_splitbar.create
end on

on u_splitbar.destroy
end on

event constructor;il_movecolor = THIS.BackColor
end event

