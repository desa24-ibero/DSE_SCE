use controlescolar_bd
go

DROP INDEX periodos_por_procesos.ind_periodos_por_procesos 
go

/*ALTER TABLE periodos_por_procesos ADD tipo_periodo VARCHAR(3) DEFAULT 'S' NULL
go*/ 

 UPDATE periodos_por_procesos
 SET tipo_periodo = 'S' 
 go


CREATE UNIQUE NONCLUSTERED INDEX ind_periodos_por_procesos ON periodos_por_procesos (cve_proceso, tipo_periodo)
go


