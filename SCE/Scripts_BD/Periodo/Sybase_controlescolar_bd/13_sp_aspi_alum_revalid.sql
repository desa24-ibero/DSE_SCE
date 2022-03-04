IF OBJECT_ID ('dbo.sp_aspi_alum_revalid') IS NOT NULL
	DROP PROCEDURE dbo.sp_aspi_alum_revalid
GO 

create procedure sp_aspi_alum_revalid  
@folio integer = null,
@cuenta integer = null,
@apaterno varchar(50) = null,
@amaterno varchar(50) = null,
@nombre varchar(50) = NULL, 
@tipo_periodo VARCHAR(3) 

as


if @apaterno = ""
	select @apaterno = null
if @amaterno = ""
	select @amaterno = null
if @nombre = ""
	select @nombre = null
if @apaterno not in (null)
	select @apaterno = "%"+@apaterno +"%"
if @amaterno not in (null)
	select @amaterno = "%"+@amaterno +"%"
if @nombre not in (null)
	select @nombre = "%"+@nombre +"%"

select folio=0, cuenta, apaterno, amaterno, nombre, ing_por_revalidacion = 0
from alumnos
where  @cuenta in (alumnos.cuenta, null)
and    (alumnos.apaterno like @apaterno or @apaterno in (null))
and    (alumnos.amaterno like @amaterno or @amaterno in (null))
and    (alumnos.nombre like @nombre or @nombre in (null))
AND EXISTS(SELECT * FROM academicos, plan_estudios
			WHERE academicos.cuenta = @cuenta 
			AND academicos.cve_carrera = plan_estudios.cve_carrera
			AND academicos.cve_plan = plan_estudios.cve_plan
			AND plan_estudios.tipo_periodo = @tipo_periodo )
union 
select folio, cuenta, apaterno, amaterno, nombre, ing_por_revalidacion
from aspirantes_revalidacion
where  @folio in (aspirantes_revalidacion.folio, null)
and    (aspirantes_revalidacion.apaterno like @apaterno or @apaterno in (null))
and    (aspirantes_revalidacion.amaterno like @amaterno or @amaterno in (null))
and    (aspirantes_revalidacion.nombre like @nombre or @nombre in (null))
AND tipo_periodo = @tipo_periodo 
GO


GRANT EXECUTE ON sp_aspi_alum_revalid TO g_se_administrador
go 

GRANT EXECUTE ON sp_aspi_alum_revalid TO g_inf_admin
go 






