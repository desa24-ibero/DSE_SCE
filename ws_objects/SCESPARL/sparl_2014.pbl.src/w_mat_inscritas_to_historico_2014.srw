$PBExportHeader$w_mat_inscritas_to_historico_2014.srw
forward
global type w_mat_inscritas_to_historico_2014 from window
end type
type st_sistema from statictext within w_mat_inscritas_to_historico_2014
end type
type p_ibero from picture within w_mat_inscritas_to_historico_2014
end type
type dw_actas_evaluacion_sin_leer from datawindow within w_mat_inscritas_to_historico_2014
end type
type st_status from statictext within w_mat_inscritas_to_historico_2014
end type
type cb_mat_insc_to_hist from commandbutton within w_mat_inscritas_to_historico_2014
end type
type cb_poner5na from commandbutton within w_mat_inscritas_to_historico_2014
end type
end forward

global type w_mat_inscritas_to_historico_2014 from window
integer width = 5189
integer height = 3348
boolean titlebar = true
string title = "Pasar calificaciones a historico"
string menuname = "m_menugeneral"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 16777215
st_sistema st_sistema
p_ibero p_ibero
dw_actas_evaluacion_sin_leer dw_actas_evaluacion_sin_leer
st_status st_status
cb_mat_insc_to_hist cb_mat_insc_to_hist
cb_poner5na cb_poner5na
end type
global w_mat_inscritas_to_historico_2014 w_mat_inscritas_to_historico_2014

on w_mat_inscritas_to_historico_2014.create
if this.MenuName = "m_menugeneral" then this.MenuID = create m_menugeneral
this.st_sistema=create st_sistema
this.p_ibero=create p_ibero
this.dw_actas_evaluacion_sin_leer=create dw_actas_evaluacion_sin_leer
this.st_status=create st_status
this.cb_mat_insc_to_hist=create cb_mat_insc_to_hist
this.cb_poner5na=create cb_poner5na
this.Control[]={this.st_sistema,&
this.p_ibero,&
this.dw_actas_evaluacion_sin_leer,&
this.st_status,&
this.cb_mat_insc_to_hist,&
this.cb_poner5na}
end on

on w_mat_inscritas_to_historico_2014.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_sistema)
destroy(this.p_ibero)
destroy(this.dw_actas_evaluacion_sin_leer)
destroy(this.st_status)
destroy(this.cb_mat_insc_to_hist)
destroy(this.cb_poner5na)
end on

type st_sistema from statictext within w_mat_inscritas_to_historico_2014
integer x = 805
integer y = 124
integer width = 229
integer height = 100
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 16777215
string text = "DSE"
boolean focusrectangle = false
end type

type p_ibero from picture within w_mat_inscritas_to_historico_2014
integer x = 59
integer y = 40
integer width = 681
integer height = 264
boolean bringtotop = true
string picturename = "logoibero-web.png"
boolean focusrectangle = false
end type

type dw_actas_evaluacion_sin_leer from datawindow within w_mat_inscritas_to_historico_2014
event carga ( )
event anterior ( )
event primero ( )
event siguiente ( )
event ultimo ( )
integer x = 32
integer y = 900
integer width = 3671
integer height = 1536
integer taborder = 30
string dataobject = "d_actas_evaluacion_sin_leer"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event carga;retrieve()
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

type st_status from statictext within w_mat_inscritas_to_historico_2014
integer x = 50
integer y = 744
integer width = 1362
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Estado"
boolean focusrectangle = false
end type

type cb_mat_insc_to_hist from commandbutton within w_mat_inscritas_to_historico_2014
integer x = 50
integer y = 580
integer width = 1362
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Pasar las materias al historico de alumnos"
end type

event clicked;string ls_mensaje, ls_mensaje_insert, ls_mensaje_delete
long ll_mat, ll_i
int li_anio, li_periodo, li_status, li_codigo_insert, li_codigo_delete
int li_anio_rev, li_periodo_rev, li_periodo_revalidacion
DataStore lds_anioperiodo_mat_inscritas, lds_mat_inscritas, lds_historico_porcuentaanioper
int li_inserta_historico_interc = 0
int li_confirmacion_intercambio = 0
li_status = 0
lds_anioperiodo_mat_inscritas = Create DataStore
lds_mat_inscritas = Create DataStore
lds_historico_porcuentaanioper = Create DataStore
lds_anioperiodo_mat_inscritas.DataObject = "d_anioperiodo_mat_inscritas"
lds_mat_inscritas.DataObject = "d_mat_inscritas_2014"
lds_historico_porcuentaanioper.DataObject = "d_historico_porcuentaanioper"
lds_anioperiodo_mat_inscritas.SetTransObject(gtr_sce)
lds_mat_inscritas.SetTransObject(gtr_sce)
lds_historico_porcuentaanioper.SetTransObject(gtr_sce)


