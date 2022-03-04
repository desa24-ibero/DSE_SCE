USE [web_bd]
GO

ALTER PROCEDURE sp_cea_materia_compartida
	(
		@licve_mat int,@licve_carrera int
	)
AS
BEGIN
/*
    *Autor: Salvador Gaytan Herrera
    *Fecha: 14/NOV/2005
    *Descripción: Regresa las materias compartidas
    *
    *Parametros:   
    *           @licve_mat = Clave de la materia
*/
DECLARE @lsnivel nvarchar(1)
SELECT @lsnivel = nivel FROM v_www_carreras WHERE cve_carrera = @licve_carrera

/*IF (@lsnivel = 'L')*/
IF (@lsnivel <> 'P') 
BEGIN
    SELECT  DISTINCT   v_www_carreras.cve_carrera, v_www_carreras.carrera, v_www_mat_prerrequisito.cve_plan
    FROM         v_www_carreras INNER JOIN
                      v_www_mat_prerrequisito ON v_www_carreras.cve_carrera = v_www_mat_prerrequisito.cve_carrera
    WHERE     (v_www_mat_prerrequisito.cve_mat = @licve_mat)
END
ELSE
BEGIN
    SELECT  DISTINCT   v_www_carreras.cve_carrera, v_www_carreras.carrera, v_www_mat_prerreq_pos.cve_plan
    FROM         v_www_carreras INNER JOIN
                      v_www_mat_prerreq_pos ON v_www_carreras.cve_carrera = v_www_mat_prerreq_pos.cve_carrera
    WHERE     (v_www_mat_prerreq_pos.cve_mat = @licve_mat)
END
END

GO

