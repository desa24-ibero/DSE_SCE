$PBExportHeader$w_analisis_programacion_grupos.srw
forward
global type w_analisis_programacion_grupos from window
end type
type lb_tipo_grupo_clase from listbox within w_analisis_programacion_grupos
end type
type st_tpo_gpo_clase from statictext within w_analisis_programacion_grupos
end type
type ddlb_coordinaciones from dropdownlistbox within w_analisis_programacion_grupos
end type
type st_coordinacion from statictext within w_analisis_programacion_grupos
end type
type ddlb_departamentos from dropdownlistbox within w_analisis_programacion_grupos
end type
type st_departamento from statictext within w_analisis_programacion_grupos
end type
type ddlb_divisiones from dropdownlistbox within w_analisis_programacion_grupos
end type
type st_division from statictext within w_analisis_programacion_grupos
end type
type st_horario_vespertino from statictext within w_analisis_programacion_grupos
end type
type st_horario_matutino from statictext within w_analisis_programacion_grupos
end type
type st_tamanio_bloque_hrs from statictext within w_analisis_programacion_grupos
end type
type st_horario_vesp from statictext within w_analisis_programacion_grupos
end type
type st_horario_mat from statictext within w_analisis_programacion_grupos
end type
type cb_imprimir from commandbutton within w_analisis_programacion_grupos
end type
type cbx_mostrar_porcentajes from checkbox within w_analisis_programacion_grupos
end type
type cb_consultar from commandbutton within w_analisis_programacion_grupos
end type
type cbx_10_o_menos_inscritos from checkbox within w_analisis_programacion_grupos
end type
type ddlb_horario from dropdownlistbox within w_analisis_programacion_grupos
end type
type st_horario from statictext within w_analisis_programacion_grupos
end type
type cb_1 from commandbutton within w_analisis_programacion_grupos
end type
type ddlb_periodo from dropdownlistbox within w_analisis_programacion_grupos
end type
type st_4 from statictext within w_analisis_programacion_grupos
end type
type st_3 from statictext within w_analisis_programacion_grupos
end type
type em_anio from editmask within w_analisis_programacion_grupos
end type
type tab_1 from tab within w_analisis_programacion_grupos
end type
type tabpage_division from userobject within tab_1
end type
type st_division_sin_info from statictext within tabpage_division
end type
type dw_division from datawindow within tabpage_division
end type
type tabpage_division from userobject within tab_1
st_division_sin_info st_division_sin_info
dw_division dw_division
end type
type tabpage_departamento from userobject within tab_1
end type
type st_departamentos_sin_info from statictext within tabpage_departamento
end type
type dw_departamento from datawindow within tabpage_departamento
end type
type tabpage_departamento from userobject within tab_1
st_departamentos_sin_info st_departamentos_sin_info
dw_departamento dw_departamento
end type
type tabpage_coordinacion from userobject within tab_1
end type
type st_coordinacion_sin_info from statictext within tabpage_coordinacion
end type
type dw_coordinacion from datawindow within tabpage_coordinacion
end type
type tabpage_coordinacion from userobject within tab_1
st_coordinacion_sin_info st_coordinacion_sin_info
dw_coordinacion dw_coordinacion
end type
type tabpage_grafica_dias from userobject within tab_1
end type
type dw_grafica_dias from datawindow within tabpage_grafica_dias
end type
type dw_grafica_dia from datawindow within tabpage_grafica_dias
end type
type tabpage_grafica_dias from userobject within tab_1
dw_grafica_dias dw_grafica_dias
dw_grafica_dia dw_grafica_dia
end type
type tabpage_condensado from userobject within tab_1
end type
type st_condensado_sin_info from statictext within tabpage_condensado
end type
type dw_reporte_condensado from datawindow within tabpage_condensado
end type
type tabpage_condensado from userobject within tab_1
st_condensado_sin_info st_condensado_sin_info
dw_reporte_condensado dw_reporte_condensado
end type
type tab_1 from tab within w_analisis_programacion_grupos
tabpage_division tabpage_division
tabpage_departamento tabpage_departamento
tabpage_coordinacion tabpage_coordinacion
tabpage_grafica_dias tabpage_grafica_dias
tabpage_condensado tabpage_condensado
end type
type ddlb_clase_aula from dropdownlistbox within w_analisis_programacion_grupos
end type
type st_clase_aula from statictext within w_analisis_programacion_grupos
end type
type st_dia from statictext within w_analisis_programacion_grupos
end type
type ddlb_dias from dropdownlistbox within w_analisis_programacion_grupos
end type
type gb_3 from groupbox within w_analisis_programacion_grupos
end type
type gb_1 from groupbox within w_analisis_programacion_grupos
end type
type gb_2 from groupbox within w_analisis_programacion_grupos
end type
type gb_4 from groupbox within w_analisis_programacion_grupos
end type
type gb_5 from groupbox within w_analisis_programacion_grupos
end type
end forward

global type w_analisis_programacion_grupos from window
integer width = 4613
integer height = 3416
boolean titlebar = true
string title = "Reporte de Programación de Grupos ..."
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean vscrollbar = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
lb_tipo_grupo_clase lb_tipo_grupo_clase
st_tpo_gpo_clase st_tpo_gpo_clase
ddlb_coordinaciones ddlb_coordinaciones
st_coordinacion st_coordinacion
ddlb_departamentos ddlb_departamentos
st_departamento st_departamento
ddlb_divisiones ddlb_divisiones
st_division st_division
st_horario_vespertino st_horario_vespertino
st_horario_matutino st_horario_matutino
st_tamanio_bloque_hrs st_tamanio_bloque_hrs
st_horario_vesp st_horario_vesp
st_horario_mat st_horario_mat
cb_imprimir cb_imprimir
cbx_mostrar_porcentajes cbx_mostrar_porcentajes
cb_consultar cb_consultar
cbx_10_o_menos_inscritos cbx_10_o_menos_inscritos
ddlb_horario ddlb_horario
st_horario st_horario
cb_1 cb_1
ddlb_periodo ddlb_periodo
st_4 st_4
st_3 st_3
em_anio em_anio
tab_1 tab_1
ddlb_clase_aula ddlb_clase_aula
st_clase_aula st_clase_aula
st_dia st_dia
ddlb_dias ddlb_dias
gb_3 gb_3
gb_1 gb_1
gb_2 gb_2
gb_4 gb_4
gb_5 gb_5
end type
global w_analisis_programacion_grupos w_analisis_programacion_grupos

type variables
Int		ii_tamanio_bloque_horas
Int		ii_cve_dia
Int		ii_clase_aula
Int		ii_anio
Int		ii_periodo
String	is_tipo_horario
Int		ii_inscritos
Int		ii_mostrar_porcentajes
Int		ii_cve_division
Int		ii_cve_depto
Int		ii_cve_coordinacion
Int		ii_cve_tipo_grupo_clase
DataWindowChild	idwc_grafica
end variables

forward prototypes
public function integer wf_obtener_periodo_y_anio_actual ()
public function integer wf_obtener_tamanio_bloque ()
public function integer wf_obtener_dias ()
public function integer wf_obtener_clase_aula ()
public function integer wf_validar_si_aplica_filtro_porcentajes ()
public function long wf_obtener_no_grupos_clase_totales ()
public function integer wf_obtener_horarios_mat_vesp (ref integer ai_hora_inicio_matutino, ref integer ai_hora_fin_matutino, ref integer ai_hora_inicio_vespertino, ref integer ai_hora_fin_vespertino)
public function integer wf_obtener_divisiones ()
public function integer wf_obtener_filtro_departamentos ()
public function integer wf_obtener_coordinaciones ()
public function integer wf_obtener_tipos_gpo_clase ()
end prototypes

public function integer wf_obtener_periodo_y_anio_actual ();String		ls_periodo
String		ls_periodo_actual
Int			li_periodo

Select		periodo,
			anio
Into		:ii_periodo,
			:ii_anio
From		periodos_por_procesos
Where	cve_proceso = 5
Using		gtr_sce;

IF gtr_sce.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De base de datos al consultar el periodo y año actual.~n~r~n~r" + gtr_sce.SQLErrText )
	Return -1;
END IF

IF gtr_sce.SQLCode = 100 THEN
	MessageBox ( "Error:" , "No esta definida la clave de proceso <5> en periodos_por_procesos." )
	Return -1
END IF

em_anio.Text =  String ( ii_anio )

// Periodo ...
DECLARE cur_periodo CURSOR FOR
	SELECT	periodo,
				descripcion
	FROM		periodo
	ORDER BY periodo
	USING	gtr_sce;

OPEN	cur_periodo;

FETCH cur_periodo into :li_periodo, :ls_periodo;

IF gtr_sce.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De base de datos al consultar el catálogo de Periodos.~n~r~n~r" + gtr_sce.SQLErrText )
	Return -1;
END IF

IF gtr_sce.SQLCode = 100 THEN
	MessageBox ( "Error:" , "El catálogo de Periodos no tiene información." )
	Return -1
END IF

DO WHILE gtr_sce.SQLCode <> 100
	IF ii_periodo = li_periodo THEN ls_periodo_actual = ls_periodo
		
	ddlb_periodo.AddItem ( ls_periodo )
	FETCH cur_periodo INTO :li_periodo, :ls_periodo;
