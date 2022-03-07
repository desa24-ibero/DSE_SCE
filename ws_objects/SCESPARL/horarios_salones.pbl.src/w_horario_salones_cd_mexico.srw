﻿$PBExportHeader$w_horario_salones_cd_mexico.srw
forward
global type w_horario_salones_cd_mexico from window
end type
type st_100 from statictext within w_horario_salones_cd_mexico
end type
type st_200 from statictext within w_horario_salones_cd_mexico
end type
type cbx_no_vacios from checkbox within w_horario_salones_cd_mexico
end type
type cb_5 from commandbutton within w_horario_salones_cd_mexico
end type
type st_3 from statictext within w_horario_salones_cd_mexico
end type
type cb_1 from commandbutton within w_horario_salones_cd_mexico
end type
type cb_2 from commandbutton within w_horario_salones_cd_mexico
end type
type cb_3 from commandbutton within w_horario_salones_cd_mexico
end type
type cb_exportar from commandbutton within w_horario_salones_cd_mexico
end type
type cb_carga from commandbutton within w_horario_salones_cd_mexico
end type
type hpb_4 from hprogressbar within w_horario_salones_cd_mexico
end type
type em_1 from editmask within w_horario_salones_cd_mexico
end type
type dw_horarios_x_salon from datawindow within w_horario_salones_cd_mexico
end type
type cbx_1 from checkbox within w_horario_salones_cd_mexico
end type
type cbx_2 from checkbox within w_horario_salones_cd_mexico
end type
type cbx_todos from checkbox within w_horario_salones_cd_mexico
end type
type st_1 from statictext within w_horario_salones_cd_mexico
end type
type cbx_4 from checkbox within w_horario_salones_cd_mexico
end type
type st_2 from statictext within w_horario_salones_cd_mexico
end type
type dw_salones_x_grupo from datawindow within w_horario_salones_cd_mexico
end type
type dw_lista_salones from datawindow within w_horario_salones_cd_mexico
end type
type cb_4 from commandbutton within w_horario_salones_cd_mexico
end type
type st_avance3 from statictext within w_horario_salones_cd_mexico
end type
type hpb_1 from hprogressbar within w_horario_salones_cd_mexico
end type
type hpb_2 from hprogressbar within w_horario_salones_cd_mexico
end type
type st_avance2 from statictext within w_horario_salones_cd_mexico
end type
type st_avance1 from statictext within w_horario_salones_cd_mexico
end type
type hpb_3 from hprogressbar within w_horario_salones_cd_mexico
end type
type hpb_avance_todos from hprogressbar within w_horario_salones_cd_mexico
end type
type st_4 from statictext within w_horario_salones_cd_mexico
end type
type dw_horario from datawindow within w_horario_salones_cd_mexico
end type
end forward

global type w_horario_salones_cd_mexico from window
integer width = 3959
integer height = 2124
boolean titlebar = true
string menuname = "m_menu_horario_salones_cd_mexico"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_100 st_100
st_200 st_200
cbx_no_vacios cbx_no_vacios
cb_5 cb_5
st_3 st_3
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_exportar cb_exportar
cb_carga cb_carga
hpb_4 hpb_4
em_1 em_1
dw_horarios_x_salon dw_horarios_x_salon
cbx_1 cbx_1
cbx_2 cbx_2
cbx_todos cbx_todos
st_1 st_1
cbx_4 cbx_4
st_2 st_2
dw_salones_x_grupo dw_salones_x_grupo
dw_lista_salones dw_lista_salones
cb_4 cb_4
st_avance3 st_avance3
hpb_1 hpb_1
hpb_2 hpb_2
st_avance2 st_avance2
st_avance1 st_avance1
hpb_3 hpb_3
hpb_avance_todos hpb_avance_todos
st_4 st_4
dw_horario dw_horario
end type
global w_horario_salones_cd_mexico w_horario_salones_cd_mexico

type variables
transaction tipo_conexion
boolean imprimir_todos_los_salones
boolean ya_se_creo_la_lista

