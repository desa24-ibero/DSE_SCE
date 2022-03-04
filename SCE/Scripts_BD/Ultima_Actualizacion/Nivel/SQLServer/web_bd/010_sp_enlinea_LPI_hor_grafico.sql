USE [web_bd]
GO
/****** Object:  StoredProcedure [dbo].[sp_enlinea_LPI_hor_grafico]    Script Date: 9/8/2017 15:42:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[sp_enlinea_LPI_hor_grafico] 
@a_cuenta integer,
@a_hash varchar(50),
@a_ip varchar(50),
@CONMENSAJES int = 0
AS
declare 
@ls_mensaje_error varchar(255),
@ll_num_error integer,
@ll_resultado integer,
@curl_cuenta integer,
@num_error integer,
@mensaje_error varchar(255),
@ll_rowcount_materia integer,
@ll_hora_menor integer,
@ll_hora_mayor integer,
@ll_cve_dia_menor integer,
@ll_cve_dia_mayor integer,
@ll_indice_horario integer,
@ll_indice_dia integer,
@ll_cve_mat_actual integer,
@ll_cve_mat_existente integer,
@ls_gpo_actual varchar(3),
@ls_gpo_existente varchar(3),
@ll_rowcount_horario_actual integer,
@ll_rowcount_horario_actual_2 integer,
@ll_rowcount_horario_existente integer
DECLARE @ANIO int, @PERIODO int
DECLARE @t_hora table (hora int)
DECLARE @t_pvt  table (hora int ,cve_dia int, cve_mat int, gpo varchar(02))
DECLARE @hi int


--NVO COD.
DECLARE @horario varchar(30),
		@lunes varchar(5),
		@martes varchar(5),
		@miercoles varchar(5),
		@jueves varchar(5),
		@viernes varchar(5),
		@sabado varchar(5)

--NVO COD.
DECLARE @t_hrspre table (horario varchar(30), lunes varchar(255) null, martes varchar(255) null, miercoles varchar(255) null, jueves varchar(255) null, viernes varchar(255) null, sabado varchar(255) null)
--DECLARE @t_gpomat table (hora int, cve_dia int, cve_gposmats varchar(255))
DECLARE @hora_aux1 int, @cve_dia_aux1 int, @cve_mat_aux1 varchar(5), @gpo_aux1 varchar(02), @cve_gposmats varchar(255)
--DECLARE @hora_aux2 int, @cve_dia_aux2 int
DECLARE @horario_mul varchar(30), @hora_ini_mul int, @cve_dia_mul int
DECLARE 
@ll_MATS_rowcount integer,
@li_codigo_proc integer,
@ls_mensaje_proc varchar(255)

/*****************************************/
-- MALH 08/08/2017
/*Se recupera el tipo de periodo asocuado al plan de estudios de la cuenta*/
DECLARE @VAR_cve_carrera INTEGER
DECLARE @VAR_cve_plan INTEGER
DECLARE @VAR_tipo_periodo VARCHAR(3)

/* Se recuperan la cerrera y el plan.*/
SELECT @VAR_cve_carrera = web_bd.dbo.v_www_academicos.cve_carrera, 
	   @VAR_cve_plan = web_bd.dbo.v_www_academicos.cve_plan
FROM web_bd.dbo.v_www_academicos
WHERE cuenta = @a_cuenta

/* Se recupera el tipo de periodo.*/
SELECT @VAR_tipo_periodo = web_bd.dbo.v_www_plan_estudios.tipo_periodo
FROM web_bd.dbo.v_www_plan_estudios
WHERE web_bd.dbo.v_www_plan_estudios.cve_carrera = @VAR_cve_carrera
AND web_bd.dbo.v_www_plan_estudios.cve_plan = @VAR_cve_plan  
/*****************************************/

exec [sp_enlinea_LPI_valida_exec] 
@a_stored_procedure = 'sp_enlinea_LPI_hor_grafico',
@a_cuenta = @a_cuenta,
@a_hash = @a_hash ,
@a_ip = @a_ip ,
@CONMENSAJES = @CONMENSAJES,
@a_CODIGO = @li_codigo_proc  OUTPUT,
@a_MENSAJE  = @ls_mensaje_proc OUTPUT


IF @li_codigo_proc = -1 
BEGIN
	SET @ll_num_error = -1
	SET @ls_mensaje_error= @ls_mensaje_proc
	IF @CONMENSAJES <> 0 print @ls_mensaje_error
	Goto EtiquetaError
END

