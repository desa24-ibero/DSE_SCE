$PBExportHeader$w_administracion_grupos2.srw
forward
global type w_administracion_grupos2 from w_master
end type
type st_clase_aula from statictext within w_administracion_grupos2
end type
type uo_i_clase_aula from uo_clase_aula within w_administracion_grupos2
end type
type lb_grupos_origen from u_lb within w_administracion_grupos2
end type
type lb_grupos_destino from u_lb within w_administracion_grupos2
end type
type uo_coordinacion from uo_coordinaciones within w_administracion_grupos2
end type
type st_1 from statictext within w_administracion_grupos2
end type
type cb_cargar_grupos from u_cb within w_administracion_grupos2
end type
type cb_aniade from u_cb within w_administracion_grupos2
end type
type cb_quita from u_cb within w_administracion_grupos2
end type
type cb_aniade_todos from u_cb within w_administracion_grupos2
end type
type cb_quita_todos from u_cb within w_administracion_grupos2
end type
type uo_1 from uo_per_ani within w_administracion_grupos2
end type
type cb_establece_periodo from u_cb within w_administracion_grupos2
end type
type st_periodo_establecido from statictext within w_administracion_grupos2
end type
type cb_eliminar_grupos from u_cb within w_administracion_grupos2
end type
type st_2 from statictext within w_administracion_grupos2
end type
type st_3 from statictext within w_administracion_grupos2
end type
type st_total_origen from statictext within w_administracion_grupos2
end type
type st_total_destino from statictext within w_administracion_grupos2
end type
type cbx_1 from checkbox within w_administracion_grupos2
end type
type uo_salon_horario from uo_salones_horario within w_administracion_grupos2
end type
type st_salon from statictext within w_administracion_grupos2
end type
type cb_limpiar_cve_salon from u_cb within w_administracion_grupos2
end type
type cb_limpiar_todos_salones from u_cb within w_administracion_grupos2
end type
type st_5 from statictext within w_administracion_grupos2
end type
end forward

global type w_administracion_grupos2 from w_master
integer x = 0
integer y = 0
integer width = 2930
integer height = 1928
string title = "Administración de Grupos"
st_clase_aula st_clase_aula
uo_i_clase_aula uo_i_clase_aula
lb_grupos_origen lb_grupos_origen
lb_grupos_destino lb_grupos_destino
uo_coordinacion uo_coordinacion
st_1 st_1
cb_cargar_grupos cb_cargar_grupos
cb_aniade cb_aniade
cb_quita cb_quita
cb_aniade_todos cb_aniade_todos
cb_quita_todos cb_quita_todos
uo_1 uo_1
cb_establece_periodo cb_establece_periodo
st_periodo_establecido st_periodo_establecido
cb_eliminar_grupos cb_eliminar_grupos
st_2 st_2
st_3 st_3
st_total_origen st_total_origen
st_total_destino st_total_destino
cbx_1 cbx_1
uo_salon_horario uo_salon_horario
st_salon st_salon
cb_limpiar_cve_salon cb_limpiar_cve_salon
cb_limpiar_todos_salones cb_limpiar_todos_salones
st_5 st_5
end type
global w_administracion_grupos2 w_administracion_grupos2

type variables
u_administrador_grupos iuo_administrador_grupos 
integer ii_periodo, ii_anio
long il_cve_mat[], il_cve_coordinacion
string is_gpo[], is_coordinacion
boolean ib_desc_sdu_se=false
st_confirma_usuario ist_confirma_usuario 


uo_periodo_servicios iuo_periodo_servicios
end variables

