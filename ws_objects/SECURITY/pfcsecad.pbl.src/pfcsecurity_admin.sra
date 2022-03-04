﻿$PBExportHeader$pfcsecurity_admin.sra
$PBExportComments$PFC Security Admin Application
forward
global type pfcsecurity_admin from application
end type
global n_tr sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global n_msg message
end forward

global variables
n_pfcsecurity_appmanager gnv_app
string gs_usuario, gs_password
n_tr gtr_sit
transaction gtr_sce


end variables

global type pfcsecurity_admin from application
 end type
global pfcsecurity_admin pfcsecurity_admin

on pfcsecurity_admin.create
appname = "pfcsecurity_admin"
message = create n_msg
sqlca = create n_tr
sqlda = create dynamicdescriptionarea
sqlsa = create dynamicstagingarea
error = create error
end on

on pfcsecurity_admin.destroy
destroy( sqlca )
destroy( sqlda )
destroy( sqlsa )
destroy( error )
destroy( message )
end on

event open;gnv_app = create n_pfcsecurity_appmanager

gnv_app.of_splash(1)


open(w_pfcsecurity_frame)

end event

event close;destroy gnv_app
end event

event systemerror;gnv_app.event pfc_systemerror ( )


end event

