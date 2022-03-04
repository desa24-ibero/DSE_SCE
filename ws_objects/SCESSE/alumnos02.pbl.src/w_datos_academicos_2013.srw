$PBExportHeader$w_datos_academicos_2013.srw
$PBExportComments$Despliegue de datos academicos de un alumno (Carrera, Semestre, Subsistema, Fecha de Ingreso, Fecha de Egreso,.....)
forward
global type w_datos_academicos_2013 from w_master_main
end type
type r_3 from rectangle within w_datos_academicos_2013
end type
type st_replica from statictext within w_datos_academicos_2013
end type
type dw_reingreso from uo_master_dw within w_datos_academicos_2013
end type
type dw_indulto from uo_master_dw within w_datos_academicos_2013
end type
type dw_academico from uo_master_dw within w_datos_academicos_2013
end type
type dw_carreras_cursadas from uo_carreras_alumno within w_datos_academicos_2013
end type
type uo_nombre from uo_nombre_alumno_2013 within w_datos_academicos_2013
end type
type st_1 from statictext within w_datos_academicos_2013
end type
type cb_nueva_carrera from commandbutton within w_datos_academicos_2013
end type
type cb_activar_carrera from commandbutton within w_datos_academicos_2013
end type
type r_1 from rectangle within w_datos_academicos_2013
end type
type r_2 from rectangle within w_datos_academicos_2013
end type
end forward

global type w_datos_academicos_2013 from w_master_main
integer width = 4439
integer height = 2812
string title = "Datos Academicos del Alumno"
string menuname = "m_datos_academicos_2013"
boolean minbox = false
boolean clientedge = true
event double ( )
r_3 r_3
st_replica st_replica
dw_reingreso dw_reingreso
dw_indulto dw_indulto
dw_academico dw_academico
dw_carreras_cursadas dw_carreras_cursadas
uo_nombre uo_nombre
st_1 st_1
cb_nueva_carrera cb_nueva_carrera
cb_activar_carrera cb_activar_carrera
r_1 r_1
r_2 r_2
end type
global w_datos_academicos_2013 w_datos_academicos_2013

type variables
boolean ib_modificando=false
Datawindowchild dwc_subsis,dwc_carrera,dwc_plan, dwc_periodo
integer ii_periodo, ii_anio,ii_sw
long il_cuenta,il_carrera, il_plan
end variables

forward prototypes
public function boolean actualiza_academicos_hist (long an_cuenta, integer an_carrera, integer an_plan)
public function boolean inserta_academicos_hist (long an_cuenta, integer an_carrera, integer an_plan, integer an_carrera_ant, integer an_plan_ant)
public function integer wf_validar ()
public function integer of_actualiza_hist ()
public function integer wf_carga_carrera ()
public function integer wf_inicia_detalle_carrera ()
end prototypes

public function boolean actualiza_academicos_hist (long an_cuenta, integer an_carrera, integer an_plan);int li_cve_subsist_act,li_sem_cursados_act,li_creditos_cursados_act,li_egresado_act,li_periodo_ing_act
int li_anio_ing_act, li_periodo_egre_act,li_anio_egre_act,li_cve_formaingreso_act,li_ceremonia_mes_act,li_ceremonia_anio_act
int li_reg
datetime ldt_fec_servidor
string ls_nivel_act,ls_mensaje_sql
dec ldc_promedio_act
LONG ll_cve_carrera
INTEGER le_cve_plan


li_cve_subsist_act = dw_academico.Getitemnumber(dw_academico.Getrow(),'cve_subsistema')
ls_nivel_act = dw_academico.Getitemstring(dw_academico.Getrow(),'nivel')
ldc_promedio_act = dw_academico.Getitemdecimal(dw_academico.Getrow(),'promedio')
li_sem_cursados_act = dw_academico.Getitemnumber(dw_academico.Getrow(),'sem_cursados')
li_creditos_cursados_act = dw_academico.Getitemnumber(dw_academico.Getrow(),'creditos_cursados')
li_egresado_act = dw_academico.Getitemnumber(dw_academico.Getrow(),'egresado')
li_periodo_ing_act = dw_academico.Getitemnumber(dw_academico.Getrow(),'periodo_ing')
li_anio_ing_act = dw_academico.Getitemnumber(dw_academico.Getrow(),'anio_ing')
li_periodo_egre_act = dw_academico.Getitemnumber(dw_academico.Getrow(),'periodo_egre')
li_anio_egre_act = dw_academico.Getitemnumber(dw_academico.Getrow(),'anio_egre')
li_cve_formaingreso_act = dw_academico.Getitemnumber(dw_academico.Getrow(),'cve_formaingreso')
li_ceremonia_mes_act = dw_academico.Getitemnumber(dw_academico.Getrow(),'ceremonia_mes')
li_ceremonia_anio_act = dw_academico.Getitemnumber(dw_academico.Getrow(),'ceremonia_anio')

ll_cve_carrera = dw_academico.Getitemnumber(dw_academico.Getrow(),'cve_carrera')
le_cve_plan = dw_academico.Getitemnumber(dw_academico.Getrow(),'cve_plan')

//select count(*)
//		into :li_reg
//	from academicos_hist
//	where cuenta = :an_cuenta and
//			cve_carrera = :an_carrera and
//			cve_plan = :an_plan
//	using gtr_sce;
//if li_reg = 0 then //si no lo encuentra lo inserta en academicos_act
//	insert  academicos_hist (cuenta,   
//	         						cve_carrera,   
//    									cve_plan,   
//    									cve_subsistema,   
//    									nivel,   
//    									promedio,   
//    									sem_cursados,   
//    									creditos_cursados,   
//    									egresado,   
//    									periodo_ing,   
//    									anio_ing,   
//    									periodo_egre,   
//    									anio_egre,   
//    									cve_formaingreso,   
//    									ceremonia_mes,   
//    									ceremonia_anio  )
//		select * 
//			from academicos
//			where cuenta = :an_cuenta and
//					cve_carrera = :ll_cve_carrera and
//					cve_plan = :le_cve_plan 
//			using gtr_sce;
//				
//		li_reg = gtr_sce.sqlcode
//		ls_mensaje_sql = gtr_sce.sqlerrtext
//		
//		if li_reg = 0 Then		
//			commit using gtr_sce;
//	   Elseif li_reg= -1 then
//			rollback using gtr_sce;
//			MessageBox("Error al actualizar la tabla de academicos_act",ls_mensaje_sql)
//		end if
//end if
		
