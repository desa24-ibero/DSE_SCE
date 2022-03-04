$PBExportHeader$w_enlace.srw
$PBExportComments$Procedimiento para transferir los datos del sistema de Admisión a los catálogos del sistema de Control Escolar
forward
global type w_enlace from Window
end type
type st_1 from statictext within w_enlace
end type
type dw_2 from datawindow within w_enlace
end type
type dw_1 from uo_dw_reporte within w_enlace
end type
type uo_1 from uo_ver_per_ani within w_enlace
end type
type em_max from editmask within w_enlace
end type
type em_min from editmask within w_enlace
end type
end forward

global type w_enlace from Window
int X=834
int Y=362
int Width=3562
int Height=1808
boolean TitleBar=true
string Title="Enlace del Sistema de Admisión al Sistema de Control Escolar"
string MenuName="m_menu"
long BackColor=30976088
event type long num_folios ( integer min_max )
event enlace ( )
event type integer checa ( long cuento )
event lee_dw_1 ( )
event lee_dw_2 ( )
event ins_alumnos ( )
event ins_estudio_ant ( )
event ins_hist_reingreso ( )
event ins_mat_inscritas ( )
event act_alumnos ( )
event act_domicilio ( )
event act_padre ( )
event act_estudio_ant ( )
event act_academicos ( )
event act_banderas ( )
event ins_hist_carreras ( )
st_1 st_1
dw_2 dw_2
dw_1 dw_1
uo_1 uo_1
em_max em_max
em_min em_min
end type
global w_enlace w_enlace

type variables
int al_estado,al_lugar,al_nacion,al_civil,al_religion,al_bachi,al_trabajo,al_horas,al_transp
long pa_estado,al_plan,al_carr,al_paq,cont_2,al_mat
long cont_1,cuenta
real al_promedio
string al_nombre,al_apaterno,al_amaterno,al_calle,al_colonia,al_cp,al_tele,al_sexo
string pa_nombre,pa_apaterno,pa_amaterno,pa_calle,pa_colonia,pa_cp,pa_tele,al_grupo
datetime al_fecha

end variables

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

event enlace;SetPointer(HourGlass!)

for cont_1=1 to dw_1.rowcount()

	cuenta=dw_1.object.general_cuenta[cont_1]
	st_1.text="Leyendo datos de "+string(cuenta)
	event lee_dw_1()
	if event checa(cuenta)=0 then
		//messagebox("Agregando","")
		event ins_alumnos()
		event act_domicilio()
		event act_padre()
		event ins_estudio_ant()
		event act_academicos()
		event act_banderas()
		commit using gtr_sce;
	else
		//messagebox("Actualizando","")
		event act_alumnos()
		event act_domicilio()
		event act_padre()
		event act_estudio_ant()
		event ins_hist_carreras()
		event ins_hist_reingreso()			
		event act_academicos()
		event act_banderas()
		commit using gtr_sce;
	end if
	
	dw_2.retrieve(al_paq, gi_periodo, gi_anio)
//	dw_2.retrieve(al_paq)
	for cont_2=1 to dw_2.rowcount()
		st_1.text="Leyendo datos de "+string(cuenta)+" , "+string(cont_2)+" materia."
		event lee_dw_2()
		event ins_mat_inscritas()
	next	
	commit using gtr_sce;	
next

st_1.text="Ya acabe"
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

