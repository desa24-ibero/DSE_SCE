IF OBJECT_ID ('dbo.sp_pase_ingreso_prerreq') IS NOT NULL
	DROP PROCEDURE dbo.sp_pase_ingreso_prerreq
GO

CREATE procedure dbo.sp_pase_ingreso_prerreq 

@a_cuenta integer,

@a_num_rows integer,

@num_error integer output,

@mensaje_error varchar(255) output

as

declare 

@ls_mensaje_error varchar(255),

@ll_num_error integer,

@sem_cursados integer, 

@egresado integer, 

@puede_integracion integer, 

@tema_fundamental_1 integer,

@tema_fundamental_2 integer,

@tema_1 integer,

@tema_2 integer,

@tema_3 integer,

@tema_4 integer,

@digito varchar(1),

@nombre_completo varchar(70),

@carrera varchar(100),

@nombre_plan varchar(20),

@ls_nivel varchar(1),

@ll_curso_prerrequisitos integer,

@ll_resultado integer,

@curl_cve_mat integer, 

@ll_cve_carrera integer, 

@ll_cve_plan integer,

@cur_ll_cve_mat integer,

@cur_ls_materia varchar(75),

@cur_ll_horas_reales integer,

@cur_ll_creditos integer,

@cur_ls_sigla varchar(7),

@cur_ll_semestre_ideal integer,

@cur_ll_cve_subsistema integer,	

@cur_ls_clase_area varchar(3),

@cur_ll_curso_prerreq integer,

@ll_num_rows integer,

@ll_row_actual integer,

@si_no integer 



--NUEVA SINTAXIS PARA CORREGIR EL USO DE RAISERROR        

    DECLARE @ErrorSeverity INT

    DECLARE @ErrorState INT



select 

@ll_cve_carrera = ac.cve_carrera, 

@ll_cve_plan = ac.cve_plan, 

@ls_nivel = ac.nivel,

@sem_cursados = ac.sem_cursados, 

@egresado = ac.egresado, 

@puede_integracion = b.puede_integracion, 

@tema_fundamental_1 = b.tema_fundamental_1,

@tema_fundamental_2 = b.tema_fundamental_2,

@tema_1 = b.tema_1,

@tema_2 = b.tema_2,

@tema_3 = b.tema_3,

@tema_4 = b.tema_4,

@digito = d.digito,

@nombre_completo = al.nombre_completo,

@carrera = c.carrera,

@nombre_plan = p.nombre_plan

FROM academicos ac, banderas b, v_sce_alumno_digito d, alumnos al, carreras c, nombre_plan p

WHERE ac.cuenta = b.cuenta

AND ac.cuenta = d.cuenta

AND ac.cuenta = al.cuenta

AND ac.cve_carrera = c.cve_carrera

AND ac.cve_plan =  p.cve_plan

AND ac.cuenta = @a_cuenta




/*IF (@ls_nivel = 'L')*/
IF (@ls_nivel <> 'P') 

BEGIN

--INSERTA LAS MATERIAS CORRESPONDIENTES AL PLAN IDEAL DE LOS ALUMNOS DE LICENCIATURA,  NO APROBADAS POR EL ALUMNO

 insert into aux_mat_pase_ingreso (cuenta , 

									 cve_carrera , 

									 cve_plan , 

									 cve_mat , 

									 materia , 

									 horas_reales , 

									 creditos , 

									 sigla , 

									 semestre_ideal , 

									 cve_subsistema , 

									 clase_area , 

									 curso_prerreq , 

									 excede_limite , 

									 origen )

  SELECT DISTINCT cuenta = @a_cuenta,

	 cve_carrera = @ll_cve_carrera,

	 cve_plan = @ll_cve_plan,cve_mat=  dbo.mat_prerrequisito.cve_mat,

         materia = dbo.materias.materia,   

         horas_reales = dbo.materias.horas_reales,   

         creditos = dbo.materias.creditos,   

	 sigla = CASE @ll_cve_plan

               			WHEN  6 THEN materias.sigla

	                    	ELSE ISNULL(materias.sigla_anterior,materias.sigla)

	                END,

         semestre_ideal = dbo.mat_prerrequisito.semestre_ideal,

	 cve_subsistema = dbo.mat_prerrequisito.cve_subsistema,

	clase_area = dbo.mat_prerrequisito.clase_area,

	curso_prerreq = 0,

	excede_limite = 0,

	origen = '1PRE'

     FROM dbo.academicos,   

          dbo.mat_prerrequisito,   

          dbo.materias  

    WHERE ( dbo.academicos.cve_carrera = dbo.mat_prerrequisito.cve_carrera ) AND  

          ( dbo.mat_prerrequisito.cve_mat = dbo.materias.cve_mat ) AND  

          ( dbo.academicos.cve_plan = dbo.mat_prerrequisito.cve_plan ) AND  

          ( ( dbo.academicos.cuenta = @a_cuenta ) AND  

          ( dbo.mat_prerrequisito.semestre_ideal <> 0 ) ) AND

          ( mat_prerrequisito.cve_mat not in (select h.cve_mat FROM historico h

			where h.calificacion in('AC','6','7','8','9','10', 'MB','B','S','E','RE')

			and h.cuenta =@a_cuenta )) and

          ( dbo.mat_prerrequisito.cve_mat not in (8763))  



