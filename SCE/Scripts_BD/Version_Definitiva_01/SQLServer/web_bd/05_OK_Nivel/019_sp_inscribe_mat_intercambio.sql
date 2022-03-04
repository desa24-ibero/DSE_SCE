USE [web_bd]
GO

ALTER PROCEDURE sp_inscribe_mat_intercambio
 @CUENTA int,
 @MATERIA int,     
 @CLAVE varchar(50),
 @ASIGNATURA varchar(255)
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
DECLARE @VAR_num_aprobadas integer
DECLARE @CARRERA integer
DECLARE @PLAN integer
DECLARE @NIVEL varchar(1)
DECLARE @CVE_PERIODO_INTERCAMBIO integer
DECLARE @CVE_COORDINADOR integer
DECLARE @MAT_BLOQUEO integer

--Obtiene la información académica del alumno
SELECT @CARRERA = academicos.cve_carrera,   
	   @PLAN =  academicos.cve_plan,
	   @NIVEL= academicos.nivel
FROM	controlescolar_bd.dbo.academicos academicos, v_www_plan_estudios pe
WHERE	( academicos.cuenta = @CUENTA )
AND  academicos.cve_carrera = pe.cve_carrera
AND  academicos.cve_plan = pe.cve_plan

--Obtiene la información de la solicitud
SELECT @PERIODO=periodo, 
		@ANIO=anio, 
		@CVE_PERIODO_INTERCAMBIO = cve_periodo_intercambio
FROM dca_solicitud_intercambio WHERE cuenta = @CUENTA

--Valida que exista la materia
SELECT  @TMATERIA=count(*) FROM dbo.v_www_materias WHERE cve_mat=@MATERIA
if @TMATERIA>0
 begin
     SELECT @TPREINSCR=count(a.cuenta) 
     FROM dca_mat_sol_intercambio a
     WHERE a.anio=  @ANIO
	 AND a.periodo= @PERIODO
	 AND a.cuenta=  @CUENTA
	 AND a.cve_mat= @MATERIA 

 --Valida que dicha materia no se haya Inscrito con anterioridad
     if @TPREINSCR=0 OR @TPREINSCR<>0
      begin 
--Si el alumno es de licenciatura, valida que pertenezca a su plan de estudios
		/*IF @NIVEL='L'*/
       IF @NIVEL <> 'P' 
        begin
          SELECT @TPLAN=count(cve_mat) 
          FROM dbo.v_www_pert_plan_lic
          WHERE cve_mat=@MATERIA AND cve_carrera=@CARRERA AND cve_plan=@PLAN
        end 
--Si el alumno NO es de licenciatura, valida que pertenezca a su plan de estudios
		/*IF @NIVEL<>'L'*/
       IF @NIVEL = 'P'
        begin 
          SELECT @TPLAN=count(cve_mat) 
          FROM dbo.v_www_pert_plan_pos
          WHERE cve_mat=@MATERIA AND cve_carrera=@CARRERA AND cve_plan=@PLAN
        end
--Valida si la materia pertenece a su plan de estudios
       IF @TPLAN<>0
		  begin
--Si la materia es el servicio social
			IF @MATERIA = 8763
				begin
			       	SELECT -89,'No se permite Inscribir el Servicio Social en Internet, favor de acudir a la Subdirección de Intercambio Estudiantil'
					return -89
				end
-- Si la Materia está bloqueada para Intercambio no permitirá inscribirla al alumno
		  SELECT @MAT_BLOQUEO=count(cve_mat) 
          FROM dbo.dca_mat_bloqueo_intercambio
          WHERE cve_mat=@MATERIA AND cve_carrera=@CARRERA AND cve_plan=@PLAN

         if @MAT_BLOQUEO>0
          begin
           	SELECT -91,'La Materia está bloqueada para Intercambio en la carrera del alumno'
			return -91
          end

--Valida que el alumno no haya aprobado la materia en el historico
		SELECT @VAR_num_aprobadas = COUNT(h.cuenta)
		FROM v_www_historico h, v_www_academicos ac
		where h.cuenta = @CUENTA
		AND h.cve_mat = @MATERIA
		AND h.cuenta = ac.cuenta 
		AND h.cve_carrera = ac.cve_carrera
		AND h.cve_plan= ac.cve_plan
		AND h.calificacion IN ('6','7','8','9','10','AC','MB','B','S','RE','E')

         if @VAR_num_aprobadas>0
          begin
           	SELECT -85,'Materia previamente aprobada en Histórico'
				return -85
          end
         else
          begin
				begin transaction Actualiza   
				SELECT @CVE_COORDINADOR = cve_coordinador 
				FROM controlescolar_bd.dbo.materias mat, 
					controlescolar_bd.dbo.coordinaciones coord
				WHERE mat.cve_coordinacion = coord.cve_coordinacion
				AND mat.cve_mat = @MATERIA

           		INSERT INTO dca_mat_sol_intercambio 
			        (cuenta, cve_mat,  cve_periodo_intercambio,  periodo,  anio, 
					clave, asignatura,  cve_coordinador, status)         
				SELECT @CUENTA, @MATERIA, @CVE_PERIODO_INTERCAMBIO, @PERIODO, @ANIO,
					@CLAVE, @ASIGNATURA, @CVE_COORDINADOR, 0

			   SELECT @MERROR=(case when @@ERROR<>0 then @@ERROR else 0 end)

		       if @MERROR<>0
			    begin
						rollback transaction Actualiza 
             			select -1, 'Error al insertar la Materia de Intercambio'
						return -1
				end
				else
				begin
					if len(ltrim(rtrim(@ASIGNATURA)))=0
					begin
						rollback transaction Actualiza 
			           	SELECT -90,'Es necesario escribir el nombre de la Asignatura Externa'
						return -90
					end
					else
					begin 
						commit transaction Actualiza 
						select 0,'OK'             
					end
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
        	select -72, 'Materia ya inscrita'
			return -72
      end
    end 
if @TMATERIA<=0
 begin
  	select -70, 'Materia Inexistente'
	return -70
 end


GO

