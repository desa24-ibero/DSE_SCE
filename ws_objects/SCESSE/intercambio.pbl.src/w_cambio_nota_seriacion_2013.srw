$PBExportHeader$w_cambio_nota_seriacion_2013.srw
forward
global type w_cambio_nota_seriacion_2013 from w_master_main
end type
type dw_materias_ligadas_inscritas from uo_master_dw within w_cambio_nota_seriacion_2013
end type
type dw_materias_ligadas_historico from uo_master_dw within w_cambio_nota_seriacion_2013
end type
type cb_sancion_inscritas from commandbutton within w_cambio_nota_seriacion_2013
end type
type cb_sancion_cursadas from commandbutton within w_cambio_nota_seriacion_2013
end type
type dw_aviso_tesoreria_intercambio from datawindow within w_cambio_nota_seriacion_2013
end type
type dw_aviso_archivo_intercambio from datawindow within w_cambio_nota_seriacion_2013
end type
end forward

global type w_cambio_nota_seriacion_2013 from w_master_main
integer width = 3785
integer height = 2240
string title = "Materias ligadas..."
boolean maxbox = false
windowtype windowtype = popup!
dw_materias_ligadas_inscritas dw_materias_ligadas_inscritas
dw_materias_ligadas_historico dw_materias_ligadas_historico
cb_sancion_inscritas cb_sancion_inscritas
cb_sancion_cursadas cb_sancion_cursadas
dw_aviso_tesoreria_intercambio dw_aviso_tesoreria_intercambio
dw_aviso_archivo_intercambio dw_aviso_archivo_intercambio
end type
global w_cambio_nota_seriacion_2013 w_cambio_nota_seriacion_2013

type variables
str_msgparm istr_msgparm

n_cst_cambio_nota inv_cambio_nota

long il_cuenta,il_carrera
end variables

on w_cambio_nota_seriacion_2013.create
int iCurrent
call super::create
this.dw_materias_ligadas_inscritas=create dw_materias_ligadas_inscritas
this.dw_materias_ligadas_historico=create dw_materias_ligadas_historico
this.cb_sancion_inscritas=create cb_sancion_inscritas
this.cb_sancion_cursadas=create cb_sancion_cursadas
this.dw_aviso_tesoreria_intercambio=create dw_aviso_tesoreria_intercambio
this.dw_aviso_archivo_intercambio=create dw_aviso_archivo_intercambio
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_materias_ligadas_inscritas
this.Control[iCurrent+2]=this.dw_materias_ligadas_historico
this.Control[iCurrent+3]=this.cb_sancion_inscritas
this.Control[iCurrent+4]=this.cb_sancion_cursadas
this.Control[iCurrent+5]=this.dw_aviso_tesoreria_intercambio
this.Control[iCurrent+6]=this.dw_aviso_archivo_intercambio
end on

on w_cambio_nota_seriacion_2013.destroy
call super::destroy
destroy(this.dw_materias_ligadas_inscritas)
destroy(this.dw_materias_ligadas_historico)
destroy(this.cb_sancion_inscritas)
destroy(this.cb_sancion_cursadas)
destroy(this.dw_aviso_tesoreria_intercambio)
destroy(this.dw_aviso_archivo_intercambio)
end on

event open;call super::open;long ll_trans_object, ll_trans_object_2 , ll_trans_object_3,ll_trans_object_4, ll_rows_inscritas, ll_rows_historico, ll_rows_aviso, ll_rows_aviso_archivo
string ls_movimiento = 'Baja'
/*----------------------------------------------------------------------*/
/* Centramos la ventana.																*/
/*----------------------------------------------------------------------*/

this.x = (this.parentwindow().x + this.parentwindow().width - this.width) / 2
this.y = (this.parentwindow().y + this.parentwindow().height - this.height) / 2

/*----------------------------------------------------------------------*/
/* Lectura de parametros.																*/
/*----------------------------------------------------------------------*/
istr_msgparm = Message.PowerObjectParm

inv_cambio_nota = Create using "n_cst_cambio_nota"

il_cuenta = istr_msgparm.data[1] 
il_carrera = istr_msgparm.data[12] 

ll_trans_object   = this.dw_materias_ligadas_inscritas.settransobject(gtr_sce)
ll_trans_object_2 = this.dw_materias_ligadas_historico.settransobject(gtr_sce)

ll_trans_object_3 = this.dw_aviso_tesoreria_intercambio.settransobject(gtr_sce)
ll_trans_object_4 = this.dw_aviso_archivo_intercambio.settransobject(gtr_sce)

//ll_rows_inscritas = this.dw_materias_ligadas_inscritas.retrieve(istr_msgparm.data[1],istr_msgparm.data[2])
//ll_rows_historico = this.dw_materias_ligadas_historico.retrieve(istr_msgparm.data[1],istr_msgparm.data[2])

ll_rows_inscritas = this.dw_materias_ligadas_inscritas.retrieve(il_cuenta,il_carrera)
ll_rows_historico = this.dw_materias_ligadas_historico.retrieve(il_cuenta,il_carrera)

ll_rows_aviso         = this.dw_aviso_tesoreria_intercambio.retrieve(il_cuenta,ls_movimiento,il_carrera)
ll_rows_aviso_archivo = this.dw_aviso_archivo_intercambio.retrieve(il_cuenta,il_carrera)