on w_administracion_grupos2.create
int iCurrent
call super::create
this.st_clase_aula=create st_clase_aula
this.uo_i_clase_aula=create uo_i_clase_aula
this.lb_grupos_origen=create lb_grupos_origen
this.lb_grupos_destino=create lb_grupos_destino
this.uo_coordinacion=create uo_coordinacion
this.st_1=create st_1
this.cb_cargar_grupos=create cb_cargar_grupos
this.cb_aniade=create cb_aniade
this.cb_quita=create cb_quita
this.cb_aniade_todos=create cb_aniade_todos
this.cb_quita_todos=create cb_quita_todos
this.uo_1=create uo_1
this.cb_establece_periodo=create cb_establece_periodo
this.st_periodo_establecido=create st_periodo_establecido
this.cb_eliminar_grupos=create cb_eliminar_grupos
this.st_2=create st_2
this.st_3=create st_3
this.st_total_origen=create st_total_origen
this.st_total_destino=create st_total_destino
this.cbx_1=create cbx_1
this.uo_salon_horario=create uo_salon_horario
this.st_salon=create st_salon
this.cb_limpiar_cve_salon=create cb_limpiar_cve_salon
this.cb_limpiar_todos_salones=create cb_limpiar_todos_salones
this.st_5=create st_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_clase_aula
this.Control[iCurrent+2]=this.uo_i_clase_aula
this.Control[iCurrent+3]=this.lb_grupos_origen
this.Control[iCurrent+4]=this.lb_grupos_destino
this.Control[iCurrent+5]=this.uo_coordinacion
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.cb_cargar_grupos
this.Control[iCurrent+8]=this.cb_aniade
this.Control[iCurrent+9]=this.cb_quita
this.Control[iCurrent+10]=this.cb_aniade_todos
this.Control[iCurrent+11]=this.cb_quita_todos
this.Control[iCurrent+12]=this.uo_1
this.Control[iCurrent+13]=this.cb_establece_periodo
this.Control[iCurrent+14]=this.st_periodo_establecido
this.Control[iCurrent+15]=this.cb_eliminar_grupos
this.Control[iCurrent+16]=this.st_2
this.Control[iCurrent+17]=this.st_3
this.Control[iCurrent+18]=this.st_total_origen
this.Control[iCurrent+19]=this.st_total_destino
this.Control[iCurrent+20]=this.cbx_1
this.Control[iCurrent+21]=this.uo_salon_horario
this.Control[iCurrent+22]=this.st_salon
this.Control[iCurrent+23]=this.cb_limpiar_cve_salon
this.Control[iCurrent+24]=this.cb_limpiar_todos_salones
this.Control[iCurrent+25]=this.st_5
end on

on w_administracion_grupos2.destroy
call super::destroy
destroy(this.st_clase_aula)
destroy(this.uo_i_clase_aula)
destroy(this.lb_grupos_origen)
destroy(this.lb_grupos_destino)
destroy(this.uo_coordinacion)
destroy(this.st_1)
destroy(this.cb_cargar_grupos)
destroy(this.cb_aniade)
destroy(this.cb_quita)
destroy(this.cb_aniade_todos)
destroy(this.cb_quita_todos)
destroy(this.uo_1)
destroy(this.cb_establece_periodo)
destroy(this.st_periodo_establecido)
destroy(this.cb_eliminar_grupos)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_total_origen)
destroy(this.st_total_destino)
destroy(this.cbx_1)
destroy(this.uo_salon_horario)
destroy(this.st_salon)
destroy(this.cb_limpiar_cve_salon)
destroy(this.cb_limpiar_todos_salones)
destroy(this.st_5)
end on

event open;call super::open;iuo_administrador_grupos = CREATE u_administrador_grupos
x=1
y=1


iuo_periodo_servicios = CREATE uo_periodo_servicios
iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, 'L', gtr_sce) 


end event

event close;call super::close;IF isvalid(iuo_administrador_grupos) THEN
	DESTROY iuo_administrador_grupos
END IF
end event

event closequery;RETURN 0
end event

event pfc_postopen;call super::pfc_postopen;cb_establece_periodo.event Clicked()
end event

type st_clase_aula from statictext within w_administracion_grupos2
integer x = 50
integer y = 692
integer width = 393
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Clase de Aula"
boolean focusrectangle = false
end type

type uo_i_clase_aula from uo_clase_aula within w_administracion_grupos2
integer x = 434
integer y = 668
integer width = 590
integer height = 120
integer taborder = 80
boolean border = false
end type

on uo_i_clase_aula.destroy
call uo_clase_aula::destroy
end on

type lb_grupos_origen from u_lb within w_administracion_grupos2
integer x = 1166
integer y = 640
integer width = 448
integer height = 940
integer taborder = 90
boolean bringtotop = true
end type

event doubleclicked;call super::doubleclicked;cb_aniade.event clicked()
end event

type lb_grupos_destino from u_lb within w_administracion_grupos2
integer x = 1938
integer y = 636
integer width = 448
integer height = 956
integer taborder = 100
boolean bringtotop = true
end type

