$PBExportHeader$w_preinsctoreinsc_ant_5_dig.srw
forward
global type w_preinsctoreinsc_ant_5_dig from window
end type
type uo_nombre from uo_nombre_alumno_sparl within w_preinsctoreinsc_ant_5_dig
end type
type sle_2 from singlelineedit within w_preinsctoreinsc_ant_5_dig
end type
type sle_1 from singlelineedit within w_preinsctoreinsc_ant_5_dig
end type
type cb_1 from commandbutton within w_preinsctoreinsc_ant_5_dig
end type
type st_total from statictext within w_preinsctoreinsc_ant_5_dig
end type
type cb_preinsctoreinsc from commandbutton within w_preinsctoreinsc_ant_5_dig
end type
type dw_mat_preinsc from datawindow within w_preinsctoreinsc_ant_5_dig
end type
type p_uia from picture within w_preinsctoreinsc_ant_5_dig
end type
type dw_reinsc_mat from datawindow within w_preinsctoreinsc_ant_5_dig
end type
type dw_horario_mat from datawindow within w_preinsctoreinsc_ant_5_dig
end type
type dw_materias from datawindow within w_preinsctoreinsc_ant_5_dig
end type
type dw_plan from datawindow within w_preinsctoreinsc_ant_5_dig
end type
type dw_ext_h from datawindow within w_preinsctoreinsc_ant_5_dig
end type
type dw_prerre from datawindow within w_preinsctoreinsc_ant_5_dig
end type
type dw_cursada from datawindow within w_preinsctoreinsc_ant_5_dig
end type
type mensaje from structure within w_preinsctoreinsc_ant_5_dig
end type
end forward

type mensaje from structure
	statictext		hora[15]
end type

global type w_preinsctoreinsc_ant_5_dig from window
integer x = 5
integer y = 4
integer width = 3648
integer height = 2412
boolean titlebar = true
string title = "Sistema de Reinscripción en Linea"
string menuname = "m_preinsctoreinsc"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 12639424
event inicia_proceso ( )
event cierra_ventanas_grupos ( )
uo_nombre uo_nombre
sle_2 sle_2
sle_1 sle_1
cb_1 cb_1
st_total st_total
cb_preinsctoreinsc cb_preinsctoreinsc
dw_mat_preinsc dw_mat_preinsc
p_uia p_uia
dw_reinsc_mat dw_reinsc_mat
dw_horario_mat dw_horario_mat
dw_materias dw_materias
dw_plan dw_plan
dw_ext_h dw_ext_h
dw_prerre dw_prerre
dw_cursada dw_cursada
end type
global w_preinsctoreinsc_ant_5_dig w_preinsctoreinsc_ant_5_dig

type variables
int cred_integ
int crd_ant
horario hora[15]

int BanderasAlumno[23]
long I_CarreraAlumno
long I_PlanAlumno
long I_cvss
int I_cms//Creditos Maximos al Semestre
int I_tipo, I_mat_a,I_cupo, I_insc
string  I_gpo_a
char nivel//L o P
//char incorp_sep//S o N
//variables que contienen parametros de activacion
int ex_cred,tipo_insc, exe_cupo,mat_enci

string i_men
int i_baj_per_dis, i_imp_com, i_preinsc
int i_pregunta_nip, i_revisa_teoria_lab,i_revisa_grupos_bloqueados
int i_nivel

//variables para bloqueos
int band_bloq
string bloqueado_por

//varible para seleccion de mat
int linea_select

//Struct
//mensaje dia_h[7]

CONSTANT int b_isa = 1, b_cfp = 2, b_b3r = 3, b_b4i = 4
CONSTANT int b_bdi = 5, b_bdo = 6, b_ih = 7, b_ec = 8
CONSTANT int b_cfpi = 9, b_cfss = 10, b_pi = 11
CONSTANT int b_tf1 = 12, b_tf2 = 13, b_t1 = 14, b_t2 = 15
CONSTANT int b_t3 = 16, b_t4 = 17, b_ci = 18, b_cfb = 19
CONSTANT int b_cfd = 20, b_af = 21, b_v = 22, b_bl= 23

DataStore  dw_mat_prerre, dw_teoria_lab

int aceptado=0//variable usada como interfaz con preinscripcion
string i_mensaje

int ii_statusmat_preinsc
end variables

forward prototypes
public function integer revisa_nivel (long numcta)
public subroutine borrado_cuenta ()
public function integer revisa_prerrequisito (long mat, long cuenta)
public function integer revisa_cursada (long mat, long cta)
public function integer revisa_creditos (long cta, integer cred_act)
public function integer verifica_extension (long cta)
public subroutine borra_materia ()
public subroutine borra_gpo ()
public function integer revisa_curso_tema (long mat, long cta)
public function integer revisa_insc (long mat, long cta)
public function integer gpo_existe (long mat, string gpo)
public subroutine agrega_mat ()
public function integer revisa_ss (long mat, long cta)
public function integer gpo_lleno (long mat, string gpo)
public function integer revisa_horario (long mat, string gpo, long cta)
public subroutine actualiza_struct_horario (integer cvmat, string gpo, integer flag)
public function integer borra_mat_insc (long cta, long mat, string gpo)
public function integer obten_carr_plan (long cta, ref long cvcarrera, ref long cvplan)
public function integer revisa_labs (long cuenta)
public function long pert_plan_est (long mat, long carr, long plan)
public function integer revisa_area (long cvmat)
public function integer obten_ss (long cta)
public subroutine obten_cred_max (long carrera, long plan)
public subroutine actualiza_integ ()
public function integer revisa_gpo_bloqueado (integer mat, string gpo)
public function integer revisa_pago_ultima_hora (long cta)
public subroutine limpia_lineas_vacias ()
public function integer lectura_parametros ()
public subroutine revisa_disciplina (long cta)
public subroutine revisa_documentos (long cta)
public subroutine revisa_invasor_hora (long cta)
public subroutine revisa_4_inscritas (long cta)
public subroutine revisa_baja_promedio (long cta)
public subroutine revisa_3_reprobadas (long cta)
public subroutine revisa_insc_sem_ant (long cta)
public subroutine revisa_baja_finanzas (long cta)
public subroutine revisa_adeudo_biblioteca (long cta)
public function integer revisanip (long al_cuenta, string as_nip)
public function integer existe_materia (long cvmat, ref string mat, ref integer crd, ref integer hrst, integer hrsp)
public function integer actualiza_status (long al_cuenta)
public subroutine inscribe_mat_preinsc ()
public subroutine actualiza_status_materias (long al_cuenta)
public function integer gruposparalelos (integer ai_cve_mat, ref string as_gpo, integer ai_anio, integer ai_periodo)
public subroutine revisa_baja_laboratorio (long cta)
public function integer llenabanderas (ref long cue, ref integer bandera[23])
end prototypes

event inicia_proceso;//Carlos Armando Melgoza Piña 											Marzo 1997
//Ejecuta los procesos de validación de un alumno para permitir la inscripción
//Proceso que en epocas ancestrales se ejecutaba con un doble click
//Evento creado en mayo de 1998
//DkWf
int h,d
long cta

SetPointer(HourGlass!)
band_bloq	=	0
aceptado=0
ii_statusmat_preinsc = 0

	dw_materias.reset()
	dw_ext_h.reset()
	dw_ext_h.triggerevent(constructor!)
	//cred_integ = 0
		for d = 1 to 7
			for h = 1 to 15
				hora[h].dia[d] = 0
			next	
		next
	
	   cta = long(uo_nombre.em_cuenta.text)
		
if cta > 0 then
	if llenabanderas(cta,BanderasAlumno) = 0	then	/******Atencion***********/
		if obten_carr_plan(cta,I_CarreraAlumno,I_PlanAlumno) = 0 then	/******Atencion***********/
			obten_cred_max(I_CarreraAlumno,I_PlanAlumno)
			if revisa_nivel(cta) = 0 then//Función que revisa el nivel del alumno contra el permitido
				if obten_ss(cta) = 0 then/*******Atención***********//*Funcion que obtiene la cve de la materia de SS*/
					//Inicia revisión de bloqueos
					bloqueado_por	=	"El alumno con número de cuenta "+string(cta)+"-"+obten_digito(cta)+" se encuentra bloqueado por:~r"
					revisa_disciplina(cta)	//Función que revisa si el alumno está bloqueado por disciplina
					revisa_documentos(cta)	//Función que revisa si el alumno está bloqueado por deber documentos						
					revisa_invasor_hora(cta)	//Función que revisa si el alumno está bloqueado por invadir horario de inscripcion.						
					revisa_4_inscritas(cta)	//Función que revisa si el alumno está bloqueado por 4 veces inscrita una materia						
					revisa_baja_promedio(cta)	//Función que revisa si el alumno está bloqueado por promedio
					revisa_3_reprobadas(cta)	//Función que revisa si el alumno está bloqueado por 3 reprobadas
					revisa_insc_sem_ant(cta)	// Función que revisa si el 	alumno estuvo inscrito el semestre anterior
					revisa_baja_finanzas(cta)	//Función que revisa si el alumno está bloqueado por finanzas
					revisa_adeudo_biblioteca(cta)	//Función que revisa si el alumno está bloqueado por adeudos con biblioteca
					revisa_baja_laboratorio(cta)	//Función que revisa si el alumno está bloqueado por adeudos de laboratorio
					//Termina revisión de bloqueos
					if band_bloq	=	0	then
						dw_plan.retrieve(cta)
						if dw_materias.retrieve(cta) = 0 then
							dw_materias.insertrow(0)
							agrega_mat()
							dw_materias.setfocus()
						end if
						//Si el usuario es distinto de inscrip o inscrposg coloca dw_cursada dependiendo 
						//del nivel del alumno
						if gi_nivel_usuario > 10 then	 
							if nivel = 'P' then
								dw_cursada.dataobject = "dw_cursada_pos"
								dw_cursada.settransobject(gtr_sce)
							elseif nivel = 'L' then
								dw_cursada.dataobject = "dw_cursada"
								dw_cursada.settransobject(gtr_sce)
							end if
						end if
						dw_materias.event actualizahorario()
					else
						ii_statusmat_preinsc = 66 //Alumno Bloqueado
						actualiza_status_materias(cta)
						borrado_cuenta()								
					end if			
				else 
					actualiza_status_materias(cta)
					borrado_cuenta()//  Inicializa el numero de cuenta en 0	
				end if
			else
				actualiza_status_materias(cta)
				borrado_cuenta()// Inicializa el número de cuenta en 0	
			end if
		else
			actualiza_status_materias(cta)
			borrado_cuenta()// Inicializa el número de cuenta en 0	
		end if
	else
		actualiza_status_materias(cta)
		borrado_cuenta()// Inicializa el número de cuenta en 0			
	end if
else
	if dw_plan.retrieve(0) = 0 then
		dw_plan.insertrow(0)
	end if
end if


//Evento en el cual se procesa la preinscripcion 
//si el alumno es de posgrado no es necesario realizar los tramites
//si el alumno es de licenciatura y tipo_preinsc es 2 obligatoria necesita realizar los tramites
//si el alumno "   "    "                "  "                 "   1 normal no necesita realizar los tramites
//Mayo 1998 		CAMP(DkWf)
// Cambios Fantine Medina 29 Julio 1998
//long cta
int stat

limpia_lineas_vacias()
cta = long(uo_nombre.em_cuenta.text)
if cta <> 0 then
	if dw_mat_preinsc.retrieve(cta,g_per,g_anio) > 0 then
		inscribe_mat_preinsc()
		actualiza_status(cta)
	else
		return
	end if
