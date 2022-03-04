$PBExportHeader$w_revision_estudios_masiva_insc_2014.srw
forward
global type w_revision_estudios_masiva_insc_2014 from w_master_main
end type
type uo_nombre from uo_carreras_alumno_lista within w_revision_estudios_masiva_insc_2014
end type
type cb_5 from commandbutton within w_revision_estudios_masiva_insc_2014
end type
type cb_4 from commandbutton within w_revision_estudios_masiva_insc_2014
end type
type cb_3 from commandbutton within w_revision_estudios_masiva_insc_2014
end type
type cb_total from commandbutton within w_revision_estudios_masiva_insc_2014
end type
type cb_genera_esquema from commandbutton within w_revision_estudios_masiva_insc_2014
end type
type sle_registros_procesados from singlelineedit within w_revision_estudios_masiva_insc_2014
end type
type st_1 from statictext within w_revision_estudios_masiva_insc_2014
end type
type st_final from statictext within w_revision_estudios_masiva_insc_2014
end type
type st_2 from statictext within w_revision_estudios_masiva_insc_2014
end type
type sle_final from singlelineedit within w_revision_estudios_masiva_insc_2014
end type
type sle_inicial from singlelineedit within w_revision_estudios_masiva_insc_2014
end type
type cb_no_egresados from commandbutton within w_revision_estudios_masiva_insc_2014
end type
type cb_2 from commandbutton within w_revision_estudios_masiva_insc_2014
end type
type gb_1 from groupbox within w_revision_estudios_masiva_insc_2014
end type
end forward

global type w_revision_estudios_masiva_insc_2014 from w_master_main
integer width = 3369
integer height = 2140
uo_nombre uo_nombre
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_total cb_total
cb_genera_esquema cb_genera_esquema
sle_registros_procesados sle_registros_procesados
st_1 st_1
st_final st_final
st_2 st_2
sle_final sle_final
sle_inicial sle_inicial
cb_no_egresados cb_no_egresados
cb_2 cb_2
gb_1 gb_1
end type
global w_revision_estudios_masiva_insc_2014 w_revision_estudios_masiva_insc_2014

type variables
long il_cuenta,il_carrera,il_plan
u_datastore ids_tramites_inscritos , ids_no_egresados, ids_total, ids_incremental, ids_cuentas_revision_estudios_ctas_cort, ids_cuentas_revision_estudios_prueba
end variables

event open;call super::open;ids_tramites_inscritos = CREATE u_datastore
ids_tramites_inscritos.dataobject = "d_cuentas_revision_estudios_total"
ids_tramites_inscritos.SetTransObject(gtr_sce)


ids_total = CREATE u_datastore
ids_total.dataobject = "d_cuentas_revision_estudios_total"
ids_total.SetTransObject(gtr_sce)


ids_incremental = CREATE u_datastore
ids_incremental.dataobject = "d_cuentas_revision_estudios_increm"
ids_incremental.SetTransObject(gtr_sce)


ids_no_egresados= CREATE u_datastore
ids_no_egresados.dataobject = "d_cuentas_revision_estudios_no_egre"
ids_no_egresados.SetTransObject(gtr_sce)
 

ids_cuentas_revision_estudios_ctas_cort = CREATE u_datastore
ids_cuentas_revision_estudios_ctas_cort.dataobject = "d_cuentas_revision_estudios_ctas_cort"
ids_cuentas_revision_estudios_ctas_cort.SetTransObject(gtr_sce)

ids_cuentas_revision_estudios_prueba = CREATE u_datastore
ids_cuentas_revision_estudios_prueba.dataobject = "d_cuentas_revision_estudios_prueba"
ids_cuentas_revision_estudios_prueba.SetTransObject(gtr_sce)
end event

event doubleclicked;call super::doubleclicked;string ls_nivel
int li_vigente

il_cuenta = long(uo_nombre.of_obten_cuenta())
il_carrera = uo_nombre.istr_carrera.str_cve_carrera
il_plan = uo_nombre.istr_carrera.str_cve_plan
ls_nivel = uo_nombre.istr_carrera.str_nivel
li_vigente = uo_nombre.istr_carrera.str_vigente

