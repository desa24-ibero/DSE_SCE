USE sumuia_bd 
GO 


IF OBJECT_ID ('dbo.sp_materias_alumno') IS NOT NULL
	DROP PROCEDURE dbo.sp_materias_alumno
GO

create procedure sp_materias_alumno @a_cuenta integer
as
declare 
@ls_mensaje_error varchar(255),
@ll_num_error integer,
@ll_resultado integer,
@ll_cuenta integer,
@curl_cve_mat integer,
@curs_calificacion varchar(2),
@curl_anio integer,
@curl_periodo integer,
@curs_anio_periodo varchar(25),
@curs_periodo_descripcion varchar(15),
@curs_sigla varchar(6),
@curs_estatus_materia varchar(50),
@ll_cve_mat_hist integer,
@ls_calificacion_hist varchar(2),
@ll_anio_hist integer,
@ll_periodo_hist integer,
@ls_periodo_descripcion_hist varchar(15),
@ls_estatus_materia_hist varchar(50),
@ll_cve_mat_mi integer,
@ls_calificacion_mi varchar(2),
@ll_anio_mi integer,
@ll_periodo_mi integer,
@ls_periodo_descripcion_mi varchar(15),
@ls_estatus_materia_mi varchar(50),
@ll_cve_mat integer,
@ls_calificacion varchar(2),
@ll_anio integer,
@ll_periodo integer,
@ls_periodo_descripcion varchar(15),
@ls_estatus_materia varchar(50),
@ls_anio_periodo varchar(25),
@ll_rowcount_historico integer,
@ll_rowcount_mat_inscritas integer,
@ll_rowcount_grupos integer,
@ll_curso_prerrequisitos integer,
@ll_cve_mat_grupos integer,
@ll_cve_carrera integer,
@ll_cve_plan integer,
@ll_rowcount_plan_ideal integer,
@ls_nivel varchar(1)


SELECT @ll_cuenta = v_sce_academicos.cuenta,
         @ll_cve_carrera = v_sce_academicos.cve_carrera,
         @ll_cve_plan = v_sce_academicos.cve_plan,
         @ls_nivel = v_sce_academicos.nivel
FROM v_sce_academicos
WHERE ( v_sce_academicos.cuenta = @a_cuenta ) 


create table #plan_ideal
(cve_mat integer not null,
materia varchar(42) null,
horas_reales integer null,
creditos integer null,
calificacion varchar(2) null,
anio integer null,
periodo integer null,
anio_periodo varchar(25) null,
periodo_descripcion varchar(15) null,
sigla varchar(6) null,
estatus_materia varchar(50) null,
semestre_ideal integer
)

/*IF (@ls_nivel = "L")*/
IF (@ls_nivel <> "P") 
BEGIN
--INSERTA LOS REGISTROS CORRESPONDIENTES AL PLAN IDEAL DE LOS ALUMNOS DE LICENCIATURA
	insert into #plan_ideal 
	 SELECT cve_mat=  v_sce_mat_prerrequisito.cve_mat,
  	      materia = v_sce_materias.materia,   
  	      horas_reales = v_sce_materias.horas_reales,   
  	      creditos = v_sce_materias.creditos,   
  	      calificacion = "",
  	      anio = 0,
  	      periodo = 0,
  	      anio_periodo = "",
         periodo_descripcion = "",
		   sigla = v_sce_materias.sigla,
       	estatus_materia = "",
	      semestre_ideal = v_sce_mat_prerrequisito.semestre_ideal       
	    FROM v_sce_academicos,   
  	       v_sce_mat_prerrequisito,   
  	       v_sce_materias  
  	 WHERE ( v_sce_academicos.cve_carrera = v_sce_mat_prerrequisito.cve_carrera ) AND  
  	       ( v_sce_mat_prerrequisito.cve_mat = v_sce_materias.cve_mat ) AND  
  	       ( v_sce_academicos.cve_plan = v_sce_mat_prerrequisito.cve_plan ) AND  
  	       ( ( v_sce_academicos.cuenta = @a_cuenta ) AND  
  	       ( v_sce_mat_prerrequisito.semestre_ideal <> 0 ) ) 
END
ELSE
	IF (@ls_nivel = "P")
	BEGIN