end if

SetPointer(Arrow!)


end event

public function integer revisa_nivel (long numcta);//Carlos Armando Melgoza Piña									Marzo 1997
//Función que revisa que el alumno se inscriba en el periodo que le corresponda Licenciatura o Posgrado.
//Regresa 1 si esta bloqueado y 0 en caso contrario
//Modificado Noviembre 1997
integer niv,cont
cont = 0
niv = i_nivel
	
intento1:	
SELECT academicos.nivel  //Revisa el nivel del alumno
	 INTO :nivel  
	 FROM academicos  
WHERE academicos.cuenta = :numcta USING gtr_sce;
	
if gtr_sce.sqlcode <> 0 then
	commit USING gtr_sce;
	if cont < 5 then
		cont++
		goto intento1
	end if
	ii_statusmat_preinsc = 65 //Error de comunicación
	return 1			
end if

commit USING gtr_sce;
	
//Verifica si el alumno puede o no inscribirse dependiendo de su nivel	
if niv = 2 then
	return 0
elseif niv = 0 then
	if nivel = 'L' then
		return 0
	else
		ii_statusmat_preinsc = 67 //No pertenece a Licenciatura
		return 1
	end if
elseif niv = 1 then
	if nivel = 'P' then
		return 0
	else
		ii_statusmat_preinsc = 68 //No pertenece a Posgrado
		return 1
	end if
end if
	

end function

public subroutine borrado_cuenta ();//Carlos Armando Melgoza Piña							Marzo 1997
//  Inicializa nuevamente el numero de cuenta en 0
uo_nombre.em_cuenta.text=" "
uo_nombre.em_cuenta.triggerevent("activarbusq")

end subroutine

public function integer revisa_prerrequisito (long mat, long cuenta);//Carlos Armando Melgoza Piña 									Marzo 1997
//Función que revisa si el  alumno cumplió todos los prerrequisitos para cursar una materia
//Regresa un 0 si los prerrequisitos fueron cumplidos y 1 en caso contrario
long cvmat/*, cvcarrera, cvplan*/,respuesta
int cont, verifica,c,bandera=0,op3=0
char enlace,cumple='N'/*Variable que indica si se cumplieron los prerrequisitos*/
c= 0
		respuesta = dw_prerre.retrieve(mat,I_CarreraAlumno,I_PlanAlumno)
		
		if respuesta = 0 then  //Consulta los prerrequisitos de la materia 
			commit USING gtr_sce;/*Si la materia no tiene prerrequisitos continua el proceso*/
			return 0
		elseif respuesta > 0 then
			commit USING gtr_sce;/*Si la materia tiene prerrequisitos se revisa si se cumplen*/
			for cont = 1 to dw_prerre.rowcount() // Revisión de los prerrequisitos en la tabla historico
				cvmat	=	dw_prerre.object.cve_prerreq[cont]
				enlace	=	dw_prerre.object.enlace[cont]
	intento:	 
				if	nivel = 'L' then
					SELECT historico_re.cve_mat  
						INTO :cvmat  
					  FROM historico_re  
					WHERE ( historico_re.cuenta = :cuenta ) AND  
								  ( historico_re.cve_mat = :cvmat ) AND 
								  ( historico_re.cve_carrera	=	:I_CarreraAlumno ) AND
								  ( historico_re.cve_plan	=	:I_PlanAlumno ) AND
								  ( historico_re.calificacion IN ("AC","6","7","8","9","10", "MB","B","S","E","RE"))
								  USING gtr_sce;
				else
					SELECT historico_pos_re.cve_mat  
						INTO :cvmat  
					  FROM historico_pos_re
					WHERE ( historico_pos_re.cuenta = :cuenta ) AND  
								  ( historico_pos_re.cve_mat = :cvmat ) AND 
								  ( historico_pos_re.cve_carrera	=	:I_CarreraAlumno ) AND
								  ( historico_pos_re.cve_plan	=	:I_PlanAlumno ) AND
								  ( historico_pos_re.calificacion IN ("AC","6","7","8","9","10", "MB","B","S","E","RE"))
								  USING gtr_sce;
				end if
								  
				 revisa_rows()				  
				 
				  if gtr_sce.sqlcode = 100 then//Este if se ejecuta si el alumno no ha llevado esa materia
						commit USING gtr_sce;
						if cont > 1 then
							if (isnull(enlace) and dw_prerre.object.enlace[cont - 1]	=	'Y')	 then
								op3 = 1
							else
								op3 = 0
							end if
						else
							op3 = 0
						end if
						
						if (	(	enlace = 'Y'	) or (isnull(enlace) and cont	=	1) or op3 = 1	)	then	//Si el	alumno no 
																																		//	ha cursado la materia
																								// y es requerida se le niega la inscripción de la materia				
							ii_statusmat_preinsc = 74 //Faltan Prerrequisitos
							return 1	
						end if
				  elseif gtr_sce.sqlcode = 0 then//Si el alumno ya curso la materia
					if enlace = 'O' then
						cumple	=	'S'
						cont++
					else 
						bandera = 1
					end if
				  elseif gtr_sce.sqlcode < 0 then
					commit USING gtr_sce;
					if c < 5 then
						c++
						goto intento
					end if
					ii_statusmat_preinsc = 65 //Error de comunicación
					return 1		//			error bd						
				  end if
				  commit USING gtr_sce;
			next
		elseif respuesta < 0 then
				commit USING gtr_sce;
				ii_statusmat_preinsc = 65 //Error de comunicación
				return 1//Error en la comunicación con la base de datos .
		end if	
		if (	(	bandera	=	0 and cumple	=	'S'	) or bandera	=	1	) then
			return 0
		else
			ii_statusmat_preinsc = 74 //Faltan Prerrequisitos
			return 1
		end if
	return 0

end function

public function integer revisa_cursada (long mat, long cta);//Carlos Armando Melgoza Piña 													Marzo 1997	
//Función que revisa si el alumno ya curso la materia y la aprobo
//Regresa 0 si no la ha cursado y 1 en caso contrario

int ren
string cal
long revisa
revisa = dw_cursada.retrieve(cta,mat,I_CarreraAlumno,I_PlanAlumno)	//DW auxiliar en la revision de materias cursadas
commit USING gtr_sce;
if revisa = 0 then 
	return 0
elseif revisa > 0 then
	for ren = 1 to dw_cursada.rowcount()
		cal = dw_cursada.getitemstring(ren,"calificacion")
		if cal = "5" or cal = "BA" or cal = "NA" or cal = "05" or cal	=	"BJ" then
		else
			ii_statusmat_preinsc = 71 //Materia Cursada
			return 1
		end if		
	next	
	return 0
elseif revisa < 0 then
	ii_statusmat_preinsc = 65 //Error de comunicación
	return 1
end if


end function

public function integer revisa_creditos (long cta, integer cred_act);//Carlos Armando Melgoza Piña 													Marzo 1997	
//Función que revisa si el alumno no ha sobrepasado el limite maximo de creditos
//Regresa 0 si se permiten y 1 en caso contrario
int cont
long /*cvcarrera, cvplan,*/crd_max

cont = 0
crd_max = verifica_extension(cta) 

if  crd_max = 0 then
	if g_per = 1 then
		crd_max = 20
	else
		crd_max = I_cms//Variable que contiene el número maximo de creditos por plan y carrera	
	end if
end if		  
if crd_max >= cred_act then return 0

//if obten_carr_plan(cta,cvcarrera,cvplan) = 0 then//Función que consulta la carrera y el plan de un alumno
if ex_cred = 0 then //si no se permite exceso de creditos
	ii_statusmat_preinsc = 69 //Excede límite de créditos
	return 1
else
	return 0
end if			


end function

public function integer verifica_extension (long cta); //Carlos Armando Melgoza Piña								Marzo 1997	
 //Función que revisa si el alumno  tiene extension de creditos o no
 //Regresa el numero de creditos si hay extensión o 0 si no hay

return BanderasAlumno[b_ec]

end function

public subroutine borra_materia ();//Carlos Armando Melgoza Piña							Marzo 1997
//  Inicializa la clave de la materia en 0 
//dw_materias.setitem(dw_materias.getrow(),"mat_inscritas_cve_mat",0)
int  ren , col

ren = dw_materias.getrow()

cred_integ = crd_ant

for col = 1  to 4 // Inicializa las columnas cve , gpo, materia y creditos
	if col = 1 or col = 4 then
		dw_materias.setitem(dw_materias.getrow(),col,0)
	else  
		dw_materias.setitem(dw_materias.getrow(),col," ")	
	end if
next		
	
	
	
	
end subroutine

public subroutine borra_gpo ();//Carlos Armando Melgoza Piña							Marzo 1997
//  Inicializa la clave grupo en 0 
//dw_materias.setitem(dw_materias.getrow(),"mat_inscritas_cve_mat",0)
int  ren , col

ren = dw_materias.getrow()
dw_materias.setitem(dw_materias.getrow(),2," ")	

	
	
end subroutine

public function integer revisa_curso_tema (long mat, long cta);//Carlos Armando Melgoza Piña												Marzo 1997
// 1)Función que revisa si ya se curso el tema de una materia de integración
// 2)Función que detecta si el alumno ya inscribio una materia de un tema determinado
// 3)Revisa el número de creditos de integración que puede inscribir el alumno
// 4)Revisa que el alumno tenga la bandera de puede integracion
//Regresa un 0 si no 1 & 2 & 3 se cumple o un 1 si no
//Modificación Noviembre 1997 union de funciones
//Fantine Medina Carrillo

long area
int curso,crd


  SELECT area_mat.cve_area  
	    INTO :area  
   	 FROM area_mat  
    WHERE area_mat.cve_mat = :mat  USING gtr_sce; //Revisión del area de la materia a inscribir
	 
	revisa_rows()			//verifica que el error no se deba a exceso de renglones
	 
	 if gtr_sce.sqlcode = 0 then
		commit USING gtr_sce;
		if area < 2201 or area > 2205 then
			return 0
		elseif BanderasAlumno[b_pi] = 0 then //El alumno no puede cursar la materia
			ii_statusmat_preinsc = 75 //No puede cursar integración
			return 1
		else
			curso = BanderasAlumno[b_tf1]+BanderasAlumno[b_tf2]
