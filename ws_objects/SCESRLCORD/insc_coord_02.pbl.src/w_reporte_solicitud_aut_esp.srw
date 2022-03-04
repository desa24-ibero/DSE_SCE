$PBExportHeader$w_reporte_solicitud_aut_esp.srw
forward
global type w_reporte_solicitud_aut_esp from window
end type
type p_ibero from picture within w_reporte_solicitud_aut_esp
end type
type st_sistema from statictext within w_reporte_solicitud_aut_esp
end type
type dw_detalle from datawindow within w_reporte_solicitud_aut_esp
end type
type dw_maestro from datawindow within w_reporte_solicitud_aut_esp
end type
end forward

global type w_reporte_solicitud_aut_esp from window
integer width = 5595
integer height = 2744
boolean titlebar = true
string title = "Solicitud de Autorización Especial"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
p_ibero p_ibero
st_sistema st_sistema
dw_detalle dw_detalle
dw_maestro dw_maestro
end type
global w_reporte_solicitud_aut_esp w_reporte_solicitud_aut_esp

type variables
long il_cuenta, il_cve_mat, il_row_selected = 0, il_row_maestro= 0
string is_gpo
end variables

on w_reporte_solicitud_aut_esp.create
this.p_ibero=create p_ibero
this.st_sistema=create st_sistema
this.dw_detalle=create dw_detalle
this.dw_maestro=create dw_maestro
this.Control[]={this.p_ibero,&
this.st_sistema,&
this.dw_detalle,&
this.dw_maestro}
end on

on w_reporte_solicitud_aut_esp.destroy
destroy(this.p_ibero)
destroy(this.st_sistema)
destroy(this.dw_detalle)
destroy(this.dw_maestro)
end on

event open;long ll_rows_maestro, ll_rows_detalle
x=1
y=1

dw_detalle.settransobject(sqlca)
dw_maestro.settransobject(sqlca)
//dw_grupos_existentes_sae.settransobject(sqlca)
//dw_horario.settransobject(sqlca)
 
ll_rows_maestro= dw_maestro.Retrieve(gi_cve_coordinacion)
 
end event

type p_ibero from picture within w_reporte_solicitud_aut_esp
integer x = 32
integer y = 24
integer width = 681
integer height = 264
string picturename = "logoibero-web.png"
boolean focusrectangle = false
end type

type st_sistema from statictext within w_reporte_solicitud_aut_esp
integer x = 741
integer y = 92
integer width = 229
integer height = 100
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

type dw_detalle from datawindow within w_reporte_solicitud_aut_esp
integer y = 2080
integer width = 5239
integer height = 492
integer taborder = 20
string title = "none"
string dataobject = "d_solicitud_autorizacion_especial_detalle"
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemfocuschanged;long ll_row, ll_cuenta, ll_cve_mat
string ls_gpo


ll_row = row

if ll_row > 0 then
	ll_cuenta = this.GetItemNumber(ll_row, "alumnos_cuenta")
	ll_cve_mat = this.GetItemNumber(ll_row, "grupos_cve_mat")
	ls_gpo = this.GetItemString(ll_row, "grupos_gpo")
	il_cuenta = ll_cuenta
	il_cve_mat = ll_cve_mat
	is_gpo = ls_gpo
	
	
else
	il_cuenta = 0
	il_cve_mat = 0
	is_gpo = ""
end if


end event

event doubleclicked;integer li_return
long ll_row, ll_cuenta, ll_cve_mat_ligada, ll_periodo, ll_anio
string ls_gpo, ls_grupo_retorno
st_grupo_ligado_sae lst_grupo_ligado_sae
w_grupos_ligados_sae lw_grupos_ligados_sae
ll_row = row

if ll_row > 0 then
	ll_cuenta = this.GetItemNumber(ll_row, "alumnos_cuenta")
	ll_cve_mat_ligada = this.GetItemNumber(ll_row, "cve_mat_ligada")
	ll_periodo = this.GetItemNumber(ll_row, "grupos_periodo")
	ll_anio = this.GetItemNumber(ll_row, "grupos_anio")
	ls_gpo = this.GetItemString(ll_row, "grupos_gpo")
	lst_grupo_ligado_sae.cve_mat = ll_cve_mat_ligada
	lst_grupo_ligado_sae.periodo = ll_periodo
	lst_grupo_ligado_sae.anio = ll_anio
	li_return = OpenWithParm (w_grupos_ligados_sae, lst_grupo_ligado_sae)
	ls_grupo_retorno = Message.StringParm
	this.SetItem(ll_row, "gpo_ligado",ls_grupo_retorno )
	
end if




end event

