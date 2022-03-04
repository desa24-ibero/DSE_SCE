$PBExportHeader$w_solicitud_equivalencias.srw
forward
global type w_solicitud_equivalencias from Window
end type
type dw_1 from uo_dw_reporte within w_solicitud_equivalencias
end type
type st_1 from statictext within w_solicitud_equivalencias
end type
type em_fecha from editmask within w_solicitud_equivalencias
end type
type uo_nombre from uo_nombre_aspirante_reval within w_solicitud_equivalencias
end type
type cb_1 from commandbutton within w_solicitud_equivalencias
end type
end forward

global type w_solicitud_equivalencias from Window
int X=845
int Y=371
int Width=3397
int Height=1741
boolean TitleBar=true
string Title="Solicitud de Equivalencias"
string MenuName="m_ancestro_menu_reportes"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_1 dw_1
st_1 st_1
em_fecha em_fecha
uo_nombre uo_nombre
cb_1 cb_1
end type
global w_solicitud_equivalencias w_solicitud_equivalencias

type variables
str_imp_sol_reval_sep istr_sol_reval_sep
end variables

on w_solicitud_equivalencias.create
if this.MenuName = "m_ancestro_menu_reportes" then this.MenuID = create m_ancestro_menu_reportes
this.dw_1=create dw_1
this.st_1=create st_1
this.em_fecha=create em_fecha
this.uo_nombre=create uo_nombre
this.cb_1=create cb_1
this.Control[]={this.dw_1,&
this.st_1,&
this.em_fecha,&
this.uo_nombre,&
this.cb_1}
end on

on w_solicitud_equivalencias.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.em_fecha)
destroy(this.uo_nombre)
destroy(this.cb_1)
end on

event open;string ls_fecha_servidor
datetime ldttm_fecha_servidor

x=1
y=1


ldttm_fecha_servidor= fecha_servidor(gtr_sce)

ls_fecha_servidor = string(ldttm_fecha_servidor, "dd/mm/yyyy")

em_fecha.text = ls_fecha_servidor




end event

type dw_1 from uo_dw_reporte within w_solicitud_equivalencias
int X=62
int Y=656
int Width=3240
int Height=822
int TabOrder=40
string DataObject="d_solicitud_equivalencias"
boolean HScrollBar=true
end type

event inicia_transaction_object;/*
DESCRIPCIÓN: Evento en el que se asigna al tr_dw_propio el objeto de transacción que se va a utilizar en el dw.
					 El codigo de este evento se agrega desde el control en la ventana
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: CAMP(DkWf)
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/
//tr_dw_propio = create transaction

//Ejemplo:					

tr_dw_propio = gtr_sce
SetTransObject(tr_dw_propio)

end event

event constructor;call super::constructor;triggerevent("inicia_transaction_object")

end event

type st_1 from statictext within w_solicitud_equivalencias
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

type em_fecha from editmask within w_solicitud_equivalencias
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

type uo_nombre from uo_nombre_aspirante_reval within w_solicitud_equivalencias
int X=51
int Y=32
int TabOrder=10
boolean Enabled=true
end type

on uo_nombre.destroy
call uo_nombre_aspirante_reval::destroy
end on

type cb_1 from commandbutton within w_solicitud_equivalencias
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