//			if curso = 2  then	//CODIGO ELIMINADO A PETICION DE SERVICIOS ESCOLARES
								//AHORA SE PUEDE CURSAR CUALQUIERA DE LA 6 MATERIAS DE INTEGRACIÓN
								//13-05-1998
			choose case area
				
				case 2202
						curso = BanderasAlumno[b_t1]	
						 if curso  <> 0 then
							ii_statusmat_preinsc = 76 // Tema ya cursado I
							return 1
						end if	
				case 2203
							curso = BanderasAlumno[b_t2]
							 if curso <> 0 then 
								ii_statusmat_preinsc = 77 // Tema ya cursado II
								return 1
							end if	
				case 2204
							curso = BanderasAlumno[b_t3]
							 if curso <> 0 then
								ii_statusmat_preinsc = 78 // Tema ya cursado III
								return 1
							end if	
				case 2205
							curso = BanderasAlumno[b_t4]
							 if curso <> 0 then
								ii_statusmat_preinsc = 79 // Tema ya cursado IV
								return 1
							end if	
				case else
						return 0				
				end choose				 	
			  SELECT area_mat.cve_area  
	   			    INTO :area  
				 FROM area_mat,   
					        mat_inscritas  
				 WHERE ( mat_inscritas.cve_mat = area_mat.cve_mat ) and  
				            ( ( area_mat.cve_area = :area ) AND  
						     ( mat_inscritas.cuenta = :cta ) )  USING gtr_sce;
					if gtr_sce.sqlcode = 100 or area = 2201 then
							commit USING gtr_sce;
					elseif gtr_sce.sqlcode = 0  then
							commit USING gtr_sce;
							ii_statusmat_preinsc = 80 // Tema ya inscrito
							return 1
					else
							commit USING gtr_sce;
							ii_statusmat_preinsc = 65 //Error de comunicación
							return 1			//error de base de datos						
					end if			
					crd = BanderasAlumno[b_ci]
					if crd = 0 then
						crd = 16
					end if
						actualiza_integ()  //Actualización de cred_integ			
					if cred_integ > crd then
						ii_statusmat_preinsc = 81 // Excede limite de créditos de integración
						cred_integ = crd_ant
						return 1
					else
						return 0
					end if	
	end if	
	else
		if gtr_sce.sqlcode = 100 then
			commit USING gtr_sce;
			return 0
		else
			commit USING gtr_sce;
			ii_statusmat_preinsc = 65 //Error de comunicación
			return 1	//error en bd			
		end if
	 end if

end function

public function integer revisa_insc (long mat, long cta);//Carlos Armando Melgoza Piña									Marzo 1997
//Función que revisa si el alumno ya tiene inscrita la materia que quiere agregar
//Regresa 0 si no la ha inscrito y 1 en caso contrario
int cont
cont = 0
intento: 
   SELECT mat_inscritas.cve_mat  //revisión si la materia ya esta inscrita
 	     INTO :mat  
	   FROM mat_inscritas  
	WHERE ( mat_inscritas.cuenta = :cta ) AND  
			     ( mat_inscritas.cve_mat = :mat ) USING gtr_sce;
				  
	  if gtr_sce.sqlcode = 100 then
		commit USING gtr_sce;
		return 0
	elseif gtr_sce.sqlcode = 0 then
		commit USING gtr_sce;
		ii_statusmat_preinsc = 72 // Materia ya inscrita
		return 1
	else
		commit USING gtr_sce;
		if cont < 5 then
			cont ++
			goto intento
		end if
		ii_statusmat_preinsc = 65 //Error de comunicación
		return 1					
	  end if
				  

end function

public function integer gpo_existe (long mat, string gpo);//Carlos Armando Melgoza Piña								Marzo 1997
//Función que revisa si el grupo elegido existe
//Regresa 0 si existe o 1 en caso contrario


 int cond

 
 SELECT 	grupos.gpo,
 			grupos.cupo, grupos.tipo, grupos.inscritos, grupos.cve_asimilada, grupos.gpo_asimilado, 
			 grupos.cond_gpo
    INTO :gpo, :i_cupo, :i_tipo, :i_insc, :i_mat_a, :i_gpo_a, :cond 
    FROM grupos  
   WHERE ( grupos.cve_mat = :mat ) AND  
         ( grupos.gpo = :gpo ) AND  
         ( grupos.periodo = :G_per ) AND  
         ( grupos.anio = :G_anio ) USING gtr_sce   ;
			
			revisa_rows()
			
	if gtr_sce.sqlcode = 0 then
		commit USING gtr_sce;
		if cond = 0 then 
			ii_statusmat_preinsc = 86  //Grupo cancelado
			return 1
		else
			return 0
		end if
	elseif gtr_sce.sqlcode = 100 then
			commit USING gtr_sce;
			ii_statusmat_preinsc = 83 //Grupo inexistente
			return 1
	else
		commit USING gtr_sce;
		ii_statusmat_preinsc = 65 //Error de comunicación
		return 1//Error en la comunicación  con BD
	end if



end function

public subroutine agrega_mat ();//Carlos Armando Melgoza Piña 										Marzo 1997
//Función que inicializa los valores de número de cuenta, periodo, año y tipo de inscripción
int /*periodo, */ret,cont
//long año
char tipo

cont = 0
	if tipo_insc = 0 then
		tipo  = "I"
	elseif tipo_insc = 1 then
			tipo = "A" 
	end if
	dw_materias.setitem(dw_materias.rowcount(),"mat_inscritas_cuenta",long(uo_nombre.em_cuenta.text))//Agrega num. cta
	dw_materias.setitem(dw_materias.rowcount(),"mat_inscritas_inscripcion",tipo)
	dw_materias.setitem(dw_materias.rowcount(),"mat_inscritas_periodo",G_per)
	dw_materias.setitem(dw_materias.rowcount(),"mat_inscritas_anio",G_anio)
	
	

end subroutine

public function integer revisa_ss (long mat, long cta);//Carlos Armando Melgoza Piña									Marzo 1997	
//Función que revisa si la materia es SS y si es así verifica que el alumno pueda cursarla
//Regresa un 0 si no es servicio social o si es y puede cursar 1 en caso de que no pueda cursar
//Modificado 14-IV-1998

long /*cvcarrera, cvplan,cvss,*/area,autori
int cont
cont = 0
if mat = I_cvss then //si la materia es servicio social
	autori = BanderasAlumno[b_cfss]
	if autori = 0 then
		ii_statusmat_preinsc = 82 //No puede cursar el servicio social
		return 1
	else
		return 0
	end if				
else	//Si la materia no es ss
	return 0
end if

end function

public function integer gpo_lleno (long mat, string gpo);//  Carlos Armando Melgoza Piña  									Marzo 1997
//	Función que verifica si un grupo esta lleno o no 
// Regresa 0 si hay cupo y 1 en caso contrario
 long /*año,*/cup,insc
 int /*per,permite*/cont

if i_insc < i_cupo then return 0
 
 cont = 0
 if exe_cupo   = 0 then 
	ii_statusmat_preinsc = 84 // Grupo Lleno
	return 1//No se permite exceso de cupo
else
	return 0
end if
 
			

end function

public function integer revisa_horario (long mat, string gpo, long cta);//  Carlos Armando Melgoza Piña  									Marzo 1997
//  Función que revisa si no existe ninguna materia inscrita en ese horario 
//  Regresa 0 si no se enciman materias y 1 en caso contrario

int d,h, cont,c,verif
//long año
//int per
//periodo_actual_insc(per,año)


c = 0
intento1:
	verif = dw_horario_mat.retrieve(mat,gpo,G_per,g_anio)
	if verif >= 0 then
		for cont = 1 to dw_horario_mat.rowcount()
			d  = dw_horario_mat.getitemnumber(cont,"cve_dia")
			d++
			for h = dw_horario_mat.getitemnumber(cont,"hora_inicio") to  dw_horario_mat.getitemnumber(cont,"hora_final") - 1
				if hora[h - 6].dia[d]  = 1 then
					if mat_enci  = 1 then // Se permite encimar
						return 0
					else
						ii_statusmat_preinsc = 87 //El horario se encima
						return 1
					end if
				end if
			next
		next
		return 0
	else
	 	if cont < 5 then
			cont++
			goto intento1
		end if
		ii_statusmat_preinsc = 65 //Error de comunicación
		return 1
	end if

end function

public subroutine actualiza_struct_horario (integer cvmat, string gpo, integer flag);//Carlos Armando Melgoza Piña 									Abril 1997
//Función que actualiza la estructura de horario.
//Escribe 1 en las horas que va ocupando el alumno y 0 en las que libera
//En el parametro flag se indica si se ocupa o libera el horario
int d,h,ren, mati
string mat
//long año
//int per
//periodo_actual_insc(per,año)

if flag = 1 then
	if dw_horario_mat.rowcount()	> 0 then //Actualización de la estructura del horario 1 si esta ocupado o 0 si las libera
		for ren  = 1 to dw_horario_mat.rowcount()
			d = dw_horario_mat.getitemnumber(ren,"cve_dia")
			d++
			for h = dw_horario_mat.getitemnumber(ren,"hora_inicio") to dw_horario_mat.getitemnumber(ren,"hora_final") -1
				hora[h - 6].dia[d] = flag //d va de 1 a 7 h va de 1 - 15
				hora[h - 6].salon[d] = dw_horario_mat.getitemstring(ren,"horario_cve_salon") // Almacenaje de salon
				dw_ext_h.setitem(h -6,d+1,string(cvmat))
			next
		next
	end if	
else
	for ren  = 1 to 6
		for h = 1 to 15
			mat = dw_ext_h.getitemstring(h,ren+1)
			mati = Integer(mat)
			if mati = cvmat then
				dw_ext_h.setitem(h ,ren+1,"")
				hora[h].dia[ren] = flag
				hora[h].salon[ren] = ""
			end if
		next
	next
end if
end subroutine

public function integer borra_mat_insc (long cta, long mat, string gpo);//Carlos Armando Melgoza Piña								Abril 1997
//Función que borra una materia  de materias_inscritas
//Regresa 0 si se efectua la actualización con exito o 1 en caso contrario
  
  DELETE FROM mat_inscritas  
  WHERE ( mat_inscritas.cuenta = :cta ) AND  
				 ( mat_inscritas.cve_mat = :mat ) USING gtr_sce;
						  
if gtr_sce.sqlcode = 0 then
	commit USING gtr_sce;
	return 0
else
	rollback USING gtr_sce;
	return 1
end if


end function

public function integer obten_carr_plan (long cta, ref long cvcarrera, ref long cvplan);//Carlos Armando Melgoza Piña								Marzo 1997
//Función que consulta y regresa los valores de la clave del plan y la carrera
//Regresa 0 si el proceso se realiza adecuadamente
  SELECT academicos.cve_carrera,   
	      academicos.cve_plan  
	INTO	:cvcarrera,
			:cvplan
	FROM	academicos 
	WHERE	( academicos.cuenta = :cta ) USING gtr_sce ;
	 
	 if gtr_sce.sqlcode <> 0 then
		commit USING gtr_sce;
		ii_statusmat_preinsc = 65 //Error de comunicación
		return 1//Error en la comunicación con BD
	else
		return 0
	end if

end function

public function integer revisa_labs (long cuenta);//Fantine Medina Carrillo	Nov 1998
//Función en el cual revisa si alguna de las materias inscritas tiene un laboratorio que no se haya inscrito
//Regresa 0 si la materia esta inscrita o no existe tal  y 1 en caso contrario
int  totmi, tottl,i, teoria, lab
int li_cve_mati[20]
string mensaje, ls_mat
string ls_gpo_teoria, ls_gpo_lab, ls_condicion_mat_teoria, ls_condicion_mat_lab
string ls_condicion_gpo_teoria, ls_condicion_gpo_lab
int li_revisa_teoria_lab, li_row
boolean lb_hay_teoria_y_lab= false