event doubleclicked;call super::doubleclicked;cb_quita.event clicked()
end event

type uo_coordinacion from uo_coordinaciones within w_administracion_grupos2
integer x = 517
integer y = 220
integer width = 1975
integer height = 124
integer taborder = 30
boolean bringtotop = true
boolean border = false
long backcolor = 79741120
end type

on uo_coordinacion.destroy
call uo_coordinaciones::destroy
end on

event constructor;call super::constructor;this.dw_coordinaciones.width= this.width - 20
this.dw_coordinaciones.Object.cve_coordinacion.width= this.width - 55
this.dw_coordinaciones.enabled= true


end event

type st_1 from statictext within w_administracion_grupos2
integer x = 91
integer y = 244
integer width = 375
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Coordinación"
boolean focusrectangle = false
end type

type cb_cargar_grupos from u_cb within w_administracion_grupos2
integer x = 1586
integer y = 508
integer width = 375
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string text = "Cargar Grupos"
end type

event clicked;call super::clicked;long ll_res_grupos, ll_cve_coordinacion, ll_row_coordinacion, ll_num_grupos
long ll_row, ll_cve_mat, ll_indice_array, ll_tamanio_array, ll_null, ll_total_items_origen, ll_total_items_destino
string ls_gpo, ls_cve_mat_gpo, ls_null, ls_coordinacion, ls_asimilante
long ll_grupos_que_asimila

lb_grupos_destino.Reset()
lb_grupos_origen.Reset()


ll_row_coordinacion = uo_coordinacion.dw_coordinaciones.GetRow()

ll_cve_coordinacion = uo_coordinacion.dw_coordinaciones.GetItemNumber(ll_row_coordinacion, "cve_coordinacion")
ls_coordinacion = uo_coordinacion.dw_coordinaciones.GetItemString(ll_row_coordinacion, "coordinacion")

il_cve_coordinacion= ll_cve_coordinacion
is_coordinacion= ls_coordinacion

SetPointer(HourGlass!)

ll_res_grupos= iuo_administrador_grupos.of_obten_grupos_coord(ll_cve_coordinacion, ii_periodo,ii_anio)

IF ll_res_grupos= -1 THEN
	RETURN
ELSEIF ll_res_grupos= 0 THEN
	MessageBox("","")
END IF

ll_num_grupos= iuo_administrador_grupos.ids_grupos_coord.RowCount()

FOR ll_row = 1 TO ll_num_grupos
	
	ll_cve_mat= iuo_administrador_grupos.ids_grupos_coord.GetItemNumber(ll_row, "cve_mat")
	ls_gpo= iuo_administrador_grupos.ids_grupos_coord.GetItemString(ll_row, "gpo")
	ll_grupos_que_asimila= iuo_administrador_grupos.ids_grupos_coord.GetItemNumber(ll_row, "grupos_que_asimila")
	IF ll_grupos_que_asimila > 0 THEN
		ls_asimilante = " *"
	ELSE
		ls_asimilante = ""		
	END IF
	ls_cve_mat_gpo = string(ll_cve_mat)+"-"+ls_gpo+ls_asimilante
	lb_grupos_origen.AddItem(ls_cve_mat_gpo)	
	
NEXT


ll_total_items_origen = lb_grupos_origen.TotalItems()
ll_total_items_destino = lb_grupos_destino.TotalItems()

st_total_origen.text = string(ll_total_items_origen)
st_total_destino.text = string(ll_total_items_destino)

end event

type cb_aniade from u_cb within w_administracion_grupos2
integer x = 1691
integer y = 812
integer width = 178
integer taborder = 110
boolean bringtotop = true
string text = "->"
end type

event clicked;call super::clicked;long ll_index_origen, ll_total_items_origen, ll_total_items_destino
string ls_item_origen


ll_index_origen = lb_grupos_origen.SelectedIndex()

DO WHILE ll_index_origen > 0

	ls_item_origen = lb_grupos_origen.SelectedItem()
	IF not isnull(ls_item_origen) and ls_item_origen<>"" THEN
		IF pos(ls_item_origen," *") = 0 THEN
			lb_grupos_destino.AddItem(ls_item_origen)

			lb_grupos_origen.DeleteItem(ll_index_origen)
		ELSE
			RETURN
		END IF
	END IF
	ll_index_origen = lb_grupos_origen.SelectedIndex()
