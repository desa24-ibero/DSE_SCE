$PBExportHeader$w_asigna_hora_inscripcion_pi.srw
forward
global type w_asigna_hora_inscripcion_pi from window
end type
type cb_establece_folio_sol from commandbutton within w_asigna_hora_inscripcion_pi
end type
type p_1 from picture within w_asigna_hora_inscripcion_pi
end type
type rb_ingreso from radiobutton within w_asigna_hora_inscripcion_pi
end type
type st_porc3 from statictext within w_asigna_hora_inscripcion_pi
end type
type st_porc2 from statictext within w_asigna_hora_inscripcion_pi
end type
type st_porc1 from statictext within w_asigna_hora_inscripcion_pi
end type
type em_susceptibles from editmask within w_asigna_hora_inscripcion_pi
end type
type cb_susceptibles from commandbutton within w_asigna_hora_inscripcion_pi
end type
type em_cuenta_registros from editmask within w_asigna_hora_inscripcion_pi
end type
type uo_1 from uo_per_ani within w_asigna_hora_inscripcion_pi
end type
type cb_contar from commandbutton within w_asigna_hora_inscripcion_pi
end type
type cb_1 from commandbutton within w_asigna_hora_inscripcion_pi
end type
type rb_todos from radiobutton within w_asigna_hora_inscripcion_pi
end type
type rb_no_preinscritos from radiobutton within w_asigna_hora_inscripcion_pi
end type
type rb_preinscritos from radiobutton within w_asigna_hora_inscripcion_pi
end type
type rb_posgrado from radiobutton within w_asigna_hora_inscripcion_pi
end type
type rb_licenciatura from radiobutton within w_asigna_hora_inscripcion_pi
end type
type st_fecha from statictext within w_asigna_hora_inscripcion_pi
end type
type em_calendar from u_em within w_asigna_hora_inscripcion_pi
end type
type rb_normal from radiobutton within w_asigna_hora_inscripcion_pi
end type
type rb_altas from radiobutton within w_asigna_hora_inscripcion_pi
end type
type p_uia from picture within w_asigna_hora_inscripcion_pi
end type
type cb_ok from commandbutton within w_asigna_hora_inscripcion_pi
end type
type em_total3 from editmask within w_asigna_hora_inscripcion_pi
end type
type em_total2 from editmask within w_asigna_hora_inscripcion_pi
end type
type em_total1 from editmask within w_asigna_hora_inscripcion_pi
end type
type st_6 from statictext within w_asigna_hora_inscripcion_pi
end type
type st_dia_3 from statictext within w_asigna_hora_inscripcion_pi
end type
type st_dia2 from statictext within w_asigna_hora_inscripcion_pi
end type
type st_dia1 from statictext within w_asigna_hora_inscripcion_pi
end type
type cbx_predeterminados from checkbox within w_asigna_hora_inscripcion_pi
end type
type em_porc_2 from editmask within w_asigna_hora_inscripcion_pi
end type
type em_porc_3 from editmask within w_asigna_hora_inscripcion_pi
end type
type em_porc_1 from editmask within w_asigna_hora_inscripcion_pi
end type
type st_4 from statictext within w_asigna_hora_inscripcion_pi
end type
type st_hora_actual from statictext within w_asigna_hora_inscripcion_pi
end type
type st_cont from statictext within w_asigna_hora_inscripcion_pi
end type
type st_3 from statictext within w_asigna_hora_inscripcion_pi
end type
type cb_limpiar from commandbutton within w_asigna_hora_inscripcion_pi
end type
type cb_eliminar from commandbutton within w_asigna_hora_inscripcion_pi
end type
type cb_insertar from commandbutton within w_asigna_hora_inscripcion_pi
end type
type lb_dias_inscripcion from listbox within w_asigna_hora_inscripcion_pi
end type
type cb_agregar from commandbutton within w_asigna_hora_inscripcion_pi
end type
type em_hora_fin from editmask within w_asigna_hora_inscripcion_pi
end type
type em_hora_ini from editmask within w_asigna_hora_inscripcion_pi
end type
type st_2 from statictext within w_asigna_hora_inscripcion_pi
end type
type st_1 from statictext within w_asigna_hora_inscripcion_pi
end type
type cb_ejecuta from commandbutton within w_asigna_hora_inscripcion_pi
end type
type gb_preinscripcion from groupbox within w_asigna_hora_inscripcion_pi
end type
type gb_grado from groupbox within w_asigna_hora_inscripcion_pi
end type
type gb_1 from groupbox within w_asigna_hora_inscripcion_pi
end type
type gb_porcent from groupbox within w_asigna_hora_inscripcion_pi
end type
type gb_disponibilidad from groupbox within w_asigna_hora_inscripcion_pi
end type
type gb_seleccionados from groupbox within w_asigna_hora_inscripcion_pi
end type
end forward

global type w_asigna_hora_inscripcion_pi from window
integer x = 4
integer y = 326
integer width = 3152
integer height = 2106
boolean titlebar = true
string title = "Asignación de horarios para reinscripción"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 10789024
cb_establece_folio_sol cb_establece_folio_sol
p_1 p_1
rb_ingreso rb_ingreso
st_porc3 st_porc3
st_porc2 st_porc2
st_porc1 st_porc1
em_susceptibles em_susceptibles
cb_susceptibles cb_susceptibles
em_cuenta_registros em_cuenta_registros
uo_1 uo_1
cb_contar cb_contar
cb_1 cb_1
rb_todos rb_todos
rb_no_preinscritos rb_no_preinscritos
rb_preinscritos rb_preinscritos
rb_posgrado rb_posgrado
rb_licenciatura rb_licenciatura
st_fecha st_fecha
em_calendar em_calendar
rb_normal rb_normal
rb_altas rb_altas
p_uia p_uia
cb_ok cb_ok
em_total3 em_total3
em_total2 em_total2
em_total1 em_total1
st_6 st_6
st_dia_3 st_dia_3
st_dia2 st_dia2
st_dia1 st_dia1
cbx_predeterminados cbx_predeterminados
em_porc_2 em_porc_2
em_porc_3 em_porc_3
em_porc_1 em_porc_1
st_4 st_4
st_hora_actual st_hora_actual
st_cont st_cont
st_3 st_3
cb_limpiar cb_limpiar
cb_eliminar cb_eliminar
cb_insertar cb_insertar
lb_dias_inscripcion lb_dias_inscripcion
cb_agregar cb_agregar
em_hora_fin em_hora_fin
em_hora_ini em_hora_ini
st_2 st_2
st_1 st_1
cb_ejecuta cb_ejecuta
gb_preinscripcion gb_preinscripcion
gb_grado gb_grado
gb_1 gb_1
gb_porcent gb_porcent
gb_disponibilidad gb_disponibilidad
gb_seleccionados gb_seleccionados
end type
global w_asigna_hora_inscripcion_pi w_asigna_hora_inscripcion_pi