integer periodos_a_cargar[10] // CPH Ene/2017

int cont_renglon,cont_renglon_horas,cont_renglon_ant
end variables

forward prototypes
public subroutine crea_lista_salones ()
public subroutine inicializa_periodos ()
end prototypes

public subroutine crea_lista_salones ();//dw_horarios_x_salon

if(ya_se_creo_la_lista) then return

long reng_lista_salones
long cont_ocupados
dw_lista_salones.settransobject(tipo_conexion)
reng_lista_salones=dw_lista_salones.retrieve()


long conteo
string salon_a_buscar

cb_3.visible=false
cbx_todos.visible=false

if imprimir_todos_los_salones then
	cb_3.visible=true
	cbx_todos.visible=true
end if

hpb_4.visible=true		
st_2.visible=true
	
hpb_4.maxposition=reng_lista_salones
hpb_4.position=0
for cont_ocupados=1 to reng_lista_salones
	hpb_4.position=cont_ocupados
	salon_a_buscar=dw_lista_salones.object.cve_salon[cont_ocupados]
	
	select isnull(count(*),0) into :conteo from horario where cve_salon=:salon_a_buscar using tipo_conexion;
	
	dw_lista_salones.object.conteo_grupos[cont_ocupados]= &
		dw_lista_salones.object.conteo_grupos[cont_ocupados] + conteo;
		
		
	dw_lista_salones.object.imprimir[cont_ocupados]='s'

next

//dw_lista_salones.setfilter("conteo_grupos>0")
//dw_lista_salones.filter()

hpb_4.visible=false
st_2.visible=false
dw_lista_salones.visible=false
cb_3.visible=false
cb_2.enabled=false
cb_exportar.enabled=false	

st_avance1.visible=false
st_avance2.visible=false
st_avance3.visible=false
hpb_1.visible=false
hpb_2.visible=false
hpb_3.visible=false
dw_horario.visible=true

ya_se_creo_la_lista=true

end subroutine

public subroutine inicializa_periodos ();w_horario_salones_cd_mexico.title="Reporte Salones Ibero-Tijuana                                                                             CPH. Ene/2017"

int cont

for cont=1 to 10
	periodos_a_cargar[cont]=-1 // CPH Ene/2017
next
end subroutine

on w_horario_salones_cd_mexico.create
if this.MenuName = "m_menu_horario_salones_cd_mexico" then this.MenuID = create m_menu_horario_salones_cd_mexico
this.st_100=create st_100
this.st_200=create st_200
this.cbx_no_vacios=create cbx_no_vacios
this.cb_5=create cb_5
this.st_3=create st_3
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_exportar=create cb_exportar
this.cb_carga=create cb_carga
this.hpb_4=create hpb_4
this.em_1=create em_1
this.dw_horarios_x_salon=create dw_horarios_x_salon
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.cbx_todos=create cbx_todos
this.st_1=create st_1
this.cbx_4=create cbx_4
this.st_2=create st_2
this.dw_salones_x_grupo=create dw_salones_x_grupo
this.dw_lista_salones=create dw_lista_salones
this.cb_4=create cb_4
this.st_avance3=create st_avance3
this.hpb_1=create hpb_1
this.hpb_2=create hpb_2
this.st_avance2=create st_avance2
this.st_avance1=create st_avance1
this.hpb_3=create hpb_3
this.hpb_avance_todos=create hpb_avance_todos
this.st_4=create st_4
this.dw_horario=create dw_horario
this.Control[]={this.st_100,&
this.st_200,&
this.cbx_no_vacios,&
this.cb_5,&
this.st_3,&
this.cb_1,&
this.cb_2,&
this.cb_3,&
this.cb_exportar,&
this.cb_carga,&
this.hpb_4,&
this.em_1,&
this.dw_horarios_x_salon,&
this.cbx_1,&
this.cbx_2,&
this.cbx_todos,&
this.st_1,&
this.cbx_4,&
this.st_2,&
this.dw_salones_x_grupo,&
this.dw_lista_salones,&
this.cb_4,&
this.st_avance3,&
this.hpb_1,&
this.hpb_2,&
this.st_avance2,&
this.st_avance1,&
this.hpb_3,&
this.hpb_avance_todos,&
this.st_4,&
this.dw_horario}
end on

