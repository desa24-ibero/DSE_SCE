$PBExportHeader$w_directorio_bloqueos.srw
$PBExportComments$Ventana para el Reporte de Directorio de Alumnos
forward
global type w_directorio_bloqueos from window
end type
type uo_carrera from uo_carreras within w_directorio_bloqueos
end type
type tab_1 from tab within w_directorio_bloqueos
end type
type tabpage_general from userobject within tab_1
end type
type uo_nivel from uo_nivel_rbutton within tabpage_general
end type
type cbx_i from checkbox within tabpage_general
end type
type cbx_b from checkbox within tabpage_general
end type
type cbx_l from checkbox within tabpage_general
end type
type cbx_dis from checkbox within tabpage_general
end type
type cbx_doc from checkbox within tabpage_general
end type
type cbx_3i from checkbox within tabpage_general
end type
type cbx_2r from checkbox within tabpage_general
end type
type cbx_p from checkbox within tabpage_general
end type
type cbx_4i from checkbox within tabpage_general
end type
type cbx_3r from checkbox within tabpage_general
end type
type st_2 from statictext within tabpage_general
end type
type ddlb_planes from uo_ddlb_datalist within tabpage_general
end type
type dw_directorio_bloqueos from datawindow within tabpage_general
end type
type cb_5x from commandbutton within tabpage_general
end type
type rb_2x from radiobutton within tabpage_general
end type
type rb_1x from radiobutton within tabpage_general
end type
type cbx_agrupa from checkbox within tabpage_general
end type
type cb_1 from commandbutton within tabpage_general
end type
type st_1 from statictext within tabpage_general
end type
type rb_todos from radiobutton within tabpage_general
end type
type rb_1ing from radiobutton within tabpage_general
end type
type gb_10 from groupbox within tabpage_general
end type
type gb_2 from groupbox within tabpage_general
end type
type gb_4 from groupbox within tabpage_general
end type
type gb_6 from groupbox within tabpage_general
end type
type gb_9 from groupbox within tabpage_general
end type
type gb_1 from groupbox within tabpage_general
end type
type tabpage_general from userobject within tab_1
uo_nivel uo_nivel
cbx_i cbx_i
cbx_b cbx_b
cbx_l cbx_l
cbx_dis cbx_dis
cbx_doc cbx_doc
cbx_3i cbx_3i
cbx_2r cbx_2r
cbx_p cbx_p
cbx_4i cbx_4i
cbx_3r cbx_3r
st_2 st_2
ddlb_planes ddlb_planes
dw_directorio_bloqueos dw_directorio_bloqueos
cb_5x cb_5x
rb_2x rb_2x
rb_1x rb_1x
cbx_agrupa cbx_agrupa
cb_1 cb_1
st_1 st_1
rb_todos rb_todos
rb_1ing rb_1ing
gb_10 gb_10
gb_2 gb_2
gb_4 gb_4
gb_6 gb_6
gb_9 gb_9
gb_1 gb_1
end type
type tab_1 from tab within w_directorio_bloqueos
tabpage_general tabpage_general
end type
type gb_carreras from groupbox within w_directorio_bloqueos
end type
type gb_3 from groupbox within w_directorio_bloqueos
end type
type gb_5 from groupbox within w_directorio_bloqueos
end type
type gb_7 from groupbox within w_directorio_bloqueos
end type
end forward

global type w_directorio_bloqueos from window
integer x = 9
integer y = 4
integer width = 3954
integer height = 2072
boolean titlebar = true
string title = "Reporte de Directorio de Alumnos Inscritos  y Bloqueos"
string menuname = "m_repo_alumnos_bloqueos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
uo_carrera uo_carrera
tab_1 tab_1
gb_carreras gb_carreras
gb_3 gb_3
gb_5 gb_5
gb_7 gb_7
end type
global w_directorio_bloqueos w_directorio_bloqueos

type variables
string nivel
int agrupa
int agrupa_2
boolean ib_usuario_especial=false
int ii_dw_width = 0, ii_dw_height = 0, ii_num_resize = 0

end variables

on w_directorio_bloqueos.create
if this.MenuName = "m_repo_alumnos_bloqueos" then this.MenuID = create m_repo_alumnos_bloqueos
this.uo_carrera=create uo_carrera
this.tab_1=create tab_1
this.gb_carreras=create gb_carreras
this.gb_3=create gb_3
this.gb_5=create gb_5
this.gb_7=create gb_7
this.Control[]={this.uo_carrera,&
this.tab_1,&
this.gb_carreras,&
this.gb_3,&
this.gb_5,&
this.gb_7}
end on

