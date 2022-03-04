
USE controlescolar_bd 
go

CREATE TABLE periodo_parametros(
				periodo tinyint not null, 
				horas_normales decimal(4,2) NOT NULL, 
				factor_ajuste_horas decimal(4,2) NOT NULL, 
				usuario_modificacion varchar(16) NOT NULL, 
				fecha_modificacion datetime NOT NULL, 
				PRIMARY KEY(periodo))
GO

INSERT INTO periodo_parametros(periodo, horas_normales, factor_ajuste_horas, usuario_modificacion, fecha_modificacion)
VALUES(0, 12, 1, 'sie', getdate())
GO

INSERT INTO periodo_parametros(periodo, horas_normales, factor_ajuste_horas, usuario_modificacion, fecha_modificacion)
VALUES(1, 12, 2.5, 'sie', getdate())
GO

INSERT INTO periodo_parametros(periodo, horas_normales, factor_ajuste_horas, usuario_modificacion, fecha_modificacion)
VALUES(2, 12, 1, 'sie', getdate())
GO




GRANT select, insert, update, delete on periodo_parametros to g_se_administrador 
go 

GRANT select, insert, update, delete on periodo_parametros to g_inf_admin 
go  
