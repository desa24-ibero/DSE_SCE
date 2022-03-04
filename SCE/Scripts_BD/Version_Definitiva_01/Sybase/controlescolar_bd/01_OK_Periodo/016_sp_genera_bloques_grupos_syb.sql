USE controlescolar_bd
go


IF OBJECT_ID ('dbo.sp_genera_bloques_grupos') IS NOT NULL
	DROP PROCEDURE dbo.sp_genera_bloques_grupos
GO

create procedure sp_genera_bloques_grupos
	@periodo tinyint = null,									
	@anio smallint = null,
	@tamanio_bloque smallint = null
as

declare	

@num_error				integer,
@mensaje_error			varchar(255),
@cur_cve_mat			integer,
@cur_gpo				varchar(2),
@cur_cve_coordinacion	integer,
@cur_cve_dia			integer,
@cur_hora_inicio		integer,
@cur_hora_final			integer,
@cur_clase_aula			integer,
@resultado				integer,
@var_hora_inicio		integer,
@var_cve_dia			integer,
@var_cve_dia_final		integer,
@var_cve_hora			integer,
@var_cve_hora_final		integer,
@cupo_cero				integer,
@num_aulas_inicial		integer,
@clase_aula_cero		integer,
@num_aulas_cero			integer,
@cur2_cve_coordinacion	integer,
@periodo_mi				integer,
@anio_mi				integer,
@min_clase_aula			integer,
@max_clase_aula			integer,
@var_clase_aula			integer,
@var_hra_inicio_vesp    integer,
@var_ult_hra_inicio_mat INTEGER, 
@tipo_periodo VARCHAR(3) 

BEGIN TRANSACTION

--IF EXISTS ( select * from tempdb..sysobjects where name = 'grupos_clase' and type = 'U' )
--BEGIN
--    DROP TABLE tempdb..grupos_clase
--END

--delete From    tempdb..grupos_clase

if @periodo in (null)
begin
	select @num_error = 20000, @mensaje_error = 'Es necesario dar el periodo origen'
	Goto EtiquetaError
end

if @anio in (null)
begin
	select @num_error = 20000, @mensaje_error = 'Es necesario dar el anio origen'
	Goto EtiquetaError
end

-- Obtener la ultima hora de inicio del turno matutino, y la hora de inicio del turno vespertino ...
Select  @var_ult_hra_inicio_mat = ultima_hra_inicio_matutino,
        @var_hra_inicio_vesp = hora_inicio_vespertino
From    parametros_grupo_clase
Where   cve_parametros_grupo_clase = 1

-- Obtiene el tipo de periodo del periodo recibido como parámetro.
SELECT @tipo_periodo = tipo 
FROM periodo WHERE periodo = @periodo 


--Obtiene el periodo de materias inscritas
select	@periodo_mi = periodo,
		@anio_mi = anio
from	periodos_por_procesos
where	cve_proceso = 5 
AND tipo_periodo = @tipo_periodo 



--Obtiene el rango de aulas dependiendo de la clase_aula
select	@min_clase_aula = min(clase),
		@max_clase_aula = max(clase)
from	clase_aula


create table tempdb..grupos_clase
(
cve_mat					integer not null, 
gpo						varchar(2) not null,
cve_coordinacion		integer not null,
cve_dia					integer not null,
hora_inicio				integer not null,
hora_final				integer not null,
clase_aula				integer not null,
cve_tipo_grupo_clase	integer not null,
num_horas				integer null,
num_bloques				float null,
num_inscritos			integer null
)



create unique index idx_gpo_clase
on tempdb..grupos_clase(cve_mat, gpo, cve_coordinacion, cve_dia, hora_inicio, hora_final, clase_aula, cve_tipo_grupo_clase)

-- Horarios, materias, coordinaciones y grupos del periodo elegido
-- que tienen asignado una clase_aula de tipo salon en su horario
-- Si el periodo origen es el actual el cursor debe apuntar a las tablas de grupos y horario

