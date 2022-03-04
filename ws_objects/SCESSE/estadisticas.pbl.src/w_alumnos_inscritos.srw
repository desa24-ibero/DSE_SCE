$PBExportHeader$w_alumnos_inscritos.srw
$PBExportComments$Reportes de alumnos inscritos en el semestre.(varios). Juan Campos Sánchez. Feb-1998.
forward
global type w_alumnos_inscritos from w_master_main_rep
end type
type cb_1 from commandbutton within w_alumnos_inscritos
end type
type tab_alum_insc_por_carrera from tab within w_alumnos_inscritos
end type
type alum_insc_por_carrera from userobject within tab_alum_insc_por_carrera
end type
type st_1 from statictext within alum_insc_por_carrera
end type
type uo_periodo from uo_periodo_variable_tipos within alum_insc_por_carrera
end type
type uo_nivel from uo_nivel_2013 within alum_insc_por_carrera
end type
type cb_inscritos_carrera from commandbutton within alum_insc_por_carrera
end type
type cb_3 from commandbutton within alum_insc_por_carrera
end type
type cb_2 from commandbutton within alum_insc_por_carrera
end type
type st_status from statictext within alum_insc_por_carrera
end type
type dw_alum_insc_por_carr from datawindow within alum_insc_por_carrera
end type
type alum_insc_por_carrera from userobject within tab_alum_insc_por_carrera
st_1 st_1
uo_periodo uo_periodo
uo_nivel uo_nivel
cb_inscritos_carrera cb_inscritos_carrera
cb_3 cb_3
cb_2 cb_2
st_status st_status
dw_alum_insc_por_carr dw_alum_insc_por_carr
end type
type depto_grupo from userobject within tab_alum_insc_por_carrera
end type
type uo_tipo_periodo_dept_gpo from uo_periodo_variable_tipos within depto_grupo
end type
type cb_inscritos_depto from commandbutton within depto_grupo
end type
type st_proceso from statictext within depto_grupo
end type
type dw_imprime_insc_depto_gpo from datawindow within depto_grupo
end type
type cb_5 from commandbutton within depto_grupo
end type
type cb_4 from commandbutton within depto_grupo
end type
type dw_alum_insc_depto_gpo from datawindow within depto_grupo
end type
type depto_grupo from userobject within tab_alum_insc_por_carrera
uo_tipo_periodo_dept_gpo uo_tipo_periodo_dept_gpo
cb_inscritos_depto cb_inscritos_depto
st_proceso st_proceso
dw_imprime_insc_depto_gpo dw_imprime_insc_depto_gpo
cb_5 cb_5
cb_4 cb_4
dw_alum_insc_depto_gpo dw_alum_insc_depto_gpo
end type
type cred_cursados_inscritos from userobject within tab_alum_insc_por_carrera
end type
type cb_6 from commandbutton within cred_cursados_inscritos
end type
type cb_imprime from commandbutton within cred_cursados_inscritos
end type
type cb_genera_reporte from commandbutton within cred_cursados_inscritos
end type
type st_status3 from statictext within cred_cursados_inscritos
end type
type dw_inscritos_creditos from datawindow within cred_cursados_inscritos
end type
type cred_cursados_inscritos from userobject within tab_alum_insc_por_carrera
cb_6 cb_6
cb_imprime cb_imprime
cb_genera_reporte cb_genera_reporte
st_status3 st_status3
dw_inscritos_creditos dw_inscritos_creditos
end type
type tab_alum_insc_por_carrera from tab within w_alumnos_inscritos
alum_insc_por_carrera alum_insc_por_carrera
depto_grupo depto_grupo
cred_cursados_inscritos cred_cursados_inscritos
end type
end forward

global type w_alumnos_inscritos from w_master_main_rep
integer x = 832
integer y = 364
integer width = 5070
integer height = 2980
string title = "Alumnos Inscritos"
boolean resizable = true
long backcolor = 79741120
cb_1 cb_1
tab_alum_insc_por_carrera tab_alum_insc_por_carrera
end type
global w_alumnos_inscritos w_alumnos_inscritos

type variables
integer	Periodo,Año

Transaction itr_parametros_iniciales
n_tr itr_seguridad, itr_original

