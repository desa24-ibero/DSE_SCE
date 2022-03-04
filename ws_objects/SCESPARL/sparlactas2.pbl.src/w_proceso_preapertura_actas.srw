$PBExportHeader$w_proceso_preapertura_actas.srw
forward
global type w_proceso_preapertura_actas from pfc_w_master
end type
type cb_obtener_actas from commandbutton within w_proceso_preapertura_actas
end type
type st_1 from statictext within w_proceso_preapertura_actas
end type
type dw_periodos_acta_evaluacion_preeliminar from datawindow within w_proceso_preapertura_actas
end type
type st_descripcion_tipo_periodo from statictext within w_proceso_preapertura_actas
end type
type dw_previo from datawindow within w_proceso_preapertura_actas
end type
type cb_ok from commandbutton within w_proceso_preapertura_actas
end type
type st_periodo_anio from statictext within w_proceso_preapertura_actas
end type
type st_trans_mat_preinsc from statictext within w_proceso_preapertura_actas
end type
type st_trans_preinsc from statictext within w_proceso_preapertura_actas
end type
type gb_1 from groupbox within w_proceso_preapertura_actas
end type
end forward

global type w_proceso_preapertura_actas from pfc_w_master
integer width = 3113
integer height = 1524
string title = "Preapertura de actas"
cb_obtener_actas cb_obtener_actas
st_1 st_1
dw_periodos_acta_evaluacion_preeliminar dw_periodos_acta_evaluacion_preeliminar
st_descripcion_tipo_periodo st_descripcion_tipo_periodo
dw_previo dw_previo
cb_ok cb_ok
st_periodo_anio st_periodo_anio
st_trans_mat_preinsc st_trans_mat_preinsc
st_trans_preinsc st_trans_preinsc
gb_1 gb_1
end type
global w_proceso_preapertura_actas w_proceso_preapertura_actas

type variables
n_tr itr_web
int ii_periodo,ii_anio
st_confirma_usuario ist_confirma_usuario


uo_periodo_servicios iuo_periodo_servicios 


end variables

forward prototypes
public subroutine wf_recupera_actas ()
public function integer wf_borra_actas (integer periodo, integer anio, string tipo_exam, transaction conexion)
public function integer wf_respalda_actas (integer periodo, integer anio, string tipo_exam, transaction conexion)
end prototypes

public subroutine wf_recupera_actas ();long ll_reg,ll_periodo,ll_anio,ll_row


dw_previo.Reset()

//Extraordinario y a Tit
declare cur cursor for
	select count(*),periodo,anio
	from acta_evaluacion_preeliminar
	where cve_tipo_examen in (2,6)
	and periodo = :ii_periodo 
	group by periodo,anio
	order by anio, periodo
	using gtr_sce;
open cur;
Fetch cur into :ll_reg,:ll_periodo,:ll_anio;
do while gtr_sce.sqlcode = 0 
	ll_row = dw_previo.Insertrow(0)
	dw_previo.Setitem(ll_row,1,'EXT')
	dw_previo.Setitem(ll_row,2,ll_periodo)
	dw_previo.Setitem(ll_row,3,ll_anio)
	dw_previo.Setitem(ll_row,4,ll_reg)
	if ll_periodo = ii_periodo and ll_anio = ii_anio then
		dw_previo.Setitem(ll_row,5,0)
	else
		dw_previo.Setitem(ll_row,5,1)
	end if
	Fetch cur into :ll_reg,:ll_periodo,:ll_anio;
loop
close cur;

//Ordinario
declare cur2 cursor for
	select count(*),periodo,anio
	from acta_evaluacion_preeliminar
	where cve_tipo_examen = 3
	and periodo = :ii_periodo
	group by periodo,anio
	order by anio, periodo
	using gtr_sce;
open cur2;
Fetch cur2 into :ll_reg,:ll_periodo,:ll_anio;
do while gtr_sce.sqlcode = 0 
	ll_row = dw_previo.Insertrow(0)
	dw_previo.Setitem(ll_row,1,'ORD')
	dw_previo.Setitem(ll_row,2,ll_periodo)
	dw_previo.Setitem(ll_row,3,ll_anio)
	dw_previo.Setitem(ll_row,4,ll_reg)
	if ll_periodo = ii_periodo and ll_anio = ii_anio then
		dw_previo.Setitem(ll_row,5,0)
	else
		dw_previo.Setitem(ll_row,5,1)
	end if
	Fetch cur2 into :ll_reg,:ll_periodo,:ll_anio;