-- Se insertan todos los registros que se encuentran en los horarios y grupos definidos ...
if (@periodo_mi = @periodo and @anio_mi = @anio)
begin
	INSERT INTO  tempdb..grupos_clase
	(
		cve_mat,
		gpo,
		cve_coordinacion,
		cve_dia,
		hora_inicio,
		hora_final,
		clase_aula, 
		cve_tipo_grupo_clase,
		num_inscritos
	)
	SELECT	g.cve_mat, 
			g.gpo, 
			m.cve_coordinacion, 
			h.cve_dia, 
			h.hora_inicio,
			h.hora_final,
			h.clase_aula,
			9999,
			g.inscritos
	FROM 	grupos g,
			horario h,
			materias m,
			coordinaciones c
	WHERE	g.cve_mat = h.cve_mat
	AND		g.gpo = h.gpo
	AND		g.periodo = h.periodo
	AND		g.anio = h.anio
	AND		g.cve_mat = m.cve_mat
	AND		m.cve_coordinacion =c.cve_coordinacion
	AND		g.anio = @anio
	AND		g.periodo = @periodo
	AND		g.cond_gpo = 1
	AND		g.gpo not in ('ZZ')
	GROUP BY g.cve_mat, g.gpo, m.cve_coordinacion, h.cve_dia, h.hora_inicio, h.hora_final, h.clase_aula, g.inscritos
	--  ORDER BY m.cve_coordinacion, h.cve_dia, h.hora_inicio, h.hora_final, h.clase_aula, g.inscritos
end
else
--Si el periodo origen es distinto al actual el cursor debe apuntar a las tablas de hist_grupos e hist_horario
begin
	INSERT INTO  tempdb..grupos_clase
	(
		cve_mat,
		gpo,
		cve_coordinacion,
		cve_dia,
		hora_inicio,
		hora_final,
		clase_aula, 
		cve_tipo_grupo_clase,
		num_inscritos
	)
	SELECT	g.cve_mat, 
			g.gpo, 
			m.cve_coordinacion, 
			h.cve_dia, 
			h.hora_inicio,
			h.hora_final,
			h.clase_aula,
			9999,
			g.inscritos
	FROM 	hist_grupos g,
			hist_horario h,
			materias m,
			coordinaciones c
	WHERE	g.cve_mat = h.cve_mat
	AND		g.gpo = h.gpo
	AND		g.periodo = h.periodo
	AND		g.anio = h.anio
	AND		g.cve_mat = m.cve_mat
	AND		m.cve_coordinacion =c.cve_coordinacion
	AND		g.anio = @anio
	AND		g.periodo = @periodo
	AND		g.cond_gpo = 1
	AND		g.gpo not in ('ZZ')
	GROUP BY g.cve_mat, g.gpo, m.cve_coordinacion, h.cve_dia, h.hora_inicio, h.hora_final, h.clase_aula, g.inscritos
	--  ORDER BY m.cve_coordinacion, h.cve_dia, h.hora_inicio, h.hora_final, h.clase_aula, g.inscritos
end

Select  @resultado = Count ( * )
From    tempdb..grupos_clase

IF @resultado = 0
BEGIN
    Select @num_error = 20000
    Select @mensaje_error = 'No exíste información para el año ' + Convert ( Varchar ( 4 ) , @anio ) + ' y periodo ' + Convert ( Varchar ( 1 ) , @periodo )
    GoTo EtiquetaError
END
--Goto Resultado

-- Se insertan todos los registros que se encuentran en los horarios y grupos definidos
-- y que el horario coincida con los horarios marcados en grupo_clase_base, los registros 
-- resultantes se almacenarán con cve_tipo_grupo_clase = 1 (BLOQUE MODELO )

if (@periodo_mi = @periodo and @anio_mi = @anio)
begin
	INSERT INTO  tempdb..grupos_clase
	(
		cve_mat,
		gpo,
		cve_coordinacion,
		cve_dia,
		hora_inicio,
		hora_final,
		clase_aula, 
		cve_tipo_grupo_clase,
		num_inscritos
	)
	SELECT	g.cve_mat, 
			g.gpo, 
			m.cve_coordinacion, 
			h.cve_dia, 
			h.hora_inicio,
			h.hora_final,
			h.clase_aula,
			1,
			g.inscritos
	FROM	grupos g,
			horario h,
			materias m,
			coordinaciones c,
			grupo_clase_base gcb
	WHERE	g.cve_mat = h.cve_mat
	AND		g.gpo = h.gpo
	AND		g.periodo = h.periodo
	AND		g.anio = h.anio
	AND		g.cve_mat = m.cve_mat
	AND		m.cve_coordinacion =c.cve_coordinacion
	AND		g.anio = @anio
	AND		g.periodo = @periodo
	AND		g.cond_gpo = 1
	AND		g.gpo not in ('ZZ')
	AND		h.hora_inicio = gcb.hora_inicio
	AND		h.hora_final = gcb.hora_final
	GROUP BY g.cve_mat, g.gpo, m.cve_coordinacion, h.cve_dia, h.hora_inicio, h.hora_final, h.clase_aula, g.inscritos

