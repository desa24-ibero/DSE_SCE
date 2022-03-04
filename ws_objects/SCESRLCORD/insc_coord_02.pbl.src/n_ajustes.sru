$PBExportHeader$n_ajustes.sru
forward
global type n_ajustes from nonvisualobject
end type
end forward

global type n_ajustes from nonvisualobject
end type
global n_ajustes n_ajustes

forward prototypes
public function integer of_valida_alumno (long al_cuenta, ref long al_codigo_sp, ref string as_mensaje_sp)
public function integer of_inscripcion_teoria_lab (long al_cuenta, long al_cve_mat, string as_gpo, long al_cve_mat_2, string as_gpo_2, integer ai_inscribe, ref long al_codigo_sp, ref string as_mensaje_sp)
public function integer of_valida_materia_grupo (long al_cuenta, long al_cve_mat, string as_gpo, integer ai_inscribe, ref long al_codigo_sp, ref string as_mensaje_sp)
public function integer of_lleva_teoria_lab (long al_cuenta, long al_cve_mat, string as_gpo, ref long al_cve_mat_2, ref string as_gpo_2, ref integer ai_es_labo)
public function integer of_obten_materia (long al_cve_mat, ref string as_materia)
public function integer of_inscribe_materia_grupo (long al_cuenta, long al_cve_mat, string as_gpo, long al_cve_mat_2, string as_gpo_2, ref long al_codigo_sp, ref string as_mensaje_sp)
public function integer of_obten_carrera_plan (long al_cuenta, ref long al_cve_carrera, ref long al_cve_plan)
public function integer of_obten_seriaciones_materia (long al_cve_mat, long al_cve_carrera, long al_cve_plan)
end prototypes

public function integer of_valida_alumno (long al_cuenta, ref long al_codigo_sp, ref string as_mensaje_sp);//of_valida_alumno
//
//Invoca el stored procedure:
//[sp_valida_alumno_insc]
//Recibe:
//al_cuenta	long
//Devuelve:
//     0 - Todo correcto
//<>0  - Error

long ll_codigo_sp, li_codigo
string ls_mensaje_sp, ls_mensaje

//Declara el stored procedure de validación de alumno
SQLCA.Autocommit = true
DECLARE spvalidaalumno PROCEDURE FOR web_bd.dbo.sp_valida_alumno_insc  @CUENTA = :al_cuenta 
USING sqlca  ;

//Ejectuta el stored procedure
EXECUTE spvalidaalumno ;

li_codigo 	= SQLCA.SqlCode
ls_mensaje = SQLCA.SqlErrText

IF li_codigo = -1 THEN
	MessageBox("Error de ejecución en sp_valida_alumno_insc",ls_mensaje,StopSign! )
	CLOSE spvalidaalumno;
	SQLCA.Autocommit = false
	return -1
END IF


//Lee los valores de retorno correspondientes al número de cuenta
FETCH spvalidaalumno
INTO  :ll_codigo_sp,
		:ls_mensaje_sp;
		
al_codigo_sp = 	ll_codigo_sp
as_mensaje_sp = ls_mensaje_sp


//Cierra el stored procedure
CLOSE spvalidaalumno;

SQLCA.Autocommit = false

RETURN 0



end function

public function integer of_inscripcion_teoria_lab (long al_cuenta, long al_cve_mat, string as_gpo, long al_cve_mat_2, string as_gpo_2, integer ai_inscribe, ref long al_codigo_sp, ref string as_mensaje_sp);//of_inscripcion_teoria_lab
//
//Invoca el stored procedure:
//[[sp_srl_inscripcion_teoria_lab]
//Recibe:
//al_cuenta		long
//al_cve_mat	long
//as_gpo			string
//al_cve_mat_2	long
//as_gpo_2		string
//ai_inscribe		integer
//al_codigo_sp	long
//as_mensaje_sp		string
//Devuelve:
//     0 - Todo correcto
//<>0  - Error

long ll_codigo_sp, li_codigo, li_inscribe =1, li_conmensajes = 0
string ls_mensaje_sp, ls_mensaje, ls_mensaje_output

li_inscribe  = ai_inscribe
SQLCA.Autocommit = true
//Declara el stored proceduresp_srl_validacion_materia_grupo de validación de alumno
DECLARE spinscribeteorialab PROCEDURE FOR sp_ae_inscripcion_teoria_lab  		 @CUENTA = :al_cuenta ,
																										 @CVEMAT1 = :al_cve_mat,          
																										 @GPO1 = :as_gpo,     
																										 @CVEMAT2 = :al_cve_mat_2 ,
																										 @GPO2 = :as_gpo_2,
																										 @MENSAJE= :ls_mensaje_output OUTPUT,
																										 @INSCRIBE =:li_inscribe,
																										 @CONMENSAJES = :li_conmensajes