if cuenta > 0 then
	li_revisa_teoria_lab = i_revisa_teoria_lab
	if li_revisa_teoria_lab = 1 then
		for i=1 to dw_materias.rowcount()
			li_cve_mati[i]=dw_materias.getitemnumber(i,"mat_inscritas_cve_mat",Primary!,False)
			//if isnull(li_cve_mati[i]) then li_cve_mati[i] = 0
		next
		tottl = dw_teoria_lab.retrieve(i_carreraalumno,i_planalumno,li_cve_mati)
		if tottl > 0 then //Hay materias que revisar
			totmi = dw_materias.RowCount()
			for i = 1 to tottl
				teoria = dw_teoria_lab.GetItemnumber(i,"cve_teoria")
				lab =  dw_teoria_lab.GetItemnumber(i,"cve_lab")
				ls_gpo_teoria = dw_teoria_lab.GetItemString(i,"gpo_teoria")
				ls_gpo_lab = dw_teoria_lab.GetItemString(i,"gpo_lab")
				
				ls_condicion_mat_teoria = 'mat_inscritas_cve_mat = '+string(teoria)
				ls_condicion_gpo_teoria = 'mat_inscritas_gpo = "'+ls_gpo_teoria+'"'
				
				ls_condicion_mat_lab = 'mat_inscritas_cve_mat = '+string(lab)
				ls_condicion_gpo_lab = 'mat_inscritas_gpo = "'+ls_gpo_lab+'"'
				//Determinar si ya se ha inscrito la teoria y el laboratorio correspondiente
				lb_hay_teoria_y_lab= true
				//la teoria requiere un grupo específico y el laboratorio tambien requiere un grupo específico
				if ls_gpo_teoria<>"*" and ls_gpo_lab<>"*" then
					if (dw_materias.Find(ls_condicion_mat_teoria+" and "+ls_condicion_gpo_teoria,1,totmi) = 0 or &
						 dw_materias.Find(ls_condicion_mat_lab+" and "+ls_condicion_gpo_lab,1,totmi) = 0 )then
						lb_hay_teoria_y_lab= false
					end if					
				//la teoria requiere un grupo específico y el laboratorio NO requiere un grupo específico
				elseif ls_gpo_teoria<>"*" and ls_gpo_lab="*" then
					if (dw_materias.Find(ls_condicion_mat_teoria+" and "+ls_condicion_gpo_teoria,1,totmi) = 0 or &
						 dw_materias.Find(ls_condicion_mat_lab,1,totmi) = 0 )then
						lb_hay_teoria_y_lab= false
					end if										
				//la teoria NO requiere un grupo específico y el laboratorio SI requiere un grupo específico
				elseif ls_gpo_teoria="*" and ls_gpo_lab<>"*" then
					if (dw_materias.Find(ls_condicion_mat_teoria,1,totmi) = 0 or &
						 dw_materias.Find(ls_condicion_mat_lab+" and "+ls_condicion_gpo_lab,1,totmi) = 0 )then
						lb_hay_teoria_y_lab= false
					end if										
				//la teoria NO requiere un grupo específico y el laboratorio NO requiere un grupo específico
				elseif ls_gpo_teoria="*" and ls_gpo_lab="*" then
					if (dw_materias.Find(ls_condicion_mat_teoria,1,totmi) = 0 or &
						 dw_materias.Find(ls_condicion_mat_lab,1,totmi) = 0 )then
						lb_hay_teoria_y_lab= false
					end if										
				end if
				
				//si no se encontraron la teoria y el laboratorio correspondientes
				//elimina la teoria o el laboratorio de mat_inscritas
				//actualiza el estatus en materias preinscritas para indicar que no se inscribio
				//la teoria-laboratorio correctamente
				
				if NOT lb_hay_teoria_y_lab then
					commit USING gtr_sce;					
				
					li_row = dw_materias.Find("mat_inscritas_cve_mat = "+string(teoria),1,totmi)
					ls_mat = string(teoria)
					if li_row = 0 then
						li_row = dw_materias.Find("mat_inscritas_cve_mat = "+string(lab),1,totmi)
						ls_mat  = string(lab)
					end if
					dw_materias.SetRow(li_row)
					dw_materias.event borramat()
					ii_statusmat_preinsc = 88 //Falta inscribir una materia Teoria-Lab
					li_row = dw_mat_preinsc.Find("cve_mat = "+ls_mat,1,dw_mat_preinsc.RowCount())
					if li_row > 0 and li_row <= dw_mat_preinsc.RowCount()then
						dw_mat_preinsc.SetItem(li_row,"status",ii_statusmat_preinsc)
						dw_mat_preinsc.Update()
						commit USING gtr_sce;
					end if
					return 1
				end if
			next
			return 0
		elseif tottl < 0 then//Error
			mensaje = gtr_sce.sqlerrtext
			commit USING gtr_sce;
			ii_statusmat_preinsc = 65 //Error de comunicación
			return 1
		else	//No hay materias a revisar
			commit USING gtr_sce;
			return 0
		end if
	else
		return 0
	end if
else //No hay alumno a revisar
	return 0 
end if

end function

public function long pert_plan_est (long mat, long carr, long plan);//Revisa plan
//Carlos Armando Melgoza Piña
//Mayo 97
//Regresa 1 si pertenece o 0 en caso contrario
int mat2
if usuario	=	"inscrposg" or nivel = 'P' then
	 SELECT mat_prerreq_pos.cve_mat  
		 INTO :mat2  
		 FROM mat_prerreq_pos  
		WHERE ( mat_prerreq_pos.cve_mat = :mat ) AND  
				( mat_prerreq_pos.cve_carrera = :carr  ) AND  
				( mat_prerreq_pos.cve_plan = :plan  )  USING gtr_sce;			
else
	 SELECT mat_prerrequisito.cve_mat  
		 INTO :mat2  
		 FROM mat_prerrequisito  
		WHERE ( mat_prerrequisito.cve_mat = :mat ) AND  
				( mat_prerrequisito.cve_carrera = :carr  ) AND  
				( mat_prerrequisito.cve_plan = :plan  )  USING gtr_sce;		
end if
			revisa_rows()
			
			if gtr_sce.sqlcode = 0 then 
				commit USING gtr_sce;
				return 0
			elseif gtr_sce.sqlcode =100 then
				commit USING gtr_sce;
				ii_statusmat_preinsc = 73 //La materia no pertenece al plan de estudios
				return 1
			else 
				commit USING gtr_sce;
				ii_statusmat_preinsc = 65 //Error de comunicación
				return 1 
			end if
		

end function

public function integer revisa_area (long cvmat);//Carlos Armando Melgoza Piña									Julio 1997
//Funcion que verifica si una materia es de integración o no, por medio del area a la que pertenece
//Regresa 1 si la materia es de integración y 0 en caso contrario

long area
int cont
cont = 0
intento:
  SELECT area_mat.cve_area  
  	    INTO :area  
	 FROM area_mat  
   WHERE area_mat.cve_mat = :cvmat USING gtr_sce;//Revisa el area de la materia a inscribir
	
	revisa_rows()		//verifica que el error no se deba a exceso de renglones
	
	if gtr_sce.sqlcode = 0 then
		commit USING gtr_sce;
		choose case area		//Si la materia es de integración 
			case 2201 to 2205
				cont = 0				
				return 1
			case else
				return 0
		end choose
	elseif gtr_sce.sqlcode = 100 then
		commit USING gtr_sce;
		return 0
	else
		commit USING gtr_sce;
		if cont < 5 then
			cont++
			goto intento
		end if
		ii_statusmat_preinsc = 65 //Error de comunicación
		return 0			
	 end if
end function

public function integer obten_ss (long cta);/*Obtiene la cvmat de servicio social para la revisión posterior del SS
  Fantine Medina Carrillo
  Carlos Armando Melgoza Piña
  Noviembre 1997
*/

long cvss,cont

if usuario	=	"inscrposg" or nivel = "P" then
	return 0
end if
intento: SELECT plan_estudios.cve_area_servicio_social  
	   	   INTO :cvss  
		FROM plan_estudios  
	  WHERE ( plan_estudios.cve_carrera = :I_CarreraAlumno ) AND  
	  			  ( plan_estudios.cve_plan = :I_PlanAlumno )  USING gtr_sce;
					 
				 revisa_rows()//verificacion de error
				 
	 if gtr_sce.sqlcode = 0 then
			commit USING gtr_sce;			
			cont = 0
	intento1:		
			SELECT area_mat.cve_mat  
		   		 INTO :I_cvss  
			    FROM area_mat  
		   WHERE area_mat.cve_area = :cvss USING gtr_sce;
		
			revisa_rows() //verificacion de error
		
			if gtr_sce.sqlcode = 0 then
				commit USING gtr_sce;
				return 0 
			else
				commit USING gtr_sce;
				if cont < 5 then
					cont ++
					goto intento1
				end if
				ii_statusmat_preinsc = 65 //Error de comunicación
				return 1		//			error bd						
			end if	
	 else
		commit USING gtr_sce;
		if cont < 5 then
			cont ++
			goto intento
		end if
		ii_statusmat_preinsc = 65 //Error de comunicación
		return 1		//			error bd		
	 end if 
return 0
end function

public subroutine obten_cred_max (long carrera, long plan);//Carlos Armando Melgoza Piña 								Abril 1997
//Revisa el numero maximo de creditos por semestre permitidos para un alumno



  SELECT plan_estudios.cred_max_sem  
    INTO :I_cms
    FROM plan_estudios  
   WHERE ( plan_estudios.cve_carrera = :carrera ) AND  
         ( plan_estudios.cve_plan = :plan ) USING gtr_sce;
			
if gtr_sce.sqlcode = 0 then
	commit USING gtr_sce;
else
	commit USING gtr_sce;
 	I_cms = 60
end if


end subroutine

public subroutine actualiza_integ ();//Carlos Armando Melgoza Piña													Marzo 1997
//Función que actualiza la cantidad de creditos de integración inscritos
//Modificada Noviembre 1997
//Fantine Medina Carrillo


int cred
cred  = dw_materias.getitemnumber(dw_materias.getrow(),"materias_creditos")					 	 
cred_integ = cred_integ + cred //incremento de materias de integracion					

end subroutine

public function integer revisa_gpo_bloqueado (integer mat, string gpo);/************************************************************/
/*		Función que revisa si el grupo al que se quiere 		*/
/*		inscribir el alumno esta bloqueado para su carrera 	*/
/*		Regresa 0 si el grupo se encuentra libre					*/
/*		Regresa 1 si el grupo se encuantra bloqueado 			*/
/*		Fantine Medina Carrillo								 			*/
/************************************************************/

long encontro
long total 
int dcar, dpla
string dgpo
boolean bgpo, bcar

if i_revisa_grupos_bloqueados = 1 then
	total = dw_reinsc_mat.RowCount( )
	encontro = dw_reinsc_mat.Find("rm_cve_mat="+string(mat),1,total)
	if encontro < 0 then return -2
	if encontro = 0 then 			//No la encontro
		return 0	
	else									//Si la encontro
		do while encontro > 0
			dgpo = dw_reinsc_mat.GetItemString(encontro,2)
			dcar = dw_reinsc_mat.GetItemNumber(encontro,3)
			dpla = dw_reinsc_mat.GetItemNumber(encontro,4)
			bgpo = false
			bcar = false
			if dgpo = gpo then bgpo = true
			if dcar = i_carreraalumno and dpla = i_planalumno then bcar = true
			if bgpo and bcar then			// Es su salon
				return 0
			end if
			if (bgpo and not(bcar)) or (not(bgpo) and bcar)then
				if encontro < total then
					encontro = dw_reinsc_mat.Find("rm_cve_mat="+string(mat)+" and rm_cve_gpo='"+gpo &
					+"' and rm_cve_carrera="+string(i_carreraalumno)&
					+" and rm_cve_plan="+string(i_planalumno),encontro+1,total)
				else
					ii_statusmat_preinsc = 85 //Grupo bloqueado
					return 1
				end if
				if encontro < 0 then return -2
				if encontro > 0 then
					return 0
				else
					ii_statusmat_preinsc = 85 //Grupo bloqueado
					return 1
				end if
			end if
			if encontro < total then
				encontro = dw_reinsc_mat.Find("rm_cve_mat="+string(mat),encontro+1,total)
			else
				encontro = 0
			end if
		loop
	return 0
	end if