on w_directorio_bloqueos.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_carrera)
destroy(this.tab_1)
destroy(this.gb_carreras)
destroy(this.gb_3)
destroy(this.gb_5)
destroy(this.gb_7)
end on

event open;/*Cuando se abra la ventana w_certificados...*/

/*Haz que la fuente de datos de el DataWindow sea el gtr_sce*/
tab_1.tabpage_general.dw_directorio_bloqueos.settransobject(gtr_sce)


//tab_1.tabpage_general.dw_2y.settransobject(gtr_sce)

ii_dw_height = tab_1.tabpage_general.dw_directorio_bloqueos.height
ii_dw_width = tab_1.tabpage_general.dw_directorio_bloqueos.width

ib_usuario_especial = f_usuario_especial(gs_usuario)


/*Acomoda la ventana en el margen superior izquierdo*/
this.x=1
this.y=1
nivel = 'T'
agrupa =1
agrupa_2 =1

///*Desabilita las opciones nuevo, actualiza y borra del menú*/
m_repo_alumnos_bloqueos.m_registro.m_nuevo.disable( )
m_repo_alumnos_bloqueos.m_registro.m_actualiza.disable( )
m_repo_alumnos_bloqueos.m_registro.m_borraregistro.disable( )

tab_1.TabPage_General.ddlb_planes.inicializa("d_nombre_plan", gtr_sce)
tab_1.TabPage_General.ddlb_planes.SelectItem(7)
//tab_1.TabPage_General.lb_carreras_por_coordinacion.inicializa(f_coordinacion_por_usuario(gs_usuario))

// Se inicializa el objeto de servicios de niveles.
tab_1.tabpage_general.uo_nivel.f_genera_nivel( "V", "L", "L", gtr_sce, "S", "N") 










end event

event resize;long ll_height_win, ll_height_dw, ll_dif_height_tab, ll_height_tab, ll_width_tab, ll_height_tab_final
long ll_height_dw_ind

if ii_num_resize > 0 then
	ll_height_dw = tab_1.tabpage_general.dw_directorio_bloqueos.height
	ll_height_dw_ind = tab_1.tabpage_general.dw_directorio_bloqueos.height
	ll_height_win = this.height

	ll_height_tab = tab_1.height
	ll_width_tab = tab_1.width

	tab_1.width = newwidth -50
	tab_1.height = newheight -50
	
	ll_height_tab_final =tab_1.height
	
	ll_dif_height_tab = ll_height_tab_final - ll_height_tab  

	tab_1.tabpage_general.gb_1.width = newwidth -200


	tab_1.tabpage_general.dw_directorio_bloqueos.width = newwidth -200
	tab_1.tabpage_general.dw_directorio_bloqueos.height = ll_height_dw + ll_dif_height_tab
	
//	ii_dw_height = tab_1.tabpage_general.dw_2x.height
else
	ii_num_resize = ii_num_resize +1
end if
end event

type uo_carrera from uo_carreras within w_directorio_bloqueos
event destroy ( )
integer x = 1906
integer y = 520
integer taborder = 40
boolean border = false
long backcolor = 12632256
end type

on uo_carrera.destroy
call uo_carreras::destroy
end on

type tab_1 from tab within w_directorio_bloqueos
event create ( )
event destroy ( )
integer width = 3835
integer height = 1892
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
end type

on tab_1.create
this.tabpage_general=create tabpage_general
this.Control[]={this.tabpage_general}
end on

on tab_1.destroy
destroy(this.tabpage_general)
end on

event selectionchanged;/* Se asignan los datawindows dependiendo del TAB al menu, para poder imprimirlos */
if newindex = 1 then
	 m_repo_alumnos_bloqueos.dw = tab_1.tabpage_general.dw_directorio_bloqueos
    m_repo_alumnos_bloqueos.dw2 = tab_1.tabpage_general.dw_directorio_bloqueos
	 
	 
	 tab_1.tabpage_general.gb_1.taborder =0
	 tab_1.tabpage_general.gb_2.taborder =0
	 tab_1.tabpage_general.gb_4.taborder =0
//	 tab_1.tabpage_general.gb_6.taborder =0
	 tab_1.tabpage_general.gb_10.taborder =0
//	 tab_1.tabpage_general.gb_20.taborder =0
end if

end event

