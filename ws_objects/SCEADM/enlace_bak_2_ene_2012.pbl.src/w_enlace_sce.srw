$PBExportHeader$w_enlace_sce.srw
forward
global type w_enlace_sce from Window
end type
type st_hora_fin from statictext within w_enlace_sce
end type
type st_hora_ini from statictext within w_enlace_sce
end type
type st_1 from statictext within w_enlace_sce
end type
type dw_2 from datawindow within w_enlace_sce
end type
type dw_1 from uo_dw_reporte within w_enlace_sce
end type
type uo_1 from uo_ver_per_ani within w_enlace_sce
end type
type em_max from editmask within w_enlace_sce
end type
type em_min from editmask within w_enlace_sce
end type
end forward

global type w_enlace_sce from Window
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
st_hora_fin st_hora_fin
st_hora_ini st_hora_ini
st_1 st_1
dw_2 dw_2
dw_1 dw_1
uo_1 uo_1
em_max em_max
em_min em_min
end type
global w_enlace_sce w_enlace_sce

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
public function integer wf_enlace_sce_principal (integer ai_version, integer ai_periodo, integer ai_anio, long al_folio_ini, long al_folio_fin)
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

event enlace;long ll_folio_ini, ll_folio_fin, ll_rows
integer li_res_enlace
SetPointer(HourGlass!)
st_hora_ini.text = string(now())

if not isnumber(em_min.text) then
	MessageBox("Datos incompletos","Escriba un folio inicial")
	return
end if
if not isnumber(em_max.text) then
	MessageBox("Datos incompletos","Escriba un folio final")
	return
end if

ll_rows = dw_1.rowcount()

if ll_rows <=0 then
	MessageBox("Información inexistente","No existen registros que sean susceptibles de enlace")
	return
end if


ll_folio_ini = long(em_min.text)
ll_folio_fin = long(em_max.text)



li_res_enlace = wf_enlace_sce_principal(gi_version, gi_periodo, gi_anio,ll_folio_ini, ll_folio_fin)

//for cont_1=1 to dw_1.rowcount()
//
//	cuenta=dw_1.object.general_cuenta[cont_1]
//	st_1.text="Leyendo datos de "+string(cuenta)
////	event lee_dw_1()
//	wf_enlace_sce(cuenta, gi_periodo, gi_anio)
//		
////La inscripción de las materias se realizará en otra ventana		
////	dw_2.retrieve(al_paq)
////	for cont_2=1 to dw_2.rowcount()
////		st_1.text="Leyendo datos de "+string(cuenta)+" , "+string(cont_2)+" materia."
////		event lee_dw_2()
////		event ins_mat_inscritas()
////	next	
////	commit using gtr_sce;	
//next

st_hora_fin.text = string(now())

st_1.text="Ya acabe"

if li_res_enlace <>0 then
	MessageBox("Problemas durante la ejecucion del enlace","Favor de corregir los registros a enlazar")
	return
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
  
INSERT INTO mat_inscritas  
	( cuenta, cve_mat, gpo, periodo, anio, cve_condicion, acreditacion, inscripcion )
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
	MessageBox("Error al ejecutar sp_enlace_sce: "+string(al_cuenta), ls_mensaje)
	return -1
else
	COMMIT USING gtr_sadm;
	return 0
end if




end function

public function integer wf_enlace_sce_principal (integer ai_version, integer ai_periodo, integer ai_anio, long al_folio_ini, long al_folio_fin);string ls_mensaje
integer li_codigo_error


DECLARE spenlacesce procedure for sp_enlace_sce_principal
@version   = :ai_version,
@periodo   = :ai_periodo,
@anio      = :ai_anio,
@folio_ini = :al_folio_ini,
@folio_fin = :al_folio_fin
using gtr_sadm;

EXECUTE spenlacesce;

li_codigo_error= gtr_sadm.SQLCode
ls_mensaje= gtr_sadm.SQLErrText
CLOSE spenlacesce;

if li_codigo_error = -1 then
	MessageBox("Error al ejecutar sp_enlace_sce: ", ls_mensaje)
	return -1
else
	COMMIT USING gtr_sadm;
	return 0
end if




end function

on w_enlace_sce.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.st_hora_fin=create st_hora_fin
this.st_hora_ini=create st_hora_ini
this.st_1=create st_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.uo_1=create uo_1
this.em_max=create em_max
this.em_min=create em_min
this.Control[]={this.st_hora_fin,&
this.st_hora_ini,&
this.st_1,&
this.dw_2,&
this.dw_1,&
this.uo_1,&
this.em_max,&
this.em_min}
end on

on w_enlace_sce.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_hora_fin)
destroy(this.st_hora_ini)
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

type st_hora_fin from statictext within w_enlace_sce
int X=282
int Y=1328
int Width=669
int Height=77
boolean Enabled=false
string Text="none"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_hora_ini from statictext within w_enlace_sce
int X=282
int Y=1216
int Width=677
int Height=77
boolean Enabled=false
string Text="none"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_enlace_sce
int X=7
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

type dw_2 from datawindow within w_enlace_sce
int X=1083
int Y=1091
int Width=1382
int Height=544
string DataObject="dw_paquetes_materias"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_1 from uo_dw_reporte within w_enlace_sce
int X=18
int Y=333
int Width=3522
int Height=755
int TabOrder=0
string DataObject="dw_aspi-alum_sce_ing"
boolean HScrollBar=true
end type

event carga;st_1.text="Leyendo datos de los aspirantes inscritos"
return retrieve(gi_version,gi_periodo,gi_anio,long(em_min.text),long(em_max.text))
end event

event retrieveend;call super::retrieveend;parent.event enlace()
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

type uo_1 from uo_ver_per_ani within w_enlace_sce
int X=26
int Y=26
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type em_max from editmask within w_enlace_sce
int X=2889
int Y=51
int Width=336
int Height=99
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

type em_min from editmask within w_enlace_sce
int X=2534
int Y=51
int Width=336
int Height=99
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

