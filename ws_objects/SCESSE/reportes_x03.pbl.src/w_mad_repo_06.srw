$PBExportHeader$w_mad_repo_06.srw
$PBExportComments$Ventana para el Reporte de Kt - SEP
forward
global type w_mad_repo_06 from window
end type
type uo_periodo from uo_periodo_variable_tipos within w_mad_repo_06
end type
type uo_nivel from uo_nivel_rbutton within w_mad_repo_06
end type
type st_9 from statictext within w_mad_repo_06
end type
type st_7 from statictext within w_mad_repo_06
end type
type st_5 from statictext within w_mad_repo_06
end type
type st_4 from statictext within w_mad_repo_06
end type
type st_3 from statictext within w_mad_repo_06
end type
type cb_2 from commandbutton within w_mad_repo_06
end type
type dw_py from datawindow within w_mad_repo_06
end type
type dw_ry from datawindow within w_mad_repo_06
end type
type dw_px2 from datawindow within w_mad_repo_06
end type
type dw_rx2 from datawindow within w_mad_repo_06
end type
type dw_px from datawindow within w_mad_repo_06
end type
type dw_rx from datawindow within w_mad_repo_06
end type
type rb_5 from radiobutton within w_mad_repo_06
end type
type rb_4 from radiobutton within w_mad_repo_06
end type
type cb_1 from commandbutton within w_mad_repo_06
end type
type st_1x from statictext within w_mad_repo_06
end type
type dw_pz from datawindow within w_mad_repo_06
end type
type st_2 from statictext within w_mad_repo_06
end type
type st_1 from statictext within w_mad_repo_06
end type
type cb_3 from commandbutton within w_mad_repo_06
end type
type gb_8 from groupbox within w_mad_repo_06
end type
type gb_7 from groupbox within w_mad_repo_06
end type
type gb_6 from groupbox within w_mad_repo_06
end type
type gb_5 from groupbox within w_mad_repo_06
end type
type gb_4 from groupbox within w_mad_repo_06
end type
type gb_3 from groupbox within w_mad_repo_06
end type
type gb_1 from groupbox within w_mad_repo_06
end type
type dw_rz from datawindow within w_mad_repo_06
end type
type gb_2 from groupbox within w_mad_repo_06
end type
end forward

global type w_mad_repo_06 from window
integer x = 832
integer y = 360
integer width = 3643
integer height = 2340
boolean titlebar = true
string title = "Reporte de Kt - SEP"
string menuname = "m_repo_mad2"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12632256
uo_periodo uo_periodo
uo_nivel uo_nivel
st_9 st_9
st_7 st_7
st_5 st_5
st_4 st_4
st_3 st_3
cb_2 cb_2
dw_py dw_py
dw_ry dw_ry
dw_px2 dw_px2
dw_rx2 dw_rx2
dw_px dw_px
dw_rx dw_rx
rb_5 rb_5
rb_4 rb_4
cb_1 cb_1
st_1x st_1x
dw_pz dw_pz
st_2 st_2
st_1 st_1
cb_3 cb_3
gb_8 gb_8
gb_7 gb_7
gb_6 gb_6
gb_5 gb_5
gb_4 gb_4
gb_3 gb_3
gb_1 gb_1
dw_rz dw_rz
gb_2 gb_2
end type
global w_mad_repo_06 w_mad_repo_06

type variables

end variables

forward prototypes
public function integer wf_imprimir (integer ae_modo)
end prototypes

public function integer wf_imprimir (integer ae_modo);
// Se verifica el modo de impresión. 
IF ae_modo = 1 THEN 
	
	s_dwtit dw_t
	
	dw_t.dwp[1] = dw_rx  // Reingreso X Carreras
	dw_t.dwp[2] = dw_rx2 // Reingreso Alfabeticamente
	dw_t.dwp[3] = dw_ry // Datawindow del Resumen de los Reingresos
	dw_t.dwp[4] = dw_px // Primer Ingreso X Carreras
	dw_t.dwp[5] = dw_px2 // Primer ingreso  Alfabeticamente
	dw_t.dwp[6] = dw_py // Datawindow del Resumen de los de Primer Ingreso
	
	//	if isvalid(dw) then
	//	
	openwithparm(conf_impr_2ver,dw_t)
	//	
	//	end if
	
END IF


RETURN 0
end function

