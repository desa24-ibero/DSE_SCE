$PBExportHeader$w_configuracion_asignacion_salones.srw
forward
global type w_configuracion_asignacion_salones from window
end type
type cb_1 from commandbutton within w_configuracion_asignacion_salones
end type
type dw_conf_asig_salones from datawindow within w_configuracion_asignacion_salones
end type
end forward

global type w_configuracion_asignacion_salones from window
integer width = 3013
integer height = 1696
boolean titlebar = true
string title = "Configuración de Asignación de Salones"
string menuname = "m_menugeneral"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
cb_1 cb_1
dw_conf_asig_salones dw_conf_asig_salones
end type
global w_configuracion_asignacion_salones w_configuracion_asignacion_salones

on w_configuracion_asignacion_salones.create
if this.MenuName = "m_menugeneral" then this.MenuID = create m_menugeneral
this.cb_1=create cb_1
this.dw_conf_asig_salones=create dw_conf_asig_salones
this.Control[]={this.cb_1,&
this.dw_conf_asig_salones}
end on

on w_configuracion_asignacion_salones.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.dw_conf_asig_salones)
end on

type cb_1 from commandbutton within w_configuracion_asignacion_salones
integer x = 2162
integer y = 80
integer width = 622
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Revisar Configuración"
end type

