$PBExportHeader$w_empalme_horarios_resp.srw
forward
global type w_empalme_horarios_resp from window
end type
type uo_periodos from uo_periodos_checkbox within w_empalme_horarios_resp
end type
type st_3 from statictext within w_empalme_horarios_resp
end type
type ddlb_clase_aula from dropdownlistbox within w_empalme_horarios_resp
end type
type dw_clase_aula from datawindow within w_empalme_horarios_resp
end type
type st_2 from statictext within w_empalme_horarios_resp
end type
type st_1 from statictext within w_empalme_horarios_resp
end type
type st_inicio_fin from statictext within w_empalme_horarios_resp
end type
type ddlb_periodos from dropdownlistbox within w_empalme_horarios_resp
end type
type dw_activacion_inicio_fin_periodo from datawindow within w_empalme_horarios_resp
end type
type dw_empalmes from datawindow within w_empalme_horarios_resp
end type
end forward

global type w_empalme_horarios_resp from window
integer width = 4480
integer height = 2844
boolean titlebar = true
string title = "Empalme de Horarios Ibero-Tijuana                                                                             CPH. Ene-Feb/2017"
string menuname = "m_menu_empalme_horarios"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
uo_periodos uo_periodos
st_3 st_3
ddlb_clase_aula ddlb_clase_aula
dw_clase_aula dw_clase_aula
st_2 st_2
st_1 st_1
st_inicio_fin st_inicio_fin
ddlb_periodos ddlb_periodos
dw_activacion_inicio_fin_periodo dw_activacion_inicio_fin_periodo
dw_empalmes dw_empalmes
end type
global w_empalme_horarios_resp w_empalme_horarios_resp

type variables
int anio_a_buscar,	periodo_a_buscar,num_periodos

transaction tipo_conexion

date inicio_periodo_academ, fin_periodo_academ


int	clave_materia_global
string	grupo_global

date	grupos_fecha_inicio_curso
date	grupos_fecha_fin_curso

int cont_clase_aula
int clase_aula

int periodo_seleccionado

boolean periodo_sem_selecc,periodo_trim_selecc
integer anio_sem_a_buscar,periodo_sem_a_buscar,anio_trim_a_buscar,periodo_trim_abuscar
end variables

forward prototypes
public subroutine carga_empalmes ()
end prototypes

public subroutine carga_empalmes ();//dw_empalmes.dataobject="dw_empalme_todos"
//dw_empalmes.settransobject(tipo_conexion)	
//dw_empalmes.retrieve()

if(periodo_seleccionado=1 ) then // Todos
	dw_empalmes.object.t_periodo.text="Periodo(s): Todos"
	if(clase_aula=-1) then
		dw_empalmes.object.t_clase_aula.text="Clase Aula: Todos los tipo de salón"
		dw_empalmes.setfilter("")
		dw_empalmes.filter()

		
	else	
		dw_empalmes.object.t_clase_aula.text="Clase Aula: "+ddlb_clase_aula.text		
		dw_empalmes.setfilter("horario_clase_aula="+string(clase_aula))
		dw_empalmes.filter()
		dw_empalmes.title="Horarios Empalmados. Se cargaron: "+string(dw_empalmes.rowcount())	
		
	end if
else
	dw_empalmes.object.t_periodo.text="Periodo: "+periodo_en_texto(periodo_a_buscar)+" de "+string(anio_a_buscar)	
	if(clase_aula=-1) then
		dw_empalmes.object.t_clase_aula.text="Clase Aula: Todos los tipos de salón"
		dw_empalmes.setfilter("horario_anio="+string(anio_a_buscar)+" and horario_periodo="+string(periodo_a_buscar))		
		dw_empalmes.filter()
		dw_empalmes.title="Horarios Empalmados. Se cargaron: "+string(dw_empalmes.rowcount())	
	else	
		dw_empalmes.object.t_clase_aula.text="Clase Aula: "+ddlb_clase_aula.text
		dw_empalmes.setfilter("horario_clase_aula="+string(clase_aula)+" and horario_anio="+string(anio_a_buscar)+" and horario_periodo="+string(periodo_a_buscar))
		dw_empalmes.filter()
		dw_empalmes.title="Horarios Empalmados. Se cargaron: "+string(dw_empalmes.rowcount())	
		
	end if
