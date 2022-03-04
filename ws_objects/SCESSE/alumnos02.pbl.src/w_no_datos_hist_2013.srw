$PBExportHeader$w_no_datos_hist_2013.srw
$PBExportComments$Despliegue de datos academicos de un alumno (Carrera, Semestre, Subsistema, Fecha de Ingreso, Fecha de Egreso,.....)
forward
global type w_no_datos_hist_2013 from w_master_main
end type
type dw_no_academicos from uo_master_dw within w_no_datos_hist_2013
end type
type uo_nombre from uo_nombre_alumno_2013 within w_no_datos_hist_2013
end type
type dw_reporte from uo_master_dw within w_no_datos_hist_2013
end type
end forward

global type w_no_datos_hist_2013 from w_master_main
integer width = 4786
integer height = 2724
string title = "Traslado de información"
string menuname = "m_menu_general_2013"
boolean clientedge = true
event double ( )
dw_no_academicos dw_no_academicos
uo_nombre uo_nombre
dw_reporte dw_reporte
end type
global w_no_datos_hist_2013 w_no_datos_hist_2013

type variables
boolean ib_modificando=false
Datawindowchild dwc_subsis,dwc_carrera,dwc_plan
integer ii_periodo, ii_anio,ii_sw
long il_cuenta,il_carrera, il_plan
end variables

forward prototypes
public function integer wf_validar ()
public function boolean inserta_academicos_hist (long an_cuenta, integer an_carrera, integer an_plan, long an_reng)
end prototypes

public function integer wf_validar ();long ll_cve_carrera,ll_cve_plan,ll_find,ll_ren
string ls_filtro
int li_i,li_aca_hist
datetime ldt_fec_servidor
if dw_no_academicos.Rowcount() = 0 and ib_modificando = true then return 1

ll_ren = dw_no_academicos.Rowcount()

if ll_ren = 0 then
	messagebox('Aviso','Favor de seleccionar la(s) carrera(s) a trasladar',Exclamation!,Ok!)
	return -1
end if

for li_i = 1 to ll_ren
	ll_cve_carrera = dw_no_academicos.Getitemnumber(li_i,'cve_carrera')
	if ll_cve_carrera = 0 then
		messagebox('Aviso','No puede transferir información SIN CARRERA',Exclamation!,Ok!)
		return -1
	end if
	ll_cve_plan = dw_no_academicos.Getitemnumber(li_i,'cve_plan')
	ls_filtro = 'cve_carrera = ' + string(ll_cve_carrera) + ' and cve_plan = ' + string(ll_cve_plan) + ' and en_aca_hist = 1'
	dw_no_academicos.Setfilter(ls_filtro)
	dw_no_academicos.Filter()
	ll_ren = dw_no_academicos.Rowcount()
	if ll_ren > 1 then
		messagebox('Aviso','No puede selecionar la misma carrera-plan para el mismo alumno',Exclamation!,Ok!)
		dw_no_academicos.Setfilter('')
		dw_no_academicos.Filter()
		return -1
	end if
	dw_no_academicos.Setfilter('')
	dw_no_academicos.Filter()	

//	ll_cve_carrera = dw_no_academicos.Getitemnumber(li_i,'cve_carrera')
//	ll_cve_plan = dw_no_academicos.Getitemnumber(li_i,'cve_plan')
//	ls_filtro = 'cve_carrera = ' + string(ll_cve_carrera) + ' and cve_plan = ' + string(ll_cve_plan)
//	ll_find = li_i + 1
//	if ll_find <= ll_ren then
//		ll_find = dw_no_academicos.Find(ls_filtro, ll_find, ll_ren)
//		li_aca_hist = dw_no_academicos.Getitemnumber(ll_find,'en_aca_hist')
//		if ll_find > 0 and li_aca_hist = 1 then
//			messagebox('Aviso','No puede selecionar la misma carrera-plan para el mismo alumno',Exclamation!,Ok!)
////			dw_no_academicos.Setfilter('')
////			dw_no_academicos.Filter()
//			return -1
//		elseif ll_find > 0 and li_aca_hist = 0 then
//			ldt_fec_servidor = datetime(f_obten_fecha_servidor() )
//			dw_no_academicos.Setitem(li_i,'fec_modif',ldt_fec_servidor)
//			dw_no_academicos.Setitem(li_i,'usuario_modif',gs_usuario)
//		end if
//	end if
end for

return 1


end function

