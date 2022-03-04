$PBExportHeader$w_horario_insc_2013.srw
forward
global type w_horario_insc_2013 from w_master_main
end type
type st_replica from statictext within w_horario_insc_2013
end type
type dw_horario_insc from uo_master_dw within w_horario_insc_2013
end type
type uo_1 from uo_per_ani within w_horario_insc_2013
end type
type dw_preinsc from uo_master_dw within w_horario_insc_2013
end type
type dw_hist_hor_insc from uo_master_dw within w_horario_insc_2013
end type
type uo_nombre from uo_carreras_alumno_lista within w_horario_insc_2013
end type
type r_1 from rectangle within w_horario_insc_2013
end type
end forward

global type w_horario_insc_2013 from w_master_main
integer width = 4439
integer height = 2724
string title = "Horarios Inscripción"
string menuname = "m_horario_insc_2013"
boolean clientedge = true
event double ( )
st_replica st_replica
dw_horario_insc dw_horario_insc
uo_1 uo_1
dw_preinsc dw_preinsc
dw_hist_hor_insc dw_hist_hor_insc
uo_nombre uo_nombre
r_1 r_1
end type
global w_horario_insc_2013 w_horario_insc_2013

type variables
boolean ib_modificando=false
integer ii_periodo, ii_anio
long il_cuenta
string is_nivel

end variables

forward prototypes
public function integer wf_validar ()
end prototypes

public function integer wf_validar ();Integer li_periodo, li_anio

periodo_actual_mat_insc_2013(ii_periodo, ii_anio, gtr_sce)

if ii_periodo<> gi_periodo or ii_anio<>gi_anio then
	MessageBox("Aviso","El periodo seleccionado no corresponde al de las materias inscritas",StopSign!)
	return -1
end if

return 1


end function

on w_horario_insc_2013.create
int iCurrent
call super::create
if this.MenuName = "m_horario_insc_2013" then this.MenuID = create m_horario_insc_2013
this.st_replica=create st_replica
this.dw_horario_insc=create dw_horario_insc
this.uo_1=create uo_1
this.dw_preinsc=create dw_preinsc
this.dw_hist_hor_insc=create dw_hist_hor_insc
this.uo_nombre=create uo_nombre
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_replica
this.Control[iCurrent+2]=this.dw_horario_insc
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.dw_preinsc
this.Control[iCurrent+5]=this.dw_hist_hor_insc
this.Control[iCurrent+6]=this.uo_nombre
this.Control[iCurrent+7]=this.r_1
end on

on w_horario_insc_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_replica)
destroy(this.dw_horario_insc)
destroy(this.uo_1)
destroy(this.dw_preinsc)
destroy(this.dw_hist_hor_insc)
destroy(this.uo_nombre)
destroy(this.r_1)
end on

event doubleclicked;call super::doubleclicked;long cuentalocal,ll_ren
int sub_sist

il_cuenta = long(uo_nombre.of_obten_cuenta())
ii_anio = integer(uo_1.em_ani.text)
ii_periodo = integer(uo_1.em_per.text)
is_nivel = uo_nombre.istr_carrera.str_nivel

if dw_horario_insc.retrieve(uo_nombre.of_obten_cuenta()) = 0 then
	if  Messagebox("Aviso","El Alumno no tiene un horario Asignado, ¿Desea Asignar horario?",Question!,YesNo!,1) = 1 then
		triggerevent('ue_nuevo')
	end if
end if


end event

event open;call super::open;dw_horario_insc.settransobject(gtr_sce)
dw_hist_hor_insc.settransobject(gtr_sce)
dw_preinsc.settransobject(gtr_sce)

uo_nombre.em_cuenta.text = " "
//triggerevent(doubleclicked!) 
dw_horario_insc.INSERTROW(0) 

/**/gnv_app.inv_security.of_SetSecurity(this)
end event

event ue_actualiza;call super::ue_actualiza;//Long		Cuenta
//Integer	Row,i,Todos
Boolean  Hor_insc=False, Preinsc = False, Historic = False, lb_historico_actualizado
//String	Nivel
Integer li_periodo, li_anio, li_rows,li_res,Row,i,li_replica_activa
datetime ldttm_fecha_servidor
long todos

