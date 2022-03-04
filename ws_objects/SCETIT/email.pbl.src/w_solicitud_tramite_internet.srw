$PBExportHeader$w_solicitud_tramite_internet.srw
forward
global type w_solicitud_tramite_internet from w_main
end type
type rb_intentados from radiobutton within w_solicitud_tramite_internet
end type
type rb_solicitados from radiobutton within w_solicitud_tramite_internet
end type
type st_3 from statictext within w_solicitud_tramite_internet
end type
type dw_resultado from u_dw within w_solicitud_tramite_internet
end type
type cb_1 from commandbutton within w_solicitud_tramite_internet
end type
type cb_cargar from u_cb within w_solicitud_tramite_internet
end type
type dw_1 from uo_dw_reporte within w_solicitud_tramite_internet
end type
type st_2 from statictext within w_solicitud_tramite_internet
end type
type st_1 from statictext within w_solicitud_tramite_internet
end type
type em_fecha_final from u_em within w_solicitud_tramite_internet
end type
type em_fecha_inicial from u_em within w_solicitud_tramite_internet
end type
type gb_1 from groupbox within w_solicitud_tramite_internet
end type
type gb_2 from groupbox within w_solicitud_tramite_internet
end type
end forward

global type w_solicitud_tramite_internet from w_main
integer width = 2994
integer height = 1772
string title = "Trámites Solicitados por Internet"
string menuname = "m_menu"
rb_intentados rb_intentados
rb_solicitados rb_solicitados
st_3 st_3
dw_resultado dw_resultado
cb_1 cb_1
cb_cargar cb_cargar
dw_1 dw_1
st_2 st_2
st_1 st_1
em_fecha_final em_fecha_final
em_fecha_inicial em_fecha_inicial
gb_1 gb_1
gb_2 gb_2
end type
global w_solicitud_tramite_internet w_solicitud_tramite_internet

type variables
long il_num_tramites_inicial, il_num_tramites_final
u_pipeline_control iu_pipeline_control, iu_pipeline_control02
n_tr i_tr_origen, i_tr_destino

st_confirma_usuario ist_confirma_usuario
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
	if isvalid(i_tr_origen) then
		DESTROY i_tr_origen		
	end if	
   IF conecta_bd(i_tr_origen,gs_sweb,ist_confirma_usuario.usuario, ist_confirma_usuario.password)<>1 then
   	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
 		RETURN -1
	END IF
END IF
i_tr_destino = gtr_sce

li_codigo_retorno = iu_pipeline_control.Start(i_tr_origen, i_tr_destino, dw_resultado)

if li_codigo_retorno <0 then
   ls_resultado= iu_pipeline_control.of_resultado(li_codigo_retorno)
	Messagebox("Error en Pipeline", ls_resultado,StopSign!)
   IF desconecta_bd(i_tr_origen)<>1 then
   	MessageBox("Error al desconectar", "No es posible desconectarse de la base del WEB", StopSign!)
 		RETURN -1
	END IF
	return -1
end if

li_codigo_retorno = iu_pipeline_control02.Start(i_tr_origen, i_tr_destino, dw_resultado)

if li_codigo_retorno <0 then
   ls_resultado= iu_pipeline_control02.of_resultado(li_codigo_retorno)
	Messagebox("Error en Pipeline", ls_resultado,StopSign!)
   IF desconecta_bd(i_tr_origen)<>1 then
   	MessageBox("Error al desconectar", "No es posible desconectarse de la base del WEB", StopSign!)
 		RETURN -1
	END IF
	return -1
else 
   IF desconecta_bd(i_tr_origen)<>1 then
   	MessageBox("Error al desconectar", "No es posible desconectarse de la base del WEB", StopSign!)
 		RETURN -1
	END IF
end if




return 0
end function

on w_solicitud_tramite_internet.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.rb_intentados=create rb_intentados
this.rb_solicitados=create rb_solicitados
this.st_3=create st_3
this.dw_resultado=create dw_resultado
this.cb_1=create cb_1
this.cb_cargar=create cb_cargar
this.dw_1=create dw_1
this.st_2=create st_2
this.st_1=create st_1
this.em_fecha_final=create em_fecha_final
this.em_fecha_inicial=create em_fecha_inicial
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_intentados
this.Control[iCurrent+2]=this.rb_solicitados
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.dw_resultado
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_cargar
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.em_fecha_final
this.Control[iCurrent+11]=this.em_fecha_inicial
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.gb_2
end on

on w_solicitud_tramite_internet.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_intentados)
destroy(this.rb_solicitados)
destroy(this.st_3)
destroy(this.dw_resultado)
destroy(this.cb_1)
destroy(this.cb_cargar)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_fecha_final)
destroy(this.em_fecha_inicial)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;datetime ldttm_fecha_servidor, ldttm_fecha_inicial

ldttm_fecha_servidor = fecha_servidor(gtr_sce)
ldttm_fecha_inicial = datetime(date("1-jan-2004"))
x=1
y=1

il_num_tramites_inicial = f_obten_numero_tramites(9999)

iu_pipeline_control =  create u_pipeline_control
iu_pipeline_control.dataobject= "dp_solicitud_tramite_internet"