type variables
Datastore ds_alumnos
real porcentaje[3]
int band_porc=1
end variables

forward prototypes
public subroutine aumenta_media_hora (ref datetime hora_insc)
public function long obten_no_bloques ()
public function integer validacion_fechas ()
public function datetime hora_inicial ()
public function time hora_final ()
public function datetime aumenta_dia ()
public subroutine genera_archivo_rangos ()
public function string wf_obten_criterio ()
end prototypes

public subroutine aumenta_media_hora (ref datetime hora_insc);//Funcion que aumenta media hora a la recibida como parametro
//Marzo	1998	
//CAMP DkWf
date dia
int hora,minuto
dia	=date(hora_insc)

hora	=	hour(time(hora_insc))
minuto	=	minute(time(hora_insc))

if minuto	= 0 then
	minuto	=	30
elseif minuto	=	30	then
	minuto	= 0
	hora++
	if hora = 25 then
		hora = 1
	elseif hora = 14 then
		hora = 15
	end if
end if


hora_insc	=	datetime(dia,time(hora,minuto,0))
st_hora_actual.text	=	string(time(hora_insc))
end subroutine

public function long obten_no_bloques ();//Función que analiza los strings y regresa el No. total de 1/2's Horas que existen
//dentro de los días de inscripción. Se toma por default la hora de la comida de 14.00 a 15:00
//Abril 1998 CAMP DkWf
string fechas[],horas_temp
int cont,bloques
time hora_ini,hora_fin
int hora1,hora2,min1,min2



for cont	=	1 to lb_dias_inscripcion.totalitems()
	lb_dias_inscripcion.selectitem(cont)
	fechas[cont]	=	lb_dias_inscripcion.selecteditem()	
next
for cont = 1 to upperbound(fechas)
	horas_temp	= mid(fechas[cont],pos(fechas[cont],' ')+1)
	hora_ini	= time(mid(horas_temp,1,pos(horas_temp,' ')))
	hora_fin	= time(mid(horas_temp,pos(horas_temp,' ')+1))
	hora1	=	integer(mid(string(hora_ini),1,2))
	min1	=	integer(mid(string(hora_ini),4,2))
	hora2	=	integer(mid(string(hora_fin),1,2))
	min2	=	integer(mid(string(hora_fin),4,2))
	bloques = bloques +(2*( hora2 - hora1))
	if min1 >=	30	then
		bloques --
	end if
	if min2 >=	30	then
		bloques++
	end if
	if hora2 <= 14 or hora1 >= 15 then
	else
		bloques	= bloques - 2
	end if
	
next

return bloques
end function

public function integer validacion_fechas ();//Funcion que revisa si existen dos renglones con la misma fecha y elimina uno
//Abril	1998	CAMP DkWf
int cont,cont1
string cad1,cad2,str1,str2
date fec1,fec2

for cont	=	1	to lb_dias_inscripcion.totalitems() - 1
	cad1	=	mid(lb_dias_inscripcion.text(cont),0,pos(lb_dias_inscripcion.text(cont),' '))
	for cont1	=	cont + 1 to lb_dias_inscripcion.totalitems()
			cad2	=	mid(lb_dias_inscripcion.text(cont1),0,pos(lb_dias_inscripcion.text(cont1),' '))
			if match(cad1,cad2)	=	true	then
				lb_dias_inscripcion.selectitem(cont1)
				cb_eliminar.triggerevent(clicked!)
				cont1 --
			end if
	next
next

for cont	=	1	to lb_dias_inscripcion.totalitems() - 1
	str1	=	lb_dias_inscripcion.text(cont)
	cad1	=	mid(str1,0,pos(str1,' '))
	fec1	=	date(cad1)
	for cont1	=	cont + 1 to lb_dias_inscripcion.totalitems()
			str2	=	lb_dias_inscripcion.text(cont1)
			cad2	=	mid(str2,0,pos(str2,' '))
			fec2	=	date(cad2)
			if	daysafter(fec1,fec2)	<	0	then
				lb_dias_inscripcion.selectitem(cont1)
				cb_eliminar.triggerevent(clicked!)
				lb_dias_inscripcion.InsertItem (str2,cont)
			end if
	next
next
return lb_dias_inscripcion.totalitems()

end function

public function datetime hora_inicial ();//Funcion que devuelve la hora de inicio de reinscripciones en base a la lista de dias
//Abril 1998	CAMP DkWf
string linea
date fecha1
time hora

lb_dias_inscripcion.selectitem(1)
linea	=	lb_dias_inscripcion.selecteditem()
fecha1	=	date(mid(linea,1,pos(linea,' ')))
hora	=	time(mid(linea,pos(linea,' ')+1,pos(linea,' ',pos(linea,' '))))
st_hora_actual.text = string(hora)
return datetime(fecha1,hora)
end function

public function time hora_final ();//Funcion que recibe la hora y el dia corriente
//regresa la hora final de ese dia
//Abril 1998 CAMP DkWf
string linea

linea = lb_dias_inscripcion.selecteditem()

return time(mid(linea,pos(linea,' ',pos(linea,' ')+1)))
end function

public function datetime aumenta_dia ();//Funcion que aumenta un dia a la recibida como parametro
//Marzo	1998			CAMP DkWf
string linea,hor
int indice,hora_temp,min
date fecha1
time hora

indice	=	lb_dias_inscripcion.selectedindex()
if indice <	lb_dias_inscripcion.TotalItems() then
	indice ++
	lb_dias_inscripcion.selectitem(indice)
	linea	=	lb_dias_inscripcion.selecteditem()	
	fecha1	= date(mid(linea,1,pos(linea,' ')))
	hor	=	mid(linea,pos(linea,' ')+1)
	hor	= 	mid(hor,1,pos(linea,' ')-1)
	hora	=	time(hor)
	hora_temp	=	hour(hora)
	if hora_temp = 14 then
		min	=	minute(hora)
		hora	=	time(15,min,00)
	end if	
	st_hora_actual.text	=	string(hora)
