$PBExportHeader$w_pregunta_nip.srw
forward
global type w_pregunta_nip from Window
end type
type p_1 from picture within w_pregunta_nip
end type
type st_nip from statictext within w_pregunta_nip
end type
type st_nombre_alumno from statictext within w_pregunta_nip
end type
type sle_nip from singlelineedit within w_pregunta_nip
end type
end forward

global type w_pregunta_nip from Window
int X=1075
int Y=483
int Width=1682
int Height=451
boolean TitleBar=true
string Title="Escribir nip"
long BackColor=0
WindowType WindowType=response!
p_1 p_1
st_nip st_nip
st_nombre_alumno st_nombre_alumno
sle_nip sle_nip
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
int li_res, li_ret, li_nip_detectado, li_rtn
string ls_nip, ls_nip_plano
ls_nip_plano = as_nip
lds_nips = Create DataStore
lds_nips.DataObject = "d_nips"
lds_nips.SetTransObject(gtr_sce)
li_res = lds_nips.Retrieve(al_cuenta)
choose case li_res
	case 1
		ls_nip = lds_nips.GetItemString(1,"nip2")
		li_nip_detectado= lds_nips.GetItemNumber(1,"nd")
		if isnull(li_nip_detectado) then
			li_nip_detectado=0
		end if
		if ls_nip = as_nip then
			li_ret = 1
			if li_nip_detectado<> 1 then
				lds_nips.SetItem(1,"nd", 1)
				li_rtn= lds_nips.Update()
				IF li_rtn = 1 THEN
//					gtr_sce.SQLNRows > 0
					COMMIT USING gtr_sce;
				ELSE
					ROLLBACK USING gtr_sce;
				END IF
			end if
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
this.Control[]={this.p_1,&
this.st_nip,&
this.st_nombre_alumno,&
this.sle_nip}
end on

on w_pregunta_nip.destroy
destroy(this.p_1)
destroy(this.st_nip)
destroy(this.st_nombre_alumno)
destroy(this.sle_nip)
end on

event open;il_cuenta = long(Mid(Message.StringParm,1,Pos(Message.StringParm,"@")-1))
st_nombre_alumno.text = "Alumno:      "+Mid(Message.StringParm,Pos(Message.StringParm,"@")+1)
end event

type p_1 from picture within w_pregunta_nip
int X=4
int Y=3
int Width=106
int Height=86
string PictureName="uia2.bmp"
boolean FocusRectangle=false
end type

type st_nip from statictext within w_pregunta_nip
int X=37
int Y=211
int Width=216
int Height=77
boolean Enabled=false
string Text="Nip:"
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=0
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_nombre_alumno from statictext within w_pregunta_nip
int X=37
int Y=96
int Width=1580
int Height=77
boolean Enabled=false
string Text="Alumno:      "
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=0
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_nip from singlelineedit within w_pregunta_nip
int X=344
int Y=182
int Width=325
int Height=102
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
int Limit=4
long BackColor=16777215
int TextSize=-18
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;CloseWithReturn(parent,compara_nip(il_cuenta,text))
end event

