$PBExportHeader$uo_nombre_alumno_sparl.sru
forward
global type uo_nombre_alumno_sparl from userobject
end type
type r_1 from rectangle within uo_nombre_alumno_sparl
end type
type em_digito from editmask within uo_nombre_alumno_sparl
end type
type st_2 from statictext within uo_nombre_alumno_sparl
end type
type st_1 from statictext within uo_nombre_alumno_sparl
end type
type r_2 from rectangle within uo_nombre_alumno_sparl
end type
type dw_nombre_alumno from datawindow within uo_nombre_alumno_sparl
end type
type em_cuenta from editmask within uo_nombre_alumno_sparl
end type
end forward

global type uo_nombre_alumno_sparl from userobject
integer width = 3246
integer height = 412
boolean enabled = false
long backcolor = 10789024
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
global uo_nombre_alumno_sparl uo_nombre_alumno_sparl

type variables
window ventana
menu menu

end variables

on uo_nombre_alumno_sparl.create
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

on uo_nombre_alumno_sparl.destroy
destroy(this.r_1)
destroy(this.em_digito)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.r_2)
destroy(this.dw_nombre_alumno)
destroy(this.em_cuenta)
end on

event constructor;dw_nombre_alumno.settransobject(gtr_sce)
dw_nombre_alumno.insertrow(0)
ventana = parent

end event

type r_1 from rectangle within uo_nombre_alumno_sparl
long linecolor = 15793151
integer linethickness = 4
long fillcolor = 10789024
integer x = 27
integer y = 8
integer width = 3205
integer height = 392
end type

type em_digito from editmask within uo_nombre_alumno_sparl
integer x = 827
integer y = 28
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

type st_2 from statictext within uo_nombre_alumno_sparl
integer x = 786
integer y = 28
integer width = 41
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_1 from statictext within uo_nombre_alumno_sparl
integer x = 46
integer y = 28
integer width = 471
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

type r_2 from rectangle within uo_nombre_alumno_sparl
integer linethickness = 4
long fillcolor = 15780518
integer x = 535
integer y = 24
integer width = 361
integer height = 88
end type

type dw_nombre_alumno from datawindow within uo_nombre_alumno_sparl
integer x = 32
integer y = 140
integer width = 3186
integer height = 256
string dataobject = "dw_nombre_alumno"
boolean border = false
end type

type em_cuenta from editmask within uo_nombre_alumno_sparl
event activarbusq ( )
integer x = 539
integer y = 28
integer width = 247
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

event activarbusq(); int cont
long cuenta
char digito,dig
STRING ls_tipo_periodo

	cuenta = long(mid(em_cuenta.text,1,len(em_cuenta.text) - 1))
	if cuenta > 1 then
		
//		// Se agrega validación para determinar si el alumno se encuentra en el tipo de periodo activo.
//		SELECT ple.tipo_periodo 
//		INTO :ls_tipo_periodo 
//		FROM plan_estudios ple, academicos aca 
//		WHERE aca.cuenta = :cuenta
//		AND aca.cve_carrera = ple.cve_carrera
//		AND aca.cve_plan = ple.cve_plan
//		USING gtr_sce;
//		IF gtr_sce.SQLCODE < 0 THEN 
//			MESSAGEBOX("Error", "Se produjo un error al recuperar el tipo de periodo del plan de estudios del alumno: " + gtr_sce.SQLERRTEXT )
//			RETURN 
//		END IF
//		IF ls_tipo_periodo <> gs_tipo_periodo THEN 
//			MESSAGEBOX("Error", "Este alumno no se encuentra inscrito en plan " + gs_descripcion_tipo_periodo)
//			em_cuenta.text = ""
//			RETURN 
//		END IF
		
		em_digito.text = upper(mid(em_cuenta.text,len(em_cuenta.text),1))
		em_cuenta.text = string(cuenta)
		dw_nombre_alumno.retrieve(cuenta)
		ventana.triggerevent("inicia_proceso")
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

