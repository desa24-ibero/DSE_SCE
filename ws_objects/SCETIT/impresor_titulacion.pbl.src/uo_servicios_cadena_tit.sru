$PBExportHeader$uo_servicios_cadena_tit.sru
forward
global type uo_servicios_cadena_tit from nonvisualobject
end type
end forward

global type uo_servicios_cadena_tit from nonvisualobject
end type
global uo_servicios_cadena_tit uo_servicios_cadena_tit

forward prototypes
public function string of_modifica_nombre (string as_cadena)
public function string of_fecha_a_texto (datetime adt_fecha)
public function string of_modifica_carrera (string as_cadena)
end prototypes

public function string of_modifica_nombre (string as_cadena);
STRING ls_val[]  
INTEGER li_posi , li = 1  
INTEGER le_pos 
STRING ls_retorno 

as_cadena = TRIM(as_cadena) 

// Se divide la cadena por espacios. 
DO WHILE POS(as_cadena , ' ') > 0
   li_posi = POS(as_cadena , ' ')
   ls_val[li] = LEFT(as_cadena , li_posi - 1)
   li ++
   as_cadena = TRIM(MID(as_cadena , li_posi + 1, LEN(as_cadena)))  
loop
ls_val[li] = as_cadena

// Se substituye la primer letra de cada palabra con mayúscula y el resto en minúscula. 
FOR le_pos = 1 TO UPPERBOUND(ls_val)

	IF LEN(ls_retorno) > 0 THEN ls_retorno = ls_retorno + " " 
	ls_retorno = ls_retorno + UPPER(LEFT(ls_val[le_pos], 1)) + LOWER(RIGHT(ls_val[le_pos], LEN(ls_val[le_pos]) - 1)) 

NEXT 

RETURN ls_retorno 




end function

public function string of_fecha_a_texto (datetime adt_fecha);
DATE ldt_fecha 
STRING ls_mes[] = {"enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"} 
STRING ls_fecha 

ldt_fecha = DATE(adt_fecha) 

ls_fecha = STRING(DAY(ldt_fecha))

IF DAY(ldt_fecha) = 1 THEN ls_fecha = ls_fecha + "°" 
	
ls_fecha = ls_fecha + " de " + ls_mes[MONTH(ldt_fecha)] + " de " + STRING(YEAR(ldt_fecha)) 

RETURN ls_fecha 












  
end function

public function string of_modifica_carrera (string as_cadena);
STRING ls_val[]  
INTEGER li_posi , li = 1  
INTEGER le_pos 
STRING ls_retorno 

as_cadena = TRIM(as_cadena) 

// Se divide la cadena por espacios. 
DO WHILE POS(as_cadena , ' ') > 0
   li_posi = POS(as_cadena , ' ')
   ls_val[li] = LEFT(as_cadena , li_posi - 1)
   li ++
   as_cadena = TRIM(MID(as_cadena , li_posi + 1, LEN(as_cadena)))  
loop
ls_val[li] = as_cadena

// Se substituye la primer letra de cada palabra con mayúscula y el resto en minúscula. 
FOR le_pos = 1 TO UPPERBOUND(ls_val)

	IF LEN(ls_retorno) > 0 THEN ls_retorno = ls_retorno + " " 
	
	IF LEN(ls_val[le_pos]) > 3 THEN 
		ls_retorno = ls_retorno + UPPER(LEFT(ls_val[le_pos], 1)) + LOWER(RIGHT(ls_val[le_pos], LEN(ls_val[le_pos]) - 1)) 
	ELSE 	
		ls_retorno = ls_retorno + LOWER(ls_val[le_pos]) 
	END IF 	
	
NEXT 

RETURN ls_retorno 




end function

on uo_servicios_cadena_tit.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_servicios_cadena_tit.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

