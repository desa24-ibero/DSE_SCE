$PBExportHeader$uo_periodo.sru
$PBExportComments$Objeto utilizado para desplegar/capturar el año y el periodo.Para realizar la captura del periodo se lee "uo_#%%/((.periodo"Esta variable entrega un int. Para efectuar la captura del  año se realiza mediante  "uo_#%%/((.año" esta variable entrega un l䅄⩔氀
forward
global type uo_periodo from UserObject
end type
type em_año from editmask within uo_periodo
end type
type ddlb_periodo from dropdownlistbox within uo_periodo
end type
type r_1 from rectangle within uo_periodo
end type
end forward

global type uo_periodo from UserObject
int Width=816
int Height=144
boolean Border=true
long BackColor=10789024
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
event keyboard pbm_keydown
em_año em_año
ddlb_periodo ddlb_periodo
r_1 r_1
end type
global uo_periodo uo_periodo

type variables
int periodo
int año
window ventana
int cont = 0
end variables

event keyboard;//La ventana en la que se usará el user object requiere  declarar un evento llamado modifper en el cual se incluirá
//el codigo necesario para ejecutar procesos propios de la ventana, al modificar el periodo y modifaño para el año
//cuando se modifica el año.


if key = KeyEnter! or key = KeyTab!  then
	if ddlb_periodo.text ="Primavera" or upper(ddlb_periodo.text) = "P" then
		ddlb_periodo.text="Primavera"
		periodo = 0
		if cont = 1 then
			em_año.setfocus()
		end if
	elseif ddlb_periodo.text = "Verano" or upper(ddlb_periodo.text) = "V" then
		ddlb_periodo.text="Verano"
		periodo = 1
		if cont = 1 then
			em_año.setfocus()
		end if
	elseif ddlb_periodo.text = "Otoño" or upper(ddlb_periodo.text) = "O" then
		ddlb_periodo.text="Otoño"
		periodo = 2
		if cont = 1 then
			em_año.setfocus()
		end if
	end if
end if
	


ventana.triggerevent("modifper")

	
end event

on uo_periodo.create
this.em_año=create em_año
this.ddlb_periodo=create ddlb_periodo
this.r_1=create r_1
this.Control[]={this.em_año,&
this.ddlb_periodo,&
this.r_1}
end on

on uo_periodo.destroy
destroy(this.em_año)
destroy(this.ddlb_periodo)
destroy(this.r_1)
end on

event constructor;ventana = parent
end event

type em_año from editmask within uo_periodo
int X=534
int Y=29
int Width=249
int Height=96
int TabOrder=20
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="####"
string DisplayData=""
long TextColor=8388608
long BackColor=33554431
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;long loc

loc = long(em_año.text)

if loc < 100 then
	em_año.text = string(1900+loc)
end if

año = long(em_año.text)


ventana.triggerevent("modifaño")

end event

event getfocus;cont = 2
selecttext(1, Len(Text))
end event

type ddlb_periodo from dropdownlistbox within uo_periodo
int X=29
int Y=32
int Width=490
int Height=438
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
boolean VScrollBar=true
boolean AllowEdit=true
long TextColor=16711680
long BackColor=15793151
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Primavera",&
"Verano",&
"Otoño"}
end type

event losefocus;if ddlb_periodo.text ="Primavera" or upper(ddlb_periodo.text) = "P" then
	ddlb_periodo.text="Primavera"
	periodo = 0
	em_año.setfocus()
elseif ddlb_periodo.text = "Verano" or upper(ddlb_periodo.text) = "V" then
	ddlb_periodo.text="Verano"
	periodo = 1
	em_año.setfocus()
elseif ddlb_periodo.text = "Otoño" or upper(ddlb_periodo.text) = "O" then
	ddlb_periodo.text="Otoño"
	periodo = 2
	em_año.setfocus()
end if


ventana.triggerevent("modifper")
	
end event

event selectionchanged;//uo_periodo.triggerevent("keyboard")
end event

event getfocus;cont = 1
end event

type r_1 from rectangle within uo_periodo
int X=11
int Y=13
int Width=779
int Height=138
boolean Enabled=false
int LineThickness=6
long LineColor=16777215
long FillColor=10789024
end type

