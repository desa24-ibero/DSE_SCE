$PBExportHeader$w_cambio_version_examen_web.srw
forward
global type w_cambio_version_examen_web from window
end type
type dw_fecha_examen from datawindow within w_cambio_version_examen_web
end type
type st_3 from statictext within w_cambio_version_examen_web
end type
type cbx_confirma_tesoreria from checkbox within w_cambio_version_examen_web
end type
type st_2 from statictext within w_cambio_version_examen_web
end type
type vsb_dw_version from vscrollbar within w_cambio_version_examen_web
end type
type dw_version from datawindow within w_cambio_version_examen_web
end type
type st_1 from statictext within w_cambio_version_examen_web
end type
type em_ani from editmask within w_cambio_version_examen_web
end type
type dw_per from datawindow within w_cambio_version_examen_web
end type
type ddlb_1 from dropdownlistbox within w_cambio_version_examen_web
end type
type uo_1 from uo_ver_per_ani within w_cambio_version_examen_web
end type
type dw_1 from uo_dw_captura within w_cambio_version_examen_web
end type
type vsb_dw_per from vscrollbar within w_cambio_version_examen_web
end type
end forward

global type w_cambio_version_examen_web from window
integer x = 832
integer y = 364
integer width = 5262
integer height = 2884
boolean titlebar = true
string title = "Cambio de Versión de Exámen - Cancelación de Folio (NUEVO)"
string menuname = "m_menu"
long backcolor = 12632256
integer transparency = 1
dw_fecha_examen dw_fecha_examen
st_3 st_3
cbx_confirma_tesoreria cbx_confirma_tesoreria
st_2 st_2
vsb_dw_version vsb_dw_version
dw_version dw_version
st_1 st_1
em_ani em_ani
dw_per dw_per
ddlb_1 ddlb_1
uo_1 uo_1
dw_1 dw_1
vsb_dw_per vsb_dw_per
end type
global w_cambio_version_examen_web w_cambio_version_examen_web

type variables
int ord
uo_administrador_liberacion iuo_administrador_liberacion

transaction itr_admision_web

n_transfiere_sybase_sql in_transfiere_sybase_sql

end variables

forward prototypes
public function integer wf_filtra_fechas ()
public function integer wf_datos_examen (ref long al_id_fecha, ref integer ai_periodo, ref integer ai_anio)
end prototypes

public function integer wf_filtra_fechas ();// Se recuperan las fechas de examen de la versión solicitada
INTEGER li_clv_ver_nueva 

dw_fecha_examen.RESET()
dw_fecha_examen.INSERTROW(0)

li_clv_ver_nueva =	dw_version.object.clv_ver[dw_version.getrow()]

DATAWINDOWCHILD ldwc_fechas
dw_fecha_examen.GETCHILD("id_examen", ldwc_fechas) 
ldwc_fechas.SETTRANSOBJECT(itr_admision_web) 
ldwc_fechas.RETRIEVE(li_clv_ver_nueva) 

RETURN 0


end function

public function integer wf_datos_examen (ref long al_id_fecha, ref integer ai_periodo, ref integer ai_anio);

al_id_fecha = dw_fecha_examen.GETITEMNUMBER(1, "id_examen")  
IF ISNULL(al_id_fecha) OR al_id_fecha = 0 THEN 
	MESSAGEBOX("Error", "Debe seleccionar una fecha de aplicación de exámen. " ) 
	RETURN -1
END IF

SELECT  periodo_ingreso, anio_ingreso
INTO :ai_periodo, :ai_anio 
FROM examen_fecha 
WHERE id_examen = :al_id_fecha 
USING itr_admision_web; 
IF itr_admision_web.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar el periodo y año de la fecha seleccionada: " + itr_admision_web.SQLERRTEXT) 
	RETURN -1 
END IF

RETURN 0











end function