--  ORDER BY m.cve_coordinacion, h.cve_dia, h.hora_inicio, h.hora_final, h.clase_aula

end

else
--Si el periodo origen es distinto al actual el cursor debe apuntar a las tablas de hist_grupos e hist_horario
begin

	INSERT INTO  tempdb..grupos_clase
	(
		cve_mat,
		gpo,
		cve_coordinacion,
		cve_dia,
		hora_inicio,
		hora_final,
		clase_aula, 
		cve_tipo_grupo_clase,
		num_inscritos
	)
	SELECT	g.cve_mat, 
			g.gpo, 
			m.cve_coordinacion, 
			h.cve_dia, 
			h.hora_inicio,
			h.hora_final,
			h.clase_aula,
			1,
			g.inscritos
	FROM 	hist_grupos g,
			hist_horario h,
			materias m,
			coordinaciones c,
			grupo_clase_base gcb
	WHERE	g.cve_mat = h.cve_mat
	AND		g.gpo = h.gpo
	AND		g.periodo = h.periodo
	AND		g.anio = h.anio
	AND		g.cve_mat = m.cve_mat
	AND		m.cve_coordinacion =c.cve_coordinacion
	AND		g.anio = @anio
	AND		g.periodo = @periodo
	AND		g.cond_gpo = 1
	AND		g.gpo not in ('ZZ')
	AND		h.hora_inicio = gcb.hora_inicio
	AND		h.hora_final = gcb.hora_final
	GROUP BY g.cve_mat, g.gpo, m.cve_coordinacion, h.cve_dia, h.hora_inicio, h.hora_final, h.clase_aula, g.inscritos
--  ORDER BY m.cve_coordinacion, h.cve_dia, h.hora_inicio, h.hora_final, h.clase_aula

end



-- Calcular el número de horas de cada registro ...
UPDATE tempdb..grupos_clase
SET num_horas = hora_final - hora_inicio

-- Calcular el número de bloques de cada registro ...
UPDATE tempdb..grupos_clase
SET num_bloques = convert(float,num_horas) /convert(float,@tamanio_bloque)

--CLASIFICA LOS GRUPOS EN FUNCIÓN DEL TIPO DE GRUPO CLASE
--tipo_grupo_clase
--1 BASE - RECOMENDADO pasa a ser:
--1	 BLOQUE MODELO
--2	 BASE - EXTENDIDO
--3 BLOQUE FUERA DE MODELO
--4 TRANSGREDE FINAL
--5	 TRANSGREDE INICIO Y FINAL
--6	 EXTENDIDO PERO TRANSGREDE POR HORAS IMPARES
--7	 GRUPOS DE HORA INICIO DE 13 O 14 HRS Y QUE NO TERMINAN EN HORARIO MARCADO

--select '*'
--TODOS LOS GRUPOS CON TRANSGRESIÓN
--SELECT  * 
--FROM tempdb..grupos_clase gc1
--WHERE NOT EXISTS(SELECT * FROM tempdb..grupos_clase gc2
--WHERE gc1.cve_mat = gc2.cve_mat
--AND	gc1.gpo = gc2.gpo
--AND	gc1.cve_coordinacion = gc2.cve_coordinacion
--AND	gc1.cve_dia = gc2.cve_dia
--AND	gc1.hora_inicio = gc2.hora_inicio
--AND	gc1.hora_final = gc2.hora_final
--AND	gc1.clase_aula = gc2.clase_aula 
--AND   gc2.cve_tipo_grupo_clase = 1
--)
--AND gc1.cve_tipo_grupo_clase = 9999

--3 TRANSGREDE INICIO pasa a ser:
--2	 BLOQUE FUERA DE MODELO
--TODOS LOS GRUPOS CON TRANSGRESIÓN EN HORA INICIO PERO NO EN HORA FINAL
--(YA NO) EXCLUYENDO CLASES DE HORA INICIO DE 13 O 14 HRS
UPDATE	tempdb..grupos_clase
SET		cve_tipo_grupo_clase = 2
FROM	tempdb..grupos_clase gc1
WHERE	NOT EXISTS	(
					SELECT	* 
					FROM	tempdb..grupos_clase gc2
					WHERE	gc1.cve_mat = gc2.cve_mat
					AND		gc1.gpo = gc2.gpo
					AND		gc1.cve_coordinacion = gc2.cve_coordinacion
					AND		gc1.cve_dia = gc2.cve_dia
					AND		gc1.hora_inicio = gc2.hora_inicio
					AND		gc1.hora_final = gc2.hora_final
					AND		gc1.clase_aula = gc2.clase_aula 
					AND		gc2.cve_tipo_grupo_clase = 1
					)
