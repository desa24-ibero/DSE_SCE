$PBExportHeader$w_asigna_salones.srw
forward
global type w_asigna_salones from window
end type
type st_200 from statictext within w_asigna_salones
end type
type st_100 from statictext within w_asigna_salones
end type
type st_2 from statictext within w_asigna_salones
end type
type st_avance from statictext within w_asigna_salones
end type
type rb_cupo_alumnos from radiobutton within w_asigna_salones
end type
type rb_cupo_salon from radiobutton within w_asigna_salones
end type
type dw_salones from datawindow within w_asigna_salones
end type
type cb_2 from commandbutton within w_asigna_salones
end type
type sle_1 from singlelineedit within w_asigna_salones
end type
type st_porcentaje from statictext within w_asigna_salones
end type
type dw_horario from datawindow within w_asigna_salones
end type
type cbx_1 from checkbox within w_asigna_salones
end type
type cbx_reiniciar_salones from checkbox within w_asigna_salones
end type
type st_grupos_sin_salon from statictext within w_asigna_salones
end type
type hpb_avance_grupos from hprogressbar within w_asigna_salones
end type
type dw_grupos from datawindow within w_asigna_salones
end type
type st_1 from statictext within w_asigna_salones
end type
type st_inicio_fin from statictext within w_asigna_salones
end type
type ddlb_periodos from dropdownlistbox within w_asigna_salones
end type
type dw_activacion_inicio_fin_periodo from datawindow within w_asigna_salones
end type
type gb_1 from groupbox within w_asigna_salones
end type
type gb_2 from groupbox within w_asigna_salones
end type
end forward

global type w_asigna_salones from window
integer width = 4480
integer height = 2844
boolean titlebar = true
string menuname = "m_menu_asigna_salones"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean toolbarvisible = false
st_200 st_200
st_100 st_100
st_2 st_2
st_avance st_avance
rb_cupo_alumnos rb_cupo_alumnos
rb_cupo_salon rb_cupo_salon
dw_salones dw_salones
cb_2 cb_2
sle_1 sle_1
st_porcentaje st_porcentaje
dw_horario dw_horario
cbx_1 cbx_1
cbx_reiniciar_salones cbx_reiniciar_salones
st_grupos_sin_salon st_grupos_sin_salon
hpb_avance_grupos hpb_avance_grupos
dw_grupos dw_grupos
st_1 st_1
st_inicio_fin st_inicio_fin
ddlb_periodos ddlb_periodos
dw_activacion_inicio_fin_periodo dw_activacion_inicio_fin_periodo
gb_1 gb_1
gb_2 gb_2
end type
global w_asigna_salones w_asigna_salones

type variables
int anio_a_buscar,	periodo_a_buscar,num_periodos

transaction tipo_conexion

date inicio_periodo_academ, fin_periodo_academ


int	clave_materia_global
string	grupo_global

date	grupos_fecha_inicio_curso
date	grupos_fecha_fin_curso

n_tr itr_web
end variables

forward prototypes
public subroutine carga_grupos ()
end prototypes

public subroutine carga_grupos ();//anio_a_buscar=dw_activacion_inicio_fin_periodo.object.anio[index]
//periodo_a_buscar=dw_activacion_inicio_fin_periodo.object.periodo[index]
//inicio_periodo_academ=date(dw_activacion_inicio_fin_periodo.object.fecha_inicio_periodo[index])
//fin_periodo_academ=date(dw_activacion_inicio_fin_periodo.object.fecha_fin_periodo[index])

//st_inicio_fin.text='Periodo (dd/mm/aaaa): '+string(inicio_periodo_academ,"dd/mm/yyyy")+' - '+string(fin_periodo_academ,"dd/mm/yyyy")



dw_grupos.settransobject(tipo_conexion)
dw_grupos.retrieve(anio_a_buscar,periodo_a_buscar)

dw_grupos.title="Grupos. Se cargaron: "+string(dw_grupos.rowcount())

dw_horario.settransobject(tipo_conexion)

dw_horario.reset()

//dw_horario.retrieve(periodo_a_buscar,anio_a_buscar)

sle_1.visible=false
st_porcentaje.visible=false
sle_1.text="0"

end subroutine