//ldt_fec_servidor = datetime(f_obten_fecha_servidor() )
//update academicos_hist
//	set vigente = 0
//	where cuenta = :an_cuenta
//using gtr_sce;
//
//update academicos_hist
//	set vigente = 1,
//		fec_modif = :ldt_fec_servidor,
//		usuario_modif = :gs_usuario
//	where cuenta = :an_cuenta and
//			cve_carrera = :ll_cve_carrera and
//			cve_plan = :le_cve_plan
//using gtr_sce;

COMMIT USING gtr_sce; 

TRIGGEREVENT(DOUBLECLICKED!)

//// Se actualizan los créditos 
//DECIMAL ld_promedio, ld_creditos 
//cred_prom_str_round_academicos2(il_cuenta, 1, ld_creditos, ld_promedio)   
//dw_academico.SETITEM(1, "promedio", ld_promedio)
//dw_academico.SETITEM(1, "creditos_cursados", ld_creditos)
//
//if li_reg > 0 then
//	
//	Update academicos 
//		set 	promedio = :ld_promedio,   
//				creditos_cursados = :ld_creditos 
//		where academicos.cuenta = :an_cuenta and
//				academicos.cve_carrera = :an_carrera and
//				academicos.cve_plan = :an_plan
//		using gtr_sce;
//		
//end if

commit using gtr_sce; 

if li_reg < 0 Then		
	return false
else
	return true
end if






//	Update academicos 
//		set cve_carrera = :an_carrera ,
//			cve_plan = :an_plan,		
//			nivel = :ls_nivel_act,   
//			cve_subsistema = :li_cve_subsist_act,
//				promedio = :ldc_promedio_act,   
//				sem_cursados = :li_sem_cursados_act,   
//				creditos_cursados = :li_creditos_cursados_act,   
//				egresado = :li_egresado_act,   
//				periodo_ing = :li_periodo_ing_act,   
//				anio_ing= :li_anio_ing_act,   
//				periodo_egre = :li_periodo_egre_act,   
//				anio_egre = :li_anio_egre_act,   
//				cve_formaingreso = :li_cve_formaingreso_act,   
//				ceremonia_mes = :li_ceremonia_mes_act,   
//				ceremonia_anio = :li_ceremonia_anio_act
//	From academicos
//		where academicos.cuenta = :an_cuenta and
//				academicos.cve_carrera = :an_carrera and
//				academicos.cve_plan = :an_plan
//		using gtr_sce;
end function

public function boolean inserta_academicos_hist (long an_cuenta, integer an_carrera, integer an_plan, integer an_carrera_ant, integer an_plan_ant);int li_cve_subsist_hist,li_sem_cursados_hist,li_creditos_cursados_hist,li_egresado_hist,li_periodo_ing_hist
int li_anio_ing_hist, li_periodo_egre_hist,li_anio_egre_hist,li_cve_formaingreso_hist,li_ceremonia_mes_hist,li_ceremonia_anio_hist
int li_reg
datetime ldt_fec_servidor
string ls_nivel_hist,ls_mensaje_sql
dec ldc_promedio_hist

LONG ll_cve_carrera 
INTEGER le_cve_plan 
INTEGER le_row  

le_row = dw_carreras_cursadas.Getrow()

li_cve_subsist_hist = dw_carreras_cursadas.Getitemnumber(le_row,'cve_subsistema')
ls_nivel_hist = dw_carreras_cursadas.Getitemstring(le_row,'nivel')
ldc_promedio_hist = dw_carreras_cursadas.Getitemdecimal(le_row,'promedio')
li_sem_cursados_hist = dw_carreras_cursadas.Getitemnumber(le_row,'sem_cursados')
li_creditos_cursados_hist = dw_carreras_cursadas.Getitemnumber(le_row,'creditos_cursados')
li_egresado_hist = dw_carreras_cursadas.Getitemnumber(le_row,'egresado')
li_periodo_ing_hist = dw_carreras_cursadas.Getitemnumber(le_row,'periodo_ing')
li_anio_ing_hist = dw_carreras_cursadas.Getitemnumber(le_row,'anio_ing')
li_periodo_egre_hist = dw_carreras_cursadas.Getitemnumber(le_row,'periodo_egre')
li_anio_egre_hist = dw_carreras_cursadas.Getitemnumber(le_row,'anio_egre')
li_cve_formaingreso_hist = dw_carreras_cursadas.Getitemnumber(le_row,'cve_formaingreso')
li_ceremonia_mes_hist = dw_carreras_cursadas.Getitemnumber(le_row,'ceremonia_mes')
li_ceremonia_anio_hist = dw_carreras_cursadas.Getitemnumber(le_row,'ceremonia_anio')

ll_cve_carrera = dw_carreras_cursadas.Getitemnumber(le_row,'cve_carrera')
le_cve_plan = dw_carreras_cursadas.Getitemnumber(le_row,'cve_plan') 

SELECT nivel 
INTO :ls_nivel_hist 
FROM carreras 
WHERE cve_carrera = :ll_cve_carrera 
USING gtr_sce; 

//if li_reg > 0 then
	
Update academicos 
	set cve_carrera = :ll_cve_carrera ,
		cve_plan = :le_cve_plan,
		cve_subsistema = :li_cve_subsist_hist,
			nivel = :ls_nivel_hist,   
			promedio = :ldc_promedio_hist,   
			sem_cursados = :li_sem_cursados_hist,   
			creditos_cursados = :li_creditos_cursados_hist,   
			egresado = :li_egresado_hist,   
			periodo_ing = :li_periodo_ing_hist,   
			anio_ing= :li_anio_ing_hist,   
			periodo_egre = :li_periodo_egre_hist,   
			anio_egre = :li_anio_egre_hist,   
			cve_formaingreso = :li_cve_formaingreso_hist,   
			ceremonia_mes = :li_ceremonia_mes_hist,   
			ceremonia_anio = :li_ceremonia_anio_hist
	where academicos.cuenta = :an_cuenta 
	using gtr_sce;
	
	COMMIT USING gtr_sce; 

//end if

//ldt_fec_servidor = datetime(f_obten_fecha_servidor() )
//update academicos_hist
//	set vigente = 0
//	where cuenta = :an_cuenta
//using gtr_sce;
//
//update academicos_hist
//	set vigente = 1,
//		fec_modif = :ldt_fec_servidor,
//		usuario_modif = :gs_usuario
//	where cuenta = :an_cuenta and
//			cve_carrera = :ll_cve_carrera  and
//			cve_plan = :le_cve_plan
//using gtr_sce;

COMMIT USING gtr_sce;

if li_reg < 0 Then		
	return false
else
	return true
end if

TRIGGEREVENT(DOUBLECLICKED!)




