$PBExportHeader$w_actualiza_aspirantes_alumnos.srw
forward
global type w_actualiza_aspirantes_alumnos from window
end type
type st_5 from statictext within w_actualiza_aspirantes_alumnos
end type
type st_4 from statictext within w_actualiza_aspirantes_alumnos
end type
type st_fin from statictext within w_actualiza_aspirantes_alumnos
end type
type st_ini from statictext within w_actualiza_aspirantes_alumnos
end type
type st_1 from statictext within w_actualiza_aspirantes_alumnos
end type
type dw_2 from datawindow within w_actualiza_aspirantes_alumnos
end type
type dw_1 from uo_dw_reporte within w_actualiza_aspirantes_alumnos
end type
type uo_1 from uo_ver_per_ani within w_actualiza_aspirantes_alumnos
end type
type em_max from editmask within w_actualiza_aspirantes_alumnos
end type
type em_min from editmask within w_actualiza_aspirantes_alumnos
end type
end forward

global type w_actualiza_aspirantes_alumnos from window
integer x = 834
integer y = 362
integer width = 3562
integer height = 1562
boolean titlebar = true
string title = "Actualiza Información de Aspirantes en Alumnos de Control Escolar"
string menuname = "m_menu"
long backcolor = 30976088
event type long num_folios ( integer min_max )
event enlace ( )
event type integer checa ( long cuento )
event lee_dw_1 ( )
event lee_dw_2 ( )
event ins_alumnos ( )
event ins_estudio_ant ( )
event ins_hist_reingreso ( )
event ins_mat_inscritas ( integer al_periodo,  integer al_anio )
event act_alumnos ( )
event act_domicilio ( )
event act_padre ( )
event act_estudio_ant ( )
event act_academicos ( )
event act_banderas ( )
event ins_hist_carreras ( )
st_5 st_5
st_4 st_4
st_fin st_fin
st_ini st_ini
st_1 st_1
dw_2 dw_2
dw_1 dw_1
uo_1 uo_1
em_max em_max
em_min em_min
end type
global w_actualiza_aspirantes_alumnos w_actualiza_aspirantes_alumnos

type variables
int al_estado,al_lugar,al_nacion,al_civil,al_religion,al_bachi,al_trabajo,al_horas,al_transp
long pa_estado,al_plan,al_carr,al_paq,cont_2,al_mat
long cont_1,cuenta
real al_promedio
string al_nombre,al_apaterno,al_amaterno,al_calle,al_colonia,al_cp,al_tele,al_sexo
string pa_nombre,pa_apaterno,pa_amaterno,pa_calle,pa_colonia,pa_cp,pa_tele,al_grupo
datetime al_fecha

end variables

forward prototypes
public function integer wf_enlace_sce (long al_cuenta, integer ai_periodo, integer ai_anio)
end prototypes

event num_folios;long folios

if min_max=0 then
	SELECT min(aspiran.folio)
	INTO :folios
	FROM aspiran  
	WHERE ( aspiran.clv_ver = :gi_version ) AND  
		( aspiran.clv_per = :gi_periodo ) AND  
		( aspiran.anio = :gi_anio )
	USING gtr_sadm;
else
	SELECT max(aspiran.folio)
	INTO :folios
	FROM aspiran  
	WHERE ( aspiran.clv_ver = :gi_version ) AND  
		( aspiran.clv_per = :gi_periodo ) AND  
		( aspiran.anio = :gi_anio )
	USING gtr_sadm;
end if

return folios
end event

event enlace();long ll_rows, ll_periodo_materias, ll_anio_materias, ll_num_aspirantes, ll_folio
long ll_rows_totales
string ls_periodo_materias, ls_anio_materias
integer li_clv_ver, li_clv_per, li_anio
boolean lb_error_encontrado=false
SetPointer(HourGlass!)
st_ini.text = string(now())
ll_num_aspirantes= dw_1.rowcount()



li_clv_ver = gi_version
li_clv_per = gi_periodo
li_anio = gi_anio
ll_rows_totales = dw_1.rowcount()

