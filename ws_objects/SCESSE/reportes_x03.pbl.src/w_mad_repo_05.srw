$PBExportHeader$w_mad_repo_05.srw
$PBExportComments$Ventana para el Reporte de Kt - UIA
forward
global type w_mad_repo_05 from window
end type
type dw_pos from datawindow within w_mad_repo_05
end type
type dw_lic from datawindow within w_mad_repo_05
end type
type tab_1 from tab within w_mad_repo_05
end type
type tabpage_general from userobject within tab_1
end type
type lb_carreras_por_coordinacion from uo_lb_carreras_por_coordinacion within tabpage_general
end type
type ddlb_planes from uo_ddlb_datalist within tabpage_general
end type
type dw_2y from datawindow within tabpage_general
end type
type dw_2x from datawindow within tabpage_general
end type
type dw_2z from datawindow within tabpage_general
end type
type cb_5x from commandbutton within tabpage_general
end type
type rb_2x from radiobutton within tabpage_general
end type
type rb_1x from radiobutton within tabpage_general
end type
type cbx_2x from checkbox within tabpage_general
end type
type cb_1 from commandbutton within tabpage_general
end type
type st_1 from statictext within tabpage_general
end type
type cbx_todosplanes from checkbox within tabpage_general
end type
type rb_3 from radiobutton within tabpage_general
end type
type rb_2 from radiobutton within tabpage_general
end type
type rb_1 from radiobutton within tabpage_general
end type
type gb_10 from groupbox within tabpage_general
end type
type gb_2 from groupbox within tabpage_general
end type
type gb_6 from groupbox within tabpage_general
end type
type gb_4 from groupbox within tabpage_general
end type
type gb_1 from groupbox within tabpage_general
end type
type tabpage_general from userobject within tab_1
lb_carreras_por_coordinacion lb_carreras_por_coordinacion
ddlb_planes ddlb_planes
dw_2y dw_2y
dw_2x dw_2x
dw_2z dw_2z
cb_5x cb_5x
rb_2x rb_2x
rb_1x rb_1x
cbx_2x cbx_2x
cb_1 cb_1
st_1 st_1
cbx_todosplanes cbx_todosplanes
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
gb_10 gb_10
gb_2 gb_2
gb_6 gb_6
gb_4 gb_4
gb_1 gb_1
end type
type tabpage_individual from userobject within tab_1
end type
type dw_1y from datawindow within tabpage_individual
end type
type st_2 from statictext within tabpage_individual
end type
type dw_1x from datawindow within tabpage_individual
end type
type st_1x from statictext within tabpage_individual
end type
type cbx_20 from checkbox within tabpage_individual
end type
type cb_3 from commandbutton within tabpage_individual
end type
type cb_3x from commandbutton within tabpage_individual
end type
type em_1x from editmask within tabpage_individual
end type
type cb_1x from commandbutton within tabpage_individual
end type
type lb_1 from listbox within tabpage_individual
end type
type cb_2x from commandbutton within tabpage_individual
end type
type cb_4x from commandbutton within tabpage_individual
end type
type gb_14 from groupbox within tabpage_individual
end type
type gb_18 from groupbox within tabpage_individual
end type
type gb_13 from groupbox within tabpage_individual
end type
type gb_16 from groupbox within tabpage_individual
end type
type gb_17 from groupbox within tabpage_individual
end type
type gb_12 from groupbox within tabpage_individual
end type
type dw_1z from datawindow within tabpage_individual
end type
type rb_10 from radiobutton within tabpage_individual
end type
type rb_20 from radiobutton within tabpage_individual
end type
type gb_15 from groupbox within tabpage_individual
end type
type gb_11 from groupbox within tabpage_individual
end type
type lb_2 from listbox within tabpage_individual
end type
type tabpage_individual from userobject within tab_1
dw_1y dw_1y
st_2 st_2
dw_1x dw_1x
st_1x st_1x
cbx_20 cbx_20
cb_3 cb_3
cb_3x cb_3x
em_1x em_1x
cb_1x cb_1x
lb_1 lb_1
cb_2x cb_2x
cb_4x cb_4x
gb_14 gb_14
gb_18 gb_18
gb_13 gb_13
gb_16 gb_16
gb_17 gb_17
gb_12 gb_12
dw_1z dw_1z
rb_10 rb_10
rb_20 rb_20
gb_15 gb_15
gb_11 gb_11
lb_2 lb_2
end type
type tab_1 from tab within w_mad_repo_05
tabpage_general tabpage_general
tabpage_individual tabpage_individual
end type
end forward

global type w_mad_repo_05 from window
integer x = 9
integer y = 4
integer width = 3666
integer height = 2084
boolean titlebar = true
string title = "Reporte de Kt - UIA"
string menuname = "m_repo_mad3"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
dw_pos dw_pos
dw_lic dw_lic
tab_1 tab_1
end type
global w_mad_repo_05 w_mad_repo_05

type variables
//string nivel
int agrupa
int agrupa_2

STRING is_nivel
end variables

on w_mad_repo_05.create
if this.MenuName = "m_repo_mad3" then this.MenuID = create m_repo_mad3
this.dw_pos=create dw_pos
this.dw_lic=create dw_lic
this.tab_1=create tab_1
this.Control[]={this.dw_pos,&
this.dw_lic,&
this.tab_1}
end on

on w_mad_repo_05.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_pos)
destroy(this.dw_lic)
destroy(this.tab_1)
end on

event open;/*Cuando se abra la ventana w_certificados...*/

/*Haz que la fuente de datos de el DataWindow sea el gtr_sce*/
tab_1.tabpage_general.dw_2x.settransobject(gtr_sce)
tab_1.tabpage_general.dw_2z.settransobject(gtr_sce)
tab_1.tabpage_general.dw_2y.settransobject(gtr_sce)

tab_1.tabpage_individual.dw_1y.settransobject(gtr_sce)
tab_1.tabpage_individual.dw_1z.settransobject(gtr_sce)
tab_1.tabpage_individual.dw_1x.settransobject(gtr_sce)




/*Acomoda la ventana en el margen superior izquierdo*/
this.x=1
this.y=1
//nivel = 'T'
agrupa =1
agrupa_2 =1

///*Desabilita las opciones nuevo, actualiza y borra del menú*/
m_repo_mad3.m_registro.m_nuevo.disable( )
m_repo_mad3.m_registro.m_actualiza.disable( )
m_repo_mad3.m_registro.m_borraregistro.disable( )