public function boolean inserta_academicos_hist (long an_cuenta, integer an_carrera, integer an_plan, long an_reng);int li_cve_subsist_hist,li_sem_cursados_hist,li_creditos_cursados_hist,li_egresado_hist,li_periodo_ing_hist
int li_anio_ing_hist, li_periodo_egre_hist,li_anio_egre_hist,li_cve_formaingreso_hist,li_ceremonia_mes_hist,li_ceremonia_anio_hist
int li_reg
datetime ldt_fec_servidor
string ls_nivel_hist,ls_mensaje_sql
dec ldc_promedio_hist

li_cve_subsist_hist = dw_no_academicos.Getitemnumber(an_reng,'cve_subsistema')
ls_nivel_hist = dw_no_academicos.Getitemstring(an_reng,'nivel')
ldc_promedio_hist = dw_no_academicos.Getitemdecimal(an_reng,'promedio')
li_sem_cursados_hist = dw_no_academicos.Getitemnumber(an_reng,'sem_cursados')
li_creditos_cursados_hist = dw_no_academicos.Getitemnumber(an_reng,'creditos_cursados')
li_egresado_hist = dw_no_academicos.Getitemnumber(an_reng,'egresado')
li_periodo_ing_hist = dw_no_academicos.Getitemnumber(an_reng,'periodo_ing')
li_anio_ing_hist = dw_no_academicos.Getitemnumber(an_reng,'anio_ing')
li_periodo_egre_hist = dw_no_academicos.Getitemnumber(an_reng,'periodo_egre')
li_anio_egre_hist = dw_no_academicos.Getitemnumber(an_reng,'anio_egre')
li_cve_formaingreso_hist = dw_no_academicos.Getitemnumber(an_reng,'cve_formaingreso')
li_ceremonia_mes_hist = dw_no_academicos.Getitemnumber(an_reng,'ceremonia_mes')
li_ceremonia_anio_hist = dw_no_academicos.Getitemnumber(an_reng,'ceremonia_anio')

select count(*)
		into :li_reg
	from academicos_hist
	where cuenta = :an_cuenta and
			cve_carrera = :an_carrera and
			cve_plan = :an_plan
	using gtr_sce;
if li_reg = 0 then //si no lo encuentra lo inserta en academicos_hist
	insert  academicos_hist (cuenta,   
	         						cve_carrera,   
    									cve_plan,   
    									cve_subsistema,   
    									nivel,   
    									promedio,   
    									sem_cursados,   
    									creditos_cursados,   
    									egresado,   
    									periodo_ing,   
    									anio_ing,   
    									periodo_egre,   
    									anio_egre,   
    									cve_formaingreso,   
    									ceremonia_mes,   
    									ceremonia_anio,
									vigente)
		Values (:an_cuenta,
		:an_carrera ,
		:an_plan,
		:li_cve_subsist_hist,
		:ls_nivel_hist,   
		:ldc_promedio_hist,   
		:li_sem_cursados_hist,   
		:li_creditos_cursados_hist,   
		:li_egresado_hist,   
		:li_periodo_ing_hist,   
		:li_anio_ing_hist,   
		:li_periodo_egre_hist,   
		:li_anio_egre_hist,   
		:li_cve_formaingreso_hist,   
		:li_ceremonia_mes_hist,   
		:li_ceremonia_anio_hist,
		0 )
			using gtr_sce;
				
		li_reg = gtr_sce.sqlcode
		ls_mensaje_sql = gtr_sce.sqlerrtext
		
		if li_reg = 0 Then		
//			commit using gtr_sce;
	   Elseif li_reg= -1 then
//			rollback using gtr_sce;
			MessageBox("Error al actualizar la tabla de academicos_hist",ls_mensaje_sql)
		end if
		
end if
		
if li_reg < 0 Then		
	return false
else
	return true
end if

end function

on w_no_datos_hist_2013.create
int iCurrent
call super::create
if this.MenuName = "m_menu_general_2013" then this.MenuID = create m_menu_general_2013
this.dw_no_academicos=create dw_no_academicos
this.uo_nombre=create uo_nombre
this.dw_reporte=create dw_reporte
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_no_academicos
this.Control[iCurrent+2]=this.uo_nombre
this.Control[iCurrent+3]=this.dw_reporte
end on

on w_no_datos_hist_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_no_academicos)
destroy(this.uo_nombre)
destroy(this.dw_reporte)
end on

event doubleclicked;call super::doubleclicked;long cuentalocal,ll_ren
int sub_sist
//char nivel


//ll_row = uo_nombre.dw_nombre_alumno.GetRow()
//ll_cuenta = uo_nombre.dw_nombre_alumno.GetItemNumber(ll_row, "cuenta")
il_cuenta = long(uo_nombre.of_obten_cuenta())

if dw_no_academicos.retrieve(uo_nombre.of_obten_cuenta()) = 0 then
	messagebox('Aviso','El alumno no tiene información a trasladar')