type tabpage_general from userobject within tab_1
event create ( )
event destroy ( )
integer x = 128
integer y = 16
integer width = 3689
integer height = 1860
long backcolor = 16777215
string text = "General"
long tabtextcolor = 33554432
long tabbackcolor = 15780518
string picturename = "Custom045!"
long picturemaskcolor = 553648127
uo_nivel uo_nivel
cbx_i cbx_i
cbx_b cbx_b
cbx_l cbx_l
cbx_dis cbx_dis
cbx_doc cbx_doc
cbx_3i cbx_3i
cbx_2r cbx_2r
cbx_p cbx_p
cbx_4i cbx_4i
cbx_3r cbx_3r
st_2 st_2
ddlb_planes ddlb_planes
dw_directorio_bloqueos dw_directorio_bloqueos
cb_5x cb_5x
rb_2x rb_2x
rb_1x rb_1x
cbx_agrupa cbx_agrupa
cb_1 cb_1
st_1 st_1
rb_todos rb_todos
rb_1ing rb_1ing
gb_10 gb_10
gb_2 gb_2
gb_4 gb_4
gb_6 gb_6
gb_9 gb_9
gb_1 gb_1
end type

on tabpage_general.create
this.uo_nivel=create uo_nivel
this.cbx_i=create cbx_i
this.cbx_b=create cbx_b
this.cbx_l=create cbx_l
this.cbx_dis=create cbx_dis
this.cbx_doc=create cbx_doc
this.cbx_3i=create cbx_3i
this.cbx_2r=create cbx_2r
this.cbx_p=create cbx_p
this.cbx_4i=create cbx_4i
this.cbx_3r=create cbx_3r
this.st_2=create st_2
this.ddlb_planes=create ddlb_planes
this.dw_directorio_bloqueos=create dw_directorio_bloqueos
this.cb_5x=create cb_5x
this.rb_2x=create rb_2x
this.rb_1x=create rb_1x
this.cbx_agrupa=create cbx_agrupa
this.cb_1=create cb_1
this.st_1=create st_1
this.rb_todos=create rb_todos
this.rb_1ing=create rb_1ing
this.gb_10=create gb_10
this.gb_2=create gb_2
this.gb_4=create gb_4
this.gb_6=create gb_6
this.gb_9=create gb_9
this.gb_1=create gb_1
this.Control[]={this.uo_nivel,&
this.cbx_i,&
this.cbx_b,&
this.cbx_l,&
this.cbx_dis,&
this.cbx_doc,&
this.cbx_3i,&
this.cbx_2r,&
this.cbx_p,&
this.cbx_4i,&
this.cbx_3r,&
this.st_2,&
this.ddlb_planes,&
this.dw_directorio_bloqueos,&
this.cb_5x,&
this.rb_2x,&
this.rb_1x,&
this.cbx_agrupa,&
this.cb_1,&
this.st_1,&
this.rb_todos,&
this.rb_1ing,&
this.gb_10,&
this.gb_2,&
this.gb_4,&
this.gb_6,&
this.gb_9,&
this.gb_1}
end on

on tabpage_general.destroy
destroy(this.uo_nivel)
destroy(this.cbx_i)
destroy(this.cbx_b)
destroy(this.cbx_l)
destroy(this.cbx_dis)
destroy(this.cbx_doc)
destroy(this.cbx_3i)
destroy(this.cbx_2r)
destroy(this.cbx_p)
destroy(this.cbx_4i)
destroy(this.cbx_3r)
destroy(this.st_2)
destroy(this.ddlb_planes)
destroy(this.dw_directorio_bloqueos)
destroy(this.cb_5x)
destroy(this.rb_2x)
destroy(this.rb_1x)
destroy(this.cbx_agrupa)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.rb_todos)
destroy(this.rb_1ing)
destroy(this.gb_10)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.gb_6)
destroy(this.gb_9)
destroy(this.gb_1)
end on

type uo_nivel from uo_nivel_rbutton within tabpage_general
integer x = 1143
integer y = 128
integer width = 517
integer height = 208
integer taborder = 72
end type

on uo_nivel.destroy
call uo_nivel_rbutton::destroy
end on

type cbx_i from checkbox within tabpage_general
integer x = 2537
integer y = 396
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Inglés"
end type

type cbx_b from checkbox within tabpage_general
integer x = 2537
integer y = 320
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Biblioteca"
end type

type cbx_l from checkbox within tabpage_general
integer x = 2537
integer y = 248
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Laboratorio"
end type

type cbx_dis from checkbox within tabpage_general
integer x = 2537
integer y = 180
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Disciplina"
end type