event lee_dw_1;		al_promedio=dw_1.object.aspiran_promedio[cont_1]
		al_nombre=dw_1.object.general_nombre[cont_1]
		al_apaterno=dw_1.object.general_apaterno[cont_1]
		al_amaterno=dw_1.object.general_amaterno[cont_1]
		al_calle=dw_1.object.general_calle[cont_1]
		al_cp=dw_1.object.general_codigo_pos[cont_1]
		pa_tele=dw_1.object.padres_telefono[cont_1]
		al_colonia=dw_1.object.general_colonia[cont_1]
		al_estado=dw_1.object.general_estado[cont_1]
		al_tele=dw_1.object.general_telefono[cont_1]
		al_fecha=dw_1.object.general_fecha_nac[cont_1]
		al_lugar=dw_1.object.general_lugar_nac[cont_1]
		al_nacion=dw_1.object.general_nacional[cont_1]
		al_sexo=dw_1.object.general_sexo[cont_1]
		al_civil=dw_1.object.general_edo_civil[cont_1]
		al_religion=dw_1.object.general_religion[cont_1]
		al_bachi=dw_1.object.general_bachillera[cont_1]
		al_trabajo=dw_1.object.general_trabajo[cont_1]
		al_horas=dw_1.object.general_trab_hor[cont_1]
		al_transp=dw_1.object.general_transporte[cont_1]
		al_plan=dw_1.object.paquetes_clv_plan[cont_1]
		al_carr=dw_1.object.paquetes_clv_carr[cont_1]
		al_paq=dw_1.object.paquetes_num_paq[cont_1]
		pa_nombre=dw_1.object.padres_nombre[cont_1]
		pa_apaterno=dw_1.object.padres_apaterno[cont_1]
		pa_amaterno=dw_1.object.padres_amaterno[cont_1]
		pa_calle=dw_1.object.padres_calle[cont_1]
		pa_cp=dw_1.object.padres_codigo_pos[cont_1]
		pa_colonia=dw_1.object.padres_colonia[cont_1]
		pa_estado=dw_1.object.padres_estado[cont_1]

end event

event lee_dw_2;			al_mat=dw_2.object.clv_mat[cont_2]
			al_grupo=dw_2.object.grupo[cont_2]

end event

event ins_alumnos;string ls_error
  INSERT INTO dbo.alumnos  
         ( dbo.alumnos.cuenta,   
           dbo.alumnos.nombre,   
           dbo.alumnos.apaterno,   
           dbo.alumnos.amaterno,   
           dbo.alumnos.sexo,   
           dbo.alumnos.cve_trabajo,   
           dbo.alumnos.horas_trabajo,   
           dbo.alumnos.fecha_nac,   
           dbo.alumnos.lugar_nac,   
           dbo.alumnos.cve_transp,   
           dbo.alumnos.cve_nacion,   
           dbo.alumnos.cve_religion,   
           dbo.alumnos.cve_edocivil,   
           dbo.alumnos.promedio_bach)  
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
	( dbo.estudio_ant.cuenta, dbo.estudio_ant.cve_escuela, dbo.estudio_ant.cve_carrera, dbo.estudio_ant.cve_grado)
VALUES ( :cuenta, :al_bachi, NULL, 'B')
USING gtr_sce;

ls_error=gtr_sce.SQLErrText
commit using gtr_sce;
if ls_error<>"" then
	MessageBox("Database Error",ls_error, Exclamation!)
end if
end event

event ins_hist_reingreso;int a,b,c
string ls_error
	
	  SELECT dbo.academicos.periodo_ing,   
         dbo.academicos.anio_ing,   
         dbo.academicos.cve_formaingreso  
    INTO :a,:b,:c  
    FROM dbo.academicos  
   WHERE dbo.academicos.cuenta = :cuenta
	USING gtr_sce;

if (a<>gi_periodo or b<>gi_anio or c<>0) then 
	  INSERT INTO dbo.hist_reingreso  
				( dbo.hist_reingreso.cuenta,   
				  dbo.hist_reingreso.cve_formaingreso,   
				  dbo.hist_reingreso.periodo_ing,   
				  dbo.hist_reingreso.anio_ing )  
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
	( dbo.mat_inscritas.periodo = :gi_periodo ) AND
	( dbo.mat_inscritas.anio = :gi_anio )
USING gtr_sce;

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
  
INSERT INTO dbo.mat_inscritas  
	( dbo.mat_inscritas.cuenta, dbo.mat_inscritas.cve_mat, dbo.mat_inscritas.gpo,
	dbo.mat_inscritas.periodo, dbo.mat_inscritas.anio, dbo.mat_inscritas.cve_condicion, 
	dbo.mat_inscritas.acreditacion, dbo.mat_inscritas.inscripcion )