tab_1.tabpage_general.ddlb_planes.inicializa("d_nombre_plan", gtr_sce)
tab_1.tabpage_general.ddlb_planes.SelectItem(7)
tab_1.tabpage_general.lb_carreras_por_coordinacion.inicializa(f_coordinacion_por_usuario(gs_usuario))




end event

type dw_pos from datawindow within w_mad_repo_05
integer x = 4320
integer y = 420
integer width = 686
integer height = 360
string dataobject = "dw_mad_carrera_pos"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
retrieve()
end event

type dw_lic from datawindow within w_mad_repo_05
integer x = 4320
integer y = 12
integer width = 686
integer height = 360
string dataobject = "dw_mad_carrera_lic"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
retrieve()
end event

type tab_1 from tab within w_mad_repo_05
event create ( )
event destroy ( )
integer width = 3611
integer height = 1876
integer taborder = 1
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean fixedwidth = true
boolean raggedright = true
boolean boldselectedtext = true
tabposition tabposition = tabsonleft!
alignment alignment = center!
integer selectedtab = 1
tabpage_general tabpage_general
tabpage_individual tabpage_individual
end type

on tab_1.create
this.tabpage_general=create tabpage_general
this.tabpage_individual=create tabpage_individual
this.Control[]={this.tabpage_general,&
this.tabpage_individual}
end on

on tab_1.destroy
destroy(this.tabpage_general)
destroy(this.tabpage_individual)
end on

event selectionchanged;/* Se asignan los datawindows dependiendo del TAB al menu, para poder imprimirlos */
if newindex = 1 then
	 m_repo_mad3.dw = tab_1.tabpage_general.dw_2x
    m_repo_mad3.dw2 = tab_1.tabpage_general.dw_2y
	 tab_1.tabpage_general.gb_1.taborder =0
	 tab_1.tabpage_general.gb_2.taborder =0
	 tab_1.tabpage_general.gb_4.taborder =0
	 tab_1.tabpage_general.gb_6.taborder =0
	 tab_1.tabpage_general.gb_10.taborder =0
	 
end if
if newindex = 2 then
	 m_repo_mad3.dw = tab_1.tabpage_individual.dw_1x
    m_repo_mad3.dw2 = tab_1.tabpage_individual.dw_1y
	 tab_1.tabpage_individual.gb_11.taborder=0
 	 tab_1.tabpage_individual.gb_12.taborder=0
  	 tab_1.tabpage_individual.gb_13.taborder=0
	 tab_1.tabpage_individual.gb_14.taborder=0
	 tab_1.tabpage_individual.gb_15.taborder=0
	 tab_1.tabpage_individual.gb_16.taborder=0
	 tab_1.tabpage_individual.gb_17.taborder=0
	 tab_1.tabpage_individual.gb_18.taborder=0
 	
end if
end event

type tabpage_general from userobject within tab_1
event create ( )
event destroy ( )
integer x = 128
integer y = 16
integer width = 3465
integer height = 1844
long backcolor = 16777215
string text = "General"
long tabtextcolor = 33554432
long tabbackcolor = 15780518
string picturename = "Custom045!"
long picturemaskcolor = 553648127
lb_carreras_por_coordinacion lb_carreras_por_coordinacion
ddlb_planes ddlb_planes
dw_2y dw_2y
dw_2x dw_2x
dw_2z dw_2z
cb_5x cb_5x
rb_2x rb_2x
rb_1x rb_1x
cbx_2x cbx_2x
cb_1 cb_1
st_1 st_1
cbx_todosplanes cbx_todosplanes
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
gb_10 gb_10
gb_2 gb_2
gb_6 gb_6
gb_4 gb_4
gb_1 gb_1
end type

on tabpage_general.create
this.lb_carreras_por_coordinacion=create lb_carreras_por_coordinacion
this.ddlb_planes=create ddlb_planes
this.dw_2y=create dw_2y
this.dw_2x=create dw_2x
this.dw_2z=create dw_2z
this.cb_5x=create cb_5x
this.rb_2x=create rb_2x
this.rb_1x=create rb_1x
this.cbx_2x=create cbx_2x
this.cb_1=create cb_1
this.st_1=create st_1
this.cbx_todosplanes=create cbx_todosplanes
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.gb_10=create gb_10
this.gb_2=create gb_2
this.gb_6=create gb_6
this.gb_4=create gb_4
this.gb_1=create gb_1
this.Control[]={this.lb_carreras_por_coordinacion,&
this.ddlb_planes,&
this.dw_2y,&
this.dw_2x,&
this.dw_2z,&
this.cb_5x,&
this.rb_2x,&
this.rb_1x,&
this.cbx_2x,&
this.cb_1,&
this.st_1,&
this.cbx_todosplanes,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.gb_10,&
this.gb_2,&
this.gb_6,&
this.gb_4,&
this.gb_1}
end on

on tabpage_general.destroy
destroy(this.lb_carreras_por_coordinacion)
destroy(this.ddlb_planes)
destroy(this.dw_2y)
destroy(this.dw_2x)
destroy(this.dw_2z)
destroy(this.cb_5x)
destroy(this.rb_2x)
destroy(this.rb_1x)
destroy(this.cbx_2x)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.cbx_todosplanes)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.gb_10)
destroy(this.gb_2)
destroy(this.gb_6)
destroy(this.gb_4)
destroy(this.gb_1)
end on

type lb_carreras_por_coordinacion from uo_lb_carreras_por_coordinacion within tabpage_general
integer x = 5
integer y = 372
integer taborder = 72
end type

on lb_carreras_por_coordinacion.destroy
call uo_lb_carreras_por_coordinacion::destroy
end on

type ddlb_planes from uo_ddlb_datalist within tabpage_general
boolean visible = false
integer x = 1390
integer y = 224
integer width = 635
integer height = 440
integer taborder = 13
integer textsize = -8
string item[] = {""}
end type

type dw_2y from datawindow within tabpage_general
integer x = 1806
integer y = 1888
integer width = 1637
integer height = 388
integer taborder = 16
string dataobject = "dw_repo_mad_05_gy"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;TabOrder = 0
end event

type dw_2x from datawindow within tabpage_general
integer x = 14
integer y = 1876
integer width = 1769
integer height = 392
integer taborder = 15
string dataobject = "dw_repo_mad_05_gx"
boolean livescroll = true
end type

event retrieveend;// Se coloca el Periodo en la impresión

