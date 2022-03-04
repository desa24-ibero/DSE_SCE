IF OBJECT_ID ('dbo.sp_enlace_sce') IS NOT NULL
	DROP PROCEDURE dbo.sp_enlace_sce
GO

create procedure sp_enlace_sce @cuenta integer,

										 @version integer,

                               @periodo integer, 

                               @anio integer, 

                               @mensaje_salida varchar(255) output

as                   

begin

declare

@mensajeerror varchar(50),

@numerror	integer,

@carrera_actual integer,

@plan_actual integer,

@carrera_anterior integer,

@plan_anterior integer,

@periodo_ing integer,

@anio_ing integer,

@forma_ing integer,

@insercion INTEGER,

@nivel VARCHAR(1)

                  

begin transaction



SELECT @insercion = 0

                                             

SELECT @numerror = 20000,@mensajeerror = "No existe un aspirante aceptado con esas condiciones"

--Revisa que exista un aspirante con esa cuenta, aceptado o diferido aceptado, que ingrese 

--en el periodo y anio indicados, con sus datos consistentes en aspiran, general y padres y

--que haya pagado su inscripcion

if (SELECT COUNT(g.cuenta) FROM general g, aspiran a, padres p 

	WHERE g.folio = a.folio AND g.clv_ver = a.clv_ver AND g.clv_per = a.clv_per AND g.anio = a.anio

	AND g.folio = p.folio AND g.clv_ver = p.clv_ver AND g.clv_per = p.clv_per AND g.anio = p.anio

	AND a.status IN (1,4) AND a.clv_per = @periodo AND a.clv_ver = @version

   AND g.cuenta = @cuenta AND a.ing_per = @periodo AND a.ing_anio = @anio) = 1

begin

--Revisa si no existe un alumno en controlescolar_bd con ese numero de cuenta

	if (SELECT COUNT(cuenta) FROM controlescolar_bd.dbo.alumnos WHERE cuenta = @cuenta) <> 1

	begin

		SELECT @insercion = 1

--Inserta en la tabla de alumnos de controlescolar_bd

		INSERT INTO controlescolar_bd.dbo.alumnos 

         ( controlescolar_bd.dbo.alumnos.cuenta,   

           controlescolar_bd.dbo.alumnos.nombre,   

           controlescolar_bd.dbo.alumnos.apaterno,   

           controlescolar_bd.dbo.alumnos.amaterno,   

           controlescolar_bd.dbo.alumnos.sexo,   

           controlescolar_bd.dbo.alumnos.cve_trabajo,   

           controlescolar_bd.dbo.alumnos.horas_trabajo,   

           controlescolar_bd.dbo.alumnos.fecha_nac,   

           controlescolar_bd.dbo.alumnos.lugar_nac,   

           controlescolar_bd.dbo.alumnos.cve_transp,   

           controlescolar_bd.dbo.alumnos.cve_nacion,   

           controlescolar_bd.dbo.alumnos.cve_religion,   

           controlescolar_bd.dbo.alumnos.cve_edocivil,   

           controlescolar_bd.dbo.alumnos.promedio_bach,

           controlescolar_bd.dbo.alumnos.fotografia,

           controlescolar_bd.dbo.alumnos.nombre_completo,
           
           controlescolar_bd.dbo.alumnos.curp)  

			SELECT	g.cuenta,

						g.nombre,

						g.apaterno,

						g.amaterno,

						g.sexo,

						g.trabajo,

						g.trab_hor,

						g.fecha_nac,

						g.lugar_nac,

						g.transporte,

						g.nacional,

						g.religion,

						g.edo_civil,

						a.promedio, 

						NULL, 

						NULL,
						
						g.curp

			FROM general g, aspiran a 

 			WHERE g.folio = a.folio AND g.clv_ver = a.clv_ver AND g.clv_per = a.clv_per AND g.anio = a.anio

			AND  g.cuenta = @cuenta 

         AND a.ing_per = @periodo AND a.ing_anio = @anio

			AND a.clv_ver <>0		

		if @@error != 0 

		begin

			SELECT @mensajeerror = "Error al insertar el alumno"

			goto error

		end