type dw_maestro from datawindow within w_reporte_solicitud_aut_esp
integer x = 32
integer y = 324
integer width = 5189
integer height = 1640
integer taborder = 10
string title = "none"
string dataobject = "d_solicitud_autorizacion_especial_coord"
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;long ll_row_actual, ll_cuenta, ll_cve_mat, ll_periodo, ll_anio , ll_rows_detalle, ll_rows_grupos_existentes, ll_row_detalle, ll_of_obten_materia, ll_rows_horario
string ls_gpo, ls_materia_2
n_ajustes  ln_ajustes 
long ll_cve_carrera, ll_cve_plan, ll_obten_carrera_plan
integer li_obten_seriaciones_materia
ll_row_actual = row
il_row_maestro= ll_row_actual

if ll_row_actual <= 0 then
	return	
end if

if il_row_selected >0 and isSelected(il_row_selected) then
	this.SelectRow(il_row_selected, false)
end if 
ll_cuenta = this.GetItemNumber(ll_row_actual,"cuenta")
ll_cve_mat = this.GetItemNumber(ll_row_actual,"cve_mat")
ls_gpo = this.GetItemString(ll_row_actual,"gpo")
ll_periodo = this.GetItemNumber(ll_row_actual,"periodo")
ll_anio  = this.GetItemNumber(ll_row_actual,"anio")




il_cuenta = ll_cuenta
il_cve_mat = ll_cve_mat
is_gpo = ls_gpo

il_row_selected = ll_row_actual
this.SelectRow(il_row_selected, true)

ll_rows_detalle = dw_detalle.Retrieve(ll_cuenta,ll_cve_mat, ls_gpo, ll_periodo,ll_anio )

//ll_rows_grupos_existentes = dw_grupos_existentes_sae.Retrieve(ll_cve_mat, ll_periodo,ll_anio )

//ll_rows_horario = dw_horario.Retrieve(ll_cve_mat, ls_gpo, ll_periodo,ll_anio )


integer li_lleva_teoria_lab,  li_inscribe = 0, li_es_labo, li_valida_materia_grupo, li_valida_materia_grupo_2, li_inscripcion_teoria_lab
long ll_valida_alumno, ll_codigo, ll_codigo_2,   ll_cve_mat_2
string ls_mensaje, ls_cuenta , ls_cve_mat,  ls_gpo_2

//Revisa si la materia lleva teoría o laboratorio ligada
if ll_cuenta>0 and ll_cve_mat>0 then 
	ln_ajustes = CREATE n_ajustes
	ll_obten_carrera_plan = ln_ajustes.of_obten_carrera_plan(ll_cuenta, ll_cve_carrera, ll_cve_plan)	
	li_obten_seriaciones_materia = ln_ajustes.of_obten_seriaciones_materia(ll_cve_mat, ll_cve_carrera, ll_cve_plan)	
	dw_detalle.SetItem(ll_rows_detalle, "num_seriaciones", li_obten_seriaciones_materia)
	
	li_lleva_teoria_lab = ln_ajustes.of_lleva_teoria_lab (ll_cuenta, ll_cve_mat, ls_gpo, ll_cve_mat_2, ls_gpo_2, li_es_labo)
	if ll_cve_mat_2>0 then
		dw_detalle.Modify("t_clave.Visible='1'")
		dw_detalle.Modify("t_grupo_ligado.Visible='1'")
		dw_detalle.Modify("t_materia_ligada.Visible='1'")		
		dw_detalle.Modify("gb_ligados.Visible='1'")		
		dw_detalle.Modify("cve_mat_ligada.Visible='1'")
		dw_detalle.Modify("gpo_ligado.Visible='1'")
		dw_detalle.Modify("materia_ligada.Visible='1'")		

		ll_of_obten_materia = ln_ajustes.of_obten_materia(ll_cve_mat_2, ls_materia_2)
		for ll_row_detalle= 1 to ll_rows_detalle
			dw_detalle.SetItem(ll_row_detalle, "cve_mat_ligada", ll_cve_mat_2)
			if ls_gpo_2 <> '*' then
				dw_detalle.SetItem(ll_row_detalle, "gpo_ligado", ls_gpo_2)
			end if
			if ll_of_obten_materia<>-1 then
				dw_detalle.SetItem(ll_row_detalle, "materia_ligada", ls_materia_2)			
			end if
		next
	else
		dw_detalle.Modify("t_clave.Visible='0'")
		dw_detalle.Modify("t_grupo_ligado.Visible='0'")
		dw_detalle.Modify("t_materia_ligada.Visible='0'")		
		dw_detalle.Modify("gb_ligados.Visible='0'")		
		dw_detalle.Modify("cve_mat_ligada.Visible='0'")
		dw_detalle.Modify("gpo_ligado.Visible='0'")
		dw_detalle.Modify("materia_ligada.Visible='0'")		
	end if	
end if



end event