for cont_1=1 to dw_1.rowcount()

	cuenta=dw_1.object.general_cuenta[cont_1]
	ll_folio =dw_1.object.folio[cont_1]
	
	st_1.text="Leyendo datos de cuenta:["+string(cuenta)+"] folio :["+string(ll_folio)+"]     ("+string(cont_1)+"/"+string(ll_rows_totales)+")"
	if f_actualiza_aspirantes_alumnos(ll_folio, li_clv_ver, li_clv_per, li_anio) = -1 then
		MessageBox("Error de actualizacion","Se suspendera la actualización masiva",StopSign!)
		lb_error_encontrado= true
		exit
	end if

next

st_fin.text = string(now())
if Not lb_error_encontrado then
	st_1.text="Ya acabe"
else
	st_1.text="Error detectado"	
end if


end event

event checa;string ls_error
long cuen

SELECT alumnos.cuenta
INTO :cuen
FROM alumnos
WHERE alumnos.cuenta=:cuento
USING gtr_sce;
ls_error=gtr_sce.SQLErrText
	
if gtr_sce.SQLCode = 100 then
	commit using gtr_sce;
	if ls_error<>"" then
		MessageBox("Database Error",ls_error, Exclamation!)
	end if
	return 0 /*Alumno nuevo*/
else
	if gtr_sce.SQLCode > 0 then
		commit using gtr_sce;
		if ls_error<>"" then
			MessageBox("Database Error",ls_error, Exclamation!)
		end if
		return -1
	else
		commit using gtr_sce;
		if ls_error<>"" then
			MessageBox("Database Error",ls_error, Exclamation!)
		end if
		return 1	/*Alumno viejo*/
	end if
End If
end event

event lee_dw_1;//		al_promedio=dw_1.object.aspiran_promedio[cont_1]
//		al_nombre=dw_1.object.general_nombre[cont_1]
//		al_apaterno=dw_1.object.general_apaterno[cont_1]
//		al_amaterno=dw_1.object.general_amaterno[cont_1]
//		al_calle=dw_1.object.general_calle[cont_1]
//		al_cp=dw_1.object.general_codigo_pos[cont_1]
//		pa_tele=dw_1.object.padres_telefono[cont_1]
//		al_colonia=dw_1.object.general_colonia[cont_1]
//		al_estado=dw_1.object.general_estado[cont_1]
//		al_tele=dw_1.object.general_telefono[cont_1]
//		al_fecha=dw_1.object.general_fecha_nac[cont_1]
//		al_lugar=dw_1.object.general_lugar_nac[cont_1]
//		al_nacion=dw_1.object.general_nacional[cont_1]
//		al_sexo=dw_1.object.general_sexo[cont_1]
//		al_civil=dw_1.object.general_edo_civil[cont_1]
//		al_religion=dw_1.object.general_religion[cont_1]
//		al_bachi=dw_1.object.general_bachillera[cont_1]
//		al_trabajo=dw_1.object.general_trabajo[cont_1]
//		al_horas=dw_1.object.general_trab_hor[cont_1]
//		al_transp=dw_1.object.general_transporte[cont_1]
//		al_plan=dw_1.object.paquetes_clv_plan[cont_1]
//		al_carr=dw_1.object.paquetes_clv_carr[cont_1]
		al_paq=dw_1.object.num_paq[cont_1]
//		pa_nombre=dw_1.object.padres_nombre[cont_1]
//		pa_apaterno=dw_1.object.padres_apaterno[cont_1]
//		pa_amaterno=dw_1.object.padres_amaterno[cont_1]
//		pa_calle=dw_1.object.padres_calle[cont_1]
//		pa_cp=dw_1.object.padres_codigo_pos[cont_1]
//		pa_colonia=dw_1.object.padres_colonia[cont_1]
//		pa_estado=dw_1.object.padres_estado[cont_1]
//
end event

event lee_dw_2;			al_mat=dw_2.object.clv_mat[cont_2]
			al_grupo=dw_2.object.grupo[cont_2]

end event

