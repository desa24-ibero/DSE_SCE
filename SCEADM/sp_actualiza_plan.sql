IF OBJECT_ID ('dbo.sp_actualiza_plan') IS NOT NULL
	DROP PROCEDURE dbo.sp_actualiza_plan
GO

create procedure sp_actualiza_plan @mensaje_salida varchar(255) output
as                   

begin

declare

@mensajeerror varchar(50)

                  

begin TRANSACTION

	UPDATE controlescolar_bd.dbo.carreras 
	SET cve_plan_ofertado = (SELECT max(a.cve_plan) 
							FROM controlescolar_bd.dbo.plan_estudios a
							WHERE a.cve_carrera = b.cve_carrera
							AND a.cve_plan < 90	 
							GROUP BY b.cve_carrera)
	FROM  controlescolar_bd.dbo.carreras b						
	WHERE b.nivel IN ( 'L'	, 'T')

 	if @@error != 0 

		begin

			SELECT @mensajeerror = "Error al actualizar carreras.cve_plan_ofertado"

			goto error

		end

	else

	begin

		commit transaction

		select @mensaje_salida = null

		return 0

	end


error:

	rollback transaction


	select @mensaje_salida = @mensajeerror

	return -1
	
END 
	
GO

