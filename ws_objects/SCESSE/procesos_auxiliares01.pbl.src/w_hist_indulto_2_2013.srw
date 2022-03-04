$PBExportHeader$w_hist_indulto_2_2013.srw
forward
global type w_hist_indulto_2_2013 from w_master_main
end type
type uo_1 from uo_per_ani within w_hist_indulto_2_2013
end type
type uo_nombre from uo_nombre_alumno_2013 within w_hist_indulto_2_2013
end type
type r_1 from rectangle within w_hist_indulto_2_2013
end type
type dw_hist_indulto from uo_master_dw within w_hist_indulto_2_2013
end type
end forward

global type w_hist_indulto_2_2013 from w_master_main
integer width = 3625
integer height = 2572
string title = "Indultos"
string menuname = "m_indultos_2013"
boolean maxbox = false
event ue_filtrar ( )
uo_1 uo_1
uo_nombre uo_nombre
r_1 r_1
dw_hist_indulto dw_hist_indulto
end type
global w_hist_indulto_2_2013 w_hist_indulto_2_2013

type variables
long     il_Cuenta
boolean ib_modificando
int ii_periodo,ii_anio
Datawindowchild dwc_periodo
uo_periodo_servicios iuo_periodo_servicios
end variables

forward prototypes
public function integer wf_validar ()
end prototypes

event ue_filtrar();long ll_ren

/*
uo_1.em_per.triggerevent(Modified!)
uo_1.em_ani.triggerevent(Modified!)

ii_periodo = gi_periodo
ii_anio = gi_anio
*/


ii_periodo=uo_1.iuo_periodo_servicios.f_recupera_id( uo_1.em_per.text, "L")
il_cuenta = long(uo_nombre.of_obten_cuenta())


ll_ren = dw_hist_indulto.Retrieve(il_cuenta,ii_periodo,ii_anio)

if ll_ren = 0 then
	dw_hist_indulto.Reset()
	messagebox('AVISO','No existe información con esa cuenta')
	return
end if
end event

public function integer wf_validar ();//Revisa que los registros sean lógicos y no estén repetidos
long ll_rows, ll_row_actual, ll_row_buscado
string ls_cve_indulto
string ls_busqueda_duplicado
integer li_periodo, li_anio

ll_rows = idw_trabajo.RowCount()
for ll_row_actual=1  to ll_rows
	ls_cve_indulto= idw_trabajo.GetItemString(ll_row_actual, "cve_indulto")
	li_periodo = idw_trabajo.GetItemNumber(ll_row_actual, "periodo")
	li_anio= idw_trabajo.GetItemNumber(ll_row_actual, "anio")
	ls_busqueda_duplicado = 'cve_indulto = "'+ls_cve_indulto+'" and periodo = '+string(li_periodo)+' and anio = '+string(li_anio) 
	ll_row_buscado = idw_trabajo.find(ls_busqueda_duplicado,1, ll_rows)
	if ll_row_buscado <> 0 and ll_row_buscado <> ll_row_actual then
		idw_trabajo.ScrollToRow(ll_row_actual)	
		MessageBox("Indulto Duplicado", "Favor de escribir un Indulto distinto", StopSign!)
		return -1	
	end if
next

return 1
end function

event activate;call super::activate;control_escolar.toolbarsheettitle="Indultos"
end event

on w_hist_indulto_2_2013.create
int iCurrent
call super::create
if this.MenuName = "m_indultos_2013" then this.MenuID = create m_indultos_2013
this.uo_1=create uo_1
this.uo_nombre=create uo_nombre
this.r_1=create r_1
this.dw_hist_indulto=create dw_hist_indulto
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.uo_nombre
this.Control[iCurrent+3]=this.r_1
this.Control[iCurrent+4]=this.dw_hist_indulto
end on

on w_hist_indulto_2_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.uo_nombre)
destroy(this.r_1)
destroy(this.dw_hist_indulto)
end on

