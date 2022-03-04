$PBExportHeader$w_inscrip_posgrado_2013.srw
forward
global type w_inscrip_posgrado_2013 from w_master_main
end type
type st_replica from statictext within w_inscrip_posgrado_2013
end type
type dw_indulto from uo_master_dw within w_inscrip_posgrado_2013
end type
type dw_reingreso from uo_master_dw within w_inscrip_posgrado_2013
end type
type dw_procedencia from uo_master_dw within w_inscrip_posgrado_2013
end type
type dw_nacimiento from uo_master_dw within w_inscrip_posgrado_2013
end type
type dw_domicilio from uo_master_dw within w_inscrip_posgrado_2013
end type
type r_2 from rectangle within w_inscrip_posgrado_2013
end type
type r_1 from rectangle within w_inscrip_posgrado_2013
end type
type uo_nombre from uo_nombre_alumno_2013 within w_inscrip_posgrado_2013
end type
type dw_academico from uo_master_dw within w_inscrip_posgrado_2013
end type
end forward

global type w_inscrip_posgrado_2013 from w_master_main
integer width = 3410
integer height = 2748
string title = "Inscripción Posgrado"
string menuname = "m_menu_general_2013"
st_replica st_replica
dw_indulto dw_indulto
dw_reingreso dw_reingreso
dw_procedencia dw_procedencia
dw_nacimiento dw_nacimiento
dw_domicilio dw_domicilio
r_2 r_2
r_1 r_1
uo_nombre uo_nombre
dw_academico dw_academico
end type
global w_inscrip_posgrado_2013 w_inscrip_posgrado_2013

type variables
datawindowchild idwc_cp
boolean ib_modificando=false
Datawindowchild dwc_subsis,dwc_carrera,dwc_plan, dwc_periodo
integer ii_periodo, ii_anio,ii_sw
integer ii_coordinacion
end variables

forward prototypes
public function integer wf_validar ()
end prototypes

public function integer wf_validar ();string nombre,apaterno,amaterno,ls_nivel
long cuenta, cuento,coordinacion,carrera


cuenta =uo_nombre.of_obten_cuenta()
nombre = string(uo_nombre.of_obten_nombre())

apaterno = string(uo_nombre.of_obten_apaterno())
	
amaterno = string(uo_nombre.of_obten_amaterno())

nombre="%"+quita_espacios(apaterno)+"%"+quita_espacios(amaterno)+"%"+quita_espacios(nombre)+"%"

setnull(cuento)
SELECT dbo.alumnos.cuenta
	INTO :cuento  
FROM dbo.alumnos  
WHERE dbo.alumnos.nombre_completo like :nombre
USING gtr_sce;

if gtr_sce.sqlcode = 100 or isnull(cuento) then
	cuento = cuenta
end if
if cuento<>cuenta then
	messagebox("Cuenta: "+string(cuento)+'-'+string(obten_digito(cuento)), &
		"Ese nombre ya existe, Verificar con Servicios Escolares")
	return -1
end if

if dw_academico.Rowcount() > 0 then
	if dw_academico.Getitemnumber(1,'periodo_ing') = 1 then
		IF messagebox('Aviso','El periodo seleccionado es "VERANO", ¿desea continuar?',Question!,Yesno!) = 2 then
			return -1
		end if
	end if
	
	carrera=dw_academico.object.cve_carrera[1]
	if ii_coordinacion <> 0 then
		SELECT dbo.carreras.cve_coordinacion
			INTO :coordinacion
		FROM dbo.carreras
		WHERE dbo.carreras.cve_carrera = :carrera
		USING gtr_sce;
	
		if coordinacion<>ii_coordinacion then
			messagebox("Solo puede editar","alumnos de su Coordinación")
			uo_nombre.em_cuenta.enabled = true
			return -1
		end if
	else
		SELECT dbo.carreras.nivel
		INTO :ls_nivel
		FROM dbo.carreras
		WHERE dbo.carreras.cve_carrera = :carrera
		USING gtr_sce;
		if ls_nivel<>'P' then
			messagebox('Aviso',"Solo puede seleccionar carreras de Posgrado")
			uo_nombre.em_cuenta.enabled = true
			return -1
		end if
	end if
	
	if dw_academico.object.periodo_ing[1]<>gi_periodo or &
		dw_academico.object.anio_ing[1]<>gi_anio or &
		dw_academico.object.cve_formaingreso[1]<>8 then
			messagebox("Solo puedes cambiar los datos","de los alumnos de primer ingreso.")
		uo_nombre.em_cuenta.enabled = true
		return -1
	end if
