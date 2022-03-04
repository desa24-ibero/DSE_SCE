use controlescolar_bd
go


ALTER TABLE periodo MODIFY descripcion varchar(15) not null 
go 

ALTER TABLE periodo ADD tipo CHAR(1) NULL
go

ALTER TABLE periodo ADD descripcion_corta VARCHAR(10) NULL
go 

ALTER TABLE periodo ADD posgrado BIT DEFAULT 0 NOT NULL 
go 


UPDATE periodo 
SET descripcion = 'PRIMAVERA', 
	tipo = 'S',  
	descripcion_corta = 'P',  
	posgrado = 0
WHERE periodo = 0
GO

UPDATE periodo 
SET descripcion = 'VERANO', 
	tipo = 'S',  
	descripcion_corta = 'V',  
	posgrado = 0
WHERE periodo = 1
GO

UPDATE periodo 
SET descripcion = 'OTOÑO', 
	tipo = 'S',  
	descripcion_corta = 'O',  
	posgrado = 0
WHERE periodo = 2
GO



alter table periodo
add constraint id_periodo_primary_key
primary key (periodo) 
go 