LOOP
CLOSE cur_periodo;

ddlb_periodo.SelectItem ( ls_periodo_actual , 0 )

Return 1
end function

public function integer wf_obtener_tamanio_bloque ();Select		tamanio_bloque_horas
Into		:ii_tamanio_bloque_horas
From		parametros_grupo_clase
Using		gtr_sce;

IF gtr_sce.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De base de datos al consultar el tamaño en horas del bloque.~n~r~n~r" + gtr_sce.SQLErrText )
	Return -1;
END IF

IF IsNull ( ii_tamanio_bloque_horas ) THEN ii_tamanio_bloque_horas = 0

IF gtr_sce.SQLCode = 100 OR ii_tamanio_bloque_horas = 0 THEN
	MessageBox ( "Error:" , "El parámetro <Tamaño del Bloque en Horas> no está definido." )
	Return -1;
END IF

st_tamanio_bloque_hrs.Text = String ( ii_tamanio_bloque_horas , "# hrs" )
Return 1
end function

public function integer wf_obtener_dias ();String		ls_dia

DECLARE cur_dias CURSOR FOR
	SELECT	dia
	FROM		dias
	WHERE	cve_dia <> 0
	ORDER BY cve_dia
	USING	gtr_sce;

OPEN	cur_dias;

FETCH cur_dias into :ls_dia;

IF gtr_sce.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De base de datos al consultar el catálogo de días.~n~r~n~r" + gtr_sce.SQLErrText )
	Return -1;
END IF

IF gtr_sce.SQLCode = 100 THEN
	MessageBox ( "Error:" , "El catálogo de días no tiene información." )
	Return -1;
END IF

DO WHILE gtr_sce.SQLCode <> 100
	ddlb_dias.AddItem ( ls_dia )
	FETCH cur_dias INTO :ls_dia;
LOOP
CLOSE cur_dias;

ddlb_dias.AddItem ( "TODOS" )

ddlb_dias.SelectItem ( "TODOS" , 0 )

Return 1
end function

public function integer wf_obtener_clase_aula ();String		ls_clase_aula

DECLARE cur_clase_aula CURSOR FOR
	SELECT	nombre_aula
	FROM		clase_aula
	ORDER BY clase
	USING	gtr_sce;

OPEN	cur_clase_aula;

FETCH cur_clase_aula into :ls_clase_aula;

IF gtr_sce.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De base de datos al consultar las Clases de Aula.~n~r~n~r" + gtr_sce.SQLErrText )
	Return -1;
END IF

IF gtr_sce.SQLCode = 100 THEN
	MessageBox ( "Error:" , "El catálogo de Clase Aula no tiene información." )
	Return -1
END IF

DO WHILE gtr_sce.SQLCode <> 100
	ddlb_clase_aula.AddItem ( ls_clase_aula )
	FETCH cur_clase_aula INTO :ls_clase_aula;
LOOP
CLOSE cur_clase_aula;

ddlb_clase_aula.AddItem ( "TODAS" )

ddlb_clase_aula.SelectItem ( "TODAS" , 0 )

Return 1
end function

public function integer wf_validar_si_aplica_filtro_porcentajes ();	/*
		Los porcentajes aplican sólo para uno de los 3 siguientes criterios de Consulta:
		1)	Día de la semana ( generalmente interesa saber mas de Viernes y Sábado )
		2)	Horario ( generalmente interesa saber mas de Vespertino )
		3)	10 o menos Alumnos Inscritos
		
		No aplica el mostrar porcentajes para cualquier otro criterio ...
		
	*/

	// Validar que exista al menos un filtro para aplicar el Mostrar Porcentajes ...
	IF	ddlb_dias.Text = 'TODOS' AND ddlb_horario.Text = 'TODOS' AND ddlb_clase_aula.Text = 'TODAS' AND cbx_10_o_menos_inscritos.Checked = False THEN
		MessageBox ( "Aviso:" , "Se debe seleccionar un criterio de consulta ('Día', 'Horario' ó '10 o menos Alumnos Inscritos') para poder mostrar Porcentajes.." )
		
		cbx_mostrar_porcentajes.Checked = False
		Return -1;
	END IF
	
	
	// Validar Filtro para dias ...
	IF ddlb_dias.Text <> 'TODOS' THEN
		// Verificar que los demás filtros no esten activados ...
		
		IF ddlb_horario.Text <> 'TODOS' OR cbx_10_o_menos_inscritos.Checked OR ddlb_clase_aula.Text <> 'TODAS' THEN
			
			MessageBox ( "Aviso:" , "No es posible aplicar el filtro de Mostrar Porcentajes si mas de un criterio de consulta está seleccionado." )
			
			cbx_mostrar_porcentajes.Checked = False
			Return -1;
		END IF
		
	END IF
	
	// Validar Filtro para Horario ...
	IF ddlb_horario.Text <> 'TODOS' THEN
		// Verificar que los demás filtros no esten activados ...
		
		IF ddlb_dias.Text <> 'TODOS' OR cbx_10_o_menos_inscritos.Checked OR ddlb_clase_aula.Text <> 'TODAS' THEN
			
			MessageBox ( "Aviso:" , "No es posible aplicar el filtro de Mostrar Porcentajes si mas de un criterio de consulta está seleccionado." )
			
			cbx_mostrar_porcentajes.Checked = False
			Return -1;
		END IF
		
	END IF
	
	// Validar Filtro para 10 o menos Alumnos Inscritos ...
	IF cbx_10_o_menos_inscritos.Checked THEN
		// Verificar que los demás filtros no esten activados ...
		
		IF ddlb_dias.Text <> 'TODOS' OR  ddlb_horario.Text <> 'TODOS' OR ddlb_clase_aula.Text <> 'TODAS' THEN
			
			MessageBox ( "Aviso:" , "No es posible aplicar el filtro de Mostrar Porcentajes si mas de un criterio de consulta está seleccionado." )
			
			cbx_mostrar_porcentajes.Checked = False
			Return -1;
		END IF
		
	END IF
	
	IF ddlb_clase_aula.Text <> 'TODAS' THEN
		Messagebox ( "Aviso:" , "No se pueden mostrar porcentajes para el filtro de Clase de Aula ..." )
		
		cbx_mostrar_porcentajes.Checked = False
		Return -1;
	END IF

Return 1
end function

public function long wf_obtener_no_grupos_clase_totales ();Long		ll_no_grupos_clase_totales

Select		num_bloques_totales = Sum ( num_bloques )
Into		:ll_no_grupos_clase_totales
From		grupo_clase,
			tipo_grupo_clase,
			clase_aula,
			coordinaciones,
			dias
WHERE	grupo_clase.anio = :ii_anio AND
			grupo_clase.periodo = :ii_periodo AND
			grupo_clase.cve_tipo_grupo_clase <> 9999 AND
			grupo_clase.cve_tipo_grupo_clase = tipo_grupo_clase.cve_tipo_grupo_clase AND
			grupo_clase.clase_aula = clase_aula.clase AND
			grupo_clase.cve_coordinacion = coordinaciones.cve_coordinacion AND
			( grupo_clase.cve_coordinacion = 9999 OR 9999 = 9999 ) AND
			grupo_clase.cve_dia = dias.cve_dia
Using		gtr_sce;

IF gtr_sce.SQLCode = -1 THEN
	Messagebox ( "Error:" , "De base de datos al obtener el número total de Grupos - Clase" )
	Return -1
END IF

Return ll_no_grupos_clase_totales
end function

public function integer wf_obtener_horarios_mat_vesp (ref integer ai_hora_inicio_matutino, ref integer ai_hora_fin_matutino, ref integer ai_hora_inicio_vespertino, ref integer ai_hora_fin_vespertino);Select		hora_inicio_vespertino,
			hora_inicio_vespertino
Into		:ai_hora_inicio_vespertino,
			:ai_hora_fin_matutino
From		parametros_grupo_clase
Using		gtr_sce;

IF gtr_sce.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De base de datos al consultar la hora de Inicio del turno Vespertino en parametros_grupo_clase.~n~r~n~r" + gtr_sce.SQLErrText )
	Return -1;
END IF

IF IsNull ( ai_hora_inicio_vespertino ) THEN ai_hora_inicio_vespertino = 0
IF IsNull ( ai_hora_fin_matutino ) THEN ai_hora_fin_matutino = 0

IF gtr_sce.SQLCode = 100 THEN
	MessageBox ( "Error:" , "No exíste información en la tabla parametros_grupo_clase." )
	Return -1;
END IF

IF ai_hora_inicio_vespertino = 0 THEN
	MessageBox ( "Error:" , "El parámetro <hora_inicio_vespertino> no está definido." )
	Return -1;
END IF

IF ai_hora_fin_matutino = 0 THEN
	MessageBox ( "Error:" , "El parámetro <ultima_hra_inicio_matutino> no está definido." )
	Return -1;
END IF

// Las horas de inicio del turno matutino y de fin del turno Vespertino se obtienen de grupo_clase_base ...
Select		Min ( hora_inicio ),
			Max ( hora_final )
Into		:ai_hora_inicio_matutino,
			:ai_hora_fin_vespertino
From		grupo_clase_base
Using		gtr_sce;