if lds_anioperiodo_mat_inscritas.Retrieve() = 1 then
	li_anio = lds_anioperiodo_mat_inscritas.GetItemNumber(1,"anio")
	li_periodo = lds_anioperiodo_mat_inscritas.GetItemNumber(1,"periodo")
	li_periodo_revalidacion = f_obten_periodo_revalidacion(li_periodo, li_anio, li_periodo_rev, li_anio_rev)
	if li_periodo_revalidacion= -1 then
		MessageBox("Error en Periodo de Revalidación", "No es posible continuar con el periodo consultado",StopSign!)
		return
	end if

	dw_actas_evaluacion_sin_leer.SetFilter("")
	if dw_actas_evaluacion_sin_leer.Retrieve() = 0 then
		
		ll_i = 0

		st_status.text = "Pasando horario a historico. . ."
		SELECT COUNT(*) INTO :ll_i FROM horario
		WHERE anio = :li_anio AND periodo = :li_periodo USING gtr_sce;
		if gtr_sce.sqlcode = 0 then li_status++  //1
		if IsNull(ll_i) then ll_i = 0
		if ll_i > 0 then
			if li_status = 1 then
				DELETE FROM hist_horario WHERE anio = :li_anio AND periodo = :li_periodo USING gtr_sce;
				if gtr_sce.sqlcode = 0 then li_status++  //2
			end if
			if li_status = 2 then
				INSERT INTO hist_horario
				SELECT * FROM horario WHERE anio = :li_anio AND periodo = :li_periodo
				USING gtr_sce;
				if gtr_sce.sqlcode = 0 then li_status++  //3
			end if
			if li_status = 3 then
				DELETE FROM horario WHERE anio = :li_anio AND periodo = :li_periodo USING gtr_sce;
				if gtr_sce.sqlcode = 0 then li_status++  //4
			end if
		else
			if li_status = 1 then li_status += 3 //4
		end if
		
		
		
		st_status.text = "Pasando grupos a historico. . ."
		ll_i = 0
		if li_status=4 then
			SELECT COUNT(*) INTO :ll_i FROM grupos
			WHERE anio = :li_anio AND periodo = :li_periodo USING gtr_sce;
			if gtr_sce.sqlcode = 0 then li_status++ //5
		end if
		if IsNull(ll_i) then ll_i = 0
		if ll_i > 0 then
			if li_status = 5 then
				DELETE FROM hist_grupos WHERE anio = :li_anio
				AND periodo = :li_periodo USING gtr_sce;
				if gtr_sce.sqlcode = 0 then li_status++ //6
			end if
			if li_status = 6 then
			INSERT INTO hist_grupos
				SELECT * FROM grupos WHERE anio = :li_anio AND periodo = :li_periodo
				USING gtr_sce;
				if gtr_sce.sqlcode = 0 then li_status++  //7
			end if
			if li_status = 7 then
				DELETE FROM grupos WHERE anio = :li_anio AND periodo = :li_periodo USING gtr_sce;
				if gtr_sce.sqlcode = 0 then li_status++  //8
			end if
		else
			if li_status = 5 then li_status += 3 //8
		end if
		
		
				
		if li_status = 8 then 
			st_status.text = "Copiando histórico de cuentas_cortes. . ."
			INSERT INTO hist_cuentas_cortes
			SELECT DISTINCT cuenta, anio, periodo FROM cuentas_cortes USING gtr_sce;						
			if gtr_sce.sqlcode = 0 then li_status++  //9
		end if
		
		if li_status = 9 then 
			st_status.text = "Eliminando las cuentas_cortes anteriores. . ."
			DELETE FROM cuentas_cortes USING gtr_sce;
			if gtr_sce.sqlcode = 0 then li_status++ //10
		end if
			
		if li_status = 10 then 
			st_status.text = "Creando lista de cortes. . ."
			INSERT INTO cuentas_cortes
			SELECT DISTINCT cuenta, :li_anio, :li_periodo FROM mat_inscritas
			WHERE cve_condicion IN (0,1,3) USING gtr_sce;
			if gtr_sce.sqlcode = 0 then li_status++  //11
		end if
		
		if li_status = 11 then 
			st_status.text = "Creando lista de cortes de Revalidación. . ."
			INSERT INTO cuentas_cortes
			SELECT DISTINCT cuenta, :li_anio, :li_periodo FROM v_sce_carreras_cursadas
			WHERE vigente = 1
			and anio_ing = :li_anio_rev
			AND periodo_ing = :li_periodo_rev
			AND cve_formaingreso = 3
			USING gtr_sce;
			if gtr_sce.sqlcode = 0 then li_status++  //12
		end if
		
	//Respaldo de mat_inscritas en hist_mat_inscritas
		if li_status = 12 then 
			st_status.text = "Creando historico de mat_inscritas. . ."
			INSERT  INTO hist_mat_inscritas  
			(cuenta,   
          cve_mat,   
          gpo,   
          periodo,   
          anio,   
          calificacion,   
          cve_condicion,   
          cve_acreditacion,   
          inscripcion)
			SELECT  cuenta,   
          cve_mat,   
          gpo,   
          periodo,   
          anio,   
          calificacion,   
          cve_condicion,   
          acreditacion,   
          inscripcion
			FROM mat_inscritas   
			WHERE periodo = :li_periodo
			AND   anio = :li_anio 
			USING gtr_sce;			
			if gtr_sce.sqlcode = 0 then li_status++  //13
		end if

	//Respaldo de mat_inscritas en historico_complementario de Laboratorios sin créditos
		if li_status = 13 then 
			st_status.text = "Creando Laboratorios sin créditos. . ."
			INSERT  INTO historico_complementario(cuenta,   
          cve_mat,   
          gpo,   
          periodo,   
          anio,   
          cve_carrera,   
          cve_plan,   
          calificacion,   
          observacion)
			SELECT  mat_inscritas.cuenta,   
			          cve_mat,   
			          gpo,   
			          periodo,   
			          anio,   
			          v_sce_carreras_cursadas.cve_carrera,   
			          v_sce_carreras_cursadas.cve_plan,   
			          calificacion,   
			          7
			FROM mat_inscritas, v_sce_carreras_cursadas 
			WHERE  mat_inscritas.cuenta = v_sce_carreras_cursadas.cuenta
			and vigente = 1
			and cve_mat IN 
								(SELECT tl.cve_lab FROM teoria_lab tl, materias m
								WHERE tl.cve_lab = m.cve_mat AND m.creditos = 0)
			AND periodo = :li_periodo
			AND anio = :li_anio
			USING gtr_sce;			
			if gtr_sce.sqlcode = 0 then li_status++  //14
		end if
		
	//Respaldo de mat_inscritas en historico_complementario de Bajas Totales
		if li_status = 14 then 
			st_status.text = "Creando Bajas Totales. . ."
			INSERT  INTO historico_complementario(mat_inscritas.cuenta,   
          cve_mat,    
          gpo,   
          periodo,   
          anio,   
          v_sce_carreras_cursadas.cve_carrera,   
          v_sce_carreras_cursadas.cve_plan,   
          calificacion,   
          observacion)
			SELECT  mat_inscritas.cuenta,   
				          cve_mat,   
				          gpo,   
				          periodo,   
				          anio,   
				          cve_carrera,   
				          cve_plan,   
				          calificacion,   
				          8
			FROM mat_inscritas, v_sce_carreras_cursadas 
			WHERE mat_inscritas.cuenta = v_sce_carreras_cursadas.cuenta
			AND v_sce_carreras_cursadas.vigente = 1
			and cve_condicion = 2 
			AND periodo = :li_periodo
			AND anio = :li_anio
			USING gtr_sce;			
			if gtr_sce.sqlcode = 0 then li_status++  //15
		end if
		
		if li_status = 15 then 
			st_status.text = "Eliminando laboratorios. . ."
			DELETE FROM mat_inscritas WHERE cve_mat IN 
			(SELECT tl.cve_lab FROM teoria_lab tl, materias m
			WHERE tl.cve_lab = m.cve_mat AND m.creditos = 0) USING gtr_sce;
			if gtr_sce.sqlcode = 0 then li_status++  //16
		end if
		if li_status = 16 then 
			st_status.text = "Eliminando Bajas Totales. . ."
			DELETE FROM mat_inscritas WHERE cve_condicion = 2 USING gtr_sce;
			if gtr_sce.sqlcode = 0 then li_status++  //17
		end if
		if li_status = 17 then 
			st_status.text = "Respaldando Bajas Finanzas. . ."
			INSERT INTO historico_baja_finanzas 
			SELECT mi.cuenta,mi.cve_mat,mi.gpo,mi.periodo,mi.anio,a.cve_carrera,a.cve_plan,mi.calificacion,3
			FROM mat_inscritas mi, v_sce_carreras_cursadas a
			WHERE mi.cuenta = a.cuenta and a.vigente = 1 AND mi.cve_condicion = 3 USING gtr_sce;
			if gtr_sce.sqlcode = 0 then li_status++  //18
		end if
		if li_status = 18 then 
			st_status.text = "Eliminado Bajas Finanzas. . ."
			DELETE FROM mat_inscritas WHERE cve_condicion = 3 USING gtr_sce;
			if gtr_sce.sqlcode = 0 then li_status++  //19
		end if
		
		if li_status = 19 then
			COMMIT using gtr_sce;
			st_status.text = "Pasando materias a historico. . ."
			ll_mat = lds_mat_inscritas.Retrieve()
			if ll_mat > 0 then
				for ll_i = 1 to ll_mat
					lds_historico_porcuentaanioper.InsertRow(ll_i)
					lds_historico_porcuentaanioper.SetItem(ll_i,"cuenta",lds_mat_inscritas.GetItemNumber(1,"cuenta"))
					lds_historico_porcuentaanioper.SetItem(ll_i,"cve_mat",lds_mat_inscritas.GetItemNumber(1,"cve_mat"))
					lds_historico_porcuentaanioper.SetItem(ll_i,"gpo",lds_mat_inscritas.GetItemString(1,"gpo"))
					lds_historico_porcuentaanioper.SetItem(ll_i,"periodo",lds_mat_inscritas.GetItemNumber(1,"periodo"))
					lds_historico_porcuentaanioper.SetItem(ll_i,"anio",lds_mat_inscritas.GetItemNumber(1,"anio"))
					lds_historico_porcuentaanioper.SetItem(ll_i,"cve_carrera",lds_mat_inscritas.GetItemNumber(1,"v_sce_carreras_cursadas_cve_carrera"))
					lds_historico_porcuentaanioper.SetItem(ll_i,"cve_plan",lds_mat_inscritas.GetItemNumber(1,"v_sce_carreras_cursadas_cve_plan"))
					lds_historico_porcuentaanioper.SetItem(ll_i,"calificacion",lds_mat_inscritas.GetItemString(1,"calificacion"))
					lds_historico_porcuentaanioper.SetItem(ll_i,"observacion",3)
					lds_mat_inscritas.DeleteRow(1)
					li_codigo_insert = lds_historico_porcuentaanioper.Update()
					ls_mensaje_insert= gtr_sce.sqlerrtext
					li_codigo_delete =lds_mat_inscritas.Update() 
					ls_mensaje_delete=gtr_sce.sqlerrtext
					if ( li_codigo_insert=1 and li_codigo_delete = 1) then
						COMMIT USING gtr_sce;
					else
						ls_mensaje = gtr_sce.sqlerrtext
						ROLLBACK USING gtr_sce;
						MessageBox("Atencion",string(lds_mat_inscritas.GetItemNumber(1,"cuenta"))+&
										"-"+string(lds_mat_inscritas.GetItemNumber(1,"cve_mat"))+&
										" No se pudo pasar una materia al historico "+"Insert:"+ls_mensaje_insert+"Delete:"+ls_mensaje_delete)
					end if
				next
			else
				MessageBox("Atencion","Error en BD al consultar materias")
				rollback using gtr_sce;
			end if
			st_status.text = "Borrando actas. . ."
			DELETE FROM actas_evaluacion USING gtr_sce;
			if gtr_sce.sqlcode = 0 then 
				COMMIT USING gtr_sce;
			else
				ls_mensaje = gtr_sce.sqlerrtext
				ROLLBACK USING gtr_sce;
				MessageBox("Atencion","No se eliminaron las actas de evaluacion "+ls_mensaje)
			end if
		else
			ls_mensaje = gtr_sce.sqlerrtext
			ROLLBACK using gtr_sce;
			MessageBox("Atencion","NO se pudo pasar el historico "+ls_mensaje)
		end if
	else // Retrieve <> 0
		MessageBox("Atención", "Faltan actas por leer")
	end if
