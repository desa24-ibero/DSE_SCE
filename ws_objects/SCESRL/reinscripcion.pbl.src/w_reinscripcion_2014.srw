$PBExportHeader$w_reinscripcion_2014.srw
forward
global type w_reinscripcion_2014 from window
end type
type cb_2 from commandbutton within w_reinscripcion_2014
end type
type st_sistema from statictext within w_reinscripcion_2014
end type
type p_ibero from picture within w_reinscripcion_2014
end type
type cb_1 from commandbutton within w_reinscripcion_2014
end type
type dw_pase_ingreso from datawindow within w_reinscripcion_2014
end type
type st_inic from statictext within w_reinscripcion_2014
end type
type st_1 from statictext within w_reinscripcion_2014
end type
type dw_reinsc_mat from datawindow within w_reinscripcion_2014
end type
type dw_materias from datawindow within w_reinscripcion_2014
end type
type dw_ext_h from datawindow within w_reinscripcion_2014
end type
type dw_prerre from datawindow within w_reinscripcion_2014
end type
type dw_cursada from datawindow within w_reinscripcion_2014
end type
type dw_comprobante from datawindow within w_reinscripcion_2014
end type
type r_1 from rectangle within w_reinscripcion_2014
end type
type dw_mat_pase_ingreso from datawindow within w_reinscripcion_2014
end type
type uo_nombre from uo_carreras_alumno_lista within w_reinscripcion_2014
end type
type dw_grupos_disponibles from datawindow within w_reinscripcion_2014
end type
type dw_mat_integ from datawindow within w_reinscripcion_2014
end type
type dw_labs from datawindow within w_reinscripcion_2014
end type
type dw_horario_mat from datawindow within w_reinscripcion_2014
end type
type dw_grupos_disp from datawindow within w_reinscripcion_2014
end type
type mensaje from structure within w_reinscripcion_2014
end type
end forward

type mensaje from structure
	statictext		hora[15]
end type

global type w_reinscripcion_2014 from window
boolean visible = false
integer x = 5
integer y = 4
integer width = 6958
integer height = 3688
boolean titlebar = true
string title = "Sistema de Reinscripción en Linea"
string menuname = "m_reinscripcion_2014"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean vscrollbar = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 16777215
string icon = "reinscripcion.ico"
event inicia_proceso ( )
event cierra_ventanas_grupos ( )
cb_2 cb_2
st_sistema st_sistema
p_ibero p_ibero
cb_1 cb_1
dw_pase_ingreso dw_pase_ingreso
st_inic st_inic
st_1 st_1
dw_reinsc_mat dw_reinsc_mat
dw_materias dw_materias
dw_ext_h dw_ext_h
dw_prerre dw_prerre
dw_cursada dw_cursada
dw_comprobante dw_comprobante
r_1 r_1
dw_mat_pase_ingreso dw_mat_pase_ingreso
uo_nombre uo_nombre
dw_grupos_disponibles dw_grupos_disponibles
dw_mat_integ dw_mat_integ
dw_labs dw_labs
dw_horario_mat dw_horario_mat
dw_grupos_disp dw_grupos_disp
end type
global w_reinscripcion_2014 w_reinscripcion_2014

type variables
decimal cred_integ
decimal crd_ant
horario hora[15]

long il_cuenta = 0
int BanderasAlumno[23]
long I_CarreraAlumno
long I_PlanAlumno
long I_cvss
int I_cms//Creditos Maximos al Semestre
int I_tipo,I_cupo, I_insc
long  I_mat_a
string  I_gpo_a
char nivel//L o P
//char incorp_sep//S o N
//variables que contienen parametros de activacion
int ex_cred,tipo_insc, exe_cupo,mat_enci

INTEGER ie_revisa_proyecto_ss

string i_men
int i_baj_per_dis, i_imp_com, i_preinsc
int i_pregunta_nip, i_revisa_teoria_lab,i_revisa_grupos_bloqueados

//variables para bloqueos
int band_bloq
string bloqueado_por

integer ii_vigente

//varible para seleccion de mat
//int linea_select

//Struct
//mensaje dia_h[7]

CONSTANT int b_isa = 1, b_cfp = 2, b_b3r = 3, b_b4i = 4
CONSTANT int b_bdi = 5, b_bdo = 6, b_ih = 7, b_ec = 8
CONSTANT int b_cfpi = 9, b_cfss = 10, b_pi = 11
CONSTANT int b_tf1 = 12, b_tf2 = 13, b_t1 = 14, b_t2 = 15
CONSTANT int b_t3 = 16, b_t4 = 17, b_ci = 18, b_cfb = 19
CONSTANT int b_cfd = 20, b_af = 21, b_v = 22, b_bl=23

DataStore  dw_mat_prerre, dw_teoria_lab, dw_teoria_lab_ligados

int aceptado=0//variable usada como interfaz con preinscripcion
string i_mensaje

uo_administrador_liberacion iuo_administrador_liberacion

integer ii_cve_mat
string is_gpo

// Máximo de créditos permitidos por Carrera y Alumno
INTEGER ie_max_creditos 
INTEGER ie_max_cred_verano

DATASTORE ids_area_mat


uo_servicios_manresa iuo_servicios_manresa
end variables

forward prototypes
public function integer revisa_nivel (long numcta)
public subroutine borrado_cuenta ()
public function integer revisa_prerrequisito (long mat, long cuenta)
public function integer revisa_cursada (long mat, long cta)
public function integer verifica_extension (long cta)
public subroutine borra_materia ()
public subroutine borra_gpo ()
public function integer revisa_insc (long mat, long cta)
public function integer gpo_existe (long mat, string gpo)
public subroutine agrega_mat ()
public function integer revisa_hora_insc (long cta)
public function integer gpo_lleno (long mat, string gpo)
public function integer revisa_horario (long mat, string gpo, long cta)
public function integer borra_mat_insc (long cta, long mat, string gpo)
public function integer revisa_per_insc_mat (long cta, long mat, string gpo)
public function integer obten_carr_plan (long cta, ref long cvcarrera, ref long cvplan)
public function integer revisa_impresiones ()
public function long pert_plan_est (long mat, long carr, long plan)
public function integer revisa_area (long cvmat)
public function integer obten_ss (long cta)
public subroutine encuentra_salon (long cvmat, ref integer row)
public subroutine limpia_comprobante ()
public subroutine fill_horario ()
public subroutine limpia_lineas_vacias ()
public function integer error (string que)
public function integer revisa_incorp_sep ()
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
public subroutine obten_nomb_profesor (long cve_mat, string gpo)
public function integer revisanip (long al_cuenta, string as_nip)
public function integer revisa_nip (long al_cuenta)
public function integer llenabanderas (ref long cue, ref integer bandera[23])
public subroutine revisa_baja_laboratorio (long cta)
public function integer revisa_gpo_bloqueado (long mat, string gpo)
public subroutine actualiza_struct_horario (long cvmat, string gpo, integer flag)
public function integer revisa_ss (long mat, long cta)
public function integer revisa_pago_ultima_hora (long cta)
public subroutine llena_comprobante ()
public function integer revisa_curso_tema (long mat, long cta)
public subroutine actualiza_integ ()
public function integer revisa_labs (long cuenta)
public function integer revisa_tipo_periodo (long al_cuenta_alumno)
public function integer obten_cred_max (long carrera, long plan)
public function integer revisa_prerrequisito_especial (long mat, long cuenta)
public function integer revisa_creditos (long cta, decimal cred_act)
public function integer existe_materia (long cvmat, ref string mat, ref decimal crd, ref integer hrst, ref integer hrsp)
public function integer f_crea_servicios_mat_sep ()
public function integer f_inserta_mat_sep (long al_cve_mat, string as_gpo)
end prototypes

event cierra_ventanas_grupos;/*Evento que verifica si las ventanas estan abiertas y las cierra Agosto 1998
CAMP(DkWf)*/
if dw_grupos_disp.visible = true then//CIERRA GRUPOS DISPONIBLES
	dw_grupos_disp.visible = false
end if

if dw_mat_integ.visible = true then //CIERRA GRUPOS DE INTEGRACION
	dw_mat_integ.visible = false
end if

end event

public function integer revisa_nivel (long numcta);//Carlos Armando Melgoza Piña									Marzo 1997
//Función que revisa que el alumno se inscriba en el periodo que le corresponda Licenciatura o Posgrado.
//Regresa 1 si esta bloqueado y 0 en caso contrario
//Modificado Noviembre 1997
integer niv,cont
cont = 0
intento:
if gi_nivel_usuario = 1 then//Selecciona si es un super usuario o no
	niv = 0
elseif gi_nivel_usuario = 2 then
	niv = 1
else
	 SELECT activacion_su.nivel    //Revisa el nivel actual de inscripción
         INTO :niv  
      FROM activacion_su  
		WHERE tipo_periodo = :gs_tipo_periodo ;
		
	if sqlca.sqlcode <> 0 then
		commit;
		if cont < 5 then
			cont++
			goto intento
		end if
		messagebox("Error de Comunicación","Error con la consulta de activación BD. Favor de intentar nuevamente", None!)						
		return 1			//Error en la comunicación con BD
	end if
	gi_nivel_usuario = 11 + niv
end if

commit;	
cont = 0

	
intento1:	
SELECT academicos.nivel  //Revisa el nivel del alumno
	 INTO :nivel  
	 FROM academicos  
WHERE academicos.cuenta = :numcta   ;
	
if sqlca.sqlcode <> 0 then
	commit;
	if cont < 5 then
		cont++
		goto intento1
	end if
	messagebox("Error de Comunicación","Error con la consulta de academicos BD. Favor de intentar nuevamente", None!)
	return 1			
end if

commit;
	
//Verifica si el alumno puede o no inscribirse dependiendo de su nivel	
if niv = 2 then
	
	return 0
elseif niv = 0 then
	//if nivel = 'L' Or nivel = 'T' then
	if nivel <> 'P' then 
		return 0
	else
		messagebox("No pertenece a Licenciatura ni a Técnico Superior Universitario","El alumno con número de cuenta "+string(numcta)+"-"+obten_digito(numcta)+" no pertenece a licenciatura ni técnico superior universitario. ~rNo puede inscribirse",stopsign!)			
		return 1
	end if
elseif niv = 1 then
	if nivel = 'P' then
		return 0
	else
		messagebox("No pertenece a Posgrado","El alumno con número de cuenta "+string(numcta)+" no pertenece a posgrado.~rNo puede inscribirse",StopSign!)
		return 1
	end if
end if
	

end function

public subroutine borrado_cuenta ();//Carlos Armando Melgoza Piña							Marzo 1997
//  Inicializa nuevamente el numero de cuenta en 0
dw_materias.reset()
dw_ext_h.reset()
dw_ext_h.triggerevent(constructor!)
limpia_comprobante()
dw_mat_pase_ingreso.Reset()
dw_pase_ingreso.Reset()
uo_nombre.dw_carreras.reset()
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
			commit;/*Si la materia no tiene prerrequisitos continua el proceso*/
			return 0
		elseif respuesta > 0 then
			commit;/*Si la materia tiene prerrequisitos se revisa si se cumplen*/
			for cont = 1 to dw_prerre.rowcount() // Revisión de los prerrequisitos en la tabla historico
				cvmat	=	dw_prerre.object.cve_prerreq[cont]
				enlace	=	dw_prerre.object.enlace[cont]
	intento:	 
				choose case nivel
						
				case 'P'
					SELECT historico_pos_re.cve_mat  
						INTO :cvmat  
					  FROM historico_pos_re
					WHERE ( historico_pos_re.cuenta = :cuenta ) AND  
								  ( historico_pos_re.cve_mat = :cvmat ) AND 
								  ( historico_pos_re.cve_carrera	=	:I_CarreraAlumno ) AND
								  ( historico_pos_re.cve_plan	=	:I_PlanAlumno ) AND
								  ( historico_pos_re.calificacion IN ("AC","6","7","8","9","10", "MB","B","S","E","RE"));						
						
				//case 'L'
			    case else 
					SELECT historico_re.cve_mat  
						INTO :cvmat  
					  FROM historico_re  
					WHERE ( historico_re.cuenta = :cuenta ) AND  
								  ( historico_re.cve_mat = :cvmat ) AND 
								  ( historico_re.cve_carrera	=	:I_CarreraAlumno ) AND
								  ( historico_re.cve_plan	=	:I_PlanAlumno ) AND
								  ( historico_re.calificacion IN ("AC","6","7","8","9","10", "MB","B","S","E","RE"));
//				case 'T'
//					SELECT historico_re.cve_mat  
//						INTO :cvmat  
//					  FROM historico_re  
//					WHERE ( historico_re.cuenta = :cuenta ) AND  
//								  ( historico_re.cve_mat = :cvmat ) AND 
//								  ( historico_re.cve_carrera	=	:I_CarreraAlumno ) AND
//								  ( historico_re.cve_plan	=	:I_PlanAlumno ) AND
//								  ( historico_re.calificacion IN ("AC","6","7","8","9","10", "MB","B","S","E","RE"));

				end choose

//Comentado Ene2014 SFF
//				if	nivel = 'L' then
//					SELECT historico_re.cve_mat  
//						INTO :cvmat  
//					  FROM historico_re  
//					WHERE ( historico_re.cuenta = :cuenta ) AND  
//								  ( historico_re.cve_mat = :cvmat ) AND 
//								  ( historico_re.cve_carrera	=	:I_CarreraAlumno ) AND
//								  ( historico_re.cve_plan	=	:I_PlanAlumno ) AND
//								  ( historico_re.calificacion IN ("AC","6","7","8","9","10", "MB","B","S","E","RE"));
//				else
//					SELECT historico_pos_re.cve_mat  
//						INTO :cvmat  
//					  FROM historico_pos_re
//					WHERE ( historico_pos_re.cuenta = :cuenta ) AND  
//								  ( historico_pos_re.cve_mat = :cvmat ) AND 
//								  ( historico_pos_re.cve_carrera	=	:I_CarreraAlumno ) AND
//								  ( historico_pos_re.cve_plan	=	:I_PlanAlumno ) AND
//								  ( historico_pos_re.calificacion IN ("AC","6","7","8","9","10", "MB","B","S","E","RE"));
//				end if
								  
				 revisa_rows()				  
				 
				  if sqlca.sqlcode = 100 then//Este if se ejecuta si el alumno no ha llevado esa materia
						commit;
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
							messagebox("Faltan prerequisitos", "El alumno con número de cuenta "+string(cuenta)+" no ha cursado todos ~rlos prerequisitos para la materia "+string(mat)+".",Exclamation!)
							return 1	
						end if
				  elseif sqlca.sqlcode = 0 then//Si el alumno ya curso la materia
					if enlace = 'O' then
						cumple	=	'S'
						cont++
					else 
						bandera = 1
					end if
				  elseif sqlca.sqlcode < 0 then
					commit;
					if c < 5 then
						c++
						goto intento
					end if
					messagebox("Error de Comunicación","Error con la consulta de historico BD. Favor de intentar nuevamente", None!)
					return 1		//			error bd						
				  end if
				  commit;
			next
		elseif respuesta < 0 then
				commit;
				messagebox("Error de Comunicación","Error con la consulta de prerequisitos BD. Favor de intentar nuevamente", None!)
				return 1//Error en la comunicación con la base de datos .
		end if	
		if (	(	bandera	=	0 and cumple	=	'S'	) or bandera	=	1	) then
			return 0
		else
			messagebox("Faltan prerequisitos", "El alumno con número de cuenta "+string(cuenta)+" no ha cursado todos ~rlos prerequisitos para la materia "+string(mat)+".",Exclamation!)
			return 1
		end if
	return 0

end function

public function integer revisa_cursada (long mat, long cta);//Carlos Armando Melgoza Piña 													Marzo 1997	
//Función que revisa si el alumno ya curso la materia y la aprobo
//Regresa 0 si no la ha cursado y 1 en caso contrario

int ren,cont
string cal
long revisa
cont = 0
intento:
revisa = dw_cursada.retrieve(cta,mat,I_CarreraAlumno,I_PlanAlumno)	//DW auxiliar en la revision de materias cursadas
commit;
if revisa = 0 then 
	return 0
elseif revisa > 0 then
	for ren = 1 to dw_cursada.rowcount()
		cal = dw_cursada.getitemstring(ren,"calificacion")
		if cal = "5" or cal = "BA" or cal = "NA" or cal = "05" or cal	=	"BJ" then
		ELSEIF cal = "IN" THEN 
			messagebox("Materia en curso","El alumno con número de cuenta "+string(cta)+"  tienen la materia  " + string(mat) + " en curso. ",Exclamation!) 
			return 1						
		else
			messagebox("Ya cursó la materia","El alumno con número de cuenta "+string(cta)+" ya curso la materia "+string(mat)+".",Exclamation!)
			return 1
		end if		
	next	
	return 0
elseif revisa < 0 then
	 if cont < 5 then
		cont++
		goto intento
	end if
	messagebox("Error de Comunicación","Error con la consulta de historico BD. Favor de intentar nuevamente", None!)
	return 1
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
			     ( mat_inscritas.cve_mat = :mat )   ;
				  
	  if sqlca.sqlcode = 100 then
		commit;
		return 0
	elseif sqlca.sqlcode = 0 then
		commit;
		messagebox("Materia ya inscrita","La materia "+string(mat)+" ya esta inscrita. Favor de verficar",Exclamation!)
		return 1
	else
		commit;
		if cont < 5 then
			cont ++
			goto intento
		end if
		messagebox("Error de Comunicación","Error con la consulta de materias_inscritas BD. Favor de intentar nuevamente", None!)
		return 1					
	  end if
				  

end function

public function integer gpo_existe (long mat, string gpo);//Carlos Armando Melgoza Piña								Marzo 1997
//Función que revisa si el grupo elegido existe
//Regresa 0 si existe o 1 en caso contrario

 //long año
 int/* per,*/cont, cond
 //periodo_actual_insc(per,año)
 
 intento:
 SELECT 	grupos.gpo,
 			grupos.cupo, grupos.tipo, grupos.inscritos, grupos.cve_asimilada, grupos.gpo_asimilado, 
			 grupos.cond_gpo
    INTO :gpo, :i_cupo, :i_tipo, :i_insc, :i_mat_a, :i_gpo_a, :cond 
    FROM grupos  
   WHERE ( grupos.cve_mat = :mat ) AND  
         ( grupos.gpo = :gpo ) AND  
         ( grupos.periodo = :G_per ) AND  
         ( grupos.anio = :G_anio )   ;
			
			revisa_rows()
			
	if sqlca.sqlcode = 0 then
		commit;
		if cond = 0 then 
			messagebox("Grupo cancelado","El grupo "+gpo+" no existe para la materia "+string(mat)+" .~Favor de verificar.",Exclamation!)
			return 1
		else
			return 0
		end if
	elseif sqlca.sqlcode = 100 then
			commit;
			messagebox("Grupo inexistente","El grupo "+gpo+" no existe para la materia "+string(mat)+" .~Favor de verificar.",Exclamation!)
			return 1
	else
		commit;
		if cont < 5 then// Realiza cinco intentos antes de indicar error
			cont ++
			goto intento
		end if
		if sqlca.sqlcode < 0 then
			messagebox("Error de comunicación","Error con la consulta de grupos BD. Favor de intentar nuevamente", None!)	
			return 1//Error en la comunicación  con BD
		end if
	end if



end function

public subroutine agrega_mat ();	//Carlos Armando Melgoza Piña 										Marzo 1997
//Función que inicializa los valores de número de cuenta, periodo, año y tipo de inscripción
int /*periodo, */ret,cont
//long año
char tipo

cont = 0
//periodo_actual_insc(periodo,año)

intento:
if gi_nivel_usuario > 10 then
	SELECT activacion_su.tipo_inscripcion  
     	    INTO :tipo_insc  
	 FROM activacion_su  
	 WHERE tipo_periodo = :gs_tipo_periodo; 
	 revisa_rows() //Verifica que el error no sea por renglon duplicado
	 if sqlca.sqlcode = 0 then	 
		commit;
	else
		commit;
		if cont < 5 then
			cont ++
			goto intento
		end if	
	end if
end if

	 
	if tipo_insc = 0 then
		tipo  = "I"
	elseif tipo_insc = 1 then
			tipo = "A" 
	end if
	dw_materias.setitem(dw_materias.rowcount(),"mat_inscritas_cuenta",long(uo_nombre.em_cuenta.text))//Agrega num. cta
	//Agrega tipo de inscripción
	dw_materias.setitem(dw_materias.rowcount(),"mat_inscritas_inscripcion",tipo)
	//Agrega periodo
	dw_materias.setitem(dw_materias.rowcount(),"mat_inscritas_periodo",G_per)
	dw_materias.setitem(dw_materias.rowcount(),"mat_inscritas_anio",G_anio)
	
	
//	if dw_materias.rowcount() > 1 then
//		dw_materias.setitem(dw_materias.rowcount(),"mat_inscritas_gpo","A")
//		dw_materias.setitem(dw_materias.rowcount(),"mat_inscritas_cve_mat",9093)
//		dw_materias.setitem(dw_materias.rowcount(),"mat_inscritas_inscripcion","I")
//	end if


end subroutine

public function integer revisa_hora_insc (long cta);//Función que compara la hora actual contra la hora de inscripción del alumno
// si la hora difiere por mas de 15 minutos la función regresa un 1  y no permite la inscripción 
//En caso contrario se regresa un 0
// Antonio Pica Ruiz 														Junio 2007	
//


Datetime  hora_in//Fecha es la hora actual y hora_in la hora en la que el alumno debe inscribirse
int cont,dias_diferencia, rev
long sec_dif,day_dif 

DateTime ldt_fecha
 
cont = 0
intento:
if gi_nivel_usuario = 1 then
		SELECT activacion.revision_hora_entrada, getdate()  
				INTO :rev, :ldt_fecha  
				FROM activacion  
				WHERE tipo_periodo = :gs_tipo_periodo;
elseif gi_nivel_usuario = 2 then
	rev = 0
else 
		SELECT activacion_su.revision_hora_entrada, getdate()  
				INTO :rev, :ldt_fecha  
				FROM activacion_su  
				WHERE tipo_periodo = :gs_tipo_periodo;
end if
if sqlca.sqlcode <> 0 then
	commit;
	if cont < 5 then
		cont++
		goto intento
	end if
	messagebox("Error de Comunicación","Error con la consulta de activación BD. Favor de intentar nuevamente", None!)
	return 1			
end if 	 
commit;	
if rev = 0 then //No se revisa horario	
	return 0
else
	cont = 0
	intento1:	  
	 
	SELECT horario_insc.hora_entrada  //Verifica la hora de inscripción del alumno
		INTO :hora_in  
		FROM horario_insc  
	WHERE horario_insc.cuenta = :cta   ;
	
	if sqlca.sqlcode <> 0 then
		commit;
		if cont < 5 then
			cont++
			goto intento1
		end if
		messagebox("Error de Comunicación","Error con la consulta de horario_insc BD. Favor de intentar nuevamente", None!)
		return 1							
	end if
	commit;	
	day_dif	=	daysafter(date(ldt_fecha),date(hora_in))
	if day_dif > 0 then
		goto modv
	elseif day_dif < 0 then
		return 0
	end if
	sec_dif = secondsafter(time(ldt_fecha),time(hora_in)) 
//Se suspende el bloqueo por invasor de horario, pero si enviarán un aviso...
	
	if sec_dif <= 1800  then //Verifica si el dia de inscripción del alumno es posterior a hoy si es así se bloquea al alumno
		return 0
	else
		modv:	  
		messagebox("Alumno Antes de Horario","El alumno con número de cuenta "+string(cta)+"-"+obten_digito(cta)+" no puede inscribirse~rantes de "+string(hora_in)+".",Stopsign!)
		return -1
		
