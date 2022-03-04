$PBExportHeader$w_datosgenerales.srw
$PBExportComments$Despliegue, consulta y modificación de datos generales de un alumno(Nombre,direccion,esc. proc., fec. nac., ......)
forward
global type w_datosgenerales from window
end type
type st_replica from statictext within w_datosgenerales
end type
type uo_nombre from uo_nombre_alumno within w_datosgenerales
end type
type dw_procedencia from datawindow within w_datosgenerales
end type
type dw_nacimiento from datawindow within w_datosgenerales
end type
type dw_cp from datawindow within w_datosgenerales
end type
type dw_domicilio from datawindow within w_datosgenerales
end type
end forward

global type w_datosgenerales from window
integer x = 5
integer y = 4
integer width = 3726
integer height = 2436
boolean titlebar = true
string title = "Datos Generales de Alumnos"
string menuname = "m_datos_generales"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
long backcolor = 10789024
event cutnombre ( )
st_replica st_replica
uo_nombre uo_nombre
dw_procedencia dw_procedencia
dw_nacimiento dw_nacimiento
dw_cp dw_cp
dw_domicilio dw_domicilio
end type
global w_datosgenerales w_datosgenerales

event cutnombre;m_datos_generales.dw = uo_nombre.dw_nombre_alumno
end event

on w_datosgenerales.create
if this.MenuName = "m_datos_generales" then this.MenuID = create m_datos_generales
this.st_replica=create st_replica
this.uo_nombre=create uo_nombre
this.dw_procedencia=create dw_procedencia
this.dw_nacimiento=create dw_nacimiento
this.dw_cp=create dw_cp
this.dw_domicilio=create dw_domicilio
this.Control[]={this.st_replica,&
this.uo_nombre,&
this.dw_procedencia,&
this.dw_nacimiento,&
this.dw_cp,&
this.dw_domicilio}
end on

on w_datosgenerales.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_replica)
destroy(this.uo_nombre)
destroy(this.dw_procedencia)
destroy(this.dw_nacimiento)
destroy(this.dw_cp)
destroy(this.dw_domicilio)
end on

event open;//g_nv_security.fnv_secure_window (this)

this.x = 1
this.y = 1

dw_domicilio.settransobject(gtr_sce)
dw_nacimiento.settransobject(gtr_sce)
dw_procedencia.settransobject(gtr_sce)
//dw_ingreso.settransobject(gtr_sce)
//
//dw_domicilio.insertrow(0)
//dw_nacimiento.insertrow(0)
//dw_procedencia.insertrow(0)
////dw_ingreso.insertrow(0)

uo_nombre.em_cuenta.text = " "
triggerevent(doubleclicked!)

//dw_ingreso.settaborder("cve_formaingreso",0)
//dw_ingreso.settaborder("periodo_ing",0)
//dw_ingreso.settaborder("anio_ing",0)
uo_nombre.cbx_nuevo.visible = true
uo_nombre.cbx_nuevo.enabled = true
uo_nombre.r_3.visible  = true
/**/gnv_app.inv_security.of_SetSecurity(this)

end event

event doubleclicked;int flag
flag = 0

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



if dw_domicilio.retrieve(long(uo_nombre.em_cuenta.text)) = 0 then
	dw_domicilio.insertrow(0)
	flag = flag + 1
end if	

if dw_nacimiento.retrieve(long(uo_nombre.em_cuenta.text)) = 0 then
	if dw_nacimiento.insertrow(0) > 0 then
		dw_nacimiento.modify("lugar_nac.width=887")		
	end if
	flag = flag + 1
else
	dw_nacimiento.modify("lugar_nac.width=887")		
end if	


if dw_procedencia.retrieve(long(uo_nombre.em_cuenta.text)) = 0 then
	dw_procedencia.insertrow(0) 
	flag = flag + 1
end if

//if dw_ingreso.retrieve(long(uo_nombre.em_cuenta.text)) = 0 then
//	dw_ingreso.insertrow(0)
//end if


if flag < 3  then
	uo_nombre.cbx_nuevo.text = "Modificar"	
end if

