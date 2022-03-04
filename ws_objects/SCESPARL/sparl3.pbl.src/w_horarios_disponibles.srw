$PBExportHeader$w_horarios_disponibles.srw
forward
global type w_horarios_disponibles from window
end type
type cb_mostrar_grupos_sin_salon from commandbutton within w_horarios_disponibles
end type
type rb_1 from radiobutton within w_horarios_disponibles
end type
type rb_mismo_nivel from radiobutton within w_horarios_disponibles
end type
type rb_cualquiera from radiobutton within w_horarios_disponibles
end type
type st_1 from statictext within w_horarios_disponibles
end type
type cbx_respaldo from checkbox within w_horarios_disponibles
end type
type sle_salon_usuario from singlelineedit within w_horarios_disponibles
end type
type rb_superior from radiobutton within w_horarios_disponibles
end type
type rb_igual from radiobutton within w_horarios_disponibles
end type
type rb_inscritos from radiobutton within w_horarios_disponibles
end type
type rb_cupo from radiobutton within w_horarios_disponibles
end type
type dw_grupos_segun_clave from datawindow within w_horarios_disponibles
end type
type dw_busqueda_salon_horario from datawindow within w_horarios_disponibles
end type
type cb_cargar_salones_disponibles from commandbutton within w_horarios_disponibles
end type
type st_3 from statictext within w_horarios_disponibles
end type
type em_cve_mat from editmask within w_horarios_disponibles
end type
type em_gpo from editmask within w_horarios_disponibles
end type
type uo_1 from uo_per_ani within w_horarios_disponibles
end type
type gb_1 from groupbox within w_horarios_disponibles
end type
type gb_categoria from groupbox within w_horarios_disponibles
end type
type gb_nivel from groupbox within w_horarios_disponibles
end type
end forward

global type w_horarios_disponibles from window
integer width = 3529
integer height = 1624
boolean titlebar = true
string title = "Horarios Disponibles"
string menuname = "m_menugeneral"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
cb_mostrar_grupos_sin_salon cb_mostrar_grupos_sin_salon
rb_1 rb_1
rb_mismo_nivel rb_mismo_nivel
rb_cualquiera rb_cualquiera
st_1 st_1
cbx_respaldo cbx_respaldo
sle_salon_usuario sle_salon_usuario
rb_superior rb_superior
rb_igual rb_igual
rb_inscritos rb_inscritos
rb_cupo rb_cupo
dw_grupos_segun_clave dw_grupos_segun_clave
dw_busqueda_salon_horario dw_busqueda_salon_horario
cb_cargar_salones_disponibles cb_cargar_salones_disponibles
st_3 st_3
em_cve_mat em_cve_mat
em_gpo em_gpo
uo_1 uo_1
gb_1 gb_1
gb_categoria gb_categoria
gb_nivel gb_nivel
end type
global w_horarios_disponibles w_horarios_disponibles

forward prototypes
public subroutine wf_asigna_salon (string as_cve_salon)
end prototypes

