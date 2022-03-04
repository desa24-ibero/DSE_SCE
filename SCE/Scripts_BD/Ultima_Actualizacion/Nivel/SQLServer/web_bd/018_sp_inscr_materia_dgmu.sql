ALTER PROCEDURE sp_inscr_materia_dgmu
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
DECLARE @INSCRITOS integer
DECLARE @CVE_COORDINACION integer
DECLARE @COORD_NUM_MATERIAS integer
DECLARE @NUM_MATERIAS integer

--Valida que exista la materia
SELECT  @TMATERIA=count(*) FROM dbo.dgmu_materias WHERE cve_mat=@MATERIA
if @TMATERIA>0
 begin
--Obtiene el cupo del grupo
  SELECT @CUPO=cupo
  FROM dbo.dgmu_grupos, dbo.v_www_parametros_servicios ps
  WHERE dbo.dgmu_grupos.cve_mat = @MATERIA AND dbo.dgmu_grupos.gpo=@GRUPO
  AND dbo.dgmu_grupos.periodo = ps.periodo_preinscripcion
  AND dbo.dgmu_grupos.anio = ps.anio_preinscripcion


--Obtiene los inscritos del grupo
  SELECT @INSCRITOS=count(dbo.dgmu_mat_inscritas.cve_mat)
  FROM dbo.dgmu_mat_inscritas, dbo.v_www_parametros_servicios ps
  WHERE dbo.dgmu_mat_inscritas.cve_mat = @MATERIA AND dbo.dgmu_mat_inscritas.gpo=@GRUPO
  AND dbo.dgmu_mat_inscritas.periodo = ps.periodo_preinscripcion
  AND dbo.dgmu_mat_inscritas.anio = ps.anio_preinscripcion

--Obtiene el numero de materias limite de la coordinacion
  SELECT @CVE_COORDINACION =dbo.dgmu_materias.cve_coordinacion,
	@COORD_NUM_MATERIAS = isnull(dbo.dgmu_coordinaciones.num_materias,0)
  FROM dbo.dgmu_materias, dbo.dgmu_coordinaciones
  WHERE dbo.dgmu_materias.cve_mat = @MATERIA
  AND dbo.dgmu_materias.cve_coordinacion = dbo.dgmu_coordinaciones.cve_coordinacion	

--Obtiene el numero de materias de la coordinacion previamente inscritas
  SELECT @NUM_MATERIAS = isnull(count(dbo.dgmu_materias.cve_mat),0)
  FROM dbo.dgmu_materias, dbo.dgmu_coordinaciones, dbo.dgmu_mat_inscritas, dbo.v_www_parametros_servicios
  WHERE dbo.dgmu_mat_inscritas.cuenta = @CUENTA
  AND dbo.dgmu_mat_inscritas.cve_mat = dbo.dgmu_materias.cve_mat
  AND dbo.dgmu_materias.cve_coordinacion = dbo.dgmu_coordinaciones.cve_coordinacion
  AND dbo.dgmu_materias.cve_coordinacion =@CVE_COORDINACION
  AND dbo.dgmu_mat_inscritas.periodo = dbo.v_www_parametros_servicios.periodo_preinscripcion
  AND dbo.dgmu_mat_inscritas.anio = dbo.v_www_parametros_servicios.anio_preinscripcion

if  (@COORD_NUM_MATERIAS=  0  OR @NUM_MATERIAS < @COORD_NUM_MATERIAS)
begin

--Valida que el grupo tenga un cupo definido
  if @CUPO is not NULL
   begin   
--Valida que el grupo tenga cupo mayor a cero, si tiene cero no podra preinscribirse
    if @CUPO > 0
    begin
     SELECT @TPREINSCR=count(a.cuenta) 
     FROM dbo.dgmu_mat_inscritas a, dbo.v_www_periodo_preinscripcion b
     WHERE a.anio=b.anio AND a.periodo=b.periodo AND a.cuenta=@CUENTA
	  AND a.cve_mat=@MATERIA AND a.gpo=@GRUPO

--Valida que dicha materia no se haya preinscrito con anterioridad
     if @TPREINSCR=0
      begin 
--Si es un grupo de intercambio
       IF @CUPO <= @INSCRITOS
	begin
--Revisa que esté inscrito en intercambio
	       	SELECT -84,'El grupo ya se encuentra lleno'
		return -84
	end

--Si el alumno es de licenciatura, valida que pertenezca a su plan de estudios
		/*IF @NIVEL='L'*/
       IF @NIVEL <> 'P'
        begin
          SELECT @TPLAN=count(cve_mat) 
          FROM dbo.v_www_pert_plan_lic
          WHERE cve_mat=@MATERIA AND cve_carrera=@CARRERA AND cve_plan=@PLAN
--Simula que pertenece al plan de estudios
          SELECT @TPLAN=1
        end 
--Si el alumno NO es de licenciatura, valida que pertenezca a su plan de estudios
		/*IF @NIVEL<>'L'*/
       IF @NIVEL = 'P' 
        begin 
          SELECT @TPLAN=count(cve_mat) 
          FROM dbo.v_www_pert_plan_pos
          WHERE cve_mat=@MATERIA AND cve_carrera=@CARRERA AND cve_plan=@PLAN
--Simula que pertenece al plan de estudios
          SELECT @TPLAN=1 
        end

--Valida si la materia pertenece a su plan de estudios
       IF @TPLAN<>0
		  begin
--Este cursor sirve para validar que el grupo no este bloqueado para alguna carrera
--distinta a la del alumno
         select @revisa_gpo_bloqueado=0
         select @termino=0

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
		       	INSERT INTO dbo.dgmu_mat_inscritas(cuenta,  cve_mat,  gpo,    periodo,  anio,  cve_origen)
			select                             @CUENTA, @MATERIA, @GRUPO, @PERIODO, @ANIO, 1 
			SELECT @MERROR=(case when @@ERROR<>0 then @@ERROR else 0 end)

				INSERT INTO dbo.dgmu_movmat_inscritas(cuenta,  cve_mat,  gpo,    status, periodo,  anio,  movimiento, cve_origen)
				select                                @CUENTA, @MATERIA, @GRUPO, 0,      @PERIODO, @ANIO, 'IN',1	
			SELECT @MERROR=(case when @@ERROR<>0 then @@ERROR else 0 end)

			UPDATE dbo.dgmu_grupos
				SET inscritos = inscritos + 1
				FROM dbo.dgmu_grupos 
			 	WHERE dbo.dgmu_grupos.cve_mat = @MATERIA AND dbo.dgmu_grupos.gpo=@GRUPO
				AND dbo.dgmu_grupos.periodo = @PERIODO
				AND dbo.dgmu_grupos.anio = @ANIO
			SELECT @MERROR=(case when @@ERROR<>0 then @@ERROR else 0 end)

           if @MERROR<>0
            begin
					rollback transaction Actualiza 
             	select -1, 'Error al insertar la materia en la inscripcion'
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
        	select -72, 'Materia ya Inscrita'
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
 if not(@NUM_MATERIAS < @COORD_NUM_MATERIAS  OR @NUM_MATERIAS = 0 )
  begin
  	select -91, 'Se ha excedido el numero de materias inscritas por coordinacion'
		return -91
  end 
 end
if @TMATERIA<=0
 begin
  	select -70, 'Materia Inexistente'
	return -70
 end

	
GO

