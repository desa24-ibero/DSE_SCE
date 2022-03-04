ALTER procedure [dbo].[sp_pase_ingreso_opt] 
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
@ll_cve_subsistema integer,
@cur_ll_cve_mat integer,
@cur_ls_materia varchar(75),
@cur_ll_horas_reales integer,
@cur_ll_creditos integer,
@cur_ls_sigla varchar(7),
@cur_ll_semestre_ideal integer,
@cur_ll_cve_subsistema integer,	
@cur_ls_clase_area varchar(3),
@cur_ll_curso_prerreq integer,
@ll_cve_area_subsistema integer,
@ll_num_rows integer,
@ll_row_actual integer,
@cve_flag_serv_social integer,
@cve_coordinacion integer

--NUEVA SINTAXIS PARA CORREGIR EL USO DE RAISERROR        
     DECLARE @ErrorSeverity INT
    DECLARE @ErrorState INT

select 
@ll_cve_carrera = ac.cve_carrera, 
@ll_cve_plan = ac.cve_plan, 
@ll_cve_subsistema = ac.cve_subsistema,
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
@nombre_plan = p.nombre_plan,
@cve_flag_serv_social = b.cve_flag_serv_social,
@cve_coordinacion = c.cve_coordinacion
FROM v_www_academicos ac, v_www_banderas b, v_www_alumno_digito d, v_www_alumnos al, v_www_carreras c, v_www_nombre_plan p
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
 insert into aux_mat_pase_ingreso 

	SELECT DISTINCT cuenta = @a_cuenta,
		cve_carrera = @ll_cve_carrera,
		cve_plan = @ll_cve_plan,
		cve_mat=  dbo.v_www_mat_prerrequisito.cve_mat,
	        materia = dbo.v_www_materias_1.materia,   
        	horas_reales = dbo.v_www_materias_1.horas_reales,   
	        creditos = dbo.v_www_materias_1.creditos,   
		sigla = CASE @ll_cve_plan
               			WHEN  6 THEN v_www_materias_1.sigla
	                    	ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
	                END,
	        semestre_ideal = dbo.v_www_mat_prerrequisito.semestre_ideal,
		cve_subsistema = dbo.v_www_mat_prerrequisito.cve_subsistema,
		clase_area = dbo.v_www_mat_prerrequisito.clase_area,
		curso_prerreq = 0,
		excede_limite = 0,
		origen = '3OPT'
	FROM        v_www_mat_prerrequisito 
	INNER JOIN  v_www_area_mat 
                ON  v_www_mat_prerrequisito.cve_mat = v_www_area_mat.cve_mat 
        INNER JOIN  v_www_materias_1 
                ON  v_www_mat_prerrequisito.cve_mat = v_www_materias_1.cve_mat
        INNER JOIN  v_www_subsistema 
                ON  v_www_subsistema.cve_area = v_www_area_mat.cve_area
        WHERE     (v_www_mat_prerrequisito.cve_plan = @ll_cve_plan) 
                AND (v_www_mat_prerrequisito.cve_carrera = @ll_cve_carrera) 
                AND (v_www_area_mat.cve_area = v_www_subsistema.cve_area)
                AND (v_www_subsistema.cve_carrera = @ll_cve_carrera)
                AND (v_www_subsistema.cve_plan = @ll_cve_plan)
                AND (v_www_subsistema.cve_subsistema = @ll_cve_subsistema)
          	AND ( v_www_mat_prerrequisito.cve_mat not in (select h.cve_mat FROM v_www_historico h
			where h.calificacion in('AC','6','7','8','9','10', 'MB','B','S','E','RE')
			and h.cuenta =@a_cuenta )) 
