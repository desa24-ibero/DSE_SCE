

use controlescolar_bd
go

ALTER TABLE plan_estudios ADD cred_max_verano INTEGER DEFAULT 0 NOT NULL
go

ALTER TABLE plan_estudios ADD tipo_periodo VARCHAR(3) DEFAULT '' NOT NULL
go

ALTER TABLE plan_estudios ADD cve_sede INTEGER DEFAULT 0 NOT NULL
go


UPDATE plan_estudios SET cve_sede = 17, tipo_periodo = 'S'
GO