//else
//	lb_dias_inscripcion.selectitem(indice)
//	linea	=	lb_dias_inscripcion.selecteditem()	
//	fecha	= date(mid(linea,1,pos(linea,' ')))
//	hor	=	mid(linea,pos(linea,' ',pos(linea,' ')+1)+1)
//	hora	=	time(mid(linea,pos(linea,' ',pos(linea,' ')+1)+1))
end if

return datetime(fecha1,hora)

end function

public subroutine genera_archivo_rangos ();//Función dedicada a crear  un archivo para tener los rangos de cuentas en el periodo de altas
//Junio 1998
//CAMP 1998 DkWf
integer spprl,cont

string linea
Datastore ds_rangos

ds_rangos	=	create datastore 
ds_rangos.dataobject	=	"dw_altas_hora_inscrip"
ds_rangos.settransobject(sqlca)
ds_rangos.retrieve()

spprl	=	FileOpen("c:\spprl\horario_altas.doc",linemode!,Write!,Lockwrite!,Replace!)
linea = "De la Cuenta~t a la~t~t Cuenta ~t Día~t ~tHora"
FileWrite(spprl,linea)
for cont = 1 to ds_rangos.rowcount()
	linea = string(ds_rangos.getitemnumber(cont,"cuenta"))+"-"+ds_rangos.getitemstring(cont,"dig")+"~t~t->~t~t"+string(ds_rangos.getitemnumber(cont,"cuentab"))+"-"+ds_rangos.getitemstring(cont,"digb")+"~t"+string(ds_rangos.getitemdatetime(cont,"hora_entrada"))
	FileWrite(spprl,linea)
next
FileClose(spprl)
messagebox("VERIFIQUE ARCHIVO GENERADO","Revise el archivo HORARIO_ALTAS.DOC en el subdirectorio C:\spprl~rContiene el rango de asignación de horarios")
end subroutine

public function string wf_obten_criterio ();//NOMBRE
//wf_obten_criterio
//
//REGRESA
//string
//
//RECIBE


string ls_criterio_grado, ls_criterio_preinsc, ls_criterio


if rb_licenciatura.checked then
	ls_criterio_grado = "L"
elseif rb_posgrado.checked then
	ls_criterio_grado = "P"
elseif rb_ingreso.checked then
	ls_criterio_grado = "I"
end if

if rb_preinscritos.checked then
	ls_criterio_preinsc = "P"
elseif rb_no_preinscritos.checked then
	ls_criterio_preinsc = "NP"
elseif rb_todos.checked then
	ls_criterio_preinsc = ""
end if

if	ls_criterio_grado = "I" then
	ls_criterio_preinsc = ""	
end if

ls_criterio =ls_criterio_grado + ls_criterio_preinsc

return ls_criterio

end function

on w_asigna_hora_inscripcion_pi.create
this.cb_establece_folio_sol=create cb_establece_folio_sol
this.p_1=create p_1
this.rb_ingreso=create rb_ingreso
this.st_porc3=create st_porc3
this.st_porc2=create st_porc2
this.st_porc1=create st_porc1
this.em_susceptibles=create em_susceptibles
this.cb_susceptibles=create cb_susceptibles
this.em_cuenta_registros=create em_cuenta_registros
this.uo_1=create uo_1
this.cb_contar=create cb_contar
this.cb_1=create cb_1
this.rb_todos=create rb_todos
this.rb_no_preinscritos=create rb_no_preinscritos
this.rb_preinscritos=create rb_preinscritos
this.rb_posgrado=create rb_posgrado
this.rb_licenciatura=create rb_licenciatura
this.st_fecha=create st_fecha
this.em_calendar=create em_calendar
this.rb_normal=create rb_normal
this.rb_altas=create rb_altas
this.p_uia=create p_uia
this.cb_ok=create cb_ok
this.em_total3=create em_total3
this.em_total2=create em_total2
this.em_total1=create em_total1
this.st_6=create st_6
this.st_dia_3=create st_dia_3
this.st_dia2=create st_dia2
this.st_dia1=create st_dia1
this.cbx_predeterminados=create cbx_predeterminados
this.em_porc_2=create em_porc_2
this.em_porc_3=create em_porc_3
this.em_porc_1=create em_porc_1
this.st_4=create st_4
this.st_hora_actual=create st_hora_actual
this.st_cont=create st_cont
this.st_3=create st_3
this.cb_limpiar=create cb_limpiar
this.cb_eliminar=create cb_eliminar
this.cb_insertar=create cb_insertar
this.lb_dias_inscripcion=create lb_dias_inscripcion
this.cb_agregar=create cb_agregar
this.em_hora_fin=create em_hora_fin
this.em_hora_ini=create em_hora_ini
this.st_2=create st_2
this.st_1=create st_1
this.cb_ejecuta=create cb_ejecuta
this.gb_preinscripcion=create gb_preinscripcion
this.gb_grado=create gb_grado
this.gb_1=create gb_1
this.gb_porcent=create gb_porcent
this.gb_disponibilidad=create gb_disponibilidad
this.gb_seleccionados=create gb_seleccionados
this.Control[]={this.cb_establece_folio_sol,&
this.p_1,&
this.rb_ingreso,&
this.st_porc3,&
this.st_porc2,&
this.st_porc1,&
this.em_susceptibles,&
this.cb_susceptibles,&
this.em_cuenta_registros,&
this.uo_1,&
this.cb_contar,&
this.cb_1,&
this.rb_todos,&
this.rb_no_preinscritos,&
this.rb_preinscritos,&
this.rb_posgrado,&
this.rb_licenciatura,&
this.st_fecha,&
this.em_calendar,&
this.rb_normal,&
this.rb_altas,&
this.p_uia,&
this.cb_ok,&
this.em_total3,&
this.em_total2,&
this.em_total1,&
this.st_6,&
this.st_dia_3,&
this.st_dia2,&
this.st_dia1,&
this.cbx_predeterminados,&
this.em_porc_2,&
this.em_porc_3,&
this.em_porc_1,&
this.st_4,&
this.st_hora_actual,&
this.st_cont,&
this.st_3,&
this.cb_limpiar,&
this.cb_eliminar,&
this.cb_insertar,&
this.lb_dias_inscripcion,&
this.cb_agregar,&
this.em_hora_fin,&
this.em_hora_ini,&
this.st_2,&
this.st_1,&
this.cb_ejecuta,&
this.gb_preinscripcion,&
this.gb_grado,&
this.gb_1,&
this.gb_porcent,&
this.gb_disponibilidad,&
this.gb_seleccionados}
end on

