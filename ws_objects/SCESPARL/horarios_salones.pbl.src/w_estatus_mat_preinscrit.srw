$PBExportHeader$w_estatus_mat_preinscrit.srw
forward
global type w_estatus_mat_preinscrit from window
end type
type uo_periodos from uo_periodos_checkbox within w_estatus_mat_preinscrit
end type
type cb_imprimir from commandbutton within w_estatus_mat_preinscrit
end type
type cb_1 from commandbutton within w_estatus_mat_preinscrit
end type
type st_3 from statictext within w_estatus_mat_preinscrit
end type
type sle_1 from singlelineedit within w_estatus_mat_preinscrit
end type
type st_2 from statictext within w_estatus_mat_preinscrit
end type
type dw_un_alumno from datawindow within w_estatus_mat_preinscrit
end type
type dw_reporte from datawindow within w_estatus_mat_preinscrit
end type
type dw_mat_preinscritas from datawindow within w_estatus_mat_preinscrit
end type
end forward

global type w_estatus_mat_preinscrit from window
integer width = 4480
integer height = 2844
boolean titlebar = true
string title = "~"Módulo de Reporte de Materias Preinscritas        Ibero-Tijuana                                               CPH. Feb/2017~""
string menuname = "m_menu_estatus_mat_preinscrit"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
uo_periodos uo_periodos
cb_imprimir cb_imprimir
cb_1 cb_1
st_3 st_3
sle_1 sle_1
st_2 st_2
dw_un_alumno dw_un_alumno
dw_reporte dw_reporte
dw_mat_preinscritas dw_mat_preinscritas
end type
global w_estatus_mat_preinscrit w_estatus_mat_preinscrit

type variables
int anio_a_buscar,	periodo_a_buscar,num_periodos

transaction tipo_conexion

date inicio_periodo_academ, fin_periodo_academ


int	clave_materia_global
string	grupo_global

date	grupos_fecha_inicio_curso
date	grupos_fecha_fin_curso

n_tr itr_web


string cuenta_a_buscar
long cuenta_a_buscar_num

int proceso_preinsc

boolean periodo_sem_selecc,periodo_trim_selecc
integer anio_sem_a_buscar,periodo_sem_a_buscar,anio_trim_a_buscar,periodo_trim_a_buscar
end variables

forward prototypes
public subroutine carga_grupos ()
public subroutine carga_alumno ()
end prototypes

public subroutine carga_grupos ();//
end subroutine

public subroutine carga_alumno ();// Cesar Ponce H, Tijuana, Feb/2017

DataWindowChild dw_encabezado,dw_lista_materias_preinsc,dw_lista_materias_preinsc_rechaz


long renglones

char digito_verif

cuenta_a_buscar=left(sle_1.text, len(sle_1.text) - 1)
digito_verif=right(sle_1.text,1)
cuenta_a_buscar_num=long(cuenta_a_buscar)

if (digito_verif=obten_digito(cuenta_a_buscar_num)) then

	renglones=dw_un_alumno.retrieve(cuenta_a_buscar_num,proceso_preinsc)
	if(renglones>0) then
	
		uo_periodos.obtener_periodos(anio_sem_a_buscar,periodo_sem_a_buscar,anio_trim_a_buscar,periodo_trim_a_buscar,periodo_sem_selecc,periodo_trim_selecc)	
		
		if not(periodo_sem_selecc) then
			anio_sem_a_buscar=0 // para forzar a que no cargue nada cph Marzo/2017
			periodo_sem_a_buscar=100 // para forzar a que no cargue nada cph Marzo/2017
		end if
	
		if not(periodo_trim_selecc) then
			anio_trim_a_buscar=0 // para forzar a que no cargue nada cph Marzo/2017
			periodo_trim_a_buscar=100 // para forzar a que no cargue nada cph Marzo/2017
		end if
	
	
	//	dw_un_alumno.visible=true // se ocultan para que solo se vea el reporte. CPH 24/Marzo/2017
		cb_imprimir.visible=true
		