on w_horario_salones_cd_mexico.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_100)
destroy(this.st_200)
destroy(this.cbx_no_vacios)
destroy(this.cb_5)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_exportar)
destroy(this.cb_carga)
destroy(this.hpb_4)
destroy(this.em_1)
destroy(this.dw_horarios_x_salon)
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.cbx_todos)
destroy(this.st_1)
destroy(this.cbx_4)
destroy(this.st_2)
destroy(this.dw_salones_x_grupo)
destroy(this.dw_lista_salones)
destroy(this.cb_4)
destroy(this.st_avance3)
destroy(this.hpb_1)
destroy(this.hpb_2)
destroy(this.st_avance2)
destroy(this.st_avance1)
destroy(this.hpb_3)
destroy(this.hpb_avance_todos)
destroy(this.st_4)
destroy(this.dw_horario)
end on

event open;/******************************************************************************

Módulo de Reporte Matricial Horario por Salone(s).

Análisis, Diseño y Programación

César Ponce Hdz.

Ibero - Tijuana, dic-2016/ene/2017



******************************************************************************/

w_horario_salones_cd_mexico.title="Reporte Salones Ibero-Tijuana                                               Marzo/2017"

w_principal.toolbarvisible=false

tipo_conexion=gtr_sce

imprimir_todos_los_salones=true

long reng_lista_salones
long cont_ocupados




dw_lista_salones.settransobject(tipo_conexion)
reng_lista_salones=dw_lista_salones.retrieve()
long conteo
string salon_a_buscar

ya_se_creo_la_lista=false
em_1.setfocus( )

cb_3.visible=false
cbx_todos.visible=false

if imprimir_todos_los_salones then
	cb_3.visible=true
	cbx_todos.visible=true
//	crea_lista_salones()
end if

//lo d abajo se anula y se hace una funcion para que solo se carguen salones al seleccionar
//el checkbox de todos CPH 28/Nov/2014
/*
for cont_ocupados=1 to reng_lista_salones

	salon_a_buscar=dw_lista_salones.object.cve_salon[cont_ocupados]
	
	select count(*) into :conteo from horario where cve_salon=:salon_a_buscar using cestijuana_bd;
	
	dw_lista_salones.object.conteo_grupos[cont_ocupados]= &
		dw_lista_salones.object.conteo_grupos[cont_ocupados] + conteo;
		
	select count(*) into :conteo from horario where cve_salon=:salon_a_buscar using cestijuana_bd_trim;
	
	dw_lista_salones.object.conteo_grupos[cont_ocupados]= &
		dw_lista_salones.object.conteo_grupos[cont_ocupados] + conteo;
		
	select count(*) into :conteo from horario where cve_salon=:salon_a_buscar using cestijuana_bd_esp;
	
	dw_lista_salones.object.conteo_grupos[cont_ocupados]= &
		dw_lista_salones.object.conteo_grupos[cont_ocupados] + conteo;		
		
	dw_lista_salones.object.imprimir[cont_ocupados]='s'

next

dw_lista_salones.setfilter("conteo_grupos>0")
dw_lista_salones.filter()
*/
dw_lista_salones.visible=false


cb_3.visible=false
cb_2.enabled=false
cb_exportar.enabled=false	

st_avance1.visible=false
st_avance2.visible=false
st_avance3.visible=false
hpb_1.visible=false
hpb_2.visible=false
hpb_3.visible=false
dw_horario.visible=true

end event

event resize;dw_horario.height=this.height - 850

dw_horario.width=this.width - 100
end event

event close;w_principal.toolbarvisible=true
end event

type st_100 from statictext within w_horario_salones_cd_mexico
integer x = 3634
integer y = 768
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

