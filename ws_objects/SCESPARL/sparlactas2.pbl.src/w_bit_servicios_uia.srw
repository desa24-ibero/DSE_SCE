$PBExportHeader$w_bit_servicios_uia.srw
forward
global type w_bit_servicios_uia from w_main
end type
type rb_todos_alumnos from radiobutton within w_bit_servicios_uia
end type
type rb_solo_alumno from radiobutton within w_bit_servicios_uia
end type
type uo_nombre from uo_nombre_alumno within w_bit_servicios_uia
end type
type st_2 from statictext within w_bit_servicios_uia
end type
type st_1 from statictext within w_bit_servicios_uia
end type
type em_fecha_final from u_em within w_bit_servicios_uia
end type
type em_fecha_inicial from u_em within w_bit_servicios_uia
end type
type gb_1 from groupbox within w_bit_servicios_uia
end type
type dw_bitacora from u_dw_captura within w_bit_servicios_uia
end type
type gb_2 from groupbox within w_bit_servicios_uia
end type
end forward

global type w_bit_servicios_uia from w_main
integer width = 4027
integer height = 1976
string title = "Accesos a Servicios en Línea"
string menuname = "m_menu"
windowstate windowstate = maximized!
rb_todos_alumnos rb_todos_alumnos
rb_solo_alumno rb_solo_alumno
uo_nombre uo_nombre
st_2 st_2
st_1 st_1
em_fecha_final em_fecha_final
em_fecha_inicial em_fecha_inicial
gb_1 gb_1
dw_bitacora dw_bitacora
gb_2 gb_2
end type
global w_bit_servicios_uia w_bit_servicios_uia

type variables
long il_num_tramites_inicial, il_num_tramites_final, il_cuenta= 0
u_pipeline_control iu_pipeline_control, iu_pipeline_control02
n_tr i_tr_origen, i_tr_destino
boolean ib_usuario_especial=false

st_confirma_usuario ist_confirma_usuario
transaction itr_web

end variables

forward prototypes
public function integer wf_conectabd ()
end prototypes

public function integer wf_conectabd ();//wf_conectaBD
//Realiza las conexiones de origen y destino la conexion 
//destino ya existe y es la del usuario firmado
integer li_confirma, li_codigo_retorno
string ls_resultado


li_confirma = 1

IF li_confirma <> 1 THEN
	RETURN 0
ELSE
	Open(w_confirma_usuario)
	ist_confirma_usuario = Message.PowerObjectParm
	if isvalid(i_tr_destino) then
		DESTROY i_tr_destino		
	end if	
   IF conecta_bd(i_tr_destino,gs_sweb, ist_confirma_usuario.usuario, ist_confirma_usuario.password)<>1 then
   	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
 		RETURN -1
	END IF
END IF
i_tr_origen = gtr_sce

il_num_tramites_inicial = f_obten_numero_tramites_web(9999, i_tr_destino)

//li_codigo_retorno = iu_pipeline_control.Start(i_tr_origen, i_tr_destino, dw_resultado)

if li_codigo_retorno <0 then
   ls_resultado= iu_pipeline_control.of_resultado(li_codigo_retorno)
	Messagebox("Error en Pipeline", ls_resultado,StopSign!)
	return -1
else 
	il_num_tramites_final = f_obten_numero_tramites_web(9999,i_tr_destino)	

//	li_codigo_retorno = iu_pipeline_control02.Start(i_tr_origen, i_tr_destino, dw_resultado)

	if li_codigo_retorno <0 then
	   ls_resultado= iu_pipeline_control02.of_resultado(li_codigo_retorno)
		Messagebox("Error en Pipeline", ls_resultado,StopSign!)
		return -1
	else 
	   IF desconecta_bd(i_tr_destino)<>1 then
   		MessageBox("Error al desconectar", "No es posible desconectarse de la base del WEB", StopSign!)
	 		RETURN -1
		END IF
	end if 
end if



return 0
end function

on w_bit_servicios_uia.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.rb_todos_alumnos=create rb_todos_alumnos
this.rb_solo_alumno=create rb_solo_alumno
this.uo_nombre=create uo_nombre
this.st_2=create st_2
this.st_1=create st_1
this.em_fecha_final=create em_fecha_final
this.em_fecha_inicial=create em_fecha_inicial
this.gb_1=create gb_1
this.dw_bitacora=create dw_bitacora
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_todos_alumnos
this.Control[iCurrent+2]=this.rb_solo_alumno
this.Control[iCurrent+3]=this.uo_nombre
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.em_fecha_final
this.Control[iCurrent+7]=this.em_fecha_inicial
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.dw_bitacora
this.Control[iCurrent+10]=this.gb_2
end on

on w_bit_servicios_uia.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_todos_alumnos)
destroy(this.rb_solo_alumno)
destroy(this.uo_nombre)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_fecha_final)
destroy(this.em_fecha_inicial)
destroy(this.gb_1)
destroy(this.dw_bitacora)
destroy(this.gb_2)
end on

event open;call super::open;datetime ldttm_fecha_servidor, ldttm_fecha_inicial

x=1
y=1

iu_pipeline_control =  create u_pipeline_control
iu_pipeline_control.dataobject  = "dp_estado_alumno_tramite"

iu_pipeline_control02 =  create u_pipeline_control
iu_pipeline_control02.dataobject= "dp_solicitud_tramite"

