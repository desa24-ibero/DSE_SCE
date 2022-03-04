$PBExportHeader$w_genera_grupo_sinodal_ets.srw
forward
global type w_genera_grupo_sinodal_ets from w_master
end type
type dw_cve_mat_gpo_ets from u_dw within w_genera_grupo_sinodal_ets
end type
type dw_grupos_ets from u_dw within w_genera_grupo_sinodal_ets
end type
type cb_inserta_grupo_sinodal from commandbutton within w_genera_grupo_sinodal_ets
end type
type st_1 from statictext within w_genera_grupo_sinodal_ets
end type
type st_num_registros from statictext within w_genera_grupo_sinodal_ets
end type
type cb_consultar_grupos from commandbutton within w_genera_grupo_sinodal_ets
end type
type dw_plantilla_grupo_sinodal_ets from u_dw within w_genera_grupo_sinodal_ets
end type
type st_periodo_establecido from statictext within w_genera_grupo_sinodal_ets
end type
end forward

global type w_genera_grupo_sinodal_ets from w_master
integer x = 0
integer y = 0
integer width = 5029
integer height = 2952
string title = " Grupos de Sinodales a Extraordinario y a Título de Suficiencia"
dw_cve_mat_gpo_ets dw_cve_mat_gpo_ets
dw_grupos_ets dw_grupos_ets
cb_inserta_grupo_sinodal cb_inserta_grupo_sinodal
st_1 st_1
st_num_registros st_num_registros
cb_consultar_grupos cb_consultar_grupos
dw_plantilla_grupo_sinodal_ets dw_plantilla_grupo_sinodal_ets
st_periodo_establecido st_periodo_establecido
end type
global w_genera_grupo_sinodal_ets w_genera_grupo_sinodal_ets

type variables
u_administrador_grupos iuo_administrador_grupos 
integer ii_periodo, ii_anio
long il_cve_mat[], il_cve_coordinacion
string is_gpo[], is_coordinacion
boolean ib_desc_sdu_se=false
st_confirma_usuario ist_confirma_usuario
end variables

forward prototypes
public function integer wf_establece_periodo (integer ai_periodo, integer ai_anio)
end prototypes

public function integer wf_establece_periodo (integer ai_periodo, integer ai_anio);//wf_establece_periodo
//Recibe:
//integer	ai_periodo
//integer	ai_anio

string ls_periodo, ls_anio, ls_periodo_anio
long ll_total_items_origen, ll_total_items_destino

// Se cre objeto de servicios para recuperar la descripción del periodo.
uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios 
luo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, 'L', gtr_sce) 
ls_periodo = luo_periodo_servicios.f_recupera_descripcion( ai_periodo, 'L')


//CHOOSE CASE ai_periodo
//	CASE 0
//		ls_periodo= "PRIMAVERA"
//	CASE 1
//		ls_periodo= "VERANO"
//	CASE 2
//		ls_periodo= "OTOÑO"
//	CASE ELSE 
//		ls_periodo= "ERROR GRAVE"		
//END CHOOSE

ls_periodo_anio = ls_periodo + " "+ STRING(ai_anio) 

st_periodo_establecido.text = ls_periodo_anio

ii_periodo= ai_periodo
ii_anio = ai_anio

gi_periodo= ai_periodo
gi_anio = ai_anio

return 1

end function

on w_genera_grupo_sinodal_ets.create
int iCurrent
call super::create
this.dw_cve_mat_gpo_ets=create dw_cve_mat_gpo_ets
this.dw_grupos_ets=create dw_grupos_ets
this.cb_inserta_grupo_sinodal=create cb_inserta_grupo_sinodal
this.st_1=create st_1
this.st_num_registros=create st_num_registros
this.cb_consultar_grupos=create cb_consultar_grupos
this.dw_plantilla_grupo_sinodal_ets=create dw_plantilla_grupo_sinodal_ets
this.st_periodo_establecido=create st_periodo_establecido
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cve_mat_gpo_ets
this.Control[iCurrent+2]=this.dw_grupos_ets
this.Control[iCurrent+3]=this.cb_inserta_grupo_sinodal
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_num_registros
this.Control[iCurrent+6]=this.cb_consultar_grupos
this.Control[iCurrent+7]=this.dw_plantilla_grupo_sinodal_ets
this.Control[iCurrent+8]=this.st_periodo_establecido
end on

on w_genera_grupo_sinodal_ets.destroy
call super::destroy
destroy(this.dw_cve_mat_gpo_ets)
destroy(this.dw_grupos_ets)
destroy(this.cb_inserta_grupo_sinodal)
destroy(this.st_1)
destroy(this.st_num_registros)
destroy(this.cb_consultar_grupos)
destroy(this.dw_plantilla_grupo_sinodal_ets)
destroy(this.st_periodo_establecido)
end on

event open;call super::open;integer li_obten_periodo, li_periodo, li_anio
long ll_rows 

iuo_administrador_grupos = CREATE u_administrador_grupos
x=1
y=1

li_obten_periodo = f_obten_periodo(li_periodo, li_anio, 12)

if li_obten_periodo <> 1 then
	MessageBox("Periodo de Exámenes Inexistente", &
	"No ha sido posible encontrar el periodo de Aplicación Extraordinario y a Título de Suficiencia.",StopSign!)
	return
else
	wf_establece_periodo(li_periodo, li_anio)
end if