end if





end event

event open;call super::open;m_menu_general_2013.m_registro.m_nuevo.enabled = False
m_menu_general_2013.m_registro.m_borraregistro.enabled = False
m_menu_general_2013.m_archivo.m_imprimir.enabled = true

dw_no_academicos.settransobject(gtr_sce)
dw_reporte.settransobject(gtr_sce)
dw_reporte.Retrieve() 



uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios 
luo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, "L", gtr_sce) 
luo_periodo_servicios.f_modifica_lista_columna( dw_no_academicos, "periodo_ing", "C") 
luo_periodo_servicios.f_modifica_lista_columna( dw_no_academicos, "periodo_egre", "C") 


end event

event ue_actualiza;call super::ue_actualiza;// Original Por: Carlos Melgoza
// Modificado por: Juan Campos 20-Feb-1997

Int  li_res,li_replica_activa,li_i,li_aca_hist
long ll_ren, ll_cve_carrera,ll_cve_plan
datetime ldt_fec_servidor

if ib_modificando then
	li_res = wf_validar ()
	if li_res = -1 then
		rollback using gtr_sce;
		messagebox("Información","No se han guardado los cambios")	
		return
	end if

	il_cuenta = long(uo_nombre.of_obten_cuenta())
	ll_ren = dw_no_academicos.Rowcount()
	
	if dw_no_academicos.Rowcount( ) > 0  and ib_modificando THEN 

		for li_i = 1 to ll_ren
			ll_cve_carrera = dw_no_academicos.Getitemnumber(li_i,'cve_carrera')
			ll_cve_plan = dw_no_academicos.Getitemnumber(li_i,'cve_plan')
			li_aca_hist = dw_no_academicos.Getitemnumber(li_i,'en_aca_hist')
			if li_aca_hist = 1 then
				if inserta_academicos_hist(il_cuenta,ll_cve_carrera,ll_cve_plan,li_i) then
					ldt_fec_servidor = datetime(f_obten_fecha_servidor() )
					dw_no_academicos.Setitem(li_i,'fec_modif',ldt_fec_servidor)
					dw_no_academicos.Setitem(li_i,'usuario_modif',gs_usuario)
				end if
			else
				ldt_fec_servidor = datetime(f_obten_fecha_servidor() )
				dw_no_academicos.Setitem(li_i,'fec_modif',ldt_fec_servidor)
				dw_no_academicos.Setitem(li_i,'usuario_modif',gs_usuario)
			end if
		end for
		if dw_no_academicos.update() = 1 then
			commit using gtr_sce;	
			messagebox("Información","Se han guardado los cambios")				
			triggerevent(doubleclicked!)
		else
			rollback using gtr_sce;
			messagebox("Información","No se han guardado los cambios")	
			return
		end if
	end if
else
	rollback using gtr_sce;
	messagebox("Información","No se han guardado los cambios")	
	return
end if
end event

event activate;//
end event

event closequery;//
end event

type st_sistema from w_master_main`st_sistema within w_no_datos_hist_2013
end type

type p_ibero from w_master_main`p_ibero within w_no_datos_hist_2013
end type

type dw_no_academicos from uo_master_dw within w_no_datos_hist_2013
integer x = 101
integer y = 660
integer width = 4576
integer height = 824
integer taborder = 40
string dataobject = "dw_no_academicos_hist_2013"
boolean vscrollbar = false
boolean resizable = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string ls_nivel, ls_columna, ls_cve_carrera
long ll_cve_carrera, ll_row
integer li_cve_plan,li_cve_subsis

ll_row = this.GetRow()

if ib_modificando then
	return
end if

ib_modificando = true

//this.AcceptText()

ls_columna =this.GetColumnName()
idw_trabajo = this

end event

event constructor;call super::constructor;idw_trabajo = this

end event

type uo_nombre from uo_nombre_alumno_2013 within w_no_datos_hist_2013
integer x = 101
integer y = 324
integer width = 3250
integer height = 320
integer taborder = 20
end type

event constructor;call super::constructor;m_menu_general_2013.objeto =this

end event

on uo_nombre.destroy
call uo_nombre_alumno_2013::destroy
end on

type dw_reporte from uo_master_dw within w_no_datos_hist_2013
boolean visible = false
integer x = 87
integer y = 1504
integer width = 3296
integer height = 824
integer taborder = 50
boolean bringtotop = true
boolean enabled = false
string dataobject = "dw_no_academicos_hist_rep_2013"
boolean hscrollbar = false
boolean vscrollbar = false
end type

event constructor;call super::constructor;m_menu_general_2013.dw = this
end event

