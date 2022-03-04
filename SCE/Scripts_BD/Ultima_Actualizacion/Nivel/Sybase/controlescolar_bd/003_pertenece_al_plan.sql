IF OBJECT_ID ('dbo.pertenece_al_plan') IS NOT NULL
	DROP PROCEDURE dbo.pertenece_al_plan
GO

create proc pertenece_al_plan @materia int, @carrera int, @plan int,

                              @pertenece int out

as

/*if (select nivel FROM materias WHERE cve_mat = @materia) = 'L'*/
if (select nivel FROM materias WHERE cve_mat = @materia) <> 'P'

	select @pertenece = count(*)

	from mat_prerrequisito

	where (cve_mat     = @materia and

     	  cve_carrera = @carrera and

      	 cve_plan    = @plan)

else

	select @pertenece = count(*)

	from mat_prerreq_pos

	where (cve_mat     = @materia and

     	  cve_carrera = @carrera and

      	 cve_plan    = @plan)

return
                                                                                                                                                                                                                                                           
GO





--GRANT EXECUTE ON dbo.pertenece_al_plan TO prhintraces
--GO
GRANT EXECUTE ON dbo.pertenece_al_plan TO g_coordinaciones
GO
GRANT EXECUTE ON dbo.pertenece_al_plan TO inscripcion
GO
GRANT EXECUTE ON dbo.pertenece_al_plan TO g_se_jef_tit_cert
GO
GRANT EXECUTE ON dbo.pertenece_al_plan TO g_se_tit_cert_ventanilla
GO
GRANT EXECUTE ON dbo.pertenece_al_plan TO g_sfeb_becas
GO
GRANT EXECUTE ON dbo.pertenece_al_plan TO g_se_administrador
GO
GRANT EXECUTE ON dbo.pertenece_al_plan TO g_inf_admin
GO
GRANT EXECUTE ON dbo.pertenece_al_plan TO g_se_ce_ventanilla
GO
GRANT EXECUTE ON dbo.pertenece_al_plan TO g_se_ce_atencion
GO
GRANT EXECUTE ON dbo.pertenece_al_plan TO g_se_jef_admision
GO
GRANT EXECUTE ON dbo.pertenece_al_plan TO g_se_admision_ventanilla
GO
GRANT EXECUTE ON dbo.pertenece_al_plan TO g_se_admision_atencion
GO
GRANT EXECUTE ON dbo.pertenece_al_plan TO g_se_jef_archivo
GO
GRANT EXECUTE ON dbo.pertenece_al_plan TO g_se_archivo_ventanilla
GO
GRANT EXECUTE ON dbo.pertenece_al_plan TO g_se_archivo_atencion
GO
GRANT EXECUTE ON dbo.pertenece_al_plan TO g_se_tit_cert_atencion
GO
GRANT EXECUTE ON dbo.pertenece_al_plan TO g_se_consultas
GO
GRANT EXECUTE ON dbo.pertenece_al_plan TO g_se_biblioteca
GO
GRANT EXECUTE ON dbo.pertenece_al_plan TO g_se_cobranzas
GO