IF gtr_sce.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De base de datos al consultar la hora de Fin del turno Vespertino en grupo_clase_base.~n~r~n~r" + gtr_sce.SQLErrText )
	Return -1;
END IF

IF IsNull ( ai_hora_inicio_matutino ) THEN ai_hora_inicio_matutino = 0
IF IsNull ( ai_hora_fin_vespertino ) THEN ai_hora_fin_vespertino = 0

IF gtr_sce.SQLCode = 100 THEN
	MessageBox ( "Error:" , "No exíste información en la tabla grupo_clase_base." )
	Return -1;
END IF

IF ai_hora_inicio_matutino = 0 THEN
	MessageBox ( "Error:" , "El parámetro <hora_inicio_matutino> no está definido." )
	Return -1;
END IF

IF ai_hora_fin_vespertino = 0 THEN
	MessageBox ( "Error:" , "El parámetro <ultima_hora_fin_vespertino> no está definido." )
	Return -1;
END IF

st_horario_matutino.Text = String ( ai_hora_inicio_matutino , "##" ) + ' - ' + String ( ai_hora_fin_matutino , "## hrs" )
st_horario_vespertino.Text = String ( ai_hora_inicio_vespertino , "##" ) + ' - ' + String ( ai_hora_fin_vespertino , "## hrs" )

Return 1
end function

public function integer wf_obtener_divisiones ();String		ls_division

DECLARE cur_divisiones CURSOR FOR
	SELECT	division
	FROM		divisiones
	ORDER BY division
	USING	gtr_sce;

OPEN	cur_divisiones;

FETCH cur_divisiones into :ls_division;

IF gtr_sce.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De base de datos al consultar el catálogo de Divisiones.~n~r~n~r" + gtr_sce.SQLErrText )
	Return -1;
END IF

IF gtr_sce.SQLCode = 100 THEN
	MessageBox ( "Error:" , "El catálogo de Divisiones no tiene información." )
	Return -1;
END IF

DO WHILE gtr_sce.SQLCode <> 100
	ddlb_divisiones.AddItem ( ls_division )
	FETCH cur_divisiones INTO :ls_division;
LOOP

CLOSE cur_divisiones;

ddlb_divisiones.AddItem ( "TODAS" )

ddlb_divisiones.SelectItem ( "TODAS" , 0 )

Return 1
end function

public function integer wf_obtener_filtro_departamentos ();String		ls_departamento

DECLARE cur_departamentos CURSOR FOR
	SELECT	departamento
	FROM		departamentos
	ORDER BY departamento
	USING	gtr_sce;

OPEN	cur_departamentos;

FETCH cur_departamentos into :ls_departamento;

IF gtr_sce.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De base de datos al consultar el catálogo de Departamentoss.~n~r~n~r" + gtr_sce.SQLErrText )
	Return -1;
END IF

IF gtr_sce.SQLCode = 100 THEN
	MessageBox ( "Error:" , "El catálogo de Departamentos no tiene información." )
	Return -1;
END IF

DO WHILE gtr_sce.SQLCode <> 100
	ddlb_departamentos.AddItem ( ls_departamento )
	FETCH cur_departamentos INTO :ls_departamento;
LOOP

CLOSE cur_departamentos;

ddlb_departamentos.AddItem ( "TODOS" )

ddlb_departamentos.SelectItem ( "TODOS" , 0 )

Return 1
end function

public function integer wf_obtener_coordinaciones ();String		ls_coordinacion

//DECLARE cur_coordinaciones CURSOR FOR
//	SELECT	Convert ( Varchar ( 10 ) , cve_coordinacion ) + ' '  + coordinacion
//	FROM		coordinaciones
//	ORDER BY cve_coordinacion
//	USING	gtr_sce;

DECLARE cur_coordinaciones CURSOR FOR
	SELECT	coordinacion
	FROM		coordinaciones
	ORDER BY coordinacion
	USING	gtr_sce;

OPEN	cur_coordinaciones;

FETCH cur_coordinaciones into :ls_coordinacion;

IF gtr_sce.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De base de datos al consultar el catálogo de Coordinaciones.~n~r~n~r" + gtr_sce.SQLErrText )
	Return -1;
END IF

IF gtr_sce.SQLCode = 100 THEN
	MessageBox ( "Error:" , "El catálogo de Coordinaciones no tiene información." )
	Return -1;
END IF

DO WHILE gtr_sce.SQLCode <> 100
	ddlb_coordinaciones.AddItem ( ls_coordinacion )
	FETCH cur_coordinaciones INTO :ls_coordinacion;
LOOP

CLOSE cur_coordinaciones;


//ddlb_coordinaciones.SelectItem ( "9999 Todos" , 0 )
ddlb_coordinaciones.SelectItem ( "Todos" , 0 )

Return 1
end function

public function integer wf_obtener_tipos_gpo_clase ();String		ls_tipo_grupo_clase

DECLARE cur_tipo_grupo_clase CURSOR FOR
	SELECT	tipo_grupo_clase
	FROM		tipo_grupo_clase
	ORDER BY cve_tipo_grupo_clase
	USING	gtr_sce;

OPEN	cur_tipo_grupo_clase;

FETCH cur_tipo_grupo_clase into :ls_tipo_grupo_clase;

IF gtr_sce.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De base de datos al consultar el catálogo de tipos de Gupo Clase.~n~r~n~r" + gtr_sce.SQLErrText )
	Return -1;
END IF

IF gtr_sce.SQLCode = 100 THEN
	MessageBox ( "Error:" , "El catálogo de tipos de Grupos - Clase no tiene información." )
	Return -1;
END IF

DO WHILE gtr_sce.SQLCode <> 100
	lb_tipo_grupo_clase.AddItem ( ls_tipo_grupo_clase )
	FETCH cur_tipo_grupo_clase INTO :ls_tipo_grupo_clase;
LOOP
CLOSE cur_tipo_grupo_clase;

Return 1
end function

on w_analisis_programacion_grupos.create
this.lb_tipo_grupo_clase=create lb_tipo_grupo_clase
this.st_tpo_gpo_clase=create st_tpo_gpo_clase
this.ddlb_coordinaciones=create ddlb_coordinaciones
this.st_coordinacion=create st_coordinacion
this.ddlb_departamentos=create ddlb_departamentos
this.st_departamento=create st_departamento
this.ddlb_divisiones=create ddlb_divisiones
this.st_division=create st_division
this.st_horario_vespertino=create st_horario_vespertino
this.st_horario_matutino=create st_horario_matutino
this.st_tamanio_bloque_hrs=create st_tamanio_bloque_hrs
this.st_horario_vesp=create st_horario_vesp
this.st_horario_mat=create st_horario_mat
this.cb_imprimir=create cb_imprimir
this.cbx_mostrar_porcentajes=create cbx_mostrar_porcentajes
this.cb_consultar=create cb_consultar
this.cbx_10_o_menos_inscritos=create cbx_10_o_menos_inscritos
this.ddlb_horario=create ddlb_horario
this.st_horario=create st_horario
this.cb_1=create cb_1
this.ddlb_periodo=create ddlb_periodo
this.st_4=create st_4
this.st_3=create st_3
this.em_anio=create em_anio
this.tab_1=create tab_1
this.ddlb_clase_aula=create ddlb_clase_aula
this.st_clase_aula=create st_clase_aula
this.st_dia=create st_dia
this.ddlb_dias=create ddlb_dias
this.gb_3=create gb_3
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_4=create gb_4
this.gb_5=create gb_5
this.Control[]={this.lb_tipo_grupo_clase,&
this.st_tpo_gpo_clase,&
this.ddlb_coordinaciones,&
this.st_coordinacion,&
this.ddlb_departamentos,&
this.st_departamento,&
this.ddlb_divisiones,&
this.st_division,&
this.st_horario_vespertino,&
this.st_horario_matutino,&
this.st_tamanio_bloque_hrs,&
this.st_horario_vesp,&
this.st_horario_mat,&
this.cb_imprimir,&
this.cbx_mostrar_porcentajes,&
this.cb_consultar,&
this.cbx_10_o_menos_inscritos,&
this.ddlb_horario,&
this.st_horario,&
this.cb_1,&
this.ddlb_periodo,&
this.st_4,&
this.st_3,&
this.em_anio,&
this.tab_1,&
this.ddlb_clase_aula,&
this.st_clase_aula,&
this.st_dia,&
this.ddlb_dias,&
this.gb_3,&
this.gb_1,&
this.gb_2,&
this.gb_4,&
this.gb_5}
end on

on w_analisis_programacion_grupos.destroy
destroy(this.lb_tipo_grupo_clase)
destroy(this.st_tpo_gpo_clase)
destroy(this.ddlb_coordinaciones)
destroy(this.st_coordinacion)
destroy(this.ddlb_departamentos)
destroy(this.st_departamento)
destroy(this.ddlb_divisiones)
destroy(this.st_division)
destroy(this.st_horario_vespertino)
destroy(this.st_horario_matutino)
destroy(this.st_tamanio_bloque_hrs)
destroy(this.st_horario_vesp)
destroy(this.st_horario_mat)
destroy(this.cb_imprimir)
destroy(this.cbx_mostrar_porcentajes)
destroy(this.cb_consultar)
destroy(this.cbx_10_o_menos_inscritos)
destroy(this.ddlb_horario)
destroy(this.st_horario)
destroy(this.cb_1)
destroy(this.ddlb_periodo)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.em_anio)
destroy(this.tab_1)
destroy(this.ddlb_clase_aula)
destroy(this.st_clase_aula)
destroy(this.st_dia)
destroy(this.ddlb_dias)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.gb_5)
end on

