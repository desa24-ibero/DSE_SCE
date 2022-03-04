$PBExportHeader$w_historico_2013.srw
$PBExportComments$Esta ventana es de consulta se despliega todas las materias anteriores incritas,calificacion,periodo,anio etc. de la tabla de historico. Juan Campos Nov-1996
forward
global type w_historico_2013 from w_master_main
end type
type uo_nombre from uo_carreras_alumno_lista within w_historico_2013
end type
type em_cuentahist from editmask within w_historico_2013
end type
type dw_historico_rep from uo_master_dw within w_historico_2013
end type
type uo_nombre_1 from uo_nombre_alumno_2013 within w_historico_2013
end type
type dw_historico from uo_master_dw within w_historico_2013
end type
end forward

global type w_historico_2013 from w_master_main
integer width = 3762
integer height = 2708
string title = "Historia Académica"
string menuname = "m_historico_2013"
event ue_sort1 ( )
event ue_sort2 ( )
event ue_consulta1 ( )
event ue_consulta2 ( )
event ue_consulta3 ( )
event ue_consulta4 ( )
event ue_consulta5 ( )
event ue_consulta6 ( )
uo_nombre uo_nombre
em_cuentahist em_cuentahist
dw_historico_rep dw_historico_rep
uo_nombre_1 uo_nombre_1
dw_historico dw_historico
end type
global w_historico_2013 w_historico_2013

type variables
long il_carrera
end variables

event ue_sort1();// Fija el orden con el cual apareceran los datos en el dw_historico
// Juan campos Nov-1997.

dw_historico.SetSort("Historico_cve_mat")
dw_historico_rep.SetSort("Historico_cve_mat")

if uo_nombre.em_cuenta.text <> '' then
	TriggerEvent(DoubleClicked!) 
	m_historico_2013.m_elijaunorden.m_por_clave.Checked = True
	m_historico_2013.m_elijaunorden.m_por_periodo.Checked = False
end if

end event

event ue_sort2();// Fija el orden con el cual apareceran los datos en el dw_historico
// Juan campos Nov-1997.

dw_historico.SetSort("Historico_anio,historico_periodo")
dw_historico_rep.SetSort("Historico_anio,historico_periodo")

if uo_nombre.em_cuenta.text <> '' then
	TriggerEvent(DoubleClicked!) 
	m_historico_2013.m_elijaunorden.m_por_clave.Checked = False
	m_historico_2013.m_elijaunorden.m_por_periodo.Checked = True
end if
end event

event ue_consulta1();// Se envian los parametros de numero de cuenta y las calificaciones a el dw_historico 
// con las cuales se hace la busqueda de los datos .
// Juan Campos Nov-1996.
long  ll_cuenta

ll_cuenta = long(uo_nombre.of_obten_cuenta())

m_historico_2013.m_tipodeconsulta.m_acreditadas.Checked = false
m_historico_2013.m_tipodeconsulta.m_bajas.Checked = false
m_historico_2013.m_tipodeconsulta.m_historico1.Checked = True
m_historico_2013.m_tipodeconsulta.m_incompletas.Checked = false
m_historico_2013.m_tipodeconsulta.m_reprobadas.Checked = false
m_historico_2013.m_tipodeconsulta.m_revalidadas.Checked = false

if dw_historico.retrieve(ll_cuenta,"5","9","10","AC","NA","RE","IN","BA","BJ","E","B","MB","S",il_carrera) = 0 then
  MessageBox("Aviso","No se encontró información con esta cuenta")
else
	dw_historico_rep.retrieve(ll_cuenta,"5","9","10","AC","NA","RE","IN","BA","BJ","E","B","MB","S",il_carrera)
end if  

end event

event ue_consulta2();long  ll_cuenta

ll_cuenta = long(uo_nombre.of_obten_cuenta())

m_historico_2013.m_tipodeconsulta.m_acreditadas.Checked = false
m_historico_2013.m_tipodeconsulta.m_bajas.Checked = false
m_historico_2013.m_tipodeconsulta.m_historico1.Checked = false
m_historico_2013.m_tipodeconsulta.m_incompletas.Checked = false
m_historico_2013.m_tipodeconsulta.m_reprobadas.Checked = true
m_historico_2013.m_tipodeconsulta.m_revalidadas.Checked = false

