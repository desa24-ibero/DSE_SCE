$PBExportHeader$w_cambio_periodo_ingreso.srw
forward
global type w_cambio_periodo_ingreso from window
end type
type cb_1 from commandbutton within w_cambio_periodo_ingreso
end type
type st_3 from statictext within w_cambio_periodo_ingreso
end type
type st_2 from statictext within w_cambio_periodo_ingreso
end type
type st_1 from statictext within w_cambio_periodo_ingreso
end type
type dw_per_pago from datawindow within w_cambio_periodo_ingreso
end type
type vsb_dw_per_pago from vscrollbar within w_cambio_periodo_ingreso
end type
type em_ani_pago from editmask within w_cambio_periodo_ingreso
end type
type em_ani from editmask within w_cambio_periodo_ingreso
end type
type vsb_dw_per from vscrollbar within w_cambio_periodo_ingreso
end type
type dw_per from datawindow within w_cambio_periodo_ingreso
end type
type ddlb_1 from dropdownlistbox within w_cambio_periodo_ingreso
end type
type uo_1 from uo_ver_per_ani within w_cambio_periodo_ingreso
end type
type dw_1 from uo_dw_captura within w_cambio_periodo_ingreso
end type
end forward

global type w_cambio_periodo_ingreso from window
integer x = 832
integer y = 364
integer width = 3671
integer height = 1960
boolean titlebar = true
string title = "Cambio de Periodo de Ingreso"
string menuname = "m_menu"
long backcolor = 30976088
cb_1 cb_1
st_3 st_3
st_2 st_2
st_1 st_1
dw_per_pago dw_per_pago
vsb_dw_per_pago vsb_dw_per_pago
em_ani_pago em_ani_pago
em_ani em_ani
vsb_dw_per vsb_dw_per
dw_per dw_per
ddlb_1 ddlb_1
uo_1 uo_1
dw_1 dw_1
end type
global w_cambio_periodo_ingreso w_cambio_periodo_ingreso

type variables
int ord
uo_administrador_liberacion iuo_administrador_liberacion
end variables

on w_cambio_periodo_ingreso.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_1=create cb_1
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.dw_per_pago=create dw_per_pago
this.vsb_dw_per_pago=create vsb_dw_per_pago
this.em_ani_pago=create em_ani_pago
this.em_ani=create em_ani
this.vsb_dw_per=create vsb_dw_per
this.dw_per=create dw_per
this.ddlb_1=create ddlb_1
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.st_3,&
this.st_2,&
this.st_1,&
this.dw_per_pago,&
this.vsb_dw_per_pago,&
this.em_ani_pago,&
this.em_ani,&
this.vsb_dw_per,&
this.dw_per,&
this.ddlb_1,&
this.uo_1,&
this.dw_1}
end on

on w_cambio_periodo_ingreso.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_per_pago)
destroy(this.vsb_dw_per_pago)
destroy(this.em_ani_pago)
destroy(this.em_ani)
destroy(this.vsb_dw_per)
destroy(this.dw_per)
destroy(this.ddlb_1)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)


f_obten_titulo(w_principal)

if not isvalid(iuo_administrador_liberacion) then
	iuo_administrador_liberacion = CREATE uo_administrador_liberacion	
end if

end event

event close;
if isvalid(iuo_administrador_liberacion) then
	DESTROY iuo_administrador_liberacion 
end if

f_obten_titulo(w_principal)
end event

type cb_1 from commandbutton within w_cambio_periodo_ingreso
boolean visible = false
integer x = 1371
integer y = 16
integer width = 562
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Probar User Object"
end type

event clicked;uo_cambio_periodo_ingreso		luo_cambio_periodo_ingreso
Int		li_existe_alumno


luo_cambio_periodo_ingreso = Create uo_cambio_periodo_ingreso	

li_existe_alumno = luo_cambio_periodo_ingreso.uof_existe_alumno ( 182392 , gtr_sce )

IF li_existe_alumno = 100 THEN
	MessageBox ( "El alumno no existe en control escolar" , "Es necesario realizar el enlace del alumno antes de cambiar su periodo de ingreso" , StopSign! )
	Return;
END IF

MessageBox ( "Aviso:" , "Encontrado en Academicos" )

// Conexion a tesoreria_db en sybfindes ...
transaction gtr_tes

if conecta_bd(gtr_tes,gs_tes,'sa','desarrollo')<>1 then
	
	DESTROY gtr_tes

end if

luo_cambio_periodo_ingreso.uof_apartado_lugar_cob_sit ( 182392 , 2 , 2011 , 0 , 2012 , gtr_tes , gtr_sce )


end event

type st_3 from statictext within w_cambio_periodo_ingreso
integer x = 1783
integer y = 204
integer width = 603
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 30976088
boolean enabled = false
string text = "Período Ing. Deseado"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_cambio_periodo_ingreso
integer x = 2002
integer y = 64
integer width = 384
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 30976088
boolean enabled = false
string text = "Período Pago"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_cambio_periodo_ingreso
integer x = 832
integer y = 204
integer width = 407
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 30976088
boolean enabled = false
string text = "Ordenamiento:"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_per_pago from datawindow within w_cambio_periodo_ingreso
event retrieveend pbm_dwnretrieveend
integer x = 2834
integer y = 48
integer width = 626
integer height = 108
integer taborder = 10
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