end event

event closequery;//
end event

event close;close(this)
end event

type st_sistema from w_master_main`st_sistema within w_cambio_nota_seriacion_2013
end type

type p_ibero from w_master_main`p_ibero within w_cambio_nota_seriacion_2013
end type

type dw_materias_ligadas_inscritas from uo_master_dw within w_cambio_nota_seriacion_2013
integer x = 37
integer y = 324
integer width = 3657
integer height = 708
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "MATERIAS INSCRITAS ACTUALES"
string dataobject = "d_seriacion_int_inscritas_prov_2013"
end type

event dberror;CHOOSE CASE sqldbcode
	CASE 277
		RETURN 1		
	CASE ELSE
		RETURN 0		
END CHOOSE
end event

type dw_materias_ligadas_historico from uo_master_dw within w_cambio_nota_seriacion_2013
integer x = 37
integer y = 1228
integer width = 3657
integer height = 708
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "MATERIAS YA CURSADAS EN HISTORICO"
string dataobject = "d_seriacion_int_historico_prov_2013"
end type

type cb_sancion_inscritas from commandbutton within w_cambio_nota_seriacion_2013
integer x = 1774
integer y = 1084
integer width = 914
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Sanciona Violación de Materias Inscritas"
end type

event clicked;	integer li_sanciona_ser_int_mat_insc, li_confirmacion, li_confirmacion2, li_print
long ll_rows_tesoreria, ll_rows_inscritas
string ls_movimiento = 'Baja'

li_confirmacion2= MessageBox("Aviso","¿Desea imprimir las materias que violan la seriación?",Question!,YesNo!)

if li_confirmacion2 = 1  and dw_aviso_tesoreria_intercambio.Rowcount() > 0 then
	li_print= dw_aviso_tesoreria_intercambio.Print()
	if li_print = 1 then
		MessageBox("Información","Se imprimió el reporte exitosamente",Information!)		
	else		
		MessageBox("Error","NO imprimió el reporte",StopSign!)		
	end if
end if


li_confirmacion = MessageBox("¡Advertencia!","¿Desea sancionar la violación en la seriación?~nEste proceso eliminará las materias inscritas que estén seriadas con su antecesor reprobado",Question!,YesNo!)

if li_confirmacion = 1 then
	li_sanciona_ser_int_mat_insc= inv_cambio_nota.of_sanciona_ser_int_mat_insc(il_cuenta)
	if li_sanciona_ser_int_mat_insc= -1 then
		MessageBox("Error","No se sancionaron las materias correctamente",StopSign!)
	else 
		MessageBox("Información","Se sancionaron las materias correctamente",Information!)
	end if
else
	MessageBox("Información","NO se sancionaron las materias",Information!)
end if

ll_rows_inscritas = dw_materias_ligadas_inscritas.retrieve(il_cuenta,il_carrera)
ll_rows_tesoreria = dw_aviso_tesoreria_intercambio.retrieve(il_cuenta, ls_movimiento,il_carrera)
end event

type cb_sancion_cursadas from commandbutton within w_cambio_nota_seriacion_2013
integer x = 1774
integer y = 1972
integer width = 933
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Sanciona Violación de Materias Cursadas"
end type

event clicked;//

integer li_sanciona_ser_int_mat_insc, li_confirmacion, li_confirmacion2, li_print
long ll_rows_archivo, ll_rows_historico

li_confirmacion2= MessageBox("Aviso","¿Desea imprimir las materias que violan la seriación?",Question!,YesNo!)

if li_confirmacion2 = 1 and dw_aviso_archivo_intercambio.Rowcount() > 0 then
	li_print= dw_aviso_archivo_intercambio.Print()
	if li_print = 1 then
		MessageBox("Información","Se imprimió el reporte exitosamente",Information!)		
	else		
		MessageBox("Error","NO imprimió el reporte",StopSign!)		
	end if
end if

li_confirmacion = MessageBox("¡Advertencia!","¿Desea sancionar la violación en la seriación?~nEste proceso eliminará las materias cursadas en historico que estén seriadas con su antecesor reprobado",Question!,YesNo!)

if li_confirmacion = 1 then
	li_sanciona_ser_int_mat_insc= inv_cambio_nota.of_sanciona_ser_int_historico(il_cuenta)
	if li_sanciona_ser_int_mat_insc= -1 then
		MessageBox("Error","No se sancionaron las materias correctamente",StopSign!)
	else 
		MessageBox("Información","Se sancionaron las materias correctamente",Information!)
	end if
else
	MessageBox("Información","NO se sancionaron las materias",Information!)
end if

ll_rows_historico = dw_materias_ligadas_historico.retrieve(il_cuenta,il_carrera)
ll_rows_archivo = dw_aviso_archivo_intercambio.retrieve(il_cuenta,il_carrera)
end event

type dw_aviso_tesoreria_intercambio from datawindow within w_cambio_nota_seriacion_2013
integer x = 2711
integer y = 1084
integer width = 955
integer height = 84
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_aviso_tesoreria_interc_prov"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_aviso_archivo_intercambio from datawindow within w_cambio_nota_seriacion_2013
integer x = 2725
integer y = 1980
integer width = 955
integer height = 84
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_aviso_archivo_intercambio_prov"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