type cbx_doc from checkbox within tabpage_general
integer x = 2537
integer y = 112
integer width = 416
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Documentos"
end type

type cbx_3i from checkbox within tabpage_general
integer x = 1824
integer y = 396
integer width = 681
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "3  o más Inscripciones"
end type

type cbx_2r from checkbox within tabpage_general
integer x = 1824
integer y = 328
integer width = 631
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "2 o más Reprobadas"
end type

type cbx_p from checkbox within tabpage_general
integer x = 1824
integer y = 260
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Promedio"
end type

type cbx_4i from checkbox within tabpage_general
integer x = 1824
integer y = 192
integer width = 480
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "4 Inscripciones"
end type

type cbx_3r from checkbox within tabpage_general
integer x = 1824
integer y = 124
integer width = 448
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "3 Reprobadas"
end type

type st_2 from statictext within tabpage_general
integer x = 1513
integer y = 544
integer width = 270
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Carrera   "
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_planes from uo_ddlb_datalist within tabpage_general
boolean visible = false
integer x = 1083
integer y = 196
integer width = 631
integer height = 488
integer taborder = 13
integer textsize = -8
boolean vscrollbar = true
string item[] = {""}
end type

type dw_directorio_bloqueos from datawindow within tabpage_general
integer y = 684
integer width = 3689
integer height = 1160
integer taborder = 14
string dataobject = "d_directorio_bloqueos"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event retrieveend;/*Cuando dw_1 termine de leer los datos de la tabla...*/


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

event constructor;TabOrder = 0
end event

type cb_5x from commandbutton within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 119
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
   dw_directorio_bloqueos.setsort("nombre_completo A, cve_carrera A")
	dw_directorio_bloqueos.sort()
	// Se recalcula el grupo
	dw_directorio_bloqueos.GroupCalc ( )
	


   if (cbx_AGRUPA.checked=TRUE) then
      dw_directorio_bloqueos.setsort("cve_carrera A, nombre_completo A")
		dw_directorio_bloqueos.sort()
		// Se recalcula el grupo
		dw_directorio_bloqueos.GroupCalc ( )
	end if		
end if

if (rb_2x.checked=TRUE) then
	// Ordenamiento por Cuenta
   dw_directorio_bloqueos.setsort("cuenta A")
	dw_directorio_bloqueos.sort()
	// Se recalcula el grupo
	dw_directorio_bloqueos.GroupCalc ( )


	if (cbx_AGRUPA.checked=TRUE) then
      dw_directorio_bloqueos.setsort("cve_carrera A, cuenta A")
		dw_directorio_bloqueos.sort()
		// Se recalcula el grupo
		dw_directorio_bloqueos.GroupCalc ( )


	end if	
	
end if

end event

event constructor;TabOrder = 0
end event

type rb_2x from radiobutton within tabpage_general
event clicked pbm_bnclicked
integer x = 91
integer y = 520
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
end type

event constructor;TabOrder = 0
end event

type rb_1x from radiobutton within tabpage_general
event constructor pbm_constructor
integer x = 91
integer y = 440
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
end type

event constructor;TabOrder = 0
end event

type cbx_agrupa from checkbox within tabpage_general
event clicked pbm_bnclicked
integer x = 3072
integer y = 408
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
event type string construye_sql ( integer alumno_x,  integer plan_x,  integer nivel_x,  integer carreras_x )
event type string verifica_criterio ( )
event type string construye_sql_2 ( integer alumno_x,  integer plan_x,  integer nivel_x,  integer carreras_x )
event type string verifica_criterio_2 ( )
event opc_mostrar ( ref integer prom_on,  ref integer cred_on,  ref integer dir_on )
integer x = 123
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

event clicked;/* Se le pasa el arreglo al datawindow*/

int Total, Plan_GO
int contador
string Textito
long Carreras[]
int Plan[]
string Nuevo_Select,Nuevo_Select_2
string Nuevo_SQL,Nuevo_SQL_2
string rc, ls_pbselect
int prom_on,cred_on,dir_on
int alumno_x,plan_x,nivel_carrera_x,all_carrera_x
long ll_row_carrera, ll_cve_carrera
integer ll_periodo, ll_anio
long ll_rows
string ls_nivel, ls_filter_bloqueos = '', ls_filter_vacio = '', ls_separador = '', ls_primer_ingreso = ''
boolean lb_primer_filtro = true

