$PBExportHeader$w_empalme_horarios.srw
forward
global type w_empalme_horarios from window
end type
type cb_2 from commandbutton within w_empalme_horarios
end type
type cb_1 from commandbutton within w_empalme_horarios
end type
type st_2 from statictext within w_empalme_horarios
end type
type st_1 from statictext within w_empalme_horarios
end type
type dw_empalmes from datawindow within w_empalme_horarios
end type
type cb_seleccionar from commandbutton within w_empalme_horarios
end type
type dw_clase_aula from datawindow within w_empalme_horarios
end type
type uo_periodos from uo_periodos_checkbox within w_empalme_horarios
end type
end forward

global type w_empalme_horarios from window
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
cb_2 cb_2
cb_1 cb_1
st_2 st_2
st_1 st_1
dw_empalmes dw_empalmes
cb_seleccionar cb_seleccionar
dw_clase_aula dw_clase_aula
uo_periodos uo_periodos
end type
global w_empalme_horarios w_empalme_horarios

type variables
int anio_a_buscar,	periodo_a_buscar,num_periodos

transaction tipo_conexion

date inicio_periodo_academ, fin_periodo_academ


int	clave_materia_global
string	grupo_global

date	grupos_fecha_inicio_curso
date	grupos_fecha_fin_curso

int cont_clase_aula
int clase_aula[10]

int periodo_seleccionado


boolean periodo_sem_selecc,periodo_trim_selecc
integer anio_sem_a_buscar,periodo_sem_a_buscar,anio_trim_a_buscar,periodo_trim_a_buscar
end variables

forward prototypes
public subroutine carga_empalmes ()
end prototypes

public subroutine carga_empalmes ();//dw_empalmes.dataobject="dw_empalme_todos"
//dw_empalmes.settransobject(tipo_conexion)	


if not(periodo_sem_selecc) then
	anio_sem_a_buscar=-1
	periodo_sem_a_buscar=-1
end if
if not(periodo_trim_selecc) then
	anio_trim_a_buscar=-1
	periodo_trim_a_buscar	=-1
end if


int inicializa

for inicializa=1 to 10
	clase_aula[inicializa]=-1
next


int cont_reng 

for cont_reng=1 to dw_clase_aula.rowcount()
	if 	dw_clase_aula.object.seleccionada[cont_reng]=1 then
		clase_aula[cont_reng]=dw_clase_aula.object.clase[cont_reng]

	end if
next

dw_empalmes.object.t_periodo.text="Periodo(s): "

if(dw_empalmes.retrieve(anio_sem_a_buscar,periodo_sem_a_buscar,anio_trim_a_buscar,periodo_trim_a_buscar,clase_aula)>0) then
	

	if periodo_sem_selecc then
		dw_empalmes.object.t_periodo.text= dw_empalmes.object.t_periodo.text +periodo_en_texto(periodo_sem_a_buscar)+" de "+string(anio_sem_a_buscar)		

	end if

	if periodo_trim_selecc then
		if periodo_sem_selecc then	
			dw_empalmes.object.t_periodo.text =dw_empalmes.object.t_periodo.text + ", "+periodo_en_texto(periodo_trim_a_buscar)+" de "+string(anio_trim_a_buscar)	
		else
			dw_empalmes.object.t_periodo.text=periodo_en_texto(periodo_trim_a_buscar)+" de "+string(anio_trim_a_buscar)				
		end if

	end if
//	if (periodo_sem_selecc and periodo_trim_selecc) then
	//		dw_empalmes.object.t_periodo.text="Periodo(s): Todos"
//	end if

end if
//dw_empalmes.retrieve()
/*
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

*/
dw_empalmes.title="Horarios Empalmados. Se cargaron: "+string(dw_empalmes.rowcount())			
dw_empalmes.setfocus( )


end subroutine

