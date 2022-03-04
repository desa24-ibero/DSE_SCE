$PBExportHeader$w_proceso_asigna_permiso_actas.srw
forward
global type w_proceso_asigna_permiso_actas from pfc_w_master
end type
type cb_borra from commandbutton within w_proceso_asigna_permiso_actas
end type
type dw_previo from datawindow within w_proceso_asigna_permiso_actas
end type
type cb_ok from commandbutton within w_proceso_asigna_permiso_actas
end type
type st_periodo_anio from statictext within w_proceso_asigna_permiso_actas
end type
type st_trans_mat_preinsc from statictext within w_proceso_asigna_permiso_actas
end type
type st_trans_preinsc from statictext within w_proceso_asigna_permiso_actas
end type
type gb_1 from groupbox within w_proceso_asigna_permiso_actas
end type
end forward

global type w_proceso_asigna_permiso_actas from pfc_w_master
integer width = 3113
integer height = 1160
string title = "Asigna permiso en Gestión Académica para captura de actas"
cb_borra cb_borra
dw_previo dw_previo
cb_ok cb_ok
st_periodo_anio st_periodo_anio
st_trans_mat_preinsc st_trans_mat_preinsc
st_trans_preinsc st_trans_preinsc
gb_1 gb_1
end type
global w_proceso_asigna_permiso_actas w_proceso_asigna_permiso_actas

type variables
n_tr itr_web,itr_parametros_iniciales,itr_ges
int ii_periodo,ii_anio
st_confirma_usuario ist_confirma_usuario
CONSTANT	string	is_controlescolar_cnx	=	"gestion_academica"


uo_periodo_servicios iuo_periodo_servicios

end variables

forward prototypes
public subroutine wf_recupera_actas ()
public function integer wf_asigna_permiso (integer periodo, integer anio, string examen)
public function integer wf_quita_permiso (integer periodo, integer anio, string examen)
end prototypes

public subroutine wf_recupera_actas ();long ll_periodo,ll_anio,ll_row
string ls_tipo

dw_previo.Reset()

declare cur cursor for
	select periodo,anio, examen = case cve_tipo_examen when 2 then 'EXT' when 6 then 'EXT' when 3 then 'ORD' else '' end
	from acta_evaluacion_preeliminar
	where cve_tipo_examen = 2
	and periodo = :ii_periodo
	group by periodo,anio,cve_tipo_examen
union 
	select periodo,anio, case cve_tipo_examen when 2 then 'EXT' when 6 then 'EXT' when 3 then 'ORD' else '' end
	from acta_evaluacion_preeliminar
	where cve_tipo_examen = 6
	and periodo = :ii_periodo
	group by periodo,anio,cve_tipo_examen
union 
	select periodo,anio, case cve_tipo_examen when 2 then 'EXT' when 6 then 'EXT' when 3 then 'ORD' else '' end
	from acta_evaluacion_preeliminar
	where cve_tipo_examen = 3
	and periodo = :ii_periodo
	group by periodo,anio,cve_tipo_examen
	order by anio, periodo
	using itr_web;
open cur;
Fetch cur into :ll_periodo,:ll_anio,:ls_tipo;
do while itr_web.sqlcode = 0 
	ll_row = dw_previo.Insertrow(0)
	dw_previo.Setitem(ll_row,1,ls_tipo)
	dw_previo.Setitem(ll_row,2,ll_periodo)
	dw_previo.Setitem(ll_row,3,ll_anio)
//	if ll_periodo = ii_periodo and ll_anio = ii_anio then
//		dw_previo.Setitem(ll_row,5,0)
//	else
//		dw_previo.Setitem(ll_row,5,1)
//	end if
	Fetch cur into :ll_periodo,:ll_anio,:ls_tipo;
loop
close cur;

//*****************************************
// Se modifica la decodificación del tipo de periodo.
iuo_periodo_servicios.f_modifica_lista_columna( dw_previo, 'periodo', 'L')
//*****************************************

dw_previo.Groupcalc()
dw_previo.Setsort('anio asc,periodo asc')
dw_previo.Sort()



end subroutine

public function integer wf_asigna_permiso (integer periodo, integer anio, string examen);long ll_cve_prof
int li_tip_exa[2], li_grupo_id 
INTEGER le_existe

if examen = 'ORD' then
	li_tip_exa[1] = 3
	li_tip_exa[2] = 3
	li_grupo_id = 21