public subroutine wf_asigna_salon (string as_cve_salon);if dw_grupos_segun_clave.RowCount() > 0 then
	int li_tot 
	int li_i
	datastore lds_respaldo_salones,lds_respaldo_salones2
	lds_respaldo_salones = create datastore
	lds_respaldo_salones.dataobject = "d_respaldo_salones"
	lds_respaldo_salones.SetTransObject(gtr_sce)
	lds_respaldo_salones2 = create datastore
	lds_respaldo_salones2.dataobject = "d_respaldo_salones"
	lds_respaldo_salones2.SetTransObject(gtr_sce)
	if (lds_respaldo_salones2.Retrieve() >= 0) then
		li_tot = dw_grupos_segun_clave.RowCount()
		for li_i = 1 to li_tot
			if ((lds_respaldo_salones2.Find("cve_mat = "+string(dw_grupos_segun_clave.GetItemNumber(li_i,"horario_cve_mat"))+&
									" AND gpo = '"+dw_grupos_segun_clave.GetItemString(li_i,"horario_gpo")+&
									"' AND periodo = "+string(dw_grupos_segun_clave.GetItemNumber(li_i,"horario_periodo"))+&
									" AND anio = "+string(dw_grupos_segun_clave.GetItemNumber(li_i,"horario_anio"))+&
									" AND cve_dia = "+string(dw_grupos_segun_clave.GetItemNumber(li_i,"horario_cve_dia"))+&
									" AND hora_inicio = "+string(dw_grupos_segun_clave.GetItemNumber(li_i,"horario_hora_inicio")),&
									1,lds_respaldo_salones2.RowCount()) = 0)  AND NOT(IsNull(dw_grupos_segun_clave.GetItemString(li_i,"horario_cve_salon")))&
									AND (cbx_respaldo.checked = true)) then
				lds_respaldo_salones.InsertRow(li_i)
				lds_respaldo_salones.SetItem(li_i, "cve_mat",dw_grupos_segun_clave.GetItemNumber(li_i,"horario_cve_mat"))
				lds_respaldo_salones.SetItem(li_i, "gpo",dw_grupos_segun_clave.GetItemString(li_i,"horario_gpo"))
				lds_respaldo_salones.SetItem(li_i, "periodo",dw_grupos_segun_clave.GetItemNumber(li_i,"horario_periodo"))
				lds_respaldo_salones.SetItem(li_i, "anio",dw_grupos_segun_clave.GetItemNumber(li_i,"horario_anio"))
				lds_respaldo_salones.SetItem(li_i, "cve_dia",dw_grupos_segun_clave.GetItemNumber(li_i,"horario_cve_dia"))
				lds_respaldo_salones.SetItem(li_i, "hora_inicio",dw_grupos_segun_clave.GetItemNumber(li_i,"horario_hora_inicio"))
				lds_respaldo_salones.SetItem(li_i, "cve_salon",dw_grupos_segun_clave.GetItemString(li_i,"horario_cve_salon"))
			end if
			dw_grupos_segun_clave.SetItem(li_i, "horario_cve_salon",as_cve_salon)
		next
		if ((dw_grupos_segun_clave.update()= 1) and (lds_respaldo_salones.update()=1) )then
			Commit using gtr_sce;
			MessageBox("Actualizacion Exitosa", "Se han respaldado y actualizado los salones.", Information!)
		else
			rollback using gtr_sce;
			MessageBox("Atencion", "NO se borraron los salones de los grupos.", StopSign!)
		end if
	else
		MessageBox("Error", "Error al consultar el respaldo de salones.", StopSign!)
	end if
	Destroy lds_respaldo_salones
	Destroy lds_respaldo_salones2
else
	MessageBox("Atencion", "NO hay horarios para asignar.", StopSign!)
end if

end subroutine

on w_horarios_disponibles.create
if this.MenuName = "m_menugeneral" then this.MenuID = create m_menugeneral
this.cb_mostrar_grupos_sin_salon=create cb_mostrar_grupos_sin_salon
this.rb_1=create rb_1
this.rb_mismo_nivel=create rb_mismo_nivel
this.rb_cualquiera=create rb_cualquiera
this.st_1=create st_1
this.cbx_respaldo=create cbx_respaldo
this.sle_salon_usuario=create sle_salon_usuario
this.rb_superior=create rb_superior
this.rb_igual=create rb_igual
this.rb_inscritos=create rb_inscritos
this.rb_cupo=create rb_cupo
this.dw_grupos_segun_clave=create dw_grupos_segun_clave
this.dw_busqueda_salon_horario=create dw_busqueda_salon_horario
this.cb_cargar_salones_disponibles=create cb_cargar_salones_disponibles
this.st_3=create st_3
this.em_cve_mat=create em_cve_mat
this.em_gpo=create em_gpo
this.uo_1=create uo_1
this.gb_1=create gb_1
this.gb_categoria=create gb_categoria
this.gb_nivel=create gb_nivel
this.Control[]={this.cb_mostrar_grupos_sin_salon,&
this.rb_1,&
this.rb_mismo_nivel,&
this.rb_cualquiera,&
this.st_1,&
this.cbx_respaldo,&
this.sle_salon_usuario,&
this.rb_superior,&
this.rb_igual,&
this.rb_inscritos,&
this.rb_cupo,&
this.dw_grupos_segun_clave,&
this.dw_busqueda_salon_horario,&
this.cb_cargar_salones_disponibles,&
this.st_3,&
this.em_cve_mat,&
this.em_gpo,&
this.uo_1,&
this.gb_1,&
this.gb_categoria,&
this.gb_nivel}
end on

