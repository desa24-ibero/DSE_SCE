$PBExportHeader$w_reasigna_salones.srw
forward
global type w_reasigna_salones from window
end type
type sle_diferencia_excedidos from singlelineedit within w_reasigna_salones
end type
type em_gpo from editmask within w_reasigna_salones
end type
type em_cve_mat from editmask within w_reasigna_salones
end type
type st_3 from statictext within w_reasigna_salones
end type
type st_2 from statictext within w_reasigna_salones
end type
type cb_borrar_salon_especial from commandbutton within w_reasigna_salones
end type
type cb_borrar_salon from commandbutton within w_reasigna_salones
end type
type cb_borrar_salones_inscritos_abajo_cupo from commandbutton within w_reasigna_salones
end type
type st_status from statictext within w_reasigna_salones
end type
type st_1 from statictext within w_reasigna_salones
end type
type sle_diferencia from singlelineedit within w_reasigna_salones
end type
type cb_borrar_salones_inscritos_mayor_cupo from commandbutton within w_reasigna_salones
end type
type dw_datawindow from datawindow within w_reasigna_salones
end type
type cb_cargar_necesarios_vs_disponibles from commandbutton within w_reasigna_salones
end type
type cb_borrar_salones_inscritos_cero from commandbutton within w_reasigna_salones
end type
type uo_1 from uo_per_ani within w_reasigna_salones
end type
end forward

global type w_reasigna_salones from window
integer width = 3913
integer height = 1800
boolean titlebar = true
string title = "Borrar Salones para Reasignación"
string menuname = "m_menugeneral"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
sle_diferencia_excedidos sle_diferencia_excedidos
em_gpo em_gpo
em_cve_mat em_cve_mat
st_3 st_3
st_2 st_2
cb_borrar_salon_especial cb_borrar_salon_especial
cb_borrar_salon cb_borrar_salon
cb_borrar_salones_inscritos_abajo_cupo cb_borrar_salones_inscritos_abajo_cupo
st_status st_status
st_1 st_1
sle_diferencia sle_diferencia
cb_borrar_salones_inscritos_mayor_cupo cb_borrar_salones_inscritos_mayor_cupo
dw_datawindow dw_datawindow
cb_cargar_necesarios_vs_disponibles cb_cargar_necesarios_vs_disponibles
cb_borrar_salones_inscritos_cero cb_borrar_salones_inscritos_cero
uo_1 uo_1
end type
global w_reasigna_salones w_reasigna_salones

on w_reasigna_salones.create
if this.MenuName = "m_menugeneral" then this.MenuID = create m_menugeneral
this.sle_diferencia_excedidos=create sle_diferencia_excedidos
this.em_gpo=create em_gpo
this.em_cve_mat=create em_cve_mat
this.st_3=create st_3
this.st_2=create st_2
this.cb_borrar_salon_especial=create cb_borrar_salon_especial
this.cb_borrar_salon=create cb_borrar_salon
this.cb_borrar_salones_inscritos_abajo_cupo=create cb_borrar_salones_inscritos_abajo_cupo
this.st_status=create st_status
this.st_1=create st_1
this.sle_diferencia=create sle_diferencia
this.cb_borrar_salones_inscritos_mayor_cupo=create cb_borrar_salones_inscritos_mayor_cupo
this.dw_datawindow=create dw_datawindow
this.cb_cargar_necesarios_vs_disponibles=create cb_cargar_necesarios_vs_disponibles
this.cb_borrar_salones_inscritos_cero=create cb_borrar_salones_inscritos_cero
this.uo_1=create uo_1
this.Control[]={this.sle_diferencia_excedidos,&
this.em_gpo,&
this.em_cve_mat,&
this.st_3,&
this.st_2,&
this.cb_borrar_salon_especial,&
this.cb_borrar_salon,&
this.cb_borrar_salones_inscritos_abajo_cupo,&
this.st_status,&
this.st_1,&
this.sle_diferencia,&
this.cb_borrar_salones_inscritos_mayor_cupo,&
this.dw_datawindow,&
this.cb_cargar_necesarios_vs_disponibles,&
this.cb_borrar_salones_inscritos_cero,&
this.uo_1}
end on

