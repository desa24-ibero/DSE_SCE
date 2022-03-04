$PBExportHeader$u_client.sru
forward
global type u_client from userobject
end type
type st_32 from u_relationship within u_client
end type
type st_31 from u_relationship within u_client
end type
type st_30 from u_relationship within u_client
end type
type st_29 from u_relationship within u_client
end type
type st_28 from u_relationship within u_client
end type
type st_27 from u_relationship within u_client
end type
type st_26 from u_relationship within u_client
end type
type st_25 from u_relationship within u_client
end type
type st_24 from u_relationship within u_client
end type
type st_23 from u_relationship within u_client
end type
type st_22 from u_relationship within u_client
end type
type st_21 from u_relationship within u_client
end type
type st_20 from u_relationship within u_client
end type
type st_19 from u_relationship within u_client
end type
type st_18 from u_relationship within u_client
end type
type st_17 from u_relationship within u_client
end type
type st_16 from u_relationship within u_client
end type
type st_15 from u_relationship within u_client
end type
type st_14 from u_relationship within u_client
end type
type st_13 from u_relationship within u_client
end type
type st_12 from u_relationship within u_client
end type
type st_11 from u_relationship within u_client
end type
type st_10 from u_relationship within u_client
end type
type st_9 from u_relationship within u_client
end type
type st_8 from u_relationship within u_client
end type
type st_7 from u_relationship within u_client
end type
type st_6 from u_relationship within u_client
end type
type st_5 from u_relationship within u_client
end type
type st_4 from u_relationship within u_client
end type
type st_3 from u_relationship within u_client
end type
type st_2 from u_relationship within u_client
end type
type st_1 from u_relationship within u_client
end type
type ln_1 from u_join within u_client
end type
type ln_2 from u_join within u_client
end type
type ln_3 from u_join within u_client
end type
type ln_4 from u_join within u_client
end type
type ln_5 from u_join within u_client
end type
type ln_6 from u_join within u_client
end type
type ln_7 from u_join within u_client
end type
type ln_8 from u_join within u_client
end type
type ln_9 from u_join within u_client
end type
type ln_10 from u_join within u_client
end type
type ln_11 from u_join within u_client
end type
type ln_12 from u_join within u_client
end type
type ln_13 from u_join within u_client
end type
type ln_14 from u_join within u_client
end type
type ln_15 from u_join within u_client
end type
type ln_16 from u_join within u_client
end type
type ln_17 from u_join within u_client
end type
type ln_18 from u_join within u_client
end type
type ln_19 from u_join within u_client
end type
type ln_20 from u_join within u_client
end type
type ln_21 from u_join within u_client
end type
type ln_22 from u_join within u_client
end type
type ln_23 from u_join within u_client
end type
type ln_24 from u_join within u_client
end type
type ln_25 from u_join within u_client
end type
type ln_26 from u_join within u_client
end type
type ln_27 from u_join within u_client
end type
type ln_28 from u_join within u_client
end type
type ln_29 from u_join within u_client
end type
type ln_30 from u_join within u_client
end type
type ln_31 from u_join within u_client
end type
type ln_32 from u_join within u_client
end type
end forward

