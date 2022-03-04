$PBExportHeader$w_antecedentesacademicos.srw
forward
global type w_antecedentesacademicos from window
end type
type cb_carrera from commandbutton within w_antecedentesacademicos
end type
type st_carrera from statictext within w_antecedentesacademicos
end type
type dw_antecedentesacademicos from datawindow within w_antecedentesacademicos
end type
type uo_nombrealumno from uo_nombre_alumno within w_antecedentesacademicos
end type
end forward

global type w_antecedentesacademicos from window
integer x = 832
integer y = 360
integer width = 3598
integer height = 2176
boolean titlebar = true
string title = "Antecedentes Académicos"
string menuname = "m_antecedentesacademicos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 16777215
event inicia_proceso ( )
cb_carrera cb_carrera
st_carrera st_carrera
dw_antecedentesacademicos dw_antecedentesacademicos
uo_nombrealumno uo_nombrealumno
end type
global w_antecedentesacademicos w_antecedentesacademicos

type variables

LONG il_cuenta

end variables

event inicia_proceso();long ll_cuenta
ll_cuenta = Message.LongParm
il_cuenta = ll_cuenta
cb_carrera.TRIGGEREVENT(CLICKED!)




end event

on w_antecedentesacademicos.create
if this.MenuName = "m_antecedentesacademicos" then this.MenuID = create m_antecedentesacademicos
this.cb_carrera=create cb_carrera
this.st_carrera=create st_carrera
this.dw_antecedentesacademicos=create dw_antecedentesacademicos
this.uo_nombrealumno=create uo_nombrealumno
this.Control[]={this.cb_carrera,&
this.st_carrera,&
this.dw_antecedentesacademicos,&
this.uo_nombrealumno}
end on

on w_antecedentesacademicos.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_carrera)
destroy(this.st_carrera)
destroy(this.dw_antecedentesacademicos)
destroy(this.uo_nombrealumno)
end on

event open;//Comentado para migrar sin padlock
//g_nv_security.fnv_secure_window (this)
x = 1
y = 1
end event

type cb_carrera from commandbutton within w_antecedentesacademicos
integer x = 46
integer y = 480
integer width = 370
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Sel. Carrera"
end type

event clicked;STRING ls_carrera_plan 
LONG ll_cve_carrera 
LONG ll_cve_plan
STRING ls_carrera 
uo_parametros_estudios_ant luo_parametros_estudios_ant

IF il_cuenta = 0 THEN RETURN 0

OPENWITHPARM(w_selecciona_carrera_cuenta, il_cuenta) 
luo_parametros_estudios_ant = CREATE uo_parametros_estudios_ant

luo_parametros_estudios_ant = MESSAGE.POWEROBJECTPARM 

IF NOT ISVALID(luo_parametros_estudios_ant) THEN RETURN 

ll_cve_carrera =  luo_parametros_estudios_ant.il_cve_carrera
ll_cve_plan = luo_parametros_estudios_ant.il_cve_plan
ls_carrera = luo_parametros_estudios_ant.is_carrera 

st_carrera.TEXT = STRING(ll_cve_carrera) + "-" + STRING(ll_cve_plan) + "  " + ls_carrera

STRING ls_sql 

ls_sql = " SELECT estudio_ant.cve_escuela, " + &
         " estudio_ant.periodo, " + &
         " estudio_ant.num_certificado, " + &   
         " estudio_ant.cve_doc_certificado, " + &   
         " estudio_ant.fecha, " + &   
         " estudio_ant.no_oficio, " + &   
         " estudio_ant.cve_grado, " + &   
         " estudio_ant.cuenta, " + &   
         " estudio_ant.fechaInicio, " + &   
         " estudio_ant.fechaTerminacion, " + &   
         " estudio_ant.noCedula, " + &   
         " estudio_ant.cve_carrera, " + &   
         " estudio_ant.cve_plan, " + &  
		" estudio_ant.extranjero " + &  
   " FROM estudio_ant " + &  
   " WHERE estudio_ant.cuenta = " + STRING(il_cuenta) + &
   " AND estudio_ant.cve_carrera = " + STRING(ll_cve_carrera) + &
   " AND estudio_ant.cve_plan = " + STRING(ll_cve_plan) 

dw_antecedentesacademicos.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'")
dw_antecedentesacademicos.Event carga(il_cuenta)

IF dw_antecedentesacademicos.ROWCOUNT() = 0 THEN dw_antecedentesacademicos.INSERTROW(0)

dw_antecedentesacademicos.SETITEM(1, "cve_carrera", ll_cve_carrera) 
dw_antecedentesacademicos.SETITEM(1, "cve_plan", ll_cve_plan) 
dw_antecedentesacademicos.SETITEM(1, "cuenta", il_cuenta) 







end event

type st_carrera from statictext within w_antecedentesacademicos
integer x = 457
integer y = 500
integer width = 2985
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Carrera..."
boolean focusrectangle = false
end type

type dw_antecedentesacademicos from datawindow within w_antecedentesacademicos
event type integer carga ( long al_cuenta )
event actualiza ( )
event nuevo ( )
event primero ( )
event ultimo ( )
event anterior ( )
event siguiente ( )
event borra_renglon ( )
integer x = 41
integer y = 616
integer width = 3483
integer height = 876
integer taborder = 2
string dataobject = "d_antecedentesacademicos"
boolean vscrollbar = true
boolean livescroll = true
end type

event type integer carga(long al_cuenta);THIS.SETTRANSOBJECT(gtr_sce)
return retrieve(al_cuenta)
end event

event actualiza;if Update() = 1 then
		commit using gtr_sce;
		MessageBox("Atención","Se han guardado los cambios")
else
		rollback using gtr_sce;
		MessageBox("Atención","No se han guardado los cambios")
end if
end event

event nuevo;ScrollToRow(InsertRow(0))
SetItem(GetRow(),"cuenta",long(uo_nombrealumno.em_cuenta.text))

end event

event primero;uo_nombrealumno.Event primero()
end event

event ultimo;uo_nombrealumno.Event ultimo()
end event

event anterior;uo_nombrealumno.Event anterior()
end event

event siguiente;uo_nombrealumno.Event siguiente()
end event

event borra_renglon;long ll_cuenta
int li_respuesta
ll_cuenta = long(uo_nombrealumno.em_cuenta.text)
li_respuesta = messagebox("Atención","Esta seguro de querer borrar los antecedentes académicos~r"+&
				"seleccionados del alumno "+string(ll_cuenta)+"-"+string(obten_digito(ll_cuenta))+&
				".",StopSign!,YesNo!,2)

if li_respuesta = 1 then
	deleterow(getrow())
	Event actualiza()
end if

end event

event constructor;SetTransOBJECT(gtr_sce)
m_antecedentesacademicos.dw = this
end event

event doubleclicked;//busqueda("escuela")
//object.cve_escuela[row]=ok

if dwo.name = "cve_escuela" then
	openwithparm(w_busqueda_2013,"escuela")
	object.cve_escuela[row]=ok
end if



end event

type uo_nombrealumno from uo_nombre_alumno within w_antecedentesacademicos
integer x = 27
integer y = 32
integer taborder = 1
boolean enabled = true
end type

on uo_nombrealumno.destroy
call uo_nombre_alumno::destroy
end on

