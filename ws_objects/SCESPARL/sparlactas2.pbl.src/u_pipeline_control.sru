$PBExportHeader$u_pipeline_control.sru
forward
global type u_pipeline_control from n_pl
end type
end forward

global type u_pipeline_control from n_pl
end type
global u_pipeline_control u_pipeline_control

forward prototypes
public function string of_resultado (integer ai_resultado)
end prototypes

public function string of_resultado (integer ai_resultado);//of_resultado
//Obtiene el texto resultante de la actualizacion
//Recibe ai_resultado

string ls_resultado

CHOOSE CASE ai_resultado
	CASE - 1
		ls_resultado = "Pipe open failed"
	CASE -2
		ls_resultado = "Too many columns"
	CASE -3
		ls_resultado = "Table already exists"
	CASE -4
		ls_resultado = "Table does not exist"
	CASE -5
		ls_resultado = "Missing connection"
	CASE -6
		ls_resultado = "Wrong arguments"
	CASE -7
		ls_resultado = "Column mismatch"
	CASE -8
		ls_resultado = "Fatal SQL error in source"
	CASE -9
		ls_resultado = "Fatal SQL error in destination"
   CASE -10
		ls_resultado = "Maximum number of errors exceeded"
	CASE -12
		ls_resultado = "Bad table syntax"
	CASE -13
		ls_resultado = "Key required but not supplied"
	CASE -15
		ls_resultado = "Pipe already in progress"
	CASE -16
		ls_resultado = "Error in source database"
	CASE -17
		ls_resultado = "Error in destination database"
	CASE -18
		ls_resultado = "Destination database is read-only"
	CASE ELSE
		ls_resultado = "WEIRD MISTAKE"
END CHOOSE

RETURN ls_resultado
end function

on u_pipeline_control.create
call super::create
end on

on u_pipeline_control.destroy
call super::destroy
end on