on w_reasigna_salones.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.sle_diferencia_excedidos)
destroy(this.em_gpo)
destroy(this.em_cve_mat)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cb_borrar_salon_especial)
destroy(this.cb_borrar_salon)
destroy(this.cb_borrar_salones_inscritos_abajo_cupo)
destroy(this.st_status)
destroy(this.st_1)
destroy(this.sle_diferencia)
destroy(this.cb_borrar_salones_inscritos_mayor_cupo)
destroy(this.dw_datawindow)
destroy(this.cb_cargar_necesarios_vs_disponibles)
destroy(this.cb_borrar_salones_inscritos_cero)
destroy(this.uo_1)
end on

type sle_diferencia_excedidos from singlelineedit within w_reasigna_salones
integer x = 2464
integer y = 152
integer width = 128
integer height = 100
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "5"
borderstyle borderstyle = stylelowered!
end type

type em_gpo from editmask within w_reasigna_salones
integer x = 837
integer y = 428
integer width = 133
integer height = 96
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!a"
end type

type em_cve_mat from editmask within w_reasigna_salones
integer x = 539
integer y = 428
integer width = 274
integer height = 96
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type st_3 from statictext within w_reasigna_salones
integer x = 384
integer y = 344
integer width = 608
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "clave de materia grupo"
boolean focusrectangle = false
end type

type st_2 from statictext within w_reasigna_salones
integer x = 2834
integer y = 308
integer width = 622
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Diferencia especificada"
boolean focusrectangle = false
end type

type cb_borrar_salon_especial from commandbutton within w_reasigna_salones
integer x = 1285
integer y = 416
integer width = 1161
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar salones segun una clave dada"
end type

event clicked;	dw_datawindow.dataobject = "d_grupos_segun_clave"
	dw_datawindow.SetTransObject(gtr_sce)
	if (dw_datawindow.Retrieve(gi_anio, gi_periodo,integer(em_cve_mat.text),em_gpo.text) = 0 ) then
		MessageBox("Atencion", "NO hay grupos de esa clave de materia grupo para el año-periodo seleccionados.", StopSign!)
	end if
end event

type cb_borrar_salon from commandbutton within w_reasigna_salones
integer x = 2112
integer y = 548
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Borrar Salón"
end type