end if

return 1
end function

on w_inscrip_posgrado_2013.create
int iCurrent
call super::create
if this.MenuName = "m_menu_general_2013" then this.MenuID = create m_menu_general_2013
this.st_replica=create st_replica
this.dw_indulto=create dw_indulto
this.dw_reingreso=create dw_reingreso
this.dw_procedencia=create dw_procedencia
this.dw_nacimiento=create dw_nacimiento
this.dw_domicilio=create dw_domicilio
this.r_2=create r_2
this.r_1=create r_1
this.uo_nombre=create uo_nombre
this.dw_academico=create dw_academico
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_replica
this.Control[iCurrent+2]=this.dw_indulto
this.Control[iCurrent+3]=this.dw_reingreso
this.Control[iCurrent+4]=this.dw_procedencia
this.Control[iCurrent+5]=this.dw_nacimiento
this.Control[iCurrent+6]=this.dw_domicilio
this.Control[iCurrent+7]=this.r_2
this.Control[iCurrent+8]=this.r_1
this.Control[iCurrent+9]=this.uo_nombre
this.Control[iCurrent+10]=this.dw_academico
end on

on w_inscrip_posgrado_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_replica)
destroy(this.dw_indulto)
destroy(this.dw_reingreso)
destroy(this.dw_procedencia)
destroy(this.dw_nacimiento)
destroy(this.dw_domicilio)
destroy(this.r_2)
destroy(this.r_1)
destroy(this.uo_nombre)
destroy(this.dw_academico)
end on

event open;call super::open;String nivel,UsuarioSigla,NomDepto,fecha,mes, ls_desc_periodo

uo_periodo_servicios	luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios

m_menu_general_2013.m_registro.m_borraregistro.enabled = False

uo_nombre.em_cuenta.enabled = true

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
	dw_reingreso.settransobject(gtr_sce)
	dw_indulto.settransobject(gtr_sce)
	dw_domicilio.settransobject(gtr_sce)
	dw_nacimiento.settransobject(gtr_sce)
	dw_procedencia.settransobject(gtr_sce)
	dw_domicilio.Getchild('cod_postal',idwc_cp)
	idwc_cp.settransobject(gtr_sce)
	idwc_cp.retrieve()
	
	
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
//		if f_obten_periodo(gi_periodo, gi_anio, 2, gs_tipo_periodo) = 1 then
		if f_obten_periodo(gi_periodo, gi_anio, 2) = 1 then
		   // MALH 31/08/2017 Cambio para Chalco
		   //if gs_tipo_periodo='S' then
			choose case gi_periodo
				case 1
					title="No es periodo de inscripción posgrado "+NomDepto
				case else
					// MALH 31/08/2017 Cambio para Chalco
					// Se adecua logica para poder incluir los periodos para Chalco
					ls_desc_periodo = luo_periodo_servicios.f_recupera_desc_periodo(gtr_sce, gi_periodo)
					
					IF luo_periodo_servicios.ierror = -1 THEN 
						MessageBox(luo_periodo_servicios.ititulo, luo_periodo_servicios.imensaje, StopSign!)
						RETURN luo_periodo_servicios.ierror 
					END IF	
					
					title="Inscripción posgrado " + Lower(ls_desc_periodo) + " " + NomDepto
// MALH 31/08/2017 Cambio para Chalco
//				case 0
//					title="Inscripción Posgrado Primavera "+NomDepto
//				case 2
//					title="Inscripción Posgrado Otoño "+NomDepto
			end choose