on w_mad_repo_06.create
if this.MenuName = "m_repo_mad2" then this.MenuID = create m_repo_mad2
this.uo_periodo=create uo_periodo
this.uo_nivel=create uo_nivel
this.st_9=create st_9
this.st_7=create st_7
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.cb_2=create cb_2
this.dw_py=create dw_py
this.dw_ry=create dw_ry
this.dw_px2=create dw_px2
this.dw_rx2=create dw_rx2
this.dw_px=create dw_px
this.dw_rx=create dw_rx
this.rb_5=create rb_5
this.rb_4=create rb_4
this.cb_1=create cb_1
this.st_1x=create st_1x
this.dw_pz=create dw_pz
this.st_2=create st_2
this.st_1=create st_1
this.cb_3=create cb_3
this.gb_8=create gb_8
this.gb_7=create gb_7
this.gb_6=create gb_6
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_1=create gb_1
this.dw_rz=create dw_rz
this.gb_2=create gb_2
this.Control[]={this.uo_periodo,&
this.uo_nivel,&
this.st_9,&
this.st_7,&
this.st_5,&
this.st_4,&
this.st_3,&
this.cb_2,&
this.dw_py,&
this.dw_ry,&
this.dw_px2,&
this.dw_rx2,&
this.dw_px,&
this.dw_rx,&
this.rb_5,&
this.rb_4,&
this.cb_1,&
this.st_1x,&
this.dw_pz,&
this.st_2,&
this.st_1,&
this.cb_3,&
this.gb_8,&
this.gb_7,&
this.gb_6,&
this.gb_5,&
this.gb_4,&
this.gb_3,&
this.gb_1,&
this.dw_rz,&
this.gb_2}
end on

on w_mad_repo_06.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_periodo)
destroy(this.uo_nivel)
destroy(this.st_9)
destroy(this.st_7)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.cb_2)
destroy(this.dw_py)
destroy(this.dw_ry)
destroy(this.dw_px2)
destroy(this.dw_rx2)
destroy(this.dw_px)
destroy(this.dw_rx)
destroy(this.rb_5)
destroy(this.rb_4)
destroy(this.cb_1)
destroy(this.st_1x)
destroy(this.dw_pz)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.gb_8)
destroy(this.gb_7)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.dw_rz)
destroy(this.gb_2)
end on

event open;/*Cuando se abra la ventana w_certificados...*/

/*Haz que la fuente de datos de el DataWindow sea el gtr_sce*/
//tab_1.tabpage_general.dw_2x.settransobject(gtr_sce)
//tab_1.tabpage_general.dw_2z.settransobject(gtr_sce)
//tab_1.tabpage_general.dw_2y.settransobject(gtr_sce)
//
dw_rx.settransobject(gtr_sce)
dw_rx2.settransobject(gtr_sce)
dw_ry.settransobject(gtr_sce)
dw_rz.settransobject(gtr_sce)
dw_px.settransobject(gtr_sce)
dw_px2.settransobject(gtr_sce)
dw_py.settransobject(gtr_sce)
dw_pz.settransobject(gtr_sce)





/*Acomoda la ventana en el margen superior izquierdo*/
this.x=1
this.y=1

gb_7.visible = FALSE

/*Desabilita las opciones nuevo, actualiza y borra del menú*/
m_repo_mad2.m_registro.m_nuevo.disable( )
m_repo_mad2.m_registro.m_actualiza.disable( )
m_repo_mad2.m_registro.m_borraregistro.disable( )


// Se inicializa el objeto de servicios de niveles.
uo_nivel.f_genera_nivel( "V", "U", "L", gtr_sce, "S", "N") 

THIS.uo_periodo.of_inicializa_servicio( "H", "L", "L", "N", gtr_sce )











end event

type uo_periodo from uo_periodo_variable_tipos within w_mad_repo_06
integer x = 1125
integer y = 424
integer width = 2331
integer height = 232
end type

on uo_periodo.destroy
call uo_periodo_variable_tipos::destroy
end on

type uo_nivel from uo_nivel_rbutton within w_mad_repo_06
integer x = 64
integer y = 128
integer width = 549
end type

on uo_nivel.destroy
call uo_nivel_rbutton::destroy
end on

type st_9 from statictext within w_mad_repo_06
integer x = 4242
integer y = 1248
integer width = 69
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Y"
boolean focusrectangle = false
end type

type st_7 from statictext within w_mad_repo_06
integer x = 4192
integer y = 824
integer width = 69
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "X2"
boolean focusrectangle = false
end type

type st_5 from statictext within w_mad_repo_06
integer x = 4215
integer y = 376
integer width = 69
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "X"
boolean focusrectangle = false
end type

