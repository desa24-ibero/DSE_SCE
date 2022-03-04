$PBExportHeader$w_inscrip_posgrado.srw
forward
global type w_inscrip_posgrado from window
end type
type st_replica from statictext within w_inscrip_posgrado
end type
type dw_procedencia from datawindow within w_inscrip_posgrado
end type
type dw_domicilio from datawindow within w_inscrip_posgrado
end type
type dw_reingreso from datawindow within w_inscrip_posgrado
end type
type dw_indulto from datawindow within w_inscrip_posgrado
end type
type dw_nacimiento from datawindow within w_inscrip_posgrado
end type
type uo_nombre from uo_nombre_alumno within w_inscrip_posgrado
end type
type r_2 from rectangle within w_inscrip_posgrado
end type
type r_1 from rectangle within w_inscrip_posgrado
end type
type dw_academico from datawindow within w_inscrip_posgrado
end type
end forward

global type w_inscrip_posgrado from window
integer x = 5
integer y = 8
integer width = 3749
integer height = 3016
boolean titlebar = true
string title = "Inscripción Posgrado"
string menuname = "m_inscrip_posgrado"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean vscrollbar = true
boolean resizable = true
long backcolor = 10789024
st_replica st_replica
dw_procedencia dw_procedencia
dw_domicilio dw_domicilio
dw_reingreso dw_reingreso
dw_indulto dw_indulto
dw_nacimiento dw_nacimiento
uo_nombre uo_nombre
r_2 r_2
r_1 r_1
dw_academico dw_academico
end type
global w_inscrip_posgrado w_inscrip_posgrado

type variables
integer ii_coordinacion
DataWindowChild carr, subs
boolean ib_modificando=false
end variables

on w_inscrip_posgrado.create
if this.MenuName = "m_inscrip_posgrado" then this.MenuID = create m_inscrip_posgrado
this.st_replica=create st_replica
this.dw_procedencia=create dw_procedencia
this.dw_domicilio=create dw_domicilio
this.dw_reingreso=create dw_reingreso
this.dw_indulto=create dw_indulto
this.dw_nacimiento=create dw_nacimiento
this.uo_nombre=create uo_nombre
this.r_2=create r_2
this.r_1=create r_1
this.dw_academico=create dw_academico
this.Control[]={this.st_replica,&
this.dw_procedencia,&
this.dw_domicilio,&
this.dw_reingreso,&
this.dw_indulto,&
this.dw_nacimiento,&
this.uo_nombre,&
this.r_2,&
this.r_1,&
this.dw_academico}
end on

on w_inscrip_posgrado.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_replica)
destroy(this.dw_procedencia)
destroy(this.dw_domicilio)
destroy(this.dw_reingreso)
destroy(this.dw_indulto)
destroy(this.dw_nacimiento)
destroy(this.uo_nombre)
destroy(this.r_2)
destroy(this.r_1)
destroy(this.dw_academico)
end on

event open;String nivel,UsuarioSigla,NomDepto,fecha,mes
//g_nv_security.fnv_secure_window (this)

This.x = 1
This.y = 1

w_inscrip_posgrado.uo_nombre.em_cuenta.enabled = true

UsuarioSigla = Upper(gtr_sce.logid)
If Mid(UsuarioSigla,2,1) = "_" Then
	UsuarioSigla = Replace(UsuarioSigla, 2, 1, "-")
End if

Select cve_coordinacion,coordinacion 
Into :ii_coordinacion,:NomDepto
From coordinaciones
Where user_id = :UsuarioSigla
USING gtr_sce;

IF gtr_sce.sqlcode = 100 then
	ii_coordinacion = 0
	NomDepto = "Todos los Posgrados"