AND		gc1.cve_tipo_grupo_clase = 9999
--comentado para no considerar mediodia AND		gc1.hora_inicio NOT IN (@var_ult_hra_inicio_mat , @var_hra_inicio_vesp)
AND		gc1.hora_inicio NOT IN (SELECT hora_inicio FROM grupo_clase_base)
AND		gc1.hora_final IN (SELECT hora_final FROM grupo_clase_base)

--SELECT * FROM tempdb..grupos_clase
--WHERE cve_tipo_grupo_clase = 2
--select '4	TRANSGREDE FINAL'

--4	 TRANSGREDE FINAL pasa a ser
--2 BLOQUE FUERA DE MODELO
--TODOS LOS GRUPOS CON TRANSGRESIÓN EN HORA FINAL PERO NO EN HORA INICIO
--(YA NO )EXCLUYENDO CLASES DE HORA INICIO DE 13 O 14 HRS

UPDATE	tempdb..grupos_clase
SET		cve_tipo_grupo_clase = 2
FROM	tempdb..grupos_clase gc1
WHERE	NOT EXISTS	(
					SELECT	*
					FROM	tempdb..grupos_clase gc2
					WHERE	gc1.cve_mat = gc2.cve_mat
					AND		gc1.gpo = gc2.gpo
					AND		gc1.cve_coordinacion = gc2.cve_coordinacion
					AND		gc1.cve_dia = gc2.cve_dia
					AND		gc1.hora_inicio = gc2.hora_inicio
					AND		gc1.hora_final = gc2.hora_final
					AND		gc1.clase_aula = gc2.clase_aula 
					AND		gc2.cve_tipo_grupo_clase = 1
					)
AND		gc1.cve_tipo_grupo_clase = 9999
--AND		gc1.hora_inicio NOT IN (@var_ult_hra_inicio_mat , @var_hra_inicio_vesp)
AND		gc1.hora_inicio IN (SELECT hora_inicio FROM grupo_clase_base)
AND		gc1.hora_final NOT IN (SELECT hora_final FROM grupo_clase_base)

--SELECT * FROM tempdb..grupos_clase
--WHERE cve_tipo_grupo_clase = 4
--select '5	TRANSGREDE INICIO Y FINAL'

--5	TRANSGREDE INICIO Y FINAL pasa a ser:
--2 BLOQUE FUERA DE MODELO
--TODOS LOS GRUPOS CON TRANSGRESIÓN EN HORA INICIO Y EN HORA FINAL
--/YA NO) EXCLUYENDO CLASES DE HORA INICIO DE 13 O 14 HRS

UPDATE	tempdb..grupos_clase
SET		cve_tipo_grupo_clase = 2
FROM	tempdb..grupos_clase gc1
WHERE	NOT EXISTS	(
					SELECT	*
					FROM	tempdb..grupos_clase gc2
					WHERE	gc1.cve_mat = gc2.cve_mat
					AND		gc1.gpo = gc2.gpo
					AND		gc1.cve_coordinacion = gc2.cve_coordinacion
					AND		gc1.cve_dia = gc2.cve_dia
					AND		gc1.hora_inicio = gc2.hora_inicio
					AND		gc1.hora_final = gc2.hora_final
					AND		gc1.clase_aula = gc2.clase_aula 
					AND		gc2.cve_tipo_grupo_clase = 1
					)
AND		gc1.cve_tipo_grupo_clase = 9999
--AND		gc1.hora_inicio NOT IN (@var_ult_hra_inicio_mat , @var_hra_inicio_vesp)
AND		gc1.hora_inicio NOT IN (SELECT hora_inicio FROM grupo_clase_base)
AND		gc1.hora_final NOT IN (SELECT hora_final FROM grupo_clase_base)

--SELECT * FROM tempdb..grupos_clase
--WHERE cve_tipo_grupo_clase = 5

--7	GRUPOS DE HORA INICIO DE 13 O 14 HRS Y QUE NO TERMINAN EN HORARIO MARCADO pasa a ser:
--2 BLOQUE FUERA DE MODELO
--select 'GRUPOS DE HORA INICIO DE 13 O 14 HRS Y QUE NO TERMINAN EN HORARIO MARCADO'

