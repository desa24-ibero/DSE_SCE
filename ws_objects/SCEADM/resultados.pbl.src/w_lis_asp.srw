$PBExportHeader$w_lis_asp.srw
$PBExportComments$Listados de Aspirantes por carrera, escuela, division, etc.
forward
global type w_lis_asp from window
end type
type cbx_por_fecha from checkbox within w_lis_asp
end type
type st_3 from statictext within w_lis_asp
end type
type dw_fecha_examen from datawindow within w_lis_asp
end type
type uo_tipo_periodo_ing from uo_tipo_periodo within w_lis_asp
end type
type dw_aspirantes from datawindow within w_lis_asp
end type
type cbx_departamentos from checkbox within w_lis_asp
end type
type cbx_coordinacion from checkbox within w_lis_asp
end type
type cb_9 from commandbutton within w_lis_asp
end type
type cbx_bachillera from checkbox within w_lis_asp
end type
type cbx_division from checkbox within w_lis_asp
end type
type cbx_carrera from checkbox within w_lis_asp
end type
type uo_2 from uo_carrera within w_lis_asp
end type
type uo_1 from uo_ver_per_ani within w_lis_asp
end type
type dw_1 from uo_dw_reporte within w_lis_asp
end type
end forward

global type w_lis_asp from window
integer x = 832
integer y = 364
integer width = 4087
integer height = 2424
boolean titlebar = true
string title = "Listados de Aspirantes"
string menuname = "m_menu"
boolean maxbox = true
boolean resizable = true
long backcolor = 30976088
cbx_por_fecha cbx_por_fecha
st_3 st_3
dw_fecha_examen dw_fecha_examen
uo_tipo_periodo_ing uo_tipo_periodo_ing
dw_aspirantes dw_aspirantes
cbx_departamentos cbx_departamentos
cbx_coordinacion cbx_coordinacion
cb_9 cb_9
cbx_bachillera cbx_bachillera
cbx_division cbx_division
cbx_carrera cbx_carrera
uo_2 uo_2
uo_1 uo_1
dw_1 dw_1
end type
global w_lis_asp w_lis_asp

type variables
transaction itr_admision_web
end variables

forward prototypes
public function integer f_recupera_fechas ()
public function integer f_recupera_fecha_detalle ()
end prototypes

public function integer f_recupera_fechas ();// Se recuperan las fechas de examen de la versión solicitada
INTEGER li_clv_ver_nueva 

dw_fecha_examen.RESET()
dw_fecha_examen.INSERTROW(0)

li_clv_ver_nueva = gi_version

DATAWINDOWCHILD ldwc_fechas
dw_fecha_examen.GETCHILD("id_examen", ldwc_fechas) 
ldwc_fechas.SETTRANSOBJECT(itr_admision_web) 
ldwc_fechas.RETRIEVE(li_clv_ver_nueva,gi_periodo, gi_anio) 

DATAWINDOWCHILD ldwc_fechas2
dw_1.GETCHILD("aspiran_id_examen", ldwc_fechas2) 
ldwc_fechas2.SETTRANSOBJECT(itr_admision_web) 
ldwc_fechas2.RETRIEVE(li_clv_ver_nueva,gi_periodo, gi_anio) 


RETURN 0 


end function

public function integer f_recupera_fecha_detalle ();// Se recuperan las fechas de examen de la versión solicitada
INTEGER li_clv_ver_nueva 

li_clv_ver_nueva = gi_version

DATAWINDOWCHILD ldwc_fechas2
dw_1.GETCHILD("id_examen", ldwc_fechas2) 
ldwc_fechas2.SETTRANSOBJECT(itr_admision_web) 
ldwc_fechas2.RETRIEVE(li_clv_ver_nueva,gi_periodo, gi_anio) 


RETURN 0 


end function