global type u_client from userobject
integer width = 2811
integer height = 1292
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = true
long backcolor = 16777215
string text = "none"
integer unitsperline = 50
integer unitspercolumn = 500
borderstyle borderstyle = stylelowered!
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event vscroll pbm_vscroll
event hscroll pbm_hscroll
event mousemove pbm_mousemove
event clicked pbm_lbuttonclk
event lbuttonup pbm_lbuttonup
st_32 st_32
st_31 st_31
st_30 st_30
st_29 st_29
st_28 st_28
st_27 st_27
st_26 st_26
st_25 st_25
st_24 st_24
st_23 st_23
st_22 st_22
st_21 st_21
st_20 st_20
st_19 st_19
st_18 st_18
st_17 st_17
st_16 st_16
st_15 st_15
st_14 st_14
st_13 st_13
st_12 st_12
st_11 st_11
st_10 st_10
st_9 st_9
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
ln_4 ln_4
ln_5 ln_5
ln_6 ln_6
ln_7 ln_7
ln_8 ln_8
ln_9 ln_9
ln_10 ln_10
ln_11 ln_11
ln_12 ln_12
ln_13 ln_13
ln_14 ln_14
ln_15 ln_15
ln_16 ln_16
ln_17 ln_17
ln_18 ln_18
ln_19 ln_19
ln_20 ln_20
ln_21 ln_21
ln_22 ln_22
ln_23 ln_23
ln_24 ln_24
ln_25 ln_25
ln_26 ln_26
ln_27 ln_27
ln_28 ln_28
ln_29 ln_29
ln_30 ln_30
ln_31 ln_31
ln_32 ln_32
end type
global u_client u_client

type variables
Boolean ib_join = FALSE

u_join iuo_join[]
u_join iuo_current

Long il_vpos
Long il_hpos
end variables

forward prototypes
public function integer of_startjoin (u_dw_table idw_table, integer il_row)
public function integer of_endjoin (u_dw_table idw_table, integer il_row)
public function u_join of_getnextline ()
public function integer of_canceljoin ()
end prototypes

event vscroll;IF ScrollPos > THIS.Height THEN
	il_vpos = ScrollPos - THIS.Height
ELSE
	il_vpos = 0
END IF

SetRedraw(TRUE)
SetFocus()
end event

event hscroll;Long ll_pos

ll_pos = PixelsToUnits(scrollpos, XPixelsToUnits!)

IF ll_pos > THIS.Width THEN
	il_hpos = ll_pos - THIS.Width
ELSE
	il_hpos = 0
END IF

SetRedraw(TRUE)
SetFocus()
end event

event mousemove;IF ib_join THEN
	
	IF PointerX() < (iuo_current.idw_tableA.X + (iuo_current.idw_tableA.Width / 2)) THEN
		iuo_current.BeginX = iuo_current.idw_tableA.X
	ELSE
		iuo_current.BeginX = iuo_current.idw_tableA.X + iuo_current.idw_tableA.Width
	END IF
	
	iuo_current.EndX = PointerX()
	iuo_current.EndY = PointerY()
	
	iuo_current.of_PositionRelationship()
END IF
end event

event clicked;of_CancelJoin()
end event

event lbuttonup;of_CancelJoin()
end event

public function integer of_startjoin (u_dw_table idw_table, integer il_row);Long ll_firstrow, ll_lastrow

iuo_current.Visible = TRUE
iuo_current.iuo_relationship.Visible = TRUE
ib_join = TRUE

iuo_current.idw_tableA = idw_table
iuo_current.ii_rowA = il_row
idw_table.TriggerEvent('positionchanging')

RETURN 1
end function

public function integer of_endjoin (u_dw_table idw_table, integer il_row);Long ll_firstrow, ll_lastrow

IF iuo_current.idw_tableA = idw_table THEN
	of_CancelJoin()
	RETURN 0
END IF

ib_join = FALSE

iuo_current.idw_tableB = idw_table
iuo_current.ii_rowB = il_row

idw_table.TriggerEvent('positionchanging')

RETURN 1
end function

public function u_join of_getnextline ();Long ll_index, ll_rowcount

ll_rowcount = UpperBound(iuo_join)

FOR ll_index = 1 TO ll_rowcount
	IF NOT iuo_join[ll_index].Visible THEN
		EXIT
	END IF
NEXT

iuo_current = iuo_join[ll_index]

RETURN iuo_current
end function

public function integer of_canceljoin ();u_dw_table luo_table

IF ib_join THEN
	iuo_current.of_CloseJoin()
	ib_join = FALSE
END IF

RETURN 1
end function

