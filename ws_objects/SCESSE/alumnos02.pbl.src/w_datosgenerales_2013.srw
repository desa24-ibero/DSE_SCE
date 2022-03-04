$PBExportHeader$w_datosgenerales_2013.srw
forward
global type w_datosgenerales_2013 from w_master_main
end type
type st_replica from statictext within w_datosgenerales_2013
end type
type dw_domicilio from uo_master_dw within w_datosgenerales_2013
end type
type uo_nombre from uo_nombre_alumno_2013 within w_datosgenerales_2013
end type
type dw_procedencia from uo_master_dw within w_datosgenerales_2013
end type
type dw_nacimiento from uo_master_dw within w_datosgenerales_2013
end type
type dw_cp from datawindow within w_datosgenerales_2013
end type
end forward

global type w_datosgenerales_2013 from w_master_main
integer width = 3461
integer height = 2432
string title = "Datos Generales de Alumnos"
string menuname = "m_datos_generales_2013"
st_replica st_replica
dw_domicilio dw_domicilio
uo_nombre uo_nombre
dw_procedencia dw_procedencia
dw_nacimiento dw_nacimiento
dw_cp dw_cp
end type
global w_datosgenerales_2013 w_datosgenerales_2013

type variables
datawindowchild idwc_cp
boolean ib_modificado = false
end variables

forward prototypes
public function integer wf_limpia_ventana ()
public function integer wf_validar ()
end prototypes

public function integer wf_limpia_ventana ();


// Se inserta un registro para inicializar los campos
dw_domicilio.RESET()
dw_domicilio.INSERTROW(0) 
dw_nacimiento.RESET()
dw_nacimiento.INSERTROW(0) 
dw_procedencia.RESET()
dw_procedencia.INSERTROW(0) 

RETURN 0
end function

public function integer wf_validar ();
STRING ls_curp 
INTEGER le_validado


ls_curp = dw_nacimiento.GETITEMSTRING(1, "curp") 
IF ISNULL(ls_curp) THEN ls_curp = "" 

IF TRIM(ls_curp) <> "" THEN 
	le_validado = dw_nacimiento.GETITEMNUMBER(1, "curp_validado")  
	
	IF le_validado = 1 AND LEN(ls_curp) <> 18 THEN 
		MESSAGEBOX("Error", "La CURP VALIDADA debe tener 18 caracteres.")
		RETURN -1
	END IF
	
END IF

RETURN 1


end function

on w_datosgenerales_2013.create
int iCurrent
call super::create
if this.MenuName = "m_datos_generales_2013" then this.MenuID = create m_datos_generales_2013
this.st_replica=create st_replica
this.dw_domicilio=create dw_domicilio
this.uo_nombre=create uo_nombre
this.dw_procedencia=create dw_procedencia
this.dw_nacimiento=create dw_nacimiento
this.dw_cp=create dw_cp
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_replica
this.Control[iCurrent+2]=this.dw_domicilio
this.Control[iCurrent+3]=this.uo_nombre
this.Control[iCurrent+4]=this.dw_procedencia
this.Control[iCurrent+5]=this.dw_nacimiento
this.Control[iCurrent+6]=this.dw_cp
end on

on w_datosgenerales_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_replica)
destroy(this.dw_domicilio)
destroy(this.uo_nombre)
destroy(this.dw_procedencia)
destroy(this.dw_nacimiento)
destroy(this.dw_cp)
end on

event open;call super::open;

dw_domicilio.settransobject(gtr_sce)
dw_nacimiento.settransobject(gtr_sce)
dw_procedencia.settransobject(gtr_sce)
dw_domicilio.Getchild('cod_postal',idwc_cp)
idwc_cp.settransobject(gtr_sce)
idwc_cp.retrieve()


uo_nombre.em_cuenta.text = " "
triggerevent(doubleclicked!)

//**--**
//wf_limpia_ventana()
//// Se inserta un registro para inicializar los campos
//dw_domicilio.INSERTROW(0) 
//dw_nacimiento.INSERTROW(0) 
//dw_procedencia.INSERTROW(0) 
//**--** 


uo_nombre.cbx_nuevo.visible = true
uo_nombre.cbx_nuevo.enabled = true  
//uo_nombre.cbx_nuevo.CHECKED = true

//uo_nombre.r_3.visible  = true
/**/gnv_app.inv_security.of_SetSecurity(this)

end event

event closequery;//
end event

event doubleclicked;call super::doubleclicked;int flag
flag = 0

long  ll_cuenta

