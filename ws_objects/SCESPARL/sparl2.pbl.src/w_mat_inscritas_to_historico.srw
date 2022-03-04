$PBExportHeader$w_mat_inscritas_to_historico.srw
forward
global type w_mat_inscritas_to_historico from window
end type
type st_periodo from statictext within w_mat_inscritas_to_historico
end type
type dw_actas_evaluacion_sin_leer from datawindow within w_mat_inscritas_to_historico
end type
type st_status from statictext within w_mat_inscritas_to_historico
end type
type cb_mat_insc_to_hist from commandbutton within w_mat_inscritas_to_historico
end type
type cb_poner5na from commandbutton within w_mat_inscritas_to_historico
end type
end forward

global type w_mat_inscritas_to_historico from window
integer x = 1056
integer y = 484
integer width = 3433
integer height = 2356
boolean titlebar = true
string title = "Pasar calificaciones a historico"
string menuname = "m_menugeneral"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
st_periodo st_periodo
dw_actas_evaluacion_sin_leer dw_actas_evaluacion_sin_leer
st_status st_status
cb_mat_insc_to_hist cb_mat_insc_to_hist
cb_poner5na cb_poner5na
end type
global w_mat_inscritas_to_historico w_mat_inscritas_to_historico

on w_mat_inscritas_to_historico.create
if this.MenuName = "m_menugeneral" then this.MenuID = create m_menugeneral
this.st_periodo=create st_periodo
this.dw_actas_evaluacion_sin_leer=create dw_actas_evaluacion_sin_leer
this.st_status=create st_status
this.cb_mat_insc_to_hist=create cb_mat_insc_to_hist
this.cb_poner5na=create cb_poner5na
this.Control[]={this.st_periodo,&
this.dw_actas_evaluacion_sin_leer,&
this.st_status,&
this.cb_mat_insc_to_hist,&
this.cb_poner5na}
end on

on w_mat_inscritas_to_historico.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_periodo)
destroy(this.dw_actas_evaluacion_sin_leer)
destroy(this.st_status)
destroy(this.cb_mat_insc_to_hist)
destroy(this.cb_poner5na)
end on

event open;
INTEGER le_periodo 
INTEGER le_anio 
STRING ls_periodo

uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios 
luo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, "L", gtr_sce) 
luo_periodo_servicios.f_carga_periodo_activo( le_periodo, le_anio, gtr_sce) 
ls_periodo = luo_periodo_servicios.f_recupera_descripcion( le_periodo, "L") 

st_periodo.TEXT = ls_periodo + " - " + STRING(le_anio) 




end event

type st_periodo from statictext within w_mat_inscritas_to_historico
integer x = 1627
integer y = 104
integer width = 1627
integer height = 144
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_actas_evaluacion_sin_leer from datawindow within w_mat_inscritas_to_historico
event carga ( )
event anterior ( )
event primero ( )
event siguiente ( )
event ultimo ( )
integer x = 87
integer y = 400
integer width = 3186
integer height = 1608
integer taborder = 30
string dataobject = "d_actas_evaluacion_sin_leer"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event carga();retrieve(gs_tipo_periodo)
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

type st_status from statictext within w_mat_inscritas_to_historico
integer x = 105
integer y = 272
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

type cb_mat_insc_to_hist from commandbutton within w_mat_inscritas_to_historico
integer x = 105
integer y = 108
integer width = 1362
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
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
lds_mat_inscritas.DataObject = "d_mat_inscritas"
lds_historico_porcuentaanioper.DataObject = "d_historico_porcuentaanioper"
lds_anioperiodo_mat_inscritas.SetTransObject(gtr_sce)
lds_mat_inscritas.SetTransObject(gtr_sce)
lds_historico_porcuentaanioper.SetTransObject(gtr_sce)


