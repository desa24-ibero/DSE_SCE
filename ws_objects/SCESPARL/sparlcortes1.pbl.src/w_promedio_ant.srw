$PBExportHeader$w_promedio_ant.srw
forward
global type w_promedio_ant from w_ancestral
end type
type dw_cred_75_ss from datawindow within w_promedio_ant
end type
type dw_prom_cred_sem from datawindow within w_promedio_ant
end type
type st_status_2 from statictext within w_promedio_ant
end type
type st_status_1 from statictext within w_promedio_ant
end type
type cb_1 from commandbutton within w_promedio_ant
end type
type dw_cortes from uo_dw_reporte within w_promedio_ant
end type
type uo_1 from uo_per_ani within w_promedio_ant
end type
end forward

global type w_promedio_ant from w_ancestral
integer width = 3579
integer height = 1696
string title = "Corte de Promedio"
string menuname = "m_menu"
dw_cred_75_ss dw_cred_75_ss
dw_prom_cred_sem dw_prom_cred_sem
st_status_2 st_status_2
st_status_1 st_status_1
cb_1 cb_1
dw_cortes dw_cortes
uo_1 uo_1
end type
global w_promedio_ant w_promedio_ant

type variables

end variables

event open;call super::open;/*
DESCRIPCIÓN: Pon la ventana en la esquina. Liga dw_cortes,dw_cred_75_ss,dw_prom_cred_sem a sce.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
dw_cortes.settransobject(gtr_sce)
dw_cred_75_ss.settransobject(gtr_sce)
dw_prom_cred_sem.settransobject(gtr_sce)

periodo_actual(gi_periodo,gi_anio,gtr_sce)
end event

on w_promedio_ant.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_cred_75_ss=create dw_cred_75_ss
this.dw_prom_cred_sem=create dw_prom_cred_sem
this.st_status_2=create st_status_2
this.st_status_1=create st_status_1
this.cb_1=create cb_1
this.dw_cortes=create dw_cortes
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cred_75_ss
this.Control[iCurrent+2]=this.dw_prom_cred_sem
this.Control[iCurrent+3]=this.st_status_2
this.Control[iCurrent+4]=this.st_status_1
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_cortes
this.Control[iCurrent+7]=this.uo_1
end on

on w_promedio_ant.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_cred_75_ss)
destroy(this.dw_prom_cred_sem)
destroy(this.st_status_2)
destroy(this.st_status_1)
destroy(this.cb_1)
destroy(this.dw_cortes)
destroy(this.uo_1)
end on

type p_uia from w_ancestral`p_uia within w_promedio_ant
end type

type dw_cred_75_ss from datawindow within w_promedio_ant
event retrieveend pbm_dwnretrieveend
event retrieverow pbm_dwnretrieverow
integer x = 2354
integer y = 1068
integer width = 1189
integer height = 432
integer taborder = 30
string dataobject = "d_cred_75_ss"
boolean vscrollbar = true
boolean livescroll = true
end type

event retrieveend;/*
DESCRIPCIÓN:
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 16 Junio 1998
MODIFICACIÓN:
*/
long lo_cont_1,lo_cont_2,lo_cuenta
int in_carrera,in_plan,in_respuesta

st_status_2.text='Terminada la Carga'

