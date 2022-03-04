$PBExportHeader$w_revisa_nip_hora_2013.srw
$PBExportComments$Despliegue de datos academicos de un alumno (Carrera, Semestre, Subsistema, Fecha de Ingreso, Fecha de Egreso,.....)
forward
global type w_revisa_nip_hora_2013 from w_master_main
end type
type uo_nombre from uo_nombre_alumno_2013 within w_revisa_nip_hora_2013
end type
type st_1 from statictext within w_revisa_nip_hora_2013
end type
type p_hora from picture within w_revisa_nip_hora_2013
end type
type st_2 from statictext within w_revisa_nip_hora_2013
end type
type p_documentos from picture within w_revisa_nip_hora_2013
end type
type st_3 from statictext within w_revisa_nip_hora_2013
end type
type p_biblioteca from picture within w_revisa_nip_hora_2013
end type
type st_4 from statictext within w_revisa_nip_hora_2013
end type
type p_finanzas from picture within w_revisa_nip_hora_2013
end type
type st_5 from statictext within w_revisa_nip_hora_2013
end type
type p_laboratorio from picture within w_revisa_nip_hora_2013
end type
type st_laboratorio from statictext within w_revisa_nip_hora_2013
end type
type st_diagnostico from statictext within w_revisa_nip_hora_2013
end type
type oval_semaforo from oval within w_revisa_nip_hora_2013
end type
type p_nip from picture within w_revisa_nip_hora_2013
end type
type st_fecha from statictext within w_revisa_nip_hora_2013
end type
end forward

global type w_revisa_nip_hora_2013 from w_master_main
integer x = 5
integer y = 4
integer width = 4238
integer height = 2704
string title = "Revisión de NIP y hora de entrada"
string menuname = "m_menu_constancias_2013"
boolean center = true
uo_nombre uo_nombre
st_1 st_1
p_hora p_hora
st_2 st_2
p_documentos p_documentos
st_3 st_3
p_biblioteca p_biblioteca
st_4 st_4
p_finanzas p_finanzas
st_5 st_5
p_laboratorio p_laboratorio
st_laboratorio st_laboratorio
st_diagnostico st_diagnostico
oval_semaforo oval_semaforo
p_nip p_nip
st_fecha st_fecha
end type
global w_revisa_nip_hora_2013 w_revisa_nip_hora_2013

type variables
int ii_anio, ii_periodo
n_tr itr_sfeb
long il_cuenta
end variables

forward prototypes
public function integer revisa_hora (long al_cuenta, ref datetime adt_fecha)
end prototypes

public function integer revisa_hora (long al_cuenta, ref datetime adt_fecha);/*
 *		Nombre	revisa_hora
 *		Recibe	al_cuenta, adt_fecha
 *		Regresa	1	si el alumno con cuenta al_cuenta esta entrando no mas de una hora antes,
 *						modifica el valor de adt_fecha con la fecha que corresponde al alumno al_cuenta
 *					0	si el alumno con cuenta al_cuenta esta entrando mas de una hora antes
 *						modifica el valor de adt_fecha con la fecha que corresponde al alumno al_cuenta
 *					-2	el alumno al_cuenta no tiene horario para inscribirse
 *					-1	error de comunicacion
 *					FMC12041999
 */
 
DataStore lds_hora_entrada
DateTime ldt_hora_real, ldt_diferencia
int li_res, li_ret
long ll_res
lds_hora_entrada = Create DataStore
lds_hora_entrada.DataObject = "d_hora_entrada"
lds_hora_entrada.SetTransObject(gtr_sce)
li_res = lds_hora_entrada.Retrieve(al_cuenta)
choose case li_res
	case 1
		adt_fecha = lds_hora_entrada.GetItemDateTime(1,"hora_entrada")
		ldt_hora_real = lds_hora_entrada.GetItemDateTime(1,"hora_real")
		ll_res = daysafter(date(ldt_hora_real),date(adt_fecha))
		if ll_res > 0 then
			li_ret = 0
		elseif ll_res < 0 then
			li_ret = 1
		else
			ll_res = secondsafter(time(ldt_hora_real),time(adt_fecha))
			if ll_res > 3600 then
				li_ret = 0
			else
				li_ret = 1
			end if
		end if
	case 0
		messagebox("No tiene horario","El alumno no tiene horario para inscribirse.",Exclamation!)
		li_ret = -2
	case else
		messagebox("Error de Comunicación","Error con la consulta de horario BD. Favor de intentar nuevamente", None!)
		li_ret = -1
