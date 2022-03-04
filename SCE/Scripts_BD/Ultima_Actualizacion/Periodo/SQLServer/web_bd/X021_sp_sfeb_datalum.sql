USE [web_bd]
GO
/****** Object:  StoredProcedure [dbo].[sp_sfeb_datalum]    Script Date: 27/9/2017 15:00:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  ALTER procedure [dbo].[sp_sfeb_datalum]( @cuenta integer, @anio integer, @periodo integer, @tipo_apoyo char(1))  
as   
-- Obtiene datos del  alumno para  servicios en línea de Financiamiento Educativo y Becas.  
-- Juan Campos. Mayo-2006.  
declare @mensaje varchar(200), @periodo_ant char(5)
declare @regresa integer  
declare @cvecarrera integer  
declare @carrera varchar(100)
declare	@plan	smallint
declare	@suj	smallint
declare	@nombre_plan varchar(30)  
select @regresa = 0  
SET @periodo_ant = ''

--En primera instancia se busca anio y periodo de ingreso del alumno para aplicar el promedio de beca con base en esa
--información
if @tipo_apoyo = 'B' 
begin
	select @anio = isnull(anio_ing,0), @periodo = ISNULL(periodo_ing,0), @plan = cve_plan
	from controlescolar_bd.dbo.academicos
	where cuenta = @cuenta
end

-- Solicitud 15014
-- Para financiamiento se debe consultar con el año y período que se envía desde el portal
if @tipo_apoyo = 'F'
begin
	select @plan = cve_plan
	from controlescolar_bd.dbo.academicos
	where cuenta = @cuenta
end

--recupera nombre de plan para pegarlo en caso de que exista un error
select top 1 @nombre_plan = nombre_plan
from 	controlescolar_bd.dbo.nombre_plan
where	cve_plan = @plan
		

--si el plan de estudios es suj(7) graba @suj =1, el cual sirve para recuperar el promedio correcto segun el plan
if @plan = 7
begin	
	set @suj = 1
end	
else
begin
	set @suj = 0
end	

if exists(select *  from controlescolar_bd.dbo.alumnos where cuenta = @cuenta)  
 if exists(select *  from controlescolar_bd.dbo.academicos where cuenta = @cuenta)  
  if exists(select *  from controlescolar_bd.dbo.domicilio where cuenta = @cuenta)   
   if exists(select *  from controlescolar_bd.dbo.alumnos alum, controlescolar_bd.dbo.nacionalidad nac  
       where alum.cuenta = @cuenta and alum.cve_nacion = nac.cve_nacion)  
    if exists(select *  from controlescolar_bd.dbo.alumnos alum, controlescolar_bd.dbo.edo_civil edoc  
        where alum.cuenta = @cuenta and alum.cve_edocivil = edoc.cve_edocivil)  
	begin
		if exists(
				select	1  
				from	controlescolar_bd.dbo.academicos aca, 
						becas_fin_bd.dbo.promedios_carreras_becas pb  
				where	aca.cuenta = @cuenta 
				and		aca.cve_carrera = pb.cve_carrera
				and		pb.anio = @anio
				and		pb.periodo = @periodo 
				and		pb.suj = @suj
				and pb.tipo_apoyo = @tipo_apoyo) 
 
		if exists(select *  from controlescolar_bd.dbo.academicos aca, controlescolar_bd.dbo.carreras carr  
          where aca.cuenta = @cuenta and aca.cve_carrera = carr.cve_carrera )  
		if exists(
				select	1  
				from	controlescolar_bd.dbo.domicilio dom, 
						controlescolar_bd.dbo.estados edos  
				where	dom.cuenta = @cuenta 
				and		dom.cve_estado = edos.cve_estado ) 
 
        select @regresa = 1  
       else          
        select @mensaje = 'Error al consultar el nombre del estado, del domicilio del alumno,  en la base de datos de Servicios Escolares'   
      else  
       select @mensaje = 'Error al consultar el nombre de la carrera,  en la base de datos de Servicios Escolares'   
     else  
      begin  

		select @cvecarrera = aca.cve_carrera , @carrera = carr.carrera   
		from controlescolar_bd.dbo.academicos aca, controlescolar_bd.dbo.carreras carr  
		where aca.cuenta = @cuenta and  
		aca.cve_carrera = carr.cve_carrera              

		DECLARE  @descripcion VARCHAR(15)

		-- MALH 27/09/2017 SE AGREGA CONSULTA
		SELECT @descripcion = ISNULL(descripcion, '')
		from controlescolar_bd.dbo.periodo
		WHERE periodo = @periodo

		if exists(
					select	1  
					from	controlescolar_bd.dbo.academicos aca, 
							becas_fin_bd.dbo.promedios_carreras_becas pb  
					where	aca.cuenta = @cuenta 
					and		aca.cve_carrera = pb.cve_carrera
					and		pb.suj = @suj and pb.tipo_apoyo = @tipo_apoyo) 
		begin
		   select @mensaje = 'No se ha especificado un promedio y créditos mínimos en la carrera ' +  
					convert(varchar(15),@cvecarrera) + '-'+ @carrera + ' del plan de estudios ' + @nombre_plan +
					' para el periodo de solicitud ('+ @descripcion + '-'+cast(@anio as varchar)+')' 
		   
		   -- MALH 27/09/2017 SE COMENTA
		   /*
		   select @mensaje = 'No se ha especificado un promedio y créditos mínimos en la carrera ' +  
					convert(varchar(15),@cvecarrera) + '-'+ @carrera + ' del plan de estudios ' + @nombre_plan +
					' para el periodo de solicitud ('+ ( case @periodo when 0 then 'Primavera' when 1 then 'Verano' else 'Otoño' end ) + '-'+cast(@anio as varchar)+')' 
		   */
		end
		else
		begin
		   select @mensaje = 'No se ha especificado un promedio y créditos mínimos para la carrera ' +  
					convert(varchar(15),@cvecarrera) + '-'+ @carrera +' del plan de estudios ' + @nombre_plan +
					' para el periodo de ingreso del alumno ('+ @descripcion + '-'+cast(@anio as varchar)+')' 

		   -- MALH 27/09/2017 SE COMENTA
		   /*
		   select @mensaje = 'No se ha especificado un promedio y créditos mínimos para la carrera ' +  
					convert(varchar(15),@cvecarrera) + '-'+ @carrera +' del plan de estudios ' + @nombre_plan +
					' para el periodo de ingreso del alumno ('+ ( case @periodo when 0 then 'Primavera' when 1 then 'Verano' else 'Otoño' end ) + '-'+cast(@anio as varchar)+')' 
		   */
		end
      end  
	end
    else  
     select @mensaje = 'Error al obtener el estado civil del alumno,  en la base de datos de Servicios Escolares'  
   else  
    select @mensaje = 'Error al consultar la nacionalidad del alumno,  en la base de datos de Servicios Escolares'  
  else  
   select @mensaje = 'Error al consultar el domicilio del alumno con la cuenta: ' +   
           convert(varchar(15), @cuenta) + ', en la base de datos de Servicios Escolares '  
 else  
  select @mensaje = 'Error al consultar datos académicos del alumno con la cuenta: ' +   
          convert(varchar(15), @cuenta) + ', en la base de datos de Servicios Escolares '  
else  
 select @mensaje = 'Error al consultar datos del alumno con la cuenta: ' +   
         convert(varchar(15), @cuenta) + ', en la base de datos de Servicios Escolares '  
if @regresa = 1   
 select * from dbo.v_sfeb_datalum where dbo.v_sfeb_datalum.cuenta = @cuenta 
 and dbo.v_sfeb_datalum.anio = @anio and dbo.v_sfeb_datalum.periodo = @periodo
 and dbo.v_sfeb_datalum.suj = @suj and dbo.v_sfeb_datalum.tipo_apoyo = @tipo_apoyo  
else  
 select 'regresa' = @regresa, 'error' = @mensaje  
return  
GO

GRANT EXECUTE ON [dbo].[sp_sfeb_datalum] TO public
GO

  