if li_vigente = 0 then
	messagebox('Aviso','La carrera del alumno tiene que ser la vigente')
	return
end if
end event

on w_revision_estudios_masiva_insc_2014.create
int iCurrent
call super::create
this.uo_nombre=create uo_nombre
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_total=create cb_total
this.cb_genera_esquema=create cb_genera_esquema
this.sle_registros_procesados=create sle_registros_procesados
this.st_1=create st_1
this.st_final=create st_final
this.st_2=create st_2
this.sle_final=create sle_final
this.sle_inicial=create sle_inicial
this.cb_no_egresados=create cb_no_egresados
this.cb_2=create cb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_nombre
this.Control[iCurrent+2]=this.cb_5
this.Control[iCurrent+3]=this.cb_4
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.cb_total
this.Control[iCurrent+6]=this.cb_genera_esquema
this.Control[iCurrent+7]=this.sle_registros_procesados
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.st_final
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.sle_final
this.Control[iCurrent+12]=this.sle_inicial
this.Control[iCurrent+13]=this.cb_no_egresados
this.Control[iCurrent+14]=this.cb_2
this.Control[iCurrent+15]=this.gb_1
end on

on w_revision_estudios_masiva_insc_2014.destroy
call super::destroy
destroy(this.uo_nombre)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_total)
destroy(this.cb_genera_esquema)
destroy(this.sle_registros_procesados)
destroy(this.st_1)
destroy(this.st_final)
destroy(this.st_2)
destroy(this.sle_final)
destroy(this.sle_inicial)
destroy(this.cb_no_egresados)
destroy(this.cb_2)
destroy(this.gb_1)
end on

event close;call super::close;if isvalid(ids_tramites_inscritos) then
	DESTROY ids_tramites_inscritos
end if
end event

event closequery;//
end event

type st_sistema from w_master_main`st_sistema within w_revision_estudios_masiva_insc_2014
end type

type p_ibero from w_master_main`p_ibero within w_revision_estudios_masiva_insc_2014
end type

type uo_nombre from uo_carreras_alumno_lista within w_revision_estudios_masiva_insc_2014
integer x = 14
integer y = 324
integer taborder = 40
boolean bringtotop = true
end type

on uo_nombre.destroy
call uo_carreras_alumno_lista::destroy
end on

type cb_5 from commandbutton within w_revision_estudios_masiva_insc_2014
integer x = 1230
integer y = 1188
integer width = 658
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Revisa Prueba"
end type

event clicked;uo_revision_de_estudios luo_revision_de_estudios
int li_confirma, li_res, li_confirma2, li_confirma3
long ll_row, ll_rows_totales, ll_cuenta, ll_cve_carrera, ll_cve_plan, ll_cve_subsistema, ll_max_cuenta
string ls_nivel
integer li_revision
//li_confirma = MessageBox("Confirmación","¿Desea Actualizar la información del Esquema?",Question!,YesNo!)
li_confirma = MessageBox("Confirmación","¿Desea Actualizar la información del Esquema Incremental?",Question!,YesNo!)
if li_confirma=1 then
	luo_revision_de_estudios = CREATE uo_revision_de_estudios 
	
		MessageBox("Actualizacion","Se han guardado los cambios",Information!)
		SELECT MAX(cuenta) 
		INTO :ll_max_cuenta
		FROM  prueba2 
		USING gtr_sce;

		ll_rows_totales = ids_cuentas_revision_estudios_prueba.Retrieve()
		li_confirma2= MessageBox("Confirmación","¿Desea Efectuar la Revisión de Estudios los alumnos en Pruebas["&
		                         +string(ll_rows_totales)+"]?",Question!,YesNo!)
		
		IF gtr_sce.sqlcode = 0 then
			commit using gtr_sce;
		end if		
		if li_confirma2 =1 then
			sle_inicial.text = string(Now())
			SetPointer (HourGlass!)
			IF ll_rows_totales<> -1 THEN
				FOR ll_row = 1 to ll_rows_totales
					ll_cuenta = ids_cuentas_revision_estudios_prueba.GetItemNumber(ll_row,"cuenta")
					ll_cve_carrera = ids_cuentas_revision_estudios_prueba.GetItemNumber(ll_row,"cve_carrera")
					ll_cve_plan = ids_cuentas_revision_estudios_prueba.GetItemNumber(ll_row,"cve_plan")
					ll_cve_subsistema = ids_cuentas_revision_estudios_prueba.GetItemNumber(ll_row,"cve_subsistema")
					ls_nivel = ids_cuentas_revision_estudios_prueba.GetItemString(ll_row,"nivel")					
					li_revision = luo_revision_de_estudios.of_revision_estudios(ll_cuenta, ll_cve_carrera, ll_cve_plan)					
					INSERT INTO prueba2 
					VALUES (:ll_cuenta)
					USING gtr_sce;
					IF gtr_sce.sqlcode = 0 then
						commit using gtr_sce;
					end if
					
					if Mod(ll_row,50)= 0 then
						sle_registros_procesados.text = string(ll_row)+"/"+ string(ll_rows_totales)+" cuenta:["+string(ll_cuenta)+"]"