if dw_historico.retrieve(ll_cuenta,"5","5","NA","BA","BJ","+","+","+","+","+","+","+","+",il_carrera) = 0 then
  MessageBox("Aviso","No se encontró información de materias reprobadas")
else
	dw_historico_rep.retrieve(ll_cuenta,"5","5","NA","BA","BJ","+","+","+","+","+","+","+","+",il_carrera) 
end if  
end event

event ue_consulta3();long  ll_cuenta

ll_cuenta = long(uo_nombre.of_obten_cuenta())

m_historico_2013.m_tipodeconsulta.m_acreditadas.Checked = false
m_historico_2013.m_tipodeconsulta.m_bajas.Checked = false
m_historico_2013.m_tipodeconsulta.m_historico1.Checked = false
m_historico_2013.m_tipodeconsulta.m_incompletas.Checked = false
m_historico_2013.m_tipodeconsulta.m_reprobadas.Checked = false
m_historico_2013.m_tipodeconsulta.m_revalidadas.Checked = true

if dw_historico.retrieve(ll_cuenta,"RE","RE","+","+","+","+","+","+","+","+","+","+","+",il_carrera) = 0 then
  MessageBox("Aviso","No se encontró información de materias revalidadas")
else
	dw_historico_rep.retrieve(ll_cuenta,"RE","RE","+","+","+","+","+","+","+","+","+","+","+",il_carrera)
end if  
end event

event ue_consulta4();long  ll_cuenta

ll_cuenta = long(uo_nombre.of_obten_cuenta())

m_historico_2013.m_tipodeconsulta.m_acreditadas.Checked = false
m_historico_2013.m_tipodeconsulta.m_bajas.Checked = false
m_historico_2013.m_tipodeconsulta.m_historico1.Checked = false
m_historico_2013.m_tipodeconsulta.m_incompletas.Checked = true
m_historico_2013.m_tipodeconsulta.m_reprobadas.Checked = false
m_historico_2013.m_tipodeconsulta.m_revalidadas.Checked = false

if dw_historico.retrieve(ll_cuenta,"IN","IN","+","+","+","+","+","+","+","+","+","+","+",il_carrera) = 0 then
  MessageBox("Aviso","No se encontró información de materias incompletas")
else
	dw_historico_rep.retrieve(ll_cuenta,"IN","IN","+","+","+","+","+","+","+","+","+","+","+",il_carrera)
end if  
end event

event ue_consulta5();long  ll_cuenta

ll_cuenta = long(uo_nombre.of_obten_cuenta())

m_historico_2013.m_tipodeconsulta.m_acreditadas.Checked = true
m_historico_2013.m_tipodeconsulta.m_bajas.Checked = false
m_historico_2013.m_tipodeconsulta.m_historico1.Checked = false
m_historico_2013.m_tipodeconsulta.m_incompletas.Checked = false
m_historico_2013.m_tipodeconsulta.m_reprobadas.Checked = false
m_historico_2013.m_tipodeconsulta.m_revalidadas.Checked = false

if dw_historico.retrieve(ll_cuenta,"6","9","10","AC","E","MB","B","S","+","+","+","+","+",il_carrera) = 0 then
  MessageBox("Aviso","No se encontró información de materias acreditadas")
else
	dw_historico_rep.retrieve(ll_cuenta,"6","9","10","AC","E","MB","B","S","+","+","+","+","+",il_carrera)
end if  
end event

event ue_consulta6();long  ll_cuenta

ll_cuenta = long(uo_nombre.of_obten_cuenta())

m_historico_2013.m_tipodeconsulta.m_acreditadas.Checked = false
m_historico_2013.m_tipodeconsulta.m_bajas.Checked = true
m_historico_2013.m_tipodeconsulta.m_historico1.Checked = false
m_historico_2013.m_tipodeconsulta.m_incompletas.Checked = false
m_historico_2013.m_tipodeconsulta.m_reprobadas.Checked = false
m_historico_2013.m_tipodeconsulta.m_revalidadas.Checked = false

if dw_historico.retrieve(ll_cuenta,"BA","BA","BJ","+","+","+","+","+","+","+","+","+","+",il_carrera) = 0 then
  MessageBox("Aviso","No se encontró información de materias de Baja")
else
	dw_historico_rep.retrieve(ll_cuenta,"BA","BA","BJ","+","+","+","+","+","+","+","+","+","+",il_carrera)