--Inserta en la tabla estudio_ant de controlescolar_bd

		INSERT INTO controlescolar_bd.dbo.estudio_ant

				(controlescolar_bd.dbo.estudio_ant.cuenta,

             controlescolar_bd.dbo.estudio_ant.cve_escuela,

             controlescolar_bd.dbo.estudio_ant.cve_carrera,

             controlescolar_bd.dbo.estudio_ant.cve_grado,

             controlescolar_bd.dbo.estudio_ant.periodo,

             controlescolar_bd.dbo.estudio_ant.num_certificado,

             controlescolar_bd.dbo.estudio_ant.cve_doc_certificado,

             controlescolar_bd.dbo.estudio_ant.fecha,

             controlescolar_bd.dbo.estudio_ant.no_oficio)

			SELECT @cuenta, 

					g.bachillera,

					NULL,

					'B',

					NULL, 

					NULL, 

					NULL, 

					NULL, 

					NULL

			FROM general g, aspiran a

			WHERE g.folio = a.folio AND g.clv_ver = a.clv_ver AND g.clv_per = a.clv_per AND g.anio = a.anio

			AND a.status IN (1,4) AND a.clv_per = @periodo AND a.clv_ver = @version

         AND g.cuenta = @cuenta AND a.ing_per = @periodo AND a.ing_anio = @anio

			AND a.clv_ver <>0

			if @@error != 0 

			begin

				SELECT @mensajeerror = "Error al insertar el estudio_ant"

				goto error

			end

--DESPUES DE HABER INSERTADO, DEBE ACTUALIZAR LA INFORMACIÓN QUE SE INSERTO EN CASCADA

			goto actualiza

	end

	else

	begin



--Actualiza la tabla de alumnos de controlescolar_bd

		UPDATE controlescolar_bd.dbo.alumnos

			SET 	cea.nombre = g.nombre, 

					cea.apaterno = g.apaterno, 

					cea.amaterno = g.amaterno,

					cea.sexo = g.sexo, 

					cea.cve_trabajo = g.trabajo, 

					cea.horas_trabajo = g.trab_hor,

					cea.fecha_nac = g.fecha_nac, 

					cea.lugar_nac = g.lugar_nac, 

					cea.cve_transp = g.transporte,

					cea.cve_nacion = g.nacional, 

					cea.cve_religion = g.religion, 

					cea.cve_edocivil = g.edo_civil,

					cea.promedio_bach = a.promedio

			FROM controlescolar_bd.dbo.alumnos cea, general g, aspiran a

			WHERE g.folio = a.folio AND g.clv_ver = a.clv_ver AND g.clv_per = a.clv_per AND g.anio = a.anio

			AND a.status IN (1,4) AND a.clv_per = @periodo AND a.clv_ver = @version

         AND g.cuenta = @cuenta AND a.ing_per = @periodo AND a.ing_anio = @anio

			AND cea.cuenta = @cuenta

			AND a.clv_ver <>0



--*		SELECT @mensajeerror = "* UPDATE EN ALUMNOS*"

--*		goto error



		if @@error != 0 

		begin

			SELECT @mensajeerror = "Error al actualizar el alumno"

			goto error

		end



actualiza:

--Revisa si existe un registro en estudio_ant con ese numero de cuenta

		if (SELECT COUNT(*) FROM controlescolar_bd.dbo.estudio_ant WHERE cuenta = @cuenta) = 0

		begin