VALUES ( :cuenta, :al_mat, :al_grupo, :gi_periodo, :gi_anio, 0, 0, 'I' )  
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
  UPDATE dbo.alumnos  
     SET dbo.alumnos.nombre = :al_nombre,   
         dbo.alumnos.apaterno = :al_apaterno,  
			dbo.alumnos.amaterno = :al_amaterno,
         dbo.alumnos.sexo = :al_sexo,   
         dbo.alumnos.cve_trabajo = :al_trabajo,   
         dbo.alumnos.horas_trabajo = :al_horas,   
         dbo.alumnos.fecha_nac = :al_fecha,   
         dbo.alumnos.lugar_nac = :al_lugar,   
         dbo.alumnos.cve_transp = :al_transp,   
         dbo.alumnos.cve_nacion = :al_nacion,   
         dbo.alumnos.cve_religion = :al_religion,   
         dbo.alumnos.cve_edocivil = :al_civil,   
         dbo.alumnos.promedio_bach = :al_promedio			
   WHERE dbo.alumnos.cuenta = :cuenta   
	USING gtr_sce;
	ls_error=gtr_sce.SQLErrText
	commit using gtr_sce;
	if ls_error<>"" then
		MessageBox("Database Error",ls_error, Exclamation!)
	end if
end event

event act_domicilio;string ls_error
  UPDATE dbo.domicilio  
     SET dbo.domicilio.calle = :al_calle,   
         dbo.domicilio.colonia = :al_colonia,   
         dbo.domicilio.cve_estado = :al_estado,   
         dbo.domicilio.cod_postal = :al_cp,   
         dbo.domicilio.telefono = :al_tele  
   WHERE dbo.domicilio.cuenta = :cuenta
   USING gtr_sce;
	ls_error=gtr_sce.SQLErrText
	commit using gtr_sce;
	if ls_error<>"" then
		MessageBox("Database Error",ls_error, Exclamation!)
	end if
end event

event act_padre;string ls_error

  UPDATE dbo.padre  
     SET dbo.padre.nombre = :pa_nombre,   
         dbo.padre.apaterno = :pa_apaterno,   
         dbo.padre.amaterno = :pa_amaterno,   
         dbo.padre.calle = :pa_calle,   
         dbo.padre.colonia = :pa_colonia,   
         dbo.padre.cve_estado = :pa_estado,   
         dbo.padre.cod_postal = :pa_cp,   
         dbo.padre.telefono = :pa_tele  
   WHERE dbo.padre.cuenta = :cuenta   
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

	UPDATE dbo.academicos  
     SET dbo.academicos.cve_carrera = :al_carr,   
         dbo.academicos.cve_plan = :al_plan,   
         dbo.academicos.cve_subsistema = 0,   
         dbo.academicos.nivel = 'L',   
         dbo.academicos.promedio = 0,   
         dbo.academicos.sem_cursados = 0,   
         dbo.academicos.creditos_cursados = 0,   
         dbo.academicos.egresado = 0,   
         dbo.academicos.periodo_ing=:gi_periodo,   
         dbo.academicos.anio_ing=:gi_anio,   
         dbo.academicos.cve_formaingreso = 0  
   WHERE dbo.academicos.cuenta = :cuenta
	USING gtr_sce;
	ls_error=gtr_sce.SQLErrText
	commit using gtr_sce;
	if ls_error<>"" then
		MessageBox("Database Error",ls_error, Exclamation!)
	end if
end event

event act_banderas;string ls_error
  UPDATE dbo.banderas  
     SET dbo.banderas.insc_sem_ant = 1,   
         dbo.banderas.cve_flag_promedio = 0,   
         dbo.banderas.baja_3_reprob = 0,   
         dbo.banderas.baja_4_insc = 0,   
         dbo.banderas.baja_disciplina = 0,   
         dbo.banderas.baja_documentos = 0,   
         dbo.banderas.invasor_hora = 0,   
         dbo.banderas.exten_cred = 0,   
         dbo.banderas.cve_flag_prerreq_ingles = 0,   
         dbo.banderas.cve_flag_serv_social = 0,   
         dbo.banderas.puede_integracion = 0,   
         dbo.banderas.tema_fundamental_1 = 0,   
         dbo.banderas.tema_fundamental_2 = 0,   
         dbo.banderas.tema_1 = 0,   
         dbo.banderas.tema_2 = 0,   
         dbo.banderas.tema_3 = 0,   
         dbo.banderas.tema_4 = 0,   
         dbo.banderas.creditos_integ = 0,   
         dbo.banderas.cve_flag_biblioteca = 0,   
         dbo.banderas.cve_flag_diapositeca = 0,   
         dbo.banderas.adeuda_finanzas = 0,   
         dbo.banderas.verano = 0  
   WHERE dbo.banderas.cuenta = :cuenta
	USING gtr_sce;
	ls_error=gtr_sce.SQLErrText
	commit using gtr_sce;
	if ls_error<>"" then
		MessageBox("Database Error",ls_error, Exclamation!)
	end if
	
	
