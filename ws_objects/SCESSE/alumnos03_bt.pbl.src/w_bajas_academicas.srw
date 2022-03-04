$PBExportHeader$w_bajas_academicas.srw
$PBExportComments$En esta  ventana se realiza el proceso de baja académica de  materias de un alumno. Se modifica mat_inscritas.cve_condicion como baja_academica  y se modifica   grupos_insc_desp_bajas. Se imprime un comprobante  .     Juan Campos Nov-1996.
forward
global type w_bajas_academicas from window
end type
type uo_nombre from uo_nombre_alu_foto within w_bajas_academicas
end type
type dw_imprime_bajas_academicas from datawindow within w_bajas_academicas
end type
type dw_teoria_lab from datawindow within w_bajas_academicas
end type
type dw_materias_inscritas from datawindow within w_bajas_academicas
end type
end forward

global type w_bajas_academicas from window
integer x = 5
integer y = 4
integer width = 3611
integer height = 1928
boolean titlebar = true
string title = "BAJAS ACADÉMICAS"
string menuname = "m_bajas_academicas"
boolean controlmenu = true
long backcolor = 27291696
uo_nombre uo_nombre
dw_imprime_bajas_academicas dw_imprime_bajas_academicas
dw_teoria_lab dw_teoria_lab
dw_materias_inscritas dw_materias_inscritas
end type
global w_bajas_academicas w_bajas_academicas

type variables
Transaction itr_parametros_iniciales
n_tr itr_seguridad, itr_original

//nombre de la conexion en parametros_conexion
CONSTANT	string	is_controlescolar_cnx	=	"controlescolar_baja_academica"
CONSTANT	string	is_tesoreria_cnx			=	"controlescolar_inscripcion_tesoreria"
CONSTANT	string	is_becas_cnx				=	"controlescolar_inscripcion_becas"

end variables
forward prototypes
public function integer wf_renglon_cursor ()
end prototypes

public function integer wf_renglon_cursor ();// Juan Campos. Dic-1996.


long  NumRen 

NumRen  = dw_materias_inscritas.GetRow()  

IF NumRen > 0 THEN 
  dw_materias_inscritas.SetRow(NumRen)
  dw_materias_inscritas.ScrollToRow(NumRen)  
  dw_materias_inscritas.SetRowFocusIndicator(Hand!)    
  Return NumRen
ELSE
  Return 0
END IF 

end function

on w_bajas_academicas.create
if this.MenuName = "m_bajas_academicas" then this.MenuID = create m_bajas_academicas
this.uo_nombre=create uo_nombre
this.dw_imprime_bajas_academicas=create dw_imprime_bajas_academicas
this.dw_teoria_lab=create dw_teoria_lab
this.dw_materias_inscritas=create dw_materias_inscritas
this.Control[]={this.uo_nombre,&
this.dw_imprime_bajas_academicas,&
this.dw_teoria_lab,&
this.dw_materias_inscritas}
end on

on w_bajas_academicas.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nombre)
destroy(this.dw_imprime_bajas_academicas)
destroy(this.dw_teoria_lab)
destroy(this.dw_materias_inscritas)
end on

event open;// Juan Campos.  Enero-1997.

this.x = 1
this.y = 1
w_bajas_academicas.dw_teoria_lab.enabled = False
w_bajas_academicas.dw_teoria_lab.visible = false
w_bajas_academicas.dw_imprime_bajas_academicas.enabled = False
w_bajas_academicas.dw_imprime_bajas_academicas.visible = False
w_bajas_academicas.dw_materias_inscritas.SetTransObject(gtr_sce)

int li_chk

//1)->
//Se conecta a la seguridad para mantener separada una transacción para la seguridad
if not (conecta_bd_n_tr(itr_seguridad,"SCE",gs_usuario,gs_password) = 1) then
	messageBox('Error en seguridad', 'No es posible validar la seguridad del usuario',Stopsign!)
end if

itr_parametros_iniciales = gtr_sce

li_chk	=	f_conecta_pas_parametros_act_bd(itr_parametros_iniciales,gtr_sce,is_controlescolar_cnx,gs_usuario,gs_password,1)
if li_chk <> 1 then return



