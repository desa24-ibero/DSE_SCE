$PBExportHeader$w_folio.srw
$PBExportComments$Capura de folios en ventanilla
forward
global type w_folio from w_ancestral
end type
type st_1 from statictext within w_folio
end type
type em_1 from editmask within w_folio
end type
end forward

global type w_folio from w_ancestral
int X=997
int Y=964
int Width=1568
int Height=500
WindowType WindowType=response!
boolean TitleBar=true
string Title="Folio"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
st_1 st_1
em_1 em_1
end type
global w_folio w_folio

on w_folio.create
int iCurrent
call super::create
this.st_1=create st_1
this.em_1=create em_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.em_1
end on

on w_folio.destroy
call super::destroy
destroy(this.st_1)
destroy(this.em_1)
end on

event open;/*
DESCRIPCIÓN: No agregues seguridad, ni pongas la ventana en la esquina.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 18 Junio 1998
MODIFICACIÓN:
*/

end event

type st_1 from statictext within w_folio
int X=379
int Y=112
int Width=1184
int Height=76
boolean Enabled=false
string Text="Dame el Folio de la Solicitud de Preinscripción"
boolean FocusRectangle=false
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_1 from editmask within w_folio
event modified pbm_enmodified
int X=850
int Y=212
int Width=242
int Height=100
int TabOrder=1
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="######"
string DisplayData=""
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;/*
DESCRIPCIÓN: Verifica que el folio que se cargue no exista.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/

long ll_fol_1,ll_fol_2

ll_fol_1=long(text)

if ll_fol_1=0 then
	close(parent)
	return
end if

if ll_fol_1>=100000 then
	messagebox("El folio no debe ser mayor","a 100,000")
	return
end if

SELECT preinsc.folio
INTO :ll_fol_2
FROM preinsc
WHERE folio = :ll_fol_1 and periodo = :gi_periodo and anio = :gi_anio
USING gtr_sce;

if isnull(ll_fol_2) then
	ll_fol_2=0
end if

if (ll_fol_1<>ll_fol_2) then
	CloseWithReturn ( parent, text)
else
	CloseWithReturn ( parent, "0")
	messagebox("Ese folio ya existe","Favor de Verfificarlo")
end if
end event

