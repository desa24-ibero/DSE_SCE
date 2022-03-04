$PBExportHeader$w_grupos_prof.srw
forward
global type w_grupos_prof from window
end type
type dw_horario from datawindow within w_grupos_prof
end type
type cbx_auxiliar from checkbox within w_grupos_prof
end type
type cb_1 from commandbutton within w_grupos_prof
end type
type uo_1 from uo_per_ani within w_grupos_prof
end type
type cb_actualiza_auxiliar from commandbutton within w_grupos_prof
end type
type r_1 from rectangle within w_grupos_prof
end type
type cbx_baja from checkbox within w_grupos_prof
end type
type cbx_alta from checkbox within w_grupos_prof
end type
type st_año from statictext within w_grupos_prof
end type
type cb_actualiza from commandbutton within w_grupos_prof
end type
type cb_cerrar from commandbutton within w_grupos_prof
end type
type dw_mat_nivel from datawindow within w_grupos_prof
end type
type dw_mov_prof from datawindow within w_grupos_prof
end type
type st_nombre_profesor from statictext within w_grupos_prof
end type
type dw_gpo_prof from datawindow within w_grupos_prof
end type
type rr_1 from roundrectangle within w_grupos_prof
end type
type dw_profesor_auxiliar from uo_dw_captura within w_grupos_prof
end type
type rr_auxiliar from roundrectangle within w_grupos_prof
end type
type st_periodo from statictext within w_grupos_prof
end type
end forward

global type w_grupos_prof from window
integer x = 832
integer y = 364
integer width = 3566
integer height = 1796
boolean titlebar = true
string title = "             MOVIMIENTO PROFESORES."
string menuname = "m_movs_prof"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 27291696
event reset ( )
dw_horario dw_horario
cbx_auxiliar cbx_auxiliar
cb_1 cb_1
uo_1 uo_1
cb_actualiza_auxiliar cb_actualiza_auxiliar
r_1 r_1
cbx_baja cbx_baja
cbx_alta cbx_alta
st_año st_año
cb_actualiza cb_actualiza
cb_cerrar cb_cerrar
dw_mat_nivel dw_mat_nivel
dw_mov_prof dw_mov_prof
st_nombre_profesor st_nombre_profesor
dw_gpo_prof dw_gpo_prof
rr_1 rr_1
dw_profesor_auxiliar dw_profesor_auxiliar
rr_auxiliar rr_auxiliar
st_periodo st_periodo
end type
global w_grupos_prof w_grupos_prof

type variables
window   EstaVentana
Integer    Periodo,Año
Boolean  ProfOk = True
Boolean ib_EsCoordinacion = true
int ii_cve_coordinacion = 0 
long il_cve_mat
integer ii_periodo, ii_anio, ii_cve_dia, ii_hora_inicio, ii_hora_final
string is_gpo
long il_row_prof_aux

uo_periodo_servicios iuo_periodo_servicios
end variables

forward prototypes
public function boolean wf_existe_prof_duplicado (long al_cve_profesor_adj, long al_num_row, integer ai_cve_dia, integer ai_hora_inicio)
public function integer wf_confirma_error (boolean ab_error)
public function integer wf_valida_profesores (boolean ab_error)
public function integer esdepto ()
end prototypes

event reset;// Juan campos Sánchez.       Diciembre-1997.

EstaVentana.SetRedraw(False)
dw_mat_nivel.Reset()
dw_mov_prof.Reset()
dw_gpo_prof.Reset()
dw_profesor_auxiliar.Reset()
dw_gpo_prof.InsertRow(0)
dw_mat_nivel.InsertRow(0)
dw_mov_prof.InsertRow(0)
cb_Actualiza.Enabled = False
dw_gpo_prof.Enabled= True
dw_gpo_prof.SetFocus()
EstaVentana.SetRedraw(True)
end event

public function boolean wf_existe_prof_duplicado (long al_cve_profesor_adj, long al_num_row, integer ai_cve_dia, integer ai_hora_inicio);//wf_existe_prof_duplicado
//Revisa que el profesor escrito no se encuentre duplicado
//
//al_cve_profesor_adj	long
//al_num_row				long
//ai_cve_dia				int
//ai_hora_inicio			int


integer li_cve_dia, li_hora_inicio
long ll_row_prof, ll_cve_profesor_adj


For ll_row_prof = 1 To dw_profesor_auxiliar.RowCount()
	ll_cve_profesor_adj 		= dw_profesor_auxiliar.GetItemNumber(ll_row_prof,"cve_profesor")
	li_cve_dia = dw_profesor_auxiliar.GetItemNumber(ll_row_prof,"cve_dia")
	li_hora_inicio = dw_profesor_auxiliar.GetItemNumber(ll_row_prof,"hora_inicio")
	if ll_row_prof <> al_num_row then		
		if ll_cve_profesor_adj = al_cve_profesor_adj and li_cve_dia = ai_cve_dia AND li_hora_inicio = ai_hora_inicio then
			return true
		end if
	end if	
Next
return false


end function

public function integer wf_confirma_error (boolean ab_error);// Pregunta si se ignorara el error o habra de detener la validacion
//wf_confirma_error
//Recibe:	ab_error boolean

integer li_res

if not ab_error then
	return -1
else
	li_res= MessageBox("Confirmacion", "¿Desea IGNORAR la validacion actual?", Question!, YesNo!,2)
	if li_res = 1 then
	   return 1
	else
		return -1
	end if
end if


end function

public function integer wf_valida_profesores (boolean ab_error);//wf_valida_profesores
//Revisa que los profesores cumplan con los requisitos de captura
//
//al_cve_profesor_adj	long
//al_num_row			long

long ll_cve_mat 
integer li_periodo, li_anio, li_horas_mat_permitidas, li_horas
integer li_null, li_cve_categoria_auxiliar, li_cve_categoria, li_tipo
string ls_gpo, ls_apaterno, ls_amaterno, ls_nombre, ls_nombre_completo, ls_mensaje_adj
string ls_coordinacion
long ll_row_profesor, ll_num_cords_adj, ll_cve_profesor_adj, ll_por_designar, ll_suma_horas
long ll_row_horas_coord, ll_horas_reales, ll_horas_gpo_normal, ll_horas_verano, ll_aviso_horas
long ll_suma_horas_mas_actual, ll_num_cords2_adj, ll_cve_profesor, ll_row
datastore lds_data, lds_data2
int li_cve_dia, li_hora_inicio

ll_horas_gpo_normal = 12
ll_horas_verano = 20
//ll_aviso_horas = 12

ll_row = dw_gpo_prof.GetRow()
SetNull(li_null)
ll_cve_mat = il_cve_mat 
ls_gpo = is_gpo 
li_periodo = ii_periodo 
li_anio = ii_anio 
ll_cve_profesor = dw_gpo_prof.GetItemNumber(ll_row,"cve_profesor")
li_tipo= dw_gpo_prof.GetItemNumber(ll_row,"tipo")

