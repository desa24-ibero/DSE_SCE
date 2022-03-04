
use controlescolar_bd
go


ALTER TABLE activacion ADD tipo_periodo VARCHAR(3) DEFAULT 'S' NOT NULL 
go

ALTER TABLE activacion ADD revisa_proyecto_ss tinyint DEFAULT 1 NOT NULL 
go


ALTER TABLE activacion_su ADD tipo_periodo VARCHAR(3) DEFAULT 'S' NOT NULL 
go

ALTER TABLE activacion_su ADD revisa_proyecto_ss tinyint DEFAULT 1 NOT NULL 
go





  