//nombre de la conexion en parametros_conexion
CONSTANT	string	is_controlescolar_cnx	=	"controlescolar_inscripcion"
CONSTANT	string	is_tesoreria_cnx			=	"controlescolar_inscripcion_tesoreria"
CONSTANT	string	is_becas_cnx				=	"controlescolar_inscripcion_becas"

end variables

on w_alumnos_inscritos.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.tab_alum_insc_por_carrera=create tab_alum_insc_por_carrera
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.tab_alum_insc_por_carrera
end on

on w_alumnos_inscritos.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.tab_alum_insc_por_carrera)
end on

event open;// Alumnos Inscritos.    Reportes varios.
// Juan Campos Sánchez.      Enero-1998.

periodo_actual_mat_insc(Periodo,Año,gtr_sce)


//**--**
//tab_alum_insc_por_carrera.alum_insc_por_carrera.uo_tipo_periodo.f_inicializa_servicio(gtr_sce) 
//tab_alum_insc_por_carrera.depto_grupo.uo_tipo_periodo_dept_gpo.f_inicializa_servicio(gtr_sce) 
//RETURN 0
tab_alum_insc_por_carrera.alum_insc_por_carrera.uo_periodo.of_inicializa_servicio("V", "L", "L", "S", gtr_sce)
tab_alum_insc_por_carrera.depto_grupo.uo_tipo_periodo_dept_gpo.of_inicializa_servicio("V", "L", "L", "S", gtr_sce)
 

//**--**


int li_retorno, li_periodo, li_anio, li_coord_usuario, li_chk, li_num_items, li_item_actual
//Cambio por Ajustes en Línea
//1)->
//Se conecta a la seguridad para mantener separada una transacción para la seguridad
if not (conecta_bd_n_tr(itr_seguridad,gs_sce,gs_usuario,gs_password) = 1) then
	messageBox('Error en seguridad', 'No es posible validar la seguridad del usuario',Stopsign!)
end if

itr_parametros_iniciales = gtr_sce

li_chk	=	f_conecta_pas_parametros_act_bd(itr_parametros_iniciales,gtr_sce,is_controlescolar_cnx,gs_usuario,gs_password,1)
if li_chk <> 1 then return


//Es necesario reasignar el transaction object para la seguridad
gnv_app.of_SetSecurity(TRUE)
gnv_app.itr_security = itr_seguridad
gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), gs_sce)
gnv_app.itr_security.of_Connect()
if (gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, gs_usuario,"Default") <> 1) then
		MessageBox("Atención","No se pudo inicializar correctamente la seguridad")
		Close(this)
end if

//Cambio por Ajustes en Línea
//1)<-



//Cambio por Ajustes en Línea
//2)->
//Se vuelve a poner porque en el constructor de los datawindows ya previamente se había ejecutado apuntando a sybase
//dw_alum_insc_depto_gpo.SetTransObject(gtr_sce)
tab_alum_insc_por_carrera.depto_grupo.dw_alum_insc_depto_gpo.SetTransObject(gtr_sce)

//dw_alum_insc_por_carr.SetTransObject(gtr_sce)

tab_alum_insc_por_carrera.alum_insc_por_carrera.dw_alum_insc_por_carr.SetTransObject(gtr_sce)

//dw_imprime_insc_depto_gpo.SetTransObject(gtr_sce)

tab_alum_insc_por_carrera.depto_grupo.dw_imprime_insc_depto_gpo.SetTransObject(gtr_sce)

//dw_inscritos_credito.SetTransObject(gtr_sce)

tab_alum_insc_por_carrera.cred_cursados_inscritos.dw_inscritos_creditos.SetTransObject(gtr_sce)

tab_alum_insc_por_carrera.alum_insc_por_carrera.uo_nivel.of_carga_control(gtr_sce)

f_obten_titulo(w_principal)

w_principal.ChangeMenu(m_grupos_impartidos_salir)

//Cambio por Ajustes en Línea
//2)<-



end event

event close;//Cambio por Ajustes en Línea
//3)->
//Se conecta a la base de datos original para reasignar a la transacción principal
if not (conecta_bd_n_tr(itr_original,gs_sce,gs_usuario,gs_password) = 1) then
	messageBox('Error en conectividad', 'No es posible reconectarse al origen. Favor de reiniciar la aplicación',Stopsign!)
	HALT CLOSE		
end if

//Se asigna la transacción original
gtr_sce = itr_original 