--	  	AND ( v_www_mat_prerrequisito.cve_mat in (select g.cve_mat FROM controlescolar_bd.dbo.grupos g, v_www_periodo_mat_inscritas pmi
--			WHERE g.periodo = pmi.periodo
--			AND g.anio =pmi.anio) )
--          ( dbo.v_www_mat_prerrequisito.semestre_ideal <> 0 ) ) AND



	if (@cve_flag_serv_social = 1) 
	BEGIN

	insert into aux_mat_pase_ingreso 

	SELECT DISTINCT cuenta = @a_cuenta,
		cve_carrera = @ll_cve_carrera,
		cve_plan = @ll_cve_plan,
		cve_mat=  dbo.v_www_mat_prerrequisito.cve_mat,
	        materia = dbo.v_www_materias_1.materia,   
        	horas_reales = dbo.v_www_materias_1.horas_reales,   
	        creditos = dbo.v_www_materias_1.creditos,   
		sigla = CASE @ll_cve_plan
               			WHEN  6 THEN v_www_materias_1.sigla
	                    	ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
	                END,
	        semestre_ideal = dbo.v_www_mat_prerrequisito.semestre_ideal,
		cve_subsistema = dbo.v_www_mat_prerrequisito.cve_subsistema,
		clase_area = dbo.v_www_mat_prerrequisito.clase_area,
		curso_prerreq = 0,
		excede_limite = 0,
		origen = '4SS'	
		FROM v_www_area_mat, v_www_materias_1, v_www_plan_estudios, v_www_mat_prerrequisito
		WHERE v_www_area_mat.cve_mat = v_www_materias_1.cve_mat
		and v_www_area_mat.cve_area =v_www_plan_estudios.cve_area_servicio_social
		and v_www_plan_estudios.cve_carrera = @ll_cve_carrera
		and v_www_plan_estudios.cve_plan = @ll_cve_plan
		and v_www_mat_prerrequisito.cve_mat = v_www_materias_1.cve_mat
		and v_www_mat_prerrequisito.cve_carrera = v_www_plan_estudios.cve_carrera
		and v_www_mat_prerrequisito.cve_plan = v_www_plan_estudios.cve_plan
          	and ( v_www_mat_prerrequisito.cve_mat not in (select h.cve_mat FROM v_www_historico h
			where h.calificacion in('AC','6','7','8','9','10', 'MB','B','S','E','RE')
			and h.cuenta =@a_cuenta )) 

--	  	AND ( v_www_mat_prerrequisito.cve_mat in (select g.cve_mat FROM controlescolar_bd.dbo.grupos g, v_www_periodo_mat_inscritas pmi
--			WHERE g.periodo = pmi.periodo
--			AND g.anio =pmi.anio) z)

	END


END
ELSE
 IF (@ls_nivel = 'P')
 BEGIN
--INSERTA LAS MATERIAS CORRESPONDIENTES AL PLAN IDEAL DE LOS ALUMNOS DE POSGRADO NO APROBADAS POR EL ALUMNO
  insert into aux_mat_pase_ingreso 

	SELECT DISTINCT cuenta = @a_cuenta,
		cve_carrera = @ll_cve_carrera,
		cve_plan = @ll_cve_plan,
		cve_mat=  dbo.v_www_mat_prerreq_pos.cve_mat,
	        materia = dbo.v_www_materias_1.materia,   
        	horas_reales = dbo.v_www_materias_1.horas_reales,   
	        creditos = dbo.v_www_materias_1.creditos,   
		sigla = CASE @ll_cve_plan
               			WHEN  6 THEN v_www_materias_1.sigla
	                    	ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
	                END,
	        semestre_ideal = dbo.v_www_mat_prerreq_pos.semestre_ideal,
		cve_subsistema = 0,
		clase_area = '',
		curso_prerreq = 0,
		excede_limite = 0,
		origen = '3OPT'	
		FROM v_www_area_mat, v_www_materias_1, v_www_plan_estudios, v_www_mat_prerreq_pos
		WHERE v_www_area_mat.cve_mat = v_www_materias_1.cve_mat
		and v_www_area_mat.cve_area =v_www_plan_estudios.cve_area_mayor_opt
		and v_www_plan_estudios.cve_carrera = @ll_cve_carrera
		and v_www_plan_estudios.cve_plan = @ll_cve_plan
		and v_www_mat_prerreq_pos.cve_mat = v_www_materias_1.cve_mat
		and v_www_mat_prerreq_pos.cve_carrera = v_www_plan_estudios.cve_carrera
		and v_www_mat_prerreq_pos.cve_plan = v_www_plan_estudios.cve_plan
          	AND ( v_www_mat_prerreq_pos.cve_mat not in (select h.cve_mat FROM v_www_historico h
			where h.calificacion in('AC','6','7','8','9','10', 'MB','B','S','E','RE')
			and h.cuenta =@a_cuenta )) 
		and v_www_materias_1.cve_coordinacion = @cve_coordinacion


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
and   origen in ( '3OPT', '4SS' )
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
if not(@@CURSOR_ROWS <= -1 OR @@CURSOR_ROWS >= 1)
begin
    select @ll_num_error = @@CURSOR_ROWS, @ls_mensaje_error = '@@CURSOR_ROWS',
				@ErrorSeverity = 16,
				@ErrorState = 1
    close cursor_prerreq
    deallocate cursor_prerreq
    goto Fin
end


if (@@FETCH_STATUS = -1)
begin
    select @ll_num_error = 20000, @ls_mensaje_error = 'FETCH statement failed or the row was beyond the result set.',
				@ErrorSeverity = 16,
				@ErrorState = 1
    close cursor_prerreq
    deallocate cursor_prerreq
    goto Fin
end
 
-- Si ocurrio un error, llamar al manejador designado 
 