// MALH 31/08/2017 Cambio para Chalco			
//		  elseif gs_tipo_periodo='T' then
//			  title="Inscripción Posgrado "+f_obten_descipcion_periodo(gi_periodo,"L")+" "+NomDepto
//		  end if
		else
			MessageBox("Atención","No se pudo cargar el periodo de inscripción posgrado")
			return
		end if
		if gi_periodo = 1 then
			messagebox("No es época de inscripciones de posgrado","Intente mas tarde")
			return
		end if
	end if	

	triggerevent(doubleclicked!)
	
	/**/gnv_app.inv_security.of_SetSecurity(this)
Else
	Messagebox("Error","Al consultar la clave de la coordinacion")
	return
End if

end event

event closequery;//
end event

event doubleclicked;call super::doubleclicked;int flag
flag = 0

long  ll_cuenta
long cuentalocal
int carrera,plan

ll_cuenta = uo_nombre.of_obten_cuenta()

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

//Modif. Roberto Novoa May/2016 .- Funcionalidad periodos multiples
f_dddw_converter(dw_academico, dwc_periodo, "periodo_ing")
f_dddw_converter(dw_academico, dwc_periodo, "periodo_egre")


/*
dw_academico.modify("periodo_ing.dddw.name=d_lista_peroidos")
dw_academico.modify("periodo_ing.dddw.displaycolumn=descripcion")
dw_academico.modify("periodo_ing.dddw.datacolumn=periodo")
dw_academico.modify("periodo_ing.dddw.percentwidth=0")

dw_academico.modify("periodo_egre.dddw.name=d_lista_peroidos")
dw_academico.modify("periodo_egre.dddw.displaycolumn=descripcion")
dw_academico.modify("periodo_egre.dddw.datacolumn=periodo")
dw_academico.modify("periodo_egre.dddw.percentwidth=0")

dw_academico.Getchild('periodo_ing',dwc_periodo)
dwc_periodo.settransobject(gtr_sce)
dwc_periodo.retrieve(gs_tipo_periodo)

dw_academico.Getchild('periodo_egre',dwc_periodo)
dwc_periodo.settransobject(gtr_sce)
dwc_periodo.retrieve(gs_tipo_periodo)

dw_academico.modify("periodo_ing.dddw.lines=0")
dw_academico.modify("periodo_ing.dddw.limit=0")
dw_academico.modify("periodo_ing.dddw.allowedit=no")
dw_academico.modify("periodo_ing.dddw.useasborder=yes")
dw_academico.modify("periodo_ing.dddw.case=any")
*/


dw_academico.getchild('cve_carrera',dwc_carrera)
dwc_carrera.settransobject(gtr_sce)
dw_academico.getchild('cve_plan',dwc_plan)
dwc_plan.settransobject(gtr_sce)
dw_academico.getchild('cve_subsistema',dwc_subsis)
dwc_subsis.settransobject(gtr_sce)

dw_reingreso.visible = true
dw_indulto.visible = true
r_1.visible = true
r_2.visible = true

cuentalocal = uo_nombre.of_obten_cuenta()
//long(uo_nombre.em_cuenta.text)

int cuantos

//BEVM 19/06/2013 Se hizo el cambio para que recuperara solo los planes de una carrera en especifico
dwc_carrera.retrieve()

if isvalid(dw_academico) then
	setnull(cuantos)
	SELECT  s.cve_subsistema, a.cve_carrera, a.cve_plan INTO :cuantos, :carrera, :plan
	FROM dbo.academicos a  LEFT JOIN dbo.subsistema s ON a.cve_carrera = s.cve_carrera AND a.cve_plan = s.cve_plan
	WHERE a.cuenta = :cuentalocal using gtr_sce;
	if isnull(cuantos) then 
		dwc_subsis.retrieve(0,0)
	end if
	if isnull(carrera)  then
		dwc_plan.Retrieve(0)
		dwc_subsis.retrieve(0,0)
	else 
		dwc_plan.Retrieve(carrera)
		dwc_subsis.retrieve(carrera,plan)
	end if
end if

if dw_academico.retrieve(uo_nombre.of_obten_cuenta()) = 0 then
	dw_academico.insertrow(0)