//Es necesario reasignar el transaction object para la seguridad
gnv_app.of_SetSecurity(TRUE)
gnv_app.itr_security = gtr_sce
gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), gs_sce)
gnv_app.itr_security.of_Connect()
if (gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, gs_usuario,"Default") <> 1) then
		MessageBox("Atención","No se pudo inicializar correctamente la seguridad")
		Close(this)
end if
 
f_obten_titulo(w_principal)
w_principal.ChangeMenu(m_principal)
gnv_app.inv_security.of_SetSecurity(w_principal)

//Cambio por Ajustes en Línea
//3)<-

end event

type st_sistema from w_master_main_rep`st_sistema within w_alumnos_inscritos
integer y = 88
end type

type p_ibero from w_master_main_rep`p_ibero within w_alumnos_inscritos
integer y = 4
end type

type cb_1 from commandbutton within w_alumnos_inscritos
integer x = 3643
integer y = 288
integer width = 247
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar"
end type

event clicked;Close(w_alumnos_inscritos)
end event

type tab_alum_insc_por_carrera from tab within w_alumnos_inscritos
integer x = 41
integer y = 284
integer width = 3904
integer height = 2456
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
alum_insc_por_carrera alum_insc_por_carrera
depto_grupo depto_grupo
cred_cursados_inscritos cred_cursados_inscritos
end type

on tab_alum_insc_por_carrera.create
this.alum_insc_por_carrera=create alum_insc_por_carrera
this.depto_grupo=create depto_grupo
this.cred_cursados_inscritos=create cred_cursados_inscritos
this.Control[]={this.alum_insc_por_carrera,&
this.depto_grupo,&
this.cred_cursados_inscritos}
end on

on tab_alum_insc_por_carrera.destroy
destroy(this.alum_insc_por_carrera)
destroy(this.depto_grupo)
destroy(this.cred_cursados_inscritos)
end on

type alum_insc_por_carrera from userobject within tab_alum_insc_por_carrera
integer x = 18
integer y = 112
integer width = 3867
integer height = 2328
long backcolor = 16777215
string text = "Por Carrera"
long tabtextcolor = 128
long tabbackcolor = 8388608
string picturename = "Run!"
long picturemaskcolor = 27291696
st_1 st_1
uo_periodo uo_periodo
uo_nivel uo_nivel
cb_inscritos_carrera cb_inscritos_carrera
cb_3 cb_3
cb_2 cb_2
st_status st_status
dw_alum_insc_por_carr dw_alum_insc_por_carr
end type

on alum_insc_por_carrera.create
this.st_1=create st_1
this.uo_periodo=create uo_periodo
this.uo_nivel=create uo_nivel
this.cb_inscritos_carrera=create cb_inscritos_carrera
this.cb_3=create cb_3
this.cb_2=create cb_2
this.st_status=create st_status
this.dw_alum_insc_por_carr=create dw_alum_insc_por_carr
this.Control[]={this.st_1,&
this.uo_periodo,&
this.uo_nivel,&
this.cb_inscritos_carrera,&
this.cb_3,&
this.cb_2,&
this.st_status,&
this.dw_alum_insc_por_carr}
end on

on alum_insc_por_carrera.destroy
destroy(this.st_1)
destroy(this.uo_periodo)
destroy(this.uo_nivel)
destroy(this.cb_inscritos_carrera)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.st_status)
destroy(this.dw_alum_insc_por_carr)
end on

type st_1 from statictext within alum_insc_por_carrera
integer x = 1705
integer y = 336
integer width = 402
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "* Periodo Activo"
boolean focusrectangle = false
end type

type uo_periodo from uo_periodo_variable_tipos within alum_insc_por_carrera
event destroy ( )
integer x = 658
integer y = 20
integer width = 1038
integer height = 384
integer taborder = 40
boolean bringtotop = true
end type

on uo_periodo.destroy
call uo_periodo_variable_tipos::destroy
end on

type uo_nivel from uo_nivel_2013 within alum_insc_por_carrera
integer x = 27
integer y = 12
integer taborder = 34
end type

on uo_nivel.destroy
call uo_nivel_2013::destroy
end on

type cb_inscritos_carrera from commandbutton within alum_insc_por_carrera
integer x = 2779
integer y = 28
integer width = 882
integer height = 108
integer taborder = 21
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Guardar como archivo de Excel"
end type

