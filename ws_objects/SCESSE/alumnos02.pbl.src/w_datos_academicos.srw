$PBExportHeader$w_datos_academicos.srw
$PBExportComments$Despliegue de datos academicos de un alumno (Carrera, Semestre, Subsistema, Fecha de Ingreso, Fecha de Egreso,.....)
forward
global type w_datos_academicos from window
end type
type st_replica from statictext within w_datos_academicos
end type
type dw_indulto from datawindow within w_datos_academicos
end type
type uo_nombre from uo_nombre_alumno within w_datos_academicos
end type
type r_1 from rectangle within w_datos_academicos
end type
type r_2 from rectangle within w_datos_academicos
end type
type dw_academico from datawindow within w_datos_academicos
end type
type dw_reingreso from datawindow within w_datos_academicos
end type
end forward

global type w_datos_academicos from window
integer x = 5
integer y = 4
integer width = 3735
integer height = 2156
boolean titlebar = true
string title = "Datos Academicos del Alumno"
string menuname = "m_datos_academicos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
long backcolor = 10789024
st_replica st_replica
dw_indulto dw_indulto
uo_nombre uo_nombre
r_1 r_1
r_2 r_2
dw_academico dw_academico
dw_reingreso dw_reingreso
end type
global w_datos_academicos w_datos_academicos

type variables
boolean ib_modificando=false
end variables

on w_datos_academicos.create
if this.MenuName = "m_datos_academicos" then this.MenuID = create m_datos_academicos
this.st_replica=create st_replica
this.dw_indulto=create dw_indulto
this.uo_nombre=create uo_nombre
this.r_1=create r_1
this.r_2=create r_2
this.dw_academico=create dw_academico
this.dw_reingreso=create dw_reingreso
this.Control[]={this.st_replica,&
this.dw_indulto,&
this.uo_nombre,&
this.r_1,&
this.r_2,&
this.dw_academico,&
this.dw_reingreso}
end on

on w_datos_academicos.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_replica)
destroy(this.dw_indulto)
destroy(this.uo_nombre)
destroy(this.r_1)
destroy(this.r_2)
destroy(this.dw_academico)
destroy(this.dw_reingreso)
end on

event open;//g_nv_security.fnv_secure_window (this)

this.x = 1
this.y = 1



dw_academico.settransobject(gtr_sce)

dw_reingreso.settransobject(gtr_sce)
dw_indulto.settransobject(gtr_sce)
//dw_academico.object.cve_subsistema.dddw.settransobject(gtr_sce)
uo_nombre.em_cuenta.text = " "
triggerevent(doubleclicked!) 
/**/gnv_app.inv_security.of_SetSecurity(this)
//if dw_academico.rowcount() = 0 then
//	dw_academico.insertrow(0)
//end if
//if dw_ingreso.rowcount() = 0 then
//	dw_ingreso.insertrow(0)
//end if
//dw_reingreso.insertrow(0)
//dw_indulto.insertrow(0)


end event

event doubleclicked;long cuentalocal
int carrera,plan
//char nivel

long ll_row, ll_cuenta

ll_row = uo_nombre.dw_nombre_alumno.GetRow()
ll_cuenta = uo_nombre.dw_nombre_alumno.GetItemNumber(ll_row, "cuenta")

if f_alumno_restringido (ll_cuenta) then
	if f_usuario_especial(gs_usuario) then
		MessageBox("Usuario  Autorizado", &
		"Alumno con acceso restringido",Information!)		
	else
		MessageBox("Usuario NO Autorizado", &
	           "Alumno con acceso restringido, por favor consulte a la ~n"+ &
				 +"Dirección de Servicios Escolares",StopSign!)
		uo_nombre.dw_nombre_alumno.Reset()	
		uo_nombre.dw_nombre_alumno.insertrow(0)
		uo_nombre.em_digito.text=" "
		uo_nombre.em_cuenta.text = " "
		uo_nombre.em_cuenta.setfocus()
		return		
	end if
end if


Datawindowchild subsis

dw_academico.getchild('cve_subsistema',subsis)

subsis.settransobject(gtr_sce)

dw_reingreso.visible = true
dw_indulto.visible = true
r_1.visible = true
r_2.visible = true

cuentalocal = long(uo_nombre.em_cuenta.text)
//
//  SELECT academicos.nivel  
//    INTO :nivel  
//    FROM academicos  
//   WHERE academicos.cuenta = :cuentalocal    using gtr_sce;
//
//
//  SELECT academicos.cve_carrera,   
//         academicos.cve_plan  
//    INTO :carrera,   
//         :plan  
//    FROM academicos  
//   WHERE academicos.cuenta = :cuentalocal using gtr_sce;

int cuantos

