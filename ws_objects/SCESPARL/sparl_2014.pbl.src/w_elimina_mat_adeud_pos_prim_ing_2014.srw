$PBExportHeader$w_elimina_mat_adeud_pos_prim_ing_2014.srw
forward
global type w_elimina_mat_adeud_pos_prim_ing_2014 from window
end type
type st_sistema from statictext within w_elimina_mat_adeud_pos_prim_ing_2014
end type
type p_ibero from picture within w_elimina_mat_adeud_pos_prim_ing_2014
end type
type dw_finanzas from u_dw within w_elimina_mat_adeud_pos_prim_ing_2014
end type
type dw_laboratorio from u_dw within w_elimina_mat_adeud_pos_prim_ing_2014
end type
type cb_genera_archivo_fin from commandbutton within w_elimina_mat_adeud_pos_prim_ing_2014
end type
type cb_elimina_materias_finanzas from commandbutton within w_elimina_mat_adeud_pos_prim_ing_2014
end type
type em_cantidad_materias_finanzas from editmask within w_elimina_mat_adeud_pos_prim_ing_2014
end type
type cb_contar_materias_finanzas from commandbutton within w_elimina_mat_adeud_pos_prim_ing_2014
end type
type gb_2 from groupbox within w_elimina_mat_adeud_pos_prim_ing_2014
end type
end forward

global type w_elimina_mat_adeud_pos_prim_ing_2014 from window
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
long backcolor = 16777215
st_sistema st_sistema
p_ibero p_ibero
dw_finanzas dw_finanzas
dw_laboratorio dw_laboratorio
cb_genera_archivo_fin cb_genera_archivo_fin
cb_elimina_materias_finanzas cb_elimina_materias_finanzas
em_cantidad_materias_finanzas em_cantidad_materias_finanzas
cb_contar_materias_finanzas cb_contar_materias_finanzas
gb_2 gb_2
end type
global w_elimina_mat_adeud_pos_prim_ing_2014 w_elimina_mat_adeud_pos_prim_ing_2014

type variables
string is_nivel = "L"
string is_nombre_nivel = "Licenciatura"
string is_bloqueo_finanzas = "Bloquear"
integer ii_adeuda_finanzas = 1
st_confirma_usuario ist_confirma_usuario
long il_creditos

end variables

on w_elimina_mat_adeud_pos_prim_ing_2014.create
this.st_sistema=create st_sistema
this.p_ibero=create p_ibero
this.dw_finanzas=create dw_finanzas
this.dw_laboratorio=create dw_laboratorio
this.cb_genera_archivo_fin=create cb_genera_archivo_fin
this.cb_elimina_materias_finanzas=create cb_elimina_materias_finanzas
this.em_cantidad_materias_finanzas=create em_cantidad_materias_finanzas
this.cb_contar_materias_finanzas=create cb_contar_materias_finanzas
this.gb_2=create gb_2
this.Control[]={this.st_sistema,&
this.p_ibero,&
this.dw_finanzas,&
this.dw_laboratorio,&
this.cb_genera_archivo_fin,&
this.cb_elimina_materias_finanzas,&
this.em_cantidad_materias_finanzas,&
this.cb_contar_materias_finanzas,&
this.gb_2}
end on

on w_elimina_mat_adeud_pos_prim_ing_2014.destroy
destroy(this.st_sistema)
destroy(this.p_ibero)
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

type st_sistema from statictext within w_elimina_mat_adeud_pos_prim_ing_2014
integer x = 791
integer y = 120
integer width = 229
integer height = 100
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 16777215
string text = "DSE"
boolean focusrectangle = false
end type

type p_ibero from picture within w_elimina_mat_adeud_pos_prim_ing_2014
integer x = 46
integer y = 36
integer width = 681
integer height = 264
boolean bringtotop = true
string picturename = "logoibero-web.png"
boolean focusrectangle = false
end type

type dw_finanzas from u_dw within w_elimina_mat_adeud_pos_prim_ing_2014
boolean visible = false
integer x = 1120
integer y = 596
integer width = 553
integer height = 156
integer taborder = 60
string dataobject = "d_materias_baja_fin_pos_prim_ing_2014"
end type

type dw_laboratorio from u_dw within w_elimina_mat_adeud_pos_prim_ing_2014
boolean visible = false
integer x = 1120
integer y = 284
integer width = 553
integer height = 156
integer taborder = 70
string dataobject = "d_materias_baja_laboratorio"
end type

type cb_genera_archivo_fin from commandbutton within w_elimina_mat_adeud_pos_prim_ing_2014
integer x = 1120
integer y = 456
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

type cb_elimina_materias_finanzas from commandbutton within w_elimina_mat_adeud_pos_prim_ing_2014
integer x = 1696
integer y = 456
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

type em_cantidad_materias_finanzas from editmask within w_elimina_mat_adeud_pos_prim_ing_2014
integer x = 699
integer y = 456
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

type cb_contar_materias_finanzas from commandbutton within w_elimina_mat_adeud_pos_prim_ing_2014
integer x = 119
integer y = 456
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

ll_rows = dw_finanzas.Retrieve()

IF ll_rows = -1 THEN
	
	RETURN	
END IF


em_cantidad_materias_finanzas.text= string(ll_rows)
cb_genera_archivo_fin.enabled = true
end event

type gb_2 from groupbox within w_elimina_mat_adeud_pos_prim_ing_2014
integer x = 64
integer y = 372
integer width = 2254
integer height = 260
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "Finanzas"
end type