on w_lis_asp.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cbx_por_fecha=create cbx_por_fecha
this.st_3=create st_3
this.dw_fecha_examen=create dw_fecha_examen
this.uo_tipo_periodo_ing=create uo_tipo_periodo_ing
this.dw_aspirantes=create dw_aspirantes
this.cbx_departamentos=create cbx_departamentos
this.cbx_coordinacion=create cbx_coordinacion
this.cb_9=create cb_9
this.cbx_bachillera=create cbx_bachillera
this.cbx_division=create cbx_division
this.cbx_carrera=create cbx_carrera
this.uo_2=create uo_2
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.cbx_por_fecha,&
this.st_3,&
this.dw_fecha_examen,&
this.uo_tipo_periodo_ing,&
this.dw_aspirantes,&
this.cbx_departamentos,&
this.cbx_coordinacion,&
this.cb_9,&
this.cbx_bachillera,&
this.cbx_division,&
this.cbx_carrera,&
this.uo_2,&
this.uo_1,&
this.dw_1}
end on

on w_lis_asp.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_por_fecha)
destroy(this.st_3)
destroy(this.dw_fecha_examen)
destroy(this.uo_tipo_periodo_ing)
destroy(this.dw_aspirantes)
destroy(this.cbx_departamentos)
destroy(this.cbx_coordinacion)
destroy(this.cb_9)
destroy(this.cbx_bachillera)
destroy(this.cbx_division)
destroy(this.cbx_carrera)
destroy(this.uo_2)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1


INTEGER li_conexion 
li_conexion = f_conecta_pas_parametros_bd(gtr_sce, itr_admision_web, 24, gs_usuario, gs_password)
if li_conexion <>1 then
	MessageBox("Error de conexion a la base del web","Favor de reintentar con un usuario que tenga permisos", StopSign!)
	close(this)
end if

dw_1.settransobject(gtr_sadm)
dw_aspirantes.settransobject(gtr_sadm)


f_recupera_fechas()
end event

event close;if isvalid(itr_admision_web) then
	DISCONNECT USING itr_admision_web;
end if
end event

type cbx_por_fecha from checkbox within w_lis_asp
integer x = 55
integer y = 256
integer width = 654
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Por Fecha Examen:"
boolean lefttext = true
end type

event clicked;IF CHECKED THEN 
	dw_fecha_examen.ENABLED = TRUE 
ELSE 
	dw_fecha_examen.ENABLED = FALSE 
END IF 
	
	
	
end event

type st_3 from statictext within w_lis_asp
integer x = 754
integer y = 256
integer width = 539
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Fecha Aplicación:"
boolean focusrectangle = false
end type

type dw_fecha_examen from datawindow within w_lis_asp
integer x = 1303
integer y = 232
integer width = 1202
integer height = 104
integer taborder = 20
string title = "none"
string dataobject = "dw_fecha_examen_cambio_ver"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_tipo_periodo_ing from uo_tipo_periodo within w_lis_asp
integer x = 2327
integer y = 44
integer height = 136
integer taborder = 10
end type

on uo_tipo_periodo_ing.destroy
call uo_tipo_periodo::destroy
end on

type dw_aspirantes from datawindow within w_lis_asp
boolean visible = false
integer x = 9
integer y = 1708
integer width = 3639
integer height = 92
integer taborder = 20
string dataobject = "dw_lis_asp_2"
boolean livescroll = true
end type

event retrieveend;string division,departamento,coordinacion,carrera,bachillerato
int clv_carr,bachillera
long cont, ll_row

