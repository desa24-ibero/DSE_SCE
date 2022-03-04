$PBExportHeader$w_prueba_opc_cero.srw
forward
global type w_prueba_opc_cero from window
end type
type sle_registros_procesados from singlelineedit within w_prueba_opc_cero
end type
type st_2 from statictext within w_prueba_opc_cero
end type
type st_final from statictext within w_prueba_opc_cero
end type
type st_1 from statictext within w_prueba_opc_cero
end type
type sle_final from singlelineedit within w_prueba_opc_cero
end type
type sle_inicial from singlelineedit within w_prueba_opc_cero
end type
type cb_inscritos from commandbutton within w_prueba_opc_cero
end type
type cb_2 from commandbutton within w_prueba_opc_cero
end type
type cb_1 from commandbutton within w_prueba_opc_cero
end type
type uo_1 from uo_datos_opc_cero within w_prueba_opc_cero
end type
type gb_1 from groupbox within w_prueba_opc_cero
end type
end forward

global type w_prueba_opc_cero from window
integer width = 3301
integer height = 1508
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
sle_registros_procesados sle_registros_procesados
st_2 st_2
st_final st_final
st_1 st_1
sle_final sle_final
sle_inicial sle_inicial
cb_inscritos cb_inscritos
cb_2 cb_2
cb_1 cb_1
uo_1 uo_1
gb_1 gb_1
end type
global w_prueba_opc_cero w_prueba_opc_cero

type variables
u_datastore ids_tramites_inscritos 
end variables

on w_prueba_opc_cero.create
this.sle_registros_procesados=create sle_registros_procesados
this.st_2=create st_2
this.st_final=create st_final
this.st_1=create st_1
this.sle_final=create sle_final
this.sle_inicial=create sle_inicial
this.cb_inscritos=create cb_inscritos
this.cb_2=create cb_2
this.cb_1=create cb_1
this.uo_1=create uo_1
this.gb_1=create gb_1
this.Control[]={this.sle_registros_procesados,&
this.st_2,&
this.st_final,&
this.st_1,&
this.sle_final,&
this.sle_inicial,&
this.cb_inscritos,&
this.cb_2,&
this.cb_1,&
this.uo_1,&
this.gb_1}
end on

on w_prueba_opc_cero.destroy
destroy(this.sle_registros_procesados)
destroy(this.st_2)
destroy(this.st_final)
destroy(this.st_1)
destroy(this.sle_final)
destroy(this.sle_inicial)
destroy(this.cb_inscritos)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.uo_1)
destroy(this.gb_1)
end on

event open;ids_tramites_inscritos = CREATE u_datastore
ids_tramites_inscritos.dataobject = "d_cuentas_tramite_titulac_inscritos"
ids_tramites_inscritos.SetTransObject(gtr_sce)


end event

event close;if isvalid(ids_tramites_inscritos) then
	DESTROY ids_tramites_inscritos
end if
end event

type sle_registros_procesados from singlelineedit within w_prueba_opc_cero
integer x = 1495
integer y = 984
integer width = 402
integer height = 96
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_prueba_opc_cero
integer x = 937
integer y = 1000
integer width = 503
integer height = 64
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

type st_final from statictext within w_prueba_opc_cero
integer x = 1102
integer y = 1264
integer width = 338
integer height = 64
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

type st_1 from statictext within w_prueba_opc_cero
integer x = 1102
integer y = 1132
integer width = 338
integer height = 64
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

type sle_final from singlelineedit within w_prueba_opc_cero
integer x = 1495
integer y = 1248
integer width = 402
integer height = 96
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_inicial from singlelineedit within w_prueba_opc_cero
integer x = 1495
integer y = 1116
integer width = 402
integer height = 96
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_inscritos from commandbutton within w_prueba_opc_cero
integer x = 1125
integer y = 608
integer width = 411
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inscritos"
end type

