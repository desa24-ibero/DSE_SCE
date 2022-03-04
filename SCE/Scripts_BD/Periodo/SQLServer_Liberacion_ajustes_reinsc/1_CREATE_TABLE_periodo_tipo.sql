use controlescolar_bd
go

CREATE TABLE periodo_tipo(
id_tipo varchar(3) NOT NULL, 
descripcion varchar(20) NOT NULL, 
PRIMARY KEY (id_tipo ))
go

GRANT select, insert, update, delete on periodo_tipo to g_servesc 
go 

GRANT select, insert, update, delete on periodo_tipo to g_coord_dgmu 
go 

GRANT select, insert, update, delete on periodo_tipo to g_admin_menu 
go 

 

INSERT INTO periodo_tipo(id_tipo, descripcion)
VALUES('S', 'Semestral')
go