event clicked;//Modificado 1-feb-2005
string ls_cadena_destino=""

IF dw_alum_insc_por_carr.RowCount() > 0 Then
	dw_alum_insc_por_carr.SaveAs(ls_cadena_destino,EXCEL!,True)
	Messagebox("Archivo guardado","El archivo se guardo exitosamente",Information!)
Else
	Messagebox("No hay datos para guardar","")
End IF
end event

type cb_3 from commandbutton within alum_insc_por_carrera
integer x = 2263
integer y = 28
integer width = 489
integer height = 108
integer taborder = 12
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Imprime Reporte"
end type

event clicked;// Juan Campos Sánchez.     22-Enero-1998.

If dw_alum_insc_por_carr.RowCount() > 0 Then
	If Messagebox("Deasa imprimir el reporte","",Question!,YesNO!,1) = 1 Then
		st_status.text = "Imprimiendo reporte.   Espere."   
		dw_alum_insc_por_carr.Print()
	End If
End IF

st_status.text = "Fin de proceso."   

end event

type cb_2 from commandbutton within alum_insc_por_carrera
integer x = 1765
integer y = 28
integer width = 471
integer height = 108
integer taborder = 11
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Genera Reporte"
end type

event clicked;// Juan campos Sánchez.	Enero-1998.



String	Nivel,Fecha
String ls_array_nivel[]
 
//If cbx_licenciatura.checked Then
//	Nivel = "L"
//ElseIf cbx_postgrado.checked Then
//	Nivel = "P"
//Else
//	Messagebox("Aviso","Selecciona un nivel académico")
//	Return
//End IF

tab_alum_insc_por_carrera.alum_insc_por_carrera.uo_nivel.of_carga_arreglo_nivel( )
tab_alum_insc_por_carrera.alum_insc_por_carrera.uo_nivel.of_obtiene_array( ls_array_nivel[])

If UpperBound(ls_array_nivel[]) <= 0 Then
	MessageBox(" Error ","Debe seleccionar un nivel",StopSign!)
	return
End If

// DESCOMENTAR  DESCOMENTAR  DESCOMENTAR  DESCOMENTAR  DESCOMENTAR  DESCOMENTAR 
// DESCOMENTAR  DESCOMENTAR  DESCOMENTAR  DESCOMENTAR  DESCOMENTAR  DESCOMENTAR 
//If UpperBound(ls_array_nivel[]) > 1 Then
//	MessageBox(" Error ","Debe seleccionar sólo un nivel",StopSign!)
//	return
//End If
// DESCOMENTAR  DESCOMENTAR  DESCOMENTAR  DESCOMENTAR  DESCOMENTAR  DESCOMENTAR 
// DESCOMENTAR  DESCOMENTAR  DESCOMENTAR  DESCOMENTAR  DESCOMENTAR  DESCOMENTAR 

//**--**
STRING ls_query
STRING ls_nivel 
STRING ls_periodos
INTEGER le_index
STRING ls_coma
INTEGER le_array_periodo[]
STRING ls_niveles
STRING ls_desc_periodos 
STRING ls_nivel_actual_desc
//ls_desc_periodos = tab_alum_insc_por_carrera.alum_insc_por_carrera.uo_tipo_periodo.f_recupera_descripcion_periodos()
//le_array_periodo[] = tab_alum_insc_por_carrera.alum_insc_por_carrera.uo_tipo_periodo.ii_periodos[] 


tab_alum_insc_por_carrera.alum_insc_por_carrera.uo_periodo.of_recupera_periodos()
FOR le_index = 1 TO UPPERBOUND(tab_alum_insc_por_carrera.alum_insc_por_carrera.uo_periodo.istr_periodos[])
	
//	IF TRIM(ls_periodo_elegido) <> "" THEN ls_periodo_elegido = ls_periodo_elegido + ", "
//	ls_periodo_elegido = ls_periodo_elegido + PARENT.uo_periodo.istr_periodos[le_index].descripcion 
	le_array_periodo[le_index] = tab_alum_insc_por_carrera.alum_insc_por_carrera.uo_periodo.istr_periodos[le_index].periodo
//	le_periodo_temp = PARENT.uo_periodo.istr_periodos[le_index].periodo
NEXT