--AND

--	  ( mat_prerrequisito.cve_mat in (select g.cve_mat FROM controlescolar_bd.dbo.grupos g, v_www_periodo_mat_inscritas pmi

--			WHERE g.periodo = pmi.periodo

--			AND g.anio =pmi.anio) )





END

ELSE

 IF (@ls_nivel = 'P')

 BEGIN

--INSERTA LAS MATERIAS CORRESPONDIENTES AL PLAN IDEAL DE LOS ALUMNOS DE POSGRADO NO APROBADAS POR EL ALUMNO

  insert into aux_mat_pase_ingreso  (cuenta , 

									 cve_carrera , 

									 cve_plan , 

									 cve_mat , 

									 materia , 

									 horas_reales , 

									 creditos , 

									 sigla , 

									 semestre_ideal , 

									 cve_subsistema , 

									 clase_area , 

									 curso_prerreq , 

									 excede_limite , 

									 origen )

   SELECT DISTINCT cuenta = @a_cuenta,

	  cve_carrera = @ll_cve_carrera,

	  cve_plan = @ll_cve_plan,cve_mat=  dbo.mat_prerreq_pos.cve_mat,

          materia = dbo.materias.materia,   

          horas_reales = dbo.materias.horas_reales,   

          creditos = dbo.materias.creditos,   

	  sigla = CASE @ll_cve_plan

               			WHEN  6 THEN materias.sigla

	                    	ELSE ISNULL(materias.sigla_anterior,materias.sigla)

	                END,

    	  semestre_ideal = dbo.mat_prerreq_pos.semestre_ideal,

	  cve_subsistema = 0,

	clase_area ='',

	curso_prerreq = 0,

	excede_limite = 0,

	origen = '1PRE'

      FROM dbo.academicos,   

           dbo.mat_prerreq_pos,   

           dbo.materias  

     WHERE ( dbo.academicos.cve_carrera = dbo.mat_prerreq_pos.cve_carrera ) AND  

           ( dbo.mat_prerreq_pos.cve_mat = dbo.materias.cve_mat ) AND  

           ( dbo.academicos.cve_plan = dbo.mat_prerreq_pos.cve_plan ) AND  

           ( ( dbo.academicos.cuenta = @a_cuenta ) AND  

           ( dbo.mat_prerreq_pos.semestre_ideal <> 0 ) ) AND

          ( mat_prerreq_pos.cve_mat not in (select h.cve_mat FROM historico h

			where h.calificacion in('AC','6','7','8','9','10', 'MB','B','S','E','RE')

			and h.cuenta =@a_cuenta )) 

--AND

--	  ( mat_prerreq_pos.cve_mat in (select g.cve_mat FROM controlescolar_bd.dbo.grupos g, v_www_periodo_mat_inscritas pmi

--			WHERE g.periodo = pmi.periodo

--			AND g.anio =pmi.anio) )

 END







--Valores leidos correspondientes al alumno, académica y de sus bloqueos

--select 

--@ll_cve_carrera ,

--@ll_cve_plan ,

--@sem_cursados ,

--@egresado ,

--@puede_integracion ,

--@tema_fundamental_1 ,

--@tema_fundamental_2 ,

--@tema_1 ,

--@tema_2 ,

--@tema_3 ,

--@tema_4 ,

--@digito ,

--@nombre_completo ,

--@carrera ,

--@nombre_plan



--EN ESTE CURSOR RECORRE TODOS LOS REGISTROS PARA REVISAR SI YA CURSO LOS PRERREQUISITOS



declare cursor_prerreq cursor 

for

select cve_mat,

materia,

horas_reales,

creditos,

sigla,

semestre_ideal ,

cve_subsistema	,

clase_area,

curso_prerreq

from aux_mat_pase_ingreso

WHERE cuenta = @a_cuenta