//						li_confirma3= MessageBox("Confirmación","¿Desea Continuar?",Question!,YesNo!)
//						if li_confirma3<>1 then
//							return 
//						end if
					end if
					if li_revision= -1 then
						MessageBox("Error","No se pudo efectuar la Revision de Estudios",Information!)
						ll_row= ll_rows_totales +1
					end if
				NEXT
			ELSE
				MessageBox("Error","No se pudo obtener a los Alumnos Inscritos",Information!)
			END IF
			SetPointer (Arrow!)
			sle_final.text = string(Now())
			sle_registros_procesados.text = string(ll_row)+"/"+ string(ll_rows_totales)+" cuenta:["+string(ll_cuenta)+"]"
		else 
			MessageBox("Error","No se efectuó la Revision de Estudios de los alumnos Inscritos",Information!)
		end if
	
	if isvalid(	luo_revision_de_estudios) then
		DESTROY luo_revision_de_estudios
	end if
end if
end event

type cb_4 from commandbutton within w_revision_estudios_masiva_insc_2014
integer x = 1230
integer y = 1040
integer width = 658
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Revisa Cuentas Cortes"
end type

event clicked;uo_revision_de_estudios luo_revision_de_estudios
int li_confirma, li_res, li_confirma2, li_confirma3
long ll_row, ll_rows_totales, ll_cuenta, ll_cve_carrera, ll_cve_plan, ll_cve_subsistema, ll_max_cuenta
string ls_nivel
integer li_revision
//li_confirma = MessageBox("Confirmación","¿Desea Actualizar la información del Esquema?",Question!,YesNo!)
li_confirma = MessageBox("Confirmación","¿Desea Actualizar la información del Esquema Incremental?",Question!,YesNo!)
if li_confirma=1 then
	luo_revision_de_estudios = CREATE uo_revision_de_estudios 
	
		MessageBox("Actualizacion","Se han guardado los cambios",Information!)
		SELECT MAX(cuenta) 
		INTO :ll_max_cuenta
		FROM  prueba2 
		USING gtr_sce;

		ll_rows_totales = ids_cuentas_revision_estudios_ctas_cort.Retrieve(ll_max_cuenta)
		li_confirma2= MessageBox("Confirmación","¿Desea Efectuar la Revisión de Estudios de TODOS los alumnos["&
		                         +string(ll_rows_totales)+"]?",Question!,YesNo!)
		
		IF gtr_sce.sqlcode = 0 then
			commit using gtr_sce;
		end if		
		if li_confirma2 =1 then
			sle_inicial.text = string(Now())
			SetPointer (HourGlass!)
			IF ll_rows_totales<> -1 THEN
				FOR ll_row = 1 to ll_rows_totales
					ll_cuenta = ids_cuentas_revision_estudios_ctas_cort.GetItemNumber(ll_row,"cuenta")
					ll_cve_carrera = ids_cuentas_revision_estudios_ctas_cort.GetItemNumber(ll_row,"cve_carrera")
					ll_cve_plan = ids_cuentas_revision_estudios_ctas_cort.GetItemNumber(ll_row,"cve_plan")
					ll_cve_subsistema = ids_cuentas_revision_estudios_ctas_cort.GetItemNumber(ll_row,"cve_subsistema")
					ls_nivel = ids_cuentas_revision_estudios_ctas_cort.GetItemString(ll_row,"nivel")					
					li_revision = luo_revision_de_estudios.of_revision_estudios(ll_cuenta, ll_cve_carrera, ll_cve_plan)					
					INSERT INTO prueba2 
					VALUES (:ll_cuenta)
					USING gtr_sce;
					IF gtr_sce.sqlcode = 0 then
						commit using gtr_sce;
					end if
					
					if Mod(ll_row,50)= 0 then
						sle_registros_procesados.text = string(ll_row)+"/"+ string(ll_rows_totales)+" cuenta:["+string(ll_cuenta)+"]"
