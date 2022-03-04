$PBExportHeader$w_actualiza_horario.srw
forward
global type w_actualiza_horario from w_ancestral
end type
type dw_actualiza_horario from uo_dw_reporte within w_actualiza_horario
end type
type dw_departamento from datawindow within w_actualiza_horario
end type
type ddlb_1 from dropdownlistbox within w_actualiza_horario
end type
type cbx_sin_gpos_zz from checkbox within w_actualiza_horario
end type
type uo_periodo from uo_periodo_variable_tipos within w_actualiza_horario
end type
type em_1 from editmask within w_actualiza_horario
end type
type cb_1 from commandbutton within w_actualiza_horario
end type
type gb_11 from groupbox within w_actualiza_horario
end type
end forward

global type w_actualiza_horario from w_ancestral
integer width = 3767
integer height = 2420
string title = "Reporte de Horarios"
string menuname = "m_menu"
dw_actualiza_horario dw_actualiza_horario
dw_departamento dw_departamento
ddlb_1 ddlb_1
cbx_sin_gpos_zz cbx_sin_gpos_zz
uo_periodo uo_periodo
em_1 em_1
cb_1 cb_1
gb_11 gb_11
end type
global w_actualiza_horario w_actualiza_horario

type variables
integer ii_depa,ii_cond, ii_num_resize = 0

uo_periodo_servicios iuo_periodo_servicios

INTEGER periodo_x[] 
STRING is_descripcion_periodo
end variables

on w_actualiza_horario.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_actualiza_horario=create dw_actualiza_horario
this.dw_departamento=create dw_departamento
this.ddlb_1=create ddlb_1
this.cbx_sin_gpos_zz=create cbx_sin_gpos_zz
this.uo_periodo=create uo_periodo
this.em_1=create em_1
this.cb_1=create cb_1
this.gb_11=create gb_11
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_actualiza_horario
this.Control[iCurrent+2]=this.dw_departamento
this.Control[iCurrent+3]=this.ddlb_1
this.Control[iCurrent+4]=this.cbx_sin_gpos_zz
this.Control[iCurrent+5]=this.uo_periodo
this.Control[iCurrent+6]=this.em_1
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.gb_11
end on

on w_actualiza_horario.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_actualiza_horario)
destroy(this.dw_departamento)
destroy(this.ddlb_1)
destroy(this.cbx_sin_gpos_zz)
destroy(this.uo_periodo)
destroy(this.em_1)
destroy(this.cb_1)
destroy(this.gb_11)
end on

event open;call super::open;
// Se inicializa el objeto de periodos
THIS.uo_periodo.of_inicializa_servicio( "V", "L", "L", "N", gtr_sce)

// Se crea objeto de servicios de periodos.
iuo_periodo_servicios = CREATE uo_periodo_servicios 






//***********************************************************************
//***********************************************************************
//***********************************************************************


int li_anio, li_periodo

dw_actualiza_horario.DataObject = "d_actualiza_horario"
dw_actualiza_horario.SetTransObject(gtr_sce)

periodo_actual_mat_insc(li_periodo, li_anio, gtr_sce)
if li_periodo <> gi_periodo or li_anio <>gi_anio then
	dw_actualiza_horario.DataObject = 'd_actualiza_horario_hist'		
	dw_actualiza_horario.SetTransObject(gtr_sce)
end if

dw_actualiza_horario.settransobject(gtr_sce)
dw_departamento.settransobject(gtr_sce)
dw_departamento.retrieve()
end event

event resize;call super::resize;long ll_height_win, ll_height_dw, ll_dif_height_tab, ll_height_tab, ll_width_tab, ll_height_tab_final

if ii_num_resize > 0 then
	ll_height_dw = dw_actualiza_horario.height
	ll_height_win = this.height

	ll_height_tab = dw_actualiza_horario.height
	ll_width_tab = dw_actualiza_horario.width

	dw_actualiza_horario.width = newwidth - 50
	dw_actualiza_horario.height = newheight - 500
	
	ll_height_tab_final = dw_actualiza_horario.height
	
	ll_dif_height_tab = ll_height_tab_final - ll_height_tab  

	dw_actualiza_horario.width = newwidth - 200
	dw_actualiza_horario.height = ll_height_dw + ll_dif_height_tab
else
	ii_num_resize = ii_num_resize +1
end if
end event