//// Se verifica si la carrera que se va a sustituir ya existe en el histórico de académicos
//select count(*)
//		into :li_reg
//	from academicos_hist
//	where cuenta = :an_cuenta and
//			cve_carrera = :an_carrera and
//			cve_plan = :an_plan
//	using gtr_sce;
//	
////Si no lo encuentra lo inserta en academicos_hist	
//if li_reg = 0 then 
//	insert  academicos_hist (cuenta,   
//	         						cve_carrera,   
//    									cve_plan,   
//    									cve_subsistema,   
//    									nivel,   
//    									promedio,   
//    									sem_cursados,   
//    									creditos_cursados,   
//    									egresado,   
//    									periodo_ing,   
//    									anio_ing,   
//    									periodo_egre,   
//    									anio_egre,   
//    									cve_formaingreso,   
//    									ceremonia_mes,   
//    									ceremonia_anio  )
//		select cuenta,   
//	         						cve_carrera,   
//    									cve_plan,   
//    									cve_subsistema,   
//    									nivel,   
//    									promedio,   
//    									sem_cursados,   
//    									creditos_cursados,   
//    									egresado,   
//    									periodo_ing,   
//    									anio_ing,   
//    									periodo_egre,   
//    									anio_egre,   
//    									cve_formaingreso,   
//    									ceremonia_mes,   
//    									ceremonia_anio 
//			from academicos
//			where cuenta = :an_cuenta and
//					cve_carrera = :an_carrera and
//					cve_plan = :an_plan 
//			using gtr_sce;
//				
//		li_reg = gtr_sce.sqlcode
//		ls_mensaje_sql = gtr_sce.sqlerrtext
//		
//		if li_reg = 0 Then		
//			commit using gtr_sce;
//	   Elseif li_reg= -1 then
//			rollback using gtr_sce;
//			MessageBox("Error al actualizar la tabla de academicos_hist",ls_mensaje_sql)
//		end if
//end if
end function

public function integer wf_validar ();if dw_academico.Rowcount() = 0 and ib_modificando = true then return 1

if dw_academico.Getitemnumber(1,'periodo_ing') = 1 then
	IF messagebox('Aviso','El periodo seleccionado es "VERANO", ¿desea continuar?',Question!,Yesno!) = 2 then
		return -1
	end if
end if

if ii_sw = 1 then
	IF messagebox('Aviso','Los cambios limpiaran la informacion creditos, promedio y semestres cursados, ¿Esta seguro de continuar?',Question!,Yesno!) = 2 then
		return -1
	else
		dw_academico.Setitem(1,'promedio',0)
		dw_academico.Setitem(1,'sem_cursados',0)
		dw_academico.Setitem(1,'creditos_cursados',0)
		dw_academico.Setitem(1,'egresado',0)
		dw_academico.Setitem(1,'periodo_ing',ii_periodo)
		dw_academico.Setitem(1,'anio_ing',ii_anio)
		dw_academico.Setitem(1,'periodo_egre',0)
		dw_academico.Setitem(1,'anio_egre',0)
		dw_academico.Setitem(1,'ceremonia_mes',0)
		dw_academico.Setitem(1,'ceremonia_anio',0)
		dw_academico.Accepttext()
	end if
end if

STRING ls_nivel , ls_descripcion_ingreso
INTEGER le_forma_ingreso
ls_nivel = dw_academico.Getitemstring(1,'nivel') 
le_forma_ingreso = dw_academico.Getitemnumber(1,'cve_formaingreso') 

ls_descripcion_ingreso = f_ingreso_descripcion(le_forma_ingreso) 

//if dw_academico.Getitemnumber(1,'cve_formaingreso') = 0 and dwc_carrera.Getitemstring(dwc_carrera.Getrow(),'nivel') <> 'L' then
if le_forma_ingreso = 0 and ls_nivel  = 'P' then 
	Messagebox("Aviso","Forma de ingreso: '" + ls_descripcion_ingreso + "', no aplica para posgrado.")  
	return -1
end if
																				  
//if dw_academico.Getitemnumber(1,'cve_formaingreso') = 8 and dwc_carrera.Getitemstring(dwc_carrera.Getrow(),'nivel') <> 'P' then
if le_forma_ingreso = 8 and ls_nivel <> 'P' then
	Messagebox("Aviso","Forma de ingreso: '" + ls_descripcion_ingreso + "', solo para nivel posgrado.")
	return -1
end if

return 1


end function

public function integer of_actualiza_hist ();
if dw_academico.Rowcount() > 0 then
	il_cuenta = long(uo_nombre.of_obten_cuenta())
	if actualiza_academicos_hist (il_cuenta,il_carrera,il_plan) then
		dw_carreras_cursadas.Retrieve(il_cuenta)
	end if
end if 

RETURN 0 
end function

public function integer wf_carga_carrera ();long ll_ren
int sub_sist


il_cuenta = long(uo_nombre.of_obten_cuenta())
sub_sist = 0

dw_academico.settransobject(gtr_sce)
	
if f_alumno_restringido (il_cuenta) then
	if f_usuario_especial(gs_usuario) then
		MessageBox("Usuario  Autorizado",  "Alumno con acceso restringido",Information!)		
	else
		MessageBox("Usuario NO Autorizado", "Alumno con acceso restringido, por favor consulte a la ~n"+ &
													   + "Dirección de Servicios Escolares",StopSign!)
		uo_nombre.dw_nombre_alumno.Reset()	
		uo_nombre.dw_nombre_alumno.insertrow(0)
		uo_nombre.em_digito.text=" "
		uo_nombre.em_cuenta.text = " "
		uo_nombre.em_cuenta.setfocus()
		return	 -1
	end if
end if

//Modif. Roberto Novoa May/2016 .- Funcionalidad periodos multiples
f_dddw_converter(dw_academico, dwc_periodo, "periodo_ing")
f_dddw_converter(dw_academico, dwc_periodo, "periodo_egre")


//BEVM 19/06/2013 Se adiciono los dw child para que recupere los datos de carrera, plan y subsistema cuando cambien
dw_academico.getchild('cve_carrera',dwc_carrera)
dwc_carrera.settransobject(gtr_sce)
dw_academico.getchild('cve_plan',dwc_plan)
dwc_plan.settransobject(gtr_sce)
dw_academico.getchild('cve_subsistema',dwc_subsis)
dwc_subsis.settransobject(gtr_sce)


dw_reingreso.visible = true
dw_indulto.visible = true
r_1.visible = true
r_2.visible = true

//cuentalocal = uo_nombre.of_obten_cuenta()
//long(uo_nombre.em_cuenta.text)

int cuantos

//BEVM 19/06/2013 Se hizo el cambio para que recuperara solo los planes de una carrera en especifico
dwc_carrera.retrieve()