ll_cuenta = long(uo_nombre.of_obten_cuenta())
//// Se innsertan registros en blanco si la cuenta no es válida. 
//IF ISNULL(ll_cuenta) OR ll_cuenta = 0 THEN 
//	dw_domicilio.INSERTROW(0) 
//	dw_nacimiento.INSERTROW(0) 
//	dw_procedencia.INSERTROW(0) 
//	RETURN 0
//END IF



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

if dw_domicilio.retrieve( ll_cuenta) = 0 then
	dw_domicilio.insertrow(0)
	flag = flag + 1
end if	

if dw_nacimiento.retrieve( ll_cuenta) = 0 then
	if dw_nacimiento.insertrow(0) > 0 then
	end if
	flag = flag + 1
end if	

if dw_procedencia.retrieve( ll_cuenta) = 0 then
	dw_procedencia.insertrow(0) 
	flag = flag + 1
end if

if flag < 3  then
	uo_nombre.cbx_nuevo.text = "Modificar"	
end if


end event

event ue_actualiza;call super::ue_actualiza;long ll_cuenta, ll_cuenta1
string nombre,apaterno,amaterno
string nombre1,apaterno1,amaterno1
int RenglonNac, RenglonNombre, li_res,li_replica_activa


dw_nacimiento.ACCEPTTEXT() 

IF uo_nombre.cbx_nuevo.checked THEN 
	ib_modificado = true
ELSE
	ib_modificado = false
END IF 


li_res = wf_validar ()
if li_res = -1 then
	rollback using gtr_sce;
	messagebox("Información","No se han guardado los cambios")	
	return
end if

// Siempre se asigna la cuenta
ll_cuenta =long(uo_nombre.of_obten_cuenta())
dw_procedencia.setitem(dw_procedencia.getrow(),"cuenta",ll_cuenta)

if ib_modificado and dw_nacimiento.Rowcount() > 0 then

	uo_nombre.em_cuenta.enabled = true
	ll_cuenta =long(uo_nombre.of_obten_cuenta())
	dw_domicilio.setitem(dw_domicilio.getrow(),"cuenta",ll_cuenta)
	dw_procedencia.setitem(dw_procedencia.getrow(),"cuenta",ll_cuenta)
	
	RenglonNac = 1
	RenglonNombre = 1
		
	ll_cuenta1 = dw_nacimiento.getitemnumber(RenglonNac,"cuenta")
	if ll_cuenta <> ll_cuenta1 or isnull(ll_cuenta1) then dw_nacimiento.setitem(RenglonNac,"cuenta",ll_cuenta)
		
	nombre = string(uo_nombre.of_obten_nombre())
	nombre1 = dw_nacimiento.getitemstring(RenglonNac,"nombre")
	if nombre <> nombre1 or isnull(nombre1) then dw_nacimiento.setitem(RenglonNac,"nombre",nombre)
	
	apaterno = string(uo_nombre.of_obten_apaterno())
	apaterno1 = dw_nacimiento.getitemstring(RenglonNac,"apaterno")
	if apaterno <> apaterno1 or isnull(apaterno1) then	dw_nacimiento.setitem(RenglonNac,"apaterno",apaterno)
		
	amaterno = string(uo_nombre.of_obten_amaterno())
	amaterno1 = dw_nacimiento.getitemstring(RenglonNac,"amaterno")
	if amaterno <> amaterno1 or isnull(apaterno1) then	dw_nacimiento.setitem(RenglonNac,"amaterno",amaterno)
end if

if dw_nacimiento.update(true) > 0 then
	commit using gtr_sce;
	if dw_domicilio.update(true) > 0 then
		if dw_procedencia.update(true) > 0 then
			commit using gtr_sce;			
				
			//INICIO:Replica a Internet
			li_replica_activa = f_replica_Activa()
			if li_replica_activa = 1 then
				f_replica_internet(this,ll_cuenta)
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
			messagebox("Información","No se han guardado los cambios",stopsign!)
		end if
	else
		rollback using gtr_sce;
		messagebox("Información","No se han guardado los cambios",stopsign!)
	end if
else
	rollback using gtr_sce;					
	messagebox("Información","No se han guardado los cambios")	
end if
triggerevent(doubleclicked!)
end event

event ue_borra;call super::ue_borra;string cuenta
int respuesta

cuenta = string(uo_nombre.of_obten_cuenta())

respuesta = messagebox("Atención","Esta seguro de querer borrar al alumno "+cuenta+ ".",StopSign!,YesNo!,2)

if respuesta = 1 then
	ib_modificado = false
	dw_domicilio.deleterow(dw_domicilio.getrow())
	triggerevent('ue_actualiza')
