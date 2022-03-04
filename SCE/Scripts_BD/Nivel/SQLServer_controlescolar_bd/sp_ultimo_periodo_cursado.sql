USE controlescolar_bd 
go


ALTER procedure sp_ultimo_periodo_cursado
	@a_cuenta integer = null
as

declare @anio integer
declare @periodo integer
declare @nivel varchar(2)



select @nivel = nivel from academicos
where cuenta = @a_cuenta

select @anio = max(anio)
from historico inner join materias on historico.cve_mat = materias.cve_mat
inner join carreras on historico.cve_carrera = carreras.cve_carrera
where cuenta = @a_cuenta
and materias.creditos >0
and carreras.nivel <> 'P'

select  @periodo = max(periodo) from historico inner join materias on historico.cve_mat = materias.cve_mat
inner join carreras on historico.cve_carrera = carreras.cve_carrera
where cuenta = @a_cuenta
and materias.creditos >0
and anio = @anio
and carreras.nivel <> 'P'

if @nivel <> 'P'
BEGIN
	SELECT cuenta= @a_cuenta, anio = @anio, periodo= @periodo
END
else
BEGIN
	SELECT cuenta= NULL, anio = NULL, periodo= NULL from mat_inscritas where 1=2
END

GO