--SI TODO FUE CORRECTO
SELECT @ll_num_error = 0,
@ls_mensaje_error = 'OK'
SELECT @num_error = @ll_num_error, @mensaje_error = @ls_mensaje_error



SET @hi = 7
SELECT	@ANIO = anio ,@PERIODO = periodo
FROM	controlescolar_bd.dbo.activacion 
WHERE tipo_periodo = @VAR_tipo_periodo -- MALH 08/08/2017 -> SE AGREGA CONDICION "WHERE"


/*LLENAR VARIABLE TIPO TABLA CON VALORES DE 7 A 21*/
WHILE @hi < 22
BEGIN
 INSERT INTO @t_hora values(@hi)
 SET	@hi = @hi + 1
END

/*LLENAR VARIABLE TIPO TABLA CON UN REGISTRO POR HORA, MATERIA Y DIA*/
INSERT	INTO @t_pvt
SELECT	distinct hr.hora, hor.cve_dia, mi.cve_mat, mi.gpo
FROM	controlescolar_bd.dbo.mat_inscritas mi
		
		inner join controlescolar_bd.dbo.grupos grp WITH (NOLOCK) on
		mi.cve_mat	= grp.cve_mat
	and mi.gpo 		= grp.gpo
	and mi.cuenta = @a_cuenta
	and mi.periodo   = grp.periodo
	and mi.anio   = grp.anio

		inner join controlescolar_bd.dbo.horario hor on
		grp.anio	= hor.anio
	and	grp.periodo	= hor.periodo
	and	((grp.cve_mat = hor.cve_mat and grp.gpo = hor.gpo) 

			or 
		 (grp.cve_asimilada = hor.cve_mat and grp.gpo_asimilado = hor.gpo))
		
		inner join @t_hora as hr  on
		hr.hora between hor.hora_inicio and hor.hora_final - 1

select @ll_hora_menor = 7, @ll_hora_mayor = 21, 
	@ll_cve_dia_menor = 1, @ll_cve_dia_mayor =6,
	@ll_indice_horario =7, @ll_indice_dia =1




INSERT INTO @t_hrspre
SELECT	case len(cast(hrr.hora as varchar(5)) ) 
		 when 1 then '0'+convert(varchar(5),(hrr.hora))  
		 else cast(hrr.hora as varchar(5))  end
		+' - '+ 
		case len(cast(hrr.hora + 1 as varchar(5)) )
		 when 1 then '0' +cast(hrr.hora + 1 as varchar(5))  
		 else cast(hrr.hora + 1 as varchar(5))  end  as horario,
		
		case count(case cve_dia when 1 then cve_mat else null end)
		when 1 then cast((select convert(varchar(05), cve_mat) + '-' + gpo from @t_pvt as ti where cve_dia = 1 and hrr.hora = ti.hora) as varchar(30)) 
		when 0 then '' 
		else '****' end as Lunes,
		
		case count(case cve_dia when 2 then cve_mat else null end)
		when 1 then cast((select convert(varchar(05), cve_mat) + '-' + gpo from @t_pvt as ti where cve_dia = 2 and hrr.hora = ti.hora) as varchar(30)) 
		when 0 then ''
		else '****' end as Martes,
		
		case count(case cve_dia when 3 then cve_mat else null end)
		when 1 then cast((select convert(varchar(05), cve_mat) + '-' + gpo from @t_pvt as ti where cve_dia = 3 and hrr.hora = ti.hora) as varchar(30)) 
		when 0 then ''
		else '****' end as Miercoles,
		
		case count(case cve_dia when 4 then cve_mat else null end)
		when 1 then cast((select convert(varchar(05), cve_mat) + '-' + gpo from @t_pvt as ti where cve_dia = 4 and hrr.hora = ti.hora) as varchar(30)) 
		when 0 then ''
		else '****' end as Jueves,
		
		case count(case cve_dia when 5 then cve_mat else null end) 
		when 1 then  cast((select convert(varchar(05), cve_mat) + '-' + gpo from @t_pvt as ti where cve_dia = 5 and hrr.hora = ti.hora) as varchar(30)) 
		when 0 then ''
		else '****' end as Viernes,
		
		case count(case cve_dia when 6 then cve_mat else null end)
		when 1 then  cast((select convert(varchar(05), cve_mat) + '-' + gpo from @t_pvt as ti where cve_dia = 6 and hrr.hora = ti.hora) as varchar(30)) 
		when 0 then ''
		else '****' end as Sabado

FROM	@t_pvt as pvt 
		right outer join @t_hora as hrr on
		pvt.hora = hrr.hora
GROUP BY	hrr.hora


--SELECT * FROM @t_hrspre

