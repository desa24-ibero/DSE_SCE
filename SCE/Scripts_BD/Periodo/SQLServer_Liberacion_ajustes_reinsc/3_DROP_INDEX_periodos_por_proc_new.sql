

use controlescolar_bd
go

DROP INDEX dbo.periodos_por_procesos.ind_periodos_por_procesos 
go

ALTER TABLE dbo.periodos_por_procesos ADD tipo_periodo VARCHAR(3) NULL
go 

 UPDATE periodos_por_procesos
 SET tipo_periodo = 'S' 
 go


CREATE UNIQUE NONCLUSTERED INDEX ind_periodos_por_procesos ON dbo.periodos_por_procesos (cve_proceso, tipo_periodo)
go


INSERT INTO dbo.periodos_por_procesos(cve_proceso, proceso, periodo, anio, fecha_inicial, fecha_final, tipo_periodo)
VALUES(0, 'Periodo Default', 0, 2017, NULL, NULL, 'S')
go 