LOOP

ll_total_items_origen = lb_grupos_origen.TotalItems()
ll_total_items_destino = lb_grupos_destino.TotalItems()

st_total_origen.text = string(ll_total_items_origen)
st_total_destino.text = string(ll_total_items_destino)





end event

type cb_quita from u_cb within w_administracion_grupos2
integer x = 1691
integer y = 956
integer width = 178
integer taborder = 120
boolean bringtotop = true
string text = "<-"
end type

event clicked;call super::clicked;long ll_index_destino, ll_total_items_origen, ll_total_items_destino
string ls_item_destino

ll_index_destino = lb_grupos_destino.SelectedIndex()
DO WHILE ll_index_destino > 0
	
	ls_item_destino = lb_grupos_destino.SelectedItem()
	IF not isnull(ls_item_destino) and ls_item_destino<>"" THEN
	
		lb_grupos_origen.AddItem(ls_item_destino)

		lb_grupos_destino.DeleteItem(ll_index_destino)

	END IF
	ll_index_destino = lb_grupos_destino.SelectedIndex()	
LOOP

ll_total_items_origen = lb_grupos_origen.TotalItems()
ll_total_items_destino = lb_grupos_destino.TotalItems()

st_total_origen.text = string(ll_total_items_origen)
st_total_destino.text = string(ll_total_items_destino)

end event

type cb_aniade_todos from u_cb within w_administracion_grupos2
integer x = 1691
integer y = 1100
integer width = 178
integer taborder = 130
boolean bringtotop = true
string text = ">>"
end type

event clicked;call super::clicked;long ll_index_origen, ll_total_items, ll_index, ll_total_items_origen, ll_total_items_destino, ll_sig_item
string ls_item_origen

ll_sig_item=1

DO WHILE lb_grupos_origen.TotalItems() >= ll_sig_item 

	ll_index = lb_grupos_origen.SelectItem(ll_sig_item)
	
	ll_index_origen = lb_grupos_origen.SelectedIndex()
	ls_item_origen = lb_grupos_origen.SelectedItem()
	IF not isnull(ls_item_origen) and ls_item_origen<>"" THEN
		IF pos(ls_item_origen," *") = 0 THEN
	
			lb_grupos_destino.AddItem(ls_item_origen)

			lb_grupos_origen.DeleteItem(ll_index_origen)
		ELSE 
			ll_sig_item= ll_sig_item +1
		END IF
	END IF
LOOP


ll_total_items_origen = lb_grupos_origen.TotalItems()
ll_total_items_destino = lb_grupos_destino.TotalItems()

st_total_origen.text = string(ll_total_items_origen)
st_total_destino.text = string(ll_total_items_destino)

end event

type cb_quita_todos from u_cb within w_administracion_grupos2
integer x = 1691
integer y = 1244
integer width = 178
integer taborder = 140
boolean bringtotop = true
string text = "<<"
end type

event clicked;call super::clicked;long ll_index_destino, ll_total_items, ll_index, ll_total_items_origen, ll_total_items_destino
string ls_item_origen


DO WHILE lb_grupos_destino.TotalItems() > 0

	ll_index = lb_grupos_destino.SelectItem(1)
	
	ll_index_destino = lb_grupos_destino.SelectedIndex()
	ls_item_origen = lb_grupos_destino.SelectedItem()
	IF not isnull(ls_item_origen) and ls_item_origen<>"" THEN
	
		lb_grupos_origen.AddItem(ls_item_origen)

		lb_grupos_destino.DeleteItem(ll_index_destino)

	END IF
LOOP


ll_total_items_origen = lb_grupos_origen.TotalItems()
ll_total_items_destino = lb_grupos_destino.TotalItems()

st_total_origen.text = string(ll_total_items_origen)
st_total_destino.text = string(ll_total_items_destino)

end event

type uo_1 from uo_per_ani within w_administracion_grupos2
integer x = 18
integer y = 16
integer width = 1253
integer height = 168
integer taborder = 10
boolean bringtotop = true
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type cb_establece_periodo from u_cb within w_administracion_grupos2
integer x = 1321
integer y = 60
integer width = 462
integer taborder = 20
boolean bringtotop = true
string text = "Establece Periodo"
end type

