IF OBJECT_ID ('dbo.tu_academicos') IS NOT NULL
	DROP TRIGGER dbo.tu_academicos
GO

-----------------------------------------------------------------------------
-- DDL for Trigger 'controlescolar_bd.dbo.tu_academicos'
-----------------------------------------------------------------------------

create trigger tu_academicos on academicos for UPDATE as
begin
  declare  @c  int,
    @carr int,  
    @valor1 int,
    @valor2 int,
    @nivel1 char(1),
    @nivel2 char(1),
    @ingreso char(1),
    @cve_subsistema int,
    @folio int,
    @cuenta int,
    @ing_per int,
    @ing_anio int,
    @error varchar(255),
 	 @nivel varchar(1),
    @cve_plan int,
    @clv_ver int,
    @clv_per int




        if update(cve_carrera) OR update(nivel) OR update(cve_formaingreso) OR update(cve_plan)
   	 begin
--Si se movió información académica fundamental, se inserta un registro, para respaldar, como estaba antes del cambio
		insert into hist_academicos
			(
  			cuenta,
			cve_carrera,
			cve_plan,
			cve_subsistema,
			nivel,
			promedio,
			sem_cursados,
			creditos_cursados,
			egresado,
			periodo_ing,
			anio_ing,
			periodo_egre,
			anio_egre,
			cve_formaingreso,
			movimiento)
		SELECT 
  			d.cuenta,
			d.cve_carrera,
			d.cve_plan,
			d.cve_subsistema,
			d.nivel,
			d.promedio,
			d.sem_cursados,
			d.creditos_cursados,
			d.egresado,
			d.periodo_ing,
			d.anio_ing,
			d.periodo_egre,
			d.anio_egre,
			d.cve_formaingreso,
			'DE'
		FROM  deleted d,inserted i 
		WHERE d.cuenta = i.cuenta

		insert into hist_academicos
			(
  			cuenta,
			cve_carrera,
			cve_plan,
			cve_subsistema,
			nivel,
			promedio,
			sem_cursados,
			creditos_cursados,
			egresado,
			periodo_ing,
			anio_ing,
			periodo_egre,
			anio_egre,
			cve_formaingreso,
			movimiento)
		SELECT 
  			i.cuenta,
  			i.cve_carrera,
  			i.cve_plan,
  			i.cve_subsistema,
  			i.nivel,
  			i.promedio,
  			i.sem_cursados,
  			i.creditos_cursados,
  			i.egresado,
  			i.periodo_ing,
  			i.anio_ing,
  			i.periodo_egre,
  			i.anio_egre,
  			i.cve_formaingreso,
			'IN'
		FROM  deleted d,inserted i 
		WHERE d.cuenta = i.cuenta


        SELECT @c = cuenta,
               @ingreso = case cve_formaingreso
                            when 3 then 'V'
                            when 0 then 'I'
                            else 'R'
                            end,
				   @nivel = nivel, 
               @cve_plan = cve_plan 
        FROM inserted


        SELECT @carr = ce.cve_carrera_ant FROM inserted i, carrera_equiv ce
            WHERE i.cve_carrera = ce.cve_carrera_act


        select @nivel1 = nivel FROM inserted

        if @nivel1 = 'P'  
                select @nivel1 = 'G'
--  Anteriormente se mandaba a llamar a un stored procedure para actualizar informacion en cobranzas

	    end

        if update(cve_carrera) or update(cve_plan)
--Si se realizo un cambio en la carrera/plan
            if (SELECT COUNT(distinct s.cve_subsistema) FROM subsistema s, inserted i 
                 WHERE s.cve_carrera = i.cve_carrera AND s.cve_plan = i.cve_plan) = 1
                BEGIN
