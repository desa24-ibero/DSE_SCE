$PBExportHeader$w_horario_insc.srw
$PBExportComments$Esta ventana contiene los procesos para generar un horario de inscripción a un alumno. Juan Campos. Enero -1998.
forward
global type w_horario_insc from window
end type
type st_replica from statictext within w_horario_insc
end type
type uo_1 from uo_per_ani within w_horario_insc
end type
type dw_hist from datawindow within w_horario_insc
end type
type dw_preinsc from datawindow within w_horario_insc
end type
type cb_actualiza from commandbutton within w_horario_insc
end type
type uo_nombre from uo_nombre_alumno within w_horario_insc
end type
type dw_horario_insc from datawindow within w_horario_insc
end type
end forward

global type w_horario_insc from window
integer x = 832
integer y = 360
integer width = 3506
integer height = 1340
boolean titlebar = true
string title = "HORARIO INSCRIPCIÓN"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 27291696
st_replica st_replica
uo_1 uo_1
dw_hist dw_hist
dw_preinsc dw_preinsc
cb_actualiza cb_actualiza
uo_nombre uo_nombre
dw_horario_insc dw_horario_insc
end type
global w_horario_insc w_horario_insc

on w_horario_insc.create
this.st_replica=create st_replica
this.uo_1=create uo_1
this.dw_hist=create dw_hist
this.dw_preinsc=create dw_preinsc
this.cb_actualiza=create cb_actualiza
this.uo_nombre=create uo_nombre
this.dw_horario_insc=create dw_horario_insc
this.Control[]={this.st_replica,&
this.uo_1,&
this.dw_hist,&
this.dw_preinsc,&
this.cb_actualiza,&
this.uo_nombre,&
this.dw_horario_insc}
end on

on w_horario_insc.destroy
destroy(this.st_replica)
destroy(this.uo_1)
destroy(this.dw_hist)
destroy(this.dw_preinsc)
destroy(this.cb_actualiza)
destroy(this.uo_nombre)
destroy(this.dw_horario_insc)
end on

event open;// Juan Campos Sánchez.		Enero-1998

This.x=5
This.y=5

dw_horario_insc.InsertRow(0)
uo_nombre.em_cuenta.SetFocus()

end event

event doubleclicked;// Juan Campos Sánchez.		Enero-1998

Long Cuenta

Cuenta = long(uo_nombre.em_cuenta.text)
dw_horario_insc.Setfocus()
cb_actualiza.enabled=False
If Long(uo_nombre.em_cuenta.text) = 0 Then
	uo_nombre.em_cuenta.setfocus()
Else
	If dw_horario_insc.Retrieve(Cuenta) = 0 Then
		If Messagebox("El Alumno no tiene un horario Asignado","Desea Asignar horario",Question!,YesNo!,1) = 1 Then
			dw_horario_insc.Reset()
			dw_horario_insc.InsertRow(0)
			dw_horario_insc.setitem(dw_horario_insc.GetRow(),"cuenta",cuenta)
		End if	
	Else 		
		uo_nombre.em_cuenta.setfocus()
	End if	
End if


end event

type st_replica from statictext within w_horario_insc
integer x = 3314
integer y = 20
integer width = 110
integer height = 88
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

event constructor;n_transfiere_sybase_sql ln_transfiere_sybase_sql
ln_transfiere_sybase_sql =  create n_transfiere_sybase_sql
integer li_replica_activa, li_obten_parametros_replicacion
li_obten_parametros_replicacion = ln_transfiere_sybase_sql.of_obten_parametros_replica(li_replica_activa)
if li_replica_activa = 1 then
	THIS.text = 'A'
	THIS.BackColor =RGB(0,255,0)
else
	THIS.text = 'I'
	THIS.BackColor =RGB(255,0,0)
end if

end event

type uo_1 from uo_per_ani within w_horario_insc
integer x = 41
integer y = 468
integer taborder = 51
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type dw_hist from datawindow within w_horario_insc
boolean visible = false
integer x = 37
integer y = 800
integer width = 549
integer height = 224
integer taborder = 10
boolean enabled = false
string dataobject = "dw_hist_hor_insc"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.settransobject(gtr_sce)
end event