type st_4 from statictext within w_mad_repo_06
integer x = 4338
integer y = 120
integer width = 430
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Primer Ingreso"
boolean focusrectangle = false
end type

type st_3 from statictext within w_mad_repo_06
integer x = 3735
integer y = 128
integer width = 279
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Reingreso"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_mad_repo_06
integer x = 1202
integer y = 124
integer width = 302
integer height = 80
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar..."
end type

event constructor;Visible = FALSE
end event

event clicked;setpointer(Hourglass!)

STRING ls_nivel
string Nivel_Array[]
INTEGER le_registros 
INTEGER le_pos

// Se verifican las opciones de busueda
st_2.Text = "Procesando la Información ................. Por Favor Espere !!! " 
//if rb_1.checked = TRUE then
//	Nivel_Array[1]="L"
//end if
//
//if rb_2.checked = TRUE then
//	Nivel_Array[1]="P"
//end if
//
//if rb_3.checked = TRUE then
//		Nivel_Array[1]="L"
//		Nivel_Array[2]="P"
//end if

ls_nivel = uo_nivel.cve_nivel 
IF ls_nivel = "A" THEN 
	le_registros = uo_nivel.iuo_nivel_servicios.ids_niveles.ROWCOUNT() 
	FOR le_pos = 1 TO le_registros 
		Nivel_Array[le_pos] = uo_nivel.iuo_nivel_servicios.ids_niveles.GETITEMSTRING(le_pos, "cve_nivel") 
	NEXT	
ELSE
	Nivel_Array[1] = ls_nivel
END IF


// Se continua con el proceso
dw_rx.retrieve(1,Nivel_Array)
//dw_rx2.retrieve(2,Nivel_Array)
dw_ry.retrieve(Nivel_Array)

dw_px.retrieve(1,Nivel_Array)
//dw_px2.retrieve(2,Nivel_Array)
dw_py.retrieve(Nivel_Array)

//	// Ordenamiento por Alumno para Reingreso
//   dw_rx2.setsort("alumnos_nombre_completo A, academicos_cve_carrera A")
//	dw_rx2.sort()
//	// Se recalcula el grupo
//	dw_rx2.GroupCalc ( )
//	
//	// Ordenamiento por Alumno para Primer Ingreso
//   dw_px2.setsort("alumnos_nombre_completo A, academicos_cve_carrera A")
//	dw_px2.sort()
//	// Se recalcula el grupo
//	dw_px2.GroupCalc ( )


st_2.Text = " Proceso Completado !!!!!. " 

// Se Oculta la segunda parte del Preproceso
	cb_2.visible = FALSE
	cb_3.visible = FALSE
	gb_7.visible = FALSE
	
// Se habilitan las Opciones para Reiniciar el Proceso
//	rb_1.enabled = TRUE
//	rb_2.enabled = TRUE
//	rb_3.enabled = TRUE
	rb_4.enabled = TRUE
	rb_5.enabled = TRUE
	cb_1.enabled = TRUE

end event

type dw_py from datawindow within w_mad_repo_06
integer x = 4343
integer y = 1128
integer width = 494
integer height = 360
string dataobject = "dw_repo_mad_06_pcay"
boolean livescroll = true
end type

event constructor;m_repo_mad2.dw6 = this
end event

type dw_ry from datawindow within w_mad_repo_06
integer x = 3694
integer y = 1128
integer width = 494
integer height = 360
string dataobject = "dw_repo_mad_06_rcay"
boolean livescroll = true
end type

event constructor;m_repo_mad2.dw3 = this
end event

event retrieveend;//int periodo,anio
//string periodo_2
//
//
//uo_periodo_servicios luo_periodo_servicios
//luo_periodo_servicios = CREATE uo_periodo_servicios
//luo_periodo_servicios.f_carga_periodo_activo( periodo, anio,gs_tipo_periodo,gtr_sce)
//
//luo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)
//periodo_2 = luo_periodo_servicios.f_recupera_descripcion(periodo , "L")
//
//
//this.object.st_periodo.text="Periodo Actual: "+periodo_2+" - "+string(anio)
//dw_ry.object.st_periodo.text="Periodo Actual: "+periodo_2+" - "+string(anio)
//

end event

type dw_px2 from datawindow within w_mad_repo_06
integer x = 4334
integer y = 700
integer width = 494
integer height = 360
string dataobject = "dw_repo_mad_06_pcax"
boolean livescroll = true
end type

event constructor;m_repo_mad2.dw5 = this
end event