int periodo,anio
string periodo_2


uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios
luo_periodo_servicios.f_carga_periodo_activo( periodo, anio,gs_tipo_periodo,gtr_sce)

luo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)
periodo_2 = luo_periodo_servicios.f_recupera_descripcion(periodo , "L")


this.object.st_periodo.text="Periodo Actual: "+periodo_2+" - "+string(anio)
dw_2x.object.st_periodo.text="Periodo Actual: "+periodo_2+" - "+string(anio)



/*
int periodo,anio
string periodo_2

periodo_actual(periodo,anio,gtr_sce)

CHOOSE CASE periodo
	CASE 0
		periodo_2="Primavera"
	CASE 1
		periodo_2="Verano"
	CASE 2
		periodo_2="Otoño"

END CHOOSE

this.object.st_periodo.text="Periodo Actual: "+periodo_2+" - "+string(anio)
dw_2y.object.st_periodo.text="Periodo Actual: "+periodo_2+" - "+string(anio)
*/
end event

event constructor;TabOrder = 0
end event

type dw_2z from datawindow within tabpage_general
integer y = 800
integer width = 3438
integer height = 1012
integer taborder = 14
string dataobject = "dw_repo_mad_05_gz"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event retrieveend;/*Cuando dw_1 termine de leer los datos de la tabla...*/

long contador
long total
long Cuenta_in
string Opcion

string Cont
setpointer(Hourglass!)
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

event constructor;TabOrder = 0
end event

type cb_5x from commandbutton within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 187
integer y = 88
integer width = 270
integer height = 96
integer taborder = 62
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ordenar"
end type

event clicked;/* Se verifica que opcion de Ordenamiento que se requiere por medio de los checks*/
setpointer(Hourglass!)
if (rb_1x.checked=TRUE) then
	// Ordenamiento por Alumno
   dw_2x.setsort("alumnos_nombre_completo A, academicos_cve_carrera A")
	dw_2x.sort()
	// Se recalcula el grupo
	dw_2x.GroupCalc ( )

   dw_2z.setsort("alumnos_nombre_completo A, academicos_cve_carrera A")
	dw_2z.sort()
	// Se recalcula el grupo
	dw_2z.GroupCalc ( )


   if (cbx_2x.checked=TRUE) then
      dw_2x.setsort("academicos_cve_carrera A, alumnos_nombre_completo A")
		dw_2x.sort()
		// Se recalcula el grupo
		dw_2x.GroupCalc ( )

      dw_2z.setsort("academicos_cve_carrera A, alumnos_nombre_completo A")
		dw_2z.sort()
		// Se recalcula el grupo
		dw_2z.GroupCalc ( )

	end if		
end if

if (rb_2x.checked=TRUE) then
	// Ordenamiento por Cuenta
   dw_2x.setsort("academicos_cuenta A")
	dw_2x.sort()
	// Se recalcula el grupo
	dw_2x.GroupCalc ( )

   dw_2z.setsort("academicos_cuenta A")
	dw_2z.sort()
	// Se recalcula el grupo
	dw_2z.GroupCalc ( )

	if (cbx_2x.checked=TRUE) then
      dw_2x.setsort("academicos_cve_carrera A, academicos_cuenta A")
		dw_2x.sort()
		// Se recalcula el grupo
		dw_2x.GroupCalc ( )

	   dw_2z.setsort("academicos_cve_carrera A, academicos_cuenta A")
		dw_2z.sort()
		// Se recalcula el grupo
		dw_2z.GroupCalc ( )

	end if	
	
end if

end event

event constructor;TabOrder = 0
end event

type rb_2x from radiobutton within tabpage_general
event clicked pbm_bnclicked
integer x = 2299
integer y = 188
integer width = 343
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Cuenta"
boolean lefttext = true
end type

event constructor;TabOrder = 0
end event

type rb_1x from radiobutton within tabpage_general
event constructor pbm_constructor
integer x = 2299
integer y = 120
integer width = 343
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Alfabético"
boolean checked = true
boolean lefttext = true
end type

event constructor;TabOrder = 0
end event

type cbx_2x from checkbox within tabpage_general
event clicked pbm_bnclicked
integer x = 2802
integer y = 188
integer width = 562
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Agrup. por Carrera "
boolean checked = true
end type

event clicked;
// Se cambia la opción de Agrupación 

if (this.checked = TRUE) then
    agrupa = 1    // CON Agrupación
else
	 agrupa = 2    // SIN Agrupación
end if
end event

event constructor;TabOrder = 3
end event

type cb_1 from commandbutton within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
event type string construye_sql ( integer alumno_x,  integer plan_x,  integer carreras_x )
event type string verifica_criterio ( )
event type string construye_sql_2 ( integer alumno_x,  integer plan_x,  integer carreras_x )
event type string verifica_criterio_2 ( )
integer x = 183
integer y = 212
integer width = 265
integer height = 108
integer taborder = 13
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar"
end type

event clicked;int Total, Plan_GO
int contador
string Textito
long Carreras[]
int Plan[]
string Nuevo_Select,Nuevo_Select_2
string Nuevo_SQL,Nuevo_SQL_2
string rc, ls_pbselect
int prom_on,cred_on,dir_on
int alumno_x,plan_x,nivel_carrera_x,all_carrera_x

setpointer(Hourglass!)



