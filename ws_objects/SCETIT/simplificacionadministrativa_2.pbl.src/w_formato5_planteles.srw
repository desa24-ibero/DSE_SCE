$PBExportHeader$w_formato5_planteles.srw
forward
global type w_formato5_planteles from window
end type
type uo_nom_alu_plant from uo_nombre_alumno_plant within w_formato5_planteles
end type
type dw_formato5 from datawindow within w_formato5_planteles
end type
end forward

global type w_formato5_planteles from window
integer x = 832
integer y = 364
integer width = 3515
integer height = 1884
boolean titlebar = true
string title = "CERTIFICADO GLOBAL O REVISION DE ESTUDIOS        FORMATO 5"
string menuname = "m_simplificacionadministrativa"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 10789024
event inicia_proceso ( )
uo_nom_alu_plant uo_nom_alu_plant
dw_formato5 dw_formato5
end type
global w_formato5_planteles w_formato5_planteles

event inicia_proceso();long ll_cuenta, ll_numero, ll_numeracion
int li_tipo, li_cve_plantel, li_cve_plantel2
int li_certificado
str_cuenta_cve_plantel lstr_cuenta_cve_plantel1, lstr_cuenta_cve_plantel2

ll_cuenta = Message.LongParm
li_cve_plantel= 0
if uo_nom_alu_plant.em_cuenta.text <> " " then	
	lstr_cuenta_cve_plantel1.cuenta = ll_cuenta
	lstr_cuenta_cve_plantel1.cve_plantel= 0	
	openwithparm(w_control_sep_planteles,lstr_cuenta_cve_plantel1)
	
	lstr_cuenta_cve_plantel2 = Message.PowerObjectParm
	IF IsValid(lstr_cuenta_cve_plantel2) THEN 
		if not isnull(lstr_cuenta_cve_plantel2) then
			ll_numero =lstr_cuenta_cve_plantel2.cuenta
			li_cve_plantel2 =lstr_cuenta_cve_plantel2.cve_plantel
		end if
	END IF		
//	messagebox("",string(ll_numero))
	if ll_numero > 0 then
		dw_formato5.Event carga(ll_numero, li_cve_plantel2)
	end if
end if
end event

on w_formato5_planteles.create
if this.MenuName = "m_simplificacionadministrativa" then this.MenuID = create m_simplificacionadministrativa
this.uo_nom_alu_plant=create uo_nom_alu_plant
this.dw_formato5=create dw_formato5
this.Control[]={this.uo_nom_alu_plant,&
this.dw_formato5}
end on

on w_formato5_planteles.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nom_alu_plant)
destroy(this.dw_formato5)
end on

event open;//Comentado para migrar sin padlock
//g_nv_security.fnv_secure_window (this)
x = 1
y = 1



end event

type uo_nom_alu_plant from uo_nombre_alumno_plant within w_formato5_planteles
integer x = 59
integer y = 60
integer width = 3241
integer height = 412
integer taborder = 20
boolean enabled = true
end type

on uo_nom_alu_plant.destroy
call uo_nombre_alumno_plant::destroy
end on

type dw_formato5 from datawindow within w_formato5_planteles
event type integer nuevo ( long al_cuenta,  long al_numero,  integer ai_tipo )
event actualiza ( )
event type integer carga ( long al_numero,  integer ai_cve_plantel )
integer x = 69
integer y = 508
integer width = 3369
integer height = 1160
integer taborder = 10
string dataobject = "d_formato5_planteles_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event nuevo;int li_ciclos_cursados
DataStore lds_carreraalumno
lds_carreraalumno = Create DataStore
lds_carreraalumno.DataObject = "d_carreraalumno"
lds_carreraalumno.SetTrans(gtr_sce)
lds_carreraalumno.retrieve(al_cuenta)
if lds_carreraalumno.RowCount() = 1 then
	ScrollToRow(insertrow(0))
	SetItem(GetRow(),"control_sep_numero",al_numero)
	SetItem(GetRow(),"control_sep_cuenta",al_cuenta)
	SetItem(GetRow(),"control_sep_fecha_emision",Today())
	SetItem(GetRow(),"control_sep_cve_carrera",lds_carreraalumno.getitemnumber(1,"academicos_cve_carrera"))
	SetItem(GetRow(),"control_sep_cve_plan",lds_carreraalumno.getitemnumber(1,"academicos_cve_plan"))
	li_ciclos_cursados = obten_ciclos(al_cuenta,&
								lds_carreraalumno.getitemnumber(1,"academicos_cve_carrera"),&
								lds_carreraalumno.getitemnumber(1,"academicos_cve_plan"),&
								lds_carreraalumno.getitemnumber(1,"academicos_cve_subsistema"))
	SetItem(GetRow(),"control_sep_ciclos_cursados",li_ciclos_cursados)
	SetItem(GetRow(),"control_sep_cve_doc_control_sep",ai_tipo)
	Event Actualiza()	
else
	Messagebox("Error", "Error al consultar la carrera del alumno")
end if
Destroy lds_carreraalumno
return 0
end event

event actualiza;if Update() = 1 then
		commit using gtr_sce;
		MessageBox("Atención","Se han guardado los cambios")
else
		rollback using gtr_sce;
		MessageBox("Atención","No se han guardado los cambios")
end if
end event

event carga;return retrieve(al_numero,ai_cve_plantel)
end event

event constructor;SetTrans(gtr_sce)
m_simplificacionadministrativa.dw = this
end event