//dw_resultado.SettransObject(gtr_sce)

ldttm_fecha_servidor = fecha_servidor(gtr_sce)
ldttm_fecha_inicial = datetime(date("1-feb-2006"))

em_fecha_inicial.text = string(ldttm_fecha_inicial,"dd/mm/yyyy")
em_fecha_final.text =  string(ldttm_fecha_servidor,"dd/mm/yyyy")


if conecta_bd(itr_web,"WEB_DESB", "scedesbloqueo","ventdesb06")<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	close(this)
else 
	dw_bitacora.SetTransObject(itr_web)
end if

ib_usuario_especial = f_usuario_especial(gs_usuario) 

if ib_usuario_especial then
	MessageBox("Bienvenido", "Su usuario es de acceso especial", Information!)
end if
end event

event close;call super::close;if isvalid(iu_pipeline_control) then
	destroy iu_pipeline_control
end if


if isvalid(iu_pipeline_control02) then
	destroy iu_pipeline_control02
end if


if isvalid(itr_web) then
	if desconecta_bd(itr_web) <> 1 then
		return
	end if
end if
end event

event doubleclicked;call super::doubleclicked;long cuentalocal
int carrera,plan
//char nivel

 
long ll_row, ll_cuenta

ll_row = uo_nombre.dw_nombre_alumno.GetRow()
ll_cuenta = uo_nombre.dw_nombre_alumno.GetItemNumber(ll_row, "cuenta")

if f_alumno_restringido (ll_cuenta) then
	if ib_usuario_especial then
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
		il_cuenta = 0
		return		
	end if
end if

il_cuenta = ll_cuenta


end event

type rb_todos_alumnos from radiobutton within w_bit_servicios_uia
integer x = 1129
integer y = 624
integer width = 558
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Todos los Alumno"
end type

event clicked;//dw_bitacora.dataobject = "d_bit_acceso_uia"
//dw_bitacora.SetTransObject(itr_web)

il_cuenta = 9999999
end event

type rb_solo_alumno from radiobutton within w_bit_servicios_uia
integer x = 1129
integer y = 524
integer width = 608
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo Alumno Actual"
boolean checked = true
end type

event clicked;//dw_bitacora.dataobject = "d_bit_acceso_uia"
//dw_bitacora.SetTransObject(itr_web)

long cuentalocal
int carrera,plan
//char nivel

 
long ll_row, ll_cuenta

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
		il_cuenta = 0
		return		
	end if
end if

il_cuenta = ll_cuenta


end event

type uo_nombre from uo_nombre_alumno within w_bit_servicios_uia
integer x = 18
integer y = 16
integer taborder = 10
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

type st_2 from statictext within w_bit_servicios_uia
integer x = 50
integer y = 636
integer width = 302
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha Final:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_bit_servicios_uia
integer x = 50
integer y = 540
integer width = 302
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha Inicial:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fecha_final from u_em within w_bit_servicios_uia
integer x = 370
integer y = 624
integer width = 352
integer height = 84
integer taborder = 30
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy "
end type

type em_fecha_inicial from u_em within w_bit_servicios_uia
integer x = 370
integer y = 524
integer width = 352
integer height = 84
integer taborder = 20
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy "
end type

type gb_1 from groupbox within w_bit_servicios_uia
integer x = 23
integer y = 460
integer width = 896
integer height = 288
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Periodo Consulta"
end type

type dw_bitacora from u_dw_captura within w_bit_servicios_uia
integer y = 772
integer width = 3854
integer height = 996
integer taborder = 40
string dataobject = "d_bit_acceso_uia"
boolean hscrollbar = true
boolean resizable = true
end type

event retrieveend;call super::retrieveend;datetime ldttm_fecha_servidor
string ls_fecha_servidor

if this.rowcount()>0 then
	ldttm_fecha_servidor = fecha_servidor(gtr_sce)
	ls_fecha_servidor = string(ldttm_fecha_servidor)
	this.object.t_fecha_servidor.text = ls_fecha_servidor
end if

end event

event carga;string ls_fecha_inicial, ls_fecha_final
date ldt_fecha_inicial, ldt_fecha_final
datetime ldttm_fecha_inicial, ldttm_fecha_final
integer li_num_registros 

if isnull(this.DataObject) then
	return 0
end if

ls_fecha_inicial= em_fecha_inicial.text
ls_fecha_final= em_fecha_final.text

ldt_fecha_inicial =date(ls_fecha_inicial)
ldt_fecha_final =date(ls_fecha_final)

if ldt_fecha_final < ldt_fecha_inicial then
	MessageBox("Error de fechas","La fecha inicial no debe ser mayor a la fecha final")
end if 

ldt_fecha_final= RelativeDate(ldt_fecha_final, +1)

ldttm_fecha_inicial =datetime(ldt_fecha_inicial)
ldttm_fecha_final =datetime(ldt_fecha_final)

li_num_registros = retrieve(il_cuenta, ldttm_fecha_inicial, ldttm_fecha_final)

if li_num_registros = 0 then
	MessageBox ("Sin Registros", "No existe información bajo esos criterios",StopSign!)	
end if

return li_num_registros




end event

type gb_2 from groupbox within w_bit_servicios_uia
integer x = 1083
integer y = 460
integer width = 896
integer height = 288
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo de Consulta"
end type

