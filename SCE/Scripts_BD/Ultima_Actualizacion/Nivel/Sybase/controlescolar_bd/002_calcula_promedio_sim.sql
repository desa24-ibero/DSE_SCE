IF OBJECT_ID ('dbo.calcula_promedio_sim') IS NOT NULL
	DROP PROCEDURE dbo.calcula_promedio_sim
GO

create proc calcula_promedio_sim @cuenta int, @cve_carr int, @plan int1,
                             @promedio real out, @creditos int out

                             

as



declare @calif tipo_calificacion
declare @calif_int int
declare @suma_calif real
declare @no_materias int
declare @anio_mayor tipo_anio
declare @per_mayor tipo_periodo
declare @cve_mat int
declare @cred int
declare @opcion_terminal int



select @calif_int = 0
select @suma_calif = 0
select @no_materias = 0
select @creditos = 0
select @promedio = 0
select @opcion_terminal = 0



SELECT @opcion_terminal = am.cve_mat 
	FROM area_mat am, plan_estudios pe, carreras c
	WHERE pe.cve_carrera = @cve_carr AND pe.cve_plan = @plan
	AND c.cve_carrera = pe.cve_carrera
   AND c.nivel NOT LIKE "P"  
	AND pe.cve_plan IN (3,4)
	AND pe.cve_area_opcion_terminal = am.cve_area


/*AND c.nivel LIKE "L" */

declare historico_cursor cursor for

  select distinct cve_mat
    from historico_re
    where cuenta=@cuenta and 
          cve_carrera=@cve_carr and cve_plan=@plan 
			AND calificacion NOT IN ("BA","BJ")
	 order by cve_mat



open historico_cursor

fetch historico_cursor into @cve_mat

if (@@sqlstatus = 2)

begin
  select @promedio=0
  select @creditos=0
  close historico_cursor
  return
end

while (@@sqlstatus = 0)

begin
  select @anio_mayor=max(anio) from historico_re
     where cuenta=@cuenta and cve_carrera=@cve_carr and
           cve_plan=@plan and cve_mat=@cve_mat and
				calificacion NOT IN ("BA","BJ")

  select @per_mayor=max(periodo) from historico_re
     where cuenta=@cuenta and cve_carrera=@cve_carr and
           cve_plan=@plan and cve_mat=@cve_mat and
           anio=@anio_mayor and
				calificacion NOT IN ("BA","BJ")

  select @calif=calificacion from historico_re
     where cuenta=@cuenta and cve_carrera=@cve_carr and
           cve_plan=@plan and cve_mat=@cve_mat and
           anio=@anio_mayor and periodo=@per_mayor

  if (@calif != 'AC') and (@calif != 'IN') and (@calif != 'NA') and
     (@calif != 'MB') and (@calif != 'B ') and (@calif != 'S ') and
     (@calif != 'BJ') and (@calif != 'BA') and (@calif != 'RE') and (@calif != 'E ')

    begin
      select @calif_int=convert(int, @calif)
      select @suma_calif = @suma_calif + @calif_int
      select @no_materias = @no_materias + 1
    end

  if (@calif = 'MB')

    begin
	  select @calif_int = 10
      select @suma_calif = @suma_calif + @calif_int
      select @no_materias = @no_materias + 1
    end

  if (@calif = 'B ')

    begin
      select @calif_int = 8
      select @suma_calif = @suma_calif + @calif_int
      select @no_materias = @no_materias + 1
    end

  if (@calif = 'S ')

    begin
      select @calif_int = 6
      select @suma_calif = @suma_calif + @calif_int
      select @no_materias = @no_materias + 1
    end
         

   fetch historico_cursor into @cve_mat

end



                                            



close historico_cursor



deallocate cursor historico_cursor



if (@no_materias != 0)

    begin

      select @promedio=@suma_calif / @no_materias

    end

select @creditos = SUM(m.creditos) FROM materias m, historico_re h

WHERE m.cve_mat = h.cve_mat AND

h.cuenta = @cuenta and h.cve_carrera=@cve_carr and

h.cve_plan=@plan AND

h.calificacion IN ('6 ','7 ','8 ','9 ','10','AC','MB','B ','S ','RE','E ' )

AND h.cve_mat <> @opcion_terminal

                                  
return
GO



GRANT EXECUTE ON dbo.calcula_promedio_sim TO g_se_administrador
GO
GRANT EXECUTE ON dbo.calcula_promedio_sim TO g_inf_admin
GO