// Se recuperan el plan y el subsistema 
setnull(cuantos)
SELECT  s.cve_subsistema, a.cve_carrera, a.cve_plan 
INTO :cuantos, :il_carrera, :il_plan
FROM dbo.academicos a  LEFT JOIN dbo.subsistema s ON a.cve_carrera = s.cve_carrera AND a.cve_plan = s.cve_plan
WHERE a.cuenta = :il_cuenta using gtr_sce;

if isnull(cuantos) then 
	dwc_subsis.retrieve(0,0)
end if
if isnull(il_carrera)  then
	dwc_plan.Retrieve(0)
	dwc_subsis.retrieve(0,0)
else 
	dwc_plan.Retrieve(il_carrera)
	dwc_subsis.retrieve(il_carrera,il_plan)
end if
	
if dwc_plan.rowcount() = 0 then
	dwc_plan.Insertrow(0)
	dwc_plan.Setitem(1,'cve_plan', 0)
	dwc_plan.Setitem(1,'nombre_plan', 'SIN PLAN')
end if
if dwc_subsis.rowcount() = 0 then
	dwc_subsis.Insertrow(0)
	dwc_subsis.Setitem(1,'cve_subsistema', 0)
	dwc_subsis.Setitem(1,'subsistema', 'SIN SUBSISTEMA')
end if

if dw_reingreso.retrieve(il_cuenta) = 0 then
	r_1.visible = false
	dw_reingreso.visible = false
end if

if dw_indulto.retrieve(il_cuenta) = 0  then
	r_2.visible = false
	dw_indulto.visible = false
end if

// Se recupera la carrera activa. 
if dw_academico.retrieve(uo_nombre.of_obten_cuenta()) = 0 then
	ll_Ren = dw_academico.insertrow(0)
	dw_academico.Setitem(ll_ren,'cuenta',il_cuenta)
end if

//BEVM 19/06/2013 Se agrego el user object para la consulta de las carreras del alumno
dw_carreras_cursadas.Retrieve(il_cuenta)

RETURN 0 
end function

public function integer wf_inicia_detalle_carrera ();long cuentalocal,ll_ren
int sub_sist
//char nivel


LONG ll_cve_carrera

ll_cve_carrera = dw_academico.GETITEMNUMBER(1, 'cve_carrera') 


//Modif. Roberto Novoa May/2016 .- Funcionalidad periodos multiples
f_dddw_converter(dw_academico, dwc_periodo, "periodo_ing")
f_dddw_converter(dw_academico, dwc_periodo, "periodo_egre")


//BEVM 19/06/2013 Se adiciono los dw child para que recupere los datos de carrera, plan y subsistema cuando cambien
//dw_academico.getchild('cve_carrera',dwc_carrera)
//dwc_carrera.settransobject(gtr_sce)
dw_academico.getchild('cve_plan',dwc_plan)
dwc_plan.settransobject(gtr_sce)
dw_academico.getchild('cve_subsistema',dwc_subsis)
dwc_subsis.settransobject(gtr_sce)


dw_reingreso.visible = true
dw_indulto.visible = true
r_1.visible = true
r_2.visible = true

cuentalocal = uo_nombre.of_obten_cuenta()
//long(uo_nombre.em_cuenta.text)

int cuantos

//BEVM 19/06/2013 Se hizo el cambio para que recuperara solo los planes de una carrera en especifico
//dwc_carrera.retrieve()

//if isvalid(dw_academico) then
//	setnull(cuantos)
//	SELECT  s.cve_subsistema, a.cve_carrera, a.cve_plan 
//	INTO :cuantos, :il_carrera, :il_plan
//	FROM dbo.academicos a  LEFT JOIN dbo.subsistema s ON a.cve_carrera = s.cve_carrera AND a.cve_plan = s.cve_plan
//	WHERE a.cuenta = :cuentalocal using gtr_sce;
	
//	if isnull(cuantos) then 
//		dwc_subsis.retrieve(0,0)
//	end if
//	if isnull(il_carrera)  then
		dwc_plan.Retrieve(0)
		dwc_subsis.retrieve(0,0)
//	else 
//		dwc_plan.Retrieve(il_carrera)
//		dwc_subsis.retrieve(il_carrera,il_plan)
//	end if
////end if

//if dwc_plan.rowcount() = 0 then
//	dwc_plan.Insertrow(0)
//	dwc_plan.Setitem(1,'cve_plan', 0)
//	dwc_plan.Setitem(1,'nombre_plan', 'SIN PLAN')
//end if
//if dwc_subsis.rowcount() = 0 then
//	dwc_subsis.Insertrow(0)
//	dwc_subsis.Setitem(1,'cve_subsistema', 0)
//	dwc_subsis.Setitem(1,'subsistema', 'SIN SUBSISTEMA')
//end if

if dw_reingreso.retrieve(il_cuenta) = 0 then
	r_1.visible = false
	dw_reingreso.visible = false
end if

if dw_indulto.retrieve(il_cuenta) = 0  then
	r_2.visible = false
	dw_indulto.visible = false
end if

//// Se recupera la carrera activa. 
//if dw_academico.retrieve(uo_nombre.of_obten_cuenta()) = 0 then
//	ll_Ren = dw_academico.insertrow(0)
//	dw_academico.Setitem(ll_ren,'cuenta',il_cuenta)
//end if
//
////BEVM 19/06/2013 Se agrego el user object para la consulta de las carreras del alumno
//dw_carreras_cursadas.Retrieve(il_cuenta)
//




return 0 

end function

on w_datos_academicos_2013.create
int iCurrent
call super::create
if this.MenuName = "m_datos_academicos_2013" then this.MenuID = create m_datos_academicos_2013
this.r_3=create r_3
this.st_replica=create st_replica
this.dw_reingreso=create dw_reingreso
this.dw_indulto=create dw_indulto
this.dw_academico=create dw_academico
this.dw_carreras_cursadas=create dw_carreras_cursadas
this.uo_nombre=create uo_nombre
this.st_1=create st_1
this.cb_nueva_carrera=create cb_nueva_carrera
this.cb_activar_carrera=create cb_activar_carrera
this.r_1=create r_1
this.r_2=create r_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.r_3
this.Control[iCurrent+2]=this.st_replica
this.Control[iCurrent+3]=this.dw_reingreso
this.Control[iCurrent+4]=this.dw_indulto
this.Control[iCurrent+5]=this.dw_academico
this.Control[iCurrent+6]=this.dw_carreras_cursadas
this.Control[iCurrent+7]=this.uo_nombre
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.cb_nueva_carrera
this.Control[iCurrent+10]=this.cb_activar_carrera
this.Control[iCurrent+11]=this.r_1
this.Control[iCurrent+12]=this.r_2
end on

