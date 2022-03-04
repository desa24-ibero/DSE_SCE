USE controlescolar_bd
GO

IF OBJECT_ID ('dbo.sp_ultimo_periodo_cursado') IS NOT NULL
	DROP PROCEDURE dbo.sp_ultimo_periodo_cursado
GO

create procedure sp_ultimo_periodo_cursado
	@a_cuenta integer = null
as

declare @anio integer
declare @periodo integer
declare @nivel varchar(2)



select @nivel = nivel from academicos
where cuenta = @a_cuenta

select @anio = max(anio)
from historico inner join materias on historico.cve_mat = materias.cve_mat
inner join carreras on historico.cve_carrera = carreras.cve_carrera
where cuenta = @a_cuenta
and materias.creditos >0
and carreras.nivel <> 'P'
/*and carreras.nivel = 'L'*/

select  @periodo = max(periodo) from historico inner join materias on historico.cve_mat = materias.cve_mat
inner join carreras on historico.cve_carrera = carreras.cve_carrera
where cuenta = @a_cuenta
and materias.creditos >0
and anio = @anio
and carreras.nivel <> 'P' 
/*and carreras.nivel = 'L'*/

/*if @nivel = 'L'*/
if @nivel <> 'P' 
BEGIN
	SELECT cuenta= @a_cuenta, anio = @anio, periodo= @periodo
END
else
BEGIN
	SELECT cuenta= NULL, anio = NULL, periodo= NULL from mat_inscritas where 1=2
END
GO


GRANT EXECUTE ON dbo.sp_ultimo_periodo_cursado TO g_coordinaciones
GO
GRANT EXECUTE ON dbo.sp_ultimo_periodo_cursado TO inscripcion
GO
GRANT EXECUTE ON dbo.sp_ultimo_periodo_cursado TO g_se_jef_tit_cert
GO
GRANT EXECUTE ON dbo.sp_ultimo_periodo_cursado TO g_se_tit_cert_ventanilla
GO
GRANT EXECUTE ON dbo.sp_ultimo_periodo_cursado TO g_sfeb_becas
GO
GRANT EXECUTE ON dbo.sp_ultimo_periodo_cursado TO g_se_administrador
GO
GRANT EXECUTE ON dbo.sp_ultimo_periodo_cursado TO g_inf_admin
GO
GRANT EXECUTE ON dbo.sp_ultimo_periodo_cursado TO g_se_ce_ventanilla
GO
GRANT EXECUTE ON dbo.sp_ultimo_periodo_cursado TO g_se_ce_atencion
GO
GRANT EXECUTE ON dbo.sp_ultimo_periodo_cursado TO g_se_jef_admision
GO
GRANT EXECUTE ON dbo.sp_ultimo_periodo_cursado TO g_se_admision_ventanilla
GO
GRANT EXECUTE ON dbo.sp_ultimo_periodo_cursado TO g_se_admision_atencion
GO
GRANT EXECUTE ON dbo.sp_ultimo_periodo_cursado TO g_se_jef_archivo
GO
GRANT EXECUTE ON dbo.sp_ultimo_periodo_cursado TO g_se_archivo_ventanilla
GO
GRANT EXECUTE ON dbo.sp_ultimo_periodo_cursado TO g_se_archivo_atencion
GO
GRANT EXECUTE ON dbo.sp_ultimo_periodo_cursado TO g_se_tit_cert_atencion
GO
GRANT EXECUTE ON dbo.sp_ultimo_periodo_cursado TO g_se_consultas
GO
GRANT EXECUTE ON dbo.sp_ultimo_periodo_cursado TO g_se_biblioteca
GO
GRANT EXECUTE ON dbo.sp_ultimo_periodo_cursado TO g_se_cobranzas
GO

