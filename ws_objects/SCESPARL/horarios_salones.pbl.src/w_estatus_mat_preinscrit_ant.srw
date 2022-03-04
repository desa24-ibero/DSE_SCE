$PBExportHeader$w_estatus_mat_preinscrit_ant.srw
forward
global type w_estatus_mat_preinscrit_ant from window
end type
type cb_imprimir from commandbutton within w_estatus_mat_preinscrit_ant
end type
type st_4 from statictext within w_estatus_mat_preinscrit_ant
end type
type cb_1 from commandbutton within w_estatus_mat_preinscrit_ant
end type
type st_3 from statictext within w_estatus_mat_preinscrit_ant
end type
type dw_mat_preinscritas_rechazadas from datawindow within w_estatus_mat_preinscrit_ant
end type
type dw_mat_preinscritas from datawindow within w_estatus_mat_preinscrit_ant
end type
type dw_un_alumno from datawindow within w_estatus_mat_preinscrit_ant
end type
type sle_1 from singlelineedit within w_estatus_mat_preinscrit_ant
end type
type st_2 from statictext within w_estatus_mat_preinscrit_ant
end type
type st_1 from statictext within w_estatus_mat_preinscrit_ant
end type
type st_inicio_fin from statictext within w_estatus_mat_preinscrit_ant
end type
type ddlb_periodos from dropdownlistbox within w_estatus_mat_preinscrit_ant
end type
type dw_activacion_inicio_fin_periodo from datawindow within w_estatus_mat_preinscrit_ant
end type
type gb_2 from groupbox within w_estatus_mat_preinscrit_ant
end type
type dw_reporte from datawindow within w_estatus_mat_preinscrit_ant
end type
end forward

global type w_estatus_mat_preinscrit_ant from window
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
cb_imprimir cb_imprimir
st_4 st_4
cb_1 cb_1
st_3 st_3
dw_mat_preinscritas_rechazadas dw_mat_preinscritas_rechazadas
dw_mat_preinscritas dw_mat_preinscritas
dw_un_alumno dw_un_alumno
sle_1 sle_1
st_2 st_2
st_1 st_1
st_inicio_fin st_inicio_fin
ddlb_periodos ddlb_periodos
dw_activacion_inicio_fin_periodo dw_activacion_inicio_fin_periodo
gb_2 gb_2
dw_reporte dw_reporte
end type
global w_estatus_mat_preinscrit_ant w_estatus_mat_preinscrit_ant

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
	
		dw_un_alumno.visible=true
		cb_imprimir.visible=true

//		dw_un_alumno.object.t_proceso_preinsc.text=string(proceso_preinsc)	
	
		if(dw_mat_preinscritas.retrieve(cuenta_a_buscar_num,anio_a_buscar,periodo_a_buscar)>0) then
			dw_mat_preinscritas.visible=true
		else
				messagebox("Aviso","¡No hay Materias Preinscritas!")
		end if
		
		if(dw_mat_preinscritas_rechazadas.retrieve(cuenta_a_buscar_num,anio_a_buscar,periodo_a_buscar)>0) then
			dw_mat_preinscritas_rechazadas.visible=true
		else
			messagebox("Aviso","¡No hay Materias Preinscritas Rechazadas!")			
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
				dw_lista_materias_preinsc.retrieve(cuenta_a_buscar_num,anio_a_buscar,periodo_a_buscar)
		end if	
	
		error1=dw_reporte.Getchild("dw_mat_preinscritas_rechazadas_reporte",dw_lista_materias_preinsc_rechaz)

		if(error1=-1) then
			messagebox("","error"+string(error1))
		else
			dw_lista_materias_preinsc_rechaz.settransobject(tipo_conexion)
			dw_lista_materias_preinsc_rechaz.retrieve(cuenta_a_buscar_num,anio_a_buscar,periodo_a_buscar)
		end if	
	else // no existe el alumno
		dw_un_alumno.visible=false
		dw_mat_preinscritas.visible=false
		dw_mat_preinscritas_rechazadas.visible=false
		cb_imprimir.visible=false
		
		messagebox("Aviso","¡El alumno no existe!")
	end if