on w_empalme_horarios.create
if this.MenuName = "m_menu_empalme_horarios" then this.MenuID = create m_menu_empalme_horarios
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_2=create st_2
this.st_1=create st_1
this.dw_empalmes=create dw_empalmes
this.cb_seleccionar=create cb_seleccionar
this.dw_clase_aula=create dw_clase_aula
this.uo_periodos=create uo_periodos
this.Control[]={this.cb_2,&
this.cb_1,&
this.st_2,&
this.st_1,&
this.dw_empalmes,&
this.cb_seleccionar,&
this.dw_clase_aula,&
this.uo_periodos}
end on

on w_empalme_horarios.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_empalmes)
destroy(this.cb_seleccionar)
destroy(this.dw_clase_aula)
destroy(this.uo_periodos)
end on

event open;/******************************************************************************

Módulo de Reporte de Empalme de Horarios-Salones.

Análisis, Diseño y Programación

César Ponce Hdz.

Ibero - Tijuana, Ene-Feb/2017



******************************************************************************/

w_empalme_horarios.title="Empalme de Horarios Ibero-Tijuana                                          Marzo/2017"

tipo_conexion=gtr_sce

uo_periodos.inicializa_periodos(gtr_sce) // CPH Marzo/2017

w_principal.toolbarvisible=false


dw_clase_aula.settransobject(tipo_conexion)
cont_clase_aula=dw_clase_aula.retrieve()



int inicializa

for inicializa=1 to 10
	clase_aula[inicializa]=-1
next



//dw_empalmes.dataobject="dw_empalme_todos"
dw_empalmes.settransobject(tipo_conexion)	
//dw_empalmes.retrieve()

// ahora se carga por boton
//carga_empalmes() 



end event

event resize;dw_empalmes.height=this.height - 850

dw_empalmes.width=this.width - 200
end event

event close;w_principal.toolbarvisible=true
end event

type cb_2 from commandbutton within w_empalme_horarios
integer x = 2002
integer y = 548
integer width = 544
integer height = 76
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Seleccionar Todos"
end type

event clicked;int cont_reng 


for cont_reng=1 to dw_clase_aula.rowcount()
	dw_clase_aula.object.seleccionada[cont_reng]=1
next

end event

type cb_1 from commandbutton within w_empalme_horarios
integer x = 658
integer y = 492
integer width = 626
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carga Reporte"
end type

event clicked;uo_periodos.obtener_periodos(anio_sem_a_buscar,periodo_sem_a_buscar,anio_trim_a_buscar,periodo_trim_a_buscar,periodo_sem_selecc,periodo_trim_selecc)

//messagebox("","anio "+string(anio_sem_a_buscar)+"periodo "+string(periodo_sem_a_buscar)+"selecc "+string(periodo_sem_selecc))

carga_empalmes()
end event

type st_2 from statictext within w_empalme_horarios
integer x = 3438
integer y = 84
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
string text = "Versión 22/marzo/2017 3.39 a.m. Tij"
boolean focusrectangle = false
end type

type st_1 from statictext within w_empalme_horarios
integer x = 617
integer y = 20
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

type dw_empalmes from datawindow within w_empalme_horarios
integer x = 78
integer y = 640
integer width = 4142
integer height = 1212
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Reporte de Empalme de Horarios"
string dataobject = "dw_empalme_todos_params_horiz"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_seleccionar from commandbutton within w_empalme_horarios
integer x = 2779
integer y = 544
integer width = 608
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Deseleccionar Todos"
end type

event clicked;int cont_reng 


for cont_reng=1 to dw_clase_aula.rowcount()
	dw_clase_aula.object.seleccionada[cont_reng]=0
next

end event

type dw_clase_aula from datawindow within w_empalme_horarios
integer x = 1993
integer y = 20
integer width = 1408
integer height = 512
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "dw_clase_aula_checkbox"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_periodos from uo_periodos_checkbox within w_empalme_horarios
integer x = 37
integer y = 92
integer taborder = 20
end type

on uo_periodos.destroy
call uo_periodos_checkbox::destroy
end on

