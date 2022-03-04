$PBExportHeader$w_establece_estatus_tramite.srw
forward
global type w_establece_estatus_tramite from w_main
end type
type st_3 from statictext within w_establece_estatus_tramite
end type
type dw_resultado from u_dw within w_establece_estatus_tramite
end type
type cb_1 from commandbutton within w_establece_estatus_tramite
end type
type cb_establece from u_cb within w_establece_estatus_tramite
end type
type st_2 from statictext within w_establece_estatus_tramite
end type
type st_1 from statictext within w_establece_estatus_tramite
end type
type em_fecha_final from u_em within w_establece_estatus_tramite
end type
type em_fecha_inicial from u_em within w_establece_estatus_tramite
end type
type gb_1 from groupbox within w_establece_estatus_tramite
end type
type dw_1 from u_dw_captura within w_establece_estatus_tramite
end type
end forward

global type w_establece_estatus_tramite from w_main
integer width = 3598
integer height = 1868
string title = "Establece Estatus de Trámites por Internet"
string menuname = "m_menu"
windowstate windowstate = maximized!
st_3 st_3
dw_resultado dw_resultado
cb_1 cb_1
cb_establece cb_establece
st_2 st_2
st_1 st_1
em_fecha_final em_fecha_final
em_fecha_inicial em_fecha_inicial
gb_1 gb_1
dw_1 dw_1
end type
global w_establece_estatus_tramite w_establece_estatus_tramite

type variables
long il_num_tramites_inicial, il_num_tramites_final
u_pipeline_control iu_pipeline_control
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

li_codigo_retorno = iu_pipeline_control.Start(i_tr_origen, i_tr_destino, dw_resultado)

if li_codigo_retorno <0 then
   ls_resultado= iu_pipeline_control.of_resultado(li_codigo_retorno)
	Messagebox("Error en Pipeline", ls_resultado,StopSign!)
	return -1
else 
	il_num_tramites_final = f_obten_numero_tramites_web(9999,i_tr_destino)	
   IF desconecta_bd(i_tr_destino)<>1 then
   	MessageBox("Error al desconectar", "No es posible desconectarse de la base del WEB", StopSign!)
 		RETURN -1
	END IF
end if


return 0
end function

on w_establece_estatus_tramite.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.st_3=create st_3
this.dw_resultado=create dw_resultado
this.cb_1=create cb_1
this.cb_establece=create cb_establece
this.st_2=create st_2
this.st_1=create st_1
this.em_fecha_final=create em_fecha_final
this.em_fecha_inicial=create em_fecha_inicial
this.gb_1=create gb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.dw_resultado
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_establece
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.em_fecha_final
this.Control[iCurrent+8]=this.em_fecha_inicial
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.dw_1
end on

on w_establece_estatus_tramite.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_3)
destroy(this.dw_resultado)
destroy(this.cb_1)
destroy(this.cb_establece)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_fecha_final)
destroy(this.em_fecha_inicial)
destroy(this.gb_1)
destroy(this.dw_1)
end on

event open;call super::open;datetime ldttm_fecha_servidor, ldttm_fecha_inicial

x=1
y=1

iu_pipeline_control =  create u_pipeline_control
iu_pipeline_control.dataobject= "dp_estado_alumno_tramite"

dw_resultado.SettransObject(gtr_sce)

ldttm_fecha_servidor = fecha_servidor(gtr_sce)
ldttm_fecha_inicial = datetime(date("1-jan-2004"))

em_fecha_inicial.text = string(ldttm_fecha_inicial,"dd/mm/yyyy")
em_fecha_final.text =  string(ldttm_fecha_servidor,"dd/mm/yyyy")

end event

event close;call super::close;if isvalid(iu_pipeline_control) then
	destroy iu_pipeline_control
end if
end event

type st_3 from statictext within w_establece_estatus_tramite
integer x = 1417
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

type dw_resultado from u_dw within w_establece_estatus_tramite
integer x = 27
integer y = 1296
integer width = 3493
integer height = 264
integer taborder = 80
string title = "Monitor de Actualización"
boolean hscrollbar = true
boolean resizable = true
end type