//		cont = 0
//		modv:	  
//			UPDATE banderas  				//Bloqueo del alumno  si intenta inscribirse antes de tiempo
//				SET invasor_hora = 1  
//				WHERE banderas.cuenta = :cta   ;
//			if sqlca.sqlcode = 0 then 
//				commit;
//				messagebox("Alumno Bloqueado","El alumno con número de cuenta "+string(cta)+"-"+obten_digito(cta)+" no puede inscribirse~rantes de "+string(hora_in)+". El alumno ha quedado bloqueado.",Stopsign!)
//				openwithparm(w_invasor_hora,string(cta,"0000000000")+string(ldt_fecha,"hh:mm am/pm dd/mm/yyyy")+&
//								string(hora_in,"hh:mm am/pm dd/mm/yyyy"))
//				//open(w_invasor_hora)
//			else
//				commit;
//				cont++
//				if cont < 5 then
//					goto modv
//				else
//					messagebox("Error de Comunicación","Existe un problema con la base de datos favor de verificar el número de cuenta",None!)
//				end if
//			end if			
//		return 1 
		
	end if
end if

end function

public function integer gpo_lleno (long mat, string gpo);//  Carlos Armando Melgoza Piña  									Marzo 1997
//	Función que verifica si un grupo esta lleno o no 
// Regresa 0 si hay cupo y 1 en caso contrario
 long /*año,*/cup,insc
 int /*per,permite*/cont

if i_insc < i_cupo then return 0
 
 cont = 0
intento:
 if gi_nivel_usuario > 10 then   
 SELECT activacion_su.exceso_cupo  
	 INTO :exe_cupo  
   FROM activacion_su  
	WHERE tipo_periodo = :gs_tipo_periodo;
end if

if sqlca.sqlcode <> 0 then
	commit;
	if cont < 5 then
		cont++
		goto intento
	end if
	messagebox("Error de Comunicación","Error con la consulta de Activación BD. Favor de intentar nuevamente", None!)
	return 1 
end if
	
commit;

 if exe_cupo   = 0 then 
	messagebox("Grupo lleno","El grupo "+gpo+" de la materia "+string(mat)+" esta lleno.",Exclamation!)
	return 1//No se permite exceso de cupo
else
	return 0
end if
 
			

end function

public function integer revisa_horario (long mat, string gpo, long cta);//  Carlos Armando Melgoza Piña  									Marzo 1997
//  Función que revisa si no existe ninguna materia inscrita en ese horario 
//  Regresa 0 si no se enciman materias y 1 en caso contrario

Integer	li_resultado			// Oscar Sánchez, 13-Septiembre-2018. La validación de horario debe ser por medio del llamado a un SP
String		ls_mensaje			// Oscar Sánchez, 13-Septiembre-2018. La validación de horario debe ser por medio del llamado a un SP
Integer	li_materia_cruce	// Oscar Sánchez, 13-Septiembre-2018. La validación de horario debe ser por medio del llamado a un SP
String		ls_grupo_cruce		// Oscar Sánchez, 13-Septiembre-2018. La validación de horario debe ser por medio del llamado a un SP
String		ls_sesionado
int d,h, cont,c,verif
//long año
//int per
//periodo_actual_insc(per,año)

verif = dw_horario_mat.retrieve(mat,gpo,G_per,g_anio)

// Oscar Sánchez, 13-Septiembre-2018. La validación de horario debe ser por medio del llamado a un SP
if gi_nivel_usuario > 10 then
	SELECT activacion_su.materias_encimadas  
				INTO :mat_enci
		FROM activacion_su  
		WHERE tipo_periodo = :gs_tipo_periodo;
end if

if mat_enci  = 1 then // Se permite encimar
	return 0
else
	
	IF SQLCA.dbms = 'OLE DB' THEN
		DECLARE  sp_validacion_materias_encimadas_sqlserver PROCEDURE FOR sp_srl_validacion_materias_enc
		@CUENTA				= :cta,
		@MATERIA				= :mat,
		@GRUPO					= :gpo,
		@INVOCA_MOVIL		= 1,
		@RESULTADO			= :li_resultado OUTPUT,
		@MENSAJE				= :ls_mensaje OUTPUT,
		@MATERIA_CRUCE	= :li_materia_cruce OUTPUT,
		@GRUPO_CRUCE		= :ls_grupo_cruce OUTPUT;
		
		EXECUTE sp_validacion_materias_encimadas_sqlserver;
		
		FETCH sp_validacion_materias_encimadas_sqlserver INTO :li_resultado, :ls_mensaje, :li_materia_cruce, :ls_grupo_cruce, :ls_sesionado;
		
		CLOSE sp_validacion_materias_encimadas_sqlserver;
	ELSE
		DECLARE  sp_validacion_materias_encimadas PROCEDURE FOR sp_srl_validacion_materias_enc
		@CUENTA				= :cta,
		@MATERIA				= :mat,
		@GRUPO					= :gpo,
		@RESULTADO			= :li_resultado OUTPUT,
		@MENSAJE				= :ls_mensaje OUTPUT,
		@MATERIA_CRUCE	= :li_materia_cruce OUTPUT,
		@GRUPO_CRUCE		= :ls_grupo_cruce OUTPUT;
		
		EXECUTE sp_validacion_materias_encimadas;
		
		FETCH sp_validacion_materias_encimadas INTO :li_resultado, :ls_mensaje, :li_materia_cruce, :ls_grupo_cruce, :ls_sesionado;
		
		CLOSE sp_validacion_materias_encimadas;
	END IF
	
	IF	li_resultado <> 0 THEN
		MessageBox ("El horario se encima", "El alumno con número de cuenta "+string(cta)+" no puede inscribir la materia " + String (mat) + " grupo '" + gpo + "'. ~rTiene inscrita la materia " + String (li_materia_cruce) + " grupo '" + ls_grupo_cruce + "' en horario similar al de la materia que se quiere inscribir.",Exclamation!)
		Return 1
	END IF
	Commit;
end if

Return 0
// Oscar Sánchez, 13-Septiembre-2018. La validación de horario debe ser por medio del llamado a un SP (FIN de la modificación)


/*
c = 0
intento1:
	verif = dw_horario_mat.retrieve(mat,gpo,G_per,g_anio)
	if verif >= 0 then
		for cont = 1 to dw_horario_mat.rowcount()
			d  = dw_horario_mat.getitemnumber(cont,"cve_dia")
			d++
			for h = dw_horario_mat.getitemnumber(cont,"hora_inicio") to  dw_horario_mat.getitemnumber(cont,"hora_final") - 1
				if hora[h - 6].dia[d]  = 1 then
				 intento:	
					if gi_nivel_usuario > 10 then
	  					SELECT activacion_su.materias_encimadas  
		    	    				INTO :mat_enci
							FROM activacion_su  
							WHERE tipo_periodo = :gs_tipo_periodo;
					end if
	 				if sqlca.sqlcode <> 0 then
						commit;
						if c < 5 then
							c++
							goto intento
						end if
						messagebox("Error de Comunicación","Error con la consulta de activacion BD. Favor de intentar nuevamente", None!)
						return 1
					end if
					commit;
					if mat_enci  = 1 then // Se permite encimar
						return 0
					else
						messagebox("El horario se encima", "El alumno con número de cuenta "+string(cta)+" no puede inscribir esta materia. ~rTiene otra materia inscrita en este horario.",Exclamation!)
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
		messagebox("Error de Comunicación","Error con la consulta de horarios BD. Favor de intentar nuevamente", None!)
		return 1
	end if
*/
end function

public function integer borra_mat_insc (long cta, long mat, string gpo);//Carlos Armando Melgoza Piña								Abril 1997
//Función que borra una materia  de materias_inscritas
//Regresa 0 si se efectua la actualización con exito o 1 en caso contrario
//2009-11-05: Se añadió el messagebox para enviar el error
integer li_codigo_sql
string	ls_mensaje_sql

  DELETE FROM mat_inscritas  
  WHERE ( mat_inscritas.cuenta = :cta ) AND  
				 ( mat_inscritas.cve_mat = :mat );

li_codigo_sql = sqlca.sqlcode
ls_mensaje_sql = sqlca.SqlErrText

if sqlca.sqlcode = 0 then
	commit;
	return 0
else
	rollback;
	MessageBox("Error al eliminar la materia ["+string(mat)+"]",ls_mensaje_sql,StopSign!)
	this.triggerevent("inicia_proceso")
	return 1
end if


end function

public function integer revisa_per_insc_mat (long cta, long mat, string gpo);//Carlos Armando Melgoza Piña										Abril 1997
//Función que revisa si la materia a dar de baja pertenece a este periodo de inscripciones
//Devuelve 0 si puede darse de baja o 1 en caso contrario
int permit,cont, ren
char insc
cont = 0
if gi_nivel_usuario < 10 then
	permit = i_baj_per_dis
else
intento:
	SELECT activacion_su.tipo_inscripcion,   
    	activacion_su.bajas_periodo_distinto  
	INTO :tipo_insc,   
   	:permit  
	FROM activacion_su  
	WHERE tipo_periodo = :gs_tipo_periodo;
	if sqlca.sqlcode <> 0 then
		commit;
		if cont < 5 then
			cont++
			goto intento
		end if
		messagebox("Error de Comunicación","Error con la consulta de activación BD. Favor de intentar nuevamente", None!)
		return 1			
	end if
	commit;
end if 
if permit = 1 then 
	return 0		
else
	ren = dw_materias.Find("mat_inscritas_cve_mat = "+string(mat)+" AND mat_inscritas_gpo = '"+gpo+"'",&
			1,dw_materias.RowCount())
	insc = dw_materias.GetItemString(ren,"mat_inscritas_inscripcion")
	if tipo_insc = 0 and insc = "I" then //Si la materia es de inscripción normal y el periodo es igual
		return 0
	elseif tipo_insc = 1 and insc = "A" then //Si la materia es de inscripción en altas y el periodo es igual
		return 0
	else
		messagebox("No se puede dar de baja","La materia "+string(mat)+" no se puede dar de baja en este periodo de inscripciones",Exclamation!)			
		return 1
	end if		
end if


end function

public function integer obten_carr_plan (long cta, ref long cvcarrera, ref long cvplan);//Carlos Armando Melgoza Piña								Marzo 1997
//Función que consulta y regresa los valores de la clave del plan y la carrera
//Regresa 0 si el proceso se realiza adecuadamente
int cont
cont = 0
intento:  
  SELECT academicos.cve_carrera,   
	      academicos.cve_plan  
	INTO	:cvcarrera,
			:cvplan
	FROM	academicos 
	WHERE	( academicos.cuenta = :cta ) ;
	 
	 if sqlca.sqlcode <> 0 then
		commit;
		if cont < 10 then
			cont++
			goto intento
		end if
		messagebox("Error de Comunicación","Error con la consulta de ACADEMICOS BD. Favor de intentar nuevamente", None!)
		return 1//Error en la comunicación con BD
	else
		return 0
	end if

end function

public function integer revisa_impresiones ();//  Carlos Armando Melgoza Piña  									Marzo 1997
//	Función que verifica si esta habilitada la opción de imprimir comprobantes
// Regresa 0 si hay  impresiones y 1 en caso contrario
 int cont,permite

 cont = 0
 
 intento:
 if gi_nivel_usuario < 10 then
//   SELECT activacion.imprime_comprobantes  
//    INTO :permite  
//    FROM activacion  
//WHERE tipo_periodo = :gs_tipo_periodo;
	permite = i_imp_com
else 
  SELECT activacion_su.imprime_comprobantes  
    INTO :permite  
    FROM activacion_su  
	 WHERE tipo_periodo = :gs_tipo_periodo;
end if

if sqlca.sqlcode <> 0 then
	commit;
	if cont < 5 then
		cont++
		goto intento
	end if
	messagebox("Error de Comunicación","Error con la consulta de Activación BD. Favor de intentar nuevamente", None!)
	return 1 
end if

commit;

if permite = 0 then
	messagebox("No se puede imprimir","En este periodo no se puede realizar la impresión.",Exclamation!)
	return 1
elseif permite = 1 then
	return 0
end if
end function

public function long pert_plan_est (long mat, long carr, long plan);//Revisa plan
//Carlos Armando Melgoza Piña
//Mayo 97
//Regresa 1 si pertenece o 0 en caso contrario
long mat2
int cont
cont = 0

intento: cont ++
if usuario	=	"inscrposg" or nivel = 'P' then
	 SELECT mat_prerreq_pos.cve_mat  
		 INTO :mat2  
		 FROM mat_prerreq_pos  
		WHERE ( mat_prerreq_pos.cve_mat = :mat ) AND  
				( mat_prerreq_pos.cve_carrera = :carr  ) AND  
				( mat_prerreq_pos.cve_plan = :plan  )   ;			
else
	 SELECT mat_prerrequisito.cve_mat  
		 INTO :mat2  
		 FROM mat_prerrequisito  
		WHERE ( mat_prerrequisito.cve_mat = :mat ) AND  
				( mat_prerrequisito.cve_carrera = :carr  ) AND  
				( mat_prerrequisito.cve_plan = :plan  )   ;		
end if
			revisa_rows()
			
			if sqlca.sqlcode = 0 then 
				commit;
				return 0
			elseif sqlca.sqlcode =100 then
				commit;
				messagebox("La materia no pertenece al plan de estudios","La materia "+string(mat)+" no pertenece al plan de estudios.",Exclamation!)
				return 1
			else 
				commit;
				if cont < 5 then
					goto intento
				else					
					messagebox("Error de Comunicación","Error con la consulta de pertenece a plan estudios BD. Favor de intentar nuevamente",None!)
					return 1 
				end if
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
   WHERE area_mat.cve_mat = :cvmat   ;//Revisa el area de la materia a inscribir
	
	revisa_rows()		//verifica que el error no se deba a exceso de renglones
	
	if sqlca.sqlcode = 0 then
		commit;
		choose case area		//Si la materia es de integración 
			case 2201 to 2205
				cont = 0				
				return 1
			case else
				return 0
		end choose
	elseif sqlca.sqlcode = 100 then
		commit;
		return 0
	else
		commit;
		if cont < 5 then
			cont++
			goto intento
		end if
		messagebox("Error de Comunicación","Error con la consulta de area_mat BD. Favor de intentar nuevamente", None!)
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
	  			  ( plan_estudios.cve_plan = :I_PlanAlumno )   ;
					 
				 revisa_rows()//verificacion de error
				 
	 if sqlca.sqlcode = 0 then
			commit;			
			cont = 0
	intento1:		
			SELECT area_mat.cve_mat  
		   		 INTO :I_cvss  
			    FROM area_mat  
		   WHERE area_mat.cve_area = :cvss   ;
		
			revisa_rows() //verificacion de error
		
			if sqlca.sqlcode = 0 then
				commit;
				return 0 
			else
				commit;
				if cont < 5 then
					cont ++
					goto intento1
				end if
				messagebox("Error de Comunicación","Error con la consulta de area_materia BD (Obtención de SS). Favor de intentar nuevamente", None!)
				return 1		//			error bd						
			end if	
	 else
		commit;
		if cont < 5 then
			cont ++
			goto intento
		end if
		messagebox("Error de Comunicación","Error con la consulta de Plan de Estudios BD (Obtención de SS). Favor de intentar nuevamente", None!)
		return 1		//			error bd		
	 end if 
return 0
end function

public subroutine encuentra_salon (long cvmat, ref integer row);int ren, col,cont
cont = 0
for col = 2 to 8	
	for ren = 1 to 15
		if col < 9 then
			if dw_ext_h.getitemstring(ren,col) = string(cvmat) then
				if cont > 0 then
					row = dw_comprobante.insertrow(0)
				end if
				dw_comprobante.setitem(row,"cve_salon", hora[ren].salon[col - 1])			
				dw_comprobante.setitem(row,"cve_dia",col - 1)				
				cont ++
				col ++
				ren = 1
			end if
		end if
	next
next


end subroutine

public subroutine limpia_comprobante ();//Función que borra los textos del comprobante de inscripción y efectua un reset a los campos
//CAMP Enero 1998
int col,ren

dw_comprobante.object.cuenta.text	 =	 ""
dw_comprobante.object.digito.text	 =	 ""
dw_comprobante.object.periodo.text	 =	 ""
dw_comprobante.object.year.text		 =	 ""
dw_comprobante.object.nombre.text	 =	 ""
dw_comprobante.object.apaterno.text =	 ""
dw_comprobante.object.amaterno.text =	 ""
dw_comprobante.object.carrera.text	  =	 ""
dw_comprobante.object.plan.text 		=	 ""

dw_comprobante.reset()
//for ren = 1 to 15
//	for col = 1 to 7
//		dia_h[col].hora[ren].text = ""
//	next
//next

dw_comprobante.object.h1.text		=	""
dw_comprobante.object.d1.text		=	""
dw_comprobante.object.l1.text		=	""
dw_comprobante.object.ma1.text	=	""
dw_comprobante.object.mi1.text	=	""
dw_comprobante.object.j1.text		=	""
dw_comprobante.object.v1.text		=	""
dw_comprobante.object.s1.text		=	""


dw_comprobante.object.h2.text		=	""
dw_comprobante.object.d2.text		=	""
dw_comprobante.object.l2.text		=	""
dw_comprobante.object.ma2.text		=	""
dw_comprobante.object.mi2.text		=	""
dw_comprobante.object.j2.text		=	""
dw_comprobante.object.v2.text		=	""
dw_comprobante.object.s2.text		=	""

dw_comprobante.object.h3.text		=	""
dw_comprobante.object.d3.text		=	""
dw_comprobante.object.l3.text		=	""
dw_comprobante.object.ma3.text		=	""
dw_comprobante.object.mi3.text		=	""
dw_comprobante.object.j3.text		=	""
dw_comprobante.object.v3.text		=	""
dw_comprobante.object.s3.text		=	""

dw_comprobante.object.h4.text		=	""
dw_comprobante.object.d4.text		=	""
dw_comprobante.object.l4.text		=	""
dw_comprobante.object.ma4.text		=	""
dw_comprobante.object.mi4.text		=	""
dw_comprobante.object.j4.text		=	""
dw_comprobante.object.v4.text		=	""
dw_comprobante.object.s4.text		=	""

dw_comprobante.object.h5.text		=	""
dw_comprobante.object.d5.text		=	""
dw_comprobante.object.l5.text		=	""
dw_comprobante.object.ma5.text		=	""
dw_comprobante.object.mi5.text		=	""
dw_comprobante.object.j5.text		=	""
dw_comprobante.object.v5.text		=	""
dw_comprobante.object.s5.text		=	""

dw_comprobante.object.h6.text		=	""
dw_comprobante.object.d6.text		=	""
dw_comprobante.object.l6.text		=	""
dw_comprobante.object.ma6.text		=	""
dw_comprobante.object.mi6.text		=	""
dw_comprobante.object.j6.text		=	""
dw_comprobante.object.v6.text		=	""
dw_comprobante.object.s6.text		=	""

dw_comprobante.object.h7.text		=	""
dw_comprobante.object.d7.text		=	""
dw_comprobante.object.l7.text		=	""
dw_comprobante.object.ma7.text		=	""
dw_comprobante.object.mi7.text		=	""
dw_comprobante.object.j7.text		=	""
dw_comprobante.object.v7.text		=	""
dw_comprobante.object.s7.text		=	""

dw_comprobante.object.h8.text		=	""
dw_comprobante.object.d8.text		=	""
dw_comprobante.object.l8.text		=	""
dw_comprobante.object.ma8.text		=	""
dw_comprobante.object.mi8.text		=	""
dw_comprobante.object.j8.text		=	""
dw_comprobante.object.v8.text		=	""
dw_comprobante.object.s8.text		=	""

dw_comprobante.object.h9.text		=	""
dw_comprobante.object.d9.text		=	""
dw_comprobante.object.l9.text		=	""
dw_comprobante.object.ma9.text		=	""
dw_comprobante.object.mi9.text		=	""
dw_comprobante.object.j9.text		=	""
dw_comprobante.object.v9.text		=	""
dw_comprobante.object.s9.text		=	""

dw_comprobante.object.h10.text		=	""
dw_comprobante.object.d10.text		=	""
dw_comprobante.object.l10.text		=	""
dw_comprobante.object.ma10.text		=	""
dw_comprobante.object.mi10.text	=	""
dw_comprobante.object.j10.text		=	""
dw_comprobante.object.v10.text		=	""
dw_comprobante.object.s10.text		=	""

dw_comprobante.object.h11.text		=	""
dw_comprobante.object.d11.text		=	""
dw_comprobante.object.l11.text		=	""
dw_comprobante.object.ma11.text		=	""
dw_comprobante.object.mi11.text		=	""
dw_comprobante.object.j11.text		=	""
dw_comprobante.object.v11.text		=	""
dw_comprobante.object.s11.text		=	""

dw_comprobante.object.h12.text		=	""
dw_comprobante.object.d12.text		=	""
dw_comprobante.object.l12.text		=	""
dw_comprobante.object.ma12.text		=	""
dw_comprobante.object.mi12.text		=	""
dw_comprobante.object.j12.text		=	""
dw_comprobante.object.v12.text		=	""
dw_comprobante.object.s12.text		=	""

dw_comprobante.object.h13.text		=	""
dw_comprobante.object.d13.text		=	""
dw_comprobante.object.l13.text		=	""
dw_comprobante.object.ma13.text		=	""
dw_comprobante.object.mi13.text		=	""
dw_comprobante.object.j13.text		=	""
dw_comprobante.object.v13.text		=	""
dw_comprobante.object.s13.text		=	""

dw_comprobante.object.h14.text		=	""
dw_comprobante.object.d14.text		=	""
dw_comprobante.object.l14.text		=	""
dw_comprobante.object.ma14.text		=	""
dw_comprobante.object.mi14.text		=	""
dw_comprobante.object.j14.text		=	""
dw_comprobante.object.v14.text		=	""
dw_comprobante.object.s14.text		=	""

dw_comprobante.object.h15.text		=	""
dw_comprobante.object.d15.text		=	""
dw_comprobante.object.l15.text		=	""
dw_comprobante.object.ma15.text		=	""
dw_comprobante.object.mi15.text		=	""
dw_comprobante.object.j15.text		=	""
dw_comprobante.object.v15.text		=	""
dw_comprobante.object.s15.text		=	""
end subroutine

public subroutine fill_horario ();//Función que llena el horario en el comprobante de inscripción 
//Enero 1998	
//CAMP


dw_comprobante.object.h1.text	=	dw_ext_h.getitemstring(1,1)
dw_comprobante.object.d1.text	=	dw_ext_h.getitemstring(1,2)
dw_comprobante.object.l1.text		=	dw_ext_h.getitemstring(1,3)
dw_comprobante.object.ma1.text	=	dw_ext_h.getitemstring(1,4)
//dw_comprobante.object.mi1.text	=	dw_ext_h.getitemstring(1,5)
dw_comprobante.object.mi1.text	=	LEFT(dw_ext_h.getitemstring(1,5),  POS(dw_ext_h.getitemstring(1,5), ' '))
dw_comprobante.object.j1.text		=	dw_ext_h.getitemstring(1,6)
dw_comprobante.object.v1.text		=	dw_ext_h.getitemstring(1,7)
dw_comprobante.object.s1.text	=	dw_ext_h.getitemstring(1,8)

dw_comprobante.object.h2.text	=	dw_ext_h.getitemstring(2,1)
dw_comprobante.object.d2.text	=	dw_ext_h.getitemstring(2,2)
dw_comprobante.object.l2.text		=	dw_ext_h.getitemstring(2,3)
dw_comprobante.object.ma2.text	=	dw_ext_h.getitemstring(2,4)
//dw_comprobante.object.mi2.text	=	dw_ext_h.getitemstring(2,5)
dw_comprobante.object.mi2.text	=	LEFT(dw_ext_h.getitemstring(2,5),  POS(dw_ext_h.getitemstring(2,5), ' '))
dw_comprobante.object.j2.text		=	dw_ext_h.getitemstring(2,6)
dw_comprobante.object.v2.text		=	dw_ext_h.getitemstring(2,7)
dw_comprobante.object.s2.text	=	dw_ext_h.getitemstring(2,8)