on w_horarios_disponibles.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_mostrar_grupos_sin_salon)
destroy(this.rb_1)
destroy(this.rb_mismo_nivel)
destroy(this.rb_cualquiera)
destroy(this.st_1)
destroy(this.cbx_respaldo)
destroy(this.sle_salon_usuario)
destroy(this.rb_superior)
destroy(this.rb_igual)
destroy(this.rb_inscritos)
destroy(this.rb_cupo)
destroy(this.dw_grupos_segun_clave)
destroy(this.dw_busqueda_salon_horario)
destroy(this.cb_cargar_salones_disponibles)
destroy(this.st_3)
destroy(this.em_cve_mat)
destroy(this.em_gpo)
destroy(this.uo_1)
destroy(this.gb_1)
destroy(this.gb_categoria)
destroy(this.gb_nivel)
end on

type cb_mostrar_grupos_sin_salon from commandbutton within w_horarios_disponibles
integer x = 654
integer y = 660
integer width = 773
integer height = 112
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mostrar Grupos Sin Salon"
end type

event clicked;st_cve_mat_gpo lst_cve_mat_gpo
Open(w_grupos_sin_salon)
lst_cve_mat_gpo = Message.PowerObjectParm
if lst_cve_mat_gpo.cve_mat > 0 then
	em_cve_mat.text = string(lst_cve_mat_gpo.cve_mat)
	em_gpo.text = lst_cve_mat_gpo.gpo
	cb_cargar_salones_disponibles.event clicked()
end if
end event

type rb_1 from radiobutton within w_horarios_disponibles
integer x = 2331
integer y = 164
integer width = 471
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "cualquier nivel"
borderstyle borderstyle = stylelowered!
end type

type rb_mismo_nivel from radiobutton within w_horarios_disponibles
integer x = 2331
integer y = 80
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "mismo nivel"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

type rb_cualquiera from radiobutton within w_horarios_disponibles
integer x = 1833
integer y = 248
integer width = 379
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "cualquiera"
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_horarios_disponibles
integer x = 2354
integer y = 488
integer width = 1033
integer height = 216
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Se debe respaldar si los salones se están moviendo después de la generación de solicitudes de materias"
boolean focusrectangle = false
end type

type cbx_respaldo from checkbox within w_horarios_disponibles
integer x = 2267
integer y = 396
integer width = 1088
integer height = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Respaldar el salón antes de borrarlo"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

type sle_salon_usuario from singlelineedit within w_horarios_disponibles
integer x = 663
integer y = 448
integer width = 297
integer height = 96
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;DataStore lds_salones_existentes,lds_salon_libre
lds_salones_existentes = CREATE DataStore
lds_salones_existentes.DataObject = "d_salones_existentes"
lds_salones_existentes.SetTransObject(gtr_sce)
lds_salon_libre = CREATE DataStore
lds_salon_libre.DataObject = "d_salon_libre"
lds_salon_libre.SetTransObject(gtr_sce)

if (lds_salones_existentes.Retrieve(0,"C")>0) then
	if (lds_salones_existentes.Find("cve_salon = '"+text+"'",1,lds_salones_existentes.RowCount()) > 0) then
		int li_total_horarios 
		li_total_horarios = dw_grupos_segun_clave.RowCount()
		int li_i, li_horarios_ocupados
		boolean lb_disponible = false
		if li_total_horarios > 0 then
			for li_i = 1 to li_total_horarios
				li_horarios_ocupados = lds_salon_libre.Retrieve(gi_anio,gi_periodo,&
					dw_grupos_segun_clave.GetItemNumber(li_i,"horario_hora_inicio"),&
					dw_grupos_segun_clave.GetItemNumber(li_i,"horario_hora_final"),&
					dw_grupos_segun_clave.GetItemNumber(li_i,"horario_cve_dia"),text)
				if ( li_horarios_ocupados> 0) then
					lb_disponible = false
					li_i = li_total_horarios
				elseif (li_horarios_ocupados = 0) then
					lb_disponible = true
				end if
			next
			if lb_disponible = false then
				MessageBox("Atencion", "El salón existe pero esta ocupado en algún o algunos de los horarios requeridos.", StopSign!)
			else
				if (MessageBox("Atencion", "El salón existe y esta libre. ¿Desea asignarlo?.", Question!,YesNo!)=1) then
					wf_asigna_salon(text)
				end if
			end if
		else
			MessageBox("Atencion", "No hay horarios a que asignar el salón.", StopSign!)
		end if
	else
		MessageBox("Atencion", "El salón no existe. "+text, StopSign!)
	end if