//if rb_L.checked then
//	ls_nivel = 'L'
//elseif rb_P.checked then
//	ls_nivel = 'P'
//elseif rb_A.checked then
//	ls_nivel = 'A'
//else
//	ls_nivel = 'A'
//end if

ls_nivel = tab_1.tabpage_general.uo_nivel.cve_nivel 

if cbx_3r.checked then
	if lb_primer_filtro then
		ls_separador = ''
		lb_primer_filtro = FALSE
	else
		ls_separador = ' OR '
		lb_primer_filtro = FALSE
	end if
	ls_filter_bloqueos = ls_filter_bloqueos + ls_separador +'banderas.baja_3_reprob = 1 '
end if

if cbx_4i.checked then
	if lb_primer_filtro then
		ls_separador = ''
		lb_primer_filtro = FALSE
	else
		ls_separador = ' OR '
		lb_primer_filtro = FALSE
	end if
	ls_filter_bloqueos = ls_filter_bloqueos + ls_separador +'banderas.baja_4_insc = 1 '
end if

if cbx_p.checked then
	if lb_primer_filtro then
		ls_separador = ''
		lb_primer_filtro = FALSE
	else
		ls_separador = ' OR '
		lb_primer_filtro = FALSE
	end if
	ls_filter_bloqueos = ls_filter_bloqueos + ls_separador +'banderas.cve_flag_promedio <> 0 '
end if

if cbx_2r.checked then
	if lb_primer_filtro then
		ls_separador = ''
		lb_primer_filtro = FALSE
	else
		ls_separador = ' OR '
		lb_primer_filtro = FALSE
	end if
	ls_filter_bloqueos = ls_filter_bloqueos + ls_separador +'con_2_o_mas_reprob > 2 '
end if

if cbx_3i.checked then
	if lb_primer_filtro then
		ls_separador = ''
		lb_primer_filtro = FALSE
	else
		ls_separador = ' OR '
		lb_primer_filtro = FALSE
	end if
	ls_filter_bloqueos = ls_filter_bloqueos + ls_separador +'con_3_o_mas_insc  > 3 '
end if

if cbx_doc.checked then
	if lb_primer_filtro then
		ls_separador = ''
		lb_primer_filtro = FALSE
	else
		ls_separador = ' OR '
		lb_primer_filtro = FALSE
	end if
	ls_filter_bloqueos = ls_filter_bloqueos + ls_separador +'baja_documentos = 1 '
end if

if cbx_dis.checked then
	if lb_primer_filtro then
		ls_separador = ''
		lb_primer_filtro = FALSE
	else
		ls_separador = ' OR '
		lb_primer_filtro = FALSE
	end if
	ls_filter_bloqueos = ls_filter_bloqueos + ls_separador +'baja_disciplina = 1 '
end if

if cbx_l.checked then
	if lb_primer_filtro then
		ls_separador = ''
		lb_primer_filtro = FALSE
	else
		ls_separador = ' OR '
		lb_primer_filtro = FALSE
	end if
	ls_filter_bloqueos = ls_filter_bloqueos + ls_separador +'baja_laboratorio = 1 '
end if

if cbx_b.checked then
	if lb_primer_filtro then
		ls_separador = ''
		lb_primer_filtro = FALSE
	else
		ls_separador = ' OR '
		lb_primer_filtro = FALSE
	end if
	ls_filter_bloqueos = ls_filter_bloqueos + ls_separador +'cve_flag_biblioteca <> 0 '
end if

if cbx_i.checked then
	if lb_primer_filtro then
		ls_separador = ''
		lb_primer_filtro = FALSE
	else
		ls_separador = ' OR '
		lb_primer_filtro = FALSE
	end if
	ls_filter_bloqueos = ls_filter_bloqueos + ls_separador +'cve_flag_prerreq_ingles <> 0 '
end if

periodo_actual_mat_insc(ll_periodo, ll_anio, gtr_sce)

ll_row_carrera = w_directorio_bloqueos.uo_carrera.dw_carreras.GetRow()
ll_cve_carrera = w_directorio_bloqueos.uo_carrera.dw_carreras.object.cve_carrera[ll_row_carrera]

setpointer(Hourglass!)
dw_directorio_bloqueos.SetFilter(ls_filter_bloqueos)

//if cbx_BLOQUEOS.checked then
//	dw_directorio_bloqueos.SetFilter(ls_filter_bloqueos)
//else
//	dw_directorio_bloqueos.SetFilter(ls_filter_vacio)
//end if


if rb_1ING.checked then
	ls_primer_ingreso= 'I'