//Es necesario reasignar el transaction object para la seguridad
gnv_app.of_SetSecurity(TRUE)
gnv_app.itr_security = itr_seguridad
gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), "SCE")
gnv_app.itr_security.of_Connect()
if (gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, gs_usuario,"Default") <> 1) then
		MessageBox("Atención","No se pudo inicializar correctamente la seguridad")
		Close(this)
end if

//1)<-



//2)->
//Se vuelve a poner porque en el constructor de los datawindows ya previamente se había ejecutado apuntando a sybase

dw_imprime_bajas_academicas.SetTransObject(gtr_sce)
dw_teoria_lab.SetTransObject(gtr_sce)
dw_materias_inscritas.SetTransObject(gtr_sce)

uo_nombre.dw_nombre_alumno.settransobject(gtr_sce)
uo_nombre.dw_nombre_alumno.insertrow(0)
f_obten_titulo(w_principal)

w_principal.ChangeMenu(m_grupos_impartidos_salir)

//2)<-





end event

event doubleclicked;// Juan Campos.  Enero-1997.

w_bajas_academicas.dw_materias_inscritas.SetSort("mat_inscritas_cve_mat")	 

if w_bajas_academicas.dw_materias_inscritas. &
   Retrieve(long(w_bajas_academicas.uo_nombre.em_cuenta.text)) = 0 then
  MessageBox("Aviso","No tiene materias inscritas este semestre")
Else	
 m_bajas_academicas.m_reactivabaja.enabled = true
 m_bajas_academicas.m_baja.enabled = true
 m_bajas_academicas.m_imprime.enabled = true
 dw_materias_inscritas.setfocus()
end if  

end event

event close;//3)->
//Se conecta a la base de datos original para reasignar a la transacción principal
if not (conecta_bd_n_tr(itr_original,"SCE",gs_usuario,gs_password) = 1) then
	messageBox('Error en conectividad', 'No es posible reconectarse al origen. Favor de reiniciar la aplicación',Stopsign!)
	HALT CLOSE		
end if

//Se asigna la transacción original
gtr_sce = itr_original 

//Es necesario reasignar el transaction object para la seguridad
gnv_app.of_SetSecurity(TRUE)
gnv_app.itr_security = gtr_sce
gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), "SCE")
gnv_app.itr_security.of_Connect()
if (gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, gs_usuario,"Default") <> 1) then
		MessageBox("Atención","No se pudo inicializar correctamente la seguridad")
		Close(this)
end if

f_obten_titulo(w_principal)
w_principal.ChangeMenu(m_principal)
gnv_app.inv_security.of_SetSecurity(w_principal)
//3)<-

end event

type uo_nombre from uo_nombre_alu_foto within w_bajas_academicas
integer height = 424
integer taborder = 10
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alu_foto::destroy
end on

type dw_imprime_bajas_academicas from datawindow within w_bajas_academicas
integer x = 105
integer y = 1752
integer width = 3584
integer height = 624
integer taborder = 30
string dataobject = "dw_imprime_bajas_academicas"
boolean livescroll = true
end type

event constructor;dw_imprime_bajas_academicas.object.fecha.text = Mid(fecha_espaniol_servidor(gtr_sce),1,11)
end event

type dw_teoria_lab from datawindow within w_bajas_academicas
integer x = 837
integer y = 988
integer width = 1527
integer height = 360
integer taborder = 40
string dataobject = "dw_teoria_lab"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleshadowbox!
end type

type dw_materias_inscritas from datawindow within w_bajas_academicas
integer x = 27
integer y = 440
integer width = 3365
integer height = 1184
integer taborder = 20
string dataobject = "dw_materias_inscritas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;// Juan Campos.  Enero-1997.

IF wf_renglon_cursor() > 0 then  	
  m_bajas_academicas.m_baja.enabled = true
  m_bajas_academicas.m_reactivabaja.enabled = true	 
ELSE
  MessageBox("AVISO","EL RENGLON NO FUE SELECCIONADO CORRECTAMENTE") 
END IF 


end event

event rowfocuschanged;// Juan Campos.  Enero-1997.

IF wf_renglon_cursor() > 0 then  	
  m_bajas_academicas.m_baja.enabled = true
  m_bajas_academicas.m_reactivabaja.enabled = true	 
ELSE
  MessageBox("AVISO","EL RENGLON NO FUE SELECCIONADO CORRECTAMENTE") 
END IF 

end event

