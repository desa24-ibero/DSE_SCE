$PBExportHeader$w_mueve_disponibles_sdu_dse.srw
forward
global type w_mueve_disponibles_sdu_dse from window
end type
type st_3 from statictext within w_mueve_disponibles_sdu_dse
end type
type em_num_salones from editmask within w_mueve_disponibles_sdu_dse
end type
type cb_1 from commandbutton within w_mueve_disponibles_sdu_dse
end type
type st_1 from statictext within w_mueve_disponibles_sdu_dse
end type
type st_2 from statictext within w_mueve_disponibles_sdu_dse
end type
end forward

global type w_mueve_disponibles_sdu_dse from window
integer x = 832
integer y = 364
integer width = 3369
integer height = 1556
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 10789024
st_3 st_3
em_num_salones em_num_salones
cb_1 cb_1
st_1 st_1
st_2 st_2
end type
global w_mueve_disponibles_sdu_dse w_mueve_disponibles_sdu_dse

event open; 

st_2.text = &
"Esté proceso actualiza la tabla de  SALONES_DERECHO_USO,  en el campo de " + &
"derecho con el valor del campo ocupados de "	+ &
"todos los departamentos en todas las horas de inicio. Por lo cual ya no sera "	+ &
"posible dar de alta grupos nuevos desde la aplicación de los departamentos. La "	+ &
"diferencia entre los ocupados y derecho sera los disponibles que se "		+ &
"actualizaran en el departamento 7300 (Servicios escolares) y en la hora y cupo "	+ &
"que le corresponda."

end event

on w_mueve_disponibles_sdu_dse.create
this.st_3=create st_3
this.em_num_salones=create em_num_salones
this.cb_1=create cb_1
this.st_1=create st_1
this.st_2=create st_2
this.Control[]={this.st_3,&
this.em_num_salones,&
this.cb_1,&
this.st_1,&
this.st_2}
end on

on w_mueve_disponibles_sdu_dse.destroy
destroy(this.st_3)
destroy(this.em_num_salones)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.st_2)
end on

type st_3 from statictext within w_mueve_disponibles_sdu_dse
integer x = 978
integer y = 228
integer width = 658
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
string text = "Número de Salones :"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_num_salones from editmask within w_mueve_disponibles_sdu_dse
integer x = 1710
integer y = 212
integer width = 402
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "200"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##0"
end type

type cb_1 from commandbutton within w_mueve_disponibles_sdu_dse
integer x = 1115
integer y = 932
integer width = 1138
integer height = 108
integer taborder = 1
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mueve Disponibles a Servicios Escolares"
end type

event clicked;// Juan Campos Sánchez.
//	Fantine Medina.							Diciembre-1997.
// Antonio Pica 								Noviembre 2004

string ls_num_salones
integer li_num_salones
ls_num_salones= em_num_salones.text

if not isnumber(ls_num_salones)then
	Messagebox("Número de Salones Incorrecto","Favor de escribir un Número de Salones válido",Stopsign!) 
	return	
else
	li_num_salones = integer(ls_num_salones)
	if li_num_salones<=0 then
		Messagebox("Número de Salones Incorrecto","Favor de escribir un Número de Salones mayor",Stopsign!) 
		return			
	end if
end if


IF Messagebox("Movimiento de disponibles a Servicios Escolares","Desea Continuar",Question!,YesNo!,2) = 1 THEN
	Setpointer(hourglass!)
	DELETE FROM salones_derecho_uso WHERE cve_coordinacion = 7300 using gtr_sce;
	
	INSERT INTO salones_derecho_uso
	SELECT 7300, cve_dia, hora_inicio, 0, :li_num_salones - SUM(ocupados), 0
	FROM salones_derecho_uso
	GROUP BY  cve_dia, hora_inicio using gtr_sce;

	UPDATE salones_derecho_uso set derecho = ocupados WHERE cve_coordinacion <> 7300 using gtr_sce;
	commit using gtr_sce;
  	Messagebox("Proceso Terminado","")
END IF
end event

type st_1 from statictext within w_mueve_disponibles_sdu_dse
integer x = 667
integer y = 92
integer width = 2034
integer height = 96
integer textsize = -14
integer weight = 700
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
long textcolor = 16776960
long backcolor = 29064704
boolean enabled = false
string text = "PROCESO DELICADO.   TOMA PRECAUCIONES."
alignment alignment = center!
boolean border = true
long bordercolor = 16777215
boolean focusrectangle = false
end type

type st_2 from statictext within w_mueve_disponibles_sdu_dse
integer x = 178
integer y = 324
integer width = 2834
integer height = 468
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
long textcolor = 15793151
long backcolor = 29064704
boolean enabled = false
alignment alignment = center!
boolean border = true
long bordercolor = 16777215
end type