if not horas_materia(ll_cve_mat, li_periodo, li_horas_mat_permitidas) then
		MessageBox("Error al consultar materia", &		
            "No es posible consultar las horas de la materia: "+string(ll_cve_mat),StopSign!)		
		return -1
end if

For ll_row_profesor = 1 To dw_profesor_auxiliar.RowCount()

	ll_cve_profesor_adj			= dw_profesor_auxiliar.GetItemNumber(ll_row_profesor,"cve_profesor")
	li_horas							= dw_profesor_auxiliar.GetItemNumber(ll_row_profesor,"horas")
	li_cve_categoria_auxiliar	= dw_profesor_auxiliar.GetItemNumber(ll_row_profesor,"cve_categoria_auxiliar")
	li_cve_dia 						= dw_profesor_auxiliar.GetItemNumber(ll_row_profesor,"cve_dia")
	li_hora_inicio					= dw_profesor_auxiliar.GetItemNumber(ll_row_profesor,"hora_inicio")
	
	if isnull(ll_cve_profesor_adj) or ll_cve_profesor_adj = li_null then
		MessageBox("Profesor Adjunto sin clave", &		
            "Existe un Profesor Adjunto sin clave capturada.",StopSign!)		
		dw_profesor_auxiliar.ScrollToRow(ll_row_profesor)
		return -1	
	end if

	if ll_cve_profesor_adj <= 8 then
		MessageBox("Profesor Adjunto Invalido", &		
            "La clave del Profesor Adjunto no esta permitida.",StopSign!)		
		dw_profesor_auxiliar.ScrollToRow(ll_row_profesor)
		return -1			
	end if
	
	if isnull(li_horas) or li_horas = li_null then
		MessageBox("Horas invalidas", &		
            "Existe un Profesor Adjunto sin horas capturadas.",StopSign!)		
		dw_profesor_auxiliar.ScrollToRow(ll_row_profesor)
		return -1	
	end if

	if li_horas <= 0 then
		MessageBox("Horas invalidas", &		
            "Existe un Profesor Adjunto con horas invalidas capturadas.",StopSign!)		
		dw_profesor_auxiliar.ScrollToRow(ll_row_profesor)
		return -1	
	end if
	
	if isnull(li_cve_categoria_auxiliar) or li_cve_categoria_auxiliar = li_null then
		MessageBox("Tipo invalido", &		
            "Existe un Profesor Adjunto sin categoria capturada.",StopSign!)		
		dw_profesor_auxiliar.ScrollToRow(ll_row_profesor)
		return -1	
	end if

	If wf_existe_prof_duplicado(ll_cve_profesor_adj, ll_row_profesor,li_cve_dia, li_hora_inicio) then
		MessageBox("Existe un Profesor Adjunto duplicado", &		
            "El profesor: "+string(ll_cve_profesor_adj)+" se encuentra duplicado",StopSign!)		
		dw_profesor_auxiliar.ScrollToRow(ll_row_profesor)
		return -1
	End If

	if li_horas > li_horas_mat_permitidas then
		MessageBox("Error en las horas de Profesor Adjunto", &		
           "No es posible registrar más horas: "+string(li_horas)+"~n de las permitidas: " &
		             +string(li_horas_mat_permitidas),StopSign!)		
		if wf_confirma_error(ab_error) = -1 then
			dw_profesor_auxiliar.ScrollToRow(ll_row_profesor)
			return -1
		end if
	end if
	
	if not(f_profesor_valido(ll_cve_profesor_adj)) then
		MessageBox("Profesor Inexistente", &
	           "El profesor "+string(ll_cve_profesor_adj)+ " no existe registrado~n"+&
				   "o se encuentra inactivo.",StopSign!)
		dw_profesor_auxiliar.SetItem(ll_row_profesor,"cve_profesor", ll_por_designar)
		ls_nombre_completo= f_obten_nombre_profesor(ll_por_designar,ls_apaterno, ls_amaterno, ls_nombre)
		dw_profesor_auxiliar.SetItem(ll_row_profesor,"nombre_completo", ls_nombre_completo)		
		dw_profesor_auxiliar.ScrollToRow(ll_row_profesor)
		return -1
	end if
	
	li_cve_categoria = f_obten_categoria_profesor(ll_cve_profesor_adj)
	if li_cve_categoria= -1 then
		MessageBox("Error en consulta de categoria", &		
		            "No es posible consultar la categoria del profesor capturado",StopSign!)			
		dw_profesor_auxiliar.ScrollToRow(ll_row_profesor)
	end if
	
	//	Revision para grupos no asimilados 	li_tipo <> 2
	//	claves de profesor validas 			ll_cve_profesor_adj > 8
	//	en profesores de asignatura 			li_cve_categoria = 4 
	if li_tipo <> 2 and ll_cve_profesor_adj > 8 and  li_cve_categoria = 4 then
		lds_data = CREATE datastore
	 	lds_data.DataObject = 'd_horas_profesor_coord'
		lds_data.SetTransObject(gtr_sce)
		ll_num_cords_adj = lds_data.Retrieve(ll_cve_profesor_adj,ll_cve_mat, ls_gpo, li_periodo, li_anio)
		ll_suma_horas= 0
		if ll_num_cords_adj>0 then
			ls_mensaje_adj = "~nEl Profesor Adjunto rebasa la cantidad de Horas Permitidas"
			ls_mensaje_adj =ls_mensaje_adj+    "~n Como Titular:"
			for ll_row_horas_coord=1 to ll_num_cords_adj
				ls_coordinacion= lds_data.GetItemString(ll_row_horas_coord,"coordinaciones_coordinacion")
				ll_horas_reales= lds_data.GetItemNumber(ll_row_horas_coord,"horas_tot_coord")
	// Si es verano, las horas deben ser por 2.5 y las horas maximas pasan de 16 a 20
				if li_periodo= 1 then
					ll_horas_reales = ll_horas_reales * 2.5
					ll_horas_gpo_normal = ll_horas_verano
				end if
				ls_mensaje_adj =ls_mensaje_adj+     "~nCoordinación  ["+string(ll_row_horas_coord)+"]        :"+ ls_coordinacion
				ls_mensaje_adj =ls_mensaje_adj+     "~nHoras Coord.  ["+string(ll_row_horas_coord)+"]        :"+ string(ll_horas_reales)
				ll_suma_horas= ll_suma_horas + ll_horas_reales	 
			next
		end if
	
	//Profesor auxiliar	
		lds_data2 = CREATE datastore
		lds_data2.DataObject = 'd_horas_profesor_auxiliar'
		lds_data2.SetTransObject(gtr_sce)
		ll_num_cords2_adj = lds_data2.Retrieve(ll_cve_profesor_adj,ll_cve_mat, ls_gpo, li_periodo, li_anio)
		if ll_num_cords2_adj>0 then
			//Si no existieron registros como titular, pon el titulo
			if ll_num_cords_adj = 0 then
				ls_mensaje_adj =ls_mensaje_adj+ "~nEl Profesor Adjunto rebasa la cantidad de Horas Permitidas"
			end if
			
			ls_mensaje_adj =ls_mensaje_adj+    "~n Como Adjunto:"
			for ll_row_horas_coord=1 to ll_num_cords2_adj
				ls_coordinacion= lds_data2.GetItemString(ll_row_horas_coord,"coordinaciones_coordinacion")
				ll_horas_reales= lds_data2.GetItemNumber(ll_row_horas_coord,"horas_tot_coord")
	// Aqui no es necesario multiplicar las horas, ya que solo se consideran las capturadas
	//sin importar el periodo
				ls_mensaje_adj =ls_mensaje_adj+     "~nCoordinación  ["+string(ll_row_horas_coord)+"]        :"+ ls_coordinacion
				ls_mensaje_adj =ls_mensaje_adj+     "~nHoras Coord.  ["+string(ll_row_horas_coord)+"]        :"+ string(ll_horas_reales)
				ll_suma_horas= ll_suma_horas + ll_horas_reales	 
			next
		end if

		ll_suma_horas_mas_actual = ll_suma_horas + li_horas
		if ll_suma_horas_mas_actual>ll_horas_gpo_normal then
			ls_mensaje_adj =ls_mensaje_adj+     "~nHoras Grupo Actual   :"+ string(li_horas)	
			ls_mensaje_adj =ls_mensaje_adj+     "~n"
			ls_mensaje_adj =ls_mensaje_adj+     "~nHoras Permitidas     :"+string(ll_horas_gpo_normal)
			ls_mensaje_adj =ls_mensaje_adj+     "~nHoras Totales           :"+string(ll_suma_horas_mas_actual)
			MessageBox("Profesor Adjunto con Horas de mas", &		
		            ls_mensaje_adj,StopSign!)	
			if wf_confirma_error(ab_error) = -1 then
				dw_profesor_auxiliar.ScrollToRow(ll_row_profesor)
				return -1
			end if						
		end if
		DESTROY lds_data
		DESTROY lds_data2
	end if