// Se genera cadena de niveles seleccionados.
FOR le_index = 1 TO UPPERBOUND(ls_array_nivel[]) 
	
	ls_nivel = ls_nivel + ls_coma + "~~~'" + ls_array_nivel[le_index] + "~~~'"  
	ls_nivel_actual_desc = f_decodifica_nivel(ls_array_nivel[le_index])  
	
	ls_niveles = ls_niveles + ls_coma + ls_nivel_actual_desc  
	
	ls_coma = ", "
	
NEXT 
dw_alum_insc_por_carr.object.nivel_academico.text = ls_niveles


ls_coma = ""
// Se genera cadena de Periodos seleccionados.
FOR le_index = 1 TO UPPERBOUND(le_array_periodo[]) 
	ls_periodos = ls_periodos + ls_coma + STRING(le_array_periodo[le_index])
	ls_coma = ", "
NEXT 

// Se genera cadena de Query
ls_query = "SELECT carreras.carrera,  " + & 
					" academicos.cve_carrera,  " + &  
					" count(banderas_inscrito.cuenta)  as tot_inscritos " + &
			 " FROM academicos,   " + & 
					" banderas_inscrito,  " + &  
					" carreras   " + &
			" WHERE ( banderas_inscrito.cuenta = academicos.cuenta ) and   " + &
					" ( academicos.cve_carrera = carreras.cve_carrera ) and   " + &
					" (academicos.nivel IN(" + ls_nivel  + " ))  " + &
					" and  EXISTS(SELECT * FROM mat_inscritas "	+ &  
					" WHERE mat_inscritas.cve_condicion IN (0,1,3) "	+ & 
					" AND mat_inscritas.periodo IN(" + ls_periodos + ") "	+ & 
					" AND mat_inscritas.cuenta =  banderas_inscrito.cuenta) " + & 						
			" GROUP BY carreras.carrera,    " + &
					" academicos.cve_carrera    " 

tab_alum_insc_por_carrera.alum_insc_por_carrera.dw_alum_insc_por_carr.MODIFY("Datawindow.Table.Select = '" + ls_query + "'" )

//**--**


st_status.text = "Generando reporte.   Espere."   
//If dw_alum_insc_por_carr.Retrieve(ls_array_nivel[]) > 0 Then
If dw_alum_insc_por_carr.Retrieve() > 0 Then
	Fecha = Mid(Fecha_Espaniol_Servidor(gtr_sce),1,12)
	dw_alum_insc_por_carr.object.Fecha_hoy.text = Fecha
 	//dw_alum_insc_por_carr.object.periodo_anio.text = Periodo_String(Periodo)+" "+ String(Año) 
	 dw_alum_insc_por_carr.object.periodo_anio.text = ls_desc_periodos + " " + String(Año) 
	 


// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 
// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 

//If UpperBound(ls_array_nivel[]) = 1 Then
//	Choose case ls_array_nivel[1]
//		Case "L"
//			dw_alum_insc_por_carr.object.nivel_academico.text = "LICENCIATURA"
//		Case "P"
//			dw_alum_insc_por_carr.object.nivel_academico.text = "POSGRADO"
//		Case "T"
//			dw_alum_insc_por_carr.object.nivel_academico.text = "TSU"
//	End Choose
//End If
	
// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 
// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 

	
//	If Nivel = "L" Then
//		dw_alum_insc_por_carr.object.nivel_academico.text = "LICENCIATURA"
//	Else
//		dw_alum_insc_por_carr.object.nivel_academico.text = "POSTGRADO"
//	End if
	st_status.text = "Fin de proceso."   
Else
  Messagebox("Aviso","No hay datos con este nivel")
  st_status.text = "Status de proceso"   
End if


 

end event

type st_status from statictext within alum_insc_por_carrera
integer x = 1765
integer y = 140
integer width = 1893
integer height = 92
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16776960
long backcolor = 8388608
boolean enabled = false
string text = "Status del proceso"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_alum_insc_por_carr from datawindow within alum_insc_por_carrera
integer x = 14
integer y = 416
integer width = 3799
integer height = 1896
integer taborder = 3
boolean titlebar = true
string dataobject = "dw_alum_insc_por_carr"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;dw_alum_insc_por_carr.settransobject(gtr_sce)
end event