loop
close cur2;

dw_previo.Groupcalc()
dw_previo.Setsort('anio asc,periodo asc')
dw_previo.Sort()



end subroutine

public function integer wf_borra_actas (integer periodo, integer anio, string tipo_exam, transaction conexion);int li_tip_exa[2]

if tipo_exam = 'ORD' then
	li_tip_exa[1] = 3
	li_tip_exa[2] = 3
else
	li_tip_exa[1] = 2
	li_tip_exa[2] = 6
end if

delete from acta_evaluacion_preeliminar
where periodo = :periodo
and anio = :anio 
and cve_tipo_examen in (:li_tip_exa[1],:li_tip_exa[2])
using conexion;

if conexion.sqlcode = 0 then
	delete from 	acta_evaluacion_transf
	where periodo = :periodo
	and anio = :anio 
	and cve_tipo_examen in (:li_tip_exa[1],:li_tip_exa[2])
	using conexion;
	
	if conexion.sqlcode = 0 then
		delete from alumno_acta_evaluacion_preelim
		where periodo = :periodo
		and anio = :anio 
		and cve_tipo_examen in (:li_tip_exa[1],:li_tip_exa[2])
		using conexion;
	
		if conexion.sqlcode = 0 then
			delete from alumno_acta_evaluacion_transf
			where periodo = :periodo
			and anio = :anio 
			and cve_tipo_examen in (:li_tip_exa[1],:li_tip_exa[2])
			using conexion;
			
			if conexion.sqlcode = 0 then
				return 1
			else
				messagebox('Error','No se borró información de alumno_acta_evaluacion_transf',Stopsign!,ok!)
				return -1
			end if
		else
			messagebox('Error','No se borró información de alumno_acta_evaluacion_preelim',Stopsign!,ok!)
			return -1
		end if
	else
		messagebox('Error','No se borró información de acta_evaluacion_transf',Stopsign!,ok!)
		return -1
	end if
else
	messagebox('Error','No se borró información de acta_evaluacion_preeliminar',Stopsign!,ok!)
	return -1
end if

end function

public function integer wf_respalda_actas (integer periodo, integer anio, string tipo_exam, transaction conexion);int li_tip_exa[2]

if tipo_exam = 'ORD' then
	li_tip_exa[1] = 3
	li_tip_exa[2] = 3
else
	li_tip_exa[1] = 2
	li_tip_exa[2] = 6
end if

insert into
hist_acta_evaluacion_pre
select * 
from acta_evaluacion_preeliminar
where periodo = :periodo
and anio = :anio 
and cve_tipo_examen in (:li_tip_exa[1],:li_tip_exa[2])
using conexion;

if conexion.sqlcode = 0 then
	insert into
	hist_acta_evaluacion_transf
	select * from 
	acta_evaluacion_transf
	where periodo = :periodo
	and anio = :anio 
	and cve_tipo_examen in (:li_tip_exa[1],:li_tip_exa[2])
	using conexion;
	
	if conexion.sqlcode = 0 then
		insert into
		hist_alumno_acta_evaluacion_pr
		select * from 
		alumno_acta_evaluacion_preelim
		where periodo = :periodo
		and anio = :anio 
		and cve_tipo_examen in (:li_tip_exa[1],:li_tip_exa[2])
		using conexion;
	
		if conexion.sqlcode = 0 then
			insert into
			hist_alumno_acta_evaluacion_tr
			select * from 
			alumno_acta_evaluacion_transf
			where periodo = :periodo
			and anio = :anio 
			and cve_tipo_examen in (:li_tip_exa[1],:li_tip_exa[2])
			using conexion;
			
			if conexion.sqlcode = 0 then
				return 1
			else
				messagebox('Error','No se inserto en historico la información de alumno_acta_evaluacion_transf',Stopsign!,ok!)
				return -1
			end if
		else
			messagebox('Error','No se inserto en historico la información de alumno_acta_evaluacion_preelim',Stopsign!,ok!)
			return -1
		end if
	else
		messagebox('Error','No se inserto en historico la información de acta_evaluacion_transf',Stopsign!,ok!)
		return -1
	end if