type st_200 from statictext within w_horario_salones_cd_mexico
boolean visible = false
integer x = 3634
integer y = 652
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

type cbx_no_vacios from checkbox within w_horario_salones_cd_mexico
boolean visible = false
integer x = 14
integer y = 120
integer width = 882
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "No generar salones vacios"
boolean checked = true
end type

type cb_5 from commandbutton within w_horario_salones_cd_mexico
boolean visible = false
integer x = 1138
integer y = 728
integer width = 635
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Deleccionar Todos"
end type

event clicked;long reng,cont_selecciona

reng=dw_lista_salones.rowcount()

for cont_selecciona= 1 to reng
	dw_lista_salones.object.imprimir[cont_selecciona]='n'
next
end event

type st_3 from statictext within w_horario_salones_cd_mexico
integer x = 2267
integer y = 412
integer width = 864
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean italic = true
long textcolor = 33554432
long backcolor = 67108864
string text = "Versión CPH-Tij 30/marzo/2017."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_horario_salones_cd_mexico
integer x = 3209
integer y = 304
integer width = 599
integer height = 112
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Configurar Impresora"
end type

event clicked;printsetup()
end event

type cb_2 from commandbutton within w_horario_salones_cd_mexico
integer x = 3406
integer y = 152
integer width = 402
integer height = 112
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Imprimir"
end type

event clicked;if(dw_horario.rowcount()>0) then
	dw_horario.print()
end if
end event

type cb_3 from commandbutton within w_horario_salones_cd_mexico
boolean visible = false
integer x = 1010
integer y = 48
integer width = 773
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cargar Todos los Salones"
end type

event clicked;int rtn
long ciclo_imprime

cb_4.visible=false
cb_5.visible=false
cb_carga.enabled=false

if  (cbx_todos.checked) then // se pone para hacer un solo reporte con todos los salones CPH Marzo/2017
	cont_renglon=1
	dw_horario.reset()	
end if

//rtn=messagebox("Aviso","¿Ya configuró la Impresora?",Question!,YesNo!)
rtn=1
if(rtn=1) then
	//rtn=messagebox("Aviso","¿Esta seguro de que desea imprimir todos los salones?~r~n~r~nEl imprimir Todos los Salones implica el gasto excesivo de papel.",Question!,OKCancel!)
	rtn=1
	if(rtn=1) then
		st_4.visible=true
		hpb_avance_todos.visible=true
		hpb_avance_todos.position=0;
		hpb_avance_todos.maxposition=dw_lista_salones.rowcount()
		
		for ciclo_imprime=1 to dw_lista_salones.rowcount()
			dw_lista_salones.scrolltorow(ciclo_imprime)
			hpb_avance_todos.position=ciclo_imprime
			if(dw_lista_salones.object.imprimir[ciclo_imprime]='s')	then
			//	rtn=messagebox("Aviso","¿Desea imprimir el Salon:?~r~n~r~n"+string(dw_lista_salones.object.cve_salon[ciclo_imprime]),Question!,OKCancel!)
			rtn=1 // se quita el de arriba por peticion de CD de Mexico, Marzo 2017 CPH
				if(rtn=1) then		
					em_1.text=dw_lista_salones.object.cve_salon[ciclo_imprime]						
					if (cbx_no_vacios.checked) then
						if(dw_lista_salones.object.conteo_grupos[ciclo_imprime]>0) then		
							cb_carga.triggerevent(Clicked!)						
						end if
					else
						cb_carga.triggerevent(Clicked!)
					end if
	

					if(cb_2.enabled) then
				//		cb_2.triggerevent(Clicked!)
					end if
				end if
//			cb_2				
//				messagebox("","imprime")
			end if // imprime='s'
		next
		st_4.visible=false
		hpb_avance_todos.visible=false
		dw_horario.visible=true		
	end if
else
	printsetup()
end if

