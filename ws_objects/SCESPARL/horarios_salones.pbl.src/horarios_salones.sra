$PBExportHeader$horarios_salones.sra
$PBExportComments$Análisis, diseño e Implementación: César Ponce Hdz. Ibero - Tijuana, 2015,2016
forward
global type horarios_salones from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
//Transaction controlescolar_bd

Transaction gtr_sce

n_controlescolar_bd conexion_controlescolar_bd
end variables

global type horarios_salones from application
string appname = "horarios_salones"
end type
global horarios_salones horarios_salones

on horarios_salones.create
appname="horarios_salones"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on horarios_salones.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;conexion_controlescolar_bd = Create using "n_controlescolar_bd"

//If conexion_escolares2.of_ConnectDB()=0  Then

//end	 if

If  conexion_controlescolar_bd.of_ConnectDB()=0 Then
//If conexion_escolares.of_ConnectDB ( )=0 Then
//If lnv_connectserv.of_ConnectDB ( ) = 0 Then	
	/*  Open Main window  */
//	Open ( w_principal )
End If

String nombre

//select nombre into:nombre from alumnos where cuenta=70503 using gtr_sce;

//MessageBox("","hola"+nombre)

open(w_marco_general)
end event

