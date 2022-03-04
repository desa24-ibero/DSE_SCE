$PBExportHeader$w_valida_doble_presencia.srw
forward
global type w_valida_doble_presencia from window
end type
type dw_2 from uo_dw_reporte within w_valida_doble_presencia
end type
type st_progreso from statictext within w_valida_doble_presencia
end type
type cb_valida from commandbutton within w_valida_doble_presencia
end type
type dw_1 from datawindow within w_valida_doble_presencia
end type
end forward

global type w_valida_doble_presencia from window
integer width = 3558
integer height = 1846
boolean titlebar = true
string title = "Untitled"
string menuname = "m_menu"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
dw_2 dw_2
st_progreso st_progreso
cb_valida cb_valida
dw_1 dw_1
end type
global w_valida_doble_presencia w_valida_doble_presencia

on w_valida_doble_presencia.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_2=create dw_2
this.st_progreso=create st_progreso
this.cb_valida=create cb_valida
this.dw_1=create dw_1
this.Control[]={this.dw_2,&
this.st_progreso,&
this.cb_valida,&
this.dw_1}
end on

on w_valida_doble_presencia.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.st_progreso)
destroy(this.cb_valida)
destroy(this.dw_1)
end on

event open;dw_1.SetTransObject(gtr_sce)
dw_2.SetTransObject(gtr_sce)
end event

type dw_2 from uo_dw_reporte within w_valida_doble_presencia
integer x = 113
integer y = 659
integer width = 2710
integer height = 803
integer taborder = 30
string dataobject = "d_doble_presencia_external"
boolean hscrollbar = true
boolean border = true
end type

type st_progreso from statictext within w_valida_doble_presencia
integer x = 761
integer y = 528
integer width = 413
integer height = 61
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_valida from commandbutton within w_valida_doble_presencia
integer x = 1456
integer y = 506
integer width = 413
integer height = 106
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Valida"
end type

event clicked;long ll_rows_horario, ll_row_horario
long ll_cve_mat
string ls_mensaje_grupos, ls_gpo
long ll_rows, ll_row, ll_indice_array=0
long cve_mats[], ll_row_insercion
string gpos[], as_gpo, as_grupos_encimados
long al_cve_mat,  ai_periodo, ai_anio
long al_cve_profesor, ai_cve_dia, ai_hora_inicio, ai_hora_final 

uds_datastore lds_datastore

lds_datastore = CREATE uds_datastore

lds_datastore.dataobject = "d_doble_presencia_profesor"
lds_datastore.SetTransObject(gtr_sce)

ll_rows_horario =dw_1.Retrieve()

FOR ll_row_horario= 1 TO ll_rows_horario
	al_cve_mat= dw_1.GetItemNumber(ll_row_horario, "horario_cve_mat")
	as_gpo= dw_1.GetItemString(ll_row_horario, "horario_gpo")
	ai_periodo= dw_1.GetItemNumber(ll_row_horario, "horario_periodo")
	ai_anio= dw_1.GetItemNumber(ll_row_horario, "horario_anio")
	al_cve_profesor= dw_1.GetItemNumber(ll_row_horario, "grupos_cve_profesor")
	ai_cve_dia= dw_1.GetItemNumber(ll_row_horario, "horario_cve_dia") 
	ai_hora_inicio= dw_1.GetItemNumber(ll_row_horario, "horario_hora_inicio") 
	ai_hora_final= dw_1.GetItemNumber(ll_row_horario, "horario_hora_final")



	ll_rows = lds_datastore.Retrieve(al_cve_mat, as_gpo, ai_periodo, ai_anio, &
 											al_cve_profesor, ai_cve_dia, ai_hora_inicio, ai_hora_final )

	ls_mensaje_grupos = ""
	IF ll_rows= -1 THEN
		MessageBox("Error", "No es posible validar")
	ELSEIF ll_rows=0 THEN
		as_grupos_encimados= ls_mensaje_grupos		
	ELSE
		FOR ll_row = 1 TO ll_rows
			ll_indice_array = ll_indice_array +1
			ll_cve_mat = lds_datastore.GetItemNumber(ll_row, "grupos_cve_mat_1")
			ls_gpo = lds_datastore.GetItemString(ll_row, "grupos_gpo_1")
			cve_mats[ll_indice_array]= ll_cve_mat
			gpos[ll_indice_array]= ls_gpo
			ls_mensaje_grupos = ls_mensaje_grupos + " ["+string(ll_cve_mat)+"-"+ls_gpo+"]~n"
			ll_row_insercion= dw_2.InsertRow(0)
			dw_2.SetItem(ll_row_insercion,"cve_mat", ll_cve_mat)
			dw_2.SetItem(ll_row_insercion,"gpo", ls_gpo)
			dw_2.SetItem(ll_row_insercion,"cve_mat_2", al_cve_mat)
			dw_2.SetItem(ll_row_insercion,"gpo_2", as_gpo)
		NEXT
	END IF
	as_grupos_encimados= ls_mensaje_grupos
	st_progreso.text = string(ll_row_horario)+"/"+string(ll_rows_horario)+" ["+string(ll_indice_array)+"]"
NEXT

dw_2.Print()

dw_2.SaveAs("C:\REPETIDOS.XLS", Excel5!, TRUE)



end event

type dw_1 from datawindow within w_valida_doble_presencia
integer x = 165
integer y = 42
integer width = 2933
integer height = 419
integer taborder = 10
string title = "none"
string dataobject = "d_horarios_doble_presencia"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