else
	return 0
end if
end function

public function integer revisa_pago_ultima_hora (long cta);/*
 *		Nombre	revisa_pago_ultima_hora
 *		Recibe	cta
 *		Regresa	0	si el alumno con cuenta cta tiene sus pagos en orden
 *					1	si el alumnos con cuenta cta debe algo
 *					-1	error de comunicacion
 *					FMC03012000
 */

int li_ret
transaction ltr_scob, ltr_sfeb
long ll_cuenta
long ll_tot,ll_i
if conecta_bd(ltr_scob,gs_scob,gs_usuario,gs_password) = 0 then
	return -1
end if

if conecta_bd(ltr_sfeb,gs_sfeb,gs_usuario,gs_password) = 0 then
	return -1
end if

ll_cuenta = cta
	if ( (tiene_adeudos(ll_cuenta,ltr_scob) = 0) AND &
		( (pago_inscripcion(ll_cuenta, gi_anio ,gi_periodo, ltr_scob) = 1) OR (tiene_beca(ll_cuenta,gi_anio,gi_periodo, ltr_sfeb) = 100) )) then
			li_ret = 0 //dw_band.setitem(ll_i,"adeuda_finanzas",0)
	else
			li_ret = 1 //dw_band.setitem(ll_i,"adeuda_finanzas",1)
	end if
desconecta_bd(ltr_scob)
desconecta_bd(ltr_sfeb)
Destroy ltr_scob
Destroy ltr_sfeb
return li_ret








//Funcion que consulta en la db de Cobranzas si el alumno debe algo en el momento actual
//Si debe revisa si tiene beca o financiamiento
//Regresa 0 si no tiene adeudos y 1 en Caso contrario
//CAMP Dec 1997
//Modificado Mayo 1998
//Modificado Abril 1999 FMC
//datetime fecha_gen 
//int year,aux,intent=0
//int porcent_tot=0
//string period
//
//
//if g_per = 0 then
//	period = 'P'
//elseif g_per = 1 then
//	period = 'V'
//elseif g_per = 2 then
//	period = 'O'
//end if
//aux = integer(mid(string(g_anio),1,2))*100
//year = mod(g_anio,aux)
//cobra = Create transaction
//DO UNTIL intent = 11		
//		intent++
//		cobra.DBMS       = ProfileString ("sparl.ini", "scob", "dbms",       "")
//		cobra.database   = ProfileString ("sparl.ini", "scob", "database",   "")
//		cobra.logid      = gtr_sce.logid      
//		cobra.logpass    = gtr_sce.logpass    
//		cobra.servername = ProfileString ("sparl.ini", "scob", "servername", "")
//		cobra.dbparm     = ProfileString ("sparl.ini", "scob", "dbparm",     "")		
//		
//		connect using cobra;
//		
//		if cobra.sqlcode <> 0 then
//			if intent = 10 then
//				DESTROY cobra
//				return 1	
//			end if
//		else
//			EXIT
//		end if
//LOOP
//
///**/Transaction ltr_sfeb
///**/ltr_sfeb = Create transaction
///**/ltr_sfeb.DBMS = ProfileString ("sparl.ini", "sfeb", "dbms","")
///**/ltr_sfeb.database = ProfileString ("sparl.ini", "sfeb", "database","")
///**/ltr_sfeb.servername = ProfileString ("sparl.ini", "sfeb", "servername","")
///**/ltr_sfeb.dbparm = ProfileString ("sparl.ini", "sfeb", "dbparm", "")		
///**/ltr_sfeb.logid = gtr_sce.logid 
///**/ltr_sfeb.logpass = gtr_sce.logpass 
///**/int li_ret
//
//if revisa_adeudos(cta)	= 0 then//si no debe revisamos pago de inscripción
//	if revisa_pago_inscripcion(cta,period,year)=0 then//Si no pago se revisa el porcentaje de beca y financiamiento
//		/**/CONNECT using ltr_sfeb;
//		/**/if ltr_sfeb.sqlcode <> 0 then
//		/**/		li_ret = 1
//		/**/else
//		/**/		porcent_tot = revisa_porcentaje_apoyo(cta,g_per,g_anio,ltr_sfeb)
//		/**/		if porcent_tot = 100 then//OK Esta cubierto su pago
//		/**/			li_ret = 0
//		/**/		elseif porcent_tot = -1 then
//		/**/			li_ret = 1
//		/**/		else// Esta Bloqueado
//		/**/			li_ret = 1
//		/**/		end if	
//		/**/		DISCONNECT using ltr_sfeb;
//		/**/end if
//	else//Si pago inscripción puede inscribirse
//		li_ret = 0
//	end if
//else//Si debe esta bloqueado
//		li_ret = 1
//end if
//
//DISCONNECT using cobra;
//DESTROY cobra;
//DESTROY ltr_sfeb;
//return li_ret
end function

public subroutine limpia_lineas_vacias ();//Funcion que revisa que no haya lineas en blanco en materias
long rowtot,cont

rowtot = dw_materias.rowcount()

for cont = 1 to rowtot
	if isnull(dw_materias.getitemnumber(cont,"mat_inscritas_cve_mat")) or isnull(dw_materias.getitemstring(cont,"mat_inscritas_gpo")) or dw_materias.getitemstring(cont,"mat_inscritas_gpo") = " " then
		dw_materias.deleterow(cont)
		cont --
		rowtot --
	end if
next

end subroutine

public function integer lectura_parametros ();/*********************************************/
/*Modificado 2 Julio 1998	FMC					*/
/*********************************************/
//  SELECT activacion.exceso_creditos,   
//         activacion.tipo_inscripcion,   
//         activacion.exceso_cupo,   
//         activacion.materias_encimadas  
//    INTO :ex_cred,   
//         :tipo_insc,   
//         :exe_cupo,   
//         :mat_enci  
//    FROM activacion   USING gtr_sce;

if gi_nivel_usuario < 10 then
	SELECT	tipo_inscripcion,
			materias_encimadas,
			bajas_periodo_distinto,
			exceso_creditos,
			exceso_cupo,
			imprime_comprobantes,
			mensaje,
			periodo,
			anio,
			preinsc,
			pregunta_nip,
			revisa_teoria_lab,
			revisa_grupos_bloqueados
	INTO		:tipo_insc,
			:mat_enci,
			:i_baj_per_dis,
			:ex_cred,
			:exe_cupo,
			:i_imp_com,
			:i_men,
			:g_per,
			:g_anio,
			:i_preinsc,
			:i_pregunta_nip,
			:i_revisa_teoria_lab,
			:i_revisa_grupos_bloqueados
	FROM		activacion USING gtr_sce;
else
	SELECT	tipo_inscripcion,
			nivel,
			materias_encimadas,
			bajas_periodo_distinto,
			exceso_creditos,
			exceso_cupo,
			imprime_comprobantes,
			mensaje,
			periodo,
			anio,
			preinsc,
			pregunta_nip,
			revisa_teoria_lab,
			revisa_grupos_bloqueados
	INTO		:tipo_insc,
			:i_nivel,
			:mat_enci,
			:i_baj_per_dis,
			:ex_cred,
			:exe_cupo,
			:i_imp_com,
			:i_men,
			:g_per,
			:g_anio,
			:i_preinsc,
			:i_pregunta_nip,
			:i_revisa_teoria_lab,
			:i_revisa_grupos_bloqueados
	FROM		activacion_su USING gtr_sce;
end if

if gtr_sce.sqlcode = 0 then
	if gi_nivel_usuario = 2 then
		SELECT mensaje 
		INTO :i_men
		FROM activacion_su USING gtr_sce;
		if gtr_sce.sqlcode <> 0 then
			i_men = ""
			messagebox("E R R O R  al cargar PARAMETROS","Los parametros NO se cargaron adecuadamente.~rSe USARAN valores PREDETERMINADOS.~rConsulte al Administrador del Sistema",StopSign!)	
			return 1
		end if
	end if
else
	ex_cred	=	0
	tipo_insc	=	0
	exe_cupo	=	0
	mat_enci	=	0
	i_baj_per_dis = 0
	i_imp_com = 0
	i_men = "No válido"
	g_per=0
	g_anio=0
	i_preinsc = 0
	i_pregunta_nip = 1
	i_revisa_teoria_lab = 1
	i_revisa_grupos_bloqueados = 1
	messagebox("E R R O R  al cargar PARAMETROS","Los parametros NO se cargaron adecuadamente.~rSe USARAN valores PREDETERMINADOS.~rConsulte al Administrador del Sistema",StopSign!)	
	return 1
end if
return 0
end function

public subroutine revisa_disciplina (long cta);//Carlos Armando Melgoza Piña 													Marzo 1997	
//Función que revisa la situación del alumno por disciplina.
//Modifica las variables bloqueado_por(string) y band_bloq(int) si el alumno esta bloqueado
//Modificado Abril 1998
int baja
baja = BanderasAlumno[b_bdi]
	
//	Revisa la situación del alumno contra la bandera	
	if baja = 0 then	
	else 
		band_bloq = 1
		bloqueado_por	= bloqueado_por+"~t+Disciplina ~r"
	end if
	

end subroutine

public subroutine revisa_documentos (long cta);//Carlos Armando Melgoza Piña 													Marzo 1997	
//Función que revisa la situación del alumno por adeudo de documentos.
//Modifica las variables bloqueado_por(string) y band_bloq(int) si el alumno esta bloqueado
//Modificado Abril 1998
int baja
baja = BanderasAlumno[b_bdo]

//	Revisa la situación del alumno contra la bandera	
	if baja = 1 then
		band_bloq = 1
		bloqueado_por	= bloqueado_por+"~t+Adeudo de documentos ~r"
	end if
	


end subroutine

public subroutine revisa_invasor_hora (long cta);//Carlos Armando Melgoza Piña 													Marzo 1997	
//Función que revisa si el alumno es invasor de horario de inscripción.
//Modifica las variables bloqueado_por(string) y band_bloq(int) si el alumno esta bloqueado
//Modificado Abril 1998

int baja
baja = BanderasAlumno[b_ih]

if baja <> 0 then
	band_bloq = 1
	bloqueado_por	= bloqueado_por+"~t+Invadir hora de inscripción ~r"
end if
	

end subroutine

public subroutine revisa_4_inscritas (long cta);//Carlos Armando Melgoza Piña 													Marzo 1997	
//Función que revisa la situación del alumno por 4 veces inscrita una materia.
//Modifica las variables bloqueado_por(string) y band_bloq(int) si el alumno esta bloqueado
//Modificado Abril 1998

int baja
baja = BanderasAlumno[b_b4i]
//	Revisa la situación del alumno contra la bandera	
	if baja <> 0 then
		band_bloq = 1
		bloqueado_por	= bloqueado_por+"~t+Tener 4 veces inscrita una materia ~r"
	end if
	

end subroutine

public subroutine revisa_baja_promedio (long cta);//Carlos Armando Melgoza Piña 													Marzo 1997	
//Función que revisa la situación del alumno por promedio.
//Modifica las variables bloqueado_por(string) y band_bloq(int) si el alumno esta bloqueado
//Modificado Abril 1998

integer flag_prom
flag_prom = BanderasAlumno[b_cfp]

//Verifica si el alumno puede o no inscribirse	
	