else
	ls_primer_ingreso= 'T'
end if


//Se cambia el modo transaccional para que permita la creación de tablas temporales en los stored procedures
gtr_sce.autocommit = true
ll_rows = dw_directorio_bloqueos.Retrieve(ll_periodo, ll_anio, ll_cve_carrera, ls_nivel, ls_primer_ingreso)
gtr_sce.autocommit = false
dw_directorio_bloqueos.Filter()

dw_directorio_bloqueos.Object.DataWindow.Zoom = 80

setpointer(Arrow!)

//
//// Se Obtiene el Nuevo Where
//Nuevo_SQL = this. EVENT verifica_criterio()
//Nuevo_SQL_2 = this. EVENT verifica_criterio_2()
//if Nuevo_SQL <> "" then
//	// Se limpian los datawindows
//	dw_2x.Reset() 
//	dw_2y.Reset()   
//	int li_seleccion, li_cve_carreras[], li_total_carreras, li_i
//	li_seleccion = lb_carreras_por_coordinacion.ObtenCarreras(li_cve_carreras, li_total_carreras)
//	for li_i = 1 to li_total_carreras
//		carreras[li_i] = li_cve_carreras[li_i]
//	next
//
//	// Se Obtienen los planes de Estudio
//	if cbx_todosplanes.checked = true then
//	//	ddlb_planes.ObtenClaves(Plan)
//	else
//		Plan[1] = ddlb_planes.ObtenClave(ddlb_planes.text)
//	end if
//	
//	
//	Nuevo_Select=" DataWindow.Table.Select=' SELECT academicos.cuenta,"+&
//             " alumnos.apaterno,"+&
//             " alumnos.amaterno,"+&
//             " alumnos.nombre,"+&
//	          " domicilio.telefono,"+&   
//   	   	 " academicos.cve_carrera,"+&
//     		    " domicilio.calle,"+&
//	     	    " domicilio.colonia,"+&
//   	       " domicilio.cod_postal,"+&
//      	    " carreras.carrera,"+&
//         	 " 0,"+&
//				 " academicos.promedio,"+&
//			    " academicos.creditos_cursados,"+&
//				 " alumnos.nombre_completo, "+&
//				 " e_mail = alumnos.fotografia, "+& 
//				 " academicos.periodo_ing, "+&				 
//				 " periodo_ingreso= periodo.descripcion, "+&				 
//				 " anio_ingreso= academicos.anio_ing "+&
//             " FROM academicos,"+&   
//         	 " alumnos,"+&
//	          " domicilio,"+&
//	          " carreras,"+&
//	          " periodo"
////				 " periodo_ingreso= CASE academicos.periodo_ing WHEN 0 THEN 'PRIMAVERA' "+&
////				 " WHEN 1 THEN 'VERANO' " +&
////				 " WHEN 2 THEN 'OTOÑO' END, " +&
//
//	 Nuevo_Select_2=" DataWindow.Table.Select=' SELECT"+&
//                " academicos.cve_carrera," +&
//                " carreras.carrera"+&
//                " FROM academicos,"+&
//                " carreras"
//
//				
//
//    Nuevo_Select = Nuevo_Select + " "+Nuevo_SQL + " ' "
//	 Nuevo_Select_2 = Nuevo_Select_2 + " "+Nuevo_SQL_2 + " ' "
//
//   // Se obtienen las opciones de ocultamiento
//	this. EVENT opc_mostrar(prom_on,cred_on,dir_on)
//   
//	// Se Modifica el SQL para X
//	rc=dw_2x.Modify(Nuevo_Select)
//	if rc="" then
//		// Se realiza el retrieve  con el nuevo SQL para X
//		dw_2x.retrieve(agrupa,Plan,Carreras,prom_on,cred_on,dir_on)
//		
//	
//	else
//		messagebox("Error en el SQL X",rc)
//	end if
//	
//	
//	rc=dw_2y.Modify(Nuevo_Select_2)
//	if rc="" then
//    		// Se realiza el retrieve  con el nuevo SQL para Z
//			ls_pbselect = dw_2y.Describe("PBSELECT")
//			dw_2y.retrieve(Plan,Carreras)
//		else
//			messagebox("Error en el SQL Y",rc)
//		end if
//	
//// Se Ordenan deacuerdo a los criterios establecidos
//   cb_5x.triggerevent("clicked") 
//end if
//
//
end event

event constructor;TabOrder = 4
end event

