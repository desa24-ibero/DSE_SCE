$PBExportHeader$w_promedio_peso_hist.srw
forward
global type w_promedio_peso_hist from window
end type
type st_1 from statictext within w_promedio_peso_hist
end type
type cb_traspasar from commandbutton within w_promedio_peso_hist
end type
type uo_1 from uo_ver_per_ani within w_promedio_peso_hist
end type
type dw_1 from uo_dw_reporte within w_promedio_peso_hist
end type
end forward

global type w_promedio_peso_hist from window
integer x = 832
integer y = 360
integer width = 2889
integer height = 1964
boolean titlebar = true
string title = "Traspaso a Histórico de Promedios"
string menuname = "m_menu"
boolean resizable = true
long backcolor = 30976088
st_1 st_1
cb_traspasar cb_traspasar
uo_1 uo_1
dw_1 dw_1
end type
global w_promedio_peso_hist w_promedio_peso_hist

on w_promedio_peso_hist.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.st_1=create st_1
this.cb_traspasar=create cb_traspasar
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.cb_traspasar,&
this.uo_1,&
this.dw_1}
end on

on w_promedio_peso_hist.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.cb_traspasar)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type st_1 from statictext within w_promedio_peso_hist
integer x = 709
integer y = 16
integer width = 1184
integer height = 80
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "Periodo Destino de Transferencia"
boolean focusrectangle = false
end type

type cb_traspasar from commandbutton within w_promedio_peso_hist
integer x = 2432
integer y = 160
integer width = 315
integer height = 104
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Traspasar"
end type

event clicked;long ll_rows, ll_renglon
integer li_carrera, li_carrera_aux, li_codigo_error, li_codigo_error_2, li_codigo_error_3
integer li_cuenta_periodo, li_respuesta
decimal ld_peso
string ls_mensaje_error

ll_rows= dw_1.RowCount()


select count(*) into :li_cuenta_periodo 
from promedio_peso_hist
where clv_ver = :gi_version
and	clv_per = :gi_periodo
and	anio = :gi_anio
using gtr_sadm;
li_codigo_error= gtr_sadm.SQLCode
ls_mensaje_error= gtr_sadm.SQLErrText

if li_codigo_error = -1 then
   MessageBox("Error", "Error al buscar en la tabla: promedio_peso_hist "+ls_mensaje_error)
	return 
elseif li_codigo_error = 0 then
	if ll_rows>0 then 
		if li_cuenta_periodo > 0 then
	   	li_respuesta = MessageBox("Información Existente", &
		              "El periodo destino ya existe, ¿Desea sobreescribirlo con los datos actuales?", Question!, YesNo! )							
			if li_respuesta = 2 then
			   MessageBox("Información", "Transferencia a histórico suspendida")
				return 
			end if
		end if
	else
		MessageBox("Favor de cargar primero", "No es posible transferir datos sin haber consultado el reporte primero",StopSign!)
		return 
	end if
end if




for ll_renglon=1 to ll_rows
	li_carrera = dw_1.object.promedio_peso_clv_carr[ll_renglon]
	ld_peso = dw_1.object.promedio_peso_peso[ll_renglon]
	
	select clv_carr into :li_carrera_aux 
	from promedio_peso_hist
	where clv_carr = :li_carrera 
	and   clv_ver = :gi_version
	and	clv_per = :gi_periodo
	and	anio = :gi_anio
	using gtr_sadm;
	
	li_codigo_error= gtr_sadm.SQLCode
	ls_mensaje_error= gtr_sadm.SQLErrText
	
	if li_codigo_error = -1 then
	   MessageBox("Error", "Error al buscar en la tabla: promedio_peso_hist "+ls_mensaje_error)
		return 
	elseif li_codigo_error = 100 then
	   insert into	promedio_peso_hist
		(clv_ver, clv_per, anio, clv_carr, peso)
		values
		(:gi_version, :gi_periodo, :gi_anio, :li_carrera, :ld_peso)
		using gtr_sadm;
		
		li_codigo_error_2= gtr_sadm.SQLCode
		ls_mensaje_error= gtr_sadm.SQLErrText		
		if li_codigo_error_2 = -1 then
			rollback using gtr_sadm;
			MessageBox("Error", "Error al insertar en la tabla: promedio_peso_hist "+ls_mensaje_error)
			return 
		else
			commit using gtr_sadm;
		end if		
	elseif li_codigo_error = 0 then

		update promedio_peso_hist
		set clv_carr = :li_carrera,
		    peso = :ld_peso
		where clv_carr = :li_carrera 
		and   clv_ver = :gi_version
		and	clv_per = :gi_periodo
		and	anio = :gi_anio
		using gtr_sadm;
		
		li_codigo_error_3= gtr_sadm.SQLCode
		ls_mensaje_error= gtr_sadm.SQLErrText		
		
		if li_codigo_error_3 = -1 then
			rollback using gtr_sadm;
			MessageBox("Error", "Error al insertar en la tabla: promedio_peso_hist "+ls_mensaje_error)
			return 
		else
			commit using gtr_sadm;
		end if				
	end if	
	
next

MessageBox("Informacion", "El proceso de transferencia a histórico ha terminado")


end event

type uo_1 from uo_ver_per_ani within w_promedio_peso_hist
integer x = 27
integer y = 132
integer height = 164
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_promedio_peso_hist
integer x = 23
integer y = 368
integer width = 2766
integer height = 1348
integer taborder = 0
string dataobject = "dw_promedio_peso_hist"
boolean hscrollbar = true
boolean resizable = true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