if lds_anioperiodo_mat_inscritas.Retrieve(gs_tipo_periodo) = 1 then 
	li_anio = lds_anioperiodo_mat_inscritas.GetItemNumber(1,"anio")
	li_periodo = lds_anioperiodo_mat_inscritas.GetItemNumber(1,"periodo")
	li_periodo_revalidacion = f_obten_periodo_revalidacion(li_periodo, li_anio, li_periodo_rev, li_anio_rev)
	if li_periodo_revalidacion= -1 then
		MessageBox("Error en Periodo de Revalidación", "No es posible continuar con el periodo consultado",StopSign!)
		return
	end if

	dw_actas_evaluacion_sin_leer.SetFilter("")
	if dw_actas_evaluacion_sin_leer.Retrieve(gs_tipo_periodo) = 0 then 
		
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
		
		// Oscar Sánchez, 20-Jun-2019. Se agraga la tabla horario_modular...
		st_status.text = "Pasando horario_modular a historico. . ."
		SELECT COUNT(*) INTO :ll_i FROM horario_modular
		WHERE anio = :li_anio AND periodo = :li_periodo USING gtr_sce;
		if gtr_sce.sqlcode = 0 then li_status++  //5
		if IsNull(ll_i) then ll_i = 0
		if ll_i > 0 then
			if li_status = 5 then
				DELETE FROM hist_horario_modular WHERE anio = :li_anio AND periodo = :li_periodo USING gtr_sce;
				if gtr_sce.sqlcode = 0 then li_status++  //6
			end if
			if li_status = 6 then
				INSERT INTO hist_horario_modular
				SELECT * FROM horario_modular WHERE anio = :li_anio AND periodo = :li_periodo
				USING gtr_sce;
				if gtr_sce.sqlcode = 0 then li_status++  //7
			end if
			if li_status = 7 then
				DELETE FROM horario_modular WHERE anio = :li_anio AND periodo = :li_periodo USING gtr_sce;
				if gtr_sce.sqlcode = 0 then li_status++  //8
			end if
		else
			if li_status = 5 then li_status += 3 //8
		end if

		// Oscar Sánchez, 24-Jun-2019. Se agraga la tabla hist_profesor_cotitular...
		st_status.text = "Pasando profesor_cotitular a historico. . ."
		SELECT COUNT(*) INTO :ll_i FROM profesor_cotitular
		WHERE anio = :li_anio AND periodo = :li_periodo USING gtr_sce;
		if gtr_sce.sqlcode = 0 then li_status++  //9
		if IsNull(ll_i) then ll_i = 0
		if ll_i > 0 then
			if li_status = 9 then
				DELETE FROM hist_profesor_cotitular WHERE anio = :li_anio AND periodo = :li_periodo USING gtr_sce;
				if gtr_sce.sqlcode = 0 then li_status++  //10
			end if
			if li_status = 10 then
				INSERT INTO hist_profesor_cotitular
				SELECT * FROM profesor_cotitular WHERE anio = :li_anio AND periodo = :li_periodo
				USING gtr_sce;
				if gtr_sce.sqlcode = 0 then li_status++  //11
			end if
			if li_status = 11 then
				DELETE FROM profesor_cotitular WHERE anio = :li_anio AND periodo = :li_periodo USING gtr_sce;
				if gtr_sce.sqlcode = 0 then li_status++  //12
			end if
		else
			if li_status = 9 then li_status += 3 //12
		end if
		
		// Oscar Sánchez, 24-Jun-2019. Se agraga la tabla hist_horario_profesor_grupo...
		st_status.text = "Pasando horario_profesor_grupo a historico. . ."
		SELECT COUNT(*) INTO :ll_i FROM horario_profesor_grupo
		WHERE anio = :li_anio AND periodo = :li_periodo USING gtr_sce;
		if gtr_sce.sqlcode = 0 then li_status++  //13
		if IsNull(ll_i) then ll_i = 0
		if ll_i > 0 then
			if li_status = 13 then
				DELETE FROM hist_horario_profesor_grupo WHERE anio = :li_anio AND periodo = :li_periodo USING gtr_sce;
				if gtr_sce.sqlcode = 0 then li_status++  //14
			end if
			if li_status = 14 then
				INSERT INTO hist_horario_profesor_grupo
				SELECT * FROM horario_profesor_grupo WHERE anio = :li_anio AND periodo = :li_periodo
				USING gtr_sce;
				if gtr_sce.sqlcode = 0 then li_status++  //15
			end if
			if li_status = 15 then
				DELETE FROM horario_profesor_grupo WHERE anio = :li_anio AND periodo = :li_periodo USING gtr_sce;
				if gtr_sce.sqlcode = 0 then li_status++  //16
			end if
		else
			if li_status = 13 then li_status += 3 //16
		end if
		
		// Oscar Sánchez, 24-Jun-2019. Se agraga la tabla hist_grupos_bloques...
		st_status.text = "Pasando grupos_bloques a historico. . ."
		SELECT COUNT(*) INTO :ll_i FROM grupos_bloques
		WHERE anio = :li_anio AND periodo = :li_periodo USING gtr_sce;
		if gtr_sce.sqlcode = 0 then li_status++  //17
		if IsNull(ll_i) then ll_i = 0
		if ll_i > 0 then
			if li_status = 17 then
				DELETE FROM hist_grupos_bloques WHERE anio = :li_anio AND periodo = :li_periodo USING gtr_sce;
				if gtr_sce.sqlcode = 0 then li_status++  //18
			end if
			if li_status = 18 then
				INSERT INTO hist_grupos_bloques
				SELECT * FROM grupos_bloques WHERE anio = :li_anio AND periodo = :li_periodo
				USING gtr_sce;
				if gtr_sce.sqlcode = 0 then li_status++  //19
			end if
			if li_status = 19 then
				DELETE FROM grupos_bloques WHERE anio = :li_anio AND periodo = :li_periodo USING gtr_sce;
				if gtr_sce.sqlcode = 0 then li_status++  //20
			end if
		else
			if li_status = 17 then li_status += 3 //20
		end if
		
		st_status.text = "Pasando grupos a historico. . ."
		ll_i = 0
		if li_status=20 then
			SELECT COUNT(*) INTO :ll_i FROM grupos
			WHERE anio = :li_anio AND periodo = :li_periodo USING gtr_sce;
			if gtr_sce.sqlcode = 0 then li_status++ //21
		end if
		if IsNull(ll_i) then ll_i = 0
		if ll_i > 0 then
			if li_status = 21 then
				DELETE FROM hist_grupos WHERE anio = :li_anio
				AND periodo = :li_periodo USING gtr_sce;
				if gtr_sce.sqlcode = 0 then li_status++ //22
			end if
			if li_status = 22 then