else
	messagebox('Error','No se inserto en historico la información de acta_evaluacion_preeliminar',Stopsign!,ok!)
	return -1
end if

end function

on w_proceso_preapertura_actas.create
int iCurrent
call super::create
this.cb_obtener_actas=create cb_obtener_actas
this.st_1=create st_1
this.dw_periodos_acta_evaluacion_preeliminar=create dw_periodos_acta_evaluacion_preeliminar
this.st_descripcion_tipo_periodo=create st_descripcion_tipo_periodo
this.dw_previo=create dw_previo
this.cb_ok=create cb_ok
this.st_periodo_anio=create st_periodo_anio
this.st_trans_mat_preinsc=create st_trans_mat_preinsc
this.st_trans_preinsc=create st_trans_preinsc
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_obtener_actas
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_periodos_acta_evaluacion_preeliminar
this.Control[iCurrent+4]=this.st_descripcion_tipo_periodo
this.Control[iCurrent+5]=this.dw_previo
this.Control[iCurrent+6]=this.cb_ok
this.Control[iCurrent+7]=this.st_periodo_anio
this.Control[iCurrent+8]=this.st_trans_mat_preinsc
this.Control[iCurrent+9]=this.st_trans_preinsc
this.Control[iCurrent+10]=this.gb_1
end on

on w_proceso_preapertura_actas.destroy
call super::destroy
destroy(this.cb_obtener_actas)
destroy(this.st_1)
destroy(this.dw_periodos_acta_evaluacion_preeliminar)
destroy(this.st_descripcion_tipo_periodo)
destroy(this.dw_previo)
destroy(this.cb_ok)
destroy(this.st_periodo_anio)
destroy(this.st_trans_mat_preinsc)
destroy(this.st_trans_preinsc)
destroy(this.gb_1)
end on

event open;call super::open;int li_visible
long ll_ord_pre,ll_tit_pre

integer li_periodo , li_anio
string ls_periodo

x=1
y=1

Setpointer(hourglass!)

IF IsValid ( itr_web ) THEN
	Disconnect using itr_web;
END IF

if conecta_bd(itr_web,gs_web_param, gs_usuario,gs_password)<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	return
End if

f_obten_periodo(li_periodo, li_anio, 8)

ii_periodo = li_periodo
ii_anio = li_anio

//***************************
iuo_periodo_servicios = CREATE uo_periodo_servicios 
iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, 'L', gtr_sce)
ls_periodo = iuo_periodo_servicios.f_recupera_descripcion( li_periodo, 'L')
//***************************

//choose case ii_periodo
//	case 0
//		ls_periodo = 'PRIMAVERA'
//	case 1
//		ls_periodo = 'VERANO'
//	case 2
//		ls_periodo = 'OTOÑO'
//end choose

st_periodo_anio.text = ls_periodo+" - "+string(ii_anio)


// 18 Enero 2019, Oscar Sánchez. Se agrega un componente para que el usuario escoja el periodo ...
//wf_recupera_actas()

IF gs_multiples_periodos = 'S' THEN
	st_descripcion_tipo_periodo.Text = "TIPO DE PERIODO: " + gs_descripcion_tipo_periodo
ELSE
	st_descripcion_tipo_periodo.Text = ""
END IF

DataWindowChild dw_child
dw_periodos_acta_evaluacion_preeliminar.Reset ( )
dw_periodos_acta_evaluacion_preeliminar.GetChild ( "periodo" , dw_child )
dw_child.SetTransObject ( gtr_sce )
dw_child.Retrieve ( gs_tipo_periodo )

dw_periodos_acta_evaluacion_preeliminar.InsertRow ( 0 )

cb_obtener_actas.Enabled = False
cb_ok.Enabled = False
end event

type cb_obtener_actas from commandbutton within w_proceso_preapertura_actas
integer x = 2267
integer y = 700
integer width = 731
integer height = 128
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Obtener actas"
end type

event clicked;wf_recupera_actas()

end event

type st_1 from statictext within w_proceso_preapertura_actas
integer x = 146
integer y = 384
integer width = 891
integer height = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Periodos disponibles de actas:"
borderstyle borderstyle = StyleBox!
boolean focusrectangle = false
end type