if flag_prom = 2 then
	band_bloq = 1
	bloqueado_por	= bloqueado_por+"~t+Baja por promedio ~r"
end if
	
end subroutine

public subroutine revisa_3_reprobadas (long cta);//Carlos Armando Melgoza Piña 													Marzo 1997	
//Función que revisa la situación del alumno por 3 materias reprobadas.
//Modifica las variables bloqueado_por(string) y band_bloq(int) si el alumno esta bloqueado
//Modificado Abril 1998

int baja
baja = BanderasAlumno[b_b3r]

//	Revisa la situación del alumno contra la bandera	
	if baja <> 0 then
		band_bloq = 1
		bloqueado_por	= bloqueado_por+"~t+Tener 3 materias reprobadas ~r"
	end if
	


end subroutine

public subroutine revisa_insc_sem_ant (long cta);//Carlos Armando Melgoza Piña 													Marzo 1997	
//Función que revisa si el alumno estuvo inscrito el semestre anterior.
//Modifica las variables bloqueado_por(string) y band_bloq(int) si el alumno esta bloqueado
//Modificado Abril 1998

int baja
baja = BanderasAlumno[b_isa]
//	Revisa la situación del alumno contra la bandera	
	if baja <> 1 then
		band_bloq = 1
		bloqueado_por	= bloqueado_por+"~t+No se inscribió el semestre anterior ~r"
	end if
	

end subroutine

public subroutine revisa_baja_finanzas (long cta);//Carlos Armando Melgoza Piña 													Marzo 1997	
//Función que revisa la situación del alumno con finanzas.
//Modifica las variables bloqueado_por(string) y band_bloq(int) si el alumno esta bloqueado
//Modificado Abril 1998
int baja
baja = BanderasAlumno[b_af]
	
//	Revisa la situación del alumno contra la bandera
	
	
	if baja <> 0 then
		if revisa_pago_ultima_hora(cta) = 0 then //Revisa la situación con finanzas al momento de la inscripción 
			return 
		else
			band_bloq = 1
			bloqueado_por	= bloqueado_por+"~t+Baja por finanzas ~r"
		end if
	end if
end subroutine

public subroutine revisa_adeudo_biblioteca (long cta);//Carlos Armando Melgoza Piña 													Marzo 1997	
//Función que revisa la situación del alumno con biblioteca.
//Modifica las variables bloqueado_por(string) y band_bloq(int) si el alumno esta bloqueado
//Modificado Abril 1998

int baja
baja = BanderasAlumno[b_cfb]

//	Revisa la situación del alumno contra la bandera
	
	if baja <> 0 then		
		band_bloq = 1
		bloqueado_por	= bloqueado_por+"~t+Por adeudos con biblioteca ~r"
	end if
	

end subroutine

public function integer revisanip (long al_cuenta, string as_nip);/*
 *		Nombre	revisanip
 *		Recibe	al_cuenta, as_nip
 *		Regresa	0	si el alumno con cuenta al_cuenta no tiene nip registrado
 *					1	si el nip dado as_nip corresponde al nip de la cuenta al_cuenta
 *					2  si el nip dado as_nip no corresponde al nip de la cuenta al_cuenta
 *					-1	error de comunicacion
 *					FMC09041999
 */
DataStore lds_nips
int li_res, li_ret
string ls_nip
lds_nips = Create DataStore
lds_nips.SetTransObject(gtr_sce)
lds_nips.DataObject = "d_nips"
li_res = lds_nips.Retrieve(al_cuenta)
choose case li_res
	case 1
		ls_nip = lds_nips.GetItemString(1,"nip")
		consulta_sie(as_nip)
		if ls_nip = as_nip then
			li_ret = 1
		else
			li_ret = 2
		end if
	case 0
		li_ret = 0
	case else
		li_ret = -1
end choose
Destroy lds_nips
return li_ret
end function

public function integer existe_materia (long cvmat, ref string mat, ref integer crd, ref integer hrst, integer hrsp);//Carlos Armando Melgoza Piña 													Marzo 1997	
//Función que revisa si la materia existe en el catalogo de mat. Si existe regresa el nombre y creditos de la materia
//Regresa 0 si existe y 1 en caso contrario
   SELECT materias.cve_mat,   
        		    materias.materia,   
		         materias.creditos,
					materias.horas_teoria,
					materias.horas_practica
	    INTO :cvmat,   
   			   :mat,   
		        :crd,
				  :hrst, :hrsp
	 FROM materias  
   WHERE materias.cve_mat = :cvmat  USING gtr_sce;
	
	if gtr_sce.sqlcode = 0 then
		commit USING gtr_sce;
		return 0
	else
		if gtr_sce.sqlcode = 100 then
			commit USING gtr_sce;
			ii_statusmat_preinsc = 70 //Materia inexistente
			return 1
		end if
		commit USING gtr_sce;
		ii_statusmat_preinsc = 65 //Error de comunicación
		return 1 //Error en la comunicación con la BD
	end if

end function

public function integer actualiza_status (long al_cuenta);/*Función que cambia el status del alumno evitando asi una nueva carga de la información de preinscripcion
	Mayo 1998	CAMP	DkWf*/

UPDATE preinsc  
     SET status = 4  
   WHERE (preinsc.cuenta = :al_cuenta) AND
   			   (preinsc.periodo = :g_per) AND
			   (preinsc.anio = :g_anio) USING gtr_sce;
	
	if gtr_sce.sqlcode = 0 then
		commit USING gtr_sce;
		return 0
	else
		rollback USING gtr_sce;
		return 1
	end if

end function

public subroutine inscribe_mat_preinsc ();/*Función que revisa e inscribe las materias preinscritas
  Mayo 1998		CAMP		DkWf*/
  int reng,cont,cred_act
  string ls_gpo, ls_gpo2
  long ll_cve_mat
  dw_materias.insertrow(0)
  cont = dw_materias.rowcount()
  agrega_mat()
  for reng = 1 to dw_mat_preinsc.rowcount()	
	dw_materias.object.mat_inscritas_cve_mat[cont]	= dw_mat_preinsc.object.cve_mat[reng]
	ll_cve_mat = dw_materias.object.mat_inscritas_cve_mat[cont]
	dw_materias.scrolltorow(cont)
	dw_materias.setcolumn("mat_inscritas_cve_mat")
	dw_materias.triggerevent(itemchanged!)
	cred_act = dw_materias.getitemnumber(dw_materias.getrow(),"creditos_totales")
		if dw_materias.object.mat_inscritas_cve_mat[cont] <> 0 then
			dw_materias.object.mat_inscritas_gpo[cont]	= dw_mat_preinsc.object.gpo[reng]
			ls_gpo2 = dw_materias.object.mat_inscritas_gpo[cont]	
			dw_materias.scrolltorow(cont)
			dw_materias.setcolumn("mat_inscritas_gpo")
			dw_materias.triggerevent(itemchanged!)
			if aceptado = 0 then
				cont ++	
			else
				aceptado = 0
			end if
		agrega_mat()
		end	 if
		dw_mat_preinsc.SetItem(reng,"status",ii_statusmat_preinsc)
		if (ii_statusmat_preinsc = 84) or (ii_statusmat_preinsc = 85) then
			ls_gpo = dw_mat_preinsc.GetItemstring(reng,"gpo")
			if gruposparalelos(dw_mat_preinsc.GetItemNumber(reng,"cve_mat"),ls_gpo,g_anio,g_per) = 1 then
				dw_mat_preinsc.InsertRow(reng + 1)
				dw_mat_preinsc.SetItem(reng + 1,"cuenta",dw_mat_preinsc.GetItemNumber(reng,"cuenta"))
				dw_mat_preinsc.SetItem(reng + 1,"cve_mat",dw_mat_preinsc.GetItemNumber(reng,"cve_mat"))
				dw_mat_preinsc.SetItem(reng + 1,"gpo",ls_gpo)
				dw_mat_preinsc.SetItem(reng + 1,"status",0)
				dw_mat_preinsc.SetItem(reng + 1,"anio",g_anio)
				dw_mat_preinsc.SetItem(reng + 1,"periodo",g_per)
			end if
		end if
  next
  dw_mat_preinsc.Update()
  commit USING gtr_sce;
end subroutine

public subroutine actualiza_status_materias (long al_cuenta);int li_i
if (dw_mat_preinsc.retrieve(al_cuenta,g_per,g_anio) > 0) then
	for li_i = 1 to dw_mat_preinsc.Rowcount()
		dw_mat_preinsc.SetItem(li_i,"status",ii_statusmat_preinsc)
	next
	dw_mat_preinsc.Update()
	commit USING gtr_sce;
end if
actualiza_status(al_cuenta)
end subroutine

public function integer gruposparalelos (integer ai_cve_mat, ref string as_gpo, integer ai_anio, integer ai_periodo); /*
 *		Nombre	gruposparalelos
 *		Recibe	ai_cve_mat,as_gpo,ai_anio,ai_periodo
 *		Regresa	0	si no existe un grupo paralelo a ai_cve_mat-as_gpo para el periodo ai_anio-ai_periodo
 *					1	si existe un grupo paralelo a ai_cve_mat-as_gpo para el periodo ai_anio-ai_periodo 
 *						cambia el valor del as_gpo por el grupo paralelo
 *						Es grupo paralelo si es la misma materia con el mismo horario, inscritos < cupo, abierto y que
 *						no este apartado para otras materias
 *					-1	error de comunicacion
 *					FMC17111999
 */
 DataStore lds_grupos_libres, lds_rev_hor
 int li_res, li_ret, li_rengl, li_i, li_encontrado
 int li_cve_dia1, li_cve_dia2, li_hora_inicio1, li_hora_inicio2, li_hora_fin1, li_hora_fin2
 boolean lb_encontrado, lb_busca_grupo
 lds_grupos_libres = Create DataStore
 lds_grupos_libres.DataObject = 'd_grupos_libres'
 li_res = lds_grupos_libres.SetTransObject(gtr_sce)
 lds_rev_hor = Create DataStore
 lds_rev_hor.DataObject = 'dw_rev_hor'
 li_res = lds_rev_hor.SetTransObject(gtr_sce)
 
 li_res = lds_grupos_libres.Retrieve(ai_cve_mat,ai_periodo,ai_anio)
 if li_res = 0 then
	li_ret = 0
 elseif li_res < 0 then
	li_ret = -1
 else
	li_res = lds_rev_hor.Retrieve(ai_cve_mat,as_gpo,ai_periodo,ai_anio)
	if li_res < 0 then
		li_ret = -1
	else
		if li_res = 0 then
			lds_rev_hor.InsertRow(0)
			lds_rev_hor.SetItem(1,"cve_dia",0)
			lds_rev_hor.SetItem(1,"hora_inicio",0)
			lds_rev_hor.SetItem(1,"hora_final",0)
		end if
		li_rengl = 1
		li_encontrado = 0
		do while li_rengl <= lds_grupos_libres.RowCount()
			for li_i = 1 to lds_rev_hor.RowCount()
				li_cve_dia1 = lds_grupos_libres.GetItemNumber(li_rengl,"horario_cve_dia")
				li_cve_dia2 = lds_rev_hor.GetItemNumber(li_i,"cve_dia")
				li_hora_inicio1 = lds_grupos_libres.GetItemNumber(li_rengl,"horario_hora_inicio")
				li_hora_inicio2 = lds_rev_hor.GetItemNumber(li_i,"hora_inicio")
				li_hora_fin1 = lds_grupos_libres.GetItemNumber(li_rengl,"horario_hora_final")
				li_hora_fin2 = lds_rev_hor.GetItemNumber(li_i,"hora_final")
				if isnull(li_cve_dia1) then li_cve_dia1 = 0
				if isnull(li_cve_dia2) then li_cve_dia2 = 0
				if isnull(li_hora_inicio1) then li_hora_inicio1 = 0
				if isnull(li_hora_inicio2) then li_hora_inicio2 = 0
				if isnull(li_hora_fin1) then li_hora_fin1 = 0
				if isnull(li_hora_fin2) then li_hora_fin2 = 0
				if (li_cve_dia1 <> li_cve_dia2) or (li_hora_inicio1 <> li_hora_inicio2)&
					or (li_hora_fin1 <> li_hora_fin2) then
					li_i =  lds_rev_hor.RowCount()+2
				else
					li_rengl ++
				end if
			next
			if li_i = lds_rev_hor.RowCount() + 3  then
				lb_busca_grupo = true
			else
				//MessageBox("",string(li_rengl))
				if revisa_gpo_bloqueado(lds_grupos_libres.GetItemNumber(li_rengl - 1, "grupos_cve_mat"),&
													lds_grupos_libres.GetItemString(li_rengl - 1, "grupos_gpo")) = 1 then
						lb_busca_grupo = true
				else
					if li_rengl <= lds_grupos_libres.RowCount() then
						if (lds_grupos_libres.GetItemString(li_rengl - 1, "grupos_gpo")=&
							lds_grupos_libres.GetItemString(li_rengl, "grupos_gpo")) then 
							lb_busca_grupo = true
						else
							lb_busca_grupo = false
							li_encontrado = li_rengl - 1
							li_rengl = lds_grupos_libres.RowCount() + 1
						end if
					else
						lb_busca_grupo = false
						li_encontrado = li_rengl - 1
						li_rengl = lds_grupos_libres.RowCount() + 1
					end if
				end if
			end if
			if lb_busca_grupo = true then
				lb_encontrado = false
				do while (li_rengl < lds_grupos_libres.RowCount() and lb_encontrado = false) 
					if (lds_grupos_libres.GetItemString(li_rengl,"grupos_gpo") =&
						lds_grupos_libres.GetItemString(li_rengl + 1,"grupos_gpo")) then
							li_rengl ++
					else
						lb_encontrado = true
					end if
				loop
			end if
			li_rengl ++
		loop
	end if
