USE web_bd
go


ALTER PROCEDURE [dbo].[sp_preinscr_materia]
@CUENTA int,
@MATERIA int,     
 @GRUPO varchar(2),     
 @CARRERA int,
@PLAN int,
@NIVEL varchar(1)
AS 
DECLARE @TMATERIA integer
DECLARE @CUPO integer
DECLARE @TPREINSCR integer
DECLARE @TPLAN integer
DECLARE @revisa_gpo_bloqueado integer
DECLARE @termino integer 
DECLARE @tmpgpo varchar(2) 
DECLARE @tmpcarrera integer 
DECLARE @bgpo integer 
DECLARE @bcar integer 
DECLARE @tmpplan integer 
DECLARE @PERIODO integer
DECLARE @ANIO integer 
DECLARE @MERROR integer
DECLARE @THIJO integer
DECLARE @retval integer
DECLARE @MENSAJE varchar(254),	@msg varchar(254), @retorno int, @lerr int, @lrwc int
DECLARE @CONMENSAJES integer, @matinscrita integer
DECLARE @cve_parametro integer
DECLARE @permite_materias_repetidas integer
DECLARE @permite_materias_encimadas integer
DECLARE @valida_demanda_inscritos integer
DECLARE @valida_prerrequisitos integer
DECLARE @ll_curso_prerrequisitos integer
DECLARE @ll_resultado integer
DECLARE @inscritos integer
DECLARE @demanda_inscritos integer

DECLARE @tipo_periodo varchar(3)  

SELECT @cve_parametro =cve_parametro,
       @permite_materias_repetidas = permite_materias_repetidas,
       @permite_materias_encimadas = permite_materias_encimadas,
       @tipo_periodo = tipo_periodo,
	   @valida_demanda_inscritos = valida_demanda_inscritos,
	   @valida_prerrequisitos = valida_prerrequisitos
FROM [controlescolar_bd].[dbo].[parametros_reinscripcion]
WHERE [cve_parametro] = 1



--Valida que exista la materia
SELECT  @TMATERIA=count(*) FROM dbo.v_www_materias WHERE cve_mat=@MATERIA
if @TMATERIA>0
begin
  SELECT @CUPO=cupo
  FROM dbo.v_www_grupos
  WHERE dbo.v_www_grupos.cve_mat = @MATERIA AND dbo.v_www_grupos.gpo=@GRUPO
--Valida que el grupo tenga un cupo definido
  if @CUPO is not NULL
   begin   
--Valida que el grupo tenga cupo mayor a cero, si tiene cero no podra preinscribirse
    if @CUPO > 0
    begin
     SELECT @TPREINSCR=count(a.cuenta) 
     FROM controlescolar_bd.dbo.mat_preinsc a, dbo.v_www_periodo_preinscripcion b
     WHERE a.anio=b.anio AND a.periodo=b.periodo AND a.cuenta=@CUENTA
                  AND a.cve_mat=@MATERIA AND a.gpo=@GRUPO
 
--Si es un grupo de intercambio
       IF @GRUPO='ZZ'
                begin
--Revisa que esté inscrito en intercambio
                IF NOT EXISTS   (SELECT                1
                                              FROM   v_www_dcaPeriodoEstancia,
                                                       dbo.v_www_periodo_preinscripcion
                                              WHERE v_www_dcaPeriodoEstancia.noFolioCuenta = @CUENTA
                                              AND      v_www_dcaPeriodoEstancia.anio = dbo.v_www_periodo_preinscripcion.anio
                                              AND      v_www_dcaPeriodoEstancia.periodo = dbo.v_www_periodo_preinscripcion.periodo
                                              AND      v_www_dcaPeriodoEstancia.tipoalumno = 'I')
                                               begin
                                               SELECT -90,'No está inscrito como alumno de Intercambio'
                                                               return -90
                                               end
                end
 
--Valida que dicha materia no se haya preinscrito con anterioridad
     if @TPREINSCR=0
      begin 
--Si el alumno es de licenciatura, valida que pertenezca a su plan de estudios
       --IF @NIVEL='L'
       IF @NIVEL <> 'P'
        begin
          SELECT @TPLAN=count(cve_mat) 
          FROM dbo.v_www_pert_plan_lic
          WHERE cve_mat=@MATERIA AND cve_carrera=@CARRERA AND cve_plan=@PLAN
        end 
--Si el alumno NO es de licenciatura, valida que pertenezca a su plan de estudios
       --IF @NIVEL<>'L'
       IF @NIVEL = 'P'
        begin 
          SELECT @TPLAN=count(cve_mat) 
          FROM dbo.v_www_pert_plan_pos
          WHERE cve_mat=@MATERIA AND cve_carrera=@CARRERA AND cve_plan=@PLAN
        end


	SET	@CONMENSAJES = 0
	SET @MENSAJE = ''