on u_client.create
this.st_32=create st_32
this.st_31=create st_31
this.st_30=create st_30
this.st_29=create st_29
this.st_28=create st_28
this.st_27=create st_27
this.st_26=create st_26
this.st_25=create st_25
this.st_24=create st_24
this.st_23=create st_23
this.st_22=create st_22
this.st_21=create st_21
this.st_20=create st_20
this.st_19=create st_19
this.st_18=create st_18
this.st_17=create st_17
this.st_16=create st_16
this.st_15=create st_15
this.st_14=create st_14
this.st_13=create st_13
this.st_12=create st_12
this.st_11=create st_11
this.st_10=create st_10
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
this.ln_4=create ln_4
this.ln_5=create ln_5
this.ln_6=create ln_6
this.ln_7=create ln_7
this.ln_8=create ln_8
this.ln_9=create ln_9
this.ln_10=create ln_10
this.ln_11=create ln_11
this.ln_12=create ln_12
this.ln_13=create ln_13
this.ln_14=create ln_14
this.ln_15=create ln_15
this.ln_16=create ln_16
this.ln_17=create ln_17
this.ln_18=create ln_18
this.ln_19=create ln_19
this.ln_20=create ln_20
this.ln_21=create ln_21
this.ln_22=create ln_22
this.ln_23=create ln_23
this.ln_24=create ln_24
this.ln_25=create ln_25
this.ln_26=create ln_26
this.ln_27=create ln_27
this.ln_28=create ln_28
this.ln_29=create ln_29
this.ln_30=create ln_30
this.ln_31=create ln_31
this.ln_32=create ln_32
this.Control[]={this.st_32,&
this.st_31,&
this.st_30,&
this.st_29,&
this.st_28,&
this.st_27,&
this.st_26,&
this.st_25,&
this.st_24,&
this.st_23,&
this.st_22,&
this.st_21,&
this.st_20,&
this.st_19,&
this.st_18,&
this.st_17,&
this.st_16,&
this.st_15,&
this.st_14,&
this.st_13,&
this.st_12,&
this.st_11,&
this.st_10,&
this.st_9,&
this.st_8,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.ln_1,&
this.ln_2,&
this.ln_3,&
this.ln_4,&
this.ln_5,&
this.ln_6,&
this.ln_7,&
this.ln_8,&
this.ln_9,&
this.ln_10,&
this.ln_11,&
this.ln_12,&
this.ln_13,&
this.ln_14,&
this.ln_15,&
this.ln_16,&
this.ln_17,&
this.ln_18,&
this.ln_19,&
this.ln_20,&
this.ln_21,&
this.ln_22,&
this.ln_23,&
this.ln_24,&
this.ln_25,&
this.ln_26,&
this.ln_27,&
this.ln_28,&
this.ln_29,&
this.ln_30,&
this.ln_31,&
this.ln_32}
end on

on u_client.destroy
destroy(this.st_32)
destroy(this.st_31)
destroy(this.st_30)
destroy(this.st_29)
destroy(this.st_28)
destroy(this.st_27)
destroy(this.st_26)
destroy(this.st_25)
destroy(this.st_24)
destroy(this.st_23)
destroy(this.st_22)
destroy(this.st_21)
destroy(this.st_20)
destroy(this.st_19)
destroy(this.st_18)
destroy(this.st_17)
destroy(this.st_16)
destroy(this.st_15)
destroy(this.st_14)
destroy(this.st_13)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
destroy(this.ln_4)
destroy(this.ln_5)
destroy(this.ln_6)
destroy(this.ln_7)
destroy(this.ln_8)
destroy(this.ln_9)
destroy(this.ln_10)
destroy(this.ln_11)
destroy(this.ln_12)
destroy(this.ln_13)
destroy(this.ln_14)
destroy(this.ln_15)
destroy(this.ln_16)
destroy(this.ln_17)
destroy(this.ln_18)
destroy(this.ln_19)
destroy(this.ln_20)
destroy(this.ln_21)
destroy(this.ln_22)
destroy(this.ln_23)
destroy(this.ln_24)
destroy(this.ln_25)
destroy(this.ln_26)
destroy(this.ln_27)
destroy(this.ln_28)
destroy(this.ln_29)
destroy(this.ln_30)
destroy(this.ln_31)
destroy(this.ln_32)
end on