Next

If wf_existe_prof_duplicado(ll_cve_profesor, 0, li_cve_dia, li_hora_inicio) then
	MessageBox("Existe un Profesor Adjunto duplicado", &		
           "El profesor: "+string(ll_cve_profesor_adj)+" se encuentra duplicado"+&
           "~n ya que esta registrado como titular.",StopSign!)		
	return -1
End If

return 1

end function

public function integer esdepto ();string ls_NombreProfile, ls_usuario
int li_cve_coordinacion

SELECT pcp.profile_name INTO :ls_NombreProfile
FROM pc_user_def pcu, pc_profile_def pcp
WHERE pcu.profile_skey = pcp.profile_skey
AND pcu.user_id LIKE :gs_usuario using gtr_sce;

if gtr_sce.sqlcode <> 0 then
	commit using gtr_sce;
	return 0
else
	commit using gtr_sce;
	if ls_NombreProfile <> "Coordinaciones" then return -1
end if

ls_usuario = gs_usuario
//if mid(gs_usuario,2,1) = "_" then ls_sigla = replace(gs_usuario,2,1,"-")
ls_usuario = Upper(ls_usuario)

SELECT cve_coordinacion INTO :li_cve_coordinacion
FROM coordinaciones.
WHERE user_id LIKE :ls_usuario using gtr_sce;

if gtr_sce.sqlcode <> 0 then 
	commit using gtr_sce;
	return 0
else
	commit using gtr_sce;
	return li_cve_coordinacion
end if
end function

on w_grupos_prof.create
if this.MenuName = "m_movs_prof" then this.MenuID = create m_movs_prof
this.dw_horario=create dw_horario
this.cbx_auxiliar=create cbx_auxiliar
this.cb_1=create cb_1
this.uo_1=create uo_1
this.cb_actualiza_auxiliar=create cb_actualiza_auxiliar
this.r_1=create r_1
this.cbx_baja=create cbx_baja
this.cbx_alta=create cbx_alta
this.st_año=create st_año
this.cb_actualiza=create cb_actualiza
this.cb_cerrar=create cb_cerrar
this.dw_mat_nivel=create dw_mat_nivel
this.dw_mov_prof=create dw_mov_prof
this.st_nombre_profesor=create st_nombre_profesor
this.dw_gpo_prof=create dw_gpo_prof
this.rr_1=create rr_1
this.dw_profesor_auxiliar=create dw_profesor_auxiliar
this.rr_auxiliar=create rr_auxiliar
this.st_periodo=create st_periodo
this.Control[]={this.dw_horario,&
this.cbx_auxiliar,&
this.cb_1,&
this.uo_1,&
this.cb_actualiza_auxiliar,&
this.r_1,&
this.cbx_baja,&
this.cbx_alta,&
this.st_año,&
this.cb_actualiza,&
this.cb_cerrar,&
this.dw_mat_nivel,&
this.dw_mov_prof,&
this.st_nombre_profesor,&
this.dw_gpo_prof,&
this.rr_1,&
this.dw_profesor_auxiliar,&
this.rr_auxiliar,&
this.st_periodo}
end on

on w_grupos_prof.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_horario)
destroy(this.cbx_auxiliar)
destroy(this.cb_1)
destroy(this.uo_1)
destroy(this.cb_actualiza_auxiliar)
destroy(this.r_1)
destroy(this.cbx_baja)
destroy(this.cbx_alta)
destroy(this.st_año)
destroy(this.cb_actualiza)
destroy(this.cb_cerrar)
destroy(this.dw_mat_nivel)
destroy(this.dw_mov_prof)
destroy(this.st_nombre_profesor)
destroy(this.dw_gpo_prof)
destroy(this.rr_1)
destroy(this.dw_profesor_auxiliar)
destroy(this.rr_auxiliar)
destroy(this.st_periodo)
end on

event open;// Juan Campos Sánchez.       Diciembre-1997.

This.x=1
This.y=1
EstaVentana = This
dw_gpo_prof.SetTransObject(gtr_sce)
dw_mat_nivel.SetTransObject(gtr_sce)
dw_horario.SetTransObject(gtr_sce)
dw_mov_prof.SetTransObject(gtr_sce)
EstaVentana.SetRedraw(False)
Periodo_Actual_mat_insc(Periodo,Año,gtr_sce)
gi_periodo= Periodo
gi_anio = Año

	//Modif. Roberto Novoa R.  Jun/2016 - Funcionalidad de periodos múltiples
	iuo_periodo_servicios = CREATE uo_periodo_servicios
	iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)
	st_periodo.text = iuo_periodo_servicios.f_recupera_descripcion(ii_periodo , "L")
	

/*
CHOOSE CASE Periodo
CASE 0
	st_periodo.text = "PRIMAVERA"
CASE 1
	st_periodo.text = "VERANO"
CASE 2	
	st_periodo.text = "OTOÑO"
CASE ELSE
	Messagebox('No hay un periodo definido','Intente de nuevo')
	Close(This)
END CHOOSE
*/