--Inserta un registro en la tabla estudio_ant de controlescolar_bd

		 INSERT INTO controlescolar_bd.dbo.estudio_ant

				(controlescolar_bd.dbo.estudio_ant.cuenta,

             controlescolar_bd.dbo.estudio_ant.cve_escuela,

             controlescolar_bd.dbo.estudio_ant.cve_carrera,

             controlescolar_bd.dbo.estudio_ant.cve_grado,

             controlescolar_bd.dbo.estudio_ant.periodo,

             controlescolar_bd.dbo.estudio_ant.num_certificado,

             controlescolar_bd.dbo.estudio_ant.cve_doc_certificado,

             controlescolar_bd.dbo.estudio_ant.fecha,

             controlescolar_bd.dbo.estudio_ant.no_oficio)

			SELECT @cuenta, 

                g.bachillera,

                NULL,

                'B',

                NULL, 

                NULL, 

                NULL, 

                NULL, 

                NULL

			FROM general g, aspiran a

			WHERE g.folio = a.folio AND g.clv_ver = a.clv_ver AND g.clv_per = a.clv_per AND g.anio = a.anio

			AND a.status IN (1,4) AND a.clv_per = @periodo AND a.clv_ver = @version

         AND g.cuenta = @cuenta AND a.ing_per = @periodo AND a.ing_anio = @anio

			AND a.clv_ver <>0

			if @@error != 0 

			begin

				SELECT @mensajeerror = "Error al insertar en estudio_ant"

				goto error

			end



--*			SELECT @mensajeerror = "* INSERT EN ESTUDIO_ANT2*"

--*			goto error

		end

		else

		begin

--Actualiza la tabla estudio_ant de controlescolar_bd solo cuando el grado es de bachillerato

			UPDATE controlescolar_bd.dbo.estudio_ant

			SET 	ea.cve_escuela = g.bachillera, 

					ea.cve_carrera = NULL 

			FROM controlescolar_bd.dbo.estudio_ant ea, general g, aspiran a

			WHERE g.folio = a.folio AND g.clv_ver = a.clv_ver AND g.clv_per = a.clv_per AND g.anio = a.anio

			AND a.status IN (1,4) AND a.clv_per = @periodo AND a.clv_ver = @version

         AND g.cuenta = @cuenta AND a.ing_per = @periodo AND a.ing_anio = @anio

			AND ea.cuenta = @cuenta AND ea.cve_grado LIKE "B"

			AND a.clv_ver <>0



--*			SELECT @mensajeerror = "* UPDATE EN ESTUDIO_ANT2*"

--*			goto error

		end

		if @@error != 0 

		begin

			SELECT @mensajeerror = "Error al actualizar el estudio_ant"

			goto error

		end



 /*		SELECT @carrera_actual = cve_carrera,

             @plan_actual =cve_plan  

      FROM controlescolar_bd.dbo.academicos ceac, general g, aspiran a

		WHERE g.folio = a.folio AND g.clv_ver = a.clv_ver AND g.clv_per = a.clv_per AND g.anio = a.anio

		AND  a.status IN (1,4) 

      AND  g.cuenta = @cuenta AND a.ing_per = @periodo AND a.ing_anio = @anio

		AND ceac.cuenta = @cuenta

		AND a.clv_ver <>0 */
		
--Se hizo el cambio para que insertara el plan de estudios actual BEVM 24/11/14
	SELECT @carrera_actual = clv_carr

      FROM general g, aspiran a

		WHERE g.folio = a.folio AND g.clv_ver = a.clv_ver AND g.clv_per = a.clv_per AND g.anio = a.anio

		AND  a.status IN (1,4) 

      AND  g.cuenta = @cuenta AND a.ing_per = @periodo AND a.ing_anio = @anio

	AND a.clv_ver <>0
	
	
	if @carrera_actual in (null)

	begin

		SELECT @carrera_actual = 0

	end

	SELECT @plan_actual = a.cve_plan_ofertado, @nivel = a.nivel
	
	FROM controlescolar_bd.dbo.carreras a
	
	WHERE a.nivel IN  ('L','T')
	
	AND a.cve_carrera = @carrera_actual
	
	if @plan_actual in (null)

	begin

		SELECT @plan_actual = 0

	end


