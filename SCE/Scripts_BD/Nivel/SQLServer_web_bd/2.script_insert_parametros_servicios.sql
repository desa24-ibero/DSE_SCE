USE [controlescolar_bd]
GO

INSERT INTO controlescolar_bd.dbo.parametros_servicios
SELECT	2, -- cve_parametro
		preinscripcion_activa,
		periodo_preinscripcion, 
		anio_preinscripcion, 
		periodo_mat_inscritas, 
		anio_mat_inscritas, 
		mes_ajustes,anio_ajustes,
		mensaje_mat_inscritas, 
		fecha_res_preinscripcion, 
		situacion_academica_en_linea, 
		activa_posgrado_p_ingreso,
		seguro_orfandad_activo, 
		pase_ingreso_en_linea, 
		num_registros_pase_ingreso, 
		inscripcion_activa, 
		minutos_tolerancia,
		envia_mensaje_completo, 
		consulta_adeudos_en_linea, 
		extrao_titulo_activo, 
		creditos_titulo_suficiencia,
		baja_academica_activa, 
		baja_total_activa, 
		lpi_inscripcion_activa, 
		lpi_busqueda, 
		autorizacion_especial_activa,
		revisa_adeudo_baja_total, 
		reinsc_2v_activa, 
		'T' -- tipo_periodo
FROM controlescolar_bd.dbo.parametros_servicios
WHERE cve_parametro = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: INSERT INTO parametros_servicios'
END ELSE BEGIN
	PRINT 'ERROR: INSERT INTO parametros_servicios'
END          

INSERT INTO controlescolar_bd.dbo.parametros_servicios
SELECT	3, -- cve_parametro
		preinscripcion_activa,
		periodo_preinscripcion, 
		anio_preinscripcion, 
		periodo_mat_inscritas, 
		anio_mat_inscritas, 
		mes_ajustes,anio_ajustes,
		mensaje_mat_inscritas, 
		fecha_res_preinscripcion, 
		situacion_academica_en_linea, 
		activa_posgrado_p_ingreso,
		seguro_orfandad_activo, 
		pase_ingreso_en_linea, 
		num_registros_pase_ingreso, 
		inscripcion_activa, 
		minutos_tolerancia,
		envia_mensaje_completo, 
		consulta_adeudos_en_linea, 
		extrao_titulo_activo, 
		creditos_titulo_suficiencia,
		baja_academica_activa, 
		baja_total_activa, 
		lpi_inscripcion_activa, 
		lpi_busqueda, 
		autorizacion_especial_activa,
		revisa_adeudo_baja_total, 
		reinsc_2v_activa, 
		'C' -- tipo_periodo
FROM controlescolar_bd.dbo.parametros_servicios
WHERE cve_parametro = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: INSERT INTO parametros_servicios'
END ELSE BEGIN
	PRINT 'ERROR: INSERT INTO parametros_servicios'
END          
