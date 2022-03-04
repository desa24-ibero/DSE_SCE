IF OBJECT_ID ('dbo.mat_insc_carrera_simul') IS NOT NULL
	DROP PROCEDURE dbo.mat_insc_carrera_simul
GO 

CREATE TABLE mat_insc_carrera_simul(
cuenta INTEGER NOT NULL, 
cve_mat INTEGER NOT NULL, 
gpo VARCHAR(2) NOT NULL,  
periodo tipo_periodo NOT NULL,  
anio tipo_anio NOT NULL,  
cve_carrera	INTEGER NOT NULL,  
cve_plan INTEGER NOT NULL, 
cve_condicion INTEGER NOT NULL, 
PRIMARY KEY (cuenta, cve_mat, gpo, periodo, anio, cve_carrera, cve_plan)) 
GO 

GRANT SELECT, INSERT, UPDATE, DELETE ON mat_insc_carrera_simul TO PUBLIC
go