event ins_alumnos;string ls_error
  INSERT INTO alumnos  
         ( cuenta,   
           nombre,   
           apaterno,   
           amaterno,   
           sexo,   
           cve_trabajo,   
           horas_trabajo,   
           fecha_nac,   
           lugar_nac,   
           cve_transp,   
           cve_nacion,   
           cve_religion,   
           cve_edocivil,   
           promedio_bach)  
  VALUES ( :cuenta,   
           :al_nombre,   
           :al_apaterno,   
           :al_amaterno,   
           :al_sexo,   
           :al_trabajo,   
           :al_horas,   
           :al_fecha,   
           :al_lugar,   
           :al_transp,   
           :al_nacion,   
           :al_religion,   
           :al_civil,   
           :al_promedio)  
	USING gtr_sce;
	ls_error=gtr_sce.SQLErrText
	commit using gtr_sce;
	if ls_error<>"" then
		MessageBox("Database Error",ls_error, Exclamation!)
	end if
end event

event ins_estudio_ant;string ls_error

INSERT INTO dbo.estudio_ant
	( cuenta,cve_escuela,cve_carrera,cve_grado )
VALUES ( :cuenta,:al_bachi,NULL,'B')
USING gtr_sce;

ls_error=gtr_sce.SQLErrText
commit using gtr_sce;
if ls_error<>"" then
	MessageBox("Database Error",ls_error, Exclamation!)
end if
end event

event ins_hist_reingreso;int a,b,c
string ls_error
	
	  SELECT academicos.periodo_ing,   
         academicos.anio_ing,   
         academicos.cve_formaingreso  
    INTO :a,:b,:c  
    FROM academicos  
   WHERE academicos.cuenta = :cuenta
	USING gtr_sce;

if (a<>gi_periodo or b<>gi_anio or c<>0) then 
	  INSERT INTO hist_reingreso  
				( cuenta,   
				  cve_formaingreso,   
				  periodo_ing,   
				  anio_ing )  
	  VALUES ( :cuenta,   
				  :c,   
				  :a,   
				  :b )  
		USING gtr_sce;
		ls_error=gtr_sce.SQLErrText
		commit using gtr_sce;
		if ls_error<>"" then
			MessageBox("Database Error",ls_error, Exclamation!)
		end if
end if
end event

event ins_mat_inscritas;long temp,cupo,inscritos
int tipo, clave_asimilada
string grupo_asimilado,ls_error

SELECT dbo.mat_inscritas.cuenta
INTO :temp
FROM dbo.mat_inscritas
WHERE ( dbo.mat_inscritas.cuenta = :cuenta ) AND
	( dbo.mat_inscritas.cve_mat = :al_mat ) AND
	( dbo.mat_inscritas.gpo = :al_grupo ) AND
	( dbo.mat_inscritas.periodo = :al_periodo ) AND
	( dbo.mat_inscritas.anio = :al_anio )
USING gtr_sce;

/*Si existe la cuenta quiere decir que la materia ya se inscribio*/
if temp=cuenta then
	return
end if
/* Comentado debido a que las validaciones posteriores se hacen via trigger*/