type dw_preinsc from datawindow within w_horario_insc
boolean visible = false
integer x = 37
integer y = 544
integer width = 549
integer height = 224
integer taborder = 20
boolean enabled = false
string dataobject = "dw_preinsc"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.settransobject(gtr_sce)
end event

type cb_actualiza from commandbutton within w_horario_insc
event key pbm_keydown
integer x = 2569
integer y = 892
integer width = 507
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualiza Horario"
end type

event key;if keydown(keyenter!) Then
	Event clicked()
End IF
end event

event clicked;// Juan Campos Sánchez.		Enero-1998.  Modificado- Mayo-1998.
 
Long		Cuenta
Integer	Row,i,Todos
Boolean  Hor_insc=False, Preinsc = False, Historic = False, lb_historico_actualizado
String	Nivel
Integer li_periodo, li_anio, li_rows
datetime ldttm_fecha_servidor

periodo_actual_mat_insc(li_periodo, li_anio, gtr_sce)

if li_periodo<> gi_periodo or li_anio<>gi_anio then
	MessageBox("Periodo Incorrecto","El periodo seleccionado no corresponde al de las materias inscritas",StopSign!)
	return
end if

uds_datastore lds_historico_reinsc_actual
lds_historico_reinsc_actual = CREATE uds_datastore 

uds_datastore Historico 
Historico = CREATE uds_datastore 

dw_horario_insc.SetItem(1,"periodo",gi_periodo)
dw_horario_insc.SetItem(1,"anio",gi_anio)
dw_horario_insc.SetItem(1,"criterio","M")

IF dw_horario_insc.Update(True,True) = 1 Then Hor_insc = True	
 
If Hor_insc Then
	Cuenta =dw_horario_insc.GetItemNumber(dw_horario_insc.GetRow(),"Cuenta") 
	IF dw_preinsc.Retrieve(Cuenta) > 0 Then
		Preinsc = True
	Else
		Row = dw_preinsc.InsertRow(0)
		dw_preinsc.SetItem(Row,"cuenta",Cuenta)
		dw_preinsc.SetItem(Row,"folio",0)
		dw_preinsc.SetItem(Row,"status",2)
		dw_preinsc.SetItem(Row,"anio",gi_anio)
		dw_preinsc.SetItem(Row,"periodo",gi_periodo)
		dw_preinsc.Accepttext()
		IF dw_preinsc.Update(True,True) = 1 Then Preinsc = True
	End if	
 End IF

If Hor_insc And Preinsc Then
	Select nivel Into :Nivel From academicos Where cuenta = :Cuenta using gtr_sce;
   If gtr_sce.sqlcode = 0 Then
		If dw_hist.Retrieve(Cuenta) > 0 Then
	      If Nivel = 'L' Then
				Historico.DataObject = "dw_hist_lic_hor_insc"
			Else
				Historico.DataObject = "dw_hist_pos_hor_insc"
			End IF	
			Historico.Settransobject(gtr_sce)
			If Historico.Retrieve(Cuenta) > 0 Then
				Todos = Historico.RowCount()
				if Todos > 0 then
					For i = 1 to Todos
						Historico.deleterow(0)
					Next	
				end if
				Historico.Accepttext()
				If Historico.Update(True,True) = 1 Then
					Historic = True
				Else
					Historic = False
				End if
			Else
				Historic = True	
			End IF	
			If Historic Then
			 if dw_hist.RowCount() > 0 then	
				For i = 1 To dw_hist.RowCount()
					Row = Historico.InsertRow(0)
					Historico.Setitem(Row,"cuenta",dw_hist.GetItemNumber(i,"cuenta"))
					Historico.Setitem(Row,"cve_mat",dw_hist.GetItemNumber(i,"cve_mat"))
					Historico.Setitem(Row,"gpo",dw_hist.GetItemString(i,"gpo"))
					Historico.Setitem(Row,"periodo",dw_hist.GetItemNumber(i,"periodo"))
					Historico.Setitem(Row,"anio",dw_hist.GetItemNumber(i,"anio"))
					Historico.Setitem(Row,"cve_carrera",dw_hist.GetItemNumber(i,"cve_carrera"))
					Historico.Setitem(Row,"cve_plan",dw_hist.GetItemNumber(i,"cve_plan"))
					Historico.Setitem(Row,"calificacion",dw_hist.GetItemString(i,"calificacion"))
					Historico.Setitem(Row,"observacion",dw_hist.GetItemNumber(i,"observacion"))					
 				Next	
				If Historico.Update(True,True) = 1 Then
					Historic = True
				Else
					Historic = False
				End if
			  end if	
			End if	
		Else
			Messagebox("Aviso","El alumno no existe en el catálogo de histórico")
			Historic = true
		End IF	
	ElseIf gtr_sce.sqlcode = 100 Then
		Messagebox("Aviso","El alumno no existe en el catalogo de académicos")
	ElseIf gtr_sce.sqlcode = -1 Then
		Messagebox("Error",gtr_sce.sqlerrtext)
	End If	