on w_asigna_hora_inscripcion_pi.destroy
destroy(this.cb_establece_folio_sol)
destroy(this.p_1)
destroy(this.rb_ingreso)
destroy(this.st_porc3)
destroy(this.st_porc2)
destroy(this.st_porc1)
destroy(this.em_susceptibles)
destroy(this.cb_susceptibles)
destroy(this.em_cuenta_registros)
destroy(this.uo_1)
destroy(this.cb_contar)
destroy(this.cb_1)
destroy(this.rb_todos)
destroy(this.rb_no_preinscritos)
destroy(this.rb_preinscritos)
destroy(this.rb_posgrado)
destroy(this.rb_licenciatura)
destroy(this.st_fecha)
destroy(this.em_calendar)
destroy(this.rb_normal)
destroy(this.rb_altas)
destroy(this.p_uia)
destroy(this.cb_ok)
destroy(this.em_total3)
destroy(this.em_total2)
destroy(this.em_total1)
destroy(this.st_6)
destroy(this.st_dia_3)
destroy(this.st_dia2)
destroy(this.st_dia1)
destroy(this.cbx_predeterminados)
destroy(this.em_porc_2)
destroy(this.em_porc_3)
destroy(this.em_porc_1)
destroy(this.st_4)
destroy(this.st_hora_actual)
destroy(this.st_cont)
destroy(this.st_3)
destroy(this.cb_limpiar)
destroy(this.cb_eliminar)
destroy(this.cb_insertar)
destroy(this.lb_dias_inscripcion)
destroy(this.cb_agregar)
destroy(this.em_hora_fin)
destroy(this.em_hora_ini)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_ejecuta)
destroy(this.gb_preinscripcion)
destroy(this.gb_grado)
destroy(this.gb_1)
destroy(this.gb_porcent)
destroy(this.gb_disponibilidad)
destroy(this.gb_seleccionados)
end on

event open;this.x=1
this.y=1

integer li_periodo, li_anio

//periodo_actual(li_periodo, li_anio, gtr_sce)

//gi_periodo = li_periodo
//gi_anio = li_anio

//uo_1.em_ani.text = string(gi_anio)
//uo_1.em_per.text = string(gi_periodo)

//uo_1.em_ani.DisplayOnly= true
//uo_1.em_per.DisplayOnly= true


ds_alumnos	=	create datastore 
ds_alumnos.dataobject	=	"d_asigna_hora_insc_nvo"

ds_alumnos.settransobject(gtr_sce)
//ds_alumnos.retrieve()

f_borra_criterio(gi_periodo, gi_anio)

porcentaje[1]	=	.35
porcentaje[2]	=	.35
porcentaje[3]	=	.30

//st_cont.text ="0 - "+string(ds_alumnos.rowcount())

end event

event close;f_borra_criterio(gi_periodo, gi_anio)
end event

type cb_establece_folio_sol from commandbutton within w_asigna_hora_inscripcion_pi
integer x = 2096
integer y = 1290
integer width = 622
integer height = 90
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Establece Folio Solicitudes"
end type

event clicked;integer li_confirma, li_res_criterio
string ls_nombre_criterio, ls_cve_criterio, ls_criterio
long ll_cuenta_inserciones

ls_criterio = wf_obten_criterio()

ll_cuenta_inserciones = f_cuenta_ins_horario_insc(gi_periodo, gi_anio, ls_criterio)

IF ll_cuenta_inserciones = 0 THEN
	MessageBox("Horarios no asignados","NO existen horarios asignados con esas caracteristicas",StopSign!)
	return	
END IF

IF rb_preinscritos.checked THEN
	ls_nombre_criterio = "ALUMNOS PREINSCRITOS CON HORARIO"
	ls_cve_criterio= "P"
ELSEIF rb_todos.checked THEN
	ls_nombre_criterio = "TODOS LOS ALUMNOS CON HORARIO"
	ls_cve_criterio= "T"
ELSE
	MessageBox("Selección de criterio errónea","Solo se permiten el criterio de Preinscritos y Todos",StopSign!)
	return
END IF

li_confirma = MessageBox("Confirmar Criterio de Folios de Solicitudes",&
"¿Desea generar las solicitudes de materia para el criterio de ~n ["+ls_nombre_criterio+"]?",Question!, YesNo!)

IF li_confirma <> 1 THEN
	MessageBox("Información","NO se ha asignado criterio para las solicitudes",Information!)
	return
END IF

li_res_criterio= f_establece_criterio_solicitudes(ls_cve_criterio,gi_periodo, gi_anio)
IF li_res_criterio =-1  THEN
	MessageBox("Error de asignación","NO se ha podido asignar criterio para las solicitudes",StopSign!)
	return
ELSEIF li_res_criterio =0 THEN
	MessageBox("Información","Se ha asignado el criterio para las solicitudes exitosamente",Information!)
	
ELSE 
	MessageBox("Error de asignación","NO se ha podido asignar criterio para las solicitudes",StopSign!)
	return
END IF

	
IF f_foliar_horario_solicitudes(ls_cve_criterio,gi_periodo, gi_anio)	= -1 THEN
	MessageBox("Error de foliación","NO se ha podido foliar las solicitudes",StopSign!)
	return
ELSE
	MessageBox("Información","Solicitudes Foliadas Exitosamente",Information!)
	return	
END IF
	
end event

type p_1 from picture within w_asigna_hora_inscripcion_pi
integer x = 527
integer y = 557
integer width = 59
integer height = 83
boolean bringtotop = true
string picturename = "ddarrow.bmp"
boolean focusrectangle = false
end type

event clicked;em_calendar.Event pfc_ddcalendar ( )
end event

type rb_ingreso from radiobutton within w_asigna_hora_inscripcion_pi
integer x = 128
integer y = 275
integer width = 406
integer height = 77
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
string text = "1er Ingreso (Lic)"
borderstyle borderstyle = stylelowered!
end type

type st_porc3 from statictext within w_asigna_hora_inscripcion_pi
integer x = 560
integer y = 1622
integer width = 55
integer height = 102
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
boolean enabled = false
string text = "%"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_porc2 from statictext within w_asigna_hora_inscripcion_pi
integer x = 560
integer y = 1523
integer width = 55
integer height = 102
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
boolean enabled = false
string text = "%"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_porc1 from statictext within w_asigna_hora_inscripcion_pi
integer x = 560
integer y = 1421
integer width = 55
integer height = 102
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
boolean enabled = false
string text = "%"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_susceptibles from editmask within w_asigna_hora_inscripcion_pi
integer x = 611
integer y = 1830
integer width = 282
integer height = 64
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
string mask = "#,###"
end type