st_año.text = String(Año)
dw_gpo_prof.InsertRow(0)
dw_mat_nivel.InsertRow(0)
dw_mov_prof.InsertRow(0)
cb_actualiza.enabled = False
dw_gpo_prof.enabled = False

/*********Modificado FMC Agosto 1998***********/
//ii_cve_coordinacion = EsDepto()
ii_cve_coordinacion= -1
if ii_cve_coordinacion >= 0 then
	ib_escoordinacion = true
else
	ib_escoordinacion = false
end if
/***************Fin modificacion**************/

EstaVentana.SetRedraw(True)


end event

type dw_horario from datawindow within w_grupos_prof
integer x = 2249
integer y = 268
integer width = 1093
integer height = 348
integer taborder = 30
string title = "none"
string dataobject = "d_horario_segundostit"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type cbx_auxiliar from checkbox within w_grupos_prof
integer x = 594
integer y = 44
integer width = 462
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 8388608
string text = "2 TITULARES"
boolean lefttext = true
borderstyle borderstyle = styleraised!
end type

event clicked;cbx_alta.checked = False
cbx_baja.checked = False
cbx_auxiliar.checked = True
EstaVentana.TriggerEvent("Reset")
 
end event

type cb_1 from commandbutton within w_grupos_prof
integer x = 1733
integer y = 28
integer width = 366
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Periodo Act."
end type

event clicked;string ls_periodo


Periodo_Actual_mat_insc(Periodo,Año,gtr_sce)
gi_periodo= Periodo
gi_anio = Año

	//Modif. Roberto Novoa R.  Jun/2016 - Funcionalidad de periodos múltiples
//	iuo_periodo_servicios = CREATE uo_periodo_servicios
	iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)
	st_periodo.text = iuo_periodo_servicios.f_recupera_descripcion(ii_periodo , "L")


/*
CHOOSE CASE gi_periodo
CASE 0
	st_periodo.text = "PRIMAVERA"
CASE 1
	st_periodo.text = "VERANO"
CASE 2	
	st_periodo.text = "OTOÑO"
CASE ELSE
	Messagebox('No hay un periodo definido','Intente de nuevo')
	Close(parent)
END CHOOSE
*/

st_año.text = String(gi_anio)

periodo= gi_periodo
año = gi_anio

uo_1.em_per.text = string(periodo)
uo_1.em_per.event Modified()
uo_1.em_ani.text = string(año)
uo_1.em_ani.event Modified()

end event

type uo_1 from uo_per_ani within w_grupos_prof
integer x = 2149
integer height = 160
integer taborder = 10
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type cb_actualiza_auxiliar from commandbutton within w_grupos_prof
event key pbm_keydown
integer x = 1193
integer y = 1484
integer width = 923
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar Segundos Titulares"
end type

event key;IF keydown(Keyenter!) Then
	TriggerEvent(Clicked!)
End IF
end event

event clicked;// Antonio Pica.		Mayo-2001

integer li_auxiliar, li_valida_profesores
dw_profesor_auxiliar.AcceptText()
li_valida_profesores = wf_valida_profesores(true)
IF li_valida_profesores<> -1 then		
	IF dw_profesor_auxiliar.update(True, True) = 1 Then
		Commit Using gtr_sce;
		Messagebox("Aviso","Los cambios a segundos profesores titulares fueron guardados")
	Else
		Rollback Using gtr_sce;
		Messagebox("Algunos datos son incorrectos","Los cambios NO fueron guardados")
	End IF
End If
				  






end event

type r_1 from rectangle within w_grupos_prof
long linecolor = 16777215
integer linethickness = 3
long fillcolor = 8388608
integer x = 32
integer y = 36
integer width = 261
integer height = 92
end type

type cbx_baja from checkbox within w_grupos_prof
integer x = 311
integer y = 44
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 8388608
string text = "BAJA"
boolean lefttext = true
borderstyle borderstyle = styleraised!
end type

event clicked;cbx_alta.checked = False
cbx_baja.checked = True
cbx_auxiliar.checked = False
EstaVentana.TriggerEvent("Reset")
 
end event

type cbx_alta from checkbox within w_grupos_prof
integer x = 37
integer y = 44
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 8388608
string text = "ALTA"
boolean lefttext = true
borderstyle borderstyle = styleraised!
end type

event clicked;cbx_alta.checked = True
cbx_baja.checked = False
cbx_auxiliar.checked = False
EstaVentana.TriggerEvent("Reset")
 
end event

type st_año from statictext within w_grupos_prof
integer x = 1499
integer y = 44
integer width = 210
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 27291696
boolean enabled = false
string text = "AÑO"
long bordercolor = 8388608
boolean focusrectangle = false
end type

type cb_actualiza from commandbutton within w_grupos_prof
event key pbm_keydown
integer x = 759
integer y = 1484
integer width = 398
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar"
end type

event key;IF keydown(Keyenter!) Then
	TriggerEvent(Clicked!)
End IF
end event

event clicked;// Juan Campos Sánchez.		Diciembre-1997.
integer li_auxiliar, li_valida_profesores, li_set_gpo_prof, li_set_mov_prof, li_update_gpo_prof, li_update_mov_prof
Long Profesor, ll_renglon_gpo_prof, ll_renglon_mov_prof
If cbx_baja.checked Or cbx_alta.checked Then
	If ProfOk Then
		dw_gpo_prof.Accepttext()
		ll_renglon_gpo_prof= dw_gpo_prof.GetRow()
		ll_renglon_mov_prof= dw_mov_prof.GetRow()		
		IF cbx_baja.checked Then
			li_set_gpo_prof= dw_gpo_prof.SetItem(ll_renglon_gpo_prof,"cve_profesor",1) //1=Profesor 
			li_set_mov_prof= dw_mov_prof.SetItem(ll_renglon_mov_prof,"cve_profesor",1) //Por Designar
			li_set_mov_prof= dw_mov_prof.SetItem(ll_renglon_mov_prof,"cve_movimiento",0)            
		Else
			li_set_mov_prof= dw_mov_prof.SetItem(ll_renglon_mov_prof,"cve_profesor",dw_gpo_prof.GetItemNumber(dw_gpo_prof.GetRow(),"cve_profesor")) 
			li_set_mov_prof= dw_mov_prof.SetItem(ll_renglon_mov_prof,"cve_movimiento",1)            
		End If
		li_set_mov_prof= dw_mov_prof.SetItem(ll_renglon_mov_prof,"cve_prof_ant",dw_gpo_prof.GetItemNumber(dw_gpo_prof.GetRow(),"cve_profesor",Primary!,True))
		li_set_mov_prof= dw_mov_prof.SetItem(ll_renglon_mov_prof,"cve_mat",dw_gpo_prof.GetItemNumber(dw_gpo_prof.GetRow(),"cve_mat"))
		li_set_mov_prof= dw_mov_prof.SetItem(ll_renglon_mov_prof,"gpo",dw_gpo_prof.GetItemString(dw_gpo_prof.GetRow(),"gpo"))
		li_set_mov_prof= dw_mov_prof.SetItem(ll_renglon_mov_prof,"periodo",dw_gpo_prof.GetItemNumber(dw_gpo_prof.GetRow(),"periodo"))
		li_set_mov_prof= dw_mov_prof.SetItem(ll_renglon_mov_prof,"anio",dw_gpo_prof.GetItemNumber(dw_gpo_prof.GetRow(),"anio"))            
		li_set_mov_prof= dw_mov_prof.SetItem(ll_renglon_mov_prof,"usuario",gs_usuario)            
		dw_gpo_prof.Accepttext()
		dw_mov_prof.Accepttext()
		li_update_gpo_prof = dw_gpo_prof.update(True,True) 
		li_update_mov_prof = dw_mov_prof.update(True,True) 		
		IF li_update_gpo_prof = 1 And li_update_mov_prof = 1 Then
			Commit Using gtr_sce;
			Messagebox("Aviso","Los cambios fueron guardados")
			EstaVentana.TriggerEvent("Reset")
		Else
			Rollback Using gtr_sce;
			Messagebox("Algunos datos son incorrectos","Los cambios NO fueron guardados")
		End IF
	Else
		Messagebox("Aviso","Favor de verificar la clave de profesor")
	End If
