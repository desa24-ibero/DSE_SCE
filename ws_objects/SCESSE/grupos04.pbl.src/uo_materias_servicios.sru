$PBExportHeader$uo_materias_servicios.sru
forward
global type uo_materias_servicios from nonvisualobject
end type
end forward

global type uo_materias_servicios from nonvisualobject
end type
global uo_materias_servicios uo_materias_servicios

type variables

n_tr itr_sce 

INTEGER ie_horas_reales 


end variables

forward prototypes
public function integer of_recupera_materia (long al_cve_materia, ref string as_materia)
public function integer of_recupera_horas_reales (long al_cve_mat)
public function integer of_recupera_horas_totales (long al_cve_materia, integer ae_periodo, integer ae_forma_imparte)
end prototypes

public function integer of_recupera_materia (long al_cve_materia, ref string as_materia);
SELECT materia  
INTO :as_materia
FROM materias 
WHERE cve_mat = :al_cve_materia 
USING itr_sce; 
IF itr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar la descripción de la materia: " + itr_sce.SQLERRTEXT)
	RETURN -1 
ELSEIF itr_sce.SQLCODE = 100 THEN 	
	MESSAGEBOX("Error", "La materia solicitada no existe.") 
	RETURN -1 	
END IF

IF ISNULL(as_materia)  THEN as_materia = ""

RETURN 0  



end function

public function integer of_recupera_horas_reales (long al_cve_mat);INTEGER le_horas_reales


SELECT horas_reales  
INTO :le_horas_reales
FROM materias 
WHERE cve_mat = :al_cve_mat 
USING itr_sce; 
IF itr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar las horas reales de la materia: " + itr_sce.SQLERRTEXT)
	RETURN -1 
ELSEIF itr_sce.SQLCODE = 100 THEN 	
	MESSAGEBOX("Error", "La materia solicitada no existe.") 
	RETURN -1 	
END IF

IF ISNULL(le_horas_reales)  THEN le_horas_reales = 0

RETURN le_horas_reales


end function

public function integer of_recupera_horas_totales (long al_cve_materia, integer ae_periodo, integer ae_forma_imparte);// Función que recupera las horas totales requeridas para el grupo.

INTEGER le_horas_totales 
INTEGER le_horas_reales
INTEGER le_semanas_semestre 

// Las horas determinadas solo aplican para grupos modulares 
IF ae_forma_imparte = 2 THEN 
	
	// Se verifica si la materia tiene establecido algún valor de horas por periodo.
	SELECT horas_totales 
	INTO :le_horas_totales
	FROM grupos_valida_exepcion 
	WHERE cve_mat = :al_cve_materia 
	USING  itr_sce;
	IF itr_sce.SQLCODE < 0 THEN 
		MESSAGEBOX("Error", "Se produjo un error al recuparar las horas para validación de la materia: " + itr_sce.SQLERRTEXT)
		RETURN -1
	END IF 
	IF ISNULL(le_horas_totales) THEN le_horas_totales = 0 
	// Si tiene asignado un valor regresa este como el determinado 
	IF le_horas_totales > 0 THEN RETURN le_horas_totales 
	
END IF 	

// Se recupera el factor de ajuste por periodo. 
SELECT semanas_semestre
INTO :le_semanas_semestre
FROM periodo_parametros
WHERE periodo = :ae_periodo
USING  itr_sce;
IF itr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuparar las semanas de el periodo actual: " + itr_sce.SQLERRTEXT)
	RETURN -1
ELSEIF itr_sce.SQLCODE = 100 THEN  	
	MESSAGEBOX("Error", "No se encontró información de las semanas de el periodo actual: " + itr_sce.SQLERRTEXT)
	RETURN -1	
END IF 
IF ISNULL(le_semanas_semestre) THEN le_semanas_semestre = 0 

SELECT horas_reales  
INTO :le_horas_reales 
FROM materias 
WHERE cve_mat = :al_cve_materia 
USING  itr_sce;
IF itr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuparar las horas reales de la materia " + string(al_cve_materia) + ": " + itr_sce.SQLERRTEXT)
	RETURN -1
ELSEIF itr_sce.SQLCODE = 100 THEN  	
	MESSAGEBOX("Error", "No se encontró información de horas reales de la materia " + string(al_cve_materia) + ": " + itr_sce.SQLERRTEXT)
	RETURN -1	
END IF
IF ISNULL(le_horas_reales) THEN le_horas_reales = 0 

le_horas_totales = le_semanas_semestre * le_horas_reales 

RETURN le_horas_totales 











end function

on uo_materias_servicios.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_materias_servicios.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