end if
if li_encontrado = 0 and li_ret <> -1 then
	li_ret = 0
else
	li_ret = 1
	//MessageBox("",string(ai_cve_mat)+"-"+as_gpo+"-"+lds_grupos_libres.GetItemString(li_encontrado,"grupos_gpo"))
	as_gpo = lds_grupos_libres.GetItemString(li_encontrado,"grupos_gpo")
end if
Destroy lds_grupos_libres
Destroy lds_rev_hor
return li_ret

end function

public subroutine revisa_baja_laboratorio (long cta);//revisa_baja_laboratorio
//Antonio Pica																			Noviembre 2001
//Función que revisa la situación del alumno por adeudos de laboratorio
//Modifica las variables bloqueado_por(string) y band_bloq(int) si el alumno esta bloqueado
//Modificado Abril 1998
//Recibe 
//			cta	long		el número de cuenta del alumno


int baja
baja = BanderasAlumno[b_bl]


//	Revisa la situación del alumno contra la bandera
//**********MUY IMPORTANTE**********
//Esta funcion se modificó para que la baja por laboratorio no bloquee a los alumnos
//si se desea su funcionalidad normal (el bloqueo por adeudos de laboratorio)
//es necesario descomentar el contenido encontrado entre el 1. y el 2.
//**********MUY IMPORTANTE**********

//1.
//	if baja <> 0 then		
//		band_bloq = 1
//		bloqueado_por	= bloqueado_por+"~t+Por adeudos de laboratorio ~r"
//	end if
//2.	


end subroutine

public function integer llenabanderas (ref long cue, ref integer bandera[23]);/*Función que llena la estructura con la información de la tabla de banderas
	Fantine Medina Carrillo
	Noviembre 1997
*/
int cont
cont = 0

intento:
SELECT	insc_sem_ant,			cve_flag_promedio,	baja_3_reprob,		baja_4_insc,
			baja_disciplina,		baja_documentos,		invasor_hora,		exten_cred,
										cve_flag_serv_social,puede_integracion,tema_fundamental_1,
			tema_fundamental_2,	tema_1,					tema_2,				tema_3,
			tema_4,												cve_flag_biblioteca,
			adeuda_finanzas,		creditos_integ,      isnull(baja_laboratorio,0)
			INTO
			:bandera[b_isa],		:bandera[b_cfp],		:bandera[b_b3r],		:bandera[b_b4i],
			:bandera[b_bdi],		:bandera[b_bdo],		:bandera[b_ih],		:bandera[b_ec],
										:bandera[b_cfss],		:bandera[b_pi],		:bandera[b_tf1],
			:bandera[b_tf2],		:bandera[b_t1],		:bandera[b_t2],		:bandera[b_t3],
			:bandera[b_t4],									:bandera[b_cfb],
			:bandera[b_af],		:bandera[b_ci],      :bandera[b_bl]
			FROM banderas WHERE cuenta = :cue USING gtr_sce;
			
		if gtr_sce.sqlcode <> 0 then
			commit USING gtr_sce;
			if cont < 5 then
				cont++
				goto intento
			end if			
			ii_statusmat_preinsc = 65 //Error de comunicación
			return 1
		elseif gtr_sce.sqlcode = 0 then
			commit USING gtr_sce;
			return 0
		end if
		
end function

on w_preinsctoreinsc_ant_5_dig.create
if this.MenuName = "m_preinsctoreinsc" then this.MenuID = create m_preinsctoreinsc
this.uo_nombre=create uo_nombre
this.sle_2=create sle_2
this.sle_1=create sle_1
this.cb_1=create cb_1
this.st_total=create st_total
this.cb_preinsctoreinsc=create cb_preinsctoreinsc
this.dw_mat_preinsc=create dw_mat_preinsc
this.p_uia=create p_uia
this.dw_reinsc_mat=create dw_reinsc_mat
this.dw_horario_mat=create dw_horario_mat
this.dw_materias=create dw_materias
this.dw_plan=create dw_plan
this.dw_ext_h=create dw_ext_h
this.dw_prerre=create dw_prerre
this.dw_cursada=create dw_cursada
this.Control[]={this.uo_nombre,&
this.sle_2,&
this.sle_1,&
this.cb_1,&
this.st_total,&
this.cb_preinsctoreinsc,&
this.dw_mat_preinsc,&
this.p_uia,&
this.dw_reinsc_mat,&
this.dw_horario_mat,&
this.dw_materias,&
this.dw_plan,&
this.dw_ext_h,&
this.dw_prerre,&
this.dw_cursada}
end on

on w_preinsctoreinsc_ant_5_dig.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nombre)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.cb_1)
destroy(this.st_total)
destroy(this.cb_preinsctoreinsc)
destroy(this.dw_mat_preinsc)
destroy(this.p_uia)
destroy(this.dw_reinsc_mat)
destroy(this.dw_horario_mat)
destroy(this.dw_materias)
destroy(this.dw_plan)
destroy(this.dw_ext_h)
destroy(this.dw_prerre)
destroy(this.dw_cursada)
end on

event open;//Carlos Armando Melgoza Piña 										Marzo 1997
//Inicialización de la ventana y sus componentes
x = 1
y = 1
dw_teoria_lab = Create DataStore

dw_plan.settransobject(gtr_sce)
dw_materias.settransobject(gtr_sce)
dw_horario_mat.settransobject(gtr_sce)
dw_prerre.settransobject(gtr_sce)
dw_mat_preinsc.settransobject(gtr_sce)
dw_teoria_lab.dataobject = "d_teoria_lab_por_carreramateria"
dw_teoria_lab.SetTransObject(gtr_sce)
if gi_nivel_usuario = 1 then
	dw_cursada.dataobject = "dw_cursada"
else
	dw_cursada.dataobject = "dw_cursada_pos"
end if
dw_cursada.settransobject(gtr_sce)
dw_reinsc_mat.settransobject(gtr_sce)
dw_reinsc_mat.retrieve()
lectura_parametros()//Se cargan los parametros fijos para la reinscripcion
uo_nombre.em_cuenta.setfocus()
uo_nombre.BackColor= RGB(191,223,191)
uo_nombre.r_1.FillColor= RGB(191,223,191)
uo_nombre.dw_nombre_alumno.object.datawindow.Color= RGB(191,223,191)


end event

event activate;sparl.toolbarsheettitle="Reinscripción en Linea"























end event

event closequery;if revisa_labs(long(this.uo_nombre.em_cuenta.text)) = 0 then
	return 0
else
	return 1
end if
end event

event close;Destroy dw_teoria_lab
end event

type uo_nombre from uo_nombre_alumno_sparl within w_preinsctoreinsc_ant_5_dig
integer x = 215
integer y = 16
integer taborder = 10
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alumno_sparl::destroy
end on

type sle_2 from singlelineedit within w_preinsctoreinsc_ant_5_dig
integer x = 1280
integer y = 1872
integer width = 247
integer height = 92
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_preinsctoreinsc_ant_5_dig
integer x = 992
integer y = 1872
integer width = 247
integer height = 92
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_preinsctoreinsc_ant_5_dig
integer x = 1083
integer y = 1984
integer width = 672
integer height = 108
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Prueba Paralelo"
end type

event clicked;//mat. gpo , anio, per
string ls_gpo, ls_cve_mat
ls_cve_mat = sle_1.text
ls_gpo = sle_2.text
if gruposparalelos(integer(ls_cve_mat),ls_gpo, g_anio, g_per) = 1 then
	sle_2.text = ls_gpo
else
	messageBox("Sin paralelo","")
end if
end event

type st_total from statictext within w_preinsctoreinsc_ant_5_dig
integer x = 2080
integer y = 1712
integer width = 576
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 12639424
boolean enabled = false
string text = "0 de 0"
boolean focusrectangle = false
end type

type cb_preinsctoreinsc from commandbutton within w_preinsctoreinsc_ant_5_dig
integer x = 718
integer y = 1700
integer width = 1317
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Paso de Preinscripción a Reinscripción"
end type

event clicked;int li_file
int li_res, li_i, li_intentos
DataStore lds_preinsc_por_anio_periodo
lds_preinsc_por_anio_periodo = Create DataStore
lds_preinsc_por_anio_periodo.DataObject = "d_preinsc_por_anio_periodo"
lds_preinsc_por_anio_periodo.SetTransObject(gtr_sce)
li_res = lds_preinsc_por_anio_periodo.Retrieve(g_anio,g_per)
li_file = FileOpen("c:\windows\escritorio\horas.txt",StreamMode!,Write!)
FileWrite(li_file,string(today(), "dd/mm/yyyy hh:mm"))
if li_res >= 0 then
	for li_i = 1 to li_res
		st_total.text = string(li_i) + " de " + string(li_res)
		text = "Procesando cuenta :"+string(lds_preinsc_por_anio_periodo.GetItemNumber(li_i,"cuenta"))
		uo_nombre.em_cuenta.text = string(lds_preinsc_por_anio_periodo.GetItemNumber(li_i,"cuenta"))+&
							obten_digito(lds_preinsc_por_anio_periodo.GetItemNumber(li_i,"cuenta"))
		uo_nombre.em_cuenta.triggerevent("activarbusq")
		li_intentos = 0
		do while (revisa_labs(lds_preinsc_por_anio_periodo.GetItemNumber(li_i,"cuenta")) <> 0) and li_intentos < 10
			li_intentos ++
		loop
	next