end choose
Destroy lds_hora_entrada
return li_ret
end function

on w_revisa_nip_hora_2013.create
int iCurrent
call super::create
if this.MenuName = "m_menu_constancias_2013" then this.MenuID = create m_menu_constancias_2013
this.uo_nombre=create uo_nombre
this.st_1=create st_1
this.p_hora=create p_hora
this.st_2=create st_2
this.p_documentos=create p_documentos
this.st_3=create st_3
this.p_biblioteca=create p_biblioteca
this.st_4=create st_4
this.p_finanzas=create p_finanzas
this.st_5=create st_5
this.p_laboratorio=create p_laboratorio
this.st_laboratorio=create st_laboratorio
this.st_diagnostico=create st_diagnostico
this.oval_semaforo=create oval_semaforo
this.p_nip=create p_nip
this.st_fecha=create st_fecha
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_nombre
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.p_hora
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.p_documentos
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.p_biblioteca
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.p_finanzas
this.Control[iCurrent+10]=this.st_5
this.Control[iCurrent+11]=this.p_laboratorio
this.Control[iCurrent+12]=this.st_laboratorio
this.Control[iCurrent+13]=this.st_diagnostico
this.Control[iCurrent+14]=this.oval_semaforo
this.Control[iCurrent+15]=this.p_nip
this.Control[iCurrent+16]=this.st_fecha
end on

on w_revisa_nip_hora_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nombre)
destroy(this.st_1)
destroy(this.p_hora)
destroy(this.st_2)
destroy(this.p_documentos)
destroy(this.st_3)
destroy(this.p_biblioteca)
destroy(this.st_4)
destroy(this.p_finanzas)
destroy(this.st_5)
destroy(this.p_laboratorio)
destroy(this.st_laboratorio)
destroy(this.st_diagnostico)
destroy(this.oval_semaforo)
destroy(this.p_nip)
destroy(this.st_fecha)
end on

event close;if (desconecta_bd(gtr_scred) = 1) then
	//OK 
else
	MessageBox("Desconexión inválida","No es posible desconectarse de la base de datos de credenciales",StopSign!)
end if


end event

event open;call super::open;DataStore lds_activacion

itr_sfeb = CREATE n_tr

if isnull(gi_numscob) OR not (isvalid(gtr_scob)) then gi_numscob = 0
if gi_numscob <= 0 then
	if conecta_bd_n_tr(gtr_scob,gs_scob,gs_usuario,gs_password)<>1 then
		MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de cobranzas", StopSign!)
		close(this)
	end if
end if
gi_numscob++

IF IsValid(This) THEN 
	IF conecta_bd_n_tr(itr_sfeb,gs_sfeb,gs_usuario,gs_password) = 0 THEN
		messagebox("Error de Comunicación","Error al conectar a becas BD. Favor de intentar nuevamente", None!)
		close(this)
		return
	END IF
	
	IF IsValid(This) THEN 
		lds_activacion = Create DataStore
		lds_activacion.DataObject = "d_activacion"
		lds_activacion.SetTransObject(gtr_sce)
		IF lds_activacion.Retrieve() = 1 THEN
			ii_anio = lds_activacion.GetItemNumber(1,"anio")
			ii_periodo = lds_activacion.GetItemNumber(1,"periodo")
		ELSE
			messagebox("Error de Comunicación","Error con la consulta de activacion BD. Favor de intentar nuevamente", None!)
			close(this)
			return
		END IF
	END IF
END IF
end event

event closequery;//
end event

event doubleclicked;call super::doubleclicked;int li_res
int li_nip, li_hora, li_documentos, li_biblioteca, li_finanzas, li_baja_laboratorio
datetime ldt_fecha
DataStore lds_banderas_por_cuenta
lds_banderas_por_cuenta = Create DataStore
lds_banderas_por_cuenta.DataObject = "d_banderas_por_cuenta_nip_hora"
lds_banderas_por_cuenta.SetTransObject(gtr_sce)