event clicked;if dw_datawindow.RowCount() > 0 then
	if (MessageBox("Atencion", "Se respaldarán y borrarán los salones. ¿Desea borrarlos?.", Question!,YesNo!)=1) then
		int li_tot 
		int li_i
		string ls_null_string
		datastore lds_respaldo_salones,lds_respaldo_salones2
		lds_respaldo_salones = create datastore
		lds_respaldo_salones.dataobject = "d_respaldo_salones"
		lds_respaldo_salones.SetTransObject(gtr_sce)
		lds_respaldo_salones2 = create datastore
		lds_respaldo_salones2.dataobject = "d_respaldo_salones"
		lds_respaldo_salones2.SetTransObject(gtr_sce)
		if (lds_respaldo_salones2.Retrieve() >= 0) then
			li_tot = dw_datawindow.RowCount()
			SetNull(ls_null_string)
			for li_i = 1 to li_tot
				if ((lds_respaldo_salones2.Find("cve_mat = "+string(dw_datawindow.GetItemNumber(li_i,"horario_cve_mat"))+&
									" AND gpo = '"+dw_datawindow.GetItemString(li_i,"horario_gpo")+&
									"' AND periodo = "+string(dw_datawindow.GetItemNumber(li_i,"horario_periodo"))+&
									" AND anio = "+string(dw_datawindow.GetItemNumber(li_i,"horario_anio"))+&
									" AND cve_dia = "+string(dw_datawindow.GetItemNumber(li_i,"horario_cve_dia"))+&
									" AND hora_inicio = "+string(dw_datawindow.GetItemNumber(li_i,"horario_hora_inicio")),&
									1,lds_respaldo_salones2.RowCount()) = 0)  AND NOT(IsNull(dw_datawindow.GetItemString(li_i,"horario_cve_salon")))) then
					lds_respaldo_salones.InsertRow(li_i)
					lds_respaldo_salones.SetItem(li_i, "cve_mat",dw_datawindow.GetItemNumber(li_i,"horario_cve_mat"))
					lds_respaldo_salones.SetItem(li_i, "gpo",dw_datawindow.GetItemString(li_i,"horario_gpo"))
					lds_respaldo_salones.SetItem(li_i, "periodo",dw_datawindow.GetItemNumber(li_i,"horario_periodo"))
					lds_respaldo_salones.SetItem(li_i, "anio",dw_datawindow.GetItemNumber(li_i,"horario_anio"))
					lds_respaldo_salones.SetItem(li_i, "cve_dia",dw_datawindow.GetItemNumber(li_i,"horario_cve_dia"))
					lds_respaldo_salones.SetItem(li_i, "hora_inicio",dw_datawindow.GetItemNumber(li_i,"horario_hora_inicio"))
					lds_respaldo_salones.SetItem(li_i, "cve_salon",dw_datawindow.GetItemString(li_i,"horario_cve_salon"))
				end if
				dw_datawindow.SetItem(li_i, "horario_cve_salon",ls_null_string)
			next
			if ((dw_datawindow.update()= 1) and (lds_respaldo_salones.update()=1) )then
				Commit using gtr_sce;
				MessageBox("Actualizacion Exitosa", "Se han respaldado y borrado los salones.", Information!)
			else
				rollback using gtr_sce;
				MessageBox("Atencion", "NO se borraron los salones de los grupos.", StopSign!)
			end if
		else
			MessageBox("Error", "Error al consultar el respaldo de salones.", StopSign!)
		end if
		Destroy lds_respaldo_salones
		Destroy lds_respaldo_salones2
	end if
else
	MessageBox("Atencion", "NO hay salones para borrar.", StopSign!)
end if

end event

type cb_borrar_salones_inscritos_abajo_cupo from commandbutton within w_reasigna_salones
integer x = 1285
integer y = 284
integer width = 1161
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar salones con inscritos menor a cupo"
end type

event clicked;	dw_datawindow.dataobject = "d_grupos_inscritos_vs_cupo"
	dw_datawindow.SetTransObject(gtr_sce)
	if (dw_datawindow.Retrieve(gi_anio, gi_periodo,integer(sle_diferencia.text),0) = 0 ) then
		MessageBox("Atencion", "NO hay grupos con inscritos menor a cupo para el año-periodo seleccionados.", StopSign!)
	end if
	
end event

type st_status from statictext within w_reasigna_salones
integer x = 2560
integer y = 588
integer width = 1179
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_1 from statictext within w_reasigna_salones
integer x = 2629
integer y = 16
integer width = 1239
integer height = 260
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "En los disponibles y en los inscritos menor a cupo se tomarán en cuenta los que tengan los inscritos por debajo del cupo del salón en al menos la diferencia especificada"
boolean focusrectangle = false
end type

type sle_diferencia from singlelineedit within w_reasigna_salones
integer x = 2464
integer y = 284
integer width = 128
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "100"
borderstyle borderstyle = stylelowered!
end type

type cb_borrar_salones_inscritos_mayor_cupo from commandbutton within w_reasigna_salones
integer x = 1285
integer y = 152
integer width = 1161
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar salones con inscritos mayor a cupo"
end type

event clicked;	dw_datawindow.dataobject = "d_grupos_inscritos_vs_cupo"
	dw_datawindow.SetTransObject(gtr_sce)
	if (dw_datawindow.Retrieve(gi_anio, gi_periodo,0,integer(sle_diferencia_excedidos.text))= 0) then
		MessageBox("Atencion", "NO hay grupos con inscritos mayor a cupo para el año-periodo seleccionados.", StopSign!)
	end if
	

end event

