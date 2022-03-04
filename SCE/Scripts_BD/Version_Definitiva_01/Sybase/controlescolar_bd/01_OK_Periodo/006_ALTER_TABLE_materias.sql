
use controlescolar_bd
go

ALTER TABLE materias ADD tipo_periodo VARCHAR(3) DEFAULT 'S' NULL
go



UPDATE materias SET tipo_periodo = 'S'
go


