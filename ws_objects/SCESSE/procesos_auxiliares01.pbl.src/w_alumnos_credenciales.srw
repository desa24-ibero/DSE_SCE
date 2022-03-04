$PBExportHeader$w_alumnos_credenciales.srw
forward
global type w_alumnos_credenciales from Window
end type
type cb_cargar from commandbutton within w_alumnos_credenciales
end type
type cb_generar from commandbutton within w_alumnos_credenciales
end type
type dw_1 from datawindow within w_alumnos_credenciales
end type
end forward

global type w_alumnos_credenciales from Window
int X=845
int Y=371
int Width=3324
int Height=1226
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_cargar cb_cargar
cb_generar cb_generar
dw_1 dw_1
end type
global w_alumnos_credenciales w_alumnos_credenciales

on w_alumnos_credenciales.create
this.cb_cargar=create cb_cargar
this.cb_generar=create cb_generar
this.dw_1=create dw_1
this.Control[]={this.cb_cargar,&
this.cb_generar,&
this.dw_1}
end on

on w_alumnos_credenciales.destroy
destroy(this.cb_cargar)
destroy(this.cb_generar)
destroy(this.dw_1)
end on

type cb_cargar from commandbutton within w_alumnos_credenciales
int X=658
int Y=195
int Width=388
int Height=106
int TabOrder=20
string Text="Cargar"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.Retrieve()
end event

type cb_generar from commandbutton within w_alumnos_credenciales
int X=2293
int Y=195
int Width=388
int Height=106
int TabOrder=10
string Text="Generar"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_FileNum
long ll_num_rows, ll_row_actual, ll_matricula
string ls_matricula, ls_separador, ls_apellidos, ls_nombre, ls_carrera, ls_grabacion_causa
string ls_tipo_de_grupo, ls_nombre_de_la_imagen, ls_registro, ls_digito

ll_num_rows=  dw_1.RowCount()

if ll_num_rows <= 0 then
	MessageBox("No hay datos", "Es necesario cargar antes de procesar")
	return
end if

li_FileNum = FileOpen("C:\CREDENCIALES.TXT", LineMode!, Write!, LockWrite!, Append!)

ls_separador = ";"
FOR ll_row_actual= 1 to ll_num_rows
	ll_matricula = dw_1.GetItemNumber(ll_row_actual, "matricula")
	ls_apellidos  = dw_1.GetItemString(ll_row_actual, "apellidos")
	ls_nombre  = dw_1.GetItemString(ll_row_actual, "alumnos_nombre")
	ls_carrera  = dw_1.GetItemString(ll_row_actual, "carrera")
	ls_grabacion_causa = dw_1.GetItemString(ll_row_actual, "grabacion_causa")
	ls_tipo_de_grupo = dw_1.GetItemString(ll_row_actual, "tipo_de_grupo")
	ls_nombre_de_la_imagen = dw_1.GetItemString(ll_row_actual, "nombre_de_la_imagen")
	
	ls_digito = obten_digito(ll_matricula)
	ls_matricula = string(ll_matricula,"0000000")+ls_digito
	ls_nombre_de_la_imagen = "A"+string(ll_matricula,"0000000")+".jpg"
	
	ls_registro = ls_matricula +ls_separador +ls_apellidos+ls_separador+ls_nombre+ls_separador+ &
					ls_carrera+ ls_separador+ ls_grabacion_causa+ls_separador+ls_tipo_de_grupo+ ls_separador+&
					ls_nombre_de_la_imagen	 
	
	FileWrite(li_FileNum, ls_registro)

NEXT
FileClose(li_FileNum)

end event

type dw_1 from datawindow within w_alumnos_credenciales
int X=366
int Y=438
int Width=2721
int Height=477
int TabOrder=20
string DataObject="d_alumnos_credenciales"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;SetTransObject(gtr_sce)
end event