event constructor;iuo_join[1] = ln_1
iuo_join[2] = ln_2
iuo_join[3] = ln_3
iuo_join[4] = ln_4
iuo_join[5] = ln_5
iuo_join[6] = ln_6
iuo_join[7] = ln_7
iuo_join[8] = ln_8
iuo_join[9] = ln_9
iuo_join[10] = ln_10
iuo_join[11] = ln_11
iuo_join[12] = ln_12
iuo_join[13] = ln_13
iuo_join[14] = ln_14
iuo_join[15] = ln_15
iuo_join[16] = ln_16
iuo_join[17] = ln_17
iuo_join[18] = ln_18
iuo_join[19] = ln_19
iuo_join[20] = ln_20
iuo_join[21] = ln_21
iuo_join[22] = ln_22
iuo_join[23] = ln_23
iuo_join[24] = ln_24
iuo_join[25] = ln_25
iuo_join[26] = ln_26
iuo_join[27] = ln_27
iuo_join[28] = ln_28
iuo_join[29] = ln_29
iuo_join[30] = ln_30
iuo_join[31] = ln_31
iuo_join[32] = ln_32
end event

type st_32 from u_relationship within u_client
integer x = 2094
integer y = 1008
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_32
end event

type st_31 from u_relationship within u_client
integer x = 1957
integer y = 1008
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_31
end event

type st_30 from u_relationship within u_client
integer x = 1824
integer y = 1008
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_30
end event

type st_29 from u_relationship within u_client
integer x = 1687
integer y = 1008
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_29
end event

type st_28 from u_relationship within u_client
integer x = 1563
integer y = 1008
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_28
end event

type st_27 from u_relationship within u_client
integer x = 1435
integer y = 1008
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_27
end event

type st_26 from u_relationship within u_client
integer x = 1303
integer y = 1008
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_26
end event

type st_25 from u_relationship within u_client
integer x = 1166
integer y = 1008
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_25
end event

type st_24 from u_relationship within u_client
integer x = 1038
integer y = 1008
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_24
end event

type st_23 from u_relationship within u_client
integer x = 914
integer y = 1008
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_23
end event

type st_22 from u_relationship within u_client
integer x = 786
integer y = 1008
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_22
end event

type st_21 from u_relationship within u_client
integer x = 654
integer y = 1008
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_21
end event

type st_20 from u_relationship within u_client
integer x = 521
integer y = 1008
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_20
end event

type st_19 from u_relationship within u_client
integer x = 389
integer y = 1008
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_19
end event

type st_18 from u_relationship within u_client
integer x = 261
integer y = 1008
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_18
end event

type st_17 from u_relationship within u_client
integer x = 123
integer y = 1008
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_17
end event

type st_16 from u_relationship within u_client
integer x = 2094
integer y = 760
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_16
end event

type st_15 from u_relationship within u_client
integer x = 1957
integer y = 760
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_15
end event

type st_14 from u_relationship within u_client
integer x = 1824
integer y = 760
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_14
end event

type st_13 from u_relationship within u_client
integer x = 1687
integer y = 760
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_13
end event

type st_12 from u_relationship within u_client
integer x = 1563
integer y = 760
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_12
end event

type st_11 from u_relationship within u_client
integer x = 1435
integer y = 760
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_11
end event

type st_10 from u_relationship within u_client
integer x = 1303
integer y = 760
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_10
end event

type st_9 from u_relationship within u_client
integer x = 1166
integer y = 760
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_9
end event

type st_8 from u_relationship within u_client
integer x = 1038
integer y = 760
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_8
end event

type st_7 from u_relationship within u_client
integer x = 914
integer y = 760
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_7
end event

type st_6 from u_relationship within u_client
integer x = 786
integer y = 760
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_6
end event

