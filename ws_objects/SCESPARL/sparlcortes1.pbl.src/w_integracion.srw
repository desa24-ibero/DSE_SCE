$PBExportHeader$w_integracion.srw
forward
global type w_integracion from w_ancestral
end type
type dw_3 from datawindow within w_integracion
end type
type dw_2 from datawindow within w_integracion
end type
type st_2 from statictext within w_integracion
end type
type st_1 from statictext within w_integracion
end type
type cb_1 from commandbutton within w_integracion
end type
type dw_1 from datawindow within w_integracion
end type
type uo_1 from uo_per_ani within w_integracion
end type
end forward

global type w_integracion from w_ancestral
integer width = 3442
integer height = 1636
string title = "Corte de Integración"
dw_3 dw_3
dw_2 dw_2
st_2 st_2
st_1 st_1
cb_1 cb_1
dw_1 dw_1
uo_1 uo_1
end type
global w_integracion w_integracion

type variables

DATASTORE ids_area_mat 
DATASTORE ids_areas_plan
end variables

forward prototypes
public function boolean f_carga_areas_materias ()
end prototypes

public function boolean f_carga_areas_materias ();
// Función que carga las materias y areas relacionadas con temas fundamentales y temas de integración.
STRING ls_query
INTEGER le_num_rgs

// Se define query que recupera las relaciones entre materias y areas de integración. 
//ls_query = " SELECT am.cve_area, am.cve_mat " + & 
//				" FROM area_mat am " + & 
//				" WHERE (am.cve_area IN(SELECT DISTINCT pe1.cve_area_integ_tema1 as area " + & 
//											" FROM plan_estudios pe1) " + &  
//						" OR am.cve_area IN(SELECT DISTINCT pe2.cve_area_integ_tema2  as area " + & 
//											" FROM plan_estudios pe2) " + &  
//						" OR am.cve_area IN(SELECT DISTINCT pe3.cve_area_integ_tema3  as area " + & 
//											" FROM plan_estudios pe3) " + &  
//						" OR am.cve_area IN(SELECT DISTINCT pe4.cve_area_integ_tema4  as area " + & 
//											" FROM plan_estudios pe4) " + &  
//						" OR am.cve_area IN(SELECT DISTINCT pe5.cve_area_integ_fundamental   as area " + & 
//											" FROM plan_estudios pe5  ) ) "

ls_query = " SELECT DISTINCT am.cve_area, am.cve_mat " + &  
				" FROM area_mat am, " + &    
						" (SELECT DISTINCT pe1.cve_area_integ_tema1 as area " + &   
						" FROM plan_estudios pe1 WHERE pe1.tipo_periodo = ~~'" + gs_tipo_periodo + "~~' " + & 
						" UNION " + &  
						" SELECT DISTINCT pe2.cve_area_integ_tema2  as area " + &   
						" FROM plan_estudios pe2 WHERE pe2.tipo_periodo = ~~'" + gs_tipo_periodo + "~~' " + & 
						" UNION " + &  
						" SELECT DISTINCT pe3.cve_area_integ_tema3  as area " + &   
						" FROM plan_estudios pe3 WHERE pe3.tipo_periodo = ~~'" + gs_tipo_periodo + "~~' " + & 
						" UNION " + &  
						" SELECT DISTINCT pe4.cve_area_integ_tema4  as area " + &   
						" FROM plan_estudios pe4 WHERE pe4.tipo_periodo = ~~'" + gs_tipo_periodo + "~~' " + & 
						" UNION " + &  
						" SELECT DISTINCT pe5.cve_area_integ_fundamental   as area " + &   
						" FROM plan_estudios pe5 WHERE pe5.tipo_periodo = ~~'" + gs_tipo_periodo + "~~') areas " + &  
				" WHERE am.cve_area = areas.area "
ids_area_mat = CREATE DATASTORE 
ids_area_mat.DATAOBJECT = "d_area_mat_cortes" 
ids_area_mat.MODIFY("Datawindow.Table.Select = '" + ls_query + "'") 
ids_area_mat.SETTRANSOBJECT(gtr_sce)
le_num_rgs = ids_area_mat.RETRIEVE()
IF le_num_rgs < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar las areas asociadas a temas de integración." )
	RETURN FALSE 	