on w_asigna_salones.create
if this.MenuName = "m_menu_asigna_salones" then this.MenuID = create m_menu_asigna_salones
this.st_200=create st_200
this.st_100=create st_100
this.st_2=create st_2
this.st_avance=create st_avance
this.rb_cupo_alumnos=create rb_cupo_alumnos
this.rb_cupo_salon=create rb_cupo_salon
this.dw_salones=create dw_salones
this.cb_2=create cb_2
this.sle_1=create sle_1
this.st_porcentaje=create st_porcentaje
this.dw_horario=create dw_horario
this.cbx_1=create cbx_1
this.cbx_reiniciar_salones=create cbx_reiniciar_salones
this.st_grupos_sin_salon=create st_grupos_sin_salon
this.hpb_avance_grupos=create hpb_avance_grupos
this.dw_grupos=create dw_grupos
this.st_1=create st_1
this.st_inicio_fin=create st_inicio_fin
this.ddlb_periodos=create ddlb_periodos
this.dw_activacion_inicio_fin_periodo=create dw_activacion_inicio_fin_periodo
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.st_200,&
this.st_100,&
this.st_2,&
this.st_avance,&
this.rb_cupo_alumnos,&
this.rb_cupo_salon,&
this.dw_salones,&
this.cb_2,&
this.sle_1,&
this.st_porcentaje,&
this.dw_horario,&
this.cbx_1,&
this.cbx_reiniciar_salones,&
this.st_grupos_sin_salon,&
this.hpb_avance_grupos,&
this.dw_grupos,&
this.st_1,&
this.st_inicio_fin,&
this.ddlb_periodos,&
this.dw_activacion_inicio_fin_periodo,&
this.gb_1,&
this.gb_2}
end on

on w_asigna_salones.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_200)
destroy(this.st_100)
destroy(this.st_2)
destroy(this.st_avance)
destroy(this.rb_cupo_alumnos)
destroy(this.rb_cupo_salon)
destroy(this.dw_salones)
destroy(this.cb_2)
destroy(this.sle_1)
destroy(this.st_porcentaje)
destroy(this.dw_horario)
destroy(this.cbx_1)
destroy(this.cbx_reiniciar_salones)
destroy(this.st_grupos_sin_salon)
destroy(this.hpb_avance_grupos)
destroy(this.dw_grupos)
destroy(this.st_1)
destroy(this.st_inicio_fin)
destroy(this.ddlb_periodos)
destroy(this.dw_activacion_inicio_fin_periodo)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;/******************************************************************************

Módulo de Asignación de Salones a Grupos.

Análisis, Diseño y Programación

César Ponce Hdz.

Ibero - Tijuana, Nov/2016



******************************************************************************/

w_asigna_salones.title="Asignación de Salones Ibero-Tijuana                                                Marzo/2017"

w_principal.toolbarvisible=false

tipo_conexion=gtr_sce

dw_activacion_inicio_fin_periodo.settransobject(tipo_conexion)
dw_salones.settransobject(tipo_conexion)

num_periodos=dw_activacion_inicio_fin_periodo.retrieve()

//ddlb_1.additem("1");
//ddlb_1.additem("2");

hpb_avance_grupos.position=0

if(num_periodos>0) then

	ddlb_periodos.insertitem(string(dw_activacion_inicio_fin_periodo.object.anio[1])+' - '+dw_activacion_inicio_fin_periodo.object.descripcion[1],1)

	anio_a_buscar=dw_activacion_inicio_fin_periodo.object.anio[1]
	periodo_a_buscar=dw_activacion_inicio_fin_periodo.object.periodo[1]
	inicio_periodo_academ=date(dw_activacion_inicio_fin_periodo.object.fecha_inicio_periodo[1])
	fin_periodo_academ=date(dw_activacion_inicio_fin_periodo.object.fecha_fin_periodo[1])

	inicio_periodo_academ=date(dw_activacion_inicio_fin_periodo.object.fecha_inicio_periodo[1])
	fin_periodo_academ=date(dw_activacion_inicio_fin_periodo.object.fecha_fin_periodo[1])



	ddlb_periodos.selectitem( 1)

	if (isnull(inicio_periodo_academ) or isnull(fin_periodo_academ)) then
		st_inicio_fin.text="Periodo (dd/mm/aaaa): EN NULO, NO SE PUEDEN ASIGNAR SALONES."	
		Messagebox("Advertencia!","No se pueden asignar salones, ~n~r La fecha de inicio - fin de periodo no pueden ser nulas! ~n~r Consulte la tabla CALENDARIO.")
		cb_2.enabled=false
		return
	else
		cb_2.enabled=true
	end if



	st_inicio_fin.text='Periodo (dd/mm/aaaa): '+string(inicio_periodo_academ,"dd/mm/yyyy")+' - '+string(fin_periodo_academ,"dd/mm/yyyy")
	carga_grupos()
else
	messagebox("Advertencia!","No Existen Periodos Academicos!")
	close(this)
end if

end event

event close;w_principal.toolbarvisible=true
end event

type st_200 from statictext within w_asigna_salones
boolean visible = false
integer x = 9
integer y = 540
integer width = 78
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "."
alignment alignment = right!
boolean focusrectangle = false
end type

event doubleclicked;st_100.visible=true
st_200.visible=false
messagebox("",string(reverse(".6102/ozraM ,anaujiT orebI~n~zdH ecnoP raseC")))

end event

type st_100 from statictext within w_asigna_salones
integer x = 9
integer y = 656
integer width = 78
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "."
alignment alignment = right!
boolean focusrectangle = false
end type