--Revisa si no existe un alumno en controlescolar_bd.hist_carreras con ese numero de cuenta, periodo

	if (SELECT COUNT(hc.cuenta) FROM controlescolar_bd.dbo.hist_carreras hc,  controlescolar_bd.dbo.academicos ceac,

		general g, aspiran a

			WHERE g.folio = a.folio AND g.clv_ver = a.clv_ver AND g.clv_per = a.clv_per AND g.anio = a.anio

			AND  a.status IN (1,4) 

         AND  g.cuenta =  @cuenta AND a.ing_per = @periodo AND a.ing_anio = @anio

			AND ceac.cuenta =  @cuenta

			AND a.clv_ver <>0

			AND hc.cuenta = ceac.cuenta

			AND ceac.cve_carrera = a.clv_carr) = 0

--Inserta un registro en la tabla hist_carreras de controlescolar_bd

   begin  

		INSERT INTO controlescolar_bd.dbo.hist_carreras 

				( controlescolar_bd.dbo.hist_carreras.cuenta,   

				  controlescolar_bd.dbo.hist_carreras.cve_formaingreso,   

				  controlescolar_bd.dbo.hist_carreras.cve_carrera_ant,   

				  controlescolar_bd.dbo.hist_carreras.cve_plan_ant,   

				  controlescolar_bd.dbo.hist_carreras.cve_subsistema_ant,   

				  controlescolar_bd.dbo.hist_carreras.cve_carrera_act,   

				  controlescolar_bd.dbo.hist_carreras.cve_plan_act,   

				  controlescolar_bd.dbo.hist_carreras.cve_subsistema_act,   

				  controlescolar_bd.dbo.hist_carreras.periodo_ing,   

				  controlescolar_bd.dbo.hist_carreras.anio_ing, 

				  controlescolar_bd.dbo.hist_carreras.nivel_ant,

				  controlescolar_bd.dbo.hist_carreras.nivel_act,

				  controlescolar_bd.dbo.hist_carreras.promedio_ant,

				  controlescolar_bd.dbo.hist_carreras.sem_cursados_ant,

				  controlescolar_bd.dbo.hist_carreras.creditos_cursados_ant,

				  controlescolar_bd.dbo.hist_carreras.egresado_ant,

				  controlescolar_bd.dbo.hist_carreras.periodo_egre_ant,

				  controlescolar_bd.dbo.hist_carreras.anio_egre_ant)

			SELECT	ceac.cuenta, 

                  ceac.cve_formaingreso, 

                  ceac.cve_carrera, 

                  ceac.cve_plan, 

                  ceac.cve_subsistema,

						@carrera_actual,

                  @plan_actual,

                  0, 

                  @periodo, 

                  @periodo,

						ceac.nivel,

						null,

						ceac.promedio,

						ceac.sem_cursados,

						ceac.creditos_cursados,

						ceac.egresado,

						ceac.periodo_egre,

						ceac.anio_egre

			FROM controlescolar_bd.dbo.academicos ceac, general g, aspiran a

			WHERE g.folio = a.folio AND g.clv_ver = a.clv_ver AND g.clv_per = a.clv_per AND g.anio = a.anio

			AND  a.status IN (1,4) 

         AND  g.cuenta = @cuenta AND a.ing_per = @periodo AND a.ing_anio = @periodo

			AND ceac.cuenta = @cuenta

			AND a.clv_ver <>0

--*		SELECT @mensajeerror = "* INSERT EN HIST_CARRERAS*"

--*		goto error



		if @@error != 0 

		begin

			SELECT @mensajeerror = "Error al insertar historico carreras"

			goto error

		end

  end


	end

--Actualiza la tabla domicilio de controlescolar_bd
--Se añadió la actualización de telefono_movil e e_mail 2009-10-21

	UPDATE controlescolar_bd.dbo.domicilio

	SET 	d.calle = g.calle, 

			d.colonia = g.colonia, 

			d.cve_estado = g.estado,

			d.cod_postal = g.codigo_pos, 

			d.telefono = g.telefono, 

			d.telefono_movil = g.telefono_movil, 

			d.e_mail = g.e_mail

	FROM controlescolar_bd.dbo.domicilio d, general g, aspiran a

	WHERE g.folio = a.folio AND g.clv_ver = a.clv_ver AND g.clv_per = a.clv_per AND g.anio = a.anio

	AND a.status IN (1,4) AND a.clv_per = @periodo AND a.clv_ver = @version

   AND g.cuenta = @cuenta AND a.ing_per = @periodo AND a.ing_anio = @anio AND d.cuenta = @cuenta

	AND a.clv_ver <>0

