USE controlescolar_bd
GO

IF OBJECT_ID ('dbo.sp_genera_tramite_titulacion') IS NOT NULL
	DROP PROCEDURE dbo.sp_genera_tramite_titulacion
GO

create procedure sp_genera_tramite_titulacion 



as





declare		@num_error integer,

		@mensaje_error varchar(255),

		@mensaje_salida varchar(255),

   	@mensaje_sp varchar(255),

		@cur_cuenta integer,

		@cur_cve_carrera integer,

		@cur_cve_plan int,

		@cur_digito varchar(1),

		@cur_creditos_cursados integer,

		@aux_digito varchar(1),

		@resultado  integer,

		@cred_mat_inscritas integer,

		@cred_aux integer,

		@promedio real,

		@creditos integer,

		@cur_hist_cuenta			int,

		@cur_hist_cve_mat			int,

		@cur_hist_gpo				varchar(2),

		@cur_hist_periodo			int,

		@cur_hist_anio				int,

		@cur_hist_cve_carrera		int,

		@cur_hist_cve_plan			int,

		@cur_hist_calificacion	varchar(2),

		@cur_hist_observacion		int,

		@ant_hist_cuenta			int,

		@ant_hist_cve_mat			int,

		@ant_hist_gpo				varchar(2),

		@ant_hist_periodo			int,

		@ant_hist_anio				int,

		@ant_hist_cve_carrera		int,

		@ant_hist_cve_plan			int,

		@ant_hist_calificacion	varchar(2),

		@ant_hist_observacion		int,

		@resultado_sp integer







BEGIN TRANSACTION

--INSERCION POR BLOQUES DE CARRERAS CURSADAS, DADO QUE UN SOLO QUERY ES CAPAZ DE LLENAR TEMPDB

DELETE FROM tramite_titulacion





INSERT INTO tramite_titulacion (cuenta, cve_carrera, cve_plan, cve_subsistema, egresado)

select distinct hc.cuenta, cve_carrera= hc.cve_carrera_ant, cve_plan = hc.cve_plan_ant, cve_subsistema = hc.cve_subsistema_ant, egresado= hc.egresado_ant

from hist_carreras hc, carreras c

where hc.cve_carrera_ant not in (9532)

and	hc.cve_plan_ant in (1,2,3,4)

and	hc.cve_carrera_ant = c.cve_carrera

and	c.nivel <> "P"

union 

select distinct a.cuenta, a.cve_carrera, a.cve_plan, a.cve_subsistema, a.egresado

from academicos a, carreras c 

where a.cve_carrera not in (9532)

and	a.cve_plan in (1,2,3,4)

and	a.cve_carrera = c.cve_carrera

and	c.nivel <> "P"

/*and	c.nivel = "L"*/



--Limpia los tramite de titulación indicando que les falta todo



update tramite_titulacion

set prerreq_ingles = 0,

	 certificado = 0,

	 titulado = 0,

	 egresado = 0



--Actualiza el tramite de titulación indicando a los que tienen aprobado el

--prerrequisito de ingles

update tramite_titulacion

set prerreq_ingles = 1

from historico h, tramite_titulacion tt

where h.cve_mat in (4078)

and h.calificacion = "AC"

and h.cuenta = tt.cuenta

and h.cve_carrera = tt.cve_carrera

and h.cve_plan = tt.cve_plan



--Actualiza el tramite de titulación indicando a los que tienen aprobado el examen



update tramite_titulacion

set titulado = 1

from titulacion t, tramite_titulacion tt

where t.cuenta = tt.cuenta

and t.cve_carrera = tt.cve_carrera

and t.cve_plan = tt.cve_plan





--Actualiza el tramite de titulación indicando a los que han solicitado certificado total



update tramite_titulacion

set certificado = 1

from certificado c, tramite_titulacion tt

where c.cuenta = tt.cuenta

and c.cve_carrera = tt.cve_carrera

and c.cve_plan = tt.cve_plan

and c.parcial = 0



--Actualiza el tramite de titulación indicando a los alumnos egresados



update tramite_titulacion

set egresado = 1

from academicos a, tramite_titulacion tt

where a.cuenta = tt.cuenta

and a.cve_carrera = tt.cve_carrera

and a.cve_plan = tt.cve_plan

and a.egresado = 1



update tramite_titulacion

set egresado = 1

from hist_carreras h, tramite_titulacion tt

where h.cuenta = tt.cuenta

and h.cve_carrera_ant = tt.cve_carrera

