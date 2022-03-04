$PBExportHeader$w_estad_excel_academica.srw
forward
global type w_estad_excel_academica from Window
end type
type uo_carrera from uo_carreras within w_estad_excel_academica
end type
type uo_coordinacion from uo_coordinaciones within w_estad_excel_academica
end type
type gb_carreras from groupbox within w_estad_excel_academica
end type
type gb_coordinacion from groupbox within w_estad_excel_academica
end type
type st_3 from statictext within w_estad_excel_academica
end type
type dw_estadisticas from datawindow within w_estad_excel_academica
end type
type cb_1 from commandbutton within w_estad_excel_academica
end type
type dw_1x from datawindow within w_estad_excel_academica
end type
type gb_8 from groupbox within w_estad_excel_academica
end type
type gb_1 from groupbox within w_estad_excel_academica
end type
end forward

global type w_estad_excel_academica from Window
int X=0
int Y=0
int Width=3632
int Height=1958
boolean TitleBar=true
string Title="Estadística de Candidatos a Excelencia Académica"
string MenuName="m_estad_excel_academica"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
uo_carrera uo_carrera
uo_coordinacion uo_coordinacion
gb_carreras gb_carreras
gb_coordinacion gb_coordinacion
st_3 st_3
dw_estadisticas dw_estadisticas
cb_1 cb_1
dw_1x dw_1x
gb_8 gb_8
gb_1 gb_1
end type
global w_estad_excel_academica w_estad_excel_academica

type variables
int periodo_x
end variables

on w_estad_excel_academica.create
if this.MenuName = "m_estad_excel_academica" then this.MenuID = create m_estad_excel_academica
this.uo_carrera=create uo_carrera
this.uo_coordinacion=create uo_coordinacion
this.gb_carreras=create gb_carreras
this.gb_coordinacion=create gb_coordinacion
this.st_3=create st_3
this.dw_estadisticas=create dw_estadisticas
this.cb_1=create cb_1
this.dw_1x=create dw_1x
this.gb_8=create gb_8
this.gb_1=create gb_1
this.Control[]={this.uo_carrera,&
this.uo_coordinacion,&
this.gb_carreras,&
this.gb_coordinacion,&
this.st_3,&
this.dw_estadisticas,&
this.cb_1,&
this.dw_1x,&
this.gb_8,&
this.gb_1}
end on

on w_estad_excel_academica.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_carrera)
destroy(this.uo_coordinacion)
destroy(this.gb_carreras)
destroy(this.gb_coordinacion)
destroy(this.st_3)
destroy(this.dw_estadisticas)
destroy(this.cb_1)
destroy(this.dw_1x)
destroy(this.gb_8)
destroy(this.gb_1)
end on

event open;this.x=1
this.y=1

end event

type uo_carrera from uo_carreras within w_estad_excel_academica
event destroy ( )
int X=1456
int Y=202
int TabOrder=30
boolean Border=false
BorderStyle BorderStyle=StyleBox!
long BackColor=79741120
end type

on uo_carrera.destroy
call uo_carreras::destroy
end on

type uo_coordinacion from uo_coordinaciones within w_estad_excel_academica
event destroy ( )
int X=91
int Y=202
int TabOrder=40
boolean Border=false
BorderStyle BorderStyle=StyleBox!
long BackColor=79741120
end type

on uo_coordinacion.destroy
call uo_coordinaciones::destroy
end on

type gb_carreras from groupbox within w_estad_excel_academica
int X=1423
int Y=141
int Width=1295
int Height=224
int TabOrder=20
string Text="Carreras"
BorderStyle BorderStyle=StyleRaised!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_coordinacion from groupbox within w_estad_excel_academica
int X=59
int Y=144
int Width=1295
int Height=224
int TabOrder=50
string Text="Coordinación"
BorderStyle BorderStyle=StyleRaised!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_estad_excel_academica
int X=3079
int Y=74
int Width=443
int Height=77
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="Total : 0"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=15793151
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_estadisticas from datawindow within w_estad_excel_academica
int Y=416
int Width=3588
int Height=1331
int TabOrder=70
string DataObject="d_excelencia_academica"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;settransobject(gtr_sce)

this.Object.DataWindow.Zoom	= 80
this.Object.DataWindow.Print.Orientation = 1

//this.Object.DataWindow.Print.Preview.Zoom	= 82
this.Object.DataWindow.Print.Orientation = 1
m_estad_excel_academica.dw= this


end event

event retrieveend;/*Cuando dw_1 termine de leer los datos de la tabla...*/


string Cont
Cont = '0'
/*Verifica si se bajo más de un dato*/
if rowcount >= 1 then
	Cont = string(rowcount)
	// Se actualiza el numero de datos traidos
//	Cont =string(dw_1z.object.cuantos[1])
	st_3.text='Total : '+Cont
else
	st_3.text='Total : '+Cont
end if

end event

type cb_1 from commandbutton within w_estad_excel_academica
event clicked pbm_bnclicked
event constructor pbm_constructor
int X=3185
int Y=221
int Width=263
int Height=109
int TabOrder=80
boolean BringToTop=true
string Text="Cargar"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// Se recuperan los registros de la base de datos
long ll_renglon_uo
integer li_cve_forma_ingreso, li_anio, li_periodo, li_indice_nivel
string ls_anio, ls_nivel[], ls_periodo, ls_periodo_elegido, ls_forma_ingreso, ls_fecha_servidor
long ll_row_carrera, ll_cve_carrera, ll_row_coordinacion, ll_cve_coordinacion
datetime ldttm_fecha_servidor

ll_row_carrera = parent.uo_carrera.dw_carreras.GetRow()
ll_cve_carrera = parent.uo_carrera.dw_carreras.object.cve_carrera[ll_row_carrera]
ll_row_coordinacion = parent.uo_coordinacion.dw_coordinaciones.GetRow()
ll_cve_coordinacion = parent.uo_coordinacion.dw_coordinaciones.object.cve_coordinacion[ll_row_coordinacion]



setpointer(Hourglass!)
ldttm_fecha_servidor = fecha_servidor(gtr_sce)
ls_fecha_servidor= string(ldttm_fecha_servidor, "dd/mm/yyyy hh:mm")

dw_estadisticas.object.st_fecha_hoy.text= ls_fecha_servidor

gtr_sce.Autocommit = true
dw_estadisticas.Retrieve(ll_cve_carrera, ll_cve_coordinacion)
gtr_sce.Autocommit = false






end event

event constructor;TabOrder = 4
end event

type dw_1x from datawindow within w_estad_excel_academica
int X=3767
int Y=624
int Width=1039
int Height=563
int TabOrder=60
string DataObject="dw_repo_mad_18_gx"
boolean LiveScroll=true
end type

type gb_8 from groupbox within w_estad_excel_academica
int X=3149
int Y=170
int Width=329
int Height=176
int TabOrder=90
BorderStyle BorderStyle=StyleRaised!
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_estad_excel_academica
int Width=3588
int Height=419
int TabOrder=10
string Text="Criterios de Busqueda"
BorderStyle BorderStyle=StyleRaised!
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