end if

if dwc_plan.rowcount() = 0 then
	dwc_plan.Insertrow(0)
	dwc_plan.Setitem(1,'cve_plan', 0)
	dwc_plan.Setitem(1,'nombre_plan', 'SIN PLAN')
end if
if dwc_subsis.rowcount() = 0 then
	dwc_subsis.Insertrow(0)
	dwc_subsis.Setitem(1,'cve_subsistema', 0)
	dwc_subsis.Setitem(1,'subsistema', 'SIN SUBSISTEMA')
end if

if dw_reingreso.retrieve(uo_nombre.of_obten_cuenta()) = 0 then
	r_1.visible = false
	dw_reingreso.visible = false
end if

if dw_indulto.retrieve(uo_nombre.of_obten_cuenta()) = 0  then
	r_2.visible = false
	dw_indulto.visible = false
end if

if dw_domicilio.retrieve( uo_nombre.of_obten_cuenta()) = 0 then
	dw_domicilio.insertrow(0)
	flag = flag + 1
end if	

if dw_nacimiento.retrieve( uo_nombre.of_obten_cuenta()) = 0 then
	if dw_nacimiento.insertrow(0) > 0 then
//		dw_nacimiento.modify("lugar_nac.width=887")		
	end if
	flag = flag + 1
//else
//	dw_nacimiento.modify("lugar_nac.width=887")		
end if	

if dw_procedencia.retrieve( uo_nombre.of_obten_cuenta()) = 0 then
	dw_procedencia.insertrow(0) 
	flag = flag + 1
end if

if flag < 3  then
	uo_nombre.cbx_nuevo.text = "Modificar"	
end if


end event

event ue_actualiza;call super::ue_actualiza;long cuenta, cuenta1
string nombre,apaterno,amaterno
string nombre1,apaterno1,amaterno1
int RenglonNac, RenglonNombre, li_res,li_replica_activa


li_res = wf_validar ()
if li_res = -1 then
	rollback using gtr_sce;
	messagebox("Información","No se han guardado los cambios")	
	triggerevent(doubleclicked!)
	return
end if
uo_nombre.em_cuenta.enabled = true
cuenta =uo_nombre.of_obten_cuenta()

uo_nombre.dw_nombre_alumno.accepttext()

//dw_domicilio.setitem(dw_domicilio.getrow(),"cuenta",cuenta)
//dw_procedencia.setitem(dw_procedencia.getrow(),"cuenta",cuenta)
//
RenglonNac = 1
RenglonNombre = 1
	
cuenta1 = dw_nacimiento.getitemnumber(RenglonNac,"cuenta")
if cuenta <> cuenta1 or isnull(cuenta1) then dw_nacimiento.setitem(RenglonNac,"cuenta",cuenta)
	
nombre = string(uo_nombre.of_obten_nombre())
nombre1 = dw_nacimiento.getitemstring(RenglonNac,"nombre")
if nombre <> nombre1 or isnull(nombre1) then dw_nacimiento.setitem(RenglonNac,"nombre",nombre)

apaterno = string(uo_nombre.of_obten_apaterno())
apaterno1 = dw_nacimiento.getitemstring(RenglonNac,"apaterno")
if apaterno <> apaterno1 or isnull(apaterno1) then	dw_nacimiento.setitem(RenglonNac,"apaterno",apaterno)
	
amaterno = string(uo_nombre.of_obten_amaterno())
amaterno1 = dw_nacimiento.getitemstring(RenglonNac,"amaterno")
if amaterno <> amaterno1 or isnull(apaterno1) then	dw_nacimiento.setitem(RenglonNac,"amaterno",amaterno)

nombre="%"+quita_espacios(apaterno)+"%"+quita_espacios(amaterno)+"%"+quita_espacios(nombre)+"%"