if ib_modificando then
	li_res = wf_validar ()
	if li_res = -1 then
		rollback using gtr_sce;
		messagebox("Información","No se han guardado los cambios (Periodo Actual)")	
		return
	end if

	uds_datastore lds_historico_reinsc_actual
	lds_historico_reinsc_actual = CREATE uds_datastore 
	
	uds_datastore Historico 
	Historico = CREATE uds_datastore 
	
	dw_horario_insc.SetItem(1,"periodo",ii_periodo)
	dw_horario_insc.SetItem(1,"anio",ii_anio)
	dw_horario_insc.SetItem(1,"criterio","M")
	
	IF dw_horario_insc.Update(True,True) = 1 Then Hor_insc = True	
	 
	If Hor_insc Then
		IF dw_preinsc.Retrieve(il_Cuenta) > 0 Then
			Preinsc = True
		Else
			Row = dw_preinsc.InsertRow(0)
			dw_preinsc.SetItem(Row,"cuenta",il_Cuenta)
			dw_preinsc.SetItem(Row,"folio",0)
			dw_preinsc.SetItem(Row,"status",2)
			dw_preinsc.SetItem(Row,"anio",gi_anio)
			dw_preinsc.SetItem(Row,"periodo",gi_periodo)
			dw_preinsc.Accepttext()
			IF dw_preinsc.Update(True,True) = 1 Then Preinsc = True
		End if	
	 End IF
	
	If Hor_insc And Preinsc Then
		If dw_hist_hor_insc.Retrieve(il_Cuenta) > 0 Then
			//If is_nivel = 'L' Then
			If is_nivel <> 'P' Then
				Historico.DataObject = "dw_hist_lic_hor_insc"
			Else
				Historico.DataObject = "dw_hist_pos_hor_insc"
			End IF	
			Historico.Settransobject(gtr_sce)
			If Historico.Retrieve(il_Cuenta) > 0 Then
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
			 if dw_hist_hor_insc.RowCount() > 0 then	
				For i = 1 To dw_hist_hor_insc.RowCount()
					Row = Historico.InsertRow(0)
					Historico.Setitem(Row,"cuenta",dw_hist_hor_insc.GetItemNumber(i,"cuenta"))
					Historico.Setitem(Row,"cve_mat",dw_hist_hor_insc.GetItemNumber(i,"cve_mat"))
					Historico.Setitem(Row,"gpo",dw_hist_hor_insc.GetItemString(i,"gpo"))
					Historico.Setitem(Row,"periodo",dw_hist_hor_insc.GetItemNumber(i,"periodo"))
					Historico.Setitem(Row,"anio",dw_hist_hor_insc.GetItemNumber(i,"anio"))
					Historico.Setitem(Row,"cve_carrera",dw_hist_hor_insc.GetItemNumber(i,"cve_carrera"))
					Historico.Setitem(Row,"cve_plan",dw_hist_hor_insc.GetItemNumber(i,"cve_plan"))
					Historico.Setitem(Row,"calificacion",dw_hist_hor_insc.GetItemString(i,"calificacion"))
					Historico.Setitem(Row,"observacion",dw_hist_hor_insc.GetItemNumber(i,"observacion"))					
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
	End If
	
	
	lds_historico_reinsc_actual.DataObject = "d_historico_reinsc_actual"
	lds_historico_reinsc_actual.SetTransObject(gtr_sce)
	li_rows = lds_historico_reinsc_actual.Retrieve(il_Cuenta, gi_periodo, gi_anio) 
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
		lds_historico_reinsc_actual.SetItem(Row,"cuenta",il_Cuenta)
		lds_historico_reinsc_actual.SetItem(Row,"anio",ii_anio)
		lds_historico_reinsc_actual.SetItem(Row,"periodo",ii_periodo)
		lds_historico_reinsc_actual.SetItem(Row,"fecha",ldttm_fecha_servidor)	
		lds_historico_reinsc_actual.Accepttext()
		IF lds_historico_reinsc_actual.Update(True,True) = 1 Then lb_historico_actualizado = True
	End if	
	
	
	
	If Hor_insc And Preinsc And Historic And lb_historico_actualizado Then
		Commit using gtr_sce;
		
		//INICIO:Replica a Internet
		li_replica_activa = f_replica_Activa()
		if li_replica_activa = 1 then
			f_replica_internet(this,il_cuenta)
			st_replica.text = 'A'
			st_replica.BackColor =RGB(0,255,0)
		else
			st_replica.text = 'I'
			st_replica.BackColor =RGB(255,0,0)
		end if
		//FIN:Replica a Internet						
			
		messagebox("Información","Se han guardado los cambios")				
	else
		rollback using gtr_sce;
		messagebox("Información","No se han guardado los cambios (Paso a Histórico)")	
		return
	end if
