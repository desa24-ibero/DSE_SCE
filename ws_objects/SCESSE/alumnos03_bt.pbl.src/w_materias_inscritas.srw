$PBExportHeader$w_materias_inscritas.srw
$PBExportComments$Esta ventana es de consulta, se despliega las materias inscritas y el horario del periodo actual . Se imprime un comprobante.     Juan Campos Dic-1996.
forward
global type w_materias_inscritas from window
end type
type dw_periodo_mat_inscritas from datawindow within w_materias_inscritas
end type
type cb_salvar from commandbutton within w_materias_inscritas
end type
type uo_1 from uo_per_ani within w_materias_inscritas
end type
type cb_horario from commandbutton within w_materias_inscritas
end type
type em_cuentaaux from editmask within w_materias_inscritas
end type
type dw_imprime_materias_inscritas from datawindow within w_materias_inscritas
end type
type uo_nombre from uo_nombre_alumno within w_materias_inscritas
end type
type cb_asimiladas from commandbutton within w_materias_inscritas
end type
type dw_mat_insc from datawindow within w_materias_inscritas
end type
type rr_1 from roundrectangle within w_materias_inscritas
end type
type dw_materias_inscritas_horario from datawindow within w_materias_inscritas
end type
type dw_hor_asimilados from datawindow within w_materias_inscritas
end type
end forward

global type w_materias_inscritas from window
integer x = 5
integer y = 4
integer width = 4050
integer height = 2236
boolean titlebar = true
string title = "MATERIAS INSCRITAS Y HORARIO"
string menuname = "m_materias_inscritas"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
long backcolor = 27291696
dw_periodo_mat_inscritas dw_periodo_mat_inscritas
cb_salvar cb_salvar
uo_1 uo_1
cb_horario cb_horario
em_cuentaaux em_cuentaaux
dw_imprime_materias_inscritas dw_imprime_materias_inscritas
uo_nombre uo_nombre
cb_asimiladas cb_asimiladas
dw_mat_insc dw_mat_insc
rr_1 rr_1
dw_materias_inscritas_horario dw_materias_inscritas_horario
dw_hor_asimilados dw_hor_asimilados
end type
global w_materias_inscritas w_materias_inscritas

type variables
boolean ib_usuario_especial=false

end variables

on w_materias_inscritas.create
if this.MenuName = "m_materias_inscritas" then this.MenuID = create m_materias_inscritas
this.dw_periodo_mat_inscritas=create dw_periodo_mat_inscritas
this.cb_salvar=create cb_salvar
this.uo_1=create uo_1
this.cb_horario=create cb_horario
this.em_cuentaaux=create em_cuentaaux
this.dw_imprime_materias_inscritas=create dw_imprime_materias_inscritas
this.uo_nombre=create uo_nombre
this.cb_asimiladas=create cb_asimiladas
this.dw_mat_insc=create dw_mat_insc
this.rr_1=create rr_1
this.dw_materias_inscritas_horario=create dw_materias_inscritas_horario
this.dw_hor_asimilados=create dw_hor_asimilados
this.Control[]={this.dw_periodo_mat_inscritas,&
this.cb_salvar,&
this.uo_1,&
this.cb_horario,&
this.em_cuentaaux,&
this.dw_imprime_materias_inscritas,&
this.uo_nombre,&
this.cb_asimiladas,&
this.dw_mat_insc,&
this.rr_1,&
this.dw_materias_inscritas_horario,&
this.dw_hor_asimilados}
end on

on w_materias_inscritas.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_periodo_mat_inscritas)
destroy(this.cb_salvar)
destroy(this.uo_1)
destroy(this.cb_horario)
destroy(this.em_cuentaaux)
destroy(this.dw_imprime_materias_inscritas)
destroy(this.uo_nombre)
destroy(this.cb_asimiladas)
destroy(this.dw_mat_insc)
destroy(this.rr_1)
destroy(this.dw_materias_inscritas_horario)
destroy(this.dw_hor_asimilados)
end on

event doubleclicked;// Juan campos. Enero-1997.

//Integer 	Periodo = 0,Año = 0

//Periodo_Actual(Periodo,Año,sqlca)

long ll_row, ll_cuenta
int  li_baja_laboratorio, li_baja_disciplina
boolean lb_permite_consulta = true
ll_row = uo_nombre.dw_nombre_alumno.GetRow()
ll_cuenta = uo_nombre.dw_nombre_alumno.GetItemNumber(ll_row, "cuenta")