Else
	Messagebox("No hay una opción de movimiento selecionado","Selecciona ALTA o BAJA")	
End If
				  






end event

type cb_cerrar from commandbutton within w_grupos_prof
event key pbm_keydown
integer x = 2158
integer y = 1484
integer width = 398
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar"
end type

event key;IF keydown(Keyenter!) Then
	TriggerEvent(Clicked!)
End IF
end event

event clicked;Rollback Using gtr_sce;
Close(w_grupos_prof)
end event

type dw_mat_nivel from datawindow within w_grupos_prof
string tag = "DATOS TEMPORALES PROFESOR"
integer x = 1125
integer y = 620
integer width = 2098
integer height = 336
boolean enabled = false
boolean titlebar = true
string title = "DATOS MATERIA"
string dataobject = "dw_materia_nivel"
boolean livescroll = true
end type

type dw_mov_prof from datawindow within w_grupos_prof
integer x = 1125
integer y = 260
integer width = 1115
integer height = 356
boolean titlebar = true
string title = "MOVIMIENTO PROFESOR"
string dataobject = "dw_movimiento_prof"
boolean resizable = true
boolean livescroll = true
end type

event itemchanged;If dwo.name = "fecha_movimiento" Then
	cb_actualiza.enabled = True
	cb_actualiza.SetFocus()
End if
end event

type st_nombre_profesor from statictext within w_grupos_prof
integer x = 622
integer y = 988
integer width = 2098
integer height = 96
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
boolean enabled = false
string text = " "
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type dw_gpo_prof from datawindow within w_grupos_prof
event nuevo_profesor ( )
event borra_profesor_actual ( )
event movto_profesor_actual ( )
integer x = 32
integer y = 160
integer width = 3369
integer height = 960
integer taborder = 20
boolean titlebar = true
string title = "PLAN GRUPOS"
string dataobject = "dw_grupos_prof"
boolean livescroll = true
end type

event nuevo_profesor;dw_profesor_auxiliar.TriggerEvent("nuevo")

end event

event borra_profesor_actual;dw_profesor_auxiliar.TriggerEvent("borra_actual")

end event

event movto_profesor_actual;dw_profesor_auxiliar.TriggerEvent("movto_profesor_actual")

end event

event itemchanged;// Juan Campos Sánchez.       Enero-1998.

String	MatGpo, Apaterno,Amaterno,Nombre
Long	Materia,Existe = 0
Long		ProfGpo
int		li_res
long ll_cve_mat
integer li_periodo, li_anio, li_permite_doble_presencia
string ls_gpo, ls_grupos_encimados

AcceptText()
Estaventana.SetRedraw(False)
If dwo.name = "grupos_cve_mat_gpo" Then
	MatGpo = GetItemString(GetRow(),"grupos_cve_mat_gpo")
	IF Retrieve(MatGpo,Periodo,Año) > 0 Then		
  		Materia = GetItemNumber(GetRow(),"cve_mat")
  		ProfGpo = GetItemNumber(GetRow(),"cve_profesor")
		/****Agregado FMC Agosto 1998************/
		if ib_escoordinacion then
			dw_mat_nivel.DataObject = "dw_materia_nivel_depto"
			dw_mat_nivel.SetTransObject(gtr_sce)
			li_res = dw_mat_nivel.Retrieve(Materia, ii_cve_coordinacion)
		else
			dw_mat_nivel.DataObject = "dw_materia_nivel"
			dw_mat_nivel.SetTransObject(gtr_sce)
			li_res = dw_mat_nivel.Retrieve(Materia)
		end if
		/***Fin modificacion****/
    	If li_res > 0 Then
			Select apaterno,amaterno,nombre Into :Apaterno,:Amaterno,:Nombre
			From profesor where cve_profesor =: ProfGpo AND status LIKE "A" using gtr_sce;
//			if gtr_sce.sqlcode = 100 Then
//				Select apaterno,amaterno,nombre Into :Apaterno,:Amaterno,:Nombre
//				From profesor_temporal where cve_profesor =: ProfGpo using gtr_sce;
				If gtr_sce.sqlcode = 100 Then
					Messagebox("Aviso","No se encontro el nombre del profesor")			
				Else
					st_nombre_profesor.text =Nombre +' '+Apaterno+' '+Amaterno
				End If
//			Else
//				st_nombre_profesor.text =Nombre +' '+Apaterno+' '+Amaterno 
//			End If
//			
			If cbx_alta.checked Then
				If ProfGpo <> 1 Then
					Messagebox("Este movimiento no es valido","El profesor en grupos debe ser: Por Designar",StopSign!)
					w_grupos_prof.TriggerEvent("Reset")
				End if
			ElseIf cbx_baja.checked Then
				If ProfGpo = 1 Then
					Messagebox("Este movimiento no es valido","No se puede dar de baja, si el grupo tiene profesor por designar",StopSign!)
					w_grupos_prof.TriggerEvent("Reset")
				Else				
					dw_mov_prof.SetFocus()
				End if
			ElseIf cbx_auxiliar.checked Then 
					Messagebox("Movimientos a segundos titulares","Se procedera a capturar los segundos profesores titulares",Information!)				
				//	TriggerEvent("nuevo_profesor")
			End If		
		Else
			Messagebox("No hay información con esta clave","Intenta de nuevo")
			w_grupos_prof.TriggerEvent("Reset")
		End IF
			Else
				Messagebox("No hay datos en el catálogo de materias","Verifique la clave de materia")
				w_grupos_prof.TriggerEvent("Reset")     
			End IF 