type cb_susceptibles from commandbutton within w_asigna_hora_inscripcion_pi
integer x = 197
integer y = 1830
integer width = 395
integer height = 64
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Susceptibles"
end type

event clicked;string ls_criterio
long ll_num_alumnos


ls_criterio = wf_obten_criterio()
//ls_nivel = Mid(ls_criterio,1,1)
ls_criterio = ls_criterio + "%"

ll_num_alumnos= ds_alumnos.Retrieve(gi_periodo, gi_anio, ls_criterio)

em_susceptibles.text =string(ll_num_alumnos)


end event

type em_cuenta_registros from editmask within w_asigna_hora_inscripcion_pi
integer x = 2004
integer y = 282
integer width = 282
integer height = 93
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
string mask = "#,##0"
end type

type uo_1 from uo_per_ani within w_asigna_hora_inscripcion_pi
integer x = 1543
integer y = 51
integer width = 1251
integer height = 166
integer taborder = 10
boolean enabled = true
long backcolor = 1090519039
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type cb_contar from commandbutton within w_asigna_hora_inscripcion_pi
integer x = 1620
integer y = 282
integer width = 318
integer height = 90
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Contar"
end type

event clicked;integer li_cuenta_inserciones
string ls_criterio, ls_cuenta_inserciones

ls_criterio = wf_obten_criterio()

li_cuenta_inserciones = f_cuenta_ins_horario_insc(gi_periodo, gi_anio, ls_criterio)
ls_cuenta_inserciones = string(li_cuenta_inserciones)

em_cuenta_registros.Text =ls_cuenta_inserciones

//MessageBox("Periodo y Año", String(gi_periodo) +"-*-"+ string(gi_anio))

end event

type cb_1 from commandbutton within w_asigna_hora_inscripcion_pi
integer x = 2352
integer y = 282
integer width = 563
integer height = 90
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Restaurar Horarios"
end type

event clicked;integer li_respuesta
integer li_cuenta_inserciones
string ls_criterio, ls_cuenta_inserciones

li_respuesta= MessageBox("Confirmacion","Desea borrar los criterios establecidos?",Question!, YesNo!)

if li_respuesta = 1 then
	
	SetPointer(HourGlass!)
	
	f_borra_horario_insc(gi_periodo, gi_anio)

	ls_criterio = "T"

	li_cuenta_inserciones = f_cuenta_ins_horario_insc(gi_periodo, gi_anio, ls_criterio)
	ls_cuenta_inserciones = string(li_cuenta_inserciones)

	em_cuenta_registros.Text =ls_cuenta_inserciones

end if

return
end event

type rb_todos from radiobutton within w_asigna_hora_inscripcion_pi
integer x = 757
integer y = 266
integer width = 252
integer height = 77
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
string text = "Todos"
borderstyle borderstyle = stylelowered!
end type

type rb_no_preinscritos from radiobutton within w_asigna_hora_inscripcion_pi
integer x = 757
integer y = 195
integer width = 413
integer height = 77
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
string text = "No Preinscritos"
borderstyle borderstyle = stylelowered!
end type

type rb_preinscritos from radiobutton within w_asigna_hora_inscripcion_pi
integer x = 757
integer y = 118
integer width = 336
integer height = 77
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
string text = "Preinscritos"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

type rb_posgrado from radiobutton within w_asigna_hora_inscripcion_pi
integer x = 128
integer y = 198
integer width = 366
integer height = 77
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
string text = "Posgrado"
borderstyle borderstyle = stylelowered!
end type

type rb_licenciatura from radiobutton within w_asigna_hora_inscripcion_pi
integer x = 128
integer y = 122
integer width = 439
integer height = 77
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
string text = "Licenciatura"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

type st_fecha from statictext within w_asigna_hora_inscripcion_pi
integer x = 190
integer y = 477
integer width = 285
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
boolean enabled = false
string text = "Fecha"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_calendar from u_em within w_asigna_hora_inscripcion_pi
integer x = 150
integer y = 557
integer width = 369
integer taborder = 180
integer textsize = -10
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
double increment = 0
string minmax = ""
end type

event constructor;Integer  li_return   

this.text= string(today())
this.of_SetDropDownCalendar(TRUE)
this.iuo_calendar.of_SetInitialValue(TRUE)
//this.iuo_calendar.x =1
//this.iuo_calendar.y =1
//
this.iuo_calendar.x =143
this.iuo_calendar.y =650
//
//this.iuo_calendar.of_SetCloseOnClick(FALSE) 
//this.iuo_calendar.of_SetCloseOnDClick(FALSE)  

//li_return = this.Event pfc_DDCalendar()
//this.iuo_calendar.of_SetDropDown(TRUE)

end event

type rb_normal from radiobutton within w_asigna_hora_inscripcion_pi
integer x = 2443
integer y = 1594
integer width = 413
integer height = 77
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Periodo Normal "
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if this.checked = true then
	ds_alumnos.setsort("academicos_creditos_cursados D,academicos_promedio D,academicos_sem_cursados A,alumnos_nombre_completo A")
	ds_alumnos.sort()
else
	ds_alumnos.setsort("academicos_cuenta A")
	ds_alumnos.sort()
end if
end event

type rb_altas from radiobutton within w_asigna_hora_inscripcion_pi
integer x = 2443
integer y = 1533
integer width = 457
integer height = 48
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Periodo de Altas"
borderstyle borderstyle = stylelowered!
end type

event clicked;//if this.checked = true then
//	ds_alumnos.setsort("academicos_cuenta A")
//	ds_alumnos.sort()
//else
//	ds_alumnos.setsort("academicos_creditos_cursados D,academicos_promedio D,academicos_sem_cursados A,alumnos_nombre_completo A")
//	ds_alumnos.sort()
//end if

rb_normal.triggerevent(clicked!)
end event

type p_uia from picture within w_asigna_hora_inscripcion_pi
integer x = 2951
integer y = 54
integer width = 110
integer height = 90
boolean originalsize = true
string picturename = "uia2.bmp"
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_asigna_hora_inscripcion_pi
integer x = 881
integer y = 1744
integer width = 249
integer height = 64
integer taborder = 200
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Aceptar"
end type