if (@@FETCH_STATUS <> 0)
begin
   select @ll_num_error = 20000, @ls_mensaje_error = '*Error de lectura en el cursor: cursor_prerreq.',
				@ErrorSeverity = 16,
				@ErrorState = 1
   close cursor_prerreq
   deallocate cursor_prerreq
   goto EtiquetaError
end
 
--Si el result set contiene elementos , entonces procesar
--cada registro de información 
 
while (@@FETCH_STATUS = 0)
begin
 



--REVISA SI CUENTA CON LOS PRERREQUISITOS
    select @ll_curso_prerrequisitos = 0
 
    exec @ll_resultado = sp_curso_prerrequisitos_pi  @a_cuenta, @cur_ll_cve_mat, @ll_cve_carrera, @ll_cve_plan, @ll_curso_prerrequisitos output
 
    if @ll_resultado <> 0
    begin
        select @ll_num_error = 20000, @ls_mensaje_error = 'Error al ejecutar sp_curso_prerrequisitos_pi : sp_pase_ingreso_opt.',
				@ErrorSeverity = 16,
				@ErrorState = 1
	close cursor_prerreq
	deallocate cursor_prerreq
       goto EtiquetaError
    end 
 
 update aux_mat_pase_ingreso
 set  curso_prerreq = @ll_curso_prerrequisitos
 where current of cursor_prerreq 
 if @@error != 0 
 begin
    select @ls_mensaje_error = 'Error al actualizar aux_mat_pase_ingreso en cursor: cursor_prerreq.',
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
 
if (@@ERROR <> 0) 
begin
   select @ls_mensaje_error = '**Error de lectura en el cursor: cursor_prerreq.',
				@ErrorSeverity = 16,
				@ErrorState = 1
 close cursor_prerreq
 deallocate cursor_prerreq
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
and   origen in ( '3OPT', '4SS' )
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

-- El result set se encuentra vacío 
if not(@@CURSOR_ROWS <= -1 OR @@CURSOR_ROWS >= 1)
begin
    select @ll_num_error = @@CURSOR_ROWS, @ls_mensaje_error = '@@CURSOR_ROWS',
				@ErrorSeverity = 16,
				@ErrorState = 1
    close cursor_prerreq2
    deallocate cursor_prerreq2
    goto Fin
end


if (@@FETCH_STATUS = -1)
begin
    select @ll_num_error = 20000, @ls_mensaje_error = 'FETCH statement failed or the row was beyond the result set.',
				@ErrorSeverity = 16,
				@ErrorState = 1
    close cursor_prerreq2
    deallocate cursor_prerreq2
    goto Fin
end
 
-- Si ocurrio un error, llamar al manejador designado 
 
if (@@FETCH_STATUS <> 0)
begin
   select @ll_num_error = 20000, @ls_mensaje_error = '*Error de lectura en el cursor: cursor_prerreq2.',
				@ErrorSeverity = 16,
				@ErrorState = 1
   close cursor_prerreq2
   deallocate cursor_prerreq2
   goto EtiquetaError
end
 
--Si el result set contiene elementos , entonces procesar
--cada registro de información 

select  @ll_num_rows = count(*),	
	@ll_row_actual =0
from aux_mat_pase_ingreso
where curso_prerreq = 1


while (@@FETCH_STATUS = 0)
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
 
if (@@ERROR <> 0) 
begin
   select @ls_mensaje_error = '**Error de lectura en el cursor: cursor_prerreq2.',
				@ErrorSeverity = 16,
				@ErrorState = 1
 close cursor_prerreq2
 deallocate cursor_prerreq2
 goto Fin
end
 
-- Cierra el cursor
close cursor_prerreq2
 
                                                   
deallocate cursor_prerreq2



--INCREMENTA EL CONTADOR DE HITS
Fin:

insert into mat_pase_ingreso
select * from aux_mat_pase_ingreso p
where p.curso_prerreq = 1
AND p.excede_limite = 0
AND NOT EXISTS(SELECT cuenta from mat_pase_ingreso
where cuenta = p.cuenta
and   cve_carrera = p.cve_carrera
and   cve_plan = p.cve_plan
and   cve_mat = p.cve_mat)
and   p.origen in ( '3OPT', '4SS' )
and   p.cuenta = @a_cuenta
order by cuenta, cve_mat, semestre_ideal, materia


 
EtiquetaCorrecto:
select @num_error = 0, @mensaje_error = ''

-- Commit Transaction
 return 0
 
EtiquetaError:
 select @num_error = @ll_num_error, @mensaje_error = @ls_mensaje_error
 RAISERROR (@ls_mensaje_error, @ErrorSeverity, @ErrorState)
-- Rollback Transaction
 return -1


GO