on w_datos_academicos_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.r_3)
destroy(this.st_replica)
destroy(this.dw_reingreso)
destroy(this.dw_indulto)
destroy(this.dw_academico)
destroy(this.dw_carreras_cursadas)
destroy(this.uo_nombre)
destroy(this.st_1)
destroy(this.cb_nueva_carrera)
destroy(this.cb_activar_carrera)
destroy(this.r_1)
destroy(this.r_2)
end on

event doubleclicked;call super::doubleclicked;long cuentalocal,ll_ren
int sub_sist
//char nivel


//ll_row = uo_nombre.dw_nombre_alumno.GetRow()
//ll_cuenta = uo_nombre.dw_nombre_alumno.GetItemNumber(ll_row, "cuenta")
il_cuenta = long(uo_nombre.of_obten_cuenta())
sub_sist = 0

dw_academico.settransobject(gtr_sce)
	
if f_alumno_restringido (il_cuenta) then
	if f_usuario_especial(gs_usuario) then
		MessageBox("Usuario  Autorizado",  "Alumno con acceso restringido",Information!)		
	else
		MessageBox("Usuario NO Autorizado", "Alumno con acceso restringido, por favor consulte a la ~n"+ &
													   + "Dirección de Servicios Escolares",StopSign!)
		uo_nombre.dw_nombre_alumno.Reset()	
		uo_nombre.dw_nombre_alumno.insertrow(0)
		uo_nombre.em_digito.text=" "
		uo_nombre.em_cuenta.text = " "
		uo_nombre.em_cuenta.setfocus()
		return		
	end if
end if

//Modif. Roberto Novoa May/2016 .- Funcionalidad periodos multiples
f_dddw_converter(dw_academico, dwc_periodo, "periodo_ing")
f_dddw_converter(dw_academico, dwc_periodo, "periodo_egre")



//BEVM 19/06/2013 Se adiciono los dw child para que recupere los datos de carrera, plan y subsistema cuando cambien
dw_academico.getchild('cve_carrera',dwc_carrera)
dwc_carrera.settransobject(gtr_sce)
dw_academico.getchild('cve_plan',dwc_plan)
dwc_plan.settransobject(gtr_sce)
dw_academico.getchild('cve_subsistema',dwc_subsis)
dwc_subsis.settransobject(gtr_sce)


dw_reingreso.visible = true
dw_indulto.visible = true
r_1.visible = true
r_2.visible = true

cuentalocal = uo_nombre.of_obten_cuenta()
//long(uo_nombre.em_cuenta.text)

int cuantos

//BEVM 19/06/2013 Se hizo el cambio para que recuperara solo los planes de una carrera en especifico
dwc_carrera.retrieve()

if isvalid(dw_academico) then
	setnull(cuantos)
	SELECT  s.cve_subsistema, a.cve_carrera, a.cve_plan 
	INTO :cuantos, :il_carrera, :il_plan
	FROM dbo.academicos a  LEFT JOIN dbo.subsistema s ON a.cve_carrera = s.cve_carrera AND a.cve_plan = s.cve_plan
	WHERE a.cuenta = :cuentalocal using gtr_sce;
	
	if isnull(cuantos) then 
		dwc_subsis.retrieve(0,0)
	end if
	if isnull(il_carrera)  then
		dwc_plan.Retrieve(0)
		dwc_subsis.retrieve(0,0)
	else 
		dwc_plan.Retrieve(il_carrera)
		dwc_subsis.retrieve(il_carrera,il_plan)
	end if
end if

if dwc_plan.rowcount() = 0 then
	dwc_plan.Insertrow(0)
	dwc_plan.Setitem(1,'cve_plan', 0)
	dwc_plan.Setitem(1,'nombre_plan', 'SIN PLAN')
end if
if dwc_subsis.rowcount() = 0 then
	dwc_subsis.Insertrow(0)
	dwc_subsis.Setitem(1,'cve_subsistema', 0)
	dwc_subsis.Setitem(1,'subsistema', 'SIN SUBSISTEMA')
end if

if dw_reingreso.retrieve(il_cuenta) = 0 then
	r_1.visible = false
	dw_reingreso.visible = false
end if

if dw_indulto.retrieve(il_cuenta) = 0  then
	r_2.visible = false
	dw_indulto.visible = false
end if

// Se recupera la carrera activa. 
if dw_academico.retrieve(uo_nombre.of_obten_cuenta()) = 0 then
	ll_Ren = dw_academico.insertrow(0)
	dw_academico.Setitem(ll_ren,'cuenta',il_cuenta)
end if

//BEVM 19/06/2013 Se agrego el user object para la consulta de las carreras del alumno
dw_carreras_cursadas.Retrieve(il_cuenta)


end event

event open;call super::open;m_datos_academicos_2013.m_registro.m_nuevo.enabled = False

dw_academico.INSERTROW(0)
dw_academico.settransobject(gtr_sce)

dw_reingreso.settransobject(gtr_sce)
dw_indulto.settransobject(gtr_sce)
uo_nombre.em_cuenta.text = " "
//triggerevent(doubleclicked!) 
/**/gnv_app.inv_security.of_SetSecurity(this)

//Actualiza el valor de Inscripción de Posgrado 
select periodo,anio
	into :ii_periodo,:ii_anio
from periodos_por_procesos
where cve_proceso = 2 
AND tipo_periodo = :gs_tipo_periodo using gtr_sce;

if gtr_sce.sqlcode <> 0 then
	ii_periodo = gi_periodo
	ii_anio = gi_anio
end if


end event

event ue_actualiza;call super::ue_actualiza;// Original Por: Carlos Melgoza
// Modificado por: Juan Campos 20-Feb-1997

Int  Carrera,Plan,Creditos,li_res,li_replica_activa

dw_academico.ACCEPTTEXT() 

