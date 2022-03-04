$PBExportHeader$w_revisa_nip_hora.srw
forward
global type w_revisa_nip_hora from w_ancestral
end type
type uo_nombre from uo_nombre_alumno within w_revisa_nip_hora
end type
type st_1 from statictext within w_revisa_nip_hora
end type
type st_2 from statictext within w_revisa_nip_hora
end type
type st_diagnostico from statictext within w_revisa_nip_hora
end type
type p_nip from picture within w_revisa_nip_hora
end type
type p_hora from picture within w_revisa_nip_hora
end type
type st_fecha from statictext within w_revisa_nip_hora
end type
type p_documentos from picture within w_revisa_nip_hora
end type
type p_biblioteca from picture within w_revisa_nip_hora
end type
type p_finanzas from picture within w_revisa_nip_hora
end type
type st_3 from statictext within w_revisa_nip_hora
end type
type st_4 from statictext within w_revisa_nip_hora
end type
type st_5 from statictext within w_revisa_nip_hora
end type
type oval_semaforo from oval within w_revisa_nip_hora
end type
type p_laboratorio from picture within w_revisa_nip_hora
end type
type st_laboratorio from statictext within w_revisa_nip_hora
end type
end forward

global type w_revisa_nip_hora from w_ancestral
integer width = 3717
integer height = 1596
string title = "Revisión de NIP y hora de entrada"
string menuname = "m_menu"
long backcolor = 30451536
uo_nombre uo_nombre
st_1 st_1
st_2 st_2
st_diagnostico st_diagnostico
p_nip p_nip
p_hora p_hora
st_fecha st_fecha
p_documentos p_documentos
p_biblioteca p_biblioteca
p_finanzas p_finanzas
st_3 st_3
st_4 st_4
st_5 st_5
oval_semaforo oval_semaforo
p_laboratorio p_laboratorio
st_laboratorio st_laboratorio
end type
global w_revisa_nip_hora w_revisa_nip_hora

type variables
int ii_anio, ii_periodo
n_tr itr_sfeb
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

on w_revisa_nip_hora.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_nombre=create uo_nombre
this.st_1=create st_1
this.st_2=create st_2
this.st_diagnostico=create st_diagnostico
this.p_nip=create p_nip
this.p_hora=create p_hora
this.st_fecha=create st_fecha
this.p_documentos=create p_documentos
this.p_biblioteca=create p_biblioteca
this.p_finanzas=create p_finanzas
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.oval_semaforo=create oval_semaforo
this.p_laboratorio=create p_laboratorio
this.st_laboratorio=create st_laboratorio
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_nombre
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_diagnostico
this.Control[iCurrent+5]=this.p_nip
this.Control[iCurrent+6]=this.p_hora
this.Control[iCurrent+7]=this.st_fecha
this.Control[iCurrent+8]=this.p_documentos
this.Control[iCurrent+9]=this.p_biblioteca
this.Control[iCurrent+10]=this.p_finanzas
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.st_4
this.Control[iCurrent+13]=this.st_5
this.Control[iCurrent+14]=this.oval_semaforo
this.Control[iCurrent+15]=this.p_laboratorio
this.Control[iCurrent+16]=this.st_laboratorio
end on

on w_revisa_nip_hora.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nombre)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_diagnostico)
destroy(this.p_nip)
destroy(this.p_hora)
destroy(this.st_fecha)
destroy(this.p_documentos)
destroy(this.p_biblioteca)
destroy(this.p_finanzas)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.oval_semaforo)
destroy(this.p_laboratorio)
destroy(this.st_laboratorio)
end on

event open;call super::open;DataStore lds_activacion

uo_nombre.r_1.FillColor = RGB(80, 167, 208)
uo_nombre.dw_nombre_alumno.object.datawindow.color = RGB(80, 167, 208)

itr_sfeb = CREATE n_tr

if isnull(gi_numscob) OR not (isvalid(gtr_scob)) then gi_numscob = 0
if gi_numscob <= 0 then
	if conecta_bd_n_tr(gtr_scob,gs_scob,gs_usuario,gs_password)<>1 then
		MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de cobranzas", StopSign!)
		close(this)
	end if
end if
gi_numscob++


if conecta_bd_n_tr(itr_sfeb,gs_sfeb,gs_usuario,gs_password) = 0 then
	messagebox("Error de Comunicación","Error al conectar a becas BD. Favor de intentar nuevamente", None!)
	close(this)
	return