if dw_nacimiento.update(true) > 0 then
	commit using gtr_sce;
	if dw_academico.rowcount() = 0 then
		dw_academico.retrieve(cuenta)
		dw_academico.object.cve_formaingreso[1]=8
		dw_academico.object.periodo_ing[1]=gi_periodo
		dw_academico.object.anio_ing[1]=gi_anio
		dw_academico.object.nivel[1]='P'
		dw_academico.accepttext()
	end if
	if dw_academico.update(true) > 0 then
		commit using gtr_sce;			
				
		//INICIO:Replica a Internet
		li_replica_activa = f_replica_Activa()
		if li_replica_activa = 1 then
			f_replica_internet(this,cuenta)
			st_replica.text = 'A'
			st_replica.BackColor =RGB(0,255,0)
		else
			st_replica.text = 'I'
			st_replica.BackColor =RGB(255,0,0)
		end if
		//FIN:Replica a Internet				
			
		messagebox("Información","Se han guardado los cambios")	
		triggerevent(doubleclicked!)
	else
		rollback using gtr_sce;
		messagebox("Información","No se han guardado los cambios",stopsign!)
		return
	end if
else
	rollback using gtr_sce;					
	messagebox("Información","No se han guardado los cambios")	
	return
end if
end event

event ue_nuevo;call super::ue_nuevo;long cuenta
string fecha,mes,nivel
int coordinacion

coordinacion=ii_coordinacion
if coordinacion <> 0 then
	setnull(nivel)
	SELECT carreras.nivel
	INTO :nivel
	FROM carreras,coordinaciones
	WHERE ( coordinaciones.cve_coordinacion = carreras.cve_coordinacion ) and
		( ( carreras.cve_coordinacion = :coordinacion ) ) and
		carreras.nivel = 'P'
	USING gtr_sce;
	if isnull(nivel) then
		nivel=' '
	end if
else
	nivel = 'P'
end if
	
if nivel<>'P' then
	messagebox("Sólo pueden dar de alta","los coordinadores de posgrado.")
	return
end if

fecha = fecha_ingles_servidor(gtr_sce)
gi_anio = long(mid(fecha,8,4))
mes = upper(mid(fecha,1,3))
if f_obten_periodo(gi_periodo, gi_anio, 2) = 1 then
else
	MessageBox("Atención","No se pudo cargar el periodo de inscripción posgrado")
	return
end if
if gi_periodo = 1 then
	messagebox("No es época de inscripciones de posgrado","Intente mas tarde")
	return
end if

SELECT min(cuentas_disponibles.cuenta)
INTO :cuenta
FROM cuentas_disponibles
USING gtr_sce;

if isnull(cuenta) then
	cuenta=0
end if
	
if cuenta = 0 or gtr_sce.sqlcode = 100 then
	messagebox("No hay números de cuenta disponibles","Consúlte a Servicios Escolares")
	return
end if

uo_nombre.cbx_nuevo.text = "Nuevo"

uo_nombre.em_digito.text = ''
uo_nombre.em_cuenta.text = ''
uo_nombre.cbx_nuevo.checked = true
	
uo_nombre.dw_nombre_alumno.reset()
dw_academico.reset()
dw_domicilio.reset()
dw_nacimiento.reset()
dw_indulto.reset()
dw_procedencia.reset()
dw_reingreso.reset()	

uo_nombre.dw_nombre_alumno.insertrow(uo_nombre.dw_nombre_alumno.getrow())
dw_nacimiento.insertrow(dw_academico.getrow())
uo_nombre.dw_nombre_alumno.setfocus()

uo_nombre.em_cuenta.text = string(cuenta)	
uo_nombre.em_digito.text = obten_digito(cuenta)
uo_nombre.em_cuenta.enabled = false
uo_nombre.dw_nombre_alumno.setfocus()
end event

event activate;//
end event

type st_sistema from w_master_main`st_sistema within w_inscrip_posgrado_2013
end type

type p_ibero from w_master_main`p_ibero within w_inscrip_posgrado_2013
end type

type st_replica from statictext within w_inscrip_posgrado_2013
integer x = 3278
integer y = 300
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

type dw_indulto from uo_master_dw within w_inscrip_posgrado_2013
integer x = 1838
integer y = 2100
integer width = 1381
integer height = 308
integer taborder = 50
boolean enabled = false
string dataobject = "dw_indulto_alumno_2013"
boolean hscrollbar = false
boolean vscrollbar = false
end type

