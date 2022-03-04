$PBExportHeader$w_cap_mat_preinsc_2013.srw
$PBExportComments$Despliegue de datos academicos de un alumno (Carrera, Semestre, Subsistema, Fecha de Ingreso, Fecha de Egreso,.....)
forward
global type w_cap_mat_preinsc_2013 from w_master_main
end type
type dw_cap_mat_preinsc from datawindow within w_cap_mat_preinsc_2013
end type
type iuo_foto_alumno_blob from uo_foto_alumno_blob within w_cap_mat_preinsc_2013
end type
type uo_1 from uo_per_ani within w_cap_mat_preinsc_2013
end type
type uo_nombre from uo_carreras_alumno_lista within w_cap_mat_preinsc_2013
end type
end forward

global type w_cap_mat_preinsc_2013 from w_master_main
integer x = 5
integer y = 4
integer width = 4238
integer height = 2704
string title = "Captura Manual de Materias Preinscritas"
string menuname = "m_menu_general_2013"
boolean center = true
dw_cap_mat_preinsc dw_cap_mat_preinsc
iuo_foto_alumno_blob iuo_foto_alumno_blob
uo_1 uo_1
uo_nombre uo_nombre
end type
global w_cap_mat_preinsc_2013 w_cap_mat_preinsc_2013

type variables
long il_cuenta, il_rows_alumno_cambio_password = 0,il_carrera,il_plan
transaction itr_web,tr_dw_propio
string  is_filename = "",is_nivel 


uo_periodo_servicios iuo_periodo_servicios 

end variables

on w_cap_mat_preinsc_2013.create
int iCurrent
call super::create
if this.MenuName = "m_menu_general_2013" then this.MenuID = create m_menu_general_2013
this.dw_cap_mat_preinsc=create dw_cap_mat_preinsc
this.iuo_foto_alumno_blob=create iuo_foto_alumno_blob
this.uo_1=create uo_1
this.uo_nombre=create uo_nombre
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cap_mat_preinsc
this.Control[iCurrent+2]=this.iuo_foto_alumno_blob
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.uo_nombre
end on

on w_cap_mat_preinsc_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_cap_mat_preinsc)
destroy(this.iuo_foto_alumno_blob)
destroy(this.uo_1)
destroy(this.uo_nombre)
end on

event close;if gi_numscob = 1 then
	if desconecta_bd_n_tr(gtr_scob) <> 1 then
		return
	end if
end if
gi_numscob --


if isvalid(itr_web) then
	if desconecta_bd(itr_web) <> 1 then
		return
	end if
end if

end event

event closequery;//
end event

event open;call super::open;dw_cap_mat_preinsc.settransobject(gtr_sce)
if isnull(gi_numscob) OR not (isvalid(gtr_scob)) then gi_numscob = 0
if gi_numscob <= 0 then
	if conecta_bd_n_tr(gtr_scob,gs_scob,gs_usuario,gs_password)<>1 then
//	if conecta_bd_n_tr(gtr_scob,gs_scob,'sa',gs_password)<>1 then
		
		MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de cobranzas", StopSign!)
		close(this)
	end if
end if
gi_numscob++

periodo_actual(gi_periodo,gi_anio,gtr_sce) 

iuo_periodo_servicios = CREATE uo_periodo_servicios 
iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, 'L', gtr_sce) 

iuo_periodo_servicios.f_recupera_periodo_siguiente( gi_periodo, gi_anio, gtr_sce) 

uo_1.em_ani.text = string(gi_anio) 
uo_1.em_per.text = string(gi_periodo) 

iuo_periodo_servicios.f_modifica_lista_columna( dw_cap_mat_preinsc, 'periodo', 'L')



//gi_periodo++
//if gi_periodo=3 then
//	gi_periodo=0
//	gi_anio++
//end if

//if conecta_bd(itr_web,gs_sweb, "preinsce","futuro")<>1 then
//if conecta_bd(itr_web,gs_sweb, "sa","desarrollo")<>1 then 
if conecta_bd(itr_web,gs_sweb, gs_usuario,gs_password)<>1 then 
	
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	close(this)
else 
	dw_cap_mat_preinsc.SetTransObject(itr_web)
end if 



end event