--2016-06-21 Antonio Pica Ruiz
--Se incluyó validación para que realice la validación contra la demanda de inscritos es decir, 
--si la demanda de inscritos es mayor o igual al cupo del grupo, no permitirá la inscripción

	IF @valida_demanda_inscritos = 1
	BEGIN 
		--Obtiene los inscritos del grupo y la demanda de inscritos resultante de la simulación
		SELECT @CUPO = ISNULL(grupos.cupo,0),
			   @inscritos = ISNULL(grupos.inscritos,0),
			   @demanda_inscritos = ISNULL(grupos.demanda_inscritos,0)
		FROM controlescolar_bd.dbo.grupos grupos, dbo.v_www_periodo_preinscripcion b
		WHERE grupos.cve_mat = @MATERIA
		AND grupos.gpo = @GRUPO
		AND grupos.anio=b.anio AND grupos.periodo=b.periodo
	
		IF @demanda_inscritos >= @CUPO --84, EL GRUPO YA ESTÁ LLENO
		BEGIN
			SET @msg = 'El grupo solicitado se llenó durante la simulación del primer ciclo, intente otro grupo.'
			IF @CONMENSAJES <> 0 print @msg
			SET @MENSAJE = @msg
			SELECT -84, @msg
			RETURN -84
		END 
	END

	SET	@CONMENSAJES = 0
	SET @MENSAJE = ''



	SET	@CONMENSAJES = 0
	SET @MENSAJE = ''
--2016-06-10 Antonio Pica Ruiz
--Se incluyó validación para que no permita inscribir la misma materia si ya existe una inscrita con otro grupo
	IF @permite_materias_repetidas = 0
	BEGIN 
		SELECT @matinscrita = ISNULL(mat_preinsc.cve_mat,0)
		FROM controlescolar_bd.dbo.mat_preinsc mat_preinsc
		where cuenta = @CUENTA
		and cve_mat = @MATERIA
	
		IF @matinscrita > 0 --72, LA MATERIA YA ESTÁ INSCRITA
		BEGIN
			SET @msg = 'La misma materia ya está inscrita.'
			IF @CONMENSAJES <> 0 print @msg
			SET @MENSAJE = @msg
			SELECT -72, @msg
			RETURN -72
		END 
	END

	SET	@CONMENSAJES = 0
	SET @MENSAJE = ''

--2016-06-10 Antonio Pica Ruiz
--Se incluyó validación para que no permita inscribir una materia si esta se encima con otra materia existente

	IF @permite_materias_encimadas = 0
	BEGIN 
		EXEC @retval = controlescolar_bd.dbo.sp_mat_preinsc_encimadas @CUENTA,@MATERIA,@GRUPO,@CONMENSAJES
		IF @retval <> 0
		BEGIN
			SET @msg = 'El horario de la materia se traslapa con otra.'
			IF @CONMENSAJES <> 0 print @msg
			SET @MENSAJE = @msg
			SELECT -87, @msg
			RETURN -87
		END
	END	
	

	
	SET	@CONMENSAJES = 0
	SET @MENSAJE = ''

--2016-10-26 Antonio Pica Ruiz
--Se incluyó validación para que no permita inscribir una materia si el alumno no ha cursado o está cursando los prerrequisitos necesarios

	IF @valida_prerrequisitos = 1
	BEGIN 
/*Validar los prerequisitos de la materia.*/
		EXEC @retval = controlescolar_bd.dbo.sp_valida_prerequisitos_reinsc @CUENTA, @MATERIA, @CARRERA, @PLAN,@CONMENSAJES
		IF @retval <> 0
		BEGIN
			SET @msg = 'La materia no está disponible por no haber cursado Todos los Prerrequisitos Necesarios.'
			IF @CONMENSAJES <> 0 print @msg
				SET @MENSAJE = @msg
				SELECT -90, @msg
				RETURN -90
		END
	END

--Valida si la materia pertenece a su plan de estudios
       IF @TPLAN<>0
                                 begin
--Si la materia es el servicio social
                                                               IF @MATERIA = 8763
--Valida que tenga inscrito el servicio social
                                                                              IF NOT EXISTS   (SELECT                1
                                                                                                                            FROM   formacionv_bd.dbo.sss_alumno_plaza,
                                                                                                                             dbo.v_www_periodo_preinscripcion
                                                                                                                            WHERE formacionv_bd.dbo.sss_alumno_plaza.cuenta = @CUENTA
                      AND                      formacionv_bd.dbo.sss_alumno_plaza.anio = dbo.v_www_periodo_preinscripcion.anio
                                                                                                                            AND                      formacionv_bd.dbo.sss_alumno_plaza.periodo IN (dbo.v_www_periodo_preinscripcion.periodo,dbo.v_www_periodo_preinscripcion.periodo - 1)
                                                                                                                            AND                      formacionv_bd.dbo.sss_alumno_plaza.sss_alumno_plaza_act = 1)
                                                                                              begin
                                                                                                              SELECT -89,'No tiene inscrito el proyecto de Servicio Social'
                                                                                                                                                             return -89
                                                                                              end