--y solo existe un subsistema, hay que ponerle ese valor al registro de academicos
                    SELECT @cve_subsistema = min(s.cve_subsistema) FROM subsistema s, inserted i
                    WHERE s.cve_carrera = i.cve_carrera AND s.cve_plan = i.cve_plan

                    UPDATE academicos 
                    SET a.cve_subsistema = @cve_subsistema
                    FROM academicos a, inserted i
                    WHERE a.cuenta = i.cuenta

                INSERT INTO ui_biacademicos(cuenta,academico, anterior, actual)
            SELECT d.cuenta, 4, d.cve_subsistema, @cve_subsistema FROM deleted d,inserted i WHERE d.cuenta = i.cuenta

                END

		
        if update(cve_carrera)

        if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.cve_carrera = d.cve_carrera AND d.cuenta = i.cuenta) = 0

                INSERT INTO ui_biacademicos(cuenta,academico, anterior,actual)
            SELECT d.cuenta, 2, d.cve_carrera, i.cve_carrera FROM deleted d,inserted i WHERE d.cuenta = i.cuenta



        if update(cve_plan)
        if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.cve_plan = d.cve_plan AND d.cuenta = i.cuenta) = 0

            INSERT INTO ui_biacademicos(cuenta,academico, anterior,actual)
            SELECT d.cuenta,3, d.cve_plan, i.cve_plan FROM deleted d,inserted i WHERE d.cuenta = i.cuenta

				/*IF (@nivel = 'L' AND @cve_plan = 6)*/
				IF (@nivel <> 'P' AND @cve_plan = 6)
				BEGIN
                    UPDATE banderas 
                    SET b.creditos_integ = 8
                    FROM banderas b, inserted i
                    WHERE b.cuenta = i.cuenta
				END

        if update(cve_subsistema)

        if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.cve_subsistema = d.cve_subsistema AND d.cuenta = i.cuenta) = 0

            INSERT INTO ui_biacademicos(cuenta,academico, anterior, actual)
            SELECT d.cuenta, 4, d.cve_subsistema, i.cve_subsistema FROM deleted d,inserted i WHERE d.cuenta = i.cuenta

        if update(nivel)
            if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.nivel = d.nivel AND d.cuenta = i.cuenta)= 0
        begin

            SELECT @nivel1 = d.nivel, @nivel2 = i.nivel FROM deleted d, inserted i WHERE d.cuenta = i.cuenta
            /*if @nivel1 = 'L'*/
            if @nivel1 <> 'P' 
                select @valor1 = 0
            else
                select @valor1= 1
            /*if @nivel2 = 'L'*/
            if @nivel2 <> 'P'
                select @valor2= 0
                else
                select @valor2= 1

            INSERT INTO ui_biacademicos(cuenta,academico, anterior,actual)
            SELECT d.cuenta, 5, @valor1, @valor2 FROM deleted d

            end

        if update(promedio)
            if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.promedio= d.promedio AND d.cuenta = i.cuenta) =0
            begin

            SELECT @valor1=convert (int,d.promedio*100),@valor2=convert (int,i.promedio*100)
            FROM deleted d, inserted i WHERE d.cuenta = i.cuenta

                INSERT INTO ui_biacademicos(cuenta,academico, anterior,actual)
                SELECT d.cuenta, 6, @valor1, @valor2 FROM deleted d

            end

        if update(sem_cursados)
            if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.sem_cursados = d.sem_cursados AND d.cuenta = i.cuenta) = 0

            INSERT INTO ui_biacademicos(cuenta,academico, anterior,actual)
                SELECT d.cuenta, 7, d.sem_cursados, i.sem_cursados FROM deleted d,inserted i WHERE d.cuenta = i.cuenta

        if update(creditos_cursados)
            if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.creditos_cursados = d.creditos_cursados AND d.cuenta = i.cuenta) = 0

                INSERT INTO ui_biacademicos(cuenta,academico, anterior,actual)
                SELECT d.cuenta, 8,d.creditos_cursados, i.creditos_cursados FROM deleted d,inserted i WHERE d.cuenta = i.cuenta

        if update(egresado)
            if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.egresado= d.egresado AND d.cuenta = i.cuenta) = 0

                INSERT INTO ui_biacademicos(cuenta,academico, anterior,actual)
                SELECT d.cuenta, 9, d.egresado,i.egresado FROM deleted d,inserted i WHERE d.cuenta = i.cuenta

        if update(periodo_ing)
            if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.periodo_ing = d.periodo_ing AND d.cuenta = i.cuenta) = 0

                INSERT INTO ui_biacademicos(cuenta,academico, anterior,actual)
                SELECT d.cuenta, 10, d.periodo_ing, i.periodo_ing FROM deleted d,inserted i WHERE d.cuenta = i.cuenta

        if update(anio_ing) 
            if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.anio_ing= d.anio_ing AND d.cuenta = i.cuenta) = 0

                INSERT INTO ui_biacademicos(cuenta,academico, anterior,actual)
                SELECT d.cuenta, 11, d.anio_ing, i.anio_ing FROM deleted d,inserted i WHERE d.cuenta = i.cuenta

		if update(periodo_ing) or update(anio_ing) 
		begin

			if (select count(*) from auxiliar_periodo_ingreso)=0
			begin
--Obtiene la cuenta a procesar

	  			SELECT @cuenta = i.cuenta, 
						@ing_per= i.periodo_ing,
						@ing_anio = i.anio_ing FROM inserted i			

--Revisa que exista un aspirante con ese numero de cuenta

				if (select count(*) from admision_bd.dbo.general
											WHERE admision_bd.dbo.general.cuenta = @cuenta) >= 1
				begin				  
--El alumno en cuestion no ha cambiado de carrera anteriormente
						if (select count(*) from hist_carreras 
												where cuenta = @cuenta)=0
						begin
						  select @folio= max(folio) from admision_bd.dbo.general where cuenta = @cuenta
						  select @clv_ver= max(clv_ver) from admision_bd.dbo.general where cuenta = @cuenta and folio = @folio
						  select @clv_per= max(clv_per) from admision_bd.dbo.general where cuenta = @cuenta and folio = @folio

							insert into auxiliar_periodo_ingreso (cuenta, folio)
							values(@cuenta,@folio)

							update admision_bd.dbo.aspiran 
							set ing_per = @ing_per,
								 ing_anio = @ing_anio
							where admision_bd.dbo.aspiran.folio = @folio	
							and admision_bd.dbo.aspiran.clv_ver = @clv_ver
							and admision_bd.dbo.aspiran.clv_per = @clv_per

							delete from auxiliar_periodo_ingreso

						end
				end
			end
		end

        if update(periodo_egre) 
            if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.periodo_egre= d.periodo_egre AND d.cuenta = i.cuenta) = 0

                INSERT INTO ui_biacademicos(cuenta,academico, anterior,actual)
                SELECT d.cuenta, 12, d.periodo_egre, i.periodo_egre FROM deleted d,inserted i WHERE d.cuenta = i.cuenta

        if update(anio_egre) 
            if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.anio_egre = d.anio_egre AND d.cuenta = i.cuenta) = 0

                INSERT INTO ui_biacademicos(cuenta,academico, anterior,actual)
                SELECT d.cuenta, 13, d.anio_egre, i.anio_egre FROM deleted d,inserted i WHERE d.cuenta = i.cuenta
        if update(cve_formaingreso) 
            if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.cve_formaingreso = d.cve_formaingreso AND d.cuenta = i.cuenta) = 0

                INSERT INTO ui_biacademicos(cuenta,academico, anterior,actual)
                SELECT d.cuenta, 14, d.cve_formaingreso, i.cve_formaingreso FROM deleted d,inserted i WHERE d.cuenta = i.cuenta
end
GO

