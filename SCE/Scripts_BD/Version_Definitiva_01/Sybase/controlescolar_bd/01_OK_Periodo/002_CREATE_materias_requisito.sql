USE controlescolar_bd 
GO


CREATE TABLE materias_requisito(id_prerrequisito VARCHAR(4) NOT NULL, cve_mat INTEGER NOT NULL, PRIMARY KEY(id_prerrequisito, cve_mat)) 
go


GRANT select, insert, update, delete on materias_requisito to g_se_administrador 
go 

GRANT select, insert, update, delete on materias_requisito to g_inf_admin 
go 