iu_pipeline_control02 =  create u_pipeline_control
iu_pipeline_control02.dataobject= "dp_bit_tramite_internet"

em_fecha_inicial.text = string(ldttm_fecha_inicial,"dd/mm/yyyy")
em_fecha_final.text =  string(ldttm_fecha_servidor,"dd/mm/yyyy")


dw_resultado.SettransObject(gtr_sce)
end event

event close;call super::close;if isvalid(iu_pipeline_control) then
	destroy iu_pipeline_control
end if
end event

type rb_intentados from radiobutton within w_solicitud_tramite_internet
integer x = 1527
integer y = 220
integer width = 347
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Intentados"
end type

event clicked;dw_1.dataobject ="d_intentos_tramites_internet"
dw_1.SettransObject(gtr_sce)
end event

type rb_solicitados from radiobutton within w_solicitud_tramite_internet
integer x = 1527
integer y = 108
integer width = 347
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solicitados"
boolean checked = true
end type

event clicked;dw_1.dataobject ="d_tramites_internet"
dw_1.SettransObject(gtr_sce)
end event

type st_3 from statictext within w_solicitud_tramite_internet
integer x = 1106
integer y = 1244
integer width = 718
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "MONITOR DE ACTUALIZACION"
boolean focusrectangle = false
end type

type dw_resultado from u_dw within w_solicitud_tramite_internet
integer x = 46
integer y = 1296
integer width = 2843
integer height = 264
integer taborder = 80
string title = "Monitor de Actualización"
boolean hscrollbar = true
boolean resizable = true
end type

type cb_1 from commandbutton within w_solicitud_tramite_internet
integer x = 101
integer y = 144
integer width = 471
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Actualiza del WEB"
end type

event clicked;//Actualiza los registros del web
long ll_diferencia

if wf_conectaBD()<> 0 then
	MessageBox("Acceso a Internet Rechazado", "No se permite la actualización de información", StopSign!)
else 
	il_num_tramites_final = f_obten_numero_tramites(9999)
	ll_diferencia = il_num_tramites_final - il_num_tramites_inicial

	MessageBox("Actualización de Internet Exitosa", "Se han actualizado todos los registros del web~nse añadieron["+&
	           string(ll_diferencia)+"] registros.", Information!)
end if
end event

type cb_cargar from u_cb within w_solicitud_tramite_internet
integer x = 2039
integer y = 144
integer width = 471
integer taborder = 30
string text = "Consultar"
end type

event clicked;call super::clicked;dw_1.Triggerevent("carga")

end event

type dw_1 from uo_dw_reporte within w_solicitud_tramite_internet
integer x = 46
integer y = 380
integer width = 2843
integer height = 836
integer taborder = 70
string dataobject = "d_tramites_internet"
boolean hscrollbar = true
boolean resizable = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio=gtr_sce
this.SetTransObject(tr_dw_propio)
end event

event carga;string ls_fecha_inicial, ls_fecha_final
date ldt_fecha_inicial, ldt_fecha_final
datetime ldttm_fecha_inicial, ldttm_fecha_final
integer li_num_registros 

if isnull(dw_1.DataObject) then
	return 0
end if

ls_fecha_inicial= em_fecha_inicial.text
ls_fecha_final= em_fecha_final.text

ldt_fecha_inicial =date(ls_fecha_inicial)
ldt_fecha_final =date(ls_fecha_final)

if ldt_fecha_final < ldt_fecha_inicial then
	MessageBox("Error de fechas","La fecha inicial de atención no debe ser mayor a la fecha final")
end if 



ldt_fecha_final= RelativeDate(ldt_fecha_final, +1)

ldttm_fecha_inicial =datetime(ldt_fecha_inicial)
ldttm_fecha_final =datetime(ldt_fecha_final)

li_num_registros= dw_1.retrieve(ldttm_fecha_inicial, ldttm_fecha_final)

return li_num_registros



end event

event retrieverow;call super::retrieverow;string ls_diagnostico , ls_diagnostico_editado 
IF rb_intentados.checked then
	ls_diagnostico = this.GetItemString(row,"bit_tramite_internet_diagnostico")
   ls_diagnostico_editado= f_convierte_diagnostico( ls_diagnostico )
	this.SetItem(row,"diagnostico_editado",ls_diagnostico_editado )
end if
end event

type st_2 from statictext within w_solicitud_tramite_internet
integer x = 713
integer y = 228
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

type st_1 from statictext within w_solicitud_tramite_internet
integer x = 713
integer y = 112
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

type em_fecha_final from u_em within w_solicitud_tramite_internet
integer x = 1033
integer y = 212
integer width = 288
integer height = 84
integer taborder = 20
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type em_fecha_inicial from u_em within w_solicitud_tramite_internet
integer x = 1033
integer y = 96
integer width = 288
integer height = 84
integer taborder = 10
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type gb_1 from groupbox within w_solicitud_tramite_internet
integer x = 695
integer y = 28
integer width = 672
integer height = 320
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Periodo Atención"
end type

type gb_2 from groupbox within w_solicitud_tramite_internet
integer x = 1490
integer y = 28
integer width = 439
integer height = 320
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Trámites"
end type