else // no es correcto el digito verif
	dw_un_alumno.visible=false
	dw_mat_preinscritas.visible=false
	dw_mat_preinscritas_rechazadas.visible=false
	cb_imprimir.visible=false	
	
	messagebox("Aviso","¡El dígito verificador es incorrecto!")
end if
end subroutine

on w_estatus_mat_preinscrit_ant.create
if this.MenuName = "m_menu_estatus_mat_preinscrit" then this.MenuID = create m_menu_estatus_mat_preinscrit
this.cb_imprimir=create cb_imprimir
this.st_4=create st_4
this.cb_1=create cb_1
this.st_3=create st_3
this.dw_mat_preinscritas_rechazadas=create dw_mat_preinscritas_rechazadas
this.dw_mat_preinscritas=create dw_mat_preinscritas
this.dw_un_alumno=create dw_un_alumno
this.sle_1=create sle_1
this.st_2=create st_2
this.st_1=create st_1
this.st_inicio_fin=create st_inicio_fin
this.ddlb_periodos=create ddlb_periodos
this.dw_activacion_inicio_fin_periodo=create dw_activacion_inicio_fin_periodo
this.gb_2=create gb_2
this.dw_reporte=create dw_reporte
this.Control[]={this.cb_imprimir,&
this.st_4,&
this.cb_1,&
this.st_3,&
this.dw_mat_preinscritas_rechazadas,&
this.dw_mat_preinscritas,&
this.dw_un_alumno,&
this.sle_1,&
this.st_2,&
this.st_1,&
this.st_inicio_fin,&
this.ddlb_periodos,&
this.dw_activacion_inicio_fin_periodo,&
this.gb_2,&
this.dw_reporte}
end on

on w_estatus_mat_preinscrit_ant.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_imprimir)
destroy(this.st_4)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.dw_mat_preinscritas_rechazadas)
destroy(this.dw_mat_preinscritas)
destroy(this.dw_un_alumno)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_inicio_fin)
destroy(this.ddlb_periodos)
destroy(this.dw_activacion_inicio_fin_periodo)
destroy(this.gb_2)
destroy(this.dw_reporte)
end on

event open;/******************************************************************************

Módulo de Reporte de Materias Preinscritas

Análisis, Diseño y Programación

César Ponce Hdz.

Ibero - Tijuana, Feb/2017



******************************************************************************/

w_estatus_mat_preinscrit.title="Módulo de Reporte de Materias Preinscritas        Ibero-Tijuana                                               CPH. Feb/2017"


if conecta_bd(itr_web,"WEB_PARAM", gs_usuario,gs_password)<>1 then

	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	return
else 
	string alumno_str
//	select nombre_completo into :alumno_str from alumnos where cuenta=146738 using itr_web;	
//	messagebox("","Error al conectar a Base de Datos de SQL Serverme conecte!!! "+alumno_str+"-"+obten_digito(long(alumno_str)))	

end if



tipo_conexion=itr_web

dw_activacion_inicio_fin_periodo.settransobject(tipo_conexion)


num_periodos=dw_activacion_inicio_fin_periodo.retrieve()

//ddlb_1.additem("1");
//ddlb_1.additem("2");



if(num_periodos>0) then

	ddlb_periodos.insertitem(string(dw_activacion_inicio_fin_periodo.object.anio[1])+' - '+dw_activacion_inicio_fin_periodo.object.periodo_descripcion[1],1)

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

		return
	else
		select proceso_preinsc into :proceso_preinsc from activacion_su where anio=:anio_a_buscar and periodo=:periodo_a_buscar using tipo_conexion;
		
		st_4.text="Proceso Preinscripción: "+string(proceso_preinsc)
	end if



	st_inicio_fin.text='Periodo (dd/mm/aaaa): '+string(inicio_periodo_academ,"dd/mm/yyyy")+' - '+string(fin_periodo_academ,"dd/mm/yyyy")
//	carga_grupos()
else
	messagebox("Advertencia!","No Existen Periodos Academicos!")
	close(this)
end if