--INSERTA LOS REGISTROS CORRESPONDIENTES AL PLAN IDEAL DE LOS ALUMNOS DE POSGRADO
		insert into #plan_ideal 
		 SELECT cve_mat=  v_sce_mat_prerreq_pos.cve_mat,
  		      materia = v_sce_materias.materia,   
  		      horas_reales = v_sce_materias.horas_reales,   
  		      creditos = v_sce_materias.creditos,   
  		      calificacion = "",
  		      anio = 0,
  		      periodo = 0,
  		      anio_periodo = "",
  		      periodo_descripcion = "",
			   sigla = v_sce_materias.sigla,
  		     	estatus_materia = "",
		      semestre_ideal = v_sce_mat_prerreq_pos.semestre_ideal       
	   	 FROM v_sce_academicos,   
	  	       v_sce_mat_prerreq_pos,   
  		       v_sce_materias  
  		 WHERE ( v_sce_academicos.cve_carrera = v_sce_mat_prerreq_pos.cve_carrera ) AND  
  		       ( v_sce_mat_prerreq_pos.cve_mat = v_sce_materias.cve_mat ) AND  
  		       ( v_sce_academicos.cve_plan = v_sce_mat_prerreq_pos.cve_plan ) AND  
  		       ( ( v_sce_academicos.cuenta = @a_cuenta ) AND  
  		       ( v_sce_mat_prerreq_pos.semestre_ideal <> 0 ) ) 
	END

SELECT @ll_rowcount_plan_ideal = @@rowcount

/*IF (@ls_nivel = "L")*/
IF (@ls_nivel <> "P") 
BEGIN
--INSERTA LAS MATERIAS CURSADAS QUE NO PERTENECEN AL PLAN IDEAL DE LOS ALUMNOS DE LICENCIATURA
	insert into #plan_ideal 
	 SELECT cve_mat=  v_sce_mat_prerrequisito.cve_mat,
  	      materia = v_sce_materias.materia,   
  	      horas_reales = v_sce_materias.horas_reales,   
  	      creditos = v_sce_materias.creditos,   
  	      calificacion = "",
  	      anio = v_sce_historico.anio,
  	      periodo = v_sce_historico.periodo,
  	      anio_periodo = "",
  	      periodo_descripcion = "",
	      sigla = v_sce_materias.sigla,
         estatus_materia = "CURSADA",
	      semestre_ideal = 100      
	    FROM v_sce_academicos,   
  	       v_sce_mat_prerrequisito,   
  	       v_sce_materias,
	       v_sce_historico  
	  	 WHERE ( v_sce_academicos.cve_carrera = v_sce_mat_prerrequisito.cve_carrera ) AND  
  	       ( v_sce_mat_prerrequisito.cve_mat = v_sce_materias.cve_mat ) AND  
  	       ( v_sce_academicos.cve_plan = v_sce_mat_prerrequisito.cve_plan ) AND  
  	       ( v_sce_academicos.cuenta = @a_cuenta ) AND  
  	       ( v_sce_mat_prerrequisito.semestre_ideal = 0 ) AND
          ( v_sce_academicos.cuenta = v_sce_historico.cuenta) AND
			 ( v_sce_academicos.cve_carrera = v_sce_historico.cve_carrera) AND
			 ( v_sce_academicos.cve_plan = v_sce_historico.cve_plan) AND
			 ( v_sce_historico.calificacion in ("AC","6","7","8","9","10", "MB","B","S","E","RE") ) AND
			 ( v_sce_historico.cve_mat =  v_sce_materias.cve_mat) 
END
ELSE
	IF (@ls_nivel = "P")
	BEGIN