//		dw_un_alumno.object.t_proceso_preinsc.text=string(proceso_preinsc)	
	
		if(dw_mat_preinscritas.retrieve(cuenta_a_buscar_num,anio_sem_a_buscar,periodo_sem_a_buscar,anio_trim_a_buscar,periodo_trim_a_buscar)>0) then
			// dw_mat_preinscritas.visible=true // se ocultan para que solo se vea el reporte. CPH 24/Marzo/2017
		else
				messagebox("Aviso","¡No hay Materias Preinscritas!")
		end if
		
	
		integer error1

		error1=dw_reporte.Getchild("dw_un_alumno",dw_encabezado)

		if(error1=-1) then
			messagebox("","error"+string(error1))
		else
				dw_encabezado.settransobject(tipo_conexion)
				dw_encabezado.retrieve(cuenta_a_buscar_num,proceso_preinsc)
			
		end if
	
		error1=dw_reporte.Getchild("dw_mat_preinscritas_reporte",dw_lista_materias_preinsc)

		if(error1=-1) then
			messagebox("","error"+string(error1))
		else
				dw_lista_materias_preinsc.settransobject(tipo_conexion)
				dw_lista_materias_preinsc.retrieve(cuenta_a_buscar_num,anio_sem_a_buscar,periodo_sem_a_buscar,anio_trim_a_buscar,periodo_trim_a_buscar)

		end if	
	
	else // no existe el alumno
		dw_un_alumno.visible=false
		dw_mat_preinscritas.visible=false

		cb_imprimir.visible=false
		
		messagebox("Aviso","¡El alumno no existe!")
	end if
else // no es correcto el digito verif
	dw_un_alumno.visible=false
	dw_mat_preinscritas.visible=false

	cb_imprimir.visible=false	
	
	messagebox("Aviso","¡El dígito verificador es incorrecto!")
end if


// se ocultan para que solo se vea el reporte. CPH 24/Marzo/2017
dw_un_alumno.visible=false
dw_mat_preinscritas.visible=false

end subroutine

on w_estatus_mat_preinscrit.create
if this.MenuName = "m_menu_estatus_mat_preinscrit" then this.MenuID = create m_menu_estatus_mat_preinscrit
this.uo_periodos=create uo_periodos
this.cb_imprimir=create cb_imprimir
this.cb_1=create cb_1
this.st_3=create st_3
this.sle_1=create sle_1
this.st_2=create st_2
this.dw_un_alumno=create dw_un_alumno
this.dw_reporte=create dw_reporte
this.dw_mat_preinscritas=create dw_mat_preinscritas
this.Control[]={this.uo_periodos,&
this.cb_imprimir,&
this.cb_1,&
this.st_3,&
this.sle_1,&
this.st_2,&
this.dw_un_alumno,&
this.dw_reporte,&
this.dw_mat_preinscritas}
end on

on w_estatus_mat_preinscrit.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_periodos)
destroy(this.cb_imprimir)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.dw_un_alumno)
destroy(this.dw_reporte)
destroy(this.dw_mat_preinscritas)
end on

event open;/******************************************************************************

Módulo de Reporte de Materias Preinscritas

Análisis, Diseño y Programación

César Ponce Hdz.

Ibero - Tijuana, Feb/2017



******************************************************************************/

w_estatus_mat_preinscrit.title="Módulo de Reporte de Materias Preinscritas        Ibero-Tijuana                   CPH. Marzo	/2017"

w_principal.toolbarvisible=false

if conecta_bd(itr_web,"WEB_PARAM", gs_usuario,gs_password)<>1 then

	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	return
else 
	string alumno_str
//	select nombre_completo into :alumno_str from alumnos where cuenta=146738 using itr_web;	
//	messagebox("","Error al conectar a Base de Datos de SQL Serverme conecte!!! "+alumno_str+"-"+obten_digito(long(alumno_str)))	

end if



tipo_conexion=itr_web


uo_periodos.inicializa_periodos( tipo_conexion)

int anio_preinsc_sem,anio_preinsc_trim
int periodo_preinsc_sem,periodo_preinsc_trim

uo_periodos.uo_1.em_per.enabled=false
uo_periodos.uo_1.em_ani.enabled=false			
uo_periodos.uo_2.em_per.enabled=false
uo_periodos.uo_2.em_ani.enabled=false			


select count(*) into :periodo_preinsc_sem from periodos_por_procesos where cve_proceso=3 and tipo_periodo='S' using tipo_conexion;
if (periodo_preinsc_sem=0) then
	messagebox("Aviso","No existe periodo semestral de preinscripcion por default")
	periodo_preinsc_sem=-1
	uo_periodos.uo_1.em_per.enabled=false	
	uo_periodos.uo_1.em_ani.enabled=false			
	uo_periodos.cbx_semestral.checked=false	
	uo_periodos.cbx_semestral.enabled=false	