dw_comprobante.object.h3.text	=	dw_ext_h.getitemstring(3,1)
dw_comprobante.object.d3.text	=	dw_ext_h.getitemstring(3,2)
dw_comprobante.object.l3.text		=	dw_ext_h.getitemstring(3,3)
dw_comprobante.object.ma3.text	=	dw_ext_h.getitemstring(3,4)
//dw_comprobante.object.mi3.text	=	dw_ext_h.getitemstring(3,5)
dw_comprobante.object.mi3.text	=	LEFT(dw_ext_h.getitemstring(3,5),  POS(dw_ext_h.getitemstring(3,5), ' '))
dw_comprobante.object.j3.text		=	dw_ext_h.getitemstring(3,6)
dw_comprobante.object.v3.text		=	dw_ext_h.getitemstring(3,7)
dw_comprobante.object.s3.text	=	dw_ext_h.getitemstring(3,8)

dw_comprobante.object.h4.text	=	dw_ext_h.getitemstring(4,1)
dw_comprobante.object.d4.text	=	dw_ext_h.getitemstring(4,2)
dw_comprobante.object.l4.text		=	dw_ext_h.getitemstring(4,3)
dw_comprobante.object.ma4.text	=	dw_ext_h.getitemstring(4,4)
//dw_comprobante.object.mi4.text	=	dw_ext_h.getitemstring(4,5)
dw_comprobante.object.mi4.text	=	LEFT(dw_ext_h.getitemstring(4,5),  POS(dw_ext_h.getitemstring(4,5), ' '))
dw_comprobante.object.j4.text		=	dw_ext_h.getitemstring(4,6)
dw_comprobante.object.v4.text		=	dw_ext_h.getitemstring(4,7)
dw_comprobante.object.s4.text	=	dw_ext_h.getitemstring(4,8)

dw_comprobante.object.h5.text	=	dw_ext_h.getitemstring(5,1)
dw_comprobante.object.d5.text	=	dw_ext_h.getitemstring(5,2)
dw_comprobante.object.l5.text		=	dw_ext_h.getitemstring(5,3)
dw_comprobante.object.ma5.text	=	dw_ext_h.getitemstring(5,4)
//dw_comprobante.object.mi5.text	=	dw_ext_h.getitemstring(5,5)
dw_comprobante.object.mi5.text	=	LEFT(dw_ext_h.getitemstring(5,5),  POS(dw_ext_h.getitemstring(5,5), ' '))
dw_comprobante.object.j5.text		=	dw_ext_h.getitemstring(5,6)
dw_comprobante.object.v5.text		=	dw_ext_h.getitemstring(5,7)
dw_comprobante.object.s5.text	=	dw_ext_h.getitemstring(5,8)

dw_comprobante.object.h6.text	=	dw_ext_h.getitemstring(6,1)
dw_comprobante.object.d6.text	=	dw_ext_h.getitemstring(6,2)
dw_comprobante.object.l6.text		=	dw_ext_h.getitemstring(6,3)
dw_comprobante.object.ma6.text	=	dw_ext_h.getitemstring(6,4)
//dw_comprobante.object.mi6.text	=	dw_ext_h.getitemstring(6,5)
dw_comprobante.object.mi6.text	=	LEFT(dw_ext_h.getitemstring(6,5),  POS(dw_ext_h.getitemstring(6,5), ' '))
dw_comprobante.object.j6.text		=	dw_ext_h.getitemstring(6,6)
dw_comprobante.object.v6.text		=	dw_ext_h.getitemstring(6,7)
dw_comprobante.object.s6.text	=	dw_ext_h.getitemstring(6,8)

dw_comprobante.object.h7.text	=	dw_ext_h.getitemstring(7,1)
dw_comprobante.object.d7.text	=	dw_ext_h.getitemstring(7,2)
dw_comprobante.object.l7.text		=	dw_ext_h.getitemstring(7,3)
dw_comprobante.object.ma7.text	=	dw_ext_h.getitemstring(7,4)
//dw_comprobante.object.mi7.text	=	dw_ext_h.getitemstring(7,5)
dw_comprobante.object.mi7.text	=	LEFT(dw_ext_h.getitemstring(7,5),  POS(dw_ext_h.getitemstring(7,5), ' '))
dw_comprobante.object.j7.text		=	dw_ext_h.getitemstring(7,6)
dw_comprobante.object.v7.text		=	dw_ext_h.getitemstring(7,7)
dw_comprobante.object.s7.text	=	dw_ext_h.getitemstring(7,8)

dw_comprobante.object.h8.text	=	dw_ext_h.getitemstring(8,1)
dw_comprobante.object.d8.text	=	dw_ext_h.getitemstring(8,2)
dw_comprobante.object.l8.text		=	dw_ext_h.getitemstring(8,3)
dw_comprobante.object.ma8.text	=	dw_ext_h.getitemstring(8,4)
//dw_comprobante.object.mi8.text	=	dw_ext_h.getitemstring(8,5)
dw_comprobante.object.mi8.text	=	LEFT(dw_ext_h.getitemstring(8,5),  POS(dw_ext_h.getitemstring(8,5), ' '))
dw_comprobante.object.j8.text		=	dw_ext_h.getitemstring(8,6)
dw_comprobante.object.v8.text		=	dw_ext_h.getitemstring(8,7)
dw_comprobante.object.s8.text	=	dw_ext_h.getitemstring(8,8)

dw_comprobante.object.h9.text	=	dw_ext_h.getitemstring(9,1)
dw_comprobante.object.d9.text	=	dw_ext_h.getitemstring(9,2)
dw_comprobante.object.l9.text		=	dw_ext_h.getitemstring(9,3)
dw_comprobante.object.ma9.text	=	dw_ext_h.getitemstring(9,4)
//dw_comprobante.object.mi9.text	=	dw_ext_h.getitemstring(9,5)
dw_comprobante.object.mi9.text	=	LEFT(dw_ext_h.getitemstring(9,5),  POS(dw_ext_h.getitemstring(9,5), ' '))
dw_comprobante.object.j9.text		=	dw_ext_h.getitemstring(9,6)
dw_comprobante.object.v9.text		=	dw_ext_h.getitemstring(9,7)
dw_comprobante.object.s9.text	=	dw_ext_h.getitemstring(9,8)

dw_comprobante.object.h10.text	=	dw_ext_h.getitemstring(10,1)
dw_comprobante.object.d10.text	=	dw_ext_h.getitemstring(10,2)
dw_comprobante.object.l10.text		=	dw_ext_h.getitemstring(10,3)
dw_comprobante.object.ma10.text	=	dw_ext_h.getitemstring(10,4)
//dw_comprobante.object.mi10.text	=	dw_ext_h.getitemstring(10,5)
dw_comprobante.object.mi10.text	=	LEFT(dw_ext_h.getitemstring(10,5),  POS(dw_ext_h.getitemstring(10,5), ' '))
dw_comprobante.object.j10.text		=	dw_ext_h.getitemstring(10,6)
dw_comprobante.object.v10.text		=	dw_ext_h.getitemstring(10,7)
dw_comprobante.object.s10.text	=	dw_ext_h.getitemstring(10,8)

dw_comprobante.object.h11.text	=	dw_ext_h.getitemstring(11,1)
dw_comprobante.object.d11.text	=	dw_ext_h.getitemstring(11,2)
dw_comprobante.object.l11.text		=	dw_ext_h.getitemstring(11,3)
dw_comprobante.object.ma11.text	=	dw_ext_h.getitemstring(11,4)
//dw_comprobante.object.mi11.text	=	dw_ext_h.getitemstring(11,5)
dw_comprobante.object.mi11.text	=	LEFT(dw_ext_h.getitemstring(11,5),  POS(dw_ext_h.getitemstring(11,5), ' '))
dw_comprobante.object.j11.text		=	dw_ext_h.getitemstring(11,6)
dw_comprobante.object.v11.text		=	dw_ext_h.getitemstring(11,7)
dw_comprobante.object.s11.text	=	dw_ext_h.getitemstring(11,8)

dw_comprobante.object.h12.text	=	dw_ext_h.getitemstring(12,1)
dw_comprobante.object.d12.text	=	dw_ext_h.getitemstring(12,2)
dw_comprobante.object.l12.text		=	dw_ext_h.getitemstring(12,3)
dw_comprobante.object.ma12.text	=	dw_ext_h.getitemstring(12,4)
//dw_comprobante.object.mi12.text	=	dw_ext_h.getitemstring(12,5)
dw_comprobante.object.mi12.text	=	LEFT(dw_ext_h.getitemstring(12,5),  POS(dw_ext_h.getitemstring(12,5), ' '))
dw_comprobante.object.j12.text		=	dw_ext_h.getitemstring(12,6)
dw_comprobante.object.v12.text		=	dw_ext_h.getitemstring(12,7)
dw_comprobante.object.s12.text	=	dw_ext_h.getitemstring(12,8)

dw_comprobante.object.h13.text	=	dw_ext_h.getitemstring(13,1)
dw_comprobante.object.d13.text	=	dw_ext_h.getitemstring(13,2)
dw_comprobante.object.l13	.text	=	dw_ext_h.getitemstring(13,3)
dw_comprobante.object.ma13.text	=	dw_ext_h.getitemstring(13,4)
//dw_comprobante.object.mi13.text	=	dw_ext_h.getitemstring(13,5)
dw_comprobante.object.mi13.text	=	LEFT(dw_ext_h.getitemstring(13,5),  POS(dw_ext_h.getitemstring(13,5), ' '))
dw_comprobante.object.j13.text		=	dw_ext_h.getitemstring(13,6)
dw_comprobante.object.v13.text		=	dw_ext_h.getitemstring(13,7)
dw_comprobante.object.s13.text	=	dw_ext_h.getitemstring(13,8)

dw_comprobante.object.h14.text	=	dw_ext_h.getitemstring(14,1)
dw_comprobante.object.d14.text	=	dw_ext_h.getitemstring(14,2)
dw_comprobante.object.l14.text		=	dw_ext_h.getitemstring(14,3)
dw_comprobante.object.ma14.text	=	dw_ext_h.getitemstring(14,4)
//dw_comprobante.object.mi14.text	=	dw_ext_h.getitemstring(14,5)
dw_comprobante.object.mi14.text	=	LEFT(dw_ext_h.getitemstring(14,5),  POS(dw_ext_h.getitemstring(14,5), ' '))
dw_comprobante.object.j14.text		=	dw_ext_h.getitemstring(14,6)
dw_comprobante.object.v14.text		=	dw_ext_h.getitemstring(14,7)
dw_comprobante.object.s14.text	=	dw_ext_h.getitemstring(14,8)

dw_comprobante.object.h15.text	=	dw_ext_h.getitemstring(15,1)
dw_comprobante.object.d15.text	=	dw_ext_h.getitemstring(15,2)
dw_comprobante.object.l15.text		=	dw_ext_h.getitemstring(15,3)
dw_comprobante.object.ma15.text	=	dw_ext_h.getitemstring(15,4)
//dw_comprobante.object.mi15.text	=	dw_ext_h.getitemstring(15,5)
dw_comprobante.object.mi15.text	=	LEFT(dw_ext_h.getitemstring(15,5),  POS(dw_ext_h.getitemstring(15,5), ' '))
dw_comprobante.object.j15.text		=	dw_ext_h.getitemstring(15,6)
dw_comprobante.object.v15.text		=	dw_ext_h.getitemstring(15,7)
dw_comprobante.object.s15.text	=	dw_ext_h.getitemstring(15,8)

end subroutine

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

public function integer error (string que);if SQLCA.sqlcode <> 0 then
	Messagebox(que,SQLCA.sqlerrtext)
end if 
return 1
end function

public function integer revisa_incorp_sep ();//Funcion que verifica si una carrera de determinado plan esta incorporado a la SEP
//Se utiliza principalmente para detectar posgrados
//24-III-1998 CAMP

//integer incsep
//
//  SELECT plan_estudios.incorporado_sep  
//    INTO :incsep  
//    FROM plan_estudios  
//   WHERE ( plan_estudios.cve_carrera = :I_CarreraAlumno ) AND  
//         ( plan_estudios.cve_plan = :I_PlanAlumno )   ;
//			
//		revisa_rows()
//
//if sqlca.sqlcode = 0 then
//	if incsep	=	1 then
//		incorp_sep	= 'S'	
//		return 0
//	else
//		incorp_sep	= 'N'
		return 0
//	end if
//else
//	messagebox("ERROR en PLAN_ESTUDIOS","Hubo un error al revisar si la carrera esta INCORPORADA a SEP "+sqlca.sqlerrtext,Stopsign! )
//	return 1
//end if

end function

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
//    FROM activacion  ;

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
			revisa_grupos_bloqueados, 
			revisa_proyecto_ss
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
			:i_revisa_grupos_bloqueados, 
			:ie_revisa_proyecto_ss
FROM		activacion
WHERE tipo_periodo = :gs_tipo_periodo;

if sqlca.sqlcode = 0 then
	if gi_nivel_usuario = 2 then
		SELECT mensaje 
		INTO :i_men
		FROM activacion_su
		WHERE tipo_periodo = :gs_tipo_periodo;
		if sqlca.sqlcode <> 0 then
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

public subroutine obten_nomb_profesor (long cve_mat, string gpo);//Función que recibe la clave de la materia y el grupo
//Si la materia esta asimilada regresa el nombre del profesor con quien se cursaria la materia
//Regresa el nombre del profesor
//CAMP Mayo 1998	DkWf
//Modificacion: Enero 5, 1999: Se elimina el query erroneo y se deja el nuevo

string nombre 
		
  SELECT DISTINCT dbo.profesor.nombre_completo  
    INTO :nombre  
    FROM dbo.grupos,        
         dbo.profesor  
	WHERE
		( dbo.profesor.cve_profesor = dbo.grupos.cve_profesor ) and
		( ( ( dbo.grupos.cve_mat = :cve_mat ) and
			( dbo.grupos.gpo = :gpo ) or
			( dbo.grupos.cve_asimilada = :cve_mat ) and
			( dbo.grupos.gpo_asimilado = :gpo ) ) and
			( dbo.grupos.anio = :g_anio ) and
			( dbo.grupos.periodo = :g_per) );	
				
open(w_profesor)

//w_profesor.x	=	x+550//+xpos
//w_profesor.y	=	y+850//+ypos
//
w_profesor.st_prof.text =w_profesor.st_prof.text+nombre
w_profesor.st_matgpo.text =w_profesor.st_matgpo.text+string(cve_mat)+" Grupo "+ gpo
				

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
lds_nips.SetTransObject(sqlca)
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

public function integer revisa_nip (long al_cuenta);/*
 *		Nombre	revisa_nip
 *		Recibe	al_cuenta
 *		Regresa	0	si el alumno con cuenta al_cuenta no tiene nip registrado y no hay que revisar el nip
 *						de acuerdo al parametro de activacion
 *					1	si el nip dado as_nip corresponde al nip de la cuenta al_cuenta o no hay que revisar el nip
 *						de acuerdo al parametro de activacion
 *					2  si el nip dado as_nip no corresponde al nip de la cuenta al_cuenta y no hay que revisar el nip
 *						de acuerdo al parametro de activacion
 *					-1	error de comunicacion
 *					FMC09041999
 */
 
int li_pregunta_nip
if gi_nivel_usuario < 10 then 
	li_pregunta_nip = i_pregunta_nip
else
	SELECT pregunta_nip INTO :li_pregunta_nip FROM activacion_su WHERE tipo_periodo = :gs_tipo_periodo;
	if sqlca.sqlcode <> 0 then
		messagebox("Error de Comunicación","Error con la consulta de activacion_su BD. Favor de intentar nuevamente", None!)
		return -1
	end if
end if
if li_pregunta_nip = 1 then
	OpenWithParm(w_pregunta_nip,string(al_cuenta)+"@"+uo_nombre.dw_nombre_alumno.getitemstring(1,"nombre")+&
	" "+uo_nombre.dw_nombre_alumno.getitemstring(1,"apaterno")+&
	" "+uo_nombre.dw_nombre_alumno.getitemstring(1,"amaterno"))
	return  int(Message.DoubleParm)
else
	return 1
end if

end function

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
			adeuda_finanzas,	   creditos_integ,      isnull(baja_laboratorio,0)
			INTO
			:bandera[b_isa],		:bandera[b_cfp],		:bandera[b_b3r],		:bandera[b_b4i],
			:bandera[b_bdi],		:bandera[b_bdo],		:bandera[b_ih],		:bandera[b_ec],
										:bandera[b_cfss],		:bandera[b_pi],		:bandera[b_tf1],
			:bandera[b_tf2],		:bandera[b_t1],		:bandera[b_t2],		:bandera[b_t3],
			:bandera[b_t4],									:bandera[b_cfb],
			:bandera[b_af],	   :bandera[b_ci],      :bandera[b_bl]
			FROM banderas WHERE cuenta = :cue;
			
		if sqlca.sqlcode <> 0 then
			commit;
			if cont < 5 then
				cont++
				goto intento
			end if			
			messagebox("Error de Comunicación","Error con la consulta de banderas BD. Favor de intentar nuevamente", None!)
			return 1
		elseif sqlca.sqlcode = 0 then
			commit;
			return 0
		end if
		
end function

public subroutine revisa_baja_laboratorio (long cta);//revisa_baja_laboratorio
//Antonio Pica																			Noviembre 2001
//Función que revisa la situación del alumno por adeudos de laboratorio
//Modifica las variables bloqueado_por(string) y band_bloq(int) si el alumno esta bloqueado
//Modificado Abril 1998

int baja
baja = BanderasAlumno[b_bl]

//	Revisa la situación del alumno contra la bandera
	
	if baja <> 0 then		
		band_bloq = 1
		bloqueado_por	= bloqueado_por+"~t+Por adeudos de laboratorio ~r"
	end if
	

end subroutine

public function integer revisa_gpo_bloqueado (long mat, string gpo);/************************************************************/
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

if gi_nivel_usuario >= 10 then 
	SELECT revisa_grupos_bloqueados INTO :i_revisa_grupos_bloqueados FROM activacion_su WHERE tipo_periodo = :gs_tipo_periodo;
	if sqlca.sqlcode <> 0 then
		messagebox("Error de Comunicación","Error con la consulta de activacion_su BD. Favor de intentar nuevamente", None!)
		return 1
	end if
end if
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
					MessageBox("Grupo bloqueado", "El grupo "+gpo+" es especial para alumnos de otras carreras",Exclamation!)
					return 1
				end if
				if encontro < 0 then return -2
				if encontro > 0 then
					return 0
				else
					MessageBox("Grupo bloqueado", "El grupo "+gpo+" es especial para alumnos de otras carreras",Exclamation!)
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

public subroutine actualiza_struct_horario (long cvmat, string gpo, integer flag);//Carlos Armando Melgoza Piña 									Abril 1997
//Función que actualiza la estructura de horario.
//Escribe 1 en las horas que va ocupando el alumno y 0 en las que libera
//En el parametro flag se indica si se ocupa o libera el horario
/*
	Persona				Fecha				Descripción
	-------------------------------------------------------------------------------------------------------------------------------
	Oscar Sánchez		 17-Sep-2018 Los horarios deben presentar el grupo y fechas de inicio y fin
	
*/
int d,h,ren
long mati
string mat
String	ls_fecha_inicio
String	ls_fecha_fin
String	ls_materia_y_fechas
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
				
				//	Oscar Sánchez		 17-Sep-2018 Los horarios deben presentar el grupo y fechas de inicio y fin
				//dw_ext_h.setitem(h -6,d+1,string(cvmat))	
				ls_fecha_inicio = String ( dw_horario_mat.GetItemDateTime ( ren , "fecha_inicio" ) , "dd-mmm" )
				ls_fecha_fin = String ( dw_horario_mat.GetItemDateTime ( ren , "fecha_fin" ) , "dd-mmm" )
				
				SetNull ( ls_materia_y_fechas )
				ls_materia_y_fechas = Trim ( dw_ext_h.GetItemString ( h -6 , d+1 ) )
				
				IF Len ( Trim ( ls_materia_y_fechas ) ) > 0 and Mid ( ls_materia_y_fechas , 1 , 1 ) = '-' THEN
					ls_materia_y_fechas = Mid ( ls_materia_y_fechas , 2 )
				END IF
				
				// Esta condición se pone debido a que la variable trae un salto de linea aunque no tenga algun otro valor...
				IF Len ( Trim ( ls_materia_y_fechas ) ) = 0 THEN
					SetNull ( ls_materia_y_fechas )
				END IF
				
				IF Not IsNull ( ls_materia_y_fechas ) or ls_materia_y_fechas <> '' THEN
					ls_materia_y_fechas = ls_materia_y_fechas + char ( 13 ) + char (10) + String ( cvmat ) + '-' + gpo + ' ' + ls_fecha_inicio + ' a ' + ls_fecha_fin					
				ELSE
					ls_materia_y_fechas = String ( cvmat ) + '-' + gpo + ' ' + ls_fecha_inicio + ' a ' + ls_fecha_fin
				END IF
				
				dw_ext_h.setitem ( h -6 , d+1 , ls_materia_y_fechas )
				
			next
		next
	end if	
else
	for ren  = 1 to 7
		for h = 1 to 15
			mat = dw_ext_h.getitemstring(h,ren+1)
			mati = Long(mat)
			if mati = cvmat then
				dw_ext_h.setitem(h ,ren+1,"")
				hora[h].dia[ren] = flag
				hora[h].salon[ren] = ""
			end if
		next
	next
end if
end subroutine

public function integer revisa_ss (long mat, long cta);//Carlos Armando Melgoza Piña									Marzo 1997	
//Función que revisa si la materia es SS y si es así verifica que el alumno pueda cursarla
//Regresa un 0 si no es servicio social o si es y puede cursar 1 en caso de que no pueda cursar
//Modificado 14-IV-1998

//**--****--****--****--****--****--****--****--****--****--****--****--**
//**--****--****--****--****--****--****--****--****--****--****--****--**
INTEGER le_revisa_proyecto_ss

// Se verifica el ni vel de usuario para validar el proyecto de servicio social.
if gi_nivel_usuario < 10 then
	le_revisa_proyecto_ss = ie_revisa_proyecto_ss
else
	SELECT activacion_su.revisa_proyecto_ss  
    INTO :le_revisa_proyecto_ss  
    FROM activacion_su WHERE tipo_periodo = :gs_tipo_periodo
	 USING SQLCA;
	 IF SQLCA.SQLCODE < 0 THEN 
		MESSAGEBOX("Aviso", "Se produjo un error al recuperar bandera de proyecto de Servicio Social: " + SQLCA.SQLERRTEXT)	
		RETURN 1
	END IF
	
end if

// Si no valida proyecto de servicio social 
IF le_revisa_proyecto_ss = 0 THEN RETURN 0

//**--****--****--****--****--****--****--****--****--****--****--****--**
//**--****--****--****--****--****--****--****--****--****--****--****--**

long /*cvcarrera, cvplan,cvss,*/area,autori
int cont
cont = 0
if mat = I_cvss then //si la materia es servicio social
	autori = BanderasAlumno[b_cfss]
	//YA PUEDE CURSAR
	if autori = 1 then
		//Si el alumno no ha inscrito el proyecto de servicio social
		if f_proyecto_ss_inscrito(cta, g_anio, g_per)=false then
			messagebox("Proyecto no inscrito","El alumno no tiene inscrito el proyecto de servicio social",Exclamation!)
			return 1			
		else
			//Ya inscribio el proyecto y ya puede cursar el servicio social
			return 0			
		end if		
	//NO HA CURSADO
	elseif autori = 0 then
		messagebox("No puede cursar el servicio social","El alumno aún no puede cursar el servicio social",Exclamation!)
		return 1
	//ESTA O YA CURSO
	elseif autori = 2 then
		messagebox("Ya cursó el servicio social","El alumno ya cursó el servicio social. ~rNo puede volver a cursarlo",Exclamation!)
		return 1
	end if				