--GRUPOS DE HORA INICIO DE 13 O 14 HRS Y QUE NO TERMINAN EN HORARIO MARCADO
UPDATE	tempdb..grupos_clase
SET		cve_tipo_grupo_clase = 2
FROM	tempdb..grupos_clase gc1
WHERE	NOT EXISTS	(
					SELECT	*
					FROM	tempdb..grupos_clase gc2
					WHERE	gc1.cve_mat = gc2.cve_mat
					AND		gc1.gpo = gc2.gpo
					AND		gc1.cve_coordinacion = gc2.cve_coordinacion
					AND		gc1.cve_dia = gc2.cve_dia
					AND		gc1.hora_inicio = gc2.hora_inicio
					AND		gc1.hora_final = gc2.hora_final
					AND		gc1.clase_aula = gc2.clase_aula 
					AND		gc2.cve_tipo_grupo_clase = 1
					)
AND		gc1.cve_tipo_grupo_clase = 9999
AND		gc1.hora_inicio IN (@var_ult_hra_inicio_mat , @var_hra_inicio_vesp)

--SELECT  * 
--FROM tempdb..grupos_clase gc1
--WHERE cve_tipo_grupo_clase = 7

--6	EXTENDIDO PERO TRANSGREDE POR HORAS IMPARES  pasa a ser:
--2 BLOQUE FUERA DE MODELO
--select 'EXTENDIDO PERO TRANSGREDE POR HORAS IMPARES'

--EXTENDIDO PERO TRANSGREDE POR HORAS IMPARES
UPDATE	tempdb..grupos_clase
SET		cve_tipo_grupo_clase = 2
FROM	tempdb..grupos_clase gc1
WHERE	NOT EXISTS	(
					SELECT	*
					FROM	tempdb..grupos_clase gc2
					WHERE	gc1.cve_mat = gc2.cve_mat
					AND		gc1.gpo = gc2.gpo
					AND		gc1.cve_coordinacion = gc2.cve_coordinacion
					AND		gc1.cve_dia = gc2.cve_dia
					AND		gc1.hora_inicio = gc2.hora_inicio
					AND		gc1.hora_final = gc2.hora_final
					AND		gc1.clase_aula = gc2.clase_aula 
					AND		gc2.cve_tipo_grupo_clase = 1
					)
AND		gc1.cve_tipo_grupo_clase = 9999
--AND		gc1.hora_inicio NOT IN (@var_ult_hra_inicio_mat , @var_hra_inicio_vesp)
AND		gc1.num_bloques <> ROUND(num_bloques,0)

--SELECT  * 
--FROM tempdb..grupos_clase gc1
--WHERE cve_tipo_grupo_clase = 6

--2	BASE - EXTENDIDO pasa a ser:
--1 BLOQUE MODELO
--select 'BASE - EXTENDIDO'

--BASE - EXTENDIDO''
UPDATE	tempdb..grupos_clase
SET		cve_tipo_grupo_clase = 1
FROM	tempdb..grupos_clase gc1
WHERE	NOT EXISTS	(
					SELECT	*
					FROM	tempdb..grupos_clase gc2
					WHERE	gc1.cve_mat = gc2.cve_mat
					AND		gc1.gpo = gc2.gpo
					AND		gc1.cve_coordinacion = gc2.cve_coordinacion
					AND		gc1.cve_dia = gc2.cve_dia
					AND		gc1.hora_inicio = gc2.hora_inicio
					AND		gc1.hora_final = gc2.hora_final
					AND		gc1.clase_aula = gc2.clase_aula 
					AND		gc2.cve_tipo_grupo_clase = 1
					)
AND		gc1.cve_tipo_grupo_clase = 9999
--AND		gc1.hora_inicio NOT IN (@var_ult_hra_inicio_mat , @var_hra_inicio_vesp)

--SELECT * FROM tempdb..grupos_clase
--WHERE cve_tipo_grupo_clase = 2
--select '*'

