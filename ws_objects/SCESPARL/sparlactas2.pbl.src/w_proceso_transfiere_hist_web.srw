$PBExportHeader$w_proceso_transfiere_hist_web.srw
forward
global type w_proceso_transfiere_hist_web from pfc_w_master
end type
type st_proceso from statictext within w_proceso_transfiere_hist_web
end type
type st_registros from statictext within w_proceso_transfiere_hist_web
end type
type cb_ok from commandbutton within w_proceso_transfiere_hist_web
end type
type st_periodo_anio from statictext within w_proceso_transfiere_hist_web
end type
type st_trans_mat_preinsc from statictext within w_proceso_transfiere_hist_web
end type
type st_trans_preinsc from statictext within w_proceso_transfiere_hist_web
end type
type gb_1 from groupbox within w_proceso_transfiere_hist_web
end type
end forward

global type w_proceso_transfiere_hist_web from pfc_w_master
integer width = 3113
integer height = 1160
string title = "Transfiere histórico a Internet"
st_proceso st_proceso
st_registros st_registros
cb_ok cb_ok
st_periodo_anio st_periodo_anio
st_trans_mat_preinsc st_trans_mat_preinsc
st_trans_preinsc st_trans_preinsc
gb_1 gb_1
end type
global w_proceso_transfiere_hist_web w_proceso_transfiere_hist_web

type variables
n_tr itr_web
integer ii_periodo,ii_anio
st_confirma_usuario ist_confirma_usuario
u_pipeline_control iu_pipeline


end variables

on w_proceso_transfiere_hist_web.create
int iCurrent
call super::create
this.st_proceso=create st_proceso
this.st_registros=create st_registros
this.cb_ok=create cb_ok
this.st_periodo_anio=create st_periodo_anio
this.st_trans_mat_preinsc=create st_trans_mat_preinsc
this.st_trans_preinsc=create st_trans_preinsc
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_proceso
this.Control[iCurrent+2]=this.st_registros
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.st_periodo_anio
this.Control[iCurrent+5]=this.st_trans_mat_preinsc
this.Control[iCurrent+6]=this.st_trans_preinsc
this.Control[iCurrent+7]=this.gb_1
end on

on w_proceso_transfiere_hist_web.destroy
call super::destroy
destroy(this.st_proceso)
destroy(this.st_registros)
destroy(this.cb_ok)
destroy(this.st_periodo_anio)
destroy(this.st_trans_mat_preinsc)
destroy(this.st_trans_preinsc)
destroy(this.gb_1)
end on

event open;call super::open;long ll_regs

integer li_periodo , li_anio
string ls_periodo

x=1
y=1

Setpointer(hourglass!)

f_obten_periodo(li_periodo, li_anio, 5)

ii_periodo = li_periodo
ii_anio = li_anio

//choose case ii_periodo
//	case 0
//		ls_periodo = 'PRIMAVERA'
//	case 1
//		ls_periodo = 'VERANO'
//	case 2
//		ls_periodo = 'OTOÑO'
//end choose

uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios 
luo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, 'L', gtr_sce) 
ls_periodo  = luo_periodo_servicios.f_recupera_descripcion( ii_periodo, 'L')



st_periodo_anio.text = ls_periodo+" - "+string(ii_anio)

select count(*)
	into :ll_regs
from historico
where periodo = :ii_periodo
and anio = :ii_anio using gtr_sce;

if gtr_sce.sqlcode <> 0 then
	messagebox('Aviso','No existen registros en histórico a transferir del periodo actual')
	return
end if

st_registros.text = 'Registros en Histórico a transferir: ' + string(ll_regs,'#,##0')

if conecta_bd(itr_web,gs_web_param, gs_usuario,gs_password)<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de Control Escolar WEB", StopSign!)
	return
End if




end event

type st_proceso from statictext within w_proceso_transfiere_hist_web
integer x = 183
integer y = 564
integer width = 1646
integer height = 96
integer textsize = -10
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

type st_registros from statictext within w_proceso_transfiere_hist_web
integer x = 183
integer y = 448
integer width = 1646
integer height = 96
integer textsize = -10
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

type cb_ok from commandbutton within w_proceso_transfiere_hist_web
integer x = 2025
integer y = 512
integer width = 731
integer height = 128
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Transferir a WEB"
end type

event clicked;int li_rtn,li_i
string ls_msg,ls_classname
n_transfiere_sybase_sql_2 ln_transfiere_sybase_sql

if messagebox('Aviso','¿Desea generar el proceso de Transferencia de histórico?', Question!,Yesno!) = 2 then
	this.enabled = false
	messagebox('Aviso','No se pudo ejecutar el proceso de Transferencia de histórico')
	return 
end if

Open(w_confirma_usuario)
ist_confirma_usuario = Message.PowerObjectParm
IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
	MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
	RETURN 
END IF

this.enabled = false

Setpointer(hourglass!)

st_proceso.text = 'Procesando... espere por favor.'

delete from historico
where periodo = :ii_periodo
and anio = :ii_anio
using itr_web;

if itr_web.sqlcode <> 0 then
	messagebox('Error','No se pudo borrar historico de WEB')
	rollback using itr_web;
	return
else
	commit using itr_web;
end if

delete from historico_transfer
using itr_web;

delete from historico_transfer
using gtr_sce;

ls_classname =	w_proceso_transfiere_hist_web.ClassName()
ln_transfiere_sybase_sql =  create n_transfiere_sybase_sql_2

insert into historico_transfer 
select cuenta,cve_mat,gpo,periodo,anio,cve_carrera,cve_plan,calificacion,observacion
from historico
where periodo = :ii_periodo
and anio = :ii_anio
using gtr_sce;

li_rtn = ln_transfiere_sybase_sql.of_actualizacion_objeto_replica(ls_classname, gtr_sce, itr_web)

if li_rtn <> 1 then
	messagebox('Error','No se pudo transferir historico_transfer a WEB')
	rollback using itr_web;
	rollback using gtr_sce;
else
	if conecta_bd(itr_web,gs_web_param, gs_usuario,gs_password)<>1 then
		MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de Control Escolar WEB", StopSign!)
		return
	End if
	
	insert into historico
	select cuenta,cve_mat,gpo,periodo,anio,cve_carrera,cve_plan,calificacion,observacion
	from historico_transfer 
	using itr_web;
	
	if itr_web.sqlcode <> 0 then
		messagebox('Error','No se pudo insertar historico de control escolar WEB')
		rollback using itr_web;
		return
	else
		messagebox('Aviso','Proceso terminado')
		commit using itr_web;
		commit using gtr_sce;
	end if
end if

st_proceso.text = ''

this.enabled = true

end event

type st_periodo_anio from statictext within w_proceso_transfiere_hist_web
integer x = 1902
integer y = 160
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

type st_trans_mat_preinsc from statictext within w_proceso_transfiere_hist_web
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

type st_trans_preinsc from statictext within w_proceso_transfiere_hist_web
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

type gb_1 from groupbox within w_proceso_transfiere_hist_web
integer x = 110
integer y = 64
integer width = 2926
integer height = 864
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Proceso Transfiere historico a Internet"
end type