--*	SELECT @mensajeerror = "* UPDATE EN DOMICILIO*"

--*	goto error

	if @@error != 0 

		begin

			SELECT @mensajeerror = "Error al actualizar domicilio"

			goto error

		end





--Actualiza la tabla padre de controlescolar_bd

	UPDATE controlescolar_bd.dbo.padre

	SET 	pce.nombre = pa.nombre, 

			pce.apaterno = pa.apaterno, 	

			pce.amaterno = pa.amaterno,

			pce.calle = pa.calle, 

			pce.colonia = pa.colonia, 

			pce.cve_estado = pa.estado,

			pce.cod_postal = pa.codigo_pos, 

			pce.telefono = pa.telefono

	FROM controlescolar_bd.dbo.padre pce, padres pa, general g, aspiran a

	WHERE g.folio = a.folio AND g.clv_ver = a.clv_ver AND g.clv_per = a.clv_per AND g.anio = a.anio

			AND g.folio = pa.folio 

         AND g.clv_ver = pa.clv_ver AND g.clv_per = pa.clv_per AND g.anio = pa.anio

			AND a.status IN (1,4) AND a.clv_per = @periodo AND a.clv_ver = @version

			AND pce.cuenta = @cuenta AND g.cuenta = @cuenta AND a.ing_per = @periodo AND a.ing_anio = @anio

			AND a.clv_ver <>0

--*	SELECT @mensajeerror = "* UPDATE EN PADRE*"

--*	goto error

	if @@error != 0 

		begin

			SELECT @mensajeerror = "Error al actualizar padre"

			goto error

		end



--Actualiza la tabla academicos de controlescolar_bd

	UPDATE controlescolar_bd.dbo.academicos

	SET ace.cve_carrera = @carrera_actual,

		ace.cve_plan = @plan_actual, 

		ace.periodo_ing = @periodo, 

		ace.anio_ing = @anio,
		
		ace.nivel = @nivel

	FROM controlescolar_bd.dbo.academicos ace,general g,aspiran a

	WHERE g.folio = a.folio AND g.clv_ver = a.clv_ver AND g.clv_per = a.clv_per AND g.anio = a.anio

		AND g.cuenta = @cuenta 

      AND a.ing_per = @periodo AND a.ing_anio = @anio

		AND a.status IN (1,4) AND a.clv_per = @periodo AND a.clv_ver = @version AND ace.cuenta = @cuenta

		AND a.clv_ver <>0

--*	SELECT @mensajeerror = "* UPDATE EN ACADEMICOS*"

--*	goto error

	if @@error != 0 

		begin

			SELECT @mensajeerror = "Error al actualizar academicos"

			goto error

		end





--Actualiza la tabla banderas de controlescolar_bd

	UPDATE controlescolar_bd.dbo.banderas 

	SET insc_sem_ant = 1, 

		exten_cred = 60 

	WHERE cuenta = @cuenta

--*	SELECT @mensajeerror = "* UPDATE EN BANDERAS*"

--*	goto error

	if @@error != 0 

		begin

			SELECT @mensajeerror = "Error al actualizar banderas"

			goto error

		end

	else

	begin

		commit transaction

		select @mensaje_salida = null

		return 0

	end

end

else

	begin

			SELECT @mensajeerror = "No existe un aspirante aceptado con esas condiciones"

			goto error

	end

end

error:

	rollback transaction

--	raiserror @numerror, @mensajeerror

	select @mensaje_salida = @mensajeerror

	return -1
GO

