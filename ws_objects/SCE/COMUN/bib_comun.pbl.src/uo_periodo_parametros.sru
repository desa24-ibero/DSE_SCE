$PBExportHeader$uo_periodo_parametros.sru
forward
global type uo_periodo_parametros from nonvisualobject
end type
end forward

global type uo_periodo_parametros from nonvisualobject
end type
global uo_periodo_parametros uo_periodo_parametros

type variables

DECIMAL id_horas_normales
DECIMAL id_factor_ajuste_horas 
INTEGER ie_horas_adic_x_una_mat

INTEGER isql_errcode
STRING is_msg_err
end variables

forward prototypes
public function integer f_carga_parametros (integer ai_periodo, transaction trans)
end prototypes

public function integer f_carga_parametros (integer ai_periodo, transaction trans);// Se recuperan los parámetros del periodo solicitado.
SELECT horas_normales, factor_ajuste_horas, horas_adic_x_una_mat 
INTO :id_horas_normales, :id_factor_ajuste_horas, :ie_horas_adic_x_una_mat  
FROM periodo_parametros 
WHERE periodo = :ai_periodo
USING trans; 

// Se verifica un posible error.
IF trans.SQLCODE < 0 THEN 
	isql_errcode = trans.SQLCODE 
	is_msg_err = trans.SQLERRTEXT 
	RETURN -1
ELSEIF trans.SQLCODE = 100 THEN 	
	isql_errcode = trans.SQLCODE 
	is_msg_err = " No se encontraron parámetros para el periodo soliucitado." 
	RETURN 100
END IF

RETURN 0



end function

on uo_periodo_parametros.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_periodo_parametros.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

