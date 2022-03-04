$PBExportHeader$w_actua_insc_ant.srw
forward
global type w_actua_insc_ant from w_ancestral
end type
type st_status from statictext within w_actua_insc_ant
end type
type cb_1 from commandbutton within w_actua_insc_ant
end type
type dw_hist_reingreso from datawindow within w_actua_insc_ant
end type
type uo_1 from uo_per_ani within w_actua_insc_ant
end type
type dw_insc_sem_ant from uo_dw_reporte within w_actua_insc_ant
end type
type dw_ing_revalidacion from datawindow within w_actua_insc_ant
end type
end forward

global type w_actua_insc_ant from w_ancestral
integer width = 3168
integer height = 1640
string title = "Actualiza Inscrito Anterior"
string menuname = "m_menu"
st_status st_status
cb_1 cb_1
dw_hist_reingreso dw_hist_reingreso
uo_1 uo_1
dw_insc_sem_ant dw_insc_sem_ant
dw_ing_revalidacion dw_ing_revalidacion
end type
global w_actua_insc_ant w_actua_insc_ant

event open;call super::open;/*
DESCRIPCIÓN: Liga dw_cortes con sce.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/

dw_ing_revalidacion.settransobject(gtr_sce)
dw_insc_sem_ant.settransobject(gtr_sce)
dw_hist_reingreso.settransobject(gtr_sce)

//periodo_actual(gi_periodo,gi_anio,gtr_sce)
end event

on w_actua_insc_ant.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.st_status=create st_status
this.cb_1=create cb_1
this.dw_hist_reingreso=create dw_hist_reingreso
this.uo_1=create uo_1
this.dw_insc_sem_ant=create dw_insc_sem_ant
this.dw_ing_revalidacion=create dw_ing_revalidacion
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_status
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_hist_reingreso
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.dw_insc_sem_ant
this.Control[iCurrent+6]=this.dw_ing_revalidacion
end on

on w_actua_insc_ant.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_status)
destroy(this.cb_1)
destroy(this.dw_hist_reingreso)
destroy(this.uo_1)
destroy(this.dw_insc_sem_ant)
destroy(this.dw_ing_revalidacion)
end on

type p_uia from w_ancestral`p_uia within w_actua_insc_ant
end type

type st_status from statictext within w_actua_insc_ant
integer x = 443
integer y = 124
integer width = 2642
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "Status"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_actua_insc_ant
event clicked pbm_bnclicked
integer x = 1367
integer width = 800
integer height = 108
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualiza Inscrito Anterior"
end type

event clicked;/*
DESCRIPCIÓN: Si no estamos en verano, limpia "insc_sem_ant" de banderas.
				 Carga las banderas de los que cursaron materias en el semestre (Banderas)
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/

if gi_periodo<>1 then
	st_status.text='Limpiando "Insc_Sem_Ant" de Banderas'
//	UPDATE banderas  
//   SET insc_sem_ant = 0  
//   WHERE banderas.insc_sem_ant = 1
//	USING gtr_sce;
//	COMMIT using gtr_sce;
	
	UPDATE banderas  
   SET insc_sem_ant = 0  
   WHERE banderas.insc_sem_ant = 1
	AND EXISTS(SELECT * FROM academicos, plan_estudios  
				WHERE academicos.cuenta = banderas.cuenta 
				AND academicos.cve_carrera = plan_estudios.cve_carrera
				AND academicos.cve_plan = plan_estudios.cve_plan
				AND plan_estudios.tipo_periodo = :gs_tipo_periodo) 
	USING gtr_sce;
	COMMIT using gtr_sce;	
	
end if



// Recupera el periodo siguiente.
uo_periodo_servicios luo_periodo_servicios 
luo_periodo_servicios = CREATE uo_periodo_servicios
luo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, 'L', gtr_sce)
luo_periodo_servicios.f_recupera_periodo_siguiente( gi_periodo, gi_anio, gtr_sce) 

//gi_periodo++
//if gi_periodo=3 then
//	gi_periodo=0
//	gi_anio++
//end if

dw_hist_reingreso.retrieve(gi_periodo,gi_anio) 





end event

type dw_hist_reingreso from datawindow within w_actua_insc_ant
integer x = 64
integer y = 1052
integer width = 718
integer height = 360
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hist_reingreso"
boolean vscrollbar = true
boolean livescroll = true
end type

event retrieverow;/*
DESCRIPCIÓN: Despliega un mensaje cad vez que se carga un renglón
				 (para mostrar que no te has trabado).
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/

st_status.text='Cargando '+string(row)
end event

event retrieveend;/*
DESCRIPCIÓN: Actualiza "insc_sem_ant" de banderas.
				 Despliega el número de cuenta (Para ver si ya me trabe)
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
long ll_cont
int li_respuesta

st_status.text='Terminada la Carga'

FOR ll_cont=1 TO rowcount()
	st_status.text=string(object.banderas_cuenta[ll_cont])
	object.banderas_insc_sem_ant[ll_cont]=1
NEXT

st_status.text='Terminada la Actualización'

if modifiedcount() > 0 then
	AcceptText()
	li_respuesta = MessageBox("A punto de hacer COMMIT; y update()",&
		"Deje de hacer lo que este haciendo",Exclamation!, OKCancel!, 2)
	IF li_respuesta = 1 THEN 
		if update(true)>= 1 then		
			commit using gtr_sce;
			dw_ing_revalidacion.retrieve(gi_periodo,gi_anio)
		else
			messagebox("Error al actualizar",gtr_sce.sqlerrtext)
			rollback using gtr_sce;
		end if
	else
		rollback using gtr_sce;
	END IF
else
	dw_ing_revalidacion.retrieve(gi_periodo,gi_anio)
end if
end event

type uo_1 from uo_per_ani within w_actua_insc_ant
integer x = 1824
integer y = 1208
integer taborder = 20
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type dw_insc_sem_ant from uo_dw_reporte within w_actua_insc_ant
event retrieveend pbm_dwnretrieveend
event retrieverow pbm_dwnretrieverow
integer x = 443
integer y = 228
integer width = 2642
integer height = 736
integer taborder = 0
string dataobject = "d_insc_sem_ant"
end type

event retrieveend;/*
DESCRIPCIÓN: Actualiza "insc_sem_ant" de banderas.
				 Despliega el número de cuenta (Para ver si ya me trabe)
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
long ll_cont
int li_respuesta

st_status.text='Terminada la Carga'

FOR ll_cont=1 TO rowcount()
//	st_status.text=string(object.banderas_cuenta[ll_cont])
	st_status.text=string(ll_cont)
	object.banderas_insc_sem_ant[ll_cont]=1
NEXT

st_status.text='Terminada la Actualización'

if modifiedcount() > 0 then
	AcceptText()
	li_respuesta = MessageBox("A punto de hacer COMMIT; y update()",&
		"Deje de hacer lo que este haciendo",Exclamation!, OKCancel!, 2)
	IF li_respuesta = 1 THEN 
		if update(true)>= 1 then		
			commit using gtr_sce;
		else
			messagebox("Error al actualizar",gtr_sce.sqlerrtext)
			rollback using gtr_sce;
		end if
	else
		rollback using gtr_sce;
	END IF
end if
end event

event retrieverow;call super::retrieverow;/*
DESCRIPCIÓN: Despliega un mensaje cad vez que se carga un renglón
				 (para mostrar que no te has trabado).
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/

st_status.text='Cargando '+string(row)
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

type dw_ing_revalidacion from datawindow within w_actua_insc_ant
integer x = 910
integer y = 1052
integer width = 718
integer height = 360
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_ing_revalidacion"
boolean vscrollbar = true
boolean livescroll = true
end type

event retrieveend;
//DESCRIPCIÓN: Actualiza "insc_sem_ant" de banderas.
//				 Despliega el número de cuenta (Para ver si ya me trabe)
//PARÁMETROS: Ninguno
//REGRESA: Nada
//AUTOR: Antonio Pica Ruiz
//FECHA: 2 de Abril de 2001
//MODIFICACIÓN:

long ll_cont
int li_respuesta

st_status.text='Terminada la Carga'

FOR ll_cont=1 TO rowcount()
	st_status.text=string(object.banderas_cuenta[ll_cont])
	object.banderas_insc_sem_ant[ll_cont]=1
NEXT

st_status.text='Terminada la Actualización'

if modifiedcount() > 0 then
	AcceptText()
	li_respuesta = MessageBox("A punto de hacer COMMIT; y update()",&
		"Deje de hacer lo que este haciendo",Exclamation!, OKCancel!, 2)
	IF li_respuesta = 1 THEN 
		if update(true)>= 1 then		
			commit using gtr_sce;
			dw_insc_sem_ant.retrieve('?', gs_tipo_periodo)
		else
			messagebox("Error al actualizar",gtr_sce.sqlerrtext)
			rollback using gtr_sce;
		end if
	else
		rollback using gtr_sce;
	END IF
else
	dw_insc_sem_ant.retrieve('?', gs_tipo_periodo)
end if
end event

event retrieverow;
//DESCRIPCIÓN: Despliega un mensaje cad vez que se carga un renglón
//				 (para mostrar que no te has trabado).
//PARÁMETROS: Ninguno
//REGRESA: Nada
//AUTOR: Antonio Pica Ruiz
//FECHA: 2 de Abril de 2001
//MODIFICACIÓN:


st_status.text='Cargando '+string(row)
end event