type depto_grupo from userobject within tab_alum_insc_por_carrera
integer x = 18
integer y = 112
integer width = 3867
integer height = 2328
long backcolor = 16777215
string text = "Por Departamento Grupo"
long tabtextcolor = 128
long tabbackcolor = 8388608
string picturename = "ArrangeIcons!"
long picturemaskcolor = 16776960
uo_tipo_periodo_dept_gpo uo_tipo_periodo_dept_gpo
cb_inscritos_depto cb_inscritos_depto
st_proceso st_proceso
dw_imprime_insc_depto_gpo dw_imprime_insc_depto_gpo
cb_5 cb_5
cb_4 cb_4
dw_alum_insc_depto_gpo dw_alum_insc_depto_gpo
end type

on depto_grupo.create
this.uo_tipo_periodo_dept_gpo=create uo_tipo_periodo_dept_gpo
this.cb_inscritos_depto=create cb_inscritos_depto
this.st_proceso=create st_proceso
this.dw_imprime_insc_depto_gpo=create dw_imprime_insc_depto_gpo
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_alum_insc_depto_gpo=create dw_alum_insc_depto_gpo
this.Control[]={this.uo_tipo_periodo_dept_gpo,&
this.cb_inscritos_depto,&
this.st_proceso,&
this.dw_imprime_insc_depto_gpo,&
this.cb_5,&
this.cb_4,&
this.dw_alum_insc_depto_gpo}
end on

on depto_grupo.destroy
destroy(this.uo_tipo_periodo_dept_gpo)
destroy(this.cb_inscritos_depto)
destroy(this.st_proceso)
destroy(this.dw_imprime_insc_depto_gpo)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.dw_alum_insc_depto_gpo)
end on

type uo_tipo_periodo_dept_gpo from uo_periodo_variable_tipos within depto_grupo
event destroy ( )
integer x = 320
integer y = 32
integer width = 1033
integer taborder = 50
boolean bringtotop = true
end type

on uo_tipo_periodo_dept_gpo.destroy
call uo_periodo_variable_tipos::destroy
end on

type cb_inscritos_depto from commandbutton within depto_grupo
integer x = 2405
integer y = 28
integer width = 882
integer height = 108
integer taborder = 24
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Guardar como archivo de Excel"
end type

event clicked;//Modificado 1-feb-2005
string ls_cadena_destino=""

IF dw_imprime_insc_depto_gpo.RowCount() > 0 Then
	dw_imprime_insc_depto_gpo.SaveAs(ls_cadena_destino,EXCEL!,True)
	Messagebox("Archivo guardado","El archivo se guardo exitosamente",Information!)
Else
	Messagebox("No hay datos para guardar","")
End IF
end event

type st_proceso from statictext within depto_grupo
integer x = 1390
integer y = 140
integer width = 1897
integer height = 92
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16776960
long backcolor = 8388608
boolean enabled = false
string text = "Status del Proceso"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_imprime_insc_depto_gpo from datawindow within depto_grupo
integer x = 23
integer y = 436
integer width = 3758
integer height = 1844
integer taborder = 3
string dataobject = "dw_imprime_insc_depto_gpo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;dw_imprime_insc_depto_gpo.settransobject(gtr_sce)
end event

type cb_5 from commandbutton within depto_grupo
integer x = 1888
integer y = 28
integer width = 489
integer height = 108
integer taborder = 13
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Imprime Reporte"
end type

event clicked;// Juan Campos Sánchez.

printsetup()
st_proceso.text = "Imprimiendo Reporte.      Espere."
dw_imprime_insc_depto_gpo.print()
st_proceso.text = "Fin de Proceso."

 
end event

type cb_4 from commandbutton within depto_grupo
integer x = 1390
integer y = 28
integer width = 448
integer height = 108
integer taborder = 13
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Genera Reporte"
end type

event clicked;// Juan Campos Sánchez.			23-Enero-1998.
// Falta solo un detalle . sea paciente....

Integer	I,j,Rango1=1,Rango2=5,Depto,SumaGpo,Reng
Long		NumBusqueda = 0
String	Nombre,Texto,Fecha

STRING ls_desc_periodos
INTEGER le_array_periodo[]
//ls_desc_periodos = tab_alum_insc_por_carrera.alum_insc_por_carrera.uo_tipo_periodo.f_recupera_descripcion_periodos()
//le_array_periodo[] = tab_alum_insc_por_carrera.depto_grupo.uo_tipo_periodo_dept_gpo.ii_periodos[] 