type st_5 from u_relationship within u_client
integer x = 654
integer y = 760
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_5
end event

type st_4 from u_relationship within u_client
integer x = 521
integer y = 760
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_4
end event

type st_3 from u_relationship within u_client
integer x = 389
integer y = 760
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_3
end event

type st_2 from u_relationship within u_client
integer x = 261
integer y = 760
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_2
end event

type st_1 from u_relationship within u_client
integer x = 123
integer y = 760
integer height = 72
end type

event constructor;call super::constructor;iuo_join = ln_1
end event

type ln_1 from u_join within u_client
integer beginx = 50
integer beginy = 692
integer endx = 279
integer endy = 892
end type

event constructor;call super::constructor;iuo_relationship = st_1
iuo_client = PARENT
end event

type ln_2 from u_join within u_client
integer beginx = 187
integer beginy = 692
integer endx = 416
integer endy = 892
end type

event constructor;call super::constructor;iuo_relationship = st_2
iuo_client = PARENT
end event

type ln_3 from u_join within u_client
integer beginx = 315
integer beginy = 692
integer endx = 544
integer endy = 892
end type

event constructor;call super::constructor;iuo_relationship = st_3
iuo_client = PARENT
end event

type ln_4 from u_join within u_client
integer beginx = 448
integer beginy = 692
integer endx = 677
integer endy = 892
end type

event constructor;call super::constructor;iuo_relationship = st_4
iuo_client = PARENT
end event

type ln_5 from u_join within u_client
integer beginx = 581
integer beginy = 692
integer endx = 809
integer endy = 892
end type

event constructor;call super::constructor;iuo_relationship = st_5
iuo_client = PARENT
end event

type ln_6 from u_join within u_client
integer beginx = 713
integer beginy = 692
integer endx = 942
integer endy = 892
end type

event constructor;call super::constructor;iuo_relationship = st_6
iuo_client = PARENT
end event

type ln_7 from u_join within u_client
integer beginx = 841
integer beginy = 692
integer endx = 1070
integer endy = 892
end type

event constructor;call super::constructor;iuo_relationship = st_7
iuo_client = PARENT
end event

type ln_8 from u_join within u_client
integer beginx = 965
integer beginy = 692
integer endx = 1193
integer endy = 892
end type

event constructor;call super::constructor;iuo_relationship = st_8
iuo_client = PARENT
end event

type ln_9 from u_join within u_client
integer beginx = 1093
integer beginy = 692
integer endx = 1321
integer endy = 892
end type

event constructor;call super::constructor;iuo_relationship = st_9
iuo_client = PARENT
end event

type ln_10 from u_join within u_client
integer beginx = 1230
integer beginy = 692
integer endx = 1458
integer endy = 892
end type

event constructor;call super::constructor;iuo_relationship = st_10
iuo_client = PARENT
end event

type ln_11 from u_join within u_client
integer beginx = 1362
integer beginy = 692
integer endx = 1591
integer endy = 892
end type

event constructor;call super::constructor;iuo_relationship = st_11
iuo_client = PARENT
end event

type ln_12 from u_join within u_client
integer beginx = 1490
integer beginy = 692
integer endx = 1719
integer endy = 892
end type

event constructor;call super::constructor;iuo_relationship = st_12
iuo_client = PARENT
end event

type ln_13 from u_join within u_client
integer beginx = 1614
integer beginy = 692
integer endx = 1842
integer endy = 892
end type

event constructor;call super::constructor;iuo_relationship = st_13
iuo_client = PARENT
end event

type ln_14 from u_join within u_client
integer beginx = 1751
integer beginy = 692
integer endx = 1979
integer endy = 892
end type

event constructor;call super::constructor;iuo_relationship = st_14
iuo_client = PARENT
end event

type ln_15 from u_join within u_client
integer beginx = 1883
integer beginy = 692
integer endx = 2112
integer endy = 892
end type

event constructor;call super::constructor;iuo_relationship = st_15
iuo_client = PARENT
end event

