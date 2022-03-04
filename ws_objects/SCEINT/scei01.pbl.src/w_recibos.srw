$PBExportHeader$w_recibos.srw
$PBExportComments$Captura en ventanilla de cuentas preinscritas
forward
global type w_recibos from w_ancestral
end type
type dw_costos from datawindow within w_recibos
end type
type dw_costos_verano from datawindow within w_recibos
end type
type dw_recibo from uo_dw_reporte within w_recibos
end type
type cbx_recibo from checkbox within w_recibos
end type
type uo_periodo_anio from uo_per_ani within w_recibos
end type
type uo_1 from uo_nombre_alu_foto within w_recibos
end type
end forward

global type w_recibos from w_ancestral
integer width = 3680
integer height = 2268
string title = "Captura Individual de Preinscritos"
string menuname = "m_menu"
boolean minbox = false
event inicia_proceso ( )
dw_costos dw_costos
dw_costos_verano dw_costos_verano
dw_recibo dw_recibo
cbx_recibo cbx_recibo
uo_periodo_anio uo_periodo_anio
uo_1 uo_1
end type
global w_recibos w_recibos

type variables
real ir_abono
string is_peri
long il_anio
transaction itr_web

uo_periodo_servicios iuo_periodo_servicios

end variables

event inicia_proceso;/*
DESCRIPCIÓN: El objecto uo_nombre manda llamar a este evento cuando se ha capturado un
				 número de cuenta. Elabora el recibo de pago de inscripción en base al grado
				 del alumno. Además lo da de alta en alumnos preinscritos.
PARÁMETROS: Message.LongParm
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN: SE COMENTO TODO LA LOGICA DIRIGIDA ACONTROLAR 1ER INGRESO Y SE AGREGEGARON
RESTRICCIONES DE IMPRESION PARA POSGRADO. Angel Jacome Sanche, marzo 1999.
*/

string ls_nombre, ls_respuesta
long ll_cont,ll_folio,ll_cuenta,ll_ok
real lr_importe_1,lr_importe_2,lr_importe_3
date ld_fecha_banco,ld_fecha_uia,ld_fecha_hoy
char lch_nivel
int li_res,li_estatus, li_codigo_sql
string ls_error


SetPointer(HourGlass!)

ll_cuenta=Message.LongParm

if ll_cuenta<>0 then
	SELECT alumnos.nombre_completo
	INTO :ls_nombre
	FROM alumnos
	HAVING ( alumnos.cuenta = :ll_cuenta )
	USING gtr_sce;
	
	SELECT academicos.nivel  
	INTO :lch_nivel  
	FROM academicos  
	WHERE academicos.cuenta = :ll_cuenta
	USING gtr_sce;
//	IF lch_nivel<>'L' THEN
//		Messagebox('Alumno de Posgrado', 'No se generara recibo.')
//		return
//	END IF
		
	
	SELECT folio,cuenta,status
	INTO :ll_folio,:ll_ok,:li_estatus
	FROM preinsc
	WHERE cuenta = :ll_cuenta and periodo = :gi_periodo and anio = :gi_anio
	USING itr_web;
	if itr_web.SQLCode = 100 then
		ll_ok=0
	elseif itr_web.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sce.SQLErrText, Exclamation!)
	End If
	
	if ll_ok<>ll_cuenta then
		select descripcion_corta into :is_peri from periodo where periodo = :gi_periodo and tipo = :gs_tipo_periodo 	USING gtr_sce;
/*		
		CHOOSE CASE gi_periodo
				CASE 0
					is_peri='P'
				CASE 1
					is_peri='V'
				CASE 2
					is_peri='O'
		END CHOOSE
*/		
		il_anio=gi_anio -(truncate(gi_anio/100,0)*100)
		if (revisaadeudospreinscripcion(ll_cuenta,ls_respuesta,1)=0) then
			if ls_respuesta <> "" then MessageBox("Atencion",ls_respuesta)
		//if (revisaadeudosinscripcion(ll_cuenta,ls_respuesta,1)<>0) then
		//	MessageBox("Atencion",ls_respuesta)
		//end if
				open(w_folio)
			if long(Message.StringParm)=0 then
				return
			end if		
			ll_folio=long(Message.StringParm)
			li_estatus=0
			li_res = MessageBox("¿Está correcta su hoja óptica?", "", Exclamation!, YesNo!, 2)
			IF li_res = 1 THEN
				INSERT INTO preinsc
					( folio,cuenta,status,periodo,anio )
					VALUES ( :ll_folio,:ll_cuenta,:li_estatus,:gi_periodo,:gi_anio )
					USING itr_web;
				li_codigo_sql = itr_web.Sqlcode
				ls_error = itr_web.SqlErrText
				if li_codigo_sql = -1 then 
					rollback using itr_web;
					MessageBox ("Error al insertar en preinsc", ls_error,StopSign! )					
				else
					commit using itr_web;
				end if
			else
				return
			end if

		else
			MessageBox("",ls_respuesta)
		end if
	end if
end if


end event