else
	li_tip_exa[1] = 2
	li_tip_exa[2] = 6
	li_grupo_id = 31
end if

//delete
//from sga_grupo_usuarios
//where grupo_id = :li_grupo_id using itr_ges;

if itr_ges.sqlcode <> 0 then 
	messagebox('Error','No se pudo eliminar profesores de sga_grupo_usuarios. ' + itr_ges.SQLERRTEXT) 
	return -1
end if

declare cur2 cursor for
	select distinct cve_profesor
	from acta_evaluacion_preeliminar
	where cve_tipo_examen in (:li_tip_exa[1],:li_tip_exa[2])
	and periodo = :ii_periodo
	and anio = :ii_anio
	using itr_web;
open cur2;
Fetch cur2 into :ll_cve_prof;
do while itr_web.sqlcode = 0 
	
	le_existe = 0
	
	SELECT COUNT(*) 
	INTO :le_existe
	FROM sga_grupo_usuarios 
	WHERE grupo_id = :li_grupo_id 
	AND num_empleado = :ll_cve_prof  
	using itr_ges; 
	if itr_ges.sqlcode < 0 then 
		messagebox('Error','No se pudo insertar profesores en sga_grupo_usuarios ' + itr_ges.SQLERRTEXT) 
		return -1
	end if
	
	IF le_existe = 0 THEN 
		INSERT INTO sga_grupo_usuarios VALUES (:li_grupo_id,:ll_cve_prof,NULL,NULL,NULL)  using itr_ges;
		if itr_ges.sqlcode <> 0 then 
			messagebox('Error','No se pudo insertar profesores en sga_grupo_usuarios.' + itr_ges.SQLERRTEXT) 
			return -1
		end if
	END IF 
	
	Fetch cur2 into :ll_cve_prof;
loop
close cur2;

return 1 





end function

public function integer wf_quita_permiso (integer periodo, integer anio, string examen);long ll_cve_prof
int li_tip_exa[2], li_grupo_id

if examen = 'ORD' then
	li_tip_exa[1] = 3
	li_tip_exa[2] = 3
	li_grupo_id = 21
else
	li_tip_exa[1] = 2
	li_tip_exa[2] = 6
	li_grupo_id = 31
end if

delete
from sga_grupo_usuarios
where grupo_id = :li_grupo_id using itr_ges;

if itr_ges.sqlcode <> 0 then 
	messagebox('Error','No se pudo eliminar profesores de sga_grupo_usuarios')
	return -1
end if

return 1
end function

on w_proceso_asigna_permiso_actas.create
int iCurrent
call super::create
this.cb_borra=create cb_borra
this.dw_previo=create dw_previo
this.cb_ok=create cb_ok
this.st_periodo_anio=create st_periodo_anio
this.st_trans_mat_preinsc=create st_trans_mat_preinsc
this.st_trans_preinsc=create st_trans_preinsc
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_borra
this.Control[iCurrent+2]=this.dw_previo
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.st_periodo_anio
this.Control[iCurrent+5]=this.st_trans_mat_preinsc
this.Control[iCurrent+6]=this.st_trans_preinsc
this.Control[iCurrent+7]=this.gb_1
end on

on w_proceso_asigna_permiso_actas.destroy
call super::destroy
destroy(this.cb_borra)
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

if conecta_bd(itr_web,gs_web_param, gs_usuario,gs_password)<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de Control Escolar WEB", StopSign!)
	return
End if

itr_parametros_iniciales = gtr_sce
if f_conecta_pas_parametros_act_bd(itr_parametros_iniciales,itr_ges,is_controlescolar_cnx,gs_usuario,gs_password,1) <> 1 then 
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de Gestion Académica WEB", StopSign!)
	return
end if

f_obten_periodo(li_periodo, li_anio, 8)

ii_periodo = li_periodo
ii_anio = li_anio

//****************************
iuo_periodo_servicios = CREATE uo_periodo_servicios 
iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, 'L', gtr_sce)
ls_periodo = iuo_periodo_servicios.f_recupera_descripcion( ii_periodo, 'L')
//****************************
//choose case ii_periodo
//	case 0
//		ls_periodo = 'PRIMAVERA'
//	case 1
//		ls_periodo = 'VERANO'
//	case 2
//		ls_periodo = 'OTOÑO'
//end choose

st_periodo_anio.text = ls_periodo+" - "+string(ii_anio)