if ib_modificando then
	li_res = wf_validar ()
	if li_res = -1 then
		rollback using gtr_sce;
		messagebox("Información","No se han guardado los cambios")	
		return
	end if

	il_cuenta = long(uo_nombre.of_obten_cuenta())
	
	if dw_academico.Rowcount( ) = 0  and ib_modificando THEN 
		if dw_academico.update(true) = 1 then
			commit using gtr_sce;	
			
			//INICIO:Replica a Internet
			li_replica_activa = f_replica_Activa()
			if li_replica_activa = 1 then
				f_replica_internet(this,il_cuenta)
				st_replica.text = 'A'
				st_replica.BackColor =RGB(0,255,0)
			else
				st_replica.text = 'I'
				st_replica.BackColor =RGB(255,0,0)
			end if
			//FIN:Replica a Internet						
					
			messagebox("Información","Se han guardado los cambios")				
			//If Not act_banderas_sersoc_integ(Cuenta,Carrera,Plan,Creditos) Then  // función anexada.
			//  Messagebox("Información","las banderas ser_social y puede_integracion No se actualizaron")		
			//End if	
			triggerevent(doubleclicked!)
			// Se llama función que actualiza el histórico 
			//of_actualiza_hist()			
		else
			rollback using gtr_sce;
			messagebox("Información","No se han guardado los cambios")	
			return
		end if
	else	
	  SELECT alumnos.cuenta  
		 INTO :il_cuenta  
		 FROM alumnos  
		WHERE alumnos.cuenta = :il_cuenta using gtr_sce;
		
		if gtr_sce.sqlcode = 0 then
			// lineas anexadas
			Carrera =  dw_academico.GetItemNumber(1,"cve_carrera")
			Plan =     dw_academico.GetItemNumber(1,"cve_plan")
			Creditos = dw_academico.GetItemNumber(1,"creditos_cursados")
			//*************** 
			//dw_academico.setitem(dw_academico.getrow(),"cuenta",cuenta)
			dw_academico.accepttext()
			if not f_plan_activo(Carrera, Plan) then
				MessageBox("Plan Inactivo","La carrera: ["+string(Carrera)+"] con el plan: ["+string(Plan)+ "] no estan activos ")	
				messagebox("Información","No se han guardado los cambios")	
				return
			end if
			if dw_academico.update(true) = 1 then
				commit using gtr_sce;	
				
				//INICIO:Replica a Internet
				li_replica_activa = f_replica_Activa()
				if li_replica_activa = 1 then
					f_replica_internet(this,il_cuenta)
					st_replica.text = 'A'
					st_replica.BackColor =RGB(0,255,0)
				else
					st_replica.text = 'I'
					st_replica.BackColor =RGB(255,0,0)
				end if
				//FIN:Replica a Internet						
						
				messagebox("Información","Se han guardado los cambios")				
				//If Not act_banderas_sersoc_integ(Cuenta,Carrera,Plan,Creditos) Then  // función anexada.
				//  Messagebox("Información","las banderas ser_social y puede_integracion No se actualizaron")		
				//End if	
				triggerevent(doubleclicked!)
				// Se llama función que actualiza el histórico 
				//of_actualiza_hist()
			else
				rollback using gtr_sce;
				messagebox("Información","No se han guardado los cambios")	
				return
			end if
		elseif gtr_sce.sqlcode = 100 then 
			messagebox("Información","El alumno con numero de cuenta "+string(il_cuenta)+" no esta dado de alta.~rDebe darse de alta desde la ventana de datos generales",stopsign!)
			rollback using gtr_sce;
		end if	
	end if
else
	rollback using gtr_sce;
	messagebox("Información","No se han guardado los cambios")	
	return
end if
end event

event ue_borra;call super::ue_borra;string cuenta
int respuesta
cuenta = uo_nombre.em_cuenta.text
respuesta = messagebox("Atención","Esta seguro de querer borrar los datos academicos~r del alumno "+cuenta+ ".",StopSign!,YesNo!,2)

if respuesta = 1 then
	il_carrera = dw_academico.Getitemnumber(dw_academico.Getrow(),'cve_carrera')
	il_plan = dw_academico.Getitemnumber(dw_academico.Getrow(),'cve_plan')
	if actualiza_academicos_hist (il_cuenta,il_carrera,il_plan) then
		dw_carreras_cursadas.Retrieve(il_cuenta)
	end if
	dw_academico.deleterow(dw_academico.getrow()) 
	ib_modificando = true
	triggerevent('ue_actualiza')
elseif respuesta = 2 then
	rollback using gtr_sce;
	messagebox("Información","No se han guardado los cambios")	
	triggerevent(doubleclicked!)
	return
end if

end event

event activate;//
end event

event closequery;//
end event

type st_sistema from w_master_main`st_sistema within w_datos_academicos_2013
end type

type p_ibero from w_master_main`p_ibero within w_datos_academicos_2013
end type

type r_3 from rectangle within w_datos_academicos_2013
long linecolor = 128
integer linethickness = 5
long fillcolor = 16777215
integer x = 110
integer y = 672
integer width = 3771
integer height = 412
end type

type st_replica from statictext within w_datos_academicos_2013
integer x = 3342
integer y = 328
integer width = 110
integer height = 88
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

event constructor;integer li_replica_activa

li_replica_activa = f_replica_Activa()

if li_replica_activa = 1 then
	THIS.text = 'A'
	THIS.BackColor =RGB(0,255,0)
else
	THIS.text = 'I'
	THIS.BackColor =RGB(255,0,0)
end if

end event

type dw_reingreso from uo_master_dw within w_datos_academicos_2013
integer x = 114
integer y = 1960
integer width = 1746
integer height = 500
integer taborder = 50
string dataobject = "dw_forma_reingreso_alumno_2013"
boolean hscrollbar = false
boolean vscrollbar = false
end type

event dberror;call super::dberror;messagebox("error",string(sqldbcode) +sqlerrtext + sqlsyntax)
end event

type dw_indulto from uo_master_dw within w_datos_academicos_2013
integer x = 1902
integer y = 1960
integer width = 1413
integer height = 500
integer taborder = 50
string dataobject = "dw_indulto_alumno_2013"
boolean hscrollbar = false
boolean vscrollbar = false
end type

type dw_academico from uo_master_dw within w_datos_academicos_2013
integer x = 87
integer y = 1112
integer width = 3296
integer height = 824
integer taborder = 40
string dataobject = "dw_academicos_alumno_2013"
boolean hscrollbar = false
boolean vscrollbar = false
end type

event itemchanged;
string ls_nivel, ls_columna, ls_cve_carrera
long ll_cve_carrera, ll_row
integer li_cve_plan, li_cve_subsis

ll_row = this.GetRow()

//if ib_modificando then
//	return
//end if

ib_modificando = true 

this.AcceptText()

//ls_columna =dwo.name

ls_columna =this.GetColumnName()

ll_cve_carrera = object.cve_carrera[ll_row]
ls_cve_carrera = string(ll_cve_carrera)
li_cve_plan = object.cve_plan[ll_row]