event doubleclicked;call super::doubleclicked;il_cuenta = long(uo_nombre.of_obten_cuenta())
//ii_periodo = integer(uo_1.em_per.text)
ii_anio = integer(uo_1.em_ani.text)
ii_periodo=uo_1.iuo_periodo_servicios.f_recupera_id( uo_1.em_per.text, "L")

dw_hist_indulto.Getchild('periodo',dwc_periodo)
dwc_periodo.settransobject(gtr_sce)
dwc_periodo.retrieve(gs_tipo_periodo)

if il_cuenta = 0 then return

if dw_hist_indulto.Retrieve(il_cuenta,ii_periodo,ii_anio) = 0  then 
   messagebox('AVISO','No existe información con esa cuenta')
   dw_hist_indulto.Reset()
   return
end if

end event

event open;call super::open;dw_hist_indulto.Settransobject(gtr_sce)
uo_nombre.em_cuenta.text = " "

	//Modif. Roberto Novoa R.  Jun/2016 - Funcionalidad de periodos múltiples
	iuo_periodo_servicios = CREATE uo_periodo_servicios
	iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)

triggerevent(doubleclicked!) 

end event

event ue_actualiza;call super::ue_actualiza;int li_res

if ib_modificando then	
	li_res = wf_validar ()
	if li_res = -1 then
		rollback using gtr_sce;
		messagebox("Información","No se han guardado los cambios")	
		triggerevent(doubleclicked!)
		return
	end if
	
	if dw_hist_indulto.update(true) = 1 then
		commit using gtr_sce;	
		messagebox("Información","Se han guardado los cambios")				
		triggerevent(doubleclicked!)
	else
		rollback using gtr_sce;
		messagebox("Información","No se han guardado los cambios")	
		return
	end if
Else
	Rollback  using gtr_sce;
	triggerevent(doubleclicked!)
end if
 
end event

event closequery;//
end event

event ue_nuevo;call super::ue_nuevo;long ll_row
String ls_periodo

//ii_periodo = integer(uo_1.em_per.text)
ii_anio = integer(uo_1.em_ani.text)

ls_periodo=uo_1.em_per.text
ii_periodo=uo_1.iuo_periodo_servicios.f_recupera_id( uo_1.em_per.text, "L")
il_cuenta = long(uo_nombre.of_obten_cuenta())


dw_hist_indulto.scrolltorow(dw_hist_indulto.insertrow(0))
dw_hist_indulto.setcolumn(1)
ll_row= dw_hist_indulto.GetRow()
dw_hist_indulto.SetItem(ll_row, "cuenta", il_cuenta)
dw_hist_indulto.SetItem(ll_row, 'periodo', ii_periodo)
dw_hist_indulto.SetItem(ll_row, 'anio', ii_anio)
dw_hist_indulto.SetItem(ll_row, 'texper', ls_periodo)

end event

event close;if ib_modificando then
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

type st_sistema from w_master_main`st_sistema within w_hist_indulto_2_2013
integer textsize = -16
end type

type p_ibero from w_master_main`p_ibero within w_hist_indulto_2_2013
end type

type uo_1 from uo_per_ani within w_hist_indulto_2_2013
integer x = 1015
integer y = 796
integer width = 1253
integer height = 168
integer taborder = 10
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type uo_nombre from uo_nombre_alumno_2013 within w_hist_indulto_2_2013
integer x = 105
integer y = 368
integer taborder = 20
end type

on uo_nombre.destroy
call uo_nombre_alumno_2013::destroy
end on

event constructor;call super::constructor;iw_ventana = parent
m_indultos_2013.objeto = this

end event

type r_1 from rectangle within w_hist_indulto_2_2013
long linecolor = 128
integer linethickness = 5
long fillcolor = 16777215
integer x = 677
integer y = 1124
integer width = 1847
integer height = 1052
end type

type dw_hist_indulto from uo_master_dw within w_hist_indulto_2_2013
integer x = 699
integer y = 1160
integer width = 1751
integer height = 984
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_hist_indulto_2013"
boolean hscrollbar = false
end type

event constructor;call super::constructor;m_indultos_2013.dw = this
idw_trabajo = this
end event

event itemchanged;call super::itemchanged;ib_modificando = true
end event