event retrieveend;//int periodo,anio
//string periodo_2
//
//
//uo_periodo_servicios luo_periodo_servicios
//luo_periodo_servicios = CREATE uo_periodo_servicios
//luo_periodo_servicios.f_carga_periodo_activo( periodo, anio,gs_tipo_periodo,gtr_sce)
//
//luo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)
//periodo_2 = luo_periodo_servicios.f_recupera_descripcion(periodo , "L")
//
//
//this.object.st_periodo.text="Periodo Actual: "+periodo_2+" - "+string(anio)
//dw_rx2.object.st_periodo.text="Periodo Actual: "+periodo_2+" - "+string(anio)
//
//
end event

type dw_rx2 from datawindow within w_mad_repo_06
integer x = 3680
integer y = 708
integer width = 494
integer height = 360
string dataobject = "dw_repo_mad_06_rcax"
boolean livescroll = true
end type

event constructor;m_repo_mad2.dw2 = this
end event

type dw_px from datawindow within w_mad_repo_06
integer x = 4320
integer y = 244
integer width = 494
integer height = 360
string dataobject = "dw_repo_mad_06_pcax"
boolean livescroll = true
end type

event constructor;m_repo_mad2.dw4 = this
end event

event retrieveend;//int periodo,anio
//string periodo_2


//uo_periodo_servicios luo_periodo_servicios
//luo_periodo_servicios = CREATE uo_periodo_servicios
//luo_periodo_servicios.f_carga_periodo_activo( periodo, anio,gs_tipo_periodo,gtr_sce)
//
//luo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)
//periodo_2 = luo_periodo_servicios.f_recupera_descripcion(periodo , "L")
//
//
//this.object.st_periodo.text="Periodo Actual: "+periodo_2+" - "+string(anio)
//dw_px.object.st_periodo.text="Periodo Actual: "+periodo_2+" - "+string(anio)


end event

type dw_rx from datawindow within w_mad_repo_06
integer x = 3671
integer y = 236
integer width = 494
integer height = 360
string dataobject = "dw_repo_mad_06_rcax"
boolean livescroll = true
end type

event constructor;m_repo_mad2.dw = this
end event

event retrieveend;//int periodo,anio
//string periodo_2
//
//
//uo_periodo_servicios luo_periodo_servicios
//luo_periodo_servicios = CREATE uo_periodo_servicios
//luo_periodo_servicios.f_carga_periodo_activo( periodo, anio,gs_tipo_periodo,gtr_sce)
//
//luo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)
//periodo_2 = luo_periodo_servicios.f_recupera_descripcion(periodo , "L")
//
//
//this.object.st_periodo.text="Periodo Actual: "+periodo_2+" - "+string(anio)
//dw_py.object.st_periodo.text="Periodo Actual: "+periodo_2+" - "+string(anio)
//

end event

event retrieverow;//int periodo,anio
//string periodo_2
//
//
//uo_periodo_servicios luo_periodo_servicios
//luo_periodo_servicios = CREATE uo_periodo_servicios
//luo_periodo_servicios.f_carga_periodo_activo( periodo, anio,gs_tipo_periodo,gtr_sce)
//
//luo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)
//periodo_2 = luo_periodo_servicios.f_recupera_descripcion(periodo , "L")
//
//
//this.object.st_periodo.text="Periodo Actual: "+periodo_2+" - "+string(anio)
//dw_rx.object.st_periodo.text="Periodo Actual: "+periodo_2+" - "+string(anio)
//
//
end event

type rb_5 from radiobutton within w_mad_repo_06
integer x = 681
integer y = 200
integer width = 288
integer height = 52
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Total"
boolean checked = true
boolean lefttext = true
end type

type rb_4 from radiobutton within w_mad_repo_06
integer x = 681
integer y = 128
integer width = 288
integer height = 52
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Parcial"
boolean lefttext = true
end type

type cb_1 from commandbutton within w_mad_repo_06
integer x = 722
integer y = 328
integer width = 247
integer height = 96
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar"
end type

event clicked;// Se procede a cargar los datos
setpointer(Hourglass!)

int Proceso
string Nivel_Array[] 
STRING ls_nivel 
INTEGER le_registros, le_pos 


st_2.Text = "Procesando la Información ................. Por Favor Espere !!! " 

// Se inicializan las variables
st_1.text='Total : 0'
st_1x.text='Total : 0'