cb_2.enabled=true // se ponen para forzar a que habilite el boton aunque el ultimo salon esta vecio CPH Marzo/30/2016
cb_exportar.enabled=true  // se ponen para forzar a que habilite el boton aunque el ultimo salon esta vecio CPH Marzo/30/2016
cb_4.visible=true
cb_5.visible=true



end event

type cb_exportar from commandbutton within w_horario_salones_cd_mexico
integer x = 3410
integer y = 460
integer width = 402
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Exportar"
end type

event clicked;dw_horario.saveas("",Excel8!,true)
end event

type cb_carga from commandbutton within w_horario_salones_cd_mexico
integer x = 2633
integer y = 152
integer width = 585
integer height = 112
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Carga Horario Salon"
end type

event clicked;string salon_a_buscar
int cont_horas
// int cont_renglon // se hace variable de instancia
long ciclo_horarios
long conteo_horarios
int ciclo_dias
int hora_inicio
int hora_fin
String contenido_horario
int ciclo_conexion
String tipo_periodo_str

boolean encontre_grupo
boolean generar_reporte
String cupo_salon_str


if(len(em_1.text)=0) then
	Messagebox("Aviso","Introduzca un salón")
	return
end if

//String periodos_a_cargar[10] // CPH Ene/2017

inicializa_periodos();

encontre_grupo=false

salon_a_buscar=em_1.text


//select count(*) into :conteo from horario where cve_salon=:salon_a_buscar using alumnos;

dw_horario.visible=false

if not(cbx_todos.checked) then
	st_avance1.visible=true
	st_avance2.visible=true
	st_avance3.visible=true
	hpb_1.visible=true
	hpb_2.visible=true
	hpb_3.visible=true
end if

dw_horario.height=parent.height - 1000

string descrip_salon
integer cupo_lim_inf, cupo_lim_sup

select isnull(descripcion, cve_salon),cupo_max into :descrip_salon, :cupo_lim_sup from salon where cve_salon=:salon_a_buscar using tipo_conexion;	

if cbx_todos.checked then // se pone para hacer un solo reporte con todos los salones CPH Marzo/2017
	cont_renglon_horas=cont_renglon		
else
	dw_horario.reset()
	cont_renglon_horas=1	
end if

for cont_horas=7 to 21
	dw_horario.insertrow(cont_renglon_horas)		
	if(cont_horas<10) then
		dw_horario.object.hora[cont_renglon_horas]="0"+string(cont_horas)+":00"
	else
		dw_horario.object.hora[cont_renglon_horas]=string(cont_horas)+":00"		
	end if
	
	dw_horario.object.cve_salon[cont_renglon_horas]=salon_a_buscar // CPH Marzo/2017
	dw_horario.object.hora_num[cont_renglon_horas]=cont_horas // CPH Marzo/2017
	dw_horario.object.cupo[cont_renglon_horas]=cupo_lim_sup // CPH Marzo/2017
	cont_renglon_horas++
next


//carga_datos(salon_a_buscar,tipo_conexion)

hpb_3.maxposition=3
hpb_3.position=0

if  (cbx_todos.checked) then // se pone para hacer un solo reporte con todos los salones CPH Marzo/2017
	cont_renglon_ant=cont_renglon
end if


for ciclo_conexion=1 to 2
	generar_reporte=false
	choose case ciclo_conexion
		case 1
			dw_horarios_x_salon.settransobject(tipo_conexion)
			dw_salones_x_grupo.settransobject(tipo_conexion) // cph Ene/2015
			tipo_periodo_str=" Semestral."
			if(cbx_1.checked) then
				inicializa_periodos();			
				periodos_a_cargar[1]=0
				periodos_a_cargar[2]=1
				periodos_a_cargar[3]=2				
				generar_reporte=true
			end if
		case 2
			dw_horarios_x_salon.settransobject(tipo_conexion)
			dw_salones_x_grupo.settransobject(tipo_conexion) // cph Ene/2015			
			tipo_periodo_str=" Trimestral."
			
			if(cbx_2.checked) then
				inicializa_periodos();			
				periodos_a_cargar[1]=3
				periodos_a_cargar[2]=4
				periodos_a_cargar[3]=5								
				periodos_a_cargar[4]=6												
