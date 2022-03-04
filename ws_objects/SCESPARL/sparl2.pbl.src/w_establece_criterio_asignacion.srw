$PBExportHeader$w_establece_criterio_asignacion.srw
forward
global type w_establece_criterio_asignacion from Window
end type
type st_fecha from statictext within w_establece_criterio_asignacion
end type
type em_calendar from u_em within w_establece_criterio_asignacion
end type
type rb_normal from radiobutton within w_establece_criterio_asignacion
end type
type rb_altas from radiobutton within w_establece_criterio_asignacion
end type
type p_uia from picture within w_establece_criterio_asignacion
end type
type cb_ok from commandbutton within w_establece_criterio_asignacion
end type
type em_total3 from editmask within w_establece_criterio_asignacion
end type
type em_total2 from editmask within w_establece_criterio_asignacion
end type
type em_total1 from editmask within w_establece_criterio_asignacion
end type
type st_6 from statictext within w_establece_criterio_asignacion
end type
type st_dia_3 from statictext within w_establece_criterio_asignacion
end type
type st_dia2 from statictext within w_establece_criterio_asignacion
end type
type st_dia1 from statictext within w_establece_criterio_asignacion
end type
type cbx_predeterminados from checkbox within w_establece_criterio_asignacion
end type
type em_porc_2 from editmask within w_establece_criterio_asignacion
end type
type em_porc_3 from editmask within w_establece_criterio_asignacion
end type
type em_porc_1 from editmask within w_establece_criterio_asignacion
end type
type st_4 from statictext within w_establece_criterio_asignacion
end type
type st_hora_actual from statictext within w_establece_criterio_asignacion
end type
type st_cont from statictext within w_establece_criterio_asignacion
end type
type st_3 from statictext within w_establece_criterio_asignacion
end type
type cb_limpiar from commandbutton within w_establece_criterio_asignacion
end type
type cb_eliminar from commandbutton within w_establece_criterio_asignacion
end type
type cb_insertar from commandbutton within w_establece_criterio_asignacion
end type
type lb_dias_inscripcion from listbox within w_establece_criterio_asignacion
end type
type cb_agregar from commandbutton within w_establece_criterio_asignacion
end type
type em_hora_fin from editmask within w_establece_criterio_asignacion
end type
type em_hora_ini from editmask within w_establece_criterio_asignacion
end type
type st_2 from statictext within w_establece_criterio_asignacion
end type
type st_1 from statictext within w_establece_criterio_asignacion
end type
type cb_ejecuta from commandbutton within w_establece_criterio_asignacion
end type
type gb_1 from groupbox within w_establece_criterio_asignacion
end type
type gb_porcent from groupbox within w_establece_criterio_asignacion
end type
type gb_disponibilidad from groupbox within w_establece_criterio_asignacion
end type
type gb_seleccionados from groupbox within w_establece_criterio_asignacion
end type
end forward

global type w_establece_criterio_asignacion from Window
int X=4
int Y=326
int Width=3152
int Height=1661
boolean TitleBar=true
string Title="Asignación de horarios para reinscripción"
long BackColor=10789024
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
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
gb_1 gb_1
gb_porcent gb_porcent
gb_disponibilidad gb_disponibilidad
gb_seleccionados gb_seleccionados
end type
global w_establece_criterio_asignacion w_establece_criterio_asignacion

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

on w_establece_criterio_asignacion.create
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
this.gb_1=create gb_1
this.gb_porcent=create gb_porcent
this.gb_disponibilidad=create gb_disponibilidad
this.gb_seleccionados=create gb_seleccionados
this.Control[]={this.st_fecha,&
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
this.gb_1,&
this.gb_porcent,&
this.gb_disponibilidad,&
this.gb_seleccionados}
end on

on w_establece_criterio_asignacion.destroy
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
destroy(this.gb_1)
destroy(this.gb_porcent)
destroy(this.gb_disponibilidad)
destroy(this.gb_seleccionados)
end on

event open;ds_alumnos	=	create datastore 
ds_alumnos.dataobject	=	"dw_asigna_hora_insc"

ds_alumnos.settransobject(sqlca)
ds_alumnos.retrieve()

porcentaje[1]	=	.35
porcentaje[2]	=	.35
porcentaje[3]	=	.30