USING sqlca  ;

//Ejectuta el stored procedure
EXECUTE spinscribeteorialab ;

li_codigo 	= SQLCA.SqlCode
ls_mensaje = SQLCA.SqlErrText

IF li_codigo = -1 THEN
	MessageBox("Error de ejecución en sp_ae_inscripcion_teoria_lab",ls_mensaje,StopSign! )
	CLOSE spinscribeteorialab;
	SQLCA.Autocommit = false
	return -1
END IF


//Lee los valores de retorno correspondientes al número de cuenta
FETCH spinscribeteorialab
INTO  :ll_codigo_sp,
		:ls_mensaje_sp;
		
al_codigo_sp 	= 	ll_codigo_sp
as_mensaje_sp = ls_mensaje_sp


//Cierra el stored procedure
CLOSE spinscribeteorialab;

SQLCA.Autocommit = false

RETURN 0




end function

public function integer of_valida_materia_grupo (long al_cuenta, long al_cve_mat, string as_gpo, integer ai_inscribe, ref long al_codigo_sp, ref string as_mensaje_sp);//of_valida_materia_grupo
//
//Invoca el stored procedure:
//[sp_ae_validacion_materia_grupo]
//Recibe:
//al_cuenta		long
//al_cve_mat	long
//as_gpo			string
//Devuelve:
//     0 - Todo correcto
//<>0  - Error

long ll_codigo_sp, li_codigo, li_inscribe =0, li_conmensajes = 0
string ls_mensaje_sp, ls_mensaje, ls_mensaje_output

li_inscribe = ai_inscribe

SQLCA.Autocommit = true
//Declara el stored procedure de validación de alumno
DECLARE spvalidamateriagpo PROCEDURE FOR controlescolar_bd.dbo.sp_ae_validacion_materia_grupo  @CUENTA = :al_cuenta ,
																										 @MATERIA = :al_cve_mat,     
																										 @GRUPO = :as_gpo ,     
																										 @MENSAJE = :ls_mensaje_output OUTPUT,
																										 @INSCRIBE =:li_inscribe,
																										 @CONMENSAJES  = :li_conmensajes
USING sqlca  ;

//Ejectuta el stored procedure
EXECUTE spvalidamateriagpo ;

li_codigo 	= SQLCA.SqlCode
ls_mensaje = SQLCA.SqlErrText

IF li_codigo = -1 THEN
	MessageBox("Error de ejecución en sp_ae_validacion_materia_grupo",ls_mensaje,StopSign! )
	CLOSE spvalidamateriagpo;
	SQLCA.Autocommit = false
	return -1
END IF


//Lee los valores de retorno correspondientes al número de cuenta
FETCH spvalidamateriagpo
INTO  :ll_codigo_sp,
		:ls_mensaje_sp;
		
al_codigo_sp = 	ll_codigo_sp
as_mensaje_sp = ls_mensaje_sp


//Cierra el stored procedure
CLOSE spvalidamateriagpo;

SQLCA.Autocommit = false

RETURN 0



end function

public function integer of_lleva_teoria_lab (long al_cuenta, long al_cve_mat, string as_gpo, ref long al_cve_mat_2, ref string as_gpo_2, ref integer ai_es_labo);//of_lleva_teoria_lab
//
//Invoca el stored procedure:
//[sp_srl_qLlevaTeoriaLab]
//Recibe:
//al_cuenta		long
//al_cve_mat	long
//as_gpo			string
//al_cve_mat_2	long
//as_gpo_2		string
//ai_es_labo		int
//Devuelve:
//     0 - Todo correcto
//<>0  - Error

long ll_codigo_sp, li_codigo, li_inscribe =1, li_conmensajes = 0, li_from_proc = 0, li_es_labo = 0 
string ls_mensaje_sp, ls_mensaje, ls_mensaje_output

SQLCA.Autocommit = true
//Declara el stored proceduresp_srl_validacion_materia_grupo de validación de alumno
DECLARE spllevateorialab PROCEDURE FOR sp_srl_qLlevaTeoriaLab		  		     @CUENTA 		= :al_cuenta ,
																										 @CLAVE_MAT = :al_cve_mat,         
																										 @GRUPO		= :as_gpo,     
																										 @FROMPROC  = li_from_proc,
																										 @CLAVE2 		= :al_cve_mat_2 output,
																										 @GRUPO2  		= :as_gpo_2 output,
																										 @ES_LABO 	= :ai_es_labo output