ll_row = dw_aspirantes.rowcount()
//FOR cont=1 TO rowcount
FOR cont=1 TO ll_row	
//	clv_carr=dw_aspirantes.GetItemNumber(cont,'aspiran_clv_carr')
	clv_carr=object.ccve_carrera[cont]
	bachillera=object.ccve_bachillera[cont]

	SELECT carreras.carrera,coordinaciones.coordinacion,departamentos.departamento,
			divisiones.division
	INTO :carrera,:coordinacion,:departamento,:division
	FROM carreras,coordinaciones,departamentos,divisiones
	WHERE ( coordinaciones.cve_coordinacion = carreras.cve_coordinacion ) and
		( departamentos.cve_depto = coordinaciones.cve_depto ) and
		( divisiones.cve_division = departamentos.cve_division ) and
		( ( carreras.cve_carrera = :clv_carr ) )
	USING gtr_sce;

	if cbx_division.checked then
		object.cdivision[cont]=division
	end if
	
	if cbx_departamentos.checked then
		object.cdepartamentos[cont]=departamento
	end if
	
	if cbx_coordinacion.checked then
		object.ccoordinacion[cont]=coordinacion
	end if

	if cbx_carrera.checked then
		carrera=string(clv_carr,"####0000")+' '+carrera
		object.ccarr[cont]=carrera
	end if
	
	if cbx_bachillera.checked then
		SELECT escuelas.escuela  
		INTO :bachillerato  
		FROM escuelas  
		WHERE escuelas.cve_escuela = :bachillera
		USING gtr_sce;
		object.cescuela[cont]=string(bachillera,"####0000")+' '+bachillerato
	end if
		
NEXT
sort()
groupcalc()
end event

type cbx_departamentos from checkbox within w_lis_asp
integer x = 416
integer y = 388
integer width = 485
integer height = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "Departamentos"
boolean lefttext = true
end type

type cbx_coordinacion from checkbox within w_lis_asp
integer x = 905
integer y = 388
integer width = 489
integer height = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "Coordinaciones"
boolean lefttext = true
end type

type cb_9 from commandbutton within w_lis_asp
boolean visible = false
integer x = 2021
integer y = 172
integer width = 283
integer height = 76
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Archivar"
end type

event clicked;int value,esc_file,row,clv_ver,lugar_gen,lugar_car
int status,edo_civil,religion,trabajo,transporte
string docname, named
string nombre,sexo,carrera,coordinacion,departamento,division,cuenta,escuela,salon,telefono
long folio
real promedio,puntaje,calif_examen

value = GetFileSaveName("Selecciona Archivo",+ docname, named, "CSV",+ "Archivo de Resultados (*.CSV),*.CSV,")

IF value = 1 THEN 	
	esc_file = FileOpen(docname,LineMode!, Write!, LockReadWrite!, Replace!)
	SetPointer(HourGlass!)
	FileWrite(esc_file,'Periodo,Cuenta,Folio,Nombre,Sexo,Division,Departamento,Coordinación,'+&
		'Carrera,Prom. Bachillerato,Puntaje,Lugar General,Lugar Carr,Calificación Examen,Salon,'+&
		'Status,Estado Civil,Religión,Trabajo,Transporte,Teléfono,Bachillerato')
	FOR row=1 TO dw_1.rowcount()
		clv_ver=dw_1.object.aspiran_clv_ver[row]
		cuenta=dw_1.object.cuen[row]
		if isnull(cuenta) then
			cuenta=""
		end if
		folio=dw_1.object.aspiran_folio[row]
		nombre=dw_1.object.nom[row]
		sexo=dw_1.object.general_sexo[row]
		if isnull(sexo) then
			sexo='?'
		end if
		division=dw_1.object.division[row]
		departamento=dw_1.object.departamento[row]
		coordinacion=dw_1.object.coordinacion[row]
		carrera=dw_1.object.carrera[row]
		promedio=dw_1.object.aspiran_promedio[row]
		if isnull(promedio) then
			promedio=0
		end if
		puntaje=dw_1.object.aspiran_puntaje[row]
		if isnull(puntaje) then
			puntaje=0
		end if
		lugar_gen=dw_1.object.aspiran_lugar_gen[row]
		if isnull(lugar_gen) then
			lugar_gen=0
		end if
		lugar_car=dw_1.object.aspiran_lugar_car[row]
		if isnull(lugar_car) then
			lugar_car=0
		end if
		calif_examen=(puntaje -promedio*40.0)/0.6
		if isnull(calif_examen) then
			calif_examen=0
		end if
		salon=dw_1.object.aspiran_salon[row]
		status=dw_1.object.aspiran_status[row]
		edo_civil=dw_1.object.general_edo_civil[row]
		if isnull(edo_civil) then
			edo_civil=999
		end if
		religion=dw_1.object.general_religion[row]
		if isnull(religion) then
			religion=999
		end if
		trabajo=dw_1.object.general_trabajo[row]
		if isnull(trabajo) then
			trabajo=999
		end if
		transporte=dw_1.object.general_transporte[row]
		if isnull(transporte) then
			transporte=999
		end if
		telefono=dw_1.object.general_telefono[row]
		if isnull(telefono) then
			telefono=""
		end if
		escuela=dw_1.object.escuela[row]
		if isnull(escuela) then
			escuela=""
		end if
		
		FileWrite(esc_file,string(clv_ver)+','+&
							cuenta+','+&
							string(folio)+','+&
							nombre+','+&
							sexo+','+&
							division+','+&
							departamento+','+&
							coordinacion+','+&
							carrera+','+&
							string(promedio,'##0.##')+','+&
							string(puntaje)+','+&
							string(lugar_gen)+','+&
							string(lugar_car)+','+&
							string(calif_examen)+','+&
							salon+','+&
							string(status)+','+&
							string(edo_civil)+','+&
							string(religion)+','+&
							string(trabajo)+','+&
							string(transporte)+','+&
							telefono+','+&
							escuela)
	NEXT
	FileClose(esc_file)