// Se Obtiene el Nuevo Where
Nuevo_SQL = this. EVENT verifica_criterio()
Nuevo_SQL_2 = this. EVENT verifica_criterio_2()
if Nuevo_SQL <> "" then
	// Se limpian los datawindows
	dw_2x.Reset() 
	dw_2z.Reset()
	dw_2y.Reset()   
	int li_seleccion, li_cve_carreras[], li_total_carreras, li_i
	//li_seleccion = lb_carreras_por_coordinacion.ObtenCarreras(li_cve_carreras, li_total_carreras)
	is_nivel = lb_carreras_por_coordinacion.ObtenCarreras(li_cve_carreras, li_total_carreras)
	for li_i = 1 to li_total_carreras
		carreras[li_i] = li_cve_carreras[li_i]
	next

	// Se Obtienen los planes de Estudio
	if cbx_todosplanes.checked = true then
	//	ddlb_planes.ObtenClaves(Plan)
	else
		Plan[1] = ddlb_planes.ObtenClave(ddlb_planes.text)
	end if
   // Se Fusiona el nuevo statement de SQL
   Nuevo_Select=" DataWindow.Table.Select=' SELECT academicos.cuenta,"+&
   	   	 " academicos.cve_carrera,"+&
             " alumnos.nombre,"+&
             " alumnos.apaterno,"+&
             " alumnos.amaterno,"+&
             " academicos.cve_plan,"+&
             " academicos.cve_subsistema,"+&
      	    " carreras.carrera,"+&
         	 " 0,"+&
				 " banderas_inscrito.cuenta,"+&
             " academicos.sem_cursados,"+&
				 " alumnos.nombre_completo "+&
             " FROM academicos,"+&   
         	 " alumnos,"+&
	          " carreras,"+&
				 " banderas_inscrito "
				 				 
				 
	 Nuevo_Select_2=" DataWindow.Table.Select=' SELECT"+&
                " academicos.cve_carrera," +&
                " carreras.carrera"+&
                " FROM academicos,"+&
                " carreras"

				

    Nuevo_Select = Nuevo_Select + " "+Nuevo_SQL + " ' "
	 Nuevo_Select_2 = Nuevo_Select_2 + " "+Nuevo_SQL_2 + " ' "

   
	// Se Modifica el SQL para X
	rc=dw_2x.Modify(Nuevo_Select)
	if rc="" then
		// Se realiza el retrieve  con el nuevo SQL para X
		dw_2x.retrieve(agrupa,Plan,Carreras)
		
	   // Se Modifica el SQL para Z
		rc=dw_2z.Modify(Nuevo_Select)
		if rc="" then
    		// Se realiza el retrieve  con el nuevo SQL para Z
			dw_2z.retrieve(agrupa,Plan,Carreras)
		else
			messagebox("Error en el SQL Z",rc)
		end if
		
	else
		messagebox("Error en el SQL X",rc)
	end if
	
	
	rc=dw_2y.Modify(Nuevo_Select_2)
	if rc="" then
    		// Se realiza el retrieve  con el nuevo SQL para Z
			dw_2y.retrieve(Plan,Carreras)
		else
			messagebox("Error en el SQL Y",rc)
		end if
	
// Se Ordenan deacuerdo a los criterios establecidos
   cb_5x.triggerevent("clicked") 

end if
end event

event constructor;TabOrder = 4
end event

event type string construye_sql(integer alumno_x, integer plan_x, integer carreras_x);// Se construye en nuevo SQL
string New_SQL_P

New_SQL_P=""


// Se Escoge que tipo de Alumno se desea
CHOOSE CASE alumno_x
	CASE 1
		//Solo Primer Ingreso
		New_SQL_P= New_SQL_P + " WHERE (academicos.sem_cursados = 0) AND ( academicos.cuenta = banderas_inscrito.cuenta ) AND "
	CASE 2
		//Inscritos Nada Mas
		New_SQL_P= New_SQL_P + " WHERE ( academicos.cuenta = banderas_inscrito.cuenta ) AND "
	CASE 3
		// (Todos)
		New_SQL_P= New_SQL_P + " WHERE ( academicos.cuenta *= banderas_inscrito.cuenta ) AND "
		                      
END CHOOSE


// Encabezado por DEFAULT
New_SQL_P=New_SQL_P+" ( academicos.cuenta = alumnos.cuenta ) and "+&  
          "( academicos.cve_carrera = carreras.cve_carrera ) "

// Se define todos los planes o algunos
IF plan_x <> 1 THEN
	// Se pasan los planes en un arreglo
		New_SQL_P= New_SQL_P + " AND ( academicos.cve_plan in ( :plan ) ) "
ELSE
	// Nada (Todos)
END IF

// Se verifica si es por nivel, carreras seleccionadas o todo
IF is_nivel = 'S' THEN 
	 // Se pasan las carreras en un arreglo
	New_SQL_P= New_SQL_P + " AND ( academicos.cve_carrera in ( :carrera ) )   "
ELSEIF is_nivel = 'A' THEN 
	// (Todos, no se agrega filtro)	
ELSE
	// Se agrega filtro del nivel seleccionado
	New_SQL_P= New_SQL_P + " AND ( carreras.nivel = ~"" + is_nivel + "~" ) " 
END IF 


//// Se define si son todas las carreras o algunas
//IF carreras_x = 1 THEN
//	// Todas las Carreras
//	CHOOSE CASE nivel_x
//		CASE 4
//			// De TSU EXCLUSIVAMENTE
//			New_SQL_P= New_SQL_P + " AND ( carreras.nivel = ~"T~" ) "			
//		CASE 1
//			// De Licenciatura EXCLUSIVAMENTE
//			New_SQL_P= New_SQL_P + " AND ( carreras.nivel = ~"L~" ) "
//		CASE 2
//			// De Posgrado EXCLUSIVAMENTE
//			New_SQL_P= New_SQL_P + " AND ( carreras.nivel = ~"P~" ) "
//		CASE 3
//			// Nada (Todos)
//	END CHOOSE
//
//ELSE
//	 // Se pasan las carreras en un arreglo
//  		New_SQL_P= New_SQL_P + " AND ( academicos.cve_carrera in ( :carrera ) )   "
//END IF


return New_SQL_P
end event

event type string verifica_criterio();// Se definen los parametros de Busqueda
string New_SQL
int alumno_x,plan_x,nivel_x,carreras_x

// Para Alumno
if rb_1.checked = TRUE then
   alumno_x = 1 // Solo Primer Ingreso
end if 

if rb_2.checked = TRUE then
   alumno_x = 2 // Solo los Inscritos
end if

if rb_3.checked = TRUE then
   alumno_x = 3 // Todos
end if

// Para Plan
if cbx_todosplanes.checked = TRUE then
	plan_x = 1 // Todos los Planes
end if

int li_seleccion, li_cve_carreras[], li_total_carreras, li_i

is_nivel = lb_carreras_por_coordinacion.ObtenCarreras(li_cve_carreras, li_total_carreras)
IF is_nivel = 'S' THEN 
	if li_total_carreras = 0 then return ""
ELSE
	carreras_x = 1
END IF 



//li_seleccion = lb_carreras_por_coordinacion.ObtenCarreras(li_cve_carreras, li_total_carreras)
//choose case li_seleccion
//	case 4 		
//		carreras_x = 1
//		nivel_x = 4		 
//	case 0
//		carreras_x = 1
//		nivel_x = 3
//	case 1
//		carreras_x = 1
//		nivel_x = 1
//	case 2
//		carreras_x = 1
//		nivel_x = 2
//	case 3
//		nivel_x = 0
//		if li_total_carreras = 0 then return ""
//end choose