type p_uia from w_ancestral`p_uia within w_actualiza_horario
integer x = 32
integer y = 12
end type

type dw_actualiza_horario from uo_dw_reporte within w_actualiza_horario
integer x = 32
integer y = 420
integer width = 3648
integer height = 1652
integer taborder = 0
string dataobject = "d_actualiza_horario"
boolean hscrollbar = true
boolean resizable = true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

event carga;int li_anio, li_periodo, li_result
string ls_filtro_vacio = ""
long  ll_cont

setpointer(Hourglass!)

//dw_actualiza_horario.DataObject = "d_actualiza_horario"
//dw_actualiza_horario.SetTransObject(gtr_sce)
//
//periodo_actual_mat_insc(li_periodo, li_anio, gtr_sce)
//if li_periodo <> gi_periodo or li_anio <>gi_anio then
//	dw_actualiza_horario.DataObject = 'd_actualiza_horario_hist'		
//	dw_actualiza_horario.SetTransObject(gtr_sce)
//end if

//**********************************************************
//**********************************************************

// Se cargan los periodos activos
//INTEGER li_periodo_sem,  li_periodo_trim
//INTEGER li_anio_sem, li_anio_trim

// Se recupera el periodo semestral 
//iuo_periodo_servicios.f_carga_periodo_activo( li_periodo_sem, li_anio_sem, "S", gtr_sce) 
//iuo_periodo_servicios.f_carga_periodo_activo( li_periodo_trim, li_anio_trim, "T", gtr_sce) 

//INTEGER li_periodo_sem_act,  li_periodo_trim_act
INTEGER li_anio_sem_act, li_anio_trim_act

// Se genera cadena de selección según el periodo de cada tipo seleccionado.
INTEGER le_index
INTEGER le_periodo[] 
STRING ls_tipo_periodo[]
STRING ls_periodo_actual
INTEGER le_anio_filtro 
STRING ls_sql 

PARENT.uo_periodo.of_recupera_periodos() 

le_anio_filtro = INTEGER(em_1.TEXT) 
periodo_x[] = le_periodo[] 
is_descripcion_periodo = ""

FOR le_index = 1 TO UPPERBOUND(PARENT.uo_periodo.istr_periodos[])
	
	IF TRIM(is_descripcion_periodo) <> "" THEN is_descripcion_periodo = is_descripcion_periodo + ", "
	is_descripcion_periodo = is_descripcion_periodo + PARENT.uo_periodo.istr_periodos[le_index].descripcion 
	periodo_x[le_index] = PARENT.uo_periodo.istr_periodos[le_index].periodo
	ls_tipo_periodo[le_index] = PARENT.uo_periodo.istr_periodos[le_index].tipo

	// Se recupera el periodo semestral 
	iuo_periodo_servicios.f_carga_periodo_activo(li_periodo, li_anio, ls_tipo_periodo[le_index], gtr_sce) 

	IF li_periodo <> periodo_x[le_index] OR li_anio <> le_anio_filtro THEN 
		ls_periodo_actual = "N"
	ELSE
		ls_periodo_actual = "S"
	END IF 
	
	// Se verifica el tipo de periodo.
//	IF ls_tipo_periodo[le_index] = "S" THEN 
//		// Se verifica si se trata del periodo actual.	
//		IF li_periodo_sem <> periodo_x[le_index] OR li_anio_sem <> le_anio_filtro THEN 
//			ls_periodo_actual = "N"
//		ELSE
//			ls_periodo_actual = "S"
//		END IF 
//	ELSEIF ls_tipo_periodo[le_index] = "T" THEN 	
//		// Se verifica si se trata del periodo actual.	
//		IF li_periodo_trim <> periodo_x[le_index] OR li_anio_trim <> le_anio_filtro THEN 
//			ls_periodo_actual = "N"
//		ELSE
//			ls_periodo_actual = "S"
//		END IF 
//	END IF
	
	// Se verifica si la búsqueda se hace a travéz del periodo actual.
	IF ls_periodo_actual = "S" THEN 
		
		IF TRIM(ls_sql) <> "" THEN ls_sql = ls_sql + " UNION ALL " 
		
		ls_sql = ls_sql + " SELECT grupos.cve_mat_gpo, " + &
				" grupos.cve_mat, " + &   
				" grupos.gpo, " + &   
				" materias.sigla, " + &   
				" materias.materia, " + &   
				" profesor.nombre_completo, " + &   
				" horario.cve_dia, " + &   
				" horario.hora_inicio, " + &   
				" horario.hora_final,  " + &  
				" horario.cve_salon, " + &
				" grupos.cupo, " + &
				" grupos.inscritos, " + &
				" materias.cve_coordinacion, " + &
				" grupos.tipo, " + &
				" tipo_grupo.nombre_tipo, " + &
				" grupos.cve_profesor, " + &
				" profesor.nombre_completo, " + &
				" profesor.cve_categoria, " + &
				" horario.clase_aula, " + &
				" clase_aula.nombre_aula " + &			
		" FROM grupos, " + &   
				" horario, " + &   
				" materias, " + &   
				" profesor, " + &
				" tipo_grupo, " + &
				" clase_aula  " + &
		" WHERE ((( grupos.cve_mat *= horario.cve_mat) and   " + &
				" ( grupos.gpo *= horario.gpo)) or " + &
				" (( grupos.cve_asimilada *= horario.cve_mat) and  " + & 
				" ( grupos.gpo_asimilado *= horario.gpo))) and " + & 
				" ( grupos.cve_mat = materias.cve_mat ) and " + &
				" ( grupos.tipo = tipo_grupo.tipo ) and " + &
				" ( grupos.cond_gpo = " + STRING(ii_cond) + " ) and " + &
				" ( grupos.cve_profesor = profesor.cve_profesor) and  " + & 
				" (( " + STRING(ii_depa) + " = 9999 OR materias.cve_coordinacion = " + STRING(ii_depa) + " ) AND " + &
				" ( grupos.anio = " + STRING(le_anio_filtro) + "  ) AND  " + & 
				" ( grupos.periodo = " + STRING(periodo_x[le_index]) + " ) AND " + &  
				" ( horario.anio = " + STRING(le_anio_filtro) + " ) AND  " + & 
				" ( horario.periodo = " + STRING(periodo_x[le_index]) + " )) AND " + &
				" ( horario.clase_aula =* clase_aula.clase)	" 
		
	// Si no se trata del periodo actual se busca en el histórico.
	ELSE

		IF TRIM(ls_sql) <> "" THEN ls_sql = ls_sql + " UNION ALL " 
	
		ls_sql = ls_sql + " SELECT hist_grupos.cve_mat_gpo, " + & 
					" hist_grupos.cve_mat, " + &   
					" hist_grupos.gpo, " + &   
					" materias.sigla, " + &   
					" materias.materia, " + &   
					" profesor.nombre_completo, " + &   
					" hist_horario.cve_dia, " + &   
					" hist_horario.hora_inicio, " + &   
					" hist_horario.hora_final, " + &   
					" hist_horario.cve_salon, " + &
					" hist_grupos.cupo, " + &
					" hist_grupos.inscritos, " + &
					" materias.cve_coordinacion, " + &
					" hist_grupos.tipo, " + &
					" tipo_grupo.nombre_tipo, " + &
					" hist_grupos.cve_profesor, " + &
					" profesor.nombre_completo, " + &
					" profesor.cve_categoria, " + &		
					" hist_horario.clase_aula, " + & 
					" clase_aula.nombre_aula " + &
			 " FROM hist_grupos, " + &   
					" hist_horario, " + &   
					" materias, " + &   
					" profesor, " + &
					" tipo_grupo,  " + & 
					" clase_aula " + & 
			" WHERE ((( hist_grupos.cve_mat *= hist_horario.cve_mat) and " + &  
					" ( hist_grupos.gpo *= hist_horario.gpo)) or " + &
					" (( hist_grupos.cve_asimilada *= hist_horario.cve_mat) and " + &  
					" ( hist_grupos.gpo_asimilado *= hist_horario.gpo))) and " + & 
					" ( hist_grupos.tipo = tipo_grupo.tipo) and " + &
					" ( hist_grupos.cve_mat = materias.cve_mat ) and " + &
					" ( hist_grupos.cond_gpo = " + STRING(ii_cond) + " ) and " + &
					" ( hist_grupos.cve_profesor = profesor.cve_profesor) and  " + & 
					" (( " + STRING(ii_depa) + " = 9999 OR materias.cve_coordinacion = " + STRING(ii_depa) + " ) AND " + &
					" ( hist_grupos.anio = " + STRING(le_anio_filtro) + "  ) AND   " + &
					" ( hist_grupos.periodo = " + STRING(periodo_x[le_index]) + " ) AND " + &  
					" ( hist_horario.anio = " + STRING(le_anio_filtro) + " ) AND   " + &
					" ( hist_horario.periodo = " + STRING(periodo_x[le_index]) + " )) AND " + &
					" ( hist_horario.clase_aula =* clase_aula.clase)	"
	
	END IF
NEXT 	
//**********************************************************
//**********************************************************

event primero()
////return retrieve(ii_depa,gi_periodo,gi_anio,ii_cond)
//li_result = retrieve(ii_depa,gi_periodo,gi_anio,ii_cond)

THIS.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'")
li_result = retrieve()

// Filtramos los grupos ZZ
if cbx_sin_gpos_zz.checked then
//	if li_periodo <> gi_periodo or li_anio <>gi_anio then
//		dw_actualiza_horario.SetFilter("hist_grupos_gpo not in ('ZZ')")
//	else
		dw_actualiza_horario.SetFilter("grupos_gpo not in ('ZZ')")
//	end if
else
	dw_actualiza_horario.SetFilter(ls_filtro_vacio)
end if

dw_actualiza_horario.Filter()
ll_cont = dw_actualiza_horario.rowcount() 
if ll_cont > 0 then
	dw_actualiza_horario.ScrollToRow(1)
end if	

return li_result

//int li_anio, li_periodo, li_result
//string ls_filtro_vacio = ""
//long  ll_cont
//
//setpointer(Hourglass!)
//
//dw_actualiza_horario.DataObject = "d_actualiza_horario"
//dw_actualiza_horario.SetTransObject(gtr_sce)
//
//periodo_actual_mat_insc(li_periodo, li_anio, gtr_sce)
//if li_periodo <> gi_periodo or li_anio <>gi_anio then
//	dw_actualiza_horario.DataObject = 'd_actualiza_horario_hist'		
//	dw_actualiza_horario.SetTransObject(gtr_sce)
//end if
//
//
//event primero()
////return retrieve(ii_depa,gi_periodo,gi_anio,ii_cond)
//li_result = retrieve(ii_depa,gi_periodo,gi_anio,ii_cond)
//
//// Filtramos los grupos ZZ
//if cbx_sin_gpos_zz.checked then
//	if li_periodo <> gi_periodo or li_anio <>gi_anio then
//		dw_actualiza_horario.SetFilter("hist_grupos_gpo not in ('ZZ')")
//	else
//		dw_actualiza_horario.SetFilter("grupos_gpo not in ('ZZ')")
//	end if
//else
//	dw_actualiza_horario.SetFilter(ls_filtro_vacio)
//end if
//
//dw_actualiza_horario.Filter()
//ll_cont = dw_actualiza_horario.rowcount() 
//if ll_cont > 0 then
//	dw_actualiza_horario.ScrollToRow(1)
//end if	
//
//return li_result
end event

type dw_departamento from datawindow within w_actualiza_horario
integer x = 1934
integer y = 32
integer width = 1733
integer height = 312
boolean bringtotop = true
string dataobject = "dw_coordinaciones"
boolean vscrollbar = true
boolean livescroll = true
end type

event itemfocuschanged;ii_depa=object.cve_coordinacion[row]
end event

type ddlb_1 from dropdownlistbox within w_actualiza_horario
integer x = 466
integer y = 188
integer width = 485
integer height = 232
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean vscrollbar = true
string item[] = {"Abiertos","Cancelados"}
end type

event selectionchanged;if index=1 then
	ii_cond=1
else
	ii_cond=0
end if
end event

type cbx_sin_gpos_zz from checkbox within w_actualiza_horario
integer x = 466
integer y = 296
integer width = 485
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Sin Grupos ZZ"
boolean checked = true
end type

type uo_periodo from uo_periodo_variable_tipos within w_actualiza_horario
integer x = 978
integer y = 28
integer width = 910
integer height = 352
integer taborder = 20
boolean bringtotop = true
long backcolor = 134217730
end type

on uo_periodo.destroy
call uo_periodo_variable_tipos::destroy
end on

type em_1 from editmask within w_actualiza_horario
integer x = 704
integer y = 80
integer width = 215
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy"
string displaydata = "`"
end type

event constructor;TabOrder = 0

int periodo,anio


periodo_actual(periodo,anio,gtr_sce)

this.text = string(anio)



end event

event modified;long fecha

fecha = long(this.text)
if fecha < 1900 then
   messagebox ("Información", "El año DEBE ser mayor a 1900")
	this.SelectText(1, Len(this.Text))
	this.setfocus()
end if
end event

type cb_1 from commandbutton within w_actualiza_horario
boolean visible = false
integer x = 3744
integer y = 136
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar"
end type

event clicked;dw_actualiza_horario.triggerevent('carga')
end event

type gb_11 from groupbox within w_actualiza_horario
integer x = 667
integer y = 20
integer width = 283
integer height = 156
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 134217730
string text = "Año"
borderstyle borderstyle = styleraised!
end type

