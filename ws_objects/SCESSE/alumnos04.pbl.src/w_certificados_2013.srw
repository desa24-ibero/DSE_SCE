$PBExportHeader$w_certificados_2013.srw
$PBExportComments$Esta ventana hace operaciones con certificados
forward
global type w_certificados_2013 from w_master_main
end type
type uo_nombre from uo_carreras_alumno_lista within w_certificados_2013
end type
type dw_certificados from uo_master_dw within w_certificados_2013
end type
end forward

global type w_certificados_2013 from w_master_main
integer x = 5
integer y = 4
integer width = 4238
integer height = 2240
string title = "Certificados"
string menuname = "m_menu_general_2013"
boolean center = true
uo_nombre uo_nombre
dw_certificados dw_certificados
end type
global w_certificados_2013 w_certificados_2013

type variables
boolean ib_modificando = false
long il_cuenta,il_carrera,il_plan
end variables

on w_certificados_2013.create
int iCurrent
call super::create
if this.MenuName = "m_menu_general_2013" then this.MenuID = create m_menu_general_2013
this.uo_nombre=create uo_nombre
this.dw_certificados=create dw_certificados
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_nombre
this.Control[iCurrent+2]=this.dw_certificados
end on

on w_certificados_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nombre)
destroy(this.dw_certificados)
end on

event ue_actualiza;call super::ue_actualiza;integer li_res

if  ib_modificando = false then return

li_res = wf_validar ()
if li_res = -1 then
	rollback using gtr_sce;
	messagebox("Información","No se han guardado los cambios")	
	return
end if

IF dw_certificados.Update(True,True) = 1 Then 
	Commit using gtr_sce;
	
	messagebox("Información","Se han guardado los cambios")				
else
	rollback using gtr_sce;
	messagebox("Información","No se han guardado los cambios")	
	return
end if
end event

event doubleclicked;call super::doubleclicked;
il_cuenta = uo_nombre.of_obten_cuenta()
il_carrera = uo_nombre.istr_carrera.str_cve_carrera
il_plan = uo_nombre.istr_carrera.str_cve_plan


dw_certificados.Retrieve(il_cuenta,il_carrera)


end event

event open;call super::open;m_menu_general_2013.m_archivo.m_leer.visible = False
m_menu_general_2013.m_archivo.m_imprimir.visible = False
m_menu_general_2013.m_archivo.m_salvar.visible = False
m_menu_general_2013.m_archivo.m_leer.Toolbaritemvisible = False
m_menu_general_2013.m_archivo.m_imprimir.Toolbaritemvisible = False
m_menu_general_2013.m_archivo.m_salvar.Toolbaritemvisible = False
//g_nv_security.fnv_secure_window (this)
integer li_x_units, li_y_units

uo_nombre.em_cuenta.text = " "
dw_certificados.Settransobject(gtr_sce)

triggerevent(doubleclicked!) 
/**/gnv_app.inv_security.of_SetSecurity(this)



end event

event closequery;//
end event

event ue_nuevo;call super::ue_nuevo;long ll_ren

ll_ren = dw_certificados.insertrow(0)

dw_certificados.Setitem(ll_ren,'cuenta',il_cuenta)
dw_certificados.Setitem(ll_ren,'cve_carrera',il_carrera)
dw_certificados.Setitem(ll_ren,'cve_plan',il_plan)
end event

event ue_borra;call super::ue_borra;if messagebox("Aviso","¿Esta seguro de querer borrar el campo actual?",Question!,YesNo!,2) = 1 then
	dw_certificados.deleterow(dw_certificados.getrow())
	ib_modificando = true
end if
end event

event close;if  ib_modificando = true then
	if messagebox('Aviso','¿Desea guardar los cambios?',Question!,Yesno!) = 1 then
		if wf_validar () <> 1 then 	
			rollback using gtr_sce;
			messagebox("Información","No se han guardado los cambios")	
			return 
		else
			 triggerevent("ue_actualiza")
		end if
	end if
end if
end event

type st_sistema from w_master_main`st_sistema within w_certificados_2013
end type

type p_ibero from w_master_main`p_ibero within w_certificados_2013
end type

type uo_nombre from uo_carreras_alumno_lista within w_certificados_2013
event destroy ( )
integer x = 69
integer y = 328
integer width = 3223
integer taborder = 10
boolean bringtotop = true
end type

on uo_nombre.destroy
call uo_carreras_alumno_lista::destroy
end on

event constructor;call super::constructor;m_menu_general_2013.objeto = this
end event

type dw_certificados from uo_master_dw within w_certificados_2013
integer x = 37
integer y = 880
integer width = 3310
integer height = 1028
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_certificados_2013"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;call super::itemchanged;datetime ldt_fecha
date ld_fecha
int	li_anio,li_mes, li_dia
if dwo.name = "fecha_entrada_sep" then
	li_anio = integer(mid(data,1,4))
	li_mes = integer(mid(data,6,2))
	li_dia = integer(mid(data,9,2))
	if li_mes <= 10 then
		li_mes += 2
	else
		li_anio++
		li_mes -= 10
	end if
	ld_fecha = date(li_anio, li_mes, li_dia)
	ldt_fecha = datetime(ld_fecha)
	setitem(getrow(),"fecha_salida_tentat_sep",ld_fecha)
end if
 ib_modificando = true
end event

event constructor;call super::constructor;idw_trabajo = this
end event