else
	rollback using gtr_sce;
	messagebox("Información","No se han guardado los cambios (No se han modificado los datos)")	
	return
end if

end event

event activate;//
end event

event closequery;//
end event

event ue_nuevo;call super::ue_nuevo;long ll_ren

il_cuenta = long(uo_nombre.of_obten_cuenta())
ii_anio = integer(uo_1.em_ani.text)
ii_periodo = integer(uo_1.em_per.text)


ll_ren = dw_horario_insc.insertrow(0)

dw_horario_insc.Setitem(ll_ren,'periodo',ii_periodo)
dw_horario_insc.Setitem(ll_ren,'anio',ii_anio)
dw_horario_insc.Setitem(ll_ren,'cuenta',il_cuenta)


end event

event close;if ib_modificando then
	if messagebox('Aviso','¿Desea guardar los cambios?',Question!,Yesno!) = 1 then
		if wf_validar () <> 1 then 	
			rollback using gtr_sce;
			messagebox("Información","No se han guardado los cambios")	
			return 
		else
			 triggerevent("ue_actualiza")
		end if
	end if
end if
end event

type st_sistema from w_master_main`st_sistema within w_horario_insc_2013
end type

type p_ibero from w_master_main`p_ibero within w_horario_insc_2013
end type

type st_replica from statictext within w_horario_insc_2013
integer x = 3342
integer y = 328
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

event constructor;integer li_replica_activa

li_replica_activa = f_replica_Activa()

if li_replica_activa = 1 then
	THIS.text = 'A'
	THIS.BackColor =RGB(0,255,0)
else
	THIS.text = 'I'
	THIS.BackColor =RGB(255,0,0)
end if

end event

type dw_horario_insc from uo_master_dw within w_horario_insc_2013
integer x = 933
integer y = 928
integer width = 1577
integer height = 344
integer taborder = 40
string dataobject = "dw_horario_insc_2013"
boolean hscrollbar = false
boolean vscrollbar = false
end type

event itemchanged;ib_modificando = true
idw_trabajo = this

end event

event constructor;call super::constructor;idw_trabajo = this
m_horario_insc_2013.dw = this

end event

type uo_1 from uo_per_ani within w_horario_insc_2013
integer x = 2062
integer y = 116
integer width = 1253
integer height = 168
integer taborder = 40
boolean bringtotop = true
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type dw_preinsc from uo_master_dw within w_horario_insc_2013
boolean visible = false
integer x = 87
integer y = 912
integer width = 649
integer height = 344
integer taborder = 50
boolean bringtotop = true
boolean enabled = false
string dataobject = "dw_preinsc"
boolean hscrollbar = false
boolean vscrollbar = false
end type

type dw_hist_hor_insc from uo_master_dw within w_horario_insc_2013
boolean visible = false
integer x = 2642
integer y = 920
integer width = 649
integer height = 344
integer taborder = 60
boolean bringtotop = true
boolean enabled = false
string dataobject = "dw_hist_hor_insc"
boolean hscrollbar = false
boolean vscrollbar = false
end type

type uo_nombre from uo_carreras_alumno_lista within w_horario_insc_2013
event destroy ( )
integer x = 101
integer y = 356
integer width = 3241
integer height = 516
integer taborder = 20
boolean bringtotop = true
end type

on uo_nombre.destroy
call uo_carreras_alumno_lista::destroy
end on

event constructor;call super::constructor;//m_horario_insc_2013.objeto =this
end event

type r_1 from rectangle within w_horario_insc_2013
long linecolor = 128
integer linethickness = 5
long fillcolor = 16777215
integer x = 850
integer y = 904
integer width = 1746
integer height = 396
end type