type vsb_dw_per_pago from vscrollbar within w_cambio_periodo_ingreso
integer x = 3470
integer y = 48
integer width = 105
integer height = 108
boolean bringtotop = true
boolean stdwidth = false
integer minposition = 1
integer position = 1
end type

event linedown;/* En cuanto el usuario oprima la flecha-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_per_pago.RowCount() then
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
maxposition=dw_per_pago.RowCount()

/* Haz que el la ventana del DataWindow se mueva al cambiar la posición del ScrollBar */
dw_per_pago.ScrollToRow(scrollpos)
	

end event

event pagedown;/* En cuanto el usuario oprima la página-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_per_pago.RowCount() then
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

type em_ani_pago from editmask within w_cambio_periodo_ingreso
event modified pbm_enmodified
integer x = 2409
integer y = 52
integer width = 347
integer height = 104
integer taborder = 10
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

type em_ani from editmask within w_cambio_periodo_ingreso
event modified pbm_enmodified
integer x = 2409
integer y = 192
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

type vsb_dw_per from vscrollbar within w_cambio_periodo_ingreso
event linedown pbm_sbnlinedown
event lineup pbm_sbnlineup
event moved pbm_sbnthumbtrack
event pagedown pbm_sbnpagedown
event pageup pbm_sbnpageup
integer x = 3470
integer y = 188
integer width = 105
integer height = 108
boolean bringtotop = true
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

type dw_per from datawindow within w_cambio_periodo_ingreso
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
event rowfocuschanged pbm_dwnrowchange
integer x = 2834
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

type ddlb_1 from dropdownlistbox within w_cambio_periodo_ingreso
integer x = 1271
integer y = 192
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

type uo_1 from uo_ver_per_ani within w_cambio_periodo_ingreso
integer y = 16
integer width = 1243
integer height = 168
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_captura within w_cambio_periodo_ingreso
integer x = 23
integer y = 332
integer width = 3607
integer height = 1428
integer taborder = 0
string dataobject = "d_cambio_periodo_ingreso"
boolean hscrollbar = true
end type

event carga;/*Antes de cargar algo, ve si hay modificaciones no guardadas*/
event primero()
return retrieve(gi_periodo,gi_anio)

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
string ls_mensaje_sql

hoy=datetime(today(),now())

IF row>0 THEN
	ok = messagebox("Folio: "+string(object.aspiran_folio[row])+' '+object.nomb[row],&
		"Con número de Cuenta: "+string(object.general_cuenta[row]),Exclamation!, OKCancel!, 2)
	IF ok = 1 THEN 
		ll_cuenta = object.general_cuenta[row]
		folio=object.aspiran_folio[row]
		nvo_anio=integer(em_ani.text)
		nvo_peri=dw_per.object.clv_per[dw_per.getrow()]
		li_anio_pago=integer(em_ani_pago.text)
		li_periodo_pago=dw_per_pago.object.clv_per[dw_per_pago.getrow()]
		IF nvo_anio=gi_anio and nvo_peri=gi_periodo  THEN
			li_confirma= messagebox("Periodo destino repetido","¿Desea realizar un enlace en el mismo periodo",Question!, YesNo!)
			IF li_confirma<>1 THEN
				RETURN
			END IF
		END IF
			li_codigo_sql = f_existe_alumno(ll_cuenta)
			IF li_codigo_sql= 100 THEN
				MessageBox("El alumno no existe en control escolar","Es necesario realizar el enlace del alumno antes de cambiar su periodo de ingreso",StopSign!)
				RETURN
			ELSEIF li_codigo_sql= -1 THEN
				MessageBox("Error al consultar academicos","No es posible cambiar su periodo de ingreso",StopSign!)				
				RETURN
			END IF	
			
			IF iuo_administrador_liberacion.of_liberacion_vigente("SIT") THEN
//				IF (ll_cuenta =187158) or (ll_cuenta =187194) THEN				
//					li_cambio_periodo= f_apartado_lugar_cob_sit_tmp(ll_cuenta, li_periodo_pago, li_anio_pago, nvo_peri, nvo_anio)						
//				ELSE				
					li_cambio_periodo= f_apartado_lugar_cob_sit(ll_cuenta, li_periodo_pago, li_anio_pago, nvo_peri, nvo_anio)	
//				END IF
			ELSE 
				li_cambio_periodo= f_apartado_lugar_cob(ll_cuenta, gi_periodo, gi_anio, nvo_peri, nvo_anio)
			END IF
			
			IF li_cambio_periodo= 0 THEN
				MessageBox("Cambio Exitoso","El alumno ha cambiado de periodo exitosamente",Information!)
				RETURN
			ELSEIF li_cambio_periodo= -1 THEN
				MessageBox("Error al cambiar de periodo","No es posible efectuar el cambio",StopSign!)
				RETURN
			END IF				
				
	END IF

END IF
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

