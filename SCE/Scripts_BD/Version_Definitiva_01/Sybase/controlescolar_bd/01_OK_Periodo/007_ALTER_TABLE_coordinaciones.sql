use controlescolar_bd
go

ALTER TABLE coordinaciones ADD tipo_periodo VARCHAR(3) DEFAULT 'S' NULL
go
 
UPDATE coordinaciones SET tipo_periodo = 'S' 
go


