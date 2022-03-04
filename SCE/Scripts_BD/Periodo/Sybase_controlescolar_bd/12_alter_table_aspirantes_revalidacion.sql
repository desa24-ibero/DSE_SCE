
use controlescolar_bd
go


ALTER TABLE aspirantes_revalidacion ADD tipo_periodo VARCHAR(3) DEFAULT '' NOT NULL
go


UPDATE aspirantes_revalidacion SET tipo_periodo = 'S' 
GO


 