event doubleclicked;st_200.visible=true
st_100.visible=false
end event

type st_2 from statictext within w_asigna_salones
integer x = 2473
integer y = 580
integer width = 974
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Versión 9/ene/2017 3.39 a.m. (Tij)"
boolean focusrectangle = false
end type

type st_avance from statictext within w_asigna_salones
integer x = 123
integer y = 736
integer width = 1326
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Click en Asigna Salones para Iniciar Proceso"
boolean focusrectangle = false
end type

type rb_cupo_alumnos from radiobutton within w_asigna_salones
integer x = 617
integer y = 372
integer width = 544
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Alumnos Inscritos"
boolean checked = true
end type

event clicked;sle_1.visible=true
st_porcentaje.visible=true
end event

type rb_cupo_salon from radiobutton within w_asigna_salones
integer x = 151
integer y = 368
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cupo Salón"
end type

type dw_salones from datawindow within w_asigna_salones
integer x = 2683
integer y = 1496
integer width = 1207
integer height = 1004
integer taborder = 40
boolean titlebar = true
string title = "Salones"
string dataobject = "dw_lista_salones_para_asignar_cdmex"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_asigna_salones
integer x = 517
integer y = 560
integer width = 1815
integer height = 104
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Asigna Salones"
end type

event clicked;/******************************************************************************

Módulo de Asignación de Salones a Grupos.

Análisis, Diseño y Programación

César Ponce Hdz.

Ibero - Tijuana, Nov/2016



******************************************************************************/


long cont_renglones
long cont_horario

long renglones_grupos
long renglones_horario
long cont_salones
long renglones_salones
integer cupo_a_checar

integer hora_inicio,hora_fin,dia
integer hora_inicio_ant,hora_fin_ant,dia_ant
String salon,salon_ant

long reng_horarios_sem
long reng_horarios_trim
long reng_horarios_esp

boolean existe_empalme

boolean salir_ciclo

string sigla_plantel

long grupos_sin_salon

boolean le_encontre_salon

//int tipo_salon // CPH Jun/2015

string tipo_salon // Cambia a String por tabla salones de CD Mex CPH Nov/2015

//messagebox("",string(1 + (double(sle_1.text) / 100.0)));
//return;

grupos_sin_salon=0;

existe_empalme=false

renglones_grupos=dw_grupos.rowcount()


//em_num_horarios


/*

update horario set cve_salon='0' where where anio=:anio_a_buscar and periodo=:periodo_a_buscar using tipo_conexion;
select * from horario where cve_salon is null;
//update horario set cve_salon=NULL where cve_salon='0';
//select * from horario where cve_salon='0';

*/

// los nulos se hacen '0' para evitar errores
// CPH Dic/2016

update horario set cve_salon='0' where cve_salon is null and anio=:anio_a_buscar and periodo=:periodo_a_buscar using tipo_conexion;
commit using tipo_conexion;

if(cbx_reiniciar_salones.checked) then
	if(messagebox("Advertencia","¿Desea reiniciar Salones?",StopSign!,OKCancel!)=1) then
		update horario set cve_salon='0'  where anio=:anio_a_buscar and periodo=:periodo_a_buscar using tipo_conexion;
	else
			if(messagebox("Advertencia","¿Desea cancelar la asignación?",StopSign!,OKCancel!)=1) then
				return;
			end if
	end if
	cbx_reiniciar_salones.checked=false	
end if

hpb_avance_grupos.visible=true
hpb_avance_grupos.position=0;
hpb_avance_grupos.maxposition=renglones_grupos;
for cont_renglones=1 to  renglones_grupos

	dw_grupos.scrolltorow(cont_renglones)
	
	st_avance.text="Asignando salones al grupo no. "+string(cont_renglones)+" de "+string(renglones_grupos)+"."


	hpb_avance_grupos.position=cont_renglones;
	
//	clave_materia_global=dw_grupos.object.cve_mat[cont_renglones];	
//	grupo_global=dw_grupos.object.gpo[cont_renglones];

// cambia el nombre de las columnas para CD Mx CPH Nov/2016
clave_materia_global=dw_grupos.object.grupos_cve_mat[cont_renglones];	
grupo_global=dw_grupos.object.grupos_gpo[cont_renglones];	
	

	

//	grupos_fecha_inicio_curso=dw_grupos.object.fecha_inicio_curso[cont_renglones]
//	grupos_fecha_fin_curso=dw_grupos.object.fecha_fin_curso[cont_renglones]			

// Cavmia inicio_curs0 por inicio_periodo para CD Mex Nov/2016
	grupos_fecha_inicio_curso=date(dw_grupos.object.v_inicio_fin_periodo_fecha_inicio_periodo[cont_renglones])
	grupos_fecha_fin_curso=date(dw_grupos.object.v_inicio_fin_periodo_fecha_fin_periodo[cont_renglones])			
	