st_cont.text ="0 - "+string(ds_alumnos.rowcount())
end event

type st_fecha from statictext within w_establece_criterio_asignacion
int X=366
int Y=58
int Width=285
int Height=64
boolean Enabled=false
string Text="Fecha"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=15793151
long BackColor=10789024
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_calendar from u_em within w_establece_criterio_asignacion
int X=325
int Y=138
int Width=369
int TabOrder=100
Alignment Alignment=Center!
string Mask="dd/mm/yyyy"
MaskDataType MaskDataType=DateMask!
double Increment=0
string MinMax=""
int TextSize=-10
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event constructor;Integer  li_return   

this.text= string(today())
this.of_SetDropDownCalendar(TRUE)
this.iuo_calendar.of_SetInitialValue(TRUE)
this.iuo_calendar.x =143
this.iuo_calendar.y =256

//this.iuo_calendar.of_SetCloseOnClick(FALSE) 
//this.iuo_calendar.of_SetCloseOnDClick(FALSE)  

//li_return = this.Event pfc_DDCalendar()
end event

type rb_normal from radiobutton within w_establece_criterio_asignacion
int X=2406
int Y=1040
int Width=413
int Height=77
string Text="Periodo Normal "
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=15793151
long BackColor=10789024
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.checked = true then
	ds_alumnos.setsort("academicos_creditos_cursados D,academicos_promedio D,academicos_sem_cursados A,alumnos_nombre_completo A")
	ds_alumnos.sort()
else
	ds_alumnos.setsort("academicos_cuenta A")
	ds_alumnos.sort()
end if
end event

type rb_altas from radiobutton within w_establece_criterio_asignacion
int X=2406
int Y=979
int Width=457
int Height=48
string Text="Periodo de Altas"
BorderStyle BorderStyle=StyleLowered!
long TextColor=15793151
long BackColor=10789024
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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

type p_uia from picture within w_establece_criterio_asignacion
int X=2926
int Y=16
int Width=110
int Height=90
string PictureName="uia2.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type cb_ok from commandbutton within w_establece_criterio_asignacion
int X=933
int Y=1398
int Width=249
int Height=64
int TabOrder=120
boolean Enabled=false
string Text="Aceptar"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;band_porc = 0
porcentaje[1]	=	real(mid(em_porc_1.text,1,2))*.010
porcentaje[2]	=	real(mid(em_porc_2.text,1,2))*.010
porcentaje[3]	=	real(mid(em_porc_3.text,1,2))*.010

end event

type em_total3 from editmask within w_establece_criterio_asignacion
int X=611
int Y=1283
int Width=461
int Height=102
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_total2 from editmask within w_establece_criterio_asignacion
int X=611
int Y=1181
int Width=461
int Height=102
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_total1 from editmask within w_establece_criterio_asignacion
int X=611
int Y=1085
int Width=461
int Height=102
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string DisplayData=""
boolean DisplayOnly=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within w_establece_criterio_asignacion
int X=490
int Y=1024
int Width=728
int Height=54
boolean Enabled=false
string Text="Alumnos por Bloque de 1/2 hora"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=15793151
long BackColor=10789024
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_dia_3 from statictext within w_establece_criterio_asignacion
int X=73
int Y=1293
int Width=249
int Height=77
boolean Enabled=false
string Text="Día 3"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=15793151
long BackColor=10789024
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_dia2 from statictext within w_establece_criterio_asignacion
int X=73
int Y=1190
int Width=249
int Height=77
boolean Enabled=false
string Text="Día 2"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=15793151
long BackColor=10789024
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_dia1 from statictext within w_establece_criterio_asignacion
int X=73
int Y=1091
int Width=249
int Height=77
boolean Enabled=false
string Text="Día 1"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=15793151
long BackColor=10789024
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_predeterminados from checkbox within w_establece_criterio_asignacion
int X=84
int Y=1405
int Width=805
int Height=58
string Text="Utilizar valores predeterminados"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=15793151
long BackColor=10789024
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if checked = true then
	em_porc_1.enabled	=	false
	em_porc_2.enabled	=	false
	em_porc_3.enabled	=	false
	
	em_porc_1.text	=	"35%"
	em_porc_2.text	=	"35%"
	em_porc_3.text	=	"30%"
	
	porcentaje[1]	=	.35
	porcentaje[2]	=	.35
	porcentaje[3]	=	.30
	
	cb_ok.enabled = false
	band_porc = 1