//				periodos_a_cargar=periodos_a_cargar+"3,4,5,6,"			
				generar_reporte=true
			end if
	
	end choose
	
//	periodos_a_cargar=left(periodos_a_cargar, len(periodos_a_cargar) - 1 ) // le quita la coma
	
conteo_horarios=dw_horarios_x_salon.retrieve(salon_a_buscar,periodos_a_cargar)



hpb_1.position=0;

hpb_1.maxposition=conteo_horarios;


if(conteo_horarios>0 and generar_reporte) then

string fecha_inicio, fecha_fin

//select isnull(descripcion, cve_salon),cupo_max into :descrip_salon, :cupo_lim_sup from salon where cve_salon=:salon_a_buscar using tipo_conexion;
//dw_horario.object.t_titulo.text="Ubicación: "+descrip_salon
dw_horario.object.t_titulo.text="Salón: "+descrip_salon
dw_horario.object.t_cupo.text="Cupo Máximo: "+string(cupo_lim_sup)

//	for ciclo_dias=1 to 7
//	next
//	cont_renglon=1

	if  (cbx_todos.checked) then // se pone para hacer un solo reporte con todos los salones CPH Marzo/2017
		cont_renglon=cont_renglon_ant
	else
		cont_renglon=1
	end if

	
	hpb_2.maxposition=21
	hpb_2.position=7
	hpb_2.minposition=7


	for cont_horas=7 to 21
		hpb_2.position=hpb_2.position + 1
		hpb_1.position = 0;
		for ciclo_horarios=1 to conteo_horarios
			hpb_1.position =	hpb_1.position + 1	
			hora_inicio=dw_horarios_x_salon.object.horario_hora_inicio[ciclo_horarios] / 100
			hora_fin=dw_horarios_x_salon.object.horario_hora_final[ciclo_horarios] / 100
			if(cont_horas>=hora_inicio and cont_horas<=hora_fin) then
				contenido_horario=string(dw_horario.getitemstring(cont_renglon,int(dw_horarios_x_salon.object.horario_cve_dia[ciclo_horarios]) + 1))
				if(isnull(contenido_horario)) then 
					contenido_horario=""
				end if

/*
				cupo_salon_str=""
				if(cbx_cupo.checked) then
					if (isnull(dw_horarios_x_salon.object.grupos_cupo_salon[ciclo_horarios]	)) then
						cupo_salon_str="Cupo grupo: 0"
					else
						cupo_salon_str="Cupo:"+string(dw_horarios_x_salon.object.grupos_cupo_salon[ciclo_horarios])					
						cupo_salon_str=cupo_salon_str + " Inscritos:"+string(dw_horarios_x_salon.object.total_inscritos[ciclo_horarios])											
					end if
				end if
	*/			
				encontre_grupo=true
				
				fecha_inicio=string(dw_horarios_x_salon.object.grupos_fecha_inicio_curso[ciclo_horarios],"dd/mm/yyyy")
				fecha_fin=string(dw_horarios_x_salon.object.grupos_fecha_fin_curso[ciclo_horarios],"dd/mm/yyyy")				
				
				if(isnull(fecha_inicio)) then fecha_inicio=""
				if(isnull(fecha_fin)) then fecha_fin=""				
				
				if(cbx_4.checked=false) then
					contenido_horario=contenido_horario + &
						string(dw_horarios_x_salon.object.horario_cve_mat[ciclo_horarios])+"-"+&
						dw_horarios_x_salon.object.horario_gpo[ciclo_horarios]+" "+tipo_periodo_str+&					
						"~n"+ &
						dw_horarios_x_salon.object.materias_materia[ciclo_horarios] + "~n" + &								
						cupo_salon_str+"~n"+ &
						"Profr. "+dw_horarios_x_salon.object.profesor_nombre_completo	[ciclo_horarios] + "~n" + &				
						"("+fecha_inicio + " - " +	fecha_fin+")" 
						
						long num_salones
						long ciclo_salones
						
						num_salones=dw_salones_x_grupo.retrieve(dw_horarios_x_salon.object.horario_cve_mat[ciclo_horarios],dw_horarios_x_salon.object.horario_gpo[ciclo_horarios])
						
						for ciclo_salones=1 to num_salones
							if(ciclo_salones=1) then
								contenido_horario=contenido_horario + "~n Salones: "+dw_salones_x_grupo.object.cve_salon[ciclo_salones]							
							else
								contenido_horario=contenido_horario + ","+dw_salones_x_grupo.object.cve_salon[ciclo_salones]															
							end if
					next
					contenido_horario=contenido_horario + "."

					contenido_horario=contenido_horario +  "~n ------- ~n"
					
					
