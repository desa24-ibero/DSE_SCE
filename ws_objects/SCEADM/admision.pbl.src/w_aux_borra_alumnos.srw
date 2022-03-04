$PBExportHeader$w_aux_borra_alumnos.srw
forward
global type w_aux_borra_alumnos from Window
end type
type dw_3 from datawindow within w_aux_borra_alumnos
end type
type cb_1 from commandbutton within w_aux_borra_alumnos
end type
type st_2 from statictext within w_aux_borra_alumnos
end type
type st_1 from statictext within w_aux_borra_alumnos
end type
type dw_2 from datawindow within w_aux_borra_alumnos
end type
type dw_1 from datawindow within w_aux_borra_alumnos
end type
end forward

global type w_aux_borra_alumnos from Window
int X=845
int Y=371
int Width=3569
int Height=1530
boolean TitleBar=true
string Title="Untitled"
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_3 dw_3
cb_1 cb_1
st_2 st_2
st_1 st_1
dw_2 dw_2
dw_1 dw_1
end type
global w_aux_borra_alumnos w_aux_borra_alumnos

on w_aux_borra_alumnos.create
this.dw_3=create dw_3
this.cb_1=create cb_1
this.st_2=create st_2
this.st_1=create st_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.dw_3,&
this.cb_1,&
this.st_2,&
this.st_1,&
this.dw_2,&
this.dw_1}
end on

on w_aux_borra_alumnos.destroy
destroy(this.dw_3)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;dw_1.SetTransObject(gtr_sce)
dw_2.SetTransObject(gtr_sce)
dw_3.SetTransObject(gtr_sce)

dw_1.Retrieve()
end event

type dw_3 from datawindow within w_aux_borra_alumnos
int X=512
int Y=1008
int Width=2480
int Height=237
int TabOrder=40
string DataObject="d_consulta_alumnos_nombre"
boolean LiveScroll=true
end type

type cb_1 from commandbutton within w_aux_borra_alumnos
int X=1536
int Y=1261
int Width=347
int Height=106
int TabOrder=30
string Text="Ejecutar"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_renglones, ll_renglon_actual, ll_nombres_parecidos, ll_nombres_parecido_act, ll_cuenta, ll_cve_carrera, ll_cve_plan
string ls_apaterno, ls_amaterno, ls_nombre, ls_apaterno_par, ls_amaterno_par, ls_nombre_par, ls_carrera
long ll_row_insertado, ll_update
ll_renglones = dw_1.RowCount()

FOR ll_renglon_actual= 1 to ll_renglones
	ls_apaterno = dw_1.GetItemString(ll_renglon_actual,"apaterno")
	ls_amaterno = dw_1.GetItemString(ll_renglon_actual,"amaterno")
	ls_nombre = dw_1.GetItemString(ll_renglon_actual,"nombre")
	if isnull(trim(ls_apaterno)) or trim(ls_apaterno) = "" then
		ls_apaterno= "%%"
	end if
	if isnull(trim(ls_amaterno)) or trim(ls_amaterno) = "" then
		ls_amaterno= "%%"
	end if
	if isnull(trim(ls_nombre)) or trim(ls_nombre) = "" then
		ls_nombre= "%%"
	end if
	
	ll_nombres_parecidos= dw_3.Retrieve(ls_apaterno, ls_amaterno, ls_nombre)
	FOR ll_nombres_parecido_act= 1 to ll_nombres_parecidos
		ll_cuenta = dw_3.GetItemNumber(ll_nombres_parecido_act,"alumnos_cuenta")
		ll_cve_carrera = dw_3.GetItemNumber(ll_nombres_parecido_act,"academicos_cve_carrera") 
		ll_cve_plan = dw_3.GetItemNumber(ll_nombres_parecido_act,"academicos_cve_plan") 
		ls_apaterno_par= dw_3.GetItemString(ll_nombres_parecido_act,"alumnos_apaterno")
		ls_amaterno_par= dw_3.GetItemString(ll_nombres_parecido_act,"alumnos_amaterno")
		ls_nombre_par= dw_3.GetItemString(ll_nombres_parecido_act,"alumnos_nombre")
		ls_carrera= dw_3.GetItemString(ll_nombres_parecido_act,"carreras_carrera")
		
		ll_row_insertado= dw_2.InsertRow(0)
		dw_2.SetItem(ll_row_insertado, "cuenta", ll_cuenta)
		dw_2.SetItem(ll_row_insertado, "apaterno", ls_apaterno_par)
		dw_2.SetItem(ll_row_insertado, "amaterno", ls_amaterno_par)
		dw_2.SetItem(ll_row_insertado, "nombre", ls_nombre_par)
		dw_2.SetItem(ll_row_insertado, "carrera", ls_carrera)
		dw_2.SetItem(ll_row_insertado, "cve_carrera", ll_cve_carrera)
		dw_2.SetItem(ll_row_insertado, "cve_plan", ll_cve_plan)		
	NEXT
	
NEXT

ll_update = dw_2.Update()
if ll_update= 1 then
	commit using gtr_sce;
else
	rollback using gtr_sce;	
end if



end event

type st_2 from statictext within w_aux_borra_alumnos
int X=1214
int Y=544
int Width=274
int Height=77
boolean Enabled=false
string Text="DESTINO"
boolean FocusRectangle=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_aux_borra_alumnos
int X=1101
int Y=45
int Width=252
int Height=77
boolean Enabled=false
string Text="ORIGEN"
boolean FocusRectangle=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_2 from datawindow within w_aux_borra_alumnos
int X=124
int Y=608
int Width=3072
int Height=368
int TabOrder=20
string DataObject="d_aux_borra_alumnos2"
boolean LiveScroll=true
end type

type dw_1 from datawindow within w_aux_borra_alumnos
int X=143
int Y=147
int Width=3076
int Height=368
int TabOrder=10
string DataObject="d_aux_borra_alumnos"
boolean LiveScroll=true
end type