--Este cursor sirve para validar que el grupo no este bloqueado para alguna carrera
--distinta a la del alumno
         select @revisa_gpo_bloqueado=0
         select @termino=0
--Obtiene los grupos bloqueados de dicha materia
         DECLARE GPOBLOQUEADO CURSOR FOR 
         SELECT gpo,cve_carrera,cve_plan
         FROM dbo.v_www_grupos_bloqueados
         WHERE cve_mat=@MATERIA
         OPEN GPOBLOQUEADO
         FETCH NEXT FROM GPOBLOQUEADO INTO @tmpgpo, @tmpcarrera,@tmpplan
--Si hay registros
         IF @@FETCH_STATUS=0
          begin
--Revisa si el alumno es de la carrera autorizada para el grupo
           WHILE  @@FETCH_STATUS = 0 AND @termino=0
            BEGIN  
             select @bgpo=0
             select @bcar=0
             if @tmpgpo=@GRUPO
              begin
               select @bgpo=1
              end
             IF @tmpcarrera=@CARRERA and @tmpplan=@PLAN
              begin
               select @bcar=1
              end 
             if @bgpo =1 and @bcar=1
              begin
               select @revisa_gpo_bloqueado=0
               select @termino=1
              end
             else
              begin
               if @bgpo=1 OR @bcar=1
                begin
                 select @revisa_gpo_bloqueado=1
                end
              end
             FETCH NEXT FROM GPOBLOQUEADO INTO  @tmpgpo, @tmpcarrera,@tmpplan
            END
          END 
         ELSE
          BEGIN
           select @revisa_gpo_bloqueado=0
           select @termino=1
          END
         CLOSE GPOBLOQUEADO 
         DEALLOCATE  GPOBLOQUEADO  
--Si es un grupo para otras carreras
         if @termino=0 and @revisa_gpo_bloqueado=1
          begin
                SELECT -85,'Grupo especial para alumnos de otras carreras'
                                                               return -85
          end
         else
          begin
                                                               begin transaction Actualiza   
                                                               SELECT @PERIODO=periodo, @ANIO=anio  from dbo.v_www_periodo_preinscripcion  
                INSERT INTO controlescolar_bd.dbo.mat_preinsc(cuenta, cve_mat, gpo, status, periodo,anio,orden,tipo)
                                                  select @CUENTA, @MATERIA,@GRUPO,0,@PERIODO,@ANIO,max(isnull(orden,0))+1,1 
                                                               from controlescolar_bd.dbo.mat_preinsc 
                                                  SELECT @MERROR=(case when @@ERROR<>0 then @@ERROR else 0 end)
                                                               INSERT INTO controlescolar_bd.dbo.movmat_preinsc(cuenta,cve_mat,gpo,status,periodo,anio,movimiento)
                                 select @CUENTA,@MATERIA,@GRUPO,0,@PERIODO,@ANIO,'IN'        
                                                               SELECT @MERROR=(case when @@ERROR<>0 then @@ERROR else 0 end)
                                                               select @THIJO=COUNT (*) FROM controlescolar_bd.dbo.preinsc
                                                               WHERE cuenta=@CUENTA and anio=@ANIO and periodo=@PERIODO
                                                               if @THIJO=0
                                                                              begin
                                                                                              INSERT INTO controlescolar_bd.dbo.preinsc(cuenta, folio, status, periodo,anio)
                                                                                              select @CUENTA,(case when  max(folio)> 99999 then max(folio)+1 else 100000 end),2,
                                                                                              @PERIODO,@ANIO from controlescolar_bd.dbo.preinsc
                                                                                              SELECT @MERROR=(case when @@ERROR<>0 then @@ERROR else 0 end)
                                                                              end
           if @MERROR<>0
            begin
                                                                              rollback transaction Actualiza 
                select -1, 'Error al insertar la materia en la reinscripcion'
                                                                              return -1
            end
           else
            begin
                                                                              commit transaction Actualiza 
                            select 0,'OK'             
            end
          end
        end
       IF @TPLAN=0
        begin
         select -73, 'Materia no pertenece al plan de estudios'
                                               return -73
        end
      end
     if @TPREINSCR<>0
      begin
                select -72, 'Materia ya Reinscrita'
                                               return -72
      end
    end 
    if @CUPO <= 0
    begin
                select -84, 'Grupo con cupo cero'
                               return -84
    end           
   end 
  if @CUPO is NULL
   begin
                select -83, 'Grupo Inexistente'
                               return -83
   end 
 end 
if @TMATERIA<=0
begin
                select -70, 'Materia Inexistente'
                return -70
end
 
 

GO