else
	em_porc_1.enabled	=	true
	em_porc_2.enabled	=	true
	em_porc_3.enabled	=	true
	
	cb_ok.enabled = true
end if
end event

type em_porc_2 from editmask within w_establece_criterio_asignacion
int X=344
int Y=1181
int Width=249
int Height=102
int TabOrder=130
boolean Enabled=false
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="##%"
string DisplayData=""
string Text="35%"
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;int variacion_mid,mid_hora

mid_hora	=	obten_no_bloques()//Función que regresa el número de 1/2's horas en el periodo
if mid_hora = 0 then
	messagebox("DEFINA DIAS de INSCRIPCIÓN","Es necesario tener definidos los dias de inscripción para poder obtener el número de alumnos por bloque")
else
	variacion_mid	=	mid_hora/3
	em_total2.text	=	string(round(((long(mid(text,1,2))*.01)*ds_alumnos.rowcount())/variacion_mid,0))
end if

end event

event rbuttondown;triggerevent(modified!)
end event

type em_porc_3 from editmask within w_establece_criterio_asignacion
int X=344
int Y=1280
int Width=249
int Height=102
int TabOrder=140
boolean Enabled=false
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="##%"
string DisplayData=","
string Text="30%"
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;int variacion_mid,mid_hora

mid_hora	=	obten_no_bloques()//Función que regresa el número de 1/2's horas en el periodo
if mid_hora = 0 then
	messagebox("DEFINA DIAS de INSCRIPCIÓN","Es necesario tener definidos los dias de inscripción para poder obtener el número de alumnos por bloque")
else
	variacion_mid	=	mid_hora/3
	em_total3.text	=	string(round(((long(mid(text,1,2))*.01)*ds_alumnos.rowcount())/variacion_mid,0))
end if

end event

event rbuttondown;triggerevent(modified!)
end event

type em_porc_1 from editmask within w_establece_criterio_asignacion
int X=344
int Y=1078
int Width=249
int Height=102
int TabOrder=110
boolean Enabled=false
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="##%"
string DisplayData="¬"
string Text="35%"
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;
int variacion_mid,mid_hora


mid_hora	=	obten_no_bloques()//Función que regresa el número de 1/2's horas en el periodo
if mid_hora = 0 then
	messagebox("DEFINA DIAS de INSCRIPCIÓN","Es necesario tener definidos los dias de inscripción para poder obtener el número de alumnos por bloque")
else
	variacion_mid	=	mid_hora/3
	em_total1.text	=	string(round(((long(mid(text,1,2))*.01)*ds_alumnos.rowcount())/variacion_mid,0))
end if
end event

event rbuttondown;triggerevent(modified!)
end event

type st_4 from statictext within w_establece_criterio_asignacion
int X=1646
int Y=1072
int Width=377
int Height=61
boolean Enabled=false
string Text="Asignando para:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=15793151
long BackColor=10789024
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_hora_actual from statictext within w_establece_criterio_asignacion
int X=2022
int Y=1062
int Width=289
int Height=77
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="07:00:00"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_cont from statictext within w_establece_criterio_asignacion
int X=2527
int Y=1373
int Width=358
int Height=70
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="2 -10000"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_establece_criterio_asignacion
int X=2560
int Y=1309
int Width=293
int Height=58
boolean Enabled=false
string Text="Asignados"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=15793151
long BackColor=10789024
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_limpiar from commandbutton within w_establece_criterio_asignacion
event clicked pbm_bnclicked
event constructor pbm_constructor
int X=1415
int Y=541
int Width=274
int Height=74
int TabOrder=60
boolean Enabled=false
boolean BringToTop=true
string Text="Limpiar"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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

type cb_eliminar from commandbutton within w_establece_criterio_asignacion
event clicked pbm_bnclicked
event constructor pbm_constructor
int X=1415
int Y=410
int Width=274
int Height=74
int TabOrder=50
boolean Enabled=false
boolean BringToTop=true
string Text="Eliminar"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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

type cb_insertar from commandbutton within w_establece_criterio_asignacion
int X=1415
int Y=278
int Width=274
int Height=74
int TabOrder=40
string Text="Insertar"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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