end if  
end event

on w_historico_2013.create
int iCurrent
call super::create
if this.MenuName = "m_historico_2013" then this.MenuID = create m_historico_2013
this.uo_nombre=create uo_nombre
this.em_cuentahist=create em_cuentahist
this.dw_historico_rep=create dw_historico_rep
this.uo_nombre_1=create uo_nombre_1
this.dw_historico=create dw_historico
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_nombre
this.Control[iCurrent+2]=this.em_cuentahist
this.Control[iCurrent+3]=this.dw_historico_rep
this.Control[iCurrent+4]=this.uo_nombre_1
this.Control[iCurrent+5]=this.dw_historico
end on

on w_historico_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nombre)
destroy(this.em_cuentahist)
destroy(this.dw_historico_rep)
destroy(this.uo_nombre_1)
destroy(this.dw_historico)
end on

event closequery;//
end event

event doubleclicked;call super::doubleclicked;//// Juan Campos. Nov-1997.
//
long  ll_cuenta

ll_cuenta = long(uo_nombre.of_obten_cuenta())
il_carrera = uo_nombre.istr_carrera.str_cve_carrera

if il_carrera = 0 then return

if f_alumno_restringido  (ll_cuenta) then
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

m_historico_2013.m_tipodeconsulta.enabled = True
m_historico_2013.m_revision.enabled = true
m_historico_2013.m_elijaunorden.m_por_periodo.Checked = true
m_historico_2013.m_tipodeconsulta.m_acreditadas.Checked = false
m_historico_2013.m_tipodeconsulta.m_bajas.Checked = false
m_historico_2013.m_tipodeconsulta.m_historico1.Checked = True
m_historico_2013.m_tipodeconsulta.m_incompletas.Checked = false
m_historico_2013.m_tipodeconsulta.m_reprobadas.Checked = false
m_historico_2013.m_tipodeconsulta.m_revalidadas.Checked = false

em_cuentahist.text=string(ll_cuenta)

if dw_historico.retrieve(ll_cuenta,"5","9","10","AC","NA","RE","IN","BA","BJ","E","MB","B","S",il_carrera) = 0 then
  MessageBox("Aviso","No se encontró información con esta cuenta")
  return
Else
  dw_historico_rep.retrieve(ll_cuenta,"5","9","10","AC","NA","RE","IN","BA","BJ","E","MB","B","S",il_carrera)  
end if  
 

end event

event open;call super::open;dw_historico.settransobject(gtr_sce)
dw_historico_rep.settransobject(gtr_sce)

uo_nombre.em_cuenta.text = " "

triggerevent(doubleclicked!)
/**/gnv_app.inv_security.of_SetSecurity(this)

end event

event ue_imprime;call super::ue_imprime;long  ll_cuenta

ll_cuenta = long(uo_nombre.of_obten_cuenta())

If dw_historico_rep.retrieve(ll_cuenta,"5","9","10","AC","NA","RE","IN","BA","BJ","E","MB","B","S",il_carrera)  = 0 Then
  Messagebox("No hay datos para imprimir","",StopSign!)	
Else
	dw_historico_rep.modify("Datawindow.print.preview = Yes")
	SetPointer(HourGlass!)
	openwithparm(conf_impr,dw_historico_rep)
	dw_historico_rep.modify("Datawindow.print.preview = No")
End if
end event

event activate;call super::activate;control_escolar.toolbarsheettitle="Historia Académica"
end event

type st_sistema from w_master_main`st_sistema within w_historico_2013
end type

type p_ibero from w_master_main`p_ibero within w_historico_2013
end type

type uo_nombre from uo_carreras_alumno_lista within w_historico_2013
integer x = 37
integer y = 296
integer width = 3241
integer height = 512
integer taborder = 40
end type

on uo_nombre.destroy
call uo_carreras_alumno_lista::destroy
end on

event constructor;call super::constructor;m_historico_2013.objeto = this
end event

type em_cuentahist from editmask within w_historico_2013
boolean visible = false
integer x = 3369
integer y = 148
integer width = 219
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type dw_historico_rep from uo_master_dw within w_historico_2013
integer x = 46
integer y = 1788
integer width = 3529
integer height = 660
integer taborder = 30
string dataobject = "dw_historico_rep2_2013"
boolean hscrollbar = false
boolean vscrollbar = false
boolean resizable = true
end type