dw_un_alumno.settransobject(tipo_conexion)
dw_mat_preinscritas.settransobject(tipo_conexion)
dw_mat_preinscritas_rechazadas.settransobject(tipo_conexion)

dw_un_alumno.visible=false
dw_mat_preinscritas.visible=false
dw_mat_preinscritas_rechazadas.visible=false
cb_imprimir.visible=false

sle_1.setfocus()
end event

event resize;//dw_mat_preinscritas

dw_mat_preinscritas.height=this.height - 2200

dw_mat_preinscritas.width=this.width - 200

dw_mat_preinscritas_rechazadas.y=dw_mat_preinscritas.y+ dw_mat_preinscritas.height + 100

dw_mat_preinscritas_rechazadas.height=dw_mat_preinscritas.height

dw_mat_preinscritas_rechazadas.width=this.width - 200
end event

event close;desconecta_bd(itr_web)
end event

type cb_imprimir from commandbutton within w_estatus_mat_preinscrit_ant
integer x = 1650
integer y = 272
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

type st_4 from statictext within w_estatus_mat_preinscrit_ant
integer x = 1705
integer y = 164
integer width = 1138
integer height = 80
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

type cb_1 from commandbutton within w_estatus_mat_preinscrit_ant
integer x = 951
integer y = 272
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

type st_3 from statictext within w_estatus_mat_preinscrit_ant
integer x = 229
integer y = 280
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

type dw_mat_preinscritas_rechazadas from datawindow within w_estatus_mat_preinscrit_ant
integer x = 41
integer y = 1296
integer width = 4274
integer height = 492
integer taborder = 60
string title = "Materias preinscritas rechazadas."
string dataobject = "dw_mat_preinscritas_rechazadas_reporte"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_mat_preinscritas from datawindow within w_estatus_mat_preinscrit_ant
integer x = 41
integer y = 736
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

type dw_un_alumno from datawindow within w_estatus_mat_preinscrit_ant
integer x = 41
integer y = 392
integer width = 3895
integer height = 324
integer taborder = 50
string title = "none"
string dataobject = "dw_un_alumno"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_estatus_mat_preinscrit_ant
integer x = 462
integer y = 272
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

type st_2 from statictext within w_estatus_mat_preinscrit_ant
integer x = 2670
integer y = 308
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
string text = "Versión 13/Feb/2017 4:30 a.m. (Tij)"
boolean focusrectangle = false
end type

type st_1 from statictext within w_estatus_mat_preinscrit_ant
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

type st_inicio_fin from statictext within w_estatus_mat_preinscrit_ant
integer x = 1701
integer y = 68
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

type ddlb_periodos from dropdownlistbox within w_estatus_mat_preinscrit_ant
integer x = 864
integer y = 108
integer width = 745
integer height = 400
integer taborder = 20
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
//	cb_2.enabled=false
	return
else
	
	select proceso_preinsc into :proceso_preinsc from activacion_su where anio=:anio_a_buscar and periodo=:periodo_a_buscar using tipo_conexion;

	st_4.text="Proceso Preinscripción: "+string(proceso_preinsc)

//	cb_2.enabled=true
end if

st_inicio_fin.text='Periodo (dd/mm/aaaa): '+string(inicio_periodo_academ,"dd/mm/yyyy")+' - '+string(fin_periodo_academ,"dd/mm/yyyy")

carga_grupos()

end event

type dw_activacion_inicio_fin_periodo from datawindow within w_estatus_mat_preinscrit_ant
boolean visible = false
integer x = 2551
integer y = 176
integer width = 567
integer height = 136
integer taborder = 30
string title = "none"
string dataobject = "dw_anio_periodo_mat_preinsc"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieverow;if(row>1) then
	ddlb_periodos.insertitem(string(object.anio[row])+' - '+object.descripcion[row],row)

end if
end event

type gb_2 from groupbox within w_estatus_mat_preinscrit_ant
integer x = 46
integer width = 4128
integer height = 268
integer taborder = 40
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

type dw_reporte from datawindow within w_estatus_mat_preinscrit_ant
boolean visible = false
integer x = 421
integer y = 960
integer width = 2121
integer height = 968
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "dw_reporte_mat_preinscritas_x_alumno"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

