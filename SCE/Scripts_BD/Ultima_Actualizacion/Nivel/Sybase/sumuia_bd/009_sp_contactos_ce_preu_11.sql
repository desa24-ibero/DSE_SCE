USE sumuia_bd 
GO


IF OBJECT_ID ('dbo.sp_contactos_ce_preu_11') IS NOT NULL
	DROP PROCEDURE dbo.sp_contactos_ce_preu_11
GO

create procedure sp_contactos_ce_preu_11  @a_periodo int, @a_anio int, @a_criterio int 
as

declare
	@mensaje_salida varchar(255),
   @mensaje_sp varchar(255),
	@resultado_sp integer,
   @cur_folio integer,
   @cur_cuenta integer,  
   @cur_clv_ver integer,  
   @cur_clv_per integer,  
   @cur_anio integer,  
   @cur_ing_per integer,
   @cur_ing_anio integer,  
   @mensaje_error varchar(255),
	@num_error integer
-- Asignacion de variables 

if @a_periodo in (null)
begin
	select @num_error = 20000, @mensaje_error = "Es necesario dar el periodo"
	Goto EtiquetaError
end

if @a_anio in (null)
begin
	select @num_error = 20000, @mensaje_error = "Es necesario dar el anio"
	Goto EtiquetaError
end

if @a_criterio in (null)
begin
	select @num_error = 20000, @mensaje_error = "Es necesario dar el criterio"
	Goto EtiquetaError
end


--Ejecuta el proceso que llena la tabla para los querys
		select @resultado_sp= 0
		select @mensaje_sp = null
		exec @resultado_sp = sp_contactos_ce_preu @periodo =@a_periodo, 
																@anio =@a_anio, 
																@criterio = @a_criterio
		if @resultado_sp != 0 
		begin
	   	select @mensaje_error = "Error al ejecutar sp_contactos_ce_preu " +
                                  " Periodo = "+convert(varchar(255), @a_periodo) +
                                  " Anio = "+convert(varchar(255), @a_anio) +
                                  " Criterio = "+convert(varchar(255), @a_criterio)
			select @num_error = 20000
			goto EtiquetaError
		end 

--11) El número de contactos por tipo de actividad y periodo
SELECT num_contactos = COUNT(*),
		clv_per,
		anio,
      clavetipoactividad,
		nombretipoactividad
FROM  saa_aspirantes_ce_preu, v_sce_carreras
WHERE  v_sce_carreras.cve_carrera = saa_aspirantes_ce_preu.cve_carrera 
AND    v_sce_carreras.nivel <> 'P'
AND 	user_name = user_name() 
GROUP BY clv_per,
		anio,
      clavetipoactividad,
		nombretipoactividad
ORDER BY nombretipoactividad

                     

Fin:

EtiquetaCorrecto:
--	Commit Transaction
	return 0

EtiquetaError:
	raiserror @num_error,  @mensaje_error
	Rollback Transaction
	return -1
GO


GRANT EXECUTE ON dbo.sp_contactos_ce_preu_11 TO g_admisionadm
GO

GRANT EXECUTE ON dbo.sp_contactos_ce_preu_11 TO g_inf_admin
GO