//	sigla_plantel=dw_grupos.object.planteles_sigla[cont_renglones]	// cph Ene/2015
	
/*	renglones_horario= &
		dw_horario.retrieve(dw_grupos.object.cve_mat[cont_renglones], &
			dw_grupos.object.gpo[cont_renglones],&
				dw_grupos.object.periodo_actual[cont_renglones],&
					dw_grupos.object.anio_actual[cont_renglones])
	*/				
	
renglones_horario= &
		dw_horario.retrieve(clave_materia_global, &
			grupo_global,&
				periodo_a_buscar,&
					anio_a_buscar)	
	
	
	if(rb_cupo_alumnos.checked) then
//		cupo_a_checar=dw_grupos.object.total_inscritos[cont_renglones]
		
	// Cambia la columna CD Mex CPH Nov/2016	
		cupo_a_checar=dw_grupos.object.grupos_inscritos[cont_renglones]
		
		cupo_a_checar=cupo_a_checar * (1 + (double(sle_1.text) / 100.0))
		
//		if(cupo_a_checar>dw_grupos.object.cupo_salon[cont_renglones]) then
//			cupo_a_checar=dw_grupos.object.cupo_salon[cont_renglones]
//		end if

// Cambia la columna de nombre para CD Mx. CPH nov/2016
		if(cupo_a_checar>dw_grupos.object.grupos_cupo[cont_renglones]) then
			cupo_a_checar=dw_grupos.object.grupos_cupo[cont_renglones]
		end if
	else
		cupo_a_checar=dw_grupos.object.grupos_cupo[cont_renglones]	
	end if
	
	salon_ant="0"
	
	for cont_horario=1 to renglones_horario
		
		hora_inicio= &
			(dw_horario.object.hora_inicio_horas[cont_horario] * 100) + &
				dw_horario.object.hora_inicio_mins[cont_horario];

		hora_fin= &
			(dw_horario.object.hora_final_horas[cont_horario] * 100) + &
				dw_horario.object.hora_final_mins[cont_horario];
		
		dia=dw_horario.object.cve_dia[cont_horario]
		salon=dw_horario.object.cve_salon[cont_horario]		
		
//		tipo_salon=dw_horario.object.clase_aula[cont_horario]		
		
		// cambia de clave de clase aula a nombre(descrip) clase_aula para CD Mx CPH, nov/2016
		tipo_salon=dw_horario.object.clase_aula_nombre_aula[cont_horario]				
		
		if(salon="0") then
		
			dw_salones.reset()									
			// solo carga los salones de tijuana y no carga el por designar
//			renglones_salones=dw_salones.retrieve(cupo_a_checar,sigla_plantel)							
	//		renglones_salones=dw_salones.retrieve(cupo_a_checar,sigla_plantel,tipo_salon)	// se agrega el tipo salon CPH Jun/2015									
	
			renglones_salones=dw_salones.retrieve(cupo_a_checar,tipo_salon)	// se quita plantel para CD Mex CPH Nov/2016
			
			if(cbx_1.checked) then
			
				dw_salones.setsort("t_salones_cupo_lim_sup asc t_salones_orden_asignacion asc")
//dw_grupos.setsort( "cupo_salon asc total_inscritos desc conteo_horarios desc")
				dw_salones.sort()			
//				messagebox("","ordenare por cupo lim sup")
			else
				dw_salones.setsort("cupo_max asc")
//				if(dw_grupos.object.cve_mat[cont_renglones]=20175 and 	dw_grupos.object.gpo[cont_renglones]='J') then												
	//				messagebox("","ordenare por orden asignacion")				
//				end if
//dw_grupos.setsort( "cupo_salon asc total_inscritos desc conteo_horarios desc")
				dw_salones.sort()			
				
//
			end if
				
			cont_salones=1;
		
	
			salir_ciclo=false;
			existe_empalme=true; // true para forzar a que entre
			
			// el if de abajo asigna el mismo salon mientras sea posible
			
			/* comentar para pruebas
			
			if(cont_horario>1) then
				reng_horarios_sem=checa_empalme_horario(clave_materia_global,grupo_global,salon_ant,dia,grupos_fecha_inicio_curso,grupos_fecha_fin_curso,hora_inicio,hora_fin,cestijuana_bd)			
				reng_horarios_trim=checa_empalme_horario(clave_materia_global,grupo_global,salon_ant,dia,grupos_fecha_inicio_curso,grupos_fecha_fin_curso,hora_inicio,hora_fin,cestijuana_bd_trim)			
				reng_horarios_esp=checa_empalme_horario(clave_materia_global,grupo_global,salon_ant,dia,grupos_fecha_inicio_curso,grupos_fecha_fin_curso,hora_inicio,hora_fin,cestijuana_bd_esp)							
				//si hay empalme
				if (reng_horarios_sem=0 and  reng_horarios_trim=0 and reng_horarios_esp=0) then
					if(salon_ant<>"0") then
						salir_ciclo=true;
						salon=salon_ant;
					else
						if(dw_grupos.object.cve_mat[cont_renglones]=10635 and 	dw_grupos.object.gpo[cont_renglones]='B') then
							messagebox("me empalme con el salon asignado:",salon_ant)
						end if						
					end if
					
				end if
			end if
			*/
	
			do while cont_salones<=renglones_salones and (not salir_ciclo)
		//		if(dw_grupos.object.cve_mat[cont_renglones]=20175 and 	dw_grupos.object.gpo[cont_renglones]='J') then								
		//		 messagebox("entre salones","fechas "+string(grupos_fecha_inicio_curso))				
		//	end if
