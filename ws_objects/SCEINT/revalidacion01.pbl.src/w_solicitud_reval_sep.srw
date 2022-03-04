$PBExportHeader$w_solicitud_reval_sep.srw
forward
global type w_solicitud_reval_sep from Window
end type
type st_1 from statictext within w_solicitud_reval_sep
end type
type em_fecha from editmask within w_solicitud_reval_sep
end type
type uo_nombre from uo_nombre_aspirante_reval within w_solicitud_reval_sep
end type
type cb_1 from commandbutton within w_solicitud_reval_sep
end type
type dw_1 from datawindow within w_solicitud_reval_sep
end type
end forward

global type w_solicitud_reval_sep from Window
int X=845
int Y=371
int Width=3397
int Height=1741
boolean TitleBar=true
string Title="Solicitud de Revalidación para SEP"
string MenuName="m_menu_sol_reval_sep"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_1 st_1
em_fecha em_fecha
uo_nombre uo_nombre
cb_1 cb_1
dw_1 dw_1
end type
global w_solicitud_reval_sep w_solicitud_reval_sep

type variables
str_imp_sol_reval_sep istr_sol_reval_sep
end variables

on w_solicitud_reval_sep.create
if this.MenuName = "m_menu_sol_reval_sep" then this.MenuID = create m_menu_sol_reval_sep
this.st_1=create st_1
this.em_fecha=create em_fecha
this.uo_nombre=create uo_nombre
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.em_fecha,&
this.uo_nombre,&
this.cb_1,&
this.dw_1}
end on

on w_solicitud_reval_sep.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.em_fecha)
destroy(this.uo_nombre)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;string ls_fecha_servidor
datetime ldttm_fecha_servidor

x=1
y=1


ldttm_fecha_servidor= fecha_servidor(gtr_sce)

ls_fecha_servidor = string(ldttm_fecha_servidor, "dd/mm/yyyy")

em_fecha.text = ls_fecha_servidor




end event

type st_1 from statictext within w_solicitud_reval_sep
int X=834
int Y=435
int Width=344
int Height=77
boolean Enabled=false
string Text="dd/mm/aaaa"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_fecha from editmask within w_solicitud_reval_sep
int X=805
int Y=522
int Width=402
int Height=90
int TabOrder=30
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="dd/mm/yyyy"
MaskDataType MaskDataType=DateTimeMask!
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_nombre from uo_nombre_aspirante_reval within w_solicitud_reval_sep
int X=51
int Y=32
int TabOrder=10
boolean Enabled=true
end type

on uo_nombre.destroy
call uo_nombre_aspirante_reval::destroy
end on

type cb_1 from commandbutton within w_solicitud_reval_sep
int X=2107
int Y=490
int Width=307
int Height=106
int TabOrder=20
string Text="Genera"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_folio
string ls_folio, ls_fecha
date ldt_fecha
datetime ldttm_fecha

ls_folio = uo_nombre.em_cuenta.text
ls_fecha = em_fecha.text

if not isdate(ls_fecha) then
	MessageBox("Datos incorrectos", "La Fecha escrita no es valida",StopSign!)
	return
end if

if not isnumber(ls_folio) then
	MessageBox("Datos incorrectos", "El Folio escrito no es valido",StopSign!)
	return
end if

ll_folio = long(ls_folio)

ldt_fecha = date(ls_fecha)

ldttm_fecha = datetime(ldt_fecha)

dw_1.Retrieve(ll_folio, ldttm_fecha)



end event

type dw_1 from datawindow within w_solicitud_reval_sep
int X=51
int Y=653
int Width=3240
int Height=822
int TabOrder=40
string DataObject="d_solicitud_reval_sep"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
end type

event constructor;//this.SetTransObject(gtr_sce)
//dw_1.Object.DataWindow.print.Preview = "yes"
//dw_1.Object.DataWindow.Print.Preview.Zoom = 100

str_imp_sol_reval_sep lstr_sol_reval_sep

m_menu_sol_reval_sep.dw = this

this.SetTransObject(gtr_sce)


//Orientación Portrait
this.Object.DataWindow.Print.Orientation	= 2

//Zoom Normal
this.Object.DataWindow.Zoom = 100	
this.Object.DataWindow.print.Preview = "yes"
this.Object.DataWindow.Print.Preview.Zoom = 100	


istr_sol_reval_sep.sdw_datawindow = this
istr_sol_reval_sep.sl_folio = 0
istr_sol_reval_sep.sw_window = parent
istr_sol_reval_sep.suo_user_object = uo_nombre

m_menu_sol_reval_sep.istr_sol_reval_sep = istr_sol_reval_sep




end event