--INSERTA LAS MATERIAS CURSADAS QUE NO PERTENECEN AL PLAN IDEAL DE LOS ALUMNOS DE POSGRADO
	insert into #plan_ideal 
	 SELECT cve_mat=  v_sce_mat_prerreq_pos.cve_mat,
  	      materia = v_sce_materias.materia,   
  	      horas_reales = v_sce_materias.horas_reales,   
  	      creditos = v_sce_materias.creditos,   
  	      calificacion = "",
  	      anio = v_sce_historico.anio,
  	      periodo = v_sce_historico.periodo,
  	      anio_periodo = "",
  	      periodo_descripcion = "",
	      sigla = v_sce_materias.sigla,
         estatus_materia = "CURSADA",
	      semestre_ideal = 100      
	    FROM v_sce_academicos,   
  	       v_sce_mat_prerreq_pos,   
  	       v_sce_materias,
	       v_sce_historico  
	  	 WHERE ( v_sce_academicos.cve_carrera = v_sce_mat_prerreq_pos.cve_carrera ) AND  
  	       ( v_sce_mat_prerreq_pos.cve_mat = v_sce_materias.cve_mat ) AND  
  	       ( v_sce_academicos.cve_plan = v_sce_mat_prerreq_pos.cve_plan ) AND  
  	       ( v_sce_academicos.cuenta = @a_cuenta ) AND  
  	       ( v_sce_mat_prerreq_pos.semestre_ideal = 0 ) AND
          ( v_sce_academicos.cuenta = v_sce_historico.cuenta) AND
			 ( v_sce_academicos.cve_carrera = v_sce_historico.cve_carrera) AND
			 ( v_sce_academicos.cve_plan = v_sce_historico.cve_plan) AND
			 ( v_sce_historico.calificacion in ("AC","6","7","8","9","10", "MB","B","S","E","RE") ) AND
			 ( v_sce_historico.cve_mat =  v_sce_materias.cve_mat) 
	END