USING sqlca  ;

//Ejectuta el stored procedure
EXECUTE spllevateorialab ;

li_codigo 	= SQLCA.SqlCode
ls_mensaje = SQLCA.SqlErrText

IF li_codigo = -1 THEN
	MessageBox("Error de ejecución en sp_srl_qLlevaTeoriaLab",ls_mensaje,StopSign! )
	CLOSE spllevateorialab;
	SQLCA.Autocommit = false
	return -1
END IF


//Lee los valores de retorno correspondientes al número de cuenta
FETCH spllevateorialab
INTO  :al_cve_mat_2,
		:as_gpo_2,
		:ai_es_labo;
		



//Cierra el stored procedure
CLOSE spllevateorialab;

SQLCA.Autocommit = false

RETURN 0




end function

public function integer of_obten_materia (long al_cve_mat, ref string as_materia);//of_obten_materia
//Recibe: al_cve_mat
//Devuelve: as_materia

integer li_codigo_sql
long ll_cve_mat
string ls_mensaje_sql

if al_cve_mat= 0 then
	return 0
end if

SELECT dbo.materias.cve_mat, 
		dbo.materias.materia
INTO	:ll_cve_mat,
		:as_materia
FROM	dbo.materias
WHERE dbo.materias.cve_mat = :al_cve_mat
USING sqlca;

li_codigo_sql = sqlca.SqlCode
ls_mensaje_sql = sqlca.SqlErrText

if li_codigo_sql = 100 or isnull(ll_cve_mat) then
	return 0
elseif li_codigo_sql = -1 then
	MessageBox("Error al consultar materias ", ls_mensaje_sql)
	return -1
end if

return 1



end function

public function integer of_inscribe_materia_grupo (long al_cuenta, long al_cve_mat, string as_gpo, long al_cve_mat_2, string as_gpo_2, ref long al_codigo_sp, ref string as_mensaje_sp);//of_inscribe_materia_grupo
//Recibe:
//al_cuenta			long
//al_cve_mat		long
//as_gpo				string
//al_cve_mat_2		long
//as_gpo_2			string
//al_codigo_sp 		long
//as_mensaje_sp	string

integer li_lleva_teoria_lab,  li_inscribe = 0, li_es_labo, li_valida_materia_grupo, li_valida_materia_grupo_2, li_inscripcion_teoria_lab
long ll_valida_alumno, ll_codigo, ll_codigo_2, ll_cuenta, ll_cve_mat , ll_cve_mat_2
string ls_mensaje, ls_cuenta , ls_cve_mat, ls_gpo, ls_gpo_2

ll_cuenta 	= al_cuenta
ll_cve_mat	= al_cve_mat
ls_gpo		= as_gpo

//Revisa si la materia lleva teoría o laboratorio ligada
li_lleva_teoria_lab = of_lleva_teoria_lab (ll_cuenta, ll_cve_mat, ls_gpo, ll_cve_mat_2, ls_gpo_2, li_es_labo)

//Si la materia 2 es distinta de cero, entonces es un grupo ligado
if ll_cve_mat_2<>0 then
	//Es cero para que se ejecuten como validaciones, sin inscripción
	 li_inscribe = 0
	li_valida_materia_grupo    = of_valida_materia_grupo (ll_cuenta, ll_cve_mat, ls_gpo, li_inscribe, ll_codigo, ls_mensaje)
	//Hay que preguntar el grupo a inscribir de la materia ligada
	//Si es * implica que puede ser en cualquier grupo, de lo contrario tiene que ser un grupo en particular
	if ll_codigo= 0 then
		if ls_gpo_2<>'*' then
			li_valida_materia_grupo_2 = of_valida_materia_grupo (ll_cuenta, ll_cve_mat_2, as_gpo_2, li_inscribe, ll_codigo_2, ls_mensaje)
		else
			//ll_cve_mat_2 se obtiene de un mecanismo de consulta de grupos
			li_valida_materia_grupo_2 = of_valida_materia_grupo (ll_cuenta, ll_cve_mat_2,as_gpo_2, li_inscribe, ll_codigo_2, ls_mensaje)		
		end if
		if ll_codigo_2= 0 then
			//Es uno para que se ejecuten como inscripción
			li_inscribe = 1
			li_inscripcion_teoria_lab = of_inscripcion_teoria_lab(ll_cuenta, ll_cve_mat, ls_gpo, ll_cve_mat_2, as_gpo_2, li_inscribe, ll_codigo, ls_mensaje)
			if ll_codigo<>0 then
				MessageBox("Resultado de inscripción de Teoría-Laboratorio", ls_mensaje+"  ["+string(ll_cve_mat)+"-"+ ls_gpo+"]" +" ["+string(ll_cve_mat_2)+"-"+ as_gpo_2+"]",StopSign!)
				return -1
			end if
		else
			MessageBox("Resultado de validación de materia grupo", ls_mensaje+" ["+string(ll_cve_mat_2)+"-"+ as_gpo_2+"]",StopSign!)
			return -1
		end if
	else
		MessageBox("Resultado de validación de materia grupo", ls_mensaje+" ["+string(ll_cve_mat)+"-"+ ls_gpo+"]",StopSign!)
		return -1
	end if