type dw_reingreso from uo_master_dw within w_inscrip_posgrado_2013
integer x = 41
integer y = 2096
integer width = 1765
integer height = 308
integer taborder = 30
boolean enabled = false
string dataobject = "dw_forma_reingreso_alumno_2013"
boolean hscrollbar = false
boolean vscrollbar = false
end type

event dberror;call super::dberror;messagebox("error",string(sqldbcode) +sqlerrtext + sqlsyntax)
end event

type dw_procedencia from uo_master_dw within w_inscrip_posgrado_2013
integer x = 41
integer y = 952
integer width = 2693
integer height = 240
integer taborder = 60
boolean enabled = false
string dataobject = "dw_procedencia_alumno_2013"
boolean hscrollbar = false
end type

event itemchanged;call super::itemchanged;idw_trabajo = this
end event

type dw_nacimiento from uo_master_dw within w_inscrip_posgrado_2013
integer x = 14
integer y = 624
integer width = 3223
integer height = 584
integer taborder = 40
string dataobject = "dw_naci_alumno_2013_2"
boolean hscrollbar = false
boolean vscrollbar = false
end type

event itemchanged;call super::itemchanged;int columna
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

idw_trabajo = this
end event

event constructor;call super::constructor;idw_trabajo = this
m_menu_general_2013.dw = this
end event

event clicked;call super::clicked;idw_trabajo = this
m_menu_general_2013.dw = this
end event

type dw_domicilio from uo_master_dw within w_inscrip_posgrado_2013
integer x = 23
integer y = 1780
integer width = 3232
integer height = 296
integer taborder = 20
boolean enabled = false
string dataobject = "dw_domicilio_alumno_2013_2"
boolean hscrollbar = false
boolean vscrollbar = false
end type

type r_2 from rectangle within w_inscrip_posgrado_2013
long linecolor = 128
integer linethickness = 5
long fillcolor = 16777215
integer x = 1819
integer y = 2084
integer width = 1417
integer height = 328
end type

type r_1 from rectangle within w_inscrip_posgrado_2013
long linecolor = 128
integer linethickness = 5
long fillcolor = 16777215
integer x = 32
integer y = 2084
integer width = 1778
integer height = 328
end type

type uo_nombre from uo_nombre_alumno_2013 within w_inscrip_posgrado_2013
integer x = 27
integer y = 300
integer taborder = 10
end type

on uo_nombre.destroy
call uo_nombre_alumno_2013::destroy
end on

event constructor;call super::constructor;m_menu_general_2013.objeto = this
end event

type dw_academico from uo_master_dw within w_inscrip_posgrado_2013
integer x = 9
integer y = 1216
integer width = 3250
integer height = 572
integer taborder = 70
string dataobject = "dw_academicos_alumno_2013_2"
boolean hscrollbar = false
boolean vscrollbar = false
end type

event itemchanged;string ls_nivel, ls_columna, ls_cve_carrera
long ll_cve_carrera, ll_row
integer li_cve_plan,li_cve_subsis

ll_row = this.GetRow()

//if ib_modificando then
//	return
//end if

ib_modificando = true

this.AcceptText()

ls_columna =this.GetColumnName()

ll_cve_carrera = object.cve_carrera[ll_row]
ls_cve_carrera = string(ll_cve_carrera)
li_cve_plan = object.cve_plan[ll_row]
li_cve_subsis = 0
dwc_plan.settransobject(gtr_sce)
dwc_subsis.settransobject(gtr_sce)
ii_sw = 0

ib_modificando = true