End If


lds_historico_reinsc_actual.DataObject = "d_historico_reinsc_actual"
lds_historico_reinsc_actual.SetTransObject(gtr_sce)
li_rows = lds_historico_reinsc_actual.Retrieve(Cuenta, gi_periodo, gi_anio) 
ldttm_fecha_servidor = fecha_servidor(gtr_sce)
IF li_rows > 0 Then
	Row = lds_historico_reinsc_actual.GetRow()
	lds_historico_reinsc_actual.SetItem(Row,"fecha",ldttm_fecha_servidor)	
	IF lds_historico_reinsc_actual.Update(True,True) = 1 Then lb_historico_actualizado = True
Elseif li_rows = -1 then
	MessageBox ("Error con historico actualizado", "No es posible consultar el historico actualizado", StopSign!)
	return
Else
	Row = lds_historico_reinsc_actual.InsertRow(0)
	lds_historico_reinsc_actual.SetItem(Row,"cuenta",Cuenta)
	lds_historico_reinsc_actual.SetItem(Row,"anio",gi_anio)
	lds_historico_reinsc_actual.SetItem(Row,"periodo",gi_periodo)
	lds_historico_reinsc_actual.SetItem(Row,"fecha",ldttm_fecha_servidor)	
	lds_historico_reinsc_actual.Accepttext()
	IF lds_historico_reinsc_actual.Update(True,True) = 1 Then lb_historico_actualizado = True
End if	



If Hor_insc And Preinsc And Historic And lb_historico_actualizado Then
	Commit using gtr_sce;
	
	//INICIO:Replica a Internet
	transaction ltr_web
	n_transfiere_sybase_sql ln_transfiere_sybase_sql
	ln_transfiere_sybase_sql =  create n_transfiere_sybase_sql
	string ls_classname
	long ll_cuentas[]
	integer li_replica_activa, li_obten_parametros_replicacion, li_res_actualizacion
		li_obten_parametros_replicacion = ln_transfiere_sybase_sql.of_obten_parametros_replica(li_replica_activa)
		if li_replica_activa = 1 then
			parent.st_replica.text = 'A'
			parent.st_replica.BackColor =RGB(0,255,0)
			ls_classname =	parent.ClassName()
			ll_cuentas[1] = cuenta
			li_res_actualizacion = ln_transfiere_sybase_sql.of_actualizacion_objeto_replica(ll_cuentas, ls_classname, gtr_sce, ltr_web)
		else
			parent.st_replica.text = 'I'
			parent.st_replica.BackColor =RGB(255,0,0)
		end if
	//FIN:Replica a Internet				
	
	
	Messagebox("Aviso","Los cambios fueron guardados")
Else
	Rollback using gtr_sce;
	Messagebox("Aviso","Los cambios No fueron guardados")
End if

DESTROY Historico

This.Enabled = False

end event

type uo_nombre from uo_nombre_alumno within w_horario_insc
integer x = 41
integer y = 20
integer width = 3241
integer height = 424
integer taborder = 40
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

type dw_horario_insc from datawindow within w_horario_insc
integer x = 859
integer y = 688
integer width = 1609
integer height = 512
integer taborder = 50
string dataobject = "dw_horario_insc"
boolean resizable = true
boolean livescroll = true
end type

event constructor;This.settransobject(gtr_sce)
end event

event itemchanged;// Juan Campos Sánchez.		Enero-1998

if dwo.name = "hora_entrada" or dwo.name = "lugar_fila" Then
	cb_actualiza.Enabled = True
End if
end event