il_cuenta = uo_nombre.of_obten_cuenta()

SetPointer(HourGlass!)
st_diagnostico.text = "Procesando..."
//	Amarillo
oval_semaforo.Fillcolor = RGB(255,255,0)

li_res= 1
if li_res = 1 then
	li_nip = 1
	p_nip.PictureName = "Paloma_2.bmp"
else
	li_nip = 0
	p_nip.PictureName = "tache_2.bmp"
end if
li_res = revisa_hora(il_cuenta,ldt_fecha)
if li_res = 1 then
	li_hora = 1
	p_hora.PictureName = "Paloma_2.bmp"
else
	li_hora = 0
	p_hora.PictureName = "tache_2.bmp"
end if
	
li_res = lds_banderas_por_cuenta.Retrieve(il_cuenta)
if li_res = 1 then
	li_documentos = lds_banderas_por_cuenta.GetItemNumber(1,"baja_documentos")
	if li_documentos = 1 then
		li_documentos = 0
	else
		li_documentos = 1
	end if
	li_biblioteca = lds_banderas_por_cuenta.GetItemNumber(1,"cve_flag_biblioteca")
	if li_biblioteca = 0 then
		li_biblioteca = 1
	else
		li_biblioteca = 0
	end if
	
	li_baja_laboratorio= lds_banderas_por_cuenta.GetItemNumber(1,"baja_laboratorio")
	if li_baja_laboratorio = 1 then
		li_baja_laboratorio = 0
	else
		li_baja_laboratorio = 1
	end if
	
	li_finanzas = lds_banderas_por_cuenta.GetItemNumber(1,"adeuda_finanzas")
	if li_finanzas = 1 then
		if ( (tiene_adeudos_n_tr(il_cuenta,gtr_scob) = 0) AND &
			( (pago_inscripcion_n_tr(il_cuenta, ii_anio ,ii_periodo, gtr_scob) = 1) OR (tiene_beca_n_tr(il_cuenta,ii_anio,ii_periodo, itr_sfeb) = 100) )) then
			li_finanzas = 1
		else
			li_finanzas = 0
		end if
	else
		li_finanzas = 1
	end if
else
	li_documentos = 0
	li_biblioteca = 0
	li_finanzas = 0
	li_baja_laboratorio = 0
	messagebox("Error de Comunicación","Error con la consulta de banderas BD. Favor de intentar nuevamente", None!)
end if
if li_documentos = 1 then
	p_documentos.PictureName = "Paloma_2.bmp"
else
	p_documentos.PictureName = "tache_2.bmp"
end if
if li_biblioteca = 1 then
	p_biblioteca.PictureName = "Paloma_2.bmp"
else
	p_biblioteca.PictureName = "tache_2.bmp"
end if
if li_finanzas = 1 then
	p_finanzas.PictureName = "Paloma_2.bmp"
else
	p_finanzas.PictureName = "tache_2.bmp"
end if
if li_baja_laboratorio = 1 then
	p_laboratorio.PictureName = "Paloma_2.bmp"
else
	p_laboratorio.PictureName = "tache_2.bmp"
end if
	
if li_nip= 1 and li_hora = 1 and li_documentos = 1 and li_biblioteca = 1 and li_finanzas = 1 and li_baja_laboratorio=1 then
	st_diagnostico.text = "¡Adelante!"
//Verde
	oval_semaforo.Fillcolor = RGB(0,255,0)
else
	st_diagnostico.text = "¡Alto!, El alumno no puede pasar"
//Rojo
	oval_semaforo.FillColor = RGB(255,0,0)
	beep(10)
end if
uo_nombre.em_cuenta.SetFocus()
st_fecha.text = string(ldt_fecha,"dd/mm/yyyy hh:mm")
end event

type st_sistema from w_master_main`st_sistema within w_revisa_nip_hora_2013
end type

type p_ibero from w_master_main`p_ibero within w_revisa_nip_hora_2013
end type

