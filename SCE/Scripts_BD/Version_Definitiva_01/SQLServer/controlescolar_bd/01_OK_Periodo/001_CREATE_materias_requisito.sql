
USE controlescolar_bd
go

CREATE TABLE materias_requisito(id_prerrequisito VARCHAR(4) NOT NULL, cve_mat INTEGER NOT NULL, PRIMARY KEY(id_prerrequisito, cve_mat)) 
go



GRANT select, insert, update, delete on materias_requisito to g_servesc 
go 

GRANT select, insert, update, delete on materias_requisito to g_coord_dgmu 
go 

GRANT select, insert, update, delete on materias_requisito to g_admin_menu 
go 