end if


dw_empalmes.title="Horarios Empalmados. Se cargaron: "+string(dw_empalmes.rowcount())			
dw_empalmes.setfocus( )


end subroutine

on w_empalme_horarios_resp.create
if this.MenuName = "m_menu_empalme_horarios" then this.MenuID = create m_menu_empalme_horarios
this.uo_periodos=create uo_periodos
this.st_3=create st_3
this.ddlb_clase_aula=create ddlb_clase_aula
this.dw_clase_aula=create dw_clase_aula
this.st_2=create st_2
this.st_1=create st_1
this.st_inicio_fin=create st_inicio_fin
this.ddlb_periodos=create ddlb_periodos
this.dw_activacion_inicio_fin_periodo=create dw_activacion_inicio_fin_periodo
this.dw_empalmes=create dw_empalmes
this.Control[]={this.uo_periodos,&
this.st_3,&
this.ddlb_clase_aula,&
this.dw_clase_aula,&
this.st_2,&
this.st_1,&
this.st_inicio_fin,&
this.ddlb_periodos,&
this.dw_activacion_inicio_fin_periodo,&
this.dw_empalmes}
end on

on w_empalme_horarios_resp.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_periodos)
destroy(this.st_3)
destroy(this.ddlb_clase_aula)
destroy(this.dw_clase_aula)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_inicio_fin)
destroy(this.ddlb_periodos)
destroy(this.dw_activacion_inicio_fin_periodo)
destroy(this.dw_empalmes)
end on

event open;/******************************************************************************

Módulo de Reporte de Empalme de Horarios-Salones.

Análisis, Diseño y Programación

César Ponce Hdz.

Ibero - Tijuana, Ene-Feb/2017



******************************************************************************/

w_empalme_horarios.title="Empalme de Horarios Ibero-Tijuana                                                                             CPH. Ene-Feb/2017"

tipo_conexion=gtr_sce

uo_periodos.inicializa_periodos(gtr_sce) // CPH Marzo/2017

dw_activacion_inicio_fin_periodo.settransobject(tipo_conexion)

dw_clase_aula.settransobject(tipo_conexion)
cont_clase_aula=dw_clase_aula.retrieve()


num_periodos=dw_activacion_inicio_fin_periodo.retrieve()


st_inicio_fin.text=""


periodo_seleccionado=1

if(num_periodos>0) then

	ddlb_periodos.insertitem("Todos los periodos",1)	

	ddlb_periodos.insertitem(string(dw_activacion_inicio_fin_periodo.object.anio[1])+' - '+dw_activacion_inicio_fin_periodo.object.descripcion[1],2)



	anio_a_buscar=dw_activacion_inicio_fin_periodo.object.anio[1]
	periodo_a_buscar=dw_activacion_inicio_fin_periodo.object.periodo[1]
	inicio_periodo_academ=date(dw_activacion_inicio_fin_periodo.object.fecha_inicio_periodo[1])
	fin_periodo_academ=date(dw_activacion_inicio_fin_periodo.object.fecha_fin_periodo[1])

	inicio_periodo_academ=date(dw_activacion_inicio_fin_periodo.object.fecha_inicio_periodo[1])
	fin_periodo_academ=date(dw_activacion_inicio_fin_periodo.object.fecha_fin_periodo[1])



	ddlb_periodos.selectitem( 1)

else
	messagebox("Advertencia!","No Existen Periodos Academicos!")
	close(this)
end if


// Clase aula

ddlb_clase_aula.reset( )

clase_aula=-1


ddlb_clase_aula.insertitem("Todos los tipos de salón",1)
	