on w_cambio_version_examen_web.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_fecha_examen=create dw_fecha_examen
this.st_3=create st_3
this.cbx_confirma_tesoreria=create cbx_confirma_tesoreria
this.st_2=create st_2
this.vsb_dw_version=create vsb_dw_version
this.dw_version=create dw_version
this.st_1=create st_1
this.em_ani=create em_ani
this.dw_per=create dw_per
this.ddlb_1=create ddlb_1
this.uo_1=create uo_1
this.dw_1=create dw_1
this.vsb_dw_per=create vsb_dw_per
this.Control[]={this.dw_fecha_examen,&
this.st_3,&
this.cbx_confirma_tesoreria,&
this.st_2,&
this.vsb_dw_version,&
this.dw_version,&
this.st_1,&
this.em_ani,&
this.dw_per,&
this.ddlb_1,&
this.uo_1,&
this.dw_1,&
this.vsb_dw_per}
end on

on w_cambio_version_examen_web.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_fecha_examen)
destroy(this.st_3)
destroy(this.cbx_confirma_tesoreria)
destroy(this.st_2)
destroy(this.vsb_dw_version)
destroy(this.dw_version)
destroy(this.st_1)
destroy(this.em_ani)
destroy(this.dw_per)
destroy(this.ddlb_1)
destroy(this.uo_1)
destroy(this.dw_1)
destroy(this.vsb_dw_per)
end on

event open;integer li_conexion



x=1
y=1

li_conexion = f_conecta_pas_parametros_bd(gtr_sce, itr_admision_web, 24, gs_usuario, gs_password)

//transaction		atr_transaccion_parametros
//transaction		atr_transaccion_nueva_bd
//integer 			ai_cve_conexion
//string				as_usuario
//string				as_password

if li_conexion <>1 then
	MessageBox("Error de conexion a la base del web","Favor de reintentar con un usuario que tenga permisos", StopSign!)
	close(this)
end if

//dw_aspiran_web.SetTransObject(itr_admision_web )


//Redirigido 2013-04-08 
//dw_1.settransobject(gtr_sadm)
dw_1.settransobject(itr_admision_web)


f_obten_titulo(w_principal)

if not isvalid(iuo_administrador_liberacion) then
	iuo_administrador_liberacion = CREATE uo_administrador_liberacion	
end if



wf_filtra_fechas()






end event

event close;
if isvalid(itr_admision_web) then
	DISCONNECT USING itr_admision_web;
end if

if isvalid(iuo_administrador_liberacion) then
	DESTROY iuo_administrador_liberacion 
end if

f_obten_titulo(w_principal)
end event

type dw_fecha_examen from datawindow within w_cambio_version_examen_web
integer x = 2981
integer y = 200
integer width = 1202
integer height = 108
integer taborder = 30
string title = "none"
string dataobject = "dw_fecha_examen_cambio_ver_enlace"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_cambio_version_examen_web
integer x = 2304
integer y = 224
integer width = 677
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Fechas Nueva Versión:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cbx_confirma_tesoreria from checkbox within w_cambio_version_examen_web
boolean visible = false
integer x = 3488
integer y = 204
integer width = 576
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Confirma Tesorería"
end type

type st_2 from statictext within w_cambio_version_examen_web
integer x = 2304
integer y = 88
integer width = 677
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Nueva Versión:"
alignment alignment = right!
boolean focusrectangle = false
end type

type vsb_dw_version from vscrollbar within w_cambio_version_examen_web
integer x = 3621
integer y = 64
integer width = 105
integer height = 108
boolean bringtotop = true
boolean stdwidth = false
integer minposition = 1
integer position = 1
end type

event linedown;/* En cuanto el usuario oprima la flecha-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_version.RowCount() then
	/* Si no lo estoy mueve el scroll bar una posición más */
	position=position+1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if


end event

event lineup;/* En cuanto el usuario oprima la flecha-arriba del ScrollBar... */

/* Verifica que no esté al inicio de los renglones del DataWindow */
if position>1 then
	/* Si no lo estoy mueve el scroll bar una posición menos */
	position=position -1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if
end event

event moved;/* En cuanto se de el evento Moved (usuario moviendo la barra o llamado desde aca adentro)... */

/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
maxposition=dw_version.RowCount()

/* Haz que el la ventana del DataWindow se mueva al cambiar la posición del ScrollBar */
dw_version.ScrollToRow(scrollpos)
	