dw_rx.Reset() 
dw_rx2.Reset()
dw_ry.Reset() 
dw_rz.Reset()
dw_px.Reset() 
dw_px2.Reset()
dw_py.Reset() 
dw_pz.Reset()


// Se verifican los criterios de busqueda y tipo de Proceso

//if rb_1.checked = TRUE then
//	Nivel_Array[1]="L"  // Solo Licenciatura
//end if
//
//if rb_2.checked = TRUE then
//	Nivel_Array[1]="P" // Solo Posgrado
//end if
//
//if rb_3.checked = TRUE then
//		Nivel_Array[1]="L"
//		Nivel_Array[2]="P"  // Los Dos Niveles
//end if

ls_nivel = uo_nivel.cve_nivel 
IF ls_nivel = "A" THEN 
	le_registros = uo_nivel.iuo_nivel_servicios.ids_niveles.ROWCOUNT() 
	FOR le_pos = 1 TO le_registros 
		Nivel_Array[le_pos] = uo_nivel.iuo_nivel_servicios.ids_niveles.GETITEMSTRING(le_pos, "cve_nivel") 
	NEXT	
ELSE
	Nivel_Array[1] = ls_nivel
END IF





if rb_5.checked = TRUE then
	Proceso = 1 // Proceso Total
end if

//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**		
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	
INTEGER le_index
INTEGER le_periodo[] 
STRING ls_tipo_periodo[]
//STRING is_descripcion_periodo

PARENT.uo_periodo.of_recupera_periodos() 

//periodo_x[] = le_periodo[]
//is_descripcion_periodo = ""
FOR le_index = 1 TO UPPERBOUND(PARENT.uo_periodo.istr_periodos[])
//	IF TRIM(is_descripcion_periodo) <> "" THEN is_descripcion_periodo = is_descripcion_periodo + ", "
//	is_descripcion_periodo = is_descripcion_periodo + PARENT.uo_periodo.istr_periodos[le_index].descripcion 
	le_periodo[le_index] = PARENT.uo_periodo.istr_periodos[le_index].periodo
	ls_tipo_periodo[le_index] = PARENT.uo_periodo.istr_periodos[le_index].tipo
NEXT 	
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**		
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	





if (Proceso = 1) then
	// Si es proceso Total 
	dw_rx.retrieve(1,Nivel_Array,le_periodo)
	dw_rx.SORT()
	dw_rx.GROUPCALC()
	
	// Se descomenta 10/10/2016
	dw_rx2.retrieve(1,Nivel_Array,le_periodo)
	dw_rx2.SORT()
	dw_rx2.GROUPCALC()
	
	dw_ry.retrieve(Nivel_Array,le_periodo)
	dw_ry.SORT()
	dw_ry.GROUPCALC()

	dw_px.retrieve(1,Nivel_Array,le_periodo)
	dw_px.SORT() 
	dw_px.GROUPCALC() 
	
	// Se descomenta 10/10/2016
	dw_px2.retrieve(1,Nivel_Array,le_periodo)
	dw_px2.SORT()
	dw_px2.GROUPCALC()
	
	dw_py.retrieve(Nivel_Array,le_periodo)
	dw_py.SORT()
	dw_py.GROUPCALC()

	dw_rz.retrieve(Nivel_Array,le_periodo) 
	dw_rz.SORT() 
	dw_rz.GROUPCALC() 
	
	dw_pz.retrieve(Nivel_Array,le_periodo)
	dw_pz.SORT()
 	dw_pz.GROUPCALC() 
	
//	// Ordenamiento por Alumno de Reingreso
//   dw_rx2.setsort("alumnos_nombre_completo A, academicos_cve_carrera A")
//	dw_rx2.sort()
//	// Se recalcula el grupo
//	dw_rx2.GroupCalc ( )
//	
//	// Ordenamiento por Alumno de Primer Ingreso
//   dw_px2.setsort("alumnos_nombre_completo A, academicos_cve_carrera A")
//	dw_px2.sort()
//	// Se recalcula el grupo
//	dw_px2.GroupCalc ( )


	st_2.Text = " Proceso Completado !!!!!. " 
else
   // Proceso Parcial
	dw_rz.retrieve(Nivel_Array,le_periodo)
	dw_rz.SORT()
	dw_rz.GROUPCALC()
	
	dw_pz.retrieve(Nivel_Array,le_periodo)
	dw_pz.SORT()
	dw_pz.GROUPCALC()
	
	// Se activan las opciones para acompletar el preproceso
	st_2.Text = "Preproceso Completado!. Presione: - Continuar - o - Cancelar - " 	
   gb_7.visible = TRUE
	cb_2.visible = TRUE
	cb_3.visible = TRUE
	
	
	// Se desabilitan las Opciones para evitar errores en la continuacion del Preproceso