//SELECT grupos.tipo,grupos.cupo,grupos.inscritos
//INTO :tipo,:cupo,:inscritos
//FROM grupos  
//WHERE ( grupos.cve_mat = :al_mat ) AND  
//	( grupos.gpo = :al_grupo ) AND  
//	( grupos.periodo = :gi_periodo ) AND  
//	( grupos.anio = :gi_anio )
//USING gtr_sce;
//
//if inscritos>=cupo then
//	/*Mensaje o archivo*/
//	return
//end if
//	
//if tipo=2 then
//	
//  SELECT grupos.cve_asimilada,   
//         grupos.gpo_asimilado  
//    INTO :clave_asimilada,   
//         :grupo_asimilado
//    FROM grupos  
//    WHERE ( grupos.cve_mat = :al_mat ) AND  
//         ( grupos.gpo = :al_grupo ) AND  
//         ( grupos.periodo = :gi_periodo ) AND  
//         ( grupos.anio = :gi_anio )
//	USING gtr_sce;
//	
//	UPDATE grupos  
//	SET inscritos = inscritos + 1 
//	WHERE ((( grupos.cve_mat = :clave_asimilada) AND
//		( grupos.gpo = :grupo_asimilado)) OR
//		(( grupos.cve_asimilada = :clave_asimilada) AND
//		( grupos.gpo_asimilado =:grupo_asimilado))) AND
//		( grupos.periodo = :gi_periodo) AND
//		( grupos.anio = :gi_anio)
//	USING gtr_sce;
//
//	if gtr_sce.SQLErrText<>"" then
//		ls_error=gtr_sce.SQLErrText
//		rollback using gtr_sce;
//		MessageBox("Database Error",ls_error, Exclamation!)
//		return
//	end if
//
//else
//	
//	UPDATE grupos  
//	SET inscritos = inscritos + 1 
//	WHERE ((( grupos.cve_mat = :al_mat ) AND  
//		( grupos.gpo = :al_grupo )) OR
//		(( grupos.cve_asimilada = :al_mat) AND
//		( grupos.gpo_asimilado = :al_grupo))) AND
//		( grupos.periodo = :gi_periodo) AND
//		( grupos.anio = :gi_anio)
//	USING gtr_sce;
//
//	if gtr_sce.SQLErrText<>"" then
//		ls_error=gtr_sce.SQLErrText
//		rollback using gtr_sce;
//		MessageBox("Database Error",ls_error, Exclamation!)
//		return
//	end if
//
//end if
  
INSERT INTO mat_inscritas  
	( cuenta, cve_mat, gpo, periodo, anio, cve_condicion, acreditacion, inscripcion )
VALUES ( :cuenta, :al_mat, :al_grupo, :al_periodo, :al_anio, 0, 0, 'I' )  
USING gtr_sce;
if gtr_sce.SQLErrText<>"" then
	ls_error=gtr_sce.SQLErrText
	rollback using gtr_sce;
	MessageBox("Database Error",ls_error, Exclamation!)
	return
else
	commit using gtr_sce;
end if
end event

event act_alumnos;string ls_error
  UPDATE alumnos  
     SET nombre = :al_nombre,   
         apaterno = :al_apaterno,  
			amaterno = :al_amaterno,
         sexo = :al_sexo,   
         cve_trabajo = :al_trabajo,   
         horas_trabajo = :al_horas,   
         fecha_nac = :al_fecha,   
         lugar_nac = :al_lugar,   
         cve_transp = :al_transp,   
         cve_nacion = :al_nacion,   
         cve_religion = :al_religion,   
         cve_edocivil = :al_civil,   
         promedio_bach = :al_promedio			
   WHERE alumnos.cuenta = :cuenta   
	USING gtr_sce;
	ls_error=gtr_sce.SQLErrText
	commit using gtr_sce;
	if ls_error<>"" then
		MessageBox("Database Error",ls_error, Exclamation!)
	end if
end event

event act_domicilio;string ls_error
  UPDATE domicilio  
     SET calle = :al_calle,   
         colonia = :al_colonia,   
         cve_estado = :al_estado,   
         cod_postal = :al_cp,   
         telefono = :al_tele  
   WHERE domicilio.cuenta = :cuenta
   USING gtr_sce;
	ls_error=gtr_sce.SQLErrText
	commit using gtr_sce;
	if ls_error<>"" then
		MessageBox("Database Error",ls_error, Exclamation!)
	end if
end event

event act_padre;string ls_error

  UPDATE padre  
     SET nombre = :pa_nombre,   
         apaterno = :pa_apaterno,   
         amaterno = :pa_amaterno,   
         calle = :pa_calle,   
         colonia = :pa_colonia,   
         cve_estado = :pa_estado,   
         cod_postal = :pa_cp,   
         telefono = :pa_tele  
   WHERE padre.cuenta = :cuenta   
	USING gtr_sce;
	ls_error=gtr_sce.SQLErrText
	commit using gtr_sce;
	if ls_error<>"" then
		MessageBox("Database Error",ls_error, Exclamation!)
	end if
end event