wf_filtra_fechas()

end event

event pagedown;/* En cuanto el usuario oprima la página-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_version.RowCount() then
	/* Si no lo estoy mueve el scroll bar una posición más */
	position=position+1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if
end event

event pageup;/* En cuanto el usuario oprima la página-arriba del ScrollBar... */

/* Verifica que no esté al inicio de los renglones del DataWindow */
if position>1 then
	/* Si no lo estoy mueve el scroll bar una posición menos */
	position=position -1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if
end event

type dw_version from datawindow within w_cambio_version_examen_web
integer x = 2981
integer y = 64
integer width = 626
integer height = 108
integer taborder = 20
string title = "none"
string dataobject = "dw_version_examen"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;/* En cuanto el usuario cambie "manualmente" el focus del DataWindow... */

if RowCount()<>0 then
	accepttext()

	/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
	vsb_dw_version.maxposition=RowCount()

	/* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
	vsb_dw_version.position=currentrow

end if





end event

event constructor;settransobject(gtr_sadm)
retrieve()
scrolltorow(1)
end event

type st_1 from statictext within w_cambio_version_examen_web
integer x = 457
integer y = 220
integer width = 407
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217728
boolean enabled = false
string text = "Ordenamiento:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_ani from editmask within w_cambio_version_examen_web
event modified pbm_enmodified
boolean visible = false
integer x = 1563
integer y = 188
integer width = 347
integer height = 104
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####"
boolean autoskip = true
boolean spin = true
string displaydata = ""
double increment = 1
end type

event constructor;text=string(gi_anio)
end event

type dw_per from datawindow within w_cambio_version_examen_web
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
event rowfocuschanged pbm_dwnrowchange
boolean visible = false
integer x = 1947
integer y = 188
integer width = 626
integer height = 108
string dataobject = "dw_periodo"
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(gtr_sadm)
retrieve()
scrolltorow(gi_periodo+1)
end event

event rowfocuschanged;/* En cuanto el usuario cambie "manualmente" el focus del DataWindow... */

if RowCount()<>0 then
	accepttext()

	/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
	vsb_dw_per.maxposition=RowCount()

	/* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
	vsb_dw_per.position=currentrow

end if
end event

type ddlb_1 from dropdownlistbox within w_cambio_version_examen_web
integer x = 896
integer y = 212
integer width = 347
integer height = 232
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean vscrollbar = true
string item[] = {"Cuenta","Folio","Nombre"}
end type

event selectionchanged;CHOOSE CASE index
	CASE 1
		dw_1.SetSort("general_cuenta")
		dw_1.Sort( ) 
	CASE 2
		dw_1.SetSort("aspiran_folio")
		dw_1.Sort( ) 
	CASE 3
		dw_1.SetSort("nomb")
		dw_1.Sort( ) 
END CHOOSE

end event

type uo_1 from uo_ver_per_ani within w_cambio_version_examen_web
integer x = 9
integer y = 16
integer width = 2281
integer height = 168
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

event cambia_seleccion;call super::cambia_seleccion;//wf_filtra_fechas()

RETURN 
end event

type dw_1 from uo_dw_captura within w_cambio_version_examen_web
integer x = 23
integer y = 348
integer width = 5070
integer height = 2272
integer taborder = 0
string dataobject = "d_cambio_version_examen"
boolean hscrollbar = true
boolean resizable = true
borderstyle borderstyle = styleraised!
end type

event carga;/*Antes de cargar algo, ve si hay modificaciones no guardadas*/


INTEGER li_clv_ver_nueva

DATAWINDOWCHILD ldwc_fechas2
dw_1.GETCHILD("aspiran_id_examen", ldwc_fechas2) 
ldwc_fechas2.SETTRANSOBJECT(itr_admision_web) 
ldwc_fechas2.RETRIEVE(gi_version,gi_periodo, gi_anio) 


event primero()
return retrieve(gi_version,gi_periodo,gi_anio)



end event