event clicked;call super::clicked;string ls_periodo, ls_anio, ls_periodo_anio
long ll_total_items_origen, ll_total_items_destino

//CHOOSE CASE gi_periodo
//	CASE 0
//		ls_periodo= "PRIMAVERA"
//	CASE 1
//		ls_periodo= "VERANO"
//	CASE 2
//		ls_periodo= "OTOÑO"
//	CASE ELSE 
//		ls_periodo= "ERROR GRAVE"		
//END CHOOSE 

ls_periodo_anio = iuo_periodo_servicios.f_recupera_descripcion( gi_periodo, 'L') 

//ls_periodo_anio = ls_periodo + " "+ STRING(gi_anio) 
ls_periodo_anio = ls_periodo_anio + " "+ STRING(gi_anio) 

st_periodo_establecido.text = ls_periodo_anio

ii_periodo= gi_periodo
ii_anio = gi_anio

lb_grupos_destino.Reset()
lb_grupos_origen.Reset()

uo_salon_horario.of_establece_periodo(ii_periodo, ii_anio)

ll_total_items_origen = lb_grupos_origen.TotalItems()
ll_total_items_destino = lb_grupos_destino.TotalItems()

st_total_origen.text = string(ll_total_items_origen)
st_total_destino.text = string(ll_total_items_destino)

end event

type st_periodo_establecido from statictext within w_administracion_grupos2
integer x = 1856
integer y = 60
integer width = 722
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_eliminar_grupos from u_cb within w_administracion_grupos2
integer x = 2427
integer y = 508
integer width = 398
integer taborder = 150
boolean bringtotop = true
fontcharset fontcharset = ansi!
string text = "Eliminar Grupos"
end type

event clicked;call super::clicked;long ll_index_destino, ll_tamanio_array, ll_null, ll_indice_array, ll_total_items, ll_item_actual, ll_index
string ls_item_destino, ls_null, ls_gpo, ls_cve_mat, ls_mensaje_sql
long ll_cve_mat, ll_total_items_origen, ll_total_items_destino
integer li_confirma, li_reset_grupos, li_obten_gpos_coord


ll_tamanio_array= upperbound(il_cve_mat)

SetNull(ll_null)
SetNull(ls_null)

FOR ll_indice_array = 1 TO ll_tamanio_array
	il_cve_mat[ll_indice_array]= ll_null
	is_gpo[ll_indice_array]= ls_null
NEXT

//ll_index_origen = lb_grupos_destino.SelectedIndex()
//ls_item_origen = lb_grupos_destino.SelectedItem()

ll_total_items = lb_grupos_destino.TotalItems()

IF ll_total_items=0 THEN
	MessageBox("Seleccione Grupos", "No existen grupos seleccionados de la coordinación ["+&
 							string(il_cve_coordinacion)+"]",StopSign!)
	RETURN							 
END IF

FOR ll_item_actual= 1 TO ll_total_items
	ll_index = lb_grupos_destino.SelectItem(ll_item_actual)
	ll_index_destino = lb_grupos_destino.SelectedIndex()
	ls_item_destino = lb_grupos_destino.SelectedItem()
	IF not isnull(ls_item_destino) and ls_item_destino<>"" THEN
		ls_cve_mat = mid(ls_item_destino,1, pos(ls_item_destino,"-")-1)
		ll_cve_mat = long(ls_cve_mat)
		ls_gpo = mid(ls_item_destino, pos(ls_item_destino,"-")+1, len(ls_item_destino))
		il_cve_mat[ll_item_actual]= ll_cve_mat
		is_gpo[ll_item_actual]= ls_gpo
	END IF
NEXT



li_confirma=MessageBox("Confirme Eliminación", "¿Desea eliminar los ["+string(ll_total_items)+"] grupos seleccionados de la coordinación~n["+&
 							string(il_cve_coordinacion)+"] ?",Question!, YesNo!)
							 
IF li_confirma <> 1 THEN
	RETURN
ELSE
	Open(w_confirma_usuario)
	ist_confirma_usuario = Message.PowerObjectParm
	IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
		MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
		RETURN
	END IF
END IF


li_reset_grupos= iuo_administrador_grupos.of_reset_dw()
IF li_reset_grupos= -1 THEN
	RETURN