else
	MessageBox("Error", "Error al consultar salones.", StopSign!)
end if

Destroy lds_salones_existentes
Destroy lds_salon_libre



end event

type rb_superior from radiobutton within w_horarios_disponibles
integer x = 1833
integer y = 164
integer width = 338
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "superior"
borderstyle borderstyle = stylelowered!
end type

type rb_igual from radiobutton within w_horarios_disponibles
integer x = 1833
integer y = 80
integer width = 338
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "igual"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

type rb_inscritos from radiobutton within w_horarios_disponibles
integer x = 1367
integer y = 164
integer width = 329
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "inscritos"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

type rb_cupo from radiobutton within w_horarios_disponibles
integer x = 1367
integer y = 80
integer width = 329
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "cupo"
borderstyle borderstyle = stylelowered!
end type

type dw_grupos_segun_clave from datawindow within w_horarios_disponibles
integer x = 37
integer y = 928
integer width = 3406
integer height = 488
integer taborder = 80
string title = "none"
string dataobject = "d_grupos_segun_clave"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;m_menugeneral.dw = this
modify("Datawindow.print.preview = Yes")
SetTransObject(gtr_sce)
end event

type dw_busqueda_salon_horario from datawindow within w_horarios_disponibles
integer x = 41
integer y = 448
integer width = 521
integer height = 452
integer taborder = 70
string title = "none"
string dataobject = "d_busqueda_salon_horario"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;if row > 0 then 
	sle_salon_usuario.text = GetItemString(row,"cve_salon")
	sle_salon_usuario. Event Modified()
	DeleteRow(row)
end if
end event

type cb_cargar_salones_disponibles from commandbutton within w_horarios_disponibles
integer x = 622
integer y = 304
integer width = 1143
integer height = 96
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar Salones Disponibles según horario"
end type

event clicked;int li_regresa
li_regresa = dw_grupos_segun_clave.Retrieve(gi_anio, gi_periodo, integer(em_cve_mat.text),em_gpo.text)
if (li_regresa = 0) then
	MessageBox("Atencion", "NO hay horarios de tipo salon con los criterios seleccionados.", StopSign!)
elseif (li_regresa > 0) then
	int li_i, li_renglon, li_salones, li_cupo_salon, li_encontrado
	int li_limiteinf[5], li_limitesup[5], li_cupoinsc[5]
	string ls_nivel
//	li_limiteinf = {45,34,25,11,0}
//	li_limitesup = {99,44,33,24,10}
//	li_cupoinsc = {60,40,30,20,10}
	f_llena_configuracion_asignacion_salones(li_limiteinf,li_limitesup,li_cupoinsc)

	if rb_cupo.checked = true then
		li_cupo_salon = dw_grupos_segun_clave.GetItemNumber(1,"grupos_cupo") 
	else
		li_cupo_salon = dw_grupos_segun_clave.GetItemNumber(1,"grupos_inscritos")
	end if
	if rb_cualquiera.checked = true then
		li_cupo_salon = 1000
	else
		for li_i = 1 to 5
			if li_cupo_salon >= li_limiteinf[li_i] AND li_cupo_salon <= li_limitesup[li_i] then
				if rb_superior.checked = true and (li_i > 1) then
					li_cupo_salon = li_cupoinsc[li_i - 1]
					li_i = 5
				else
					li_cupo_salon = li_cupoinsc[li_i]
					li_i = 5
				end if
			end if
		next
	end if
	datastore lds_salones_ofrecidos
	lds_salones_ofrecidos = CREATE DataStore
	lds_salones_ofrecidos.DataObject = "d_salones_ofrecidos"
	lds_salones_ofrecidos.SetTransObject(gtr_sce)
	if rb_mismo_nivel.checked = true then
		ls_nivel = dw_grupos_segun_clave.GetItemString(1,"materias_nivel")
	else
		ls_nivel = "C"
	end if