if isvalid(dw_academico) then
	setnull(cuantos)
	SELECT  s.cve_subsistema, a.cve_carrera, a.cve_plan 
	INTO :cuantos, :carrera, :plan
	FROM dbo.academicos a  LEFT JOIN dbo.subsistema s ON a.cve_carrera = s.cve_carrera AND a.cve_plan = s.cve_plan
	WHERE a.cuenta = :cuentalocal using gtr_sce;
	
	if isnull(cuantos) then 
		subsis.retrieve(0,0)
	else
		subsis.retrieve(carrera,plan) 
	end if
end if
//if isvalid(dw_academico) then
	//if nivel = 'L' then
	//   	if subsis.retrieve(carrera,plan) = -1 then  subsis.retrieve(0,0)
	//	else
	//		subsis.retrieve(145,3)
	//	end if
//end if




if dw_academico.retrieve(long(uo_nombre.em_cuenta.text)) = 0 then
	dw_academico.insertrow(0)
end if



if dw_reingreso.retrieve(long(uo_nombre.em_cuenta.text)) = 0 then
	r_1.visible = false
	dw_reingreso.visible = false
end if

if dw_indulto.retrieve(long(uo_nombre.em_cuenta.text)) = 0  then
	r_2.visible = false
	dw_indulto.visible = false
end if



end event

event closequery;//int resp
//if dw_reingreso.modifiedcount() > 0 or dw_reingreso.deletedcount() > 0 or dw_indulto.modifiedcount() > 0 or dw_indulto.deletedcount() > 0 or dw_academico.modifiedcount() > 0 or dw_academico.deletedcount() > 0 then
//	resp = messagebox("Aviso","Los cambios no han sido guardados.~n¿Desea guardarlos ahora?",question!,yesnocancel!)
//	choose case resp
//		case 1 
//			m_datos_academicos.m_registro.m_actualiza.triggerevent(clicked!)			
//		case 2
//			dw_indulto.resetupdate()
//			dw_reingreso.resetupdate()
//			dw_academico.resetupdate()
//			
//		case 3
//			message.returnvalue = 1 
//	end choose
//end if
end event

event activate;//control_escolar.toolbarsheettitle="Datos Academicos"
end event

event close;//close(this)
end event

type st_replica from statictext within w_datos_academicos
integer x = 3493
integer y = 32
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

type dw_indulto from datawindow within w_datos_academicos
integer x = 2057
integer y = 1360
integer width = 1381
integer height = 508
integer taborder = 40
string dataobject = "dw_indulto_alumno"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event getfocus;m_datos_academicos.dw = this
end event

type uo_nombre from uo_nombre_alumno within w_datos_academicos
integer x = 233
integer y = 32
integer width = 3241
integer height = 424
integer taborder = 10
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

event constructor;call super::constructor;m_datos_academicos.objeto = this
end event

type r_1 from rectangle within w_datos_academicos
long linecolor = 15793151
integer linethickness = 4
long fillcolor = 10789024
integer x = 256
integer y = 1340
integer width = 1769
integer height = 540
end type

type r_2 from rectangle within w_datos_academicos
long linecolor = 15793151
integer linethickness = 4
long fillcolor = 10789024
integer x = 2048
integer y = 1340
integer width = 1399
integer height = 540
end type

type dw_academico from datawindow within w_datos_academicos
integer x = 233
integer y = 444
integer width = 3250
integer height = 892
integer taborder = 20
string dataobject = "dw_academicos_alumno"
boolean border = false
end type

event getfocus;m_datos_academicos.dw = this
end event

event itemchanged;
string ls_nivel, ls_columna, ls_cve_carrera
long ll_cve_carrera, ll_row
integer li_cve_plan

ll_row = this.GetRow()

if ib_modificando then
	return
end if

ib_modificando = true

this.AcceptText()

//ls_columna =dwo.name

ls_columna =this.GetColumnName()

ll_cve_carrera = object.cve_carrera[ll_row]
ls_cve_carrera = string(ll_cve_carrera)
li_cve_plan = object.cve_plan[ll_row]

choose case ls_columna 
case 'cve_carrera' 	
	ls_nivel = f_obten_nivel(ll_cve_carrera)	
	object.nivel[ll_row]=ls_nivel
case 'cve_plan' 
	if isnull(ll_cve_carrera) or (ll_cve_carrera= 0) then
		ll_cve_carrera= 0
		MessageBox("Captura previa requerida","Favor de Capturar la carrera")
		this.SetColumn("cve_carrera")
		ib_modificando = false
		return 2
	elseif not f_plan_activo(ll_cve_carrera, li_cve_plan) then
		MessageBox("Plan Inactivo","La carrera: ["+ls_cve_carrera+"] con el plan: ["+string(li_cve_plan)+ "] no estan activos ")	
		ib_modificando = false
		return 2		
	end if
end choose

ib_modificando = false

end event

type dw_reingreso from datawindow within w_datos_academicos
integer x = 261
integer y = 1360
integer width = 1751
integer height = 508
integer taborder = 30
string dataobject = "dw_forma_reingreso_alumno"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event getfocus;m_datos_academicos.dw = this
end event

event dberror;messagebox("error",string(sqldbcode) +sqlerrtext + sqlsyntax)
end event

