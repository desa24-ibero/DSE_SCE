$PBExportHeader$w_cambio_version_examen.srw
forward
global type w_cambio_version_examen from window
end type
type st_2 from statictext within w_cambio_version_examen
end type
type vsb_dw_version from vscrollbar within w_cambio_version_examen
end type
type dw_version from datawindow within w_cambio_version_examen
end type
type st_1 from statictext within w_cambio_version_examen
end type
type em_ani from editmask within w_cambio_version_examen
end type
type dw_per from datawindow within w_cambio_version_examen
end type
type ddlb_1 from dropdownlistbox within w_cambio_version_examen
end type
type uo_1 from uo_ver_per_ani within w_cambio_version_examen
end type
type dw_1 from uo_dw_captura within w_cambio_version_examen
end type
type vsb_dw_per from vscrollbar within w_cambio_version_examen
end type
end forward

global type w_cambio_version_examen from window
integer x = 834
integer y = 362
integer width = 3661
integer height = 1798
boolean titlebar = true
string title = "Cambio de Versión de Exámen - Cancelación de Folio"
string menuname = "m_menu"
long backcolor = 30976088
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
global w_cambio_version_examen w_cambio_version_examen

type variables
int ord
uo_administrador_liberacion iuo_administrador_liberacion
end variables

on w_cambio_version_examen.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
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
this.Control[]={this.st_2,&
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

on w_cambio_version_examen.destroy
if IsValid(MenuID) then destroy(MenuID)
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

type st_2 from statictext within w_cambio_version_examen
integer x = 2772
integer y = 102
integer width = 483
integer height = 61
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 30976088
string text = "Nueva Versión"
alignment alignment = center!
boolean focusrectangle = false
end type

type vsb_dw_version from vscrollbar within w_cambio_version_examen
integer x = 3321
integer y = 189
integer width = 106
integer height = 106
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

type dw_version from datawindow within w_cambio_version_examen
integer x = 2703
integer y = 189
integer width = 625
integer height = 106
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

type st_1 from statictext within w_cambio_version_examen
integer x = 457
integer y = 221
integer width = 406
integer height = 61
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

type em_ani from editmask within w_cambio_version_examen
event modified pbm_enmodified
boolean visible = false
integer x = 1562
integer y = 189
integer width = 347
integer height = 102
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

type dw_per from datawindow within w_cambio_version_examen
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
event rowfocuschanged pbm_dwnrowchange
boolean visible = false
integer x = 1949
integer y = 189
integer width = 625
integer height = 106
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

type ddlb_1 from dropdownlistbox within w_cambio_version_examen
integer x = 896
integer y = 211
integer width = 347
integer height = 230
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

type uo_1 from uo_ver_per_ani within w_cambio_version_examen
integer x = 11
integer y = 16
integer width = 2282
integer height = 166
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_captura within w_cambio_version_examen
integer x = 22
integer y = 346
integer width = 3591
integer height = 1254
integer taborder = 0
string dataobject = "d_cambio_version_examen"
boolean hscrollbar = true
end type

event type integer carga();/*Antes de cargar algo, ve si hay modificaciones no guardadas*/
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
str_aspirante lstr_aspirante
integer li_clv_ver_nueva, li_nvo_folio

hoy=datetime(today(),now())

IF row>0 THEN
	ll_folio_actual = object.aspiran_folio[row]
	ll_cuenta_actual = object.general_cuenta[row]
	ls_nombre = object.nomb[row]
	ok = messagebox("Desea Cambiar la Versión del Examen", "Folio Actual: "+string(ll_folio_actual)+' ~n'+ls_nombre+&
			" ~nNúmero de Cuenta: "+string(ll_cuenta_actual),Exclamation!, YesNo!, 2)

	IF ok = 1 THEN 
		li_nvo_folio = messagebox("Desea generar un NUEVO FOLIO ", "Folio Actual: "+string(ll_folio_actual)+' ~n'+ls_nombre+&
			" ~nNúmero de Cuenta: "+string(ll_cuenta_actual),Exclamation!, YesNo!, 2)
		li_clv_ver_nueva =	dw_version.object.clv_ver[dw_version.getrow()]
		nvo_anio=integer(em_ani.text)
		nvo_peri=dw_per.object.clv_per[dw_per.getrow()]
	
		lstr_aspirante.folio		= 	ll_folio_actual
		lstr_aspirante.clv_ver	= 	li_clv_ver_nueva
		lstr_aspirante.clv_per	= 	gi_periodo
		lstr_aspirante.anio		= 	gi_anio
		IF li_nvo_folio=1 THEN
			OpenWithParm(w_folio_enlace, lstr_aspirante, w_cambio_version_examen)
			if isvalid(Message.PowerObjectParm) then
				lstr_aspirante= Message.PowerObjectParm
				ll_folio_nuevo= lstr_aspirante.folio
			else
				ll_folio_nuevo= ll_folio_actual
			end if
		ELSE
			ll_folio_nuevo= ll_folio_actual

		END IF

////		li_anio_pago=integer(em_ani_pago.text)
////		li_periodo_pago=dw_per_pago.object.clv_per[dw_per_pago.getrow()]
		IF gi_version=li_clv_ver_nueva  THEN
			li_confirma= messagebox("Periodo destino repetido","¿Desea realizar un enlace en el mismo periodo",Question!, YesNo!)
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
			
			li_cambio_periodo= f_cambio_version_examen_sit(ll_folio_actual, gi_version, gi_periodo, gi_anio, ll_folio_nuevo,li_clv_ver_nueva)	
			
			IF li_cambio_periodo= 0 THEN
				MessageBox("Cambio Exitoso","El alumno ha cambiado de versión exitosamente",Information!)
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

type vsb_dw_per from vscrollbar within w_cambio_version_examen
event linedown pbm_sbnlinedown
event lineup pbm_sbnlineup
event moved pbm_sbnthumbtrack
event pagedown pbm_sbnpagedown
event pageup pbm_sbnpageup
boolean visible = false
integer x = 2567
integer y = 189
integer width = 106
integer height = 106
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

