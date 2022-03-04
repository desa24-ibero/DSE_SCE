$PBExportHeader$u_join.sru
forward
global type u_join from line
end type
end forward

global type u_join from line
boolean visible = false
long linecolor = 255
integer linethickness = 4
integer beginx = 261
integer beginy = 72
integer endx = 489
integer endy = 272
event resize pbm_size
end type
global u_join u_join

type variables
u_dw_table idw_tableA
Integer ii_rowA

u_dw_table idw_tableB
Integer ii_rowB

u_relationship iuo_relationship

String is_position

u_client iuo_client
end variables

forward prototypes
public function integer of_positionrelationship ()
public function integer of_closejoin ()
end prototypes

public function integer of_positionrelationship ();Long ll_centerx, ll_centery

ll_centerX = Abs(BeginX - EndX) / 2
ll_centerY = Abs(BeginY - EndY) / 2

IF BeginY < EndY THEN
	ll_centerY = ll_centerY + BeginY
ELSE
	ll_centerY = ll_centerY + EndY
END IF

IF BeginX < EndX THEN
	ll_centerX = ll_centerX + BeginX
ELSE
	ll_centerX = ll_centerX + EndX
END IF

iuo_relationship.X = ll_centerX - (iuo_relationship.Width / 2)
iuo_relationship.Y = ll_centerY - (iuo_relationship.Height / 2)

iuo_relationship.SetPosition(Behind!)

RETURN 1
end function

public function integer of_closejoin ();iuo_relationship.Visible = FALSE
THIS.Visible = FALSE

idw_tableA.of_CloseJoin(THIS)

IF IsValid(idw_tableB) THEN
	idw_tableB.of_CloseJoin(THIS)
END IF

RETURN 1

end function

on u_join.create
end on

on u_join.destroy
end on