if f_alumno_restringido (ll_cuenta) then
	if f_usuario_especial(gs_usuario) then
		MessageBox("Usuario  Autorizado", &
		"Alumno con acceso restringido",Information!)		
	else
		MessageBox("Usuario NO Autorizado", &
	           "Alumno con acceso restringido, por favor consulte a la ~n"+ &
				 +"Dirección de Servicios Escolares",StopSign!)
		uo_nombre.dw_nombre_alumno.Reset()	
		uo_nombre.dw_nombre_alumno.insertrow(0)
		uo_nombre.em_digito.text=" "
		uo_nombre.em_cuenta.text = " "
		uo_nombre.em_cuenta.setfocus()

		return		
	end if
end if



li_baja_laboratorio = f_obten_baja_laboratorio(ll_cuenta)
li_baja_disciplina = f_obten_baja_disciplina(ll_cuenta)
if li_baja_laboratorio = 1 then
	MessageBox("Adeudo de Laboratorio","El alumno tiene adeudos de material de laboratorio",StopSign!)
	lb_permite_consulta = false			
elseif li_baja_laboratorio = -1 then
	MessageBox("Error en Laboratorio","No es posible consultar la baja por laboratorio",StopSign!)
	lb_permite_consulta = false			
end if
if li_baja_disciplina = 1 then
	MessageBox("Baja por Disciplina","El alumno esta dado de baja por disciplina",StopSign!)
	lb_permite_consulta = false			
elseif li_baja_disciplina = -1 then
	MessageBox("Error en  Disciplina","No es posible consultar la baja por disciplina",StopSign!)
	lb_permite_consulta = false			
end if

IF NOT lb_permite_consulta THEN
		uo_nombre.dw_nombre_alumno.Reset()	
		uo_nombre.dw_nombre_alumno.insertrow(0)
		uo_nombre.em_digito.text=" "
		uo_nombre.em_cuenta.text = " "
		uo_nombre.em_cuenta.setfocus()	
		return
END IF

m_materias_inscritas.m_revision.enabled = true
m_materias_inscritas.m_imprimematerias.enabled = true
	
dw_hor_asimilados.reset()
dw_materias_inscritas_horario.reset()
dw_hor_asimilados.visible = False
dw_hor_asimilados.enabled = False
cb_asimiladas.visible = False
cb_asimiladas.enabled = False
cb_horario.visible = False
cb_horario.enabled = False

em_cuentaaux.text=uo_nombre.em_cuenta.text 

ll_cuenta = long(w_materias_inscritas.uo_nombre.em_cuenta.text)

if dw_mat_insc.Retrieve(ll_cuenta) = 0 then 
	MessageBox("Aviso","No tiene materias inscritas este semestre")
Else
	w_materias_inscritas.dw_materias_inscritas_horario.Retrieve(ll_cuenta)
	dw_materias_inscritas_horario.setfocus()
end if  

dw_periodo_mat_inscritas.Retrieve()
end event

event open;this.x = 1
this.y = 1

w_materias_inscritas.dw_imprime_materias_inscritas.visible = false
w_materias_inscritas.dw_imprime_materias_inscritas.enabled = false 
w_materias_inscritas.dw_materias_inscritas_horario.SetTransObject(gtr_sce)
w_materias_inscritas.dw_mat_insc.SetTransObject(gtr_sce)
w_materias_inscritas.dw_hor_asimilados.SetTransObject(gtr_sce)
dw_periodo_mat_inscritas.SetTransObject(gtr_sce)
cb_asimiladas.visible = False
cb_asimiladas.enabled = False
cb_horario.visible = False
cb_horario.enabled = False
dw_hor_asimilados.visible = False
dw_hor_asimilados.enabled = False

ib_usuario_especial = f_usuario_especial(gs_usuario)

//g_nv_security.fnv_secure_window (this)

end event

type dw_periodo_mat_inscritas from datawindow within w_materias_inscritas
integer x = 1381
integer y = 480
integer width = 800
integer height = 92
integer taborder = 81
string dataobject = "d_periodo_mat_inscritas"
boolean border = false
boolean livescroll = true
end type

type cb_salvar from commandbutton within w_materias_inscritas
integer x = 37
integer y = 1820
integer width = 576
integer height = 108
integer taborder = 71
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salvar"
end type

event clicked;if isvalid(dw_mat_insc) then
	SetPointer(HourGlass!)
	if dw_mat_insc.SaveAs("",Excel!, TRUE)<>1 then
		dw_mat_insc.SaveAs("",Clipboard!, TRUE)
		messagebox("No se pudo guardar el archivo","La información se encuentra en el Clipboard")	
	end if
end if
end event

type uo_1 from uo_per_ani within w_materias_inscritas
boolean visible = false
integer x = 2327
integer y = 1808
integer width = 1253
integer height = 168
integer taborder = 70
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type cb_horario from commandbutton within w_materias_inscritas
integer x = 1609
integer y = 1632
integer width = 722
integer height = 124
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Horario Grupos Normales"
end type