// Se obtiene el nuevo Statement de WHERE
New_SQL = this. Event construye_sql(alumno_x,plan_x,carreras_x)
return New_SQL
end event

event type string construye_sql_2(integer alumno_x, integer plan_x, integer carreras_x);// Se construye en nuevo SQL
string New_SQL_P

New_SQL_P=""

if (alumno_x = 2 or alumno_x = 1 )then
    New_SQL_P =	 ", banderas_inscrito "
end if


// Se Escoge que tipo de Alumno se desea
CHOOSE CASE alumno_x
	CASE 1
		//Solo Primer Ingreso
		New_SQL_P= New_SQL_P + " WHERE (academicos.sem_cursados = 0) AND ( academicos.cuenta = banderas_inscrito.cuenta ) AND "
	CASE 2
		//Inscritos Nada Mas
		New_SQL_P= New_SQL_P + " WHERE ( academicos.cuenta = banderas_inscrito.cuenta ) AND "
	CASE 3
		// Nada (Todos)
		New_SQL_P=New_SQL_P+" WHERE "
END CHOOSE

// Encabezado por DEFAULT
New_SQL_P=New_SQL_P+" ( academicos.cve_carrera = carreras.cve_carrera ) "


// Se define todos los planes o algunos
IF plan_x <> 1 THEN
	// Se pasan los planes en un arreglo
		New_SQL_P= New_SQL_P + " AND ( academicos.cve_plan in ( :plan ) ) "
ELSE
	// Nada (Todos)
END IF


// Se verifica si es por nivel, carreras seleccionadas o todo
IF is_nivel = 'S' THEN 
	 // Se pasan las carreras en un arreglo
	New_SQL_P= New_SQL_P + " AND ( academicos.cve_carrera in ( :carrera ) )   "
ELSEIF is_nivel = 'A' THEN 
	// (Todos, no se agrega filtro)	
ELSE
	// Se agrega filtro del nivel seleccionado
	New_SQL_P= New_SQL_P + " AND ( carreras.nivel = ~"" + is_nivel + "~" ) " 
END IF 


//******************************************************************
// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 
//// Se define si son todas las carreras o algunas
//IF carreras_x = 1 THEN
//	// Todas las Carreras
//	CHOOSE CASE nivel_x
//		CASE 4
//			// De Licenciatura EXCLUSIVAMENTE
//			New_SQL_P= New_SQL_P + " AND ( carreras.nivel = ~"T~" ) "			
//		CASE 1
//			// De Licenciatura EXCLUSIVAMENTE
//			New_SQL_P= New_SQL_P + " AND ( carreras.nivel = ~"L~" ) "
//		CASE 2
//			// De Posgrado EXCLUSIVAMENTE
//			New_SQL_P= New_SQL_P + " AND ( carreras.nivel = ~"P~" ) "
//		CASE 3
//			// Nada (Todos)
//	END CHOOSE
//
//ELSE
//	 // Se pasan las carreras en un arreglo
//  		New_SQL_P= New_SQL_P + " AND ( academicos.cve_carrera in ( :carrera ) )   "
//END IF
//******************************************************************


return New_SQL_P
  

end event

event type string verifica_criterio_2();// Se definen los parametros de Busqueda
string New_SQL
int alumno_x,plan_x,nivel_x,carreras_x

// Para Alumno
if rb_1.checked = TRUE then
   alumno_x = 1 // Solo Primer Ingreso
end if 

if rb_2.checked = TRUE then
   alumno_x = 2 // Solo los Inscritos
end if

if rb_3.checked = TRUE then
   alumno_x = 3 // Todos
end if

// Para Plan
if cbx_todosplanes.checked = TRUE then
	plan_x = 1 // Todos los Planes
end if

int li_seleccion, li_cve_carreras[], li_total_carreras, li_i

is_nivel = lb_carreras_por_coordinacion.ObtenCarreras(li_cve_carreras, li_total_carreras) 
IF is_nivel = 'S' THEN 
	if li_total_carreras = 0 then return ""
ELSE
	carreras_x = 1
END IF 

//li_seleccion = lb_carreras_por_coordinacion.ObtenCarreras(li_cve_carreras, li_total_carreras)
//choose case li_seleccion
//	case 4
//		carreras_x = 1
//		nivel_x = 4		 
//	case 0
//		carreras_x = 1
//		nivel_x = 3
//	case 1
//		carreras_x = 1
//		nivel_x = 1
//	case 2
//		carreras_x = 1
//		nivel_x = 2
//	case 3
//		nivel_x = 0
//		if li_total_carreras = 0 then return ""
//end choose





// Se obtiene el nuevo Statement de WHERE
New_SQL = this. Event construye_sql_2(alumno_x,plan_x,carreras_x)
return New_SQL
end event

type st_1 from statictext within tabpage_general
event constructor pbm_constructor
integer x = 2738
integer y = 68
integer width = 672
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

type cbx_todosplanes from checkbox within tabpage_general
integer x = 1408
integer y = 128
integer width = 288
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "TODOS"
boolean checked = true
end type

event clicked;If (this.checked = TRUE) then
	ddlb_planes.enabled = false
	ddlb_planes.visible = false
else
	ddlb_planes.enabled = true
	ddlb_planes.visible = true
end if


end event

event constructor;TabOrder = 0
end event

type rb_3 from radiobutton within tabpage_general
integer x = 791
integer y = 256
integer width = 485
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Todos"
boolean checked = true
end type

event constructor;TabOrder = 0
end event

type rb_2 from radiobutton within tabpage_general
integer x = 791
integer y = 184
integer width = 485
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Inscritos"
end type

event constructor;TabOrder = 0
end event

type rb_1 from radiobutton within tabpage_general
integer x = 791
integer y = 112
integer width = 485
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "De 1er. Ingreso"
end type

event constructor;TabOrder = 0
end event

type gb_10 from groupbox within tabpage_general
integer x = 2775
integer y = 148
integer width = 617
integer height = 128
integer taborder = 4
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within tabpage_general
integer x = 2245
integer y = 60
integer width = 466
integer height = 220
integer taborder = 14
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Ordenamiento"
borderstyle borderstyle = styleraised!
end type