event clicked;uo_atencion_opc_cero luo_atencion_opc_cero
int li_confirma, li_res, li_confirma2
long ll_row, ll_rows_totales, ll_cuenta, ll_cve_carrera, ll_cve_plan, ll_cve_subsistema
string ls_nivel
integer li_revision
li_confirma = MessageBox("Confirmación","¿Desea Actualizar la información?",Question!,YesNo!)
if li_confirma=1 then
	luo_atencion_opc_cero = CREATE uo_atencion_opc_cero 
	li_res = luo_atencion_opc_cero.of_actualiza_datos_tramites_i()
	if li_res = -1 then
		MessageBox("Error","No se han guardado los cambios",StopSign!)
	else
		MessageBox("Actualizacion","Se han guardado los cambios",Information!)
		li_confirma2= MessageBox("Confirmación","¿Desea Efectuar la Revisión de Estudios de TODOS los alumnos Inscritos?",Question!,YesNo!)
		if li_confirma=1 then
			sle_inicial.text = string(Now())
			SetPointer (HourGlass!)
			ll_rows_totales = ids_tramites_inscritos.Retrieve()
			IF ll_rows_totales<> -1 THEN
				FOR ll_row = 1 to ll_rows_totales
					ll_cuenta = ids_tramites_inscritos.GetItemNumber(ll_row,"cuenta")
					ll_cve_carrera = ids_tramites_inscritos.GetItemNumber(ll_row,"cve_carrera")
					ll_cve_plan = ids_tramites_inscritos.GetItemNumber(ll_row,"cve_plan")
					ll_cve_subsistema = ids_tramites_inscritos.GetItemNumber(ll_row,"cve_subsistema")
					ls_nivel = ids_tramites_inscritos.GetItemString(ll_row,"nivel")					
					li_revision = luo_atencion_opc_cero.of_revision_estudios(ll_cuenta, ll_cve_carrera, ll_cve_plan)					
					if Mod(ll_row,50)= 0 then
						sle_registros_procesados.text = string(ll_row)+"/"+ string(ll_rows_totales)
					end if
					if li_revision= -1 then
						MessageBox("Error","No se pudo efectuar la Revision de Estudios",Information!)
						ll_row= ll_rows_totales +1
					end if
				NEXT
			ELSE
				MessageBox("Error","No se pudo obtener a loa Alumnos Inscritos",Information!)
			END IF
			SetPointer (Arrow!)
			sle_final.text = string(Now())
			sle_registros_procesados.text = string(ll_row)+"/"+ string(ll_rows_totales)
		else 
			MessageBox("Error","No se efectuó la Revision de Estudios de los alumnos Inscritos",Information!)
		end if
	end if
	if isvalid(	luo_atencion_opc_cero) then
		DESTROY luo_atencion_opc_cero
	end if
end if
end event

type cb_2 from commandbutton within w_prueba_opc_cero
integer x = 1737
integer y = 608
integer width = 411
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Elegido"
end type

event clicked;uo_atencion_opc_cero luo_atencion_opc_cero
int li_confirma, li_res
long ll_cuenta, ll_cve_carrera, ll_cve_plan

ll_cuenta = uo_1.of_obten_cuenta()
ll_cve_carrera = uo_1.of_obten_cve_carrera()
ll_cve_plan = uo_1.of_obten_cve_plan(ll_cuenta)

li_confirma = MessageBox("Confirmación","¿Desea Actualizar con cuenta["+string(ll_cuenta)+"]~n"+&
											" cve_carrera["+string(ll_cve_carrera)+"]~n"+&
											" cve_plan["+string(ll_cve_plan)+"]~n"+&
											" ?",Question!,YesNo!)
if li_confirma=1 then
	luo_atencion_opc_cero = CREATE uo_atencion_opc_cero 
	li_res = luo_atencion_opc_cero.of_actualiza_datos_tramites(ll_cuenta, ll_cve_carrera, ll_cve_plan)
	if li_res = -1 then
		MessageBox("Error","No se han guardado los cambios",StopSign!)
	else
		MessageBox("Actualizacion","Se han guardado los cambios",StopSign!)
	end if
	if isvalid(	luo_atencion_opc_cero) then
		DESTROY luo_atencion_opc_cero
	end if
end if
end event

type cb_1 from commandbutton within w_prueba_opc_cero
boolean visible = false
integer x = 521
integer y = 608
integer width = 411
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Todos"
end type

event clicked;uo_atencion_opc_cero luo_atencion_opc_cero
int li_confirma, li_res
li_confirma = MessageBox("Confirmación","¿Desea Actualizar?",Question!,YesNo!)
if li_confirma=1 then
	luo_atencion_opc_cero = CREATE uo_atencion_opc_cero 
	li_res = luo_atencion_opc_cero.of_actualiza_datos_tramites()
	if li_res = -1 then
		MessageBox("Error","No se han guardado los cambios",StopSign!)
	else
		MessageBox("Actualizacion","Se han guardado los cambios",StopSign!)
	end if
	if isvalid(	luo_atencion_opc_cero) then
		DESTROY luo_atencion_opc_cero
	end if
end if
end event

type uo_1 from uo_datos_opc_cero within w_prueba_opc_cero
integer x = 9
integer y = 12
integer width = 3205
integer height = 380
integer taborder = 10
end type

on uo_1.destroy
call uo_datos_opc_cero::destroy
end on

type gb_1 from groupbox within w_prueba_opc_cero
integer x = 901
integer y = 868
integer width = 1289
integer height = 520
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Monitoreo de Ejecución"
borderstyle borderstyle = stylelowered!
end type

