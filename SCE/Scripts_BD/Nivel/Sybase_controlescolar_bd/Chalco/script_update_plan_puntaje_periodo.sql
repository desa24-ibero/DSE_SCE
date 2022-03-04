USE controlescolar_bd
GO

UPDATE plan_puntaje_periodo SET periodo_ing_min = 7 -- CUATRIMESTRE 1
WHERE periodo_ing_min = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE plan_puntaje_periodo'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE plan_puntaje_periodo'
END          
GO

UPDATE plan_puntaje_periodo SET periodo_ing_max = 7 -- CUATRIMESTRE 1
WHERE periodo_ing_max = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE plan_puntaje_periodo'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE plan_puntaje_periodo'
END          
GO

UPDATE plan_puntaje_periodo SET periodo_ing_min = 8 -- CUATRIMESTRE 2
WHERE periodo_ing_min = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE plan_puntaje_periodo'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE plan_puntaje_periodo'
END          
GO

UPDATE plan_puntaje_periodo SET periodo_ing_max = 8 -- CUATRIMESTRE 2
WHERE periodo_ing_max = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE plan_puntaje_periodo'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE plan_puntaje_periodo'
END          
GO

UPDATE plan_puntaje_periodo SET periodo_ing_min = 9 -- CUATRIMESTRE 3
WHERE periodo_ing_min = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE plan_puntaje_periodo'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE plan_puntaje_periodo'
END
GO

UPDATE plan_puntaje_periodo SET periodo_ing_max = 9 -- CUATRIMESTRE 3
WHERE periodo_ing_max = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE plan_puntaje_periodo'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE plan_puntaje_periodo'
END
GO