/*Se hace para TODOS los alumnos que se inscribieron en el semestre (cuentas_cortes)*/
FOR lo_cont_1=1 TO dw_prom_cred_sem.rowcount()
	lo_cuenta=dw_prom_cred_sem.object.academicos_cuenta[lo_cont_1]
	st_status_2.text="Calculando dw_cred_75_ss de "+string(lo_cuenta) /*Despliega el número de cuenta (Para ver si ya me trabe)*/
	in_carrera=dw_prom_cred_sem.object.academicos_cve_carrera[lo_cont_1]
	in_plan=dw_prom_cred_sem.object.academicos_cve_plan[lo_cont_1]
	
	if dw_prom_cred_sem.object.academicos_nivel[lo_cont_1]='L' then
		lo_cont_2=1
		DO UNTIL ((object.plan_estudios_cve_plan[lo_cont_2]=in_plan &
						and object.plan_estudios_cve_carrera[lo_cont_2]=in_carrera))
			lo_cont_2=lo_cont_2+1 /*Busca el renglón que coincide con la in_carrera y el plan (DEBE APARECER)*/
			if lo_cont_2 > rowcount() then
				MessageBox("Carrera no existe", "El alumno con cuenta"+ string(dw_prom_cred_sem.object.academicos_cuenta))
				in_carrera = 101
				in_plan = 1
				lo_cont_2 = 1
			end if
		LOOP
		
		if isnull(object.plan_estudios_cred_puntaje[lo_cont_2]) then
			object.plan_estudios_cred_puntaje[lo_cont_2]=0
		end if
		
		if isnull(object.plan_estudios_puntaje_min[lo_cont_2]) then
			object.plan_estudios_puntaje_min[lo_cont_2]=0
		end if
		
		if isnull(object.plan_estudios_cred_serv_social[lo_cont_2]) then
			object.plan_estudios_cred_serv_social[lo_cont_2]=0
		end if
		
		if dw_prom_cred_sem.object.academicos_creditos_cursados[lo_cont_1] >= &
				object.plan_estudios_cred_serv_social[lo_cont_2] then /*Si ya se curso para SS...*/
				if dw_cortes.object.banderas_cve_flag_serv_social[lo_cont_1]=0 then
					dw_cortes.object.banderas_cve_flag_serv_social[lo_cont_1]=1
				end if
		end if
		
		if dw_prom_cred_sem.object.academicos_creditos_cursados[lo_cont_1] >= 72 then /*Si ya se curso para Integracion...*/
			dw_cortes.object.banderas_puede_integracion[lo_cont_1]=1
		end if
		
		if dw_prom_cred_sem.object.academicos_creditos_cursados[lo_cont_1] >= &
				object.plan_estudios_cred_puntaje[lo_cont_2] then /*Si ya se cursaron 75% o más...*/			
				
			dw_cortes.object.banderas_cve_flag_promedio[lo_cont_1]=3
			dw_cortes.object.banderas_baja_3_reprob[lo_cont_1]=0
			dw_cortes.object.banderas_baja_4_insc[lo_cont_1]=0
			
		else/*dw_prom_cred_sem.object.academicos_creditos_cursados[lo_cont_1]>=object.plan_estudios_cred_puntaje[lo_cont_2]*/
			if gi_periodo<>1 then /*Si no estoy en verano*/
				/*Si el promedio que se tiene es mayor o igual al de calidad...*/
				if round(dw_prom_cred_sem.object.academicos_promedio[lo_cont_1],1)>=&
						round(object.plan_estudios_puntaje_min[lo_cont_2],1) then
					CHOOSE CASE dw_cortes.object.banderas_cve_flag_promedio[lo_cont_1]
						CASE 0
						CASE 1
							dw_cortes.object.banderas_cve_flag_promedio[lo_cont_1]=0 /*Desamonesta*/
						CASE 2
							//dw_cortes.object.banderas_cve_flag_promedio[lo_cont_1]=2 /*Según lcoronado*/
						CASE 3
						CASE ELSE
					END CHOOSE
				else /*dw_prom_cred_sem.object.academicos_promedio[lo_cont_1]>=object.plan_estudios_puntaje_min[lo_cont_2]*/
					/*Si no está amonestado...*/
					if dw_cortes.object.banderas_cve_flag_promedio[lo_cont_1]=0 then
						dw_cortes.object.banderas_cve_flag_promedio[lo_cont_1]=1 /*Amonéstalo*/
					elseif dw_cortes.object.banderas_cve_flag_promedio[lo_cont_1] <> 3 then/*Si no...*/
						dw_cortes.object.banderas_cve_flag_promedio[lo_cont_1]=2 /*Expúlsalo*/
					end if/*dw_cortes.object.banderas_cve_flag_promedio[lo_cont_1]=0*/
				end if				
			else/*g_in_periodo<>1*/
			end if/*g_in_periodo<>1*/
		end if/*dw_prom_cred_sem.object.academicos_creditos_cursados[lo_cont_1]>=object.plan_estudios_cred_puntaje[lo_cont_2]*/
	else/*dw_prom_cred_sem.object.academicos_nivel<>'L'*/
	end if/*dw_prom_cred_sem.object.academicos_nivel<>'L'*/
NEXT

/*Avisa que ya se terminó la actualización*/
st_status_2.text='Terminada la Actualización'

if dw_cortes.modifiedcount()+dw_prom_cred_sem.modifiedcount() > 0 then
	dw_cortes.AcceptText()
	dw_prom_cred_sem.AcceptText()
	in_respuesta = MessageBox("A punto de hacer COMMIT; y update()",&
		"Deje de hacer lo que este haciendo",Exclamation!, OKCancel!, 2)
	IF in_respuesta = 1 THEN 
		if dw_cortes.update(true)+dw_prom_cred_sem.update(true) >= 1 then	
			commit using gtr_SCE;
		else
			messagebox("Error al actualizar",gtr_sce.sqlerrtext)
			rollback using gtr_SCE;
		end if
	else
		rollback using gtr_SCE;
	END IF
end if
end event