else
	messagebox("Error de comunicación","Error con la consulta de alumnos preinscritos BD. Favor de intentar nuevamente", None!)	
end if
text = "Fin de Proceso"
enabled = false
Destroy lds_preinsc_por_anio_periodo
FileWrite(li_file,string(today(), "dd/mm/yyyy hh:mm"))
FileClose(li_file)

end event

type dw_mat_preinsc from datawindow within w_preinsctoreinsc_ant_5_dig
boolean visible = false
integer x = 320
integer y = 1636
integer width = 1006
integer height = 324
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_mat_preinscritas"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type p_uia from picture within w_preinsctoreinsc_ant_5_dig
integer x = 3479
integer y = 20
integer width = 110
integer height = 92
boolean originalsize = true
string picturename = "uia2.bmp"
boolean focusrectangle = false
end type

type dw_reinsc_mat from datawindow within w_preinsctoreinsc_ant_5_dig
boolean visible = false
integer x = 626
integer y = 1680
integer width = 494
integer height = 228
integer taborder = 80
string dataobject = "dw_reinscripcion_materias"
boolean livescroll = true
end type

type dw_horario_mat from datawindow within w_preinsctoreinsc_ant_5_dig
boolean visible = false
integer x = 59
integer y = 20
integer width = 73
integer height = 260
string dataobject = "dw_rev_hor"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_materias from datawindow within w_preinsctoreinsc_ant_5_dig
event borramat ( )
event verhorariodisp ( )
event verhorariodispinteg ( long area )
event laboratorios ( )
event actualizahorario ( )
boolean visible = false
integer x = 91
integer y = 620
integer width = 2455
integer height = 1004
integer taborder = 10
string dataobject = "dw_mat_inscritas"
boolean border = false
end type

event borramat;//Carlos Armando Melgoza Piña								Marzo 1997
//Evento encargado del borrado de una materia y
//la actualización correspondiente en alumnos inscritos en la tabla de grupos
long cvmat
string gpo


if rowcount()	>	0 then
	if isnull(getitemstring(RowCount(),"materias_materia")) then deleterow(RowCount())
	if getitemnumber(getrow(),1) > 0 and getitemstring(getrow(),2) <> " " then
		cvmat = getitemnumber(getrow(),"mat_inscritas_cve_mat",Primary!,False) // Lectura de la cve de la mat
		gpo = getitemstring(getrow(),"mat_inscritas_gpo",Primary!,False) // Lectura del gpo de la mat
		if borra_mat_insc(long(uo_nombre.em_cuenta.text),cvmat,gpo) = 0 then		//borra la materia de materias inscritas del alumno
			commit USING gtr_sce;
			actualiza_struct_horario(cvmat,gpo,0)	//Actualización de la estructura de horario		
			dw_materias.retrieve(long(uo_nombre.em_cuenta.text))
			if rowcount() <= 0 then //Inserta nuevo renglon para evitar errores				
				dw_materias.insertrow(0)
				agrega_mat()
				dw_materias.setfocus()
			end if
		end if
	else
		deleterow(getrow())
		if rowcount() <= 0 then //Inserta nuevo renglon para evitar errores				
		  dw_materias.insertrow(0)
			 agrega_mat()
		  dw_materias.setfocus()
		end if
	end if
end if
end event

event actualizahorario;//Carlos Amando Melgoza Piña										Marzo 1997
//Evento en el cual se dibujan las materias

int cont
long cvmat
string gpo

for cont = 1 to rowcount()
	cvmat = getitemnumber(cont,"mat_inscritas_cve_mat") //Lectura de materia inscrita
	gpo = getitemstring(cont,"mat_inscritas_gpo") //Lectura del grupo inscrito
	dw_horario_mat.retrieve(cvmat,gpo,g_per,g_anio)	  
	actualiza_struct_horario(cvmat,gpo,1)		  	  
next


end event

event itemchanged;//Carlos Amando Melgoza Piña										Marzo 1997
//Evento de detección del campo modificado : Clave o Grupo
string columna,gpo,mat
long cvmat
int crd, hrst,hrsp
//valores para aceptado 0 Se acepto la materia 1 no se acepto la materia 2 no se acepto el grupo
//Si sobrepaso el número de creditos  tiene en aceptado 3

setpointer(Hourglass!)
accepttext()
ii_statusmat_preinsc = 0
columna = getcolumnname() // Revisión de la columna modificada
cvmat = getitemnumber(getrow(),"mat_inscritas_cve_mat",Primary!,False) // Lectura de la cve de la mat
if columna = "mat_inscritas_cve_mat" then //Si la columna es clave de materia	
	if cvmat > 0 then
		if existe_materia(cvmat,mat,crd,hrst,hrsp) = 0 then  //Revisa si la materia existe
			setitem(getrow(),"materias_materia",mat)  //Si existe, despliega el nombre y los creditos y las horas
			setitem(getrow(),"materias_creditos",crd)
			setitem(getrow(),"choras_teoria",hrst)
			setitem(getrow(),"choras_practica",hrsp)
			cred_integ = crd_ant
			aceptado = 1
			if pert_plan_est(cvmat,I_CarreraAlumno, I_PlanAlumno) = 0 then //Revisa si la materia pertenece al plan de estudios del alumno
				if revisa_prerrequisito(cvmat,long(uo_nombre.em_cuenta.text)) = 0 then //Revisa si el alumno ha cursado los prerequisitos necesarios para la materia
					if revisa_cursada(cvmat,long(uo_nombre.em_cuenta.text)) = 0 then //Revisa si el alumno habia cursado la materia
						if revisa_creditos(long(uo_nombre.em_cuenta.text),getitemnumber(getrow(),"creditos_totales")) = 0 then	//Revisa si los creditos maximos del alumno no han sido sobrepasados
							if revisa_insc(cvmat,long(uo_nombre.em_cuenta.text)) = 0 then //Revisa si ya se inscribió la materia anteriormente
								if revisa_ss(cvmat,long(uo_nombre.em_cuenta.text)) = 0 then // Revisa si la materia es ss y si el alumno puede cursarla
									if revisa_curso_tema(cvmat,long(uo_nombre.em_cuenta.text)) = 0	then //Revisa si ya se curso un tema de integración 
										aceptado=0
										setcolumn(2)
										return 0
									end if
								end if
							end if
						else
							aceptado=3//Si sobrepaso el número de creditos  tiene en aceptado 3
						end if
					end if
				end if
			end if
			setpointer(Arrow!)
			borra_materia()
			return 1
		end if	
	end if
	setpointer(Arrow!)
	return 0
elseif columna = "mat_inscritas_gpo" then // Si la columna es el grupo
	cvmat = getitemnumber(getrow(),"mat_inscritas_cve_mat",Primary!,False)
	gpo = getitemstring(getrow(),columna,Primary!,False) // Lectura del gpo de la mat
	if gpo_existe(cvmat,gpo) = 0 then // Revisión de grupo existente
	 	if revisa_horario(cvmat,gpo,long(uo_nombre.em_cuenta.text)) = 0  then  //Revisión de materias encimadas
			if revisa_gpo_bloqueado(cvmat,gpo) = 0 then //Revisión de grupo bloqueado	*****Busque un pararelo*****  		
				if gpo_lleno(cvmat,gpo) = 0 then //Revisión de grupo lleno   *****Busque un pararelo*****
					if dw_materias.update(TRUE) = 1 then //Realiza la actualización de materias inscritas					
						commit USING gtr_sce;				       							
						actualiza_struct_horario(cvmat,gpo,1)
						crd_ant = cred_integ		
						scrolltorow(insertrow(0))
						agrega_mat()
						ii_statusmat_preinsc = 255
						setcolumn("mat_inscritas_cve_mat") 	
						parent.uo_nombre.em_cuenta.enabled = false
						parent.uo_nombre.dw_nombre_alumno.enabled = false
						setpointer(Arrow!)
						return 1
					else
						rollback USING gtr_sce;
					end if			
				end if 		//Grupo lleno
			end if			//Grupo Bloqueado
		end if				//Horario
	end if					//ExisteGrupo
	setpointer(Arrow!)
	aceptado=2
	borra_gpo()
	return 1
end if
setpointer(Arrow!)
return 0
end event

event itemerror;return 1
end event

event rowfocuschanged;//Carlos Armando Melgoza Piña										Abril 1997	
//Evento que coloca el cursor en el campo materia en el cambio de renglon

int a , b
a = getrow()
b = rowcount()

if getrow() = rowcount() then
	setcolumn("mat_inscritas_cve_mat")
end if
end event

event retrieveend;//Carlos Amando Melgoza Piña										Marzo 1997
//Evento en el cual se verifica el total de materias de integración inscritas.

int cont,cred,d,h,ren
long cvmat,area
string gpo
int li_cve_mat[64]

cred_integ = 0
//for con = 1 to 64 li_cve_mat = 0

for cont = 1 to rowcount()
	li_cve_mat[cont] = getitemnumber(cont,"mat_inscritas_cve_mat") //Lectura de materia inscrita
next
if rowcount() > 0 then
	DataStore lds_creditos_integ
	lds_creditos_integ = Create DataStore
	lds_creditos_integ.DataObject = "d_creditos_integ"
	lds_creditos_integ.SetTransObject(gtr_sce)
	if (lds_creditos_integ.Retrieve(li_cve_mat) = 1) then
		cred_integ = lds_creditos_integ.GetItemNumber(1,"suma")
	else
		cred_integ = 100 // Error de comunicacion, Excede créditos
	end if
	Destroy lds_creditos_integ
end if
if isnull(cred_integ) then cred_integ = 0	
crd_ant = cred_integ


	
	
	
end event

type dw_plan from datawindow within w_preinsctoreinsc_ant_5_dig
integer x = 192
integer y = 436
integer width = 3250
integer height = 172
string dataobject = "dw_plan_de_est"
boolean border = false
end type

type dw_ext_h from datawindow within w_preinsctoreinsc_ant_5_dig
boolean visible = false
integer x = 2523
integer y = 604
integer width = 1093
integer height = 1124
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ext_horario"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;int cont
string rango_hora

for cont = 1 to 15
	rango_hora = string(cont+6)+" - "+string(cont+7)
	insertrow(0)
	setitem(cont,"horario",rango_hora)
next
end event

event itemfocuschanged;//Evento en el que se selecciona la materia desde el horario
//CAMP									abril 1998
long materia
int cont

materia	=	long(dwo.primary[row])
dw_materias.SelectRow ( linea_select, false )	
for cont	=	1 to dw_materias.rowcount()
	if dw_materias.object.mat_inscritas_cve_mat[cont] = materia	then		
		dw_materias.SelectRow ( cont, true )
		linea_select	=	cont
	end if			
next
dw_materias.setfocus()
dw_materias.setrow(linea_select)

end event

type dw_prerre from datawindow within w_preinsctoreinsc_ant_5_dig
boolean visible = false
integer x = 32
integer y = 156
integer width = 128
integer height = 192
boolean bringtotop = true
string dataobject = "dw_prerrequisito"
boolean border = false
end type

type dw_cursada from datawindow within w_preinsctoreinsc_ant_5_dig
boolean visible = false
integer x = 18
integer y = 48
integer width = 206
integer height = 260
boolean bringtotop = true
string dataobject = "dw_cursada"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