type dw_datawindow from datawindow within w_reasigna_salones
integer x = 105
integer y = 700
integer width = 3689
integer height = 876
integer taborder = 60
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;m_menugeneral.dw = this
modify("Datawindow.print.preview = Yes")
SetTransObject(gtr_sce)
end event

event doubleclicked;if row > 0  then
	if (MessageBox("Atencion", "El salón se respaldará y se borrará. ¿Desea borrarlo?.", Question!,YesNo!)=1) then
		string ls_null_string
		int li_renglon
		datastore lds_respaldo_salones
		lds_respaldo_salones = create datastore
		lds_respaldo_salones.dataobject = "d_respaldo_salones"
		lds_respaldo_salones.SetTransObject(gtr_sce)
	
		if (lds_respaldo_salones.Retrieve() >= 0) then
			if ((lds_respaldo_salones.Find("cve_mat = "+string(dw_datawindow.GetItemNumber(row,"horario_cve_mat"))+&
									" AND gpo = '"+dw_datawindow.GetItemString(row,"horario_gpo")+&
									"' AND periodo = "+string(dw_datawindow.GetItemNumber(row,"horario_periodo"))+&
									" AND anio = "+string(dw_datawindow.GetItemNumber(row,"horario_anio"))+&
									" AND cve_dia = "+string(dw_datawindow.GetItemNumber(row,"horario_cve_dia"))+&
									" AND hora_inicio = "+string(dw_datawindow.GetItemNumber(row,"horario_hora_inicio")),&
									1,lds_respaldo_salones.RowCount()) = 0)  AND NOT(IsNull(dw_datawindow.GetItemString(row,"horario_cve_salon")))) then
				li_renglon = lds_respaldo_salones.InsertRow(0)
				lds_respaldo_salones.SetItem(li_renglon, "cve_mat",dw_datawindow.GetItemNumber(row,"horario_cve_mat"))
				lds_respaldo_salones.SetItem(li_renglon, "gpo",dw_datawindow.GetItemString(row,"horario_gpo"))
				lds_respaldo_salones.SetItem(li_renglon, "periodo",dw_datawindow.GetItemNumber(row,"horario_periodo"))
				lds_respaldo_salones.SetItem(li_renglon, "anio",dw_datawindow.GetItemNumber(row,"horario_anio"))
				lds_respaldo_salones.SetItem(li_renglon, "cve_dia",dw_datawindow.GetItemNumber(row,"horario_cve_dia"))
				lds_respaldo_salones.SetItem(li_renglon, "hora_inicio",dw_datawindow.GetItemNumber(row,"horario_hora_inicio"))
				lds_respaldo_salones.SetItem(li_renglon, "cve_salon",dw_datawindow.GetItemString(row,"horario_cve_salon"))
			end if
			SetNull(ls_null_string)	
			dw_datawindow.SetItem(row, "horario_cve_salon",ls_null_string)
			if ((dw_datawindow.update()= 1) and (lds_respaldo_salones.update()=1) )then
				Commit using gtr_sce;
				MessageBox("Actualizacion Exitosa", "Se ha respaldado y borrado el salón.", Information!)
			else
				rollback using gtr_sce;
				MessageBox("Atencion", "NO se borró el salón.", StopSign!)
			end if
		else
			MessageBox("Error", "Error al consultar el respaldo de salones.", StopSign!)
		end if
		Destroy lds_respaldo_salones
	end if
end if
end event

type cb_cargar_necesarios_vs_disponibles from commandbutton within w_reasigna_salones
integer x = 2629
integer y = 416
integer width = 1189
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar Necesarios VS Disponibles"
end type

event clicked;dw_datawindow.dataobject = "d_salones_demanda_vs_oferta"
dw_datawindow.reset()
datastore lds_salones_requeridos, lds_salones_ofrecidos
lds_salones_requeridos = Create DataStore
lds_salones_ofrecidos = Create DataStore
lds_salones_requeridos.DataObject = "d_salones_requeridos"
lds_salones_ofrecidos.DataObject = "d_salones_ofrecidos"
lds_salones_requeridos.SetTransObject(gtr_sce)
lds_salones_ofrecidos.SetTransObject(gtr_sce)
st_status.text = "Empieza la carga"