//dw_nacimiento.setitem(dw_nacimiento.getrow(),"nombre",uo_nombre.dw_nombre_alumno.getitemstring(uo_nombre.dw_nombre_alumno.getrow(),"nombre"))
//
//
//dw_nacimiento.setitem(dw_nacimiento.getrow(),"apaterno",uo_nombre.dw_nombre_alumno.getitemstring(uo_nombre.dw_nombre_alumno.getrow(),"apaterno"))
//
//dw_nacimiento.setitem(dw_nacimiento.getrow(),"amaterno",uo_nombre.dw_nombre_alumno.getitemstring(uo_nombre.dw_nombre_alumno.getrow(),"amaterno"))
end event

event closequery;//int resp
//if dw_domicilio.modifiedcount() > 0 or dw_domicilio.deletedcount() > 0 or dw_nacimiento.modifiedcount() > 0 or dw_nacimiento.deletedcount() > 0  or dw_procedencia.modifiedcount() > 0 or dw_procedencia.deletedcount() > 0  or uo_nombre.dw_nombre_alumno.modifiedcount() > 0 or uo_nombre.dw_nombre_alumno.deletedcount() > 0  then
//	resp = messagebox("Aviso","Los cambios no han sido guardados.~n¿Desea guardarlos ahora?",question!,yesnocancel!)
//	choose case resp
//		case 1 
//			m_datos_generales.m_registro.m_actualiza.triggerevent(clicked!)			
//		case 2
//			uo_nombre.dw_nombre_alumno.resetupdate()
//			dw_domicilio.resetupdate()
//			dw_nacimiento.resetupdate()
//			dw_procedencia.resetupdate()
//		case 3
//			message.returnvalue = 1 
//	end choose
//end if
end event

event activate;control_escolar.toolbarsheettitle="Datos Generales del Alumno"
end event

event close;//close(this)
end event

type st_replica from statictext within w_datosgenerales
integer x = 3470
integer y = 28
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

type uo_nombre from uo_nombre_alumno within w_datosgenerales
integer x = 192
integer y = 28
integer width = 3241
integer height = 424
integer taborder = 10
boolean enabled = true
end type

event constructor;call super::constructor;m_datos_generales.objeto = this

end event

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

type dw_procedencia from datawindow within w_datosgenerales
integer x = 219
integer y = 1312
integer width = 2711
integer height = 348
integer taborder = 50
string dataobject = "dw_procedencia_alumno"
boolean vscrollbar = true
boolean border = false
end type

event getfocus;m_datos_generales.dw = this
end event

event doubleclicked;if getcolumn() = 2 then
	busqueda("escuela")
	object.cve_escuela[row]=ok
elseif getcolumn() = 4 then
	busqueda("carrera")
	object.cve_carrera[row]=ok
end if
end event

type dw_nacimiento from datawindow within w_datosgenerales
integer x = 197
integer y = 796
integer width = 3250
integer height = 836
integer taborder = 40
string dataobject = "dw_naci_alumno"
boolean border = false
boolean livescroll = true
end type

event itemchanged;int columna
string ls_fecha_nac
date ldt_fecha_nac
datetime ldttm_fecha_nac,ldttm_fecha_nac2, ldttm_fecha_hoy
if dw_nacimiento.getcolumnname() = "fecha_nac" then
	ldttm_fecha_nac = dw_nacimiento.getitemdatetime(dw_nacimiento.getrow(),"fecha_nac")
	ls_fecha_nac = mid(data,1,pos(data," ",1))
	if not isdate(ls_fecha_nac) then
		messagebox("Aviso","La fecha de nacimiento no es valida",stopsign!)
		return 1		
	else
		ldt_fecha_nac = date(ls_fecha_nac)
		ldttm_fecha_nac = datetime(ldt_fecha_nac,now())
	end if
	ldttm_fecha_hoy = fecha_servidor(gtr_sce)
   if ldttm_fecha_nac > ldttm_fecha_hoy then
		messagebox("Aviso","La fecha no puede ser mayor que la fecha de hoy",stopsign!)
		return 1
	end if
end if

columna = getcolumn()

CHOOSE CASE COLUMNA
	CASE 2 
		modify("lugar_nac.width=887")		
	CASE 3
		modify("cve_nacion.width=887")
	CASE 5
		modify("cve_edocivil.width=535")
	CASE 6
		modify("cve_religion.width=535")
	CASE 7
		modify("cve_transp.width=645")
		modify("cve_transp.x=2538")
	CASE 8
		modify("cve_trabajo.width=887")
END CHOOSE
end event

event getfocus;m_datos_generales.dw = this


end event

event itemfocuschanged;int columna
string c