event type string construye_sql(integer alumno_x, integer plan_x, integer nivel_x, integer carreras_x);// Se construye en nuevo SQL
string New_SQL_P

New_SQL_P=""

if (alumno_x = 2 or alumno_x = 1 )then
    New_SQL_P =	 ", banderas_inscrito "
end if

// Encabezado por DEFAULT
New_SQL_P=New_SQL_P+" WHERE ( academicos.cuenta = alumnos.cuenta ) and "+&  
          "( academicos.cuenta = domicilio.cuenta ) and  "+&
          "( academicos.cve_carrera = carreras.cve_carrera ) and"+&
          "( academicos.periodo_ing = periodo.periodo ) "  

//Solo los usuarios especiales pueden ver a todos los alumnos
if NOT ib_usuario_especial then

	New_SQL_P= New_SQL_P + " AND academicos.cuenta NOT in (select cuenta from alumnos_restringidos where restringido IN (1)) "
			
end if


// Se Escoge que tipo de Alumno se desea
CHOOSE CASE alumno_x
	CASE 1
		//Solo Primer Ingreso
		New_SQL_P= New_SQL_P + " AND (academicos.sem_cursados = 0) AND ( academicos.cuenta = banderas_inscrito.cuenta ) "
	CASE 2
		//Inscritos Nada Mas
		New_SQL_P= New_SQL_P + " AND ( academicos.cuenta = banderas_inscrito.cuenta ) "
	CASE 3
		// Nada (Todos)
END CHOOSE

// Se define todos los planes o algunos
IF plan_x <> 1 THEN
	// Se pasan los planes en un arreglo
		New_SQL_P= New_SQL_P + " AND ( academicos.cve_plan in ( :plan ) ) "
ELSE
	// Nada (Todos)
END IF

// Se define si son todas las carreras o algunas
IF carreras_x = 1 THEN
	// Todas las Carreras
	CHOOSE CASE nivel_x
		CASE 1
			// De Licenciatura EXCLUSIVAMENTE
			New_SQL_P= New_SQL_P + " AND ( carreras.nivel = ~"L~" ) "
		CASE 2
			// De Posgrado EXCLUSIVAMENTE
			New_SQL_P= New_SQL_P + " AND ( carreras.nivel = ~"P~" ) "
		CASE 3
			// Nada (Todos)
	END CHOOSE

ELSE
	 // Se pasan las carreras en un arreglo
  		New_SQL_P= New_SQL_P + " AND ( academicos.cve_carrera in ( :carrera ) )   "
END IF

return New_SQL_P
end event

event type string verifica_criterio();// Se definen los parametros de Busqueda
string New_SQL
int alumno_x,plan_x,nivel_x,carreras_x

//// Para Alumno
//if rb_1.checked = TRUE then
//   alumno_x = 1 // Solo Primer Ingreso
//end if 

//if rb_2.checked = TRUE then
//   alumno_x = 2 // Solo los Inscritos
//end if
//
//if rb_3.checked = TRUE then
//   alumno_x = 3 // Todos
//end if
//
//// Para Plan
//if cbx_todosplanes.checked = TRUE then
//	plan_x = 1 // Todos los Planes
//end if

int li_seleccion, li_cve_carreras[], li_total_carreras, li_i
//li_seleccion = lb_carreras_por_coordinacion.ObtenCarreras(li_cve_carreras, li_total_carreras)
choose case li_seleccion
	case 0
		carreras_x = 1
		nivel_x = 3
	case 1
		carreras_x = 1
		nivel_x = 1
	case 2
		carreras_x = 1
		nivel_x = 2
	case 3
		nivel_x = 0
		if li_total_carreras = 0 then return ""
end choose




// Se obtiene el nuevo Statement de WHERE
New_SQL = this. Event construye_sql(alumno_x,plan_x,nivel_x,carreras_x)
return New_SQL
end event

event type string construye_sql_2(integer alumno_x, integer plan_x, integer nivel_x, integer carreras_x);// Se construye en nuevo SQL
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

//Solo los usuarios especiales pueden ver a todos los alumnos
if NOT ib_usuario_especial then

	New_SQL_P= New_SQL_P + " AND academicos.cuenta NOT in (select cuenta from alumnos_restringidos where restringido IN (1)) "
			
end if


// Se define todos los planes o algunos
IF plan_x <> 1 THEN
	// Se pasan los planes en un arreglo
		New_SQL_P= New_SQL_P + " AND ( academicos.cve_plan in ( :plan ) ) "
