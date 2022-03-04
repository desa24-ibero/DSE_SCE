
USE controlescolar_bd
go


INSERT INTO periodos_por_procesos(cve_proceso,proceso,periodo, anio,fecha_inicial,fecha_final,tipo_periodo)
VALUES(0, 'Periodo Activo', 0, 2017, NULL, NULL, 'S')


UPDATE periodos_por_procesos SET tipo_periodo = 'S'

go