event act_estudio_ant;string ls_error
UPDATE estudio_ant  
     SET cve_escuela = :al_bachi,   
         cve_carrera = NULL  
   WHERE ( estudio_ant.cuenta = :cuenta ) AND  
         ( estudio_ant.cve_grado = 'B' )
	USING gtr_sce;
	ls_error=gtr_sce.SQLErrText
	commit using gtr_sce;
	if ls_error<>"" then
		MessageBox("Database Error",ls_error, Exclamation!)
	end if
end event

event act_academicos;string ls_error

	UPDATE academicos  
     SET cve_carrera = :al_carr,   
         cve_plan = :al_plan,   
         cve_subsistema = 0,   
         nivel = 'L',   
         promedio = 0,   
         sem_cursados = 0,   
         creditos_cursados = 0,   
         egresado = 0,   
         periodo_ing=:gi_periodo,   
         anio_ing=:gi_anio,   
         cve_formaingreso = 0  
   WHERE academicos.cuenta = :cuenta
	USING gtr_sce;
	ls_error=gtr_sce.SQLErrText
	commit using gtr_sce;
	if ls_error<>"" then
		MessageBox("Database Error",ls_error, Exclamation!)
	end if
end event

event act_banderas;string ls_error
  UPDATE banderas  
     SET insc_sem_ant = 1,   
         cve_flag_promedio = 0,   
         baja_3_reprob = 0,   
         baja_4_insc = 0,   
         baja_disciplina = 0,   
         baja_documentos = 0,   
         invasor_hora = 0,   
         exten_cred = 0,   
         cve_flag_prerreq_ingles = 0,   
         cve_flag_serv_social = 0,   
         puede_integracion = 0,   
         tema_fundamental_1 = 0,   
         tema_fundamental_2 = 0,   
         tema_1 = 0,   
         tema_2 = 0,   
         tema_3 = 0,   
         tema_4 = 0,   
         creditos_integ = 0,   
         cve_flag_biblioteca = 0,   
         cve_flag_diapositeca = 0,   
         adeuda_finanzas = 0,   
         verano = 0  
   WHERE banderas.cuenta = :cuenta
	USING gtr_sce;
	ls_error=gtr_sce.SQLErrText
	commit using gtr_sce;
	if ls_error<>"" then
		MessageBox("Database Error",ls_error, Exclamation!)
	end if
end event

event ins_hist_carreras;int carr_ant,plan_ant,subs_ant,peri_ant,anio_ant,forma_ingreso
string ls_error

  SELECT academicos.cve_carrera,   
         academicos.cve_plan,   
         academicos.cve_subsistema,   
         academicos.periodo_ing,   
         academicos.anio_ing,  
			academicos.cve_formaingreso
    INTO :carr_ant,   
         :plan_ant,   
         :subs_ant,   
         :peri_ant,   
         :anio_ant,  
			:forma_ingreso
    FROM academicos  
   WHERE academicos.cuenta = :cuenta
	USING gtr_sce;
	
	if (carr_ant<>al_carr or plan_ant<>al_plan) then
	
		  INSERT INTO hist_carreras  
				( cuenta,   
				  cve_formaingreso,   
				  cve_carrera_ant,   
				  cve_plan_ant,   
				  cve_subsistema_ant,   
				  cve_carrera_act,   
				  cve_plan_act,   
				  cve_subsistema_act,   
				  periodo_ing,   
				  anio_ing )  
	  VALUES ( :cuenta,   
				  :forma_ingreso,   
				  :carr_ant,   
				  :plan_ant,   
				  :subs_ant,   
				  :al_carr,   
				  :al_plan,   
				  0,   
				  :peri_ant,   
				  :anio_ant )
		USING gtr_sce;
		ls_error=gtr_sce.SQLErrText
		commit using gtr_sce;
		if ls_error<>"" then
			MessageBox("Database Error",ls_error, Exclamation!)
		end if
	end if
end event

public function integer wf_enlace_sce (long al_cuenta, integer ai_periodo, integer ai_anio);string ls_mensaje
integer li_codigo_error


DECLARE spenlacesce procedure for sp_enlace_sce
@cuenta = :al_cuenta, 
@periodo = :ai_periodo, 
@anio = :ai_anio
using gtr_sadm;

EXECUTE spenlacesce;

li_codigo_error= gtr_sadm.SQLCode