and   origen = '1PRE'

for update



 

-- Abre el cursor 

open cursor_prerreq

 

-- Lee el primer registro 

fetch cursor_prerreq

into 

@cur_ll_cve_mat,

@cur_ls_materia,

@cur_ll_horas_reales,

@cur_ll_creditos,

@cur_ls_sigla,

@cur_ll_semestre_ideal ,

@cur_ll_cve_subsistema	,

@cur_ls_clase_area,

@cur_ll_curso_prerreq 







-- El result set se encuentra vacío 



if (@@sqlstatus = 2)

begin

    select @ll_num_error = 20000, @ls_mensaje_error = "No existen materias a Procesar.",

				@ErrorSeverity = 16,

				@ErrorState = 1

    close cursor_prerreq

	 deallocate cursor_prerreq

	 select @si_no= 1

    goto Fin

end

-- Si ocurrio un error, llamar al manejador designado 



if (@@sqlstatus = 1) 

begin



	select @ll_num_error = 20000, @ll_num_error = 20000,

	@ls_mensaje_error = "Error de lectura en el cursor: cursor_prerreq ."

	close cursor_prerreq 

	select @si_no= 1

    goto Fin



end



 

--Si el result set contiene elementos , entonces procesar

--cada registro de información 



select  @ll_num_rows = count(*),	

	@ll_row_actual =0

from aux_mat_pase_ingreso

where curso_prerreq = 1





while (@@sqlstatus = 0)

begin

 

   select  @ll_row_actual = @ll_row_actual + 1



--REVISA SI CUENTA CON LOS PRERREQUISITOS

    select @ll_curso_prerrequisitos = 0

 

    exec @ll_resultado = sp_curso_prerrequisitos_pi  @a_cuenta, @cur_ll_cve_mat, @ll_cve_carrera, @ll_cve_plan, @ll_curso_prerrequisitos output

 

    if @ll_resultado <> 0

    begin

        select @ll_num_error = 20000, @ls_mensaje_error = 'Error al ejecutar sp_curso_prerrequisitos_pi : sp_pase_ingreso_prerreq.',

				@ErrorSeverity = 16,

				@ErrorState = 1



	close cursor_prerreq

	deallocate cursor_prerreq

       goto EtiquetaError

    end 

 

--Si son menos o iguales



    update aux_mat_pase_ingreso

	set  excede_limite = 0 ,

	     curso_prerreq = @ll_curso_prerrequisitos

    where current of cursor_prerreq

    if @@error != 0 

    begin

    	    select @ls_mensaje_error = 'Error al actualizar 1 aux_mat_pase_ingreso en cursor: cursor_prerreq.',

				@ErrorSeverity = 16,

				@ErrorState = 1



	    close cursor_prerreq

	    deallocate cursor_prerreq

	    goto Fin

    end 

 

 fetch cursor_prerreq

 into 

  @cur_ll_cve_mat,

  @cur_ls_materia,

  @cur_ll_horas_reales,

  @cur_ll_creditos,

  @cur_ls_sigla,

  @cur_ll_semestre_ideal ,

  @cur_ll_cve_subsistema,

  @cur_ls_clase_area,

  @cur_ll_curso_prerreq





end

 

-- Si ocurrio un error, llamar al manejador designado 

 

if (@@sqlstatus = 1) 

begin



	select @ll_num_error = 20000, @ll_num_error = 20000,

	@ls_mensaje_error = "Error de lectura en el cursor: cursor_prerreq ."

	close cursor_prerreq 

	select @si_no= 1

    goto Fin



end





 

-- Cierra el cursor

close cursor_prerreq

 

                                                   

deallocate cursor_prerreq





--EN ESTE CURSOR RECORRE SOLO LOS PRIMEROS N=@a_num_rows REGISTROS PARA LIMITAR EL NUMERO DE MATERIAS A MOSTRAR



declare cursor_prerreq2 cursor 

for

select cve_mat,

materia,

horas_reales,

creditos,

sigla,

semestre_ideal ,

cve_subsistema	,

clase_area,

curso_prerreq

from aux_mat_pase_ingreso

where curso_prerreq = 1

AND cuenta = @a_cuenta

and   origen = '1PRE'

order by semestre_ideal, materia



-- Abre el cursor 

open cursor_prerreq2

 

-- Lee el primer registro 

fetch cursor_prerreq2

into 

@cur_ll_cve_mat,

@cur_ls_materia,

@cur_ll_horas_reales,

@cur_ll_creditos,

@cur_ls_sigla,

@cur_ll_semestre_ideal ,

