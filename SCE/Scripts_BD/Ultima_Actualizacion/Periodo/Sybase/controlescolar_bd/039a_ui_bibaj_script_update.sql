USE controlescolar_bd
GO

UPDATE ui_bibaj SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE ui_bibaj'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE ui_bibaj'
END          
GO

UPDATE ui_bibaj SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE ui_bibaj'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE ui_bibaj'
END          
GO

UPDATE ui_bibaj SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE ui_bibaj'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE ui_bibaj'
END
GO

DELETE FROM ui_bibaj
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE ui_bibaj'
END ELSE BEGIN
	PRINT 'ERROR: DELETE ui_bibaj'
END
GO