$PBExportHeader$ss.sra
$PBExportComments$Sistema de seguridad
forward
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
string gs_startupfile, gs_usuario, gs_password
transaction gtr_ss

end variables

global type ss from application
 end type
global ss ss

on ss.create
appname = "ss"
message = create message
sqlca = create transaction
sqlda = create dynamicdescriptionarea
sqlsa = create dynamicstagingarea
error = create error
end on

on ss.destroy
destroy( sqlca )
destroy( sqlda )
destroy( sqlsa )
destroy( error )
destroy( message )
end on

event open;gtr_ss = Create Transaction
gs_startupfile = "ss.ini"
//open(w_login_ss)
//if gs_password <> "" then open(w_principal)
//
end event

event close;DESTROY gtr_ss
end event