//				salon=dw_salones.object.t_salones_cve_salon[cont_salones]					
			// Cambia nombre de columna a cve_salon, para CD Mx CPH Nov/2016
				salon=dw_salones.object.cve_salon[cont_salones]					
				

				reng_horarios_sem=0				
				reng_horarios_trim=0;
				reng_horarios_esp=0;
			
				reng_horarios_sem=checa_empalme_horario(clave_materia_global,grupo_global,salon,dia,grupos_fecha_inicio_curso,grupos_fecha_fin_curso,hora_inicio,hora_fin,tipo_conexion)
//				reng_horarios_trim=checa_empalme_horario(clave_materia_global,grupo_global,salon,dia,grupos_fecha_inicio_curso,grupos_fecha_fin_curso,hora_inicio,hora_fin,cestijuana_bd_trim)
//				reng_horarios_esp=checa_empalme_horario(clave_materia_global,grupo_global,salon,dia,grupos_fecha_inicio_curso,grupos_fecha_fin_curso,hora_inicio,hora_fin,cestijuana_bd_esp)	

//				if(reng_horarios_sem>0 OR reng_horarios_trim>0 OR reng_horarios_esp>0) then
				if(reng_horarios_sem>0) then
//		tab_1.tabpage_5.dw_horario.object.salon_empalmado[renglon_horario]=1
			//		messagebox("empalme:",salon)		
//					return
					existe_empalme=true

				else
					salir_ciclo=true				
					existe_empalme=false
			//	tab_1.tabpage_5.dw_horario.object.salon_empalmado[renglon_horario]=0		
				end if			
			
			
				cont_salones=cont_salones+1;
		//		messagebox("salon asignado:",salon)				
			loop // Lista de Salones
		
			if (salir_ciclo) then
				dw_horario.object.cve_salon[cont_horario]=salon
				if(salon_ant='0') then
					salon_ant=salon;	
				end if
//				if(dw_grupos.object.cve_mat[cont_renglones]=20175 and 	dw_grupos.object.gpo[cont_renglones]='J') then
	//				messagebox("salon asignado:",salon)
		//		end if
				dw_horario.update()
				commit using tipo_conexion;	
//				if(dw_grupos.object.cve_mat[cont_renglones]=10126 and 	dw_grupos.object.gpo[cont_renglones]='B') then				
		//		messagebox("asigne horario","")
	//		end if
	
	
	/*			dw_horario.retrieve(dw_grupos.object.cve_mat[cont_renglones], &
					dw_grupos.object.gpo[cont_renglones],&
						dw_grupos.object.periodo_actual[cont_renglones],&
							dw_grupos.object.anio_actual[cont_renglones])			
							*/
						
						// Cambian parametros para CD Mx CPH Nov/2016
				dw_horario.retrieve(clave_materia_global, &
					grupo_global,&
						periodo_a_buscar,&
							anio_a_buscar)								
				
			end if
	
		else // luego quitar este else para corrida normal
//			messagebox("salon",salon)
		end if // si el salon no es por designar, es decir ya tiene asignado previamente un salon
	//	if(dw_grupos.object.cve_mat[cont_renglones]=10635 and 	dw_grupos.object.gpo[cont_renglones]='B') then
	//			messagebox("esta es",""+string(cont_horario))
		//		messagebox("renlglones horario",""+string(renglones_horario))				
			//	return;