type lb_dias_inscripcion from listbox within w_establece_criterio_asignacion
int X=1829
int Y=96
int Width=1009
int Height=582
int TabOrder=90
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean Sorted=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_agregar from commandbutton within w_establece_criterio_asignacion
int X=1415
int Y=144
int Width=274
int Height=74
int TabOrder=30
string Text="Agregar "
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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

type em_hora_fin from editmask within w_establece_criterio_asignacion
int X=1006
int Y=454
int Width=274
int Height=83
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
string Mask="hh:mm:ss"
MaskDataType MaskDataType=TimeMask!
string DisplayData=""
string Text="18:00"
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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

type em_hora_ini from editmask within w_establece_criterio_asignacion
int X=1013
int Y=138
int Width=274
int Height=83
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string Mask="hh:mm:ss"
MaskDataType MaskDataType=TimeMask!
string DisplayData=""
string Text="8:00"
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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

type st_2 from statictext within w_establece_criterio_asignacion
int X=944
int Y=362
int Width=402
int Height=64
boolean Enabled=false
string Text="Ultima Hora"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=15793151
long BackColor=10789024
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_establece_criterio_asignacion
int X=940
int Y=58
int Width=402
int Height=64
boolean Enabled=false
string Text="Primera Hora"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=15793151
long BackColor=10789024
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_ejecuta from commandbutton within w_establece_criterio_asignacion
int X=1627
int Y=1370
int Width=878
int Height=77
int TabOrder=80
boolean Enabled=false
string Text="Asigna Horarios  de Inscripción"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long total_alumnos,bloques,cuenta,limit
int mid_hora,cont,cnt,dias,variacion_mid,fila,cont1,alumno,sobr,ultimo
//real porcent
datetime hora_insc
string error_asigna
integer archivo
archivo	=	FileOpen("c:\contesc\errores_asigna_horario.log",linemode!,Write!,Lockwrite!,Replace!)

if band_porc = 1 and cbx_predeterminados.checked = false then
	if messagebox("AVISO, ASIGNACIÓN PREDETERMINADA","No presiono el boton ACEPTAR para utilizar sus porcentajes~r¿CONTINUAR?",Question!,yesno!,2) = 2 then
		return 0
	else
		cbx_predeterminados.triggerevent(clicked!)	
		cbx_predeterminados.checked = true
	end if
end if

DELETE FROM horario_insc  ;

setpointer(HourGlass!)
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
				INSERT INTO horario_insc  
								( cuenta,   
								  hora_entrada,
								  lugar_fila)  
					VALUES ( :cuenta,   
								  :hora_insc,
								  :fila)  ;
			if sqlca.sqlcode	=	0 then
//				commit;
				st_cont.text =string(cont1)+" - "+string(total_alumnos)
			else
				//se reportaran en un listado los errores
				error_asigna	="CUENTA: "+string(cuenta)+"~t HORA_ENTRADA: "+string(hora_insc)+"~t Lugar en la fila: "+string(fila)+"~rERROR: "+sqlca.sqlerrtext
				FileWrite(archivo,error_asigna)
				messagebox("ERROR",error_asigna)
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



commit;
fileclose(archivo)
messagebox("FINALIZADA LA ASIGNACIÓN","Se termino de efectuar la asignación de horarios de reinscripción")

if rb_altas.checked = true then
	genera_archivo_rangos()
end if


end event

type gb_1 from groupbox within w_establece_criterio_asignacion
int X=2381
int Y=912
int Width=494
int Height=240
int TabOrder=70
string Text="Asignación para:"
long TextColor=16777215
long BackColor=10789024
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_porcent from groupbox within w_establece_criterio_asignacion
int X=66
int Y=963
int Width=1156
int Height=518
string Text="Porcentaje por Bloque de Inscripción"
long TextColor=16777215
long BackColor=10789024
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_disponibilidad from groupbox within w_establece_criterio_asignacion
int X=51
int Y=10
int Width=1368
int Height=704
boolean Visible=false
string Text="Selección de Horarios de Reinscripción"
long TextColor=16777215
long BackColor=10789024
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_seleccionados from groupbox within w_establece_criterio_asignacion
int X=1796
int Y=10
int Width=1079
int Height=704
string Text="Dias de Reinscripción Seleccionados"
long TextColor=16777215
long BackColor=10789024
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