//			INSERT INTO hist_grupos
//				SELECT * FROM grupos WHERE anio = :li_anio AND periodo = :li_periodo
//				USING gtr_sce;
				INSERT INTO hist_grupos	(
													cve_mat_gpo, cve_mat, gpo, periodo, anio, 
													cond_gpo, cupo, tipo, inscritos, insc_desp_bajas, 
													cve_asimilada, gpo_asimilado, cve_profesor, prom_gpo, porc_asis, 
													ema4, primer_sem, comentarios,
													// Oscar Sánchez, 01-Nov-2018. Se agregan las columnas para grupos modulares ...
													demanda_inscritos,
													idioma,					
													forma_imparte,			
													fecha_inicio,				
													fecha_fin,				
													factor_horas,
													// Oscar Sánchez, 20-Jun-2019. Se agregan las columnas para grupos modulares sesionados...
													sesionado, modalidad
													) 
				SELECT	cve_mat_gpo, cve_mat, gpo, periodo, anio, 
							cond_gpo, cupo, tipo, inscritos, insc_desp_bajas, 
							cve_asimilada, gpo_asimilado, cve_profesor, prom_gpo, porc_asis, 
							ema4, primer_sem, comentarios,
							// Oscar Sánchez, 01-Nov-2018. Se agregan las columnas para grupos modulares ...
							demanda_inscritos,
							idioma,					
							forma_imparte,			
							fecha_inicio,				
							fecha_fin,				
							factor_horas,
							// Oscar Sánchez, 20-Jun-2019. Se agregan las columnas para grupos modulares sesionados...
							sesionado, modalidad
				FROM grupos WHERE anio = :li_anio AND periodo = :li_periodo
				USING gtr_sce; 

				if gtr_sce.sqlcode = 0 then li_status++  //23
			end if
			if li_status = 23 then
				DELETE FROM grupos WHERE anio = :li_anio AND periodo = :li_periodo USING gtr_sce;
				if gtr_sce.sqlcode = 0 then li_status++  //24
			end if
		else
			if li_status = 21 then li_status += 3 //24
		end if
		
		
				
		if li_status = 24 then 
			st_status.text = "Copiando histórico de cuentas_cortes. . ."
			INSERT INTO hist_cuentas_cortes
			SELECT DISTINCT cuc.cuenta, cuc.anio, cuc.periodo 
			FROM cuentas_cortes cuc, periodo per 
			WHERE cuc.periodo = per.periodo 
			AND per.tipo = :gs_tipo_periodo 
			USING gtr_sce;	 
			if gtr_sce.sqlcode = 0 then li_status++  //25
		end if
		
		if li_status = 25 then 
			st_status.text = "Eliminando las cuentas_cortes anteriores. . ."
			DELETE FROM cuentas_cortes  
			WHERE periodo IN(SELECT per.periodo FROM periodo per WHERE per.tipo = :gs_tipo_periodo)
			USING gtr_sce;
			if gtr_sce.sqlcode = 0 then li_status++ //26
		end if
			
		if li_status = 26 then 
			st_status.text = "Creando lista de cortes. . ."
			INSERT INTO cuentas_cortes
			SELECT DISTINCT mi.cuenta, :li_anio, :li_periodo 
			FROM mat_inscritas mi 
			WHERE cve_condicion IN (0,1,3) 
			AND mi.periodo IN(SELECT per.periodo FROM periodo per WHERE per.tipo = :gs_tipo_periodo) 
			USING gtr_sce;
			if gtr_sce.sqlcode = 0 then li_status++  //27
		end if
		
		if li_status = 27 then 
			st_status.text = "Creando lista de cortes de Revalidación. . ."
			INSERT INTO cuentas_cortes
			SELECT DISTINCT cuenta, :li_anio, :li_periodo 
			FROM academicos
			WHERE anio_ing = :li_anio_rev
			AND periodo_ing = :li_periodo_rev
			AND cve_formaingreso = 3
			USING gtr_sce;
			if gtr_sce.sqlcode = 0 then li_status++  //28
		end if
		
	//Respaldo de mat_inscritas en hist_mat_inscritas
		if li_status = 28 then 
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
			if gtr_sce.sqlcode = 0 then li_status++  //29
		end if

	//Respaldo de mat_inscritas en historico_complementario de Laboratorios sin créditos
		if li_status = 29 then 
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
          academicos.cve_carrera,   
          academicos.cve_plan,   
          calificacion,   
          7
			FROM mat_inscritas, academicos 
			WHERE cve_mat IN (SELECT tl.cve_lab FROM teoria_lab tl, materias m
										WHERE tl.cve_lab = m.cve_mat AND m.creditos = 0)
			AND periodo = :li_periodo
			AND anio = :li_anio
			AND mat_inscritas.cuenta = academicos.cuenta
			USING gtr_sce;			
			if gtr_sce.sqlcode = 0 then li_status++  //30
		end if
		
	//Respaldo de mat_inscritas en historico_complementario de Bajas Totales
		if li_status = 30 then 
			st_status.text = "Creando Bajas Totales. . ."
			INSERT  INTO historico_complementario(mat_inscritas.cuenta,   
          cve_mat,    
          gpo,   
          periodo,   
          anio,   
          academicos.cve_carrera,   
          academicos.cve_plan,   
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
			FROM mat_inscritas, academicos 
			WHERE cve_condicion = 2 
			AND periodo = :li_periodo
			AND anio = :li_anio
			AND mat_inscritas.cuenta = academicos.cuenta
			USING gtr_sce;			
			if gtr_sce.sqlcode = 0 then li_status++  //31
		end if
		
		if li_status = 31 then 
			st_status.text = "Eliminando laboratorios. . ."
			DELETE FROM mat_inscritas 
			WHERE cve_mat IN (SELECT tl.cve_lab 
										FROM teoria_lab tl, materias m
										WHERE tl.cve_lab = m.cve_mat 
										AND m.tipo_periodo = :gs_tipo_periodo
										AND m.creditos = 0) 
			USING gtr_sce;
			if gtr_sce.sqlcode = 0 then li_status++  //32
		end if
		
		if li_status = 32 then 
			st_status.text = "Eliminando Bajas Totales. . ."
			DELETE FROM mat_inscritas 
			WHERE cve_condicion = 2 
			AND cve_mat IN(SELECT cve_mat FROM materias WHERE tipo_periodo = :gs_tipo_periodo) 
			USING gtr_sce;
			if gtr_sce.sqlcode = 0 then li_status++  //33
		end if
		
		if li_status = 33 then 
			st_status.text = "Respaldando Bajas Finanzas. . ."
			INSERT INTO historico_baja_finanzas 
			SELECT mi.cuenta,mi.cve_mat,mi.gpo,mi.periodo,mi.anio,a.cve_carrera,a.cve_plan,mi.calificacion,3
			FROM mat_inscritas mi, academicos a
			WHERE mi.cuenta = a.cuenta 
			AND mi.cve_condicion = 3 
			AND  mi.cve_mat IN(SELECT cve_mat FROM materias WHERE tipo_periodo = :gs_tipo_periodo)
			USING gtr_sce;
			if gtr_sce.sqlcode = 0 then li_status++  //34
		end if
		
		if li_status = 34 then 
			st_status.text = "Eliminado Bajas Finanzas. . ."
			DELETE FROM mat_inscritas 
			WHERE cve_condicion = 3 
			AND cve_mat IN(SELECT cve_mat FROM materias WHERE tipo_periodo = :gs_tipo_periodo)
			USING gtr_sce;
			if gtr_sce.sqlcode = 0 then li_status++  //35
		end if
		
		if li_status = 35 then
			COMMIT using gtr_sce;
			st_status.text = "Pasando materias a historico. . ."
			ll_mat = lds_mat_inscritas.Retrieve(gs_tipo_periodo) 
			if ll_mat > 0 then
				for ll_i = 1 to ll_mat
					lds_historico_porcuentaanioper.InsertRow(ll_i)
					lds_historico_porcuentaanioper.SetItem(ll_i,"cuenta",lds_mat_inscritas.GetItemNumber(1,"cuenta"))
					lds_historico_porcuentaanioper.SetItem(ll_i,"cve_mat",lds_mat_inscritas.GetItemNumber(1,"cve_mat"))
					lds_historico_porcuentaanioper.SetItem(ll_i,"gpo",lds_mat_inscritas.GetItemString(1,"gpo"))
					lds_historico_porcuentaanioper.SetItem(ll_i,"periodo",lds_mat_inscritas.GetItemNumber(1,"periodo"))
					lds_historico_porcuentaanioper.SetItem(ll_i,"anio",lds_mat_inscritas.GetItemNumber(1,"anio"))
					lds_historico_porcuentaanioper.SetItem(ll_i,"cve_carrera",lds_mat_inscritas.GetItemNumber(1,"cve_carrera"))
					lds_historico_porcuentaanioper.SetItem(ll_i,"cve_plan",lds_mat_inscritas.GetItemNumber(1,"cve_plan"))
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
			
			DELETE FROM actas_evaluacion 
			WHERE cve_mat IN(SELECT cve_mat FROM materias WHERE tipo_periodo = :gs_tipo_periodo) 
			USING gtr_sce;
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

type cb_poner5na from commandbutton within w_mat_inscritas_to_historico
boolean visible = false
integer x = 110
integer y = 300
integer width = 1362
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