event open;Int		li_hora_inicio_matutino
Int		li_hora_fin_matutino
Int		li_hora_inicio_vespertino
Int		li_hora_fin_vespertino

// Inicializar variables de instancia ...
ii_tamanio_bloque_horas = 0;
ii_cve_dia = 9999;	// TODOS
ii_clase_aula = 9999;	// TODAS
ii_periodo = -1;
ii_anio = 0;
is_tipo_horario = 'TODOS'
ii_inscritos = 9999	// TODOS
ii_mostrar_porcentajes = 0
ii_cve_division = 9999	// TODAS
ii_cve_depto = 9999	// TODOS
ii_cve_coordinacion = 9999	// TODAS
ii_cve_tipo_grupo_clase = 9999	// TODOS

// Obtiene el periodo y año actual ..
IF wf_obtener_periodo_y_anio_actual ( ) = -1 THEN Return

// Obtener el tamaño en horas del bloque ..
IF wf_obtener_tamanio_bloque ( ) = -1 THEN Return

IF wf_obtener_horarios_mat_vesp ( li_hora_inicio_matutino , li_hora_fin_matutino , li_hora_inicio_vespertino , li_hora_fin_vespertino ) = -1 THEN Return

// Inicializar el filtro para días ...
IF wf_obtener_dias ( ) = -1 THEN Return

// Inicializar el filtro para aulas ...
IF wf_obtener_clase_aula ( ) = -1 THEN Return

// Inicializar el filtro para Divisiones ...
IF wf_obtener_divisiones ( ) = -1 THEN Return

// Inicializar el filtro para Departamentos ...
IF wf_obtener_filtro_departamentos ( ) = -1 THEN Return

// Inicializar el filtro para Coordinaciones ...
IF wf_obtener_coordinaciones ( ) = -1 THEN Return

// Inicializar el filtro para Coordinaciones ...
IF wf_obtener_tipos_gpo_clase ( ) = -1 THEN Return

// Inicializar el filtro para horario ...
ddlb_horario.SelectItem ( "TODOS" , 0 )

Tab_1.Tabpage_division.dw_division.SetTransObject ( gtr_sce )
Tab_1.Tabpage_departamento.dw_departamento.SetTransObject ( gtr_sce )
Tab_1.Tabpage_coordinacion.dw_coordinacion.SetTransObject ( gtr_sce )
Tab_1.tabpage_grafica_dias.dw_grafica_dias.SetTransObject ( gtr_sce )
Tab_1.tabpage_condensado.dw_reporte_condensado.SetTransObject ( gtr_sce )

// Inicializar los encabezados de los reportes ...
Tab_1.Tabpage_division.dw_division.Object.t_inscritos.Text = ''
Tab_1.Tabpage_division.dw_division.Object.t_matutino_vespertino.Text = ''
Tab_1.Tabpage_division.dw_division.Object.t_dia.Text = ''
Tab_1.Tabpage_division.dw_division.Object.t_clase_aula.Text = ''
Tab_1.Tabpage_division.dw_division.Object.t_division.Text = ''

Tab_1.Tabpage_departamento.dw_departamento.Object.t_inscritos.Text = ''
Tab_1.Tabpage_departamento.dw_departamento.Object.t_matutino_vespertino.Text = ''
Tab_1.Tabpage_departamento.dw_departamento.Object.t_dia.Text = ''
Tab_1.Tabpage_departamento.dw_departamento.Object.t_clase_aula.Text = ''
Tab_1.Tabpage_departamento.dw_departamento.Object.t_departamento.Text = ''

Tab_1.Tabpage_coordinacion.dw_coordinacion.Object.t_inscritos.Text = ''
Tab_1.Tabpage_coordinacion.dw_coordinacion.Object.t_matutino_vespertino.Text = ''
Tab_1.Tabpage_coordinacion.dw_coordinacion.Object.t_dia.Text = ''
Tab_1.Tabpage_coordinacion.dw_coordinacion.Object.t_clase_aula.Text = ''
Tab_1.Tabpage_coordinacion.dw_coordinacion.Object.t_coordinacion.Text = ''

Tab_1.tabpage_condensado.dw_reporte_condensado.Object.t_dia.Text = ''
Tab_1.tabpage_condensado.dw_reporte_condensado.Object.t_clase_aula.Text = ''
Tab_1.tabpage_condensado.dw_reporte_condensado.Object.t_tipo_grupo_clase.Text = ''

tab_1.tabpage_grafica_dias.dw_grafica_dias.Object.gr_1.Title = 'Porcentajes de Grupos - Clase por Día'
tab_1.tabpage_grafica_dias.dw_grafica_dia.Object.t_clase_aula.Text = ''

// Eliminar el renglón que se inserta en la sección "Data" del moso de diseño de la dw ...
// Esto de insertar un registro desde el modo de diseño es para corregir un bug de power,
// si no se hace esto, siempre se presenta, en modo de ejecución, el díalogo que solicita los
// argumentos de retrieve ...
tab_1.tabpage_grafica_dias.dw_grafica_dias.DeleteRow ( 1 )

// Obtener la dw Child del reporte composit ...
IF tab_1.tabpage_grafica_dias.dw_grafica_dia.GetChild ( 'dw_grafica' , idwc_grafica ) = -1 THEN
	MessageBox ( "Error" , "En Get Child del reporte tipo composit." )
END IF

// Preparar el objeto de Transacción de la dw_child ...
idwc_grafica.SetTransObject ( gtr_sce )
idwc_grafica.DeleteRow  ( 1 )

tab_1.tabpage_grafica_dias.dw_grafica_dia.SetTransObject ( gtr_sce )


Tab_1.SelectTab( 3 )
//cb_consultar.Enabled = False
end event

type lb_tipo_grupo_clase from listbox within w_analisis_programacion_grupos
boolean visible = false
integer x = 2597
integer y = 352
integer width = 1161
integer height = 192
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean vscrollbar = true
boolean sorted = false
boolean multiselect = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string		ls_tipo_grupo_clase

// Obtener la clave del tipo de Grupo - Clase seleccionado ...

ls_tipo_grupo_clase = Text ( 3 )

Select		cve_tipo_grupo_clase
Into		:ii_cve_tipo_grupo_clase
From		tipo_grupo_clase
Where	tipo_grupo_clase = :ls_tipo_grupo_clase
Using		gtr_sce;

IF gtr_sce.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De base de datos al consultar la clave del tipo de Grupo - Clase.~n~r~n~r" + gtr_sce.SQLErrText )
	Return;
END IF

IF IsNull ( ii_cve_tipo_grupo_clase ) THEN ii_cve_tipo_grupo_clase = -1

IF gtr_sce.SQLCode = 100 THEN
	MessageBox ( "Error:" , "El Tipo de Grupo - Clase seleccionada ha cambiado de descripción, la ventana se cerrará." )
	Close ( Parent )
	Return
END IF

//Tab_1.tabpage_condensado.dw_reporte_condensado.Object.t_tipo_grupo_clase.Text = 'TIPO GRUPO - CLASE: ' + Text ( 3 )

//IF cbx_mostrar_porcentajes.Checked THEN
//	IF wf_validar_si_aplica_filtro_porcentajes ( ) = 1 THEN
//		ii_mostrar_porcentajes = 1
//	ELSE
//		ii_mostrar_porcentajes = 0
//	END IF
//END IF
end event

type st_tpo_gpo_clase from statictext within w_analisis_programacion_grupos
boolean visible = false
integer x = 2089
integer y = 360
integer width = 489
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo Grupo-Clase:"
boolean focusrectangle = false
end type

type ddlb_coordinaciones from dropdownlistbox within w_analisis_programacion_grupos
boolean visible = false
integer x = 1449
integer y = 464
integer width = 1211
integer height = 400
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String		ls_coordinacion

// Obtener la clave de la coordinación seleccionada ...

ls_coordinacion = Text

Select		cve_coordinacion
Into		:ii_cve_coordinacion
From		coordinaciones
Where	coordinacion = :ls_coordinacion
Using		gtr_sce;

IF gtr_sce.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De base de datos al consultar la clave de la Coordinación.~n~r~n~r" + gtr_sce.SQLErrText )
	Return;
END IF

IF IsNull ( ii_cve_coordinacion ) THEN ii_cve_coordinacion = -1

IF gtr_sce.SQLCode = 100 THEN
	MessageBox ( "Error:" , "La coordinación seleccionada ha cambiado de descripción, la ventana se cerrará." )
	Close ( Parent )
	Return
END IF

IF Text <> 'Todos' THEN
	Tab_1.Tabpage_coordinacion.dw_coordinacion.Object.t_coordinacion.Text = 'COORDINACIÓN: ' + String ( ii_cve_coordinacion ) + ' ' + Text
END IF

//IF cbx_mostrar_porcentajes.Checked THEN
//	IF wf_validar_si_aplica_filtro_porcentajes ( ) = 1 THEN
//		ii_mostrar_porcentajes = 1
//	ELSE
//		ii_mostrar_porcentajes = 0
//	END IF
//END IF
end event