--TODOS LOS GRUPOS CON TRANSGRESIÓN
--SELECT  * 
--FROM tempdb..grupos_clase gc1
--WHERE NOT EXISTS(SELECT * FROM tempdb..grupos_clase gc2
--WHERE gc1.cve_mat = gc2.cve_mat
--AND	gc1.gpo = gc2.gpo
--AND	gc1.cve_coordinacion = gc2.cve_coordinacion
--AND	gc1.cve_dia = gc2.cve_dia
--AND	gc1.hora_inicio = gc2.hora_inicio
--AND	gc1.hora_final = gc2.hora_final
--AND	gc1.clase_aula = gc2.clase_aula 
--AND   gc2.cve_tipo_grupo_clase = 1
--)
--AND gc1.cve_tipo_grupo_clase = 9999
--AND gc1.hora_inicio NOT IN (@var_ult_hra_inicio_mat , @var_hra_inicio_vesp)

--SELECT '9999'
--SELECT COUNT(*) FROM tempdb..grupos_clase
--WHERE cve_tipo_grupo_clase = 9999

Resultado:

DELETE FROM tempdb..grupos_clase
WHERE cve_tipo_grupo_clase = 9999

--SELECT 'RESTO'
DELETE	FROM grupo_clase
WHERE	periodo = @periodo
AND		anio = @anio

INSERT INTO grupo_clase

(
	periodo,
	anio,
	cve_mat,
	gpo,
	cve_coordinacion ,
	cve_dia,
	hora_inicio,
	hora_final,
	clase_aula,
	cve_tipo_grupo_clase ,
	num_horas ,
	num_bloques,
	num_inscritos
)
SELECT	@periodo,
		@anio,
		cve_mat,
		gpo,
		cve_coordinacion ,
		cve_dia,
		hora_inicio,
		hora_final,
		clase_aula,
		cve_tipo_grupo_clase ,
		num_horas ,
		num_bloques,
		num_inscritos
FROM	tempdb..grupos_clase

DROP TABLE tempdb..grupos_clase
goto Fin

return

Fin:

    Commit Transaction
	return 0

--select * from tempdb..grupos_clase 
--order by cve_coordinacion, cve_dia, hora_inicio, clase_aula

EtiquetaCorrecto:

	raiserror 20000,  'Proceso correcto'

	Commit Transaction

	return 0

EtiquetaError:

	raiserror @num_error,  @mensaje_error

	Rollback Transaction

	return -1
GO



/*
GRANT EXECUTE ON sp_aspi_alum_revalid TO g_se_administrador
go 

GRANT EXECUTE ON sp_aspi_alum_revalid TO g_inf_admin
go 
*/

GRANT EXECUTE ON dbo.sp_genera_bloques_grupos TO prhintraces
GO
GRANT EXECUTE ON dbo.sp_genera_bloques_grupos TO g_coordinaciones
GO
GRANT EXECUTE ON dbo.sp_genera_bloques_grupos TO inscripcion
GO
GRANT EXECUTE ON dbo.sp_genera_bloques_grupos TO g_se_jef_tit_cert
GO
GRANT EXECUTE ON dbo.sp_genera_bloques_grupos TO g_se_tit_cert_ventanilla
GO
GRANT EXECUTE ON dbo.sp_genera_bloques_grupos TO g_sfeb_becas
GO
GRANT EXECUTE ON dbo.sp_genera_bloques_grupos TO g_se_administrador
GO
GRANT EXECUTE ON dbo.sp_genera_bloques_grupos TO g_inf_admin
GO
GRANT EXECUTE ON dbo.sp_genera_bloques_grupos TO g_se_ce_ventanilla
GO
GRANT EXECUTE ON dbo.sp_genera_bloques_grupos TO g_se_ce_atencion
GO
GRANT EXECUTE ON dbo.sp_genera_bloques_grupos TO g_se_jef_admision
GO
GRANT EXECUTE ON dbo.sp_genera_bloques_grupos TO g_se_admision_ventanilla
GO
GRANT EXECUTE ON dbo.sp_genera_bloques_grupos TO g_se_admision_atencion
GO
GRANT EXECUTE ON dbo.sp_genera_bloques_grupos TO g_se_jef_archivo
GO
GRANT EXECUTE ON dbo.sp_genera_bloques_grupos TO g_se_archivo_ventanilla
GO
GRANT EXECUTE ON dbo.sp_genera_bloques_grupos TO g_se_archivo_atencion
GO
GRANT EXECUTE ON dbo.sp_genera_bloques_grupos TO g_se_tit_cert_atencion
GO
GRANT EXECUTE ON dbo.sp_genera_bloques_grupos TO g_se_consultas
GO
GRANT EXECUTE ON dbo.sp_genera_bloques_grupos TO g_se_biblioteca
GO
GRANT EXECUTE ON dbo.sp_genera_bloques_grupos TO g_se_cobranzas
GO

