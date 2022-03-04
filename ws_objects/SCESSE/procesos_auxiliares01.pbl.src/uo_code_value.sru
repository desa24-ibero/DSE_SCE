$PBExportHeader$uo_code_value.sru
forward
global type uo_code_value from UserObject
end type
type dw_1 from datawindow within uo_code_value
end type
end forward

global type uo_code_value from UserObject
int Width=874
int Height=93
boolean Border=true
long BackColor=79741120
long PictureMaskColor=536870912
long TabBackColor=16777215
dw_1 dw_1
end type
global uo_code_value uo_code_value

forward prototypes
public function datawindowchild of_obten_datawindowchild ()
public function long of_obten_seleccionado_long ()
end prototypes

public function datawindowchild of_obten_datawindowchild ();//of_obten_datawindowchild
//Devuelve el datawindow external relacionado con el user object

DataWindowChild dwc 
integer rtncode 
 
rtncode = dw_1.GetChild("code_value", dwc) 
 
//Statements to check for errors 
dwc.SetTransObject (gtr_sce) 
dwc.AcceptText()

return dwc
end function

public function long of_obten_seleccionado_long ();//of_obten_seleccionado_long
//Devuelve el valor seleccionado en el datawindow

long ll_row, ll_code_seleccionado

ll_row= dw_1.GetRow()

ll_code_seleccionado = dw_1.GetItemNumber(ll_row, "code_value") 
 
return ll_code_seleccionado
end function

on uo_code_value.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on uo_code_value.destroy
destroy(this.dw_1)
end on

event constructor;long ll_row
dw_1.SetTransObject(gtr_sce)
ll_row = dw_1.InsertRow(0)




end event

type dw_1 from datawindow within uo_code_value
int Width=867
int Height=99
int TabOrder=10
string DataObject="d_ext_code_description"
boolean Border=false
boolean LiveScroll=true
end type