dw_plantilla_grupo_sinodal_ets.SetTransObject(gtr_sce)
dw_grupos_ets.SetTransObject(gtr_sce)
dw_cve_mat_gpo_ets.SetTransObject(gtr_sce)

cb_consultar_grupos.event clicked()
//ll_rows = dw_plantilla_grupo_sinodal_ets.Retrieve()

end event

event close;call super::close;IF isvalid(iuo_administrador_grupos) THEN
	DESTROY iuo_administrador_grupos
END IF
end event

event closequery;RETURN 0
end event

type dw_cve_mat_gpo_ets from u_dw within w_genera_grupo_sinodal_ets
integer x = 105
integer y = 2116
integer width = 4800
integer height = 664
integer taborder = 170
string dataobject = "dw_datos_gpo_alumno_mat_ets_gpo"
boolean hscrollbar = true
boolean resizable = true
end type

type dw_grupos_ets from u_dw within w_genera_grupo_sinodal_ets
integer x = 105
integer y = 1428
integer width = 4800
integer height = 664
integer taborder = 160
string dataobject = "d_grupo_sinodal_ets"
boolean hscrollbar = true
boolean resizable = true
end type

event retrieveend;call super::retrieveend;long ll_row, ll_cve_mat, ll_cve_mat_gpo_ets, ll_cve_tipo_examen
string ls_gpo, ls_nivel
int li_update

for ll_row=1 to rowcount
	ll_cve_mat = this.GetItemNumber(ll_row,"cve_mat")
	ls_gpo = this.GetItemString(ll_row,"gpo")
	ll_cve_tipo_examen = this.GetItemNumber(ll_row,"tipo_examen")
	ls_nivel = this.GetItemString(ll_row,"materias_nivel")	
	ll_cve_mat_gpo_ets =dw_cve_mat_gpo_ets.Retrieve(ii_periodo, ii_anio, ll_cve_mat,ls_gpo, ll_cve_tipo_examen, ls_nivel)
	if ll_cve_mat_gpo_ets=-1 then
		MessageBox("Error","Error al consultar el grupo ["+string(ll_cve_mat)+"-"+ls_gpo+"]",Stopsign!)
		return
	elseif ll_cve_mat_gpo_ets>0 then 
		this.SetItem(ll_row, "inscritos", ll_cve_mat_gpo_ets)
	end if
next

li_update = this.Update()
if li_update = 1 then	
		commit using gtr_sce;
		MessageBox("Actualización Exitosa","Se han actualizado los inscritos de los grupos exitosamente",Information!)	
else
		MessageBox("Error","No se ha podido actualizar a los inscritos de los grupos",Stopsign!)
		rollback using gtr_sce;
end if



end event

type cb_inserta_grupo_sinodal from commandbutton within w_genera_grupo_sinodal_ets
integer x = 2290
integer y = 1284
integer width = 667
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Insertar Grupos de Sinodales"
end type

event clicked;integer li_es_fecha_menor_ets, li_es_fecha_menor_aplicacion_ets, li_inserta_grupo_sinodal_ets
long ll_num_grupo_sinodal_ets, ll_grupos_ets

li_es_fecha_menor_aplicacion_ets = f_es_fecha_menor_aplicacion_ets (ii_periodo, ii_anio, li_es_fecha_menor_ets)

if li_es_fecha_menor_ets <>1 then
	MessageBox("Error de Generación", "No es posible generar las actas en el periodo actual.",StopSign!)
	return	
end if
 
ll_num_grupo_sinodal_ets = f_num_grupo_sinodal_ets(ii_periodo, ii_anio, gtr_sce) 

if ll_num_grupo_sinodal_ets>0 then
	MessageBox("Grupos de Sinodales Existentes", "Ya se han generado los Grupos de Sinodales en el periodo actual.",StopSign!)
	return	
end if


if ll_num_grupo_sinodal_ets = 0 then
	li_inserta_grupo_sinodal_ets = f_inserta_grupo_sinodal_ets (ii_periodo, ii_anio)
end if

if li_inserta_grupo_sinodal_ets = -1 then
	MessageBox("Error de Inserción", "No es posible insertar los Grupos de Sinodales en el periodo actual.",StopSign!)
	return		
end if

ll_grupos_ets= dw_grupos_ets.Retrieve(ii_periodo, ii_anio)



end event

type st_1 from statictext within w_genera_grupo_sinodal_ets
integer x = 1696
integer y = 1156
integer width = 521
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
string text = "Num Registros:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_num_registros from statictext within w_genera_grupo_sinodal_ets
integer x = 2299
integer y = 1156
integer width = 343
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
string text = "none"
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_consultar_grupos from commandbutton within w_genera_grupo_sinodal_ets
integer x = 2263
integer y = 284
integer width = 416
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Consultar Grupos"
end type

event clicked;long ll_rows
ll_rows = dw_plantilla_grupo_sinodal_ets.Retrieve(gs_tipo_periodo)

st_num_registros.text = string(ll_rows)
end event

type dw_plantilla_grupo_sinodal_ets from u_dw within w_genera_grupo_sinodal_ets
integer x = 91
integer y = 420
integer width = 4800
integer height = 664
integer taborder = 150
string dataobject = "d_plantilla_grupo_sinodal_ets"
boolean hscrollbar = true
boolean resizable = true
end type

type st_periodo_establecido from statictext within w_genera_grupo_sinodal_ets
integer x = 2007
integer y = 32
integer width = 928
integer height = 92
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
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