int cont_crea_menu_clase_aula

cont_clase_aula=dw_clase_aula.rowcount()
	
for cont_crea_menu_clase_aula=1 to cont_clase_aula
	ddlb_clase_aula.insertitem(string(dw_clase_aula.object.clase[cont_crea_menu_clase_aula])+' - '+dw_clase_aula.object.nombre_aula[cont_crea_menu_clase_aula],cont_crea_menu_clase_aula + 1)		
next
	
ddlb_clase_aula.selectitem(1)	

dw_empalmes.dataobject="dw_empalme_todos"
dw_empalmes.settransobject(tipo_conexion)	
dw_empalmes.retrieve()


carga_empalmes()



end event

event resize;dw_empalmes.height=this.height - 850

dw_empalmes.width=this.width - 200
end event

type uo_periodos from uo_periodos_checkbox within w_empalme_horarios_resp
integer x = 1998
integer y = 12
integer taborder = 20
end type

on uo_periodos.destroy
call uo_periodos_checkbox::destroy
end on

type st_3 from statictext within w_empalme_horarios_resp
integer x = 357
integer y = 272
integer width = 279
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Clase Aula"
boolean focusrectangle = false
end type

type ddlb_clase_aula from dropdownlistbox within w_empalme_horarios_resp
integer x = 663
integer y = 260
integer width = 1019
integer height = 588
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//anio_a_buscar
//periodo_a_buscar

long renglon
renglon=index

if(renglon=1) then
	clase_aula=-1
else
	clase_aula=dw_clase_aula.object.clase[renglon - 1]
//	st_inicio_fin.text='Clase'+string(clase_aula)
end if

carga_empalmes()
end event

type dw_clase_aula from datawindow within w_empalme_horarios_resp
boolean visible = false
integer x = 955
integer y = 444
integer width = 686
integer height = 400
integer taborder = 40
string title = "none"
string dataobject = "dw_clase_aula"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_empalme_horarios_resp
integer x = 2171
integer y = 464
integer width = 1061
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Versión 7/feb/2017 3.39 a.m. Tij"
boolean focusrectangle = false
end type

type st_1 from statictext within w_empalme_horarios_resp
integer x = 64
integer y = 108
integer width = 594
integer height = 88
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

type st_inicio_fin from statictext within w_empalme_horarios_resp
integer x = 1445
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

type ddlb_periodos from dropdownlistbox within w_empalme_horarios_resp
integer x = 663
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

periodo_seleccionado=renglon

if(renglon>1) then

anio_a_buscar=dw_activacion_inicio_fin_periodo.object.anio[index - 1]
periodo_a_buscar=dw_activacion_inicio_fin_periodo.object.periodo[index - 1]
inicio_periodo_academ=date(dw_activacion_inicio_fin_periodo.object.fecha_inicio_periodo[index - 1])
fin_periodo_academ=date(dw_activacion_inicio_fin_periodo.object.fecha_fin_periodo[index - 1])


st_inicio_fin.text='Periodo (dd/mm/aaaa): '+string(inicio_periodo_academ,"dd/mm/yyyy")+' - '+string(fin_periodo_academ,"dd/mm/yyyy")

else
	st_inicio_fin.text=""
end if

carga_empalmes()
end event

type dw_activacion_inicio_fin_periodo from datawindow within w_empalme_horarios_resp
boolean visible = false
integer x = 1719
integer y = 444
integer width = 530
integer height = 344
integer taborder = 20
string title = "none"
string dataobject = "dw_activacion_inicio_fin_periodo"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieverow;if(row>1) then
	ddlb_periodos.insertitem(string(object.anio[row])+' - '+object.descripcion[row],row + 1)

end if
end event

type dw_empalmes from datawindow within w_empalme_horarios_resp
integer x = 78
integer y = 552
integer width = 4142
integer height = 1300
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Reporte de Empalme de Horarios"
string dataobject = "dw_empalme_todos"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