else //Retrieve <> 1
	MessageBox("Atención","No hay algo para pasar al histórico")
end if

st_status.text = "Transferencia de materias de intercambio (ZZ)"
li_confirmacion_intercambio = MessageBox("Confirmación de Intercambio","¿Desea Transferir las materias de intercambio (ZZ)?", Question!, YesNo!, 1)

if li_confirmacion_intercambio <>1 then
	MessageBox("Transferencia Cancelada", "¡Queda pendiente la transferencia de intercambio (ZZ)!", StopSign!)
else
	li_inserta_historico_interc = f_inserta_historico_intercambio(li_periodo, li_anio)
	if li_inserta_historico_interc= 0 then
		MessageBox("Transferencia Exitosa", "Se transfirió intercambio (ZZ) exitosamente", Information!)
	elseif li_inserta_historico_interc= -1 then
		MessageBox("Error en Transferencia", "¡Queda pendiente la transferencia de intercambio (ZZ)!", StopSign!)				
	elseif li_inserta_historico_interc= 100 then
		MessageBox("Transferencia sin registros", "Parece que no hay registros de intercambio (ZZ) a transferir", Information!)		
	end if
end if

st_status.text = "Fin del proceso"
Destroy lds_anioperiodo_mat_inscritas
Destroy lds_mat_inscritas
end event