else
	select anio,periodo into :anio_preinsc_sem,:periodo_preinsc_sem from periodos_por_procesos where cve_proceso=3 and tipo_periodo='S' using tipo_conexion;	
	uo_periodos.uo_1.em_per.text=string(periodo_preinsc_sem)	
	uo_periodos.uo_1.em_ani.text=string(anio_preinsc_sem)		

end if


select count(*) into :periodo_preinsc_trim from periodos_por_procesos where cve_proceso=3 and tipo_periodo='T' using tipo_conexion;
if (periodo_preinsc_trim=0) then
	messagebox("Aviso","No existe periodo trimestral de preinscripcion por default")
	periodo_preinsc_trim=-1
	uo_periodos.uo_2.em_per.enabled=false	
	uo_periodos.uo_2.em_ani.enabled=false		
	uo_periodos.cbx_trimestral.checked=false	
	uo_periodos.cbx_trimestral.enabled=false	
else
	select anio,periodo into :anio_preinsc_trim,:periodo_preinsc_trim from periodos_por_procesos where cve_proceso=3 and tipo_periodo='T' using tipo_conexion;	
	uo_periodos.uo_2.em_per.text=string(periodo_preinsc_trim)	
	uo_periodos.uo_2.em_ani.text=string(anio_preinsc_trim)		
end if





//ddlb_1.additem("1");
//ddlb_1.additem("2");



dw_un_alumno.settransobject(tipo_conexion)
dw_mat_preinscritas.settransobject(tipo_conexion)


dw_un_alumno.visible=false
dw_mat_preinscritas.visible=false

cb_imprimir.visible=false

sle_1.setfocus()
end event

event resize;//dw_mat_preinscritas

dw_mat_preinscritas.height=this.height - 2200

dw_mat_preinscritas.width=this.width - 200

//dw_mat_preinscritas_rechazadas.y=dw_mat_preinscritas.y+ dw_mat_preinscritas.height + 50

//dw_mat_preinscritas_rechazadas.height=dw_mat_preinscritas.height

//dw_mat_preinscritas_rechazadas.width=this.width - 250

dw_reporte.height=this.height - 900
dw_reporte.width=this.width - 200
end event

event close;desconecta_bd(itr_web)
w_principal.toolbarvisible=true
end event

type uo_periodos from uo_periodos_checkbox within w_estatus_mat_preinscrit
integer x = 96
integer y = 56
integer taborder = 50
end type

on uo_periodos.destroy
call uo_periodos_checkbox::destroy
end on

type cb_imprimir from commandbutton within w_estatus_mat_preinscrit
integer x = 1646
integer y = 472
integer width = 503
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Imprimir Reporte"
end type

event clicked;w_estatus_mat_preinscrit.dw_reporte.print()
end event

type cb_1 from commandbutton within w_estatus_mat_preinscrit
integer x = 946
integer y = 472
integer width = 457
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Carga"
end type

event clicked;carga_alumno()
end event

type st_3 from statictext within w_estatus_mat_preinscrit
integer x = 224
integer y = 480
integer width = 215
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cuenta"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_estatus_mat_preinscrit
integer x = 457
integer y = 472
integer width = 457
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;carga_alumno()
end event

type st_2 from statictext within w_estatus_mat_preinscrit
integer x = 2665
integer y = 508
integer width = 1033
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Versión 23/Marzo/2017 4:30 a.m. (Tij)"
boolean focusrectangle = false
end type

type dw_un_alumno from datawindow within w_estatus_mat_preinscrit
integer x = 69
integer y = 688
integer width = 3895
integer height = 324
integer taborder = 50
string title = "none"
string dataobject = "dw_un_alumno"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_reporte from datawindow within w_estatus_mat_preinscrit
integer x = 69
integer y = 680
integer width = 4265
integer height = 1496
integer taborder = 70
boolean titlebar = true
string title = "Materia Preinscritas por Alumno"
string dataobject = "dw_reporte_mat_preinscritas_x_alumno"
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_mat_preinscritas from datawindow within w_estatus_mat_preinscrit
integer x = 69
integer y = 1028
integer width = 4279
integer height = 536
integer taborder = 60
string title = "Materias preinscritas"
string dataobject = "dw_mat_preinscritas_reporte"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

