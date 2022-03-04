$PBExportHeader$w_cambios_nota_2013.srw
$PBExportComments$Esta ventana es de consulta se despliega todas las materias anteriores incritas,calificacion,periodo,anio etc. de la tabla de historico. Juan Campos Nov-1996
forward
global type w_cambios_nota_2013 from w_master_main
end type
type uo_nombre from uo_carreras_alumno_lista within w_cambios_nota_2013
end type
type dw_mov_historico_materias from uo_master_dw within w_cambios_nota_2013
end type
end forward

global type w_cambios_nota_2013 from w_master_main
integer width = 3758
integer height = 2668
string title = "Cambio de Nota"
string menuname = "m_menu_general_2013"
boolean maxbox = false
uo_nombre uo_nombre
dw_mov_historico_materias dw_mov_historico_materias
end type
global w_cambios_nota_2013 w_cambios_nota_2013

type variables
long il_carrera,il_cuenta,il_plan
n_cortes in_cortes
datawindowchild idwc_carreras,idwc_calif
end variables

forward prototypes
public function integer wf_validar ()
end prototypes

public function integer wf_validar ();dwItemStatus l_status
int li_i
string ls_gpo, ls_calificacion
long ll_materia,ll_cuenta
INTEGER le_existe 

l_status = idw_trabajo.GetItemStatus(1, 0, Primary!)

//historico_calificacion
for li_i = 1 to idw_trabajo.Rowcount()
	l_status = idw_trabajo.GetItemStatus(li_i, 'historico_calificacion', Primary!)
	if l_status <> NotModified!	then
		ll_cuenta = idw_trabajo.GetItemNumber(li_i,"cuenta")
		ls_gpo = idw_trabajo.GetItemString(li_i,"historico_gpo")
		ll_materia = idw_trabajo.GetItemNumber(li_i,"historico_cve_mat")
		ls_calificacion = idw_trabajo.GetItemString(li_i,"historico_calificacion")
		if idw_trabajo.GetItemNumber(li_i,"anio") < uo_nombre.istr_carrera.str_anio_ing then
			messagebox('Aviso','El año capturado no puede ser menor a:' + string(uo_nombre.istr_carrera.str_anio_ing))
			return -1
		end if
//		if idw_trabajo.GetItemNumber(li_i,"historico_periodo") < uo_nombre.istr_carrera.str_periodo_ing then
//			messagebox('Aviso','El periodo capturado no puede ser menor a:' + string(uo_nombre.istr_carrera.str_periodo_ing))
//			return -1
//		end if

		// Esta validación se omite de manera temporal  Esta validación se omite de manera temporal Esta validación se omite de manera temporal
//		IF ls_gpo = "ZZ"	then
//			Messagebox("Grupo de Intercambio","No se permiten cambios de nota en grupos de intercambio.~nUtilice las ventanas de Intercambio Provisional/Definitivo para este efecto.",StopSign!)
//			return -1
//		end if
		// Esta validación se omite de manera temporal  Esta validación se omite de manera temporal Esta validación se omite de manera temporal
		
		If Tipo_evaluacion_2013(ll_materia,ls_calificacion) Then
			Return 1
		Else
			messagebox('Aviso','El tipo de evaluación de la materia: ' + string(ll_materia) + ' es incorrecto')
			Return -1
		End if	
		
		// Se verifica si la materia es inglés 
		SELECT COUNT(*) 
		INTO :le_existe 
		FROM materias_requisito 
		WHERE id_prerrequisito = 'ING'	 
		AND cve_mat = :ll_materia 
		USING gtr_sce; 
		IF ISNULL(le_existe) THEN le_existe = 0		
		
		
		//If ll_materia = 4078 Then    // actualiza bandera prerreq. ingles
		If le_existe > 0 Then    // actualiza bandera prerreq. ingles
			If Not Act_Bandera_Prerreq_Ingles(ll_cuenta,ls_calificacion) then
		 		Messagebox("Atención","La bandera de Prerrequisito de ingles NO se actualizo") 	
				 Return -1
			End If
		End IF
	end if
end for



end function

on w_cambios_nota_2013.create
int iCurrent
call super::create
if this.MenuName = "m_menu_general_2013" then this.MenuID = create m_menu_general_2013
this.uo_nombre=create uo_nombre
this.dw_mov_historico_materias=create dw_mov_historico_materias
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_nombre
this.Control[iCurrent+2]=this.dw_mov_historico_materias
end on

on w_cambios_nota_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nombre)
destroy(this.dw_mov_historico_materias)
end on

event closequery;//
end event

event doubleclicked;call super::doubleclicked;il_cuenta = long(uo_nombre.of_obten_cuenta())
il_carrera = uo_nombre.istr_carrera.str_cve_carrera
il_plan = uo_nombre.istr_carrera.str_cve_plan