event clicked;real lr_suma, lr_uno, lr_dos, lr_tres, lr_suma_validada

band_porc = 0
lr_uno	=	real(mid(em_porc_1.text,1,2))*.010
lr_dos	=	real(mid(em_porc_2.text,1,2))*.010
lr_tres	=	real(mid(em_porc_3.text,1,2))*.010

lr_suma = lr_uno + lr_dos + lr_tres
lr_suma_validada = round(lr_suma,1)

if lr_suma_validada <> 1 then
	MessageBox("Error en los porcentajes", "La suma de los porcentajes debe dar 100%",StopSign!)
	return
end if

porcentaje[1]	=	lr_uno
porcentaje[2]	=	lr_dos
porcentaje[3]	=	lr_tres

MessageBox("Porcentajes establecidos", "Los porcentajes fueron asignados correctamente")
return

end event

type em_total3 from editmask within w_asigna_hora_inscripcion_pi
integer x = 611
integer y = 1626
integer width = 461
integer height = 102
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
end type

type em_total2 from editmask within w_asigna_hora_inscripcion_pi
integer x = 611
integer y = 1523
integer width = 461
integer height = 102
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
end type

type em_total1 from editmask within w_asigna_hora_inscripcion_pi
integer x = 611
integer y = 1427
integer width = 461
integer height = 102
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
string displaydata = ""
end type

type st_6 from statictext within w_asigna_hora_inscripcion_pi
integer x = 490
integer y = 1366
integer width = 728
integer height = 54
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
boolean enabled = false
string text = "Alumnos por Bloque de 1/2 hora"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_dia_3 from statictext within w_asigna_hora_inscripcion_pi
integer x = 73
integer y = 1635
integer width = 249
integer height = 77
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
boolean enabled = false
string text = "Bloque 3"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_dia2 from statictext within w_asigna_hora_inscripcion_pi
integer x = 73
integer y = 1533
integer width = 249
integer height = 77
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
boolean enabled = false
string text = "Bloque 2"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_dia1 from statictext within w_asigna_hora_inscripcion_pi
integer x = 73
integer y = 1434
integer width = 249
integer height = 77
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
boolean enabled = false
string text = "Bloque 1"
alignment alignment = center!
boolean focusrectangle = false
end type

type cbx_predeterminados from checkbox within w_asigna_hora_inscripcion_pi
integer x = 84
integer y = 1747
integer width = 805
integer height = 58
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Utilizar valores predeterminados"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

event clicked;long ll_num_alumnos
string ls_criterio

if checked = true then
	em_porc_1.enabled	=	false
	em_porc_2.enabled	=	false
	em_porc_3.enabled	=	false
	
	em_porc_1.text	=	"35"
	em_porc_2.text	=	"35"
	em_porc_3.text	=	"30"
	
	porcentaje[1]	=	.35
	porcentaje[2]	=	.35
	porcentaje[3]	=	.30
	
	cb_ok.enabled = false
	cb_susceptibles.enabled = false
	band_porc = 1
else
	
	setpointer(HourGlass!)
	f_inicializa()

	em_porc_1.enabled	=	true
	em_porc_2.enabled	=	true
	em_porc_3.enabled	=	true
	
	cb_ok.enabled = true
	cb_susceptibles.enabled = true
end if

ls_criterio = wf_obten_criterio()
//ls_nivel = Mid(ls_criterio,1,1)
ls_criterio = ls_criterio + "%"
ll_num_alumnos= ds_alumnos.Retrieve(gi_periodo, gi_anio, ls_criterio)

em_susceptibles.text =string(ll_num_alumnos)

em_porc_1.event Modified()
em_porc_2.event Modified()
em_porc_3.event Modified()


end event

type em_porc_2 from editmask within w_asigna_hora_inscripcion_pi
integer x = 344
integer y = 1523
integer width = 205
integer height = 102
integer taborder = 210
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "35"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##"
end type

event modified;
int variacion_mid,mid_hora
real lr_calculo, lr_variacion
long ll_porcentaje, ll_num_renglones

mid_hora	=	obten_no_bloques()//Función que regresa el número de 1/2's horas en el periodo
if mid_hora = 0 then
	messagebox("DEFINA DIAS de INSCRIPCIÓN","Es necesario tener definidos los dias de inscripción para poder obtener el número de alumnos por bloque")
else
	variacion_mid	=	mid_hora/3
	lr_variacion = mid_hora/3
//	em_total2.text	=	string(round(((long(mid(text,1,2))*.01)*ds_alumnos.rowcount())/variacion_mid,0))
   ll_porcentaje = long(mid(text,1,2))
	ll_num_renglones = ds_alumnos.rowcount()
	lr_calculo = ((ll_porcentaje*.01)*ll_num_renglones)/lr_variacion
	em_total2.text	=	string(round(lr_calculo,0))
end if

end event

event rbuttondown;triggerevent(modified!)
end event

type em_porc_3 from editmask within w_asigna_hora_inscripcion_pi
integer x = 344
integer y = 1622
integer width = 205
integer height = 102
integer taborder = 220
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "30"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##"
end type

event modified;
int variacion_mid,mid_hora
real lr_calculo, lr_variacion
long ll_porcentaje, ll_num_renglones

mid_hora	=	obten_no_bloques()//Función que regresa el número de 1/2's horas en el periodo
if mid_hora = 0 then
	messagebox("DEFINA DIAS de INSCRIPCIÓN","Es necesario tener definidos los dias de inscripción para poder obtener el número de alumnos por bloque")
else
	variacion_mid	=	mid_hora/3
	lr_variacion = mid_hora/3
//	em_total3.text	=	string(round(((long(mid(text,1,2))*.01)*ds_alumnos.rowcount())/variacion_mid,0))
   ll_porcentaje = long(mid(text,1,2))
	ll_num_renglones = ds_alumnos.rowcount()
	lr_calculo = ((ll_porcentaje*.01)*ll_num_renglones)/lr_variacion
	em_total3.text	=	string(round(lr_calculo,0))
end if

end event

event rbuttondown;triggerevent(modified!)
end event

type em_porc_1 from editmask within w_asigna_hora_inscripcion_pi
integer x = 344
integer y = 1421
integer width = 205
integer height = 102
integer taborder = 190
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "35"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##"
end type

event modified;
int variacion_mid,mid_hora
real lr_calculo, lr_variacion
long ll_porcentaje, ll_num_renglones