type cb_poner5na from commandbutton within w_mat_inscritas_to_historico_2014
integer x = 55
integer y = 404
integer width = 1362
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Calificar con 5 o NA las actas faltantes"
end type

event clicked;DataStore lds_cuenta_sin_calificacion_por_materia
long ll_i
int  li_j, li_alumnos_actas, li_alumnos
string ls_tipo
lds_cuenta_sin_calificacion_por_materia = Create DataStore
lds_cuenta_sin_calificacion_por_materia.DataObject = "d_cuenta_sin_calificacion_por_materia" 
lds_cuenta_sin_calificacion_por_materia.SetTransObject(gtr_sce)
dw_actas_evaluacion_sin_leer.SetFilter("")
dw_actas_evaluacion_sin_leer.Retrieve()
for ll_i = 1 to dw_actas_evaluacion_sin_leer.Rowcount()
	st_status.text = "Calificando acta núm.: "+&
		string(dw_actas_evaluacion_sin_leer.GetItemNumber(ll_i, "actas_evaluacion_no_acta"))+" Materia :"+&
		string(dw_actas_evaluacion_sin_leer.GetItemNumber(ll_i,"actas_evaluacion_cve_mat"))+&
		dw_actas_evaluacion_sin_leer.GetItemString(ll_i,"actas_evaluacion_gpo")
	li_alumnos_actas = dw_actas_evaluacion_sin_leer.GetItemNumber(ll_i,"actas_evaluacion_inscritos")
	li_alumnos = lds_cuenta_sin_calificacion_por_materia.Retrieve&
		(dw_actas_evaluacion_sin_leer.GetItemNumber(ll_i,"actas_evaluacion_cve_mat"),&
		dw_actas_evaluacion_sin_leer.GetItemString(ll_i,"actas_evaluacion_gpo")) 
	if li_alumnos = li_alumnos_actas then
		ls_tipo = Mid(lds_cuenta_sin_calificacion_por_materia.GetItemString(1,"materias_evaluacion"),1,2)
		for li_j = 1 to lds_cuenta_sin_calificacion_por_materia.RowCount()
			if  ls_tipo = "NU" then
				lds_cuenta_sin_calificacion_por_materia.SetItem(li_j,"calificacion","5")	
			else
				lds_cuenta_sin_calificacion_por_materia.SetItem(li_j,"calificacion","NA")
			end if
		next
		if lds_cuenta_sin_calificacion_por_materia.Update() = 1 then
			dw_actas_evaluacion_sin_leer.Setitem(ll_i,"actas_evaluacion_status",1)
			if dw_actas_evaluacion_sin_leer.Update() = 1 then
				commit using gtr_sce;
			else
				rollback using gtr_sce;
				MessageBox("Atencion", "Los cambios no se han guardado para el acta"+&
				string(dw_actas_evaluacion_sin_leer.GetItemNumber(ll_i, "actas_evaluacion_no_acta")))
			end if
		else
			rollback using gtr_sce;
			MessageBox("Atencion", "Los cambios no se han guardado para el acta"+&
			string(dw_actas_evaluacion_sin_leer.GetItemNumber(ll_i, "actas_evaluacion_no_acta")))
		end if
		//Actualiza y actualiza status
	else
		MessageBox("Atencion","Los inscritos no coinciden para el acta num:" +&
		string(dw_actas_evaluacion_sin_leer.GetItemNumber(ll_i, "actas_evaluacion_no_acta")))
	end if
	
next
Destroy lds_cuenta_sin_calificacion_por_materia
dw_actas_evaluacion_sin_leer.Retrieve()


end event