m_datos_generales.dw = this

columna = getcolumn()

CHOOSE CASE COLUMNA
	CASE 2 
		modify("cve_transp.x=2538")
		modify("lugar_nac.width=1250")
		modify("cve_nacion.width=887")
		modify("cve_edocivil.width=535")
		modify("cve_religion.width=535")
		modify("cve_transp.width=645")
		modify("cve_trabajo.width=887")
	CASE 3
		modify("cve_transp.x=2538")
		modify("cve_nacion.width=1300")
		modify("lugar_nac.width=887")
		modify("cve_edocivil.width=535")
		modify("cve_religion.width=535")
		modify("cve_transp.width=645")
		modify("cve_trabajo.width=887")
	CASE 5
		modify("cve_transp.x=2538")
		modify("lugar_nac.width=887")
		modify("cve_nacion.width=887")
		modify("cve_edocivil.width=1000")
		modify("cve_religion.width=535")
		modify("cve_transp.width=645")
		modify("cve_trabajo.width=887")		
	CASE 6
		modify("cve_transp.x=2538")
		modify("cve_religion.width=1000")
		modify("lugar_nac.width=887")
		modify("cve_nacion.width=887")
		modify("cve_edocivil.width=535")		
		modify("cve_transp.width=645")
		modify("cve_trabajo.width=887")
	CASE 7
		modify("cve_transp.width=2000")
		modify("cve_transp.x=1975")
		modify("lugar_nac.width=887")
		modify("cve_nacion.width=887")
		modify("cve_edocivil.width=535")
		modify("cve_religion.width=535")
		modify("cve_trabajo.width=887")
	CASE 8
		modify("cve_transp.x=2538")
		modify("cve_trabajo.width=1250")
		modify("lugar_nac.width=887")
		modify("cve_nacion.width=887")
		modify("cve_edocivil.width=535")
		modify("cve_religion.width=535")
		modify("cve_transp.width=645")		
	CASE ELSE
		modify("cve_transp.x=2538")
		modify("lugar_nac.width=887")
		modify("cve_nacion.width=887")
		modify("cve_edocivil.width=535")
		modify("cve_religion.width=535")
		modify("cve_transp.width=645")
		modify("cve_trabajo.width=887")
END CHOOSE
end event

event losefocus;int columna
columna = getcolumn()

CHOOSE CASE COLUMNA
	CASE 2 
		modify("lugar_nac.width=887")		
	CASE 3
		modify("cve_nacion.width=887")
	CASE 5
		modify("cve_edocivil.width=535")
	CASE 6
		modify("cve_religion.width=535")
	CASE 7
		modify("cve_transp.width=645")
		modify("cve_transp.x=2538")
	CASE 8
		modify("cve_trabajo.width=887")
END CHOOSE
end event

type dw_cp from datawindow within w_datosgenerales
event constructor pbm_constructor
event doubleclicked pbm_dwnlbuttondblclk
event getfocus pbm_dwnsetfocus
event losefocus pbm_dwnkillfocus
boolean visible = false
integer x = 530
integer y = 372
integer width = 2610
integer height = 492
integer taborder = 20
string dataobject = "dw_codigos_postales"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;hide()
settransobject(gtr_sce)
end event

event doubleclicked;if row>0 then
	dw_domicilio.object.domicilio_colonia[1]=object.colonia[row]+", "+object.ciudad[row]
	dw_domicilio.object.domicilio_cve_estado[1]=object.cve_estado[row]
	dw_domicilio.setfocus()
end if

end event

event getfocus;show()
end event

event losefocus;hide()
end event

type dw_domicilio from datawindow within w_datosgenerales
integer x = 210
integer y = 436
integer width = 3250
integer height = 364
integer taborder = 30
string dataobject = "dw_domicilio_alumno"
boolean border = false
end type

event getfocus;m_datos_generales.dw = this
end event

event itemchanged;long columna

columna = getcolumn()

if columna=6 then

	dw_cp.retrieve(data)
	if dw_cp.rowcount()>0 then
		if dw_cp.rowcount()=1 then
			object.domicilio_colonia[1]=dw_cp.object.colonia[1]+", "+dw_cp.object.ciudad[1]
			object.domicilio_cve_estado[1]=dw_cp.object.cve_estado[1]
		else
			dw_cp.setfocus()
		end if
	end if	
end if
end event