choose case ls_columna 
case 'cve_carrera' 	
	ls_nivel = f_obten_nivel(ll_cve_carrera)	
	object.nivel[ll_row]=ls_nivel

	if dwc_plan.Retrieve(ll_cve_carrera) > 0 then
		li_cve_plan = dwc_plan.Getitemnumber(1,'cve_plan')
	else
		li_cve_plan = 0
		dwc_plan.Insertrow(0)
		dwc_plan.Setitem(1,'cve_plan', 0)
		dwc_plan.Setitem(1,'nombre_plan', 'SIN PLAN')
	end if
	Setitem(row,'cve_plan',li_cve_plan)
	if dwc_subsis.Retrieve(ll_cve_carrera,li_cve_plan) = 0 then
		dwc_subsis.Insertrow(0)
		dwc_subsis.Setitem(1,'cve_subsistema', 0)
		dwc_subsis.Setitem(1,'subsistema', 'SIN SUBSISTEMA')
		Setitem(row,'cve_subsistema',0)
	else
		li_cve_subsis = dwc_subsis.Getitemnumber(1,'cve_subsistema')
		Setitem(row,'cve_subsistema',li_cve_subsis)
	end if
	ii_sw = 1
case 'cve_plan' 
	if isnull(ll_cve_carrera) or (ll_cve_carrera= 0) then
		ll_cve_carrera= 0
		MessageBox("Captura previa requerida","Favor de Capturar la carrera")
		this.SetColumn("cve_carrera")
		ib_modificando = false
		return 1
	elseif not f_plan_activo(ll_cve_carrera, li_cve_plan) then
		MessageBox("Plan Inactivo","La carrera: ["+ls_cve_carrera+"] con el plan: ["+string(li_cve_plan)+ "] no estan activos ")	
		ib_modificando = false
		if dwc_subsis.Retrieve(ll_cve_carrera,li_cve_plan) = 0 then
			dwc_subsis.Insertrow(0)
			dwc_subsis.Setitem(1,'cve_subsistema', 0)
			dwc_subsis.Setitem(1,'subsistema', 'SIN SUBSISTEMA')
			Setitem(row,'cve_subsistema',0)
		else
			li_cve_subsis = dwc_subsis.Getitemnumber(1,'cve_subsistema')
			Setitem(row,'cve_subsistema',li_cve_subsis)
		end if
	else
		IF dwc_plan.retrieve(ll_cve_carrera) = 0 then
			dwc_plan.Insertrow(0)
			dwc_plan.Setitem(1,'cve_plan', 0)
			dwc_plan.Setitem(1,'nombre_plan', 'SIN PLAN')
			Setitem(row,'cve_plan',0)
		end if
		if dwc_subsis.Retrieve(ll_cve_carrera,li_cve_plan) = 0 then
			dwc_subsis.Insertrow(0)
			dwc_subsis.Setitem(1,'cve_subsistema', 0)
			dwc_subsis.Setitem(1,'subsistema', 'SIN SUBSISTEMA')
			Setitem(row,'cve_subsistema',0)
		else
			li_cve_subsis = dwc_subsis.Getitemnumber(1,'cve_subsistema')
			Setitem(row,'cve_subsistema',li_cve_subsis)
		end if
	end if
	ii_sw = 1
case 'cve_formaingreso'
	
	//**
	STRING ls_descripcion_ingreso
	INTEGER le_forma_ingreso
	ls_nivel = dw_academico.Getitemstring(row, "nivel") 
	le_forma_ingreso = integer(data)
	
	ls_descripcion_ingreso = f_ingreso_descripcion(le_forma_ingreso) 	
	//**
	
	//if integer(data) = 0 and dwc_carrera.Getitemstring(dwc_carrera.Getrow(),'nivel') <> 'L' then
	if le_forma_ingreso = 0 and ls_nivel = 'P' then
		Messagebox("Aviso","Forma de ingreso: '" + ls_descripcion_ingreso + "', no aplica para nivel posgrado.")  
		ib_modificando = false
	end if
	//if integer(data) = 8 and dwc_carrera.Getitemstring(dwc_carrera.Getrow(),'nivel') <> 'P' then
	if le_forma_ingreso = 8 and ls_nivel <> 'P' then	
		Messagebox("Aviso","Forma de ingreso: '" + ls_descripcion_ingreso + "', solo para nivel posgrado.") 
		ib_modificando = false
	end if	
	ii_sw = 1
end choose
idw_trabajo = this

end event

event clicked;call super::clicked;idw_trabajo = this
m_menu_general_2013.dw = this
end event