//				messagebox("",contenido_horario)

				else
					contenido_horario=contenido_horario + &
						string(dw_horarios_x_salon.object.horario_cve_mat[ciclo_horarios])+"-"+&
						dw_horarios_x_salon.object.horario_gpo[ciclo_horarios]+"~n"
				end if
				
				// aqui obtener salones por grupo CPH Ene/2015
				/*
				
				
				*/
				dw_horario.setitem(cont_renglon,int(dw_horarios_x_salon.object.horario_cve_dia[ciclo_horarios]) + 1,contenido_horario)				
			end if
		next
		cont_renglon++		
	next // horas
end if
hpb_3.position=hpb_3.position + 1
next

cb_2.enabled=true
cb_exportar.enabled=true
if(not(encontre_grupo)) then
	if not(cbx_todos.checked) then // se pone para hacer un solo reporte con todos los salones CPH Marzo/2017
		dw_horario.reset()
	end if

	cb_2.enabled=false
	cb_exportar.enabled=false	
end if

st_avance1.visible=false
st_avance2.visible=false
st_avance3.visible=false
hpb_1.visible=false
hpb_2.visible=false
hpb_3.visible=false

if not(cbx_todos.checked) then
	dw_horario.visible=true
end if
/*
long ciclo_horarios
long conteo_horarios
int ciclo_dias
int hora_inicio
int hora_fin

*/
end event

type hpb_4 from hprogressbar within w_horario_salones_cd_mexico
boolean visible = false
integer x = 78
integer y = 320
integer width = 1893
integer height = 96
boolean bringtotop = true
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
boolean smoothscroll = true
end type

type em_1 from editmask within w_horario_salones_cd_mexico
integer x = 2395
integer y = 164
integer width = 215
integer height = 84
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "Arrow!"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!!!"
end type

event modified;cb_carga.triggerevent(Clicked!)
end event

type dw_horarios_x_salon from datawindow within w_horario_salones_cd_mexico
boolean visible = false
integer x = 2373
integer y = 316
integer width = 663
integer height = 400
integer taborder = 50
boolean enabled = false
string title = "none"
string dataobject = "dw_horarios_x_salon_cd_mexico"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_1 from checkbox within w_horario_salones_cd_mexico
integer x = 2007
integer y = 20
integer width = 439
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Semestrales"
boolean checked = true
end type

type cbx_2 from checkbox within w_horario_salones_cd_mexico
integer x = 2473
integer y = 20
integer width = 439
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Trimestrales"
boolean checked = true
end type

type cbx_todos from checkbox within w_horario_salones_cd_mexico
integer x = 14
integer y = 20
integer width = 841
integer height = 84
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Imprimir todos los salones"
end type

event clicked;dw_horario.reset()
if (this.checked=false) then
	cbx_no_vacios.visible=false
	dw_lista_salones.visible=false	
	cb_3.visible=false
	
	cb_4.visible=false
	cb_5.visible=false
	
	cb_carga.enabled=true // CPH - Marzo/2017
	em_1.enabled=true
	