END IF



// Se define query para cargar las areas relacionadas a los temas de integración y Fundamentales. 
ls_query = " SELECT DISTINCT pe.cve_carrera, pe.cve_plan, pe.cve_area_integ_fundamental, ~~'fundamental~~' " + & 
				" FROM cuentas_cortes cc, academicos ac, plan_estudios pe " + &   
				" WHERE cc.cuenta = ac.cuenta " + &  
				" AND ac.cve_carrera = pe.cve_carrera " + &  
				" AND ac.cve_plan = pe.cve_plan " + &  
				" AND pe.tipo_periodo = ~~'" + gs_tipo_periodo + "~~'" + & 
				" UNION " + &  
				" SELECT DISTINCT pe.cve_carrera, pe.cve_plan,pe.cve_area_integ_tema1, ~~'tema1~~' " + & 
				" FROM cuentas_cortes cc, academicos ac, plan_estudios pe " + &   
				" WHERE cc.cuenta = ac.cuenta " + &  
				" AND ac.cve_carrera = pe.cve_carrera " + & 
				" AND ac.cve_plan = pe.cve_plan " + &  
				" AND pe.tipo_periodo = ~~'" + gs_tipo_periodo + "~~'" + & 
				" UNION " + &  
				" SELECT DISTINCT pe.cve_carrera, pe.cve_plan,pe.cve_area_integ_tema2, ~~'tema2~~' " + & 
				" FROM cuentas_cortes cc, academicos ac, plan_estudios pe " + &   
				" WHERE cc.cuenta = ac.cuenta " + &  
				" AND ac.cve_carrera = pe.cve_carrera " + & 
				" AND ac.cve_plan = pe.cve_plan " + &  
				" AND pe.tipo_periodo = ~~'" + gs_tipo_periodo + "~~'" + & 
				" UNION " + &  
				" SELECT DISTINCT pe.cve_carrera, pe.cve_plan,pe.cve_area_integ_tema3, ~~'tema3~~' " + & 
				" FROM cuentas_cortes cc, academicos ac, plan_estudios pe " + &   
				" WHERE cc.cuenta = ac.cuenta " + &  
				" AND ac.cve_carrera = pe.cve_carrera " + & 
				" AND ac.cve_plan = pe.cve_plan " + &  
				" AND pe.tipo_periodo = ~~'" + gs_tipo_periodo + "~~'" + & 
				" UNION " + &  
				" SELECT DISTINCT pe.cve_carrera, pe.cve_plan,pe.cve_area_integ_tema4, ~~'tema4~~' " + &  
				" FROM cuentas_cortes cc, academicos ac, plan_estudios pe " + &   
				" WHERE cc.cuenta = ac.cuenta " + &  
				" AND ac.cve_carrera = pe.cve_carrera " + & 
				" AND ac.cve_plan = pe.cve_plan " + &
				" AND pe.tipo_periodo = ~~'" + gs_tipo_periodo + "~~'" 
				
ids_areas_plan = CREATE DATASTORE 
ids_areas_plan.DATAOBJECT = "d_area_plan_cortes"
ids_areas_plan.MODIFY("Datawindow.Table.Select = '" + ls_query + "'")
ids_areas_plan.SETTRANSOBJECT(gtr_sce)
le_num_rgs = ids_areas_plan.RETRIEVE()
IF le_num_rgs < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar las areas asociadas a los planes de estudio." ) 
	RETURN FALSE 	
END IF

RETURN TRUE 





end function

on w_integracion.create
int iCurrent
call super::create
this.dw_3=create dw_3
this.dw_2=create dw_2
this.st_2=create st_2
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_1=create dw_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.uo_1
end on

on w_integracion.destroy
call super::destroy
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.uo_1)
end on

event open;call super::open;//periodo_actual(gi_periodo,gi_anio,gtr_sce)
end event