else	//Si la materia no es ss
	return 0
end if

end function

public function integer revisa_pago_ultima_hora (long cta);//Funcion que consulta en la db de Cobranzas si el alumno debe algo en el momento actual
//Si debe revisa si tiene beca o financiamiento
//Regresa 0 si no tiene adeudos y 1 en Caso contrario
//CAMP Dec 1997
//Modificado Mayo 1998
//Modificado Abril 1999 FMC
datetime fecha_gen 
int year,aux,intent=0
int porcent_tot=0
string period, ls_nombre_servidor, ls_nombre_base_datos


//if g_per = 0 then
//	period = 'P'
//elseif g_per = 1 then
//	period = 'V'
//elseif g_per = 2 then
//	period = 'O'
//end if


aux = integer(mid(string(g_anio),1,2))*100
year = mod(g_anio,aux)
cobra = Create transaction
DO UNTIL intent = 11		
		intent++
//Se comenta este código 2009-04-02 Omar Ugalde
//Por nuevo requerimiento las conexiones tomarán sus parámetros de la base de datos
//		cobra.DBMS       = ProfileString (gs_startupfile, gs_cobranzas, "dbms",       "")
//		cobra.database   = ProfileString (gs_startupfile, gs_cobranzas, "database",   "")
//		cobra.logid      = sqlca.logid      
//		cobra.logpass    = sqlca.logpass    
//		cobra.servername = ProfileString (gs_startupfile, gs_cobranzas, "servername", "")
//		cobra.dbparm     = ProfileString (gs_startupfile, gs_cobranzas, "dbparm",     "")		

//		if isvalid(sqlca) then
//			if f_mapea_parametros_conexion("SIT", gs_cobranzas, ls_nombre_servidor, ls_nombre_base_datos ) then
//				cobra.servername = ls_nombre_servidor
//				cobra.database = ls_nombre_base_datos
//			end if
//		end if
		
//		connect using cobra;
	//En esta función se conecta
	/*Conectar antes de realizar consultas a la transacción*/
	CONNECT USING gtr_parametros_iniciales;
	f_conecta_pas_parametros_bd(gtr_parametros_iniciales,cobra,gs_tesoreria_cnx,sqlca.logid,sqlca.logpass)
	/*Desconectar después de utilizarla*/
	DISCONNECT USING gtr_parametros_iniciales;
	/*****************************************/
		if cobra.sqlcode <> 0 then
			if intent = 10 then
				MessageBox ("NO SE PUEDE CONSULTAR LA BASE DE DATOS DE FINANZAS", cobra.sqlerrtext)	
				DESTROY cobra
				return 1	
			end if
		else
			if isvalid(sqlca) then
				f_obten_titulo(w_srl)
			end if
			EXIT
		end if
LOOP

/**/Transaction ltr_sfeb
/**/ltr_sfeb = Create transaction
//Se comenta este código 2009-04-02 Omar Ugalde
//Por nuevo requerimiento las conexiones tomarán sus parámetros de la base de datos
///**/ltr_sfeb.DBMS = ProfileString (gs_startupfile, gs_sfeb, "dbms","")
///**/ltr_sfeb.database = ProfileString (gs_startupfile, gs_sfeb, "database","")
///**/ltr_sfeb.servername = ProfileString (gs_startupfile, gs_sfeb, "servername","")
///**/ltr_sfeb.dbparm = ProfileString (gs_startupfile, gs_sfeb, "dbparm", "")		
///**/ltr_sfeb.logid = sqlca.logid 
///**/ltr_sfeb.logpass = sqlca.logpass 
/**/int li_ret

if revisa_adeudos(cta)	= 0 then//si no debe revisamos pago de inscripción
	//if revisa_pago_inscripcion(cta,period,year)=0 and revisa_pago_anticipado(cta)=0 then//Si no pago se revisa el porcentaje de beca y financiamiento
	if revisa_pago_inscripcion(cta,g_per,year)=0 and revisa_pago_anticipado(cta)=0 then//Si no pago se revisa el porcentaje de beca y financiamiento
	//En esta función se conecta
	CONNECT USING gtr_parametros_iniciales;
	f_conecta_pas_parametros_bd(gtr_parametros_iniciales,ltr_sfeb,gs_becas_cnx,sqlca.logid,sqlca.logpass)
	DISCONNECT USING gtr_parametros_iniciales;
//		/**/CONNECT using ltr_sfeb;
		/**/if ltr_sfeb.sqlcode <> 0 then
		/**/		MessageBox ("NO SE PUEDE CONSULTAR LA BASE DE DATOS DE BECAS", ltr_sfeb.sqlerrtext)	
		/**/		li_ret = 1
		/**/else
		/**/		porcent_tot = revisa_porcentaje_apoyo(cta,g_per,g_anio,ltr_sfeb)
		/**/		if porcent_tot = 100 then//OK Esta cubierto su pago
		/**/			li_ret = 0
		/**/		elseif porcent_tot = -1 then
		/**/			MessageBox ("Error al consultar la base de datos de becas", ltr_sfeb.sqlerrtext)	
		/**/			li_ret = 1
		/**/		else// Esta Bloqueado
		/**/			li_ret = 1
		/**/		end if	
		/**/		DISCONNECT using ltr_sfeb;
		/**/end if
	else//Si pago inscripción puede inscribirse
		li_ret = 0
	end if
else//Si debe esta bloqueado
		li_ret = 1
end if

DISCONNECT using cobra;
DESTROY cobra;
DESTROY ltr_sfeb;
return li_ret
end function

public subroutine llena_comprobante ();int row,nummat,col,ren,code, noimp
long cvmat
string gpo,periodo, ls_amaterno
long lli_cuenta
//DataWindowChild observaciones

//if g_per = 0 then
//	periodo = "Primavera"
//elseif g_per = 1 then
//	periodo = "Verano"
//elseif g_per = 2 then
//	periodo = "Otoño"
//end if

SELECT descripcion 
INTO :periodo
FROM periodo
WHERE periodo = :g_per
USING sqlca;
IF sqlca.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar la descripción del periodo:" + SQLCA.SQLERRTEXT)
	RETURN 
END IF


//  SELECT activacion_su.mensaje  
//    INTO :i_mensaje  
//    FROM activacion_su  ;

i_mensaje = i_men

/*dw_comprobante.getchild("mensaje",observaciones)
observaciones.retrieve()*/
row = dw_comprobante.insertrow(0)
// Llenando Encabezado
dw_comprobante.object.cuenta.text = uo_nombre.em_cuenta.text
dw_comprobante.object.digito.text = uo_nombre.em_digito.text
dw_comprobante.object.periodo.text = periodo
dw_comprobante.object.year.text = string(g_anio)
dw_comprobante.object.nombre.text = uo_nombre.dw_nombre_alumno.getitemstring(1,"nombre")
dw_comprobante.object.apaterno.text = uo_nombre.dw_nombre_alumno.getitemstring(1,"apaterno")
ls_amaterno = string(uo_nombre.dw_nombre_alumno.getitemstring(1,"amaterno"))
dw_comprobante.object.amaterno.text = ls_amaterno+space(1)
//dw_comprobante.object.carrera.text = dw_plan.getitemstring(1,"carreras_carrera")
//dw_comprobante.object.plan.text = dw_plan.getitemstring(1,"nombre_plan_nombre_plan")
//Mensaje  Servesc hacia Alumnos
dw_comprobante.object.mensaje.text = i_mensaje



//Llenado de Materias
cvmat = dw_materias.getitemnumber(1,"mat_inscritas_cve_mat")
gpo = dw_materias.getitemstring(1,"mat_inscritas_gpo")
dw_comprobante.setitem(row,"cve_mat",cvmat)
dw_comprobante.setitem(row,"gpo",gpo)
dw_comprobante.setitem(row,"creditos",dw_materias.getitemdecimal(1,"materias_creditos"))
dw_comprobante.setitem(row,"horas",dw_materias.getitemnumber(1,"materias_horas_totales"))
dw_comprobante.setitem(row,"materia",dw_materias.getitemstring(1,"materias_materia"))
encuentra_salon(cvmat,row)
for nummat = 2 to dw_materias.rowcount()
	cvmat = dw_materias.getitemnumber(nummat,"mat_inscritas_cve_mat")
	gpo = dw_materias.getitemstring(nummat,"mat_inscritas_gpo")
	row = dw_comprobante.insertrow(0)
	dw_comprobante.setitem(row,"cve_mat",cvmat)
	dw_comprobante.setitem(row,"gpo",gpo)
	dw_comprobante.setitem(row,"creditos",dw_materias.getitemdecimal(nummat,"materias_creditos"))
	dw_comprobante.setitem(row,"horas",dw_materias.getitemnumber(nummat,"materias_horas_totales"))
	dw_comprobante.setitem(row,"materia",dw_materias.getitemstring(nummat,"materias_materia"))
	encuentra_salon(cvmat,row)
next
//Llena horario
fill_horario()

lli_cuenta = long(uo_nombre.em_cuenta.text)


SELECT isnull(noimpresiones,0) INTO :noimp FROM preinsc
WHERE cuenta = :lli_cuenta AND
periodo = :g_per AND
anio = :g_anio using sqlca;

if sqlca.sqlcode <> 0 then
	noimp = 0;
	commit using sqlca;
else
	noimp++
	UPDATE preinsc SET noimpresiones = :noimp
	WHERE cuenta = :lli_cuenta AND
	periodo = :g_per AND
	anio = :g_anio using sqlca;
	if sqlca.sqlcode <> 0 then
		rollback using sqlca;
		noimp = -noimp
	else
		commit using sqlca;
	end if
end if
//if isnull(noimp) then
//	noimp=0
//end if

dw_comprobante.object.noimpresion.text = "***"+string(noimp)+"***"



end subroutine

public function integer revisa_curso_tema (long mat, long cta);//Carlos Armando Melgoza Piña												Marzo 1997
// 1)Función que revisa si ya se curso el tema de una materia de integración
// 2)Función que detecta si el alumno ya inscribio una materia de un tema determinado
// 3)Revisa el número de creditos de integración que puede inscribir el alumno
// 4)Revisa que el alumno tenga la bandera de puede integracion
//Regresa un 0 si no 1 & 2 & 3 se cumple o un 1 si no
//Modificación Noviembre 1997 union de funciones
//Fantine Medina Carrillo

// SE ELIMINA PROVISIONALMENTE LA VALIDACIÓN DE AREA DE INTEGRACIÓN
// SE ELIMINA PROVISIONALMENTE LA VALIDACIÓN DE AREA DE INTEGRACIÓN
// SE ELIMINA PROVISIONALMENTE LA VALIDACIÓN DE AREA DE INTEGRACIÓN
//RETURN 0
// SE ELIMINA PROVISIONALMENTE LA VALIDACIÓN DE AREA DE INTEGRACIÓN
// SE ELIMINA PROVISIONALMENTE LA VALIDACIÓN DE AREA DE INTEGRACIÓN
// SE ELIMINA PROVISIONALMENTE LA VALIDACIÓN DE AREA DE INTEGRACIÓN

INTEGER le_revisa_tema

SELECT revisa_tema_integracion 
INTO :le_revisa_tema
FROM activacion 
WHERE tipo_periodo = :gs_tipo_periodo;

IF ISNULL(le_revisa_tema) THEN le_revisa_tema = 1 
// Si no se revisa tema se omite la validación
IF le_revisa_tema = 0 THEN RETURN 0



long area
int curso,cont,crd, ll_cve_plan
cont = 0
INTEGER le_total_materias, le_total_areas
	 
// Verifica si la materia pertenece a un área de temas de integración.
SELECT COUNT(*)	 
INTO :le_total_materias 
FROM area_mat  
WHERE area_mat.cve_mat = :mat 
 AND area_mat.cve_area  IN ( SELECT area FROM (  SELECT DISTINCT pe1.cve_area_integ_tema1 as area 
																	 FROM plan_estudios pe1 
																	UNION
																	 SELECT DISTINCT pe2.cve_area_integ_tema2  as area 
																	 FROM plan_estudios pe2 
																	UNION 
																	SELECT DISTINCT pe3.cve_area_integ_tema3  as area 
																	 FROM plan_estudios pe3 
																	UNION 
																	SELECT DISTINCT pe4.cve_area_integ_tema4  as area 
																	 FROM plan_estudios pe4 
																	UNION 
																	SELECT DISTINCT pe5.cve_area_integ_fundamental   as area 
																	 FROM plan_estudios pe5  ) areas_temas);
//	revisa_rows()			//verifica que el error no se deba a exceso de renglones

// Verifica que la materia no sea de ninguna de estas áreas.
IF le_total_materias = 0 THEN 
	commit;
	RETURN 0
END IF

//El alumno no puede cursar la materia
IF BanderasAlumno[b_pi] = 0 THEN 
	messagebox("No puede cursar la materia","El alumno no puede cursar materias de integracion.",Exclamation!)
	return 1
END IF


// Se filtra el DS de instancia para la materia actual. 
ids_area_mat.SETFILTER("cve_mat = " + STRING(mat))
ids_area_mat.FILTER()
INTEGER le_pos
STRING ls_tema_area


FOR le_pos = 1 TO ids_area_mat.ROWCOUNT()

	area = ids_area_mat.GETITEMNUMBER(le_pos, "cve_area") 
	IF ISNULL(area) THEN CONTINUE 

	ls_tema_area = ids_area_mat.GETITEMSTRING(le_pos, "tema")  
	IF ISNULL(ls_tema_area ) OR TRIM(ls_tema_area ) = "" THEN CONTINUE 

	// Se verifica el tipo de area para determinar si ya cursó.
	CHOOSE CASE ls_tema_area 
		CASE 'integracion' 
			curso = BanderasAlumno[b_tf1] 
			IF curso  <> 0 THEN 
				curso = BanderasAlumno[b_tf2] 
				IF curso  <> 0 then
					MESSAGEBOX("Tema ya cursado","El alumno ya curso la materia el tema fundamental 1.~No puede cursarla nuevamente.",Exclamation!)
					RETURN 1
				END IF
			END IF
		CASE 'reflexion1'
			curso = BanderasAlumno[b_t1]	
			IF curso  <> 0 then
				MESSAGEBOX("Tema ya cursado","El alumno ya curso la materia del tema I.~No puede cursarla nuevamente.",Exclamation!)
				RETURN 1
			END IF			
		CASE 'reflexion2'
			curso = BanderasAlumno[b_t2]
			IF curso  <> 0 then
				MESSAGEBOX("Tema ya cursado","El alumno ya curso la materia del tema II.~No puede cursarla nuevamente.",Exclamation!)
				RETURN 1
			END IF						
		CASE 'reflexion3'
			curso = BanderasAlumno[b_t3]
			IF curso  <> 0 then
				MESSAGEBOX("Tema ya cursado","El alumno ya curso la materia del tema III.~No puede cursarla nuevamente.",Exclamation!)
				RETURN 1
			END IF						
		CASE 'reflexion4'
			curso = BanderasAlumno[b_t4]
			IF curso  <> 0 then
				MESSAGEBOX("Tema ya cursado","El alumno ya curso la materia del tema IV.~No puede cursarla nuevamente.",Exclamation!)	
				RETURN 1
			END IF						
	END CHOOSE
	
	
	SELECT COUNT(*)
	INTO :le_total_areas
	FROM area_mat,   
			mat_inscritas  
	WHERE ( mat_inscritas.cve_mat = area_mat.cve_mat ) and  
			( ( area_mat.cve_area = :area ) AND  
			( mat_inscritas.cuenta = :cta ) )   ;
			
	IF le_total_areas = 0 THEN CONTINUE		
	
	IF le_total_areas > 0 THEN 
		commit;
		messagebox("Tema ya inscrito","El alumno ya inscribió una materia de este tema.~r No puede cursar otra materia del mismo.",Exclamation!)
		return 1			
	END IF
	
NEXT

// Si llega hasta este punto se trata de una materia de tema de integración y puede ser inscrita.
// Se validan los créditos.
// VALIDAR ESTE CASO.
crd = BanderasAlumno[b_ci]
if crd = 0 then
	crd = 8
end if

//Actualización de cred_integ. 
actualiza_integ()  			
if cred_integ > crd then
	messagebox("Excede limite de créditos de integración","El alumno ha sobrepasado el limite de materias de integración.~rEsta materia no podrá inscribirse",Exclamation!)
	cred_integ = crd_ant
	return 1
else
	return 0
end if	

RETURN 0


// Se recupera el área de la materia.

	 
//	 if sqlca.sqlcode = 0 then
//		commit;
//		if (area < 2201 or area > 2205) and (area < 8061 or area > 8064) and (area < 335 or area > 336) AND (area < 8977 or area > 8980) then
//			return 0
//		elseif BanderasAlumno[b_pi] = 0 then //El alumno no puede cursar la materia
//			messagebox("No puede cursar la materia","El alumno no puede cursar materias de integracion.",Exclamation!)
//			return 1
//		else
//			curso = BanderasAlumno[b_tf1]+BanderasAlumno[b_tf2]
////			if curso = 2  then	//CODIGO ELIMINADO A PETICION DE SERVICIOS ESCOLARES
//								//AHORA SE PUEDE CURSAR CUALQUIERA DE LA 6 MATERIAS DE INTEGRACIÓN
//								//13-05-1998
//			choose case area
//				case 	8977, 8978, 8979, 8980 
//						curso = BanderasAlumno[b_tf1]	
//						 if curso  <> 0 then
//							messagebox("Tema ya cursado","El alumno ya curso la materia el tema fundamental 1.~No puede cursarla nuevamente.",Exclamation!)
//							return 1
//						end if							
//				case 2202,8061,336
//						curso = BanderasAlumno[b_t1]	
//						 if curso  <> 0 then
//							messagebox("Tema ya cursado","El alumno ya curso la materia del tema I.~No puede cursarla nuevamente.",Exclamation!)
//							return 1
//						end if	
//				case 2203,8062
//							curso = BanderasAlumno[b_t2]
//							 if curso <> 0 then 
//								messagebox("Tema ya cursado","El alumno ya curso la materia del tema II.~No puede cursarla nuevamente.",Exclamation!)
//								return 1
//							end if	
//				case 2204,8063
//							curso = BanderasAlumno[b_t3]
//							 if curso <> 0 then
//								messagebox("Tema ya cursado","El alumno ya curso la materia del tema III.~No puede cursarla nuevamente.",Exclamation!)
//								return 1
//							end if	
//				case 2205,8064
//							curso = BanderasAlumno[b_t4]
//							 if curso <> 0 then
//								messagebox("Tema ya cursado","El alumno ya curso la materia del tema IV.~No puede cursarla nuevamente.",Exclamation!)
//								return 1
//							end if	
//				case else
//						return 0				
//				end choose				 	
////				elseif area <> 2201 then
////					messagebox("No ha cursado el tema fundamental","El alumno no ha cursado las materias del tema fundamental.~No puede cursar esta materia.",Exclamation!)
////					return 1
////				end if
//			cont = 0
//			intento1:
//			  SELECT area_mat.cve_area  
//	   			    INTO :area  
//				 FROM area_mat,   
//					        mat_inscritas  
//				 WHERE ( mat_inscritas.cve_mat = area_mat.cve_mat ) and  
//				            ( ( area_mat.cve_area = :area ) AND  
//						     ( mat_inscritas.cuenta = :cta ) )   ;
//					if sqlca.sqlcode = 100 or area = 2201 or area = 335 then
//							commit;
//					elseif sqlca.sqlcode = 0  then
//							commit;
//							messagebox("Tema ya inscrito","El alumno ya inscribió una materia de este tema.~r No puede cursar otra materia del mismo.",Exclamation!)
//							return 1
//					else
//							commit;
//							if cont < 5 then
//								cont++
//								goto intento1
//							end if
//							messagebox("Error de Comunicación","Error con la consulta de MATERIAS_INSCRITAS y area BD. Favor de intentar nuevamente", None!)					
//							return 1			//error de base de datos						
//					end if			
//					crd = BanderasAlumno[b_ci]
//					if crd = 0 then
//						ll_cve_plan = i_planalumno
//						if isnull(ll_cve_plan) then 
//							crd = 16
//						elseif i_planalumno <> 6 then
//							crd = 16
//						else
//							crd = 8
//						end if
//					end if
//						actualiza_integ()  //Actualización de cred_integ			
//					if cred_integ > crd then
//						messagebox("Excede limite de créditos de integración","El alumno ha sobrepasado el limite de materias de integración.~rEsta materia no podrá inscribirse",Exclamation!)
//						cred_integ = crd_ant
//						return 1
//					else
//						return 0
//					end if	
//	end if	
//	else
////		 commit;
////		 if cont < 5 then
////			cont++
////			goto intento
////		end if					
//		if sqlca.sqlcode = 100 then
//			commit;
//			return 0
//		else
//			commit;
//			messagebox("Error de Comunicación","Error con la consulta de AREA_MATERIA BD. Favor de intentar nuevamente", None!)
//			return 1	//error en bd			
//		end if
//	 end if
//



//  SELECT area_mat.cve_area  
//	    INTO :area  
//   	 FROM area_mat  
//    WHERE area_mat.cve_mat = :mat 
//	 AND area_mat.cve_area  IN (
//					 SELECT area FROM (
//							SELECT DISTINCT pe1.cve_area_integ_tema1 as area 
//							 FROM plan_estudios pe1 
//							UNION
//							 SELECT DISTINCT pe2.cve_area_integ_tema2  as area 
//							 FROM plan_estudios pe2 
//							UNION 
//							SELECT DISTINCT pe3.cve_area_integ_tema3  as area 
//							 FROM plan_estudios pe3 
//							UNION 
//		 					SELECT DISTINCT pe4.cve_area_integ_tema4  as area 
//							 FROM plan_estudios pe4 
//							UNION 
//		 					SELECT DISTINCT pe5.cve_area_integ_fundamental   as area 
//							 FROM plan_estudios pe5  ) areas_temas
//	 									)	 
//										 ;
//


// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 
// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 
// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 
//
//
////Carlos Armando Melgoza Piña												Marzo 1997
//// 1)Función que revisa si ya se curso el tema de una materia de integración
//// 2)Función que detecta si el alumno ya inscribio una materia de un tema determinado
//// 3)Revisa el número de creditos de integración que puede inscribir el alumno
//// 4)Revisa que el alumno tenga la bandera de puede integracion
////Regresa un 0 si no 1 & 2 & 3 se cumple o un 1 si no
////Modificación Noviembre 1997 union de funciones
////Fantine Medina Carrillo
//
//long area
//int curso,cont,crd, ll_cve_plan
//cont = 0
//
//  SELECT area_mat.cve_area  
//	    INTO :area  
//   	 FROM area_mat  
//    WHERE area_mat.cve_mat = :mat 
//	 AND area_mat.cve_area  IN (8061, 8062, 8063, 8064, 2200, 2201, 2202, 2203, 2204, 2205, 335,336, 8977, 8978, 8979, 8980)
//	 
//	 
//	 
//	 
//	 ; //Revisión del area de la materia a inscribir
//	 
//	revisa_rows()			//verifica que el error no se deba a exceso de renglones
//	 
//	 if sqlca.sqlcode = 0 then
//		commit;
//		if (area < 2201 or area > 2205) and (area < 8061 or area > 8064) and (area < 335 or area > 336) AND (area < 8977 or area > 8980) then
//			return 0
//		elseif BanderasAlumno[b_pi] = 0 then //El alumno no puede cursar la materia
//			messagebox("No puede cursar la materia","El alumno no puede cursar materias de integracion.",Exclamation!)
//			return 1
//		else
//			curso = BanderasAlumno[b_tf1]+BanderasAlumno[b_tf2]
////			if curso = 2  then	//CODIGO ELIMINADO A PETICION DE SERVICIOS ESCOLARES
//								//AHORA SE PUEDE CURSAR CUALQUIERA DE LA 6 MATERIAS DE INTEGRACIÓN
//								//13-05-1998
//			choose case area
//				case 	8977, 8978, 8979, 8980 
//						curso = BanderasAlumno[b_tf1]	
//						 if curso  <> 0 then
//							messagebox("Tema ya cursado","El alumno ya curso la materia el tema fundamental 1.~No puede cursarla nuevamente.",Exclamation!)
//							return 1
//						end if							
//				case 2202,8061,336
//						curso = BanderasAlumno[b_t1]	
//						 if curso  <> 0 then
//							messagebox("Tema ya cursado","El alumno ya curso la materia del tema I.~No puede cursarla nuevamente.",Exclamation!)
//							return 1
//						end if	
//				case 2203,8062
//							curso = BanderasAlumno[b_t2]
//							 if curso <> 0 then 
//								messagebox("Tema ya cursado","El alumno ya curso la materia del tema II.~No puede cursarla nuevamente.",Exclamation!)
//								return 1
//							end if	
//				case 2204,8063
//							curso = BanderasAlumno[b_t3]
//							 if curso <> 0 then
//								messagebox("Tema ya cursado","El alumno ya curso la materia del tema III.~No puede cursarla nuevamente.",Exclamation!)
//								return 1
//							end if	
//				case 2205,8064
//							curso = BanderasAlumno[b_t4]
//							 if curso <> 0 then
//								messagebox("Tema ya cursado","El alumno ya curso la materia del tema IV.~No puede cursarla nuevamente.",Exclamation!)
//								return 1
//							end if	
//				case else
//						return 0				
//				end choose				 	
////				elseif area <> 2201 then
////					messagebox("No ha cursado el tema fundamental","El alumno no ha cursado las materias del tema fundamental.~No puede cursar esta materia.",Exclamation!)
////					return 1
////				end if
//			cont = 0
//			intento1:
//			  SELECT area_mat.cve_area  
//	   			    INTO :area  
//				 FROM area_mat,   
//					        mat_inscritas  
//				 WHERE ( mat_inscritas.cve_mat = area_mat.cve_mat ) and  
//				            ( ( area_mat.cve_area = :area ) AND  
//						     ( mat_inscritas.cuenta = :cta ) )   ;
//					if sqlca.sqlcode = 100 or area = 2201 or area = 335 then
//							commit;
//					elseif sqlca.sqlcode = 0  then
//							commit;
//							messagebox("Tema ya inscrito","El alumno ya inscribió una materia de este tema.~r No puede cursar otra materia del mismo.",Exclamation!)
//							return 1
//					else
//							commit;
//							if cont < 5 then
//								cont++
//								goto intento1
//							end if
//							messagebox("Error de Comunicación","Error con la consulta de MATERIAS_INSCRITAS y area BD. Favor de intentar nuevamente", None!)					
//							return 1			//error de base de datos						
//					end if			
//					crd = BanderasAlumno[b_ci]
//					if crd = 0 then
//						ll_cve_plan = i_planalumno
//						if isnull(ll_cve_plan) then 
//							crd = 16
//						elseif i_planalumno <> 6 then
//							crd = 16
//						else
//							crd = 8
//						end if
//					end if
//						actualiza_integ()  //Actualización de cred_integ			
//					if cred_integ > crd then
//						messagebox("Excede limite de créditos de integración","El alumno ha sobrepasado el limite de materias de integración.~rEsta materia no podrá inscribirse",Exclamation!)
//						cred_integ = crd_ant
//						return 1
//					else
//						return 0
//					end if	
//	end if	
//	else
////		 commit;
////		 if cont < 5 then
////			cont++
////			goto intento
////		end if					
//		if sqlca.sqlcode = 100 then
//			commit;
//			return 0
//		else
//			commit;
//			messagebox("Error de Comunicación","Error con la consulta de AREA_MATERIA BD. Favor de intentar nuevamente", None!)
//			return 1	//error en bd			
//		end if
//	 end if
//
end function

public subroutine actualiza_integ ();//Carlos Armando Melgoza Piña													Marzo 1997
//Función que actualiza la cantidad de creditos de integración inscritos
//Modificada Noviembre 1997
//Fantine Medina Carrillo


decimal cred
cred  = dw_materias.getitemdecimal(dw_materias.getrow(),"materias_creditos")					 	 
cred_integ = cred_integ + cred //incremento de materias de integracion					

end subroutine

public function integer revisa_labs (long cuenta);//Fantine Medina Carrillo	Nov 1998
//Función en el cual revisa si alguna de las materias inscritas tiene un laboratorio que no se haya inscrito
//Regresa 0 si la materia esta inscrita o no existe tal  y 1 en caso contrario
int  totmi, tottl,i, teoria, lab, li_num_ligados, li_ligado_actual, li_reset_ligados, li_retrieve_ligados
long ll_cve_mati[20]
string mensaje, ls_gpo_teoria, ls_gpo_lab, ls_condicion_mat_teoria, ls_condicion_mat_lab
string ls_condicion_gpo_teoria, ls_condicion_gpo_lab, ls_filtro_teoria, ls_filtro_laboratorio, ls_filtro_limpio
string ls_gpo_teoria_i, ls_gpo_lab_i
int li_revisa_teoria_lab, li_teoria_i, li_lab_i
boolean lb_teoria_aprobada, lb_laboratorio_aprobado
decimal ldc_creditos_laboratorio
if cuenta > 0 then
	if gi_nivel_usuario < 10 then 
		li_revisa_teoria_lab = i_revisa_teoria_lab
	else
		SELECT revisa_teoria_lab INTO :li_revisa_teoria_lab FROM activacion_su WHERE tipo_periodo = :gs_tipo_periodo;
		if sqlca.sqlcode <> 0 then
			messagebox("Error de Comunicación","Error con la consulta de activacion_su BD. Favor de intentar nuevamente", None!)
			return 1
		end if
	end if
	if li_revisa_teoria_lab = 1 then
		for i=1 to dw_materias.rowcount()
			ll_cve_mati[i]=dw_materias.getitemnumber(i,"mat_inscritas_cve_mat",Primary!,False)
		next
		tottl = dw_teoria_lab.retrieve(i_carreraalumno,i_planalumno,ll_cve_mati)
		//Limpia cualquier filtro existente
		ls_filtro_limpio = ""				
		dw_teoria_lab_ligados.SetFilter(ls_filtro_limpio)
		dw_teoria_lab_ligados.Filter()
		li_reset_ligados = dw_teoria_lab_ligados.Reset()
		li_retrieve_ligados = dw_teoria_lab_ligados.retrieve(i_carreraalumno,i_planalumno,ll_cve_mati)
		if tottl > 0 then //Hay materias que revisar
			totmi = dw_materias.RowCount()
			for i = 1 to tottl
				//Revisa el i-esimo elemento de las materias inscritas que tienen teoria laboratorio
				li_teoria_i = dw_teoria_lab.GetItemnumber(i,"cve_teoria")
				li_lab_i =  dw_teoria_lab.GetItemnumber(i,"cve_lab")
				ls_gpo_teoria_i = dw_teoria_lab.GetItemString(i,"gpo_teoria")
				ls_gpo_lab_i = dw_teoria_lab.GetItemString(i,"gpo_lab")
				
				
				//Revisa las materias inscritas que tienen dependencia de teoria
				ls_filtro_teoria = 'cve_teoria = '+string(li_teoria_i)
				
				dw_teoria_lab_ligados.SetFilter(ls_filtro_teoria)
				dw_teoria_lab_ligados.Filter()
				li_num_ligados= dw_teoria_lab_ligados.RowCount()
				li_ligado_actual= 1
				DO WHILE li_ligado_actual<=li_num_ligados
					
					teoria = dw_teoria_lab_ligados.GetItemnumber(li_ligado_actual,"cve_teoria")
					lab =  dw_teoria_lab_ligados.GetItemnumber(li_ligado_actual,"cve_lab")
					ls_gpo_teoria = dw_teoria_lab_ligados.GetItemString(li_ligado_actual,"gpo_teoria")
					ls_gpo_lab = dw_teoria_lab_ligados.GetItemString(li_ligado_actual,"gpo_lab")
					
					ls_condicion_mat_teoria = 'mat_inscritas_cve_mat = '+string(teoria)
					ls_condicion_gpo_teoria = 'mat_inscritas_gpo = "'+ls_gpo_teoria+'"'
					
					ls_condicion_mat_lab = 'mat_inscritas_cve_mat = '+string(lab)
					ls_condicion_gpo_lab = 'mat_inscritas_gpo = "'+ls_gpo_lab+'"'
					
					lb_teoria_aprobada = f_materia_aprobada(cuenta, teoria, I_CarreraAlumno, I_PlanAlumno)
					lb_laboratorio_aprobado = f_materia_aprobada(cuenta, lab, I_CarreraAlumno, I_PlanAlumno)
				
					ldc_creditos_laboratorio = f_obten_creditos_materia(lab)
					if ldc_creditos_laboratorio = -1 then ldc_creditos_laboratorio = 0

					//El grupo de ambas debe ser específico
					if ls_gpo_teoria<>"*" and ls_gpo_lab<>"*" then
						if ((dw_materias.Find(ls_condicion_mat_teoria+" and "+ls_condicion_gpo_teoria,1,totmi) = 0 and &
						     (lb_teoria_aprobada = false) ) &
						    or &
							 (dw_materias.Find(ls_condicion_mat_lab+" and "+ls_condicion_gpo_lab,1,totmi) = 0 and &
							  (lb_laboratorio_aprobado = false) ) &
						    or &
							 (dw_materias.Find(ls_condicion_mat_lab+" and "+ls_condicion_gpo_lab,1,totmi) > 0 and &
							  (lb_teoria_aprobada = true) and (ldc_creditos_laboratorio = 0) ) ) then
							 if li_ligado_actual= li_num_ligados then
								commit;
								messagebox("La materia requiere inscribir un grupo particular","Es necesario que el alumno inscriba el laboratorio ["&
										+string(lab)+"] en el grupo ["+ls_gpo_lab+"]~r"+&
										" Y cursar la materia ["+string(teoria)+"] en el grupo ["+ls_gpo_teoria+"].",Exclamation!) 
								return 1								
							end if
						else
							li_ligado_actual= li_ligado_actual+li_num_ligados
						end if					
					//El grupo de la teoría debe ser específico
					elseif ls_gpo_teoria<>"*" and ls_gpo_lab="*" then
						if ((dw_materias.Find(ls_condicion_mat_teoria+" and "+ls_condicion_gpo_teoria,1,totmi) = 0 and &
						      (lb_teoria_aprobada = false) ) &						
						    or &
							 (dw_materias.Find(ls_condicion_mat_lab,1,totmi) = 0  and &
							  (lb_laboratorio_aprobado = false) ) &
						    or &
							 (dw_materias.Find(ls_condicion_mat_lab,1,totmi) > 0 and &
							  (lb_teoria_aprobada = true) and (ldc_creditos_laboratorio = 0) ) ) then
							 if li_ligado_actual= li_num_ligados then
								commit;
								messagebox("La materia requiere inscribir un grupo particular","Es necesario que el alumno inscriba la materia"+&
							         " ["+string(teoria)+"] en el grupo ["+ls_gpo_teoria+"] ~r Y cursar el laboratorio ["&
										+string(lab)+"].",Exclamation!) 
								return 1						
							end if
						else
							li_ligado_actual= li_ligado_actual+li_num_ligados
						end if										
					//El grupo del laboratorio debe ser específico
					elseif ls_gpo_teoria="*" and ls_gpo_lab<>"*" then
						if ((dw_materias.Find(ls_condicion_mat_teoria,1,totmi) = 0 and &
						      (lb_teoria_aprobada = false) ) &						
						    or &
							 (dw_materias.Find(ls_condicion_mat_lab+" and "+ls_condicion_gpo_lab,1,totmi) = 0  and &
							  (lb_laboratorio_aprobado = false)) &
						    or &
							 (dw_materias.Find(ls_condicion_mat_lab+" and "+ls_condicion_gpo_lab,1,totmi) > 0  and &
							  (lb_teoria_aprobada = true) and (ldc_creditos_laboratorio = 0) ) ) then
							 if li_ligado_actual= li_num_ligados then
								commit;
								messagebox("El laboratorio requiere inscribir un grupo particular","Es necesario que el alumno inscriba el laboratorio ["&
											+string(lab)+"] en el grupo ["+ls_gpo_lab+"]~r Y cursar la materia ["+string(teoria)+"].",Exclamation!) 
								return 1						
							end if
						else
							li_ligado_actual= li_ligado_actual+li_num_ligados
						end if										
					//No importa el grupo de ambas
					elseif ls_gpo_teoria="*" and ls_gpo_lab="*" then
						if ((dw_materias.Find(ls_condicion_mat_teoria,1,totmi) = 0 and &
  					        (lb_teoria_aprobada = false) ) &						
						    or &
							 (dw_materias.Find(ls_condicion_mat_lab,1,totmi) = 0 and &
							  (lb_laboratorio_aprobado = false) ) &
						    or &
							 (dw_materias.Find(ls_condicion_mat_lab,1,totmi) > 0 and &
							  (lb_teoria_aprobada = true) and (ldc_creditos_laboratorio = 0) ) ) then
							 if li_ligado_actual= li_num_ligados then
								commit;
								messagebox("Falta inscribir una materia o laboratorio","Es necesario que el alumno inscriba el laboratorio ["&
											+string(lab)+"]~r Y cursar la materia ["+string(teoria)+"].",Exclamation!) 
								return 1						
							end if
						else
							li_ligado_actual= li_ligado_actual+li_num_ligados
						end if										
					end if					
					li_ligado_actual= li_ligado_actual+1
				LOOP 	
				
				//Revisa las materias inscritas que tienen dependencia de laboratorio
				ls_filtro_laboratorio = 'cve_lab = '+string(li_lab_i)
				
				dw_teoria_lab_ligados.SetFilter(ls_filtro_laboratorio)
				dw_teoria_lab_ligados.Filter()
				li_num_ligados= dw_teoria_lab_ligados.RowCount()
				li_ligado_actual= 1
				DO WHILE li_ligado_actual<=li_num_ligados
					
					teoria = dw_teoria_lab_ligados.GetItemnumber(li_ligado_actual,"cve_teoria")
					lab =  dw_teoria_lab_ligados.GetItemnumber(li_ligado_actual,"cve_lab")
					ls_gpo_teoria = dw_teoria_lab_ligados.GetItemString(li_ligado_actual,"gpo_teoria")
					ls_gpo_lab = dw_teoria_lab_ligados.GetItemString(li_ligado_actual,"gpo_lab")
					
					ls_condicion_mat_teoria = 'mat_inscritas_cve_mat = '+string(teoria)
					ls_condicion_gpo_teoria = 'mat_inscritas_gpo = "'+ls_gpo_teoria+'"'
					
					ls_condicion_mat_lab = 'mat_inscritas_cve_mat = '+string(lab)
					ls_condicion_gpo_lab = 'mat_inscritas_gpo = "'+ls_gpo_lab+'"'

					lb_teoria_aprobada = f_materia_aprobada(cuenta, teoria, I_CarreraAlumno, I_PlanAlumno)
					lb_laboratorio_aprobado = f_materia_aprobada(cuenta, lab, I_CarreraAlumno, I_PlanAlumno)

					ldc_creditos_laboratorio = f_obten_creditos_materia(lab)
					if ldc_creditos_laboratorio = -1 then ldc_creditos_laboratorio = 0
				
					//El grupo de ambas debe ser específico
					if ls_gpo_teoria<>"*" and ls_gpo_lab<>"*" then
						if ((dw_materias.Find(ls_condicion_mat_teoria+" and "+ls_condicion_gpo_teoria,1,totmi) = 0 and &
						     (lb_teoria_aprobada=false)) &
						    or &
							 (dw_materias.Find(ls_condicion_mat_lab+" and "+ls_condicion_gpo_lab,1,totmi) = 0 and & 
							  (lb_laboratorio_aprobado=false) ) &
						    or &
							 (dw_materias.Find(ls_condicion_mat_lab+" and "+ls_condicion_gpo_lab,1,totmi) > 0 and & 
							  (lb_teoria_aprobada = true) and (ldc_creditos_laboratorio = 0) ) ) then
							 if li_ligado_actual= li_num_ligados then
								commit;
								messagebox("La materia requiere inscribir un grupo particular","Es necesario que el alumno inscriba el laboratorio ["&
										+string(lab)+"] en el grupo ["+ls_gpo_lab+"]~r"+&
										" Y cursar la materia ["+string(teoria)+"] en el grupo ["+ls_gpo_teoria+"].",Exclamation!) 
								return 1								
							end if
						else
							li_ligado_actual= li_ligado_actual+li_num_ligados
						end if					
					//El grupo de la teoría debe ser específico
					elseif ls_gpo_teoria<>"*" and ls_gpo_lab="*" then
						if ((dw_materias.Find(ls_condicion_mat_teoria+" and "+ls_condicion_gpo_teoria,1,totmi) = 0 and &
						     (lb_teoria_aprobada=false) ) &
						     or &
							 (dw_materias.Find(ls_condicion_mat_lab,1,totmi) = 0 and &
							  (lb_laboratorio_aprobado=false) ) &
						     or &
							 (dw_materias.Find(ls_condicion_mat_lab,1,totmi) > 0 and &
							  (lb_teoria_aprobada = true) and (ldc_creditos_laboratorio = 0) ) ) then
							 if li_ligado_actual= li_num_ligados then
								commit;
								messagebox("La materia requiere inscribir un grupo particular","Es necesario que el alumno inscriba la materia"+&
							         " ["+string(teoria)+"] en el grupo ["+ls_gpo_teoria+"] ~r Y cursar el laboratorio ["&
										+string(lab)+"].",Exclamation!) 
								return 1						
							end if
						else
							li_ligado_actual= li_ligado_actual+li_num_ligados
						end if										
					//El grupo del laboratorio debe ser específico
					elseif ls_gpo_teoria="*" and ls_gpo_lab<>"*" then
						if ((dw_materias.Find(ls_condicion_mat_teoria,1,totmi) = 0 and &
						     (lb_teoria_aprobada=false)) &
						     or &
							 (dw_materias.Find(ls_condicion_mat_lab+" and "+ls_condicion_gpo_lab,1,totmi) = 0  and &
							  (lb_laboratorio_aprobado=false)) &
						     or &
							 (dw_materias.Find(ls_condicion_mat_lab+" and "+ls_condicion_gpo_lab,1,totmi) > 0 and &
							  (lb_teoria_aprobada = true) and (ldc_creditos_laboratorio = 0) ) ) then
							 if li_ligado_actual= li_num_ligados then
								commit;
								messagebox("El laboratorio requiere inscribir un grupo particular","Es necesario que el alumno inscriba el laboratorio ["&
											+string(lab)+"] en el grupo ["+ls_gpo_lab+"]~r Y cursar la materia ["+string(teoria)+"].",Exclamation!) 
								return 1						
							end if
						else
							li_ligado_actual= li_ligado_actual+li_num_ligados
						end if										
					//No importa el grupo de ambas
					elseif ls_gpo_teoria="*" and ls_gpo_lab="*" then
						if ((dw_materias.Find(ls_condicion_mat_teoria,1,totmi) = 0 and &
						     (lb_teoria_aprobada=false)) &
						     or &
							 (dw_materias.Find(ls_condicion_mat_lab,1,totmi) = 0 and &
							  (lb_laboratorio_aprobado=false)) &
						     or &
							 (dw_materias.Find(ls_condicion_mat_lab,1,totmi) > 0 and &
							  (lb_teoria_aprobada = true) and (ldc_creditos_laboratorio = 0) ) ) then
							 if li_ligado_actual= li_num_ligados then
								commit;
								messagebox("Falta inscribir una materia o laboratorio","Es necesario que el alumno inscriba el laboratorio ["&
											+string(lab)+"]~r Y cursar la materia ["+string(teoria)+"].",Exclamation!) 
								return 1						
							end if
						else
							li_ligado_actual= li_ligado_actual+li_num_ligados
						end if										
					end if					
					li_ligado_actual= li_ligado_actual+1
				LOOP 	
				
				
			next
			return 0
		elseif tottl < 0 then//Error
			mensaje = sqlca.sqlerrtext
			commit;
			messagebox("ERROR en la Consulta de teoria_lab","Intente Imprimir más tarde")
			return 1
		else	//No hay materias a revisar
			commit;
			return 0
		end if
	else
		return 0
	end if
else //No hay alumno a revisar
	return 0 
end if

end function

public function integer revisa_tipo_periodo (long al_cuenta_alumno);
STRING ls_tipo_periodo

SELECT tipo_periodo 
INTO :ls_tipo_periodo
FROM plan_estudios 
WHERE cve_carrera = :I_CarreraAlumno
AND cve_plan = :I_PlanAlumno
USING SQLCA;
IF SQLCA.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar el tipo de periodo asociado al plan de estudios: " + SQLCA.SQLERRTEXT)
	RETURN -1
END IF


// Se verifica si el tipo de periodo de la carrera y el plan corresponde al tipo de periodo de trabajo de la ventana.
IF ls_tipo_periodo <> gs_tipo_periodo THEN 
	MESSAGEBOX("Aviso", "El plan de estudios del alumno no es de tipo: " + gs_descripcion_periodo)
	RETURN -1
END IF 


RETURN 0





end function

public function integer obten_cred_max (long carrera, long plan);//Carlos Armando Melgoza Piña 								Abril 1997
//Revisa el numero maximo de creditos por semestre permitidos para un alumno



  SELECT plan_estudios.cred_max_sem, plan_estudios.cred_max_verano   
    INTO :I_cms, :ie_max_cred_verano
    FROM plan_estudios  
   WHERE ( plan_estudios.cve_carrera = :carrera ) AND  
         ( plan_estudios.cve_plan = :plan )   ;
IF ISNULL(I_cms) THEN I_cms = 0
IF ISNULL(ie_max_cred_verano) THEN ie_max_cred_verano = 0

if sqlca.sqlcode = 0 then
	commit;
else
	commit;
 	I_cms = 60
end if
			

STRING ls_mensaje
			
// Se verifica que dato es nulo. 
IF ISNULL(I_cms) OR ISNULL(ie_max_cred_verano) THEN 
	IF ISNULL(I_cms) THEN 
		ls_mensaje = " créditos máximos por semestre "
	ELSE
		ls_mensaje = " créditos máximos en verano "
	END IF
	MESSAGEBOX("Error", " El plan de estudios no tiene registrados " + ls_mensaje)
	RETURN -1
END IF
			
RETURN 0


end function

public function integer revisa_prerrequisito_especial (long mat, long cuenta);INTEGER le_existe
LONG cvmat
LONG ll_total 

// Se verifica si la materia solicitada tiene un prerrequisito especial.
SELECT COUNT(*) 
INTO :le_existe 
FROM prerrequisitos_esp 
WHERE cve_mat =  :mat
AND	cve_carrera = :I_CarreraAlumno
AND	cve_plan = :I_PlanAlumno ;
	
// Si no tiene prerrequisito especial, termina la validación
IF 	le_existe = 0 THEN RETURN 0 

