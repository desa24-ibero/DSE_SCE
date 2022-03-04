$PBExportHeader$w_elimina_mat_adeud_pos_prim_ing.srw
forward
global type w_elimina_mat_adeud_pos_prim_ing from window
end type
type dw_finanzas from u_dw within w_elimina_mat_adeud_pos_prim_ing
end type
type dw_laboratorio from u_dw within w_elimina_mat_adeud_pos_prim_ing
end type
type cb_genera_archivo_fin from commandbutton within w_elimina_mat_adeud_pos_prim_ing
end type
type cb_elimina_materias_finanzas from commandbutton within w_elimina_mat_adeud_pos_prim_ing
end type
type em_cantidad_materias_finanzas from editmask within w_elimina_mat_adeud_pos_prim_ing
end type
type cb_contar_materias_finanzas from commandbutton within w_elimina_mat_adeud_pos_prim_ing
end type
type gb_2 from groupbox within w_elimina_mat_adeud_pos_prim_ing
end type
end forward

global type w_elimina_mat_adeud_pos_prim_ing from window
integer x = 846
integer y = 372
integer width = 2482
integer height = 860
boolean titlebar = true
string title = "Elimina Materias de Posgrado  Primer Ingreso con Adeudos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
dw_finanzas dw_finanzas
dw_laboratorio dw_laboratorio
cb_genera_archivo_fin cb_genera_archivo_fin
cb_elimina_materias_finanzas cb_elimina_materias_finanzas
em_cantidad_materias_finanzas em_cantidad_materias_finanzas
cb_contar_materias_finanzas cb_contar_materias_finanzas
gb_2 gb_2
end type
global w_elimina_mat_adeud_pos_prim_ing w_elimina_mat_adeud_pos_prim_ing

type variables
string is_nivel = "L"
string is_nombre_nivel = "Licenciatura"
string is_bloqueo_finanzas = "Bloquear"
integer ii_adeuda_finanzas = 1
st_confirma_usuario ist_confirma_usuario
long il_creditos

end variables

on w_elimina_mat_adeud_pos_prim_ing.create
this.dw_finanzas=create dw_finanzas
this.dw_laboratorio=create dw_laboratorio
this.cb_genera_archivo_fin=create cb_genera_archivo_fin
this.cb_elimina_materias_finanzas=create cb_elimina_materias_finanzas
this.em_cantidad_materias_finanzas=create em_cantidad_materias_finanzas
this.cb_contar_materias_finanzas=create cb_contar_materias_finanzas
this.gb_2=create gb_2
this.Control[]={this.dw_finanzas,&
this.dw_laboratorio,&
this.cb_genera_archivo_fin,&
this.cb_elimina_materias_finanzas,&
this.em_cantidad_materias_finanzas,&
this.cb_contar_materias_finanzas,&
this.gb_2}
end on

on w_elimina_mat_adeud_pos_prim_ing.destroy
destroy(this.dw_finanzas)
destroy(this.dw_laboratorio)
destroy(this.cb_genera_archivo_fin)
destroy(this.cb_elimina_materias_finanzas)
destroy(this.em_cantidad_materias_finanzas)
destroy(this.cb_contar_materias_finanzas)
destroy(this.gb_2)
end on

event open;x=1
y=1
dw_laboratorio.SetTransObject(gtr_sce)
dw_finanzas.SetTransObject(gtr_sce)

end event

type dw_finanzas from u_dw within w_elimina_mat_adeud_pos_prim_ing
boolean visible = false
integer x = 1120
integer y = 596
integer width = 553
integer height = 156
integer taborder = 60
string dataobject = "d_materias_baja_fin_pos_prim_ing"
end type

type dw_laboratorio from u_dw within w_elimina_mat_adeud_pos_prim_ing
boolean visible = false
integer x = 1120
integer y = 284
integer width = 553
integer height = 156
integer taborder = 70
string dataobject = "d_materias_baja_laboratorio"
end type

type cb_genera_archivo_fin from commandbutton within w_elimina_mat_adeud_pos_prim_ing
integer x = 1120
integer y = 284
integer width = 549
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Genera Archivo"
end type

event clicked;long ll_rows, ll_res_genera

ll_rows = dw_finanzas.RowCount()

IF ll_rows = -1 THEN	
	RETURN	
END IF

ll_res_genera = dw_finanzas.SaveAs("",Excel!,TRUE)

IF ll_res_genera = 1 THEN
	cb_elimina_materias_finanzas.enabled=true
ELSE
	cb_elimina_materias_finanzas.enabled=false	
END IF

RETURN
end event

type cb_elimina_materias_finanzas from commandbutton within w_elimina_mat_adeud_pos_prim_ing
integer x = 1696
integer y = 284
integer width = 549
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Eliminar Materias"
end type

event clicked;integer li_confirmacion
long ll_row, ll_rows

ll_rows = dw_finanzas.RowCount()
li_confirmacion= MessageBox("Confirmación","¿Desea eliminar las ["+string(ll_rows)+"] materias por adeudo de finanzas?",Question!,YesNo!)
IF li_confirmacion<>1 THEN
	RETURN
ELSE
	SetPointer(hourglass!)
	FOR ll_row = 1 TO ll_rows
		dw_finanzas.DeleteRow(dw_finanzas.GetRow())
	NEXT
END IF

ll_rows = dw_finanzas.RowCount()

IF ll_rows = 0 THEN
	IF dw_finanzas.Update()= 1 THEN
		COMMIT USING gtr_sce;
		MessageBox("Eliminacion exitosa","Se han eliminado correctamente las materias por adeudo de finanzas",Information!)
	ELSE
		ROLLBACK USING gtr_sce;		
		MessageBox("Error de Eliminacion","No es posible eliminar las materias por adeudo de finanzas",Information!)
	END IF
END IF

end event

type em_cantidad_materias_finanzas from editmask within w_elimina_mat_adeud_pos_prim_ing
integer x = 699
integer y = 284
integer width = 393
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 33554431
string text = "0"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###"
end type

type cb_contar_materias_finanzas from commandbutton within w_elimina_mat_adeud_pos_prim_ing
integer x = 119
integer y = 284
integer width = 549
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Contar Materias"
end type

event clicked;long ll_rows 

ll_rows = dw_finanzas.Retrieve(gs_tipo_periodo) 

IF ll_rows = -1 THEN
	
	RETURN	
END IF


em_cantidad_materias_finanzas.text= string(ll_rows)
cb_genera_archivo_fin.enabled = true
end event

type gb_2 from groupbox within w_elimina_mat_adeud_pos_prim_ing
integer x = 64
integer y = 200
integer width = 2254
integer height = 260
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "Finanzas"
end type