//						li_confirma3= MessageBox("Confirmación","¿Desea Continuar?",Question!,YesNo!)
//						if li_confirma3<>1 then
//							return 
//						end if
					end if
					if li_revision= -1 then
						MessageBox("Error","No se pudo efectuar la Revision de Estudios",Information!)
						ll_row= ll_rows_totales +1
					end if
				NEXT
			ELSE
				MessageBox("Error","No se pudo obtener a los Alumnos Inscritos",Information!)
			END IF
			SetPointer (Arrow!)
			sle_final.text = string(Now())
			sle_registros_procesados.text = string(ll_row)+"/"+ string(ll_rows_totales)+" cuenta:["+string(ll_cuenta)+"]"
		else 
			MessageBox("Error","No se efectuó la Revision de Estudios de los alumnos Inscritos",Information!)
		end if
	
	if isvalid(	luo_revision_de_estudios) then
		DESTROY luo_revision_de_estudios
	end if
end if
end event

type cb_3 from commandbutton within w_revision_estudios_masiva_insc_2014
integer x = 1253
integer y = 892
integer width = 613
integer height = 108
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Revisa Incremental"
end type

event clicked;uo_revision_de_estudios luo_revision_de_estudios
int li_confirma, li_res, li_confirma2, li_confirma3
long ll_row, ll_rows_totales, ll_cuenta, ll_cve_carrera, ll_cve_plan, ll_cve_subsistema, ll_max_cuenta
string ls_nivel
integer li_revision
//li_confirma = MessageBox("Confirmación","¿Desea Actualizar la información del Esquema?",Question!,YesNo!)
li_confirma = MessageBox("Confirmación","¿Desea Actualizar la información del Esquema Incremental?",Question!,YesNo!)
if li_confirma=1 then
	luo_revision_de_estudios = CREATE uo_revision_de_estudios 
	
		MessageBox("Actualizacion","Se han guardado los cambios",Information!)
		SELECT MAX(cuenta) 
		INTO :ll_max_cuenta
		FROM  prueba2 
		USING gtr_sce;
		if isnull(ll_max_cuenta) then ll_max_cuenta = 0
		
		ll_rows_totales = ids_incremental.Retrieve(ll_max_cuenta)
		li_confirma2= MessageBox("Confirmación","¿Desea Efectuar la Revisión de Estudios de TODOS los alumnos["&
		                         +string(ll_rows_totales)+"]?",Question!,YesNo!)
		
		IF gtr_sce.sqlcode = 0 then
			commit using gtr_sce;
		end if		
		if li_confirma2 =1 then
			sle_inicial.text = string(Now())
			SetPointer (HourGlass!)
			IF ll_rows_totales<> -1 THEN
				FOR ll_row = 1 to ll_rows_totales
					ll_cuenta = ids_incremental.GetItemNumber(ll_row,"cuenta")
					ll_cve_carrera = ids_incremental.GetItemNumber(ll_row,"cve_carrera")
					ll_cve_plan = ids_incremental.GetItemNumber(ll_row,"cve_plan")
					ll_cve_subsistema = ids_incremental.GetItemNumber(ll_row,"cve_subsistema")
					ls_nivel = ids_incremental.GetItemString(ll_row,"nivel")					
					li_revision = luo_revision_de_estudios.of_revision_estudios(ll_cuenta, ll_cve_carrera, ll_cve_plan)					
					INSERT INTO prueba2 
					VALUES (:ll_cuenta)
					USING gtr_sce;
					IF gtr_sce.sqlcode = 0 then
						commit using gtr_sce;
					end if
					
					if Mod(ll_row,50)= 0 then
						sle_registros_procesados.text = string(ll_row)+"/"+ string(ll_rows_totales)+" cuenta:["+string(ll_cuenta)+"]"