//		end if		
		
		// inicia codigo prueba
		
		if(cont_horario>1) then // trata de asignar el mismo salon a los dos ultimos horarios
	
			le_encontre_salon=false
		
			hora_inicio= &
				(dw_horario.object.hora_inicio_horas[cont_horario] * 100) + &
					dw_horario.object.hora_inicio_mins[cont_horario];

			hora_fin= &
				(dw_horario.object.hora_final_horas[cont_horario] * 100) + &
					dw_horario.object.hora_final_mins[cont_horario];
		
			dia=dw_horario.object.cve_dia[cont_horario]
			salon=dw_horario.object.cve_salon[cont_horario]		

		// anterior
			hora_inicio_ant= &
				(dw_horario.object.hora_inicio_horas[cont_horario - 1] * 100) + &
					dw_horario.object.hora_inicio_mins[cont_horario - 1];

			hora_fin_ant= &
				(dw_horario.object.hora_final_horas[cont_horario - 1] * 100) + &
					dw_horario.object.hora_final_mins[cont_horario - 1];
		
			dia_ant=dw_horario.object.cve_dia[cont_horario - 1]
			salon_ant=dw_horario.object.cve_salon[cont_horario - 1]		
	
	
	
			if(salon_ant<>'0') then // si el ultimo horario <>'0' checa si el ultimo salon puede tener el del anterior
					reng_horarios_sem=checa_empalme_horario(clave_materia_global,grupo_global,salon_ant,dia,grupos_fecha_inicio_curso,grupos_fecha_fin_curso,hora_inicio,hora_fin,tipo_conexion)			
//					reng_horarios_trim=checa_empalme_horario(clave_materia_global,grupo_global,salon_ant,dia,grupos_fecha_inicio_curso,grupos_fecha_fin_curso,hora_inicio,hora_fin,cestijuana_bd_trim)			
	//				reng_horarios_esp=checa_empalme_horario(clave_materia_global,grupo_global,salon_ant,dia,grupos_fecha_inicio_curso,grupos_fecha_fin_curso,hora_inicio,hora_fin,cestijuana_bd_esp)									
		//			if (reng_horarios_sem=0 and  reng_horarios_trim=0 and reng_horarios_esp=0) then // esta libre
					if (reng_horarios_sem=0) then // esta libre. Cambia a un solo Chequeo pra CD Mex CPH Nov/2016
						le_encontre_salon=true;
						dw_horario.object.cve_salon[cont_horario]=dw_horario.object.cve_salon[cont_horario - 1]														
					end if
			end if
			if(not le_encontre_salon) then
				if(salon<>'0') then // si el ultimo horario <>'0' checa si el ultimo salon puede tener el del anterior
						reng_horarios_sem=checa_empalme_horario(clave_materia_global,grupo_global,salon,dia_ant,grupos_fecha_inicio_curso,grupos_fecha_fin_curso,hora_inicio_ant,hora_fin_ant,tipo_conexion)			
//						reng_horarios_trim=checa_empalme_horario(clave_materia_global,grupo_global,salon,dia_ant,grupos_fecha_inicio_curso,grupos_fecha_fin_curso,hora_inicio_ant,hora_fin_ant,cestijuana_bd_trim)			
	//					reng_horarios_esp=checa_empalme_horario(clave_materia_global,grupo_global,salon,dia_ant,grupos_fecha_inicio_curso,grupos_fecha_fin_curso,hora_inicio_ant,hora_fin_ant,cestijuana_bd_esp)			
 
//						if (reng_horarios_sem=0 and  reng_horarios_trim=0 and reng_horarios_esp=0) then // esta libre
						if (reng_horarios_sem=0 and  reng_horarios_trim=0 and reng_horarios_esp=0) then // esta libre. Cambia a un solo Chequeo pra CD Mex CPH Nov/2016						
							le_encontre_salon=true;
							dw_horario.object.cve_salon[cont_horario - 1]=dw_horario.object.cve_salon[cont_horario]														
						end if
				end if		
			end if // no le encontro salon
			if(le_encontre_salon) then
				dw_horario.update()
				commit using tipo_conexion;	
				