type uo_nombre from uo_nombre_alumno_2013 within w_revisa_nip_hora_2013
event destroy ( )
integer x = 73
integer y = 328
integer taborder = 30
boolean bringtotop = true
end type

on uo_nombre.destroy
call uo_nombre_alumno_2013::destroy
end on

event constructor;call super::constructor;m_menu_constancias_2013.objeto = this
end event

type st_1 from statictext within w_revisa_nip_hora_2013
integer x = 1097
integer y = 720
integer width = 585
integer height = 112
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 553648127
boolean enabled = false
string text = "NIP "
long bordercolor = 30451536
boolean focusrectangle = false
end type

type p_hora from picture within w_revisa_nip_hora_2013
integer x = 923
integer y = 836
integer width = 146
integer height = 128
boolean bringtotop = true
string picturename = "tache_2.bmp"
boolean focusrectangle = false
end type

type st_2 from statictext within w_revisa_nip_hora_2013
integer x = 1097
integer y = 844
integer width = 585
integer height = 112
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
boolean enabled = false
string text = "Hora entrada "
long bordercolor = 30451536
boolean focusrectangle = false
end type

type p_documentos from picture within w_revisa_nip_hora_2013
integer x = 923
integer y = 972
integer width = 146
integer height = 128
boolean bringtotop = true
string picturename = "tache_2.bmp"
boolean focusrectangle = false
end type

type st_3 from statictext within w_revisa_nip_hora_2013
integer x = 1097
integer y = 984
integer width = 1440
integer height = 112
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
boolean enabled = false
string text = "Documentos Servicios Escolares"
long bordercolor = 30451536
boolean focusrectangle = false
end type

type p_biblioteca from picture within w_revisa_nip_hora_2013
integer x = 923
integer y = 1112
integer width = 146
integer height = 128
boolean bringtotop = true
string picturename = "tache_2.bmp"
boolean focusrectangle = false
end type

type st_4 from statictext within w_revisa_nip_hora_2013
integer x = 1097
integer y = 1120
integer width = 585
integer height = 112
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
boolean enabled = false
string text = "Biblioteca"
long bordercolor = 30451536
boolean focusrectangle = false
end type

type p_finanzas from picture within w_revisa_nip_hora_2013
integer x = 923
integer y = 1248
integer width = 146
integer height = 128
boolean bringtotop = true
string picturename = "tache_2.bmp"
boolean focusrectangle = false
end type

type st_5 from statictext within w_revisa_nip_hora_2013
integer x = 1097
integer y = 1260
integer width = 585
integer height = 112
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
boolean enabled = false
string text = "Finanzas"
long bordercolor = 30451536
boolean focusrectangle = false
end type

type p_laboratorio from picture within w_revisa_nip_hora_2013
integer x = 923
integer y = 1388
integer width = 146
integer height = 128
boolean bringtotop = true
string picturename = "tache_2.bmp"
boolean focusrectangle = false
end type

type st_laboratorio from statictext within w_revisa_nip_hora_2013
integer x = 1097
integer y = 1396
integer width = 699
integer height = 112
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
boolean enabled = false
string text = "Laboratorio"
long bordercolor = 30451536
boolean focusrectangle = false
end type

type st_diagnostico from statictext within w_revisa_nip_hora_2013
integer x = 87
integer y = 1576
integer width = 2496
integer height = 176
boolean bringtotop = true
integer textsize = -22
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
boolean enabled = false
string text = "¡Alto!, El alumno no puede pasar"
long bordercolor = 30451536
boolean focusrectangle = false
end type

type oval_semaforo from oval within w_revisa_nip_hora_2013
long linecolor = 8421504
integer linethickness = 10
long fillcolor = 255
integer x = 73
integer y = 768
integer width = 741
integer height = 612
end type

type p_nip from picture within w_revisa_nip_hora_2013
integer x = 923
integer y = 700
integer width = 146
integer height = 128
string picturename = "tache_2.bmp"
boolean focusrectangle = false
end type

type st_fecha from statictext within w_revisa_nip_hora_2013
integer x = 1819
integer y = 720
integer width = 1733
integer height = 180
boolean bringtotop = true
integer textsize = -26
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
boolean enabled = false
long bordercolor = 30451536
boolean focusrectangle = false
end type