SELECT cve_prerreq 
INTO :cvmat 
FROM prerrequisitos_esp 
WHERE cve_mat =  :mat
AND	cve_carrera = :I_CarreraAlumno
AND	cve_plan = :I_PlanAlumno ;
	
	
//*Se verifica que se haya cursado la materia*//	 
CHOOSE CASE nivel
		
	CASE 'P'
		
		SELECT COUNT(*)  
			INTO :ll_total
		  FROM historico_pos_re
		WHERE ( historico_pos_re.cuenta = :cuenta ) AND  
					  ( historico_pos_re.cve_mat = :cvmat ) AND 
					  ( historico_pos_re.cve_carrera	=	:I_CarreraAlumno ) AND
					  ( historico_pos_re.cve_plan	=	:I_PlanAlumno ) 
					  USING SQLCA;						
			
	CASE ELSE
			
		SELECT COUNT(*)
			INTO :ll_total  
		  FROM historico_re  
		WHERE ( historico_re.cuenta = :cuenta ) AND  
					  ( historico_re.cve_mat = :cvmat ) AND 
					  ( historico_re.cve_carrera	=	:I_CarreraAlumno ) AND
					  ( historico_re.cve_plan	=	:I_PlanAlumno ) 
					  USING SQLCA;

END CHOOSE 	

IF ll_total <= 0 THEN RETURN 0
//**//			
	
	
//Si la materia fué cursada se valida que haya sido aprobada	
CHOOSE CASE nivel
		
	CASE 'P'
		
		SELECT historico_pos_re.cve_mat  
			INTO :cvmat  
		  FROM historico_pos_re
		WHERE ( historico_pos_re.cuenta = :cuenta ) AND  
					  ( historico_pos_re.cve_mat = :cvmat ) AND 
					  ( historico_pos_re.cve_carrera	=	:I_CarreraAlumno ) AND
					  ( historico_pos_re.cve_plan	=	:I_PlanAlumno ) AND
					  ( historico_pos_re.calificacion IN ("AC","6","7","8","9","10", "MB","B","S","E","RE"))
					  USING SQLCA;						
			
	CASE ELSE
			
		SELECT historico_re.cve_mat  
			INTO :cvmat  
		  FROM historico_re  
		WHERE ( historico_re.cuenta = :cuenta ) AND  
					  ( historico_re.cve_mat = :cvmat ) AND 
					  ( historico_re.cve_carrera	=	:I_CarreraAlumno ) AND
					  ( historico_re.cve_plan	=	:I_PlanAlumno ) AND
					  ( historico_re.calificacion IN ("AC","6","7","8","9","10", "MB","B","S","E","RE"))
					  USING SQLCA;

END CHOOSE 


IF SQLCA.SQLCODE = 100 THEN 
	messagebox("Faltan prerequisitos", "El alumno con número de cuenta "+string(cuenta)+" no ha cursado todos ~rlos prerequisitos para la materia "+string(mat)+".",Exclamation!)
	return 1	
ELSEIF SQLCA.SQLCODE = 0 THEN 
	RETURN 0
ELSEIF SQLCA.SQLCODE < 0 THEN 
	commit;
	messagebox("Error de Comunicación","Error con la consulta de prerequisitos BD. Favor de intentar nuevamente", None!)
	return 1//Error en la comunicación con la base de datos .	
END IF 

RETURN 0


//
//
//
//
//
//END IF 
//
//
//
//CREATE TABLE dbo.prerrequisitos_esp
//	(
//	cve_mat     INT NOT NULL,
//	cve_carrera INT NOT NULL,
//	cve_plan    int1 NOT NULL,
//	cve_prerreq INT NOT NULL,
//	enlace      tipo_enlace NULL,
//	orden       int1 NOT NULL
//	)
//	LOCK ALLPAGES
//GO
//
//
//
//
//
//
//// Se verifica si la materia está en el histórico.
//
//
//
//
//
//
//
//
//
//
//
//
//
////Carlos Armando Melgoza Piña 									Marzo 1997
////Función que revisa si el  alumno cumplió todos los prerrequisitos para cursar una materia
////Regresa un 0 si los prerrequisitos fueron cumplidos y 1 en caso contrario
//long cvmat/*, cvcarrera, cvplan*/,respuesta
//int cont, verifica,c,bandera=0,op3=0
//char enlace,cumple='N'/*Variable que indica si se cumplieron los prerrequisitos*/
//c= 0
//		respuesta = dw_prerre.retrieve(mat,I_CarreraAlumno,I_PlanAlumno)
//		
//		if respuesta = 0 then  //Consulta los prerrequisitos de la materia 
//			commit;/*Si la materia no tiene prerrequisitos continua el proceso*/
//			return 0
//		elseif respuesta > 0 then
//			commit;/*Si la materia tiene prerrequisitos se revisa si se cumplen*/
//			for cont = 1 to dw_prerre.rowcount() // Revisión de los prerrequisitos en la tabla historico
//				cvmat	=	dw_prerre.object.cve_prerreq[cont]
//				enlace	=	dw_prerre.object.enlace[cont]
//	intento:	 
//				choose case nivel
//						
//				case 'P'
//					SELECT historico_pos_re.cve_mat  
//						INTO :cvmat  
//					  FROM historico_pos_re
//					WHERE ( historico_pos_re.cuenta = :cuenta ) AND  
//								  ( historico_pos_re.cve_mat = :cvmat ) AND 
//								  ( historico_pos_re.cve_carrera	=	:I_CarreraAlumno ) AND
//								  ( historico_pos_re.cve_plan	=	:I_PlanAlumno ) AND
//								  ( historico_pos_re.calificacion IN ("AC","6","7","8","9","10", "MB","B","S","E","RE"));						
//						
//				//case 'L'
//			    case else 
//					SELECT historico_re.cve_mat  
//						INTO :cvmat  
//					  FROM historico_re  
//					WHERE ( historico_re.cuenta = :cuenta ) AND  
//								  ( historico_re.cve_mat = :cvmat ) AND 
//								  ( historico_re.cve_carrera	=	:I_CarreraAlumno ) AND
//								  ( historico_re.cve_plan	=	:I_PlanAlumno ) AND
//								  ( historico_re.calificacion IN ("AC","6","7","8","9","10", "MB","B","S","E","RE"));
////				case 'T'
////					SELECT historico_re.cve_mat  
////						INTO :cvmat  
////					  FROM historico_re  
////					WHERE ( historico_re.cuenta = :cuenta ) AND  
////								  ( historico_re.cve_mat = :cvmat ) AND 
////								  ( historico_re.cve_carrera	=	:I_CarreraAlumno ) AND
////								  ( historico_re.cve_plan	=	:I_PlanAlumno ) AND
////								  ( historico_re.calificacion IN ("AC","6","7","8","9","10", "MB","B","S","E","RE"));
//
//				end choose
//
////Comentado Ene2014 SFF
////				if	nivel = 'L' then
////					SELECT historico_re.cve_mat  
////						INTO :cvmat  
////					  FROM historico_re  
////					WHERE ( historico_re.cuenta = :cuenta ) AND  
////								  ( historico_re.cve_mat = :cvmat ) AND 
////								  ( historico_re.cve_carrera	=	:I_CarreraAlumno ) AND
////								  ( historico_re.cve_plan	=	:I_PlanAlumno ) AND
////								  ( historico_re.calificacion IN ("AC","6","7","8","9","10", "MB","B","S","E","RE"));
////				else
////					SELECT historico_pos_re.cve_mat  
////						INTO :cvmat  
////					  FROM historico_pos_re
////					WHERE ( historico_pos_re.cuenta = :cuenta ) AND  
////								  ( historico_pos_re.cve_mat = :cvmat ) AND 
////								  ( historico_pos_re.cve_carrera	=	:I_CarreraAlumno ) AND
////								  ( historico_pos_re.cve_plan	=	:I_PlanAlumno ) AND
////								  ( historico_pos_re.calificacion IN ("AC","6","7","8","9","10", "MB","B","S","E","RE"));
////				end if
//								  
//				 revisa_rows()				  
//				 
//				  if sqlca.sqlcode = 100 then//Este if se ejecuta si el alumno no ha llevado esa materia
//						commit;
//						if cont > 1 then
//							if (isnull(enlace) and dw_prerre.object.enlace[cont - 1]	=	'Y')	 then
//								op3 = 1
//							else
//								op3 = 0
//							end if
//						else
//							op3 = 0
//						end if
//						
//						if (	(	enlace = 'Y'	) or (isnull(enlace) and cont	=	1) or op3 = 1	)	then	//Si el	alumno no 
//																																		//	ha cursado la materia
//																								// y es requerida se le niega la inscripción de la materia				
//							messagebox("Faltan prerequisitos", "El alumno con número de cuenta "+string(cuenta)+" no ha cursado todos ~rlos prerequisitos para la materia "+string(mat)+".",Exclamation!)
//							return 1	
//						end if
//				  elseif sqlca.sqlcode = 0 then//Si el alumno ya curso la materia
//					if enlace = 'O' then
//						cumple	=	'S'
//						cont++
//					else 
//						bandera = 1
//					end if
//				  elseif sqlca.sqlcode < 0 then
//					commit;
//					if c < 5 then
//						c++
//						goto intento
//					end if
//					messagebox("Error de Comunicación","Error con la consulta de historico BD. Favor de intentar nuevamente", None!)
//					return 1		//			error bd						
//				  end if
//				  commit;
//			next
//		elseif respuesta < 0 then
//				commit;
//				messagebox("Error de Comunicación","Error con la consulta de prerequisitos BD. Favor de intentar nuevamente", None!)
//				return 1//Error en la comunicación con la base de datos .
//		end if	
//		if (	(	bandera	=	0 and cumple	=	'S'	) or bandera	=	1	) then
//			return 0
//		else
//			messagebox("Faltan prerequisitos", "El alumno con número de cuenta "+string(cuenta)+" no ha cursado todos ~rlos prerequisitos para la materia "+string(mat)+".",Exclamation!)
//			return 1
//		end if
//	return 0
//
end function

public function integer revisa_creditos (long cta, decimal cred_act);//Carlos Armando Melgoza Piña 													Marzo 1997	
//Función que revisa si el alumno no ha sobrepasado el limite maximo de creditos
//Regresa 0 si se permiten y 1 en caso contrario
int cont
long /*cvcarrera, cvplan,*/crd_max

cont = 0
crd_max = verifica_extension(cta) 

if  crd_max = 0 then
	if g_per = 1 then
		//crd_max = 20
		// Se hace el cambio para considerar el número de créditos máximos en verano por plan-carrera
		crd_max = ie_max_cred_verano
	else
		// Si la bandera de extensión de créditos no tiene valor asignado, asigna el máximo de créditos del plan-carrera 
		crd_max = I_cms//Variable que contiene el número maximo de creditos por plan y carrera	
	end if
end if		  
if crd_max >= cred_act then return 0

//if obten_carr_plan(cta,cvcarrera,cvplan) = 0 then//Función que consulta la carrera y el plan de un alumno
intento:
if gi_nivel_usuario > 10 then	  
	 SELECT activacion_su.exceso_creditos  
	    	    INTO :ex_cred  
		 FROM activacion_su  
		 WHERE tipo_periodo = :gs_tipo_periodo; 
end if
if sqlca.sqlcode <> 0 then
	commit;
	if cont < 5 then
		cont++
		goto intento
	end if			
	messagebox("Error de Comunicación","Error con la consulta de activación BD. Favor de intentar nuevamente", None!)
	return 1
end if
commit;
if ex_cred = 0 then //si no se permite exceso de creditos
	messagebox("Excede limite de créditos","Se ha sobrepasado el limite de créditos. Esta materia no podra inscribirse.",Exclamation!)
	return 1
else
	return 0
end if			


end function

public function integer existe_materia (long cvmat, ref string mat, ref decimal crd, ref integer hrst, ref integer hrsp);//Carlos Armando Melgoza Piña 													Marzo 1997	
//Función que revisa si la materia existe en el catalogo de mat. Si existe regresa el nombre y creditos de la materia
//Regresa 0 si existe y 1 en caso contrario
int cont
cont = 0
intento:
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
   WHERE materias.cve_mat = :cvmat   ;
	
	if sqlca.sqlcode = 0 then
		commit;
		return 0
	else
		if sqlca.sqlcode = 100 then
			commit;
			messagebox("La materia no existe","La materia con clave "+string(cvmat)+" no existe. Favor de verificar.",Exclamation!)		
			return 1
		else
			commit;
			if cont < 5 then//Realiza cinco intentos para efectuar el select
				cont++
				goto intento
			end if
		end if
			commit;
			messagebox("Error de Comunicación","Error con la consulta de materias BD. Favor de intentar nuevamente",None!)						
			return 1 //Error en la comunicación con la BD
	end if

end function

public function integer f_crea_servicios_mat_sep ();// Funciòn que inicializa los servicios de materias con clave única SEP 

IF ISVALID(iuo_servicios_manresa) THEN DESTROY iuo_servicios_manresa 

iuo_servicios_manresa = CREATE uo_servicios_manresa 

iuo_servicios_manresa.il_cuenta = il_cuenta
iuo_servicios_manresa.il_cve_carrera = I_CarreraAlumno
iuo_servicios_manresa.ie_cve_plan = I_PlanAlumno 
iuo_servicios_manresa.ie_periodo = g_per
iuo_servicios_manresa.ie_anio = g_anio 

iuo_servicios_manresa.itr_trans = sqlca 


RETURN 0 





end function

public function integer f_inserta_mat_sep (long al_cve_mat, string as_gpo);string columna 
int ultimo

//columna = getcolumnname()

if long(uo_nombre.em_cuenta.text) > 0 then
	if dw_materias.getitemnumber(dw_materias.rowcount(),1) > 0 and dw_materias.getitemstring(dw_materias.rowcount(),2) <> " " then
		dw_materias.insertrow(0)
		agrega_mat()
	end if
	
	//if columna = "grupos_gpo"  or columna = "grupos_cve_mat"  then
		dw_materias.scrolltorow(dw_materias.rowcount())
		dw_materias.setitem(dw_materias.rowcount(),"mat_inscritas_cve_mat", al_cve_mat)
		dw_materias.setfocus()
		visible = false		
		dw_materias.setcolumn("mat_inscritas_cve_mat")
		dw_materias.triggerevent(itemchanged!)	
		if dw_materias.getitemnumber(dw_materias.rowcount(),"mat_inscritas_cve_mat") > 0 then
			dw_materias.setitem(dw_materias.rowcount(),"mat_inscritas_gpo", as_gpo)
			dw_materias.setfocus()		
			dw_materias.setcolumn("mat_inscritas_gpo")
			dw_materias.triggerevent(itemchanged!)	
		end if
	//end if
	
	
	
	
end if 

RETURN 0
end function

on w_reinscripcion_2014.create
if this.MenuName = "m_reinscripcion_2014" then this.MenuID = create m_reinscripcion_2014
this.cb_2=create cb_2
this.st_sistema=create st_sistema
this.p_ibero=create p_ibero
this.cb_1=create cb_1
this.dw_pase_ingreso=create dw_pase_ingreso
this.st_inic=create st_inic
this.st_1=create st_1
this.dw_reinsc_mat=create dw_reinsc_mat
this.dw_materias=create dw_materias
this.dw_ext_h=create dw_ext_h
this.dw_prerre=create dw_prerre
this.dw_cursada=create dw_cursada
this.dw_comprobante=create dw_comprobante
this.r_1=create r_1
this.dw_mat_pase_ingreso=create dw_mat_pase_ingreso
this.uo_nombre=create uo_nombre
this.dw_grupos_disponibles=create dw_grupos_disponibles
this.dw_mat_integ=create dw_mat_integ
this.dw_labs=create dw_labs
this.dw_horario_mat=create dw_horario_mat
this.dw_grupos_disp=create dw_grupos_disp
this.Control[]={this.cb_2,&
this.st_sistema,&
this.p_ibero,&
this.cb_1,&
this.dw_pase_ingreso,&
this.st_inic,&
this.st_1,&
this.dw_reinsc_mat,&
this.dw_materias,&
this.dw_ext_h,&
this.dw_prerre,&
this.dw_cursada,&
this.dw_comprobante,&
this.r_1,&
this.dw_mat_pase_ingreso,&
this.uo_nombre,&
this.dw_grupos_disponibles,&
this.dw_mat_integ,&
this.dw_labs,&
this.dw_horario_mat,&
this.dw_grupos_disp}
end on

on w_reinscripcion_2014.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_2)
destroy(this.st_sistema)
destroy(this.p_ibero)
destroy(this.cb_1)
destroy(this.dw_pase_ingreso)
destroy(this.st_inic)
destroy(this.st_1)
destroy(this.dw_reinsc_mat)
destroy(this.dw_materias)
destroy(this.dw_ext_h)
destroy(this.dw_prerre)
destroy(this.dw_cursada)
destroy(this.dw_comprobante)
destroy(this.r_1)
destroy(this.dw_mat_pase_ingreso)
destroy(this.uo_nombre)
destroy(this.dw_grupos_disponibles)
destroy(this.dw_mat_integ)
destroy(this.dw_labs)
destroy(this.dw_horario_mat)
destroy(this.dw_grupos_disp)
end on

event open;//Carlos Armando Melgoza Piña 										Marzo 1997
//Inicialización de la ventana y sus componentes

dw_teoria_lab = Create DataStore
dw_teoria_lab_ligados = Create DataStore

dw_comprobante.settransobject(sqlca)
dw_mat_pase_ingreso.settransobject(sqlca)
dw_pase_ingreso.settransobject(sqlca)

dw_comprobante.modify("Datawindow.print.preview = Yes")
//dw_plan.settransobject(sqlca)
dw_materias.settransobject(sqlca)
dw_labs.settransobject(sqlca)
dw_grupos_disp.settransobject(sqlca)

dw_grupos_disponibles.settransobject(sqlca)


dw_mat_integ.settransobject(sqlca)
dw_horario_mat.settransobject(sqlca)
dw_prerre.settransobject(sqlca)
dw_teoria_lab.dataobject = "d_teoria_lab"
dw_teoria_lab.SetTransObject(sqlca)
dw_teoria_lab_ligados.dataobject = "d_teoria_lab"
dw_teoria_lab_ligados.SetTransObject(sqlca)
if gi_nivel_usuario = 1 then
	dw_cursada.dataobject = "dw_cursada"
else
	dw_cursada.dataobject = "dw_cursada_pos"
end if
dw_cursada.settransobject(sqlca)
dw_reinsc_mat.settransobject(sqlca)
dw_reinsc_mat.retrieve()
lectura_parametros()//Se cargan los parametros fijos para la reinscripcion
uo_nombre.em_cuenta.setfocus()
//g_nv_security.fnv_secure_window(this)

if not isvalid(iuo_administrador_liberacion) then
	iuo_administrador_liberacion = CREATE uo_administrador_liberacion	
end if

//**--**
// Función que carga las materias y areas relacionadas con temas fundamentales y temas de integración.
STRING ls_query
INTEGER le_num_rgs

// Se define query que recupera las relaciones entre materias y areas de integración. 
ls_query = " SELECT DISTINCT am.cve_area, am.cve_mat, ~~'integracion~~' " + &
				" FROM area_mat am " + &
				" WHERE am.cve_area IN(SELECT DISTINCT pe5.cve_area_integ_fundamental   as area FROM plan_estudios pe5  ) " + &
				" UNION  " + &
				" SELECT DISTINCT am.cve_area, am.cve_mat, ~~'reflexion1~~' " + &
				" FROM area_mat am  " + &
				" WHERE am.cve_area IN(SELECT DISTINCT pe1.cve_area_integ_tema1   as area FROM plan_estudios pe1  ) " + &
				" UNION  " + &
				" SELECT DISTINCT am.cve_area, am.cve_mat, ~~'reflexion2~~' " + &
				" FROM area_mat am  " + &
				" WHERE am.cve_area IN(SELECT DISTINCT pe2.cve_area_integ_tema2   as area FROM plan_estudios pe2  ) " + &
				" UNION  " + &
				" SELECT DISTINCT am.cve_area, am.cve_mat, ~~'reflexion3~~' " + &
				" FROM area_mat am  " + &
				" WHERE am.cve_area IN(SELECT DISTINCT pe3.cve_area_integ_tema3   as area FROM plan_estudios pe3  ) " + &
				" UNION  " + &
				" SELECT DISTINCT am.cve_area, am.cve_mat, ~~'reflexion4~~' " + &
				" FROM area_mat am  " + &
				" WHERE am.cve_area IN(SELECT DISTINCT pe4.cve_area_integ_tema4   as area FROM plan_estudios pe4  ) " 

ids_area_mat = CREATE DATASTORE 
ids_area_mat.DATAOBJECT = "d_area_mat_temas" 
ids_area_mat.MODIFY("Datawindow.Table.Select = '" + ls_query + "'") 
ids_area_mat.SETTRANSOBJECT(sqlca)
le_num_rgs = ids_area_mat.RETRIEVE()
IF le_num_rgs < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar las areas asociadas a temas de integración." )
	RETURN -1 	
END IF
//**--**

f_obten_titulo(w_srl)

p_ibero.PictureName = gs_logo

end event

event timer;//Carlos Armando Melgoza Piña										Abril 1997
//Evento en el cual se realiza el refresh de las ventanas de grupos disponibles

long area

if dw_grupos_disp.visible = true then
	dw_materias.triggerevent("verhorariodisp")
elseif dw_mat_integ.visible = true then
	area = dw_mat_integ.getitemnumber(1,"area_mat_cve_area")	
	dw_materias.triggerevent("verhorariodispinteg",0,area)
end if
end event

event activate;//srl.toolbarsheettitle="Reinscripción en Linea"























end event

event closequery;if revisa_labs(long(this.uo_nombre.em_cuenta.text)) = 0 then
	return 0
else
	return 1
end if
end event

event close;Destroy dw_teoria_lab

if isvalid(iuo_administrador_liberacion) then
	DESTROY iuo_administrador_liberacion 
end if

end event

event doubleclicked;//Carlos Armando Melgoza Piña 											Marzo 1997
//Ejecuta los procesos de validación de un alumno para permitir la inscripción
//Proceso que en epocas ancestrales se ejecutaba con un doble click
//Evento creado en mayo de 1998
//DkWf
int h,d
long cta
long ll_historico_actualizado, ll_rows_mat_pase_ingreso, ll_rows_pase_ingreso
string ls_dig

SetPointer(HourGlass!)
band_bloq	=	0
aceptado=0

cta = long(uo_nombre.em_cuenta.text)
if il_cuenta = 0 then
	il_cuenta = cta
else
	if il_cuenta <> cta then
		if revisa_labs(il_cuenta) <> 0 then 
			uo_nombre.em_cuenta.text = string(il_cuenta)
			ls_dig = uo_nombre.of_obten_digito(il_cuenta)
			uo_nombre.em_cuenta.text = string(il_cuenta) + ls_dig
			uo_nombre.em_cuenta.triggerevent("activarbusq")	
			return
		end if
		il_cuenta = cta
	end if
end if
I_CarreraAlumno = uo_nombre.of_obten_carrera()
I_PlanAlumno = uo_nombre.of_obten_plan()
ii_vigente = uo_nombre.istr_carrera.str_vigente

dw_materias.reset()
dw_ext_h.reset()
dw_ext_h.triggerevent(constructor!)
limpia_comprobante()
dw_mat_pase_ingreso.Reset()
dw_pase_ingreso.Reset()
//cred_integ = 0
	for d = 1 to 7
		for h = 1 to 15
			hora[h].dia[d] = 0
		next	
	next
	

	
if ii_vigente = 0 then	
	MessageBox("Error","Debe escoger una carrera vigente", StopSign!)
	return
end if
		