end if

lds_activacion = Create DataStore
lds_activacion.DataObject = "d_activacion"
lds_activacion.SetTransObject(gtr_sce)
if lds_activacion.Retrieve() = 1 then
	ii_anio = lds_activacion.GetItemNumber(1,"anio")
	ii_periodo = lds_activacion.GetItemNumber(1,"periodo")
else
	messagebox("Error de Comunicación","Error con la consulta de activacion BD. Favor de intentar nuevamente", None!)
	close(this)
	return
end if



end event

event inicia_proceso;long ll_cuenta
int li_res
int li_nip, li_hora, li_documentos, li_biblioteca, li_finanzas, li_baja_laboratorio
datetime ldt_fecha
DataStore lds_banderas_por_cuenta
lds_banderas_por_cuenta = Create DataStore
lds_banderas_por_cuenta.DataObject = "d_banderas_por_cuenta_nip_hora"
lds_banderas_por_cuenta.SetTransObject(gtr_sce)

	SetPointer(HourGlass!)
	st_diagnostico.text = "Procesando..."
//	Amarillo
	oval_semaforo.Fillcolor = RGB(255,255,0)


ll_cuenta = long(uo_nombre.em_cuenta.text)
//	OpenWithParm(w_pregunta_nip,uo_nombre.em_cuenta.text+"@"+uo_nombre.dw_nombre_alumno.getitemstring(1,"nombre")+&
//	" "+uo_nombre.dw_nombre_alumno.getitemstring(1,"apaterno")+&
//	" "+uo_nombre.dw_nombre_alumno.getitemstring(1,"amaterno"))
//	li_res = Message.DoubleParm
	
	
	li_res= 1
	if li_res = 1 then
		li_nip = 1
		p_nip.PictureName = "Paloma.bmp"
	else
		li_nip = 0
		p_nip.PictureName = "tache.bmp"
	end if
	li_res = revisa_hora(ll_cuenta,ldt_fecha)
	if li_res = 1 then
		li_hora = 1
		p_hora.PictureName = "Paloma.bmp"
	else
		li_hora = 0
		p_hora.PictureName = "tache.bmp"
	end if
	
	li_res = lds_banderas_por_cuenta.Retrieve(ll_cuenta)
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
//		li_baja_laboratorio= lds_banderas_por_cuenta.GetItemNumber(1,1)
		if li_baja_laboratorio = 1 then
			li_baja_laboratorio = 0
		else
			li_baja_laboratorio = 1
		end if
		
		
		li_finanzas = lds_banderas_por_cuenta.GetItemNumber(1,"adeuda_finanzas")
		if li_finanzas = 1 then
			if ( (tiene_adeudos_n_tr(ll_cuenta,gtr_scob) = 0) AND &
				( (pago_inscripcion_n_tr(ll_cuenta, ii_anio ,ii_periodo, gtr_scob) = 1) OR (tiene_beca_n_tr(ll_cuenta,ii_anio,ii_periodo, itr_sfeb) = 100) )) then
				li_finanzas = 1
//				lds_banderas_por_cuenta.SetItem(1,"adeuda_finanzas",0)
//				if lds_banderas_por_cuenta.Update() = 1 then
//					commit using gtr_sce;
//				else
//					rollback using gtr_sce;
//					messagebox("Error de Comunicación","Error con la actualizacion de finanzas BD. Favor de intentar nuevamente", None!)
//				end if
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
		p_documentos.PictureName = "Paloma.bmp"
	else
		p_documentos.PictureName = "tache.bmp"
	end if
	if li_biblioteca = 1 then
		p_biblioteca.PictureName = "Paloma.bmp"
	else
		p_biblioteca.PictureName = "tache.bmp"
	end if
	if li_finanzas = 1 then
		p_finanzas.PictureName = "Paloma.bmp"
	else
		p_finanzas.PictureName = "tache.bmp"
	end if
	if li_baja_laboratorio = 1 then
		p_laboratorio.PictureName = "Paloma.bmp"
	else
		p_laboratorio.PictureName = "tache.bmp"
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

event close;
if gi_numscob = 1 then
	if desconecta_bd_n_tr(gtr_scob) <> 1 then
		return
	end if
end if
gi_numscob --
DISCONNECT using itr_sfeb;

DESTROY itr_sfeb


end event