Elseif dwo.name = "cve_profesor" Then
	AcceptText()
	If cbx_alta.checked Then
		ProfGpo = GetItemNumber(GetRow(),"cve_profesor")
		ll_cve_mat = GetItemNumber(GetRow(),"cve_mat")
		ls_gpo = GetItemString(GetRow(),"gpo")
		li_periodo = GetItemNumber(GetRow(),"periodo")
		li_anio = GetItemNumber(GetRow(),"anio")
		If ProfGpo >= 90000 Then
			Select Count(*) Into :Existe From profesor
			Where cve_profesor = :ProfGpo  AND status LIKE "A"  using gtr_sce;
			If gtr_sce.sqlcode = 0 And Existe > 0 Then
				IF f_doble_presencia_horario_prof(ll_cve_mat, ls_gpo, li_periodo, li_anio, ProfGpo, ls_grupos_encimados) THEN
					li_permite_doble_presencia = MessageBox("Advertencia: Grupo Encimado", &
										"El profesor ["+ string(ProfGpo)+"] tiene otros grupos a la misma hora:~n"+ls_grupos_encimados+"~n¿Desea asignarlo?",Question!,YesNo!)
					IF li_permite_doble_presencia = 1 THEN
						ProfOk = True
						dw_mov_prof.Setfocus()
					ELSE
						ProfOk = False
						this.SetItem(GetRow(),"cve_profesor",GetItemNumber(GetRow(),"cve_profesor",Primary!,TRUE))
						this.SetText("1")
						ReselectRow(GetRow())
						Messagebox("Horario Encimado","Favor de Seleccionar otro profesor",StopSign!)
					END IF
				ELSE
					ProfOk = True
					dw_mov_prof.Setfocus()
				END IF
			Else
				ProfOk = False
				ReselectRow(GetRow())
				Messagebox("La Clave del Profesor No Existe","Intente de nuevo.")
			End If		
		Else
			Select nombre_completo
			Into :st_nombre_profesor.text
			From profesor
			Where cve_profesor = :ProfGpo AND status LIKE "A"  using gtr_sce;
			If gtr_sce.sqlcode = 0 Then
				IF f_doble_presencia_horario_prof(ll_cve_mat, ls_gpo, li_periodo, li_anio, ProfGpo, ls_grupos_encimados) THEN
					li_permite_doble_presencia = MessageBox("Advertencia: Grupo Encimado", &
										"El profesor "+ string(ProfGpo)+" tiene otros grupos a la misma hora:~n"+ls_grupos_encimados+"~n¿Desea asignarlo?",Question!,YesNo!)
					IF li_permite_doble_presencia = 1 THEN
						ProfOk = True
						dw_mov_prof.Setfocus()
					ELSE
						ProfOk = False
						this.SetItem(GetRow(),"cve_profesor",GetItemNumber(GetRow(),"cve_profesor",Primary!,TRUE))
						this.SetText("1")
						ReselectRow(GetRow())
						Messagebox("Horario Encimado","Favor de Seleccionar otro profesor",StopSign!)
					END IF
				ELSE
					ProfOk = True
					dw_mov_prof.Setfocus()
				END IF				
			Else
				ProfOk = False
				ReselectRow(GetRow())
				Messagebox("La Clave del Profesor No Existe","Intente de nuevo.")
			End If
		End If	
	End IF
End if
ll_cve_mat = GetItemNumber(GetRow(),"cve_mat")
ls_gpo = GetItemString(GetRow(),"gpo")
dw_horario.retrieve(ll_cve_mat,ls_gpo,Periodo,Año)			
Estaventana.SetRedraw(True)
end event

event getfocus;// Juan Campos Sánchez.   Enero-1998.

If cbx_baja.checked Then
	SetTabOrder(1, 10)
	SetTabOrder(13, 0)
ElseIf cbx_alta.checked Then
	SetTabOrder(1, 10)
	SetTabOrder(13, 20)
ElseIf cbx_auxiliar.checked Then
	SetTabOrder(1, 10)
	SetTabOrder(13, 20)
Else
	This.Enabled = False
	Messagebox("No hay un movimiento seleccionado","Seleccione [ALTA, BAJA o AUXIL]")
End IF


end event

event retrieveend;long ll_row

if rowcount>  0 then
	ll_row= this.GetRow()
 	il_cve_mat = GetItemNumber(ll_row,"cve_mat")
	is_gpo = GetItemString(ll_row,"gpo")
 	ii_periodo = GetItemNumber(ll_row,"periodo")
 	ii_anio = GetItemNumber(ll_row,"anio")
   dw_profesor_auxiliar.Enabled = true
	dw_profesor_auxiliar.Retrieve(il_cve_mat, is_gpo, ii_periodo, ii_anio)
	
else 	
 	il_cve_mat = 9999
	is_gpo = ""
   dw_profesor_auxiliar.Enabled = false
	dw_profesor_auxiliar.Reset()
end if
end event

event constructor;m_movs_prof.dw = this
end event

event rbuttondown;//Menu4 NewMenu
//
//NewMenu = CREATE Menu4
//
//NewMenu.m_language.PopMenu(xpos, ypos)
//
//In an MDI application, the arguments for PopMenu need to specify coordinates relative to the MDI frame:
//
//NewMenu.m_language.PopMenu( &
//
//w_frame.PointerX(), w_frame.PointerY())
end event

type rr_1 from roundrectangle within w_grupos_prof
long linecolor = 16777215
integer linethickness = 3
long fillcolor = 8388608
integer x = 306
integer y = 36
integer width = 270
integer height = 92
integer cornerheight = 42
integer cornerwidth = 40
end type

type dw_profesor_auxiliar from uo_dw_captura within w_grupos_prof
event type integer borra_actual ( )
event type integer borra_todo ( )
event type integer movto_profesor_actual ( )
integer x = 32
integer y = 1148
integer width = 3360
integer height = 348
integer taborder = 30
boolean titlebar = true
string title = "PROFESOR AUXILIAR"
string dataobject = "d_profesor_auxiliar_cprof"
borderstyle borderstyle = styleraised!
end type

event borra_actual;integer li_res_del
long ll_row, ll_num_rows, ll_row_actual, ll_rows_nuevos[], ll_indice_array, ll_tam_array

ll_row_actual = GetRow()
ll_num_rows = RowCount()	


li_res_del= DeleteRow(ll_row_actual)


return 1

end event

event borra_todo;long ll_cve_mat
integer li_cve_coordinacion, li_periodo, li_anio, li_respuesta, li_res_del, li_res_upd
string ls_gpo, ls_mensaje_sql
long ll_row, ll_num_rows, ll_row_horario
integer li_cve_dia_orig, li_hora_inicio_orig, li_hora_final_orig, li_cupo
dwItemStatus l_status
boolean lb_desc_sdu_se

ll_cve_mat= il_cve_mat
ls_gpo = is_gpo
li_periodo = ii_periodo
li_anio = ii_anio

	
	
ll_num_rows = RowCount()

