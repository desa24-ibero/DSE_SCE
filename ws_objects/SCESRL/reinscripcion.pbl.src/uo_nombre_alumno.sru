$PBExportHeader$uo_nombre_alumno.sru
$PBExportComments$Objeto que busca al alumno por No. de Cta., por nombre o por apellidos, o efectuando una revisión en la tabla de alumnos
forward
global type uo_nombre_alumno from UserObject
end type
type r_1 from rectangle within uo_nombre_alumno
end type
type em_digito from editmask within uo_nombre_alumno
end type
type st_2 from statictext within uo_nombre_alumno
end type
type st_1 from statictext within uo_nombre_alumno
end type
type r_2 from rectangle within uo_nombre_alumno
end type
type dw_nombre_alumno from datawindow within uo_nombre_alumno
end type
type em_cuenta from editmask within uo_nombre_alumno
end type
end forward

global type uo_nombre_alumno from UserObject
int Width=3248
int Height=416
boolean Enabled=false
long BackColor=30976088
long PictureMaskColor=553648127
long TabTextColor=41943040
long TabBackColor=80793808
r_1 r_1
em_digito em_digito
st_2 st_2
st_1 st_1
r_2 r_2
dw_nombre_alumno dw_nombre_alumno
em_cuenta em_cuenta
end type
global uo_nombre_alumno uo_nombre_alumno

type variables
window ventana
menu menu

end variables

on uo_nombre_alumno.create
this.r_1=create r_1
this.em_digito=create em_digito
this.st_2=create st_2
this.st_1=create st_1
this.r_2=create r_2
this.dw_nombre_alumno=create dw_nombre_alumno
this.em_cuenta=create em_cuenta
this.Control[]={this.r_1,&
this.em_digito,&
this.st_2,&
this.st_1,&
this.r_2,&
this.dw_nombre_alumno,&
this.em_cuenta}
end on

on uo_nombre_alumno.destroy
destroy(this.r_1)
destroy(this.em_digito)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.r_2)
destroy(this.dw_nombre_alumno)
destroy(this.em_cuenta)
end on

event constructor;dw_nombre_alumno.settransobject(sqlca)
dw_nombre_alumno.insertrow(0)
ventana = parent

end event

type r_1 from rectangle within uo_nombre_alumno
int X=26
int Y=10
int Width=3204
int Height=394
boolean Enabled=false
int LineThickness=3
long LineColor=15793151
long FillColor=30976088
end type

type em_digito from editmask within uo_nombre_alumno
int X=827
int Y=29
int Width=66
int Height=80
boolean Enabled=false
boolean Border=false
string Mask="!!"
MaskDataType MaskDataType=StringMask!
string DisplayData=""
long BackColor=15793151
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;//em_cuenta.triggerevent(losefocus!)
end event

type st_2 from statictext within uo_nombre_alumno
int X=786
int Y=29
int Width=40
int Height=80
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within uo_nombre_alumno
int X=48
int Y=29
int Width=435
int Height=80
boolean Enabled=false
boolean Border=true
string Text="No. de Cuenta"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type r_2 from rectangle within uo_nombre_alumno
int X=501
int Y=26
int Width=399
int Height=90
boolean Enabled=false
int LineThickness=3
long FillColor=15780518
end type

type dw_nombre_alumno from datawindow within uo_nombre_alumno
int X=33
int Y=141
int Width=3185
int Height=256
string DataObject="dw_nombre_alumno"
boolean Border=false
end type

type em_cuenta from editmask within uo_nombre_alumno
event activarbusq ( )
int X=505
int Y=29
int Width=285
int Height=80
int TabOrder=20
boolean BringToTop=true
Alignment Alignment=Right!
boolean Border=false
string Mask="aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
MaskDataType MaskDataType=StringMask!
string DisplayData=""
long BackColor=15793151
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event activarbusq; int cont
long cuenta
char digito,dig

	cuenta = long(mid(em_cuenta.text,1,len(em_cuenta.text) - 1))
	if cuenta > 1 then
		em_digito.text = upper(mid(em_cuenta.text,len(em_cuenta.text),1))
		em_cuenta.text = string(cuenta)
		 SELECT alumnos.cuenta  
			 INTO :cuenta  
		    FROM alumnos  
	      WHERE alumnos.cuenta = :cuenta   ;
		if sqlca.sqlcode = 100 then
			messagebox("El Alumno no existe","El alumno con clave "+string(cuenta)+" no existe.", StopSign!)
			em_cuenta.text = ""
			em_digito.text=""
			if dw_nombre_alumno.retrieve(0) = 0 then
			  	dw_nombre_alumno.insertrow(0)
			end if
			ventana.triggerevent("inicia_proceso")
			em_cuenta.setfocus()
		else
			if em_digito.text = "" then em_digito.text = "C"
			digito = upper(em_digito.text)
			dig = obten_digito(cuenta)
			if digito = dig then	
				dw_nombre_alumno.retrieve(cuenta)
				ventana.triggerevent("inicia_proceso")
			else
				messagebox("Digito Incorrecto","Revise que el dígito verificador esté correcto",StopSign!)
				em_cuenta.text = ""
				em_digito.text=""
				if dw_nombre_alumno.retrieve(0) = 0 then
			 		dw_nombre_alumno.insertrow(0)
				end if
				ventana.triggerevent("inicia_proceso")
				em_cuenta.setfocus()
			end if	
		end if
	else
		if dw_nombre_alumno.retrieve(0) = 0 then
			dw_nombre_alumno.insertrow(0)
		end if 
		em_cuenta.text = ""
		em_digito.text=""
		ventana.triggerevent("inicia_proceso")
		em_cuenta.setfocus()
	end if

end event

event getfocus;em_cuenta.selecttext(1,len(em_cuenta.text))
end event

event losefocus;if keydown(KeyEnter!) = true then
	triggerevent("activarbusq")	
end if
end event

event modified;if keydown(keyenter!) then	
	dw_nombre_alumno.setfocus()	
end if
end event