/*				dw_horario.retrieve(dw_grupos.object.cve_mat[cont_renglones], &
					dw_grupos.object.gpo[cont_renglones],&
						dw_grupos.object.periodo_actual[cont_renglones],&
							dw_grupos.object.anio_actual[cont_renglones])		*/
							
			// Cambian parametros para CD Mx CPH Nov/2016
				dw_horario.retrieve(clave_materia_global, &
					grupo_global,&
						periodo_a_buscar,&
							anio_a_buscar)															
							
		//		messagebox("","Puede encontrarle el mismo salon!")							
			end if
		end if // trata de asignar el mismo salon a los dos ultimos horarios
		
		
		
		// fin codigo prueba
		
			
		if(dw_horario.object.cve_salon[cont_horario]="0") then
			grupos_sin_salon=grupos_sin_salon + 1;
			st_grupos_sin_salon.text="Horarios con salon Sin Designar: "+string(grupos_sin_salon);
		end if
	next // horario

	// ahora checa si son mas de dos salones si el ultimo salon puede ser al anterior y viceversa
	// CPH Ene/2015
	/*
	if(renglones_horario>1) then // trata de asignar el mismo salon a los dos ultimos horarios
	
		le_encontre_salon=false
		
		hora_inicio= &
			(dw_horario.object.hora_inicio_horas[renglones_horario] * 100) + &
				dw_horario.object.hora_inicio_mins[renglones_horario];

		hora_fin= &
			(dw_horario.object.hora_final_horas[renglones_horario] * 100) + &
				dw_horario.object.hora_final_mins[renglones_horario];
		
		dia=dw_horario.object.cve_dia[renglones_horario]
		salon=dw_horario.object.cve_salon[renglones_horario]		

		// anterior
		hora_inicio_ant= &
			(dw_horario.object.hora_inicio_horas[renglones_horario - 1] * 100) + &
				dw_horario.object.hora_inicio_mins[renglones_horario - 1];

		hora_fin_ant= &
			(dw_horario.object.hora_final_horas[renglones_horario - 1] * 100) + &
				dw_horario.object.hora_final_mins[renglones_horario - 1];
		
		dia_ant=dw_horario.object.cve_dia[renglones_horario - 1]
		salon_ant=dw_horario.object.cve_salon[renglones_horario - 1]		
	
	
	
		if(salon_ant<>'0') then // si el ultimo horario <>'0' checa si el ultimo salon puede tener el del anterior
				reng_horarios_sem=checa_empalme_horario(clave_materia_global,grupo_global,salon_ant,dia,grupos_fecha_inicio_curso,grupos_fecha_fin_curso,hora_inicio,hora_fin,cestijuana_bd)			
				reng_horarios_trim=checa_empalme_horario(clave_materia_global,grupo_global,salon_ant,dia,grupos_fecha_inicio_curso,grupos_fecha_fin_curso,hora_inicio,hora_fin,cestijuana_bd_trim)			
				reng_horarios_esp=checa_empalme_horario(clave_materia_global,grupo_global,salon_ant,dia,grupos_fecha_inicio_curso,grupos_fecha_fin_curso,hora_inicio,hora_fin,cestijuana_bd_esp)									
				if (reng_horarios_sem=0 and  reng_horarios_trim=0 and reng_horarios_esp=0) then // esta libre
					le_encontre_salon=true;
					dw_horario.object.cve_salon[renglones_horario]=dw_horario.object.cve_salon[renglones_horario - 1]														
				end if
		end if
		if(not le_encontre_salon) then
			if(salon<>'0') then // si el ultimo horario <>'0' checa si el ultimo salon puede tener el del anterior
					reng_horarios_sem=checa_empalme_horario(clave_materia_global,grupo_global,salon,dia_ant,grupos_fecha_inicio_curso,grupos_fecha_fin_curso,hora_inicio_ant,hora_fin_ant,cestijuana_bd)			
					reng_horarios_trim=checa_empalme_horario(clave_materia_global,grupo_global,salon,dia_ant,grupos_fecha_inicio_curso,grupos_fecha_fin_curso,hora_inicio_ant,hora_fin_ant,cestijuana_bd_trim)			
					reng_horarios_esp=checa_empalme_horario(clave_materia_global,grupo_global,salon,dia_ant,grupos_fecha_inicio_curso,grupos_fecha_fin_curso,hora_inicio_ant,hora_fin_ant,cestijuana_bd_esp)			
					if (reng_horarios_sem=0 and  reng_horarios_trim=0 and reng_horarios_esp=0) then // esta libre
						le_encontre_salon=true;
						dw_horario.object.cve_salon[renglones_horario - 1]=dw_horario.object.cve_salon[renglones_horario]														
					end if
			end if		
		end if // no le encontro salon
		if(le_encontre_salon) then
				dw_horario.update()
				commit using tipo_conexion;	
				dw_horario.retrieve(dw_grupos.object.cve_mat[cont_renglones], &
					dw_grupos.object.gpo[cont_renglones],&
						dw_grupos.object.periodo_actual[cont_renglones],&
							dw_grupos.object.anio_actual[cont_renglones])		
//				messagebox("","Puede encontrarle el mismo salon!")							
		end if
	end if // trata de asignar el mismo salon a los dos ultimos horarios
*/	

	//	if(dw_grupos.object.cve_mat[cont_renglones]=10635 and 	dw_grupos.object.gpo[cont_renglones]='B') then
	//			messagebox("me salgo","")
			//	return;
//			end if							
//dw_salones.retrieve()					
next

// Se regresan los cve_salon='0'  a NULLO para CD de Mexico
// CPH Dic/2016

update horario set cve_salon=NULL where cve_salon='0' and  anio=:anio_a_buscar and periodo=:periodo_a_buscar using tipo_conexion;
commit using tipo_conexion;

long horarios_sin_asignar


//select count(*) from horario where cve_salon='0' and anio=2015 and periodo=0;
//st_sin_asignar.text=string()


cbx_reiniciar_salones.checked=false
hpb_avance_grupos.visible=false

messagebox("Aviso","Se finalizó la asignación de Salones")
end event

type sle_1 from singlelineedit within w_asigna_salones
boolean visible = false
integer x = 2089
integer y = 352
integer width = 178
integer height = 116
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "0"
borderstyle borderstyle = stylelowered!
end type

