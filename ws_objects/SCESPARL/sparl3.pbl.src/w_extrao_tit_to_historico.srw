$PBExportHeader$w_extrao_tit_to_historico.srw
forward
global type w_extrao_tit_to_historico from window
end type
type uo_1 from uo_per_ani within w_extrao_tit_to_historico
end type
type dw_extrao_tit_sin_calif from datawindow within w_extrao_tit_to_historico
end type
type st_status from statictext within w_extrao_tit_to_historico
end type
type cb_mat_insc_to_hist from commandbutton within w_extrao_tit_to_historico
end type
type cb_poner5na from commandbutton within w_extrao_tit_to_historico
end type
end forward

global type w_extrao_tit_to_historico from window
integer x = 1056
integer y = 484
integer width = 3433
integer height = 2356
boolean titlebar = true
string title = "Pasar Extraodinario y Titulos a Historico"
string menuname = "m_menugeneral"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
uo_1 uo_1
dw_extrao_tit_sin_calif dw_extrao_tit_sin_calif
st_status st_status
cb_mat_insc_to_hist cb_mat_insc_to_hist
cb_poner5na cb_poner5na
end type
global w_extrao_tit_to_historico w_extrao_tit_to_historico

on w_extrao_tit_to_historico.create
if this.MenuName = "m_menugeneral" then this.MenuID = create m_menugeneral
this.uo_1=create uo_1
this.dw_extrao_tit_sin_calif=create dw_extrao_tit_sin_calif
this.st_status=create st_status
this.cb_mat_insc_to_hist=create cb_mat_insc_to_hist
this.cb_poner5na=create cb_poner5na
this.Control[]={this.uo_1,&
this.dw_extrao_tit_sin_calif,&
this.st_status,&
this.cb_mat_insc_to_hist,&
this.cb_poner5na}
end on

on w_extrao_tit_to_historico.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.dw_extrao_tit_sin_calif)
destroy(this.st_status)
destroy(this.cb_mat_insc_to_hist)
destroy(this.cb_poner5na)
end on

event open;x = 1
y = 1
end event

type uo_1 from uo_per_ani within w_extrao_tit_to_historico
integer x = 110
integer y = 44
integer taborder = 10
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type dw_extrao_tit_sin_calif from datawindow within w_extrao_tit_to_historico
event carga ( )
event anterior ( )
event primero ( )
event siguiente ( )
event ultimo ( )
integer x = 87
integer y = 796
integer width = 3186
integer height = 1212
integer taborder = 30
string dataobject = "d_extrao_tit_sin_calif_rep"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event carga;retrieve(gi_periodo, gi_anio)
end event

event anterior;//anterior
scrollpriorpage ( )

end event

event primero;
/*Ve al primer renglón*/
setcolumn(1)
setfocus()
scrolltorow(1)

end event

event siguiente;scrollnextpage ( )
end event

event ultimo;/*Ve al último renglón*/
setcolumn(1)
setfocus()
scrolltorow(rowcount())
end event

event constructor;m_menugeneral.dw = this
modify("Datawindow.print.preview = Yes")
SetTransObject(gtr_sce)
end event

type st_status from statictext within w_extrao_tit_to_historico
integer x = 105
integer y = 640
integer width = 1362
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Estado"
boolean focusrectangle = false
end type

type cb_mat_insc_to_hist from commandbutton within w_extrao_tit_to_historico
integer x = 105
integer y = 476
integer width = 1458
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pasar Extraodinario y Titulos al Historico de alumnos"
end type

event clicked;string ls_mensaje, ls_mensaje_insert, ls_mensaje_delete
long ll_mat, ll_i
int li_anio, li_periodo, li_status, li_codigo_insert, li_codigo_delete
DataStore lds_extrao_tit_anio_periodo, lds_historico_porcuentaanioper
li_status = 1
lds_extrao_tit_anio_periodo = Create DataStore