mid_hora	=	obten_no_bloques()//Función que regresa el número de 1/2's horas en el periodo
//MessageBox("1/2 horas"+ string(mid_hora),"renglones "+string(ds_alumnos.rowcount()))

if mid_hora = 0 then
	messagebox("DEFINA DIAS de INSCRIPCIÓN","Es necesario tener definidos los dias de inscripción para poder obtener el número de alumnos por bloque")
else
	variacion_mid	=	mid_hora/3
	lr_variacion = mid_hora/3
//	em_total1.text	=	string(round(((long(mid(text,1,2))*.01)*ds_alumnos.rowcount())/variacion_mid,0))
   ll_porcentaje = long(mid(text,1,2))
	ll_num_renglones = ds_alumnos.rowcount()
	lr_calculo = ((ll_porcentaje*.01)*ll_num_renglones)/lr_variacion
	em_total1.text	=	string(round(lr_calculo,0))
end if

end event

event rbuttondown;triggerevent(modified!)
end event

type st_4 from statictext within w_asigna_hora_inscripcion_pi
integer x = 1682
integer y = 1562
integer width = 377
integer height = 61
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
boolean enabled = false
string text = "Asignando para:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_hora_actual from statictext within w_asigna_hora_inscripcion_pi
integer x = 2059
integer y = 1552
integer width = 289
integer height = 77
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "07:00:00"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_cont from statictext within w_asigna_hora_inscripcion_pi
integer x = 2527
integer y = 1843
integer width = 358
integer height = 70
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "2 -10000"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_3 from statictext within w_asigna_hora_inscripcion_pi
integer x = 2560
integer y = 1779
integer width = 293
integer height = 58
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
boolean enabled = false
string text = "Asignados"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_limpiar from commandbutton within w_asigna_hora_inscripcion_pi
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 1441
integer y = 1008
integer width = 274
integer height = 74
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Limpiar"
end type

event clicked;/* Se limpia la lista de alumnos y el datawindow*/
int Total
setpointer(Hourglass!)
Total=lb_dias_inscripcion.totalitems()
DO UNTIL Total=0
		lb_dias_inscripcion.DeleteItem(1)   
		Total=lb_dias_inscripcion.totalitems()
LOOP

cb_ejecuta.enabled	=	false	
enabled	= false
cb_eliminar.enabled	=	false




end event

event constructor;TabOrder = 0
end event

type cb_eliminar from commandbutton within w_asigna_hora_inscripcion_pi
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 1441
integer y = 877
integer width = 274
integer height = 74
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Eliminar"
end type

event clicked;/* Cuando se selecciona un numero de cuenta de la lista se borra */
integer li_Index
setpointer(Hourglass!)
// Se Obtiene el primer indice del renglon seleccionado
li_Index = lb_dias_inscripcion.SelectedIndex( )

// Se eliminan todos los renglones seleccionados 
DO UNTIL li_index=-1
	// Se elimina el renglon en los dos list_box
	lb_dias_inscripcion.DeleteItem(li_Index)	
	// Se vuelve a obtener el siguiente renglon
	li_Index = lb_dias_inscripcion.SelectedIndex( )
LOOP

if lb_dias_inscripcion.totalitems()	>	0	then
	cb_ejecuta.enabled	=	true
	cb_eliminar.enabled	=	true
	cb_limpiar.enabled	=	true
else
	cb_ejecuta.enabled	=	false	
	cb_eliminar.enabled	=	false
	cb_limpiar.enabled	=	false
end if


end event

event constructor;TabOrder = 0
end event

type cb_insertar from commandbutton within w_asigna_hora_inscripcion_pi
integer x = 1441
integer y = 746
integer width = 274
integer height = 74
integer taborder = 100
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Insertar"
end type

event clicked;string dia
//dia	= dw_1.fu_fecha_selected_str()
dia	= em_calendar.Text

lb_dias_inscripcion.InsertItem (  dia+" "+em_hora_ini.text+" "+em_hora_fin.text, lb_dias_inscripcion.SelectedIndex ( ))

if lb_dias_inscripcion.totalitems()	>	0	then
	cb_ejecuta.enabled	=	true
	cb_eliminar.enabled	=	true
	cb_limpiar.enabled	=	true
else
	cb_ejecuta.enabled	=	false	
end if
end event

type lb_dias_inscripcion from listbox within w_asigna_hora_inscripcion_pi
integer x = 1869
integer y = 573
integer width = 1009
integer height = 582
integer taborder = 170
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

type cb_agregar from commandbutton within w_asigna_hora_inscripcion_pi
integer x = 1441
integer y = 611
integer width = 274
integer height = 74
integer taborder = 90
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Agregar "
end type

event clicked;string dia
//dia	= dw_1.fu_fecha_selected_str()
dia	= em_calendar.Text

lb_dias_inscripcion.AddItem (dia+" "+em_hora_ini.text+" "+em_hora_fin.text)

if lb_dias_inscripcion.totalitems()	>	0	then
	cb_ejecuta.enabled	=	true
	cb_eliminar.enabled	=	true
	cb_limpiar.enabled	=	true
else
	cb_ejecuta.enabled	=	false	
end if
end event

type em_hora_fin from editmask within w_asigna_hora_inscripcion_pi
integer x = 1006
integer y = 874
integer width = 274
integer height = 83
integer taborder = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "18:00"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = timemask!
string mask = "hh:mm:ss"
string displaydata = ""
end type

event modified;time ini
long dif

ini	=	time(this.text)

dif	=	secondsafter(time(em_hora_ini.text),ini)
if dif < 0 then
	this.text =	"18:00:00"
else
	dif	=	secondsafter(time("20:00:00"),ini)
	if dif >		0 then
		this.text	=	"18:00:00"
	end if
end if
end event

type em_hora_ini from editmask within w_asigna_hora_inscripcion_pi
integer x = 1013
integer y = 557
integer width = 274
integer height = 83
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "8:00"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = timemask!
string mask = "hh:mm:ss"
string displaydata = ""
end type

event modified;time ini
long dif

ini	=	time(this.text)

dif	=	secondsafter(time("07:00:00"),ini)
if dif < 0 then
	this.text =	"08:00:00"
else
	dif	=	secondsafter(time("20:00:00"),ini)
	if dif >		0 then
		this.text	=	"08:00:00"
	end if
end if
end event

