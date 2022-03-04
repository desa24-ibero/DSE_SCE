$PBExportHeader$w_preinsc.srw
$PBExportComments$Captura Global de cuentas preinscritas
forward
global type w_preinsc from w_ancestral
end type
type uo_periodo_anio from uo_per_ani within w_preinsc
end type
type cb_2 from commandbutton within w_preinsc
end type
type dw_preinsc from uo_dw_captura within w_preinsc
end type
type dw_cap_mat_preinsc from uo_dw_captura within w_preinsc
end type
end forward

global type w_preinsc from w_ancestral
integer height = 2148
string title = "Captura Global de Preinscritos"
string menuname = "m_menu"
uo_periodo_anio uo_periodo_anio
cb_2 cb_2
dw_preinsc dw_preinsc
dw_cap_mat_preinsc dw_cap_mat_preinsc
end type
global w_preinsc w_preinsc

type variables
transaction itr_web
uo_periodo_servicios iuo_periodo_servicios 
end variables

event open;call super::open;/*
DESCRIPCIÓN: Liga los dw a sce.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/

iuo_periodo_servicios = CREATE uo_periodo_servicios

periodo_actual(gi_periodo,gi_anio,gtr_sce)

uo_periodo_anio.em_ani.text = string(gi_anio) 
uo_periodo_anio.em_per.text = string(gi_periodo) 


//if conecta_bd(itr_web,gs_sweb, "preinsce","futuro")<>1 then
if conecta_bd(itr_web,gs_sweb, gs_usuario, gs_password)<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	close(this)
else 
	dw_cap_mat_preinsc.settransobject(itr_web)
	dw_preinsc.settransobject(itr_web)
end if


//dw_cap_mat_preinsc.settransobject(gtr_sce)
//dw_preinsc.settransobject(gtr_sce)
end event

on w_preinsc.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_periodo_anio=create uo_periodo_anio
this.cb_2=create cb_2
this.dw_preinsc=create dw_preinsc
this.dw_cap_mat_preinsc=create dw_cap_mat_preinsc
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_periodo_anio
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.dw_preinsc
this.Control[iCurrent+4]=this.dw_cap_mat_preinsc
end on

on w_preinsc.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_periodo_anio)
destroy(this.cb_2)
destroy(this.dw_preinsc)
destroy(this.dw_cap_mat_preinsc)
end on

event close;call super::close;
if isvalid(itr_web) then
	if desconecta_bd(itr_web) <> 1 then
		return
	end if
end if
end event

type p_uia from w_ancestral`p_uia within w_preinsc
integer x = 5
end type

type uo_periodo_anio from uo_per_ani within w_preinsc
integer x = 1166
integer y = 60
integer width = 1253
integer height = 168
boolean enabled = true
long backcolor = 1090519039
end type

on uo_periodo_anio.destroy
call uo_per_ani::destroy
end on

type cb_2 from commandbutton within w_preinsc
event clicked pbm_bnclicked
integer x = 594
integer y = 60
integer width = 306
integer height = 164
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualiza"
end type

event clicked;/*
DESCRIPCIÓN: Actualiza los status de las materias preinscritas.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
int li_status,li_carr,li_plan
long ll_renglon_1,ll_renglon_2,ll_renglon_3,ll_clave,ll_cuenta
string ls_grupo,ls_nivel

//dw_preinsc.event carga()


IF dw_preinsc.ROWCOUNT() <= 0 THEN 
	MESSAGEBOX("Aviso", "No se han seleccionado registros para actualizar.") 
	RETURN 0
END IF
dw_preinsc.UPDATE()


dw_preinsc.setfilter("status<>0")
dw_preinsc.filter()

FOR ll_renglon_1=1 TO dw_preinsc.rowcount()
	dw_preinsc.scrolltorow(ll_renglon_1)
	ll_cuenta=dw_preinsc.object.cuenta[ll_renglon_1]
	dw_cap_mat_preinsc.retrieve(ll_cuenta,gi_periodo,gi_anio)
	if dw_cap_mat_preinsc.rowcount()>0 then
		dw_preinsc.object.status[ll_renglon_1]=2
		
		SELECT academicos.nivel,academicos.cve_carrera,academicos.cve_plan
		INTO :ls_nivel,:li_carr,:li_plan
		FROM academicos
		WHERE academicos.cuenta = :ll_cuenta
		USING gtr_sce;
		
		FOR ll_renglon_3=1 TO dw_cap_mat_preinsc.rowcount()
			if gi_periodo=dw_cap_mat_preinsc.object.periodo[ll_renglon_3] and &
				gi_anio=dw_cap_mat_preinsc.object.anio[ll_renglon_3] then
				ll_clave=dw_cap_mat_preinsc.object.cve_mat[ll_renglon_3]
				ls_grupo=dw_cap_mat_preinsc.object.gpo[ll_renglon_3]	
				li_status=f_e_mat(ll_clave)
				li_status=f_e_grup(ll_clave,ls_grupo)+li_status
				li_status=f_e_plan(ls_nivel,li_carr,li_plan,ll_clave)+li_status
				li_status=f_no_curso(ll_cuenta,ll_clave)+li_status
				li_status=f_puede_integracion(ll_cuenta,ll_clave)+li_status
				li_status=f_puede_cursar(ll_cuenta,ll_clave,li_carr,li_plan)+li_status
				dw_cap_mat_preinsc.object.status[ll_renglon_3]=li_status
			end if
		NEXT
		
		dw_cap_mat_preinsc.event actualiza()
	else
		dw_preinsc.object.status[ll_renglon_1]=1
	end if
NEXT 

MESSAGEBOX("Aviso", "Se han actualizado los registros.") 



end event

type dw_preinsc from uo_dw_captura within w_preinsc
event type integer carga ( )
integer x = 5
integer y = 416
integer width = 3506
integer height = 1496
integer taborder = 0
string dataobject = "d_preinsc"
end type

event carga;/*
DESCRIPCIÓN: Carga a las personas que tienen materias preinscritas. En el semestre dado.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
event inicia_transaction_object()
event actualiza()
event primero()
return retrieve(gi_periodo,gi_anio)
end event

event inicia_transaction_object();call super::inicia_transaction_object;tr_dw_propio = itr_web
end event

type dw_cap_mat_preinsc from uo_dw_captura within w_preinsc
event constructor pbm_constructor
event type integer actualiza ( )
integer x = 146
integer y = 720
integer taborder = 0
string dataobject = "d_cap_mat_preinsc"
end type

event constructor;/*
DESCRIPCIÓN: Evita el código: triggerevent("asigna_dw_menu")
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/

triggerevent("inicia_transaction_object")
end event

event type integer actualiza();/*
DESCRIPCIÓN: Actualiza normal pero sin preguntas.
PARÁMETROS: Ninguno
REGRESA: 1 si no hay error, -1 si hay error.
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
AcceptText()
if ModifiedCount()+DeletedCount() > 0 Then
	if update(true) = 1 then		
		commit using itr_web;
		return 1
	else
		rollback using itr_web;
		return -1
	end if
else
	return 1
end if
end event

event inicia_transaction_object();call super::inicia_transaction_object;tr_dw_propio = itr_web
end event