type p_uia from w_ancestral`p_uia within w_revisa_nip_hora
integer x = 14
integer y = 16
integer width = 421
integer height = 364
string picturename = "uia.bmp"
end type

type uo_nombre from uo_nombre_alumno within w_revisa_nip_hora
integer x = 439
integer y = 12
integer height = 428
integer taborder = 1
boolean enabled = true
long backcolor = 30451536
end type

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

type st_1 from statictext within w_revisa_nip_hora
integer x = 951
integer y = 432
integer width = 585
integer height = 112
boolean bringtotop = true
integer textsize = -16
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 30451536
boolean enabled = false
string text = "NIP "
long bordercolor = 30451536
boolean focusrectangle = false
end type

type st_2 from statictext within w_revisa_nip_hora
integer x = 951
integer y = 556
integer width = 585
integer height = 112
boolean bringtotop = true
integer textsize = -16
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 30451536
boolean enabled = false
string text = "Hora entrada "
long bordercolor = 30451536
boolean focusrectangle = false
end type

type st_diagnostico from statictext within w_revisa_nip_hora
integer x = 206
integer y = 1232
integer width = 1993
integer height = 176
boolean bringtotop = true
integer textsize = -22
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 30451536
boolean enabled = false
string text = "¡Alto!, El alumno no puede pasar"
long bordercolor = 30451536
boolean focusrectangle = false
end type

type p_nip from picture within w_revisa_nip_hora
integer x = 777
integer y = 412
integer width = 146
integer height = 128
boolean bringtotop = true
string picturename = "tache.bmp"
boolean focusrectangle = false
end type

type p_hora from picture within w_revisa_nip_hora
integer x = 777
integer y = 548
integer width = 146
integer height = 128
boolean bringtotop = true
string picturename = "tache.bmp"
boolean focusrectangle = false
end type

type st_fecha from statictext within w_revisa_nip_hora
integer x = 1888
integer y = 460
integer width = 1733
integer height = 180
boolean bringtotop = true
integer textsize = -26
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 30451536
boolean enabled = false
long bordercolor = 30451536
boolean focusrectangle = false
end type

type p_documentos from picture within w_revisa_nip_hora
integer x = 777
integer y = 684
integer width = 146
integer height = 128
boolean bringtotop = true
string picturename = "tache.bmp"
boolean focusrectangle = false
end type

type p_biblioteca from picture within w_revisa_nip_hora
integer x = 777
integer y = 824
integer width = 146
integer height = 128
boolean bringtotop = true
string picturename = "tache.bmp"
boolean focusrectangle = false
end type

type p_finanzas from picture within w_revisa_nip_hora
integer x = 777
integer y = 960
integer width = 146
integer height = 128
boolean bringtotop = true
string picturename = "tache.bmp"
boolean focusrectangle = false
end type

type st_3 from statictext within w_revisa_nip_hora
integer x = 951
integer y = 696
integer width = 1440
integer height = 112
boolean bringtotop = true
integer textsize = -16
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 30451536
boolean enabled = false
string text = "Documentos Servicios Escolares"
long bordercolor = 30451536
boolean focusrectangle = false
end type

type st_4 from statictext within w_revisa_nip_hora
integer x = 951
integer y = 832
integer width = 585
integer height = 112
boolean bringtotop = true
integer textsize = -16
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 30451536
boolean enabled = false
string text = "Biblioteca"
long bordercolor = 30451536
boolean focusrectangle = false
end type

type st_5 from statictext within w_revisa_nip_hora
integer x = 951
integer y = 972
integer width = 585
integer height = 112
boolean bringtotop = true
integer textsize = -16
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 30451536
boolean enabled = false
string text = "Finanzas"
long bordercolor = 30451536
boolean focusrectangle = false
end type

type oval_semaforo from oval within w_revisa_nip_hora
long linecolor = 8421504
integer linethickness = 10
long fillcolor = 255
integer x = 23
integer y = 492
integer width = 741
integer height = 612
end type

type p_laboratorio from picture within w_revisa_nip_hora
integer x = 777
integer y = 1100
integer width = 146
integer height = 128
boolean bringtotop = true
string picturename = "tache.bmp"
boolean focusrectangle = false
end type

type st_laboratorio from statictext within w_revisa_nip_hora
integer x = 951
integer y = 1108
integer width = 585
integer height = 112
boolean bringtotop = true
integer textsize = -16
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 30451536
boolean enabled = false
string text = "Laboratorio"
long bordercolor = 30451536
boolean focusrectangle = false
end type