type cb_1 from commandbutton within w_establece_estatus_tramite
integer x = 2277
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
string text = "Actualiza WEB"
end type

event clicked;//Actualiza los registros del web
long ll_diferencia

if wf_conectaBD()<> 0 then
	MessageBox("Acceso a Internet Rechazado", "No se permite la actualización de información", StopSign!)
else 

	ll_diferencia = il_num_tramites_final - il_num_tramites_inicial

	MessageBox("Actualización de Internet Exitosa", "Se han actualizado todos los registros del web~nse añadieron["+&
	           string(ll_diferencia)+"] registros.", Information!)
end if
end event

type cb_establece from u_cb within w_establece_estatus_tramite
integer x = 805
integer y = 144
integer width = 471
integer taborder = 30
string text = "Establece Estatus"
end type

event clicked;call super::clicked;dw_1.Triggerevent("carga")

end event

type st_2 from statictext within w_establece_estatus_tramite
integer x = 1467
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

type st_1 from statictext within w_establece_estatus_tramite
integer x = 1467
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

type em_fecha_final from u_em within w_establece_estatus_tramite
integer x = 1787
integer y = 212
integer width = 288
integer height = 84
integer taborder = 20
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type em_fecha_inicial from u_em within w_establece_estatus_tramite
integer x = 1787
integer y = 96
integer width = 288
integer height = 84
integer taborder = 10
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type gb_1 from groupbox within w_establece_estatus_tramite
integer x = 1440
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

type dw_1 from u_dw_captura within w_establece_estatus_tramite
integer x = 27
integer y = 380
integer width = 3493
integer height = 892
integer taborder = 30
string dataobject = "d_establece_estatus_tramite"
boolean hscrollbar = true
boolean resizable = true
end type

event inicia_transaction_object;tr_dw_propio=gtr_sce
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

event nuevo;return
end event

event borra;return
end event

event actualiza;long ll_row_actual, ll_rowcount
long ll_cuenta, ll_cve_carrera, ll_cve_plan
integer li_cve_tramite, li_cve_estado, li_cve_sub_estado, li_confirma
datetime ldttm_fecha

li_confirma = MessageBox("Confirmación", "¿Desea actualizar el estatus?", Question!,YesNo!)

if li_confirma<> 1 then
	return -1
	
end if

ll_rowcount = this.Rowcount()

FOR ll_row_actual=1 TO ll_rowcount

	ll_cuenta = this.GetItemNumber(ll_row_actual, "estado_alumno_tramite_cuenta")
	ll_cve_carrera = this.GetItemNumber(ll_row_actual, "estado_alumno_tramite_cve_carrera")
	ll_cve_plan = this.GetItemNumber(ll_row_actual, "estado_alumno_tramite_cve_plan")
	li_cve_tramite = this.GetItemNumber(ll_row_actual, "estado_alumno_tramite_cve_tramite")
	li_cve_estado = 0
	li_cve_sub_estado= 0
	ldttm_fecha = this.GetItemDatetime(ll_row_actual, "estado_alumno_tramite_fecha")
	
	f_obten_estatus_tramite(ll_cuenta,	    ll_cve_carrera,	ll_cve_plan, &
                         	li_cve_tramite, ldttm_fecha,     li_cve_estado, li_cve_sub_estado)


   if f_establece_estatus_tramite(ll_cuenta,	    ll_cve_carrera,	ll_cve_plan, &
                         	li_cve_tramite, ldttm_fecha,     li_cve_estado, li_cve_sub_estado)= -1 then
		MessageBox("Error de actualización", "No es posible almacenar los cambios", StopSign!)
		return -1
	end if
//	this.SetItem(ll_row_actual, "estado_alumno_tramite_cve_estado", li_cve_estado)
//	this.SetItem(ll_row_actual, "estado_alumno_tramite_cve_sub_estado", li_cve_sub_estado)


NEXT

this.event carga()

return 0


//IF this.Update()=1 THEN
//	COMMIT USING gtr_sce;
//	return 0
//ELSE
//	ROLLBACK USING gtr_sce;
//	MessageBox("Error de actualización", "No es posible almacenar los cambios", StopSign!)
//	return -1
//END IF


end event