type gb_6 from groupbox within tabpage_general
integer x = 1353
integer y = 60
integer width = 709
integer height = 292
integer taborder = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Plan "
borderstyle borderstyle = styleraised!
end type

type gb_4 from groupbox within tabpage_general
integer x = 773
integer y = 60
integer width = 544
integer height = 292
integer taborder = 62
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Alumnos "
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within tabpage_general
integer width = 3438
integer height = 800
integer taborder = 13
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Criterios de Busqueda"
borderstyle borderstyle = styleraised!
end type

type tabpage_individual from userobject within tab_1
event create ( )
event destroy ( )
integer x = 128
integer y = 16
integer width = 3465
integer height = 1844
long backcolor = 16777215
string text = "Individual"
long tabtextcolor = 33554432
long tabbackcolor = 12639424
string picturename = "Move!"
long picturemaskcolor = 553648127
dw_1y dw_1y
st_2 st_2
dw_1x dw_1x
st_1x st_1x
cbx_20 cbx_20
cb_3 cb_3
cb_3x cb_3x
em_1x em_1x
cb_1x cb_1x
lb_1 lb_1
cb_2x cb_2x
cb_4x cb_4x
gb_14 gb_14
gb_18 gb_18
gb_13 gb_13
gb_16 gb_16
gb_17 gb_17
gb_12 gb_12
dw_1z dw_1z
rb_10 rb_10
rb_20 rb_20
gb_15 gb_15
gb_11 gb_11
lb_2 lb_2
end type

on tabpage_individual.create
this.dw_1y=create dw_1y
this.st_2=create st_2
this.dw_1x=create dw_1x
this.st_1x=create st_1x
this.cbx_20=create cbx_20
this.cb_3=create cb_3
this.cb_3x=create cb_3x
this.em_1x=create em_1x
this.cb_1x=create cb_1x
this.lb_1=create lb_1
this.cb_2x=create cb_2x
this.cb_4x=create cb_4x
this.gb_14=create gb_14
this.gb_18=create gb_18
this.gb_13=create gb_13
this.gb_16=create gb_16
this.gb_17=create gb_17
this.gb_12=create gb_12
this.dw_1z=create dw_1z
this.rb_10=create rb_10
this.rb_20=create rb_20
this.gb_15=create gb_15
this.gb_11=create gb_11
this.lb_2=create lb_2
this.Control[]={this.dw_1y,&
this.st_2,&
this.dw_1x,&
this.st_1x,&
this.cbx_20,&
this.cb_3,&
this.cb_3x,&
this.em_1x,&
this.cb_1x,&
this.lb_1,&
this.cb_2x,&
this.cb_4x,&
this.gb_14,&
this.gb_18,&
this.gb_13,&
this.gb_16,&
this.gb_17,&
this.gb_12,&
this.dw_1z,&
this.rb_10,&
this.rb_20,&
this.gb_15,&
this.gb_11,&
this.lb_2}
end on

on tabpage_individual.destroy
destroy(this.dw_1y)
destroy(this.st_2)
destroy(this.dw_1x)
destroy(this.st_1x)
destroy(this.cbx_20)
destroy(this.cb_3)
destroy(this.cb_3x)
destroy(this.em_1x)
destroy(this.cb_1x)
destroy(this.lb_1)
destroy(this.cb_2x)
destroy(this.cb_4x)
destroy(this.gb_14)
destroy(this.gb_18)
destroy(this.gb_13)
destroy(this.gb_16)
destroy(this.gb_17)
destroy(this.gb_12)
destroy(this.dw_1z)
destroy(this.rb_10)
destroy(this.rb_20)
destroy(this.gb_15)
destroy(this.gb_11)
destroy(this.lb_2)
end on

type dw_1y from datawindow within tabpage_individual
integer x = 32
integer y = 2200
integer width = 3424
integer height = 352
integer taborder = 15
string dataobject = "dw_repo_mad_05_ly"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;TabOrder = 0
end event

type st_2 from statictext within tabpage_individual
integer x = 1307
integer y = 92
integer width = 311
integer height = 68
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Agrupación"
boolean focusrectangle = false
end type

type dw_1x from datawindow within tabpage_individual
integer x = 41
integer y = 1860
integer width = 2432
integer height = 316
integer taborder = 14
string dataobject = "dw_repo_mad_05_lx"
boolean livescroll = true
end type

event constructor;TabOrder = 0
end event

event retrieveend;// Se coloca el Periodo en la impresión

int periodo,anio
string periodo_2


uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios
luo_periodo_servicios.f_carga_periodo_activo( periodo, anio,gs_tipo_periodo,gtr_sce)

luo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)
periodo_2 = luo_periodo_servicios.f_recupera_descripcion(periodo , "L")


this.object.st_periodo.text="Periodo Actual: "+periodo_2+" - "+string(anio)
dw_1y.object.st_periodo.text="Periodo Actual: "+periodo_2+" - "+string(anio)



/*
int periodo,anio
string periodo_2

periodo_actual(periodo,anio,gtr_sce)

CHOOSE CASE periodo
	CASE 0
		periodo_2="Primavera"
	CASE 1
		periodo_2="Verano"
	CASE 2
		periodo_2="Otoño"

END CHOOSE

this.object.st_periodo.text="Periodo Actual: "+periodo_2+" - "+string(anio)
dw_1y.object.st_periodo.text="Periodo Actual: "+periodo_2+" - "+string(anio)
*/
end event

type st_1x from statictext within tabpage_individual
event constructor pbm_constructor
integer x = 2825
integer y = 68
integer width = 558
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

type cbx_20 from checkbox within tabpage_individual
event clicked pbm_bnclicked
integer x = 1257
integer y = 156
integer width = 393
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "por Carrera "
boolean checked = true
boolean lefttext = true
end type

event clicked;// Se cambia la opción de Agrupación 

if (this.checked = TRUE) then
    agrupa_2 = 1    // CON Agrupación
else
	 agrupa_2 = 2    // SIN Agrupación
end if
end event

event constructor;TabOrder = 3
end event

type cb_3 from commandbutton within tabpage_individual
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 649
integer y = 324
integer width = 274
integer height = 124
integer taborder = 3
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ordenar"
end type

event clicked;setpointer(Hourglass!)
/* Se verifica que opcion de Ordenamiento que se requiere por medio de los checks*/