//						li_confirma3= MessageBox("Confirmación","¿Desea Continuar?",Question!,YesNo!)
//						if li_confirma3<>1 then
//							return 
//						end if
					end if
					if li_revision= -1 then
						MessageBox("Error","No se pudo efectuar la Revision de Estudios",Information!)
						ll_row= ll_rows_totales +1
					end if
				NEXT
			ELSE
				MessageBox("Error","No se pudo obtener a los Alumnos Inscritos",Information!)
			END IF
			SetPointer (Arrow!)
			sle_final.text = string(Now())
			sle_registros_procesados.text = string(ll_row)+"/"+ string(ll_rows_totales)+" cuenta:["+string(ll_cuenta)+"]"
		else 
			MessageBox("Error","No se efectuó la Revision de Estudios de los alumnos Inscritos",Information!)
		end if
	
	if isvalid(	luo_revision_de_estudios) then
		DESTROY luo_revision_de_estudios
	end if
end if
end event

type cb_total from commandbutton within w_revision_estudios_masiva_insc_2014
integer x = 114
integer y = 1200
integer width = 613
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Revisa Total"
end type

event clicked;uo_revision_de_estudios luo_revision_de_estudios
int li_confirma, li_res, li_confirma2
long ll_row, ll_rows_totales, ll_cuenta, ll_cve_carrera, ll_cve_plan, ll_cve_subsistema
string ls_nivel
integer li_revision
li_confirma = MessageBox("Confirmación","¿Desea Actualizar la información del Esquema?",Question!,YesNo!)
if li_confirma=1 then
	luo_revision_de_estudios = CREATE uo_revision_de_estudios 
	li_res = luo_revision_de_estudios.of_actualiza_datos_tramites_i()
	if li_res = -1 then
		MessageBox("Error","No se han guardado los cambios",StopSign!)
	else
		MessageBox("Actualizacion","Se han guardado los cambios",Information!)
		ll_rows_totales = ids_total.Retrieve()
		li_confirma2= MessageBox("Confirmación","¿Desea Efectuar la Revisión de Estudios de TODOS los alumnos["&
		                         +string(ll_rows_totales)+"]?",Question!,YesNo!)
		DELETE FROM  prueba2 
		USING gtr_sce;
		IF gtr_sce.sqlcode = 0 then
			commit using gtr_sce;
		end if		
		if li_confirma2 =1 then
			sle_inicial.text = string(Now())
			SetPointer (HourGlass!)
			IF ll_rows_totales<> -1 THEN
				FOR ll_row = 1 to ll_rows_totales
					ll_cuenta = ids_total.GetItemNumber(ll_row,"cuenta")
					ll_cve_carrera = ids_total.GetItemNumber(ll_row,"cve_carrera")
					ll_cve_plan = ids_total.GetItemNumber(ll_row,"cve_plan")
					ll_cve_subsistema = ids_total.GetItemNumber(ll_row,"cve_subsistema")
					ls_nivel = ids_total.GetItemString(ll_row,"nivel")					
					li_revision = luo_revision_de_estudios.of_revision_estudios(ll_cuenta, ll_cve_carrera, ll_cve_plan)					
					INSERT INTO prueba2 
					VALUES (:ll_cuenta)
					USING gtr_sce;
					IF gtr_sce.sqlcode = 0 then
						commit using gtr_sce;
					end if
					
					if Mod(ll_row,50)= 0 then
						sle_registros_procesados.text = string(ll_row)+"/"+ string(ll_rows_totales)
					end if
					if li_revision= -1 then
						MessageBox("Error","No se pudo efectuar la Revision de Estudios",Information!)
						ll_row= ll_rows_totales +1
					end if
				NEXT
			ELSE
				MessageBox("Error","No se pudo obtener a los Alumnos Inscritos",Information!)
			END IF
			SetPointer (Arrow!)
			sle_final.text = string(Now())
			sle_registros_procesados.text = string(ll_row)+"/"+ string(ll_rows_totales)
		else 
			MessageBox("Error","No se efectuó la Revision de Estudios de los alumnos Inscritos",Information!)
		end if
	end if
	if isvalid(	luo_revision_de_estudios) then
		DESTROY luo_revision_de_estudios
	end if