//ls_periodo
//ls_desc_periodos = tab_alum_insc_por_carrera.depto_grupo.uo_tipo_periodo_dept_gpo.f_recupera_descripcion_periodos()
INTEGER le_index 

tab_alum_insc_por_carrera.depto_grupo.uo_tipo_periodo_dept_gpo.of_recupera_periodos()
FOR le_index = 1 TO UPPERBOUND(tab_alum_insc_por_carrera.depto_grupo.uo_tipo_periodo_dept_gpo.istr_periodos[])
	
	IF TRIM(ls_desc_periodos) <> "" THEN ls_desc_periodos = ls_desc_periodos + ", "
	ls_desc_periodos = ls_desc_periodos + tab_alum_insc_por_carrera.depto_grupo.uo_tipo_periodo_dept_gpo.istr_periodos[le_index].descripcion 
	le_array_periodo[le_index] = tab_alum_insc_por_carrera.depto_grupo.uo_tipo_periodo_dept_gpo.istr_periodos[le_index].periodo
//	le_periodo_temp = PARENT.uo_periodo.istr_periodos[le_index].periodo

NEXT


st_proceso.text = "Generando reporte.    Espere."
Fecha = Mid(Fecha_Espaniol_Servidor(gtr_sce),1,12)
dw_imprime_insc_depto_gpo.object.Fecha_hoy.text = Fecha
//dw_imprime_insc_depto_gpo.object.periodoanio.text = Periodo_String(Periodo)+" "+String(Año)
dw_imprime_insc_depto_gpo.object.periodoanio.text = ls_desc_periodos+" "+String(Año)


For I = 1 To 14
	//IF dw_alum_insc_depto_gpo.Retrieve(Rango1,Rango2,Periodo,Año) > 0 Then
	IF dw_alum_insc_depto_gpo.Retrieve(Rango1,Rango2,le_array_periodo[] ,Año) > 0 Then
	
		For j=1 To dw_alum_insc_depto_gpo.RowCount() 
      	Depto		=	dw_alum_insc_depto_gpo.GetItemNumber(j,"coordinaciones_cve_coordinacion")
			dw_imprime_insc_depto_gpo.Accepttext()
			Texto = "cve_depto = " +String(Depto)
			NumBusqueda = dw_imprime_insc_depto_gpo.Find(Texto,1,dw_imprime_insc_depto_gpo.RowCount( ))
			If NumBusqueda > 0 Then
				Reng = NumBusqueda
			Else
				Reng = dw_imprime_insc_depto_gpo.InsertRow(0)
			End if
			Nombre	=	dw_alum_insc_depto_gpo.GetItemString(j,"coordinaciones_coordinacion")
			SumaGpo	=	dw_alum_insc_depto_gpo.GetItemNumber(j,"compute_0003")
	      dw_imprime_insc_depto_gpo.setitem(Reng,"cve_depto",Depto)
			dw_imprime_insc_depto_gpo.setitem(Reng,"nombre",Nombre)			
			Choose Case Rango2
			Case 5
				dw_imprime_insc_depto_gpo.setitem(Reng,"a",SumaGpo)
			Case 10
				dw_imprime_insc_depto_gpo.setitem(Reng,"b",SumaGpo)
			Case 15
				dw_imprime_insc_depto_gpo.setitem(Reng,"c",SumaGpo)
			Case 20
				dw_imprime_insc_depto_gpo.setitem(Reng,"d",SumaGpo)
			Case 25
				dw_imprime_insc_depto_gpo.setitem(Reng,"e",SumaGpo)
			Case 30
				dw_imprime_insc_depto_gpo.setitem(Reng,"f",SumaGpo)
			Case 35
				dw_imprime_insc_depto_gpo.setitem(Reng,"g",SumaGpo)
			Case 40
				dw_imprime_insc_depto_gpo.setitem(Reng,"h",SumaGpo)
			Case 45
				dw_imprime_insc_depto_gpo.setitem(Reng,"i",SumaGpo)
			Case 50
				dw_imprime_insc_depto_gpo.setitem(Reng,"j",SumaGpo)
			Case 55
				dw_imprime_insc_depto_gpo.setitem(Reng,"k",SumaGpo)
			Case 60
				dw_imprime_insc_depto_gpo.setitem(Reng,"l",SumaGpo)
			Case 65
				dw_imprime_insc_depto_gpo.setitem(Reng,"m",SumaGpo)
			Case 70
				dw_imprime_insc_depto_gpo.setitem(Reng,"n",SumaGpo)
			Case Else
				dw_imprime_insc_depto_gpo.setitem(Reng,"o",SumaGpo)
			End Choose
		Next
	End If	
	Rango1 = Rango1 + 5
	Rango2 = Rango2 + 5