if (rb_10.checked=TRUE) then
	// Ordenamiento por Alumno
   dw_1x.setsort("alumnos_nombre_completo A, academicos_cve_carrera A")
	dw_1x.sort()
	// Se recalcula el grupo
	dw_1x.GroupCalc ( )

   dw_1z.setsort("alumnos_nombre_completo A, academicos_cve_carrera A")
	dw_1z.sort()
	// Se recalcula el grupo
	dw_1z.GroupCalc ( )


   if (cbx_20.checked=TRUE) then
      dw_1x.setsort("academicos_cve_carrera A, alumnos_nombre_completo A")
		dw_1x.sort()
		// Se recalcula el grupo
		dw_1x.GroupCalc ( )

      dw_1z.setsort("academicos_cve_carrera A, alumnos_nombre_completo A")
		dw_1z.sort()
		// Se recalcula el grupo
		dw_1z.GroupCalc ( )

	end if		
end if

if (rb_20.checked=TRUE) then
	// Ordenamiento por Cuenta
   dw_1x.setsort("academicos_cuenta A")
	dw_1x.sort()
	// Se recalcula el grupo
	dw_1x.GroupCalc ( )

   dw_1z.setsort("academicos_cuenta A")
	dw_1z.sort()
	// Se recalcula el grupo
	dw_1z.GroupCalc ( )

	if (cbx_20.checked=TRUE) then
      dw_1x.setsort("academicos_cve_carrera A, academicos_cuenta A")
		dw_1x.sort()
		// Se recalcula el grupo
		dw_1x.GroupCalc ( )

	   dw_1z.setsort("academicos_cve_carrera A, academicos_cuenta A")
		dw_1z.sort()
		// Se recalcula el grupo
		dw_1z.GroupCalc ( )

	end if	
	
end if

end event

event constructor;TabOrder = 0
end event

type cb_3x from commandbutton within tabpage_individual
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 2949
integer y = 256
integer width = 343
integer height = 120
integer taborder = 14
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar"
end type

event clicked;/* Se le pasa el arreglo al datawindow*/
int Total
int contador
string Textito
long Number[]
int prom_on,cred_on,dir_on

setpointer(Hourglass!)

// Se limpian los Datawindows
dw_1x.Reset() 
dw_1z.Reset() 
dw_1y.Reset() 


// Se obtienen los numeros de cuenta
Total=lb_2.totalitems()


if Total > 0 then
   contador=1
	FOR contador=1 TO Total
		Textito=lb_2.text(contador)
		Number[contador]=long(Textito)
   
	NEXT
	
	
	// Se traen los datos al datawindow, Agrupa_2 = 1 ---- CON Agrupación de Carrera
	//                                   Agrupa_2 = 2 ---- SIN Agrupación de Carrera
	dw_1x.retrieve(agrupa_2,Number)
	dw_1z.retrieve(agrupa_2,Number)
	dw_1y.retrieve(Number)
	
	// Se Ordenan los Datos de acuerdo a los criterios establecidos
   cb_3.triggerevent("clicked") 

end if


end event

event constructor;TabOrder = 4
end event

type em_1x from editmask within tabpage_individual
event constructor pbm_constructor
event modified pbm_enmodified
integer x = 105
integer y = 120
integer width = 475
integer height = 84
integer taborder = 2
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "###xxxxxx"
string displaydata = "Ä"
end type

event constructor;TabOrder = 1
end event

event modified;string Cuenta
string Digito_X
string Digito
/* Si se detecta un ENTER se verifica que haya escrito algo y se verifica el numero de cuenta 
en el evento clicked de cd_1x*/
if keydown(keyenter!) then	
	Cuenta=this.text
	if (Cuenta <> '') then
   	  cb_1x.triggerevent("clicked")
	end if	
end if

end event

type cb_1x from commandbutton within tabpage_individual
event clicked pbm_bnclicked
event constructor pbm_constructor
event type integer verifica ( )
event type integer verifica_2 ( string cuenta )
integer x = 718
integer y = 108
integer width = 279
integer height = 108
integer taborder = 2
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Agregar"
end type

event clicked;/* Se verifica que exista el alumno y que no este en la lista y que su digito verificador este
correcto */
string Cuenta
	Cuenta=em_1x.text
	if (Cuenta <> '') then
		if this. EVENT verifica() = 1 then
		else
			em_1x.SelectText(1, Len(em_1x.Text))
			em_1x.setfocus()
		end if	  
end if
end event

event constructor;TabOrder = 2
end event

event verifica;/* Se verifica que el alumno exista y que el digito verificador corresponda y que no se 
   encuentre en la lista*/

string Digito_X
string Digito
string Cuenta
long Cuenta_A
long Cuenta_B

Cuenta=em_1x.text
Digito_X=mid(Cuenta,len(Cuenta),len(Cuenta))
Cuenta=mid(Cuenta,1,len(Cuenta)-1)
Digito=obten_digito ( long (Cuenta) )
Cuenta_A=long(Cuenta)

SELECT alumnos.cuenta  
    INTO :Cuenta_B  
	 FROM alumnos  
	 WHERE alumnos.cuenta = :Cuenta_A using gtr_sce;
	 if gtr_sce.sqlcode = 100 then
			messagebox("Atención","El alumno con clave "+string(cuenta)+" no existe.")
		   /* Alumno no existe */
			return 0
	 else		
		
		if Digito=Digito_X then
	      if this. EVENT verifica_2(Cuenta) = 1 then
			   lb_1.additem (Cuenta+" - "+Digito_X)
            lb_2.additem (Cuenta)
			   em_1x.text=''
		      return 1 /* Todo esta bien */
	      else
   			/* Ya esta en la lista */
	   		return 0
		   end if	
	 
	   else
	      /* Digito Verificador Erroneo */
         messagebox("Atención","El digito verificador es ERRONEO, favor de revisarlo")
      	return 0
      end if

end if

end event

event verifica_2;/* Se verifica que no se encuentre en la lista */
int Total
int contador
string Textito
int Bandera

Bandera=0
Total=lb_2.totalitems()

if Total > 0 then
   contador=1
	FOR contador=1 TO Total
		Textito=lb_2.text(contador)
	   if Cuenta=Textito then
			Bandera=1  /*Si existe */
		end if	
	NEXT

end if

if Bandera = 1 then
	messagebox("Atención","El número de cuenta que desea introducir ~r~ "+&
	                      "        YA SE ENCUENTRA LA LISTA")
	return 0 /* Si existe */
else
	return 1 /* No existe, todo esta bien */
end if
end event