event clicked;call super::clicked;idw_trabajo = this
m_historico_2013.dw = this
end event

type uo_nombre_1 from uo_nombre_alumno_2013 within w_historico_2013
boolean visible = false
integer x = 3314
integer y = 16
integer width = 288
integer taborder = 10
end type

on uo_nombre_1.destroy
call uo_nombre_alumno_2013::destroy
end on

event constructor;call super::constructor;m_historico_2013.objeto = this
end event

event anterior;Long cuenta
Char digito

Setpointer(hourglass!) 
  
uo_nombre.cbx_nuevo.checked = False

//Cuenta = long(Mid(w_historico.uo_nombre.em_cuenta.text,1,Len(w_historico.uo_nombre.em_cuenta.text)-1))
Cuenta =long( em_cuentahist.text)

If uo_nombre.em_cuenta.text <> "" Then     
	SELECT max(cuenta)  
	INTO :cuenta  
	FROM historico 
	WHERE cuenta < :cuenta using gtr_sce;

	if Not isnull(cuenta)  then	
		uo_nombre.em_cuenta.text = string(cuenta)		 
		em_cuentahist.text = String(Cuenta)
 		uo_nombre.em_cuenta.text = string(cuenta) + obten_digito(cuenta)		 
		uo_nombre.em_cuenta.triggerevent("activarbusq")
	else
		Messagebox("Información","Este es el primer alumno")
	end if	
Else
	MessageBox("Aviso","No hay un número de cuenta preestablecido")
End If
end event

event primero;long cuenta

setpointer(hourglass!) 
  
uo_nombre.cbx_nuevo.checked = False
 
SELECT min(cuenta)  
INTO :cuenta  
FROM historico where cuenta <> 0 using gtr_sce;

if gtr_sce.sqlcode <> 100 then
	uo_nombre.em_cuenta.text = string(cuenta)		 
	em_cuentahist.text = String(Cuenta)
 	uo_nombre.em_cuenta.text = string(cuenta) + obten_digito(cuenta)		 
	uo_nombre.em_cuenta.triggerevent("activarbusq")
end if	
end event

event siguente;Long 		Cuenta
Char 		Digito

SetPointer(HourGlass!) 
  
uo_nombre.cbx_nuevo.checked = False

//Cuenta = long(Mid(w_historico.uo_nombre.em_cuenta.text,1,Len(w_historico.uo_nombre.em_cuenta.text)-1))
Cuenta =long( em_cuentahist.text)
 
If uo_nombre.em_cuenta.text <> "" Then   
 
SELECT min(cuenta)  
INTO :cuenta  
FROM historico 
WHERE cuenta > :cuenta using gtr_sce;

if Not isnull(cuenta)  then
	uo_nombre.em_cuenta.text = string(cuenta)
	em_cuentahist.text = String(Cuenta)
	uo_nombre.em_cuenta.text = string(cuenta) + obten_digito(cuenta)		  
	uo_nombre.em_cuenta.triggerevent("activarbusq")
else
	Messagebox("Información","Este es el último alumno")
end if	

Else
  MessageBox("Aviso","No hay un número de cuenta en la ventana")
End If

end event

event ultimo;long cuenta
char digito

setpointer(hourglass!) 
  
uo_nombre.cbx_nuevo.checked = False
 
SELECT max(cuenta)  
INTO :cuenta  
FROM historico using gtr_sce;
  
if gtr_sce.sqlcode <> 100 then	
	uo_nombre.em_cuenta.text = string(cuenta)		 
	em_cuentahist.text = String(Cuenta)
	uo_nombre.em_cuenta.text = string(cuenta) + obten_digito(cuenta)		 
	uo_nombre.em_cuenta.triggerevent("activarbusq")
End if	


end event

type dw_historico from uo_master_dw within w_historico_2013
integer x = 46
integer y = 820
integer width = 3529
integer height = 960
integer taborder = 0
string dataobject = "dw_historico_2013"
boolean hscrollbar = false
boolean resizable = true
end type

event constructor;call super::constructor;idw_trabajo = this
m_historico_2013.dw = this
end event

event clicked;call super::clicked;idw_trabajo = this
m_historico_2013.dw = this
end event