choose case ls_columna 
case 'cve_carrera' 	
	ls_nivel = f_obten_nivel(ll_cve_carrera)	
	object.nivel[ll_row]=ls_nivel    

	/**/
	
	ll_cve_carrera = long(data)
	
	ls_nivel = f_obten_nivel(ll_cve_carrera)	
	object.nivel[row]=ls_nivel

	if dwc_plan.Retrieve(ll_cve_carrera) > 0 then
		li_cve_plan = dwc_plan.Getitemnumber(1,'cve_plan')
	else
		li_cve_plan = 0
		dwc_plan.Insertrow(0)
		dwc_plan.Setitem(1,'cve_plan', 0)
		dwc_plan.Setitem(1,'nombre_plan', 'SIN PLAN')
	end if
	Setitem(row,'cve_plan',li_cve_plan)
	if dwc_subsis.Retrieve(ll_cve_carrera,li_cve_plan) = 0 then
		dwc_subsis.Insertrow(0)
		dwc_subsis.Setitem(1,'cve_subsistema', 0)
		dwc_subsis.Setitem(1,'subsistema', 'SIN SUBSISTEMA')
		Setitem(row,'cve_subsistema',0)
	else
		li_cve_subsis = dwc_subsis.Getitemnumber(1,'cve_subsistema')
		Setitem(row,'cve_subsistema',li_cve_subsis)
	end if	
	
	// Se limpian los  campos por cambio de carrera 
	THIS.SETITEM(row, "creditos_cursados", 0)
	THIS.SETITEM(row, "promedio", 0)
	THIS.SETITEM(row, "sem_cursados", 0)
	THIS.SETITEM(row, "egresado", 0)
	THIS.SETITEM(row, "ceremonia_mes", 0)
	THIS.SETITEM(row, "ceremonia_anio", 0)
	
	
	/**/
	
case 'cve_plan' 
	if isnull(ll_cve_carrera) or (ll_cve_carrera= 0) then
		ll_cve_carrera= 0
		MessageBox("Captura previa requerida","Favor de Capturar la carrera")
		this.SetColumn("cve_carrera")
		ib_modificando = false
		return 2
	elseif not f_plan_activo(ll_cve_carrera, li_cve_plan) then
		MessageBox("Plan Inactivo","La carrera: ["+ls_cve_carrera+"] con el plan: ["+string(li_cve_plan)+ "] no estan activos ")	
		ib_modificando = false
		return 2		
	end if
end choose

// 30/09/2020 ib_modificando = false


// CODIGO ORIGINAL VER 2013 CODIGO ORIGINAL VER 2013 CODIGO ORIGINAL VER 2013 CODIGO ORIGINAL VER 2013 CODIGO ORIGINAL VER 2013 
// CODIGO ORIGINAL VER 2013 CODIGO ORIGINAL VER 2013 CODIGO ORIGINAL VER 2013 CODIGO ORIGINAL VER 2013 CODIGO ORIGINAL VER 2013 
//string ls_nivel, ls_columna, ls_cve_carrera
//long ll_cve_carrera, ll_row
//integer li_cve_plan,li_cve_subsis
//
//ll_row = this.GetRow()
//
////if ib_modificando then
////	return
////end if
//
//ib_modificando = true
//
//this.AcceptText()
//
//ls_columna =this.GetColumnName()
//
//ll_cve_carrera = object.cve_carrera[ll_row]
//ls_cve_carrera = string(ll_cve_carrera)
//li_cve_plan = object.cve_plan[ll_row]
//li_cve_subsis = 0
//dwc_plan.settransobject(gtr_sce)
//dwc_subsis.settransobject(gtr_sce)
//ii_sw = 0
//
//ib_modificando = true
//
//choose case ls_columna 
//case 'cve_carrera' 	
//	ll_cve_carrera = long(data)
//	
//	ls_nivel = f_obten_nivel(ll_cve_carrera)	
//	object.nivel[row]=ls_nivel
//
//	if dwc_plan.Retrieve(ll_cve_carrera) > 0 then
//		li_cve_plan = dwc_plan.Getitemnumber(1,'cve_plan')
//	else
//		li_cve_plan = 0
//		dwc_plan.Insertrow(0)
//		dwc_plan.Setitem(1,'cve_plan', 0)
//		dwc_plan.Setitem(1,'nombre_plan', 'SIN PLAN')
//	end if
//	Setitem(row,'cve_plan',li_cve_plan)
//	if dwc_subsis.Retrieve(ll_cve_carrera,li_cve_plan) = 0 then
//		dwc_subsis.Insertrow(0)
//		dwc_subsis.Setitem(1,'cve_subsistema', 0)
//		dwc_subsis.Setitem(1,'subsistema', 'SIN SUBSISTEMA')
//		Setitem(row,'cve_subsistema',0)
//	else
//		li_cve_subsis = dwc_subsis.Getitemnumber(1,'cve_subsistema')
//		Setitem(row,'cve_subsistema',li_cve_subsis)
//	end if
//	ii_sw = 1
//case 'cve_plan' 
//	if isnull(ll_cve_carrera) or (ll_cve_carrera= 0) then
//		ll_cve_carrera= 0
//		MessageBox("Captura previa requerida","Favor de Capturar la carrera")
//		this.SetColumn("cve_carrera")
//		ib_modificando = false
//		return 1
//	elseif not f_plan_activo(ll_cve_carrera, li_cve_plan) then
//		MessageBox("Plan Inactivo","La carrera: ["+ls_cve_carrera+"] con el plan: ["+string(li_cve_plan)+ "] no estan activos ")	
//		ib_modificando = false
//		if dwc_subsis.Retrieve(ll_cve_carrera,li_cve_plan) = 0 then
//			dwc_subsis.Insertrow(0)
//			dwc_subsis.Setitem(1,'cve_subsistema', 0)
//			dwc_subsis.Setitem(1,'subsistema', 'SIN SUBSISTEMA')
//			Setitem(row,'cve_subsistema',0)
//		else
//			li_cve_subsis = dwc_subsis.Getitemnumber(1,'cve_subsistema')
//			Setitem(row,'cve_subsistema',li_cve_subsis)
//		end if
//	else
//		IF dwc_plan.retrieve(ll_cve_carrera) = 0 then
//			dwc_plan.Insertrow(0)
//			dwc_plan.Setitem(1,'cve_plan', 0)
//			dwc_plan.Setitem(1,'nombre_plan', 'SIN PLAN')
//			Setitem(row,'cve_plan',0)
//		end if
//		if dwc_subsis.Retrieve(ll_cve_carrera,li_cve_plan) = 0 then
//			dwc_subsis.Insertrow(0)
//			dwc_subsis.Setitem(1,'cve_subsistema', 0)
//			dwc_subsis.Setitem(1,'subsistema', 'SIN SUBSISTEMA')
//			Setitem(row,'cve_subsistema',0)
//		else
//			li_cve_subsis = dwc_subsis.Getitemnumber(1,'cve_subsistema')
//			Setitem(row,'cve_subsistema',li_cve_subsis)
//		end if
//	end if
//	ii_sw = 1
//case 'cve_formaingreso'
//	
//	STRING ls_descripcion_ingreso
//	INTEGER le_forma_ingreso
//	ls_nivel = dw_academico.Getitemstring(row,'nivel') 
//	le_forma_ingreso = integer(data)
//	
//	ls_descripcion_ingreso = f_ingreso_descripcion(le_forma_ingreso) 
//	
//	//if integer(data) = 0 and dwc_carrera.Getitemstring(dwc_carrera.Getrow(),'nivel') <> 'L' then
//	if le_forma_ingreso = 0 and ls_nivel = 'P' then
//		Messagebox("Aviso","Forma de ingreso: '" + ls_descripcion_ingreso + "', no aplica para nivel posgrado.")
//		ib_modificando = false
//	end if
//	//if integer(data) = 8 and dwc_carrera.Getitemstring(dwc_carrera.Getrow(),'nivel') <> 'P' then
//	if le_forma_ingreso = 8 and ls_nivel <> 'P' then 
//		Messagebox("Aviso","Forma de ingreso: '" + ls_descripcion_ingreso + "', solo para nivel posgrado.") 
//		ib_modificando = false
//	end if	
//	ii_sw = 1
//end choose
//idw_trabajo = this
//
end event