event clicked;int limiteinf1, limiteinf2, limiteinf3, limiteinf4, limiteinf5
int limitesup1, limitesup2, limitesup3, limitesup4, limitesup5
int cupoinsc1,  cupoinsc2,  cupoinsc3,  cupoinsc4,  cupoinsc5
int li_total_salones_por_cupo, li_i,li_cupo
string ls_bloqueados = ""
datastore lds_total_de_salones_por_cupo
lds_total_de_salones_por_cupo = CREATE DataStore
lds_total_de_salones_por_cupo.DataObject = "d_total_de_salones_por_cupo"
lds_total_de_salones_por_cupo.SetTransObject(gtr_sce)
li_total_salones_por_cupo = lds_total_de_salones_por_cupo.Retrieve()
string ls_mensaje
if dw_conf_asig_salones.RowCount() = 1 AND li_total_salones_por_cupo > 0 then
	limiteinf1= dw_conf_asig_salones.GetItemNumber(1,"limiteinf1")
	limiteinf2= dw_conf_asig_salones.GetItemNumber(1,"limiteinf2")
	limiteinf3= dw_conf_asig_salones.GetItemNumber(1,"limiteinf3")
	limiteinf4= dw_conf_asig_salones.GetItemNumber(1,"limiteinf4")
	limiteinf5= dw_conf_asig_salones.GetItemNumber(1,"limiteinf5")
	limitesup1= dw_conf_asig_salones.GetItemNumber(1,"limitesup1")
	limitesup2= dw_conf_asig_salones.GetItemNumber(1,"limitesup2")
	limitesup3= dw_conf_asig_salones.GetItemNumber(1,"limitesup3")
	limitesup4= dw_conf_asig_salones.GetItemNumber(1,"limitesup4")
	limitesup5= dw_conf_asig_salones.GetItemNumber(1,"limitesup5")
	cupoinsc1 = dw_conf_asig_salones.GetItemNumber(1,"cupoinsc1")
	cupoinsc2 = dw_conf_asig_salones.GetItemNumber(1,"cupoinsc2")
	cupoinsc3 = dw_conf_asig_salones.GetItemNumber(1,"cupoinsc3")
	cupoinsc4 = dw_conf_asig_salones.GetItemNumber(1,"cupoinsc4")
	cupoinsc5 = dw_conf_asig_salones.GetItemNumber(1,"cupoinsc5")
	if limiteinf1 <> 0 then ls_mensaje += "El primer límite inferior debe ser igual a 0"
	if limitesup5 <> 99 then ls_mensaje += "~nEl úiltimo límite superior debe ser igual a 99"
	if (limiteinf2 <= 0 OR limiteinf3 <= 0 OR limiteinf4 <= 0 OR limiteinf5 <= 0&
		 OR limitesup1 <= 0  OR limitesup2 <= 0  OR limitesup3 <= 0  OR limitesup4 <= 0&
		  OR cupoinsc1 <= 0  OR cupoinsc2 <= 0  OR cupoinsc3 <= 0 OR cupoinsc4 <= 0&
		  OR cupoinsc5 <= 0) then ls_mensaje += "~nNo puede habe número negativos"
	if limitesup1 + 1 <> limiteinf2 then ls_mensaje += "~nEl bloque uno y el dos no son consecutivos"
	if limitesup2 + 1 <> limiteinf3 then ls_mensaje += "~nEl bloque dos y el tres no son consecutivos"
	if limitesup3 + 1 <> limiteinf4 then ls_mensaje += "~nEl bloque tres y el cuatro no son consecutivos"
	if limitesup4 + 1 <> limiteinf5 then ls_mensaje += "~nEl bloque cuatro y el cinco no son consecutivos"
	if (cupoinsc1 > limitesup1 or cupoinsc1 < limiteinf1) then
		ls_mensaje += "~nEl salón que se asignará en el bloque uno no está dentro de sus rangos"
	end if
	if (cupoinsc2 > limitesup2 or cupoinsc2 < limiteinf2) then
		ls_mensaje += "~nEl salón que se asignará en el bloque dos no está dentro de sus rangos"
	end if
	if (cupoinsc3 > limitesup3 or cupoinsc3 < limiteinf3) then
		ls_mensaje += "~nEl salón que se asignará en el bloque tres no está dentro de sus rangos"
	end if
	if (cupoinsc4 > limitesup4 or cupoinsc4 < limiteinf4) then
		ls_mensaje += "~nEl salón que se asignará en el bloque cuatro no está dentro de sus rangos"
	end if
	if (cupoinsc5 > limitesup5 or cupoinsc5 < limiteinf5) then
		ls_mensaje += "~nEl salón que se asignará en el bloque cinco no está dentro de sus rangos"
	end if
	for li_i = 1 to li_total_salones_por_cupo
		li_cupo = lds_total_de_salones_por_cupo.GetItemNumber(li_i, "cupo_max")
		if li_cupo<> cupoinsc1 AND li_cupo<> cupoinsc2 AND li_cupo<> cupoinsc3 AND li_cupo<> cupoinsc4&
			AND li_cupo<> cupoinsc5 then
			if lds_total_de_salones_por_cupo.GetItemNumber(li_i, "bloqueado") = 0 then ls_bloqueados = "NO"
			ls_mensaje += "~nHay "+ String(lds_total_de_salones_por_cupo.GetItemNumber(li_i, "total_salones"))+&
					" salones "+ls_bloqueados+" bloqueados con cupo de "+string(li_cupo)+" que no están siendo utilizados"
			ls_bloqueados = ""
		end if
	next
	if lds_total_de_salones_por_cupo.Find("bloqueado = 0 AND cupo_max = "+string(cupoinsc1),1,li_total_salones_por_cupo) <= 0 then
		ls_mensaje += "~nNo hay salones NO bloqueados con el cupo del bloque uno"
	end if
	if lds_total_de_salones_por_cupo.Find("bloqueado = 0 AND cupo_max = "+string(cupoinsc2),1,li_total_salones_por_cupo) <= 0 then
		ls_mensaje += "~nNo hay salones NO bloqueados con el cupo del bloque uno"
	end if
	if lds_total_de_salones_por_cupo.Find("bloqueado = 0 AND cupo_max = "+string(cupoinsc3),1,li_total_salones_por_cupo) <= 0 then
		ls_mensaje += "~nNo hay salones NO bloqueados con el cupo del bloque uno"
	end if
	if lds_total_de_salones_por_cupo.Find("bloqueado = 0 AND cupo_max = "+string(cupoinsc4),1,li_total_salones_por_cupo) <= 0 then
		ls_mensaje += "~nNo hay salones NO bloqueados con el cupo del bloque uno"
	end if
	if lds_total_de_salones_por_cupo.Find("bloqueado = 0 AND cupo_max = "+string(cupoinsc5),1,li_total_salones_por_cupo) <= 0 then
		ls_mensaje += "~nNo hay salones NO bloqueados con el cupo del bloque uno"
	end if
	
	if ls_mensaje = "" then ls_mensaje = "Revisión O.K."
	MessageBox("Resultado de la revisión de configuración",ls_mensaje,Information!)
else
	MessageBox("Atencion", "Error al consultar la configuración para asignar de salones y/o los salones", StopSign!)
end if
Destroy lds_total_de_salones_por_cupo
end event

type dw_conf_asig_salones from datawindow within w_configuracion_asignacion_salones
event actualiza ( )
integer x = 69
integer y = 96
integer width = 1947
integer height = 852
integer taborder = 10
string title = "none"
string dataobject = "d_conf_asig_salones"
boolean border = false
boolean livescroll = true
end type

event actualiza();if update()= 1 then
	commit using gtr_sce;
	MessageBox("Actualizacion Exitosa", "Se ha actualizado la configuración para asignar salones.", Information!)
else
	rollback using gtr_sce;
	MessageBox("Atencion", "NO se actualizó la configuración para asignar salones.", StopSign!)
end if
end event

event constructor;m_menugeneral.dw = this
//modify("Datawindow.print.preview = Yes")
SetTransObject(gtr_sce)
Retrieve()
end event