else
//Solo se require validar	la materia antes de inscribir
	//Es cero para que se ejecuten como validaciones, sin inscripción
	 li_inscribe = 0
	li_valida_materia_grupo    = of_valida_materia_grupo (ll_cuenta, ll_cve_mat, ls_gpo, li_inscribe, ll_codigo, ls_mensaje)
	if ll_codigo= 0 then
		//Es uno para que se ejecuten como inscripción
		li_inscribe = 1
		li_valida_materia_grupo    = of_valida_materia_grupo (ll_cuenta, ll_cve_mat, ls_gpo, li_inscribe, ll_codigo, ls_mensaje)
		if ll_codigo<>0 then
			al_codigo_sp = ll_codigo
			as_mensaje_sp = ls_mensaje
			MessageBox("Resultado de inscripción de Materia Grupo", ls_mensaje,StopSign!)
			return -1
		end if
	else
		MessageBox("Resultado de validación de materia grupo", ls_mensaje+" ["+string(ll_cve_mat)+"-"+ ls_gpo+"]",StopSign!)
		return -1
	end if
end if

return 0


end function

public function integer of_obten_carrera_plan (long al_cuenta, ref long al_cve_carrera, ref long al_cve_plan);//of_obten_carrera_plan
//Recibe: al_cuenta				long
//Devuelve: al_cve_carrera		long
//				al_cve_plan			long
//integer

integer li_codigo_sql
long ll_cve_mat, ll_cve_carrera, ll_cve_plan
string ls_mensaje_sql

if al_cuenta= 0 then
	return 0
end if

SELECT dbo.academicos.cve_carrera, 
		dbo.academicos.cve_plan
INTO	:ll_cve_carrera, 
		:ll_cve_plan
FROM	dbo.academicos
WHERE dbo.academicos.cuenta = :al_cuenta
USING sqlca;

li_codigo_sql = sqlca.SqlCode
ls_mensaje_sql = sqlca.SqlErrText

if li_codigo_sql = 100 or isnull(ll_cve_carrera) then
	return 0
elseif li_codigo_sql = -1 then
	MessageBox("Error al consultar academicos ", ls_mensaje_sql)
	return -1
end if
al_cve_carrera = ll_cve_carrera
al_cve_plan = ll_cve_plan

return 1
end function

public function integer of_obten_seriaciones_materia (long al_cve_mat, long al_cve_carrera, long al_cve_plan);//of_obten_seriaciones_materia
//Recibe: al_cve_mat			long
//			al_cve_carrera		long
//			al_cve_plan			long
//Devuelve: integer

integer li_codigo_sql, li_num_seriaciones
long ll_cve_mat, ll_cve_carrera, ll_cve_plan
string ls_mensaje_sql

if al_cve_mat= 0 then
	return 0
end if

select count(*) 
into	:li_num_seriaciones
from prerrequisitos
where cve_prerreq = :al_cve_mat
and cve_carrera = :al_cve_carrera
and cve_plan = :al_cve_plan
USING sqlca;

li_codigo_sql = sqlca.SqlCode
ls_mensaje_sql = sqlca.SqlErrText

if li_codigo_sql = 100 or isnull(li_num_seriaciones) then
	return 0
elseif li_codigo_sql = -1 then
	MessageBox("Error al consultar prerrequisitos ", ls_mensaje_sql)
	return -1
end if

return li_num_seriaciones


end function

on n_ajustes.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_ajustes.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