ELSEIF li_reset_grupos= 0 THEN
	MessageBox("Grupos inexistentes","No se encuentran grupos")
END IF

SetPointer(HourGlass!)
li_obten_gpos_coord= iuo_administrador_grupos.of_obten_grupos_coord(il_cve_coordinacion, ii_periodo,ii_anio)

IF li_obten_gpos_coord= -1 THEN
	RETURN
ELSEIF li_obten_gpos_coord= 0 THEN
	MessageBox("Grupos inexistentes","No se encuentran grupos")
END IF


IF iuo_administrador_grupos.of_asigna_arrays_grupos(il_cve_mat, is_gpo) <= 0 THEN
	RETURN
END IF
gtr_sce.autocommit = false
IF iuo_administrador_grupos.of_borra_ds_coord(iuo_administrador_grupos.ids_horario_coord)= 1 AND & 
   iuo_administrador_grupos.of_borra_ds_coord(iuo_administrador_grupos.ids_profesor_auxiliar_coord)= 1 AND &
	iuo_administrador_grupos.of_borra_ds_coord(iuo_administrador_grupos.ids_grupos_coord)= 1 THEN
	
	IF iuo_administrador_grupos.of_actualiza_sdu_coord(ib_desc_sdu_se)= 1 THEN
		IF iuo_administrador_grupos.ids_horario_coord.Update()=1 THEN
			IF	iuo_administrador_grupos.ids_profesor_auxiliar_coord.Update()=1 THEN
				IF iuo_administrador_grupos.ids_grupos_coord.update()=1 THEN

						COMMIT USING gtr_sce;
						messagebox("Información","Los grupos de la coordinacion ["+string(il_cve_coordinacion)+"] se han eliminado exitosamente",Information!)					
						lb_grupos_destino.Reset()
						ll_total_items_origen = lb_grupos_origen.TotalItems()
						ll_total_items_destino = lb_grupos_destino.TotalItems()
						st_total_origen.text = string(ll_total_items_origen)
						st_total_destino.text = string(ll_total_items_destino)
						RETURN 1
				ELSE
					GOTO ERROR
				END IF						
			ELSE
				GOTO ERROR
			END IF						
		ELSE
			GOTO ERROR
		END IF						
	ELSE
		GOTO ERROR
	END IF
	
	
ELSE
	MessageBox("Información","No es posible eliminar los grupos, horarios y los profesores auxiliares~n"+&
	           " de la coordinacion ["+string(il_cve_coordinacion)+"]",StopSign!)					
	RETURN -1


END IF


ERROR:
ls_mensaje_sql= gtr_sce.SqlErrText
ROLLBACK USING gtr_sce;					  
MessageBox("Existen grupos dependientes","Error al eliminar los grupos de la coordinacion ["+string(il_cve_coordinacion)+"]", StopSign!)
ll_total_items_origen = lb_grupos_origen.TotalItems()
ll_total_items_destino = lb_grupos_destino.TotalItems()
st_total_origen.text = string(ll_total_items_origen)
st_total_destino.text = string(ll_total_items_destino)
RETURN -1

end event

type st_2 from statictext within w_administracion_grupos2
integer x = 1632
integer y = 1616
integer width = 315
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean enabled = false
string text = "Total Destino:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_administracion_grupos2
integer x = 850
integer y = 1616
integer width = 311
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean enabled = false
string text = "Total Origen :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_total_origen from statictext within w_administracion_grupos2
integer x = 1266
integer y = 1616
integer width = 251
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean enabled = false
string text = "0"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_total_destino from statictext within w_administracion_grupos2
integer x = 2039
integer y = 1616
integer width = 251
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean enabled = false
string text = "0"
alignment alignment = right!
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_administracion_grupos2
integer x = 1216
integer y = 396
integer width = 1125
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
string text = "Descontar Derecho y uso a Servicios Escolares"
boolean lefttext = true
end type

event clicked;ib_desc_sdu_se=  this.checked 
end event

type uo_salon_horario from uo_salones_horario within w_administracion_grupos2
integer x = 379
integer y = 508
integer width = 357
integer height = 100
integer taborder = 50
boolean bringtotop = true
boolean border = false
end type

on uo_salon_horario.destroy
call uo_salones_horario::destroy
end on