type lb_1 from listbox within tabpage_individual
event constructor pbm_constructor
event invierte_seleccion ( )
event selecciona_todo ( )
integer x = 1879
integer y = 120
integer width = 544
integer height = 372
integer taborder = 1
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean vscrollbar = true
boolean multiselect = true
borderstyle borderstyle = stylelowered!
end type

event constructor;TabOrder = 0
end event

event invierte_seleccion;integer 	li_totalitems
long		ll_item

//Only a valid operation when MuliSelect is set to True.
If this.MultiSelect Then
	li_totalitems = this.TotalItems()
	//Loop through all items - Inverting each item
	For ll_item = 1 to li_totalitems
		this.SetState(ll_item, (Not this.State(ll_item)=1) )
	Next
//	//Number of selected items
//	Return this.TotalSelected()
End If

//Not a valid operation
//Return 0
end event

event selecciona_todo;integer 	li_totalitems
long		ll_item

//Only a valid operation when MuliSelect is set to True.
If this.MultiSelect Then
	li_totalitems = this.TotalItems()
	//Loop through all items
	For ll_item = 1 to li_totalitems
		this.SetState(ll_item, True)
	Next
	//Number of selected items
//	Return li_totalitems
End If

//Not a valid operation
//Return 0
end event

event doubleclicked;// Al hacer el doubleclick se selecciona el renglon y se borra
integer li_Index
	li_Index = lb_1.SelectedIndex( )
	lb_1.DeleteItem(li_Index)
	lb_2.DeleteItem(li_Index)




end event

type cb_2x from commandbutton within tabpage_individual
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 2469
integer y = 148
integer width = 279
integer height = 108
integer taborder = 1
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Eliminar"
end type

event clicked;/* Cuando se selecciona un numero de cuenta de la lista se borra */
integer li_Index
setpointer(Hourglass!)
// Se Obtiene el primer indice del renglon seleccionado
li_Index = lb_1.SelectedIndex( )

// Se eliminan todos los renglones seleccionados 
DO UNTIL li_index=-1
	// Se elimina el renglon en los dos list_box
	lb_1.DeleteItem(li_Index)
	lb_2.DeleteItem(li_Index)
	// Se vuelve a obtener el siguiente renglon
	li_Index = lb_1.SelectedIndex( )
LOOP



end event

event constructor;TabOrder = 0
end event

type cb_4x from commandbutton within tabpage_individual
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 2469
integer y = 352
integer width = 279
integer height = 108
integer taborder = 62
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Limpiar"
end type

event clicked;/* Se limpia la lista de alumnos y el datawindow*/
int Total
setpointer(Hourglass!)
Total=lb_1.totalitems()
DO UNTIL Total=0
		lb_1.DeleteItem(1)
      lb_2.DeleteItem(1)
		Total=lb_1.totalitems()
LOOP
// Se limpian los Datawindows
dw_1x.Reset() 
dw_1z.Reset() 
dw_1y.Reset() 
st_1x.text='Total : 0'


end event

event constructor;TabOrder = 0
end event

type gb_14 from groupbox within tabpage_individual
integer x = 1221
integer y = 52
integer width = 466
integer height = 180
integer taborder = 15
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_18 from groupbox within tabpage_individual
integer x = 2875
integer y = 204
integer width = 485
integer height = 196
integer taborder = 3
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_13 from groupbox within tabpage_individual
integer x = 672
integer y = 56
integer width = 366
integer height = 180
integer taborder = 2
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_16 from groupbox within tabpage_individual
integer x = 608
integer y = 268
integer width = 352
integer height = 200
integer taborder = 3
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_17 from groupbox within tabpage_individual
integer x = 1851
integer y = 56
integer width = 933
integer height = 472
integer taborder = 2
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = " Lista  "
borderstyle borderstyle = styleraised!
end type

type gb_12 from groupbox within tabpage_individual
integer x = 59
integer y = 56
integer width = 581
integer height = 180
integer taborder = 2
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = " Núm. de Cuenta "
borderstyle borderstyle = styleraised!
end type

type dw_1z from datawindow within tabpage_individual
integer x = 5
integer y = 548
integer width = 3433
integer height = 1268
integer taborder = 63
string dataobject = "dw_repo_mad_05_lz"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;TabOrder = 0
end event

event retrieveend;/*Cuando dw_1 termine de leer los datos de la tabla...*/


int li_Index
int Total
int Total_Renglon
int Contador


string Cont
Cont = '0'
/*Verifica si se bajo más de un dato*/
if rowcount >= 1 then
	// Se actualiza el numero de datos traidos
	Cont =string(rowcount)
	st_1x.text='Total : '+Cont
   
	Total=lb_2.totalitems()
   Total_Renglon=rowcount()
	
   lb_1.EVENT selecciona_todo()
   lb_1.EVENT invierte_seleccion()
	
		 FOR Contador=1 to Total_Renglon		   
	     li_Index = lb_1.SelectItem(string(object.academicos_cuenta[Contador]), 1)
		  lb_1.SetState(li_Index, TRUE)		  
       NEXT
	/* Selecciona a los numero de cuenta que no se encontraron */	 
       lb_1.EVENT invierte_seleccion()
	
else
	st_1x.text='Total : '+Cont
	lb_1.EVENT selecciona_todo()
end if

end event

type rb_10 from radiobutton within tabpage_individual
event constructor pbm_constructor
integer x = 110
integer y = 336
integer width = 343
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Alfabético"
boolean checked = true
boolean lefttext = true
end type

event constructor;TabOrder = 0
end event

type rb_20 from radiobutton within tabpage_individual
event clicked pbm_bnclicked
integer x = 110
integer y = 400
integer width = 343
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Cuenta"
boolean lefttext = true
end type

event constructor;TabOrder = 0
end event

type gb_15 from groupbox within tabpage_individual
integer x = 41
integer y = 268
integer width = 503
integer height = 228
integer taborder = 2
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = " Ordenamiento"
borderstyle borderstyle = styleraised!
end type

type gb_11 from groupbox within tabpage_individual
integer width = 3438
integer height = 548
integer taborder = 3
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Criterios de Busqueda"
borderstyle borderstyle = styleraised!
end type

type lb_2 from listbox within tabpage_individual
event constructor pbm_constructor
integer x = 1161
integer y = 96
integer width = 142
integer height = 92
integer taborder = 12
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
boolean multiselect = true
borderstyle borderstyle = stylelowered!
end type

event constructor;TabOrder = 0
end event