/*IF (@ls_nivel = "L")*/
IF (@ls_nivel <> "P") 
BEGIN
--INSERTA LAS MATERIAS CURSADAS SI LA CARRERA NO TIENE CARGADO UN PLAN IDEAL DE LOS ALUMNOS DE LICENCIATURA
	insert into #plan_ideal 
	 SELECT cve_mat=  v_sce_historico.cve_mat,
  	      materia = v_sce_materias.materia,   
  	      horas_reales = v_sce_materias.horas_reales,   
  	      creditos = v_sce_materias.creditos,   
  	      calificacion = "",
  	      anio = v_sce_historico.anio,
  	      periodo = v_sce_historico.periodo,
  	      anio_periodo = "",
  	      periodo_descripcion = "",
		   sigla = v_sce_materias.sigla,
     	   estatus_materia = "CURSADA",
			semestre_ideal = 100      
	    FROM v_sce_academicos ac, 
	         v_sce_materias,
				v_sce_historico  
  		WHERE ( ac.cuenta = @a_cuenta ) AND  
				( ac.cuenta = v_sce_historico.cuenta) AND
				( ac.cve_carrera = v_sce_historico.cve_carrera) AND
				( ac.cve_plan = v_sce_historico.cve_plan) AND
				( v_sce_historico.calificacion in ("AC","6","7","8","9","10", "MB","B","S","E","RE") ) AND
				( v_sce_historico.cve_mat =  v_sce_materias.cve_mat) AND
				( v_sce_historico.cve_mat not in (SELECT cve_mat FROM #plan_ideal  pi) )
END
ELSE
	IF (@ls_nivel = "P")
	BEGIN
--INSERTA LAS MATERIAS CURSADAS SI LA CARRERA NO TIENE CARGADO UN PLAN IDEAL DE LOS ALUMNOS DE POSGRADO
	insert into #plan_ideal 
	 SELECT cve_mat=  v_sce_historico.cve_mat,
  	      materia = v_sce_materias.materia,   
  	      horas_reales = v_sce_materias.horas_reales,   
  	      creditos = v_sce_materias.creditos,   
  	      calificacion = "",
  	      anio = v_sce_historico.anio,
  	      periodo = v_sce_historico.periodo,
  	      anio_periodo = "",
  	      periodo_descripcion = "",
		   sigla = v_sce_materias.sigla,
     	   estatus_materia = "CURSADA",
			semestre_ideal = 100      
	    FROM v_sce_academicos ac, 
	         v_sce_materias,
				v_sce_historico  
  		WHERE ( ac.cuenta = @a_cuenta ) AND  
				( ac.cuenta = v_sce_historico.cuenta) AND
				( ac.cve_carrera = v_sce_historico.cve_carrera) AND
				( ac.cve_plan = v_sce_historico.cve_plan) AND
				( v_sce_historico.calificacion in ("AC","6","7","8","9","10", "MB","B","S","E","RE") ) AND
				( v_sce_historico.cve_mat =  v_sce_materias.cve_mat) AND
				( v_sce_historico.cve_mat not in (SELECT cve_mat FROM #plan_ideal  pi) )
	END

/*IF (@ls_nivel = "L")*/
IF (@ls_nivel <> "P")
BEGIN
--INSERTA LAS MATERIAS INSCRITAS SI LA CARRERA NO TIENE CARGADO UN PLAN IDEAL DE LOS ALUMNOS DE LICENCIATURA
	insert into #plan_ideal 
	 SELECT cve_mat=  v_sce_mat_inscritas.cve_mat,
	        materia = v_sce_materias.materia,   
  		     horas_reales = v_sce_materias.horas_reales,   
  		     creditos = v_sce_materias.creditos,   
	        calificacion = "",
  		     anio = v_sce_mat_inscritas.anio,
  	   	  periodo = v_sce_mat_inscritas.periodo,
	        anio_periodo = "",
  	        periodo_descripcion = "",
			  sigla = v_sce_materias.sigla,
           estatus_materia = "CURSANDO",
			  semestre_ideal = 100      
	    FROM v_sce_academicos ac, 
   	      v_sce_materias,
				v_sce_mat_inscritas  
	   WHERE ( ac.cuenta = @a_cuenta ) AND  
				( ac.cuenta = v_sce_mat_inscritas.cuenta) AND
				( v_sce_mat_inscritas.cve_mat =  v_sce_materias.cve_mat) AND
				( v_sce_mat_inscritas.cve_mat not in (SELECT cve_mat FROM #plan_ideal  pi) )
END
ELSE
	IF (@ls_nivel = "P")
	BEGIN
--INSERTA LAS MATERIAS INSCRITAS SI LA CARRERA NO TIENE CARGADO UN PLAN IDEAL DE LOS ALUMNOS DE POSGRADO
	insert into #plan_ideal 
	 SELECT cve_mat=  v_sce_mat_inscritas.cve_mat,
	        materia = v_sce_materias.materia,   
  		     horas_reales = v_sce_materias.horas_reales,   
  		     creditos = v_sce_materias.creditos,   
	        calificacion = "",
  		     anio = v_sce_mat_inscritas.anio,
  	   	  periodo = v_sce_mat_inscritas.periodo,
	        anio_periodo = "",
  	        periodo_descripcion = "",
			  sigla = v_sce_materias.sigla,
           estatus_materia = "CURSANDO",
			  semestre_ideal = 100      
	    FROM v_sce_academicos ac, 
   	      v_sce_materias,
				v_sce_mat_inscritas  
	   WHERE ( ac.cuenta = @a_cuenta ) AND  
				( ac.cuenta = v_sce_mat_inscritas.cuenta) AND
				( v_sce_mat_inscritas.cve_mat =  v_sce_materias.cve_mat) AND
				( v_sce_mat_inscritas.cve_mat not in (SELECT cve_mat FROM #plan_ideal  pi) )

	END



--SI NO EXISTEN REGISTROS INSERTADOS
--IF @ll_rowcount_plan_ideal= 0 
--BEGIN
--END


create unique index idx_plan_ideal
on #plan_ideal(cve_mat)

declare cursor_plan_ideal cursor 
for
select cve_mat,
		calificacion,
		anio,
		periodo,
		anio_periodo,
      periodo_descripcion,
      estatus_materia
from #plan_ideal
for update

-- Abre el cursor 
open cursor_plan_ideal

-- Lee el primer registro 
fetch cursor_plan_ideal
into 
@curl_cve_mat,
@curs_calificacion,
@curl_anio,
@curl_periodo,
@curs_anio_periodo,
@curs_periodo_descripcion,
@curs_estatus_materia

-- El result set se encuentra vacío 

if (@@sqlstatus = 2)
begin
    select @ll_num_error = 20000, @ls_mensaje_error = "No existen materias a Procesar."
    close cursor_plan_ideal
    goto Fin
end

-- Si ocurrio un error, llamar al manejador designado 

if (@@sqlstatus = 1) 
begin
   select @ll_num_error = 20000, @ls_mensaje_error = "Error de lectura en el cursor: cursor_plan_ideal."
	close cursor_plan_ideal
	goto EtiquetaError
end

-- Si el result set contiene elementos , entonces procesar
--cada registro de información 


while (@@sqlstatus = 0)
begin

--INICIALIZA LAS VARIABLES UTILIZADAS EN LA ASIGNACION

  SELECT @ls_calificacion= "",
				 @ll_anio = 0,
				 @ll_periodo = 0,
				 @ls_periodo_descripcion = "",
				 @ls_estatus_materia = "",
				 @ls_anio_periodo = ""

  SELECT @ll_cve_mat_hist  = v_sce_historico.cve_mat,
         @ls_calificacion_hist = v_sce_historico.calificacion,   
         @ll_anio_hist = v_sce_historico.anio,   
         @ll_periodo_hist = v_sce_historico.periodo,   
         @ls_periodo_descripcion_hist =  CASE v_sce_historico.periodo WHEN 0 THEN "PRIMAVERA"
																		WHEN 1 THEN "VERANO"   
																		WHEN 2 THEN "OTOÑO" END,   
			@ls_estatus_materia_hist =  "CURSADA"
    FROM v_sce_historico,   
         v_sce_materias, 
         v_sce_academicos  
   WHERE ( v_sce_historico.cve_mat = v_sce_materias.cve_mat ) and  
--**         ( v_sce_materias.nivel = v_sce_academicos.nivel ) and  
         ( v_sce_academicos.cve_carrera = v_sce_historico.cve_carrera ) and  
         ( v_sce_academicos.cve_plan = v_sce_historico.cve_plan ) and  
         ( v_sce_academicos.cuenta = v_sce_historico.cuenta ) and  
         ( ( v_sce_historico.cuenta = @a_cuenta ) AND  
         ( v_sce_historico.calificacion in ("AC","6","7","8","9","10", "MB","B","S","E","RE") ) )  and
         (  v_sce_historico.cve_mat = @curl_cve_mat )   
	SELECT @ll_rowcount_historico = @@rowcount


  SELECT @ll_cve_mat_mi  = v_sce_mat_inscritas.cve_mat,
         @ls_calificacion_mi = v_sce_mat_inscritas.calificacion,   
         @ll_anio_mi = v_sce_mat_inscritas.anio,   
         @ll_periodo_mi = v_sce_mat_inscritas.periodo,   
         @ls_periodo_descripcion_mi =  CASE v_sce_mat_inscritas.periodo WHEN 0 THEN "PRIMAVERA"
																		WHEN 1 THEN "VERANO"   
																		WHEN 2 THEN "OTOÑO" END,   
			@ls_estatus_materia_mi =  "CURSANDO"
    FROM v_sce_mat_inscritas,   
         v_sce_materias 
   WHERE ( v_sce_mat_inscritas.cve_mat = v_sce_materias.cve_mat ) and
         ( v_sce_mat_inscritas.cuenta = @a_cuenta )  and
         ( v_sce_mat_inscritas.cve_mat = @curl_cve_mat ) and  
         ( isnull(v_sce_mat_inscritas.calificacion,"") not in ("BA") )   

	SELECT @ll_rowcount_mat_inscritas = @@rowcount

--YA CURSO Y APROBO LA MATERIA
	IF @ll_rowcount_historico> 0 
	BEGIN
		SELECT @ls_calificacion= @ls_calificacion_hist,
				 @ll_anio = @ll_anio_hist,
				 @ll_periodo = @ll_periodo_hist,
				 @ls_periodo_descripcion = @ls_periodo_descripcion_hist,
				 @ls_estatus_materia = @ls_estatus_materia_hist
	END
	ELSE

--ESTA CURSANDO LA MATERIA EN LA ACTUALIDAD
      IF @ll_rowcount_mat_inscritas> 0 
  		BEGIN
		SELECT @ls_calificacion= @ls_calificacion_mi,
				 @ll_anio = @ll_anio_mi,
				 @ll_periodo = @ll_periodo_mi,
				 @ls_periodo_descripcion = @ls_periodo_descripcion_mi,
				 @ls_estatus_materia = @ls_estatus_materia_mi
		END
		ELSE
      BEGIN
--NO HA CURSADO ESA MATERIA
			  SELECT @ls_calificacion= "",
				 @ll_anio = 0,
				 @ll_periodo = 0,
				 @ls_periodo_descripcion = "",
				 @ls_estatus_materia = "",
				 @ls_anio_periodo = ""


--REVISA SI CUENTA CON LOS PRERREQUISITOS
				select @ll_curso_prerrequisitos = 0

				exec @ll_resultado = sp_curso_prerrequisitos  @a_cuenta, @curl_cve_mat, @ll_cve_carrera, @ll_cve_plan, @ll_curso_prerrequisitos output

				if @ll_resultado <> 0
				begin
				   select @ll_num_error = 20000, @ls_mensaje_error = "Error al ejecutar sp_curso_prerrequisitos : sp_materias_alumno."
					goto EtiquetaError
				end 

				IF (@ll_curso_prerrequisitos = 1 )
				BEGIN
					SELECT @ls_estatus_materia="DISPONIBLE"
				END
				ELSE
					IF (@ll_curso_prerrequisitos = 0 )
					BEGIN
						SELECT @ls_estatus_materia="NO DISPONIBLE/ PRERREQUISITOS"
					END
					ELSE
						IF (@ll_curso_prerrequisitos = 2 )
						BEGIN
							IF @ll_rowcount_mat_inscritas > 0 
							BEGIN
								SELECT @ls_estatus_materia="OPCION TERMINAL/ CURSANDO"
							END
							ELSE
								IF @ll_rowcount_historico >0 
								BEGIN
									SELECT @ls_estatus_materia="OPCION TERMINAL/ CURSADA"
								END
								ELSE
									BEGIN
										SELECT @ls_estatus_materia="OPCION TERMINAL"
									END
							
						END

				IF (@ll_curso_prerrequisitos = 1 ) OR (@ll_curso_prerrequisitos = 2 )
				BEGIN

--CUENTA LA CANTIDAD DE GRUPOS ABIERTOS
					SELECT @ll_cve_mat_grupos = g.cve_mat
					FROM v_sce_grupos g, v_sce_periodos_por_procesos p
					WHERE g.cve_mat = @curl_cve_mat
					AND	g.periodo = p.periodo
					AND	g.anio = p.anio
					AND 	g.cond_gpo = 1
					AND 	p.cve_proceso= 7				

					SELECT @ll_rowcount_grupos = @@rowcount

--EXISTE AL MENOS UN GRUPO ABIERTO
					IF @ll_rowcount_grupos> 0
					BEGIN		
						IF (@ll_curso_prerrequisitos = 1 )		
						BEGIN
							SELECT @ls_estatus_materia="DISPONIBLE"
						END
						ELSE
							IF (@ll_curso_prerrequisitos = 2 )		
							BEGIN
								SELECT @ls_estatus_materia="OPCION TERMINAL"
							END						
					END
--NO EXISTEN GRUPOS ABIERTOS
					ELSE
					BEGIN
						SELECT @ls_estatus_materia="NO DISPONIBLE/ GRUPOS"
					END 

				END
		END


--ASIGNA EL PERIODO
	select @ls_anio_periodo =  @ls_periodo_descripcion+ " " +convert(varchar(10),@ll_anio)



	update #plan_ideal
	set calificacion = @ls_calificacion,
		anio = @ll_anio,
		periodo = @ll_periodo,
		anio_periodo = @ls_anio_periodo,
		periodo_descripcion = @ls_periodo_descripcion,
		estatus_materia = @ls_estatus_materia
   
	where current of cursor_plan_ideal 
	if @@error != 0 
	begin
	   select @ls_mensaje_error = "Error al actualizar #plan_ideal en cursor: cursor_plan_ideal."
		close cursor_plan_ideal
		goto Fin
	end 

	fetch cursor_plan_ideal
	into 
   @curl_cve_mat,
   @curs_calificacion,
   @curl_anio,
   @curl_periodo,
   @curs_anio_periodo,
   @curs_periodo_descripcion,
   @curs_estatus_materia


end


-- Si ocurrio un error, llamar al manejador designado 

if (@@sqlstatus = 1) 
begin
   select @ls_mensaje_error = "Error de lectura en el cursor: cursor_plan_ideal."
	close cursor_plan_ideal
	goto Fin
end

-- Cierra el cursor
close cursor_plan_ideal

-- Elimina el espacio reservado para el cursor*/
deallocate cursor cursor_plan_ideal


/* Adaptive Server has expanded all '*' elements in the following statement */ select #plan_ideal.cve_mat, #plan_ideal.materia, #plan_ideal.horas_reales, #plan_ideal.creditos, #plan_ideal.calificacion, #plan_ideal.anio, #plan_ideal.periodo, #plan_ideal.anio_periodo, #plan_ideal.periodo_descripcion, #plan_ideal.sigla, #plan_ideal.estatus_materia, #plan_ideal.semestre_ideal 
from #plan_ideal
order by semestre_ideal, anio, periodo, cve_mat



Fin:
--	raiserror @ll_num_error,  @ls_mensaje_error

EtiquetaCorrecto:
	Commit Transaction
	return 0


EtiquetaError:
	raiserror @ll_num_error,  @ls_mensaje_error
	Rollback Transaction
	return -1


GO




GRANT EXECUTE ON dbo.sp_materias_alumno TO g_inf_admin
GO








