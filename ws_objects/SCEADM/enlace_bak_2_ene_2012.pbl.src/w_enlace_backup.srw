$PBExportHeader$w_enlace_backup.srw
forward
global type w_enlace_backup from Window
end type
type st_1 from statictext within w_enlace_backup
end type
type dw_1 from uo_dw_reporte within w_enlace_backup
end type
type uo_1 from uo_ver_per_ani within w_enlace_backup
end type
type em_max from editmask within w_enlace_backup
end type
type em_min from editmask within w_enlace_backup
end type
end forward

global type w_enlace_backup from Window
int X=833
int Y=361
int Width=3562
int Height=1281
boolean TitleBar=true
string Title="Enlace del Sistema de Admisión al Sistema de Control Escolar"
string MenuName="m_menu"
long BackColor=30976088
event type long num_folios ( integer min_max )
event enlace ( )
event type integer checa ( long cuento )
event lee_dw_1 ( )
event ins_alumnos ( )
event ins_estudio_ant ( )
event ins_hist_reingreso ( )
event act_alumnos ( )
event act_domicilio ( )
event act_padre ( )
event act_estudio_ant ( )
event act_academicos ( )
event act_banderas ( )
event ins_hist_carreras ( )
st_1 st_1
dw_1 dw_1
uo_1 uo_1
em_max em_max
em_min em_min
end type
global w_enlace_backup w_enlace_backup

type variables
int al_estado,al_lugar,al_nacion,al_civil,al_religion,al_bachi,al_trabajo,al_horas,al_transp
int pa_estado,al_plan,al_carr,cont_2
long cont_1,cuenta
real al_promedio
string al_nombre,al_apaterno,al_amaterno,al_calle,al_colonia,al_cp,al_tele,al_sexo
string pa_nombre,pa_apaterno,pa_amaterno,pa_calle,pa_colonia,pa_cp,pa_tele
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
		
		if isnull(dw_1.object.padres_telefono[cont_1]) then
			pa_tele="0"
		else
			pa_tele=dw_1.object.padres_telefono[cont_1]
		end if
		
		al_colonia=dw_1.object.general_colonia[cont_1]
		al_estado=dw_1.object.general_estado[cont_1]
		
		if isnull(dw_1.object.general_telefono[cont_1]) then
			al_tele="0"
		else
			al_tele=dw_1.object.general_telefono[cont_1]
		end if
		
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
		al_carr=dw_1.object.aspiran_clv_carr[cont_1]
		
		SELECT dbo.sol_foli.plan_est  
		INTO :al_plan  
		FROM dbo.sol_foli  
		WHERE ( dbo.sol_foli.clv_ver = :gi_version ) AND  
			( dbo.sol_foli.clv_per = :gi_periodo ) AND  
			( dbo.sol_foli.anio = :gi_anio ) AND  
			( dbo.sol_foli.clv_carr = :al_carr )
		USING gtr_sadm;
		
		pa_nombre=dw_1.object.padres_nombre[cont_1]
		pa_apaterno=dw_1.object.padres_apaterno[cont_1]
		pa_amaterno=dw_1.object.padres_amaterno[cont_1]
		pa_calle=dw_1.object.padres_calle[cont_1]
		pa_cp=dw_1.object.padres_codigo_pos[cont_1]
		pa_colonia=dw_1.object.padres_colonia[cont_1]
		pa_estado=dw_1.object.padres_estado[cont_1]

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
         creditos_integ = 72,   
         cve_flag_biblioteca = 0,   
         cve_flag_diapositeca = 0,   
         adeuda_finanzas = 0,   
         verano = 0  
   WHERE banderas.cuenta = :cuenta
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

on w_enlace_backup.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.st_1=create st_1
this.dw_1=create dw_1
this.uo_1=create uo_1
this.em_max=create em_max
this.em_min=create em_min
this.Control[]={ this.st_1,&
this.dw_1,&
this.uo_1,&
this.em_max,&
this.em_min}
end on

on w_enlace_backup.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.uo_1)
destroy(this.em_max)
destroy(this.em_min)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type st_1 from statictext within w_enlace_backup
int X=10
int Y=209
int Width=3521
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

type dw_1 from uo_dw_reporte within w_enlace_backup
int X=19
int Y=333
int Width=3521
int Height=757
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

type uo_1 from uo_ver_per_ani within w_enlace_backup
int X=28
int Y=25
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type em_max from editmask within w_enlace_backup
int X=2890
int Y=53
int Width=339
int Height=101
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

type em_min from editmask within w_enlace_backup
int X=2533
int Y=53
int Width=339
int Height=101
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