end if
if gtr_sce.sqlcode = 0 or gtr_sce.sqlcode = 100 then
	dw_academico.settransobject(gtr_sce)
		
	dw_academico.getchild("cve_carrera",carr)
	carr.settransobject(gtr_sce)
	carr.retrieve(0)

	dw_academico.getchild("cve_subsistema",subs)
	subs.settransobject(gtr_sce)
	subs.retrieve(0,0)
	
	dw_nacimiento.settransobject(gtr_sce)
	dw_reingreso.settransobject(gtr_sce)
	dw_indulto.settransobject(gtr_sce)
	dw_domicilio.settransobject(gtr_sce)
	dw_procedencia.settransobject(gtr_sce)
	
	uo_nombre.em_cuenta.text = " "
		
	title="Consulta de Datos "+NomDepto
	if ii_coordinacion <> 0 then
		setnull(nivel)
		SELECT dbo.carreras.nivel
		INTO :nivel
		FROM dbo.carreras,dbo.coordinaciones
		WHERE ( dbo.coordinaciones.cve_coordinacion = dbo.carreras.cve_coordinacion ) and
			( ( dbo.carreras.cve_coordinacion = :ii_coordinacion ) ) and
			dbo.carreras.nivel = 'P'
		USING gtr_sce;
		if isnull(nivel) then
			nivel=' '
		end if
	else
		nivel = 'P'
	end if
	if nivel='P' then
		if f_obten_periodo(gi_periodo, gi_anio, 2) = 1 then
			choose case gi_periodo
				case 0
					title="Inscripción Posgrado Primavera "+NomDepto
				case 1
					title="NO es periodo de Inscripción Posgrado "+NomDepto
				case 2
					title="Inscripción Posgrado Otoño "+NomDepto
			end choose
		else
			MessageBox("Atención","No se pudo cargar el periodo de inscripción posgrado")
			Close(this)
		end if
		if gi_periodo = 1 then
			messagebox("No es época de inscripciones de posgrado","Intente mas tarde")
		end if
//		fecha = fecha_ingles_servidor(gtr_sce)
//		gi_anio = long(mid(fecha,8,4))
//		mes = upper(mid(fecha,1,3))
//		if mes = "JAN" or mes = "NOV" or mes = "DEC" then
//			gi_periodo = 0
//			title="Inscripción Posgrado Primavera "+NomDepto
//			if mes = "NOV" or mes = "DEC" then
//				gi_anio = gi_anio + 1
//			end if
//		elseif mes = "JUN" or mes = "JUL" or mes = "AUG" then
//			gi_periodo = 2
//			title="Inscripción Posgrado Otoño "+NomDepto
//		else
//			messagebox("No es época de inscripciones de posgrado","Intente mas tarde")
//		end if
	end if	
Else
	Messagebox("Error","Al consultar la clave de la coordinacion")
	Close(This)
End if
end event

event doubleclicked;long cuentalocal
int carrera,plan,prueba,coordinacion,cuantos
int flag
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

cuentalocal = long(uo_nombre.em_cuenta.text)

  SELECT academicos.cve_carrera,   
         academicos.cve_plan  
    INTO :carrera,   
         :plan  
    FROM academicos  
   WHERE academicos.cuenta = :cuentalocal
	USING gtr_sce;

  SELECT dbo.carreras.cve_coordinacion
    INTO :coordinacion
    FROM dbo.carreras
   WHERE dbo.carreras.cve_carrera = :carrera
	USING gtr_sce;

if isvalid(dw_academico) then
	SELECT COUNT(cve_subsistema) INTO :cuantos 
	FROM subsistema  WHERE cve_carrera = :carrera AND cve_plan = :plan using gtr_sce;
	if cuantos = 0 then 
		subs.retrieve(0,0)
	else
		subs.retrieve(carrera,plan) 
	end if
	//carr.retrieve(coordinacion)
end if

dw_academico.retrieve(long(uo_nombre.em_cuenta.text))
dw_nacimiento.retrieve(long(uo_nombre.em_cuenta.text))

if dw_reingreso.retrieve(long(uo_nombre.em_cuenta.text)) = 0 then
	r_1.visible = false
	dw_reingreso.visible = false
else
	r_1.visible = true
	dw_reingreso.visible = true
end if