type st_salon from statictext within w_administracion_grupos2
integer x = 169
integer y = 516
integer width = 206
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Salón"
boolean focusrectangle = false
end type

type cb_limpiar_cve_salon from u_cb within w_administracion_grupos2
integer x = 745
integer y = 508
integer width = 375
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
string text = "Limpiar Salon"
end type

event clicked;call super::clicked;long ll_res_grupos, ll_cve_coordinacion, ll_row_coordinacion, ll_num_grupos
long ll_row, ll_cve_mat, ll_indice_array, ll_tamanio_array, ll_null, ll_total_items_origen, ll_total_items_destino
string ls_gpo, ls_cve_mat_gpo, ls_null, ls_coordinacion, ls_cve_salon
long ll_num_horarios_con_salon
integer li_confirma, li_limpia_horario_salon

ls_cve_salon= uo_salon_horario.of_obten_salon()

IF  isnull(ls_cve_salon) or ls_cve_salon="" THEN
	MessageBox("Salon invalido", "No existen salones seleccionables")
	RETURN
ELSE
	ll_num_horarios_con_salon = iuo_administrador_grupos.of_cuenta_horario_de_salon(ii_periodo, ii_anio, ls_cve_salon,9999)
	IF ll_num_horarios_con_salon >=0 THEN
		li_confirma =MessageBox("Confirmación","El salón ["+ls_cve_salon+"] es ocupado en ["+&
					string(ll_num_horarios_con_salon)+"] horarios~n ¿Desea limpiarlo?",Question!, YesNo!)
		IF li_confirma= 1 THEN
			li_limpia_horario_salon = iuo_administrador_grupos.of_limpia_horario_de_salon(ii_periodo, ii_anio, ls_cve_salon,9999)			
			IF li_limpia_horario_salon<> -1 THEN
				MessageBox("Actualización Exitosa","El salón ["+ls_cve_salon+"] ha sido limpiado exitosamente",Information!)
			END IF
		END IF
	END IF
END IF

end event

type cb_limpiar_todos_salones from u_cb within w_administracion_grupos2
integer x = 274
integer y = 880
integer width = 562
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
string text = "Limpiar Todos Salones"
end type

event clicked;call super::clicked;long ll_res_grupos, ll_cve_coordinacion, ll_row_coordinacion, ll_num_grupos
long ll_row, ll_cve_mat, ll_indice_array, ll_tamanio_array, ll_null, ll_total_items_origen, ll_total_items_destino
string ls_gpo, ls_cve_mat_gpo, ls_null, ls_coordinacion, ls_cve_salon
long ll_num_horarios_con_salon, ll_clase_aula
integer li_confirma, li_limpia_horario_salon

ls_cve_salon= "9999"
ll_clase_aula= uo_i_clase_aula.of_obten_clave()
IF  isnull(ls_cve_salon) or ls_cve_salon="" THEN
	MessageBox("Salon invalido", "No existen salones seleccionables")
	RETURN
ELSE
	ll_num_horarios_con_salon = iuo_administrador_grupos.of_cuenta_horario_de_salon(ii_periodo, ii_anio, ls_cve_salon,ll_clase_aula)
	IF ll_num_horarios_con_salon >=0 THEN
		li_confirma =MessageBox("Confirmación","¿Desea limpiar los ["+&
				string(ll_num_horarios_con_salon)+ "] horarios existentes?",Question!, YesNo!)
		IF li_confirma= 1 THEN
			Open(w_confirma_usuario)
			ist_confirma_usuario = Message.PowerObjectParm
			IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
				MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
				RETURN
			END IF	
			SetPointer(HourGlass!)
			li_limpia_horario_salon = iuo_administrador_grupos.of_limpia_horario_de_salon(ii_periodo, ii_anio, ls_cve_salon,ll_clase_aula)			
			IF li_limpia_horario_salon<> -1 THEN
				MessageBox("Actualización Exitosa","El salón ["+ls_cve_salon+"] ha sido limpiado exitosamente",Information!)
			END IF
		END IF
	END IF
END IF

end event

type st_5 from statictext within w_administracion_grupos2
integer x = 370
integer y = 1020
integer width = 741
integer height = 188
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean enabled = false
string text = "* Los grupos con un asterisco al    final no pueden eliminarse por estar asimilando a otro(s) grupos"
boolean focusrectangle = false
end type