event doubleclicked;call super::doubleclicked;/*
DESCRIPCIÓN: Cuando se capture el número de cuenta, carga en dw_cap_mat_preinsc las materias
				 que tenga preinscritas.
PARÁMETROS: Message.LongParm
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/

il_cuenta = long(uo_nombre.of_obten_cuenta())
il_carrera = uo_nombre.istr_carrera.str_cve_carrera
il_plan = uo_nombre.istr_carrera.str_cve_plan
is_nivel = uo_nombre.istr_carrera.str_nivel

dw_cap_mat_preinsc.retrieve(il_cuenta,gi_periodo,gi_anio)
end event

event ue_actualiza;call super::ue_actualiza;/*
DESCRIPCIÓN: Antes de guardar los cambios hechos, verifica el status de las materias.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
int li_status,li_respuesta
long ll_clave,ll_renglon
string ls_grupo

FOR ll_renglon=1 TO dw_cap_mat_preinsc.rowcount()
	ll_clave= dw_cap_mat_preinsc.object.cve_mat[ll_renglon]
	if gi_periodo= dw_cap_mat_preinsc.object.periodo[ll_renglon] and gi_anio= dw_cap_mat_preinsc.object.anio[ll_renglon] then
		ls_grupo= dw_cap_mat_preinsc.object.gpo[ll_renglon]	
		li_status=f_e_mat(ll_clave)
		li_status=f_e_grup(ll_clave,ls_grupo)+li_status
		li_status=f_e_plan(is_nivel,il_carrera,il_plan,ll_clave)+li_status
		li_status=f_no_curso(il_cuenta,ll_clave)+li_status
		li_status=f_puede_integracion(il_cuenta,ll_clave)+li_status
		li_status=f_puede_cursar(il_cuenta,ll_clave,il_carrera,il_plan)+li_status
		dw_cap_mat_preinsc.object.status[ll_renglon]=li_status
	end if
NEXT

/*Acepta el texto de la última columna editada*/
dw_cap_mat_preinsc.AcceptText()
/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
if dw_cap_mat_preinsc.ModifiedCount()+dw_cap_mat_preinsc.DeletedCount() > 0 Then

	/*Pregunta si se desean guardar los cambios hechos*/
	li_respuesta = messagebox("Atención","Desea actualizar los cambios:",StopSign!,YesNo!,2)

	if li_respuesta = 1 then
			/*Checa que los renglones cumplan con las reglas de validación*/
			if dw_cap_mat_preinsc.update(true) = 1 then		
				/*Si es asi, guardalo en la tabla y avisa.*/
				commit using itr_web;
				messagebox("Información","Se han guardado los cambios")
			else
				/*De lo contrario, desecha los cambios (todos) y avisa*/
				rollback using itr_web;
				messagebox("Información","Algunos datos están incorrectos, favor de corregirlos")	
			end if
	else
		/*De lo contrario, solo avisa que no se guardó nada.*/
		messagebox("Información","No se han guardado los cambios")
	end if
end if
end event

event ue_nuevo;call super::ue_nuevo;/*
DESCRIPCIÓN: Cuando el usuario pida una materia nueva, inicializa el número de cuenta,
				 el periodo y el año.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
long ll_renglon

ll_renglon=dw_cap_mat_preinsc.insertrow(0)

dw_cap_mat_preinsc.object.cuenta[ll_renglon]=il_cuenta
dw_cap_mat_preinsc.object.periodo[ll_renglon]=gi_periodo
dw_cap_mat_preinsc.object.anio[ll_renglon]=gi_anio
end event

type st_sistema from w_master_main`st_sistema within w_cap_mat_preinsc_2013
end type

type p_ibero from w_master_main`p_ibero within w_cap_mat_preinsc_2013
end type

type dw_cap_mat_preinsc from datawindow within w_cap_mat_preinsc_2013
integer x = 192
integer y = 932
integer width = 3520
integer height = 768
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_cap_mat_preinsc_2013"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;tr_dw_propio = create transaction
tr_dw_propio = itr_web
end event

type iuo_foto_alumno_blob from uo_foto_alumno_blob within w_cap_mat_preinsc_2013
event destroy ( )
integer x = 87
integer y = 324
integer width = 498
integer height = 492
integer taborder = 40
boolean bringtotop = true
borderstyle borderstyle = stylebox!
end type

on iuo_foto_alumno_blob.destroy
call uo_foto_alumno_blob::destroy
end on

type uo_1 from uo_per_ani within w_cap_mat_preinsc_2013
event destroy ( )
integer x = 2610
integer y = 52
integer width = 1253
integer height = 168
integer taborder = 40
boolean bringtotop = true
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

event ue_modifica;call super::ue_modifica;
PARENT.triggerevent(doubleclicked!) 



end event

type uo_nombre from uo_carreras_alumno_lista within w_cap_mat_preinsc_2013
event destroy ( )
integer x = 622
integer y = 324
integer width = 3241
integer height = 516
integer taborder = 20
boolean bringtotop = true
end type

on uo_nombre.destroy
call uo_carreras_alumno_lista::destroy
end on

event constructor;call super::constructor;m_menu_general_2013.objeto = this
end event