type st_coordinacion from statictext within w_analisis_programacion_grupos
boolean visible = false
integer x = 1047
integer y = 476
integer width = 407
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Coordinación:"
boolean focusrectangle = false
end type

type ddlb_departamentos from dropdownlistbox within w_analisis_programacion_grupos
boolean visible = false
integer x = 1449
integer y = 464
integer width = 1120
integer height = 400
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String		ls_departamento

// Obtener la clave de la división seleccionada ...

IF Text = "TODOS" THEN
	ii_cve_depto = 9999
	Tab_1.Tabpage_division.dw_division.Object.t_clase_aula.Text = ''
	Tab_1.Tabpage_departamento.dw_departamento.Object.t_departamento.Text = ''

	Return;
END IF

ls_departamento = Text

Select		cve_depto
Into		:ii_cve_depto
From		departamentos
Where	departamento = :ls_departamento 
Using		gtr_sce;

IF gtr_sce.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De base de datos al consultar la clave del Departamento.~n~r~n~r" + gtr_sce.SQLErrText )
	Return;
END IF

IF IsNull ( ii_cve_depto ) THEN ii_cve_depto = -1

IF gtr_sce.SQLCode = 100 THEN
	MessageBox ( "Error:" , "El Departamento seleccionado ha cambiado de descripción, la ventana se cerrará." )
	Close ( Parent )
	Return
END IF

IF Text <> 'TODOS' THEN
	Tab_1.Tabpage_departamento.dw_departamento.Object.t_departamento.Text = 'DEPARTAMENTO: ' + String ( ii_cve_depto ) + ' ' + ls_departamento
END IF

//IF cbx_mostrar_porcentajes.Checked THEN
//	IF wf_validar_si_aplica_filtro_porcentajes ( ) = 1 THEN
//		ii_mostrar_porcentajes = 1
//	ELSE
//		ii_mostrar_porcentajes = 0
//	END IF
//END IF
end event

type st_departamento from statictext within w_analisis_programacion_grupos
boolean visible = false
integer x = 1047
integer y = 476
integer width = 407
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Departamento:"
boolean focusrectangle = false
end type

type ddlb_divisiones from dropdownlistbox within w_analisis_programacion_grupos
boolean visible = false
integer x = 1449
integer y = 464
integer width = 1120
integer height = 400
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String		ls_division

// Obtener la clave de la división seleccionada ...

IF Text = "TODAS" THEN
	ii_cve_division = 9999
	Tab_1.Tabpage_division.dw_division.Object.t_division.Text = ''

	Return;
END IF

ls_division = Text

Select		cve_division
Into		:ii_cve_division
From		divisiones
Where	division = :ls_division
Using		gtr_sce;

IF gtr_sce.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De base de datos al consultar la clave de la División.~n~r~n~r" + gtr_sce.SQLErrText )
	Return;
END IF

IF IsNull ( ii_cve_division ) THEN ii_cve_division = -1

IF gtr_sce.SQLCode = 100 THEN
	MessageBox ( "Error:" , "La División seleccionada a cambiado de descripción, la ventana se cerrará." )
	Close ( Parent )
	Return
END IF

IF Text <> 'TODAS' THEN
	Tab_1.Tabpage_division.dw_division.Object.t_division.Text = 'DIVISIÓN: ' + String ( ii_cve_division ) + ' ' + ls_division
END IF

//IF cbx_mostrar_porcentajes.Checked THEN
//	IF wf_validar_si_aplica_filtro_porcentajes ( ) = 1 THEN
//		ii_mostrar_porcentajes = 1
//	ELSE
//		ii_mostrar_porcentajes = 0
//	END IF
//END IF
end event

type st_division from statictext within w_analisis_programacion_grupos
boolean visible = false
integer x = 1047
integer y = 476
integer width = 233
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "División:"
boolean focusrectangle = false
end type

type st_horario_vespertino from statictext within w_analisis_programacion_grupos
integer x = 1047
integer y = 152
integer width = 402
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_horario_matutino from statictext within w_analisis_programacion_grupos
integer x = 1047
integer y = 72
integer width = 402
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_tamanio_bloque_hrs from statictext within w_analisis_programacion_grupos
integer x = 201
integer y = 116
integer width = 379
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "hrs"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_horario_vesp from statictext within w_analisis_programacion_grupos
integer x = 713
integer y = 168
integer width = 315
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vespertino:"
boolean focusrectangle = false
end type

type st_horario_mat from statictext within w_analisis_programacion_grupos
integer x = 713
integer y = 96
integer width = 315
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Matutino:"
boolean focusrectangle = false
end type

type cb_imprimir from commandbutton within w_analisis_programacion_grupos
integer x = 3771
integer y = 444
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Imprimir"
end type

event clicked;
IF tab_1.selectedTab = 1 THEN
	IF Tab_1.Tabpage_division.dw_division.RowCount ( ) > 0 THEN
		PrintSetup ( )
		Tab_1.Tabpage_division.dw_division.Print ( )
	END IF
END IF

IF tab_1.selectedTab = 2 THEN
	IF Tab_1.Tabpage_departamento.dw_departamento.RowCount ( ) > 0 THEN
		PrintSetup ( )
		Tab_1.Tabpage_departamento.dw_departamento.Print ( )
	END IF
END IF

IF tab_1.selectedTab = 3 THEN
	IF Tab_1.Tabpage_coordinacion.dw_coordinacion.RowCount ( ) > 0 THEN
		PrintSetup ( )
		Tab_1.Tabpage_coordinacion.dw_coordinacion.Print ( )
	END IF
END IF

IF tab_1.selectedTab = 4 THEN
	IF Tab_1.tabpage_grafica_dias.dw_grafica_dia.RowCOunt ( ) > 0 THEN
		PrintSetup ( )
		Tab_1.tabpage_grafica_dias.dw_grafica_dia.Print ( )
	END IF
END IF

IF tab_1.selectedTab = 5 THEN
	IF Tab_1.tabpage_condensado.dw_reporte_condensado.RowCOunt ( ) > 0 THEN
		PrintSetup ( )
		Tab_1.tabpage_condensado.dw_reporte_condensado.Print ( )
	END IF
END IF
end event

type cbx_mostrar_porcentajes from checkbox within w_analisis_programacion_grupos
integer x = 2761
integer y = 476
integer width = 608
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mostrar Porcentajes"
end type

event clicked;IF Checked THEN
//	
//	IF wf_validar_si_aplica_filtro_porcentajes ( ) = 1 THEN
		ii_mostrar_porcentajes = 1
//	ELSE
//		ii_mostrar_porcentajes = 0
//	END IF

ELSE
	ii_mostrar_porcentajes = 0
END IF
end event

type cb_consultar from commandbutton within w_analisis_programacion_grupos
integer x = 3771
integer y = 324
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Consultar"
end type

event clicked;Int		li_horario_matutino
Int		li_horario_vespertino
Long	ll_no_grupos_clase_totales
Long	ll_no_grupos_clase_division
Long	ll_no_grupos_clase_departamento
Long	ll_no_grupos_clase_coordinacion
Dec	ldec_porcentaje
Int		li_total_seleccionados
Int		li_total_elementos
String	ls_tipo_grupo_clase
Int		li_indice
Int		li_cve_tipo_grupo_clase []
Int		li_contador

// Obtener los posibles valores del fitrlo por Tipo Grupo - Clase ...
li_total_elementos = lb_tipo_grupo_clase.TotalItems ( )

li_total_seleccionados = lb_tipo_grupo_clase.TotalSelected ( )

IF li_total_seleccionados = 0 THEN
	FOR li_indice = 1 TO li_total_elementos
		
			li_cve_tipo_grupo_clase [ li_indice ] = li_indice

	NEXT
END IF

IF li_total_seleccionados > 0 THEN
	li_contador = 0
	FOR li_indice = 1 TO li_total_elementos
		
		IF lb_tipo_grupo_clase.State ( li_indice ) = 1 THEN
			ls_tipo_grupo_clase = lb_tipo_grupo_clase.Text ( li_indice )
			
			li_contador ++
			li_cve_tipo_grupo_clase [ li_contador ] = li_indice

		END IF
	NEXT

END IF


Tab_1.Tabpage_coordinacion.st_coordinacion_sin_info.Visible = False
Tab_1.Tabpage_departamento.st_departamentos_sin_info.Visible = False
Tab_1.Tabpage_division.st_division_sin_info.Visible = False
Tab_1.tabpage_condensado.st_condensado_sin_info.Visible = False

// Agregar al nombre del reporte el periodo y año ...
Tab_1.Tabpage_division.dw_division.Object.t_reporte.Text = 'REPORTE DE PROGRAMACIÓN DE GRUPOS POR DIVISIÓN, ' + ddlb_periodo.Text + ' ' + String ( ii_anio )
Tab_1.Tabpage_departamento.dw_departamento.Object.t_reporte.Text = 'REPORTE DE PROGRAMACIÓN DE GRUPOS POR DEPARTAMENTO, ' + ddlb_periodo.Text + ' ' + String ( ii_anio )
Tab_1.Tabpage_coordinacion.dw_coordinacion.Object.t_reporte.Text = 'REPORTE DE PROGRAMACIÓN DE GRUPOS POR COORDINACIÓN, ' + ddlb_periodo.Text + ' ' + String ( ii_anio )