if dw_indulto.retrieve(long(uo_nombre.em_cuenta.text)) = 0  then
	r_2.visible = false
	dw_indulto.visible = false
else
	r_2.visible = true
	dw_indulto.visible = true
end if

if dw_domicilio.retrieve(long(uo_nombre.em_cuenta.text)) = 0 then
	dw_domicilio.visible=false
else
	dw_domicilio.visible=true
end if

if dw_procedencia.retrieve(long(uo_nombre.em_cuenta.text)) = 0 then
	dw_procedencia.visible=false
else
	dw_procedencia.visible=true
end if
end event

type st_replica from statictext within w_inscrip_posgrado
integer x = 3497
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

type dw_procedencia from datawindow within w_inscrip_posgrado
event doubleclicked pbm_dwnlbuttondblclk
event getfocus pbm_dwnsetfocus
integer x = 219
integer y = 856
integer width = 2711
integer height = 348
integer taborder = 31
string dataobject = "dw_procedencia_alumno"
boolean vscrollbar = true
boolean border = false
end type

event getfocus;m_inscrip_posgrado.dw = this
end event

type dw_domicilio from datawindow within w_inscrip_posgrado
event getfocus pbm_dwnsetfocus
event itemchanged pbm_dwnitemchange
integer x = 229
integer y = 1940
integer width = 3250
integer height = 372
integer taborder = 20
string dataobject = "dw_domicilio_alumno"
boolean border = false
end type

event getfocus;m_inscrip_posgrado.dw = this
end event

type dw_reingreso from datawindow within w_inscrip_posgrado
event dberror pbm_dwndberror
event getfocus pbm_dwnsetfocus
integer x = 233
integer y = 2348
integer width = 1751
integer height = 508
integer taborder = 50
string dataobject = "dw_forma_reingreso_alumno"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event getfocus;m_inscrip_posgrado.dw = this
end event

type dw_indulto from datawindow within w_inscrip_posgrado
event getfocus pbm_dwnsetfocus
integer x = 2053
integer y = 2348
integer width = 1381
integer height = 508
integer taborder = 60
string dataobject = "dw_indulto_alumno"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event getfocus;m_inscrip_posgrado.dw = this
end event

type dw_nacimiento from datawindow within w_inscrip_posgrado
event getfocus pbm_dwnsetfocus
event itemchanged pbm_dwnitemchange
event itemfocuschanged pbm_dwnitemchangefocus
event losefocus pbm_dwnkillfocus
integer x = 229
integer y = 428
integer width = 3250
integer height = 768
integer taborder = 30
string dataobject = "dw_naci_alumno"
boolean border = false
boolean livescroll = true
end type

event getfocus;m_inscrip_posgrado.dw = this


end event

event itemchanged;int columna
if dw_nacimiento.getcolumnname() = "fecha_nac" then
   if dw_nacimiento.getitemdatetime(dw_nacimiento.getrow(),"fecha_nac") > datetime(today(),now()) then
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

event itemfocuschanged;int columna
string c

m_inscrip_posgrado.dw = this

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

type uo_nombre from uo_nombre_alumno within w_inscrip_posgrado
integer x = 233
integer y = 32
integer width = 3241
integer height = 428
integer taborder = 10
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

event constructor;call super::constructor;m_inscrip_posgrado.objeto = this
end event

type r_2 from rectangle within w_inscrip_posgrado
long linecolor = 15793151
integer linethickness = 6
long fillcolor = 10789024
integer x = 2043
integer y = 2340
integer width = 1399
integer height = 540
end type

type r_1 from rectangle within w_inscrip_posgrado
long linecolor = 15793151
integer linethickness = 6
long fillcolor = 10789024
integer x = 229
integer y = 2340
integer width = 1769
integer height = 540
end type

type dw_academico from datawindow within w_inscrip_posgrado
integer x = 229
integer y = 1216
integer width = 3250
integer height = 728
integer taborder = 40
string dataobject = "dw_academicos_alumno_posg"
boolean border = false
end type

event getfocus;m_inscrip_posgrado.dw = this
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

