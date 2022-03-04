$PBExportHeader$w_folio_ceneval.srw
$PBExportComments$Ventana que pide el folio del alumno. Lo da el Ceneval en su solicitud.
forward
global type w_folio_ceneval from Window
end type
type em_1 from editmask within w_folio_ceneval
end type
type st_1 from statictext within w_folio_ceneval
end type
end forward

global type w_folio_ceneval from Window
int X=1134
int Y=941
int Width=1236
int Height=330
boolean TitleBar=true
WindowType WindowType=response!
em_1 em_1
st_1 st_1
end type
global w_folio_ceneval w_folio_ceneval

on w_folio_ceneval.create
this.em_1=create em_1
this.st_1=create st_1
this.Control[]={this.em_1,&
this.st_1}
end on

on w_folio_ceneval.destroy
destroy(this.em_1)
destroy(this.st_1)
end on

type em_1 from editmask within w_folio_ceneval
int X=494
int Y=118
int Width=241
int Height=102
int TabOrder=1
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="######"
string DisplayData=""
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;long fol_1,fol_2
						
fol_1=long(text)
						
	SELECT aspiran.folio
	INTO :fol_2
	FROM aspiran
	WHERE (aspiran.folio = :fol_1) AND
			(aspiran.clv_ver = :gi_version) AND
			(aspiran.clv_per = :gi_periodo) AND
			(aspiran.anio = :gi_anio)
	USING gtr_sadm;
	if isnull(fol_2) then
		fol_2=1
	end if

	if (fol_1<>fol_2)and(fol_1>1) then
		tit1=text
		close(parent)
	else
		messagebox("Ese folio ya existe","Favor de Verificarlo")
	end if
end event

type st_1 from statictext within w_folio_ceneval
int X=66
int Y=22
int Width=1101
int Height=77
boolean Enabled=false
string Text="Dame el Folio de la Solicitud del Ceneval"
boolean FocusRectangle=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