event constructor;call super::constructor;DataWindowChild carr
getchild("aspiran_clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()
end event

event actualiza;/**/
return 0
end event

event borra;/**/
end event

event nuevo;/**/
end event

event doubleclicked;int nvo_anio,nvo_peri,clv_carr,estado,lugar_nac,nacional,edo_civil
int religion,bachillera,trabajo,trab_hor,ya_inscri,transporte,pago_insc, li_num_padres
long folio,cuenta, ll_cuenta
real puntaje,promedio
string nombre,apaterno,amaterno,calle,codigo_pos,colonia,telefono,sexo, ls_sexo_padre
datetime fecha_nac,hoy
int li_codigo_sql, li_cambio_periodo, li_anio_pago, li_periodo_pago, li_confirma
string ls_mensaje_sql, ls_nombre
long ll_folio_actual, ll_cuenta_actual, ll_folio_nuevo
//str_aspirante lstr_aspirante.
integer li_clv_ver_nueva, li_nvo_folio
integer li_confirma_tesoreria
long ll_saldo_sit
hoy=datetime(today(),now())
STRING ls_periodo, ls_seccion, ls_seccion2
integer ai_periodo, ai_anio, ai_periodo_sit ,ai_anio_sit, li_obten_periodo_sit		
LONG ll_id_fecha_examen
STRING ls_salon_null

OPEN(w_selecciona_periodo) 
ls_periodo = MESSAGE.STRINGPARM
ls_seccion = LEFT(ls_periodo, POS(ls_periodo, "-") - 1) 
ls_seccion2 = RIGHT(ls_periodo, LEN(ls_periodo) -  POS(ls_periodo, "-"))

IF TRIM(ls_periodo) = "" OR TRIM(ls_seccion) = "" OR TRIM(ls_seccion2) = "" THEN 
	MESSAGEBOX("Aviso", "No se ha seleccionado un periodo válido.")
	RETURN 0
ELSE
	ai_periodo_sit = INTEGER(ls_seccion) 
	ai_anio_sit = INTEGER(ls_seccion2) 
END IF


IF row>0 THEN
	ll_folio_actual = object.aspiran_folio[row]
	ll_cuenta_actual = object.general_cuenta[row]
	IF ISNULL(ll_cuenta_actual) THEN ll_cuenta_actual = 0
	ls_nombre = object.nomb[row]
	ok = messagebox("Desea Cambiar la Versión del Examen", "Folio Actual: "+string(ll_folio_actual)+' ~n'+ls_nombre+&
			" ~nNúmero de Cuenta: "+string(ll_cuenta_actual),Exclamation!, YesNo!, 2)

	if	cbx_confirma_tesoreria.checked then
		li_confirma_tesoreria = 1 
	else
		li_confirma_tesoreria = 0		
	end if
	
	IF ok = 1 THEN 
		
//	AHORA EL CAMBIO DE FOLIO SERÁ OBLIGATORIO		
//		li_nvo_folio = messagebox("Desea generar un NUEVO FOLIO ", "Folio Actual: "+string(ll_folio_actual)+' ~n'+ls_nombre+&
//			" ~nNúmero de Cuenta: "+string(ll_cuenta_actual),Exclamation!, YesNo!, 2)
		li_clv_ver_nueva =	dw_version.object.clv_ver[dw_version.getrow()]
//		nvo_anio=integer(em_ani.text)
//		nvo_peri=dw_per.object.clv_per[dw_per.getrow()]
//	
//		lstr_aspirante.folio		= 	ll_folio_actual
//		lstr_aspirante.clv_ver	= 	li_clv_ver_nueva
//		lstr_aspirante.clv_per	= 	gi_periodo
//		lstr_aspirante.anio		= 	gi_anio
//		IF li_nvo_folio=1 THEN
//			OpenWithParm(w_folio_enlace, lstr_aspirante, w_cambio_version_examen)
//			if isvalid(Message.PowerObjectParm) then
//				lstr_aspirante= Message.PowerObjectParm
//				ll_folio_nuevo= lstr_aspirante.folio
//			else
//				ll_folio_nuevo= ll_folio_actual
//			end if
//		ELSE
//			ll_folio_nuevo= ll_folio_actual
//
//		END IF

////		li_anio_pago=integer(em_ani_pago.text)
////		li_periodo_pago=dw_per_pago.object.clv_per[dw_per_pago.getrow()]

		IF gi_version=li_clv_ver_nueva  THEN
			//li_confirma= messagebox("Periodo destino repetido","¿Desea realizar un enlace en el mismo periodo",Question!, YesNo!)
			li_confirma= messagebox("Versión destino repetida","¿Desea realizar un enlace en la misma versión",Question!, YesNo!)
			IF li_confirma<>1 THEN
				RETURN
			END IF
		END IF
			li_codigo_sql = f_existe_aspirante(ll_folio_actual, gi_version, gi_periodo, gi_anio)
			IF li_codigo_sql= 100 THEN
				MessageBox("El aspirante no existe en admision","Favor de registrarlo primero",StopSign!)
				RETURN
			ELSEIF li_codigo_sql= -1 THEN
				MessageBox("Error al consultar aspiran","No es posible cambiar su versión de examen",StopSign!)				
				RETURN
			END IF	
						
						
		


			// El periodo y año se toman de la fecha de aplicación de exámen 22/Nov/2017 
//			ai_periodo = gi_periodo
//			ai_anio = gi_anio 
			
			// Se recuperan la fecha y el periodo del exámen 
			IF wf_datos_examen(ll_id_fecha_examen, ai_periodo, ai_anio) = -1 THEN RETURN 
			
			
			// 07/02/2018 SE SUSTITUYE ESTA VALIDACION PARA QUE EL USUARIO SELECCIONE EL PERIODO DE TRASPASO DE SALDOS
			// 07/02/2018 SE SUSTITUYE ESTA VALIDACION PARA QUE EL USUARIO SELECCIONE EL PERIODO DE TRASPASO DE SALDOS			
//			//DADO QUE EN TESORERIA HAY UN PERIODO ANTERIOR AL REGISTRO DE ADMISION OBTIENE LOS PERIODOS CORRESPONDIENTES
//			li_obten_periodo_sit = f_obten_periodo_sit(ai_periodo, ai_anio, ai_periodo_sit, ai_anio_sit )
//			IF  li_obten_periodo_sit=-1  THEN
//				MessageBox("Error al consultar los periodos","No es posible cambiar su versión de examen",StopSign!)				
//				RETURN
//			END IF	
//			//2016-05-31
//			//SUSTITUYE LOS VALORES ANTERIORES, YA QUE PARA CAMBIOS DE VERSIÓN ESTO NO APLICA.
////			ai_periodo_sit = ai_periodo
////			ai_anio_sit = ai_anio 
			// 07/02/2018 SE SUSTITUYE ESTA VALIDACION PARA QUE EL USUARIO SELECCIONE EL PERIODO DE TRASPASO DE SALDOS
			// 07/02/2018 SE SUSTITUYE ESTA VALIDACION PARA QUE EL USUARIO SELECCIONE EL PERIODO DE TRASPASO DE SALDOS
			
			// 
			//ANTES QUE NADA, VALIDA QUE TENGA EL SALDO CORRESPONDIENTE						
			ll_saldo_sit= f_saldo_admision_sit_2013(ll_folio_actual, gi_version, ai_periodo_sit, ai_anio_sit, ll_folio_nuevo,li_clv_ver_nueva)	
			

			IF  ll_saldo_sit<=0  THEN
				MessageBox("Error al consultar saldo","No es posible cambiar su versión de examen",StopSign!)				
				RETURN
			END IF	
			// 
			
			//EFECTUA LOS CAMBIOS DE VERSIÓN
			//li_cambio_periodo= f_cambio_version_aspirante(ll_folio_actual, gi_version, gi_periodo, gi_anio, li_clv_ver_nueva, gi_periodo, gi_anio, itr_admision_web, gtr_sadm,li_confirma_tesoreria )	
			//li_cambio_periodo= f_cambio_version_aspirante2(ll_folio_actual, gi_version, gi_periodo, gi_anio, li_clv_ver_nueva, gi_periodo, gi_anio, itr_admision_web, gtr_sadm,li_confirma_tesoreria, ll_id_fecha_examen )	
			li_cambio_periodo= f_cambio_version_aspirante2(ll_folio_actual, gi_version, gi_periodo, gi_anio, li_clv_ver_nueva, ai_periodo, ai_anio, itr_admision_web, gtr_sadm,li_confirma_tesoreria, ll_id_fecha_examen, ai_periodo_sit, ai_anio_sit)

			
			IF li_cambio_periodo= 0 THEN
				
				SETNULL(ls_salon_null)
				
				// Si se realiza el cambio de periodo se actualiza el estatus del registro anterior para recalcular los lugares ocupados.
				UPDATE aspiran 
				SET status = 99, salon = :ls_salon_null 
				WHERE folio = 	:ll_folio_actual 
				AND clv_ver = :gi_version 
				AND clv_per = :gi_periodo   
				AND anio = :gi_anio  				
				USING itr_admision_web;
				IF itr_admision_web.SQLCODE < 0 THEN 
					MESSAGEBOX("ERROR", "Se produjo un error al actualizar el estatus en SQL: " + itr_admision_web.SQLERRTEXT)
					ROLLBACK USING itr_admision_web;
				END IF

				UPDATE aspiran 
				SET status = 99,  salon = :ls_salon_null 
				WHERE folio = 	:ll_folio_actual 
				AND clv_ver = :gi_version 
				AND clv_per = :gi_periodo   
				AND anio = :gi_anio  				
				USING gtr_sadm;				
				IF gtr_sadm.SQLCODE < 0 THEN 
					MESSAGEBOX("ERROR", "Se produjo un error al actualizar el estatus en SQL: " + gtr_sadm.SQLERRTEXT)
					ROLLBACK USING gtr_sadm;								
				END IF
				
				MessageBox("Cambio Exitoso","El alumno ha cambiado de versión exitosamente",Information!)
				RETURN
			ELSEIF li_cambio_periodo= -1 THEN
				MessageBox("Error al cambiar de periodo","No es posible efectuar el cambio",StopSign!)
				RETURN
			END IF				
				
	END IF

END IF
end event

event inicia_transaction_object;call super::inicia_transaction_object;//Modificado 2013-04-08
//tr_dw_propio = gtr_sadm

tr_dw_propio = itr_admision_web


//MessageBox("TITULO", tr_dw_propio.DBPARM, INFORMATION!)

end event

type vsb_dw_per from vscrollbar within w_cambio_version_examen_web
event linedown pbm_sbnlinedown
event lineup pbm_sbnlineup
event moved pbm_sbnthumbtrack
event pagedown pbm_sbnpagedown
event pageup pbm_sbnpageup
boolean visible = false
integer x = 2569
integer y = 188
integer width = 105
integer height = 108
boolean stdwidth = false
integer minposition = 1
integer position = 1
end type

event linedown;/* En cuanto el usuario oprima la flecha-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_per.RowCount() then
	/* Si no lo estoy mueve el scroll bar una posición más */
	position=position+1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if


end event

event lineup;/* En cuanto el usuario oprima la flecha-arriba del ScrollBar... */

/* Verifica que no esté al inicio de los renglones del DataWindow */
if position>1 then
	/* Si no lo estoy mueve el scroll bar una posición menos */
	position=position -1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if
end event

event moved;/* En cuanto se de el evento Moved (usuario moviendo la barra o llamado desde aca adentro)... */

/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
maxposition=dw_per.RowCount()

/* Haz que el la ventana del DataWindow se mueva al cambiar la posición del ScrollBar */
dw_per.ScrollToRow(scrollpos)
	

end event

event pagedown;/* En cuanto el usuario oprima la página-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_per.RowCount() then
	/* Si no lo estoy mueve el scroll bar una posición más */
	position=position+1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if
end event

event pageup;/* En cuanto el usuario oprima la página-arriba del ScrollBar... */

/* Verifica que no esté al inicio de los renglones del DataWindow */
if position>1 then
	/* Si no lo estoy mueve el scroll bar una posición menos */
	position=position -1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if
end event