IF is_tipo_horario = 'MATUTINO' THEN
	li_horario_matutino = 9999
	li_horario_vespertino = 0
END IF

IF is_tipo_horario = 'VESPERTINO' THEN
	li_horario_vespertino = 9999
	li_horario_matutino = 0
END IF

IF is_tipo_horario = 'TODOS' THEN
	li_horario_matutino = 9999
	li_horario_vespertino = 9999
END IF

IF Tab_1.Tabpage_division.dw_division.Retrieve ( ii_anio , ii_periodo , ii_cve_dia , ii_inscritos , ii_clase_aula , li_horario_matutino , li_horario_vespertino , ii_cve_division ) = 0 THEN

	Tab_1.Tabpage_division.st_division_sin_info.Visible = True
	
END IF

IF Tab_1.Tabpage_departamento.dw_departamento.Retrieve ( ii_anio , ii_periodo , ii_cve_dia , ii_inscritos , ii_clase_aula , li_horario_matutino , li_horario_vespertino , ii_cve_depto ) = 0 THEN

	Tab_1.Tabpage_departamento.st_departamentos_sin_info.Visible = True
	
END IF

IF Tab_1.Tabpage_coordinacion.dw_coordinacion.Retrieve ( ii_anio , ii_periodo , ii_cve_dia , ii_inscritos , ii_clase_aula , li_horario_matutino , li_horario_vespertino , ii_cve_coordinacion ) = 0 THEN
	
	Tab_1.Tabpage_coordinacion.st_coordinacion_sin_info.Visible = True
	
END IF

IF Tab_1.tabpage_condensado.dw_reporte_condensado.Retrieve ( ii_anio , ii_periodo , ii_cve_dia , ii_clase_aula , li_cve_tipo_grupo_clase [  ] ) = 0 THEN
	
	Tab_1.tabpage_condensado.st_condensado_sin_info.Visible = True
	
END IF

IF cbx_mostrar_porcentajes.Checked THEN
	 ll_no_grupos_clase_totales = wf_obtener_no_grupos_clase_totales ( ) 
	 
	IF ll_no_grupos_clase_totales = -1 THEN
		MessageBox ( "Aviso:" , "No es posible presentar el porcentaje, por favor, comunique este mensaje al áre de Informática" )
		Return
	END IF

	// Porcentajes para filtro por División ...
	IF Tab_1.Tabpage_division.dw_division.RowCount ( ) > 0 THEN
		ll_no_grupos_clase_division = Tab_1.Tabpage_division.dw_division.Object.c_total_grupos_clase [ 1 ]
		
		ldec_porcentaje = Round ( ( ll_no_grupos_clase_division / ll_no_grupos_clase_totales ) * 100 , 2 )
		
		Tab_1.Tabpage_division.dw_division.Object.t_porcentaje.Text = 'Porcentaje: ' + String ( ldec_porcentaje , "##.00" ) + ' %'
	END IF
	

	// Porcentajes para filtro por Departamento ...
	IF Tab_1.Tabpage_departamento.dw_departamento.RowCount ( ) > 0 THEN
		ll_no_grupos_clase_departamento = Tab_1.Tabpage_departamento.dw_departamento.Object.c_total_grupos_clase [ 1 ]
		
		ldec_porcentaje = Round ( ( ll_no_grupos_clase_departamento / ll_no_grupos_clase_totales ) * 100 , 2 )
		
		Tab_1.Tabpage_departamento.dw_departamento.Object.t_porcentaje.Text = 'Porcentaje: ' + String ( ldec_porcentaje , "##.00" ) + ' %'
	END IF
	
	// Porcentajes para filtro por Coordinación ...
	IF Tab_1.Tabpage_coordinacion.dw_coordinacion.RowCount ( ) > 0 THEN
		ll_no_grupos_clase_coordinacion = Tab_1.Tabpage_coordinacion.dw_coordinacion.Object.c_total_grupos_clase [ 1 ]
		
		ldec_porcentaje = Round ( ( ll_no_grupos_clase_coordinacion / ll_no_grupos_clase_totales ) * 100 , 2 )
		
		Tab_1.Tabpage_coordinacion.dw_coordinacion.Object.t_porcentaje.Text = 'Porcentaje: ' + String ( ldec_porcentaje , "##.00" ) + ' %'
	END IF
	
ELSE
	Tab_1.Tabpage_division.dw_division.Object.t_porcentaje.Text = ''
	Tab_1.Tabpage_departamento.dw_departamento.Object.t_porcentaje.Text = ''
	Tab_1.Tabpage_coordinacion.dw_coordinacion.Object.t_porcentaje.Text = ''
	
END IF

Tab_1.tabpage_grafica_dias.dw_grafica_dias.Retrieve ( ii_anio , ii_periodo , ii_clase_aula )
idwc_grafica.Retrieve (  ii_anio , ii_periodo , ii_clase_aula )
end event

type cbx_10_o_menos_inscritos from checkbox within w_analisis_programacion_grupos
integer x = 2761
integer y = 360
integer width = 864
integer height = 80
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "10 o menos Alumnos inscritos"
end type

event clicked;IF Checked THEN
	ii_inscritos = 10
	Tab_1.Tabpage_division.dw_division.Object.t_inscritos.Text = 'CON 10 O MENOS ALUMNOS INSCRITOS'
	Tab_1.Tabpage_departamento.dw_departamento.Object.t_inscritos.Text = 'CON 10 O MENOS ALUMNOS INSCRITOS'
	Tab_1.Tabpage_coordinacion.dw_coordinacion.Object.t_inscritos.Text = 'CON 10 O MENOS ALUMNOS INSCRITOS'
ELSE
	ii_inscritos = 9999
	Tab_1.Tabpage_division.dw_division.Object.t_inscritos.Text = ''
	Tab_1.Tabpage_departamento.dw_departamento.Object.t_inscritos.Text = ''
	Tab_1.Tabpage_coordinacion.dw_coordinacion.Object.t_inscritos.Text = ''
END IF

//IF cbx_mostrar_porcentajes.Checked THEN
//	IF wf_validar_si_aplica_filtro_porcentajes ( ) = 1 THEN
//		ii_mostrar_porcentajes = 1
//	ELSE
//		ii_mostrar_porcentajes = 0
//	END IF
//END IF
end event

type ddlb_horario from dropdownlistbox within w_analisis_programacion_grupos
integer x = 471
integer y = 464
integer width = 480
integer height = 400
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"MATUTINO","VESPERTINO","TODOS"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;// Obtener el horario seleccionado ...

is_tipo_horario = Text

IF is_tipo_horario = 'MATUTINO' THEN
	Tab_1.Tabpage_division.dw_division.Object.t_matutino_vespertino.Text = 'EN HORARIO MATUTINO'
	Tab_1.Tabpage_departamento.dw_departamento.Object.t_matutino_vespertino.Text = 'EN HORARIO MATUTINO'
	Tab_1.Tabpage_coordinacion.dw_coordinacion.Object.t_matutino_vespertino.Text = 'EN HORARIO MATUTINO'
END IF

IF is_tipo_horario = 'VESPERTINO' THEN
	Tab_1.Tabpage_division.dw_division.Object.t_matutino_vespertino.Text = 'EN HORARIO VESPERTINO'
	Tab_1.Tabpage_departamento.dw_departamento.Object.t_matutino_vespertino.Text = 'EN HORARIO VESPERTINO'
	Tab_1.Tabpage_coordinacion.dw_coordinacion.Object.t_matutino_vespertino.Text = 'EN HORARIO VESPERTINO'
END IF

IF is_tipo_horario = 'TODOS' THEN
	Tab_1.Tabpage_division.dw_division.Object.t_matutino_vespertino.Text = ''
	Tab_1.Tabpage_departamento.dw_departamento.Object.t_matutino_vespertino.Text = ''
	Tab_1.Tabpage_coordinacion.dw_coordinacion.Object.t_matutino_vespertino.Text = ''
END IF

//IF cbx_mostrar_porcentajes.Checked THEN
//	IF wf_validar_si_aplica_filtro_porcentajes ( ) = 1 THEN
//		ii_mostrar_porcentajes = 1
//	ELSE
//		ii_mostrar_porcentajes = 0
//	END IF
//END IF
end event

type st_horario from statictext within w_analisis_programacion_grupos
integer x = 210
integer y = 476
integer width = 229
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Horario:"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_analisis_programacion_grupos
integer x = 3479
integer y = 100
integer width = 695
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Preparar Año y Periodo"
end type

event clicked;
SetPointer ( HourGlass! )

DECLARE  lsp_genera_grupos_clase PROCEDURE FOR dbo.sp_genera_grupos_clase
@periodo= :ii_periodo, 
@anio = :ii_anio, 
@tamanio_bloque = :ii_tamanio_bloque_horas
USING gtr_sce;

EXECUTE lsp_genera_grupos_clase;

IF gtr_sce.SQLCode = -1 THEN
	
	MessageBox ( "Error" , "Al ejecutar el proceso que prepara la información de Año y Periodo.~n~r~n~r " + gtr_sce.SQLErrText )
	RollBack Using gtr_sce;
	SetPointer ( Arrow! )
	Return