end if
end event

type cb_genera_esquema from commandbutton within w_revision_estudios_masiva_insc_2014
integer x = 165
integer y = 1044
integer width = 517
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Genera Esquema"
end type

event clicked;uo_revision_de_estudios luo_revision_de_estudios
int li_confirma, li_res, li_confirma2
long ll_row, ll_rows_totales, ll_cuenta, ll_cve_carrera, ll_cve_plan, ll_cve_subsistema
string ls_nivel
integer li_revision
li_confirma = MessageBox("Confirmación","¿Desea Generar el Esquema de TODOS Alumnos?",Question!,YesNo!)
if li_confirma=1 then
	SetPointer (HourGlass!)
	luo_revision_de_estudios = CREATE uo_revision_de_estudios 
	li_res = luo_revision_de_estudios.of_inserta_carreras()
	if li_res = -1 then
		MessageBox("Error","No se han guardado los cambios",StopSign!)
	else
		MessageBox("Actualizacion","Se han guardado los cambios",Information!)
		SetPointer (Arrow!)
	end if
	if isvalid(	luo_revision_de_estudios) then
		DESTROY luo_revision_de_estudios
	end if
end if
end event

type sle_registros_procesados from singlelineedit within w_revision_estudios_masiva_insc_2014
integer x = 1426
integer y = 1428
integer width = 1531
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_revision_estudios_masiva_insc_2014
integer x = 869
integer y = 1444
integer width = 503
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Regs. Procesados"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_final from statictext within w_revision_estudios_masiva_insc_2014
integer x = 1033
integer y = 1708
integer width = 338
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Hora Final"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_revision_estudios_masiva_insc_2014
integer x = 1033
integer y = 1576
integer width = 338
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Hora Inicial"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_final from singlelineedit within w_revision_estudios_masiva_insc_2014
integer x = 1426
integer y = 1692
integer width = 402
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_inicial from singlelineedit within w_revision_estudios_masiva_insc_2014
integer x = 1426
integer y = 1560
integer width = 402
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_no_egresados from commandbutton within w_revision_estudios_masiva_insc_2014
integer x = 114
integer y = 1336
integer width = 613
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Revisa no Egresados"
end type