ELSE
	// Nada (Todos)
END IF

// Se define si son todas las carreras o algunas
IF carreras_x = 1 THEN
	// Todas las Carreras
	CHOOSE CASE nivel_x
		CASE 1
			// De Licenciatura EXCLUSIVAMENTE
			New_SQL_P= New_SQL_P + " AND ( carreras.nivel = ~"L~" ) "
		CASE 2
			// De Posgrado EXCLUSIVAMENTE
			New_SQL_P= New_SQL_P + " AND ( carreras.nivel = ~"P~" ) "
		CASE 3
			// Nada (Todos)
	END CHOOSE

ELSE
	 // Se pasan las carreras en un arreglo
  		New_SQL_P= New_SQL_P + " AND ( academicos.cve_carrera in ( :carrera ) )   "
END IF

return New_SQL_P
  

end event

event type string verifica_criterio_2();//// Se definen los parametros de Busqueda
//string New_SQL
//int alumno_x,plan_x,nivel_x,carreras_x
//
//// Para Alumno
//if rb_1.checked = TRUE then
//   alumno_x = 1 // Solo Primer Ingreso
//end if 
//
//if rb_2.checked = TRUE then
//   alumno_x = 2 // Solo los Inscritos
//end if
//
//if rb_3.checked = TRUE then
//   alumno_x = 3 // Todos
//end if
//
////// Para Plan
////if cbx_todosplanes.checked = TRUE then
////	plan_x = 1 // Todos los Planes
////end if
//
//int li_seleccion, li_cve_carreras[], li_total_carreras, li_i
//li_seleccion = lb_carreras_por_coordinacion.ObtenCarreras(li_cve_carreras, li_total_carreras)
//choose case li_seleccion
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
//
//
//
//
//
//// Se obtiene el nuevo Statement de WHERE
//New_SQL = this. Event construye_sql_2(alumno_x,plan_x,nivel_x,carreras_x)
//return New_SQL
return ""
end event

event opc_mostrar(ref integer prom_on, ref integer cred_on, ref integer dir_on);// Se verifican las opciones de ocultamiento de campos

//IF (cbx_10.checked = TRUE) THEN
//	// Visualizar Promedio
//	prom_on=1  // SI
//ELSE
//	prom_on=0  // NO
//END IF

//IF (cbx_11.checked = TRUE) THEN
//	// Visualizar Num. de Cred.
//	cred_on=1  // SI
//ELSE
//	cred_on=0  // NO
//END IF

//IF (cbx_12.checked = TRUE) THEN
//	// Visualizar Domicilio
//	dir_on=1  // SI
//ELSE
//	dir_on=0  // NO
//END IF
//
end event

type st_1 from statictext within tabpage_general
event constructor pbm_constructor
integer x = 3045
integer y = 88
integer width = 631
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

type rb_todos from radiobutton within tabpage_general
integer x = 562
integer y = 236
integer width = 247
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

type rb_1ing from radiobutton within tabpage_general
integer x = 562
integer y = 140
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
integer x = 3045
integer y = 368
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
integer x = 59
integer y = 376
integer width = 439
integer height = 240
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

type gb_4 from groupbox within tabpage_general
integer x = 526
integer y = 60
integer width = 526
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

type gb_6 from groupbox within tabpage_general
integer x = 1115
integer y = 60
integer width = 576
integer height = 432
integer taborder = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Nivel"
borderstyle borderstyle = styleraised!
end type

type gb_9 from groupbox within tabpage_general
integer x = 1778
integer y = 56
integer width = 1202
integer height = 444
integer taborder = 82
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Bloqueos y Avisos"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within tabpage_general
integer x = 5
integer width = 3685
integer height = 684
integer taborder = 13
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Criterios de Busqueda"
end type

type gb_carreras from groupbox within w_directorio_bloqueos
integer x = 1134
integer y = 276
integer width = 1294
integer height = 224
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Carreras"
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_directorio_bloqueos
integer x = 1134
integer y = 276
integer width = 1294
integer height = 224
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Carreras"
borderstyle borderstyle = styleraised!
end type

type gb_5 from groupbox within w_directorio_bloqueos
integer x = 1134
integer y = 276
integer width = 1294
integer height = 224
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Carreras"
borderstyle borderstyle = styleraised!
end type

type gb_7 from groupbox within w_directorio_bloqueos
integer x = 1051
integer y = 60
integer width = 709
integer height = 292
integer taborder = 15
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Plan "
borderstyle borderstyle = styleraised!
end type