//	rb_1.enabled = FALSE
//	rb_2.enabled = FALSE
//	rb_3.enabled = FALSE
	rb_4.enabled = FALSE
	rb_5.enabled = FALSE
	
	cb_1.enabled = FALSE
					
end if

end event

type st_1x from statictext within w_mad_repo_06
event constructor pbm_constructor
integer x = 2638
integer y = 108
integer width = 759
integer height = 76
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
string text = "Total : 0"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event constructor;TabOrder = 0
end event

type dw_pz from datawindow within w_mad_repo_06
integer y = 1452
integer width = 3589
integer height = 684
string dataobject = "dw_repo_mad_06_pcaz"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event retrieveend;
string Cont
Cont = '0'
/*Verifica si se bajo más de un dato*/
if rowcount >= 1 then
	// Se actualiza el numero de datos traidos
	Cont =string(rowcount)
	st_1x.text='Total : '+Cont
else
	st_1x.text='Total : '+Cont
end if

end event

type st_2 from statictext within w_mad_repo_06
integer x = 1719
integer y = 292
integer width = 1719
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 65535
boolean enabled = false
string text = "Listo Para Empezar !!! ......"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_1 from statictext within w_mad_repo_06
event constructor pbm_constructor
integer x = 1760
integer y = 108
integer width = 759
integer height = 76
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
string text = "Total : 0"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event constructor;TabOrder = 0
end event

type cb_3 from commandbutton within w_mad_repo_06
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 1225
integer y = 256
integer width = 247
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;// Si se aborta el proceso

setpointer(Hourglass!)

// Se Oculta la segunda parte del Preproceso
	cb_2.visible = FALSE
	cb_3.visible = FALSE
	gb_7.visible = FALSE
	
// Se habilitan las Opciones para iniciar el proceso
//	rb_1.enabled = TRUE
//	rb_2.enabled = TRUE
//	rb_3.enabled = TRUE
	rb_4.enabled = TRUE
	rb_5.enabled = TRUE
	
	cb_1.enabled = TRUE

// Se limpian los datawindows y algunas variables
dw_rx.Reset() 
dw_rx2.Reset()
dw_ry.Reset() 
dw_rz.Reset()
dw_px.Reset() 
dw_px2.Reset()
dw_py.Reset() 
dw_pz.Reset()

st_2.text= "Listo Para Empezar !!! ......"
st_1.text='Total : 0'
st_1x.text='Total : 0'


end event

event constructor;Visible = FALSE

end event

type gb_8 from groupbox within w_mad_repo_06
integer x = 663
integer y = 280
integer width = 370
integer height = 160
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_7 from groupbox within w_mad_repo_06
integer x = 1152
integer y = 64
integer width = 393
integer height = 312
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_6 from groupbox within w_mad_repo_06
integer x = 663
integer y = 64
integer width = 370
integer height = 216
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "T. Proceso"
borderstyle borderstyle = styleraised!
end type

type gb_5 from groupbox within w_mad_repo_06
integer x = 2592
integer y = 48
integer width = 864
integer height = 160
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Total de Alumnos 1er. Ingreso"
end type

type gb_4 from groupbox within w_mad_repo_06
integer x = 1701
integer y = 48
integer width = 864
integer height = 160
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Total de Alumnos Reingreso"
end type

type gb_3 from groupbox within w_mad_repo_06
integer x = 1701
integer y = 232
integer width = 1755
integer height = 164
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Status"
end type

type gb_1 from groupbox within w_mad_repo_06
integer x = 41
integer y = 56
integer width = 590
integer height = 460
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Nivel de Estudios"
borderstyle borderstyle = styleraised!
end type

type dw_rz from datawindow within w_mad_repo_06
integer y = 768
integer width = 3589
integer height = 684
string dataobject = "dw_repo_mad_06_rcaz"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event retrieveend;

string Cont
Cont = '0'
/*Verifica si se bajo más de un dato*/
if rowcount >= 1 then
	// Se actualiza el numero de datos traidos
	Cont =string(rowcount)
	st_1.text='Total : '+Cont
else
	st_1.text='Total : '+Cont
end if

end event

type gb_2 from groupbox within w_mad_repo_06
integer width = 3589
integer height = 748
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Criterios de Busqueda"
borderstyle borderstyle = styleraised!
end type