wf_recupera_actas()

end event

type cb_borra from commandbutton within w_proceso_asigna_permiso_actas
integer x = 2011
integer y = 564
integer width = 731
integer height = 128
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Quita permisos"
end type

event clicked;int li_i,li_proceso,li_res,li_tip_exa[2]
long ll_periodo,ll_anio
string ls_tip_exa,ls_exam

if messagebox('Aviso','¿Desea generar el proceso de Quitar Permisos de actas?', Question!,Yesno!) = 2 then
	this.enabled = false
	messagebox('Aviso','No se pudo ejecutar el proceso de Quitar Permisos de actas')
	return 
end if

Open(w_confirma_usuario)
ist_confirma_usuario = Message.PowerObjectParm
IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
	MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
	RETURN 
END IF

Setpointer(Hourglass!)
for li_i = 1 to dw_previo.Rowcount()
	li_proceso = dw_previo.Getitemnumber(li_i,'proceso')
	if li_proceso = 1 then
		ll_periodo = dw_previo.Getitemnumber(li_i,'periodo')
		ll_anio = dw_previo.Getitemnumber(li_i,'anio')
		ls_tip_exa = dw_previo.Getitemstring(li_i,'tipo_examen')
		li_res = wf_quita_permiso(ll_periodo,ll_anio,ls_tip_exa)
		if li_res = 1 then
			Commit using itr_ges;
		else
			Rollback using itr_ges;
			exit
		end if
	end if
end for

wf_recupera_actas()
messagebox('Aviso','Proceso terminado')
end event

type dw_previo from datawindow within w_proceso_asigna_permiso_actas
integer x = 146
integer y = 320
integer width = 1719
integer height = 544
integer taborder = 30
string title = "none"
string dataobject = "d_previo_asig_actas"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;//int li_periodo,li_anio
//
//if dwo.name = 'proceso' then
//	li_periodo = getitemnumber(row,'periodo')
//	li_anio = getitemnumber(row,'anio')
////	if li_periodo = ii_periodo and li_anio = ii_anio then
//		if data = '1' then
//			if messagebox('Aviso','¿Desea asignar los permisos de actas para este periodo?',Question!,yesno!) = 2 then
//				return 2
//			else
//				Open(w_confirma_usuario)
//				ist_confirma_usuario = Message.PowerObjectParm
//				IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
//					MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
//					RETURN 2
//				END IF
//			end if
//		end if
////	else
////		if data = '0' then
////			return 2
////		end if
////	end if
//end if
end event

type cb_ok from commandbutton within w_proceso_asigna_permiso_actas
integer x = 2011
integer y = 416
integer width = 731
integer height = 128
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Asigna permisos"
end type

event clicked;int li_i,li_proceso,li_res,li_tip_exa[2]
long ll_periodo,ll_anio
string ls_tip_exa,ls_exam

if messagebox('Aviso','¿Desea generar el proceso de Asignación Permiso de actas?', Question!,Yesno!) = 2 then
	this.enabled = false
	messagebox('Aviso','No se pudo ejecutar el proceso de Asignación Permiso de actas')
	return 
end if

Open(w_confirma_usuario)
ist_confirma_usuario = Message.PowerObjectParm
IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
	MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
	RETURN 
END IF

Setpointer(Hourglass!)
for li_i = 1 to dw_previo.Rowcount()
	li_proceso = dw_previo.Getitemnumber(li_i,'proceso')
	if li_proceso = 1 then
		ll_periodo = dw_previo.Getitemnumber(li_i,'periodo')
		ll_anio = dw_previo.Getitemnumber(li_i,'anio')
		ls_tip_exa = dw_previo.Getitemstring(li_i,'tipo_examen')
		li_res = wf_asigna_permiso(ll_periodo,ll_anio,ls_tip_exa)
		if li_res = 1 then
			Commit using itr_ges;
		else
			Rollback using itr_ges;
			exit
		end if
	end if
end for

wf_recupera_actas()
messagebox('Aviso','Proceso terminado')
end event

type st_periodo_anio from statictext within w_proceso_asigna_permiso_actas
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

type st_trans_mat_preinsc from statictext within w_proceso_asigna_permiso_actas
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

type st_trans_preinsc from statictext within w_proceso_asigna_permiso_actas
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

type gb_1 from groupbox within w_proceso_asigna_permiso_actas
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
string text = "Proceso Asigna Permiso Actas"
end type