ls_mensaje= gtr_sadm.SQLErrText

if li_codigo_error = -1 then
	MessageBox("Error al ejecutar sp_enlace_sce", ls_mensaje)
	return -1
else
	COMMIT USING gtr_sadm;
	return 0
end if




end function

on w_actualiza_aspirantes_alumnos.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.st_5=create st_5
this.st_4=create st_4
this.st_fin=create st_fin
this.st_ini=create st_ini
this.st_1=create st_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.uo_1=create uo_1
this.em_max=create em_max
this.em_min=create em_min
this.Control[]={this.st_5,&
this.st_4,&
this.st_fin,&
this.st_ini,&
this.st_1,&
this.dw_2,&
this.dw_1,&
this.uo_1,&
this.em_max,&
this.em_min}
end on

on w_actualiza_aspirantes_alumnos.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_fin)
destroy(this.st_ini)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.uo_1)
destroy(this.em_max)
destroy(this.em_min)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
dw_2.settransobject(gtr_sadm)


end event

type st_5 from statictext within w_actualiza_aspirantes_alumnos
integer x = 26
integer y = 1293
integer width = 428
integer height = 61
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 30976088
string text = "Hora Término:"
boolean focusrectangle = false
end type

type st_4 from statictext within w_actualiza_aspirantes_alumnos
integer x = 26
integer y = 1149
integer width = 413
integer height = 61
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 30976088
string text = "Hora Inicio:"
boolean focusrectangle = false
end type

type st_fin from statictext within w_actualiza_aspirantes_alumnos
integer x = 457
integer y = 1283
integer width = 669
integer height = 77
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29534863
boolean enabled = false
string text = "none"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_ini from statictext within w_actualiza_aspirantes_alumnos
integer x = 457
integer y = 1139
integer width = 669
integer height = 77
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29534863
boolean enabled = false
string text = "none"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_1 from statictext within w_actualiza_aspirantes_alumnos
integer x = 7
integer y = 208
integer width = 3522
integer height = 77
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

event constructor;text=""
end event

type dw_2 from datawindow within w_actualiza_aspirantes_alumnos
boolean visible = false
integer x = 2085
integer y = 1245
integer width = 1382
integer height = 128
string dataobject = "dw_paquetes_materias"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_1 from uo_dw_reporte within w_actualiza_aspirantes_alumnos
integer x = 18
integer y = 333
integer width = 3522
integer height = 768
integer taborder = 0
string dataobject = "dw_actualiza_aspirantes_alumnos"
boolean hscrollbar = true
end type

event type integer carga();integer li_confirma
string ls_min, ls_max
long ll_min, ll_max

ls_min = em_min.text
ls_max = em_max.text
ll_min = long(ls_min)
ll_max = long(ls_max)
li_confirma= MessageBox("Confirmacion","¿Desea realizar la actualización de datos? ["+ls_min+"] ["+ls_max+"]",Question!, YesNo!)


if li_confirma= 1 then
	st_1.text="Leyendo datos de los aspirantes inscritos"
	return retrieve(gi_version,gi_periodo,gi_anio,ll_min,ll_max)
end if

return 0
end event

event retrieveend;call super::retrieveend;parent.event enlace()
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

type uo_1 from uo_ver_per_ani within w_actualiza_aspirantes_alumnos
integer x = 26
integer y = 26
integer height = 166
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type em_max from editmask within w_actualiza_aspirantes_alumnos
integer x = 2889
integer y = 51
integer width = 336
integer height = 99
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
string mask = "######"
boolean spin = true
string displaydata = ""
double increment = 1
string minmax = "2~~999999"
end type

event constructor;text=string(event num_folios(1))
end event

event getfocus;text=string(event num_folios(1))
end event

type em_min from editmask within w_actualiza_aspirantes_alumnos
integer x = 2534
integer y = 51
integer width = 336
integer height = 99
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
string mask = "######"
boolean spin = true
string displaydata = ""
double increment = 1
string minmax = "2~~999999"
end type

event constructor;text=string(event num_folios(0))
end event

event getfocus;text=string(event num_folios(0))
end event