event open;call super::open;/*
DESCRIPCIÓN: Pon la ventana en el extremo.
				 Asegura que las variables Periodo y Año sean del próximo semestre.
				 Lee los costos de cobranzas.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/


x=1
y=1

iuo_periodo_servicios = CREATE uo_periodo_servicios
/*iuo_periodo_servicios.f_carga_periodos(gs_tipo_periodo, "L", gtr_sce) */

periodo_actual(gi_periodo,gi_anio,gtr_sce)
//gi_periodo++

iuo_periodo_servicios.f_recupera_periodo_siguiente( gi_periodo, gi_anio, gtr_sce )

/*if gi_periodo=3 then
	gi_periodo=0
	gi_anio++
end if
*/

uo_periodo_anio.em_ani.text = string(gi_anio) 
uo_periodo_anio.em_per.text = string(gi_periodo) 


if isnull(gi_numscob) OR not (isvalid(gtr_scob)) then gi_numscob = 0
if gi_numscob <= 0 then
	if conecta_bd_n_tr(gtr_scob,gs_scob,gs_usuario,gs_password)<>1 then
		MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de cobranzas", StopSign!)
		close(this)
	end if
end if
gi_numscob++


if conecta_bd_n_tr(gtr_sfeb,gs_sfeb,gs_usuario,gs_password)=0 then
	return
end if



//if conecta_bd(itr_web,gs_sweb, "preinsce","futuro")<>1 then
if conecta_bd(itr_web,gs_sweb, gs_usuario,gs_password)<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	close(this)
end if



//if conecta_bd(gtr_scob,gs_scob,'EMRCES','ALBANIA')=0 then
//if conecta_bd(gtr_scob,gs_scob,gs_usuario,gs_password)=0 then
////if conecta_bd(gtr_scob,gs_scob,"informes","informes")=0 then
//	return
//end if
	
//dw_costos.settransobject(gtr_scob)
//dw_costos.retrieve()
//dw_costos_verano.settransobject(gtr_scob)
//dw_costos_verano.retrieve()
//
//CHOOSE CASE gi_periodo
//	CASE 0
//		is_peri='P'
//	CASE 1
//		is_peri='V'
//	CASE 2
//		is_peri='O'
//END CHOOSE
//
//il_anio=gi_anio -(truncate(gi_anio/100,0)*100)
//
//SELECT costos_abono.importe  
//INTO :ir_abono  
//FROM costos_abono  
//WHERE ( costos_abono.anio = :il_anio ) AND  
//		( costos_abono.periodo = :is_peri )
//USING gtr_scob;
//
//// desconecta_bd(gtr_scob)
end event

on w_recibos.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_costos=create dw_costos
this.dw_costos_verano=create dw_costos_verano
this.dw_recibo=create dw_recibo
this.cbx_recibo=create cbx_recibo
this.uo_periodo_anio=create uo_periodo_anio
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_costos
this.Control[iCurrent+2]=this.dw_costos_verano
this.Control[iCurrent+3]=this.dw_recibo
this.Control[iCurrent+4]=this.cbx_recibo
this.Control[iCurrent+5]=this.uo_periodo_anio
this.Control[iCurrent+6]=this.uo_1
end on

on w_recibos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_costos)
destroy(this.dw_costos_verano)
destroy(this.dw_recibo)
destroy(this.cbx_recibo)
destroy(this.uo_periodo_anio)
destroy(this.uo_1)
end on

event close;
if gi_numscob = 1 then
	if desconecta_bd_n_tr(gtr_scob) <> 1 then
		return
	end if
end if
gi_numscob --
desconecta_bd_n_tr(gtr_sfeb)


if isvalid(itr_web) then
	if desconecta_bd(itr_web) <> 1 then
		return
	end if
end if

end event

type p_uia from w_ancestral`p_uia within w_recibos
end type

type dw_costos from datawindow within w_recibos
event constructor pbm_constructor
integer x = 2386
integer y = 1308
integer width = 1207
integer height = 340
string dataobject = "d_costos"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_costos_verano from datawindow within w_recibos
integer x = 2386
integer y = 1668
integer width = 1207
integer height = 340
string dataobject = "d_costos_verano"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_recibo from uo_dw_reporte within w_recibos
event constructor pbm_constructor
integer x = 0
integer y = 428
integer width = 2377
integer height = 1652
integer taborder = 0
string dataobject = "d_recibo"
end type

event constructor;call super::constructor;/*
DESCRIPCIÓN: Escala este DataWindow para el tamaño del recibo.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/

Object.DataWindow.Zoom = 80
end event

type cbx_recibo from checkbox within w_recibos
integer x = 2729
integer y = 1188
integer width = 526
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "Imprimir Recibos"
boolean checked = true
boolean lefttext = true
end type

type uo_periodo_anio from uo_per_ani within w_recibos
event destroy ( )
integer x = 2368
integer y = 428
integer width = 1253
integer height = 168
boolean enabled = true
long backcolor = 1090519039
end type

on uo_periodo_anio.destroy
call uo_per_ani::destroy
end on

type uo_1 from uo_nombre_alu_foto within w_recibos
event destroy ( )
integer height = 428
integer taborder = 11
boolean bringtotop = true
boolean enabled = true
end type

on uo_1.destroy
call uo_nombre_alu_foto::destroy
end on