int li_dias, li_horario, li_inscritos, li_renglon
int li_limiteinf[5], li_limitesup[5], li_cupoinsc[5], li_hora_inicio[7]
string ls_dias[6]
//li_limiteinf = {45,34,25,11,0}
//li_limitesup = {99,44,33,24,10}
//li_cupoinsc = {60,40,30,20,10}
f_llena_configuracion_asignacion_salones(li_limiteinf,li_limitesup,li_cupoinsc)

li_hora_inicio = {7,9,11,13,16,18,20}
ls_dias = {"Lunes","Martes","Miercoles","Jueves","Viernes","Sabado"}
for li_dias = 1 to 6
	for li_horario = 1 to 7
		for li_inscritos = 1 to 5 
			li_renglon = dw_datawindow.InsertRow(0)
			st_status.text = "Cargando " + string(li_renglon) + " de 210"
			dw_datawindow.SetItem(li_renglon,"cve_dia",li_dias)
			dw_datawindow.SetItem(li_renglon,"dia",ls_dias[li_dias])
			dw_datawindow.SetItem(li_renglon,"hora_inicio",li_hora_inicio[li_horario])
			dw_datawindow.SetItem(li_renglon,"hora_final",li_hora_inicio[li_horario] + 2)
			dw_datawindow.SetItem(li_renglon,"insc_min",li_limiteinf[li_inscritos])
			dw_datawindow.SetItem(li_renglon,"insc_max",li_limitesup[li_inscritos])
			dw_datawindow.SetItem(li_renglon,"salon_cupo",li_cupoinsc[li_inscritos])
			dw_datawindow.SetItem(li_renglon,"lic_req",&
				lds_salones_requeridos.retrieve(gi_anio, gi_periodo, "L",li_dias,&
				li_hora_inicio[li_horario],li_hora_inicio[li_horario] + 2,&
				li_limiteinf[li_inscritos],li_limitesup[li_inscritos],integer(sle_diferencia.text)))
			dw_datawindow.SetItem(li_renglon,"lic_disp",&
				lds_salones_ofrecidos.retrieve(gi_anio, gi_periodo,"L",li_dias,&
				li_hora_inicio[li_horario],li_hora_inicio[li_horario] + 2,&
				li_cupoinsc[li_inscritos],integer(sle_diferencia.text)))
			dw_datawindow.SetItem(li_renglon,"pos_req",&
				lds_salones_requeridos.retrieve(gi_anio, gi_periodo, "P",li_dias,&
				li_hora_inicio[li_horario],li_hora_inicio[li_horario] + 2,&
				li_limiteinf[li_inscritos],li_limitesup[li_inscritos],integer(sle_diferencia.text)))
			dw_datawindow.SetItem(li_renglon,"pos_disp",&
				lds_salones_ofrecidos.retrieve(gi_anio, gi_periodo,"P",li_dias,&
				li_hora_inicio[li_horario],li_hora_inicio[li_horario] + 2,&
				li_cupoinsc[li_inscritos],integer(sle_diferencia.text)))
		next
	next
next
st_status.text = "Terminado"
DESTROY lds_salones_requeridos
DESTROY lds_salones_ofrecidos
end event

type cb_borrar_salones_inscritos_cero from commandbutton within w_reasigna_salones
integer x = 1285
integer y = 20
integer width = 1161
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar salones de grupos con inscritos 0"
end type

event clicked;	dw_datawindow.dataobject = "d_grupos_cero_inscritos"
	dw_datawindow.SetTransObject(gtr_sce)
	if (dw_datawindow.Retrieve(gi_anio, gi_periodo) = 0) then
		MessageBox("Atencion", "NO hay grupos con cero inscritos para el año-periodo seleccionados.", StopSign!)
	end if
		
end event

type uo_1 from uo_per_ani within w_reasigna_salones
integer x = 23
integer y = 24
integer width = 1248
integer height = 164
integer taborder = 40
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