lds_historico_porcuentaanioper = Create DataStore
lds_extrao_tit_anio_periodo.DataObject = "d_extrao_tit_anio_periodo"
lds_historico_porcuentaanioper.DataObject = "d_historico_porcuentaanioper"
lds_extrao_tit_anio_periodo.SetTransObject(gtr_sce)
lds_historico_porcuentaanioper.SetTransObject(gtr_sce)
if lds_extrao_tit_anio_periodo.Retrieve(gi_periodo, gi_anio) >= 1 then
	li_anio = gi_anio
	li_periodo = gi_periodo
	dw_extrao_tit_sin_calif.SetFilter("")
	if dw_extrao_tit_sin_calif.Retrieve(gi_periodo, gi_anio) = 0 then
		ll_i = 1
		if IsNull(ll_i) then ll_i = 0
		if li_status = 1 then 
			st_status.text = "Respaldando Bajas Finanzas. . ."
			INSERT INTO historico_baja_finanzas 
			SELECT et.cuenta,et.cve_mat,et.gpo,et.periodo,et.anio,a.cve_carrera,a.cve_plan,et.calificacion,et.tipo_examen
			FROM examen_extrao_titulo et, academicos a
			WHERE et.cuenta = a.cuenta 
			AND et.cve_condicion = 3 
			AND et.periodo = :li_periodo
			AND et.anio = :li_anio
			USING gtr_sce;
			if gtr_sce.sqlcode = 0 then li_status++  //2
		end if
		if li_status = 2 then 
			st_status.text = "Eliminado Bajas Finanzas. . ."
			DELETE FROM examen_extrao_titulo 
			WHERE cve_condicion = 3 
			AND periodo = :li_periodo
			AND anio = :li_anio
			USING gtr_sce;
			if gtr_sce.sqlcode = 0 then li_status++  //3
		end if
		if li_status = 3 then
			COMMIT using gtr_sce;
			st_status.text = "Pasando materias a historico. . ."
			ll_mat = lds_extrao_tit_anio_periodo.Retrieve(gi_periodo, gi_anio) 
			if ll_mat > 0 then
				for ll_i = 1 to ll_mat
					lds_historico_porcuentaanioper.InsertRow(ll_i)
					lds_historico_porcuentaanioper.SetItem(ll_i,"cuenta",lds_extrao_tit_anio_periodo.GetItemNumber(1,"examen_extrao_titulo_cuenta"))
					lds_historico_porcuentaanioper.SetItem(ll_i,"cve_mat",lds_extrao_tit_anio_periodo.GetItemNumber(1,"examen_extrao_titulo_cve_mat"))
					lds_historico_porcuentaanioper.SetItem(ll_i,"gpo",lds_extrao_tit_anio_periodo.GetItemString(1,"examen_extrao_titulo_gpo"))
					lds_historico_porcuentaanioper.SetItem(ll_i,"periodo",lds_extrao_tit_anio_periodo.GetItemNumber(1,"examen_extrao_titulo_periodo"))
					lds_historico_porcuentaanioper.SetItem(ll_i,"anio",lds_extrao_tit_anio_periodo.GetItemNumber(1,"examen_extrao_titulo_anio"))
					lds_historico_porcuentaanioper.SetItem(ll_i,"cve_carrera",lds_extrao_tit_anio_periodo.GetItemNumber(1,"academicos_cve_carrera"))
					lds_historico_porcuentaanioper.SetItem(ll_i,"cve_plan",lds_extrao_tit_anio_periodo.GetItemNumber(1,"academicos_cve_plan"))
					lds_historico_porcuentaanioper.SetItem(ll_i,"calificacion",lds_extrao_tit_anio_periodo.GetItemString(1,"examen_extrao_titulo_calificacion"))
					lds_historico_porcuentaanioper.SetItem(ll_i,"observacion",lds_extrao_tit_anio_periodo.GetItemNumber(1,"examen_extrao_titulo_tipo_examen"))
					lds_extrao_tit_anio_periodo.DeleteRow(1)
					li_codigo_insert = lds_historico_porcuentaanioper.Update()
					ls_mensaje_insert= gtr_sce.sqlerrtext
					li_codigo_delete =lds_extrao_tit_anio_periodo.Update() 
					ls_mensaje_delete=gtr_sce.sqlerrtext
					if ( li_codigo_insert=1 and li_codigo_delete = 1) then
						COMMIT USING gtr_sce;
					else
						ls_mensaje = gtr_sce.sqlerrtext			
						if isnull(ls_mensaje) then ls_mensaje = ""
						ROLLBACK USING gtr_sce;
						MessageBox("Atencion",string(lds_extrao_tit_anio_periodo.GetItemNumber(1,"cuenta"))+&
										"-"+string(lds_extrao_tit_anio_periodo.GetItemNumber(1,"cve_mat"))+&
										" No se pudo pasar una materia al historico "+"Insert:"+ls_mensaje_insert+"Delete:"+ls_mensaje_delete)
					end if
				next
			else
				MessageBox("Atencion","Error en BD al consultar materias")
				rollback using gtr_sce;
			end if
		else
			ls_mensaje = gtr_sce.sqlerrtext
			ROLLBACK using gtr_sce;
			MessageBox("Atencion","NO se pudo pasar el historico "+ls_mensaje)
		end if
	else // Retrieve <> 0
		MessageBox("Atención", "Faltan calificaciones de Extraordinario/Titulo por leer")
	end if
