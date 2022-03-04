$PBExportHeader$w_consulta_sol_mat.srw
forward
global type w_consulta_sol_mat from w_main
end type
type st_2 from u_st within w_consulta_sol_mat
end type
type dw_maestro from u_dw_captura within w_consulta_sol_mat
end type
type em_folio from u_em within w_consulta_sol_mat
end type
type st_1 from u_st within w_consulta_sol_mat
end type
type st_estatus_bloqueo from statictext within w_consulta_sol_mat
end type
type uo_nombre from uo_nombre_alumno within w_consulta_sol_mat
end type
type dw_detalle from u_dw_captura within w_consulta_sol_mat
end type
end forward

global type w_consulta_sol_mat from w_main
integer width = 4640
integer height = 2500
string title = "Consulta de Comprobantes de Inscripción"
string menuname = "m_menu"
windowstate windowstate = maximized!
st_2 st_2
dw_maestro dw_maestro
em_folio em_folio
st_1 st_1
st_estatus_bloqueo st_estatus_bloqueo
uo_nombre uo_nombre
dw_detalle dw_detalle
end type
global w_consulta_sol_mat w_consulta_sol_mat

type variables
long il_num_tramites_inicial, il_num_tramites_final, il_cuenta= 0
u_pipeline_control iu_pipeline_control, iu_pipeline_control02
n_tr i_tr_origen, i_tr_destino
boolean ib_usuario_especial=false
integer ii_bloqueo_activo = 0
st_confirma_usuario ist_confirma_usuario
transaction itr_web
Datawindowchild dwc_periodo
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

on w_consulta_sol_mat.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.st_2=create st_2
this.dw_maestro=create dw_maestro
this.em_folio=create em_folio
this.st_1=create st_1
this.st_estatus_bloqueo=create st_estatus_bloqueo
this.uo_nombre=create uo_nombre
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.dw_maestro
this.Control[iCurrent+3]=this.em_folio
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_estatus_bloqueo
this.Control[iCurrent+6]=this.uo_nombre
this.Control[iCurrent+7]=this.dw_detalle
end on

on w_consulta_sol_mat.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_2)
destroy(this.dw_maestro)
destroy(this.em_folio)
destroy(this.st_1)
destroy(this.st_estatus_bloqueo)
destroy(this.uo_nombre)
destroy(this.dw_detalle)
end on

event open;call super::open;datetime ldttm_fecha_servidor, ldttm_fecha_inicial
integer li_return_conexion

x=1
y=1

//dw_resultado.SettransObject(gtr_sce)

li_return_conexion =f_conecta_pas_parametros_bd(gtr_sce, itr_web, 16, gs_usuario,  gs_password )
if li_return_conexion<> 1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	close(this)	
end if

dw_maestro.SetTransObject(itr_web)
dw_detalle.SetTransObject(itr_web)

f_dddw_converter(dw_maestro, dwc_periodo, "periodo")
f_dddw_converter(dw_detalle, dwc_periodo, "periodo")

//transaction		atr_transaccion_parametros
//transaction		atr_transaccion_nueva_bd
//integer 			ai_cve_conexion
////string				as_usuario
//string				as_password

//if conecta_bd(itr_web,gs_web_desb, "sa","desarrollo")<>1 then
//	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
//	close(this)
//else 
//	dw_maestro.SetTransObject(itr_web)
//	dw_detalle.SetTransObject(itr_web)
//end if
//

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



il_cuenta = ll_cuenta





end event

type st_2 from u_st within w_consulta_sol_mat
integer x = 805
integer y = 500
integer width = 887
string text = "( 999999 para traer todos los del alumno)"
end type

type dw_maestro from u_dw_captura within w_consulta_sol_mat
integer x = 55
integer y = 620
integer width = 2889
integer height = 776
integer taborder = 80
string dataobject = "d_folio_solicitud_materias"
end type

event carga;long cuentalocal, ll_folio, ll_rows_maestro, ll_rows_detalle
int carrera,plan
string ls_folio
//char nivel

 
long ll_row, ll_cuenta

ll_row = uo_nombre.dw_nombre_alumno.GetRow()

if ll_row>0 then

	ll_cuenta = uo_nombre.dw_nombre_alumno.GetItemNumber(ll_row, "cuenta")
	
	if isnull(ll_cuenta) then
		MessageBox("Error de Folio", "Favor de escribir un numéro de cuenta válido",Stopsign!)
		return 0		
	end if

	ls_folio = em_folio.text

	if not isnumber(ls_folio) then
		MessageBox("Error de Folio", "Favor de escribir un folio numérico válido",Stopsign!)
		return 0
	end if

	ll_folio = long(ls_folio)
	
	if ll_folio<0 then
		MessageBox("Error de Folio", "Favor de escribir un folio numérico mayor que cero",Stopsign!)
		return 0
	end if


	il_cuenta = ll_cuenta


	ll_rows_maestro = this.Retrieve(il_cuenta, ll_folio)
	ll_rows_detalle = dw_detalle.Retrieve(il_cuenta, ll_folio)
else
	MessageBox("Información Incompleta", "Favor de elegir un alumno válido y escribir un número de folio",Stopsign!)
	return 0
end if
return ll_rows_maestro




end event

event itemfocuschanged;call super::itemfocuschanged;long cuentalocal, ll_folio, ll_rows_maestro, ll_rows_detalle
int carrera,plan
string ls_folio
//char nivel

 
long ll_row, ll_cuenta

ll_row = row

ll_cuenta = dw_maestro.GetItemNumber(ll_row, "cuenta")

ll_folio = dw_maestro.GetItemNumber(ll_row, "folio")


il_cuenta = ll_cuenta

ll_rows_detalle = dw_detalle.Retrieve(il_cuenta, ll_folio)

return ll_rows_detalle

end event

event borra;return 
end event

event nuevo;return
end event

event actualiza;return 0
end event

type em_folio from u_em within w_consulta_sol_mat
integer x = 457
integer y = 492
integer width = 311
integer height = 84
integer taborder = 70
alignment alignment = right!
string mask = "######"
end type

type st_1 from u_st within w_consulta_sol_mat
integer x = 183
integer y = 500
integer width = 238
string text = "FOLIO:"
alignment alignment = right!
end type

type st_estatus_bloqueo from statictext within w_consulta_sol_mat
boolean visible = false
integer x = 1061
integer y = 832
integer width = 1687
integer height = 72
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "EL ALUMNO NO CUENTA CON BLOQUEOS"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_nombre from uo_nombre_alumno within w_consulta_sol_mat
integer x = 55
integer y = 16
integer taborder = 10
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

type dw_detalle from u_dw_captura within w_consulta_sol_mat
integer x = 55
integer y = 1432
integer width = 4526
integer height = 840
integer taborder = 80
string dataobject = "d_bit_solicitud_materias"
end type

event asigna_dw_menu;return 
end event