elseif respuesta = 2 then
	rollback using gtr_sce;
	messagebox("Información","No se han guardado los cambios")	
	triggerevent(doubleclicked!)
	return
end if	

end event

event ue_nuevo;call super::ue_nuevo;long cuenta,res

res = MessageBox("Aviso", "¿Genero un nuevo número de cuenta?",Exclamation!, YesNo!, 1)
IF res = 1 THEN 
	SELECT min(cuenta)
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
	uo_nombre.em_cuenta.text = string(cuenta)
	uo_nombre.em_digito.text = obten_digito(cuenta)
	uo_nombre.em_cuenta.enabled = false
ELSE
	uo_nombre.em_cuenta.text = ""
	uo_nombre.em_digito.text = ""
	uo_nombre.em_cuenta.enabled = true
END IF
	
uo_nombre.cbx_nuevo.text = "Nuevo"
	
uo_nombre.cbx_nuevo.checked = true
uo_nombre.dw_nombre_alumno.reset()
uo_nombre.dw_nombre_alumno.insertrow(uo_nombre.dw_nombre_alumno.getrow())
uo_nombre.dw_nombre_alumno.setfocus()

dw_nacimiento.reset()
dw_domicilio.reset()
dw_procedencia.reset()

if dw_nacimiento.retrieve( cuenta) = 0 then
	if dw_nacimiento.insertrow(0) > 0 then
	end if
end if	

if dw_procedencia.retrieve( cuenta) = 0 then
	dw_procedencia.insertrow(0) 
end if

ib_modificado = TRUE
end event

event activate;//
end event

type st_sistema from w_master_main`st_sistema within w_datosgenerales_2013
end type

type p_ibero from w_master_main`p_ibero within w_datosgenerales_2013
end type

type st_replica from statictext within w_datosgenerales_2013
integer x = 3269
integer y = 336
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

type dw_domicilio from uo_master_dw within w_datosgenerales_2013
integer x = 27
integer y = 660
integer width = 3223
integer height = 368
integer taborder = 20
string dataobject = "dw_domicilio_alumno_2013"
boolean hscrollbar = false
boolean vscrollbar = false
end type

event itemchanged;call super::itemchanged;
long columna

columna = getcolumn()

if dwo.name = 'cod_postal' then

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
idw_trabajo = this




//if dwo.name = 'cod_postal' then
//	object.domicilio_colonia[1]= idwc_cp.Getitemstring(idwc_cp.Getrow(),'colonia') + ', ' + idwc_cp.Getitemstring(idwc_cp.Getrow(),'ciudad')
//	object.domicilio_cve_estado[1]=idwc_cp.Getitemnumber(idwc_cp.Getrow(),'cve_estado')
//end if
//idw_trabajo = this
end event

event constructor;call super::constructor;idw_trabajo = this
m_datos_generales_2013.dw = this
end event

event clicked;call super::clicked;idw_trabajo = this
m_datos_generales_2013.dw = this
end event

type uo_nombre from uo_nombre_alumno_2013 within w_datosgenerales_2013
integer x = 27
integer y = 332
integer taborder = 10
end type

on uo_nombre.destroy
call uo_nombre_alumno_2013::destroy
end on

event constructor;call super::constructor;m_datos_generales_2013.objeto = this
end event

type dw_procedencia from uo_master_dw within w_datosgenerales_2013
integer x = 46
integer y = 1612
integer width = 2720
integer height = 436
integer taborder = 40
string dataobject = "dw_procedencia_alumno_2013"
boolean hscrollbar = false
end type

event doubleclicked;call super::doubleclicked;if getcolumn() = 2 then
	busqueda_2013("escuela")
	object.cve_escuela[row]=ok
elseif getcolumn() = 4 then
	busqueda_2013("carrera")
	object.cve_carrera[row]=ok
end if
end event

event getfocus;call super::getfocus;m_datos_generales_2013.dw = this
end event

event itemchanged;call super::itemchanged;idw_trabajo = this

if dwo.name = 'cve_escuela' then
end if

end event

type dw_nacimiento from uo_master_dw within w_datosgenerales_2013
integer x = 9
integer y = 1024
integer width = 3250
integer height = 1108
integer taborder = 30
string dataobject = "dw_naci_alumno_2013"
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

event clicked;call super::clicked;idw_trabajo = this
m_datos_generales_2013.dw = this
end event

type dw_cp from datawindow within w_datosgenerales_2013
boolean visible = false
integer x = 530
integer y = 372
integer width = 2610
integer height = 492
integer taborder = 30
boolean bringtotop = true
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