end event

event ins_hist_carreras;int carr_ant,plan_ant,subs_ant,peri_ant,anio_ant,forma_ingreso
string ls_error

  SELECT dbo.academicos.cve_carrera,   
         dbo.academicos.cve_plan,   
         dbo.academicos.cve_subsistema,   
         dbo.academicos.periodo_ing,   
         dbo.academicos.anio_ing,  
			dbo.academicos.cve_formaingreso
    INTO :carr_ant,   
         :plan_ant,   
         :subs_ant,   
         :peri_ant,   
         :anio_ant,  
			:forma_ingreso
    FROM dbo.academicos  
   WHERE dbo.academicos.cuenta = :cuenta
	USING gtr_sce;
	
	if (carr_ant<>al_carr or plan_ant<>al_plan) then
	
		  INSERT INTO dbo.hist_carreras  
				( dbo.hist_carreras.cuenta,   
				  dbo.hist_carreras.cve_formaingreso,   
				  dbo.hist_carreras.cve_carrera_ant,   
				  dbo.hist_carreras.cve_plan_ant,   
				  dbo.hist_carreras.cve_subsistema_ant,   
				  dbo.hist_carreras.cve_carrera_act,   
				  dbo.hist_carreras.cve_plan_act,   
				  dbo.hist_carreras.cve_subsistema_act,   
				  dbo.hist_carreras.periodo_ing,   
				  dbo.hist_carreras.anio_ing )  
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

on w_enlace.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.st_1=create st_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.uo_1=create uo_1
this.em_max=create em_max
this.em_min=create em_min
this.Control[]={this.st_1,&
this.dw_2,&
this.dw_1,&
this.uo_1,&
this.em_max,&
this.em_min}
end on

on w_enlace.destroy
if IsValid(MenuID) then destroy(MenuID)
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

type st_1 from statictext within w_enlace
int X=11
int Y=208
int Width=3522
int Height=77
boolean Enabled=false
string Text="none"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;text=""
end event

type dw_2 from datawindow within w_enlace
int X=1083
int Y=1094
int Width=1382
int Height=544
string DataObject="dw_paquetes_materias"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_1 from uo_dw_reporte within w_enlace
int X=18
int Y=333
int Width=3522
int Height=758
int TabOrder=0
string DataObject="dw_aspi-alum"
boolean HScrollBar=true
end type

event carga;st_1.text="Leyendo datos de los aspirantes inscritos"
return retrieve(gi_version,gi_periodo,gi_anio,long(em_min.text),long(em_max.text))
end event

event retrieveend;call super::retrieveend;parent.event enlace()
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

type uo_1 from uo_ver_per_ani within w_enlace
int X=29
int Y=26
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type em_max from editmask within w_enlace
int X=2889
int Y=54
int Width=340
int Height=102
Alignment Alignment=Center!
string Mask="######"
boolean Spin=true
string DisplayData=""
double Increment=1
string MinMax="2~~999999"
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;text=string(event num_folios(1))
end event

event getfocus;text=string(event num_folios(1))
end event

type em_min from editmask within w_enlace
int X=2534
int Y=54
int Width=340
int Height=102
Alignment Alignment=Center!
string Mask="######"
boolean Spin=true
string DisplayData=""
double Increment=1
string MinMax="2~~999999"
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;text=string(event num_folios(0))
end event

event getfocus;text=string(event num_folios(0))
end event