event retrieverow;/*
DESCRIPCIÓN: Despliega un mensaje cada vez que se carga un renglón
				 (para mostrar que no te has trabado)
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/

st_status_2.text='Cargando '+string(row)
end event

type dw_prom_cred_sem from datawindow within w_promedio_ant
event retrieveend pbm_dwnretrieveend
event retrieverow pbm_dwnretrieverow
event constructor pbm_constructor
integer x = 5
integer y = 1068
integer width = 2341
integer height = 432
integer taborder = 40
string dataobject = "d_prom_cred_sem"
boolean vscrollbar = true
boolean livescroll = true
end type

event retrieveend;/*
DESCRIPCIÓN: Calcula tanto el promedio como el número de créditos acumulados y actualiza
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 16 Junio 1998
MODIFICACIÓN:
*/
long lo_cont,lo_cuenta
int in_carrera,in_plan,in_semestres
decimal in_cred
double do_prom

st_status_2.text='Terminada la Carga'

	/*Procedimiento que calcula tanto el promedio como el número de créditos acumulados*/
	DECLARE cal_prom PROCEDURE FOR calcula_promedio  
         @cuenta = :lo_cuenta,   
         @cve_carr = :in_carrera,   
         @plan = :in_plan,   
         @promedio = :do_prom OUTPUT,
         @creditos =:in_cred OUTPUT
	USING gtr_sce;
	
/*Se hace para TODOS los alumnos que se inscribieron en el semestre (cuentas_cortes)*/
FOR lo_cont=1 TO rowcount()
	lo_cuenta=object.academicos_cuenta[lo_cont]
	st_status_2.text="Calculando dw_prom_cred_sem de "+string(lo_cuenta) /*Despliega el número de cuenta (Para ver si ya me trabe)*/
	in_carrera=object.academicos_cve_carrera[lo_cont]
	in_plan=object.academicos_cve_plan[lo_cont]
	execute cal_prom;
	FETCH cal_prom INTO :do_prom, :in_cred;/*Calcula promedio y créditos cursados*/
	close cal_prom;

	if isnull(do_prom) then
		do_prom=0
	end if
	object.academicos_promedio[lo_cont]=do_prom /*Actualiza tanto el promedio como*/
	
	if isnull(in_cred) then
		in_cred=0
	end if
	object.academicos_creditos_cursados[lo_cont]=Long(in_cred) /*los créditos cursados*/
	
	if gi_periodo<>1 then /*Si el Periodo no es Verano...*/
		SELECT count(count(anio))
		INTO :in_semestres
		FROM historico,materias
		WHERE ( historico.periodo <> 1 ) AND  
				( historico.cuenta = :lo_cuenta ) AND
				( historico.cve_carrera = :in_carrera) AND
				( historico.cve_plan = :in_plan) AND
				( historico.cve_mat = materias.cve_mat ) AND
				( materias.creditos > 0 ) 
		GROUP BY historico.cuenta,
				historico.anio,   
				historico.periodo
		USING gtr_sce;
		object.academicos_sem_cursados[lo_cont]=in_semestres
	end if
NEXT
st_status_2.text='Terminado el Cálculo' /*Avisa que ya terminaste de calcular promedios y semestres*/
/*Busca los promedios de calidad de las carreras que tuvieron alumnos inscritos ()plan_estudios)*/
dw_cred_75_ss.retrieve()
end event

event retrieverow;/*
DESCRIPCIÓN: Despliega un mensaje cada vez que se carga un renglón
				 (para mostrar que no te has trabado)
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/

st_status_2.text='Cargando '+string(row)
end event

type st_status_2 from statictext within w_promedio_ant
integer x = 27
integer y = 972
integer width = 3355
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

type st_status_1 from statictext within w_promedio_ant
integer x = 18
integer y = 428
integer width = 3360
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

type cb_1 from commandbutton within w_promedio_ant
event clicked pbm_bnclicked
integer x = 1422
integer y = 252
integer width = 549
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Corte de Promedio"
end type

event clicked;/*
DESCRIPCIÓN: Carga las banderas de los que cursaron materias en el semestre (Banderas)
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
dw_cortes.retrieve('?')
end event

type dw_cortes from uo_dw_reporte within w_promedio_ant
event retrieveend pbm_dwnretrieveend
event retrieverow pbm_dwnretrieverow
integer x = 18
integer y = 524
integer width = 3355
integer height = 432
integer taborder = 10
string dataobject = "d_cortes"
end type

event retrieveend;call super::retrieveend;/*
DESCRIPCIÓN: Carga los datos de los que cursaron materias en el semestre (Academicos)
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
st_status_1.text='Terminada la Carga'
dw_prom_cred_sem.retrieve('?')
end event

event retrieverow;call super::retrieverow;/*
DESCRIPCIÓN: Despliega un mensaje cad vez que se carga un renglón
				 (para mostrar que no te has trabado)
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/

st_status_1.text='Cargando '+string(row)
end event

type uo_1 from uo_per_ani within w_promedio_ant
integer x = 1074
integer y = 44
integer taborder = 1
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