type dw_periodos_acta_evaluacion_preeliminar from datawindow within w_proceso_preapertura_actas
integer x = 1344
integer y = 384
integer width = 686
integer height = 108
integer taborder = 20
string title = "none"
string dataobject = "dddw_acta_evaluacion_preeliminar_periodos"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;IF Not IsNull ( data )  or data <> '' THEN
	ii_periodo = Integer ( data )
	cb_obtener_actas.Enabled = True
END IF
end event

type st_descripcion_tipo_periodo from statictext within w_proceso_preapertura_actas
integer x = 1339
integer y = 192
integer width = 1243
integer height = 100
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "AQUI SE PRESENTA EL TIPO DE PERIODO."
borderstyle borderstyle = StyleBox!
boolean focusrectangle = false
end type

type dw_previo from datawindow within w_proceso_preapertura_actas
integer x = 146
integer y = 612
integer width = 2048
integer height = 544
integer taborder = 30
string title = "none"
string dataobject = "d_previo_actas"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;int li_periodo,li_anio

if dwo.name = 'proceso' then
	li_periodo = getitemnumber(row,'periodo')
	li_anio = getitemnumber(row,'anio')
	if li_periodo = ii_periodo and li_anio = ii_anio then
		if data = '1' then
			if messagebox('Aviso','¿Desea respaldar y borrar las actas del periodo actual?',Question!,yesno!) = 2 then
				return 2
			else
				Open(w_confirma_usuario)
				ist_confirma_usuario = Message.PowerObjectParm
				IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
					MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
					RETURN 2
				END IF
			end if
		end if
	else
		if data = '0' then
			return 2
		end if
	end if
end if

cb_ok.Enabled = True
end event

type cb_ok from commandbutton within w_proceso_preapertura_actas
integer x = 2267
integer y = 884
integer width = 731
integer height = 128
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Transferencia a histórico"
end type

event clicked;int li_i,li_proceso,li_res,li_tip_exa[2]
long ll_periodo,ll_anio
string ls_tip_exa,ls_exam

if messagebox('Aviso','¿Desea generar el proceso de Preapertura de actas?', Question!,Yesno!) = 2 then
	this.enabled = false
	messagebox('Aviso','No se pudo ejecutar el proceso de Preapertura de actas')
	return 
end if

Setpointer(Hourglass!)
for li_i = 1 to dw_previo.Rowcount()
	li_proceso = dw_previo.Getitemnumber(li_i,'proceso')
	if li_proceso = 1 then
		ll_periodo = dw_previo.Getitemnumber(li_i,'periodo')
		ll_anio = dw_previo.Getitemnumber(li_i,'anio')
		ls_tip_exa = dw_previo.Getitemstring(li_i,'tipo_examen')
		li_res = wf_respalda_actas (ll_periodo,ll_anio,ls_tip_exa,gtr_sce)
		if li_res = 1 then
			Commit using gtr_sce;
			li_res = wf_borra_actas (ll_periodo,ll_anio,ls_tip_exa,gtr_sce)
			if li_res = 1 then
				Commit using gtr_sce;
			else
				Rollback using gtr_sce;
				exit
			end if
		else
			Rollback using gtr_sce;
			exit
		end if
		li_res = wf_respalda_actas (ll_periodo,ll_anio,ls_tip_exa,itr_web)
		if li_res = 1 then
			Commit using itr_web;
			li_res = wf_borra_actas (ll_periodo,ll_anio,ls_tip_exa,itr_web)
			if li_res = 1 then
				Commit using itr_web;
			else
				Rollback using itr_web;
				exit
			end if
		else
			Rollback using itr_web;
			exit
		end if
	end if
end for

wf_recupera_actas()
messagebox('Aviso','Proceso terminado')
Parent.TriggerEvent ( Open! )
end event

type st_periodo_anio from statictext within w_proceso_preapertura_actas
integer x = 146
integer y = 176
integer width = 983
integer height = 116
boolean bringtotop = true
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "PERIODO - AÑO"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_trans_mat_preinsc from statictext within w_proceso_preapertura_actas
integer x = 1170
integer y = 628
integer width = 896
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_trans_preinsc from statictext within w_proceso_preapertura_actas
integer x = 1170
integer y = 544
integer width = 896
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_proceso_preapertura_actas
integer x = 110
integer y = 60
integer width = 2926
integer height = 1232
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Proceso Preapertura Actas"
end type

