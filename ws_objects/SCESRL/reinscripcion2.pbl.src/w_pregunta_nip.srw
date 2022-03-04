$PBExportHeader$w_pregunta_nip.srw
forward
global type w_pregunta_nip from window
end type
type p_1 from picture within w_pregunta_nip
end type
type st_nip from statictext within w_pregunta_nip
end type
type st_nombre_alumno from statictext within w_pregunta_nip
end type
type sle_nip from singlelineedit within w_pregunta_nip
end type
type r_1 from rectangle within w_pregunta_nip
end type
end forward

global type w_pregunta_nip from window
integer x = 1074
integer y = 484
integer width = 1682
integer height = 452
boolean titlebar = true
string title = "Escribir nip"
windowtype windowtype = response!
long backcolor = 0
p_1 p_1
st_nip st_nip
st_nombre_alumno st_nombre_alumno
sle_nip sle_nip
r_1 r_1
end type
global w_pregunta_nip w_pregunta_nip

type variables
long il_cuenta
end variables

forward prototypes
public function integer compara_nip (long al_cuenta, string as_nip)
end prototypes

public function integer compara_nip (long al_cuenta, string as_nip);/*
 *		Nombre	compara_nips
 *		Recibe	al_cuenta, as_nip
 *		Regresa	0	si el alumno con cuenta al_cuenta no tiene nip registrado
 *					1	si el nip dado as_nip corresponde al nip de la cuenta al_cuenta
 *					2  si el nip dado as_nip no corresponde al nip de la cuenta al_cuenta
 *					-1	error de comunicacion
 *					FMC09041999
 */
 
DataStore lds_nips
int li_res, li_ret
string ls_nip
lds_nips = Create DataStore
lds_nips.DataObject = "d_nips"
lds_nips.SetTransObject(sqlca)
li_res = lds_nips.Retrieve(al_cuenta)
choose case li_res
	case 1
		ls_nip = lds_nips.GetItemString(1,"nip")
		consulta_sie(as_nip)
		if ls_nip = as_nip then
			li_ret = 1
		else
			messagebox("Nip incorrecto","El nip no corresponde a la cuenta "+string(al_cuenta)+"-"+&
			string(obten_digito(al_cuenta)),Exclamation!)
			li_ret = 2
		end if
	case 0
		messagebox("Nip inexistente","Es necesario que el alumno acuda a cargar su nip.",Exclamation!)
		li_ret = 0
	case else
		messagebox("Error de Comunicación","Error con la consulta de nips BD. Favor de intentar nuevamente", None!)
		li_ret = -1
end choose
Destroy lds_nips
return li_ret
end function

on w_pregunta_nip.create
this.p_1=create p_1
this.st_nip=create st_nip
this.st_nombre_alumno=create st_nombre_alumno
this.sle_nip=create sle_nip
this.r_1=create r_1
this.Control[]={this.p_1,&
this.st_nip,&
this.st_nombre_alumno,&
this.sle_nip,&
this.r_1}
end on

on w_pregunta_nip.destroy
destroy(this.p_1)
destroy(this.st_nip)
destroy(this.st_nombre_alumno)
destroy(this.sle_nip)
destroy(this.r_1)
end on

event open;il_cuenta = long(Mid(Message.StringParm,1,Pos(Message.StringParm,"@")-1))
st_nombre_alumno.text = "Alumno:      "+Mid(Message.StringParm,Pos(Message.StringParm,"@")+1)
end event

type p_1 from picture within w_pregunta_nip
integer x = 5
integer y = 4
integer width = 110
integer height = 92
string picturename = "uia2.bmp"
boolean focusrectangle = false
end type

type st_nip from statictext within w_pregunta_nip
integer x = 37
integer y = 220
integer width = 219
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 0
boolean enabled = false
string text = "Nip:"
boolean focusrectangle = false
end type

type st_nombre_alumno from statictext within w_pregunta_nip
integer x = 37
integer y = 108
integer width = 1586
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 0
boolean enabled = false
string text = "Alumno:      "
boolean focusrectangle = false
end type

type sle_nip from singlelineedit within w_pregunta_nip
integer x = 352
integer y = 196
integer width = 325
integer height = 108
integer taborder = 1
integer textsize = -18
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean autohscroll = false
boolean password = true
integer limit = 4
borderstyle borderstyle = stylelowered!
end type

event modified;CloseWithReturn(parent,compara_nip(il_cuenta,text))
end event

type r_1 from rectangle within w_pregunta_nip
long linecolor = 16711680
integer linethickness = 3
long fillcolor = 255
integer x = 1568
integer y = 276
integer width = 87
integer height = 76
end type