if cta > 0 then
	if  revisa_nip(cta) = 1 then		/*El nip es correcto*/	
		
		//**--****--****--****--****--****--****--****--****--****--****--****--****--****--**
		// Se verifica si el periodo al que está inscrito el alumno corresponde al periodo de operaciones de la ventana
		IF revisa_tipo_periodo(cta) < 0 THEN 
			borrado_cuenta()  //  Inicializa el numero de cuenta en 0		
			RETURN 0
		END IF
		//**--****--****--****--****--****--****--****--****--****--****--****--****--****--**
	
		ll_historico_actualizado = f_historico_actualizado(cta, g_per, g_anio)
		if	ll_historico_actualizado >= 1 and ll_historico_actualizado <> 100 then 
			if llenabanderas(cta,BanderasAlumno) = 0	then	/******Atencion***********/
//				if obten_carr_plan(cta,I_CarreraAlumno,I_PlanAlumno) = 0 then	/******Atencion***********/
				if I_CarreraAlumno > 0 then
					IF obten_cred_max(I_CarreraAlumno,I_PlanAlumno) < 0 THEN
						borrado_cuenta()  //  Inicializa el numero de cuenta en 0		
						RETURN 0						
					END IF
					ll_rows_mat_pase_ingreso = dw_mat_pase_ingreso.Retrieve(cta)
					ll_rows_pase_ingreso = dw_pase_ingreso.Retrieve(cta)
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
							revisa_baja_laboratorio(cta) 	//Función que revisa si el alumno está bloqueado por adeudos de material de laboratorio
							//Termina revisión de bloqueos
							if band_bloq	=	0	then
								if revisa_hora_insc(cta) = 0 then //Función que revisa si el alumno está en la hora correcta de inscripción.
//									dw_plan.retrieve(cta)
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
											dw_cursada.settransobject(sqlca)
//										elseif nivel = 'L' then
										elseif nivel <> 'P' then
											dw_cursada.dataobject = "dw_cursada"
											dw_cursada.settransobject(sqlca)
										end if
									end if
									dw_materias.event actualizahorario()
								else
									borrado_cuenta()  //  Inicializa el numero de cuenta en 0									
								end if		
							else
								messagebox("Alumno BLOQUEADO",bloqueado_por,stopsign!)
								f_obten_titulo(w_srl)
								borrado_cuenta()								
							end if			
						else 
							borrado_cuenta()//  Inicializa el numero de cuenta en 0							
						end if
					else
						borrado_cuenta()// Inicializa el número de cuenta en 0					
					end if
				else
					borrado_cuenta()// Inicializa el número de cuenta en 0				
				end if
			else
				borrado_cuenta()// Inicializa el número de cuenta en 0			
			end if			
		else
			MessageBox("No se ha actualizado el histórico del alumno", "Favor de acudir a Servicios Escolares para asignarle horario", StopSign!)
			borrado_cuenta()// Inicializa el número de cuenta en 0			
		end if			
	else
		borrado_cuenta()// Inicializa el número de cuenta en 0			
	end if
else
//	if dw_plan.retrieve(0) = 0 then
//		dw_plan.insertrow(0)
//	end if
end if
SetPointer(Arrow!)


end event

type cb_2 from commandbutton within w_reinscripcion_2014
boolean visible = false
integer x = 3689
integer y = 100
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;OPEN(w_valida_cruce) 


//LONG cta
//LONG mat
//STRING gpo
//
//
////  Carlos Armando Melgoza Piña  									Marzo 1997
////  Función que revisa si no existe ninguna materia inscrita en ese horario 
////  Regresa 0 si no se enciman materias y 1 en caso contrario
//
//Integer	li_resultado			// Oscar Sánchez, 13-Septiembre-2018. La validación de horario debe ser por medio del llamado a un SP
//String		ls_mensaje			// Oscar Sánchez, 13-Septiembre-2018. La validación de horario debe ser por medio del llamado a un SP
//Integer	li_materia_cruce	// Oscar Sánchez, 13-Septiembre-2018. La validación de horario debe ser por medio del llamado a un SP
//String		ls_grupo_cruce		// Oscar Sánchez, 13-Septiembre-2018. La validación de horario debe ser por medio del llamado a un SP
//String		ls_sesionado
//int d,h, cont,c,verif
////long año
////int per
////periodo_actual_insc(per,año)
//
//LONG ll_materias
//LONG ll_pos 
//
//DATASTORE lds_cuentas  
//lds_cuentas = CREATE DATASTORE 
//lds_cuentas.DATAOBJECT = "dw_cuentas_revisa" 
//lds_cuentas.SETTRANSOBJECT(SQLCA) 
//ll_materias = lds_cuentas.RETRIEVE() 
//
//FOR ll_pos = 1 TO ll_materias 
//
//
//	DECLARE  sp_validacion_materias_encimadas PROCEDURE FOR sp_srl_validacion_materias_enc
//	@CUENTA				= :cta,
//	@MATERIA				= :mat,
//	@GRUPO					= :gpo,
//	@RESULTADO			= :li_resultado OUTPUT,
//	@MENSAJE				= :ls_mensaje OUTPUT,
//	@MATERIA_CRUCE	= :li_materia_cruce OUTPUT,
//	@GRUPO_CRUCE		= :ls_grupo_cruce OUTPUT;
//	
//	EXECUTE sp_validacion_materias_encimadas;
//	
//	FETCH sp_validacion_materias_encimadas INTO :li_resultado, :ls_mensaje, :li_materia_cruce, :ls_grupo_cruce, :ls_sesionado;
//	
//	CLOSE sp_validacion_materias_encimadas;
//		
//	IF	li_resultado <> 0 THEN
//		MessageBox ("El horario se encima", "El alumno con número de cuenta "+string(cta)+" no puede inscribir la materia " + String (mat) + " grupo '" + gpo + "'. ~rTiene inscrita la materia " + String (li_materia_cruce) + " grupo '" + ls_grupo_cruce + "' en horario similar al de la materia que se quiere inscribir.",Exclamation!)
//		Return 1
//	END IF
//	Commit;
//	
//NEXT 	
//
//Return 0
//
//

/*
c = 0
intento1:
	verif = dw_horario_mat.retrieve(mat,gpo,G_per,g_anio)
	if verif >= 0 then
		for cont = 1 to dw_horario_mat.rowcount()
			d  = dw_horario_mat.getitemnumber(cont,"cve_dia")
			d++
			for h = dw_horario_mat.getitemnumber(cont,"hora_inicio") to  dw_horario_mat.getitemnumber(cont,"hora_final") - 1
				if hora[h - 6].dia[d]  = 1 then
				 intento:	
					if gi_nivel_usuario > 10 then
						  SELECT activacion_su.materias_encimadas  
							        INTO :mat_enci
							FROM activacion_su  
							WHERE tipo_periodo = :gs_tipo_periodo;
					end if
					 if sqlca.sqlcode <> 0 then
						commit;
						if c < 5 then
							c++
							goto intento
						end if
						messagebox("Error de Comunicación","Error con la consulta de activacion BD. Favor de intentar nuevamente", None!)
						return 1
					end if
					commit;
					if mat_enci  = 1 then // Se permite encimar
						return 0
					else
						messagebox("El horario se encima", "El alumno con número de cuenta "+string(cta)+" no puede inscribir esta materia. ~rTiene otra materia inscrita en este horario.",Exclamation!)
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
		messagebox("Error de Comunicación","Error con la consulta de horarios BD. Favor de intentar nuevamente", None!)
		return 1
	end if
*/
end event

type st_sistema from statictext within w_reinscripcion_2014
integer x = 727
integer y = 96
integer width = 229
integer height = 100
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 16777215
string text = "DSE"
boolean focusrectangle = false
end type

type p_ibero from picture within w_reinscripcion_2014
integer x = 18
integer y = 28
integer width = 681
integer height = 264
string picturename = "logoibero-web.png"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_reinscripcion_2014
boolean visible = false
integer x = 3927
integer y = 1932
integer width = 713
integer height = 112
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprime Pase de Ingreso"
end type

event clicked;integer li_confirmacion, li_impresion
if dw_pase_ingreso.RowCount()>0 then

	li_confirmacion = MessageBox("Confirme Impresión","Desea Imprimir el pase de ingreso", Question!, YesNo!)
	if li_confirmacion = 1 then
		li_impresion = dw_pase_ingreso.Print()
		if li_impresion = -1 then
			MessageBox("Error de Impresión", "No es posible imprimir el pase de ingreso", StopSign!)
		end if
	end if
else
	MessageBox("Información Inexistente", "NO existe Información de alumno para imprimir el pase de ingreso", StopSign!)	
end if
end event

type dw_pase_ingreso from datawindow within w_reinscripcion_2014
boolean visible = false
integer x = 3963
integer y = 1900
integer width = 686
integer height = 400
integer taborder = 40
string title = "none"
string dataobject = "d_pase_ingreso"
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_inic from statictext within w_reinscripcion_2014
integer x = 37
integer y = 2028
integer width = 562
integer height = 44
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
boolean enabled = false
string text = " A.P.R. - F.M.C"
alignment alignment = center!
long bordercolor = 15793151
boolean focusrectangle = false
end type

type st_1 from statictext within w_reinscripcion_2014
integer x = 1070
integer y = 2028
integer width = 613
integer height = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Otoño 2018  18/09/18"
boolean focusrectangle = false
end type

type dw_reinsc_mat from datawindow within w_reinscripcion_2014
boolean visible = false
integer x = 626
integer y = 1996
integer width = 494
integer height = 228
integer taborder = 70
string dataobject = "dw_reinscripcion_materias"
boolean livescroll = true
end type

type dw_materias from datawindow within w_reinscripcion_2014
event keyboard pbm_dwnkey
event borramat ( )
event verhorariodisp ( )
event verhorariodispinteg ( long area )
event laboratorios ( )
event actualizahorario ( )
integer x = 18
integer y = 924
integer width = 2587
integer height = 1004
integer taborder = 30
string dataobject = "dw_mat_inscritas_2014"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event keyboard;long cvmat
int col

col = getcolumn()
if keyflags= 6 then
	col = 2
end if
if key = keyenter! or key = keytab! then
	if col = 2  then	
		accepttext()
		return 0
	end if
end if

if key = KeyDownArrow! then
	if rowcount() = 0 and uo_nombre.em_cuenta.text <> " " then
		insertrow(0)
		agrega_mat()
		return 1		
	elseif uo_nombre.em_cuenta.text = " " then
		return 0
	end if
	
	if getrow() = rowcount() then  //Agrega un renglón si se esta en el último y se presiona la tecla key down arrow
		if getitemnumber(getrow(),1) > 0 and getitemstring(getrow(),2) <> " " then
			insertrow(0)
			scrolltorow(rowcount())
			agrega_mat()			
			setcolumn("mat_inscritas_cve_mat")
		end if
	end if
elseif key = KeyA! or key =  KeyB! or key =  KeyC! or key =  KeyD! or key =  KeyE! or key =  KeyF! or &
		key =  KeyG! or key =  KeyH! or key =  KeyI! or key =  KeyJ! or key =  KeyK! or key =  KeyL! or &
		key =  KeyM! or key =  KeyN! or key =  KeyO! or key =  KeyP! or key =  KeyQ! or key =  KeyR! or &
		key =  KeyS! or key =  KeyT! or key =  KeyU! or key =  KeyV! or key =  KeyW! or key =  KeyX! or &
		key =  KeyY! or key =  KeyZ! then		
	if col = 2 then
		if getrow() = rowcount() then			
				if getitemnumber(getrow(),1) > 0 and getitemstring(getrow(),2) <> " " then				
					messagebox("Atención", "No es posible modificar el grupo de una materia inscrita",Exclamation!)
					setitem(getrow(),2,getitemstring(getrow(),2,primary!,true))		
					return 1
				else
					return 0
				end if			
		else	
			messagebox("Atención", "No es posible modificar el grupo de una materia inscrita",Exclamation!)
			setitem(getrow(),2,getitemstring(getrow(),2,primary!,true))			
			return 1
		end if
	end if
//elseif key = Key0! or key = Key1! or key = Key2! or key = Key3! or key = Key4! or key = Key5! or key = Key6! or&
//		key = Key7! or key = Key8! or key = Key9! or key = Keynumpad1! or key = Keynumpad2! or key = Keynumpad3!&
//		or key = Keynumpad4! or key = Keynumpad5! or key = Keynumpad6! or key = Keynumpad7! or key = Keynumpad8!&
//		or key = Keynumpad9! or key = Keynumpad0! then	
//	if col = 1  then
//		if getrow() = rowcount() then
//			if getitemnumber(getrow(),1) > 0 and getitemstring(getrow(),2) <> " " then		
//				messagebox("Atención", "No es posible modificar la clave de una materia inscrita",Exclamation!)
//				setitem(getrow(),1,getitemnumber(getrow(),1,primary!,true))	
//				return 0
//			else
//				return 1
//			end if
//		else			
//			messagebox("Atención", "No es posible modificar la clave de una materia inscrita",Exclamation!)
//			setitem(getrow(),1,getitemnumber(getrow(),1,primary!,true))			
//			return 1
//		end if
//	elseif col = 2 then
//		return 0
//	end if	
end if
return 0
end event

event borramat();//Carlos Armando Melgoza Piña								Marzo 1997
//Evento encargado del borrado de una materia y
//la actualización correspondiente en alumnos inscritos en la tabla de grupos
long cvmat, ll_rowcount, ll_getrow, ll_cuenta
string gpo, ls_gpo, ls_materia

ll_rowcount = rowcount()
ll_cuenta = long(uo_nombre.em_cuenta.text)
if ll_rowcount	>	0 then
	ll_getrow = getrow()
	ls_materia = getitemstring(ll_getrow,"materias_materia")
	if isnull(ls_materia) then 
		deleterow(RowCount())
		return
	else
		cvmat = getitemnumber(ll_getrow,"mat_inscritas_cve_mat",Primary!,False) // Lectura de la cve de la mat
		gpo = getitemstring(ll_getrow,"mat_inscritas_gpo",Primary!,False) // Lectura del gpo de la mat
		ls_gpo = getitemstring(ll_getrow,2)
	end if
	if ll_getrow = 0 then return 
	if getitemnumber(getrow(),1) > 0 and ls_gpo <> " " then
		if revisa_per_insc_mat(ll_cuenta,cvmat,gpo) = 0 then //Revisa que la materia a dar de baja sea de este periodo (Altas o Insc)			
				//deleterow(getrow())
				deleterow(ll_getrow)		
				if borra_mat_insc(ll_cuenta,cvmat,gpo) = 0 then		//borra la materia de materias inscritas del alumno
				//if update() = 1 then
					commit;
					actualiza_struct_horario(cvmat,gpo,0)	//Actualización de la estructura de horario		
					//deleterow(getrow())	//borra el renglon				
					dw_materias.retrieve(ll_cuenta)
					
					dw_ext_h.event Constructor()	//	Oscar Sánchez		 17-Sep-2018 Inicializar la visualizacion de los horarios
					event actualizahorario()			//	Oscar Sánchez		 17-Sep-2018 Refrescar los horarios después de borrar
					
					if rowcount() <= 0 then //Inserta nuevo renglon para evitar errores				
					  dw_materias.insertrow(0)
						agrega_mat()
					  dw_materias.setfocus()
					end if
				//else
				//	rollback;
				//end if
			else
				rollback;		
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

event verhorariodisp();//Carlos Armando Melgoza Piña											Marzo 1997	
//Evento utilizado para desplegar/Ocultar  los horarios disponibles de una materia
long cvmat//,año
//int per
// 
//periodo_actual_insc(per,año)

if rowcount() > 0  then
	cvmat = getitemnumber(getrow(),"mat_inscritas_cve_mat")
	if cvmat <> 0 then
		if dw_grupos_disp.retrieve(cvmat,G_per,G_anio) = 0 then
			commit;
			dw_grupos_disp.insertrow(0)	
			dw_grupos_disp.visible = False
			timer(0)
			messagebox("No hay grupos disponibles","La materia " +string(cvmat)+" no tiene grupos disponibles, o todos están llenos.",Information!)
		else
			commit;
			dw_grupos_disp.visible = True
			timer(45)
		end if
	end if
end if
	
end event

event verhorariodispinteg(long area);//Carlos Armando Melgoza Piña											Marzo 1997	
//Evento utilizado para desplegar/Ocultar  los horarios disponibles de una materia de integración

string numarea

LONG ll_cve_area_integ_fundamental 
LONG ll_cve_area_integ_tema1 
LONG ll_cve_area_integ_tema2 
LONG ll_cve_area_integ_tema3 
LONG ll_cve_area_integ_tema4 
STRING ls_cve_sep_unica
LONG ll_cve_area_sep


area = Message.LongParm

IF LEN(TRIM(uo_nombre.em_cuenta.text)) = 0 THEN 
	MESSAGEBOX("Aviso", "Debe seleccionar un alumno.") 
	RETURN 
ELSEIF NOT ISNUMBER(uo_nombre.em_cuenta.text) THEN 
	MESSAGEBOX("Aviso", "La cuenta de alumno no es válida.") 
	RETURN 	
END IF 


SELECT cve_area_integ_fundamental, cve_area_integ_tema1, cve_area_integ_tema2, cve_area_integ_tema3, cve_area_integ_tema4, mat_cve_sep_unica 
INTO :ll_cve_area_integ_fundamental, :ll_cve_area_integ_tema1,  :ll_cve_area_integ_tema2,  :ll_cve_area_integ_tema3,  :ll_cve_area_integ_tema4,  :ls_cve_sep_unica 
FROM plan_estudios 
WHERE cve_plan = :I_PlanAlumno 
AND cve_carrera = :I_CarreraAlumno 
USING SQLCA; 

// Si el plan de estudios maneja claves únicas de materias ante la SEP, se crea objeto de servicios.
IF ls_cve_sep_unica = 'S' THEN 
	
	// Se crean los servicios de materias SEP	
	f_crea_servicios_mat_sep()  
	
	CHOOSE CASE area 
		CASE 0 
			iuo_servicios_manresa.il_area = ll_cve_area_integ_fundamental 
		CASE 1
			iuo_servicios_manresa.il_area = ll_cve_area_integ_tema1
		CASE 2
			iuo_servicios_manresa.il_area = ll_cve_area_integ_tema2
		CASE 3
			iuo_servicios_manresa.il_area = ll_cve_area_integ_tema3
		CASE 4	
			iuo_servicios_manresa.il_area = ll_cve_area_integ_tema4
	END CHOOSE 
	
	iuo_servicios_manresa.of_selecciona_materia_sep() 
	
LONG ll_cve_mat_sel 
STRING ls_gpo_sel 
LONG ll_cve_mat_SEP 
	
ll_cve_mat_sel = iuo_servicios_manresa.il_cve_mat_sel
ls_gpo_sel = iuo_servicios_manresa.is_gpo_sel 
ll_cve_mat_SEP = iuo_servicios_manresa.ll_cve_mat_sep_sel

//	MESSAGEBOX("", STRING(iuo_servicios_manresa.il_cve_mat_sel) + " " + iuo_servicios_manresa.is_gpo_sel + " " + STRING(iuo_servicios_manresa.ll_cve_mat_sep_sel))
	
f_inserta_mat_sep(iuo_servicios_manresa.il_cve_mat_sel, iuo_servicios_manresa.is_gpo_sel)
	
iuo_servicios_manresa.of_inserta_mat_insc_sep_area( ll_cve_mat_sel, ls_gpo_sel, iuo_servicios_manresa.il_area)	
	
//	
//	 
//	iuo_servicios_manresa.ll_cve_mat_sep_sel

	
	
	RETURN 
	
	
ELSE 

	// Se verifica el tipo de tema que se solicita.
	CHOOSE CASE area
		CASE 0
			numarea = "fundamental"
			dw_mat_integ.title ="Grupos disponibles para materias de Integración" 
			area = ll_cve_area_integ_fundamental
			IF ISNULL(ll_cve_area_integ_fundamental) OR ll_cve_area_integ_fundamental = 0 THEN 
				MESSAGEBOX("Aviso", "El plan de estudios del alumno no tiene asignadas Materias de Integración.") 
				RETURN 
			END IF
		CASE 1
			numarea = "I"
			dw_mat_integ.title = "Grupos disponibles para materias de Reflexión Universitaria" 
			area = ll_cve_area_integ_tema1
			IF ISNULL(ll_cve_area_integ_tema1) OR ll_cve_area_integ_tema1 = 0 THEN 
				MESSAGEBOX("Aviso", "El plan de estudios del alumno no tiene asignadas materias de Reflexión Universitaria I.") 
				RETURN 
			END IF			
		CASE 2
			numarea = "II"
			dw_mat_integ.title = "Grupos disponibles para materias de Reflexión Universitaria" 
			area = ll_cve_area_integ_tema2
			IF ISNULL(ll_cve_area_integ_tema2) OR ll_cve_area_integ_tema2 = 0 THEN 
				MESSAGEBOX("Aviso", "El plan de estudios del alumno no tiene asignadas materias de Reflexión Universitaria II.") 
				RETURN 
			END IF						
		CASE 3
			numarea = "III"
			dw_mat_integ.title = "Grupos disponibles para materias de Reflexión Universitaria" 
			area = ll_cve_area_integ_tema3
			IF ISNULL(ll_cve_area_integ_tema3) OR ll_cve_area_integ_tema3 = 0 THEN 
				MESSAGEBOX("Aviso", "El plan de estudios del alumno no tiene asignadas materias de Reflexión Universitaria III.") 
				RETURN 
			END IF						
		CASE 4
			numarea = "IV"
			dw_mat_integ.title = "Grupos disponibles para materias de Reflexión Universitaria" 
			area = ll_cve_area_integ_tema4
			IF ISNULL(ll_cve_area_integ_tema4) OR ll_cve_area_integ_tema4 = 0 THEN 
				MESSAGEBOX("Aviso", "El plan de estudios del alumno no tiene asignadas materias de Reflexión Universitaria IV.") 
				RETURN 
			END IF						
	END CHOOSE
	
	
			
	if dw_mat_integ.retrieve(area,G_per,G_anio) = 0 then		
		commit;
		dw_mat_integ.insertrow(0)	
		messagebox("No hay grupos disponibles","El tema " +numarea+" de integración no tiene grupos disponibles.",Exclamation!)
		dw_mat_integ.visible = False
		timer(0)
	else
		commit;
		dw_mat_integ.visible = True
		timer(45)
	end if
	
END IF 







//// long año
//// int per
//// periodo_actual_insc(per,año)
//if long(uo_nombre.em_cuenta.text) > 0 then
//	
//	
//	
//	
//	
//	
//
//area = Message.LongParm
//	
//	if I_PlanAlumno >= 6 then
//		if nivel = 'L' then
//			choose case area
//				case 2201, 8977, 8978, 8979, 8990
//					numarea = "fundamental"
//					dw_mat_integ.title ="Grupos disponibles para materias de Integración"						
////					return 
//				case 2202
//					area =  8061
//					numarea = "I"
//					dw_mat_integ.title ="Grupos disponibles para materias de Reflexión Universitaria"
//				case 2203
//					area =  8062
//					numarea = "II"
//					dw_mat_integ.title ="Grupos disponibles para materias de Reflexión Universitaria"
//				case 2204
//					area =  8063
//					numarea = "III"
//					dw_mat_integ.title ="Grupos disponibles para materias de Reflexión Universitaria"
//				case 2205
//					area =  8064
//					numarea = "IV"
//					dw_mat_integ.title ="Grupos disponibles para materias de Reflexión Universitaria"
//			end choose	
//		elseif nivel = 'T' then
//			choose case area
//				case 2201
//					area =  335
//					numarea = "I"
//					dw_mat_integ.title ="Grupos disponibles para materias de Reflexión Universitaria"
//				case 2202
//					area =  336
//					numarea = "I"
//					dw_mat_integ.title ="Grupos disponibles para materias de Reflexión Universitaria"
//				case 2203
//					return 
//				case 2204
//					return 
//				case 2205
//					return					
//			end choose				
//		end if
//	else
//		choose case area
//			case 2201, 8977, 8978, 8979, 8990
//				numarea = "fundamental"
//				dw_mat_integ.title ="Grupos disponibles para materias de Integración"
//			case 2202
//				numarea = "I"
//				dw_mat_integ.title ="Grupos disponibles para materias de Integración"
//			case 2203
//				numarea = "II"
//				dw_mat_integ.title ="Grupos disponibles para materias de Integración"
//			case 2204
//				numarea = "III"
//				dw_mat_integ.title ="Grupos disponibles para materias de Integración"
//			case 2205
//				numarea = "IV"
//				dw_mat_integ.title ="Grupos disponibles para materias de Integración"
//		end choose	
//	end if
//	
//	if dw_mat_integ.retrieve(area,G_per,G_anio) = 0 then		
//		commit;
//		dw_mat_integ.insertrow(0)	
//		messagebox("No hay grupos disponibles","El tema " +numarea+" de integración no tiene grupos disponibles.",Exclamation!)
//		dw_mat_integ.visible = False
//		timer(0)
//	else
//		commit;
//		dw_mat_integ.visible = True
//		timer(45)
//	end if
//
//end if

// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 
// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 

////Carlos Armando Melgoza Piña											Marzo 1997	
////Evento utilizado para desplegar/Ocultar  los horarios disponibles de una materia de integración
//
//string numarea
//
//// long año
//// int per
//// periodo_actual_insc(per,año)
//if long(uo_nombre.em_cuenta.text) > 0 then
//	area = Message.LongParm
//	
//	if I_PlanAlumno >= 6 then
//		if nivel = 'L' then
//			choose case area
//				case 2201, 8977, 8978, 8979, 8990
//					numarea = "fundamental"
//					dw_mat_integ.title ="Grupos disponibles para materias de Integración"						
////					return 
//				case 2202
//					area =  8061
//					numarea = "I"
//					dw_mat_integ.title ="Grupos disponibles para materias de Reflexión Universitaria"
//				case 2203
//					area =  8062
//					numarea = "II"
//					dw_mat_integ.title ="Grupos disponibles para materias de Reflexión Universitaria"
//				case 2204
//					area =  8063
//					numarea = "III"
//					dw_mat_integ.title ="Grupos disponibles para materias de Reflexión Universitaria"
//				case 2205
//					area =  8064
//					numarea = "IV"
//					dw_mat_integ.title ="Grupos disponibles para materias de Reflexión Universitaria"
//			end choose	
//		elseif nivel = 'T' then
//			choose case area
//				case 2201
//					area =  335
//					numarea = "I"
//					dw_mat_integ.title ="Grupos disponibles para materias de Reflexión Universitaria"
//				case 2202
//					area =  336
//					numarea = "I"
//					dw_mat_integ.title ="Grupos disponibles para materias de Reflexión Universitaria"
//				case 2203
//					return 
//				case 2204
//					return 
//				case 2205
//					return					
//			end choose				
//		end if
//	else
//		choose case area
//			case 2201, 8977, 8978, 8979, 8990
//				numarea = "fundamental"
//				dw_mat_integ.title ="Grupos disponibles para materias de Integración"
//			case 2202
//				numarea = "I"
//				dw_mat_integ.title ="Grupos disponibles para materias de Integración"
//			case 2203
//				numarea = "II"
//				dw_mat_integ.title ="Grupos disponibles para materias de Integración"
//			case 2204
//				numarea = "III"
//				dw_mat_integ.title ="Grupos disponibles para materias de Integración"
//			case 2205
//				numarea = "IV"
//				dw_mat_integ.title ="Grupos disponibles para materias de Integración"
//		end choose	
//	end if
//		if dw_mat_integ.retrieve(area,G_per,G_anio) = 0 then		
//			commit;
//			dw_mat_integ.insertrow(0)	
//			messagebox("No hay grupos disponibles","El tema " +numarea+" de integración no tiene grupos disponibles.",Exclamation!)
//			dw_mat_integ.visible = False
//			timer(0)
//		else
//			commit;
//			dw_mat_integ.visible = True
//			timer(45)
//		end if
//	end if
end event

event laboratorios;//Carlos Armando Melgoza Piña							Abril 1997
//Evento en el cual se despliegan los laboratorios asimilados a una materia
long cvmat//,año
//int per
//periodo_actual_insc(per,año)

if rowcount() > 0 then	
	cvmat = getitemnumber(getrow(),"mat_inscritas_cve_mat")
	
		if dw_labs.retrieve(cvmat,G_per,G_anio) = 0 then
			commit;
			dw_labs.insertrow(0)	
			messagebox("No hay grupos disponibles","La materia " +string(cvmat)+" no tiene grupos disponibles.",Exclamation!)
			dw_labs.visible = False
			timer(0)
		else
			commit;
			dw_labs.visible = True
			timer(45)
		end if
end if

end event

event actualizahorario();//Carlos Amando Melgoza Piña										Marzo 1997
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
int hrst,hrsp
decimal crd
//valores para aceptado 0 Se acepto la materia 1 no se acepto la materia 2 no se acepto el grupo
//Si sobrepaso el número de creditos  tiene en aceptado 3

setpointer(Hourglass!)
accepttext()
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
				//if revisa_prerrequisito(cvmat,long(uo_nombre.em_cuenta.text)) = 0 then //Revisa si el alumno ha cursado los prerequisitos necesarios para la materia
				if revisa_prerrequisito(cvmat,long(uo_nombre.em_cuenta.text)) = 0 AND revisa_prerrequisito_especial(cvmat,long(uo_nombre.em_cuenta.text)) = 0 then //Revisa si el alumno ha cursado los prerequisitos necesarios para la materia
					if revisa_cursada(cvmat,long(uo_nombre.em_cuenta.text)) = 0 then //Revisa si el alumno habia cursado la materia
						if revisa_creditos(long(uo_nombre.em_cuenta.text),getitemdecimal(getrow(),"creditos_totales")) = 0 then	//Revisa si los creditos maximos del alumno no han sido sobrepasados
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
	gpo = Upper ( getitemstring(getrow(),columna,Primary!,False) ) // Lectura del gpo de la mat
	if gpo_existe(cvmat,gpo) = 0 then // Revisión de grupo existente
	 	if revisa_gpo_bloqueado(cvmat,gpo) = 0  then  //Revisión de grupo bloqueado	  		
			if revisa_horario(cvmat,gpo,long(uo_nombre.em_cuenta.text)) = 0 then //Revisión de materias encimadas
				gpo_existe(cvmat,gpo)
				if gpo_lleno(cvmat,gpo) = 0 then //Revisión de grupo lleno
					ii_cve_mat = cvmat
					is_gpo = gpo
					if dw_materias.update(TRUE) = 1 then //Realiza la actualización de materias inscritas						
						commit;			
						// Se despliega la modalidad del grupo 
						STRING ls_modalidad 
						SELECT grupo_modalidad.descripcion 
						INTO :ls_modalidad 
						FROM grupos, grupo_modalidad 
						WHERE grupos.cve_mat = :cvmat 
						AND grupos.gpo = :gpo 
						AND grupos.periodo = :G_per 
						AND grupos.anio = :G_anio 
						AND grupos.modalidad = grupo_modalidad.id_modalidad 
						USING SQLCA; 
						IF ISNULL(ls_modalidad ) THEN ls_modalidad  = "" 
						setitem(getrow(),"grupo_modalidad_descripcion",ls_modalidad)
						
						
						actualiza_struct_horario(cvmat,gpo,1)
						crd_ant = cred_integ		
						scrolltorow(insertrow(0))
						agrega_mat()
						setcolumn("mat_inscritas_cve_mat") 	
						parent.uo_nombre.em_cuenta.enabled = false
						parent.uo_nombre.dw_nombre_alumno.enabled = false
						setpointer(Arrow!)
						return 1
					else
						//2009-11-05: Se añadió el el rollback en el evento DBError y para enviar el error
						//rollback;
					end if			
				end if
			end if		
		end if
	end if
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

event doubleclicked;triggerevent("verhorariodisp")	

return 1
end event

event rowfocuschanged;//Carlos Armando Melgoza Piña										Abril 1997	
//Evento que coloca el cursor en el campo materia en el cambio de renglon


//dw_materias.SetRow(currentrow)
dw_materias.SelectRow ( 0, false )
dw_materias.SelectRow ( currentrow, true )


if getrow() = rowcount() then
	setcolumn("mat_inscritas_cve_mat")
	dw_materias.SelectRow ( 0, false )
end if

end event

event retrieveend;//Carlos Amando Melgoza Piña										Marzo 1997
//Evento en el cual se verifica el total de materias de integración inscritas.

int cont,cred,d,h,ren
long cvmat,area
string gpo
long ll_cve_mat[64]

cred_integ = 0
//for con = 1 to 64 ll_cve_mat = 0

for cont = 1 to rowcount()
	ll_cve_mat[cont] = getitemnumber(cont,"mat_inscritas_cve_mat") //Lectura de materia inscrita
next
if rowcount() > 0 then
	DataStore lds_creditos_integ
	lds_creditos_integ = Create DataStore
	lds_creditos_integ.DataObject = "d_creditos_integ"
	lds_creditos_integ.SetTransObject(sqlca)
	if (lds_creditos_integ.Retrieve(ll_cve_mat) = 1) then
		cred_integ = lds_creditos_integ.GetItemDecimal(1,"suma")
	else
		MessageBox("Error de comunicación","Error con la consulta de areas materias BD. Favor de intentar nuevamente", None!)
		cred_integ = 100
	end if
	Destroy lds_creditos_integ
end if
if isnull(cred_integ) then cred_integ = 0	
crd_ant = cred_integ


	
	
	
//	SELECT area_mat.cve_area  
//   		 INTO :area  
//	    FROM area_mat  
//   	 WHERE area_mat.cve_mat = :cvmat   ;

//	  if sqlca.sqlcode = 0 then
//		if area = 2201 or area = 2202 or area = 2203 or area = 2204 or area = 2205 then  //Revisión de area
//			  cred  = getitemnumber(cont,"materias_creditos")					 	 
//			  cred_integ = cred_integ + cred //incremento de materias de integracion					
//		end if			 							
//	  else			
//		
//	  end if
//next
//
//crd_ant = cred_integ
end event

event dberror;////2009_11_05: Se añadió para detectar y notificar los errores de permisos

rollback ;
MessageBox("Error al actualizar la materia ["+string(ii_cve_mat)+"-"+is_gpo+"]",sqlerrtext,StopSign!)
return 1

end event

type dw_ext_h from datawindow within w_reinscripcion_2014
integer x = 2610
integer y = 920
integer width = 4009
integer height = 1668
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ext_horario_2014"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;int cont
string rango_hora

for cont = 1 to 15
	rango_hora = string(cont+6)+" - "+string(cont+7)
	insertrow(0)
	setitem(cont,"horario",rango_hora)
	//	Oscar Sánchez		 17-Sep-2018 Los valores de cada hora de cada día se inicializan para que el datawindow dibuje los bordes ...
	setitem(cont,"domingo","-")
	setitem(cont,"lunes","-")
	setitem(cont,"martes","-")
	setitem(cont,"miercoles","-")
	setitem(cont,"jueves","-")
	setitem(cont,"viernes","-")
	setitem(cont,"sabado","-")
next
end event

event itemfocuschanged;//Evento en el que se selecciona la materia desde el horario
//CAMP									abril 1998
long materia
int cont

materia	=	long(dwo.primary[row])
//dw_materias.SelectRow ( linea_select, false )	
for cont	=	1 to dw_materias.rowcount()
	if dw_materias.object.mat_inscritas_cve_mat[cont] = materia	then	
		dw_materias.SetRow(cont)
//		dw_materias.SelectRow ( 0, false )
//		dw_materias.SelectRow ( cont, true )
//		linea_select	=	cont
	end if			
next
dw_materias.setfocus()
//dw_materias.setrow(linea_select)

end event

type dw_prerre from datawindow within w_reinscripcion_2014
boolean visible = false
integer x = 32
integer y = 472
integer width = 128
integer height = 192
boolean bringtotop = true
string dataobject = "dw_prerrequisito_2014"
boolean border = false
end type

type dw_cursada from datawindow within w_reinscripcion_2014
boolean visible = false
integer x = 14
integer y = 364
integer width = 206
integer height = 260
boolean bringtotop = true
string dataobject = "dw_cursada_2014"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_comprobante from datawindow within w_reinscripcion_2014
boolean visible = false
integer x = 146
integer y = 412
integer width = 3397
integer height = 1548
integer taborder = 20
string dataobject = "dw_comprobante_insc"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type r_1 from rectangle within w_reinscripcion_2014
long linecolor = 16711680
integer linethickness = 3
long fillcolor = 255
integer x = 3497
integer y = 2140
integer width = 87
integer height = 76
end type

type dw_mat_pase_ingreso from datawindow within w_reinscripcion_2014
integer x = 41
integer y = 2188
integer width = 2235
integer height = 1000
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Materias - Recomendadas"
string dataobject = "d_mat_pase_ingreso_2014"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;////Antonio Pica Ruiz									Junio 2007
//Modificacion:	05-Agosto-2008 	Se solicitó que no permita elegir materias desde este datawindow
//
////Evento utilizado para desplegar
////Ocultar  los horarios disponibles de una materia
//long ll_row_materias, ll_cve_mat, ll_cve_mat_exis, ll_cve_mat_post_event, ll_cuenta
//integer li_ret_cve_mat, li_ret_gpo
//string columna, ls_gpo
//
//ll_cuenta = long(uo_nombre.em_cuenta.text)
//
////int per	
//// 
////periodo_actual_insc(per,año)
//SetPointer(HourGlass!)
//if rowcount() > 0  then
//	//Obtiene la lista de materias del pase de ingreso
//	ll_cve_mat = getitemnumber(getrow(),"cve_mat")
//
//	if ll_cve_mat <> 0 then		
//		ll_row_materias = dw_materias.getrow()
//		//Ya hay renglones insertados de materias
//		if ll_row_materias > 0 then 			
//			ll_cve_mat_exis= dw_materias.GetItemNumber(ll_row_materias, "mat_inscritas_cve_mat")
//			ls_gpo= dw_materias.GetItemString(ll_row_materias, "mat_inscritas_gpo")
//			
//			//Si ya existen materias insertadas y la actual es mayor a cero, inserta un renglon nuevo
//			if ll_cve_mat_exis > 0 then
//				if isnull(ls_gpo) or len(trim(ls_gpo))=0 then
//					SetPointer(UpArrow!)
//					MessageBox("Materia elegida", "Favor de terminar la captura del grupo actual, antes de elegir otra materia", StopSign!)					
//					dw_materias.SetFocus()
//					dw_materias.SetColumn("mat_inscritas_gpo")
//					SetPointer(Arrow!)
//					return			
//				else
//					ll_row_materias =dw_materias.insertrow(0)				
//					agrega_mat()								
//				end if
//			end if 	
//		else
//		//No hay renglones insertados de materias
//			ll_row_materias =dw_materias.insertrow(0)
//			agrega_mat()
//		end if
//				
////		if dw_materias.event keyboard(KeyA!,6) = 0 then
//			dw_materias.SetRow(ll_row_materias)
//			dw_materias.setitem(ll_row_materias,"mat_inscritas_cve_mat", ll_cve_mat)
//			dw_materias.setcolumn("mat_inscritas_cve_mat")
//			dw_materias.setfocus()		
//			li_ret_cve_mat = dw_materias.triggerevent(itemchanged!)
//			if li_ret_cve_mat = 1 then
//				ll_cve_mat_post_event = dw_materias.GetItemNumber(ll_row_materias,"mat_inscritas_cve_mat")		
//			end if
////		end if		
//	end if
//end if
//
//SetPointer(Arrow!)
//	
////if rowcount() > 0  then
////	ll_cve_mat = getitemnumber(getrow(),"cve_mat")
////	if ll_cve_mat <> 0 then
////		if dw_grupos_disponibles.retrieve(ll_cve_mat,G_per,G_anio) = 0 then
////			commit;
////			dw_grupos_disponibles.insertrow(0)	
////			dw_grupos_disponibles.visible = False
////			timer(0)
////			messagebox("No hay grupos disponibles","La materia " +string(ll_cve_mat)+" no tiene grupos disponibles, o todos están llenos.",Information!)
////		else
////			commit;
////			dw_grupos_disponibles.visible = True
////			timer(45)
////		end if
////	end if
////end if
//
//return 1
end event

type uo_nombre from uo_carreras_alumno_lista within w_reinscripcion_2014
event destroy ( )
integer x = 18
integer y = 316
integer taborder = 30
boolean bringtotop = true
end type

on uo_nombre.destroy
call uo_carreras_alumno_lista::destroy
end on

event constructor;call super::constructor;iw_ventana = parent
m_reinscripcion_2014.objeto = this

end event

type dw_grupos_disponibles from datawindow within w_reinscripcion_2014
boolean visible = false
integer x = 498
integer y = 840
integer width = 2057
integer height = 1252
integer taborder = 80
boolean titlebar = true
string title = "Horario de Grupos Disponibles - Recomendados"
string dataobject = "dw_grupos_libres_2014"
boolean controlmenu = true
boolean maxbox = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;string columna, ls_gpo
long ll_row_materias, ll_cve_mat, ll_cve_mat_post_event, ll_cuenta
integer li_ret_cve_mat, li_ret_gpo
ll_cuenta = long(uo_nombre.em_cuenta.text)

if long(uo_nombre.em_cuenta.text) > 0 then

	ll_row_materias = dw_materias.getrow()
	if ll_row_materias > 0 then 
		ll_cve_mat= dw_materias.GetItemNumber(ll_row_materias, "mat_inscritas_cve_mat")
		ls_gpo= dw_materias.GetItemString(ll_row_materias, "mat_inscritas_gpo")
		//Si ya existen materias insertadas y la actual es mayor a cero, inserta un renglon nuevo
		if ll_cve_mat > 0 then
			ll_row_materias =dw_materias.insertrow(0)
			agrega_mat()			
		end if 
	else
//		MessageBox("Inserte materia","Favor de insertar un registro antes de elegir grupos",StopSign!)
		ll_row_materias =dw_materias.insertrow(0)
		agrega_mat()
	end if
	
	columna = getcolumnname()
	dw_materias.setcolumn("mat_inscritas_gpo")
	
	if columna = "grupos_gpo" then
		if dw_materias.event keyboard(KeyA!,6) = 0 then
			ll_cve_mat = getitemNumber(getrow(),"grupos_cve_mat")
			dw_materias.setitem(ll_row_materias,"mat_inscritas_cve_mat", ll_cve_mat)
			dw_materias.setcolumn("mat_inscritas_cve_mat")
			dw_materias.setfocus()		
			li_ret_cve_mat = dw_materias.triggerevent(itemchanged!)
			if li_ret_cve_mat = 1 then
				ll_cve_mat_post_event = dw_materias.GetItemNumber(ll_row_materias,"mat_inscritas_cve_mat")
				if ll_cve_mat_post_event> 0 and (not isnull(ll_cve_mat_post_event)) then
					ls_gpo = getitemstring(getrow(),columna)
					dw_materias.setitem(ll_row_materias,"mat_inscritas_gpo", ls_gpo)
					dw_materias.setcolumn("mat_inscritas_gpo")
					dw_materias.setfocus()		
					li_ret_gpo = dw_materias.triggerevent(itemchanged!)
				end if	
			end if
		end if
		
	visible = false	
	dw_materias.setcolumn("mat_inscritas_gpo")	
	end if
end if

end event

event rbuttondown;long cve_mat
string gpo

if row = 0 then
	row = getrow()
end if

cve_mat	=	object.grupos_cve_mat[row]
gpo	= object.grupos_gpo[row]

obten_nomb_profesor(cve_mat,gpo)


end event

event losefocus;timer(0)

end event

type dw_mat_integ from datawindow within w_reinscripcion_2014
boolean visible = false
integer x = 526
integer y = 896
integer width = 2903
integer height = 1076
integer taborder = 60
boolean titlebar = true
string title = "Grupos disponibles de materias de Integración"
string dataobject = "dw_materias_integracion_2014"
boolean controlmenu = true
boolean maxbox = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event losefocus;timer(0)
end event

event doubleclicked;//string columna 
//int ultimo
//
//columna = getcolumnname()
//
//if long(uo_nombre.em_cuenta.text) > 0 then
//	if dw_materias.getitemnumber(dw_materias.rowcount(),1) > 0 and dw_materias.getitemstring(dw_materias.rowcount(),2) <> " " then
//		dw_materias.insertrow(0)
//		agrega_mat()
//	end if
//	
//	if columna = "grupos_gpo"  or columna = "grupos_cve_mat"  then
//		dw_materias.scrolltorow(dw_materias.rowcount())
//		dw_materias.setitem(dw_materias.rowcount(),"mat_inscritas_cve_mat",getitemnumber(getrow(),"grupos_cve_mat"))
//		dw_materias.setfocus()
//		visible = false		
//		dw_materias.setcolumn("mat_inscritas_cve_mat")
//		dw_materias.triggerevent(itemchanged!)	
//		if dw_materias.getitemnumber(dw_materias.rowcount(),"mat_inscritas_cve_mat") > 0 then
//			dw_materias.setitem(dw_materias.rowcount(),"mat_inscritas_gpo",getitemstring(getrow(),"grupos_gpo"))
//			dw_materias.setfocus()		
//			dw_materias.setcolumn("mat_inscritas_gpo")
//			dw_materias.triggerevent(itemchanged!)	
//		end if
//	end if
//end if
end event

event rbuttondown;long cve_mat
string gpo

if row = 0 then
	row = getrow()
end if

cve_mat	=	object.horario_cve_mat[row]
gpo	= object.horario_gpo[row]

obten_nomb_profesor(cve_mat,gpo)


end event

type dw_labs from datawindow within w_reinscripcion_2014
boolean visible = false
integer x = 526
integer y = 896
integer width = 2903
integer height = 1024
integer taborder = 50
boolean titlebar = true
string title = "Laboratorios asimilados a otra materia disponibles"
string dataobject = "dw_labs_2014"
boolean controlmenu = true
boolean maxbox = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rbuttondown;long cve_mat
string gpo

if row = 0 then
	row = getrow()
end if

cve_mat	=	object.teoria_lab_cve_lab[row]
gpo	= object.horario_gpo[row]

obten_nomb_profesor(cve_mat,gpo)


end event

type dw_horario_mat from datawindow within w_reinscripcion_2014
boolean visible = false
integer x = 2368
integer y = 2608
integer width = 3200
integer height = 500
boolean bringtotop = true
string dataobject = "dw_rev_hor_2014"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_grupos_disp from datawindow within w_reinscripcion_2014
event closedw pbm_dwescape
boolean visible = false
integer x = 498
integer y = 736
integer width = 3127
integer height = 1252
integer taborder = 80
boolean bringtotop = true
boolean titlebar = true
string title = "Horario de Grupos Disponibles"
string dataobject = "dw_grupos_libres_2014"
boolean controlmenu = true
boolean maxbox = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;string columna

if long(uo_nombre.em_cuenta.text) > 0 then
	columna = getcolumnname()
	dw_materias.setcolumn("mat_inscritas_gpo")
		
	if columna = "grupos_gpo" then
		if dw_materias.event keyboard(KeyA!,6) = 0 then
			dw_materias.setitem(dw_materias.getrow(),"mat_inscritas_gpo",getitemstring(getrow(),columna))
			dw_materias.setfocus()		
			dw_materias.triggerevent(itemchanged!)
		end if
		
	visible = false	
	dw_materias.setcolumn("mat_inscritas_gpo")	
	end if
end if
end event

event losefocus;timer(0)
end event

event rbuttondown;long cve_mat
string gpo

if row = 0 then
	row = getrow()
end if

cve_mat	=	object.grupos_cve_mat[row]
gpo	= object.grupos_gpo[row]

obten_nomb_profesor(cve_mat,gpo)


end event