ELSE
	Commit Using gtr_sce;
END IF

MessageBox ( "Aviso" , "La información se preparó de forma correcta para el año " + em_anio.Text + " y el periodo " + ddlb_periodo.Text  )

cb_consultar.Enabled = True

SetPointer ( Arrow! )
end event

type ddlb_periodo from dropdownlistbox within w_analisis_programacion_grupos
integer x = 2501
integer y = 108
integer width = 526
integer height = 400
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;// Obtener la clave del día seleccionado ...

Select		periodo
Into		:ii_periodo
From		periodo
Where	descripcion = :Text
Using		gtr_sce;

IF gtr_sce.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De base de datos al consultar la clave del Periodo.~n~r~n~r" + gtr_sce.SQLErrText )
	Return;
END IF

IF IsNull ( ii_periodo ) THEN ii_periodo = -1

IF gtr_sce.SQLCode = 100 OR ii_clase_aula = -1 THEN
	MessageBox ( "Error:" , "El periodo seleccionado a cambiado de descripción, la ventana se cerrará." )
	Close ( Parent )
	Return
END IF

end event

type st_4 from statictext within w_analisis_programacion_grupos
integer x = 2203
integer y = 124
integer width = 233
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Periodo:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_analisis_programacion_grupos
integer x = 1586
integer y = 124
integer width = 197
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Año:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_anio from editmask within w_analisis_programacion_grupos
integer x = 1829
integer y = 108
integer width = 283
integer height = 96
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "2011"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####"
boolean spin = true
double increment = 1
end type

event modified;ii_anio = Integer ( Text )
end event

type tab_1 from tab within w_analisis_programacion_grupos
integer x = 55
integer y = 656
integer width = 4389
integer height = 2172
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 3
tabpage_division tabpage_division
tabpage_departamento tabpage_departamento
tabpage_coordinacion tabpage_coordinacion
tabpage_grafica_dias tabpage_grafica_dias
tabpage_condensado tabpage_condensado
end type

on tab_1.create
this.tabpage_division=create tabpage_division
this.tabpage_departamento=create tabpage_departamento
this.tabpage_coordinacion=create tabpage_coordinacion
this.tabpage_grafica_dias=create tabpage_grafica_dias
this.tabpage_condensado=create tabpage_condensado
this.Control[]={this.tabpage_division,&
this.tabpage_departamento,&
this.tabpage_coordinacion,&
this.tabpage_grafica_dias,&
this.tabpage_condensado}
end on

on tab_1.destroy
destroy(this.tabpage_division)
destroy(this.tabpage_departamento)
destroy(this.tabpage_coordinacion)
destroy(this.tabpage_grafica_dias)
destroy(this.tabpage_condensado)
end on

event selectionchanged;// -------------------------------------------------------------------------------------------
// Ocultar los filtros tal como estan al abrir la ventana ...
// -------------------------------------------------------------------------------------------
st_division.Visible = False
st_departamento.Visible = False
st_coordinacion.Visible = False
st_tpo_gpo_clase.Visible = False
ddlb_divisiones.Visible = False
ddlb_departamentos.Visible = False
ddlb_coordinaciones.Visible = False
lb_tipo_grupo_clase.Visible = False


// -------------------------------------------------------------------------------------------
// Hacer visibles los filtros tal como aparecen al abrir la ventana ...
// -------------------------------------------------------------------------------------------
st_dia.Visible = True
ddlb_dias.Visible = True
st_horario.Visible = True
ddlb_horario.Visible = True
st_horario.Visible = True
ddlb_horario.Visible = True
cbx_10_o_menos_inscritos.Visible = True
cbx_mostrar_porcentajes.Visible = True


// -------------------------------------------------------------------------------------------
//	Colocar las posiciones de los filtros tal como estan al abrir la ventana ...
// -------------------------------------------------------------------------------------------
st_clase_aula.x = 1047
ddlb_clase_aula.x = 1449


// -------------------------------------------------------------------------------------------
// Ahora, sólo mostrasr el filtro correspondiente al tab seleccionado ...
// -------------------------------------------------------------------------------------------

IF SelectedTab = 1 THEN
	// Mostrar el filtro de División ...
	st_division.Visible = True
	ddlb_divisiones.Visible = True
END IF

IF SelectedTab = 2 THEN
	// Mostrar el filtro de Departamento ...
	st_departamento.Visible = True
	ddlb_departamentos.Visible = True
END IF

IF SelectedTab = 3 THEN
	// Mostrar el filtro de Coordinación ...
	st_coordinacion.Visible = True
	ddlb_coordinaciones.Visible = True
END IF

IF SelectedTab = 4 THEN
	// Ocultar el filtro por día ...
	st_dia.Visible = False
	ddlb_dias.Visible = False
	
	// Ocultar el filtro por horario ...
	st_horario.Visible = False
	ddlb_horario.Visible = False
	
	// Mover la posición del filtro Clase - Aula ...
	st_clase_aula.x = 210
	ddlb_clase_aula.x = 612
	
	// Ocultar el Filtro de Con 10 o menos inscritos ...
	cbx_10_o_menos_inscritos.Visible = False
	
	// Ocultar el filtro de Mostrar Porcentajes ...
	cbx_mostrar_porcentajes.Visible = False
END IF

IF SelectedTab = 5 THEN
	// Mostrar el filtro de Tipos de Grupo Clase ...
	st_tpo_gpo_clase.Visible = True
	lb_tipo_grupo_clase.Visible = True
	
	// Ocultar el filtro por Horario ...
	st_horario.Visible = False
	ddlb_horario.Visible = False
	
	// Ocultar el Filtro de Con 10 o menos inscritos ...
	cbx_10_o_menos_inscritos.Visible = False
	
	// Ocultar el filtro de Mostrar Porcentajes ...
	cbx_mostrar_porcentajes.Visible = False
END IF

end event

type tabpage_division from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 4352
integer height = 2044
long backcolor = 67108864
string text = "División"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_division_sin_info st_division_sin_info
dw_division dw_division
end type

on tabpage_division.create
this.st_division_sin_info=create st_division_sin_info
this.dw_division=create dw_division
this.Control[]={this.st_division_sin_info,&
this.dw_division}
end on

on tabpage_division.destroy
destroy(this.st_division_sin_info)
destroy(this.dw_division)
end on

type st_division_sin_info from statictext within tabpage_division
boolean visible = false
integer x = 677
integer y = 756
integer width = 3118
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean italic = true
long textcolor = 10789024
string text = "NO EXÍSTE INFORMACIÓN PARA LOS CRITERIOS SELECCIONADOS"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_division from datawindow within tabpage_division
integer x = 9
integer y = 52
integer width = 4325
integer height = 1940
integer taborder = 30
string title = "none"
string dataobject = "dw_grupos_clase_por_division"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;SelectRow ( 0 , False )
SelectRow ( CurrentRow , True )
end event

event resize;Long		ll_diferencia

IF Height <> NewHeight THEN
	
	tab_1.Height += 200
	gb_2.Height += 200

END IF


end event

type tabpage_departamento from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 4352
integer height = 2044
long backcolor = 67108864
string text = "Departamento"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_departamentos_sin_info st_departamentos_sin_info
dw_departamento dw_departamento
end type

on tabpage_departamento.create
this.st_departamentos_sin_info=create st_departamentos_sin_info
this.dw_departamento=create dw_departamento
this.Control[]={this.st_departamentos_sin_info,&
this.dw_departamento}
end on

on tabpage_departamento.destroy
destroy(this.st_departamentos_sin_info)
destroy(this.dw_departamento)
end on

type st_departamentos_sin_info from statictext within tabpage_departamento
boolean visible = false
integer x = 677
integer y = 756
integer width = 3118
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean italic = true
long textcolor = 10789024
string text = "NO EXÍSTE INFORMACIÓN PARA LOS CRITERIOS SELECCIONADOS"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_departamento from datawindow within tabpage_departamento
integer x = 9
integer y = 52
integer width = 4325
integer height = 1940
integer taborder = 40
string title = "none"
string dataobject = "dw_grupos_clase_por_departamento"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;SelectRow ( 0 , False )
SelectRow ( CurrentRow , True )
end event

event resize;Long		ll_diferencia

IF Height <> NewHeight THEN
	
	tab_1.Height += 200
	gb_2.Height += 200

END IF


end event

type tabpage_coordinacion from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4352
integer height = 2044
long backcolor = 67108864
string text = "Coordinación"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_coordinacion_sin_info st_coordinacion_sin_info
dw_coordinacion dw_coordinacion
end type

on tabpage_coordinacion.create
this.st_coordinacion_sin_info=create st_coordinacion_sin_info
this.dw_coordinacion=create dw_coordinacion
this.Control[]={this.st_coordinacion_sin_info,&
this.dw_coordinacion}
end on

on tabpage_coordinacion.destroy
destroy(this.st_coordinacion_sin_info)
destroy(this.dw_coordinacion)
end on

type st_coordinacion_sin_info from statictext within tabpage_coordinacion
boolean visible = false
integer x = 677
integer y = 756
integer width = 3118
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean italic = true
long textcolor = 10789024
string text = "NO EXÍSTE INFORMACIÓN PARA LOS CRITERIOS SELECCIONADOS"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_coordinacion from datawindow within tabpage_coordinacion
integer x = 9
integer y = 52
integer width = 4325
integer height = 1940
integer taborder = 30
string title = "none"
string dataobject = "dw_grupos_clase_por_coordinacion"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;SelectRow ( 0 , False )
SelectRow ( CurrentRow , True )
end event

