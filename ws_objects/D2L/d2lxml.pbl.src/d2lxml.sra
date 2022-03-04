$PBExportHeader$d2lxml.sra
$PBExportComments$Generated Application Object
forward
global type d2lxml from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables

STRING gs_usuario 
STRING gs_password 

uo_conexion guo_conexion 

DATE gf_fecha_ejecucion 
INTEGER ge_periodo 
INTEGER ge_anio
STRING gs_tipo_periodo


STRING gs_plantel
STRING gs_plantel2


STRING multiples_periodos
STRING gs_periodo_default  






end variables

global type d2lxml from application
string appname = "d2lxml"
string appruntimeversion = "21.0.0.1311"
end type
global d2lxml d2lxml

on d2lxml.create
appname="d2lxml"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on d2lxml.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;
INTEGER le_retorno

guo_conexion = CREATE uo_conexion 
OPEN(w_login) 
le_retorno = message.DoubleParm

IF le_retorno = -1 OR le_retorno = 100 THEN  
	HALT 
END IF

OPEN(w_procesar) 





end event

