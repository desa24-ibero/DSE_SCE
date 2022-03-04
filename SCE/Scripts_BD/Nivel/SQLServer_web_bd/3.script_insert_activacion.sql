USE controlescolar_bd
GO

INSERT INTO controlescolar_bd.dbo.activacion
SELECT tipo_inscripcion,
	   nivel,
	   materias_encimadas,
	   bajas_periodo_distinto,
	   exceso_creditos,
	   revision_hora_entrada,
	   exceso_cupo,
	   imprime_comprobantes,
	   mensaje,
	   5, -- periodo
	   anio,
	   preinsc,
	   pregunta_nip,
	   revisa_teoria_lab,
	   revisa_grupos_bloqueados,
	   'T', -- tipo_periodo
	   revisa_proyecto_ss,
	   leyenda_mat_aceptadas,
	   leyenda_mat_rechazadas
FROM controlescolar_bd.dbo.activacion
WHERE tipo_periodo = 'S'
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: INSERT INTO activacion'
END ELSE BEGIN
	PRINT 'ERROR: INSERT INTO activacion'
END          

-- ***** ESTA INSERT SOLO APLICA PARA CHALCO ***** 
INSERT INTO controlescolar_bd.dbo.activacion
SELECT tipo_inscripcion,
	   nivel,
	   materias_encimadas,
	   bajas_periodo_distinto,
	   exceso_creditos,
	   revision_hora_entrada,
	   exceso_cupo,
	   imprime_comprobantes,
	   mensaje,
	   7, -- periodo
	   anio,
	   preinsc,
	   pregunta_nip,
	   revisa_teoria_lab,
	   revisa_grupos_bloqueados,
	   'C', -- tipo_periodo
	   revisa_proyecto_ss,
	   leyenda_mat_aceptadas,
	   leyenda_mat_rechazadas
FROM controlescolar_bd.dbo.activacion
WHERE tipo_periodo = 'S'
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: INSERT INTO activacion'
END ELSE BEGIN
	PRINT 'ERROR: INSERT INTO activacion'
END          