for ll_row=1 to ll_num_rows
	li_res_del= DeleteRow(0)
next

//if ib_borrando then
	li_res_upd= Update()
	ls_mensaje_sql= gtr_sce.SqlErrText
	IF li_res_upd = 1  THEN
		COMMIT USING gtr_sce;
	ELSE
		ROLLBACK USING gtr_sce;
		MessageBox("Error al eliminar el profesor adjunto", ls_mensaje_sql)
		return -1
	END IF

	return 1
//else
//	return 1
//end if



end event

event type integer movto_profesor_actual();long ll_row
ll_row = this.GetRow()

if ll_row <= 0 then
	return 0
end if


integer li_res, li_deten_timer, li_inicia_timer
long ll_cve_profesor,ll_cve_profesor_ant, ll_row_anterior, ll_num_rows, ll_num_seguimiento
str_movimiento_prof_aux lstr_movimiento_prof_aux
dwItemStatus l_status
long ll_modified, ll_deleted, ll_num_movtos, ll_num_actualizaciones
integer li_auxiliar, li_valida_profesores

this.AcceptText()
li_valida_profesores = wf_valida_profesores(true)

IF li_valida_profesores= -1 then		
	MessageBox("Error","Es necesario de corregir los errores de los ~n" +&
	           "segundos profesores titulares antes de registrar un movimiento", StopSign!)
	return 0

End If

ll_modified = this.ModifiedCount()
ll_deleted = this.DeletedCount()

l_status = this.GetItemStatus(ll_row, 0, Primary!)

If (l_status = New! or l_status = NewModified!) then
	ll_cve_profesor_ant = 1
else
	ll_cve_profesor_ant = this.GetItemNumber(ll_row, "cve_profesor", Primary!, True)
end if

ll_cve_profesor = this.GetItemNumber(ll_row, "cve_profesor")
ii_cve_dia = GetItemNumber(ll_row,"cve_dia")
ii_hora_inicio = GetItemNumber(ll_row,"hora_inicio")
ii_hora_final = GetItemNumber(ll_row,"hora_final")

li_res= MessageBox("Confirmacion","¿Desea registrar movimiento al profesor ["+ string(ll_cve_profesor)+"] ?", Question!, YesNo!)

if li_res = 1 then
	
	lstr_movimiento_prof_aux.cve_profesor = ll_cve_profesor
	lstr_movimiento_prof_aux.cve_prof_ant = ll_cve_profesor_ant
	lstr_movimiento_prof_aux.cve_mat = il_cve_mat
	lstr_movimiento_prof_aux.gpo = is_gpo
	lstr_movimiento_prof_aux.periodo = ii_periodo
	lstr_movimiento_prof_aux.anio = ii_anio
	lstr_movimiento_prof_aux.cve_dia = ii_cve_dia
	lstr_movimiento_prof_aux.hora_inicio = ii_hora_inicio
	lstr_movimiento_prof_aux.hora_final = ii_hora_final
	lstr_movimiento_prof_aux.usuario = gs_usuario
	
	OpenWithParm(w_movimientos_prof_aux, lstr_movimiento_prof_aux, w_grupos_prof)
	
	ll_num_movtos=	Message.DoubleParm
	
	ll_modified = this.ModifiedCount()
	ll_deleted = this.DeletedCount()
	
	
	ll_num_actualizaciones =ll_modified + ll_deleted 
	

	if ll_num_actualizaciones > 0 and ll_num_movtos > 0 then
		IF dw_profesor_auxiliar.update(True, True) = 1 Then
			Commit Using gtr_sce;
			Messagebox("Aviso","Los cambios a segundos profesores titulares fueron guardados")
		Else
			Rollback Using gtr_sce;
			Messagebox("Algunos datos son incorrectos","Los cambios NO fueron guardados")
		End IF		
	end if
end if

il_row_prof_aux =	ll_row

return 0

end event

event asigna_dw_menu;///*
//DESCRIPCIÓN: Evento en el cual se asigna a la variable dw del menu este objeto.
//				En este evento se busca la ventana dueña del objeto y cual es su menu
//PARÁMETROS: Ninguno
//REGRESA: Nada
//AUTOR: CAMP(DkWf)
//FECHA: 17 Junio 1998
//MODIFICACIÓN:
//*/
//window ventana_propietaria
//
//ventana_propietaria = getparent()
//
//menu_propietario = ventana_propietaria.menuid
//
//menu_propietario.dw	= this
end event

event actualiza_np;//	La unica interacción con el usuario es mediante avisos de que los campos se guardaron o no
//PARÁMETROS: Ninguno
//REGRESA: Nada
//AUTOR: Antonio Pica
//FECHA: 8 Mayo 2001
//MODIFICACIÓN:


if event actualiza_0_int() = 1 then
	/*Si es asi, guardalo en la tabla y avisa.*/
//	messagebox("Información","Se han guardado los cambios")
	return 1
else
	/*De lo contrario, desecha los cambios (todos) y avisa*/
	messagebox("Información","Algunos datos están incorrectos, favor de corregirlos")	
	return -1
end if

end event

event actualiza;//DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
//				
//PARÁMETROS: Ninguno
//REGRESA: Nada
//AUTOR: Antonio Pica Ruiz
//FECHA: 17 Octubre 2000
//MODIFICACIÓN:

int li_respuesta
//Acepta el texto de la última columna editada
AcceptText()
//Ve si existen cambios en el DataWindow que no se hayan guardado
if ModifiedCount()+DeletedCount() > 0 Then

//Pregunta si se desean guardar los cambios hechos
//li_respuesta = messagebox("Atención","Desea actualizar los cambios:",StopSign!,YesNo!,2)
	
	li_respuesta= 1
	
	if li_respuesta = 1 then
//			Checa que los renglones cumplan con las reglas de validación
			if event actualiza_np() = 1 then//Manda llamar la función que realiza el update
				return 1
			else 
				return -1
			end if
	else
//		De lo contrario, solo avisa que no se guardó nada.
		messagebox("Información","No se han guardado los cambios")
		return -1
	end if
else
	return 1
end if


end event

event borra;
long ll_cve_mat
integer li_cve_coordinacion, li_periodo, li_anio, li_respuesta
string ls_gpo
long ll_row



li_respuesta = messagebox("Atención","Esta seguro de querer borrar el profesor actual.",StopSign!,YesNo!,2)

if li_respuesta = 1 then
	if deleterow(getrow())	= 1 then
		triggerevent("actualiza")
	else
		messagebox("Información","No se han guardado los cambios")	
	end if
elseif li_respuesta = 2 then
	rollback using gtr_sce;
end if


end event

event carga;//DESCRIPCIÓN: Antes de cargar algo, ve si hay modificaciones no guardadas.

if event actualiza()=1 then
	event primero()
	return 0
	return this.retrieve(il_cve_mat, is_gpo, ii_periodo, ii_anio)
end if

end event

event dberror;call super::dberror;return 0

end event

event inicia_transaction_object;tr_dw_propio = gtr_sce
this.SetTransObject(gtr_sce)