event clicked;uo_revision_de_estudios luo_revision_de_estudios
int li_confirma, li_res, li_confirma2
long ll_row, ll_rows_totales, ll_cuenta, ll_cve_carrera, ll_cve_plan, ll_cve_subsistema
string ls_nivel
integer li_revision
li_confirma = MessageBox("Confirmación","¿Desea Actualizar la información del Esquema?",Question!,YesNo!)
if li_confirma=1 then
	luo_revision_de_estudios = CREATE uo_revision_de_estudios 
	li_res = luo_revision_de_estudios.of_actualiza_datos_tramites_i()
	if li_res = -1 then
		MessageBox("Error","No se han guardado los cambios",StopSign!)
	else
		MessageBox("Actualizacion","Se han guardado los cambios",Information!)
		ll_rows_totales = ids_no_egresados.Retrieve()
		li_confirma2= MessageBox("Confirmación","¿Desea Efectuar la Revisión de Estudios de TODOS los alumnos NO Egresados["&
		                         +string(ll_rows_totales)+"]?",Question!,YesNo!)
		DELETE FROM  prueba2 
		USING gtr_sce;
		IF gtr_sce.sqlcode = 0 then
			commit using gtr_sce;
		end if		
		if li_confirma2=1 then
			sle_inicial.text = string(Now())
			SetPointer (HourGlass!)
			IF ll_rows_totales<> -1 THEN
				FOR ll_row = 1 to ll_rows_totales
					ll_cuenta = ids_no_egresados.GetItemNumber(ll_row,"cuenta")
					ll_cve_carrera = ids_no_egresados.GetItemNumber(ll_row,"cve_carrera")
					ll_cve_plan = ids_no_egresados.GetItemNumber(ll_row,"cve_plan")
					ll_cve_subsistema = ids_no_egresados.GetItemNumber(ll_row,"cve_subsistema")
					ls_nivel = ids_no_egresados.GetItemString(ll_row,"nivel")					
					li_revision = luo_revision_de_estudios.of_revision_estudios(ll_cuenta, ll_cve_carrera, ll_cve_plan)					
					INSERT INTO prueba2 
					VALUES (:ll_cuenta)
					USING gtr_sce;
					IF gtr_sce.sqlcode = 0 then
						commit using gtr_sce;
					end if
					
					if Mod(ll_row,50)= 0 then
						sle_registros_procesados.text = string(ll_row)+"/"+ string(ll_rows_totales)
					end if
					if li_revision= -1 then
						MessageBox("Error","No se pudo efectuar la Revision de Estudios",Information!)
						ll_row= ll_rows_totales +1
					end if
				NEXT
			ELSE
				MessageBox("Error","No se pudo obtener a los Alumnos Inscritos",Information!)
			END IF
			SetPointer (Arrow!)
			sle_final.text = string(Now())
			sle_registros_procesados.text = string(ll_row)+"/"+ string(ll_rows_totales)
		else 
			MessageBox("Error","No se efectuó la Revision de Estudios de los alumnos Inscritos",Information!)
		end if
	end if
	if isvalid(	luo_revision_de_estudios) then
		DESTROY luo_revision_de_estudios
	end if
end if
end event

type cb_2 from commandbutton within w_revision_estudios_masiva_insc_2014
integer x = 215
integer y = 1504
integer width = 411
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Elegido"
end type

event clicked;uo_revision_de_estudios luo_revision_de_estudios
int li_confirma, li_res
long ll_cuenta, ll_cve_carrera, ll_cve_plan

li_confirma = MessageBox("Confirmación","¿Desea Actualizar con cuenta["+string(il_cuenta)+"]~n"+&
											" cve_carrera["+string(il_carrera)+"]~n"+&
											" cve_plan["+string(il_plan)+"]~n"+&
											" ?",Question!,YesNo!)
if li_confirma=1 then
	luo_revision_de_estudios = CREATE uo_revision_de_estudios 
//	li_res = luo_revision_de_estudios.of_actualiza_datos_tramites(ll_cuenta, ll_cve_carrera, ll_cve_plan)
	li_res = luo_revision_de_estudios.of_revision_estudios(il_cuenta, il_carrera, il_plan)
	if li_res = -1 then
		MessageBox("Error","No se han guardado los cambios",StopSign!)
	else
		MessageBox("Actualizacion","Se han guardado los cambios",StopSign!)
	end if
	if isvalid(	luo_revision_de_estudios) then
		DESTROY luo_revision_de_estudios
	end if
end if
end event

type gb_1 from groupbox within w_revision_estudios_masiva_insc_2014
integer x = 832
integer y = 1312
integer width = 2130
integer height = 520
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Monitoreo de Ejecución"
end type