else //Retrieve <> 1
	MessageBox("Atención","No hay calificaciones de Extraordinario/Titulo para pasar al histórico")
end if
st_status.text = "Fin del proceso"
Destroy lds_extrao_tit_anio_periodo

end event

type cb_poner5na from commandbutton within w_extrao_tit_to_historico
boolean visible = false
integer x = 110
integer y = 300
integer width = 1458
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Calificar con 5 o NA las actas faltantes"
end type

event clicked;DataStore lds_extrao_tit_sin_calificacion
long ll_i, ll_cuenta_extrao_tit_falt
int  li_j, li_alumnos_actas, li_alumnos, li_confirmacion

long ll_num_rows, ll_row_actual
string ls_tipo, ls_materias_evaluacion

ll_cuenta_extrao_tit_falt= f_cuenta_extrao_tit_falt(gi_periodo, gi_anio)

if ll_cuenta_extrao_tit_falt = -1 then
	return
end if

st_status.text= "Confirmando calificaciones"

li_confirmacion = MessageBox("A punto de calificar con 5 y NA a los faltantes", &
 "Existen ["+ string(ll_cuenta_extrao_tit_falt) + "] calificaciones sin registar. ~n ¿Desea Continuar?", Question!, YesNo!)

if li_confirmacion <> 1 then
	MessageBox("Cambios no realizados","NO se ha calificado con 5 y NA", Information!)
	return
end if

lds_extrao_tit_sin_calificacion = Create DataStore
lds_extrao_tit_sin_calificacion.DataObject = "d_extrao_tit_sin_calif" 
lds_extrao_tit_sin_calificacion.SetTransObject(gtr_sce)
ll_num_rows = lds_extrao_tit_sin_calificacion.Retrieve(gi_periodo, gi_anio)

for ll_row_actual = 1 to ll_num_rows
	ls_materias_evaluacion = lds_extrao_tit_sin_calificacion.GetItemString(ll_row_actual,"materias_evaluacion")
	ls_tipo = Mid(ls_materias_evaluacion,1,2)
	if  ls_tipo = "NU" then
		lds_extrao_tit_sin_calificacion.SetItem(ll_row_actual,"examen_extrao_titulo_calificacion","5")	
	else
		lds_extrao_tit_sin_calificacion.SetItem(ll_row_actual,"examen_extrao_titulo_calificacion","NA")
	end if
	st_status.text= "Calificando"

next	
	
if lds_extrao_tit_sin_calificacion.Update() = 1 then
	commit using gtr_sce;
	st_status.text= "Actualizando calificaciones"
	MessageBox("Actualizacion Exitosa", "Se han actualizado exitosamente en 5 y NA las calificaciones leidas.", Information!)
else
	rollback using gtr_sce;
	st_status.text= "Revirtiendo calificaciones"
	MessageBox("Atencion", "NO se han actualizado a 5 y NA las calificaciones leidas.", StopSign!)
end if
	
Destroy lds_extrao_tit_sin_calificacion



end event