type ln_16 from u_join within u_client
integer beginx = 2021
integer beginy = 692
integer endx = 2249
integer endy = 892
end type

event constructor;call super::constructor;iuo_relationship = st_16
iuo_client = PARENT
end event

type ln_17 from u_join within u_client
integer beginx = 50
integer beginy = 936
integer endx = 279
integer endy = 1136
end type

event constructor;call super::constructor;iuo_relationship = st_17
iuo_client = PARENT
end event

type ln_18 from u_join within u_client
integer beginx = 187
integer beginy = 936
integer endx = 416
integer endy = 1136
end type

event constructor;call super::constructor;iuo_relationship = st_18
iuo_client = PARENT
end event

type ln_19 from u_join within u_client
integer beginx = 315
integer beginy = 936
integer endx = 544
integer endy = 1136
end type

event constructor;call super::constructor;iuo_relationship = st_19
iuo_client = PARENT
end event

type ln_20 from u_join within u_client
integer beginx = 448
integer beginy = 936
integer endx = 677
integer endy = 1136
end type

event constructor;call super::constructor;iuo_relationship = st_20
iuo_client = PARENT
end event

type ln_21 from u_join within u_client
integer beginx = 581
integer beginy = 936
integer endx = 809
integer endy = 1136
end type

event constructor;call super::constructor;iuo_relationship = st_21
iuo_client = PARENT
end event

type ln_22 from u_join within u_client
integer beginx = 713
integer beginy = 936
integer endx = 942
integer endy = 1136
end type

event constructor;call super::constructor;iuo_relationship = st_22
iuo_client = PARENT
end event

type ln_23 from u_join within u_client
integer beginx = 841
integer beginy = 936
integer endx = 1070
integer endy = 1136
end type

event constructor;call super::constructor;iuo_relationship = st_23
iuo_client = PARENT
end event

type ln_24 from u_join within u_client
integer beginx = 965
integer beginy = 936
integer endx = 1193
integer endy = 1136
end type

event constructor;call super::constructor;iuo_relationship = st_24
iuo_client = PARENT
end event

type ln_25 from u_join within u_client
integer beginx = 1093
integer beginy = 936
integer endx = 1321
integer endy = 1136
end type

event constructor;call super::constructor;iuo_relationship = st_25
iuo_client = PARENT
end event

type ln_26 from u_join within u_client
integer beginx = 1230
integer beginy = 936
integer endx = 1458
integer endy = 1136
end type

event constructor;call super::constructor;iuo_relationship = st_26
iuo_client = PARENT
end event

type ln_27 from u_join within u_client
integer beginx = 1362
integer beginy = 936
integer endx = 1591
integer endy = 1136
end type

event constructor;call super::constructor;iuo_relationship = st_27
iuo_client = PARENT
end event

type ln_28 from u_join within u_client
integer beginx = 1490
integer beginy = 936
integer endx = 1719
integer endy = 1136
end type

event constructor;call super::constructor;iuo_relationship = st_28
iuo_client = PARENT
end event

type ln_29 from u_join within u_client
integer beginx = 1614
integer beginy = 936
integer endx = 1842
integer endy = 1136
end type

event constructor;call super::constructor;iuo_relationship = st_29
iuo_client = PARENT
end event

type ln_30 from u_join within u_client
integer beginx = 1751
integer beginy = 936
integer endx = 1979
integer endy = 1136
end type

event constructor;call super::constructor;iuo_relationship = st_30
iuo_client = PARENT
end event

type ln_31 from u_join within u_client
integer beginx = 1883
integer beginy = 936
integer endx = 2112
integer endy = 1136
end type

event constructor;call super::constructor;iuo_relationship = st_31
iuo_client = PARENT
end event

type ln_32 from u_join within u_client
integer beginx = 2021
integer beginy = 936
integer endx = 2249
integer endy = 1136
end type

event constructor;call super::constructor;iuo_relationship = st_32
iuo_client = PARENT
end event