type p_uia from w_ancestral`p_uia within w_integracion
end type

type dw_3 from datawindow within w_integracion
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
event retrieverow pbm_dwnretrieverow
integer x = 1051
integer y = 1076
integer width = 1531
integer height = 432
integer taborder = 30
string dataobject = "d_mat_integra"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
end event

event retrieveend;
// Se llama función que carga las relaciones entre area y materia
IF NOT f_carga_areas_materias() THEN RETURN -1 


long lo_cont_1,lo_cont_2 ,lo_cuenta, ll_cve_coordinacion
LONG ll_cve_mat
string ls_tema  , ls_calificacion
integer li_calificacion 

STRING ls_busca_area, ls_busca_plan 
INTEGER le_pos_area, le_pos_plan
INTEGER le_area_mat
LONG ll_cve_plan, ll_cve_carrera 
STRING ls_tipo_area
INTEGER le_fundamental1

st_2.text='Terminada la Carga'

dw_1.setsort("banderas_cuenta")
dw_3.setsort("historico_cuenta")
dw_1.sort()
dw_3.sort()

lo_cont_2=1
/*Se hace para TODAS las materias de Integración que se cursaron en el periodo*/
FOR lo_cont_1=1 TO rowcount

	// Se recupera el numero de cuenta
	lo_cuenta = dw_3.GETITEMNUMBER(lo_cont_1, "historico_cuenta") 
	
	// Se recupera la clave de la materia 
	ll_cve_mat = dw_3.GETITEMNUMBER(lo_cont_1, "materias_cve_mat") 

	// Se recupera el Id de el plan de estudios 
	ll_cve_plan = dw_3.GETITEMNUMBER(lo_cont_1, "academicos_cve_plan") 
	ll_cve_carrera = dw_3.GETITEMNUMBER(lo_cont_1, "academicos_cve_carrera") 

	// Se recupera la calificación 
	ls_calificacion = dw_3.object.historico_calificacion[lo_cont_1]
	IF ls_calificacion ="BA" OR ls_calificacion ="NA" OR ls_calificacion ="IN" OR isnull(ls_calificacion) THEN
		li_calificacion = 0
	ELSE
		li_calificacion = integer(ls_calificacion)
	END IF
	// Si no se aprobó la materia, se continúa al siguiente registro.
	IF li_calificacion <= 5 THEN CONTINUE

	// Despliega el número de cuenta (Para ver si ya me trabe)
	st_2.text=string(lo_cuenta) 
	
	// Se busca el número de cuenta en las banderas a actualizar 
//	DO UNTIL lo_cuenta = dw_1.GETITEMNUMBER(lo_cont_2, "banderas_cuenta")
//		// Se incrementa el apuntador 
//		lo_cont_2 = lo_cont_2 + 1 
//		IF lo_cont_2 > dw_1.ROWCOUNT() THEN 
//			lo_cont_2 = 0
//			EXIT
//		END IF
//	LOOP

	lo_cont_2 = dw_1.FIND("banderas_cuenta = " + STRING(lo_cuenta), 0, dw_1.ROWCOUNT() + 1) 
	// Si no encuentra el número de cuenta busca el siguiente. 
	IF lo_cont_2 = 0 THEN CONTINUE 

	le_pos_area = 0
	// Se hace ciclo para recuperar el área de la materia. 
	DO  	 	
		
		le_pos_area ++ 
		
		// Se define cadena de búsqueda del área 
		ls_busca_area = "cve_mat = " + STRING(ll_cve_mat) 
		le_pos_area = ids_area_mat.FIND(ls_busca_area, le_pos_area, ids_area_mat.ROWCOUNT() + 1) 
		
		le_area_mat = 0
		IF le_pos_area > 0 THEN 
			le_area_mat = ids_area_mat.GETITEMNUMBER(le_pos_area, "cve_area")  
			IF ISNULL(le_area_mat) OR le_area_mat = 0 THEN CONTINUE 
		ELSE
			CONTINUE 
		END IF
		
		// Se busca si el area corresponde a ue area de Tema o de integración o Fundamental 
		ls_busca_plan = "cve_carrera = " + STRING(ll_cve_carrera) + " AND cve_plan = " + STRING(ll_cve_plan)  + " AND area_tema = " + STRING(le_area_mat) 
		
		ls_tipo_area = ""
		le_pos_plan = ids_areas_plan.FIND(ls_busca_plan, 0, ids_areas_plan.ROWCOUNT() + 1) 
		// Si encuentra el area de la materia, 
		IF le_pos_plan > 0 THEN 
			ls_tipo_area = ids_areas_plan.GETITEMSTRING(le_pos_plan, "tipo_tema") 
			IF ISNULL(ls_tipo_area) OR TRIM(ls_tipo_area) = "" THEN CONTINUE 
		ELSE
			CONTINUE 
		END IF
		
		// Se revisa 
		CHOOSE CASE ls_tipo_area 
				
			CASE 'tema1' 
				dw_1.SETITEM(lo_cont_2, "banderas_tema_1", 1)				
			CASE 'tema2' 
				dw_1.SETITEM(lo_cont_2, "banderas_tema_2", 1)
			CASE 	'tema3' 
				dw_1.SETITEM(lo_cont_2, "banderas_tema_3", 1)
			CASE 'tema4' 
				dw_1.SETITEM(lo_cont_2, "banderas_tema_4", 1)
			CASE 'fundamental' 
				// Se verifica si ya tiene marcado como cursado algún fundamental 
				le_fundamental1 = dw_1.GETITEMNUMBER(lo_cont_2, "banderas_tema_fundamental_1") 
				//  Se verifica si ya tiene cursado un tema fundamental, si no, se marca.
				IF le_fundamental1 = 0 THEN 
					dw_1.SETITEM(lo_cont_2, "banderas_tema_fundamental_1", 1)
				// Si no 	
				ELSE
					dw_1.SETITEM(lo_cont_2, "banderas_tema_fundamental_2", 1)
				END IF
				
		END CHOOSE 
		
	LOOP WHILE le_pos_area > 0 
	
NEXT

st_2.text='Terminado el Cálculo' /*Avisa que ya terminaste*/

if dw_1.modifiedcount() > 0 then
	dw_1.AcceptText()
	messagebox("A punto de hacer COMMIT; y update()","Deje de hacer lo que este haciendo")
	if dw_1.update(true) = 1 then		
		commit using gtr_sce;
	else
		rollback using gtr_sce;
	end if
end if






// CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL 
// CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL 
// CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL 

//long lo_cont_1,lo_cont_2,lo_cuenta, ll_cve_plan, ll_cve_coordinacion
//string ls_tema , ls_calificacion
//integer li_calificacion
//
//st_2.text='Terminada la Carga'
//
//dw_1.setsort("banderas_cuenta")
//dw_3.setsort("historico_cuenta")
//dw_1.sort()
//dw_3.sort()
//
//lo_cont_2=1
///*Se hace para TODAS las materias de Integración que se cursaron en el periodo*/
//FOR lo_cont_1=1 TO rowcount
//	lo_cuenta=dw_3.object.historico_cuenta[lo_cont_1]
//	st_2.text=string(lo_cuenta) /*Despliega el número de cuenta (Para ver si ya me trabe)*/
//	DO UNTIL lo_cuenta=dw_1.object.banderas_cuenta[lo_cont_2]
//		lo_cont_2=lo_cont_2+1 /*Buscalos en las banderas*/
//	LOOP
//	
//	ls_tema = dw_3.object.tema[lo_cont_1]
//	ll_cve_coordinacion = dw_3.object.materias_cve_coordinacion[lo_cont_1]
//	ll_cve_plan = dw_3.object.academicos_cve_plan[lo_cont_1]
//	ls_calificacion = dw_3.object.historico_calificacion[lo_cont_1]
//	IF ls_calificacion ="BA" OR ls_calificacion ="NA" OR ls_calificacion ="IN" OR isnull(ls_calificacion) THEN
//		li_calificacion = 0
//	ELSE
//		li_calificacion = integer(ls_calificacion)
//	END IF
//	
//	if ll_cve_plan <> 6 then
//	
//		CHOOSE CASE dw_3.object.tema[lo_cont_1]
//			CASE 'INTRODUCCION AL PROBLEMA DEL HOMBRE'
//				dw_1.object.banderas_tema_fundamental_1[lo_cont_2]=1
//			CASE 'INTRODUCCION AL PROBLEMA SOCIAL'
//				dw_1.object.banderas_tema_fundamental_2[lo_cont_2]=1
//			CASE 'Tema 1'
//				dw_1.object.banderas_tema_1[lo_cont_2]=1
//			CASE 'Tema 2'
//				dw_1.object.banderas_tema_2[lo_cont_2]=1
//			CASE 'Tema 3'
//				dw_1.object.banderas_tema_3[lo_cont_2]=1
//			CASE 'Tema 4'
//				dw_1.object.banderas_tema_4[lo_cont_2]=1
//		END CHOOSE	
//	else
//		IF li_calificacion > 5 THEN
//			CHOOSE CASE ll_cve_coordinacion
//				CASE 6070
//					dw_1.object.banderas_tema_1[lo_cont_2]=1
//				CASE 6071
//					dw_1.object.banderas_tema_2[lo_cont_2]=1
//				CASE 6072
//					dw_1.object.banderas_tema_3[lo_cont_2]=1
//				CASE 6073
//					dw_1.object.banderas_tema_4[lo_cont_2]=1
//			END CHOOSE	
//		END IF
//	end if
//NEXT
//
//st_2.text='Terminado el Cálculo' /*Avisa que ya terminaste*/
//
//if dw_1.modifiedcount() > 0 then
//	dw_1.AcceptText()
//	messagebox("A punto de hacer COMMIT; y update()","Deje de hacer lo que este haciendo")
//	if dw_1.update(true) = 1 then		
//		commit using gtr_sce;
//	else
//		rollback using gtr_sce;
//	end if
//end if    




end event

event retrieverow;/*Despliega un mensaje cada vez que se carga un renglón (para mostrar que no te has trabado)*/
st_2.text='Cargando '+string(row)
end event

type dw_2 from datawindow within w_integracion
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
event retrieverow pbm_dwnretrieverow
integer y = 1072
integer width = 581
integer height = 432
integer taborder = 40
string dataobject = "d_cred_72"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
end event

event retrieveend;long lo_cont_1,lo_cont_2,lo_cuenta

st_2.text='Terminada la Carga'

/*Para todos los que ya tienen 72 créditos o más y no se les haya puesto que ya pueden...*/	
//lo_cont_2=1
//FOR lo_cont_1=1 TO rowcount
//	lo_cuenta=dw_2.object.academicos_cuenta[lo_cont_1]
//	st_2.text=string(lo_cuenta) /*Despliega el número de cuenta (Para ver si ya me trabe)*/
//	DO UNTIL lo_cuenta=dw_1.object.banderas_cuenta[lo_cont_2]
//		lo_cont_2=lo_cont_2+1 /*Buscalos en las banderas*/
//	LOOP
//	dw_1.object.banderas_puede_integracion[lo_cont_2]=1 /*Ya pueden*/
//NEXT
//st_2.text='Terminado el Cálculo' /*Avisa que ya terminaste*/
//
/*Carga los datos de las materias de integración que se cursaron en este periodo*/
dw_3.retrieve(gi_periodo,gi_anio, gs_tipo_periodo)
end event

event retrieverow;/*Despliega un mensaje cada vez que se carga un renglón (para mostrar que no te has trabado)*/
st_2.text='Cargando '+string(row)
end event

type st_2 from statictext within w_integracion
integer x = 27
integer y = 980
integer width = 3355
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "Status"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_integracion
integer x = 18
integer y = 428
integer width = 3360
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "Status"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_integracion
event clicked pbm_bnclicked
integer x = 1403
integer y = 268
integer width = 585
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Corte de Integración"
end type

event clicked;/*Carga las banderas de los que cursaron materias en el semestre (Banderas)*/
dw_1.retrieve('L', gs_tipo_periodo) 



end event

type dw_1 from datawindow within w_integracion
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
event retrieverow pbm_dwnretrieverow
integer x = 18
integer y = 524
integer width = 3360
integer height = 452
integer taborder = 10
string dataobject = "d_cortes"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
end event

event retrieveend;st_1.text='Terminada la Carga'
/*Carga los datos de los que cursaron materias en el semestre (Academicos)*/
dw_2.retrieve(gs_tipo_periodo) 


end event

event retrieverow;/*Despliega un mensaje cad vez que se carga un renglón (para mostrar que no te has trabado)*/
st_1.text='Cargando '+string(row)
end event

type uo_1 from uo_per_ani within w_integracion
integer x = 1074
integer y = 60
integer taborder = 11
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

