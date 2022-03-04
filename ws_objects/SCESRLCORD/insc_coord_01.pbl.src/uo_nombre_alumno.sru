$PBExportHeader$uo_nombre_alumno.sru
$PBExportComments$Objeto que busca al alumno por No. de Cta., por nombre o por apellidos, o efectuando una revisión en la tabla de alumnos
forward
global type uo_nombre_alumno from userobject
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

global type uo_nombre_alumno from userobject
integer width = 3250
integer height = 416
boolean enabled = false
long backcolor = 31641519
long tabtextcolor = 41943040
long tabbackcolor = 80793808
long picturemaskcolor = 553648127
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
long linecolor = 15793151
integer linethickness = 3
long fillcolor = 31641519
integer x = 27
integer y = 12
integer width = 3205
integer height = 396
end type

type em_digito from editmask within uo_nombre_alumno
integer x = 832
integer y = 32
integer width = 64
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
boolean border = false
maskdatatype maskdatatype = stringmask!
string mask = "!!"
string displaydata = ""
end type

event modified;//em_cuenta.triggerevent(losefocus!)
end event

type st_2 from statictext within uo_nombre_alumno
integer x = 791
integer y = 32
integer width = 50
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = " -"
boolean focusrectangle = false
end type

type st_1 from statictext within uo_nombre_alumno
integer x = 50
integer y = 28
integer width = 434
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "No. de Cuenta"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type r_2 from rectangle within uo_nombre_alumno
integer linethickness = 3
long fillcolor = 15780518
integer x = 503
integer y = 28
integer width = 398
integer height = 92
end type

type dw_nombre_alumno from datawindow within uo_nombre_alumno
integer x = 32
integer y = 140
integer width = 3186
integer height = 256
string dataobject = "dw_nombre_alumno"
boolean border = false
end type

type em_cuenta from editmask within uo_nombre_alumno
event activarbusq ( )
integer x = 507
integer y = 32
integer width = 283
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean border = false
alignment alignment = right!
maskdatatype maskdatatype = stringmask!
string mask = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
string displaydata = ""
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