type st_2 from statictext within w_asigna_hora_inscripcion_pi
integer x = 944
integer y = 781
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
boolean enabled = false
string text = "Ultima Hora"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_asigna_hora_inscripcion_pi
integer x = 940
integer y = 477
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
boolean enabled = false
string text = "Primera Hora"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_ejecuta from commandbutton within w_asigna_hora_inscripcion_pi
integer x = 1627
integer y = 1840
integer width = 878
integer height = 77
integer taborder = 160
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Asigna Horarios  de Inscripción"
end type

event clicked;long total_alumnos,bloques,cuenta,limit, ll_num_alumnos
int mid_hora,cont,cnt,dias,variacion_mid,fila,cont1,alumno,sobr,ultimo, ls_codigo_sql
//real porcent
datetime hora_insc
string error_asigna, ls_nivel, ls_criterio, ls_criterio_insercion, ls_mensaje_sql
integer archivo
//archivo	=	FileOpen("c:\contesc\errores_asigna_horario.log",linemode!,Write!,Lockwrite!,Replace!)
archivo	=	FileOpen("errores_asigna_horario.log",linemode!,Write!,Lockwrite!,Replace!)

if band_porc = 1 and cbx_predeterminados.checked = false then
	if messagebox("AVISO, ASIGNACIÓN PREDETERMINADA","No presiono el boton ACEPTAR para utilizar sus porcentajes~r¿Usar Predeterminados?",Question!,yesno!,2) = 2 then
		return 0
	else
		cbx_predeterminados.triggerevent(clicked!)	
		cbx_predeterminados.checked = true
	end if
end if

setpointer(HourGlass!)
f_inicializa()
ls_criterio = wf_obten_criterio()
//ls_nivel = Mid(ls_criterio,1,1)
ls_criterio = ls_criterio + "%"

ll_num_alumnos= ds_alumnos.Retrieve(gi_periodo, gi_anio, ls_criterio)

st_cont.text ="0 - "+string(ds_alumnos.rowcount())


total_alumnos	=	ds_alumnos.rowcount()
for cont	= 1 to 3	
	dias	=	validacion_fechas()//Función que revisa que no haya dos renglones con el mismo dia regresa el # de dias de inscripcion
next	
mid_hora	=	obten_no_bloques()//Función que regresa el número de 1/2's horas en el periodo

variacion_mid	=	mid_hora/3
alumno = 1
//porcent =	.35
sobr	=	0
fila	=	1
hora_insc	=	hora_inicial()//función que regresa la hora y dia de inicio de reinscripciones

for cont = 1 to 3
	if cont = 3 then
		sobr	=	mid_hora - (variacion_mid*3)
//		porcent	=	.30
		limit = total_alumnos
	else
		limit =	porcentaje[cont]*total_alumnos+alumno
	end if
	bloques	= ((porcentaje[cont]*total_alumnos)/(variacion_mid+sobr)) + 1	
	for cont1 = alumno to limit
		if cont1 > total_alumnos then
			exit
		end if
			cuenta	=	ds_alumnos.object.academicos_cuenta[cont1]			
			ls_criterio_insercion =	ds_alumnos.object.orden_inscripcion_criterio[cont1]			
				INSERT INTO horario_insc  
								( periodo,
								  anio,
								  cuenta,   
								  hora_entrada,
								  lugar_fila,
								  criterio)  
				VALUES ( :gi_periodo,
				         :gi_anio,
				         :cuenta,   
							:hora_insc,
							:fila,
							:ls_criterio_insercion)  
				USING gtr_sce;
				ls_codigo_sql =gtr_sce.Sqlcode
				ls_mensaje_sql =gtr_sce.SqlErrText				
			if gtr_sce.sqlcode	=	0 then
//				commit;
				st_cont.text =string(cont1)+" - "+string(total_alumnos)
			else
				//se reportaran en un listado los errores
//				error_asigna	="Cuenta: "+string(cuenta)+"~t HORA_ENTRADA: "+string(hora_insc)+"~t Lugar en la fila: "+string(fila)+"~rERROR: "+sqlca.sqlerrtext
				error_asigna	="Cuenta: "+string(cuenta)+"hora_entrada: "+string(hora_insc)+"Lugar fila: "+string(fila)
				FileWrite(archivo,error_asigna+ls_mensaje_sql)
				messagebox(error_asigna, ls_mensaje_sql)
				return
			end if
			cnt++
			fila++
			if ( lb_dias_inscripcion.selectedindex() = lb_dias_inscripcion.TotalItems()	and	secondsafter(time(hora_insc),hora_final())	<= 1800 ) then
				ultimo = 1
			else 
				ultimo	= 0
			end if
			if (cnt = bloques and ultimo	= 0 )then
				cnt	=	1		
				fila		= 	1
				aumenta_media_hora(hora_insc)
				if secondsafter(time(hora_insc),hora_final())	= 0	then
					hora_insc	=	aumenta_dia()			
				end if
			end if			
	next
	alumno	=	(porcentaje[cont]*total_alumnos)+alumno + 1
next



commit using gtr_sce;
fileclose(archivo)
messagebox("FINALIZADA LA ASIGNACIÓN","Se termino de efectuar la asignación de horarios de reinscripción")

if rb_altas.checked = true then
	genera_archivo_rangos()
end if


end event

type gb_preinscripcion from groupbox within w_asigna_hora_inscripcion_pi
integer x = 728
integer y = 61
integer width = 505
integer height = 304
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
string text = "Preinscripción"
borderstyle borderstyle = stylelowered!
end type

type gb_grado from groupbox within w_asigna_hora_inscripcion_pi
integer x = 84
integer y = 64
integer width = 505
integer height = 304
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
string text = "Grado"
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_asigna_hora_inscripcion_pi
integer x = 2417
integer y = 1466
integer width = 494
integer height = 240
integer taborder = 150
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Asignación para:"
end type

type gb_porcent from groupbox within w_asigna_hora_inscripcion_pi
integer x = 66
integer y = 1306
integer width = 1156
integer height = 630
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Porcentaje por Bloque de Inscripción"
end type

type gb_disponibilidad from groupbox within w_asigna_hora_inscripcion_pi
boolean visible = false
integer x = 51
integer y = 10
integer width = 1368
integer height = 704
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 10789024
string text = "Selección de Horarios de Reinscripción"
end type

type gb_seleccionados from groupbox within w_asigna_hora_inscripcion_pi
integer x = 1836
integer y = 486
integer width = 1079
integer height = 704
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Dias de Reinscripción Seleccionados"
end type