Next

dw_imprime_insc_depto_gpo.Sort()
st_proceso.text = "Fin de Proceso."
end event

type dw_alum_insc_depto_gpo from datawindow within depto_grupo
boolean visible = false
integer x = 3008
integer y = 1076
integer width = 238
integer height = 140
integer taborder = 2
boolean enabled = false
string dataobject = "dw_alum_insc_depto_gpo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;dw_alum_insc_depto_gpo.settransobject(gtr_sce)
end event

type cred_cursados_inscritos from userobject within tab_alum_insc_por_carrera
integer x = 18
integer y = 112
integer width = 3867
integer height = 2328
long backcolor = 16777215
string text = "Créditos Cursados e Inscritos"
long tabtextcolor = 128
long tabbackcolor = 8388608
string picturename = "Graph!"
long picturemaskcolor = 553648127
cb_6 cb_6
cb_imprime cb_imprime
cb_genera_reporte cb_genera_reporte
st_status3 st_status3
dw_inscritos_creditos dw_inscritos_creditos
end type

on cred_cursados_inscritos.create
this.cb_6=create cb_6
this.cb_imprime=create cb_imprime
this.cb_genera_reporte=create cb_genera_reporte
this.st_status3=create st_status3
this.dw_inscritos_creditos=create dw_inscritos_creditos
this.Control[]={this.cb_6,&
this.cb_imprime,&
this.cb_genera_reporte,&
this.st_status3,&
this.dw_inscritos_creditos}
end on

on cred_cursados_inscritos.destroy
destroy(this.cb_6)
destroy(this.cb_imprime)
destroy(this.cb_genera_reporte)
destroy(this.st_status3)
destroy(this.dw_inscritos_creditos)
end on

type cb_6 from commandbutton within cred_cursados_inscritos
integer x = 2167
integer y = 28
integer width = 882
integer height = 108
integer taborder = 14
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Guardar como archivo de Excel"
end type

event clicked;//Modificado 1-feb-2005
string ls_cadena_destino=""

IF dw_inscritos_creditos.RowCount() > 0 Then
	dw_inscritos_creditos.SaveAs(ls_cadena_destino,EXCEL!,True)
	Messagebox("Archivo guardado","El archivo se guardo exitosamente",Information!)
Else
	Messagebox("No hay datos para guardar","")
End IF
end event

type cb_imprime from commandbutton within cred_cursados_inscritos
integer x = 1650
integer y = 28
integer width = 489
integer height = 108
integer taborder = 13
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Imprime Reporte"
end type

event clicked;// Juan Campos Sánchez.      Mar-1998.

IF dw_inscritos_creditos.RowCount() > 0 Then
	st_status3.text= "Imprimiendo reporte.   Espere..."
	dw_inscritos_creditos.Print()
Else
	Messagebox("No hay datos para imprimir","")
End IF

st_status3.text= "Fin de proceso"

end event

type cb_genera_reporte from commandbutton within cred_cursados_inscritos
integer x = 1152
integer y = 28
integer width = 471
integer height = 108
integer taborder = 12
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Genera Reporte"
end type

event clicked;// Juan Campos Sánchez.     Marzo-1998.


st_status3.text= "Generando reporte.   Espere..."
dw_inscritos_creditos.Retrieve()
st_status3.text= "Fin Proceso"
end event

type st_status3 from statictext within cred_cursados_inscritos
integer x = 1152
integer y = 140
integer width = 1445
integer height = 92
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16776960
long backcolor = 8388608
boolean enabled = false
string text = "Status de Proceso"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_inscritos_creditos from datawindow within cred_cursados_inscritos
integer x = 5
integer y = 256
integer width = 3781
integer height = 1824
integer taborder = 4
string dataobject = "dw_inscritos_creditos"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;dw_inscritos_creditos.Settransobject(gtr_sce)
end event