event resize;Long		ll_diferencia

IF Height <> NewHeight THEN
	
	tab_1.Height += 200
	gb_2.Height += 200

END IF


end event

type tabpage_grafica_dias from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4352
integer height = 2044
long backcolor = 67108864
string text = "Gráfica de % por Día"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_grafica_dias dw_grafica_dias
dw_grafica_dia dw_grafica_dia
end type

on tabpage_grafica_dias.create
this.dw_grafica_dias=create dw_grafica_dias
this.dw_grafica_dia=create dw_grafica_dia
this.Control[]={this.dw_grafica_dias,&
this.dw_grafica_dia}
end on

on tabpage_grafica_dias.destroy
destroy(this.dw_grafica_dias)
destroy(this.dw_grafica_dia)
end on

type dw_grafica_dias from datawindow within tabpage_grafica_dias
integer x = 297
integer y = 60
integer width = 2331
integer height = 1212
integer taborder = 30
string title = "none"
string dataobject = "dw_grafica_de_porcentaje_por_dias"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_grafica_dia from datawindow within tabpage_grafica_dias
boolean visible = false
integer x = 9
integer y = 52
integer width = 3826
integer height = 1256
integer taborder = 30
string title = "none"
string dataobject = "dw_grafica_de_porcentaje_por_diass"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_condensado from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4352
integer height = 2044
long backcolor = 67108864
string text = "Reporte Condensado"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_condensado_sin_info st_condensado_sin_info
dw_reporte_condensado dw_reporte_condensado
end type

on tabpage_condensado.create
this.st_condensado_sin_info=create st_condensado_sin_info
this.dw_reporte_condensado=create dw_reporte_condensado
this.Control[]={this.st_condensado_sin_info,&
this.dw_reporte_condensado}
end on

on tabpage_condensado.destroy
destroy(this.st_condensado_sin_info)
destroy(this.dw_reporte_condensado)
end on

type st_condensado_sin_info from statictext within tabpage_condensado
boolean visible = false
integer x = 677
integer y = 756
integer width = 3118
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean italic = true
long textcolor = 10789024
string text = "NO EXÍSTE INFORMACIÓN PARA LOS CRITERIOS SELECCIONADOS"
boolean focusrectangle = false
end type

type dw_reporte_condensado from datawindow within tabpage_condensado
integer x = 9
integer y = 52
integer width = 4325
integer height = 1940
integer taborder = 30
string title = "none"
string dataobject = "dw_grupos_clase_por_division_condensado"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event resize;Long		ll_diferencia

IF Height <> NewHeight THEN
	
	tab_1.Height += 200
	gb_2.Height += 200

END IF


end event

event rowfocuschanged;SelectRow ( 0 , False )
SelectRow ( CurrentRow , True )
end event

type ddlb_clase_aula from dropdownlistbox within w_analisis_programacion_grupos
integer x = 1449
integer y = 352
integer width = 585
integer height = 400
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;// Obtener la clave del día seleccionado ...

IF Text = "TODAS" THEN
	ii_clase_aula = 9999
	Tab_1.Tabpage_division.dw_division.Object.t_clase_aula.Text = ''
	Tab_1.Tabpage_departamento.dw_departamento.Object.t_clase_aula.Text = ''
	Tab_1.Tabpage_coordinacion.dw_coordinacion.Object.t_clase_aula.Text = ''
	Tab_1.tabpage_condensado.dw_reporte_condensado.Object.t_clase_aula.Text = ''
	tab_1.tabpage_grafica_dias.dw_grafica_dias.Object.gr_1.Title = 'Porcentajes de Grupos - Clase por Día'
	tab_1.tabpage_grafica_dias.dw_grafica_dia.Object.t_clase_aula.Text = ''
	
	Return;
END IF

Select		clase
Into		:ii_clase_aula
From		clase_aula
Where	nombre_aula = :Text
Using		gtr_sce;

IF gtr_sce.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De base de datos al consultar la clave de la Clase de Aula.~n~r~n~r" + gtr_sce.SQLErrText )
	Return;
END IF

IF IsNull ( ii_clase_aula ) THEN ii_clase_aula = -1

IF gtr_sce.SQLCode = 100 OR ii_clase_aula = -1 THEN
	MessageBox ( "Error:" , "La Clase de Aula seleccionada a cambiado de descripción, la ventana se cerrará." )
	Close ( Parent )
	Return
END IF

IF Text <> 'TODAS' THEN
	Tab_1.Tabpage_division.dw_division.Object.t_clase_aula.Text = 'CLASE DE AULA: ' + Text
	Tab_1.Tabpage_departamento.dw_departamento.Object.t_clase_aula.Text = 'CLASE DE AULA: ' + Text
	Tab_1.Tabpage_coordinacion.dw_coordinacion.Object.t_clase_aula.Text = 'CLASE DE AULA: ' + Text
	Tab_1.tabpage_condensado.dw_reporte_condensado.Object.t_clase_aula.Text = 'CLASE DE AULA: ' + Text
	tab_1.tabpage_grafica_dias.dw_grafica_dias.Object.gr_1.Title = 'Porcentajes de Grupos - Clase por Día ' + 'CLASE DE AULA: ' + Text
		tab_1.tabpage_grafica_dias.dw_grafica_dia.Object.t_clase_aula.Text = 'CLASE DE AULA: ' + Text
END IF

//IF cbx_mostrar_porcentajes.Checked THEN
//	IF wf_validar_si_aplica_filtro_porcentajes ( ) = 1 THEN
//		ii_mostrar_porcentajes = 1
//	ELSE
//		ii_mostrar_porcentajes = 0
//	END IF
//END IF
end event

type st_clase_aula from statictext within w_analisis_programacion_grupos
integer x = 1047
integer y = 360
integer width = 311
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Clase Aula:"
boolean focusrectangle = false
end type

type st_dia from statictext within w_analisis_programacion_grupos
integer x = 210
integer y = 360
integer width = 155
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Día:"
boolean focusrectangle = false
end type

type ddlb_dias from dropdownlistbox within w_analisis_programacion_grupos
integer x = 471
integer y = 352
integer width = 480
integer height = 400
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;// Obtener la clave del día seleccionado ...

IF Text = "TODOS" THEN
	ii_cve_dia = 9999
	Tab_1.Tabpage_division.dw_division.Object.t_dia.Text = ''
	Tab_1.Tabpage_departamento.dw_departamento.Object.t_dia.Text = ''
	Tab_1.Tabpage_coordinacion.dw_coordinacion.Object.t_dia.Text = ''
	Tab_1.tabpage_condensado.dw_reporte_condensado.Object.t_dia.Text = ''

	Return;
END IF

Select		cve_dia
Into		:ii_cve_dia
From		dias
Where	dias.dia = :Text
Using		gtr_sce;

IF gtr_sce.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De base de datos al consultar la clave del día.~n~r~n~r" + gtr_sce.SQLErrText )
	Return;
END IF

IF IsNull ( ii_cve_dia ) THEN ii_cve_dia = 0

IF gtr_sce.SQLCode = 100 OR ii_cve_dia = 0 THEN
	MessageBox ( "Error:" , "El el día seleccionado a cambiado de descripción, la ventana se cerrará." )
	Close ( Parent )
	Return
END IF

IF ddlb_dias.Text <> 'TODOS' THEN
	Tab_1.Tabpage_division.dw_division.Object.t_dia.Text = 'DÍA: ' + ddlb_dias.Text
	Tab_1.Tabpage_departamento.dw_departamento.Object.t_dia.Text = 'DÍA: ' + ddlb_dias.Text
	Tab_1.Tabpage_coordinacion.dw_coordinacion.Object.t_dia.Text = 'DÍA: ' + ddlb_dias.Text
	Tab_1.tabpage_condensado.dw_reporte_condensado.Object.t_dia.Text = 'DÍA: ' + ddlb_dias.Text
END IF

//IF cbx_mostrar_porcentajes.Checked THEN
//	IF wf_validar_si_aplica_filtro_porcentajes ( ) = 1 THEN
//		ii_mostrar_porcentajes = 1
//	ELSE
//		ii_mostrar_porcentajes = 0
//	END IF
//END IF
//
end event

type gb_3 from groupbox within w_analisis_programacion_grupos
integer x = 128
integer y = 248
integer width = 4078
integer height = 324
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Criterios de Consulta:"
end type

type gb_1 from groupbox within w_analisis_programacion_grupos
integer x = 133
integer y = 24
integer width = 503
integer height = 224
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tamaño Bloque:"
end type

type gb_2 from groupbox within w_analisis_programacion_grupos
integer x = 32
integer y = 572
integer width = 4439
integer height = 2300
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_4 from groupbox within w_analisis_programacion_grupos
integer x = 1545
integer y = 24
integer width = 2661
integer height = 220
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Año y Periodo"
end type

type gb_5 from groupbox within w_analisis_programacion_grupos
integer x = 645
integer y = 24
integer width = 878
integer height = 224
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Turnos:"
end type