event clicked;dw_materias_inscritas_horario.visible = true
dw_materias_inscritas_horario.enabled = true
end event

type em_cuentaaux from editmask within w_materias_inscritas
boolean visible = false
integer x = 750
integer y = 1708
integer width = 274
integer height = 100
integer taborder = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
end type

type dw_imprime_materias_inscritas from datawindow within w_materias_inscritas
boolean visible = false
integer x = 114
integer y = 1836
integer width = 3515
integer height = 364
integer taborder = 90
string dataobject = "dw_imprime_materias_inscritas"
boolean livescroll = true
borderstyle borderstyle = styleshadowbox!
end type

event constructor;dw_imprime_materias_inscritas.object.fecha.text = Mid(fecha_espaniol_servidor(gtr_sce),1,11)
end event

type uo_nombre from uo_nombre_alumno within w_materias_inscritas
integer x = 178
integer y = 44
integer width = 3241
integer height = 428
integer taborder = 10
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

type cb_asimiladas from commandbutton within w_materias_inscritas
integer x = 791
integer y = 1632
integer width = 763
integer height = 124
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Horario Grupos Asimilados"
end type

event clicked;// Juan campos. Sep-1997.

//Integer 	Periodo = 0,Año = 0

//Periodo_Actual(Periodo,Año,sqlca)
 long ll_cuenta
 ll_cuenta = long(w_materias_inscritas.uo_nombre.em_cuenta.text)
if w_materias_inscritas.dw_hor_asimilados.Retrieve(ll_cuenta) > 0 then
	dw_hor_asimilados.visible = True
	dw_hor_asimilados.enabled = True
	cb_horario.visible= True
	cb_horario.enabled = True
else 
	dw_hor_asimilados.visible = False
	dw_hor_asimilados.enabled = False
	cb_horario.visible= False
	cb_horario.enabled = False
end if
 
 

end event

type dw_mat_insc from datawindow within w_materias_inscritas
integer x = 23
integer y = 600
integer width = 2505
integer height = 1008
integer taborder = 30
string dataobject = "dw_mat_insc"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event retrieveend;// Juan Campos.      Sep-1997.

Integer	Contador
Boolean	Asimilados = False
	
FOR Contador = 1 to RowCount()
	SetRow(Contador)
	if	GetItemNumber(Contador,"grupos_tipo") = 2 Then
		Asimilados = True
	end if
NEXT

if Asimilados Then 
	cb_asimiladas.visible = True
	cb_asimiladas.enabled = True
else
	cb_asimiladas.visible = False
	cb_asimiladas.enabled = False
	cb_horario.visible = False
	cb_horario.enabled = False
end if


end event

type rr_1 from roundrectangle within w_materias_inscritas
long linecolor = 16777215
integer linethickness = 3
long fillcolor = 10789024
integer x = 18
integer y = 576
integer width = 3808
integer height = 1196
integer cornerheight = 42
integer cornerwidth = 40
end type

type dw_materias_inscritas_horario from datawindow within w_materias_inscritas
integer x = 2496
integer y = 600
integer width = 1303
integer height = 1136
integer taborder = 20
string dataobject = "dw_materias_inscritas_horario"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;// Juan Campos. Marzo-1997.

IF dw_materias_inscritas_horario.GetRow() > 0 THEN 
	dw_materias_inscritas_horario.SetRow(dw_materias_inscritas_horario.GetRow())
	dw_materias_inscritas_horario.ScrollToRow(dw_materias_inscritas_horario.GetRow())  
	dw_materias_inscritas_horario.SetRowFocusIndicator(Hand!)    
END IF 

end event

event rowfocuschanged;// Juan Campos. Marzo-1997.

IF dw_materias_inscritas_horario.GetRow() > 0 THEN 
	dw_materias_inscritas_horario.SetRow(dw_materias_inscritas_horario.GetRow())
	dw_materias_inscritas_horario.ScrollToRow(dw_materias_inscritas_horario.GetRow())  
	dw_materias_inscritas_horario.SetRowFocusIndicator(Hand!)    
END IF 

end event

type dw_hor_asimilados from datawindow within w_materias_inscritas
integer x = 2501
integer y = 704
integer width = 1102
integer height = 1004
integer taborder = 40
string dataobject = "dw_hor_asimilados"
boolean livescroll = true
end type

event rowfocuschanged;IF GetRow() > 0 THEN 
	SetRow(GetRow())
	ScrollToRow(GetRow())  
	SetRowFocusIndicator(Hand!)    
END IF 

end event