//	MessageBox("", "Buscando salones para "+&
//							dw_grupos_segun_clave.GetItemString(1,"materias_nivel")+&
//							" del dia "+string(dw_grupos_segun_clave.GetItemNumber(1,"horario_cve_dia"))+&
//							" del horario "+string(dw_grupos_segun_clave.GetItemNumber(1,"horario_hora_inicio"))+&
//							"hrs a las "+string(dw_grupos_segun_clave.GetItemNumber(1,"horario_hora_final"))+&
//							"hrs con un cupo máximo del salon de "+string(li_cupo_salon))
	li_salones = lds_salones_ofrecidos.Retrieve(gi_anio, gi_periodo,ls_nivel,&
					dw_grupos_segun_clave.GetItemNumber(1,"horario_cve_dia"),&
					dw_grupos_segun_clave.GetItemNumber(1,"horario_hora_inicio"),&
					dw_grupos_segun_clave.GetItemNumber(1,"horario_hora_final"),&
					li_cupo_salon,100)
	if li_salones > 0 then
		dw_busqueda_salon_horario.reset()
		for li_renglon = 1 to li_salones
			li_renglon = dw_busqueda_salon_horario.InsertRow(0)
			dw_busqueda_salon_horario.SetItem(li_renglon,"cve_salon",lds_salones_ofrecidos.GetItemString(li_renglon,"salon_cve_salon"))
			dw_busqueda_salon_horario.SetItem(li_renglon,"disponible",0)
			dw_busqueda_salon_horario.SetItem(li_renglon,"nivel",lds_salones_ofrecidos.GetItemString(li_renglon,"nivel"))
			dw_busqueda_salon_horario.SetItem(li_renglon,"cupo",lds_salones_ofrecidos.GetItemNumber(li_renglon,"cupo_max"))
		next
		for li_i = 2 to li_regresa
			li_salones = lds_salones_ofrecidos.Retrieve(gi_anio, gi_periodo,ls_nivel,&
					dw_grupos_segun_clave.GetItemNumber(li_i,"horario_cve_dia"),&
					dw_grupos_segun_clave.GetItemNumber(li_i,"horario_hora_inicio"),&
					dw_grupos_segun_clave.GetItemNumber(li_i,"horario_hora_final"),&
					li_cupo_salon,100)
			for li_renglon = 1 to li_salones
				li_encontrado = dw_busqueda_salon_horario.Find("cve_salon = '" +&
					lds_salones_ofrecidos.GetItemString(li_renglon, "salon_cve_salon")+"'",1,dw_busqueda_salon_horario.RowCount())
				if li_encontrado > 0 then dw_busqueda_salon_horario.SetItem(li_encontrado,"disponible",1)
			next
			for li_renglon = 1 to dw_busqueda_salon_horario.RowCount()
				if dw_busqueda_salon_horario.GetItemNumber(li_renglon, "disponible") = 0 then
					dw_busqueda_salon_horario.DeleteRow(li_renglon)
					li_renglon --
				else
					dw_busqueda_salon_horario.SetItem(li_renglon, "disponible",0)
				end if
			next
		next
		dw_busqueda_salon_horario.Sort()
		Destroy lds_salones_ofrecidos
	end if
end if
end event

type st_3 from statictext within w_horarios_disponibles
integer x = 18
integer y = 220
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

type em_cve_mat from editmask within w_horarios_disponibles
integer x = 174
integer y = 304
integer width = 274
integer height = 96
integer taborder = 20
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

type em_gpo from editmask within w_horarios_disponibles
integer x = 471
integer y = 304
integer width = 133
integer height = 96
integer taborder = 30
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

type uo_1 from uo_per_ani within w_horarios_disponibles
integer x = 23
integer y = 24
integer width = 1248
integer height = 164
integer taborder = 10
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type gb_1 from groupbox within w_horarios_disponibles
integer x = 1326
integer y = 16
integer width = 402
integer height = 244
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Criterio"
borderstyle borderstyle = stylelowered!
end type

type gb_categoria from groupbox within w_horarios_disponibles
integer x = 1806
integer y = 16
integer width = 416
integer height = 336
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Categoria"
borderstyle borderstyle = stylelowered!
end type

type gb_nivel from groupbox within w_horarios_disponibles
integer x = 2299
integer y = 16
integer width = 553
integer height = 264
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nivel"
borderstyle borderstyle = stylelowered!
end type