event updateend;call super::updateend;//if dw_academico.Rowcount() > 0 then
//	il_cuenta = long(uo_nombre.of_obten_cuenta())
//	if actualiza_academicos_hist (il_cuenta,il_carrera,il_plan) then
//		dw_carreras_cursadas.Retrieve(il_cuenta)
//	end if
//end if
end event

event constructor;call super::constructor;idw_trabajo = this
m_datos_academicos_2013.dw = this
end event

type dw_carreras_cursadas from uo_carreras_alumno within w_datos_academicos_2013
integer x = 160
integer y = 684
integer width = 3634
integer height = 368
integer taborder = 30
end type

event doubleclicked;call super::doubleclicked;//long ll_cuenta
//int li_cve_carrera_hist,li_cve_plan_hist
//int li_cve_carrera,li_cve_plan
//
//li_cve_carrera_hist = this.Getitemnumber(row,'cve_carrera')
//li_cve_plan_hist = this.Getitemnumber(row,'cve_plan')
//
//li_cve_carrera = dw_academico.Getitemnumber(dw_academico.Getrow(),'cve_carrera')
//li_cve_plan = dw_academico.Getitemnumber(dw_academico.Getrow(),'cve_plan')
//
//if li_cve_carrera <> li_cve_carrera_hist then
//	if messagebox('Aviso','¿Esta seguro de querer asignar la carrera: ' + this.Getitemstring(row,'carrera') + ' como vigente?',Question!,Yesno!) = 1 then
//		ll_cuenta = long(uo_nombre.of_obten_cuenta())
//		if inserta_academicos_hist (ll_cuenta,li_cve_carrera,li_cve_plan,li_cve_carrera_hist,li_cve_plan_hist) then
//			ib_modificando = TRUE 
//			parent.triggerevent(doubleclicked!)
//		end if
//	end if
//end if
end event

event rowfocuschanged;call super::rowfocuschanged;THIS.SELECTROW(0, FALSE) 
THIS.SETROW(currentrow)  
THIS.SELECTROW(currentrow, TRUE) 
end event

event clicked;call super::clicked;THIS.SELECTROW(0, FALSE) 
THIS.SETROW(row)  
THIS.SELECTROW(row, TRUE) 
end event

type uo_nombre from uo_nombre_alumno_2013 within w_datos_academicos_2013
integer x = 101
integer y = 324
integer width = 3250
integer height = 320
integer taborder = 20
end type

event constructor;call super::constructor;m_datos_academicos_2013.objeto =this

end event

on uo_nombre.destroy
call uo_nombre_alumno_2013::destroy
end on

type st_1 from statictext within w_datos_academicos_2013
integer x = 2962
integer y = 212
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
string text = "Abril 2021"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_nueva_carrera from commandbutton within w_datos_academicos_2013
integer x = 3451
integer y = 1260
integer width = 443
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Nueva Carrera"
end type

event clicked;
dw_academico.DELETEROW(1) 
dw_academico.INSERTROW(0) 

LONG ll_cuenta
ll_cuenta = uo_nombre.of_obten_cuenta() 
dw_academico.SETITEM(1, "cuenta", ll_cuenta)  
end event

type cb_activar_carrera from commandbutton within w_datos_academicos_2013
integer x = 3451
integer y = 1132
integer width = 443
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Activar Carrera"
end type

event clicked;long ll_cuenta
int li_cve_carrera_hist,li_cve_plan_hist
int li_cve_carrera,li_cve_plan
INTEGER le_row
STRING ls_carrera

le_row = dw_carreras_cursadas.GETROW()  

li_cve_carrera_hist = dw_carreras_cursadas.Getitemnumber(le_row,'cve_carrera')
li_cve_plan_hist = dw_carreras_cursadas.Getitemnumber(le_row,'cve_plan')
ls_carrera = dw_carreras_cursadas.GETITEMSTRING(le_row,'carrera')

li_cve_carrera = dw_academico.Getitemnumber(dw_academico.Getrow(),'cve_carrera')
li_cve_plan = dw_academico.Getitemnumber(dw_academico.Getrow(),'cve_plan')


if li_cve_carrera <> li_cve_carrera_hist OR li_cve_plan_hist <> li_cve_plan   then
	if messagebox('Aviso','¿Esta seguro de querer asignar la carrera: ' + ls_carrera + ' como vigente?',Question!,Yesno!) = 1 then
		ll_cuenta = long(uo_nombre.of_obten_cuenta())
		if inserta_academicos_hist (ll_cuenta,li_cve_carrera,li_cve_plan,li_cve_carrera_hist,li_cve_plan_hist) then
			ib_modificando = TRUE 
			parent.triggerevent(doubleclicked!)
		end if
	end if
end if  

MESSAGEBOX("Aviso", "Se ha actualizado la carrera con éxito.") 
end event

type r_1 from rectangle within w_datos_academicos_2013
long linecolor = 128
integer linethickness = 5
long fillcolor = 16777215
integer x = 110
integer y = 1940
integer width = 1760
integer height = 548
end type

type r_2 from rectangle within w_datos_academicos_2013
long linecolor = 128
integer linethickness = 5
long fillcolor = 16777215
integer x = 1879
integer y = 1940
integer width = 1445
integer height = 548
end type