@cur_ll_cve_subsistema	,

@cur_ls_clase_area,

@cur_ll_curso_prerreq 





if (@@sqlstatus = 2)

begin

    select @ll_num_error = 20000, @ls_mensaje_error = "No existen materias a Procesar.",

				@ErrorSeverity = 16,

				@ErrorState = 1

    close cursor_prerreq2

	 deallocate cursor_prerreq2

	 select @si_no= 1

    goto Fin

end

-- Si ocurrio un error, llamar al manejador designado 



if (@@sqlstatus = 1) 

begin



	select @ll_num_error = 20000, @ll_num_error = 20000,

	@ls_mensaje_error = "Error de lectura en el cursor: cursor_prerreq2 ."

	close cursor_prerreq2 

	select @si_no= 1

    goto Fin



end

 

--Si el result set contiene elementos , entonces procesar

--cada registro de información 



select  @ll_num_rows = count(*),	

	@ll_row_actual =0

from aux_mat_pase_ingreso

where curso_prerreq = 1





while (@@sqlstatus = 0)

begin

 

   select  @ll_row_actual = @ll_row_actual + 1



--Si son menos o iguales

  IF (@a_num_rows = 0) OR (@ll_row_actual <= @a_num_rows) 

  BEGIN

	 update aux_mat_pase_ingreso

	 set  excede_limite = 0 

	 where cuenta = @a_cuenta

	 and cve_mat = @cur_ll_cve_mat

	 if @@error != 0 

	 begin

	    select @ls_mensaje_error = 'Error al actualizar 1 aux_mat_pase_ingreso en cursor: cursor_prerreq2.',

				@ErrorSeverity = 16,

				@ErrorState = 1



	    close cursor_prerreq2

	    deallocate cursor_prerreq2

	    goto Fin

	 end 

  END

  ELSE

  BEGIN

	 update aux_mat_pase_ingreso

	 set excede_limite = 1

	 where cuenta = @a_cuenta

	 and cve_mat = @cur_ll_cve_mat

	 if @@error != 0 

	 begin	

	    select @ls_mensaje_error = 'Error al actualizar 2 aux_mat_pase_ingreso en cursor: cursor_prerreq2.',

				@ErrorSeverity = 16,

				@ErrorState = 1



	    close cursor_prerreq2

	    deallocate cursor_prerreq2

	    goto Fin

	 end 



  END



 

 fetch cursor_prerreq2

 into 

  @cur_ll_cve_mat,

  @cur_ls_materia,

  @cur_ll_horas_reales,

  @cur_ll_creditos,

  @cur_ls_sigla,

  @cur_ll_semestre_ideal ,

  @cur_ll_cve_subsistema,

  @cur_ls_clase_area,

  @cur_ll_curso_prerreq





end

 

-- Si ocurrio un error, llamar al manejador designado 

 



if (@@sqlstatus = 1) 

begin



	select @ll_num_error = 20000, @ll_num_error = 20000,

	@ls_mensaje_error = "Error de lectura en el cursor: cursor_prerrequisitos ."

	close cursor_prerreq2 

	select @si_no= 1

    goto Fin



end



 

-- Cierra el cursor

close cursor_prerreq2

 

                                                   

deallocate cursor_prerreq2









--INCREMENTA EL CONTADOR DE HITS

Fin:



insert into mat_pase_ingreso

select cuenta , 

									 cve_carrera , 

									 cve_plan , 

									 cve_mat , 

									 materia , 

									 horas_reales , 

									 creditos , 

									 sigla , 

									 semestre_ideal , 

									 cve_subsistema , 

									 clase_area , 

									 curso_prerreq , 

									 excede_limite , 

									 origen  from aux_mat_pase_ingreso p

where p.curso_prerreq = 1

AND p.excede_limite = 0

AND NOT EXISTS(SELECT cuenta from mat_pase_ingreso

where cuenta = p.cuenta

and   cve_carrera = p.cve_carrera

and   cve_plan = p.cve_plan

and   cve_mat = p.cve_mat)

and   p.cve_mat not in (8580,8581)

and   p.origen = '1PRE'

and   p.cuenta = @a_cuenta

order by cuenta, cve_mat, semestre_ideal, materia



 

EtiquetaCorrecto:

select @num_error = 0, @mensaje_error = ''



-- Commit Transaction

 return 0

 

EtiquetaError:

 select @num_error = @ll_num_error, @mensaje_error = @ls_mensaje_error

 RAISERROR 20000, @ls_mensaje_error

-- Rollback Transaction

 return -1
GO