else
	crea_lista_salones()		
	cb_3.visible=true	
	cbx_no_vacios.visible=true	
	dw_lista_salones.visible=true	
	
	cb_4.visible=true
	cb_5.visible=true
	cb_carga.enabled=false // CPH - Marzo/2017	
	em_1.enabled=false

end if


end event

type st_1 from statictext within w_horario_salones_cd_mexico
integer x = 2185
integer y = 168
integer width = 187
integer height = 80
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "Arrow!"
long textcolor = 33554432
long backcolor = 67108864
string text = "Salon:"
boolean focusrectangle = false
end type

type cbx_4 from checkbox within w_horario_salones_cd_mexico
integer x = 2994
integer y = 16
integer width = 768
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sólo incluir Materia-Grupo"
end type

type st_2 from statictext within w_horario_salones_cd_mexico
string tag = "~thpb_3.position"
boolean visible = false
integer x = 457
integer y = 244
integer width = 901
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Espere Creando Lista de Salones"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_salones_x_grupo from datawindow within w_horario_salones_cd_mexico
boolean visible = false
integer x = 1010
integer y = 1524
integer width = 686
integer height = 400
integer taborder = 30
string title = "none"
string dataobject = "dw_salones_x_grupo_cd_mex"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_lista_salones from datawindow within w_horario_salones_cd_mexico
integer x = 18
integer y = 204
integer width = 2135
integer height = 504
string title = "none"
string dataobject = "dw_lista_salones_a_imprimir_cd_mex"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieverow;if(isnull(object.descripcion[row])=true) then
	object.descripcion[row]="Salon "+string(object.cve_salon[row])
end if
end event

type cb_4 from commandbutton within w_horario_salones_cd_mexico
boolean visible = false
integer x = 64
integer y = 728
integer width = 635
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Seleccionar Todos"
end type

event clicked;long reng,cont_selecciona

reng=dw_lista_salones.rowcount()

for cont_selecciona= 1 to reng
	dw_lista_salones.object.imprimir[cont_selecciona]='s'
next
end event

type st_avance3 from statictext within w_horario_salones_cd_mexico
string tag = "~thpb_3.position"
integer x = 64
integer y = 888
integer width = 448
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Avance Hora:"
alignment alignment = right!
boolean focusrectangle = false
end type

type hpb_1 from hprogressbar within w_horario_salones_cd_mexico
integer x = 567
integer y = 896
integer width = 2999
integer height = 64
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
boolean smoothscroll = true
end type

type hpb_2 from hprogressbar within w_horario_salones_cd_mexico
integer x = 562
integer y = 820
integer width = 2999
integer height = 68
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
boolean smoothscroll = true
end type

type st_avance2 from statictext within w_horario_salones_cd_mexico
string tag = "~thpb_3.position"
integer x = 78
integer y = 812
integer width = 457
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Avance Dia:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_avance1 from statictext within w_horario_salones_cd_mexico
string tag = "~thpb_3.position"
integer x = 87
integer y = 736
integer width = 448
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Avance Total:"
alignment alignment = right!
boolean focusrectangle = false
end type

type hpb_3 from hprogressbar within w_horario_salones_cd_mexico
integer x = 562
integer y = 736
integer width = 2999
integer height = 72
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
boolean smoothscroll = true
end type

type hpb_avance_todos from hprogressbar within w_horario_salones_cd_mexico
boolean visible = false
integer x = 1344
integer y = 1204
integer width = 2277
integer height = 100
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 1
boolean smoothscroll = true
end type

type st_4 from statictext within w_horario_salones_cd_mexico
string tag = "~thpb_3.position"
boolean visible = false
integer x = 146
integer y = 1224
integer width = 1179
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Avance generación todos los horarios-salon:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_horario from datawindow within w_horario_salones_cd_mexico
integer x = 18
integer y = 864
integer width = 3826
integer height = 1088
integer taborder = 80
boolean titlebar = true
string title = "Reporte Salones"
string dataobject = "dw_plantilla_horario_todos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type