DECLARE v_cur_materias_mult CURSOR FOR
SELECT horario, convert(int, LEFT(horario,2)) as hora_ini, 1 as cve_dia
  FROM @t_hrspre
 WHERE lunes = '****'
 UNION
SELECT horario, convert(int, LEFT(horario,2)) as hora_ini, 2 as cve_dia
  FROM @t_hrspre
 WHERE martes = '****'
 UNION
SELECT horario, convert(int, LEFT(horario,2)) as hora_ini, 3 as cve_dia
  FROM @t_hrspre
 WHERE miercoles = '****'
 UNION
SELECT horario, convert(int, LEFT(horario,2)) as hora_ini, 4 as cve_dia
  FROM @t_hrspre
 WHERE jueves = '****'
 UNION
SELECT horario, convert(int, LEFT(horario,2)) as hora_ini, 5 as cve_dia
  FROM @t_hrspre
 WHERE viernes = '****'
 UNION
SELECT horario, convert(int, LEFT(horario,2)) as hora_ini, 6 as cve_dia
  FROM @t_hrspre
 WHERE sabado = '****'
ORDER BY 3,2

OPEN v_cur_materias_mult

FETCH v_cur_materias_mult
INTO @horario_mul, @hora_ini_mul, @cve_dia_mul

WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT @cve_gposmats = ''

	DECLARE v_cur_gpomat CURSOR FOR
	select hora, cve_dia, cve_mat, gpo
	from @t_pvt
	WHERE hora = @hora_ini_mul
	AND cve_dia = @cve_dia_mul

	OPEN v_cur_gpomat

	FETCH v_cur_gpomat
	INTO @hora_aux1, @cve_dia_aux1, @cve_mat_aux1, @gpo_aux1

	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		IF LEN(@cve_gposmats)>0 
		BEGIN
			SELECT @cve_gposmats = @cve_gposmats + ' | '
		END
		SELECT @cve_gposmats = @cve_gposmats + @cve_mat_aux1 + '-' +  + @gpo_aux1

	FETCH v_cur_gpomat
	INTO @hora_aux1, @cve_dia_aux1, @cve_mat_aux1, @gpo_aux1

	END

	-- SE ACTUALIZAN LAS MATERIAS-GRUPO MULTIPLE DE C/U DE LOS HORARIOS DE LA SEMANA
	IF @cve_dia_mul = 1
	BEGIN
		UPDATE @t_hrspre
		   SET lunes = @cve_gposmats
		 WHERE horario = @horario_mul
	END

	IF @cve_dia_mul = 2
	BEGIN
		UPDATE @t_hrspre
		   SET martes = @cve_gposmats
		 WHERE horario = @horario_mul
	END

	IF @cve_dia_mul = 3
	BEGIN
		UPDATE @t_hrspre
		   SET miercoles = @cve_gposmats
		 WHERE horario = @horario_mul
	END

	IF @cve_dia_mul = 4
	BEGIN
		UPDATE @t_hrspre
		   SET jueves = @cve_gposmats
		 WHERE horario = @horario_mul
	END

	IF @cve_dia_mul = 5
	BEGIN
		UPDATE @t_hrspre
		   SET viernes = @cve_gposmats
		 WHERE horario = @horario_mul
	END

	IF @cve_dia_mul = 6
	BEGIN
		UPDATE @t_hrspre
		   SET sabado = @cve_gposmats
		 WHERE horario = @horario_mul
	END

	CLOSE v_cur_gpomat	
	DEALLOCATE v_cur_gpomat
	-- FIN CURSOR MATERIAS CONCATENADAS

FETCH v_cur_materias_mult
INTO @horario_mul, @hora_ini_mul, @cve_dia_mul
END

CLOSE v_cur_materias_mult	
DEALLOCATE v_cur_materias_mult
-- FIN CURSOR v_cur_materias_mult

SELECT CODIGO = @ll_num_error, MENSAJE =@ls_mensaje_error,  *
FROM @t_hrspre

--SELECT *
--FROM @t_gpomat


--SELECT * FROM @t_hora

--SELECT * FROM @t_pvt

Fin:
 
EtiquetaCorrecto:
 --Commit Transaction
 return 0
 
EtiquetaError:
  --raiserror ('%d, %s.',16, 1,@ll_num_error, @ls_mensaje_error)
  SELECT CODIGO = @ll_num_error, MENSAJE =@ls_mensaje_error,  
  horario= NULL, lunes= NULL, martes= NULL, miercoles= NULL, jueves= NULL , viernes = NULL, sabado = NULL



 --Rollback Transaction
 return -1