and h.cve_plan_ant = tt.cve_plan

and h.egresado_ant = 1







--select * from tramite_titulacion

goto Fin





declare cursor_carreras_alumno cursor 

for

select cuenta,

		 cve_carrera,

		cve_plan

from tramite_titulacion

order by cuenta, cve_carrera, cve_plan





                    

open cursor_carreras_alumno



                            

fetch cursor_carreras_alumno

into 

@cur_cuenta, 

@cur_cve_carrera,

@cur_cve_plan



                                      



if (@@sqlstatus = 2)

begin

    select @mensaje_error = "No existen movimientos a Procesar."

    close cursor_carreras_alumno

    goto Fin

end



                                                        



if (@@sqlstatus = 1) 

begin

   select @num_error = 20000, @mensaje_error = "Error de lectura en el cursor: cursor_carreras_alumno."

	close cursor_carreras_alumno

	goto EtiquetaError

end



                                                                                           





while (@@sqlstatus = 0)

begin





--	select @resultado_sp= 0



--	exec @resultado_sp = sp_valida_historico @cur_cuenta, @cur_cve_carrera, @cur_cve_plan, @mensaje_salida = @mensaje_sp output



--	if @@error != 0 

--	begin

--	   select @mensaje_error = "Error al ejecutar sp_valida_historico  Cuenta = "+convert(varchar(255), @cur_cuenta)+

--										" Carrera = "+convert(varchar(255), @cur_cve_carrera)+

--										" Plan = "+convert(varchar(255), @cur_cve_plan)

--		close cursor_carreras_alumno

--		goto EtiquetaError

--	end 





	fetch cursor_carreras_alumno

	into 

	@cur_cuenta, 

	@cur_cve_carrera,

	@cur_cve_plan





end





                                                        



if (@@sqlstatus = 1) 

begin

   select @mensaje_error = "Error de lectura en el cursor: cursor_carreras_alumno."

	close cursor_carreras_alumno

	goto Fin

end



                     

close cursor_carreras_alumno



                                                

deallocate cursor cursor_carreras_alumno







Fin:

                                         


EtiquetaCorrecto:

	Commit Transaction

	return 0





EtiquetaError:

	raiserror @num_error,  @mensaje_error

	Rollback Transaction

	return -1


                              
GO







GRANT EXECUTE ON dbo.sp_genera_tramite_titulacion TO g_coordinaciones
GO
GRANT EXECUTE ON dbo.sp_genera_tramite_titulacion TO inscripcion
GO
GRANT EXECUTE ON dbo.sp_genera_tramite_titulacion TO g_se_jef_tit_cert
GO
GRANT EXECUTE ON dbo.sp_genera_tramite_titulacion TO g_se_tit_cert_ventanilla
GO
GRANT EXECUTE ON dbo.sp_genera_tramite_titulacion TO g_sfeb_becas
GO
GRANT EXECUTE ON dbo.sp_genera_tramite_titulacion TO g_se_administrador
GO
GRANT EXECUTE ON dbo.sp_genera_tramite_titulacion TO g_inf_admin
GO
GRANT EXECUTE ON dbo.sp_genera_tramite_titulacion TO g_se_ce_ventanilla
GO
GRANT EXECUTE ON dbo.sp_genera_tramite_titulacion TO g_se_ce_atencion
GO
GRANT EXECUTE ON dbo.sp_genera_tramite_titulacion TO g_se_jef_admision
GO
GRANT EXECUTE ON dbo.sp_genera_tramite_titulacion TO g_se_admision_ventanilla
GO
GRANT EXECUTE ON dbo.sp_genera_tramite_titulacion TO g_se_admision_atencion
GO
GRANT EXECUTE ON dbo.sp_genera_tramite_titulacion TO g_se_jef_archivo
GO
GRANT EXECUTE ON dbo.sp_genera_tramite_titulacion TO g_se_archivo_ventanilla
GO
GRANT EXECUTE ON dbo.sp_genera_tramite_titulacion TO g_se_archivo_atencion
GO
GRANT EXECUTE ON dbo.sp_genera_tramite_titulacion TO g_se_tit_cert_atencion
GO
GRANT EXECUTE ON dbo.sp_genera_tramite_titulacion TO g_se_consultas
GO
GRANT EXECUTE ON dbo.sp_genera_tramite_titulacion TO g_se_biblioteca
GO
GRANT EXECUTE ON dbo.sp_genera_tramite_titulacion TO g_se_cobranzas
GO