end event

event nuevo;long ll_cve_mat
integer li_cve_coordinacion, li_periodo, li_anio
string ls_gpo
long ll_row, ll_row_padre


ll_cve_mat= il_cve_mat
ls_gpo = is_gpo
li_periodo = ii_periodo
li_anio = ii_anio
ll_row_padre= dw_gpo_prof.GetRow()

if not (f_materia_valida(ll_cve_mat, 9999) and &
	 f_grupo_valido(ls_gpo)) then
	MessageBox("Grupo Invalido", "Favor de Seleccionar materias y grupos validos "+&	
	"antes de comenzar una Insercion de profesores.")
//	uo_1.rb_editar.checked = true
//	uo_1.is_estatus = "Modificar"
	return	
elseif ll_row_padre <= 0 then
	MessageBox("Profesor Invalido", "Favor de iniciar la insercion del grupo "+&
	            "antes de los profesores.")
//	uo_1.rb_editar.checked = true
//	uo_1.is_estatus = "Modificar"
	return	
end if

setfocus()
scrolltorow(insertrow(0))
ll_row = this.GetRow()
this.object.cve_mat[ll_row]= ll_cve_mat
this.object.gpo[ll_row]= ls_gpo
this.object.periodo[ll_row]= li_periodo
this.object.anio[ll_row]= li_anio
setcolumn("cve_categoria_auxiliar")

end event

event itemchanged;call super::itemchanged;string ls_columna, ls_apaterno, ls_amaterno, ls_nombre, ls_nombre_completo, ls_cve_profesor_ec
string ls_cve_profesor_dw, ls_nombre_completo_dw
boolean lb_modificando
long ll_cve_profesor_dw, ll_por_designar, ll_cve_profesor_ec

if lb_modificando then
	return
end if

lb_modificando = true

ll_por_designar= 1
ll_cve_profesor_dw = object.cve_profesor[row]
ls_nombre_completo_dw= object.nombre_completo[row] 
if isnull(ll_cve_profesor_dw) then
	ls_cve_profesor_dw = ""
else
	ls_cve_profesor_dw = string(ll_cve_profesor_dw)	
end if

if isnull(ls_nombre_completo_dw) then
	ls_nombre_completo_dw = ""
else
	ls_nombre_completo_dw = ls_nombre_completo_dw
end if

ls_columna =this.GetColumnName()

choose case ls_columna 
case "cve_profesor"
		ls_cve_profesor_ec = this.GetText()
		if isnumber(ls_cve_profesor_ec) then
			ll_cve_profesor_ec = long(ls_cve_profesor_ec)
		end if
		if not(f_profesor_valido(ll_cve_profesor_ec)) then
			MessageBox("Profesor Inexistente", &
			           "El profesor "+string(ll_cve_profesor_ec)+ " no existe registrado"+&
						   "~n o esta registrado como inactivo",StopSign!)
			this.SetText(string(ls_cve_profesor_dw))
			this.object.nombre_completo[row] = ls_nombre_completo_dw
//				ls_nombre_completo= f_obten_nombre_profesor(ll_por_designar,ls_apaterno, ls_amaterno, ls_nombre)
//			this.object.nombre_completo[row] = ls_nombre_completo
//			this.object.cve_profesor[row] = ll_por_designar
			lb_modificando = false
			return 2
		else
			ls_nombre_completo= f_obten_nombre_profesor(ll_cve_profesor_ec,ls_apaterno, ls_amaterno, ls_nombre)
			this.object.nombre_completo[row] = ls_nombre_completo
			lb_modificando = false
			return 0
		end if

end choose

lb_modificando = false
return 0


end event

event retrieveend;call super::retrieveend;string ls_columna, ls_apaterno, ls_amaterno, ls_nombre, ls_nombre_completo
long ll_row_actual, ll_cve_profesor

//Es Necesario actualizar el nombre completo, para no sobrecargar la red 
//en la utilizacion de un drop down datawindow

For ll_row_actual = 1 to  rowcount
	ll_cve_profesor = object.cve_profesor[ll_row_actual]
	ls_nombre_completo= f_obten_nombre_profesor(ll_cve_profesor,ls_apaterno, ls_amaterno, ls_nombre)
	this.object.nombre_completo[ll_row_actual] = ls_nombre_completo
	this.SetItemStatus(ll_row_actual, 0, Primary!, NotModified!)
Next
end event

event rbuttondown;call super::rbuttondown;//m_movimiento_prof_aux NewMenu
//
//NewMenu = CREATE m_movimiento_prof_aux
//
////NewMenu.PopMenu( xpos, ypos)
//NewMenu.PopMenu( parent.PointerX(), parent.PointerY())
//
end event

event doubleclicked;call super::doubleclicked;//if row <= 0 then
//	return
//end if
//
//
//integer li_res, li_deten_timer, li_inicia_timer
//long ll_cve_profesor,ll_cve_profesor_ant, ll_row_anterior, ll_num_rows, ll_num_seguimiento
//str_movimiento_prof_aux lstr_movimiento_prof_aux
//dwItemStatus l_status
//
//l_status = this.GetItemStatus(row, 0, Primary!)
//
//If (l_status = New! or l_status = NewModified!) then
//	ll_cve_profesor_ant = 1
//else
//	ll_cve_profesor_ant = this.GetItemNumber(row, "cve_profesor", Primary!, True)
//end if
//
//ll_cve_profesor = this.GetItemNumber(row, "cve_profesor")
//
//li_res= MessageBox("Confirmacion","¿Desea registrar movimiento al profesor ["+ string(ll_cve_profesor)+"] ?", Question!, YesNo!)
//
//if li_res = 1 then
//	
//	lstr_movimiento_prof_aux.cve_profesor = ll_cve_profesor
//	lstr_movimiento_prof_aux.cve_prof_ant = ll_cve_profesor_ant
//	lstr_movimiento_prof_aux.cve_mat = ii_cve_mat
//	lstr_movimiento_prof_aux.gpo = is_gpo
//	lstr_movimiento_prof_aux.periodo = ii_periodo
//	lstr_movimiento_prof_aux.anio = ii_anio
//	lstr_movimiento_prof_aux.usuario = gs_usuario
//	
//	OpenWithParm(w_movimientos_prof_aux, lstr_movimiento_prof_aux, w_grupos_prof)
//end if
//
//il_row_prof_aux =	row
//
//
//
end event

type rr_auxiliar from roundrectangle within w_grupos_prof
long linecolor = 16777215
integer linethickness = 3
long fillcolor = 8388608
integer x = 585
integer y = 36
integer width = 485
integer height = 92
integer cornerheight = 42
integer cornerwidth = 40
end type

type st_periodo from statictext within w_grupos_prof
integer x = 1074
integer y = 44
integer width = 416
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 27291696
boolean enabled = false
string text = "PERIODO"
alignment alignment = center!
long bordercolor = 8388608
boolean focusrectangle = false
end type

