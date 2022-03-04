$PBExportHeader$w_no_preinsc_internet.srw
forward
global type w_no_preinsc_internet from Window
end type
type cb_3 from commandbutton within w_no_preinsc_internet
end type
type cb_2 from commandbutton within w_no_preinsc_internet
end type
type cb_1 from commandbutton within w_no_preinsc_internet
end type
type dw_1 from datawindow within w_no_preinsc_internet
end type
end forward

global type w_no_preinsc_internet from Window
int X=845
int Y=371
int Width=2860
int Height=1229
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_no_preinsc_internet w_no_preinsc_internet

on w_no_preinsc_internet.create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_no_preinsc_internet.destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_3 from commandbutton within w_no_preinsc_internet
int X=1602
int Y=918
int Width=252
int Height=106
int TabOrder=30
string Text="Filtrar"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_null
setnull(ls_null)
dw_1.SetFilter(ls_null)
dw_1.Filter()

end event

type cb_2 from commandbutton within w_no_preinsc_internet
int X=2143
int Y=906
int Width=322
int Height=106
int TabOrder=20
string Text="Guardar"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_res 
string ls_mensaje
//li_res =dw_1.Update()
//
//IF li_res = 1  THEN
//	COMMIT USING gtr_sce;
//	MessageBox("Datos Correctos", "Datos bien guardados")
//ELSE
//	ls_mensaje= gtr_sce.SqlErrtext
//	ROLLBACK USING gtr_sce;
//	MessageBox("Error al grabar", ls_mensaje)
//END IF
//
dw_1.SaveAs("no_preinsc_internet.txt",Text!,true)
end event

type cb_1 from commandbutton within w_no_preinsc_internet
int X=1192
int Y=912
int Width=315
int Height=106
int TabOrder=30
string Text="Procesar"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_num_rows, ll_row_actual, ll_cve_mat, ll_cuenta, ll_row_cve_mat, ll_row_cuenta
long ll_row_anterior, ll_row_cve_mat_anterior
string ls_gpo, ls_row_gpo

ll_num_rows = dw_1.RowCount()
ll_cve_mat = 0
ll_cuenta = 0
ls_gpo = ""


for ll_row_actual = 1 to ll_num_rows
	ll_row_cuenta = dw_1.object.cuenta[ll_row_actual]
	if (ll_row_cuenta>0 ) and (ll_row_cuenta <> ll_cuenta) then
		ll_cuenta = ll_row_cuenta
	end if	
	if (ll_row_cuenta=0 or isnull(ll_row_cuenta)) and (ll_row_cuenta <> ll_cuenta) then
		dw_1.object.cuenta[ll_row_actual]= ll_cuenta
	end if	
next

for ll_row_actual = ll_num_rows to 1 step -1
	if ll_row_actual >2 then
		ll_row_anterior =ll_row_actual - 1
	end if		
	ll_row_cve_mat_anterior = dw_1.object.cve_mat[ll_row_anterior]
	ll_row_cve_mat = dw_1.object.cve_mat[ll_row_actual]
	ls_row_gpo = dw_1.object.gpo[ll_row_actual]
	if (not isnull(ls_row_gpo)) and ll_row_cve_mat =0 and ll_row_cve_mat_anterior >0 then
		dw_1.object.gpo[ll_row_anterior]= ls_row_gpo
	end if
next 


//for ll_row_actual = ll_num_rows to 1 step -1
//	ll_row_cve_mat = dw_1.object.cve_mat[ll_row_actual]
//	if (not isnull(ll_row_cve_mat) and ll_row_cve_mat<>0 ) and (ll_row_cve_mat <> ll_cve_mat) then
//		ll_cve_mat = ll_row_cve_mat
//	end if	
//	if (ll_row_cve_mat=0 or isnull(ll_row_cve_mat) ) and (ll_row_cve_mat <> ll_cve_mat) then
////	if isnull(ls_row_gpo)  then
//		dw_1.object.cve_mat[ll_row_actual]= ll_cve_mat
//	end if	
//next


//ls_row_gpo =dw_1.object.gpo[ll_row_actual]
//
//ll_row_cve_mat = dw_1.object.cve_mat[ll_row_actual]

end event

type dw_1 from datawindow within w_no_preinsc_internet
int X=146
int Y=144
int Width=2494
int Height=701
int TabOrder=10
string DataObject="d_no_preinsc_internet"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;this.SetTransObject(gtr_sce)
this.Retrieve()
end event

event dberror;return 0

end event