end if
end event

type cbx_bachillera from checkbox within w_lis_asp
integer x = 1723
integer y = 388
integer width = 343
integer height = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "Escuelas"
boolean lefttext = true
end type

type cbx_division from checkbox within w_lis_asp
integer x = 59
integer y = 388
integer width = 357
integer height = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "Divisiones"
boolean lefttext = true
end type

type cbx_carrera from checkbox within w_lis_asp
integer x = 1399
integer y = 388
integer width = 320
integer height = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "Carreras"
boolean lefttext = true
end type

type uo_2 from uo_carrera within w_lis_asp
integer x = 2597
integer y = 232
integer width = 1344
integer height = 204
boolean enabled = true
end type

on uo_2.destroy
call uo_carrera::destroy
end on

type uo_1 from uo_ver_per_ani within w_lis_asp
integer x = 41
integer y = 28
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

event cambia_seleccion;call super::cambia_seleccion;f_recupera_fechas()
end event

type dw_1 from uo_dw_reporte within w_lis_asp
integer x = 55
integer y = 488
integer width = 3954
integer height = 1664
integer taborder = 0
string dataobject = "dw_lis_asp_2"
boolean hscrollbar = true
boolean resizable = true
end type

event carga;IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	this.dataobject = "dw_lis_asp_2"
	this.SetTransObject(gtr_sadm)
ELSE
	this.dataobject = "dw_lis_asp_2_ing"
	this.SetTransObject(gtr_sadm)	
END IF

event primero()
object.st_1.text=tit1

//dw_aspirantes.retrieve(gi_version,gi_periodo,gi_anio,uo_2.dw_carrera.object.cve_carrera[uo_2.dw_carrera.getrow()])


LONG ll_id_fecha


IF cbx_por_fecha.CHECKED THEN 
	ll_id_fecha = dw_fecha_examen.GETITEMNUMBER(1, "id_examen")  
	IF ISNULL(ll_id_fecha) OR ll_id_fecha = 0 THEN 
		MESSAGEBOX("Error", "Debe seleccionar una fecha de aplicación de exámen. " ) 
		RETURN -1
	END IF
ELSE 
	ll_id_fecha = 0
END IF 

f_recupera_fecha_detalle()


return retrieve(gi_version,gi_periodo,gi_anio,uo_2.dw_carrera.object.cve_carrera[uo_2.dw_carrera.getrow()], ll_id_fecha)
end event