type st_porcentaje from statictext within w_asigna_salones
boolean visible = false
integer x = 1198
integer y = 376
integer width = 841
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Alumnos Inscr + Porcentaje de:"
boolean focusrectangle = false
end type

type dw_horario from datawindow within w_asigna_salones
integer x = 110
integer y = 1496
integer width = 2409
integer height = 1004
integer taborder = 30
boolean titlebar = true
string title = "Horarios"
string dataobject = "dw_horario_mat_gpo_anio_periodo_asign_salon"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieverow;// Se implementan nuevas columnas y algoritmo
// para permitir horas y minutos
// en el Sistem.
// Cesar Ponce H. Junio-Julio/2011

/*
object.hora_inicio_horas[row]=&
		object.hora_inicio[row]/100
		
object.hora_inicio_mins[row]=&
	(object.hora_inicio[row] - & 
		(long (object.hora_inicio[row]/100) * 100));

object.hora_final_horas[row]=&
		object.hora_final[row]/100
		
object.hora_final_mins[row]=&
	(object.hora_final[row] - & 
		(long (object.hora_final[row]/100) * 100));
		
*/

// Cambia para Sistema de Asignación de CD de Mexico
// CPH Nov/2016
object.hora_inicio_horas[row]=&
		object.hora_inicio[row]
		
object.hora_inicio_mins[row]=0;

object.hora_final_horas[row]=&
		object.hora_final[row] - 1
		
object.hora_final_mins[row]=59
		

end event

type cbx_1 from checkbox within w_asigna_salones
boolean visible = false
integer x = 2427
integer y = 448
integer width = 1765
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ordenar salones por cupo limite superior asc (Lic, Post) No Trim"
end type

type cbx_reiniciar_salones from checkbox within w_asigna_salones
integer x = 2423
integer y = 368
integer width = 759
integer height = 100
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Reiniciar Salones"
end type

type st_grupos_sin_salon from statictext within w_asigna_salones
integer x = 3099
integer y = 736
integer width = 997
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Horarios con salón Sin Designar:"
boolean focusrectangle = false
end type

type hpb_avance_grupos from hprogressbar within w_asigna_salones
integer x = 1495
integer y = 736
integer width = 1495
integer height = 84
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
end type

type dw_grupos from datawindow within w_asigna_salones
integer x = 110
integer y = 840
integer width = 4059
integer height = 596
integer taborder = 20
boolean titlebar = true
string title = "Grupos"
string dataobject = "dw_grupos_horarios"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_asigna_salones
integer x = 155
integer y = 108
integer width = 645
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleccione el Periodo"
boolean focusrectangle = false
end type

type st_inicio_fin from statictext within w_asigna_salones
integer x = 1701
integer y = 108
integer width = 2391
integer height = 112
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type ddlb_periodos from dropdownlistbox within w_asigna_salones
integer x = 864
integer y = 108
integer width = 745
integer height = 400
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//anio_a_buscar
//periodo_a_buscar

long renglon
renglon=index

anio_a_buscar=dw_activacion_inicio_fin_periodo.object.anio[index]
periodo_a_buscar=dw_activacion_inicio_fin_periodo.object.periodo[index]
inicio_periodo_academ=date(dw_activacion_inicio_fin_periodo.object.fecha_inicio_periodo[index])
fin_periodo_academ=date(dw_activacion_inicio_fin_periodo.object.fecha_fin_periodo[index])

if (isnull(inicio_periodo_academ) or isnull(fin_periodo_academ)) then
	st_inicio_fin.text="Periodo (dd/mm/aaaa): EN NULO, NO SE PUEDEN ASIGNAR SALONES."	
	Messagebox("Advertencia!","No se pueden asignar salones, ~n~r La fecha de inicio - fin de periodo no pueden ser nulas! ~n~r Consulte la tabla CALENDARIO.")
	cb_2.enabled=false
	return
else
	cb_2.enabled=true
end if

st_inicio_fin.text='Periodo (dd/mm/aaaa): '+string(inicio_periodo_academ,"dd/mm/yyyy")+' - '+string(fin_periodo_academ,"dd/mm/yyyy")

carga_grupos()

end event

type dw_activacion_inicio_fin_periodo from datawindow within w_asigna_salones
boolean visible = false
integer x = 1760
integer y = 108
integer width = 567
integer height = 136
integer taborder = 20
string title = "none"
string dataobject = "dw_activacion_inicio_fin_periodo"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieverow;if(row>1) then
	ddlb_periodos.insertitem(string(object.anio[row])+' - '+object.descripcion[row],row)

end if
end event

type gb_1 from groupbox within w_asigna_salones
integer x = 133
integer y = 284
integer width = 2217
integer height = 244
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cupo a utlizar:"
end type

type gb_2 from groupbox within w_asigna_salones
integer x = 46
integer width = 4128
integer height = 268
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Periodo de Asignación de Salones:"
end type