if il_carrera = 0 then return

dw_mov_historico_materias.Reset()

If idwc_carreras.Retrieve(il_cuenta,il_carrera, il_plan) = 0 Then
	Messagebox("Aviso","El alumno no tiene registradas materias en el historico")	
else
	triggerevent('ue_nuevo')
end if
end event

event open;call super::open;dw_mov_historico_materias.settransobject(gtr_sce)

uo_nombre.em_cuenta.text = " "

if not isvalid(in_cortes) then
	in_cortes = create n_cortes
end if

dw_mov_historico_materias.Getchild('historico_cve_mat',idwc_carreras)
dw_mov_historico_materias.Getchild('historico_calificacion',idwc_calif)
idwc_carreras.settransobject(gtr_sce)
idwc_calif.settransobject(gtr_sce)

triggerevent(doubleclicked!)
/**/gnv_app.inv_security.of_SetSecurity(this)

end event

event activate;call super::activate;control_escolar.toolbarsheettitle="Cambios de nota"
end event

event ue_actualiza;call super::ue_actualiza;integer li_corte_3r_4i,  li_baja_3_reprob, li_baja_4_insc,li_corte_promedio_creditos
long ll_cuenta,  ll_cve_plan, ll_cve_flag_promedio_original
decimal ld_promedio, ldc_creditos
int li_res

li_res = wf_validar ()
if li_res = -1 then
	rollback using gtr_sce;
	messagebox("Información","No se han guardado los cambios")	
	triggerevent(doubleclicked!)
	return
end if

Setpointer(Hourglass!)

ll_cuenta = long(uo_nombre.of_obten_cuenta())
il_carrera = uo_nombre.istr_carrera.str_cve_carrera
ll_cve_plan = uo_nombre.istr_carrera.str_cve_plan

IF dw_mov_historico_materias.Update(True,True) = 1 Then
	Commit using gtr_sce;
	messagebox("Información","Se han guardado los cambios")		
	If Not actualiza_bandera(ll_cuenta,0) then // Actualiza creditos,promedio y banderas
    		Messagebox("ATENCIÓN","Los catálogos, Académicos, Banderas de bloqueos de servicios escolares, NO se actualizaron")
   	    	MessageBox("IMPORTANTE","Revisar promedio, créditos y Banderas bloqueos del alumno, en sus respectivos catálogos")		  	  
    	End if

	//Corte de 3 Reprobadas y 4 Inscripciones
	li_corte_3r_4i = in_cortes.of_corte_3r_4i(ll_cuenta, il_carrera, ll_cve_plan, li_baja_3_reprob, li_baja_4_insc)
					
	ll_cve_flag_promedio_original = in_cortes.of_obten_cve_flag_promedio(ll_cuenta)
	//Calculo de Promedios y Créditos SIN mover Banderas
	li_corte_promedio_creditos = in_cortes.of_corte_promedio_creditos_sb(ll_cuenta, il_carrera, ll_cve_plan, ld_promedio, ldc_creditos)					
	
Else
	Rollback using gtr_sce;
	Messagebox("Algunos datos son incorrectos","Los cambios no fueron guardados")
End if		

end event

event ue_nuevo;call super::ue_nuevo;dw_mov_historico_materias.Insertrow(0)
end event

event ue_borra;call super::ue_borra;dw_mov_historico_materias.deleterow(dw_mov_historico_materias.Getrow())
end event

type st_sistema from w_master_main`st_sistema within w_cambios_nota_2013
end type

type p_ibero from w_master_main`p_ibero within w_cambios_nota_2013
end type

type uo_nombre from uo_carreras_alumno_lista within w_cambios_nota_2013
integer x = 37
integer y = 304
integer width = 3241
integer height = 516
integer taborder = 40
end type

on uo_nombre.destroy
call uo_carreras_alumno_lista::destroy
end on

event constructor;call super::constructor;m_menu_general_2013.objeto = this
end event

type dw_mov_historico_materias from uo_master_dw within w_cambios_nota_2013
integer x = 27
integer y = 832
integer width = 3621
integer height = 1604
integer taborder = 0
string dataobject = "dw_mov_historico_materias_2013"
boolean hscrollbar = false
boolean resizable = true
end type

event constructor;call super::constructor;idw_trabajo = this
m_menu_general_2013.dw = this
end event

event itemchanged;call super::itemchanged;long ll_mat

if dwo.name = 'historico_cve_mat' then
	ll_mat = long(data)
	dw_mov_historico_materias.Retrieve(il_cuenta,ll_mat,il_carrera,il_plan)
	idwc_calif.Retrieve(ll_mat)
end if

end event