event retrieveend;call super::retrieveend;string division,departamento,coordinacion,carrera,bachillerato
int clv_carr,bachillera
long cont, ll_row


////*
//ll_row = dw_1.rowcount()
////FOR cont=1 TO rowcount
//FOR cont=1 TO ll_row	
////	clv_carr=dw_1.GetItemNumber(cont,'aspiran_clv_carr')
//	clv_carr=object.aspiran_clv_carr[cont]
//	bachillera=object.general_bachillera[cont]
//
//	SELECT carreras.carrera,coordinaciones.coordinacion,departamentos.departamento,
//			divisiones.division
//	INTO :carrera,:coordinacion,:departamento,:division
//	FROM carreras,coordinaciones,departamentos,divisiones
//	WHERE ( coordinaciones.cve_coordinacion = carreras.cve_coordinacion ) and
//		( departamentos.cve_depto = coordinaciones.cve_depto ) and
//		( divisiones.cve_division = departamentos.cve_division ) and
//		( ( carreras.cve_carrera = :clv_carr ) )
//	USING gtr_sce;
//
//	if cbx_division.checked then
//		object.division[cont]=division
//	end if
//	
//	if cbx_departamentos.checked then
//		object.departamento[cont]=departamento
//	end if
//	
//	if cbx_coordinacion.checked then
//		object.coordinacion[cont]=coordinacion
//	end if
//
//	if cbx_carrera.checked then
//		carrera=string(clv_carr,"####0000")+' '+carrera
//		object.carrera[cont]=carrera
//	end if
//	
//	if cbx_bachillera.checked then
//		SELECT escuelas.escuela  
//		INTO :bachillerato  
//		FROM escuelas  
//		WHERE escuelas.cve_escuela = :bachillera
//		USING gtr_sce;
//		object.escuela[cont]=string(bachillera,"####0000")+' '+bachillerato
//	end if
//		
//NEXT



//***
ll_row = dw_1.rowcount()
//FOR cont=1 TO rowcount
FOR cont=1 TO ll_row	
//	clv_carr=dw_1.GetItemNumber(cont,'aspiran_clv_carr')
	clv_carr=object.ccve_carrera[cont]
	bachillera=object.ccve_bachillera[cont]

	SELECT carreras.carrera,coordinaciones.coordinacion,departamentos.departamento,
			divisiones.division
	INTO :carrera,:coordinacion,:departamento,:division
	FROM carreras,coordinaciones,departamentos,divisiones
	WHERE ( coordinaciones.cve_coordinacion = carreras.cve_coordinacion ) and
		( departamentos.cve_depto = coordinaciones.cve_depto ) and
		( divisiones.cve_division = departamentos.cve_division ) and
		( ( carreras.cve_carrera = :clv_carr ) )
	USING gtr_sce;

	if cbx_division.checked then
		object.cdivision[cont]=division
	end if
	
	if cbx_departamentos.checked then
		object.cdepartamentos[cont]=departamento
	end if
	
	if cbx_coordinacion.checked then
		object.ccoordinacion[cont]=coordinacion
	end if

	if cbx_carrera.checked then
		carrera=string(clv_carr,"####0000")+' '+carrera
		object.ccarr[cont]=carrera
	end if
	
	if cbx_bachillera.checked then
		SELECT escuelas.escuela  
		INTO :bachillerato  
		FROM escuelas  
		WHERE escuelas.cve_escuela = :bachillera
		USING gtr_sce;
		object.cescuela[cont]=string(bachillera,"####0000")+' '+bachillerato
	end if
		
NEXT

sort()
groupcalc()

end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event asigna_dw_menu;/*
DESCRIPCIÓN: Evento en el cual se asigna a la variable dw del menu este objeto.
				En este evento se busca la ventana dueña del objeto y cual es su menu
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: CAMP(DkWf)
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/
window ventana_propietaria

ventana_propietaria = getparent()

menu_propietario = ventana_propietaria.menuid

menu_propietario.dw	= this

//menu_propietario.dw_2= dw_aspirantes


end event

